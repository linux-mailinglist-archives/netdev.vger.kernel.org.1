Return-Path: <netdev+bounces-245799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E277DCD8020
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E55B530534AF
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29ED2EF662;
	Tue, 23 Dec 2025 03:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-105.mail.aliyun.com (out28-105.mail.aliyun.com [115.124.28.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8972882CD;
	Tue, 23 Dec 2025 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461941; cv=none; b=tueh+Hb02oSqHYG9ayVRwDBmyAhi2V5zM4Z4EPhutKicPECM4lZWRvV0ds2uows0E87lrHm0EDI1a2bJCAz6+AaSAKsAMi7bsS5EhZIn2jvaaxo64152mjEBrmos5dUoYgvjPpLdPQOU/89A17dW649JwgtT0FlVOAzAI28GF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461941; c=relaxed/simple;
	bh=IIQNSoYb/hNzCWiKiHYVm/DLTqQMpX0R83dNEPwqqtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMktA7t+L0D9jRhmS6RMgAFYyLBbOZlxjFeOjiYDVD83AzzUZW4XjUwCRAK6GbIPf5lGnrrDAPSCisMGolIxQ7/8Fdm3e7eb1KRlOF8NAxEBvbs858/xr7lQ0dC1EoCQXieb+gr0orq9LjOY0oThSJgSE19inoRP7POrvzW4BJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxX3b_1766461913 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:55 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 13/15] net/nebula-matrix: add Dev start, stop operation
Date: Tue, 23 Dec 2025 11:50:36 +0800
Message-ID: <20251223035113.31122-14-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

some important steps in dev start:
1.start common dev: config msix map table, alloc and enable msix vectors,
register mailbox ISR and enable mailbox irq, set up chan keepalive task.
2.start ctrl dev: request abnormal and adminq ISR , enable them. schedule some
ctrl tasks such as adapt desc gother task.
3.start net dev:
 3.1 alloc netdev with multi-queue support, config private data and associatess
with the adapter.
 3.2 alloc tx/rx rings, set up network resource managements(vlan,rate limiting)
 3.3 build the netdev structure, map queues to msix interrupts, init hw stats.
 3.4 register link stats and reset event chan msg.
 3.5 start net vsi and register net irq.
 3.6 register netdev
 3.7 some other handles such as sysfs attributes.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: Ic97bbe53ace0e70ec704235513a2174d6c9b219e
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 3513 +++++++++++-----
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 3595 +++++++++++++++--
 .../nbl/nbl_include/nbl_def_dev.h             |    9 +-
 .../nbl/nbl_include/nbl_def_service.h         |   55 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   78 +-
 6 files changed, 5829 insertions(+), 1423 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 96e00bcc5ff4..69f7a3b1b3ab 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -136,6 +136,8 @@ struct nbl_software_tool_table {
 
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
+void nbl_core_stop(struct nbl_adapter *adapter);
 
 int nbl_st_init(struct nbl_software_tool_table *st_table);
 void nbl_st_remove(struct nbl_software_tool_table *st_table);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 853dd5469f60..d97651c5daa0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -27,11 +27,35 @@ static struct nbl_dev_board_id_table board_id_table;
 
 struct nbl_dev_ops dev_ops;
 
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
+static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info);
 static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt);
 static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param);
 static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter);
 
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
+static void nbl_dev_init_port(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (restore_eth)
+		serv_ops->init_port(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
 static int nbl_dev_alloc_board_id(struct nbl_dev_board_id_table *index_table, u32 board_key)
 {
 	int i = 0;
@@ -70,7 +94,41 @@ static void nbl_dev_free_board_id(struct nbl_dev_board_id_table *index_table, u3
 		memset(&index_table->entry[i], 0, sizeof(index_table->entry[i]));
 }
 
+static void nbl_dev_set_netdev_priv(struct net_device *netdev, struct nbl_dev_vsi *vsi,
+				    struct nbl_dev_vsi *user_vsi)
+{
+	struct nbl_netdev_priv *net_priv = netdev_priv(netdev);
+
+	net_priv->tx_queue_num = vsi->queue_num;
+	net_priv->rx_queue_num = vsi->queue_num;
+	net_priv->queue_size = vsi->queue_size;
+	net_priv->netdev = netdev;
+	net_priv->data_vsi = vsi->vsi_id;
+	if (user_vsi)
+		net_priv->user_vsi = user_vsi->vsi_id;
+	else
+		net_priv->user_vsi = vsi->vsi_id;
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
 	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
@@ -81,6 +139,23 @@ static void nbl_dev_handle_abnormal_event(struct work_struct *work)
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
+static irqreturn_t nbl_dev_clean_abnormal_event(int __always_unused irq, void *data)
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
@@ -114,1414 +189,2876 @@ static void nbl_dev_register_ctrl_irq(struct nbl_dev_mgt *dev_mgt)
 	msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num = irq_num.adminq_irq_num;
 }
 
-/* ----------  Channel config  ---------- */
-static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+static int nbl_dev_request_net_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = {0};
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
 	int ret = 0;
 
-	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
-		return 0;
+	param.msix_entries = kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return -ENOMEM;
 
-	ret = chan_ops->cfg_chan_qinfo_map_table(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-						 chan_type);
-	if (ret)
-		dev_err(dev, "setup chan:%d, qinfo map table failed\n", chan_type);
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries, msix_info->msix_entries +
+		msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+		sizeof(param.msix_entries[0]) * msix_num);
 
+	ret = serv_ops->request_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
+
+	kfree(param.msix_entries);
 	return ret;
 }
 
-static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+static void nbl_dev_free_net_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	int ret = 0;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_msix_info_param param = {0};
+	int msix_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
 
-	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
-		ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+	param.msix_entries = kcalloc(msix_num, sizeof(*param.msix_entries), GFP_KERNEL);
+	if (!param.msix_entries)
+		return;
 
-	return ret;
+	param.msix_num = msix_num;
+	memcpy(param.msix_entries, msix_info->msix_entries +
+		msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id,
+	       sizeof(param.msix_entries[0]) * msix_num);
+
+	serv_ops->free_net_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &param);
+
+	kfree(param.msix_entries);
 }
 
-static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	int ret = 0;
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	u32 irq_num;
+	int err;
 
-	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
-		ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
 
-	return ret;
-}
+	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
 
-static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
-{
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
+		 "nbl_mailbox@pci:%s", pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_mailbox,
+			       0, dev_common->mailbox_name, dev_mgt);
+	if (err) {
+		dev_err(dev, "Request mailbox irq handler failed err: %d\n", err);
+		return err;
+	}
 
-	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
-		chan_ops->remove_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+	return 0;
 }
 
-static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
-				       u8 chan_type, struct work_struct *task)
+static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	u32 irq_num;
 
-	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
-		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type, task);
-}
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return;
 
-/* ----------  Tasks config  ---------- */
-static void nbl_dev_clean_mailbox_task(struct work_struct *work)
-{
-	struct nbl_dev_common *common_dev = container_of(work, struct nbl_dev_common,
-							 clean_mbx_task);
-	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
 
-	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_MAILBOX);
+	devm_free_irq(dev, irq_num, dev_mgt);
 }
 
-static void nbl_dev_prepare_reset_task(struct work_struct *work)
+static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	int ret;
-	struct nbl_reset_task_info *task_info = container_of(work, struct nbl_reset_task_info,
-							     task);
-	struct nbl_dev_common *common_dev = container_of(task_info, struct nbl_dev_common,
-							 reset_task);
-	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct nbl_chan_send_info chan_send;
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
 
-	serv_ops->netdev_stop(dev_mgt->net_dev->netdev);
-	netif_device_detach(dev_mgt->net_dev->netdev); /* to avoid ethtool operation */
-	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
 
-	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_ACK_RESET_EVENT, NULL,
-		      0, NULL, 0, 0);
-	/* notify ctrl dev, finish reset event process */
-	ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
-	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
 				  NBL_CHAN_TYPE_MAILBOX, true);
 
-	/* sleep to avoid send_msg is running */
-	usleep_range(10, 20);
-
-	/* ctrl dev must shutdown phy reg read/write after ctrl dev has notify emp shutdown dev */
-	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
-		serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
+	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, true);
 }
 
-static void nbl_dev_clean_adminq_task(struct work_struct *work)
+static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
-						       clean_adminq_task);
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
 
-	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_ADMINQ);
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_flush_task(&dev_common->clean_mbx_task);
+
+	local_vector_id = msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, false);
+
+	return serv_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, false);
 }
 
-static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
+static int nbl_dev_request_adminq_irq(struct nbl_dev_mgt *dev_mgt, struct nbl_task_info *task_info)
 {
-	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
-						       fw_hb_task);
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
 	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	u32 irq_num;
+	char *irq_name;
+	int err;
 
-	if (task_info->fw_resetting)
-		return;
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
 
-	if (!serv_ops->check_fw_heartbeat(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
-		dev_notice(NBL_COMMON_TO_DEV(common), "FW reset detected");
-		task_info->fw_resetting = true;
-		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
-					NBL_CHAN_TYPE_ADMINQ, true);
-		nbl_common_queue_delayed_work(&task_info->fw_reset_task, MSEC_PER_SEC, true);
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
+	irq_name = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].irq_name;
+
+	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_adminq@pci:%s",
+		 pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_adminq,
+			       0, irq_name, task_info);
+	if (err) {
+		dev_err(dev, "Request adminq irq handler failed err: %d\n", err);
+		return err;
 	}
+
+	return 0;
 }
 
-static void nbl_dev_fw_reset_task(struct work_struct *work)
+static void nbl_dev_free_adminq_irq(struct nbl_dev_mgt *dev_mgt, struct nbl_task_info *task_info)
 {
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	u32 irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return;
+
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
+
+	devm_free_irq(dev, irq_num, task_info);
 }
 
-static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
+static int nbl_dev_enable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
-						       adapt_desc_gother_task);
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
 
-	serv_ops->adapt_desc_gother(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
+
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_ADMINQ, true);
+
+	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, true);
 }
 
-static void nbl_dev_recovery_abnormal_task(struct work_struct *work)
+static int nbl_dev_disable_adminq_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
-						       recovery_abnormal_task);
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
 
-	serv_ops->recovery_abnormal(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-}
+	if (!msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num)
+		return 0;
 
-static void nbl_dev_ctrl_reset_task(struct work_struct *work)
-{
-	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
-						       reset_task);
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].base_vector_id;
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_ADMINQ, false);
 
-	nbl_dev_handle_fatal_err(dev_mgt);
+	return serv_ops->enable_adminq_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, false);
 }
 
-static void nbl_dev_ctrl_task_schedule(struct nbl_task_info *task_info)
+static int nbl_dev_request_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	char *irq_name;
+	u32 irq_num;
+	int err;
+	u16 local_vector_id;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_FW_HB_CAP))
-		nbl_common_queue_work(&task_info->fw_hb_task, true);
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_ADAPT_DESC_GOTHER))
-		nbl_common_queue_work(&task_info->adapt_desc_gother_task, true);
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
+	irq_name = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].irq_name;
+
+	snprintf(irq_name, NBL_STRING_NAME_LEN, "nbl_abnormal@pci:%s",
+		 pci_name(NBL_COMMON_TO_PDEV(common)));
+	err = devm_request_irq(dev, irq_num, nbl_dev_clean_abnormal_event,
+			       0, irq_name, dev_mgt);
+	if (err) {
+		dev_err(dev, "Request abnormal_irq irq handler failed err: %d\n", err);
+		return err;
+	}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_RECOVERY_ABNORMAL_STATUS))
-		nbl_common_queue_work(&task_info->recovery_abnormal_task, true);
+	return 0;
 }
 
-static void nbl_dev_ctrl_task_timer(struct timer_list *t)
+static void nbl_dev_free_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_task_info *task_info = container_of(t, struct nbl_task_info, serv_timer);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	u32 irq_num;
 
-	mod_timer(&task_info->serv_timer, round_jiffies(task_info->serv_timer_period + jiffies));
-	nbl_dev_ctrl_task_schedule(task_info);
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return;
+
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	irq_num = msix_info->msix_entries[local_vector_id].vector;
+
+	devm_free_irq(dev, irq_num, dev_mgt);
 }
 
-static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
-					 void *data, u32 data_len)
+static int nbl_dev_enable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	u16 vfid;
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	int err = 0;
 
-	vfid = *(u16 *)data;
-	serv_ops->process_flr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vfid);
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
+
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, true);
+
+	return err;
 }
 
-static void nbl_dev_ctrl_register_flr_chan_msg(struct nbl_dev_mgt *dev_mgt)
+static int nbl_dev_disable_abnormal_irq(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	u16 local_vector_id;
+	int err = 0;
 
-	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					   NBL_PROCESS_FLR_CAP))
-		return;
+	if (!msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num)
+		return 0;
 
-	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-			       NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY,
-			       nbl_dev_chan_notify_flr_resp, dev_mgt);
+	local_vector_id = msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].base_vector_id;
+	err = serv_ops->enable_abnormal_irq(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					    local_vector_id, false);
+
+	return err;
 }
 
-static struct nbl_dev_temp_alarm_info temp_alarm_info[NBL_TEMP_STATUS_MAX] = {
-	{LOGLEVEL_WARNING, "High temperature on sensors0 resumed.\n"},
-	{LOGLEVEL_WARNING, "High temperature on sensors0 observed, security(WARNING).\n"},
-	{LOGLEVEL_CRIT, "High temperature on sensors0 observed, security(CRITICAL).\n"},
-	{LOGLEVEL_EMERG, "High temperature on sensors0 observed, security(EMERGENCY).\n"},
-};
-
-static void nbl_dev_handle_temp_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
 {
-	u16 temp = (u16)*data;
-	u64 uptime = 0;
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
-	enum nbl_dev_temp_status old_temp_status = ctrl_dev->temp_status;
-	enum nbl_dev_temp_status new_temp_status = NBL_TEMP_STATUS_NORMAL;
-
-	/* no resume if temp exceed NBL_TEMP_EMERG_THRESHOLD, even if the temp resume nomal.
-	 * Because the hw has shutdown.
-	 */
-	if (old_temp_status == NBL_TEMP_STATUS_EMERG)
-		return;
-
-	/* if temp in (85-105) and not in normal_status, no resume to avoid alarm oscillate */
-	if (temp > NBL_TEMP_NOMAL_THRESHOLD &&
-	    temp < NBL_TEMP_WARNING_THRESHOLD &&
-	    old_temp_status > NBL_TEMP_STATUS_NORMAL)
-		return;
-
-	if (temp >= NBL_TEMP_WARNING_THRESHOLD &&
-	    temp < NBL_TEMP_CRIT_THRESHOLD)
-		new_temp_status = NBL_TEMP_STATUS_WARNING;
-	else if (temp >= NBL_TEMP_CRIT_THRESHOLD &&
-		 temp < NBL_TEMP_EMERG_THRESHOLD)
-		new_temp_status = NBL_TEMP_STATUS_CRIT;
-	else if (temp >= NBL_TEMP_EMERG_THRESHOLD)
-		new_temp_status = NBL_TEMP_STATUS_EMERG;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	int err = 0;
+	int i;
+	u16 msix_not_net_num = 0;
 
-	if (new_temp_status == old_temp_status)
-		return;
+	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
+		msix_info->serv_info[i].base_vector_id = msix_info->serv_info[i - 1].base_vector_id
+							 + msix_info->serv_info[i - 1].num;
 
-	ctrl_dev->temp_status = new_temp_status;
+	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++) {
+		if (i == NBL_MSIX_NET_TYPE)
+			continue;
 
-	/* temp fall only alarm when the alarm need to resume */
-	if (new_temp_status < old_temp_status && new_temp_status != NBL_TEMP_STATUS_NORMAL)
-		return;
+		msix_not_net_num += msix_info->serv_info[i].num;
+	}
 
-	if (data_len > sizeof(u16))
-		uptime = *(u64 *)(data + sizeof(u16));
-	nbl_log(common, temp_alarm_info[new_temp_status].logvel,
-		"[%llu] %s", uptime, temp_alarm_info[new_temp_status].alarm_info);
+	err = serv_ops->configure_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   msix_info->serv_info[NBL_MSIX_NET_TYPE].num,
+					   msix_not_net_num,
+					   msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en);
 
-	if (new_temp_status == NBL_TEMP_STATUS_EMERG) {
-		ctrl_dev->task_info.reset_event = NBL_HW_FATAL_ERR_EVENT;
-		nbl_common_queue_work(&ctrl_dev->task_info.reset_task, false);
-	}
+	return err;
 }
 
-static const char *nbl_log_level_name(int level)
+static int nbl_dev_destroy_msix_map(struct nbl_dev_mgt *dev_mgt)
 {
-	switch (level) {
-	case NBL_EMP_ALERT_LOG_FATAL:
-		return "FATAL";
-	case NBL_EMP_ALERT_LOG_ERROR:
-		return "ERROR";
-	case NBL_EMP_ALERT_LOG_WARNING:
-		return "WARNING";
-	case NBL_EMP_ALERT_LOG_INFO:
-		return "INFO";
-	default:
-		return "UNKNOWN";
-	}
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	int err = 0;
+
+	err = serv_ops->destroy_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	return err;
 }
 
-static void nbl_dev_handle_emp_log_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+static int nbl_dev_alloc_msix_entries(struct nbl_dev_mgt *dev_mgt, u16 num_entries)
 {
-	struct nbl_emp_alert_log_event *log_event = (struct nbl_emp_alert_log_event *)data;
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u16 i;
 
-	nbl_log(common, LOGLEVEL_INFO, "[FW][%llu] <%s> %.*s", log_event->uptime,
-		nbl_log_level_name(log_event->level), data_len - sizeof(u64) - sizeof(u8),
-		log_event->data);
-}
+	msix_info->msix_entries = devm_kcalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), num_entries,
+					       sizeof(msix_info->msix_entries),
+					       GFP_KERNEL);
+	if (!msix_info->msix_entries)
+		return -ENOMEM;
 
-static void nbl_dev_chan_notify_evt_alert_resp(void *priv, u16 src_id, u16 msg_id,
-					       void *data, u32 data_len)
-{
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
-	struct nbl_chan_param_emp_alert_event *alert_param =
-						(struct nbl_chan_param_emp_alert_event *)data;
+	for (i = 0; i < num_entries; i++)
+		msix_info->msix_entries[i].entry =
+				serv_ops->get_msix_entry_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), i);
 
-	switch (alert_param->type) {
-	case NBL_EMP_EVENT_TEMP_ALERT:
-		nbl_dev_handle_temp_ext(dev_mgt, alert_param->data, alert_param->len);
-		return;
-	case NBL_EMP_EVENT_LOG_ALERT:
-		nbl_dev_handle_emp_log_ext(dev_mgt, alert_param->data, alert_param->len);
-		return;
-	default:
-		return;
-	}
+	dev_info(NBL_DEV_MGT_TO_DEV(dev_mgt), "alloc msix entry: %u-%u.\n",
+		 msix_info->msix_entries[0].entry, msix_info->msix_entries[num_entries - 1].entry);
+
+	return 0;
 }
 
-static void nbl_dev_ctrl_register_emp_ext_alert_chan_msg(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_free_msix_entries(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-
-	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-					 NBL_CHAN_TYPE_MAILBOX))
-		return;
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
 
-	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-			       NBL_CHAN_MSG_ADMINQ_EXT_ALERT,
-			       nbl_dev_chan_notify_evt_alert_resp, dev_mgt);
+	devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), msix_info->msix_entries);
+	msix_info->msix_entries = NULL;
 }
 
-static int nbl_dev_setup_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+static int nbl_dev_alloc_msix_intr(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
-	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int needed = 0;
+	int err;
+	int i;
 
-	task_info->dev_mgt = dev_mgt;
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
+		needed += msix_info->serv_info[i].num;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_FW_HB_CAP)) {
-		nbl_common_alloc_task(&task_info->fw_hb_task, nbl_dev_fw_heartbeat_task);
-		task_info->timer_setup = true;
+	err = nbl_dev_alloc_msix_entries(dev_mgt, (u16)needed);
+	if (err) {
+		pr_err("Allocate msix entries failed\n");
+		return err;
 	}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_FW_RESET_CAP)) {
-		nbl_common_alloc_delayed_task(&task_info->fw_reset_task, nbl_dev_fw_reset_task);
-		task_info->timer_setup = true;
+	err = pci_enable_msix_range(NBL_COMMON_TO_PDEV(common), msix_info->msix_entries,
+				    needed, needed);
+	if (err < 0) {
+		pr_err("pci_enable_msix_range failed, err = %d.\n", err);
+		goto enable_msix_failed;
 	}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_CLEAN_ADMINDQ_CAP)) {
-		nbl_common_alloc_task(&task_info->clean_adminq_task, nbl_dev_clean_adminq_task);
-		task_info->timer_setup = true;
-	}
+	return needed;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_ADAPT_DESC_GOTHER)) {
-		nbl_common_alloc_task(&task_info->adapt_desc_gother_task,
-				      nbl_dev_adapt_desc_gother_task);
-		task_info->timer_setup = true;
-	}
+enable_msix_failed:
+	nbl_dev_free_msix_entries(dev_mgt);
+	return err;
+}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_RECOVERY_ABNORMAL_STATUS)) {
-		nbl_common_alloc_task(&task_info->recovery_abnormal_task,
-				      nbl_dev_recovery_abnormal_task);
-		task_info->timer_setup = true;
-	}
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_RESET_CTRL_CAP))
-		nbl_common_alloc_task(&task_info->reset_task, &nbl_dev_ctrl_reset_task);
+static void nbl_dev_free_msix_intr(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 
-	nbl_common_alloc_task(&task_info->clean_abnormal_irq_task,
-			      nbl_dev_handle_abnormal_event);
+	pci_disable_msix(NBL_COMMON_TO_PDEV(common));
+	nbl_dev_free_msix_entries(dev_mgt);
+}
 
-	if (task_info->timer_setup) {
-		timer_setup(&task_info->serv_timer, nbl_dev_ctrl_task_timer, 0);
-		task_info->serv_timer_period = HZ;
-	}
+static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	int err = 0;
 
-	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, &task_info->clean_adminq_task);
+	err = nbl_dev_alloc_msix_intr(dev_mgt);
+	if (err < 0) {
+		dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Failed to enable MSI-X vectors\n");
+		return err;
+	}
 
 	return 0;
 }
 
-static void nbl_dev_remove_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+	nbl_dev_free_msix_intr(dev_mgt);
+}
 
-	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, NULL);
+/* ----------  Channel config  ---------- */
+static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret = 0;
 
-	nbl_common_release_task(&task_info->clean_abnormal_irq_task);
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		return 0;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_FW_RESET_CAP))
-		nbl_common_release_delayed_task(&task_info->fw_reset_task);
+	ret = chan_ops->cfg_chan_qinfo_map_table(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+						 chan_type);
+	if (ret)
+		dev_err(dev, "setup chan:%d, qinfo map table failed\n", chan_type);
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_FW_HB_CAP))
-		nbl_common_release_task(&task_info->fw_hb_task);
+	return ret;
+}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_CLEAN_ADMINDQ_CAP))
-		nbl_common_release_task(&task_info->clean_adminq_task);
+static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_ADAPT_DESC_GOTHER))
-		nbl_common_release_task(&task_info->adapt_desc_gother_task);
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_RECOVERY_ABNORMAL_STATUS))
-		nbl_common_release_task(&task_info->recovery_abnormal_task);
+	return ret;
+}
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_RESET_CTRL_CAP))
-		nbl_common_release_task(&task_info->reset_task);
+static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+
+	return ret;
 }
 
-static int nbl_dev_update_template_config(struct nbl_dev_mgt *dev_mgt)
+static bool nbl_dev_should_chan_keepalive(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	bool ret = true;
 
-	return serv_ops->update_template_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	ret = serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					     NBL_TASK_KEEP_ALIVE);
+
+	return ret;
 }
 
-/* ----------  Dev init process  ---------- */
-static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+static int nbl_dev_setup_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_common *common_dev;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	int board_id;
-
-	common_dev = devm_kzalloc(NBL_ADAPTER_TO_DEV(adapter),
-				  sizeof(struct nbl_dev_common), GFP_KERNEL);
-	if (!common_dev)
-		return -ENOMEM;
-	common_dev->dev_mgt = dev_mgt;
+	u16 dest_func_id = NBL_COMMON_TO_MGT_PF(common);
 
-	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
-		goto setup_chan_fail;
+	if (!nbl_dev_should_chan_keepalive(dev_mgt))
+		return 0;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_CLEAN_MAILBOX_CAP))
-		nbl_common_alloc_task(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+	if (chan_type != NBL_CHAN_TYPE_MAILBOX)
+		return -EOPNOTSUPP;
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_RESET_CAP))
-		nbl_common_alloc_task(&common_dev->reset_task.task, &nbl_dev_prepare_reset_task);
+	dest_func_id = serv_ops->get_function_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+						 NBL_COMMON_TO_VSI_ID(common));
 
-	if (param->caps.is_nic) {
-		board_id = serv_ops->get_board_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-		if (board_id < 0)
-			goto get_board_id_fail;
-		NBL_COMMON_TO_BOARD_ID(common) = board_id;
-	}
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		return chan_ops->setup_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+						 dest_func_id, chan_type);
 
-	NBL_COMMON_TO_VSI_ID(common) = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0,
-							    NBL_VSI_DATA);
+	return -ENOENT;
+}
 
-	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_COMMON_TO_VSI_ID(common),
-			     &NBL_COMMON_TO_ETH_MODE(common), &NBL_COMMON_TO_ETH_ID(common),
-			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
+static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, &common_dev->clean_mbx_task);
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		chan_ops->remove_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+}
 
-	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = common_dev;
-
-	nbl_dev_register_common_irq(dev_mgt);
+static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
+				       u8 chan_type, struct work_struct *task)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	return 0;
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type, task);
+}
 
-get_board_id_fail:
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_RESET_CAP))
-		nbl_common_release_task(&common_dev->reset_task.task);
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox_task(struct work_struct *work)
+{
+	struct nbl_dev_common *common_dev = container_of(work, struct nbl_dev_common,
+							 clean_mbx_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_CLEAN_MAILBOX_CAP))
-		nbl_common_release_task(&common_dev->clean_mbx_task);
-setup_chan_fail:
-	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
-	return -EFAULT;
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_MAILBOX);
 }
 
-static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
 
-	if (!common_dev)
-		return;
-
-	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
-
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_RESET_CAP))
-		nbl_common_release_task(&common_dev->reset_task.task);
-
-	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					  NBL_TASK_CLEAN_MAILBOX_CAP))
-		nbl_common_release_task(&common_dev->clean_mbx_task);
-
-	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	if (ctrl_dev)
+		queue_work(ctrl_dev->ctrl_dev_wq1, &common_dev->clean_mbx_task);
+	else
+		nbl_common_queue_work(&common_dev->clean_mbx_task, false);
 
-	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
-	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = NULL;
+	return 0;
 }
 
-static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+static void nbl_dev_prepare_reset_task(struct work_struct *work)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_dev_ctrl *ctrl_dev;
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	int ret;
+	struct nbl_reset_task_info *task_info = container_of(work, struct nbl_reset_task_info,
+							     task);
+	struct nbl_dev_common *common_dev = container_of(task_info, struct nbl_dev_common,
+							 reset_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
 	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	int i, ret = 0;
-	u32 board_key;
-	char part_number[50] = "";
-	char serial_number[128] = "";
-	int board_id;
-
-	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
-			dev_mgt->common->pdev->bus->number;
-	if (param->caps.is_nic) {
-		board_id =
-			nbl_dev_alloc_board_id(&board_id_table, board_key);
-		if (board_id < 0)
-			return -ENOSPC;
-		NBL_COMMON_TO_BOARD_ID(common) =  board_id;
-	}
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_chan_send_info chan_send;
 
-	dev_info(dev, "board_key 0x%x alloc board id 0x%x\n",
-		 board_key, NBL_COMMON_TO_BOARD_ID(common));
+	serv_ops->netdev_stop(dev_mgt->net_dev->netdev);
+	netif_device_detach(dev_mgt->net_dev->netdev); /* to avoid ethtool operation */
+	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
 
-	ctrl_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_ctrl), GFP_KERNEL);
-	if (!ctrl_dev)
-		goto alloc_fail;
-	NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev)->adapter = adapter;
-	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = ctrl_dev;
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_ACK_RESET_EVENT, NULL,
+		      0, NULL, 0, 0);
+	/* notify ctrl dev, finish reset event process */
+	ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+				  NBL_CHAN_TYPE_MAILBOX, true);
 
-	nbl_dev_register_ctrl_irq(dev_mgt);
+	/* sleep to avoid send_msg is running */
+	usleep_range(10, 20);
 
-	ctrl_dev->ctrl_dev_wq1 = create_singlethread_workqueue("nbl_ctrldev_wq1");
-	if (!ctrl_dev->ctrl_dev_wq1) {
-		dev_err(dev, "Failed to create workqueue nbl_ctrldev_wq1\n");
-		goto alloc_wq_fail;
-	}
+	/* ctrl dev must shutdown phy reg read/write after ctrl dev has notify emp shutdown dev */
+	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
+		serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
+}
 
-	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-	if (ret) {
-		dev_err(dev, "ctrl dev chip_init failed\n");
-		goto chip_init_fail;
-	}
+static void nbl_dev_clean_adminq_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       clean_adminq_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	ret = serv_ops->start_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-	if (ret) {
-		dev_err(dev, "ctrl dev start_mgt_flow failed\n");
-		goto mgt_flow_fail;
-	}
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_ADMINQ);
+}
 
-	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
-		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
-		if (ret) {
-			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
-				goto setup_chan_q_fail;
-		}
-	}
+static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info)
+{
+	nbl_common_queue_work(&task_info->clean_adminq_task, true);
+}
 
-	nbl_dev_ctrl_register_flr_chan_msg(dev_mgt);
-	nbl_dev_ctrl_register_emp_ext_alert_chan_msg(dev_mgt);
+static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       fw_hb_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 
-	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
-	if (ret) {
-		dev_err(dev, "ctrl dev setup chan queue failed\n");
-			goto setup_chan_q_fail;
-	}
+	if (task_info->fw_resetting)
+		return;
 
-	ret = nbl_dev_setup_ctrl_dev_task(dev_mgt);
-	if (ret) {
-		dev_err(dev, "ctrl dev task failed\n");
-		goto setup_ctrl_dev_task_fail;
+	if (!serv_ops->check_fw_heartbeat(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
+		dev_notice(NBL_COMMON_TO_DEV(common), "FW reset detected");
+		task_info->fw_resetting = true;
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+					NBL_CHAN_TYPE_ADMINQ, true);
+		nbl_common_queue_delayed_work(&task_info->fw_reset_task, MSEC_PER_SEC, true);
 	}
-
-	serv_ops->get_part_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), part_number);
-	serv_ops->get_serial_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), serial_number);
-	dev_info(dev, "part number: %s, serial number: %s\n", part_number, serial_number);
-
-	nbl_dev_update_template_config(dev_mgt);
-
-	return 0;
-
-setup_ctrl_dev_task_fail:
-	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
-setup_chan_q_fail:
-	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-mgt_flow_fail:
-	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-chip_init_fail:
-	destroy_workqueue(ctrl_dev->ctrl_dev_wq1);
-alloc_wq_fail:
-	devm_kfree(dev, ctrl_dev);
-	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = NULL;
-alloc_fail:
-	nbl_dev_free_board_id(&board_id_table, board_key);
-	return ret;
 }
 
-static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+static void nbl_dev_fw_reset_task(struct work_struct *work)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_ctrl **ctrl_dev = &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct nbl_task_info *task_info = container_of(delayed_work, struct nbl_task_info,
+						       fw_reset_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	u32 board_key;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 
-	if (!*ctrl_dev)
-		return;
+	if (serv_ops->check_fw_reset(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
+		dev_notice(NBL_COMMON_TO_DEV(common), "FW recovered");
+		nbl_dev_disable_adminq_irq(dev_mgt);
+		nbl_dev_free_adminq_irq(dev_mgt, task_info);
 
-	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
-			dev_mgt->common->pdev->bus->number;
-	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
-	nbl_dev_remove_ctrl_dev_task(dev_mgt);
+		msleep(NBL_DEV_FW_RESET_WAIT_TIME); // wait adminq timeout
+		nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_setup_chan_qinfo(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+		nbl_dev_request_adminq_irq(dev_mgt, task_info);
+		nbl_dev_enable_adminq_irq(dev_mgt);
 
-	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+					  NBL_CHAN_TYPE_ADMINQ, false);
 
-	destroy_workqueue((*ctrl_dev)->ctrl_dev_wq1);
-	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), *ctrl_dev);
-	*ctrl_dev = NULL;
+		if (NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)) {
+			nbl_dev_get_port_attributes(dev_mgt);
+			nbl_dev_enable_port(dev_mgt, true);
+		}
+		task_info->fw_resetting = false;
+		return;
+	}
 
-	/* If it is not nic, this free function will do nothing, so no need check */
-	nbl_dev_free_board_id(&board_id_table, board_key);
+	nbl_common_queue_delayed_work(delayed_work, MSEC_PER_SEC, true);
 }
 
-static int nbl_dev_netdev_open(struct net_device *netdev)
+static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       adapt_desc_gother_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	return serv_ops->netdev_open(netdev);
+	serv_ops->adapt_desc_gother(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
 }
 
-static int nbl_dev_netdev_stop(struct net_device *netdev)
+static void nbl_dev_recovery_abnormal_task(struct work_struct *work)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       recovery_abnormal_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	return serv_ops->netdev_stop(netdev);
+	serv_ops->recovery_abnormal(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
 }
 
-static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static void nbl_dev_ctrl_reset_task(struct work_struct *work)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       reset_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 
-	return pt_ops->start_xmit(skb, netdev);
+	nbl_dev_handle_fatal_err(dev_mgt);
 }
 
-static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+static void nbl_dev_ctrl_task_schedule(struct nbl_task_info *task_info)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	serv_ops->get_stats64(netdev, stats);
-}
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP))
+		nbl_common_queue_work(&task_info->fw_hb_task, true);
 
-static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
-{
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER))
+		nbl_common_queue_work(&task_info->adapt_desc_gother_task, true);
 
-	return serv_ops->rx_add_vid(netdev, proto, vid);
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS))
+		nbl_common_queue_work(&task_info->recovery_abnormal_task, true);
 }
 
-static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+static void nbl_dev_ctrl_task_timer(struct timer_list *t)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_task_info *task_info = container_of(t, struct nbl_task_info, serv_timer);
+
+	mod_timer(&task_info->serv_timer, round_jiffies(task_info->serv_timer_period + jiffies));
+	nbl_dev_ctrl_task_schedule(task_info);
+}
+
+static void nbl_dev_ctrl_task_start(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	if (!task_info->timer_setup)
+		return;
+
+	mod_timer(&task_info->serv_timer, round_jiffies(jiffies + task_info->serv_timer_period));
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
+static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
+					 void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u16 vfid;
 
-	return serv_ops->rx_kill_vid(netdev, proto, vid);
+	vfid = *(u16 *)data;
+	serv_ops->process_flr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vfid);
 }
 
-static const struct net_device_ops netdev_ops_leonis_pf = {
-	.ndo_open = nbl_dev_netdev_open,
-	.ndo_stop = nbl_dev_netdev_stop,
-	.ndo_start_xmit = nbl_dev_start_xmit,
-	.ndo_validate_addr = eth_validate_addr,
-	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
-	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
-	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+static void nbl_dev_ctrl_register_flr_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   NBL_PROCESS_FLR_CAP))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY,
+			       nbl_dev_chan_notify_flr_resp, dev_mgt);
+}
 
+static struct nbl_dev_temp_alarm_info temp_alarm_info[NBL_TEMP_STATUS_MAX] = {
+	{LOGLEVEL_WARNING, "High temperature on sensors0 resumed.\n"},
+	{LOGLEVEL_WARNING, "High temperature on sensors0 observed, security(WARNING).\n"},
+	{LOGLEVEL_CRIT, "High temperature on sensors0 observed, security(CRITICAL).\n"},
+	{LOGLEVEL_EMERG, "High temperature on sensors0 observed, security(EMERGENCY).\n"},
 };
 
-static const struct net_device_ops netdev_ops_leonis_vf = {
-	.ndo_open = nbl_dev_netdev_open,
-	.ndo_stop = nbl_dev_netdev_stop,
-	.ndo_start_xmit = nbl_dev_start_xmit,
-	.ndo_validate_addr = eth_validate_addr,
-	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
-	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
-	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+static void nbl_dev_handle_temp_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+{
+	u16 temp = (u16)*data;
+	u64 uptime = 0;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	enum nbl_dev_temp_status old_temp_status = ctrl_dev->temp_status;
+	enum nbl_dev_temp_status new_temp_status = NBL_TEMP_STATUS_NORMAL;
+
+	/* no resume if temp exceed NBL_TEMP_EMERG_THRESHOLD, even if the temp resume nomal.
+	 * Because the hw has shutdown.
+	 */
+	if (old_temp_status == NBL_TEMP_STATUS_EMERG)
+		return;
+
+	/* if temp in (85-105) and not in normal_status, no resume to avoid alarm oscillate */
+	if (temp > NBL_TEMP_NOMAL_THRESHOLD &&
+	    temp < NBL_TEMP_WARNING_THRESHOLD &&
+	    old_temp_status > NBL_TEMP_STATUS_NORMAL)
+		return;
+
+	if (temp >= NBL_TEMP_WARNING_THRESHOLD &&
+	    temp < NBL_TEMP_CRIT_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_WARNING;
+	else if (temp >= NBL_TEMP_CRIT_THRESHOLD &&
+		 temp < NBL_TEMP_EMERG_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_CRIT;
+	else if (temp >= NBL_TEMP_EMERG_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_EMERG;
+
+	if (new_temp_status == old_temp_status)
+		return;
+
+	ctrl_dev->temp_status = new_temp_status;
+
+	/* temp fall only alarm when the alarm need to resume */
+	if (new_temp_status < old_temp_status && new_temp_status != NBL_TEMP_STATUS_NORMAL)
+		return;
+
+	if (data_len > sizeof(u16))
+		uptime = *(u64 *)(data + sizeof(u16));
+	nbl_log(common, temp_alarm_info[new_temp_status].logvel,
+		"[%llu] %s", uptime, temp_alarm_info[new_temp_status].alarm_info);
+
+	if (new_temp_status == NBL_TEMP_STATUS_EMERG) {
+		ctrl_dev->task_info.reset_event = NBL_HW_FATAL_ERR_EVENT;
+		nbl_common_queue_work(&ctrl_dev->task_info.reset_task, false);
+	}
+}
+
+static const char *nbl_log_level_name(int level)
+{
+	switch (level) {
+	case NBL_EMP_ALERT_LOG_FATAL:
+		return "FATAL";
+	case NBL_EMP_ALERT_LOG_ERROR:
+		return "ERROR";
+	case NBL_EMP_ALERT_LOG_WARNING:
+		return "WARNING";
+	case NBL_EMP_ALERT_LOG_INFO:
+		return "INFO";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void nbl_dev_handle_emp_log_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+{
+	struct nbl_emp_alert_log_event *log_event = (struct nbl_emp_alert_log_event *)data;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	nbl_log(common, LOGLEVEL_INFO, "[FW][%llu] <%s> %.*s", log_event->uptime,
+		nbl_log_level_name(log_event->level), data_len - sizeof(u64) - sizeof(u8),
+		log_event->data);
+}
+
+static void nbl_dev_chan_notify_evt_alert_resp(void *priv, u16 src_id, u16 msg_id,
+					       void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_chan_param_emp_alert_event *alert_param =
+						(struct nbl_chan_param_emp_alert_event *)data;
+
+	switch (alert_param->type) {
+	case NBL_EMP_EVENT_TEMP_ALERT:
+		nbl_dev_handle_temp_ext(dev_mgt, alert_param->data, alert_param->len);
+		return;
+	case NBL_EMP_EVENT_LOG_ALERT:
+		nbl_dev_handle_emp_log_ext(dev_mgt, alert_param->data, alert_param->len);
+		return;
+	default:
+		return;
+	}
+}
+
+static void nbl_dev_ctrl_register_emp_ext_alert_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ADMINQ_EXT_ALERT,
+			       nbl_dev_chan_notify_evt_alert_resp, dev_mgt);
+}
+
+static int nbl_dev_setup_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	task_info->dev_mgt = dev_mgt;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP)) {
+		nbl_common_alloc_task(&task_info->fw_hb_task, nbl_dev_fw_heartbeat_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_RESET_CAP)) {
+		nbl_common_alloc_delayed_task(&task_info->fw_reset_task, nbl_dev_fw_reset_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_ADMINDQ_CAP)) {
+		nbl_common_alloc_task(&task_info->clean_adminq_task, nbl_dev_clean_adminq_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER)) {
+		nbl_common_alloc_task(&task_info->adapt_desc_gother_task,
+				      nbl_dev_adapt_desc_gother_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS)) {
+		nbl_common_alloc_task(&task_info->recovery_abnormal_task,
+				      nbl_dev_recovery_abnormal_task);
+		task_info->timer_setup = true;
+	}
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CTRL_CAP))
+		nbl_common_alloc_task(&task_info->reset_task, &nbl_dev_ctrl_reset_task);
+
+	nbl_common_alloc_task(&task_info->clean_abnormal_irq_task,
+			      nbl_dev_handle_abnormal_event);
+
+	if (task_info->timer_setup) {
+		timer_setup(&task_info->serv_timer, nbl_dev_ctrl_task_timer, 0);
+		task_info->serv_timer_period = HZ;
+	}
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, &task_info->clean_adminq_task);
+
+	return 0;
+}
+
+static void nbl_dev_remove_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, NULL);
+
+	nbl_common_release_task(&task_info->clean_abnormal_irq_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_RESET_CAP))
+		nbl_common_release_delayed_task(&task_info->fw_reset_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP))
+		nbl_common_release_task(&task_info->fw_hb_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_ADMINDQ_CAP))
+		nbl_common_release_task(&task_info->clean_adminq_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER))
+		nbl_common_release_task(&task_info->adapt_desc_gother_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS))
+		nbl_common_release_task(&task_info->recovery_abnormal_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CTRL_CAP))
+		nbl_common_release_task(&task_info->reset_task);
+}
+
+static int nbl_dev_update_template_config(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->update_template_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+/* ----------  Dev init process  ---------- */
+static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *common_dev;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int board_id;
+
+	common_dev = devm_kzalloc(NBL_ADAPTER_TO_DEV(adapter),
+				  sizeof(struct nbl_dev_common), GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
+		goto setup_chan_fail;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_alloc_task(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_alloc_task(&common_dev->reset_task.task, &nbl_dev_prepare_reset_task);
+
+	if (param->caps.is_nic) {
+		board_id = serv_ops->get_board_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+		if (board_id < 0)
+			goto get_board_id_fail;
+		NBL_COMMON_TO_BOARD_ID(common) = board_id;
+	}
+
+	NBL_COMMON_TO_VSI_ID(common) = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0,
+							    NBL_VSI_DATA);
+
+	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_COMMON_TO_VSI_ID(common),
+			     &NBL_COMMON_TO_ETH_MODE(common), &NBL_COMMON_TO_ETH_ID(common),
+			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, &common_dev->clean_mbx_task);
+
+	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = common_dev;
+
+	nbl_dev_register_common_irq(dev_mgt);
+
+	return 0;
+
+get_board_id_fail:
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_release_task(&common_dev->reset_task.task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_release_task(&common_dev->clean_mbx_task);
+setup_chan_fail:
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
+	return -EFAULT;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+
+	if (!common_dev)
+		return;
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_release_task(&common_dev->reset_task.task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_release_task(&common_dev->clean_mbx_task);
+
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
+	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = NULL;
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int i, ret = 0;
+	u32 board_key;
+	char part_number[50] = "";
+	char serial_number[128] = "";
+	int board_id;
+
+	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
+			dev_mgt->common->pdev->bus->number;
+	if (param->caps.is_nic) {
+		board_id =
+			nbl_dev_alloc_board_id(&board_id_table, board_key);
+		if (board_id < 0)
+			return -ENOSPC;
+		NBL_COMMON_TO_BOARD_ID(common) =  board_id;
+	}
+
+	dev_info(dev, "board_key 0x%x alloc board id 0x%x\n",
+		 board_key, NBL_COMMON_TO_BOARD_ID(common));
+
+	ctrl_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_ctrl), GFP_KERNEL);
+	if (!ctrl_dev)
+		goto alloc_fail;
+	NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev)->adapter = adapter;
+	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = ctrl_dev;
+
+	nbl_dev_register_ctrl_irq(dev_mgt);
+
+	ctrl_dev->ctrl_dev_wq1 = create_singlethread_workqueue("nbl_ctrldev_wq1");
+	if (!ctrl_dev->ctrl_dev_wq1) {
+		dev_err(dev, "Failed to create workqueue nbl_ctrldev_wq1\n");
+		goto alloc_wq_fail;
+	}
+
+	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "ctrl dev chip_init failed\n");
+		goto chip_init_fail;
+	}
+
+	ret = serv_ops->start_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "ctrl dev start_mgt_flow failed\n");
+		goto mgt_flow_fail;
+	}
+
+	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
+		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
+		if (ret) {
+			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
+				goto setup_chan_q_fail;
+		}
+	}
+
+	nbl_dev_ctrl_register_flr_chan_msg(dev_mgt);
+	nbl_dev_ctrl_register_emp_ext_alert_chan_msg(dev_mgt);
+
+	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+	if (ret) {
+		dev_err(dev, "ctrl dev setup chan queue failed\n");
+			goto setup_chan_q_fail;
+	}
+
+	ret = nbl_dev_setup_ctrl_dev_task(dev_mgt);
+	if (ret) {
+		dev_err(dev, "ctrl dev task failed\n");
+		goto setup_ctrl_dev_task_fail;
+	}
+
+	serv_ops->get_part_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), part_number);
+	serv_ops->get_serial_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), serial_number);
+	dev_info(dev, "part number: %s, serial number: %s\n", part_number, serial_number);
+
+	nbl_dev_update_template_config(dev_mgt);
+
+	return 0;
+
+setup_ctrl_dev_task_fail:
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+setup_chan_q_fail:
+	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+mgt_flow_fail:
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+chip_init_fail:
+	destroy_workqueue(ctrl_dev->ctrl_dev_wq1);
+alloc_wq_fail:
+	devm_kfree(dev, ctrl_dev);
+	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = NULL;
+alloc_fail:
+	nbl_dev_free_board_id(&board_id_table, board_key);
+	return ret;
+}
+
+static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ctrl **ctrl_dev = &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u32 board_key;
+
+	if (!*ctrl_dev)
+		return;
+
+	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
+			dev_mgt->common->pdev->bus->number;
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+	nbl_dev_remove_ctrl_dev_task(dev_mgt);
+
+	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	destroy_workqueue((*ctrl_dev)->ctrl_dev_wq1);
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), *ctrl_dev);
+	*ctrl_dev = NULL;
+
+	/* If it is not nic, this free function will do nothing, so no need check */
+	nbl_dev_free_board_id(&board_id_table, board_key);
+}
+
+static int nbl_dev_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_open(netdev);
+}
+
+static int nbl_dev_netdev_stop(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_stop(netdev);
+}
+
+static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
+
+	return pt_ops->start_xmit(skb, netdev);
+}
+
+static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_stats64(netdev, stats);
+}
+
+static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->rx_add_vid(netdev, proto, vid);
+}
+
+static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->rx_kill_vid(netdev, proto, vid);
+}
+
+static const struct net_device_ops netdev_ops_leonis_pf = {
+	.ndo_open = nbl_dev_netdev_open,
+	.ndo_stop = nbl_dev_netdev_stop,
+	.ndo_start_xmit = nbl_dev_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+
+};
+
+static const struct net_device_ops netdev_ops_leonis_vf = {
+	.ndo_open = nbl_dev_netdev_open,
+	.ndo_stop = nbl_dev_netdev_stop,
+	.ndo_start_xmit = nbl_dev_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+
+};
+
+static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
+				       struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	bool is_vf = param->caps.is_vf;
+
+	if (is_vf) {
+		netdev->netdev_ops = &netdev_ops_leonis_vf;
+	} else {
+		netdev->netdev_ops = &netdev_ops_leonis_pf;
+		serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 &netdev_ops_leonis_pf, true);
+	}
+	return 0;
+}
+
+static void nbl_dev_remove_netops(struct net_device *netdev)
+{
+	netdev->netdev_ops = NULL;
+}
+
+static void nbl_dev_set_eth_mac_addr(struct nbl_dev_mgt *dev_mgt, struct net_device *netdev)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	u8 mac[ETH_ALEN];
+
+	ether_addr_copy(mac, netdev->dev_addr);
+	serv_ops->set_eth_mac_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				   mac, NBL_COMMON_TO_ETH_ID(common));
+}
+
+static int nbl_dev_cfg_netdev(struct net_device *netdev, struct nbl_dev_mgt *dev_mgt,
+			      struct nbl_init_param *param,
+			      struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net_ops *net_dev_ops = NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt);
+	u64 vlan_features = 0;
+	int ret = 0;
+
+	if (param->pci_using_dac)
+		netdev->features |= NETIF_F_HIGHDMA;
+	netdev->watchdog_timeo = 5 * HZ;
+
+	vlan_features = register_result->vlan_features ? register_result->vlan_features
+							: register_result->features;
+	netdev->hw_features |= nbl_features_to_netdev_features(register_result->hw_features);
+	netdev->features |= nbl_features_to_netdev_features(register_result->features);
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
+	serv_ops->set_spoof_check_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev->perm_addr);
+
+	netdev->needed_headroom = serv_ops->get_tx_headroom(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
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
+static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(NBL_DEV_MGT_TO_COMMON(dev_mgt));
+#ifdef CONFIG_PCI_IOV
+	struct resource *res;
+#endif
+	u16 pf_bdf;
+	u64 pf_bar_start;
+	u64 vf_bar_start, vf_bar_size;
+	u16 total_vfs = 0, offset, stride;
+	int pos;
+	u32 val;
+	struct nbl_register_net_param register_param = {0};
+	int ret = 0;
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &val);
+	pf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + 4, &val);
+	pf_bar_start |= ((u64)val << 32);
+
+	register_param.pf_bar_start = pf_bar_start;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		pf_bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_STRIDE, &stride);
+		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF, &total_vfs);
+
+		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR, &val);
+		vf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR + 4, &val);
+		vf_bar_start |= ((u64)val << 32);
+
+#ifdef CONFIG_PCI_IOV
+		res = &pdev->resource[PCI_IOV_RESOURCES];
+		vf_bar_size = resource_size(res);
+#else
+		vf_bar_size = 0;
+#endif
+		if (total_vfs) {
+			register_param.pf_bdf = pf_bdf;
+			register_param.vf_bar_start = vf_bar_start;
+			register_param.vf_bar_size = vf_bar_size;
+			register_param.total_vfs = total_vfs;
+			register_param.offset = offset;
+			register_param.stride = stride;
+		}
+	}
+
+	net_dev->total_vfs = total_vfs;
+
+	ret = serv_ops->register_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     &register_param, register_result);
+
+	if (!register_result->tx_queue_num || !register_result->rx_queue_num)
+		return -EIO;
+
+	return ret;
+}
+
+static void nbl_dev_unregister_net(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret;
+
+	ret = serv_ops->unregister_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret)
+		dev_err(dev, "unregister net failed\n");
+}
+
+static u16 nbl_dev_vsi_alloc_queue(struct nbl_dev_net *net_dev, u16 queue_num)
+{
+	struct nbl_dev_vsi_controller *vsi_ctrl = &net_dev->vsi_ctrl;
+	u16 queue_offset = 0;
+
+	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->total_queue_num)
+		return -ENOSPC;
+
+	queue_offset = vsi_ctrl->queue_free_offset;
+	vsi_ctrl->queue_free_offset += queue_num;
+
+	return queue_offset;
+}
+
+static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				    struct nbl_dev_vsi *vsi)
+{
+	int ret = 0;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_vsi_param vsi_param = {0};
+
+	vsi->queue_offset = nbl_dev_vsi_alloc_queue(NBL_DEV_MGT_TO_NET_DEV(dev_mgt),
+						    vsi->queue_num);
+	vsi_param.index = vsi->index;
+	vsi_param.vsi_id = vsi->vsi_id;
+	vsi_param.queue_offset = vsi->queue_offset;
+	vsi_param.queue_num = vsi->queue_num;
+
+	/* Tell serv & res layer the mapping from vsi to queue_id */
+	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &vsi_param);
+	return ret;
+}
+
+static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
+{
+}
+
+static int nbl_dev_vsi_common_start(struct nbl_dev_mgt *dev_mgt, struct net_device *netdev,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret;
+
+	vsi->napi_netdev = netdev;
+
+	ret = serv_ops->setup_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup q2vsi failed\n");
+		goto set_q2vsi_fail;
+	}
+
+	ret = serv_ops->setup_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss failed\n");
+		goto set_rss_fail;
+	}
+
+	ret = serv_ops->setup_rss_indir(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	if (ret) {
+		dev_err(dev, "Setup rss indir failed\n");
+		goto setup_rss_indir_fail;
+	}
+
+	if (vsi->use_independ_irq) {
+		ret = serv_ops->enable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
+		if (ret) {
+			dev_err(dev, "Enable napis failed\n");
+			goto enable_napi_fail;
+		}
+	}
+
+	ret = serv_ops->init_tx_rate(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
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
+static void nbl_dev_vsi_common_stop(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (vsi->use_independ_irq)
+		serv_ops->disable_napis(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
+	serv_ops->remove_rss(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	serv_ops->remove_q2vsi(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+}
+
+static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int ret = 0;
+
+	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
+	if (ret)
+		return ret;
+
+	vsi->queue_num = vsi->register_result.tx_queue_num;
+	vsi->queue_size = vsi->register_result.queue_size;
+
+	nbl_debug(common, NBL_DEBUG_VSI, "Data vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+
+	return 0;
+}
+
+static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
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
+	ret = serv_ops->start_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev, vsi->vsi_id, vid,
+				       vsi->register_result.trusted);
+	if (ret) {
+		dev_err(dev, "Set netdev flow table failed\n");
+		goto set_flow_fail;
+	}
+
+	if (!NBL_COMMON_TO_VF_CAP(common)) {
+		ret = serv_ops->set_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
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
+		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
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
+		serv_ops->remove_lldp_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+		vsi->feature.has_lldp = false;
+	}
+
+	serv_ops->stop_net_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+}
+
+static int nbl_dev_vsi_data_netdev_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+					 struct net_device *netdev, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	vsi->netdev = netdev;
+	return nbl_dev_cfg_netdev(netdev, dev_mgt, param, &vsi->register_result);
+}
+
+static void nbl_dev_vsi_data_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_reset_netdev(vsi->netdev);
+}
+
+static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     &vsi->queue_num, &vsi->queue_size);
+
+	nbl_debug(common, NBL_DEBUG_VSI, "Ctrl vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+	return 0;
+}
+
+static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
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
+	int ret = 0;
+
+	ret = nbl_dev_vsi_common_start(dev_mgt, netdev, vsi);
+	if (ret)
+		goto start_fail;
+
+	/* For ctrl vsi, open it after create, for that we don't have ndo_open ops. */
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
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)dev_priv;
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->vsi_stop(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->index);
+	nbl_dev_vsi_common_stop(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_ctrl_netdev_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+					 struct net_device *netdev, void *vsi_data)
+{
+	return 0;
+}
+
+static void nbl_dev_vsi_ctrl_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+}
+
+static int nbl_dev_vsi_user_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_user_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				      &vsi->queue_num, &vsi->queue_size,
+				      NBL_COMMON_TO_VSI_ID(common));
+
+	nbl_debug(common, NBL_DEBUG_VSI, "User vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+	return 0;
+}
+
+static int nbl_dev_vsi_user_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_user_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_user_start(void *dev_priv, struct net_device *netdev,
+				  void *vsi_data)
+{
+	return 0;
+}
+
+static void nbl_dev_vsi_user_stop(void *dev_priv, void *vsi_data)
+{
+}
+
+static int nbl_dev_vsi_user_netdev_build(struct nbl_dev_mgt *dev_mgt,
+					 struct nbl_init_param *param,
+					 struct net_device *netdev, void *vsi_data)
+{
+	return 0;
+}
+
+static void nbl_dev_vsi_user_netdev_destroy(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	/* nothing need to do */
+}
+
+static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
+	[NBL_VSI_DATA] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_data_register,
+			.setup = nbl_dev_vsi_data_setup,
+			.remove = nbl_dev_vsi_data_remove,
+			.start = nbl_dev_vsi_data_start,
+			.stop = nbl_dev_vsi_data_stop,
+			.netdev_build = nbl_dev_vsi_data_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_data_netdev_destroy,
+		},
+		.vf_support = true,
+		.only_nic_support = false,
+		.in_kernel = true,
+		.use_independ_irq = true,
+		.static_queue = true,
+	},
+	[NBL_VSI_CTRL] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_ctrl_register,
+			.setup = nbl_dev_vsi_ctrl_setup,
+			.remove = nbl_dev_vsi_ctrl_remove,
+			.start = nbl_dev_vsi_ctrl_start,
+			.stop = nbl_dev_vsi_ctrl_stop,
+			.netdev_build = nbl_dev_vsi_ctrl_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_ctrl_netdev_destroy,
+		},
+		.vf_support = false,
+		.only_nic_support = true,
+		.in_kernel = true,
+		.use_independ_irq = true,
+		.static_queue = true,
+	},
+	[NBL_VSI_USER] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_user_register,
+			.setup = nbl_dev_vsi_user_setup,
+			.remove = nbl_dev_vsi_user_remove,
+			.start = nbl_dev_vsi_user_start,
+			.stop = nbl_dev_vsi_user_stop,
+			.netdev_build = nbl_dev_vsi_user_netdev_build,
+			.netdev_destroy = nbl_dev_vsi_user_netdev_destroy,
+		},
+		.vf_support = false,
+		.only_nic_support = true,
+		.in_kernel = false,
+		.use_independ_irq = false,
+		.static_queue = false,
+	},
+};
+
+static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_vsi *vsi = NULL;
+	int i;
+
+	net_dev->vsi_ctrl.queue_num = 0;
+	net_dev->vsi_ctrl.queue_free_offset = 0;
+
+	/* Build all vsi, and alloc vsi_id for each of them */
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		if ((param->caps.is_vf && !vsi_tbl[i].vf_support) ||
+		    (!param->caps.is_nic && vsi_tbl[i].only_nic_support))
+			continue;
+
+		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi), GFP_KERNEL);
+		if (!vsi)
+			goto malloc_vsi_fail;
+
+		vsi->ops = &vsi_tbl[i].vsi_ops;
+		vsi->vsi_id = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0, i);
+		vsi->index = i;
+		vsi->in_kernel = vsi_tbl[i].in_kernel;
+		vsi->use_independ_irq = vsi_tbl[i].use_independ_irq;
+		vsi->static_queue = vsi_tbl[i].static_queue;
+		net_dev->vsi_ctrl.vsi_list[i] = vsi;
+	}
+
+	return 0;
+
+malloc_vsi_fail:
+	while (--i + 1) {
+		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
+		net_dev->vsi_ctrl.vsi_list[i] = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static void nbl_dev_vsi_destroy(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	int i;
+
+	for (i = 0; i < NBL_VSI_MAX; i++)
+		if (net_dev->vsi_ctrl.vsi_list[i]) {
+			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
+			net_dev->vsi_ctrl.vsi_list[i] = NULL;
+		}
+}
+
+struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi = NULL;
+	int i = 0;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = net_dev->vsi_ctrl.vsi_list[i];
+		if (vsi && vsi->index == vsi_index)
+			return vsi;
+	}
+
+	return NULL;
+}
+
+static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0,
+		      st_dev->real_st_name, sizeof(st_dev->real_st_name), 1);
+	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+}
+
+static void nbl_dev_chan_get_st_name_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(dev_mgt->common);
+	struct nbl_chan_ack_info chan_ack;
+	int ret;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id,
+		     0, st_dev->st_name, sizeof(st_dev->st_name));
+	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
+	if (ret)
+		dev_err(dev, "channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_ST_NAME);
+}
+
+static void nbl_dev_register_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_GET_ST_NAME,
+			       nbl_dev_chan_get_st_name_resp, dev_mgt);
+	st_dev->resp_msg_registered = true;
+}
+
+static void nbl_dev_unregister_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!st_dev->resp_msg_registered)
+		return;
+
+	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_MSG_GET_ST_NAME);
+}
+
+static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
+	{
+		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
+	},
+};
+
+static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
+{
+	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
+}
+
+static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_dev_vsi *vsi;
+	int i, ret = 0;
+	u16 total_queue_num = 0, kernel_queue_num = 0, user_queue_num = 0;
+	u16 dynamic_queue_max = 0, irq_queue_num = 0;
+
+	*net_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_net), GFP_KERNEL);
+	if (!*net_dev)
+		return -ENOMEM;
+
+	ret = nbl_dev_vsi_build(dev_mgt, param);
+	if (ret)
+		goto vsi_build_fail;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		ret = vsi->ops->register_vsi(dev_mgt, param, vsi);
+		if (ret) {
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d register failed", vsi->index);
+			goto vsi_register_fail;
+		}
+
+		if (vsi->static_queue) {
+			total_queue_num += vsi->queue_num;
+		} else {
+			if (dynamic_queue_max < vsi->queue_num)
+				dynamic_queue_max = vsi->queue_num;
+		}
+
+		if (vsi->use_independ_irq)
+			irq_queue_num += vsi->queue_num;
+
+		if (vsi->in_kernel)
+			kernel_queue_num += vsi->queue_num;
+		else
+			user_queue_num += vsi->queue_num;
+	}
+
+	/* all vsi's dynamic only support enable use one at the same time. */
+	total_queue_num += dynamic_queue_max;
+
+	/* the total queue set must before vsi stepup */
+	(*net_dev)->total_queue_num = total_queue_num;
+	(*net_dev)->kernel_queue_num = kernel_queue_num;
+	(*net_dev)->user_queue_num = user_queue_num;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		if (!vsi->in_kernel)
+			continue;
+
+		ret = vsi->ops->setup(dev_mgt, param, vsi);
+		if (ret) {
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d setup failed", vsi->index);
+			goto vsi_setup_fail;
+		}
+	}
+
+	nbl_dev_register_net_irq(dev_mgt, irq_queue_num);
+
+	nbl_det_setup_net_dev_ops(dev_mgt, param);
+
+	return 0;
+
+vsi_setup_fail:
+vsi_register_fail:
+	nbl_dev_vsi_destroy(dev_mgt);
+vsi_build_fail:
+	devm_kfree(dev, *net_dev);
+	return ret;
+}
+
+static void nbl_dev_remove_net_dev(struct nbl_adapter *adapter)
+{
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	int i = 0;
+
+	if (!*net_dev)
+		return;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		vsi->ops->remove(dev_mgt, vsi);
+	}
+	nbl_dev_vsi_destroy(dev_mgt);
 
-};
+	nbl_dev_unregister_net(dev_mgt);
 
-static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
-				       struct nbl_init_param *param)
+	devm_kfree(dev, *net_dev);
+	*net_dev = NULL;
+}
+
+static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	int ret;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	bool is_vf = param->caps.is_vf;
+	struct nbl_dev_st_dev *st_dev;
 
-	if (is_vf) {
-		netdev->netdev_ops = &netdev_ops_leonis_vf;
+	/* unify restool's chardev for leonis/draco/rnic400. all pf create chardev */
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+		return 0;
+
+	st_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_st_dev), GFP_KERNEL);
+	if (!st_dev)
+		return -ENOMEM;
+
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = st_dev;
+	ret = serv_ops->setup_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 nbl_get_st_table(), st_dev->st_name);
+	if (ret) {
+		dev_err(dev, "create resource char dev failed\n");
+		goto alloc_chardev_failed;
+	}
+
+	if (param->caps.has_ctrl) {
+		nbl_dev_register_get_st_name_chan_msg(dev_mgt);
 	} else {
-		netdev->netdev_ops = &netdev_ops_leonis_pf;
-		serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					 &netdev_ops_leonis_pf, true);
+		ret = nbl_dev_chan_get_st_name_req(dev_mgt);
+		if (!ret)
+			serv_ops->register_real_st_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+							st_dev->real_st_name);
+		else
+			dev_err(dev, "get real resource char dev failed\n");
 	}
+
 	return 0;
+alloc_chardev_failed:
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
+	return -1;
 }
 
-static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
-				struct nbl_register_net_result *register_result)
+static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter)
 {
-	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(NBL_DEV_MGT_TO_COMMON(dev_mgt));
-#ifdef CONFIG_PCI_IOV
-	struct resource *res;
-#endif
-	u16 pf_bdf;
-	u64 pf_bar_start;
-	u64 vf_bar_start, vf_bar_size;
-	u16 total_vfs = 0, offset, stride;
-	int pos;
-	u32 val;
-	struct nbl_register_net_param register_param = {0};
-	int ret = 0;
-
-	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &val);
-	pf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
-	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + 4, &val);
-	pf_bar_start |= ((u64)val << 32);
-
-	register_param.pf_bar_start = pf_bar_start;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-	if (pos) {
-		pf_bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
-
-		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
-		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_STRIDE, &stride);
-		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF, &total_vfs);
-
-		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR, &val);
-		vf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
-		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR + 4, &val);
-		vf_bar_start |= ((u64)val << 32);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
 
-#ifdef CONFIG_PCI_IOV
-		res = &pdev->resource[PCI_IOV_RESOURCES];
-		vf_bar_size = resource_size(res);
-#else
-		vf_bar_size = 0;
-#endif
-		if (total_vfs) {
-			register_param.pf_bdf = pf_bdf;
-			register_param.vf_bar_start = vf_bar_start;
-			register_param.vf_bar_size = vf_bar_size;
-			register_param.total_vfs = total_vfs;
-			register_param.offset = offset;
-			register_param.stride = stride;
-		}
-	}
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+		return;
 
-	net_dev->total_vfs = total_vfs;
+	nbl_dev_unregister_get_st_name_chan_msg(dev_mgt);
+	serv_ops->remove_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), nbl_get_st_table());
 
-	ret = serv_ops->register_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-				     &register_param, register_result);
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
+}
 
-	if (!register_result->tx_queue_num || !register_result->rx_queue_num)
-		return -EIO;
+static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
+{
+	*dev_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(struct nbl_dev_mgt), GFP_KERNEL);
+	if (!*dev_mgt)
+		return -ENOMEM;
 
-	return ret;
+	NBL_DEV_MGT_TO_COMMON(*dev_mgt) = common;
+	return 0;
 }
 
-static void nbl_dev_unregister_net(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_remove_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
 {
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
-	int ret;
-
-	ret = serv_ops->unregister_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
-	if (ret)
-		dev_err(dev, "unregister net failed\n");
+	devm_kfree(NBL_COMMON_TO_DEV(common), *dev_mgt);
+	*dev_mgt = NULL;
 }
 
-static u16 nbl_dev_vsi_alloc_queue(struct nbl_dev_net *net_dev, u16 queue_num)
+static void nbl_dev_remove_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl)
 {
-	struct nbl_dev_vsi_controller *vsi_ctrl = &net_dev->vsi_ctrl;
-	u16 queue_offset = 0;
+	devm_kfree(dev, *dev_ops_tbl);
+	*dev_ops_tbl = NULL;
+}
 
-	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->total_queue_num)
-		return -ENOSPC;
+static int nbl_dev_setup_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl,
+			     struct nbl_adapter *adapter)
+{
+	*dev_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dev_ops_tbl), GFP_KERNEL);
+	if (!*dev_ops_tbl)
+		return -ENOMEM;
 
-	queue_offset = vsi_ctrl->queue_free_offset;
-	vsi_ctrl->queue_free_offset += queue_num;
+	NBL_DEV_OPS_TBL_TO_OPS(*dev_ops_tbl) = &dev_ops;
+	NBL_DEV_OPS_TBL_TO_PRIV(*dev_ops_tbl) = adapter;
 
-	return queue_offset;
+	return 0;
 }
 
-static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				    struct nbl_dev_vsi *vsi)
+int nbl_dev_init(void *p, struct nbl_init_param *param)
 {
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
+	struct nbl_service_ops_tbl *serv_ops_tbl = NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
+	struct nbl_channel_ops_tbl *chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
 	int ret = 0;
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_vsi_param vsi_param = {0};
 
-	vsi->queue_offset = nbl_dev_vsi_alloc_queue(NBL_DEV_MGT_TO_NET_DEV(dev_mgt),
-						    vsi->queue_num);
-	vsi_param.index = vsi->index;
-	vsi_param.vsi_id = vsi->vsi_id;
-	vsi_param.queue_offset = vsi->queue_offset;
-	vsi_param.queue_num = vsi->queue_num;
+	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
+	if (ret)
+		goto setup_mgt_fail;
 
-	/* Tell serv & res layer the mapping from vsi to queue_id */
-	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &vsi_param);
-	return ret;
-}
+	NBL_DEV_MGT_TO_SERV_OPS_TBL(*dev_mgt) = serv_ops_tbl;
+	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
 
-static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
-{
-}
+	ret = nbl_dev_setup_common_dev(adapter, param);
+	if (ret)
+		goto setup_common_dev_fail;
 
-static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				     void *vsi_data)
-{
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
-	int ret = 0;
+	if (param->caps.has_ctrl) {
+		ret = nbl_dev_setup_ctrl_dev(adapter, param);
+		if (ret)
+			goto setup_ctrl_dev_fail;
+	}
 
-	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
+	ret = nbl_dev_setup_net_dev(adapter, param);
 	if (ret)
-		return ret;
+		goto setup_net_dev_fail;
 
-	vsi->queue_num = vsi->register_result.tx_queue_num;
-	vsi->queue_size = vsi->register_result.queue_size;
+	ret = nbl_dev_setup_st_dev(adapter, param);
+	if (ret)
+		goto setup_st_dev_fail;
 
-	nbl_debug(common, NBL_DEBUG_VSI, "Data vsi register, queue_num %d, queue_size %d",
-		  vsi->queue_num, vsi->queue_size);
+	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
+	if (ret)
+		goto setup_ops_fail;
 
 	return 0;
+
+setup_ops_fail:
+	nbl_dev_remove_st_dev(adapter);
+setup_st_dev_fail:
+	nbl_dev_remove_net_dev(adapter);
+setup_net_dev_fail:
+	nbl_dev_remove_ctrl_dev(adapter);
+setup_ctrl_dev_fail:
+	nbl_dev_remove_common_dev(adapter);
+setup_common_dev_fail:
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
+setup_mgt_fail:
+	return ret;
 }
 
-static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				  void *vsi_data)
+void nbl_dev_remove(void *p)
 {
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
 
-	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
-}
+	nbl_dev_remove_ops(dev, dev_ops_tbl);
 
-static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
-{
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	nbl_dev_remove_st_dev(adapter);
+	nbl_dev_remove_net_dev(adapter);
+	nbl_dev_remove_ctrl_dev(adapter);
+	nbl_dev_remove_common_dev(adapter);
 
-	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
 }
 
-static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				     void *vsi_data)
+static void nbl_dev_notify_dev_prepare_reset(struct nbl_dev_mgt *dev_mgt,
+					     enum nbl_reset_event event)
 {
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int func_num = 0;
+	unsigned long cur_func = 0;
+	unsigned long next_func = 0;
+	unsigned long *func_bitmap;
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	func_bitmap = devm_kcalloc(NBL_COMMON_TO_DEV(common), BITS_TO_LONGS(NBL_MAX_FUNC),
+				   sizeof(long), GFP_KERNEL);
+	if (!func_bitmap)
+		return;
 
-	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-				     &vsi->queue_num, &vsi->queue_size);
+	serv_ops->get_active_func_bitmaps(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), func_bitmap,
+					  NBL_MAX_FUNC);
+	memset(dev_mgt->ctrl_dev->task_info.reset_status, 0,
+	       sizeof(dev_mgt->ctrl_dev->task_info.reset_status));
+	/* clear ctrl_dev func_id, and do it last */
+	clear_bit(NBL_COMMON_TO_MGT_PF(common), func_bitmap);
+
+	cur_func = NBL_COMMON_TO_MGT_PF(common);
+	while (1) {
+		next_func = find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
+		if (next_func >= NBL_MAX_FUNC)
+			break;
 
-	nbl_debug(common, NBL_DEBUG_VSI, "Ctrl vsi register, queue_num %d, queue_size %d",
-		  vsi->queue_num, vsi->queue_size);
-	return 0;
-}
+		cur_func = next_func;
+		dev_mgt->ctrl_dev->task_info.reset_status[cur_func] = NBL_RESET_SEND;
+		NBL_CHAN_SEND(chan_send, cur_func, NBL_CHAN_MSG_NOTIFY_RESET_EVENT, &event,
+			      sizeof(event), NULL, 0, 0);
+		chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+		func_num++;
+		if (func_num >= NBL_DEV_BATCH_RESET_FUNC_NUM) {
+			usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
+			func_num = 0;
+		}
+	}
 
-static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				  void *vsi_data)
-{
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	if (func_num)
+		usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
 
-	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
-}
+	/* ctrl dev need proc last, basecase reset task will close mailbox */
+	dev_mgt->ctrl_dev->task_info.reset_status[NBL_COMMON_TO_MGT_PF(common)] = NBL_RESET_SEND;
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+		      NULL, 0, NULL, 0, 0);
+	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+	usleep_range(NBL_DEV_BATCH_RESET_USEC, NBL_DEV_BATCH_RESET_USEC * 2);
 
-static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
-{
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	cur_func = NBL_COMMON_TO_MGT_PF(common);
+	while (1) {
+		if (dev_mgt->ctrl_dev->task_info.reset_status[cur_func] == NBL_RESET_SEND)
+			nbl_info(common, NBL_DEBUG_MAIN, "func %ld reset failed", cur_func);
 
-	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+		next_func = find_next_bit(func_bitmap, NBL_MAX_FUNC, cur_func + 1);
+		if (next_func >= NBL_MAX_FUNC)
+			break;
+
+		cur_func = next_func;
+	}
+
+	devm_kfree(NBL_COMMON_TO_DEV(common), func_bitmap);
 }
 
-static int nbl_dev_vsi_user_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				     void *vsi_data)
+static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt)
 {
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_chan_param_notify_fw_reset_info fw_reset = {0};
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev_mgt->net_dev->netdev);
 	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_chan_send_info chan_send;
 
-	serv_ops->get_user_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-				      &vsi->queue_num, &vsi->queue_size,
-				      NBL_COMMON_TO_VSI_ID(common));
+	if (test_and_set_bit(NBL_FATAL_ERR, adapter->state)) {
+		nbl_info(common, NBL_DEBUG_MAIN, "dev in fatal_err status already.");
+		return;
+	}
 
-	nbl_debug(common, NBL_DEBUG_VSI, "User vsi register, queue_num %d, queue_size %d",
-		  vsi->queue_num, vsi->queue_size);
-	return 0;
-}
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+	nbl_dev_ctrl_task_stop(dev_mgt);
+	nbl_dev_notify_dev_prepare_reset(dev_mgt, NBL_HW_FATAL_ERR_EVENT);
 
-static int nbl_dev_vsi_user_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
-				  void *vsi_data)
-{
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	/* notify emp shutdown dev */
+	fw_reset.type = NBL_FW_HIGH_TEMP_RESET;
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_NOTIFY_FW_RESET, &fw_reset, sizeof(fw_reset), NULL, 0, 0);
+	chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
 
-	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+				  NBL_CHAN_TYPE_ADMINQ, true);
+	serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
+	nbl_info(common, NBL_DEBUG_MAIN, "dev in fatal_err status.");
 }
 
-static void nbl_dev_vsi_user_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+/* ----------  Dev start process  ---------- */
+static int nbl_dev_start_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
-	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	int err = 0;
 
-	nbl_dev_vsi_common_remove(dev_mgt, vsi);
-}
+	err = nbl_dev_request_abnormal_irq(dev_mgt);
+	if (err)
+		goto abnormal_request_irq_err;
 
-static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
-	[NBL_VSI_DATA] = {
-		.vsi_ops = {
-			.register_vsi = nbl_dev_vsi_data_register,
-			.setup = nbl_dev_vsi_data_setup,
-			.remove = nbl_dev_vsi_data_remove,
-		},
-		.vf_support = true,
-		.only_nic_support = false,
-		.in_kernel = true,
-		.use_independ_irq = true,
-		.static_queue = true,
-	},
-	[NBL_VSI_CTRL] = {
-		.vsi_ops = {
-			.register_vsi = nbl_dev_vsi_ctrl_register,
-			.setup = nbl_dev_vsi_ctrl_setup,
-			.remove = nbl_dev_vsi_ctrl_remove,
-		},
-		.vf_support = false,
-		.only_nic_support = true,
-		.in_kernel = true,
-		.use_independ_irq = true,
-		.static_queue = true,
-	},
-	[NBL_VSI_USER] = {
-		.vsi_ops = {
-			.register_vsi = nbl_dev_vsi_user_register,
-			.setup = nbl_dev_vsi_user_setup,
-			.remove = nbl_dev_vsi_user_remove,
-		},
-		.vf_support = false,
-		.only_nic_support = true,
-		.in_kernel = false,
-		.use_independ_irq = false,
-		.static_queue = false,
-	},
-};
+	err = nbl_dev_enable_abnormal_irq(dev_mgt);
+	if (err)
+		goto enable_abnormal_irq_err;
 
-static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
-{
-	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_dev_vsi *vsi = NULL;
-	int i;
+	err = nbl_dev_request_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
+	if (err)
+		goto request_adminq_irq_err;
 
-	net_dev->vsi_ctrl.queue_num = 0;
-	net_dev->vsi_ctrl.queue_free_offset = 0;
+	err = nbl_dev_enable_adminq_irq(dev_mgt);
+	if (err)
+		goto enable_adminq_irq_err;
 
-	/* Build all vsi, and alloc vsi_id for each of them */
-	for (i = 0; i < NBL_VSI_MAX; i++) {
-		if ((param->caps.is_vf && !vsi_tbl[i].vf_support) ||
-		    (!param->caps.is_nic && vsi_tbl[i].only_nic_support))
-			continue;
+	nbl_dev_get_port_attributes(dev_mgt);
+	nbl_dev_init_port(dev_mgt);
+	nbl_dev_enable_port(dev_mgt, true);
+	nbl_dev_ctrl_task_start(dev_mgt);
 
-		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi), GFP_KERNEL);
-		if (!vsi)
-			goto malloc_vsi_fail;
+	return 0;
 
-		vsi->ops = &vsi_tbl[i].vsi_ops;
-		vsi->vsi_id = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0, i);
-		vsi->index = i;
-		vsi->in_kernel = vsi_tbl[i].in_kernel;
-		vsi->use_independ_irq = vsi_tbl[i].use_independ_irq;
-		vsi->static_queue = vsi_tbl[i].static_queue;
-		net_dev->vsi_ctrl.vsi_list[i] = vsi;
-	}
+enable_adminq_irq_err:
+	nbl_dev_free_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
+request_adminq_irq_err:
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+enable_abnormal_irq_err:
+	nbl_dev_free_abnormal_irq(dev_mgt);
+abnormal_request_irq_err:
+	return err;
+}
 
-	return 0;
+static void nbl_dev_stop_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
 
-malloc_vsi_fail:
-	while (--i + 1) {
-		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
-		net_dev->vsi_ctrl.vsi_list[i] = NULL;
-	}
+	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
+		return;
 
-	return -ENOMEM;
+	nbl_dev_ctrl_task_stop(dev_mgt);
+	nbl_dev_enable_port(dev_mgt, false);
+	nbl_dev_disable_adminq_irq(dev_mgt);
+	nbl_dev_free_adminq_irq(dev_mgt, &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)->task_info);
+	nbl_dev_disable_abnormal_irq(dev_mgt);
+	nbl_dev_free_abnormal_irq(dev_mgt);
 }
 
-static void nbl_dev_vsi_destroy(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_chan_notify_link_state_resp(void *priv, u16 src_id, u16 msg_id,
+						void *data, u32 data_len)
 {
-	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
-	int i;
+	struct net_device *netdev = (struct net_device *)priv;
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_chan_param_notify_link_state *link_info;
 
-	for (i = 0; i < NBL_VSI_MAX; i++)
-		if (net_dev->vsi_ctrl.vsi_list[i]) {
-			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
-			net_dev->vsi_ctrl.vsi_list[i] = NULL;
-		}
+	link_info = (struct nbl_chan_param_notify_link_state *)data;
+
+	serv_ops->set_netdev_carrier_state(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   netdev, link_info->link_state);
 }
 
-struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index)
+static void nbl_dev_register_link_state_chan_msg(struct nbl_dev_mgt *dev_mgt,
+						 struct net_device *netdev)
 {
-	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
-	struct nbl_dev_vsi *vsi = NULL;
-	int i = 0;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 
-	for (i = 0; i < NBL_VSI_MAX; i++) {
-		vsi = net_dev->vsi_ctrl.vsi_list[i];
-		if (vsi && vsi->index == vsi_index)
-			return vsi;
-	}
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
 
-	return NULL;
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+			       nbl_dev_chan_notify_link_state_resp, netdev);
 }
 
-static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_chan_notify_reset_event_resp(void *priv, u16 src_id, u16 msg_id,
+						 void *data, u32 data_len)
 {
-	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
-	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	enum nbl_reset_event event = *(enum nbl_reset_event *)data;
 
-	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
-		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0,
-		      st_dev->real_st_name, sizeof(st_dev->real_st_name), 1);
-	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+	dev_mgt->common_dev->reset_task.event = event;
+	nbl_common_queue_work(&dev_mgt->common_dev->reset_task.task, false);
 }
 
-static void nbl_dev_chan_get_st_name_resp(void *priv, u16 src_id, u16 msg_id,
-					  void *data, u32 data_len)
+static void nbl_dev_chan_ack_reset_event_resp(void *priv, u16 src_id, u16 msg_id,
+					      void *data, u32 data_len)
 {
 	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
-	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct device *dev = NBL_COMMON_TO_DEV(dev_mgt->common);
-	struct nbl_chan_ack_info chan_ack;
-	int ret;
 
-	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id,
-		     0, st_dev->st_name, sizeof(st_dev->st_name));
-	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
-	if (ret)
-		dev_err(dev, "channel send ack failed with ret: %d, msg_type: %d\n",
-			ret, NBL_CHAN_MSG_GET_ST_NAME);
+	WRITE_ONCE(dev_mgt->ctrl_dev->task_info.reset_status[src_id], NBL_RESET_DONE);
 }
 
-static void nbl_dev_register_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+static void nbl_dev_register_reset_event_chan_msg(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
 
 	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
 					 NBL_CHAN_TYPE_MAILBOX))
 		return;
 
 	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
-			       NBL_CHAN_MSG_GET_ST_NAME,
-			       nbl_dev_chan_get_st_name_resp, dev_mgt);
-	st_dev->resp_msg_registered = true;
+			       NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+			       nbl_dev_chan_notify_reset_event_resp, dev_mgt);
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ACK_RESET_EVENT,
+			       nbl_dev_chan_ack_reset_event_resp, dev_mgt);
 }
 
-static void nbl_dev_unregister_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+int nbl_dev_setup_vf_config(void *p, int num_vfs)
 {
-	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
-	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
-
-	if (!st_dev->resp_msg_registered)
-		return;
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_MSG_GET_ST_NAME);
+	return serv_ops->setup_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), num_vfs, false);
 }
 
-static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
-	{
-		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
-	},
-};
+void nbl_dev_register_dev_name(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 
-static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
+	/* get pf_name then register it to AF */
+	serv_ops->register_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				    common->vsi_id, net_dev->netdev->name);
+}
+
+void nbl_dev_get_dev_name(void *p, char *dev_name)
 {
-	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	serv_ops->get_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), common->vsi_id, dev_name);
 }
 
-static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+void nbl_dev_remove_vf_config(void *p)
 {
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
-	struct nbl_dev_vsi *vsi;
-	int i, ret = 0;
-	u16 total_queue_num = 0, kernel_queue_num = 0, user_queue_num = 0;
-	u16 dynamic_queue_max = 0, irq_queue_num = 0;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
 
-	*net_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_net), GFP_KERNEL);
-	if (!*net_dev)
-		return -ENOMEM;
+	return serv_ops->remove_vf_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
 
-	ret = nbl_dev_vsi_build(dev_mgt, param);
-	if (ret)
-		goto vsi_build_fail;
+static int nbl_dev_start_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+#ifdef CONFIG_PCI_ATS
+	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(common);
+#endif
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	struct nbl_netdev_priv *net_priv;
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	struct nbl_dev_vsi *user_vsi;
+	struct nbl_ring_param ring_param = {0};
+	u16 net_vector_id, queue_num;
+	int ret;
+	char dev_name[IFNAMSIZ] = {0};
+
+	vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_DATA);
+	if (!vsi)
+		return -EFAULT;
+
+	user_vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_USER);
+	queue_num = vsi->queue_num;
+	netdev = alloc_etherdev_mqs(sizeof(struct nbl_netdev_priv), queue_num, queue_num);
+	if (!netdev) {
+		dev_err(dev, "Alloc net device failed\n");
+		ret = -ENOMEM;
+		goto alloc_netdev_fail;
+	}
 
-	for (i = 0; i < NBL_VSI_MAX; i++) {
-		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+	SET_NETDEV_DEV(netdev, dev);
+	net_priv = netdev_priv(netdev);
+	net_priv->adapter = adapter;
+	nbl_dev_set_netdev_priv(netdev, vsi, user_vsi);
 
-		if (!vsi)
-			continue;
+	net_dev->netdev = netdev;
+	common->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
+	serv_ops->set_mask_en(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), net_msix_mask_en);
 
-		ret = vsi->ops->register_vsi(dev_mgt, param, vsi);
-		if (ret) {
-			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d register failed", vsi->index);
-			goto vsi_register_fail;
-		}
+	ring_param.tx_ring_num = net_dev->kernel_queue_num;
+	ring_param.rx_ring_num = net_dev->kernel_queue_num;
+	ring_param.queue_size = net_priv->queue_size;
+	ret = serv_ops->alloc_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev, &ring_param);
+	if (ret) {
+		dev_err(dev, "Alloc rings failed\n");
+		goto alloc_rings_fail;
+	}
 
-		if (vsi->static_queue) {
-			total_queue_num += vsi->queue_num;
-		} else {
-			if (dynamic_queue_max < vsi->queue_num)
-				dynamic_queue_max = vsi->queue_num;
-		}
+	serv_ops->cpu_affinity_init(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->queue_num);
+	ret = serv_ops->setup_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), netdev,
+					       vsi->register_result.vlan_proto,
+					       vsi->register_result.vlan_tci,
+					       vsi->register_result.rate);
+	if (ret) {
+		dev_err(dev, "setup net mgt failed\n");
+		goto setup_net_mgt_fail;
+	}
 
-		if (vsi->use_independ_irq)
-			irq_queue_num += vsi->queue_num;
+	/* netdev build must before setup_txrx_queues. Because snoop check mac trust the mac
+	 * if pf use ip link cfg the mac for vf. We judge the case will not permit accord queue
+	 * has alloced when vf modify mac.
+	 */
+	ret = vsi->ops->netdev_build(dev_mgt, param, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Build netdev failed, selected vsi %d\n", vsi->index);
+		goto build_netdev_fail;
+	}
 
-		if (vsi->in_kernel)
-			kernel_queue_num += vsi->queue_num;
-		else
-			user_queue_num += vsi->queue_num;
+	net_vector_id = msix_info->serv_info[NBL_MSIX_NET_TYPE].base_vector_id;
+	ret = serv_ops->setup_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  vsi->vsi_id, net_dev->total_queue_num, net_vector_id);
+	if (ret) {
+		dev_err(dev, "Set queue map failed\n");
+		goto set_queue_fail;
 	}
 
-	/* all vsi's dynamic only support enable use one at the same time. */
-	total_queue_num += dynamic_queue_max;
+	ret = serv_ops->init_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "init hw stats failed\n");
+		goto init_hw_stats_fail;
+	}
 
-	/* the total queue set must before vsi stepup */
-	(*net_dev)->total_queue_num = total_queue_num;
-	(*net_dev)->kernel_queue_num = kernel_queue_num;
-	(*net_dev)->user_queue_num = user_queue_num;
+	nbl_dev_register_link_state_chan_msg(dev_mgt, netdev);
+	nbl_dev_register_reset_event_chan_msg(dev_mgt);
 
-	for (i = 0; i < NBL_VSI_MAX; i++) {
-		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+	ret = vsi->ops->start(dev_mgt, netdev, vsi);
+	if (ret) {
+		dev_err(dev, "Start vsi failed, selected vsi %d\n", vsi->index);
+		goto start_vsi_fail;
+	}
 
-		if (!vsi)
-			continue;
+	ret = nbl_dev_request_net_irq(dev_mgt);
+	if (ret) {
+		dev_err(dev, "request irq failed\n");
+		goto request_irq_fail;
+	}
 
-		if (!vsi->in_kernel)
-			continue;
+	netif_carrier_off(netdev);
 
-		ret = vsi->ops->setup(dev_mgt, param, vsi);
-		if (ret) {
-			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d setup failed", vsi->index);
-			goto vsi_setup_fail;
-		}
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(dev, "Register netdev failed\n");
+		goto register_netdev_fail;
 	}
 
-	nbl_dev_register_net_irq(dev_mgt, irq_queue_num);
+	if (!param->caps.is_vf) {
+		if (net_dev->total_vfs) {
+			ret = serv_ops->setup_vf_resource(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+							  net_dev->total_vfs);
+			if (ret)
+				goto setup_vf_res_fail;
+		}
+		nbl_netdev_add_st_sysfs(netdev, net_dev);
 
-	nbl_det_setup_net_dev_ops(dev_mgt, param);
+	} else {
+		/* vf device need get pf name as its base name */
+		nbl_net_add_name_attr(&net_dev->dev_attr.dev_name_attr, dev_name);
+#ifdef CONFIG_PCI_ATS
+		if (pdev->physfn) {
+			nbl_dev_get_dev_name(adapter, dev_name);
+			memcpy(net_dev->dev_attr.dev_name_attr.net_dev_name, dev_name, IFNAMSIZ);
+			ret = sysfs_create_file(&netdev->dev.kobj,
+						&net_dev->dev_attr.dev_name_attr.attr);
+			if (ret) {
+				dev_err(dev, "nbl vf device add dev_name:%s net-fs failed",
+					dev_name);
+				goto add_vf_sys_attr_fail;
+			}
+			dev_dbg(dev, "nbl vf device get dev_name:%s", dev_name);
+		} else {
+			dev_dbg(dev, "nbl vf device no need change name");
+		}
+#endif
+	}
 
-	return 0;
+	set_bit(NBL_DOWN, adapter->state);
 
-vsi_setup_fail:
-vsi_register_fail:
-	nbl_dev_vsi_destroy(dev_mgt);
-vsi_build_fail:
-	devm_kfree(dev, *net_dev);
+	return 0;
+setup_vf_res_fail:
+#ifdef CONFIG_PCI_ATS
+add_vf_sys_attr_fail:
+#endif
+	unregister_netdev(netdev);
+register_netdev_fail:
+	nbl_dev_free_net_irq(dev_mgt);
+request_irq_fail:
+	vsi->ops->stop(dev_mgt, vsi);
+start_vsi_fail:
+	serv_ops->remove_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+init_hw_stats_fail:
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+set_queue_fail:
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+build_netdev_fail:
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+setup_net_mgt_fail:
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+alloc_rings_fail:
+	free_netdev(netdev);
+alloc_netdev_fail:
 	return ret;
 }
 
-static void nbl_dev_remove_net_dev(struct nbl_adapter *adapter)
+static void nbl_dev_stop_net_dev(struct nbl_adapter *adapter)
 {
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	struct nbl_dev_vsi *vsi;
-	int i = 0;
+	struct net_device *netdev;
+	char dev_name[IFNAMSIZ] = {0};
 
-	if (!*net_dev)
+	if (!net_dev)
 		return;
 
-	for (i = 0; i < NBL_VSI_MAX; i++) {
-		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+	netdev = net_dev->netdev;
 
-		if (!vsi)
-			continue;
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_DATA];
+	if (!vsi)
+		return;
 
-		vsi->ops->remove(dev_mgt, vsi);
+	if (!common->is_vf) {
+		serv_ops->remove_vf_resource(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+		nbl_netdev_remove_st_sysfs(net_dev);
+	} else {
+		/* remove vf dev_name attr */
+		if (memcmp(net_dev->dev_attr.dev_name_attr.net_dev_name, dev_name, IFNAMSIZ))
+			nbl_net_remove_dev_attr(net_dev);
 	}
-	nbl_dev_vsi_destroy(dev_mgt);
 
-	nbl_dev_unregister_net(dev_mgt);
+	serv_ops->change_mtu(netdev, 0);
+	unregister_netdev(netdev);
+	rtnl_lock();
+	netif_device_detach(netdev);
+	rtnl_unlock();
 
-	devm_kfree(dev, *net_dev);
-	*net_dev = NULL;
+	vsi->ops->netdev_destroy(dev_mgt, vsi);
+	vsi->ops->stop(dev_mgt, vsi);
+
+	nbl_dev_free_net_irq(dev_mgt);
+
+	serv_ops->remove_hw_stats(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	serv_ops->remove_net_resource_mgt(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	serv_ops->remove_txrx_queues(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vsi->vsi_id);
+	serv_ops->free_rings(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	free_netdev(netdev);
 }
 
-static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+static int nbl_dev_resume_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
-	int ret;
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_dev_st_dev *st_dev;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct net_device *netdev;
+	int ret = 0;
 
-	/* unify restool's chardev for leonis/draco/rnic400. all pf create chardev */
-	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+	if (!net_dev)
 		return 0;
 
-	st_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_st_dev), GFP_KERNEL);
-	if (!st_dev)
-		return -ENOMEM;
-
-	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = st_dev;
-	ret = serv_ops->setup_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-					 nbl_get_st_table(), st_dev->st_name);
-	if (ret) {
-		dev_err(dev, "create resource char dev failed\n");
-		goto alloc_chardev_failed;
-	}
+	netdev = net_dev->netdev;
 
-	if (param->caps.has_ctrl) {
-		nbl_dev_register_get_st_name_chan_msg(dev_mgt);
-	} else {
-		ret = nbl_dev_chan_get_st_name_req(dev_mgt);
-		if (!ret)
-			serv_ops->register_real_st_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-							st_dev->real_st_name);
-		else
-			dev_err(dev, "get real resource char dev failed\n");
-	}
+	ret = nbl_dev_request_net_irq(dev_mgt);
+	if (ret)
+		dev_err(dev, "request irq failed\n");
 
-	return 0;
-alloc_chardev_failed:
-	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
-	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
-	return -1;
+	netif_device_attach(netdev);
+	return ret;
 }
 
-static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter)
+static void nbl_dev_suspend_net_dev(struct nbl_adapter *adapter)
 {
-	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct net_device *netdev;
 
-	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+	if (!net_dev)
 		return;
 
-	nbl_dev_unregister_get_st_name_chan_msg(dev_mgt);
-	serv_ops->remove_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), nbl_get_st_table());
-
-	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
-	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
+	netdev = net_dev->netdev;
+	netif_device_detach(netdev);
+	nbl_dev_free_net_irq(dev_mgt);
 }
 
-static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
+static int nbl_dev_start_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
-	*dev_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(struct nbl_dev_mgt), GFP_KERNEL);
-	if (!*dev_mgt)
-		return -ENOMEM;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	int ret = 0;
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
 
-	NBL_DEV_MGT_TO_COMMON(*dev_mgt) = common;
 	return 0;
+enable_mailbox_irq_err:
+	nbl_dev_free_mailbox_irq(dev_mgt);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	nbl_dev_destroy_msix_map(dev_mgt);
+config_msix_map_err:
+	return ret;
 }
 
-static void nbl_dev_remove_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
+static void nbl_dev_stop_common_dev(struct nbl_adapter *adapter)
 {
-	devm_kfree(NBL_COMMON_TO_DEV(common), *dev_mgt);
-	*dev_mgt = NULL;
-}
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
 
-static void nbl_dev_remove_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl)
-{
-	devm_kfree(dev, *dev_ops_tbl);
-	*dev_ops_tbl = NULL;
+	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	nbl_dev_disable_mailbox_irq(dev_mgt);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	nbl_dev_destroy_msix_map(dev_mgt);
 }
 
-static int nbl_dev_setup_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl,
-			     struct nbl_adapter *adapter)
+static int nbl_dev_resume_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
-	*dev_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dev_ops_tbl), GFP_KERNEL);
-	if (!*dev_ops_tbl)
-		return -ENOMEM;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	int ret = 0;
 
-	NBL_DEV_OPS_TBL_TO_OPS(*dev_ops_tbl) = &dev_ops;
-	NBL_DEV_OPS_TBL_TO_PRIV(*dev_ops_tbl) = adapter;
+	ret = nbl_dev_request_mailbox_irq(dev_mgt);
+	if (ret)
+		return ret;
+
+	nbl_dev_setup_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
 
 	return 0;
 }
 
-int nbl_dev_init(void *p, struct nbl_init_param *param)
+static void nbl_dev_suspend_common_dev(struct nbl_adapter *adapter)
 {
-	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
-	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
-	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
-	struct nbl_service_ops_tbl *serv_ops_tbl = NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
-	struct nbl_channel_ops_tbl *chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
-	int ret = 0;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
 
-	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
-	if (ret)
-		goto setup_mgt_fail;
+	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+}
 
-	NBL_DEV_MGT_TO_SERV_OPS_TBL(*dev_mgt) = serv_ops_tbl;
-	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
+int nbl_dev_start(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	int ret = 0;
 
-	ret = nbl_dev_setup_common_dev(adapter, param);
+	ret = nbl_dev_start_common_dev(adapter, param);
 	if (ret)
-		goto setup_common_dev_fail;
+		goto start_common_dev_fail;
 
 	if (param->caps.has_ctrl) {
-		ret = nbl_dev_setup_ctrl_dev(adapter, param);
+		ret = nbl_dev_start_ctrl_dev(adapter, param);
 		if (ret)
-			goto setup_ctrl_dev_fail;
+			goto start_ctrl_dev_fail;
 	}
 
-	ret = nbl_dev_setup_net_dev(adapter, param);
-	if (ret)
-		goto setup_net_dev_fail;
-
-	ret = nbl_dev_setup_st_dev(adapter, param);
-	if (ret)
-		goto setup_st_dev_fail;
-
-	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
+	ret = nbl_dev_start_net_dev(adapter, param);
 	if (ret)
-		goto setup_ops_fail;
+		goto start_net_dev_fail;
 
 	return 0;
 
-setup_ops_fail:
-	nbl_dev_remove_st_dev(adapter);
-setup_st_dev_fail:
-	nbl_dev_remove_net_dev(adapter);
-setup_net_dev_fail:
-	nbl_dev_remove_ctrl_dev(adapter);
-setup_ctrl_dev_fail:
-	nbl_dev_remove_common_dev(adapter);
-setup_common_dev_fail:
-	nbl_dev_remove_dev_mgt(common, dev_mgt);
-setup_mgt_fail:
+start_net_dev_fail:
+	nbl_dev_stop_ctrl_dev(adapter);
+start_ctrl_dev_fail:
+	nbl_dev_stop_common_dev(adapter);
+start_common_dev_fail:
 	return ret;
 }
 
-void nbl_dev_remove(void *p)
+void nbl_dev_stop(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
-	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
-	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
-	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
-
-	nbl_dev_remove_ops(dev, dev_ops_tbl);
-
-	nbl_dev_remove_st_dev(adapter);
-	nbl_dev_remove_net_dev(adapter);
-	nbl_dev_remove_ctrl_dev(adapter);
-	nbl_dev_remove_common_dev(adapter);
 
-	nbl_dev_remove_dev_mgt(common, dev_mgt);
+	nbl_dev_stop_ctrl_dev(adapter);
+	nbl_dev_stop_net_dev(adapter);
+	nbl_dev_stop_common_dev(adapter);
 }
 
-static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt)
+int nbl_dev_resume(void *p)
 {
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_init_param *param = &adapter->init_param;
+	int ret = 0;
+
+	ret = nbl_dev_resume_common_dev(adapter, param);
+	if (ret)
+		goto start_common_dev_fail;
+
+	if (param->caps.has_ctrl) {
+		ret = nbl_dev_start_ctrl_dev(adapter, param);
+		if (ret)
+			goto start_ctrl_dev_fail;
+	}
+
+	ret = nbl_dev_resume_net_dev(adapter, param);
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
 }
 
-/* ----------  Dev start process  ---------- */
-void nbl_dev_register_dev_name(void *p)
+int nbl_dev_suspend(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
-	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
-	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
 	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 
-	/* get pf_name then register it to AF */
-	serv_ops->register_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
-				    common->vsi_id, net_dev->netdev->name);
-}
+	nbl_dev_stop_ctrl_dev(adapter);
+	nbl_dev_suspend_net_dev(adapter);
+	nbl_dev_suspend_common_dev(adapter);
+
+	pci_save_state(adapter->pdev);
+	pci_wake_from_d3(adapter->pdev, common->wol_ena);
+	pci_set_power_state(adapter->pdev, PCI_D3hot);
 
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 2ed67c9fe73b..89d3cf0f1bd4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -8,6 +8,7 @@
 #include <crypto/hash.h>
 
 static void nbl_serv_set_link_state(struct nbl_service_mgt *serv_mgt, struct net_device *netdev);
+static int nbl_serv_update_default_vlan(struct nbl_service_mgt *serv_mgt, u16 vid);
 
 static void nbl_serv_set_queue_param(struct nbl_serv_ring *ring, u16 desc_num,
 				     struct nbl_txrx_queue_param *param, u16 vsi_id,
@@ -137,6 +138,87 @@ static void nbl_serv_stop_rings(struct nbl_service_mgt *serv_mgt,
 		disp_ops->stop_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
 }
 
+static int nbl_serv_set_tx_rings(struct nbl_serv_ring_mgt *ring_mgt,
+				 struct net_device *netdev, struct device *dev)
+{
+	int i;
+	u16 ring_num = ring_mgt->tx_ring_num;
+
+	ring_mgt->tx_rings = devm_kcalloc(dev, ring_num, sizeof(*ring_mgt->tx_rings), GFP_KERNEL);
+	if (!ring_mgt->tx_rings)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->tx_rings[i].index = i;
+
+	return 0;
+}
+
+static void nbl_serv_remove_tx_ring(struct nbl_serv_ring_mgt *ring_mgt, struct device *dev)
+{
+	devm_kfree(dev, ring_mgt->tx_rings);
+	ring_mgt->tx_rings = NULL;
+}
+
+static int nbl_serv_set_rx_rings(struct nbl_serv_ring_mgt *ring_mgt,
+				 struct net_device *netdev, struct device *dev)
+{
+	int i;
+	u16 ring_num = ring_mgt->rx_ring_num;
+
+	ring_mgt->rx_rings = devm_kcalloc(dev, ring_num, sizeof(*ring_mgt->rx_rings), GFP_KERNEL);
+	if (!ring_mgt->rx_rings)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->rx_rings[i].index = i;
+
+	return 0;
+}
+
+static void nbl_serv_remove_rx_ring(struct nbl_serv_ring_mgt *ring_mgt, struct device *dev)
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
+	int i;
+	u16 ring_num = ring_mgt->rx_ring_num;
+
+	ring_mgt->vectors = devm_kcalloc(dev, ring_num, sizeof(*ring_mgt->vectors), GFP_KERNEL);
+	if (!ring_mgt->vectors)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++) {
+		ring_mgt->vectors[i].nbl_napi =
+			disp_ops->get_vector_napi(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+		netif_napi_add(netdev, &ring_mgt->vectors[i].nbl_napi->napi, pt_ops->napi_poll);
+		ring_mgt->vectors[i].netdev = netdev;
+		cpumask_clear(&ring_mgt->vectors[i].cpumask);
+	}
+
+	return 0;
+}
+
+static void nbl_serv_remove_vectors(struct nbl_serv_ring_mgt *ring_mgt, struct device *dev)
+{
+	int i;
+	u16 ring_num = ring_mgt->rx_ring_num;
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
@@ -157,6 +239,20 @@ static void nbl_serv_check_flow_table_spec(struct nbl_service_mgt *serv_mgt)
 	}
 }
 
+static bool nbl_serv_check_need_flow_rule(u8 *mac, u16 promisc)
+{
+	if (promisc & (BIT(NBL_USER_FLOW) | BIT(NBL_MIRROR)))
+		return false;
+
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
@@ -178,6 +274,82 @@ static void nbl_serv_free_vlan_node(struct nbl_serv_vlan_node *vlan_node)
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
+static int nbl_serv_update_submac_node_effective(struct nbl_service_mgt *serv_mgt,
+						 struct nbl_serv_submac_node *submac_node,
+						 bool effective,
+						 u16 vsi)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
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
+			ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						    submac_node->mac, vlan_node->vid, vsi);
+			if (ret)
+				goto del_macvlan_node;
+		} else {
+			disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					      submac_node->mac, vlan_node->vid, vsi);
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
+			disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					      submac_node->mac, vlan_node->vid, vsi);
+	}
+
+	if (ret) {
+		force_promisc = 1;
+		if (flow_mgt->force_promisc ^ force_promisc) {
+			flow_mgt->force_promisc = force_promisc;
+			flow_mgt->pending_async_work = 1;
+			netdev_info(dev, "Reached MAC filter limit, forcing promisc/allmuti moden");
+		}
+	}
+
+	return 0;
+}
+
 static int nbl_serv_update_vlan_node_effective(struct nbl_service_mgt *serv_mgt,
 					       struct nbl_serv_vlan_node *vlan_node,
 					       bool effective,
@@ -253,6 +425,145 @@ static int nbl_serv_update_vlan_node_effective(struct nbl_service_mgt *serv_mgt,
 	return ret;
 }
 
+static void nbl_serv_del_submac_node(struct nbl_service_mgt *serv_mgt, u8 *mac, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node, *submac_node_safe;
+	struct list_head *submac_head;
+
+	if (is_multicast_ether_addr(mac))
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_MULTI];
+	else
+		submac_head = &flow_mgt->submac_list[NBL_SUBMAC_UNICAST];
+
+	list_for_each_entry_safe(submac_node, submac_node_safe, submac_head, node)
+		if (ether_addr_equal(submac_node->mac, mac)) {
+			if (submac_node->effective)
+				nbl_serv_update_submac_node_effective(serv_mgt,
+								      submac_node, 0, vsi);
+			list_del(&submac_node->node);
+			flow_mgt->submac_list_cnt--;
+			if (is_multicast_ether_addr(submac_node->mac))
+				flow_mgt->multi_mac_cnt--;
+			else
+				flow_mgt->unicast_mac_cnt--;
+			nbl_serv_free_submac_node(submac_node);
+			break;
+		}
+}
+
+static int nbl_serv_add_submac_node(struct nbl_service_mgt *serv_mgt, u8 *mac, u16 vsi, u16 promisc)
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
+	    (flow_mgt->trusted_en || flow_mgt->active_submac_list < NBL_NO_TRUST_MAX_MAC)) {
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node, 1, vsi);
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
+static void nbl_serv_update_mcast_submac(struct nbl_service_mgt *serv_mgt, bool multi_effective,
+					 bool unicast_effective, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node;
+
+	list_for_each_entry(submac_node, &flow_mgt->submac_list[NBL_SUBMAC_MULTI], node)
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node,
+						      multi_effective, vsi);
+
+	list_for_each_entry(submac_node, &flow_mgt->submac_list[NBL_SUBMAC_UNICAST], node)
+		nbl_serv_update_submac_node_effective(serv_mgt, submac_node,
+						      unicast_effective, vsi);
+}
+
+static void nbl_serv_update_promisc_vlan(struct nbl_service_mgt *serv_mgt, bool effective, u16 vsi)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node)
+		nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, effective, vsi);
+}
+
+static void nbl_serv_del_all_vlans(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node, *vlan_node_safe;
+
+	list_for_each_entry_safe(vlan_node, vlan_node_safe, &flow_mgt->vlan_list, node) {
+		if (vlan_node->primary_mac_effective)
+			disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+					      vlan_node->vid, NBL_COMMON_TO_VSI_ID(common));
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
+			nbl_serv_update_submac_node_effective(serv_mgt, submac_node, 0, vsi);
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
+	int i;
+
+	for (i = 0; i < rings_num; i++) {
+		cpumask_set_cpu(cpumask_local_spread(i, NBL_COMMON_TO_DEV(common)->numa_node),
+				&ring_mgt->vectors[i].cpumask);
+		netif_set_xps_queue(ring_mgt->vectors[i].netdev, &ring_mgt->vectors[i].cpumask, i);
+	}
+}
+
 static void nbl_serv_set_sfp_state(void *priv, struct net_device *netdev, u8 eth_id,
 				   bool open, bool is_force)
 {
@@ -425,6 +736,24 @@ int nbl_serv_vsi_stop(void *priv, u16 vsi_index)
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
@@ -437,6 +766,15 @@ static int nbl_serv_abnormal_event_to_queue(int event_type)
 	}
 }
 
+static int nbl_serv_stop_abnormal_sw_queue(struct nbl_service_mgt *serv_mgt,
+					   u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->stop_abnormal_sw_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						local_queue_id, type);
+}
+
 static int nbl_serv_chan_stop_abnormal_sw_queue_req(struct nbl_service_mgt *serv_mgt,
 						    u16 local_queue_id, u16 func_id, int type)
 {
@@ -455,6 +793,52 @@ static int nbl_serv_chan_stop_abnormal_sw_queue_req(struct nbl_service_mgt *serv
 	return ret;
 }
 
+static void nbl_serv_chan_stop_abnormal_sw_queue_resp(void *priv, u16 src_id, u16 msg_id,
+						      void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_stop_abnormal_sw_queue *param =
+					(struct nbl_chan_param_stop_abnormal_sw_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = 0;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >= vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	ret = nbl_serv_stop_abnormal_sw_queue(serv_mgt, param->local_queue_id, param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE, msg_id,
+		     ret, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
+static dma_addr_t nbl_serv_netdev_queue_restore(struct nbl_service_mgt *serv_mgt,
+						u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->restore_abnormal_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					       local_queue_id, type);
+}
+
+static int nbl_serv_netdev_queue_restart(struct nbl_service_mgt *serv_mgt,
+					 u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->restart_abnormal_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					       local_queue_id, type);
+}
+
 static dma_addr_t nbl_serv_chan_restore_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 							 u16 local_queue_id, u16 func_id, int type)
 {
@@ -476,6 +860,34 @@ static dma_addr_t nbl_serv_chan_restore_netdev_queue_req(struct nbl_service_mgt
 	return dma;
 }
 
+static void nbl_serv_chan_restore_netdev_queue_resp(void *priv, u16 src_id, u16 msg_id,
+						    void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restore_queue *param = (struct nbl_chan_param_restore_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	dma_addr_t dma = 0;
+	int ret = NBL_CHAN_RESP_OK;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >= vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	dma = nbl_serv_netdev_queue_restore(serv_mgt, param->local_queue_id, param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE, msg_id,
+		     ret, &dma, sizeof(dma));
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
 static int nbl_serv_chan_restart_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
 						  u16 local_queue_id, u16 func_id, int type)
 {
@@ -491,6 +903,33 @@ static int nbl_serv_chan_restart_netdev_queue_req(struct nbl_service_mgt *serv_m
 	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
 }
 
+static void nbl_serv_chan_restart_netdev_queue_resp(void *priv, u16 src_id, u16 msg_id,
+						    void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restart_queue *param = (struct nbl_chan_param_restart_queue *)data;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = 0;
+
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	if (param->local_queue_id < vsi_info->ring_offset ||
+	    param->local_queue_id >= vsi_info->ring_offset + vsi_info->ring_num ||
+	    !vsi_info->ring_num) {
+		ret = -EINVAL;
+		goto send_ack;
+	}
+
+	ret = nbl_serv_netdev_queue_restart(serv_mgt, param->local_queue_id, param->type);
+
+send_ack:
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_RESTART_NETDEV_QUEUE, msg_id,
+		     ret, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
 static int
 nbl_serv_start_abnormal_hw_queue(struct nbl_service_mgt *serv_mgt, u16 vsi_id, u16 local_queue_id,
 				 dma_addr_t dma, int type)
@@ -573,37 +1012,319 @@ static void nbl_serv_restore_queue(struct nbl_service_mgt *serv_mgt, u16 vsi_id,
 	rtnl_unlock();
 }
 
-int nbl_serv_netdev_open(struct net_device *netdev)
+static void nbl_serv_handle_tx_timeout(struct work_struct *work)
 {
-	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
-	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt, tx_timeout);
+	struct nbl_service_mgt *serv_mgt = serv_net_resource_mgt->serv_mgt;
 	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
-	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 	struct nbl_serv_ring_vsi_info *vsi_info;
-	int num_cpus, real_qps, ret = 0;
-	bool netdev_open = true;
-
-	if (!test_bit(NBL_DOWN, adapter->state))
-		return -EBUSY;
-
-	netdev_info(netdev, "Nbl open\n");
+	struct nbl_serv_vector *vector;
+	int i = 0;
 
-	netif_carrier_off(netdev);
-	nbl_serv_set_sfp_state(serv_mgt, netdev, NBL_COMMON_TO_ETH_ID(common), true, false);
 	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
 
-	if (vsi_info->active_ring_num) {
-		real_qps = vsi_info->active_ring_num;
-	} else {
-		num_cpus = num_online_cpus();
-		real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num : num_cpus;
+	for (i = vsi_info->ring_offset; i < vsi_info->ring_offset + vsi_info->ring_num; i++) {
+		if (ring_mgt->tx_rings[i].need_recovery) {
+			vector = &ring_mgt->vectors[i];
+			nbl_serv_restore_queue(serv_mgt, vsi_info->vsi_id, i, NBL_TX, false);
+			ring_mgt->tx_rings[i].need_recovery = false;
+		}
 	}
+}
 
-	ret = nbl_serv_vsi_open(serv_mgt, netdev, NBL_VSI_DATA, real_qps, 1);
-	if (ret)
-		goto vsi_open_fail;
+static void nbl_serv_update_link_state(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt, update_link_state);
+	struct nbl_service_mgt *serv_mgt = serv_net_resource_mgt->serv_mgt;
 
-	ret = netif_set_real_num_tx_queues(netdev, real_qps);
+	nbl_serv_set_link_state(serv_mgt, serv_net_resource_mgt->netdev);
+}
+
+static int nbl_serv_chan_notify_link_forced_req(struct nbl_service_mgt *serv_mgt, u16 func_id)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_NOTIFY_LINK_FORCED, NULL, 0, NULL, 0, 1);
+	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+}
+
+static void nbl_serv_chan_notify_link_forced_resp(void *priv, u16 src_id, u16 msg_id,
+						  void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = serv_mgt->net_resource_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_ack_info chan_ack;
+
+	if (!net_resource_mgt)
+		return;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_NOTIFY_LINK_FORCED, msg_id,
+		     NBL_CHAN_RESP_OK, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+
+	nbl_common_queue_work(&net_resource_mgt->update_link_state, false);
+}
+
+static void nbl_serv_register_link_forced_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_NOTIFY_LINK_FORCED,
+			       nbl_serv_chan_notify_link_forced_resp, serv_mgt);
+}
+
+static void nbl_serv_unregister_link_forced_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->unregister_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+				 NBL_CHAN_MSG_NOTIFY_LINK_FORCED);
+}
+
+static void nbl_serv_update_vlan(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt, update_vlan);
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
+			netdev_err(netdev, "Netdev stop failed while update_vlan\n");
+			goto netdev_stop_fail;
+		}
+
+		err = nbl_serv_netdev_open(netdev);
+		if (err) {
+			netdev_err(netdev, "Netdev open failed after update_vlan\n");
+			goto netdev_open_fail;
+		}
+	}
+
+netdev_stop_fail:
+netdev_open_fail:
+	rtnl_unlock();
+}
+
+static int nbl_serv_chan_notify_vlan_req(struct nbl_service_mgt *serv_mgt, u16 func_id,
+					 struct nbl_serv_notify_vlan_param *param)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_NOTIFY_VLAN,
+		      param, sizeof(*param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+}
+
+static void nbl_serv_chan_notify_vlan_resp(void *priv, u16 src_id, u16 msg_id,
+					   void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_serv_notify_vlan_param *param = (struct nbl_serv_notify_vlan_param *)data;
+	struct nbl_chan_ack_info chan_ack;
+
+	net_resource_mgt->vlan_tci = param->vlan_tci;
+	net_resource_mgt->vlan_proto = param->vlan_proto;
+
+	nbl_common_queue_work(&net_resource_mgt->update_vlan, false);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_NOTIFY_VLAN, msg_id,
+		     NBL_CHAN_RESP_OK, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
+static void nbl_serv_register_vlan_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), NBL_CHAN_MSG_NOTIFY_VLAN,
+			       nbl_serv_chan_notify_vlan_resp, serv_mgt);
+}
+
+static void nbl_serv_unregister_vlan_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->unregister_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), NBL_CHAN_MSG_NOTIFY_VLAN);
+}
+
+static int nbl_serv_chan_notify_trust_req(struct nbl_service_mgt *serv_mgt,
+					  u16 func_id, bool trusted)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_NOTIFY_TRUST, &trusted, sizeof(trusted),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+}
+
+static void nbl_serv_chan_notify_trust_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	bool *trusted = (bool *)data;
+	struct nbl_chan_ack_info chan_ack;
+
+	flow_mgt->trusted_en = *trusted;
+	flow_mgt->trusted_update = 1;
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_NOTIFY_TRUST, msg_id,
+		     NBL_CHAN_RESP_OK, NULL, 0);
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
+static void nbl_serv_register_trust_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), NBL_CHAN_MSG_NOTIFY_TRUST,
+			       nbl_serv_chan_notify_trust_resp, serv_mgt);
+}
+
+static void nbl_serv_unregister_trust_notify(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->unregister_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), NBL_CHAN_MSG_NOTIFY_TRUST);
+}
+
+static int nbl_serv_chan_get_vf_stats_req(struct nbl_service_mgt *serv_mgt,
+					  u16 func_id, struct nbl_vf_stats *vf_stats)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_GET_VF_STATS,
+		      NULL, 0, vf_stats, sizeof(*vf_stats), 1);
+	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+}
+
+static void nbl_serv_chan_get_vf_stats_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	struct nbl_vf_stats vf_stats = {0};
+	struct nbl_stats stats = { 0 };
+	int err = NBL_CHAN_RESP_OK;
+
+	disp_ops->get_net_stats(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &stats);
+
+	vf_stats.rx_packets = stats.rx_packets;
+	vf_stats.tx_packets = stats.tx_packets;
+	vf_stats.rx_bytes = stats.rx_bytes;
+	vf_stats.tx_bytes = stats.tx_bytes;
+	vf_stats.multicast = stats.rx_multicast_packets;
+	vf_stats.rx_dropped = 0;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VF_STATS, msg_id,
+		     err, &vf_stats, sizeof(vf_stats));
+	chan_ops->send_ack(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_ack);
+}
+
+static void nbl_serv_register_get_vf_stats(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_GET_VF_STATS,
+			       nbl_serv_chan_get_vf_stats_resp, serv_mgt);
+}
+
+static void nbl_serv_unregister_get_vf_stats(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->unregister_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), NBL_CHAN_MSG_GET_VF_STATS);
+}
+
+int nbl_serv_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	int num_cpus, real_qps, ret = 0;
+	bool netdev_open = true;
+
+	if (!test_bit(NBL_DOWN, adapter->state))
+		return -EBUSY;
+
+	netdev_info(netdev, "Nbl open\n");
+
+	netif_carrier_off(netdev);
+	nbl_serv_set_sfp_state(serv_mgt, netdev, NBL_COMMON_TO_ETH_ID(common), true, false);
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+
+	if (vsi_info->active_ring_num) {
+		real_qps = vsi_info->active_ring_num;
+	} else {
+		num_cpus = num_online_cpus();
+		real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num : num_cpus;
+	}
+
+	ret = nbl_serv_vsi_open(serv_mgt, netdev, NBL_VSI_DATA, real_qps, 1);
+	if (ret)
+		goto vsi_open_fail;
+
+	ret = netif_set_real_num_tx_queues(netdev, real_qps);
 	if (ret)
 		goto setup_real_qps_fail;
 	ret = netif_set_real_num_rx_queues(netdev, real_qps);
@@ -651,6 +1372,44 @@ int nbl_serv_netdev_stop(struct net_device *netdev)
 	return 0;
 }
 
+static int nbl_serv_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
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
 static int nbl_serv_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
 {
 	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
@@ -740,6 +1499,78 @@ static int nbl_serv_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
 	return 0;
 }
 
+static int nbl_serv_update_default_vlan(struct nbl_service_mgt *serv_mgt, u16 vid)
+{
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node = NULL;
+	struct nbl_serv_vlan_node *node, *tmp;
+	struct nbl_common_info *common;
+	int ret;
+	u16 vsi;
+	bool other_effective = false;
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
+				nbl_serv_update_vlan_node_effective(serv_mgt, node, 0, vsi);
+				list_del(&node->node);
+				nbl_serv_free_vlan_node(node);
+			}
+		} else if (node->vid != vid) {
+			nbl_serv_update_vlan_node_effective(serv_mgt, node,
+							    other_effective, vsi);
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
 static void nbl_serv_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
 {
 	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
@@ -769,703 +1600,2560 @@ static void nbl_serv_get_stats64(struct net_device *netdev, struct rtnl_link_sta
 	stats->tx_dropped = 0;
 }
 
-static int nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
-				 struct nbl_register_net_result *register_result)
+static int nbl_addr_unsync(struct net_device *netdev, const u8 *addr)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_adapter *adapter;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
 
-	return disp_ops->register_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-				     register_param, register_result);
+	adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
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
 }
 
-static int nbl_serv_unregister_net(void *priv)
+static int nbl_addr_sync(struct net_device *netdev, const u8 *addr)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops;
+	struct nbl_adapter *adapter;
+	struct nbl_service_mgt *serv_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
 
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-	return disp_ops->unregister_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
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
 }
 
-static int nbl_serv_start_mgt_flow(void *priv)
+static void nbl_modify_submacs(struct nbl_serv_net_resource_mgt *net_resource_mgt)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct net_device *netdev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_mac_filter *filter, *safe_filter;
 
-	return disp_ops->setup_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
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
+		nbl_serv_del_submac_node(serv_mgt, filter->macaddr, priv->data_vsi);
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
 }
 
-static void nbl_serv_stop_mgt_flow(void *priv)
+static void nbl_modify_promisc_mode(struct nbl_serv_net_resource_mgt *net_resource_mgt)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct net_device *netdev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *priv = netdev_priv(netdev);
+	struct nbl_service_mgt *serv_mgt = net_resource_mgt->serv_mgt;
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	bool mode = 0, multi = 0;
+	bool need_flow = 1;
+	bool unicast_enable, multicast_enable;
 
-	return disp_ops->remove_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-}
+	rtnl_lock();
+	net_resource_mgt->curr_promiscuout_mode = netdev->flags;
 
-static u32 nbl_serv_get_tx_headroom(void *priv)
-{
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	if (((netdev->flags & (IFF_PROMISC)) || flow_mgt->force_promisc) &&
+	    !NBL_COMMON_TO_VF_CAP(NBL_SERV_MGT_TO_COMMON(serv_mgt)))
+		mode = 1;
 
-	return disp_ops->get_tx_headroom(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-}
+	if ((netdev->flags & (IFF_PROMISC | IFF_ALLMULTI)) || flow_mgt->force_promisc)
+		multi = 1;
 
-/**
- * This ops get fix product capability from resource layer, this capability fix by product_type, no
- * need get from ctrl device
- */
-static bool nbl_serv_get_product_fix_cap(void *priv, enum nbl_fix_cap_type cap_type)
-{
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	if (flow_mgt->promisc & (BIT(NBL_USER_FLOW) | BIT(NBL_MIRROR))) {
+		multi = 0;
+		mode = 0;
+		need_flow = 0;
+	}
 
-	return disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-						       cap_type);
-}
+	if (!flow_mgt->trusted_en)
+		multi = 0;
 
-static int nbl_serv_init_chip(void *priv)
-{
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops;
-	struct nbl_common_info *common;
-	struct device *dev;
-	int ret = 0;
+	unicast_enable = !mode && need_flow;
+	multicast_enable = !multi && need_flow;
 
-	common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-	dev = NBL_COMMON_TO_DEV(common);
+	if ((flow_mgt->promisc & BIT(NBL_PROMISC)) ^ (mode << NBL_PROMISC))
+		if (!NBL_COMMON_TO_VF_CAP(NBL_SERV_MGT_TO_COMMON(serv_mgt))) {
+			disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						priv->data_vsi, mode);
+			if (mode)
+				flow_mgt->promisc |= BIT(NBL_PROMISC);
+			else
+				flow_mgt->promisc &= ~BIT(NBL_PROMISC);
+		}
 
-	ret = disp_ops->init_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	if (ret) {
-		dev_err(dev, "init_chip_module failed\n");
-		goto module_init_fail;
+	if ((flow_mgt->promisc & BIT(NBL_ALLMULTI)) ^ (multi << NBL_ALLMULTI)) {
+		disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				  priv->data_vsi, multi);
+		if (multi)
+			flow_mgt->promisc |= BIT(NBL_ALLMULTI);
+		else
+			flow_mgt->promisc &= ~BIT(NBL_ALLMULTI);
 	}
 
-	ret = disp_ops->queue_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	if (ret) {
-		dev_err(dev, "queue_init failed\n");
-		goto queue_init_fail;
+	if (flow_mgt->multicast_flow_enable ^ multicast_enable) {
+		nbl_serv_update_mcast_submac(serv_mgt, multicast_enable,
+					     unicast_enable, priv->data_vsi);
+		flow_mgt->multicast_flow_enable = multicast_enable;
 	}
 
-	ret = disp_ops->vsi_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	if (ret) {
-		dev_err(dev, "vsi_init failed\n");
-		goto vsi_init_fail;
+	if (flow_mgt->unicast_flow_enable ^ unicast_enable) {
+		nbl_serv_update_promisc_vlan(serv_mgt, unicast_enable, priv->data_vsi);
+		flow_mgt->unicast_flow_enable = unicast_enable;
 	}
 
-	return 0;
-
-vsi_init_fail:
-queue_init_fail:
-module_init_fail:
-	return ret;
+	if (flow_mgt->trusted_update) {
+		flow_mgt->trusted_update = 0;
+		if (flow_mgt->active_submac_list < flow_mgt->submac_list_cnt)
+			nbl_serv_update_mcast_submac(serv_mgt, flow_mgt->multicast_flow_enable,
+						     flow_mgt->unicast_flow_enable, priv->data_vsi);
+	}
+	rtnl_unlock();
 }
 
-static int nbl_serv_destroy_chip(void *p)
+static int nbl_serv_set_vf_mac(struct net_device *dev, int vf_id, u8 *mac)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)p;
-	struct nbl_dispatch_ops *disp_ops;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
 
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
 
-	if (!disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-					   NBL_NEED_DESTROY_CHIP))
-		return 0;
+	ether_addr_copy(net_resource_mgt->vf_info[vf_id].mac, mac);
+
+	disp_ops->register_func_mac(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), mac, function_id);
 
-	disp_ops->deinit_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
 	return 0;
 }
 
-static u16 nbl_serv_get_vsi_id(void *priv, u16 func_id, u16 type)
+static int nbl_serv_set_vf_rate(struct net_device *dev, int vf_id, int min_rate, int max_rate)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
+	int ret = 0;
 
-	return disp_ops->get_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id, type);
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+
+	if (vf_id < net_resource_mgt->num_vfs)
+		ret = disp_ops->set_tx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    function_id, max_rate, 0);
+
+	if (!ret)
+		net_resource_mgt->vf_info[vf_id].max_tx_rate = max_rate;
+
+	ret = disp_ops->register_func_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   function_id, max_rate);
+
+	return ret;
 }
 
-static void nbl_serv_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+static int nbl_serv_set_vf_spoofchk(struct net_device *dev, int vf_id, bool ena)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int ret = 0;
 
-	return disp_ops->get_eth_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
-				    eth_mode, eth_id, logic_eth_id);
+	if (vf_id >= net_resource_mgt->total_vfs || !net_resource_mgt->vf_info)
+		return -EINVAL;
+
+	if (vf_id < net_resource_mgt->num_vfs)
+		ret = disp_ops->set_vf_spoof_check(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						   NBL_COMMON_TO_VSI_ID(common), vf_id, ena);
+
+	if (!ret)
+		net_resource_mgt->vf_info[vf_id].spoof_check = ena;
+
+	return ret;
 }
 
-static void nbl_serv_get_rep_queue_info(void *priv, u16 *queue_num, u16 *queue_size)
+static int nbl_serv_set_vf_link_state(struct net_device *dev, int vf_id, int link_state)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
+	bool should_notify = false;
+	int ret = 0;
 
-	disp_ops->get_rep_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-				     queue_num, queue_size);
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+
+	ret = disp_ops->register_func_link_forced(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						  function_id, link_state, &should_notify);
+	if (!ret && should_notify)
+		nbl_serv_chan_notify_link_forced_req(serv_mgt, function_id);
+
+	if (!ret)
+		net_resource_mgt->vf_info[vf_id].state = link_state;
+
+	return ret;
 }
 
-static void nbl_serv_get_user_queue_info(void *priv, u16 *queue_num, u16 *queue_size, u16 vsi_id)
+static int nbl_serv_set_vf_trust(struct net_device *dev, int vf_id, bool trusted)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+						NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
+	bool should_notify = false;
+	int ret = 0;
 
-	disp_ops->get_user_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-				      queue_num, queue_size, vsi_id);
-}
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
 
-static void
-nbl_serv_set_netdev_ops(void *priv, const struct net_device_ops *net_device_ops, bool is_pf)
-{
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
-	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	ret = disp_ops->register_func_trust(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    function_id, trusted, &should_notify);
+	if (!ret && should_notify)
+		nbl_serv_chan_notify_trust_req(serv_mgt, function_id, trusted);
 
-	dev_info(dev, "set netdev ops:%p is_pf:%d\n", net_device_ops, is_pf);
-	if (is_pf)
-		net_resource_mgt->netdev_ops.pf_netdev_ops = (void *)net_device_ops;
+	if (!ret)
+		net_resource_mgt->vf_info[vf_id].trusted = trusted;
+
+	return ret;
 }
 
-static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
+static int __used nbl_serv_set_vf_tx_rate(struct net_device *dev,
+					  int vf_id, int tx_rate,
+					  int burst, bool burst_en)
 {
-	int i = 0;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
+	int ret = 0;
 
-	INIT_LIST_HEAD(&flow_mgt->vlan_list);
-	for (i = 0; i < NBL_SUBMAC_MAX; i++)
-		INIT_LIST_HEAD(&flow_mgt->submac_list[i]);
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+	if (!burst_en)
+		burst = net_resource_mgt->vf_info[vf_id].meter_tx_burst;
+
+	if (vf_id < net_resource_mgt->num_vfs)
+		ret = disp_ops->set_tx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    function_id, tx_rate, burst);
+
+	if (!ret) {
+		net_resource_mgt->vf_info[vf_id].meter_tx_rate = tx_rate;
+		if (burst_en)
+			net_resource_mgt->vf_info[vf_id].meter_tx_burst = burst;
+	}
+
+	return ret;
 }
 
-static u8 __iomem *nbl_serv_get_hw_addr(void *priv, size_t *size)
+static int __used nbl_serv_set_vf_rx_rate(struct net_device *dev,
+					  int vf_id, int rx_rate,
+					  int burst, bool burst_en)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 function_id = U16_MAX;
+	int ret = 0;
 
-	return disp_ops->get_hw_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), size);
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+	if (!burst_en)
+		burst = net_resource_mgt->vf_info[vf_id].meter_tx_burst;
+
+	if (vf_id < net_resource_mgt->num_vfs)
+		ret = disp_ops->set_rx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    function_id, rx_rate, burst);
+
+	if (!ret) {
+		net_resource_mgt->vf_info[vf_id].meter_rx_rate = rx_rate;
+		if (burst_en)
+			net_resource_mgt->vf_info[vf_id].meter_rx_burst = burst;
+	}
+
+	return ret;
 }
 
-static u16 nbl_serv_get_function_id(void *priv, u16 vsi_id)
+static int nbl_serv_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan, u8 qos, __be16 proto)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_notify_vlan_param param = {0};
+	int ret = 0;
+	u16 function_id = U16_MAX;
+	bool should_notify = false;
 
-	return disp_ops->get_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+	if (vlan > 4095 || qos > 7)
+		return -EINVAL;
+
+	function_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (function_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+
+	if (vlan) {
+		param.vlan_tci = (vlan & VLAN_VID_MASK) | (qos << VLAN_PRIO_SHIFT);
+		param.vlan_proto = ntohs(proto);
+	} else {
+		proto = 0;
+		qos = 0;
+	}
+
+	ret = disp_ops->register_func_vlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), function_id,
+					   param.vlan_tci, param.vlan_proto,
+					   &should_notify);
+	if (should_notify && !ret) {
+		ret = nbl_serv_chan_notify_vlan_req(serv_mgt, function_id, &param);
+		if (ret)
+			disp_ops->register_func_vlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						     function_id, 0, 0, &should_notify);
+	}
+	if (!ret) {
+		net_resource_mgt->vf_info[vf_id].vlan = vlan;
+		net_resource_mgt->vf_info[vf_id].vlan_proto = ntohs(proto);
+		net_resource_mgt->vf_info[vf_id].vlan_qos = qos;
+	}
+
+	return ret;
 }
 
-static void nbl_serv_get_real_bdf(void *priv, u16 vsi_id, u8 *bus, u8 *dev, u8 *function)
+static int nbl_serv_get_vf_stats(struct net_device *dev, int vf_id, struct ifla_vf_stats *vf_stats)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_service_mgt *serv_mgt = NBL_NETDEV_TO_SERV_MGT(dev);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_vf_stats stats = {0};
+	u16 func_id = U16_MAX;
+	int ret = 0;
 
-	return disp_ops->get_real_bdf(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
-				      bus, dev, function);
+	func_id = nbl_serv_get_vf_function_id(serv_mgt, vf_id);
+	if (func_id == U16_MAX) {
+		netdev_info(dev, "vf id %d invalid\n", vf_id);
+		return -EINVAL;
+	}
+
+	ret = disp_ops->check_vf_is_active(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id);
+	if (!ret)
+		return 0;
+	ret = nbl_serv_chan_get_vf_stats_req(serv_mgt, func_id, &stats);
+
+	if (ret)
+		return -EIO;
+
+	vf_stats->rx_packets = stats.rx_packets;
+	vf_stats->tx_packets = stats.tx_packets;
+	vf_stats->rx_bytes = stats.rx_bytes;
+	vf_stats->tx_bytes = stats.tx_bytes;
+	vf_stats->broadcast = stats.broadcast;
+	vf_stats->multicast = stats.multicast;
+	vf_stats->rx_dropped = stats.rx_dropped;
+	vf_stats->tx_dropped = stats.tx_dropped;
+
+	return 0;
 }
 
-static bool nbl_serv_check_fw_heartbeat(void *priv)
+static int nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
+				 struct nbl_register_net_result *register_result)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops;
-
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return disp_ops->check_fw_heartbeat(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return disp_ops->register_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     register_param, register_result);
 }
 
-static bool nbl_serv_check_fw_reset(void *priv)
+static int nbl_serv_unregister_net(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops;
 
 	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-
-	return disp_ops->check_fw_reset(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return disp_ops->unregister_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
 }
 
-static void nbl_serv_get_common_irq_num(void *priv, struct nbl_common_irq_num *irq_num)
+static int nbl_serv_setup_txrx_queues(void *priv, u16 vsi_id, u16 queue_num, u16 net_vector_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_vector *vector;
+	int i, ret = 0;
 
-	irq_num->mbx_irq_num = disp_ops->get_mbx_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-}
+	/* queue_num include user&kernel queue */
+	ret = disp_ops->alloc_txrx_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, queue_num);
+	if (ret)
+		return -EFAULT;
 
-static void nbl_serv_get_ctrl_irq_num(void *priv, struct nbl_ctrl_irq_num *irq_num)
-{
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	/* ring_mgt->tx_ring_number only for kernel use */
+	for (i = 0; i < ring_mgt->tx_ring_num; i++) {
+		ring_mgt->tx_rings[i].local_queue_id = NBL_PAIR_ID_GET_TX(i);
+		ring_mgt->rx_rings[i].local_queue_id = NBL_PAIR_ID_GET_RX(i);
+	}
 
-	irq_num->adminq_irq_num = disp_ops->get_adminq_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	irq_num->abnormal_irq_num =
-		disp_ops->get_abnormal_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	for (i = 0; i < ring_mgt->rx_ring_num; i++) {
+		vector = &ring_mgt->vectors[i];
+		vector->local_vector_id = i + net_vector_id;
+		vector->global_vector_id =
+			disp_ops->get_global_vector(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						    vsi_id, vector->local_vector_id);
+		vector->irq_enable_base =
+			disp_ops->get_msix_irq_enable_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							   vector->global_vector_id,
+							   &vector->irq_data);
+
+		disp_ops->set_vector_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					  vector->irq_enable_base,
+					  vector->irq_data, i,
+					  ring_mgt->net_msix_mask_en);
+	}
+
+	return 0;
 }
 
-static int nbl_serv_get_port_attributes(void *priv)
+static void nbl_serv_remove_txrx_queues(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt;
 	struct nbl_dispatch_ops *disp_ops;
-	int ret = 0;
 
+	ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
 	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	ret = disp_ops->get_port_attributes(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	if (ret)
-		return -EIO;
-
-	return 0;
+	disp_ops->free_txrx_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static int nbl_serv_update_template_config(void *priv)
+static int nbl_serv_init_tx_rate(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 func_id;
 	int ret = 0;
 
-	ret = disp_ops->update_ring_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	if (ret)
-		return ret;
+	if (net_resource_mgt->max_tx_rate) {
+		func_id = disp_ops->get_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+		ret = disp_ops->set_tx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    func_id, net_resource_mgt->max_tx_rate, 0);
+	}
 
-	return 0;
+	return ret;
 }
 
-static int nbl_serv_get_part_number(void *priv, char *part_number)
+static int nbl_serv_setup_q2vsi(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return disp_ops->get_part_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), part_number);
+	return disp_ops->setup_q2vsi(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static int nbl_serv_get_serial_number(void *priv, char *serial_number)
+static void nbl_serv_remove_q2vsi(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return disp_ops->get_serial_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), serial_number);
+	disp_ops->remove_q2vsi(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static int nbl_serv_enable_port(void *priv, bool enable)
+static int nbl_serv_setup_rss(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops;
-	int ret = 0;
-
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-
-	ret = disp_ops->enable_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), enable);
-	if (ret)
-		return -EIO;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return 0;
+	return disp_ops->setup_rss(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static void nbl_serv_init_port(void *priv)
+static void nbl_serv_remove_rss(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops;
-
-	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	disp_ops->init_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	disp_ops->remove_rss(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static int nbl_serv_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+static int nbl_serv_setup_rss_indir(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
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
+	real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num : num_cpus;
+
+	for (i = 0; i < rxfh_indir_size; i++)
+		indir[i] = i % real_qps;
+
+	disp_ops->set_rxfh_indir(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				 vsi_id, indir, rxfh_indir_size);
+	devm_kfree(dev, indir);
+	return 0;
+}
+
+static int nbl_serv_alloc_rings(void *priv, struct net_device *netdev, struct nbl_ring_param *param)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct device *dev;
+	struct nbl_serv_ring_mgt *ring_mgt;
+	struct nbl_dispatch_ops *disp_ops;
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
+	ret = disp_ops->alloc_rings(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), netdev, param);
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
+	struct device *dev;
+	struct nbl_serv_ring_mgt *ring_mgt;
+	struct nbl_dispatch_ops *disp_ops;
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
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[vsi_index];
+	u16 start = vsi_info->ring_offset, end = vsi_info->ring_offset + vsi_info->ring_num;
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
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[vsi_index];
+	u16 start = vsi_info->ring_offset, end = vsi_info->ring_offset + vsi_info->ring_num;
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
+static int nbl_serv_start_net_flow(void *priv, struct net_device *netdev, u16 vsi_id, u16 vid,
+				   bool trusted)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_vlan_node *vlan_node;
+	u8 mac[ETH_ALEN];
+	int ret = 0;
 
-	if (NBL_COMMON_TO_VF_CAP(common))
-		return 0;
-	else
-		return disp_ops->set_eth_mac_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-						  mac, eth_id);
+	flow_mgt->unicast_flow_enable = true;
+	flow_mgt->multicast_flow_enable = true;
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
+	ret = nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, 1, vsi_id);
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
 }
 
-static void nbl_serv_adapt_desc_gother(void *priv)
+static void nbl_serv_stop_net_flow(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(dev);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
 
-	if (test_bit(NBL_FLAG_HIGH_THROUGHPUT, &serv_mgt->flags))
-		disp_ops->set_desc_high_throughput(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
-	else
-		disp_ops->adapt_desc_gother(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	nbl_serv_del_all_submacs(serv_mgt, net_priv->data_vsi);
+	nbl_serv_del_all_vlans(serv_mgt);
+
+	disp_ops->del_multi_rule(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+
+	disp_ops->set_vf_spoof_check(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     vsi_id, -1, false);
+	memset(flow_mgt->mac, 0, sizeof(flow_mgt->mac));
 }
 
-static void nbl_serv_process_flr(void *priv, u16 vfid)
+static void nbl_serv_clear_flow(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	disp_ops->flr_clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
-	disp_ops->flr_clear_flows(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
-	disp_ops->flr_clear_interrupt(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
-	disp_ops->flr_clear_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->clear_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static u16 nbl_serv_covert_vfid_to_vsi_id(void *priv, u16 vfid)
+static int nbl_serv_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return disp_ops->covert_vfid_to_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	return disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, mode);
 }
 
-static void nbl_serv_recovery_abnormal(void *priv)
+static int nbl_serv_cfg_multi_mcast(void *priv, u16 vsi_id, u16 enable)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	disp_ops->unmask_all_interrupts(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, enable);
 }
 
-static void nbl_serv_keep_alive(void *priv)
+static int nbl_serv_set_lldp_flow(void *priv, u16 vsi_id)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	disp_ops->keep_alive(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return disp_ops->add_lldp_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
 }
 
-static int nbl_serv_register_vsi_info(void *priv, struct nbl_vsi_param *vsi_param)
+static void nbl_serv_remove_lldp_flow(void *priv, u16 vsi_id)
 {
-	u16 vsi_index = vsi_param->index;
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-	u32 num_cpus;
 
-	ring_mgt->vsi_info[vsi_index].vsi_index = vsi_index;
-	ring_mgt->vsi_info[vsi_index].vsi_id = vsi_param->vsi_id;
-	ring_mgt->vsi_info[vsi_index].ring_offset = vsi_param->queue_offset;
-	ring_mgt->vsi_info[vsi_index].ring_num = vsi_param->queue_num;
+	disp_ops->del_lldp_flow(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
 
-	/* init active ring number before first open, guarantee fd direct config check success. */
-	num_cpus = num_online_cpus();
-	ring_mgt->vsi_info[vsi_index].active_ring_num = (u16)num_cpus > vsi_param->queue_num ?
-							vsi_param->queue_num : (u16)num_cpus;
+static int nbl_serv_start_mgt_flow(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	/**
-	 * Clear cfgs, in case this function exited abnormaly last time.
-	 * only for data vsi, vf in vm only support data vsi.
-	 * DPDK user vsi can not leak resource.
-	 */
-	if (vsi_index == NBL_VSI_DATA)
-		disp_ops->clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_param->vsi_id);
-	disp_ops->register_vsi_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
-				    vsi_param->queue_offset, vsi_param->queue_num);
+	return disp_ops->setup_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
 
-	return disp_ops->register_vsi2q(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
-					vsi_param->vsi_id, vsi_param->queue_offset,
-					vsi_param->queue_num);
+static void nbl_serv_stop_mgt_flow(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->remove_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
 }
 
-static int nbl_serv_st_open(struct inode *inode, struct file *filep)
+static u32 nbl_serv_get_tx_headroom(void *priv)
 {
-	struct nbl_serv_st_mgt *p = container_of(inode->i_cdev, struct nbl_serv_st_mgt, cdev);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	filep->private_data = p;
+	return disp_ops->get_tx_headroom(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
 
-	return 0;
+/**
+ * This ops get fix product capability from resource layer, this capability fix by product_type, no
+ * need get from ctrl device
+ */
+static bool nbl_serv_get_product_fix_cap(void *priv, enum nbl_fix_cap_type cap_type)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						       cap_type);
 }
 
-static ssize_t nbl_serv_st_write(struct file *file, const char __user *ubuf,
-				 size_t size, loff_t *ppos)
+static int nbl_serv_init_chip(void *priv)
 {
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	struct nbl_common_info *common;
+	struct device *dev;
+	int ret = 0;
+
+	common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	dev = NBL_COMMON_TO_DEV(common);
+
+	ret = disp_ops->init_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "init_chip_module failed\n");
+		goto module_init_fail;
+	}
+
+	ret = disp_ops->queue_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "queue_init failed\n");
+		goto queue_init_fail;
+	}
+
+	ret = disp_ops->vsi_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "vsi_init failed\n");
+		goto vsi_init_fail;
+	}
+
 	return 0;
+
+vsi_init_fail:
+queue_init_fail:
+module_init_fail:
+	return ret;
 }
 
-static ssize_t nbl_serv_st_read(struct file *file, char __user *ubuf, size_t size, loff_t *ppos)
+static int nbl_serv_destroy_chip(void *p)
 {
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)p;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	if (!disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_NEED_DESTROY_CHIP))
+		return 0;
+
+	disp_ops->deinit_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
 	return 0;
 }
 
-static int nbl_serv_st_release(struct inode *inode, struct file *filp)
+static int nbl_serv_configure_msix_map(void *priv, u16 num_net_msix, u16 num_others_msix,
+				       bool net_msix_mask_en)
 {
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->configure_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), num_net_msix,
+					   num_others_msix, net_msix_mask_en);
+	if (ret)
+		return -EIO;
+
 	return 0;
 }
 
-static int nbl_serv_process_passthrough(struct nbl_service_mgt *serv_mgt,
-					unsigned int cmd, unsigned long arg)
+static int nbl_serv_destroy_msix_map(void *priv)
 {
-	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
-	struct nbl_passthrough_fw_cmd_param *param = NULL, *result = NULL;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
 	int ret = 0;
 
-	if (st_mgt->real_st_name_valid)
-		return -EOPNOTSUPP;
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	param = kzalloc(sizeof(*param), GFP_KERNEL);
-	if (!param)
-		goto alloc_param_fail;
+	ret = disp_ops->destroy_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return -EIO;
 
-	result = kzalloc(sizeof(*result), GFP_KERNEL);
-	if (!result)
-		goto alloc_result_fail;
+	return 0;
+}
+
+static int nbl_serv_enable_mailbox_irq(void *priv, u16 vector_id, bool enable_msix)
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
+static int nbl_serv_enable_abnormal_irq(void *priv, u16 vector_id, bool enable_msix)
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
+static int nbl_serv_request_net_irq(void *priv, struct nbl_msix_info_param *msix_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
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
+		snprintf(vector->name, sizeof(vector->name), "nbl_txrx%d@pci:%s",
+			 i, pci_name(NBL_COMMON_TO_PDEV(common)));
+		ret = devm_request_irq(dev, irq_num, nbl_serv_clean_rings, 0,
+				       vector->name, vector);
+		if (ret) {
+			nbl_err(common, NBL_DEBUG_INTR, "TxRx Queue %u req irq with error %d",
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
+static void nbl_serv_free_net_irq(void *priv, struct nbl_msix_info_param *msix_info)
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
+static u16 nbl_serv_get_global_vector(void *priv, u16 local_vector_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_global_vector(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_COMMON_TO_VSI_ID(common), local_vector_id);
+}
+
+static u16 nbl_serv_get_msix_entry_id(void *priv, u16 local_vector_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_msix_entry_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_COMMON_TO_VSI_ID(common), local_vector_id);
+}
+
+static u16 nbl_serv_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id, type);
+}
+
+static void nbl_serv_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_eth_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				    eth_mode, eth_id, logic_eth_id);
+}
+
+static void nbl_serv_get_rep_queue_info(void *priv, u16 *queue_num, u16 *queue_size)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_rep_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     queue_num, queue_size);
+}
+
+static void nbl_serv_get_user_queue_info(void *priv, u16 *queue_num, u16 *queue_size, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_user_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      queue_num, queue_size, vsi_id);
+}
+
+static void
+nbl_serv_set_netdev_ops(void *priv, const struct net_device_ops *net_device_ops, bool is_pf)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+
+	dev_info(dev, "set netdev ops:%p is_pf:%d\n", net_device_ops, is_pf);
+	if (is_pf)
+		net_resource_mgt->netdev_ops.pf_netdev_ops = (void *)net_device_ops;
+}
+
+static void nbl_serv_rx_mode_async_task(struct work_struct *work)
+{
+	struct nbl_serv_net_resource_mgt *serv_net_resource_mgt =
+		container_of(work, struct nbl_serv_net_resource_mgt, rx_mode_async);
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
+static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
+{
+	int i = 0;
+
+	INIT_LIST_HEAD(&flow_mgt->vlan_list);
+	for (i = 0; i < NBL_SUBMAC_MAX; i++)
+		INIT_LIST_HEAD(&flow_mgt->submac_list[i]);
+}
+
+static void nbl_serv_register_restore_netdev_queue(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+			       nbl_serv_chan_stop_abnormal_sw_queue_resp, serv_mgt);
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+			       nbl_serv_chan_restore_netdev_queue_resp, serv_mgt);
+
+	chan_ops->register_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt),
+			       NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+			       nbl_serv_chan_restart_netdev_queue_resp, serv_mgt);
+}
+
+static void nbl_serv_set_wake(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+
+	if (!common->is_vf && common->is_ocp)
+		disp_ops->set_wol(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), eth_id, common->wol_ena);
+}
+
+static void nbl_serv_remove_net_resource_mgt(void *priv)
+{
+	struct device *dev;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	dev = NBL_COMMON_TO_DEV(common);
+
+	if (net_resource_mgt) {
+		if (common->is_vf) {
+			nbl_serv_unregister_link_forced_notify(serv_mgt);
+			nbl_serv_unregister_vlan_notify(serv_mgt);
+			nbl_serv_unregister_get_vf_stats(serv_mgt);
+			nbl_serv_unregister_trust_notify(serv_mgt);
+		}
+		nbl_serv_set_wake(serv_mgt);
+		timer_delete_sync(&net_resource_mgt->serv_timer);
+		nbl_common_release_task(&net_resource_mgt->rx_mode_async);
+		nbl_common_release_task(&net_resource_mgt->tx_timeout);
+		if (common->is_vf) {
+			nbl_common_release_task(&net_resource_mgt->update_link_state);
+			nbl_common_release_task(&net_resource_mgt->update_vlan);
+		}
+		devm_kfree(dev, net_resource_mgt);
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
+		ret = disp_ops->set_wol(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), eth_id, false);
+
+	return ret;
+}
+
+static int nbl_serv_init_hw_stats(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+	struct nbl_ustore_stats ustore_stats = {0};
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
+		ret = disp_ops->get_ustore_total_pkt_drop_stats(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+								eth_id, &ustore_stats);
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
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+
+	devm_kfree(dev, net_resource_mgt->hw_stats.total_uvn_stat_pkt_drop);
+	return 0;
+}
+
+static int nbl_serv_setup_net_resource_mgt(void *priv, struct net_device *netdev,
+					   u16 vlan_proto, u16 vlan_tci, u32 rate)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	u32 delay_time;
+	unsigned long hw_stats_delay_time = 0;
+
+	net_resource_mgt = devm_kzalloc(dev, sizeof(struct nbl_serv_net_resource_mgt), GFP_KERNEL);
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
+	if (common->is_vf) {
+		nbl_serv_register_link_forced_notify(serv_mgt);
+		nbl_serv_register_vlan_notify(serv_mgt);
+		nbl_serv_register_get_vf_stats(serv_mgt);
+		nbl_serv_register_trust_notify(serv_mgt);
+	}
+	net_resource_mgt->hw_stats_period = NBL_HW_STATS_PERIOD_SECONDS * HZ;
+	get_random_bytes(&delay_time, sizeof(delay_time));
+	hw_stats_delay_time = delay_time % net_resource_mgt->hw_stats_period;
+	timer_setup(&net_resource_mgt->serv_timer, nbl_serv_net_task_service_timer, 0);
+
+	net_resource_mgt->serv_timer_period = HZ;
+	nbl_common_alloc_task(&net_resource_mgt->rx_mode_async, nbl_serv_rx_mode_async_task);
+	nbl_common_alloc_task(&net_resource_mgt->tx_timeout, nbl_serv_handle_tx_timeout);
+	if (common->is_vf) {
+		nbl_common_alloc_task(&net_resource_mgt->update_link_state,
+				      nbl_serv_update_link_state);
+		nbl_common_alloc_task(&net_resource_mgt->update_vlan,
+				      nbl_serv_update_vlan);
+	}
+
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_add_filter_list);
+	INIT_LIST_HEAD(&net_resource_mgt->tmp_del_filter_list);
+	INIT_LIST_HEAD(&net_resource_mgt->indr_dev_priv_list);
+	net_resource_mgt->get_stats_jiffies = jiffies;
+
+	mod_timer(&net_resource_mgt->serv_timer,
+		  jiffies + net_resource_mgt->serv_timer_period +
+		  hw_stats_delay_time);
+
+	return 0;
+}
+
+static int nbl_serv_enable_adminq_irq(void *priv, u16 vector_id, bool enable_msix)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
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
+static u8 __iomem *nbl_serv_get_hw_addr(void *priv, size_t *size)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_hw_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), size);
+}
+
+static u16 nbl_serv_get_function_id(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static void nbl_serv_get_real_bdf(void *priv, u16 vsi_id, u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_real_bdf(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				      bus, dev, function);
+}
+
+static bool nbl_serv_check_fw_heartbeat(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->check_fw_heartbeat(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static bool nbl_serv_check_fw_reset(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->check_fw_reset(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_get_common_irq_num(void *priv, struct nbl_common_irq_num *irq_num)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	irq_num->mbx_irq_num = disp_ops->get_mbx_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_get_ctrl_irq_num(void *priv, struct nbl_ctrl_irq_num *irq_num)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	irq_num->adminq_irq_num = disp_ops->get_adminq_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	irq_num->abnormal_irq_num =
+		disp_ops->get_abnormal_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_get_port_attributes(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->get_port_attributes(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int nbl_serv_update_template_config(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int ret = 0;
+
+	ret = disp_ops->update_ring_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int nbl_serv_get_part_number(void *priv, char *part_number)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_part_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), part_number);
+}
+
+static int nbl_serv_get_serial_number(void *priv, char *serial_number)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_serial_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), serial_number);
+}
+
+static int nbl_serv_enable_port(void *priv, bool enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->enable_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), enable);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static void nbl_serv_init_port(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->init_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	if (NBL_COMMON_TO_VF_CAP(common))
+		return 0;
+	else
+		return disp_ops->set_eth_mac_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						  mac, eth_id);
+}
+
+static void nbl_serv_adapt_desc_gother(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	if (test_bit(NBL_FLAG_HIGH_THROUGHPUT, &serv_mgt->flags))
+		disp_ops->set_desc_high_throughput(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	else
+		disp_ops->adapt_desc_gother(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_process_flr(void *priv, u16 vfid)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->flr_clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_flows(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_interrupt(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+}
+
+static u16 nbl_serv_covert_vfid_to_vsi_id(void *priv, u16 vfid)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->covert_vfid_to_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+}
+
+static void nbl_serv_recovery_abnormal(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->unmask_all_interrupts(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_keep_alive(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->keep_alive(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_register_vsi_info(void *priv, struct nbl_vsi_param *vsi_param)
+{
+	u16 vsi_index = vsi_param->index;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u32 num_cpus;
+
+	ring_mgt->vsi_info[vsi_index].vsi_index = vsi_index;
+	ring_mgt->vsi_info[vsi_index].vsi_id = vsi_param->vsi_id;
+	ring_mgt->vsi_info[vsi_index].ring_offset = vsi_param->queue_offset;
+	ring_mgt->vsi_info[vsi_index].ring_num = vsi_param->queue_num;
+
+	/* init active ring number before first open, guarantee fd direct config check success. */
+	num_cpus = num_online_cpus();
+	ring_mgt->vsi_info[vsi_index].active_ring_num = (u16)num_cpus > vsi_param->queue_num ?
+							vsi_param->queue_num : (u16)num_cpus;
+
+	/**
+	 * Clear cfgs, in case this function exited abnormaly last time.
+	 * only for data vsi, vf in vm only support data vsi.
+	 * DPDK user vsi can not leak resource.
+	 */
+	if (vsi_index == NBL_VSI_DATA)
+		disp_ops->clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_param->vsi_id);
+	disp_ops->register_vsi_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
+				    vsi_param->queue_offset, vsi_param->queue_num);
+
+	return disp_ops->register_vsi2q(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
+					vsi_param->vsi_id, vsi_param->queue_offset,
+					vsi_param->queue_num);
+}
+
+static int nbl_serv_st_open(struct inode *inode, struct file *filep)
+{
+	struct nbl_serv_st_mgt *p = container_of(inode->i_cdev, struct nbl_serv_st_mgt, cdev);
+
+	filep->private_data = p;
+
+	return 0;
+}
+
+static ssize_t nbl_serv_st_write(struct file *file, const char __user *ubuf,
+				 size_t size, loff_t *ppos)
+{
+	return 0;
+}
+
+static ssize_t nbl_serv_st_read(struct file *file, char __user *ubuf, size_t size, loff_t *ppos)
+{
+	return 0;
+}
+
+static int nbl_serv_st_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int nbl_serv_process_passthrough(struct nbl_service_mgt *serv_mgt,
+					unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_passthrough_fw_cmd_param *param = NULL, *result = NULL;
+	int ret = 0;
+
+	if (st_mgt->real_st_name_valid)
+		return -EOPNOTSUPP;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		goto alloc_param_fail;
+
+	result = kzalloc(sizeof(*result), GFP_KERNEL);
+	if (!result)
+		goto alloc_result_fail;
 
 	ret = copy_from_user(param, (void *)arg, _IOC_SIZE(cmd));
 	if (ret) {
-		nbl_err(common, NBL_DEBUG_ST, "Bad access %d.\n", ret);
+		nbl_err(common, NBL_DEBUG_ST, "Bad access %d.\n", ret);
+		return ret;
+	}
+
+	nbl_debug(common, NBL_DEBUG_ST, "Passthough opcode: %d\n", param->opcode);
+
+	ret = disp_ops->passthrough_fw_cmd(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), param, result);
+	if (ret)
+		goto passthrough_fail;
+
+	ret = copy_to_user((void *)arg, result, _IOC_SIZE(cmd));
+
+passthrough_fail:
+	kfree(result);
+alloc_result_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+static int nbl_serv_process_st_info(struct nbl_service_mgt *serv_mgt,
+				    unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_st_info_param *param = NULL;
+	int ret = 0;
+
+	nbl_debug(common, NBL_DEBUG_ST, "Get st info\n");
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	strscpy(param->driver_name, NBL_DRIVER_NAME, sizeof(param->driver_name));
+	if (net_resource_mgt->netdev)
+		strscpy(param->netdev_name[0], net_resource_mgt->netdev->name,
+			sizeof(param->netdev_name[0]));
+
+	strscpy(param->driver_ver, NBL_DRIVER_VERSION, sizeof(param->driver_ver));
+
+	param->bus = common->bus;
+	param->devid = common->devid;
+	param->function = common->function;
+	param->domain = pci_domain_nr(NBL_COMMON_TO_PDEV(common)->bus);
+
+	param->version = IOCTL_ST_INFO_VERSION;
+
+	param->real_chrdev_flag = st_mgt->real_st_name_valid;
+	if (st_mgt->real_st_name_valid)
+		memcpy(param->real_chrdev_name, st_mgt->real_st_name,
+		       sizeof(param->real_chrdev_name));
+
+	ret = copy_to_user((void *)arg, param, _IOC_SIZE(cmd));
+
+	kfree(param);
+	return ret;
+}
+
+static long nbl_serv_st_unlock_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_st_mgt *st_mgt = file->private_data;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)st_mgt->serv_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	int ret = 0;
+
+	if (_IOC_TYPE(cmd) != IOCTL_TYPE) {
+		nbl_err(common, NBL_DEBUG_ST, "cmd %u, bad magic 0x%x/0x%x.\n",
+			cmd, _IOC_TYPE(cmd), IOCTL_TYPE);
+		return -ENOTTY;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	if (ret) {
+		nbl_err(common, NBL_DEBUG_ST, "Bad access.\n");
+		return ret;
+	}
+
+	switch (cmd) {
+	case IOCTL_PASSTHROUGH:
+		ret = nbl_serv_process_passthrough(serv_mgt, cmd, arg);
+		break;
+	case IOCTL_ST_INFO:
+		ret = nbl_serv_process_st_info(serv_mgt, cmd, arg);
+		break;
+	default:
+		nbl_err(common, NBL_DEBUG_ST, "Unknown cmd %d.\n", cmd);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+static const struct file_operations st_ops = {
+	.owner = THIS_MODULE,
+	.open = nbl_serv_st_open,
+	.write = nbl_serv_st_write,
+	.read = nbl_serv_st_read,
+	.unlocked_ioctl = nbl_serv_st_unlock_ioctl,
+	.release = nbl_serv_st_release,
+};
+
+static int nbl_serv_alloc_subdev_id(struct nbl_software_tool_table *st_table)
+{
+	int subdev_id;
+
+	subdev_id = find_first_zero_bit(st_table->devid, NBL_ST_MAX_DEVICE_NUM);
+	if (subdev_id == NBL_ST_MAX_DEVICE_NUM)
+		return -ENOSPC;
+	set_bit(subdev_id, st_table->devid);
+
+	return subdev_id;
+}
+
+static void nbl_serv_free_subdev_id(struct nbl_software_tool_table *st_table, int id)
+{
+	clear_bit(id, st_table->devid);
+}
+
+static void nbl_serv_register_real_st_name(void *priv, char *st_name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+
+	st_mgt->real_st_name_valid = true;
+	memcpy(st_mgt->real_st_name, st_name, NBL_RESTOOL_NAME_LEN);
+}
+
+static int nbl_serv_setup_st(void *priv, void *st_table_param, char *st_name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct device *char_device;
+	char name[NBL_RESTOOL_NAME_LEN] = {0};
+	dev_t devid;
+	int id, subdev_id, ret = 0;
+
+	id = NBL_COMMON_TO_BOARD_ID(common);
+
+	subdev_id = nbl_serv_alloc_subdev_id(st_table);
+	if (subdev_id < 0)
+		goto alloc_subdev_id_fail;
+
+	devid = MKDEV(st_table->major, subdev_id);
+
+	if (!NBL_COMMON_TO_PCI_FUNC_ID(common))
+		snprintf(name, sizeof(name), "nblst%04x_conf%d",
+			 NBL_COMMON_TO_PDEV(common)->device, id);
+	else
+		snprintf(name, sizeof(name), "nblst%04x_conf%d.%d",
+			 NBL_COMMON_TO_PDEV(common)->device, id, NBL_COMMON_TO_PCI_FUNC_ID(common));
+
+	st_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(*st_mgt), GFP_KERNEL);
+	if (!st_mgt)
+		goto malloc_fail;
+
+	st_mgt->serv_mgt = serv_mgt;
+
+	st_mgt->major = MAJOR(devid);
+	st_mgt->minor = MINOR(devid);
+	st_mgt->devno = devid;
+	st_mgt->subdev_id = subdev_id;
+
+	cdev_init(&st_mgt->cdev, &st_ops);
+	ret = cdev_add(&st_mgt->cdev, devid, 1);
+	if (ret)
+		goto cdev_add_fail;
+
+	char_device = device_create(st_table->cls, NULL, st_mgt->devno, NULL, name);
+	if (IS_ERR(char_device)) {
+		ret = -EBUSY;
+		goto device_create_fail;
+	}
+
+	memcpy(st_name, name, NBL_RESTOOL_NAME_LEN);
+	memcpy(st_mgt->st_name, name, NBL_RESTOOL_NAME_LEN);
+	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = st_mgt;
+	return 0;
+
+device_create_fail:
+	cdev_del(&st_mgt->cdev);
+cdev_add_fail:
+	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
+malloc_fail:
+	nbl_serv_free_subdev_id(st_table, subdev_id);
+alloc_subdev_id_fail:
+	return ret;
+}
+
+static void nbl_serv_remove_st(void *priv, void *st_table_param)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	if (!st_mgt)
+		return;
+
+	device_destroy(st_table->cls, st_mgt->devno);
+	cdev_del(&st_mgt->cdev);
+
+	nbl_serv_free_subdev_id(st_table, st_mgt->subdev_id);
+
+	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = NULL;
+	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
+}
+
+static int nbl_serv_set_spoof_check_addr(void *priv, u8 *mac)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	return disp_ops->set_spoof_check_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					      NBL_COMMON_TO_VSI_ID(common), mac);
+}
+
+static int nbl_serv_get_board_id(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_board_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_process_abnormal_event(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_abnormal_event_info abnomal_info;
+	struct nbl_abnormal_details *detail;
+	u16 local_queue_id;
+	int type, i, ret = 0;
+
+	memset(&abnomal_info, 0, sizeof(abnomal_info));
+
+	ret = disp_ops->process_abnormal_event(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &abnomal_info);
+	if (!ret)
+		return ret;
+
+	for (i = 0; i < NBL_ABNORMAL_EVENT_MAX; i++) {
+		detail = &abnomal_info.details[i];
+
+		if (!detail->abnormal)
+			continue;
+
+		type = nbl_serv_abnormal_event_to_queue(i);
+		local_queue_id = disp_ops->get_local_queue_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							      detail->vsi_id, detail->qid);
+		if (local_queue_id == U16_MAX)
+			return 0;
+
+		nbl_serv_restore_queue(serv_mgt, detail->vsi_id, local_queue_id, type, true);
+	}
+
+	return 0;
+}
+
+static ssize_t nbl_serv_vf_mac_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "usage: write MAC ADDR to set mac address\n");
+}
+
+static ssize_t nbl_serv_vf_mac_store(struct kobject *kobj, struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	u8 mac[ETH_ALEN];
+	int ret = 0;
+
+	ret = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+		     &mac[0], &mac[1], &mac[2], &mac[3], &mac[4], &mac[5]);
+	if (ret != ETH_ALEN)
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_mac(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				  vf_info->vf_id, mac);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_trust_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "usage: write <ON|OFF> to set vf trust\n");
+}
+
+static ssize_t nbl_serv_vf_trust_store(struct kobject *kobj, struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	bool trusted = false;
+	int ret = 0;
+
+	if (sysfs_streq(buf, "ON"))
+		trusted = true;
+	else if (sysfs_streq(buf, "OFF"))
+		trusted = false;
+	else
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_trust(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				    vf_info->vf_id, trusted);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_vlan_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "usage: wr <Vlan:Qos[:Proto]> to set VF Vlan,Qos,and Protocol\n");
+}
+
+static ssize_t nbl_serv_vf_vlan_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	char vproto_ext[5] = {'\0'};
+	__be16 vlan_proto;
+	u16 vlan_id;
+	u8 qos;
+	int ret = 0;
+
+	ret = sscanf(buf, "%hu:%hhu:802.%4s", &vlan_id, &qos, vproto_ext);
+	if (ret == 3) {
+		if ((strcmp(vproto_ext, "1AD") == 0) ||
+		    (strcmp(vproto_ext, "1ad") == 0))
+			vlan_proto = htons(ETH_P_8021AD);
+		else if ((strcmp(vproto_ext, "1Q") == 0) ||
+			 (strcmp(vproto_ext, "1q") == 0))
+			vlan_proto = htons(ETH_P_8021Q);
+		else
+			return -EINVAL;
+	} else {
+		ret = sscanf(buf, "%hu:%hhu", &vlan_id, &qos);
+		if (ret != 2)
+			return -EINVAL;
+		vlan_proto = htons(ETH_P_8021Q);
+	}
+
+	ret = nbl_serv_set_vf_vlan(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				   vf_info->vf_id, vlan_id, qos, vlan_proto);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_max_tx_rate_show(struct kobject *kobj, struct kobj_attribute *attr,
+					    char *buf)
+{
+	return sprintf(buf, "usage: write RATE to set max_tx_rate(Mbps)\n");
+}
+
+static ssize_t nbl_serv_vf_max_tx_rate_store(struct kobject *kobj, struct kobj_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	int max_tx_rate = 0, ret = 0;
+
+	ret = kstrtos32(buf, 0, &max_tx_rate);
+	if (ret)
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_rate(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				   vf_info->vf_id, 0, max_tx_rate);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_spoofchk_show(struct kobject *kobj, struct kobj_attribute *attr,
+					 char *buf)
+{
+	return sprintf(buf, "usage: write <ON|OFF> to set vf spoof check\n");
+}
+
+static ssize_t nbl_serv_vf_spoofchk_store(struct kobject *kobj, struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	bool enable = false;
+	int ret = 0;
+
+	if (sysfs_streq(buf, "ON"))
+		enable = true;
+	else if (sysfs_streq(buf, "OFF"))
+		enable = false;
+	else
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_spoofchk(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				       vf_info->vf_id, enable);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_link_state_show(struct kobject *kobj, struct kobj_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "usage: write <AUTO|ENABLE|DISABLE> to set vf link state\n");
+}
+
+static ssize_t nbl_serv_vf_link_state_store(struct kobject *kobj, struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	int state = 0, ret = 0;
+
+	if (sysfs_streq(buf, "AUTO"))
+		state = IFLA_VF_LINK_STATE_AUTO;
+	else if (sysfs_streq(buf, "ENABLE"))
+		state = IFLA_VF_LINK_STATE_ENABLE;
+	else if (sysfs_streq(buf, "DISABLE"))
+		state = IFLA_VF_LINK_STATE_DISABLE;
+	else
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_link_state(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+					 vf_info->vf_id, state);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_stats_show(struct kobject *kobj, struct kobj_attribute *attr,
+				      char *buf)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct net_device *netdev = serv_mgt->net_resource_mgt->netdev;
+	struct ifla_vf_stats stats = { 0 };
+	int ret = 0;
+
+	ret = nbl_serv_get_vf_stats(netdev, vf_info->vf_id, &stats);
+	if (ret) {
+		netdev_info(netdev, "get_vf %d stats failed %d\n", vf_info->vf_id, ret);
 		return ret;
 	}
 
-	nbl_debug(common, NBL_DEBUG_ST, "Passthough opcode: %d\n", param->opcode);
+	return scnprintf(buf, PAGE_SIZE,
+		"tx_packets      : %llu\n"
+		"tx_bytes        : %llu\n"
+		"tx_dropped      : %llu\n"
+		"rx_packets      : %llu\n"
+		"rx_bytes        : %llu\n"
+		"rx_dropped      : %llu\n"
+		"rx_broadcast    : %llu\n"
+		"rx_multicast    : %llu\n",
+		stats.tx_packets, stats.tx_bytes, stats.tx_dropped,
+		stats.rx_packets, stats.rx_bytes, stats.rx_dropped,
+		stats.broadcast, stats.multicast
+	);
+}
+
+static ssize_t nbl_serv_vf_tx_rate_show(struct kobject *kobj, struct kobj_attribute *attr,
+					char *buf)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, tx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int rate = net_resource_mgt->vf_info[vf_info->vf_id].meter_tx_rate;
+
+	return sprintf(buf, "max tx rate(Mbps): %d\n", rate);
+}
+
+static ssize_t nbl_serv_vf_tx_rate_store(struct kobject *kobj, struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, tx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	int tx_rate = 0, ret = 0;
+
+	ret = kstrtos32(buf, 0, &tx_rate);
+	if (ret)
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_tx_rate(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				      vf_info->vf_id, tx_rate, 0, false);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_tx_burst_show(struct kobject *kobj, struct kobj_attribute *attr,
+					 char *buf)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, tx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int burst = net_resource_mgt->vf_info[vf_info->vf_id].meter_tx_burst;
+
+	return sprintf(buf, "max burst depth %d\n", burst);
+}
+
+static ssize_t nbl_serv_vf_tx_burst_store(struct kobject *kobj, struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, tx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int burst = 0, ret = 0;
+	int rate = net_resource_mgt->vf_info[vf_info->vf_id].meter_tx_rate;
+
+	ret = kstrtos32(buf, 0, &burst);
+	if (ret)
+		return -EINVAL;
+	if (burst >= NBL_MAX_BURST)
+		return -EINVAL;
+
+	if (rate || !burst)
+		ret = nbl_serv_set_vf_tx_rate(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+					      vf_info->vf_id, rate, burst, true);
+	else
+		return -EINVAL;
+
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_rx_rate_show(struct kobject *kobj, struct kobj_attribute *attr,
+					char *buf)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, rx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int rate = net_resource_mgt->vf_info[vf_info->vf_id].meter_rx_rate;
+
+	return sprintf(buf, "max rx rate(Mbps): %d\n", rate);
+}
+
+static ssize_t nbl_serv_vf_rx_rate_store(struct kobject *kobj, struct kobj_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, rx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	int rx_rate = 0, ret = 0;
+
+	ret = kstrtos32(buf, 0, &rx_rate);
+	if (ret)
+		return -EINVAL;
+
+	ret = nbl_serv_set_vf_rx_rate(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+				      vf_info->vf_id, rx_rate, 0, false);
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_rx_burst_show(struct kobject *kobj, struct kobj_attribute *attr,
+					 char *buf)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, rx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int burst = net_resource_mgt->vf_info[vf_info->vf_id].meter_rx_burst;
+
+	return sprintf(buf, "max burst depth %d\n", burst);
+}
+
+static ssize_t nbl_serv_vf_rx_burst_store(struct kobject *kobj, struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct nbl_serv_vf_info *vf_info = container_of(kobj, struct nbl_serv_vf_info, rx_bps_kobj);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)vf_info->priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	int burst = 0, ret = 0;
+	int rate = net_resource_mgt->vf_info[vf_info->vf_id].meter_rx_rate;
+
+	ret = kstrtos32(buf, 0, &burst);
+	if (ret)
+		return -EINVAL;
+	if (burst > NBL_MAX_BURST)
+		return -EINVAL;
+
+	if (rate || !burst)
+		ret = nbl_serv_set_vf_rx_rate(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)->netdev,
+					      vf_info->vf_id, rate, burst, true);
+	else
+		return -EINVAL;
+
+	return ret ? ret : count;
+}
+
+static ssize_t nbl_serv_vf_config_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct kobj_attribute *kattr = container_of(attr, struct kobj_attribute, attr);
+
+	if (kattr->show)
+		return kattr->show(kobj, kattr, buf);
+
+	return -EIO;
+}
+
+static ssize_t nbl_serv_vf_config_store(struct kobject *kobj, struct attribute *attr,
+					const char *buf, size_t count)
+{
+	struct kobj_attribute *kattr = container_of(attr, struct kobj_attribute, attr);
+
+	if (kattr->show)
+		return kattr->store(kobj, kattr, buf, count);
+
+	return -EIO;
+}
+
+static void dir_release(struct kobject *kobj)
+{
+}
+
+static struct kobj_attribute nbl_attr_vf_mac = {
+	.attr = {.name = "mac",
+		 .mode = 0644},
+	.show = nbl_serv_vf_mac_show,
+	.store = nbl_serv_vf_mac_store,
+};
+
+static struct kobj_attribute nbl_attr_vf_vlan = {
+	.attr = {.name = "vlan",
+		 .mode = 0644},
+	.show = nbl_serv_vf_vlan_show,
+	.store = nbl_serv_vf_vlan_store,
+};
+
+static struct kobj_attribute nbl_attr_vf_trust = {
+	.attr = {.name = "trust",
+		 .mode = 0644},
+	.show = nbl_serv_vf_trust_show,
+	.store = nbl_serv_vf_trust_store,
+};
 
-	ret = disp_ops->passthrough_fw_cmd(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), param, result);
-	if (ret)
-		goto passthrough_fail;
+static struct kobj_attribute nbl_attr_vf_max_tx_rate = {
+	.attr = {.name = "max_tx_rate",
+		 .mode = 0644},
+	.show = nbl_serv_vf_max_tx_rate_show,
+	.store = nbl_serv_vf_max_tx_rate_store,
+};
 
-	ret = copy_to_user((void *)arg, result, _IOC_SIZE(cmd));
+static struct kobj_attribute nbl_attr_vf_spoofcheck = {
+	.attr = {.name = "spoofcheck",
+		 .mode = 0644},
+	.show = nbl_serv_vf_spoofchk_show,
+	.store = nbl_serv_vf_spoofchk_store,
+};
 
-passthrough_fail:
-	kfree(result);
-alloc_result_fail:
-	kfree(param);
-alloc_param_fail:
-	return ret;
-}
+static struct kobj_attribute nbl_attr_vf_tx_rate = {
+	.attr = {.name = "rate",
+		 .mode = 0644},
+	.show = nbl_serv_vf_tx_rate_show,
+	.store = nbl_serv_vf_tx_rate_store,
+};
 
-static int nbl_serv_process_st_info(struct nbl_service_mgt *serv_mgt,
-				    unsigned int cmd, unsigned long arg)
-{
-	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
-	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
-	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
-	struct nbl_st_info_param *param = NULL;
-	int ret = 0;
+static struct kobj_attribute nbl_attr_vf_tx_burst = {
+	.attr = {.name = "burst",
+		 .mode = 0644},
+	.show = nbl_serv_vf_tx_burst_show,
+	.store = nbl_serv_vf_tx_burst_store,
+};
 
-	nbl_debug(common, NBL_DEBUG_ST, "Get st info\n");
+static struct kobj_attribute nbl_attr_vf_rx_rate = {
+	.attr = {.name = "rate",
+		 .mode = 0644},
+	.show = nbl_serv_vf_rx_rate_show,
+	.store = nbl_serv_vf_rx_rate_store,
+};
 
-	param = kzalloc(sizeof(*param), GFP_KERNEL);
-	if (!param)
-		return -ENOMEM;
+static struct kobj_attribute nbl_attr_vf_rx_burst = {
+	.attr = {.name = "burst",
+		 .mode = 0644},
+	.show = nbl_serv_vf_rx_burst_show,
+	.store = nbl_serv_vf_rx_burst_store,
+};
 
-	strscpy(param->driver_name, NBL_DRIVER_NAME, sizeof(param->driver_name));
-	if (net_resource_mgt->netdev)
-		strscpy(param->netdev_name[0], net_resource_mgt->netdev->name,
-			sizeof(param->netdev_name[0]));
+static struct kobj_attribute nbl_attr_vf_link_state = {
+	.attr = {.name = "link_state",
+		 .mode = 0644},
+	.show = nbl_serv_vf_link_state_show,
+	.store = nbl_serv_vf_link_state_store,
+};
 
-	strscpy(param->driver_ver, NBL_DRIVER_VERSION, sizeof(param->driver_ver));
+static struct kobj_attribute nbl_attr_vf_stats = {
+	.attr = {.name = "stats",
+		 .mode = 0444},
+	.show = nbl_serv_vf_stats_show,
+};
 
-	param->bus = common->bus;
-	param->devid = common->devid;
-	param->function = common->function;
-	param->domain = pci_domain_nr(NBL_COMMON_TO_PDEV(common)->bus);
+static struct attribute *nbl_vf_config_attrs[] = {
+	&nbl_attr_vf_mac.attr,
+	&nbl_attr_vf_vlan.attr,
+	&nbl_attr_vf_trust.attr,
+	&nbl_attr_vf_max_tx_rate.attr,
+	&nbl_attr_vf_spoofcheck.attr,
+	&nbl_attr_vf_link_state.attr,
+	&nbl_attr_vf_stats.attr,
+	NULL,
+};
 
-	param->version = IOCTL_ST_INFO_VERSION;
+ATTRIBUTE_GROUPS(nbl_vf_config);
 
-	param->real_chrdev_flag = st_mgt->real_st_name_valid;
-	if (st_mgt->real_st_name_valid)
-		memcpy(param->real_chrdev_name, st_mgt->real_st_name,
-		       sizeof(param->real_chrdev_name));
+static struct attribute *nbl_vf_tx_config_attrs[] = {
+	&nbl_attr_vf_tx_rate.attr,
+	&nbl_attr_vf_tx_burst.attr,
+	NULL,
+};
 
-	ret = copy_to_user((void *)arg, param, _IOC_SIZE(cmd));
+ATTRIBUTE_GROUPS(nbl_vf_tx_config);
 
-	kfree(param);
-	return ret;
-}
+static struct attribute *nbl_vf_rx_config_attrs[] = {
+	&nbl_attr_vf_rx_rate.attr,
+	&nbl_attr_vf_rx_burst.attr,
+	NULL,
+};
 
-static long nbl_serv_st_unlock_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct nbl_serv_st_mgt *st_mgt = file->private_data;
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)st_mgt->serv_mgt;
-	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
-	int ret = 0;
+ATTRIBUTE_GROUPS(nbl_vf_rx_config);
 
-	if (_IOC_TYPE(cmd) != IOCTL_TYPE) {
-		nbl_err(common, NBL_DEBUG_ST, "cmd %u, bad magic 0x%x/0x%x.\n",
-			cmd, _IOC_TYPE(cmd), IOCTL_TYPE);
-		return -ENOTTY;
-	}
+static const struct sysfs_ops nbl_sysfs_ops_vf = {
+	.show = nbl_serv_vf_config_show,
+	.store = nbl_serv_vf_config_store,
+};
 
-	if (_IOC_DIR(cmd) & _IOC_READ)
-		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
-	else if (_IOC_DIR(cmd) & _IOC_WRITE)
-		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
-	if (ret) {
-		nbl_err(common, NBL_DEBUG_ST, "Bad access.\n");
-		return ret;
-	}
+static const struct kobj_type nbl_kobj_vf_type = {
+	.sysfs_ops = &nbl_sysfs_ops_vf,
+	.default_groups = nbl_vf_config_groups,
+};
 
-	switch (cmd) {
-	case IOCTL_PASSTHROUGH:
-		ret = nbl_serv_process_passthrough(serv_mgt, cmd, arg);
-		break;
-	case IOCTL_ST_INFO:
-		ret = nbl_serv_process_st_info(serv_mgt, cmd, arg);
-		break;
-	default:
-		nbl_err(common, NBL_DEBUG_ST, "Unknown cmd %d.\n", cmd);
-		return -EFAULT;
-	}
+static const struct kobj_type nbl_kobj_dir = {
+	.release = dir_release,
+};
 
-	return ret;
-}
+static const struct kobj_type nbl_kobj_vf_tx_type = {
+	.sysfs_ops = &nbl_sysfs_ops_vf,
+	.default_groups = nbl_vf_tx_config_groups,
+};
 
-static const struct file_operations st_ops = {
-	.owner = THIS_MODULE,
-	.open = nbl_serv_st_open,
-	.write = nbl_serv_st_write,
-	.read = nbl_serv_st_read,
-	.unlocked_ioctl = nbl_serv_st_unlock_ioctl,
-	.release = nbl_serv_st_release,
+static const struct kobj_type nbl_kobj_vf_rx_type = {
+	.sysfs_ops = &nbl_sysfs_ops_vf,
+	.default_groups = nbl_vf_rx_config_groups,
 };
 
-static int nbl_serv_alloc_subdev_id(struct nbl_software_tool_table *st_table)
+static int nbl_serv_setup_vf_sysfs(struct nbl_service_mgt *serv_mgt)
 {
-	int subdev_id;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_vf_info *vf_info = net_resource_mgt->vf_info;
+	int i = 0, ret = 0;
+	int index = 0;
 
-	subdev_id = find_first_zero_bit(st_table->devid, NBL_ST_MAX_DEVICE_NUM);
-	if (subdev_id == NBL_ST_MAX_DEVICE_NUM)
-		return -ENOSPC;
-	set_bit(subdev_id, st_table->devid);
+	for (i = 0; i < net_resource_mgt->num_vfs; i++) {
+		index = i;
+		vf_info[i].priv = serv_mgt;
+		vf_info[i].vf_id = (u16)i;
 
-	return subdev_id;
-}
+		ret = kobject_init_and_add(&vf_info[i].kobj, &nbl_kobj_vf_type,
+					   net_resource_mgt->sriov_kobj, "%d", i);
+		if (ret)
+			goto err;
 
-static void nbl_serv_free_subdev_id(struct nbl_software_tool_table *st_table, int id)
-{
-	clear_bit(id, st_table->devid);
+		ret = kobject_init_and_add(&vf_info[i].meters_kobj, &nbl_kobj_dir,
+					   &vf_info[i].kobj, "meters");
+		if (ret)
+			goto err;
+		ret = kobject_init_and_add(&vf_info[i].rx_kobj, &nbl_kobj_dir,
+					   &vf_info[i].meters_kobj, "rx");
+		if (ret)
+			goto err;
+		ret = kobject_init_and_add(&vf_info[i].tx_kobj, &nbl_kobj_dir,
+					   &vf_info[i].meters_kobj, "tx");
+		if (ret)
+			goto err;
+		ret = kobject_init_and_add(&vf_info[i].rx_bps_kobj, &nbl_kobj_vf_rx_type,
+					   &vf_info[i].rx_kobj, "bps");
+		if (ret)
+			goto err;
+		ret = kobject_init_and_add(&vf_info[i].tx_bps_kobj, &nbl_kobj_vf_tx_type,
+					   &vf_info[i].tx_kobj, "bps");
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (i = 0; i <= index; i++) {
+		if (vf_info[i].tx_bps_kobj.state_initialized)
+			kobject_put(&vf_info[i].tx_bps_kobj);
+		if (vf_info[i].rx_bps_kobj.state_initialized)
+			kobject_put(&vf_info[i].rx_bps_kobj);
+		if (vf_info[i].tx_kobj.state_initialized)
+			kobject_put(&vf_info[i].tx_kobj);
+		if (vf_info[i].tx_kobj.state_initialized)
+			kobject_put(&vf_info[i].tx_kobj);
+		if (vf_info[i].tx_kobj.state_initialized)
+			kobject_put(&vf_info[i].tx_kobj);
+		if (vf_info[i].tx_kobj.state_initialized)
+			kobject_put(&vf_info[i].tx_kobj);
+	}
+
+	return 0;
 }
 
-static void nbl_serv_register_real_st_name(void *priv, char *st_name)
+static void nbl_serv_remove_vf_sysfs(struct nbl_service_mgt *serv_mgt)
 {
-	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_vf_info *vf_info = net_resource_mgt->vf_info;
+	int i = 0;
 
-	st_mgt->real_st_name_valid = true;
-	memcpy(st_mgt->real_st_name, st_name, NBL_RESTOOL_NAME_LEN);
+	for (i = 0; i < net_resource_mgt->num_vfs; i++) {
+		kobject_put(&vf_info[i].tx_bps_kobj);
+		kobject_put(&vf_info[i].rx_bps_kobj);
+		kobject_put(&vf_info[i].tx_kobj);
+		kobject_put(&vf_info[i].rx_kobj);
+		kobject_put(&vf_info[i].meters_kobj);
+		kobject_put(&vf_info[i].kobj);
+	}
 }
 
-static int nbl_serv_setup_st(void *priv, void *st_table_param, char *st_name)
+static int nbl_serv_setup_vf_config(void *priv, int num_vfs, bool is_flush)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_vf_info *vf_info = net_resource_mgt->vf_info;
 	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
-	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
-	struct device *char_device;
-	char name[NBL_RESTOOL_NAME_LEN] = {0};
-	dev_t devid;
-	int id, subdev_id, ret = 0;
+	u16 func_id = U16_MAX;
+	u16 vlan_tci;
+	bool should_notify;
+	int i, ret = 0;
 
-	id = NBL_COMMON_TO_BOARD_ID(common);
+	net_resource_mgt->num_vfs = num_vfs;
 
-	subdev_id = nbl_serv_alloc_subdev_id(st_table);
-	if (subdev_id < 0)
-		goto alloc_subdev_id_fail;
+	for (i = 0; i < net_resource_mgt->num_vfs; i++) {
+		func_id = nbl_serv_get_vf_function_id(serv_mgt, i);
+		if (func_id == U16_MAX) {
+			nbl_err(common, NBL_DEBUG_MAIN, "vf id %d invalid\n", i);
+			return -EINVAL;
+		}
 
-	devid = MKDEV(st_table->major, subdev_id);
+		disp_ops->init_vf_msix_map(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id, !is_flush);
 
-	if (!NBL_COMMON_TO_PCI_FUNC_ID(common))
-		snprintf(name, sizeof(name), "nblst%04x_conf%d",
-			 NBL_COMMON_TO_PDEV(common)->device, id);
-	else
-		snprintf(name, sizeof(name), "nblst%04x_conf%d.%d",
-			 NBL_COMMON_TO_PDEV(common)->device, id, NBL_COMMON_TO_PCI_FUNC_ID(common));
+		disp_ops->register_func_mac(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    vf_info[i].mac, func_id);
 
-	st_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(*st_mgt), GFP_KERNEL);
-	if (!st_mgt)
-		goto malloc_fail;
+		vlan_tci = vf_info[i].vlan | (u16)(vf_info[i].vlan_qos << VLAN_PRIO_SHIFT);
+		ret = disp_ops->register_func_vlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id,
+						   vlan_tci, vf_info[i].vlan_proto,
+						   &should_notify);
+		if (ret)
+			break;
 
-	st_mgt->serv_mgt = serv_mgt;
+		ret = disp_ops->register_func_trust(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						    func_id, vf_info[i].trusted,
+						    &should_notify);
 
-	st_mgt->major = MAJOR(devid);
-	st_mgt->minor = MINOR(devid);
-	st_mgt->devno = devid;
-	st_mgt->subdev_id = subdev_id;
+		if (ret)
+			break;
 
-	cdev_init(&st_mgt->cdev, &st_ops);
-	ret = cdev_add(&st_mgt->cdev, devid, 1);
-	if (ret)
-		goto cdev_add_fail;
+		ret = disp_ops->register_func_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id,
+						   vf_info[i].max_tx_rate);
+		if (ret)
+			break;
 
-	char_device = device_create(st_table->cls, NULL, st_mgt->devno, NULL, name);
-	if (IS_ERR(char_device)) {
-		ret = -EBUSY;
-		goto device_create_fail;
+		ret = disp_ops->set_tx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    func_id, vf_info[i].max_tx_rate, 0);
+		if (ret)
+			break;
+
+		ret = disp_ops->set_rx_rate(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    func_id, vf_info[i].meter_rx_rate, 0);
+		if (ret)
+			break;
+
+		ret = disp_ops->set_vf_spoof_check(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						   NBL_COMMON_TO_VSI_ID(common), i,
+						   vf_info[i].spoof_check);
+		if (ret)
+			break;
+
+		/* No need to notify vf, vf will get link forced when probe,
+		 * Here we only flush the config.
+		 */
+		ret = disp_ops->register_func_link_forced(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							  func_id, vf_info[i].state,
+							  &should_notify);
+		if (ret)
+			break;
 	}
 
-	memcpy(st_name, name, NBL_RESTOOL_NAME_LEN);
-	memcpy(st_mgt->st_name, name, NBL_RESTOOL_NAME_LEN);
-	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = st_mgt;
-	return 0;
+	if (!ret && net_resource_mgt->sriov_kobj && !is_flush)
+		ret = nbl_serv_setup_vf_sysfs(serv_mgt);
+
+	if (ret)
+		net_resource_mgt->num_vfs = 0;
 
-device_create_fail:
-	cdev_del(&st_mgt->cdev);
-cdev_add_fail:
-	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
-malloc_fail:
-	nbl_serv_free_subdev_id(st_table, subdev_id);
-alloc_subdev_id_fail:
 	return ret;
 }
 
-static void nbl_serv_remove_st(void *priv, void *st_table_param)
+static void nbl_serv_remove_vf_config(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
-	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
-	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_vf_info *vf_info = net_resource_mgt->vf_info;
+	int i;
 
-	if (!st_mgt)
-		return;
+	nbl_serv_remove_vf_sysfs(serv_mgt);
 
-	device_destroy(st_table->cls, st_mgt->devno);
-	cdev_del(&st_mgt->cdev);
+	for (i = 0; i < net_resource_mgt->num_vfs; i++)
+		memset(&vf_info[i], 0, sizeof(vf_info[i]));
 
-	nbl_serv_free_subdev_id(st_table, st_mgt->subdev_id);
+	nbl_serv_setup_vf_config(priv, net_resource_mgt->num_vfs, true);
 
-	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = NULL;
-	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
+	net_resource_mgt->num_vfs = 0;
 }
 
-static int nbl_serv_get_board_id(void *priv)
+static void nbl_serv_register_dev_name(void *priv, u16 vsi_id, char *name)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
 
-	return disp_ops->get_board_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	disp_ops->register_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, name);
 }
 
-static int nbl_serv_process_abnormal_event(void *priv)
+static void nbl_serv_get_dev_name(void *priv, u16 vsi_id, char *name)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
 	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
-	struct nbl_abnormal_event_info abnomal_info;
-	struct nbl_abnormal_details *detail;
-	u16 local_queue_id;
-	int type, i, ret = 0;
-
-	memset(&abnomal_info, 0, sizeof(abnomal_info));
 
-	ret = disp_ops->process_abnormal_event(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &abnomal_info);
-	if (!ret)
-		return ret;
+	disp_ops->get_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, name);
+}
 
-	for (i = 0; i < NBL_ABNORMAL_EVENT_MAX; i++) {
-		detail = &abnomal_info.details[i];
+static int nbl_serv_setup_vf_resource(void *priv, int num_vfs)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_vf_info *vf_info;
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+	int i;
 
-		if (!detail->abnormal)
-			continue;
+	net_resource_mgt->total_vfs = num_vfs;
 
-		type = nbl_serv_abnormal_event_to_queue(i);
-		local_queue_id = disp_ops->get_local_queue_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
-							      detail->vsi_id, detail->qid);
-		if (local_queue_id == U16_MAX)
-			return 0;
+	net_resource_mgt->vf_info = devm_kcalloc(dev, net_resource_mgt->total_vfs,
+						 sizeof(struct nbl_serv_vf_info), GFP_KERNEL);
+	if (!net_resource_mgt->vf_info)
+		return -ENOMEM;
 
-		nbl_serv_restore_queue(serv_mgt, detail->vsi_id, local_queue_id, type, true);
+	vf_info = net_resource_mgt->vf_info;
+	for (i = 0; i < net_resource_mgt->total_vfs; i++) {
+		vf_info[i].state = IFLA_VF_LINK_STATE_AUTO;
+		vf_info[i].spoof_check = false;
 	}
 
+	net_resource_mgt->sriov_kobj = kobject_create_and_add("sriov", &dev->kobj);
+	if (!net_resource_mgt->sriov_kobj)
+		nbl_warn(NBL_SERV_MGT_TO_COMMON(serv_mgt), NBL_DEBUG_MAIN,
+			 "Fail to create sriov sysfs");
+
 	return 0;
 }
 
-static void nbl_serv_register_dev_name(void *priv, u16 vsi_id, char *name)
+static void nbl_serv_remove_vf_resource(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
-	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
 
-	disp_ops->register_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, name);
+	nbl_serv_remove_vf_config(priv);
+
+	kobject_put(net_resource_mgt->sriov_kobj);
+
+	if (net_resource_mgt->vf_info) {
+		devm_kfree(dev, net_resource_mgt->vf_info);
+		net_resource_mgt->vf_info = NULL;
+	}
 }
 
 static void nbl_serv_set_hw_status(void *priv, enum nbl_hw_status hw_status)
@@ -1511,6 +4199,15 @@ static struct nbl_service_ops serv_ops = {
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
@@ -1523,22 +4220,47 @@ static struct nbl_service_ops serv_ops = {
 
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
 	.get_product_fix_cap	= nbl_serv_get_product_fix_cap,
+	.set_spoof_check_addr = nbl_serv_set_spoof_check_addr,
 
 	.vsi_open = nbl_serv_vsi_open,
 	.vsi_stop = nbl_serv_vsi_stop,
 	/* For netdev ops */
 	.netdev_open = nbl_serv_netdev_open,
 	.netdev_stop = nbl_serv_netdev_stop,
+	.change_mtu = nbl_serv_change_mtu,
+
 	.rx_add_vid = nbl_serv_rx_add_vid,
 	.rx_kill_vid = nbl_serv_rx_kill_vid,
 	.get_stats64 = nbl_serv_get_stats64,
+
 	.get_rep_queue_info = nbl_serv_get_rep_queue_info,
 	.get_user_queue_info = nbl_serv_get_user_queue_info,
 
@@ -1546,7 +4268,10 @@ static struct nbl_service_ops serv_ops = {
 
 	.get_vsi_id = nbl_serv_get_vsi_id,
 	.get_eth_id = nbl_serv_get_eth_id,
-
+	.setup_net_resource_mgt = nbl_serv_setup_net_resource_mgt,
+	.remove_net_resource_mgt = nbl_serv_remove_net_resource_mgt,
+	.init_hw_stats = nbl_serv_init_hw_stats,
+	.remove_hw_stats = nbl_serv_remove_hw_stats,
 	.get_board_info = nbl_serv_get_board_info,
 
 	.get_hw_addr = nbl_serv_get_hw_addr,
@@ -1564,11 +4289,17 @@ static struct nbl_service_ops serv_ops = {
 
 	.check_fw_heartbeat = nbl_serv_check_fw_heartbeat,
 	.check_fw_reset = nbl_serv_check_fw_reset,
+	.set_netdev_carrier_state = nbl_serv_set_netdev_carrier_state,
 	.setup_st = nbl_serv_setup_st,
 	.remove_st = nbl_serv_remove_st,
 	.register_real_st_name = nbl_serv_register_real_st_name,
 
+	.setup_vf_config = nbl_serv_setup_vf_config,
+	.remove_vf_config = nbl_serv_remove_vf_config,
 	.register_dev_name = nbl_serv_register_dev_name,
+	.get_dev_name = nbl_serv_get_dev_name,
+	.setup_vf_resource = nbl_serv_setup_vf_resource,
+	.remove_vf_resource = nbl_serv_remove_vf_resource,
 
 	.set_hw_status = nbl_serv_set_hw_status,
 	.get_active_func_bitmaps = nbl_serv_get_active_func_bitmaps,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index 74f231dd997b..eeade2432e66 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -22,6 +22,13 @@ struct nbl_dev_ops_tbl {
 
 int nbl_dev_init(void *p, struct nbl_init_param *param);
 void nbl_dev_remove(void *p);
-void nbl_dev_register_dev_name(void *p);
+int nbl_dev_start(void *p, struct nbl_init_param *param);
+void nbl_dev_stop(void *p);
 
+int nbl_dev_setup_vf_config(void *p, int num_vfs);
+void nbl_dev_remove_vf_config(void *p);
+void nbl_dev_register_dev_name(void *p);
+void nbl_dev_get_dev_name(void *p, char *dev_name);
+int nbl_dev_resume(void *p);
+int nbl_dev_suspend(void *p);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index 39788878a42e..07b5e36fc1ec 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -15,6 +15,16 @@
 struct nbl_service_ops {
 	int (*init_chip)(void *p);
 	int (*destroy_chip)(void *p);
+	int (*configure_msix_map)(void *p, u16 num_net_msix, u16 num_others_msix,
+				  bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv);
+	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_abnormal_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_adminq_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*request_net_irq)(void *priv, struct nbl_msix_info_param *msix_info);
+	void (*free_net_irq)(void *priv, struct nbl_msix_info_param *msix_info);
+	u16 (*get_global_vector)(void *priv, u16 local_vector_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 local_vector_id);
 	void (*get_common_irq_num)(void *priv, struct nbl_common_irq_num *irq_num);
 	void (*get_ctrl_irq_num)(void *priv, struct nbl_ctrl_irq_num *irq_num);
 	int (*get_port_attributes)(void *p);
@@ -23,14 +33,19 @@ struct nbl_service_ops {
 	int (*get_serial_number)(void *priv, char *serial_number);
 	int (*enable_port)(void *p, bool enable);
 	void (*init_port)(void *priv);
+	void (*set_netdev_carrier_state)(void *p, struct net_device *netdev, u8 link_state);
+
 	int (*vsi_open)(void *priv, struct net_device *netdev, u16 vsi_index,
 			u16 real_qps, bool use_napi);
 	int (*vsi_stop)(void *priv, u16 vsi_index);
+
 	int (*netdev_open)(struct net_device *netdev);
 	int (*netdev_stop)(struct net_device *netdev);
+	int (*change_mtu)(struct net_device *netdev, int new_mtu);
 	void (*get_stats64)(struct net_device *netdev, struct rtnl_link_stats64 *stats);
 	void (*set_rx_mode)(struct net_device *dev);
 	void (*change_rx_flags)(struct net_device *dev, int flag);
+	int (*set_mac)(struct net_device *dev, void *p);
 	int (*rx_add_vid)(struct net_device *dev, __be16 proto, u16 vid);
 	int (*rx_kill_vid)(struct net_device *dev, __be16 proto, u16 vid);
 	int (*set_features)(struct net_device *dev, netdev_features_t features);
@@ -56,12 +71,42 @@ struct nbl_service_ops {
 	int (*register_net)(void *priv, struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
 	int (*unregister_net)(void *priv);
+	int (*setup_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num, u16 net_vector_id);
+	void (*remove_txrx_queues)(void *priv, u16 vsi_id);
 	int (*register_vsi_info)(void *priv, struct nbl_vsi_param *vsi_param);
+	int (*init_tx_rate)(void *priv, u16 vsi_id);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*setup_rss_indir)(void *priv, u16 vsi_id);
+
+	int (*alloc_rings)(void *priv, struct net_device *dev, struct nbl_ring_param *param);
+	void (*cpu_affinity_init)(void *priv, u16 rings_num);
+	void (*free_rings)(void *priv);
+	int (*enable_napis)(void *priv, u16 vsi_index);
+	void (*disable_napis)(void *priv, u16 vsi_index);
+	void (*set_mask_en)(void *priv, bool enable);
+	int (*start_net_flow)(void *priv, struct net_device *dev, u16 vsi_id, u16 vid,
+			      bool trusted);
+	void (*stop_net_flow)(void *priv, u16 vsi_id);
+	void (*clear_flow)(void *priv, u16 vsi_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*cfg_multi_mcast)(void *priv, u16 vsi, u16 enable);
+	int (*set_lldp_flow)(void *priv, u16 vsi_id);
+	void (*remove_lldp_flow)(void *priv, u16 vsi_id);
 	int (*start_mgt_flow)(void *priv);
 	void (*stop_mgt_flow)(void *priv);
 	u32 (*get_tx_headroom)(void *priv);
+	int (*set_spoof_check_addr)(void *priv, u8 *mac);
+
 	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
+	int (*setup_net_resource_mgt)(void *priv, struct net_device *dev,
+				      u16 vlan_proto, u16 vlan_tci, u32 rate);
+	void (*remove_net_resource_mgt)(void *priv);
+	int (*init_hw_stats)(void *priv);
+	int (*remove_hw_stats)(void *priv);
 	void (*set_sfp_state)(void *priv, struct net_device *netdev, u8 eth_id,
 			      bool open, bool is_force);
 	int (*get_board_id)(void *priv);
@@ -69,6 +114,7 @@ struct nbl_service_ops {
 
 	void (*get_rep_queue_info)(void *priv, u16 *queue_num, u16 *queue_size);
 	void (*get_user_queue_info)(void *priv, u16 *queue_num, u16 *queue_size, u16 vsi_id);
+
 	void (*set_netdev_ops)(void *priv, const struct net_device_ops *net_device_ops, bool is_pf);
 
 	u8 __iomem * (*get_hw_addr)(void *priv, size_t *size);
@@ -86,10 +132,19 @@ struct nbl_service_ops {
 	bool (*check_fw_reset)(void *priv);
 
 	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
+
 	int (*setup_st)(void *priv, void *st_table_param, char *st_name);
 	void (*remove_st)(void *priv, void *st_table_param);
 	void (*register_real_st_name)(void *priv, char *st_name);
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
 	void (*get_active_func_bitmaps)(void *priv, unsigned long *bitmap, int max_func);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index a15b2068e1e1..f3fc67dbaa67 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -24,6 +24,19 @@ static char *nblst_cdevnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "nblst/%s", dev_name(dev));
 }
 
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
 static void nbl_core_setup_product_ops(struct nbl_adapter *adapter, struct nbl_init_param *param,
 				       struct nbl_product_base_ops **product_base_ops)
 {
@@ -222,8 +235,17 @@ static int nbl_probe(struct pci_dev *pdev, const struct pci_device_id __always_u
 	}
 
 	pci_set_drvdata(pdev, adapter);
+
+	err = nbl_core_start(adapter, &param);
+	if (err)
+		goto core_start_err;
+
 	dev_info(dev, "nbl probe finished\n");
+
 	return 0;
+
+core_start_err:
+	nbl_core_remove(adapter);
 adapter_init_err:
 	pci_clear_master(pdev);
 configure_dma_err:
@@ -237,6 +259,8 @@ static void nbl_remove(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev, "nbl remove\n");
 	pci_disable_sriov(pdev);
+
+	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 
 	pci_clear_master(pdev);
@@ -247,6 +271,49 @@ static void nbl_remove(struct pci_dev *pdev)
 
 static void nbl_shutdown(struct pci_dev *pdev)
 {
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	bool wol_ena = common->wol_ena;
+
+	if (!NBL_COMMON_TO_VF_CAP(NBL_ADAPTER_TO_COMMON(adapter)))
+		nbl_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pdev, wol_ena);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+
+	dev_info(&pdev->dev, "nbl shutdown OK\n");
+}
+
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
+	/* register pf_name to AF first, cuz vf_name depends on pf_anme */
+	nbl_dev_register_dev_name(adapter);
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
 }
 
 #define NBL_VENDOR_ID			(0x1F0F)
@@ -340,12 +407,18 @@ MODULE_DEVICE_TABLE(pci, nbl_id_table);
 
 static int __maybe_unused nbl_suspend(struct device *dev)
 {
-	return 0;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	return nbl_dev_suspend(adapter);
 }
 
 static int __maybe_unused nbl_resume(struct device *dev)
 {
-	return 0;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	return nbl_dev_resume(adapter);
 }
 
 static SIMPLE_DEV_PM_OPS(nbl_pm_ops, nbl_suspend, nbl_resume);
@@ -355,6 +428,7 @@ static struct pci_driver nbl_driver = {
 	.probe = nbl_probe,
 	.remove = nbl_remove,
 	.shutdown = nbl_shutdown,
+	.sriov_configure = nbl_sriov_configure,
 	.driver.pm = &nbl_pm_ops,
 };
 
-- 
2.43.0


