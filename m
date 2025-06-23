Return-Path: <netdev+bounces-200117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EDAE3410
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA15618913D1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA7151990;
	Mon, 23 Jun 2025 03:48:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B7A933;
	Mon, 23 Jun 2025 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750650503; cv=none; b=H7ATbyRC02FIfVC0+trB0z1JGHC2Bf1dZaPPaNTFm8hADp31d0Y6ppjRrdSEcsPLl2kMxcBErQQ5e/RpJo2Vt/gURSe7lHl/DGhIuyOA6ZlhAZP+T4LzKVjW+MmchpTTpJxZwM/URT4ETxqDdGRXodW1P2mAEvedt/nQ5Vfhd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750650503; c=relaxed/simple;
	bh=qt/+ct1EsDxJroNT5S6IwbORgIaQ5BsRcdhUMcdxPrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pViSAnnFALmxNPtxA8owx4Ha8yL+d36qjGMdFj25XHGcmwJ11L/pUX8OIX/Yb0E8EvNvU8DvF6NwsdwrISp9k7o+Y2bFeovkneRwSJ7x7hz5GOEgOnEDLVewQecRvXZmoyDYAxkL99v4dl/erpaGz7NOmd6kW2qjIXeQ3PjoMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bQYq75wFGzPt9m;
	Mon, 23 Jun 2025 11:44:19 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 94F8D1402E9;
	Mon, 23 Jun 2025 11:48:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 11:48:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 2/3] net: hibmcge: adjust the burst len configuration of the MAC controller to improve TX performance.
Date: Mon, 23 Jun 2025 11:41:28 +0800
Message-ID: <20250623034129.838246-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623034129.838246-1-shaojijie@huawei.com>
References: <20250623034129.838246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Adjust the burst len configuration of the MAC controller
to improve TX performance.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c  | 8 ++++++++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 9b65eef62b3f..6e5602591554 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -168,6 +168,11 @@ static void hbg_hw_set_mac_max_frame_len(struct hbg_priv *priv,
 
 void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 {
+	/* burst_len BIT(29) set to 1 can improve the TX performance.
+	 * But packet drop occurs when mtu > 2000.
+	 * So, BIT(29) reset to 0 when mtu > 2000.
+	 */
+	u32 burst_len_bit = (mtu > 2000) ? 0 : 1;
 	u32 frame_len;
 
 	frame_len = mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
@@ -175,6 +180,9 @@ void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
 
 	hbg_hw_set_pcu_max_frame_len(priv, frame_len);
 	hbg_hw_set_mac_max_frame_len(priv, frame_len);
+
+	hbg_reg_write_field(priv, HBG_REG_BRUST_LENGTH_ADDR,
+			    HBG_REG_BRUST_LENGTH_B, burst_len_bit);
 }
 
 void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index eb50b202ca3a..310f8a74797d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -185,6 +185,8 @@
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
 #define HBG_REG_TX_CFF_ADDR_3_ADDR		(HBG_REG_SGMII_BASE + 0x0494)
 #define HBG_REG_RX_CFF_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x04A0)
+#define HBG_REG_BRUST_LENGTH_ADDR		(HBG_REG_SGMII_BASE + 0x04C4)
+#define HBG_REG_BRUST_LENGTH_B			BIT(29)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
-- 
2.33.0


