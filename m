Return-Path: <netdev+bounces-155370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33928A0209A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E7F163840
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C91D88C4;
	Mon,  6 Jan 2025 08:24:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E31D5CDD
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151878; cv=none; b=p4lkNm4TIvge32crPlgB65WO0PX8uIwlkImspwL9TFUqUTDeUdbvPfKukAwYdbrRRxHb+7DhW7q98E3wNIc3J4FEoAFMglG2MwpO2plwDShdeyPREJWSm1Wak+XoumQuxUxnjjP/NpFlvkk8ZpoiwHTBi/oR2xJ+zeSIIssdu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151878; c=relaxed/simple;
	bh=U75f3BCAOINrcOpE+9/YSvpKcyF4jXsSfqt5t1X6DxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1D7hg6zykZPseEiMZQgPpDHEKvA1/d+uq3rDq2CI5UrfpjFCNWYWVY3A8zZS9GiZ7nTYlCzWYFjKu7o2XyovoCqMKInGwTEMYKkWWCY84EWcPF73Mj1HwX4et+WqXRryir0pTN9ojBc6JVhjYMQqXRUw7fYkrEv0BJh29fdgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1736151868tuiqsl
X-QQ-Originating-IP: /x3cPJKI8b+g02RmdRNP/wnHdgWDFBuuO95kHGf6ufU=
Received: from wxdbg.localdomain ( [125.118.30.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 06 Jan 2025 16:24:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7499969919596435804
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
Subject: [PATCH net-next v2 2/4] net: wangxun: Implement get_ts_info
Date: Mon,  6 Jan 2025 16:45:04 +0800
Message-Id: <20250106084506.2042912-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MstGp8TWLL+e039RFf0LwZPkvOpThVkgm5PHdWPvjR9+/Qhxh71w3wLV
	a/wRAG9c57rfuiJICnNQJmosCQJvOdUkwadogAiEUBwkvnORhkwo8t86cRlXpCrXYgZKcVD
	bovesw4brG7V0OoT+EE62DjB3yi+NQol6WQBRAYa7CFHQ+dzQzHGrWMINnQGxVnWiOUe1GX
	V+ikWUCZGmf3Cj3wIRLt7xfFNcJyzQnoOiKDMEna8PsjkHojl2DvYaGO3seNFKAS1T8QHm/
	FuQEFzk3niHR75aNeD0NjA8xHitM1EKEOU9A7i1mTzJWR1FsytJxVNhMaNf8E+DfCsJE4nI
	MWst3MKjqKYqFOclm+tiZbtGZZ/CQLRXcZ+w7fdq5EncwIyKaPsufDts12ash+5qAOSwSIl
	qAj7ocX5EFfV9epFzoFVAv5zlx0N4vNaMSbXljl3m6fNuKSPLV2sCJ1Vz5zreU4MlQRXpJg
	s6gvIX6GJ7DJF+bArUl3VtybqapPUKu5PvYQCCM31/pEiKyZq8hVbYisEv5oxz6MYYcVWlb
	KP2IpO1g3OhKZgcGEg8IPNUojJ85A2T6+MpaImZPa4SNFOQAETp4FO+nPXIYi647Fvy0TCJ
	GbjKKUaQ2owiPB4PGzCHOTPAEbbpFCasM+zRq1sL1MXkugaum+BvI+kkcT/O12zWEUOKE3P
	vzlt2DVfPn95p3peVw2c/vd/ium/86KG2LFN9AdX1xfQBR6g/kLtfuB/ljiJABA1ijZDKaa
	KAgnlddw5n87SNxCaMWLv9+lJNbOjfF7dD9Rs3sEhx1xyEvazvjXZ+gj8mEE1Z/h5e0M2JT
	EFhJIYdcZSCfx3imxmuIz7eVrmARwKO6QWHTvuLZ/cRDjv+ttehHlYMUWx4Umv4R8OsYTEo
	DyDBKEImdZG6zIIemqQD/YPNu4v4H4/Mmg8mZiOFLUzrvpi82O2XmfIlmi5srdG/2QprR9T
	wN41ikizaNVfB/raR7qZKyagYyjnzeSGjfd83/WHxE0gHIc/wyOCCP/p2HhchxfwAR3LImK
	2IsbgWsvUU/Ieb7oa2
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Implement the function get_ts_info in ethtool_ops which is needed to get
the HW capabilities for timestamping.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 35 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  2 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  1 +
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c4b3b00b0926..27e6643509f6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -455,3 +455,38 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
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
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 600c3b597d1a..7c3630e3e187 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -40,4 +40,6 @@ int wx_set_channels(struct net_device *dev,
 		    struct ethtool_channels *ch);
 u32 wx_get_msglevel(struct net_device *netdev);
 void wx_set_msglevel(struct net_device *netdev, u32 data);
+int wx_get_ts_info(struct net_device *dev,
+		   struct kernel_ethtool_ts_info *info);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index e868f7ef4920..9270cf8e5bc7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -138,6 +138,7 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_channels		= ngbe_set_channels,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
+	.get_ts_info		= wx_get_ts_info,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index d98314b26c19..9f8df5b3aee0 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -529,6 +529,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_rxnfc		= txgbe_set_rxnfc,
 	.get_msglevel		= wx_get_msglevel,
 	.set_msglevel		= wx_set_msglevel,
+	.get_ts_info		= wx_get_ts_info,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
-- 
2.27.0


