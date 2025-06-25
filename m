Return-Path: <netdev+bounces-200926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A3AE756D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348A25A4B7E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC81F03D5;
	Wed, 25 Jun 2025 03:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EE1DE889;
	Wed, 25 Jun 2025 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822904; cv=none; b=WojeTZJQVLw1dyrMaMp33212K08mI9S7Id5Or5FXTqA9WmDpjIxjR8hVlR0lsjIqD8L2pIhmBU1gl8vbXLqXapk5tmMA49lG7xLGVriDpCtZixSD5NvYLhxujOXc0FzXHTFwuOIo5069ttPRkmOmB697jxLB2igb4NkYJgNAZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822904; c=relaxed/simple;
	bh=fkpkxGBPRYd1UY7DCJ0ibJMQkAOB7BPvzkG8pOYhD4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rd8E9kka4/dToBk73er6vO5UsziozODzzpqLhNiP2pFTxyWN/o7fvcUXABXcwoyt1rtrrNuKj9l0KLXKdmMzG2z3A/wkzQ2hfTJRdg7NoFEhF0sdeH7I0BjurM4IXZt+4LHKF1pNJdqR4Y+eOwNhOczeXoOojlrAfHym5ng/r8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bRndC4mP3z2BdX8;
	Wed, 25 Jun 2025 11:39:59 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F30B140142;
	Wed, 25 Jun 2025 11:41:36 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Jun 2025 11:41:34 +0800
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
Subject: [PATCH net-next v05 4/8] hinic3: Command Queue interfaces
Date: Wed, 25 Jun 2025 11:41:15 +0800
Message-ID: <08a3ea4a38b3cf97b47b3606554627a0bf012e8f.1750821322.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1750821322.git.zhuyikai1@h-partners.com>
References: <cover.1750821322.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add Command Queue interfaces initialization.
It enables communictaion and operation with HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 504 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.h  |   5 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |   9 +
 3 files changed, 518 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index 67bfd73aebb8..f2af187281e0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -12,6 +12,9 @@
 #define CMDQ_BUF_SIZE             2048
 #define CMDQ_WQEBB_SIZE           64
 
+#define CMDQ_CMD_TIMEOUT          5000
+#define CMDQ_ENABLE_WAIT_TIMEOUT  300
+
 #define CMDQ_CTXT_CURR_WQE_PAGE_PFN_MASK  GENMASK_ULL(51, 0)
 #define CMDQ_CTXT_EQ_ID_MASK              GENMASK_ULL(60, 53)
 #define CMDQ_CTXT_CEQ_ARM_MASK            BIT_ULL(61)
@@ -23,6 +26,47 @@
 #define CMDQ_CTXT_SET(val, member)  \
 	FIELD_PREP(CMDQ_CTXT_##member##_MASK, val)
 
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
+#define CMDQ_WQE_ERRCODE_VAL_MASK      GENMASK(30, 0)
+#define CMDQ_WQE_ERRCODE_GET(val, member)  \
+	FIELD_GET(CMDQ_WQE_ERRCODE_##member##_MASK, val)
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
+#define CMDQ_CEQE_TYPE_MASK            GENMASK(2, 0)
+#define CMDQ_CEQE_GET(val, member)  \
+	FIELD_GET(CMDQ_CEQE_##member##_MASK, val)
+
+#define CMDQ_WQE_HEADER(wqe)           ((struct cmdq_header *)(wqe))
+#define CMDQ_WQE_COMPLETED(ctrl_info)  CMDQ_CTRL_GET(ctrl_info, HW_BUSY_BIT)
+
 #define CMDQ_PFN(addr)  ((addr) >> 12)
 
 /* cmdq work queue's chip logical address table is up to 512B */
@@ -33,6 +77,31 @@
 #define CMDQ_DIRECT_SYNC_CMPT_CODE  11
 #define CMDQ_FORCE_STOP_CMPT_CODE   12
 
+enum cmdq_data_format {
+	CMDQ_DATA_SGE    = 0,
+	CMDQ_DATA_DIRECT = 1,
+};
+
+enum cmdq_ctrl_sect_len {
+	CMDQ_CTRL_SECT_LEN        = 1,
+	CMDQ_CTRL_DIRECT_SECT_LEN = 2,
+};
+
+enum cmdq_bufdesc_len {
+	CMDQ_BUFDESC_LCMD_LEN = 2,
+	CMDQ_BUFDESC_SCMD_LEN = 3,
+};
+
+enum cmdq_completion_format {
+	CMDQ_COMPLETE_DIRECT = 0,
+	CMDQ_COMPLETE_SGE    = 1,
+};
+
+enum cmdq_cmd_type {
+	CMDQ_CMD_DIRECT_RESP,
+	CMDQ_CMD_SGE_RESP,
+};
+
 #define CMDQ_WQE_NUM_WQEBBS  1
 
 static struct cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
@@ -45,6 +114,35 @@ static struct cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
 	return get_q_element(&wq->qpages, wq->cons_idx, NULL);
 }
 
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
+		goto err_free_cmd_buf;
+	}
+
+	cmd_buf->size = CMDQ_BUF_SIZE;
+	refcount_set(&cmd_buf->ref_cnt, 1);
+
+	return cmd_buf;
+
+err_free_cmd_buf:
+	kfree(cmd_buf);
+
+	return NULL;
+}
+
 void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
 			 struct hinic3_cmd_buf *cmd_buf)
 {
@@ -68,6 +166,412 @@ static void cmdq_clear_cmd_buf(struct hinic3_cmdq_cmd_info *cmd_info,
 	}
 }
 
+static void clear_wqe_complete_bit(struct hinic3_cmdq *cmdq,
+				   struct cmdq_wqe *wqe, u16 ci)
+{
+	struct cmdq_header *hdr = CMDQ_WQE_HEADER(wqe);
+	u32 header_info = hdr->header_info;
+	enum cmdq_data_format df;
+	struct cmdq_ctrl *ctrl;
+
+	df = CMDQ_WQE_HDR_GET(header_info, DATA_FMT);
+	if (df == CMDQ_DATA_SGE)
+		ctrl = &wqe->wqe_lcmd.ctrl;
+	else
+		ctrl = &wqe->wqe_scmd.ctrl;
+
+	/* clear HW busy bit */
+	ctrl->ctrl_info = 0;
+	cmdq->cmd_infos[ci].cmd_type = HINIC3_CMD_TYPE_NONE;
+	wmb(); /* verify wqe is clear */
+	hinic3_wq_put_wqebbs(&cmdq->wq, CMDQ_WQE_NUM_WQEBBS);
+}
+
+static void cmdq_update_cmd_status(struct hinic3_cmdq *cmdq, u16 prod_idx,
+				   struct cmdq_wqe *wqe)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	u32 status_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	cmd_info = &cmdq->cmd_infos[prod_idx];
+	if (cmd_info->errcode) {
+		status_info = wqe_lcmd->status.status_info;
+		*cmd_info->errcode = CMDQ_WQE_ERRCODE_GET(status_info, VAL);
+	}
+
+	if (cmd_info->direct_resp)
+		*cmd_info->direct_resp = wqe_lcmd->completion.resp.direct.val;
+}
+
+static void cmdq_sync_cmd_handler(struct hinic3_cmdq *cmdq,
+				  struct cmdq_wqe *wqe, u16 ci)
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
+	enum hinic3_cmdq_type cmdq_type = CMDQ_CEQE_GET(ceqe_data, TYPE);
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	struct hinic3_cmdq_cmd_info *cmd_info;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct hinic3_cmdq *cmdq;
+	struct cmdq_wqe *wqe;
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
+			dev_warn(hwdev->dev, "Cmdq timeout, q_id: %u, ci: %u\n",
+				 cmdq_type, ci);
+			fallthrough;
+		case HINIC3_CMD_TYPE_FAKE_TIMEOUT:
+			cmdq_clear_cmd_buf(cmd_info, hwdev);
+			clear_wqe_complete_bit(cmdq, wqe, ci);
+			break;
+		default:
+			/* only arm bit is using scmd wqe,
+			 * the other wqe is lcmd
+			 */
+			wqe_lcmd = &wqe->wqe_lcmd;
+			ctrl_info = wqe_lcmd->ctrl.ctrl_info;
+			if (!CMDQ_WQE_COMPLETED(ctrl_info))
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
+	end = jiffies + msecs_to_jiffies(CMDQ_ENABLE_WAIT_TIMEOUT);
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
+static void cmdq_set_completion(struct cmdq_completion *complete,
+				struct hinic3_cmd_buf *buf_out)
+{
+	struct hinic3_sge *sge = &complete->resp.sge;
+
+	hinic3_set_sge(sge, buf_out->dma_addr, CMDQ_BUF_SIZE);
+}
+
+static struct cmdq_wqe *cmdq_get_wqe(struct hinic3_wq *wq, u16 *pi)
+{
+	if (!hinic3_wq_free_wqebbs(wq))
+		return NULL;
+
+	return hinic3_wq_get_one_wqebb(wq, pi);
+}
+
+static void cmdq_set_lcmd_bufdesc(struct cmdq_wqe_lcmd *wqe,
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
+	struct cmdq_db db;
+
+	db.db_info = CMDQ_DB_INFO_SET(prod_idx >> 8, HI_PROD_IDX);
+	db.db_head = CMDQ_DB_HEAD_SET(1, QUEUE_TYPE) |
+		     CMDQ_DB_HEAD_SET(cmdq_type, CMDQ_TYPE);
+	writeq(*(u64 *)&db, db_base + db_ofs);
+}
+
+static void cmdq_wqe_fill(struct cmdq_wqe *hw_wqe,
+			  const struct cmdq_wqe *shadow_wqe)
+{
+	const struct cmdq_header *src = (struct cmdq_header *)shadow_wqe;
+	struct cmdq_header *dst = (struct cmdq_header *)hw_wqe;
+	size_t len;
+
+	len = sizeof(struct cmdq_wqe) - sizeof(struct cmdq_header);
+	memcpy(dst + 1, src + 1, len);
+	/* Header should be written last */
+	wmb();
+	WRITE_ONCE(*dst, *src);
+}
+
+static void cmdq_prepare_wqe_ctrl(struct cmdq_wqe *wqe, u8 wrapped,
+				  u8 mod, u8 cmd, u16 prod_idx,
+				  enum cmdq_completion_format complete_format,
+				  enum cmdq_data_format data_format,
+				  enum cmdq_bufdesc_len buf_len)
+{
+	struct cmdq_header *hdr = CMDQ_WQE_HEADER(wqe);
+	enum cmdq_ctrl_sect_len ctrl_len;
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct cmdq_wqe_scmd *wqe_scmd;
+	struct cmdq_ctrl *ctrl;
+
+	if (data_format == CMDQ_DATA_SGE) {
+		wqe_lcmd = &wqe->wqe_lcmd;
+		wqe_lcmd->status.status_info = 0;
+		ctrl = &wqe_lcmd->ctrl;
+		ctrl_len = CMDQ_CTRL_SECT_LEN;
+	} else {
+		wqe_scmd = &wqe->wqe_scmd;
+		wqe_scmd->status.status_info = 0;
+		ctrl = &wqe_scmd->ctrl;
+		ctrl_len = CMDQ_CTRL_DIRECT_SECT_LEN;
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
+static void cmdq_set_lcmd_wqe(struct cmdq_wqe *wqe,
+			      enum cmdq_cmd_type cmd_type,
+			      struct hinic3_cmd_buf *buf_in,
+			      struct hinic3_cmd_buf *buf_out,
+			      u8 wrapped, u8 mod, u8 cmd, u16 prod_idx)
+{
+	enum cmdq_completion_format complete_format = CMDQ_COMPLETE_DIRECT;
+	struct cmdq_wqe_lcmd *wqe_lcmd = &wqe->wqe_lcmd;
+
+	switch (cmd_type) {
+	case CMDQ_CMD_DIRECT_RESP:
+		wqe_lcmd->completion.resp.direct.val = 0;
+		break;
+	case CMDQ_CMD_SGE_RESP:
+		if (buf_out) {
+			complete_format = CMDQ_COMPLETE_SGE;
+			cmdq_set_completion(&wqe_lcmd->completion, buf_out);
+		}
+		break;
+	}
+
+	cmdq_prepare_wqe_ctrl(wqe, wrapped, mod, cmd, prod_idx, complete_format,
+			      CMDQ_DATA_SGE, CMDQ_BUFDESC_LCMD_LEN);
+	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);
+}
+
+static int hinic3_cmdq_sync_timeout_check(struct hinic3_cmdq *cmdq,
+					  struct cmdq_wqe *wqe, u16 pi)
+{
+	struct cmdq_wqe_lcmd *wqe_lcmd;
+	struct cmdq_ctrl *ctrl;
+	u32 ctrl_info;
+
+	wqe_lcmd = &wqe->wqe_lcmd;
+	ctrl = &wqe_lcmd->ctrl;
+	ctrl_info = ctrl->ctrl_info;
+	if (!CMDQ_WQE_COMPLETED(ctrl_info)) {
+		dev_dbg(cmdq->hwdev->dev, "Cmdq sync command check busy bit not set\n");
+		return -EFAULT;
+	}
+	cmdq_update_cmd_status(cmdq, pi, wqe);
+
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
+					 struct cmdq_wqe *curr_wqe,
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
+		dev_err(cmdq->hwdev->dev,
+			"Cmdq sync command current msg id mismatch cmd_info msg id\n");
+	}
+
+	clear_cmd_info(cmd_info, saved_cmd_info);
+	spin_unlock_bh(&cmdq->cmdq_lock);
+
+	return err;
+}
+
+static int cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+				     struct hinic3_cmd_buf *buf_in,
+				     u64 *out_param)
+{
+	struct hinic3_cmdq_cmd_info *cmd_info, saved_cmd_info;
+	int cmpt_code = CMDQ_SEND_CMPT_CODE;
+	struct cmdq_wqe *curr_wqe, wqe = {};
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
+	wrapped = cmdq->wrapped;
+	next_prod_idx = curr_prod_idx + CMDQ_WQE_NUM_WQEBBS;
+	if (next_prod_idx >= wq->q_depth) {
+		cmdq->wrapped ^= 1;
+		next_prod_idx -= wq->q_depth;
+	}
+
+	cmd_info = &cmdq->cmd_infos[curr_prod_idx];
+	init_completion(&done);
+	refcount_inc(&buf_in->ref_cnt);
+	cmd_info->cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
+	cmd_info->done = &done;
+	cmd_info->errcode = &errcode;
+	cmd_info->direct_resp = out_param;
+	cmd_info->cmpt_code = &cmpt_code;
+	cmd_info->buf_in = buf_in;
+	saved_cmd_info = *cmd_info;
+	cmdq_set_lcmd_wqe(&wqe, CMDQ_CMD_DIRECT_RESP, buf_in, NULL,
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
+		dev_err(cmdq->hwdev->dev,
+			"Cmdq sync command timeout, mod: %u, cmd: %u, prod idx: 0x%x\n",
+			mod, cmd, curr_prod_idx);
+		err = -ETIMEDOUT;
+	}
+
+	if (cmpt_code == CMDQ_FORCE_STOP_CMPT_CODE) {
+		dev_dbg(cmdq->hwdev->dev,
+			"Force stop cmdq cmd, mod: %u, cmd: %u\n", mod, cmd);
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
+
+	return err;
+}
+
 static void cmdq_init_queue_ctxt(struct hinic3_hwdev *hwdev, u8 cmdq_id,
 				 struct comm_cmdq_ctxt_info *ctxt_info)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
index 80c9a108b5f5..c1d1c4e20ffe 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.h
@@ -141,8 +141,13 @@ struct hinic3_cmdqs {
 int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev);
 void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);
 
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(struct hinic3_hwdev *hwdev);
 void hinic3_free_cmd_buf(struct hinic3_hwdev *hwdev,
 			 struct hinic3_cmd_buf *cmd_buf);
+void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, u32 ceqe_data);
+
+int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, u8 mod, u8 cmd,
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param);
 
 void hinic3_cmdq_flush_sync_cmd(struct hinic3_hwdev *hwdev);
 int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index 3e8875abb4e1..52d6cb2515c8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -25,6 +25,15 @@ struct hinic3_sge {
 	u32 rsvd;
 };
 
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
-- 
2.43.0


