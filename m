Return-Path: <netdev+bounces-88194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D938A63CD
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB981F21AB5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCA96BFC2;
	Tue, 16 Apr 2024 06:33:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC021E49D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249202; cv=none; b=cUgZuAN4zjHhMSzTTmXSPIINNVD0Fn/9p8ag74hsjjAMCFwEPFO7pe4d50H8hz8YO78dzwblluWCQEKbqyMnSPi6Xr+kXGcCiOWvBvEQKvO50/vJ+VDoUfgxPt69M7t1JE07f5e99RD06YdShqgm/Clwowd4d7d1iuKWUek3EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249202; c=relaxed/simple;
	bh=84W4/VSC8EgR7MavgN14T/xjQvFRS15y3wisyIOW2NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6NVEduUkRrT1XLPMEDzzpEvCFCwuUtL2mfVP6kf9AEOscLCEBYlDbsk5vB8STU+tqFULFQhDsZUbzxSLQzIljWj0RO8Af/gK1NrQgyy9Z8yCNxd6gm6ZgTPJjNgk2Yjs26PYP0WN9y762wI6USkoXEoywTuxadMvWHUtEWZOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1713249008t91m9pmw
X-QQ-Originating-IP: 93RTpw930k7+K8yfwIbpURyp49p/cjo1gWMfMmh1NKs=
Received: from lap-jiawenwu.trustnetic.com ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 14:30:07 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: GiL6AMY6vMBVcNHTqizpNXH4mD01zlKK3fAVKAyHhGPOt9WjVe70g8ptoQ2Wb
	OBUqimIKojlfMCXPTrWS1NZnvNILPEP5fVAB2v9O1pv9KCXU1FhL2RzJnyN3GkIgSBJBxgu
	FfMT41rJPcJ2nx26zCb1eLpBl3M3hxpSuqbNSozt0JTFFREZO6MPUYy/nohaglJTY/mY6wg
	OMHeboUKXQAkl2BtiC5mhS/A/q4vQ3XSP6HADcdS/By0Y12kTu51qY4bwtKfyYCV2GtV/tH
	glpEpfuTwxEmZz8jjWcStv6LCkJGuLiUP3YDqJpFy0/30b1KxvzcA1jaJTuuach1Cg5PqVw
	KRbHqrTaVbNjWtFUM3AlSEu8+wXsYIh2Kk2UmlXJyx96a5Kh/00BzQECWsdojixqTHyX7dH
	moPogAqp6e4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13564188104620174498
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
Subject: [PATCH net 1/5] net: wangxun: fix the incorrect display of queue number in statistics
Date: Tue, 16 Apr 2024 14:29:48 +0800
Message-Id: <20240416062952.14196-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240416062952.14196-1-jiawenwu@trustnetic.com>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When using ethtool -S to print hardware statistics, the number of
Rx/Tx queues printed is greater than the number of queues actually
used.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index cc3bec42ed8e..3847c909ba1a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -59,9 +59,17 @@ static const struct wx_stats wx_gstrings_stats[] = {
 
 int wx_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct wx *wx = netdev_priv(netdev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return WX_STATS_LEN;
+		if (wx->num_tx_queues <= WX_NUM_RX_QUEUES) {
+			return WX_STATS_LEN -
+			       (WX_NUM_RX_QUEUES - wx->num_tx_queues) *
+			       (sizeof(struct wx_queue_stats) / sizeof(u64)) * 2;
+		} else {
+			return WX_STATS_LEN;
+		}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -70,6 +78,7 @@ EXPORT_SYMBOL(wx_get_sset_count);
 
 void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
+	struct wx *wx = netdev_priv(netdev);
 	u8 *p = data;
 	int i;
 
@@ -77,11 +86,11 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
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
@@ -107,7 +116,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 			   sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 
-	for (j = 0; j < netdev->num_tx_queues; j++) {
+	for (j = 0; j < wx->num_tx_queues; j++) {
 		ring = wx->tx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
@@ -122,7 +131,7 @@ void wx_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry(&ring->syncp, start));
 		i += 2;
 	}
-	for (j = 0; j < WX_NUM_RX_QUEUES; j++) {
+	for (j = 0; j < wx->num_rx_queues; j++) {
 		ring = wx->rx_ring[j];
 		if (!ring) {
 			data[i++] = 0;
-- 
2.27.0


