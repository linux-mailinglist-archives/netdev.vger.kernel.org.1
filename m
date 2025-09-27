Return-Path: <netdev+bounces-226834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E736BA57A6
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E351C0221B
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7F1F5820;
	Sat, 27 Sep 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="1L4vVknF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB24212B3D
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935428; cv=none; b=H/m/KfIT2QuXQ9VjlCL+hGXOkBEKLzF7vlyV2AbM70TNNHiqFXob6EotD02p58REGVixzwYqa8CMn3g0PSl2TQrL52Cng/NfATGRGs74ck1h0d9Z+y/SM3ICqD6KGxS28fwk6rjUWje5LRGqVeNd1AY4s7EESwSUdRCZ2Fmx8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935428; c=relaxed/simple;
	bh=eH+tmMAvM/AAGrlmYHqDDYpTkLGhq8nmwFzPlWLbw1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkGQe0D898capZWvnSh4cN0k8cNKyrZYgu7ym4nPAIfDjGr3DcHylNpzg1pjIPxEKM9DWQOhfV40exnu2g5sCZCi+W+L7ZuBp8lPboa3eWkUZh0NqUcda6aFe+SsNkODB5BcxdVPrJ1tD/p55lq7qFcOFXOVJdxpO94L5zPzj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=1L4vVknF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26808b24a00so3871505ad.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1758935426; x=1759540226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sS71HvFqwTzomYQRgxOmpGCI58SqoYhCQk5FjdViyP8=;
        b=1L4vVknFHm6GGGWDbNc/Vw1LWg+G6OwKyOZnBkJv9LIsdLT7j93c6q810iv1k0r98P
         J1bs3nyDynShMhlRvufcjiIDK8rpxm9JnSKpjIAuNX2vwvO/+Gfs0GhHvLZyBtNEniTD
         6FaHlE5jMWGscD9vkoUpFUBV5obXGI6tJEQI/G26N3ltxniEQhH9wkweGgh0F21QziYh
         Tv+aENwTasfA98Mrzu044IZzf1y3Kn29YcC1BIy9TE8xOqUEzO9/lLA4oPMF0Xzo8Yo5
         Qx0INOlAGQ7o9/REr2zFSwEaCBPC/zYJi2OGD1x7vpcPL4y/c+9Z/7GVMscwqNCEqiB4
         8tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935426; x=1759540226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS71HvFqwTzomYQRgxOmpGCI58SqoYhCQk5FjdViyP8=;
        b=NaSW1d0pq4UwcbLQvJqpBNsELGsU9cVQSJjWEG4/ad+muVlpSoEfWoLBubVxOp7d71
         tJWXcWN6cKlVjjqNR3aMC6GazdKHna07qtesd2y/J9xhPUDxLRG005WdieRUV0eCG5+4
         UdNjMeeUkSvbAsXXqX52rIO8lVjfqKx1mVPP/x7YlGYte7z2y8vgzMmrCkYLvIIkhUeT
         Ps9MK3x3oaOdaRDSUDdSafS5IOaZuqZKR1qEJmeVtNOaNBb/ggdovUnzpYIKfgYLDFsO
         tfTCtVM3vA4L99/Dv/pKqJIjKDUUKQGXzQfFKxDyxOI0sQ0cy+YGQPPl8L4BDQKtIONz
         9PcA==
X-Gm-Message-State: AOJu0YwUgIspCucmlfm8KVbYcS+6zJ9u0eUL5iiZSIqNDWJNA7SrjCIW
	9mC7ZVkaym1NUhec5G0ne8bCs62uLe4QicD7KKChDSh7L1DLh6agJWlo06TsBHoQ9tCkEv3v+YS
	Qahxp
X-Gm-Gg: ASbGncto7Qz8DuDnurc9Kjr9/ZjEmhgZrmmyJygW6m/qWc2Pz0TPLgHX2qt+W+nbiVE
	GyrNhZGjv/pHNrtGALXPY8NFwv4rODXYX6hIUjzkwmQjaoBsgFVPEaJNHLEm2To8H2YBPMmV+U1
	udW48NDQty+Tm/BpSiHRCMfy1kAcw0/ezBo6p6WIJvotJSAuV1yqqbtKxSsUyzbVsCiqYPAs8lq
	oH2p2d8epF0Da25Cnr7rGUlJTTRFn4Cf6dXYMhFtslX0t9hASVnQDYl+tNkR3thdteGqVc+RhrO
	XxUX6WVsz+n519PDiLyp4mE9wxkc2m43wcCBjthLIHp4H3FEO696H3MR2xI6xyzE962YDaZ58Me
	Fp44WXswHvZ6KdpUNUKW+1Ww7b3B0udoYOALXFIzAy+UD4nca3Qu4ACt80V8r
X-Google-Smtp-Source: AGHT+IH/fARBQD4l6W0sgJLvRkr1Zkx2PW6Ep3kRjtsj6Om/I7M1NqByhUQg9tdXiLKS0UzEd9yjZw==
X-Received: by 2002:a17:902:ea11:b0:25c:9a33:95fb with SMTP id d9443c01a7336-27ed4a967abmr57464245ad.8.1758935425956;
        Fri, 26 Sep 2025 18:10:25 -0700 (PDT)
Received: from m2 (192-184-204-241.fiber.dynamic.sonic.net. [192.184.204.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69be6cdsm65255915ad.125.2025.09.26.18.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:10:25 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:10:23 -0700
From: Jordan Rife <jordan@jrife.io>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com, willemb@google.com, 
	sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 14/20] netkit: Add single device mode for netkit
Message-ID: <mcwr6vpkmbmkrixfnwyxuph6ziy5r2of67vvhgkvpiwxezfdtu@mitfrbd52rty>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-15-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-15-daniel@iogearbox.net>

On Fri, Sep 19, 2025 at 11:31:47PM +0200, Daniel Borkmann wrote:
> Add a single device mode for netkit instead of netkit pairs. The primary
> target for the paired devices is to connect network namespaces, of course,
> and support has been implemented in projects like Cilium [0]. For the rxq
> binding the plan is to support two main scenarios related to single device
> mode:
> 
> * For the use-case of io_uring zero-copy, the control plane can either
>   set up a netkit pair where the peer device can perform rxq binding which
>   is then tied to the lifetime of the peer device, or the control plane
>   can use a regular netkit pair to connect the hostns to a Pod/container
>   and dynamically add/remove rxq bindings through a single device without
>   having to interrupt the device pair. In the case of io_uring, the memory
>   pool is used as skb non-linear pages, and thus the skb will go its way
>   through the regular stack into netkit. Things like the netkit policy when
>   no BPF is attached or skb scrubbing etc apply as-is in case the paired
>   devices are used, or if the backend memory is tied to the single device
>   and traffic goes through a paired device.
> 
> * For the use-case of AF_XDP, the control plane needs to use netkit in the
>   single device mode. The single device mode currently enforces only a
>   pass policy when no BPF is attached, and does not yet support BPF link
>   attachments for AF_XDP. skbs sent to that device get dropped at the
>   moment. Given AF_XDP operates at a lower layer of the stack tying this
>   to the netkit pair did not make sense. In future, the plan is to allow
>   BPF at the XDP layer which can: i) process traffic coming from the AF_XDP
>   application (e.g. QEMU with AF_XDP backend) to filter egress traffic or
>   to push selected egress traffic up to the single netkit device to the
>   local stack (e.g. DHCP requests), and ii) vice-versa skbs sent to the
>   single netkit into the AF_XDP application (e.g. DHCP replies). Also,
>   the control-plane can dynamically add/remove rxq bindings for the single
>   netkit device without having to interrupt (e.g. down/up cycle) the main
>   netkit pair for the Pod which has traffic going in and out.

This seems very cool. I'm curious, in single device mode, how would
traffic originating in the host ns make its way into a pod hosting a
QEMU VM using an AF_XDP backend? How would redirection work between two
such VMs on the same host?

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Link: https://docs.cilium.io/en/stable/operations/performance/tuning/#netkit-device-mode [0]
> ---
>  drivers/net/netkit.c         | 108 ++++++++++++++++++++++-------------
>  include/uapi/linux/if_link.h |   6 ++
>  2 files changed, 74 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 492be60f2e70..ceb1393ee599 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -25,6 +25,7 @@ struct netkit {
>  
>  	/* Needed in slow-path */
>  	enum netkit_mode mode;
> +	enum netkit_pairing pair;
>  	bool primary;
>  	u32 headroom;
>  };
> @@ -133,6 +134,10 @@ static int netkit_open(struct net_device *dev)
>  	struct netkit *nk = netkit_priv(dev);
>  	struct net_device *peer = rtnl_dereference(nk->peer);
>  
> +	if (nk->pair == NETKIT_DEVICE_SINGLE) {
> +		netif_carrier_on(dev);
> +		return 0;
> +	}
>  	if (!peer)
>  		return -ENOTCONN;
>  	if (peer->flags & IFF_UP) {
> @@ -333,6 +338,7 @@ static int netkit_new_link(struct net_device *dev,
>  	enum netkit_scrub scrub_prim = NETKIT_SCRUB_DEFAULT;
>  	enum netkit_scrub scrub_peer = NETKIT_SCRUB_DEFAULT;
>  	struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;
> +	enum netkit_pairing pair = NETKIT_DEVICE_PAIR;
>  	enum netkit_action policy_prim = NETKIT_PASS;
>  	enum netkit_action policy_peer = NETKIT_PASS;
>  	struct nlattr **data = params->data;
> @@ -341,7 +347,7 @@ static int netkit_new_link(struct net_device *dev,
>  	struct nlattr **tb = params->tb;
>  	u16 headroom = 0, tailroom = 0;
>  	struct ifinfomsg *ifmp = NULL;
> -	struct net_device *peer;
> +	struct net_device *peer = NULL;
>  	char ifname[IFNAMSIZ];
>  	struct netkit *nk;
>  	int err;
> @@ -378,6 +384,8 @@ static int netkit_new_link(struct net_device *dev,
>  			headroom = nla_get_u16(data[IFLA_NETKIT_HEADROOM]);
>  		if (data[IFLA_NETKIT_TAILROOM])
>  			tailroom = nla_get_u16(data[IFLA_NETKIT_TAILROOM]);
> +		if (data[IFLA_NETKIT_PAIRING])
> +			pair = nla_get_u32(data[IFLA_NETKIT_PAIRING]);
>  	}
>  
>  	if (ifmp && tbp[IFLA_IFNAME]) {
> @@ -390,45 +398,49 @@ static int netkit_new_link(struct net_device *dev,
>  	if (mode != NETKIT_L2 &&
>  	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
>  		return -EOPNOTSUPP;
> +	if (pair != NETKIT_DEVICE_PAIR &&

nit: IMO this would be a little clearer without the inverted logic:

if (pair == NETKIT_DEVICE_SINGLE &&

> +	    (tb != tbp ||
> +	     tb[IFLA_NETKIT_PEER_POLICY] ||
> +	     tb[IFLA_NETKIT_PEER_SCRUB] ||
> +	     policy_prim != NETKIT_PASS))
> +		return -EOPNOTSUPP;
>  
> -	peer = rtnl_create_link(peer_net, ifname, ifname_assign_type,
> -				&netkit_link_ops, tbp, extack);
> -	if (IS_ERR(peer))
> -		return PTR_ERR(peer);
> -
> -	netif_inherit_tso_max(peer, dev);
> -	if (headroom) {
> -		peer->needed_headroom = headroom;
> -		dev->needed_headroom = headroom;
> -	}
> -	if (tailroom) {
> -		peer->needed_tailroom = tailroom;
> -		dev->needed_tailroom = tailroom;
> -	}
> -
> -	if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
> -		eth_hw_addr_random(peer);
> -	if (ifmp && dev->ifindex)
> -		peer->ifindex = ifmp->ifi_index;
> -
> -	nk = netkit_priv(peer);
> -	nk->primary = false;
> -	nk->policy = policy_peer;
> -	nk->scrub = scrub_peer;
> -	nk->mode = mode;
> -	nk->headroom = headroom;
> -	bpf_mprog_bundle_init(&nk->bundle);
> +	if (pair == NETKIT_DEVICE_PAIR) {
> +		peer = rtnl_create_link(peer_net, ifname, ifname_assign_type,
> +					&netkit_link_ops, tbp, extack);
> +		if (IS_ERR(peer))
> +			return PTR_ERR(peer);
> +
> +		netif_inherit_tso_max(peer, dev);
> +		if (headroom)
> +			peer->needed_headroom = headroom;
> +		if (tailroom)
> +			peer->needed_tailroom = tailroom;
> +		if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
> +			eth_hw_addr_random(peer);
> +		if (ifmp && dev->ifindex)
> +			peer->ifindex = ifmp->ifi_index;
>  
> -	err = register_netdevice(peer);
> -	if (err < 0)
> -		goto err_register_peer;
> -	netif_carrier_off(peer);
> -	if (mode == NETKIT_L2)
> -		dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
> +		nk = netkit_priv(peer);
> +		nk->primary = false;
> +		nk->policy = policy_peer;
> +		nk->scrub = scrub_peer;
> +		nk->mode = mode;
> +		nk->pair = pair;
> +		nk->headroom = headroom;
> +		bpf_mprog_bundle_init(&nk->bundle);
> +
> +		err = register_netdevice(peer);
> +		if (err < 0)
> +			goto err_register_peer;
> +		netif_carrier_off(peer);
> +		if (mode == NETKIT_L2)
> +			dev_change_flags(peer, peer->flags & ~IFF_NOARP, NULL);
>  
> -	err = rtnl_configure_link(peer, NULL, 0, NULL);
> -	if (err < 0)
> -		goto err_configure_peer;
> +		err = rtnl_configure_link(peer, NULL, 0, NULL);
> +		if (err < 0)
> +			goto err_configure_peer;
> +	}
>  
>  	if (mode == NETKIT_L2 && !tb[IFLA_ADDRESS])
>  		eth_hw_addr_random(dev);
> @@ -436,12 +448,17 @@ static int netkit_new_link(struct net_device *dev,
>  		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
>  	else
>  		strscpy(dev->name, "nk%d", IFNAMSIZ);
> +	if (headroom)
> +		dev->needed_headroom = headroom;
> +	if (tailroom)
> +		dev->needed_tailroom = tailroom;
>  
>  	nk = netkit_priv(dev);
>  	nk->primary = true;
>  	nk->policy = policy_prim;
>  	nk->scrub = scrub_prim;
>  	nk->mode = mode;
> +	nk->pair = pair;
>  	nk->headroom = headroom;
>  	bpf_mprog_bundle_init(&nk->bundle);
>  
> @@ -453,10 +470,12 @@ static int netkit_new_link(struct net_device *dev,
>  		dev_change_flags(dev, dev->flags & ~IFF_NOARP, NULL);
>  
>  	rcu_assign_pointer(netkit_priv(dev)->peer, peer);
> -	rcu_assign_pointer(netkit_priv(peer)->peer, dev);
> +	if (peer)
> +		rcu_assign_pointer(netkit_priv(peer)->peer, dev);
>  	return 0;
>  err_configure_peer:
> -	unregister_netdevice(peer);
> +	if (peer)
> +		unregister_netdevice(peer);
>  	return err;
>  err_register_peer:
>  	free_netdev(peer);
> @@ -516,6 +535,8 @@ static struct net_device *netkit_dev_fetch(struct net *net, u32 ifindex, u32 whi
>  	nk = netkit_priv(dev);
>  	if (!nk->primary)
>  		return ERR_PTR(-EACCES);
> +	if (nk->pair == NETKIT_DEVICE_SINGLE)
> +		return ERR_PTR(-EOPNOTSUPP);
>  	if (which == BPF_NETKIT_PEER) {
>  		dev = rcu_dereference_rtnl(nk->peer);
>  		if (!dev)
> @@ -877,6 +898,7 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
>  		{ IFLA_NETKIT_PEER_INFO,  "peer info" },
>  		{ IFLA_NETKIT_HEADROOM,   "headroom" },
>  		{ IFLA_NETKIT_TAILROOM,   "tailroom" },
> +		{ IFLA_NETKIT_PAIRING,    "pairing" },
>  	};
>  
>  	if (!nk->primary) {
> @@ -896,9 +918,11 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
>  	}
>  
>  	if (data[IFLA_NETKIT_POLICY]) {
> +		err = -EOPNOTSUPP;
>  		attr = data[IFLA_NETKIT_POLICY];
>  		policy = nla_get_u32(attr);
> -		err = netkit_check_policy(policy, attr, extack);
> +		if (nk->pair == NETKIT_DEVICE_PAIR)
> +			err = netkit_check_policy(policy, attr, extack);
>  		if (err)
>  			return err;
>  		WRITE_ONCE(nk->policy, policy);
> @@ -929,6 +953,7 @@ static size_t netkit_get_size(const struct net_device *dev)
>  	       nla_total_size(sizeof(u8))  + /* IFLA_NETKIT_PRIMARY */
>  	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_HEADROOM */
>  	       nla_total_size(sizeof(u16)) + /* IFLA_NETKIT_TAILROOM */
> +	       nla_total_size(sizeof(u32)) + /* IFLA_NETKIT_PAIRING */
>  	       0;
>  }
>  
> @@ -949,6 +974,8 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		return -EMSGSIZE;
>  	if (nla_put_u16(skb, IFLA_NETKIT_TAILROOM, dev->needed_tailroom))
>  		return -EMSGSIZE;
> +	if (nla_put_u32(skb, IFLA_NETKIT_PAIRING, nk->pair))
> +		return -EMSGSIZE;
>  
>  	if (peer) {
>  		nk = netkit_priv(peer);
> @@ -970,6 +997,7 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>  	[IFLA_NETKIT_TAILROOM]		= { .type = NLA_U16 },
>  	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
>  	[IFLA_NETKIT_PEER_SCRUB]	= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
> +	[IFLA_NETKIT_PAIRING]		= NLA_POLICY_MAX(NLA_U32, NETKIT_DEVICE_SINGLE),
>  	[IFLA_NETKIT_PRIMARY]		= { .type = NLA_REJECT,
>  					    .reject_message = "Primary attribute is read-only" },
>  };
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 45f56c9f95d9..4a2f781f3cca 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1294,6 +1294,11 @@ enum netkit_mode {
>  	NETKIT_L3,
>  };
>  
> +enum netkit_pairing {
> +	NETKIT_DEVICE_PAIR,
> +	NETKIT_DEVICE_SINGLE,
> +};
> +
>  /* NETKIT_SCRUB_NONE leaves clearing skb->{mark,priority} up to
>   * the BPF program if attached. This also means the latter can
>   * consume the two fields if they were populated earlier.
> @@ -1318,6 +1323,7 @@ enum {
>  	IFLA_NETKIT_PEER_SCRUB,
>  	IFLA_NETKIT_HEADROOM,
>  	IFLA_NETKIT_TAILROOM,
> +	IFLA_NETKIT_PAIRING,
>  	__IFLA_NETKIT_MAX,
>  };
>  #define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
> -- 
> 2.43.0
>

Reviewed-by: Jordan Rife <jordan@jrife.io>

