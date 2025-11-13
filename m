Return-Path: <netdev+bounces-238370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B9C57D34
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F91F343CDE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0997D23C8CD;
	Thu, 13 Nov 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Up4CoFQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzDJcDNi"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8320B81B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042308; cv=none; b=HuLK31xiheLmWsXbP9eAN4VacD6kBfk6U1X3/A0cfs4LBfAlEsfVk4aVUVmWe54EScSPWZEhKF39qQqbnhwHpJDnf1WBU17syZz4cZERpXcz0AEmmDQoi8DF9s3LODC7nH9cGgqd5vXS55gtGGC0kC2Hwi+b0HkxD+IfluZkBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042308; c=relaxed/simple;
	bh=pz5KYoyDMNDddbP8jlD9cjDe8VPGmJ+oWOpNdsbh1LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N353L9oWAYL+q55Rb9TXb5NRJrWLaforYuHJH4AwmXsSROQVlfE4apTBEltjKYLvXTLAWCBhcGEcvraX9gZsL5XdsuRiXo+Iq6SJ7Emhxi/vx1mawiElZufNEWem/uaitKzlo3PzU5UdCoQ5qcVIzksAQDn1sFl3HQBaUH6CbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Up4CoFQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzDJcDNi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D56051400290;
	Thu, 13 Nov 2025 08:58:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 08:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763042305; x=
	1763128705; bh=bGeBTJP2g90UEGJG0nBY039trOaI9HyJDqCuLHJnVGk=; b=U
	p4CoFQlwCe3HW2e1NzHZBMFh0eVwbIUDCo5KTsZHsnS+ZGqIXSMQlW/EQAK5IOmM
	lXp4VQsjFBGIH+18Xwaf95S2yQJEIJ5+pKv0tDDbJWd1/P1ZzmaICJVbpPMMg+Pa
	qriyRVGJbgBN5sB7qVcjP4Q6kaaBx8KuLkwkD0SWSKNwBtZ/OjRkEG5u4S7JhYZ9
	X+mTi0nHHyOa1SRhOi4z6j3fW0Sm051XbFQRs+bepaH54N3nkZE46ICzPhwUuqnY
	+FoNpKu3ZkaXQxDJ5lREprqVpIMzwFS8hNocwrvynz5fs3fiia3iIztyZA9Hfyyn
	hIK5opWv9Zo6/9vf6sL+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763042305; x=1763128705; bh=bGeBTJP2g90UEGJG0nBY039trOaI9HyJDqC
	uLHJnVGk=; b=HzDJcDNi5K0rG8/uJGO/Nbt+tuvMh9EdzP9/Gs4YJL+1RI3a6u5
	Ubp3SB050s9MgoGw+nfQqZZHiQjp9//AxC9kjJWHO+q4HHbvzQKdRc28L5h5zCYf
	e49SEvNQZorcDNW9K1MXUjJ0IchOueZiyj7Ssdsyua0Xk4KaRQWU50TLr+YiratX
	BXGfBkF6KCl+f4Lp8Gq5Xk9f7lwIF6Y66vurj8KJlIv6WAGOfF6620F2SIIpbF2f
	dr1IPQJ+/n5DZajp0mmjqxEhJbt1TgQs5krkL4+YsxD5dknXD6Ja5auU8Z6QPg1z
	fqo80aTv/r888KhHFmHme9Xx2Qp3yDhDqfA==
X-ME-Sender: <xms:AeQVaUwNPh9kAmv5fSCF-06iv157VE0MXosuBbXox9ImNVJXiYPm0Q>
    <xme:AeQVab8y3y4r3c9AoOM6vL7tvpsbby4mzkk0m1FlVfjhRj9d86RTgnbqsg8TTlJbZ
    76dR-4grznjf478LJi3XyPGbPNZy5esuC18x2lfroTPL3xiya90sOJc>
X-ME-Received: <xmr:AeQVaQKQdy9Co5Xvzq8ugL__gd6PYM_eqPh35-5FdTYtV5N2xg4XXPgUMDNz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomh
X-ME-Proxy: <xmx:AeQVaZeMDwOFiRKvTHJG8Z5cXme5V8OQepnya8eGMJyNN1yw8eoqwQ>
    <xmx:AeQVaX9VmDm10T5mB8Eqzo33v6oMBwTuJnjlTH0mbEtVHrQ5USuktw>
    <xmx:AeQVaeqf8OQudibUdgvYgacPJoQVqcx-S2iQ5tlrgj0bIDcv8kLD4w>
    <xmx:AeQVaUDJ4A_dfQ1W6rB7-cu6WXGLzWWH6WUhr9ot0sPjwVuQFNTkUw>
    <xmx:AeQVaQ7niMuQY2hze7xHx2KsF1wJpK2vnqT97HwlaX3QMEfMdibDkDH5>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 08:58:24 -0500 (EST)
Date: Thu, 13 Nov 2025 14:58:23 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 5/8] ovpn: add support for asymmetric peer IDs
Message-ID: <aRXj_--Rbimt-5yL@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111214744.12479-6-antonio@openvpn.net>

2025-11-11, 22:47:38 +0100, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> In order to support the multipeer architecture, upon connection setup
> each side of a tunnel advertises a unique ID that the other side must
> include in packets sent to them. Therefore when transmitting a packet, a
> peer inserts the recipient's advertised ID for that specific tunnel into
> the peer ID field. When receiving a packet, a peer expects to find its
> own unique receive ID for that specific tunnel in the peer ID field.
> 
> Add support for the TX peer ID and embed it into transmitting packets.
> If no TX peer ID is specified, fallback to using the same peer ID both
> for RX and TX in order to be compatible with the non-multipeer compliant
> peers.
> 
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  Documentation/netlink/specs/ovpn.yaml | 17 ++++++++++++++++-
>  drivers/net/ovpn/crypto_aead.c        |  2 +-
>  drivers/net/ovpn/netlink-gen.c        | 13 ++++++++++---
>  drivers/net/ovpn/netlink-gen.h        |  6 +++---
>  drivers/net/ovpn/netlink.c            | 14 ++++++++++++--
>  drivers/net/ovpn/peer.c               |  4 ++++
>  drivers/net/ovpn/peer.h               |  4 +++-
>  include/uapi/linux/ovpn.h             |  1 +
>  8 files changed, 50 insertions(+), 11 deletions(-)

The patch looks ok, but shouldn't there be a selftest for this
feature, and a few others in this series (bound device/address, maybe
the RPF patch as well)?

-- 
Sabrina

