Return-Path: <netdev+bounces-266592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO9pEH09sWmAswIAu9opvQ
	(envelope-from <netdev+bounces-266592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1570261A11
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DB0B30B69E3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35C3BAD9E;
	Wed, 11 Mar 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgBvaN8L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4C3BA240
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223119; cv=none; b=EQireV1BAlDQ5S5QZfrUWB+7/OmJ8pBCmOwDaOgOhUBLzFfy2n9Btzn01o2hbUyTkvj07z7xiE1BRXk2CL9qxZSslJCLfrndaLOtjM+zb8dsPPteLtrSCuuipsMnBwfc+p9u/zVZxRi8qadRLBqYi8zmbpBiX4CiySJ+wqTFk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223119; c=relaxed/simple;
	bh=xmfQQSexzlItJbadxzX3S+VXv/F9hU4ivxKn31l7mzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuxOE+bHDALJUpvR2OHvXgNstI+Nc4jIHmTQeV547cKLBSquJTlqnEr5KETRkyVMtP503Fu/dvUFt0Owdj63x5FHTXbUl01eN6YTUesCLFuxWZ7B9np5ljQEtIntszHni1/vps+0sXUhKXSiJaCWbGXZEtAlBKK0aMajIiA3QtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgBvaN8L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773223117; x=1804759117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmfQQSexzlItJbadxzX3S+VXv/F9hU4ivxKn31l7mzY=;
  b=FgBvaN8LFFGsMOU+ndYrxqlUuWUHAO3UJsJ3tzuamCw7tulnMw8QOhjx
   TaaD4WyUm+Y0Ge3JgIx3P9Ft25uRTxoEb56+nx4pRalXdFqwhbqYa+NKN
   +CBRFTSOasnxdfQPe6qAaxM5U73KCHjPEE4Wp3KoJCUxUkRb+wy4/Trab
   x+XozNFVnC7LsSMp5vgfqKJ6Q7lIa8lstQ3D5RAK5x2g14oeqHfIVzmfV
   fJVQ/ShQxRs5gpcmdthDt/Hp2LjpCBm3g1LT6gYWhpiBm0e2++G1prqvL
   ohX5sOv9GvZx1hqLxFMgh/QrD1mjI78ozAvaMMt1miS+DYSApUR6QC/Tt
   w==;
X-CSE-ConnectionGUID: PzTsBoqNT6SgAaJTynwUgw==
X-CSE-MsgGUID: NstzalbiQoWuPfJZpED27A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74326063"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74326063"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:36 -0700
X-CSE-ConnectionGUID: qprlaoAvRAG/K0jTR1a7EA==
X-CSE-MsgGUID: Qx8StSelQVWFZ5pltWj46g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217095859"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:30 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	anvesh.bakwad@intel.com,
	maarten.lankhorst@linux.intel.com,
	Riana Tauro <riana.tauro@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event notification
Date: Wed, 11 Mar 2026 15:59:17 +0530
Message-ID: <20260311102913.3387468-9-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260311102913.3387468-6-riana.tauro@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1570261A11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266592-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,davemloft.net:email,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

Add support for asynchronous error notifications in drm_ras.

Define a new `error-event` netlink event and a new multicast
group `error-notify` in drm_ras spec. Each event contains
a node-id and error-id to identify the type and source
of error.

Add drm_ras_error_notify() to trigger this event from drivers.
Userspace can receive this event by subscribing to the
multicast group error-notify.

Example: Using ynl tool

$ sudo ynl --family drm_ras --subscribe error-notify

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 Documentation/gpu/drm-ras.rst            |  9 +++++
 Documentation/netlink/specs/drm_ras.yaml | 14 +++++++
 drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 +++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 include/drm/drm_ras.h                    |  2 +
 include/uapi/drm/drm_ras.h               |  3 ++
 7 files changed, 86 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 4636e68f5678..09b2918f67bd 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -54,6 +54,8 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Listen to ``error-event`` notifications for error events by subscribing to the
+  ``error-notify`` multicast group.
 
 YAML-based Interface
 --------------------
@@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Listen to error events
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --subscribe error-notify
+    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..4dc047be59e9 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -124,3 +124,17 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: error-event
+      doc: >-
+           Notify userspace of an error event.
+           The event includes the error-id and node-id of the error
+           that triggered the event.
+      attribute-set: error-counter-attrs
+      event:
+        attributes: *id-attrs
+
+mcast-groups:
+  list:
+    -
+      name: error-notify
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..36a3a79cbbea 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,10 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. ERROR_EVENT: Notify userspace of an error event.
+ *    The event includes the error-id and node-id of the error
+ *    that triggered the event.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -355,6 +359,50 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	return node->clear_error_counter(node, error_id);
 }
 
+/**
+ * drm_ras_error_notify() - Notify userspace of an error event
+ * @node: Node structure
+ * @error_id: ID of the error counter that triggered the event
+ * @flags: GFP flags for memory allocation
+ *
+ * Notifies userspace of an error event related to a specific RAS node and error counter.
+ */
+void drm_ras_error_notify(struct drm_ras_node *node, u32 error_id, gfp_t flags)
+{
+	struct genl_info info;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
+	if (!msg)
+		return;
+
+	hdr = genlmsg_iput(msg, &info);
+	if (!hdr)
+		goto err_free;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID, node->id);
+	if (ret)
+		goto err_cancel;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		goto err_cancel;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_NOTIFY, flags);
+	return;
+
+err_cancel:
+	genlmsg_cancel(msg, hdr);
+err_free:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(drm_ras_error_notify);
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..ac724bb87a3b 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
+	[DRM_RAS_NLGRP_ERROR_NOTIFY] = { "error-notify", },
+};
+
 struct genl_family drm_ras_nl_family __ro_after_init = {
 	.name		= DRM_RAS_FAMILY_NAME,
 	.version	= DRM_RAS_FAMILY_VERSION,
@@ -66,4 +70,6 @@ struct genl_family drm_ras_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= drm_ras_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(drm_ras_nl_ops),
+	.mcgrps		= drm_ras_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(drm_ras_nl_mcgrps),
 };
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index a398643572a5..17e1af8cc3b3 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 
+enum {
+	DRM_RAS_NLGRP_ERROR_NOTIFY,
+};
+
 extern struct genl_family drm_ras_nl_family;
 
 #endif /* _LINUX_DRM_RAS_GEN_H */
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..a2d4f257c9c2 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -78,9 +78,11 @@ struct drm_device;
 #if IS_ENABLED(CONFIG_DRM_RAS)
 int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
+void drm_ras_error_notify(struct drm_ras_node *node, u32 error_id, gfp_t flags);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
+static inline void drm_ras_error_notify(struct drm_ras_node *node, u32 error_id, gfp_t flags) { }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..47fafeff93e7 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -42,9 +42,12 @@ enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_ERROR_EVENT,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
 };
 
+#define DRM_RAS_MCGRP_ERROR_NOTIFY	"error-notify"
+
 #endif /* _UAPI_LINUX_DRM_RAS_H */
-- 
2.47.1


