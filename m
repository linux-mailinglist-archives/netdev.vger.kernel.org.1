Return-Path: <netdev+bounces-154695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F49FF7D3
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 11:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE693A1E17
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD161A8F68;
	Thu,  2 Jan 2025 10:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188D1A4F2F
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812638; cv=none; b=bzy4zliX7et+NrIKEmf/TJCVpcjuDMdH5q7lBbE62lBLGDRk0Li5uWy3lNyxCUPpOM/uTfzlt8f0ARNtyBejMNpn9OW9KROw1GTqRlF08R9632KBYamWIFEO65Q2/vIGNNl/HQ/8LpV/YhoGUtonKfNHLLF36KrGwvpwE4V5XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812638; c=relaxed/simple;
	bh=Bh3hu20nyqbJX1pMGLdT/nNwbgHHX2Cj9jY4aMrVhTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEnRaQ4VdbKnMTom7Nco+K3vLKd8uJyS3qsf1MKo0gg1zNpRGosM1yWOggC/cEHvo14GEns2puQzBU9lq3C+VzirfmZgyo6igu8yjcVT7nra8z37MgG8QS13O1A+YV1SV1fR3LZfnDo4wDKc5Bn1LBTT2gG4/lJMkN7DKTHEAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1735812572ty1lihx
X-QQ-Originating-IP: J+Xn0TSOGZZrfhiyimSPM6kdN45HLscHrNSt/OOLlFI=
Received: from wxdbg.localdomain.com ( [115.220.136.229])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jan 2025 18:09:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12601964673255411224
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
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/4] net: wangxun: Implement get_ts_info
Date: Thu,  2 Jan 2025 18:30:24 +0800
Message-Id: <20250102103026.1982137-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NybhH3S+IWZnzjdpsrrw6NwdFYgFOeCKzJ+hqwFbVMWYsQEbE4tbaxgF
	0UZHddegPAPg7gd/eBB1Ar4TIsc+VfbKzNuCCLkfbE3Z0I+gYX5tl/tB7YeUXU6YKRAhDrq
	KH/kMIn66gvAxm9klXEv3fpfCWIEeSxdwKEOXKnsdywcHPHf1b5U569XBX+8bQliMTJ6LqT
	6PfWEXCMMnKZ3MjDldp7KQ/0F5/nfD4+KvxPdObBpQ6z5P6pEKxdELopQmaIoJ8rrH3BEul
	9qOff6YoQgHRkzjbS1f5n0HQW9UZodEeJJUn0pKD12anfTq421FJ1+rYN4S5O5zXLiM4L2y
	KeVfM+21/RQlVX0oFACFEoHgd8MMoSd1qi8AvCoP0FYKW+gMoHUdlHSHu8KF8LyIPRCkTYy
	Ng3wVjiiO26CANdHD908bsgFFbm7UNv+L4QdSWkhbmXW4Xruz7yKDAtwSB5a1derR00Nyfd
	Q60sQjCMWJRssQJYpDFGLcA3Ki+oVpcRvV6LlIr+X70ir8753nmDhV8Brg7padcuwcl3Hrj
	XoFRbDflLpi2b3WTkv5uweGRXd3QVmQUiQa3d2vdQcSWG8Ma7rOPtYn3crD4y11ajp+TzAy
	1+zL23kDzgcTruTVP7fqVKcjUl8w30g/5HCaqXQ/n3JM40azjfJaLVclr3SxGe4qUKe8cq7
	G/FNY1GfO0qVS7moVjwm8XqWprg557/aUVp/M57pZR18wkOk9lpqRQ5/jBJ4wT/7lSSuwuK
	3MST2q/W6q8WmqzVsIablHQ48HRmhYYi5mty71YmqVrQInrjmMWY3rISVDgtbqMpRFUqO0p
	CqYtfQxBkCLJ9fCHJdCrHI9eJ10Kze9xSlV+3JNyMQO1uElY0hQVw7OZ62l6iZA4KtOqbvu
	SpvDCMfg3Wl9cyEDKS1hlHJM5sOH69+qv9N9DhnjYM+JUuclPY0xGA+g4SrLHDg0qMvWlU1
	aK2UNT3iruevcLnZJrWiIeBGIKTQKiB0ZYficgGNwn1S3q/5+aaKfAIn6L4OYkrr12AJCsH
	CcVikGbeJd8rlrVtObJlPPze2O4PX7EXzWRJYm+Q==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Implement the function get_ts_info in ethtool_ops which is needed to get
the HW capabilities for timestamping.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 37 +++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  2 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  1 +
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c4b3b00b0926..2a228faf0c26 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -455,3 +455,40 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
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
+				SOF_TIMESTAMPING_RX_SOFTWARE |
+				SOF_TIMESTAMPING_SOFTWARE |
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


