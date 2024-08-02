Return-Path: <netdev+bounces-115377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A894614F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5459F280F69
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89FF1A34A3;
	Fri,  2 Aug 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E22aDYDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2C1A34A1
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614519; cv=none; b=mx6QS0dzV51nHifRjXnL85rBhXnDRskBTHS/m13S+RmLhdcdDCKuMu+hWnlG2NCDvU2gAzV4T0k8qExH6pg+9XmZIVWAufaD2DRHr7bjDfOTdzoz0GEH4hV16kZZMXFt2+nYtsl0gjtHgy+/dZ/bVh0lhgvm+/ALm1exRxOL6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614519; c=relaxed/simple;
	bh=rKOsQKrCc8soXK9iBMgR8jo0NZg4YCh12LbY5b2U27w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXllAG86L32Brqz94e94qSOgVJ3LlEXL9HWb6PylYyHtjGo0H+UokxcH1Jw/A98wm5ha2jAeQ19ZGZJVFW4kkybtXgQmcb3Ki4EauHdwsMqakn2IST6efy3TgYpu+RwxFj24nW2M5QFNiePLVI2A8Ek2I8n2hvyK8dwE6bJTJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E22aDYDE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso1205789a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722614515; x=1723219315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggaMjo/H93tbbJk9RvAkZiq9f29wpxFYFMSjZvNAb0g=;
        b=E22aDYDEYvZaiFV0cSnuvNmMA0bWzIgPPC5HJ5C0TNDQx6ShUzR9QISZTb7dGt6L4w
         xv+6B+dZfDEFwfnjg4cOXzhn+SdeNF1ZZeJKSxwABQEbzxA57IGJuEJKuoXlSLfSmwEN
         otdPOSp8dIAgPJiq3NaUNTJtwQpl51cCRpAgZhi6UT/Wlu+QCQirOzlOOXRJyZb1PMsy
         SFuY97U6xoIngdikOGXD0kkVW6AsJyO/9fkVtzHVW2QcH38aIiJTpNcq/aBmH5SsuE05
         yMq6CWnTLI8388qU7kChkEYtb6Z0hTmVzsTdHZ4L/4x2i+NVtrjm8SHncK899zXhYySJ
         PZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614515; x=1723219315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggaMjo/H93tbbJk9RvAkZiq9f29wpxFYFMSjZvNAb0g=;
        b=fB45FwnupdU5GTEFlxNxBnLchMI/Xh26SJcbECwpt05ssomO3VEeoqD9J3X+lb1ui6
         B5GXTco/7F8H3csyJ31hLWyP0YQiHXC236v3bAjGPwyvbNbfzTeDqUhvcWW9NvV1TfGP
         mpnLOQ0AGTF4VqXdgPQjjBcfEQ3ceH6BoMYBesG7qSMFEC2zg4DjMRmJ1ZD1ogkToMqO
         pNZO+SyAxtFlnH0kMNQ/CMuLH0CBFN580dM/JeNPJk42gtvcYTospDqBWXiMhEyA4AHU
         Yxh0KQJhndKXzTXrTYJ3arbWk/bIpa+C9DTpQNjqaQCECJitxp7GyHgtuxP5/3jSZNnF
         dkBA==
X-Gm-Message-State: AOJu0YzZofnY4O4SRXRuyw576S/H2YchUkemsxtykzldIIH8cv5e8QWk
	p9Hbe6mQ8jZe8UEVfvB/7L5ydMergsCdXavdEhj/DfpfqdeehQbNnUBQy25k+mo=
X-Google-Smtp-Source: AGHT+IGDxgUyWHXllVD4mQ4gjeE7ZRlH4ju9nPmyA+2MNEqF3TKsQkplCVYK0/YRTQ9C2drNUZ7/Zg==
X-Received: by 2002:a05:6402:2055:b0:5a2:5854:5a2f with SMTP id 4fb4d7f45d1cf-5b80b294b93mr3354674a12.10.1722614514609;
        Fri, 02 Aug 2024 09:01:54 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a24fdedsm1254946a12.50.2024.08.02.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:01:53 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:01:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH RFC v2 03/11] net-shapers: implement NL set and delete
 operations
Message-ID: <Zq0C8HdpMCAxya9P@nanopsycho.orion>
References: <cover.1721851988.git.pabeni@redhat.com>
 <b51a8dbc20d6bd68b528ccf58a049bd26e564e49.1721851988.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51a8dbc20d6bd68b528ccf58a049bd26e564e49.1721851988.git.pabeni@redhat.com>

Wed, Jul 24, 2024 at 10:24:49PM CEST, pabeni@redhat.com wrote:
>Both NL operations directly map on the homonymous device shaper
>callbacks and update accordingly the shapers cache.
>Implement the cache modification helpers to additionally deal with
>DETACHED scope shaper. That will be needed by the group() operation
>implemented in the next patch.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
> net/shaper/shaper.c | 323 +++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 321 insertions(+), 2 deletions(-)
>
>diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
>index 93dd491ac7c2..7802c9ba6d9c 100644
>--- a/net/shaper/shaper.c
>+++ b/net/shaper/shaper.c
>@@ -19,6 +19,35 @@ struct net_shaper_nl_ctx {
> 	u32 start_handle;
> };
> 
>+static u32 default_parent(u32 handle)
>+{
>+	enum net_shaper_scope parent, scope = net_shaper_handle_scope(handle);

In the rest of the code you call this "pscope", could you rename?


>+
>+	switch (scope) {
>+	case NET_SHAPER_SCOPE_PORT:
>+	case NET_SHAPER_SCOPE_UNSPEC:
>+		parent = NET_SHAPER_SCOPE_UNSPEC;
>+		break;
>+
>+	case NET_SHAPER_SCOPE_QUEUE:
>+	case NET_SHAPER_SCOPE_DETACHED:

Why default parent of detached is netdev? Detached means "node in tree"
if IIUC. Can't port be parent?

>+		parent = NET_SHAPER_SCOPE_NETDEV;
>+		break;
>+
>+	case NET_SHAPER_SCOPE_NETDEV:
>+	case NET_SHAPER_SCOPE_VF:
>+		parent = NET_SHAPER_SCOPE_PORT;
>+		break;
>+	}
>+
>+	return net_shaper_make_handle(parent, 0);
>+}
>+
>+static bool is_detached(u32 handle)
>+{
>+	return net_shaper_handle_scope(handle) == NET_SHAPER_SCOPE_DETACHED;
>+}
>+
> static int fill_handle(struct sk_buff *msg, u32 handle, u32 type,
> 		       const struct genl_info *info)
> {
>@@ -117,6 +146,115 @@ static struct net_shaper_info *sc_lookup(struct net_device *dev, u32 handle)
> 	return xa ? xa_load(xa, handle) : NULL;
> }
> 
>+/* allocate on demand the per device shaper's cache */
>+static struct xarray *__sc_init(struct net_device *dev,
>+				struct netlink_ext_ack *extack)
>+{
>+	if (!dev->net_shaper_data) {
>+		dev->net_shaper_data = kmalloc(sizeof(*dev->net_shaper_data),
>+					       GFP_KERNEL);
>+		if (!dev->net_shaper_data) {
>+			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");
>+			return NULL;
>+		}
>+
>+		xa_init(&dev->net_shaper_data->shapers);
>+		idr_init(&dev->net_shaper_data->detached_ids);
>+	}
>+	return &dev->net_shaper_data->shapers;
>+}
>+
>+/* prepare the cache to actually insert the given shaper, doing
>+ * in advance the needed allocations

In comments (all), would it make sense to start the sentence with
capital letter and end it with "."?


>+ */
>+static int sc_prepare_insert(struct net_device *dev, u32 *handle,
>+			     struct netlink_ext_ack *extack)
>+{
>+	enum net_shaper_scope scope = net_shaper_handle_scope(*handle);
>+	struct xarray *xa = __sc_init(dev, extack);
>+	struct net_shaper_info *prev, *cur;
>+	bool id_allocated = false;
>+	int ret, id;
>+
>+	if (!xa)
>+		return -ENOMEM;
>+
>+	cur = xa_load(xa, *handle);
>+	if (cur)
>+		return 0;
>+
>+	/* allocated a new id, if needed */

s/allocated/allocate/ perhaps ?


>+	if (scope == NET_SHAPER_SCOPE_DETACHED &&
>+	    net_shaper_handle_id(*handle) == NET_SHAPER_ID_UNSPEC) {
>+		xa_lock(xa);
>+		id = idr_alloc(&dev->net_shaper_data->detached_ids, NULL,
>+			       0, NET_SHAPER_ID_UNSPEC, GFP_ATOMIC);
>+		xa_unlock(xa);
>+
>+		if (id < 0) {
>+			NL_SET_ERR_MSG(extack, "Can't allocate new id for detached shaper");
>+			return id;
>+		}
>+
>+		*handle = net_shaper_make_handle(scope, id);
>+		id_allocated = true;
>+	}
>+
>+	cur = kmalloc(sizeof(*cur), GFP_KERNEL | __GFP_ZERO);
>+	if (!cur) {
>+		NL_SET_ERR_MSG(extack, "Can't allocate memory for cached shaper");
>+		ret = -ENOMEM;
>+		goto free_id;
>+	}
>+
>+	/* mark 'tentative' shaper inside the cache */
>+	xa_lock(xa);
>+	prev = __xa_store(xa, *handle, cur, GFP_KERNEL);
>+	__xa_set_mark(xa, *handle, XA_MARK_0);

I think it is nice to actually have a define for the mark that indicates
what a certain mark represents.

Also, this patch introduces a bug in net_shaper_nl_get_dumpit()/net_shaper_nl_get_doit()
which now work with uncommitted shapers. You have to check the mark.


>+	xa_unlock(xa);
>+	if (xa_err(prev)) {
>+		NL_SET_ERR_MSG(extack, "Can't insert shaper into cache");
>+		kfree(cur);
>+		ret = xa_err(prev);
>+		goto free_id;
>+	}
>+	return 0;
>+
>+free_id:
>+	if (id_allocated) {
>+		xa_lock(xa);

May be worth mentioning you protect detached_ids with the xa lock.


>+		idr_remove(&dev->net_shaper_data->detached_ids,
>+			   net_shaper_handle_id(*handle));
>+		xa_unlock(xa);
>+	}
>+	return ret;
>+}
>+
>+/* commit the tentative insert with the actual values.
>+ * Must be called only after a successful sc_prepare_insert()
>+ */
>+static void sc_commit(struct net_device *dev, int nr_shapers,
>+		      const struct net_shaper_info *shapers)
>+{
>+	struct xarray *xa = __sc_container(dev);
>+	struct net_shaper_info *cur;
>+	int i;
>+
>+	xa_lock(xa);
>+	for (i = 0; i < nr_shapers; ++i) {
>+		cur = xa_load(xa, shapers[i].handle);
>+		if (WARN_ON_ONCE(!cur))
>+			continue;
>+
>+		/* successful update: drop the tentative mark
>+		 * and update the cache
>+		 */
>+		__xa_clear_mark(xa, shapers[i].handle, XA_MARK_0);
>+		*cur = shapers[i];
>+	}
>+	xa_unlock(xa);
>+}
>+
> static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
> 			u32 *handle)
> {
>@@ -154,6 +292,68 @@ static int parse_handle(const struct nlattr *attr, const struct genl_info *info,
> 	return 0;
> }
> 
>+static int __parse_shaper(struct net_device *dev, struct nlattr **tb,

In general, "__" prefix indicates that reader should be careful for any
reason, locking for example. Here, It's a simple helper, isn't it? Why
"__" make sense here?



>+			  const struct genl_info *info,
>+			  struct net_shaper_info *shaper)
>+{
>+	struct net_shaper_info *old;
>+	int ret;
>+
>+	/* the shaper handle is the only mandatory attribute */
>+	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
>+		return -EINVAL;
>+
>+	ret = parse_handle(tb[NET_SHAPER_A_HANDLE], info, &shaper->handle);
>+	if (ret)
>+		return ret;
>+
>+	/* fetch existing data, if any, so that user provide info will
>+	 * incrementally update the existing shaper configuration
>+	 */
>+	old = sc_lookup(dev, shaper->handle);
>+	if (old)
>+		*shaper = *old;
>+	else
>+		shaper->parent = default_parent(shaper->handle);
>+
>+	if (tb[NET_SHAPER_A_METRIC])
>+		shaper->metric = nla_get_u32(tb[NET_SHAPER_A_METRIC]);
>+
>+	if (tb[NET_SHAPER_A_BW_MIN])
>+		shaper->bw_min = nla_get_uint(tb[NET_SHAPER_A_BW_MIN]);
>+
>+	if (tb[NET_SHAPER_A_BW_MAX])
>+		shaper->bw_max = nla_get_uint(tb[NET_SHAPER_A_BW_MAX]);
>+
>+	if (tb[NET_SHAPER_A_BURST])
>+		shaper->burst = nla_get_uint(tb[NET_SHAPER_A_BURST]);
>+
>+	if (tb[NET_SHAPER_A_PRIORITY])
>+		shaper->priority = nla_get_u32(tb[NET_SHAPER_A_PRIORITY]);
>+
>+	if (tb[NET_SHAPER_A_WEIGHT])
>+		shaper->weight = nla_get_u32(tb[NET_SHAPER_A_WEIGHT]);
>+	return 0;
>+}
>+
>+/* fetch the cached shaper info and update them with the user-provided
>+ * attributes
>+ */
>+static int parse_shaper(struct net_device *dev, const struct nlattr *attr,
>+			const struct genl_info *info,
>+			struct net_shaper_info *shaper)
>+{
>+	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
>+	int ret;
>+
>+	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
>+			       net_shaper_ns_info_nl_policy, info->extack);
>+	if (ret < 0)
>+		return ret;
>+
>+	return __parse_shaper(dev, tb, info, shaper);
>+}
>+
> int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct net_shaper_info *shaper;
>@@ -239,14 +439,133 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
> 	return ret;
> }
> 
>+/* Update the H/W and on success update the local cache, too */
>+static int net_shaper_set(struct net_device *dev,
>+			  const struct net_shaper_info *shaper,
>+			  struct netlink_ext_ack *extack)
>+{
>+	enum net_shaper_scope scope;
>+	u32 handle = shaper->handle;
>+	int ret;
>+
>+	scope = net_shaper_handle_scope(handle);
>+	if (scope == NET_SHAPER_SCOPE_PORT ||

NET_SHAPER_SCOPE_PORT is not really used in this set. Why do you have
it? Same applies tol NET_SHAPER_SCOPE_NETDEV.


>+	    scope == NET_SHAPER_SCOPE_UNSPEC) {
>+		NL_SET_ERR_MSG_FMT(extack, "Can't set shaper %x with scope %d",
>+				   handle, scope);
>+		return -EINVAL;
>+	}
>+	if (scope == NET_SHAPER_SCOPE_DETACHED && !sc_lookup(dev, handle)) {
>+		NL_SET_ERR_MSG_FMT(extack, "Shaper %x with detached scope does not exist",
>+				   handle);
>+		return -EINVAL;
>+	}
>+
>+	ret = sc_prepare_insert(dev, &handle, extack);
>+	if (ret)
>+		return ret;
>+
>+	ret = dev->netdev_ops->net_shaper_ops->set(dev, shaper, extack);
>+	sc_commit(dev, 1, shaper);

Missing rollback?


>+	return ret;
>+}
>+
> int net_shaper_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
> {
>-	return -EOPNOTSUPP;
>+	struct net_shaper_info shaper;
>+	struct net_device *dev;
>+	struct nlattr *attr;
>+	int ret;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_SHAPER))
>+		return -EINVAL;
>+
>+	ret = fetch_dev(info, &dev);
>+	if (ret)
>+		return ret;
>+
>+	attr = info->attrs[NET_SHAPER_A_SHAPER];
>+	ret = parse_shaper(dev, attr, info, &shaper);
>+	if (ret)
>+		goto put;
>+
>+	ret = net_shaper_set(dev, &shaper, info->extack);

Hmm, if I don't miss anything, this is lockless (.parallel_ops==true).
What's stopping user from performing the set action in parallel on a
single shaper? The locking scheme seems to be missing. Another thing to
describe in documentation, perhaps.



>+
>+put:
>+	dev_put(dev);
>+	return ret;
>+}
>+
>+static int net_shaper_delete(struct net_device *dev, u32 handle,
>+			     struct netlink_ext_ack *extack)
>+{
>+	struct net_shaper_info *parent, *shaper = sc_lookup(dev, handle);
>+	struct xarray *xa = __sc_container(dev);
>+	enum net_shaper_scope pscope;
>+	u32 parent_handle;
>+	int ret;
>+
>+	if (!xa || !shaper) {
>+		NL_SET_ERR_MSG_FMT(extack, "Shaper %x not found", handle);
>+		return -EINVAL;
>+	}
>+
>+	if (is_detached(handle) && shaper->children > 0) {
>+		NL_SET_ERR_MSG_FMT(extack, "Can't delete detached shaper %d with %d child nodes",
>+				   handle, shaper->children);
>+		return -EINVAL;
>+	}
>+
>+	while (shaper) {
>+		parent_handle = shaper->parent;
>+		pscope = net_shaper_handle_scope(parent_handle);
>+
>+		ret = dev->netdev_ops->net_shaper_ops->delete(dev, handle, extack);
>+		if (ret < 0)
>+			return ret;
>+
>+		xa_lock(xa);
>+		__xa_erase(xa, handle);

Hmm, did you think about free of dev->net_shaper_data in case this is
the last item? I think it would be correct to do that.


>+		if (is_detached(handle))
>+			idr_remove(&dev->net_shaper_data->detached_ids,
>+				   net_shaper_handle_id(handle));
>+		xa_unlock(xa);
>+		kfree(shaper);
>+		shaper = NULL;
>+
>+		if (pscope == NET_SHAPER_SCOPE_DETACHED) {
>+			parent = sc_lookup(dev, parent_handle);
>+			if (parent && !--parent->children) {
>+				shaper = parent;
>+				handle = parent_handle;
>+			}
>+		}
>+	}
>+	return 0;
> }
> 
> int net_shaper_nl_delete_doit(struct sk_buff *skb, struct genl_info *info)
> {
>-	return -EOPNOTSUPP;
>+	struct net_device *dev;
>+	u32 handle;
>+	int ret;
>+
>+	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
>+		return -EINVAL;
>+
>+	ret = fetch_dev(info, &dev);
>+	if (ret)
>+		return ret;
>+
>+	ret = parse_handle(info->attrs[NET_SHAPER_A_HANDLE], info, &handle);
>+	if (ret)
>+		goto put;
>+
>+	ret = net_shaper_delete(dev, handle, info->extack);
>+
>+put:
>+	dev_put(dev);
>+	return ret;
> }
> 
> int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
>-- 
>2.45.2
>

