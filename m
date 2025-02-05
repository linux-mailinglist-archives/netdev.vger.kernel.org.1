Return-Path: <netdev+bounces-163178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FAA2985C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E276188A5B4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380F21FCFEE;
	Wed,  5 Feb 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzwIwIZF"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A771FCD02
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778733; cv=none; b=El28DNReGLEUlq/cNnr00aMA8MyqmHV0NDCFzoiBy4UmOgyx7dYBAr2a0pL7CYz9Wnk9KbNWKecXgNCTsXOG6Zy5xLxpbdV3MnFGyM+R2WIUKDd5F+YH9RV77aa5dxBOo0fyuvTilmjgHt4fIdkoWeDBweHBAi0uFaCGwuFYzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778733; c=relaxed/simple;
	bh=5Bnh++hFZvS+a96/ut0mZ9P8VTCvFf6+ItJV2muE9PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWoxNP7oeWlUvkliuKgyILfwv7Wbi47AFfD1y0QZR7JBFNl3LD4eC3YOo6a5d0cyJpz76DCwTG0diszbZpFcPd0scqSkyNesd8tED115+jWh+lOkhEoeKFIv43zU8BNwV5lOvP4eLgL0Fwa22SdMHW6WUEqNjYLKU2aNrLXFRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzwIwIZF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 766ED1140157;
	Wed,  5 Feb 2025 13:05:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 13:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738778730; x=1738865130; bh=3oX3tqD4dIamxijGaswsLrvkSc427kOJseX
	F74YElF4=; b=XzwIwIZFPUXY/NZhPG02j+0aeHkderNDn2MprgSgGXCdicMZGS0
	oADhdCS3RyCw9UOsXi0uWrCp31sag24Ct88vkGV8wP3vQ/Ons6rIgLD5vJGysrXe
	Z4drb2Cl64VKF2/VeCRF53F6J0EmIVXiV69RDzgxLPI0kckfoVcxT/t1v2xIkcs3
	DID7THK6cYf7Pij9Yu6/aBWjIzIxkdxf6grRYV8nuN5q5JpVYIRWlVQQ28MzxN0+
	8pfYSD89Ejrw5IdZNQDE1FJ3VP8r/bwb/wBfRzLwm4AWcmOBqr1o0Wc/tlTapq4i
	2Z1s5Bsy2lOC3gv6FzbzUvaP5dpK+7tNVOA==
X-ME-Sender: <xms:aqijZ4Gl8EMq1VVidO_8UI2Ur9Rs0HaJusNXJqenxllurZ6rcL5LKQ>
    <xme:aqijZxV6Ctt7Xjjwm0TgMARGvSqtiF9tFSXGd0Lr-nq6k1C2_LiEp9x2h7p9MzfS_
    dd9XohmTHIVyVI>
X-ME-Received: <xmr:aqijZyIx4WWfGOp8jOMoDMYhwVRw1yMDLYdV8tC8Xm9bgCtbqeRqguzvYTds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghl
    uceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufe
    evkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiug
    hoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghn
    ughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtrghrihhqthesnhhvihguihgrrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aqijZ6HjQb8zF07mYquO2oVQIvs1C119x_n3FOtY1XgYA1FC9RAjLA>
    <xmx:aqijZ-VVQFQlhmIojna0J68nMC-ihXSNXCGUVQfjImepzqJWaRAQNQ>
    <xmx:aqijZ9PskvJlSfden6-27TAhnfWeGsPITtvtqu8Aaon9s8B_HCfDcQ>
    <xmx:aqijZ135dQinVJQmVQ8MfEpF4Fh4srDhnjWyOZWrJlyDqPxzW0Mguw>
    <xmx:aqijZyqmptuPo5XyydIdAdZxvSQ7r0zkz0cKsp4j0IPijjSVmu0baagS>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 13:05:29 -0500 (EST)
Date: Wed, 5 Feb 2025 20:05:27 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 4/4] eth: mlx4: use the page pool for Rx buffers
Message-ID: <Z6OoZwJ-REpisYb6@shredder>
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205031213.358973-5-kuba@kernel.org>

On Tue, Feb 04, 2025 at 07:12:13PM -0800, Jakub Kicinski wrote:
> @@ -283,6 +265,7 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>  	pp.netdev = priv->dev;
>  	pp.dev = &mdev->dev->persist->pdev->dev;
>  	pp.dma_dir = DMA_BIDIRECTIONAL;
> +	pp.max_len = PAGE_SIZE;

Possibly a stupid question, but can you explain this hunk given patch #1
does not set 'PP_FLAG_DMA_SYNC_DEV' ?

