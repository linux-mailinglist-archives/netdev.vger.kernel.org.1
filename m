Return-Path: <netdev+bounces-294329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3FtKaMdH2p2ggAAu9opvQ
	(envelope-from <netdev+bounces-294329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D5630FA9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=ruDMABKZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294329-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294329-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E91A3029717
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46937B003;
	Tue,  2 Jun 2026 18:14:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B337C92C
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:14:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424082; cv=none; b=bw2qpp96XUGjyD5OQaEHkD4OmCpDZHR/8TsC97BzDA4DJoLLHQS1iXWTqG0BIIURD6LFiWWlOCKJTGHyM61t3KkNEZuiXPQesM+6uTLkkpmzVVVx3Ut8fGBwePDzDvXmcEyG5g2TLVsh1S+rqjzi+CluWQfGy/5Lit2gOtXpTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424082; c=relaxed/simple;
	bh=zQ/ZrJMNTZ2Bz2WOj07alh6OpCDTEYOgtMshWNBCYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW8d8Xj+IUcyHnt2dwsM+/iWjR14Hy5dpgWMK9DYOnZijfQSXRfX21UPhxaI8ADIIKGPTQiomGAW0Nv5nnRzkIwLt+8JdY07TcPN4pWLM/AbwhS94AK+lSguxOJw75cYOr9v/IFo7vTb6HheO/eOs/4YgGwjgjX+CcvUheNMvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ruDMABKZ; arc=none smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EOe1N1177919
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 11:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=XV5fG+g
	/7eBdcUXSXxll+NWCXbW+1UC6QuPyL8X8Jgs=; b=ruDMABKZShpmLlyYwFiyIAu
	sUf5vS8OX/+ZGQo4PJESObYLPHz8feSGL/6/Kj3pzpoE5c/lp89F7ie/2j+9MW4S
	SAM7EVUhQJouTdrQrgLC9EHVT9YalqxFdHhQPzv3DqQzHUCqZNi2dZptBFd/QTPf
	zeaTU1UDDsKDNwMe/En1f9e40fEfd9gMQ2pyNtR6Qan5mbh83dkKgu4MlNNmVd2+
	l6nrTASzQizvgZzS8yB39keOncAr2oYRR4xQlvIf3fsQf65/uQMhEPaT4iyaPWei
	eSwUhAHnaKG5ccBLLTZNpOVtFDlifAnbHWdB2ooGn3BFWIXxhZYLlcsAs4DiI9Q=
	=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ej0wshnxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:14:33 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6b59080ecso6118023a34.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424072; x=1781028872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XV5fG+g/7eBdcUXSXxll+NWCXbW+1UC6QuPyL8X8Jgs=;
        b=sr9202p0RBVxH6KHmktRnFczAyZT360Jm3CBxJfp4TthXFIyG1FiVWXRtXp6M2fOoz
         9Lgoefc2EXDUcESmoVtQqfaCV8bj0iz2AhzEcRoNOre4i99BfQiyTvb2GeKXlppF+Rk1
         SW7POW9tD+YaxTeGe8MvC9pU7d/gz4NHz1j0Qs3A9iAwbAf5oTmAWhGA0KEy5lVvpnvK
         S7Jra6AOjWWDoikBFVh2TYiV4vsGDluu0eh9dhmDpIHFdblIJweP1fzVV+3bA6cBFF/G
         PVylDgV1i8gKI2m7dpuOK0hqAuvXSIjAK51wxu4MnXrCoIU2ikrdIkd1mDf9gu8CSJ8Z
         jWnQ==
X-Gm-Message-State: AOJu0YzRUXO3Y5gEMWGeInKgrJ7m5HdW8T0VYNQynPMCi6RkllOhe+qz
	kqd9GAONXFgeDowCfk8+FjxD5E5A/NU4KEbIru3jDq/rBjwIvVPigoZbRSIbsSpiE0xFcb56xKY
	zV5PxY5VU0seyyNWwS6r3RMZ/gl7NdBhUrA+ffFcHAHUqnxIsbJcww2oPZeX7vArzJ0nRFszzBU
	gSiSl3yozZ5rgRPrT2pdbvdDvlO8BZ2uW9NSvl
X-Gm-Gg: Acq92OFqwroxtc+41GOjD40nLSNDds/ZjIfAYHtR5+eLgOhLT/juH6ZrTyUNUkbIFt+
	J2CjHwD5jJIjOoeN+p7paZFH6fj5iZPRJXN0YYPVk6UjpY/crpAOomG5v58uJHuuiRLlv8IOSjP
	Iz1ZCv43SHE1UjDtw0fbI/Y/v2ZYxEfr3esqlAHjhdrKlzZ5j5NnB4CNLTDuqE5TcoFenaDd/5a
	XEuKuKp6XrXuBOmJrJMhn8808nS2c6zh9e1r3T+FPJDKIYfaaEt3Mj3zOQyi72rqzvUenwttoSm
	Q4Eau1MgxA9+joVtPCHkbawxsQv7LVZ84Dz71yuJzqOEN4K4S/SGgwdnjlg1VG+jy3iAz6Tv0gp
	e0fVtcR/BdGiUC9VskYKP
X-Received: by 2002:a05:6830:6289:b0:7df:616:77fc with SMTP id 46e09a7af769-7e6e6407a42mr360008a34.6.1780424072094;
        Tue, 02 Jun 2026 11:14:32 -0700 (PDT)
X-Received: by 2002:a05:6830:6289:b0:7df:616:77fc with SMTP id 46e09a7af769-7e6e6407a42mr359964a34.6.1780424071483;
        Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14acsm57624a34.14.2026.06.02.11.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:14:31 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH v11 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue,  2 Jun 2026 11:14:27 -0700
Message-ID: <20260602181428.2318919-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260602181428.2318919-1-ntspring@meta.com>
References: <20260602181428.2318919-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJfAb79m c=1 sm=1 tr=0 ts=6a1f1d89 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=ZM5h17c31KwNFtHZtJAA:9
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: O7jFh9BNiehsdf7NQ0l3wkJSVa5XxZ2M
X-Proofpoint-ORIG-GUID: O7jFh9BNiehsdf7NQ0l3wkJSVa5XxZ2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3NiBTYWx0ZWRfX+voU96yXlNiT
 ZBiQ32W11PhmHbZcRuMWiXC/KN38rNELINFRk4VZ0Lx0F+hbM8vKn6Qne7TTV5HZM2M7oAHetyL
 519cwGW6EzvNvi0ZBQVadb0KImKzBNQFmOYlV3WQB+QYpvVGlYc+7roa4HyN+e7vovQou909l46
 LgObN91YYlUGew5hTxwgBJsgtpPwSeVytqBB2/xz56bGWAiaMqMnVQ783ejzaqHyXl6vRHAYeSs
 j6TvcjNaAAU/3C85tDHCSTx94GB0o76JUsaprGIIq73nX7zA5dIQf+PoI2F02Om6hFQisI+nPDt
 u9ewLO1++jQoqIp0p1vKwn9842BVNw2LgGXrUvqr4quCC0V/MSTi6at5aT0xqQLpkdcvEkkxsyZ
 /MYrR3ymQab6TAgSD61arpeoBBsaCkxlXxtS0mVetdbFQASHQzcQnt84vWDn1p0lBZFSCHEwpv5
 4nMu699QIOce7GfAwng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
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
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294329-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:ntspring@meta.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,meta.com:from_mime,meta.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 601D5630FA9

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

The mp_hash override only applies to fib_multipath_hash_policy 0 (the
default L3 policy).  Policy 0 is already asymmetric for TCP: with
auto_flowlabels enabled (the default), each socket gets a per-socket
flowlabel derived from sk_txhash, so the hash is already per-connection
and unidirectional.  Overriding with txhash is consistent with that
existing behavior while making rehash effective.  Policies 1-3 exist
for operators who need deterministic symmetric hashing (e.g., for
stateful middleboxes or same-path debugging), and are left unchanged.

The mp_hash assignment in inet6_csk_route_socket() is guarded by
sk_protocol == IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
inet6_csk_xmit) fall through to rt6_multipath_hash() and retain
their existing flow-key-based ECMP behavior.  The expression uses
(txhash >> 1) ?: 1 so that the rare txhash == 1 still produces a
valid non-zero mp_hash.

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
created.  cookie_tcp_reqsk_init() derives txhash from the cookie for
IPv6 sockets so the ECMP path matches the SYN-ACK; IPv4 sockets
retain net_tx_rndhash() since IPv4 ECMP does not use sk_txhash and
the v4 cookie has mssind bits that would bias queue distribution.

cookie_init_sequence() is split from the former version that also
called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
side effects are now in cookie_record_sent(), called after
route_req() succeeds so they are not triggered when no SYN-ACK is
sent.  cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
match the guard on tcp_synq_overflow().  route_req() receives 0 as
tw_isn for the syncookie path so that tcp_v6_init_req() still saves
ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
options.  The ecn_ok clear for syncookies without timestamps stays
after tcp_ecn_create_request() so it takes precedence.

bpf_sk_assign_tcp_reqsk() is updated to initialize txhash via
net_tx_rndhash() to avoid reading uninitialized slab memory.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 Documentation/networking/ip-sysctl.rst |  5 ++++-
 include/net/tcp.h                      | 20 ++++++++++++++------
 net/core/filter.c                      |  1 +
 net/ipv4/syncookies.c                  | 11 ++++++++++-
 net/ipv4/tcp_input.c                   | 15 +++++++++++----
 net/ipv4/tcp_plb.c                     |  5 ++++-
 net/ipv4/tcp_timer.c                   |  2 ++
 net/ipv6/af_inet6.c                    |  3 +++
 net/ipv6/inet6_connection_sock.c       |  8 ++++++++
 net/ipv6/syncookies.c                  |  4 ++++
 net/ipv6/tcp_ipv6.c                    | 13 +++++++++++--
 11 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..f8d99f3b7c96 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2444,7 +2444,10 @@ fib_multipath_hash_policy - INTEGER
 
 	Possible values:
 
-	- 0 - Layer 3 (source and destination addresses plus flow label)
+	- 0 - Layer 3 (source and destination addresses plus flow label).
+	  For IPv6 TCP, each connection selects its own ECMP path,
+	  which may change after a retransmission timeout to recover
+	  from path failure.
 	- 1 - Layer 4 (standard 5-tuple)
 	- 2 - Layer 3 or inner Layer 3 if present
 	- 3 - Custom multipath hash. Fields used for multipath hash calculation
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c4e6adb0dbd..75d265d19bce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2540,22 +2540,30 @@ extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
 
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
 
+#ifdef CONFIG_SYN_COOKIES
+static inline void cookie_record_sent(const struct sock *sk)
+{
+	tcp_synq_overflow(sk);
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
+}
+#else
+static inline void cookie_record_sent(const struct sock *sk)
+{
+}
+#endif
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
index df479277fb80..6535da52594c 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,9 +280,18 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
-	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	if (sk->sk_family == AF_INET6) {
+		/* Use the cookie as txhash so the ECMP path matches
+		 * the SYN-ACK, where txhash was also set to the
+		 * cookie.  The original request socket (and its
+		 * txhash) was freed after sending the SYN-ACK.
+		 */
+		treq->txhash = treq->snt_isn;
+	} else {
+		treq->txhash = net_tx_rndhash();
+	}
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


