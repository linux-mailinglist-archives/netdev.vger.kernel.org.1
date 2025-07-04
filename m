Return-Path: <netdev+bounces-204052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D0AF8B11
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEDBB408CA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F68283FE7;
	Fri,  4 Jul 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L/+xltRa"
X-Original-To: netdev@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F328467F;
	Fri,  4 Jul 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616041; cv=none; b=PtXt1X5n9NbFU+0QKBx8nBjjzJR/JfevGAeq+MPElt9YE/XQMerPJocF6jrOXlb39pVZLfdBOWcqoC5KBQIW2pv/xJau8t2Yia+U4GkMnbizCOeW05hyTY38TGj8j1hkCb1uWu2kRm1dIs8Z8gwPoptr4krkqN7FwiAA9LSRSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616041; c=relaxed/simple;
	bh=NdsQLhu3apZCCsjVCTrZUaX7k09Iz1jpvghceMbRr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO5b2L8xVsiwePawvVDVF6XAqbI9Q2rfZYNjruOwdaJOyd9Tv5Dznolw+nwi8pC4uugsSYCnfAVqCWzDx/RVs3vW8d4AODhsXeEOsowN2/IhP13gnYaSSKpM7OfziOeRUDCA0yz65Yn96n9p47KeYWGq3N5SEShSDraplhHXzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L/+xltRa; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7A77442A6;
	Fri,  4 Jul 2025 08:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751616034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28LCPxaORx3LFMubXW62TY4Yq/7zWWZ/gh5lCqg/Pns=;
	b=L/+xltRakFnyjQ2A4c5BsLY816WmWC2LnI2wrzcajwVQ8eoDWY6cg2NYerbdr0NYRskuK2
	AvHNYCds7urK1AKjEbhQrAkBS4TK0IdGJcyjVm0f/QwF9o+ParUECQigu/LrkHlc6lDfZe
	brP+CZLKI9I/udyeJYvKqUchOGWz5CMutNMfUhGCROf3inc+YB/DBLsH7WZpKUmhanjfPI
	6u5NJVkEgp7g4zzaqLxPj8rxPfHVE1xNtve6SX256j2/H7G08Sv33pxwvSYqkFShgAs8c3
	0JJoU/coLi3v6mZLLlYC3FDOTctfVc+Vcpb3KbXLFblxVlsLf9DCbKEttf6GiA==
Date: Fri, 4 Jul 2025 10:00:31 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andre Edich <andre.edich@microchip.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>
Subject: Re: [PATCH net v2 2/3] net: phy: smsc: Force predictable MDI-X
 state on LAN87xx
Message-ID: <20250704100031.19f95d3e@fedora.home>
In-Reply-To: <20250703114941.3243890-3-o.rempel@pengutronix.de>
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
	<20250703114941.3243890-3-o.rempel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgdrvgguihgthhesmhhitghrohgthhhiphdrtghomh

On Thu,  3 Jul 2025 13:49:40 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Override the hardware strap configuration for MDI-X mode to ensure a
> predictable initial state for the driver. The initial mode of the LAN87xx
> PHY is determined by the AUTOMDIX_EN strap pin, but the driver has no
> documented way to read its latched status.
> 
> This unpredictability means the driver cannot know if the PHY has
> initialized with Auto-MDIX enabled or disabled, preventing it from
> providing a reliable interface to the user.
> 
> This patch introduces a `config_init` hook that forces the PHY into a
> known state by explicitly enabling Auto-MDIX.
> 
> Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Andre Edich <andre.edich@microchip.com>

The patch looks good to me, but I have a few questions.  As this
overrides some configuration on existing HW, and I'm not utra familiar
with auto-mdix, is there any chance this could cause regressions ?

Especially regarding your patch 3, is there any chance that the PHY is
strapped in a fixed MDIX mode to address the broken autoneg off mode ? 

I'm not saying that strapping is a good solution for that ofc :) it's a
shame we can't read the strap config :/

Maxime


