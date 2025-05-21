Return-Path: <netdev+bounces-192172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D53ABEC5B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9069E1BA67D4
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4523BD05;
	Wed, 21 May 2025 06:46:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1723A997
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809962; cv=none; b=iAZOGq3JTVOA7Bd2hoccCsKfEVjuwU/isEtQ2IS8TOc5142jSte9xs5KYi/qXp1Ibihq0vnB1gin/fwd+Wg5ph22icAuYiVigp/Ofat/9MKGo8R3eSY4/g0YE6DwwyOeWFYLGURpUwGzJ7Yxs35xcGx10CU1pWq+gkl7q417RDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809962; c=relaxed/simple;
	bh=4O3kEczX06L0w29DATaf2abIVwMcvo1ygT4ixZUwNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXpNX4UXftDPD1rmmlPz/FBKaa7aBSC9Xxs1g1rNFJZXZXYWQme3EasE+ngTDVtF31TJfT91EgA4suwHwVoMPo9nCjjPwuirZE2IKgzwwNUGASShO/kMVh6cI/btrRwTnf+NXuojQoGIBtu2NAcBXWdnyV6+yUtAc54nlo+ZDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809882ta5362d60
X-QQ-Originating-IP: LTOiv/yC8hnKFAtjs71HTrWM7wCr4l40T2J8JNZ/L7A=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16121035583678015757
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 8/9] net: txgbe: Implement PTP for AML devices
Date: Wed, 21 May 2025 14:44:01 +0800
Message-ID: <F2F6E5E8899D2C20+20250521064402.22348-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250521064402.22348-1-jiawenwu@trustnetic.com>
References: <20250521064402.22348-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MbKW93omTBNJm7yfLnxHGdqMcLP+/vBoHHBjCwtaZ2PTavBfodCJAIQR
	ZPAbeyb4FBlB/UIU8lC/IVqtTfCEruuLrtk8tRI1a9tYf4Hu2Lukkxx3bgM9tlfjjNexIWo
	vc+meF+k0uIfTIPTPXN1bii7CAYztsa486BZnleM2mzQbvMuRCYqkGgJmx1Rs27P3J+RFEm
	JAQwPJdjzDhmzk5MyvCSC/wk7rNsswecMerx1qVKaz1AgXeQRXfQ3PgeBVWfSJBUqdfbXQ6
	XBvD1TRQAdnjC0iQk0yw+rqiWjHpS8ziSMkGV5Ep0CtZAyU6+qWsYEKBmtumymrO8xMMBZm
	lSzZdiqnYnEToyLqgn+3ROnWr8qSJp1/l/c1a5Bu0rtKmK5Nxrwk1XhQPeBw4LBztKOuupP
	Yne2EiKwaztgvmdT2RT2YTUvUQUVFfWUFWtmNo1Nf+FeEtsFh0LCJSuWqkomzn+71PgX0bi
	U65heHSmTBgsEGmeQmzb9wVM9lXOIDNiwI1VI0eSS/kG5sFIlvOcyLy6oTUwghswYHP9yvY
	G56L4lhkNt4xgVbglERLsSaOZjgNAxnUAefDyqLejfpbPlfefdPs/ed9ZoXQ6Ep/pfyMwkv
	zI8WPQsoJQvE4C5R58q/3X4fZaiCB/XRVUKM0iP+DYVjzMPnPbz5a/dGEvx3x2SHZsc2nu8
	JG/n348LYmYBhYXBTpJr/vbCXEyO1jhtSaFQn9y1yVuBG+e76M88BrRfiiVI3C+duZFQwic
	i6rzch0S64XlOFR1/3488sXw0phCz/iWyIH7WT63gcYjhqU76gJOYZBbLJgdSSs83CVsjZQ
	KmZmycWrZUuNUm6rUOhYckLuosO1BcqBX3xohQ6IJ0odOOE25PH6vvrWuTxh3RX3ZtkthZG
	5pAvOsnL6eo9KBAEvggIExkZcJ/VxLt5lZ9wanSBq+gQDchcVTJOL4NlJWFvZu7GHpU3G2l
	HlqB/JqVK6HMdQKXtzzpxr5CK0y/bQiCQz/VdzbS8du82w3m83tnwD+jw1ekedAW0ZXV4Tw
	OfCY4LDlzEaq18L+IV+1HwGGE0OtrMKNiU1lsitbMHUmKdR6bAA6UpJ6dP1gqnPlX8dFODA
	Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Support PTP clock and 1PPS output signal for AML devices.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 30 ++++++++++++++++---
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    |  6 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  5 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +-
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 07c015ba338f..2c39b879f977 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -15,12 +15,14 @@
 #define WX_INCVAL_100         0xA00000
 #define WX_INCVAL_10          0xC7F380
 #define WX_INCVAL_EM          0x2000000
+#define WX_INCVAL_AML         0xA00000
 
 #define WX_INCVAL_SHIFT_10GB  20
 #define WX_INCVAL_SHIFT_1GB   18
 #define WX_INCVAL_SHIFT_100   15
 #define WX_INCVAL_SHIFT_10    12
 #define WX_INCVAL_SHIFT_EM    22
+#define WX_INCVAL_SHIFT_AML   21
 
 #define WX_OVERFLOW_PERIOD    (HZ * 30)
 #define WX_PTP_TX_TIMEOUT     (HZ)
@@ -504,15 +506,27 @@ static long wx_ptp_create_clock(struct wx *wx)
 	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
 	wx->ptp_caps.settime64 = wx_ptp_settime64;
 	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
-	if (wx->mac.type == wx_mac_em) {
-		wx->ptp_caps.max_adj = 500000000;
+	switch (wx->mac.type) {
+	case wx_mac_aml:
+	case wx_mac_aml40:
+		wx->ptp_caps.max_adj = 250000000;
 		wx->ptp_caps.n_per_out = 1;
 		wx->ptp_setup_sdp = wx_ptp_setup_sdp;
 		wx->ptp_caps.enable = wx_ptp_feature_enable;
-	} else {
+		break;
+	case wx_mac_sp:
 		wx->ptp_caps.max_adj = 250000000;
 		wx->ptp_caps.n_per_out = 0;
 		wx->ptp_setup_sdp = NULL;
+		break;
+	case wx_mac_em:
+		wx->ptp_caps.max_adj = 500000000;
+		wx->ptp_caps.n_per_out = 1;
+		wx->ptp_setup_sdp = wx_ptp_setup_sdp;
+		wx->ptp_caps.enable = wx_ptp_feature_enable;
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
 	wx->ptp_clock = ptp_clock_register(&wx->ptp_caps, &wx->pdev->dev);
@@ -647,10 +661,18 @@ static u64 wx_ptp_read(const struct cyclecounter *hw_cc)
 
 static void wx_ptp_link_speed_adjust(struct wx *wx, u32 *shift, u32 *incval)
 {
-	if (wx->mac.type == wx_mac_em) {
+	switch (wx->mac.type) {
+	case wx_mac_aml:
+	case wx_mac_aml40:
+		*shift = WX_INCVAL_SHIFT_AML;
+		*incval = WX_INCVAL_AML;
+		return;
+	case wx_mac_em:
 		*shift = WX_INCVAL_SHIFT_EM;
 		*incval = WX_INCVAL_EM;
 		return;
+	default:
+		break;
 	}
 
 	switch (wx->speed) {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 83b383021790..6bcf67bef576 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -8,6 +8,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
 #include "txgbe_aml.h"
@@ -311,6 +312,9 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
 	wr32(wx, TXGBE_AML_MAC_TX_CFG, txcfg | TXGBE_AML_MAC_TX_CFG_TE);
 
 	wx->speed = speed;
+	wx->last_rx_ptp_check = jiffies;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static void txgbe_mac_link_down_aml(struct phylink_config *config,
@@ -323,6 +327,8 @@ static void txgbe_mac_link_down_aml(struct phylink_config *config,
 	wr32m(wx, WX_MAC_RX_CFG, WX_MAC_RX_CFG_RE, 0);
 
 	wx->speed = SPEED_UNKNOWN;
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset_cyclecounter(wx);
 }
 
 static void txgbe_mac_config_aml(struct phylink_config *config, unsigned int mode,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 05fe8fd43b80..dfc3a2cc27f6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -6,6 +6,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
@@ -178,6 +179,10 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		handle_nested_irq(sub_irq);
 		nhandled++;
 	}
+	if (unlikely(eicr & TXGBE_PX_MISC_IC_TIMESYNC)) {
+		wx_ptp_check_pps_event(wx);
+		nhandled++;
+	}
 
 	wx_intr_enable(wx, TXGBE_INTR_MISC);
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 98bd25254c80..7a00e3343be6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -82,6 +82,7 @@
 /* Extended Interrupt Enable Set */
 #define TXGBE_PX_MISC_ETH_LKDN                  BIT(8)
 #define TXGBE_PX_MISC_DEV_RST                   BIT(10)
+#define TXGBE_PX_MISC_IC_TIMESYNC               BIT(11)
 #define TXGBE_PX_MISC_ETH_EVENT                 BIT(17)
 #define TXGBE_PX_MISC_ETH_LK                    BIT(18)
 #define TXGBE_PX_MISC_ETH_AN                    BIT(19)
@@ -92,7 +93,7 @@
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
 	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR | \
-	 TXGBE_PX_MISC_IC_VF_MBOX)
+	 TXGBE_PX_MISC_IC_VF_MBOX | TXGBE_PX_MISC_IC_TIMESYNC)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
-- 
2.48.1


