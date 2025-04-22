Return-Path: <netdev+bounces-184767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE5A971D7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A193B14BD
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDD527C859;
	Tue, 22 Apr 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n7oFJI4W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24927815F
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337839; cv=none; b=HCFS5mr22YlZJF1MTMuR0KqM/UzPQ3QdrNiqNV5dZqxFSos5iuSLRX/HYTr0uZ5wv5PBcpF1G1cIT1amo+ssUDnoZD+bbNtpUYBTCOfxZGBPCoCYa8Y+8lzypaWrFxK9sNoaZ9PyHt+73/0ryL8i64dCfT8BFb/4jkiwf3/DuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337839; c=relaxed/simple;
	bh=UNnhvLP7zIb5IJPg1Tnki+zvvtQrfIX980UlR7/FUfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFfgNUOPkjKvZcn9XAdfGc8fAdSc1V+70BY0sNX3z+NnRb1EmPvEG4R2wZyaNuAAbw5MLHLGE+faIEcaTibA7gYeM8S0w2VVe+pVi0XD5qVrtDB4dtpeeyrkLtBI8SVy1Udx/O1YuiYxsuHJ64vAGfKUeiJu3/wa6UjxScshAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n7oFJI4W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qJTeiDhJ/WU7DbPen9gCUpOHDGJpW9QAvy7lOs5acwQ=; b=n7oFJI4WqKOu9+eVmJtqHXOVB3
	JTIVy23JI8bH8OPl6Mz309ZOVFRTYODek7sIIX9YFVW7Z+r6MHkHXPJ8mtDkGS1p0M2T0MGTti99k
	Faa9DIsszbBqTzeRXUG/MyUS5G5FjtL9/Au3W3bjzFbeW6hEHUUM81B6a1W26v7/+BU1tyH/It2Qa
	nHom0TZAiFC8pvGpSnGo9NrvXn5FRDAexrTT7VL4FkeizKRhyMPw9XSY5LFN+oUAY3koiZOXOAlj3
	J6S8wOJYEioUn65n/JyR70aSXhE3HKaEB5r5xaVCUByXGWmEk0Cz90yTERtG3MCMWoyjuYoh3yjBg
	/bDc9G1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7G69-0004hZ-2X;
	Tue, 22 Apr 2025 17:03:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7G66-0007bk-0A;
	Tue, 22 Apr 2025 17:03:46 +0100
Date: Tue, 22 Apr 2025 17:03:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mathew McBride <matt@traverse.com.au>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
Message-ID: <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 18, 2025 at 01:02:19PM +1000, Mathew McBride wrote:
> #regzbot introduced: 6561f0e547be221f411fda5eddfcc5bd8bb058a5
> 
> Hi Russell,
> 
> On Thu, Dec 5, 2024, at 8:42 PM, Russell King (Oracle) wrote:
> > Report the PCS in-band capabilities to phylink for the Lynx PCS.
> > 
> 
> The implementation of in-band capabilities has broken SFP+ (10GBase-R) mode on my LS1088 board.
> The other ports in the system (QSGMII) work fine.

Thanks for the report.

Please try the diff below:

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bdd5d8bb5b0..2147e2d3003a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3624,6 +3624,15 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 	phylink_dbg(pl, "optical SFP: chosen %s interface\n",
 		    phy_modes(interface));
 
+	/* GBASE-R interfaces with the exception of KR do not have autoneg at
+	 * the PCS. As the PCS is media facing, disable the Autoneg bit in the
+	 * advertisement.
+	 */
+	if (interface == PHY_INTERFACE_MODE_5GBASER ||
+	    interface == PHY_INTERFACE_MODE_10GBASER ||
+	    interface == PHY_INTERFACE_MODE_25GBASER)
+		__clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
+
 	if (!phylink_validate_pcs_inband_autoneg(pl, interface,
 						 config.advertising)) {
 		phylink_err(pl, "autoneg setting not compatible with PCS");

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

