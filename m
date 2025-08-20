Return-Path: <netdev+bounces-215380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E4EB2E4BC
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117CB3BF605
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C02749EA;
	Wed, 20 Aug 2025 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="juFswRBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD282741CD
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713563; cv=none; b=P6cTvGqC92u6IXOql/4GB2+YNq/eYo9Ar2SOLnN67iQ7NwErA1shQGVt7loqaEdpQDrJ0Bcsb7pHKPEALwy3jlaMISzslV4CNc96gFBijfxXtvPDKEqfuBXHwMnat804+CgLleQyVjhlsTwwXZ8iJPDlriGNS6+C9zaNLb4uNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713563; c=relaxed/simple;
	bh=O5r4hFv4YuQlnE2jM2bevX9aGytCAvxxQJ1OmG9Jxhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAOhi0T42hFzyA2ifU/obBnmM/U2L6qZAKXYuUJNj1sdv6logNCASXhC2JtoWJyBYXNDe5oNEzGIHH91eP2FvUHtvbewIjC8EzOku8izmBCaYid6u4IawI+qV/H/8g+FzeDlSfUv57XmwcbxEivd/8SfVQg1MzGe1mXpIdVKKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=juFswRBx; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e8704cdc76so10426785a.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1755713561; x=1756318361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAOBCRGqGCCBkeFxC7EldyD/HmHmyvwXkM6ohZosHXc=;
        b=juFswRBxOC++ONrdHDp4Pjv6ZWZ/4UbloHT5YPxHJdfbedDs0/tgv2kmCvQau8M1Wx
         FguxITH5LHxNCLE0vsgQ5henEbTA2vWOkUT9SINPtKATFozexcTPrL/8ojJsZyXdSbTw
         Qf2WAGe4/TiFCD5FgydrMcxbNdZsIlmaXVdtkUncd9y/O44hWSRGR9Ytw+59cWiBxBAd
         o4coCfdIl76VFu85JGlseuaDZ6nSPPzzI0SWSC75jYENT8ecSRgFaCB2anxqBLRxd0bf
         QOkNyyMFlK7B8Wt9ncl3U7qKLELcLMJgQvbOiTsxJG5zFmLPS2fr3c4gcq0THlA1BvgW
         qukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713561; x=1756318361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAOBCRGqGCCBkeFxC7EldyD/HmHmyvwXkM6ohZosHXc=;
        b=odGYGiX2I41NvsMLuvNJYl+bYF1X1VFhPU8SiuixQSUcFjc+EiAxJoIyETNNNhNaYT
         C67hD7fbwEyXE9gRMBo19u2/0fKp80kPWBaiXnDc9tYRS2I1K0xkjvMLUMLzy9r7eH/b
         AurYUWDB4iiY+fBNTuGhxwJn5p7DZESviS75X/EFmTbmNbqU4DduoMwZfP06Wigf3Ht3
         SYWnhV9VfSe4APnUFPphT2HE1zXzWM6N/lpOS/xaLLOaNAihZ43WAJ9egxaNYFJm/2ON
         F0AFT6S+6sNbTJbsXTMHTo10o0nAykQEI62cu9xDcW9ATyuY9FkI8tmufDL5ecM5TEuR
         EkDA==
X-Gm-Message-State: AOJu0YxCbHkTMWChSeDE2G7UH/65ZU3N9P90qiICXotjQ7+I35VQUihR
	LuFon2uIimbvjHG8Vao06uqyRcLLUFjg12xKLl1gfypkNRsvA+UqCfHk/c+VgHX1I7TxXrAmWD7
	MA1L107qhDhFHx7fIBUYzZLm3XRInGInDyIbNvxWpEraI4HFSaKiojv+qfJxqQvRMatKqqRHTNZ
	73H3Xvt/LIOdIpgJJz36ZbDUawkszjs2Ij+Fhc0eAjJR7xGA==
X-Gm-Gg: ASbGncuMItwYHvukLtexu9vT2KeIJORKpMYDEBfkfUTC8CIt2BRF4WR8f7L2JiT3K3G
	SoKVuCoJxWWE4NLJplexv3v7JkqT1jdvLRb/Yk2bnRdIeqR5UZr6hEkLmVwcvtcFVjmBtmWyDxL
	4sfr70suyGXKRHf69i3D/i36SKEyWbRc7ldfk/S3aNSMuf53tNCPOt904mWfdheYvzLSl16YfeO
	S4dt5bb9OmAbyrr2hXfqfs+6Zhy1A3ajCLE9wKv44cwhcIEjVvHn1dGmh1h72HDWaQ9Vok7uwVy
	BKu7KCOGXLFDg+L/RXAWGBL3RzodEmB5LFsmIoRED4belNQN4u3bnwVM2wB2aggKZeC7lX6U9kb
	D0i0gaOpKYcGnifdGccIHFwvXvFMEB4cDLSqB8qKvoxWxNK9nE3joTnqzpCbfcnoddK3P3Q==
X-Google-Smtp-Source: AGHT+IHvq9WywHqiGo37LA+8/LL1+UriT6iTRElDQGIej36jKBSkbEsq3LGOE9cGPwaMhN+nPodV9w==
X-Received: by 2002:a05:620a:44d6:b0:7e9:f820:2b72 with SMTP id af79cd13be357-7e9fcbd0c6fmr450683385a.72.1755713560740;
        Wed, 20 Aug 2025 11:12:40 -0700 (PDT)
Received: from ievenbach-5SCQ9Y3.taila24ae5.ts.net ([2607:fb91:8201:920:c1f5:e65a:cf92:2a6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c56e9sm967134985a.67.2025.08.20.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:12:40 -0700 (PDT)
From: "Ilya A. Evenbach" <ievenbach@aurora.tech>
To: netdev@vger.kernel.org
Cc: dima.fedrau@gmail.com,
	"Ilya A. Evenbach" <ievenbach@aurora.tech>
Subject: [PATCH] [88q2xxx] Add support for handling master/slave in forced mode
Date: Wed, 20 Aug 2025 11:11:43 -0700
Message-Id: <20250820181143.2288755-2-ievenbach@aurora.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820181143.2288755-1-ievenbach@aurora.tech>
References: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
 <20250820181143.2288755-1-ievenbach@aurora.tech>
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
 drivers/net/phy/marvell-88q2xxx.c | 106 ++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index f3d83b04c953..b94d574fd9b7 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -118,6 +118,11 @@
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
@@ -377,13 +382,57 @@ static int mv88q2xxx_read_link(struct phy_device *phydev)
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
@@ -391,6 +440,34 @@ static int mv88q2xxx_read_master_slave_state(struct phy_device *phydev)
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
@@ -448,6 +525,11 @@ static int mv88q2xxx_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Populate master/slave status also for forced modes */
+	ret = mv88q2xxx_read_master_slave_state(phydev);
+	if (ret < 0 && ret != -EOPNOTSUPP)
+		return ret;
+
 	return genphy_c45_read_pma(phydev);
 }
 
@@ -478,6 +560,20 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
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


