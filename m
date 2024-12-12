Return-Path: <netdev+bounces-151358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C749EE57D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252211611AE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3F212B01;
	Thu, 12 Dec 2024 11:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE81211A20;
	Thu, 12 Dec 2024 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004291; cv=none; b=SEvirMpvaO1GX7FwxNWYjm4rjwuiYzRj8k5ER5Y2AoKq3vrHey4Rdro0bHVF6uWTncuJVwwFhQprOQdOg1dhUQ7CXTwp8INqbpRw/zTJ/VqeYIEYxP3d91Z9iKCCZaUiCpwV4f5YQTOGDlse5ZuY/tuqfYHvmik6oo+N/+wI7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004291; c=relaxed/simple;
	bh=xH4oEUrk42vhYbJLGKCEN/WHH65e5CdQaYaV07K6xCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtLiKRuW+SO1rtcOMKFKYw99BpqydgRogewYvRqiNEPll8raWiaNC31o4ahuaVLZVB+wFOkaXJoYdQac+ef1wcGh+u3v3WxnOfWLu8YtcsuDS2vXqQV6xp2TRJ1HYOcm1clSEVxMz3sqeJgc3y5ZdodxdPejgIuyHlcPJu38y7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y89l76Ls6z6LDg2;
	Thu, 12 Dec 2024 19:50:27 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E7B4140A86;
	Thu, 12 Dec 2024 19:51:23 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 12:51:13 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: [RFC net-next v02 2/3] net: hinic3: management interfaces
Date: Thu, 12 Dec 2024 14:04:16 +0200
Message-ID: <69c6b929a91a199500eaee1650ad9dc99224022b.1733990727.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733990727.git.gur.stavi@huawei.com>
References: <cover.1733990727.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

From: gongfan <gongfan1@huawei.com>

This is [2/3] part of hinic3 Ethernet driver initial submission.
With this patch hinic3 is a valid kernel module but non-functional driver.

The driver parts contained in this patch:
Mailbox management interface.
Command queue management interface.
Event queues, AEQ and CEQ upon which management relies.
Some of thew IRQ implementation but without full initialization yet.

Submitted-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: gongfan <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   3 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 898 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  | 150 +++
 .../ethernet/huawei/hinic3/hinic3_common.c    |  45 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  74 ++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 786 +++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   | 128 +++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  42 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  43 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 156 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  25 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 172 ++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 831 +++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 131 +++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    | 103 ++
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  12 +
 20 files changed, 3670 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index b80543cff545..423501b87cbd 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -8,14 +8,17 @@ hinic3-objs := hinic3_hwdev.o \
 	       hinic3_common.o \
 	       hinic3_hwif.o \
 	       hinic3_hw_cfg.o \
+	       hinic3_eqs.o \
 	       hinic3_queue_common.o \
 	       hinic3_mbox.o \
 	       hinic3_hw_comm.o \
 	       hinic3_wq.o \
+	       hinic3_cmdq.o \
 	       hinic3_nic_io.o \
 	       hinic3_nic_cfg.o \
 	       hinic3_tx.o \
 	       hinic3_rx.o \
 	       hinic3_netdev_ops.o \
+	       hinic3_irq.o \
 	       hinic3_rss.o \
 	       hinic3_main.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
new file mode 100644
index 000000000000..c5d32e8b1e0f
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -0,0 +1,898 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/dma-mapping.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_cmdq.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_hwif.h"
+
+#define HINIC3_CMDQ_BUF_SIZE  2048U
+#define CMDQ_WQEBB_SIZE       64
+
+#define CMDQ_CMD_TIMEOUT               5000
+#define WAIT_CMDQ_ENABLE_TIMEOUT       300
+
+#define CMDQ_CTXT_CURR_WQE_PAGE_PFN_MASK  GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_EQ_ID_MASK              GENMASK_ULL(60, 53)
+#define CMDQ_CTXT_CEQ_ARM_MASK            BIT_ULL(61)
+#define CMDQ_CTXT_CEQ_EN_MASK             BIT_ULL(62)
+#define CMDQ_CTXT_HW_BUSY_BIT_MASK        BIT_ULL(63)
+
+#define CMDQ_CTXT_WQ_BLOCK_PFN_MASK       GENMASK_ULL(51, 0)
+#define CMDQ_CTXT_CI_MASK                 GENMASK_ULL(63, 52)
+#define CMDQ_CTXT_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTXT_##member##_MASK, val)
+
+#define CMDQ_WQE_HDR_BUFDESC_LEN_MASK        GENMASK(7, 0)
+#define CMDQ_WQE_HDR_COMPLETE_FMT_MASK       BIT(15)
+#define CMDQ_WQE_HDR_DATA_FMT_MASK           BIT(22)
+#define CMDQ_WQE_HDR_COMPLETE_REQ_MASK       BIT(23)
+#define CMDQ_WQE_HDR_COMPLETE_SECT_LEN_MASK  GENMASK(28, 27)
+#define CMDQ_WQE_HDR_CTRL_LEN_MASK           GENMASK(30, 29)
+#define CMDQ_WQE_HDR_HW_BUSY_BIT_MASK        BIT(31)
+#define CMDQ_WQE_HDR_SET(val, member)  \
+	FIELD_PREP(CMDQ_WQE_HDR_##member##_MASK, val)
+#define CMDQ_WQE_HDR_GET(val, member)  \
+	FIELD_GET(CMDQ_WQE_HDR_##member##_MASK, val)
+
+#define CMDQ_CTRL_PI_MASK              GENMASK(15, 0)
+#define CMDQ_CTRL_CMD_MASK             GENMASK(23, 16)
+#define CMDQ_CTRL_MOD_MASK             GENMASK(28, 24)
+#define CMDQ_CTRL_HW_BUSY_BIT_MASK     BIT(31)
+#define CMDQ_CTRL_SET(val, member)  \
+	FIELD_PREP(CMDQ_CTRL_##member##_MASK, val)
+#define CMDQ_CTRL_GET(val, member)  \
+	FIELD_GET(CMDQ_CTRL_##member##_MASK, val)
+
+#define WQE_ERRCODE_VAL_MASK              GENMASK(30, 0)
+#define WQE_ERRCODE_GET(val, member)  \
+	FIELD_GET(WQE_ERRCODE_##member##_MASK, val)
+
+#define CMDQ_DB_INFO_HI_PROD_IDX_MASK  GENMASK(7, 0)
+#define CMDQ_DB_INFO_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_INFO_##member##_MASK, val)
+
+#define CMDQ_DB_HEAD_QUEUE_TYPE_MASK   BIT(23)
+#define CMDQ_DB_HEAD_CMDQ_TYPE_MASK    GENMASK(26, 24)
+#define CMDQ_DB_HEAD_SET(val, member)  \
+	FIELD_PREP(CMDQ_DB_HEAD_##member##_MASK, val)
+
+#define CEQE_CMDQ_TYPE_MASK               GENMASK(2, 0)
+#define CEQE_CMDQ_GET(val, member)  \
+	FIELD_GET(CEQE_CMDQ_##member##_MASK, val)
+
+#define WQE_HEADER(wqe)           ((struct hinic3_cmdq_header *)(wqe))
+#define WQE_COMPLETED(ctrl_info)  CMDQ_CTRL_GET(ctrl_info, HW_BUSY_BIT)
+
+#define CMDQ_PFN(addr)  ((addr) >> 12)
+
+/* cmdq work queue's chip logical address table is up to 512B */
+#define CMDQ_WQ_CLA_SIZE  512
+
+/* Completion codes: send, direct sync, force stop */
+#define CMDQ_SEND_CMPT_CODE         10
+#define CMDQ_DIRECT_SYNC_CMPT_CODE  11
+#define CMDQ_FORCE_STOP_CMPT_CODE   12
+
+enum data_format {
+	DATA_SGE = 0,
+	DATA_DIRECT = 1,
+};
+
+enum ctrl_sect_len {
+	CTRL_SECT_LEN        = 1,
+	CTRL_DIRECT_SECT_LEN = 2,
+};
+
+enum bufdesc_len {
+	BUFDESC_LCMD_LEN = 2,
+	BUFDESC_SCMD_LEN = 3,
+};
+
+enum completion_format {
+	COMPLETE_DIRECT = 0,
+	COMPLETE_SGE    = 1,
+};
+
+enum cmdq_cmd_type {
+	SYNC_CMD_DIRECT_RESP,
+	SYNC_CMD_SGE_RESP,
+};
+
+#define NUM_WQEBBS_FOR_CMDQ_WQE  1
+
+static struct hinic3_cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
+{
+	if (hinic3_wq_get_used(wq) == 0)
+		return NULL;
+
+	*ci = wq->cons_idx & wq->idx_mask;
+	return get_q_element(&wq->qpages, wq->cons_idx, NULL);
+}
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = hwdev->cmdqs;
+
+	cmd_buf = kzalloc(sizeof(*cmd_buf), GFP_ATOMIC);
+	if (!cmd_buf)
+		return NULL;
+
+	cmd_buf->buf = dma_pool_alloc(cmdqs->cmd_buf_pool, GFP_ATOMIC,
+				      &cmd_buf->dma_addr);
+	if (!cmd_buf->buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmdq cmd buf from the pool\n");
+		goto err_alloc_pci_buf;
+	}
+
+	cmd_buf->size = HINIC3_CMDQ_BUF_SIZE;
+	atomic_set(&cmd_buf->ref_cnt, 1);
+
+	return cmd_buf;
+
+err_alloc_pci_buf:
+	kfree(cmd_buf);
+	return NULL;
+}
+
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf *cmd_buf)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	if (!atomic_dec_and_test(&cmd_buf->ref_cnt))
+		return;
+
+	cmdqs = hwdev->cmdqs;
+
+	dma_pool_free(cmdqs->cmd_buf_pool, cmd_buf->buf, cmd_buf->dma_addr);
+	kfree(cmd_buf);
+}
+
+static void cmdq_clear_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
+			       struct hinic3_hwdev *hwdev)
+{
+	if (cmd_info->buf_in) {
+		hinic3_free_cmd_buf(hwdev, cmd_info->buf_in);
+		cmd_info->buf_in = NULL;
+	}
+}
+
+static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
+				   struct hinic3_cmdq_wqe *wqe, u16 ci)
+{
+	struct hinic3_cmdq_header *hdr = WQE_HEADER(wqe);
+	u32 header_info = hdr->header_info;
+	struct hinic3_ctrl *ctrl;
+	enum data_format df;
+
+	df = CMDQ_WQE_HDR_GET(header_info, DATA_FMT);
+	if (df == DATA_SGE)
+		ctrl = &wqe->wqe_lcmd.ctrl;
+	else
+		ctrl = &wqe->wqe_scmd.ctrl;
+
+	/* clear HW busy bit */
+	ctrl->ctrl_info = 0;
+	cmdq->cmd_infos[ci].cmd_type = HINIC3_CMD_TYPE_NONE;
+	wmb(); /* verify wqe is clear */
+	hinic3_wq_put_wqebbs(&cmdq->wq, NUM_WQEBBS_FOR_CMDQ_WQE);
+}
+
+static void cmdq_update_cmd_status(struct hinic3_cmdq *cmdq, u16 prod_idx,
+				   struct hinic3_cmdq_wqe *wqe)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	u32 status_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	cmd_info = &cmdq->cmd_infos[prod_idx];
+	if (cmd_info->errcode) {
+		status_info = wqe_lcmd->status.status_info;
+		*cmd_info->errcode = WQE_ERRCODE_GET(status_info, VAL);
+	}
+
+	if (cmd_info->direct_resp)
+		*cmd_info->direct_resp = wqe_lcmd->completion.resp.direct.val;
+}
+
+static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
+				  struct hinic3_cmdq_wqe *wqe, u16 ci)
+{
+	spin_lock(&cmdq->cmdq_lock);
+	cmdq_update_cmd_status(cmdq, ci, wqe);
+	if (cmdq->cmd_infos[ci].cmpt_code) {
+		*cmdq->cmd_infos[ci].cmpt_code = CMDQ_DIRECT_SYNC_CMPT_CODE;
+		cmdq->cmd_infos[ci].cmpt_code = NULL;
+	}
+
+	/* Ensure that completion code has been updated before updating done */
+	smp_rmb();
+	if (cmdq->cmd_infos[ci].done) {
+		complete(cmdq->cmd_infos[ci].done);
+		cmdq->cmd_infos[ci].done = NULL;
+	}
+	spin_unlock(&cmdq->cmdq_lock);
+
+	cmdq_clear_cmd_buf(&cmdq->cmd_infos[ci], cmdq->hwdev);
+	clear_wqe_complete_bit(cmdq, wqe, ci);
+}
+
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data)
+{
+	enum hinic3_cmdq_type cmdq_type = CEQE_CMDQ_GET(ceqe_data, TYPE);
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct hinic3_cmdq_wqe *wqe;
+	struct hinic3_cmdq *cmdq;
+	u32 ctrl_info;
+	u16 ci;
+
+	if (unlikely(cmdq_type >= ARRAY_SIZE(cmdqs->cmdq)))
+		return;
+
+	cmdq = &cmdqs->cmdq[cmdq_type];
+	while ((wqe = cmdq_read_wqe(&cmdq->wq, &ci)) != NULL) {
+		cmd_info = &cmdq->cmd_infos[ci];
+		switch (cmd_info->cmd_type) {
+		case HINIC3_CMD_TYPE_NONE:
+			return;
+		case HINIC3_CMD_TYPE_TIMEOUT:
+			dev_warn(hwdev->dev, "Cmdq timeout, q_id: %u, ci: %u\n", cmdq_type, ci);
+			fallthrough;
+		case HINIC3_CMD_TYPE_FAKE_TIMEOUT:
+			cmdq_clear_cmd_buf(cmd_info, hwdev);
+			clear_wqe_complete_bit(cmdq, wqe, ci);
+			break;
+		default:
+			/* only arm bit is using scmd wqe, the other wqe is lcmd */
+			wqe_lcmd = &wqe->wqe_lcmd;
+			ctrl_info = wqe_lcmd->ctrl.ctrl_info;
+			if (!WQE_COMPLETED(ctrl_info))
+				return;
+
+			dma_rmb();
+			/* For FORCE_STOP cmd_type, we also need to wait for
+			 * the firmware processing to complete to prevent the
+			 * firmware from accessing the released cmd_buf
+			 */
+			if (cmd_info->cmd_type == HINIC3_CMD_TYPE_FORCE_STOP) {
+				cmdq_clear_cmd_buf(cmd_info, hwdev);
+				clear_wqe_complete_bit(cmdq, wqe, ci);
+			} else {
+				cmdq_sync_cmd_handler(cmdq, wqe, ci);
+			}
+
+			break;
+		}
+	}
+}
+
+static int wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
+{
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(WAIT_CMDQ_ENABLE_TIMEOUT);
+	do {
+		if (cmdqs->status & HINIC3_CMDQ_ENABLE)
+			return 0;
+	} while (time_before(jiffies, end) && !cmdqs->disable_flag);
+
+	cmdqs->disable_flag = 1;
+
+	return -EBUSY;
+}
+
+static void cmdq_set_completion(struct hinic3_cmdq_completion *complete,
+				struct hinic3_cmd_buf *buf_out)
+{
+	struct hinic3_sge *sge = &complete->resp.sge;
+
+	hinic3_set_sge(sge, buf_out->dma_addr, HINIC3_CMDQ_BUF_SIZE);
+}
+
+static struct hinic3_cmdq_wqe *cmdq_get_wqe(struct hinic3_wq *wq, u16 *pi)
+{
+	if (!hinic3_wq_free_wqebbs(wq))
+		return NULL;
+
+	return hinic3_wq_get_one_wqebb(wq, pi);
+}
+
+static void cmdq_set_lcmd_bufdesc(struct hinic3_cmdq_wqe_lcmd *wqe,
+				  struct hinic3_cmd_buf *buf_in)
+{
+	hinic3_set_sge(&wqe->buf_desc.sge, buf_in->dma_addr, buf_in->size);
+}
+
+static void cmdq_set_db(struct hinic3_cmdq *cmdq,
+			enum hinic3_cmdq_type cmdq_type, u16 prod_idx)
+{
+	u8 __iomem *db_base = cmdq->hwdev->cmdqs->cmdqs_db_base;
+	u16 db_ofs = (prod_idx & 0xFF) << 3;
+	struct hinic3_cmdq_db db;
+
+	db.db_info = CMDQ_DB_INFO_SET(prod_idx >> 8, HI_PROD_IDX);
+	db.db_head = CMDQ_DB_HEAD_SET(1, QUEUE_TYPE) |
+		     CMDQ_DB_HEAD_SET(cmdq_type, CMDQ_TYPE);
+	writeq(*(u64 *)&db, db_base + db_ofs);
+}
+
+static void cmdq_wqe_fill(struct hinic3_cmdq_wqe *hw_wqe,
+			  const struct hinic3_cmdq_wqe *shadow_wqe)
+{
+	const struct hinic3_cmdq_header *src = (struct hinic3_cmdq_header *)shadow_wqe;
+	struct hinic3_cmdq_header *dst = (struct hinic3_cmdq_header *)hw_wqe;
+	size_t len;
+
+	len = sizeof(struct hinic3_cmdq_wqe) - sizeof(struct hinic3_cmdq_header);
+	memcpy(dst + 1, src + 1, len);
+	/* Header should be written last */
+	wmb();
+	WRITE_ONCE(*dst, *src);
+}
+
+static void cmdq_prepare_wqe_ctrl(struct hinic3_cmdq_wqe *wqe, u8 wrapped,
+				  u8 mod, u8 cmd, u16 prod_idx,
+				  enum completion_format complete_format,
+				  enum data_format data_format,
+				  enum bufdesc_len buf_len)
+{
+	struct hinic3_cmdq_header *hdr = WQE_HEADER(wqe);
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq_wqe_scmd *wqe_scmd;
+	enum ctrl_sect_len ctrl_len;
+	struct hinic3_ctrl *ctrl;
+
+	if (data_format == DATA_SGE) {
+		wqe_lcmd = &wqe->wqe_lcmd;
+		wqe_lcmd->status.status_info = 0;
+		ctrl = &wqe_lcmd->ctrl;
+		ctrl_len = CTRL_SECT_LEN;
+	} else {
+		wqe_scmd = &wqe->wqe_scmd;
+		wqe_scmd->status.status_info = 0;
+		ctrl = &wqe_scmd->ctrl;
+		ctrl_len = CTRL_DIRECT_SECT_LEN;
+	}
+
+	ctrl->ctrl_info =
+		CMDQ_CTRL_SET(prod_idx, PI) |
+		CMDQ_CTRL_SET(cmd, CMD) |
+		CMDQ_CTRL_SET(mod, MOD);
+
+	hdr->header_info =
+		CMDQ_WQE_HDR_SET(buf_len, BUFDESC_LEN) |
+		CMDQ_WQE_HDR_SET(complete_format, COMPLETE_FMT) |
+		CMDQ_WQE_HDR_SET(data_format, DATA_FMT) |
+		CMDQ_WQE_HDR_SET(1, COMPLETE_REQ) |
+		CMDQ_WQE_HDR_SET(3, COMPLETE_SECT_LEN) |
+		CMDQ_WQE_HDR_SET(ctrl_len, CTRL_LEN) |
+		CMDQ_WQE_HDR_SET(wrapped, HW_BUSY_BIT);
+}
+
+static void cmdq_set_lcmd_wqe(struct hinic3_cmdq_wqe *wqe,
+			      enum cmdq_cmd_type cmd_type,
+			      struct hinic3_cmd_buf *buf_in,
+			      struct hinic3_cmd_buf *buf_out, u8 wrapped,
+			      u8 mod, u8 cmd, u16 prod_idx)
+{
+	enum completion_format complete_format = COMPLETE_DIRECT;
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd = &wqe->wqe_lcmd;
+
+	switch (cmd_type) {
+	case SYNC_CMD_DIRECT_RESP:
+		wqe_lcmd->completion.resp.direct.val = 0;
+		break;
+	case SYNC_CMD_SGE_RESP:
+		if (buf_out) {
+			complete_format = COMPLETE_SGE;
+			cmdq_set_completion(&wqe_lcmd->completion, buf_out);
+		}
+		break;
+	}
+
+	cmdq_prepare_wqe_ctrl(wqe, wrapped, mod, cmd, prod_idx, complete_format,
+			      DATA_SGE, BUFDESC_LCMD_LEN);
+	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);
+}
+
+static int hinic3_cmdq_sync_timeout_check(struct hinic3_cmdq *cmdq,
+					  struct hinic3_cmdq_wqe *wqe, u16 pi)
+{
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_ctrl *ctrl;
+	u32 ctrl_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	ctrl = &wqe_lcmd->ctrl;
+	ctrl_info = ctrl->ctrl_info;
+	if (!WQE_COMPLETED(ctrl_info)) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq sync command check busy bit not set\n");
+		return -EFAULT;
+	}
+	cmdq_update_cmd_status(cmdq, pi, wqe);
+	return 0;
+}
+
+static void clear_cmd_info(struct hinic3_cmdq_cmd_info *cmd_info,
+			   const struct hinic3_cmdq_cmd_info *saved_cmd_info)
+{
+	if (cmd_info->errcode == saved_cmd_info->errcode)
+		cmd_info->errcode = NULL;
+
+	if (cmd_info->done == saved_cmd_info->done)
+		cmd_info->done = NULL;
+
+	if (cmd_info->direct_resp == saved_cmd_info->direct_resp)
+		cmd_info->direct_resp = NULL;
+}
+
+static int wait_cmdq_sync_cmd_completion(struct hinic3_cmdq *cmdq,
+					 struct hinic3_cmdq_cmd_info *cmd_info,
+					 struct hinic3_cmdq_cmd_info *saved_cmd_info,
+					 u64 curr_msg_id, u16 curr_prod_idx,
+					 struct hinic3_cmdq_wqe *curr_wqe,
+					 u32 timeout)
+{
+	ulong timeo = msecs_to_jiffies(timeout);
+	int err;
+
+	if (wait_for_completion_timeout(saved_cmd_info->done, timeo))
+		return 0;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	if (cmd_info->cmpt_code == saved_cmd_info->cmpt_code)
+		cmd_info->cmpt_code = NULL;
+
+	if (*saved_cmd_info->cmpt_code == CMDQ_DIRECT_SYNC_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq direct sync command has been completed\n");
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return 0;
+	}
+
+	if (curr_msg_id == cmd_info->cmdq_msg_id) {
+		err = hinic3_cmdq_sync_timeout_check(cmdq, curr_wqe,
+						     curr_prod_idx);
+		if (err)
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_TIMEOUT;
+		else
+			cmd_info->cmd_type = HINIC3_CMD_TYPE_FAKE_TIMEOUT;
+	} else {
+		err = -ETIMEDOUT;
+		dev_err(cmdq->hwdev->dev, "Cmdq sync command current msg id mismatch cmd_info msg id\n");
+	}
+
+	clear_cmd_info(cmd_info, saved_cmd_info);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+	return err;
+}
+
+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in, u64 *out_param)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
+	struct hinic3_cmdq_wqe *curr_wqe, wqe;
+	int cmpt_code = CMDQ_SEND_CMPT_CODE;
+	struct hinic3_wq *wq = &cmdq->wq;
+	u16 curr_prod_idx, next_prod_idx;
+	struct completion done;
+	u64 curr_msg_id;
+	int errcode;
+	u8 wrapped;
+	int err;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	curr_wqe = cmdq_get_wqe(wq, &curr_prod_idx);
+	if (!curr_wqe) {
+		spin_unlock_bh(&cmdq->cmdq_lock);
+		return -EBUSY;
+	}
+
+	memset(&wqe, 0, sizeof(wqe));
+	wrapped = cmdq->wrapped;
+	next_prod_idx = curr_prod_idx + NUM_WQEBBS_FOR_CMDQ_WQE;
+	if (next_prod_idx >= wq->q_depth) {
+		cmdq->wrapped ^= 1;
+		next_prod_idx -= wq->q_depth;
+	}
+
+	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
+	init_completion(&done);
+	atomic_inc(&buf_in->ref_cnt);
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
+	cmd_info->done = &done;
+	cmd_info->errcode = &errcode;
+	cmd_info->direct_resp = out_param;
+	cmd_info->cmpt_code = &cmpt_code;
+	cmd_info->buf_in = buf_in;
+	saved_cmd_info = *cmd_info;
+	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_DIRECT_RESP, buf_in, NULL,
+			  wrapped, mod, cmd, curr_prod_idx);
+
+	cmdq_wqe_fill(curr_wqe, &wqe);
+	(cmd_info->cmdq_msg_id)++;
+	curr_msg_id = cmd_info->cmdq_msg_id;
+	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	err = wait_cmdq_sync_cmd_completion(cmdq, cmd_info, &saved_cmd_info,
+					    curr_msg_id, curr_prod_idx,
+					    curr_wqe, CMDQ_CMD_TIMEOUT);
+	if (err) {
+		dev_err(cmdq->hwdev->dev, "Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
+			mod, cmd, curr_prod_idx);
+		err = -ETIMEDOUT;
+	}
+
+	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev, "Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
+		err = -EAGAIN;
+	}
+
+	smp_rmb(); /* read error code after completion */
+
+	return err ? err : errcode;
+}
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param)
+{
+	struct hinic3_cmdqs *cmdqs;
+	int err;
+
+	cmdqs = hwdev->cmdqs;
+	err = wait_cmdqs_enable(cmdqs);
+	if (err) {
+		dev_err(hwdev->dev, "Cmdq is disabled\n");
+		return err;
+	}
+
+	err = cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC],
+					mod, cmd, buf_in, out_param);
+	return err;
+}
+
+static void cmdq_init_queue_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id,
+				 struct cmdq_ctxt_info *ctxt_info)
+{
+	const struct hinic3_cmdqs *cmdqs;
+	u64 cmdq_first_block_paddr, pfn;
+	const struct hinic3_wq *wq;
+
+	cmdqs = hwdev->cmdqs;
+	wq = &cmdqs->cmdq[cmdq_id].wq;
+	pfn = CMDQ_PFN(hinic3_wq_get_first_wqe_page_addr(wq));
+
+	ctxt_info->curr_wqe_page_pfn =
+		CMDQ_CTXT_SET(1, HW_BUSY_BIT) |
+		CMDQ_CTXT_SET(1, CEQ_EN)	|
+		CMDQ_CTXT_SET(1, CEQ_ARM)	|
+		CMDQ_CTXT_SET(0, EQ_ID) |
+		CMDQ_CTXT_SET(pfn, CURR_WQE_PAGE_PFN);
+
+	if (!WQ_IS_0_LEVEL_CLA(wq)) {
+		cmdq_first_block_paddr = cmdqs->wq_block_paddr;
+		pfn = CMDQ_PFN(cmdq_first_block_paddr);
+	}
+
+	ctxt_info->wq_block_pfn =
+		CMDQ_CTXT_SET(wq->cons_idx, CI) |
+		CMDQ_CTXT_SET(pfn, WQ_BLOCK_PFN);
+}
+
+static int init_cmdq(struct hinic3_cmdq *cmdq, struct hinic3_hwdev *hwdev,
+		     enum hinic3_cmdq_type q_type)
+{
+	int err;
+
+	cmdq->cmdq_type = q_type;
+	cmdq->wrapped = 1;
+	cmdq->hwdev = hwdev;
+
+	spin_lock_init(&cmdq->cmdq_lock);
+
+	cmdq->cmd_infos = kcalloc(cmdq->wq.q_depth, sizeof(*cmdq->cmd_infos),
+				  GFP_KERNEL);
+	if (!cmdq->cmd_infos) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	return 0;
+}
+
+static void free_cmdq(struct hinic3_cmdq *cmdq)
+{
+	kfree(cmdq->cmd_infos);
+}
+
+static int hinic3_set_cmdq_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id)
+{
+	struct comm_cmd_cmdq_ctxt cmdq_ctxt;
+	u32 out_size = sizeof(cmdq_ctxt);
+	int err;
+
+	memset(&cmdq_ctxt, 0, sizeof(cmdq_ctxt));
+	cmdq_init_queue_ctxt(hwdev, cmdq_id, &cmdq_ctxt.ctxt);
+	cmdq_ctxt.func_id = hinic3_global_func_id(hwdev);
+	cmdq_ctxt.cmdq_id = cmdq_id;
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM,
+				       COMM_MGMT_CMD_SET_CMDQ_CTXT,
+				       &cmdq_ctxt, sizeof(cmdq_ctxt),
+				       &cmdq_ctxt, &out_size, 0);
+	if (err || !out_size || cmdq_ctxt.head.status) {
+		dev_err(hwdev->dev, "Failed to set cmdq ctxt, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, cmdq_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+	int err;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_set_cmdq_ctxt(hwdev, cmdq_type);
+		if (err)
+			return err;
+	}
+
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+	cmdqs->disable_flag = 0;
+
+	return 0;
+}
+
+static int create_cmdq_wq(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
+{
+	u8 cmdq_type;
+	int err;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = hinic3_wq_create(hwdev, &cmdqs->cmdq[cmdq_type].wq,
+				       HINIC3_CMDQ_DEPTH, CMDQ_WQEBB_SIZE);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to create cmdq wq\n");
+			goto destroy_wq;
+		}
+	}
+
+	/* 1-level Chip Logical Address (CLA) must put all cmdq's wq page addr in one wq block */
+	if (!WQ_IS_0_LEVEL_CLA(&cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq)) {
+		if (cmdqs->cmdq[HINIC3_CMDQ_SYNC].wq.qpages.num_pages >
+		    CMDQ_WQ_CLA_SIZE / sizeof(u64)) {
+			err = -EINVAL;
+			dev_err(hwdev->dev, "Cmdq number of wq pages exceeds limit: %lu\n",
+				CMDQ_WQ_CLA_SIZE / sizeof(u64));
+			goto destroy_wq;
+		}
+
+		cmdqs->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
+							   HINIC3_MIN_PAGE_SIZE,
+							   &cmdqs->wq_block_paddr,
+							   GFP_KERNEL);
+		if (!cmdqs->wq_block_vaddr) {
+			err = -ENOMEM;
+			goto destroy_wq;
+		}
+
+		for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++)
+			memcpy((u8 *)cmdqs->wq_block_vaddr +
+			       CMDQ_WQ_CLA_SIZE * cmdq_type,
+			       cmdqs->cmdq[cmdq_type].wq.wq_block_vaddr,
+			       cmdqs->cmdq[cmdq_type].wq.qpages.num_pages * sizeof(__be64));
+	}
+
+	return 0;
+
+destroy_wq:
+	while (cmdq_type > 0) {
+		cmdq_type--;
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[cmdq_type].wq);
+	}
+
+	return err;
+}
+
+static void destroy_cmdq_wq(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
+{
+	u8 cmdq_type;
+
+	if (cmdqs->wq_block_vaddr)
+		dma_free_coherent(hwdev->dev, HINIC3_MIN_PAGE_SIZE,
+				  cmdqs->wq_block_vaddr, cmdqs->wq_block_paddr);
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++)
+		hinic3_wq_destroy(hwdev, &cmdqs->cmdq[cmdq_type].wq);
+}
+
+static int init_cmdqs(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = kzalloc(sizeof(*cmdqs), GFP_KERNEL);
+	if (!cmdqs)
+		return -ENOMEM;
+
+	hwdev->cmdqs = cmdqs;
+	cmdqs->hwdev = hwdev;
+	cmdqs->cmdq_num = hwdev->max_cmdq;
+
+	cmdqs->cmd_buf_pool = dma_pool_create("hinic3_cmdq", hwdev->dev,
+					      HINIC3_CMDQ_BUF_SIZE, HINIC3_CMDQ_BUF_SIZE, 0ULL);
+	if (!cmdqs->cmd_buf_pool) {
+		dev_err(hwdev->dev, "Failed to create cmdq buffer pool\n");
+		kfree(cmdqs);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void cmdq_flush_sync_cmd(struct hinic3_cmdq_cmd_info *cmd_info)
+{
+	if (cmd_info->cmd_type != HINIC3_CMD_TYPE_DIRECT_RESP)
+		return;
+
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_FORCE_STOP;
+
+	if (cmd_info->cmpt_code &&
+	    *cmd_info->cmpt_code == CMDQ_SEND_CMPT_CODE)
+		*cmd_info->cmpt_code = CMDQ_FORCE_STOP_CMPT_CODE;
+
+	if (cmd_info->done) {
+		complete(cmd_info->done);
+		cmd_info->done = NULL;
+		cmd_info->cmpt_code = NULL;
+		cmd_info->direct_resp = NULL;
+		cmd_info->errcode = NULL;
+	}
+}
+
+static void hinic3_cmdq_flush_cmd(struct hinic3_hwdev *hwdev,
+				  struct hinic3_cmdq *cmdq)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	u16 ci;
+
+	spin_lock_bh(&cmdq->cmdq_lock);
+	while (cmdq_read_wqe(&cmdq->wq, &ci)) {
+		hinic3_wq_put_wqebbs(&cmdq->wq, NUM_WQEBBS_FOR_CMDQ_WQE);
+		cmd_info = &cmdq->cmd_infos[ci];
+		if (cmd_info->cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP)
+			cmdq_flush_sync_cmd(cmd_info);
+	}
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdq *cmdq;
+	u16 wqe_cnt, wqe_idx, i;
+	struct hinic3_wq *wq;
+
+	cmdq = &hwdev->cmdqs->cmdq[HINIC3_CMDQ_SYNC];
+	spin_lock_bh(&cmdq->cmdq_lock);
+	wq = &cmdq->wq;
+	wqe_cnt = hinic3_wq_get_used(wq);
+	for (i = 0; i < wqe_cnt; i++) {
+		wqe_idx = (wq->cons_idx + i) & wq->idx_mask;
+		cmdq_flush_sync_cmd(cmdq->cmd_infos + wqe_idx);
+	}
+	spin_unlock_bh(&cmdq->cmdq_lock);
+}
+
+static void cmdq_reset_all_cmd_buff(struct hinic3_cmdq *cmdq)
+{
+	u16 i;
+
+	for (i = 0; i < cmdq->wq.q_depth; i++)
+		cmdq_clear_cmd_buf(&cmdq->cmd_infos[i], cmdq->hwdev);
+}
+
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(hwdev, &cmdqs->cmdq[cmdq_type]);
+		cmdq_reset_all_cmd_buff(&cmdqs->cmdq[cmdq_type]);
+		cmdqs->cmdq[cmdq_type].wrapped = 1;
+		hinic3_wq_reset(&cmdqs->cmdq[cmdq_type].wq);
+	}
+
+	return hinic3_set_cmdq_ctxts(hwdev);
+}
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs;
+	void __iomem *db_base;
+	u8 cmdq_type;
+	int err;
+
+	err = init_cmdqs(hwdev);
+	if (err)
+		return err;
+
+	cmdqs = hwdev->cmdqs;
+	err = create_cmdq_wq(hwdev, cmdqs);
+	if (err)
+		goto err_create_wq;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell address\n");
+		goto err_alloc_db;
+	}
+	cmdqs->cmdqs_db_base = db_base;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		err = init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev, cmdq_type);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to initialize cmdq type :%d\n", cmdq_type);
+			goto err_init_cmdq;
+		}
+	}
+
+	err = hinic3_set_cmdq_ctxts(hwdev);
+	if (err)
+		goto err_init_cmdq;
+
+	return 0;
+
+err_init_cmdq:
+	while (cmdq_type > 0) {
+		cmdq_type--;
+		free_cmdq(&cmdqs->cmdq[cmdq_type]);
+	}
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base, NULL);
+
+err_alloc_db:
+	destroy_cmdq_wq(hwdev, cmdqs);
+
+err_create_wq:
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+	kfree(cmdqs);
+
+	return err;
+}
+
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	u8 cmdq_type;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		hinic3_cmdq_flush_cmd(hwdev, &cmdqs->cmdq[cmdq_type]);
+		cmdq_reset_all_cmd_buff(&cmdqs->cmdq[cmdq_type]);
+		free_cmdq(&cmdqs->cmdq[cmdq_type]);
+	}
+
+	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base, NULL);
+	destroy_cmdq_wq(hwdev, cmdqs);
+	dma_pool_destroy(cmdqs->cmd_buf_pool);
+	kfree(cmdqs);
+}
+
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq)
+{
+	return hinic3_wq_get_used(&cmdq->wq) == 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
new file mode 100644
index 000000000000..f8eccfd2f350
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_CMDQ_H
+#define HINIC3_CMDQ_H
+
+#include <linux/dmapool.h>
+
+#include "hinic3_wq.h"
+#include "hinic3_hw_intf.h"
+
+#define HINIC3_CMDQ_DEPTH  4096
+
+struct hinic3_cmd_buf {
+	void       *buf;
+	dma_addr_t dma_addr;
+	u16        size;
+	atomic_t   ref_cnt;
+};
+
+struct hinic3_cmdq_db {
+	u32 db_head;
+	u32 db_info;
+};
+
+/* hw defined cmdq wqe header */
+struct hinic3_cmdq_header {
+	u32 header_info;
+	u32 saved_data;
+};
+
+struct hinic3_lcmd_bufdesc {
+	struct hinic3_sge sge;
+	u64               rsvd2;
+	u64               rsvd3;
+};
+
+struct hinic3_status {
+	u32 status_info;
+};
+
+struct hinic3_ctrl {
+	u32 ctrl_info;
+};
+
+struct hinic3_direct_resp {
+	u64 val;
+	u64 rsvd;
+};
+
+struct hinic3_cmdq_completion {
+	union {
+		struct hinic3_sge         sge;
+		struct hinic3_direct_resp direct;
+	} resp;
+};
+
+struct hinic3_cmdq_wqe_scmd {
+	struct hinic3_cmdq_header     header;
+	u64                           rsvd3;
+	struct hinic3_status          status;
+	struct hinic3_ctrl            ctrl;
+	struct hinic3_cmdq_completion completion;
+	u32                           rsvd10[6];
+};
+
+struct hinic3_cmdq_wqe_lcmd {
+	struct hinic3_cmdq_header     header;
+	struct hinic3_status          status;
+	struct hinic3_ctrl            ctrl;
+	struct hinic3_cmdq_completion completion;
+	struct hinic3_lcmd_bufdesc    buf_desc;
+};
+
+struct hinic3_cmdq_wqe {
+	union {
+		struct hinic3_cmdq_wqe_scmd   wqe_scmd;
+		struct hinic3_cmdq_wqe_lcmd   wqe_lcmd;
+	};
+};
+
+static_assert(sizeof(struct hinic3_cmdq_wqe) == 64);
+
+enum hinic3_cmdq_status {
+	HINIC3_CMDQ_ENABLE = BIT(0),
+};
+
+enum hinic3_cmdq_cmd_type {
+	HINIC3_CMD_TYPE_NONE,
+	HINIC3_CMD_TYPE_DIRECT_RESP,
+	HINIC3_CMD_TYPE_FAKE_TIMEOUT,
+	HINIC3_CMD_TYPE_TIMEOUT,
+	HINIC3_CMD_TYPE_FORCE_STOP,
+};
+
+struct hinic3_cmdq_cmd_info {
+	enum hinic3_cmdq_cmd_type cmd_type;
+	struct completion         *done;
+	int                       *errcode;
+	/* completion code */
+	int                       *cmpt_code;
+	u64                       *direct_resp;
+	u64                       cmdq_msg_id;
+	struct hinic3_cmd_buf     *buf_in;
+};
+
+struct hinic3_cmdq {
+	struct hinic3_wq            wq;
+	enum hinic3_cmdq_type       cmdq_type;
+	u8                          wrapped;
+	/* synchronize command submission with completions via event queue */
+	spinlock_t                  cmdq_lock;
+	struct hinic3_cmdq_cmd_info *cmd_infos;
+	struct hinic3_hwdev         *hwdev;
+};
+
+struct hinic3_cmdqs {
+	struct hinic3_hwdev *hwdev;
+	struct hinic3_cmdq  cmdq[HINIC3_MAX_CMDQ_TYPES];
+	struct dma_pool     *cmd_buf_pool;
+	/* doorbell area */
+	u8 __iomem          *cmdqs_db_base;
+
+	/* When command queue uses multiple memory pages (1-level CLA), this
+	 * block will hold aggregated indirection table for all command queues
+	 * of cmdqs. Not used for small cmdq (0-level CLA).
+	 */
+	dma_addr_t          wq_block_paddr;
+	void                *wq_block_vaddr;
+
+	u32                 status;
+	u32                 disable_flag;
+	u8                  cmdq_num;
+};
+
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev);
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);
+
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev);
+void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev, struct hinic3_cmd_buf *cmd_buf);
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param);
+
+void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
index d416a6a00a8b..2b2919560c56 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -51,3 +51,48 @@ void hinic3_dma_free_coherent_align(struct device *dev,
 	dma_free_coherent(dev, mem_align->real_size,
 			  mem_align->ori_vaddr, mem_align->ori_paddr);
 }
+
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us)
+{
+	/* Take 9/10 * wait_once_us as the minimum sleep time of usleep_range */
+	u32 usleep_min = wait_once_us - wait_once_us / 10;
+	enum hinic3_wait_return ret;
+	unsigned long end;
+
+	end = jiffies + msecs_to_jiffies(wait_total_ms);
+	do {
+		ret = handler(priv_data);
+		if (ret == WAIT_PROCESS_CPL)
+			return 0;
+
+		/* Sleep more than 20ms using msleep is accurate */
+		if (wait_once_us >= 20 * USEC_PER_MSEC)
+			msleep(wait_once_us / USEC_PER_MSEC);
+		else
+			usleep_range(usleep_min, wait_once_us);
+	} while (time_before(jiffies, end));
+
+	ret = handler(priv_data);
+	if (ret == WAIT_PROCESS_CPL)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+/* Data provided to/by cmdq is arranged in structs with little endian fields but
+ * every dword (32bits) should be swapped since HW swaps it again when it
+ * copies it from/to host memory. This is a mandatory swap regardless of the
+ * CPU endianness.
+ */
+void cmdq_buf_swab32(void *data, int len)
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
index f8ff768c20ca..83595e0f3b31 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -18,10 +18,37 @@ struct hinic3_dma_addr_align {
 	dma_addr_t align_paddr;
 };
 
+enum hinic3_wait_return {
+	WAIT_PROCESS_CPL     = 0,
+	WAIT_PROCESS_WAITING = 1,
+};
+
+struct hinic3_sge {
+	u32 hi_addr;
+	u32 lo_addr;
+	u32 len;
+	u32 rsvd;
+};
+
+static inline void hinic3_set_sge(struct hinic3_sge *sge, dma_addr_t addr,
+				  int len)
+{
+	sge->hi_addr = upper_32_bits(addr);
+	sge->lo_addr = lower_32_bits(addr);
+	sge->len = len;
+	sge->rsvd = 0;
+}
+
 int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
 				     gfp_t flag,
 				     struct hinic3_dma_addr_align *mem_align);
 void hinic3_dma_free_coherent_align(struct device *dev,
 				    struct hinic3_dma_addr_align *mem_align);
 
+typedef enum hinic3_wait_return (*wait_cpl_handler)(void *priv_data);
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us);
+
+void cmdq_buf_swab32(void *data, int len);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
new file mode 100644
index 000000000000..01d59748ef15
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_CSR_H
+#define HINIC3_CSR_H
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
+#define HINIC3_AEQ_INDIR_IDX_ADDR             (HINIC3_CFG_REGS_FLAG + 0x210)
+#define HINIC3_CEQ_INDIR_IDX_ADDR             (HINIC3_CFG_REGS_FLAG + 0x290)
+
+#define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
+	((type == HINIC3_AEQ) ? HINIC3_AEQ_INDIR_IDX_ADDR : HINIC3_CEQ_INDIR_IDX_ADDR)
+
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR          (HINIC3_CFG_REGS_FLAG + 0x240)
+#define HINIC3_CEQ_MTT_OFF_BASE_ADDR          (HINIC3_CFG_REGS_FLAG + 0x2C0)
+
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE         8
+
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR            (HINIC3_CFG_REGS_FLAG + 0x200)
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR            (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x20C)
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR   (HINIC3_CFG_REGS_FLAG + 0x50)
+
+#define HINIC3_CSR_CEQ_PROD_IDX_ADDR          (HINIC3_CFG_REGS_FLAG + 0x28c)
+#define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR   (HINIC3_CFG_REGS_FLAG + 0x54)
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
new file mode 100644
index 000000000000..9eb9e276fb99
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -0,0 +1,786 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/delay.h>
+
+#include "hinic3_eqs.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_hwif.h"
+#include "hinic3_csr.h"
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
+#define CEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define CEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define CEQ_CTRL_0_LIMIT_KICK_MASK    GENMASK(23, 20)
+#define CEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(25, 24)
+#define CEQ_CTRL_0_PAGE_SIZE_MASK     GENMASK(30, 27)
+#define CEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define CEQ_CTRL_0_SET(val, member)   \
+	FIELD_PREP(CEQ_CTRL_0_##member##_MASK, val)
+
+#define CEQ_CTRL_1_LEN_MASK           GENMASK(19, 0)
+#define CEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_1_##member##_MASK, val)
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
+#define EQ_CI_SIMPLE_INDIR_CEQ_IDX_MASK  GENMASK(31, 24)
+#define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
+	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
+
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
+	 HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR)
+
+#define EQ_PROD_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_PROD_IDX_ADDR : HINIC3_CSR_CEQ_PROD_IDX_ADDR)
+
+#define HINIC3_EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
+	((u32)((type == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)))
+
+#define HINIC3_EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
+	((u32)((type == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)))
+
+#define HINIC3_EQ_MAX_PAGES(eq)  \
+	((eq)->type == HINIC3_AEQ ?  \
+	 HINIC3_AEQ_MAX_PAGES : HINIC3_CEQ_MAX_PAGES)
+
+#define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
+#define HINIC3_EQ_UPDATE_CI_STEP       64
+#define HINIC3_EQS_WQ_NAME             "hinic3_eqs"
+
+#define EQ_MSIX_RESEND_TIMER_CLEAR     1
+
+#define EQ_VALID_SHIFT    31
+#define EQ_WRAPPED(eq)    ((u32)(eq)->wrapped << EQ_VALID_SHIFT)
+
+#define EQ_WRAPPED_SHIFT  20
+#define EQ_CONS_IDX(eq)   \
+	((eq)->cons_idx | ((u32)(eq)->wrapped << EQ_WRAPPED_SHIFT))
+
+#define CEQE_TYPE_MASK   GENMASK(25, 23)
+#define CEQE_TYPE(type)  FIELD_GET(CEQE_TYPE_MASK, type)
+
+#define CEQE_DATA_MASK   GENMASK(25, 0)
+#define CEQE_DATA(data)  ((data) & CEQE_DATA_MASK)
+
+static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+static const __be32 *get_curr_ceq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev, enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb)
+{
+	struct hinic3_aeqs *aeqs;
+	unsigned long *cb_state;
+
+	aeqs = hwdev->aeqs;
+	cb_state = &aeqs->aeq_cb_state[event];
+	aeqs->aeq_cb[event] = hwe_cb;
+	set_bit(HINIC3_AEQ_CB_REG, cb_state);
+	return 0;
+}
+
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev, enum hinic3_aeq_type event)
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
+		usleep_range(EQ_USLEEP_LOW_BOUND, EQ_USLEEP_HIG_BOUND);
+
+	aeqs->aeq_cb[event] = NULL;
+}
+
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	ceqs->ceq_cb[event] = callback;
+	set_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+	return 0;
+}
+
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev, enum hinic3_ceq_event event)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	clear_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+	/* Ensure handler can observe our intent to unregister. */
+	mb();
+	while (test_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]))
+		usleep_range(EQ_USLEEP_LOW_BOUND, EQ_USLEEP_HIG_BOUND);
+
+	ceqs->ceq_cb[event] = NULL;
+}
+
+/* Set consumer index in the hw. */
+static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
+{
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR(eq);
+	u32 eq_wrap_ci, val;
+
+	eq_wrap_ci = EQ_CONS_IDX(eq);
+	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
+	if (eq->type == HINIC3_AEQ) {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	} else {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, CEQ_IDX);
+	}
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
+}
+
+static struct hinic3_ceqs *ceq_to_ceqs(const struct hinic3_eq *eq)
+{
+	return container_of(eq, struct hinic3_ceqs, ceq[eq->q_id]);
+}
+
+static void ceq_event_handler(struct hinic3_ceqs *ceqs, u32 ceqe)
+{
+	enum hinic3_ceq_event event = CEQE_TYPE(ceqe);
+	struct hinic3_hwdev *hwdev = ceqs->hwdev;
+	u32 ceqe_data = CEQE_DATA(ceqe);
+
+	if (event >= HINIC3_MAX_CEQ_EVENTS) {
+		dev_warn(hwdev->dev, "Ceq unknown event:%d, ceqe date: 0x%x\n",
+			 event, ceqe_data);
+		return;
+	}
+
+	set_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
+	/* Ensure unregister sees we are running. */
+	mb();
+	if (ceqs->ceq_cb[event] &&
+	    test_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]))
+		ceqs->ceq_cb[event](hwdev, ceqe_data);
+
+	clear_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
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
+	cmdq_buf_swab32(data, HINIC3_AEQE_DATA_SIZE);
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
+static int ceq_irq_handler(struct hinic3_eq *eq)
+{
+	struct hinic3_ceqs *ceqs;
+	u32 ceqe, eqe_cnt = 0;
+	__be32 ceqe_raw;
+	u32 i;
+
+	ceqs = ceq_to_ceqs(eq);
+	for (i = 0; i < HINIC3_TASK_PROCESS_EQE_LIMIT; i++) {
+		ceqe_raw = *get_curr_ceq_elem(eq);
+		ceqe = be32_to_cpu(ceqe_raw);
+
+		/* HW updates wrapped bit, when it adds eq element event */
+		if (EQ_ELEM_DESC_GET(ceqe, WRAPPED) == eq->wrapped)
+			return 0;
+
+		ceq_event_handler(ceqs, ceqe);
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
+	} else {
+		tasklet_schedule(&eq->ceq_tasklet);
+	}
+}
+
+static int eq_irq_handler(struct hinic3_eq *eq)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+	else
+		err = ceq_irq_handler(eq);
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
+static void ceq_tasklet(ulong ceq_data)
+{
+	struct hinic3_eq *eq = (struct hinic3_eq *)ceq_data;
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
+	hinic3_misx_intr_clear_resend_bit(hwdev, aeq->eq_irq.msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	queue_work_on(WORK_CPU_UNBOUND, workq, &aeq->aeq_work);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ceq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *ceq = data;
+
+	/* clear resend timer counters */
+	hinic3_misx_intr_clear_resend_bit(ceq->hwdev,
+					  ceq->eq_irq.msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	tasklet_schedule(&ceq->ceq_tasklet);
+	return IRQ_HANDLED;
+}
+
+static int hinic3_set_ceq_ctrl_reg(struct hinic3_hwdev *hwdev, u16 q_id,
+				   u32 ctrl0, u32 ctrl1)
+{
+	struct comm_cmd_ceq_ctrl_reg ceq_ctrl;
+	u32 out_size = sizeof(ceq_ctrl);
+	int err;
+
+	memset(&ceq_ctrl, 0, sizeof(ceq_ctrl));
+	ceq_ctrl.func_id = hinic3_global_func_id(hwdev);
+	ceq_ctrl.q_id = q_id;
+	ceq_ctrl.ctrl0 = ctrl0;
+	ceq_ctrl.ctrl1 = ctrl1;
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM,
+				       COMM_MGMT_CMD_SET_CEQ_CTRL_REG,
+				       &ceq_ctrl, sizeof(ceq_ctrl),
+				       &ceq_ctrl, &out_size, 0);
+	if (err || !out_size || ceq_ctrl.head.status) {
+		dev_err(hwdev->dev, "Failed to set ceq %u ctrl reg, err: %d status: 0x%x, out_size: 0x%x\n",
+			q_id, err, ceq_ctrl.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int set_eq_ctrls(struct hinic3_eq *eq)
+{
+	struct hinic3_hwif *hwif = eq->hwdev->hwif;
+	struct irq_info *eq_irq = &eq->eq_irq;
+	struct hinic3_queue_pages *qpages;
+	u8 pci_intf_idx, elem_size;
+	u32 mask, ctrl0, ctrl1;
+	u32 page_size_val;
+	int err;
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
+			AEQ_CTRL_0_SET(eq_irq->msix_entry_idx, INTR_IDX) |
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
+	} else {
+		ctrl0 = CEQ_CTRL_0_SET(eq_irq->msix_entry_idx, INTR_IDX) |
+			CEQ_CTRL_0_SET(0, DMA_ATTR) |
+			CEQ_CTRL_0_SET(0, LIMIT_KICK) |
+			CEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			CEQ_CTRL_0_SET(page_size_val, PAGE_SIZE) |
+			CEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+
+		ctrl1 = CEQ_CTRL_1_SET(eq->eq_len, LEN);
+
+		/* set ceq ctrl reg through mgmt cpu */
+		err = hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, ctrl0, ctrl1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void ceq_elements_init(struct hinic3_eq *eq, u32 init_val)
+{
+	__be32 *ceqe;
+	u32 i;
+
+	for (i = 0; i < eq->eq_len; i++) {
+		ceqe = get_q_element(&eq->qpages, i, NULL);
+		*ceqe = cpu_to_be32(init_val);
+	}
+
+	wmb();    /* Write the init values */
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
+	else
+		ceq_elements_init(eq, init_val);
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
+	err = queue_pages_alloc(eq->hwdev, qpages, HINIC3_MIN_PAGE_SIZE);
+	if (err)
+		return err;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		page_paddr = qpages->pages[pg_idx].align_paddr;
+		reg = HINIC3_EQ_HI_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, upper_32_bits(page_paddr));
+		reg = HINIC3_EQ_LO_PHYS_ADDR_REG(eq->type, pg_idx);
+		hinic3_hwif_write_reg(hwif, reg, lower_32_bits(page_paddr));
+	}
+
+	init_val = EQ_WRAPPED(eq);
+	eq_elements_init(eq, init_val);
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
+	max_pages = HINIC3_EQ_MAX_PAGES(eq);
+	min_page_size = HINIC3_MIN_PAGE_SIZE;
+	total_size = eq->eq_len * elem_size;
+
+	if (total_size <= max_pages * min_page_size)
+		page_size = min_page_size;
+	else
+		page_size = total_size / max_pages;
+
+	queue_pages_init(&eq->qpages, eq->eq_len, page_size, elem_size);
+}
+
+static int request_eq_irq(struct hinic3_eq *eq, struct irq_info *entry)
+{
+	int err;
+
+	if (eq->type == HINIC3_AEQ) {
+		INIT_WORK(&eq->aeq_work, eq_irq_work);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(entry->irq_id, aeq_interrupt, 0UL,
+				  eq->irq_name, eq);
+	} else {
+		tasklet_init(&eq->ceq_tasklet, ceq_tasklet, (ulong)eq);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_ceq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(entry->irq_id, ceq_interrupt, 0UL,
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
+	else
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR(eq), 0);
+}
+
+static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
+		   u32 q_len, enum hinic3_eq_type type, struct irq_info *entry)
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
+	elem_size = (type == HINIC3_AEQ) ? HINIC3_AEQE_SIZE : HINIC3_CEQE_SIZE;
+	eq_calc_page_size_and_num(eq, elem_size);
+
+	err = alloc_eq_pages(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate pages for eq\n");
+		return err;
+	}
+
+	eq->eq_irq.msix_entry_idx = entry->msix_entry_idx;
+	eq->eq_irq.irq_id = entry->irq_id;
+
+	err = set_eq_ctrls(eq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set ctrls for eq\n");
+		goto err_undo_pages_alloc;
+	}
+
+	set_eq_cons_idx(eq, HINIC3_EQ_ARMED);
+
+	err = request_eq_irq(eq, entry);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to request irq for the eq, err: %d\n", err);
+		goto err_undo_pages_alloc;
+	}
+
+	hinic3_set_msix_state(hwdev, entry->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+
+	return 0;
+
+err_undo_pages_alloc:
+	queue_pages_free(hwdev, &eq->qpages);
+	return err;
+}
+
+static void remove_eq(struct hinic3_eq *eq)
+{
+	struct irq_info *entry = &eq->eq_irq;
+
+	hinic3_set_msix_state(eq->hwdev, entry->msix_entry_idx,
+			      HINIC3_MSIX_DISABLE);
+	synchronize_irq(entry->irq_id);
+	free_irq(entry->irq_id, eq);
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
+	} else {
+		tasklet_kill(&eq->ceq_tasklet);
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+	}
+
+	/* update consumer index to avoid invalid interrupt */
+	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
+					    EQ_PROD_IDX_REG_ADDR(eq));
+	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
+	queue_pages_free(eq->hwdev, &eq->qpages);
+}
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct irq_info *msix_entries)
+{
+	struct hinic3_aeqs *aeqs;
+	u16 i, q_id;
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
+		goto err_create_work;
+	}
+
+	for (q_id = 0; q_id < num_aeqs; q_id++) {
+		err = init_eq(&aeqs->aeq[q_id], hwdev, q_id, HINIC3_DEFAULT_AEQ_LEN,
+			      HINIC3_AEQ, &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init aeq %u\n",
+				q_id);
+			goto err_init_aeq;
+		}
+	}
+	for (q_id = 0; q_id < num_aeqs; q_id++)
+		hinic3_set_msix_state(hwdev, msix_entries[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_init_aeq:
+	for (i = 0; i < q_id; i++)
+		remove_eq(&aeqs->aeq[i]);
+
+	destroy_workqueue(aeqs->workq);
+
+err_create_work:
+	kfree(aeqs);
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
+		hinic3_free_irq(hwdev, eq->eq_irq.irq_id);
+	}
+
+	for (aeq_event = 0; aeq_event < HINIC3_MAX_AEQ_EVENTS; aeq_event++)
+		hinic3_aeq_unregister_cb(hwdev, aeq_event);
+
+	destroy_workqueue(aeqs->workq);
+
+	kfree(aeqs);
+}
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct irq_info *msix_entries)
+{
+	struct hinic3_ceqs *ceqs;
+	u16 i, q_id;
+	int err;
+
+	ceqs = kzalloc(sizeof(*ceqs), GFP_KERNEL);
+	if (!ceqs)
+		return -ENOMEM;
+
+	hwdev->ceqs = ceqs;
+	ceqs->hwdev = hwdev;
+	ceqs->num_ceqs = num_ceqs;
+
+	for (q_id = 0; q_id < num_ceqs; q_id++) {
+		err = init_eq(&ceqs->ceq[q_id], hwdev, q_id, HINIC3_DEFAULT_CEQ_LEN,
+			      HINIC3_CEQ, &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init ceq %u\n",
+				q_id);
+			goto err_init_ceq;
+		}
+	}
+	for (q_id = 0; q_id < num_ceqs; q_id++)
+		hinic3_set_msix_state(hwdev, msix_entries[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_init_ceq:
+	for (i = 0; i < q_id; i++)
+		remove_eq(&ceqs->ceq[i]);
+
+	kfree(ceqs);
+	return err;
+}
+
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	enum hinic3_ceq_event ceq_event;
+	struct hinic3_eq *eq;
+	u16 q_id;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = ceqs->ceq + q_id;
+		remove_eq(eq);
+		hinic3_free_irq(hwdev, eq->eq_irq.irq_id);
+	}
+
+	for (ceq_event = 0; ceq_event < HINIC3_MAX_CEQ_EVENTS; ceq_event++)
+		hinic3_ceq_unregister_cb(hwdev, ceq_event);
+
+	kfree(ceqs);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
new file mode 100644
index 000000000000..32739d6e5346
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_EQS_H
+#define HINIC3_EQS_H
+
+#include <linux/interrupt.h>
+
+#include "hinic3_queue_common.h"
+#include "hinic3_hw_cfg.h"
+
+#define HINIC3_MAX_AEQS              4
+#define HINIC3_MAX_CEQS              32
+
+#define HINIC3_AEQ_MAX_PAGES         4
+#define HINIC3_CEQ_MAX_PAGES         8
+
+#define HINIC3_AEQE_SIZE             64
+#define HINIC3_CEQE_SIZE             4
+
+#define HINIC3_AEQE_DESC_SIZE        4
+#define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
+
+#define HINIC3_DEFAULT_AEQ_LEN       0x10000
+#define HINIC3_DEFAULT_CEQ_LEN       0x10000
+
+#define EQ_IRQ_NAME_LEN              64
+
+#define EQ_USLEEP_LOW_BOUND          900
+#define EQ_USLEEP_HIG_BOUND          1000
+
+enum hinic3_eq_type {
+	HINIC3_AEQ = 0,
+	HINIC3_CEQ = 1,
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
+	struct irq_info           eq_irq;
+	char                      irq_name[EQ_IRQ_NAME_LEN];
+	struct work_struct        aeq_work;
+	struct tasklet_struct     ceq_tasklet;
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
+typedef void (*hinic3_aeq_event_cb)(struct hinic3_hwdev *hwdev, u8 *data, u8 size);
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
+enum hinic3_ceq_cb_state {
+	HINIC3_CEQ_CB_REG     = 0,
+	HINIC3_CEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_ceq_event {
+	HINIC3_CMDQ               = 3,
+	HINIC3_MAX_CEQ_EVENTS     = 6,
+};
+
+typedef void (*hinic3_ceq_event_cb)(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+struct hinic3_ceqs {
+	struct hinic3_hwdev *hwdev;
+
+	hinic3_ceq_event_cb ceq_cb[HINIC3_MAX_CEQ_EVENTS];
+	unsigned long       ceq_cb_state[HINIC3_MAX_CEQ_EVENTS];
+
+	struct hinic3_eq    ceq[HINIC3_MAX_CEQS];
+	u16                 num_ceqs;
+};
+
+int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
+		     struct irq_info *msix_entries);
+void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_aeq_type event,
+			   hinic3_aeq_event_cb hwe_cb);
+void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_aeq_type event);
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct irq_info *msix_entries);
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback);
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index be1bc3f47c08..08121b3112cc 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -11,6 +11,48 @@
 #define IS_NIC_TYPE(hwdev) \
 	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & BIT(SERVICE_T_NIC))
 
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
+		      struct irq_info *alloc_arr, u16 *act_num)
+{
+	struct cfg_irq_alloc_info *curr;
+	struct cfg_irq_info *irq_info;
+	u16 i, found = 0;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq && found < num; i++) {
+		curr = irq_info->alloc_info + i;
+		if (curr->allocated)
+			continue;
+		curr->allocated = true;
+		alloc_arr[found].msix_entry_idx = curr->info.msix_entry_idx;
+		alloc_arr[found].irq_id = curr->info.irq_id;
+		found++;
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+
+	*act_num = found;
+	return found == 0 ? -ENOMEM : 0;
+}
+
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
+{
+	struct cfg_irq_alloc_info *curr;
+	struct cfg_irq_info *irq_info;
+	u16 i;
+
+	irq_info = &hwdev->cfg_mgmt->irq_info;
+	mutex_lock(&irq_info->irq_mutex);
+	for (i = 0; i < irq_info->num_irq; i++) {
+		curr = irq_info->alloc_info + i;
+		if (curr->info.irq_id == irq_id) {
+			curr->allocated = false;
+			break;
+		}
+	}
+	mutex_unlock(&irq_info->irq_mutex);
+}
+
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 {
 	if (!IS_NIC_TYPE(hwdev))
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index fc2efcfd22a1..3147afc8391d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -15,6 +15,37 @@ static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void
 					in_size, buf_out, out_size, 0);
 }
 
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct interrupt_info *info)
+{
+	struct comm_cmd_msix_config msix_cfg;
+	u32 out_size = sizeof(msix_cfg);
+	int err;
+
+	memset(&msix_cfg, 0, sizeof(msix_cfg));
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_SET;
+
+	msix_cfg.lli_credit_cnt = info->lli_credit_limit;
+	msix_cfg.lli_timer_cnt = info->lli_timer_cfg;
+	msix_cfg.pending_cnt = info->pending_limt;
+	msix_cfg.coalesce_timer_cnt = info->coalesc_timer_cfg;
+	msix_cfg.resend_timer_cnt = info->resend_timer_cfg;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_CFG_MSIX_CTRL_REG,
+				    &msix_cfg, sizeof(msix_cfg), &msix_cfg,
+				    &out_size);
+	if (err || !out_size || msix_cfg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set interrupt config, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, msix_cfg.head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 {
 	struct comm_cmd_func_reset func_reset;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index cb60d7d7826d..2d747270515e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -8,6 +8,19 @@
 
 struct hinic3_hwdev;
 
+struct interrupt_info {
+	u32 lli_set;
+	u32 interrupt_coalesc_set;
+	u16 msix_index;
+	u8  lli_credit_limit;
+	u8  lli_timer_cfg;
+	u8  pending_limt;
+	u8  coalesc_timer_cfg;
+	u8  resend_timer_cfg;
+};
+
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct interrupt_info *info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 5c2f8383bcbb..229256780a0b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/bits.h>
 
+#define MGMT_MSG_CMD_OP_SET   1
+#define MGMT_MSG_CMD_OP_GET   0
 #define MGMT_CMD_UNSUPPORTED  0xFF
 
 struct mgmt_msg_head {
@@ -52,6 +54,20 @@ enum hinic3_mgmt_cmd {
 	COMM_MGMT_CMD_SET_DMA_ATTR            = 25,
 };
 
+struct comm_cmd_msix_config {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u16                  msix_index;
+	u8                   pending_cnt;
+	u8                   coalesce_timer_cnt;
+	u8                   resend_timer_cnt;
+	u8                   lli_timer_cnt;
+	u8                   lli_credit_cnt;
+	u8                   rsvd2[5];
+};
+
 enum func_reset_type_bits {
 	RESET_TYPE_FLUSH        = BIT(0),
 	RESET_TYPE_MQM          = BIT(1),
@@ -82,4 +98,31 @@ struct comm_cmd_feature_nego {
 	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
 };
 
+enum hinic3_cmdq_type {
+	HINIC3_CMDQ_SYNC = 0,
+	HINIC3_MAX_CMDQ_TYPES = 4
+};
+
+struct comm_cmd_ceq_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  q_id;
+	u32                  ctrl0;
+	u32                  ctrl1;
+	u32                  rsvd1;
+};
+
+struct cmdq_ctxt_info {
+	u64 curr_wqe_page_pfn;
+	u64 wq_block_pfn;
+};
+
+struct comm_cmd_cmdq_ctxt {
+	struct mgmt_msg_head  head;
+	u16                   func_id;
+	u8                    cmdq_id;
+	u8                    rsvd1[5];
+	struct cmdq_ctxt_info ctxt;
+};
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 4e12670a9440..1cbaf543cb52 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -8,6 +8,162 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_common.h"
 #include "hinic3_hwif.h"
+#include "hinic3_csr.h"
+
+/* config BAR45 4MB, DB & DWQE both 2MB */
+#define HINIC3_DB_DWQE_SIZE  0x00400000
+
+/* db/dwqe page size: 4K */
+#define HINIC3_DB_PAGE_SIZE  0x00001000ULL
+#define HINIC3_DWQE_OFFSET   0x00000800ULL
+#define HINIC3_DB_MAX_AREAS  (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
+
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
+static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 pg_idx;
+
+	spin_lock(&db_area->idx_lock);
+	pg_idx = (u32)find_first_zero_bit(db_area->db_bitmap_array,
+					  db_area->db_max_areas);
+	if (pg_idx == db_area->db_max_areas) {
+		spin_unlock(&db_area->idx_lock);
+		return -ENOMEM;
+	}
+	set_bit(pg_idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+
+	*idx = pg_idx;
+
+	return 0;
+}
+
+static void free_db_idx(struct hinic3_hwif *hwif, u32 idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+
+	spin_lock(&db_area->idx_lock);
+	clear_bit(idx, db_area->db_bitmap_array);
+	spin_unlock(&db_area->idx_lock);
+}
+
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const void __iomem *db_base,
+			 void __iomem *dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	uintptr_t distance;
+	u32 idx;
+
+	hwif = hwdev->hwif;
+	distance = (const char __iomem *)db_base - (const char __iomem *)hwif->db_base;
+	idx = distance / HINIC3_DB_PAGE_SIZE;
+
+	free_db_idx(hwif, idx);
+}
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base)
+{
+	struct hinic3_hwif *hwif;
+	u8 __iomem *addr;
+	u32 idx;
+	int err;
+
+	hwif = hwdev->hwif;
+
+	err = get_db_idx(hwif, &idx);
+	if (err)
+		return -EFAULT;
+
+	addr = hwif->db_base + idx * HINIC3_DB_PAGE_SIZE;
+	*db_base = addr;
+
+	if (dwqe_base)
+		*dwqe_base = addr + HINIC3_DWQE_OFFSET;
+
+	return 0;
+}
+
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+			   enum hinic3_msix_state flag)
+{
+	struct hinic3_hwif *hwif;
+	u8 int_msk = 1;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
+}
+
+void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en)
+{
+	struct hinic3_hwif *hwif;
+	u32 msix_ctrl, addr;
+
+	hwif = hwdev->hwif;
+
+	msix_ctrl = HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |
+		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);
+}
+
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag)
+{
+	struct hinic3_hwif *hwif;
+	u32 mask_bits;
+	u32 addr;
+
+	hwif = hwdev->hwif;
+
+	if (flag)
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);
+	else
+		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);
+
+	mask_bits = mask_bits |
+		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
+
+	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
+	hinic3_hwif_write_reg(hwif, addr, mask_bits);
+}
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index da502c4b6efb..ebfaf2c49c3a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -45,6 +45,31 @@ struct hinic3_hwif {
 	struct hinic3_func_attr attr;
 };
 
+enum hinic3_msix_state {
+	HINIC3_MSIX_ENABLE,
+	HINIC3_MSIX_DISABLE,
+};
+
+enum hinic3_msix_auto_mask {
+	HINIC3_CLR_MSIX_AUTO_MASK,
+	HINIC3_SET_MSIX_AUTO_MASK,
+};
+
+u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
+void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
+
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base);
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const void __iomem *db_base,
+			 void __iomem *dwqe_base);
+
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+			   enum hinic3_msix_state flag);
+void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				       u8 clear_resend_en);
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag);
+
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
new file mode 100644
index 000000000000..28605e244d53
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/netdevice.h>
+
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_rx.h"
+#include "hinic3_tx.h"
+#include "hinic3_hwif.h"
+
+static int hinic3_poll(struct napi_struct *napi, int budget)
+{
+	struct hinic3_irq *irq_cfg =
+		container_of(napi, struct hinic3_irq, napi);
+	struct hinic3_nic_dev *nic_dev;
+	int tx_pkts, rx_pkts;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	rx_pkts = hinic3_rx_poll(irq_cfg->rxq, budget);
+
+	tx_pkts = hinic3_tx_poll(irq_cfg->txq, budget);
+	if (tx_pkts >= budget || rx_pkts >= budget)
+		return budget;
+
+	napi_complete(napi);
+
+	hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+			      HINIC3_MSIX_ENABLE);
+
+	return max(tx_pkts, rx_pkts);
+}
+
+static void qp_add_napi(struct hinic3_irq *irq_cfg)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
+
+	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);
+	napi_enable(&irq_cfg->napi);
+}
+
+static void qp_del_napi(struct hinic3_irq *irq_cfg)
+{
+	napi_disable(&irq_cfg->napi);
+	netif_napi_del(&irq_cfg->napi);
+}
+
+static irqreturn_t qp_irq(int irq, void *data)
+{
+	struct hinic3_irq *irq_cfg = data;
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev, irq_cfg->msix_entry_idx, 1);
+
+	napi_schedule(&irq_cfg->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_request_irq(struct hinic3_irq *irq_cfg, u16 q_id)
+{
+	struct interrupt_info info = {};
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	int err;
+
+	netdev = irq_cfg->netdev;
+	nic_dev = netdev_priv(netdev);
+	qp_add_napi(irq_cfg);
+
+	info.msix_index = irq_cfg->msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = nic_dev->intr_coalesce[q_id].pending_limt;
+	info.coalesc_timer_cfg =
+		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
+	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
+	if (err) {
+		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	err = request_irq(irq_cfg->irq_id, qp_irq, 0, irq_cfg->irq_name, irq_cfg);
+	if (err) {
+		netdev_err(netdev, "Failed to request Rx irq\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	irq_set_affinity_hint(irq_cfg->irq_id, &irq_cfg->affinity_mask);
+	return 0;
+}
+
+static void hinic3_release_irq(struct hinic3_irq *irq_cfg)
+{
+	irq_set_affinity_hint(irq_cfg->irq_id, NULL);
+	synchronize_irq(irq_cfg->irq_id);
+	free_irq(irq_cfg->irq_id, irq_cfg);
+	qp_del_napi(irq_cfg);
+}
+
+int hinic3_qps_irq_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct irq_info *qp_irq_info;
+	struct hinic3_irq *irq_cfg;
+	u32 local_cpu;
+	u16 q_id, i;
+	int err;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		qp_irq_info = &nic_dev->qps_irq_info[q_id];
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+
+		irq_cfg->irq_id = qp_irq_info->irq_id;
+		irq_cfg->msix_entry_idx = qp_irq_info->msix_entry_idx;
+		irq_cfg->netdev = netdev;
+		irq_cfg->txq = &nic_dev->txqs[q_id];
+		irq_cfg->rxq = &nic_dev->rxqs[q_id];
+		nic_dev->rxqs[q_id].irq_cfg = irq_cfg;
+
+		local_cpu = cpumask_local_spread(q_id, dev_to_node(&pdev->dev));
+		cpumask_set_cpu(local_cpu, &irq_cfg->affinity_mask);
+
+		snprintf(irq_cfg->irq_name, sizeof(irq_cfg->irq_name),
+			 "%s_qp%u", netdev->name, q_id);
+
+		err = hinic3_request_irq(irq_cfg, q_id);
+		if (err) {
+			netdev_err(netdev, "Failed to request Rx irq\n");
+			goto err_req_tx_irq;
+		}
+
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+						HINIC3_SET_MSIX_AUTO_MASK);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx, HINIC3_MSIX_ENABLE);
+	}
+
+	return 0;
+
+err_req_tx_irq:
+	for (i = 0; i < q_id; i++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[i];
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx, HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+
+	return err;
+}
+
+void hinic3_qps_irq_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_irq *irq_cfg;
+	u16 q_id;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index 73b0357c0a07..2a3491aff04e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -7,11 +7,838 @@
 #include "hinic3_common.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
+#include "hinic3_csr.h"
+
+#define HINIC3_MBOX_INT_DST_AEQN_MASK        GENMASK(11, 10)
+#define HINIC3_MBOX_INT_SRC_RESP_AEQN_MASK   GENMASK(13, 12)
+#define HINIC3_MBOX_INT_STAT_DMA_MASK        GENMASK(19, 14)
+/* TX size, expressed in 4 bytes units */
+#define HINIC3_MBOX_INT_TX_SIZE_MASK         GENMASK(24, 20)
+/* SO_RO == strong order, relaxed order */
+#define HINIC3_MBOX_INT_STAT_DMA_SO_RO_MASK  GENMASK(26, 25)
+#define HINIC3_MBOX_INT_WB_EN_MASK           BIT(28)
+#define HINIC3_MBOX_INT_SET(val, field)  \
+	FIELD_PREP(HINIC3_MBOX_INT_##field##_MASK, val)
+
+#define HINIC3_MBOX_CTRL_TRIGGER_AEQE_MASK   BIT(0)
+#define HINIC3_MBOX_CTRL_TX_STATUS_MASK      BIT(1)
+#define HINIC3_MBOX_CTRL_DST_FUNC_MASK       GENMASK(28, 16)
+#define HINIC3_MBOX_CTRL_SET(val, field)  \
+	FIELD_PREP(HINIC3_MBOX_CTRL_##field##_MASK, val)
+
+#define MBOX_MSG_POLLING_TIMEOUT  8000
+#define HINIC3_MBOX_COMP_TIME     40000U
+
+#define MBOX_MAX_BUF_SZ           2048U
+#define MBOX_HEADER_SZ            8
+
+/* MBOX size is 64B, 8B for mbox_header, 8B reserved */
+#define MBOX_SEG_LEN              48
+#define MBOX_SEG_LEN_ALIGN        4
+#define MBOX_WB_STATUS_LEN        16UL
+
+#define SEQ_ID_START_VAL          0
+#define SEQ_ID_MAX_VAL            42
+#define MBOX_LAST_SEG_MAX_LEN  \
+	(MBOX_MAX_BUF_SZ - SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
+
+/* mbox write back status is 16B, only first 4B is used */
+#define MBOX_WB_STATUS_ERRCODE_MASK       0xFFFF
+#define MBOX_WB_STATUS_MASK               0xFF
+#define MBOX_WB_ERROR_CODE_MASK           0xFF00
+#define MBOX_WB_STATUS_FINISHED_SUCCESS   0xFF
+#define MBOX_WB_STATUS_NOT_FINISHED       0x00
+
+#define MBOX_STATUS_FINISHED(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
+#define MBOX_STATUS_SUCCESS(wb)  \
+	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
+#define MBOX_STATUS_ERRCODE(wb)  \
+	((wb) & MBOX_WB_ERROR_CODE_MASK)
+
+#define MBOX_DMA_MSG_QUEUE_DEPTH    32
+#define MBOX_BODY_FROM_HDR(header)  ((u8 *)(header) + MBOX_HEADER_SZ)
+#define MBOX_AREA(hwif)  \
+	((hwif)->cfg_regs_base + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF)
+
+#define MBOX_MQ_CI_OFFSET  \
+	(HINIC3_CFG_REGS_FLAG + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF + \
+	 MBOX_HEADER_SZ + MBOX_SEG_LEN)
+
+#define MBOX_MQ_SYNC_CI_MASK   GENMASK(7, 0)
+#define MBOX_MQ_ASYNC_CI_MASK  GENMASK(15, 8)
+#define MBOX_MQ_CI_GET(val, field)  \
+	FIELD_GET(MBOX_MQ_##field##_CI_MASK, val)
+
+static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
+						 enum hinic3_msg_direction_type dir,
+						 u16 src_func_id)
+{
+	struct hinic3_msg_channel *msg_ch;
+
+	msg_ch = (src_func_id == HINIC3_MGMT_FUNC_ID) ?
+		&mbox->mgmt_msg : mbox->func_msg;
+	return (dir == HINIC3_MSG_DIRECT_SEND) ?
+		&msg_ch->recv_msg : &msg_ch->resp_msg;
+}
+
+static void resp_mbox_handler(struct hinic3_mbox *mbox,
+			      const struct hinic3_msg_desc *msg_desc)
+{
+	spin_lock(&mbox->mbox_lock);
+	if (msg_desc->msg_info.msg_id == mbox->send_msg_id &&
+	    mbox->event_flag == EVENT_START)
+		mbox->event_flag = EVENT_SUCCESS;
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static bool mbox_segment_valid(struct hinic3_mbox *mbox,
+			       struct hinic3_msg_desc *msg_desc,
+			       u64 mbox_header)
+{
+	u8 seq_id, seg_len, msg_id, mod;
+	u16 src_func_idx, cmd;
+
+	seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+	msg_id = HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);
+	mod = HINIC3_MSG_HEADER_GET(mbox_header, MODULE);
+	cmd = HINIC3_MSG_HEADER_GET(mbox_header, CMD);
+	src_func_idx = HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+
+	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
+		goto err_seg;
+
+	if (seq_id == 0) {
+		msg_desc->seq_id = seq_id;
+		msg_desc->msg_info.msg_id = msg_id;
+		msg_desc->mod = mod;
+		msg_desc->cmd = cmd;
+	} else {
+		if (seq_id != msg_desc->seq_id + 1 || msg_id != msg_desc->msg_info.msg_id ||
+		    mod != msg_desc->mod || cmd != msg_desc->cmd)
+			goto err_seg;
+
+		msg_desc->seq_id = seq_id;
+	}
+
+	return true;
+
+err_seg:
+	dev_err(mbox->hwdev->dev,
+		"Mailbox segment check failed, src func id: 0x%x, front seg info: seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		src_func_idx, msg_desc->seq_id, msg_desc->msg_info.msg_id,
+		msg_desc->mod, msg_desc->cmd);
+	dev_err(mbox->hwdev->dev,
+		"Current seg info: seg len: 0x%x, seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
+		seg_len, seq_id, msg_id, mod, cmd);
+
+	return false;
+}
+
+static void recv_mbox_handler(struct hinic3_mbox *mbox,
+			      u64 *header, struct hinic3_msg_desc *msg_desc)
+{
+	void *mbox_body = MBOX_BODY_FROM_HDR(((void *)header));
+	u64 mbox_header = *header;
+	u8 seq_id, seg_len;
+	int pos;
+
+	if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
+		msg_desc->seq_id = SEQ_ID_MAX_VAL;
+		return;
+	}
+
+	seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+
+	pos = seq_id * MBOX_SEG_LEN;
+	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);
+
+	if (!HINIC3_MSG_HEADER_GET(mbox_header, LAST))
+		return;
+
+	msg_desc->msg_len = HINIC3_MSG_HEADER_GET(mbox_header, MSG_LEN);
+	msg_desc->msg_info.status = HINIC3_MSG_HEADER_GET(mbox_header, STATUS);
+
+	if (HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION) ==
+	    HINIC3_MSG_RESPONSE) {
+		resp_mbox_handler(mbox, msg_desc);
+		return;
+	}
+}
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size)
+{
+	u64 mbox_header = *((u64 *)header);
+	enum hinic3_msg_direction_type dir;
+	struct hinic3_mbox *mbox;
+	struct hinic3_msg_desc *msg_desc;
+	u16 src_func_id;
+
+	mbox = hwdev->mbox;
+	dir = HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION);
+	src_func_id = HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
+	recv_mbox_handler(mbox, (u64 *)header, msg_desc);
+}
+
+static int init_mbox_dma_queue(struct hinic3_hwdev *hwdev, struct mbox_dma_queue *mq)
+{
+	u32 size;
+
+	mq->depth = MBOX_DMA_MSG_QUEUE_DEPTH;
+	mq->prod_idx = 0;
+	mq->cons_idx = 0;
+
+	size = mq->depth * MBOX_MAX_BUF_SZ;
+	mq->dma_buff_vaddr = dma_alloc_coherent(hwdev->dev, size, &mq->dma_buff_paddr,
+						GFP_KERNEL);
+	if (!mq->dma_buff_vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void deinit_mbox_dma_queue(struct hinic3_hwdev *hwdev, struct mbox_dma_queue *mq)
+{
+	dma_free_coherent(hwdev->dev, mq->depth * MBOX_MAX_BUF_SZ,
+			  mq->dma_buff_vaddr, mq->dma_buff_paddr);
+}
+
+static int hinic3_init_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	u32 val;
+	int err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	if (err)
+		return err;
+
+	err = init_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+	if (err) {
+		deinit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+		return err;
+	}
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	val &= ~MBOX_MQ_SYNC_CI_MASK;
+	val &= ~MBOX_MQ_ASYNC_CI_MASK;
+	hinic3_hwif_write_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET, val);
+
+	return 0;
+}
+
+static void hinic3_deinit_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	deinit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	deinit_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
+}
+
+static int alloc_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	msg_ch->resp_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->resp_msg.msg)
+		return -ENOMEM;
+
+	msg_ch->recv_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
+	if (!msg_ch->recv_msg.msg) {
+		kfree(msg_ch->resp_msg.msg);
+		return -ENOMEM;
+	}
+
+	msg_ch->resp_msg.seq_id = SEQ_ID_MAX_VAL;
+	msg_ch->recv_msg.seq_id = SEQ_ID_MAX_VAL;
+	return 0;
+}
+
+static void free_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
+{
+	kfree(msg_ch->recv_msg.msg);
+	kfree(msg_ch->resp_msg.msg);
+}
+
+static int init_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	int err;
+
+	err = alloc_mbox_msg_channel(&mbox->mgmt_msg);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to alloc mgmt message channel\n");
+		return err;
+	}
+
+	err = hinic3_init_mbox_dma_queue(mbox);
+	if (err) {
+		dev_err(mbox->hwdev->dev, "Failed to init mbox dma queue\n");
+		free_mbox_msg_channel(&mbox->mgmt_msg);
+	}
+
+	return err;
+}
+
+static void deinit_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	hinic3_deinit_mbox_dma_queue(mbox);
+	free_mbox_msg_channel(&mbox->mgmt_msg);
+}
+
+static int hinic3_init_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox;
+	int err;
+
+	mbox = hwdev->mbox;
+	mbox->func_msg = kzalloc(sizeof(*mbox->func_msg), GFP_KERNEL);
+	if (!mbox->func_msg)
+		return -ENOMEM;
+
+	err = alloc_mbox_msg_channel(mbox->func_msg);
+	if (err)
+		goto err_undo_alloc_func_msg;
+
+	return 0;
+
+err_undo_alloc_func_msg:
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+	return -ENOMEM;
+}
+
+static void hinic3_deinit_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+
+	free_mbox_msg_channel(mbox->func_msg);
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+}
+
+static void prepare_send_mbox(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+
+	send_mbox->data = MBOX_AREA(mbox->hwdev->hwif);
+}
+
+static int alloc_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u32 addr_h, addr_l;
+
+	send_mbox->wb_vaddr = dma_alloc_coherent(hwdev->dev,
+						 MBOX_WB_STATUS_LEN,
+						 &send_mbox->wb_paddr,
+						 GFP_KERNEL);
+	if (!send_mbox->wb_vaddr)
+		return -ENOMEM;
+
+	addr_h = upper_32_bits(send_mbox->wb_paddr);
+	addr_l = lower_32_bits(send_mbox->wb_paddr);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      addr_h);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      addr_l);
+
+	return 0;
+}
+
+static void free_mbox_wb_status(struct hinic3_mbox *mbox)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
+			      0);
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
+			      0);
+
+	dma_free_coherent(hwdev->dev, MBOX_WB_STATUS_LEN,
+			  send_mbox->wb_vaddr, send_mbox->wb_paddr);
+}
+
+static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
+				struct hinic3_mbox **mbox)
+{
+	(*mbox) = kzalloc(sizeof(struct hinic3_mbox), GFP_KERNEL);
+	if (!(*mbox))
+		return -ENOMEM;
+
+	(*mbox)->hwdev = hwdev;
+	mutex_init(&(*mbox)->mbox_send_lock);
+	mutex_init(&(*mbox)->msg_send_lock);
+	spin_lock_init(&(*mbox)->mbox_lock);
+
+	(*mbox)->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
+	if (!(*mbox)->workq) {
+		dev_err(hwdev->dev, "Failed to initialize MBOX workqueue\n");
+		kfree((*mbox));
+		return -ENOMEM;
+	}
+	hwdev->mbox = (*mbox);
+
+	return 0;
+}
+
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox;
+	int err;
+
+	err = hinic3_mbox_pre_init(hwdev, &mbox);
+	if (err)
+		return err;
+
+	err = init_mgmt_msg_channel(mbox);
+	if (err)
+		goto err_init_mgmt_msg_ch;
+
+	err = hinic3_init_func_mbox_msg_channel(hwdev);
+	if (err)
+		goto err_init_func_msg_ch;
+
+	err = alloc_mbox_wb_status(mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
+		goto err_alloc_wb_status;
+	}
+
+	prepare_send_mbox(mbox);
+
+	return 0;
+
+err_alloc_wb_status:
+	hinic3_deinit_func_mbox_msg_channel(hwdev);
+
+err_init_func_msg_ch:
+	deinit_mgmt_msg_channel(mbox);
+
+err_init_mgmt_msg_ch:
+	destroy_workqueue(mbox->workq);
+	kfree(mbox);
+
+	return err;
+}
+
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+
+	destroy_workqueue(mbox->workq);
+	free_mbox_wb_status(mbox);
+	hinic3_deinit_func_mbox_msg_channel(hwdev);
+	deinit_mgmt_msg_channel(mbox);
+	kfree(mbox);
+}
+
+#define MBOX_DMA_MSG_INIT_XOR_VAL    0x5a5a5a5a
+#define MBOX_XOR_DATA_ALIGN          4
+static u32 mbox_dma_msg_xor(u32 *data, u32 msg_len)
+{
+	u32 xor = MBOX_DMA_MSG_INIT_XOR_VAL;
+	u32 dw_len = msg_len / sizeof(u32);
+	u32 i;
+
+	for (i = 0; i < dw_len; i++)
+		xor ^= data[i];
+
+	return xor;
+}
+
+#define MQ_ID_MASK(mq, idx)    ((idx) & ((mq)->depth - 1))
+#define IS_MSG_QUEUE_FULL(mq) \
+	(MQ_ID_MASK(mq, (mq)->prod_idx + 1) == MQ_ID_MASK(mq, (mq)->cons_idx))
+
+static int mbox_prepare_dma_entry(struct hinic3_mbox *mbox, struct mbox_dma_queue *mq,
+				  struct mbox_dma_msg *dma_msg, const void *msg, u32 msg_len)
+{
+	u64 dma_addr, offset;
+	void *dma_vaddr;
+
+	if (IS_MSG_QUEUE_FULL(mq)) {
+		dev_err(mbox->hwdev->dev, "Mbox sync message queue is busy, pi: %u, ci: %u\n",
+			mq->prod_idx, MQ_ID_MASK(mq, mq->cons_idx));
+		return -EBUSY;
+	}
+
+	/* copy data to DMA buffer */
+	offset = mq->prod_idx * MBOX_MAX_BUF_SZ;
+	dma_vaddr = (u8 *)mq->dma_buff_vaddr + offset;
+	memcpy(dma_vaddr, msg, msg_len);
+	dma_addr = mq->dma_buff_paddr + offset;
+	dma_msg->dma_addr_high = upper_32_bits(dma_addr);
+	dma_msg->dma_addr_low = lower_32_bits(dma_addr);
+	dma_msg->msg_len = msg_len;
+	/* The firmware obtains message based on 4B alignment. */
+	dma_msg->xor = mbox_dma_msg_xor(dma_vaddr, ALIGN(msg_len, MBOX_XOR_DATA_ALIGN));
+	mq->prod_idx++;
+	mq->prod_idx = MQ_ID_MASK(mq, mq->prod_idx);
+	return 0;
+}
+
+static int mbox_prepare_dma_msg(struct hinic3_mbox *mbox, enum hinic3_msg_ack_type ack_type,
+				struct mbox_dma_msg *dma_msg, const void *msg, u32 msg_len)
+{
+	struct mbox_dma_queue *mq;
+	u32 val;
+
+	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
+	if (ack_type == HINIC3_MSG_ACK) {
+		mq = &mbox->sync_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, SYNC);
+	} else {
+		mq = &mbox->async_msg_queue;
+		mq->cons_idx = MBOX_MQ_CI_GET(val, ASYNC);
+	}
+
+	return mbox_prepare_dma_entry(mbox, mq, dma_msg, msg, msg_len);
+}
+
+static void clear_mbox_status(struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+
+	*wb_status = 0;
+	/* clear mailbox write back status */
+	wmb();
+}
+
+static void mbox_dword_write(const void *src, void __iomem *dst, u32 count)
+{
+	u32 __iomem *dst32 = dst;
+	const u32 *src32 = src;
+	u32 i;
+
+	/* Data written to mbox is arranged in structs with little endian fields
+	 * but when written to HW every dword (32bits) should be swapped since
+	 * the HW will swap it again. This is a mandatory swap regardless of the
+	 * CPU endianness.
+	 */
+	for (i = 0; i < count; i++)
+		__raw_writel(swab32(src32[i]), dst32 + i);
+}
+
+static void mbox_copy_header(struct hinic3_hwdev *hwdev,
+			     struct hinic3_send_mbox *mbox, u64 *header)
+{
+	mbox_dword_write(header, mbox->data, MBOX_HEADER_SZ / sizeof(u32));
+}
+
+static void mbox_copy_send_data(struct hinic3_hwdev *hwdev,
+				struct hinic3_send_mbox *mbox, void *seg,
+				u32 seg_len)
+{
+	u32 __iomem *dst = (u32 __iomem *)(mbox->data + MBOX_HEADER_SZ);
+	u32 count, leftover, last_dword;
+	const u32 *src = seg;
+
+	count = seg_len / sizeof(u32);
+	leftover = seg_len % sizeof(u32);
+	if (count > 0)
+		mbox_dword_write(src, dst, count);
+
+	if (leftover > 0) {
+		last_dword = 0;
+		memcpy(&last_dword, src + count, leftover);
+		mbox_dword_write(&last_dword, dst + count, 1);
+	}
+}
+
+static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
+				u16 dst_func, u16 dst_aeqn, u32 seg_len)
+{
+	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
+	u32 mbox_int, mbox_ctrl, tx_size;
+
+	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
+
+	mbox_int = HINIC3_MBOX_INT_SET(dst_aeqn, DST_AEQN) |
+		   HINIC3_MBOX_INT_SET(0, STAT_DMA) |
+		   HINIC3_MBOX_INT_SET(tx_size, TX_SIZE) |
+		   HINIC3_MBOX_INT_SET(0, STAT_DMA_SO_RO) |
+		   HINIC3_MBOX_INT_SET(1, WB_EN);
+
+	mbox_ctrl = HINIC3_MBOX_CTRL_SET(1, TX_STATUS) |
+		    HINIC3_MBOX_CTRL_SET(0, TRIGGER_AEQE) |
+		    HINIC3_MBOX_CTRL_SET(dst_func, DST_FUNC);
+
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
+	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF, mbox_ctrl);
+}
+
+static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
+{
+	__be64 *wb_status = mbox->wb_vaddr;
+	u64 wb_val;
+
+	wb_val = be64_to_cpu(*wb_status);
+	/* verify reading before check */
+	rmb();
+	return (u16)(wb_val & MBOX_WB_STATUS_ERRCODE_MASK);
+}
+
+static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+	u16 wb_status;
+
+	wb_status = get_mbox_status(&mbox->send_mbox);
+	return MBOX_STATUS_FINISHED(wb_status) ?
+		WAIT_PROCESS_CPL : WAIT_PROCESS_WAITING;
+}
+
+static int send_mbox_seg(struct hinic3_mbox *mbox, u64 header,
+			 u16 dst_func, void *seg, u32 seg_len, void *msg_info)
+{
+	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	u8 num_aeqs = hwdev->hwif->attr.num_aeqs;
+	enum hinic3_msg_direction_type dir;
+	u16 dst_aeqn, wb_status, errcode;
+	int err;
+
+	/* mbox to mgmt cpu, hardware doesn't care about dst aeq id */
+	if (num_aeqs > HINIC3_AEQ_FOR_MBOX) {
+		dir = HINIC3_MSG_HEADER_GET(header, DIRECTION);
+		dst_aeqn = (dir == HINIC3_MSG_DIRECT_SEND) ?
+			   HINIC3_AEQ_FOR_EVENT : HINIC3_AEQ_FOR_MBOX;
+	} else {
+		dst_aeqn = 0;
+	}
+
+	clear_mbox_status(send_mbox);
+	mbox_copy_header(hwdev, send_mbox, &header);
+	mbox_copy_send_data(hwdev, send_mbox, seg, seg_len);
+	write_mbox_msg_attr(mbox, dst_func, dst_aeqn, seg_len);
+
+	err = hinic3_wait_for_timeout(mbox, check_mbox_wb_status,
+				      MBOX_MSG_POLLING_TIMEOUT, USEC_PER_MSEC);
+	wb_status = get_mbox_status(send_mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
+			wb_status);
+		return -ETIMEDOUT;
+	}
+
+	if (!MBOX_STATUS_SUCCESS(wb_status)) {
+		dev_err(hwdev->dev, "Send mailbox segment to function %u error, wb status: 0x%x\n",
+			dst_func, wb_status);
+		errcode = MBOX_STATUS_ERRCODE(wb_status);
+		return errcode ? errcode : -EFAULT;
+	}
+
+	return 0;
+}
+
+static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
+			 const void *msg, u32 msg_len, u16 dst_func,
+			 enum hinic3_msg_direction_type direction,
+			 enum hinic3_msg_ack_type ack_type,
+			 struct mbox_msg_info *msg_info)
+{
+	enum hinic3_data_type data_type = HINIC3_DATA_INLINE;
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
+	struct mbox_dma_msg dma_msg;
+	u32 seg_len = MBOX_SEG_LEN;
+	u64 header = 0;
+	u32 seq_id = 0;
+	u16 rsp_aeq_id;
+	u8 *msg_seg;
+	int err = 0;
+	u32 left;
+
+	if (hwdev->hwif->attr.num_aeqs > HINIC3_AEQ_FOR_MBOX)
+		rsp_aeq_id = HINIC3_AEQ_FOR_MBOX;
+	else
+		rsp_aeq_id = 0;
+
+	mutex_lock(&mbox->msg_send_lock);
+
+	if (IS_DMA_MBX_MSG(dst_func) && !SUPPORT_SEGMENT(hwdev->features[0])) {
+		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg, msg, msg_len);
+		if (err)
+			goto err_send;
+
+		msg = &dma_msg;
+		msg_len = sizeof(dma_msg);
+		data_type = HINIC3_DATA_DMA;
+	}
+
+	msg_seg = (u8 *)msg;
+	left = msg_len;
+
+	header = HINIC3_MSG_HEADER_SET(msg_len, MSG_LEN) |
+		 HINIC3_MSG_HEADER_SET(mod, MODULE) |
+		 HINIC3_MSG_HEADER_SET(seg_len, SEG_LEN) |
+		 HINIC3_MSG_HEADER_SET(ack_type, NO_ACK) |
+		 HINIC3_MSG_HEADER_SET(data_type, DATA_TYPE) |
+		 HINIC3_MSG_HEADER_SET(SEQ_ID_START_VAL, SEQID) |
+		 HINIC3_MSG_HEADER_SET(NOT_LAST_SEGMENT, LAST) |
+		 HINIC3_MSG_HEADER_SET(direction, DIRECTION) |
+		 HINIC3_MSG_HEADER_SET(cmd, CMD) |
+		 HINIC3_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |
+		 HINIC3_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |
+		 HINIC3_MSG_HEADER_SET(HINIC3_MSG_FROM_MBOX, SOURCE) |
+		 HINIC3_MSG_HEADER_SET(!!msg_info->status, STATUS);
+
+	while (!(HINIC3_MSG_HEADER_GET(header, LAST))) {
+		if (left <= MBOX_SEG_LEN) {
+			header &= ~HINIC3_MSG_HEADER_SEG_LEN_MASK;
+			header |= HINIC3_MSG_HEADER_SET(left, SEG_LEN);
+			header |= HINIC3_MSG_HEADER_SET(LAST_SEGMENT, LAST);
+			seg_len = left;
+		}
+
+		err = send_mbox_seg(mbox, header, dst_func, msg_seg,
+				    seg_len, msg_info);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to send mbox seg, seq_id=0x%llx\n",
+				HINIC3_MSG_HEADER_GET(header, SEQID));
+			goto err_send;
+		}
+
+		left -= MBOX_SEG_LEN;
+		msg_seg += MBOX_SEG_LEN;
+		seq_id++;
+		header &= ~HINIC3_MSG_HEADER_SEG_LEN_MASK;
+		header |= HINIC3_MSG_HEADER_SET(seq_id, SEQID);
+	}
+
+err_send:
+	mutex_unlock(&mbox->msg_send_lock);
+	return err;
+}
+
+static void set_mbox_to_func_event(struct hinic3_mbox *mbox,
+				   enum mbox_event_state event_flag)
+{
+	spin_lock(&mbox->mbox_lock);
+	mbox->event_flag = event_flag;
+	spin_unlock(&mbox->mbox_lock);
+}
+
+static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
+{
+	struct hinic3_mbox *mbox = priv_data;
+
+	return (mbox->event_flag == EVENT_SUCCESS) ?
+		WAIT_PROCESS_CPL : WAIT_PROCESS_WAITING;
+}
+
+static int wait_mbox_msg_completion(struct hinic3_mbox *mbox,
+				    u32 timeout)
+{
+	u32 wait_time;
+	int err;
+
+	wait_time = (timeout != 0) ? timeout : HINIC3_MBOX_COMP_TIME;
+	err = hinic3_wait_for_timeout(mbox, check_mbox_msg_finish,
+				      wait_time, USEC_PER_MSEC);
+	if (err) {
+		set_mbox_to_func_event(mbox, EVENT_TIMEOUT);
+		return -ETIMEDOUT;
+	}
+	set_mbox_to_func_event(mbox, EVENT_END);
+	return 0;
+}
+
+static int hinic3_mbox_to_func(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+			       u16 dst_func, const void *buf_in, u32 in_size, void *buf_out,
+			       u32 *out_size, u32 timeout)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	struct mbox_msg_info msg_info = {};
+	struct hinic3_msg_desc *msg_desc;
+	int err;
+
+	/* expect response message */
+	msg_desc = get_mbox_msg_desc(mbox, HINIC3_MSG_RESPONSE, dst_func);
+	mutex_lock(&mbox->mbox_send_lock);
+	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;
+	mbox->send_msg_id = msg_info.msg_id;
+	set_mbox_to_func_event(mbox, EVENT_START);
+
+	err = send_mbox_msg(mbox, mod, cmd, buf_in, in_size, dst_func,
+			    HINIC3_MSG_DIRECT_SEND, HINIC3_MSG_ACK, &msg_info);
+	if (err) {
+		dev_err(hwdev->dev, "Send mailbox mod %u, cmd %u failed, msg_id: %u, err: %d\n",
+			mod, cmd, msg_info.msg_id, err);
+		set_mbox_to_func_event(mbox, EVENT_FAIL);
+		goto err_send;
+	}
+
+	if (wait_mbox_msg_completion(mbox, timeout)) {
+		dev_err(hwdev->dev,
+			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
+		err = -ETIMEDOUT;
+		goto err_send;
+	}
+
+	if (mod != msg_desc->mod || cmd != msg_desc->cmd) {
+		dev_err(hwdev->dev,
+			"Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0x%x, cmd: 0x%x\n",
+			msg_desc->mod, msg_desc->cmd, mod, cmd);
+		err = -EFAULT;
+		goto err_send;
+	}
+
+	if (msg_desc->msg_info.status) {
+		err = msg_desc->msg_info.status;
+		goto err_send;
+	}
+
+	if (buf_out && out_size) {
+		if (*out_size < msg_desc->msg_len) {
+			dev_err(hwdev->dev,
+				"Invalid response mbox message length: %u for mod %d cmd %u, should less than: %u\n",
+				msg_desc->msg_len, mod, cmd, *out_size);
+			err = -EFAULT;
+			goto err_send;
+		}
+
+		if (msg_desc->msg_len)
+			memcpy(buf_out, msg_desc->msg, msg_desc->msg_len);
+
+		*out_size = msg_desc->msg_len;
+	}
+
+err_send:
+	mutex_unlock(&mbox->mbox_send_lock);
+	return err;
+}
+
+static int hinic3_mbox_to_func_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				      u16 dst_func, const void *buf_in, u32 in_size)
+{
+	struct hinic3_mbox *mbox = hwdev->mbox;
+	struct mbox_msg_info msg_info = {};
+	int err;
+
+	mutex_lock(&mbox->mbox_send_lock);
+	err = send_mbox_msg(mbox, mod, cmd, buf_in, in_size,
+			    dst_func, HINIC3_MSG_DIRECT_SEND,
+			    HINIC3_MSG_NO_ACK, &msg_info);
+	if (err)
+		dev_err(hwdev->dev, "Send mailbox no ack failed\n");
+
+	mutex_unlock(&mbox->mbox_send_lock);
+
+	return err;
+}
 
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const void *buf_in, u32 in_size, void *buf_out,
 			     u32 *out_size, u32 timeout)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	return hinic3_mbox_to_func(hwdev, mod, cmd, HINIC3_MGMT_FUNC_ID,
+				   buf_in, in_size, buf_out, out_size, timeout);
+}
+
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const void *buf_in, u32 in_size)
+{
+	return hinic3_mbox_to_func_no_ack(hwdev, mod, cmd, HINIC3_MGMT_FUNC_ID,
+					  buf_in, in_size);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index 5a90420230b4..b841f270a9a5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -9,8 +9,139 @@
 
 struct hinic3_hwdev;
 
+#define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK  GENMASK_ULL(12, 0)
+#define HINIC3_MSG_HEADER_STATUS_MASK            BIT_ULL(13)
+#define HINIC3_MSG_HEADER_SOURCE_MASK            BIT_ULL(15)
+#define HINIC3_MSG_HEADER_AEQ_ID_MASK            GENMASK_ULL(17, 16)
+#define HINIC3_MSG_HEADER_MSG_ID_MASK            GENMASK_ULL(21, 18)
+#define HINIC3_MSG_HEADER_CMD_MASK               GENMASK_ULL(31, 22)
+#define HINIC3_MSG_HEADER_MSG_LEN_MASK           GENMASK_ULL(42, 32)
+#define HINIC3_MSG_HEADER_MODULE_MASK            GENMASK_ULL(47, 43)
+#define HINIC3_MSG_HEADER_SEG_LEN_MASK           GENMASK_ULL(53, 48)
+#define HINIC3_MSG_HEADER_NO_ACK_MASK            BIT_ULL(54)
+#define HINIC3_MSG_HEADER_DATA_TYPE_MASK         BIT_ULL(55)
+#define HINIC3_MSG_HEADER_SEQID_MASK             GENMASK_ULL(61, 56)
+#define HINIC3_MSG_HEADER_LAST_MASK              BIT_ULL(62)
+#define HINIC3_MSG_HEADER_DIRECTION_MASK         BIT_ULL(63)
+
+#define HINIC3_MSG_HEADER_SET(val, member) \
+	FIELD_PREP(HINIC3_MSG_HEADER_##member##_MASK, val)
+#define HINIC3_MSG_HEADER_GET(val, member) \
+	FIELD_GET(HINIC3_MSG_HEADER_##member##_MASK, val)
+
+#define HINIC3_MGMT_FUNC_ID       0x1FFF
+#define IS_DMA_MBX_MSG(dst_func)  ((dst_func) == HINIC3_MGMT_FUNC_ID)
+#define COMM_F_MBOX_SEGMENT       BIT(3)
+#define SUPPORT_SEGMENT(feature)  ((feature) & COMM_F_MBOX_SEGMENT)
+
+enum hinic3_msg_direction_type {
+	HINIC3_MSG_DIRECT_SEND = 0,
+	HINIC3_MSG_RESPONSE    = 1,
+};
+
+enum hinic3_msg_segment_type {
+	NOT_LAST_SEGMENT = 0,
+	LAST_SEGMENT     = 1,
+};
+
+enum hinic3_msg_ack_type {
+	HINIC3_MSG_ACK    = 0,
+	HINIC3_MSG_NO_ACK = 1,
+};
+
+enum hinic3_data_type {
+	HINIC3_DATA_INLINE = 0,
+	HINIC3_DATA_DMA    = 1,
+};
+
+enum hinic3_msg_src_type {
+	HINIC3_MSG_FROM_MBOX = 1,
+};
+
+enum hinic3_msg_aeq_type {
+	HINIC3_AEQ_FOR_EVENT = 0,
+	HINIC3_AEQ_FOR_MBOX  = 1,
+};
+
+#define HINIC3_MBOX_WQ_NAME  "hinic3_mbox"
+
+struct mbox_msg_info {
+	u8 msg_id;
+	u8 status;
+};
+
+struct hinic3_msg_desc {
+	void   *msg;
+	u16    msg_len;
+	u8     seq_id;
+	u8     mod;
+	u16    cmd;
+	struct mbox_msg_info msg_info;
+};
+
+struct hinic3_msg_channel {
+	struct   hinic3_msg_desc resp_msg;
+	struct   hinic3_msg_desc recv_msg;
+};
+
+struct hinic3_send_mbox {
+	u8 __iomem *data;
+	void       *wb_vaddr;
+	dma_addr_t wb_paddr;
+};
+
+enum mbox_event_state {
+	EVENT_START   = 0,
+	EVENT_FAIL    = 1,
+	EVENT_SUCCESS = 2,
+	EVENT_TIMEOUT = 3,
+	EVENT_END     = 4,
+};
+
+struct mbox_dma_msg {
+	u32 xor;
+	u32 dma_addr_high;
+	u32 dma_addr_low;
+	u32 msg_len;
+	u64 rsvd;
+};
+
+struct mbox_dma_queue {
+	void       *dma_buff_vaddr;
+	dma_addr_t dma_buff_paddr;
+	u16        depth;
+	u16        prod_idx;
+	u16        cons_idx;
+};
+
+struct hinic3_mbox {
+	struct hinic3_hwdev       *hwdev;
+	/* lock for send mbox message and ack message */
+	struct mutex              mbox_send_lock;
+	/* lock for send mbox message */
+	struct mutex              msg_send_lock;
+	struct hinic3_send_mbox   send_mbox;
+	struct mbox_dma_queue     sync_msg_queue;
+	struct mbox_dma_queue     async_msg_queue;
+	struct workqueue_struct   *workq;
+	/* driver and MGMT CPU */
+	struct hinic3_msg_channel mgmt_msg;
+	/* VF to PF */
+	struct hinic3_msg_channel *func_msg;
+	u8                        send_msg_id;
+	enum mbox_event_state     event_flag;
+	/* lock for mbox event flag */
+	spinlock_t                mbox_lock;
+};
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size);
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev);
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
+
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const void *buf_in, u32 in_size, void *buf_out,
 			     u32 *out_size, u32 timeout);
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+				    const void *buf_in, u32 in_size);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 4daacc7b03b0..86857cc920b6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -96,5 +96,7 @@ struct hinic3_nic_dev {
 };
 
 void hinic3_set_netdev_ops(struct net_device *netdev);
+int hinic3_qps_irq_init(struct net_device *netdev);
+void hinic3_qps_irq_deinit(struct net_device *netdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
index e4ed790f3de1..8e2e1ac30b45 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
@@ -6,6 +6,109 @@
 #include "hinic3_wq.h"
 #include "hinic3_hwdev.h"
 
+#define WQ_MIN_DEPTH            64
+#define WQ_MAX_DEPTH            65536
+#define WQ_PAGE_ADDR_SIZE       sizeof(u64)
+#define WQ_MAX_NUM_PAGES        (HINIC3_MIN_PAGE_SIZE / WQ_PAGE_ADDR_SIZE)
+
+static int wq_init_wq_block(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	int i;
+
+	if (WQ_IS_0_LEVEL_CLA(wq)) {
+		wq->wq_block_paddr = qpages->pages[0].align_paddr;
+		wq->wq_block_vaddr = qpages->pages[0].align_vaddr;
+
+		return 0;
+	}
+
+	if (wq->qpages.num_pages > WQ_MAX_NUM_PAGES) {
+		dev_err(hwdev->dev, "wq num_pages exceed limit: %lu\n",
+			WQ_MAX_NUM_PAGES);
+		return -EFAULT;
+	}
+
+	wq->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
+						HINIC3_MIN_PAGE_SIZE,
+						&wq->wq_block_paddr,
+						GFP_KERNEL);
+	if (!wq->wq_block_vaddr)
+		return -ENOMEM;
+
+	for (i = 0; i < qpages->num_pages; i++)
+		wq->wq_block_vaddr[i] = cpu_to_be64(qpages->pages[i].align_paddr);
+
+	return 0;
+}
+
+static int wq_alloc_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	int err;
+
+	err = queue_pages_alloc(hwdev, &wq->qpages, 0);
+	if (err)
+		return err;
+
+	err = wq_init_wq_block(hwdev, wq);
+	if (err) {
+		queue_pages_free(hwdev, &wq->qpages);
+		return err;
+	}
+
+	return 0;
+}
+
+static void wq_free_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	if (!WQ_IS_0_LEVEL_CLA(wq))
+		dma_free_coherent(hwdev->dev,
+				  HINIC3_MIN_PAGE_SIZE,
+				  wq->wq_block_vaddr,
+				  wq->wq_block_paddr);
+
+	queue_pages_free(hwdev, &wq->qpages);
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, u32 q_depth,
+		     u16 wqebb_size)
+{
+	u32 wq_page_size;
+
+	if (q_depth < WQ_MIN_DEPTH || q_depth > WQ_MAX_DEPTH ||
+	    !is_power_of_2(q_depth) || !is_power_of_2(wqebb_size)) {
+		dev_err(hwdev->dev, "Wq q_depth %u or wqebb_size %u is invalid\n",
+			q_depth, wqebb_size);
+		return -EINVAL;
+	}
+
+	wq_page_size = ALIGN(hwdev->wq_page_size, HINIC3_MIN_PAGE_SIZE);
+
+	memset(wq, 0, sizeof(*wq));
+	wq->q_depth = q_depth;
+	wq->idx_mask = (u16)(q_depth - 1);
+
+	queue_pages_init(&wq->qpages, q_depth, wq_page_size, wqebb_size);
+	return wq_alloc_pages(hwdev, wq);
+}
+
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
+{
+	wq_free_pages(hwdev, wq);
+}
+
+void hinic3_wq_reset(struct hinic3_wq *wq)
+{
+	struct hinic3_queue_pages *qpages = &wq->qpages;
+	u16 pg_idx;
+
+	wq->cons_idx = 0;
+	wq->prod_idx = 0;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++)
+		memset(qpages->pages[pg_idx].align_vaddr, 0, qpages->page_size);
+}
+
 void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
 				u16 num_wqebbs, u16 *prod_idx,
 				struct hinic3_sq_bufdesc **first_wqebb,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
index ca33f4176eea..dba7d2a0c5d8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
@@ -42,6 +42,9 @@ struct hinic3_wq {
 	__be64                    *wq_block_vaddr;
 } ____cacheline_aligned;
 
+#define WQ_IS_0_LEVEL_CLA(wq) \
+	((wq)->qpages.num_pages == 1)
+
 /* Get number of elements in work queue that are in-use. */
 static inline u16 hinic3_wq_get_used(const struct hinic3_wq *wq)
 {
@@ -66,6 +69,15 @@ static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqebbs)
 	wq->cons_idx += num_wqebbs;
 }
 
+static inline u64 hinic3_wq_get_first_wqe_page_addr(const struct hinic3_wq *wq)
+{
+	return wq->qpages.pages[0].align_paddr;
+}
+
+int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq, u32 q_depth,
+		     u16 wqebb_size);
+void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq);
+void hinic3_wq_reset(struct hinic3_wq *wq);
 void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
 				u16 num_wqebbs, u16 *prod_idx,
 				struct hinic3_sq_bufdesc **first_wqebb,
-- 
2.45.2


