Return-Path: <netdev+bounces-293163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPl5BqC+GWq0yggAu9opvQ
	(envelope-from <netdev+bounces-293163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:28:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A4605959
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680B834FCA19
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDAD3F6C22;
	Fri, 29 May 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MW1fEru0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139B3A1C9
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070511; cv=none; b=CXt4kbQJ7Sv9nCRSTicJ6+4o7yFmz+oNLkdYOkP5cBxTAuHqNFuRaivuKTzyTxWtxlmhdusqIBwI0DCbZeVReTmlAK0IXUmccFWG0VElSrltsN5SYau966V++XcYxmW8SOyXgNGPE1G8cyJga3cqSQeEQS21xvUXGUSD3HanlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070511; c=relaxed/simple;
	bh=tXumORyJJFC6PhP74ao1I5Pfmf1ztjo0vpe862okRSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVk8+JVhFmfOFgkrlXxbsGcVxgV0j0uBwnbRt2uFVa6FqEde6q5ahnQzfzuXw6iyfEArsaA6P/6OY7f0aa//K70wCv2RXMeH5cnDpnqQbeZbQYynrSQr1y2WhVL3nZG8G2/IQA14M8h7YB2Ov77SU3+gHZgprTrUjBcI/S3DpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MW1fEru0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SNILwu1872484
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:01:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=9gwcYq1
	2Rfx0CdaBOzTEh/d/clI1xLE6aTtEzKsSrzA=; b=MW1fEru0imsKVsUH6cw7TlD
	/DOHkY94blDKtEK8W55wplqtIXV79UiPsiTUe7dkyBKntfzRIwUnuqEj+cjVQX8G
	eCuIKNj6L3rXq0tAb4zmFjyWw5jLmhvtTO8oha+YjfEcIMCJicZ/TVrLlm7WIUex
	Fl/KFejbibrwBJupXqo+lYu1ncRRUxsRRVb4WWTqQuAM2IBmrDk8+q1SvqcLgmH0
	e6kkGGr8w35QeD3AiJwh5ApH3NmvWRBhAi7snZL7ApyAnhxocllpZGTYw3ESyCkt
	zUNdQNowrUgJejY/Sm2XajUt9rjzRmjF2s8+u+AXYpNkNpJQFskQf5CwH1CpVTw=
	=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6w27h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:01:48 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48576b309c7so9255871b6e.3
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780070508; x=1780675308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gwcYq12Rfx0CdaBOzTEh/d/clI1xLE6aTtEzKsSrzA=;
        b=elLSRuf4kmgVdSdGMMJ/xwOKoXbWlB9ebPhqe4ecKmLJbo0G+9Et76r4ftLAOAqRs8
         cBQsCaI1B20JX0HqlDWMY9CaMl0L5PR9YORMzwdB4OUz3Vq0B6iVdMjWOEwn5CCcR98C
         MJ/BZvI9wKbJRHLD2tdGDOxZctRtIU1zJ0E0YMkjPpJuD7n5IdSn+KerXhU3Q7dOXT6Z
         TKFbb9kARcJXMja8fAxWIkMoUWK44oEPFX4Nxzqm++NnnBf1SfEkaObZL5qWJuzSp6Ks
         dUa9FiasxD5HWKrGJupr5RoWkPDJ55zkK6Qn+OsujoejTf7/NLX8KpdMZZgMNVjZCZjU
         lp4g==
X-Gm-Message-State: AOJu0YxAPpQrPBkwNUaurs2j/bekLUIRjylDBnReA4dSSzevi7/OQJzd
	xbFSw4nana0e9KS3gF1wZ9FkhjU3YLp58E2Pcxh9iCLEzxLPyZtwHYEzDtM9kY4RjIKlNpV9snh
	kt7X1zt84/9k5YKuJzXp0ZkGqPbLDhm2BZj1nWnkInhDAyML/XwXE/Wn9/d3knbArBIbVU7FMFI
	PRje2y6A+AoRAE93cj9OjYWeCJyVuOgBfWlWA3
X-Gm-Gg: Acq92OGuoQ0SFUKRSqXMbXir96bJLXkYzujBK4M5X43TyHC/1aT2w3IcZJYIYyrw1nV
	Gg4IuU3TiJGtoQCHsdpefD3PyAZq8ugEmBQubtxlg73/CXmkn3tUGPaRvoCecl5x5CBQZvKdxZY
	eGr4ui/RWfxpmIRGVjOaMQ/Tg0z+OdvHgAiqu6N6To2s34b0rUfo1o7Mv9cw7zwxOVHVbVGy360
	II1LnGp6fAQro5skAMbpHfad72dfe+WNWfMAz4atpYkvqPiS2Z/O5aO2zmdjkqnxvrDGYHnb7wH
	AtLWsLefgHJvocUedMsj7zPph3TL9wTec9lc8tf+CwUWymIgqe0SZagxKkKFaYgWbCyjrO52May
	pkhzTMWWerAjZdG20v0Tt
X-Received: by 2002:a05:6808:118a:b0:479:ead7:2a5b with SMTP id 5614622812f47-485fb63edf6mr12691b6e.16.1780070503923;
        Fri, 29 May 2026 09:01:43 -0700 (PDT)
X-Received: by 2002:a05:6808:118a:b0:479:ead7:2a5b with SMTP id 5614622812f47-485fb63edf6mr12081b6e.16.1780070500009;
        Fri, 29 May 2026 09:01:40 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485edbc33a1sm870523b6e.4.2026.05.29.09.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:01:39 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v10 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Fri, 29 May 2026 09:01:35 -0700
Message-ID: <20260529160136.1010064-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529160136.1010064-1-ntspring@meta.com>
References: <20260529160136.1010064-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE2MCBTYWx0ZWRfX8elspEauLg73
 F9w/R8ycQOhvmofD7Y5qx2X+hp+kNtEUkFEODZIgnCX725erOm2QC5y0g+5oq9uqPs3RDWf7Ywk
 e0clyO0d3oQzHsZyJ/blkQTSB83XEifue9nQAQsPeGfUY6sayyKmadaljOEIktA91jWMzZ6gld0
 5W8PAsD3wKWiCOh/HyG7xgLB0sF7MSQUKd/eT4qXo+pqha7ekmpOCqpUg5SjDdVshvCUwv6d2TG
 4/1wiv0flzcKCmcivozTYq4K5B2bqM6C1UgcFDcQLzEagJUWgMy5kSUVQmKtTq90cjHHhLicXEu
 NKS+jXF/foyYkJL/DkORlvJZyzNeQPCAtEDFxoSp5HwYm2bdIfLXpxzAI6G5cF9vGLF4uxcYH09
 CsBiUDm+mZa5ynu8zKVJL8tlKMCdcTEjRUPvAVpMHx/h9j69V4i63gKq4zkdAJljAGagxhVuTpE
 uOFLgxW9owb9RUNbiQQ==
X-Authority-Analysis: v=2.4 cv=BoCtB4X5 c=1 sm=1 tr=0 ts=6a19b86c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=-h2tWy7gSZMk7rz1gC4A:9
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: XbFMZ1wFIg4XWjDJeGXboI7vhNyscefo
X-Proofpoint-ORIG-GUID: XbFMZ1wFIg4XWjDJeGXboI7vhNyscefo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293163-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 829A4605959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

The mp_hash assignment in inet6_csk_route_socket() is guarded by
sk_protocol == IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
inet6_csk_xmit) fall through to rt6_multipath_hash() and retain
their existing flow-key-based ECMP behavior.  It is conditioned on
fib_multipath_hash_policy == 0 (L3) because policies 1-3 compute a
deterministic hash from the flow keys which must not be overridden.
The expression uses (txhash >> 1) ?: 1 so that the rare txhash == 1
still produces a valid non-zero mp_hash.

Setting mp_hash explicitly is necessary because the default ECMP hash
derives from fl6->flowlabel via np->flow_label, which is not updated
from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
cannot help either, as it runs after the route lookup.

sk_set_txhash() is moved before ip6_dst_lookup_flow() in
tcp_v6_connect() so the initial ECMP path is selected by the same
txhash that subsequent route rebuilds will use.  This avoids
unintended path changes when the cached dst is naturally invalidated
(e.g., by PMTU discovery or route changes).

The dst reset in tcp_write_timeout() and tcp_plb_check_rehash() is
guarded by sk->sk_family == AF_INET6 since IPv4 ECMP does not
currently use sk_txhash for path selection.  For IPv4-mapped IPv6
sockets this produces a redundant dst reset on a cold path
(RTO/PLB); the subsequent IPv4 route lookup returns the same result.

For syncookies, cookie_init_sequence() computes the cookie value
before route_req() and sets txhash so the SYN-ACK selects the same
ECMP path that cookie_v6_check() will use when the full socket is
created.  cookie_tcp_reqsk_init() likewise derives txhash from the
cookie rather than calling net_tx_rndhash(), since the original
request socket (and its txhash) was freed after the SYN-ACK.  The
cookie is SipHash output, so for IPv4 (where cookie_tcp_reqsk_init
is also used) the derived txhash has equivalent distribution to a
random one and queue selection is unaffected.

cookie_init_sequence() is split from the former version that also
called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
side effects are now in cookie_record_sent(), called after
route_req() succeeds so they are not triggered when no SYN-ACK is
sent.  route_req() receives 0 as tw_isn for the syncookie path so
that tcp_v6_init_req() still saves ireq->pktopts for REPFLOW
flowlabel reflection and IPv6 cmsg options.  The ecn_ok clear for
syncookies without timestamps stays after tcp_ecn_create_request()
so it takes precedence.

bpf_sk_assign_tcp_reqsk() is updated to initialize txhash via
net_tx_rndhash() to avoid reading uninitialized slab memory.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 include/net/tcp.h                | 14 ++++++++------
 net/core/filter.c                |  1 +
 net/ipv4/syncookies.c            |  8 +++++++-
 net/ipv4/tcp_input.c             | 15 +++++++++++----
 net/ipv4/tcp_plb.c               |  5 ++++-
 net/ipv4/tcp_timer.c             |  2 ++
 net/ipv6/af_inet6.c              |  3 +++
 net/ipv6/inet6_connection_sock.c |  8 ++++++++
 net/ipv6/syncookies.c            |  4 ++++
 net/ipv6/tcp_ipv6.c              | 13 +++++++++++--
 10 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c4e6adb0dbd..eff72c37de10 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2540,22 +2540,24 @@ extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
 
 #ifdef CONFIG_SYN_COOKIES
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
-					 const struct sock *sk, struct sk_buff *skb,
-					 __u16 *mss)
+					 struct sk_buff *skb, __u16 *mss)
 {
-	tcp_synq_overflow(sk);
-	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
 	return ops->cookie_init_seq(skb, mss);
 }
 #else
 static inline __u32 cookie_init_sequence(const struct tcp_request_sock_ops *ops,
-					 const struct sock *sk, struct sk_buff *skb,
-					 __u16 *mss)
+					 struct sk_buff *skb, __u16 *mss)
 {
 	return 0;
 }
 #endif
 
+static inline void cookie_record_sent(const struct sock *sk)
+{
+	tcp_synq_overflow(sk);
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
+}
+
 struct tcp_key {
 	union {
 		struct {
diff --git a/net/core/filter.c b/net/core/filter.c
index 80a3b702a2d4..7fea9ad881e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12301,6 +12301,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 
 	treq->req_usec_ts = !!attrs->usec_ts_ok;
 	treq->ts_off = tsoff;
+	treq->txhash = net_tx_rndhash();
 
 	skb_orphan(skb);
 	skb->sk = req_to_sk(req);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index df479277fb80..8591f2606ca6 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,9 +280,15 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
-	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	/* Use the cookie as txhash so the ECMP path matches the
+	 * SYN-ACK, where txhash was also set to the cookie.  A
+	 * random txhash would be inconsistent because the original
+	 * request socket (and its txhash) was freed after sending
+	 * the SYN-ACK.
+	 */
+	treq->txhash = treq->snt_isn;
 	treq->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 
 #if IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..0936279fd1cf 100644
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
@@ -7659,7 +7662,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	dst = af_ops->route_req(sk, skb, &fl, req, isn);
+	if (want_cookie) {
+		isn = cookie_init_sequence(af_ops, skb, &req->mss);
+		tcp_rsk(req)->txhash = isn;
+	}
+
+	dst = af_ops->route_req(sk, skb, &fl, req, want_cookie ? 0 : isn);
 	if (!dst)
 		goto drop_and_free;
 
@@ -7699,7 +7707,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_ecn_create_request(req, skb, sk, dst);
 
 	if (want_cookie) {
-		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		cookie_record_sent(sk);
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok = 0;
 	}
@@ -7717,7 +7725,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
-	tcp_rsk(req)->txhash = net_tx_rndhash();
 	tcp_rsk(req)->syn_tos = TCP_SKB_CB(skb)->ip_dsfield;
 	tcp_openreq_init_rwin(req, sk, dst);
 	sk_rx_queue_set(req_to_sk(req), skb);
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..849ac4aad480 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -78,7 +78,10 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 	if (plb->pause_until)
 		return;
 
-	sk_rethink_txhash(sk);
+	if (sk_rethink_txhash(sk)) {
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
+	}
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..7c05f1072a06 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,8 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+		if (sk->sk_family == AF_INET6)
+			__sk_dst_reset(sk);
 	}
 
 	return 0;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0a88b376141d..7a2b1de7487c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -823,6 +823,9 @@ int inet6_sk_rebuild_header(struct sock *sk)
 	fl6->flowi6_uid = sk_uid(sk);
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
+
 	rcu_read_lock();
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..7ca24eef614c 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,10 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (ip6_multipath_hash_policy(sock_net(sk)) == 0 &&
+	    tcp_rsk(req)->txhash)
+		fl6->mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +74,10 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (sk->sk_protocol == IPPROTO_TCP &&
+	    ip6_multipath_hash_policy(sock_net(sk)) == 0 && sk->sk_txhash)
+		fl6->mp_hash = (sk->sk_txhash >> 1) ?: 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 4f6f0d751d6c..70759cd64b34 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -245,6 +245,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		fl6.flowi6_uid = sk_uid(sk);
 		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
 
+		if (ip6_multipath_hash_policy(net) == 0 &&
+		    tcp_rsk(req)->txhash)
+			fl6.mp_hash = (tcp_rsk(req)->txhash >> 1) ?: 1;
+
 		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
 		if (IS_ERR(dst)) {
 			SKB_DR_SET(reason, IP_OUTNOROUTES);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709..ecdc8f84d203 100644
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
+	if (ip6_multipath_hash_policy(net) == 0 && sk->sk_txhash)
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


