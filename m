Return-Path: <netdev+bounces-192175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3DABEC62
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FFE167FF7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A723D282;
	Wed, 21 May 2025 06:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA423C4E9
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809968; cv=none; b=TMG0V59DSmTH70OTwCgNh0f8J9TBBMuomhoVc9Ra73ZySubE+j+dd0u5FLg6R4QmmpnQAPMb3QXhj3NEO773Do62jECHVuSFiQZl04ZCFo6u/ybXQ6GhGtpO0kDcLuWKZq17GmF34YjieZIVi3yRV6JOXnKxHX85X1V1Hulbk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809968; c=relaxed/simple;
	bh=5m33Lk0ffIz30ZD7R4rdRUL5Q+R1Qw2H88ehEx9wga8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6UAO9T4HbsCHUdH9P+y06T5oyR/DwSuyVeTMqVu45tSjHiJbQQNLfIimwH7g7I/ORJqL/1NFocd5P/MU+WdPgFv/PVqRp9SX5Gs56Bu8Ew3M7dR+zQN/7Ydl7CMMwE4MqGQJ6OREGSgEd05o39D5l5Lx/CX+DiZqrzN8KSbeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1747809875t49bc5a3c
X-QQ-Originating-IP: V3UbL2H40Ac0zjHoFiTO/0jGmCkdBSIL4hIHpGcgbbo=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 May 2025 14:44:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1391573572020330471
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	richardcochran@gmail.com,
	linux@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 5/9] net: txgbe: Support to handle GPIO IRQs for AML devices
Date: Wed, 21 May 2025 14:43:58 +0800
Message-ID: <399624AF221E8E28+20250521064402.22348-6-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MMRwY2QoRaEQYr0L5J3yhg24xku68eV5BJH83bxEU85ys8KW5RQIH0F6
	T6zOD+DnHNSM9v1yu7BSvo46zwpSxTAFKkYsHU/bHT1lYNdhirOHzpyIp1s8UpGuIPMLFHS
	FRLH55XoXyc2oplgQ9QWLtDWOlCNZrzckTUrWqMq8eN9d2DJ8YOpzwq4QFAAJdBXM6d2+7B
	pI0YEDPI2HWoI9ztuNRdWH1lBvgzPgVfrwNQzyeGhKpzoYGAwwYIrNBWJjnxHJ2J1XT2Sv0
	fbsQl31q9MpS1vMM6o3CBzoH9kOeX8K2tU+lc99TohiR9gI7F2SB3BlL60k6vM9WMUW2/7W
	gBI0V4BSo6itOfK7W5tF2Bd7tJ6kC8Q2GNeCyMDC0xB3vbN9gEXcfkErh7HWnL9d4GUJdsY
	d9MGqiPA47IRsUMzdlzyqqSlZJJ5uXjE8KNa4xH8g23basjIJUqrajHuZUOBxvH+4dzkV31
	6eoBJG+HzXZ99Kx24YqRpr1wZP6AOKTqUidjkckKzmw4BZtynWGvmB+9H/juUdf9xk8EvIC
	X/YJEj0fV9fOLYPUHqGB6l+KMHXUoDIqtsmvayzYCXnWvgX8Bk4eT/HMt4rmX+SE2U0WhFN
	YPqayNp5GeKpSsbx/NA8AXHuHDgFSezAR/EqwjZ7Vy2dL5ysay//kdu7wGX+TAVFld405My
	txUiM1XAqE5SQ6fjNapmJvnLHu/84p680Bwb2EqpvmMEoXVHTAvbNCgbWi/v8RQToPmjwKQ
	OE9U7dQ7gcnHwI2jPRgkeckp/knpslSR7+CL4iDPcraggDga2R0yH40Ht+4sMs5D8y2587e
	JG3bOBuAWq38G6T6z9DxnPtDBbWoTw2K6HF0FVey505WOMr9/IHi6YFetUYnyyYr3p4pPCf
	5CLV1dIeBuTmuD5VxYN5gIqD8XLOIUbY1MYX31mnrpM212bTZLdPHvxQotWv1ieOc+9fMbm
	dUYkgSkJweb8xErg4MQxR0ybeqLc34aC/ag0duKvO/IfiUuhJ5DpsZBrz2ZoD1XIMn5GeIT
	XzpIwcOPc/lg5R7035K3gJREu9sPvTKB+VFBZr4hF6hvqsutLWWlpr7IoEr134IB2j8kKlQ
	O7C04skgFt2UPJSqtcZ9I0=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The driver needs to handle GPIO interrupts to identify SFP module and
configure PHY by sending mailbox messages to firmware.

Since the SFP module needs to wait for ready to get information when it
is inserted, workqueue is added to handle delayed tasks. And each SW-FW
interaction takes time to wait, so they are processed in the workqueue
instead of IRQ handler function.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  31 +++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   8 +
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 204 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |   5 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  35 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  74 ++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  75 +++++++
 8 files changed, 433 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 68e7cfe2f7ea..5c747509d56b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -5,6 +5,7 @@
 #include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/inet_ecn.h>
+#include <linux/workqueue.h>
 #include <linux/iopoll.h>
 #include <linux/sctp.h>
 #include <linux/pci.h>
@@ -3095,5 +3096,35 @@ void wx_set_ring(struct wx *wx, u32 new_tx_count,
 }
 EXPORT_SYMBOL(wx_set_ring);
 
+void wx_service_event_schedule(struct wx *wx)
+{
+	if (!test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
+		queue_work(system_power_efficient_wq, &wx->service_task);
+}
+EXPORT_SYMBOL(wx_service_event_schedule);
+
+void wx_service_event_complete(struct wx *wx)
+{
+	if (WARN_ON(!test_bit(WX_STATE_SERVICE_SCHED, wx->state)))
+		return;
+
+	/* flush memory to make sure state is correct before next watchdog */
+	smp_mb__before_atomic();
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+EXPORT_SYMBOL(wx_service_event_complete);
+
+void wx_service_timer(struct timer_list *t)
+{
+	struct wx *wx = from_timer(wx, t, service_timer);
+	unsigned long next_event_offset = HZ * 2;
+
+	/* Reset the timer */
+	mod_timer(&wx->service_timer, next_event_offset + jiffies);
+
+	wx_service_event_schedule(wx);
+}
+EXPORT_SYMBOL(wx_service_timer);
+
 MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index 49f8bde36ddb..aed6ea8cf0d6 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -38,5 +38,8 @@ netdev_features_t wx_features_check(struct sk_buff *skb,
 				    netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
+void wx_service_event_schedule(struct wx *wx);
+void wx_service_event_complete(struct wx *wx);
+void wx_service_timer(struct timer_list *t);
 
 #endif /* _WX_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b4275ba622de..7730c9fc3e02 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1154,6 +1154,7 @@ enum wx_state {
 	WX_STATE_SWFW_BUSY,
 	WX_STATE_PTP_RUNNING,
 	WX_STATE_PTP_TX_IN_PROGRESS,
+	WX_STATE_SERVICE_SCHED,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1197,6 +1198,8 @@ enum wx_pf_flags {
 	WX_FLAG_RX_HWTSTAMP_ENABLED,
 	WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
 	WX_FLAG_PTP_PPS_ENABLED,
+	WX_FLAG_NEED_LINK_CONFIG,
+	WX_FLAG_NEED_SFP_RESET,
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
@@ -1235,6 +1238,8 @@ struct wx {
 
 	/* PHY stuff */
 	bool notify_down;
+	int adv_speed;
+	int adv_duplex;
 	unsigned int link;
 	int speed;
 	int duplex;
@@ -1332,6 +1337,9 @@ struct wx {
 	struct ptp_clock_info ptp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct sk_buff *ptp_tx_skb;
+
+	struct timer_list service_timer;
+	struct work_struct service_task;
 };
 
 #define WX_INTR_ALL (~0ULL)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index 49eb93987a9d..af12ebb89c71 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -13,6 +13,96 @@
 #include "txgbe_aml.h"
 #include "txgbe_hw.h"
 
+void txgbe_gpio_init_aml(struct wx *wx)
+{
+	u32 status;
+
+	wr32(wx, WX_GPIO_INTTYPE_LEVEL, TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3);
+	wr32(wx, WX_GPIO_INTEN, TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3);
+
+	status = rd32(wx, WX_GPIO_INTSTATUS);
+	for (int i = 0; i < 6; i++) {
+		if (status & BIT(i))
+			wr32(wx, WX_GPIO_EOI, BIT(i));
+	}
+}
+
+irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data)
+{
+	struct txgbe *txgbe = data;
+	struct wx *wx = txgbe->wx;
+	u32 status;
+
+	wr32(wx, WX_GPIO_INTMASK, 0xFF);
+	status = rd32(wx, WX_GPIO_INTSTATUS);
+	if (status & TXGBE_GPIOBIT_2) {
+		set_bit(WX_FLAG_NEED_SFP_RESET, wx->flags);
+		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_2);
+		wx_service_event_schedule(wx);
+	}
+	if (status & TXGBE_GPIOBIT_3) {
+		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+		wx_service_event_schedule(wx);
+		wr32(wx, WX_GPIO_EOI, TXGBE_GPIOBIT_3);
+	}
+
+	wr32(wx, WX_GPIO_INTMASK, 0);
+	return IRQ_HANDLED;
+}
+
+static int txgbe_identify_sfp_hostif(struct wx *wx, struct txgbe_hic_i2c_read *buffer)
+{
+	buffer->hdr.cmd = FW_READ_SFP_INFO_CMD;
+	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
+			      sizeof(struct wx_hic_hdr);
+	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+
+	return wx_host_interface_command(wx, (u32 *)buffer,
+					 sizeof(struct txgbe_hic_i2c_read),
+					 WX_HI_COMMAND_TIMEOUT, true);
+}
+
+static int txgbe_set_phy_link_hostif(struct wx *wx, int speed, int autoneg, int duplex)
+{
+	struct txgbe_hic_ephy_setlink buffer;
+
+	buffer.hdr.cmd = FW_PHY_SET_LINK_CMD;
+	buffer.hdr.buf_len = sizeof(struct txgbe_hic_ephy_setlink) -
+			     sizeof(struct wx_hic_hdr);
+	buffer.hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
+
+	switch (speed) {
+	case SPEED_25000:
+		buffer.speed = TXGBE_LINK_SPEED_25GB_FULL;
+		break;
+	case SPEED_10000:
+		buffer.speed = TXGBE_LINK_SPEED_10GB_FULL;
+		break;
+	}
+
+	buffer.fec_mode = TXGBE_PHY_FEC_AUTO;
+	buffer.autoneg = autoneg;
+	buffer.duplex = duplex;
+
+	return wx_host_interface_command(wx, (u32 *)&buffer, sizeof(buffer),
+					 WX_HI_COMMAND_TIMEOUT, true);
+}
+
+static void txgbe_get_link_capabilities(struct wx *wx)
+{
+	struct txgbe *txgbe = wx->priv;
+
+	if (test_bit(PHY_INTERFACE_MODE_25GBASER, txgbe->sfp_interfaces))
+		wx->adv_speed = SPEED_25000;
+	else if (test_bit(PHY_INTERFACE_MODE_10GBASER, txgbe->sfp_interfaces))
+		wx->adv_speed = SPEED_10000;
+	else
+		wx->adv_speed = SPEED_UNKNOWN;
+
+	wx->adv_duplex = wx->adv_speed == SPEED_UNKNOWN ?
+			 DUPLEX_HALF : DUPLEX_FULL;
+}
+
 static void txgbe_get_phy_link(struct wx *wx, int *speed)
 {
 	u32 status;
@@ -28,6 +118,120 @@ static void txgbe_get_phy_link(struct wx *wx, int *speed)
 		*speed = SPEED_UNKNOWN;
 }
 
+int txgbe_set_phy_link(struct wx *wx)
+{
+	int speed, err;
+	u32 gpio;
+
+	/* Check RX signal */
+	gpio = rd32(wx, WX_GPIO_EXT);
+	if (gpio & TXGBE_GPIOBIT_3)
+		return -ENODEV;
+
+	txgbe_get_link_capabilities(wx);
+	if (wx->adv_speed == SPEED_UNKNOWN)
+		return -ENODEV;
+
+	txgbe_get_phy_link(wx, &speed);
+	if (speed == wx->adv_speed)
+		return 0;
+
+	err = txgbe_set_phy_link_hostif(wx, wx->adv_speed, 0, wx->adv_duplex);
+	if (err) {
+		wx_err(wx, "Failed to setup link\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sfp_id *id)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	struct txgbe *txgbe = wx->priv;
+
+	if (id->com_25g_code & (TXGBE_SFF_25GBASESR_CAPABLE |
+				TXGBE_SFF_25GBASEER_CAPABLE |
+				TXGBE_SFF_25GBASELR_CAPABLE)) {
+		phylink_set(modes, 25000baseSR_Full);
+		__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+	}
+	if (id->com_10g_code & TXGBE_SFF_10GBASESR_CAPABLE) {
+		phylink_set(modes, 10000baseSR_Full);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+	}
+	if (id->com_10g_code & TXGBE_SFF_10GBASELR_CAPABLE) {
+		phylink_set(modes, 10000baseLR_Full);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER, interfaces);
+	}
+
+	if (phy_interface_empty(interfaces)) {
+		wx_err(wx, "unsupported SFP module\n");
+		return -EINVAL;
+	}
+
+	phylink_set(modes, Pause);
+	phylink_set(modes, Asym_Pause);
+	phylink_set(modes, FIBRE);
+	txgbe->link_port = PORT_FIBRE;
+
+	if (!linkmode_equal(txgbe->sfp_support, modes)) {
+		linkmode_copy(txgbe->sfp_support, modes);
+		phy_interface_and(txgbe->sfp_interfaces,
+				  wx->phylink_config.supported_interfaces,
+				  interfaces);
+		linkmode_copy(txgbe->advertising, modes);
+
+		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+	}
+
+	return 0;
+}
+
+int txgbe_identify_sfp(struct wx *wx)
+{
+	struct txgbe_hic_i2c_read buffer;
+	struct txgbe_sfp_id *id;
+	int err = 0;
+	u32 gpio;
+
+	gpio = rd32(wx, WX_GPIO_EXT);
+	if (gpio & TXGBE_GPIOBIT_2)
+		return -ENODEV;
+
+	err = txgbe_identify_sfp_hostif(wx, &buffer);
+	if (err) {
+		wx_err(wx, "Failed to identify SFP module\n");
+		return err;
+	}
+
+	id = &buffer.id;
+	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP) {
+		wx_err(wx, "Invalid SFP module\n");
+		return -ENODEV;
+	}
+
+	err = txgbe_sfp_to_linkmodes(wx, id);
+	if (err)
+		return err;
+
+	if (gpio & TXGBE_GPIOBIT_3)
+		set_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+
+	return 0;
+}
+
+void txgbe_setup_link(struct wx *wx)
+{
+	struct txgbe *txgbe = wx->priv;
+
+	phy_interface_zero(txgbe->sfp_interfaces);
+	linkmode_zero(txgbe->sfp_support);
+
+	txgbe_identify_sfp(wx);
+}
+
 static void txgbe_get_link_state(struct phylink_config *config,
 				 struct phylink_link_state *state)
 {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
index aa3b7848e03d..2376a021ba8d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
@@ -4,6 +4,11 @@
 #ifndef _TXGBE_AML_H_
 #define _TXGBE_AML_H_
 
+void txgbe_gpio_init_aml(struct wx *wx);
+irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
+int txgbe_set_phy_link(struct wx *wx);
+int txgbe_identify_sfp(struct wx *wx);
+void txgbe_setup_link(struct wx *wx);
 int txgbe_phylink_init_aml(struct txgbe *txgbe);
 
 #endif /* _TXGBE_AML_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index f53a5d00a41b..05fe8fd43b80 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -11,6 +11,7 @@
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
 #include "txgbe_irq.h"
+#include "txgbe_aml.h"
 
 /**
  * txgbe_irq_enable - Enable default interrupt generation settings
@@ -19,7 +20,14 @@
  **/
 void txgbe_irq_enable(struct wx *wx, bool queues)
 {
-	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
+	u32 misc_ien = TXGBE_PX_MISC_IEN_MASK;
+
+	if (wx->mac.type == wx_mac_aml) {
+		misc_ien |= TXGBE_PX_MISC_GPIO;
+		txgbe_gpio_init_aml(wx);
+	}
+
+	wr32(wx, WX_PX_MISC_IEN, misc_ien);
 
 	/* unmask interrupt */
 	wx_intr_enable(wx, TXGBE_INTR_MISC);
@@ -81,6 +89,14 @@ static int txgbe_request_link_irq(struct txgbe *txgbe)
 				    IRQF_ONESHOT, "txgbe-link-irq", txgbe);
 }
 
+static int txgbe_request_gpio_irq(struct txgbe *txgbe)
+{
+	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+	return request_threaded_irq(txgbe->gpio_irq, NULL,
+				    txgbe_gpio_irq_handler_aml,
+				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
+}
+
 static const struct irq_chip txgbe_irq_chip = {
 	.name = "txgbe-misc-irq",
 };
@@ -157,6 +173,11 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		handle_nested_irq(sub_irq);
 		nhandled++;
 	}
+	if (eicr & TXGBE_PX_MISC_GPIO) {
+		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
+		handle_nested_irq(sub_irq);
+		nhandled++;
+	}
 
 	wx_intr_enable(wx, TXGBE_INTR_MISC);
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
@@ -179,6 +200,9 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 	if (txgbe->wx->mac.type == wx_mac_aml40)
 		return;
 
+	if (txgbe->wx->mac.type == wx_mac_aml)
+		free_irq(txgbe->gpio_irq, txgbe);
+
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
@@ -222,11 +246,20 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (err)
 		goto free_msic_irq;
 
+	if (wx->mac.type == wx_mac_sp)
+		goto skip_sp_irq;
+
+	err = txgbe_request_gpio_irq(txgbe);
+	if (err)
+		goto free_link_irq;
+
 skip_sp_irq:
 	wx->misc_irq_domain = true;
 
 	return 0;
 
+free_link_irq:
+	free_irq(txgbe->link_irq, txgbe);
 free_msic_irq:
 	free_irq(txgbe->misc.irq, txgbe);
 del_misc_irq:
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ca3dbc448646..6f3b67def51a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -21,6 +21,7 @@
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
+#include "txgbe_aml.h"
 #include "txgbe_irq.h"
 #include "txgbe_fdir.h"
 #include "txgbe_ethtool.h"
@@ -88,6 +89,58 @@ static int txgbe_enumerate_functions(struct wx *wx)
 	return physfns;
 }
 
+static void txgbe_sfp_detection_subtask(struct wx *wx)
+{
+	int err;
+
+	if (!test_bit(WX_FLAG_NEED_SFP_RESET, wx->flags))
+		return;
+
+	/* wait for SFP module ready */
+	msleep(200);
+
+	err = txgbe_identify_sfp(wx);
+	if (err)
+		return;
+
+	clear_bit(WX_FLAG_NEED_SFP_RESET, wx->flags);
+}
+
+static void txgbe_link_config_subtask(struct wx *wx)
+{
+	int err;
+
+	if (!test_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
+		return;
+
+	err = txgbe_set_phy_link(wx);
+	if (err)
+		return;
+
+	clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
+}
+
+/**
+ * txgbe_service_task - manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+static void txgbe_service_task(struct work_struct *work)
+{
+	struct wx *wx = container_of(work, struct wx, service_task);
+
+	txgbe_sfp_detection_subtask(wx);
+	txgbe_link_config_subtask(wx);
+
+	wx_service_event_complete(wx);
+}
+
+static void txgbe_init_service(struct wx *wx)
+{
+	timer_setup(&wx->service_timer, wx_service_timer, 0);
+	INIT_WORK(&wx->service_task, txgbe_service_task);
+	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
+}
+
 static void txgbe_up_complete(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
@@ -110,6 +163,11 @@ static void txgbe_up_complete(struct wx *wx)
 		netif_carrier_on(wx->netdev);
 		break;
 	case wx_mac_aml:
+		/* Enable TX laser */
+		wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, 0);
+		txgbe_setup_link(wx);
+		phylink_start(wx->phylink);
+		break;
 	case wx_mac_sp:
 		phylink_start(wx->phylink);
 		break;
@@ -125,6 +183,7 @@ static void txgbe_up_complete(struct wx *wx)
 
 	/* enable transmits */
 	netif_tx_start_all_queues(netdev);
+	mod_timer(&wx->service_timer, jiffies);
 
 	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
 	wr32m(wx, WX_CFG_PORT_CTL, WX_CFG_PORT_CTL_PFRSTD,
@@ -173,6 +232,8 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_irq_disable(wx);
 	wx_napi_disable_all(wx);
 
+	timer_delete_sync(&wx->service_timer);
+
 	if (wx->bus.func < 2)
 		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);
 	else
@@ -218,6 +279,10 @@ void txgbe_down(struct wx *wx)
 		netif_carrier_off(wx->netdev);
 		break;
 	case wx_mac_aml:
+		phylink_stop(wx->phylink);
+		/* Disable TX laser */
+		wr32m(wx, WX_GPIO_DR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		break;
 	case wx_mac_sp:
 		phylink_stop(wx->phylink);
 		break;
@@ -752,9 +817,11 @@ static int txgbe_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
 
+	txgbe_init_service(wx);
+
 	err = wx_init_interrupt_scheme(wx);
 	if (err)
-		goto err_free_mac_table;
+		goto err_cancel_service;
 
 	/* Save off EEPROM version number and Option Rom version which
 	 * together make a unique identify for the eeprom
@@ -847,6 +914,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
+err_cancel_service:
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
 err_free_mac_table:
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
@@ -873,6 +943,8 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct txgbe *txgbe = wx->priv;
 	struct net_device *netdev;
 
+	cancel_work_sync(&wx->service_task);
+
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index ca4da2696eed..98bd25254c80 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -6,6 +6,8 @@
 
 #include <linux/property.h>
 #include <linux/irq.h>
+#include <linux/phy.h>
+#include "../libwx/wx_type.h"
 
 /* Device IDs */
 #define TXGBE_DEV_ID_SP1000                     0x1001
@@ -311,6 +313,72 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev);
 
+#define TXGBE_LINK_SPEED_10GB_FULL      4
+#define TXGBE_LINK_SPEED_25GB_FULL      0x10
+
+#define TXGBE_SFF_IDENTIFIER_SFP        0x3
+#define TXGBE_SFF_DA_PASSIVE_CABLE      0x4
+#define TXGBE_SFF_DA_ACTIVE_CABLE       0x8
+#define TXGBE_SFF_DA_SPEC_ACTIVE_LIMIT  0x4
+#define TXGBE_SFF_FCPI4_LIMITING        0x3
+#define TXGBE_SFF_10GBASESR_CAPABLE     0x10
+#define TXGBE_SFF_10GBASELR_CAPABLE     0x20
+#define TXGBE_SFF_25GBASESR_CAPABLE     0x2
+#define TXGBE_SFF_25GBASELR_CAPABLE     0x3
+#define TXGBE_SFF_25GBASEER_CAPABLE     0x4
+#define TXGBE_SFF_25GBASECR_91FEC       0xB
+#define TXGBE_SFF_25GBASECR_74FEC       0xC
+#define TXGBE_SFF_25GBASECR_NOFEC       0xD
+
+#define TXGBE_PHY_FEC_RS                BIT(0)
+#define TXGBE_PHY_FEC_BASER             BIT(1)
+#define TXGBE_PHY_FEC_OFF               BIT(2)
+#define TXGBE_PHY_FEC_AUTO              (TXGBE_PHY_FEC_OFF | \
+					 TXGBE_PHY_FEC_BASER |\
+					 TXGBE_PHY_FEC_RS)
+
+#define FW_PHY_GET_LINK_CMD             0xC0
+#define FW_PHY_SET_LINK_CMD             0xC1
+#define FW_READ_SFP_INFO_CMD            0xC5
+
+struct txgbe_sfp_id {
+	u8 identifier;		/* A0H 0x00 */
+	u8 com_1g_code;		/* A0H 0x06 */
+	u8 com_10g_code;	/* A0H 0x03 */
+	u8 com_25g_code;	/* A0H 0x24 */
+	u8 cable_spec;		/* A0H 0x3C */
+	u8 cable_tech;		/* A0H 0x08 */
+	u8 vendor_oui0;		/* A0H 0x25 */
+	u8 vendor_oui1;		/* A0H 0x26 */
+	u8 vendor_oui2;		/* A0H 0x27 */
+	u8 reserved[3];
+};
+
+struct txgbe_hic_i2c_read {
+	struct wx_hic_hdr hdr;
+	struct txgbe_sfp_id id;
+};
+
+struct txgbe_hic_ephy_setlink {
+	struct wx_hic_hdr hdr;
+	u8 speed;
+	u8 duplex;
+	u8 autoneg;
+	u8 fec_mode;
+	u8 resv[4];
+};
+
+struct txgbe_hic_ephy_getlink {
+	struct wx_hic_hdr hdr;
+	u8 speed;
+	u8 duplex;
+	u8 autoneg;
+	u8 flow_ctl;
+	u8 power;
+	u8 fec_mode;
+	u8 resv[6];
+};
+
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
 		.name = _NAME,			\
@@ -348,6 +416,7 @@ struct txgbe_nodes {
 
 enum txgbe_misc_irqs {
 	TXGBE_IRQ_LINK = 0,
+	TXGBE_IRQ_GPIO,
 	TXGBE_IRQ_MAX
 };
 
@@ -369,6 +438,7 @@ struct txgbe {
 	struct clk *clk;
 	struct gpio_chip *gpio;
 	unsigned int link_irq;
+	unsigned int gpio_irq;
 	u32 eicr;
 
 	/* flow director */
@@ -376,6 +446,11 @@ struct txgbe {
 	union txgbe_atr_input fdir_mask;
 	int fdir_filter_count;
 	spinlock_t fdir_perfect_lock; /* spinlock for FDIR */
+
+	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
+	u8 link_port;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.48.1


