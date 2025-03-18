Return-Path: <netdev+bounces-175784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8564A67783
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DB117CEEB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980120D505;
	Tue, 18 Mar 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="aU28cHya"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C426C13D
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311041; cv=none; b=keZBASr4QnnmTYqVAbodPxyK0jG8rXZMmluGxNm4BTLGq78PPcebaRqHFE7B2SwGUibqMSxz0a/BT+tWqbz3N5NGyH2SugNmMS0FjTjt+C0exHwcYi/WBaFxjZE4IiIkH8SIl1sePKdn4yj3qrab1ACaJkskg8tCHq3oGGwFP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311041; c=relaxed/simple;
	bh=l4r7hQjWG5bALcuq0XNZnftxvvMzJlsFuf/MI3s+WwM=;
	h=In-Reply-To:References:From:Subject:Date:Message-Id:Cc:
	 Mime-Version:To:Content-Type; b=tSxEz8gaGOajBxNJCbs+VLtg3Mpu9p/B4t87DSi88YrPsFijrLiro5BpLVY9apgFcd1TZBwGJo/R27lpjjVq3aZYpHrnNG9I3kLXFqTX2Gp44nff0Vd6DKyWCMDIq9XAtvo0ZK4hxJ4g0aXc3dJz35zSuViLXAbQguMpcgSXeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=aU28cHya; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742310895; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ofSeuTDK0GLvb2pZA3yos0UzVpHIESweECC1bzPUQDI=;
 b=aU28cHyaHpy3ahz06hpjwZcYqPsfHKAUeFkU+FhOtfvPIBDdu9BB73M+WLc1OKiW18kOqF
 mH4x+00o+LoSDlyUjMCEG1TlgjOtar7UK8wy9NsPt1ps2VQYL3gNtPI4l9K/38Kgtau3CA
 8UqH3SsoCLMeX7lxoIOl4VccOcg+RRwdxpUR1ESJ/a4T8xLRcICvxGzKk+QyxsxqrUbjWo
 UQMsX9ysHvZ6B1GkJjC2Z0XOK5P/XYcSpJLj4LK1iDpDueGcFHnMj1soPlwRdEUw5HRRnI
 3HB2ZIFtmYeziVJ/y0wZ6hTvg57T6cFeP7rjdTt2Gn4oNNNk5q1xw7SQ9tHVDQ==
In-Reply-To: <20250318151449.1376756-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH net-next v9 02/14] xsc: Enable command queue
Date: Tue, 18 Mar 2025 23:14:53 +0800
Message-Id: <20250318151451.1376756-3-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267d98ded+5fe1dd+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 23:14:53 +0800
To: <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>

The command queue is a hardware channel for sending
commands between the driver and the firmware.
xsc_cmd.h defines the command protocol structures.
The logic for command allocation, sending,
completion handling, and error handling is implemented
in cmdq.c.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   94 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  |  630 +++++++
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  234 +++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |    7 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   26 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |    2 +-
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1571 +++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   56 +
 8 files changed, 2619 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
new file mode 100644
index 000000000..d9d0419e3
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_HW_H
+#define __XSC_HW_H
+
+/* hif_irq_csr_defines.h */
+#define HIF_IRQ_TBL2IRQ_TBL_RD_DONE_INT_MSIX_REG_ADDR   0xa1100070
+
+/* hif_cpm_csr_defines.h */
+#define HIF_CPM_LOCK_GET_REG_ADDR   0xa0000104
+#define HIF_CPM_LOCK_PUT_REG_ADDR   0xa0000108
+#define HIF_CPM_LOCK_AVAIL_REG_ADDR   0xa000010c
+#define HIF_CPM_IDA_DATA_MEM_ADDR   0xa0000800
+#define HIF_CPM_IDA_CMD_REG_ADDR   0xa0000020
+#define HIF_CPM_IDA_ADDR_REG_ADDR   0xa0000080
+#define HIF_CPM_IDA_BUSY_REG_ADDR   0xa0000100
+#define HIF_CPM_IDA_CMD_REG_IDA_IDX_WIDTH 5
+#define HIF_CPM_IDA_CMD_REG_IDA_LEN_WIDTH 4
+#define HIF_CPM_IDA_CMD_REG_IDA_R0W1_WIDTH 1
+#define HIF_CPM_LOCK_GET_REG_LOCK_VLD_SHIFT 5
+#define HIF_CPM_LOCK_GET_REG_LOCK_IDX_MASK  0x1f
+#define HIF_CPM_IDA_ADDR_REG_STRIDE 0x4
+#define HIF_CPM_CHIP_VERSION_H_REG_ADDR   0xa0000010
+
+/* mmc_csr_defines.h */
+#define MMC_MPT_TBL_MEM_DEPTH  32768
+#define MMC_MTT_TBL_MEM_DEPTH  262144
+#define MMC_MPT_TBL_MEM_WIDTH  256
+#define MMC_MTT_TBL_MEM_WIDTH  64
+#define MMC_MPT_TBL_MEM_ADDR   0xa4100000
+#define MMC_MTT_TBL_MEM_ADDR   0xa4200000
+
+/* clsf_dma_csr_defines.h */
+#define CLSF_DMA_DMA_UL_BUSY_REG_ADDR   0xa6010048
+#define CLSF_DMA_DMA_DL_DONE_REG_ADDR   0xa60100d0
+#define CLSF_DMA_DMA_DL_SUCCESS_REG_ADDR   0xa60100c0
+#define CLSF_DMA_ERR_CODE_CLR_REG_ADDR   0xa60100d4
+#define CLSF_DMA_DMA_RD_TABLE_ID_REG_DMA_RD_TBL_ID_MASK  0x7f
+#define CLSF_DMA_DMA_RD_TABLE_ID_REG_ADDR   0xa6010020
+#define CLSF_DMA_DMA_RD_ADDR_REG_DMA_RD_BURST_NUM_SHIFT 16
+#define CLSF_DMA_DMA_RD_ADDR_REG_ADDR   0xa6010024
+#define CLSF_DMA_INDRW_RD_START_REG_ADDR   0xa6010028
+
+/* hif_tbl_csr_defines.h */
+#define HIF_TBL_TBL_DL_BUSY_REG_ADDR   0xa1060030
+#define HIF_TBL_TBL_DL_REQ_REG_TBL_DL_LEN_SHIFT 12
+#define HIF_TBL_TBL_DL_REQ_REG_TBL_DL_HOST_ID_SHIFT 11
+#define HIF_TBL_TBL_DL_REQ_REG_ADDR   0xa1060020
+#define HIF_TBL_TBL_DL_ADDR_L_REG_TBL_DL_ADDR_L_MASK  0xffffffff
+#define HIF_TBL_TBL_DL_ADDR_L_REG_ADDR   0xa1060024
+#define HIF_TBL_TBL_DL_ADDR_H_REG_TBL_DL_ADDR_H_MASK  0xffffffff
+#define HIF_TBL_TBL_DL_ADDR_H_REG_ADDR   0xa1060028
+#define HIF_TBL_TBL_DL_START_REG_ADDR   0xa106002c
+#define HIF_TBL_TBL_UL_REQ_REG_TBL_UL_HOST_ID_SHIFT 11
+#define HIF_TBL_TBL_UL_REQ_REG_ADDR   0xa106007c
+#define HIF_TBL_TBL_UL_ADDR_L_REG_TBL_UL_ADDR_L_MASK  0xffffffff
+#define HIF_TBL_TBL_UL_ADDR_L_REG_ADDR   0xa1060080
+#define HIF_TBL_TBL_UL_ADDR_H_REG_TBL_UL_ADDR_H_MASK  0xffffffff
+#define HIF_TBL_TBL_UL_ADDR_H_REG_ADDR   0xa1060084
+#define HIF_TBL_TBL_UL_START_REG_ADDR   0xa1060088
+#define HIF_TBL_MSG_RDY_REG_ADDR   0xa1060044
+
+/* hif_cmdqm_csr_defines.h */
+#define HIF_CMDQM_HOST_REQ_PID_MEM_ADDR   0xa1026000
+#define HIF_CMDQM_HOST_REQ_CID_MEM_ADDR   0xa1028000
+#define HIF_CMDQM_HOST_RSP_PID_MEM_ADDR   0xa102e000
+#define HIF_CMDQM_HOST_RSP_CID_MEM_ADDR   0xa1030000
+#define HIF_CMDQM_HOST_REQ_BUF_BASE_H_ADDR_MEM_ADDR   0xa1022000
+#define HIF_CMDQM_HOST_REQ_BUF_BASE_L_ADDR_MEM_ADDR   0xa1024000
+#define HIF_CMDQM_HOST_RSP_BUF_BASE_H_ADDR_MEM_ADDR   0xa102a000
+#define HIF_CMDQM_HOST_RSP_BUF_BASE_L_ADDR_MEM_ADDR   0xa102c000
+#define HIF_CMDQM_VECTOR_ID_MEM_ADDR   0xa1034000
+#define HIF_CMDQM_Q_ELEMENT_SZ_REG_ADDR   0xa1020020
+#define HIF_CMDQM_HOST_Q_DEPTH_REG_ADDR   0xa1020028
+#define HIF_CMDQM_HOST_VF_ERR_STS_MEM_ADDR   0xa1032000
+
+/* PSV use */
+/* hif_irq_csr_defines.h */
+#define HIF_IRQ_CONTROL_TBL_MEM_ADDR   0xa1102000
+#define HIF_IRQ_INT_DB_REG_ADDR   0xa11000b4
+#define HIF_IRQ_CFG_VECTOR_TABLE_BUSY_REG_ADDR   0xa1100114
+#define HIF_IRQ_CFG_VECTOR_TABLE_ADDR_REG_ADDR   0xa11000f0
+#define HIF_IRQ_CFG_VECTOR_TABLE_CMD_REG_ADDR   0xa11000ec
+#define HIF_IRQ_CFG_VECTOR_TABLE_MSG_LADDR_REG_ADDR   0xa11000f4
+#define HIF_IRQ_CFG_VECTOR_TABLE_MSG_UADDR_REG_ADDR   0xa11000f8
+#define HIF_IRQ_CFG_VECTOR_TABLE_MSG_DATA_REG_ADDR   0xa11000fc
+#define HIF_IRQ_CFG_VECTOR_TABLE_CTRL_REG_ADDR   0xa1100100
+#define HIF_IRQ_CFG_VECTOR_TABLE_START_REG_ADDR   0xa11000e8
+
+#endif /* __XSC_HW_H  */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
new file mode 100644
index 000000000..b830e2a63
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
@@ -0,0 +1,630 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_CMD_H
+#define __XSC_CMD_H
+
+#define XSC_CMDQ_VERSION	0x32
+
+#define XSC_BOARD_SN_LEN	32
+
+enum {
+	XSC_CMD_STAT_OK				= 0x0,
+	XSC_CMD_STAT_INT_ERR			= 0x1,
+	XSC_CMD_STAT_BAD_OP_ERR			= 0x2,
+	XSC_CMD_STAT_BAD_PARAM_ERR		= 0x3,
+	XSC_CMD_STAT_BAD_SYS_STATE_ERR		= 0x4,
+	XSC_CMD_STAT_BAD_RES_ERR		= 0x5,
+	XSC_CMD_STAT_RES_BUSY			= 0x6,
+	XSC_CMD_STAT_LIM_ERR			= 0x8,
+	XSC_CMD_STAT_BAD_RES_STATE_ERR		= 0x9,
+	XSC_CMD_STAT_IX_ERR			= 0xa,
+	XSC_CMD_STAT_NO_RES_ERR			= 0xf,
+	XSC_CMD_STAT_BAD_QP_STATE_ERR		= 0x10,
+	XSC_CMD_STAT_BAD_PKT_ERR		= 0x30,
+	XSC_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR	= 0x40,
+	XSC_CMD_STAT_BAD_INP_LEN_ERR		= 0x50,
+	XSC_CMD_STAT_BAD_OUTP_LEN_ERR		= 0x51,
+};
+
+enum {
+	XSC_CMD_OP_QUERY_HCA_CAP		= 0x100,
+	XSC_CMD_OP_QUERY_CMDQ_VERSION		= 0x10a,
+	XSC_CMD_OP_FUNCTION_RESET		= 0x10c,
+	XSC_CMD_OP_DUMMY			= 0x10d,
+	XSC_CMD_OP_QUERY_GUID			= 0x113,
+	XSC_CMD_OP_ACTIVATE_HW_CONFIG		= 0x114,
+
+	XSC_CMD_OP_CREATE_EQ			= 0x301,
+	XSC_CMD_OP_DESTROY_EQ			= 0x302,
+
+	XSC_CMD_OP_CREATE_CQ			= 0x400,
+	XSC_CMD_OP_DESTROY_CQ			= 0x401,
+
+	XSC_CMD_OP_CREATE_QP			= 0x500,
+	XSC_CMD_OP_DESTROY_QP			= 0x501,
+	XSC_CMD_OP_RST2INIT_QP			= 0x502,
+	XSC_CMD_OP_INIT2RTR_QP			= 0x503,
+	XSC_CMD_OP_RTR2RTS_QP			= 0x504,
+	XSC_CMD_OP_RTS2RTS_QP			= 0x505,
+	XSC_CMD_OP_SQERR2RTS_QP			= 0x506,
+	XSC_CMD_OP_2ERR_QP			= 0x507,
+	XSC_CMD_OP_RTS2SQD_QP			= 0x508,
+	XSC_CMD_OP_SQD2RTS_QP			= 0x509,
+	XSC_CMD_OP_2RST_QP			= 0x50a,
+	XSC_CMD_OP_INIT2INIT_QP			= 0x50e,
+	XSC_CMD_OP_CREATE_MULTI_QP		= 0x515,
+
+	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
+
+	XSC_CMD_OP_ENABLE_NIC_HCA		= 0x810,
+	XSC_CMD_OP_DISABLE_NIC_HCA		= 0x811,
+
+	XSC_CMD_OP_QUERY_VPORT_STATE		= 0x822,
+	XSC_CMD_OP_QUERY_EVENT_TYPE		= 0x831,
+
+	XSC_CMD_OP_ENABLE_MSIX			= 0x850,
+
+	XSC_CMD_OP_SET_MTU			= 0x1100,
+	XSC_CMD_OP_QUERY_ETH_MAC		= 0X1101,
+
+	XSC_CMD_OP_SET_PORT_ADMIN_STATUS	= 0x1801,
+
+	XSC_CMD_OP_MAX
+};
+
+enum xsc_dma_direct {
+	XSC_DMA_DIR_TO_MAC,
+	XSC_DMA_DIR_READ,
+	XSC_DMA_DIR_WRITE,
+	XSC_DMA_DIR_LOOPBACK,
+	XSC_DMA_DIR_MAX
+};
+
+/* hw feature bitmap, 32bit */
+enum xsc_hw_feature_flag {
+	XSC_HW_RDMA_SUPPORT			= BIT(0),
+	XSC_HW_PFC_PRIO_STATISTIC_SUPPORT	= BIT(1),
+	XSC_HW_PFC_STALL_STATS_SUPPORT		= BIT(3),
+	XSC_HW_RDMA_CM_SUPPORT			= BIT(5),
+
+	XSC_HW_LAST_FEATURE			= BIT(31)
+};
+
+struct xsc_inbox_hdr {
+	__be16		opcode;
+	u8		rsvd[4];
+	__be16		ver; /* cmd version */
+};
+
+struct xsc_outbox_hdr {
+	u8		status;
+	u8		rsvd[5];
+	__be16		ver;
+};
+
+/*CQ mbox*/
+struct xsc_cq_context {
+	__be16		eqn; /* event queue number */
+	__be16		pa_num; /* physical address count in the ctx */
+	__be16		glb_func_id;
+	u8		log_cq_sz;
+	u8		cq_type;
+};
+
+struct xsc_create_cq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_cq_context	ctx;
+	__be64			pas[]; /* physical address list */
+};
+
+struct xsc_create_cq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			cqn; /* completion queue number */
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_cq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			cqn;
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_cq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+/*QP mbox*/
+struct xsc_create_qp_request {
+	__be16		input_qpn;
+	__be16		pa_num;
+	u8		qp_type;
+	u8		log_sq_sz;
+	u8		log_rq_sz;
+	u8		dma_direct;
+	__be32		pdn; /* protect domain number */
+	__be16		cqn_send;
+	__be16		cqn_recv;
+	__be16		glb_funcid;
+	/*rsvd, the old logic_port */
+	u8		rsvd[2];
+	__be64		pas[];
+};
+
+struct xsc_create_qp_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_create_qp_request	req;
+};
+
+struct xsc_create_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			qpn; /* queue pair number */
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_qp_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			qpn;
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_qp_context {
+	__be32		remote_qpn;
+	__be32		cqn_send;
+	__be32		cqn_recv;
+	__be32		next_send_psn;
+	__be32		next_recv_psn;
+	__be32		pdn;
+	__be16		src_udp_port;
+	__be16		path_id;
+	u8		mtu_mode;
+	u8		lag_sel;
+	u8		lag_sel_en;
+	u8		retry_cnt;
+	u8		rnr_retry;
+	u8		dscp;
+	u8		state;
+	u8		hop_limit;
+	u8		dmac[6];
+	u8		smac[6];
+	__be32		dip[4];
+	__be32		sip[4];
+	__be16		ip_type;
+	__be16		grp_id;
+	u8		vlan_valid;
+	u8		dci_cfi_prio_sl;
+	__be16		vlan_id;
+	u8		qp_out_port;
+	u8		pcie_no;
+	__be16		lag_id;
+	__be16		func_id;
+	__be16		rsvd;
+};
+
+struct xsc_modify_qp_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			qpn;
+	struct xsc_qp_context	ctx;
+	u8			no_need_wait;
+};
+
+struct xsc_modify_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_create_multiqp_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			qp_num;
+	u8			qp_type;
+	u8			rsvd;
+	__be32			req_len;
+	u8			data[];
+};
+
+struct xsc_create_multiqp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			qpn_base;
+};
+
+/* MSIX TABLE mbox */
+struct xsc_msix_table_info_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			index;
+	u8			rsvd[6];
+};
+
+struct xsc_msix_table_info_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			addr_lo;
+	__be32			addr_hi;
+	__be32			data;
+};
+
+/*EQ mbox*/
+struct xsc_eq_context {
+	__be16			vecidx;
+	__be16			pa_num;
+	u8			log_eq_sz;
+	__be16			glb_func_id;
+	u8			is_async_eq;
+	u8			rsvd;
+};
+
+struct xsc_create_eq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_eq_context	ctx;
+	__be64			pas[];
+};
+
+struct xsc_create_eq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			eqn;
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_eq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			eqn;
+	u8			rsvd[4];
+};
+
+struct xsc_destroy_eq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_query_eq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd0[3];
+	u8			eqn;
+	u8			rsvd1[4];
+};
+
+struct xsc_query_eq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+	struct xsc_eq_context	ctx;
+};
+
+struct xsc_query_cq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			cqn;
+	u8			rsvd0[4];
+};
+
+struct xsc_query_cq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd0[8];
+	struct xsc_cq_context	ctx;
+	u8			rsvd6[16];
+	__be64			pas[];
+};
+
+struct xsc_cmd_query_cmdq_ver_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_query_cmdq_ver_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be16			cmdq_ver;
+	u8			rsvd[6];
+};
+
+struct xsc_cmd_dummy_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_dummy_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_fw_version {
+	u8		fw_version_major;
+	u8		fw_version_minor;
+	__be16		fw_version_patch;
+	__be32		fw_version_tweak;
+	u8		fw_version_extra_flag;
+	u8		rsvd[7];
+};
+
+struct xsc_hca_cap {
+	u8		rsvd1[12];
+	u8		send_seg_num;
+	u8		send_wqe_shift;
+	u8		recv_seg_num;
+	u8		recv_wqe_shift;
+	u8		log_max_srq_sz;
+	u8		log_max_qp_sz;
+	u8		log_max_mtt;
+	u8		log_max_qp;
+	u8		log_max_strq_sz;
+	u8		log_max_srqs;
+	u8		rsvd4[2];
+	u8		log_max_tso;
+	u8		log_max_cq_sz;
+	u8		rsvd6;
+	u8		log_max_cq;
+	u8		log_max_eq_sz;
+	u8		log_max_mkey;
+	u8		log_max_msix;
+	u8		log_max_eq;
+	u8		max_indirection;
+	u8		log_max_mrw_sz;
+	u8		log_max_bsf_list_sz;
+	u8		log_max_klm_list_sz;
+	u8		rsvd_8_0;
+	u8		log_max_ra_req_dc;
+	u8		rsvd_8_1;
+	u8		log_max_ra_res_dc;
+	u8		rsvd9;
+	u8		log_max_ra_req_qp;
+	u8		log_max_qp_depth;
+	u8		log_max_ra_res_qp;
+	__be16		max_vfs;
+	__be16		raweth_qp_id_end;
+	__be16		raw_tpe_qp_num;
+	__be16		max_qp_count;
+	__be16		raweth_qp_id_base;
+	u8		rsvd13;
+	u8		local_ca_ack_delay;
+	u8		max_num_eqs;
+	u8		num_ports;
+	u8		log_max_msg;
+	u8		mac_port;
+	__be16		raweth_rss_qp_id_base;
+	__be16		stat_rate_support;
+	u8		rsvd16[2];
+	__be64		flags;
+	u8		rsvd17;
+	u8		uar_sz;
+	u8		rsvd18;
+	u8		log_pg_sz;
+	__be16		bf_log_bf_reg_size;
+	__be16		msix_base;
+	__be16		msix_num;
+	__be16		max_desc_sz_sq;
+	u8		rsvd20[2];
+	__be16		max_desc_sz_rq;
+	u8		rsvd21[2];
+	__be16		max_desc_sz_sq_dc;
+	u8		rsvd22[4];
+	__be16		max_qp_mcg;
+	u8		rsvd23;
+	u8		log_max_mcg;
+	u8		rsvd24;
+	u8		log_max_pd;
+	u8		rsvd25;
+	u8		log_max_xrcd;
+	u8		rsvd26[40];
+	__be32		uar_page_sz;
+	u8		rsvd27[8];
+	__be32		hw_feature_flag; /* enum xsc_hw_feature_flag */
+	__be16		pf0_vf_funcid_base;
+	__be16		pf0_vf_funcid_top;
+	__be16		pf1_vf_funcid_base;
+	__be16		pf1_vf_funcid_top;
+	__be16		pcie0_pf_funcid_base;
+	__be16		pcie0_pf_funcid_top;
+	__be16		pcie1_pf_funcid_base;
+	__be16		pcie1_pf_funcid_top;
+	u8		log_msx_atomic_size_qp;
+	u8		pcie_host;
+	u8		rsvd28;
+	u8		log_msx_atomic_size_dc;
+	u8		board_sn[XSC_BOARD_SN_LEN];
+	u8		max_tc;
+	u8		mac_bit;
+	__be16		funcid_to_logic_port;
+	u8		rsvd29[6];
+	u8		nif_port_num;
+	u8		reg_mr_via_cmdq;
+	__be32		hca_core_clock;
+	__be32		max_rwq_indirection_tables; /* rss_caps */
+	__be32		max_rwq_indirection_table_size; /* rss_caps */
+	__be32		chip_ver_h;
+	__be32		chip_ver_m;
+	__be32		chip_ver_l;
+	__be32		hotfix_num;
+	__be32		feature_flag;
+	__be32		rx_pkt_len_max;
+	__be32		glb_func_id;
+	__be64		tx_db;
+	__be64		rx_db;
+	__be64		complete_db;
+	__be64		complete_reg;
+	__be64		event_db;
+	__be32		qp_rate_limit_min;
+	__be32		qp_rate_limit_max;
+	struct xsc_fw_version	fw_ver;
+	u8		lag_logic_port_ofst;
+};
+
+struct xsc_cmd_query_hca_cap_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			cpu_num;
+	u8			rsvd[6];
+};
+
+struct xsc_cmd_query_hca_cap_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd0[8];
+	struct xsc_hca_cap	hca_cap;
+};
+
+struct xsc_query_vport_state_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			admin_state:4;
+	u8			state:4;
+};
+
+struct xsc_query_vport_state_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			data0;
+#define XSC_QUERY_VPORT_OTHER_VPORT	BIT(0)
+#define XSC_QUERY_VPORT_VPORT_NUM_MASK	GENMASK(16, 1)
+};
+
+enum {
+	XSC_CMD_EVENT_RESP_CHANGE_LINK		= BIT(0),
+	XSC_CMD_EVENT_RESP_TEMP_WARN		= BIT(1),
+	XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION	= BIT(2),
+};
+
+struct xsc_event_resp {
+	u8			resp_cmd_type;
+};
+
+struct xsc_event_query_type_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[2];
+};
+
+struct xsc_event_query_type_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_event_resp	ctx;
+};
+
+struct xsc_modify_raw_qp_request {
+	__be16		qpn;
+	__be16		lag_id;
+	__be16		func_id;
+	u8		dma_direct;
+	u8		prio;
+	u8		qp_out_port;
+	u8		rsvd[7];
+};
+
+struct xsc_modify_raw_qp_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			pcie_no;
+	u8			rsvd[7];
+	struct xsc_modify_raw_qp_request	req;
+};
+
+struct xsc_modify_raw_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_set_mtu_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			mtu;
+	__be16			rx_buf_sz_min;
+	u8			mac_port;
+	u8			rsvd;
+};
+
+struct xsc_set_mtu_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+};
+
+struct xsc_query_eth_mac_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			index;
+};
+
+struct xsc_query_eth_mac_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			mac[ETH_ALEN];
+};
+
+enum {
+	XSC_TBM_CAP_HASH_PPH = 0,
+	XSC_TBM_CAP_RSS,
+	XSC_TBM_CAP_PP_BYPASS,
+	XSC_TBM_CAP_PCT_DROP_CONFIG,
+};
+
+struct xsc_nic_attr {
+	__be16	caps;
+	__be16	caps_mask;
+	u8	mac_addr[ETH_ALEN];
+};
+
+struct xsc_rss_attr {
+	u8	rss_en;
+	u8	hfunc;
+	__be16	rqn_base;
+	__be16	rqn_num;
+	__be32	hash_tmpl;
+};
+
+struct xsc_cmd_enable_nic_hca_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_nic_attr	nic;
+	struct xsc_rss_attr	rss;
+};
+
+struct xsc_cmd_enable_nic_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd0[2];
+};
+
+struct xsc_nic_dis_attr {
+	__be16	caps;
+};
+
+struct xsc_cmd_disable_nic_hca_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_nic_dis_attr		nic;
+};
+
+struct xsc_cmd_disable_nic_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd0[4];
+};
+
+struct xsc_function_reset_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			glb_func_id;
+	u8			rsvd[6];
+};
+
+struct xsc_function_reset_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_query_guid_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_query_guid_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be64			guid;
+};
+
+struct xsc_cmd_activate_hw_config_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_activate_hw_config_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_event_set_port_admin_status_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			status;
+};
+
+struct xsc_event_set_port_admin_status_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			status;
+};
+
+#endif /* __XSC_CMD_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
new file mode 100644
index 000000000..0b29fc2f7
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_CMDQ_H
+#define __XSC_CMDQ_H
+
+#include <linux/if_ether.h>
+
+#include "common/xsc_cmd.h"
+
+enum {
+	XSC_CMD_TIMEOUT_MSEC	= 10 * 1000,
+	XSC_CMD_WQ_MAX_NAME	= 32,
+};
+
+enum {
+	XSC_CMD_DATA, /* print command payload only */
+	XSC_CMD_TIME, /* print command execution time */
+};
+
+enum {
+	XSC_MAX_COMMANDS		= 32,
+	XSC_CMD_DATA_BLOCK_SIZE	= 512,
+	XSC_PCI_CMD_XPORT		= 7,
+};
+
+struct xsc_cmd_prot_block {
+	u8		data[XSC_CMD_DATA_BLOCK_SIZE];
+	u8		rsvd0[48];
+	__be64		next;
+	__be32		block_num;
+	/* init to 0, dma user should change this val to 1 */
+	u8		owner_status;
+	u8		token;
+	u8		ctrl_sig;
+	u8		sig;
+};
+
+struct cache_ent {
+	/* protect block chain allocations */
+	spinlock_t		lock;
+	struct list_head	head;
+};
+
+struct cmd_msg_cache {
+	struct cache_ent	large;
+	struct cache_ent	med;
+
+};
+
+#define CMD_FIRST_SIZE 8
+struct xsc_cmd_first {
+	__be32		data[CMD_FIRST_SIZE];
+};
+
+struct xsc_cmd_mailbox {
+	void			*buf;
+	dma_addr_t		dma;
+	struct xsc_cmd_mailbox *next;
+};
+
+struct xsc_cmd_msg {
+	struct list_head	list;
+	struct cache_ent	*cache;
+	u32			len;
+	struct xsc_cmd_first	first;
+	struct xsc_cmd_mailbox	*next;
+};
+
+#define RSP_FIRST_SIZE 14
+struct xsc_rsp_first {
+	/* can be larger, xsc_rsp_layout */
+	__be32		data[RSP_FIRST_SIZE];
+};
+
+struct xsc_rsp_msg {
+	struct list_head		list;
+	struct cache_ent		*cache;
+	u32				len;
+	struct xsc_rsp_first		first;
+	struct xsc_cmd_mailbox		*next;
+};
+
+typedef void (*xsc_cmd_cbk_t)(int status, void *context);
+
+/* hw will use this for some records(e.g. vf_id) */
+struct cmdq_rsv {
+	u16	vf_id;
+	u8	rsv[2];
+};
+
+/* related with hw, won't change */
+#define CMDQ_ENTRY_SIZE 64
+
+struct xsc_cmd_layout {
+	struct cmdq_rsv	rsv0;
+	__be32		inlen;
+	__be64		in_ptr;
+	__be32		in[CMD_FIRST_SIZE];
+	__be64		out_ptr;
+	__be32		outlen;
+	u8		token;
+	u8		sig;
+	u8		idx;
+	u8		type: 7;
+	/* rsv for hw, arm will check this bit to make sure mem written */
+	u8		owner_bit: 1;
+};
+
+struct xsc_rsp_layout {
+	struct cmdq_rsv	rsv0;
+	__be32		out[RSP_FIRST_SIZE];
+	u8		token;
+	u8		sig;
+	u8		idx;
+	u8		type: 7;
+	/* rsv for hw, driver will check this bit to make sure mem written */
+	u8		owner_bit: 1;
+};
+
+struct xsc_cmd_work_ent {
+	struct xsc_cmd_msg	*in;
+	struct xsc_rsp_msg	*out;
+	int			idx;
+	struct completion	done;
+	struct xsc_cmd		*cmd;
+	struct work_struct	work;
+	struct xsc_cmd_layout	*lay;
+	struct xsc_rsp_layout	*rsp_lay;
+	int			ret;
+	u8			status;
+	u8			token;
+	struct timespec64	ts1;
+	struct timespec64	ts2;
+};
+
+struct xsc_cmd_debug {
+	struct dentry		*dbg_root;
+	struct dentry		*dbg_in;
+	struct dentry		*dbg_out;
+	struct dentry		*dbg_outlen;
+	struct dentry		*dbg_status;
+	struct dentry		*dbg_run;
+	void			*in_msg;
+	void			*out_msg;
+	u8			status;
+	u16			inlen;
+	u16			outlen;
+};
+
+struct xsc_cmd_stats {
+	u64		sum;
+	u64		n;
+	struct dentry	*root;
+	struct dentry	*avg;
+	struct dentry	*count;
+	/* protect command average calculations */
+	spinlock_t	lock;
+};
+
+struct xsc_cmd_reg {
+	u32 req_pid_addr;
+	u32 req_cid_addr;
+	u32 rsp_pid_addr;
+	u32 rsp_cid_addr;
+	u32 req_buf_h_addr;
+	u32 req_buf_l_addr;
+	u32 rsp_buf_h_addr;
+	u32 rsp_buf_l_addr;
+	u32 msix_vec_addr;
+	u32 element_sz_addr;
+	u32 q_depth_addr;
+	u32 interrupt_stat_addr;
+};
+
+enum xsc_cmd_status {
+	XSC_CMD_STATUS_NORMAL,
+	XSC_CMD_STATUS_TIMEDOUT,
+};
+
+enum xsc_cmd_mode {
+	XSC_CMD_MODE_POLLING,
+	XSC_CMD_MODE_EVENTS,
+};
+
+struct xsc_cmd {
+	struct xsc_cmd_reg	reg;
+	void			*cmd_buf;
+	void			*cq_buf;
+	dma_addr_t		dma;
+	dma_addr_t		cq_dma;
+	u16			cmd_pid;
+	u16			cq_cid;
+	u8			owner_bit;
+	u8			cmdif_rev;
+	u8			log_sz;
+	u8			log_stride;
+	int			max_reg_cmds;
+	int			events;
+	u32 __iomem		*vector;
+
+	/* protect command queue allocations */
+	spinlock_t		alloc_lock;
+	/* protect token allocations */
+	spinlock_t		token_lock;
+	/* protect cmdq req pid doorbell */
+	spinlock_t		doorbell_lock;
+	u8			token;
+	unsigned long		cmd_entry_mask;
+	char			wq_name[XSC_CMD_WQ_MAX_NAME];
+	struct workqueue_struct	*wq;
+	struct task_struct	*cq_task;
+	/* The semaphore limits the number of working commands
+	 * to max_reg_cmds. Each exec_cmd call does a down
+	 * to acquire the semaphore before execution and an up
+	 * after completion, ensuring no more than max_reg_cmds
+	 * commands run at the same time.
+	 */
+	struct semaphore	sem;
+	enum xsc_cmd_mode	mode;
+	struct xsc_cmd_work_ent	*ent_arr[XSC_MAX_COMMANDS];
+	struct dma_pool		*pool;
+	struct xsc_cmd_debug	dbg;
+	struct cmd_msg_cache	cache;
+	int			checksum_disabled;
+	struct xsc_cmd_stats	stats[XSC_CMD_OP_MAX];
+	unsigned int		irqn;
+	u8			ownerbit_learned;
+	u8			cmd_status;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 0673e34fe..c6077b8b3 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -8,6 +8,8 @@
 
 #include <linux/pci.h>
 
+#include "common/xsc_cmdq.h"
+
 #define XSC_PCI_VENDOR_ID		0x1f67
 
 #define XSC_MC_PF_DEV_ID		0x1011
@@ -25,6 +27,8 @@
 #define XSC_MV_HOST_VF_DEV_ID		0x1152
 #define XSC_MV_SOC_PF_DEV_ID		0x1153
 
+#define XSC_REG_ADDR(dev, offset)	(((dev)->bar) + ((offset) - 0xA0000000))
+
 struct xsc_dev_resource {
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
@@ -38,6 +42,9 @@ struct xsc_core_device {
 
 	void __iomem		*bar;
 	int			bar_num;
+
+	struct xsc_cmd		cmd;
+	u16			cmdq_ver;
 };
 
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
new file mode 100644
index 000000000..d8a945fcc
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_DRIVER_H
+#define __XSC_DRIVER_H
+
+#include "common/xsc_core.h"
+#include "common/xsc_cmd.h"
+
+int xsc_cmd_init(struct xsc_core_device *xdev);
+void xsc_cmd_cleanup(struct xsc_core_device *xdev);
+void xsc_cmd_use_events(struct xsc_core_device *xdev);
+void xsc_cmd_use_polling(struct xsc_core_device *xdev);
+int xsc_cmd_err_handler(struct xsc_core_device *xdev);
+void xsc_cmd_resp_handler(struct xsc_core_device *xdev);
+int xsc_cmd_status_to_err(struct xsc_outbox_hdr *hdr);
+int xsc_cmd_exec(struct xsc_core_device *xdev,
+		 void *in, unsigned int in_size,
+		 void *out, unsigned int out_size);
+int xsc_cmd_version_check(struct xsc_core_device *xdev);
+const char *xsc_command_str(int command);
+
+#endif
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 709270df8..5e0f0a205 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o
+xsc_pci-y := main.o cmdq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
new file mode 100644
index 000000000..4d461f45a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
@@ -0,0 +1,1571 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ * Copyright (c) 2013-2016, Mellanox Technologies. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/kthread.h>
+#include <linux/io-mapping.h>
+
+#include "common/xsc_driver.h"
+#include "common/xsc_cmd.h"
+#include "common/xsc_auto_hw.h"
+#include "common/xsc_core.h"
+
+enum {
+	CMD_IF_REV = 3,
+};
+
+enum {
+	NUM_LONG_LISTS	  = 2,
+	NUM_MED_LISTS	  = 64,
+	LONG_LIST_SIZE	  = (2ULL * 1024 * 1024 * 1024 / PAGE_SIZE) * 8 + 16 +
+				XSC_CMD_DATA_BLOCK_SIZE,
+	MED_LIST_SIZE	  = 16 + XSC_CMD_DATA_BLOCK_SIZE,
+};
+
+enum {
+	XSC_CMD_DELIVERY_STAT_OK			= 0x0,
+	XSC_CMD_DELIVERY_STAT_SIGNAT_ERR		= 0x1,
+	XSC_CMD_DELIVERY_STAT_TOK_ERR			= 0x2,
+	XSC_CMD_DELIVERY_STAT_BAD_BLK_NUM_ERR		= 0x3,
+	XSC_CMD_DELIVERY_STAT_OUT_PTR_ALIGN_ERR		= 0x4,
+	XSC_CMD_DELIVERY_STAT_IN_PTR_ALIGN_ERR		= 0x5,
+	XSC_CMD_DELIVERY_STAT_FW_ERR			= 0x6,
+	XSC_CMD_DELIVERY_STAT_IN_LENGTH_ERR		= 0x7,
+	XSC_CMD_DELIVERY_STAT_OUT_LENGTH_ERR		= 0x8,
+	XSC_CMD_DELIVERY_STAT_RES_FLD_NOT_CLR_ERR	= 0x9,
+	XSC_CMD_DELIVERY_STAT_CMD_DESCR_ERR		= 0x10,
+};
+
+static struct xsc_cmd_work_ent *xsc_alloc_cmd(struct xsc_cmd *cmd,
+					      struct xsc_cmd_msg *in,
+					      struct xsc_rsp_msg *out)
+{
+	struct xsc_cmd_work_ent *ent;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	ent->in		= in;
+	ent->out	= out;
+	ent->cmd	= cmd;
+
+	return ent;
+}
+
+static void xsc_free_cmd(struct xsc_cmd_work_ent *ent)
+{
+	kfree(ent);
+}
+
+static u8 xsc_alloc_token(struct xsc_cmd *cmd)
+{
+	u8 token;
+
+	spin_lock(&cmd->token_lock);
+	token = cmd->token++ % 255 + 1;
+	spin_unlock(&cmd->token_lock);
+
+	return token;
+}
+
+static int xsc_alloc_ent(struct xsc_cmd *cmd)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cmd->alloc_lock, flags);
+	ret = find_first_bit(&cmd->cmd_entry_mask, cmd->max_reg_cmds);
+	if (ret < cmd->max_reg_cmds)
+		clear_bit(ret, &cmd->cmd_entry_mask);
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+
+	return ret < cmd->max_reg_cmds ? ret : -ENOSPC;
+}
+
+static void xsc_free_ent(struct xsc_cmd *cmd, int idx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmd->alloc_lock, flags);
+	set_bit(idx, &cmd->cmd_entry_mask);
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+}
+
+static struct xsc_cmd_layout *xsc_get_inst(struct xsc_cmd *cmd, int idx)
+{
+	return cmd->cmd_buf + (idx << cmd->log_stride);
+}
+
+static struct xsc_rsp_layout *xsc_get_cq_inst(struct xsc_cmd *cmd, int idx)
+{
+	return cmd->cq_buf + (idx << cmd->log_stride);
+}
+
+static u8 xsc_xor8_buf(void *buf, int len)
+{
+	u8 *ptr = buf;
+	u8 sum = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		sum ^= ptr[i];
+
+	return sum;
+}
+
+static int xsc_verify_block_sig(struct xsc_cmd_prot_block *block)
+{
+	/* rsvd0 was set to 0xFF by fw */
+	if (xsc_xor8_buf(block->rsvd0,
+			 sizeof(*block) - sizeof(block->data) - 1) != 0xff)
+		return -EINVAL;
+
+	if (xsc_xor8_buf(block, sizeof(*block)) != 0xff)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void xsc_calc_block_sig(struct xsc_cmd_prot_block *block, u8 token)
+{
+	block->token = token;
+	block->ctrl_sig = ~xsc_xor8_buf(block->rsvd0,
+				    sizeof(*block) - sizeof(block->data) - 2);
+	block->sig = ~xsc_xor8_buf(block, sizeof(*block) - 1);
+}
+
+static void xsc_calc_chain_sig(struct xsc_cmd_mailbox *head, u8 token)
+{
+	struct xsc_cmd_mailbox *next = head;
+
+	while (next) {
+		xsc_calc_block_sig(next->buf, token);
+		next = next->next;
+	}
+}
+
+static void xsc_set_signature(struct xsc_cmd_work_ent *ent)
+{
+	ent->lay->sig = ~xsc_xor8_buf(ent->lay, sizeof(*ent->lay));
+	xsc_calc_chain_sig(ent->in->next, ent->token);
+	xsc_calc_chain_sig(ent->out->next, ent->token);
+}
+
+static int xsc_verify_signature(struct xsc_cmd_work_ent *ent)
+{
+	struct xsc_cmd_mailbox *next = ent->out->next;
+	int err;
+	u8 sig;
+
+	sig = xsc_xor8_buf(ent->rsp_lay, sizeof(*ent->rsp_lay));
+	if (sig != 0xff)
+		return -EINVAL;
+
+	while (next) {
+		err = xsc_verify_block_sig(next->buf);
+		if (err)
+			return err;
+
+		next = next->next;
+	}
+
+	return 0;
+}
+
+const char *xsc_command_str(int command)
+{
+	switch (command) {
+	case XSC_CMD_OP_QUERY_HCA_CAP:
+		return "QUERY_HCA_CAP";
+
+	case XSC_CMD_OP_QUERY_CMDQ_VERSION:
+		return "QUERY_CMDQ_VERSION";
+
+	case XSC_CMD_OP_FUNCTION_RESET:
+		return "FUNCTION_RESET";
+
+	case XSC_CMD_OP_DUMMY:
+		return "DUMMY_CMD";
+
+	case XSC_CMD_OP_CREATE_EQ:
+		return "CREATE_EQ";
+
+	case XSC_CMD_OP_DESTROY_EQ:
+		return "DESTROY_EQ";
+
+	case XSC_CMD_OP_CREATE_CQ:
+		return "CREATE_CQ";
+
+	case XSC_CMD_OP_DESTROY_CQ:
+		return "DESTROY_CQ";
+
+	case XSC_CMD_OP_CREATE_QP:
+		return "CREATE_QP";
+
+	case XSC_CMD_OP_DESTROY_QP:
+		return "DESTROY_QP";
+
+	case XSC_CMD_OP_RST2INIT_QP:
+		return "RST2INIT_QP";
+
+	case XSC_CMD_OP_INIT2RTR_QP:
+		return "INIT2RTR_QP";
+
+	case XSC_CMD_OP_RTR2RTS_QP:
+		return "RTR2RTS_QP";
+
+	case XSC_CMD_OP_RTS2RTS_QP:
+		return "RTS2RTS_QP";
+
+	case XSC_CMD_OP_SQERR2RTS_QP:
+		return "SQERR2RTS_QP";
+
+	case XSC_CMD_OP_2ERR_QP:
+		return "2ERR_QP";
+
+	case XSC_CMD_OP_RTS2SQD_QP:
+		return "RTS2SQD_QP";
+
+	case XSC_CMD_OP_SQD2RTS_QP:
+		return "SQD2RTS_QP";
+
+	case XSC_CMD_OP_2RST_QP:
+		return "2RST_QP";
+
+	case XSC_CMD_OP_INIT2INIT_QP:
+		return "INIT2INIT_QP";
+
+	case XSC_CMD_OP_MODIFY_RAW_QP:
+		return "MODIFY_RAW_QP";
+
+	case XSC_CMD_OP_ENABLE_NIC_HCA:
+		return "ENABLE_NIC_HCA";
+
+	case XSC_CMD_OP_DISABLE_NIC_HCA:
+		return "DISABLE_NIC_HCA";
+
+	case XSC_CMD_OP_QUERY_VPORT_STATE:
+		return "QUERY_VPORT_STATE";
+
+	case XSC_CMD_OP_QUERY_EVENT_TYPE:
+		return "QUERY_EVENT_TYPE";
+
+	case XSC_CMD_OP_ENABLE_MSIX:
+		return "ENABLE_MSIX";
+
+	case XSC_CMD_OP_SET_MTU:
+		return "SET_MTU";
+
+	case XSC_CMD_OP_QUERY_ETH_MAC:
+		return "QUERY_ETH_MAC";
+
+	default: return "unknown command opcode";
+	}
+}
+
+static void cmd_work_handler(struct work_struct *work)
+{
+	struct xsc_cmd_work_ent *ent;
+	struct xsc_core_device *xdev;
+	struct xsc_cmd_layout *lay;
+	struct semaphore *sem;
+	struct xsc_cmd *cmd;
+	unsigned long flags;
+
+	ent = container_of(work, struct xsc_cmd_work_ent, work);
+	cmd = ent->cmd;
+	xdev = container_of(cmd, struct xsc_core_device, cmd);
+	sem = &cmd->sem;
+	down(sem);
+	ent->idx = xsc_alloc_ent(cmd);
+	if (ent->idx < 0) {
+		pci_err(xdev->pdev, "failed to allocate command entry\n");
+		up(sem);
+		return;
+	}
+
+	ent->token = xsc_alloc_token(cmd);
+	cmd->ent_arr[ent->idx] = ent;
+
+	spin_lock_irqsave(&cmd->doorbell_lock, flags);
+	lay = xsc_get_inst(cmd, cmd->cmd_pid);
+	ent->lay = lay;
+	memset(lay, 0, sizeof(*lay));
+	memcpy(lay->in, ent->in->first.data, sizeof(lay->in));
+	if (ent->in->next)
+		lay->in_ptr = cpu_to_be64(ent->in->next->dma);
+	lay->inlen = cpu_to_be32(ent->in->len);
+	if (ent->out->next)
+		lay->out_ptr = cpu_to_be64(ent->out->next->dma);
+	lay->outlen = cpu_to_be32(ent->out->len);
+	lay->type = XSC_PCI_CMD_XPORT;
+	lay->token = ent->token;
+	lay->idx = ent->idx;
+	if (!cmd->checksum_disabled)
+		xsc_set_signature(ent);
+	else
+		lay->sig = 0xff;
+
+	ktime_get_ts64(&ent->ts1);
+
+	/* ring doorbell after the descriptor is valid */
+	wmb();
+
+	cmd->cmd_pid = (cmd->cmd_pid + 1) % (1 << cmd->log_sz);
+	writel(cmd->cmd_pid, XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	spin_unlock_irqrestore(&cmd->doorbell_lock, flags);
+}
+
+static const char *xsc_deliv_status_to_str(u8 status)
+{
+	switch (status) {
+	case XSC_CMD_DELIVERY_STAT_OK:
+		return "no errors";
+	case XSC_CMD_DELIVERY_STAT_SIGNAT_ERR:
+		return "signature error";
+	case XSC_CMD_DELIVERY_STAT_TOK_ERR:
+		return "token error";
+	case XSC_CMD_DELIVERY_STAT_BAD_BLK_NUM_ERR:
+		return "bad block number";
+	case XSC_CMD_DELIVERY_STAT_OUT_PTR_ALIGN_ERR:
+		return "output pointer not aligned to block size";
+	case XSC_CMD_DELIVERY_STAT_IN_PTR_ALIGN_ERR:
+		return "input pointer not aligned to block size";
+	case XSC_CMD_DELIVERY_STAT_FW_ERR:
+		return "firmware internal error";
+	case XSC_CMD_DELIVERY_STAT_IN_LENGTH_ERR:
+		return "command input length error";
+	case XSC_CMD_DELIVERY_STAT_OUT_LENGTH_ERR:
+		return "command output length error";
+	case XSC_CMD_DELIVERY_STAT_RES_FLD_NOT_CLR_ERR:
+		return "reserved fields not cleared";
+	case XSC_CMD_DELIVERY_STAT_CMD_DESCR_ERR:
+		return "bad command descriptor type";
+	default:
+		return "unknown status code";
+	}
+}
+
+static u16 xsc_msg_to_opcode(struct xsc_cmd_msg *in)
+{
+	struct xsc_inbox_hdr *hdr = (struct xsc_inbox_hdr *)(in->first.data);
+
+	return be16_to_cpu(hdr->opcode);
+}
+
+static int xsc_wait_func(struct xsc_core_device *xdev,
+			 struct xsc_cmd_work_ent *ent)
+{
+	unsigned long timeout = msecs_to_jiffies(XSC_CMD_TIMEOUT_MSEC);
+	struct xsc_cmd *cmd = &xdev->cmd;
+	int err;
+
+	if (!wait_for_completion_timeout(&ent->done, timeout))
+		err = -ETIMEDOUT;
+	else
+		err = ent->ret;
+
+	if (err == -ETIMEDOUT) {
+		cmd->cmd_status = XSC_CMD_STATUS_TIMEDOUT;
+		pci_err(xdev->pdev, "wait for %s(0x%x) response timeout!\n",
+			xsc_command_str(xsc_msg_to_opcode(ent->in)),
+			xsc_msg_to_opcode(ent->in));
+	} else if (err) {
+		pci_err(xdev->pdev, "err %d, delivery status %s(%d)\n", err,
+			xsc_deliv_status_to_str(ent->status), ent->status);
+	}
+
+	return err;
+}
+
+/*  Notes:
+ *    1. Callback functions may not sleep
+ *    2. page queue commands do not support asynchrous completion
+ */
+static int xsc_cmd_invoke(struct xsc_core_device *xdev, struct xsc_cmd_msg *in,
+			  struct xsc_rsp_msg *out, u8 *status)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_work_ent *ent;
+	struct xsc_cmd_stats *stats;
+	ktime_t t1, t2, delta;
+	struct semaphore *sem;
+	int err = 0;
+	s64 ds;
+	u16 op;
+
+	ent = xsc_alloc_cmd(cmd, in, out);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);
+
+	init_completion(&ent->done);
+	INIT_WORK(&ent->work, cmd_work_handler);
+	if (!queue_work(cmd->wq, &ent->work)) {
+		pci_err(xdev->pdev, "failed to queue work\n");
+		err = -ENOMEM;
+		goto err_free;
+	}
+
+	err = xsc_wait_func(xdev, ent);
+	if (err == -ETIMEDOUT)
+		goto err_sem_up;
+	t1 = timespec64_to_ktime(ent->ts1);
+	t2 = timespec64_to_ktime(ent->ts2);
+	delta = ktime_sub(t2, t1);
+	ds = ktime_to_ns(delta);
+	op = be16_to_cpu(((struct xsc_inbox_hdr *)in->first.data)->opcode);
+	if (op < ARRAY_SIZE(cmd->stats)) {
+		stats = &cmd->stats[op];
+		spin_lock(&stats->lock);
+		stats->sum += ds;
+		++stats->n;
+		spin_unlock(&stats->lock);
+	}
+	*status = ent->status;
+	xsc_free_cmd(ent);
+
+	return err;
+
+err_sem_up:
+	sem = &cmd->sem;
+	up(sem);
+err_free:
+	xsc_free_cmd(ent);
+	return err;
+}
+
+static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from,
+			       unsigned int size)
+{
+	struct xsc_cmd_prot_block *block;
+	struct xsc_cmd_mailbox *next;
+	unsigned int copy;
+
+	if (!to || !from)
+		return -ENOMEM;
+
+	copy = min(size, sizeof(to->first.data));
+	memcpy(to->first.data, from, copy);
+	size -= copy;
+	from += copy;
+
+	next = to->next;
+	while (size) {
+		if (!next) {
+			WARN_ONCE(1, "Mail box not enough\n");
+			return -ENOMEM;
+		}
+
+		copy = min(size, XSC_CMD_DATA_BLOCK_SIZE);
+		block = next->buf;
+		memcpy(block->data, from, copy);
+		block->owner_status = 0;
+		from += copy;
+		size -= copy;
+		next = next->next;
+	}
+
+	return 0;
+}
+
+static int xsc_copy_from_rsp_msg(void *to, struct xsc_rsp_msg *from,
+				 unsigned int size)
+{
+	struct xsc_cmd_prot_block *block;
+	struct xsc_cmd_mailbox *next;
+	unsigned int copy;
+
+	if (!to || !from)
+		return -ENOMEM;
+
+	copy = min(size, sizeof(from->first.data));
+	memcpy(to, from->first.data, copy);
+	size -= copy;
+	to += copy;
+
+	next = from->next;
+	while (size) {
+		if (!next) {
+			WARN_ONCE(1, "Mail too short\n");
+			return -ENOMEM;
+		}
+
+		copy = min(size, XSC_CMD_DATA_BLOCK_SIZE);
+		block = next->buf;
+		if (!block->owner_status)
+			pr_err("block ownership check failed\n");
+
+		memcpy(to, block->data, copy);
+		to += copy;
+		size -= copy;
+		next = next->next;
+	}
+
+	return 0;
+}
+
+static struct xsc_cmd_mailbox *xsc_alloc_cmd_box(struct xsc_core_device *xdev,
+						 gfp_t flags)
+{
+	struct xsc_cmd_mailbox *mailbox;
+
+	mailbox = kmalloc(sizeof(*mailbox), flags);
+	if (!mailbox)
+		return ERR_PTR(-ENOMEM);
+
+	mailbox->buf = dma_pool_zalloc(xdev->cmd.pool, flags,
+				       &mailbox->dma);
+	if (!mailbox->buf) {
+		kfree(mailbox);
+		return ERR_PTR(-ENOMEM);
+	}
+	mailbox->next = NULL;
+
+	return mailbox;
+}
+
+static void xsc_free_cmd_box(struct xsc_core_device *xdev,
+			     struct xsc_cmd_mailbox *mailbox)
+{
+	dma_pool_free(xdev->cmd.pool, mailbox->buf, mailbox->dma);
+
+	kfree(mailbox);
+}
+
+static struct xsc_cmd_msg *xsc_alloc_cmd_msg(struct xsc_core_device *xdev,
+					     gfp_t flags, unsigned int size)
+{
+	struct xsc_cmd_mailbox *tmp, *head = NULL;
+	struct xsc_cmd_prot_block *block;
+	struct xsc_cmd_msg *msg;
+	int blen;
+	int err;
+	int n;
+	int i;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+
+	blen = size - min(sizeof(msg->first.data), size);
+	n = (blen + XSC_CMD_DATA_BLOCK_SIZE - 1) / XSC_CMD_DATA_BLOCK_SIZE;
+
+	for (i = 0; i < n; i++) {
+		tmp = xsc_alloc_cmd_box(xdev, flags);
+		if (IS_ERR(tmp)) {
+			pci_err(xdev->pdev, "failed allocating block\n");
+			err = PTR_ERR(tmp);
+			goto err_free;
+		}
+
+		block = tmp->buf;
+		tmp->next = head;
+		block->next = cpu_to_be64(tmp->next ? tmp->next->dma : 0);
+		block->block_num = cpu_to_be32(n - i - 1);
+		head = tmp;
+	}
+	msg->next = head;
+	msg->len = size;
+	return msg;
+
+err_free:
+	while (head) {
+		tmp = head->next;
+		xsc_free_cmd_box(xdev, head);
+		head = tmp;
+	}
+	kfree(msg);
+
+	return ERR_PTR(err);
+}
+
+static void xsc_free_cmd_msg(struct xsc_core_device *xdev,
+			     struct xsc_cmd_msg *msg)
+{
+	struct xsc_cmd_mailbox *head = msg->next;
+	struct xsc_cmd_mailbox *next;
+
+	while (head) {
+		next = head->next;
+		xsc_free_cmd_box(xdev, head);
+		head = next;
+	}
+	kfree(msg);
+}
+
+static struct xsc_rsp_msg *xsc_alloc_rsp_msg(struct xsc_core_device *xdev,
+					     gfp_t flags, unsigned int size)
+{
+	struct xsc_cmd_mailbox *tmp, *head = NULL;
+	struct xsc_cmd_prot_block *block;
+	struct xsc_rsp_msg *msg;
+	int blen;
+	int err;
+	int n;
+	int i;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+
+	blen = size - min_t(int, sizeof(msg->first.data), size);
+	n = (blen + XSC_CMD_DATA_BLOCK_SIZE - 1) / XSC_CMD_DATA_BLOCK_SIZE;
+
+	for (i = 0; i < n; i++) {
+		tmp = xsc_alloc_cmd_box(xdev, flags);
+		if (IS_ERR(tmp)) {
+			pci_err(xdev->pdev, "failed allocating block\n");
+			err = PTR_ERR(tmp);
+			goto err_free;
+		}
+
+		block = tmp->buf;
+		tmp->next = head;
+		block->next = cpu_to_be64(tmp->next ? tmp->next->dma : 0);
+		block->block_num = cpu_to_be32(n - i - 1);
+		head = tmp;
+	}
+	msg->next = head;
+	msg->len = size;
+	return msg;
+
+err_free:
+	while (head) {
+		tmp = head->next;
+		xsc_free_cmd_box(xdev, head);
+		head = tmp;
+	}
+	kfree(msg);
+
+	return ERR_PTR(err);
+}
+
+static void xsc_free_rsp_msg(struct xsc_core_device *xdev,
+			     struct xsc_rsp_msg *msg)
+{
+	struct xsc_cmd_mailbox *head = msg->next;
+	struct xsc_cmd_mailbox *next;
+
+	while (head) {
+		next = head->next;
+		xsc_free_cmd_box(xdev, head);
+		head = next;
+	}
+	kfree(msg);
+}
+
+static void xsc_set_wqname(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+
+	snprintf(cmd->wq_name, sizeof(cmd->wq_name), "xsc_cmd_%s",
+		 dev_name(&xdev->pdev->dev));
+}
+
+void xsc_cmd_use_events(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	int i;
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		down(&cmd->sem);
+
+	flush_workqueue(cmd->wq);
+
+	cmd->mode = XSC_CMD_MODE_EVENTS;
+
+	while (cmd->cmd_pid != cmd->cq_cid)
+		msleep(20);
+	kthread_stop(cmd->cq_task);
+	cmd->cq_task = NULL;
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		up(&cmd->sem);
+}
+
+static int xsc_cmd_cq_polling(void *data);
+void xsc_cmd_use_polling(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	int i;
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		down(&cmd->sem);
+
+	flush_workqueue(cmd->wq);
+	cmd->mode = XSC_CMD_MODE_POLLING;
+	cmd->cq_task = kthread_create(xsc_cmd_cq_polling,
+				      (void *)xdev,
+				      "xsc_cmd_cq_polling");
+	if (cmd->cq_task)
+		wake_up_process(cmd->cq_task);
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		up(&cmd->sem);
+}
+
+static int xsc_status_to_err(u8 status)
+{
+	return status ? -1 : 0;
+}
+
+static struct xsc_cmd_msg *xsc_alloc_msg(struct xsc_core_device *xdev,
+					 unsigned int in_size)
+{
+	struct xsc_cmd_msg *msg = ERR_PTR(-ENOMEM);
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct cache_ent *ent = NULL;
+
+	if (in_size > MED_LIST_SIZE && in_size <= LONG_LIST_SIZE)
+		ent = &cmd->cache.large;
+	else if (in_size > 16 && in_size <= MED_LIST_SIZE)
+		ent = &cmd->cache.med;
+
+	if (ent) {
+		spin_lock(&ent->lock);
+		if (!list_empty(&ent->head)) {
+			msg = list_entry(ent->head.next, typeof(*msg), list);
+			/* For cached lists, we must explicitly state what is
+			 * the real size
+			 */
+			msg->len = in_size;
+			list_del(&msg->list);
+		}
+		spin_unlock(&ent->lock);
+	}
+
+	if (IS_ERR(msg))
+		msg = xsc_alloc_cmd_msg(xdev, GFP_KERNEL, in_size);
+
+	return msg;
+}
+
+static void xsc_free_msg(struct xsc_core_device *xdev, struct xsc_cmd_msg *msg)
+{
+	if (msg->cache) {
+		spin_lock(&msg->cache->lock);
+		list_add_tail(&msg->list, &msg->cache->head);
+		spin_unlock(&msg->cache->lock);
+	} else {
+		xsc_free_cmd_msg(xdev, msg);
+	}
+}
+
+static int xsc_dummy_work(struct xsc_core_device *xdev,
+			  struct xsc_cmd_msg *in,
+			  struct xsc_rsp_msg *out,
+			  u16 dummy_cnt,
+			  u16 dummy_start_pid)
+{
+	struct xsc_cmd_work_ent **dummy_ent_arr;
+	struct xsc_cmd *cmd = &xdev->cmd;
+	u16 temp_pid = dummy_start_pid;
+	struct xsc_cmd_layout *lay;
+	struct semaphore *sem;
+	u16 free_cnt = 0;
+	int err = 0;
+	u16 i;
+
+	sem = &cmd->sem;
+
+	dummy_ent_arr = kcalloc(dummy_cnt, sizeof(struct xsc_cmd_work_ent *),
+				GFP_KERNEL);
+	if (!dummy_ent_arr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < dummy_cnt; i++) {
+		dummy_ent_arr[i] = xsc_alloc_cmd(cmd, in, out);
+		if (IS_ERR(dummy_ent_arr[i])) {
+			pci_err(xdev->pdev, "failed to alloc cmd buffer\n");
+			err = -ENOMEM;
+			free_cnt = i;
+			goto err_free;
+		}
+
+		down(sem);
+
+		dummy_ent_arr[i]->idx = xsc_alloc_ent(cmd);
+		if (dummy_ent_arr[i]->idx < 0) {
+			pci_err(xdev->pdev, "failed to allocate command entry\n");
+			err = -1;
+			free_cnt = i;
+			up(sem);
+			xsc_free_cmd(dummy_ent_arr[i]);
+			goto err_free;
+		}
+		dummy_ent_arr[i]->token = xsc_alloc_token(cmd);
+		cmd->ent_arr[dummy_ent_arr[i]->idx] = dummy_ent_arr[i];
+		init_completion(&dummy_ent_arr[i]->done);
+
+		lay = xsc_get_inst(cmd, temp_pid);
+		dummy_ent_arr[i]->lay = lay;
+		memset(lay, 0, sizeof(*lay));
+		memcpy(lay->in,
+		       dummy_ent_arr[i]->in->first.data,
+		       sizeof(dummy_ent_arr[i]->in));
+		lay->inlen = cpu_to_be32(dummy_ent_arr[i]->in->len);
+		lay->outlen = cpu_to_be32(dummy_ent_arr[i]->out->len);
+		lay->type = XSC_PCI_CMD_XPORT;
+		lay->token = dummy_ent_arr[i]->token;
+		lay->idx = dummy_ent_arr[i]->idx;
+		if (!cmd->checksum_disabled)
+			xsc_set_signature(dummy_ent_arr[i]);
+		else
+			lay->sig = 0xff;
+		temp_pid = (temp_pid + 1) % (1 << cmd->log_sz);
+	}
+
+	/* ring doorbell after the descriptor is valid */
+	wmb();
+	writel(cmd->cmd_pid, XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	if (readl(XSC_REG_ADDR(xdev, cmd->reg.interrupt_stat_addr)) != 0)
+		writel(0xF, XSC_REG_ADDR(xdev, cmd->reg.interrupt_stat_addr));
+
+	if (wait_for_completion_timeout(&dummy_ent_arr[dummy_cnt - 1]->done,
+					msecs_to_jiffies(3000)) == 0) {
+		pci_err(xdev->pdev, "dummy_cmd %d ent timeout, cmdq fail\n",
+			dummy_cnt - 1);
+		err = -ETIMEDOUT;
+	}
+
+	for (i = 0; i < dummy_cnt; i++)
+		xsc_free_cmd(dummy_ent_arr[i]);
+
+	kfree(dummy_ent_arr);
+	return err;
+
+err_free:
+	for (i = 0; i < free_cnt; i++) {
+		xsc_free_ent(cmd, dummy_ent_arr[i]->idx);
+		up(sem);
+		xsc_free_cmd(dummy_ent_arr[i]);
+	}
+	kfree(dummy_ent_arr);
+err_out:
+	return err;
+}
+
+static int xsc_dummy_cmd_exec(struct xsc_core_device *xdev,
+			      void *in, unsigned int in_size,
+			      void *out, unsigned int out_size,
+			      u16 dmmy_cnt, u16 dummy_start)
+{
+	struct xsc_rsp_msg *outb;
+	struct xsc_cmd_msg *inb;
+	int err;
+
+	inb = xsc_alloc_msg(xdev, in_size);
+	if (IS_ERR(inb)) {
+		err = PTR_ERR(inb);
+		return err;
+	}
+
+	err = xsc_copy_to_cmd_msg(inb, in, in_size);
+	if (err) {
+		pci_err(xdev->pdev, "err %d\n", err);
+		goto err_free_msg;
+	}
+
+	outb = xsc_alloc_rsp_msg(xdev, GFP_KERNEL, out_size);
+	if (IS_ERR(outb)) {
+		err = PTR_ERR(outb);
+		goto err_free_msg;
+	}
+
+	err = xsc_dummy_work(xdev, inb, outb, dmmy_cnt, dummy_start);
+
+	if (err)
+		goto err_free_rsp;
+
+	err = xsc_copy_from_rsp_msg(out, outb, out_size);
+
+err_free_rsp:
+	xsc_free_rsp_msg(xdev, outb);
+
+err_free_msg:
+	xsc_free_msg(xdev, inb);
+	return err;
+}
+
+static int xsc_send_dummy_cmd(struct xsc_core_device *xdev,
+			      u16 gap, u16 dummy_start)
+{
+	struct xsc_cmd_dummy_mbox_out *out;
+	struct xsc_cmd_dummy_mbox_in in;
+	int err;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DUMMY);
+
+	err = xsc_dummy_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out),
+				 gap, dummy_start);
+	if (err)
+		goto err_free;
+
+	if (out->hdr.status) {
+		err = xsc_cmd_status_to_err(&out->hdr);
+		goto err_free;
+	}
+
+err_free:
+	kfree(out);
+	return err;
+}
+
+static int xsc_request_pid_cid_mismatch_restore(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	u16 req_pid, req_cid;
+	u16 gap;
+
+	int err;
+
+	req_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	req_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_cid_addr));
+	if (req_pid >= (1 << cmd->log_sz) || req_cid >= (1 << cmd->log_sz)) {
+		pci_err(xdev->pdev,
+			"req_pid %d, req_cid %d, out of normal range!!! max value is %d\n",
+			req_pid, req_cid, (1 << cmd->log_sz));
+		return -EFAULT;
+	}
+
+	if (req_pid == req_cid)
+		return 0;
+
+	gap = (req_pid > req_cid) ? (req_pid - req_cid)
+	      : ((1 << cmd->log_sz) + req_pid - req_cid);
+
+	err = xsc_send_dummy_cmd(xdev, gap, req_cid);
+	if (err) {
+		pci_err(xdev->pdev, "Send dummy cmd failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int _xsc_cmd_exec(struct xsc_core_device *xdev,
+			 void *in, unsigned int in_size,
+			 void *out, unsigned int out_size)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_rsp_msg *outb;
+	struct xsc_cmd_msg *inb;
+	u8 status = 0;
+	int err;
+
+	if (cmd->cmd_status == XSC_CMD_STATUS_TIMEDOUT)
+		return -ETIMEDOUT;
+
+	inb = xsc_alloc_msg(xdev, in_size);
+	if (IS_ERR(inb)) {
+		err = PTR_ERR(inb);
+		return err;
+	}
+
+	err = xsc_copy_to_cmd_msg(inb, in, in_size);
+	if (err) {
+		pci_err(xdev->pdev, "copy to cmd_msg err %d\n", err);
+		goto err_free_msg;
+	}
+
+	outb = xsc_alloc_rsp_msg(xdev, GFP_KERNEL, out_size);
+	if (IS_ERR(outb)) {
+		err = PTR_ERR(outb);
+		goto err_free_msg;
+	}
+
+	err = xsc_cmd_invoke(xdev, inb, outb, &status);
+	if (err)
+		goto err_free_rsp;
+
+	if (status) {
+		pci_err(xdev->pdev, "opcode:%#x, err %d, status %d\n",
+			xsc_msg_to_opcode(inb), err, status);
+		err = xsc_status_to_err(status);
+		goto err_free_rsp;
+	}
+
+	err = xsc_copy_from_rsp_msg(out, outb, out_size);
+
+err_free_rsp:
+	xsc_free_rsp_msg(xdev, outb);
+
+err_free_msg:
+	xsc_free_msg(xdev, inb);
+	return err;
+}
+
+int xsc_cmd_exec(struct xsc_core_device *xdev,
+		 void *in, unsigned int in_size,
+		 void *out, unsigned int out_size)
+{
+	struct xsc_inbox_hdr *hdr = (struct xsc_inbox_hdr *)in;
+
+	hdr->ver = 0;
+	if (hdr->ver != 0) {
+		pci_err(xdev->pdev, "recv an unexpected cmd ver = %d, opcode = %d\n",
+			be16_to_cpu(hdr->ver), be16_to_cpu(hdr->opcode));
+		WARN_ON(hdr->ver != 0);
+	}
+
+	return _xsc_cmd_exec(xdev, in, in_size, out, out_size);
+}
+EXPORT_SYMBOL(xsc_cmd_exec);
+
+static void xsc_destroy_msg_cache(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_msg *msg;
+	struct xsc_cmd_msg *n;
+
+	list_for_each_entry_safe(msg, n, &cmd->cache.large.head, list) {
+		list_del(&msg->list);
+		xsc_free_cmd_msg(xdev, msg);
+	}
+
+	list_for_each_entry_safe(msg, n, &cmd->cache.med.head, list) {
+		list_del(&msg->list);
+		xsc_free_cmd_msg(xdev, msg);
+	}
+}
+
+static int xsc_create_msg_cache(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_msg *msg;
+	int err;
+	int i;
+
+	spin_lock_init(&cmd->cache.large.lock);
+	INIT_LIST_HEAD(&cmd->cache.large.head);
+	spin_lock_init(&cmd->cache.med.lock);
+	INIT_LIST_HEAD(&cmd->cache.med.head);
+
+	for (i = 0; i < NUM_LONG_LISTS; i++) {
+		msg = xsc_alloc_cmd_msg(xdev, GFP_KERNEL, LONG_LIST_SIZE);
+		if (IS_ERR(msg)) {
+			err = PTR_ERR(msg);
+			goto err_destroy;
+		}
+		msg->cache = &cmd->cache.large;
+		list_add_tail(&msg->list, &cmd->cache.large.head);
+	}
+
+	for (i = 0; i < NUM_MED_LISTS; i++) {
+		msg = xsc_alloc_cmd_msg(xdev, GFP_KERNEL, MED_LIST_SIZE);
+		if (IS_ERR(msg)) {
+			err = PTR_ERR(msg);
+			goto err_destroy;
+		}
+		msg->cache = &cmd->cache.med;
+		list_add_tail(&msg->list, &cmd->cache.med.head);
+	}
+
+	return 0;
+
+err_destroy:
+	xsc_destroy_msg_cache(xdev);
+	return err;
+}
+
+static void xsc_cmd_comp_handler(struct xsc_core_device *xdev, u8 idx,
+				 struct xsc_rsp_layout *rsp)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_work_ent *ent;
+
+	if (idx > cmd->max_reg_cmds || (cmd->cmd_entry_mask & (1 << idx))) {
+		pci_err(xdev->pdev, "idx[%d] exceed max cmds, or has no relative request.\n",
+			idx);
+		return;
+	}
+	ent = cmd->ent_arr[idx];
+	ent->rsp_lay = rsp;
+	ktime_get_ts64(&ent->ts2);
+
+	memcpy(ent->out->first.data,
+	       ent->rsp_lay->out,
+	       sizeof(ent->rsp_lay->out));
+	if (!cmd->checksum_disabled)
+		ent->ret = xsc_verify_signature(ent);
+	else
+		ent->ret = 0;
+	ent->status = 0;
+
+	xsc_free_ent(cmd, ent->idx);
+	complete(&ent->done);
+	up(&cmd->sem);
+}
+
+static int xsc_cmd_cq_polling(void *data)
+{
+	struct xsc_core_device *xdev = data;
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_rsp_layout *rsp;
+	u32 cq_pid;
+
+	while (!kthread_should_stop()) {
+		if (need_resched())
+			schedule();
+		cq_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+		if (cmd->cq_cid == cq_pid) {
+			mdelay(3);
+			continue;
+		}
+
+		rsp = xsc_get_cq_inst(cmd, cmd->cq_cid);
+		if (!cmd->ownerbit_learned) {
+			cmd->ownerbit_learned = 1;
+			cmd->owner_bit = rsp->owner_bit;
+		}
+		if (cmd->owner_bit != rsp->owner_bit) {
+			pci_err(xdev->pdev, "hw update cq doorbell but buf not ready %u %u\n",
+				cmd->cq_cid, cq_pid);
+			continue;
+		}
+
+		xsc_cmd_comp_handler(xdev, rsp->idx, rsp);
+
+		cmd->cq_cid = (cmd->cq_cid + 1) % (1 << cmd->log_sz);
+
+		writel(cmd->cq_cid, XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+		if (cmd->cq_cid == 0)
+			cmd->owner_bit = !cmd->owner_bit;
+	}
+
+	return 0;
+}
+
+int xsc_cmd_err_handler(struct xsc_core_device *xdev)
+{
+	union interrupt_stat {
+		struct {
+			u32	hw_read_req_err:1;
+			u32	hw_write_req_err:1;
+			u32	req_pid_err:1;
+			u32	rsp_cid_err:1;
+		};
+		u32	raw;
+	} stat;
+	int retry = 0;
+	int err = 0;
+
+	stat.raw = readl(XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	while (stat.raw != 0) {
+		err++;
+		if (stat.hw_read_req_err) {
+			retry = 1;
+			stat.hw_read_req_err = 0;
+			pci_err(xdev->pdev, "hw report read req from host failed!\n");
+		} else if (stat.hw_write_req_err) {
+			retry = 1;
+			stat.hw_write_req_err = 0;
+			pci_err(xdev->pdev, "hw report write req to fw failed!\n");
+		} else if (stat.req_pid_err) {
+			stat.req_pid_err = 0;
+			pci_err(xdev->pdev, "hw report unexpected req pid!\n");
+		} else if (stat.rsp_cid_err) {
+			stat.rsp_cid_err = 0;
+			pci_err(xdev->pdev, "hw report unexpected rsp cid!\n");
+		} else {
+			stat.raw = 0;
+			pci_err(xdev->pdev, "ignore unknown interrupt!\n");
+		}
+	}
+
+	if (retry)
+		writel(xdev->cmd.cmd_pid,
+		       XSC_REG_ADDR(xdev, xdev->cmd.reg.req_pid_addr));
+
+	if (err)
+		writel(0xf,
+		       XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+
+	return err;
+}
+
+void xsc_cmd_resp_handler(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_rsp_layout *rsp;
+	const int budget = 32;
+	int count = 0;
+	u32 cq_pid;
+
+	while (count < budget) {
+		cq_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+		if (cq_pid == cmd->cq_cid)
+			return;
+
+		rsp = xsc_get_cq_inst(cmd, cmd->cq_cid);
+		if (!cmd->ownerbit_learned) {
+			cmd->ownerbit_learned = 1;
+			cmd->owner_bit = rsp->owner_bit;
+		}
+		if (cmd->owner_bit != rsp->owner_bit) {
+			pci_err(xdev->pdev, "hw update cq doorbell but buf not ready %u %u\n",
+				cmd->cq_cid, cq_pid);
+			return;
+		}
+
+		xsc_cmd_comp_handler(xdev, rsp->idx, rsp);
+
+		cmd->cq_cid = (cmd->cq_cid + 1) % (1 << cmd->log_sz);
+		writel(cmd->cq_cid, XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+		if (cmd->cq_cid == 0)
+			cmd->owner_bit = !cmd->owner_bit;
+
+		count++;
+	}
+}
+
+static void xsc_cmd_handle_rsp_before_reload
+(struct xsc_cmd *cmd, struct xsc_core_device *xdev)
+{
+	u32 rsp_pid, rsp_cid;
+
+	rsp_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+	rsp_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+	if (rsp_pid == rsp_cid)
+		return;
+
+	cmd->cq_cid = rsp_pid;
+
+	writel(cmd->cq_cid, XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+}
+
+int xsc_cmd_init(struct xsc_core_device *xdev)
+{
+	unsigned int size = sizeof(struct xsc_cmd_prot_block);
+	int align = roundup_pow_of_two(size);
+	struct xsc_cmd *cmd = &xdev->cmd;
+	u32 cmd_h, cmd_l;
+	u32 err_stat;
+	int err;
+	int i;
+
+	/* now there is 544 cmdq resource, soc using from id 514 */
+	cmd->reg.req_pid_addr = HIF_CMDQM_HOST_REQ_PID_MEM_ADDR;
+	cmd->reg.req_cid_addr = HIF_CMDQM_HOST_REQ_CID_MEM_ADDR;
+	cmd->reg.rsp_pid_addr = HIF_CMDQM_HOST_RSP_PID_MEM_ADDR;
+	cmd->reg.rsp_cid_addr = HIF_CMDQM_HOST_RSP_CID_MEM_ADDR;
+	cmd->reg.req_buf_h_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_H_ADDR_MEM_ADDR;
+	cmd->reg.req_buf_l_addr = HIF_CMDQM_HOST_REQ_BUF_BASE_L_ADDR_MEM_ADDR;
+	cmd->reg.rsp_buf_h_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_H_ADDR_MEM_ADDR;
+	cmd->reg.rsp_buf_l_addr = HIF_CMDQM_HOST_RSP_BUF_BASE_L_ADDR_MEM_ADDR;
+	cmd->reg.msix_vec_addr = HIF_CMDQM_VECTOR_ID_MEM_ADDR;
+	cmd->reg.element_sz_addr = HIF_CMDQM_Q_ELEMENT_SZ_REG_ADDR;
+	cmd->reg.q_depth_addr = HIF_CMDQM_HOST_Q_DEPTH_REG_ADDR;
+	cmd->reg.interrupt_stat_addr = HIF_CMDQM_HOST_VF_ERR_STS_MEM_ADDR;
+
+	cmd->pool = dma_pool_create("xsc_cmd",
+				    &xdev->pdev->dev,
+				    size, align, 0);
+	if (!cmd->pool)
+		return -ENOMEM;
+
+	cmd->cmd_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
+	if (!cmd->cmd_buf) {
+		err = -ENOMEM;
+		goto err_free_pool;
+	}
+	cmd->cq_buf = (void *)__get_free_pages(GFP_ATOMIC, 0);
+	if (!cmd->cq_buf) {
+		err = -ENOMEM;
+		goto err_free_cmd;
+	}
+
+	cmd->dma = dma_map_single(&xdev->pdev->dev, cmd->cmd_buf, PAGE_SIZE,
+				  DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&xdev->pdev->dev, cmd->dma)) {
+		err = -ENOMEM;
+		goto err_free_cq;
+	}
+
+	cmd->cq_dma = dma_map_single(&xdev->pdev->dev, cmd->cq_buf, PAGE_SIZE,
+				     DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&xdev->pdev->dev, cmd->cq_dma)) {
+		err = -ENOMEM;
+		goto err_unmap_cmd;
+	}
+
+	cmd->cmd_pid = readl(XSC_REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	cmd->cq_cid = readl(XSC_REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+	cmd->ownerbit_learned = 0;
+
+	xsc_cmd_handle_rsp_before_reload(cmd, xdev);
+
+#define ELEMENT_SIZE_LOG	6 /* 64B */
+#define Q_DEPTH_LOG		5 /* 32 */
+
+	cmd->log_sz = Q_DEPTH_LOG;
+	cmd->log_stride = readl(XSC_REG_ADDR(xdev, cmd->reg.element_sz_addr));
+	writel(1 << cmd->log_sz, XSC_REG_ADDR(xdev, cmd->reg.q_depth_addr));
+	if (cmd->log_stride != ELEMENT_SIZE_LOG) {
+		dev_err(&xdev->pdev->dev, "firmware failed to init cmdq, log_stride=(%d, %d)\n",
+			cmd->log_stride, ELEMENT_SIZE_LOG);
+		err = -ENODEV;
+		goto err_unmap_cq;
+	}
+
+	if (1 << cmd->log_sz > XSC_MAX_COMMANDS) {
+		dev_err(&xdev->pdev->dev, "firmware reports too many outstanding commands %d\n",
+			1 << cmd->log_sz);
+		err = -EINVAL;
+		goto err_unmap_cq;
+	}
+
+	if (cmd->log_sz + cmd->log_stride > PAGE_SHIFT) {
+		dev_err(&xdev->pdev->dev, "command queue size overflow\n");
+		err = -EINVAL;
+		goto err_unmap_cq;
+	}
+
+	cmd->checksum_disabled = 1;
+	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
+	cmd->cmd_entry_mask = (1 << cmd->max_reg_cmds) - 1;
+
+	spin_lock_init(&cmd->alloc_lock);
+	spin_lock_init(&cmd->token_lock);
+	spin_lock_init(&cmd->doorbell_lock);
+	for (i = 0; i < ARRAY_SIZE(cmd->stats); i++)
+		spin_lock_init(&cmd->stats[i].lock);
+
+	sema_init(&cmd->sem, cmd->max_reg_cmds);
+
+	cmd_h = upper_32_bits(cmd->dma);
+	cmd_l = lower_32_bits(cmd->dma);
+	if (cmd_l & 0xfff) {
+		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_unmap_cq;
+	}
+
+	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.req_buf_h_addr));
+	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.req_buf_l_addr));
+
+	cmd_h = upper_32_bits(cmd->cq_dma);
+	cmd_l = lower_32_bits(cmd->cq_dma);
+	if (cmd_l & 0xfff) {
+		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_unmap_cq;
+	}
+	writel(cmd_h, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_h_addr));
+	writel(cmd_l, XSC_REG_ADDR(xdev, cmd->reg.rsp_buf_l_addr));
+
+	/* Make sure firmware sees the complete address before we proceed */
+	wmb();
+
+	cmd->mode = XSC_CMD_MODE_POLLING;
+	cmd->cmd_status = XSC_CMD_STATUS_NORMAL;
+
+	err = xsc_create_msg_cache(xdev);
+	if (err) {
+		dev_err(&xdev->pdev->dev, "failed to create command cache\n");
+		goto err_unmap_cq;
+	}
+
+	xsc_set_wqname(xdev);
+	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
+	if (!cmd->wq) {
+		dev_err(&xdev->pdev->dev, "failed to create command workqueue\n");
+		err = -ENOMEM;
+		goto err_destroy_cache;
+	}
+
+	cmd->cq_task = kthread_create(xsc_cmd_cq_polling,
+				      (void *)xdev,
+				      "xsc_cmd_cq_polling");
+	if (!cmd->cq_task) {
+		dev_err(&xdev->pdev->dev, "failed to create cq task\n");
+		err = -ENOMEM;
+		goto err_destroy_wq;
+	}
+	wake_up_process(cmd->cq_task);
+
+	err = xsc_request_pid_cid_mismatch_restore(xdev);
+	if (err) {
+		dev_err(&xdev->pdev->dev, "request pid,cid wrong, restore failed\n");
+		goto err_stop_cq_task;
+	}
+
+	/* clear abnormal state to avoid the impact of previous error */
+	err_stat = readl(XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	if (err_stat) {
+		pci_err(xdev->pdev, "err_stat 0x%x when init, clear it\n",
+			err_stat);
+		writel(0xf,
+		       XSC_REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	}
+
+	return 0;
+
+err_stop_cq_task:
+	kthread_stop(cmd->cq_task);
+
+err_destroy_wq:
+	destroy_workqueue(cmd->wq);
+
+err_destroy_cache:
+	xsc_destroy_msg_cache(xdev);
+
+err_unmap_cq:
+	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+
+err_unmap_cmd:
+	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+err_free_cq:
+	free_pages((unsigned long)cmd->cq_buf, 0);
+
+err_free_cmd:
+	free_pages((unsigned long)cmd->cmd_buf, 0);
+
+err_free_pool:
+	dma_pool_destroy(cmd->pool);
+
+	return err;
+}
+
+void xsc_cmd_cleanup(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+
+	destroy_workqueue(cmd->wq);
+	if (cmd->cq_task)
+		kthread_stop(cmd->cq_task);
+	xsc_destroy_msg_cache(xdev);
+	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+	free_pages((unsigned long)cmd->cq_buf, 0);
+	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+	free_pages((unsigned long)cmd->cmd_buf, 0);
+	dma_pool_destroy(cmd->pool);
+}
+
+int xsc_cmd_version_check(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd_query_cmdq_ver_mbox_out *out;
+	struct xsc_cmd_query_cmdq_ver_mbox_in in;
+
+	int err;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return -ENOMEM;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_CMDQ_VERSION);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out));
+	if (err)
+		goto err_free;
+
+	if (out->hdr.status) {
+		err = xsc_cmd_status_to_err(&out->hdr);
+		goto err_free;
+	}
+
+	if (be16_to_cpu(out->cmdq_ver) != XSC_CMDQ_VERSION) {
+		pci_err(xdev->pdev, "cmdq version check failed, expecting %d, actual %d\n",
+			XSC_CMDQ_VERSION, be16_to_cpu(out->cmdq_ver));
+		err = -EINVAL;
+		goto err_free;
+	}
+	xdev->cmdq_ver = XSC_CMDQ_VERSION;
+
+err_free:
+	kfree(out);
+	return err;
+}
+
+static const char *cmd_status_str(u8 status)
+{
+	switch (status) {
+	case XSC_CMD_STAT_OK:
+		return "OK";
+	case XSC_CMD_STAT_INT_ERR:
+		return "internal error";
+	case XSC_CMD_STAT_BAD_OP_ERR:
+		return "bad operation";
+	case XSC_CMD_STAT_BAD_PARAM_ERR:
+		return "bad parameter";
+	case XSC_CMD_STAT_BAD_SYS_STATE_ERR:
+		return "bad system state";
+	case XSC_CMD_STAT_BAD_RES_ERR:
+		return "bad resource";
+	case XSC_CMD_STAT_RES_BUSY:
+		return "resource busy";
+	case XSC_CMD_STAT_LIM_ERR:
+		return "limits exceeded";
+	case XSC_CMD_STAT_BAD_RES_STATE_ERR:
+		return "bad resource state";
+	case XSC_CMD_STAT_IX_ERR:
+		return "bad index";
+	case XSC_CMD_STAT_NO_RES_ERR:
+		return "no resources";
+	case XSC_CMD_STAT_BAD_INP_LEN_ERR:
+		return "bad input length";
+	case XSC_CMD_STAT_BAD_OUTP_LEN_ERR:
+		return "bad output length";
+	case XSC_CMD_STAT_BAD_QP_STATE_ERR:
+		return "bad QP state";
+	case XSC_CMD_STAT_BAD_PKT_ERR:
+		return "bad packet (discarded)";
+	case XSC_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR:
+		return "bad size too many outstanding CQEs";
+	default:
+		return "unknown status";
+	}
+}
+
+int xsc_cmd_status_to_err(struct xsc_outbox_hdr *hdr)
+{
+	if (!hdr->status)
+		return 0;
+
+	pr_warn("command failed, status %s(0x%x)\n",
+		cmd_status_str(hdr->status), hdr->status);
+
+	switch (hdr->status) {
+	case XSC_CMD_STAT_OK:				return 0;
+	case XSC_CMD_STAT_INT_ERR:			return -EIO;
+	case XSC_CMD_STAT_BAD_OP_ERR:			return -EOPNOTSUPP;
+	case XSC_CMD_STAT_BAD_PARAM_ERR:		return -EINVAL;
+	case XSC_CMD_STAT_BAD_SYS_STATE_ERR:		return -EIO;
+	case XSC_CMD_STAT_BAD_RES_ERR:			return -EINVAL;
+	case XSC_CMD_STAT_RES_BUSY:			return -EBUSY;
+	case XSC_CMD_STAT_LIM_ERR:			return -EINVAL;
+	case XSC_CMD_STAT_BAD_RES_STATE_ERR:		return -EINVAL;
+	case XSC_CMD_STAT_IX_ERR:			return -EINVAL;
+	case XSC_CMD_STAT_NO_RES_ERR:			return -EAGAIN;
+	case XSC_CMD_STAT_BAD_INP_LEN_ERR:		return -EIO;
+	case XSC_CMD_STAT_BAD_OUTP_LEN_ERR:		return -EIO;
+	case XSC_CMD_STAT_BAD_QP_STATE_ERR:		return -EINVAL;
+	case XSC_CMD_STAT_BAD_PKT_ERR:			return -EINVAL;
+	case XSC_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR:	return -EINVAL;
+	default:					return -EIO;
+	}
+}
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index b8fc25679..3c717acbb 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -4,6 +4,7 @@
  */
 
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -136,6 +137,52 @@ static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
 	xsc_dev_res_cleanup(xdev);
 }
 
+static int xsc_hw_setup(struct xsc_core_device *xdev)
+{
+	int err;
+
+	err = xsc_cmd_init(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "Failed initializing command interface, aborting\n");
+		goto err_out;
+	}
+
+	err = xsc_cmd_version_check(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "Failed to check cmdq version\n");
+		goto err_cmd_cleanup;
+	}
+
+	return 0;
+err_cmd_cleanup:
+	xsc_cmd_cleanup(xdev);
+err_out:
+	return err;
+}
+
+static void xsc_hw_cleanup(struct xsc_core_device *xdev)
+{
+	xsc_cmd_cleanup(xdev);
+}
+
+static int xsc_load(struct xsc_core_device *xdev)
+{
+	int err = 0;
+
+	err = xsc_hw_setup(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_hw_setup failed %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void xsc_unload(struct xsc_core_device *xdev)
+{
+	xsc_hw_cleanup(xdev);
+}
+
 static int xsc_pci_probe(struct pci_dev *pci_dev,
 			 const struct pci_device_id *id)
 {
@@ -162,7 +209,15 @@ static int xsc_pci_probe(struct pci_dev *pci_dev,
 		goto err_pci_fini;
 	}
 
+	err = xsc_load(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_load failed %d\n", err);
+		goto err_core_dev_cleanup;
+	}
+
 	return 0;
+err_core_dev_cleanup:
+	xsc_core_dev_cleanup(xdev);
 err_pci_fini:
 	xsc_pci_fini(xdev);
 err_unset_pci_drvdata:
@@ -176,6 +231,7 @@ static void xsc_pci_remove(struct pci_dev *pci_dev)
 {
 	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
 
+	xsc_unload(xdev);
 	xsc_core_dev_cleanup(xdev);
 	xsc_pci_fini(xdev);
 	pci_set_drvdata(pci_dev, NULL);
-- 
2.43.0

