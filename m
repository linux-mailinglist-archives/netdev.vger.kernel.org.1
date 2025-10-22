Return-Path: <netdev+bounces-231581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D902CBFAD53
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6976C505536
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F73081AF;
	Wed, 22 Oct 2025 08:14:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659E305E0D;
	Wed, 22 Oct 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120884; cv=none; b=IZsf326XEhTQa7fKdBPN2oH1WKAJ2c/Y+lRLrmYgjXXGMysTjTA4vSVXIBdiwQ3Ws4qbfWYwYtTmTKTXgJlByjy8Sm4Kjej2R9+MEccWnvqipkdMp+PQ24lwxR2TajMOSWzq1iDluXbRYrGlGY5mrWodJ9ZS48GFsOns6ORxCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120884; c=relaxed/simple;
	bh=YCdOBn/2nJUO6+mwARMa8oFB6+JKkKDkUwQuHkUfRd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMOvTXTraOuarq+2/jV9e+7uD7077gRrCj0CggaxNuuHRZ/dHQjF+b+x47KrV97oD8Bt8tCiZS9fHBHKjRHyicbZXcytmMN9UZFEfVJnkZiGB7ScZua3us0EQCPyNs/6TzWaqpvVUBPovPEBHsSGA/MgULnQ0B4IXqbEaLy9I8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1761120853t0b2a076f
X-QQ-Originating-IP: 2++8yLUuSIdnpaSCqmWCoRfNksn0KwRqvzE7uJZuDfk=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Oct 2025 16:14:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13873262490975081737
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v15 3/5] net: rnpgbe: Add basic mbx ops support
Date: Wed, 22 Oct 2025 16:13:49 +0800
Message-Id: <20251022081351.99446-4-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251022081351.99446-1-dong100@mucse.com>
References: <20251022081351.99446-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N3l5ASPewLWqG27oRt4bLgvfLR1q1VfiIFZvD1/im90u09ucUFmUTPQZ
	k63V530oHQD4V9JgOT05ZClTT6EoTl3lgKJV81zJU0MIuYWfcIv5p+RMf127BtBcC21p2wi
	meGMetUhSgEfTRAfJuVoiC/L7zvXYv02vr7g22PAiIEMgHmH3RjN7er3hB9bVKJlSihDs9i
	lAy+iy0iY1o14yDqi2akq9+Iyg2MwXoCr6h6v8s+ZVpezq/76Kom0dMFvOEETDqTd1iElX5
	oJlHeet9SJa8tFs4E8tOMEt8MIWRPArKBn7jIHxe4pPbouOeNB0iuQZgJqFDoANpGBfdasv
	JjUUutQ01btWN1tZAlv5lirhUvsPKYJI8R0lgNMq6Pi9ir3GM7f4McpNFJdoLWBfFa3Puhj
	djA1o9l43CrMznZ+T1Yt+fxLl7fjLtzemWWuTTECicB4d/4qbLyG/Rc3ttzZ9vLJpYeaBDv
	vkKOzWDo0pk6kVAdDVW07t1MSDsSuToy70/t3mPF24isiA52a+f2FFZdk19iwS4qjegaMCf
	EB0HLhHYhXf4KaENicpIX4I3+X1QcmNsERqi3xgtwy4SAuDBKyEki1/fJhkNungOIOfgbNG
	wK6L/sZY41ivIYMkgK+ZSMT+WPUuIYqkRs2Yx3HOISmFQVcfgfoiPzM9/UbV2xWOvnOqbvS
	9HCRC91XfEfGnP5ugGTwiZPFgaGWQEoy1XzDPTF4YyjWm8aOtAkYCRolsyyEtFd3xUtMv88
	HqEQc81o8aeWmn487w+EH5ZYjQru6ozrRVXl29TvKOOJqiPx32LGI1MaPOylVXOGHYdPZ0+
	uhvdnxq44cjoiFFaryrqGZDVkFGBUleZULlblPWfObr/Ng8LWURFTgVRZ2l9OW6nSpbuqCT
	BtsaV6smVdMbzbqJpYuYxIfKbp6dCZCCNST82zEJ1kimxwAMMQK7qMLgZQzZKbb0r4M8hal
	LpRuK0gBxzN8hCcZQ4V0Xvc8RbIgeWDEABEERKebSyJ/piBA26XEN42j556n5sTXe4cWKI9
	hgwlkgELqWzGZjsm098ZSUIXqGqbU0BKOSFs1I4g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add fundamental mailbox (MBX) communication operations between PF
(Physical Function) and firmware for n500/n210 chips

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 405 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 7 files changed, 527 insertions(+), 1 deletion(-)
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
index a121ce4872a6..4c70b0cedd1f 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,13 +4,28 @@
 #ifndef _RNPGBE_H
 #define _RNPGBE_H
 
+#include <linux/types.h>
+
 enum rnpgbe_boards {
 	board_n500,
 	board_n210
 };
 
+struct mucse_mbx_info {
+	u32 timeout_us;
+	u32 delay_us;
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
@@ -19,6 +34,8 @@ struct mucse {
 	struct mucse_hw hw;
 };
 
+int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
 #define RNPGBE_DEVICE_ID_N500_QUAD_PORT   0x8308
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..5739db98f12a
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
+ * Return: 0 on success, -EINVAL on failure
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
+		break;
+	case board_n210:
+		rnpgbe_init_n210(hw);
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* init_params with mbx base */
+	mucse_init_mbx_params_pf(hw);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 3a779806e8be..268f572936aa 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -4,5 +4,12 @@
 #ifndef _RNPGBE_HW_H
 #define _RNPGBE_HW_H
 
+#define MUCSE_N500_FWPF_CTRL_BASE      0x28b00
+#define MUCSE_N500_FWPF_SHM_BASE       0x2d000
+#define MUCSE_GBE_PFFW_MBX_CTRL_OFFSET 0x5500
+#define MUCSE_GBE_FWPF_MBX_MASK_OFFSET 0x5700
+#define MUCSE_N210_FWPF_CTRL_BASE      0x29400
+#define MUCSE_N210_FWPF_SHM_BASE       0x2d900
+
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 305657d73e25..d8aaac79ff4b 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -64,6 +64,11 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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
index 000000000000..5de4b104455e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
@@ -0,0 +1,405 @@
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
+ * mbx_data_rd32 - Reads reg with base mbx->fwpf_shm_base
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
+ * mbx_data_wr32 - Writes value to reg with base mbx->fwpf_shm_base
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
+ * mbx_ctrl_rd32 - Reads reg with base mbx->fwpf_ctrl_base
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
+ * mbx_ctrl_wr32 - Writes value to reg with base mbx->fwpf_ctrl_base
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
+	u32 val;
+
+	return read_poll_timeout_atomic(mucse_mbx_get_lock_pf,
+					val, val & MUCSE_MBX_PFU,
+					mbx->delay_us,
+					mbx->timeout_us,
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
+	mbx_ctrl_wr32(mbx, reg, req ? MUCSE_MBX_REQ : 0);
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
+ * mucse_mbx_inc_pf_ack reads pf_ack from hw, then writes
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
+}
+
+/**
+ * mucse_read_mbx_pf - Read a message from the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * mucse_read_mbx_pf copies a message from the mbx buffer to the caller's
+ * memory buffer. The presumption is that the caller knows that there was
+ * a message due to a fw request so no polling for message is needed.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	const int size_in_words = size / sizeof(u32);
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int err;
+
+	err = mucse_obtain_mbx_lock_pf(hw);
+	if (err)
+		return err;
+
+	for (int i = 0; i < size_in_words; i++)
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
+	 * mbx command. Return -EIO if in this state, others
+	 * fw == hw->mbx.fw_req means no new msg.
+	 **/
+	if (fw_req == 0 || fw_req == hw->mbx.fw_req)
+		return -EIO;
+
+	return 0;
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
+	int val;
+
+	return read_poll_timeout(mucse_check_for_msg_pf,
+				 val, !val, mbx->delay_us,
+				 mbx->timeout_us,
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
+ * copied it into the receive buffer, negative errno on failure
+ **/
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	int err;
+
+	err = mucse_poll_for_msg(hw);
+	if (err)
+		return err;
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
+ * mucse_mbx_inc_pf_req reads pf_req from hw, then writes
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
+}
+
+/**
+ * mucse_write_mbx_pf - Place a message in the mailbox
+ * @hw: pointer to the HW structure
+ * @msg: the message buffer
+ * @size: length of buffer
+ *
+ * Return: 0 if it successfully copied message into the buffer,
+ * negative errno on failure
+ **/
+static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
+{
+	const int size_in_words = size / sizeof(u32);
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	int err;
+
+	err = mucse_obtain_mbx_lock_pf(hw);
+	if (err)
+		return err;
+
+	for (int i = 0; i < size_in_words; i++)
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
+	 * mbx command. Return -EIO if in this state, others
+	 * fw_ack == hw->mbx.fw_ack means no new ack.
+	 **/
+	if (fw_ack == 0 || fw_ack == hw->mbx.fw_ack)
+		return -EIO;
+
+	return 0;
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
+	int val;
+
+	return read_poll_timeout(mucse_check_for_ack_pf,
+				 val, !val, mbx->delay_us,
+				 mbx->timeout_us,
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
+	int err;
+
+	err = mucse_write_mbx_pf(hw, msg, size);
+	if (err)
+		return err;
+
+	return mucse_poll_for_ack(hw);
+}
+
+/**
+ * mucse_mbx_reset - Reset mbx info, sync info from regs
+ * @hw: pointer to the HW structure
+ *
+ * mucse_mbx_reset resets all mbx variables to default.
+ **/
+static void mucse_mbx_reset(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+	u32 val;
+
+	val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);
+	hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), val);
+	hw->mbx.fw_ack = FIELD_GET(GENMASK_U32(31, 16), val);
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
+	mbx->delay_us = 100;
+	mbx->timeout_us = 4 * USEC_PER_SEC;
+	mucse_mbx_reset(hw);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
new file mode 100644
index 000000000000..e6fcc8d1d3ca
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
+#define MUCSE_MBX_FW2PF_CNT       0
+#define MUCSE_MBX_PF2FW_CNT       4
+#define MUCSE_MBX_FWPF_SHM        8
+#define MUCSE_MBX_PF2FW_CTRL(mbx) ((mbx)->pf2fw_mbx_ctrl)
+#define MUCSE_MBX_FWPF_MASK(mbx)  ((mbx)->fwpf_mbx_mask)
+#define MUCSE_MBX_REQ             BIT(0) /* Request a req to mailbox */
+#define MUCSE_MBX_PFU             BIT(3) /* PF owns the mailbox buffer */
+
+int mucse_write_and_wait_ack_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+void mucse_init_mbx_params_pf(struct mucse_hw *hw);
+int mucse_poll_and_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size);
+#endif /* _RNPGBE_MBX_H */
-- 
2.25.1


