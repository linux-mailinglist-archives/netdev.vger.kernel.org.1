Return-Path: <netdev+bounces-123544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498589654CD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC37E1F23BE1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5A4D112;
	Fri, 30 Aug 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyVL5gFG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BF3C0B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982229; cv=none; b=LBzZ7st4QtEXe7kINrEF3WPj4IzLWo+eIC7pJRx9clsrcjsdn9EUj68xSTTpFYmsiG2FokWxvdUdSQiL1Qg29hNA3+7yJFYss97zBQnm3rFu6uFUFpYGVf81sAXZXBqHmFuy2SfzNB5he032DVaTPiFMr+p+Euebi5p+BbCPf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982229; c=relaxed/simple;
	bh=SFPig2ookyAhjzfhfbcqktZTQfLe4eeQ8rr/FvIUCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5HU3pI4v9T0y2PGOj6gImeUuFxJfqCvTs9YzPQRKddEZVP/8vdNOlPACv2wIPEBpVbeqXGZUEttyFKisJ9Ug3Pylc7B+9RhUZuwihlqTfQYkqCx4NB9aO2bQUOBu+fJFcKPifAhRILuD93BgggNLYJWtbGQS9s0x+Q1ukTFUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyVL5gFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1FAC4CEC3;
	Fri, 30 Aug 2024 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724982228;
	bh=SFPig2ookyAhjzfhfbcqktZTQfLe4eeQ8rr/FvIUCUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DyVL5gFGwr+W7vQ3gXbQ/L1XHCbWfcID3jRUa9wPZU1nDo/HJw9FQ9lAYJSzSWPMq
	 ie7p2ZFXuDAmoHUKU2RzlLiA+u5iN7By4r/eYxpyrjNGId3xECnLHfANpznczZ8kAi
	 kuN9M6RZCPVcrPNqvqNirRP+B/GunGv6XsArPBefw4FWC2QOlWU4ByG9i493GzeeaQ
	 cOsB+rgxogpt3/igd/pa3SNWC/ymoQYjjT1ciyFgyOD+vi2QEfgSpWV/KpX+GUM5BW
	 1q67nbmBcYUMtMqlWyBYVC/pPaMRh4rg4kaqfvCoycKuQWYyJpjoM+opbQpZrFL/Dl
	 pQxGO8E0YcDvQ==
Date: Thu, 29 Aug 2024 18:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 03/12] net-shapers: implement NL set and
 delete operations
Message-ID: <20240829184347.3a9a7910@kernel.org>
In-Reply-To: <fcf4c258f606837cac72bb26cd751bb619e9ff87.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<fcf4c258f606837cac72bb26cd751bb619e9ff87.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:16:56 +0200 Paolo Abeni wrote:
> ithe next patch and will be implemented later in the series.

s/ithe/the/

> diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
> index 2ed80df25765..a58bdd2ec013 100644
> --- a/net/shaper/shaper.c
> +++ b/net/shaper/shaper.c
> @@ -23,6 +23,10 @@
>  
>  struct net_shaper_data {
>  	struct xarray shapers;
> +
> +	/* Serialize write ops and protects node_ids updates. */

By write ops you mean all driver ops but @capabilities?
Maybe let's say all driver ops and avoid confusion?

> +	struct mutex lock;
> +	struct idr node_ids;

Do we need an IDR? can we not allocate the IDs using the xarray,
starting at the offset of first NODE? Since type is on top bits?

>  };
>  
>  struct net_shaper_nl_ctx {
> @@ -47,6 +51,27 @@ net_shaper_binding_data(struct net_shaper_binding *binding)
>  	return NULL;
>  }
>  
> +static struct net_shaper_data *
> +net_shaper_binding_set_data(struct net_shaper_binding *binding,
> +			    struct net_shaper_data *data)
> +{
> +	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
> +		return cmpxchg(&binding->netdev->net_shaper_data, NULL, data);

Hmm. Do we need this because the lock is inside the struct we're
allocating? I've been wondering if we shouldn't move this lock
directly into net_device and combine it with the RSS lock.
Create a "per-netdev" lock, instead of having multiple disparate
mutexes which are hard to allocate?

> +	/* No devlink implementation yet.*/
> +	return NULL;
> +}
> +
> +static const struct net_shaper_ops *
> +net_shaper_binding_ops(struct net_shaper_binding *binding)
> +{
> +	if (binding->type == NET_SHAPER_BINDING_TYPE_NETDEV)
> +		return binding->netdev->netdev_ops->net_shaper_ops;
> +
> +	/* No devlink implementation yet.*/
> +	return NULL;
> +}
> +
>  static int net_shaper_fill_binding(struct sk_buff *msg,
>  				   const struct net_shaper_binding *binding,
>  				   u32 type)
> @@ -178,6 +203,26 @@ static void net_shaper_index_to_handle(u32 index,
>  	handle->id = FIELD_GET(NET_SHAPER_ID_MASK, index);
>  }
>  
> +static void net_shaper_default_parent(const struct net_shaper_handle *handle,
> +				      struct net_shaper_handle *parent)
> +{
> +	switch (handle->scope) {
> +	case NET_SHAPER_SCOPE_UNSPEC:
> +	case NET_SHAPER_SCOPE_NETDEV:
> +	case __NET_SHAPER_SCOPE_MAX:
> +		parent->scope = NET_SHAPER_SCOPE_UNSPEC;
> +		break;
> +
> +	case NET_SHAPER_SCOPE_QUEUE:
> +	case NET_SHAPER_SCOPE_NODE:
> +		parent->scope = NET_SHAPER_SCOPE_NETDEV;
> +		break;
> +	}
> +	parent->id = 0;
> +}
> +
> +#define NET_SHAPER_CACHE_NOT_VALID XA_MARK_0
> +
>  /* Lookup the given shaper inside the cache. */
>  static struct net_shaper_info *
>  net_shaper_cache_lookup(struct net_shaper_binding *binding,
> @@ -186,7 +231,132 @@ net_shaper_cache_lookup(struct net_shaper_binding *binding,
>  	struct net_shaper_data *data = net_shaper_binding_data(binding);
>  	u32 index = net_shaper_handle_to_index(handle);
>  
> -	return data ? xa_load(&data->shapers, index) : NULL;
> +	if (!data || xa_get_mark(&data->shapers, index,
> +				 NET_SHAPER_CACHE_NOT_VALID))
> +		return NULL;
> +
> +	return xa_load(&data->shapers, index);
> +}
> +
> +/* Allocate on demand the per device shaper's cache. */
> +static struct net_shaper_data *
> +net_shaper_cache_init(struct net_shaper_binding *binding,
> +		      struct netlink_ext_ack *extack)
> +{
> +	struct net_shaper_data *new, *data = net_shaper_binding_data(binding);
> +

Please don't call functions in variable init if you have to check
what they returned later.

> +	if (!data) {

invert the condition and return early?

> +		new = kmalloc(sizeof(*data), GFP_KERNEL);
> +		if (!new) {
> +			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");

no error messages needed for GFP_KERNEL OOM (pls fix everywhere)

> +			return NULL;
> +		}
> +
> +		mutex_init(&new->lock);
> +		xa_init(&new->shapers);
> +		idr_init(&new->node_ids);
> +
> +		/* No lock acquired yet, we can race with other operations. */
> +		data = net_shaper_binding_set_data(binding, new);
> +		if (!data)
> +			data = new;
> +		else
> +			kfree(new);
> +	}
> +	return data;
> +}
> +
> +/* Prepare the cache to actually insert the given shaper, doing
> + * in advance the needed allocations.
> + */
> +static int net_shaper_cache_pre_insert(struct net_shaper_binding *binding,
> +				       struct net_shaper_handle *handle,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct net_shaper_data *data = net_shaper_binding_data(binding);
> +	struct net_shaper_info *prev, *cur;
> +	bool id_allocated = false;
> +	int ret, id, index;
> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	index = net_shaper_handle_to_index(handle);
> +	cur = xa_load(&data->shapers, index);
> +	if (cur)
> +		return 0;
> +
> +	/* Allocated a new id, if needed. */
> +	if (handle->scope == NET_SHAPER_SCOPE_NODE &&
> +	    handle->id == NET_SHAPER_ID_UNSPEC) {
> +		id = idr_alloc(&data->node_ids, NULL,
> +			       0, NET_SHAPER_ID_UNSPEC, GFP_ATOMIC);

How did we enter ATOMIC context?

> +
> +		if (id < 0) {
> +			NL_SET_ERR_MSG(extack, "Can't allocate new id for NODE shaper");
> +			return id;
> +		}
> +
> +		handle->id = id;
> +		index = net_shaper_handle_to_index(handle);
> +		id_allocated = true;
> +	}
> +
> +	cur = kmalloc(sizeof(*cur), GFP_KERNEL | __GFP_ZERO);

kzalloc() ?

> +	if (!cur) {
> +		NL_SET_ERR_MSG(extack, "Can't allocate memory for cached shaper");
> +		ret = -ENOMEM;
> +		goto free_id;
> +	}
> +
> +	/* Mark 'tentative' shaper inside the cache. */
> +	xa_lock(&data->shapers);
> +	prev = __xa_store(&data->shapers, index, cur, GFP_KERNEL);
> +	__xa_set_mark(&data->shapers, index, NET_SHAPER_CACHE_NOT_VALID);

Maybe worth calling out if it's level to xa_set_mark on a non-inserted
handle?

> +	xa_unlock(&data->shapers);
> +	if (xa_err(prev)) {
> +		NL_SET_ERR_MSG(extack, "Can't insert shaper into cache");
> +		kfree(cur);
> +		ret = xa_err(prev);
> +		goto free_id;
> +	}
> +	return 0;
> +
> +free_id:
> +	if (id_allocated)
> +		idr_remove(&data->node_ids, handle->id);
> +	return ret;
> +}
> +
> +/* Commit the tentative insert with the actual values.
> + * Must be called only after a successful net_shaper_pre_insert().
> + */
> +static void net_shaper_cache_commit(struct net_shaper_binding *binding,
> +				    int nr_shapers,
> +				    const struct net_shaper_handle *handle,
> +				    const struct net_shaper_info *shapers)
> +{
> +	struct net_shaper_data *data = net_shaper_binding_data(binding);
> +	struct net_shaper_info *cur;
> +	int index;
> +	int i;
> +
> +	xa_lock(&data->shapers);
> +	for (i = 0; i < nr_shapers; ++i) {
> +		index = net_shaper_handle_to_index(&handle[i]);
> +
> +		cur = xa_load(&data->shapers, index);
> +		if (WARN_ON_ONCE(!cur))
> +			continue;
> +
> +		/* Successful update: drop the tentative mark
> +		 * and update the cache.
> +		 */
> +		__xa_clear_mark(&data->shapers, index,
> +				NET_SHAPER_CACHE_NOT_VALID);
> +		*cur = shapers[i];
> +	}
> +	xa_unlock(&data->shapers);
>  }
>  
>  static int net_shaper_parse_handle(const struct nlattr *attr,
> @@ -227,6 +397,85 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
>  	return 0;
>  }
>  
> +static int net_shaper_parse_info(struct net_shaper_binding *binding,
> +				 struct nlattr **tb,
> +				 const struct genl_info *info,
> +				 struct net_shaper_handle *handle,
> +				 struct net_shaper_info *shaper,
> +				 bool *cached)
> +{
> +	struct net_shaper_info *old;
> +	int ret;
> +
> +	/* The shaper handle is the only mandatory attribute. */
> +	if (NL_REQ_ATTR_CHECK(info->extack, NULL, tb, NET_SHAPER_A_HANDLE))
> +		return -EINVAL;
> +
> +	ret = net_shaper_parse_handle(tb[NET_SHAPER_A_HANDLE], info, handle);
> +	if (ret)
> +		return ret;
> +
> +	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC) {
> +		NL_SET_BAD_ATTR(info->extack,
> +				info->attrs[NET_SHAPER_A_HANDLE]);
> +		return -EINVAL;
> +	}
> +
> +	/* Fetch existing data, if any, so that user provide info will
> +	 * incrementally update the existing shaper configuration.
> +	 */
> +	old = net_shaper_cache_lookup(binding, handle);
> +	if (old)
> +		*shaper = *old;
> +	*cached = !!old;
> +
> +	if (tb[NET_SHAPER_A_METRIC])
> +		shaper->metric = nla_get_u32(tb[NET_SHAPER_A_METRIC]);
> +
> +	if (tb[NET_SHAPER_A_BW_MIN])
> +		shaper->bw_min = nla_get_uint(tb[NET_SHAPER_A_BW_MIN]);
> +
> +	if (tb[NET_SHAPER_A_BW_MAX])
> +		shaper->bw_max = nla_get_uint(tb[NET_SHAPER_A_BW_MAX]);
> +
> +	if (tb[NET_SHAPER_A_BURST])
> +		shaper->burst = nla_get_uint(tb[NET_SHAPER_A_BURST]);
> +
> +	if (tb[NET_SHAPER_A_PRIORITY])
> +		shaper->priority = nla_get_u32(tb[NET_SHAPER_A_PRIORITY]);
> +
> +	if (tb[NET_SHAPER_A_WEIGHT])
> +		shaper->weight = nla_get_u32(tb[NET_SHAPER_A_WEIGHT]);
> +	return 0;
> +}
> +
> +/* Fetch the cached shaper info and update them with the user-provided
> + * attributes.
> + */
> +static int net_shaper_parse_info_nest(struct net_shaper_binding *binding,
> +				      const struct nlattr *attr,
> +				      const struct genl_info *info,
> +				      struct net_shaper_handle *handle,
> +				      struct net_shaper_info *shaper)
> +{
> +	struct nlattr *tb[NET_SHAPER_A_WEIGHT + 1];
> +	bool cached;
> +	int ret;
> +
> +	ret = nla_parse_nested(tb, NET_SHAPER_A_WEIGHT, attr,
> +			       net_shaper_info_nl_policy, info->extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = net_shaper_parse_info(binding, tb, info, handle, shaper, &cached);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!cached)
> +		net_shaper_default_parent(handle, &shaper->parent);
> +	return 0;
> +}
> +
>  static int net_shaper_generic_pre(struct genl_info *info, int type)
>  {
>  	struct net_shaper_nl_ctx *ctx;
> @@ -358,14 +607,153 @@ int net_shaper_nl_get_dumpit(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/* Update the H/W and on success update the local cache, too. */
> +static int net_shaper_set(struct net_shaper_binding *binding,
> +			  const struct net_shaper_handle *h,
> +			  const struct net_shaper_info *shaper,
> +			  struct netlink_ext_ack *extack)
> +{
> +	struct net_shaper_data *data = net_shaper_cache_init(binding, extack);
> +	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
> +	struct net_shaper_handle handle = *h;
> +	int ret;
> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* Should never happen: binding lookup validates the ops presence */
> +	if (WARN_ON_ONCE(!ops))
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&data->lock);
> +	if (handle.scope == NET_SHAPER_SCOPE_NODE &&
> +	    net_shaper_cache_lookup(binding, &handle)) {
> +		ret = -ENOENT;

EEXIST ? Presumably this is temporary as described in the commit
message?

