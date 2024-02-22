Return-Path: <netdev+bounces-74127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA12686028B
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7DB27354
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF3554919;
	Thu, 22 Feb 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ckdd4R7q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB5548EF
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628704; cv=none; b=UQpqUMt2xd37hnwD5BusME6hw6PnwkmhVnXVAIyf/FNI3JDfU/OVMKQBR7QfvXFKMLmBB1pNCBhAy2cod9LNG797M75UUokW3qvD2kJGraDTRqPZ2zHxUEiB7QQSw8QZJ99E22vmCPMhKJKV8Vj/ndLd9wQYz1lY0EkkyCwofAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628704; c=relaxed/simple;
	bh=55D8tO+nCVyoxrApYhqRzfI6osHgV78tfReAk5VS/LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSbxjA7qAi3RBJjyu4VhseA8wD0X9AIEo3PVg5CscDGxQsgVrWUved5AkrMGVqX4fO3tIvpRSa9dIFJy0GGdMbyE7GWYu1wK5wsWFA5JnVqYT/7MGfb+UZ8dkGpEM5Nz30wtEDKCm+YsJlOelr6WtC+ClbSWrrQ9pgZyeNLgBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ckdd4R7q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708628703; x=1740164703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=55D8tO+nCVyoxrApYhqRzfI6osHgV78tfReAk5VS/LM=;
  b=Ckdd4R7qNDBvIWVcqEyI8+MjzhlmDX1rXd1mzQcxx95wdIg5B33zw7ld
   8IMB/jyQEg3QFUXHLE7vyIUKDwSROX3dOp3HkcNFNCcJ3C0DDBGxa05UA
   th14dYoTUErtbsKvnF9zQ/nUtUmegAHsBxRxK05FeMUNl8UmtmLkTLL9w
   7TYFyFkImMvKjjdSURpYTZo8VEbGmBh+ur9MXkvJKed8iqm42AoEYEsEd
   nV0ZqPvuJOJYxhltRSEqYsMo+uakU8Iz6t5SJqHmfS7pl2ctpa3Ao7o8a
   en4VZR9smYxJGd68anDpdY68cKfzDA+qvaoI7TVL6ZYBaMWws2KBbma8P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13506383"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13506383"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 11:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10171294"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 11:05:02 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Alan Brady <alan.brady@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v6 06/11 iwl-next] idpf: add async_handler for MAC filter messages
Date: Thu, 22 Feb 2024 11:04:36 -0800
Message-ID: <20240222190441.2610930-7-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222190441.2610930-1-alan.brady@intel.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
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
index 0f14860efa28..d1107507a98c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3656,6 +3656,75 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
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
@@ -3683,6 +3752,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 				VIRTCHNL2_OP_DEL_MAC_ADDR;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.async = async;
+	xn_params.async_handler = idpf_mac_filter_async_handler;
 
 	vport_config = adapter->vport_config[np->vport_idx];
 	spin_lock_bh(&vport_config->mac_filter_list_lock);
-- 
2.43.0


