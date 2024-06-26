Return-Path: <netdev+bounces-106778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9964E9179A3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54522284344
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17811598E3;
	Wed, 26 Jun 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s5wWZeaA"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E8158A31;
	Wed, 26 Jun 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386790; cv=none; b=f1aWKOhCK6yP9ZNqIwPZ87+Ec5psGMQUKUBMDqDzC7pRhCobuPtcpwTCWYrqSW0ZV2aKVbN3aZIzjr1tx1lu7GAiQ3N48dQXaZ3WozLXObIfKwMSUx1MfRjnUU2gLhJhRJL54yY7vUUVXF4+nKKQqZyA3dMtkAUlBv1WXZWVadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386790; c=relaxed/simple;
	bh=NInRap8rjOYZsSP+/1FpBnfCmt7RlHkTh0A/Xt+55PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHVS9yRtjrCTG/snkZadhh7L99wDWX7cXJDqsMKm2aaoV+3CZhAoXwf1d55hzuINpiHoI+MyUfnVoONbLDn3ZvMNb9TwVVuH8hXmL9Q80tT6IXnhKS6gJGQ+Fg4NejkCZJY1teH+4DhoUKEDEjx2HsMKAICjJ+cELpH3OhRkbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s5wWZeaA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 204CD11403B6;
	Wed, 26 Jun 2024 03:26:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 26 Jun 2024 03:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719386788; x=1719473188; bh=VE9YtLMEWcvMxts0V08/6rrHfcM3
	u6lcRlaMcClxEt0=; b=s5wWZeaAWjTgio4dHKbHieh4PPWvyFPp4UzoFX/aLTrp
	TTO8P+7Gh82FlBG/MPg3KjOjtuWpUjOgt35BR0xKNRSp2Q1SJRhRu7tgXWRbfQAs
	EVfVGp206DZGdLx6fHy/lqT+9mvWk8d6yIzeP2pooNO2G1BNu/gLY/MR+s3vUtGX
	UgGW8rjqfwVhClI36h4pd5YQxtcPuv76JFvcRMqt44Y5gAgxuxFTQEHYWs/zKQJU
	Ne68o39wOIxL0wRpgdsHcotjG4lz+eCETz1hfJp+hQXKuZnUjVO2FocUfz2UB7GJ
	sd7ai7TW4d2zaekG6tisHAMMTz16MrWd5G2x6GQu/g==
X-ME-Sender: <xms:o8J7ZsHgWTNjkTTJH0IsB0EawYjIn2mwYxxublK9gr1BRlO8dYGnag>
    <xme:o8J7ZlU0FHUA4h97nFGnJP_h9jgeJILUYwyi54DuJZ1bDwfPLesQ8QicSQ9fUPoSu
    J5YtpFdRFvWzUg>
X-ME-Received: <xmr:o8J7ZmL-WuxllxyHGY_X9GyNqH9x5LR6xeF6dal96s8hOz-xQHIoSwGugfmK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:o8J7ZuHHhSbfJ2ibtFehASp1Y1cSeAKdMB5vxxBwR7fHuJRknVE7GQ>
    <xmx:o8J7ZiUFOjYgO2LXMQYXexIsN61V_Yg1RQ278zwTX103k5DfhkQSEA>
    <xmx:o8J7ZhMLVoy4yxCyap_suzaXI7DYxIGAc5oS_6U8TH4TuzxAW-ROCA>
    <xmx:o8J7Zp1atzBs-sdhcFSsjzNAzU7OggkAoO6rCMNMKE4CaIqABetKnw>
    <xmx:pMJ7Zjs8E2PnFXHlKV0qlg4awof2irPW9PYEzd0W5lVODc0Cprj0El6T>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jun 2024 03:26:27 -0400 (EDT)
Date: Wed, 26 Jun 2024 10:26:21 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/10] net: psample: allow using rate as
 probability
Message-ID: <ZnvClz6gXv1jR5X1@shredder.mtl.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-5-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625205204.3199050-5-amorenoz@redhat.com>

On Tue, Jun 25, 2024 at 10:51:47PM +0200, Adrian Moreno wrote:
> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> 
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
> 
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
> 
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
> 
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

