Return-Path: <netdev+bounces-199517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B1AE0938
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D724D1882635
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CED23D282;
	Thu, 19 Jun 2025 14:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78121E0AF;
	Thu, 19 Jun 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344693; cv=none; b=QynGPt0oo/g/24XX/F9pXZXWa2RA4wG+e2iZ30OoKuhrQFgX5uuwTQUxCnSHC+9n+pcX3rVbN/uh4H5L6mJJPvFOZ/VCVuVSMRgj2tW7b/6/PIOFaSdfRiGtzYgeHLj7ea52pXMLFlY6m01EVZ+gDcymhbWxfI3gr1C++Mlv3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344693; c=relaxed/simple;
	bh=qt/+ct1EsDxJroNT5S6IwbORgIaQ5BsRcdhUMcdxPrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJAy741NHSHNlBSFc0Eh75AqHaL/qGOHsrBq7Ozip7df9G882IqpjqrvfOd8XmGEa2mWeJ7XOF1HwH97q6Vw4Bqa3KoTdCuteDU90WG2WVA7MbW3tkDlKGAPOT8pqHdEh/aJJQ/H87ib5Z/4IBJx6EKPjeGhNZK8xW/OZ6wvEU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bNNjs1bXDzRkdD;
	Thu, 19 Jun 2025 22:47:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 22205180B6A;
	Thu, 19 Jun 2025 22:51:30 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Jun 2025 22:51:29 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 2/3] net: hibmcge: adjust the burst len configuration of the MAC controller to improve TX performance.
Date: Thu, 19 Jun 2025 22:44:22 +0800
Message-ID: <20250619144423.2661528-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250619144423.2661528-1-shaojijie@huawei.com>
References: <20250619144423.2661528-1-shaojijie@huawei.com>
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


