Return-Path: <netdev+bounces-178813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F32A7903E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835853B64FC
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A3A23ED74;
	Wed,  2 Apr 2025 13:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FF23E25F;
	Wed,  2 Apr 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601572; cv=none; b=cbvcwKVNW9ddUy1VtXzwCrLy8+JVWURdqjWXEZcvxf0cK1CNAwItoStWpuElCLrbHs+nkvgpTXHgGpWm5lc2UuPgkJtj+yPzIeW6D3qq3J8ASN7Mv6w4umDp0YapHdv+ACj1DMGbL7tvAgKborA6uP79Jani2bHYKBNZTBNgg2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601572; c=relaxed/simple;
	bh=Fdn9AAEzZ/hRD8VFHR5kDD+c58oSI5O0nLvr2r3Mcc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjZkFPG/PqPKkyHZ96KoZeh1X21NM7oH5FE7cZzFf6BRhFQowpCS+aLh7jLk1PF5xWBseUJ8QU5IxI1iXnh/vs8VZY1Mya1em9HAq0cBFbs4OrVi275HgQmGcvuC8sLHRNt7FhU8EwhrHdQALAMFrEBFFM5gwIdqMAJWcGRsYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZSQxh5K21z1f0vT;
	Wed,  2 Apr 2025 21:41:12 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CE20F1A016C;
	Wed,  2 Apr 2025 21:46:01 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 21:46:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 1/7] net: hibmcge: fix incorrect pause frame statistics issue
Date: Wed, 2 Apr 2025 21:38:59 +0800
Message-ID: <20250402133905.895421-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402133905.895421-1-shaojijie@huawei.com>
References: <20250402133905.895421-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The driver supports pause frames,
but does not pass pause frames based on rx pause enable configuration,
resulting in incorrect pause frame statistics.

This patch fixes this problem.

Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c  | 3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 74a18033b444..7d3bbd3e2adc 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -242,6 +242,9 @@ void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
 			    HBG_REG_PAUSE_ENABLE_TX_B, tx_en);
 	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
 			    HBG_REG_PAUSE_ENABLE_RX_B, rx_en);
+
+	hbg_reg_write_field(priv, HBG_REG_REC_FILT_CTRL_ADDR,
+			    HBG_REG_REC_FILT_CTRL_PAUSE_FRM_PASS_B, rx_en);
 }
 
 void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index cc2cc612770d..fd623cfd13de 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -68,6 +68,7 @@
 #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
 #define HBG_REG_REC_FILT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0064)
 #define HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B	BIT(0)
+#define HBG_REG_REC_FILT_CTRL_PAUSE_FRM_PASS_B	BIT(4)
 #define HBG_REG_RX_OCTETS_TOTAL_OK_ADDR		(HBG_REG_SGMII_BASE + 0x0080)
 #define HBG_REG_RX_OCTETS_BAD_ADDR		(HBG_REG_SGMII_BASE + 0x0084)
 #define HBG_REG_RX_UC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0088)
-- 
2.33.0


