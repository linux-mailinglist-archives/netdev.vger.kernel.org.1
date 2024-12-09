Return-Path: <netdev+bounces-150059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5BB9E8BF2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC8F1642E9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16806214A7C;
	Mon,  9 Dec 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="cS44ML3J"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1817215042
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728423; cv=none; b=CuxQd/iK8OINpPOoQ3G33dGJdcOGheWJ2+rjuLoV9spegrbwzkPlSmf0NJJNmx+ZMNeIB9of2nGULgzzO1LoBHoADau4rE4+rPvcMgmuFNFDX+TaLr3CMMgVg1Y1ctcnARum0OXea0pQjMncTgbR4LYQizvHJn3lz1fbhGUXO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728423; c=relaxed/simple;
	bh=zcGd7yXKCUwNScQHTDTpbJnm6KcpCNm9F9uTmvmsb6A=;
	h=Content-Type:Date:Message-Id:Mime-Version:From:Subject:To:Cc; b=eBgi1pt15xQfZ308CIbViB/hlUjJARTUUuvwnqcomdQr4TZeqTtW/Atr+h+C06MV4T0C301DSsUz6ywmf+Qe1J2jh3bbuxJZDblc2Gw1tFfXQpLl0Mf0tm+81jywMnZi96Yz3fAx26WdMeFSdPZ5BKSBCMQVfh/bkHBeTv2zxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=cS44ML3J; arc=none smtp.client-ip=209.127.231.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728268; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=t3Qunzo8KfAjxqpzsYQEQhO1DrbtXtv0xf5aIGofwN0=;
 b=cS44ML3JrIOYpjdyKyJlUAS5yBhvfM78KM8fCjz0s8ZH88P/u1Ba/Pd2EPIzxbkMUSVrk7
 0QBY9WZ5q+SZGNK+Z0YxCrpLJce2lGA6zKquZ+adwY/TGfJWgYWoWgyb2axVOYTQS5PIcn
 pa43JWynclveRMaMXR/4U8D+UzOcMIoJo+QP2+Kirbexk/Tq4pEV3Zzmgo33HMJhbxlaJN
 AtFOzjtfK+UN+6oTpzlmVNrBK5+sU1cPfZ8xhxFGfr9GCf0NDhOhf/DvFLRsHshb8+i1S2
 MSCgx6kF6uj1gj+KHrLsq4gTEv4+9S5OHjn/Klv1dth0U7Yt417B8OIcJeMvfA==
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon,  9 Dec 2024 15:10:47 +0800
Message-Id: <20241209071101.3392590-3-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
From: "Tian Xin" <tianx@yunsilicon.com>
Subject: [PATCH 02/16] net-next/yunsilicon: Enable CMDQ
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:05 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26756980a+b1f034+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Enable cmd queue to support driver-firmware communication.
Hardware control will be performed through cmdq mostly.

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   97 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  | 2513 +++++++++++++++++
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  218 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   15 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |    2 +-
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 2164 ++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   96 +
 8 files changed, 5129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
new file mode 100644
index 000000000..4864cb747
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+/* generated time:
+ * Thu Feb 29 15:33:50 CST 2024
+ */
+
+#ifndef XSC_HW_H
+#define XSC_HW_H
+
+//hif_irq_csr_defines.h
+#define HIF_IRQ_TBL2IRQ_TBL_RD_DONE_INT_MSIX_REG_ADDR   0xa1100070
+
+//hif_cpm_csr_defines.h
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
+//mmc_csr_defines.h
+#define MMC_MPT_TBL_MEM_DEPTH  32768
+#define MMC_MTT_TBL_MEM_DEPTH  262144
+#define MMC_MPT_TBL_MEM_WIDTH  256
+#define MMC_MTT_TBL_MEM_WIDTH  64
+#define MMC_MPT_TBL_MEM_ADDR   0xa4100000
+#define MMC_MTT_TBL_MEM_ADDR   0xa4200000
+
+//clsf_dma_csr_defines.h
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
+//hif_tbl_csr_defines.h
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
+//hif_cmdqm_csr_defines.h
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
+//PSV use
+//hif_irq_csr_defines.h
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
+#endif /* XSC_HW_H  */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
new file mode 100644
index 000000000..1d5d0e6c8
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
@@ -0,0 +1,2513 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CMD_H
+#define XSC_CMD_H
+
+#define CMDQ_VERSION 0x32
+
+#define MAX_MBOX_OUT_LEN	2048
+
+#define QOS_PRIO_MAX		7
+#define	QOS_DSCP_MAX		63
+#define MAC_PORT_DSCP_SHIFT	6
+#define	QOS_PCP_MAX		7
+#define DSCP_PCP_UNSET		255
+#define MAC_PORT_PCP_SHIFT	3
+#define XSC_MAX_MAC_NUM		8
+#define XSC_BOARD_SN_LEN	32
+#define MAX_PKT_LEN		9800
+#define XSC_RTT_CFG_QPN_MAX 32
+
+#define XSC_PCIE_LAT_CFG_INTERVAL_MAX	8
+#define XSC_PCIE_LAT_CFG_HISTOGRAM_MAX	9
+#define XSC_PCIE_LAT_EN_DISABLE		0
+#define XSC_PCIE_LAT_EN_ENABLE		1
+#define XSC_PCIE_LAT_PERIOD_MIN		1
+#define XSC_PCIE_LAT_PERIOD_MAX		20
+#define DPU_PORT_WGHT_CFG_MAX		1
+
+enum {
+	XSC_CMD_STAT_OK			= 0x0,
+	XSC_CMD_STAT_INT_ERR			= 0x1,
+	XSC_CMD_STAT_BAD_OP_ERR		= 0x2,
+	XSC_CMD_STAT_BAD_PARAM_ERR		= 0x3,
+	XSC_CMD_STAT_BAD_SYS_STATE_ERR		= 0x4,
+	XSC_CMD_STAT_BAD_RES_ERR		= 0x5,
+	XSC_CMD_STAT_RES_BUSY			= 0x6,
+	XSC_CMD_STAT_LIM_ERR			= 0x8,
+	XSC_CMD_STAT_BAD_RES_STATE_ERR		= 0x9,
+	XSC_CMD_STAT_IX_ERR			= 0xa,
+	XSC_CMD_STAT_NO_RES_ERR		= 0xf,
+	XSC_CMD_STAT_BAD_INP_LEN_ERR		= 0x50,
+	XSC_CMD_STAT_BAD_OUTP_LEN_ERR		= 0x51,
+	XSC_CMD_STAT_BAD_QP_STATE_ERR		= 0x10,
+	XSC_CMD_STAT_BAD_PKT_ERR		= 0x30,
+	XSC_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR	= 0x40,
+};
+
+enum {
+	DPU_PORT_WGHT_TARGET_HOST,
+	DPU_PORT_WGHT_TARGET_SOC,
+	DPU_PORT_WGHT_TARGET_NUM,
+};
+
+enum {
+	DPU_PRIO_WGHT_TARGET_HOST2SOC,
+	DPU_PRIO_WGHT_TARGET_SOC2HOST,
+	DPU_PRIO_WGHT_TARGET_HOSTSOC2LAG,
+	DPU_PRIO_WGHT_TARGET_NUM,
+};
+
+#define XSC_AP_FEAT_UDP_SPORT_MIN	1024
+#define XSC_AP_FEAT_UDP_SPORT_MAX	65535
+
+enum {
+	XSC_CMD_OP_QUERY_HCA_CAP		= 0x100,
+	XSC_CMD_OP_QUERY_ADAPTER		= 0x101,
+	XSC_CMD_OP_INIT_HCA			= 0x102,
+	XSC_CMD_OP_TEARDOWN_HCA			= 0x103,
+	XSC_CMD_OP_ENABLE_HCA			= 0x104,
+	XSC_CMD_OP_DISABLE_HCA			= 0x105,
+	XSC_CMD_OP_MODIFY_HCA			= 0x106,
+	XSC_CMD_OP_QUERY_PAGES			= 0x107,
+	XSC_CMD_OP_MANAGE_PAGES			= 0x108,
+	XSC_CMD_OP_SET_HCA_CAP			= 0x109,
+	XSC_CMD_OP_QUERY_CMDQ_VERSION		= 0x10a,
+	XSC_CMD_OP_QUERY_MSIX_TBL_INFO		= 0x10b,
+	XSC_CMD_OP_FUNCTION_RESET		= 0x10c,
+	XSC_CMD_OP_DUMMY			= 0x10d,
+	XSC_CMD_OP_SET_DEBUG_INFO		= 0x10e,
+	XSC_CMD_OP_QUERY_PSV_FUNCID		= 0x10f,
+	XSC_CMD_OP_ALLOC_IA_LOCK		= 0x110,
+	XSC_CMD_OP_RELEASE_IA_LOCK		= 0x111,
+	XSC_CMD_OP_ENABLE_RELAXED_ORDER		= 0x112,
+	XSC_CMD_OP_QUERY_GUID			= 0x113,
+	XSC_CMD_OP_ACTIVATE_HW_CONFIG		= 0x114,
+
+	XSC_CMD_OP_CREATE_MKEY			= 0x200,
+	XSC_CMD_OP_QUERY_MKEY			= 0x201,
+	XSC_CMD_OP_DESTROY_MKEY			= 0x202,
+	XSC_CMD_OP_QUERY_SPECIAL_CONTEXTS	= 0x203,
+	XSC_CMD_OP_REG_MR			= 0x204,
+	XSC_CMD_OP_DEREG_MR			= 0x205,
+	XSC_CMD_OP_SET_MPT			= 0x206,
+	XSC_CMD_OP_SET_MTT			= 0x207,
+
+	XSC_CMD_OP_CREATE_EQ			= 0x301,
+	XSC_CMD_OP_DESTROY_EQ			= 0x302,
+	XSC_CMD_OP_QUERY_EQ			= 0x303,
+
+	XSC_CMD_OP_CREATE_CQ			= 0x400,
+	XSC_CMD_OP_DESTROY_CQ			= 0x401,
+	XSC_CMD_OP_QUERY_CQ			= 0x402,
+	XSC_CMD_OP_MODIFY_CQ			= 0x403,
+	XSC_CMD_OP_ALLOC_MULTI_VIRTQ_CQ    = 0x404,
+	XSC_CMD_OP_RELEASE_MULTI_VIRTQ_CQ  = 0x405,
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
+	XSC_CMD_OP_QUERY_QP			= 0x50b,
+	XSC_CMD_OP_CONF_SQP			= 0x50c,
+	XSC_CMD_OP_MAD_IFC			= 0x50d,
+	XSC_CMD_OP_INIT2INIT_QP			= 0x50e,
+	XSC_CMD_OP_SUSPEND_QP			= 0x50f,
+	XSC_CMD_OP_UNSUSPEND_QP			= 0x510,
+	XSC_CMD_OP_SQD2SQD_QP			= 0x511,
+	XSC_CMD_OP_ALLOC_QP_COUNTER_SET		= 0x512,
+	XSC_CMD_OP_DEALLOC_QP_COUNTER_SET	= 0x513,
+	XSC_CMD_OP_QUERY_QP_COUNTER_SET		= 0x514,
+	XSC_CMD_OP_CREATE_MULTI_QP		= 0x515,
+	XSC_CMD_OP_ALLOC_MULTI_VIRTQ    = 0x516,
+	XSC_CMD_OP_RELEASE_MULTI_VIRTQ  = 0x517,
+	XSC_CMD_OP_QUERY_QP_FLUSH_STATUS	= 0x518,
+
+	XSC_CMD_OP_CREATE_PSV			= 0x600,
+	XSC_CMD_OP_DESTROY_PSV			= 0x601,
+	XSC_CMD_OP_QUERY_PSV			= 0x602,
+	XSC_CMD_OP_QUERY_SIG_RULE_TABLE		= 0x603,
+	XSC_CMD_OP_QUERY_BLOCK_SIZE_TABLE	= 0x604,
+
+	XSC_CMD_OP_CREATE_SRQ			= 0x700,
+	XSC_CMD_OP_DESTROY_SRQ			= 0x701,
+	XSC_CMD_OP_QUERY_SRQ			= 0x702,
+	XSC_CMD_OP_ARM_RQ			= 0x703,
+	XSC_CMD_OP_RESIZE_SRQ			= 0x704,
+
+	XSC_CMD_OP_ALLOC_PD			= 0x800,
+	XSC_CMD_OP_DEALLOC_PD			= 0x801,
+	XSC_CMD_OP_ALLOC_UAR			= 0x802,
+	XSC_CMD_OP_DEALLOC_UAR			= 0x803,
+
+	XSC_CMD_OP_ATTACH_TO_MCG		= 0x806,
+	XSC_CMD_OP_DETACH_FROM_MCG		= 0x807,
+
+	XSC_CMD_OP_ALLOC_XRCD			= 0x80e,
+	XSC_CMD_OP_DEALLOC_XRCD			= 0x80f,
+
+	XSC_CMD_OP_ACCESS_REG			= 0x805,
+
+	XSC_CMD_OP_MODIFY_RAW_QP		= 0x81f,
+
+	XSC_CMD_OP_ENABLE_NIC_HCA		= 0x810,
+	XSC_CMD_OP_DISABLE_NIC_HCA		= 0x811,
+	XSC_CMD_OP_MODIFY_NIC_HCA		= 0x812,
+
+	XSC_CMD_OP_QUERY_NIC_VPORT_CONTEXT	= 0x820,
+	XSC_CMD_OP_MODIFY_NIC_VPORT_CONTEXT	= 0x821,
+	XSC_CMD_OP_QUERY_VPORT_STATE		= 0x822,
+	XSC_CMD_OP_MODIFY_VPORT_STATE		= 0x823,
+	XSC_CMD_OP_QUERY_HCA_VPORT_CONTEXT	= 0x824,
+	XSC_CMD_OP_MODIFY_HCA_VPORT_CONTEXT	= 0x825,
+	XSC_CMD_OP_QUERY_HCA_VPORT_GID		= 0x826,
+	XSC_CMD_OP_QUERY_HCA_VPORT_PKEY		= 0x827,
+	XSC_CMD_OP_QUERY_VPORT_COUNTER		= 0x828,
+	XSC_CMD_OP_QUERY_PRIO_STATS		= 0x829,
+	XSC_CMD_OP_QUERY_PHYPORT_STATE		= 0x830,
+	XSC_CMD_OP_QUERY_EVENT_TYPE		= 0x831,
+	XSC_CMD_OP_QUERY_LINK_INFO		= 0x832,
+	XSC_CMD_OP_QUERY_PFC_PRIO_STATS		= 0x833,
+	XSC_CMD_OP_MODIFY_LINK_INFO		= 0x834,
+	XSC_CMD_OP_QUERY_FEC_PARAM		= 0x835,
+	XSC_CMD_OP_MODIFY_FEC_PARAM		= 0x836,
+
+	XSC_CMD_OP_LAG_CREATE				= 0x840,
+	XSC_CMD_OP_LAG_ADD_MEMBER			= 0x841,
+	XSC_CMD_OP_LAG_REMOVE_MEMBER		= 0x842,
+	XSC_CMD_OP_LAG_UPDATE_MEMBER_STATUS	= 0x843,
+	XSC_CMD_OP_LAG_UPDATE_HASH_TYPE		= 0x844,
+	XSC_CMD_OP_LAG_DESTROY				= 0x845,
+
+	XSC_CMD_OP_LAG_SET_QOS			= 0x848,
+	XSC_CMD_OP_ENABLE_MSIX			= 0x850,
+
+	XSC_CMD_OP_IOCTL_FLOW			= 0x900,
+	XSC_CMD_OP_IOCTL_OTHER			= 0x901,
+
+	XSC_CMD_OP_IOCTL_SET_DSCP_PMT		= 0x1000,
+	XSC_CMD_OP_IOCTL_GET_DSCP_PMT		= 0x1001,
+	XSC_CMD_OP_IOCTL_SET_TRUST_MODE		= 0x1002,
+	XSC_CMD_OP_IOCTL_GET_TRUST_MODE		= 0x1003,
+	XSC_CMD_OP_IOCTL_SET_PCP_PMT		= 0x1004,
+	XSC_CMD_OP_IOCTL_GET_PCP_PMT		= 0x1005,
+	XSC_CMD_OP_IOCTL_SET_DEFAULT_PRI	= 0x1006,
+	XSC_CMD_OP_IOCTL_GET_DEFAULT_PRI	= 0x1007,
+	XSC_CMD_OP_IOCTL_SET_PFC		= 0x1008,
+	XSC_CMD_OP_IOCTL_GET_PFC		= 0x1009,
+	XSC_CMD_OP_IOCTL_SET_RATE_LIMIT		= 0x100a,
+	XSC_CMD_OP_IOCTL_GET_RATE_LIMIT		= 0x100b,
+	XSC_CMD_OP_IOCTL_SET_SP			= 0x100c,
+	XSC_CMD_OP_IOCTL_GET_SP			= 0x100d,
+	XSC_CMD_OP_IOCTL_SET_WEIGHT		= 0x100e,
+	XSC_CMD_OP_IOCTL_GET_WEIGHT		= 0x100f,
+	XSC_CMD_OP_IOCTL_DPU_SET_PORT_WEIGHT	= 0x1010,
+	XSC_CMD_OP_IOCTL_DPU_GET_PORT_WEIGHT	= 0x1011,
+	XSC_CMD_OP_IOCTL_DPU_SET_PRIO_WEIGHT	= 0x1012,
+	XSC_CMD_OP_IOCTL_DPU_GET_PRIO_WEIGHT	= 0x1013,
+	XSC_CMD_OP_IOCTL_SET_WATCHDOG_EN	= 0x1014,
+	XSC_CMD_OP_IOCTL_GET_WATCHDOG_EN	= 0x1015,
+	XSC_CMD_OP_IOCTL_SET_WATCHDOG_PERIOD	= 0x1016,
+	XSC_CMD_OP_IOCTL_GET_WATCHDOG_PERIOD	= 0x1017,
+	XSC_CMD_OP_IOCTL_SET_PFC_DROP_TH	= 0x1018,
+	XSC_CMD_OP_IOCTL_GET_PFC_CFG_STATUS	= 0x1019,
+
+	XSC_CMD_OP_IOCTL_SET_ENABLE_RP = 0x1030,
+	XSC_CMD_OP_IOCTL_SET_ENABLE_NP = 0x1031,
+	XSC_CMD_OP_IOCTL_SET_INIT_ALPHA = 0x1032,
+	XSC_CMD_OP_IOCTL_SET_G = 0x1033,
+	XSC_CMD_OP_IOCTL_SET_AI = 0x1034,
+	XSC_CMD_OP_IOCTL_SET_HAI = 0x1035,
+	XSC_CMD_OP_IOCTL_SET_TH = 0x1036,
+	XSC_CMD_OP_IOCTL_SET_BC_TH = 0x1037,
+	XSC_CMD_OP_IOCTL_SET_CNP_OPCODE = 0x1038,
+	XSC_CMD_OP_IOCTL_SET_CNP_BTH_B = 0x1039,
+	XSC_CMD_OP_IOCTL_SET_CNP_BTH_F = 0x103a,
+	XSC_CMD_OP_IOCTL_SET_CNP_ECN = 0x103b,
+	XSC_CMD_OP_IOCTL_SET_DATA_ECN = 0x103c,
+	XSC_CMD_OP_IOCTL_SET_CNP_TX_INTERVAL = 0x103d,
+	XSC_CMD_OP_IOCTL_SET_EVT_PERIOD_RSTTIME = 0x103e,
+	XSC_CMD_OP_IOCTL_SET_CNP_DSCP = 0x103f,
+	XSC_CMD_OP_IOCTL_SET_CNP_PCP = 0x1040,
+	XSC_CMD_OP_IOCTL_SET_EVT_PERIOD_ALPHA = 0x1041,
+	XSC_CMD_OP_IOCTL_GET_CC_CFG = 0x1042,
+	XSC_CMD_OP_IOCTL_GET_CC_STAT = 0x104b,
+	XSC_CMD_OP_IOCTL_SET_CLAMP_TGT_RATE = 0x1052,
+	XSC_CMD_OP_IOCTL_SET_MAX_HAI_FACTOR = 0x1053,
+	XSC_CMD_OP_IOCTL_SET_SCALE = 0x1054,
+
+	XSC_CMD_OP_IOCTL_SET_HWC = 0x1060,
+	XSC_CMD_OP_IOCTL_GET_HWC = 0x1061,
+
+	XSC_CMD_OP_SET_MTU = 0x1100,
+	XSC_CMD_OP_QUERY_ETH_MAC = 0X1101,
+
+	XSC_CMD_OP_QUERY_HW_STATS = 0X1200,
+	XSC_CMD_OP_QUERY_PAUSE_CNT = 0X1201,
+	XSC_CMD_OP_IOCTL_QUERY_PFC_STALL_STATS = 0x1202,
+	XSC_CMD_OP_QUERY_HW_STATS_RDMA = 0X1203,
+	XSC_CMD_OP_QUERY_HW_STATS_ETH = 0X1204,
+	XSC_CMD_OP_QUERY_HW_GLOBAL_STATS = 0X1210,
+
+	XSC_CMD_OP_SET_RTT_EN = 0X1220,
+	XSC_CMD_OP_GET_RTT_EN = 0X1221,
+	XSC_CMD_OP_SET_RTT_QPN = 0X1222,
+	XSC_CMD_OP_GET_RTT_QPN = 0X1223,
+	XSC_CMD_OP_SET_RTT_PERIOD = 0X1224,
+	XSC_CMD_OP_GET_RTT_PERIOD = 0X1225,
+	XSC_CMD_OP_GET_RTT_RESULT = 0X1226,
+	XSC_CMD_OP_GET_RTT_STATS = 0X1227,
+
+	XSC_CMD_OP_SET_LED_STATUS = 0X1228,
+
+	XSC_CMD_OP_AP_FEAT			= 0x1400,
+	XSC_CMD_OP_PCIE_LAT_FEAT		= 0x1401,
+
+	XSC_CMD_OP_GET_LLDP_STATUS = 0x1500,
+	XSC_CMD_OP_SET_LLDP_STATUS = 0x1501,
+
+	XSC_CMD_OP_SET_VPORT_RATE_LIMIT = 0x1600,
+
+	XSC_CMD_OP_SET_PORT_ADMIN_STATUS = 0x1801,
+	XSC_CMD_OP_USER_EMU_CMD = 0x8000,
+
+	XSC_CMD_OP_MAX
+};
+
+enum {
+	XSC_CMD_EVENT_RESP_CHANGE_LINK	= 0x0001,
+	XSC_CMD_EVENT_RESP_TEMP_WARN	= 0x0002,
+	XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION	= 0x0004,
+};
+
+enum xsc_eth_qp_num_sel {
+	XSC_ETH_QP_NUM_8K_SEL = 0,
+	XSC_ETH_QP_NUM_8K_8TC_SEL,
+	XSC_ETH_QP_NUM_SEL_MAX,
+};
+
+enum xsc_eth_vf_num_sel {
+	XSC_ETH_VF_NUM_SEL_8 = 0,
+	XSC_ETH_VF_NUM_SEL_16,
+	XSC_ETH_VF_NUM_SEL_32,
+	XSC_ETH_VF_NUM_SEL_64,
+	XSC_ETH_VF_NUM_SEL_128,
+	XSC_ETH_VF_NUM_SEL_256,
+	XSC_ETH_VF_NUM_SEL_512,
+	XSC_ETH_VF_NUM_SEL_1024,
+	XSC_ETH_VF_NUM_SEL_MAX
+};
+
+enum {
+	LINKSPEED_MODE_UNKNOWN = -1,
+	LINKSPEED_MODE_10G = 10000,
+	LINKSPEED_MODE_25G = 25000,
+	LINKSPEED_MODE_40G = 40000,
+	LINKSPEED_MODE_50G = 50000,
+	LINKSPEED_MODE_100G = 100000,
+	LINKSPEED_MODE_200G = 200000,
+	LINKSPEED_MODE_400G = 400000,
+};
+
+enum {
+	MODULE_SPEED_UNKNOWN,
+	MODULE_SPEED_10G,
+	MODULE_SPEED_25G,
+	MODULE_SPEED_40G_R4,
+	MODULE_SPEED_50G_R,
+	MODULE_SPEED_50G_R2,
+	MODULE_SPEED_100G_R2,
+	MODULE_SPEED_100G_R4,
+	MODULE_SPEED_200G_R4,
+	MODULE_SPEED_200G_R8,
+	MODULE_SPEED_400G_R8,
+};
+
+enum xsc_dma_direct {
+	DMA_DIR_TO_MAC,
+	DMA_DIR_READ,
+	DMA_DIR_WRITE,
+	DMA_DIR_LOOPBACK,
+	DMA_DIR_MAX,
+};
+
+/* hw feature bitmap, 32bit */
+enum xsc_hw_feature_flag {
+	XSC_HW_RDMA_SUPPORT = 0x1,
+	XSC_HW_PFC_PRIO_STATISTIC_SUPPORT = 0x2,
+	XSC_HW_THIRD_FEATURE = 0x4,
+	XSC_HW_PFC_STALL_STATS_SUPPORT = 0x8,
+	XSC_HW_RDMA_CM_SUPPORT = 0x20,
+
+	XSC_HW_LAST_FEATURE = 0x80000000,
+};
+
+enum xsc_lldp_dcbx_sub_cmd {
+	XSC_OS_HANDLE_LLDP_STATUS = 0x1,
+	XSC_DCBX_STATUS
+};
+
+struct xsc_inbox_hdr {
+	__be16		opcode;
+	u8		rsvd[4];
+	__be16		ver;
+};
+
+struct xsc_outbox_hdr {
+	u8		status;
+	u8		rsvd[5];
+	__be16		ver;
+};
+
+struct xsc_alloc_ia_lock_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			lock_num;
+	u8			rsvd[7];
+};
+
+#define XSC_RES_NUM_IAE_GRP 16
+
+struct xsc_alloc_ia_lock_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			lock_idx[XSC_RES_NUM_IAE_GRP];
+};
+
+struct xsc_release_ia_lock_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			lock_idx[XSC_RES_NUM_IAE_GRP];
+};
+
+struct xsc_release_ia_lock_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_pci_driver_init_params_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			s_wqe_mode;
+	__be32			r_wqe_mode;
+	__be32			local_timeout_retrans;
+	u8				mac_lossless_prio[XSC_MAX_MAC_NUM];
+	__be32			group_mod;
+};
+
+struct xsc_pci_driver_init_params_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+/*CQ mbox*/
+struct xsc_cq_context {
+	__be16		eqn;
+	__be16		pa_num;
+	__be16		glb_func_id;
+	u8		log_cq_sz;
+	u8		cq_type;
+};
+
+struct xsc_create_cq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_cq_context	ctx;
+	__be64			pas[];
+};
+
+struct xsc_create_cq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			cqn;
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
+	u8		dma_direct;//0 for dma read, 1 for dma write
+	__be32		pdn;
+	__be16		cqn_send;
+	__be16		cqn_recv;
+	__be16		glb_funcid;
+	/*rsvd,rename logic_port used to transfer logical_port to fw*/
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
+	__be32			qpn;
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
+struct xsc_query_qp_flush_status_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			qpn;
+};
+
+struct xsc_query_qp_flush_status_mbox_out {
+	struct xsc_outbox_hdr	hdr;
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
+struct xsc_query_qp_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			qpn;
+	u8			rsvd[4];
+};
+
+struct xsc_query_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_qp_context	ctx;
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
+struct xsc_alloc_multi_virtq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			qp_or_cq_num;
+	__be16			pa_num;
+	__be32			rsvd;
+	__be32			rsvd2;
+};
+
+struct xsc_alloc_multi_virtq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			qnum_base;
+	__be32			pa_list_base;
+	__be32			rsvd;
+};
+
+struct xsc_release_multi_virtq_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			qp_or_cq_num;
+	__be16			pa_num;
+	__be32			qnum_base;
+	__be32			pa_list_base;
+};
+
+struct xsc_release_multi_virtq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			rsvd;
+	__be32			rsvd2;
+	__be32			rsvd3;
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
+
+};
+
+struct xsc_destroy_eq_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+/*PD mbox*/
+struct xsc_alloc_pd_request {
+	u8	rsvd[8];
+};
+
+struct xsc_alloc_pd_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_alloc_pd_request	req;
+};
+
+struct xsc_alloc_pd_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			pdn;
+	u8			rsvd[4];
+};
+
+struct xsc_dealloc_pd_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			pdn;
+	u8			rsvd[4];
+
+};
+
+struct xsc_dealloc_pd_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+/*MR mbox*/
+struct xsc_register_mr_request {
+	__be32		pdn;
+	__be32		pa_num;
+	__be32		len;
+	__be32		mkey;
+	u8		rsvd;
+	u8		acc;
+	u8		page_mode;
+	u8		map_en;
+	__be64		va_base;
+	__be64		pas[];
+};
+
+struct xsc_register_mr_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_register_mr_request	req;
+};
+
+struct xsc_register_mr_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			mkey;
+	u8			rsvd[4];
+};
+
+struct xsc_unregister_mr_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32			mkey;
+	u8			rsvd[4];
+};
+
+struct xsc_unregister_mr_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_mpt_item {
+	__be32		pdn;
+	__be32		pa_num;
+	__be32		len;
+	__be32		mkey;
+	u8		rsvd[5];
+	u8		acc;
+	u8		page_mode;
+	u8		map_en;
+	__be64		va_base;
+};
+
+struct xsc_set_mpt_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_mpt_item	mpt_item;
+};
+
+struct xsc_set_mpt_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			mtt_base;
+	u8			rsvd[4];
+};
+
+struct xsc_mtt_setting {
+	__be32		mtt_base;
+	__be32		pa_num;
+	__be64		pas[];
+};
+
+struct xsc_set_mtt_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_mtt_setting	mtt_setting;
+};
+
+struct xsc_set_mtt_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_create_mkey_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8	rsvd[4];
+};
+
+struct xsc_create_mkey_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32	mkey;
+};
+
+struct xsc_destroy_mkey_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32	mkey;
+};
+
+struct xsc_destroy_mkey_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd;
+};
+
+struct xsc_access_reg_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd0[2];
+	__be16			register_id;
+	__be32			arg;
+	__be32			data[];
+};
+
+struct xsc_access_reg_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+	__be32			data[];
+};
+
+struct xsc_mad_ifc_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			remote_lid;
+	u8			rsvd0;
+	u8			port;
+	u8			rsvd1[4];
+	u8			data[256];
+};
+
+struct xsc_mad_ifc_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+	u8			data[256];
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
+	__be16		cmdq_ver;
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
+	__be16	fw_version_patch;
+	__be32	fw_version_tweak;
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
+	__be32		hw_feature_flag;/*enum xsc_hw_feature_flag*/
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
+	__be32		max_rwq_indirection_tables;/*rss_caps*/
+	__be32		max_rwq_indirection_table_size;/*rss_caps*/
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
+	struct xsc_fw_version  fw_ver;
+	u8	lag_logic_port_ofst;
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
+struct xsc_cmd_enable_hca_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16	vf_num;
+	__be16  max_msix_vec;
+	__be16	cpu_num;
+	u8	pp_bypass;
+	u8	esw_mode;
+};
+
+struct xsc_cmd_enable_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd0[4];
+};
+
+struct xsc_cmd_disable_hca_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16	vf_num;
+	u8	pp_bypass;
+	u8	esw_mode;
+};
+
+struct xsc_cmd_disable_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd0[4];
+};
+
+struct xsc_cmd_modify_hca_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8	pp_bypass;
+	u8	esw_mode;
+	u8	rsvd0[6];
+};
+
+struct xsc_cmd_modify_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd0[4];
+};
+
+struct xsc_query_special_ctxs_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_query_special_ctxs_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32			dump_fill_mkey;
+	__be32			reserved_lkey;
+};
+
+/* vport mbox */
+struct xsc_nic_vport_context {
+	__be32		min_wqe_inline_mode:3;
+	__be32		disable_mc_local_lb:1;
+	__be32		disable_uc_local_lb:1;
+	__be32		roce_en:1;
+
+	__be32		arm_change_event:1;
+	__be32		event_on_mtu:1;
+	__be32		event_on_promisc_change:1;
+	__be32		event_on_vlan_change:1;
+	__be32		event_on_mc_address_change:1;
+	__be32		event_on_uc_address_change:1;
+	__be32		affiliation_criteria:4;
+	__be32		affiliated_vhca_id;
+
+	__be16		mtu;
+
+	__be64		system_image_guid;
+	__be64		port_guid;
+	__be64		node_guid;
+
+	__be32		qkey_violation_counter;
+
+	__be16		spoofchk:1;
+	__be16		trust:1;
+	__be16		promisc:1;
+	__be16		allmcast:1;
+	__be16		vlan_allowed:1;
+	__be16		allowed_list_type:3;
+	__be16		allowed_list_size:10;
+
+	__be16		vlan_proto;
+	__be16		vlan;
+	u8		qos;
+	u8		permanent_address[6];
+	u8		current_address[6];
+	u8		current_uc_mac_address[0][2];
+};
+
+enum {
+	XSC_HCA_VPORT_SEL_PORT_GUID	= 1 << 0,
+	XSC_HCA_VPORT_SEL_NODE_GUID	= 1 << 1,
+	XSC_HCA_VPORT_SEL_STATE_POLICY	= 1 << 2,
+};
+
+struct xsc_hca_vport_context {
+	u32		field_select;
+	u32		port_physical_state:4;
+	u32		vport_state_policy:4;
+	u32		port_state:4;
+	u32		vport_state:4;
+	u32		rcvd0:16;
+
+	u64		system_image_guid;
+	u64		port_guid;
+	u64		node_guid;
+
+	u16		qkey_violation_counter;
+	u16		pkey_violation_counter;
+};
+
+struct xsc_query_nic_vport_context_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_nic_vport_context nic_vport_ctx;
+};
+
+struct xsc_query_nic_vport_context_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			vport_number:16;
+	u32			allowed_list_type:3;
+	u32			rsvd:12;
+};
+
+struct xsc_modify_nic_vport_context_out {
+	struct xsc_outbox_hdr	hdr;
+	__be16			outer_vlan_id;
+	u8			rsvd[2];
+};
+
+struct xsc_modify_nic_vport_field_select {
+	__be32		affiliation:1;
+	__be32		disable_uc_local_lb:1;
+	__be32		disable_mc_local_lb:1;
+	__be32		node_guid:1;
+	__be32		port_guid:1;
+	__be32		min_inline:1;
+	__be32		mtu:1;
+	__be32		change_event:1;
+	__be32		promisc:1;
+	__be32		allmcast:1;
+	__be32		permanent_address:1;
+	__be32		current_address:1;
+	__be32		addresses_list:1;
+	__be32		roce_en:1;
+	__be32		spoofchk:1;
+	__be32		trust:1;
+	__be32		rsvd:16;
+};
+
+struct xsc_modify_nic_vport_context_in {
+	struct xsc_inbox_hdr	hdr;
+	__be32		other_vport:1;
+	__be32		vport_number:16;
+	__be32		rsvd:15;
+	__be16		caps;
+	__be16		caps_mask;
+	__be16		lag_id;
+
+	struct xsc_modify_nic_vport_field_select field_select;
+	struct xsc_nic_vport_context nic_vport_ctx;
+};
+
+struct xsc_query_hca_vport_context_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_hca_vport_context hca_vport_ctx;
+};
+
+struct xsc_query_hca_vport_context_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			port_num:4;
+	u32			vport_number:16;
+	u32			rsvd0:11;
+};
+
+struct xsc_modify_hca_vport_context_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[2];
+};
+
+struct xsc_modify_hca_vport_context_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			port_num:4;
+	u32			vport_number:16;
+	u32			rsvd0:11;
+
+	struct xsc_hca_vport_context hca_vport_ctx;
+};
+
+struct xsc_array128 {
+	u8			array128[16];
+};
+
+struct xsc_query_hca_vport_gid_out {
+	struct xsc_outbox_hdr	hdr;
+	u16			gids_num;
+	struct xsc_array128	gid[];
+};
+
+struct xsc_query_hca_vport_gid_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			port_num:4;
+	u32			vport_number:16;
+	u32			rsvd0:11;
+	u16			gid_index;
+};
+
+struct xsc_pkey {
+	u16			pkey;
+};
+
+struct xsc_query_hca_vport_pkey_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_pkey		pkey[];
+};
+
+struct xsc_query_hca_vport_pkey_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			port_num:4;
+	u32			vport_number:16;
+	u32			rsvd0:11;
+	u16			pkey_index;
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
+	u32			other_vport:1;
+	u32			vport_number:16;
+	u32			rsvd0:15;
+};
+
+struct xsc_modify_vport_state_out {
+	struct xsc_outbox_hdr	hdr;
+};
+
+struct xsc_modify_vport_state_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			vport_number:16;
+	u32			rsvd0:15;
+	u8			admin_state:4;
+	u8			rsvd1:4;
+};
+
+struct xsc_traffic_counter {
+	u64         packets;
+	u64         bytes;
+};
+
+struct xsc_query_vport_counter_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_traffic_counter received_errors;
+	struct xsc_traffic_counter transmit_errors;
+	struct xsc_traffic_counter received_ib_unicast;
+	struct xsc_traffic_counter transmitted_ib_unicast;
+	struct xsc_traffic_counter received_ib_multicast;
+	struct xsc_traffic_counter transmitted_ib_multicast;
+	struct xsc_traffic_counter received_eth_broadcast;
+	struct xsc_traffic_counter transmitted_eth_broadcast;
+	struct xsc_traffic_counter received_eth_unicast;
+	struct xsc_traffic_counter transmitted_eth_unicast;
+	struct xsc_traffic_counter received_eth_multicast;
+	struct xsc_traffic_counter transmitted_eth_multicast;
+};
+
+struct xsc_query_vport_counter_in {
+	struct xsc_inbox_hdr	hdr;
+	u32			other_vport:1;
+	u32			port_num:4;
+	u32			vport_number:16;
+	u32			rsvd0:11;
+};
+
+/* ioctl mbox */
+struct xsc_ioctl_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16			len;
+	__be16			rsvd;
+	u8			data[];
+};
+
+struct xsc_ioctl_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	__be32    error;
+	__be16	len;
+	__be16	rsvd;
+	u8	data[];
+};
+
+struct xsc_modify_raw_qp_request {
+	u16		qpn;
+	u16		lag_id;
+	u16		func_id;
+	u8		dma_direct;
+	u8		prio;
+	u8		qp_out_port;
+	u8		rsvd[7];
+};
+
+struct xsc_modify_raw_qp_mbox_in {
+	struct xsc_inbox_hdr				hdr;
+	u8		pcie_no;
+	u8		rsv[7];
+	struct xsc_modify_raw_qp_request	req;
+};
+
+struct xsc_modify_raw_qp_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8						rsvd[8];
+};
+
+#define ETH_ALEN	6
+
+struct xsc_create_lag_request {
+	__be16	lag_id;
+	u8	lag_type;
+	u8	lag_sel_mode;
+	u8	mac_idx;
+	u8	netdev_addr[ETH_ALEN];
+	u8	bond_mode;
+	u8  slave_status;
+};
+
+struct xsc_add_lag_member_request {
+	__be16	lag_id;
+	u8	lag_type;
+	u8	lag_sel_mode;
+	u8	mac_idx;
+	u8	netdev_addr[ETH_ALEN];
+	u8	bond_mode;
+	u8  slave_status;
+	u8	mad_mac_idx;
+};
+
+struct xsc_remove_lag_member_request {
+	__be16	lag_id;
+	u8	lag_type;
+	u8	mac_idx;
+	u8	mad_mac_idx;
+	u8	bond_mode;
+	u8 is_roce_lag_xdev;
+	u8	not_roce_lag_xdev_mask;
+};
+
+struct xsc_update_lag_member_status_request {
+	__be16	lag_id;
+	u8	lag_type;
+	u8	mac_idx;
+	u8	bond_mode;
+	u8  slave_status;
+	u8	rsvd;
+};
+
+struct xsc_update_lag_hash_type_request {
+	__be16	lag_id;
+	u8 lag_sel_mode;
+	u8	rsvd[5];
+};
+
+struct xsc_destroy_lag_request {
+	__be16	lag_id;
+	u8	lag_type;
+	u8 mac_idx;
+	u8 bond_mode;
+	u8 slave_status;
+	u8	rsvd[3];
+};
+
+struct xsc_set_lag_qos_request {
+	__be16		lag_id;
+	u8		member_idx;
+	u8		lag_op;
+	u8		resv[4];
+};
+
+struct xsc_create_lag_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_create_lag_request	req;
+};
+
+struct xsc_create_lag_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_add_lag_member_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_add_lag_member_request	req;
+};
+
+struct xsc_add_lag_member_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_remove_lag_member_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_remove_lag_member_request	req;
+};
+
+struct xsc_remove_lag_member_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_update_lag_member_status_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_update_lag_member_status_request	req;
+};
+
+struct xsc_update_lag_member_status_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_update_lag_hash_type_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_update_lag_hash_type_request	req;
+};
+
+struct xsc_update_lag_hash_type_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_destroy_lag_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_destroy_lag_request	req;
+};
+
+struct xsc_destroy_lag_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+struct xsc_set_lag_qos_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_set_lag_qos_request	req;
+};
+
+struct xsc_set_lag_qos_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+/*ioctl qos*/
+struct xsc_qos_req_prfx {
+	u8 mac_port;
+	u8 rsvd[7];
+};
+
+struct xsc_qos_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_qos_req_prfx		req_prfx;
+	u8				data[];
+};
+
+struct xsc_qos_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			data[];
+};
+
+struct xsc_prio_stats {
+	u64 tx_bytes;
+	u64 rx_bytes;
+	u64 tx_pkts;
+	u64 rx_pkts;
+};
+
+struct xsc_prio_stats_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 pport;
+};
+
+struct xsc_prio_stats_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_prio_stats	prio_stats[QOS_PRIO_MAX + 1];
+};
+
+struct xsc_pfc_prio_stats {
+	u64 tx_pause;
+	u64 tx_pause_duration;
+	u64 rx_pause;
+	u64 rx_pause_duration;
+};
+
+struct xsc_pfc_prio_stats_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			pport;
+};
+
+struct xsc_pfc_prio_stats_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	struct xsc_pfc_prio_stats	prio_stats[QOS_PRIO_MAX + 1];
+};
+
+struct xsc_hw_stats_rdma_pf {
+	/*by mac port*/
+	u64 rdma_tx_pkts;
+	u64 rdma_tx_bytes;
+	u64 rdma_rx_pkts;
+	u64 rdma_rx_bytes;
+	u64 np_cnp_sent;
+	u64 rp_cnp_handled;
+	u64 np_ecn_marked_roce_packets;
+	u64 rp_cnp_ignored;
+	u64 read_rsp_out_of_seq;
+	u64 implied_nak_seq_err;
+	/*by function*/
+	u64 out_of_sequence;
+	u64 packet_seq_err;
+	u64 out_of_buffer;
+	u64 rnr_nak_retry_err;
+	u64 local_ack_timeout_err;
+	u64 rx_read_requests;
+	u64 rx_write_requests;
+	u64 duplicate_requests;
+	u64 rdma_tx_pkts_func;
+	u64 rdma_tx_payload_bytes;
+	u64 rdma_rx_pkts_func;
+	u64 rdma_rx_payload_bytes;
+	/*global*/
+	u64 rdma_loopback_pkts;
+	u64 rdma_loopback_bytes;
+};
+
+struct xsc_hw_stats_rdma_vf {
+	/*by function*/
+	u64 rdma_tx_pkts_func;
+	u64 rdma_tx_payload_bytes;
+	u64 rdma_rx_pkts_func;
+	u64 rdma_rx_payload_bytes;
+
+	u64 out_of_sequence;
+	u64 packet_seq_err;
+	u64 out_of_buffer;
+	u64 rnr_nak_retry_err;
+	u64 local_ack_timeout_err;
+	u64 rx_read_requests;
+	u64 rx_write_requests;
+	u64 duplicate_requests;
+};
+
+struct xsc_hw_stats_rdma {
+	u8 is_pf;
+	u8 rsv[3];
+	union {
+		struct xsc_hw_stats_rdma_pf pf_stats;
+		struct xsc_hw_stats_rdma_vf vf_stats;
+	} stats;
+};
+
+struct xsc_hw_stats_eth_pf {
+	/*by mac port*/
+	u64 rdma_tx_pkts;
+	u64 rdma_tx_bytes;
+	u64 rdma_rx_pkts;
+	u64 rdma_rx_bytes;
+	u64 tx_pause;
+	u64 rx_pause;
+	u64 rx_fcs_errors;
+	u64 rx_discards;
+	u64	tx_multicast_phy;
+	u64 tx_broadcast_phy;
+	u64 rx_multicast_phy;
+	u64 rx_broadcast_phy;
+	/*by global*/
+	u64 rdma_loopback_pkts;
+	u64 rdma_loopback_bytes;
+};
+
+struct xsc_hw_stats_eth_vf {
+	/*by function*/
+	u64 rdma_tx_pkts;
+	u64 rdma_tx_bytes;
+	u64 rdma_rx_pkts;
+	u64 rdma_rx_bytes;
+};
+
+struct xsc_hw_stats_eth {
+	u8 is_pf;
+	u8 rsv[3];
+	union {
+		struct xsc_hw_stats_eth_pf pf_stats;
+		struct xsc_hw_stats_eth_vf vf_stats;
+	} stats;
+};
+
+struct xsc_hw_stats_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 mac_port;
+	u8 is_lag;
+	u8 lag_member_num;
+	u8 member_port[];
+};
+
+struct xsc_hw_stats_rdma_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_hw_stats_rdma	hw_stats;
+};
+
+struct xsc_hw_stats_eth_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_hw_stats_eth	hw_stats;
+};
+
+struct xsc_hw_global_stats_rdma {
+	/*by global*/
+	u64 rdma_loopback_pkts;
+	u64 rdma_loopback_bytes;
+	u64 rx_icrc_encapsulated;
+	u64 req_cqe_error;
+	u64 resp_cqe_error;
+	u64 cqe_msg_code_error;
+};
+
+struct xsc_hw_global_stats_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 rsv[4];
+};
+
+struct xsc_hw_global_stats_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	struct xsc_hw_global_stats_rdma	hw_stats;
+};
+
+struct xsc_pfc_stall_stats {
+	/*by mac port*/
+	u64 tx_pause_storm_triggered;
+};
+
+struct xsc_pfc_stall_stats_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 mac_port;
+};
+
+struct xsc_pfc_stall_stats_mbox_out {
+	struct xsc_outbox_hdr hdr;
+	struct xsc_pfc_stall_stats pfc_stall_stats;
+};
+
+struct xsc_dscp_pmt_set {
+	u8 dscp;
+	u8 priority;
+	u8 rsvd[6];
+};
+
+struct xsc_dscp_pmt_get {
+	u8 prio_map[QOS_DSCP_MAX + 1];
+	u8 max_prio;
+	u8 rsvd[7];
+};
+
+struct xsc_trust_mode_set {
+	u8 is_pcp;
+	u8 rsvd[7];
+};
+
+struct xsc_trust_mode_get {
+	u8 is_pcp;
+	u8 rsvd[7];
+};
+
+struct xsc_pcp_pmt_set {
+	u8 pcp;
+	u8 priority;
+	u8 rsvd[6];
+};
+
+struct xsc_pcp_pmt_get {
+	u8 prio_map[QOS_PCP_MAX + 1];
+	u8 max_prio;
+	u8 rsvd[7];
+};
+
+struct xsc_default_pri_set {
+	u8 priority;
+	u8 rsvd[7];
+};
+
+struct xsc_default_pri_get {
+	u8 priority;
+	u8 rsvd[7];
+};
+
+#define PFC_WATCHDOG_EN_OFF 0
+#define PFC_WATCHDOG_EN_ON 1
+struct xsc_watchdog_en_set {
+	u8 en;
+};
+
+struct xsc_watchdog_en_get {
+	u8 en;
+};
+
+#define PFC_WATCHDOG_PERIOD_MIN 1
+#define PFC_WATCHDOG_PERIOD_MAX 4000000
+struct xsc_watchdog_period_set {
+	u32 period;
+};
+
+struct xsc_watchdog_period_get {
+	u32 period;
+};
+
+struct xsc_event_resp {
+	u8 resp_cmd_type; /* bitmap:0x0001: link up/down */
+};
+
+struct xsc_event_linkstatus_resp {
+	u8 linkstatus; /*0:down, 1:up*/
+};
+
+struct xsc_event_linkinfo {
+	u8 linkstatus; /*0:down, 1:up*/
+	u8 port;
+	u8 duplex;
+	u8 autoneg;
+	u32 linkspeed;
+	u64 supported;
+	u64 advertising;
+	u64 supported_fec;	/* reserved, not support currently */
+	u64 advertised_fec;	/* reserved, not support currently */
+	u64 supported_speed[2];
+	u64 advertising_speed[2];
+};
+
+struct xsc_lldp_status_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	__be32 os_handle_lldp;
+	u8 sub_type;
+};
+
+struct xsc_lldp_status_mbox_out {
+	struct xsc_outbox_hdr hdr;
+	union {
+		__be32 os_handle_lldp;
+		__be32 dcbx_status;
+	} status;
+};
+
+struct xsc_vport_rate_limit_mobox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 other_vport;
+	__be16 vport_number;
+	__be16 rsvd0;
+	__be32 rate;
+};
+
+struct xsc_vport_rate_limit_mobox_out {
+	struct xsc_outbox_hdr hdr;
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
+struct xsc_event_query_linkstatus_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[2];
+};
+
+struct xsc_event_query_linkstatus_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	struct xsc_event_linkstatus_resp	ctx;
+};
+
+struct xsc_event_query_linkinfo_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+};
+
+struct xsc_event_query_linkinfo_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	struct xsc_event_linkinfo	ctx;
+};
+
+struct xsc_event_modify_linkinfo_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	struct xsc_event_linkinfo	ctx;
+};
+
+struct xsc_event_modify_linkinfo_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	u32	status;
+};
+
+struct xsc_event_set_port_admin_status_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u16	admin_status;
+
+};
+
+struct xsc_event_set_port_admin_status_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u32	status;
+};
+
+struct xsc_event_set_led_status_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	u8	port_id;
+};
+
+struct xsc_event_set_led_status_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	u32	status;
+};
+
+struct xsc_event_modify_fecparam_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u32	fec;
+};
+
+struct xsc_event_modify_fecparam_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	u32	status;
+};
+
+struct xsc_event_query_fecparam_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[2];
+};
+
+struct xsc_event_query_fecparam_mbox_out {
+	struct xsc_outbox_hdr		hdr;
+	u32	active_fec;
+	u32	fec_cfg;
+	u32	status;
+};
+
+#define PFC_ON_PG_PRFL_IDX	0
+#define PFC_OFF_PG_PRFL_IDX	1
+#define PFC_ON_QMU_VALUE	0
+#define PFC_OFF_QMU_VALUE	1
+
+#define NIF_PFC_EN_ON		1
+#define NIF_PFC_EN_OFF		0
+
+#define PFC_CFG_CHECK_TIMEOUT_US	8000000
+#define PFC_CFG_CHECK_SLEEP_TIME_US	200
+#define PFC_CFG_CHECK_MAX_RETRY_TIMES \
+	(PFC_CFG_CHECK_TIMEOUT_US / PFC_CFG_CHECK_SLEEP_TIME_US)
+#define PFC_CFG_CHECK_VALID_CNT		3
+
+enum {
+	PFC_OP_ENABLE = 0,
+	PFC_OP_DISABLE,
+	PFC_OP_MODIFY,
+	PFC_OP_TYPE_MAX,
+};
+
+enum {
+	DROP_TH_CLEAR = 0,
+	DROP_TH_RECOVER,
+	DROP_TH_RECOVER_LOSSY,
+	DROP_TH_RECOVER_LOSSLESS,
+};
+
+struct xsc_pfc_cfg {
+	u8 req_prio;
+	u8 req_pfc_en;
+	u8 curr_prio;
+	u8 curr_pfc_en;
+	u8 pfc_op;
+	u8 lossless_num;
+};
+
+#define LOSSLESS_NUM_INVAILD	9
+struct xsc_pfc_set {
+	u8 priority;
+	u8 pfc_on;
+	u8 type;
+	u8 src_prio;
+	u8 lossless_num;
+};
+
+#define PFC_PRIO_MAX 7
+struct xsc_pfc_get {
+	u8 pfc_on[PFC_PRIO_MAX + 1];
+	u8 max_prio;
+};
+
+struct xsc_pfc_set_drop_th_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 prio;
+	u8 cfg_type;
+};
+
+struct xsc_pfc_set_drop_th_mbox_out {
+	struct xsc_outbox_hdr hdr;
+};
+
+struct xsc_pfc_get_cfg_status_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	u8 prio;
+};
+
+struct xsc_pfc_get_cfg_status_mbox_out {
+	struct xsc_outbox_hdr hdr;
+};
+
+struct xsc_rate_limit_set {
+	u32 rate_cir;
+	u32 limit_id;
+	u8 limit_level;
+	u8 rsvd[7];
+};
+
+struct xsc_rate_limit_get {
+	u32 rate_cir[QOS_PRIO_MAX + 1];
+	u32 max_limit_id;
+	u8 limit_level;
+	u8 rsvd[3];
+};
+
+struct xsc_sp_set {
+	u8 sp[QOS_PRIO_MAX + 1];
+};
+
+struct xsc_sp_get {
+	u8 sp[QOS_PRIO_MAX + 1];
+	u8 max_prio;
+	u8 rsvd[7];
+};
+
+struct xsc_weight_set {
+	u8 weight[QOS_PRIO_MAX + 1];
+};
+
+struct xsc_weight_get {
+	u8 weight[QOS_PRIO_MAX + 1];
+	u8 max_prio;
+	u8 rsvd[7];
+};
+
+struct xsc_dpu_port_weight_set {
+	u8 target;
+	u8 weight[DPU_PORT_WGHT_CFG_MAX + 1];
+	u8 rsv[5];
+};
+
+struct xsc_dpu_port_weight_get {
+	u8 weight[DPU_PORT_WGHT_TARGET_NUM][DPU_PORT_WGHT_CFG_MAX + 1];
+	u8 rsvd[4];
+};
+
+struct xsc_dpu_prio_weight_set {
+	u8 target;
+	u8 weight[QOS_PRIO_MAX + 1];
+	u8 rsv[7];
+};
+
+struct xsc_dpu_prio_weight_get {
+	u8 weight[DPU_PRIO_WGHT_TARGET_NUM][QOS_PRIO_MAX + 1];
+};
+
+struct xsc_cc_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			data[];
+};
+
+struct xsc_cc_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			data[];
+};
+
+struct xsc_cc_ctrl_cmd {
+	u16 cmd;
+	u16 len;
+	u8 val[];
+};
+
+struct xsc_cc_cmd_enable_rp {
+	u16 cmd;
+	u16 len;
+	u32 enable;
+	u32 section;
+};
+
+struct xsc_cc_cmd_enable_np {
+	u16 cmd;
+	u16 len;
+	u32 enable;
+	u32 section;
+};
+
+struct xsc_cc_cmd_init_alpha {
+	u16 cmd;
+	u16 len;
+	u32 alpha;
+	u32 section;
+};
+
+struct xsc_cc_cmd_g {
+	u16 cmd;
+	u16 len;
+	u32 g;
+	u32 section;
+};
+
+struct xsc_cc_cmd_ai {
+	u16 cmd;
+	u16 len;
+	u32 ai;
+	u32 section;
+};
+
+struct xsc_cc_cmd_hai {
+	u16 cmd;
+	u16 len;
+	u32 hai;
+	u32 section;
+};
+
+struct xsc_cc_cmd_th {
+	u16 cmd;
+	u16 len;
+	u32 threshold;
+	u32 section;
+};
+
+struct xsc_cc_cmd_bc {
+	u16 cmd;
+	u16 len;
+	u32 bytecount;
+	u32 section;
+};
+
+struct xsc_cc_cmd_cnp_opcode {
+	u16 cmd;
+	u16 len;
+	u32 opcode;
+};
+
+struct xsc_cc_cmd_cnp_bth_b {
+	u16 cmd;
+	u16 len;
+	u32 bth_b;
+};
+
+struct xsc_cc_cmd_cnp_bth_f {
+	u16 cmd;
+	u16 len;
+	u32 bth_f;
+};
+
+struct xsc_cc_cmd_cnp_ecn {
+	u16 cmd;
+	u16 len;
+	u32 ecn;
+};
+
+struct xsc_cc_cmd_data_ecn {
+	u16 cmd;
+	u16 len;
+	u32 ecn;
+};
+
+struct xsc_cc_cmd_cnp_tx_interval {
+	u16 cmd;
+	u16 len;
+	u32 interval; // us
+	u32 section;
+};
+
+struct xsc_cc_cmd_evt_rsttime {
+	u16 cmd;
+	u16 len;
+	u32 period;
+};
+
+struct xsc_cc_cmd_cnp_dscp {
+	u16 cmd;
+	u16 len;
+	u32 dscp;
+	u32 section;
+};
+
+struct xsc_cc_cmd_cnp_pcp {
+	u16 cmd;
+	u16 len;
+	u32 pcp;
+	u32 section;
+};
+
+struct xsc_cc_cmd_evt_period_alpha {
+	u16 cmd;
+	u16 len;
+	u32 period;
+};
+
+struct xsc_cc_cmd_clamp_tgt_rate {
+	u16 cmd;
+	u16 len;
+	u32 clamp_tgt_rate;
+	u32 section;
+};
+
+struct xsc_cc_cmd_max_hai_factor {
+	u16 cmd;
+	u16 len;
+	u32 max_hai_factor;
+	u32 section;
+};
+
+struct xsc_cc_cmd_scale {
+	u16 cmd;
+	u16 len;
+	u32 scale;
+	u32 section;
+};
+
+struct xsc_cc_cmd_get_cfg {
+	u16 cmd;
+	u16 len;
+	u32 enable_rp;
+	u32 enable_np;
+	u32 init_alpha;
+	u32 g;
+	u32 ai;
+	u32 hai;
+	u32 threshold;
+	u32 bytecount;
+	u32 opcode;
+	u32 bth_b;
+	u32 bth_f;
+	u32 cnp_ecn;
+	u32 data_ecn;
+	u32 cnp_tx_interval;
+	u32 evt_period_rsttime;
+	u32 cnp_dscp;
+	u32 cnp_pcp;
+	u32 evt_period_alpha;
+	u32 clamp_tgt_rate;
+	u32 max_hai_factor;
+	u32 scale;
+	u32 section;
+};
+
+struct xsc_cc_cmd_get_stat {
+	u16 cmd;
+	u16 len;
+	u32 section;
+};
+
+struct xsc_cc_cmd_stat {
+	u32 cnp_handled;
+	u32 alpha_recovery;
+	u32 reset_timeout;
+	u32 reset_bytecount;
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
+struct xsc_hwc_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			data[];
+};
+
+struct xsc_hwc_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			data[];
+};
+
+struct hwc_set_t {
+	u8 type;
+	u8 s_wqe_mode;
+	u8 r_wqe_mode;
+	u8 ack_timeout;
+	u8 group_mode;
+	u8 lossless_prio[XSC_MAX_MAC_NUM];
+	u8 lossless_prio_len;
+	u8 retry_cnt_th;
+	u8 adapt_to_other;
+	u8 alloc_qp_id_mode;
+	u16 vf_num_per_pf;
+	u16 max_vf_num_per_pf;
+	u8 eth_pkt_offset;
+	u8 rdma_pkt_offset;
+	u8 tso_eth_pkt_offset;
+	u8 tx_dedi_pref;
+	u8 reg_mr_via_cmdq;
+	u8 per_dst_grp_thr;
+	u8 per_dst_grp_cnt;
+	u8 dcbx_status[XSC_MAX_MAC_NUM];
+	u8 dcbx_port_cnt;
+};
+
+struct hwc_get_t {
+	u8 cur_s_wqe_mode;
+	u8 next_s_wqe_mode;
+	u8 cur_r_wqe_mode;
+	u8 next_r_wqe_mode;
+	u8 cur_ack_timeout;
+	u8 next_ack_timeout;
+	u8 cur_group_mode;
+	u8 next_group_mode;
+	u8 cur_lossless_prio[XSC_MAX_MAC_NUM];
+	u8 next_lossless_prio[XSC_MAX_MAC_NUM];
+	u8 lossless_prio_len;
+	u8 cur_retry_cnt_th;
+	u8 next_retry_cnt_th;
+	u8 cur_adapt_to_other;
+	u8 next_adapt_to_other;
+	u16 cur_vf_num_per_pf;
+	u16 next_vf_num_per_pf;
+	u16 cur_max_vf_num_per_pf;
+	u16 next_max_vf_num_per_pf;
+	u8 cur_eth_pkt_offset;
+	u8 next_eth_pkt_offset;
+	u8 cur_rdma_pkt_offset;
+	u8 next_rdma_pkt_offset;
+	u8 cur_tso_eth_pkt_offset;
+	u8 next_tso_eth_pkt_offset;
+	u8 cur_alloc_qp_id_mode;
+	u8 next_alloc_qp_id_mode;
+	u8 cur_tx_dedi_pref;
+	u8 next_tx_dedi_pref;
+	u8 cur_reg_mr_via_cmdq;
+	u8 next_reg_mr_via_cmdq;
+	u8 cur_per_dst_grp_thr;
+	u8 next_per_dst_grp_thr;
+	u8 cur_per_dst_grp_cnt;
+	u8 next_per_dst_grp_cnt;
+	u8 cur_dcbx_status[XSC_MAX_MAC_NUM];
+	u8 next_dcbx_status[XSC_MAX_MAC_NUM];
+	u8 dcbx_port_cnt;
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
+	u8			mac[6];
+};
+
+struct xsc_query_pause_cnt_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u16    mac_port;
+	u16    cnt_type;
+	u32    reg_addr;
+};
+
+struct xsc_query_pause_cnt_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u64    val;
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
+	u8	mac_addr[6];
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
+	struct xsc_outbox_hdr		hdr;
+	u8	rsvd0[2];
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
+	u8	rsvd0[4];
+};
+
+enum {
+	XSC_RSS_HASH_KEY_UPDATE	= 0,
+	XSC_RSS_HASH_TEMP_UPDATE,
+	XSC_RSS_HASH_FUNC_UPDATE,
+	XSC_RSS_RXQ_UPDATE,
+	XSC_RSS_RXQ_DROP,
+};
+
+struct xsc_rss_modify_attr {
+	u8	caps_mask;
+	u8	rss_en;
+	__be16	rqn_base;
+	__be16	rqn_num;
+	u8	hfunc;
+	__be32	hash_tmpl;
+	u8	hash_key[52];
+};
+
+struct xsc_cmd_modify_nic_hca_mbox_in {
+	struct xsc_inbox_hdr		hdr;
+	struct xsc_nic_attr		nic;
+	struct xsc_rss_modify_attr	rss;
+};
+
+struct xsc_cmd_modify_nic_hca_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd0[4];
+};
+
+struct xsc_function_reset_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	__be16	glb_func_id;
+	u8	rsvd[6];
+};
+
+struct xsc_function_reset_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8	rsvd[8];
+};
+
+enum {
+	XSC_PCIE_LAT_FEAT_SET_EN	= 0,
+	XSC_PCIE_LAT_FEAT_GET_EN,
+	XSC_PCIE_LAT_FEAT_SET_INTERVAL,
+	XSC_PCIE_LAT_FEAT_GET_INTERVAL,
+	XSC_PCIE_LAT_FEAT_GET_HISTOGRAM,
+	XSC_PCIE_LAT_FEAT_GET_PEAK,
+	XSC_PCIE_LAT_FEAT_HW,
+	XSC_PCIE_LAT_FEAT_HW_INIT,
+};
+
+struct xsc_pcie_lat {
+	u8 pcie_lat_enable;
+	u32 pcie_lat_interval[XSC_PCIE_LAT_CFG_INTERVAL_MAX];
+	u32 pcie_lat_histogram[XSC_PCIE_LAT_CFG_HISTOGRAM_MAX];
+	u32 pcie_lat_peak;
+};
+
+struct xsc_pcie_lat_feat_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	__be16 xsc_pcie_lat_feature_opcode;
+	struct xsc_pcie_lat pcie_lat;
+};
+
+struct xsc_pcie_lat_feat_mbox_out {
+	struct xsc_outbox_hdr hdr;
+	__be16 xsc_pcie_lat_feature_opcode;
+	struct xsc_pcie_lat pcie_lat;
+};
+
+struct xsc_reg_mcia {
+	u8         module;
+	u8         status;
+
+	u8         i2c_device_address;
+	u8         page_number;
+	u8         device_address;
+
+	u8         size;
+
+	u8         dword_0[0x20];
+	u8         dword_1[0x20];
+	u8         dword_2[0x20];
+	u8         dword_3[0x20];
+	u8         dword_4[0x20];
+	u8         dword_5[0x20];
+	u8         dword_6[0x20];
+	u8         dword_7[0x20];
+	u8         dword_8[0x20];
+	u8         dword_9[0x20];
+	u8         dword_10[0x20];
+	u8         dword_11[0x20];
+};
+
+struct xsc_rtt_en_mbox_in {
+	struct xsc_inbox_hdr    hdr;
+	u8    en;//0-disable, 1-enable
+	u8    rsvd[7];
+};
+
+struct xsc_rtt_en_mbox_out {
+	struct xsc_outbox_hdr    hdr;
+	u8    en;//0-disable, 1-enable
+	u8    rsvd[7];
+};
+
+struct xsc_rtt_qpn_mbox_in {
+	struct xsc_inbox_hdr    hdr;
+	__be32    qpn[32];
+};
+
+struct xsc_rtt_qpn_mbox_out {
+	struct xsc_outbox_hdr    hdr;
+	u8    rsvd[8];
+};
+
+struct xsc_get_rtt_qpn_mbox_out {
+	struct xsc_outbox_hdr    hdr;
+	__be32    qpn[32];
+};
+
+struct xsc_rtt_period_mbox_in {
+	struct xsc_inbox_hdr    hdr;
+	__be32    period; //ms
+};
+
+struct xsc_rtt_period_mbox_out {
+	struct xsc_outbox_hdr    hdr;
+	__be32    period; //ms
+	u8    rsvd[4];
+};
+
+struct xsc_rtt_result_mbox_out {
+	struct xsc_outbox_hdr    hdr;
+	__be64    result[32];
+};
+
+struct rtt_stats {
+	u64 rtt_succ_snd_req_cnt;
+	u64 rtt_succ_snd_rsp_cnt;
+	u64 rtt_fail_snd_req_cnt;
+	u64 rtt_fail_snd_rsp_cnt;
+	u64 rtt_rcv_req_cnt;
+	u64 rtt_rcv_rsp_cnt;
+	u64 rtt_rcv_unk_cnt;
+	u64 rtt_grp_invalid_cnt;
+};
+
+struct xsc_rtt_stats_mbox_out {
+	struct xsc_outbox_hdr	 hdr;
+	struct rtt_stats stats;
+};
+
+enum {
+	XSC_AP_FEAT_SET_UDP_SPORT = 0,
+};
+
+struct xsc_ap_feat_set_udp_sport {
+	u32 qpn;
+	u32 udp_sport;
+};
+
+struct xsc_ap {
+	struct xsc_ap_feat_set_udp_sport set_udp_sport;
+};
+
+struct xsc_ap_feat_mbox_in {
+	struct xsc_inbox_hdr hdr;
+	__be16 xsc_ap_feature_opcode;
+	struct xsc_ap ap;
+};
+
+struct xsc_ap_feat_mbox_out {
+	struct xsc_outbox_hdr hdr;
+	__be16 xsc_ap_feature_opcode;
+	struct xsc_ap ap;
+};
+
+struct xsc_set_debug_info_mbox_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			set_field;
+	u8			log_level;
+	u8			cmd_verbose;
+	u8			rsvd[5];
+};
+
+struct xsc_set_debug_info_mbox_out {
+	struct xsc_outbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_enable_relaxed_order_in {
+	struct xsc_inbox_hdr	hdr;
+	u8			rsvd[8];
+};
+
+struct xsc_cmd_enable_relaxed_order_out {
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
+#endif /* XSC_CMD_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
new file mode 100644
index 000000000..ff278f52e
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CMDQ_H
+#define XSC_CMDQ_H
+
+#include "common/xsc_cmd.h"
+
+enum {
+	/* one minute for the sake of bringup. Generally, commands must always
+	 * complete and we may need to increase this timeout value
+	 */
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
+	u8		owner_status; //init to 0, dma user should change this val to 1
+	u8		token;
+	u8		ctrl_sig;
+	u8		sig;
+};
+
+struct cache_ent {
+	/* protect block chain allocations
+	 */
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
+	__be32		data[RSP_FIRST_SIZE]; //can be larger, xsc_rsp_layout
+};
+
+struct xsc_rsp_msg {
+	struct list_head		list;
+	struct cache_ent	       *cache;
+	u32				len;
+	struct xsc_rsp_first		first;
+	struct xsc_cmd_mailbox	    *next;
+};
+
+typedef void (*xsc_cmd_cbk_t)(int status, void *context);
+
+//hw will use this for some records(e.g. vf_id)
+struct cmdq_rsv {
+	u16 vf_id;
+	u8 rsv[2];
+};
+
+//related with hw, won't change
+#define CMDQ_ENTRY_SIZE 64
+
+struct xsc_cmd_layout {
+	struct cmdq_rsv rsv0;
+	__be32		inlen;
+	__be64		in_ptr;
+	__be32		in[CMD_FIRST_SIZE];
+	__be64		out_ptr;
+	__be32		outlen;
+	u8		token;
+	u8		sig;
+	u8		idx;
+	u8		type: 7;
+	u8      owner_bit: 1; //rsv for hw, arm will check this bit to make sure mem written
+};
+
+struct xsc_rsp_layout {
+	struct cmdq_rsv rsv0;
+	__be32		out[RSP_FIRST_SIZE];
+	u8		token;
+	u8		sig;
+	u8		idx;
+	u8		type: 7;
+	u8      owner_bit: 1; //rsv for hw, driver will check this bit to make sure mem written
+};
+
+struct xsc_cmd_work_ent {
+	struct xsc_cmd_msg    *in;
+	struct xsc_rsp_msg    *out;
+	int idx;
+	struct completion	done;
+	struct xsc_cmd        *cmd;
+	struct work_struct	work;
+	struct xsc_cmd_layout *lay;
+	struct xsc_rsp_layout *rsp_lay;
+	int			ret;
+	u8			status;
+	u8			token;
+	struct timespec64       ts1;
+	struct timespec64       ts2;
+};
+
+struct xsc_cmd_debug {
+	struct dentry	       *dbg_root;
+	struct dentry	       *dbg_in;
+	struct dentry	       *dbg_out;
+	struct dentry	       *dbg_outlen;
+	struct dentry	       *dbg_status;
+	struct dentry	       *dbg_run;
+	void		       *in_msg;
+	void		       *out_msg;
+	u8			status;
+	u16			inlen;
+	u16			outlen;
+};
+
+struct xsc_cmd_stats {
+	u64		sum;
+	u64		n;
+	struct dentry  *root;
+	struct dentry  *avg;
+	struct dentry  *count;
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
+struct xsc_cmd {
+	struct xsc_cmd_reg reg;
+	void	       *cmd_buf;
+	void	       *cq_buf;
+	dma_addr_t	dma;
+	dma_addr_t	cq_dma;
+	u16     cmd_pid;
+	u16     cq_cid;
+	u8      owner_bit;
+	u8		cmdif_rev;
+	u8		log_sz;
+	u8		log_stride;
+	int		max_reg_cmds;
+	int		events;
+	u32 __iomem    *vector;
+
+	spinlock_t	alloc_lock;	/* protect command queue allocations */
+	spinlock_t	token_lock;	/* protect token allocations */
+	spinlock_t	doorbell_lock;	/* protect cmdq req pid doorbell */
+	u8		token;
+	unsigned long	bitmask;
+	char		wq_name[XSC_CMD_WQ_MAX_NAME];
+	struct workqueue_struct *wq;
+	struct task_struct *cq_task;
+	struct semaphore sem;
+	int	mode;
+	struct xsc_cmd_work_ent *ent_arr[XSC_MAX_COMMANDS];
+	struct dma_pool *pool;
+	struct xsc_cmd_debug dbg;
+	struct cmd_msg_cache cache;
+	int checksum_disabled;
+	struct xsc_cmd_stats stats[XSC_CMD_OP_MAX];
+	unsigned int	irqn;
+	u8	ownerbit_learned;
+	u8	cmd_status;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 6049c2c65..7b60102f5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -8,7 +8,9 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include "common/xsc_cmdq.h"
 
+extern uint xsc_debug_mask;
 extern unsigned int xsc_log_level;
 
 #define XSC_PCI_VENDOR_ID		0x1f67
@@ -93,6 +95,11 @@ do {									\
 	}								\
 } while (0)
 
+#define REG_ADDR(dev, offset)						\
+	(((dev)->bar) + ((offset) - 0xA0000000))
+
+#define REG_WIDTH_TO_STRIDE(width)	((width) / 8)
+
 enum {
 	XSC_MAX_NAME_LEN = 32,
 };
@@ -107,6 +114,11 @@ enum xsc_pci_status {
 	XSC_PCI_STATUS_ENABLED,
 };
 
+enum xsc_interface_state {
+	XSC_INTERFACE_STATE_UP = BIT(0),
+	XSC_INTERFACE_STATE_TEARDOWN = BIT(1),
+};
+
 struct xsc_priv {
 	char			name[XSC_MAX_NAME_LEN];
 	struct list_head	dev_list;
@@ -125,6 +137,9 @@ struct xsc_core_device {
 	void __iomem		*bar;
 	int			bar_num;
 
+	struct xsc_cmd		cmd;
+	u16			cmdq_ver;
+
 	struct mutex		pci_status_mutex;	/* protect pci_status */
 	enum xsc_pci_status	pci_status;
 	struct mutex		intf_state_mutex;	/* protect intf_state */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
new file mode 100644
index 000000000..1097353f4
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_DRIVER_H
+#define XSC_DRIVER_H
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
+int xsc_cmd_exec(struct xsc_core_device *dev, void *in, int in_size, void *out,
+		 int out_size);
+int xsc_cmd_version_check(struct xsc_core_device *dev);
+const char *xsc_command_str(int command);
+
+#endif
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index b2ae73fb9..e2bf8bcf0 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o
+xsc_pci-y := main.o cmdq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
new file mode 100644
index 000000000..bc9467ba4
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
@@ -0,0 +1,2164 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2013-2016, Mellanox Technologies. All rights reserved.
+ * Copyright (C) 2021-2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifdef HAVE_GENERIC_KMAP_TYPE
+#include <asm-generic/kmap_types.h>
+#endif
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/kthread.h>
+#include <linux/io-mapping.h>
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
+	CMD_MODE_POLLING,
+	CMD_MODE_EVENTS
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
+	XSC_CMD_DELIVERY_STAT_OUT_PTR_ALIGN_ERR	= 0x4,
+	XSC_CMD_DELIVERY_STAT_IN_PTR_ALIGN_ERR		= 0x5,
+	XSC_CMD_DELIVERY_STAT_FW_ERR			= 0x6,
+	XSC_CMD_DELIVERY_STAT_IN_LENGTH_ERR		= 0x7,
+	XSC_CMD_DELIVERY_STAT_OUT_LENGTH_ERR		= 0x8,
+	XSC_CMD_DELIVERY_STAT_RES_FLD_NOT_CLR_ERR	= 0x9,
+	XSC_CMD_DELIVERY_STAT_CMD_DESCR_ERR		= 0x10,
+};
+
+static struct xsc_cmd_work_ent *alloc_cmd(struct xsc_cmd *cmd,
+					  struct xsc_cmd_msg *in,
+					  struct xsc_rsp_msg *out)
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
+static u8 alloc_token(struct xsc_cmd *cmd)
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
+static int alloc_ent(struct xsc_cmd *cmd)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&cmd->alloc_lock, flags);
+	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
+	if (ret < cmd->max_reg_cmds)
+		clear_bit(ret, &cmd->bitmask);
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+
+	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
+}
+
+static void free_ent(struct xsc_cmd *cmd, int idx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cmd->alloc_lock, flags);
+	set_bit(idx, &cmd->bitmask);
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+}
+
+static struct xsc_cmd_layout *get_inst(struct xsc_cmd *cmd, int idx)
+{
+	return cmd->cmd_buf + (idx << cmd->log_stride);
+}
+
+static struct xsc_rsp_layout *get_cq_inst(struct xsc_cmd *cmd, int idx)
+{
+	return cmd->cq_buf + (idx << cmd->log_stride);
+}
+
+static u8 xor8_buf(void *buf, int len)
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
+static int verify_block_sig(struct xsc_cmd_prot_block *block)
+{
+	if (xor8_buf(block->rsvd0, sizeof(*block) - sizeof(block->data) - 1) != 0xff)
+		return -EINVAL;
+
+	if (xor8_buf(block, sizeof(*block)) != 0xff)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void calc_block_sig(struct xsc_cmd_prot_block *block, u8 token)
+{
+	block->token = token;
+	block->ctrl_sig = ~xor8_buf(block->rsvd0, sizeof(*block) - sizeof(block->data) - 2);
+	block->sig = ~xor8_buf(block, sizeof(*block) - 1);
+}
+
+static void calc_chain_sig(struct xsc_cmd_mailbox *head, u8 token)
+{
+	struct xsc_cmd_mailbox *next = head;
+
+	while (next) {
+		calc_block_sig(next->buf, token);
+		next = next->next;
+	}
+}
+
+static void set_signature(struct xsc_cmd_work_ent *ent)
+{
+	ent->lay->sig = ~xor8_buf(ent->lay, sizeof(*ent->lay));
+	calc_chain_sig(ent->in->next, ent->token);
+	calc_chain_sig(ent->out->next, ent->token);
+}
+
+static void free_cmd(struct xsc_cmd_work_ent *ent)
+{
+	kfree(ent);
+}
+
+static int verify_signature(struct xsc_cmd_work_ent *ent)
+{
+	struct xsc_cmd_mailbox *next = ent->out->next;
+	int err;
+	u8 sig;
+
+	sig = xor8_buf(ent->rsp_lay, sizeof(*ent->rsp_lay));
+	if (sig != 0xff)
+		return -EINVAL;
+
+	while (next) {
+		err = verify_block_sig(next->buf);
+		if (err)
+			return err;
+
+		next = next->next;
+	}
+
+	return 0;
+}
+
+static void dump_buf(void *buf, int size, int offset)
+{
+	__be32 *p = buf;
+	int i;
+
+	for (i = 0; i < size; i += 16) {
+		xsc_pr_debug("%03x: %08x %08x %08x %08x\n", offset, be32_to_cpu(p[0]),
+			     be32_to_cpu(p[1]), be32_to_cpu(p[2]), be32_to_cpu(p[3]));
+		p += 4;
+		offset += 16;
+	}
+	xsc_pr_debug("\n");
+}
+
+const char *xsc_command_str(int command)
+{
+	switch (command) {
+	case XSC_CMD_OP_QUERY_HCA_CAP:
+		return "QUERY_HCA_CAP";
+
+	case XSC_CMD_OP_ENABLE_HCA:
+		return "ENABLE_HCA";
+
+	case XSC_CMD_OP_DISABLE_HCA:
+		return "DISABLE_HCA";
+
+	case XSC_CMD_OP_MODIFY_HCA:
+		return "MODIFY_HCA";
+
+	case XSC_CMD_OP_QUERY_CMDQ_VERSION:
+		return "QUERY_CMDQ_VERSION";
+
+	case XSC_CMD_OP_QUERY_MSIX_TBL_INFO:
+		return "QUERY_MSIX_TBL_INFO";
+
+	case XSC_CMD_OP_FUNCTION_RESET:
+		return "FUNCTION_RESET";
+
+	case XSC_CMD_OP_ALLOC_IA_LOCK:
+		return "ALLOC_IA_LOCK";
+
+	case XSC_CMD_OP_RELEASE_IA_LOCK:
+		return "RELEASE_IA_LOCK";
+
+	case XSC_CMD_OP_DUMMY:
+		return "DUMMY_CMD";
+
+	case XSC_CMD_OP_SET_DEBUG_INFO:
+		return "SET_DEBUG_INFO";
+
+	case XSC_CMD_OP_CREATE_MKEY:
+		return "CREATE_MKEY";
+
+	case XSC_CMD_OP_QUERY_MKEY:
+		return "QUERY_MKEY";
+
+	case XSC_CMD_OP_DESTROY_MKEY:
+		return "DESTROY_MKEY";
+
+	case XSC_CMD_OP_QUERY_SPECIAL_CONTEXTS:
+		return "QUERY_SPECIAL_CONTEXTS";
+
+	case XSC_CMD_OP_SET_MPT:
+		return "SET_MPT";
+
+	case XSC_CMD_OP_SET_MTT:
+		return "SET_MTT";
+
+	case XSC_CMD_OP_CREATE_EQ:
+		return "CREATE_EQ";
+
+	case XSC_CMD_OP_DESTROY_EQ:
+		return "DESTROY_EQ";
+
+	case XSC_CMD_OP_QUERY_EQ:
+		return "QUERY_EQ";
+
+	case XSC_CMD_OP_CREATE_CQ:
+		return "CREATE_CQ";
+
+	case XSC_CMD_OP_DESTROY_CQ:
+		return "DESTROY_CQ";
+
+	case XSC_CMD_OP_QUERY_CQ:
+		return "QUERY_CQ";
+
+	case XSC_CMD_OP_MODIFY_CQ:
+		return "MODIFY_CQ";
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
+	case XSC_CMD_OP_QUERY_QP:
+		return "QUERY_QP";
+
+	case XSC_CMD_OP_CONF_SQP:
+		return "CONF_SQP";
+
+	case XSC_CMD_OP_MAD_IFC:
+		return "MAD_IFC";
+
+	case XSC_CMD_OP_INIT2INIT_QP:
+		return "INIT2INIT_QP";
+
+	case XSC_CMD_OP_SQD2SQD_QP:
+		return "SQD2SQD_QP";
+
+	case XSC_CMD_OP_QUERY_QP_FLUSH_STATUS:
+		return "QUERY_QP_FLUSH_STATUS";
+
+	case XSC_CMD_OP_ALLOC_PD:
+		return "ALLOC_PD";
+
+	case XSC_CMD_OP_DEALLOC_PD:
+		return "DEALLOC_PD";
+
+	case XSC_CMD_OP_ACCESS_REG:
+		return "ACCESS_REG";
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
+	case XSC_CMD_OP_MODIFY_NIC_HCA:
+		return "MODIFY_NIC_HCA";
+
+	case XSC_CMD_OP_QUERY_NIC_VPORT_CONTEXT:
+		return "QUERY_NIC_VPORT_CONTEXT";
+
+	case XSC_CMD_OP_MODIFY_NIC_VPORT_CONTEXT:
+		return "MODIFY_NIC_VPORT_CONTEXT";
+
+	case XSC_CMD_OP_QUERY_VPORT_STATE:
+		return "QUERY_VPORT_STATE";
+
+	case XSC_CMD_OP_MODIFY_VPORT_STATE:
+		return "MODIFY_VPORT_STATE";
+
+	case XSC_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
+		return "QUERY_HCA_VPORT_CONTEXT";
+
+	case XSC_CMD_OP_MODIFY_HCA_VPORT_CONTEXT:
+		return "MODIFY_HCA_VPORT_CONTEXT";
+
+	case XSC_CMD_OP_QUERY_HCA_VPORT_GID:
+		return "QUERY_HCA_VPORT_GID";
+
+	case XSC_CMD_OP_QUERY_HCA_VPORT_PKEY:
+		return "QUERY_HCA_VPORT_PKEY";
+
+	case XSC_CMD_OP_QUERY_VPORT_COUNTER:
+		return "QUERY_VPORT_COUNTER";
+
+	case XSC_CMD_OP_QUERY_PRIO_STATS:
+		return "QUERY_PRIO_STATS";
+
+	case XSC_CMD_OP_QUERY_PHYPORT_STATE:
+		return "QUERY_PHYPORT_STATE";
+
+	case XSC_CMD_OP_QUERY_EVENT_TYPE:
+		return "QUERY_EVENT_TYPE";
+
+	case XSC_CMD_OP_QUERY_LINK_INFO:
+		return "QUERY_LINK_INFO";
+
+	case XSC_CMD_OP_MODIFY_LINK_INFO:
+		return "MODIFY_LINK_INFO";
+
+	case XSC_CMD_OP_MODIFY_FEC_PARAM:
+		return "MODIFY_FEC_PARAM";
+
+	case XSC_CMD_OP_QUERY_FEC_PARAM:
+		return "QUERY_FEC_PARAM";
+
+	case XSC_CMD_OP_LAG_CREATE:
+		return "LAG_CREATE";
+
+	case XSC_CMD_OP_LAG_ADD_MEMBER:
+		return "LAG ADD MEMBER";
+
+	case XSC_CMD_OP_LAG_REMOVE_MEMBER:
+		return "LAG REMOVE MEMBER";
+
+	case XSC_CMD_OP_LAG_UPDATE_MEMBER_STATUS:
+		return "LAG UPDATE MEMBER STATUS";
+
+	case XSC_CMD_OP_LAG_UPDATE_HASH_TYPE:
+		return "LAG UPDATE HASH TYPE";
+
+	case XSC_CMD_OP_LAG_DESTROY:
+		return "LAG_DESTROY";
+
+	case XSC_CMD_OP_LAG_SET_QOS:
+		return "LAG_SET_QOS";
+
+	case XSC_CMD_OP_ENABLE_MSIX:
+		return "ENABLE_MSIX";
+
+	case XSC_CMD_OP_IOCTL_FLOW:
+		return "CFG_FLOW_TABLE";
+
+	case XSC_CMD_OP_IOCTL_SET_DSCP_PMT:
+		return "SET_DSCP_PMT";
+
+	case XSC_CMD_OP_IOCTL_GET_DSCP_PMT:
+		return "GET_DSCP_PMT";
+
+	case XSC_CMD_OP_IOCTL_SET_TRUST_MODE:
+		return "SET_TRUST_MODE";
+
+	case XSC_CMD_OP_IOCTL_GET_TRUST_MODE:
+		return "GET_TRUST_MODE";
+
+	case XSC_CMD_OP_IOCTL_SET_PCP_PMT:
+		return "SET_PCP_PMT";
+
+	case XSC_CMD_OP_IOCTL_GET_PCP_PMT:
+		return "GET_PCP_PMT";
+
+	case XSC_CMD_OP_IOCTL_SET_DEFAULT_PRI:
+		return "SET_DEFAULT_PRI";
+
+	case XSC_CMD_OP_IOCTL_GET_DEFAULT_PRI:
+		return "GET_DEFAULT_PRI";
+
+	case XSC_CMD_OP_IOCTL_SET_PFC:
+		return "SET_PFC";
+
+	case XSC_CMD_OP_IOCTL_SET_PFC_DROP_TH:
+		return "SET_PFC_DROP_TH";
+
+	case XSC_CMD_OP_IOCTL_GET_PFC:
+		return "GET_PFC";
+
+	case XSC_CMD_OP_IOCTL_GET_PFC_CFG_STATUS:
+		return "GET_PFC_CFG_STATUS";
+
+	case XSC_CMD_OP_IOCTL_SET_RATE_LIMIT:
+		return "SET_RATE_LIMIT";
+
+	case XSC_CMD_OP_IOCTL_GET_RATE_LIMIT:
+		return "GET_RATE_LIMIT";
+
+	case XSC_CMD_OP_IOCTL_SET_SP:
+		return "SET_SP";
+
+	case XSC_CMD_OP_IOCTL_GET_SP:
+		return "GET_SP";
+
+	case XSC_CMD_OP_IOCTL_SET_WEIGHT:
+		return "SET_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_GET_WEIGHT:
+		return "GET_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_DPU_SET_PORT_WEIGHT:
+		return "DPU_SET_PORT_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_DPU_GET_PORT_WEIGHT:
+		return "DPU_GET_PORT_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_DPU_SET_PRIO_WEIGHT:
+		return "DPU_SET_PRIO_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_DPU_GET_PRIO_WEIGHT:
+		return "DPU_GET_PRIO_WEIGHT";
+
+	case XSC_CMD_OP_IOCTL_SET_WATCHDOG_EN:
+		return "SET_WATCHDOG_EN";
+
+	case XSC_CMD_OP_IOCTL_GET_WATCHDOG_EN:
+		return "GET_WATCHDOG_EN";
+
+	case XSC_CMD_OP_IOCTL_SET_WATCHDOG_PERIOD:
+		return "SET_WATCHDOG_PERIOD";
+
+	case XSC_CMD_OP_IOCTL_GET_WATCHDOG_PERIOD:
+		return "GET_WATCHDOG_PERIOD";
+
+	case XSC_CMD_OP_IOCTL_SET_ENABLE_RP:
+		return "ENABLE_RP";
+
+	case XSC_CMD_OP_IOCTL_SET_ENABLE_NP:
+		return "ENABLE_NP";
+
+	case XSC_CMD_OP_IOCTL_SET_INIT_ALPHA:
+		return "SET_INIT_ALPHA";
+
+	case XSC_CMD_OP_IOCTL_SET_G:
+		return "SET_G";
+
+	case XSC_CMD_OP_IOCTL_SET_AI:
+		return "SET_AI";
+
+	case XSC_CMD_OP_IOCTL_SET_HAI:
+		return "SET_HAI";
+
+	case XSC_CMD_OP_IOCTL_SET_TH:
+		return "SET_TH";
+
+	case XSC_CMD_OP_IOCTL_SET_BC_TH:
+		return "SET_BC_TH";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_OPCODE:
+		return "SET_CNP_OPCODE";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_BTH_B:
+		return "SET_CNP_BTH_B";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_BTH_F:
+		return "SET_CNP_BTH_F";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_ECN:
+		return "SET_CNP_ECN";
+
+	case XSC_CMD_OP_IOCTL_SET_DATA_ECN:
+		return "SET_DATA_ECN";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_TX_INTERVAL:
+		return "SET_CNP_TX_INTERVAL";
+
+	case XSC_CMD_OP_IOCTL_SET_EVT_PERIOD_RSTTIME:
+		return "SET_EVT_PERIOD_RSTTIME";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_DSCP:
+		return "SET_CNP_DSCP";
+
+	case XSC_CMD_OP_IOCTL_SET_CNP_PCP:
+		return "SET_CNP_PCP";
+
+	case XSC_CMD_OP_IOCTL_SET_EVT_PERIOD_ALPHA:
+		return "SET_EVT_PERIOD_ALPHA";
+
+	case XSC_CMD_OP_IOCTL_GET_CC_CFG:
+		return "GET_CC_CFG";
+
+	case XSC_CMD_OP_IOCTL_GET_CC_STAT:
+		return "GET_CC_STAT";
+
+	case XSC_CMD_OP_IOCTL_SET_CLAMP_TGT_RATE:
+		return "SET_CLAMP_TGT_RATE";
+
+	case XSC_CMD_OP_IOCTL_SET_MAX_HAI_FACTOR:
+		return "SET_MAX_HAI_FACTOR";
+
+	case XSC_CMD_OP_IOCTL_SET_HWC:
+		return "SET_HWCONFIG";
+
+	case XSC_CMD_OP_IOCTL_GET_HWC:
+		return "GET_HWCONFIG";
+
+	case XSC_CMD_OP_SET_MTU:
+		return "SET_MTU";
+
+	case XSC_CMD_OP_QUERY_ETH_MAC:
+		return "QUERY_ETH_MAC";
+
+	case XSC_CMD_OP_QUERY_HW_STATS:
+		return "QUERY_HW_STATS";
+
+	case XSC_CMD_OP_QUERY_PAUSE_CNT:
+		return "QUERY_PAUSE_CNT";
+
+	case XSC_CMD_OP_SET_RTT_EN:
+		return "SET_RTT_EN";
+
+	case XSC_CMD_OP_GET_RTT_EN:
+		return "GET_RTT_EN";
+
+	case XSC_CMD_OP_SET_RTT_QPN:
+		return "SET_RTT_QPN";
+
+	case XSC_CMD_OP_GET_RTT_QPN:
+		return "GET_RTT_QPN";
+
+	case XSC_CMD_OP_SET_RTT_PERIOD:
+		return "SET_RTT_PERIOD";
+
+	case XSC_CMD_OP_GET_RTT_PERIOD:
+		return "GET_RTT_PERIOD";
+
+	case XSC_CMD_OP_GET_RTT_RESULT:
+		return "GET_RTT_RESULT";
+
+	case XSC_CMD_OP_GET_RTT_STATS:
+		return "ET_RTT_STATS";
+
+	case XSC_CMD_OP_SET_LED_STATUS:
+		return "SET_LED_STATUS";
+
+	case XSC_CMD_OP_AP_FEAT:
+		return "AP_FEAT";
+
+	case XSC_CMD_OP_PCIE_LAT_FEAT:
+		return "PCIE_LAT_FEAT";
+
+	case XSC_CMD_OP_USER_EMU_CMD:
+		return "USER_EMU_CMD";
+
+	case XSC_CMD_OP_QUERY_PFC_PRIO_STATS:
+		return "QUERY_PFC_PRIO_STATS";
+
+	case XSC_CMD_OP_IOCTL_QUERY_PFC_STALL_STATS:
+		return "QUERY_PFC_STALL_STATS";
+
+	case XSC_CMD_OP_QUERY_HW_STATS_RDMA:
+		return "QUERY_HW_STATS_RDMA";
+
+	case XSC_CMD_OP_QUERY_HW_STATS_ETH:
+		return "QUERY_HW_STATS_ETH";
+
+	case XSC_CMD_OP_SET_VPORT_RATE_LIMIT:
+		return "SET_VPORT_RATE_LIMIT";
+
+	default: return "unknown command opcode";
+	}
+}
+
+static void dump_command(struct xsc_core_device *xdev, struct xsc_cmd_mailbox *next,
+			 struct xsc_cmd_work_ent *ent, int input, int len)
+{
+	u16 op = be16_to_cpu(((struct xsc_inbox_hdr *)(ent->lay->in))->opcode);
+	int offset = 0;
+
+	if (!(xsc_debug_mask & (1 << XSC_CMD_DATA)))
+		return;
+
+	xsc_core_dbg(xdev, "dump command %s(0x%x) %s\n", xsc_command_str(op), op,
+		     input ? "INPUT" : "OUTPUT");
+
+	if (input) {
+		dump_buf(ent->lay, sizeof(*ent->lay), offset);
+		offset += sizeof(*ent->lay);
+	} else {
+		dump_buf(ent->rsp_lay, sizeof(*ent->rsp_lay), offset);
+		offset += sizeof(*ent->rsp_lay);
+	}
+
+	while (next && offset < len) {
+		xsc_core_dbg(xdev, "command block:\n");
+		dump_buf(next->buf, sizeof(struct xsc_cmd_prot_block), offset);
+		offset += sizeof(struct xsc_cmd_prot_block);
+		next = next->next;
+	}
+}
+
+static void cmd_work_handler(struct work_struct *work)
+{
+	struct xsc_cmd_work_ent *ent = container_of(work, struct xsc_cmd_work_ent, work);
+	struct xsc_cmd *cmd = ent->cmd;
+	struct xsc_core_device *xdev = container_of(cmd, struct xsc_core_device, cmd);
+	struct xsc_cmd_layout *lay;
+	struct semaphore *sem;
+	unsigned long flags;
+
+	sem = &cmd->sem;
+	down(sem);
+	ent->idx = alloc_ent(cmd);
+	if (ent->idx < 0) {
+		xsc_core_err(xdev, "failed to allocate command entry\n");
+		up(sem);
+		return;
+	}
+
+	ent->token = alloc_token(cmd);
+	cmd->ent_arr[ent->idx] = ent;
+
+	spin_lock_irqsave(&cmd->doorbell_lock, flags);
+	lay = get_inst(cmd, cmd->cmd_pid);
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
+		set_signature(ent);
+	else
+		lay->sig = 0xff;
+	dump_command(xdev, ent->in->next, ent, 1, ent->in->len);
+
+	ktime_get_ts64(&ent->ts1);
+
+	/* ring doorbell after the descriptor is valid */
+	wmb();
+
+	cmd->cmd_pid = (cmd->cmd_pid + 1) % (1 << cmd->log_sz);
+	writel(cmd->cmd_pid, REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	spin_unlock_irqrestore(&cmd->doorbell_lock, flags);
+
+#ifdef XSC_DEBUG
+	xsc_core_dbg(xdev, "write 0x%x to command doorbell, idx %u\n", cmd->cmd_pid, ent->idx);
+#endif
+}
+
+static const char *deliv_status_to_str(u8 status)
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
+static u16 msg_to_opcode(struct xsc_cmd_msg *in)
+{
+	struct xsc_inbox_hdr *hdr = (struct xsc_inbox_hdr *)(in->first.data);
+
+	return be16_to_cpu(hdr->opcode);
+}
+
+static int wait_func(struct xsc_core_device *xdev, struct xsc_cmd_work_ent *ent)
+{
+	unsigned long timeout = msecs_to_jiffies(XSC_CMD_TIMEOUT_MSEC);
+	int err;
+	struct xsc_cmd *cmd = &xdev->cmd;
+
+	if (!wait_for_completion_timeout(&ent->done, timeout))
+		err = -ETIMEDOUT;
+	else
+		err = ent->ret;
+
+	if (err == -ETIMEDOUT) {
+		cmd->cmd_status = XSC_CMD_STATUS_TIMEDOUT;
+		xsc_core_warn(xdev, "wait for %s(0x%x) response timeout!\n",
+			      xsc_command_str(msg_to_opcode(ent->in)),
+			      msg_to_opcode(ent->in));
+	} else if (err) {
+		xsc_core_dbg(xdev, "err %d, delivery status %s(%d)\n", err,
+			     deliv_status_to_str(ent->status), ent->status);
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
+	ktime_t t1, t2, delta;
+	struct xsc_cmd_stats *stats;
+	int err = 0;
+	s64 ds;
+	u16 op;
+	struct semaphore *sem;
+
+	ent = alloc_cmd(cmd, in, out);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);
+
+	init_completion(&ent->done);
+	INIT_WORK(&ent->work, cmd_work_handler);
+	if (!queue_work(cmd->wq, &ent->work)) {
+		xsc_core_warn(xdev, "failed to queue work\n");
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	err = wait_func(xdev, ent);
+	if (err == -ETIMEDOUT)
+		goto out;
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
+	xsc_core_dbg_mask(xdev, 1 << XSC_CMD_TIME,
+			  "fw exec time for %s is %lld nsec\n",
+			  xsc_command_str(op), ds);
+	*status = ent->status;
+	free_cmd(ent);
+
+	return err;
+
+out:
+	sem = &cmd->sem;
+	up(sem);
+out_free:
+	free_cmd(ent);
+	return err;
+}
+
+static ssize_t dbg_write(struct file *filp, const char __user *buf,
+			 size_t count, loff_t *pos)
+{
+	struct xsc_core_device *xdev = filp->private_data;
+	struct xsc_cmd_debug *dbg = &xdev->cmd.dbg;
+	char lbuf[3];
+	int err;
+
+	if (!dbg->in_msg || !dbg->out_msg)
+		return -ENOMEM;
+
+	if (copy_from_user(lbuf, buf, sizeof(lbuf)))
+		return -EPERM;
+
+	lbuf[sizeof(lbuf) - 1] = 0;
+
+	if (strcmp(lbuf, "go"))
+		return -EINVAL;
+
+	err = xsc_cmd_exec(xdev, dbg->in_msg, dbg->inlen, dbg->out_msg, dbg->outlen);
+
+	return err ? err : count;
+}
+
+static const struct file_operations fops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.write	= dbg_write,
+};
+
+static int xsc_copy_to_cmd_msg(struct xsc_cmd_msg *to, void *from, int size)
+{
+	struct xsc_cmd_prot_block *block;
+	struct xsc_cmd_mailbox *next;
+	int copy;
+
+	if (!to || !from)
+		return -ENOMEM;
+
+	copy = min_t(int, size, sizeof(to->first.data));
+	memcpy(to->first.data, from, copy);
+	size -= copy;
+	from += copy;
+
+	next = to->next;
+	while (size) {
+		if (!next) {
+			/* this is a BUG */
+			return -ENOMEM;
+		}
+
+		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);
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
+static int xsc_copy_from_rsp_msg(void *to, struct xsc_rsp_msg *from, int size)
+{
+	struct xsc_cmd_prot_block *block;
+	struct xsc_cmd_mailbox *next;
+	int copy;
+
+	if (!to || !from)
+		return -ENOMEM;
+
+	copy = min_t(int, size, sizeof(from->first.data));
+	memcpy(to, from->first.data, copy);
+	size -= copy;
+	to += copy;
+
+	next = from->next;
+	while (size) {
+		if (!next) {
+			/* this is a BUG */
+			return -ENOMEM;
+		}
+
+		copy = min_t(int, size, XSC_CMD_DATA_BLOCK_SIZE);
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
+static struct xsc_cmd_mailbox *alloc_cmd_box(struct xsc_core_device *xdev,
+					     gfp_t flags)
+{
+	struct xsc_cmd_mailbox *mailbox;
+
+	mailbox = kmalloc(sizeof(*mailbox), flags);
+	if (!mailbox)
+		return ERR_PTR(-ENOMEM);
+
+	mailbox->buf = dma_pool_alloc(xdev->cmd.pool, flags,
+				      &mailbox->dma);
+	if (!mailbox->buf) {
+		xsc_core_dbg(xdev, "failed allocation\n");
+		kfree(mailbox);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(mailbox->buf, 0, sizeof(struct xsc_cmd_prot_block));
+	mailbox->next = NULL;
+
+	return mailbox;
+}
+
+static void free_cmd_box(struct xsc_core_device *xdev,
+			 struct xsc_cmd_mailbox *mailbox)
+{
+	dma_pool_free(xdev->cmd.pool, mailbox->buf, mailbox->dma);
+
+	kfree(mailbox);
+}
+
+static struct xsc_cmd_msg *xsc_alloc_cmd_msg(struct xsc_core_device *xdev,
+					     gfp_t flags, int size)
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
+	blen = size - min_t(int, sizeof(msg->first.data), size);
+	n = (blen + XSC_CMD_DATA_BLOCK_SIZE - 1) / XSC_CMD_DATA_BLOCK_SIZE;
+
+	for (i = 0; i < n; i++) {
+		tmp = alloc_cmd_box(xdev, flags);
+		if (IS_ERR(tmp)) {
+			xsc_core_warn(xdev, "failed allocating block\n");
+			err = PTR_ERR(tmp);
+			goto err_alloc;
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
+err_alloc:
+	while (head) {
+		tmp = head->next;
+		free_cmd_box(xdev, head);
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
+		free_cmd_box(xdev, head);
+		head = next;
+	}
+	kfree(msg);
+}
+
+static struct xsc_rsp_msg *xsc_alloc_rsp_msg(struct xsc_core_device *xdev,
+					     gfp_t flags, int size)
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
+		tmp = alloc_cmd_box(xdev, flags);
+		if (IS_ERR(tmp)) {
+			xsc_core_warn(xdev, "failed allocating block\n");
+			err = PTR_ERR(tmp);
+			goto err_alloc;
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
+err_alloc:
+	while (head) {
+		tmp = head->next;
+		free_cmd_box(xdev, head);
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
+		free_cmd_box(xdev, head);
+		head = next;
+	}
+	kfree(msg);
+}
+
+static ssize_t data_write(struct file *filp, const char __user *buf,
+			  size_t count, loff_t *pos)
+{
+	struct xsc_core_device *xdev = filp->private_data;
+	struct xsc_cmd_debug *dbg = &xdev->cmd.dbg;
+	void *ptr;
+	int err;
+
+	if (*pos != 0)
+		return -EINVAL;
+
+	kfree(dbg->in_msg);
+	dbg->in_msg = NULL;
+	dbg->inlen = 0;
+
+	ptr = kzalloc(count, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	if (copy_from_user(ptr, buf, count)) {
+		err = -EPERM;
+		goto out;
+	}
+	dbg->in_msg = ptr;
+	dbg->inlen = count;
+
+	*pos = count;
+
+	return count;
+
+out:
+	kfree(ptr);
+	return err;
+}
+
+static ssize_t data_read(struct file *filp, char __user *buf, size_t count,
+			 loff_t *pos)
+{
+	struct xsc_core_device *xdev = filp->private_data;
+	struct xsc_cmd_debug *dbg = &xdev->cmd.dbg;
+	int copy;
+
+	if (*pos)
+		return 0;
+
+	if (!dbg->out_msg)
+		return -ENOMEM;
+
+	copy = min_t(int, count, dbg->outlen);
+	if (copy_to_user(buf, dbg->out_msg, copy))
+		return -EPERM;
+
+	*pos += copy;
+
+	return copy;
+}
+
+static const struct file_operations dfops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.write	= data_write,
+	.read	= data_read,
+};
+
+static ssize_t outlen_read(struct file *filp, char __user *buf, size_t count,
+			   loff_t *pos)
+{
+	struct xsc_core_device *xdev = filp->private_data;
+	struct xsc_cmd_debug *dbg = &xdev->cmd.dbg;
+	char outlen[8];
+	int err;
+
+	if (*pos)
+		return 0;
+
+	err = snprintf(outlen, sizeof(outlen), "%d", dbg->outlen);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(buf, &outlen, err))
+		return -EPERM;
+
+	*pos += err;
+
+	return err;
+}
+
+static ssize_t outlen_write(struct file *filp, const char __user *buf,
+			    size_t count, loff_t *pos)
+{
+	struct xsc_core_device *xdev = filp->private_data;
+	struct xsc_cmd_debug *dbg = &xdev->cmd.dbg;
+	char outlen_str[8];
+	int outlen;
+	void *ptr;
+	int err;
+
+	if (*pos != 0 || count > 6)
+		return -EINVAL;
+
+	kfree(dbg->out_msg);
+	dbg->out_msg = NULL;
+	dbg->outlen = 0;
+
+	if (copy_from_user(outlen_str, buf, count))
+		return -EPERM;
+
+	outlen_str[7] = 0;
+
+	err = kstrtoint(outlen_str, 10, &outlen);
+	if (err < 0)
+		return err;
+
+	ptr = kzalloc(outlen, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	dbg->out_msg = ptr;
+	dbg->outlen = outlen;
+
+	*pos = count;
+
+	return count;
+}
+
+static const struct file_operations olfops = {
+	.owner	= THIS_MODULE,
+	.open	= simple_open,
+	.write	= outlen_write,
+	.read	= outlen_read,
+};
+
+static void set_wqname(struct xsc_core_device *xdev)
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
+	cmd->mode = CMD_MODE_EVENTS;
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
+static int cmd_cq_polling(void *data);
+void xsc_cmd_use_polling(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	int i;
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		down(&cmd->sem);
+
+	flush_workqueue(cmd->wq);
+	cmd->mode = CMD_MODE_POLLING;
+	cmd->cq_task = kthread_create(cmd_cq_polling, (void *)xdev, "xsc_cmd_cq_polling");
+	if (cmd->cq_task)
+		wake_up_process(cmd->cq_task);
+
+	for (i = 0; i < cmd->max_reg_cmds; i++)
+		up(&cmd->sem);
+}
+
+static int status_to_err(u8 status)
+{
+	return status ? -1 : 0; /* TBD more meaningful codes */
+}
+
+static struct xsc_cmd_msg *alloc_msg(struct xsc_core_device *xdev, int in_size)
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
+static void free_msg(struct xsc_core_device *xdev, struct xsc_cmd_msg *msg)
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
+static int dummy_work(struct xsc_core_device *xdev, struct xsc_cmd_msg *in,
+		      struct xsc_rsp_msg *out, u16 dummy_cnt, u16 dummy_start_pid)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_work_ent **dummy_ent_arr;
+	struct xsc_cmd_layout *lay;
+	struct semaphore *sem;
+	int err = 0;
+	u16 i;
+	u16 free_cnt = 0;
+	u16 temp_pid = dummy_start_pid;
+
+	sem = &cmd->sem;
+
+	dummy_ent_arr = kcalloc(dummy_cnt, sizeof(struct xsc_cmd_work_ent *), GFP_KERNEL);
+	if (!dummy_ent_arr) {
+		err = -ENOMEM;
+		goto alloc_ent_arr_err;
+	}
+
+	for (i = 0; i < dummy_cnt; i++) {
+		dummy_ent_arr[i] = alloc_cmd(cmd, in, out);
+		if (IS_ERR(dummy_ent_arr[i])) {
+			xsc_core_err(xdev, "failed to alloc cmd buffer\n");
+			err = -ENOMEM;
+			free_cnt = i;
+			goto alloc_ent_err;
+		}
+
+		down(sem);
+
+		dummy_ent_arr[i]->idx = alloc_ent(cmd);
+		if (dummy_ent_arr[i]->idx < 0) {
+			xsc_core_err(xdev, "failed to allocate command entry\n");
+			err = -1;
+			free_cnt = i;
+			goto get_cmd_ent_idx_err;
+		}
+		dummy_ent_arr[i]->token = alloc_token(cmd);
+		cmd->ent_arr[dummy_ent_arr[i]->idx] = dummy_ent_arr[i];
+		init_completion(&dummy_ent_arr[i]->done);
+
+		lay = get_inst(cmd, temp_pid);
+		dummy_ent_arr[i]->lay = lay;
+		memset(lay, 0, sizeof(*lay));
+		memcpy(lay->in, dummy_ent_arr[i]->in->first.data, sizeof(dummy_ent_arr[i]->in));
+		lay->inlen = cpu_to_be32(dummy_ent_arr[i]->in->len);
+		lay->outlen = cpu_to_be32(dummy_ent_arr[i]->out->len);
+		lay->type = XSC_PCI_CMD_XPORT;
+		lay->token = dummy_ent_arr[i]->token;
+		lay->idx = dummy_ent_arr[i]->idx;
+		if (!cmd->checksum_disabled)
+			set_signature(dummy_ent_arr[i]);
+		else
+			lay->sig = 0xff;
+		temp_pid = (temp_pid + 1) % (1 << cmd->log_sz);
+	}
+
+	/* ring doorbell after the descriptor is valid */
+	wmb();
+	writel(cmd->cmd_pid, REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	if (readl(REG_ADDR(xdev, cmd->reg.interrupt_stat_addr)) != 0)
+		writel(0xF, REG_ADDR(xdev, cmd->reg.interrupt_stat_addr));
+
+	xsc_core_dbg(xdev, "write 0x%x to command doorbell, idx %u ~ %u\n", cmd->cmd_pid,
+		     dummy_ent_arr[0]->idx, dummy_ent_arr[dummy_cnt - 1]->idx);
+
+	if (wait_for_completion_timeout(&dummy_ent_arr[dummy_cnt - 1]->done,
+					msecs_to_jiffies(3000)) == 0) {
+		xsc_core_err(xdev, "dummy_cmd %d ent timeout, cmdq fail\n", dummy_cnt - 1);
+		err = -ETIMEDOUT;
+	} else {
+		xsc_core_dbg(xdev, "%d ent done\n", dummy_cnt);
+	}
+
+	for (i = 0; i < dummy_cnt; i++)
+		free_cmd(dummy_ent_arr[i]);
+
+	kfree(dummy_ent_arr);
+	return err;
+
+get_cmd_ent_idx_err:
+	free_cmd(dummy_ent_arr[free_cnt]);
+	up(sem);
+alloc_ent_err:
+	for (i = 0; i < free_cnt; i++) {
+		free_ent(cmd, dummy_ent_arr[i]->idx);
+		up(sem);
+		free_cmd(dummy_ent_arr[i]);
+	}
+	kfree(dummy_ent_arr);
+alloc_ent_arr_err:
+	return err;
+}
+
+static int xsc_dummy_cmd_exec(struct xsc_core_device *xdev, void *in, int in_size, void *out,
+			      int out_size, u16 dmmy_cnt, u16 dummy_start)
+{
+	struct xsc_cmd_msg *inb;
+	struct xsc_rsp_msg *outb;
+	int err;
+
+	inb = alloc_msg(xdev, in_size);
+	if (IS_ERR(inb)) {
+		err = PTR_ERR(inb);
+		return err;
+	}
+
+	err = xsc_copy_to_cmd_msg(inb, in, in_size);
+	if (err) {
+		xsc_core_warn(xdev, "err %d\n", err);
+		goto out_in;
+	}
+
+	outb = xsc_alloc_rsp_msg(xdev, GFP_KERNEL, out_size);
+	if (IS_ERR(outb)) {
+		err = PTR_ERR(outb);
+		goto out_in;
+	}
+
+	err = dummy_work(xdev, inb, outb, dmmy_cnt, dummy_start);
+
+	if (err)
+		goto out_out;
+
+	err = xsc_copy_from_rsp_msg(out, outb, out_size);
+
+out_out:
+	xsc_free_rsp_msg(xdev, outb);
+
+out_in:
+	free_msg(xdev, inb);
+	return err;
+}
+
+static int xsc_send_dummy_cmd(struct xsc_core_device *xdev, u16 gap, u16 dummy_start)
+{
+	struct xsc_cmd_dummy_mbox_out *out;
+	struct xsc_cmd_dummy_mbox_in in;
+	int err;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out) {
+		err = -ENOMEM;
+		goto no_mem_out;
+	}
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DUMMY);
+
+	err = xsc_dummy_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out), gap, dummy_start);
+	if (err)
+		goto out_out;
+
+	if (out->hdr.status) {
+		err = xsc_cmd_status_to_err(&out->hdr);
+		goto out_out;
+	}
+
+out_out:
+	kfree(out);
+no_mem_out:
+	return err;
+}
+
+static int request_pid_cid_mismatch_restore(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	u16 req_pid, req_cid;
+	u16 gap;
+
+	int err;
+
+	req_pid = readl(REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	req_cid = readl(REG_ADDR(xdev, cmd->reg.req_cid_addr));
+	if (req_pid >= (1 << cmd->log_sz) || req_cid >= (1 << cmd->log_sz)) {
+		xsc_core_err(xdev, "req_pid %d, req_cid %d, out of normal range!!! max value is %d\n",
+			     req_pid, req_cid, (1 << cmd->log_sz));
+		return -1;
+	}
+
+	if (req_pid == req_cid)
+		return 0;
+
+	gap = (req_pid > req_cid) ? (req_pid - req_cid) : ((1 << cmd->log_sz) + req_pid - req_cid);
+	xsc_core_info(xdev, "Cmdq req_pid %d, req_cid %d, send %d dummy cmds\n",
+		      req_pid, req_cid, gap);
+
+	err = xsc_send_dummy_cmd(xdev, gap, req_cid);
+	if (err) {
+		xsc_core_err(xdev, "Send dummy cmd failed\n");
+		goto send_dummy_fail;
+	}
+
+send_dummy_fail:
+	return err;
+}
+
+static int _xsc_cmd_exec(struct xsc_core_device *xdev, void *in, int in_size, void *out,
+			 int out_size)
+{
+	struct xsc_cmd_msg *inb;
+	struct xsc_rsp_msg *outb;
+	int err;
+	u8 status = 0;
+	struct xsc_cmd *cmd = &xdev->cmd;
+
+	if (cmd->cmd_status == XSC_CMD_STATUS_TIMEDOUT)
+		return -ETIMEDOUT;
+
+	inb = alloc_msg(xdev, in_size);
+	if (IS_ERR(inb)) {
+		err = PTR_ERR(inb);
+		return err;
+	}
+
+	err = xsc_copy_to_cmd_msg(inb, in, in_size);
+	if (err) {
+		xsc_core_warn(xdev, "err %d\n", err);
+		goto out_in;
+	}
+
+	outb = xsc_alloc_rsp_msg(xdev, GFP_KERNEL, out_size);
+	if (IS_ERR(outb)) {
+		err = PTR_ERR(outb);
+		goto out_in;
+	}
+
+	err = xsc_cmd_invoke(xdev, inb, outb, &status);
+	if (err)
+		goto out_out;
+
+	if (status) {
+		xsc_core_err(xdev, "opcode:%#x, err %d, status %d\n",
+			     msg_to_opcode(inb), err, status);
+		err = status_to_err(status);
+		goto out_out;
+	}
+
+	err = xsc_copy_from_rsp_msg(out, outb, out_size);
+
+out_out:
+	xsc_free_rsp_msg(xdev, outb);
+
+out_in:
+	free_msg(xdev, inb);
+	return err;
+}
+
+int xsc_cmd_exec(struct xsc_core_device *dev, void *in, int in_size, void *out,
+		 int out_size)
+{
+	struct xsc_inbox_hdr *hdr = (struct xsc_inbox_hdr *)in;
+
+	hdr->ver = 0;
+	if (hdr->ver != 0) {
+		xsc_core_warn(dev, "recv an unexpected cmd ver = %d, opcode = %d\n",
+			      be16_to_cpu(hdr->ver), be16_to_cpu(hdr->opcode));
+		WARN_ON(hdr->ver != 0);
+	}
+
+	return _xsc_cmd_exec(dev, in, in_size, out, out_size);
+}
+EXPORT_SYMBOL(xsc_cmd_exec);
+
+static void destroy_msg_cache(struct xsc_core_device *xdev)
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
+static int create_msg_cache(struct xsc_core_device *xdev)
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
+			goto ex_err;
+		}
+		msg->cache = &cmd->cache.large;
+		list_add_tail(&msg->list, &cmd->cache.large.head);
+	}
+
+	for (i = 0; i < NUM_MED_LISTS; i++) {
+		msg = xsc_alloc_cmd_msg(xdev, GFP_KERNEL, MED_LIST_SIZE);
+		if (IS_ERR(msg)) {
+			err = PTR_ERR(msg);
+			goto ex_err;
+		}
+		msg->cache = &cmd->cache.med;
+		list_add_tail(&msg->list, &cmd->cache.med.head);
+	}
+
+	return 0;
+
+ex_err:
+	destroy_msg_cache(xdev);
+	return err;
+}
+
+static void xsc_cmd_comp_handler(struct xsc_core_device *xdev, u8 idx, struct xsc_rsp_layout *rsp)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_cmd_work_ent *ent;
+	struct xsc_inbox_hdr *hdr;
+
+	if (idx > cmd->max_reg_cmds || (cmd->bitmask & (1 << idx))) {
+		xsc_core_err(xdev, "idx[%d] exceed max cmds, or has no relative request.\n", idx);
+		return;
+	}
+	ent = cmd->ent_arr[idx];
+	ent->rsp_lay = rsp;
+	ktime_get_ts64(&ent->ts2);
+
+	memcpy(ent->out->first.data, ent->rsp_lay->out, sizeof(ent->rsp_lay->out));
+	dump_command(xdev, ent->out->next, ent, 0, ent->out->len);
+	if (!cmd->checksum_disabled)
+		ent->ret = verify_signature(ent);
+	else
+		ent->ret = 0;
+	ent->status = 0;
+
+	hdr = (struct xsc_inbox_hdr *)ent->in->first.data;
+	xsc_core_dbg(xdev, "delivery status:%s(%d), rsp status=%d, opcode %#x, idx:%d,%d, ret=%d\n",
+		     deliv_status_to_str(ent->status), ent->status,
+		     ((struct xsc_outbox_hdr *)ent->rsp_lay->out)->status,
+		     __be16_to_cpu(hdr->opcode), idx, ent->lay->idx, ent->ret);
+	free_ent(cmd, ent->idx);
+	complete(&ent->done);
+	up(&cmd->sem);
+}
+
+static int cmd_cq_polling(void *data)
+{
+	struct xsc_core_device *xdev = data;
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_rsp_layout *rsp;
+	u32 cq_pid;
+
+	while (!kthread_should_stop()) {
+		if (need_resched())
+			schedule();
+		cq_pid = readl(REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+		if (cmd->cq_cid == cq_pid) {
+#ifdef COSIM
+			mdelay(1000);
+#else
+			mdelay(3);
+#endif
+			continue;
+		}
+
+		//get cqe
+		rsp = get_cq_inst(cmd, cmd->cq_cid);
+		if (!cmd->ownerbit_learned) {
+			cmd->ownerbit_learned = 1;
+			cmd->owner_bit = rsp->owner_bit;
+		}
+		if (cmd->owner_bit != rsp->owner_bit) {
+			//hw update cq doorbell but buf may not ready
+			xsc_core_err(xdev, "hw update cq doorbell but buf not ready %u %u\n",
+				     cmd->cq_cid, cq_pid);
+			continue;
+		}
+
+		xsc_cmd_comp_handler(xdev, rsp->idx, rsp);
+
+		cmd->cq_cid = (cmd->cq_cid + 1) % (1 << cmd->log_sz);
+
+		writel(cmd->cq_cid, REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+		if (cmd->cq_cid == 0)
+			cmd->owner_bit = !cmd->owner_bit;
+	}
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
+	int err = 0;
+	int retry = 0;
+
+	stat.raw = readl(REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	while (stat.raw != 0) {
+		err++;
+		if (stat.hw_read_req_err) {
+			retry = 1;
+			stat.hw_read_req_err = 0;
+			xsc_core_err(xdev, "hw report read req from host failed!\n");
+		} else if (stat.hw_write_req_err) {
+			retry = 1;
+			stat.hw_write_req_err = 0;
+			xsc_core_err(xdev, "hw report write req to fw failed!\n");
+		} else if (stat.req_pid_err) {
+			stat.req_pid_err = 0;
+			xsc_core_err(xdev, "hw report unexpected req pid!\n");
+		} else if (stat.rsp_cid_err) {
+			stat.rsp_cid_err = 0;
+			xsc_core_err(xdev, "hw report unexpected rsp cid!\n");
+		} else {
+			stat.raw = 0;
+			xsc_core_err(xdev, "ignore unknown interrupt!\n");
+		}
+	}
+
+	if (retry)
+		writel(xdev->cmd.cmd_pid, REG_ADDR(xdev, xdev->cmd.reg.req_pid_addr));
+
+	if (err)
+		writel(0xf, REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+
+	return err;
+}
+
+void xsc_cmd_resp_handler(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+	struct xsc_rsp_layout *rsp;
+	u32 cq_pid;
+	const int budget = 32;
+	int count = 0;
+
+	while (count < budget) {
+		cq_pid = readl(REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+		if (cq_pid == cmd->cq_cid)
+			return;
+
+		rsp = get_cq_inst(cmd, cmd->cq_cid);
+		if (!cmd->ownerbit_learned) {
+			cmd->ownerbit_learned = 1;
+			cmd->owner_bit = rsp->owner_bit;
+		}
+		if (cmd->owner_bit != rsp->owner_bit) {
+			xsc_core_err(xdev, "hw update cq doorbell but buf not ready %u %u\n",
+				     cmd->cq_cid, cq_pid);
+			return;
+		}
+
+		xsc_cmd_comp_handler(xdev, rsp->idx, rsp);
+
+		cmd->cq_cid = (cmd->cq_cid + 1) % (1 << cmd->log_sz);
+		writel(cmd->cq_cid, REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
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
+	rsp_pid = readl(REG_ADDR(xdev, cmd->reg.rsp_pid_addr));
+	rsp_cid = readl(REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+	if (rsp_pid == rsp_cid)
+		return;
+
+	cmd->cq_cid = rsp_pid;
+
+	writel(cmd->cq_cid, REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+}
+
+int xsc_cmd_init(struct xsc_core_device *xdev)
+{
+	int size = sizeof(struct xsc_cmd_prot_block);
+	int align = roundup_pow_of_two(size);
+	struct xsc_cmd *cmd = &xdev->cmd;
+	u32 cmd_h, cmd_l;
+	u32 err_stat;
+	int err;
+	int i;
+
+	//sriov need adapt for this process.
+	//now there is 544 cmdq resource, soc using from id 514
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
+	cmd->pool = dma_pool_create("xsc_cmd", &xdev->pdev->dev, size, align, 0);
+
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
+		goto err_free;
+	}
+
+	cmd->cq_dma = dma_map_single(&xdev->pdev->dev, cmd->cq_buf, PAGE_SIZE,
+				     DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&xdev->pdev->dev, cmd->cq_dma)) {
+		err = -ENOMEM;
+		goto err_map_cmd;
+	}
+
+	cmd->cmd_pid = readl(REG_ADDR(xdev, cmd->reg.req_pid_addr));
+	cmd->cq_cid = readl(REG_ADDR(xdev, cmd->reg.rsp_cid_addr));
+	cmd->ownerbit_learned = 0;
+
+	xsc_cmd_handle_rsp_before_reload(cmd, xdev);
+
+#define ELEMENT_SIZE_LOG 6 //64B
+#define Q_DEPTH_LOG	5 //32
+
+	cmd->log_sz = Q_DEPTH_LOG;
+	cmd->log_stride = readl(REG_ADDR(xdev, cmd->reg.element_sz_addr));
+	writel(1 << cmd->log_sz, REG_ADDR(xdev, cmd->reg.q_depth_addr));
+	if (cmd->log_stride != ELEMENT_SIZE_LOG) {
+		dev_err(&xdev->pdev->dev, "firmware failed to init cmdq, log_stride=(%d, %d)\n",
+			cmd->log_stride, ELEMENT_SIZE_LOG);
+		err = -ENODEV;
+		goto err_map;
+	}
+
+	if (1 << cmd->log_sz > XSC_MAX_COMMANDS) {
+		dev_err(&xdev->pdev->dev, "firmware reports too many outstanding commands %d\n",
+			1 << cmd->log_sz);
+		err = -EINVAL;
+		goto err_map;
+	}
+
+	if (cmd->log_sz + cmd->log_stride > PAGE_SHIFT) {
+		dev_err(&xdev->pdev->dev, "command queue size overflow\n");
+		err = -EINVAL;
+		goto err_map;
+	}
+
+	cmd->checksum_disabled = 1;
+	cmd->max_reg_cmds = (1 << cmd->log_sz) - 1;
+	cmd->bitmask = (1 << cmd->max_reg_cmds) - 1;
+
+	spin_lock_init(&cmd->alloc_lock);
+	spin_lock_init(&cmd->token_lock);
+	spin_lock_init(&cmd->doorbell_lock);
+	for (i = 0; i < ARRAY_SIZE(cmd->stats); i++)
+		spin_lock_init(&cmd->stats[i].lock);
+
+	sema_init(&cmd->sem, cmd->max_reg_cmds);
+
+	cmd_h = (u32)((u64)(cmd->dma) >> 32);
+	cmd_l = (u32)(cmd->dma);
+	if (cmd_l & 0xfff) {
+		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_map;
+	}
+
+	writel(cmd_h, REG_ADDR(xdev, cmd->reg.req_buf_h_addr));
+	writel(cmd_l, REG_ADDR(xdev, cmd->reg.req_buf_l_addr));
+
+	cmd_h = (u32)((u64)(cmd->cq_dma) >> 32);
+	cmd_l = (u32)(cmd->cq_dma);
+	if (cmd_l & 0xfff) {
+		dev_err(&xdev->pdev->dev, "invalid command queue address\n");
+		err = -ENOMEM;
+		goto err_map;
+	}
+	writel(cmd_h, REG_ADDR(xdev, cmd->reg.rsp_buf_h_addr));
+	writel(cmd_l, REG_ADDR(xdev, cmd->reg.rsp_buf_l_addr));
+
+	/* Make sure firmware sees the complete address before we proceed */
+	wmb();
+
+	xsc_core_dbg(xdev, "descriptor at dma 0x%llx 0x%llx\n",
+		     (unsigned long long)(cmd->dma), (unsigned long long)(cmd->cq_dma));
+
+	cmd->mode = CMD_MODE_POLLING;
+	cmd->cmd_status = XSC_CMD_STATUS_NORMAL;
+
+	err = create_msg_cache(xdev);
+	if (err) {
+		dev_err(&xdev->pdev->dev, "failed to create command cache\n");
+		goto err_map;
+	}
+
+	set_wqname(xdev);
+	cmd->wq = create_singlethread_workqueue(cmd->wq_name);
+	if (!cmd->wq) {
+		dev_err(&xdev->pdev->dev, "failed to create command workqueue\n");
+		err = -ENOMEM;
+		goto err_cache;
+	}
+
+	cmd->cq_task = kthread_create(cmd_cq_polling, (void *)xdev, "xsc_cmd_cq_polling");
+	if (!cmd->cq_task) {
+		dev_err(&xdev->pdev->dev, "failed to create cq task\n");
+		err = -ENOMEM;
+		goto err_wq;
+	}
+	wake_up_process(cmd->cq_task);
+
+	err = request_pid_cid_mismatch_restore(xdev);
+	if (err) {
+		dev_err(&xdev->pdev->dev, "request pid,cid wrong, restore failed\n");
+		goto err_req_restore;
+	}
+
+	// clear abnormal state to avoid the impact of previous error
+	err_stat = readl(REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	if (err_stat) {
+		xsc_core_warn(xdev, "err_stat 0x%x when initializing, clear it\n", err_stat);
+		writel(0xf, REG_ADDR(xdev, xdev->cmd.reg.interrupt_stat_addr));
+	}
+
+	return 0;
+
+err_req_restore:
+	kthread_stop(cmd->cq_task);
+
+err_wq:
+	destroy_workqueue(cmd->wq);
+
+err_cache:
+	destroy_msg_cache(xdev);
+
+err_map:
+	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+
+err_map_cmd:
+	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+err_free:
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
+EXPORT_SYMBOL(xsc_cmd_init);
+
+void xsc_cmd_cleanup(struct xsc_core_device *xdev)
+{
+	struct xsc_cmd *cmd = &xdev->cmd;
+
+	destroy_workqueue(cmd->wq);
+	if (cmd->cq_task)
+		kthread_stop(cmd->cq_task);
+	destroy_msg_cache(xdev);
+	dma_unmap_single(&xdev->pdev->dev, cmd->dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+	free_pages((unsigned long)cmd->cq_buf, 0);
+	dma_unmap_single(&xdev->pdev->dev, cmd->cq_dma, PAGE_SIZE,
+			 DMA_BIDIRECTIONAL);
+	free_pages((unsigned long)cmd->cmd_buf, 0);
+	dma_pool_destroy(cmd->pool);
+}
+EXPORT_SYMBOL(xsc_cmd_cleanup);
+
+int xsc_cmd_version_check(struct xsc_core_device *dev)
+{
+	struct xsc_cmd_query_cmdq_ver_mbox_out *out;
+	struct xsc_cmd_query_cmdq_ver_mbox_in in;
+
+	int err;
+
+	out = kzalloc(sizeof(*out), GFP_KERNEL);
+	if (!out) {
+		err = -ENOMEM;
+		goto no_mem_out;
+	}
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_CMDQ_VERSION);
+
+	err = xsc_cmd_exec(dev, &in, sizeof(in), out, sizeof(*out));
+	if (err)
+		goto out_out;
+
+	if (out->hdr.status) {
+		err = xsc_cmd_status_to_err(&out->hdr);
+		goto out_out;
+	}
+
+	if (be16_to_cpu(out->cmdq_ver) != CMDQ_VERSION) {
+		xsc_core_err(dev, "cmdq version check failed, expecting version %d, actual version %d\n",
+			     CMDQ_VERSION, be16_to_cpu(out->cmdq_ver));
+		err = -EINVAL;
+		goto out_out;
+	}
+	dev->cmdq_ver = CMDQ_VERSION;
+
+out_out:
+	kfree(out);
+no_mem_out:
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
index 1d26ffa8d..1123832f7 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -4,6 +4,12 @@
  */
 
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
+
+unsigned int xsc_debug_mask;
+module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
+MODULE_PARM_DESC(debug_mask,
+		 "debug mask: 1=dump cmd data, 2=dump cmd exec time, 3=both. Default=0");
 
 unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
 module_param_named(log_level, xsc_log_level, uint, 0644);
@@ -195,6 +201,87 @@ static void xsc_core_dev_cleanup(struct xsc_core_device *dev)
 	xsc_dev_res_cleanup(dev);
 }
 
+static int xsc_hw_setup(struct xsc_core_device *dev)
+{
+	int err;
+
+	err = xsc_cmd_init(dev);
+	if (err) {
+		xsc_core_err(dev, "Failed initializing command interface, aborting\n");
+		goto err_cmd_init;
+	}
+
+	err = xsc_cmd_version_check(dev);
+	if (err) {
+		xsc_core_err(dev, "Failed to check cmdq version\n");
+		goto err_cmdq_ver_chk;
+	}
+
+	return 0;
+err_cmdq_ver_chk:
+	xsc_cmd_cleanup(dev);
+err_cmd_init:
+	return err;
+}
+
+static int xsc_hw_cleanup(struct xsc_core_device *dev)
+{
+	xsc_cmd_cleanup(dev);
+
+	return 0;
+}
+
+static int xsc_load(struct xsc_core_device *dev)
+{
+	int err = 0;
+
+	mutex_lock(&dev->intf_state_mutex);
+	if (test_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state)) {
+		xsc_core_warn(dev, "interface is up, NOP\n");
+		goto out;
+	}
+
+	if (test_bit(XSC_INTERFACE_STATE_TEARDOWN, &dev->intf_state)) {
+		xsc_core_warn(dev, "device is being removed, stop load\n");
+		err = -ENODEV;
+		goto out;
+	}
+
+	err = xsc_hw_setup(dev);
+	if (err) {
+		xsc_core_err(dev, "xsc_hw_setup failed %d\n", err);
+		goto out;
+	}
+
+	set_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
+	mutex_unlock(&dev->intf_state_mutex);
+
+	return 0;
+out:
+	mutex_unlock(&dev->intf_state_mutex);
+	return err;
+}
+
+static int xsc_unload(struct xsc_core_device *dev)
+{
+	mutex_lock(&dev->intf_state_mutex);
+	if (!test_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state)) {
+		xsc_core_warn(dev, "%s: interface is down, NOP\n",
+			      __func__);
+		xsc_hw_cleanup(dev);
+		goto out;
+	}
+
+	clear_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
+
+	xsc_hw_cleanup(dev);
+
+out:
+	mutex_unlock(&dev->intf_state_mutex);
+
+	return 0;
+}
+
 static int xsc_pci_probe(struct pci_dev *pci_dev,
 			 const struct pci_device_id *id)
 {
@@ -223,7 +310,15 @@ static int xsc_pci_probe(struct pci_dev *pci_dev,
 		goto err_dev_init;
 	}
 
+	err = xsc_load(xdev);
+	if (err) {
+		xsc_core_err(xdev, "xsc_load failed %d\n", err);
+		goto err_load;
+	}
+
 	return 0;
+err_load:
+	xsc_core_dev_cleanup(xdev);
 err_dev_init:
 	xsc_pci_fini(xdev);
 err_pci_init:
@@ -237,6 +332,7 @@ static void xsc_pci_remove(struct pci_dev *pci_dev)
 {
 	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
 
+	xsc_unload(xdev);
 	xsc_core_dev_cleanup(xdev);
 	xsc_pci_fini(xdev);
 	pci_set_drvdata(pci_dev, NULL);
-- 
2.43.0

