Return-Path: <netdev+bounces-248753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBEDD0DE9B
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC5DA300A28F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DFBA3F;
	Sat, 10 Jan 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DbqRo6HS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oO760jlG"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CC3D6F
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085128; cv=none; b=dqEcF5LBdS+3NRH4EbB5aKFvUXh8ycF1bU40a6lfCuJDlT4fNCosU5N2vtz4dz4/nOPk5N46i4GthcrX/g3sLDoKutG5hMgrn2veol0g+Py7lPvqz6X+20sdvdbcK8iu8K3AqerAjoAsvKzD/a/SCnmWYiFZcOtPXVcjRyz4aj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085128; c=relaxed/simple;
	bh=kEEUdRWfpOeXBo05mG2tjWDcqaG1TWLY4q7/ro52XUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqnhdeh/o5kZ80aBZcIS+AHfWZaHzbQtTGYbXHK3b5FehVii7E3U5e/Vb71XsoFIyaSi+TB7ORXQvdj534CNGdC56aX6q9on3NhGRRTgjUSjH1KsC+zeZfaNyWSbIl+7yKl7lc0n32zW9ObgFhKw/QRqur+TSAfGOYoB3mCP3+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DbqRo6HS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oO760jlG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D6A601D00046;
	Sat, 10 Jan 2026 17:45:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 10 Jan 2026 17:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1768085124; x=
	1768171524; bh=lUTaC9frI1geWFBueP6jnUisCWQXwepesFn1SQqS4Yw=; b=D
	bqRo6HS8g0bh+4ZLrY7R3IoqMdIs/oSm3T9sk7QQ4n6LHmFZgJy1Zb7tP0dTgh5E
	Qg/jhwnvSN9J5E3R8lQfQn7MisVHXqOb6XbHhDBO0j/U3YHyKC0nCW3v03HYg82u
	PQ81QxSdBslCC1bmqnFCvEm5WEXwFbP5J4YN5dFdqhtgqFOC3kQdMoD2Mnm/Q9J+
	WY0inPfeq2xPXHwJ0ajoYenqXLnf5wsYIPaGuTPh3D0DOzAQPwjM1nk2FAjiMYH2
	7ND9KmiN3+PkIYF+WdhDiDU5+pBV+/0bZKL0Yc3KVil9EMCGUWCtZ1tvwO7kXKRx
	4VcovcL+U6AGD7hvDcCIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768085124; x=1768171524; bh=lUTaC9frI1geWFBueP6jnUisCWQXwepesFn
	1SQqS4Yw=; b=oO760jlG0Gbq1+wFwCO7VplXPTpnp9E3Vgv9FjuLuXPsX2H9WBl
	buCMJrp2/KFKwEJUXxI5NAqdY9OOhbsfe1Mz5QW6oMuiv5A8LbimGiWCc5S48dgl
	F6iIg8ICMk43FzPDyxJ2SOgyfDHugMoRRuV9vcoo1S34a961OfRaRDxljCDEoNFX
	ak1SJYRpbaGwFxZi9b7eTQF80H0KyU+cnBIU9552IJVpDBERXXGSDNLU3wc13Jvx
	Q15d7XwScB7BstEm395e8RSO9m0dhS0Rr1jcwgBCU2ARNDt50DOoutiOtJ3bU+S6
	GRoAyOVIv9Ak587Gk7ytMK/DbGuCvg0Wb6A==
X-ME-Sender: <xms:hNZiaUlCABikRoBIFLIbOhwSpbamWF-rGNZi3m9bzlmTG7BRQGmP5Q>
    <xme:hNZiaS7KXmsHijhazqqrON4G7Lrd4hvPxEarGrwK-zZZqvMmH8c0hHD9WDDrB1bCF
    QgeDt0i2ZpNHWtSKkIUTqZ0LlhmnkS3ER-TMZgfsP8ZD_FfZLlVfA>
X-ME-Received: <xmr:hNZiaY0n9rp-vH8V_3244XYCp3sb77MgGtj-80Km6VFtt6PHdwqBqpkd0JKL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughtrghtuhhlvggrsehnvh
    hiughirgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgv
    thguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:hNZiadGiPPMJ3jsAt-58DOoQ-YFDKjO9IjJD42ZObP-Umt_LOAT5_g>
    <xmx:hNZiaXinA4pQl65L9Lmcd4Z1w_V0Q_lJ28Pgw0hLjSVCGB0l3GamPg>
    <xmx:hNZiaQAcXF-DKeyhrOY4CXkxMorxJjgzqyDghglwukw2n64n1tnT6Q>
    <xmx:hNZiaZQ8I65XxuXjJRpPZczLc_R4APloKBqKIIlIke2CzLwpu0zPdg>
    <xmx:hNZiaeTpd2lsbDkkAQoC0ZALa12vZPjqBcMjjRl9Mh6KdnWwIt7JTVPY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 17:45:23 -0500 (EST)
Date: Sat, 10 Jan 2026 23:45:22 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Message-ID: <aWLWgrL8UYJISOsu@krikkit>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
 <aWDX64mYvwI3EVo4@krikkit>
 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
 <aWDvTx9JUHzUKEGm@krikkit>
 <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>

2026-01-09, 13:50:24 +0000, Cosmin Ratiu wrote:
> On Fri, 2026-01-09 at 13:06 +0100, Sabrina Dubroca wrote:
> > 2026-01-09, 11:38:59 +0000, Cosmin Ratiu wrote:
> > > On Fri, 2026-01-09 at 11:26 +0100, Sabrina Dubroca wrote:
> > > > 2026-01-07, 12:47:23 +0200, Cosmin Ratiu wrote:
> > > > > VLAN-filtering is done through two netdev features
> > > > > (NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER)
> > > > > and
> > > > > two
> > > > > netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).
> > > > > 
> > > > > Implement these and advertise the features if the lower device
> > > > > supports
> > > > > them. This allows proper VLAN filtering to work on top of
> > > > > macsec
> > > > > devices, when the lower device is capable of VLAN filtering.
> > > > > As a concrete example, having this chain of interfaces now
> > > > > works:
> > > > > vlan_filtering_capable_dev(1) -> macsec_dev(2) ->
> > > > > macsec_vlan_dev(3)
> > > > > 
> > > > > Before the "Fixes" commit this used to accidentally work
> > > > > because
> > > > > the
> > > > > macsec device (and thus the lower device) was put in
> > > > > promiscuous
> > > > > mode
> > > > > and the VLAN filter was not used. But after that commit
> > > > > correctly
> > > > > made
> > > > > the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous
> > > > > mode
> > > > > was
> > > > > no longer used and VLAN filters on dev 1 kicked in. Without
> > > > > support
> > > > > in
> > > > > dev 2 for propagating VLAN filters down, the register_vlan_dev
> > > > > ->
> > > > > vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call
> > > > > from
> > > > > dev
> > > > > 3 is silently eaten (because vlan_hw_filter_capable returns
> > > > > false
> > > > > and
> > > > > vlan_add_rx_filter_info silently succeeds).
> > > > 
> > > > We only want to propagate VLAN filters when macsec offload is
> > > > used,
> > > > no? If offload isn't used, the lower device should be unaware of
> > > > whatever is happening on top of macsec, so I don't think non-
> > > > offloaded
> > > > setups are affected by this?
> > > 
> > > VLAN filters are not related to macsec offload, right? It's about
> > > informing the lower netdevice which VLANs should be allowed.
> > > Without
> > > this patch, the VLAN-tagged packets intended for the macsec vlan
> > > device
> > > are discarded by the lower device VLAN filter.
> > 
> > Why does the lower device need to know in the non-offload case? It
> > has
> > no idea whether it's VLAN traffic or anything else once it's stuffed
> > into macsec.
> > 
> > The packet will look like
> > 
> > ETH | MACSEC | [some opaque data that may or may not start with a
> > VLAN header ]
> 
> You're right, I checked the failure and it happens only when offloads
> are enabled.

Ok, thanks.

> > > > Even when offload is used, the lower device should probably
> > > > handle
> > > > "ETH + VLAN 5" differently from "ETH + MACSEC + VLAN 5", but that
> > > > may
> > > > not be possible with just the existing device ops.
> > > 
> > > I don't see how macsec plays a role into how the lower device
> > > handles
> > > VLANs. From the protocol diagrams, I see that it's ETH + VLAN 5 +
> > > MACSEC, the VLAN isn't encrypted if present.
> > 
> > Wait, if we're talking about ETH + VLAN 5 + MACSEC, macsec shouldn't
> > even be involved in VLAN id 5.
> > 
> > ip link add link eth0 type vlan id 5
> > 
> > should never go through any macsec code at all.
> > 
> 
> These are the interfaces:
> ip link add link $LOWER_DEV macsec0 type macsec sci ...
> ip macsec offload macsec0 mac
> ip link add link macsec0 name macsec_vlan type vlan id 5

Ok, that's what I was expecting.

(so it's not "ETH + VLAN 5 + MACSEC", either there was a typo or the
"protocol diagrams" you mentioned above are incorrect)

> What happens is that without the VLAN filter configured correctly, the
> hw on the rx side decrypts and decapsulates macsec packets but drops
> them shorty after.

Right.

> Would you like to see any tweaks to the proposed patch?

Well, updating the lower device's VLAN filters when not using offload
is undesireable, so macsec_vlan_rx_{add,kill}_vid should check that
offload is used, but then we'd have to remove/re-add then when offload
is toggled after some vlan devices have been created on top of the
macsec device.  Keeping track of all the ids we've pushed down via
macsec_vlan_rx_add_vid seems a bit unreasonable, but maybe we can
call vlan_{get,drop}_rx_*_filter_info when we toggle macsec offload?
(not sure if that will have the behavior we want)

-- 
Sabrina

