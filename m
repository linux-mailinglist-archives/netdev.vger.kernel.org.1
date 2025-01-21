Return-Path: <netdev+bounces-159919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344C6A175EE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505F6188AF6B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F4433A8;
	Tue, 21 Jan 2025 02:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C514F102
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426079; cv=none; b=B5DlNLMDC/eDuCdWIKZ6xEfT7IrxD+9qnTWVz2Gs0mjxcCF6br2DKPbnTxsCxvcExKzcG9CaYm6fGwDZtz8k/2GGmdz4Cuxk1w0XF2zPxepNw+RAZpOYPIuu98IMA+Qqwy1V4N0H9hNVgfRTGG+HeanR9I6wRDNhnnvt7jBgYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426079; c=relaxed/simple;
	bh=Qq8SSureU8S3Ou0zbBou6Got6asQczN5/bB2E+jm894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQDwZJVqlkxabmq709DinwIDGmNjE15s28JKPoP2Ra4yP2sDH1YTEjMNN2Vf7QqlKshE/Jlib3h4L2GN7lcqGcHUw9UUQc2m798kf5+Vlci3dpx8zhCaTXbhi87J2t4XCYIMH4EkQVVQALbq7/ut7rQn+e1kfjZtMqa8flCL0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz7t1737426065tlh4a5j
X-QQ-Originating-IP: 4GniKO5LTGuVtzqKArswU9/zBicqXOjPwSBTh8CuvFw=
Received: from wxdbg.localdomain.com ( [115.197.136.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jan 2025 10:21:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4162427598436202465
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 2/4] net: wangxun: Support to get ts info
Date: Tue, 21 Jan 2025 10:20:32 +0800
Message-Id: <20250121022034.2321131-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
References: <20250121022034.2321131-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MRY6qckr/MVJe+EJqxTGTBWjhPgmMc5UUqabebmyCqCAmBpGlj9wNyDS
	WBl5fsJ/DCP3zwg1Sc9vS88Hx8hT4nK+vUqtPROraGekQ0ofXXSLtyRsoTLup65KRGdnARe
	9ziUYJwpXhcA1tzvBOeknyZnFp+/GL1/5b2/fvNqVhR5OBZEjaEgzEuGR4NxhSirWzYuvTk
	y1QdkbRtwOa2lnlZd99yGyPfz/s+cP/YQqjWQ/YvQ3fgWdboUSKUuMzlmx1aIs35DQSJTtk
	Bk9mBbmlJn4a+DWTjy2RVA4SPVK5BxO8RNPnuBvFueFapNESl2tk4HAfGjsn0QVEStpyJqC
	q84LOvkfM3X8fVxYahIENyv6BJvoUAu2dw2f1XOtmrdFBREAiLMT9RlM9N+qqsJmjiMqeIS
	ZFu9ESEBtqxoAkQeKisqW/vetzZkLE927tgd+ebSr5HOxFaYebnrBZZJTztLi5Uu4troiKF
	hAJnCDilVR8yRftKUtT/z1+1OL+T1OChSboGNck7qDQNH7T+W2cC0WqugFYA+sy3rRcwMnM
	m470UVKzGzZOZec3EsdhD3x5xZ5812vqUaTx9VXqsGXniCsoFLgg3DIq2zBJR5lGvCyCvlz
	0DFE7NwtenF1lWD472fOmGdtEpk1REiVg4Zk8M1gjm+U4kLlDmuqk7/XlzbzYX3nESVVjSo
	ZqzITkqTVB2OTPZIckvxFEphS+CacwWYwea35O/dRsNpBEfwazsP8RmXHMauPob+EVLMT89
	Da+5pOkoezQtZE1nikbbgLRBFhxwrFdbwqWQo8J5bDU0RsakEtDgoUuHKLpnDULcGB7CWPj
	iBD4KGwPPN3UPNeRHLMkZfzFLPB/pWHe2176qveXLKD+BJsqhBvJA57jC2CMVdIR1OE12Ra
	hALUL40/nZtnNIIG8adAv4SdvCHoXvBQBU7MRIQCL9t4A4fPHbKI5OqvTJOHnpQ3Aw6tiE0
	Or9xAmOr9Nsojzi0ze+RF/MjYqehkDI3C1nNVrhn4FYerbA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Implement the function get_ts_info and get_ts_stats in ethtool_ops to
get the HW capabilities and statistics for timestamping.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 50 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +
 4 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c4b3b00b0926..28f982fbc64c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -455,3 +455,53 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
 	wx->msg_enable = data;
 }
 EXPORT_SYMBOL(wx_set_msglevel);
+
+int wx_get_ts_info(struct net_device *dev,
+		   struct kernel_ethtool_ts_info *info)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	if (wx->ptp_clock)
+		info->phc_index = ptp_clock_index(wx->ptp_clock);
+	else
+		info->phc_index = -1;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
+			 BIT(HWTSTAMP_TX_ON);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_get_ts_info);
+
+void wx_get_ptp_stats(struct net_device *dev,
+		      struct ethtool_ts_stats *ts_stats)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	if (wx->ptp_clock) {
+		ts_stats->pkts = wx->tx_hwtstamp_pkts;
+		ts_stats->lost = wx->tx_hwtstamp_timeouts +
+				 wx->tx_hwtstamp_skipped +
+				 wx->rx_hwtstamp_cleared;
+		ts_stats->err = wx->tx_hwtstamp_errors;
+	}
+}
+EXPORT_SYMBOL(wx_get_ptp_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 600c3b597d1a..9e002e699eca 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -40,4 +40,8 @@ int wx_set_channels(struct net_device *dev,
 		    struct ethtool_channels *ch);
 u32 wx_get_msglevel(struct net_device *netdev);
 void wx_set_msglevel(struct net_device *netdev, u32 data);
+int wx_get_ts_info(struct net_device *dev,
+		   struct kernel_ethtool_ts_info *info);
+void wx_get_ptp_stats(struct net_device *dev,
+		      struct ethtool_ts_stats *ts_stats);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index e868f7ef4920..7e2d9ec38a30 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -138,6 +138,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_channels		= ngbe_set_channels,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
+	.get_ts_info		= wx_get_ts_info,
+	.get_ts_stats		= wx_get_ptp_stats,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index d98314b26c19..78999d484f18 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -529,6 +529,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_rxnfc		= txgbe_set_rxnfc,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
+	.get_ts_info		= wx_get_ts_info,
+	.get_ts_stats		= wx_get_ptp_stats,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


