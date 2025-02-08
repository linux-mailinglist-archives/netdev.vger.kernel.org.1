Return-Path: <netdev+bounces-164274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01912A2D33B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65E37A5121
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C681215442A;
	Sat,  8 Feb 2025 02:48:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225262AE9A
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738982917; cv=none; b=h0fbvrsaNHKMIy9X7zeeCFzbS9qoCojdWCweelz8o/WJF6sJuiicfezospT+WPkwPRyCno0eWIGLlTjtJ8MtF3EFNOC7ubOwELGAPj7Ou+84MfpZM8C+K9e1LbjGtFQrsgyVl2tz7GmxOW68CBp8uKP9vE9NLSFIXYEf37gvme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738982917; c=relaxed/simple;
	bh=Qq8SSureU8S3Ou0zbBou6Got6asQczN5/bB2E+jm894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVCUdGCUn4MrMUiRvtMZrLXtTlvf8/0h9cz4QG5zvUm8bByopNIZ23dGZKvy+FQ+peIhHtEQkW6Y8pOJqat/AByLX2d9qY/Cdyb/ZxQznyowLmkkDLs2RWnKewtve9g74RW5M5Xe9Mjn/N27O8805IRz6e8bLmmRocHCbVwKBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz12t1738982907twd4ep
X-QQ-Originating-IP: DAKbV7EreFVixl3pAiSIAldN+qyqGZ/gr/fPPQDssVI=
Received: from wxdbg.localdomain.com ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 08 Feb 2025 10:48:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12838914148754106534
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
Date: Sat,  8 Feb 2025 11:13:46 +0800
Message-Id: <20250208031348.4368-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250208031348.4368-1-jiawenwu@trustnetic.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NL81vSJxOQlIy1ieoTe2oQEhBYcH6zvgvhM3YOClli6fZNERHQdtaYku
	3Tj9uQPFt4A7u/Ug2iWu3TSuLj/otml4lZUWzqK4fKica15UoMDnvHHhEUUHuIBr4GeBBky
	xDRuFe5gT1zrlynbAiYmGKYk//Sdsl0lFfI6DgICylXTGsX1IlOt8d7D3CkciA8i9o7p6Zo
	2FGt/9uWrOCs4YjDrlw65ZhuUtuaeujAloWLQehAowIXgbQ+W4jUdmVdq6NT6+/dSK8Y/BS
	S0me6dnnm4VwES8/cYNuo6QLIMFFVkNPT48AuIa8bE02OuawTI1jOOfq3Tm8eCrvYvZObcn
	mzn+haZIY7u3K49gMR83ZxsostqZOiObUAF5Yw0IcvMpW/IdXF2vRdqaKAz5PQNn1M9uY5h
	muthwULibcnShTHa0L2/8CJBYsefiVHzC2Xd/4jKCoC2Hwd2M0Q83i1cavVE14DSDBbDnju
	tTvM/myvYlU9iURtVi48X0uGx3CGHnGUdJZcvH+A7hEDcSJVjRzDqTbyR59v3cqcDq1cKPU
	Ox9qqRu0RwEStdMjj/95cNFy1NTjhTcgD1ocOEOZSABzepLh/kZIsOoX3YwHYRRRKsNMTWZ
	oQESF1k1yWDtkNbO7wQjvxgqShZ+TJYlWBk1t2wHSJyJ/GW4pEYTisk4AuRsxWJqHENDIWi
	G0xpoUf7BE92T/IpqDY56+PnqJwJNG6k6vr2VxDgE6tYRtiRKAbwvbK9jcxzcjpH2qEb8bl
	WWIaQcELDho4Z2xXVA4Jaus6E+wBD2H5Sh+tDre25UFcSEFtOSNMiDG2iAGjngc870Thzhl
	XsrD+gTHvjuX3gRqMN8RDVPS24yUiG9RKNyTvVDAPkYNs/L7ePdk2iUSK9Ocy4GR76HWq9X
	35PcASOj5BsBysmwuumS2dsUM2SDuCU2gSFvRn2PiWDarQs3BdID5w9qmhqjNzmeER344Fu
	SAzzyxiPxbWb5C2phvflYAp4xc1pusORJzEJ6IOOuTutkIpRQhTFwSUqGicYn9fxuxeHzEH
	n9pE0Mh/XTF7odoiWi+ULuf0cQoaA=
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


