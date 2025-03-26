Return-Path: <netdev+bounces-177821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D5DA71E79
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988B31763B7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4923FC54;
	Wed, 26 Mar 2025 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DY1KRstn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6649659;
	Wed, 26 Mar 2025 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013989; cv=none; b=FaN/sCyO2i601MwgiEoEJgQMxpImGk7NX8WY4tmUV7/ayWzd1KDKXcnFkhTwX7JDNTLZaJAtFFdS3QeXjyRBAkQx41rwuCNAwyjQQHbyq4DabrI+janmJbfQbVaE2rRGhQh0GhgF6wLqOzoK/1oeqUUlSbKKNN2qgjyyTwC37hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013989; c=relaxed/simple;
	bh=H0WXYCkOruHYlRYfNbikAmGGuU6Z90xa4UIW4J8YeYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqPW+S7JvUzMsWMZluXtC3xldz6KUTrKeN52iIUk3joc4W+TUMKPlkrI4mhyyTutKEOuD6Ch0+cD/1BOjxLIY08LxNWTAty9tviBsL4aajZr9peMjhVKLBCQC++4kwR++vTj/XQvqXqTv0SJ70754L1xybt0vXijO6txUlTFLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DY1KRstn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ryEB0XASAK2pygu+vzvMr1XOWAUfXVnhydu7SRIwMUY=; b=DY1KRstnirVjWnobv2tNwEo6CQ
	awzsx1zrrP7fw2PPlf2/tlxDUtE1WR5pygD/tXvXwOm5jV4rEZm5VvdDGEoG5Pcm5gHoJTTL5NPxl
	rYkxjqLz3XQ4tNhE/O2WdlXXYjCqh0lHub5AGZqrrVVlAK3YAtzHsBDrf3rCl4tvOMVKxvfcDs1yX
	N89GZAcWfGZXmFzzWtYc10y7wSJWYXKBtGXnjq+3FtK6AYLkiHdY2ZLOC53tHQldMt5oP5jj8I1JK
	aGdRtLZmf62R3FHjozjHmOgeB8qrktWabgkAPxWs1vrKRua5GQHjejhthtgCM956tpKX8Ky+dL+C0
	rKYbzVDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txVYe-0006SW-2z;
	Wed, 26 Mar 2025 18:32:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txVYc-0004dJ-1m;
	Wed, 26 Mar 2025 18:32:54 +0000
Date: Wed, 26 Mar 2025 18:32:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <Z-RIVkVOgpzTjKZv@shell.armlinux.org.uk>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
 <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
 <Z-RCiWzRWbv7RlHJ@shell.armlinux.org.uk>
 <67e444e6.050a0220.81044.004e@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e444e6.050a0220.81044.004e@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 26, 2025 at 07:18:12PM +0100, Christian Marangi wrote:
> On Wed, Mar 26, 2025 at 06:08:09PM +0000, Russell King (Oracle) wrote:
> > An alternative would be to change the match_phy_device() method to
> > pass the phy_driver, which would allow a single match_phy_device
> > function to match the new hardware ID values against the PHY IDs in
> > the phy_driver without needing to modify the IDs in phy_device.
> > 
> 
> I also considered extending the function with additional stuff but then
> I considered that would mean rework each PHY driver and destroy PHY
> driver downstream, not something we should care but still quite a big
> task. If the -ENODEV path is not OK, I feel an additional OP is better
> than tweaking match_phy_device.

For those in the kernel, 8 files, 26 initialisers.

drivers/net/phy/nxp-c45-tja11xx.c can probably be simplified with
this idea, reducing it down to a pair of functions.

drivers/net/phy/bcm87xx.c can probably be reduced to one match function.

So, doing so would appear to bring benefits to other PHY drivers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

