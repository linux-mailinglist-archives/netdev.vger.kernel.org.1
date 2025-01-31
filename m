Return-Path: <netdev+bounces-161788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D65EA23FE2
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D366161AA7
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFBA1E1C3A;
	Fri, 31 Jan 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H/2W58Ej"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B46E14F9F9;
	Fri, 31 Jan 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338597; cv=none; b=VNUBB1MbFzhUxhIWiQnkgtG/c+KNMdtjBOsXfgm+Wml9MSLNnSjMttoyYORn7TXiO5cLG3Q+SgNrSvs6lio6H5K96ORik7fG5GWRQiTknIjO3D0594bBoF4vKIhu5/N+fE/zPXY5UKpTilUsZLENtIfluk10r0KdWCBwiBW1PO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338597; c=relaxed/simple;
	bh=C/DVSGSxQVDX1sYfb54kbgi2Bhpn+X68IRQ1SpGOlxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ7gpD0U2hu67K8JtAeFKw5va67hzs5526qiNwBFWxWKmYDiCQCcGlAFbrdEV9w8qzZqnQpTchhrCo6sRKCTMX6aa6chGktXrAQHcHuU3vBMCgXd5fq7iuhxEp2SMxFswEhguyfNh7EaHMPmvV84/WhyEdk8taTAZbSpTIXGDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H/2W58Ej; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e/F9u+3cF2iLaOijLqsTbANw2pbfWuTYD44j+N6FGSw=; b=H/2W58Ejnvc7E+8MtzbZQNcaWd
	DIlslICtX5edxLWnOOTaCcHdDDWiIg3yim0Kiky8KclgvBIWZwigWkVF5P7Bp+NzQMExnIW643v/e
	1feCUH2eeT3fZBiw4Gh6DhQ+dws/8YmHp1mahPtys+T5eU86+4ql2nZiA5+Dh9/cwFhVSCkOJVL70
	RUUGweNl2cWRdIESdY8QXSTSHlYvtm20t90K5nOohzwxU6tRc77tshWe9M+X5L89t7RbemeKpY3Tl
	pX4LdlEfDX2x5Qap6Gjo42qFwCJRDAIPiSVq7PSbXVIBwM31xoqWECKDixd7F1uApXfDGQnB1nqm8
	6dVf+K+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40162)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdtGx-0007VU-2U;
	Fri, 31 Jan 2025 15:49:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdtGt-0005uV-1Y;
	Fri, 31 Jan 2025 15:49:31 +0000
Date: Fri, 31 Jan 2025 15:49:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Tristram.Ha@microchip.com" <Tristram.Ha@microchip.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sadhan Rudresh <Sadhan.Rudresh@synopsys.com>,
	Siddhant Kumar <Siddhant.Kumar@synopsys.com>
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Message-ID: <Z5zxC3hwk4C0s456@shell.armlinux.org.uk>
References: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
 <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
 <DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Pf0Rs55r4xv0C6MY"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--Pf0Rs55r4xv0C6MY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2025 at 02:36:49PM +0000, Jose Abreu wrote:
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Date: Thu, Jan 30, 2025 at 11:02:00
> 
> > Would it be safe to set these two bits with newer XPCS hardware when
> > programming it for 1000base-X mode, even though documentation e.g.
> > for SJA1105 suggests that these bits do not apply when operating in
> > 1000base-X mode?
> 
> It's hard to provide a clear answer because our products can all be modified
> by final customer. I hope this snippet below can help:
> 
> "Nothing has changed in "AN control register" ever since at least for a decade.
> Having said that, bit[4] and bit[3] are valid for SGMII mode and not valid
> for 1000BASE-X mode (I don't know why customer says 'serdes' mode.
> There is no such mode in ethernet standard). So, customer shall
> leave this bits at default value of 0.  Even if they set to 1, there is no
> impact (as those bits are not used in 1000BASE-X mode)."

Thanks for the reply Jose, that's useful.

Tristram, I think you need to talk to your hardware people to find out
where this requirement to set these two bits comes from as it seems it
isn't a property that comes from Synopsys' IP (I suppose unless your
IP is older than ten years.)

That said, Jose's response indicates that we can set these two bits
with impunity provided another of Synopsys's customers hasn't modified
their integration of XPCS to require these bits to be set to zero. So,
while I think we can do that unconditionally (as per the patch
attached) I think we need a clearer comment to state why it's being
done (and I probably need to now modify the commit message - this was
created before Jose's reply.)

So, I think given the last two patches I've sent, I believe I've
covered both of the issues that you have with XPCS:

1) the need to set bits 4 and 3 in AN control for 1000base-X in KSZ9477
   (subject to a better commit message and code comment, which will be
    dependent on your research as to where this requirement has come
    from.)

2) the lack of MAC_AUTO_SW support in KSZ9477 which can be enabled by
   writing DW_XPCS_SGMII_MODE_MAC_MANUAL to xpcs->sgmii_mode.

We now need to work out a way to identify this older IP. I think for
(2) we could potentially do something like (error handling omitted for
clarity):

	if (xpcs->sgmii_mode == DW_XPCS_SGMII_MODE_MAC_AUTO) {
		xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL,
			    DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW,
			    DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW);

		ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL);

		/* If MAC_AUTO_SW doesn't retain the MAC_AUTO_SW bit, then the
		 * XPCS implementation does not support this feature, and we
		 * have to manually configure the BMCR for the link parameters.
		 */
		if (ret >= 0 && !(ret & DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW))
			xpcs->sgmii_mode = DW_XPCS_SGMII_MODE_MAC_MANUAL;
	}

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--Pf0Rs55r4xv0C6MY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-xpcs-allow-1000BASE-X-to-work-with-older-XPCS-IP.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: xpcs: allow 1000BASE-X to work with older XPCS
 IP

Older XPCS IP requires SGMII_LINK and PHY_SIDE_SGMII to be set when
operating in 1000BASE-X mode even though the XPCS is not configured for
SGMII. An example of a device with older XPCS IP is KSZ9477.

We already don't clear these bits if we switch from SGMII to 1000BASE-X
on TXGBE - which would result in 1000BASE-X with the PHY_SIDE_SGMII bit
left set.

It is currently believed to be safe to set both bits on newer IP
without side-effects.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 13 +++++++++++--
 drivers/net/pcs/pcs-xpcs.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 29269d5c5f3a..cbd2bdd0fd55 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -745,9 +745,18 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 			return ret;
 	}
 
-	mask = DW_VR_MII_PCS_MODE_MASK;
+	/* Older XPCS IP requires PHY_MODE (bit 3) and SGMII_LINK (but 4) to
+	 * be set when operating in 1000BASE-X mode. See page 233
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf
+	 * "5.5.9 SGMII AUTO-NEGOTIATION CONTROL REGISTER"
+	 */
+	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_AN_CTRL_SGMII_LINK |
+	       DW_VR_MII_TX_CONFIG_MASK;
 	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
-			 DW_VR_MII_PCS_MODE_C37_1000BASEX);
+			 DW_VR_MII_PCS_MODE_C37_1000BASEX) |
+	      FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
+			 DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII) |
+	      DW_VR_MII_AN_CTRL_SGMII_LINK;
 
 	if (!xpcs->pcs.poll) {
 		mask |= DW_VR_MII_AN_INTR_EN;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index be8fab40b012..082933d1d485 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -61,6 +61,7 @@
 
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_CTRL_8BIT			BIT(8)
+#define DW_VR_MII_AN_CTRL_SGMII_LINK		BIT(4
 #define DW_VR_MII_TX_CONFIG_MASK		BIT(3)
 #define DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII	0x1
 #define DW_VR_MII_TX_CONFIG_MAC_SIDE_SGMII	0x0
-- 
2.30.2


--Pf0Rs55r4xv0C6MY--

