Return-Path: <netdev+bounces-302871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q6bPHwkXQ2pePwoAu9opvQ
	(envelope-from <netdev+bounces-302871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:08:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACB6DF819
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302871-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302871-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE0DB301D744
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8E26E6F2;
	Tue, 30 Jun 2026 01:07:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95EF1A680B;
	Tue, 30 Jun 2026 01:07:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782781660; cv=none; b=JZPJOR8ix4W9FWFTzcZHFrdOqyOu0EPemAVsVi0uKvrjAIVmrYLgh0ZRQVMcB7oT0a5NXB8cdHlBejoMYtF4/EBbM8i66HuRlPVqZEyi0sMEWmBSX1ISHmV7zZOaFi8SKGruMGevNmwgoDg8Nt/XmFnyAE31SOkk6id+0lBpAA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782781660; c=relaxed/simple;
	bh=OO18g66oL3xPm/7xwV7rZ1et6yoB12aNbD3koZn3+6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9soae2tyO/TD9dRG9tQfXR/Qn/mN62QQKtbD3x5cOiAFgNFw5KazO7R02Nh3yaWsy496PfDEd1npJQI2pcfzHbRgDtWtPAmsgz2u8aNap2jy53aHo7qugIz8IHBJzFqJ/Ml/yAZsjft6sTkE3dhrk07OTHn1sTlS8AS1bAOsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.76
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00678158-0.00402133-0.989197;FP=16884553646306119406|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.i91QN6e_1782781653;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.i91QN6e_1782781653 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 09:07:34 +0800
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
Subject: [PATCH v20 net-next 10/10] net/nebula-matrix: add common dev start/stop operation
Date: Tue, 30 Jun 2026 09:07:12 +0800
Message-ID: <20260630010718.4346-11-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630010718.4346-1-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:dimon.zhao@nebula-matrix.com,m:illusion.wang@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:email,nebula-matrix.com:mid,nebula-matrix.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20ACB6DF819

From: illusion wang <illusion.wang@nebula-matrix.com>

This patch wires up nbl_dev_start() and nbl_dev_stop() to configure
the MSI-X map, allocate vectors, and request/enable the mailbox IRQ.
It also adds a workqueue in nbl_dev_init() for the new IRQ handler.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  24 ++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 256 +++++++++++++++++-
 .../nbl/nbl_include/nbl_def_common.h          |   6 +
 3 files changed, 284 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
index 2954cbbe0f95..bae1a7e401ce 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -6,6 +6,30 @@
 #include <linux/device.h>
 #include "nbl_common.h"
 
+void nbl_common_queue_work(struct nbl_common_info *common,
+			   struct work_struct *task)
+{
+	queue_work(common->wq, task);
+}
+
+void nbl_common_destroy_wq(struct nbl_common_info *common)
+{
+	destroy_workqueue(common->wq);
+}
+
+int nbl_common_create_wq(struct nbl_common_info *common)
+{
+	common->wq = alloc_workqueue("nbl_wq", WQ_UNBOUND, 0);
+	if (!common->wq) {
+		pr_err("Failed to create workqueue nbl_wq\n");
+		goto alloc_wq_failed;
+	}
+
+	return 0;
+alloc_wq_failed:
+	return -ENOMEM;
+}
+
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id)
 {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 8feae561d0f1..45cdd4f6e9c4 100644
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
@@ -14,6 +25,182 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+	/*
+	 * Disable order: software state first, then hardware.
+	 *
+	 * Review suggested HW-then-state for symmetry with enable, but that
+	 * causes "Channel waiting ack failed" errors. The reason: after
+	 * set_mailbox_irq(..., false) disables the hardware, the device may
+	 * still be sending ACKs for in-flight messages. If we then switch to
+	 * polling mode (clear INTERRUPT_READY), the ACK handler won't process
+	 * those pending ACKs, leading to "waiting ack failed" and "Skip ack
+	 * with invalid status" errors.
+	 *
+	 * The original state-then-HW order avoids this: we switch to polling
+	 * first, so any late interrupts are silently ignored (no ACK expected),
+	 * then we disable the hardware. The theoretical window where an
+	 * interrupt could fire and be ignored is harmless here because this
+	 * function is only called on the error path of nbl_dev_start(),
+	 * immediately followed by nbl_dev_free_mailbox_irq() and
+	 * cancel_work_sync(&clean_mbx_task). The channel is torn down right
+	 * after, so no descriptors can be left stuck.
+	 *
+	 * Do NOT change to HW-then-state.
+	 */
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
+static int nbl_dev_init_interrupt_scheme(struct nbl_dev_mgt *dev_mgt)
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
@@ -72,6 +259,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
 				      NBL_CHAN_TYPE_MAILBOX);
 }
 
+static void nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	struct nbl_common_info *common = dev_mgt->common;
+
+	nbl_common_queue_work(common, &common_dev->clean_mbx_task);
+}
+
 /* ----------  Dev init process  ---------- */
 static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
 {
@@ -189,10 +384,12 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	dev_mgt->disp_ops_tbl = disp_ops_tbl;
 	dev_mgt->chan_ops_tbl = chan_ops_tbl;
 	adapter->core.dev_mgt = dev_mgt;
-
-	ret = nbl_dev_setup_common_dev(adapter);
+	ret = nbl_common_create_wq(common);
 	if (ret)
 		return ret;
+	ret = nbl_dev_setup_common_dev(adapter);
+	if (ret)
+		goto setup_err;
 
 	if (common->has_ctrl) {
 		ret = nbl_dev_setup_ctrl_dev(adapter);
@@ -203,6 +400,8 @@ int nbl_dev_init(struct nbl_adapter *adapter)
 	return 0;
 setup_ctrl_dev_fail:
 	nbl_dev_remove_common_dev(adapter);
+setup_err:
+	nbl_common_destroy_wq(common);
 	return ret;
 }
 
@@ -213,14 +412,67 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 	if (common->has_ctrl)
 		nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
+	nbl_common_destroy_wq(common);
 }
 
 /* ----------  Dev start process  ---------- */
 int nbl_dev_start(struct nbl_adapter *adapter)
 {
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int cleanup_ret;
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
+	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	/* just log err*/
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", cleanup_ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	cleanup_ret =  nbl_dev_destroy_msix_map(dev_mgt);
+	/* just log err*/
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", cleanup_ret);
+	return ret;
 }
 
 void nbl_dev_stop(struct nbl_adapter *adapter)
 {
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	struct nbl_dev_common *common_dev = dev_mgt->common_dev;
+	int ret;
+
+	/* just log err*/
+	ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	cancel_work_sync(&common_dev->clean_mbx_task);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index bc741b7df7b9..4621b3ce5856 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -29,6 +29,7 @@ struct nbl_hash_tbl_mgt;
 	})
 
 struct nbl_common_info {
+	struct workqueue_struct *wq;
 	struct pci_dev *pdev;
 	struct device *dev;
 	u32 msg_enable;
@@ -61,6 +62,11 @@ struct nbl_hash_tbl_del_key {
 	void (*action_func)(void *priv, void *key, void *data);
 };
 
+void nbl_common_queue_work(struct nbl_common_info *common,
+			   struct work_struct *task);
+
+void nbl_common_destroy_wq(struct nbl_common_info *common);
+int nbl_common_create_wq(struct nbl_common_info *common);
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
 					  u32 pf_id);
 
-- 
2.47.3


