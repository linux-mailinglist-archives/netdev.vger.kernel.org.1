Return-Path: <netdev+bounces-199072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD27ADED3D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF2170E82
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF918CC1C;
	Wed, 18 Jun 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1vc9lvdn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E7BA3D;
	Wed, 18 Jun 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251653; cv=none; b=LwkZBAvItdteO5hieh9XWVhaPQdJlDYwCpbs7SnHqIs/765WHDJC3/EcjVa3/OO7kl+iW3Y9wb2VC97jlZRwIrONRJpvyHu4fUdlDVC4LehpeQNqP1HqyLYa0kVxdmsg02HCldC381vMSXIwyZAzSgcxhajks11tFUZ7nN0FTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251653; c=relaxed/simple;
	bh=0VKMJ80WeQed5dCcjnvRbYVdo5UVRbQsnBzQwh4l9Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIq3U273UvV6VGAywcuhY0kYVZLclUdLHmdEFbychKAMH8cAH1uj1YLcQO+fckRz5c9/iwlidex1zhd/3LwIcAbYh4EMk/HbSR0/o1ApYE5kidbZlb/BHGF4fGUoOFR+VFEjuPQDbFCYiLpZP/j9QuLoLugBgQdbP6zLi33thic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1vc9lvdn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g9rbnUq9NAUMIQ53jkwY7OQrnJE9eX1UJuJrg7IAxnU=; b=1vc9lvdnkHCnHKylDBVYX1SxWQ
	wMR0aDBPFYcoOM3T9PPBp9342/umNSw8wkkC1ArU5e3tGUvs0z2iSIpFzQx4qK67xxzxsr8Y33Q4M
	OTp5WnrzgISdrSurMMKSUs4fm8XxZiFK5X9SXwBB2FZW4Ddg3x91xiwV3Gk0Quomv4vbb0fwVpU4D
	jVhzcIUJX/xN1544gPw/0637DpOwtUsnHAhV8/E9M+lM6TzNNbKBMp+pLOk4WADyMA/35jSRjBNH1
	Mx90/bKoHm7kdehPe21+AHhqHMJvF2rIRrn3GSPFO2kWgI/jLQ+qvnoDJFt+l6SDRBbDbpuiCahXR
	HsSprYmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60496)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsPD-0006Tp-25;
	Wed, 18 Jun 2025 14:00:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsPC-0006qh-1W;
	Wed, 18 Jun 2025 14:00:42 +0100
Date: Wed, 18 Jun 2025 14:00:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 3/6] net: usb: lan78xx: Use
 ethtool_op_get_link to reflect current link status
Message-ID: <aFK4epTcawjpdAjA@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-4-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:25:59PM +0200, Oleksij Rempel wrote:
> Replace the custom lan78xx_get_link implementation with the standard
> ethtool_op_get_link helper, which uses netif_carrier_ok to reflect
> the current link status accurately.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

