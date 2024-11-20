Return-Path: <netdev+bounces-146393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35FC9D343A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305C9B22F67
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA2158D6A;
	Wed, 20 Nov 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYogboIG"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100815B0E2
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088411; cv=none; b=CJhbb9Eg19QoDlbV3+7ORQFdBvQ7cAf3j45736rcb46KGt1eNDPhTbVyR4KdtM3RNI/Vx5DIF7ZIHDByIUxbro5d8BgcH/vvjVDZOjzJUcnJ/3Kz8G7AOimZ61Xlb+j8imAJTSjtTAV0Ov8KE5NNtcxybtyp2QeH4gyyj2UAHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088411; c=relaxed/simple;
	bh=5NBpiOdcl0cunyRLhCfjjuhNqW0BeuIw0Rwggbxtnhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXS3F7QENP/0zEa0xWYbH1qWJJBbV8I3hVBY5Pnan8dRyAbcQH8tcgOFg6Lbp3Z/g5IOjxI9KWPp5ExRDWbVTacDVMEPhwkXSHb6x+KgtgGYNN6vhhw4L3VeZ1mJ4F0ZLVRLzMQ91AtCn0MTeBbJ6iQ3OXf0YzAoVwG55OWihxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYogboIG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CB1D2540213;
	Wed, 20 Nov 2024 02:40:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 20 Nov 2024 02:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732088409; x=1732174809; bh=mRwlURH/zqPPvYHN+vyfwHNmXoIV6iH4CCu
	WJgZIEfU=; b=JYogboIGJWHm6KDaO6vAbbrbKsoOT2UxZCCTbM3jLnmiNMo9Qpf
	PFQ1v3pKluvokEJZtKG/hEbVoKcgaJHYz5bW5do/4T6RSul4ALjLkQJuL7wfl6qb
	WiJQZ3Rsi+5gY/v1lME5TA8vMcsstlWUX8oL2FpfYdsfh4jtBACHMe5kG0+R+tP/
	82Nti7GhuYlMMyY+ZEtUS1LSVLHN/l6HwdjNuy/HQAkp5jB7pAPnr6hT5awztVmU
	Gt8IkyIFIzIG10Yn5UrZgoTahktiPEjScdtUtMHJbcthJaQZypBMZNG+hdsbOjIL
	mksd1XWM7IfaXZ3PBXquz7i2pvtYWNRoMrw==
X-ME-Sender: <xms:WJI9Z1vOYFPSIa5nz390Q0HeVIO79ajSXh81RRYGz0dP1W8DbLM_-g>
    <xme:WJI9Z-e6d-fdPxZWNuGt_cAj5KAUDdKwA4intSmoJDT29X3M9eSremmrp2WxVRpTa
    mrjOMLwRNxUvbg>
X-ME-Received: <xmr:WJI9Z4x2OraafhIo4gtqMsoWHQot0YNDkojJjMzAt2P6zEfAp7ey-bwn_oyP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfdu
    ffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhes
    ihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    rhgvvggrrhgssegtrghnuggvlhgrthgvtghhrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WJI9Z8OtWRPwJ5zNb-SehpMtH7NxySbbqOzkdDn3ms_Sx9XWHOpe9w>
    <xmx:WJI9Z1_yU1Vl89T9vAvDNZqbiJNcggrPult4GLd_JlSZFH-OLsZLQw>
    <xmx:WJI9Z8Uo-hJJsJpriwnsfVfaNQAPIkHbh9YlAIO_MakkFiPGzaSiZw>
    <xmx:WJI9Z2frXbMVf_2l9iF4UAVK6Qp228yQ0HXaqzs7rFDzMm-7fe5vng>
    <xmx:WZI9Z3JM4ehxTgv8IpnNqmgD4BuSE0vZF9SJhaxVP7Yh-HzI21SKFR7M>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:40:08 -0500 (EST)
Date: Wed, 20 Nov 2024 09:40:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>
Subject: Re: GRE tunnels bound to VRF
Message-ID: <Zz2SVFfcLnL1Hw56@shredder>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
 <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
 <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
 <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>

On Tue, Nov 19, 2024 at 09:36:13AM -0700, David Ahern wrote:
> On 11/19/24 7:59 AM, Ben Greear wrote:
> > 
> > Ok, I am happy to report that GRE with lower-dev bound to one VRF and
> > greX in a different
> > VRF works fine.
> > 
> 
> mind sending a selftest that also documents this use case?

We already have that. See:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fed926d4f64ca1ba23c496747fc4209244c13d80

