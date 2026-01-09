Return-Path: <netdev+bounces-248479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB4D0965F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73213309C3AB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB11B359FBA;
	Fri,  9 Jan 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="x16ZGwEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DnA5lemX"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FA1946C8
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960405; cv=none; b=f6cY7SW51vgkddy8C/uYNryXY8NY4BhXREClUQdJU1qKZNQzPCcQELRJYPhFoiGc1lgZ2yisH6EMtklsFFOzLxcRum3fL7TcEw/je+GDTYdXoyp7v20EjL3YI6qN4nXiRMFSS4jmP0wavlMszKzd7mHsmCNFtrMz8XfViI+x5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960405; c=relaxed/simple;
	bh=W3mAz2JCYPLN9rKRyT8nYTCUf3fYKA3DZYZ49e++gPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQYeoimTFoQVsTgNvqbkBuY1uqa4/ZbpBfYwu6eWb0ha1qe5fWs+gh8wdzq0LHhOL2S7rPW4djYOrsPHYhAEL1jaQZ0YNLGAc4x6peBmTkRDN3hciDqf+2hbQAPJMTQ6Hr4ctDxWiTShayE0TeS4VR6/5gx1cHYRXING4dz/3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=x16ZGwEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DnA5lemX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5A8D7A00A4;
	Fri,  9 Jan 2026 07:06:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1767960401; x=
	1768046801; bh=3Y9JpwticBGoJfPkecuEHCx8pXFBpbdDA2TNbFVTVYQ=; b=x
	16ZGwEuC+vn+ct43hHGy5CLI3UXtfiDbUKR6Q8nag8rD8IX38mehCBqTegaqoQY9
	P8SUV+MHzy8YbOM4NBA9RkRJN/NSTH6ZUv8M/opA1xCnMCeUN5h7QwRklS04ebCc
	k9X90HYnf3Iht/1wMnlp+vKyvhmvKN4vZHlsVH0yPFxDnIOYzgB0GHoZNGDIbM5X
	lHDOkhpyFof+NQN0G0kTtsj5K2bc6IqItSY0XKNPFu6wLg8BtTareovSGLzs/FGf
	qKaalDCjogQF7DDo7lssIgdWnQt+7YFXFOGlbM3lGp7JKKx9ofLEJE6rfYXbNmYy
	idgOQDZbZOAcOpbtmxl2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767960401; x=1768046801; bh=3Y9JpwticBGoJfPkecuEHCx8pXFBpbdDA2T
	NbFVTVYQ=; b=DnA5lemXq1BlIqsdIzb1mwjOpLPNFa3hZH9P0zEeXwt15UBi7Lz
	ehhEL/OrSvosSVW5H+55D3h+2FDwnIvEhzl8FQu+iR3ybEJWPrY5DTXVtbOK5Ubz
	p5MWrZaNkIbZi9UD5htgFEM6/PvCvSSr9Ksom1IViSL0xNCcSRcRleDa7ikzwS58
	2pfPDdu2P/iGc6LLApQvQwaQeI7QuW//n0Wc0ATXDZlDJI4k05raLTWzcxB8RDi7
	FF9gsz0MkuAUgDXtBFrxA9oxXxzYhu3vfa95ujTZBSpf/Binwk+spb2qEjkGG0de
	kb9kZcxMXntDhXSgEDJcgFssF8wA8NAXv2g==
X-ME-Sender: <xms:Ue9gaeqm6cYgJ0VDmimsK2mNrxjYIEUgUcfveKaomx-5c5pO7cVN3A>
    <xme:Ue9gabtIk_edD6DELwYHMlQbQHNUFeCGJp_44_kaVIhurxzz4uao6sPfL2K9jOGX7
    avO7-G_hfUscO_Es6U_oM46yPIAdO0t1kDtIfMjGfJ5bUZTNo1rwfUB>
X-ME-Received: <xmr:Ue9gaZa3_oYaYCso7TxcZ8cHR5sSXPwrl1cPmfStrcYsV1V7c8Xr9qvPWiCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepughtrghtuhhlvggrsehnvhhiughirgdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:Ue9gaaYMlhq34qFbqGMVBM8o3h-IttK0DPkE1IsnLlZfRispFmkmeQ>
    <xmx:Ue9gaSkVh-asGAiK4EvKxdf8MgjCUFKBDm28Dq-4Ecv65AQdtb-4zw>
    <xmx:Ue9gaV3WCnW-pXFtJVldNH9PKp-_IpxkKQtdeRUwodLW56MaHAaP3w>
    <xmx:Ue9gaS0ktFh8FV0W8yBavGf2xHNM9O7xTcVfx6OgcWC6lhZi1bhF0g>
    <xmx:Ue9gaU1_gMU7EnBUiZBEQVtdwFWqhaXifS2lXDE9TaCqo36paI4-Ojdw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:06:40 -0500 (EST)
Date: Fri, 9 Jan 2026 13:06:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Message-ID: <aWDvTx9JUHzUKEGm@krikkit>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
 <aWDX64mYvwI3EVo4@krikkit>
 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>

2026-01-09, 11:38:59 +0000, Cosmin Ratiu wrote:
> On Fri, 2026-01-09 at 11:26 +0100, Sabrina Dubroca wrote:
> > 2026-01-07, 12:47:23 +0200, Cosmin Ratiu wrote:
> > > VLAN-filtering is done through two netdev features
> > > (NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and
> > > two
> > > netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).
> > > 
> > > Implement these and advertise the features if the lower device
> > > supports
> > > them. This allows proper VLAN filtering to work on top of macsec
> > > devices, when the lower device is capable of VLAN filtering.
> > > As a concrete example, having this chain of interfaces now works:
> > > vlan_filtering_capable_dev(1) -> macsec_dev(2) ->
> > > macsec_vlan_dev(3)
> > > 
> > > Before the "Fixes" commit this used to accidentally work because
> > > the
> > > macsec device (and thus the lower device) was put in promiscuous
> > > mode
> > > and the VLAN filter was not used. But after that commit correctly
> > > made
> > > the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous mode
> > > was
> > > no longer used and VLAN filters on dev 1 kicked in. Without support
> > > in
> > > dev 2 for propagating VLAN filters down, the register_vlan_dev ->
> > > vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call from
> > > dev
> > > 3 is silently eaten (because vlan_hw_filter_capable returns false
> > > and
> > > vlan_add_rx_filter_info silently succeeds).
> > 
> > We only want to propagate VLAN filters when macsec offload is used,
> > no? If offload isn't used, the lower device should be unaware of
> > whatever is happening on top of macsec, so I don't think non-
> > offloaded
> > setups are affected by this?
> 
> VLAN filters are not related to macsec offload, right? It's about
> informing the lower netdevice which VLANs should be allowed. Without
> this patch, the VLAN-tagged packets intended for the macsec vlan device
> are discarded by the lower device VLAN filter.

Why does the lower device need to know in the non-offload case? It has
no idea whether it's VLAN traffic or anything else once it's stuffed
into macsec.

The packet will look like

ETH | MACSEC | [some opaque data that may or may not start with a VLAN header ]


> > Even when offload is used, the lower device should probably handle
> > "ETH + VLAN 5" differently from "ETH + MACSEC + VLAN 5", but that may
> > not be possible with just the existing device ops.
> 
> I don't see how macsec plays a role into how the lower device handles
> VLANs. From the protocol diagrams, I see that it's ETH + VLAN 5 +
> MACSEC, the VLAN isn't encrypted if present.

Wait, if we're talking about ETH + VLAN 5 + MACSEC, macsec shouldn't
even be involved in VLAN id 5.

ip link add link eth0 type vlan id 5

should never go through any macsec code at all.

-- 
Sabrina

