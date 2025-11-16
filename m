Return-Path: <netdev+bounces-238998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD88C61ECB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04653B52FF
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187E248880;
	Sun, 16 Nov 2025 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="c5VMf9ef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVN0jzw0"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C96246333
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763334716; cv=none; b=FecTAE0j0o73gS2Oo5lIxAayS0kVT2Ldvy3gFnkt9Ft/5MEf3a1fw5uWLjwaJf3iJDY7ozqcWn3Zr2fi9oLu7BJF5/yLldqgM8jzlm2dE2pR+t/r6Tb1W8kGLXvbZaAzDkTJSOXIzssIgRlRcxQ1zu1SM3hf8fX58ctrxQZ9K1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763334716; c=relaxed/simple;
	bh=NUc9IWAKvLaijb7DqB2/Rr43lRgMFvf2IYykMcjjoAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiMdQrehxkE6+ZmG6fqun8jMPYXhKkhrpOouGCfRpltEP/kgXpOXGmnHQGuAMf9WZietiqXGLThVaZEcWxHLb9rUTLS9C971MAA4+kc4wQakpuHa+lWSlQOShuXy40nVIYcGLf7KbQn20bnj8IZqvw6o5r0JNZ2OacRz1JanvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=c5VMf9ef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVN0jzw0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60906140007F;
	Sun, 16 Nov 2025 18:11:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 16 Nov 2025 18:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763334712; x=
	1763421112; bh=hav0ownM2U+DJzYph6m1Q5A3+3d6nEUhFuqy2/TDFbU=; b=c
	5VMf9efyzBzMmP80WJCQ6P6gbgXUqdDqI6VenGaeSsyP6MGLTCsNGd3LOnt+V8lJ
	5Ww5OdIsvzCClu46RIHJPp7DVJmWPar4Qfd3B3FO+ZP6PPJBcibyu0J2ht7GJPgb
	dnoG9QP1yYd4vhewDMiH3KiXaUuHlSH8f0hYWvjz5YJOX/RN/gWhjQ3DqhDSrTK8
	qsTfdWgVzqbTV6jSQ4WbjxCyj7s90B20J9cLHhTkDa8Ww0eK2DNCDWtAsgBg+MOC
	gt2OCOlwidqpSiQcWAsnya4r6j4vdgMZXfWtAUMTiH4LKgz13zwTSEa42ieV+MJy
	eAcHXesRBxyb0EMxkyj6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763334712; x=1763421112; bh=hav0ownM2U+DJzYph6m1Q5A3+3d6nEUhFuq
	y2/TDFbU=; b=rVN0jzw0QEOpOW+8DOWsyLWja2CWN0Hipn/4kwK8hG7vU9EZNDH
	njjTkx4lSb8MgBKspE1Rv5AXoWOFZ70YT9wB6IUqcU4PCvLZiIIwVRBihdWYN1uS
	hGp/VuEoGXetVYkVCynRIfMt+SrKJA/Cox1xR+3pTV0Abzgaj9I7BLVxZY53pzMj
	VK2xAPm0hGfMZtZyKVWXR5iVCl0lBdhSeAPkRtXIVQDpel7G6u1JgFOpWqozwtMW
	n7pz9wyRb+cBfzaDS4HCq7B60tLRhfronbzq/H659eYX+L3/QxPrcTpwIcg0oTUg
	4cEDXJbvG5aIvcLp5c/5/jrfjQBfOSZS5AQ==
X-ME-Sender: <xms:N1oaachrMMTv0pO8w8ar8fj2pBnQkwIZTK6iSfrtE0fQJqd-XP9NRw>
    <xme:N1oaaQ5nuMxXIplQfC12Ksn7rZDYxpeuMtbUCyhLC3vcstrB73dOa4ZrVLbuqsbz3
    aUp68QWqKIVqck0-KPQYx1briqgg48y01n8TJ7YSzrOjDdBq4EwE0_Z>
X-ME-Received: <xmr:N1oaaRGQzcsX8vE-qrkRcCImbei8J_VnndTqCLONZxYZTfTyIjArTNRQUAkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeikeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:N1oaaSII08BMkvbc8sqaDgJ8c-fcg4LRVFsmjicy9bb237eS9RNuPg>
    <xmx:N1oaaeg70namKDegE_xvYu5_HDeQ5PMdB6tnEFDHoXVwc7m4V0ia3g>
    <xmx:N1oaaQkv5BUAJlyWHoD7Io0ya2GW_nh_h5xXtn1PXVcoWwaPlYnJ7g>
    <xmx:N1oaaVWzQMUW9PJRtmEnRz-j608eTwO6uFOfK-4P8s0J1frSVXkhgg>
    <xmx:OFoaaW9_HOsvL138QY8vTs9AM_C6SmGgeXwVoiTLWmGFgDwq3BKYoegm>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 18:11:50 -0500 (EST)
Date: Mon, 17 Nov 2025 00:11:48 +0100
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
Message-ID: <aRpaNMxGlyV_eAHe@krikkit>
References: <20251114035824.22293-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114035824.22293-1-jianbol@nvidia.com>

2025-11-14, 05:56:17 +0200, Jianbo Liu wrote:
> Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet
> inner protocol") attempted to fix GSO segmentation by reading the
> inner protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was
> incorrect as the XFRM_MODE_SKB_CB(skb)->protocol field is not assigned
> a value in this code path and led to selecting the wrong inner mode.

Your testing didn't catch it before the patch was submitted? :(


> The correct value is in xfrm_offload(skb)->proto, which is set from
> the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
> is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
> or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
> inner packet's address family.

What's the call sequence that leads to calling
xfrm4_tunnel_gso_segment without setting
XFRM_MODE_SKB_CB(skb)->protocol? I'm seeing

xfrm_output -> xfrm_output2 -> xfrm_output_one
 -> xfrm_outer_mode_output -> xfrm4_prepare_output
 -> xfrm_inner_extract_output -> xfrm4_extract_output

(almost same as what ends up calling xfrm[4|6]_tunnel_encap_add)
so XFRM_MODE_SKB_CB(skb)->protocol should be set?


Also, after thinking about it more, I'm not so sure that
xfrm_ip2inner_mode is wanted/needed in this context. Since we already
have the inner protocol (whether it's via xo->proto or
XFRM_MODE_SKB_CB(skb)->protocol), and all we care about is the inner
family (to get the corresponding ethertype), we can just get it
directly from the inner protocol without looking at
x->inner_mode{,_iaf}? (pretty much just the reverse of xfrm_af2proto)

-- 
Sabrina

