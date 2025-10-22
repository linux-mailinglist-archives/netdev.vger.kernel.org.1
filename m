Return-Path: <netdev+bounces-231676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BDBFC693
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28FE634CEE8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3732AAA8;
	Wed, 22 Oct 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="e5oomHdW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgPvpIVk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5C32B9A0
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142368; cv=none; b=YCR1RDWjlnoXjsq7WuuHPFaDnadSR7ZZhm6r25N+ouwD6knCz9dzEWeqM436RzbrYgB4w88iqBw2JAT5eM63LvNgJ7WqCXMP998ind4kHdtNVw9iE7+TyoHr5BXCHBOi9EIvvtc7SreB7F/97d6LH9MvwrrlQjEfW+43qyOv2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142368; c=relaxed/simple;
	bh=B+fErxkRo3JCMh2kLynSEuc5hejbCHdtBnm4mjuO3QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QevG7ElAHhIXEH8pDSNpyxNTUbbAkJ4ycI7CCKEeyOsRLtQnRtzg2ukHrsmczZ0lVQBS9dI16X45kA52INkIm9otO3HdWpVbnjwQdhMnQTVBoLlyBjqb0iIwojRzq3yU9oPhbb8OwfK07Zyj/az623oDzm/Z7nMFdQJu66NY6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=e5oomHdW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgPvpIVk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0814140012D;
	Wed, 22 Oct 2025 10:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761142364; x=
	1761228764; bh=V3rET48pGHPs7ubCu3QKu6Zo/l+qfAAOqFy1bFXH9Oc=; b=e
	5oomHdWtjtSYfc8R7o1mUJ4PlRE5XnYeV8ll+eqjbDRM+teV6nTlbHccCzZ1VvsL
	xiourP5GbiFsCH/mCGdpFYqhBS0QNZIRdAMn4cMqfEg1zetp71RUs4C8sUN2k3+s
	IKKs0c/81cPprXAyhjg0B/Hqe3vLr3M0ey6VxEeq6ZSTvJL2g3SLyF9wPaiFXb4I
	zEuzliebBpW5ceO5MqmlVJaCsbVPEUW5ve8QwUwY6poaugrjGMcZCi//8hRqqTvb
	dtRnmlT1u9DUcA7gZAHSDrDtaD/7cpUDVm7fz390kXHBroT0VOXOs9zL4mCQy5aO
	U+dKWX/Y9R4fPGcu2B17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761142364; x=1761228764; bh=V3rET48pGHPs7ubCu3QKu6Zo/l+qfAAOqFy
	1bFXH9Oc=; b=RgPvpIVkRJ3517W7iTjZIsD4R+0LSOl1X+b2GOQAgBk8yxltteQ
	8ivG1ksraF5MvVJqbwUVj+wBZCXnJjX2X2p1mN+cqZZYq7P/bgKhOUg5n/jc2gxW
	hFRSS9xmTjjOFx0WEks4d1uyoaR6/iRgMBJNoWVnyCXAlpnUknPlraIyqf1OJoaM
	/MWnXA+8RYsTkWizkFlaojkN5xHG0yEVTRmvvfSHp/qSkG+uSQjRKNYasSxQYC/3
	T8BnwZZeSnkx+qGJZe2nNs4hSmlMTdvC9G7FkhDKdSA6CSN1eggcyK/DPY9N2I5R
	kBZEAjdAdgeYk2D9QPj9M60qiag6iup1p3Q==
X-ME-Sender: <xms:XOb4aDPX8whQrl7CXLxGm2AFHMEXM1KMIv1XbnuAp-21Q0EWGoRxlA>
    <xme:XOb4aKhZ-vcLBUsGmo8Mk4-TCOJ7zCsgk_QJMzMtaiFPPJoNu3MxCrGaNZoqN_pIn
    LhmhxMuWiJb3VlLTjcZf2CIIbl6Mz4ktsNBUwDNCwRZBh82k8u-47dq>
X-ME-Received: <xmr:XOb4aGtVq0zipHjrFd6g4M7XRjdSZJNgvK3c8v1hAWIQqwwPiFekjjPfUFvF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlmhgrshhrhihmihhn
    rgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehgohhoghhlvg
    drtghomh
X-ME-Proxy: <xmx:XOb4aOiBykzAYLhGCCLIYVkwCQQMhHpltUrAwWwJIbeRkfscbv2yww>
    <xmx:XOb4aMaX7fADKg2HvftlgRWaNWfO9-87pyVO6KuRDo0flXSJQUGLsA>
    <xmx:XOb4aNb6D4OGLeL5DkD2P8gxCXjm5sr97P0OE2XhEhJJpE1ng00rjA>
    <xmx:XOb4aBx6Mo7L6R3vp3Dvmlukf_p9VnnbzgmDMqnbTPRxd72AlUwvJQ>
    <xmx:XOb4aBuwEEApzQb1OsREtpETX8-XUfs7Wkgg9YE_OuPuff-r7y0sYbIY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:12:43 -0400 (EDT)
Date: Wed, 22 Oct 2025 16:12:41 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net v3 1/3] net: datagram: introduce datagram_poll_queue
 for custom receive queues
Message-ID: <aPjmWUAuG-mMJGZm@krikkit>
References: <20251021100942.195010-1-ralf@mandelbit.com>
 <20251021100942.195010-2-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021100942.195010-2-ralf@mandelbit.com>

2025-10-21, 12:09:40 +0200, Ralf Lici wrote:
> Some protocols using TCP encapsulation (e.g., espintcp, openvpn) deliver
> userspace-bound packets through a custom skb queue rather than the
> standard sk_receive_queue.
> 
> Introduce datagram_poll_queue that accepts an explicit receive queue,
> and convert datagram_poll into a wrapper around datagram_poll_queue.
> This allows protocols with custom skb queues to reuse the core polling
> logic without relying on sk_receive_queue.
> 
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Antonio Quartulli <antonio@openvpn.net>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
>  include/linux/skbuff.h |  3 +++
>  net/core/datagram.c    | 44 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 37 insertions(+), 10 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

