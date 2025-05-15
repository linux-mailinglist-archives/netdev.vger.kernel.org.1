Return-Path: <netdev+bounces-190632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E82DAB7ED6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E23B9104
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1B1B6D06;
	Thu, 15 May 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gp5hEekP"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA0110FD;
	Thu, 15 May 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294290; cv=none; b=gwmCuRjRpZXGmEpAVaebkaGX/fdl2METN9LScq8N6sPIk6dTpjHlPUDCdgPRAf2PuRdv/4l5FL5BqAfsAiylQ8pMPy0rWkZ/cLmDp0ebiGqGIThZfP6fdrtK9DjCk/TYillhtQ0zVA/3kpLlPuCw9jDzJ2dKik4AX3Kn1gq5Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294290; c=relaxed/simple;
	bh=AAYNcNZn4MmRjtFJuqCMF+YEecA54JF4VSCDovXMDuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOOp4z9/rXM5ZjZ9SdknbQJBZHl3qtWirPoB21UiC0WoPzn9ourqPeiw1MS9oDuNlvtAXYurrH45D/G42ZTJrpI3U6q8pbtqNF0I6bLvqsCcqBuYyNE3AfHD2M+Zh0xaakvGTNXPm1fjTvKg9z0am6O0ulmbP8vHHtaMFrMFOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gp5hEekP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F016C43B56;
	Thu, 15 May 2025 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747294286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6ZVrKXZ7nh1gJn9x7O1w63niuypshH7rDC/mZ2ilkQ=;
	b=gp5hEekPPgb0aWTMfZXrT35W3K8YfdS3rZ9QlucKjykkQiKwNYpbENvWffczSlOWJWkdYj
	BTI9QvFlcyJccZm38DpCXXg7WQbXD9GvR7DDOWAiyxhfzq6C9DzAbOWjk7aqlKHxI6A6Re
	D2D1EwL3JBmMmDKkCNwtbg0aV6l7lDiS2ImmBqL+AE7aePw+GfTa7tUSC029qdQUQn+DsQ
	oPeCulbI5yVoFrxQtpFB9YlyPC0QaFzAlv03Cb8zXPDodmXYJ+BYKelN06od2hYzkV5YWE
	q9OA3L9c6g6kTQFTJXH3/PM9qDL76v2bwRwQi0JPahFeRUtjiK7Kbn4jnk5jRA==
Date: Thu, 15 May 2025 09:31:24 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Tristram.Ha@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250515093124.7b7c365a@fedora.home>
In-Reply-To: <20250513222224.4123-1-Tristram.Ha@microchip.com>
References: <20250513222224.4123-1-Tristram.Ha@microchip.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepvfhrihhsthhrrghmrdfjrgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhi
 hhprdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tristram,

On Tue, 13 May 2025 15:22:24 -0700
<Tristram.Ha@microchip.com> wrote:

> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> port.  However there are some hardware bugs in the KSZ9477 SGMII
> module so workarounds are needed.  There was a proposal to update the
> XPCS driver to accommodate KSZ9477, but the new code is not generic
> enough to be used by other vendors.  It is better to do all these
> workarounds inside the KSZ9477 driver instead of modifying the XPCS
> driver.
> 
> There are 3 hardware issues.  The first is the MII_ADVERTISE register
> needs to be write once after reset for the correct code word to be
> sent.  The XPCS driver disables auto-negotiation first before
> configuring the SGMII/1000BASE-X mode and then enables it back.  The
> KSZ9477 driver then writes the MII_ADVERTISE register before enabling
> auto-negotiation.  In 1000BASE-X mode the MII_ADVERTISE register will
> be set, so KSZ9477 driver does not need to write it.
> 
> The second issue is the MII_BMCR register needs to set the exact speed
> and duplex mode when running in SGMII mode.  During link polling the
> KSZ9477 will check the speed and duplex mode are different from
> previous ones and update the MII_BMCR register accordingly.
> 
> The last issue is 1000BASE-X mode does not work with auto-negotiation
> on.  The cause is the local port hardware does not know the link is up
> and so network traffic is not forwarded.  The workaround is to write 2
> additional bits when 1000BASE-X mode is configured.
> 
> Note the SGMII interrupt in the port cannot be masked.  As that
> interrupt is not handled in the KSZ9477 driver the SGMII interrupt bit
> will not be set even when the XPCS driver sets it.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

I was able to test this patch this morning, with both SGMII (copper
SFP) and 1000BaseX (Fibre SFP), hot-swapping and all, it works well :)

Thanks for that !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

