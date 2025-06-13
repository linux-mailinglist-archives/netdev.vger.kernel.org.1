Return-Path: <netdev+bounces-197572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BCCAD938A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DC21BC29A3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689DE221FBE;
	Fri, 13 Jun 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIArIpM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010C221727
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834701; cv=none; b=kzPGHvN+uYq/Lt6UxQJ7U6WvoIyjIWQhsIJ8BT79sfBKAhnd/XAKiSSxrELKX+UB82ANUGwBmvmmzu6k93eDGFtxlLuQy4ueN86jn2YzWvSFFfiO7lrfHBzSw1SRvr5V+xdlspAgsThce35lFJx2QF0k2RB0TvRHv01SyxgGzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834701; c=relaxed/simple;
	bh=2AGD9Ae/vSJEt9BhoOQK34+j0dU6umT3cC6voBrdlUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWFrpB/RQl+0j4VvaNRKecUBQf3KVzr/UmEW8s5i0+DRpEMRYcEmsQpb4dpRI9bo8pSuIjqTRFNrXxn5eg8P07oHyHY+m9gztZikV7cnzkPP/m1DH8MSVPdtO1STc9IX2xuQjGph8gpiv+1UeJ96pFyXD/jS/HVKZThWN9gsh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIArIpM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481A3C4CEE3;
	Fri, 13 Jun 2025 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749834700;
	bh=2AGD9Ae/vSJEt9BhoOQK34+j0dU6umT3cC6voBrdlUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIArIpM+f0ueCTkSwci44alnaytY/XxT8pyOjl4BUEDaR6OeNrzwRrnO+BCdzE9U8
	 Xb0eYgTFd1/xzDXmkXRFDmzcAJdhDNI06Vad6GeAjm/i+mTCuKgdzGjbZJ7CI3Ikmm
	 QFzXCeU/5ieujJo0XKvz93T2WZ0NqwVVNHWtYDWjOR4HUpuIaaU1MXEaq6f5ORLR/Q
	 iOE7of/RW2f+hecfBHpUfsmV8YQId6zL9Crv10+GU3+0J2BpMaJ3mLH1kzYzAM0Hke
	 vyatL3ApGwZUksEufLZqwlmvpHtTlVk3kn9QschbhQWDRu2TF3TbrJ55phnZXj/sFw
	 2Oz9BD1LCwjtg==
Date: Fri, 13 Jun 2025 18:11:37 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 12/13] net: mctp: add gateway routing support
Message-ID: <20250613171137.GM414686@horms.kernel.org>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
 <20250611-dev-forwarding-v1-12-6b69b1feb37f@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-dev-forwarding-v1-12-6b69b1feb37f@codeconstruct.com.au>

On Wed, Jun 11, 2025 at 02:30:39PM +0800, Jeremy Kerr wrote:
> This change allows for gateway routing, where a route table entry
> may reference a routable endpoint (by network and EID), instead of
> routing directly to a netdevice.
> 
> We add support for a RTM_GATEWAY attribute for netlink route updates,
> with an attribute format of:
> 
>     struct mctp_fq_addr {
>         unsigned int net;
>         mctp_eid_t eid;
>     }
> 
> - we need the net here to uniquely identify the target EID, as we no
> longer have the device reference directly (which would provide the net
> id in the case of direct routes).
> 
> This makes route lookups recursive, as a route lookup that returns a
> gateway route must be resolved into a direct route (ie, to a device)
> eventually. We provide a limit to the route lookups, to prevent infinite
> loop routing.
> 
> The route lookup populates a new 'nexthop' field in the dst structure,
> which now specifies the key for the neighbour table lookup on device
> output, rather than using the packet destination address directly.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

...

> diff --git a/net/mctp/route.c b/net/mctp/route.c

...

> -/* base parsing; common to both _lookup and _populate variants */
> +/* base parsing; common to both _lookup and _populate variants.
> + *
> + * For gateway routes (which have a RTA_GATEWAY, and no RTA_OIF), we populate
> + * *gatweayp. for direct routes (RTA_OIF, no RTA_GATEWAY), we populate *mdev.
> + */
>  static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
>  				     struct netlink_ext_ack *extack,
>  				     struct nlattr **tb, struct rtmsg **rtm,
>  				     struct mctp_dev **mdev,
> +				     struct mctp_fq_addr *gatewayp,
>  				     mctp_eid_t *daddr_start)
>  {
> +	struct mctp_fq_addr *gateway;
> +	unsigned int ifindex = 0;
>  	struct net_device *dev;
> -	unsigned int ifindex;
>  	int rc;
>  
>  	rc = nlmsg_parse(nlh, sizeof(struct rtmsg), tb, RTA_MAX,
> @@ -1321,11 +1372,44 @@ static int mctp_route_nlparse_common(struct net *net, struct nlmsghdr *nlh,
>  	}
>  	*daddr_start = nla_get_u8(tb[RTA_DST]);
>  
> -	if (!tb[RTA_OIF]) {
> -		NL_SET_ERR_MSG(extack, "ifindex missing");
> +	if (tb[RTA_OIF])
> +		ifindex = nla_get_u32(tb[RTA_OIF]);
> +
> +	if (tb[RTA_GATEWAY])
> +		gateway = nla_data(tb[RTA_GATEWAY]);
> +
> +	if (ifindex && gateway) {

Hi Jeremy,

gateway may be uninitialised here...

> +		NL_SET_ERR_MSG(extack,
> +			       "cannot specify both ifindex and gateway");
> +		return -EINVAL;
> +
> +	} else if (ifindex) {
> +		dev = __dev_get_by_index(net, ifindex);
> +		if (!dev) {
> +			NL_SET_ERR_MSG(extack, "bad ifindex");
> +			return -ENODEV;
> +		}
> +		*mdev = mctp_dev_get_rtnl(dev);
> +		if (!*mdev)
> +			return -ENODEV;
> +		gatewayp->eid = 0;
> +
> +	} else if (gateway) {

... and here.

Flagged by Smatch.

> +		if (!mctp_address_unicast(gateway->eid)) {
> +			NL_SET_ERR_MSG(extack, "bad gateway");
> +			return -EINVAL;
> +		}
> +
> +		gatewayp->eid = gateway->eid;
> +		gatewayp->net = gateway->net != MCTP_NET_ANY ?
> +			gateway->net :
> +			READ_ONCE(net->mctp.default_net);
> +		*mdev = NULL;
> +
> +	} else {
> +		NL_SET_ERR_MSG(extack, "no route output provided");
>  		return -EINVAL;
>  	}
> -	ifindex = nla_get_u32(tb[RTA_OIF]);
>  
>  	*rtm = nlmsg_data(nlh);
>  	if ((*rtm)->rtm_family != AF_MCTP) {

...

