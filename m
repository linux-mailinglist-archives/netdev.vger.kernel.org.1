Return-Path: <netdev+bounces-248443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE42D088E1
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B67A3007E47
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA213370EF;
	Fri,  9 Jan 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kF+7bg0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zw0Cnk6b"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC53382E4
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954418; cv=none; b=iQ1oiSieYLUgqhGgDbmQvcCgDxa3TaqMAEwhYx/1rUZgVy+cz/NTVu4j5h4iPyZX6YHlCHkl9DVYN8iLjiXP6J75nbBIZPvpOILlA90r+Ia9Am3xyey9XubxPepsJAR4T++Lq2uA9xbUyu0HHj7cThhSW3ZEgECLoRc/jl1muqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954418; c=relaxed/simple;
	bh=Snq+umPomX9fyavkvRRyaT2n0isrX93YrXdSoU9OwMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0TbJVsP6iOEfFC0p1Pgut06wNP+Yk0DnkunZLXF0loEQCRgkesG0F9qz/8ZY2y81Vxz97WcrCgBU4qaTbX5ZVJiijITbuNJQX9h8xBxs1evalm1X9DtfAFxkW1O5Ymjs0oU6rYY0rdQTZd+X9/JHwcUJywBobXKURjVXUI3xro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kF+7bg0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zw0Cnk6b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 75FD21D00130;
	Fri,  9 Jan 2026 05:26:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 05:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1767954414; x=
	1768040814; bh=aZINNoLVZ+Mwd+rayagnxMm/756a0J8Sm4oNGlDsEoc=; b=k
	F+7bg0LXPxzC7Lnh8MuTVqkHmLjDw+2yaL0JTAE/i9xUUOwoXv9Bm+2f/WNu8zRY
	f2AwSuPi7qXUCXj2PRtfpYl5uPI8twUMnI9dthJL3bWIzKcGnQ4L589R2YjuXEF0
	uJsu3WOQ6VPaTDckIWY+RIshT9IGEird7lGy/mUezziKjqf/35MDWRCtdXk1FcSs
	oFqkwQpBRxqDRNZ9aAT8kJerQ0mmDo73WJvDqFcjuCyrlTHT6jXAct+c28rp67qZ
	ewkzuxLSkqPMvBIarotQKjF2U7eze5pU2DpimBm7eZjLra3k9UTAZyZC828fZ0e9
	87Dg4jshJGMJ6NZo0yCYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767954414; x=1768040814; bh=aZINNoLVZ+Mwd+rayagnxMm/756a0J8Sm4o
	NGlDsEoc=; b=Zw0Cnk6bk2+O6Mc0ZgmXzE7Asbb4JoFmQRBD1mK0guoaeKyFXCm
	qOLm7rl+fAKMGJYFHX4I1z+qWeFPkJC6pr8gNxM/je65GlXDjppZQVYRA8Vsxz8O
	JNaBOAcVQXqHPWTHUG6mhUxUjC+3tVpoKkGDacyrsq6iv39AcuxP5V/lCGjaAGL2
	5Hv4rWVOzPQcV9YIgr69CioAv8O1w9yDorHMKj9oaKYSlQZSNqf9Tvx8LlrKAA0E
	00PasjCJYNdHrPcRwYfLLPjh7tE9XRbro3mDNCGc3o3u5zyZjRLsiYBCjPA3M1da
	ZuTXN8g8/OcrulDPejgpdJOCmwPZ6g4nDZw==
X-ME-Sender: <xms:7ddgaR6kGfiPgkuc2fHOtxqwZ3NcelLG7f_s0jnUc_yrBGknEIKVWg>
    <xme:7ddgad_Pbop4B16lnPE2eFYhVCVXZRqFBacrgbOxhdFDXbQB4GGVwzWZxoN5Fx3lY
    -pEf4s1VkzTrr5O0tIlHl4rvWn1lkasigh1RmoXfPpCx3nRY-PcAydV>
X-ME-Received: <xmr:7ddgaeqZERfcEr9x_fS-UVwUmDaf_4jPGewyjbgcht7Tvf_79xJBkUjKQALL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguthgrthhulhgv
    rgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:7ddgaWriZ-d-7f2LgDItkwWiBduOvdVG8Wyl6TZeHjNKuba4BPJR4g>
    <xmx:7ddgaZ0xnaqkKJ6TXytz2Uj30sZRWwShCGzNuJM-XXGts2ZZ1TLeig>
    <xmx:7ddgacEr9aKPSixVv0i1TzOqRIO8e2olPAIp9-EgRbtg8DIYDn_Lgw>
    <xmx:7ddgacFXYt59tvro7qoLgsLn2JBFlTW5bDF3aKR678_mNiUbWX42_g>
    <xmx:7tdgaSGpKVIecU3opd5VJ31Sg-QHqorzk0E9Tls0IXJmh1yEkp8jMq22>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 05:26:53 -0500 (EST)
Date: Fri, 9 Jan 2026 11:26:51 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Message-ID: <aWDX64mYvwI3EVo4@krikkit>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107104723.2750725-1-cratiu@nvidia.com>

2026-01-07, 12:47:23 +0200, Cosmin Ratiu wrote:
> VLAN-filtering is done through two netdev features
> (NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
> netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).
> 
> Implement these and advertise the features if the lower device supports
> them. This allows proper VLAN filtering to work on top of macsec
> devices, when the lower device is capable of VLAN filtering.
> As a concrete example, having this chain of interfaces now works:
> vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)
> 
> Before the "Fixes" commit this used to accidentally work because the
> macsec device (and thus the lower device) was put in promiscuous mode
> and the VLAN filter was not used. But after that commit correctly made
> the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous mode was
> no longer used and VLAN filters on dev 1 kicked in. Without support in
> dev 2 for propagating VLAN filters down, the register_vlan_dev ->
> vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call from dev
> 3 is silently eaten (because vlan_hw_filter_capable returns false and
> vlan_add_rx_filter_info silently succeeds).

We only want to propagate VLAN filters when macsec offload is used,
no? If offload isn't used, the lower device should be unaware of
whatever is happening on top of macsec, so I don't think non-offloaded
setups are affected by this?

Even when offload is used, the lower device should probably handle
"ETH + VLAN 5" differently from "ETH + MACSEC + VLAN 5", but that may
not be possible with just the existing device ops.

-- 
Sabrina

