Return-Path: <netdev+bounces-92086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55C8B5553
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A25328509E
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA393A8F7;
	Mon, 29 Apr 2024 10:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536CB376E5
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386478; cv=none; b=WVCsL4TW+stQtOPaC7CSnUvkfOncOHLTx3YcYMzcv5COlPsiS6gTLYjYjxNiObc8sjSvKRM3bOO0kNdzH+BslYr4S56xHnCI579iMwmQwWBqKguus3hJf4turOpb7N4SlF9LoZpdll19k2dLJdju8vVjUW196cDU288RzwXhnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386478; c=relaxed/simple;
	bh=UaMBmkSzMlXtIhCmidFFj12rxYatUMvs6mUquUoxlPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvCZZfkqO/azN6nGGv9fh5xIXjGb8FH2PT66vElMkX+bXcuNwhvGYwmIBfjlBDEqSkgFLvUQZL9JjA87Zl8zkml70hZwW7Pe4gIIXNB+21Ms7RTohWHMnUNfsOzYqYwHtw7yb/FY+qPW/AG0BpuSEv++cM1TxPEcjn2llTW46uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1714386339t0llpj
X-QQ-Originating-IP: wozpXTH8htOrqX5xRKb2U5mF/dcj7Wg2xVyVyc/GgZs=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.150.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2024 18:25:38 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: vCKdglClpVLcXH785aEIaSaMN7q6Vlb3mW/XLq0Azyw5Czm7FcNslx4ARfjWr
	R6stC+dwqW9zFXwCiL/VlCIkWFn2eGp8frAIoRU9dhyum4iXC5mVttU24CrTdEnqsLBpBxI
	Go0om3JG3kbrMYnJ5u3N6DI7mbsiBSvzRflT7TiSF5lWwbCpiuUbX1BrXGF7v78UM+tJonH
	tVK+epniN00FU9q2d+TRvfc0gEgzXvZYGnIicbGsyzugmqqELqxi/tw9ESIE35++zgZzN3c
	Zq2LYBuLM5GDYk1YZfNnOAJTLQPGCcQZc+RlNyraPCnznHL7uCpruqj9WcnPRMp3ALGYDws
	HDJnPeeFaxMS7Z5071fuUwWtmOzOaylJhkKhqcm1kLeCw73T6pdw2OF9P/mT0aQlYe3NcDo
	UO4bFsvTUS+I0/qvch35tA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8311698413773401071
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 1/4] net: wangxun: fix the incorrect display of queue number in statistics
Date: Mon, 29 Apr 2024 18:25:16 +0800
Message-Id: <20240429102519.25096-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240429102519.25096-1-jiawenwu@trustnetic.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When using ethtool -S to print hardware statistics, the number of
Rx/Tx queues printed is greater than the number of queues actually
used.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index cc3bec42ed8e..803c7f1da9a4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -59,9 +59,12 @@ static const struct wx_stats wx_gstrings_stats[] = {
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct wx *wx = netdev_priv(netdev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return WX_STATS_LEN;
+		return WX_STATS_LEN - (WX_NUM_RX_QUEUES - wx->num_tx_queues) *
+		       (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -70,6 +73,7 @@ EXPORT_SYMBOL(wx_get_sset_count);
 
 void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
+	struct wx *wx = netdev_priv(netdev);
 	u8 *p = data;
 	int i;
 
@@ -77,11 +81,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
 			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
-		for (i = 0; i < netdev->num_tx_queues; i++) {
+		for (i = 0; i < wx->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
 		}
-		for (i = 0; i < WX_NUM_RX_QUEUES; i++) {
+		for (i = 0; i < wx->num_rx_queues; i++) {
 			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
 		}
@@ -107,7 +111,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
-	for (j = 0; j < netdev->num_tx_queues; j++) {
+	for (j = 0; j < wx->num_tx_queues; j++) {
 		ring = wx->tx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
@@ -122,7 +126,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
-	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
+	for (j = 0; j < wx->num_rx_queues; j++) {
 		ring = wx->rx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
@@ -177,13 +181,8 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
-	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES) {
-		info->n_stats = WX_STATS_LEN -
-				   (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
-				   (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
-	} else {
-		info->n_stats = WX_STATS_LEN;
-	}
+	info->n_stats = WX_STATS_LEN - (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
+			(sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
 
-- 
2.27.0


