Return-Path: <netdev+bounces-18423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C740B756DA4
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DEB2814BC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2FC2CB;
	Mon, 17 Jul 2023 19:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397E253CE
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:51:34 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77BA1B1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689623492; x=1721159492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+22vEzH9uGZr97L6DScONeNVJ/PItIbyRDLR1AbIO0c=;
  b=UuyP3AXVGwKO7HknxC4ubSFW62w1s80UzcgYJI4IIvqZjkneFFReL6mY
   hW3tVSNGkGc9xJ9xWFCxBVsj0UqreWfDeujfWli5lTiMToOs7tyYlDo6c
   VVhgimvt9P0Vmtu9bb/+ZiQUm1G/yMY/xwqxtAyWXLT6Ftce3WIvSqf2r
   c=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="16846975"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:51:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id B1E0F805F0;
	Mon, 17 Jul 2023 19:51:26 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:51:25 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:51:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net 1/2] tcp: annotate data-races around tcp_rsk(req)->txhash
Date: Mon, 17 Jul 2023 12:51:13 -0700
Message-ID: <20230717195113.428-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144445.653164-2-edumazet@google.com>
References: <20230717144445.653164-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Jul 2023 14:44:44 +0000
> TCP request sockets are lockless, some of their fields
> can change while being read by another cpu as syzbot noticed.
> 
> This is usually harmless, but we should annotate the known
> races.
> 
> This patch takes care of tcp_rsk(req)->txhash,
> a separate one is needed for tcp_rsk(req)->ts_recent.
> 
> BUG: KCSAN: data-race in tcp_make_synack / tcp_rtx_synack
> 
> write to 0xffff8881362304bc of 4 bytes by task 32083 on cpu 1:
> tcp_rtx_synack+0x9d/0x2a0 net/ipv4/tcp_output.c:4213
> inet_rtx_syn_ack+0x38/0x80 net/ipv4/inet_connection_sock.c:880
> tcp_check_req+0x379/0xc70 net/ipv4/tcp_minisocks.c:665
> tcp_v6_rcv+0x125b/0x1b20 net/ipv6/tcp_ipv6.c:1673
> ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
> ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
> dst_input include/net/dst.h:468 [inline]
> ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
> __netif_receive_skb_one_core net/core/dev.c:5452 [inline]
> __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
> netif_receive_skb_internal net/core/dev.c:5652 [inline]
> netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
> tun_rx_batched+0x3bf/0x400
> tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
> tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
> call_write_iter include/linux/fs.h:1871 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x4ab/0x7d0 fs/read_write.c:584
> ksys_write+0xeb/0x1a0 fs/read_write.c:637
> __do_sys_write fs/read_write.c:649 [inline]
> __se_sys_write fs/read_write.c:646 [inline]
> __x64_sys_write+0x42/0x50 fs/read_write.c:646
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read to 0xffff8881362304bc of 4 bytes by task 32078 on cpu 0:
> tcp_make_synack+0x367/0xb40 net/ipv4/tcp_output.c:3663
> tcp_v6_send_synack+0x72/0x420 net/ipv6/tcp_ipv6.c:544
> tcp_conn_request+0x11a8/0x1560 net/ipv4/tcp_input.c:7059
> tcp_v6_conn_request+0x13f/0x180 net/ipv6/tcp_ipv6.c:1175
> tcp_rcv_state_process+0x156/0x1de0 net/ipv4/tcp_input.c:6494
> tcp_v6_do_rcv+0x98a/0xb70 net/ipv6/tcp_ipv6.c:1509
> tcp_v6_rcv+0x17b8/0x1b20 net/ipv6/tcp_ipv6.c:1735
> ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:437
> ip6_input_finish net/ipv6/ip6_input.c:482 [inline]
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:491
> dst_input include/net/dst.h:468 [inline]
> ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:309
> __netif_receive_skb_one_core net/core/dev.c:5452 [inline]
> __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5566
> netif_receive_skb_internal net/core/dev.c:5652 [inline]
> netif_receive_skb+0x4a/0x310 net/core/dev.c:5711
> tun_rx_batched+0x3bf/0x400
> tun_get_user+0x1d24/0x22b0 drivers/net/tun.c:1997
> tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2043
> call_write_iter include/linux/fs.h:1871 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x4ab/0x7d0 fs/read_write.c:584
> ksys_write+0xeb/0x1a0 fs/read_write.c:637
> __do_sys_write fs/read_write.c:649 [inline]
> __se_sys_write fs/read_write.c:646 [inline]
> __x64_sys_write+0x42/0x50 fs/read_write.c:646
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x91d25731 -> 0xe79325cd
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 32078 Comm: syz-executor.4 Not tainted 6.5.0-rc1-syzkaller-00033-geb26cbb1a754 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> 
> Fixes: 58d607d3e52f ("tcp: provide skb->hash to synack packets")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_ipv4.c      | 3 ++-
>  net/ipv4/tcp_minisocks.c | 2 +-
>  net/ipv4/tcp_output.c    | 4 ++--
>  net/ipv6/tcp_ipv6.c      | 2 +-
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd365de4d5ffca5e6cb22d056acb27a1a40a497f..fa04ff49100ba09bb17ccb54664c17fc1a9d170e 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -992,7 +992,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			0,
>  			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
>  			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
> -			ip_hdr(skb)->tos, tcp_rsk(req)->txhash);
> +			ip_hdr(skb)->tos,
> +			READ_ONCE(tcp_rsk(req)->txhash));
>  }
>  
>  /*
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 04fc328727e68404000e4068d741225d00c6e33c..ec05f277ce2ef8f72e2039fab2d5624a4104c869 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -528,7 +528,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>  	newicsk->icsk_ack.lrcvtime = tcp_jiffies32;
>  
>  	newtp->lsndtime = tcp_jiffies32;
> -	newsk->sk_txhash = treq->txhash;
> +	newsk->sk_txhash = READ_ONCE(treq->txhash);
>  	newtp->total_retrans = req->num_retrans;
>  
>  	tcp_init_xmit_timers(newsk);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 2cb39b6dad029c8935b8c31c6a19bd72e7507a12..3b09cd13e2db312198ff314fafd98bccfa8266c8 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3660,7 +3660,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  	rcu_read_lock();
>  	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
>  #endif
> -	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
> +	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
>  	/* bpf program will be interested in the tcp_flags */
>  	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
>  	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
> @@ -4210,7 +4210,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
>  
>  	/* Paired with WRITE_ONCE() in sock_setsockopt() */
>  	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
> -		tcp_rsk(req)->txhash = net_tx_rndhash();
> +		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
>  	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
>  				  NULL);
>  	if (!res) {
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 40dd92a2f4807960c7939a19adccdd1b493c30b1..eb96a8010414bda2eae39c3d8d0bac76ad465165 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1129,7 +1129,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			req->ts_recent, sk->sk_bound_dev_if,
>  			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
>  			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
> -			tcp_rsk(req)->txhash);
> +			READ_ONCE(tcp_rsk(req)->txhash));
>  }
>  
>  
> -- 
> 2.41.0.255.g8b1d071c50-goog

