Return-Path: <netdev+bounces-303558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0W4aM5HhRGo82goAu9opvQ
	(envelope-from <netdev+bounces-303558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:44:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C33236EBB4D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=VyZddI8U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303558-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFA43300C3AB
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08F73F7878;
	Wed,  1 Jul 2026 09:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C233B19BA
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:44:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899083; cv=none; b=h0RnGzIPRDRKjbV476g8n2HMdj2vP2J7ufDb1hprGBeisruxOG8XDVcrHSDDPMkFS1l0gSRmHRn2x40kTywGTkQgTC5gPzFeV1B21LcU7q0CsDNNzLrUj/zh2XKSht7k4bYbz43KCMi7K/Ls4uWHvDUbe6V/xGivLBpQQeCCSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899083; c=relaxed/simple;
	bh=Jo39ehljGadUGz4tu3h6C48QU/o6HhxzR60meOSjD9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3O43Z1HQetJ7zzWYV+sTpBwSjEYN+3nMnuuLaKcKehrAMvELkKHVPrXwZ7khc5w+nI4Kl8+KEqPmCrTjp7+x4GYQ8d2zpa5QceDgs2zJN4DXFpYfFT0EK+qTuYYBHvg1nlHvX/5LrmMS2cd0DNbYmodKgwF/hBjTMcf+P0erh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyZddI8U; arc=none smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782899081; x=1814435081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jo39ehljGadUGz4tu3h6C48QU/o6HhxzR60meOSjD9g=;
  b=VyZddI8UzmoE3tJT+7/vDpJa4/zx5XproS/0PHoWGuatgjXJAdySjz7l
   in2AMQqLDP/DYf6O5GRew0auo9tBfl+qZ70S7mUELX28bdppMcY0fjwj+
   epczRPkvehWX8tEYvIVdYq4h1RuQ06gN+hGKm48GO527pG9aUl7iXKHbM
   EoQDiQal9JDrmc+l0lNH+LuDwA+ygkOOT+K2Wpf+HO0KgU7FQsAGn8PBV
   Kt6+qdZ1lro7BLLQOCUqYmC5E6aHcHC18GbQT7AYWDDDwnMLXlsaexyN7
   5GU8MXgjhuNHJQOYFcdytwAnzWh6qtMvPFVx8ebg4oLVG8CaMGMPkLhY6
   w==;
X-CSE-ConnectionGUID: CZFBbpeLRouGRDgfRuUpHg==
X-CSE-MsgGUID: QFI3ewfuTn6WZ9D6sPv/zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94781491"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="94781491"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:41 -0700
X-CSE-ConnectionGUID: 2CjU04MHSdulK+oAQx+W8w==
X-CSE-MsgGUID: fpv5hk00Qd2yLXjAAeegrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="248541435"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:44:32 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v4 1/3] drm/drm_ras: Add drm_ras netlink error event
Date: Wed,  1 Jul 2026 15:14:11 +0530
Message-ID: <20260701094409.129131-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260701094409.129131-5-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303558-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,m:zachary.mckevitt@oss.qualcomm.com,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,davemloft.net:email,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C33236EBB4D

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Userspace must subscribe to 'error-report' to receive 'error-event'
notifications.

Usage:

$ sudo ynl --family drm_ras --subscribe error-report

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: remove redundant initialization
    remove unnecessary space
    use ynl in commit message and doc (Raag)
    simplify doc for error-event attrs

v3: rename error-notify to error-report
    Replace notify with report across the file (Raag)
---
 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 +++++++++++++
 drivers/gpu/drm/drm_ras.c                | 87 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 ++++
 7 files changed, 186 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 83c21853b74b..406e4c49bac1 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,7 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Subscribe to the ``error-report`` multicast group to receive ``error-event``.
 
 YAML-based Interface
 --------------------
@@ -111,3 +112,23 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Subscribe to ``error-report`` multicast group
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --output-json --subscribe error-report
+
+.. code-block:: json
+
+    {
+        "name": "error-event",
+        "msg": {
+            "device-name": "0000:03:00.0",
+            "node-id": 1,
+            "node-name": "uncorrectable-errors",
+            "error-id": 1,
+            "error-name": "error_name1",
+            "error-value": 1
+        }
+    }
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..8aed3d4515e5 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,33 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+  -
+    name: error-event-attrs
+    attributes:
+      -
+        name: device-name
+        type: string
+        doc: Device (PCI BDF, UUID) that reported the error.
+      -
+        name: node-id
+        type: u32
+        doc: ID of the node that reported the error.
+      -
+        name: node-name
+        type: string
+        doc: Name of the node that reported the error.
+      -
+        name: error-id
+        type: u32
+        doc: ID of the error counter.
+      -
+        name: error-name
+        type: string
+        doc: Name of the error.
+      -
+        name: error-value
+        type: u32
+        doc: Current value of the error counter.
 
 operations:
   list:
@@ -124,3 +151,24 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: error-event
+      doc: >-
+           Report an error event to userspace.
+           The event includes the device, node and error information
+           of the error that triggered the event.
+      attribute-set: error-event-attrs
+      mcgrp: error-report
+      event:
+        attributes:
+          - device-name
+          - node-id
+          - node-name
+          - error-id
+          - error-name
+          - error-value
+
+mcast-groups:
+  list:
+    -
+      name: error-report
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..77f912a4d101 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,11 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. ERROR_REPORT: Subscribe to this multicast group to receive error events
+ *
+ * 5. ERROR_EVENT: Report an error event to userspace. The event contains device, node
+ *    and error information that triggered the event.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -186,6 +191,34 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_put_error_event_attrs(struct sk_buff *msg, struct drm_ras_node *node,
+				     u32 error_id, const char *error_name, u32 value)
+{
+	int ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME, node->device_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID, node->id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME, node->node_name);
+	if (ret)
+		return ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME, error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE, value);
+}
+
 static int doit_reply_value(struct genl_info *info, u32 node_id,
 			    u32 error_id)
 {
@@ -222,6 +255,60 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+/**
+ * drm_ras_nl_error_event() - Report an error event
+ * @node: Node structure
+ * @error_id: ID of the error
+ * @error_name: Name of the error
+ * @value: Value associated with the error
+ * @flags: GFP flags for memory allocation
+ *
+ * Report an error-event to userspace using the error-report multicast group.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags)
+{
+	struct genl_info info;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	int ret;
+
+	if (!error_name)
+		return -EINVAL;
+
+	if (!genl_has_listeners(&drm_ras_nl_family, &init_net, DRM_RAS_NLGRP_ERROR_REPORT))
+		return 0;
+
+	genl_info_init_ntf(&info, &drm_ras_nl_family, DRM_RAS_CMD_ERROR_EVENT);
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, flags);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, &info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = msg_put_error_event_attrs(msg, node, error_id, error_name, value);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&drm_ras_nl_family, msg, 0, DRM_RAS_NLGRP_ERROR_REPORT, flags);
+	return 0;
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+EXPORT_SYMBOL(drm_ras_nl_error_event);
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..9d3123cc9f9c 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -58,6 +58,10 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
+	[DRM_RAS_NLGRP_ERROR_REPORT] = { "error-report", },
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
index a398643572a5..03ec275aca92 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -21,6 +21,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
 
+enum {
+	DRM_RAS_NLGRP_ERROR_REPORT,
+};
+
 extern struct genl_family drm_ras_nl_family;
 
 #endif /* _LINUX_DRM_RAS_GEN_H */
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 0beede3ddc4e..8abfb7d2077b 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -80,9 +80,14 @@ struct drm_device;
 #if IS_ENABLED(CONFIG_DRM_RAS)
 int drm_ras_node_register(struct drm_ras_node *node);
 void drm_ras_node_unregister(struct drm_ras_node *node);
+int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id, const char *error_name,
+			   u32 value, gfp_t flags);
 #else
 static inline int drm_ras_node_register(struct drm_ras_node *node) { return 0; }
 static inline void drm_ras_node_unregister(struct drm_ras_node *node) { }
+static inline int drm_ras_nl_error_event(struct drm_ras_node *node, u32 error_id,
+					 const char *error_name, u32 value, gfp_t flags)
+{ return 0; }
 #endif
 
 #endif
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..eab8231aa87c 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -38,13 +38,28 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
 };
 
+enum {
+	DRM_RAS_A_ERROR_EVENT_ATTRS_DEVICE_NAME = 1,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_NODE_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_ID,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_NAME,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_ERROR_VALUE,
+
+	__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX,
+	DRM_RAS_A_ERROR_EVENT_ATTRS_MAX = (__DRM_RAS_A_ERROR_EVENT_ATTRS_MAX - 1)
+};
+
 enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_ERROR_EVENT,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
 };
 
+#define DRM_RAS_MCGRP_ERROR_REPORT	"error-report"
+
 #endif /* _UAPI_LINUX_DRM_RAS_H */
-- 
2.47.1


