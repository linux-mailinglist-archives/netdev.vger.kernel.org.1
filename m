Return-Path: <netdev+bounces-204045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EE6AF8B26
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587DE1896115
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C85289347;
	Fri,  4 Jul 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pt13Wn75"
X-Original-To: netdev@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF711288C19;
	Fri,  4 Jul 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615644; cv=none; b=jm2gh2UE1i/mbQI1+Ek+ViKMqzjp9sm9cgckFv6UewBjQmNwa1P0JzNiOjWgMyaJ5MYa34VzL4WVhf6v7c2MeyjcLAEeRo7RHaJQ9aP5W/StCihzK/mMgYegWDbH8GUk7a9JE2udDUUWbHmIDY0YfbW5Tqzd4r5cfX+g0vPfyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615644; c=relaxed/simple;
	bh=Ja1PvWH1xvcWWWPWhJqOm3iUtLfvIbMEc340tKKqjbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzIWVYTuUi0A+nEcgDL74OU/eK8oKSN9Tt1HVeGR2rmWdl7q8Jw75PIyFHpkBZwbZE+YsS3tSRLtKUkEwcO5dP1R22hHhubk0OI9wZPQsmws8dLfWiNeoASBr6eJX2gnI9ApfuVNmUPcktqASoT+ypqzU4SQxpwn88c2bbC6Czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pt13Wn75; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 144F6449EC;
	Fri,  4 Jul 2025 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751615639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGokUQU9D12trbOtyhmYZxUvKU7aVutPppQ14CcUIWA=;
	b=Pt13Wn75RkhLV5K/mIBzGx1yeA+VpBMJm3BU4XhkWzkKw2E9ol0xa6glQFbWKhx+elBXGs
	Dc4BttBnHVwL8SXxZXTREKDWncqJ7q+modSv7/clL2AOVFQq0dB6YASOsPnXwI/rf3eQc0
	NUt6n+nifKwfOkLZMdmd2Zq7d1Q5xX8KBTRRzKXEBCDyBH+Lf+r0HTOo84F8vMq7KTT+u9
	LZBLFX4VopTDErPvZod2fgZFwqXyKZiyw/Sia4i0J/jr/JxtZkM58XNc9J1XNSPe3XVqiT
	JB4kdwQGsecuWUyY2Tf1WL3fsD2sFBu/RYiYOo6oEnWPDdiH9P2Ou/FgZWpa0A==
Date: Fri, 4 Jul 2025 09:53:56 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andre Edich <andre.edich@microchip.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>
Subject: Re: [PATCH net v2 1/3] net: phy: smsc: Fix Auto-MDIX configuration
 when disabled by strap
Message-ID: <20250704095356.680bd24b@fedora.home>
In-Reply-To: <20250703114941.3243890-2-o.rempel@pengutronix.de>
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
	<20250703114941.3243890-2-o.rempel@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgdrvgguihgthhesmhhitghrohgthhhiphdrtghomh

Hi Oleksij,

On Thu,  3 Jul 2025 13:49:39 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Correct the Auto-MDIX configuration to ensure userspace settings are
> respected when the feature is disabled by the AUTOMDIX_EN hardware strap.
> 
> The LAN9500 PHY allows its default MDI-X mode to be configured via a
> hardware strap. If this strap sets the default to "MDI-X off", the
> driver was previously unable to enable Auto-MDIX from userspace.
> 
> When handling the ETH_TP_MDI_AUTO case, the driver would set the
> SPECIAL_CTRL_STS_AMDIX_ENABLE_ bit but neglected to set the required
> SPECIAL_CTRL_STS_OVRRD_AMDIX_ bit. Without the override flag, the PHY
> falls back to its hardware strap default, ignoring the software request.
> 
> This patch corrects the behavior by also setting the override bit when
> enabling Auto-MDIX. This ensures that the userspace configuration takes
> precedence over the hardware strap, allowing Auto-MDIX to be enabled
> correctly in all scenarios.
> 
> Fixes: 05b35e7eb9a1 ("smsc95xx: add phylib support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Andre Edich <andre.edich@microchip.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


