Return-Path: <netdev+bounces-275317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFk1LZ9v0Gmo7gYAu9opvQ
	(envelope-from <netdev+bounces-275317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 03:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DB3998A9
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 03:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 961793019516
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307302BDC23;
	Sat,  4 Apr 2026 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLczD5cO"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941021DFD96
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775267741; cv=none; b=Yxpy8nkYw5FSj/ByAglVIMws6aDbusaVI5BzyPKlc0h8olVYX7vjGE+hQQncVFw15MV6vEP6qD+8LTkRGJgi0Ujs2TkqXMNMwxrtpX7i6hHhADub0+7zwzN0qfhrpKHkHKZZCTjxpdXT2Q8YtLSZ1NN12WKVKbpftM+kAptk6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775267741; c=relaxed/simple;
	bh=d0gRG5sUPk/qnF5oEb914IdRgbu7FRiGBIpb6tifVps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB1bMMxACKILVGKyifbaHkmaMZn9aRsMeR8jFQdB/EMd2X1HmI6isEBJ+bmKZC7ntfTFbkZ58kK+O5bjRJykhZ/l6M1mLQ0c+hPyQBxewL9Y/hMsd3/yNEyGYD++usyE3CVrFYSBpygGP59GCrj41N/yGNHn+14u8CJ/tASr/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLczD5cO; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f30ccde-5c6b-42a1-a53a-94f9346794be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775267726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCJGBXnWQyfC1ns6yf/kUaOwu8NxCNbpAODPzSZVwwI=;
	b=JLczD5cOt0njG6ngiMm5ybS30ZdVjsVM64b4EM+RkN26aAcwVICfRBNKKr/jpzWlOceUTm
	Jdb1txgoJuLRWM6FIg2yO0cfLZrGzuQFsmzGvY9m5gMLwcKqbbYxzIi89+unczeXk0VuxH
	NhEKqshBcu1nEtULsdOEiY6zwMbqI8g=
Date: Sat, 4 Apr 2026 09:55:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: mptcp: fix slab-use-after-free in
 __inet_lookup_established
To: mptcp@lists.linux.dev, netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260403130734.93981-1-jiayuan.chen@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260403130734.93981-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 0C6DB3998A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/3/26 9:07 PM, Jiayuan Chen wrote:
> The ehash table lookups are lockless and rely on
> SLAB_TYPESAFE_BY_RCU to guarantee socket memory stability
> during RCU read-side critical sections. Both tcp_prot and
> tcpv6_prot have their slab caches created with this flag
> via proto_register().
>
> However, MPTCP's mptcp_subflow_init() copies tcpv6_prot into
> tcpv6_prot_override during inet_init() (fs_initcall, level 5),
> before inet6_init() (module_init/device_initcall, level 6) has
> called proto_register(&tcpv6_prot). At that point,
> tcpv6_prot.slab is still NULL, so tcpv6_prot_override.slab
> remains NULL permanently.
>
> This causes MPTCP v6 subflow child sockets to be allocated via
> kmalloc (falling into kmalloc-4k) instead of the TCPv6 slab
> cache. The kmalloc-4k cache lacks SLAB_TYPESAFE_BY_RCU, so
> when these sockets are freed without SOCK_RCU_FREE (which is
> cleared for child sockets by design), the memory can be
> immediately reused. Concurrent ehash lookups under
> rcu_read_lock can then access freed memory, triggering a
> slab-use-after-free in __inet_lookup_established.
>
> Fix this by splitting the IPv6-specific initialization out of
> mptcp_subflow_init() into a new mptcp_subflow_v6_init(), which
> is called from mptcpv6_init() after proto_register(&tcpv6_prot)
> has completed. This ensures tcpv6_prot_override.slab correctly
> inherits the SLAB_TYPESAFE_BY_RCU slab cache.
>
> Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   net/mptcp/ctrl.c     |  6 +++++-
>   net/mptcp/protocol.h |  1 +
>   net/mptcp/subflow.c  | 15 +++++++++------
>   3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index d96130e49942..5887ddcdb875 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -583,7 +583,11 @@ int __init mptcpv6_init(void)
>   	int err;
>   
>   	err = mptcp_proto_v6_init();
> +	if (err)
> +		return err;
>   
> -	return err;
> +	mptcp_subflow_v6_init();
> +
> +	return 0;
>   }
>   #endif
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0bd1ee860316..ec15e503da8b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -875,6 +875,7 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
>   void __init mptcp_proto_init(void);
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>   int __init mptcp_proto_v6_init(void);
> +void __init mptcp_subflow_v6_init(void);
>   #endif
>   
>   struct sock *mptcp_sk_clone_init(const struct sock *sk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 6716970693e9..4ff5863aa9fd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -2165,7 +2165,15 @@ void __init mptcp_subflow_init(void)
>   	tcp_prot_override.psock_update_sk_prot = NULL;
>   #endif
>   
> +	mptcp_diag_subflow_init(&subflow_ulp_ops);
> +
> +	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
> +		panic("MPTCP: failed to register subflows to ULP\n");
> +}
> +
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +void __init mptcp_subflow_v6_init(void)
> +{
>   	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
>   	 * structures for v4 and v6 have the same size. It should not changed in
>   	 * the future but better to make sure to be warned if it is no longer
> @@ -2204,10 +2212,5 @@ void __init mptcp_subflow_init(void)
>   	/* Disable sockmap processing for subflows */
>   	tcpv6_prot_override.psock_update_sk_prot = NULL;
>   #endif
> -#endif
> -
> -	mptcp_diag_subflow_init(&subflow_ulp_ops);
> -
> -	if (tcp_register_ulp(&subflow_ulp_ops) != 0)
> -		panic("MPTCP: failed to register subflows to ULP\n");
>   }
> +#endif



I think the AI review is not accurate here.
https://sashiko.dev/#/patchset/20260403130734.93981-1-jiayuan.chen%40linux.dev

Userspace programs only start running after all initcalls have 
completed, so there is no race condition.


