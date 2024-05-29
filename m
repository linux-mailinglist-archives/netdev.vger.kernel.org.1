Return-Path: <netdev+bounces-98940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B628D333F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F190E1C23ECC
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E04016A375;
	Wed, 29 May 2024 09:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC5167DB1
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975638; cv=none; b=J8rm+M+iaTuTTUsODxRWrPZw0n354zfQYeyYkmuoFezS/C9uCTF6xsqYH+zFBhg9GH3+cDuGbKSncn8scszoyGZNVff96XcLrwCJvTJT5Lm7s6RfOFBUmxParwbCBoTL9thnz7N0BInoJvSRtW51m48oaSOT+Pt1Cv2SOi8HM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975638; c=relaxed/simple;
	bh=H/68tBdX9mZemtxPe/ta6e4vNDJ6hIimSebhJYJMqmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQDSLPyu5SRjHHBZk/c2F2oa2TqFXBYYw3J2LbV0ji/1CQyETV2mxtsRg0wZEbC+Vp3yfsPlkfvXZhBb+hpOCWw0Yoj6rFm9Ex4EjnaP1PY9B/uC5YYwSlhYfXzUVXgO/4/DsZ7Xa61l73DXZ7H+vBgOSkXPm61MjbpqNFn5BX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1716975524t29538r1
X-QQ-Originating-IP: UchCiX1wO6EOrvBQzAXDugW/wmkLi2LugKwP2wYlqG4=
Received: from lap-jiawenwu.trustnetic.com ( [220.184.253.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 May 2024 17:38:42 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: +oIWmpEafD+viyCC52JvMo50EXZvB9D66O4Rp1tHhhuRxL2DbCuKzziig4HdZ
	ygeOkeDypW7huXoy4zmvgo0ALBPqAWJ1Mxme2YeGW6RbaSSHXXdFutbPpqg3ir0fiG/gqsw
	Xih3mK3/FD8hF8Y3uD8KKM8a7fuqa+nGaA/RgmAWU9UgqyUImTOvnyb6MyDQ3T+zlr/F76y
	L587pC/TgkYdD0YzxH6GmgyGqtyhmQbL1DnFMp1NRoso0NZKQ1ldkmSgy79dwHy5qo9DYQF
	jBOM/Hgp6gmLNJJhGrWtkpc7TI1MFLtY5kCntU6oLj7mSlxv7SAeMpT0xYSLOCKk2pw9epe
	95DTDjjG2K0t9wwnEa8Aq3UlW0jEEXQEjLbz7B+Hkg2TyMmUTR3O1OQ40OoOXBcOaaiTYY6
	7DiAZ3HptkID+qTJYwDMAA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4223801997178189703
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	justinstitt@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RFC net-next 3/3] net: txgbe: add FDIR info to ethtool ops
Date: Wed, 29 May 2024 17:38:21 +0800
Message-Id: <20240529093821.27108-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240529093821.27108-1-jiawenwu@trustnetic.com>
References: <20240529093821.27108-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add flow director filter match and miss statistics to ethtool -S.
And change the number of queues when using flow director for ehtool -l.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 39 +++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  5 +++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  4 ++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index cc3bec42ed8e..a6241091e95c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -43,6 +43,11 @@ static const struct wx_stats wx_gstrings_stats[] = {
 	WX_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
 };
 
+static const struct wx_stats wx_gstrings_fdir_stats[] = {
+	WX_STAT("fdir_match", stats.fdirmatch),
+	WX_STAT("fdir_miss", stats.fdirmiss),
+};
+
 /* drivers allocates num_tx_queues and num_rx_queues symmetrically so
  * we set the num_rx_queues to evaluate to num_tx_queues. This is
  * used because we do not have a good way to get the max number of
@@ -55,12 +60,17 @@ static const struct wx_stats wx_gstrings_stats[] = {
 		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
 		(sizeof(struct wx_queue_stats) / sizeof(u64)))
 #define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
+#define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
 #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct wx *wx = netdev_priv(netdev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
+		if (wx->mac.type == wx_mac_sp)
+			return WX_STATS_LEN + WX_FDIR_STATS_LEN;
 		return WX_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
@@ -70,6 +80,7 @@ EXPORT_SYMBOL(wx_get_sset_count);
 
 void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
+	struct wx *wx = netdev_priv(netdev);
 	u8 *p = data;
 	int i;
 
@@ -77,6 +88,10 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < WX_GLOBAL_STATS_LEN; i++)
 			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
+		if (wx->mac.type == wx_mac_sp) {
+			for (i = 0; i < WX_FDIR_STATS_LEN; i++)
+				ethtool_puts(&p, wx_gstrings_fdir_stats[i].stat_string);
+		}
 		for (i = 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
@@ -96,7 +111,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	struct wx_ring *ring;
 	unsigned int start;
-	int i, j;
+	int i, j, k;
 	char *p;
 
 	wx_update_stats(wx);
@@ -107,6 +122,14 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
+	if (wx->mac.type == wx_mac_sp) {
+		for (k = 0; k < WX_FDIR_STATS_LEN; k++) {
+			p = (char *)wx + wx_gstrings_fdir_stats[k].stat_offset;
+			data[i++] = (wx_gstrings_fdir_stats[k].sizeof_stat ==
+				   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
+		}
+	}
+
 	for (j = 0; j < netdev->num_tx_queues; j++) {
 		ring = wx->tx_ring[j];
 		if (!ring) {
@@ -172,17 +195,21 @@ EXPORT_SYMBOL(wx_get_pause_stats);
 
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 {
+	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
 
+	if (wx->mac.type == wx_mac_sp)
+		stats_len += WX_FDIR_STATS_LEN;
+
 	strscpy(info->driver, wx->driver_name, sizeof(info->driver));
 	strscpy(info->fw_version, wx->eeprom_id, sizeof(info->fw_version));
 	strscpy(info->bus_info, pci_name(wx->pdev), sizeof(info->bus_info));
 	if (wx->num_tx_queues <= WX_NUM_TX_QUEUES) {
-		info->n_stats = WX_STATS_LEN -
+		info->n_stats = stats_len -
 				   (WX_NUM_TX_QUEUES - wx->num_tx_queues) *
 				   (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
 	} else {
-		info->n_stats = WX_STATS_LEN;
+		info->n_stats = stats_len;
 	}
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
@@ -383,6 +410,9 @@ void wx_get_channels(struct net_device *dev,
 
 	/* record RSS queues */
 	ch->combined_count = wx->ring_feature[RING_F_RSS].indices;
+
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
+		ch->combined_count = wx->ring_feature[RING_F_FDIR].indices;
 }
 EXPORT_SYMBOL(wx_get_channels);
 
@@ -400,6 +430,9 @@ int wx_set_channels(struct net_device *dev,
 	if (count > wx_max_channels(wx))
 		return -EINVAL;
 
+	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
+		wx->ring_feature[RING_F_FDIR].limit = count;
+
 	wx->ring_feature[RING_F_RSS].limit = count;
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 8fb38f83a615..44cd7a5866c1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2352,6 +2352,11 @@ void wx_update_stats(struct wx *wx)
 	hwstats->b2ogprc += rd32(wx, WX_RDM_BMC2OS_CNT);
 	hwstats->rdmdrop += rd32(wx, WX_RDM_DRP_PKT);
 
+	if (wx->mac.type == wx_mac_sp) {
+		hwstats->fdirmatch += rd32(wx, WX_RDB_FDIR_MATCH);
+		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
+	}
+
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b1f9bab06e90..e0b7866f96ec 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -157,6 +157,8 @@
 #define WX_RDB_RA_CTL_RSS_IPV6_TCP   BIT(21)
 #define WX_RDB_RA_CTL_RSS_IPV4_UDP   BIT(22)
 #define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
+#define WX_RDB_FDIR_MATCH            0x19558
+#define WX_RDB_FDIR_MISS             0x1955C
 
 /******************************* PSR Registers *******************************/
 /* psr control */
@@ -1018,6 +1020,8 @@ struct wx_hw_stats {
 	u64 crcerrs;
 	u64 rlec;
 	u64 qmprc;
+	u64 fdirmatch;
+	u64 fdirmiss;
 };
 
 enum wx_state {
-- 
2.27.0


