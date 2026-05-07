Return-Path: <netdev+bounces-285437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKu4LEDI/Gn0TgAAu9opvQ
	(envelope-from <netdev+bounces-285437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:13:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607D4ECBD4
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B628300D360
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E13F9F54;
	Thu,  7 May 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZGjlAsZX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1B4508EB
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174011; cv=none; b=VkcnfQVfAvIsGOhIGvRPLw82ZZLg69sQUKILjJT5LaF+VLqFMunmkzY0Y5a40+1UGLw8xeEmtn//euFFJ8ACP1pyZaOrVdKEKGUvGGjuKacC7246a4kPJtqQX/WEXfP4HzMMuibbZXDh3xeE9+wGPNR/C5AEABaavjOyv3oofqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174011; c=relaxed/simple;
	bh=72jCYSUtvw2rfqBc+H+W6IruE2/oajXh7+A56VLPZn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZp2jfT37SK9bihSOELL866nxNJEURZxNQ0ZqF1OpsSyfjdB2AaoKdtXSs4CEdVLLWLKu9mNk5T2V+gHVHSUSr7P3yUjScx6skJ26SOnC6kfW/M9QKT4NejH6gV5vTepcz2Uo8q2BMxm9n/IGEgLTQD/gQb60usNK4nw+feUt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZGjlAsZX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BoEiO1166465
	for <netdev@vger.kernel.org>; Thu, 7 May 2026 10:13:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=SzrUE3l
	DsznqJxZ7gWqn468VAqdAMeTCbC2XUIqwsDY=; b=ZGjlAsZX8Ks7cLV8qd2JPZ/
	vdJPYw686e6g5HniLF/vt2UjtS+7YAf7k82N3rLiz3KtxcpnEcKRsZEeU4wSKWgP
	JE1aqOPGQ0uYQlKQs/pfNgbCtX33YOmYobgGglMQ/crHh2PJ3gdSY3x5oZB3tuZf
	z/eOebeV+6nJF9jVrwvPjLNpOT5youami0PF4gY2SwpZmugQZ4kyBkhxAk7Qy8io
	G8S/03/0QFFhD+mnOdfbblWlr4BxyoJNeWWQAypk9gXt8Z/wFga4t2PkLgBHjJG/
	tzWcJ94xs/omyYJkKyg4ZIHM1B0UeKLX3DnuLqC4D0aqY6fki7xwJYwgtrbcKfg=
	=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e0t6dt808-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:13:24 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dccbd50e3fso2343328a34.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 10:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174003; x=1778778803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SzrUE3lDsznqJxZ7gWqn468VAqdAMeTCbC2XUIqwsDY=;
        b=pky+dD9lDvUAqEZUa+M5mLWOA6e1yrwmqn8L+PQBZdI+1ejnVSRgSPdAt4MSBp7IQI
         OLxVTEd8koVyxN9fiET4vt30boDaCOCvS6dPcVe9rbFWDD5mbWEAriuQz1YV/+Zn0thm
         Rt0uIySrxMV/XdJcAppKrCxWeLINCvsKWtcYMF6mDqKkbjaJs19jEL+5A6NCXEE4exW+
         hHP66bdoFsL6ORch7n9M4jp/p9fxYd3tJcRFHkzVN4MSjpREMxNyXmy9hkMwh6WbTFim
         Hcm1G1GhO0wrciXX53HtgYOYgdgAUwquEQJWUZ49vJBDKDPeTY14oW9JpSVxxAiWWXFq
         13rg==
X-Gm-Message-State: AOJu0YwSwfmSBNC4c/9a8yMyGEvjXQpsuyQM3upF6Ammc3oWuT2gtOmB
	llpAsn4eekqAQTMbd7JaR/dAlbkwJCnD1/886dEyVQwgSLAl4aKQMyMmobMVWD/59O0Ehqeph6h
	4zwybiFU95zQ0sWYa9Yw8rJ39ryrv6v/o9MjGtOlXtZhy8BndkBarshm6CGsvLt+uKwgOJUZNEl
	ARWPJ/ZvYGyYUDcVeD3Xa7QRnELfMKM8Vdh0+x
X-Gm-Gg: AeBDievV7+dJDCGIxB+T3ijamhfaxbLp1mi5vKaLHMzKbCBWD959po7HeSfWLy22/wq
	n9X3QOa4MWBCsbL6H2nF1+gKSNbelxo2OVqKncdfKdsuAAlRzpTrWsDI6qvfOIjJGJ5XiMmCO/p
	kUrC8isiaD9m7rNQuY8Tf8l7Vhjh+kPrc5rsXg5nkMv8Nxr7aKnsuKRUZROAEeVJRUriB/1uRTH
	KyAbQ5B5jvgjGBkvH2Wcvj49xQK8qYwhqyzUexgRokSzlH6Sc6Ebmzfp3P/IUCcRrH6ogdwJgap
	qNhut9dOZxo4MTtHsA9mclBezGA7YsMz6FDAOOCesdTb7zCnYtylY/jpQaWphgLTZIiXFPpCcXn
	20XbnlMRP9g==
X-Received: by 2002:a05:6830:3c83:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7e1def6a571mr5393698a34.9.1778174002810;
        Thu, 07 May 2026 10:13:22 -0700 (PDT)
X-Received: by 2002:a05:6830:3c83:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7e1def6a571mr5393665a34.9.1778174002175;
        Thu, 07 May 2026 10:13:22 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e3024792d5sm107813a34.12.2026.05.07.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:13:21 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v4 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Thu,  7 May 2026 10:13:18 -0700
Message-ID: <20260507171319.1259115-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507171319.1259115-1-ntspring@meta.com>
References: <20260507171319.1259115-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX6YGPmsgEiVMw
 vSewY6DatiMzi+05yVpWZ9IoPOMRAzugaHsbHXpT0KiT1AvBDKKePt9fQ0I/+gxKnSzGH4y2HmU
 Nky/39Dc6gNI7uRWSJdQLWIVUTj/4z/skI/uqqCcGZTmnN+u4PvNGda4frGa5W508+YpZGR70BM
 x+adRm13CEh7bqbdvnCRzHSveELK/MQSbR2UrnbkVC0cMIQWxpnLj2JpbZxnZUeX8OV7b7t27Ym
 ky1IuNL/V2UTE4YWBKizMPB3I3zKYnUzQmkd+64dZnmdYRNE28DoQh/IovfwXHoiDxTi5FaL471
 +bnynexN1WSrgoSeA2qu2OYh7azaK+Wz69cYeOmo4yGDCUtlAAY3Z/+JumRMumFF059XnuIIiSx
 /dj3dkZSEJzLLdwT8Scn0uwNFlGVGXazz7CrXrgnseIhwipUUJpMfQVNc3pLIhE30yuwz8kct7r
 HI3beSMpNuFv7OMvxHg==
X-Proofpoint-ORIG-GUID: Xj-sM29XwQRFyl7q_gxe_BC0BijyKnyv
X-Proofpoint-GUID: Xj-sM29XwQRFyl7q_gxe_BC0BijyKnyv
X-Authority-Analysis: v=2.4 cv=F7dnsKhN c=1 sm=1 tr=0 ts=69fcc834 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=PrRIV2uz1Vmq3iRVJPsA:9
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: 5607D4ECBD4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email,meta.com:mid,meta.com:dkim];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
and spurious-retransmission events, but the cached route is reused and
the new hash is not propagated into the ECMP path selection logic.  Two
changes are needed to make rehash select a different local ECMP path:

1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
   tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
   tcp_plb_check_rehash() so the cached dst is invalidated and the
   next transmit triggers a fresh route lookup.

2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
   SYN/ACK retransmits) in inet6_sk_rebuild_header(),
   inet6_csk_route_req(), and inet6_csk_route_socket() so
   fib6_select_path() picks a path based on the new hash.

   It is necessary to update mp_hash explicitly because the
   default ECMP hash derives from fl6->flowlabel via
   np->flow_label, which is not updated from sk_txhash
   (REPFLOW is off by default).  ip6_make_flowlabel() cannot
   help either, as it runs after the route lookup.

The dst reset is guarded by sk->sk_family == AF_INET6 since IPv4
ECMP does not currently use sk_txhash for path selection.

tcp_rsk(req)->txhash initialization is moved before route_req() in
tcp_conn_request() so that inet6_csk_route_req() reads a valid hash
on the initial SYN/ACK.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/ipv4/tcp_input.c             | 6 ++++--
 net/ipv4/tcp_plb.c               | 7 ++++++-
 net/ipv4/tcp_timer.c             | 4 ++++
 net/ipv6/af_inet6.c              | 3 +++
 net/ipv6/inet6_connection_sock.c | 6 ++++++
 5 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..8f602a665b71 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
 	    skb->protocol == htons(ETH_P_IPV6) &&
 	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
 	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
-	    sk_rethink_txhash(sk))
+	    sk_rethink_txhash(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+		__sk_dst_reset(sk);
+	}
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
@@ -7636,6 +7638,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->af_specific = af_ops;
 	tcp_rsk(req)->ts_off = 0;
 	tcp_rsk(req)->req_usec_ts = false;
+	tcp_rsk(req)->txhash = net_tx_rndhash();
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
 #endif
@@ -7717,7 +7720,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..accdd83dfc3d 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,12 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	if (sk_rethink_txhash(sk)) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
+	}
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..24c1c19eda6e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,10 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+#endif
 	}
 
 	return 0;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..90ff4448aa56 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	/* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
+	fl6->mp_hash = sk->sk_txhash >> 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..fc4b75de6af8 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,9 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	/* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
+	fl6->mp_hash = tcp_rsk(req)->txhash >> 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +73,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	/* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
+	fl6->mp_hash = sk->sk_txhash >> 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
-- 
2.53.0-Meta


