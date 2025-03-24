Return-Path: <netdev+bounces-177090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9CA6DD28
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4123A2523
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6525FA15;
	Mon, 24 Mar 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9KOSlB3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7A25E466
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827016; cv=none; b=WOc3WFRHCQJeW04JtVMm8Xc6bkLeLV1n9ipMYFZ0HQuI8TpD76RJoBRFMFRtQ/j/h4/ceGPV6Rikg1nGjKr7OSEoL86IHAsBAjUebKePxdX3mMsOfQx8ELasvpt9fnf8Q6HqO6CULhx6y2VLogOnfyyxoknCBb+uM10ojlQl7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827016; c=relaxed/simple;
	bh=EX+i78UY8McSF1UOTDyM7XbHFG0x0gyM+83kDGGHSgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGbiVrAEPXMmlWjQBRCRgrPYoy9N98rlozjAeA9pevewMW4Gudjpty0xTvUySmMr6jQOvnthM96KFY8fX+wUjU5saz+szEPQzX1vI1ZiPvC43bH5gbnDDkO1qHlOdoaJkCvkCQr6ta3jWRpSTL42fLG0lm5LxIQWzB3ziANe22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9KOSlB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742827012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcpEI29yewr2cAV7fgE3lTB883tDXKjfA4C7oEZt6RU=;
	b=g9KOSlB3WuccIFlkcfjOpM2y56JuITqgwvXaHQfgi5AuGLEyLFwBTiya0+BmRkQQgMgLEJ
	mqvkHyHB4NY5nrY/4nA/N/XI6+8cVOOLdJLbsHtV2hBBK9CJw7r9TkIoDBf69feqEcyIXx
	FO7VP6DxSuWg8hZ42B/hPq7tMcfOHvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-73J4f5K6Okuio0Pixg8RWA-1; Mon, 24 Mar 2025 10:36:51 -0400
X-MC-Unique: 73J4f5K6Okuio0Pixg8RWA-1
X-Mimecast-MFC-AGG-ID: 73J4f5K6Okuio0Pixg8RWA_1742827010
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39141ffa913so2300611f8f.2
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 07:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827010; x=1743431810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcpEI29yewr2cAV7fgE3lTB883tDXKjfA4C7oEZt6RU=;
        b=O8UYGuhpKUoU2ampIT13hJaOtix9+3hdwV59n4s+mKNCCZNN8Irozr9GGeSj+7uz/V
         6KHfrefXUkECyl6eO6q/4rvDEjBjJP5HnhJbt8h0mxjJs16tmnbm7yt0/sc9P6lWVxgX
         cwMHW4mF+d33RNMYoOrej/A+AGAfizCspMITCHIUqqGkPI53jIJPuKWNvp1S19CtJPl6
         DqLYEBEksmx+cbGOpmMyJ5QsboEZS+fFuVL3kpF9JFi51voE/Jpob3KOjvZq7OMMEO4R
         1ubGnoBN8Gzu2qkErsBUxTh3oOu2zFQo0wlngvnGHbdgZ0qqZ4vTpJ/FKk4x41pace/j
         8O1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUi+LYcRtlk8qsxcaViaGFXnNQrDzwLwhd50B+iaUp8jlHcWy6I/duDaSWGCJCH5rjE4xLEVAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCl+tvmysQEC58mXGjTS71qOtX+R0ZkUT59j+4awYF0LvlJ4b
	Er9UM+eh3eSb/W6ROl9u1aHfDUJGbIxNi4eli7VVHC3LUdfCaGLOcL62cTT2hE9bUxoQ53gX4Iz
	nGgVxjT2Vb1nWMOR87WFzeiLe1WmsbtvZt65fZfZuzlF9vVTKvkhyyw==
X-Gm-Gg: ASbGncvHoJ4LUx0PEdFYa4PqpPw9X+9txjKsMkjP5tP23hzdoLNgYTr2LncoRK5h+5v
	XnfQzu4wku5XukxOwwONeRiA3AeFLA1iz9oXlM+L2/csAPVzPB44GOpwd6rVgX8dKrmzZLWa/xQ
	/SgUie41ZsJXPw7jJTP2RytUMpNcHGESukT3Z4I83DRGak/1C7kCB8zy5XWPJoJvsWwt8iyUOm1
	fF5mPYe/LPVgk2NuaaofN2MY3LgWNz82bABmxGzUVhUijqzvtAT/eZ+D1BKiyStCKdN5aPzdQgS
	mJ1UykOi00t8OB1PZ+SlioSbOigh+Tj8Y6aaf2yhwTfMxU5jMl3RJ+9bDqlPbRRhMy92gHw=
X-Received: by 2002:a05:6000:2ad:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3997f8f92d0mr12481187f8f.9.1742827009869;
        Mon, 24 Mar 2025 07:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdCGLHCmsS6Kb9u2K6fLHpf+p0lqiiXpzMnZhlgzlKtTUY+dFW9H57r7MgcZ9NvSp6L7as5Q==
X-Received: by 2002:a05:6000:2ad:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3997f8f92d0mr12481161f8f.9.1742827009391;
        Mon, 24 Mar 2025 07:36:49 -0700 (PDT)
Received: from debian (2a01cb058d23d6003b0bfb3a34015c73.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:3b0b:fb3a:3401:5c73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957efsm11310162f8f.14.2025.03.24.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:36:48 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:36:46 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z+Ft/jPlaoM+7IUU@debian>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
 <Z9SPDT9_M_nH9JiM@mini-arch>
 <Z9bNYPX165yxdoId@shredder>
 <Z9iP1anwinOHhjjm@debian>
 <20250320162646.GC892515@horms.kernel.org>
 <Z9xmvRX_g_ZifayA@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xmvRX_g_ZifayA@shredder>

On Thu, Mar 20, 2025 at 09:04:29PM +0200, Ido Schimmel wrote:
> On Thu, Mar 20, 2025 at 04:26:46PM +0000, Simon Horman wrote:
> > On Mon, Mar 17, 2025 at 10:10:45PM +0100, Guillaume Nault wrote:
> > > On Sun, Mar 16, 2025 at 03:08:48PM +0200, Ido Schimmel wrote:
> > > > On Fri, Mar 14, 2025 at 01:18:21PM -0700, Stanislav Fomichev wrote:
> > > > > On 03/14, Guillaume Nault wrote:
> > > > > > On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > > > > > > 
> > > > > > > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > > > > > > It seems like it started falling after this series has been pulled:
> > > > > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> > > > > > 
> > > > > > Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> > > > > > current net tree (I'm at commit 4003c9e78778). I have only one failure,
> > > > > > but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> > > > > > address generation.") was applied.
> > > > > 
> > > > > On my side I see the following (ignore ping6 FAILs):
> > > > > 
> > > > > bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>
> > > > > 
> > > > > TAP version 13
> > > > > 1..1
> > > > > # timeout set to 0
> > > > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > > > [    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
> > > > > [   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
> > > > > [   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
> > > > > [   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > > > [   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > > > [   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
> > > > > [   17.559477][  T321] GACT probability NOT on
> > > > > [   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > > > [   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > > > # TEST: ping                                                          [ OK ]
> > > > > # TEST: ping6                                                         [FAIL]
> > > > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > > > # TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
> > > > > #       Expected traffic to be balanced, but it is not
> > > > > # INFO: Packets sent on path1 / path2: 1 / 12602
> > > > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 0 / 12601
> > > > > # TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
> > > > > #       Expected traffic to be balanced, but it is not
> > > > > # INFO: Packets sent on path1 / path2: 1 / 12600
> > > > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > > > ...
> > > > > 
> > > > > 8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>
> > > > > 
> > > > > TAP version 13
> > > > > 1..1
> > > > > # timeout set to 0
> > > > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > > > [   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
> > > > > [   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
> > > > > [   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
> > > > > [   17.629460][  T317] GACT probability NOT on
> > > > > [   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
> > > > > # TEST: ping                                                          [ OK ]
> > > > > # TEST: ping6                                                         [FAIL]
> > > > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > > > # TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 5552 / 7052
> > > > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 12600 / 2
> > > > > [   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
> > > > > # TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 6650 / 5950
> > > > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > > > ...
> > > > > 
> > > > > And I also see the failures on 4003c9e78778. Not sure why we see
> > > > > different results. And the NIPAs fails as well:
> > > > > 
> > > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout
> > > > 
> > > > I can reproduce this locally and I'm getting the exact same result as
> > > > the CI. All the balanced tests fail because the traffic is forwarded via
> > > > a single nexthop. No failures after reverting 183185a18ff9.
> > > > 
> > > > I'm still not sure what happens, but for some reason a neighbour is not
> > > > created on one of the nexthop devices which causes rt6_check_neigh() to
> > > > skip over this path (returning RT6_NUD_FAIL_DO_RR). Enabling
> > > > CONFIG_IPV6_ROUTER_PREF fixes the issue because then RT6_NUD_SUCCEED is
> > > > returned.
> > > > 
> > > > I can continue looking into this on Tuesday (mostly AFK tomorrow).
> > > 
> > > I finally managed to reproduce the problem using vng. Still no problem
> > > on my regular VM, no matter if I enable CONFIG_IPV6_ROUTER_PREF or not.
> > > I'll continue investigating this problem...
> > 
> > FWIIW, I have tried much, but am unable to _reliably_ reproduce this problem.
> 
> Sorry for the delay. Busy with other tasks at the moment, but I found
> some time to look into this. I believe I understand the issue and have a
> fix. Guillaume's patch is fine. It simply exposed a bug elsewhere.
> 
> The test is failing because all the packets are forwarded via a single
> path instead of being load balanced between both paths.
> fib6_select_path() chooses the path according to the hash-threshold
> algorithm. If the function is called with the last nexthop in a
> multipath route, it will always choose this nexthop because the
> calculated hash will always be smaller than the upper bound of this
> nexthop.
> 
> Fix is to find the first nexthop (sibling route) and choose the first
> matching nexthop according to hash-threshold. Given Guillaume and you
> can reproduce the issue, can you please test the fix [1]?

Good catch!
I can confirm that your patch fixes the selftest for me.

> I think Guillaume's patch exposed the issue because it caused the ip6gre
> device to transmit a packet (Router Solicitation as part of the DAD
> process for the IPv6 link-local address) as soon as the device is
> brought up. With debug kernels this might happen while forwarding is
> still disabled as the test enables forwarding at the end of the setup.
> 
> When forwarding is disabled the nexthop's neighbour state is taken into
> account when choosing a route in rt6_select() and round-robin will be
> performed between the two sibling routes. It is possible to end up in a
> situation where rt6_select() always returns the second sibling route
> which fib6_select_path() will then always select due to its upper bound.

Thanks a lot for your help Ido!

> [1]
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index fb2e99a56529..afcd66b73a92 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
>  	return false;
>  }
>  
> +static struct fib6_info *
> +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> +{
> +	struct fib6_info *iter;
> +	struct fib6_node *fn;
> +
> +	fn = rcu_dereference(rt->fib6_node);
> +	if (!fn)
> +		goto out;
> +	iter = rcu_dereference(fn->leaf);
> +	if (!iter)
> +		goto out;
> +
> +	while (iter) {
> +		if (iter->fib6_metric == rt->fib6_metric &&
> +		    rt6_qualify_for_ecmp(iter))
> +			return iter;
> +		iter = rcu_dereference(iter->fib6_next);
> +	}
> +
> +out:
> +	return NULL;
> +}
> +
>  void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		      struct flowi6 *fl6, int oif, bool have_oif_match,
>  		      const struct sk_buff *skb, int strict)
>  {
> -	struct fib6_info *match = res->f6i;
> +	struct fib6_info *first, *match = res->f6i;
>  	struct fib6_info *sibling;
>  
>  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
>  		return;
>  	}
>  
> -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> +	first = rt6_multipath_first_sibling_rcu(match);
> +	if (!first)
>  		goto out;
>  
> -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> +			    strict) >= 0) {
> +		match = first;
> +		goto out;
> +	}
> +
> +	list_for_each_entry_rcu(sibling, &first->fib6_siblings,
>  				fib6_siblings) {
>  		const struct fib6_nh *nh = sibling->fib6_nh;
>  		int nh_upper_bound;
> 


