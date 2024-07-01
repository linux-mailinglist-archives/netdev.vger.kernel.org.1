Return-Path: <netdev+bounces-108238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF691E784
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D60F1C2102E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B7171643;
	Mon,  1 Jul 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsO0rbk7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592C17108D;
	Mon,  1 Jul 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858573; cv=none; b=Va69InULllTKqgMPYoZ6HdReD2JmOXoNbVDQIOWEpKMRPwH5fNagAmHshC2nFko+pAWL1UxiWQG7kR8N85NIdlp4EoSynz7AnVl2iOkUbV5sz167W4NdAAjHj8Dz4eoTbfWtIVEbheHKaCWp0hstiWQPMIk6WQwddoNpGkY2GdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858573; c=relaxed/simple;
	bh=5a1GFZ8wTeAmz7Gve1fInYYY8617Pj1/rYITwooozAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSlIWofweIYRdVmDsWHMgarh2gp6QgB775K65zkkGIh9ZplK/LEZwCv1MHph2ksU728kAKJKOVibJTQGkm9k7DNcSsE38MT2c9ay3JMkUhOD7fXl5CSk4Fl/lGb+DLdwq344jMWwn+UottE0XyJaN8zox89RVfLNTlGdfaKeXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsO0rbk7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e743307a2so3805009e87.0;
        Mon, 01 Jul 2024 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858569; x=1720463369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJZJ7zT19bxaU2dwvEdo+FnNvTszCWJeMGSm2TuYY2E=;
        b=MsO0rbk76nJ2Z4wMz1R+dbelzQqCVLPMyrcP285wtMxV/LYVg/X4OQxg/gnvdXuTGr
         L/roWMyDzCJE+BUvCeJ/fnWaviicYFDnW+/OwXQLjatSG/HgVhRLRbWMfSjjeQlsAOsP
         VHYF4P5VqMoMaaD1K5nYz6MSYmAmx5+hVP9AidSzS/+JUOc/piRr9BPlIdO0haUL8+Gz
         vJ8y906NzQ7qDEdklxeIbfhpLydWNb/osfUK2PG3m4ZunoVtBtviE7olS6K+AOTJ1fEK
         8s845IYyWu6A/T+VQOEvLQyAHRAAj4tHwvBjIdNVEon4wmqaK2P1zpo97TtsOir7qhkA
         pv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858569; x=1720463369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJZJ7zT19bxaU2dwvEdo+FnNvTszCWJeMGSm2TuYY2E=;
        b=sajta7uZJauv3HomB594GvAgJkpxtrw+4YKYW9VWHp2qcRu9xz/g/pWNyWOLXC3ZYA
         lLeYEJTCJKNBFN3KhcuIj+CDbE9bNKf1mJDoXTi0A6NojUP304Q8NXWnMSPZ9q/CNtEs
         UEyA2MWOhuLmq36f+Pz7OY5K0iAGhOqhUwLcXszlqOBcbx7Zoa6gRVz5+b0/Sfml2M0Q
         r4OEO1txyA0z5EKo+my33lV+muwBrLqr9Y/HvRHxgmy7o23cloZpTENlLf0nxL9Direp
         IyrMKR8UjsVoSYWosYezcFlntZ4//ftYrTXZKsqlFPE/ksizS4uiTHybVVfeTmjM/Dt/
         8OEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkfoobA7hhh2NhCQpcUgbqxFjHOltdNSatVt1aD8yci+1LAyXXMs66Pn4q+Kvu/8AVIRMxXzwo2f0+bqpW/VlNQboEYGYWVfOT1WspKl4mDPguNygZjNqL7Gnjqz45U3nZ4vQ4DJtdZjlX1Usxxo8bjgbK05f4TcU056RELkhuOg==
X-Gm-Message-State: AOJu0Yx4aYIIwDKXpWZG+Nu3wYmWDcwuPSYhvU/MhXNxNT5syXgo39yo
	kF5CeaK+48pJcemqvngxiGOtPM+nmQ3xcab7bH9v6ZLKd3niuwli
X-Google-Smtp-Source: AGHT+IFy1GZqp5d4wTUhT8i3U0LfxaYFtX3JxbiO989hpXMUde3LZDuIRiLrbHtCmZ/RuLmN0hPjgw==
X-Received: by 2002:a05:6512:3b81:b0:52c:db0a:a550 with SMTP id 2adb3069b0e04-52e8270a7c9mr4943057e87.42.1719858568293;
        Mon, 01 Jul 2024 11:29:28 -0700 (PDT)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab100f2sm1497771e87.69.2024.07.01.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:29:27 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 05/10] net: pcs: xpcs: Introduce DW XPCS info structure
Date: Mon,  1 Jul 2024 21:28:36 +0300
Message-ID: <20240701182900.13402-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701182900.13402-1-fancer.lancer@gmail.com>
References: <20240701182900.13402-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The being introduced structure will preserve the PCS and PMA IDs retrieved
from the respective DW XPCS MMDs or potentially pre-defined by the client
drivers. (The later change will be introduced later in the framework of
the commit adding the memory-mapped DW XPCS devices support.)

The structure fields are filled in in the xpcs_get_id() function, which
used to be responsible for the PCS Device ID getting only. Besides of the
PCS ID the method now fetches the PMA/PMD IDs too from MMD 1, which used
to be done in xpcs_dev_flag(). The retrieved PMA ID will be from now
utilized for the PMA-specific tweaks like it was introduced for the
Wangxun TxGBE PCS in the commit f629acc6f210 ("net: pcs: xpcs: support to
switch mode for Wangxun NICs").

Note 1. The xpcs_get_id() error-handling semantics has been changed. From
now the error number will be returned from the function. There is no point
in the next IOs or saving 0xffs and then looping over the actual device
IDs if device couldn't be reached. -ENODEV will be returned if the very
first IO operation failed thus indicating that no device could be found.

Note 2. The PCS and PMA IDs macros have been converted to enum'es. The
enum'es will be populated later in another commit with the virtual IDs
identifying the DW XPCS devices which have some platform-specifics, but
have been synthesized with the default PCS/PMA ID.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced due to the commit adding the Wangxun
  TXGbe PCS support.
---
 drivers/net/pcs/pcs-xpcs.c   | 104 +++++++++++++++++------------------
 include/linux/pcs/pcs-xpcs.h |  28 ++++++----
 2 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index eefb5e1dbe21..6397dac82d1f 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -237,29 +237,6 @@ int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val)
 	return xpcs_write_vendor(xpcs, MDIO_MMD_PCS, reg, val);
 }
 
-static int xpcs_dev_flag(struct dw_xpcs *xpcs)
-{
-	int ret, oui;
-
-	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID1);
-	if (ret < 0)
-		return ret;
-
-	oui = ret;
-
-	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID2);
-	if (ret < 0)
-		return ret;
-
-	ret = (ret >> 10) & 0x3F;
-	oui |= ret << 16;
-
-	if (oui == DW_OUI_WX)
-		xpcs->dev_flag = DW_DEV_TXGBE;
-
-	return 0;
-}
-
 static int xpcs_poll_reset(struct dw_xpcs *xpcs, int dev)
 {
 	/* Poll until the reset bit clears (50ms per retry == 0.6 sec) */
@@ -684,7 +661,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 {
 	int ret, mdio_ctrl, tx_conf;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP | DW_EN_VSMMD1);
 
 	/* For AN for C37 SGMII mode, the settings are :-
@@ -722,7 +699,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	ret |= (DW_VR_MII_PCS_MODE_C37_SGMII <<
 		DW_VR_MII_AN_CTRL_PCS_MODE_SHIFT &
 		DW_VR_MII_PCS_MODE_MASK);
-	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		ret |= DW_VR_MII_AN_CTRL_8BIT;
 		/* Hardware requires it to be PHY side SGMII */
 		tx_conf = DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII;
@@ -744,7 +721,7 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	else
 		ret &= ~DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		ret |= DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL;
 
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
@@ -766,7 +743,7 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
 	int ret, mdio_ctrl, adv;
 	bool changed = 0;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE)
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
 		xpcs_write_vpcs(xpcs, DW_VR_XS_PCS_DIG_CTRL1, DW_CL37_BP | DW_EN_VSMMD1);
 
 	/* According to Chap 7.12, to set 1000BASE-X C37 AN, AN must
@@ -857,7 +834,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		ret = txgbe_xpcs_switch_mode(xpcs, interface);
 		if (ret)
 			return ret;
@@ -1229,44 +1206,66 @@ static void xpcs_an_restart(struct phylink_pcs *pcs)
 	}
 }
 
-static u32 xpcs_get_id(struct dw_xpcs *xpcs)
+static int xpcs_get_id(struct dw_xpcs *xpcs)
 {
 	int ret;
 	u32 id;
 
-	/* First, search C73 PCS using PCS MMD */
+	/* First, search C73 PCS using PCS MMD 3. Return ENODEV if communication
+	 * failed indicating that device couldn't be reached.
+	 */
 	ret = xpcs_read(xpcs, MDIO_MMD_PCS, MII_PHYSID1);
 	if (ret < 0)
-		return 0xffffffff;
+		return -ENODEV;
 
 	id = ret << 16;
 
 	ret = xpcs_read(xpcs, MDIO_MMD_PCS, MII_PHYSID2);
 	if (ret < 0)
-		return 0xffffffff;
+		return ret;
 
-	/* If Device IDs are not all zeros or all ones,
-	 * we found C73 AN-type device
+	id |= ret;
+
+	/* If Device IDs are not all zeros or ones, then 10GBase-X/R or C73
+	 * KR/KX4 PCS found. Otherwise fallback to detecting 1000Base-X or C37
+	 * PCS in MII MMD 31.
 	 */
-	if ((id | ret) && (id | ret) != 0xffffffff)
-		return id | ret;
+	if (!id || id == 0xffffffff) {
+		ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_PHYSID1);
+		if (ret < 0)
+			return ret;
+
+		id = ret << 16;
+
+		ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_PHYSID2);
+		if (ret < 0)
+			return ret;
 
-	/* Next, search C37 PCS using Vendor-Specific MII MMD */
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_PHYSID1);
+		id |= ret;
+	}
+
+	xpcs->info.pcs = id;
+
+	/* Find out PMA/PMD ID from MMD 1 device ID registers */
+	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID1);
 	if (ret < 0)
-		return 0xffffffff;
+		return ret;
 
-	id = ret << 16;
+	id = ret;
 
-	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_PHYSID2);
+	ret = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVID2);
 	if (ret < 0)
-		return 0xffffffff;
+		return ret;
+
+	/* Note the inverted dword order and masked out Model/Revision numbers
+	 * with respect to what is done with the PCS ID...
+	 */
+	ret = (ret >> 10) & 0x3F;
+	id |= ret << 16;
 
-	/* If Device IDs are not all zeros, we found C37 AN-type device */
-	if (id | ret)
-		return id | ret;
+	xpcs->info.pma = id;
 
-	return 0xffffffff;
+	return 0;
 }
 
 static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
@@ -1390,15 +1389,16 @@ static void xpcs_free_data(struct dw_xpcs *xpcs)
 
 static int xpcs_init_id(struct dw_xpcs *xpcs)
 {
-	u32 xpcs_id;
 	int i, ret;
 
-	xpcs_id = xpcs_get_id(xpcs);
+	ret = xpcs_get_id(xpcs);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
 		const struct dw_xpcs_desc *desc = &xpcs_desc_list[i];
 
-		if ((xpcs_id & desc->mask) != desc->id)
+		if ((xpcs->info.pcs & desc->mask) != desc->id)
 			continue;
 
 		xpcs->desc = desc;
@@ -1409,10 +1409,6 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 	if (!xpcs->desc)
 		return -ENODEV;
 
-	ret = xpcs_dev_flag(xpcs);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -1424,7 +1420,7 @@ static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 	if (!compat)
 		return -EINVAL;
 
-	if (xpcs->dev_flag == DW_DEV_TXGBE) {
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		xpcs->pcs.poll = false;
 		return 0;
 	}
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index e706bd16b986..1dc60f5e653f 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -9,11 +9,7 @@
 
 #include <linux/phy.h>
 #include <linux/phylink.h>
-
-#define NXP_SJA1105_XPCS_ID		0x00000010
-#define NXP_SJA1110_XPCS_ID		0x00000020
-#define DW_XPCS_ID			0x7996ced0
-#define DW_XPCS_ID_MASK			0xffffffff
+#include <linux/types.h>
 
 /* AN mode */
 #define DW_AN_C73			1
@@ -22,20 +18,30 @@
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
 
-/* device vendor OUI */
-#define DW_OUI_WX			0x0018fc80
+struct dw_xpcs_desc;
 
-/* dev_flag */
-#define DW_DEV_TXGBE			BIT(0)
+enum dw_xpcs_pcs_id {
+	NXP_SJA1105_XPCS_ID = 0x00000010,
+	NXP_SJA1110_XPCS_ID = 0x00000020,
+	DW_XPCS_ID = 0x7996ced0,
+	DW_XPCS_ID_MASK = 0xffffffff,
+};
 
-struct dw_xpcs_desc;
+enum dw_xpcs_pma_id {
+	WX_TXGBE_XPCS_PMA_10G_ID = 0x0018fc80,
+};
+
+struct dw_xpcs_info {
+	u32 pcs;
+	u32 pma;
+};
 
 struct dw_xpcs {
+	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
 	struct mdio_device *mdiodev;
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
-	int dev_flag;
 };
 
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.43.0


