Return-Path: <netdev+bounces-48752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4FE7EF6A7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0BB1C20840
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BCD1CFAB;
	Fri, 17 Nov 2023 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="a0wQmPBS"
X-Original-To: netdev@vger.kernel.org
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3BD56
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:57:13 -0800 (PST)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 6047D21749;
	Fri, 17 Nov 2023 18:57:10 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 490F921741;
	Fri, 17 Nov 2023 18:57:10 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id BDC163C0435;
	Fri, 17 Nov 2023 18:57:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1700240228; bh=0giuIG5qHqC4kUsf0OpEQJWWH2sJDf+9aaE9zDOpm7k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=a0wQmPBSH7lfxDCuh5G2WSEQyHK/RcDGoDUkkURoNPOFxWCGLO/s+G2tc1YFHHKAs
	 dzemdt8/TDCG6wNfW1Gl9IINWhoQe6HiOaTCBFAirrnmeVtAgwMIa5rAxZJ6AFHWgd
	 19Mh3zGKn5MJ4Nj6VC7CFidhVmpIxEgMX+X6L9bY=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3AHGuvKc078372;
	Fri, 17 Nov 2023 18:56:59 +0200
Date: Fri, 17 Nov 2023 18:56:57 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Antoine Tenart <atenart@kernel.org>
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, netdev@vger.kernel.org, liuhangbin@gmail.com
Subject: Re: [PATCH net-next] net: ipv4: replace the right route in case
 prefsrc is used
In-Reply-To: <20231117114837.36100-1-atenart@kernel.org>
Message-ID: <85f52258-d1cb-9c3c-0ea4-602954e929e8@ssi.bg>
References: <20231117114837.36100-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Fri, 17 Nov 2023, Antoine Tenart wrote:

> In case similar routes with different prefsrc are installed, any
> modification of one of those routes will always modify the first one
> found as the prefsrc is not matched. Fix this by updating the entry we
> found in case prefsrc was set in the request.
> 
> Before the patch:
> 
>   $ ip route show
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100
>   $ ip route change 172.16.42.0/24 dev eth0 proto kernel scope link \
>         src 172.16.42.4 metric 100 mtu 1280
>   $ ip route show
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100 mtu 1280
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100
> 
> After the patch:
> 
>   $ ip route show
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100
>   $ ip route change 172.16.42.0/24 dev eth0 proto kernel scope link \
>         src 172.16.42.4 metric 100 mtu 1280
>   $ ip route show
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.3 metric 100
>   172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.4 metric 100 mtu 1280
> 
> All fib selftest ran and no failure was seen.
> 
> Note: a selftest wasn't added as `ip route` use NLM_F_EXCL which
> prevents us from constructing the above routes. But this is a valid

ip route append/prepend are standard way to create alternative routes,
if you want to encode a selftest.

> example of what NetworkManager can construct for example.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
> 
> Hi, comment/question below,
> 
> I'm wondering if we want to fix the above case. I made this patch
> because we already filter on prefsrc when deleting a route[1] to deal
> with the same configurations as above, and that would make the route
> replacement consistent with that.
> 
> However even with this (same for [1]) things are not 100% failsafe
> (and we can argue on the use case and feasibility). For example
> consider,
> 
> $ ip route show
> 172.16.42.0/24 dev eth0 proto kernel scope link src 172.16.42.2 metric 100
> 172.16.42.0/24 dev eth0 proto kernel scope link metric 100
> $ ip route del 172.16.42.0/24 dev eth0 proto kernel scope link metric 100
> $ ip route show
> 172.16.42.0/24 dev eth0 proto kernel scope link metric 100
> 
> Also the differing part could be something else that the prefsrc (not
> that it would necessarily make sense).
> 
> Thoughts?
> 
> Thanks!
> Antoine
> 
> [1] 74cb3c108bc0 ("ipv4: match prefsrc when deleting routes").
> 
> ---
>  net/ipv4/fib_trie.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 9bdfdab906fe..6cf775d4574e 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -1263,10 +1263,11 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
>  
>  		nlflags &= ~NLM_F_EXCL;
>  
> -		/* We have 2 goals:
> +		/* We have 3 goals:
>  		 * 1. Find exact match for type, scope, fib_info to avoid
>  		 * duplicate routes
>  		 * 2. Find next 'fa' (or head), NLM_F_APPEND inserts before it
> +		 * 3. Find the right 'fa' in case a prefsrc is used
>  		 */
>  		fa_match = NULL;
>  		fa_first = fa;
> @@ -1282,6 +1283,9 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
>  				fa_match = fa;
>  				break;
>  			}
> +			if (cfg->fc_prefsrc &&
> +			    cfg->fc_prefsrc == fa->fa_info->fib_prefsrc)

	You may prefer to restrict it for the change operation by
adding && (cfg->fc_nlflags & NLM_F_REPLACE) check, otherwise if
we change the prepend position (fa_first) route with such prefsrc
can not be installed as first one:

prepend 172.16.42.4 mtu 1280 impossible here if following are
src 172.16.42.2
src 172.16.42.3
<- we do not want here for prepend
src 172.16.42.4

	Even if we consider just the change operation, this patch
will change the expectation that we replace the first alternative
route. But I don't know if one uses alternative routes that
differ in prefsrc. More common example would be alternative routes
that differ in gateway, that is what fib_select_default() and
fib_detect_death() notices as a real alternatives that differ in
neigh state.

	Note that link routes (nhc_scope RT_SCOPE_HOST) or
routes with prefixlen!=0 (fib_select_path) are not considered
as alternatives by the kernel. So, even if we can create such
routes, they are probably not used. So, deleting link routes
by prefsrc is good as we remove routes with deleted prefsrc
but for routing we are using just the first link route.

> +				fa_first = fa;
>  		}
>  
>  		if (cfg->fc_nlflags & NLM_F_REPLACE) {
> -- 
> 2.41.0

Regards

--
Julian Anastasov <ja@ssi.bg>


