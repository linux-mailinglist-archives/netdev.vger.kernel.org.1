Return-Path: <netdev+bounces-208565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5E9B0C2BB
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0103A4752
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48AA29B8D2;
	Mon, 21 Jul 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EFNzWCqH"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502828DB61;
	Mon, 21 Jul 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096869; cv=none; b=MsTe74N04Lb7mSf/Sj7AJhpDixZnm38gHZ87D8thS+IO4K60/Og7PfiZqnrJXumDPB5ImlFTYxcXkHS6j27PW0t8/9nZ8sm5nBYSvxGm9gLZCyoIXFAl1K5ZucE8iJGNLhyo0AGz9qYQLnUcrhfjULDYsLlG+kLBxBvzsuvcKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096869; c=relaxed/simple;
	bh=QlqcErhvXJnFXPQ6XDMHIJxmEdcRJXdlyYXZuJiJYik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XMZW5azeuiLYQWdDRQ+CciNAQRPm+ZClIrAvi1MlEoZpISFr9sw/S3XQaPo/ZPAN9KoGflQNRv23o7Ns0AVOO9UtKHPP38qslAVbi/8Lftmrd8baPWZcUSm0h+s7RC49TSjBBDLQ//T8cT7KaAMGmlcS3/RZG04tGk87w5Ki4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EFNzWCqH; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L96UQA017909;
	Mon, 21 Jul 2025 13:20:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1vvxFkwi2T8eGOtFKxrwUzKBICi5aNoTqQdzLMsYlNM=; b=EFNzWCqHZxTWVK2U
	U28uJnsMvOyw4Lkv1B0V4oEhNvM3FlxxCUQtks6GTk+nQIkZOhO7NU+BxBni+1lh
	/13fybd7OMBHmHmpacwzfukkM1RGln8xl6Gppax0VD31KMBIe8A7j2ETs5muc39a
	bJwiPpZ2nfjRNeU5rX3t7QDFqcUZcZir8g8RAwzYhF1fP8Myq283TMxcPsp6NLmu
	3h9VnrMtrwoR0szVNYRr2VdyrPbL2dg3+9+t5Pl0w8CPGqZhrUQUsaArN+lzNvkn
	G4nf7BMHzlGE1b6cdEWwW2DDit6sIJthez8K02dVCvAE4dn2sAmyzxrCl9pDY2CI
	xK1mpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4dmgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 13:20:46 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D222240050;
	Mon, 21 Jul 2025 13:19:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E2187A321C;
	Mon, 21 Jul 2025 13:17:48 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 13:17:48 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Mon, 21 Jul 2025 13:14:45 +0200
Subject: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
In-Reply-To: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Simon
 Horman <horms@kernel.org>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        Florian
 Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3389;
 i=gatien.chevallier@foss.st.com; h=from:subject:message-id;
 bh=QlqcErhvXJnFXPQ6XDMHIJxmEdcRJXdlyYXZuJiJYik=;
 b=owEB7QES/pANAwAKAar3Rq6G8cMoAcsmYgBofiHY6FFiv0Vu9Wazl1iqrvA9PHA7unw5zT+CV
 7ygpezNYiOJAbMEAAEKAB0WIQRuDsu+jpEBc9gaoV2q90auhvHDKAUCaH4h2AAKCRCq90auhvHD
 KNblC/9bbwmxJ5fRSONlv9Nq7MEeAaauC/7WrpgBpvZJNxIVhwyv+9J8U7wMNGcJurjdDt5aIN5
 d5DR3LnY4VOs4UyTUjbIsOBkSRvWg5nmgAV8A1hSqrSmVkUcFXlnj351S5seNk1owR0nq9ESc6G
 IRCdlKiU6s8+k7WN1Tf+s2puKsBkbf5SU+t/7ixwEquY2LBqT/UKL9H1NKrp8L0HM491D3OndUG
 mGVPF/5UBrE+2MIK9s0yoRpJwLA9duHs+Qp2hnJGneIYbZu03CqobPf9n573T2aAUDx8cZ7Bq2Z
 x4jfglXMwTT2F1RnFYX7Gb43l6iOSoiQRGwPoHSXSHWd8INfUQ0Oc3lLV7KUPWS+ArzfKq/6mif
 OdrtT5TbxUG7G1ZCoOa9rJQ66wPPVZP4CWh6UmPGKfV3X3MDsade9+CzLTMbQ3WFcDmXH92Hj5X
 2cqas/ExKtoCoI3mYA2OOzMDsDBRqvPVdumuXBO3zSSJCEWNkDqEybmRUDndd7kVO1neU=
X-Developer-Key: i=gatien.chevallier@foss.st.com; a=openpgp;
 fpr=6E0ECBBE8E910173D81AA15DAAF746AE86F1C328
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01

Add suspend()/resume() callbacks that do not shut down the PHY if the
WoL is supported and handle the WoL status flags.

If the WoL is supported by the PHY, indicate that the PHY device can
be a source of wake up for the platform. When setting the WoL
configuration, enable this capability.

Fixes: 8b305ee2a91c ("net: phy: smsc: add WoL support to LAN8740/LAN8742 PHYs")
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/phy/smsc.c  | 42 ++++++++++++++++++++++++++++++++++++++----
 include/linux/smscphy.h |  2 ++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b6489da5cfcdfb405457058dc88575c0d84d259d..cf4e763907aefd2d725c734d3e0f2926128f770e 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -537,14 +537,45 @@ static int lan874x_set_wol(struct phy_device *phydev,
 		}
 	}
 
-	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
-			   val_wucsr);
+	/* Enable wakeup on PHY device if at least one WoL feature is configured */
+	device_set_wakeup_enable(&phydev->mdio.dev, !!(val_wucsr & MII_LAN874X_PHY_WOL_MASK));
+
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR, val_wucsr);
 	if (rc < 0)
 		return rc;
 
 	return 0;
 }
 
+static int smsc_phy_suspend(struct phy_device *phydev)
+{
+	if (!phydev->wol_enabled)
+		return genphy_suspend(phydev);
+
+	return 0;
+}
+
+static int smsc_phy_resume(struct phy_device *phydev)
+{
+	int rc;
+
+	if (!phydev->wol_enabled)
+		return genphy_resume(phydev);
+
+	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
+	if (rc < 0)
+		return rc;
+
+	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
+		return 0;
+
+	dev_info(&phydev->mdio.dev, "Woke up from LAN event.\n");
+	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
+			   rc | MII_LAN874X_PHY_WOL_STATUS_MASK);
+
+	return rc;
+}
+
 static int smsc_get_sset_count(struct phy_device *phydev)
 {
 	return ARRAY_SIZE(smsc_hw_stats);
@@ -673,6 +704,9 @@ int smsc_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	if (phydev->drv->set_wol)
+		device_set_wakeup_capable(&phydev->mdio.dev, true);
+
 	/* Make clk optional to keep DTB backward compatibility. */
 	refclk = devm_clk_get_optional_enabled_with_rate(dev, NULL,
 							 50 * 1000 * 1000);
@@ -875,8 +909,8 @@ static struct phy_driver smsc_phy_driver[] = {
 	.set_wol	= lan874x_set_wol,
 	.get_wol	= lan874x_get_wol,
 
-	.suspend	= genphy_suspend,
-	.resume		= genphy_resume,
+	.suspend	= smsc_phy_suspend,
+	.resume		= smsc_phy_resume,
 } };
 
 module_phy_driver(smsc_phy_driver);
diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
index 1a6a851d2cf80d225bada7adeb79969e625964bd..cdf266960032609241afc8316da23f1c4834bfee 100644
--- a/include/linux/smscphy.h
+++ b/include/linux/smscphy.h
@@ -65,6 +65,8 @@ int smsc_phy_probe(struct phy_device *phydev);
 #define MII_LAN874X_PHY_WOL_WUEN		BIT(2)
 #define MII_LAN874X_PHY_WOL_MPEN		BIT(1)
 #define MII_LAN874X_PHY_WOL_BCSTEN		BIT(0)
+#define MII_LAN874X_PHY_WOL_MASK		GENMASK(4, 0)
+#define MII_LAN874X_PHY_WOL_STATUS_MASK		GENMASK(7, 4)
 
 #define MII_LAN874X_PHY_WOL_FILTER_EN		BIT(15)
 #define MII_LAN874X_PHY_WOL_FILTER_MCASTTEN	BIT(9)

-- 
2.35.3


