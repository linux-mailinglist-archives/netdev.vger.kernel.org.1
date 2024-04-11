Return-Path: <netdev+bounces-86918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE718A0C81
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9701C2087C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C6144D35;
	Thu, 11 Apr 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmhslzfs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04101448E3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828175; cv=none; b=NQyK2GTkK95uwVZNluXFziChCDn9bhjbTkCg3ZKgAlKtuuaCrw9nXrgXuPxVlG9hGbiW+3pnb9EYj1pH/ND+bWFFp7NGAgdNunlaLNtO6hXzbvH9O4JzXqmSdEn/THIhe8uYN2JiNKfYPUGAXxZlRMH0YQZ4euzxlwEKNTyULrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828175; c=relaxed/simple;
	bh=RXmc29eQZGbK0zuoPnXkAnwF6HYn6+Q0wFSYMK+OvwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7+BB9kqlYRq5qsMr5BP5bFA7Mgp4p2Y4vQ0V4RmYjyHB28QztZRZg+WDAyd5K3VQ0SsnEG6eMpNxKXDZ9rX4WZxvssTFSPSTfZAEeC4FjiiRFfqGdVqgMFGIXs7OGxzYmBjaIYiaSg/9VrQ5T0J7c0J8GTtPwyudhzV1DtRWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmhslzfs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2bbc2048eso63124155ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712828173; x=1713432973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVBJIQug8yqCUUIfJEa9eFfFbhAzWoMESo2JpVscuTw=;
        b=FmhslzfsB5TN8N6iUuYm0Ksmg5Yy9bIhxZOotFsjMw9hMqwGUAzImA71g11QfZiBOu
         guqjijAOvnXfrcs21CvUoUW3fHOgDRf/jADjPRiGUz5R1BzXSmSFo3htacMpM4WhZJxx
         0wYYC2ybM2hoxelabca2ZGgBM6f7EIMbBRcxnFpb/LPAKfsIjP9fSUmrUIzqZtV1khtc
         Q0QSjHAg2vwpJZF2AvEKiUTw+bALcTGPnkywfAT1DFWBu4pNMqAOnMtt6x6vHnLhrPF4
         N259r2iNnxz6+aWiNvQTiQRL2PdbX7ueIGBsGrwwcpWhoPE4IWP5eHDzS+LPY/wwXM+K
         CjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828173; x=1713432973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVBJIQug8yqCUUIfJEa9eFfFbhAzWoMESo2JpVscuTw=;
        b=YJT1xzVGFsqmGk2NrXt5kh1kkWuf75E6lSsxneNrCwOj4s8u8NaUj/v8H1D9LDDM7g
         AW34rOpateGRv0QWwHuNw3eyFfCI3wRBqn6JPyn6v57I7m/yMTCQyk566j58OIJmYRhk
         YHHg+6I2ni0p2DzxpgMTHKKaWgsrXnNA34YlAV5QX3EPGlt4P91hnjdEJZBRrviJ2uSu
         FOUDWO1ntajzu0C71Icz97TQB3QsZzNW2cHwke6jlwNo04n1T3wtpCwhaL6hmCh7v6kH
         a36199DH2hNqRwE+OAqdzU4FEp1NB10vrjXN6evlnZrJNIHLcg1a6k4eOGDagw00SsuY
         HZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWTKZAjQkUDhpddt4FLiewuyQdZhhl0Ey52feHlGAYFnpwcd6LSY317yrC2pRfqvVLScBt+J8ave+3kNyZ/tYMCulmzPXzu
X-Gm-Message-State: AOJu0YwI94rGvpnl+iSTvhaNhRAPPLjYZ4KmBAJUReUz30uQIe261v34
	Y8EOq5na0v9KTA6jZP+8BPCRnxW7kz95lIHicEoChomx1sfM/jbR
X-Google-Smtp-Source: AGHT+IHV7EZMPbZySGd1apdjyW+oekX0mZR0/x6yGmcYyt0RbvXf7ed2pqzlwRBTcVVH4D+APkIu5Q==
X-Received: by 2002:a17:902:eccf:b0:1e4:2b90:7589 with SMTP id a15-20020a170902eccf00b001e42b907589mr5574710plh.61.1712828173043;
        Thu, 11 Apr 2024 02:36:13 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b001e446490ad1sm798918plg.271.2024.04.11.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:36:12 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:36:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	David Ahern <dsahern@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next] ipv4: Set scope explicitly in ip_route_output().
Message-ID: <ZhevBkZJBfgLjyLL@Laptop-X1>
References: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3c874fb825cdc030f729d2e48e6f45f3e3527f.1712347466.git.gnault@redhat.com>

On Fri, Apr 05, 2024 at 10:05:00PM +0200, Guillaume Nault wrote:
> Add a "scope" parameter to ip_route_output() so that callers don't have
> to override the tos parameter with the RTO_ONLINK flag if they want a
> local scope.
> 
> This will allow converting flowi4_tos to dscp_t in the future, thus
> allowing static analysers to flag invalid interactions between
> "tos" (the DSCP bits) and ECN.
> 
> Only three users ask for local scope (bonding, arp and atm). The others
> continue to use RT_SCOPE_UNIVERSE. While there, add a comment to warn
> users about the limitations of ip_route_output().
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c        | 3 ++-
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 3 ++-
>  drivers/net/bonding/bond_main.c         | 4 ++--
>  drivers/net/ethernet/broadcom/cnic.c    | 3 ++-
>  include/net/route.h                     | 9 ++++++++-
>  net/atm/clip.c                          | 2 +-
>  net/bridge/br_netfilter_hooks.c         | 3 ++-
>  net/ipv4/arp.c                          | 9 ++++++---
>  net/ipv4/igmp.c                         | 3 ++-
>  net/mpls/af_mpls.c                      | 2 +-
>  10 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
> index 1ee7a4e0d8d8..36bb7e5ce638 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -1985,7 +1985,8 @@ static int irdma_addr_resolve_neigh(struct irdma_device *iwdev, u32 src_ip,
>  	__be32 dst_ipaddr = htonl(dst_ip);
>  	__be32 src_ipaddr = htonl(src_ip);
>  
> -	rt = ip_route_output(&init_net, dst_ipaddr, src_ipaddr, 0, 0);
> +	rt = ip_route_output(&init_net, dst_ipaddr, src_ipaddr, 0, 0,
> +			     RT_SCOPE_UNIVERSE);
>  	if (IS_ERR(rt)) {
>  		ibdev_dbg(&iwdev->ibdev, "CM: ip_route_output fail\n");
>  		return -EINVAL;
> diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> index a51fc6854984..259303b9907c 100644
> --- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
> @@ -447,7 +447,8 @@ qedr_addr4_resolve(struct qedr_dev *dev,
>  	struct rtable *rt = NULL;
>  	int rc = 0;
>  
> -	rt = ip_route_output(&init_net, dst_ip, src_ip, 0, 0);
> +	rt = ip_route_output(&init_net, dst_ip, src_ip, 0, 0,
> +			     RT_SCOPE_UNIVERSE);
>  	if (IS_ERR(rt)) {
>  		DP_ERR(dev, "ip_route_output returned error\n");
>  		return -EINVAL;
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 2c5ed0a7cb18..c9f0415f780a 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3014,8 +3014,8 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>  		tags = NULL;
>  
>  		/* Find out through which dev should the packet go */
> -		rt = ip_route_output(dev_net(bond->dev), targets[i], 0,
> -				     RTO_ONLINK, 0);
> +		rt = ip_route_output(dev_net(bond->dev), targets[i], 0, 0, 0,
> +				     RT_SCOPE_LINK);
>  		if (IS_ERR(rt)) {
>  			/* there's no route to target - try to send arp
>  			 * probe to generate any traffic (arp_validate=0)
> diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
> index 3d63177e7e52..c2b4188a1ef1 100644
> --- a/drivers/net/ethernet/broadcom/cnic.c
> +++ b/drivers/net/ethernet/broadcom/cnic.c
> @@ -3682,7 +3682,8 @@ static int cnic_get_v4_route(struct sockaddr_in *dst_addr,
>  #if defined(CONFIG_INET)
>  	struct rtable *rt;
>  
> -	rt = ip_route_output(&init_net, dst_addr->sin_addr.s_addr, 0, 0, 0);
> +	rt = ip_route_output(&init_net, dst_addr->sin_addr.s_addr, 0, 0, 0,
> +			     RT_SCOPE_UNIVERSE);
>  	if (!IS_ERR(rt)) {
>  		*dst = &rt->dst;
>  		return 0;
> diff --git a/include/net/route.h b/include/net/route.h
> index d4a0147942f1..315a8acee6c6 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -141,15 +141,22 @@ static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4
>  	return ip_route_output_flow(net, flp, NULL);
>  }
>  
> +/* Simplistic IPv4 route lookup function.
> + * This is only suitable for some particular use cases: since the flowi4
> + * structure is only partially set, it may bypass some fib-rules.
> + */
>  static inline struct rtable *ip_route_output(struct net *net, __be32 daddr,
> -					     __be32 saddr, u8 tos, int oif)
> +					     __be32 saddr, u8 tos, int oif,
> +					     __u8 scope)
>  {
>  	struct flowi4 fl4 = {
>  		.flowi4_oif = oif,
>  		.flowi4_tos = tos,
> +		.flowi4_scope = scope,
>  		.daddr = daddr,
>  		.saddr = saddr,
>  	};
> +
>  	return ip_route_output_key(net, &fl4);
>  }
>  
> diff --git a/net/atm/clip.c b/net/atm/clip.c
> index 294cb9efe3d3..362e8d25a79e 100644
> --- a/net/atm/clip.c
> +++ b/net/atm/clip.c
> @@ -463,7 +463,7 @@ static int clip_setentry(struct atm_vcc *vcc, __be32 ip)
>  		unlink_clip_vcc(clip_vcc);
>  		return 0;
>  	}
> -	rt = ip_route_output(&init_net, ip, 0, 1, 0);
> +	rt = ip_route_output(&init_net, ip, 0, 0, 0, RT_SCOPE_LINK);
>  	if (IS_ERR(rt))
>  		return PTR_ERR(rt);
>  	neigh = __neigh_lookup(&arp_tbl, &ip, rt->dst.dev, 1);
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index 35e10c5a766d..4242447be322 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -399,7 +399,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
>  				goto free_skb;
>  
>  			rt = ip_route_output(net, iph->daddr, 0,
> -					     RT_TOS(iph->tos), 0);
> +					     RT_TOS(iph->tos), 0,
> +					     RT_SCOPE_UNIVERSE);
>  			if (!IS_ERR(rt)) {
>  				/* - Bridged-and-DNAT'ed traffic doesn't
>  				 *   require ip_forwarding. */
> diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
> index 0d0d725b46ad..ab82ca104496 100644
> --- a/net/ipv4/arp.c
> +++ b/net/ipv4/arp.c
> @@ -456,7 +456,8 @@ static int arp_filter(__be32 sip, __be32 tip, struct net_device *dev)
>  	/*unsigned long now; */
>  	struct net *net = dev_net(dev);
>  
> -	rt = ip_route_output(net, sip, tip, 0, l3mdev_master_ifindex_rcu(dev));
> +	rt = ip_route_output(net, sip, tip, 0, l3mdev_master_ifindex_rcu(dev),
> +			     RT_SCOPE_UNIVERSE);
>  	if (IS_ERR(rt))
>  		return 1;
>  	if (rt->dst.dev != dev) {
> @@ -1056,7 +1057,8 @@ static int arp_req_set(struct net *net, struct arpreq *r,
>  	if (r->arp_flags & ATF_PERM)
>  		r->arp_flags |= ATF_COM;
>  	if (!dev) {
> -		struct rtable *rt = ip_route_output(net, ip, 0, RTO_ONLINK, 0);
> +		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
> +						    RT_SCOPE_LINK);
>  
>  		if (IS_ERR(rt))
>  			return PTR_ERR(rt);
> @@ -1188,7 +1190,8 @@ static int arp_req_delete(struct net *net, struct arpreq *r,
>  
>  	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
>  	if (!dev) {
> -		struct rtable *rt = ip_route_output(net, ip, 0, RTO_ONLINK, 0);
> +		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
> +						    RT_SCOPE_LINK);
>  		if (IS_ERR(rt))
>  			return PTR_ERR(rt);
>  		dev = rt->dst.dev;
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 717e97a389a8..9bf09de6a2e7 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1842,7 +1842,8 @@ static struct in_device *ip_mc_find_dev(struct net *net, struct ip_mreqn *imr)
>  	if (!dev) {
>  		struct rtable *rt = ip_route_output(net,
>  						    imr->imr_multiaddr.s_addr,
> -						    0, 0, 0);
> +						    0, 0, 0,
> +						    RT_SCOPE_UNIVERSE);
>  		if (!IS_ERR(rt)) {
>  			dev = rt->dst.dev;
>  			ip_rt_put(rt);
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 6dab883a08dd..1303acb9cdd2 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -594,7 +594,7 @@ static struct net_device *inet_fib_lookup_dev(struct net *net,
>  	struct in_addr daddr;
>  
>  	memcpy(&daddr, addr, sizeof(struct in_addr));
> -	rt = ip_route_output(net, daddr.s_addr, 0, 0, 0);
> +	rt = ip_route_output(net, daddr.s_addr, 0, 0, 0, RT_SCOPE_UNIVERSE);
>  	if (IS_ERR(rt))
>  		return ERR_CAST(rt);
>  
> -- 
> 2.39.2
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

