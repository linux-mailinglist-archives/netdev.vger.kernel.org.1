Return-Path: <netdev+bounces-18424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7A756DAC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABBE1C20B8E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F485C2CC;
	Mon, 17 Jul 2023 19:54:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61785C159
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:53:59 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47E5126
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689623638; x=1721159638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKsKMdRl+V9tJ/cIY57/Bd+rflFoSQZv8NTlH3h8z/Q=;
  b=S1rgpiTEN4BVnzPBbzPrGBV2gC/0K1zvlhRkk0NfalVtMND3rnHTP8KK
   R7TRlNcwxeouhhRbNf2hpWtuNf7S43E81YlottLebIDU/kd2I5aluprjS
   0i4qFSdLJ+vPPHViBBRCY0Au7OfamMiFt3GTkyor7D/H6df/PCzRUFTkV
   U=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="661064405"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:53:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id EB27846BD3;
	Mon, 17 Jul 2023 19:53:48 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:53:41 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:53:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net 2/2] tcp: annotate data-races around tcp_rsk(req)->ts_recent
Date: Mon, 17 Jul 2023 12:53:29 -0700
Message-ID: <20230717195329.574-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717144445.653164-3-edumazet@google.com>
References: <20230717144445.653164-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
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
Date: Mon, 17 Jul 2023 14:44:45 +0000
> TCP request sockets are lockless, tcp_rsk(req)->ts_recent
> can change while being read by another cpu as syzbot noticed.
> 
> This is harmless, but we should annotate the known races.
> 
> Note that tcp_check_req() changes req->ts_recent a bit early,
> we might change this in the future.
> 
> BUG: KCSAN: data-race in tcp_check_req / tcp_check_req
> 
> write to 0xffff88813c8afb84 of 4 bytes by interrupt on cpu 1:
> tcp_check_req+0x694/0xc70 net/ipv4/tcp_minisocks.c:762
> tcp_v4_rcv+0x12db/0x1b70 net/ipv4/tcp_ipv4.c:2071
> ip_protocol_deliver_rcu+0x356/0x6d0 net/ipv4/ip_input.c:205
> ip_local_deliver_finish+0x13c/0x1a0 net/ipv4/ip_input.c:233
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip_local_deliver+0xec/0x1c0 net/ipv4/ip_input.c:254
> dst_input include/net/dst.h:468 [inline]
> ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip_rcv+0x197/0x270 net/ipv4/ip_input.c:569
> __netif_receive_skb_one_core net/core/dev.c:5493 [inline]
> __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5607
> process_backlog+0x21f/0x380 net/core/dev.c:5935
> __napi_poll+0x60/0x3b0 net/core/dev.c:6498
> napi_poll net/core/dev.c:6565 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6698
> __do_softirq+0xc1/0x265 kernel/softirq.c:571
> do_softirq+0x7e/0xb0 kernel/softirq.c:472
> __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:396
> local_bh_enable+0x1f/0x20 include/linux/bottom_half.h:33
> rcu_read_unlock_bh include/linux/rcupdate.h:843 [inline]
> __dev_queue_xmit+0xabb/0x1d10 net/core/dev.c:4271
> dev_queue_xmit include/linux/netdevice.h:3088 [inline]
> neigh_hh_output include/net/neighbour.h:528 [inline]
> neigh_output include/net/neighbour.h:542 [inline]
> ip_finish_output2+0x700/0x840 net/ipv4/ip_output.c:229
> ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:317
> NF_HOOK_COND include/linux/netfilter.h:292 [inline]
> ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:431
> dst_output include/net/dst.h:458 [inline]
> ip_local_out net/ipv4/ip_output.c:126 [inline]
> __ip_queue_xmit+0xa4d/0xa70 net/ipv4/ip_output.c:533
> ip_queue_xmit+0x38/0x40 net/ipv4/ip_output.c:547
> __tcp_transmit_skb+0x1194/0x16e0 net/ipv4/tcp_output.c:1399
> tcp_transmit_skb net/ipv4/tcp_output.c:1417 [inline]
> tcp_write_xmit+0x13ff/0x2fd0 net/ipv4/tcp_output.c:2693
> __tcp_push_pending_frames+0x6a/0x1a0 net/ipv4/tcp_output.c:2877
> tcp_push_pending_frames include/net/tcp.h:1952 [inline]
> __tcp_sock_set_cork net/ipv4/tcp.c:3336 [inline]
> tcp_sock_set_cork+0xe8/0x100 net/ipv4/tcp.c:3343
> rds_tcp_xmit_path_complete+0x3b/0x40 net/rds/tcp_send.c:52
> rds_send_xmit+0xf8d/0x1420 net/rds/send.c:422
> rds_send_worker+0x42/0x1d0 net/rds/threads.c:200
> process_one_work+0x3e6/0x750 kernel/workqueue.c:2408
> worker_thread+0x5f2/0xa10 kernel/workqueue.c:2555
> kthread+0x1d7/0x210 kernel/kthread.c:379
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> read to 0xffff88813c8afb84 of 4 bytes by interrupt on cpu 0:
> tcp_check_req+0x32a/0xc70 net/ipv4/tcp_minisocks.c:622
> tcp_v4_rcv+0x12db/0x1b70 net/ipv4/tcp_ipv4.c:2071
> ip_protocol_deliver_rcu+0x356/0x6d0 net/ipv4/ip_input.c:205
> ip_local_deliver_finish+0x13c/0x1a0 net/ipv4/ip_input.c:233
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip_local_deliver+0xec/0x1c0 net/ipv4/ip_input.c:254
> dst_input include/net/dst.h:468 [inline]
> ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
> NF_HOOK include/linux/netfilter.h:303 [inline]
> ip_rcv+0x197/0x270 net/ipv4/ip_input.c:569
> __netif_receive_skb_one_core net/core/dev.c:5493 [inline]
> __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5607
> process_backlog+0x21f/0x380 net/core/dev.c:5935
> __napi_poll+0x60/0x3b0 net/core/dev.c:6498
> napi_poll net/core/dev.c:6565 [inline]
> net_rx_action+0x32b/0x750 net/core/dev.c:6698
> __do_softirq+0xc1/0x265 kernel/softirq.c:571
> run_ksoftirqd+0x17/0x20 kernel/softirq.c:939
> smpboot_thread_fn+0x30a/0x4a0 kernel/smpboot.c:164
> kthread+0x1d7/0x210 kernel/kthread.c:379
> ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> value changed: 0x1cd237f1 -> 0x1cd237f2
> 
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/ipv4/tcp_ipv4.c      | 2 +-
>  net/ipv4/tcp_minisocks.c | 9 ++++++---
>  net/ipv4/tcp_output.c    | 2 +-
>  net/ipv6/tcp_ipv6.c      | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fa04ff49100ba09bb17ccb54664c17fc1a9d170e..b5c81cf5b86f7cb086c9c9619dec0c088e5d5916 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -988,7 +988,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			tcp_rsk(req)->rcv_nxt,
>  			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
>  			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
> -			req->ts_recent,
> +			READ_ONCE(req->ts_recent),
>  			0,
>  			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
>  			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index ec05f277ce2ef8f72e2039fab2d5624a4104c869..c8f2aa0033871ed3f8b6b045c2cbca6e88bf2b61 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -555,7 +555,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>  	newtp->max_window = newtp->snd_wnd;
>  
>  	if (newtp->rx_opt.tstamp_ok) {
> -		newtp->rx_opt.ts_recent = req->ts_recent;
> +		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
>  		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
>  		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
>  	} else {
> @@ -619,7 +619,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
>  
>  		if (tmp_opt.saw_tstamp) {
> -			tmp_opt.ts_recent = req->ts_recent;
> +			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
>  			if (tmp_opt.rcv_tsecr)
>  				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
>  			/* We do not store true stamp, but it is not required,
> @@ -758,8 +758,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>  
>  	/* In sequence, PAWS is OK. */
>  
> +	/* TODO: We probably should defer ts_recent change once
> +	 * we take ownership of @req.
> +	 */
>  	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
> -		req->ts_recent = tmp_opt.rcv_tsval;
> +		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
>  
>  	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
>  		/* Truncate SYN, it is out of window starting
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3b09cd13e2db312198ff314fafd98bccfa8266c8..51d8638d4b4c61be3d172a354356b31dae9f8c2f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -878,7 +878,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
>  	if (likely(ireq->tstamp_ok)) {
>  		opts->options |= OPTION_TS;
>  		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
> -		opts->tsecr = req->ts_recent;
> +		opts->tsecr = READ_ONCE(req->ts_recent);
>  		remaining -= TCPOLEN_TSTAMP_ALIGNED;
>  	}
>  	if (likely(ireq->sack_ok)) {
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index eb96a8010414bda2eae39c3d8d0bac76ad465165..4714eb695913d43f03f533483560ab8cb5bf555d 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1126,7 +1126,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>  			tcp_rsk(req)->rcv_nxt,
>  			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
>  			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
> -			req->ts_recent, sk->sk_bound_dev_if,
> +			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
>  			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
>  			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority,
>  			READ_ONCE(tcp_rsk(req)->txhash));
> -- 
> 2.41.0.255.g8b1d071c50-goog

