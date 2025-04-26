Return-Path: <netdev+bounces-186251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3861A9DBA0
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 17:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D07AB585
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8716221FC1;
	Sat, 26 Apr 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4xS9gTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB417548
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679695; cv=none; b=cAE9jnxHFwhh+LO0eXXL2aG0EmQ6y/kZaRMV3FKqfFMmF0HjGN8odsfGK6h4uUxD7/Vcwi2npE7fjQFX7oeTB19B+t/dPpGGWQBsUaEQtvDSXEXOyc1tPHgOeagTFr9dbmuQ32O802M0lA4TqBZSMeAO6aGoDryJ55KCl2jDnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679695; c=relaxed/simple;
	bh=5jKqo9MvB5attn0SH7vPni0sbydsCwbldl/yOcxjNkI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rJnyXPP9TdMLZRM8Uyyx9ey5r0Xxo1ZFOIoaPach2FUgWi7+tLFCEwlyjHoFyCqzagUHKo9fUsIRHtZz6FV5OPjzqd9WA2XbE8DoIOK+rtvpqLkav0OUcqsScAfu75PUB120G0xwZz2N512W5OxxV2DkF1zFaGESyguVurKiRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4xS9gTG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47691d82bfbso75771711cf.0
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745679693; x=1746284493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK5wjKz7tMVtzmHgtWAPfCxZ51HqL0/S9lOuMiMOq7w=;
        b=Q4xS9gTGPGkT0lksaedLWqFdtVYoWlQkQe8h+8sC9gAtqJ5QFP2V9UML16PkDSLlEi
         1tJik7nKV5DCAYPm9rrYfR5ImdKq+ihnUJyG2vKK6IVddonY8V6ml2PLzQN5l0pX+3xe
         9jqLM2MC4klCwi5pDCS0dzV3F+/s6shgLbTmVy1egFrWgRzk4Fm4dWg/qLHTWouQAT/C
         q+txNbAMohevNkC4EMhzhgm6PEHRke7RohIYNWoUItMrDGuQN5XaJQRB342UAn4M+W1O
         UownCXzhsb1+23V/Bl+5WJTUwe76ctEL7z3bTMNrUPLzk73AzYFAiaughW3CKtrUrISK
         WfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745679693; x=1746284493;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WK5wjKz7tMVtzmHgtWAPfCxZ51HqL0/S9lOuMiMOq7w=;
        b=h/yr9QDp3oGXmJMVwAW9RyZOQX8vlL4xihx1BZQ/aF7mTL/5dLyJOwNzfABu8oZN5r
         r11rlvFlZxayMC7ps2M5xxTKsPX319u+r1VEu/8IQMIUZ7p+2AZx0x7NzIEscy4eiaj9
         YoEtrhwecz12GKJDkSbt6cak/UunXtHGskgN2hAxbIo5OxMwNlr9PmSgFdLjmXIC+sRM
         EuBxZQ/kzrxvao7RUjQZlcsTHmjUWUHGjB+bdNr8RMiIw7hGuCO/pqZuKT3e6NFmxpE/
         zCCaMdpHIuyu5cFtVd5AAEvL+iS+Et/aRfwfq3NrmDBLUym3mU3a/gPS6AdsC/NiKKhg
         Gq7g==
X-Gm-Message-State: AOJu0YwSTQeIYsHsJU+cag61lYHBvGl3Nedz6U6TP1ktaJV2S1zytV3S
	737skydVZA8Ots3TS627bb3HFWNEhhLe+bKA0S1AAi4U8+O9wQLK
X-Gm-Gg: ASbGncuoiqtPyBXBa+1c3roG6/ODDhztQU4ecX9E8hG4FKx0GqsZPbbi1nrveHJikkZ
	iZrSH1kXUy4iP0GI18TPuWkYo3mZVO+NKxtBeO32Ans8auW8ZEB1whv/qXeWaYiSKQ/ccxno+I9
	cVlTpJ2XlLRxr+AhFiCCHwCgVjepwYudnOdMg8qYsqCgFV8jsOFiVRHhLpNHHGYsxC1TVGJkQ7d
	MvkGoInYbzRFVpLuw0VSkMhW9rewZem+mUjKAmFPjvC27m6CWvxQUfVZ+NivqdrHDDMtZgnJibt
	MOrsZJX81/OGyHTuZCJ1fo48hLUsKG+0/dw/oIGJ8QlahMYCH80/GHE5/ufJy237VoS4/hqafFX
	03Jxv2kc02h7LMGnkamnN
X-Google-Smtp-Source: AGHT+IGmVzgmMzs7Y3RcUQKt8wWDOd7c3HcRqblUoNJiyT5mDa3Rtr5hjKcD0STKFctqZD8dDrKktg==
X-Received: by 2002:a05:620a:4609:b0:7c5:6a66:5c1e with SMTP id af79cd13be357-7c9668cdc37mr545148485a.58.1745679692919;
        Sat, 26 Apr 2025 08:01:32 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c965750a69sm149548385a.1.2025.04.26.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 08:01:32 -0700 (PDT)
Date: Sat, 26 Apr 2025 11:01:31 -0400
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
Message-ID: <680cf54b983d5_193a06294ab@willemb.c.googlers.com.notmuch>
In-Reply-To: <aAujZJXqlG8VZpJF@shredder>
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com>
 <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
 <aAujZJXqlG8VZpJF@shredder>
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
> On Thu, Apr 24, 2025 at 10:35:18AM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > With multipath routes, try to ensure that packets leave on the device
> > that is associated with the source address.
> > 
> > Avoid the following tcpdump example:
> > 
> >     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
> >     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
> > 
> > Which can happen easily with the most straightforward setup:
> > 
> >     ip addr add 10.0.0.1/24 dev veth0
> >     ip addr add 10.1.0.1/24 dev veth1
> > 
> >     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
> >     			  nexthop via 10.1.0.2 dev veth1
> > 
> > This is apparently considered WAI, based on the comment in
> > ip_route_output_key_hash_rcu:
> > 
> >     * 2. Moreover, we are allowed to send packets with saddr
> >     *    of another iface. --ANK
> > 
> > It may be ok for some uses of multipath, but not all. For instance,
> > when using two ISPs, a router may drop packets with unknown source.
> > 
> > The behavior occurs because tcp_v4_connect makes three route
> > lookups when establishing a connection:
> > 
> > 1. ip_route_connect calls to select a source address, with saddr zero.
> > 2. ip_route_connect calls again now that saddr and daddr are known.
> > 3. ip_route_newports calls again after a source port is also chosen.
> > 
> > With a route with multiple nexthops, each lookup may make a different
> > choice depending on available entropy to fib_select_multipath. So it
> > is possible for 1 to select the saddr from the first entry, but 3 to
> > select the second entry. Leading to the above situation.
> > 
> > Address this by preferring a match that matches the flowi4 saddr. This
> > will make 2 and 3 make the same choice as 1. Continue to update the
> > backup choice until a choice that matches saddr is found.
> > 
> > Do this in fib_select_multipath itself, rather than passing an fl4_oif
> > constraint, to avoid changing non-multipath route selection. Commit
> > e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> > how that may cause regressions.
> > 
> > Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> > refresh in the loop.
> > 
> > This does not happen in IPv6, which performs only one lookup.
> > 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> One note below
> 
> [...]
> 
> > -void fib_select_multipath(struct fib_result *res, int hash)
> > +void fib_select_multipath(struct fib_result *res, int hash,
> > +			  const struct flowi4 *fl4)
> >  {
> >  	struct fib_info *fi = res->fi;
> >  	struct net *net = fi->fib_net;
> > -	bool first = false;
> > +	bool found = false;
> > +	bool use_neigh;
> > +	__be32 saddr;
> >  
> >  	if (unlikely(res->fi->nh)) {
> >  		nexthop_path_fib_result(res, hash);
> >  		return;
> >  	}
> >  
> > +	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
> > +	saddr = fl4 ? fl4->saddr : 0;
> > +
> >  	change_nexthops(fi) {
> > -		if (READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh)) {
> > -			if (!fib_good_nh(nexthop_nh))
> > -				continue;
> > -			if (!first) {
> > -				res->nh_sel = nhsel;
> > -				res->nhc = &nexthop_nh->nh_common;
> > -				first = true;
> > -			}
> > +		if (use_neigh && !fib_good_nh(nexthop_nh))
> > +			continue;
> > +
> > +		if (!found) {
> > +			res->nh_sel = nhsel;
> > +			res->nhc = &nexthop_nh->nh_common;
> > +			found = !saddr || nexthop_nh->nh_saddr == saddr;
> >  		}
> >  
> >  		if (hash > atomic_read(&nexthop_nh->fib_nh_upper_bound))
> >  			continue;
> 
> Note that because 'res' is set before comparing the hash with the hash
> threshold, it's possible to choose a nexthop that does not have a
> carrier (they are assigned a hash threshold of -1), whereas this did
> not happen before. Tested with [1].

This is different from the previous pre-threshold choice if !first,
because that choice was always tested with fib_good_nh(), while now
that is optional?

> I guess it's not a problem in practice because the initial route lookup
> for the source address wouldn't have chosen the linkdown nexthop to
> begin with.

Agreed. Thanks for the thorough review.
 
> >  
> > -		res->nh_sel = nhsel;
> > -		res->nhc = &nexthop_nh->nh_common;
> > -		return;
> > +		if (!saddr || nexthop_nh->nh_saddr == saddr) {
> > +			res->nh_sel = nhsel;
> > +			res->nhc = &nexthop_nh->nh_common;
> > +			return;
> > +		}
> > +
> > +		if (found)
> > +			return;
> > +
> >  	} endfor_nexthops(fi);
> >  }
> 
> [1]
> #!/bin/bash
> 
> ip link del dev dummy1 &> /dev/null
> ip link del dev dummy2 &> /dev/null
> 
> ip link add name dummy1 up type dummy
> ip link add name dummy2 up type dummy
> ip address add 192.0.2.1/28 dev dummy1
> ip address add 192.0.2.17/28 dev dummy2
> ip route add 192.0.2.32/28 \
> 	nexthop via 192.0.2.2 dev dummy1 \
> 	nexthop via 192.0.2.18 dev dummy2
> 
> ip link set dev dummy2 carrier off
> sysctl -wq net.ipv4.fib_multipath_hash_policy=1
> sysctl -wq net.ipv4.conf.all.ignore_routes_with_linkdown=1
> 
> sleep 1
> 
> ip route show 192.0.2.32/28
> for i in {1..100}; do
> 	ip route get to 192.0.2.33 from 192.0.2.17 ipproto tcp sport $i dport $i | grep dummy2
> done



