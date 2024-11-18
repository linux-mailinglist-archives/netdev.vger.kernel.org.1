Return-Path: <netdev+bounces-145776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F69D0B50
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316F52827C5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09978148FF6;
	Mon, 18 Nov 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kb3sBtyE"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939D2110E
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920444; cv=none; b=cMETMPTUxQBgX24cfLIynEqRvbr02IFy2Wqn8n6PBllE6RzwkO2Zkl67XD7PPkNXtyidWp2QYwcIxA4mezqTzZDaGM6qO881JQDdQyGEFE4wgsbxN3tP6zK0EzNDc5N+r0lRK64wPRQ7p2ezQQFDiPYhAXq6MmoiTgc2P2Vb1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920444; c=relaxed/simple;
	bh=OX4xRIdK49sRmIqTk1uovx4zGNvomeZS27VLhEI7gNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiaD9MJodHrPSZgJOElDuiI49pP5JfkxfiefQzngbHSSCFC7TVqZswhvo+VUhfiy+rGbYDZF/JODC4GMahARETW8KsRXD9+fKMRgK/lnZSAjTJQgSci/h+X7L2sIZyxDifMJ4YGDJNe51dZx6ZkoYNkGCfl4yLzITHKl6+c/NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kb3sBtyE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D91321140222;
	Mon, 18 Nov 2024 04:00:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 04:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731920441; x=1732006841; bh=5fC/Pq5ZuBb6DF3/GCNWrhgYuNNgmF8cm5w
	99GYk0mk=; b=kb3sBtyEURUBuTZfFgGlwRrE4J+Htr5iMWXIwGAleuhzh1SKc4q
	HeG9Wh/QTNgDLVXwtafgkrzjSVW1DvTsv5dS2YgsM8UUfL0qR1uIopWJ+J/iOUtS
	GofLVn51icyoy7MbWMMBTrG9GADF0kSSpQd2Y86+DAaSuizFsinFx5/wWPJCSG1i
	ZeFeDVYt53PZHHXM3EUooQNHvt0/25MtKtBW7WdEwhh97hoWfPDD9HslXfTEGP9t
	WTj1OAc6AZcap9CXUYIXqto839gMd0HQ66VL7B7/W7JULrrTi+GOqZuU2jDhqmh2
	YxtEQcYqpvXHsnuv6vVWxiMPdZ1JQVq+vrQ==
X-ME-Sender: <xms:OQI7Z0CQLYYVPnT_tKI9mYfYsf-Ig3uV6sdNVuSnrqMwqtvQyQkYIA>
    <xme:OQI7Z2gH9tP8dreYtJwNpKgmtvjwBE9t6eWveT4xwh6-Pb67zxzRvKfPMxRHzPM_C
    Kk29-l6Vs28eIQ>
X-ME-Received: <xmr:OQI7Z3nvqEVLD9Wbwlyk2Z5kPHptJN63gL17pDR1dto3YlW053ajN0ZOinej>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvggvrghrsgestggrnh
    guvghlrghtvggthhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:OQI7Z6wYhGbCFLCZI4gsMzTGojqkBMWr6HPPfSWrS1zpA191TVOVyA>
    <xmx:OQI7Z5TNPHe4ryi6FNUiaI90hFk7yd2FnO8ESkBaDJ025UwDe0a41Q>
    <xmx:OQI7Z1Yc7cLni9p6sYBnQRX9NdSWdWM5aSrvlUzu9vbVLmmyEHD4SA>
    <xmx:OQI7ZyTmTyz9tw8XWQMYhesH15CoCNzobRc6EuyMXVgJGMCHnZ7fBA>
    <xmx:OQI7Z4INjcK-JJCXRTs1K4IWBFLQbFxQIINvb14WaEyVu0q4n0s41bS7>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 04:00:40 -0500 (EST)
Date: Mon, 18 Nov 2024 11:00:37 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: Re: GRE tunnels bound to VRF
Message-ID: <ZzsCNUN1vl01uZcX@shredder>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>

On Sun, Nov 17, 2024 at 10:40:18AM -0800, Ben Greear wrote:
> Hello,
> 
> Is there any (sane) way to tell a GRE tunnel to use a VRF for its
> underlying traffic?
> 
> For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
> to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
> gre interfaces and have that go out whatever the ethernet VRFs route to...

You can set eth{1,2} as the "physical device" of gre{0,1}

ip link add name gre0 up type gre [...] dev eth1
ip link add name gre1 up type gre [...] dev eth2

The "physical device" can be any interface in the VRF, not necessarily
eth{1,2}.

