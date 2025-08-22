Return-Path: <netdev+bounces-215883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C8AB30BEC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8FE5E29FC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF21E9B35;
	Fri, 22 Aug 2025 02:35:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303119E97A;
	Fri, 22 Aug 2025 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830136; cv=none; b=ZZA1Wi7/bPGaJtjt/gZv8plXmVoiozT/w/cXn3LjTAmdNRmjfCjgNKAe0idZN6QpagydhO14CnSZcQDfL3ygk39BVNcNYItCgS92Lvvhv9Hq1dYX35HbN1Z5pCGdncu1A+bGIbxdksLEczXd3FDCu9716Klyd33V3ZispOjToys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830136; c=relaxed/simple;
	bh=n+OCV/kSNWsv+APoEzZ4JFFL8b+thyqTc0wsyRQj6AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWj5phG0yZ7fTOImGhQHq10cCja3gzrc36YhyS7uRSk5+PHjSWwCToY8SlyHVbFXETAYDVcf1wuIX5h9o+k1/r4+3nJpzJ0E0Dc6p1vpiUzUFoEdCQ3hj3Te5VY7BgL93gAIZiHr3GLqMqb0CmjQ/7yHr4VWzqy6OQ0RdEBEIus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755830116t6f8a15fe
X-QQ-Originating-IP: HE118qCeh1rFcCuUIAqtVj3Gz5cMYjAgoKC/BLUruFY=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 10:35:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11203629229566898037
EX-QQ-RecipientCnt: 26
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
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v7 3/5] net: rnpgbe: Add basic mbx ops support
Date: Fri, 22 Aug 2025 10:34:51 +0800
Message-Id: <20250822023453.1910972-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822023453.1910972-1-dong100@mucse.com>
References: <20250822023453.1910972-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OVH4KwRWo4QxIbT3yQzyu4sAMP07VTTgpT70sifXvo6aYmIzya2FGtEA
	+JobVfO+ftr4ucg/O1WmQcxJA1ZZOYKWGO/lESuVjX6ZAB5WfUly/Bxt2KshG50vnw8v0b7
	Vyzx7NxSVUzdBIyQT9gOVPP/K0Q1HRgDoHEZu1VexKfH2mMt8qKX0ItWJYXcRCzG2M0AgmD
	yNuddH5Qe6N56j+9Phw72uVw21YetnnRNAyQ9DNi2y0mMlnsDb1nfGJsxRQ4ad5ViZG34DG
	bHntxIcWLl99lZ9Tzlm0ac5RlhK2qXcdDmLi/PBCVr4Pqp43PyBg4k8dQvW2oWxJgwP0TIY
	3YPcPRqLxEc1U11pbE6ejJanMLcSpFyQI2NtLi4xTq5VnhQKCEQBXf8jG7F/4nbHLTMeDWw
	n0k3gjkr+9JKytr++aUaoKCT7G8AZmPtWa964603vvSwlIpCzbzkTFk3Dg8aqJoL5i/pGzt
	c544Er/Y3ZYOzY9qegh3yxbNTzXmbokBr5yBnBZW1OqLZrQGzzudv5e/0EjfcCMq0UZ0pkU
	/PZ0tUvP717TXQxhb2Ft8Zf/DCrLVzUX7bBFbe3KUOMHi81BXqgDUIhawV7ot2JE4QshPqI
	UB5pxPyMl2/5mDAp7Kn1M72Dyrz62yCvn1Fofm7vbWjcziiCLGha/pINdRPRL3NcHB8MlQv
	tHkjt7MdaY9CRvLzgzt8VY5dFMbjETtbLL5C/1QHiOKJf+In0+wf/ZM/Q433dRW4UND5JKH
	3DM/LZvPFHekMW2fyc/19hBGOT/O5c/7tV3egCSHaFd/NQ2OwktB2NyLwvIJiXm1AaweGDD
	dYf0V0WYxIIArj5Ri++jDxaPjUfk8/HWlH0qxOzA8a6T7nOxtFfJXuAMyLPeLFluid5LBSi
	ZNh7bejKzlufEXFY2Sfxg3HqAwwe0NUb84Dt0wah9wV9boOFngpybX1YtpZwszvh7+5mVv5
	UYlRGlCtNvR8wu1p/yP3xLZwQ8iBQCSatAAwUGhrjlg4G/huca9x6uUxjoL7xAjY6aDZa8U
	9sRzjwJLndb4BFigXsrx39lb5q22UthyyWbhy69knZY6Dm0/5MEtcR7xrFCF0s5DJHFs4cQ
	MA2bG7Rcv7Urw5XrpBlrNStklRUWk8kDo3QwOH5ziyqp2OZGXZXH7CfpuDq9g0Udg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Initialize basic mbx function.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   3 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 395 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 5 files changed, 442 insertions(+), 1 deletion(-)
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
index 9a86e67d6395..67e28a4667e7 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -5,6 +5,7 @@
 #define _RNPGBE_H
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -23,7 +24,23 @@ enum rnpgbe_hw_type {
 	rnpgbe_hw_unknown
 };
 
+struct mucse_mbx_stats {
+	u32 msgs_tx;
+	u32 msgs_rx;
+	u32 acks;
+	u32 reqs;
+};
+
 struct mucse_mbx_info {
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
index 179621ea09f3..f38daef752a3 100644
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
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..e02563b994c2
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,395 @@
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
+ * mbx_data_rd32  - Reads reg with base mbx->fw_pf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * @return: register value
+ **/
+static u32 mbx_data_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fw_pf_shm_base + reg);
+}
+
+/**
+ * mbx_data_wr32  - Writes value to reg with base mbx->fw_pf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_data_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fw_pf_shm_base + reg);
+}
+
+/**
+ * mbx_ctrl_rd32  - Reads reg with base mbx->fw2pf_mbox_vec
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * @return: register value
+ **/
+static u32 mbx_ctrl_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fw2pf_mbox_vec + reg);
+}
+
+/**
+ * mbx_ctrl_wr32  - Writes value to reg with base mbx->fw2pf_mbox_vec
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_ctrl_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fw2pf_mbox_vec + reg);
+}
+
+/**
+ * mucse_mbx_get_fwreq - Read fw req from reg
+ * @mbx: pointer to the mbx structure
+ *
+ * @return: the req value
+ **/
+static u16 mucse_mbx_get_fwreq(struct mucse_mbx_info *mbx)
+{
+	return mbx_data_rd32(mbx, MBX_FW2PF_COUNTER) & GENMASK_U32(15, 0);
+}
+
+/**
+ * mucse_mbx_get_fwack - Read fw ack from reg
+ * @mbx: pointer to the MBX structure
+ *
+ * @return: the ack value
+ **/
+static u16 mucse_mbx_get_fwack(struct mucse_mbx_info *mbx)
+{
+	return (mbx_data_rd32(mbx, MBX_FW2PF_COUNTER) >> 16);
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
+	u16 req;
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
+	req = (v & GENMASK_U32(15, 0));
+	req++;
+	v &= GENMASK_U32(31, 16);
+	v |= req;
+	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
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
+	u16 ack;
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
+	ack = (v >> 16) & GENMASK_U32(15, 0);
+	ack++;
+	v &= GENMASK_U32(15, 0);
+	v |= (ack << 16);
+	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
+	hw->mbx.stats.msgs_rx++;
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
+	hw_req_count = mucse_mbx_get_fwreq(mbx);
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
+	return read_poll_timeout(mucse_check_for_msg_pf,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
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
+	hw_fw_ack = mucse_mbx_get_fwack(mbx);
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
+	return read_poll_timeout(mucse_check_for_ack_pf,
+				 val, val == 0, mbx->usec_delay,
+				 countdown * mbx->usec_delay,
+				 false, hw);
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
+		mbx_ctrl_wr32(mbx, reg, MBOX_PF_HOLD);
+		/* force write back before check */
+		wmb();
+		if (mbx_ctrl_rd32(mbx, reg) & MBOX_PF_HOLD)
+			return 0;
+		udelay(100);
+	}
+	return -EIO;
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
+	int size_inwords = size / 4;
+	u32 ctrl_reg;
+	int ret;
+	int i;
+
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+	for (i = 0; i < size_inwords; i++)
+		msg[i] = mbx_data_rd32(mbx, MBX_FW_PF_SHM_DATA + 4 * i);
+	/* Hw need write data_reg at last */
+	mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA, 0);
+	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
+	mucse_mbx_inc_pf_ack(hw);
+	mbx_ctrl_wr32(mbx, ctrl_reg, 0);
+
+	return 0;
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
+int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = mucse_poll_for_msg(hw);
+	if (ret)
+		return ret;
+
+	return mucse_read_mbx_pf(hw, msg, size);
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
+	u32 v;
+
+	v = mbx_data_rd32(mbx, MBX_FW2PF_COUNTER);
+	hw->mbx.fw_req = v & GENMASK_U32(15, 0);
+	hw->mbx.fw_ack = (v >> 16) & GENMASK_U32(15, 0);
+	mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
+	mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), GENMASK_U32(31, 16));
+}
+
+/**
+ * mucse_init_mbx_params_pf - Set initial values for pf mailbox
+ * @hw: pointer to the HW structure
+ *
+ * Initializes the hw->mbx struct to correct values for pf mailbox
+ */
+void mucse_init_mbx_params_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->usec_delay = 100;
+	mbx->timeout = (4 * USEC_PER_SEC) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mbx->size = MUCSE_MAILBOX_BYTES;
+	mutex_init(&mbx->lock);
+	mucse_mbx_reset(hw);
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
+int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int size_inwords = size / 4;
+	u32 ctrl_reg;
+	int ret;
+	int i;
+
+	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size_inwords; i++)
+		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
+
+	/* flush msg and acks as we are overwriting the message buffer */
+	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
+	mucse_mbx_inc_pf_req(hw);
+	mbx_ctrl_wr32(mbx, ctrl_reg, MBOX_CTRL_REQ);
+
+	return 0;
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
+int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = mucse_write_mbx_pf(hw, msg, size);
+	if (ret)
+		return ret;
+	return mucse_poll_for_ack(hw);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..110c1ee025ba
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+
+#define MUCSE_MAILBOX_BYTES 56
+#define MBX_FW2PF_COUNTER 0
+#define MBX_PF2FW_COUNTER 4
+#define MBX_FW_PF_SHM_DATA 8
+#define FW2PF_MBOX_VEC 0
+#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
+#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
+#define MBOX_CTRL_REQ BIT(0)
+#define MBOX_PF_HOLD BIT(3)
+#define MBOX_IRQ_EN 0
+#define MBOX_IRQ_DISABLE 1
+
+int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size);
+int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+void mucse_init_mbx_params_pf(struct mucse_hw *hw);
+int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


