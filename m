Return-Path: <netdev+bounces-66103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A883D40E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 06:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B2128A13E
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 05:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D935BE76;
	Fri, 26 Jan 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7fNqLMb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F7BE58
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248128; cv=none; b=Ew1XLAXfiEuav/RKEbWXQVilOEkngp/oKITSBB/68ObI96FofOTTDiwTzFyHdlEjARLCD3b2KpOGphTw2GwTeFnHdd5ghI2shctysHbT6aPL32lsvKwvt7q5dVmccTHoCTeRl9VBE8DvGZ+syryuwm9RElb8XT5rWpoixsZAWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248128; c=relaxed/simple;
	bh=CcY02uZgyyQhK3z83/NLifX9J8vjI5S2QatR+AA0DzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foa5zz6h16kPwS2exM2/peKfnZBSBVaNFzuPL6p6ZAl7GKf+JD30XrFbMYPb4mVexKiCLhPPb+WN+nYwDLjdku9KwSy3+ZpT3Bnnjo9gT3VWu8xRxA8O83ZN6tuwxBpRhPA1WOzesbR9X8cG3M2fOwnpKHY5Nc5aZg//NuOIWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7fNqLMb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706248126; x=1737784126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CcY02uZgyyQhK3z83/NLifX9J8vjI5S2QatR+AA0DzU=;
  b=i7fNqLMba9at5rX7zyQnBxKCC7L6McddIMy3aZTt2pedtykuoxDRus8a
   pKglPDPm38ICXYvfXe7N0cDTZWpQiHiVALu0NE3g2Pk/zLd5A+ySFscmt
   p8qEMlbycrTYKVAu58CrHbqwgCUF502GNe4JbjYYD+2oMD/npzdOaKcp7
   kzxS2Ie0WXP//X2BUnkGaG+rCnkRcLNsTC0tsesgHZFUn5xoksQp3/4ru
   6Ca1u8WV1XHC8GQPhj/RO+j1Kex8maK3V15LxowMjcMgCYYe4agquiRzl
   B4Dl8CGjiZMCNn+WL+8Mzqa/nFweXnmeeADZIxMSwoj25AQNqPrhdJ1GK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9779294"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9779294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21306203"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmviesa002.fm.intel.com with ESMTP; 25 Jan 2024 21:48:45 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	igor.bagnucki@intel.com,
	willemdebruijn.kernel@gmail.com,
	Alan Brady <alan.brady@intel.com>
Subject: [PATCH v2 5/7 iwl-next] idpf: add async_handler for MAC filter messages
Date: Thu, 25 Jan 2024 21:47:45 -0800
Message-Id: <20240126054747.960172-6-alan.brady@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126054747.960172-1-alan.brady@intel.com>
References: <20240126054747.960172-1-alan.brady@intel.com>
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

This adds an async_handler for asynchronously sent virtchnl messages for
MAC filters so that we can better handle if there's an error of some
kind. If success we don't need to do anything else, but if we failed to
program the new filter we really should remove it from our list of MAC
filters. If we don't remove bad filters, what I expect to happen is
after a reset of some kind we try to program the MAC filter again and it
fails again. This is clearly wrong and I would expect to be confusing
for the user.

It could also be the failure is for a delete MAC filter message but
those filters get deleted regardless. Not much we can do about a delete
failure.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index e992e4cf09e7..707fdbca2a87 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3645,6 +3645,75 @@ u32 idpf_get_vport_id(struct idpf_vport *vport)
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
+	dev_err_ratelimited(&adapter->pdev->dev, "Received error sending mac filter request (op %d)\n",
+			    xn->vc_op);
+
+	return 0;
+
+invalid_payload:
+	dev_err_ratelimited(&adapter->pdev->dev, "Received invalid mac filter payload (op %d) (len %ld)\n",
+			    xn->vc_op, xn->reply_sz);
+
+	return -EINVAL;
+}
+
 /**
  * idpf_add_del_mac_filters - Add/del mac filters
  * @vport: Virtual port data structure
@@ -3672,6 +3741,7 @@ int idpf_add_del_mac_filters(struct idpf_vport *vport,
 				VIRTCHNL2_OP_DEL_MAC_ADDR;
 	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 	xn_params.async = async;
+	xn_params.async_handler = idpf_mac_filter_async_handler;
 
 	vport_config = adapter->vport_config[np->vport_idx];
 	spin_lock_bh(&vport_config->mac_filter_list_lock);
-- 
2.40.1


