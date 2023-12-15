Return-Path: <netdev+bounces-57979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0D814A91
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4231F23D48
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF81856;
	Fri, 15 Dec 2023 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TXY+ixfw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49870111C;
	Fri, 15 Dec 2023 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=43Gh+m/twnEm+7XuRxlnacCXYn8PBvARAyFAEY78f7k=; b=TXY+ixfw8BpUL7W34m9jOJt65I
	MUTdE6oaT/yDXBCi8Ud+JozmM/hOz28nH71uiWar4kRrQm4ajLj+0kM6adpO2hBS3ndxlB+exlnNV
	TnDtVERWjpPisXUkBr8V2P+DNJ9JeE86NMMk5suEmrvDFh6OM1G7c7d+cj6ah+vcLcbKitZotpusL
	eItoJqMXPBOrR4W4l9wBV7Zt0nut4Vd6jOGqv05tftd1ZoalZLaJtBQLiYcV18T+8Ku5ycM8JeVnN
	F9CwAyXEm+6a2LzvyAKgBxexKGpm7z+NIunPaTyADF1cWvzt/jsBUKAsHGAxX0YyAgB7+fj6c6FD8
	45mzITaw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41496)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rE9GJ-0002mk-17;
	Fri, 15 Dec 2023 14:33:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rE9GK-0003gF-UA; Fri, 15 Dec 2023 14:34:00 +0000
Date: Fri, 15 Dec 2023 14:34:00 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, kabel@kernel.org, hkallweit1@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <ZXxj2FMiAMEV0ZGM@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
 <627fbf7d-5992-4c4b-9e32-b34e363db928@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627fbf7d-5992-4c4b-9e32-b34e363db928@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 03:30:09PM +0100, Andrew Lunn wrote:
> On Thu, Dec 14, 2023 at 09:14:39PM +0100, Tobias Waldekranz wrote:
> > When probing, if a device is waiting for firmware to be loaded into
> > its RAM, ask userspace for the binary and load it over XMDIO.
> 
> Does a device without firmware have valid ID registers?

Yes it does - remember one of the ZII dev boards had a 3310 without
firmware, and that can be successfully probed by the driver, which
is key to my userspace tooling being able to access the PHY (since
userspace can only access devices on MDIO buses that are bound to
a netdev.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

