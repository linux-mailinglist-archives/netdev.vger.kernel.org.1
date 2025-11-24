Return-Path: <netdev+bounces-241156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FCC80A1F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28084E223B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54962FD1B6;
	Mon, 24 Nov 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fin26cxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pIa8HBWS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8026FD97
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989298; cv=none; b=sE/NCRbDtH6QAtvOo0fICT42BXDKGlsscSXEBHO4EOvXhlEjJzzKzuofcJeZATDJM3i7BfE9HUPLhocWo/i6zGF9UXy0yVnEA6gfZV/lUjcXYz0VnDXcRrGxS+jPgmG6t1AC5n7OFtWF9BuCFH/ypAFez7oh+Nh3dM6FLJJn8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989298; c=relaxed/simple;
	bh=jsu7s+T2hdTTkKBqqMPLD/M7523mqaUhylW8ZPWXwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1qf/MhG39kkEB0bulECfz9h51GZroxyIiKv9oPDDjyqmszBR1CaYoHSHct/x4yKRgFLJdYVumCguZhpzSNqP8z7Myewm/2163plXgtZhde7KWuiSi8aXChWjEE4Jww/7tkJrJGNKqX4L5LNlZSTTDe6dv1EOjDfeD4SAklyGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fin26cxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pIa8HBWS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5465D7A00E2;
	Mon, 24 Nov 2025 08:01:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 24 Nov 2025 08:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763989294; x=
	1764075694; bh=sZ2wW7m63ycOgq95DSiJKdYFGA6MDBaQH243p9HHFw0=; b=f
	in26cxWrezenuGiEcaXG9hDBPZKis4tQsaXr/F2By/wXd08A41vAhD9WxolAt6EL
	wRfxws99ro3VtbPIwW1/3Vrj2EB0a4rCS6LQLgUNvpIIsn2Gedmco45Oo8FJOmmR
	rQaNlzv0+Ab4FTSlF2D4MVCHgxGgVWMFhQMGDaPNTl9GnRkyUsAWhtUZxUnRqYAK
	3qY1XYsHGqGzySrTTvDV/gBkn8p7voCLevWwePGSvJRzbvS3EdQ00hCLBLMcng9P
	0l7kQJ4dJyani696GQF80lq6PIUSr92/nMy0RkANQDQYH5Ge2grdN9yK4rLYIrOX
	szvtKmufK6emOL3K92pNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763989294; x=1764075694; bh=sZ2wW7m63ycOgq95DSiJKdYFGA6MDBaQH24
	3p9HHFw0=; b=pIa8HBWSxHe7jX2xTGumNCiPouZcXttCMLybtRZUt5UgY7iO4z9
	GuvbUAAa1Cbr8VxlFmsRgyqkQ1QxUdeVupUfGZuGdzo6iDOc2aZCeXS7lElNGDIY
	LMPWUKHxoKv/p6V3+wXSrdNq2m27AyUC0RNdb9sXx2sNsEckxKkqhJqh1/YM2aWc
	nbPqVUVQ4o0Gwpgh+J/2H7YY/fsx5kAkzPDZL4ZtjsW//Zi22pS/nODguVPPIXzW
	hQr4qlDpElOJfcN6OYmg5cL8GT4KMxVk6zW3yoSts29lIfWzdiPLuszMHnh+77V3
	8wme1as8Kdbp6Bdr7i21iJ/UzL7xeZKz7sw==
X-ME-Sender: <xms:LFckaf1qhOHbcIiuA8FMDRRvnIIWO2RbPPV3MjOBFf0Qiqs01O5qBg>
    <xme:LFckaZ-uofscD1cSXcSWBwgVAI7pgEry_MRl0c3rz0p7Vo6_zENMIyROZKxJ3NAB3
    NJPDxiNVDK-1bsUayR6MOQJfRidFGVurHZ_lIGG1at9eK-O8ZDWuIoJ>
X-ME-Received: <xmr:LFckac5OGROds4sVEYPLLlCY75Fh2M6yTPupmfgWhGVq-1etPtwS2vqCH37g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirghnsgholhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrd
    grphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:LFckaZsMreWNVZYC6IrPJvWsHE8ZeQd_no0qfvAYoNlyt8y5tCocMA>
    <xmx:LFckaW3ZNhXngv7M-kR1pg_acyvjNBHjpI7ZsvKn0uvYZtRT5bfk4A>
    <xmx:LFckaaq-3HiT_gI9ya48qP6wYaqenPMKDJSgSS4R9ZWuhONTjHLTrg>
    <xmx:LFckaeKAjEBR8-piM21FyPYL4FRNTT75ZkJGYfVVandcb1tkGff2gQ>
    <xmx:LlckaRjE-RoqNeCorUSVJBU5xjcZwrUD-HY_k7P2mLfzXrzU9S2h1HB5>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 08:01:32 -0500 (EST)
Date: Mon, 24 Nov 2025 14:01:30 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH ipsec v2] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
Message-ID: <aSRXKqA3M_pE9wfq@krikkit>
References: <20251120035856.12337-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120035856.12337-1-jianbol@nvidia.com>

2025-11-20, 05:56:09 +0200, Jianbo Liu wrote:
> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner
> protocol") attempted to fix GSO segmentation by reading the inner
> protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was incorrect
> because the field holds the inner L4 protocol (TCP/UDP) instead of the
> required tunnel protocol. Also, the memory location (shared by
> XFRM_SKB_CB(skb) which could be overwritten by xfrm_replay_overflow())
> is prone to corruption. This combination caused the kernel to select
> the wrong inner mode and get the wrong address family.
> 
> The correct value is in xfrm_offload(skb)->proto, which is set from
> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
> inner packet's address family.
> 
> Fixes: 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner protocol")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> ---
> V2:
>  - Update commit message.

Thanks Jianbo.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

