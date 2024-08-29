Return-Path: <netdev+bounces-123354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8F49649B2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7161283967
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421E1B1429;
	Thu, 29 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxZ9jnUc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F71AED50
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944671; cv=none; b=dE1vu/RhlKDLqVgTU0ZzQDQf3vV9+7rTzJqEmGA/XdYdAa3rK7StX8hYqDcUhFCaY0+OHDzwr9tWPLl/pfNu1SscIjYS2+zoAw/ikKcUh/eDavNWNpP7bTgXVNVR12DNHjEgUx12xtjvh6iccqdLITQduqKXj/4mCUEvi5Gn9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944671; c=relaxed/simple;
	bh=2E+f60lMAXkBRiW9c/LLx7fSH+lKmev/TvsfQhTLZC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECfOISdy6cmfX0TVUe4qaGTbj7/X+JFVpj0lu6VHguzhVMcR+LxCL427I/55Ag5sVngMfg61ebPRi/EvoozVEU++tE9Qk1zRBCR39rvVXRkkz3FQJKegtHYJq1uJPZwOyXcv5Cmq3u7DKumkjlOGs0qZCVF912EKPSxYGzFxu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxZ9jnUc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724944668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCFq2W4ZuleS4SBL2SFUyPZdrtJSes9573ALK3euMC0=;
	b=TxZ9jnUcDnOhpyzZO7ka7A4KOj+RAwSEDxTCvSpE7hArn2M+R+PYqZRYn97qSZ4XyYPONq
	BnF/RYJ8DUKMcOU+T02H4WO0u4EdQBE8knoVg/k8bP2kEeQStSzoLXTp5AAIiQ92UNByVK
	sJfRqF9P/R6bR9eXrHariZLKGrtrPrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-a_ugSsnZNxmcDd08nB3tMw-1; Thu,
 29 Aug 2024 11:17:44 -0400
X-MC-Unique: a_ugSsnZNxmcDd08nB3tMw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80B031955F03;
	Thu, 29 Aug 2024 15:17:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D93723001FE8;
	Thu, 29 Aug 2024 15:17:35 +0000 (UTC)
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
Subject: [PATCH v5 net-next 03/12] net-shapers: implement NL set and delete operations
Date: Thu, 29 Aug 2024 17:16:56 +0200
Message-ID: <fcf4c258f606837cac72bb26cd751bb619e9ff87.1724944117.git.pabeni@redhat.com>
In-Reply-To: <cover.1724944116.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Both NL operations directly map on the homonymous device shaper
callbacks, update accordingly the shapers cache and are serialized
via a per device lock.
Implement the cache modification helpers to additionally deal with
NODE scope shaper. That will be needed by the group() operation
implemented in the next patch.
The delete implementation is partial: does not handle NODE scope
shaper yet. Such support will require infrastructure from
ithe next patch and will be implemented later in the series.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - replace net_device * with binding* in most helpers
 - move check for scope NONE handle at parse time and leverage
   NL_SET_BAD_ATTR()
 - move the default parent initialization to net_shaper_parse_info_nest()

v3 -> v4:
 - add locking
 - helper rename

RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 398 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 395 insertions(+), 3 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 2ed80df25765..a58bdd2ec013 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -23,6 +23,10 @@
 
 struct net_shaper_data {
 	struct xarray shapers;
+
+	/* Serialize write ops and protects node_ids updates. */
+	struct mutex lock;
+	struct idr node_ids;
 };
 
 struct net_shaper_nl_ctx {
@@ -47,6 +51,27 @@ net_shaper_binding_data(struct net_shaper_binding *binding)
 	return NULL;
 }
 
+static struct net_shaper_data *
+net_shaper_binding_set_data(struct net_shaper_binding *binding,
+			    struct net_shaper_data *data)
+{
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		return cmpxchg(&binding->netdev->net_shaper_data, NULL, data);
+
+	/* No devlink implementation yet.*/
+	return NULL;
+}
+
+static const struct net_shaper_ops *
+net_shaper_binding_ops(struct net_shaper_binding *binding)
+{
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		return binding->netdev->netdev_ops->net_shaper_ops;
+
+	/* No devlink implementation yet.*/
+	return NULL;
+}
+
 static int net_shaper_fill_binding(struct sk_buff *msg,
 				   const struct net_shaper_binding *binding,
 				   u32 type)
@@ -178,6 +203,26 @@ static void net_shaper_index_to_handle(u32 index,
 	handle->id = FIELD_GET(NET_SHAPER_ID_MASK, index);
 }
 
+static void net_shaper_default_parent(const struct net_shaper_handle *handle,
+				      struct net_shaper_handle *parent)
+{
+	switch (handle->scope) {
+	case NET_SHAPER_SCOPE_UNSPEC:
+	case NET_SHAPER_SCOPE_NETDEV:
+	case __NET_SHAPER_SCOPE_MAX:
+		parent->scope = NET_SHAPER_SCOPE_UNSPEC;
+		break;
+
+	case NET_SHAPER_SCOPE_QUEUE:
+	case NET_SHAPER_SCOPE_NODE:
+		parent->scope = NET_SHAPER_SCOPE_NETDEV;
+		break;
+	}
+	parent->id = 0;
+}
+
+#define NET_SHAPER_CACHE_NOT_VALID XA_MARK_0
+
 /* Lookup the given shaper inside the cache. */
 static struct net_shaper_info *
 net_shaper_cache_lookup(struct net_shaper_binding *binding,
@@ -186,7 +231,132 @@ net_shaper_cache_lookup(struct net_shaper_binding *binding,
 	struct net_shaper_data *data = net_shaper_binding_data(binding);
 	u32 index = net_shaper_handle_to_index(handle);
 
-	return data ? xa_load(&data->shapers, index) : NULL;
+	if (!data || xa_get_mark(&data->shapers, index,
+				 NET_SHAPER_CACHE_NOT_VALID))
+		return NULL;
+
+	return xa_load(&data->shapers, index);
+}
+
+/* Allocate on demand the per device shaper's cache. */
+static struct net_shaper_data *
+net_shaper_cache_init(struct net_shaper_binding *binding,
+		      struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *new, *data = net_shaper_binding_data(binding);
+
+	if (!data) {
+		new = kmalloc(sizeof(*data), GFP_KERNEL);
+		if (!new) {
+			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");
+			return NULL;
+		}
+
+		mutex_init(&new->lock);
+		xa_init(&new->shapers);
+		idr_init(&new->node_ids);
+
+		/* No lock acquired yet, we can race with other operations. */
+		data = net_shaper_binding_set_data(binding, new);
+		if (!data)
+			data = new;
+		else
+			kfree(new);
+	}
+	return data;
+}
+
+/* Prepare the cache to actually insert the given shaper, doing
+ * in advance the needed allocations.
+ */
+static int net_shaper_cache_pre_insert(struct net_shaper_binding *binding,
+				       struct net_shaper_handle *handle,
+				       struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_info *prev, *cur;
+	bool id_allocated = false;
+	int ret, id, index;
+
+	if (!data)
+		return -ENOMEM;
+
+	index = net_shaper_handle_to_index(handle);
+	cur = xa_load(&data->shapers, index);
+	if (cur)
+		return 0;
+
+	/* Allocated a new id, if needed. */
+	if (handle->scope == NET_SHAPER_SCOPE_NODE &&
+	    handle->id == NET_SHAPER_ID_UNSPEC) {
+		id = idr_alloc(&data->node_ids, NULL,
+			       0, NET_SHAPER_ID_UNSPEC, GFP_ATOMIC);
+
+		if (id < 0) {
+			NL_SET_ERR_MSG(extack, "Can't allocate new id for NODE shaper");
+			return id;
+		}
+
+		handle->id = id;
+		index = net_shaper_handle_to_index(handle);
+		id_allocated = true;
+	}
+
+	cur = kmalloc(sizeof(*cur), GFP_KERNEL | __GFP_ZERO);
+	if (!cur) {
+		NL_SET_ERR_MSG(extack, "Can't allocate memory for cached shaper");
+		ret = -ENOMEM;
+		goto free_id;
+	}
+
+	/* Mark 'tentative' shaper inside the cache. */
+	xa_lock(&data->shapers);
+	prev = __xa_store(&data->shapers, index, cur, GFP_KERNEL);
+	__xa_set_mark(&data->shapers, index, NET_SHAPER_CACHE_NOT_VALID);
+	xa_unlock(&data->shapers);
+	if (xa_err(prev)) {
+		NL_SET_ERR_MSG(extack, "Can't insert shaper into cache");
+		kfree(cur);
+		ret = xa_err(prev);
+		goto free_id;
+	}
+	return 0;
+
+free_id:
+	if (id_allocated)
+		idr_remove(&data->node_ids, handle->id);
+	return ret;
+}
+
+/* Commit the tentative insert with the actual values.
+ * Must be called only after a successful net_shaper_pre_insert().
+ */
+static void net_shaper_cache_commit(struct net_shaper_binding *binding,
+				    int nr_shapers,
+				    const struct net_shaper_handle *handle,
+				    const struct net_shaper_info *shapers)
+{
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_info *cur;
+	int index;
+	int i;
+
+	xa_lock(&data->shapers);
+	for (i = 0; i < nr_shapers; ++i) {
+		index = net_shaper_handle_to_index(&handle[i]);
+
+		cur = xa_load(&data->shapers, index);
+		if (WARN_ON_ONCE(!cur))
+			continue;
+
+		/* Successful update: drop the tentative mark
+		 * and update the cache.
+		 */
+		__xa_clear_mark(&data->shapers, index,
+				NET_SHAPER_CACHE_NOT_VALID);
+		*cur = shapers[i];
+	}
+	xa_unlock(&data->shapers);
 }
 
 static int net_shaper_parse_handle(const struct nlattr *attr,
@@ -227,6 +397,85 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	return 0;
 }
 
+static int net_shaper_parse_info(struct net_shaper_binding *binding,
+				 struct nlattr **tb,
+				 const struct genl_info *info,
+				 struct net_shaper_handle *handle,
+				 struct net_shaper_info *shaper,
+				 bool *cached)
+{
+	struct net_shaper_info *old;
+	int ret;
+
+	/* The shaper handle is the only mandatory attribute. */
+	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = net_shaper_parse_handle(tb[NET_SHAPER_A_HANDLE], info, handle);
+	if (ret)
+		return ret;
+
+	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC) {
+		NL_SET_BAD_ATTR(info->extack,
+				info->attrs[NET_SHAPER_A_HANDLE]);
+		return -EINVAL;
+	}
+
+	/* Fetch existing data, if any, so that user provide info will
+	 * incrementally update the existing shaper configuration.
+	 */
+	old = net_shaper_cache_lookup(binding, handle);
+	if (old)
+		*shaper = *old;
+	*cached = !!old;
+
+	if (tb[NET_SHAPER_A_METRIC])
+		shaper->metric = nla_get_u32(tb[NET_SHAPER_A_METRIC]);
+
+	if (tb[NET_SHAPER_A_BW_MIN])
+		shaper->bw_min = nla_get_uint(tb[NET_SHAPER_A_BW_MIN]);
+
+	if (tb[NET_SHAPER_A_BW_MAX])
+		shaper->bw_max = nla_get_uint(tb[NET_SHAPER_A_BW_MAX]);
+
+	if (tb[NET_SHAPER_A_BURST])
+		shaper->burst = nla_get_uint(tb[NET_SHAPER_A_BURST]);
+
+	if (tb[NET_SHAPER_A_PRIORITY])
+		shaper->priority = nla_get_u32(tb[NET_SHAPER_A_PRIORITY]);
+
+	if (tb[NET_SHAPER_A_WEIGHT])
+		shaper->weight = nla_get_u32(tb[NET_SHAPER_A_WEIGHT]);
+	return 0;
+}
+
+/* Fetch the cached shaper info and update them with the user-provided
+ * attributes.
+ */
+static int net_shaper_parse_info_nest(struct net_shaper_binding *binding,
+				      const struct nlattr *attr,
+				      const struct genl_info *info,
+				      struct net_shaper_handle *handle,
+				      struct net_shaper_info *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
+	bool cached;
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
+			       net_shaper_info_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	ret = net_shaper_parse_info(binding, tb, info, handle, shaper, &cached);
+	if (ret < 0)
+		return ret;
+
+	if (!cached)
+		net_shaper_default_parent(handle, &shaper->parent);
+	return 0;
+}
+
 static int net_shaper_generic_pre(struct genl_info *info, int type)
 {
 	struct net_shaper_nl_ctx *ctx;
@@ -358,14 +607,153 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	return 0;
 }
 
+/* Update the H/W and on success update the local cache, too. */
+static int net_shaper_set(struct net_shaper_binding *binding,
+			  const struct net_shaper_handle *h,
+			  const struct net_shaper_info *shaper,
+			  struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *data = net_shaper_cache_init(binding, extack);
+	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
+	struct net_shaper_handle handle = *h;
+	int ret;
+
+	if (!data)
+		return -ENOMEM;
+
+	/* Should never happen: binding lookup validates the ops presence */
+	if (WARN_ON_ONCE(!ops))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&data->lock);
+	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
+	    net_shaper_cache_lookup(binding, &handle)) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = net_shaper_cache_pre_insert(binding, &handle, extack);
+	if (ret)
+		goto unlock;
+
+	ret = ops->set(binding, &handle, shaper, extack);
+	net_shaper_cache_commit(binding, 1, &handle, shaper);
+
+unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_binding *binding;
+	struct net_shaper_handle handle;
+	struct net_shaper_info shaper;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
+		return -EINVAL;
+
+	binding = net_shaper_binding_from_ctx(info->user_ptr[0]);
+	attr = info->attrs[NET_SHAPER_A_SHAPER];
+	ret = net_shaper_parse_info_nest(binding, attr, info, &handle,
+					 &shaper);
+	if (ret)
+		return ret;
+
+	return net_shaper_set(binding, &handle, &shaper, info->extack);
+}
+
+static int __net_shaper_delete(struct net_shaper_binding *binding,
+			       const struct net_shaper_handle *h,
+			       struct net_shaper_info *shaper,
+			       struct netlink_ext_ack *extack)
+{
+	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_handle parent_handle, handle = *h;
+	int ret;
+
+	/* Should never happen: we are under the cache lock, the cache
+	 * is already initialized.
+	 */
+	if (WARN_ON_ONCE(!data || !ops))
+		return -EINVAL;
+
+again:
+	parent_handle = shaper->parent;
+
+	ret = ops->delete(binding, &handle, extack);
+	if (ret < 0)
+		return ret;
+
+	xa_erase(&data->shapers, net_shaper_handle_to_index(&handle));
+	if (handle.scope == NET_SHAPER_SCOPE_NODE)
+		idr_remove(&data->node_ids, handle.id);
+	kfree(shaper);
+
+	/* Eventually delete the parent, if it is left over with no leaves. */
+	if (parent_handle.scope == NET_SHAPER_SCOPE_NODE) {
+		shaper = net_shaper_cache_lookup(binding, &parent_handle);
+		if (shaper && !--shaper->leaves) {
+			handle = parent_handle;
+			goto again;
+		}
+	}
+	return 0;
+}
+
+static int net_shaper_delete(struct net_shaper_binding *binding,
+			     const struct net_shaper_handle *handle,
+			     struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *data = net_shaper_binding_data(binding);
+	struct net_shaper_info *shaper;
+	int ret;
+
+	/* The lock is null when the cache is not initialized, and thus
+	 * no shaper has been created yet.
+	 */
+	if (!data)
+		return -ENOENT;
+
+	mutex_lock(&data->lock);
+	shaper = net_shaper_cache_lookup(binding, handle);
+	if (!shaper) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (handle->scope == NET_SHAPER_SCOPE_NODE) {
+		/* TODO: implement support for scope NODE delete. */
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = __net_shaper_delete(binding, handle, shaper, extack);
+
+unlock:
+	mutex_unlock(&data->lock);
+	return ret;
 }
 
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_binding *binding;
+	struct net_shaper_handle handle;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	binding = net_shaper_binding_from_ctx(info->user_ptr[0]);
+	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
+				      &handle);
+	if (ret)
+		return ret;
+
+	return net_shaper_delete(binding, &handle, info->extack);
 }
 
 static void net_shaper_flush(struct net_shaper_binding *binding)
@@ -377,12 +765,16 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!data)
 		return;
 
+	mutex_lock(&data->lock);
 	xa_lock(&data->shapers);
 	xa_for_each(&data->shapers, index, cur) {
 		__xa_erase(&data->shapers, index);
 		kfree(cur);
 	}
 	xa_unlock(&data->shapers);
+	idr_destroy(&data->node_ids);
+	mutex_unlock(&data->lock);
+
 	kfree(data);
 }
 
-- 
2.45.2


