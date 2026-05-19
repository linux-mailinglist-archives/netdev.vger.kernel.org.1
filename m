Return-Path: <netdev+bounces-289331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGkdC3IjDGpqXAUAu9opvQ
	(envelope-from <netdev+bounces-289331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:46:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B676457A6E3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28DF5302F9C7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A8395254;
	Tue, 19 May 2026 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJYFwKVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD213C585C
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180377; cv=none; b=RcgVfG/mSkC8lvpxA8NtAnX+vDgyVVpsfNoACUd+GcTMS2ddFz/RcCKnV3g/3SW13dhSIUrCvNnIr688uiRw9TXgGgXPUpEgM/VzdHfOJB13vdW2DL1mBxZQwqKaYvAResHVL6prb5KfyMPtw1gIclVHdaxKyt52/PRXDNxk0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180377; c=relaxed/simple;
	bh=XtvZssOFq3x9ABupOERdo79VOaXLriwhFH111CrzZpI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B/azZ7aLcZvltJ9SpNyVoDCg+wxm/k4SrA09uZKIA6Epm6JcKa12KZIX/DLKgWM5B2gfej+f5q0nEFnhDIP9GKn9nXSH74lFNFQFjv6KFcXWJw+/BiZnQmrh2ZvUzNRhdSc4s4Oz/MvT9HWH6qPUlqoBy+3AK1JhPWmqpFmY8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJYFwKVE; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90d6fe98316so776579585a.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779180373; x=1779785173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fo2sHMd0p1op9HVG5DbuQOAb0262oSskb/WnMIBx3ro=;
        b=mJYFwKVE+f/uKvA+W/yZ4Pf+C/FPo8lUqgYP6kBpsSYHR0GoIBcwI0yjUP+SFfUJ7/
         pB0zKUYlr2a1rIt8qIOruR775/l46VQvKDo449iFBzdxE3yOQYmiQDbfFFd/wq0k2/p2
         ymMByk7G0y+n9xCXDeMTE0vzO0oUCjzj4m9iQKimEkNYcv+IjbFIEAmZMTbUScwD53hP
         djdZQKEz9wrjq4ymBca+zNRYLrvhwrGaY3o1CKxd4mHbrHSkzn8mhEY7Et99Wj+1b0fe
         fZm1gWLEMgN1b5xXvsTQJzbxd/DomTQUoj/sUWHtStUztNPfPnXonScx8qIHa2hj6IQe
         j67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180373; x=1779785173;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fo2sHMd0p1op9HVG5DbuQOAb0262oSskb/WnMIBx3ro=;
        b=GOQVXBv5UiefSAaeDwmcGed2M9AbDTECgsRPR7JgfNOzlQvstS1lRsK90SX7RfMHZe
         rU53CIymO2W1VfShaaOvknvoqQiEZD1P4qgyyS96yYUC2bPNI2ZHHdLZzb/l14yZQBeZ
         HLOLtXNm1m0hRETvxWG5itjnP9kHfBp1zmVHNGc0fYgZ+0yvOZyrxOMzNMJ68UlV9U/1
         VWYjJ0gRRH0sySAa155JfisutpN1k8nLP2JLMp+BT3OobULg0FW3gmUqMpfg+7T2kvNh
         7jY/I21kKmVFSSpTZQu2snkg18a9aHwIC3wzqeAnmRwyZOL2ZLV5eBCPnXpjs0nbZIvB
         pdYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XILwigTHJ/KGq5f2F/nQTFqPYG8kP3RqfLxkxVyDxXeg4YKdBm1px3XchpZPdu4xmqI98J40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iwu6PBzL/9aRMVv+/pQwAygje/nU2PcR/MrVCA5vzEpcEpDa
	IGNAt4XCT1Ga6xjY3frQRpxgqUQRshThP+iB0/0FV7XNZ+p5w5Vmve68DXvdE8llCKa/b/Sxyeh
	bZjpUW/OsQCkt9w==
X-Received: from qknsg43.prod.google.com ([2002:a05:620a:936b:b0:912:6847:c74f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3708:b0:8cd:c01f:fd25 with SMTP id af79cd13be357-911cd07b23amr2811427285a.14.1779180372544;
 Tue, 19 May 2026 01:46:12 -0700 (PDT)
Date: Tue, 19 May 2026 08:46:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519084611.2485277-1-edumazet@google.com>
Subject: [PATCH v4 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.com:email,vmlinux.new:url]
X-Rspamd-Queue-Id: B676457A6E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Blamed commit moved the TIME_WAIT-derived ISN from the skb control
block to a per-CPU variable, assuming the value would always be consumed
by tcp_conn_request() for the same packet that wrote it. That assumption
is violated by multiple drop paths between the producer
(__this_cpu_write(tcp_tw_isn, isn) in tcp_v{4,6}_rcv()) and the consumer
(tcp_conn_request()):

 - min_ttl / min_hopcount check
 - xfrm policy check
 - tcp_inbound_hash() MD5/AO mismatch
 - tcp_filter() eBPF/SO_ATTACH_FILTER drop
 - th->syn && th->fin discard in tcp_rcv_state_process() TCP_LISTEN
 - psp_sk_rx_policy_check() in tcp_v{4,6}_do_rcv()
 - tcp_checksum_complete() in tcp_v{4,6}_do_rcv()
 - tcp_v{4,6}_cookie_check() returning NULL

When a packet is dropped on any of these paths, tcp_tw_isn is left set.

The next SYN processed on the same CPU then consumes the non zero value in
tcp_conn_request(), receiving a potentially predictable ISN.

This patch moves back tcp_tw_isn to skb->cb[], getting rid of the per-cpu
variable.

Note that tcp_v{4,6}_fill_cb() do not set it.

Very litle impact on overall code size/complexity:

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 2/1 up/down: 8/-15 (-7)
Function                                     old     new   delta
tcp_v6_rcv                                  3038    3042      +4
tcp_v4_rcv                                  3035    3039      +4
tcp_conn_request                            2938    2923     -15
Total: Before=24436060, After=24436053, chg -0.00%

Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v4: okay, move back tcp_tw_isn to skb->cb[]

 include/net/tcp.h    |  7 ++++---
 net/ipv4/tcp.c       |  3 ---
 net/ipv4/tcp_input.c | 15 ++++++---------
 net/ipv4/tcp_ipv4.c  |  3 ++-
 net/ipv6/tcp_ipv6.c  |  3 ++-
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a7446cb18c245e670ba49ff574dfaff7..98848db62894aa4453efa9db7ea425d0aab263da 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -65,8 +65,6 @@ static inline void tcp_orphan_count_dec(void)
 	this_cpu_dec(tcp_orphan_count);
 }
 
-DECLARE_PER_CPU(u32, tcp_tw_isn);
-
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
 #define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
@@ -1102,10 +1100,13 @@ struct tcp_skb_cb {
 	__u32		seq;		/* Starting sequence number	*/
 	__u32		end_seq;	/* SEQ + FIN + SYN + datalen	*/
 	union {
-		/* Note :
+		/* Notes :
+		 *	tcp_tw_isn is used in input path only
+		 *	(isn chosen by tcp_timewait_state_process())
 		 * 	  tcp_gso_segs/size are used in write queue only,
 		 *	  cf tcp_skb_pcount()/tcp_skb_mss()
 		 */
+		u32		tcp_tw_isn;
 		struct {
 			u16	tcp_gso_segs;
 			u16	tcp_gso_size;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4c8ef5d50339bfdf7da0ea8772b94..389a7cc17110daa5b3b490b3c339e53e212969f8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -299,9 +299,6 @@ enum {
 DEFINE_PER_CPU(unsigned int, tcp_orphan_count);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_orphan_count);
 
-DEFINE_PER_CPU(u32, tcp_tw_isn);
-EXPORT_PER_CPU_SYMBOL_GPL(tcp_tw_isn);
-
 long sysctl_tcp_mem[3] __read_mostly;
 
 DEFINE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d97606d8eb57aba8ebc2373adf1bed62b..de9f68a9c0cf04109101b0d1bca20440376d4b05 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7589,6 +7589,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_fastopen_cookie foc = { .len = -1 };
+	u32 isn = TCP_SKB_CB(skb)->tcp_tw_isn;
 	struct tcp_options_received tmp_opt;
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
@@ -7599,20 +7600,16 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	struct dst_entry *dst;
 	struct flowi fl;
 	u8 syncookies;
-	u32 isn;
 
 #ifdef CONFIG_TCP_AO
 	const struct tcp_ao_hdr *aoh;
 #endif
 
-	isn = __this_cpu_read(tcp_tw_isn);
-	if (isn) {
-		/* TW buckets are converted to open requests without
-		 * limitations, they conserve resources and peer is
-		 * evidently real one.
-		 */
-		__this_cpu_write(tcp_tw_isn, 0);
-	} else {
+	/* If isn is non-zero, this SYN originally matched a TIME_WAIT socket.
+	 * TW sockets are converted to open requests without limitations,
+	 * we skip the queue limits and syncookie checks in the block below.
+	 */
+	if (!isn) {
 		syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
 
 		if (syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c0526cc0398049fb34b5de20a1175d54942e80cd..fdc81150ff6cf938b1971c33b2b997e5d0d8fcaa 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2198,6 +2198,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 
+	isn = 0;
 process:
 	if (static_branch_unlikely(&ip4_min_ttl)) {
 		/* min_ttl can be changed concurrently from do_ip_setsockopt() */
@@ -2227,6 +2228,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
 	tcp_v4_fill_cb(skb, iph, th);
+	TCP_SKB_CB(skb)->tcp_tw_isn = isn;
 
 	skb->dev = NULL;
 
@@ -2313,7 +2315,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v4_restore_cb(skb);
 			refcounted = false;
-			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d13d49bfef19457cc5902cb556605a80f4c0ab2c..36d75fb50a70b728fedb7c316e023758bd61d62c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1839,6 +1839,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 
+	isn = 0;
 process:
 	if (static_branch_unlikely(&ip6_min_hopcount)) {
 		/* min_hopcount can be changed concurrently from do_ipv6_setsockopt() */
@@ -1868,6 +1869,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	th = (const struct tcphdr *)skb->data;
 	hdr = ipv6_hdr(skb);
 	tcp_v6_fill_cb(skb, hdr, th);
+	TCP_SKB_CB(skb)->tcp_tw_isn = isn;
 
 	skb->dev = NULL;
 
@@ -1956,7 +1958,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v6_restore_cb(skb);
 			refcounted = false;
-			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 
-- 
2.54.0.563.g4f69b47b94-goog


