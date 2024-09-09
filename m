Return-Path: <netdev+bounces-126723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFD97250E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC251F24C3A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508FB18CBEF;
	Mon,  9 Sep 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGhHlZID"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF518C930
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919901; cv=none; b=nPZyhFzGS7RbDd9p90IuMSNRx3VXfKb4PMZPsTmRIQ4K+W37DOVzTsVluDziFAL76QfkwhD20vvVExjAnV1d7ghUIXaoGKGZlXYYTqo+OMy3o4ju4mdR7ubJoBwZ66aJmv0Rlyhax9JGtbpUzYsZS39mMw5Ia6CSRShxPu/6DjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919901; c=relaxed/simple;
	bh=sAGtsrt/7mMSuBppUVs6/lKBlBOYmSc3oPTzVy/7uJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYrJKEBfjcRTdqgJcFKiIQN4HhgvCH3Djway/vWAgkZwuGJQ9teheAMCFYvDWfVby8WltccSrBrrevxuTZxAcCpC6ZN4AGd1Nz6ihHcoseQhpTqnftPH7ySY9MF9KBmqPdV1qxH4e0Ulmx8ZvWcz0rweiVwx1aruhj1/9RbSocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGhHlZID; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725919898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzbimObBdohLQg8HcH+jHUsCVIOgfWRXU3BOzz36E9s=;
	b=UGhHlZIDvXrH/1FF//dnCX4RmviTzi6aVt6omyVmnDjt0iUR3Zaz/0EyOFVz7Z7fbQqFOb
	8I0U4sy/QmlLFRVo1fmTfMazs2LF3NMtG29tWq9f1oUNffHWw2gxqc9j33CkbtBTPw04uS
	YDcQSBlPEsaUdoVm9LMkfwgr1w6hX10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-kZuWTtEPNVmA0seFigonrg-1; Mon,
 09 Sep 2024 18:11:34 -0400
X-MC-Unique: kZuWTtEPNVmA0seFigonrg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB61A1955F68;
	Mon,  9 Sep 2024 22:11:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACC7E1956086;
	Mon,  9 Sep 2024 22:11:26 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com
Subject: [PATCH v7 net-next 08/15] netlink: spec: add shaper introspection support
Date: Tue, 10 Sep 2024 00:10:02 +0200
Message-ID: <4009e4ca5d2a4af23ccfa47500d2b769c36a9642.1725919039.git.pabeni@redhat.com>
In-Reply-To: <cover.1725919039.git.pabeni@redhat.com>
References: <cover.1725919039.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Allow the user-space to fine-grain query the shaping features
supported by the NIC on each domain.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - shorter cap-related names

v4 -> v5:
 - added pre/post helpers for dump op
---
 Documentation/netlink/specs/net_shaper.yaml | 88 +++++++++++++++++++++
 include/uapi/linux/net_shaper.h             | 17 ++++
 net/shaper/shaper.c                         | 32 ++++++++
 net/shaper/shaper_nl_gen.c                  | 29 +++++++
 net/shaper/shaper_nl_gen.h                  | 10 +++
 5 files changed, 176 insertions(+)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index cfe55af41d9d..e6b55bcb7a7b 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -27,6 +27,11 @@ doc: |
 
   The user can query the running configuration via the @get operation.
 
+  Different devices can provide different feature sets, e.g. with no
+  support for complex scheduling hierarchy, or for some shaping
+  parameters. The user can introspect the HW capabilities via the
+  @cap-get operation.
+
 definitions:
   -
     type: enum
@@ -149,6 +154,53 @@ attribute-sets:
         name: priority
       -
         name: weight
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Interface index queried for shapers capabilities.
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
@@ -274,3 +326,39 @@ operations:
             - leaves
         reply:
           attributes: *ns-binding
+
+    -
+      name: cap-get
+      doc: |
+        Get the shaper capabilities supported by the given device
+        for the specified scope.
+      attribute-set: caps
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
+        pre: net-shaper-nl-cap-pre-dumpit
+        post: net-shaper-nl-cap-post-dumpit
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *cap-attrs
diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
index 9e3fa63618ee..d8834b59f7d7 100644
--- a/include/uapi/linux/net_shaper.h
+++ b/include/uapi/linux/net_shaper.h
@@ -65,11 +65,28 @@ enum {
 	NET_SHAPER_A_HANDLE_MAX = (__NET_SHAPER_A_HANDLE_MAX - 1)
 };
 
+enum {
+	NET_SHAPER_A_CAPS_IFINDEX = 1,
+	NET_SHAPER_A_CAPS_SCOPE,
+	NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS,
+	NET_SHAPER_A_CAPS_SUPPORT_METRIC_PPS,
+	NET_SHAPER_A_CAPS_SUPPORT_NESTING,
+	NET_SHAPER_A_CAPS_SUPPORT_BW_MIN,
+	NET_SHAPER_A_CAPS_SUPPORT_BW_MAX,
+	NET_SHAPER_A_CAPS_SUPPORT_BURST,
+	NET_SHAPER_A_CAPS_SUPPORT_PRIORITY,
+	NET_SHAPER_A_CAPS_SUPPORT_WEIGHT,
+
+	__NET_SHAPER_A_CAPS_MAX,
+	NET_SHAPER_A_CAPS_MAX = (__NET_SHAPER_A_CAPS_MAX - 1)
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
index 2ddd52ec28e3..1b4b3408d7a1 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -600,6 +600,27 @@ int net_shaper_nl_post_dumpit(struct netlink_callback *cb)
 	return 0;
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
+int net_shaper_nl_cap_pre_dumpit(struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
+int net_shaper_nl_cap_post_dumpit(struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_shaper_binding *binding;
@@ -1128,6 +1149,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	goto free_leaves;
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
 static void net_shaper_flush(struct net_shaper_binding *binding)
 {
 	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index 34185c5989e6..204c8ae8c7b1 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -65,6 +65,17 @@ static const struct nla_policy net_shaper_group_nl_policy[NET_SHAPER_A_LEAVES +
 	[NET_SHAPER_A_LEAVES] = NLA_POLICY_NESTED(net_shaper_leaf_info_nl_policy),
 };
 
+/* NET_SHAPER_CMD_CAP_GET - do */
+static const struct nla_policy net_shaper_cap_get_do_nl_policy[NET_SHAPER_A_CAPS_SCOPE + 1] = {
+	[NET_SHAPER_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+	[NET_SHAPER_A_CAPS_SCOPE] = NLA_POLICY_MAX(NLA_U32, 3),
+};
+
+/* NET_SHAPER_CMD_CAP_GET - dump */
+static const struct nla_policy net_shaper_cap_get_dump_nl_policy[NET_SHAPER_A_CAPS_IFINDEX + 1] = {
+	[NET_SHAPER_A_CAPS_IFINDEX] = { .type = NLA_U32, },
+};
+
 /* Ops table for net_shaper */
 static const struct genl_split_ops net_shaper_nl_ops[] = {
 	{
@@ -112,6 +123,24 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 		.maxattr	= NET_SHAPER_A_LEAVES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.pre_doit	= net_shaper_nl_cap_pre_doit,
+		.doit		= net_shaper_nl_cap_get_doit,
+		.post_doit	= net_shaper_nl_cap_post_doit,
+		.policy		= net_shaper_cap_get_do_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPS_SCOPE,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NET_SHAPER_CMD_CAP_GET,
+		.start		= net_shaper_nl_cap_pre_dumpit,
+		.dumpit		= net_shaper_nl_cap_get_dumpit,
+		.done		= net_shaper_nl_cap_post_dumpit,
+		.policy		= net_shaper_cap_get_dump_nl_policy,
+		.maxattr	= NET_SHAPER_A_CAPS_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 struct genl_family net_shaper_nl_family __ro_after_init = {
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index 016cb6f3187b..cb7f9026fc23 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -17,17 +17,27 @@ extern const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGH
 
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
 int net_shaper_nl_pre_dumpit(struct netlink_callback *cb);
+int net_shaper_nl_cap_pre_dumpit(struct netlink_callback *cb);
 int net_shaper_nl_post_dumpit(struct netlink_callback *cb);
+int net_shaper_nl_cap_post_dumpit(struct netlink_callback *cb);
 
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


