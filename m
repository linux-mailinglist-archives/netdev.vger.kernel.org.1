Return-Path: <netdev+bounces-252582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHizFDvOcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA36F6F0E6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F543306C547
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249FE37BE76;
	Fri, 23 Jan 2026 01:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395FB36C0B4;
	Fri, 23 Jan 2026 01:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131172; cv=none; b=fyqgWuRin+keyVZ5TMJFrT9zBJ5YCKzKWPlF56dHyQChKLvticjD+JmbiWmu/GNzt2dES90fyiM/T4RU9wuShHqoYJ49j9/PGVy+di386+DfpRWWIZGip6v0KypCGYtKoIrMsvNxfHZaP2+f8Hmf8L8mJ4S6Y4VmPXNffCsHSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131172; c=relaxed/simple;
	bh=/p/Dw+UQPKU/Y7ZDMhOSdQwYlOmThz+Dvgoqntn/GWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPUNlYU0cUX1rsa47ce6g4ANuxccRYFf/GklChK2WtJX8VyLimVn4vN2feFYzET5JPmYFspNUkQQdNheWyAWwSgNqalIGZWTILb5BLiWaAAmd/ZAFG6vD3cTQKX1xdgok9xLoP2d5goaKDaMYUoD9xz87nzcW193XB3tzvv5fOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYWLi_1769131135 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:56 +0800
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
Subject: [PATCH v3 net-next 14/15] net/nebula-matrix: add common dev start/stop operation
Date: Fri, 23 Jan 2026 09:17:51 +0800
Message-ID: <20260123011804.31263-15-illusion.wang@nebula-matrix.com>
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
	TAGGED_FROM(0.00)[bounces-252582-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,pci:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA36F6F0E6
X-Rspamd-Action: no action

start common dev: config msix map table, alloc and enable msix vectors,
register mailbox ISR and enable mailbox irq

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 306 +++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 395 +++++++++++++++++-
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  34 +-
 3 files changed, 732 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 2d34ab101144..cdc1baa5988d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -11,6 +11,17 @@
 #include "nbl_dev.h"
 
 static struct nbl_dev_ops dev_ops;
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt);
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
 static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
 {
 	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
@@ -30,6 +41,237 @@ static void nbl_dev_register_net_irq(struct nbl_dev_mgt *dev_mgt, u16 queue_num)
 	msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en = 1;
 }
 
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
+	nbl_common_flush_task(&dev_common->clean_mbx_task);
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
+
+	return serv_ops->destroy_msix_map(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
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
@@ -96,6 +338,14 @@ static void nbl_dev_clean_mailbox_task(struct work_struct *work)
 				      NBL_CHAN_TYPE_MAILBOX);
 }
 
+static int nbl_dev_clean_mailbox_schedule(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+
+	nbl_common_queue_work(&common_dev->clean_mbx_task, false);
+	return 0;
+}
+
 /* ----------  Dev init process  ---------- */
 static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter,
 				    struct nbl_init_param *param)
@@ -572,6 +822,7 @@ int nbl_dev_init(void *p, struct nbl_init_param *param)
 	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
 	if (ret)
 		goto setup_ops_fail;
+
 	return 0;
 
 setup_ops_fail:
@@ -605,11 +856,64 @@ void nbl_dev_remove(void *p)
 	nbl_dev_remove_dev_mgt(common, dev_mgt);
 }
 
-int nbl_dev_start(void *p, struct nbl_init_param *param)
+/* ----------  Dev start process  ---------- */
+
+static int nbl_dev_start_common_dev(struct nbl_adapter *adapter,
+				    struct nbl_init_param *param)
 {
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
 	return 0;
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
+	nbl_dev_disable_mailbox_irq(dev_mgt);
+	nbl_dev_free_mailbox_irq(dev_mgt);
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
+	return ret;
 }
 
 void nbl_dev_stop(void *p)
 {
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+
+	nbl_dev_stop_common_dev(adapter);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index ad41117511d0..b83b79a8001f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -13,6 +13,97 @@
 
 #include "nbl_service.h"
 
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
 static int
 nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
 		      struct nbl_register_net_result *register_result)
@@ -33,6 +124,227 @@ static int nbl_serv_unregister_net(void *priv)
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
+	ring_mgt->net_msix_mask_en = enable;
+}
+
 static int nbl_serv_init_chip(void *priv)
 {
 	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
@@ -73,6 +385,68 @@ static int nbl_serv_destroy_chip(void *p)
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
@@ -151,11 +525,30 @@ static struct nbl_service_ops serv_ops = {
 	.init_chip = nbl_serv_init_chip,
 	.destroy_chip = nbl_serv_destroy_chip,
 
+	.configure_msix_map = nbl_serv_configure_msix_map,
+	.destroy_msix_map = nbl_serv_destroy_msix_map,
+	.enable_mailbox_irq = nbl_serv_enable_mailbox_irq,
+
+	.get_msix_entry_id = nbl_serv_get_msix_entry_id,
+
 	.register_net = nbl_serv_register_net,
 	.unregister_net = nbl_serv_unregister_net,
-
+	.setup_txrx_queues = nbl_serv_setup_txrx_queues,
+	.remove_txrx_queues = nbl_serv_remove_txrx_queues,
+
+	.setup_q2vsi = nbl_serv_setup_q2vsi,
+	.remove_q2vsi = nbl_serv_remove_q2vsi,
+	.setup_rss = nbl_serv_setup_rss,
+	.remove_rss = nbl_serv_remove_rss,
+	.setup_rss_indir = nbl_serv_setup_rss_indir,
 	.register_vsi_info = nbl_serv_register_vsi_info,
 
+	.alloc_rings = nbl_serv_alloc_rings,
+	.free_rings = nbl_serv_free_rings,
+	.enable_napis = nbl_serv_enable_napis,
+	.disable_napis = nbl_serv_disable_napis,
+	.set_mask_en = nbl_serv_set_mask_en,
+
 	.set_netdev_ops = nbl_serv_set_netdev_ops,
 	.get_vsi_id = nbl_serv_get_vsi_id,
 	.get_eth_id = nbl_serv_get_eth_id,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 624e8a75a1ff..354951ff366f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -314,7 +314,39 @@ static struct pci_driver nbl_driver = {
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
+	pr_info("nbl module loaded\n");
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
+
+	nbl_common_destroy_wq();
+
+	pr_info("nbl module unloaded\n");
+}
 
+module_init(nbl_module_init);
+module_exit(nbl_module_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Nebula Matrix Network Driver");
-- 
2.47.3


