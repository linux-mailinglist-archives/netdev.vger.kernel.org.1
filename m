Return-Path: <netdev+bounces-121209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800695C31E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450451C224E8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D61CA96;
	Fri, 23 Aug 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g83MeRdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4C79C2
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379044; cv=none; b=DR+fXH0ku9kQvZ12bDZcjr7yFiFGnGJLhW3oZBzykP9NVsDaftcG4XSokk6jWOi9Mo5EeGddks/8K18XHnwea0XEpOdTMUIKYk6MIdbY93iR7F6isW38r10XD3EAUgmr4R6F+ErIYhzwwbh2of/GEe2kZG/GtdOttw/6uUqE8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379044; c=relaxed/simple;
	bh=1Vnw4BxoYy6vOmUUeeZDqgC/igIarcd5B2kwf0aZOLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGQel5iV0izBENgFzhVPL8TbOX7f52sO5tWXCCD20nqaDxaaz0y4It+S53Z9tcn0qkQvhRhTzVvcZ2wSqiPzjbdJrTu/NsH+8HCWVSsg7ZqFxO2B4g0hdBCW3ZuZKk5EfaHWyhMNh8zBXj11TotJ8O0a5Y48YGFwVyuzhVaj1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g83MeRdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC69C32782;
	Fri, 23 Aug 2024 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724379043;
	bh=1Vnw4BxoYy6vOmUUeeZDqgC/igIarcd5B2kwf0aZOLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g83MeRdUpzlzxk11bncQhQgiDj+WSrXaK4Jqbsisxu8ih+xiqlfR8mx4aue1aE7yA
	 9ulzwAT3VI/p3UtCbmmePp7MYZstgCojlXFSKMz0He0sBPXthLrRQnJWIwf2n7P48S
	 NqImWX5xe0O2l+NPzQnBtT0dPb+uBli6RdOKhiTzrOQPGzpv+WGZCTPcLLRM2muLt/
	 FSm7Xgv3UrQleak7XwjW9rDsCe7g92SuNi0ux936pqlmHF60gZQM/iQKJ55thY98Fp
	 j0OyXwuHuwK0CKP3KQRHf/N4nZiivGnSksx06Ca+iJvDqd4Hy8jsRixW9UuNMT4piY
	 ylUPgeqwA4ehg==
Date: Thu, 22 Aug 2024 19:10:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 03/12] net-shapers: implement NL get
 operation
Message-ID: <20240822191042.71a19582@kernel.org>
In-Reply-To: <c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Aug 2024 17:12:24 +0200 Paolo Abeni wrote:
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -81,6 +81,8 @@ struct xdp_frame;
>  struct xdp_metadata_ops;
>  struct xdp_md;
>  struct ethtool_netdev_state;
> +struct net_shaper_ops;
> +struct net_shaper_data;

no need, forward declarations are only needed for function declarations

> + * struct net_shaper_ops - Operations on device H/W shapers
> + *
> + * The initial shaping configuration at device initialization is empty:
> + * does not constraint the rate in any way.
> + * The network core keeps track of the applied user-configuration in
> + * the net_device structure.
> + * The operations are serialized via a per network device lock.
> + *
> + * Each shaper is uniquely identified within the device with an 'handle'

a handle

> + * comprising the shaper scope and a scope-specific id.
> + */
> +struct net_shaper_ops {
> +	/**
> +	 * @group: create the specified shapers scheduling group
> +	 *
> +	 * Nest the @leaves shapers identified by @leaves_handles under the
> +	 * @root shaper identified by @root_handle. All the shapers belong
> +	 * to the network device @dev. The @leaves and @leaves_handles shaper
> +	 * arrays size is specified by @leaves_count.
> +	 * Create either the @leaves and the @root shaper; or if they already
> +	 * exists, links them together in the desired way.
> +	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.

Or SCOPE_NODE, no?

> +	 * Returns 0 on group successfully created, otherwise an negative
> +	 * error value and set @extack to describe the failure's reason.

the return and extack lines are pretty obvious, you can drop

> +	 */
> +	int (*group)(struct net_device *dev, int leaves_count,
> +		     const struct net_shaper_handle *leaves_handles,
> +		     const struct net_shaper_info *leaves,
> +		     const struct net_shaper_handle *root_handle,
> +		     const struct net_shaper_info *root,
> +		     struct netlink_ext_ack *extack);

> +#endif
> +

ooh, here's one of the trailing whitespace git was mentioning :)

>  #include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/idr.h>
> +#include <linux/netdevice.h>
> +#include <linux/netlink.h>
>  #include <linux/skbuff.h>
> +#include <linux/xarray.h>
> +#include <net/net_shaper.h>

kernel.h between idr.h and netdevice.h

> +static int net_shaper_fill_handle(struct sk_buff *msg,
> +				  const struct net_shaper_handle *handle,
> +				  u32 type, const struct genl_info *info)
> +{
> +	struct nlattr *handle_attr;
> +
> +	if (handle->scope =3D=3D NET_SHAPER_SCOPE_UNSPEC)
> +		return 0;

In what context can we try to fill handle with scope unspec?

> +	handle_attr =3D nla_nest_start_noflag(msg, type);
> +	if (!handle_attr)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE, handle->scope) ||
> +	    (handle->scope >=3D NET_SHAPER_SCOPE_QUEUE &&
> +	     nla_put_u32(msg, NET_SHAPER_A_ID, handle->id)))
> +		goto handle_nest_cancel;

So netdev root has no id and no scope?

> +	nla_nest_end(msg, handle_attr);
> +	return 0;
> +
> +handle_nest_cancel:
> +	nla_nest_cancel(msg, handle_attr);
> +	return -EMSGSIZE;
> +}

> +/* On success sets pdev to the relevant device and acquires a reference
> + * to it.
> + */
> +static int net_shaper_fetch_dev(const struct genl_info *info,
> +				struct net_device **pdev)
> +{
> +	struct net *ns =3D genl_info_net(info);
> +	struct net_device *dev;
> +	int ifindex;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NET_SHAPER_A_IFINDEX))
> +		return -EINVAL;
> +
> +	ifindex =3D nla_get_u32(info->attrs[NET_SHAPER_A_IFINDEX]);
> +	dev =3D dev_get_by_index(ns, ifindex);

netdev_get_by_index()

> +	if (!dev) {
> +		GENL_SET_ERR_MSG_FMT(info, "device %d not found", ifindex);

Point to the IFINDEX attribute, return -ENOENT.
Please only use string errors when there's no way of expressing=20
the error with machine readable attrs.

> +		return -EINVAL;
> +	}
> +
> +	if (!dev->netdev_ops->net_shaper_ops) {
> +		GENL_SET_ERR_MSG_FMT(info, "device %s does not support H/W shaper",
> +				     dev->name);

same as a above, point at device, -EOPNOTSUPP

> +		netdev_put(dev, NULL);

I appears someone is coding to patchwork checks =F0=9F=A7=90=EF=B8=8F

