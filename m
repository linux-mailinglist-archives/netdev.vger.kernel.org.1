Return-Path: <netdev+bounces-128675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4FF97ADB7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEC41C211A4
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05E155382;
	Tue, 17 Sep 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pyiRW+Mc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DF136351;
	Tue, 17 Sep 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564653; cv=none; b=lePWAKf++9QNFOlYquy/WCBf72IaMl2x/gd5DYosmZi0y3LhnPqFz/lEsUdvM6MJF2dEBUz6OYIeLDac0PN208d413GtDvQJi59by7UqNwf6IwB5QV8CZChA1/57EluTzKsX/LiSokkBjPGlJU9ZSMS/rlRETeo4ACpbIxYocGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564653; c=relaxed/simple;
	bh=DG6fdDDcI5Cyq+nRTSK7X26r2gaWYB/ijo48VPl0dww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpEKgRTYfSRJFG+DBQN0O7s26UMk5mi6C7zfDpEmwu2EOQqP1/Es/fIrTFawTUm6cphaCj+ZPByWrhjEArOxU9agqStYLGrMX4L0yR0TQcPXkfGRS7keSnkgSynRWPzU/j3lPv0zldhI2voH9g6T19YgStuWi3UMd6BdRk+DdYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pyiRW+Mc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u1XtYv1oP8kEWubxjLTRw4ZnVypnBzNGZPdqFGQZ/Zs=; b=pyiRW+McJKSzuq/HMDwua8u2/S
	8BzgpuXJeOo47eM8C2OjPZvN031lWeogAhraIulYkI3GqDYirk5p9e7nrHXhZvMBMhR8HXWrqP/I8
	lC0WQOVlnrmjKoCBczJJLGN8n8adYym++lj/LjiYFyKiI3wf8l2TAZAils11j2EjvRe38MQ3ffgt4
	pmJIrwVBINMgJE3GAPY1QxW5NJpchOwAAcP3Qbai0FF0+hiedtuwZpy3bDL3fYruTiV9MdeWrCMr6
	tjUjUaXnv85+E70ZB5OCCWvj+f72PqiLUseLJy8H2vcKKbbPvGdj1bshU7DBhk/fWCQXplPh4Nq3H
	FTScWuOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33412)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqUKl-0006mf-0N;
	Tue, 17 Sep 2024 10:17:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqUKj-0007rN-0k;
	Tue, 17 Sep 2024 10:17:17 +0100
Date: Tue, 17 Sep 2024 10:17:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: phy: Add support for PHY
 timing-role configuration via device tree
Message-ID: <ZulJHVuku8OPlXke@shell.armlinux.org.uk>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240913084022.3343903-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913084022.3343903-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 13, 2024 at 10:40:22AM +0200, Oleksij Rempel wrote:
> Introduce support for configuring the master/slave role of PHYs based on
> the `timing-role` property in the device tree. While this functionality
> is necessary for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1)
> where hardware strap pins may be unavailable or incorrectly set, it
> works for any PHY type.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

