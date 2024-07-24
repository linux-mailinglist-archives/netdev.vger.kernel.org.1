Return-Path: <netdev+bounces-112846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7274593B7FE
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 22:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2771F28183C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088816C694;
	Wed, 24 Jul 2024 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9o9Kvwp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB765E20
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852742; cv=none; b=ItNBzPB6qg2urQURIM3Iysg4rFXLlDT8ib6sQJZSK/vVMOMBe3GdOMxfrlE58qjv8yIfYkBGDwo1rmTqnOlWRc/unMq7q5vuzj1nOqbWz3fxINJYQ7ay9EQDNPMZQmoDq3Gyx0/ru6XENssjftOtorIBqbi0y3DJfqaNtHUGWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852742; c=relaxed/simple;
	bh=wWuSCrr2vPSvDLVhGmXOG1Pf905qyFK7ZWISpO1H6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSHpyrjWwaj0HTjF79hz8sAwuLI8RU4Iv5qTdtW2PpzFbLEOLBPi+KGg3z2sHw7DQp64sTu+0YWUkqL3Vojzp9Sp0DyfWvdXvgLiRxtyWnJaijJLnyPS78+v/seWPNJu2PnJfvYc2r60kS02pTZ1LQgKi9i2RRjI+a+mrPQQ96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9o9Kvwp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721852739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOqIXlkCUkLKbSWJ4Coy4usxWPK8i1GrgDiz1cQH4Ws=;
	b=S9o9Kvwpq/inqygCHlB0tRkCEu/CAjOGkq6BdODv9O5yVwBXv90uAYZ8mCjihkAtfNDAKO
	Oqac0C75rOflfjP/PlB3gTI+fT9XNMAJPJUJ+61XGuAQ/6SvkmotQHD6GrYKU1c6WOum7v
	vWvNwM3AA3oWjVwgYe73lXGSLTrNJZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Poniig02O36PpByVBjwbhQ-1; Wed,
 24 Jul 2024 16:25:34 -0400
X-MC-Unique: Poniig02O36PpByVBjwbhQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2AD195608A;
	Wed, 24 Jul 2024 20:25:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CDFA19560AE;
	Wed, 24 Jul 2024 20:25:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH RFC v2 03/11] net-shapers: implement NL set and delete operations
Date: Wed, 24 Jul 2024 22:24:49 +0200
Message-ID: <b51a8dbc20d6bd68b528ccf58a049bd26e564e49.1721851988.git.pabeni@redhat.com>
In-Reply-To: <cover.1721851988.git.pabeni@redhat.com>
References: <cover.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Both NL operations directly map on the homonymous device shaper
callbacks and update accordingly the shapers cache.
Implement the cache modification helpers to additionally deal with
DETACHED scope shaper. That will be needed by the group() operation
implemented in the next patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/shaper/shaper.c | 323 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 321 insertions(+), 2 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 93dd491ac7c2..7802c9ba6d9c 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -19,6 +19,35 @@ struct net_shaper_nl_ctx {
 	u32 start_handle;
 };
 
+static u32 default_parent(u32 handle)
+{
+	enum net_shaper_scope parent, scope = net_shaper_handle_scope(handle);
+
+	switch (scope) {
+	case NET_SHAPER_SCOPE_PORT:
+	case NET_SHAPER_SCOPE_UNSPEC:
+		parent = NET_SHAPER_SCOPE_UNSPEC;
+		break;
+
+	case NET_SHAPER_SCOPE_QUEUE:
+	case NET_SHAPER_SCOPE_DETACHED:
+		parent = NET_SHAPER_SCOPE_NETDEV;
+		break;
+
+	case NET_SHAPER_SCOPE_NETDEV:
+	case NET_SHAPER_SCOPE_VF:
+		parent = NET_SHAPER_SCOPE_PORT;
+		break;
+	}
+
+	return net_shaper_make_handle(parent, 0);
+}
+
+static bool is_detached(u32 handle)
+{
+	return net_shaper_handle_scope(handle) == NET_SHAPER_SCOPE_DETACHED;
+}
+
 static int fill_handle(struct sk_buff *msg, u32 handle, u32 type,
 		       const struct genl_info *info)
 {
@@ -117,6 +146,115 @@ static struct net_shaper_info *sc_lookup(struct net_device *dev, u32 handle)
 	return xa ? xa_load(xa, handle) : NULL;
 }
 
+/* allocate on demand the per device shaper's cache */
+static struct xarray *__sc_init(struct net_device *dev,
+				struct netlink_ext_ack *extack)
+{
+	if (!dev->net_shaper_data) {
+		dev->net_shaper_data = kmalloc(sizeof(*dev->net_shaper_data),
+					       GFP_KERNEL);
+		if (!dev->net_shaper_data) {
+			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");
+			return NULL;
+		}
+
+		xa_init(&dev->net_shaper_data->shapers);
+		idr_init(&dev->net_shaper_data->detached_ids);
+	}
+	return &dev->net_shaper_data->shapers;
+}
+
+/* prepare the cache to actually insert the given shaper, doing
+ * in advance the needed allocations
+ */
+static int sc_prepare_insert(struct net_device *dev, u32 *handle,
+			     struct netlink_ext_ack *extack)
+{
+	enum net_shaper_scope scope = net_shaper_handle_scope(*handle);
+	struct xarray *xa = __sc_init(dev, extack);
+	struct net_shaper_info *prev, *cur;
+	bool id_allocated = false;
+	int ret, id;
+
+	if (!xa)
+		return -ENOMEM;
+
+	cur = xa_load(xa, *handle);
+	if (cur)
+		return 0;
+
+	/* allocated a new id, if needed */
+	if (scope == NET_SHAPER_SCOPE_DETACHED &&
+	    net_shaper_handle_id(*handle) == NET_SHAPER_ID_UNSPEC) {
+		xa_lock(xa);
+		id = idr_alloc(&dev->net_shaper_data->detached_ids, NULL,
+			       0, NET_SHAPER_ID_UNSPEC, GFP_ATOMIC);
+		xa_unlock(xa);
+
+		if (id < 0) {
+			NL_SET_ERR_MSG(extack, "Can't allocate new id for detached shaper");
+			return id;
+		}
+
+		*handle = net_shaper_make_handle(scope, id);
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
+	/* mark 'tentative' shaper inside the cache */
+	xa_lock(xa);
+	prev = __xa_store(xa, *handle, cur, GFP_KERNEL);
+	__xa_set_mark(xa, *handle, XA_MARK_0);
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
+	if (id_allocated) {
+		xa_lock(xa);
+		idr_remove(&dev->net_shaper_data->detached_ids,
+			   net_shaper_handle_id(*handle));
+		xa_unlock(xa);
+	}
+	return ret;
+}
+
+/* commit the tentative insert with the actual values.
+ * Must be called only after a successful sc_prepare_insert()
+ */
+static void sc_commit(struct net_device *dev, int nr_shapers,
+		      const struct net_shaper_info *shapers)
+{
+	struct xarray *xa = __sc_container(dev);
+	struct net_shaper_info *cur;
+	int i;
+
+	xa_lock(xa);
+	for (i = 0; i < nr_shapers; ++i) {
+		cur = xa_load(xa, shapers[i].handle);
+		if (WARN_ON_ONCE(!cur))
+			continue;
+
+		/* successful update: drop the tentative mark
+		 * and update the cache
+		 */
+		__xa_clear_mark(xa, shapers[i].handle, XA_MARK_0);
+		*cur = shapers[i];
+	}
+	xa_unlock(xa);
+}
+
 static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
 			u32 *handle)
 {
@@ -154,6 +292,68 @@ static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
 	return 0;
 }
 
+static int __parse_shaper(struct net_device *dev, struct nlattr **tb,
+			  const struct genl_info *info,
+			  struct net_shaper_info *shaper)
+{
+	struct net_shaper_info *old;
+	int ret;
+
+	/* the shaper handle is the only mandatory attribute */
+	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = parse_handle(tb[NET_SHAPER_A_HANDLE], info, &shaper->handle);
+	if (ret)
+		return ret;
+
+	/* fetch existing data, if any, so that user provide info will
+	 * incrementally update the existing shaper configuration
+	 */
+	old = sc_lookup(dev, shaper->handle);
+	if (old)
+		*shaper = *old;
+	else
+		shaper->parent = default_parent(shaper->handle);
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
+/* fetch the cached shaper info and update them with the user-provided
+ * attributes
+ */
+static int parse_shaper(struct net_device *dev, const struct nlattr *attr,
+			const struct genl_info *info,
+			struct net_shaper_info *shaper)
+{
+	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
+			       net_shaper_ns_info_nl_policy, info->extack);
+	if (ret < 0)
+		return ret;
+
+	return __parse_shaper(dev, tb, info, shaper);
+}
+
 int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_shaper_info *shaper;
@@ -239,14 +439,133 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/* Update the H/W and on success update the local cache, too */
+static int net_shaper_set(struct net_device *dev,
+			  const struct net_shaper_info *shaper,
+			  struct netlink_ext_ack *extack)
+{
+	enum net_shaper_scope scope;
+	u32 handle = shaper->handle;
+	int ret;
+
+	scope = net_shaper_handle_scope(handle);
+	if (scope == NET_SHAPER_SCOPE_PORT ||
+	    scope == NET_SHAPER_SCOPE_UNSPEC) {
+		NL_SET_ERR_MSG_FMT(extack, "Can't set shaper %x with scope %d",
+				   handle, scope);
+		return -EINVAL;
+	}
+	if (scope == NET_SHAPER_SCOPE_DETACHED && !sc_lookup(dev, handle)) {
+		NL_SET_ERR_MSG_FMT(extack, "Shaper %x with detached scope does not exist",
+				   handle);
+		return -EINVAL;
+	}
+
+	ret = sc_prepare_insert(dev, &handle, extack);
+	if (ret)
+		return ret;
+
+	ret = dev->netdev_ops->net_shaper_ops->set(dev, shaper, extack);
+	sc_commit(dev, 1, shaper);
+	return ret;
+}
+
 int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_shaper_info shaper;
+	struct net_device *dev;
+	struct nlattr *attr;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
+		return -EINVAL;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	attr = info->attrs[NET_SHAPER_A_SHAPER];
+	ret = parse_shaper(dev, attr, info, &shaper);
+	if (ret)
+		goto put;
+
+	ret = net_shaper_set(dev, &shaper, info->extack);
+
+put:
+	dev_put(dev);
+	return ret;
+}
+
+static int net_shaper_delete(struct net_device *dev, u32 handle,
+			     struct netlink_ext_ack *extack)
+{
+	struct net_shaper_info *parent, *shaper = sc_lookup(dev, handle);
+	struct xarray *xa = __sc_container(dev);
+	enum net_shaper_scope pscope;
+	u32 parent_handle;
+	int ret;
+
+	if (!xa || !shaper) {
+		NL_SET_ERR_MSG_FMT(extack, "Shaper %x not found", handle);
+		return -EINVAL;
+	}
+
+	if (is_detached(handle) && shaper->children > 0) {
+		NL_SET_ERR_MSG_FMT(extack, "Can't delete detached shaper %d with %d child nodes",
+				   handle, shaper->children);
+		return -EINVAL;
+	}
+
+	while (shaper) {
+		parent_handle = shaper->parent;
+		pscope = net_shaper_handle_scope(parent_handle);
+
+		ret = dev->netdev_ops->net_shaper_ops->delete(dev, handle, extack);
+		if (ret < 0)
+			return ret;
+
+		xa_lock(xa);
+		__xa_erase(xa, handle);
+		if (is_detached(handle))
+			idr_remove(&dev->net_shaper_data->detached_ids,
+				   net_shaper_handle_id(handle));
+		xa_unlock(xa);
+		kfree(shaper);
+		shaper = NULL;
+
+		if (pscope == NET_SHAPER_SCOPE_DETACHED) {
+			parent = sc_lookup(dev, parent_handle);
+			if (parent && !--parent->children) {
+				shaper = parent;
+				handle = parent_handle;
+			}
+		}
+	}
+	return 0;
 }
 
 int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct net_device *dev;
+	u32 handle;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
+		return -EINVAL;
+
+	ret = fetch_dev(info, &dev);
+	if (ret)
+		return ret;
+
+	ret = parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info, &handle);
+	if (ret)
+		goto put;
+
+	ret = net_shaper_delete(dev, handle, info->extack);
+
+put:
+	dev_put(dev);
+	return ret;
 }
 
 int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
-- 
2.45.2


