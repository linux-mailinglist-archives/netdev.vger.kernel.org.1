Return-Path: <netdev+bounces-211911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F88B1C688
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F71162187
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673245C14;
	Wed,  6 Aug 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SlBqHmO2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6623E358;
	Wed,  6 Aug 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754485282; cv=none; b=NHt87+xAlkknHM66zvtYijwYfHcgs3+zvUFZw623zEXOasibDgSRq7FrTdZmbm/Dla8FiZUcnHFv3MzQysTlIoUUugYC93X7f6AFPOuRWbpyiEIYefPehzVW6Fyjnb4VsdKQWCRlj66eR0Tscu9zoCfFgNkYwHA3ppc4S0n8WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754485282; c=relaxed/simple;
	bh=ZNUXG2GvGCx2VZ5W4Qg1NTNoY1RcTQ2Omyt1UvC2aK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpmZft0lF4hUzC4kLTsmHPWDMMBO37SUmUEeSZSRzWqfgESYl4ye0kE+PBv2fGca3Wts2SXoam/OH0TAf5Ya7EvD3wX2PTgZreZWDbhw4ZDi7gSlZ+s2igSN8y92zeydNRjWVeUfZZZMT4qWuwfLJDEpWWZcgVEHdua7Z6gFrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SlBqHmO2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u8l9q58ZeHFderpggttge7hAv/WuaSueIaS+TqcUHkw=; b=SlBqHmO2/3GEayE4e7p2CmyOWH
	1NUi5JhhD4t0yyCOvl4izVxltdXZyf8PGO4e8eSK//M4QzAiLrdOYTi6UWVIPz5CLhGHpribUTMXr
	nkJdSFPTH4NOTESLbZGES0mS+h0y2K19Zxm2zpWg+YYCKSW2TBN9KpgnhN9ZDa43qqOsjOPZCBVHd
	ffXE1sUuZ4aT7oCJ2IKjMMdrRfaeb3jQiFd9VK4Vi7gGS804YP0ON6vKh+0PT9UMAHlUFOFXwWWuP
	Un0ykXP1vVeJOSYT8ViBZKw62M4z88ZzV/ZfAr895FolTwF3g6SUuSjqDcMKNgsdRVKEUdPcoAyxa
	HRCKBc3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujdlQ-0004Yx-2V;
	Wed, 06 Aug 2025 14:01:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujdlN-00077e-31;
	Wed, 06 Aug 2025 14:01:01 +0100
Date: Wed, 6 Aug 2025 14:01:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, o.rempel@pengutronix.de,
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 06, 2025 at 04:56:58PM +0800, Xu Yang wrote:
> Hi Russell,
> 
> On Wed, Aug 06, 2025 at 09:45:01AM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 06, 2025 at 04:29:31PM +0800, Xu Yang wrote:
> > > Not all phy devices have phy driver attached, so fix the NULL pointer
> > > dereference issue in phy_polling_mode() which was observed on USB net
> > > devices.
> > 
> > See my comments in response to your first posting.
> 
> Thanks for the comments!
> 
> Reproduce step is simple:
> 
> 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
>    DUB-E100 Fast Ethernet Adapter".
> 2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
>    device.
> 
> root@imx95evk:~# lsusb -t
> /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
>     |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> 
> 3. then the driver will create many mdio devices. 
> 
> root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
> devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
> devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
> devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
> devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f

This looks broken - please check what
/sys/bus/mdio_bus/devices/usb*/phy_id contains.

However, this patch should stop the oops. Please test and let me know
whether it works. Thanks.

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7556aa3dd7ee..e6a673faabe6 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -288,7 +288,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
 		return phydev->attached_dev && phydev->adjust_link;
 
 	/* phydev->phy_link_change is implicitly phylink_phy_change() */
-	return true;
+	return !!phydev->phy_link_change;
 }
 
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

