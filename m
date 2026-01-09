Return-Path: <netdev+bounces-248430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9079D086AD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EC553027AF8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD333A9E9;
	Fri,  9 Jan 2026 10:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141E2D8760;
	Fri,  9 Jan 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952981; cv=none; b=mbK/sRCESl7gl20wxQjrsJBc2n/6MJPUiricijkI2btdEzb2UagOpomqE45PLt0/lUClu2VA+EHN6MaFduQurPg451Q+sem/whWi6W1MlL4aUCiVxh8xu/zfe48xDZQiUjO/UWXEbS+jLka8xwr54egonRUkLfb7Ii1Gz1gnCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952981; c=relaxed/simple;
	bh=ZQMBGt86yLCu5TsoYLbxz32w+FGWg24wX+viaxW24NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7EyPGGU3qlunaZDjWCTyk+I23qoNUZ0ntjoTeM5LSzJcOXbb5Ha4T+Cy36whMVbJz5lerMVkchsW+9GSK58Ffl4cz19FcEWXihJhwJ93WJDrTNenbBMLuHg6zJou8GqKy2MeeN5trEZYLhBAFj6mJdYX9t2ZLoogZeCwVBmvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQB-Z_1767952966 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:47 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 14/15] net/nebula-matrix: add Dev start, stop operation
Date: Fri,  9 Jan 2026 18:01:32 +0800
Message-ID: <20260109100146.63569-15-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

some important steps in dev start:
1.start common dev: config msix map table, alloc and enable msix
vectors, register mailbox ISR and enable mailbox irq, set up chan
keepalive task.
2.start ctrl dev: request abnormal and adminq ISR , enable them.
schedule some ctrl tasks such as adapt desc gother task.
3.start net dev:
 3.1 alloc netdev with multi-queue support, config private data
and associatess with the adapter.
 3.2 alloc tx/rx rings, set up network resource managements(vlan,rate
limiting)
 3.3 build the netdev structure, map queues to msix interrupts, init
hw stats.
 3.4 register link stats and reset event chan msg.
 3.5 start net vsi and register net irq.
 3.6 register netdev

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    3 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 1620 ++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 2036 ++++++++++++++++-
 .../nbl/nbl_include/nbl_def_dev.h             |    4 +
 .../nbl/nbl_include/nbl_def_service.h         |   56 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   49 +
 6 files changed, 3737 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 685d9f1831be..3db1364eefdc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -127,4 +127,7 @@ struct nbl_netdev_priv {
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
+void nbl_core_stop(struct nbl_adapter *adapter);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 6b797d7ddbf8..a379a5851523 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -14,8 +14,25 @@
 static struct nbl_dev_board_id_table board_id_table;
 static struct nbl_dev_ops dev_ops;
 
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
+static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info);
 static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt);
+
 /* ----------  Basic functions  ---------- */
+static int nbl_dev_get_port_attributes(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->get_port_attributes(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+static int nbl_dev_enable_port(struct nbl_dev_mgt *dev_mgt, bool enable)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->enable_port(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), enable);
+}
+
 static int nbl_dev_alloc_board_id(struct nbl_dev_board_id_table *index_table,
 				  u32 board_key)
 {
@@ -58,7 +75,37 @@ static void nbl_dev_free_board_id(struct nbl_dev_board_id_table *index_table,
 		       sizeof(index_table->entry[i]));
 }
 
+static void nbl_dev_set_netdev_priv(struct net_device *netdev,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_netdev_priv *net_priv = netdev_priv(netdev);
+
+	net_priv->tx_queue_num = vsi->queue_num;
+	net_priv->rx_queue_num = vsi->queue_num;
+	net_priv->queue_size = vsi->queue_size;
+	net_priv->netdev = netdev;
+	net_priv->data_vsi = vsi->vsi_id;
+}
+
 /* ----------  Interrupt config  ---------- */
+static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
+
+	nbl_dev_clean_mailbox_schedule(dev_mgt);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nbl_dev_clean_adminq(int __always_unused irq, void *data)
+{
+	struct nbl_task_info *task_info = (struct nbl_task_info *)data;
+
+	nbl_dev_clean_adminq_schedule(task_info);
+
+	return IRQ_HANDLED;
+}
+
 static void nbl_dev_handle_abnormal_event(struct work_struct *work)
 {
 	struct nbl_task_info *task_info = container_of(work,
@@ -70,6 +117,24 @@ static void nbl_dev_handle_abnormal_event(struct work_struct *work)
 	serv_ops->process_abnormal_event(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
 }
 
+static void nbl_dev_clean_abnormal_status(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	nbl_common_queue_work(&task_info->clean_abnormal_irq_task, true);
+}
+
+static irqreturn_t nbl_dev_clean_abnormal_event(int __always_unused irq,
+						void *data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
+
+	nbl_dev_clean_abnormal_status(dev_mgt);
+
+	return IRQ_HANDLED;
+}
+
 static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
@@ -109,6 +174,486 @@ static void nbl_dev_register_ctrl_irq(struct nbl_dev_mgt *dev_mgt)
 		irq_num.adminq_irq_num;
 }
 
+static int nbl_dev_request_net_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = { 0 };
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	int ret = 0;
+
+	param.msix_entries =
+		kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return -ENOMEM;
+
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries,
+	       msix_info->msix_entries +
+		       msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+	       sizeof(param.msix_entries[0]) * msix_num);
+
+	ret = serv_ops->request_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					&param);
+
+	kfree(param.msix_entries);
+	return ret;
+}
+
+static void nbl_dev_free_net_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = { 0 };
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+
+	param.msix_entries =
+		kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return;
+
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries,
+	       msix_info->msix_entries +
+		       msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+	       sizeof(param.msix_entries[0]) * msix_num);
+
+	serv_ops->free_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
+
+	kfree(param.msix_entries);
+}
+
+static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	u16 local_vec_id;
+	u32 irq_num;
+	int err;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+
+	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
+		 "nbl_mailbox@pci:%s", pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_mailbox, 0,
+			       dev_common->mailbox_name, dev_mgt);
+	if (err) {
+		dev_err(dev, "Request mailbox irq handler failed err: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	u16 local_vec_id;
+	u32 irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+
+	devm_free_irq(dev, irq_num, dev_mgt);
+}
+
+static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, true);
+
+	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, true);
+}
+
+static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_flush_task(&dev_common->clean_mbx_task);
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, false);
+
+	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, false);
+}
+
+static int nbl_dev_request_adminq_irq(struct nbl_dev_mgt *dev_mgt,
+				      struct nbl_task_info *task_info)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	u16 local_vec_id;
+	u32 irq_num;
+	char *irq_name;
+	int err;
+
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+	irq_name = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].irq_name;
+
+	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_adminq@pci:%s",
+		 pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_adminq, 0, irq_name,
+			       task_info);
+	if (err) {
+		dev_err(dev, "Request adminq irq handler failed err: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void nbl_dev_free_adminq_irq(struct nbl_dev_mgt *dev_mgt,
+				    struct nbl_task_info *task_info)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	u16 local_vec_id;
+	u32 irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+
+	devm_free_irq(dev, irq_num, task_info);
+}
+
+static int nbl_dev_enable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_ADMINQ, true);
+
+	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, true);
+}
+
+static int nbl_dev_disable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_ADMINQ, false);
+
+	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, false);
+}
+
+static int nbl_dev_request_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	char *irq_name;
+	u32 irq_num;
+	int err;
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+	irq_name = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].irq_name;
+
+	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_abnormal@pci:%s",
+		 pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_abnormal_event, 0,
+			       irq_name, dev_mgt);
+	if (err) {
+		dev_err(dev,
+			"Request abnormal_irq irq handler failed err: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void nbl_dev_free_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	u16 local_vec_id;
+	u32 irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vec_id].vector;
+
+	devm_free_irq(dev, irq_num, dev_mgt);
+}
+
+static int nbl_dev_enable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+	int err = 0;
+
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, true);
+
+	return err;
+}
+
+static int nbl_dev_disable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vec_id;
+	int err = 0;
+
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vec_id, false);
+
+	return err;
+}
+
+static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 msix_not_net_num = 0;
+	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
+	int err = 0;
+	int i;
+
+	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
+		msix_info->serv_info[i].base_vector_id =
+			msix_info->serv_info[i - 1].base_vector_id +
+			msix_info->serv_info[i - 1].num;
+
+	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++) {
+		if (i == NBL_MSIX_NET_TYPE)
+			continue;
+
+		msix_not_net_num += msix_info->serv_info[i].num;
+	}
+
+	err = serv_ops->configure_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   msix_net_num,
+					   msix_not_net_num,
+					   mask_en);
+
+	return err;
+}
+
+static int nbl_dev_destroy_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	int err = 0;
+
+	err = serv_ops->destroy_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	return err;
+}
+
+static int nbl_dev_alloc_msix_entries(struct nbl_dev_mgt *dev_mgt,
+				      u16 num_entries)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u16 i;
+
+	msix_info->msix_entries =
+		devm_kcalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), num_entries,
+			     sizeof(msix_info->msix_entries), GFP_KERNEL);
+	if (!msix_info->msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < num_entries; i++)
+		msix_info->msix_entries[i].entry =
+				serv_ops->get_msix_entry_id(priv, i);
+
+	dev_info(NBL_DEV_MGT_TO_DEV(dev_mgt), "alloc msix entry: %u-%u.\n",
+		 msix_info->msix_entries[0].entry,
+		 msix_info->msix_entries[num_entries - 1].entry);
+
+	return 0;
+}
+
+static void nbl_dev_free_msix_entries(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+
+	devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), msix_info->msix_entries);
+	msix_info->msix_entries = NULL;
+}
+
+static int nbl_dev_alloc_msix_intr(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int needed = 0;
+	int err;
+	int i;
+
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
+		needed += msix_info->serv_info[i].num;
+
+	err = nbl_dev_alloc_msix_entries(dev_mgt, (u16)needed);
+	if (err) {
+		pr_err("Allocate msix entries failed\n");
+		return err;
+	}
+
+	err = pci_enable_msix_range(NBL_COMMON_TO_PDEV(common),
+				    msix_info->msix_entries, needed, needed);
+	if (err < 0) {
+		pr_err("pci_enable_msix_range failed, err = %d.\n", err);
+		goto enable_msix_failed;
+	}
+
+	return needed;
+
+enable_msix_failed:
+	nbl_dev_free_msix_entries(dev_mgt);
+	return err;
+}
+
+static void nbl_dev_free_msix_intr(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	pci_disable_msix(NBL_COMMON_TO_PDEV(common));
+	nbl_dev_free_msix_entries(dev_mgt);
+}
+
+static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	int err = 0;
+
+	err = nbl_dev_alloc_msix_intr(dev_mgt);
+	if (err < 0) {
+		dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt),
+			"Failed to enable MSI-X vectors\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	nbl_dev_free_msix_intr(dev_mgt);
+}
+
 /* ----------  Channel config  ---------- */
 static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -152,6 +697,43 @@ static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 	return ret;
 }
 
+static bool nbl_dev_should_chan_keepalive(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	bool ret = true;
+
+	ret = serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    NBL_TASK_KEEP_ALIVE);
+
+	return ret;
+}
+
+static int nbl_dev_setup_chan_keepalive(struct nbl_dev_mgt *dev_mgt,
+					u8 chan_type)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt);
+	u16 dest_func_id = NBL_COMMON_TO_MGT_PF(common);
+
+	if (!nbl_dev_should_chan_keepalive(dev_mgt))
+		return 0;
+
+	if (chan_type != NBL_CHAN_TYPE_MAILBOX)
+		return -EOPNOTSUPP;
+
+	dest_func_id =
+		serv_ops->get_function_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_COMMON_TO_VSI_ID(common));
+
+	if (chan_ops->check_queue_exist(priv, chan_type))
+		return chan_ops->setup_keepalive(priv,
+						 dest_func_id, chan_type);
+
+	return -ENOENT;
+}
+
 static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt,
 					  u8 chan_type)
 {
@@ -182,8 +764,21 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
 	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
 	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-				      NBL_CHAN_TYPE_MAILBOX);
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				      NBL_CHAN_TYPE_MAILBOX);
+}
+
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+
+	if (ctrl_dev)
+		queue_work(ctrl_dev->ctrl_dev_wq1, &common_dev->clean_mbx_task);
+	else
+		nbl_common_queue_work(&common_dev->clean_mbx_task, false);
+
+	return 0;
 }
 
 static void nbl_dev_prepare_reset_task(struct work_struct *work)
@@ -232,6 +827,11 @@ static void nbl_dev_clean_adminq_task(struct work_struct *work)
 				      NBL_CHAN_TYPE_ADMINQ);
 }
 
+static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info)
+{
+	nbl_common_queue_work(&task_info->clean_adminq_task, true);
+}
+
 static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
 {
 	struct nbl_task_info *task_info =
@@ -257,6 +857,39 @@ static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
 
 static void nbl_dev_fw_reset_task(struct work_struct *work)
 {
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nbl_task_info *task_info =
+		container_of(delayed_work, struct nbl_task_info, fw_reset_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	if (serv_ops->check_fw_reset(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
+		dev_notice(NBL_COMMON_TO_DEV(common), "FW recovered");
+		nbl_dev_disable_adminq_irq(dev_mgt);
+		nbl_dev_free_adminq_irq(dev_mgt, task_info);
+
+		msleep(NBL_DEV_FW_RESET_WAIT_TIME); // wait adminq timeout
+		nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_request_adminq_irq(dev_mgt, task_info);
+		nbl_dev_enable_adminq_irq(dev_mgt);
+
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					  NBL_CHAN_ABNORMAL,
+					  NBL_CHAN_TYPE_ADMINQ, false);
+
+		if (NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)) {
+			nbl_dev_get_port_attributes(dev_mgt);
+			nbl_dev_enable_port(dev_mgt, true);
+		}
+		task_info->fw_resetting = false;
+		return;
+	}
+
+	nbl_common_q_dwork(delayed_work, MSEC_PER_SEC, true);
 }
 
 static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
@@ -318,6 +951,30 @@ static void nbl_dev_ctrl_task_timer(struct timer_list *t)
 	nbl_dev_ctrl_task_schedule(task_info);
 }
 
+static void nbl_dev_ctrl_task_start(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	if (!task_info->timer_setup)
+		return;
+
+	mod_timer(&task_info->serv_timer,
+		  round_jiffies(jiffies + task_info->serv_timer_period));
+}
+
+static void nbl_dev_ctrl_task_stop(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	if (!task_info->timer_setup)
+		return;
+
+	timer_delete_sync(&task_info->serv_timer);
+	task_info->timer_setup = false;
+}
+
 static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
 					 void *data, u32 data_len)
 {
@@ -842,6 +1499,33 @@ static void nbl_dev_netdev_get_stats64(struct net_device *netdev,
 	serv_ops->get_stats64(netdev, stats);
 }
 
+static void nbl_dev_netdev_set_rx_mode(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->set_rx_mode(netdev);
+}
+
+static void nbl_dev_netdev_change_rx_flags(struct net_device *netdev, int flag)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->change_rx_flags(netdev, flag);
+}
+
+static int nbl_dev_netdev_set_mac(struct net_device *netdev, void *p)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_mac(netdev, p);
+}
+
 static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto,
 				     u16 vid)
 {
@@ -862,14 +1546,83 @@ static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto,
 	return serv_ops->rx_kill_vid(netdev, proto, vid);
 }
 
+static int nbl_dev_netdev_set_features(struct net_device *netdev,
+				       netdev_features_t features)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->set_features(netdev, features);
+}
+
+static netdev_features_t
+nbl_dev_netdev_features_check(struct sk_buff *skb, struct net_device *netdev,
+			      netdev_features_t features)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->features_check(skb, netdev, features);
+}
+
+static void nbl_dev_netdev_tx_timeout(struct net_device *netdev, u32 txqueue)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->tx_timeout(netdev, txqueue);
+}
+
+static u16 nbl_dev_netdev_select_queue(struct net_device *netdev,
+				       struct sk_buff *skb,
+				       struct net_device *sb_dev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->select_queue(netdev, skb, sb_dev);
+}
+
+static int nbl_dev_netdev_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->change_mtu(netdev, new_mtu);
+}
+
+static int nbl_dev_ndo_get_phys_port_name(struct net_device *netdev, char *name,
+					  size_t len)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->get_phys_port_name(netdev, name, len);
+}
+
 static const struct net_device_ops netdev_ops_leonis_pf = {
 	.ndo_open = nbl_dev_netdev_open,
 	.ndo_stop = nbl_dev_netdev_stop,
 	.ndo_start_xmit = nbl_dev_start_xmit,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_set_rx_mode = nbl_dev_netdev_set_rx_mode,
+	.ndo_change_rx_flags = nbl_dev_netdev_change_rx_flags,
+	.ndo_set_mac_address = nbl_dev_netdev_set_mac,
 	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+	.ndo_set_features = nbl_dev_netdev_set_features,
+	.ndo_features_check = nbl_dev_netdev_features_check,
+	.ndo_tx_timeout = nbl_dev_netdev_tx_timeout,
+	.ndo_select_queue = nbl_dev_netdev_select_queue,
+	.ndo_change_mtu = nbl_dev_netdev_change_mtu,
+	.ndo_get_phys_port_name = nbl_dev_ndo_get_phys_port_name,
 
 };
 
@@ -879,9 +1632,15 @@ static const struct net_device_ops netdev_ops_leonis_vf = {
 	.ndo_start_xmit = nbl_dev_start_xmit,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_set_rx_mode = nbl_dev_netdev_set_rx_mode,
+	.ndo_set_mac_address = nbl_dev_netdev_set_mac,
 	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
-
+	.ndo_features_check = nbl_dev_netdev_features_check,
+	.ndo_tx_timeout = nbl_dev_netdev_tx_timeout,
+	.ndo_select_queue = nbl_dev_netdev_select_queue,
+	.ndo_change_mtu = nbl_dev_netdev_change_mtu,
+	.ndo_get_phys_port_name = nbl_dev_ndo_get_phys_port_name,
 };
 
 static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
@@ -901,6 +1660,80 @@ static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
 	return 0;
 }
 
+static void nbl_dev_remove_netops(struct net_device *netdev)
+{
+	netdev->netdev_ops = NULL;
+}
+
+static void nbl_dev_set_eth_mac_addr(struct nbl_dev_mgt *dev_mgt,
+				     struct net_device *netdev)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	u8 mac[ETH_ALEN];
+
+	ether_addr_copy(mac, netdev->dev_addr);
+	serv_ops->set_eth_mac_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), mac,
+				   NBL_COMMON_TO_ETH_ID(common));
+}
+
+static int nbl_dev_cfg_netdev(struct net_device *netdev,
+			      struct nbl_dev_mgt *dev_mgt,
+			      struct nbl_init_param *param,
+			      struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net_ops *net_dev_ops =
+		NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt);
+	u64 vlan_features = 0;
+	int ret = 0;
+
+	if (param->pci_using_dac)
+		netdev->features |= NETIF_F_HIGHDMA;
+	netdev->watchdog_timeo = 5 * HZ;
+
+	vlan_features = register_result->vlan_features ?
+				register_result->vlan_features :
+				register_result->features;
+	netdev->hw_features |=
+		nbl_features_to_netdev_features(register_result->hw_features);
+	netdev->features |=
+		nbl_features_to_netdev_features(register_result->features);
+	netdev->vlan_features |= nbl_features_to_netdev_features(vlan_features);
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	SET_DEV_MIN_MTU(netdev, ETH_MIN_MTU);
+	SET_DEV_MAX_MTU(netdev, register_result->max_mtu);
+	netdev->mtu = min_t(u16, register_result->max_mtu, NBL_DEFAULT_MTU);
+	serv_ops->change_mtu(netdev, netdev->mtu);
+
+	if (is_valid_ether_addr(register_result->mac))
+		eth_hw_addr_set(netdev, register_result->mac);
+	else
+		eth_hw_addr_random(netdev);
+
+	ether_addr_copy(netdev->perm_addr, netdev->dev_addr);
+
+	netdev->needed_headroom =
+		serv_ops->get_tx_headroom(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	ret = net_dev_ops->setup_netdev_ops(dev_mgt, netdev, param);
+	if (ret)
+		goto set_ops_fail;
+
+	nbl_dev_set_eth_mac_addr(dev_mgt, netdev);
+
+	return 0;
+set_ops_fail:
+	return ret;
+}
+
+static void nbl_dev_reset_netdev(struct net_device *netdev)
+{
+	nbl_dev_remove_netops(netdev);
+}
+
 static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
 				struct nbl_register_net_result *register_result)
 {
@@ -1020,6 +1853,78 @@ static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt,
 {
 }
 
+static int nbl_dev_vsi_common_start(struct nbl_dev_mgt *dev_mgt,
+				    struct net_device *netdev,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret;
+
+	vsi->napi_netdev = netdev;
+
+	ret = serv_ops->setup_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				    vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup q2vsi failed\n");
+		goto set_q2vsi_fail;
+	}
+
+	ret = serv_ops->setup_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				  vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss failed\n");
+		goto set_rss_fail;
+	}
+
+	ret = serv_ops->setup_rss_indir(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss indir failed\n");
+		goto setup_rss_indir_fail;
+	}
+
+	if (vsi->use_independ_irq) {
+		ret = serv_ops->enable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					     vsi->index);
+		if (ret) {
+			dev_err(dev, "Enable napis failed\n");
+			goto enable_napi_fail;
+		}
+	}
+
+	ret = serv_ops->init_tx_rate(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "init tx_rate failed\n");
+		goto init_tx_rate_fail;
+	}
+
+	return 0;
+
+init_tx_rate_fail:
+	serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
+enable_napi_fail:
+setup_rss_indir_fail:
+	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_rss_fail:
+	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_q2vsi_fail:
+	return ret;
+}
+
+static void nbl_dev_vsi_common_stop(struct nbl_dev_mgt *dev_mgt,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (vsi->use_independ_irq)
+		serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					vsi->index);
+	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+}
+
 static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt,
 				     struct nbl_init_param *param,
 				     void *vsi_data)
@@ -1056,35 +1961,172 @@ static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
 	nbl_dev_vsi_common_remove(dev_mgt, vsi);
 }
 
-static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt,
-				     struct nbl_init_param *param,
-				     void *vsi_data)
+static int nbl_dev_vsi_data_start(void *dev_priv, struct net_device *netdev,
+				  void *vsi_data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int ret;
+	u16 vid;
+
+	vid = vsi->register_result.vlan_tci & VLAN_VID_MASK;
+	ret = serv_ops->start_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				       netdev, vsi->vsi_id, vid,
+				       vsi->register_result.trusted);
+	if (ret) {
+		dev_err(dev, "Set netdev flow table failed\n");
+		goto set_flow_fail;
+	}
+
+	if (!NBL_COMMON_TO_VF_CAP(common)) {
+		ret = serv_ops->set_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					      vsi->vsi_id);
+		if (ret) {
+			dev_err(dev, "Set netdev lldp flow failed\n");
+			goto set_lldp_fail;
+		}
+		vsi->feature.has_lldp = true;
+	}
+
+	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Vsi common start failed\n");
+		goto common_start_fail;
+	}
+
+	return 0;
+
+common_start_fail:
+	if (!NBL_COMMON_TO_VF_CAP(common))
+		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   vsi->vsi_id);
+set_lldp_fail:
+	serv_ops->stop_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_flow_fail:
+	return ret;
+}
+
+static void nbl_dev_vsi_data_stop(void *dev_priv, void *vsi_data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_stop(dev_mgt, vsi);
+
+	if (!NBL_COMMON_TO_VF_CAP(common)) {
+		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   vsi->vsi_id);
+		vsi->feature.has_lldp = false;
+	}
+
+	serv_ops->stop_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+}
+
+static int nbl_dev_vsi_data_netdev_build(struct nbl_dev_mgt *dev_mgt,
+					 struct nbl_init_param *param,
+					 struct net_device *netdev,
+					 void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	vsi->netdev = netdev;
+	return nbl_dev_cfg_netdev(netdev, dev_mgt, param,
+				  &vsi->register_result);
+}
+
+static void nbl_dev_vsi_data_netdev_destroy(struct nbl_dev_mgt *dev_mgt,
+					    void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_reset_netdev(vsi->netdev);
+}
+
+static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt,
+				     struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     &vsi->queue_num, &vsi->queue_size);
+
+	nbl_debug(common, "Ctrl vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+	return 0;
+}
+
+static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt,
+				  struct nbl_init_param *param, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_ctrl_start(void *dev_priv, struct net_device *netdev,
+				  void *vsi_data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	int ret;
+
+	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
+	if (ret)
+		goto start_fail;
+
+	/* For ctrl vsi, open it after create, for that
+	 *we don't have ndo_open ops.
+	 */
+	ret = serv_ops->vsi_open(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev,
+				 vsi->index, vsi->queue_num, 1);
+	if (ret)
+		goto open_fail;
+
+	return ret;
+
+open_fail:
+	nbl_dev_vsi_common_stop(dev_mgt, vsi);
+start_fail:
+	return ret;
+}
+
+static void nbl_dev_vsi_ctrl_stop(void *dev_priv, void *vsi_data)
 {
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
 	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-				     &vsi->queue_num, &vsi->queue_size);
-
-	nbl_debug(common, "Ctrl vsi register, queue_num %d, queue_size %d",
-		  vsi->queue_num, vsi->queue_size);
-	return 0;
+	serv_ops->vsi_stop(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
+	nbl_dev_vsi_common_stop(dev_mgt, vsi);
 }
 
-static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt,
-				  struct nbl_init_param *param, void *vsi_data)
+static int nbl_dev_vsi_ctrl_netdev_build(struct nbl_dev_mgt *dev_mgt,
+					 struct nbl_init_param *param,
+					 struct net_device *netdev,
+					 void *vsi_data)
 {
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
-
-	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+	return 0;
 }
 
-static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+static void nbl_dev_vsi_ctrl_netdev_destroy(struct nbl_dev_mgt *dev_mgt,
+					    void *vsi_data)
 {
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
-
-	nbl_dev_vsi_common_remove(dev_mgt, vsi);
 }
 
 static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
@@ -1093,6 +2135,10 @@ static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
 			.register_vsi = nbl_dev_vsi_data_register,
 			.setup = nbl_dev_vsi_data_setup,
 			.remove = nbl_dev_vsi_data_remove,
+			.start = nbl_dev_vsi_data_start,
+			.stop = nbl_dev_vsi_data_stop,
+			.netdev_build = nbl_dev_vsi_data_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_data_netdev_destroy,
 		},
 		.vf_support = true,
 		.only_nic_support = false,
@@ -1105,6 +2151,10 @@ static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
 			.register_vsi = nbl_dev_vsi_ctrl_register,
 			.setup = nbl_dev_vsi_ctrl_setup,
 			.remove = nbl_dev_vsi_ctrl_remove,
+			.start = nbl_dev_vsi_ctrl_start,
+			.stop = nbl_dev_vsi_ctrl_stop,
+			.netdev_build = nbl_dev_vsi_ctrl_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_ctrl_netdev_destroy,
 		},
 		.vf_support = false,
 		.only_nic_support = true,
@@ -1423,6 +2473,532 @@ void nbl_dev_remove(void *p)
 	nbl_dev_remove_dev_mgt(common, dev_mgt);
 }
 
+static void nbl_dev_notify_dev_prepare_reset(struct nbl_dev_mgt *dev_mgt,
+					     enum nbl_reset_event event)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_chan_send_info chan_send;
+	unsigned long cur_func = 0;
+	unsigned long next_func = 0;
+	unsigned long *func_bitmap;
+	int func_num = 0;
+
+	func_bitmap = devm_kcalloc(NBL_COMMON_TO_DEV(common),
+				   BITS_TO_LONGS(NBL_MAX_FUNC), sizeof(long),
+				   GFP_KERNEL);
+	if (!func_bitmap)
+		return;
+
+	serv_ops->get_active_func_bitmaps(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  func_bitmap, NBL_MAX_FUNC);
+	memset(dev_mgt->ctrl_dev->task_info.reset_status, 0,
+	       sizeof(dev_mgt->ctrl_dev->task_info.reset_status));
+	/* clear ctrl_dev func_id, and do it last */
+	clear_bit(NBL_COMMON_TO_MGT_PF(common), func_bitmap);
+
+	cur_func = NBL_COMMON_TO_MGT_PF(common);
+	while (1) {
+		next_func =
+			find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
+		if (next_func >= NBL_MAX_FUNC)
+			break;
+
+		cur_func = next_func;
+		dev_mgt->ctrl_dev->task_info.reset_status[cur_func] =
+			NBL_RESET_SEND;
+		NBL_CHAN_SEND(chan_send, cur_func,
+			      NBL_CHAN_MSG_NOTIFY_RESET_EVENT, &event,
+			      sizeof(event), NULL, 0, 0);
+		chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				   &chan_send);
+		func_num++;
+		if (func_num >= NBL_DEV_BATCH_RESET_FUNC_NUM) {
+			usleep_range(NBL_DEV_BATCH_RESET_USEC,
+				     NBL_DEV_BATCH_RESET_USEC * 2);
+			func_num = 0;
+		}
+	}
+
+	if (func_num)
+		usleep_range(NBL_DEV_BATCH_RESET_USEC,
+			     NBL_DEV_BATCH_RESET_USEC * 2);
+
+	/* ctrl dev need proc last, basecase reset task will close mailbox */
+	dev_mgt->ctrl_dev->task_info.reset_status[common->mgt_pf] =
+		NBL_RESET_SEND;
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_NOTIFY_RESET_EVENT, NULL, 0, NULL, 0, 0);
+	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+	usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
+
+	cur_func = NBL_COMMON_TO_MGT_PF(common);
+	while (1) {
+		if (dev_mgt->ctrl_dev->task_info.reset_status[cur_func] ==
+		    NBL_RESET_SEND)
+			nbl_info(common, "func %ld reset failed", cur_func);
+
+		next_func =
+			find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
+		if (next_func >= NBL_MAX_FUNC)
+			break;
+
+		cur_func = next_func;
+	}
+
+	devm_kfree(NBL_COMMON_TO_DEV(common), func_bitmap);
+}
+
 static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt)
 {
+	struct nbl_adapter *adapter =
+		NBL_NETDEV_TO_ADAPTER(dev_mgt->net_dev->netdev);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_chan_param_notify_fw_reset_info fw_reset = {0};
+	struct nbl_chan_send_info chan_send;
+
+	if (test_and_set_bit(NBL_FATAL_ERR, adapter->state)) {
+		nbl_info(common, "dev in fatal_err status already.");
+		return;
+	}
+
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+	nbl_dev_ctrl_task_stop(dev_mgt);
+	nbl_dev_notify_dev_prepare_reset(dev_mgt, NBL_HW_FATAL_ERR_EVENT);
+
+	/* notify emp shutdown dev */
+	fw_reset.type = NBL_FW_HIGH_TEMP_RESET;
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_NOTIFY_FW_RESET, &fw_reset,
+		      sizeof(fw_reset), NULL, 0, 0);
+	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  NBL_CHAN_ABNORMAL, NBL_CHAN_TYPE_ADMINQ,
+				  true);
+	serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				NBL_HW_FATAL_ERR);
+	nbl_info(common, "dev in fatal_err status.");
+}
+
+/* ----------  Dev start process  ---------- */
+static int nbl_dev_start_ctrl_dev(struct nbl_adapter *adapter,
+				  struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	int err;
+
+	err = nbl_dev_request_abnormal_irq(dev_mgt);
+	if (err)
+		goto abnormal_request_irq_err;
+
+	err = nbl_dev_enable_abnormal_irq(dev_mgt);
+	if (err)
+		goto enable_abnormal_irq_err;
+
+	err = nbl_dev_request_adminq_irq(dev_mgt,
+					 &ctrl_dev->task_info);
+	if (err)
+		goto request_adminq_irq_err;
+
+	err = nbl_dev_enable_adminq_irq(dev_mgt);
+	if (err)
+		goto enable_adminq_irq_err;
+
+	nbl_dev_get_port_attributes(dev_mgt);
+	nbl_dev_enable_port(dev_mgt, true);
+	nbl_dev_ctrl_task_start(dev_mgt);
+
+	return 0;
+
+enable_adminq_irq_err:
+	nbl_dev_free_adminq_irq(dev_mgt,
+				&ctrl_dev->task_info);
+request_adminq_irq_err:
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+enable_abnormal_irq_err:
+	nbl_dev_free_abnormal_irq(dev_mgt);
+abnormal_request_irq_err:
+	return err;
+}
+
+static void nbl_dev_stop_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+
+	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
+		return;
+
+	nbl_dev_ctrl_task_stop(dev_mgt);
+	nbl_dev_enable_port(dev_mgt, false);
+	nbl_dev_disable_adminq_irq(dev_mgt);
+	nbl_dev_free_adminq_irq(dev_mgt,
+				&NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+	nbl_dev_free_abnormal_irq(dev_mgt);
+}
+
+static void nbl_dev_chan_notify_link_state_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct net_device *netdev = (struct net_device *)priv;
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_chan_param_notify_link_state *link_info;
+
+	link_info = (struct nbl_chan_param_notify_link_state *)data;
+
+	serv_ops->set_netdev_carrier_state(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   netdev, link_info->link_state);
+}
+
+static void nbl_dev_register_link_state_chan_msg(struct nbl_dev_mgt *dev_mgt,
+						 struct net_device *netdev)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+			       nbl_dev_chan_notify_link_state_resp, netdev);
+}
+
+static void nbl_dev_chan_notify_reset_event_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	enum nbl_reset_event event = *(enum nbl_reset_event *)data;
+
+	dev_mgt->common_dev->reset_task.event = event;
+	nbl_common_queue_work(&dev_mgt->common_dev->reset_task.task, false);
+}
+
+static void nbl_dev_chan_ack_reset_event_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+
+	WRITE_ONCE(dev_mgt->ctrl_dev->task_info.reset_status[src_id],
+		   NBL_RESET_DONE);
+}
+
+static void nbl_dev_register_reset_event_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+			       nbl_dev_chan_notify_reset_event_resp, dev_mgt);
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ACK_RESET_EVENT,
+			       nbl_dev_chan_ack_reset_event_resp, dev_mgt);
+}
+
+int nbl_dev_setup_vf_config(void *p, int num_vfs)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->setup_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 num_vfs, false);
+}
+
+void nbl_dev_remove_vf_config(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->remove_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+static int nbl_dev_start_net_dev(struct nbl_adapter *adapter,
+				 struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	struct nbl_netdev_priv *net_priv;
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	struct nbl_ring_param ring_param = {0};
+	struct nbl_dev_vsi *vsi;
+	u16 net_vector_id, queue_num;
+	int ret;
+
+	vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_DATA);
+	if (!vsi)
+		return -EFAULT;
+
+	queue_num = vsi->queue_num;
+	netdev = alloc_etherdev_mqs(sizeof(struct nbl_netdev_priv), queue_num,
+				    queue_num);
+	if (!netdev) {
+		dev_err(dev, "Alloc net device failed\n");
+		ret = -ENOMEM;
+		goto alloc_netdev_fail;
+	}
+
+	SET_NETDEV_DEV(netdev, dev);
+	net_priv = netdev_priv(netdev);
+	net_priv->adapter = adapter;
+	nbl_dev_set_netdev_priv(netdev, vsi);
+
+	net_dev->netdev = netdev;
+	common->msg_enable = netif_msg_init(-1, DEFAULT_MSG_ENABLE);
+	serv_ops->set_mask_en(priv, 1);
+
+	ring_param.tx_ring_num = net_dev->kernel_queue_num;
+	ring_param.rx_ring_num = net_dev->kernel_queue_num;
+	ring_param.queue_size = net_priv->queue_size;
+	ret = serv_ops->alloc_rings(priv, netdev, &ring_param);
+	if (ret) {
+		dev_err(dev, "Alloc rings failed\n");
+		goto alloc_rings_fail;
+	}
+
+	serv_ops->cpu_affinity_init(priv,
+				    vsi->queue_num);
+	ret = serv_ops->setup_net_resource_mgt(priv, netdev,
+					       vsi->register_result.vlan_proto,
+					       vsi->register_result.vlan_tci,
+					       vsi->register_result.rate);
+	if (ret) {
+		dev_err(dev, "setup net mgt failed\n");
+		goto setup_net_mgt_fail;
+	}
+
+	/* netdev build must before setup_txrx_queues. Because snoop check mac
+	 * trust the mac if pf use ip link cfg the mac for vf. We judge the
+	 * case will not permit accord queue has alloced when vf modify mac.
+	 */
+	ret = vsi->ops->netdev_build(dev_mgt, param, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Build netdev failed, selected vsi %d\n",
+			vsi->index);
+		goto build_netdev_fail;
+	}
+
+	net_vector_id = msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id;
+	ret = serv_ops->setup_txrx_queues(priv,
+					  vsi->vsi_id, net_dev->total_queue_num,
+					  net_vector_id);
+	if (ret) {
+		dev_err(dev, "Set queue map failed\n");
+		goto set_queue_fail;
+	}
+
+	ret = serv_ops->init_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "init hw stats failed\n");
+		goto init_hw_stats_fail;
+	}
+
+	nbl_dev_register_link_state_chan_msg(dev_mgt, netdev);
+	nbl_dev_register_reset_event_chan_msg(dev_mgt);
+
+	ret = vsi->ops->start(dev_mgt, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Start vsi failed, selected vsi %d\n", vsi->index);
+		goto start_vsi_fail;
+	}
+
+	ret = nbl_dev_request_net_irq(dev_mgt);
+	if (ret) {
+		dev_err(dev, "request irq failed\n");
+		goto request_irq_fail;
+	}
+
+	netif_carrier_off(netdev);
+
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(dev, "Register netdev failed\n");
+		goto register_netdev_fail;
+	}
+
+	if (!param->caps.is_vf) {
+		if (net_dev->total_vfs) {
+			ret = serv_ops->setup_vf_resource(priv,
+							  net_dev->total_vfs);
+			if (ret)
+				goto setup_vf_res_fail;
+		}
+	}
+
+	set_bit(NBL_DOWN, adapter->state);
+
+	return 0;
+setup_vf_res_fail:
+	unregister_netdev(netdev);
+register_netdev_fail:
+	nbl_dev_free_net_irq(dev_mgt);
+request_irq_fail:
+	vsi->ops->stop(dev_mgt, vsi);
+start_vsi_fail:
+	serv_ops->remove_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+init_hw_stats_fail:
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     vsi->vsi_id);
+set_queue_fail:
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+build_netdev_fail:
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+setup_net_mgt_fail:
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+alloc_rings_fail:
+	free_netdev(netdev);
+alloc_netdev_fail:
+	return ret;
+}
+
+static void nbl_dev_stop_net_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	struct net_device *netdev;
+
+	if (!net_dev)
+		return;
+
+	netdev = net_dev->netdev;
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_DATA];
+	if (!vsi)
+		return;
+
+	if (!common->is_vf)
+		serv_ops->remove_vf_resource(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	serv_ops->change_mtu(netdev, 0);
+	unregister_netdev(netdev);
+	rtnl_lock();
+	netif_device_detach(netdev);
+	rtnl_unlock();
+
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+	vsi->ops->stop(dev_mgt, vsi);
+
+	nbl_dev_free_net_irq(dev_mgt);
+
+	serv_ops->remove_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     vsi->vsi_id);
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	free_netdev(netdev);
+}
+
+static int nbl_dev_start_common_dev(struct nbl_adapter *adapter,
+				    struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	int ret;
+
+	ret = nbl_dev_configure_msix_map(dev_mgt);
+	if (ret)
+		goto config_msix_map_err;
+
+	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
+	if (ret)
+		goto init_interrupt_scheme_err;
+
+	ret = nbl_dev_request_mailbox_irq(dev_mgt);
+	if (ret)
+		goto mailbox_request_irq_err;
+
+	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
+	if (ret)
+		goto enable_mailbox_irq_err;
+	nbl_dev_setup_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+
+	return 0;
+enable_mailbox_irq_err:
+	nbl_dev_free_mailbox_irq(dev_mgt);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	nbl_dev_destroy_msix_map(dev_mgt);
+config_msix_map_err:
+	return ret;
+}
+
+static void nbl_dev_stop_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+
+	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	nbl_dev_disable_mailbox_irq(dev_mgt);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	nbl_dev_destroy_msix_map(dev_mgt);
+}
+
+int nbl_dev_start(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	int ret;
+
+	ret = nbl_dev_start_common_dev(adapter, param);
+	if (ret)
+		goto start_common_dev_fail;
+
+	if (param->caps.has_ctrl) {
+		ret = nbl_dev_start_ctrl_dev(adapter, param);
+		if (ret)
+			goto start_ctrl_dev_fail;
+	}
+
+	ret = nbl_dev_start_net_dev(adapter, param);
+	if (ret)
+		goto start_net_dev_fail;
+
+	return 0;
+
+start_net_dev_fail:
+	nbl_dev_stop_ctrl_dev(adapter);
+start_ctrl_dev_fail:
+	nbl_dev_stop_common_dev(adapter);
+start_common_dev_fail:
+	return ret;
+}
+
+void nbl_dev_stop(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	nbl_dev_stop_ctrl_dev(adapter);
+	nbl_dev_stop_net_dev(adapter);
+	nbl_dev_stop_common_dev(adapter);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 76a2a1513e2f..5118615c0dbe 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -15,6 +15,8 @@
 
 static void nbl_serv_set_link_state(struct nbl_service_mgt *serv_mgt,
 				    struct net_device *netdev);
+static int nbl_serv_update_default_vlan(struct nbl_service_mgt *serv_mgt,
+					u16 vid);
 
 static void nbl_serv_set_queue_param(struct nbl_serv_ring *ring, u16 desc_num,
 				     struct nbl_txrx_queue_param *param,
@@ -154,6 +156,98 @@ static void nbl_serv_stop_rings(struct nbl_service_mgt *serv_mgt,
 		disp_ops->stop_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
 }
 
+static int nbl_serv_set_tx_rings(struct nbl_serv_ring_mgt *ring_mgt,
+				 struct net_device *netdev, struct device *dev)
+{
+	u16 ring_num = ring_mgt->tx_ring_num;
+	int i;
+
+	ring_mgt->tx_rings = devm_kcalloc(dev, ring_num,
+					  sizeof(*ring_mgt->tx_rings),
+					  GFP_KERNEL);
+	if (!ring_mgt->tx_rings)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->tx_rings[i].index = i;
+
+	return 0;
+}
+
+static void nbl_serv_remove_tx_ring(struct nbl_serv_ring_mgt *ring_mgt,
+				    struct device *dev)
+{
+	devm_kfree(dev, ring_mgt->tx_rings);
+	ring_mgt->tx_rings = NULL;
+}
+
+static int nbl_serv_set_rx_rings(struct nbl_serv_ring_mgt *ring_mgt,
+				 struct net_device *netdev, struct device *dev)
+{
+	u16 ring_num = ring_mgt->rx_ring_num;
+	int i;
+
+	ring_mgt->rx_rings = devm_kcalloc(dev, ring_num,
+					  sizeof(*ring_mgt->rx_rings),
+					  GFP_KERNEL);
+	if (!ring_mgt->rx_rings)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->rx_rings[i].index = i;
+
+	return 0;
+}
+
+static void nbl_serv_remove_rx_ring(struct nbl_serv_ring_mgt *ring_mgt,
+				    struct device *dev)
+{
+	devm_kfree(dev, ring_mgt->rx_rings);
+	ring_mgt->rx_rings = NULL;
+}
+
+static int nbl_serv_set_vectors(struct nbl_service_mgt *serv_mgt,
+				struct net_device *netdev, struct device *dev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_resource_pt_ops *pt_ops = NBL_ADAPTER_TO_RES_PT_OPS(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	u16 ring_num = ring_mgt->rx_ring_num;
+	int i;
+
+	ring_mgt->vectors = devm_kcalloc(dev, ring_num,
+					 sizeof(*ring_mgt->vectors),
+					 GFP_KERNEL);
+	if (!ring_mgt->vectors)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++) {
+		ring_mgt->vectors[i].nbl_napi =
+			disp_ops->get_vector_napi(p, i);
+		netif_napi_add(netdev, &ring_mgt->vectors[i].nbl_napi->napi,
+			       pt_ops->napi_poll);
+		ring_mgt->vectors[i].netdev = netdev;
+		cpumask_clear(&ring_mgt->vectors[i].cpumask);
+	}
+
+	return 0;
+}
+
+static void nbl_serv_remove_vectors(struct nbl_serv_ring_mgt *ring_mgt,
+				    struct device *dev)
+{
+	u16 ring_num = ring_mgt->rx_ring_num;
+	int i;
+
+	for (i = 0; i < ring_num; i++)
+		netif_napi_del(&ring_mgt->vectors[i].nbl_napi->napi);
+
+	devm_kfree(dev, ring_mgt->vectors);
+	ring_mgt->vectors = NULL;
+}
+
 static void nbl_serv_check_flow_table_spec(struct nbl_service_mgt *serv_mgt)
 {
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
@@ -175,6 +269,17 @@ static void nbl_serv_check_flow_table_spec(struct nbl_service_mgt *serv_mgt)
 	}
 }
 
+static bool nbl_serv_check_need_flow_rule(u8 *mac, u16 promisc)
+{
+	if (!is_multicast_ether_addr(mac) && (promisc & BIT(NBL_PROMISC)))
+		return false;
+
+	if (is_multicast_ether_addr(mac) && (promisc & BIT(NBL_ALLMULTI)))
+		return false;
+
+	return true;
+}
+
 static struct nbl_serv_vlan_node *nbl_serv_alloc_vlan_node(void)
 {
 	struct nbl_serv_vlan_node *vlan_node = NULL;
@@ -196,6 +301,87 @@ static void nbl_serv_free_vlan_node(struct nbl_serv_vlan_node *vlan_node)
 	kfree(vlan_node);
 }
 
+static struct nbl_serv_submac_node *nbl_serv_alloc_submac_node(void)
+{
+	struct nbl_serv_submac_node *submac_node = NULL;
+
+	submac_node = kzalloc(sizeof(*submac_node), GFP_ATOMIC);
+	if (!submac_node)
+		return NULL;
+
+	INIT_LIST_HEAD(&submac_node->node);
+	submac_node->effective = 0;
+
+	return submac_node;
+}
+
+static void nbl_serv_free_submac_node(struct nbl_serv_submac_node *submac_node)
+{
+	kfree(submac_node);
+}
+
+static int
+nbl_serv_update_submac_node_effective(struct nbl_service_mgt *serv_mgt,
+				      struct nbl_serv_submac_node *submac_node,
+				      bool effective, u16 vsi)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+	bool force_promisc = 0;
+	int ret = 0;
+
+	if (submac_node->effective == effective)
+		return 0;
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (!vlan_node->sub_mac_effective)
+			continue;
+
+		if (effective) {
+			ret = disp_ops->add_macvlan(p,
+						    submac_node->mac,
+						    vlan_node->vid, vsi);
+			if (ret)
+				goto del_macvlan_node;
+		} else {
+			disp_ops->del_macvlan(p,
+					      submac_node->mac,
+					      vlan_node->vid, vsi);
+		}
+	}
+	submac_node->effective = effective;
+	if (effective)
+		flow_mgt->active_submac_list++;
+	else
+		flow_mgt->active_submac_list--;
+
+	return 0;
+
+del_macvlan_node:
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (vlan_node->sub_mac_effective)
+			disp_ops->del_macvlan(p,
+					      submac_node->mac,
+					      vlan_node->vid, vsi);
+	}
+
+	if (ret) {
+		force_promisc = 1;
+		if (flow_mgt->force_promisc ^ force_promisc) {
+			flow_mgt->force_promisc = force_promisc;
+			flow_mgt->pending_async_work = 1;
+			netdev_info(dev, "Reached MAC filter limit, forcing promisc/allmuti mode\n");
+		}
+	}
+
+	return 0;
+}
+
 static int
 nbl_serv_update_vlan_node_effective(struct nbl_service_mgt *serv_mgt,
 				    struct nbl_serv_vlan_node *vlan_node,
@@ -279,6 +465,193 @@ nbl_serv_update_vlan_node_effective(struct nbl_service_mgt *serv_mgt,
 	return ret;
 }
 
+static void nbl_serv_del_submac_node(struct nbl_service_mgt *serv_mgt, u8 *mac,
+				     u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *mac_node, *mac_node_safe;
+	struct list_head *submac_head;
+
+	if (is_multicast_ether_addr(mac))
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_MULTI];
+	else
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_UNICAST];
+
+	list_for_each_entry_safe(mac_node, mac_node_safe, submac_head,
+				 node)
+		if (ether_addr_equal(mac_node->mac, mac)) {
+			if (mac_node->effective)
+				nbl_serv_update_submac_node_effective(serv_mgt,
+								      mac_node,
+								      0, vsi);
+			list_del(&mac_node->node);
+			flow_mgt->submac_list_cnt--;
+			if (is_multicast_ether_addr(mac_node->mac))
+				flow_mgt->multi_mac_cnt--;
+			else
+				flow_mgt->unicast_mac_cnt--;
+			nbl_serv_free_submac_node(mac_node);
+			break;
+		}
+}
+
+static int nbl_serv_add_submac_node(struct nbl_service_mgt *serv_mgt, u8 *mac,
+				    u16 vsi, u16 promisc)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node;
+	struct list_head *submac_head;
+
+	if (is_multicast_ether_addr(mac))
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_MULTI];
+	else
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_UNICAST];
+
+	list_for_each_entry(submac_node, submac_head, node) {
+		if (ether_addr_equal(submac_node->mac, mac))
+			return 0;
+	}
+
+	submac_node = nbl_serv_alloc_submac_node();
+	if (!submac_node)
+		return -ENOMEM;
+
+	submac_node->effective = 0;
+	ether_addr_copy(submac_node->mac, mac);
+	if (nbl_serv_check_need_flow_rule(mac, promisc) &&
+	    (flow_mgt->trusted_en ||
+	     flow_mgt->active_submac_list < NBL_NO_TRUST_MAX_MAC)) {
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node, 1,
+						      vsi);
+	}
+
+	list_add(&submac_node->node, submac_head);
+	flow_mgt->submac_list_cnt++;
+	if (is_multicast_ether_addr(mac))
+		flow_mgt->multi_mac_cnt++;
+	else
+		flow_mgt->unicast_mac_cnt++;
+
+	return 0;
+}
+
+static void nbl_serv_update_mcast_submac(struct nbl_service_mgt *serv_mgt,
+					 bool multi_effective,
+					 bool unicast_effective, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node;
+
+	list_for_each_entry(submac_node,
+			    &flow_mgt->submac_list[NBL_SUBMAC_MULTI], node)
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node,
+						      multi_effective, vsi);
+
+	list_for_each_entry(submac_node,
+			    &flow_mgt->submac_list[NBL_SUBMAC_UNICAST], node)
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node,
+						      unicast_effective, vsi);
+}
+
+static void nbl_serv_update_promisc_vlan(struct nbl_service_mgt *serv_mgt,
+					 bool effective, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node)
+		nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node,
+						    effective, vsi);
+}
+
+static void nbl_serv_del_all_vlans(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node, *vlan_node_safe;
+
+	list_for_each_entry_safe(vlan_node, vlan_node_safe,
+				 &flow_mgt->vlan_list, node) {
+		if (vlan_node->primary_mac_effective)
+			disp_ops->del_macvlan(p, flow_mgt->mac,
+					      vlan_node->vid,
+					      NBL_COMMON_TO_VSI_ID(common));
+
+		list_del(&vlan_node->node);
+		nbl_serv_free_vlan_node(vlan_node);
+	}
+}
+
+static void nbl_serv_del_all_submacs(struct nbl_service_mgt *serv_mgt, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node, *submac_node_safe;
+	int i;
+
+	for (i = 0; i < NBL_SUBMAC_MAX; i++)
+		list_for_each_entry_safe(submac_node, submac_node_safe,
+					 &flow_mgt->submac_list[i], node) {
+			nbl_serv_update_submac_node_effective(serv_mgt,
+							      submac_node,
+							      0, vsi);
+			list_del(&submac_node->node);
+			flow_mgt->submac_list_cnt--;
+			if (is_multicast_ether_addr(submac_node->mac))
+				flow_mgt->multi_mac_cnt--;
+			else
+				flow_mgt->unicast_mac_cnt--;
+			nbl_serv_free_submac_node(submac_node);
+		}
+}
+
+void nbl_serv_cpu_affinity_init(void *priv, u16 rings_num)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	int i;
+
+	for (i = 0; i < rings_num; i++) {
+		cpumask_set_cpu(cpumask_local_spread(i, dev->numa_node),
+				&ring_mgt->vectors[i].cpumask);
+		netif_set_xps_queue(ring_mgt->vectors[i].netdev,
+				    &ring_mgt->vectors[i].cpumask, i);
+	}
+}
+
+static int nbl_serv_ipv6_exthdr_num(struct sk_buff *skb, int start, u8 nexthdr)
+{
+	struct ipv6_opt_hdr _hdr, *hp;
+	int exthdr_num = 0;
+	unsigned int hdrlen;
+
+	while (ipv6_ext_hdr(nexthdr)) {
+		if (nexthdr == NEXTHDR_NONE)
+			return -1;
+
+		hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
+		if (!hp)
+			return -1;
+
+		exthdr_num++;
+
+		if (nexthdr == NEXTHDR_FRAGMENT)
+			hdrlen = 8;
+		else if (nexthdr == NEXTHDR_AUTH)
+			hdrlen = ipv6_authlen(hp);
+		else
+			hdrlen = ipv6_optlen(hp);
+
+		nexthdr = hp->nexthdr;
+		start += hdrlen;
+	}
+
+	return exthdr_num;
+}
+
 static void nbl_serv_set_sfp_state(void *priv, struct net_device *netdev,
 				   u8 eth_id, bool open, bool is_force)
 {
@@ -470,6 +843,24 @@ int nbl_serv_vsi_stop(void *priv, u16 vsi_index)
 	return 0;
 }
 
+static struct nbl_mac_filter *nbl_add_filter(struct list_head *head,
+					     const u8 *macaddr)
+{
+	struct nbl_mac_filter *f;
+
+	if (!macaddr)
+		return NULL;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return f;
+
+	ether_addr_copy(f->macaddr, macaddr);
+	list_add_tail(&f->list, head);
+
+	return f;
+}
+
 static int nbl_serv_abnormal_event_to_queue(int event_type)
 {
 	switch (event_type) {
@@ -482,6 +873,16 @@ static int nbl_serv_abnormal_event_to_queue(int event_type)
 	}
 }
 
+static int nbl_serv_stop_abnormal_sw_queue(struct nbl_service_mgt *serv_mgt,
+					   u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+
+	return disp_ops->stop_abnormal_sw_queue(p,
+						local_queue_id, type);
+}
+
 static int
 nbl_serv_chan_stop_abnormal_sw_queue_req(struct nbl_service_mgt *serv_mgt,
 					 u16 local_queue_id, u16 func_id,
@@ -503,6 +904,58 @@ nbl_serv_chan_stop_abnormal_sw_queue_req(struct nbl_service_mgt *serv_mgt,
 	return ret;
 }
 
+static void nbl_serv_chan_stop_abnormal_sw_queue_resp(void *priv, u16 src_id,
+						      u16 msg_id, void *data,
+						      u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_stop_abnormal_sw_queue *param =
+		(struct nbl_chan_param_stop_abnormal_sw_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = 0;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >=
+		    vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	ret = nbl_serv_stop_abnormal_sw_queue(serv_mgt, param->local_queue_id,
+					      param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+		     msg_id, ret, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
+static dma_addr_t
+nbl_serv_netdev_queue_restore(struct nbl_service_mgt *serv_mgt,
+			      u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+
+	return disp_ops->restore_abnormal_ring(p,
+					       local_queue_id, type);
+}
+
+static int nbl_serv_netdev_queue_restart(struct nbl_service_mgt *serv_mgt,
+					 u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+
+	return disp_ops->restart_abnormal_ring(p,
+					       local_queue_id, type);
+}
+
 static dma_addr_t
 nbl_serv_chan_restore_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 				       u16 local_queue_id, u16 func_id,
@@ -527,6 +980,38 @@ nbl_serv_chan_restore_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 	return dma;
 }
 
+static void nbl_serv_chan_restore_netdev_queue_resp(void *priv, u16 src_id,
+						    u16 msg_id, void *data,
+						    u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restore_queue *param =
+		(struct nbl_chan_param_restore_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	dma_addr_t dma = 0;
+	int ret = NBL_CHAN_RESP_OK;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >=
+		    vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	dma = nbl_serv_netdev_queue_restore(serv_mgt, param->local_queue_id,
+					    param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+		     msg_id, ret, &dma, sizeof(dma));
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
 static int
 nbl_serv_chan_restart_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 				       u16 local_queue_id, u16 func_id,
@@ -545,6 +1030,38 @@ nbl_serv_chan_restart_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 				  &chan_send);
 }
 
+static void nbl_serv_chan_restart_netdev_queue_resp(void *priv, u16 src_id,
+						    u16 msg_id, void *data,
+						    u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restart_queue *param =
+		(struct nbl_chan_param_restart_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt =
+		NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = 0;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >=
+		    vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	ret = nbl_serv_netdev_queue_restart(serv_mgt, param->local_queue_id,
+					    param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+		     msg_id, ret, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
 static int nbl_serv_start_abnormal_hw_queue(struct nbl_service_mgt *serv_mgt,
 					    u16 vsi_id, u16 local_queue_id,
 					    dma_addr_t dma, int type)
@@ -636,19 +1153,88 @@ static void nbl_serv_restore_queue(struct nbl_service_mgt *serv_mgt, u16 vsi_id,
 	rtnl_unlock();
 }
 
-int nbl_serv_netdev_open(struct net_device *netdev)
+static void nbl_serv_handle_tx_timeout(struct work_struct *work)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt,
+			     tx_timeout);
+	struct nbl_service_mgt *serv_mgt = serv_net_resource_mgt->serv_mgt;
 	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
-	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
 	struct nbl_serv_ring_vsi_info *vsi_info;
-	int num_cpus, real_qps, ret = 0;
+	int i = 0;
 
-	if (!test_bit(NBL_DOWN, adapter->state))
-		return -EBUSY;
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
 
-	netdev_dbg(netdev, "Nbl open\n");
+	for (i = vsi_info->ring_offset;
+	     i < vsi_info->ring_offset + vsi_info->ring_num; i++) {
+		if (ring_mgt->tx_rings[i].need_recovery) {
+			nbl_serv_restore_queue(serv_mgt, vsi_info->vsi_id, i,
+					       NBL_TX, false);
+			ring_mgt->tx_rings[i].need_recovery = false;
+		}
+	}
+}
+
+static void nbl_serv_update_link_state(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt,
+			     update_link_state);
+	struct nbl_service_mgt *serv_mgt = serv_net_resource_mgt->serv_mgt;
+
+	nbl_serv_set_link_state(serv_mgt, serv_net_resource_mgt->netdev);
+}
+
+static void nbl_serv_update_vlan(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt,
+			     update_vlan);
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct net_device *netdev = net_resource_mgt->netdev;
+	int was_running, err;
+	u16 vid;
+
+	vid = net_resource_mgt->vlan_tci & VLAN_VID_MASK;
+	nbl_serv_update_default_vlan(serv_mgt, vid);
+
+	rtnl_lock();
+	was_running = netif_running(netdev);
+
+	if (was_running) {
+		err = nbl_serv_netdev_stop(netdev);
+		if (err) {
+			netdev_err(netdev,
+				   "Netdev stop failed while update_vlan\n");
+			goto netdev_stop_fail;
+		}
+
+		err = nbl_serv_netdev_open(netdev);
+		if (err) {
+			netdev_err(netdev,
+				   "Netdev open failed after update_vlan\n");
+			goto netdev_open_fail;
+		}
+	}
+
+netdev_stop_fail:
+netdev_open_fail:
+	rtnl_unlock();
+}
+
+int nbl_serv_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	int num_cpus, real_qps, ret = 0;
+
+	if (!test_bit(NBL_DOWN, adapter->state))
+		return -EBUSY;
+
+	netdev_dbg(netdev, "Nbl open\n");
 
 	netif_carrier_off(netdev);
 	nbl_serv_set_sfp_state(serv_mgt, netdev, NBL_COMMON_TO_ETH_ID(common),
@@ -715,6 +1301,104 @@ int nbl_serv_netdev_stop(struct net_device *netdev)
 	return 0;
 }
 
+static int nbl_serv_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int was_running = 0, err = 0;
+	int max_mtu;
+
+	max_mtu = disp_ops->get_max_mtu(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (new_mtu > max_mtu)
+		netdev_notice(netdev, "Netdev already bind xdp prog: new_mtu(%d) > current_max_mtu(%d), try to rebuild rx buffer\n",
+			      new_mtu, max_mtu);
+
+	if (new_mtu) {
+		netdev->mtu = new_mtu;
+		was_running = netif_running(netdev);
+		if (was_running) {
+			err = nbl_serv_netdev_stop(netdev);
+			if (err) {
+				netdev_err(netdev, "Netdev stop failed while change mtu\n");
+				return err;
+			}
+
+			err = nbl_serv_netdev_open(netdev);
+			if (err) {
+				netdev_err(netdev, "Netdev open failed after change mtu\n");
+				return err;
+			}
+		}
+	}
+
+	disp_ops->set_mtu(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			  NBL_COMMON_TO_VSI_ID(common), new_mtu);
+
+	return 0;
+}
+
+static int nbl_serv_set_mac(struct net_device *dev, void *p)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+	struct sockaddr *addr = p;
+	struct nbl_netdev_priv *priv = netdev_priv(dev);
+	int ret = 0;
+
+	if (!is_valid_ether_addr(addr->sa_data)) {
+		netdev_err(dev, "Temp to change a invalid mac address %pM\n",
+			   addr->sa_data);
+		return -EADDRNOTAVAIL;
+	}
+
+	if (ether_addr_equal(flow_mgt->mac, addr->sa_data))
+		return 0;
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (!vlan_node->primary_mac_effective)
+			continue;
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      flow_mgt->mac, vlan_node->vid,
+				      priv->data_vsi);
+		ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    addr->sa_data, vlan_node->vid,
+					    priv->data_vsi);
+		if (ret) {
+			netdev_err(dev, "Fail to cfg macvlan on vid %u",
+				   vlan_node->vid);
+			goto fail;
+		}
+	}
+
+	ether_addr_copy(flow_mgt->mac, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
+
+	if (!NBL_COMMON_TO_VF_CAP(common))
+		disp_ops->set_eth_mac_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   addr->sa_data,
+					   NBL_COMMON_TO_ETH_ID(common));
+
+	return 0;
+fail:
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		if (!vlan_node->primary_mac_effective)
+			continue;
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      addr->sa_data, vlan_node->vid,
+				      priv->data_vsi);
+		disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      flow_mgt->mac, vlan_node->vid,
+				      priv->data_vsi);
+	}
+	return -EAGAIN;
+}
+
 static int nbl_serv_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 {
 	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
@@ -813,6 +1497,82 @@ static int nbl_serv_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	return 0;
 }
 
+static int nbl_serv_update_default_vlan(struct nbl_service_mgt *serv_mgt,
+					u16 vid)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node = NULL;
+	struct nbl_serv_vlan_node *node, *tmp;
+	struct nbl_common_info *common;
+	bool other_effective = false;
+	int ret;
+	u16 vsi;
+
+	if (flow_mgt->vid == vid)
+		return 0;
+
+	common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	vsi = NBL_COMMON_TO_VSI_ID(common);
+	rtnl_lock();
+
+	list_for_each_entry(node, &flow_mgt->vlan_list, node) {
+		if (node->vid == vid) {
+			node->ref_cnt++;
+			vlan_node = node;
+			break;
+		}
+	}
+
+	if (!vlan_node)
+		vlan_node = nbl_serv_alloc_vlan_node();
+
+	if (!vlan_node) {
+		rtnl_unlock();
+		return -ENOMEM;
+	}
+
+	vlan_node->vid = vid;
+	/* restore to default vlan id 0, we need restore other vlan interface */
+	if (!vid)
+		other_effective = true;
+	list_for_each_entry_safe(node, tmp, &flow_mgt->vlan_list, node) {
+		if (node->vid == flow_mgt->vid && node != vlan_node) {
+			node->ref_cnt--;
+			if (!node->ref_cnt) {
+				nbl_serv_update_vlan_node_effective(serv_mgt,
+								    node,
+								    0, vsi);
+				list_del(&node->node);
+				nbl_serv_free_vlan_node(node);
+			}
+		} else if (node->vid != vid) {
+			nbl_serv_update_vlan_node_effective(serv_mgt, node,
+							    other_effective,
+							    vsi);
+		}
+	}
+
+	ret = nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, 1, vsi);
+	if (ret)
+		goto free_vlan_node;
+
+	if (vlan_node->ref_cnt == 1)
+		list_add(&vlan_node->node, &flow_mgt->vlan_list);
+
+	flow_mgt->vid = vid;
+	rtnl_unlock();
+
+	return 0;
+
+free_vlan_node:
+	vlan_node->ref_cnt--;
+	if (!vlan_node->ref_cnt)
+		nbl_serv_free_vlan_node(vlan_node);
+	rtnl_unlock();
+
+	return ret;
+}
+
 static void nbl_serv_get_stats64(struct net_device *netdev,
 				 struct rtnl_link_stats64 *stats)
 {
@@ -844,6 +1604,406 @@ static void nbl_serv_get_stats64(struct net_device *netdev,
 	stats->tx_dropped = 0;
 }
 
+static int nbl_addr_unsync(struct net_device *netdev, const u8 *addr)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_adapter *adapter;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
+	if (!nbl_add_filter(&net_resource_mgt->tmp_del_filter_list, addr))
+		return -ENOMEM;
+
+	net_resource_mgt->update_submac = 1;
+	return 0;
+}
+
+static int nbl_addr_sync(struct net_device *netdev, const u8 *addr)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_adapter *adapter;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	if (ether_addr_equal(addr, netdev->dev_addr))
+		return 0;
+
+	if (!nbl_add_filter(&net_resource_mgt->tmp_add_filter_list, addr))
+		return -ENOMEM;
+
+	net_resource_mgt->update_submac = 1;
+	return 0;
+}
+
+static void
+nbl_modify_submacs(struct nbl_serv_net_resource_mgt *net_resource_mgt)
+{
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct net_device *netdev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_mac_filter *filter, *safe_filter;
+
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_add_filter_list);
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_del_filter_list);
+	net_resource_mgt->update_submac = 0;
+
+	netif_addr_lock_bh(netdev);
+	__dev_uc_sync(net_resource_mgt->netdev, nbl_addr_sync, nbl_addr_unsync);
+	__dev_mc_sync(net_resource_mgt->netdev, nbl_addr_sync, nbl_addr_unsync);
+	netif_addr_unlock_bh(netdev);
+
+	if (!net_resource_mgt->update_submac)
+		return;
+
+	rtnl_lock();
+	list_for_each_entry_safe(filter, safe_filter,
+				 &net_resource_mgt->tmp_del_filter_list, list) {
+		nbl_serv_del_submac_node(serv_mgt, filter->macaddr,
+					 priv->data_vsi);
+		list_del(&filter->list);
+		kfree(filter);
+	}
+
+	list_for_each_entry_safe(filter, safe_filter,
+				 &net_resource_mgt->tmp_add_filter_list, list) {
+		nbl_serv_add_submac_node(serv_mgt, filter->macaddr,
+					 priv->data_vsi, flow_mgt->promisc);
+		list_del(&filter->list);
+		kfree(filter);
+	}
+
+	nbl_serv_check_flow_table_spec(serv_mgt);
+	rtnl_unlock();
+}
+
+static void
+nbl_modify_promisc_mode(struct nbl_serv_net_resource_mgt *net_resource_mgt)
+{
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct net_device *netdev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	bool mode = 0, multi = 0;
+	bool need_flow = 1;
+	bool unicast_enable, multicast_enable;
+
+	rtnl_lock();
+	net_resource_mgt->curr_promiscuout_mode = netdev->flags;
+
+	if (((netdev->flags & (IFF_PROMISC)) || flow_mgt->force_promisc) &&
+	    !NBL_COMMON_TO_VF_CAP(NBL_SERV_MGT_TO_COMMON(serv_mgt)))
+		mode = 1;
+
+	if ((netdev->flags & (IFF_PROMISC | IFF_ALLMULTI)) ||
+	    flow_mgt->force_promisc)
+		multi = 1;
+
+	if (!flow_mgt->trusted_en)
+		multi = 0;
+
+	unicast_enable = !mode && need_flow;
+	multicast_enable = !multi && need_flow;
+
+	if ((flow_mgt->promisc & BIT(NBL_PROMISC)) ^ (mode << NBL_PROMISC))
+		if (!NBL_COMMON_TO_VF_CAP(NBL_SERV_MGT_TO_COMMON(serv_mgt))) {
+			disp_ops->set_promisc_mode(p,
+						   priv->data_vsi, mode);
+			if (mode)
+				flow_mgt->promisc |= BIT(NBL_PROMISC);
+			else
+				flow_mgt->promisc &= ~BIT(NBL_PROMISC);
+		}
+
+	if ((flow_mgt->promisc & BIT(NBL_ALLMULTI)) ^ (multi << NBL_ALLMULTI)) {
+		disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  priv->data_vsi, multi);
+		if (multi)
+			flow_mgt->promisc |= BIT(NBL_ALLMULTI);
+		else
+			flow_mgt->promisc &= ~BIT(NBL_ALLMULTI);
+	}
+
+	if (flow_mgt->mcast_flow_en ^ multicast_enable) {
+		nbl_serv_update_mcast_submac(serv_mgt, multicast_enable,
+					     unicast_enable, priv->data_vsi);
+		flow_mgt->mcast_flow_en = multicast_enable;
+	}
+
+	if (flow_mgt->ucast_flow_en ^ unicast_enable) {
+		nbl_serv_update_promisc_vlan(serv_mgt, unicast_enable,
+					     priv->data_vsi);
+		flow_mgt->ucast_flow_en = unicast_enable;
+	}
+
+	if (flow_mgt->trusted_update) {
+		flow_mgt->trusted_update = 0;
+		if (flow_mgt->active_submac_list < flow_mgt->submac_list_cnt)
+			nbl_serv_update_mcast_submac(serv_mgt,
+						     flow_mgt->mcast_flow_en,
+						     flow_mgt->ucast_flow_en,
+						     priv->data_vsi);
+	}
+	rtnl_unlock();
+}
+
+static void nbl_serv_set_rx_mode(struct net_device *dev)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_adapter *adapter;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+}
+
+static void nbl_serv_change_rx_flags(struct net_device *dev, int flag)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_adapter *adapter;
+
+	adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+}
+
+static netdev_features_t nbl_serv_features_check(struct sk_buff *skb,
+						 struct net_device *dev,
+						 netdev_features_t features)
+{
+	u32 l2_l3_hrd_len = 0, l4_hrd_len = 0, total_hrd_len = 0;
+	u8 l4_proto = 0;
+	__be16 protocol, frag_off;
+	unsigned char *exthdr;
+	unsigned int offset = 0;
+	int nexthdr = 0;
+	int exthdr_num = 0;
+	int ret;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		unsigned char *hdr;
+	} l4;
+
+	/* No point in doing any of this if neither checksum nor GSO are
+	 * being requested for this frame. We can rule out both by just
+	 * checking for CHECKSUM_PARTIAL.
+	 */
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return features;
+
+	/* We cannot support GSO if the MSS is going to be less than
+	 * 256 bytes or bigger than 16383 bytes. If it is then we need
+	 *to drop support for GSO.
+	 */
+	if (skb_is_gso(skb) &&
+	    (skb_shinfo(skb)->gso_size < NBL_TX_TSO_MSS_MIN ||
+	     skb_shinfo(skb)->gso_size > NBL_TX_TSO_MSS_MAX))
+		features &= ~NETIF_F_GSO_MASK;
+
+	l2_l3_hrd_len = (u32)(skb_transport_header(skb) - skb->data);
+
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
+	protocol = vlan_get_protocol(skb);
+
+	if (protocol == htons(ETH_P_IP)) {
+		l4_proto = ip.v4->protocol;
+	} else if (protocol == htons(ETH_P_IPV6)) {
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+		if (l4.hdr != exthdr) {
+			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
+					       &l4_proto, &frag_off);
+			if (ret < 0)
+				goto out_rm_features;
+		}
+
+		/* IPV6 extension headers
+		 * (1) donot support routing and destination extension headers
+		 * (2) support 2 extension headers mostly
+		 */
+		nexthdr = ipv6_find_hdr(skb, &offset, NEXTHDR_ROUTING, NULL,
+					NULL);
+		if (nexthdr == NEXTHDR_ROUTING) {
+			netdev_info(dev,
+				    "skb contain ipv6 routing ext header\n");
+			goto out_rm_features;
+		}
+
+		nexthdr = ipv6_find_hdr(skb, &offset, NEXTHDR_DEST, NULL, NULL);
+		if (nexthdr == NEXTHDR_DEST) {
+			netdev_info(dev,
+				    "skb contain ipv6 routing dest header\n");
+			goto out_rm_features;
+		}
+
+		exthdr_num = nbl_serv_ipv6_exthdr_num(skb, exthdr - skb->data,
+						      ip.v6->nexthdr);
+		if (exthdr_num < 0 || exthdr_num > 2) {
+			netdev_info(dev, "skb ipv6 exthdr_num:%d\n",
+				    exthdr_num);
+			goto out_rm_features;
+		}
+	} else {
+		goto out_rm_features;
+	}
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		l4_hrd_len = (l4.tcp->doff) * 4;
+		break;
+	case IPPROTO_UDP:
+		l4_hrd_len = sizeof(struct udphdr);
+		break;
+	case IPPROTO_SCTP:
+		l4_hrd_len = sizeof(struct sctphdr);
+		break;
+	default:
+		goto out_rm_features;
+	}
+
+	total_hrd_len = l2_l3_hrd_len + l4_hrd_len;
+
+	// TX checksum offload support total header len is [0, 255]
+	if (total_hrd_len > NBL_TX_CHECKSUM_OFFLOAD_L2L3L4_HDR_LEN_MAX)
+		goto out_rm_features;
+
+	// TSO support total header len is [42, 128]
+	if (total_hrd_len < NBL_TX_TSO_L2L3L4_HDR_LEN_MIN ||
+	    total_hrd_len > NBL_TX_TSO_L2L3L4_HDR_LEN_MAX)
+		features &= ~NETIF_F_GSO_MASK;
+
+	if (skb->encapsulation)
+		goto out_rm_features;
+
+	return features;
+
+out_rm_features:
+	return features & ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
+			    NETIF_F_SCTP_CRC | NETIF_F_GSO_MASK);
+}
+
+static int nbl_serv_config_rxhash(void *priv, bool enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt =
+		NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[NBL_VSI_DATA];
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	u32 rxfh_indir_size = 0;
+	u32 *indir = NULL;
+	int i = 0;
+
+	disp_ops->get_rxfh_indir_size(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      NBL_COMMON_TO_VSI_ID(common),
+				      &rxfh_indir_size);
+	indir = devm_kcalloc(dev, rxfh_indir_size, sizeof(u32), GFP_KERNEL);
+	if (!indir)
+		return -ENOMEM;
+	if (enable) {
+		if (ring_mgt->rss_indir_user) {
+			memcpy(indir, ring_mgt->rss_indir_user,
+			       rxfh_indir_size * sizeof(u32));
+		} else {
+			for (i = 0; i < rxfh_indir_size; i++)
+				indir[i] = i % vsi_info->active_ring_num;
+		}
+	}
+	disp_ops->set_rxfh_indir(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				 NBL_COMMON_TO_VSI_ID(common), indir,
+				 rxfh_indir_size);
+	devm_kfree(dev, indir);
+	return 0;
+}
+
+static int nbl_serv_set_features(struct net_device *netdev,
+				 netdev_features_t features)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	netdev_features_t changed = netdev->features ^ features;
+	bool enable = false;
+
+	if (changed & NETIF_F_RXHASH) {
+		enable = !!(features & NETIF_F_RXHASH);
+		nbl_serv_config_rxhash(serv_mgt, enable);
+	}
+
+	return 0;
+}
+
+static u16
+nbl_serv_select_queue(struct net_device *netdev, struct sk_buff *skb,
+		      struct net_device *sb_dev)
+{
+	return netdev_pick_tx(netdev, skb, sb_dev);
+}
+
+static void nbl_serv_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_adapter *adapter = NBL_NETDEV_PRIV_TO_ADAPTER(priv);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAP_TO_SERV_MGT(adapter);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+
+	ring_mgt->tx_rings[vsi_info->ring_offset + txqueue].need_recovery =
+		true;
+	ring_mgt->tx_rings[vsi_info->ring_offset + txqueue].tx_timeout_count++;
+
+	netif_warn(common, drv, netdev, "TX timeout on queue %d", txqueue);
+
+	nbl_common_queue_work(&net_resource_mgt->tx_timeout, false);
+}
+
+static int nbl_serv_get_phys_port_name(struct net_device *dev, char *name,
+				       size_t len)
+{
+	struct nbl_common_info *common = NBL_NETDEV_TO_COMMON(dev);
+	u8 pf_id;
+
+	pf_id = common->eth_id;
+	if ((NBL_COMMON_TO_ETH_MODE(common) == NBL_TWO_ETHERNET_PORT) &&
+	    common->eth_id == 2)
+		pf_id = 1;
+
+	if (snprintf(name, len, "p%u", pf_id) >= len)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static int
 nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
 		      struct nbl_register_net_result *register_result)
@@ -864,6 +2024,361 @@ static int nbl_serv_unregister_net(void *priv)
 	return disp_ops->unregister_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
 }
 
+static int nbl_serv_setup_txrx_queues(void *priv, u16 vsi_id, u16 queue_num,
+				      u16 net_vector_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_vector *vec;
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	int i, ret = 0;
+
+	/* queue_num include user&kernel queue */
+	ret = disp_ops->alloc_txrx_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  vsi_id, queue_num);
+	if (ret)
+		return -EFAULT;
+
+	/* ring_mgt->tx_ring_number only for kernel use */
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		ring_mgt->tx_rings[i].local_queue_id = NBL_PAIR_ID_GET_TX(i);
+		ring_mgt->rx_rings[i].local_queue_id = NBL_PAIR_ID_GET_RX(i);
+	}
+
+	for (i = 0; i < ring_mgt->rx_ring_num; i++) {
+		vec = &ring_mgt->vectors[i];
+		vec->local_vec_id = i + net_vector_id;
+		vec->global_vec_id =
+			disp_ops->get_global_vector(p,
+						    vsi_id,
+						    vec->local_vec_id);
+		vec->irq_enable_base = (u8 __iomem *)
+			disp_ops->get_msix_irq_enable_info(p,
+							   vec->global_vec_id,
+							   &vec->irq_data);
+
+		disp_ops->set_vector_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  vec->irq_enable_base,
+					  vec->irq_data, i,
+					  ring_mgt->net_msix_mask_en);
+	}
+
+	return 0;
+}
+
+static void nbl_serv_remove_txrx_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->free_txrx_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static int nbl_serv_init_tx_rate(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	u16 func_id;
+	int ret = 0;
+
+	if (net_resource_mgt->max_tx_rate) {
+		func_id = disp_ops->get_function_id(p, vsi_id);
+		ret = disp_ops->set_tx_rate(p, func_id,
+					    net_resource_mgt->max_tx_rate,
+					    0);
+	}
+
+	return ret;
+}
+
+static int nbl_serv_setup_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->setup_q2vsi(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     vsi_id);
+}
+
+static void nbl_serv_remove_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->remove_q2vsi(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static int nbl_serv_setup_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->setup_rss(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static void nbl_serv_remove_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->remove_rss(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static int nbl_serv_setup_rss_indir(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[NBL_VSI_DATA];
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	u32 rxfh_indir_size = 0;
+	int num_cpus = 0, real_qps = 0;
+	u32 *indir = NULL;
+	int i = 0;
+
+	disp_ops->get_rxfh_indir_size(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      vsi_id, &rxfh_indir_size);
+	indir = devm_kcalloc(dev, rxfh_indir_size, sizeof(u32), GFP_KERNEL);
+	if (!indir)
+		return -ENOMEM;
+
+	num_cpus = num_online_cpus();
+	real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num :
+						   num_cpus;
+
+	for (i = 0; i < rxfh_indir_size; i++)
+		indir[i] = i % real_qps;
+
+	disp_ops->set_rxfh_indir(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				 indir, rxfh_indir_size);
+	devm_kfree(dev, indir);
+	return 0;
+}
+
+static int nbl_serv_alloc_rings(void *priv, struct net_device *netdev,
+				struct nbl_ring_param *param)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt;
+	struct nbl_dispatch_ops *disp_ops;
+	struct device *dev;
+	int ret = 0;
+
+	dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ring_mgt->tx_ring_num = param->tx_ring_num;
+	ring_mgt->rx_ring_num = param->rx_ring_num;
+	ring_mgt->tx_desc_num = param->queue_size;
+	ring_mgt->rx_desc_num = param->queue_size;
+
+	ret = disp_ops->alloc_rings(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), netdev,
+				    param);
+	if (ret)
+		goto alloc_rings_fail;
+
+	ret = nbl_serv_set_tx_rings(ring_mgt, netdev, dev);
+	if (ret)
+		goto set_tx_fail;
+	ret = nbl_serv_set_rx_rings(ring_mgt, netdev, dev);
+	if (ret)
+		goto set_rx_fail;
+
+	ret = nbl_serv_set_vectors(serv_mgt, netdev, dev);
+	if (ret)
+		goto set_vectors_fail;
+
+	return 0;
+
+set_vectors_fail:
+	nbl_serv_remove_rx_ring(ring_mgt, dev);
+set_rx_fail:
+	nbl_serv_remove_tx_ring(ring_mgt, dev);
+set_tx_fail:
+	disp_ops->remove_rings(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+alloc_rings_fail:
+	return ret;
+}
+
+static void nbl_serv_free_rings(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt;
+	struct nbl_dispatch_ops *disp_ops;
+	struct device *dev;
+
+	dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	nbl_serv_remove_vectors(ring_mgt, dev);
+	nbl_serv_remove_rx_ring(ring_mgt, dev);
+	nbl_serv_remove_tx_ring(ring_mgt, dev);
+
+	disp_ops->remove_rings(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_enable_napis(void *priv, u16 vsi_index)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[vsi_index];
+	u16 start = vsi_info->ring_offset,
+	    end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i;
+
+	for (i = start; i < end; i++)
+		napi_enable(&ring_mgt->vectors[i].nbl_napi->napi);
+
+	return 0;
+}
+
+static void nbl_serv_disable_napis(void *priv, u16 vsi_index)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[vsi_index];
+	u16 start = vsi_info->ring_offset,
+	    end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i;
+
+	for (i = start; i < end; i++)
+		napi_disable(&ring_mgt->vectors[i].nbl_napi->napi);
+}
+
+static void nbl_serv_set_mask_en(void *priv, bool enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt;
+
+	ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+
+	ring_mgt->net_msix_mask_en = enable;
+}
+
+static int nbl_serv_start_net_flow(void *priv, struct net_device *netdev,
+				   u16 vsi_id, u16 vid, bool trusted)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+	u8 mac[ETH_ALEN];
+	int ret = 0;
+
+	flow_mgt->ucast_flow_en = true;
+	flow_mgt->mcast_flow_en = true;
+	/* Clear cfgs, in case this function exited abnormaly last time */
+	disp_ops->clear_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+	disp_ops->set_mtu(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			  NBL_COMMON_TO_VSI_ID(common), netdev->mtu);
+
+	if (!list_empty(&flow_mgt->vlan_list))
+		return -ECONNRESET;
+
+	vlan_node = nbl_serv_alloc_vlan_node();
+	if (!vlan_node)
+		goto alloc_fail;
+
+	flow_mgt->vid = vid;
+	flow_mgt->trusted_en = trusted;
+	vlan_node->vid = vid;
+	ether_addr_copy(flow_mgt->mac, netdev->dev_addr);
+	ret = nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, 1,
+						  vsi_id);
+	if (ret)
+		goto add_macvlan_fail;
+
+	list_add(&vlan_node->node, &flow_mgt->vlan_list);
+	flow_mgt->vlan_list_cnt++;
+
+	memset(mac, 0xFF, ETH_ALEN);
+	ret = nbl_serv_add_submac_node(serv_mgt, mac, vsi_id, 0);
+	if (ret)
+		goto add_submac_failed;
+
+	return 0;
+
+add_submac_failed:
+	nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, 0, vsi_id);
+add_macvlan_fail:
+	nbl_serv_free_vlan_node(vlan_node);
+alloc_fail:
+	return ret;
+}
+
+static void nbl_serv_stop_net_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt =
+		NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(dev);
+
+	nbl_serv_del_all_submacs(serv_mgt, net_priv->data_vsi);
+	nbl_serv_del_all_vlans(serv_mgt);
+
+	disp_ops->del_multi_rule(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+	memset(flow_mgt->mac, 0, sizeof(flow_mgt->mac));
+}
+
+static void nbl_serv_clear_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->clear_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static int nbl_serv_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  vsi_id, mode);
+}
+
+static int nbl_serv_cfg_multi_mcast(void *priv, u16 vsi_id, u16 enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					 vsi_id, enable);
+}
+
+static int nbl_serv_set_lldp_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->add_lldp_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				       vsi_id);
+}
+
+static void nbl_serv_remove_lldp_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->del_lldp_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
 static int nbl_serv_start_mgt_flow(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -956,6 +2471,176 @@ static int nbl_serv_destroy_chip(void *p)
 	return 0;
 }
 
+static int nbl_serv_configure_msix_map(void *priv, u16 num_net_msix,
+				       u16 num_others_msix,
+				       bool net_msix_mask_en)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->configure_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   num_net_msix, num_others_msix,
+					   net_msix_mask_en);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int nbl_serv_destroy_msix_map(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->destroy_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int nbl_serv_enable_mailbox_irq(void *priv, u16 vector_id,
+				       bool enable_msix)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->enable_mailbox_irq(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   vector_id, enable_msix);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int nbl_serv_enable_abnormal_irq(void *priv, u16 vector_id,
+					bool enable_msix)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->enable_abnormal_irq(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    vector_id, enable_msix);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static irqreturn_t nbl_serv_clean_rings(int __always_unused irq, void *data)
+{
+	struct nbl_serv_vector *vector = (struct nbl_serv_vector *)data;
+
+	napi_schedule_irqoff(&vector->nbl_napi->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int nbl_serv_request_net_irq(void *priv,
+				    struct nbl_msix_info_param *msix_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_ring *tx_ring, *rx_ring;
+	struct nbl_serv_vector *vector;
+	u32 irq_num;
+	int i, ret = 0;
+
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		tx_ring = &ring_mgt->tx_rings[i];
+		rx_ring = &ring_mgt->rx_rings[i];
+		vector = &ring_mgt->vectors[i];
+		vector->tx_ring = tx_ring;
+		vector->rx_ring = rx_ring;
+
+		irq_num = msix_info->msix_entries[i].vector;
+		snprintf(vector->name, sizeof(vector->name),
+			 "nbl_txrx%d@pci:%s", i,
+			 pci_name(NBL_COMMON_TO_PDEV(common)));
+		ret = devm_request_irq(dev, irq_num, nbl_serv_clean_rings, 0,
+				       vector->name, vector);
+		if (ret) {
+			nbl_err(common, "TxRx Queue %u req irq with error %d",
+				i, ret);
+			goto request_irq_err;
+		}
+		if (!cpumask_empty(&vector->cpumask))
+			irq_set_affinity_hint(irq_num, &vector->cpumask);
+	}
+
+	net_resource_mgt->num_net_msix = msix_info->msix_num;
+
+	return 0;
+
+request_irq_err:
+	while (--i + 1) {
+		vector = &ring_mgt->vectors[i];
+
+		irq_num = msix_info->msix_entries[i].vector;
+		irq_set_affinity_hint(irq_num, NULL);
+		devm_free_irq(dev, irq_num, vector);
+	}
+	return ret;
+}
+
+static void nbl_serv_free_net_irq(void *priv,
+				  struct nbl_msix_info_param *msix_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_vector *vector;
+	u32 irq_num;
+	int i;
+
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		vector = &ring_mgt->vectors[i];
+
+		irq_num = msix_info->msix_entries[i].vector;
+		irq_set_affinity_hint(irq_num, NULL);
+		devm_free_irq(dev, irq_num, vector);
+	}
+}
+
+static u16 nbl_serv_get_global_vector(void *priv, u16 local_vec_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_global_vector(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_COMMON_TO_VSI_ID(common),
+					   local_vec_id);
+}
+
+static u16 nbl_serv_get_msix_entry_id(void *priv, u16 local_vec_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_msix_entry_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_COMMON_TO_VSI_ID(common),
+					   local_vec_id);
+}
+
 static u16 nbl_serv_get_vsi_id(void *priv, u16 func_id, u16 type)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -1000,6 +2685,31 @@ static void nbl_serv_set_netdev_ops(void *priv,
 			(void *)net_device_ops;
 }
 
+static void nbl_serv_rx_mode_async_task(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt,
+			     rx_mode_async);
+
+	nbl_modify_submacs(serv_net_resource_mgt);
+	nbl_modify_promisc_mode(serv_net_resource_mgt);
+}
+
+static void nbl_serv_net_task_service_timer(struct timer_list *t)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		container_of(t, struct nbl_serv_net_resource_mgt, serv_timer);
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+
+	mod_timer(&net_resource_mgt->serv_timer,
+		  round_jiffies(net_resource_mgt->serv_timer_period + jiffies));
+	if (flow_mgt->pending_async_work) {
+		nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+		flow_mgt->pending_async_work = 0;
+	}
+}
+
 static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
 {
 	int i = 0;
@@ -1009,6 +2719,212 @@ static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
 		INIT_LIST_HEAD(&flow_mgt->submac_list[i]);
 }
 
+static void
+nbl_serv_register_restore_netdev_queue(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+			       nbl_serv_chan_stop_abnormal_sw_queue_resp,
+			       serv_mgt);
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+			       nbl_serv_chan_restore_netdev_queue_resp,
+			       serv_mgt);
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+			       nbl_serv_chan_restart_netdev_queue_resp,
+			       serv_mgt);
+}
+
+static void nbl_serv_set_wake(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+
+	if (!common->is_vf && common->is_ocp)
+		disp_ops->set_wol(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), eth_id,
+				  common->wol_ena);
+}
+
+static void nbl_serv_remove_net_resource_mgt(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev;
+
+	net_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	dev = NBL_COMMON_TO_DEV(common);
+
+	if (net_mgt) {
+		nbl_serv_set_wake(serv_mgt);
+		timer_delete_sync(&net_mgt->serv_timer);
+		nbl_common_release_task(&net_mgt->rx_mode_async);
+		nbl_common_release_task(&net_mgt->tx_timeout);
+		if (common->is_vf) {
+			nbl_common_release_task(&net_mgt->update_link_state);
+			nbl_common_release_task(&net_mgt->update_vlan);
+		}
+		devm_kfree(dev, net_mgt);
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt) = NULL;
+	}
+}
+
+static int nbl_serv_hw_init(struct nbl_serv_net_resource_mgt *net_resource_mgt)
+{
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	/* disable wol when driver init */
+	if (!common->is_vf && common->is_ocp)
+		ret = disp_ops->set_wol(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					eth_id, false);
+
+	return ret;
+}
+
+static int nbl_serv_init_hw_stats(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info =
+		&ring_mgt->vsi_info[NBL_VSI_DATA];
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_ustore_stats ustore_stats = {0};
+	void *p = NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt);
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+	int ret = 0;
+
+	net_resource_mgt->hw_stats.total_uvn_stat_pkt_drop =
+		devm_kcalloc(dev, vsi_info->ring_num, sizeof(u64), GFP_KERNEL);
+	if (!net_resource_mgt->hw_stats.total_uvn_stat_pkt_drop) {
+		ret = -ENOMEM;
+		goto alloc_total_uvn_stat_pkt_drop_fail;
+	}
+
+	if (!common->is_vf) {
+		ret = disp_ops->get_ustore_total_pkt_drop_stats(p,
+								eth_id,
+								&ustore_stats);
+		if (ret)
+			goto get_ustore_total_pkt_drop_stats_fail;
+		net_resource_mgt->hw_stats.start_ustore_stats.rx_drop_packets =
+			ustore_stats.rx_drop_packets;
+		net_resource_mgt->hw_stats.start_ustore_stats.rx_trun_packets =
+			ustore_stats.rx_trun_packets;
+	}
+
+	return 0;
+
+get_ustore_total_pkt_drop_stats_fail:
+	devm_kfree(dev, net_resource_mgt->hw_stats.total_uvn_stat_pkt_drop);
+alloc_total_uvn_stat_pkt_drop_fail:
+	return ret;
+}
+
+static int nbl_serv_remove_hw_stats(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+
+	devm_kfree(dev, net_resource_mgt->hw_stats.total_uvn_stat_pkt_drop);
+	return 0;
+}
+
+static int nbl_serv_setup_net_resource_mgt(void *priv,
+					   struct net_device *netdev,
+					   u16 vlan_proto, u16 vlan_tci,
+					   u32 rate)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	unsigned long hw_stats_delay_time = 0;
+	int size = sizeof(struct nbl_serv_net_resource_mgt);
+	u32 delay_time;
+
+	net_resource_mgt = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!net_resource_mgt)
+		return -ENOMEM;
+
+	net_resource_mgt->netdev = netdev;
+	net_resource_mgt->serv_mgt = serv_mgt;
+	net_resource_mgt->vlan_proto = vlan_proto;
+	net_resource_mgt->vlan_tci = vlan_tci;
+	net_resource_mgt->max_tx_rate = rate;
+	NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt) = net_resource_mgt;
+
+	nbl_serv_hw_init(net_resource_mgt);
+	nbl_serv_register_restore_netdev_queue(serv_mgt);
+
+	net_resource_mgt->hw_stats_period = NBL_HW_STATS_PERIOD_SECONDS * HZ;
+	get_random_bytes(&delay_time, sizeof(delay_time));
+	hw_stats_delay_time = delay_time % net_resource_mgt->hw_stats_period;
+	timer_setup(&net_resource_mgt->serv_timer,
+		    nbl_serv_net_task_service_timer, 0);
+
+	net_resource_mgt->serv_timer_period = HZ;
+	nbl_common_alloc_task(&net_resource_mgt->rx_mode_async,
+			      nbl_serv_rx_mode_async_task);
+	nbl_common_alloc_task(&net_resource_mgt->tx_timeout,
+			      nbl_serv_handle_tx_timeout);
+	if (common->is_vf) {
+		nbl_common_alloc_task(&net_resource_mgt->update_link_state,
+				      nbl_serv_update_link_state);
+		nbl_common_alloc_task(&net_resource_mgt->update_vlan,
+				      nbl_serv_update_vlan);
+	}
+
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_add_filter_list);
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_del_filter_list);
+	net_resource_mgt->get_stats_jiffies = jiffies;
+
+	mod_timer(&net_resource_mgt->serv_timer,
+		  jiffies + net_resource_mgt->serv_timer_period +
+		  hw_stats_delay_time);
+
+	return 0;
+}
+
+static int nbl_serv_enable_adminq_irq(void *priv, u16 vector_id,
+				      bool enable_msix)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->enable_adminq_irq(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    vector_id, enable_msix);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
 static u8 __iomem *nbl_serv_get_hw_addr(void *priv, size_t *size)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -1287,6 +3203,58 @@ static int nbl_serv_process_abnormal_event(void *priv)
 	return 0;
 }
 
+static int nbl_serv_setup_vf_config(void *priv, int num_vfs, bool is_flush)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct net_device *netdev = NBL_SERV_MGT_TO_NETDEV(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	u16 func_id = U16_MAX;
+	int i, ret = 0;
+
+	net_resource_mgt->num_vfs = num_vfs;
+	for (i = 0; i < net_resource_mgt->num_vfs; i++) {
+		func_id = nbl_serv_get_vf_function_id(serv_mgt, i);
+		if (func_id == U16_MAX) {
+			netif_err(common, drv, netdev, "vf id %d invalid\n", i);
+			return -EINVAL;
+		}
+
+		disp_ops->init_vf_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   func_id, !is_flush);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static void nbl_serv_remove_vf_config(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	nbl_serv_setup_vf_config(priv, net_resource_mgt->num_vfs, true);
+	net_resource_mgt->num_vfs = 0;
+}
+
+static int nbl_serv_setup_vf_resource(void *priv, int num_vfs)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	net_resource_mgt->total_vfs = num_vfs;
+	return 0;
+}
+
+static void nbl_serv_remove_vf_resource(void *priv)
+{
+	nbl_serv_remove_vf_config(priv);
+}
+
 static void nbl_serv_set_hw_status(void *priv, enum nbl_hw_status hw_status)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -1325,6 +3293,15 @@ static struct nbl_service_ops serv_ops = {
 	.init_chip = nbl_serv_init_chip,
 	.destroy_chip = nbl_serv_destroy_chip,
 
+	.configure_msix_map = nbl_serv_configure_msix_map,
+	.destroy_msix_map = nbl_serv_destroy_msix_map,
+	.enable_mailbox_irq = nbl_serv_enable_mailbox_irq,
+	.enable_abnormal_irq = nbl_serv_enable_abnormal_irq,
+	.enable_adminq_irq = nbl_serv_enable_adminq_irq,
+	.request_net_irq = nbl_serv_request_net_irq,
+	.free_net_irq = nbl_serv_free_net_irq,
+	.get_global_vector = nbl_serv_get_global_vector,
+	.get_msix_entry_id = nbl_serv_get_msix_entry_id,
 	.get_common_irq_num = nbl_serv_get_common_irq_num,
 	.get_ctrl_irq_num = nbl_serv_get_ctrl_irq_num,
 	.get_port_attributes = nbl_serv_get_port_attributes,
@@ -1336,9 +3313,30 @@ static struct nbl_service_ops serv_ops = {
 
 	.register_net = nbl_serv_register_net,
 	.unregister_net = nbl_serv_unregister_net,
-
+	.setup_txrx_queues = nbl_serv_setup_txrx_queues,
+	.remove_txrx_queues = nbl_serv_remove_txrx_queues,
+
+	.init_tx_rate = nbl_serv_init_tx_rate,
+	.setup_q2vsi = nbl_serv_setup_q2vsi,
+	.remove_q2vsi = nbl_serv_remove_q2vsi,
+	.setup_rss = nbl_serv_setup_rss,
+	.remove_rss = nbl_serv_remove_rss,
+	.setup_rss_indir = nbl_serv_setup_rss_indir,
 	.register_vsi_info = nbl_serv_register_vsi_info,
 
+	.alloc_rings = nbl_serv_alloc_rings,
+	.cpu_affinity_init = nbl_serv_cpu_affinity_init,
+	.free_rings = nbl_serv_free_rings,
+	.enable_napis = nbl_serv_enable_napis,
+	.disable_napis = nbl_serv_disable_napis,
+	.set_mask_en = nbl_serv_set_mask_en,
+	.start_net_flow = nbl_serv_start_net_flow,
+	.stop_net_flow = nbl_serv_stop_net_flow,
+	.clear_flow = nbl_serv_clear_flow,
+	.set_promisc_mode = nbl_serv_set_promisc_mode,
+	.cfg_multi_mcast = nbl_serv_cfg_multi_mcast,
+	.set_lldp_flow = nbl_serv_set_lldp_flow,
+	.remove_lldp_flow = nbl_serv_remove_lldp_flow,
 	.start_mgt_flow = nbl_serv_start_mgt_flow,
 	.stop_mgt_flow = nbl_serv_stop_mgt_flow,
 	.get_tx_headroom = nbl_serv_get_tx_headroom,
@@ -1349,15 +3347,28 @@ static struct nbl_service_ops serv_ops = {
 	/* For netdev ops */
 	.netdev_open = nbl_serv_netdev_open,
 	.netdev_stop = nbl_serv_netdev_stop,
+	.change_mtu = nbl_serv_change_mtu,
+	.set_mac = nbl_serv_set_mac,
 	.rx_add_vid = nbl_serv_rx_add_vid,
 	.rx_kill_vid = nbl_serv_rx_kill_vid,
 	.get_stats64 = nbl_serv_get_stats64,
+	.set_rx_mode = nbl_serv_set_rx_mode,
+	.change_rx_flags = nbl_serv_change_rx_flags,
+	.set_features = nbl_serv_set_features,
+	.features_check = nbl_serv_features_check,
+	.get_phys_port_name = nbl_serv_get_phys_port_name,
+	.tx_timeout = nbl_serv_tx_timeout,
+	.select_queue = nbl_serv_select_queue,
 	.get_rep_queue_info = nbl_serv_get_rep_queue_info,
 
 	.set_netdev_ops = nbl_serv_set_netdev_ops,
 
 	.get_vsi_id = nbl_serv_get_vsi_id,
 	.get_eth_id = nbl_serv_get_eth_id,
+	.setup_net_resource_mgt = nbl_serv_setup_net_resource_mgt,
+	.remove_net_resource_mgt = nbl_serv_remove_net_resource_mgt,
+	.init_hw_stats = nbl_serv_init_hw_stats,
+	.remove_hw_stats = nbl_serv_remove_hw_stats,
 
 	.get_hw_addr = nbl_serv_get_hw_addr,
 
@@ -1374,6 +3385,13 @@ static struct nbl_service_ops serv_ops = {
 
 	.check_fw_heartbeat = nbl_serv_check_fw_heartbeat,
 	.check_fw_reset = nbl_serv_check_fw_reset,
+	.set_netdev_carrier_state = nbl_serv_set_netdev_carrier_state,
+
+	.setup_vf_config = nbl_serv_setup_vf_config,
+	.remove_vf_config = nbl_serv_remove_vf_config,
+
+	.setup_vf_resource = nbl_serv_setup_vf_resource,
+	.remove_vf_resource = nbl_serv_remove_vf_resource,
 
 	.set_hw_status = nbl_serv_set_hw_status,
 	.get_active_func_bitmaps = nbl_serv_get_active_func_bitmaps,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index 2d60be4610a4..29331407fc41 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -22,5 +22,9 @@ struct nbl_dev_ops_tbl {
 
 int nbl_dev_init(void *p, struct nbl_init_param *param);
 void nbl_dev_remove(void *p);
+int nbl_dev_start(void *p, struct nbl_init_param *param);
+void nbl_dev_stop(void *p);
 
+int nbl_dev_setup_vf_config(void *p, int num_vfs);
+void nbl_dev_remove_vf_config(void *p);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index 6cab14b7cdfc..d7490a60bebb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -12,6 +12,17 @@
 struct nbl_service_ops {
 	int (*init_chip)(void *p);
 	int (*destroy_chip)(void *p);
+	int (*configure_msix_map)(void *p, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv);
+	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_abnormal_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_adminq_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*request_net_irq)(void *priv,
+			       struct nbl_msix_info_param *msix_info);
+	void (*free_net_irq)(void *priv, struct nbl_msix_info_param *msix_info);
+	u16 (*get_global_vector)(void *priv, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 local_vec_id);
 	void (*get_common_irq_num)(void *priv,
 				   struct nbl_common_irq_num *irq_num);
 	void (*get_ctrl_irq_num)(void *priv, struct nbl_ctrl_irq_num *irq_num);
@@ -20,15 +31,21 @@ struct nbl_service_ops {
 	int (*get_part_number)(void *priv, char *part_number);
 	int (*get_serial_number)(void *priv, char *serial_number);
 	int (*enable_port)(void *p, bool enable);
+	void (*set_netdev_carrier_state)(void *p, struct net_device *netdev,
+					 u8 link_state);
+
 	int (*vsi_open)(void *priv, struct net_device *netdev, u16 vsi_index,
 			u16 real_qps, bool use_napi);
 	int (*vsi_stop)(void *priv, u16 vsi_index);
+
 	int (*netdev_open)(struct net_device *netdev);
 	int (*netdev_stop)(struct net_device *netdev);
+	int (*change_mtu)(struct net_device *netdev, int new_mtu);
 	void (*get_stats64)(struct net_device *netdev,
 			    struct rtnl_link_stats64 *stats);
 	void (*set_rx_mode)(struct net_device *dev);
 	void (*change_rx_flags)(struct net_device *dev, int flag);
+	int (*set_mac)(struct net_device *dev, void *p);
 	int (*rx_add_vid)(struct net_device *dev, __be16 proto, u16 vid);
 	int (*rx_kill_vid)(struct net_device *dev, __be16 proto, u16 vid);
 	int (*set_features)(struct net_device *dev, netdev_features_t features);
@@ -44,13 +61,44 @@ struct nbl_service_ops {
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
 	int (*unregister_net)(void *priv);
+	int (*setup_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num,
+				 u16 net_vector_id);
+	void (*remove_txrx_queues)(void *priv, u16 vsi_id);
 	int (*register_vsi_info)(void *priv, struct nbl_vsi_param *vsi_param);
+	int (*init_tx_rate)(void *priv, u16 vsi_id);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*setup_rss_indir)(void *priv, u16 vsi_id);
+
+	int (*alloc_rings)(void *priv, struct net_device *dev,
+			   struct nbl_ring_param *param);
+	void (*cpu_affinity_init)(void *priv, u16 rings_num);
+	void (*free_rings)(void *priv);
+	int (*enable_napis)(void *priv, u16 vsi_index);
+	void (*disable_napis)(void *priv, u16 vsi_index);
+	void (*set_mask_en)(void *priv, bool enable);
+	int (*start_net_flow)(void *priv, struct net_device *dev, u16 vsi_id,
+			      u16 vid, bool trusted);
+	void (*stop_net_flow)(void *priv, u16 vsi_id);
+	void (*clear_flow)(void *priv, u16 vsi_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*cfg_multi_mcast)(void *priv, u16 vsi, u16 enable);
+	int (*set_lldp_flow)(void *priv, u16 vsi_id);
+	void (*remove_lldp_flow)(void *priv, u16 vsi_id);
 	int (*start_mgt_flow)(void *priv);
 	void (*stop_mgt_flow)(void *priv);
 	u32 (*get_tx_headroom)(void *priv);
+
 	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
 			   u8 *logic_eth_id);
+	int (*setup_net_resource_mgt)(void *priv, struct net_device *dev,
+				      u16 vlan_proto, u16 vlan_tci, u32 rate);
+	void (*remove_net_resource_mgt)(void *priv);
+	int (*init_hw_stats)(void *priv);
+	int (*remove_hw_stats)(void *priv);
 	void (*set_sfp_state)(void *priv, struct net_device *netdev, u8 eth_id,
 			      bool open, bool is_force);
 	int (*get_board_id)(void *priv);
@@ -76,7 +124,15 @@ struct nbl_service_ops {
 	bool (*check_fw_reset)(void *priv);
 
 	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
+
+	int (*setup_vf_config)(void *priv, int num_vfs, bool is_flush);
+	void (*remove_vf_config)(void *priv);
 	void (*register_dev_name)(void *priv, u16 vsi_id, char *name);
+	void (*get_dev_name)(void *priv, u16 vsi_id, char *name);
+
+	int (*setup_vf_resource)(void *priv, int num_vfs);
+	void (*remove_vf_resource)(void *priv);
+
 	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
 	void (*get_active_func_bitmaps)(void *priv, unsigned long *bitmap,
 					int max_func);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 6aca084d2b36..70e62fa0dd97 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -18,6 +18,19 @@ static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	},
 };
 
+int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	int ret = 0;
+
+	ret = nbl_dev_start(adapter, param);
+	return ret;
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
+
 static void
 nbl_core_setup_product_ops(struct nbl_adapter *adapter,
 			   struct nbl_init_param *param,
@@ -184,8 +197,13 @@ static int nbl_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter, &param);
+	if (err)
+		goto core_start_err;
 	dev_dbg(dev, "nbl probe ok!\n");
 	return 0;
+core_start_err:
+	nbl_core_remove(adapter);
 adapter_init_err:
 	pci_clear_master(pdev);
 configure_dma_err:
@@ -201,6 +219,8 @@ static void nbl_remove(struct pci_dev *pdev)
 	if (!adapter)
 		return;
 	pci_disable_sriov(pdev);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
@@ -209,6 +229,34 @@ static void nbl_remove(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "nbl remove OK!\n");
 }
 
+static __maybe_unused int nbl_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+	int err;
+
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		if (!adapter)
+			return 0;
+
+		nbl_dev_remove_vf_config(adapter);
+		return 0;
+	}
+
+	err = nbl_dev_setup_vf_config(adapter, num_vfs);
+	if (err) {
+		dev_err(&pdev->dev, "nbl setup vf config failed %d!\n", err);
+		return err;
+	}
+	err = pci_enable_sriov(pdev, num_vfs);
+	if (err) {
+		nbl_dev_remove_vf_config(adapter);
+		dev_err(&pdev->dev, "nbl enable sriov failed %d!\n", err);
+		return err;
+	}
+	return num_vfs;
+}
+
 #define NBL_VENDOR_ID			(0x1F0F)
 
 /*
@@ -297,6 +345,7 @@ static struct pci_driver nbl_driver = {
 	.id_table = nbl_id_table,
 	.probe = nbl_probe,
 	.remove = nbl_remove,
+	.sriov_configure = nbl_sriov_configure,
 };
 
 static int __init nbl_module_init(void)
-- 
2.47.3


