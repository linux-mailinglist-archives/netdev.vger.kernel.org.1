Return-Path: <netdev+bounces-209237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C44B0EC7A
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF0A1C267AB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA72777F2;
	Wed, 23 Jul 2025 07:55:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16404191493;
	Wed, 23 Jul 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257359; cv=none; b=KE8naGccEI0iTCBZTAJ7VFcZhc8e+AKVTBR3tvi2Qig8pIQ7VOOvAfAZ1MkCZgyM+MP2SqvuSZweRLuTdu4huX2mF8Bci3sxJJeTzran4SXbDeqRHFwy/HrMsroYQd3oqqf6G8M1s86MGz+bqcItWv/WZ1wxv80n0KNtADnQ2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257359; c=relaxed/simple;
	bh=ZTN5RivIRx/H0a44pKKMap2YEHiLVsrsyyjMHCenDUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SrWGp6FRV6OJJwUYFm0KlaCRRANxoRTaijagnqDW4YibHqEw3VjF9OE1Ae5ZD5d9a8nEiknx4F4+cwHdalUDDut67ZXjZ1HlwmK7mL2c7MJQkyKmwCIOHnoPG93SoY+RUPoaRAiRA0IO4uvCgCBStJIrB79dQlhfkITmtgqSWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bn5sr3Tcjz14M3V;
	Wed, 23 Jul 2025 15:50:56 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FDCB1402CC;
	Wed, 23 Jul 2025 15:55:46 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 15:55:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next] net: hibmcge: support for statistics of reset failures
Date: Wed, 23 Jul 2025 15:48:26 +0800
Message-ID: <20250723074826.2756135-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
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

Add a statistical item to count the number of reset failures.
This statistical item can be queried using ethtool -S or
reported through diagnose information.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h   | 1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c | 1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c      | 2 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 7725cb0c5c8a..ea09a09c451b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -258,6 +258,7 @@ struct hbg_stats {
 	u64 tx_dma_err_cnt;
 
 	u64 np_link_fail_cnt;
+	u64 reset_fail_cnt;
 };
 
 struct hbg_priv {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
index f23fb5920c3c..c0ce74cf7382 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
@@ -156,6 +156,7 @@ static const struct hbg_push_stats_info hbg_push_stats_list[] = {
 	HBG_PUSH_STATS_I(tx_drop_cnt, 84),
 	HBG_PUSH_STATS_I(tx_excessive_length_drop_cnt, 85),
 	HBG_PUSH_STATS_I(tx_dma_err_cnt, 86),
+	HBG_PUSH_STATS_I(reset_fail_cnt, 87),
 };
 
 static int hbg_push_msg_send(struct hbg_priv *priv,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index ff3295b60a69..503cfbfb4a8a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -68,6 +68,7 @@ static int hbg_reset_prepare(struct hbg_priv *priv, enum hbg_reset_type type)
 	clear_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
 	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_RESET);
 	if (ret) {
+		priv->stats.reset_fail_cnt++;
 		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
 		clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	}
@@ -88,6 +89,7 @@ static int hbg_reset_done(struct hbg_priv *priv, enum hbg_reset_type type)
 	clear_bit(HBG_NIC_STATE_RESETTING, &priv->state);
 	ret = hbg_rebuild(priv);
 	if (ret) {
+		priv->stats.reset_fail_cnt++;
 		set_bit(HBG_NIC_STATE_RESET_FAIL, &priv->state);
 		dev_err(&priv->pdev->dev, "failed to rebuild after reset\n");
 		return ret;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 55520053270a..1d62ff913737 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -84,6 +84,7 @@ static const struct hbg_ethtool_stats hbg_ethtool_stats_info[] = {
 			HBG_REG_TX_EXCESSIVE_LENGTH_DROP_ADDR),
 	HBG_STATS_I(tx_dma_err_cnt),
 	HBG_STATS_I(tx_timeout_cnt),
+	HBG_STATS_I(reset_fail_cnt),
 };
 
 static const struct hbg_ethtool_stats hbg_ethtool_rmon_stats_info[] = {
-- 
2.33.0


