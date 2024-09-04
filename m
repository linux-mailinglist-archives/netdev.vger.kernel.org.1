Return-Path: <netdev+bounces-125112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B035F96BF61
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDD0B23AF4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288871DC19B;
	Wed,  4 Sep 2024 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGzfZiVW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5431DC183
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458231; cv=none; b=GMrx8wwsM8Rs35ucsAUz8kEMXQC0iFvqivW9uVtF213nAeXRiJQWWOsyuWMBNGsBHLbeCmhbGFkp8Nby+Bgzfa3CpfjmzyCJdKDTmH9xTvguxeQfh+3f9gmB8VN/wNtjrMr8uBeFHiXyxaEZvIosvc9bEmcCHIdSKQL2uGce1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458231; c=relaxed/simple;
	bh=a7NB/jdtZ2QYlZ4nRJssYhSrXVqlW3Vw4mDclRt2NLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQPZUFtOl/KIaDuMgCkcL1JaMsEZl9sEhoVIA/eprNvuG663czoy5LJLOYgvK2y5C7fUP3M4JUZ9U/0YjSgjiTr8ACn3DJFL7ym2TtbFusfMERCEe5YrFVnj2aKOM57Gb5vpA2Z9LArfUgNrj/+AqaiwJuVMuCTyvF1Op9X3IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGzfZiVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkgSho2EE7C/UqkqPqhMvsZCkRVM/sLG4mK61upMSOg=;
	b=VGzfZiVWjEk2PdTRqLxRSSjovqQ7KMl/PXX/Mr5Pw9yQDsoq7qR5RtWtCnlwz2hlF66kcB
	eW6y088oQJXumjh4rdC3u+QmugwaECJWOfJ67txGJZqLKiGutlw0lc4MOUWhB8Y5MiPkM4
	FxCqcXZxpJkmAdCOoB7uvUiw7ztp3mw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-a8rZ9EyKNL6HTQ8ZWpBAnA-1; Wed,
 04 Sep 2024 09:57:04 -0400
X-MC-Unique: a8rZ9EyKNL6HTQ8ZWpBAnA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00875195422C;
	Wed,  4 Sep 2024 13:57:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 463FE1956088;
	Wed,  4 Sep 2024 13:56:56 +0000 (UTC)
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
Subject: [PATCH v6 net-next 04/15] net-shapers: implement NL set and delete operations
Date: Wed,  4 Sep 2024 15:53:36 +0200
Message-ID: <66b6e936d93ec71d989c1181b6d22c537faa4abc.1725457317.git.pabeni@redhat.com>
In-Reply-To: <cover.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Both NL operations directly map on the homonymous device shaper
callbacks, update accordingly the shapers cache and are serialized
via a per device lock.
Implement the cache modification helpers to additionally deal with
NODE scope shaper. That will be needed by the group() operation
implemented in the next patch.
The delete implementation is partial: does not handle NODE scope
shaper yet. Such support will require infrastructure from
the next patch and will be implemented later in the series.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v5 -> v6:
 - use xa_alloc() instead idr
 - rcu protection on shaper free
 - drop NL_SET_ERR_MSG() on allocation failures
 - net_shaper_cache_init() -> net_shaper_hierarchy_setup()
 - net_shaper_cache_{pre_insert,commit} -> net_shaper_{pre_insert,commit}
 - fix BAD_ADDR handle in net_shaper_parse_info()

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
 net/shaper/shaper.c | 403 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 401 insertions(+), 2 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 2d72f9112f23..8d6f3c5829b0 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -36,6 +36,24 @@ static struct net_shaper_binding *net_shaper_binding_from_ctx(void *ctx)
 	return &((struct net_shaper_nl_ctx *)ctx)->binding;
 }
 
+static void net_shaper_lock(struct net_shaper_binding *binding)
+{
+	switch (binding->type) {
+	case NET_SHAPER_BINDING_TYPE_NETDEV:
+		mutex_lock(&binding->netdev->lock);
+		break;
+	}
+}
+
+static void net_shaper_unlock(struct net_shaper_binding *binding)
+{
+	switch (binding->type) {
+	case NET_SHAPER_BINDING_TYPE_NETDEV:
+		mutex_unlock(&binding->netdev->lock);
+		break;
+	}
+}
+
 static struct net_shaper_hierarchy *
 net_shaper_hierarchy(struct net_shaper_binding *binding)
 {
@@ -47,6 +65,16 @@ net_shaper_hierarchy(struct net_shaper_binding *binding)
 	return NULL;
 }
 
+static const struct net_shaper_ops *
+net_shaper_ops(struct net_shaper_binding *binding)
+{
+	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
+		return binding->netdev->netdev_ops->net_shaper_ops;
+
+	/* No other type supported yet. */
+	return NULL;
+}
+
 static int net_shaper_fill_binding(struct sk_buff *msg,
 				   const struct net_shaper_binding *binding,
 				   u32 type)
@@ -171,6 +199,37 @@ static u32 net_shaper_handle_to_index(const struct net_shaper_handle *handle)
 		FIELD_PREP(NET_SHAPER_ID_MASK, handle->id);
 }
 
+static void net_shaper_index_to_handle(u32 index,
+				       struct net_shaper_handle *handle)
+{
+	handle->scope = FIELD_GET(NET_SHAPER_SCOPE_MASK, index);
+	handle->id = FIELD_GET(NET_SHAPER_ID_MASK, index);
+}
+
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
+/*
+ * MARK_0 is already in use due to XA_FLAGS_ALLOC, can't reuse such flag as
+ * it's cleared by xa_store().
+ */
+#define NET_SHAPER_NOT_VALID XA_MARK_1
+
 static struct net_shaper *
 net_shaper_lookup(struct net_shaper_binding *binding,
 		  const struct net_shaper_handle *handle)
@@ -179,6 +238,135 @@ net_shaper_lookup(struct net_shaper_binding *binding,
 	u32 index = net_shaper_handle_to_index(handle);
 
 	return hierarchy ? xa_load(&hierarchy->shapers, index) : NULL;
+	if (!hierarchy || xa_get_mark(&hierarchy->shapers, index,
+				      NET_SHAPER_NOT_VALID))
+		return NULL;
+
+	return xa_load(&hierarchy->shapers, index);
+}
+
+/* Allocate on demand the per device shaper's hierarchy container.
+ * Called under the net shaper lock
+ */
+static struct net_shaper_hierarchy *
+net_shaper_hierarchy_setup(struct net_shaper_binding *binding)
+{
+	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
+
+	if (hierarchy)
+		return hierarchy;
+
+	hierarchy = kmalloc(sizeof(*hierarchy), GFP_KERNEL);
+	if (!hierarchy)
+		return NULL;
+
+	/* The flag is required for ID allocation */
+	xa_init_flags(&hierarchy->shapers, XA_FLAGS_ALLOC);
+
+	switch (binding->type) {
+	case NET_SHAPER_BINDING_TYPE_NETDEV:
+		/* Pairs with READ_ONCE in net_shaper_hierarchy. */
+		WRITE_ONCE(binding->netdev->net_shaper_hierarchy, hierarchy);
+		break;
+	}
+	return hierarchy;
+}
+
+/* Prepare the hierarchy container to actually insert the given shaper, doing
+ * in advance the needed allocations.
+ */
+static int net_shaper_pre_insert(struct net_shaper_binding *binding,
+				 struct net_shaper_handle *handle,
+				 struct netlink_ext_ack *extack)
+{
+	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
+	struct net_shaper *prev, *cur;
+	bool id_allocated = false;
+	int ret, index;
+
+	if (!hierarchy)
+		return -ENOMEM;
+
+	index = net_shaper_handle_to_index(handle);
+	cur = xa_load(&hierarchy->shapers, index);
+	if (cur)
+		return 0;
+
+	/* Allocated a new id, if needed. */
+	if (handle->scope == NET_SHAPER_SCOPE_NODE &&
+	    handle->id == NET_SHAPER_ID_UNSPEC) {
+		u32 min, max;
+
+		handle->id = NET_SHAPER_ID_MASK - 1;
+		max = net_shaper_handle_to_index(handle);
+		handle->id = 0;
+		min = net_shaper_handle_to_index(handle);
+
+		ret = xa_alloc(&hierarchy->shapers, &index, NULL,
+			       XA_LIMIT(min, max), GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Can't allocate new id for NODE shaper");
+			return ret;
+		}
+
+		net_shaper_index_to_handle(index, handle);
+		id_allocated = true;
+	}
+
+	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
+	if (!cur) {
+		ret = -ENOMEM;
+		goto free_id;
+	}
+
+	/* Mark 'tentative' shaper inside the hierarchy container.
+	 * xa_set_mark is a no-op if the previous store fails.
+	 */
+	xa_lock(&hierarchy->shapers);
+	prev = __xa_store(&hierarchy->shapers, index, cur, GFP_KERNEL);
+	__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_NOT_VALID);
+	xa_unlock(&hierarchy->shapers);
+	if (xa_err(prev)) {
+		NL_SET_ERR_MSG(extack, "Can't insert shaper into device store");
+		kfree_rcu(cur, rcu);
+		ret = xa_err(prev);
+		goto free_id;
+	}
+	return 0;
+
+free_id:
+	if (id_allocated)
+		xa_erase(&hierarchy->shapers, index);
+	return ret;
+}
+
+/* Commit the tentative insert with the actual values.
+ * Must be called only after a successful net_shaper_pre_insert().
+ */
+static void net_shaper_commit(struct net_shaper_binding *binding,
+			      int nr_shapers, const struct net_shaper *shapers)
+{
+	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
+	struct net_shaper *cur;
+	int index;
+	int i;
+
+	xa_lock(&hierarchy->shapers);
+	for (i = 0; i < nr_shapers; ++i) {
+		index = net_shaper_handle_to_index(&shapers[i].handle);
+
+		cur = xa_load(&hierarchy->shapers, index);
+		if (WARN_ON_ONCE(!cur))
+			continue;
+
+		/* Successful update: drop the tentative mark
+		 * and update the hierarchy container.
+		 */
+		__xa_clear_mark(&hierarchy->shapers, index,
+				NET_SHAPER_NOT_VALID);
+		*cur = shapers[i];
+	}
+	xa_unlock(&hierarchy->shapers);
 }
 
 static int net_shaper_parse_handle(const struct nlattr *attr,
@@ -216,6 +404,85 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	return 0;
 }
 
+static int net_shaper_parse_info(struct net_shaper_binding *binding,
+				 struct nlattr **tb,
+				 const struct genl_info *info,
+				 struct net_shaper *shaper,
+				 bool *exists)
+{
+	struct net_shaper *old;
+	int ret;
+
+	/* The shaper handle is the only mandatory attribute. */
+	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = net_shaper_parse_handle(tb[NET_SHAPER_A_HANDLE], info,
+				      &shaper->handle);
+	if (ret)
+		return ret;
+
+	if (shaper->handle.scope == NET_SHAPER_SCOPE_UNSPEC) {
+		NL_SET_BAD_ATTR(info->extack, tb[NET_SHAPER_A_HANDLE]);
+		return -EINVAL;
+	}
+
+	/* Fetch existing hierarchy, if any, so that user provide info will
+	 * incrementally update the existing shaper configuration.
+	 */
+	rcu_read_lock();
+	old = net_shaper_lookup(binding, &shaper->handle);
+	if (old)
+		*shaper = *old;
+	*exists = !!old;
+	rcu_read_unlock();
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
+/* Fetch the existing shaper info and update them with the user-provided
+ * attributes.
+ */
+static int net_shaper_parse_info_nest(struct net_shaper_binding *binding,
+				      const struct nlattr *attr,
+				      const struct genl_info *info,
+				      struct net_shaper *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
+	bool exists;
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
+			       net_shaper_info_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	ret = net_shaper_parse_info(binding, tb, info, shaper, &exists);
+	if (ret < 0)
+		return ret;
+
+	if (!exists)
+		net_shaper_default_parent(&shaper->handle, &shaper->parent);
+	return 0;
+}
+
 static int net_shaper_generic_pre(struct genl_info *info, int type)
 {
 	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)info->ctx;
@@ -336,14 +603,143 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/* Update the H/W and on success update the hierarchy container, too. */
+static int net_shaper_set(struct net_shaper_binding *binding,
+			  const struct net_shaper *shaper,
+			  struct netlink_ext_ack *extack)
+{
+	const struct net_shaper_ops *ops = net_shaper_ops(binding);
+	struct net_shaper_handle handle = shaper->handle;
+	struct net_shaper_hierarchy *hierarchy;
+	int ret;
+
+	net_shaper_lock(binding);
+
+	hierarchy = net_shaper_hierarchy_setup(binding);
+	if (!hierarchy) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	/* The 'set' can't create node-scope shapers. */
+	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
+	    !net_shaper_lookup(binding, &handle)) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = net_shaper_pre_insert(binding, &handle, extack);
+	if (ret)
+		goto unlock;
+
+	ret = ops->set(binding, shaper, extack);
+	net_shaper_commit(binding, 1, shaper);
+
+unlock:
+	net_shaper_unlock(binding);
+	return ret;
+}
+
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_binding *binding;
+	struct net_shaper shaper;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
+		return -EINVAL;
+
+	binding = net_shaper_binding_from_ctx(info->ctx);
+	attr = info->attrs[NET_SHAPER_A_SHAPER];
+	ret = net_shaper_parse_info_nest(binding, attr, info, &shaper);
+	if (ret)
+		return ret;
+
+	return net_shaper_set(binding, &shaper, info->extack);
+}
+
+static int __net_shaper_delete(struct net_shaper_binding *binding,
+			       struct net_shaper *shaper,
+			       struct netlink_ext_ack *extack)
+{
+	struct net_shaper_hierarchy *hierarchy = net_shaper_hierarchy(binding);
+	struct net_shaper_handle parent_handle, handle = shaper->handle;
+	const struct net_shaper_ops *ops = net_shaper_ops(binding);
+	int ret;
+
+again:
+	parent_handle = shaper->parent;
+
+	ret = ops->delete(binding, &handle, extack);
+	if (ret < 0)
+		return ret;
+
+	xa_erase(&hierarchy->shapers, net_shaper_handle_to_index(&handle));
+	kfree_rcu(shaper, rcu);
+
+	/* Eventually delete the parent, if it is left over with no leaves. */
+	if (parent_handle.scope == NET_SHAPER_SCOPE_NODE) {
+		shaper = net_shaper_lookup(binding, &parent_handle);
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
+	struct net_shaper_hierarchy *hierarchy;
+	struct net_shaper *shaper;
+	int ret;
+
+	net_shaper_lock(binding);
+
+	hierarchy = net_shaper_hierarchy(binding);
+	if (!hierarchy) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	shaper = net_shaper_lookup(binding, handle);
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
+	ret = __net_shaper_delete(binding, shaper, extack);
+
+unlock:
+	net_shaper_unlock(binding);
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
+	binding = net_shaper_binding_from_ctx(info->ctx);
+	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
+				      &handle);
+	if (ret)
+		return ret;
+
+	return net_shaper_delete(binding, &handle, info->extack);
 }
 
 static void net_shaper_flush(struct net_shaper_binding *binding)
@@ -355,12 +751,15 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	if (!hierarchy)
 		return;
 
+	net_shaper_lock(binding);
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		__xa_erase(&hierarchy->shapers, index);
 		kfree(cur);
 	}
 	xa_unlock(&hierarchy->shapers);
+	net_shaper_unlock(binding);
+
 	kfree(hierarchy);
 }
 
-- 
2.45.2


