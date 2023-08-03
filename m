Return-Path: <netdev+bounces-23879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC576DF2D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 05:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BB71C2138F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5318C0A;
	Thu,  3 Aug 2023 03:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200718BFF
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:55:34 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEE2D62
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691034934; x=1722570934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j62fn2GezZII5YL4BW4HIcDLa8rY020ja7Tlk7IqUTI=;
  b=HjtrC/VH8Vj4sFOLF0DlEBg0Y+GgSH2PJYoaP4UNsnEE9mKMQ+d1Cg9P
   8H3hPXPCqTQ3CusJGS1yMToZgb2wG9KLwVg5lgkNKrQSfgsCnsoICH4IB
   XzGpvPZnOus0I3/xjQNWAnCjUKkPtiKHT1d2QxUBMcNn8g77r0zeOSaaC
   g=;
X-IronPort-AV: E=Sophos;i="6.01,251,1684800000"; 
   d="scan'208";a="343324220"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:55:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id E0ADD470A4;
	Thu,  3 Aug 2023 03:55:28 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:55:28 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:55:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH v1 net] tcp: Enable header prediction for active open connections with MD5.
Date: Wed, 2 Aug 2023 20:55:17 -0700
Message-ID: <20230803035517.35188-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230803011658.17086-1-kuniyu@amazon.com>
References: <20230803011658.17086-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 2 Aug 2023 18:16:58 -0700
> TCP socket saves the minimum required header length in tcp_header_len
> of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
> to generate a part of TCP header in tcp_sock(sk)->pred_flags.
> 
> In tcp_rcv_established(), if the incoming packet has the same pattern
> with pred_flags, we enter the fast path and skip full option parsing.
> 
> The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> again later in tcp_rcv_established() unless other options exist.  Thus,
> MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
> slow path.
> 
> For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> to tcp_header_len in tcp_create_openreq_child() after 3WHS.
> 
> On the other hand, we do it in tcp_connect_init() for active open
> connections.  However, the value is overwritten while processing
> SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
> 
>   SYN+ACK:
>   tcp_rcv_synsent_state_process
>     tp->tcp_header_len = sizeof(struct tcphdr) or
>                          sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
>     tcp_finish_connect
>       __tcp_fast_path_on
> 
>   Crossed SYN:
>   tcp_rcv_synsent_state_process
>     tp->tcp_header_len = sizeof(struct tcphdr) or
>                          sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
>     tcp_finish_connect

Wrong copy-and-paste here.  Will fix in v2.

pw-bot: cr


> 
>   tcp_v4_rcv
>     tcp_v4_do_rcv
>       tcp_rcv_state_process
>         tcp_fast_path_on
> 
> So these two cases will have the wrong value in pred_flags and never
> go into the fast path.
> 
> Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
> to enable header prediction for active open connections.
> 
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/tcp_input.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 57c8af1859c1..4d274b511d97 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6291,6 +6291,11 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>  			tp->tcp_header_len = sizeof(struct tcphdr);
>  		}
>  
> +#ifdef CONFIG_TCP_MD5SIG
> +		if (tp->af_specific->md5_lookup(sk, sk))
> +			tp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
> +#endif
> +
>  		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
>  		tcp_initialize_rcv_mss(sk);
>  
> @@ -6368,6 +6373,11 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>  			tp->tcp_header_len = sizeof(struct tcphdr);
>  		}
>  
> +#ifdef CONFIG_TCP_MD5SIG
> +		if (tp->af_specific->md5_lookup(sk, sk))
> +			tp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
> +#endif
> +
>  		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
>  		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
>  		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
> -- 
> 2.30.2

