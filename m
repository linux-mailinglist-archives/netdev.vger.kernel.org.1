Return-Path: <netdev+bounces-181012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982CA83660
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C3E4A0512
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209A1CBEB9;
	Thu, 10 Apr 2025 02:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CB1E22E9;
	Thu, 10 Apr 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251608; cv=none; b=bsF5WJk8jmfMNUTaVMlpOHUVvTT2HVwW6PVr9wyipjnvTvziuEINt305ZC5TV7AjuOnKxAlV2HRgcyL3fEi0+IddOiTinaMxrBxy/iRgkEd6NBimKQHzWiWypqn7Qpp9L1NNxm7HeSCpsLijzfwvQkZ/F95DuNm0t2bzJ5PnDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251608; c=relaxed/simple;
	bh=lEGW+Bw4xxorkIb+7Sie8pMeqAd+bZwBrGQPRx6W3Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8Z19kCJ4ncQgJdbRnEpf2xCL9pXiNC7iTlCTMXy5hxyCynPJ8HVsw7BfCBHnGkyNvGBI0c+vGfdMc0zdZZ0ZP65DYRaPLtk50pAtlN2WESDzpMfvvaHgvfRCKtJQaPSqlkT6m44Y1oBt892tiGwxeMGU9D9cR+ba3dLBCRMsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZY3N23N8GzHrDv;
	Thu, 10 Apr 2025 10:16:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 352AA1800EE;
	Thu, 10 Apr 2025 10:19:58 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 10:19:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v3 1/7] net: hibmcge: fix incorrect pause frame statistics issue
Date: Thu, 10 Apr 2025 10:13:21 +0800
Message-ID: <20250410021327.590362-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250410021327.590362-1-shaojijie@huawei.com>
References: <20250410021327.590362-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The driver supports pause frames,
but does not pass pause frames based on rx pause enable configuration,
resulting in incorrect pause frame statistics.

like this:
mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
	-p 64 -c 100

ethtool -S enp132s0f2 | grep -v ": 0"
NIC statistics:
     rx_octets_total_filt_cnt: 6800
     rx_filt_pkt_cnt: 100

The rx pause frames are filtered by the MAC hardware.

This patch configures pass pause frames based on the
rx puase enable status to ensure that
rx pause frames are not filtered.

mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
        -p 64 -c 100

ethtool --include-statistics -a enp132s0f2
Pause parameters for enp132s0f2:
Autonegotiate:	on
RX:		on
TX:		on
RX negotiated: on
TX negotiated: on
Statistics:
  tx_pause_frames: 0
  rx_pause_frames: 100

Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v1 -> v2:
  - Add more details in commit log, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/
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


