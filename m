Return-Path: <netdev+bounces-46719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D08D7E6107
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 00:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9DB20BE4
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8337374F6;
	Wed,  8 Nov 2023 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AVV1oBGO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AA3717B
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 23:30:28 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896B125B2
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699486228; x=1731022228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JkWNhQYdVLRiq0Uy0XQNnFvYRvc3MKKbo70kvj5B2dM=;
  b=AVV1oBGOgcWLErQHMM5dL58JcgbsgN3uA/9ms9YEHWpFxAiFHq4/J/3T
   75MwHr64BBBeUlEHekGI/EhyiokKY/H3XAXAUN7w38oD0CXqJagFqrN5l
   s84iT+oI8tzBSDlGZjpCwVMAEBy4ioZA9RWioaEiVmGGU6Bvnu7edhxxM
   I=;
X-IronPort-AV: E=Sophos;i="6.03,287,1694736000"; 
   d="scan'208";a="369272438"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:30:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 6867580640;
	Wed,  8 Nov 2023 23:30:23 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:59225]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.174:2525] with esmtp (Farcaster)
 id 594b2c37-c83a-4feb-af61-47fd3a6548bb; Wed, 8 Nov 2023 23:30:22 +0000 (UTC)
X-Farcaster-Flow-ID: 594b2c37-c83a-4feb-af61-47fd3a6548bb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 23:30:22 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 23:30:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sdf@google.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net v2] net: set SOCK_RCU_FREE before inserting socket into hashtable
Date: Wed, 8 Nov 2023 15:30:09 -0800
Message-ID: <20231108233009.29311-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231108211325.18938-1-sdf@google.com>
References: <20231108211325.18938-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.12]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Stanislav Fomichev <sdf@google.com>
Date: Wed,  8 Nov 2023 13:13:25 -0800
> We've started to see the following kernel traces:
> 
>  WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0
> 
>  Call Trace:
>   <IRQ>
>   __bpf_skc_lookup+0x10d/0x120
>   bpf_sk_lookup+0x48/0xd0
>   bpf_sk_lookup_tcp+0x19/0x20
>   bpf_prog_<redacted>+0x37c/0x16a3
>   cls_bpf_classify+0x205/0x2e0
>   tcf_classify+0x92/0x160
>   __netif_receive_skb_core+0xe52/0xf10
>   __netif_receive_skb_list_core+0x96/0x2b0
>   napi_complete_done+0x7b5/0xb70
>   <redacted>_poll+0x94/0xb0
>   net_rx_action+0x163/0x1d70
>   __do_softirq+0xdc/0x32e
>   asm_call_irq_on_stack+0x12/0x20
>   </IRQ>
>   do_softirq_own_stack+0x36/0x50
>   do_softirq+0x44/0x70
> 
> __inet_hash can race with lockless (rcu) readers on the other cpus:
> 
>   __inet_hash
>     __sk_nulls_add_node_rcu
>     <- (bpf triggers here)
>     sock_set_flag(SOCK_RCU_FREE)
> 
> Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
> the socket into hashtables. Note, that the race is really harmless;
> the bpf callers are handling this situation (where listener socket
> doesn't have SOCK_RCU_FREE set) correctly, so the only
> annoyance is a WARN_ONCE.
> 
> More details from Eric regarding SOCK_RCU_FREE timeline:
> 
> Commit 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under
> synflood") added SOCK_RCU_FREE. At that time, the precise location of
> sock_set_flag(sk, SOCK_RCU_FREE) did not matter, because the thread calling
> __inet_hash() owns a reference on sk. SOCK_RCU_FREE was only tested
> at dismantle time.
> 
> Commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> started checking SOCK_RCU_FREE _after_ the lookup to infer whether
> the refcount has been taken care of.
> 
> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/inet_hashtables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 598c1b114d2c..a532f749e477 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -751,12 +751,12 @@ int __inet_hash(struct sock *sk, struct sock *osk)
>  		if (err)
>  			goto unlock;
>  	}
> +	sock_set_flag(sk, SOCK_RCU_FREE);
>  	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
>  		sk->sk_family == AF_INET6)
>  		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
>  	else
>  		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> -	sock_set_flag(sk, SOCK_RCU_FREE);
>  	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  unlock:
>  	spin_unlock(&ilb2->lock);
> -- 
> 2.42.0.869.gea05f2083d-goog


