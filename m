Return-Path: <netdev+bounces-221189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B29B4F3C0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255134E215C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387B32F752;
	Tue,  9 Sep 2025 12:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADB32BF55;
	Tue,  9 Sep 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419788; cv=none; b=Q4aM88RbWAdUPKNu7SJ+3KMZSdwdHU4wDTx6Kn+shDrAP/9GDtWdeSObUxG4d6U5C9Xdw3G57OLXqEPA/sIyMrcwnW/B8bV3lnkDMCvJ7LX5oSZCxWxCVRGutePkEpVO0PiYcag8OV3768RQIAb4rWau7p85QbdQ6TRIISkk9a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419788; c=relaxed/simple;
	bh=5DOIMocRsTlzQn4j4qvy7P2ZzQDeJwbmt/LKMZZ7MwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLwhBKNqnzfEVng7Llr1Qs2Dn9Hh5XDciIDqGJLhFZvgwXIVmKAcIisrQeG8XhYVnl25SPnkTHtKLm9SJShegX4/oVHFU0uxIiDW/7WbaiaDQjmfxfpk0HxhTDU0C0Gz6n8eVsWCn/AuqClqV5g4O/CkZ9jORBD34jqgAF/ia4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1757419768t1121283a
X-QQ-Originating-IP: ocFURMVNH3hAJ5Vv/6GwVjyGWasZK6YQFavtP8LqhLU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 09 Sep 2025 20:09:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5452483259770360640
EX-QQ-RecipientCnt: 28
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
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Date: Tue,  9 Sep 2025 20:09:04 +0800
Message-Id: <20250909120906.1781444-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250909120906.1781444-1-dong100@mucse.com>
References: <20250909120906.1781444-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Of/cMPzraU64xf/m4vM31prA+p0j9R2NujX5Gt1TxX2eSuMx5kZyXnd1
	nrLkyevV/icFmbr6fw/fN/V6SaaIrxKz+W7iEIcAS5O7IHlGPDbcfSKuEM+tR8UQpBvuyJC
	UwJ0MG5zOPyvLZCUcLQJZCwwvHvzYOkH2Um1G5NxFbkpmbYHz42fxb6d0/qMvD7HJfn1Nhv
	4155crYYtBPxUEtLOEgxh8WZcqTAft2VEi+uV8vmmqFM9cyv+8fqbZsqnHAhSN/rqgSamu7
	RaBaC9NIvc68+/KTB6RJb/dkJxkJtU17JgRondEtOPphWnk0pqXQo1RG/EXOfDu3xACx5u7
	LHLhhBD4EU1PjvqqIB1K0oMG9G1zWKqkvqcqniG22OPwD5Z0zdO71c69TVS3WVOfWwy5aA2
	2ihMJFjX/fWj83HVwU4myL7pWAW8+2hkrTRFQM0HKInCwRYgM/XDy6nW0oYczZlNgCc3Yhw
	MiGxNuflFWq/bxuNJxvaI0ahtCBT1ZKkuzAFHl2VNg5YLP+OB3DfbK9becXfRO9iBA+M7U4
	kl4bHia/2cnbfI2jGrPpY11+uwlEH/wNBt9sUPP+gKZcwdRPx5P/GlpXNkoJsfELyU4Ks2G
	ZKYVkhAx01DtDg0QlXFb1rfBU2iDl4c8vVmYyEX5IDoaS9CZFWVc+bKOHondHmJKolxoNKP
	RaWoNQ6yA9ZSgY4euwi1aXXM9SeZxyPGAG+0RxbaEqgGPVk2gQcTbuG7//xDI8XIV7UD9Po
	B6U06FDrFv0r58PBYPOclKoi3RQa9bL3H9nZ5ZCMxW4njMtS8RdNg50mtUsuk7lKe8h/0Im
	64zcfXovAIsIMNJXHxsk5mdwuAZGODKfK9wtDmjKLN7WIJJ6glHy6YKxpXcRjp4g4dW9MfN
	AxDsEp+ebCqglPTmYpWwDlmY9aoTII3Zg0bmymwpRSrXgidm7/2cWZ2Gwo+kpOW6/LlETeE
	fJMzY9GrznSaNMdP1fxLd9IIr2My5kPmywCv69Liy4oHMHFgRa0x6pt4b3aLrB4pxLZZrvl
	EG1Oh68creCfL3wVvYHrrAt9rOy7w=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Add fundamental mailbox (MBX) communication operations between PF (Physical
Function) and firmware for n500/n210 chips

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 425 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 7 files changed, 555 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 9df536f0d04c..5fc878ada4b1 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,4 +5,6 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-rnpgbe-objs := rnpgbe_main.o
+rnpgbe-objs := rnpgbe_main.o\
+	       rnpgbe_chip.o\
+	       rnpgbe_mbx.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 3b122dd508ce..ac28502a8860 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,13 +4,36 @@
 #ifndef _RNPGBE_H
 #define _RNPGBE_H
 
+#include <linux/types.h>
+
 enum rnpgbe_boards {
 	board_n500,
 	board_n210
 };
 
+struct mucse_mbx_stats {
+	u32 msgs_tx; /* Number of messages sent from PF to fw */
+	u32 msgs_rx; /* Number of messages received from fw to PF */
+	u32 acks; /* Number of ACKs received from firmware */
+	u32 reqs; /* Number of requests sent to firmware */
+};
+
+struct mucse_mbx_info {
+	struct mucse_mbx_stats stats;
+	u32 timeout_cnt;
+	u32 usec_delay;
+	u16 fw_req;
+	u16 fw_ack;
+	/* fw <--> pf mbx */
+	u32 fwpf_shm_base;
+	u32 pf2fw_mbx_ctrl;
+	u32 fwpf_mbx_mask;
+	u32 fwpf_ctrl_base;
+};
+
 struct mucse_hw {
 	void __iomem *hw_addr;
+	struct mucse_mbx_info mbx;
 };
 
 struct mucse {
@@ -19,6 +42,8 @@ struct mucse {
 	struct mucse_hw hw;
 };
 
+int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE 0x8848
 #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..0e277e7557ee
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/errno.h>
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+#include "rnpgbe_mbx.h"
+
+/**
+ * rnpgbe_init_n500 - Setup n500 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n500 initializes all private
+ * structure for n500
+ **/
+static void rnpgbe_init_n500(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->fwpf_ctrl_base = MUCSE_N500_FWPF_CTRL_BASE;
+	mbx->fwpf_shm_base = MUCSE_N500_FWPF_SHM_BASE;
+}
+
+/**
+ * rnpgbe_init_n210 - Setup n210 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n210 initializes all private
+ * structure for n210
+ **/
+static void rnpgbe_init_n210(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->fwpf_ctrl_base = MUCSE_N210_FWPF_CTRL_BASE;
+	mbx->fwpf_shm_base = MUCSE_N210_FWPF_SHM_BASE;
+}
+
+/**
+ * rnpgbe_init_hw - Setup hw info according to board_type
+ * @hw: hw information structure
+ * @board_type: board type
+ *
+ * rnpgbe_init_hw initializes all hw data
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
+	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
+
+	switch (board_type) {
+	case board_n500:
+		rnpgbe_init_n500(hw);
+	break;
+	case board_n210:
+		rnpgbe_init_n210(hw);
+	break;
+	default:
+		return -EINVAL;
+	}
+	/* init_params with mbx base */
+	mucse_init_mbx_params_pf(hw);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 1a0b22d651b9..612f0ba65265 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -4,6 +4,13 @@
 #ifndef _RNPGBE_HW_H
 #define _RNPGBE_HW_H
 
+/**************** MBX Resource ****************************/
+#define MUCSE_N500_FWPF_CTRL_BASE 0x28b00
+#define MUCSE_N500_FWPF_SHM_BASE 0x2d000
+#define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
+#define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
+#define MUCSE_N210_FWPF_CTRL_BASE 0x29400
+#define MUCSE_N210_FWPF_SHM_BASE 0x2d900
 /**************** CHIP Resource ****************************/
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 0afe39621661..c6cfb54f7c59 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -68,6 +68,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	hw->hw_addr = hw_addr;
+	err = rnpgbe_init_hw(hw, board_type);
+	if (err) {
+		dev_err(&pdev->dev, "Init hw err %d\n", err);
+		goto err_free_net;
+	}
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
new file mode 100644
index 000000000000..9fcafda1bc5b
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2022 - 2025 Mucse Corporation. */
+
+#include <linux/errno.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+
+#include "rnpgbe_mbx.h"
+
+/**
+ * mbx_data_rd32  - Reads reg with base mbx->fwpf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * Return: register value
+ **/
+static u32 mbx_data_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fwpf_shm_base + reg);
+}
+
+/**
+ * mbx_data_wr32  - Writes value to reg with base mbx->fwpf_shm_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_data_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fwpf_shm_base + reg);
+}
+
+/**
+ * mbx_ctrl_rd32  - Reads reg with base mbx->fwpf_ctrl_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ *
+ * Return: register value
+ **/
+static u32 mbx_ctrl_rd32(struct mucse_mbx_info *mbx, u32 reg)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	return readl(hw->hw_addr + mbx->fwpf_ctrl_base + reg);
+}
+
+/**
+ * mbx_ctrl_wr32  - Writes value to reg with base mbx->fwpf_ctrl_base
+ * @mbx: pointer to the MBX structure
+ * @reg: register offset
+ * @value: value to be written
+ *
+ **/
+static void mbx_ctrl_wr32(struct mucse_mbx_info *mbx, u32 reg, u32 value)
+{
+	struct mucse_hw *hw = container_of(mbx, struct mucse_hw, mbx);
+
+	writel(value, hw->hw_addr + mbx->fwpf_ctrl_base + reg);
+}
+
+/**
+ * mucse_mbx_get_lock_pf - Write ctrl and read back lock status
+ * @hw: pointer to the HW structure
+ *
+ * Return: register value after write
+ **/
+static u32 mucse_mbx_get_lock_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg = MUCSE_MBX_PF2FW_CTRL(mbx);
+
+	mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_PFU);
+
+	return mbx_ctrl_rd32(mbx, reg);
+}
+
+/**
+ * mucse_obtain_mbx_lock_pf - Obtain mailbox lock
+ * @hw: pointer to the HW structure
+ *
+ * Pair with mucse_release_mbx_lock_pf()
+ * This function maybe used in an irq handler.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int count = mbx->timeout_cnt;
+	u32 val;
+
+	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
+					val, val & MUCSE_MBX_PFU,
+					mbx->usec_delay,
+					count * mbx->usec_delay,
+					false, hw);
+}
+
+/**
+ * mucse_release_mbx_lock_pf - Release mailbox lock
+ * @hw: pointer to the HW structure
+ * @req: send a request or not
+ *
+ * Pair with mucse_obtain_mbx_lock_pf():
+ * - Releases the mailbox lock by clearing MUCSE_MBX_PFU bit
+ * - Simultaneously sends the request by setting MUCSE_MBX_REQ bit
+ *   if req is true
+ * (Both bits are in the same mailbox control register,
+ * so operations are combined)
+ **/
+static void mucse_release_mbx_lock_pf(struct mucse_hw *hw, bool req)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 reg = MUCSE_MBX_PF2FW_CTRL(mbx);
+
+	if (req)
+		mbx_ctrl_wr32(mbx, reg, MUCSE_MBX_REQ);
+	else
+		mbx_ctrl_wr32(mbx, reg, 0);
+}
+
+/**
+ * mucse_mbx_get_fwreq - Read fw req from reg
+ * @mbx: pointer to the mbx structure
+ *
+ * Return: the fwreq value
+ **/
+static u16 mucse_mbx_get_fwreq(struct mucse_mbx_info *mbx)
+{
+	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
+
+	return FIELD_GET(GENMASK_U32(15, 0), val);
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
+	u32 val;
+
+	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
+	ack = FIELD_GET(GENMASK_U32(31, 16), val);
+	ack++;
+	val &= ~GENMASK_U32(31, 16);
+	val |= FIELD_PREP(GENMASK_U32(31, 16), ack);
+	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
+	hw->mbx.stats.msgs_rx++;
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
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int size_in_words = size / 4;
+	int ret;
+	int i;
+
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size_in_words; i++)
+		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);
+	/* Hw needs write data_reg at last */
+	mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM, 0);
+	/* flush reqs as we have read this request data */
+	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
+	mucse_mbx_inc_pf_ack(hw);
+	mucse_release_mbx_lock_pf(hw, false);
+
+	return 0;
+}
+
+/**
+ * mucse_check_for_msg_pf - Check to see if the fw has sent mail
+ * @hw: pointer to the HW structure
+ *
+ * Return: 0 if the fw has set the Status bit or else -EIO
+ **/
+static int mucse_check_for_msg_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 fw_req;
+
+	fw_req = mucse_mbx_get_fwreq(mbx);
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'fw_req != hw->mbx.fw_req'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (fw_req != 0 && fw_req != hw->mbx.fw_req) {
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
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_poll_for_msg(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int count = mbx->timeout_cnt;
+	int val;
+
+	return read_poll_timeout(mucse_check_for_msg_pf,
+				 val, !val, mbx->usec_delay,
+				 count * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_poll_and_read_mbx - Wait for message notification and receive message
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 if it successfully received a message notification and
+ * copied it into the receive buffer
+ **/
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
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
+ * mucse_mbx_get_fwack - Read fw ack from reg
+ * @mbx: pointer to the MBX structure
+ *
+ * Return: the fwack value
+ **/
+static u16 mucse_mbx_get_fwack(struct mucse_mbx_info *mbx)
+{
+	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
+
+	return FIELD_GET(GENMASK_U32(31, 16), val);
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
+	u32 val;
+
+	val = mbx_data_rd32(mbx, MUCSE_MBX_PF2FW_CNT);
+	req = FIELD_GET(GENMASK_U32(15, 0), val);
+	req++;
+	val &= ~GENMASK_U32(15, 0);
+	val |= FIELD_PREP(GENMASK_U32(15, 0), req);
+	mbx_data_wr32(mbx, MUCSE_MBX_PF2FW_CNT, val);
+	hw->mbx.stats.msgs_tx++;
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
+ * Return: 0 if it successfully copied message into the buffer
+ **/
+static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int size_in_words = size / 4;
+	int ret;
+	int i;
+
+	ret = mucse_obtain_mbx_lock_pf(hw);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size_in_words; i++)
+		mbx_data_wr32(mbx, MUCSE_MBX_FWPF_SHM + i * 4, msg[i]);
+
+	/* flush acks as we are overwriting the message buffer */
+	hw->mbx.fw_ack = mucse_mbx_get_fwack(mbx);
+	mucse_mbx_inc_pf_req(hw);
+	mucse_release_mbx_lock_pf(hw, true);
+
+	return 0;
+}
+
+/**
+ * mucse_check_for_ack_pf - Check to see if the fw has ACKed
+ * @hw: pointer to the HW structure
+ *
+ * Return: 0 if the fw has set the Status bit or else -EIO
+ **/
+static int mucse_check_for_ack_pf(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u16 fw_ack;
+
+	fw_ack = mucse_mbx_get_fwack(mbx);
+	/* chip's register is reset to 0 when rc send reset
+	 * mbx command. This causes 'fw_ack != hw->mbx.fw_ack'
+	 * be TRUE before fw really reply. Driver must wait fw reset
+	 * done reply before using chip, we must check no-zero.
+	 **/
+	if (fw_ack != 0 && fw_ack != hw->mbx.fw_ack) {
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
+ * Return: 0 if it successfully received a message acknowledgment,
+ * else negative errno
+ **/
+static int mucse_poll_for_ack(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int count = mbx->timeout_cnt;
+	int val;
+
+	return read_poll_timeout(mucse_check_for_ack_pf,
+				 val, !val, mbx->usec_delay,
+				 count * mbx->usec_delay,
+				 false, hw);
+}
+
+/**
+ * mucse_write_and_wait_ack_mbx - Write a message to the mailbox, wait for ack
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 if it successfully copied message into the buffer and
+ * received an ack to that message within delay * timeout_cnt period
+ **/
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int ret;
+
+	ret = mucse_write_mbx_pf(hw, msg, size);
+	if (ret)
+		return ret;
+	return mucse_poll_for_ack(hw);
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
+	v = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
+	hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), v);
+	hw->mbx.fw_ack = FIELD_GET(GENMASK_U32(31, 16), v);
+	mbx_ctrl_wr32(mbx, MUCSE_MBX_PF2FW_CTRL(mbx), 0);
+	mbx_ctrl_wr32(mbx, MUCSE_MBX_FWPF_MASK(mbx), GENMASK_U32(31, 16));
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
+	mbx->timeout_cnt = (4 * USEC_PER_SEC) / mbx->usec_delay;
+	mbx->stats.msgs_tx = 0;
+	mbx->stats.msgs_rx = 0;
+	mbx->stats.reqs = 0;
+	mbx->stats.acks = 0;
+	mucse_mbx_reset(hw);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..eac99f13b6ff
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_MBX_H
+#define _RNPGBE_MBX_H
+
+#include "rnpgbe.h"
+
+#define MUCSE_MBX_FW2PF_CNT 0
+#define MUCSE_MBX_PF2FW_CNT 4
+#define MUCSE_MBX_FWPF_SHM 8
+#define MUCSE_MBX_PF2FW_CTRL(mbx) ((mbx)->pf2fw_mbx_ctrl)
+#define MUCSE_MBX_FWPF_MASK(mbx) ((mbx)->fwpf_mbx_mask)
+#define MUCSE_MBX_REQ BIT(0) /* Request a req to mailbox */
+#define MUCSE_MBX_PFU BIT(3) /* PF owns the mailbox buffer */
+
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+void mucse_init_mbx_params_pf(struct mucse_hw *hw);
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


