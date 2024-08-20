Return-Path: <netdev+bounces-120245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616E958AD6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE61284B34
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E60192B95;
	Tue, 20 Aug 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQF6kXy8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8D1922F7
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166811; cv=none; b=Nij7GfIVEV7LT1O+HiUaQlpKzV24YwIFabmFicR8S8fWiiTsG2QfWYSgXBZyfeuVOZKDQIjp6x8Pz+zPhhlqvmxKP4zmEK+wGKw5Dhx+TcqwZnu6amvRBSrTaswk7itfhuQahlJ8WBKqRG9tvriRrhCeETrgntv0PAjGR2LxMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166811; c=relaxed/simple;
	bh=wn2oj0XE+tSdntTy4BU+yGD7Z95emPVwiAj7ZbTaPTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuXsRXNkKjrU6dbMZDved8dKbg8NIh7vpGq8yGpJ1zXDYXdGWxVD+O7bSouIea0vh9pyA2WeUaPBOrR+xz0BTaT9n0OO+3pp0jeCNPEeLYUGpMLUuaZvJwSKojANZnT8dt7auelwa29B6OlhaoNYLHHEJpGo67CMKLrr99hm49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQF6kXy8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6pUR/21jvfPwyIlPtEQHoEgrk5zaw30gf7ei29RxuU=;
	b=WQF6kXy8LN1HY13HxmiJK/6AjhYSf1x+bLUsusrKwqqFzK7LyCAGaEIwpYMp0vXgfKCThp
	43DUScy9sN3AQcRr4g9TwTYiMz7PWkrbhZEqLyT/s2UNfghZucvxCHbgb7Wu/jjbUrehl1
	UWy1ffvQ2M6xQ9alA9PAf/5EI4TjMQw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-MWCJhZo5NFiaagQOrrNIpg-1; Tue,
 20 Aug 2024 11:13:25 -0400
X-MC-Unique: MWCJhZo5NFiaagQOrrNIpg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AD651955D4C;
	Tue, 20 Aug 2024 15:13:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3345119560AA;
	Tue, 20 Aug 2024 15:13:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 07/12] netlink: spec: add shaper introspection support
Date: Tue, 20 Aug 2024 17:12:28 +0200
Message-ID: <0e5fcb58af18ce3537be4652f2a805d3f0cb331e.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Allow the user-space to fine-grain query the shaping features
supported by the NIC on each domain.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 Documentation/netlink/specs/net_shaper.yaml | 84 +++++++++++++++++++++
 include/uapi/linux/net_shaper.h             | 17 +++++
 net/shaper/shaper.c                         | 22 ++++++
 net/shaper/shaper_nl_gen.c                  | 27 +++++++
 net/shaper/shaper_nl_gen.h                  |  8 ++
 5 files changed, 158 insertions(+)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index a2b7900646ae..64d827176a61 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -20,6 +20,11 @@ doc: |
 
   The user can query the running configuration via the @get operation.
 
+  Different devices can provide different feature set, e.g. with no
+  support for complex scheduling hierarchy, or for some shaping
+  parameters. The user can introspect the HW capabilities via the
+  @cap-get operation.
+
 definitions:
   -
     type: enum
@@ -187,6 +192,52 @@ attribute-sets:
         name: priority
       -
         name: weight
+  -
+    name: capabilities
+    attributes:
+      -
+        name: ifindex
+        type: u32
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: The scope to which the queried capabilities apply.
+      -
+        name: support-metric-bps
+        type: flag
+        doc: The device accepts 'bps' metric for bw-min, bw-max and burst.
+      -
+        name: support-metric-pps
+        type: flag
+        doc: The device accepts 'pps' metric for bw-min, bw-max and burst.
+      -
+        name: support-nesting
+        type: flag
+        doc: |
+          The device supports nesting shaper belonging to this scope
+          below 'node' scoped shapers. Only 'queue' and 'node'
+          scope can have flag 'support-nesting'.
+      -
+        name: support-bw-min
+        type: flag
+        doc: The device supports a minimum guaranteed B/W.
+      -
+        name: support-bw-max
+        type: flag
+        doc: The device supports maximum B/W shaping.
+      -
+        name: support-burst
+        type: flag
+        doc: The device supports a maximum burst size.
+      -
+        name: support-priority
+        type: flag
+        doc: The device supports priority scheduling.
+      -
+        name: support-weight
+        type: flag
+        doc: The device supports weighted round robin scheduling.
 
 operations:
   list:
@@ -287,3 +338,36 @@ operations:
             - root
         reply:
           attributes: *ns-binding
+
+    -
+      name: cap-get
+      doc: |
+        Get / Dump the shaper capabilities supported by the given device.
+      attribute-set: capabilities
+
+      do:
+        pre: net-shaper-nl-cap-pre-doit
+        post: net-shaper-nl-cap-post-doit
+        request:
+          attributes:
+            - ifindex
+            - scope
+        reply:
+          attributes: &cap-attrs
+            - ifindex
+            - scope
+            - support-metric-bps
+            - support-metric-pps
+            - support-nesting
+            - support-bw-min
+            - support-bw-max
+            - support-burst
+            - support-priority
+            - support-weight
+
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *cap-attrs
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
index 05917f10b021..70d9639f9345 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -60,11 +60,28 @@ enum {
 	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
 };
 
+enum {
+	NET_SHAPER_A_CAPABILITIES_IFINDEX = 1,
+	NET_SHAPER_A_CAPABILITIES_SCOPE,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_BPS,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_METRIC_PPS,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_NESTING,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BW_MIN,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BW_MAX,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_BURST,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_PRIORITY,
+	NET_SHAPER_A_CAPABILITIES_SUPPORT_WEIGHT,
+
+	__NET_SHAPER_A_CAPABILITIES_MAX,
+	NET_SHAPER_A_CAPABILITIES_MAX = (__NET_SHAPER_A_CAPABILITIES_MAX - 1)
+};
+
 enum {
 	NET_SHAPER_CMD_GET = 1,
 	NET_SHAPER_CMD_SET,
 	NET_SHAPER_CMD_DELETE,
 	NET_SHAPER_CMD_GROUP,
+	NET_SHAPER_CMD_CAP_GET,
 
 	__NET_SHAPER_CMD_MAX,
 	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index e5282c5bebe1..d3bb0ee1a18a 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -501,6 +501,17 @@ void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 	netdev_put(dev, NULL);
 }
 
+int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
+			       struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+void net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info)
+{
+}
+
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_device *dev = info->user_ptr[0];
@@ -1052,6 +1063,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
+int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb)
+{
+	return 0;
+}
+
 void net_shaper_flush(struct net_device *dev)
 {
 	struct xarray *xa = net_shaper_cache_container(dev);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index b0a4bdf1f00a..04f9cbf3aee0 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -67,6 +67,17 @@ static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_ROOT + 1]
 	[NET_SHAPER_A_ROOT] = NLA_POLICY_NESTED(net_shaper_root_info_nl_policy),
 };
 
+/* NET_SHAPER_CMD_CAP_GET - do */
+static const struct nla_policy net_shaper_cap_get_do_nl_policy[NET_SHAPER_A_CAPABILITIES_SCOPE + 1] = {
+	[NET_SHAPER_A_CAPABILITIES_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_CAPABILITIES_SCOPE] = NLA_POLICY_MAX(NLA_U32, 3),
+};
+
+/* NET_SHAPER_CMD_CAP_GET - dump */
+static const struct nla_policy net_shaper_cap_get_dump_nl_policy[NET_SHAPER_A_CAPABILITIES_IFINDEX + 1] = {
+	[NET_SHAPER_A_CAPABILITIES_IFINDEX] = { .type = NLA_U32, },
+};
+
 /* Ops table for net_shaper */
 static const struct genl_split_ops net_shaper_nl_ops[] = {
 	{
@@ -112,6 +123,22 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 		.maxattr	= NET_SHAPER_A_ROOT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.pre_doit	= net_shaper_nl_cap_pre_doit,
+		.doit		= net_shaper_nl_cap_get_doit,
+		.post_doit	= net_shaper_nl_cap_post_doit,
+		.policy		= net_shaper_cap_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPABILITIES_SCOPE,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.dumpit		= net_shaper_nl_cap_get_dumpit,
+		.policy		= net_shaper_cap_get_dump_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPABILITIES_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family net_shaper_nl_family __ro_after_init = {
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index 9b0682c83a07..6cec8903f25b 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -18,15 +18,23 @@ extern const struct nla_policy net_shaper_root_info_nl_policy[NET_SHAPER_A_PAREN
 
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
+			       struct sk_buff *skb, struct genl_info *info);
 void
 net_shaper_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
+void
+net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
+			    struct sk_buff *skb, struct genl_info *info);
 
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_doit(struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_cap_get_dumpit(struct sk_buff *skb,
+				 struct netlink_callback *cb);
 
 extern struct genl_family net_shaper_nl_family;
 
-- 
2.45.2


