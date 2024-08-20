Return-Path: <netdev+bounces-120244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0384F958AD4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA327282E3F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CC1922EA;
	Tue, 20 Aug 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnfbRdKY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0851917FB
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166809; cv=none; b=adhBVu6aAe/HCMExRkZmxCTJs11gEFjh82HwjlB6ai412HKIIWdAU6R6LNjC+jUf0iK8Ec9W7sZf7YXeXsaMR01/wvt6mFsmpVSKGJsQvNafRoURWsdKkR+OK8QkbEcT8eBqQ6fqwktQmKK7pFP6nKvVX/Ma80JHGjDLuxe7lZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166809; c=relaxed/simple;
	bh=34O4CLaPAjksQGhE59akAeBGWI/u9d5hP7RDR+vuLbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAx6AnNUby1AoJSMnfbb9FiGC1tAZERNDKz/JtsNDh0KiIo0zMjYePU+DPy/ngsEnJYNan5Rp+Qdf7HktEpJELAbt0y1u+gg3E86byq1tKSAdL1zvR3EIUtovMHm2ktYbSET3gv5sCb52+tvsMOWBLLi1Y9lNkWM4phsaTH5diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnfbRdKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cY5Mqmoz8wyJrHymrosrJMHonmoF7UYrKswkhYt87eI=;
	b=hnfbRdKY7DlkE5NQzeZOEBJtrnJBTfFb+JPmwZDkeD6xZhwEucqjTdf96zUQ23bNTo5zaj
	qIO8Y1pmrzTF4WD4lInBamkp+naUeXedHDNcoUARdeqlKq287j0KPFxX4q71CpGThlQO9R
	XRqufve06FoT7NOd06wRm+GTBhNdoaM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-0WeBLvXqOOOZlj-zHtCvqA-1; Tue,
 20 Aug 2024 11:13:22 -0400
X-MC-Unique: 0WeBLvXqOOOZlj-zHtCvqA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 670BC1955BEF;
	Tue, 20 Aug 2024 15:13:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7A521955F41;
	Tue, 20 Aug 2024 15:13:11 +0000 (UTC)
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
Subject: [PATCH v4 net-next 05/12] net-shapers: implement NL group operation
Date: Tue, 20 Aug 2024 17:12:26 +0200
Message-ID: <438e0f17c733984b920f0949fa908d31724e2dfe.1724165948.git.pabeni@redhat.com>
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

Allow grouping multiple leaves shaper under the given root.
The root and the leaves shapers are created, if needed, otherwise
the existing shapers are re-linked as requested.

Try hard to pre-allocated the needed resources, to avoid non
trivial H/W configuration rollbacks in case of any failure.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v3:
 - cleanup left-over scope node shaper after re-link, as needed
 - add locking
 - separate arguments for shaper handle

RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 320 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 319 insertions(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 055fda39176b..c4228f98b416 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -32,6 +32,24 @@ struct net_shaper_nl_ctx {
 	u32 start_index;
 };
 
+/* Count the number of [multi] attributes of the given type. */
+static int net_shaper_list_len(struct genl_info *info, int type)
+{
+	struct nlattr *attr;
+	int rem, cnt = 0;
+
+	nla_for_each_attr_type(attr, type, genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem)
+		cnt++;
+	return cnt;
+}
+
+static int net_shaper_handle_size(void)
+{
+	return nla_total_size(nla_total_size(sizeof(u32)) +
+			      nla_total_size(sizeof(u32)));
+}
+
 static int net_shaper_fill_handle(struct sk_buff *msg,
 				  const struct net_shaper_handle *handle,
 				  u32 type, const struct genl_info *info)
@@ -306,6 +324,28 @@ static void net_shaper_cache_commit(struct net_device *dev, int nr_shapers,
 	xa_unlock(xa);
 }
 
+/* Rollback all the tentative inserts from the shaper cache. */
+static void net_shaper_cache_rollback(struct net_device *dev)
+{
+	struct xarray *xa = net_shaper_cache_container(dev);
+	struct net_shaper_handle handle;
+	struct net_shaper_info *cur;
+	unsigned long index;
+
+	if (!xa)
+		return;
+
+	xa_lock(xa);
+	xa_for_each_marked(xa, index, cur, NET_SHAPER_CACHE_NOT_VALID) {
+		net_shaper_index_to_handle(index, &handle);
+		if (handle.scope == NET_SHAPER_SCOPE_NODE)
+			idr_remove(&dev->net_shaper_data->node_ids, handle.id);
+		__xa_erase(xa, index);
+		kfree(cur);
+	}
+	xa_unlock(xa);
+}
+
 static int net_shaper_parse_handle(const struct nlattr *attr,
 				   const struct genl_info *info,
 				   struct net_shaper_handle *handle)
@@ -408,6 +448,37 @@ static int net_shaper_parse_info_nest(struct net_device *dev,
 	return net_shaper_parse_info(dev, tb, info, handle, shaper);
 }
 
+/* Alike net_parse_shaper_info(), but additionally allow the user specifying
+ * the shaper's parent handle.
+ */
+static int net_shaper_parse_root(struct net_device *dev,
+				 const struct nlattr *attr,
+				 const struct genl_info *info,
+				 struct net_shaper_handle *handle,
+				 struct net_shaper_info *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_PARENT + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_PARENT, attr,
+			       net_shaper_root_info_nl_policy,
+			       info->extack);
+	if (ret < 0)
+		return ret;
+
+	ret = net_shaper_parse_info(dev, tb, info, handle, shaper);
+	if (ret)
+		return ret;
+
+	if (tb[NET_SHAPER_A_PARENT]) {
+		ret = net_shaper_parse_handle(tb[NET_SHAPER_A_PARENT], info,
+					      &shaper->parent);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info)
 {
@@ -604,6 +675,89 @@ static int __net_shaper_delete(struct net_device *dev,
 	return 0;
 }
 
+static int __net_shaper_group(struct net_device *dev, int leaves_count,
+			      const struct net_shaper_handle *leaves_handles,
+			      struct net_shaper_info *leaves,
+			      struct net_shaper_handle *root_handle,
+			      struct net_shaper_info *root,
+			      struct netlink_ext_ack *extack)
+{
+	struct net_shaper_info *parent = NULL;
+	struct net_shaper_handle leaf_handle;
+	int i, ret;
+
+	if (root_handle->scope == NET_SHAPER_SCOPE_NODE) {
+		if (root_handle->id != NET_SHAPER_ID_UNSPEC &&
+		    !net_shaper_cache_lookup(dev, root_handle)) {
+			NL_SET_ERR_MSG_FMT(extack, "Root shaper %d:%d does not exists",
+					   root_handle->scope, root_handle->id);
+			return -ENOENT;
+		}
+		if (root->parent.scope != NET_SHAPER_SCOPE_NODE &&
+		    root->parent.scope != NET_SHAPER_SCOPE_NETDEV) {
+			NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for root parent shaper",
+					   root->parent.scope);
+			return -EINVAL;
+		}
+	}
+
+	if (root->parent.scope == NET_SHAPER_SCOPE_NODE) {
+		parent = net_shaper_cache_lookup(dev, &root->parent);
+		if (!parent) {
+			NL_SET_ERR_MSG_FMT(extack, "Root parent shaper %d:%d does not exists",
+					   root->parent.scope, root->parent.id);
+			return -ENOENT;
+		}
+	}
+
+	/* For newly created node scope shaper, the following will update
+	 * the handle, due to id allocation.
+	 */
+	ret = net_shaper_cache_pre_insert(dev, root_handle, extack);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < leaves_count; ++i) {
+		leaf_handle = leaves_handles[i];
+		if (leaf_handle.scope != NET_SHAPER_SCOPE_QUEUE) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for leaf shaper %d",
+					   leaf_handle.scope, i);
+			goto rollback;
+		}
+
+		ret = net_shaper_cache_pre_insert(dev, &leaf_handle, extack);
+		if (ret)
+			goto rollback;
+
+		if (leaves[i].parent.scope == root_handle->scope &&
+		    leaves[i].parent.id == root_handle->id)
+			continue;
+
+		/* The leaves shapers will be nested to the root, update the
+		 * linking accordingly.
+		 */
+		leaves[i].parent = *root_handle;
+		root->leaves++;
+	}
+
+	ret = dev->netdev_ops->net_shaper_ops->group(dev, leaves_count,
+						     leaves_handles, leaves,
+						     root_handle, root,
+						     extack);
+	if (ret < 0)
+		goto rollback;
+
+	if (parent)
+		parent->leaves++;
+	net_shaper_cache_commit(dev, 1, root_handle, root);
+	net_shaper_cache_commit(dev, leaves_count, leaves_handles, leaves);
+	return 0;
+
+rollback:
+	net_shaper_cache_rollback(dev);
+	return ret;
+}
 static int net_shaper_delete(struct net_device *dev,
 			     const struct net_shaper_handle *handle,
 			     struct netlink_ext_ack *extack)
@@ -655,9 +809,173 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	return net_shaper_delete(dev, &handle, info->extack);
 }
 
+/* Update the H/W and on success update the local cache, too */
+static int net_shaper_group(struct net_device *dev, int leaves_count,
+			    const struct net_shaper_handle *leaves_handles,
+			    struct net_shaper_info *leaves,
+			    struct net_shaper_handle *root_handle,
+			    struct net_shaper_info *root,
+			    struct netlink_ext_ack *extack)
+{
+	struct mutex *lock = net_shaper_cache_init(dev, extack);
+	struct net_shaper_handle *old_roots;
+	int i, ret, old_roots_count = 0;
+
+	if (!lock)
+		return -ENOMEM;
+
+	if (root_handle->scope != NET_SHAPER_SCOPE_NODE &&
+	    root_handle->scope != NET_SHAPER_SCOPE_NETDEV) {
+		NL_SET_ERR_MSG_FMT(extack, "Invalid scope %d for root shaper",
+				   root_handle->scope);
+		return -EINVAL;
+	}
+
+	old_roots = kcalloc(leaves_count, sizeof(struct net_shaper_handle),
+			    GFP_KERNEL);
+	if (!old_roots)
+		return -ENOMEM;
+
+	for (i = 0; i < leaves_count; i++)
+		if (leaves[i].parent.scope == NET_SHAPER_SCOPE_NODE &&
+		    (leaves[i].parent.scope != root_handle->scope ||
+		     leaves[i].parent.id != root_handle->id))
+			old_roots[old_roots_count++] = leaves[i].parent;
+
+	mutex_lock(lock);
+	ret = __net_shaper_group(dev, leaves_count, leaves_handles,
+				 leaves, root_handle, root, extack);
+
+	/* Check if we need to delete any NODE left alone by the new leaves
+	 * linkage.
+	 */
+	for (i = 0; i < old_roots_count; ++i) {
+		root = net_shaper_cache_lookup(dev, &old_roots[i]);
+		if (!root)
+			continue;
+
+		if (--root->leaves > 0)
+			continue;
+
+		/* Errors here are not fatal: the grouping operation is
+		 * completed, and user-space can still explicitly clean-up
+		 * left-over nodes.
+		 */
+		__net_shaper_delete(dev, &old_roots[i], root, extack);
+	}
+
+	mutex_unlock(lock);
+
+	kfree(old_roots);
+	return ret;
+}
+
+static int net_shaper_group_send_reply(struct genl_info *info,
+				       struct net_shaper_handle *handle)
+{
+	struct net_device *dev = info->user_ptr[0];
+	struct nlattr *handle_attr;
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	/* Prepare the msg reply in advance, to avoid device operation
+	 * rollback.
+	 */
+	msg = genlmsg_new(net_shaper_handle_size(), GFP_KERNEL);
+	if (!msg)
+		return ret;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr)
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_IFINDEX, dev->ifindex))
+		goto free_msg;
+
+	handle_attr = nla_nest_start(msg, NET_SHAPER_A_HANDLE);
+	if (!handle_attr)
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE, handle->scope))
+		goto free_msg;
+
+	if (nla_put_u32(msg, NET_SHAPER_A_ID, handle->id))
+		goto free_msg;
+
+	nla_nest_end(msg, handle_attr);
+	genlmsg_end(msg, hdr);
+
+	ret = genlmsg_reply(msg, info);
+	if (ret)
+		goto free_msg;
+
+	return ret;
+
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_handle *leaves_handles, root_handle;
+	struct net_device *dev = info->user_ptr[0];
+	struct net_shaper_info *leaves, root;
+	int i, ret, rem, leaves_count;
+	struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_LEAVES) ||
+	    GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_ROOT))
+		return -EINVAL;
+
+	leaves_count = net_shaper_list_len(info, NET_SHAPER_A_LEAVES);
+	leaves = kcalloc(leaves_count, sizeof(struct net_shaper_info) +
+			 sizeof(struct net_shaper_handle), GFP_KERNEL);
+	if (!leaves) {
+		GENL_SET_ERR_MSG_FMT(info, "Can't allocate memory for %d leaves shapers",
+				     leaves_count);
+		return -ENOMEM;
+	}
+	leaves_handles = (struct net_shaper_handle *)&leaves[leaves_count];
+
+	ret = net_shaper_parse_root(dev, info->attrs[NET_SHAPER_A_ROOT],
+				    info, &root_handle, &root);
+	if (ret)
+		goto free_shapers;
+
+	i = 0;
+	nla_for_each_attr_type(attr, NET_SHAPER_A_LEAVES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		if (WARN_ON_ONCE(i >= leaves_count))
+			goto free_shapers;
+
+		ret = net_shaper_parse_info_nest(dev, attr, info,
+						 &leaves_handles[i],
+						 &leaves[i]);
+		if (ret)
+			goto free_shapers;
+		i++;
+	}
+
+	ret = net_shaper_group(dev, leaves_count, leaves_handles, leaves,
+			       &root_handle, &root, info->extack);
+	if (ret < 0)
+		goto free_shapers;
+
+	ret = net_shaper_group_send_reply(info, &root_handle);
+	if (ret) {
+		/* Error on reply is not fatal to avoid rollback a successful
+		 * configuration.
+		 */
+		GENL_SET_ERR_MSG_FMT(info, "Can't send reply %d", ret);
+		ret = 0;
+	}
+
+free_shapers:
+	kfree(leaves);
+	return ret;
 }
 
 void net_shaper_flush(struct net_device *dev)
-- 
2.45.2


