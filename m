Return-Path: <netdev+bounces-73495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E54785CD0A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 01:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013D728698D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C21FBF;
	Wed, 21 Feb 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adAJAwgj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A83C2F
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476650; cv=none; b=qQtUM+kY+9N25PN96tyRoZvp8cFXCXtf+tXlptD9hsG1mefZKuogIQeEzmo9QWPasV+KVYp1lS4+71Pd9Lr0tpGplvQFrO/W4ri0orBjpQH3nwRFBhiv6B6Qda0QKs/f9sHClvIMbPPMX+uic407/P86HJikfAw8uiPCG0uZHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476650; c=relaxed/simple;
	bh=AcjckNDpXZ2CrE6JuYN8FCLzPvU85vFH345Qss+kUF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw69v9H2oyqHXQPUHQ5Y+BDz1jJXQB2LzsBIoFrbonfgO1oUJzc/qW7xiPebPWk2EegBZfFZO3EnnbAt6Lb3dzTtGLxxU+bQrjFTvhCLT44Vi6VZVt6se0/UjiQ1hqiOpTYgaokxSmVWZe3fv2s0M5RVZov7fRgxcgdKJpfgmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adAJAwgj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708476649; x=1740012649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AcjckNDpXZ2CrE6JuYN8FCLzPvU85vFH345Qss+kUF4=;
  b=adAJAwgj+O0fevUON/7ijrxsHVfQekcnMMG92PdpYF/+NQffDKs7wc6y
   bXQIDxG7HujEaf5QNFoV0AmyqL5abRRu0shs8+eVp0Tsw7ez5gmdfh0/u
   fdy5xBf0TkEZfOCCF8DXn2cYW2kFCV4/7bZ34JScRYNditJKOGpBmD/EM
   ktPHmlSxY1xgGEAL38Jiufv3stRndhcDKvN9k7O/n1pMY8e2e0Rmphj9y
   Oawj2GS83DkKKowTW8wFM/f80Rs4Z0TKPFybRnWDpc0JvbnbyKejEqoow
   8iGG22FV0A6ucAGmlVMpDQjaxz4k6GWHkJWN569p7w3uQEOUFShAHIgu0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2500779"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2500779"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 16:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9550962"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2024 16:50:49 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v5 05/10 iwl-next] idpf: add async_handler for MAC filter messages
Date: Tue, 20 Feb 2024 16:49:44 -0800
Message-ID: <20240221004949.2561972-6-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221004949.2561972-1-alan.brady@intel.com>
References: <20240221004949.2561972-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where the driver needs to add a MAC filter but
we're explicitly not allowed to sleep so we can wait for a virtchnl
message to complete.

This adds an async_handler for asynchronously sent messages for MAC
filters so that we can better handle if there's an error of some kind.
If success we don't need to do anything else, but if we failed to
program the new filter we really should remove it from our list of MAC
filters. If we don't remove bad filters, what I expect to happen is
after a reset of some kind we try to program the MAC filter again and it
fails again. This is clearly wrong and I would expect to be confusing
for the user.

It could also be the failure is for a delete MAC filter message but
those filters get deleted regardless. Not much we can do about a delete
failure.

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index ca0fd7144e75..fa12b08e7965 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3551,6 +3551,75 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
 	return le32_to_cpu(vport_msg->vport_id);
 }
 
+/**
+ * idpf_mac_filter_async_handler - Async callback for mac filters
+ * @adapter: private data struct
+ * @xn: transaction for message
+ * @ctlq_msg: received message
+ *
+ * In some scenarios driver can't sleep and wait for a reply (e.g.: stack is
+ * holding rtnl_lock) when adding a new mac filter. It puts us in a difficult
+ * situation to deal with errors returned on the reply. The best we can
+ * ultimately do is remove it from our list of mac filters and report the
+ * error.
+ */
+static int idpf_mac_filter_async_handler(struct idpf_adapter *adapter,
+					 struct idpf_vc_xn *xn,
+					 const struct idpf_ctlq_msg *ctlq_msg)
+{
+	struct virtchnl2_mac_addr_list *ma_list;
+	struct idpf_vport_config *vport_config;
+	struct virtchnl2_mac_addr *mac_addr;
+	struct idpf_mac_filter *f, *tmp;
+	struct list_head *ma_list_head;
+	struct idpf_vport *vport;
+	u16 num_entries;
+	int i;
+
+	/* if success we're done, we're only here if something bad happened */
+	if (!ctlq_msg->cookie.mbx.chnl_retval)
+		return 0;
+
+	/* make sure at least struct is there */
+	if (xn->reply_sz < sizeof(*ma_list))
+		goto invalid_payload;
+
+	ma_list = ctlq_msg->ctx.indirect.payload->va;
+	mac_addr = ma_list->mac_addr_list;
+	num_entries = le16_to_cpu(ma_list->num_mac_addr);
+	/* we should have received a buffer at least this big */
+	if (xn->reply_sz < struct_size(ma_list, mac_addr_list, num_entries))
+		goto invalid_payload;
+
+	vport = idpf_vid_to_vport(adapter, le32_to_cpu(ma_list->vport_id));
+	if (!vport)
+		goto invalid_payload;
+
+	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
+	ma_list_head = &vport_config->user_config.mac_filter_list;
+
+	/* We can't do much to reconcile bad filters at this point, however we
+	 * should at least remove them from our list one way or the other so we
+	 * have some idea what good filters we have.
+	 */
+	spin_lock_bh(&vport_config->mac_filter_list_lock);
+	list_for_each_entry_safe(f, tmp, ma_list_head, list)
+		for (i = 0; i < num_entries; i++)
+			if (ether_addr_equal(mac_addr[i].addr, f->macaddr))
+				list_del(&f->list);
+	spin_unlock_bh(&vport_config->mac_filter_list_lock);
+	dev_err_ratelimited(&adapter->pdev->dev, "Received error sending MAC filter request (op %d)\n",
+			    xn->vc_op);
+
+	return 0;
+
+invalid_payload:
+	dev_err_ratelimited(&adapter->pdev->dev, "Received invalid MAC filter payload (op %d) (len %zd)\n",
+			    xn->vc_op, xn->reply_sz);
+
+	return -EINVAL;
+}
+
 /**
  * idpf_add_del_mac_filters - Add/del mac filters
  * @vport: Virtual port data structure
@@ -3578,6 +3647,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 				VIRTCHNL2_OP_DEL_MAC_ADDR;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.async = async;
+	xn_params.async_handler = idpf_mac_filter_async_handler;
 
 	vport_config = adapter->vport_config[np->vport_idx];
 	spin_lock_bh(&vport_config->mac_filter_list_lock);
-- 
2.43.0


