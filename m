Return-Path: <netdev+bounces-201387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDFFAE93E9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A894A1EB2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377751DEFD2;
	Thu, 26 Jun 2025 02:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D31C84D6;
	Thu, 26 Jun 2025 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750903984; cv=none; b=iZ08rNyqEUV1cDmGLwTHQUtuX7MX/6nWUJ5E2aHHVd0+Qi2aTmWUGk5vfF+Xmcn22Lb5CT3fqtSv/UaBGQqOK0JEerOo9p/uNq2IWsKvKHUvIKgLrueltPd/gIEMwqtQY/+XhhhlX9AO9TJz7jGR/vciMSI4S/kyjEwyVCtUXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750903984; c=relaxed/simple;
	bh=T9HkFnDBMvtvh+rx8Kod6hT1Ps6qQGtTGTjHSzPg5hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiEy1bVfbVMZ0tgt6kD9cW6NMRJGi6aueXYDApap6gX2X1pLBRGoxs8tiwc5LwLwQUt8ZSpqtZvLHmHDD5uvA0VsI3Zk4JHtPXjP1Lo2X4mZr9rpLFnSClnFNs/UrUuo517ahfEo6V85qxnZJb44XpZgoX9GhFcdECYf2zh4EWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bSMcV1V9Wz2BdVy;
	Thu, 26 Jun 2025 10:11:22 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E6E37140109;
	Thu, 26 Jun 2025 10:12:59 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 10:12:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH v3 net-next 3/3] net: hibmcge: configure FIFO thresholds according to the MAC controller documentation
Date: Thu, 26 Jun 2025 10:06:13 +0800
Message-ID: <20250626020613.637949-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250626020613.637949-1-shaojijie@huawei.com>
References: <20250626020613.637949-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Configure FIFO thresholds according to the MAC controller documentation

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v1 -> v2:
  - Fix code formatting errors, reported by Jakub Kicinski
  v1: https://lore.kernel.org/all/20250619144423.2661528-1-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 49 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  6 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 6e5602591554..8cca8316ba40 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -18,6 +18,13 @@
 #define HBG_ENDIAN_CTRL_LE_DATA_BE	0x0
 #define HBG_PCU_FRAME_LEN_PLUS 4
 
+#define HBG_FIFO_TX_FULL_THRSLD		0x3F0
+#define HBG_FIFO_TX_EMPTY_THRSLD	0x1F0
+#define HBG_FIFO_RX_FULL_THRSLD		0x240
+#define HBG_FIFO_RX_EMPTY_THRSLD	0x190
+#define HBG_CFG_FIFO_FULL_THRSLD	0x10
+#define HBG_CFG_FIFO_EMPTY_THRSLD	0x01
+
 static bool hbg_hw_spec_is_valid(struct hbg_priv *priv)
 {
 	return hbg_reg_read(priv, HBG_REG_SPEC_VALID_ADDR) &&
@@ -272,6 +279,41 @@ void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr)
 	hbg_reg_write64(priv, HBG_REG_FD_FC_ADDR_LOW_ADDR, mac_addr);
 }
 
+static void hbg_hw_set_fifo_thrsld(struct hbg_priv *priv,
+				   u32 full, u32 empty, enum hbg_dir dir)
+{
+	u32 value = 0;
+
+	value |= FIELD_PREP(HBG_REG_FIFO_THRSLD_FULL_M, full);
+	value |= FIELD_PREP(HBG_REG_FIFO_THRSLD_EMPTY_M, empty);
+
+	if (dir & HBG_DIR_TX)
+		hbg_reg_write(priv, HBG_REG_TX_FIFO_THRSLD_ADDR, value);
+
+	if (dir & HBG_DIR_RX)
+		hbg_reg_write(priv, HBG_REG_RX_FIFO_THRSLD_ADDR, value);
+}
+
+static void hbg_hw_set_cfg_fifo_thrsld(struct hbg_priv *priv,
+				       u32 full, u32 empty, enum hbg_dir dir)
+{
+	u32 value;
+
+	value = hbg_reg_read(priv, HBG_REG_CFG_FIFO_THRSLD_ADDR);
+
+	if (dir & HBG_DIR_TX) {
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_FULL_M, full);
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M, empty);
+	}
+
+	if (dir & HBG_DIR_RX) {
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_FULL_M, full);
+		value |= FIELD_PREP(HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M, empty);
+	}
+
+	hbg_reg_write(priv, HBG_REG_CFG_FIFO_THRSLD_ADDR, value);
+}
+
 static void hbg_hw_init_transmit_ctrl(struct hbg_priv *priv)
 {
 	u32 ctrl = 0;
@@ -332,5 +374,12 @@ int hbg_hw_init(struct hbg_priv *priv)
 
 	hbg_hw_init_rx_control(priv);
 	hbg_hw_init_transmit_ctrl(priv);
+
+	hbg_hw_set_fifo_thrsld(priv, HBG_FIFO_TX_FULL_THRSLD,
+			       HBG_FIFO_TX_EMPTY_THRSLD, HBG_DIR_TX);
+	hbg_hw_set_fifo_thrsld(priv, HBG_FIFO_RX_FULL_THRSLD,
+			       HBG_FIFO_RX_EMPTY_THRSLD, HBG_DIR_RX);
+	hbg_hw_set_cfg_fifo_thrsld(priv, HBG_CFG_FIFO_FULL_THRSLD,
+				   HBG_CFG_FIFO_EMPTY_THRSLD, HBG_DIR_TX_RX);
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index d40880beb2f8..a39d1e796e4a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -141,7 +141,13 @@
 /* PCU */
 #define HBG_REG_TX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0420)
 #define HBG_REG_RX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0424)
+#define HBG_REG_FIFO_THRSLD_FULL_M		GENMASK(25, 16)
+#define HBG_REG_FIFO_THRSLD_EMPTY_M		GENMASK(9, 0)
 #define HBG_REG_CFG_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0428)
+#define HBG_REG_CFG_FIFO_THRSLD_TX_FULL_M	GENMASK(31, 24)
+#define HBG_REG_CFG_FIFO_THRSLD_TX_EMPTY_M	GENMASK(23, 16)
+#define HBG_REG_CFG_FIFO_THRSLD_RX_FULL_M	GENMASK(15, 8)
+#define HBG_REG_CFG_FIFO_THRSLD_RX_EMPTY_M	GENMASK(7, 0)
 #define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
 #define HBG_INT_MSK_WE_ERR_B			BIT(31)
 #define HBG_INT_MSK_RBREQ_ERR_B			BIT(30)
-- 
2.33.0


