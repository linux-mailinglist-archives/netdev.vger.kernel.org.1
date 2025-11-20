Return-Path: <netdev+bounces-240363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175EC73CAA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8B564E8D53
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189CD302150;
	Thu, 20 Nov 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="xVW8G8M9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uNTOc6Ww"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AC32D455
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638877; cv=none; b=CZ+s6jIJAZqVrgcjtOeAdzFUeTAcrRYtC3t85EVyonqhIHkHx+zQ0knmCZrPcH0lTHcT6G2HXZvbZMHOPF8arNM36BUk13GmIDrK/avLmBJJosrBWMJmi3uiJy+XxdAdNsKGjwpRpZc6DN135uR72iY/wGP+4RYrSxTrzubkOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638877; c=relaxed/simple;
	bh=QRiWu8IMKuFEZ0Zb1YqIko45RVAugpaDPrxC8+KbOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX/psK9hpaS7HZJiCXzDM5agj9XMxtCFotSij9FEe/ESkgSUaDuTJUG+4TwQ6yP7Mko6Nlxf25cbzxDkcJuzIkWHTFrf+55P2uY4gc59SiwGaZjgRDfgVtWWxfoNHiDJai7hCsyO4G7Qzn0n5QcAj9UyxTfz4VJ+mPi7ACoV8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=xVW8G8M9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uNTOc6Ww; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 26FCAEC00A1;
	Thu, 20 Nov 2025 06:41:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Nov 2025 06:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763638874; x=
	1763725274; bh=2MN86O1mfC8UsJREomoDMj1T6vuicrR1s3SYMTvRUJU=; b=x
	VW8G8M96pJMBz9sTmIl2hTMaz2B2q6iVioz5DAqH7CSJ4dT5lTd9R/VR9Yapa/1F
	zRMxr+xayfxOicnMsxqMEOuJh8GBIi3ig64x99Kj/0CwBONxl3u1FHzqmmXIgbnV
	9yVuDkfUFV+FbLKjODczRffAn1MnerVZYiFgEgcdRoQS22boQocC3uYV7zKIRLIX
	zHUBLv/bscdOTqxJO99kNJz9XXMPgNXeW7wgamBdD/vs9k+/0wLfA7hEN/ys/Lad
	QQJxUpbQIxKup/L+n6vP3ZJgsIimmotOvkGSCD1fjxwK6k0CLXdis/gmYspGcrar
	FVH4ClM6r/jqol08gU2pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763638874; x=1763725274; bh=2MN86O1mfC8UsJREomoDMj1T6vuicrR1s3S
	YMTvRUJU=; b=uNTOc6WwtQPLlpL1fCUJDkO4EsU20mb5ZfAoEgbGx16DH9VWzqZ
	KVFsvW4jdeTtSwftPxVYUZfKPOuFZaaXFIfu/RlqnVQAwAZQuUBfoHC8Vw7wVJ/i
	MSxhdoFJba9hAkm5qlMVm8MeURDVqsGwdd36irorg8iIr+4UvM9mUXSqINPOoYZi
	g9d3um3PXckH6rUuECbMO9+tLFYC8bIZGYb1ZkiWzGdCAJ58SDZGmyDRWyJ+ltZL
	zl//XUfDL7Ym/ucDFnybXyzAt7njfuU4rLCL4jyoLZepYZy1bTSeXl4cFsw2dkZi
	C2K4OLqpXDMBQk4N/YyMk1fZXGLoII0v2zQ==
X-ME-Sender: <xms:Wf4eaUmLGy9CVFKrC9yswgTkJgcEbYA6GWbVtEvohY6-8_iIQWVsHw>
    <xme:Wf4eafu2Dnp9cthUCbzow_n_aqRxaN_Ok9NM0OO8PZ5ztI6EL4lejKsXiudh1IIDe
    jjDrnh8Q8sw67uc2oeIdlW94pQR55LQF3HBcs_s-vlgJu64dxxJ1v8>
X-ME-Received: <xmr:Wf4eafqF2FnPxl5BWWl41CZ9K_RH2FzYnTqdVkTD-cEmUVUkM5myeDo6Q7Ur>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeileekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Wf4eaVcSOdVaCEcpBvRwwTgRyVL7Hgw0Jr-ifCx_e3pcIkg3V3T1SQ>
    <xmx:Wf4eaXkyTDIpbvtXvMhwVPKapzQDehNob8X4BoDj9ytbUu9nT8WPOw>
    <xmx:Wf4eacZwBIhH3Xreq8sWThPcLFcyarWv3GxhIT3GwE6e5WpRkNHL_A>
    <xmx:Wf4eac5-SNjNMzXs6CIsSFSxyvRwGi5w7KpE5DcCbFIbFEhsTNygvA>
    <xmx:Wv4eaRQnoShaC9JtpmQsgkEzEVGbYGhfmJxtOHlyK1jmR9Qa2JgazXKx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 06:41:12 -0500 (EST)
Date: Thu, 20 Nov 2025 12:41:11 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH ipsec] xfrm: Fix inner mode lookup in tunnel mode GSO
 segmentation
Message-ID: <aR7-Vx4du2M6HGl2@krikkit>
References: <20251114035824.22293-1-jianbol@nvidia.com>
 <aRpaNMxGlyV_eAHe@krikkit>
 <d18ab53f-b91b-4c64-926f-4a1466d2d31e@nvidia.com>
 <aR2_D3iEQvAklDEW@krikkit>
 <86801357-7262-40e5-b2bc-8429ac80ec7e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86801357-7262-40e5-b2bc-8429ac80ec7e@nvidia.com>

2025-11-20, 09:20:11 +0800, Jianbo Liu wrote:
> On 11/19/2025 8:58 PM, Sabrina Dubroca wrote:
> > 2025-11-17, 10:12:32 +0800, Jianbo Liu wrote:
> > > On 11/17/2025 7:11 AM, Sabrina Dubroca wrote:
> > > > 2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
> > > > > The correct value is in xfrm_offload(skb)->proto, which is set from
> > > > > the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
> > > > > is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
> > > > > or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
> > > > > inner packet's address family.
> > > > 
> > > > What's the call sequence that leads to calling
> > > > xfrm4_tunnel_gso_segment without setting
> > > > XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing
> > > > 
> > > > xfrm_output -> xfrm_output2 -> xfrm_output_one
> > > >    -> xfrm_outer_mode_output -> xfrm4_prepare_output
> > > >    -> xfrm_inner_extract_output -> xfrm4_extract_output
> > > > 
> > > > (almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
> > > > so XFRM_MODE_SKB_CB(skb)->protocol should be set?
> > > > 
> > > 
> > > I think we both made mistaken.
> > > a. XFRM_MODE_SKB_CB(skb)->protocol is assigned in that path, but it is
> > > assigned the value from ip_hdr(skb)->protocol. This means it holds the L4
> > > protocol (e.g., IPPROTO_TCP or IPPROTO_UDP). However, to correctly determine
> > > the inner mode family, we need the tunnel protocols (IPPROTO_IPIP or
> > > IPPROTO_IPV6), which xfrm_af2proto() expects.
> > 
> > (not "expects" but "returns"? or did you mean
> > s/xfrm_af2proto/xfrm_ip2inner_mode/?)
> > 
> 
> Yes, I meant xfrm_ip2inner_mode. I apologize for the confusing mix-up in
> helper function names.

No worries. Thanks for clarifying.

[...]
> > And looking for all uses of inner_mode_iaf, I'm not sure we need this
> > at all anymore. We only use inner_mode_iaf->family nowadays, and
> > ->family is always "not x->props.family" (one of AF_INET/AF_INET6), or
> > 0 with unspec selector on transport mode (makes sense, there's no
> > "inner" AF there). (but that's a separate issue)
> > 
> 
> The inner_mode_iaf is required because it holds several fields (maybe more
> if extended in the future) for the inner mode, not just the address family.

But the other fields are never used (and have the same value as those
from x->inner_mode, no need to check _iaf). Anyway, I'll propose a
cleanup later.

-- 
Sabrina

