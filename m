Return-Path: <netdev+bounces-197923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B011EADA546
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 02:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04383ACD51
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005E3B2A0;
	Mon, 16 Jun 2025 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="/hXHeWhs";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="OYLEfYCg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4B3594C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035372; cv=none; b=o5Z9BzQ4w/6Hafdf2IqhuL5Irhm/Wx7QLonRqcDkwHOfvd+SoWJe3DVo014vrC4Fuf0AVS2DNZ+DUeU1FKRrS82JK8Ho0kK+jgAejYWxMZsm31JtekBwppOtBLqlTbH3jNwwbPSoWF/a/yXZ7fSGUKTuXZP36s9QLxAZ9cQpHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035372; c=relaxed/simple;
	bh=ILaz/tPzlkoDzHxleWwxdDZyE3+yTLV51lfyOSQdfY4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WBBz/GNeCbAjzy4YzfqRU7Nv7pCjoWg+/lr/XvXdUS6KVDd1pIWbL0qkIEV7qrcWdzInU/UCm4+2Ilg/KNU3pIlj+IvS5FMv1w5/jnHfJeH3JHGwDdOIMk0Q+5AJRAMfbhRzIJQNrOK1SckQ7VygFY/EzSjbNtW/gRqkr0msWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=/hXHeWhs; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=OYLEfYCg; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55G0tP4V026028;
	Mon, 16 Jun 2025 02:55:30 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 3E7F0121DDD;
	Mon, 16 Jun 2025 02:55:20 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1750035320; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvl89xFFjLLi7FVM2SjFo//HDntKWbZvstyDpJcNCIQ=;
	b=/hXHeWhsfURxX5ef+sJOBcxX77N21kdt8rHBhP8qgdj0C+X1z4hP1d1n+r2NAOgD+MmHsL
	E1k5HT7WoVePrYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1750035320; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rvl89xFFjLLi7FVM2SjFo//HDntKWbZvstyDpJcNCIQ=;
	b=OYLEfYCgKkhciEZH2EQplaMPCvokRvjdv6f4hbTMwfitSCSoitllZ05Q6b/gQ/bSYh1H0Z
	6gfWqJpfKh8YOKp19eFkI02NFBmCSdBqv8WrBBMtGw2D/CyfiMqG4OIst/ZsT2wqh+qQ6T
	TkZ3TsomtaFl7Q00XN1LBikL8enoFvACwQAAXDG6uYNPvjDxSp+RDbhbBPaSks3ndF49Dn
	ceGwMJxiFfJZzuL0p01WpoXdj3XY9LnhvLa2FXDHdyMk2aOw48qWx2O7EG87zt+uAVFDGa
	LURy0zifB5YY/CiPedq/GwKW6dIEXiyMwHhvot79YSeIy4BrgoEjXCMCc00DwQ==
Date: Mon, 16 Jun 2025 02:55:20 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <edumazet@google.com>, <dsahern@kernel.org>,
        <horms@kernel.org>, <petrm@nvidia.com>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>, stefano.salsano@uniroma2.it,
        <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 1/4] seg6: Extend seg6_lookup_any_nexthop()
 with an oif argument
Message-Id: <20250616025520.92d6c60879210751664f11ad@uniroma2.it>
In-Reply-To: <20250612122323.584113-2-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
	<20250612122323.584113-2-idosch@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 12 Jun 2025 15:23:20 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> seg6_lookup_any_nexthop() is called by the different endpoint behaviors
> (e.g., End, End.X) to resolve an IPv6 route. Extend the function with an
> output interface argument so that it could be used to resolve a route
> with a certain output interface. This will be used by subsequent patches
> that will extend the End.X behavior with an output interface as an
> optional argument.
> 
> ip6_route_input_lookup() cannot be used when an output interface is
> specified as it ignores this parameter. Similarly, calling
> ip6_pol_route() when a table ID was not specified (e.g., End.X behavior)
> is wrong.
> 
> Therefore, when an output interface is specified without a table ID,
> resolve the route using ip6_route_output() which will take the output
> interface into account.
> 
> Note that no endpoint behavior currently passes both a table ID and an
> output interface, so the oif argument passed to ip6_pol_route() is
> always zero and there are no functional changes in this regard.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/seg6_local.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index a11a02b4ba95..8bce7512df97 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -270,7 +270,7 @@ static void advance_nextseg(struct ipv6_sr_hdr *srh, struct in6_addr *daddr)
>  
>  static int
>  seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
> -			u32 tbl_id, bool local_delivery)
> +			u32 tbl_id, bool local_delivery, int oif)
>  {
>  	

I took some time to verify that the proposed updates to
seg6_lookup_any_nexthop() work correctly with End.DT6 when using legacy mode
(as seg6_lookup_any_nexthop() is directly used by End.DT6).
Right now, there is no self-test for End.DT6 in legacy mode because the current
one covers End.DT6 in VRF mode. So, I (locally) adjusted the existing self-test
for testing End.DT6 legacy. After running the test, it looks like the legacy
End.DT6 also works fine with the suggested changes.

struct net *net = dev_net(skb->dev);
>  	struct ipv6hdr *hdr = ipv6_hdr(skb);
> @@ -282,6 +282,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  
>  	memset(&fl6, 0, sizeof(fl6));
>  	fl6.flowi6_iif = skb->dev->ifindex;
> +	fl6.flowi6_oif = oif;
>  	fl6.daddr = nhaddr ? *nhaddr : hdr->daddr;
>  	fl6.saddr = hdr->saddr;
>  	fl6.flowlabel = ip6_flowinfo(hdr);
> @@ -291,17 +292,19 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  	if (nhaddr)
>  		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
>  
> -	if (!tbl_id) {
> +	if (!tbl_id && !oif) {
>  		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
> -	} else {
> +	} else if (tbl_id) {
>  		struct fib6_table *table;
>  
>  		table = fib6_get_table(net, tbl_id);
>  		if (!table)
>  			goto out;
>  
> -		rt = ip6_pol_route(net, table, 0, &fl6, skb, flags);
> +		rt = ip6_pol_route(net, table, oif, &fl6, skb, flags);
>  		dst = &rt->dst;
> +	} else {
> +		dst = ip6_route_output(net, NULL, &fl6);
>  	}

I checked that regardless of which routing helper function is used -
ip6_route_output, ip6_pol_route, or ip6_route_input_lookup - the End.X behavior
must always invoke dst_input() to continue processing and forwarding the packet
to the next node, i.e., via ip6_forward(). This allows us to adjust the hop
limit, pass the packet through the netfilter forwarding hook, and then send it
out i.e., ip6_output().
The same processing applies to End.X when used without specifying an outgoing
interface (referred to as legacy End.X). The way packets are handled after the
destination is found is consistent for both legacy End.X and End.X with oif.
It's good that we've maintained consistency between the two End.X
implementations.

Overall, the patch looks good to me (greatly appreciated - if any - suggestions
and insights from routing experts).

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

>  
>  	/* we want to discard traffic destined for local packet processing,
> @@ -330,7 +333,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
>  int seg6_lookup_nexthop(struct sk_buff *skb,
>  			struct in6_addr *nhaddr, u32 tbl_id)
>  {
> -	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false);
> +	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0);
>  }
>  
>  static __u8 seg6_flv_lcblock_octects(const struct seg6_flavors_info *finfo)
> @@ -1277,7 +1280,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
>  	/* note: this time we do not need to specify the table because the VRF
>  	 * takes care of selecting the correct table.
>  	 */
> -	seg6_lookup_any_nexthop(skb, NULL, 0, true);
> +	seg6_lookup_any_nexthop(skb, NULL, 0, true, 0);
>  
>  	return dst_input(skb);
>  
> @@ -1285,7 +1288,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
>  #endif
>  	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
>  
> -	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true);
> +	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true, 0);
>  
>  	return dst_input(skb);
>  
> -- 
> 2.49.0
> 

