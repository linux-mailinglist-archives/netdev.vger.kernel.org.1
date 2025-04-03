Return-Path: <netdev+bounces-179054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E274A7A485
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114881771CB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882624EA8F;
	Thu,  3 Apr 2025 13:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841924E4A7;
	Thu,  3 Apr 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688776; cv=none; b=j9LDZMmaE+cyn/VNlioHcoVcGrs0b45/43fbMhdYM5vFO2I3so+VFAuVBuDbDiN91VSTGC9C/ATmrfuvwd/vTjqfAQW3VlBJxNL2Ct4XJdOa1Ue5lat52Nxt8FZvHHVq9+TsHtkqzDkOPte1L7OYkAlD3Q7eZ//XHhKIgxqK0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688776; c=relaxed/simple;
	bh=phohLvRdRa714i8FH/81n8i7pd4IZURhE1ZhxleuVbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWadovJFftvKk/CvXpIh83EwhI8mii4O0jwfw0I9UKo5XNvmCb/J10fTHVFJQ9SQBufS6cuPBXlzqCIZhoAOMvZXCqRSdJgnlkN6d3HXULWmiC9OLN+IkiJejl0AMC1yoXptEJn6BDbG5vGLkXbIvKbMBDIP787bVYWyAZZETCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZT3K12SRrz27hFP;
	Thu,  3 Apr 2025 22:00:05 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 04DAD1A0188;
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
Subject: [PATCH net v2 1/7] net: hibmcge: fix incorrect pause frame statistics issue
Date: Thu, 3 Apr 2025 21:53:05 +0800
Message-ID: <20250403135311.545633-2-shaojijie@huawei.com>
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


