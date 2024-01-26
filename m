Return-Path: <netdev+bounces-66078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FA83D284
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01A3B2884A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1979D9;
	Fri, 26 Jan 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akbUioO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154686AD6
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235845; cv=none; b=nCsStQQvE6JJMivaZwmxnfLeIHu9/4BRgCvqxOK0nAn+yxpmG8l/s/ERrgbq5XpwhtClW1R9XsRvO4vYdbAaFk5Xb0n5wG5PVp182sh0GbOphnI/z66HhYJ8tejuB3r0zIK2PZC48gvjuxBa9RbpsCSUU4oX7HiWEqUIRF7NusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235845; c=relaxed/simple;
	bh=aEUlbcw885E3qQFoqD4WobwiAkc1qMyIH1rqMgxxa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMplT5/uduTLaLa1wgap5RqeX7iyz0YG/jg4d+5bicYRd7JV+drwKcCEzREVHlfEj3Xg/yIVi9/OVsV2RHdXbBZhnUCm9vZ7yrDKrpu5xxgxfEAdOL5lp04ojtWaFh/HA3OZUo92dmwZkLul4bkAEYD+5BrBD5rwmBX0bVzppkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akbUioO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5089BC433C7;
	Fri, 26 Jan 2024 02:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706235844;
	bh=aEUlbcw885E3qQFoqD4WobwiAkc1qMyIH1rqMgxxa7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akbUioO4Am985o6ANEfOhgLq5qgFmW7v7gBjlimxl0EIx0EcGazRNXlm+DJXnI3YA
	 RuLVlm9c7qy2tZQQ18R8w/tofS1dFeqIy4iHzW+NuMfjV3erppaqVfnd2kuZ8wtw5Y
	 WZSi6TWwhhAoDn7f9A3qvodDVfpVTSupB2EVU2P115TtpGf0771aWgKOdHoAv6kYu6
	 HI3W1KDkWnkPtuXMLp869/rmWCLmK4Y2vs5X2wu531WL89CFXkGG+DUU9KNFkTr/8D
	 ABiZjOgL13glrfnCbJMXbxhZtgvkMrKHQga6wtE/Ie1JDrFkbPC6+X7iVtftY3qGNb
	 SmKiYgCBzhVpA==
Date: Thu, 25 Jan 2024 18:24:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <20240125182403.13c4475b@kernel.org>
In-Reply-To: <20240126012357.535494-2-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
	<20240126012357.535494-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 17:23:54 -0800 David Wei wrote:
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index bcbc1e19edde..be8ac2e60c69 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -232,9 +232,81 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
>  }
>  static BUS_ATTR_WO(del_device);
>  
> +static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
> +{
> +	unsigned int netnsid_a, netnsid_b, ifidx_a, ifidx_b;
> +	struct netdevsim *nsim_a, *nsim_b;
> +	struct net_device *dev_a, *dev_b;
> +	struct net *ns_a, *ns_b;
> +	int err;
> +
> +	err = sscanf(buf, "%u %u %u %u", &netnsid_a, &ifidx_a, &netnsid_b, &ifidx_b);

I'd go for "%u:%u %u:%u" to make the 'grouping' of netns and ifindex
more obvious. But no strong feelings.

> +	if (err != 4) {
> +		pr_err("Format for linking two devices is \"netnsid_a ifidx_a netnsid_b ifidx_b\" (uint uint unit uint).\n");
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	ns_a = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_a);
> +	if (!ns_a) {
> +		pr_err("Could not find netns with id: %d\n", netnsid_a);
> +		goto out_unlock_rtnl;
> +	}
> +
> +	dev_a = dev_get_by_index(ns_a, ifidx_a);

since you're under rtnl_lock you can use __get_device_by_index(),
it doesn't increase the refcount so you won't have to worry about
releasing it.

> +	if (!dev_a) {
> +		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_a, netnsid_a);
> +		goto out_put_netns_a;
> +	}
> +
> +	if (!netdev_is_nsim(dev_a)) {
> +		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_a, netnsid_a);
> +		goto out_put_dev_a;
> +	}
> +
> +	ns_b = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_b);
> +	if (!ns_b) {
> +		pr_err("Could not find netns with id: %d\n", netnsid_b);
> +		goto out_put_dev_a;
> +	}
> +
> +	dev_b = dev_get_by_index(ns_b, ifidx_b);
> +	if (!dev_b) {
> +		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_b, netnsid_b);
> +		goto out_put_netns_b;
> +	}
> +
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_b, netnsid_b);
> +		goto out_put_dev_b;
> +	}
> +
> +	err = 0;
> +	nsim_a = netdev_priv(dev_a);
> +	nsim_b = netdev_priv(dev_b);
> +	rcu_assign_pointer(nsim_a->peer, nsim_b);
> +	rcu_assign_pointer(nsim_b->peer, nsim_a);

Shouldn't we check if peer is NULL? Otherwise we can get into weird
situations where we link A<>B then B<>C and then the pointers look like
this A->B<>C. When B gets freed A's pointer won't get cleared.

> +out_put_dev_b:
> +	dev_put(dev_b);
> +out_put_netns_b:
> +	put_net(ns_b);
> +out_put_dev_a:
> +	dev_put(dev_a);
> +out_put_netns_a:
> +	put_net(ns_a);
> +out_unlock_rtnl:
> +	rtnl_unlock();
> +
> +	return !err ? count : err;
> +}
> +static BUS_ATTR_WO(link_device);

