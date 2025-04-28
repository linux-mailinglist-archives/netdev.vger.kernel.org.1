Return-Path: <netdev+bounces-186483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7356A9F5C5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E9A164660
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAEB27B519;
	Mon, 28 Apr 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZnh7TV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FE27A91E
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857617; cv=none; b=cgzmjbcf4l5JdZHJb3SL4E3uYnEzfaIQuRqNDRFzLHTBrsRaeT1ZZM7fDnUWM+ao9J82b2PnfSmoBGMOIf+ttx1U1th1cFMmZmoP/0TR7hVAq+Jyu98Lxa8hfnF3vl3r444kd6HnJS+9Z/ReeCnNzEa05VJ0rebJYjjN2jfi3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857617; c=relaxed/simple;
	bh=A6oXOqzJ5A2HrdsJ/01+w6gnudRMBxiykbtk9IXgiME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M/0os9X7sHg03tr9krsNuVOeqWJf+MS/burVPqGgVpYmEinoCx4l2NT/Pteo2xYjBA9hR47o1UEP+jGkkQwkpoJ9qAasBldM4nSBQqyH/sJC9htOYBYwiQSZYLLdIWIsUHxoKYHY+clTpnJCd+3iHaHErdCyvPYKWEysLYSjr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZnh7TV6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4768f90bf36so58668321cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745857614; x=1746462414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckHouoWVII4IPDYwSc7+1A1VRZJC5e3MIJjiXdVT+Rc=;
        b=CZnh7TV6+ups+ZM99XA3KSwg7Cj5KWg+2Gz9pXcFCSv/CrkCxLY94houzRHwjSGRGg
         b/Nr9PzFCu89Yc2X+JlX0PrQL01DU0Vh5sekw9dc1SfQ10+KmXX2GoJKeHE6vE7BslgG
         WI2F+j08MJHx/0PRdZrJe+7sPwLha0CDNKwqimjacaLeAmznH2MzeGAqyXczxybcWHfM
         Vwd5T626h7sSNIbuirosDwI3O4Y+jnXWVssk555hErN/P19GNQhiYcdOaHLKCECBCknQ
         0j0gbvRl/qW0Gbl6fPFXjieh+YRbykFEUA2jcEJ8aCJjFyLQe5e002UYh8iu/elA8UU5
         X4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857614; x=1746462414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckHouoWVII4IPDYwSc7+1A1VRZJC5e3MIJjiXdVT+Rc=;
        b=gTcvOjWuIRPG9RIkqmpCn7xt30/pJZykLbwHY9+G2c2VXUYQza7wnPuHvpQ3jiJ0QJ
         J1YWHmIKrFfyRKxMr8QA41iWTvOcDhkg1UmKNbPUIuyekUWc3LVvwAYCM2fkOxyvZV/S
         a2Ea/lo7bSsMwiCpaxq99sabc7EtgOppIOu+Vg/p9IXYBethwxUU/Kx3J8E9in427Xyn
         NdV79qdREomNn6Lq0hRwE4W+cVvTnur1T+u1yN2ogZaYcfmgJAPiIQFXnz4UssC1LFig
         fq/8BACc6wea5eFOZHRRD5esaV8EevQh0EpveQUX7SviPEOZXlxNMxaA2vhPL3hQA+CJ
         jhiw==
X-Gm-Message-State: AOJu0YwG6Icv4d3O0YCx/ZGSvhusrMhsugcBCxvOTt4vAFDWhEPS5vfg
	lzo2ESGStix+Jnil5J1DWWrgK/pUjf5peptJ8Fmf1fS/TCByrvPJ
X-Gm-Gg: ASbGnctDXPkOgdwJr7RBT6a5A790G2q/PH1beSMxBS5EVIEheQ5dt8uHeCRjGgBmz0l
	dAE+MV/C7AaPAT/qkT5h3jbNhk/2A62I8buzPQ2sCLYvXPLqr5Qm7YuS/z3kRxd3ntcQ+KHvGd1
	JTuaoINgY2YL9wgHgaqUCoBqaepf0QuhXdD8enD72f2JfTWDneID1kERq44l2jddYLa4uM+RdaN
	pUIeUM38UAipPIs1/9qcM4NlCJf6lMOFotaVaUstae+f0uab4XVZF3OPLqeQn7nBuGpB3xNB+Da
	HO5c/gbm9OCNNMTgaHpRQkNm588dNsanlVFZhZkDs39cP4D1Epeo+P98fStclsjqlnT4Y5Ifpss
	b7B9G4IFfZjiseMr1rn1+
X-Google-Smtp-Source: AGHT+IHxgQCnGU2GqriiJ9OcZsJ+aBC6RKyF3LaMizvvex7sA9uvZPeOBglVQI+vXvRJ3GI4g3Wezg==
X-Received: by 2002:ad4:5f0b:0:b0:6e4:3ddc:5d33 with SMTP id 6a1803df08f44-6f4d1efe8abmr190561646d6.13.1745857614516;
        Mon, 28 Apr 2025 09:26:54 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0aaf977sm62652666d6.112.2025.04.28.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:26:53 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:26:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 kuniyu@amazon.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <680fac4d8cc75_23f881294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <aA5px6qCjTWbHimM@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
 <aAujZJXqlG8VZpJF@shredder>
 <680cf54b983d5_193a06294ab@willemb.c.googlers.com.notmuch>
 <aA5px6qCjTWbHimM@shredder>
Subject: Re: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that
 matches source address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Sat, Apr 26, 2025 at 11:01:31AM -0400, Willem de Bruijn wrote:
> > Ido Schimmel wrote:
> > > On Thu, Apr 24, 2025 at 10:35:18AM -0400, Willem de Bruijn wrote:
> > > > From: Willem de Bruijn <willemb@google.com>
> > > > 
> > > > With multipath routes, try to ensure that packets leave on the device
> > > > that is associated with the source address.
> > > > 
> > > > Avoid the following tcpdump example:
> > > > 
> > > >     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
> > > >     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
> > > > 
> > > > Which can happen easily with the most straightforward setup:
> > > > 
> > > >     ip addr add 10.0.0.1/24 dev veth0
> > > >     ip addr add 10.1.0.1/24 dev veth1
> > > > 
> > > >     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
> > > >     			  nexthop via 10.1.0.2 dev veth1
> > > > 
> > > > This is apparently considered WAI, based on the comment in
> > > > ip_route_output_key_hash_rcu:
> > > > 
> > > >     * 2. Moreover, we are allowed to send packets with saddr
> > > >     *    of another iface. --ANK
> > > > 
> > > > It may be ok for some uses of multipath, but not all. For instance,
> > > > when using two ISPs, a router may drop packets with unknown source.
> > > > 
> > > > The behavior occurs because tcp_v4_connect makes three route
> > > > lookups when establishing a connection:
> > > > 
> > > > 1. ip_route_connect calls to select a source address, with saddr zero.
> > > > 2. ip_route_connect calls again now that saddr and daddr are known.
> > > > 3. ip_route_newports calls again after a source port is also chosen.
> > > > 
> > > > With a route with multiple nexthops, each lookup may make a different
> > > > choice depending on available entropy to fib_select_multipath. So it
> > > > is possible for 1 to select the saddr from the first entry, but 3 to
> > > > select the second entry. Leading to the above situation.
> > > > 
> > > > Address this by preferring a match that matches the flowi4 saddr. This
> > > > will make 2 and 3 make the same choice as 1. Continue to update the
> > > > backup choice until a choice that matches saddr is found.
> > > > 
> > > > Do this in fib_select_multipath itself, rather than passing an fl4_oif
> > > > constraint, to avoid changing non-multipath route selection. Commit
> > > > e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> > > > how that may cause regressions.
> > > > 
> > > > Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> > > > refresh in the loop.
> > > > 
> > > > This does not happen in IPv6, which performs only one lookup.
> > > > 
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > Reviewed-by: David Ahern <dsahern@kernel.org>
> > > 
> > > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> > > 
> > > One note below
> > > 
> > > [...]
> > > 
> > > > -void fib_select_multipath(struct fib_result *res, int hash)
> > > > +void fib_select_multipath(struct fib_result *res, int hash,
> > > > +			  const struct flowi4 *fl4)
> > > >  {
> > > >  	struct fib_info *fi = res->fi;
> > > >  	struct net *net = fi->fib_net;
> > > > -	bool first = false;
> > > > +	bool found = false;
> > > > +	bool use_neigh;
> > > > +	__be32 saddr;
> > > >  
> > > >  	if (unlikely(res->fi->nh)) {
> > > >  		nexthop_path_fib_result(res, hash);
> > > >  		return;
> > > >  	}
> > > >  
> > > > +	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
> > > > +	saddr = fl4 ? fl4->saddr : 0;
> > > > +
> > > >  	change_nexthops(fi) {
> > > > -		if (READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh)) {
> > > > -			if (!fib_good_nh(nexthop_nh))
> > > > -				continue;
> > > > -			if (!first) {
> > > > -				res->nh_sel = nhsel;
> > > > -				res->nhc = &nexthop_nh->nh_common;
> > > > -				first = true;
> > > > -			}
> > > > +		if (use_neigh && !fib_good_nh(nexthop_nh))
> > > > +			continue;
> > > > +
> > > > +		if (!found) {
> > > > +			res->nh_sel = nhsel;
> > > > +			res->nhc = &nexthop_nh->nh_common;
> > > > +			found = !saddr || nexthop_nh->nh_saddr == saddr;
> > > >  		}
> > > >  
> > > >  		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
> > > >  			continue;
> > > 
> > > Note that because 'res' is set before comparing the hash with the hash
> > > threshold, it's possible to choose a nexthop that does not have a
> > > carrier (they are assigned a hash threshold of -1), whereas this did
> > > not happen before. Tested with [1].
> > 
> > This is different from the previous pre-threshold choice if !first,
> > because that choice was always tested with fib_good_nh(), while now
> > that is optional?
> 
> I'm not sure I understood the question, but my point is that we can make
> the code a bit clearer and more "correct" with something like this [1]
> as a follow-up. It honors the "ignore_routes_with_linkdown" sysctl and
> skips over nexthops that do not have a carrier.
>
> I tested with [2] which fails without the patch. fib_tests.sh is also OK
> [3] (including the new tests).
> 
> In practice, the patch shouldn't make a big difference. For the case of
> saddr==0 (e.g., forwarding), it shouldn't make any difference because
> you are guaranteed to find a nexthop whose upper bound covers the
> calculated hash.
> 
> For the case of saddr!=0 (e.g., locally generated traffic) this patch
> will not choose a nexthop if it has the correct address but no carrier.
> Like I said before, it probably doesn't matter in practice because the
> route lookup for the source address wouldn't choose this nexthop /
> address in the first place.
> 
> [1]
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 2371f311a1e1..ce56fe39b185 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2188,7 +2188,14 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  	saddr = fl4 ? fl4->saddr : 0;
>  
>  	change_nexthops(fi) {
> -		if (use_neigh && !fib_good_nh(nexthop_nh))
> +		int nh_upper_bound;
> +
> +		/* Nexthops without a carrier are assigned an upper bound of
> +		 * minus one when "ignore_routes_with_linkdown" is set.
> +		 */
> +		nh_upper_bound = atomic_read(&nexthop_nh->fib_nh_upper_bound);
> +		if (nh_upper_bound == -1 ||
> +		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
>  		if (!found) {
> @@ -2197,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  			found = !saddr || nexthop_nh->nh_saddr == saddr;
>  		}
>  
> -		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
> +		if (hash > nh_upper_bound)
>  			continue;
>  
>  		if (!saddr || nexthop_nh->nh_saddr == saddr) {

Makes sense, thanks.

Do you want to send the follow up to net-next once the series
lands there?
 
> [2]
> #!/bin/bash
> 
> trap cleanup EXIT
> 
> cleanup() {
> 	ip netns del ns1
> }
> 
> ip netns add ns1
> ip -n ns1 link set dev lo up
> 
> ip -n ns1 link add name dummy1 up type dummy
> ip -n ns1 link add name dummy2 up type dummy
> 
> ip -n ns1 address add 192.0.2.1/28 dev dummy1
> ip -n ns1 address add 192.0.2.17/28 dev dummy2
> 
> ip -n ns1 route add 198.51.100.0/24 \
> 	nexthop via 192.0.2.2 dev dummy1 \
> 	nexthop via 192.0.2.18 dev dummy2
> 
> ip netns exec ns1 sysctl -wq net.ipv4.fib_multipath_hash_policy=1
> ip netns exec ns1 sysctl -wq net.ipv4.conf.all.ignore_routes_with_linkdown=1
> 
> ip -n ns1 link set dev dummy2 carrier off
> 
> for i in {1..128}; do
> 	ip -n ns1 route get to 198.51.100.1 from 192.0.2.17 \
> 		ipproto tcp sport $i dport $i | grep -q dummy2
> 	[[ $? -eq 0 ]] && echo "FAIL" && exit
> done
> 
> echo "SUCCESS"
> 
> [3]
> # ./fib_tests.sh
> [...]
> Tests passed: 230
> Tests failed:   0



