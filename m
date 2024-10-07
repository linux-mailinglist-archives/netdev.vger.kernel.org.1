Return-Path: <netdev+bounces-132816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8089934A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DA71C215EA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663441DCB1D;
	Mon,  7 Oct 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GK4X/xXT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7241DA2E5;
	Mon,  7 Oct 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321445; cv=none; b=pqtUA2YrKCitceT6+A0l/Pthvvn9VYaP49KTacY2O7Z+BEoOTTNCRflr4bf8mC+A/ExIi+i10BZKlwmmtGdqouahvk9IWviSLN2Xk+hheIiIYg4Jhk1R6oMnRbgyJT+6kIyJIsl3px43vsiHI3p6HvPCf+mUjUhlN1L/PBY6Pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321445; c=relaxed/simple;
	bh=VxGBX0ULYi2EAq+yRPUREoOPa1Wmckf4kqo5VQMoH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOg9yKjVTvmH7TABcMmEgQClAcB5o2J3wfhijRccKG7xiorDTzk0N3s4odX6pSi1j9NVCzjaBJrEMoTamOz2WwT4yw0JXBL2mauoTSa6eRQLaLcwbaK2Viby8NVJ42sNSr5AuACwGpYoHcPp/8iI2gVPdsnK7ILqDsJ1yI49H98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GK4X/xXT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mZjJh1i9ljUXC8dDHtmmP0zanIYCPR10JoyaAII1NYo=; b=GK4X/xXT2YGi2t+0cHu5xqF+n1
	eUZ1kLTcTxIyzxkHnVPNy4wUhkaZo/ZNdH0zoV8jeQ/IrileC1PXcVgAnREk/x912Mcxvzz6MOgew
	ewYHlWMMyBBV0pALXNV+XmmAk36TB3t6yBO3gpxMVVmhrTsHAVwNv17YmzAkEBF5V99E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxrMA-009I9K-Lj; Mon, 07 Oct 2024 19:17:14 +0200
Date: Mon, 7 Oct 2024 19:17:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: disable eee due to errata on various KSZ
 switches
Message-ID: <013420e6-12c7-45df-986c-22b3e2c1f610@lunn.ch>
References: <20241007171032.3510003-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007171032.3510003-1-tharvey@gateworks.com>

On Mon, Oct 07, 2024 at 10:10:32AM -0700, Tim Harvey wrote:
> The well-known errata regarding EEE not being functional on various KSZ
> switches has been refactored a few times. Recently the refactoring has
> excluded several switches that the errata should also apply to.
> 
> Disable EEE for additional switches with this errata.
> 
> The original workaround for the errata was applied with a register
> write to manually disable the EEE feature in MMD 7:60 which was being
> applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.
> 
> Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
> fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
> remove KSZ9477 PHY errata handling") which moved the errata from the
> switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
> however that PHY code was dead code because an entry was never added
> for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.
> 
> This was apparently realized much later and commit ("54a4e5c16382 net:
> phy: micrel: add Microchip KSZ 9477 to the device table") added the
> PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
> applied to PHY_ID_KSZ9477 it's not completely clear what switches
> that relates to.
> 
> Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
> after suspend/resume") breaks this again for all but KSZ9897 by only
> applying the errata for that PHY ID.
> 
> The most recent time this was affected was with commit ("08c6d8bae48c
> net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
> removes the blatant register write to MMD 7:60 and replaces it by
> setting phydev->eee_broken_modes = -1 so that the generic phy-c45 code
> disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2: added fixes tag and history of issue

You did?

Also, you need to set the subject line to net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

       Andrew

