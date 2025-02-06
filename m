Return-Path: <netdev+bounces-163602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5309FA2AE3C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F43616AD86
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376F23537E;
	Thu,  6 Feb 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xxeNnXwP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE651A3176
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860885; cv=none; b=IpGn/FHmAiQtz8a8TydBld165CO5ynOS+aGMpuaMQ2+lfEzHMC92SEoiBrv33C5+NN2BjMuewdYzNVXMeiE1E6rZwFjPMf2hRKzVvV2mJADZ1pBMpO1YGM7Uqulm+Rj0h6vlQUbDsaUwiPcn9uphqEYWvoaXVPARtoK9ieyxg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860885; c=relaxed/simple;
	bh=+j4le5j8NzB9bpgaitvjI/p/ZqXk5rE9cn6ChkT0Q0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXtzF1CDlqfBBjdztX+iQxt/4CumuUG8uvU0A0/cc5anCTtHKlHd8h409pYDBWTQaM7GzR3PoA2q6WVXyLbkcJUBaSO9/nHA22oyqoUpjoimvqAsFa3BR8PBLLKO1HyUJh+XoiHHKXpHfN0FlJIDZIq8x4K+3gIB1y2FuKcdIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xxeNnXwP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D8401140204;
	Thu,  6 Feb 2025 11:54:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 11:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738860882; x=1738947282; bh=M62mOkKiTSaXLkFdxB2DF+HHwcMeUYCpDvY
	rPD54O+8=; b=xxeNnXwPYziFL+1Lda5FQAUV36lPpK/mNtOMij/CqVeJ1O9ppOZ
	9j+GvSvSSg3xgO/caQvyUxkzNE7P8olpX2Gz2oHpMdGpb/3lpMiatROLNoG1Yi82
	uLnKVvs80PIpuZlYYmsKWlHqENG8udkssDQV8Wb4hwvfiEIV2IaYInZyMA5i8oo3
	YBv2sG6qJAmU1VgD2M52wMP4d74KaAj2573SRlPf2XpA7utwJjrZeBpIxs60A+ur
	MqWpq6wv8eC3i09GHILyItrGAl9R4loPzYQQMfmyW/0j67KvttFmH/4OjoOynWm/
	NWAEYWiD6Z6TwUC2LXFk0hufHgsuzXHv11A==
X-ME-Sender: <xms:UemkZ4f9sRDkElIBQ2OA9AtqllbWtZBjGmtkVKiqHNcn7n8wMz_sRg>
    <xme:UemkZ6NY-hdCRFbHXgE5o4EX_byPcoy92L5uLY_iM_gABO9BWqGxK4Pn6vqt9kEkx
    Xyq2wmpjWcg6rM>
X-ME-Received: <xmr:UemkZ5iH3ihXlLVfH-lwv6CVWbGmIiUneHVm_ZBVf2KRWS0E6RFbxaZe1uXMhESIBQl11iPsoj8eDMh6h6ThgrSKPz-hMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiinhhstghntghhvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:UemkZ9-3lWkpbewUELMJXx4Z--pl2X7k1CscEv2dYfsvHQWOc3f_sw>
    <xmx:UemkZ0toyZew9ItdUlQSzzDMueu4jKsLluYyyWRGwjEXrwEVOijBhw>
    <xmx:UemkZ0Fmf0QVPUhH7zcYUPoERS0RRBbflgNNYrH6mIMxTio6GWpUuw>
    <xmx:UemkZzOBprQ7oTOTSMiglh2pPT8sA3NJIK_6l-7tBO9RaD9azsVswA>
    <xmx:UumkZ59Rh0dokF7HMiWOp6PXHVSDB2l2j5ALOnoRdZjU4-CXKBIbGXlP>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 11:54:40 -0500 (EST)
Date: Thu, 6 Feb 2025 18:54:37 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v2] vxlan: Remove unnecessary comments for
 vxlan_rcv() and vxlan_err_lookup()
Message-ID: <Z6TpTbS2VZUsqbav@shredder>
References: <20250206140002.116178-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206140002.116178-1-znscnchen@gmail.com>

On Thu, Feb 06, 2025 at 10:00:02PM +0800, Ted Chen wrote:
> Remove the two unnecessary comments around vxlan_rcv() and
> vxlan_err_lookup(), which indicate that the callers are from
> net/ipv{4,6}/udp.c. These callers are trivial to find. Additionally, the
> comment for vxlan_rcv() missed that the caller could also be from
> net/ipv6/udp.c.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ted Chen <znscnchen@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

