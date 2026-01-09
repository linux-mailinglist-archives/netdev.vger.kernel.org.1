Return-Path: <netdev+bounces-248427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCAD0867A
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43F523021E5D
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC7A338F56;
	Fri,  9 Jan 2026 10:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31A338598;
	Fri,  9 Jan 2026 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952976; cv=none; b=gTEPzpYkqWGkJ3059b3SJ66tF7eD5s/TZnmJe1fLSchnqj8yG+AyP7smL9Uv2NJ/Yp8/J15q39F1ltU4yibzPZzfIhVCvC3qONOK46OlOzEjEWZlYrVu9fruxPsNF6mpnjabhkp6WUhJivw2B8AGyElPEjPyG8q+ZEe4Ohr/u8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952976; c=relaxed/simple;
	bh=NPE+ZghCliRDzBKQnZlxEbbA4gKh0RaWwMNjlGAGWgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAoyconL+MwgsxYuDfIbHr5ItkspP+PCkYdrjxz2PdFW8TgrNt4IfWIRpOwDKXnUdbdNOKwPE+ArsWhOzJOa/+N9qPyzimV+vjwftoXcqgDTGHdNhmxxKRnpIcZIPJ2tt0k2rr4suJqQUYQ95lQJvwC0GC3lsLsaPVQS9Gp3mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQB1H_1767952968 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:49 +0800
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
Subject: [PATCH v2 net-next 15/15] net/nebula-matrix: add st_sysfs and vf name sysfs
Date: Fri,  9 Jan 2026 18:01:33 +0800
Message-ID: <20260109100146.63569-16-illusion.wang@nebula-matrix.com>
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

Add st_sysfs to support our private nblconfig tool. The VF netdev sysfs
was introduced to address issues where PF names are sometimes too long.
The new support also resolves dependencies on specific udev versions.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  11 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 192 +++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  20 ++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 296 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |  24 ++
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.c    |  85 +++++
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.h    |  20 ++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../nbl/nbl_include/nbl_def_service.h         |   4 +
 .../nbl/nbl_include/nbl_include.h             |  19 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  49 +++
 12 files changed, 721 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 062ff1ffb964..bd7f91c789b5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -19,6 +19,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
+				nbl_core/nbl_sysfs.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 3db1364eefdc..1988c087e22b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -124,10 +124,21 @@ struct nbl_netdev_priv {
 	s64 last_st_time;
 };
 
+#define NBL_ST_MAX_DEVICE_NUM			96
+struct nbl_software_tool_table {
+	DECLARE_BITMAP(devid, NBL_ST_MAX_DEVICE_NUM);
+	int major;
+	dev_t devno;
+	struct class *cls;
+};
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
 int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param);
 void nbl_core_stop(struct nbl_adapter *adapter);
 
+int nbl_st_init(struct nbl_software_tool_table *st_table);
+void nbl_st_remove(struct nbl_software_tool_table *st_table);
+struct nbl_software_tool_table *nbl_get_st_table(void);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index a379a5851523..b94502d31305 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -17,6 +17,9 @@ static struct nbl_dev_ops dev_ops;
 static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
 static void nbl_dev_clean_adminq_schedule(struct nbl_task_info *task_info);
 static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt);
+static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter,
+				struct nbl_init_param *param);
+static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter);
 
 /* ----------  Basic functions  ---------- */
 static int nbl_dev_get_port_attributes(struct nbl_dev_mgt *dev_mgt)
@@ -2237,6 +2240,66 @@ struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt,
 	return NULL;
 }
 
+static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0, st_dev->real_st_name,
+		      sizeof(st_dev->real_st_name), 1);
+	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				  &chan_send);
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
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id, 0,
+		     st_dev->st_name, sizeof(st_dev->st_name));
+	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
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
+	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+				 NBL_CHAN_MSG_GET_ST_NAME);
+}
+
 static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
 	{
 		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
@@ -2360,6 +2423,70 @@ static void nbl_dev_remove_net_dev(struct nbl_adapter *adapter)
 	*net_dev = NULL;
 }
 
+static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter,
+				struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	struct nbl_dev_st_dev *st_dev;
+	int ret;
+
+	/* unify restool's chardev for all chips. all pf create chardev */
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   NBL_RESTOOL_CAP))
+		return 0;
+
+	st_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_st_dev), GFP_KERNEL);
+	if (!st_dev)
+		return -ENOMEM;
+
+	dev_mgt->st_dev = st_dev;
+	ret = serv_ops->setup_st(priv, nbl_get_st_table(), st_dev->st_name);
+	if (ret) {
+		dev_err(dev, "create resource char dev failed\n");
+		goto alloc_chardev_failed;
+	}
+
+	if (param->caps.has_ctrl) {
+		nbl_dev_register_get_st_name_chan_msg(dev_mgt);
+	} else {
+		ret = nbl_dev_chan_get_st_name_req(dev_mgt);
+		if (!ret)
+			serv_ops->register_real_st_name(priv,
+							st_dev->real_st_name);
+		else
+			dev_err(dev, "get real resource char dev failed\n");
+	}
+
+	return 0;
+alloc_chardev_failed:
+	devm_kfree(NBL_ADAP_TO_DEV(adapter), st_dev);
+	dev_mgt->st_dev = NULL;
+	return -1;
+}
+
+static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt =
+		(struct nbl_dev_mgt *)NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   NBL_RESTOOL_CAP))
+		return;
+
+	nbl_dev_unregister_get_st_name_chan_msg(dev_mgt);
+	serv_ops->remove_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+			    nbl_get_st_table());
+
+	devm_kfree(NBL_ADAP_TO_DEV(adapter), st_dev);
+	dev_mgt->st_dev = NULL;
+}
+
 static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common,
 				 struct nbl_dev_mgt **dev_mgt)
 {
@@ -2437,6 +2564,10 @@ int nbl_dev_init(void *p, struct nbl_init_param *param)
 	if (ret)
 		goto setup_net_dev_fail;
 
+	ret = nbl_dev_setup_st_dev(adapter, param);
+	if (ret)
+		goto setup_st_dev_fail;
+
 	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
 	if (ret)
 		goto setup_ops_fail;
@@ -2444,6 +2575,8 @@ int nbl_dev_init(void *p, struct nbl_init_param *param)
 	return 0;
 
 setup_ops_fail:
+	nbl_dev_remove_st_dev(adapter);
+setup_st_dev_fail:
 	nbl_dev_remove_net_dev(adapter);
 setup_net_dev_fail:
 	nbl_dev_remove_ctrl_dev(adapter);
@@ -2466,6 +2599,8 @@ void nbl_dev_remove(void *p)
 		&NBL_ADAP_TO_DEV_OPS_TBL(adapter);
 
 	nbl_dev_remove_ops(dev, dev_ops_tbl);
+
+	nbl_dev_remove_st_dev(adapter);
 	nbl_dev_remove_net_dev(adapter);
 	nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
@@ -2721,6 +2856,30 @@ int nbl_dev_setup_vf_config(void *p, int num_vfs)
 					 num_vfs, false);
 }
 
+void nbl_dev_register_dev_name(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+
+	/* get pf_name then register it to AF */
+	serv_ops->register_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				    common->vsi_id, net_dev->netdev->name);
+}
+
+void nbl_dev_get_dev_name(void *p, char *dev_name)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+
+	serv_ops->get_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+			       common->vsi_id, dev_name);
+}
+
 void nbl_dev_remove_vf_config(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
@@ -2748,6 +2907,7 @@ static int nbl_dev_start_net_dev(struct nbl_adapter *adapter,
 	struct nbl_ring_param ring_param = {0};
 	struct nbl_dev_vsi *vsi;
 	u16 net_vector_id, queue_num;
+	char dev_name[IFNAMSIZ] = {0};
 	int ret;
 
 	vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_DATA);
@@ -2848,12 +3008,34 @@ static int nbl_dev_start_net_dev(struct nbl_adapter *adapter,
 			if (ret)
 				goto setup_vf_res_fail;
 		}
+		nbl_netdev_add_st_sysfs(netdev, net_dev);
+
+	} else {
+		/* vf device need get pf name as its base name */
+		nbl_net_add_name_attr(&net_dev->dev_attr.dev_name_attr,
+				      dev_name);
+#ifdef CONFIG_PCI_ATS
+		nbl_dev_get_dev_name(adapter, dev_name);
+		memcpy(net_dev->dev_attr.dev_name_attr.net_dev_name, dev_name,
+		       IFNAMSIZ);
+		ret = sysfs_create_file(&netdev->dev.kobj,
+					&net_dev->dev_attr.dev_name_attr.attr);
+		if (ret) {
+			dev_err(dev, "nbl vf device add dev_name:%s net-fs failed",
+				dev_name);
+			goto add_vf_sys_attr_fail;
+		}
+		dev_dbg(dev, "nbl vf device get dev_name:%s", dev_name);
+#endif
 	}
 
 	set_bit(NBL_DOWN, adapter->state);
 
 	return 0;
 setup_vf_res_fail:
+#ifdef CONFIG_PCI_ATS
+add_vf_sys_attr_fail:
+#endif
 	unregister_netdev(netdev);
 register_netdev_fail:
 	nbl_dev_free_net_irq(dev_mgt);
@@ -2884,6 +3066,7 @@ static void nbl_dev_stop_net_dev(struct nbl_adapter *adapter)
 	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	struct nbl_dev_vsi *vsi;
 	struct net_device *netdev;
+	char dev_name[IFNAMSIZ] = { 0 };
 
 	if (!net_dev)
 		return;
@@ -2894,8 +3077,15 @@ static void nbl_dev_stop_net_dev(struct nbl_adapter *adapter)
 	if (!vsi)
 		return;
 
-	if (!common->is_vf)
+	if (!common->is_vf) {
 		serv_ops->remove_vf_resource(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+		nbl_netdev_remove_st_sysfs(net_dev);
+	} else {
+		/* remove vf dev_name attr */
+		if (memcmp(net_dev->dev_attr.dev_name_attr.net_dev_name,
+			   dev_name, IFNAMSIZ))
+			nbl_net_remove_dev_attr(net_dev);
+	}
 
 	serv_ops->change_mtu(netdev, 0);
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
index 3b1cf6eea915..91c672ee5993 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -8,6 +8,7 @@
 #define _NBL_DEV_H_
 
 #include "nbl_core.h"
+#include "nbl_sysfs.h"
 
 #define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
 #define NBL_DEV_MGT_TO_DEV(dev_mgt) \
@@ -15,6 +16,7 @@
 #define NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt)	((dev_mgt)->common_dev)
 #define NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)	((dev_mgt)->ctrl_dev)
 #define NBL_DEV_MGT_TO_NET_DEV(dev_mgt)		((dev_mgt)->net_dev)
+#define NBL_DEV_MGT_TO_ST_DEV(dev_mgt)		((dev_mgt)->st_dev)
 #define NBL_DEV_COMMON_TO_MSIX_INFO(dev_common)	(&(dev_common)->msix_info)
 #define NBL_DEV_CTRL_TO_TASK_INFO(dev_ctrl)	(&(dev_ctrl)->task_info)
 #define NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt)	((dev_mgt)->net_dev->ops)
@@ -177,6 +179,17 @@ struct nbl_dev_net {
 	u16 total_queue_num;
 	u16 kernel_queue_num;
 	u16 total_vfs;
+	struct nbl_st_name st_name;
+};
+
+/* Unify res tool. All pf has st char dev. For leonis, only pf0 has adminq,
+ * so other pf's resoure tool use pf0's char dev actually.
+ */
+struct nbl_dev_st_dev {
+	bool resp_msg_registered;
+	u8 resv[3];
+	char st_name[NBL_RESTOOL_NAME_LEN];
+	char real_st_name[NBL_RESTOOL_NAME_LEN];
 };
 
 struct nbl_dev_mgt {
@@ -186,6 +199,7 @@ struct nbl_dev_mgt {
 	struct nbl_dev_common *common_dev;
 	struct nbl_dev_ctrl *ctrl_dev;
 	struct nbl_dev_net *net_dev;
+	struct nbl_dev_st_dev *st_dev;
 };
 
 struct nbl_dev_vsi_feature {
@@ -247,4 +261,10 @@ struct nbl_dev_board_id_table {
 
 struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt,
 				       u8 vsi_index);
+void nbl_net_add_name_attr(struct nbl_netdev_name_attr *dev_name_attr,
+			   char *rep_name);
+void nbl_net_remove_dev_attr(struct nbl_dev_net *net_dev);
+int nbl_netdev_add_st_sysfs(struct net_device *netdev,
+			    struct nbl_dev_net *net_dev);
+void nbl_netdev_remove_st_sysfs(struct nbl_dev_net *net_dev);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 5118615c0dbe..9418777e5b18 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -3159,6 +3159,278 @@ static int nbl_serv_register_vsi_info(void *priv,
 					vsi_param->queue_num);
 }
 
+static int nbl_serv_st_open(struct inode *inode, struct file *filep)
+{
+	struct nbl_serv_st_mgt *p =
+		container_of(inode->i_cdev, struct nbl_serv_st_mgt, cdev);
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
+static ssize_t nbl_serv_st_read(struct file *file, char __user *ubuf,
+				size_t size, loff_t *ppos)
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
+	struct net_device *netdev = NBL_SERV_MGT_TO_NETDEV(serv_mgt);
+	struct nbl_passthrough_fw_cmd *param = NULL, *result = NULL;
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
+
+	ret = copy_from_user(param, (void __user *)arg, _IOC_SIZE(cmd));
+	if (ret) {
+		netif_err(common, drv, netdev, "Bad access %d.\n", ret);
+		return ret;
+	}
+
+	nbl_debug(common, "Passthough opcode: %d\n", param->opcode);
+
+	ret = disp_ops->passthrough_fw_cmd(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   param, result);
+	if (ret)
+		goto passthrough_fail;
+
+	ret = copy_to_user((void __user *)arg, result, _IOC_SIZE(cmd));
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
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_st_info_param *param = NULL;
+	int ret = 0;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	strscpy(param->driver_name, NBL_DRIVER_NAME,
+		sizeof(param->driver_name));
+	if (net_resource_mgt->netdev)
+		strscpy(param->netdev_name[0], net_resource_mgt->netdev->name,
+			sizeof(param->netdev_name[0]));
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
+	ret = copy_to_user((void __user *)arg, param, _IOC_SIZE(cmd));
+
+	kfree(param);
+	return ret;
+}
+
+static long nbl_serv_st_unlock_ioctl(struct file *file, unsigned int cmd,
+				     unsigned long arg)
+{
+	struct nbl_serv_st_mgt *st_mgt = file->private_data;
+	struct nbl_service_mgt *serv_mgt =
+		(struct nbl_service_mgt *)st_mgt->serv_mgt;
+	struct net_device *netdev = NBL_SERV_MGT_TO_NETDEV(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	int ret = 0;
+
+	if (_IOC_TYPE(cmd) != IOCTL_TYPE) {
+		netif_err(common, drv, netdev, "cmd %u, magic 0x%x/0x%x.\n",
+			  cmd, _IOC_TYPE(cmd), IOCTL_TYPE);
+		return -ENOTTY;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	if (ret) {
+		netif_err(common, drv, netdev, "Bad access.\n");
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
+		netif_err(common, drv, netdev, "Unknown cmd %d.\n", cmd);
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
+static void nbl_serv_free_subdev_id(struct nbl_software_tool_table *st_table,
+				    int id)
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
+	struct nbl_software_tool_table *st_table =
+		(struct nbl_software_tool_table *)st_table_param;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
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
+			 NBL_COMMON_TO_PDEV(common)->device, id,
+			 NBL_COMMON_TO_PCI_FUNC_ID(common));
+
+	st_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(*st_mgt),
+			      GFP_KERNEL);
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
+	char_device =
+		device_create(st_table->cls, NULL, st_mgt->devno, NULL, name);
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
+	struct nbl_software_tool_table *st_table =
+		(struct nbl_software_tool_table *)st_table_param;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
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
 static int nbl_serv_get_board_id(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -3240,6 +3512,24 @@ static void nbl_serv_remove_vf_config(void *priv)
 	net_resource_mgt->num_vfs = 0;
 }
 
+static void nbl_serv_register_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->register_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				    name);
+}
+
+static void nbl_serv_get_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+			       name);
+}
+
 static int nbl_serv_setup_vf_resource(void *priv, int num_vfs)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -3386,10 +3676,14 @@ static struct nbl_service_ops serv_ops = {
 	.check_fw_heartbeat = nbl_serv_check_fw_heartbeat,
 	.check_fw_reset = nbl_serv_check_fw_reset,
 	.set_netdev_carrier_state = nbl_serv_set_netdev_carrier_state,
+	.setup_st = nbl_serv_setup_st,
+	.remove_st = nbl_serv_remove_st,
+	.register_real_st_name = nbl_serv_register_real_st_name,
 
 	.setup_vf_config = nbl_serv_setup_vf_config,
 	.remove_vf_config = nbl_serv_remove_vf_config,
-
+	.register_dev_name = nbl_serv_register_dev_name,
+	.get_dev_name = nbl_serv_get_dev_name,
 	.setup_vf_resource = nbl_serv_setup_vf_resource,
 	.remove_vf_resource = nbl_serv_remove_vf_resource,
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
index 1357a7f7f26f..ba9e9761a062 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -9,6 +9,8 @@
 
 #include <linux/mm.h>
 #include <linux/ptr_ring.h>
+#include <linux/cdev.h>
+
 #include "nbl_core.h"
 
 #define NBL_SERV_MGT_TO_COMMON(serv_mgt)	((serv_mgt)->common)
@@ -20,6 +22,7 @@
 #define NBL_SERV_MGT_TO_RING_MGT(serv_mgt)	(&(serv_mgt)->ring_mgt)
 #define NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt)	(&(serv_mgt)->flow_mgt)
 #define NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)	((serv_mgt)->net_resource_mgt)
+#define NBL_SERV_MGT_TO_ST_MGT(serv_mgt)	((serv_mgt)->st_mgt)
 
 #define NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)	((serv_mgt)->disp_ops_tbl)
 #define NBL_SERV_MGT_TO_DISP_OPS(serv_mgt) \
@@ -191,6 +194,26 @@ struct nbl_serv_net_resource_mgt {
 	int max_tx_rate;
 };
 
+#define IOCTL_TYPE 'n'
+#define IOCTL_PASSTHROUGH \
+	_IOWR(IOCTL_TYPE, 0x01, struct nbl_passthrough_fw_cmd)
+#define IOCTL_ST_INFO		_IOR(IOCTL_TYPE, 0x02, struct nbl_st_info_param)
+
+#define IOCTL_ST_INFO_VERSION	0x10		/* 1.0 */
+
+struct nbl_serv_st_mgt {
+	void *serv_mgt;
+	struct cdev cdev;
+	int major;
+	int minor;
+	dev_t devno;
+	int subdev_id;
+	char st_name[NBL_RESTOOL_NAME_LEN];
+	char real_st_name[NBL_RESTOOL_NAME_LEN];
+	bool real_st_name_valid;
+	u8 resv[3];
+};
+
 struct nbl_service_mgt {
 	struct nbl_common_info *common;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
@@ -198,6 +221,7 @@ struct nbl_service_mgt {
 	struct nbl_serv_ring_mgt ring_mgt;
 	struct nbl_serv_flow_mgt flow_mgt;
 	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_serv_st_mgt *st_mgt;
 };
 
 struct nbl_serv_notify_vlan_param {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
new file mode 100644
index 000000000000..02dc0ecc481e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_dev.h"
+
+#define NBL_SET_RO_ATTR(dev_name_attr, attr_name, attr_show) do {	\
+	typeof(dev_name_attr) _name_attr = (dev_name_attr);		\
+	(_name_attr)->attr.name = __stringify(attr_name);		\
+	(_name_attr)->attr.mode = SYSFS_PREALLOC |			\
+				  VERIFY_OCTAL_PERMISSIONS(0444);	\
+	(_name_attr)->show = attr_show;					\
+	(_name_attr)->store = NULL;					\
+} while (0)
+
+static ssize_t net_rep_show(struct device *dev,
+			    struct nbl_netdev_name_attr *attr, char *buf)
+{
+	return scnprintf(buf, IFNAMSIZ, "%s\n", attr->net_dev_name);
+}
+
+static ssize_t nbl_st_name_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct nbl_sysfs_st_info *st_info =
+		container_of(attr, struct nbl_sysfs_st_info, kobj_attr);
+	struct nbl_dev_net *net_dev = st_info->net_dev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(net_dev->netdev);
+	struct nbl_adapter *adapter = net_priv->adapter;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	return snprintf(buf, PAGE_SIZE, "nblst/%s\n", st_dev->st_name);
+}
+
+void nbl_netdev_remove_st_sysfs(struct nbl_dev_net *net_dev)
+{
+	if (!net_dev->st_name.st_name_kobj)
+		return;
+
+	sysfs_remove_file(net_dev->st_name.st_name_kobj,
+			  &net_dev->st_name.st_info.kobj_attr.attr);
+
+	kobject_put(net_dev->st_name.st_name_kobj);
+}
+
+int nbl_netdev_add_st_sysfs(struct net_device *netdev,
+			    struct nbl_dev_net *net_dev)
+{
+	int ret;
+
+	net_dev->st_name.st_name_kobj =
+		kobject_create_and_add("resource_tool", &netdev->dev.kobj);
+	if (!net_dev->st_name.st_name_kobj)
+		return -ENOMEM;
+
+	net_dev->st_name.st_info.net_dev = net_dev;
+	sysfs_attr_init(&net_dev->st_name.st_info.kobj_attr.attr);
+	net_dev->st_name.st_info.kobj_attr.attr.name = "st_name";
+	net_dev->st_name.st_info.kobj_attr.attr.mode = 0444;
+	net_dev->st_name.st_info.kobj_attr.show = nbl_st_name_show;
+
+	ret = sysfs_create_file(net_dev->st_name.st_name_kobj,
+				&net_dev->st_name.st_info.kobj_attr.attr);
+
+	if (ret)
+		netdev_err(netdev, "Failed to create st_name sysfs file\n");
+
+	return 0;
+}
+
+void nbl_net_add_name_attr(struct nbl_netdev_name_attr *attr, char *rep_name)
+{
+	sysfs_attr_init(&attr->attr);
+	NBL_SET_RO_ATTR(attr, dev_name, net_rep_show);
+	strscpy(attr->net_dev_name, rep_name, IFNAMSIZ);
+}
+
+void nbl_net_remove_dev_attr(struct nbl_dev_net *net_dev)
+{
+	sysfs_remove_file(&net_dev->netdev->dev.kobj,
+			  &net_dev->dev_attr.dev_name_attr.attr);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
new file mode 100644
index 000000000000..34e5d63addf0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_SYSFS_H_
+#define _NBL_SYSFS_H_
+
+struct nbl_sysfs_st_info {
+	struct nbl_dev_net *net_dev;
+	struct kobj_attribute kobj_attr;
+};
+
+struct nbl_st_name {
+	struct kobject *st_name_kobj;
+	struct nbl_sysfs_st_info st_info;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index 29331407fc41..5a7b4b26bf1b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -27,4 +27,6 @@ void nbl_dev_stop(void *p);
 
 int nbl_dev_setup_vf_config(void *p, int num_vfs);
 void nbl_dev_remove_vf_config(void *p);
+void nbl_dev_register_dev_name(void *p);
+void nbl_dev_get_dev_name(void *p, char *dev_name);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index d7490a60bebb..a908e2f6cb97 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -125,6 +125,10 @@ struct nbl_service_ops {
 
 	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
 
+	int (*setup_st)(void *priv, void *st_table_param, char *st_name);
+	void (*remove_st)(void *priv, void *st_table_param);
+	void (*register_real_st_name)(void *priv, char *st_name);
+
 	int (*setup_vf_config)(void *priv, int num_vfs, bool is_flush);
 	void (*remove_vf_config)(void *priv);
 	void (*register_dev_name)(void *priv, u16 vsi_id, char *name);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 38a9d47ab6ca..0c568488bd1a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -379,6 +379,25 @@ struct nbl_cmd_vf_num {
 	u16 vf_max_num[NBL_VF_NUM_CMD_LEN];
 };
 
+#define NBL_RESTOOL_NAME_LEN	32
+#define NBL_ST_INFO_NAME_LEN				(64)
+#define NBL_ST_INFO_NETDEV_MAX				(8)
+#define NBL_ST_INFO_RESERVED_LEN			(344)
+struct nbl_st_info_param {
+	u8 version;
+	u8 bus;
+	u8 devid;
+	u8 function;
+	u16 domain;
+	u16 rsv0;
+	char driver_name[NBL_ST_INFO_NAME_LEN];
+	char driver_ver[NBL_ST_INFO_NAME_LEN];
+	char netdev_name[NBL_ST_INFO_NETDEV_MAX][NBL_ST_INFO_NAME_LEN];
+	char real_chrdev_flag;
+	char real_chrdev_name[31];
+	u8 rsv[NBL_ST_INFO_RESERVED_LEN];
+} __packed;
+
 #define NBL_OPS_CALL(func, para)		\
 do {						\
 	typeof(func) _func = (func);		\
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 70e62fa0dd97..9749823f5a83 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,6 +7,7 @@
 #include <linux/aer.h>
 #include "nbl_core.h"
 
+static struct nbl_software_tool_table nbl_st_table;
 static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	{
 		.hw_init	= nbl_hw_init_leonis,
@@ -18,6 +19,11 @@ static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	},
 };
 
+static char *nblst_cdevnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "nblst/%s", dev_name(dev));
+}
+
 int nbl_core_start(struct nbl_adapter *adapter, struct nbl_init_param *param)
 {
 	int ret = 0;
@@ -134,6 +140,43 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 	devm_kfree(dev, adapter);
 }
 
+int nbl_st_init(struct nbl_software_tool_table *st_table)
+{
+	dev_t devid;
+	int ret = 0;
+
+	ret = alloc_chrdev_region(&devid, 0, NBL_ST_MAX_DEVICE_NUM, "nblst");
+	if (ret < 0)
+		return ret;
+
+	st_table->major = MAJOR(devid);
+	st_table->devno = devid;
+
+	st_table->cls = class_create("nblst_cls");
+
+	st_table->cls->devnode = nblst_cdevnode;
+	if (IS_ERR(st_table->cls)) {
+		unregister_chrdev(st_table->major, "nblst");
+		unregister_chrdev_region(st_table->devno,
+					 NBL_ST_MAX_DEVICE_NUM);
+		ret = -EBUSY;
+	}
+
+	return ret;
+}
+
+void nbl_st_remove(struct nbl_software_tool_table *st_table)
+{
+	class_destroy(st_table->cls);
+	unregister_chrdev(st_table->major, "nblst");
+	unregister_chrdev_region(st_table->devno, NBL_ST_MAX_DEVICE_NUM);
+}
+
+struct nbl_software_tool_table *nbl_get_st_table(void)
+{
+	return &nbl_st_table;
+}
+
 static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
 			       struct nbl_init_param *param)
 {
@@ -243,6 +286,8 @@ static __maybe_unused int nbl_sriov_configure(struct pci_dev *pdev, int num_vfs)
 		return 0;
 	}
 
+	/* register pf_name to AF first, cuz vf_name depends on pf_anme */
+	nbl_dev_register_dev_name(adapter);
 	err = nbl_dev_setup_vf_config(adapter, num_vfs);
 	if (err) {
 		dev_err(&pdev->dev, "nbl setup vf config failed %d!\n", err);
@@ -357,6 +402,8 @@ static int __init nbl_module_init(void)
 		pr_err("Failed to create wq, err = %d\n", status);
 		goto wq_create_failed;
 	}
+	nbl_st_init(nbl_get_st_table());
+
 	status = pci_register_driver(&nbl_driver);
 	if (status) {
 		pr_err("Failed to register PCI driver, err = %d\n", status);
@@ -375,6 +422,8 @@ static void __exit nbl_module_exit(void)
 {
 	pci_unregister_driver(&nbl_driver);
 
+	nbl_st_remove(nbl_get_st_table());
+
 	nbl_common_destroy_wq();
 
 	pr_info("nbl module unloaded\n");
-- 
2.47.3


