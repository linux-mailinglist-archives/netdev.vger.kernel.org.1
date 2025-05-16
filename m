Return-Path: <netdev+bounces-190977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E9AB98F7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74904A664B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A48233155;
	Fri, 16 May 2025 09:34:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15882231825
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388058; cv=none; b=DT6yPwuDTNCClO1F+nFkH71+jv3X5NJuQi5WueVmy7xCOpi0cakhJIBBqNHt6KZLw/Gg9p7U0vUGB37Qofn5bZ4Eb6UdbLlYysCt1sJIBUaqi2hTMjzQf6Ye6avQ3uSpDpwdtld0uaNm+5Mood5ZEdq8+7PED16n8HpDdinEYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388058; c=relaxed/simple;
	bh=4O3kEczX06L0w29DATaf2abIVwMcvo1ygT4ixZUwNl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwlVAeKGTJc+HQbDxvCoRO1sLRCMYemvxgUwcjky+4s1DOA1gdEcZK/pD8srtgjroracK9e+WD+UTPqTaHn8wpX2X1mIHsK0YHjIOsgSIZtojqtqe2/q4//3pXodQZLGNVU4ReSkMeSv7/9SB7iE2rw/OERmuWhmkG5qdpGc+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1747387977t27d641f5
X-QQ-Originating-IP: Px+/DIO4HGDq4FBqVfobyENoyMGgE9GGjS7eApNpxDk=
Received: from w-MS-7E16.trustnetic.com ( [122.233.195.51])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 May 2025 17:32:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9192241663184129588
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 8/9] net: txgbe: Implement PTP for AML devices
Date: Fri, 16 May 2025 17:32:19 +0800
Message-ID: <41FE252AE684333A+20250516093220.6044-9-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516093220.6044-1-jiawenwu@trustnetic.com>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MdeKXtvFSi8p2UnW2jlAwHRFTqziL2bbKmA1RH3kD6Y0nrR/8BbKlPnI
	xvI1kfqynEduY08Kpa1GpNpVBG2kRQKk0aj8YZZNIGdi+vst+b1k7MKWSYnt7QoZ6drOYNo
	Xd3A/5R4lEgamLcetixlGsKYRWqvj9voKDEViBelPkUFrRff3BZSvXscQjXoOBHC+zDenmT
	/sqMjT+h68D5w5X7+BWW240e1kopcHk8GV5TPO2e5+TufnuKMCWr2oAAtMtbPOcDYgiRdlq
	Pdsa1BNFGdF8Yao4E/USE4mfZgwpetAvT6D7gOk+Q5zvMLbLx8RO4TwnOSa1JFxxLfzPKXb
	CqhVMoEMp7m2j+CQ4zgzlbDyk0J44XJ+btWLtTBTKyJXkARIOufuzZ5BWo1FUi4TUi7cFzx
	dXjRp4l6YCe7vZ6PgLpW5UMtzX8A6H/okYlGdjHp3V+MQRX600jzZKHRdFSiYgVNtzJkdDF
	zb8rzcS18LHJkemDbCx/ghpKiLUFaCxEUjD7PN7xd9B5sGpsUPBFAvfCpACWQQZPLRlHGxQ
	C9G9EYvEmxmbCTYGfZ0YV9Hsnk9no12Q2TQJnteFvcIgGja2GQSoAnuoaQ3YOmaVXQFJRKR
	Lnrnie40KuatjJ23b8dLJjsSL04zod652Uhl8uIGyQUz2ezfCUhKQciU4MQvxi1hEx26x6L
	+A6irJkWSRn6p2S1FWvhNPefk4MvQUpaJiAURGFcJO4fwcMoF9M8smni2yad98PxBXNDmPz
	5WjhSB0hYvu+z0JuQs4b//lSuJYRuLR1ZB0A7Q7GYU90gnIwhW8ShDNJeei+0GqfGy4dkcn
	2eROHR4y9BrMkLaOPYRyoTZMo1EH6exA5IDAf4p5DlnOJjM5RWRQVfp9zbB4rsWGiYc0IfF
	i71CNQjzi7fxlI1yijGuUJMZWYm10kH+SfQMGCP7OtmWi4CCk8ufTpglSm1AqFqqheZGFVg
	p7ooNtTANCbvWXwoUVJvN/+4MAyrksuoL4PIu5J7qOFDzlu6WqKeyiqVw/AnCQSrMR5cNGi
	/mnBMPDEIDZQlqi/wGatL4jjZ/V1g4+oUKGAv+axtDDNVh9krwDAf/R99mqmHhyYashbyuL
	Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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


