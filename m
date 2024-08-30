Return-Path: <netdev+bounces-123540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A89654A3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8221F2187C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783233998;
	Fri, 30 Aug 2024 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpYfsFSb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504BD27E
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980821; cv=none; b=ZYEmbz8ksA16y7qtbxPmuZtNSVQAn3hKvzNuenjSOBsnsHaW2q+mbdd+VPgUiVznIbE99KXRckzno/300ZvvmY/vrRusQyti+K3oxLqD+TUTCuEDvi/DBMk8zqSCb9D/W9lX93ryZbPvCyMbHNvvYCwaocH4qobbgQEVpacxnPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980821; c=relaxed/simple;
	bh=c+b4T/aHGsOzlEDZZkN6DoiXx2A9j5itydLLpXheobA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQY1ityziBwizx+ZwvJYGN/B6ncH0B3QXf3ADEa3XGnPT/ais97V1gvc9RWZfpOF/cZW+DjSxGjrFt2CyUDrItDOkBta/+RI7zmjrfcbJlcOq94ZiJj5K2KneTj1EOYQS1dzHUVIHlZ1z0BaN3Z+7HPforzzIQ/yLh4Q0iBGwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpYfsFSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E6BC4CEC1;
	Fri, 30 Aug 2024 01:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724980821;
	bh=c+b4T/aHGsOzlEDZZkN6DoiXx2A9j5itydLLpXheobA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GpYfsFSbZoPuiaWMKRzJzfklmzv0lFpHz6olqaan+KFRHyiJp9t8X8FoMBH4lj9ZS
	 qJ3xkBhB9ePurOljZOPnCjtfrvMtNyaa/2sXgUr6VVNfREM2KeYGryIwwIOirhyMGp
	 L5qDb41TQso29dMi87IgTnXFemNof5t/+nbgYdnEXcje9ICrE89SNa5sz5lGTtKmxu
	 6xaq7OPtQKmNZsVp6/2ds8Y3m7P7V0IvDs8njw+BWBtQ5jCkloYJFOL0pi0JNwDj/o
	 z8uBrM+GNvZ4wrxZ/7vHvDlvqxb3icbEdg+bpan60AAQ4peqEMEtwCFkwq07v+jwsZ
	 IEn+uSjcazD/A==
Date: Thu, 29 Aug 2024 18:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 02/12] net-shapers: implement NL get
 operation
Message-ID: <20240829182019.105962f6@kernel.org>
In-Reply-To: <53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<53077d35a1183d5c1110076a07d73940bb2a55f3.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:16:55 +0200 Paolo Abeni wrote:
> +static int net_shaper_fill_handle(struct sk_buff *msg,
> +				  const struct net_shaper_handle *handle,
> +				  u32 type)
> +{
> +	struct nlattr *handle_attr;
> +
> +	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC)
> +		return 0;
> +
> +	handle_attr = nla_nest_start_noflag(msg, type);

_noflag() is deprecated

> +	if (!handle_attr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(msg, NET_SHAPER_A_HANDLE_SCOPE, handle->scope) ||
> +	    (handle->scope >= NET_SHAPER_SCOPE_QUEUE &&
> +	     nla_put_u32(msg, NET_SHAPER_A_HANDLE_ID, handle->id)))
> +		goto handle_nest_cancel;
> +
> +	nla_nest_end(msg, handle_attr);
> +	return 0;
> +
> +handle_nest_cancel:
> +	nla_nest_cancel(msg, handle_attr);
> +	return -EMSGSIZE;
> +}

> +/* Initialize the context fetching the relevant device and
> + * acquiring a reference to it.
> + */
> +static int net_shaper_ctx_init(const struct genl_info *info, int type,
> +			       struct net_shaper_nl_ctx *ctx)
> +{
> +	struct net *ns = genl_info_net(info);
> +	struct net_device *dev;
> +	int ifindex;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +	if (GENL_REQ_ATTR_CHECK(info, type))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[type]);

Let's limit the 'binding' thing to just driver call sites, we can
redo the rest easily later. This line and next pretends to take
"arbitrary" type but clearly wants a ifindex/netdev, right?

> +	dev = netdev_get_by_index(ns, ifindex, &ctx->dev_tracker, GFP_KERNEL);
> +	if (!dev) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
> +		return -ENOENT;
> +	}

> +static int net_shaper_parse_handle(const struct nlattr *attr,
> +				   const struct genl_info *info,
> +				   struct net_shaper_handle *handle)
> +{
> +	struct nlattr *tb[NET_SHAPER_A_HANDLE_MAX + 1];
> +	struct nlattr *scope_attr, *id_attr;
> +	u32 id = 0;
> +	int ret;
> +
> +	ret = nla_parse_nested(tb, NET_SHAPER_A_HANDLE_MAX, attr,
> +			       net_shaper_handle_nl_policy, info->extack);
> +	if (ret < 0)
> +		return ret;
> +
> +	scope_attr = tb[NET_SHAPER_A_HANDLE_SCOPE];
> +	if (!scope_attr) {

NL_REQ_ATTR_CHECK()

> +		NL_SET_BAD_ATTR(info->extack,
> +				tb[NET_SHAPER_A_HANDLE_SCOPE]);
> +		return -EINVAL;
> +	}
> +
> +	handle->scope = nla_get_u32(scope_attr);
> +
> +	/* The default id for NODE scope shapers is an invalid one
> +	 * to help the 'group' operation discriminate between new
> +	 * NODE shaper creation (ID_UNSPEC) and reuse of existing
> +	 * shaper (any other value).
> +	 */
> +	id_attr = tb[NET_SHAPER_A_HANDLE_ID];
> +	if (id_attr)
> +		id = nla_get_u32(id_attr);
> +	else if (handle->scope == NET_SHAPER_SCOPE_NODE)
> +		id = NET_SHAPER_ID_UNSPEC;
> +
> +	handle->id = id;
> +	return 0;
> +}
> +
> +static int net_shaper_generic_pre(struct genl_info *info, int type)
> +{
> +	struct net_shaper_nl_ctx *ctx;
> +	int ret;
> +
> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);

Maybe send a patch like this, to avoid having to allocate this space,
and special casing dump vs doit:

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ab49bfeae78..7658f0885178 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -124,7 +124,8 @@ struct genl_family {
  * @genlhdr: generic netlink message header
  * @attrs: netlink attributes
  * @_net: network namespace
- * @user_ptr: user pointers
+ * @ctx: storage space for the use by the family
+ * @user_ptr: user pointers (deprecated, use ctx instead)
  * @extack: extended ACK report struct
  */
 struct genl_info {
@@ -135,7 +136,10 @@ struct genl_info {
 	struct genlmsghdr *	genlhdr;
 	struct nlattr **	attrs;
 	possible_net_t		_net;
-	void *			user_ptr[2];
+	union {
+		u8		ctx[48];
+		void *		user_ptr[2];
+	};
 	struct netlink_ext_ack *extack;
 };
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a116..29387b605f3e 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -997,7 +997,7 @@ static int genl_start(struct netlink_callback *cb)
 	info->info.attrs	= attrs;
 	genl_info_net_set(&info->info, sock_net(cb->skb->sk));
 	info->info.extack	= cb->extack;
-	memset(&info->info.user_ptr, 0, sizeof(info->info.user_ptr));
+	memset(&info->info.ctx, 0, sizeof(info->info.ctx));
 
 	cb->data = info;
 	if (ops->start) {
@@ -1104,7 +1104,7 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 	info.attrs = attrbuf;
 	info.extack = extack;
 	genl_info_net_set(&info, net);
-	memset(&info.user_ptr, 0, sizeof(info.user_ptr));
+	memset(&info.ctx, 0, sizeof(info.ctx));
 
 	if (ops->pre_doit) {
 		err = ops->pre_doit(ops, skb, &info);

> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ret = net_shaper_ctx_init(info, type, ctx);
> +	if (ret) {
> +		kfree(ctx);
> +		return ret;
> +	}
> +
> +	info->user_ptr[0] = ctx;
> +	return 0;
> +}
> +
>  int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct net_shaper_binding *binding;
> +	struct net_shaper_handle handle;
> +	struct net_shaper_info *shaper;
> +	struct sk_buff *msg;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_HANDLE))
> +		return -EINVAL;
> +
> +	binding = net_shaper_binding_from_ctx(info->user_ptr[0]);

This 'binding' has the same meaning as 'binding' in TCP ZC? :(

> +	shaper = net_shaper_cache_lookup(binding, &handle);

Why call the stored info "cache"? It's the authoritative version of
user configuration, isn't it?

> +	if (!shaper) {
> +		NL_SET_BAD_ATTR(info->extack,
> +				info->attrs[NET_SHAPER_A_HANDLE]);
> +		return -ENOENT;
> +	}
> +
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	ret = net_shaper_fill_one(msg, binding, &handle, shaper, info);
> +	if (ret)
> +		goto free_msg;
> +
> +	ret =  genlmsg_reply(msg, info);

double space

