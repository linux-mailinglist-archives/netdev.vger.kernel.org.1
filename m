Return-Path: <netdev+bounces-305659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X1sQDRD0TWqBAgIAu9opvQ
	(envelope-from <netdev+bounces-305659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6187225EE
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305659-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305659-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027CA306A387
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0C3EB114;
	Wed,  8 Jul 2026 06:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20CE3E3D8C;
	Wed,  8 Jul 2026 06:48:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493287; cv=none; b=GG5gywtrbxsbzu3tlEmPk9d7F3exxC05sXdfuniuLD97O7ZzJAWyN2m9w94mMpWGJJ8MN8pb846kBZ/BeDNCxbM1Qn/ipI/GRKOrCLcOLK6LVfkVnbKyyxVldYH+8WERQo/4DsBoiMESkhPrUAFut+HMBWI32PRP7hk7ynHZjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493287; c=relaxed/simple;
	bh=hj7ktit+15MLVyG2lx/AouUHTW+PSePtO7LGUOa392w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQQ5ORQ2VAD4cJoewq2CodBpqU6/fvqYC3BMkPTuy2TpCZe7k4juudyP9jyY4Or3VM2bBYd6aqWOueBB9GaHZ9Qivgs8gjyslNYfRoAy1OIel059NlrNnAvnXOod0A+cWG283pN3/qhC7ImYWLKNFmFf/t39ZfuxjKAd7kAbXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.99
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0118133-0.00127147-0.986915;FP=16895108975112505058|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iG5uJE0_1783493277;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iG5uJE0_1783493277 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 14:47:58 +0800
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
Subject: [PATCH v21 net-next 12/12] net/nebula-matrix: add common dev start/stop operation
Date: Wed,  8 Jul 2026 14:47:38 +0800
Message-ID: <20260708064742.35391-13-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305659-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:from_mime,nebula-matrix.com:email,nebula-matrix.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B6187225EE

From: illusion wang <illusion.wang@nebula-matrix.com>

Add device start/stop helper functions to manage MSI-X vector mapping,
mailbox interrupt resource initialization and deinitialization.

This patch implements complete startup and shutdown flow for
common device resources:
1. Add nbl_dev_start() to finish device startup procedure:
   - Configure hardware MSI-X mapping table for different interrupt types
   - Allocate required MSI-X irq vectors via pci_alloc_irq_vectors
   - Request threaded mailbox IRQ with top-half/bottom-half handler
   - Enable hardware mailbox interrupt and mark channel interrupt ready

2. Add nbl_dev_stop() to tear down device resources safely in order:
   - Software channel state cleared first, then hardware interrupt masked
   - Free mailbox IRQ handler and release MSI-X vector resources
   - Destroy hardware MSI-X mapping table

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   2 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 264 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_dev.h             |   2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  22 +-
 4 files changed, 288 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index beeabf627402..5ab8555cf91f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -50,5 +50,7 @@ struct nbl_adapter {
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+int nbl_core_start(struct nbl_adapter *adapter);
+void nbl_core_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 7d3800d4694f..ff4185a6e1b6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -6,6 +6,24 @@
 #include <linux/pci.h>
 #include "nbl_dev.h"
 
+static void nbl_dev_clean_mailbox(struct nbl_dev_mgt *dev_mgt);
+
+/* ----------  Interrupt config  ---------- */
+static irqreturn_t nbl_dev_clean_mailbox_top(int __always_unused irq,
+					     void *data)
+{
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t nbl_dev_clean_mailbox_thread(int __always_unused irq,
+						void *data)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)data;
+
+	nbl_dev_clean_mailbox(dev_mgt);
+	return IRQ_HANDLED;
+}
+
 static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = dev_mgt->common_dev;
@@ -14,6 +32,188 @@ static void nbl_dev_init_msix_cnt(struct nbl_dev_mgt *dev_mgt)
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
+	err = request_threaded_irq(irq_num,
+				   nbl_dev_clean_mailbox_top,
+				   nbl_dev_clean_mailbox_thread,
+				   0,
+				   dev_common->mailbox_name,
+				   dev_mgt);
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
+	 * Disable sequence invariant: update software state first, then mask
+	 * hardware interrupt. Must not reverse the order.
+	 *
+	 * If hardware interrupt is masked before clearing INTERRUPT_READY,
+	 * the hardware may still transmit outstanding ACK packets for in-flight
+	 * messages. Subsequent switch to polling mode discards pending ACK
+	 * processing, triggering "Channel waiting ack failed" and "Skip ack
+	 * with invalid status" errors.
+	 *
+	 * By entering polling mode first, any late hardware interrupts are
+	 * ignored without pending ACK expectations, then hardware interrupt
+	 * can be safely disabled.
+	 *
+	 * This helper is invoked in two paths:
+	 * 1. Error unwind path of nbl_dev_start(): immediately followed by
+	 *    nbl_dev_free_mailbox_irq(), channel resources
+	 *    are fully torn down afterwards, no stale descriptors remain.
+	 * 2. Normal device stop path nbl_dev_stop(): free_irq() synchronously
+	 *    waits for any in-flight threaded irq bottom-half handler to
+	 *    finish execution, all pending mailbox cleanup work completes
+	 *    before channel teardown in late remove stage. No stuck
+	 *    descriptors will linger in either scenario.
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
@@ -50,6 +250,15 @@ static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
 	return ret;
 }
 
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = dev_mgt->chan_ops_tbl->ops;
+
+	chan_ops->clean_queue_subtask(dev_mgt->chan_ops_tbl->priv,
+				      NBL_CHAN_TYPE_MAILBOX);
+}
+
 /* ----------  Dev init process  ---------- */
 static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter)
 {
@@ -198,3 +407,58 @@ void nbl_dev_remove(struct nbl_adapter *adapter)
 		nbl_dev_remove_ctrl_dev(adapter);
 	nbl_dev_remove_common_dev(adapter);
 }
+
+/* ----------  Dev start process  ---------- */
+int nbl_dev_start(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
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
+	return 0;
+enable_mailbox_irq_err:
+	cleanup_ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", cleanup_ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+mailbox_request_irq_err:
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+init_interrupt_scheme_err:
+	cleanup_ret =  nbl_dev_destroy_msix_map(dev_mgt);
+	if (cleanup_ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", cleanup_ret);
+	return ret;
+}
+
+void nbl_dev_stop(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = adapter->core.dev_mgt;
+	int ret;
+
+	ret = nbl_dev_disable_mailbox_irq(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to disable mailbox IRQ: %d\n", ret);
+	nbl_dev_free_mailbox_irq(dev_mgt);
+	nbl_dev_clear_interrupt_scheme(dev_mgt);
+	ret = nbl_dev_destroy_msix_map(dev_mgt);
+	if (ret)
+		dev_err(dev_mgt->common->dev,
+			"Failed to destroy MSI-X map: %d\n", ret);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index b422a4edf0a9..32e6cce38d39 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -10,5 +10,7 @@ struct nbl_adapter;
 
 int nbl_dev_init(struct nbl_adapter *adapter);
 void nbl_dev_remove(struct nbl_adapter *adapter);
+int nbl_dev_start(struct nbl_adapter *adapter);
+void nbl_dev_stop(struct nbl_adapter *adapter);
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 7a9cfe5cff9e..699f3bbe73c4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -16,6 +16,16 @@
 #include "nbl_include/nbl_def_common.h"
 #include "nbl_core.h"
 
+int nbl_core_start(struct nbl_adapter *adapter)
+{
+	return nbl_dev_start(adapter);
+}
+
+void nbl_core_stop(struct nbl_adapter *adapter)
+{
+	nbl_dev_stop(adapter);
+}
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param)
 {
@@ -135,7 +145,14 @@ static int nbl_probe(struct pci_dev *pdev,
 		goto adapter_init_err;
 	}
 	pci_set_drvdata(pdev, adapter);
+	err = nbl_core_start(adapter);
+	if (err)
+		goto core_start_err;
+
 	return 0;
+core_start_err:
+	pci_set_drvdata(pdev, NULL);
+	nbl_core_remove(adapter);
 adapter_init_err:
 	pci_clear_master(pdev);
 configure_dma_err:
@@ -147,9 +164,10 @@ static void nbl_remove(struct pci_dev *pdev)
 {
 	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
 
-	if (adapter)
+	if (adapter) {
+		nbl_core_stop(adapter);
 		nbl_core_remove(adapter);
-
+	}
 	pci_restore_state(pdev);
 	pci_clear_master(pdev);
 	pci_disable_device(pdev);
-- 
2.47.3


