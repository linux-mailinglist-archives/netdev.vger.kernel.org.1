Return-Path: <netdev+bounces-72676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A385922D
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 20:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158C6B2164D
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93601E501;
	Sat, 17 Feb 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="sTUaVv51"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56B134A4
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199081; cv=pass; b=sEOTmzn5Yi1/iMQ1smY0+CcgBeS+qne5mZilfvHlPqXqEiIkbHiBTUdsWeOAuWxGrNVsTqpU/bmujNWGgod5j6mdPfsQCEPP1Hi82dy73nO7zmSNh2T8SLByrowe0/oDS5hdZGx6D+A8MZyH1dAqx346uh4e8bXPUpUaG1vC0XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199081; c=relaxed/simple;
	bh=GEhmrw92VPzI1vUFs7EHQsHwCGl2JtJ5K3w0TqDCJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq/LMMXX4+hfehQDXLROk23QKBjj4AqYQajQrBQlqKiYrJ/I8xA9Q4GfPzaTDYK7T/mG63l/DqsK9BN4yxPdQX8D6+fGeqfdlCpVNHblDlJvKb5qXCs2n/rpAvh8U0CDVsx72YHVc7kODgatCKfyvWL796a8TY+O04475N3V5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=sTUaVv51; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1708199070; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Jk7k3U3J46/1GAua/1bZYgEhYSEs7d7K96Bpi005yIichF5qi9aHGlO9nD3AbX2FerhR1yKiaTjFyCrWTFIN/87SbJhGCg6uBjXpJ9B12dAFwR1PYclG2Ulz7ZSWd/abQarRlL5uGSA5BGVtqFeKsC2IWosxvkphwsZJnNgD8KI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1708199070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tfHKKxVrnCkZA0Dn0Br7kNfS1MeUhw1oe4FAsCJHdHY=; 
	b=SwOg2OERuJM71i1CqGtvZtI63GXZMpHJoueZi9/KOeZUa76oBGEkbfN3kfqMq/fTAQpZUyJFTzE7doDfBV2vk1G6p4l0K/OMQ784SJNVnUsZjJzPcOLFQSvAJvH9NgNrhKY/V+dofM8zgyjnE6qP/4htDDi07oI44XPGAvBz8GY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1708199070;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tfHKKxVrnCkZA0Dn0Br7kNfS1MeUhw1oe4FAsCJHdHY=;
	b=sTUaVv51fyK72c9N5DAltY7zC/RPUrp+qT+P+968fIFiuir4jvVdp+EcJfxv/cx4
	CWQb73kKZ5WfSYjzIPIvREuKs9bGRKvALWP0eKLYIR7aJigqgIj1gaFo/AJHnx0xE6z
	HwrdA+tjcZRI1nF/R4rGAevzPL3W96B3b30PB7lqNH8plLvdZbo3L8WMxghHy94Xd8r
	bFJkIW6j6JcWPLeN9W6cyjOT2DWCIXu3boExrUDm8Sxdx2DJ7wNIEcDGoCkcC4vaL5V
	bE+s8pAgUkWytahEftMNkAeccsNc/FsAkHo5BgMfvXDCrri+ngFaIm2rfuuUpAUZIpK
	dZW8aL3+YQ==
Received: from [192.168.1.222] (83.8.250.194.ipv4.supernova.orange.pl [83.8.250.194]) by mx.zohomail.com
	with SMTPS id 17081990681583.510485167691968; Sat, 17 Feb 2024 11:44:28 -0800 (PST)
Message-ID: <85f0669b-d9e5-416f-9887-8032a6553fa6@machnikowski.net>
Date: Sat, 17 Feb 2024 20:44:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/4] netdevsim: allow two netdevsim ports to
 be connected
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240217050418.3125504-1-dw@davidwei.uk>
 <20240217050418.3125504-2-dw@davidwei.uk>
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
In-Reply-To: <20240217050418.3125504-2-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 17/02/2024 06:04, David Wei wrote:
> Add two netdevsim bus attribute to sysfs:
> /sys/bus/netdevsim/link_device
> /sys/bus/netdevsim/unlink_device
> 
> Writing "A M B N" to link_device will link netdevsim M in netnsid A with
> netdevsim N in netnsid B.
> 
> Writing "A M" to unlink_device will unlink netdevsim M in netnsid A from
> its peer, if any.
> 
> rtnl_lock is taken to ensure nothing changes during the linking.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  drivers/net/netdevsim/bus.c       | 135 ++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdev.c    |  10 +++
>  drivers/net/netdevsim/netdevsim.h |   2 +
>  3 files changed, 147 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index aedab1d9623a..438b862cb577 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -232,9 +232,144 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
>  }
>  static BUS_ATTR_WO(del_device);
>  
> +static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
> +{
> +	struct netdevsim *nsim_a, *nsim_b, *peer;
> +	struct net_device *dev_a, *dev_b;
> +	unsigned int ifidx_a, ifidx_b;
> +	int netnsfd_a, netnsfd_b, err;
> +	struct net *ns_a, *ns_b;
> +
> +	err = sscanf(buf, "%d:%u %d:%u", &netnsfd_a, &ifidx_a, &netnsfd_b, &ifidx_b);
> +	if (err != 4) {
> +		pr_err("Format for linking two devices is \"netnsfd_a:ifidx_a netnsfd_b:ifidx_b\" (int uint int uint).\n");
> +		return -EINVAL;
> +	}
> +
> +	ns_a = get_net_ns_by_fd(netnsfd_a);
> +	if (IS_ERR(ns_a)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_a);
> +		return -EINVAL;
> +	}
> +
> +	ns_b = get_net_ns_by_fd(netnsfd_b);
> +	if (IS_ERR(ns_b)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd_b);
> +		put_net(ns_a);
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	dev_a = __dev_get_by_index(ns_a, ifidx_a);
> +	if (!dev_a) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_a, netnsfd_a);
> +		goto out_err;
> +	}
> +
> +	if (!netdev_is_nsim(dev_a)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_a, netnsfd_a);
> +		goto out_err;
> +	}
> +
> +	dev_b = __dev_get_by_index(ns_b, ifidx_b);
> +	if (!dev_b) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_b, netnsfd_b);
> +		goto out_err;
> +	}
> +
> +	if (!netdev_is_nsim(dev_b)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
> +		goto out_err;
> +	}
> +
> +	if (dev_a == dev_b) {
> +		pr_err("Cannot link a netdevsim to itself\n");
> +		goto out_err;
> +	}
> +
> +	err = 0;
> +	nsim_a = netdev_priv(dev_a);
> +	peer = rtnl_dereference(nsim_a->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
> +		goto out_err;
> +	}
> +
> +	nsim_b = netdev_priv(dev_b);
> +	peer = rtnl_dereference(nsim_b->peer);
> +	if (peer) {
> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b, ifidx_b);
> +		goto out_err;
> +	}
> +
> +	rcu_assign_pointer(nsim_a->peer, nsim_b);
> +	rcu_assign_pointer(nsim_b->peer, nsim_a);
> +
> +out_err:
> +	put_net(ns_b);
> +	put_net(ns_a);
> +	rtnl_unlock();
> +
> +	return !err ? count : err;
> +}
> +static BUS_ATTR_WO(link_device);
> +
> +static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
> +{
> +	struct netdevsim *nsim, *peer;
> +	struct net_device *dev;
> +	unsigned int ifidx;
> +	int netnsfd, err;
> +	struct net *ns;
> +
> +	err = sscanf(buf, "%u:%u", &netnsfd, &ifidx);
> +	if (err != 2) {
> +		pr_err("Format for unlinking a device is \"netnsfd:ifidx\" (int uint).\n");
> +		return -EINVAL;
> +	}
> +
> +	ns = get_net_ns_by_fd(netnsfd);
> +	if (IS_ERR(ns)) {
> +		pr_err("Could not find netns with fd: %d\n", netnsfd);
> +		return -EINVAL;
> +	}
> +
> +	err = -EINVAL;
> +	rtnl_lock();
> +	dev = __dev_get_by_index(ns, ifidx);
> +	if (!dev) {
> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx, netnsfd);
> +		goto out_put_netns;
> +	}
> +
> +	if (!netdev_is_nsim(dev)) {
> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx, netnsfd);
> +		goto out_put_netns;
> +	}
> +
> +	err = 0;
> +	nsim = netdev_priv(dev);
> +	peer = rtnl_dereference(nsim->peer);
> +	if (!peer)
> +		goto out_put_netns;
> +
> +	RCU_INIT_POINTER(nsim->peer, NULL);
> +	RCU_INIT_POINTER(peer->peer, NULL);
> +
> +out_put_netns:
> +	put_net(ns);
> +	rtnl_unlock();
> +
> +	return !err ? count : err;
> +}
> +static BUS_ATTR_WO(unlink_device);
> +
>  static struct attribute *nsim_bus_attrs[] = {
>  	&bus_attr_new_device.attr,
>  	&bus_attr_del_device.attr,
> +	&bus_attr_link_device.attr,
> +	&bus_attr_unlink_device.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(nsim_bus);
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 77e8250282a5..9063f4f2971b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -413,8 +413,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>  void nsim_destroy(struct netdevsim *ns)
>  {
>  	struct net_device *dev = ns->netdev;
> +	struct netdevsim *peer;
>  
>  	rtnl_lock();
> +	peer = rtnl_dereference(ns->peer);
> +	if (peer)
> +		RCU_INIT_POINTER(peer->peer, NULL);
> +	RCU_INIT_POINTER(ns->peer, NULL);
>  	unregister_netdevice(dev);
>  	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>  		nsim_macsec_teardown(ns);
> @@ -427,6 +432,11 @@ void nsim_destroy(struct netdevsim *ns)
>  	free_netdev(dev);
>  }
>  
> +bool netdev_is_nsim(struct net_device *dev)
> +{
> +	return dev->netdev_ops == &nsim_netdev_ops;
> +}
> +
>  static int nsim_validate(struct nlattr *tb[], struct nlattr *data[],
>  			 struct netlink_ext_ack *extack)
>  {
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index 028c825b86db..c8b45b0d955e 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -125,11 +125,13 @@ struct netdevsim {
>  	} udp_ports;
>  
>  	struct nsim_ethtool ethtool;
> +	struct netdevsim __rcu *peer;
>  };
>  
>  struct netdevsim *
>  nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port);
>  void nsim_destroy(struct netdevsim *ns);
> +bool netdev_is_nsim(struct net_device *dev);
>  
>  void nsim_ethtool_init(struct netdevsim *ns);
>  
Please cc people who commented previous patch revisions - makes it
easier to track progress.

Looks good to me!

Reviewed-by: Maciek Machnikowski <maciek@machnikowski.net>


