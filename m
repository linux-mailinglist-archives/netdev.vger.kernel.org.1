Return-Path: <netdev+bounces-200447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871BFAE585B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9223E3A6A9D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9714986348;
	Tue, 24 Jun 2025 00:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E082AEFE;
	Tue, 24 Jun 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724105; cv=none; b=BUqDqEBjiVmFzF/90BFRw3holKsY257MoCsV9E+vc9/kwUSE+5Lce0tRG9MBeZQ5MEUqq71HnOzpKEIuLlksj0oyq5T7FakpqfB5JowM9yDOEgF9ak8MQ1RGz4XDTM9oer95yon/AaZlX8CYIFw8HcssfoZcB2IG+wNuQQJJRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724105; c=relaxed/simple;
	bh=VAh3RDae6xdRsdCfQv+ZipbvZPqrD5NEOV2nxmpv6i0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkSBag7z0iHFdS5j2OCLCZKTIiTm1o6jP5xgZvkoCEGhPY8B8hG/tiUiEKfkJSS2uJg71K56ORdgAhHRUEa7v16DO3+5RnkAA62znnqWFBbf/7uaSBbym4+FJfzEba5DdaAA0JuDwhU6VcfC1MXjCvoFUwyvcsR8X7Xv79dVX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bR52901GGzTgnd;
	Tue, 24 Jun 2025 08:10:40 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CE7EA14020C;
	Tue, 24 Jun 2025 08:14:59 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 08:14:58 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v04 1/8] hinic3: Async Event Queue interfaces
Date: Tue, 24 Jun 2025 08:14:22 +0800
Message-ID: <3fefa626dc1ad068d2994a3cd5d20fb7b8136990.1750665915.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1750665915.git.zhuyikai1@h-partners.com>
References: <cover.1750665915.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add async event queue interfaces initialization.
It allows driver to handle async events reported by HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |  17 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  65 +++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 522 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  94 ++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  43 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  32 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |   5 +
 9 files changed, 781 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 509dfbfb0e96..5fb4d1370049 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_HINIC3) += hinic3.o
 
 hinic3-objs := hinic3_common.o \
+	       hinic3_eqs.o \
 	       hinic3_hw_cfg.o \
 	       hinic3_hw_comm.o \
 	       hinic3_hwdev.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
index 0aa42068728c..d3a69d67b4c1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -51,3 +51,20 @@ void hinic3_dma_free_coherent_align(struct device *dev,
 	dma_free_coherent(dev, mem_align->real_size,
 			  mem_align->ori_vaddr, mem_align->ori_paddr);
 }
+
+/* Data provided to/by cmdq is arranged in structs with little endian fields but
+ * every dword (32bits) should be swapped since HW swaps it again when it
+ * copies it from/to host memory. This is a mandatory swap regardless of the
+ * CPU endianness.
+ */
+void hinic3_cmdq_buf_swab32(void *data, int len)
+{
+	int i, chunk_sz = sizeof(u32);
+	int data_len = len;
+	u32 *mem = data;
+
+	data_len = data_len / chunk_sz;
+
+	for (i = 0; i < data_len; i++)
+		mem[i] = swab32(mem[i]);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index bb795dace04c..c8e8a491adbf 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -24,4 +24,6 @@ int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
 void hinic3_dma_free_coherent_align(struct device *dev,
 				    struct hinic3_dma_addr_align *mem_align);
 
+void hinic3_cmdq_buf_swab32(void *data, int len);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
new file mode 100644
index 000000000000..39e15fbf0ed7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_CSR_H_
+#define _HINIC3_CSR_H_
+
+#define HINIC3_CFG_REGS_FLAG                  0x40000000
+#define HINIC3_REGS_FLAG_MASK                 0x3FFFFFFF
+
+#define HINIC3_VF_CFG_REG_OFFSET              0x2000
+
+/* HW interface registers */
+#define HINIC3_CSR_FUNC_ATTR0_ADDR            (HINIC3_CFG_REGS_FLAG + 0x0)
+#define HINIC3_CSR_FUNC_ATTR1_ADDR            (HINIC3_CFG_REGS_FLAG + 0x4)
+#define HINIC3_CSR_FUNC_ATTR2_ADDR            (HINIC3_CFG_REGS_FLAG + 0x8)
+#define HINIC3_CSR_FUNC_ATTR3_ADDR            (HINIC3_CFG_REGS_FLAG + 0xC)
+#define HINIC3_CSR_FUNC_ATTR4_ADDR            (HINIC3_CFG_REGS_FLAG + 0x10)
+#define HINIC3_CSR_FUNC_ATTR5_ADDR            (HINIC3_CFG_REGS_FLAG + 0x14)
+#define HINIC3_CSR_FUNC_ATTR6_ADDR            (HINIC3_CFG_REGS_FLAG + 0x18)
+
+#define HINIC3_FUNC_CSR_MAILBOX_DATA_OFF      0x80
+#define HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF   (HINIC3_CFG_REGS_FLAG + 0x0100)
+#define HINIC3_FUNC_CSR_MAILBOX_INT_OFF       (HINIC3_CFG_REGS_FLAG + 0x0104)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF  (HINIC3_CFG_REGS_FLAG + 0x0108)
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF  (HINIC3_CFG_REGS_FLAG + 0x010C)
+
+#define HINIC3_CSR_DMA_ATTR_TBL_ADDR          (HINIC3_CFG_REGS_FLAG + 0x380)
+#define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR    (HINIC3_CFG_REGS_FLAG + 0x390)
+
+/* MSI-X registers */
+#define HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR       (HINIC3_CFG_REGS_FLAG + 0x58)
+
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_MASK  BIT(0)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_MASK       BIT(1)
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_MASK       BIT(2)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_MASK      BIT(3)
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_MASK      BIT(4)
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_MASK  GENMASK(31, 22)
+#define HINIC3_MSI_CLR_INDIR_SET(val, member)  \
+	FIELD_PREP(HINIC3_MSI_CLR_INDIR_##member##_MASK, val)
+
+/* EQ registers */
+#define HINIC3_AEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x210)
+
+#define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
+	HINIC3_AEQ_INDIR_IDX_ADDR
+
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x240)
+
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE  8
+
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR           (HINIC3_CFG_REGS_FLAG + 0x200)
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR           (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x20C)
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x50)
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
new file mode 100644
index 000000000000..4cc0fadfade8
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include <linux/delay.h>
+
+#include "hinic3_csr.h"
+#include "hinic3_eqs.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+
+#define AEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define AEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define AEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(22, 20)
+#define AEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define AEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_0_##member##_MASK, val)
+
+#define AEQ_CTRL_1_LEN_MASK           GENMASK(20, 0)
+#define AEQ_CTRL_1_ELEM_SIZE_MASK     GENMASK(25, 24)
+#define AEQ_CTRL_1_PAGE_SIZE_MASK     GENMASK(31, 28)
+#define AEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(AEQ_CTRL_1_##member##_MASK, val)
+
+#define EQ_ELEM_DESC_TYPE_MASK        GENMASK(6, 0)
+#define EQ_ELEM_DESC_SRC_MASK         BIT(7)
+#define EQ_ELEM_DESC_SIZE_MASK        GENMASK(15, 8)
+#define EQ_ELEM_DESC_WRAPPED_MASK     BIT(31)
+#define EQ_ELEM_DESC_GET(val, member)  \
+	FIELD_GET(EQ_ELEM_DESC_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_CI_MASK       GENMASK(20, 0)
+#define EQ_CI_SIMPLE_INDIR_ARMED_MASK    BIT(21)
+#define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK  GENMASK(31, 30)
+#define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
+	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR  \
+	HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR
+
+#define EQ_PROD_IDX_REG_ADDR  \
+	HINIC3_CSR_AEQ_PROD_IDX_ADDR
+
+#define EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
+	HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)
+
+#define EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
+	HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)
+
+#define EQ_MSIX_RESEND_TIMER_CLEAR  1
+
+#define HINIC3_EQ_MAX_PAGES  \
+	HINIC3_AEQ_MAX_PAGES
+
+#define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
+#define HINIC3_EQ_UPDATE_CI_STEP       64
+#define HINIC3_EQS_WQ_NAME             "hinic3_eqs"
+
+#define HINIC3_EQ_VALID_SHIFT          31
+#define HINIC3_EQ_WRAPPED(eq)  \
+	((eq)->wrapped << HINIC3_EQ_VALID_SHIFT)
+
+#define HINIC3_EQ_WRAPPED_SHIFT        20
+#define HINIC3_EQ_CONS_IDX(eq)  \
+	((eq)->cons_idx | ((eq)->wrapped << HINIC3_EQ_WRAPPED_SHIFT))
+
+static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_cb_state[event];
+	aeqs->aeq_cb[event] = hwe_cb;
+	set_bit(HINIC3_AEQ_CB_REG, cb_state);
+
+	return 0;
+}
+
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_cb_state[event];
+	clear_bit(HINIC3_AEQ_CB_REG, cb_state);
+	/* Ensure handler can observe our intent to unregister. */
+	mb();
+	while (test_bit(HINIC3_AEQ_CB_RUNNING, cb_state))
+		usleep_range(HINIC3_EQ_USLEEP_LOW_BOUND,
+			     HINIC3_EQ_USLEEP_HIGH_BOUND);
+
+	aeqs->aeq_cb[event] = NULL;
+}
+
+/* Set consumer index in the hw. */
+static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
+{
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR;
+	u32 eq_wrap_ci, val;
+
+	eq_wrap_ci = HINIC3_EQ_CONS_IDX(eq);
+	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
+	if (eq->type == HINIC3_AEQ)
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
+}
+
+static struct hinic3_aeqs *aeq_to_aeqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_aeqs, aeq[eq->q_id]);
+}
+
+static void aeq_event_handler(struct hinic3_aeqs *aeqs, u32 aeqe,
+			      const struct hinic3_aeq_elem *aeqe_pos)
+{
+	struct hinic3_hwdev *hwdev = aeqs->hwdev;
+	u8 data[HINIC3_AEQE_DATA_SIZE], size;
+	enum hinic3_aeq_type event;
+	hinic3_aeq_event_cb hwe_cb;
+	unsigned long *cb_state;
+
+	if (EQ_ELEM_DESC_GET(aeqe, SRC))
+		return;
+
+	event = EQ_ELEM_DESC_GET(aeqe, TYPE);
+	if (event >= HINIC3_MAX_AEQ_EVENTS) {
+		dev_warn(hwdev->dev, "Aeq unknown event:%d\n", event);
+		return;
+	}
+
+	memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);
+	hinic3_cmdq_buf_swab32(data, HINIC3_AEQE_DATA_SIZE);
+	size = EQ_ELEM_DESC_GET(aeqe, SIZE);
+	cb_state = &aeqs->aeq_cb_state[event];
+	set_bit(HINIC3_AEQ_CB_RUNNING, cb_state);
+	/* Ensure unregister sees we are running. */
+	mb();
+	hwe_cb = aeqs->aeq_cb[event];
+	if (hwe_cb && test_bit(HINIC3_AEQ_CB_REG, cb_state))
+		hwe_cb(aeqs->hwdev, data, size);
+	clear_bit(HINIC3_AEQ_CB_RUNNING, cb_state);
+}
+
+static int aeq_irq_handler(struct hinic3_eq *eq)
+{
+	const struct hinic3_aeq_elem *aeqe_pos;
+	struct hinic3_aeqs *aeqs;
+	u32 i, eqe_cnt = 0;
+	u32 aeqe;
+
+	aeqs = aeq_to_aeqs(eq);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		aeqe_pos = get_curr_aeq_elem(eq);
+		aeqe = be32_to_cpu(aeqe_pos->desc);
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(aeqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		/* Prevent speculative reads from element */
+		dma_rmb();
+		aeq_event_handler(aeqs, aeqe, aeqe_pos);
+		eq->cons_idx++;
+		if (eq->cons_idx == eq->eq_len) {
+			eq->cons_idx = 0;
+			eq->wrapped = !eq->wrapped;
+		}
+
+		if (++eqe_cnt >= HINIC3_EQ_UPDATE_CI_STEP) {
+			eqe_cnt = 0;
+			set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+		}
+	}
+
+	return -EAGAIN;
+}
+
+static void reschedule_eq_handler(struct hinic3_eq *eq)
+{
+	if (eq->type == HINIC3_AEQ) {
+		struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
+
+		queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
+	}
+}
+
+static int eq_irq_handler(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+
+	set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
+			HINIC3_EQ_ARMED);
+
+	return err;
+}
+
+static void eq_irq_work(struct work_struct *work)
+{
+	struct hinic3_eq *eq = container_of(work, struct hinic3_eq, aeq_work);
+	int err;
+
+	err = eq_irq_handler(eq);
+	if (err)
+		reschedule_eq_handler(eq);
+}
+
+static irqreturn_t aeq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *aeq = data;
+	struct hinic3_aeqs *aeqs = aeq_to_aeqs(aeq);
+	struct hinic3_hwdev *hwdev = aeq->hwdev;
+	struct workqueue_struct *workq;
+
+	/* clear resend timer cnt register */
+	workq = aeqs->workq;
+	hinic3_msix_intr_clear_resend_bit(hwdev, aeq->msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	queue_work_on(WORK_CPU_UNBOUND, workq, &aeq->aeq_work);
+
+	return IRQ_HANDLED;
+}
+
+static int set_eq_ctrls(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct hinic3_queue_pages *qpages;
+	u8 pci_intf_idx, elem_size;
+	u32 mask, ctrl0, ctrl1;
+	u32 page_size_val;
+
+	qpages = &eq->qpages;
+	page_size_val = ilog2(qpages->page_size / HINIC3_MIN_PAGE_SIZE);
+	pci_intf_idx = hwif->attr.pci_intf_idx;
+
+	if (eq->type == HINIC3_AEQ) {
+		/* set ctrl0 using read-modify-write */
+		mask = AEQ_CTRL_0_INTR_IDX_MASK |
+		       AEQ_CTRL_0_DMA_ATTR_MASK |
+		       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
+		       AEQ_CTRL_0_INTR_MODE_MASK;
+		ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
+		ctrl0 = (ctrl0 & ~mask) |
+			AEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			AEQ_CTRL_0_SET(0, DMA_ATTR) |
+			AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
+
+		/* HW expects log2(number of 32 byte units). */
+		elem_size = qpages->elem_size_shift - 5;
+		ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
+			AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
+			AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
+		hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
+	}
+
+	return 0;
+}
+
+static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	struct hinic3_aeq_elem *aeqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		aeqe = get_q_element(&eq->qpages, i, NULL);
+		aeqe->desc = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
+}
+
+static void eq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	if (eq->type == HINIC3_AEQ)
+		aeq_elements_init(eq, init_val);
+}
+
+static int alloc_eq_pages(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct hinic3_queue_pages *qpages;
+	dma_addr_t page_paddr;
+	u32 reg, init_val;
+	u16 pg_idx;
+	int err;
+
+	qpages = &eq->qpages;
+	err = hinic3_queue_pages_alloc(eq->hwdev, qpages, HINIC3_MIN_PAGE_SIZE);
+	if (err)
+		return err;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		page_paddr = qpages->pages[pg_idx].align_paddr;
+		reg = EQ_HI_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, upper_32_bits(page_paddr));
+		reg = EQ_LO_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, lower_32_bits(page_paddr));
+	}
+
+	init_val = HINIC3_EQ_WRAPPED(eq);
+	eq_elements_init(eq, init_val);
+
+	return 0;
+}
+
+static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
+{
+	u32 max_pages, min_page_size, page_size, total_size;
+
+	/* No need for complicated arithmetics. All values must be power of 2.
+	 * Multiplications give power of 2 and divisions give power of 2 without
+	 * remainder.
+	 */
+	max_pages = HINIC3_EQ_MAX_PAGES;
+	min_page_size = HINIC3_MIN_PAGE_SIZE;
+	total_size = eq->eq_len * elem_size;
+
+	if (total_size <= max_pages * min_page_size)
+		page_size = min_page_size;
+	else
+		page_size = total_size / max_pages;
+
+	hinic3_queue_pages_init(&eq->qpages, eq->eq_len, page_size, elem_size);
+}
+
+static int request_eq_irq(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ) {
+		INIT_WORK(&eq->aeq_work, eq_irq_work);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, aeq_interrupt, 0,
+				  eq->irq_name, eq);
+	}
+
+	return err;
+}
+
+static void reset_eq(struct hinic3_eq *eq)
+{
+	/* clear eq_len to force eqe drop in hardware */
+	if (eq->type == HINIC3_AEQ)
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR, 0);
+}
+
+static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
+		   u32 q_len, enum hinic3_eq_type type,
+		   struct msix_entry *msix_entry)
+{
+	u32 elem_size;
+	int err;
+
+	eq->hwdev = hwdev;
+	eq->q_id = q_id;
+	eq->type = type;
+	eq->eq_len = q_len;
+
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	reset_eq(eq);
+
+	eq->cons_idx = 0;
+	eq->wrapped = 0;
+
+	elem_size = HINIC3_AEQE_SIZE;
+	eq_calc_page_size_and_num(eq, elem_size);
+
+	err = alloc_eq_pages(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate pages for eq\n");
+		return err;
+	}
+
+	eq->msix_entry_idx = msix_entry->entry;
+	eq->irq_id = msix_entry->vector;
+
+	err = set_eq_ctrls(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set ctrls for eq\n");
+		goto err_free_queue_pages;
+	}
+
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);
+
+	err = request_eq_irq(eq);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to request irq for the eq, err: %d\n", err);
+		goto err_free_queue_pages;
+	}
+
+	hinic3_set_msix_state(hwdev, eq->msix_entry_idx, HINIC3_MSIX_DISABLE);
+
+	return 0;
+
+err_free_queue_pages:
+	hinic3_queue_pages_free(hwdev, &eq->qpages);
+
+	return err;
+}
+
+static void remove_eq(struct hinic3_eq *eq)
+{
+	hinic3_set_msix_state(eq->hwdev, eq->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+	synchronize_irq(eq->irq_id);
+	free_irq(eq->irq_id, eq);
+	/* Indirect access should set q_id first */
+	hinic3_hwif_write_reg(eq->hwdev->hwif,
+			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+			      eq->q_id);
+
+	if (eq->type == HINIC3_AEQ) {
+		cancel_work_sync(&eq->aeq_work);
+		/* clear eq_len to avoid hw access host memory */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	}
+
+	/* update consumer index to avoid invalid interrupt */
+	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
+					    EQ_PROD_IDX_REG_ADDR);
+	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+	hinic3_queue_pages_free(eq->hwdev, &eq->qpages);
+}
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct msix_entry *msix_entries)
+{
+	struct hinic3_aeqs *aeqs;
+	u16 q_id;
+	int err;
+
+	aeqs = kzalloc(sizeof(*aeqs), GFP_KERNEL);
+	if (!aeqs)
+		return -ENOMEM;
+
+	hwdev->aeqs = aeqs;
+	aeqs->hwdev = hwdev;
+	aeqs->num_aeqs = num_aeqs;
+	aeqs->workq = alloc_workqueue(HINIC3_EQS_WQ_NAME, WQ_MEM_RECLAIM,
+				      HINIC3_MAX_AEQS);
+	if (!aeqs->workq) {
+		dev_err(hwdev->dev, "Failed to initialize aeq workqueue\n");
+		err = -ENOMEM;
+		goto err_free_aeqs;
+	}
+
+	for (q_id = 0; q_id < num_aeqs; q_id++) {
+		err = init_eq(&aeqs->aeq[q_id], hwdev, q_id,
+			      HINIC3_DEFAULT_AEQ_LEN, HINIC3_AEQ,
+			      &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init aeq %u\n",
+				q_id);
+			goto err_remove_eqs;
+		}
+	}
+	for (q_id = 0; q_id < num_aeqs; q_id++)
+		hinic3_set_msix_state(hwdev, aeqs->aeq[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_remove_eqs:
+	while (q_id > 0) {
+		q_id--;
+		remove_eq(&aeqs->aeq[q_id]);
+	}
+
+	destroy_workqueue(aeqs->workq);
+
+err_free_aeqs:
+	kfree(aeqs);
+
+	return err;
+}
+
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	enum hinic3_aeq_type aeq_event;
+	struct hinic3_eq *eq;
+	u16 q_id;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		eq = aeqs->aeq + q_id;
+		remove_eq(eq);
+		hinic3_free_irq(hwdev, eq->irq_id);
+	}
+
+	for (aeq_event = 0; aeq_event < HINIC3_MAX_AEQ_EVENTS; aeq_event++)
+		hinic3_aeq_unregister_cb(hwdev, aeq_event);
+
+	destroy_workqueue(aeqs->workq);
+
+	kfree(aeqs);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
new file mode 100644
index 000000000000..2b4c274e6ba4
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_EQS_H_
+#define _HINIC3_EQS_H_
+
+#include <linux/interrupt.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_queue_common.h"
+
+#define HINIC3_MAX_AEQS              4
+
+#define HINIC3_AEQ_MAX_PAGES         4
+
+#define HINIC3_AEQE_SIZE             64
+
+#define HINIC3_AEQE_DESC_SIZE        4
+#define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
+
+#define HINIC3_DEFAULT_AEQ_LEN       0x10000
+
+#define HINIC3_EQ_IRQ_NAME_LEN       64
+
+#define HINIC3_EQ_USLEEP_LOW_BOUND   900
+#define HINIC3_EQ_USLEEP_HIGH_BOUND  1000
+
+enum hinic3_eq_type {
+	HINIC3_AEQ = 0,
+};
+
+enum hinic3_eq_intr_mode {
+	HINIC3_INTR_MODE_ARMED  = 0,
+	HINIC3_INTR_MODE_ALWAYS = 1,
+};
+
+enum hinic3_eq_ci_arm_state {
+	HINIC3_EQ_NOT_ARMED = 0,
+	HINIC3_EQ_ARMED     = 1,
+};
+
+struct hinic3_eq {
+	struct hinic3_hwdev       *hwdev;
+	struct hinic3_queue_pages qpages;
+	u16                       q_id;
+	enum hinic3_eq_type       type;
+	u32                       eq_len;
+	u32                       cons_idx;
+	u8                        wrapped;
+	u32                       irq_id;
+	u16                       msix_entry_idx;
+	char                      irq_name[HINIC3_EQ_IRQ_NAME_LEN];
+	struct work_struct        aeq_work;
+};
+
+struct hinic3_aeq_elem {
+	u8     aeqe_data[HINIC3_AEQE_DATA_SIZE];
+	__be32 desc;
+};
+
+enum hinic3_aeq_cb_state {
+	HINIC3_AEQ_CB_REG     = 0,
+	HINIC3_AEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_aeq_type {
+	HINIC3_HW_INTER_INT   = 0,
+	HINIC3_MBX_FROM_FUNC  = 1,
+	HINIC3_MSG_FROM_FW    = 2,
+	HINIC3_MAX_AEQ_EVENTS = 6,
+};
+
+typedef void (*hinic3_aeq_event_cb)(struct hinic3_hwdev *hwdev, u8 *data,
+				    u8 size);
+
+struct hinic3_aeqs {
+	struct hinic3_hwdev     *hwdev;
+	hinic3_aeq_event_cb     aeq_cb[HINIC3_MAX_AEQ_EVENTS];
+	unsigned long           aeq_cb_state[HINIC3_MAX_AEQ_EVENTS];
+	struct hinic3_eq        aeq[HINIC3_MAX_AEQS];
+	u16                     num_aeqs;
+	struct workqueue_struct *workq;
+};
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct msix_entry *msix_entries);
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb);
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 87d9450c30ca..0599fc4f3fb0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,6 +8,49 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
+		      struct msix_entry *alloc_arr, u16 *act_num)
+{
+	struct hinic3_irq_info *irq_info;
+	struct hinic3_irq *curr;
+	u16 i, found = 0;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq && found < num; i++) {
+		curr = irq_info->irq + i;
+		if (curr->allocated)
+			continue;
+		curr->allocated = true;
+		alloc_arr[found].vector = curr->irq_id;
+		alloc_arr[found].entry = curr->msix_entry_idx;
+		found++;
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+
+	*act_num = found;
+
+	return found == 0 ? -ENOMEM : 0;
+}
+
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
+{
+	struct hinic3_irq_info *irq_info;
+	struct hinic3_irq *curr;
+	u16 i;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq; i++) {
+		curr = irq_info->irq + i;
+		if (curr->irq_id == irq_id) {
+			curr->allocated = false;
+			break;
+		}
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+}
+
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 0865453bf0e7..5eafb4b04311 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -6,15 +6,47 @@
 #include <linux/io.h>
 
 #include "hinic3_common.h"
+#include "hinic3_csr.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 
+#define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
+
+static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
+{
+	return hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
+}
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val;
+
+	raw_val = (__force __be32)readl(addr);
+
+	return be32_to_cpu(raw_val);
+}
+
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
+{
+	void __iomem *addr = hinic3_reg_addr(hwif, reg);
+	__be32 raw_val = cpu_to_be32(val);
+
+	writel((__force u32)raw_val, addr);
+}
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag)
 {
 	/* Completed by later submission due to LoC limit. */
 }
 
+void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en)
+{
+	/* Completed by later submission due to LoC limit. */
+}
+
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->hwif->attr.func_global_idx;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 513c9680e6b6..2e300fb0ba25 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -50,8 +50,13 @@ enum hinic3_msix_state {
 	HINIC3_MSIX_DISABLE,
 };
 
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
+void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en);
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
 
-- 
2.43.0


