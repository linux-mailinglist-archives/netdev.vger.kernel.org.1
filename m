Return-Path: <netdev+bounces-123562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896596550F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA421C221CB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65400535DC;
	Fri, 30 Aug 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVbOVo4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410994D8CE
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983487; cv=none; b=sMlFXH0usio4O3msUbxPDi9DFg5AXU89ldWBzCZKC5R1dLVt5GMyfe4bbjpkHs1VjsZE6cSjhARPV8qPxIzwzj60pyNDYVRsN2E5GSVyHm4zhtpTG9uR62g81IjgvQJJGnLP6AzrVwf3+BSDxrviz1dmR4baZZpES07aACm0MLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983487; c=relaxed/simple;
	bh=3OJ2QWbxiooIsEPG7RBOyCZbWUQi+zRJda0w7NW7ix8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2a8eYAocV9oYtVnaI38Oc0XvvK2G7m4GGrZP60/QX2xohNYlu0yQiWzbd5sBohevGaAw65HP7tApopXmJSK6upmncAXutoYLls/yLG1gHDxH9SMLiT1HXrKK5HoHebBcxBaonA3y+b2P72GelBLktKDRf6pwQKouoRlcxE2E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVbOVo4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298E1C4CEC1;
	Fri, 30 Aug 2024 02:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724983486;
	bh=3OJ2QWbxiooIsEPG7RBOyCZbWUQi+zRJda0w7NW7ix8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVbOVo4HkZH0Kvb+RfQWlpGJ09XeZHrSYmH77L15jSyEHwsEdz1qZl0XuVeSPGt1L
	 4rjIAVAuPre0rJZzZNK1bNC8NASgWxShkB1q5P2RQtvQE6EZ4zttdAfeXLtEvhJK0z
	 9OmFp9tpuOQj2KhtIJDau8QKQwcEtL1aQz8+ZjdgYm8tOyWG32cIaMbVpY2np1U7RH
	 z6yd+JqJ42gLfDPU1CQveMs1sGa47Dwhmi/YqMcVlsoFWtygCMsGMXQQEd+e2/9sT5
	 78nyKtttMfX19APJGQnI+ehbYaUvrWa0GQ2BQ8zzMSBUqfnMSWBVfrhf+VjfoQ1udy
	 nRHSgzhyoJjFQ==
Date: Thu, 29 Aug 2024 19:04:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 04/12] net-shapers: implement NL group
 operation
Message-ID: <20240829190445.7bb3a569@kernel.org>
In-Reply-To: <f67b0502e7e9e9e8452760c4d3ad7cdac648ecda.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<f67b0502e7e9e9e8452760c4d3ad7cdac648ecda.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:16:57 +0200 Paolo Abeni wrote:
> Allow grouping multiple leaves shaper under the given root.
> The root and the leaves shapers are created, if needed, otherwise
> the existing shapers are re-linked as requested.
> 
> Try hard to pre-allocated the needed resources, to avoid non
> trivial H/W configuration rollbacks in case of any failure.

Need to s/root/parent/ the commit message?

> +static int __net_shaper_group(struct net_shaper_binding *binding,
> +			      int leaves_count,
> +			      const struct net_shaper_handle *leaves_handles,
> +			      struct net_shaper_info *leaves,
> +			      struct net_shaper_handle *node_handle,
> +			      struct net_shaper_info *node,
> +			      struct netlink_ext_ack *extack)
> +{
> +	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
> +	struct net_shaper_info *parent = NULL;
> +	struct net_shaper_handle leaf_handle;
> +	int i, ret;
> +
> +	if (node_handle->scope == NET_SHAPER_SCOPE_NODE) {
> +		if (node_handle->id != NET_SHAPER_ID_UNSPEC &&
> +		    !net_shaper_cache_lookup(binding, node_handle)) {
> +			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
> +					   node_handle->scope, node_handle->id);

BAD_ATTR would do?

> +			return -ENOENT;
> +		}
> +
> +		/* When unspecified, the node parent scope is inherited from
> +		 * the leaves.
> +		 */
> +		if (node->parent.scope == NET_SHAPER_SCOPE_UNSPEC) {
> +			for (i = 1; i < leaves_count; ++i) {
> +				if (leaves[i].parent.scope !=
> +				    leaves[0].parent.scope ||
> +				    leaves[i].parent.id !=
> +				    leaves[0].parent.id) {

memcmp() ? put a BUILD_BUG_ON(sizeof() != 8) to make sure we double
check it if the struct grows?

> +					NL_SET_ERR_MSG_FMT(extack, "All the leaves shapers must have the same old parent");
> +					return -EINVAL;

5 indents is too many indents :( maybe make the for loop a helper?

> +				}
> +			}
> +
> +			if (leaves_count > 0)

how can we get here and not have leaves? :o

> +				node->parent = leaves[0].parent;
> +		}
> +
> +	} else {
> +		net_shaper_default_parent(node_handle, &node->parent);
> +	}

> +static int net_shaper_group_send_reply(struct genl_info *info,
> +				       struct net_shaper_handle *handle)
> +{
> +	struct net_shaper_binding *binding = info->user_ptr[0];
> +	struct sk_buff *msg;
> +	int ret = -EMSGSIZE;
> +	void *hdr;
> +
> +	/* Prepare the msg reply in advance, to avoid device operation
> +	 * rollback.
> +	 */
> +	msg = genlmsg_new(net_shaper_handle_size(), GFP_KERNEL);
> +	if (!msg)
> +		return ret;

return -ENOMEM;

> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr)
> +		goto free_msg;
> +
> +	if (net_shaper_fill_binding(msg, binding, NET_SHAPER_A_IFINDEX))
> +		goto free_msg;
> +
> +	if (net_shaper_fill_handle(msg, handle, NET_SHAPER_A_HANDLE))

you can combine the two fill ifs into one with ||

> +		goto free_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	ret = genlmsg_reply(msg, info);
> +	if (ret)
> +		goto free_msg;

reply always eats the skb, just:

	return genlmsg_reply(msg, info);

> +
> +	return ret;
> +
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;

return -EMSGSIZE;

> +}
> +
> +int net_shaper_nl_group_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct net_shaper_handle *leaves_handles, node_handle;
> +	struct net_shaper_info *leaves, node;
> +	struct net_shaper_binding *binding;
> +	int i, ret, rem, leaves_count;
> +	struct nlattr *attr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_LEAVES) ||
> +	    GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_NODE))
> +		return -EINVAL;
> +
> +	binding = net_shaper_binding_from_ctx(info->user_ptr[0]);
> +	leaves_count = net_shaper_list_len(info, NET_SHAPER_A_LEAVES);
> +	leaves = kcalloc(leaves_count, sizeof(struct net_shaper_info) +
> +			 sizeof(struct net_shaper_handle), GFP_KERNEL);
> +	if (!leaves) {
> +		GENL_SET_ERR_MSG_FMT(info, "Can't allocate memory for %d leaves shapers",
> +				     leaves_count);
> +		return -ENOMEM;
> +	}
> +	leaves_handles = (struct net_shaper_handle *)&leaves[leaves_count];
> +
> +	ret = net_shaper_parse_node(binding, info->attrs[NET_SHAPER_A_NODE],
> +				    info, &node_handle, &node);
> +	if (ret)
> +		goto free_shapers;
> +
> +	i = 0;
> +	nla_for_each_attr_type(attr, NET_SHAPER_A_LEAVES,
> +			       genlmsg_data(info->genlhdr),
> +			       genlmsg_len(info->genlhdr), rem) {
> +		if (WARN_ON_ONCE(i >= leaves_count))
> +			goto free_shapers;
> +
> +		ret = net_shaper_parse_info_nest(binding, attr, info,
> +						 NET_SHAPER_SCOPE_QUEUE,
> +						 &leaves_handles[i],

Wouldn't it be convenient to store the handle in the "info" object?
AFAIU the handle is forever for an info, so no risk of it being out 
of sync...

> +						 &leaves[i]);
> +		if (ret)
> +			goto free_shapers;
> +		i++;
> +	}
> +
> +	ret = net_shaper_group(binding, leaves_count, leaves_handles, leaves,
> +			       &node_handle, &node, info->extack);

...and it'd be nice if group had 5 rather than 7 params

> +	if (ret < 0)
> +		goto free_shapers;
> +
> +	ret = net_shaper_group_send_reply(info, &node_handle);
> +	if (ret) {
> +		/* Error on reply is not fatal to avoid rollback a successful
> +		 * configuration.

Slight issues with the grammar here, but I think it should be fatal.
The sender will most likely block until they get a response.
Not to mention that the caller will not know what the handle 
we allocated is.

> +		 */
> +		GENL_SET_ERR_MSG_FMT(info, "Can't send reply %d", ret);
> +		ret = 0;
> +	}
> +
> +free_shapers:
> +	kfree(leaves);
> +	return ret;
> +}

