Return-Path: <netdev+bounces-215050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6227FB2CE82
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A237A97A5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C031CA5B;
	Tue, 19 Aug 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="PcZA0hqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607C343D99
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755638966; cv=none; b=u797o56YOOkfIIqafd/PTum9z8qRryzV9tEZFIqmXh05x3UefN/TqBEjJBRXJZpM7SWZ8rT/U191VnQ0ZtQBKFot5pGMgNU6v1F1bxyB0lTGnF8/cDAIhhe7cLTbf4Pni79MFAx3PtGGiLyrJ5nQAegIxWzGfFqog+fChIUpaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755638966; c=relaxed/simple;
	bh=VPYppmP8+N68IfWTMKDY6CCdjcacnp4h/5+7AGXFxYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3Dk/Y86QCHXO6T/+HZwn6GJdpiUOIXnQ2k/FusrmMs7bjR1li98UcPeIrnTOcn8hzhsCChMf02F+/Mi1Xntr+Wrjuq8pNghZ2aFNxvWBxJSE3T7h+6cwTxTv1DxAN+IrMcCvgIpBYy9wRWzI9AScEMa3K9m+WIar2qqQivwHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=PcZA0hqe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso5099565b3a.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1755638964; x=1756243764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7aCI6yzk8DM4TwNhCoALXUsVJxPXQENSR97a0plBk5E=;
        b=PcZA0hqe6cn7TIPegIsvworY7zmTuDFpS97455LIQHoDX6CyFuduE6hONDT0d4e51w
         7ZLGGMHR3lDjXAqSZ7l8EN4+B0xWvSmZYpf/VOQRs/8zQqJgYqWIZF4cI18Er4qDE+Tn
         GaUnvFN81PeVV47pA1C4OAStEaPFXeg7jxrliXIO+COqdOcmuIp2VwVA+eBnjfhr+Fcy
         EW729xzbhgSUjMTKcoBOQXmcYZ6grqWCD27+kYekKyMJHbCL2I5BVs9bjAsSEMhLxIAx
         GNo1/4TLFEobhCJQ4X20mb/Tdogd48U8sTU10/kswKK2Jk8NS5+SgIqVQy1SiWADGWG4
         pyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755638964; x=1756243764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aCI6yzk8DM4TwNhCoALXUsVJxPXQENSR97a0plBk5E=;
        b=O3wk/yRXnwQpSz3kLQLLJGgoY4l6shPHXDxOZwgJFxbRTKLVKAGTIZR+NTY7rrijHh
         li5bef0o28RFrZaaa7RrqaU1UcHw210weFeOmVPWDrQ1L8UPCxt3QbShLU1NhYCgamct
         sUpYIIsqKw+UhIuV2TqBD0mZRlYHXp1IiZUSLD5z7BhCtXdzd4htMFLWJI3AhtuPaW7z
         IA/Z6SASPXUMMGNJ52QxUtEJFPR5yeMLo00csjL9CTC1PbG5+A9SNjixEobw/BC4rxn+
         fUAHFjOXxwtYfHTH88Rxcec9nEzJDv4j/7pebnYV1FrLCh6XYCxChHXrjORphceQfpRf
         Rl2g==
X-Gm-Message-State: AOJu0Yw/dwnPzS/QRV0x8ZW7V9gk4UaKvP4VRXME7elTnJU2Rw1UyYE2
	di8o6JCDlJetriXy+X4/cF3kRDQ3/SSB2f2P/8K2bWi2M9by1ueZTV0JvGKlezgRhN4eq9OtCaL
	8AhbKCAL7TPQwpIniB1uzYWCpvpx36Iw1FsgyZ0/5iTbWcaojurA7UIzfqczJtIn8N/mjCKB5rG
	CO9tXL9kJ8uxsPV4qFgteTan3O1AA8i4OaHEP40+XUWFWtrA==
X-Gm-Gg: ASbGncu9I5vadB72UQU5JmOYy4QxbLu0YNZeGBKe+ywlKBfJT6cqsy5q3r9oXnOLq01
	XPBv2Nd95CIckdduIMv85VZ7YWDx0DcVWERkML+Na6upyZMLkGxOWiglsr3InyfNQGFGyA+yWTG
	siKLP+O0zjXpRq1TX4ji4+SRsF98gTxNe0u+Wts9YZqFpx7a1Cmfjnvo5A0vzkMGE6R+3z+S/YY
	nKWaQ4wye5whsHygRB/e9FxFgl3PbO7IOd/CYbTN9umr1ewTdNn+Be6Q0MCLXm4THx277wvLFVk
	/9IOgr8m7i/QPuS/Dan+lgSJSQRk+CJQ2NdN1vdQKJBl6BnWJzHC2iJ02irL+peA9M4k/cgiFxn
	oGdT152+DoGpVO9s4CEAe9UMw4IVIi6P410TYR/o87hQeKXgkTUUqCFnwex2d
X-Google-Smtp-Source: AGHT+IEKLLXBhvdqQ9DkLGqLweL2RAop/TOGgN/7svtAkHa4dIHH00EQWAnZUSDMdmZp5bWblOASSg==
X-Received: by 2002:a05:6a20:3d87:b0:240:30c:274a with SMTP id adf61e73a8af0-2431b82b45dmr1046597637.18.1755638964116;
        Tue, 19 Aug 2025 14:29:24 -0700 (PDT)
Received: from ievenbach-5SCQ9Y3.taila24ae5.ts.net ([2607:fb91:8284:c7ef:144e:d365:b3ff:ef2f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e2625749sm127792a91.14.2025.08.19.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:29:23 -0700 (PDT)
From: "Ilya A. Evenbach" <ievenbach@aurora.tech>
To: netdev@vger.kernel.org
Cc: "Ilya A. Evenbach" <ievenbach@aurora.tech>
Subject: [PATCH] [88q2xxx] Add support for handling master/slave in forced mode
Date: Tue, 19 Aug 2025 14:29:01 -0700
Message-Id: <20250819212901.1559962-1-ievenbach@aurora.tech>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

88q2xxx PHYs have non-standard way of setting master/slave in
forced mode.
This change adds support for changing and reporting this setting
correctly through ethtool.

Signed-off-by: Ilya A. Evenbach <ievenbach@aurora.tech>
---
 drivers/net/phy/marvell-88q2xxx.c | 107 ++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index f3d83b04c953..1ab450056e86 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -9,6 +9,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/hwmon.h>
 #include <linux/marvell_phy.h>
+#include <linux/mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 
@@ -118,6 +119,11 @@
 #define MV88Q2XXX_LED_INDEX_TX_ENABLE			0
 #define MV88Q2XXX_LED_INDEX_GPIO			1
 
+/* Marvell vendor PMA/PMD control for forced master/slave when AN is disabled */
+#define PMAPMD_MVL_PMAPMD_CTL				0x0834
+#define MASTER_MODE					BIT(14)
+#define MODE_MASK					BIT(14)
+
 struct mv88q2xxx_priv {
 	bool enable_led0;
 };
@@ -377,13 +383,57 @@ static int mv88q2xxx_read_link(struct phy_device *phydev)
 static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
 {
 	int ret;
+	int adv_l, adv_m, stat, stat2;
+
+	/* In forced mode, state and config are controlled via PMAPMD 0x834 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		ret = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_MVL_PMAPMD_CTL);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MASTER_MODE) {
+			phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
+			phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
+		} else {
+			phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
+			phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_FORCE;
+		}
+		return 0;
+	}
 
-	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
-	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
-	if (ret < 0)
-		return ret;
 
-	if (ret & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
+	adv_l = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L);
+	if (adv_l < 0)
+		return adv_l;
+	adv_m = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_M);
+	if (adv_m < 0)
+		return adv_m;
+
+	if (adv_l & MDIO_AN_T1_ADV_L_FORCE_MS)
+		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_FORCE;
+	else if (adv_m & MDIO_AN_T1_ADV_M_MST)
+		phydev->master_slave_get = MASTER_SLAVE_CFG_MASTER_PREFERRED;
+	else
+		phydev->master_slave_get = MASTER_SLAVE_CFG_SLAVE_PREFERRED;
+
+	stat = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
+	if (stat < 0)
+		return stat;
+
+	if (stat & MDIO_MMD_AN_MV_STAT_MS_CONF_FAULT) {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_ERR;
+		return 0;
+	}
+
+	stat2 = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT2);
+	if (stat2 < 0)
+		return stat2;
+	if (!(stat2 & MDIO_MMD_AN_MV_STAT2_AN_RESOLVED)) {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+		return 0;
+	}
+
+	if (stat & MDIO_MMD_AN_MV_STAT_LOCAL_MASTER)
 		phydev->master_slave_state = MASTER_SLAVE_STATE_MASTER;
 	else
 		phydev->master_slave_state = MASTER_SLAVE_STATE_SLAVE;
@@ -391,6 +441,34 @@ static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
 	return 0;
 }
 
+static int mv88q2xxx_setup_master_slave_forced(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
+					     PMAPMD_MVL_PMAPMD_CTL,
+					     MODE_MASK, MASTER_MODE);
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_PMAPMD,
+					     PMAPMD_MVL_PMAPMD_CTL,
+					     MODE_MASK, 0);
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
 static int mv88q2xxx_read_aneg_speed(struct phy_device *phydev)
 {
 	int ret;
@@ -448,6 +526,11 @@ static int mv88q2xxx_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Populate master/slave status also for forced modes */
+	ret = mv88q2xxx_read_master_slave_state(phydev);
+	if (ret < 0 && ret != -EOPNOTSUPP)
+		return ret;
+
 	return genphy_c45_read_pma(phydev);
 }
 
@@ -478,6 +561,20 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Configure Base-T1 master/slave per phydev->master_slave_set.
+	 * For AN disabled, program PMAPMD role directly; otherwise rely on
+	 * the standard Base-T1 AN advertisement bits.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		ret = mv88q2xxx_setup_master_slave_forced(phydev);
+		if (ret)
+			return ret;
+	} else {
+		ret = genphy_c45_pma_baset1_setup_master_slave(phydev);
+		if (ret)
+			return ret;
+	}
+
 	return phydev->drv->soft_reset(phydev);
 }
 
-- 
2.34.1


