Return-Path: <netdev+bounces-260525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIDAD/KlnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:21:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883351878EA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1930E31F7D7D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8F39E162;
	Tue, 24 Feb 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sZRhqD8a"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5B39C630;
	Tue, 24 Feb 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938973; cv=none; b=VnmH9+mquh6C54tg9BVo7wrNAFldVl3dEhD2f7gNHM+AwZl1BATZWmO4yquc9LqW3fi9CD4KPJwq5HcBaSIz4DkbKN1GUvQT60gLghaXLa72Z4LdHXZOejX1fyymM7bdWseOgi+VVZx/MvP51WV8ToOJJB19ghvGziw3TVhncpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938973; c=relaxed/simple;
	bh=JWi7xOGUAAklJ2iK/Yh5d39MPzBDhncc72z1PddnmnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzCuGpPQk29Z4xHOrzwvPghXvCc/Ch3oBcXlwKjnJofc+CD9MlkHAIcnJCDqPr5ONuCfzrVVJGCB6dGs7WmL+XEbz92TF14rFzr7vVQ4PpaX2Fw5RDHF0Rc4BA7IbWtQbG2ACYLa0HP2G1J6m9eWMAuULO1wxAc8T+O/CFTxNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sZRhqD8a; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OO7ZywSotYxKYTcrQfTyH3yxYXm3Kp6nWpw60m8kjWI=;
	b=sZRhqD8aFLfZWhRXP8x5IdZFSGBlOzBEF2N1Bdgy5SQ14tkXRtw5WCjazY1EFIYKGkG0OIouu
	3dKrjlf0vMF/SN2La4AV78pwGYVop0JvPaLiU1fUhGXjoDy9IXXZnjcMnUoovLEBfnDMnOZ4Il3
	wmFdqBAKBsGQpw9TRSxZFg8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fKylp4nxYz1prKq;
	Tue, 24 Feb 2026 21:11:18 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B8544056B;
	Tue, 24 Feb 2026 21:16:07 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:16:06 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>
Subject: [PATCH net-next v01 02/15] hinic3: Add Command Queue/Async Event Queue/Mailbox dump interfaces
Date: Tue, 24 Feb 2026 21:15:39 +0800
Message-ID: <16ace51aa4ff2cdcfb3e3f41799d06f574b0dc7d.1771916043.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260525-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:mid,h-partners.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim]
X-Rspamd-Queue-Id: 883351878EA
X-Rspamd-Action: no action

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  | 19 ++++++
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  2 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 67 +++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  6 ++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 15 +++++
 5 files changed, 109 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index 15c9aa247bae..928bcd857751 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -6,12 +6,14 @@
 #include <linux/dma-mapping.h>
 
 #include "hinic3_cmdq.h"
+#include "hinic3_eqs.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
 #define CMDQ_BUF_SIZE             2048
 #define CMDQ_WQEBB_SIZE           64
+#define CMDQ_WQE_HEAD_LEN         32
 
 #define CMDQ_CMD_TIMEOUT          5000
 #define CMDQ_ENABLE_WAIT_TIMEOUT  300
@@ -114,6 +116,20 @@ enum cmdq_cmd_type {
 
 #define CMDQ_WQE_NUM_WQEBBS  1
 
+static void hinic3_dump_cmdq_wqe_head(struct hinic3_hwdev *hwdev,
+				      struct cmdq_wqe *wqe)
+{
+	u32 *data = (u32 *)wqe;
+	u32 i;
+
+	for (i = 0; i < (CMDQ_WQE_HEAD_LEN / sizeof(u32)); i += 0x4) {
+		dev_dbg(hwdev->dev,
+			"wqe data: 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
+			*(data + i), *(data + i + 0x1), *(data + i + 0x2),
+			*(data + i + 0x3));
+	}
+}
+
 static struct cmdq_wqe *cmdq_read_wqe(struct hinic3_wq *wq, u16 *ci)
 {
 	if (hinic3_wq_get_used(wq) == 0)
@@ -279,6 +295,7 @@ void hinic3_cmdq_ceq_handler(struct hinic3_hwdev *hwdev, __le32 ceqe_data)
 		case HINIC3_CMD_TYPE_TIMEOUT:
 			dev_warn(hwdev->dev, "Cmdq timeout, q_id: %u, ci: %u\n",
 				 cmdq_type, ci);
+			hinic3_dump_cmdq_wqe_head(hwdev, wqe);
 			fallthrough;
 		case HINIC3_CMD_TYPE_FAKE_TIMEOUT:
 			cmdq_clear_cmd_buf(cmd_info, hwdev);
@@ -535,6 +552,8 @@ static int wait_cmdq_sync_cmd_completion(struct hinic3_cmdq *cmdq,
 	clear_cmd_info(cmd_info, saved_cmd_info);
 	spin_unlock_bh(&cmdq->cmdq_lock);
 
+	hinic3_dump_ceq_info(cmdq->hwdev);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
index f7083a6e7df9..0e32ff34919e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -76,9 +76,11 @@
 
 #define HINIC3_CSR_AEQ_CTRL_0_ADDR           (HINIC3_CFG_REGS_FLAG + 0x200)
 #define HINIC3_CSR_AEQ_CTRL_1_ADDR           (HINIC3_CFG_REGS_FLAG + 0x204)
+#define HINIC3_CSR_AEQ_CONS_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x208)
 #define HINIC3_CSR_AEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x20C)
 #define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x50)
 
+#define HINIC3_CSR_CEQ_CONS_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x288)
 #define HINIC3_CSR_CEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x28c)
 #define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x54)
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index a2c3962116d5..1bdc6a82ca4d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -56,6 +56,10 @@
 #define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
 	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
 
+#define EQ_CONS_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CONS_IDX_ADDR : HINIC3_CSR_CEQ_CONS_IDX_ADDR)
+
 #define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
 	(((eq)->type == HINIC3_AEQ) ?  \
 	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
@@ -353,6 +357,7 @@ static irqreturn_t ceq_interrupt(int irq, void *data)
 	struct hinic3_eq *ceq = data;
 	int err;
 
+	ceq->hard_intr_jif = jiffies;
 	/* clear resend timer counters */
 	hinic3_msix_intr_clear_resend_bit(ceq->hwdev, ceq->msix_entry_idx,
 					  EQ_MSIX_RESEND_TIMER_CLEAR);
@@ -713,6 +718,39 @@ void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
 	kfree(aeqs);
 }
 
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)
+{
+	const struct hinic3_aeq_elem *aeqe_pos;
+	u32 addr, ci, pi, ctrl0, idx;
+	struct hinic3_eq *eq;
+	int q_id;
+
+	for (q_id = 0; q_id < hwdev->aeqs->num_aeqs; q_id++) {
+		eq = &hwdev->aeqs->aeq[q_id];
+		/* Indirect access should set q_id first */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+				      eq->q_id);
+
+		addr = HINIC3_CSR_AEQ_CTRL_0_ADDR;
+
+		ctrl0 = hinic3_hwif_read_reg(hwdev->hwif, addr);
+
+		idx = hinic3_hwif_read_reg(hwdev->hwif,
+					   HINIC3_EQ_INDIR_IDX_ADDR(eq->type));
+
+		addr = EQ_CONS_IDX_REG_ADDR(eq);
+		ci = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		addr = EQ_PROD_IDX_REG_ADDR(eq);
+		pi = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		aeqe_pos = get_curr_aeq_elem(eq);
+		dev_err(hwdev->dev,
+			"Aeq id: %d, idx: %u, ctrl0: 0x%08x, ci: 0x%08x, pi: 0x%x, work_state: 0x%x, wrap: %u, desc: 0x%x swci:0x%x\n",
+			q_id, idx, ctrl0, ci, pi, work_busy(&eq->aeq_work),
+			eq->wrapped, be32_to_cpu(aeqe_pos->desc), eq->cons_idx);
+	}
+}
+
 int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
 		     struct msix_entry *msix_entries)
 {
@@ -773,3 +811,32 @@ void hinic3_ceqs_free(struct hinic3_hwdev *hwdev)
 
 	kfree(ceqs);
 }
+
+void hinic3_dump_ceq_info(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_eq *eq;
+	u32 addr, ci, pi;
+	int q_id;
+
+	for (q_id = 0; q_id < hwdev->ceqs->num_ceqs; q_id++) {
+		eq = &hwdev->ceqs->ceq[q_id];
+		/* Indirect access should set q_id first */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
+				      eq->q_id);
+
+		addr = EQ_CONS_IDX_REG_ADDR(eq);
+		ci = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		addr = EQ_PROD_IDX_REG_ADDR(eq);
+		pi = hinic3_hwif_read_reg(hwdev->hwif, addr);
+		dev_err(hwdev->dev,
+			"Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, wrap: %u, ceqe: 0x%x\n",
+			q_id, ci, eq->cons_idx, pi,
+			eq->wrapped, be32_to_cpu(*get_curr_ceq_elem(eq)));
+
+		dev_err(hwdev->dev, "Ceq last response hard interrupt time: %u\n",
+			jiffies_to_msecs(jiffies - eq->hard_intr_jif));
+		dev_err(hwdev->dev, "Ceq last response soft interrupt time: %u\n",
+			jiffies_to_msecs(jiffies - eq->soft_intr_jif));
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
index 005a6e0745b3..dfcd1a00855a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -56,6 +56,9 @@ struct hinic3_eq {
 	u16                       msix_entry_idx;
 	char                      irq_name[HINIC3_EQ_IRQ_NAME_LEN];
 	struct work_struct        aeq_work;
+
+	u64                       hard_intr_jif;
+	u64                       soft_intr_jif;
 };
 
 struct hinic3_aeq_elem {
@@ -110,6 +113,8 @@ int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
 			   hinic3_aeq_event_cb hwe_cb);
 void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
 			      enum hinic3_aeq_type event);
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);
+
 int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
 		     struct msix_entry *msix_entries);
 void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
@@ -118,5 +123,6 @@ int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
 			   hinic3_ceq_event_cb callback);
 void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
 			      enum hinic3_ceq_event event);
+void hinic3_dump_ceq_info(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index c871fd0fb109..1bfaff9ba253 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -5,6 +5,7 @@
 
 #include "hinic3_common.h"
 #include "hinic3_csr.h"
+#include "hinic3_eqs.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
@@ -616,6 +617,18 @@ static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
 			      mbox_ctrl);
 }
 
+static void hinic3_dump_mbox_reg(struct hinic3_hwdev *hwdev)
+{
+	u32 val;
+
+	val = hinic3_hwif_read_reg(hwdev->hwif,
+				   HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF);
+	dev_err(hwdev->dev, "Mailbox control reg: 0x%x\n", val);
+	val = hinic3_hwif_read_reg(hwdev->hwif,
+				   HINIC3_FUNC_CSR_MAILBOX_INT_OFF);
+	dev_err(hwdev->dev, "Mailbox interrupt offset: 0x%x\n", val);
+}
+
 static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
 {
 	__be64 *wb_status = mbox->wb_vaddr;
@@ -670,6 +683,7 @@ static int send_mbox_seg(struct hinic3_mbox *mbox, __le64 header,
 	if (err) {
 		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
 			wb_status);
+		hinic3_dump_mbox_reg(hwdev);
 		return err;
 	}
 
@@ -825,6 +839,7 @@ int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
 	if (wait_mbox_msg_completion(mbox, msg_params->timeout_ms)) {
 		dev_err(hwdev->dev,
 			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
+		hinic3_dump_aeq_info(mbox->hwdev);
 		err = -ETIMEDOUT;
 		goto err_send;
 	}
-- 
2.43.0


