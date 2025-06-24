Return-Path: <netdev+bounces-200452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C77AE586E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5853AE9BC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59002063F0;
	Tue, 24 Jun 2025 00:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2941D63E6;
	Tue, 24 Jun 2025 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750724125; cv=none; b=QTJMC7eMpDbpnHUWp547kt3qjxqZy8Fcx2KWrj3p9nKQi3lxxvPZgs/a+bC9R69r8iApHeMNgMrTOQzC/gvdQW9PoXPkBGe0UbGGILZyTYeihvAZpUU7q7fAhZpcCYT9YVwboC7Ccqfkc6XelVIq+fMJSrcK9EDn63SOT1Z3YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750724125; c=relaxed/simple;
	bh=q4ZSlxKWE885ny78Ph+FV55g1/yzZAph6yKVJWbsmcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4S0IzA5H+ASz6rBoYSEqDripDhhn8kLwvsmdVzHhu9N+E6Qki+0kjWOcbiYLgIZFiKu4IvWsgv9Zt1ALKApdCAbHLyKamUBiuLTpjYVv1doMN/zkhGQXTzgd/u3q7h6jL2cYDJAzH/6exYh/fnzvnYGvjLxKzu0sAZhV4uKNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bR56C3fcGztS0Y;
	Tue, 24 Jun 2025 08:14:11 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CFCD1180087;
	Tue, 24 Jun 2025 08:15:20 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 08:15:19 +0800
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
Subject: [PATCH net-next v04 6/8] hinic3: Mailbox framework
Date: Tue, 24 Jun 2025 08:14:27 +0800
Message-ID: <8721abac9f08c55d95b98aa7fcab73a41984a084.1750665915.git.zhuyikai1@h-partners.com>
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

Add mailbox framework initialization.
It allows driver to send commands to HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_common.c    |  14 +
 .../ethernet/huawei/hinic3/hinic3_common.h    |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 403 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  | 105 +++++
 4 files changed, 531 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
index d3a69d67b4c1..016da1911072 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 
 #include "hinic3_common.h"
 
@@ -52,6 +53,19 @@ void hinic3_dma_free_coherent_align(struct device *dev,
 			  mem_align->ori_vaddr, mem_align->ori_paddr);
 }
 
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us)
+{
+	enum hinic3_wait_return ret;
+	int err;
+
+	err = read_poll_timeout(handler, ret, ret == HINIC3_WAIT_PROCESS_CPL,
+				wait_once_us, wait_total_ms * USEC_PER_MSEC,
+				false, priv_data);
+
+	return err;
+}
+
 /* Data provided to/by cmdq is arranged in structs with little endian fields but
  * every dword (32bits) should be swapped since HW swaps it again when it
  * copies it from/to host memory. This is a mandatory swap regardless of the
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
index 52d6cb2515c8..50d1fd038b48 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -18,6 +18,11 @@ struct hinic3_dma_addr_align {
 	dma_addr_t align_paddr;
 };
 
+enum hinic3_wait_return {
+	HINIC3_WAIT_PROCESS_CPL     = 0,
+	HINIC3_WAIT_PROCESS_WAITING = 1,
+};
+
 struct hinic3_sge {
 	u32 hi_addr;
 	u32 lo_addr;
@@ -40,6 +45,10 @@ int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
 void hinic3_dma_free_coherent_align(struct device *dev,
 				    struct hinic3_dma_addr_align *mem_align);
 
+typedef enum hinic3_wait_return (*wait_cpl_handler)(void *priv_data);
+int hinic3_wait_for_timeout(void *priv_data, wait_cpl_handler handler,
+			    u32 wait_total_ms, u32 wait_once_us);
+
 void hinic3_cmdq_buf_swab32(void *data, int len);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index e74d1eb09730..df908bfabdbd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -4,10 +4,413 @@
 #include <linux/dma-mapping.h>
 
 #include "hinic3_common.h"
+#include "hinic3_csr.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+#define MBOX_MSG_POLLING_TIMEOUT_MS  8000 // send msg seg timeout
+#define MBOX_COMP_POLLING_TIMEOUT_MS 40000 // response
+
+#define MBOX_MAX_BUF_SZ           2048
+#define MBOX_HEADER_SZ            8
+
+/* MBOX size is 64B, 8B for mbox_header, 8B reserved */
+#define MBOX_SEG_LEN              48
+#define MBOX_SEG_LEN_ALIGN        4
+#define MBOX_WB_STATUS_LEN        16
+
+#define MBOX_SEQ_ID_START_VAL     0
+#define MBOX_SEQ_ID_MAX_VAL       42
+#define MBOX_LAST_SEG_MAX_LEN  \
+	(MBOX_MAX_BUF_SZ - MBOX_SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
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
+#define MBOX_MGMT_FUNC_ID         0x1FFF
+#define MBOX_COMM_F_MBOX_SEGMENT  BIT(3)
+
+static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
+						 enum mbox_msg_direction_type dir,
+						 u16 src_func_id)
+{
+	struct hinic3_msg_channel *msg_ch;
+
+	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
+		&mbox->mgmt_msg : mbox->func_msg;
+
+	return (dir == MBOX_MSG_SEND) ?
+		&msg_ch->recv_msg : &msg_ch->resp_msg;
+}
+
+static void resp_mbox_handler(struct hinic3_mbox *mbox,
+			      const struct hinic3_msg_desc *msg_desc)
+{
+	spin_lock(&mbox->mbox_lock);
+	if (msg_desc->msg_info.msg_id == mbox->send_msg_id &&
+	    mbox->event_flag == MBOX_EVENT_START)
+		mbox->event_flag = MBOX_EVENT_SUCCESS;
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
+	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
+	msg_id = MBOX_MSG_HEADER_GET(mbox_header, MSG_ID);
+	mod = MBOX_MSG_HEADER_GET(mbox_header, MODULE);
+	cmd = MBOX_MSG_HEADER_GET(mbox_header, CMD);
+	src_func_idx = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+
+	if (seq_id > MBOX_SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == MBOX_SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
+		goto err_seg;
+
+	if (seq_id == 0) {
+		msg_desc->seq_id = seq_id;
+		msg_desc->msg_info.msg_id = msg_id;
+		msg_desc->mod = mod;
+		msg_desc->cmd = cmd;
+	} else {
+		if (seq_id != msg_desc->seq_id + 1 ||
+		    msg_id != msg_desc->msg_info.msg_id ||
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
+		msg_desc->seq_id = MBOX_SEQ_ID_MAX_VAL;
+		return;
+	}
+
+	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
+	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
+
+	pos = seq_id * MBOX_SEG_LEN;
+	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);
+
+	if (!MBOX_MSG_HEADER_GET(mbox_header, LAST))
+		return;
+
+	msg_desc->msg_len = MBOX_MSG_HEADER_GET(mbox_header, MSG_LEN);
+	msg_desc->msg_info.status = MBOX_MSG_HEADER_GET(mbox_header, STATUS);
+
+	if (MBOX_MSG_HEADER_GET(mbox_header, DIRECTION) == MBOX_MSG_RESP)
+		resp_mbox_handler(mbox, msg_desc);
+}
+
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				   u8 size)
+{
+	u64 mbox_header = *((u64 *)header);
+	enum mbox_msg_direction_type dir;
+	struct hinic3_mbox *mbox;
+	struct hinic3_msg_desc *msg_desc;
+	u16 src_func_id;
+
+	mbox = hwdev->mbox;
+	dir = MBOX_MSG_HEADER_GET(mbox_header, DIRECTION);
+	src_func_id = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
+	recv_mbox_handler(mbox, (u64 *)header, msg_desc);
+}
+
+static int init_mbox_dma_queue(struct hinic3_hwdev *hwdev,
+			       struct mbox_dma_queue *mq)
+{
+	u32 size;
+
+	mq->depth = MBOX_DMA_MSG_QUEUE_DEPTH;
+	mq->prod_idx = 0;
+	mq->cons_idx = 0;
+
+	size = mq->depth * MBOX_MAX_BUF_SZ;
+	mq->dma_buf_vaddr = dma_alloc_coherent(hwdev->dev, size,
+					       &mq->dma_buf_paddr,
+					       GFP_KERNEL);
+	if (!mq->dma_buf_vaddr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void uninit_mbox_dma_queue(struct hinic3_hwdev *hwdev,
+				  struct mbox_dma_queue *mq)
+{
+	dma_free_coherent(hwdev->dev, mq->depth * MBOX_MAX_BUF_SZ,
+			  mq->dma_buf_vaddr, mq->dma_buf_paddr);
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
+		uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
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
+static void hinic3_uninit_mbox_dma_queue(struct hinic3_mbox *mbox)
+{
+	uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
+	uninit_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
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
+	msg_ch->resp_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
+	msg_ch->recv_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
+
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
+		return err;
+	}
+
+	return 0;
+}
+
+static void uninit_mgmt_msg_channel(struct hinic3_mbox *mbox)
+{
+	hinic3_uninit_mbox_dma_queue(mbox);
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
+		goto err_free_func_msg;
+
+	return 0;
+
+err_free_func_msg:
+	kfree(mbox->func_msg);
+	mbox->func_msg = NULL;
+
+	return err;
+}
+
+static void hinic3_uninit_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
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
+		goto err_destroy_workqueue;
+
+	err = hinic3_init_func_mbox_msg_channel(hwdev);
+	if (err)
+		goto err_uninit_mgmt_msg_ch;
+
+	err = alloc_mbox_wb_status(mbox);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
+		goto err_uninit_func_mbox_msg_ch;
+	}
+
+	prepare_send_mbox(mbox);
+
+	return 0;
+
+err_uninit_func_mbox_msg_ch:
+	hinic3_uninit_func_mbox_msg_channel(hwdev);
+
+err_uninit_mgmt_msg_ch:
+	uninit_mgmt_msg_channel(mbox);
+
+err_destroy_workqueue:
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
+	hinic3_uninit_func_mbox_msg_channel(hwdev);
+	uninit_mgmt_msg_channel(mbox);
+	kfree(mbox);
+}
+
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const struct mgmt_msg_params *msg_params)
 {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
index d7a6c37b7eff..730795b66a86 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -9,6 +9,111 @@
 
 struct hinic3_hwdev;
 
+#define MBOX_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK  GENMASK_ULL(12, 0)
+#define MBOX_MSG_HEADER_STATUS_MASK            BIT_ULL(13)
+#define MBOX_MSG_HEADER_SOURCE_MASK            BIT_ULL(15)
+#define MBOX_MSG_HEADER_AEQ_ID_MASK            GENMASK_ULL(17, 16)
+#define MBOX_MSG_HEADER_MSG_ID_MASK            GENMASK_ULL(21, 18)
+#define MBOX_MSG_HEADER_CMD_MASK               GENMASK_ULL(31, 22)
+#define MBOX_MSG_HEADER_MSG_LEN_MASK           GENMASK_ULL(42, 32)
+#define MBOX_MSG_HEADER_MODULE_MASK            GENMASK_ULL(47, 43)
+#define MBOX_MSG_HEADER_SEG_LEN_MASK           GENMASK_ULL(53, 48)
+#define MBOX_MSG_HEADER_NO_ACK_MASK            BIT_ULL(54)
+#define MBOX_MSG_HEADER_DATA_TYPE_MASK         BIT_ULL(55)
+#define MBOX_MSG_HEADER_SEQID_MASK             GENMASK_ULL(61, 56)
+#define MBOX_MSG_HEADER_LAST_MASK              BIT_ULL(62)
+#define MBOX_MSG_HEADER_DIRECTION_MASK         BIT_ULL(63)
+
+#define MBOX_MSG_HEADER_SET(val, member) \
+	FIELD_PREP(MBOX_MSG_HEADER_##member##_MASK, val)
+#define MBOX_MSG_HEADER_GET(val, member) \
+	FIELD_GET(MBOX_MSG_HEADER_##member##_MASK, val)
+
+/* identifies if a segment belongs to a message or to a response. A VF is only
+ * expected to send messages and receive responses. PF driver could receive
+ * messages and send responses.
+ */
+enum mbox_msg_direction_type {
+	MBOX_MSG_SEND = 0,
+	MBOX_MSG_RESP = 1,
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
+	void                 *msg;
+	u16                  msg_len;
+	u8                   seq_id;
+	u8                   mod;
+	u16                  cmd;
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
+	MBOX_EVENT_START   = 0,
+	MBOX_EVENT_FAIL    = 1,
+	MBOX_EVENT_SUCCESS = 2,
+	MBOX_EVENT_TIMEOUT = 3,
+	MBOX_EVENT_END     = 4,
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
+	void       *dma_buf_vaddr;
+	dma_addr_t dma_buf_paddr;
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
+void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
+				   u8 size);
+int hinic3_init_mbox(struct hinic3_hwdev *hwdev);
+void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
+
 int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 			     const struct mgmt_msg_params *msg_params);
 
-- 
2.43.0


