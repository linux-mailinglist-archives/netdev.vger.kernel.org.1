Return-Path: <netdev+bounces-200922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA464AE755E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F21716B6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27E1DE4D2;
	Wed, 25 Jun 2025 03:41:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9721DF247;
	Wed, 25 Jun 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822898; cv=none; b=SQIiN32CW5I4nzJOwGwcs/Wlm7XtokQXsneGyL2QhT8Hjfqlpwk1m2SKAvU4g6ts7NzoLdGEa/rjhyK/j4TbFO1gh7efzgVhcrlVAW3yIbN4tvXoe+89HX4ghNNXEpQ8ieScINu/Na7NHO9UX5rwRpVfQ87w8JTctP78CqBz1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822898; c=relaxed/simple;
	bh=1XfwF7YRm4JcNJXS7czILPsi8NHevuQBkJBW7K9pxcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KepyMOsBv+ciuU3sfjB+HTrchG493djspCPFCD2QHH8CJzSJjrmNv1jkSEaYvGmZznO88KrohOi3ltFIcmXsZPOUDTO8kdOzGD7VAnR3U5TXmre1Get5F9yJDTjy+dPFvUknMl4tBbYT33BYnU82BNyDxUQ6xGbPe7xWk5DXTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bRnh32T51z2QVJ9;
	Wed, 25 Jun 2025 11:42:27 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E353140279;
	Wed, 25 Jun 2025 11:41:32 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Jun 2025 11:41:30 +0800
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
Subject: [PATCH net-next v05 2/8] hinic3: Complete Event Queue interfaces
Date: Wed, 25 Jun 2025 11:41:13 +0800
Message-ID: <6db1bb335c730ea7de00e9bd2969ef8cc681c9ff.1750821322.git.zhuyikai1@h-partners.com>
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

Add complete event queue interfaces initialization.
It informs that driver should handle the messages from HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  16 +-
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   | 395 +++++++++++++++---
 .../net/ethernet/huawei/hinic3/hinic3_eqs.h   |  36 ++
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  36 ++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 123 +++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  11 +
 6 files changed, 563 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
index 39e15fbf0ed7..e7417e8efa99 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -41,11 +41,14 @@
 
 /* EQ registers */
 #define HINIC3_AEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x210)
+#define HINIC3_CEQ_INDIR_IDX_ADDR      (HINIC3_CFG_REGS_FLAG + 0x290)
 
 #define HINIC3_EQ_INDIR_IDX_ADDR(type)  \
-	HINIC3_AEQ_INDIR_IDX_ADDR
+	((type == HINIC3_AEQ) ? HINIC3_AEQ_INDIR_IDX_ADDR :  \
+	 HINIC3_CEQ_INDIR_IDX_ADDR)
 
 #define HINIC3_AEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x240)
+#define HINIC3_CEQ_MTT_OFF_BASE_ADDR   (HINIC3_CFG_REGS_FLAG + 0x2C0)
 
 #define HINIC3_CSR_EQ_PAGE_OFF_STRIDE  8
 
@@ -57,9 +60,20 @@
 	(HINIC3_AEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
 	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
 
+#define HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE)
+
+#define HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num)  \
+	(HINIC3_CEQ_MTT_OFF_BASE_ADDR + (pg_num) *  \
+	 HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)
+
 #define HINIC3_CSR_AEQ_CTRL_0_ADDR           (HINIC3_CFG_REGS_FLAG + 0x200)
 #define HINIC3_CSR_AEQ_CTRL_1_ADDR           (HINIC3_CFG_REGS_FLAG + 0x204)
 #define HINIC3_CSR_AEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x20C)
 #define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x50)
 
+#define HINIC3_CSR_CEQ_PROD_IDX_ADDR         (HINIC3_CFG_REGS_FLAG + 0x28c)
+#define HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR  (HINIC3_CFG_REGS_FLAG + 0x54)
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index f7b5208de9e1..0d1f1b406064 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -22,6 +22,25 @@
 #define AEQ_CTRL_1_SET(val, member)  \
 	FIELD_PREP(AEQ_CTRL_1_##member##_MASK, val)
 
+#define CEQ_CTRL_0_INTR_IDX_MASK      GENMASK(9, 0)
+#define CEQ_CTRL_0_DMA_ATTR_MASK      GENMASK(17, 12)
+#define CEQ_CTRL_0_LIMIT_KICK_MASK    GENMASK(23, 20)
+#define CEQ_CTRL_0_PCI_INTF_IDX_MASK  GENMASK(25, 24)
+#define CEQ_CTRL_0_PAGE_SIZE_MASK     GENMASK(30, 27)
+#define CEQ_CTRL_0_INTR_MODE_MASK     BIT(31)
+#define CEQ_CTRL_0_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_0_##member##_MASK, val)
+
+#define CEQ_CTRL_1_LEN_MASK           GENMASK(19, 0)
+#define CEQ_CTRL_1_SET(val, member)  \
+	FIELD_PREP(CEQ_CTRL_1_##member##_MASK, val)
+
+#define CEQE_TYPE_MASK                GENMASK(25, 23)
+#define CEQE_TYPE(type)               FIELD_GET(CEQE_TYPE_MASK, type)
+
+#define CEQE_DATA_MASK                GENMASK(25, 0)
+#define CEQE_DATA(data)               ((data) & CEQE_DATA_MASK)
+
 #define EQ_ELEM_DESC_TYPE_MASK        GENMASK(6, 0)
 #define EQ_ELEM_DESC_SRC_MASK         BIT(7)
 #define EQ_ELEM_DESC_SIZE_MASK        GENMASK(15, 8)
@@ -32,25 +51,34 @@
 #define EQ_CI_SIMPLE_INDIR_CI_MASK       GENMASK(20, 0)
 #define EQ_CI_SIMPLE_INDIR_ARMED_MASK    BIT(21)
 #define EQ_CI_SIMPLE_INDIR_AEQ_IDX_MASK  GENMASK(31, 30)
+#define EQ_CI_SIMPLE_INDIR_CEQ_IDX_MASK  GENMASK(31, 24)
 #define EQ_CI_SIMPLE_INDIR_SET(val, member)  \
 	FIELD_PREP(EQ_CI_SIMPLE_INDIR_##member##_MASK, val)
 
-#define EQ_CI_SIMPLE_INDIR_REG_ADDR  \
-	HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR
+#define EQ_CI_SIMPLE_INDIR_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR :  \
+	 HINIC3_CSR_CEQ_CI_SIMPLE_INDIR_ADDR)
 
-#define EQ_PROD_IDX_REG_ADDR  \
-	HINIC3_CSR_AEQ_PROD_IDX_ADDR
+#define EQ_PROD_IDX_REG_ADDR(eq)  \
+	(((eq)->type == HINIC3_AEQ) ?  \
+	 HINIC3_CSR_AEQ_PROD_IDX_ADDR : HINIC3_CSR_CEQ_PROD_IDX_ADDR)
 
 #define EQ_HI_PHYS_ADDR_REG(type, pg_num)  \
-	HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num)
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_HI_PHYS_ADDR_REG(pg_num))
 
 #define EQ_LO_PHYS_ADDR_REG(type, pg_num)  \
-	HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num)
+	(((type) == HINIC3_AEQ) ?  \
+	       HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) :  \
+	       HINIC3_CEQ_LO_PHYS_ADDR_REG(pg_num))
 
 #define EQ_MSIX_RESEND_TIMER_CLEAR  1
 
-#define HINIC3_EQ_MAX_PAGES  \
-	HINIC3_AEQ_MAX_PAGES
+#define HINIC3_EQ_MAX_PAGES(eq)  \
+	((eq)->type == HINIC3_AEQ ?  \
+	 HINIC3_AEQ_MAX_PAGES : HINIC3_CEQ_MAX_PAGES)
 
 #define HINIC3_TASK_PROCESS_EQE_LIMIT  1024
 #define HINIC3_EQ_UPDATE_CI_STEP       64
@@ -69,6 +97,11 @@ static const struct hinic3_aeq_elem *get_curr_aeq_elem(const struct hinic3_eq *e
 	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
 }
 
+static const __be32 *get_curr_ceq_elem(const struct hinic3_eq *eq)
+{
+	return get_q_element(&eq->qpages, eq->cons_idx, NULL);
+}
+
 int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
 			   enum hinic3_aeq_type event,
 			   hinic3_aeq_event_cb hwe_cb)
@@ -102,21 +135,83 @@ void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
 	aeqs->aeq_cb[event] = NULL;
 }
 
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	ceqs->ceq_cb[event] = callback;
+	set_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+
+	return 0;
+}
+
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event)
+{
+	struct hinic3_ceqs *ceqs;
+
+	ceqs = hwdev->ceqs;
+	clear_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]);
+	/* Ensure handler can observe our intent to unregister. */
+	mb();
+	while (test_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]))
+		usleep_range(HINIC3_EQ_USLEEP_LOW_BOUND,
+			     HINIC3_EQ_USLEEP_HIGH_BOUND);
+
+	ceqs->ceq_cb[event] = NULL;
+}
+
 /* Set consumer index in the hw. */
 static void set_eq_cons_idx(struct hinic3_eq *eq, u32 arm_state)
 {
-	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR;
+	u32 addr = EQ_CI_SIMPLE_INDIR_REG_ADDR(eq);
 	u32 eq_wrap_ci, val;
 
 	eq_wrap_ci = HINIC3_EQ_CONS_IDX(eq);
 	val = EQ_CI_SIMPLE_INDIR_SET(arm_state, ARMED);
-	val = val |
-		EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
-		EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	if (eq->type == HINIC3_AEQ) {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, AEQ_IDX);
+	} else {
+		val = val |
+			EQ_CI_SIMPLE_INDIR_SET(eq_wrap_ci, CI) |
+			EQ_CI_SIMPLE_INDIR_SET(eq->q_id, CEQ_IDX);
+	}
 
 	hinic3_hwif_write_reg(eq->hwdev->hwif, addr, val);
 }
 
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
+		dev_warn(hwdev->dev, "Ceq unknown event:%d, ceqe data: 0x%x\n",
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
 static struct hinic3_aeqs *aeq_to_aeqs(const struct hinic3_eq *eq)
 {
 	return container_of(eq, struct hinic3_aeqs, aeq[eq->q_id]);
@@ -186,18 +281,57 @@ static int aeq_irq_handler(struct hinic3_eq *eq)
 	return -EAGAIN;
 }
 
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
 static void reschedule_eq_handler(struct hinic3_eq *eq)
 {
-	struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
+	if (eq->type == HINIC3_AEQ) {
+		struct hinic3_aeqs *aeqs = aeq_to_aeqs(eq);
 
-	queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
+		queue_work_on(WORK_CPU_UNBOUND, aeqs->workq, &eq->aeq_work);
+	} else {
+		tasklet_schedule(&eq->ceq_tasklet);
+	}
 }
 
 static int eq_irq_handler(struct hinic3_eq *eq)
 {
 	int err;
 
-	err = aeq_irq_handler(eq);
+	if (eq->type == HINIC3_AEQ)
+		err = aeq_irq_handler(eq);
+	else
+		err = ceq_irq_handler(eq);
 
 	set_eq_cons_idx(eq, err ? HINIC3_EQ_NOT_ARMED :
 			HINIC3_EQ_ARMED);
@@ -215,6 +349,16 @@ static void eq_irq_work(struct work_struct *work)
 		reschedule_eq_handler(eq);
 }
 
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
 static irqreturn_t aeq_interrupt(int irq, void *data)
 {
 	struct hinic3_eq *aeq = data;
@@ -231,6 +375,43 @@ static irqreturn_t aeq_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ceq_interrupt(int irq, void *data)
+{
+	struct hinic3_eq *ceq = data;
+
+	/* clear resend timer counters */
+	hinic3_msix_intr_clear_resend_bit(ceq->hwdev, ceq->msix_entry_idx,
+					  EQ_MSIX_RESEND_TIMER_CLEAR);
+	tasklet_schedule(&ceq->ceq_tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_set_ceq_ctrl_reg(struct hinic3_hwdev *hwdev, u16 q_id,
+				   u32 ctrl0, u32 ctrl1)
+{
+	struct comm_cmd_set_ceq_ctrl_reg ceq_ctrl = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	ceq_ctrl.func_id = hinic3_global_func_id(hwdev);
+	ceq_ctrl.q_id = q_id;
+	ceq_ctrl.ctrl0 = ctrl0;
+	ceq_ctrl.ctrl1 = ctrl1;
+
+	mgmt_msg_params_init_default(&msg_params, &ceq_ctrl, sizeof(ceq_ctrl));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_CEQ_CTRL_REG, &msg_params);
+	if (err || ceq_ctrl.head.status) {
+		dev_err(hwdev->dev, "Failed to set ceq %u ctrl reg, err: %d status: 0x%x\n",
+			q_id, err, ceq_ctrl.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int set_eq_ctrls(struct hinic3_eq *eq)
 {
 	struct hinic3_hwif *hwif = eq->hwdev->hwif;
@@ -238,34 +419,65 @@ static int set_eq_ctrls(struct hinic3_eq *eq)
 	u8 pci_intf_idx, elem_size;
 	u32 mask, ctrl0, ctrl1;
 	u32 page_size_val;
+	int err;
 
 	qpages = &eq->qpages;
 	page_size_val = ilog2(qpages->page_size / HINIC3_MIN_PAGE_SIZE);
 	pci_intf_idx = hwif->attr.pci_intf_idx;
 
-	/* set ctrl0 using read-modify-write */
-	mask = AEQ_CTRL_0_INTR_IDX_MASK |
-	       AEQ_CTRL_0_DMA_ATTR_MASK |
-	       AEQ_CTRL_0_PCI_INTF_IDX_MASK |
-	       AEQ_CTRL_0_INTR_MODE_MASK;
-	ctrl0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR);
-	ctrl0 = (ctrl0 & ~mask) |
-		AEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
-		AEQ_CTRL_0_SET(0, DMA_ATTR) |
-		AEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
-		AEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
-	hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_0_ADDR, ctrl0);
-
-	/* HW expects log2(number of 32 byte units). */
-	elem_size = qpages->elem_size_shift - 5;
-	ctrl1 = AEQ_CTRL_1_SET(eq->eq_len, LEN) |
-		AEQ_CTRL_1_SET(elem_size, ELEM_SIZE) |
-		AEQ_CTRL_1_SET(page_size_val, PAGE_SIZE);
-	hinic3_hwif_write_reg(hwif, HINIC3_CSR_AEQ_CTRL_1_ADDR, ctrl1);
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
+	} else {
+		ctrl0 = CEQ_CTRL_0_SET(eq->msix_entry_idx, INTR_IDX) |
+			CEQ_CTRL_0_SET(0, DMA_ATTR) |
+			CEQ_CTRL_0_SET(0, LIMIT_KICK) |
+			CEQ_CTRL_0_SET(pci_intf_idx, PCI_INTF_IDX) |
+			CEQ_CTRL_0_SET(page_size_val, PAGE_SIZE) |
+			CEQ_CTRL_0_SET(HINIC3_INTR_MODE_ARMED, INTR_MODE);
+
+		ctrl1 = CEQ_CTRL_1_SET(eq->eq_len, LEN);
+
+		/* set ceq ctrl reg through mgmt cpu */
+		err = hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, ctrl0,
+					      ctrl1);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
 
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
 static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
 {
 	struct hinic3_aeq_elem *aeqe;
@@ -281,7 +493,10 @@ static void aeq_elements_init(struct hinic3_eq *eq, u32 init_val)
 
 static void eq_elements_init(struct hinic3_eq *eq, u32 init_val)
 {
-	aeq_elements_init(eq, init_val);
+	if (eq->type == HINIC3_AEQ)
+		aeq_elements_init(eq, init_val);
+	else
+		ceq_elements_init(eq, init_val);
 }
 
 static int alloc_eq_pages(struct hinic3_eq *eq)
@@ -320,7 +535,7 @@ static void eq_calc_page_size_and_num(struct hinic3_eq *eq, u32 elem_size)
 	 * Multiplications give power of 2 and divisions give power of 2 without
 	 * remainder.
 	 */
-	max_pages = HINIC3_EQ_MAX_PAGES;
+	max_pages = HINIC3_EQ_MAX_PAGES(eq);
 	min_page_size = HINIC3_MIN_PAGE_SIZE;
 	total_size = eq->eq_len * elem_size;
 
@@ -336,12 +551,21 @@ static int request_eq_irq(struct hinic3_eq *eq)
 {
 	int err;
 
-	INIT_WORK(&eq->aeq_work, eq_irq_work);
-	snprintf(eq->irq_name, sizeof(eq->irq_name),
-		 "hinic3_aeq%u@pci:%s", eq->q_id,
-		 pci_name(eq->hwdev->pdev));
-	err = request_irq(eq->irq_id, aeq_interrupt, 0,
-			  eq->irq_name, eq);
+	if (eq->type == HINIC3_AEQ) {
+		INIT_WORK(&eq->aeq_work, eq_irq_work);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_aeq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, aeq_interrupt, 0,
+				  eq->irq_name, eq);
+	} else {
+		tasklet_init(&eq->ceq_tasklet, ceq_tasklet, (ulong)eq);
+		snprintf(eq->irq_name, sizeof(eq->irq_name),
+			 "hinic3_ceq%u@pci:%s", eq->q_id,
+			 pci_name(eq->hwdev->pdev));
+		err = request_irq(eq->irq_id, ceq_interrupt, 0,
+				  eq->irq_name, eq);
+	}
 
 	return err;
 }
@@ -349,10 +573,13 @@ static int request_eq_irq(struct hinic3_eq *eq)
 static void reset_eq(struct hinic3_eq *eq)
 {
 	/* clear eq_len to force eqe drop in hardware */
-	hinic3_hwif_write_reg(eq->hwdev->hwif,
-			      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	if (eq->type == HINIC3_AEQ)
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	else
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
 
-	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR, 0);
+	hinic3_hwif_write_reg(eq->hwdev->hwif, EQ_PROD_IDX_REG_ADDR(eq), 0);
 }
 
 static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
@@ -376,7 +603,7 @@ static int init_eq(struct hinic3_eq *eq, struct hinic3_hwdev *hwdev, u16 q_id,
 	eq->cons_idx = 0;
 	eq->wrapped = 0;
 
-	elem_size = HINIC3_AEQE_SIZE;
+	elem_size = (type == HINIC3_AEQ) ? HINIC3_AEQE_SIZE : HINIC3_CEQE_SIZE;
 	eq_calc_page_size_and_num(eq, elem_size);
 
 	err = alloc_eq_pages(eq);
@@ -424,14 +651,19 @@ static void remove_eq(struct hinic3_eq *eq)
 			      HINIC3_EQ_INDIR_IDX_ADDR(eq->type),
 			      eq->q_id);
 
-	cancel_work_sync(&eq->aeq_work);
-	/* clear eq_len to avoid hw access host memory */
-	hinic3_hwif_write_reg(eq->hwdev->hwif,
-			      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	if (eq->type == HINIC3_AEQ) {
+		cancel_work_sync(&eq->aeq_work);
+		/* clear eq_len to avoid hw access host memory */
+		hinic3_hwif_write_reg(eq->hwdev->hwif,
+				      HINIC3_CSR_AEQ_CTRL_1_ADDR, 0);
+	} else {
+		tasklet_kill(&eq->ceq_tasklet);
+		hinic3_set_ceq_ctrl_reg(eq->hwdev, eq->q_id, 0, 0);
+	}
 
 	/* update consumer index to avoid invalid interrupt */
 	eq->cons_idx = hinic3_hwif_read_reg(eq->hwdev->hwif,
-					    EQ_PROD_IDX_REG_ADDR);
+					    EQ_PROD_IDX_REG_ADDR(eq));
 	set_eq_cons_idx(eq, HINIC3_EQ_NOT_ARMED);
 	hinic3_queue_pages_free(eq->hwdev, &eq->qpages);
 }
@@ -508,3 +740,64 @@ void hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
 
 	kfree(aeqs);
 }
+
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries)
+{
+	struct hinic3_ceqs *ceqs;
+	u16 q_id;
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
+		err = init_eq(&ceqs->ceq[q_id], hwdev, q_id,
+			      HINIC3_DEFAULT_CEQ_LEN, HINIC3_CEQ,
+			      &msix_entries[q_id]);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to init ceq %u\n",
+				q_id);
+			goto err_free_ceqs;
+		}
+	}
+	for (q_id = 0; q_id < num_ceqs; q_id++)
+		hinic3_set_msix_state(hwdev, ceqs->ceq[q_id].msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+
+	return 0;
+
+err_free_ceqs:
+	while (q_id > 0) {
+		q_id--;
+		remove_eq(&ceqs->ceq[q_id]);
+	}
+
+	kfree(ceqs);
+
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
+		hinic3_free_irq(hwdev, eq->irq_id);
+	}
+
+	for (ceq_event = 0; ceq_event < HINIC3_MAX_CEQ_EVENTS; ceq_event++)
+		hinic3_ceq_unregister_cb(hwdev, ceq_event);
+
+	kfree(ceqs);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
index 2b4c274e6ba4..c7535910adbd 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
@@ -10,15 +10,19 @@
 #include "hinic3_queue_common.h"
 
 #define HINIC3_MAX_AEQS              4
+#define HINIC3_MAX_CEQS              32
 
 #define HINIC3_AEQ_MAX_PAGES         4
+#define HINIC3_CEQ_MAX_PAGES         8
 
 #define HINIC3_AEQE_SIZE             64
+#define HINIC3_CEQE_SIZE             4
 
 #define HINIC3_AEQE_DESC_SIZE        4
 #define HINIC3_AEQE_DATA_SIZE        (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
 
 #define HINIC3_DEFAULT_AEQ_LEN       0x10000
+#define HINIC3_DEFAULT_CEQ_LEN       0x10000
 
 #define HINIC3_EQ_IRQ_NAME_LEN       64
 
@@ -27,6 +31,7 @@
 
 enum hinic3_eq_type {
 	HINIC3_AEQ = 0,
+	HINIC3_CEQ = 1,
 };
 
 enum hinic3_eq_intr_mode {
@@ -51,6 +56,7 @@ struct hinic3_eq {
 	u16                       msix_entry_idx;
 	char                      irq_name[HINIC3_EQ_IRQ_NAME_LEN];
 	struct work_struct        aeq_work;
+	struct tasklet_struct     ceq_tasklet;
 };
 
 struct hinic3_aeq_elem {
@@ -82,6 +88,28 @@ struct hinic3_aeqs {
 	struct workqueue_struct *workq;
 };
 
+enum hinic3_ceq_cb_state {
+	HINIC3_CEQ_CB_REG     = 0,
+	HINIC3_CEQ_CB_RUNNING = 1,
+};
+
+enum hinic3_ceq_event {
+	HINIC3_CMDQ           = 3,
+	HINIC3_MAX_CEQ_EVENTS = 6,
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
 int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
 		     struct msix_entry *msix_entries);
 void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
@@ -90,5 +118,13 @@ int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
 			   hinic3_aeq_event_cb hwe_cb);
 void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
 			      enum hinic3_aeq_type event);
+int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
+		     struct msix_entry *msix_entries);
+void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
+int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
+			   enum hinic3_ceq_event event,
+			   hinic3_ceq_event_cb callback);
+void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
+			      enum hinic3_ceq_event event);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 22c84093efa2..5f161f1314ac 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -70,6 +70,20 @@ enum comm_cmd {
 	COMM_CMD_SET_DMA_ATTR            = 25,
 };
 
+struct comm_cmd_cfg_msix_ctrl_reg {
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
 enum comm_func_reset_bits {
 	COMM_FUNC_RESET_BIT_FLUSH        = BIT(0),
 	COMM_FUNC_RESET_BIT_MQM          = BIT(1),
@@ -100,6 +114,28 @@ struct comm_cmd_feature_nego {
 	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
 };
 
+struct comm_cmd_set_ceq_ctrl_reg {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  q_id;
+	u32                  ctrl0;
+	u32                  ctrl1;
+	u32                  rsvd1;
+};
+
+struct comm_cmdq_ctxt_info {
+	u64 curr_wqe_page_pfn;
+	u64 wq_block_pfn;
+};
+
+struct comm_cmd_set_cmdq_ctxt {
+	struct mgmt_msg_head       head;
+	u16                        func_id;
+	u8                         cmdq_id;
+	u8                         rsvd1[5];
+	struct comm_cmdq_ctxt_info ctxt;
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 5eafb4b04311..9b1e98e349b1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -10,6 +10,14 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 
+/* config BAR4/5 4MB, DB & DWQE both 2MB */
+#define HINIC3_DB_DWQE_SIZE    0x00400000
+
+/* db/dwqe page size: 4K */
+#define HINIC3_DB_PAGE_SIZE    0x00001000
+#define HINIC3_DWQE_OFFSET     0x00000800
+#define HINIC3_DB_MAX_AREAS    (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
+
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
@@ -35,16 +43,127 @@ void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
 	writel((__force u32)raw_val, addr);
 }
 
+static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 pg_idx;
+
+	spin_lock(&db_area->idx_lock);
+	pg_idx = find_first_zero_bit(db_area->db_bitmap_array,
+				     db_area->db_max_areas);
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
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base)
+{
+	struct hinic3_hwif *hwif;
+	uintptr_t distance;
+	u32 idx;
+
+	hwif = hwdev->hwif;
+	distance = (const char __iomem *)db_base -
+		   (const char __iomem *)hwif->db_base;
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
+		return err;
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
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag)
 {
-	/* Completed by later submission due to LoC limit. */
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
 }
 
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en)
 {
-	/* Completed by later submission due to LoC limit. */
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
 }
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 2e300fb0ba25..29dd86eb458a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -50,13 +50,24 @@ enum hinic3_msix_state {
 	HINIC3_MSIX_DISABLE,
 };
 
+enum hinic3_msix_auto_mask {
+	HINIC3_CLR_MSIX_AUTO_MASK,
+	HINIC3_SET_MSIX_AUTO_MASK,
+};
+
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
 void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
 
+int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
+			 void __iomem **dwqe_base);
+void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en);
+void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
+				     enum hinic3_msix_auto_mask flag);
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
 
-- 
2.43.0


