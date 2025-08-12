Return-Path: <netdev+bounces-212835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30765B2238B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA1150458A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD32EA730;
	Tue, 12 Aug 2025 09:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B172EA16E;
	Tue, 12 Aug 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991673; cv=none; b=ettNIE9/yxV+kI7gWSV4nGmpdnjx79GniFkTDtiIBINfuAWQirZwh6eHKMy9BVzrW2lMVKk7sb2cH7be2Yg+46wE4P5+fCT36xVg5RU7b6xlaL641Z99diaVG7TqrLsMznG08I9cMtwCwUb7+zo4vdJznpQzdAKPfr0hz71dZd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991673; c=relaxed/simple;
	bh=n6e00EncJITyfR7gATzZvlsIcyq4HKpGRztpLjtqiCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwnmqgJyEEuLp3wefPQilI4+JE2R2UuFFxS2LHU6Jvy54RGV8bHAo6ZWFrdFLOf3f5rVkwrZVS7wTwU6QlJ60q8sq5qG3w8DU68guewexegdPPwbkTn1jEu7CgjOwOrY1fjUpWZGvpWTR3L7XSWXZjIUtLLh5IfcG0yNWMia110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991609teb2437b0
X-QQ-Originating-IP: rtIzCFuKJ5+54blkKtztRANy15mOL3tB8Qcy4JLsHno=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:40:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16346924292247263763
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v3 3/5] net: rnpgbe: Add basic mbx ops support
Date: Tue, 12 Aug 2025 17:39:35 +0800
Message-Id: <20250812093937.882045-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250812093937.882045-1-dong100@mucse.com>
References: <20250812093937.882045-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MpO6L0LObisWHx7JzHigqEgjocqqxVkNQjbLtxAaGQJPdd5nWKWgS5PS
	zHGuz6tnwn+GeKtPD1jhTzk5eqNat9j8UXvj6NlfuotHBt5AIu+JdG/M9+/xhne0Ao2kjMd
	BIjOGQYEbM7Rb54r1tbH1jbUkD8HBnr7ZPngIfrUilTdYr1oDFEDrmHa80i4r4+YDadhqPC
	ZjojF95SsBssrEmYjouXdw27mMssUaliHo3WZjGz/kMgN6XaXcNAPtTPZ7QtrkFo0ZqlHhu
	KlB4iuy5DfidHTktiAJ69VhhLp5kovyfkBAV0mIejpifd4AXe/JgPV+ivy+ygZBIx8nM2xM
	MSptV0dQcRJYrfOxygGze1ipe6nl1x3hPtm8GmDZE9u/CZ99KW2py2eHA7ld8T/BMGdhZ3L
	OyiuKCJmvC0kEtgZmQkecfW+R+jlGudcuLLf31yZdn/O59NUUUXw1LU9vT/oTA7/yZEl+2N
	6JGRCeFbIGRZnD6Op+tpsySY954WogokvClOFLekuRd40kdgmPojR1jDzCBU40d3IS0PnBE
	Ey+xkVmdE5ql88w3pzWNLm2CAFuNSaxJujQrztcnXTj6onM7eEd5/nRglU1F1D0f1jYDUHz
	iV0ncvWmoFzBBE48frM438IPEJEXN0I/mwWLAJ6KDYTJPqmJjvAdwikyKSyV9GxazXKWkAR
	3Hu1OrIvY7PHBBrNqtv1/zgJb7X4CfJT5EmCvh+J+jcxqqh8AQTcg4546oHRkI6CpmW5jUO
	5KnLqgQpQAHqsiskN9rt8Qe8ncRilrQ9oEXAK3zrgZq2NOZqJ61+YbYR2PhrJ/DGV6cSDLF
	14x/wEdYC6spUAHiauD2Ng6SQ39WRek0qvZlAUsJnaJP6w6THNt+eAr6hHg3zMKz82rlux2
	fmCNfldDrvF1ILEGjGUz8P9bPBdTWf6POFRt3ZpZFDcR1FbusqPyXdWR334ow8qDxKD0Ry4
	hNBnhzywR3KP0ujyi5qtSWdap4MjZH5Fv3D845YJoJY3Ymsp8/rSvNtwdmRAuJzDKWebNoI
	IzckvqCHOYuTnf7Wt8AJXyrnsoLUX75VUvUDpYh+cBQX47AgPVXAyecaUKJbFm3cmW2/SWC
	B41ecc24HW2
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize basic mbx function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  37 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 6 files changed, 520 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 42c359f459d9..5fc878ada4b1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -6,4 +6,5 @@
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
 rnpgbe-objs := rnpgbe_main.o\
-	       rnpgbe_chip.o
+	       rnpgbe_chip.o\
+	       rnpgbe_mbx.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 0dd3d3cb2a4d..05830bb73d3e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -40,7 +41,43 @@ struct mucse_mac_info {
 	void *back;
 };
 
+struct mucse_hw;
+
+struct mucse_mbx_operations {
+	void (*init_params)(struct mucse_hw *hw);
+	int (*read)(struct mucse_hw *hw, u32 *msg,
+		    u16 size);
+	int (*write)(struct mucse_hw *hw, u32 *msg,
+		     u16 size);
+	int (*read_posted)(struct mucse_hw *hw, u32 *msg,
+			   u16 size);
+	int (*write_posted)(struct mucse_hw *hw, u32 *msg,
+			    u16 size);
+	int (*check_for_msg)(struct mucse_hw *hw);
+	int (*check_for_ack)(struct mucse_hw *hw);
+	void (*configure)(struct mucse_hw *hw, int num_vec,
+			  bool enable);
+};
+
+struct mucse_mbx_stats {
+	u32 msgs_tx;
+	u32 msgs_rx;
+	u32 acks;
+	u32 reqs;
+	u32 rsts;
+};
+
 struct mucse_mbx_info {
+	const struct mucse_mbx_operations *ops;
+	struct mucse_mbx_stats stats;
+	u32 timeout;
+	u32 usec_delay;
+	u16 size;
+	u16 fw_req;
+	u16 fw_ack;
+	/* lock for only one use mbx */
+	struct mutex lock;
+	bool irq_enabled;
 	/* fw <--> pf mbx */
 	u32 fw_pf_shm_base;
 	u32 pf2fw_mbox_ctrl;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 20ec67c9391e..16d0a76114b5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2020 - 2025 Mucse Corporation. */
 
+#include <linux/string.h>
+
 #include "rnpgbe.h"
 #include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
 
 /**
  * rnpgbe_init_common - Setup common attribute
@@ -23,6 +26,8 @@ static void rnpgbe_init_common(struct mucse_hw *hw)
 
 	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
 	mac->back = hw;
+
+	hw->mbx.ops = &mucse_mbx_ops_generic;
 }
 
 /**
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index fc57258537cf..aee037e3219d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -7,6 +7,8 @@
 #define RNPGBE_RING_BASE 0x1000
 #define RNPGBE_MAC_BASE 0x20000
 #define RNPGBE_ETH_BASE 0x10000
+/**************** DMA Registers ****************************/
+#define RNPGBE_DMA_DUMY 0x000c
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..1195cf945ad1
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_mbx.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * mucse_read_mbx - Reads a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	/* limit read size */
+	min(size, mbx->size);
+	return mbx->ops->read(hw, msg, size);
+}
+
+/**
+ * mucse_write_mbx - Write a message to the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	return mbx->ops->write(hw, msg, size);
+}
+
+/**
+ * mucse_mbx_get_req - Read req from reg
+ * @hw: pointer to the HW structure
+ * @reg: register to read
+ *
+ * @return: the req value
+ **/
+static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
+{
+	return mbx_rd32(hw, reg) & GENMASK(15, 0);
+}
+
+/**
+ * mucse_mbx_get_ack - Read ack from reg
+ * @hw: pointer to the HW structure
+ * @reg: register to read
+ *
+ * @return: the ack value
+ **/
+static u16 mucse_mbx_get_ack(struct mucse_hw *hw, int reg)
+{
+	return (mbx_rd32(hw, reg) >> 16);
+}
+
+/**
+ * mucse_mbx_inc_pf_req - Increase req
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_inc_pf_req read pf_req from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg, v;
+	u16 req;
+
+	reg = PF2FW_COUNTER(mbx);
+	v = mbx_rd32(hw, reg);
+	req = (v & GENMASK(15, 0));
+	req++;
+	v &= GENMASK(31, 16);
+	v |= req;
+	mbx_wr32(hw, reg, v);
+	hw->mbx.stats.msgs_tx++;
+}
+
+/**
+ * mucse_mbx_inc_pf_ack - Increase ack
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
+ * new value back after increase
+ **/
+static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg, v;
+	u16 ack;
+
+	reg = PF2FW_COUNTER(mbx);
+	v = mbx_rd32(hw, reg);
+	ack = (v >> 16) & GENMASK(15, 0);
+	ack++;
+	v &= GENMASK(15, 0);
+	v |= (ack << 16);
+	mbx_wr32(hw, reg, v);
+	hw->mbx.stats.msgs_rx++;
+}
+
+/**
+ * mucse_check_for_msg - Check to see if fw sent us mail
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_msg(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	return mbx->ops->check_for_msg(hw);
+}
+
+/**
+ * mucse_check_for_ack - Check to see if fw sent us ACK
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int mucse_check_for_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	return mbx->ops->check_for_ack(hw);
+}
+
+/**
+ * mucse_poll_for_msg - Wait for message notification
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_poll_for_msg(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	return read_poll_timeout(mbx->ops->check_for_msg,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_poll_for_ack - Wait for message acknowledgment
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if it successfully received a message acknowledgment
+ **/
+static int mucse_poll_for_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+	int val;
+
+	return read_poll_timeout(mbx->ops->check_for_ack,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_read_posted_mbx - Wait for message notification and receive message
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer.
+ **/
+static int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int ret;
+
+	ret = mucse_poll_for_msg(hw);
+	if (ret)
+		return ret;
+
+	return mbx->ops->read(hw, msg, size);
+}
+
+/**
+ * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * @return: 0 if it successfully copied message into the buffer and
+ * received an ack to that message within delay * timeout period
+ **/
+static int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int ret;
+
+	ret = mbx->ops->write(hw, msg, size);
+	if (ret)
+		return ret;
+	return mucse_poll_for_ack(hw);
+}
+
+/**
+ * mucse_check_for_msg_pf - Check to see if the fw has sent mail
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if the fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_msg_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 hw_req_count = 0;
+
+	hw_req_count = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'hw_req_count != hw->mbx.fw_req'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (hw_req_count != 0 && hw_req_count != hw->mbx.fw_req) {
+		hw->mbx.stats.reqs++;
+		return 0;
+	}
+
+	return -EIO;
+}
+
+/**
+ * mucse_check_for_ack_pf - Check to see if the VF has ACKed
+ * @hw: pointer to the HW structure
+ *
+ * @return: 0 if the fw has set the Status bit or else
+ * -EIO
+ **/
+static int mucse_check_for_ack_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 hw_fw_ack;
+
+	hw_fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'hw_fw_ack != hw->mbx.fw_ack'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (hw_fw_ack != 0 && hw_fw_ack != hw->mbx.fw_ack) {
+		hw->mbx.stats.acks++;
+		return 0;
+	}
+
+	return -EIO;
+}
+
+/**
+ * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
+ * @hw: pointer to the HW structure
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if we obtained the mailbox lock
+ **/
+static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int try_cnt = 5000;
+	u32 reg;
+
+	reg = PF2FW_MBOX_CTRL(mbx);
+	while (try_cnt-- > 0) {
+		mbx_wr32(hw, reg, MBOX_PF_HOLD);
+		/* force write back before check */
+		wmb();
+		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
+			return 0;
+		udelay(100);
+	}
+	return -EIO;
+}
+
+/**
+ * mucse_write_mbx_pf - Place a message in the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * This function maybe used in an irq handler.
+ *
+ * @return: 0 if it successfully copied message into the buffer
+ **/
+static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 data_reg, ctrl_reg;
+	int ret;
+	u16 i;
+
+	data_reg = FW_PF_SHM_DATA(mbx);
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++)
+		mbx_wr32(hw, data_reg + i * 4, msg[i]);
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	hw->mbx.fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
+	mucse_mbx_inc_pf_req(hw);
+	mbx_wr32(hw, ctrl_reg, MBOX_CTRL_REQ);
+
+	return 0;
+}
+
+/**
+ * mucse_read_mbx_pf - Read a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * This function copies a message from the mailbox buffer to the caller's
+ * memory buffer. The presumption is that the caller knows that there was
+ * a message due to a fw request so no polling for message is needed.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 data_reg, ctrl_reg;
+	int ret;
+	u32 i;
+
+	data_reg = FW_PF_SHM_DATA(mbx);
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+	for (i = 0; i < size; i++)
+		msg[i] = mbx_rd32(hw, data_reg + 4 * i);
+	/* Hw need write data_reg at last */
+	mbx_wr32(hw, data_reg, 0);
+	hw->mbx.fw_req = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
+	mucse_mbx_inc_pf_ack(hw);
+	mbx_wr32(hw, ctrl_reg, 0);
+
+	return 0;
+}
+
+/**
+ * mucse_mbx_reset - Reset mbx info, sync info from regs
+ * @hw: pointer to the HW structure
+ *
+ * This function reset all mbx variables to default.
+ **/
+static void mucse_mbx_reset(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int v;
+
+	v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+	hw->mbx.fw_req = v & GENMASK(15, 0);
+	hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+	mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+	mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+}
+
+/**
+ * mucse_mbx_configure_pf - Configure mbx to use nr_vec interrupt
+ * @hw: pointer to the HW structure
+ * @nr_vec: vector number for mbx
+ * @enable: TRUE for enable, FALSE for disable
+ *
+ * This function configure mbx to use interrupt nr_vec.
+ **/
+static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
+				   bool enable)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 v;
+
+	if (enable) {
+		v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
+		hw->mbx.fw_req = v & GENMASK(15, 0);
+		hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+		mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
+	} else {
+		mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
+		mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
+		mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
+	}
+}
+
+/**
+ * mucse_init_mbx_params_pf - Set initial values for pf mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Initializes the hw->mbx struct to correct values for pf mailbox
+ */
+static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->usec_delay = 100;
+	mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mbx->stats.rsts = 0;
+	mbx->size = MUCSE_MAILBOX_WORDS;
+	mutex_init(&mbx->lock);
+	mucse_mbx_reset(hw);
+}
+
+const struct mucse_mbx_operations mucse_mbx_ops_generic = {
+	.init_params = mucse_init_mbx_params_pf,
+	.read = mucse_read_mbx_pf,
+	.write = mucse_write_mbx_pf,
+	.read_posted = mucse_read_posted_mbx,
+	.write_posted = mucse_write_posted_mbx,
+	.check_for_msg = mucse_check_for_msg_pf,
+	.check_for_ack = mucse_check_for_ack_pf,
+	.configure = mucse_mbx_configure_pf,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..2d850a11c369
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+
+#define MUCSE_MAILBOX_WORDS 14
+#define MUCSE_FW_MAILBOX_WORDS MUCSE_MAILBOX_WORDS
+#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
+#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
+#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
+#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
+#define FW2PF_MBOX_VEC(mbx) ((mbx)->fw2pf_mbox_vec)
+#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
+#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
+#define MBOX_CTRL_REQ BIT(0)
+#define MBOX_PF_HOLD BIT(3)
+#define MBOX_IRQ_EN 0
+#define MBOX_IRQ_DISABLE 1
+#define mbx_rd32(hw, reg) readl((hw)->hw_addr + (reg))
+#define mbx_wr32(hw, reg, val) writel((val), (hw)->hw_addr + (reg))
+
+extern const struct mucse_mbx_operations mucse_mbx_ops_generic;
+
+int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_check_for_msg(struct mucse_hw *hw);
+int mucse_check_for_ack(struct mucse_hw *hw);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


