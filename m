Return-Path: <netdev+bounces-23884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5A76DF61
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E4D281F89
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 04:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC708F4F;
	Thu,  3 Aug 2023 04:22:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD48F43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:22:43 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7A30C7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691036556; x=1722572556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6b6EluS52ZyeAZHJM5peJyc3e/yORy5d3aMYZD1MsvQ=;
  b=j6/7CySPqOauJMF/1PBXISFlz7JBfsGPTJN9hiZGd4rQagO9rro/FGNW
   I1mytiolaqnRJxfoC+jTRU4bgLYrEBviBz36F5c/LM+540Q5gysRTlaPV
   9sIIp79Eww8Ra5K9SvwgtUlbUjTCTjiBxzbHv74gVN7Jb7CpQFZ/hIw7Y
   E=;
X-IronPort-AV: E=Sophos;i="6.01,251,1684800000"; 
   d="scan'208";a="146396868"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:22:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id AC11945D3C;
	Thu,  3 Aug 2023 04:22:32 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 04:22:26 +0000
Received: from 88665a182662.ant.amazon.com (10.142.140.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Thu, 3 Aug 2023 04:22:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net] tcp: Enable header prediction for active open connections with MD5.
Date: Wed, 2 Aug 2023 21:22:14 -0700
Message-ID: <20230803042214.38309-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.142.140.92]
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
again later in tcp_rcv_established() unless other options exist.  Thus,
MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
slow path.

For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
to tcp_header_len in tcp_create_openreq_child() after 3WHS.

On the other hand, we do it in tcp_connect_init() for active open
connections.  However, the value is overwritten while processing
SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().

  1) SYN+ACK

    tcp_rcv_synsent_state_process
      tp->tcp_header_len = sizeof(struct tcphdr) or
                           sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
      tcp_finish_connect
        __tcp_fast_path_on
      tcp_send_ack

  2) Crossed SYN and the following ACK

    tcp_rcv_synsent_state_process
      tp->tcp_header_len = sizeof(struct tcphdr) or
                           sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
      tcp_set_state(sk, TCP_SYN_RECV)
      tcp_send_synack

    -- ACK received --
    tcp_v4_rcv
      tcp_v4_do_rcv
        tcp_rcv_state_process
          tcp_fast_path_on
            __tcp_fast_path_on

So these two cases will have the wrong value in pred_flags and never
go into the fast path.

Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
to enable header prediction for active open connections.

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Update function graph

v1: https://lore.kernel.org/all/20230803011658.17086-1-kuniyu@amazon.com/
---
 net/ipv4/tcp_input.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 57c8af1859c1..4d274b511d97 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6291,6 +6291,11 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			tp->tcp_header_len = sizeof(struct tcphdr);
 		}
 
+#ifdef CONFIG_TCP_MD5SIG
+		if (tp->af_specific->md5_lookup(sk, sk))
+			tp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
+#endif
+
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 		tcp_initialize_rcv_mss(sk);
 
@@ -6368,6 +6373,11 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			tp->tcp_header_len = sizeof(struct tcphdr);
 		}
 
+#ifdef CONFIG_TCP_MD5SIG
+		if (tp->af_specific->md5_lookup(sk, sk))
+			tp->tcp_header_len += TCPOLEN_MD5SIG_ALIGNED;
+#endif
+
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-- 
2.30.2


