Return-Path: <netdev+bounces-291536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EeiJAEbFWrkSgcAu9opvQ
	(envelope-from <netdev+bounces-291536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:01:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CB5D089B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 06:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482C73073717
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1753BB13A;
	Tue, 26 May 2026 03:55:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6083BB121;
	Tue, 26 May 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779767726; cv=none; b=sxgRlIAi1Q2+tv1cnAqC3xFSjtQXskVSgoapcQlFwyETBBzXDxBuzxA4qrgW4Hj+zXd/yjAVA5iWQm3+hfwK5mIQjnXBDYY3156QE9fvzyY30F0W/qYg5UcMkfqah/wgPkhzlW9hQnLiK6Wf2OZCHQc77igLNBmay9TDXpT+WP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779767726; c=relaxed/simple;
	bh=q04LCfxibnc4ys/JWTf8b/7t5auf1fg/vUVw+GLGJac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac79Y8VzPxw+ATHR5aKPjF3ft87xHx+ZCCU5yWmHxjRVCU8UpCcz00PDNy128or+TXpoPhBAEk8cNqzXWrAgKycAs8pgfB1SrGGPVNes79jxzkNJrnvfVO0n1lHwaiRNaDGHoXXJ1jPPyQQnq+FH5fFCPSrxHSM7Ejyl9H6hG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0160118-0.00258281-0.981405;FP=16867630513087205026|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hgpPbOo_1779767709;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hgpPbOo_1779767709 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 11:55:10 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v16 net-next 11/11] net/nebula-matrix: add common dev start/stop operation
Date: Tue, 26 May 2026 11:54:48 +0800
Message-ID: <20260526035453.2359-12-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526035453.2359-1-illusion.wang@nebula-matrix.com>
References: <20260526035453.2359-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-291536-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nebula-matrix.com:mid,nebula-matrix.com:email,pci:email]
X-Rspamd-Queue-Id: 3E9CB5D089B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch wires up nbl_dev_start() and nbl_dev_stop() to configure
the MSI-X map, allocate vectors, and request/enable the mailbox IRQ.
It also replaces module_pci_driver() with explicit init/exit functions
that additionally create and destroy the driver's workqueue via
nbl_common_create_wq() / nbl_common_destroy_wq(), which is needed
because the new IRQ handler schedules work through
nbl_common_queue_work().

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  36 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 220 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_common.h          |   4 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  31 ++-
 4 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index 11b1948658d9..9482bcdc46bc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -6,6 +6,42 @@
 #include <linux/device.h>
 #include "nbl_common.h"
 
+static struct nbl_common_wq_mgt *wq_mgt;
+
+void nbl_common_queue_work(struct work_struct *task)
+{
+	queue_work(wq_mgt->ctrl_dev_wq, task);
+}
+
+void nbl_common_destroy_wq(void)
+{
+	if (!wq_mgt)
+		return;
+	destroy_workqueue(wq_mgt->ctrl_dev_wq);
+	kfree(wq_mgt);
+	wq_mgt = NULL;
+}
+
+int nbl_common_create_wq(void)
+{
+	wq_mgt = kzalloc_obj(*wq_mgt);
+	if (!wq_mgt)
+		return -ENOMEM;
+
+	wq_mgt->ctrl_dev_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_UNBOUND,
+					      0, "nbl_ctrldev_wq");
+	if (!wq_mgt->ctrl_dev_wq) {
+		pr_err("Failed to create workqueue nbl_ctrldev_wq\n");
+		goto alloc_ctrl_dev_wq_failed;
+	}
+
+	return 0;
+alloc_ctrl_dev_wq_failed:
+	kfree(wq_mgt);
+	wq_mgt = NULL;
+	return -ENOMEM;
+}
+
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id)
 {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 44fd1605380e..7afde0265199 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -6,6 +6,17 @@
 #include <linux/pci.h>
 #include "nbl_dev.h"
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
+
+/* ----------  Interrupt config  ---------- */
+static irqreturn_t nbl_dev_clean_mailbox(int __always_unused irq, void *data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
+
+	nbl_dev_clean_mailbox_schedule(dev_mgt);
+	return IRQ_HANDLED;
+}
+
 static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
@@ -14,6 +25,173 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = 1;
 }
 
+static int nbl_dev_request_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	u16 local_vec_id;
+	int irq_num;
+	int err;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, local_vec_id);
+	if (irq_num < 0) {
+		dev_err(common->dev, "Failed to get mailbox IRQ vector: %d\n",
+			irq_num);
+		return irq_num;
+	}
+
+	snprintf(dev_common->mailbox_name, sizeof(dev_common->mailbox_name),
+		 "nbl_mailbox@pci:%s", pci_name(common->pdev));
+	err = request_irq(irq_num, nbl_dev_clean_mailbox, 0,
+			  dev_common->mailbox_name, dev_mgt);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void nbl_dev_free_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	u16 local_vec_id;
+	int irq_num;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	irq_num = pci_irq_vector(common->pdev, local_vec_id);
+	if (irq_num >= 0)
+		free_irq(irq_num, dev_mgt);
+}
+
+static int nbl_dev_enable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, true);
+
+	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					    local_vec_id, true);
+}
+
+static int nbl_dev_disable_mailbox_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	u16 local_vec_id;
+
+	if (!msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num)
+		return 0;
+
+	local_vec_id =
+		msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].base_vector_id;
+	chan_ops->set_queue_state(dev_mgt->chan_ops_tbl->priv,
+				  NBL_CHAN_INTERRUPT_READY,
+				  NBL_CHAN_TYPE_MAILBOX, false);
+
+	return disp_ops->set_mailbox_irq(dev_mgt->disp_ops_tbl->priv,
+					    local_vec_id, false);
+}
+
+static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
+	u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
+	u16 msix_not_net_num = 0;
+	int err, i;
+
+	msix_info->serv_info[NBL_MSIX_VIRTIO_TYPE].base_vector_id = 0;
+	for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
+		msix_info->serv_info[i].base_vector_id =
+			msix_info->serv_info[i - 1].base_vector_id +
+			msix_info->serv_info[i - 1].num;
+
+	for (i = NBL_MSIX_MAILBOX_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
+		msix_not_net_num += msix_info->serv_info[i].num;
+
+	err = disp_ops->configure_msix_map(dev_mgt->disp_ops_tbl->priv,
+					   msix_net_num, msix_not_net_num,
+					   mask_en);
+
+	return err;
+}
+
+static int nbl_dev_destroy_msix_map(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
+
+	return disp_ops->destroy_msix_map(dev_mgt->disp_ops_tbl->priv);
+}
+
+static int nbl_dev_alloc_msix_intr(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
+	struct nbl_msix_info *msix_info = &dev_common->msix_info;
+	struct nbl_common_info *common = dev_mgt->common;
+	int needed = 0;
+	int err;
+	int i;
+
+	for (i = 0; i < NBL_MSIX_TYPE_MAX; i++)
+		needed += msix_info->serv_info[i].num;
+
+	err = pci_alloc_irq_vectors(common->pdev, needed, needed,
+				    PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+	if (err < 0) {
+		dev_err(common->dev,
+			"pci_alloc_irq_vectors failed, err = %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	int err;
+
+	err = nbl_dev_alloc_msix_intr(dev_mgt);
+	if (err) {
+		dev_err(dev_mgt->common->dev,
+			"Failed to enable MSI-X vectors\n");
+		return err;
+	}
+	return 0;
+}
+
+static void nbl_dev_clear_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = dev_mgt->common;
+
+	pci_free_irq_vectors(common->pdev);
+}
+
 /* ----------  Channel config  ---------- */
 static void nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 {
@@ -72,6 +250,13 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
 				      NBL_CHAN_TYPE_MAILBOX);
 }
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+
+	nbl_common_queue_work(&common_dev->clean_mbx_task);
+}
+
 /* ----------  Dev init process  ---------- */
 static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
 {
@@ -221,9 +406,44 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 /* ----------  Dev start process  ---------- */
 int nbl_dev_start(struct nbl_adapter *adapter)
 {
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int ret;
+
+	ret = nbl_dev_configure_msix_map(dev_mgt);
+	if (ret)
+		return ret;
+
+	ret = nbl_dev_init_interrupt_scheme(dev_mgt);
+	if (ret)
+		goto init_interrupt_scheme_err;
+	ret = nbl_dev_request_mailbox_irq(dev_mgt);
+	if (ret)
+		goto mailbox_request_irq_err;
+	ret = nbl_dev_enable_mailbox_irq(dev_mgt);
+	if (ret)
+		goto enable_mailbox_irq_err;
+
 	return 0;
+enable_mailbox_irq_err:
+	nbl_dev_disable_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	nbl_dev_destroy_msix_map(dev_mgt);
+	return ret;
 }
 
 void nbl_dev_stop(struct nbl_adapter *adapter)
 {
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+
+	nbl_dev_disable_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	nbl_dev_destroy_msix_map(dev_mgt);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 09d20d3235fe..2a35399cd1ec 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -62,6 +62,10 @@ struct nbl_hash_tbl_del_key {
 	void (*action_func)(void *priv, void *key, void *data);
 };
 
+void nbl_common_queue_work(struct work_struct *task);
+
+void nbl_common_destroy_wq(void);
+int nbl_common_create_wq(void);
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index a45c0bd93540..2d60499667cb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -302,7 +302,36 @@ static struct pci_driver nbl_driver = {
 	.remove = nbl_remove,
 };
 
-module_pci_driver(nbl_driver);
+static int __init nbl_module_init(void)
+{
+	int status;
+
+	status = nbl_common_create_wq();
+	if (status) {
+		pr_err("Failed to create wq, err = %d\n", status);
+		goto wq_create_failed;
+	}
+	status = pci_register_driver(&nbl_driver);
+	if (status) {
+		pr_err("Failed to register PCI driver, err = %d\n", status);
+		goto pci_register_driver_failed;
+	}
+
+	return 0;
+
+pci_register_driver_failed:
+	nbl_common_destroy_wq();
+wq_create_failed:
+	return status;
+}
+
+static void __exit nbl_module_exit(void)
+{
+	pci_unregister_driver(&nbl_driver);
+	nbl_common_destroy_wq();
+}
 
+module_init(nbl_module_init);
+module_exit(nbl_module_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Nebula Matrix Network Driver");
-- 
2.47.3


