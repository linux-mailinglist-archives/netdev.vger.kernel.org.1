Return-Path: <netdev+bounces-238412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2EC586CB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E134FF80
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00D359FBB;
	Thu, 13 Nov 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZWc3PTRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5Z/FoXj"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F058359712
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047109; cv=none; b=ot9cFMx7t+XYHG91ESOoX7gwoXOoTYpaHGoghn279BKzMGypDdPZkUmPIjBSrRSxSe0OSE+GVg28ZlbgQxc9Iqphb7LzEPIkRsvBbZ6DIiWDVLbTfJSt+YNEyCqVAztA8rhs5CSpNRS5R+4pukzGrS4AvG1i2DwQtb19r3JGzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047109; c=relaxed/simple;
	bh=Fk6c0X/j1wQ0v7G9KAekXwpfoCWbXeVtN8vV7mzyYaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw8BWXzX7YD/oq/3nmgiG27O9gpjIFU29dqdb/iErvpAlEHdT/PkmTAKzDBHOmXPTf870A0ajLtGa3i08H+e3RItha9yNKMfFws5+bNJ5a6fJWr6U9Vzhwmk9vkKUzlnm5+jnnBcgDXg2vwimgxdGTf4FmiGfWjATr/rtuGAcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZWc3PTRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5Z/FoXj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8030B140020C;
	Thu, 13 Nov 2025 10:18:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 13 Nov 2025 10:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763047105; x=
	1763133505; bh=Pz5KaHfv6ghlQdAJAnAh2msA3f1GXhXCsrjgDvnPv4Q=; b=Z
	Wc3PTRdsKpg0MccTGXSR1JNFdFSYMKOooSmO39XVPms5mCMYVywpEhehwPNxA8z8
	RqPXcf7EV6AzEJOCgBhCREv/xQvLx1xdRW1NIpH22sYfQBhUTMKOOTQmA+DUuo46
	98LNR1vj4JIzRxCzVyt0J8rzstaL50/MZWdXBxD3mtT9jZCKilQXbBtxr8rw4MgC
	8VVkt9C88I/f7EtXnR5bfKBqq7hfiNXDUuNQ2gV4B+y67yF+8xJWR8os2WfvrWqL
	dt6L/1ldPkltVXhOoBUhehp8ncqyR0r+6jqjddGLqzyatfguD0KfC976EjKiG0wk
	7dNYefT3NffShAMLwRBiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763047105; x=1763133505; bh=Pz5KaHfv6ghlQdAJAnAh2msA3f1GXhXCsrj
	gDvnPv4Q=; b=r5Z/FoXjBEXeeyacbcY1Hf79HHKyzdZqioYcKxoYTopcdP+oZOa
	i+7kN7bDdSZR7fYYlv6AAqfa0TUrUrlG2uQZxHKgKcs2X2ZLhZAHuo2+Ulrt2gOn
	wcxOLONx93oumU7Og6aBwQO/GYyHtgyDmYKZP/EQZ/uLSsP/508mAFfNF2kzDNL7
	Obr4zSRBGY4Ea38FYO6LDal/ciarw9n1p6c6WxySG4YlEKq30MRMxfgOOwro6e5G
	loI0etQhIH0fwYq62Jvty1xaQUfG/Vjjp2J7VHKxZsWSiRwKNjUDfK55OuLGGGyK
	tHQGhRwNBhDRCjEpmjMa8MJBayWR9eq0LHA==
X-ME-Sender: <xms:wfYVaRPp-YimHy-dru_DDlsGfcdJr_DuqvUQhc6r6RNJoIc7n9Z6sQ>
    <xme:wfYVaXqQxCjRyNmG2oulfOG--hX1Ha4oWEjNWfX-pty_mTVgZj-yZMUmoF_lLibvU
    Hme4msovTtZjMwnxwC_YQMqcozdm9zpHhzbTOgSuhc9f74hcbUs2wNi>
X-ME-Received: <xmr:wfYVaaF6ujrITSfyzOswZVPTAdeXCaKLVNeov-q_yZik7FhUL3Gjt3ANtyLd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wfYVaUpM7Bn-3ZqrvMCbyC27iZEdUThYQip-XDh8OKaB4Ly01IkXHA>
    <xmx:wfYVabbG1DzSyj3EVsayGJSQVuemQddIgCe8-jj9Ws1H99mlJfkUDA>
    <xmx:wfYVaVU-GKSq8lWHzTJmi5tXDb6P9sYuR1Oh1iVrVQhPKVq1V4-5lA>
    <xmx:wfYVac9et-DPN1BQEq5qNcLHBiuMHxQEPDnBmSu_wWHDD4oSoQuFaw>
    <xmx:wfYVaaXuwOUfUAwi_Jl_pBJMCRt-M3bY_IGWBDt-5Wyt7ZlyWgB3pcNJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 10:18:24 -0500 (EST)
Date: Thu, 13 Nov 2025 16:18:22 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 5/8] ovpn: add support for asymmetric peer IDs
Message-ID: <aRX2voeEDfs5wc0Z@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-6-antonio@openvpn.net>
 <aRXj_--Rbimt-5yL@krikkit>
 <461eef90-18b1-4ebb-b929-9f0b3e87154b@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <461eef90-18b1-4ebb-b929-9f0b3e87154b@openvpn.net>

2025-11-13, 15:12:41 +0100, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> On 13/11/2025 14:58, Sabrina Dubroca wrote:
> > 2025-11-11, 22:47:38 +0100, Antonio Quartulli wrote:
> > > From: Ralf Lici <ralf@mandelbit.com>
> > > 
> > > In order to support the multipeer architecture, upon connection setup
> > > each side of a tunnel advertises a unique ID that the other side must
> > > include in packets sent to them. Therefore when transmitting a packet, a
> > > peer inserts the recipient's advertised ID for that specific tunnel into
> > > the peer ID field. When receiving a packet, a peer expects to find its
> > > own unique receive ID for that specific tunnel in the peer ID field.
> > > 
> > > Add support for the TX peer ID and embed it into transmitting packets.
> > > If no TX peer ID is specified, fallback to using the same peer ID both
> > > for RX and TX in order to be compatible with the non-multipeer compliant
> > > peers.
> > > 
> > > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > > Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> > > ---
> > >   Documentation/netlink/specs/ovpn.yaml | 17 ++++++++++++++++-
> > >   drivers/net/ovpn/crypto_aead.c        |  2 +-
> > >   drivers/net/ovpn/netlink-gen.c        | 13 ++++++++++---
> > >   drivers/net/ovpn/netlink-gen.h        |  6 +++---
> > >   drivers/net/ovpn/netlink.c            | 14 ++++++++++++--
> > >   drivers/net/ovpn/peer.c               |  4 ++++
> > >   drivers/net/ovpn/peer.h               |  4 +++-
> > >   include/uapi/linux/ovpn.h             |  1 +
> > >   8 files changed, 50 insertions(+), 11 deletions(-)
> > 
> > The patch looks ok, but shouldn't there be a selftest for this
> > feature, and a few others in this series (bound device/address, maybe
> > the RPF patch as well)?
> 
> selftests were indeed extended to check for this feature (and others).
> However, since these extensions required some restructuring, I preferred to
> keep all selftests patches for a second PR.
> 
> It's obviously always better to have feature+test shipped together, but the
> restructuring on the selftests may require a discussion on its own,
> therefore I decided to go this way.
> 
> I hope it makes sense.

Ok, not ideal but I can live with that.

Then for this patch:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

