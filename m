Return-Path: <netdev+bounces-252583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMh6K1/OcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D966F118
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06F0307C8D5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EA2EBB86;
	Fri, 23 Jan 2026 01:19:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91057346E50;
	Fri, 23 Jan 2026 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131173; cv=none; b=OksdxSbUuv3VfpzDP3zzD4XFqHhiJc6+knhVBDgmwmLfks86E7Vse4zqxHtx65fcOk4J/QZcVCOYSnDc01WMTnpIder84BQ/MdoUybzbOVa65gSWVaVnnx9VFkfeFvBa8aHTMfs+h95/aBVcvLFJnhhgXK3/Nf8q5CXRKfhVHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131173; c=relaxed/simple;
	bh=shHqp0zN1kXuqxP2Bx3cefL8YSHMkytNmUJKneZlmjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYSOY8YmIszwQo/3fhYaBSiOyg5cHqJKS8E2vgFXpkYtdQIEvij+VLi3+TrvOhIB/ffs2C2P2c/4iwa2snf7SMtcWM8IE8VZ6Aa4f41O75H6Dz0UMB23IR4squ10qxnLEh5rbYNNH2dAF+JmWf8SwKkKMevq5bYbiVhM5iMdxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYWIi_1769131134 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:55 +0800
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
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 13/15] net/nebula-matrix: add net dev init/reinit operation
Date: Fri, 23 Jan 2026 09:17:50 +0800
Message-ID: <20260123011804.31263-14-illusion.wang@nebula-matrix.com>
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
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252583-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 44D966F118
X-Rspamd-Action: no action

net dev init:vsi build, register vsi, register net irq

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 315 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  |  81 +++++
 2 files changed, 396 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index b661d8ab972c..2d34ab101144 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -20,6 +20,16 @@ static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
 	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
 }
 
+static void nbl_dev_register_net_irq(struct nbl_dev_mgt *dev_mgt, u16 queue_num)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info =
+		NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+
+	msix_info->serv_info[NBL_MSIX_NET_TYPE].num = queue_num;
+	msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en = 1;
+}
+
 /* ----------  Channel config  ---------- */
 static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -185,6 +195,303 @@ static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
 	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
 }
 
+static const struct net_device_ops netdev_ops_leonis_pf = {
+};
+
+static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
+				       struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	netdev->netdev_ops = &netdev_ops_leonis_pf;
+	serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 &netdev_ops_leonis_pf, true);
+	return 0;
+}
+
+static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_register_net_param register_param = {0};
+	int ret;
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
+	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->kernel_queue_num)
+		return -ENOSPC;
+
+	queue_offset = vsi_ctrl->queue_free_offset;
+	vsi_ctrl->queue_free_offset += queue_num;
+
+	return queue_offset;
+}
+
+static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt,
+				    struct nbl_init_param *param,
+				    struct nbl_dev_vsi *vsi)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_vsi_param vsi_param = { 0 };
+	int ret;
+
+	vsi->queue_offset = nbl_dev_vsi_alloc_queue(net_dev,
+						    vsi->queue_num);
+	vsi_param.index = vsi->index;
+	vsi_param.vsi_id = vsi->vsi_id;
+	vsi_param.queue_offset = vsi->queue_offset;
+	vsi_param.queue_num = vsi->queue_num;
+
+	/* Tell serv & res layer the mapping from vsi to queue_id */
+	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  &vsi_param);
+	return ret;
+}
+
+static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt,
+				      struct nbl_dev_vsi *vsi)
+{
+}
+
+static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt,
+				     struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int ret;
+
+	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
+	if (ret)
+		return ret;
+
+	vsi->queue_num = vsi->register_result.tx_queue_num;
+	vsi->queue_size = vsi->register_result.queue_size;
+
+	nbl_debug(common, "Data vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+
+	return 0;
+}
+
+static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt,
+				  struct nbl_init_param *param, void *vsi_data)
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
+static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
+	[NBL_VSI_DATA] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_data_register,
+			.setup = nbl_dev_vsi_data_setup,
+			.remove = nbl_dev_vsi_data_remove,
+		},
+	},
+};
+
+static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt,
+			     struct nbl_init_param *param)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	void *priv = NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt);
+	struct nbl_dev_vsi *vsi = NULL;
+	int i;
+
+	net_dev->vsi_ctrl.queue_num = 0;
+	net_dev->vsi_ctrl.queue_free_offset = 0;
+
+	/* Build all vsi, and alloc vsi_id for each of them */
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi),
+				   GFP_KERNEL);
+		if (!vsi)
+			goto malloc_vsi_fail;
+
+		vsi->ops = &vsi_tbl[i].vsi_ops;
+		vsi->vsi_id = serv_ops->get_vsi_id(priv, 0, i);
+		vsi->index = i;
+
+		net_dev->vsi_ctrl.vsi_list[i] = vsi;
+	}
+
+	return 0;
+
+malloc_vsi_fail:
+	while (--i + 1) {
+		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt),
+			   net_dev->vsi_ctrl.vsi_list[i]);
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
+			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt),
+				   net_dev->vsi_ctrl.vsi_list[i]);
+			net_dev->vsi_ctrl.vsi_list[i] = NULL;
+		}
+}
+
+struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt,
+				       u8 vsi_index)
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
+static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
+	{
+		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
+	},
+};
+
+static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt,
+				      struct nbl_init_param *param)
+{
+	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
+}
+
+static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter,
+				 struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	struct nbl_dev_vsi *vsi;
+	u16 kernel_queue_num = 0;
+	int i, ret;
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
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt),
+				"Vsi %d register failed", vsi->index);
+			goto vsi_register_fail;
+		}
+		kernel_queue_num += vsi->queue_num;
+	}
+
+	(*net_dev)->kernel_queue_num = kernel_queue_num;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+		ret = vsi->ops->setup(dev_mgt, param, vsi);
+		if (ret) {
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt),
+				"Vsi %d setup failed", vsi->index);
+			goto vsi_setup_fail;
+		}
+	}
+
+	nbl_dev_register_net_irq(dev_mgt, kernel_queue_num);
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
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAP_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	int i;
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
+
+	nbl_dev_unregister_net(dev_mgt);
+
+	devm_kfree(dev, *net_dev);
+	*net_dev = NULL;
+}
+
 static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common,
 				 struct nbl_dev_mgt **dev_mgt)
 {
@@ -257,12 +564,19 @@ int nbl_dev_init(void *p, struct nbl_init_param *param)
 		if (ret)
 			goto setup_ctrl_dev_fail;
 	}
+
+	ret = nbl_dev_setup_net_dev(adapter, param);
+	if (ret)
+		goto setup_net_dev_fail;
+
 	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
 	if (ret)
 		goto setup_ops_fail;
 	return 0;
 
 setup_ops_fail:
+	nbl_dev_remove_net_dev(adapter);
+setup_net_dev_fail:
 	if (common->is_ctrl)
 		nbl_dev_remove_ctrl_dev(adapter);
 setup_ctrl_dev_fail:
@@ -284,6 +598,7 @@ void nbl_dev_remove(void *p)
 		&NBL_ADAP_TO_DEV_OPS_TBL(adapter);
 
 	nbl_dev_remove_ops(dev, dev_ops_tbl);
+	nbl_dev_remove_net_dev(adapter);
 	if (common->is_ctrl)
 		nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 1c2f8d7e4272..ad41117511d0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -13,6 +13,26 @@
 
 #include "nbl_service.h"
 
+static int
+nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
+		      struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->register_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      register_param, register_result);
+}
+
+static int nbl_serv_unregister_net(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	return disp_ops->unregister_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
 static int nbl_serv_init_chip(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -72,10 +92,71 @@ static void nbl_serv_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode,
 				    eth_mode, eth_id, logic_eth_id);
 }
 
+static void nbl_serv_set_netdev_ops(void *priv,
+				    const struct net_device_ops *net_device_ops,
+				    bool is_pf)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+		NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+
+	dev_dbg(dev, "set netdev ops:%p is_pf:%d\n", net_device_ops, is_pf);
+	if (is_pf)
+		net_resource_mgt->netdev_ops.pf_netdev_ops =
+			(void *)net_device_ops;
+}
+
+static int nbl_serv_register_vsi_info(void *priv,
+				      struct nbl_vsi_param *vsi_param)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 vsi_index = vsi_param->index;
+	u32 num_cpus;
+
+	ring_mgt->vsi_info[vsi_index].vsi_index = vsi_index;
+	ring_mgt->vsi_info[vsi_index].vsi_id = vsi_param->vsi_id;
+	ring_mgt->vsi_info[vsi_index].ring_offset = vsi_param->queue_offset;
+	ring_mgt->vsi_info[vsi_index].ring_num = vsi_param->queue_num;
+
+	/* init active ring number before first open, guarantee fd direct
+	 *config check success.
+	 */
+	num_cpus = num_online_cpus();
+	ring_mgt->vsi_info[vsi_index].active_ring_num =
+		(u16)num_cpus > vsi_param->queue_num ? vsi_param->queue_num :
+						       (u16)num_cpus;
+
+	/*
+	 * Clear cfgs, in case this function exited abnormaly last time.
+	 * only for data vsi, vf in vm only support data vsi.
+	 * DPDK user vsi can not leak resource.
+	 */
+	if (vsi_index == NBL_VSI_DATA)
+		disp_ops->clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				       vsi_param->vsi_id);
+	disp_ops->register_vsi_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				    vsi_index, vsi_param->queue_offset,
+				    vsi_param->queue_num);
+
+	return disp_ops->register_vsi2q(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					vsi_index, vsi_param->vsi_id,
+					vsi_param->queue_offset,
+					vsi_param->queue_num);
+}
+
 static struct nbl_service_ops serv_ops = {
 	.init_chip = nbl_serv_init_chip,
 	.destroy_chip = nbl_serv_destroy_chip,
 
+	.register_net = nbl_serv_register_net,
+	.unregister_net = nbl_serv_unregister_net,
+
+	.register_vsi_info = nbl_serv_register_vsi_info,
+
+	.set_netdev_ops = nbl_serv_set_netdev_ops,
 	.get_vsi_id = nbl_serv_get_vsi_id,
 	.get_eth_id = nbl_serv_get_eth_id,
 };
-- 
2.47.3


