Return-Path: <netdev+bounces-24226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D676F5D5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 00:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676651C215EC
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FA25921;
	Thu,  3 Aug 2023 22:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5FEA0
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 22:46:34 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0133468A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691102793; x=1722638793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JEwDUJ1MERmGAkWquw7G1cp5IE+vODCOdunGP1L2g3I=;
  b=A3ux61HHBzhtlbLMlBNco54oYqrKOxFpYav3x1uu7u9HmAbe1R27VHl5
   PQ2dihwSUd685deevyKR1jighv62cvuozRT9gUNZBeAYeO94+gA+q4Wf7
   lX9bHTjhDYysjoaMQl5xKQ1aQNHU5auHAJ79VLkk51eF/TL+Vwq/0MoTc
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,253,1684800000"; 
   d="scan'208";a="20517477"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:46:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 638B940DB5;
	Thu,  3 Aug 2023 22:46:31 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:46:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 22:46:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 1/2] tcp: Disable header prediction for MD5 flow.
Date: Thu, 3 Aug 2023 15:45:51 -0700
Message-ID: <20230803224552.69398-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230803224552.69398-1-kuniyu@amazon.com>
References: <20230803224552.69398-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.14]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCP socket saves the minimum required header length in tcp_header_len
of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
to generate a part of TCP header in tcp_sock(sk)->pred_flags.

In tcp_rcv_established(), if the incoming packet has the same pattern
with pred_flags, we enter the fast path and skip full option parsing.

The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
again later in tcp_rcv_established() unless other options exist.  We
add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len in two paths to avoid the
slow path.

For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
to tcp_header_len in tcp_create_openreq_child() after 3WHS.

On the other hand, we do it in tcp_connect_init() for active open
connections.  However, the value is overwritten while processing
SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().

These two cases will have the wrong value in pred_flags and never go
into the fast path.

We could update tcp_header_len in tcp_rcv_synsent_state_process(), but
a test with slightly modified netperf which uses MD5 for each flow shows
that the slow path is actually a bit faster than the fast path.

  On c5.4xlarge EC2 instance (16 vCPU, 32 GiB mem)

  $ for i in {1..10}; do
  ./super_netperf $(nproc) -H localhost -l 10 -- -m 256 -M 256;
  done

  Avg of 10
  * 36e68eadd303  : 10.376 Gbps
  * all fast path : 10.374 Gbps (patch v2, See Link)
  * all slow path : 10.394 Gbps

The header prediction is not worth adding complexity for MD5, so let's
disable it for MD5.

Link: https://lore.kernel.org/netdev/20230803042214.38309-1-kuniyu@amazon.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3:
  * Disable header prediction

v2: https://lore.kernel.org/netdev/20230803042214.38309-1-kuniyu@amazon.com/
  * Update function graph

v1: https://lore.kernel.org/netdev/20230803011658.17086-1-kuniyu@amazon.com/
---
 net/ipv4/tcp_minisocks.c | 2 --
 net/ipv4/tcp_output.c    | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c8f2aa003387..ddba3b67f7c8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -570,8 +570,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->tsoffset = treq->ts_off;
 #ifdef CONFIG_TCP_MD5SIG
 	newtp->md5sig_info = NULL;	/*XXX*/
-	if (treq->af_specific->req_md5_lookup(sk, req_to_sk(req)))
-		newtp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
 #endif
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 51d8638d4b4c..c5412ee77fc8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3741,11 +3741,6 @@ static void tcp_connect_init(struct sock *sk)
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps))
 		tp->tcp_header_len += TCPOLEN_TSTAMP_ALIGNED;
 
-#ifdef CONFIG_TCP_MD5SIG
-	if (tp->af_specific->md5_lookup(sk, sk))
-		tp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
-#endif
-
 	/* If user gave his TCP_MAXSEG, record it to clamp */
 	if (tp->rx_opt.user_mss)
 		tp->rx_opt.mss_clamp = tp->rx_opt.user_mss;
-- 
2.30.2


