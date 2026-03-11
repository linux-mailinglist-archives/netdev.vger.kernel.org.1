Return-Path: <netdev+bounces-266590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAX3FNZEsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A82623FE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810823004F5C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A33B7B92;
	Wed, 11 Mar 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzsGLWZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02E3B634E
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223113; cv=none; b=OCPn32LuHpjm+vRPUK3BVlwu3J7e1cU/F1cGe3UBA/0nOOQq6OfQtm0IuN28E7Liu6KkmMZXEqcBqIcBIYWrrHMFCqfuOw0AGRRaYZvl4x/Km3KOq+hXhBan42H4IjRAz5RCLf8Vatw2JHYy+h+uB2J6HcGseXNtwTg1UgrdN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223113; c=relaxed/simple;
	bh=l0/q/4FoyWlUhCmTVIlN+9vCrj6MIJrCZmnj5E4h5WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJemS5ftW+6IhoZ6M7/NxKtViQFsdG7PKyN51uoKhOm8eAIPvkM0djRgCijUHto4d5H9dx8mb/b7b2Mm1Dr2NjjdB+ewjx0+lhEaZXoDe5J+xmo9DwTncRlv6araXPhi3N0oXW76i+AHI4rCyNFsPSJ1ALy8aP1TizSLzIeHn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzsGLWZN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773223112; x=1804759112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0/q/4FoyWlUhCmTVIlN+9vCrj6MIJrCZmnj5E4h5WE=;
  b=CzsGLWZNO3fRwZHCRp4I6Nnuni7GIGsraZ3huF+4157YMIJzWCvULC9E
   PVu5Ei9j63NwKSWxDPbn9q0/x+W3KWlfccteZvb19a1bGsJ/iM8MKoGp0
   ei9Grj2stX4zSWNaVqW8z81tyZcTNKxEr6i3Tlfv3gfvW4QRMv9zXmyCb
   dz1nyHwXS6PFMuferJVYPbc4LGkWJQ1EmslFyitzdl8peOFrN924OFiwH
   IQNb99D5INxe097yt61CWqvTo1EjRblFfuh/Cj4xHOlqe2Q5hCqnD6wcb
   /4eXXvTWMawGkmqYGz7FeFMhl7VN64WFhPK0JLTe9lqD8z1oYLvF3LrjU
   w==;
X-CSE-ConnectionGUID: VdFopYdRRISf1th3f7u6NA==
X-CSE-MsgGUID: ciAc544cR5KpZbucAERbxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74326023"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74326023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:22 -0700
X-CSE-ConnectionGUID: 9tZWZ/cmT9ya+B0MXScSGA==
X-CSE-MsgGUID: GaSE/pXcTRmmkecHxRVncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217095822"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:15 -0700
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
Subject: [PATCH 1/4] drm/drm_ras: Add clear-error-counter netlink command to drm_ras
Date: Wed, 11 Mar 2026 15:59:15 +0530
Message-ID: <20260311102913.3387468-7-riana.tauro@intel.com>
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
X-Rspamd-Queue-Id: 921A82623FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266590-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,intel.com:dkim,intel.com:email,intel.com:mid,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

Introduce a new 'clear-error-counter' DRM RAS command to reset the counter
value for a specific error counter of a given node.

The command is a 'do' netlink request with 'node-id' and 'error-id'
as parameters with no additional response payload.

Usage

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":1}'
None

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 Documentation/gpu/drm-ras.rst            |  8 +++++
 Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
 drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 ++
 include/drm/drm_ras.h                    | 11 ++++++
 include/uapi/drm/drm_ras.h               |  1 +
 7 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 70b246a78fc8..4636e68f5678 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -52,6 +52,8 @@ User space tools can:
   as a parameter.
 * Query specific error counter values with the ``get-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Clear specific error counters with the ``clear-error-counter`` command, using both
+  ``node-id`` and ``error-id`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -101,3 +103,9 @@ Example: Query an error counter for a given node
     sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
     {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
 
+Example: Clear an error counter for a given node
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
+    None
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 79af25dac3c5..e113056f8c01 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -99,7 +99,7 @@ operations:
       flags: [admin-perm]
       do:
         request:
-          attributes:
+          attributes: &id-attrs
             - node-id
             - error-id
         reply:
@@ -113,3 +113,14 @@ operations:
             - node-id
         reply:
           attributes: *errorinfo
+    -
+      name: clear-error-counter
+      doc: >-
+           Clear error counter for a given node.
+           The request includes the error-id and node-id of the
+           counter to be cleared.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes: *id-attrs
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b2fa5ab86d87..d6eab29a1394 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -26,7 +26,7 @@
  * efficient lookup by ID. Nodes can be registered or unregistered
  * dynamically at runtime.
  *
- * A Generic Netlink family `drm_ras` exposes two main operations to
+ * A Generic Netlink family `drm_ras` exposes the below operations to
  * userspace:
  *
  * 1. LIST_NODES: Dump all currently registered RAS nodes.
@@ -37,6 +37,10 @@
  *    Returns all counters of a node if only Node ID is provided or specific
  *    error counters.
  *
+ * 3. CLEAR_ERROR_COUNTER: Clear error counter of a given node.
+ *    Userspace must provide Node ID, Error ID.
+ *    Clears specific error counter of a node if supported.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -66,6 +70,8 @@
  *   operation, fetching all counters from a specific node.
  * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
  *   operation, fetching a counter value from a specific node.
+ * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
+ *   operation, clearing a counter value from a specific node.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -314,6 +320,41 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	return doit_reply_value(info, node_id, error_id);
 }
 
+/**
+ * drm_ras_nl_clear_error_counter_doit() - Clear an error counter of a node
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the node ID and error ID from the netlink attributes and
+ * clears the current value.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	struct drm_ras_node *node;
+	u32 node_id, error_id;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->clear_error_counter)
+		return -ENOENT;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->clear_error_counter(node, error_id);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 16803d0c4a44..dea1c1b2494e 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_CLEAR_ERROR_COUNTER - do */
+static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+		.doit		= drm_ras_nl_clear_error_counter_doit,
+		.policy		= drm_ras_clear_error_counter_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 06ccd9342773..a398643572a5 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 				      struct genl_info *info);
 int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
+int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 5d50209e51db..f2a787bc4f64 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -58,6 +58,17 @@ struct drm_ras_node {
 	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
 				   const char **name, u32 *val);
 
+	/**
+	 * @clear_error_counter:
+	 *
+	 * This callback is used by drm_ras to clear a specific error counter.
+	 * Driver should implement this callback to support clearing error counters
+	 * of a node.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 5f40fa5b869d..218a3ee86805 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -41,6 +41,7 @@ enum {
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
+	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.47.1


