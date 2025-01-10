Return-Path: <netdev+bounces-156941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30383A085B4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A5916A429
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D27194A60;
	Fri, 10 Jan 2025 02:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B062C9D
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477809; cv=none; b=Tm+rnC5lgSMTXiCh3u38p6YB4LSkO4lP+HNuCKfNHJp53HxeOasHR8WC6t77sdLRd5i/7orMjDBa5ExL95CbmdfixdDUfbP4hrvGFlxTjKcRmM8GosWUpEowQyJ5d2KCaq913i/x/ZvxOomA3gMaMtLlHvLucMdPS023Mp9PW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477809; c=relaxed/simple;
	bh=MbHdlfo5uZVe4GJ3hoz1yWfOBjcwV7EZpTiSeAKckW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U01amkKC7x0pVJLd3bf4s1NvQqFGnBcxhXxZ+anuKSJlHEMV6HiT4KN7T7CzMz9YCInTowE68Q4AFXlfFm4g4Rw0P4bX4qVnUH9DGgpVZU6E/EY3CTmd+wyYa5cGW0rND7PpD5kwUWDUDD7WUOTUpIsfCXENCwK0g9OyLyH/7rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz4t1736477795tpreewy
X-QQ-Originating-IP: FBTKkpcCTad0vqyfAzUg/XFN9rfQ5aYG9pufdsnNY2E=
Received: from wxdbg.localdomain.com ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 10:56:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4453379034131088410
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
Subject: [PATCH net-next v3 2/4] net: wangxun: Support to get ts info
Date: Fri, 10 Jan 2025 11:17:14 +0800
Message-Id: <20250110031716.2120642-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDGUoPnBmw7savKoWcZKinnx2AH21hFA59hyPu3uNtiz9V5+iJllR4mL
	Qg5BVCMLX9ci951PaSYmEvhFSimNcpOQzXpXPBbkwjckrrUaWPnK1Toinc+ufJdUT+IHlNX
	DuXxEEbf32SyKv/LHAHpt2dT/u2OeXywpin6U7bTA87AxJ5Gy7JKKzB7dD2PyJolebR3Gs4
	d+9kSsU+IKeRTkkuGfXlQUwBMoGDnPp87/vlG6MQTpm5pPRJIm+CDwWHVH8XAeHW7seO21V
	VGSnvvD5vdzsMLtB7agN0tRHKudMuh5mPiil/6cA77tWCvzuxtH2lm0UOx9wX8x5LKVNODH
	kZmLxFUFoJRdr8OAttY/dTYzsXTRkQ+Kdb+8txhTXpx2VqjmEC42JxaCkqgyffvZIeP6KHr
	ISlBW+6hu9zZGl6J+XqmMhRaFjPF2xY7Km1ZIodb7Pse+RF+3V0lQrDbMDejjVq5Daut1Xw
	TG2CHAkuhphE3lDzxfBogKDVki+5e5H/ZLMu1d6nxAvWkGNUI7bfF/k4mUYYJg0XI7++8ge
	lnnIkpxPMxTgSBDd68CMOj5Yl0VHF9Q0BIypMiufB5rgppKXJwxU9ZjH3gmGfb+ki2gzTBV
	FMO3twAtHGIoH6e1sAEAfXduiTX5kSWZS6DHpWWqfVUAuMrfDh1Gs+hW2AR6okd11TcY7Rp
	H7eB/ZVPC1DLNisX018DE5tokj6knOmsMuGw0Uc2tyBeKXC+jT7yTHYCS42oUGXVhwT+S2a
	Jez5klHsiKCrnM1MjQXqBFgj2L2uHPKnexnRP89oP8Y+890vdRB6IiD04zM63syFD3TbgMn
	l+9EXXysak3A75hAApsr0A9lNMj46a4JuMWB0EskooM12r0eMlsUKZ16Ifx1LZmDuADYxFh
	koBIcMRImijmJqX0XGCKGBLE1i2+6m/pFhVmYMZ2S1budtqkU6qbv4itDwgfvifmTiZOqQ/
	N5385a8gyD47BT2BmX8dSLA1HEqDCjmzwhe99hivhIdVnOEG4gHB5fIFCemZxTFw+p9I=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Implement the function get_ts_info and get_ts_stats in ethtool_ops to
get the HW capabilities and statistics for timestamping.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 49 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  2 +
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c4b3b00b0926..7098b794b8f5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -455,3 +455,52 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
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


