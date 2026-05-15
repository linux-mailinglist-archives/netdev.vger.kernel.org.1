Return-Path: <netdev+bounces-288215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGusC5/OBmqAoAIAu9opvQ
	(envelope-from <netdev+bounces-288215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FD54AC59
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4583F302DF45
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1637DEB4;
	Fri, 15 May 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXHJflXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2A37474A
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830743; cv=none; b=PLSwxLdQMxqni3YKMzTrkmKaaY3zHRfQ/B3uO/n+Qx3Qu+Jg6WvF2JiifOOojVABCFAALjaPYqpSBlZw/LCi0qUOdhciY6Fs+M1dBuRqHlvDchckBUc6d7gZf/xG/g6z9Lo3zDBZEQL+FfrSQJLm0S//DJMD5rxPa3rYFRuTxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830743; c=relaxed/simple;
	bh=viBXqwyvXK9gpufOAQnli5t6y7N/k8IRJxVJxqjcIzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TuZqRDiAZ+7nqOq4VwTHycRoADBPKe4p+WLueeN50VXCZs7QRpN/DaXRSk7WnJP/ZV+iQ6iGuiSUUGIpRsRSh3YG72CG7TFK8WNXnROTNsQfGa2/vxGH6CabcwjOhniYL8fm2Zm6L51/69aGvWbdnmWMZDZbXLo6p5Nf1R6HXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXHJflXo; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90f74de8cbcso587205985a.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778830741; x=1779435541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6qft15bD4Qc2qX1OC2DNH2Ss7HwpryBZ6XacMirxDhs=;
        b=mXHJflXotWPBqIPooqnxOvK7CREL/8+rJEGpIbDIsfoWPqRlWN3SxQ40fej15pG2m3
         TlsRenuF9e3QH9QGBBeB+zNK8IQkbdzaJCqezAaoIb7w8FuGgCiZkgtFGh4hUodO4ySC
         0/TxXmL6ASbKKRa4lO+ACkZZleD0Zz+jlx0dXiTyITzSfR1EOLA+Ch2YgPCZxLLFCO2s
         n1uy7sKSwKxwFT/LE4FF9n9tGZJcsLjIC6ZUJWoUGKONMnthgNK+VEqgpmZFQ0fctVbK
         DLWs7ainJXO5p/Fa9//VqYD1Bx4nCVgtTM7zPQXjFYJgAqb3MHg4flcAeyA7QRt4V8n7
         pN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778830741; x=1779435541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qft15bD4Qc2qX1OC2DNH2Ss7HwpryBZ6XacMirxDhs=;
        b=cOAlnyJ/58VszVvjECL5VS9GCxx8SVvuInz4UEKcfG9sInWiXS0NpIWdCvPn5d+OqQ
         GGguQV2lwq7SSon+eBL2elKQt859cFB4Fjgffz98j0hGtWFm7oIGG3pMMBL+Pjlkl3Jt
         bZI8QiuKS8Otznje4LFMeVDITPhST3IP+Y2GkO/aM5WVhhgGyzRq0GFPtEqIrXA2ExhK
         W959GcuNDI/BvW11uLfYAX4QHL4HmeVozfaENFovSliv5Vyg4gFXA6obsagtuw94iBED
         Et8Ew6EsebLbcGFr+j5G2hXrYK/J2V4qZuTiFuCOozjktKqdzzbX2LOf111jhbePmXTU
         Idow==
X-Forwarded-Encrypted: i=1; AFNElJ+8vienq2F9DsNm/LbQHHmzF1npmnhOZa03tDkPGPhnYjMjoMA5W60M9LWl73tYMqq55bO1zyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyREYffBxc93H8u1FqgSgug4JEvU2kWr+yReQcAviSDtCSP0Oq
	qaIy83G9B8egmd7HCfP2pPYY8ql37MWxdTGGRqcBRbes4z39sMIyKZZN16YZYCPirUMEqVCsq95
	yer52nHGaYYyNtg==
X-Received: from qknvz9.prod.google.com ([2002:a05:620a:4949:b0:8d3:e114:9744])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28cb:b0:8ef:3312:a148 with SMTP id af79cd13be357-911c9f5b535mr453864685a.0.1778830740480;
 Fri, 15 May 2026 00:39:00 -0700 (PDT)
Date: Fri, 15 May 2026 07:38:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515073859.957056-1-edumazet@google.com>
Subject: [PATCH v3 net] tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A75FD54AC59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288215-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action

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
tcp_conn_request(), receiving a predictable ISN.

This patch moves back tcp_tw_isn to skb, but not in skb->cb[] which
was the original problem.

Instead, union it with skb->mark / skb->reserved_tailroom which
are unused in TCP receive path.

Fixes: 41eecbd712b7 ("tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h   |  2 ++
 include/net/tcp.h        |  3 ---
 net/ipv4/tcp.c           |  3 ---
 net/ipv4/tcp_input.c     | 15 ++++++---------
 net/ipv4/tcp_ipv4.c      |  5 ++---
 net/ipv4/tcp_minisocks.c |  5 +++--
 net/ipv6/tcp_ipv6.c      |  5 ++---
 7 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b9edb0d1342319d4340c0a9997eeb..8a5082685b822057bff7f49d71fd6bd6e2553f91 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -860,6 +860,7 @@ enum skb_tstamp_type {
  *	@mark: Generic packet mark
  *	@reserved_tailroom: (aka @mark) number of bytes of free space available
  *		at the tail of an sk_buff
+ *	@tcp_tw_isn: ISN when a TW socket receives a valid SYN.
  *	@vlan_all: vlan fields (proto & tci)
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
@@ -1066,6 +1067,7 @@ struct sk_buff {
 	union {
 		__u32		mark;
 		__u32		reserved_tailroom;
+		u32		tcp_tw_isn;
 	};
 
 	union {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a7446cb18c245e670ba49ff574dfaff7..74835c51e0d55ee9b35d422d442f951e37d95cbc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -65,8 +65,6 @@ static inline void tcp_orphan_count_dec(void)
 	this_cpu_dec(tcp_orphan_count);
 }
 
-DECLARE_PER_CPU(u32, tcp_tw_isn);
-
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
 #define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
@@ -479,7 +477,6 @@ enum tcp_tw_status {
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
 					      const struct tcphdr *th,
-					      u32 *tw_isn,
 					      enum skb_drop_reason *drop_reason);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
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
index d5c9e65d97606d8eb57aba8ebc2373adf1bed62b..203660dc94efddfb6a79db8b5fce4d54dbe0b4ab 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7594,25 +7594,22 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	struct net *net = sock_net(sk);
 	struct sock *fastopen_sk = NULL;
 	union tcp_seq_and_ts_off st;
+	u32 isn = skb->tcp_tw_isn;
 	struct request_sock *req;
 	bool want_cookie = false;
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
+	/* TW buckets are converted to open requests without
+	 * limitations, they conserve resources and peer is
+	 * evidently real one.
+	 */
+	if (!isn) {
 		syncookies = READ_ONCE(net->ipv4.sysctl_tcp_syncookies);
 
 		if (syncookies == 2 || inet_csk_reqsk_queue_is_full(sk)) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c0526cc0398049fb34b5de20a1175d54942e80cd..719cfab3cd0296652791b9720fc25c9e437ca403 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2077,7 +2077,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	struct sock *sk = NULL;
 	bool refcounted;
 	int ret;
-	u32 isn;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -2198,6 +2197,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 
+	skb->tcp_tw_isn = 0;
 process:
 	if (static_branch_unlikely(&ip4_min_ttl)) {
 		/* min_ttl can be changed concurrently from do_ip_setsockopt() */
@@ -2299,7 +2299,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th,
 					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN: {
@@ -2313,7 +2313,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v4_restore_cb(skb);
 			refcounted = false;
-			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e6092c3ac840bdc1f62d4435c414e7f79edc10c2..8396f396f326336a31bde408dfffcdd7de95187b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -99,7 +99,7 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq,
  */
 enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
-			   const struct tcphdr *th, u32 *tw_isn,
+			   const struct tcphdr *th,
 			   enum skb_drop_reason *drop_reason)
 {
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
@@ -255,9 +255,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	     (tmp_opt.saw_tstamp &&
 	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0))) {
 		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
+
 		if (isn == 0)
 			isn++;
-		*tw_isn = isn;
+		skb->tcp_tw_isn = isn;
 		return TCP_TW_SYN;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d13d49bfef19457cc5902cb556605a80f4c0ab2c..208ec75703df17d5e53e133b888b6b93a5ec04e6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1722,7 +1722,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	struct sock *sk = NULL;
 	bool refcounted;
 	int ret;
-	u32 isn;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (skb->pkt_type != PACKET_HOST)
@@ -1839,6 +1838,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 
+	skb->tcp_tw_isn = 0;
 process:
 	if (static_branch_unlikely(&ip6_min_hopcount)) {
 		/* min_hopcount can be changed concurrently from do_ipv6_setsockopt() */
@@ -1937,7 +1937,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th,
 					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN:
@@ -1956,7 +1956,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			sk = sk2;
 			tcp_v6_restore_cb(skb);
 			refcounted = false;
-			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
 
-- 
2.54.0.563.g4f69b47b94-goog


