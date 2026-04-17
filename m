Return-Path: <netdev+bounces-279423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CioLIik4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E541EAAF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 092A530562A9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DE836B055;
	Fri, 17 Apr 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlceqnGc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EF36BCCA
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460883; cv=none; b=J+6/Ij34ax2/dpS4Y3d8ary9fmyisAiFkC9eFH0XopCo2LTGUIvhG03FNnW/KtSM2NPNg5PmXASYHDa4jLHqaqeQgwqLbM5Z/69uPvd4rLBmJv4VvOGNg0BKu8O4fUuvwWO9qpCwkHpNC0HbavsGYnqBAuW69/rAWkN3USPnw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460883; c=relaxed/simple;
	bh=mO7/1hdAD2f0GpmlzYXIPqNi2BdJxVjMEVEeBRLIVBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRcS3hWpoVYZboP86fwK2UoDaqED21CBsbif9k+W3c6BNByPrKuz+TTxy/a0IDNdbiGimLE6ja34qyVFh6LzznvmlFI8C4V5KVs+c0GfcDe7jraJC+YWEh2sU5rHi3Eh4jeR6t8CbQB3th3PqATtmEACwqtH2ZyvQ4NH979k7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlceqnGc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460880; x=1807996880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mO7/1hdAD2f0GpmlzYXIPqNi2BdJxVjMEVEeBRLIVBk=;
  b=KlceqnGc0aV1oJAi6DiirlcwC2yjrCaGDqtsT/Z23TPsNH57VXA3ZXv5
   niz6kPr1PSIFF91K6alNwJEcRLnbmSu5Qzv4+7++v7M5VLhVOB/e4b96i
   IpO5BO5KtkIhvfwezJ1Ux8Ewx+UhcqqPXjsbj7ToUG3TFQcqBvRa/zILW
   X8RTLGbyXZ5JxPOAC3xbJRjvKNT6szSJAQ+0wFHuFaK505ZmIe7xsvPI9
   C+ZQ1EJUXxng/BiQSx+jkDU4/nJdN8HokcEB6bKTpO2bd08ERk2s+DMpb
   2gk5Y/EW2UvsOfQUFQo8n9C2MfP0g2K58il8IZ045f3I23VSQtklTdFdw
   A==;
X-CSE-ConnectionGUID: WzYwunkIQzGnRURskGEDlA==
X-CSE-MsgGUID: xIQ+vTD0R8CSLBfOFABWHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046095"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046095"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:21:15 -0700
X-CSE-ConnectionGUID: F86X92tST4yE982ofkJynw==
X-CSE-MsgGUID: 5oSyq91ATp2s7MHO+B/8KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503788"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:09 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	maarten@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 02/11] drm/ras: Introduce get-error-threshold
Date: Sat, 18 Apr 2026 02:46:37 +0530
Message-ID: <20260417211730.837345-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279423-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 5B0E541EAAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add get-error-threshold command support which allows querying threshold
value of the error. Threshold in RAS context means the number of errors
the hardware is expected to accumulate before it raises them to software.
This is to have a fine grained control over error notifications that are
raised by the hardware.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 Documentation/gpu/drm-ras.rst            |   8 ++
 Documentation/netlink/specs/drm_ras.yaml |  37 ++++++++
 drivers/gpu/drm/drm_ras.c                | 103 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  13 +++
 drivers/gpu/drm/drm_ras_nl.h             |   2 +
 include/drm/drm_ras.h                    |  14 +++
 include/uapi/drm/drm_ras.h               |  11 +++
 7 files changed, 188 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 70b246a78fc8..6443dfd1677f 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -52,6 +52,8 @@ User space tools can:
   as a parameter.
 * Query specific error counter values with the ``get-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Query specific error threshold value with the ``get-error-threshold`` command, using both
+  ``node-id`` and ``error-id`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -101,3 +103,9 @@ Example: Query an error counter for a given node
     sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
     {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
 
+Example: Query threshold value of a given error
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
+    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 0}
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 79af25dac3c5..95a939fb987d 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,25 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+  -
+    name: error-threshold-attrs
+    attributes:
+      -
+        name: node-id
+        type: u32
+        doc: Node ID targeted by this operation.
+      -
+        name: error-id
+        type: u32
+        doc: Unique identifier for a specific error within the node.
+      -
+        name: error-name
+        type: string
+        doc: Name of the error.
+      -
+        name: error-threshold
+        type: u32
+        doc: Threshold value of the error.
 
 operations:
   list:
@@ -113,3 +132,21 @@ operations:
             - node-id
         reply:
           attributes: *errorinfo
+    -
+      name: get-error-threshold
+      doc: >-
+           Retrieve threshold value of the error.
+           The response includes the id, the name, and current threshold
+           value of the error.
+      attribute-set: error-threshold-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+            - error-id
+        reply:
+          attributes:
+            - error-id
+            - error-name
+            - error-threshold
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 1f7435d60f11..d2d853d5d69c 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -37,6 +37,10 @@
  *    Returns all counters of a node if only Node ID is provided or specific
  *    error counters.
  *
+ * 3. GET_ERROR_THRESHOLD: Query threshold value of the error.
+ *    Userspace must provide Node ID and Error ID.
+ *    Returns the threshold value of a specific error.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -66,6 +70,8 @@
  *   operation, fetching all counters from a specific node.
  * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
  *   operation, fetching a counter value from a specific node.
+ * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
+ *   operation, fetching the threshold value of a specific error.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -162,6 +168,22 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
+static int get_node_error_threshold(u32 node_id, u32 error_id,
+				    const char **name, u32 *value)
+{
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->query_error_threshold)
+		return -ENOENT;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->query_error_threshold(node, error_id, name, value);
+}
+
 static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 				   const char *error_name, u32 value)
 {
@@ -180,6 +202,24 @@ static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_reply_threshold_value(struct sk_buff *msg, u32 error_id,
+				     const char *error_name, u32 value)
+{
+	int ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
+			     error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
+			   value);
+}
+
 static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
 				    u32 error_id)
 {
@@ -216,6 +256,42 @@ static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+static int doit_reply_threshold_value(struct genl_info *info, u32 node_id,
+				      u32 error_id)
+{
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	const char *error_name;
+	u32 value;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	ret = get_node_error_threshold(node_id, error_id,
+				       &error_name, &value);
+	if (ret)
+		return ret;
+
+	ret = msg_reply_threshold_value(msg, error_id, error_name, value);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
@@ -314,6 +390,33 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	return doit_reply_counter_value(info, node_id, error_id);
 }
 
+/**
+ * drm_ras_nl_get_error_threshold_doit() - Query threshold value of the error
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the node ID and error ID from the netlink attributes and
+ * retrieves the current threshold of the corresponding error. Sends the
+ * result back to the requesting user via the standard Genl reply.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	u32 node_id, error_id;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID]);
+
+	return doit_reply_threshold_value(info, node_id, error_id);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 16803d0c4a44..48e231734f4d 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID + 1] = {
+	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
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
+		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
+		.doit		= drm_ras_nl_get_error_threshold_doit,
+		.policy		= drm_ras_get_error_threshold_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 06ccd9342773..540fe22e2312 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 				      struct genl_info *info);
 int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 5d50209e51db..50cee70bd065 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -57,6 +57,20 @@ struct drm_ras_node {
 	 */
 	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
 				   const char **name, u32 *val);
+	/**
+	 * @query_error_threshold:
+	 *
+	 * This callback is used by drm-ras to query threshold value of a
+	 * specific error.
+	 *
+	 * Driver should expect query_error_threshold() to be called with
+	 * error_id from `error_counter_range.first` to
+	 * `error_counter_range.last`.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
+				     const char **name, u32 *val);
 
 	/** @priv: Driver private data */
 	void *priv;
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 5f40fa5b869d..49c5ca497d73 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -38,9 +38,20 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID = 1,
+	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
+	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
+	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
+
+	__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX,
+	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX = (__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
+	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0


