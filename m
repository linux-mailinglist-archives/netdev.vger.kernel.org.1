Return-Path: <netdev+bounces-179051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE26A7A47C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42083B73A8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F324EAAE;
	Thu,  3 Apr 2025 13:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E324E4A7;
	Thu,  3 Apr 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688771; cv=none; b=NKAwcgD6qR01z+bQnjDETEo5T2KPIf4fLgeAJ1ybmUOiCdn0h83HgNfQYTC5fr6A/dn2BI7YseW/sABfEN7C8rvb/z1QpuzbYAtcjmB0xLVdpS9Q8R682taHXddQGSQXbnow3Fycezexi/AffSX4Msn4xLQisFIYu2eTUODy5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688771; c=relaxed/simple;
	bh=vzCXWZGzihP3BhWZ8/TdNt8+q3fIshrw7ROTfyrMnUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEtsKEdoEMsaq1YFT5RDyMHq2KpCPDXwlBgmLsfbm2aM8T5P2mi9jyqIIlrFgNZWs0KBoKosGP9DqFxKxBb/hMhfGJvQ7fWlmAFNbEyL2onGBlRC1gFYov2Jwt4ZTD51qIs6rGazLLC133yK1rB7S/WA1T1NPtsnjB19k2/q0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZT3Hd38n1z1d12M;
	Thu,  3 Apr 2025 21:58:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 98A3D180087;
	Thu,  3 Apr 2025 21:59:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Apr 2025 21:59:25 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v2 2/7] net: hibmcge: fix incorrect multicast filtering issue
Date: Thu, 3 Apr 2025 21:53:06 +0800
Message-ID: <20250403135311.545633-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250403135311.545633-1-shaojijie@huawei.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The driver does not support multicast filtering,
the mask must be set to 0xFFFFFFFF. Otherwise,
incorrect filtering occurs.

This patch fixes this problem.

Fixes: 37b367d60d0f ("net: hibmcge: Add unicast frame filter supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c  | 4 ++++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 7d3bbd3e2adc..9b65eef62b3f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -234,6 +234,10 @@ void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable)
 {
 	hbg_reg_write_field(priv, HBG_REG_REC_FILT_CTRL_ADDR,
 			    HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B, enable);
+
+	/* only uc filter is supported, so set all bits of mc mask reg to 1 */
+	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_MSK_0, U64_MAX);
+	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_MSK_1, U64_MAX);
 }
 
 void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index fd623cfd13de..a6e7f5e62b48 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -135,6 +135,8 @@
 #define HBG_REG_STATION_ADDR_HIGH_4_ADDR	(HBG_REG_SGMII_BASE + 0x0224)
 #define HBG_REG_STATION_ADDR_LOW_5_ADDR		(HBG_REG_SGMII_BASE + 0x0228)
 #define HBG_REG_STATION_ADDR_HIGH_5_ADDR	(HBG_REG_SGMII_BASE + 0x022C)
+#define HBG_REG_STATION_ADDR_LOW_MSK_0		(HBG_REG_SGMII_BASE + 0x0230)
+#define HBG_REG_STATION_ADDR_LOW_MSK_1		(HBG_REG_SGMII_BASE + 0x0238)
 
 /* PCU */
 #define HBG_REG_TX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0420)
-- 
2.33.0


