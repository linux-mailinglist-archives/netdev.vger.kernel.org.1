Return-Path: <netdev+bounces-177106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E94A6DEBA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBC3A5A10
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1525F982;
	Mon, 24 Mar 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OPYk/32J"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353125D533;
	Mon, 24 Mar 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830299; cv=none; b=Cb8EVHfvqebALWU3TqXXkYod1tG5GrkwxfJTdtRDAwTqKydGjmlOZHUaDTR6sD9MQ7+oa+ScBWDl4V2TU4U2YrHz81V0Wlu3x9+SRt5DkF/Aq8dtvDabh3fBsVavoSzcdz17Toj5sI9fpwD8QXQRw/TFpbEBM7cRTG4gN3V4e7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830299; c=relaxed/simple;
	bh=4tiDfJT8ZQGVLD+hVOtWyC4YIAJ3VvygQpPhRRl56wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1q7TJMDE3uX1q4ieBPEbszYDdQmn/prFiBct0Iw/ScvHCR7U0RDip8rijR/EYmsJlxYNete58a4KYL3EQbYUsJ3KjnMEWkG8pWbRPl6g8nU1KDl2njq0UpvZTGe6XRCoAox4qq2lOTQRuuOHC2mY0TsOXlBlSqpz1Hc9WVH5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OPYk/32J; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nvtENk+3+KaSmXkgyGUoSrWZRJ1UWD7Fi7ChmwLCxjc=; b=OPYk/32JCjgYGQrqjxae0tui+D
	qXYN7H+Z4qEBXJZfHTaG7W8ABdtR41p0qY4y7hhK+CNlhxopgf4EIF4xPUc7rdvZXGvMY4ifAxFA/
	jGikpsQL4xNqKDBjQw941jCb1cqAMQ8HX0ZhtCkPpT/Anu1Eua14JiXDwXkPQB7QTYCghwY0/cQJl
	ARTHXB8gSDKBN1k96kI1lq5se19V3E0SbolT4oP1NpWMdlCGMrV6vrVpG+b/Rq6iHZ0QT1/UVQmDj
	vAZHh9EbmKdPNz2n6xyzOHFosxftenHnc60bwmulpg8BnPRJErF/+qktAOunLXrtHS4ZoIXYbumz7
	3wi9dGhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54216)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twjlt-0003il-04;
	Mon, 24 Mar 2025 15:31:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twjlq-0002Le-11;
	Mon, 24 Mar 2025 15:31:22 +0000
Date: Mon, 24 Mar 2025 15:31:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 1/6] net: usb: lan78xx: Improve error
 handling in PHY initialization
Message-ID: <Z-F6ykGiKIOIoSY-@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319084952.419051-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 09:49:47AM +0100, Oleksij Rempel wrote:
>  	} else {
>  		if (!phydev->drv) {
>  			netdev_err(dev->net, "no PHY driver found\n");
> -			return NULL;
> +			return ERR_PTR(-EINVAL);
>  		}

Idly wondering why this driver cares whether the PHY has a driver or
not (it seemingly wants to exclude the generic driver.) Not a reason
to reject the patch, just curious.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

