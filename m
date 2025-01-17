Return-Path: <netdev+bounces-159165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2109A149AB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29033AADBA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D91F76D4;
	Fri, 17 Jan 2025 06:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DD1F75A6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094884; cv=none; b=WybEtcfY2if8YrZpO8OqJCCj3qhVSDpgTrT716NKpK4KQa6wBL9NJghNNuPJk6f7wAiyN2lqll7Sv8rNbWoNyBTQGmSwSdpdprpBYFLRq8btQuM1DFdyGzeCMiqqFNQUM0yWW0VbXhaYxOJ6dIxf4f7uAnmgIjCIhuW4ExmJjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094884; c=relaxed/simple;
	bh=Qq8SSureU8S3Ou0zbBou6Got6asQczN5/bB2E+jm894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoE1s0laGsyzosI3BA/ioZxEOrfrAMXReE/NItzDZnx7FFfq51VI6N7Kkd7/Q5gJ0pHrMC75IgHgrhuHQOA7YYNco0ao4PEFEhZVHjs5zsNSUSQwGp36ERobWyWsv0uDl0BDOjIoYbe5gPMvPCZviBTkfJRQ9ZLIIhhsU+PDvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp89t1737094873ts086eny
X-QQ-Originating-IP: Fc00jOj/ylQWRzAbzpNVJ3bYMU8Fi4cIK3pDTffXU0Y=
Received: from wxdbg.localdomain.com ( [36.24.187.167])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 14:21:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2971817056801722153
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
Subject: [PATCH net-next v5 2/4] net: wangxun: Support to get ts info
Date: Fri, 17 Jan 2025 14:20:49 +0800
Message-Id: <20250117062051.2257073-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NKv2G1wnhDBnjCZXgLIG/WcN+YSeudFlO4yYUoHHZxHk9/bYGZ6Iv7mN
	1WH1xVPwYMPqR54GSNyGWsO+93nVbQ3Q71Uh32tDlTwfvQr+5BS91+rsQoDuhSau4JK3OkF
	k1veWHqUILdbBFs4ggYGyBBMKoqHatW4ykRZCyxpYit5OBI77GWccNCC/uUGqpWvgO6TPG4
	s5fnb5AjcCvbFMWSGX8SctN1dy8IFkK+5rZBSHLEv0ySBlP+99kNlqf60xIvBgUeNtbaq5M
	m7QVhiwXjIvluuW4RbrlsAjA4xFcH7VzIVvo2g18nqkIdMRpfB+QCFbp44Bkk1VadenEeYi
	uNCE/O4XtYsk3fjcNpCyfKENuQgfNcbE7P9V4VWHpLWNTnO2ygMUkxaxpwjEoDPjI3dkAt3
	y6/BA5Nt0Bxh4JJjmOXg7tT34VdGxqkb0t0Ddsvi7mfUA82Ab8HKgKm1et3EJX9uW1L0RhL
	/pfc9ivG/6jcfAdvakfrzoNfAEvlGYAh8JJM19Qu+CgTNsvyMKvnWNbqACSV91ldnGeXA80
	hektsXMLhLc+4dXyPptEWJi4kQmK+MsmB8lDJ6sDZztgC/6Kx8L6Vp/tjmUhTyqtsO2xfHa
	p4sYdyRQCk2PE9rtgfi4Ms4DXgkUbHR1Ar3gsonmlqGCCIXhMybvJQnGXs1Ly+7KESaMdfx
	fbxhdzYi9KbST/S3MnoLinZg2fuNsFthX39gYnk/uAbwdZA77UWHsSlctqMHNGo6nhZoam7
	/8PGRHLtJiremKe9FJvgDpRPn2TnAOBLIiYFt2sKhiXgwnOZhDPDynJQibmiskYI6c15I6F
	7bh4zGbMWRwX0bwn/gewztmKHQjEkwRXaBzu8c1VdcnCnbaZrnlYkjUwxKMN8rN1pX31tH+
	LvlvmLrBaVkqQhcFDnO7OkQZlj3JjJBFoWzJiED5SLHg4BllK0TtsiKm7cjy07jtX8ajFX/
	SPOEVf6c52Bmwaofy4FHCa6nHyfyXuFigJ3ALdWsGv74IfpJDHww2/97eMeWjmDCVevi3RE
	o8ia1xFlE2/SYjMfB2R0MiMPWYtNE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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


