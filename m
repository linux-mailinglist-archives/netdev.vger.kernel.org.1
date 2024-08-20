Return-Path: <netdev+bounces-120242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FFD958AD1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3931C21AB4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762D1922C7;
	Tue, 20 Aug 2024 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF9xAWJ1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F73191F89
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166800; cv=none; b=mUnivML5k6WPLgE0k79VmjvO+RjnDzQzCDe4LNIVYav3+qhEHK0LTCAa+E0aWZsIcPQ1MRQfjoSbzbcaCd8uRDQfjtzzdTmu4/4PwRN3A1dxaD6HrcGyncYIOz2wzgbsHy+MbVCmw8hyVcpv1skH9vyX3OHFPnCjbDwgocDUfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166800; c=relaxed/simple;
	bh=BYfCOgZzlmVpmUfz3yc9rYzaa3aq4oRdBPXU2qtMwa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js+7YTbmG0UwbkVU9T/cH6U7Q+wIKDA4xbd8trnL1hX+lQ9nmJXHOAYCXBDbnO2tkr2wcHp6zlNGRfXxo6nI4uONbARCGjAXngcndTDWIRZcvSzv6crvkuFurw3hm9RQs8jIRHUI6SeOKovI1q2HPdRxJorsKiBArBRwG//MnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZF9xAWJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nl/vL7MrJ8N4J8ajUTvGh5lfLzfjzn7Eg2qb2d+od3Q=;
	b=ZF9xAWJ15lzpjqG+frpWSZnn/ihvX3iYU5Vs4xEqri7Iq5yZhiNdVIJrLdcK95CjWHL3f1
	wMiiNlnfH432KFmS2IA2WnMREV89AxXAo8DIvXQwQHzfrRTK7L2QL6nSE5bcSNIfrLtYAL
	46Rnv7Wy9klfceCGS8c72r6gadvrPbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122--7d_7OsUPFmhzMsOKKeEVg-1; Tue,
 20 Aug 2024 11:13:14 -0400
X-MC-Unique: -7d_7OsUPFmhzMsOKKeEVg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463D71955BF8;
	Tue, 20 Aug 2024 15:13:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB55919560AD;
	Tue, 20 Aug 2024 15:13:07 +0000 (UTC)
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
Subject: [PATCH v4 net-next 04/12] net-shapers: implement NL set and delete operations
Date: Tue, 20 Aug 2024 17:12:25 +0200
Message-ID: <4f59482b9ad98517e83e1e6bd8add7c38bb4bdb3.1724165948.git.pabeni@redhat.com>
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
v3 -> v3:
 - add locking
 - helper rename

RFC v2 -> RFC v3:
 - dev_put() -> netdev_put()
---
 net/shaper/shaper.c | 363 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 359 insertions(+), 4 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 723f0c5ec479..055fda39176b 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -22,6 +22,10 @@
 
 struct net_shaper_data {
 	struct xarray shapers;
+
+	/* Serialize write ops and protects node_ids updates. */
+	struct mutex lock;
+	struct idr node_ids;
 };
 
 struct net_shaper_nl_ctx {
@@ -137,6 +141,26 @@ static void net_shaper_index_to_handle(u32 index,
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
 static struct xarray *net_shaper_cache_container(struct net_device *dev)
 {
 	/* The barrier pairs with cmpxchg on init. */
@@ -145,6 +169,11 @@ static struct xarray *net_shaper_cache_container(struct net_device *dev)
 	return data ? &data->shapers : NULL;
 }
 
+static struct mutex *net_shaper_cache_lock(struct net_device *dev)
+{
+	return dev->net_shaper_data ? &dev->net_shaper_data->lock : NULL;
+}
+
 /* Lookup the given shaper inside the cache. */
 static struct net_shaper_info *
 net_shaper_cache_lookup(struct net_device *dev,
@@ -153,7 +182,128 @@ net_shaper_cache_lookup(struct net_device *dev,
 	struct xarray *xa = net_shaper_cache_container(dev);
 	u32 index = net_shaper_handle_to_index(handle);
 
-	return xa ? xa_load(xa, index) : NULL;
+	if (!xa || xa_get_mark(xa, index, NET_SHAPER_CACHE_NOT_VALID))
+		return NULL;
+
+	return xa_load(xa, index);
+}
+
+/* Allocate on demand the per device shaper's cache. */
+static struct mutex *net_shaper_cache_init(struct net_device *dev,
+					   struct netlink_ext_ack *extack)
+{
+	struct net_shaper_data *new, *data = READ_ONCE(dev->net_shaper_data);
+
+	if (!data) {
+		new = kmalloc(sizeof(*dev->net_shaper_data), GFP_KERNEL);
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
+		data = cmpxchg(&dev->net_shaper_data, NULL, new);
+		if (!data)
+			data = new;
+		else
+			kfree(new);
+	}
+	return &data->lock;
+}
+
+/* Prepare the cache to actually insert the given shaper, doing
+ * in advance the needed allocations.
+ */
+static int net_shaper_cache_pre_insert(struct net_device *dev,
+				       struct net_shaper_handle *handle,
+				       struct netlink_ext_ack *extack)
+{
+	struct xarray *xa = net_shaper_cache_container(dev);
+	struct net_shaper_info *prev, *cur;
+	bool id_allocated = false;
+	int ret, id, index;
+
+	if (!xa)
+		return -ENOMEM;
+
+	index = net_shaper_handle_to_index(handle);
+	cur = xa_load(xa, index);
+	if (cur)
+		return 0;
+
+	/* Allocated a new id, if needed. */
+	if (handle->scope == NET_SHAPER_SCOPE_NODE &&
+	    handle->id == NET_SHAPER_ID_UNSPEC) {
+		id = idr_alloc(&dev->net_shaper_data->node_ids, NULL,
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
+	xa_lock(xa);
+	prev = __xa_store(xa, index, cur, GFP_KERNEL);
+	__xa_set_mark(xa, index, NET_SHAPER_CACHE_NOT_VALID);
+	xa_unlock(xa);
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
+		idr_remove(&dev->net_shaper_data->node_ids, handle->id);
+	return ret;
+}
+
+/* Commit the tentative insert with the actual values.
+ * Must be called only after a successful net_shaper_pre_insert().
+ */
+static void net_shaper_cache_commit(struct net_device *dev, int nr_shapers,
+				    const struct net_shaper_handle *handle,
+				    const struct net_shaper_info *shapers)
+{
+	struct xarray *xa = net_shaper_cache_container(dev);
+	struct net_shaper_info *cur;
+	int index;
+	int i;
+
+	xa_lock(xa);
+	for (i = 0; i < nr_shapers; ++i) {
+		index = net_shaper_handle_to_index(&handle[i]);
+
+		cur = xa_load(xa, index);
+		if (WARN_ON_ONCE(!cur))
+			continue;
+
+		/* Successful update: drop the tentative mark
+		 * and update the cache.
+		 */
+		__xa_clear_mark(xa, index, NET_SHAPER_CACHE_NOT_VALID);
+		*cur = shapers[i];
+	}
+	xa_unlock(xa);
 }
 
 static int net_shaper_parse_handle(const struct nlattr *attr,
@@ -193,6 +343,71 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	return 0;
 }
 
+static int net_shaper_parse_info(struct net_device *dev, struct nlattr **tb,
+				 const struct genl_info *info,
+				 struct net_shaper_handle *handle,
+				 struct net_shaper_info *shaper)
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
+	/* Fetch existing data, if any, so that user provide info will
+	 * incrementally update the existing shaper configuration.
+	 */
+	old = net_shaper_cache_lookup(dev, handle);
+	if (old)
+		*shaper = *old;
+	else
+		net_shaper_default_parent(handle, &shaper->parent);
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
+static int net_shaper_parse_info_nest(struct net_device *dev,
+				      const struct nlattr *attr,
+				      const struct genl_info *info,
+				      struct net_shaper_handle *handle,
+				      struct net_shaper_info *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
+			       net_shaper_info_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	return net_shaper_parse_info(dev, tb, info, handle, shaper);
+}
+
 int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
 			   struct sk_buff *skb, struct genl_info *info)
 {
@@ -295,14 +510,149 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/* Update the H/W and on success update the local cache, too. */
+static int net_shaper_set(struct net_device *dev,
+			  const struct net_shaper_handle *h,
+			  const struct net_shaper_info *shaper,
+			  struct netlink_ext_ack *extack)
+{
+	struct mutex *lock = net_shaper_cache_init(dev, extack);
+	struct net_shaper_handle handle = *h;
+	int ret;
+
+	if (!lock)
+		return -ENOMEM;
+
+	if (handle.scope == NET_SHAPER_SCOPE_UNSPEC) {
+		NL_SET_ERR_MSG_FMT(extack, "Can't set shaper with unspec scope");
+		return -EINVAL;
+	}
+
+	mutex_lock(lock);
+	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
+	    net_shaper_cache_lookup(dev, &handle)) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	ret = net_shaper_cache_pre_insert(dev, &handle, extack);
+	if (ret)
+		goto unlock;
+
+	ret = dev->netdev_ops->net_shaper_ops->set(dev, &handle, shaper, extack);
+	net_shaper_cache_commit(dev, 1, &handle, shaper);
+
+unlock:
+	mutex_unlock(lock);
+	return ret;
+}
+
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev = info->user_ptr[0];
+	struct net_shaper_handle handle;
+	struct net_shaper_info shaper;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
+		return -EINVAL;
+
+	attr = info->attrs[NET_SHAPER_A_SHAPER];
+	ret = net_shaper_parse_info_nest(dev, attr, info, &handle, &shaper);
+	if (ret)
+		return ret;
+
+	return net_shaper_set(dev, &handle, &shaper, info->extack);
+}
+
+static int __net_shaper_delete(struct net_device *dev,
+			       const struct net_shaper_handle *h,
+			       struct net_shaper_info *shaper,
+			       struct netlink_ext_ack *extack)
+{
+	struct net_shaper_handle parent_handle, handle = *h;
+	struct xarray *xa = net_shaper_cache_container(dev);
+	int ret;
+
+	/* Should never happen: we are under the cache lock, the cache
+	 * is already initialized.
+	 */
+	if (WARN_ON_ONCE(!xa))
+		return -EINVAL;
+
+again:
+	parent_handle = shaper->parent;
+
+	ret = dev->netdev_ops->net_shaper_ops->delete(dev, &handle, extack);
+	if (ret < 0)
+		return ret;
+
+	xa_erase(xa, net_shaper_handle_to_index(&handle));
+	if (handle.scope == NET_SHAPER_SCOPE_NODE)
+		idr_remove(&dev->net_shaper_data->node_ids, handle.id);
+	kfree(shaper);
+
+	/* Eventually delete the parent, if it is left over with no leaves. */
+	if (parent_handle.scope == NET_SHAPER_SCOPE_NODE) {
+		shaper = net_shaper_cache_lookup(dev, &parent_handle);
+		if (shaper && !--shaper->leaves) {
+			handle = parent_handle;
+			goto again;
+		}
+	}
+	return 0;
+}
+
+static int net_shaper_delete(struct net_device *dev,
+			     const struct net_shaper_handle *handle,
+			     struct netlink_ext_ack *extack)
+{
+	struct mutex *lock = net_shaper_cache_lock(dev);
+	struct net_shaper_info *shaper;
+	int ret;
+
+	/* The lock is null when the cache is not initialized, and thus
+	 * no shaper has been created yet.
+	 */
+	if (!lock)
+		return -ENOENT;
+
+	mutex_lock(lock);
+	shaper = net_shaper_cache_lookup(dev, handle);
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
+	ret = __net_shaper_delete(dev, handle, shaper, extack);
+
+unlock:
+	mutex_unlock(lock);
+	return ret;
 }
 
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev = info->user_ptr[0];
+	struct net_shaper_handle handle;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info,
+				      &handle);
+	if (ret)
+		return ret;
+
+	return net_shaper_delete(dev, &handle, info->extack);
 }
 
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
@@ -313,18 +663,23 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
 void net_shaper_flush(struct net_device *dev)
 {
 	struct xarray *xa = net_shaper_cache_container(dev);
+	struct mutex *lock = net_shaper_cache_lock(dev);
 	struct net_shaper_info *cur;
 	unsigned long index;
 
-	if (!xa)
+	if (!xa || !lock)
 		return;
 
+	mutex_lock(lock);
 	xa_lock(xa);
 	xa_for_each(xa, index, cur) {
 		__xa_erase(xa, index);
 		kfree(cur);
 	}
 	xa_unlock(xa);
+	idr_destroy(&dev->net_shaper_data->node_ids);
+	mutex_unlock(lock);
+
 	kfree(dev->net_shaper_data);
 }
 
-- 
2.45.2


