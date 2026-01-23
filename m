Return-Path: <netdev+bounces-252626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7B98FuvncmmnrAAAu9opvQ
	(envelope-from <netdev+bounces-252626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:15:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30976FF13
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2912F3003618
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2237F8CA;
	Fri, 23 Jan 2026 03:15:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-29.us.a.mail.aliyun.com (out198-29.us.a.mail.aliyun.com [47.90.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CDA18BBAE;
	Fri, 23 Jan 2026 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138150; cv=none; b=MRmXcdlmNb19zVCV9ETX2jeH7j9XITADnbJhRsO7pqopHWPnRdFxPEhxSNo93PXWuGeBeir49qzmUVYo/QmNseIRO/U3hYOUeKFycSm7Yc0BDPaBdRHu9lt3ArsUrX22J+WLbXGuGu7JRnEbmORkupwweq0RpW3G4jwQrKLsWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138150; c=relaxed/simple;
	bh=jBfFQHSw2ZkHoVynG+cygO+Y4c1wIgss+hWQk5tvzJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDMihHsqLPZ6JE6wPBakvOElvTIhS87eSrs3SLCJeBVgJMPcql4bfCbQK1Lm8Ho72CqKeSlhSCmLbJxCLse9288nvJ4RH6H/ggzUyfsWN0/RhWRIQQ5ocLw3M+sR6LNsoGnA7BIoHcUd08VwUqZJJw26skLHkg1DwgbvW+HXqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSsZoJ_1769138115 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 11:15:16 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: netdev@vger.kernel.org
Cc: "illusion.wang" <illusion.wang@nebula-matrix.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 12/15] net/nebula-matrix: add common/ctrl dev init/reinit operation
Date: Fri, 23 Jan 2026 11:15:11 +0800
Message-ID: <20260123031512.31815-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252626-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: B30976FF13
X-Rspamd-Action: no action

Common Device Setup: nbl_dev_setup_common_dev configures mailbox queues,
registers cleanup tasks, and requests IRQs.
Control Device Setup (optional): nbl_dev_setup_ctrl_dev initializes
the chip and configures all channel queues.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 194 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  92 +++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  |  69 +++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  91 +++++++-
 .../nbl/nbl_include/nbl_def_service.h         |  57 +++++
 .../nbl/nbl_include/nbl_include.h             |   7 +
 6 files changed, 506 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index dbeffcfe397e..b661d8ab972c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -11,6 +11,179 @@
 #include "nbl_dev.h"
 
 static struct nbl_dev_ops dev_ops;
+static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+
+	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
+}
+
+/* ----------  Channel config  ---------- */
+static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt);
+	int ret = 0;
+
+	if (!chan_ops->check_queue_exist(priv, chan_type))
+		return 0;
+
+	ret = chan_ops->cfg_chan_qinfo_map_table(priv, chan_type);
+	if (ret)
+		dev_err(dev, "setup chan:%d, qinfo map table failed\n",
+			chan_type);
+
+	return ret;
+}
+
+static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt);
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(priv, chan_type))
+		ret = chan_ops->setup_queue(priv, chan_type);
+
+	return ret;
+}
+
+static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt);
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(priv, chan_type))
+		ret = chan_ops->teardown_queue(priv, chan_type);
+
+	return ret;
+}
+
+static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
+				       u8 chan_type, struct work_struct *task)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					chan_type))
+		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					     chan_type, task);
+}
+
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox_task(struct work_struct *work)
+{
+	struct nbl_dev_common *common_dev =
+		container_of(work, struct nbl_dev_common, clean_mbx_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				      NBL_CHAN_TYPE_MAILBOX);
+}
+
+/* ----------  Dev init process  ---------- */
+static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter,
+				    struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *common_dev;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+
+	common_dev = devm_kzalloc(NBL_ADAP_TO_DEV(adapter),
+				  sizeof(struct nbl_dev_common), GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
+		goto setup_chan_fail;
+
+	nbl_common_alloc_task(&common_dev->clean_mbx_task,
+			      nbl_dev_clean_mailbox_task);
+
+	common->vsi_id = serv_ops->get_vsi_id(priv, 0, NBL_VSI_DATA);
+
+	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+			     NBL_COMMON_TO_VSI_ID(common),
+			     &NBL_COMMON_TO_ETH_MODE(common),
+			     &NBL_COMMON_TO_ETH_ID(common),
+			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
+				   &common_dev->clean_mbx_task);
+
+	dev_mgt->common_dev = common_dev;
+	nbl_dev_register_common_irq(dev_mgt);
+	return 0;
+
+setup_chan_fail:
+	devm_kfree(NBL_ADAP_TO_DEV(adapter), common_dev);
+	return -EFAULT;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+
+	if (!common_dev)
+		return;
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+	nbl_common_release_task(&common_dev->clean_mbx_task);
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+	devm_kfree(NBL_ADAP_TO_DEV(adapter), common_dev);
+	dev_mgt->common_dev = NULL;
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter,
+				  struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	int i, ret = 0;
+
+	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "ctrl dev chip_init failed\n");
+		goto chip_init_fail;
+	}
+
+	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
+		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
+		if (ret) {
+			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
+			goto setup_chan_q_fail;
+		}
+	}
+
+	return 0;
+
+setup_chan_q_fail:
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+chip_init_fail:
+	return ret;
+}
+
+static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
 
 static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common,
 				 struct nbl_dev_mgt **dev_mgt)
@@ -74,14 +247,27 @@ int nbl_dev_init(void *p, struct nbl_init_param *param)
 
 	(*dev_mgt)->serv_ops_tbl = serv_ops_tbl;
 	(*dev_mgt)->chan_ops_tbl = chan_ops_tbl;
+
+	ret = nbl_dev_setup_common_dev(adapter, param);
+	if (ret)
+		goto setup_common_dev_fail;
+
+	if (common->is_ctrl) {
+		ret = nbl_dev_setup_ctrl_dev(adapter, param);
+		if (ret)
+			goto setup_ctrl_dev_fail;
+	}
 	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
 	if (ret)
 		goto setup_ops_fail;
-
 	return 0;
 
 setup_ops_fail:
-
+	if (common->is_ctrl)
+		nbl_dev_remove_ctrl_dev(adapter);
+setup_ctrl_dev_fail:
+	nbl_dev_remove_common_dev(adapter);
+setup_common_dev_fail:
 	nbl_dev_remove_dev_mgt(common, dev_mgt);
 setup_mgt_fail:
 	return ret;
@@ -98,7 +284,9 @@ void nbl_dev_remove(void *p)
 		&NBL_ADAP_TO_DEV_OPS_TBL(adapter);
 
 	nbl_dev_remove_ops(dev, dev_ops_tbl);
-
+	if (common->is_ctrl)
+		nbl_dev_remove_ctrl_dev(adapter);
+	nbl_dev_remove_common_dev(adapter);
 	nbl_dev_remove_dev_mgt(common, dev_mgt);
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
index 8a7c85db8ceb..ebcf33eead7d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -29,11 +29,103 @@
 	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->ops)
 #define NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt) \
 	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->priv)
+
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | \
+			    NETIF_MSG_LINK | NETIF_MSG_IFDOWN | \
+			    NETIF_MSG_IFUP)
+
+#define NBL_STRING_NAME_LEN			32
+#define NBL_DEFAULT_MTU				1500
+
+enum nbl_msix_serv_type {
+	/* virtio_dev has a config vector_id, and the vector_id need is 0 */
+	NBL_MSIX_VIRTIO_TYPE = 0,
+	NBL_MSIX_NET_TYPE,
+	NBL_MSIX_MAILBOX_TYPE,
+	NBL_MSIX_TYPE_MAX
+};
+
+struct nbl_msix_serv_info {
+	char irq_name[NBL_STRING_NAME_LEN];
+	u16 num;
+	u16 base_vector_id;
+	/* true: hw report msix, hw need to mask actively */
+	bool hw_self_mask_en;
+};
+
+struct nbl_msix_info {
+	struct nbl_msix_serv_info serv_info[NBL_MSIX_TYPE_MAX];
+	struct msix_entry *msix_entries;
+};
+
+struct nbl_dev_common {
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_msix_info msix_info;
+	char mailbox_name[NBL_STRING_NAME_LEN];
+	// for ctrl-dev/net-dev mailbox recv msg
+	struct work_struct clean_mbx_task;
+
+};
+
+struct nbl_dev_vsi_controller {
+	u16 queue_num;
+	u16 queue_free_offset;
+	void *vsi_list[NBL_VSI_MAX];
+};
+
+struct nbl_dev_net_ops {
+	int (*setup_netdev_ops)(void *priv, struct net_device *netdev,
+				struct nbl_init_param *param);
+};
+
+struct nbl_dev_net {
+	struct net_device *netdev;
+	struct nbl_dev_net_ops *ops;
+	u8 eth_id;
+	struct nbl_dev_vsi_controller vsi_ctrl;
+	u16 kernel_queue_num;
+};
+
 struct nbl_dev_mgt {
 	struct nbl_common_info *common;
 	struct nbl_service_ops_tbl *serv_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dev_common *common_dev;
+	struct nbl_dev_net *net_dev;
+};
+
+struct nbl_dev_vsi_ops {
+	int (*register_vsi)(struct nbl_dev_mgt *dev_mgt,
+			    struct nbl_init_param *param, void *vsi_data);
+	int (*setup)(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+		     void *vsi_data);
+	void (*remove)(struct nbl_dev_mgt *dev_mgt, void *vsi_data);
+	int (*start)(void *dev_priv, struct net_device *netdev, void *vsi_data);
+	void (*stop)(void *dev_priv, void *vsi_data);
+	int (*netdev_build)(struct nbl_dev_mgt *dev_mgt,
+			    struct nbl_init_param *param,
+			    struct net_device *netdev, void *vsi_data);
+	void (*netdev_destroy)(struct nbl_dev_mgt *dev_mgt, void *vsi_data);
+};
+
+struct nbl_dev_vsi {
+	struct nbl_dev_vsi_ops *ops;
+	struct net_device *netdev;
+	struct net_device *napi_netdev;
+	struct nbl_register_net_result register_result;
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+	u16 queue_size;
+	u8 index;
+	bool enable;
+
+};
 
+struct nbl_dev_vsi_tbl {
+	struct nbl_dev_vsi_ops vsi_ops;
 };
 
+struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt,
+				       u8 vsi_index);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index a0adfb95382c..1c2f8d7e4272 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -12,7 +12,72 @@
 #include <linux/if_vlan.h>
 
 #include "nbl_service.h"
+
+static int nbl_serv_init_chip(void *priv)
+{
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
+	return 0;
+queue_init_fail:
+module_init_fail:
+	return ret;
+}
+
+static int nbl_serv_destroy_chip(void *p)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)p;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->deinit_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return 0;
+}
+
+static u16 nbl_serv_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				    func_id, type);
+}
+
+static void nbl_serv_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode,
+				u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_eth_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				    eth_mode, eth_id, logic_eth_id);
+}
+
 static struct nbl_service_ops serv_ops = {
+	.init_chip = nbl_serv_init_chip,
+	.destroy_chip = nbl_serv_destroy_chip,
+
+	.get_vsi_id = nbl_serv_get_vsi_id,
+	.get_eth_id = nbl_serv_get_eth_id,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
@@ -71,6 +136,7 @@ int nbl_serv_init(void *p, struct nbl_init_param *param)
 	struct nbl_service_mgt **serv_mgt;
 	struct nbl_service_ops_tbl **serv_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_dispatch_ops *disp_ops;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	int ret = 0;
 
@@ -80,6 +146,7 @@ int nbl_serv_init(void *p, struct nbl_init_param *param)
 	serv_ops_tbl = &NBL_ADAP_TO_SERV_OPS_TBL(adapter);
 	disp_ops_tbl = NBL_ADAP_TO_DISP_OPS_TBL(adapter);
 	chan_ops_tbl = NBL_ADAP_TO_CHAN_OPS_TBL(adapter);
+	disp_ops = disp_ops_tbl->ops;
 
 	ret = nbl_serv_setup_serv_mgt(common, serv_mgt);
 	if (ret)
@@ -91,6 +158,8 @@ int nbl_serv_init(void *p, struct nbl_init_param *param)
 
 	(*serv_mgt)->disp_ops_tbl = disp_ops_tbl;
 	(*serv_mgt)->chan_ops_tbl = chan_ops_tbl;
+	disp_ops->get_resource_pt_ops(disp_ops_tbl->priv,
+				      &(*serv_ops_tbl)->pt_ops);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
index 083350bd50ba..273218200526 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -12,12 +12,90 @@
 #include "nbl_core.h"
 
 #define NBL_SERV_MGT_TO_COMMON(serv_mgt)	((serv_mgt)->common)
+#define NBL_SERV_MGT_TO_DEV(serv_mgt) \
+	NBL_COMMON_TO_DEV(NBL_SERV_MGT_TO_COMMON(serv_mgt))
+#define NBL_NET_RES_MGT_TO_NETDEV(net_res_mgt) ((net_res_mgt)->netdev)
+#define NBL_SERV_MGT_TO_NETDEV(serv_mgt) \
+	NBL_NET_RES_MGT_TO_NETDEV(NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt))
+#define NBL_SERV_MGT_TO_RING_MGT(serv_mgt)	(&(serv_mgt)->ring_mgt)
+#define NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)	((serv_mgt)->net_resource_mgt)
+
+#define NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)	((serv_mgt)->disp_ops_tbl)
+#define NBL_SERV_MGT_TO_DISP_OPS(serv_mgt) \
+	(NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)->ops)
+#define NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt) \
+	(NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)->priv)
+
 #define NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)	((serv_mgt)->chan_ops_tbl)
 #define NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt) \
 	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->ops)
 #define NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt) \
 	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->priv)
 
+#define NBL_DEFAULT_VLAN_ID				0
+#define NBL_HW_STATS_PERIOD_SECONDS			5
+#define NBL_HW_STATS_RX_RATE_THRESHOLD			(1000) /* 1k pps */
+
+#define NBL_TX_TSO_MSS_MIN				(256)
+#define NBL_TX_TSO_MSS_MAX				(16383)
+#define NBL_TX_TSO_L2L3L4_HDR_LEN_MIN			(42)
+#define NBL_TX_TSO_L2L3L4_HDR_LEN_MAX			(128)
+#define NBL_TX_CHECKSUM_OFFLOAD_L2L3L4_HDR_LEN_MAX	(255)
+
+#define SET_DPORT_TYPE_VSI_HOST				(0)
+#define SET_DPORT_TYPE_VSI_ECPU				(1)
+#define SET_DPORT_TYPE_ETH_LAG				(2)
+#define SET_DPORT_TYPE_SP_PORT				(3)
+
+/* primary vlan in vlan list */
+#define NBL_NO_TRUST_MAX_VLAN				9
+/* primary mac not in submac list */
+#define NBL_NO_TRUST_MAX_MAC				12
+
+struct nbl_serv_ring {
+	dma_addr_t dma;
+	u16 index;
+	u16 local_queue_id;
+	u16 global_queue_id;
+	bool need_recovery;
+	u32 tx_timeout_count;
+};
+
+struct nbl_serv_vector {
+	char name[32];
+	struct net_device *netdev;
+	struct nbl_napi_struct *nbl_napi;
+	struct nbl_serv_ring *tx_ring;
+	struct nbl_serv_ring *rx_ring;
+	u8 __iomem *irq_enable_base;
+	u32 irq_data;
+	u16 local_vec_id;
+	u16 global_vec_id;
+};
+
+struct nbl_serv_ring_vsi_info {
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 ring_offset;
+	u16 ring_num;
+	u16 active_ring_num;
+	bool itr_dynamic;
+	bool started;
+};
+
+struct nbl_serv_ring_mgt {
+	struct nbl_serv_ring *tx_rings;
+	struct nbl_serv_ring *rx_rings;
+	struct nbl_serv_vector *vectors;
+	struct nbl_serv_ring_vsi_info vsi_info[NBL_VSI_MAX];
+	u16 tx_desc_num;
+	u16 rx_desc_num;
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+	u16 active_ring_num;
+	bool net_msix_mask_en;
+};
+
 enum {
 	NBL_PROMISC = 0,
 	NBL_ALLMULTI = 1,
@@ -27,11 +105,22 @@ struct nbl_serv_netdev_ops {
 	void *pf_netdev_ops;
 };
 
+struct nbl_serv_net_resource_mgt {
+	struct nbl_service_mgt *serv_mgt;
+	struct net_device *netdev;
+	struct nbl_serv_netdev_ops netdev_ops;
+	u16 num_net_msix;
+	u16 vlan_tci;
+	u16 vlan_proto;
+	int max_tx_rate;
+};
+
 struct nbl_service_mgt {
 	struct nbl_common_info *common;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
-
+	struct nbl_serv_ring_mgt ring_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
 };
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index dc261fda3aa5..29b541649a90 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -10,6 +10,63 @@
 #include "nbl_include.h"
 
 struct nbl_service_ops {
+	int (*init_chip)(void *p);
+	int (*destroy_chip)(void *p);
+	int (*configure_msix_map)(void *p, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv);
+	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*request_net_irq)(void *priv,
+			       struct nbl_msix_info_param *msix_info);
+	void (*free_net_irq)(void *priv, struct nbl_msix_info_param *msix_info);
+	u16 (*get_global_vector)(void *priv, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 local_vec_id);
+
+	int (*vsi_open)(void *priv, struct net_device *netdev, u16 vsi_index,
+			u16 real_qps, bool use_napi);
+	int (*vsi_stop)(void *priv, u16 vsi_index);
+
+	int (*netdev_open)(struct net_device *netdev);
+	int (*netdev_stop)(struct net_device *netdev);
+	void (*get_stats64)(struct net_device *netdev,
+			    struct rtnl_link_stats64 *stats);
+	netdev_features_t (*features_check)(struct sk_buff *skb,
+					    struct net_device *dev,
+					    netdev_features_t features);
+	u16 (*select_queue)(struct net_device *netdev, struct sk_buff *skb,
+			    struct net_device *sb_dev);
+	int (*register_net)(void *priv,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv);
+	int (*setup_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num,
+				 u16 net_vector_id);
+	void (*remove_txrx_queues)(void *priv, u16 vsi_id);
+	int (*register_vsi_info)(void *priv, struct nbl_vsi_param *vsi_param);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*setup_rss_indir)(void *priv, u16 vsi_id);
+	int (*alloc_rings)(void *priv, struct net_device *dev,
+			   struct nbl_ring_param *param);
+	void (*cpu_affinity_init)(void *priv, u16 rings_num);
+	void (*free_rings)(void *priv);
+	int (*enable_napis)(void *priv, u16 vsi_index);
+	void (*disable_napis)(void *priv, u16 vsi_index);
+	void (*set_mask_en)(void *priv, bool enable);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	u32 (*get_tx_headroom)(void *priv);
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			   u8 *logic_eth_id);
+	int (*setup_net_resource_mgt)(void *priv, struct net_device *dev,
+				      u16 vlan_proto, u16 vlan_tci, u32 rate);
+	void (*remove_net_resource_mgt)(void *priv);
+	void (*set_netdev_ops)(void *priv,
+			       const struct net_device_ops *net_device_ops,
+			       bool is_pf);
+
 };
 
 struct nbl_service_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 6d57391f85f9..0ab4dd981c8a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -262,6 +262,13 @@ enum nbl_performance_mode {
 	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
 };
 
+struct nbl_vsi_param {
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+	u8 index;
+};
+
 struct nbl_ring_param {
 	u16 tx_ring_num;
 	u16 rx_ring_num;
-- 
2.47.3


