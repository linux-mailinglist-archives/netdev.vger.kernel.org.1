Return-Path: <netdev+bounces-158025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69299A101F6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4E93A9217
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76169284A62;
	Tue, 14 Jan 2025 08:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D4243331
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843062; cv=none; b=X1RModcu2G+TJUbUNOA8u8zhfxCZ+DK6RkM1S/Zmslz1bkTgltKJqcRjRht9JppSEbyKkitnchxnw9QmFZ/ZnlHOTqprWE+ITyI/TRDA6NRY5A6A9hFktdZVleIRFhmvxBVDoik0sTdcxaIoELCN80GEeKZsny5MsmFxXSTM0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843062; c=relaxed/simple;
	bh=Qq8SSureU8S3Ou0zbBou6Got6asQczN5/bB2E+jm894=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4ddClADJMfN77M8Bp4vGLJPpUvUNrt4nUirTFCmWa9dxGAEB9N30BYX8AwbjoPkI43yR85/9elPgeTreBj4gHpsZROb3wlG1zAQ3EKbqBVX+81R1/0WCtrF1L4bjtF7L5KKixrL7irF/rXFoNgjLdv6xNgdHffjlYblw7JBzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz9t1736843040tno01sd
X-QQ-Originating-IP: 7eOOOALQXEV9lj/ynWFloHBhpMfU1ZCBVaJpYXoVn1o=
Received: from wxdbg.localdomain.com ( [36.20.58.48])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Jan 2025 16:23:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7153803749452004686
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
Subject: [PATCH net-next v4 2/4] net: wangxun: Support to get ts info
Date: Tue, 14 Jan 2025 16:44:23 +0800
Message-Id: <20250114084425.2203428-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M8UzNwRhOXbJxJTgtyCqjQxC3n0k1WWs739vW3D4Vk4lxZLi++7UKkee
	U6vKmiPi8Er7J7OS+qdS8yF4Nfmeid/pHJT+vQj4Uq60snzlbzBnKgI1ekSJUnOxfJ4SYTo
	Za/bssDAumzJ1qWKMmbKghRigDfyUtEan/IxZ5Anz3BGm06L+xcQv622QdNVd3jyMt0Vsiz
	rCxIBNRBgABk1/9xMPBxIRaepeIQHr13SxzY+t7AMW/UQScbyrn9zHKuX+FB0trmkTUbNXI
	vMp3LVJ+q9LGplito+lAc4HylB+PlLcZE7yZ8tSxsvpAy3fywVJqe45sN64+iQ2xcEk7Pox
	7Xw8Lb37Ik6LERq3DRBjIMczxPLwFipjHrRTsBKpGcrLuMIDTFx4gh3+0hBGoEGGLhERAto
	zknaxW8rA+7KP0AyWQtZc/1ELuQO68mhDJe3WzrqQggiAXXHA534lK417ytYeMUdIe3GQrL
	yRiypJi4spRJbamrW1wYuMi86R5ERXQNrgeCN2TKHHAZOsBT2fmUClpNXXtOeLEf1UpEovK
	sKDGVFOkcayrmH8DLOthhqKn24l9txPRB4WMRvGUwPKAKQsKhKtbH9jYqbErZFSqS8lf66B
	5JyrWkh70bgKEDfRrPWMeumVmvgeAVUbf8PxgmtKRMhMbq4+48L++oVsEkDxE8zEsZf7drw
	0bQKHbu4K3bVnMiaW7KwK9vzM7etaVbDsy1RZ2kv7p45PKX6F9N6sNvkviSzkAoKVQPdwPH
	2U1iXtDpXv/z9CDAHuX9zi7G1ubz25ltV1W0V8TYJtxvaEp02Zco3Typ8SP4hWKU5u4o/fM
	MtP5/Be/AQ9tN8YA5aupKs7JmYR44zq2kvU9dEbTzFklPQShUjfGA1F4ejPyByiC/OV3tWf
	8i+cWb8Huf2fgkAOLZAVwo+hQboC0MwdjZV32BQ+jADWAIQTF5mr86CYPQyJByGrEKaL8zS
	f5fTa6JaIPFWZxhp3fG/9WqNroj5Zx2+lOu2S4Im6ZHDHro13d5SVzlnmZScTJjOKmTNLLm
	a8t6qyfg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


