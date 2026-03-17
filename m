Return-Path: <netdev+bounces-268673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKtVFaB9uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:13:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8BE2ADB71
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 616AA30451CA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FC32FB08C;
	Tue, 17 Mar 2026 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bITS8Who"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA52F8BD3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763840; cv=none; b=Xbe25Tdk3bdn0yztOTjTjU8FOgmjrzCj+V7xFUj/TC4yBTjdUDLazAanZCQB9rlDaCZh3TPSICxWoxHMEcZZF7hwzLQ1pCmZqk5cEOk8WtYYAArnJ/5xGBzH2OhO6HwJBgywkznq4nDYJsR7tsoW2IC9O0LGi4kiiIrkgV6EKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763840; c=relaxed/simple;
	bh=oPwL7umOuRfctjq7ByPp0zsRg/MvsHyQysHZ+PKIa4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieuoVBH5Ru7HDtYJRrHsGG/gGpu/d/+bSBcPzsk/HTrbAW65qc7m/hwZp2pRbyZix3NabJie4CCWrjB9cJtZglrajpJh76cCyRXBU1qIJR33jED7ksh8UCmswjTz6IrPSO8FDR6KEwYi9+5YLO6mR6rsSw9r4eSQ1fypYgRzcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bITS8Who; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586A1C19424;
	Tue, 17 Mar 2026 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773763839;
	bh=oPwL7umOuRfctjq7ByPp0zsRg/MvsHyQysHZ+PKIa4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bITS8WhoF4XZyCXDmVj3RpuiGBq/TBHZ3NLCd98RslEwr1jTMZ0RICdp9jqri9OVb
	 mlZou9yR7YOEKtH460lfOBNPmSU/Z01+oEusU4CT4kEoUH5gPjaoTsv/QTL15in7ws
	 MxodE7tP92jVcZOz4NdowVdn37mxBgYmNzhZWnu8+vfkxYA/6cLox8yq174ksibvmf
	 OZqjDQRiJTjMcOPmKlpg4umjk0+56oBQ8U/gqyxzfNS5bfuEh+ZN7JXHmOQBstqLZy
	 WRFjtxR/tHP4G4bNgniDTU9OklBWZGKbjiSXDKqF4FYNscTog9YGSDYwg6Om/1WFTJ
	 vT8zSJtC2jMmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	p@1g4.org,
	ast@fiberby.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] net: shaper: protect from late creation of hierarchy
Date: Tue, 17 Mar 2026 09:10:14 -0700
Message-ID: <20260317161014.779569-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317161014.779569-1-kuba@kernel.org>
References: <20260317161014.779569-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com,1g4.org,fiberby.net,resnulli.us];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-268673-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E8BE2ADB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We look up a netdev during prep of Netlink ops (pre- callbacks)
and take a ref to it. Then later in the body of the callback
we take its lock or RCU which are the actual protections.

The netdev may get unregistered in between the time we take
the ref and the time we lock it. We may allocate the hierarchy
after flush has already run, which would lead to a leak.

Take the instance lock in pre- already, this saves us from the race
and removes the need for dedicated lock/unlock callbacks completely.
After all, if there's any chance of write happening concurrently
with the flush - we're back to leaking the hierarchy.

We may take the lock for devices which don't support shapers but
we're only dealing with SET operations here, not taking the lock
would be optimizing for an error case.

Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations")
Link: https://lore.kernel.org/20260309173450.538026-1-p@1g4.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/net_shaper.yaml |  12 +-
 net/shaper/shaper_nl_gen.h                  |   5 +
 net/shaper/shaper.c                         | 134 +++++++++++---------
 net/shaper/shaper_nl_gen.c                  |  12 +-
 4 files changed, 89 insertions(+), 74 deletions(-)

diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 0b1b54be48f9..3f2ad772b64b 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -247,8 +247,8 @@ doc: |
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes:
             - ifindex
@@ -278,8 +278,8 @@ doc: |
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes: *ns-binding
 
@@ -309,8 +309,8 @@ doc: |
       flags: [admin-perm]
 
       do:
-        pre: net-shaper-nl-pre-doit
-        post: net-shaper-nl-post-doit
+        pre: net-shaper-nl-pre-doit-write
+        post: net-shaper-nl-post-doit-write
         request:
           attributes:
             - ifindex
diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
index ec41c90431a4..42c46c52c775 100644
--- a/net/shaper/shaper_nl_gen.h
+++ b/net/shaper/shaper_nl_gen.h
@@ -18,12 +18,17 @@ extern const struct nla_policy net_shaper_leaf_info_nl_policy[NET_SHAPER_A_WEIGH
 
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info);
+int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
 			       struct sk_buff *skb, struct genl_info *info);
 void
 net_shaper_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
 void
+net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
+			      struct sk_buff *skb, struct genl_info *info);
+void
 net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
 			    struct sk_buff *skb, struct genl_info *info);
 int net_shaper_nl_pre_dumpit(struct netlink_callback *cb);
diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 6b4c87e12f1f..94bc9c7382ea 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -36,24 +36,6 @@ static struct net_shaper_binding *net_shaper_binding_from_ctx(void *ctx)
 	return &((struct net_shaper_nl_ctx *)ctx)->binding;
 }
 
-static void net_shaper_lock(struct net_shaper_binding *binding)
-{
-	switch (binding->type) {
-	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		netdev_lock(binding->netdev);
-		break;
-	}
-}
-
-static void net_shaper_unlock(struct net_shaper_binding *binding)
-{
-	switch (binding->type) {
-	case NET_SHAPER_BINDING_TYPE_NETDEV:
-		netdev_unlock(binding->netdev);
-		break;
-	}
-}
-
 static struct net_shaper_hierarchy *
 net_shaper_hierarchy(struct net_shaper_binding *binding)
 {
@@ -219,12 +201,49 @@ static int net_shaper_ctx_setup(const struct genl_info *info, int type,
 	return 0;
 }
 
+/* Like net_shaper_ctx_setup(), but for "write" handlers (never for dumps!)
+ * Acquires the lock protecting the hierarchy (instance lock for netdev).
+ */
+static int net_shaper_ctx_setup_lock(const struct genl_info *info, int type,
+				     struct net_shaper_nl_ctx *ctx)
+{
+	struct net *ns = genl_info_net(info);
+	struct net_device *dev;
+	int ifindex;
+
+	if (GENL_REQ_ATTR_CHECK(info, type))
+		return -EINVAL;
+
+	ifindex = nla_get_u32(info->attrs[type]);
+	dev = netdev_get_by_index_lock(ns, ifindex);
+	if (!dev) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		return -ENOENT;
+	}
+
+	if (!dev->netdev_ops->net_shaper_ops) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
+		netdev_unlock(dev);
+		return -EOPNOTSUPP;
+	}
+
+	ctx->binding.type = NET_SHAPER_BINDING_TYPE_NETDEV;
+	ctx->binding.netdev = dev;
+	return 0;
+}
+
 static void net_shaper_ctx_cleanup(struct net_shaper_nl_ctx *ctx)
 {
 	if (ctx->binding.type == NET_SHAPER_BINDING_TYPE_NETDEV)
 		netdev_put(ctx->binding.netdev, &ctx->dev_tracker);
 }
 
+static void net_shaper_ctx_cleanup_unlock(struct net_shaper_nl_ctx *ctx)
+{
+	if (ctx->binding.type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		netdev_unlock(ctx->binding.netdev);
+}
+
 static u32 net_shaper_handle_to_index(const struct net_shaper_handle *handle)
 {
 	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, handle->scope) |
@@ -278,7 +297,7 @@ net_shaper_lookup(struct net_shaper_binding *binding,
 }
 
 /* Allocate on demand the per device shaper's hierarchy container.
- * Called under the net shaper lock
+ * Called under the lock protecting the hierarchy (instance lock for netdev)
  */
 static struct net_shaper_hierarchy *
 net_shaper_hierarchy_setup(struct net_shaper_binding *binding)
@@ -697,6 +716,22 @@ void net_shaper_nl_post_doit(const struct genl_split_ops *ops,
 	net_shaper_generic_post(info);
 }
 
+int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)info->ctx;
+
+	BUILD_BUG_ON(sizeof(*ctx) > sizeof(info->ctx));
+
+	return net_shaper_ctx_setup_lock(info, NET_SHAPER_A_IFINDEX, ctx);
+}
+
+void net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
+				   struct sk_buff *skb, struct genl_info *info)
+{
+	net_shaper_ctx_cleanup_unlock((struct net_shaper_nl_ctx *)info->ctx);
+}
+
 int net_shaper_nl_pre_dumpit(struct netlink_callback *cb)
 {
 	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)cb->ctx;
@@ -824,45 +859,38 @@ int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	binding = net_shaper_binding_from_ctx(info->ctx);
 
-	net_shaper_lock(binding);
 	ret = net_shaper_parse_info(binding, info->attrs, info, &shaper,
 				    &exists);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	if (!exists)
 		net_shaper_default_parent(&shaper.handle, &shaper.parent);
 
 	hierarchy = net_shaper_hierarchy_setup(binding);
-	if (!hierarchy) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!hierarchy)
+		return -ENOMEM;
 
 	/* The 'set' operation can't create node-scope shapers. */
 	handle = shaper.handle;
 	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
-	    !net_shaper_lookup(binding, &handle)) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	    !net_shaper_lookup(binding, &handle))
+		return -ENOENT;
 
 	ret = net_shaper_pre_insert(binding, &handle, info->extack);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	ops = net_shaper_ops(binding);
 	ret = ops->set(binding, &shaper, info->extack);
 	if (ret) {
 		net_shaper_rollback(binding);
-		goto unlock;
+		return ret;
 	}
 
 	net_shaper_commit(binding, 1, &shaper);
 
-unlock:
-	net_shaper_unlock(binding);
-	return ret;
+	return 0;
 }
 
 static int __net_shaper_delete(struct net_shaper_binding *binding,
@@ -1090,35 +1118,26 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 
 	binding = net_shaper_binding_from_ctx(info->ctx);
 
-	net_shaper_lock(binding);
 	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
 				      &handle);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	hierarchy = net_shaper_hierarchy(binding);
-	if (!hierarchy) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!hierarchy)
+		return -ENOENT;
 
 	shaper = net_shaper_lookup(binding, &handle);
-	if (!shaper) {
-		ret = -ENOENT;
-		goto unlock;
-	}
+	if (!shaper)
+		return -ENOENT;
 
 	if (handle.scope == NET_SHAPER_SCOPE_NODE) {
 		ret = net_shaper_pre_del_node(binding, shaper, info->extack);
 		if (ret)
-			goto unlock;
+			return ret;
 	}
 
-	ret = __net_shaper_delete(binding, shaper, info->extack);
-
-unlock:
-	net_shaper_unlock(binding);
-	return ret;
+	return __net_shaper_delete(binding, shaper, info->extack);
 }
 
 static int net_shaper_group_send_reply(struct net_shaper_binding *binding,
@@ -1167,21 +1186,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!net_shaper_ops(binding)->group)
 		return -EOPNOTSUPP;
 
-	net_shaper_lock(binding);
 	leaves_count = net_shaper_list_len(info, NET_SHAPER_A_LEAVES);
 	if (!leaves_count) {
 		NL_SET_BAD_ATTR(info->extack,
 				info->attrs[NET_SHAPER_A_LEAVES]);
-		ret = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
 	leaves = kcalloc(leaves_count, sizeof(struct net_shaper) +
 			 sizeof(struct net_shaper *), GFP_KERNEL);
-	if (!leaves) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!leaves)
+		return -ENOMEM;
 	old_nodes = (void *)&leaves[leaves_count];
 
 	ret = net_shaper_parse_node(binding, info->attrs, info, &node);
@@ -1258,9 +1273,6 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 
 free_leaves:
 	kfree(leaves);
-
-unlock:
-	net_shaper_unlock(binding);
 	return ret;
 
 free_msg:
@@ -1370,14 +1382,12 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
-	net_shaper_lock(binding);
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		__xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
 	xa_unlock(&hierarchy->shapers);
-	net_shaper_unlock(binding);
 
 	kfree(hierarchy);
 }
diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
index e8cccc4c1180..9b29be3ef19a 100644
--- a/net/shaper/shaper_nl_gen.c
+++ b/net/shaper/shaper_nl_gen.c
@@ -99,27 +99,27 @@ static const struct genl_split_ops net_shaper_nl_ops[] = {
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_SET,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_set_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_set_nl_policy,
 		.maxattr	= NET_SHAPER_A_IFINDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_DELETE,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_delete_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_delete_nl_policy,
 		.maxattr	= NET_SHAPER_A_IFINDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NET_SHAPER_CMD_GROUP,
-		.pre_doit	= net_shaper_nl_pre_doit,
+		.pre_doit	= net_shaper_nl_pre_doit_write,
 		.doit		= net_shaper_nl_group_doit,
-		.post_doit	= net_shaper_nl_post_doit,
+		.post_doit	= net_shaper_nl_post_doit_write,
 		.policy		= net_shaper_group_nl_policy,
 		.maxattr	= NET_SHAPER_A_LEAVES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
-- 
2.53.0


