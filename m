Return-Path: <netdev+bounces-261195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ETKBaj4n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:39:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 201671A1EDD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 881B5300E4B6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E79338F939;
	Thu, 26 Feb 2026 07:39:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DF38B7B3;
	Thu, 26 Feb 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091553; cv=none; b=g875Dx4AFEemMxr+hL7AdM5iUQ7TH15v60Ycy68wctOTGshLV/gvG/92VxhFpbcCvY17sDM1jHMvzdxzAgWs2thRYK0KydXMPtBTYO9AA2cfSnKwZXP24g9pb0QBIyJiwAmqbtNtSwLu3F7bMsXs5VWd+IDBPEchkhMEmhq7h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091553; c=relaxed/simple;
	bh=vpO1pK+X6jjBw4igVhJzxFRhRxB8HX3cgz4OAh9KCxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awRQQPb/o+NKWY1AXHh/AnUx9n0VKKUK225ZAg4+E9XtR2lwH3Jam8YKA0RlP86vayumJfQtMvTVDo3cAk0sT+x66r7qc4jsDVLUrnep4l52CFK+GLtAIsIqkRggsCmiMD9nBdR+pBZ9i1x75sjPnKIQXtAW0ljC1djLZzT4Sxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gfIwj0c_1772091545 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 26 Feb 2026 15:39:06 +0800
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
Subject: [PATCH v5 net-next 10/11] net/nebula-matrix: add common/ctrl dev init/reinit operation
Date: Thu, 26 Feb 2026 15:38:35 +0800
Message-ID: <20260226073840.3222-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
References: <20260226073840.3222-1-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261195-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.911];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 201671A1EDD
X-Rspamd-Action: no action

Common Device Setup: nbl_dev_setup_common_dev configures mailbox queues,
registers cleanup tasks, and cfg IRQs.
Control Device Setup (optional): nbl_dev_setup_ctrl_dev initializes
the chip and configures all channel queues.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 172 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  35 ++++
 .../nbl/nbl_include/nbl_include.h             |   7 +-
 3 files changed, 211 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 8db2cfd5488f..bda7ac7d41a3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -6,6 +6,159 @@
 
 #include "nbl_dev.h"
 
+static void nbl_dev_cfg_common_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+
+	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
+}
+
+/* ----------  Channel config  ---------- */
+static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
+	struct device *dev = dev_mgt->common->dev;
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
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
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
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *priv = dev_mgt->chan_ops_tbl->priv;
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
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+
+	if (chan_ops->check_queue_exist(dev_mgt->chan_ops_tbl->priv, chan_type))
+		chan_ops->register_chan_task(dev_mgt->chan_ops_tbl->priv,
+					     chan_type, task);
+}
+
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox_task(struct work_struct *work)
+{
+	struct nbl_dev_common *common_dev =
+		container_of(work, struct nbl_dev_common, clean_mbx_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+
+	chan_ops->clean_queue_subtask(dev_mgt->chan_ops_tbl->priv,
+				      NBL_CHAN_TYPE_MAILBOX);
+}
+
+/* ----------  Dev init process  ---------- */
+static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter,
+				    struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dispatch_mgt *priv = dev_mgt->disp_ops_tbl->priv;
+	struct nbl_common_info *common = dev_mgt->common;
+	struct nbl_dev_common *common_dev;
+
+	common_dev = devm_kzalloc(&adapter->pdev->dev,
+				  sizeof(struct nbl_dev_common), GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
+		goto setup_chan_fail;
+
+	INIT_WORK(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+	common->vsi_id = disp_ops->get_vsi_id(priv, 0, NBL_VSI_DATA);
+	disp_ops->get_eth_id(priv, common->vsi_id, &common->eth_mode,
+			     &common->eth_id, &common->logic_eth_id);
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX,
+				   &common_dev->clean_mbx_task);
+
+	dev_mgt->common_dev = common_dev;
+	nbl_dev_cfg_common_irq(dev_mgt);
+	return 0;
+
+setup_chan_fail:
+	return -EFAULT;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+
+	if (!common_dev)
+		return;
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter,
+				  struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	int i, ret = 0;
+
+	ret = disp_ops->init_chip_module(dev_mgt->disp_ops_tbl->priv);
+	if (ret)
+		goto chip_init_fail;
+
+	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
+		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
+		if (ret)
+			goto setup_chan_q_fail;
+	}
+
+	return 0;
+setup_chan_q_fail:
+	disp_ops->deinit_chip_module(dev_mgt->disp_ops_tbl->priv);
+chip_init_fail:
+	return ret;
+}
+
+static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+
+	disp_ops->deinit_chip_module(dev_mgt->disp_ops_tbl->priv);
+}
+
 static struct nbl_dev_mgt *nbl_dev_setup_dev_mgt(struct nbl_common_info *common)
 {
 	struct nbl_dev_mgt *dev_mgt;
@@ -38,11 +191,30 @@ int nbl_dev_init(struct nbl_adapter *adapter, struct nbl_init_param *param)
 	dev_mgt->chan_ops_tbl = chan_ops_tbl;
 	adapter->core.dev_mgt = dev_mgt;
 
+	ret = nbl_dev_setup_common_dev(adapter, param);
+	if (ret)
+		return ret;
+
+	if (common->is_ctrl) {
+		ret = nbl_dev_setup_ctrl_dev(adapter, param);
+		if (ret)
+			goto setup_ctrl_dev_fail;
+	}
+
 	return 0;
+
+setup_ctrl_dev_fail:
+	nbl_dev_remove_common_dev(adapter);
+	return ret;
 }
 
 void nbl_dev_remove(struct nbl_adapter *adapter)
 {
+	struct nbl_common_info *common = &adapter->common;
+
+	if (common->is_ctrl)
+		nbl_dev_remove_ctrl_dev(adapter);
+	nbl_dev_remove_common_dev(adapter);
 }
 
 /* ----------  Dev start process  ---------- */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
index f94ddff8d7e5..c87b801c2b54 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -9,10 +9,45 @@
 
 #include "nbl_core.h"
 
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | \
+			    NETIF_MSG_LINK | NETIF_MSG_IFDOWN | \
+			    NETIF_MSG_IFUP)
+
+#define NBL_STRING_NAME_LEN			32
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
+};
+
+struct nbl_dev_common {
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_msix_info msix_info;
+	char mailbox_name[NBL_STRING_NAME_LEN];
+	// for ctrl-dev/net-dev mailbox recv msg
+	struct work_struct clean_mbx_task;
+};
+
 struct nbl_dev_mgt {
 	struct nbl_common_info *common;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dev_common *common_dev;
 };
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 4cdb3e97d6d3..d4c7faaee844 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0*/
 /*
  * Copyright (c) 2025 Nebula Matrix Limited.
  * Author:
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 /*  ------  Basic definitions  -------  */
-#define NBL_DRIVER_NAME					"nbl"
+#define NBL_DRIVER_NAME					"nbl_core"
 #define NBL_MAX_PF					8
 #define NBL_NEXT_ID(id, max)				\
 	({						\
@@ -37,7 +37,8 @@ struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
 	u32 is_nic:1;
-	u32 rsv:29;
+	u32 is_ocp:1;
+	u32 rsv:28;
 };
 
 struct nbl_init_param {
-- 
2.47.3


