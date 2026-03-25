Return-Path: <netdev+bounces-271703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DoQMCw0xGkAxQQAu9opvQ
	(envelope-from <netdev+bounces-271703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:14:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D632B151
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 396A9302CE10
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B433D4E9;
	Wed, 25 Mar 2026 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9PzW5EN"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0E13D51E;
	Wed, 25 Mar 2026 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465915; cv=none; b=OmJhyoxGyRqcKbLdj0nCFYqlGFcvGFOwqHOD3FKZhvdrFWe6p6b4yNPoJm1N2kN+3dFLPfFrH9sGfFAgIPWg5icjF2mgU1PuYw0nbi2Esp9kRC2lhux41wjgfsAfxsWyysqHOAl5S/exM3wElzbSwSkq9bYLe70MawpMlXpGHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465915; c=relaxed/simple;
	bh=3sJ77Gp7qkVWLtd/dpYIZhb93hL1rpNpMqHMEm5E89E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt2p6Y3FSZPoMAzdaXITF28QjYTbVRrLWNGzG+Z5N4XmY1kdY9wFR8yagk9355wiAZRdjcjVdCZQNiBTCUAusFPrkquQ1m5deikZfV77/GkOW69IrHB0NMkRGOWDSdPa7ty6G5DrEUDikuysnSgLJ8wR8T5bWqmV/fIWtBMNFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9PzW5EN; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774465902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bwzI5I4kMNZg9C5PXzD0ZvcdZx2z7+EA/lSvVzkZ5w=;
	b=q9PzW5EN5yrzsQ4r7/PCue0LoxNXR8Xpq/nGPlqKH3WZh/h7pweNW66NzeYTdB7QLbXU67
	YS01LH2u8H7HTENe1oza9K20EHZLwWM+ysVNiamBYiNBS0CCETSUYDQouWXIwRa8+1QdZo
	alt74wq8qcrBXopcorCb3u09udm4czc=
Date: Wed, 25 Mar 2026 12:11:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260325120928.15848-10-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271703-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AF5D632B151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 5:08 AM, Fernando Fernandez Mancera wrote:
> As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.
> 
> Convert all ipv6_bpf_stub usage to direct function calls instead. The
> fallback functions introduced previously will prevent linkage errors
> when CONFIG_IPV6 is disabled.

Thanks for working on this.

> @@ -6221,8 +6215,8 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   	if (likely(nhc->nhc_gw_family != AF_INET6))
>   		neigh = __ipv4_neigh_lookup_noref(dev,
>   						  (__force u32)params->ipv4_dst);
> -	else
> -		neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
> +	else if (IS_ENABLED(CONFIG_IPV6))
> +		neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);

Should it be ipv6_mod_enabled() instead of IS_ENABLED(CONFIG_IPV6)?
Is nd_tbl always initialized?

>   
>   	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>   		return BPF_FIB_LKUP_RET_NO_NEIGH;
> @@ -6290,12 +6284,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   			params->tbid = 0;
>   		}
>   
> -		tb = ipv6_stub->fib6_get_table(net, tbid);
> +		tb = fib6_get_table(net, tbid);
>   		if (unlikely(!tb))
>   			return BPF_FIB_LKUP_RET_NOT_FWDED;
>   
> -		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
> -						   strict);
> +		err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);

A similar question here and other changes in the patch.

I think bpf_ipv6_fib_lookup() is fine because the earlier
"!idev" check should fail when ipv6 is disabled at boot time?

>   	} else {
>   		if (flags & BPF_FIB_LOOKUP_MARK)
>   			fl6.flowi6_mark = params->mark;
> @@ -6305,7 +6298,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   		fl6.flowi6_tun_key.tun_id = 0;
>   		fl6.flowi6_uid = sock_net_uid(net, NULL);
>   
> -		err = ipv6_stub->fib6_lookup(net, oif, &fl6, &res, strict);
> +		err = fib6_lookup(net, oif, &fl6, &res, strict);
>   	}
>   
>   	if (unlikely(err || IS_ERR_OR_NULL(res.f6i) ||
> @@ -6326,11 +6319,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   		return BPF_FIB_LKUP_RET_NOT_FWDED;
>   	}
>   
> -	ipv6_stub->fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
> -				    fl6.flowi6_oif != 0, NULL, strict);
> +	fib6_select_path(net, &res, &fl6, fl6.flowi6_oif,
> +			 fl6.flowi6_oif != 0, NULL, strict);
>   
>   	if (check_mtu) {
> -		mtu = ipv6_stub->ip6_mtu_from_fib6(&res, dst, src);
> +		mtu = ip6_mtu_from_fib6(&res, dst, src);
>   		if (params->tot_len > mtu) {
>   			params->mtu_result = mtu; /* union with tot_len */
>   			return BPF_FIB_LKUP_RET_FRAG_NEEDED;
> @@ -6351,9 +6344,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   		if (res.f6i->fib6_prefsrc.plen) {
>   			*src = res.f6i->fib6_prefsrc.addr;
>   		} else {
> -			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
> -								&fl6.daddr, 0,
> -								src);
> +			err = ipv6_dev_get_saddr(net, dev, &fl6.daddr, 0, src);
>   			if (err)
>   				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
>   		}
> @@ -6365,7 +6356,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>   	/* xdp and cls_bpf programs are run in RCU-bh so rcu_read_lock_bh is
>   	 * not needed here.
>   	 */
> -	neigh = __ipv6_neigh_lookup_noref_stub(dev, dst);
> +	neigh = __ipv6_neigh_lookup_noref(dev, dst);
>   	if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>   		return BPF_FIB_LKUP_RET_NO_NEIGH;
>   	memcpy(params->dmac, neigh->ha, ETH_ALEN);
> @@ -6900,11 +6891,10 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
>   					    src6, tuple->ipv6.sport,
>   					    dst6, ntohs(tuple->ipv6.dport),
>   					    dif, sdif, &refcounted);
> -		else if (likely(ipv6_bpf_stub))
> -			sk = ipv6_bpf_stub->udp6_lib_lookup(net,
> -							    src6, tuple->ipv6.sport,
> -							    dst6, tuple->ipv6.dport,
> -							    dif, sdif, NULL);
> +		else if (likely(ipv6_mod_enabled()))
> +			sk = __udp6_lib_lookup(net, src6, tuple->ipv6.sport,
> +					       dst6, tuple->ipv6.dport,
> +					       dif, sdif, NULL);
>   #endif
>   	}
>   
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index 9f40be0c3e71..f71ef82a5f3d 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -13,7 +13,6 @@
>   #include <net/gre.h>
>   #include <net/ip.h>
>   #include <net/ip6_route.h>
> -#include <net/ipv6_stubs.h>
>   
>   struct bpf_lwt_prog {
>   	struct bpf_prog *prog;
> @@ -103,7 +102,12 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>   		dev_put(dev);
>   	} else if (skb->protocol == htons(ETH_P_IPV6)) {
>   		skb_dst_drop(skb);
> -		err = ipv6_stub->ipv6_route_input(skb);
> +		if (IS_ENABLED(CONFIG_IPV6)) {
> +			ip6_route_input(skb);
> +			err = skb_dst(skb)->error;
> +		} else {
> +			err = -EAFNOSUPPORT;
> +		}
>   	} else {
>   		err = -EAFNOSUPPORT;
>   	}
> @@ -233,7 +237,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
>   		fl6.daddr = iph6->daddr;
>   		fl6.saddr = iph6->saddr;
>   
> -		dst = ipv6_stub->ipv6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
> +		dst = ip6_dst_lookup_flow(net, skb->sk, &fl6, NULL);
>   		if (IS_ERR(dst)) {
>   			err = PTR_ERR(dst);
>   			goto err;
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index bb29b29fdcfb..07ae6ea7743a 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -264,8 +264,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>   	goto out;
>   }
>   
> -static int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
> -			u32 flags)
> +int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
> +		 u32 flags)
>   {
>   	struct sockaddr_in6 *addr = (struct sockaddr_in6 *)uaddr;
>   	struct inet_sock *inet = inet_sk(sk);
> @@ -1032,14 +1032,6 @@ static const struct ipv6_stub ipv6_stub_impl = {
>   	.ip6_xmit = ip6_xmit,
>   };
>   
> -static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
> -	.inet6_bind = __inet6_bind,
> -	.udp6_lib_lookup = __udp6_lib_lookup,
> -	.ipv6_setsockopt = do_ipv6_setsockopt,
> -	.ipv6_getsockopt = do_ipv6_getsockopt,
> -	.ipv6_dev_get_saddr = ipv6_dev_get_saddr,
> -};
> -
>   static int __init inet6_init(void)
>   {
>   	struct list_head *r;
> @@ -1199,7 +1191,6 @@ static int __init inet6_init(void)
>   	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
>   	wmb();
>   	ipv6_stub = &ipv6_stub_impl;
> -	ipv6_bpf_stub = &ipv6_bpf_stub_impl;
>   out:
>   	return err;
>   


