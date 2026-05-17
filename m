Return-Path: <netdev+bounces-288761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAUWKcH+CWqqvwQAu9opvQ
	(envelope-from <netdev+bounces-288761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581F562BE5
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D5330073CA
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDB3CB2DA;
	Sun, 17 May 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZfwBO75C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95EA3CAE94
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039933; cv=none; b=ITpTQ6tcs11A6mLOD4Lza/YyiSEKWDxXSbekysSEx+ozNAro4AAM+rM0Um/A3j+RW0ugAUMUEbZueqV/QJb4HYE7EpT/rqw9vs0gq9W8LMw9GQR54LRQVGdDgqfwUrGZ/W5vui1vM7Qchcf1qC70JodMAPBHF0IXV8TnOnN8ry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039933; c=relaxed/simple;
	bh=fXxy1Sy/5F41T5Sx3jo+gB/W5t3QoT6r6jP8/14BiI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nte2bWrlaLXIhn+vxrBf4rUIgpXvPIUro3tNpechFEYgoDCsHBcv02fzrEeuF3o2VLvt8BpUxPzzjyWrVoKlXDBERmXeNqKHXV4E6tXpjzNEQAu2zMdWIRcg56UYVzNtVNq5hFDK2tCDcomqB6Pf4J1DjBLuLa2UgPtyCBgpdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZfwBO75C; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HGdVIh913860
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=hHwjqC/
	gnuHNLCaMsw451iPYwce4YfSboUtjcc/Yjko=; b=ZfwBO75C+zhqzFAG9OswnxD
	32UoSz4Of6l8bsdDorJBmXPaTQRvJDcpbNrx7LTCbgnIxlPJtaysBElUz/r8pdWc
	2DCLNMTp2OGC1lVDk1CEMq6NjcdikeULNW2OFzgoUzq6OEl1bP6H9lg3tdWkyIme
	CmP+gDLRbr79DqzrAKBwE6CSg/6ILo9qKm6L2HgbDsMl39WznsPAfNKupAECYQ+j
	K3nVSJ7CCuJT4nYf7zDV2V9SJR4CCjpjOB6l+qq6+7RxRaRFf54MfCn6sndBTLEu
	fefm29ofxxZfs/QWC9F1hwI5niqUcOdcHevIt2O6MLlhBmkQfeMBo+3eUHrJwgg=
	=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e7a7dsadw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:29 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6967fe3eeb1so1408506eaf.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 10:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039929; x=1779644729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHwjqC/gnuHNLCaMsw451iPYwce4YfSboUtjcc/Yjko=;
        b=QNQ+G/S8xNBgrJBUPn0653YfBE1fXwWpx5h9svsETpl4aciLbLJ5V/onCPOyi/Sp8p
         x2opxsmjXzvgY5a6Y7hxpCvTqoGXVY4Hjcd4s1DWenwCGPdRoFAnuXeMXeR9OsgUSYJ8
         WbDq+Mc1Q9hY1lCNNzdVBLprf3TuXaFmJocuRYKOoV5F6U+biYawZ7WD4fxUiyaRxUcN
         gnGohfq/MNErK5eI4XTIpkASa1qq+CtWIMLPO5fpO8IuIDqyeF4qLPJNbbukXV/XjRGL
         4yM94gBUOUooQa8tVYwvvCiNOmT4iFvtabooFHbUZGTJTi0DBNNMx7E0D+k3wHRorEaG
         VQMg==
X-Gm-Message-State: AOJu0YyhQ45necoxnQAiKsi0A9qgYfve/QpQTW0ENHFFELDQIqP7wW+r
	0HizvR8NeLI5bQi5xc9jJNcXaW5Cr/7YdQOvhvYsVFHp2wbLpdwzcm6Haf8B14qwAOmfjStJqqY
	637ZXkh3aRFBzlKrGcG3yaOxqtPoQR5febo4oNH9a8sjCWr55H/jqzuCPmmOEAPj9G8/oxz/EPy
	ED8yWvahWGtc6+1jQebtDwScPajemIUF5YlUeO
X-Gm-Gg: Acq92OFB+WckeR5oWpW80LJgdlxDsE1e3oONE1GhzJZ838cjVitQRyUTdHrINbzZTF5
	NELSPZgrOTXnb6taJxzQJgSVP82TYmmfvKB+gF4URyY+sDoTha3WC626PeGPqLh6oy5aFWqKuor
	0Wh3TIhawapMB3dqsTJoYavqMFgPACkfU9Zc5ugPqTzzJr8X4W299UyVEpi92Q+j4MwXwYVImra
	u3ZLhG9T+4GjNzqxrVimINbUlGLWaXhYDyqsnKnHnOQlyhbzJ/1vVX362GrSTOgouTle7lqmfzY
	DNKifPh3NoEpL+9XDgMEHmiRIBBOWHEaA5Urm9qeYX3SR5vcl6J75+kTe1I3y/PB9dhO6Szu9qC
	WYT7s2O/o7lkluLc5Bj77
X-Received: by 2002:a05:6820:3103:b0:69b:5486:e85 with SMTP id 006d021491bc7-69c9bfd479emr7536383eaf.36.1779039928500;
        Sun, 17 May 2026 10:45:28 -0700 (PDT)
X-Received: by 2002:a05:6820:3103:b0:69b:5486:e85 with SMTP id 006d021491bc7-69c9bfd479emr7536354eaf.36.1779039927852;
        Sun, 17 May 2026 10:45:27 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d045e6646sm4436558eaf.1.2026.05.17.10.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:45:27 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com
Subject: [PATCH net-next v6 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Sun, 17 May 2026 10:45:21 -0700
Message-ID: <20260517174522.2232057-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260517174522.2232057-1-ntspring@meta.com>
References: <20260517174522.2232057-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6GIU9IiE6mlU0IdCXgLEn3qNqNCR86xE
X-Proofpoint-GUID: 6GIU9IiE6mlU0IdCXgLEn3qNqNCR86xE
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a09feb9 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=LSjaGeFOPYFcjronpEcA:9
 a=WZGXeFmKUf7gPmL3hEjn:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MSBTYWx0ZWRfX6IGm0xYU0Bv7
 eb3Gxs3MxBAlXrioXYEwvFXTb8Dcn900pGZDPhG0yu3CGmvEjgi1+V3zlTvWwqPHC7CP9a5nhRs
 jJz1/yunsKeFJ8fN+PU8qj8T9yTDZY9dXHhiKxa2UxdhQnZBgp5o0vmKDyDvHpohMLLEbVoqUwY
 VOakQRSNqP+7ZxRkWzwAspuzDe0NjugeNh/z+BkcqZKJu1LhsNLXu/vw1kURM0xDsF9tHR7qt2g
 C/kuN09Mmj8H152i9S5TBwG+vDZDRInhqb4ob/xHE9cRROTOhGGgNCy6v5xlK9SVuAUX3WZg/Q3
 P4bPZKNmHJms6bYI8ljnXC8YDdRpQ7rIERJXCtrmNJoyXuEXYrRwT+0/7YjNsYceP/UUDIRh3/A
 EAHyz5wXuXoiAqwxI6neSHSVY+8Riu/QWM1lqPa5eUZ6M6yu0L7fDWWxminV/MFLF2dew/nhRRW
 KHFTAbAAuKqIX8dNk7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Rspamd-Queue-Id: 1581F562BE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288761-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
   SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
   inet6_sk_rebuild_header(), inet6_csk_route_req(),
   inet6_csk_route_socket(), and cookie_v6_check() so
   fib6_select_path() picks a path based on the new hash.

   The expression uses (txhash >> 1) ?: 1 to guarantee a non-zero
   mp_hash, since fib6_select_path() treats zero as unset and
   falls back to rt6_multipath_hash().

   This is conditioned on fib_multipath_hash_policy == 0 (L3)
   because policies 1-3 compute a deterministic hash from the
   flow keys (e.g., symmetric 5-tuple for policy 1) which must
   not be overridden by a random txhash.

   It is necessary to update mp_hash explicitly because the
   default ECMP hash derives from fl6->flowlabel via
   np->flow_label, which is not updated from sk_txhash
   (REPFLOW is off by default).  ip6_make_flowlabel() cannot
   help either, as it runs after the route lookup.

sk_set_txhash() is moved before ip6_dst_lookup_flow() in
tcp_v6_connect() so the initial ECMP path is selected by the same
txhash that subsequent route rebuilds will use.  This avoids
unintended path changes when the cached dst is naturally
invalidated (e.g., by PMTU discovery or route changes).

The dst reset is guarded by sk->sk_family == AF_INET6 since IPv4
ECMP does not currently use sk_txhash for path selection.  For
IPv4-mapped IPv6 sockets this produces a redundant dst reset on a
cold path (RTO/PLB); the subsequent IPv4 route lookup returns the
same result.

tcp_rsk(req)->txhash initialization is moved before route_req() in
tcp_conn_request() so that inet6_csk_route_req() reads a valid hash
on the initial SYN/ACK.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/ipv4/tcp_input.c             |  6 ++++--
 net/ipv4/tcp_plb.c               |  7 ++++++-
 net/ipv4/tcp_timer.c             |  4 ++++
 net/ipv6/af_inet6.c              |  3 +++
 net/ipv6/inet6_connection_sock.c |  6 ++++++
 net/ipv6/syncookies.c            |  3 +++
 net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
 7 files changed, 37 insertions(+), 5 deletions(-)

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
index 0a88b376141d..8e8f94b1f2a4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..4e10299ba0bd 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,9 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +73,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..f43f10bd2822 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,9 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		if (ip6_multipath_hash_policy(net) == 0)
+			fl6.mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..231eed3d4f7b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -258,6 +258,8 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
 		saddr = &sk->sk_v6_rcv_saddr;
 
+	sk_set_txhash(sk);
+
 	fl6->flowi6_proto = IPPROTO_TCP;
 	fl6->daddr = sk->sk_v6_daddr;
 	fl6->saddr = saddr ? *saddr : np->saddr;
@@ -275,6 +277,15 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	/* Non-zero mp_hash bypasses rt6_multipath_hash() in
+	 * fib6_select_path(), letting txhash control ECMP path
+	 * selection so that sk_rethink_txhash() rehashes onto a
+	 * different path.  Policies 1-3 derive a deterministic
+	 * hash from the flow keys and must not be overridden.
+	 */
+	if (ip6_multipath_hash_policy(net) == 0)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
@@ -313,8 +324,6 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err)
 		goto late_failure;
 
-	sk_set_txhash(sk);
-
 	if (likely(!tp->repair)) {
 		union tcp_seq_and_ts_off st;
 
-- 
2.53.0-Meta


