Return-Path: <netdev+bounces-161637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DCA22D0A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075831665B5
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B11E3DD6;
	Thu, 30 Jan 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UzAa4dDE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630D1E3DD3;
	Thu, 30 Jan 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738241113; cv=none; b=chEJm3L/272fmbW7IkRihQXMZACbweu0debVfTtL/U55+fAoH1v7hFUzr0Cc32IC1Zhk45LHjVeJTF3QDe3Nc77DGSO64bmMh3JTn6MjPyOYqXqhxDdx1qn0IyjZoWl1bJTk5+cMWLBGrx9iWEb0OaiD/JLyd2d3PT+8HSGYoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738241113; c=relaxed/simple;
	bh=JeH6TP90agPXAVPb1kklv3jyQbjCgZEtCOGIrN9TGHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RozO+NQzYvkEsQ7gNRchVl2kwA2QGdsbFtbnYQQoil7B4FdWpdZbR9zQJbhCi+wcYr/Xv/nzGt6LHspBtEKHNiTsKwDJCUNRix+aafqeEqZmxS8Uve6yVa8LNrLJdcf0oTOSwJCWnxlZB8WfzLDNeBozCuP+3bLEtCGc2fpKvfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UzAa4dDE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IjcD3JS62CmN07AaBtyvm82C7ufperoua9ZZEG+8E0I=; b=UzAa4dDEsOmsaDpL4E/ak9zOkL
	BKIdbvKf8gwLxT8w3BaOlwHdCGpUS/Cj1Xfjn2zxuSyuDc1G05+T7AAxEYZHhUFs4Ze2B4hpwgH/S
	/u63yPJRiZo72G/V5Z3PeXmaYa1zY+1/eO6QhvZLc9CRNVMbAf4+osGKJBfv+0ycgLRNmFfDnnLnQ
	P0ECvy2fQs2BViHe53HZJ8YfJaHzzKBwUnnqV651B35iAaqd2ShvG2VI99wuHVVRJ0N2D64dTBOx5
	+tO3K9vJ3JpeECpQiIRJvKVP27jN7rOe8eglbHj/59+JS5hz1rh3ezkQQRrkkFCZkIRppL6BhSH1N
	+OrMHVhw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdTuj-00049j-1Q;
	Thu, 30 Jan 2025 12:44:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdTug-0004lY-1p;
	Thu, 30 Jan 2025 12:44:54 +0000
Date: Thu, 30 Jan 2025 12:44:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5t0RvoUOhxqeh25@shell.armlinux.org.uk>
References: <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <20250129230549.kwkcxdn62mghdlx3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zkRfgM4TtTI/x6kM"
Content-Disposition: inline
In-Reply-To: <20250129230549.kwkcxdn62mghdlx3@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--zkRfgM4TtTI/x6kM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2025 at 01:05:49AM +0200, Vladimir Oltean wrote:
> On Wed, Jan 29, 2025 at 10:05:20PM +0000, Russell King (Oracle) wrote:
> > For Vladimir: I've added four hacky patches that build on top of the
> > large RFC series I sent earlier which add probably saner configuration
> > for the SGMII code, hopefully making it more understandable in light
> > of Wangxun's TXGBE using PHY mode there (they were adamant that their
> > hardware requires it.) These do not address Tristram's issue.
> 
> Ok, let's sidetrack Tristram's thread, sure.

... and this is no longer a side track, because one of the changes in
Tristram's patches is to manually update the BMCR register on link-up
in SGMII mode, because the older XPCS hardware doesn't support
MAC_AUTO_SW. So, here's a patch that splits DW_XPCS_SGMII_MODE_MAC
introduced in the last patch into an _AUTO and _MANUAL variant.

The intention is - once we work out how to detect the older hardware -
that instead of DW_XPCS_SGMII_MODE_MAC_AUTO being used, Tristram sets
DW_XPCS_SGMII_MODE_MAC_MANUAL, which will attempt to clear MAC_AUTO_SW
(it's not clear to me that this can be done given the information that
Tristram has mentioned thus far - but I don't think that matters) and
xpcs_link_up_sgmii_1000basex() will program the BMCR.

This gives us a single control to enable this behaviour, rather than
introducing a quirk for it. Setting DW_XPCS_SGMII_MODE_MAC_MANUAL with
newer hardware allows these code paths to be tested there as well.

See the attached patch, which builds on top of the four already sent.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--zkRfgM4TtTI/x6kM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-xpcs-add-support-for-manual-update-for-SGMII.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: xpcs: add support for manual update for SGMII

Older revisions of the XPCS IP do not support the MAC_AUTO_SW flag and
need the BMCR register updated with the speed information from the PHY.
Split the DW_XPCS_SGMII_MODE_MAC mode into _AUTO and _MANUAL variants,
where _AUTO mode means the update happens in hardware autonomously,
whereas the _MANUAL mode means that we need to update the BMCR register
when the link comes up.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c |  9 +++++++--
 drivers/net/pcs/pcs-xpcs.h | 11 ++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e7aad3c402a4..f23193d1115a 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -691,11 +691,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
 	switch (xpcs->sgmii_mode) {
-	case DW_XPCS_SGMII_MODE_MAC:
+	case DW_XPCS_SGMII_MODE_MAC_AUTO:
 		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 			val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 		break;
 
+	case DW_XPCS_SGMII_MODE_MAC_MANUAL:
+		break;
+
 	case DW_XPCS_SGMII_MODE_PHY_HW:
 		val |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 		fallthrough;
@@ -1123,7 +1126,9 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 {
 	int ret;
 
-	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED &&
+	    !(interface == PHY_INTERFACE_MODE_SGMII &&
+	      xpcs->sgmii_mode == )
 		return;
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 4bd6a82f1a18..be8fab40b012 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -112,8 +112,12 @@ enum dw_xpcs_sgmii_10_100 {
 };
 
 /* The SGMII mode:
- * DW_XPCS_SGMII_MODE_MAC: the XPCS acts as a MAC, reading and acknowledging
- * the config word.
+ * DW_XPCS_SGMII_MODE_MAC_AUTO: the XPCS acts as a MAC, accepting the
+ * parameters from the PHY end of the SGMII link and acknowledging the
+ * config word. The XPCS autonomously switches speed.
+ *
+ * DW_XPCS_SGMII_MODE_MAC_MANUAL: the XPCS acts as a MAC as above, but
+ * does not autonomously switch speed.
  *
  * DW_XPCS_SGMII_MODE_PHY_HW: the XPCS acts as a PHY, deriving the tx_config
  * bits 15 (link), 12 (duplex) and 11:10 (speed) from hardware inputs to the
@@ -125,7 +129,8 @@ enum dw_xpcs_sgmii_10_100 {
  * integration documentation states that MII_ADVERTISE must be written last.
  */
 enum dw_xpcs_sgmii_mode {
-	DW_XPCS_SGMII_MODE_MAC,		/* XPCS is MAC on SGMII */
+	DW_XPCS_SGMII_MODE_MAC_AUTO,	/* XPCS is MAC, auto update */
+	DW_XPCS_SGMII_MODE_MAC_MANUAL,	/* XPCS is MAC, manual update */
 	DW_XPCS_SGMII_MODE_PHY_HW,	/* XPCS is PHY, tx_config from hw */
 	DW_XPCS_SGMII_MODE_PHY_REG,	/* XPCS is PHY, tx_config from regs */
 };
-- 
2.30.2


--zkRfgM4TtTI/x6kM--

