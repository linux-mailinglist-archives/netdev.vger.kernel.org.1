Return-Path: <netdev+bounces-295419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ggp/HLHsIWpoQgEAu9opvQ
	(envelope-from <netdev+bounces-295419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:22:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D564393E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=XStWF+Y1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295419-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 610F73025AF8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8B3FB7C7;
	Thu,  4 Jun 2026 21:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C953EAC9F
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:22:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608175; cv=none; b=nFGcr4O3RFCiN1z0pESfLp8O67DQrUQ1dfPSns9pfM0+IhOlbDhLMRuEslWx/Fvhg06s37IE1Gzjss89ATKgHH0veupNLdk7Pomjon0NPBkqGLIxxPNmhujbXtRDFUBeclkz2rSzSboK/E7RTQYlN630IYR2vqTKTAYWgSwHQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608175; c=relaxed/simple;
	bh=HhYRu7fm5ZrjRuLe95CPdyufMeUSXkYY5MpNG514AQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loerZTi9x1cS31WGUfXscv0vphv6FXwmkqhC0ARpi4VZNGp5eQptaIlhsBVVjml+aD2cr2M/5Ozbr9qFhKnOI19dSyHh08LPHA6dS/5ntycsiUtH2TSrZH4xutLFQ5dbNsJ8X6P7Qm3gUrwhAOjurzvvybMAWAbhn7xESSW296E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XStWF+Y1; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654DuXjA293238
	for <netdev@vger.kernel.org>; Thu, 4 Jun 2026 14:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=Hcm8Dn3
	58DWLdta6KIp8uqw3GyvFM7+UwZityJyagto=; b=XStWF+Y1cVPjZpe6hQE/4wx
	00xDcXZ7hq4RMn/Xphqk7sQUdF7QoDkq1znZD6/yqXn/U7mZoNWj5HIxhl4nZ/WY
	8c4hG1a9gnB0R0IkofaeL9+J3gWfZwHgMIK2xmMZQU0y8xzbLHbjC2HJbUEqTVcx
	wOR0uublwsH3EPdTJUmHJoz8zv4d1mJP5+PiE0DiJBNifDMnERlMuKDPNxAdEVrz
	3TVzNhMDKFcJB0wc6bBsOyKw4c7z+3stkJtWwfXgeVn3BtVhZ+U+XdRYC5XTgIJR
	byCy/ZqBXRdAQzl9NxrPO2rMQHq9jLOkEyZcywWHbYIgJmWaATfUXs4Vz58lHgg=
	=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ek39qwec1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:22:53 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6ed99b9b4so2577400a34.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608173; x=1781212973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hcm8Dn358DWLdta6KIp8uqw3GyvFM7+UwZityJyagto=;
        b=dQ61k1xNlVFWJrLz9aocX9l/A+putBWaqn1XbhH79PT+TuCCiVZzVFnGI1qfC4EyNf
         UwHpK1hSplJtTZdZHxUsQY4TDRS2WkHFqSgGAQ+msJ6nEiFrW2JyKfJF9hfDfZT+JLfj
         6GW+G6PgsaewwejOy34tj2c+Svlj2BQlHYodeEBCPWNwJgi/1eLsRFUXFzJhFJCvoJxL
         snzmy1AWSs4SNV9UORAh1ii+TOo2hHtXl8F8k5SB9hpP7ZSADMngrwjMXatkWMzaJF83
         LmYABVE0vwsKTTYwaWuyiiyDCCPpItzIGAXOXUSMj25aoOty5F3B8gBwLfQIjjakq8X2
         IwYA==
X-Gm-Message-State: AOJu0YxDTJXhnaHK7Bo2ww9JVUAsN+5M2yZBL8pMe6FczIXc1CjktKCH
	hzhjKrcgZwj2ur4qaorfo4t7f5Vk/UBuPa9C4qRjI5ZLQDlkRgNutDw+x+ucuEfzLcz5FYoUYR6
	SqGhKdyNjKwZSQLpMTgizUXGpscQWLY/lObNzmlx2cj6EDfTfy3jCwG19CCERiqbVj7NhZkhKD7
	H6c+eg/PoDVXZvEWQpXrZKyYWQAYQEkNv3WeNE
X-Gm-Gg: Acq92OHJnuOZQvI0mVoBVtkZ5ZQeqWAWI7Bas1iw7CEBAvuMh1RxC9W7ilWNRixx9Qu
	KbdznKPa/egMvcvkcn4jePfMuQoBU8TkxK3vow+NH1KrPZbgw7FCoCoAzN6gv7paVHId/B7IJ7Y
	7Px0nz1kVvR1ETMmsuAOhdlze49Nc+lWrlGFHtjgC/o9sfljViimgiELhklI0xf6/6h7AUReKPd
	u4jnDHH8c7Wi9zHpNLNIOT5q8fbgKHGqPdrLquadP0Z9qGSOuj2xWQMbydf/gLh+K9QztLhMHee
	jyjnpVp7nMcmsX5nXWiCskttOJoiO2azY1oiYdQUQ7gAvYahcNxojC/HDgh4XF9qKfJ6pBmnJpE
	iG7Z21Ecng/ZUG01cL2Qv
X-Received: by 2002:a05:6830:f90:b0:7dc:d967:63de with SMTP id 46e09a7af769-7e70c5addcbmr298306a34.3.1780608172344;
        Thu, 04 Jun 2026 14:22:52 -0700 (PDT)
X-Received: by 2002:a05:6830:f90:b0:7dc:d967:63de with SMTP id 46e09a7af769-7e70c5addcbmr298269a34.3.1780608171659;
        Thu, 04 Jun 2026 14:22:51 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78dd7b9sm4676970a34.15.2026.06.04.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:22:51 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, ntspring@meta.com,
        bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: [PATCH net-next v12 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Thu,  4 Jun 2026 14:22:45 -0700
Message-ID: <20260604212246.265079-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604212246.265079-1-ntspring@meta.com>
References: <20260604212246.265079-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O5UY3hxbKnxLUUqArpi45UE_u-mcUeup
X-Authority-Analysis: v=2.4 cv=NJXlPU6g c=1 sm=1 tr=0 ts=6a21ecad cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=kDibughgBo_jdUefT2EA:9
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: O5UY3hxbKnxLUUqArpi45UE_u-mcUeup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIwOSBTYWx0ZWRfX9Kgn5H4quUQo
 sokKtDtkW8+2tjvKTlbWEBVedFNA3bN3wi4lx+onkSvuPza4gYQphGeSDQQ/GpeCtuo1ZmP6ucV
 LePuNLp8vBmzpfQrWLacAKiJXxMj7Rl4IrdHyEhyePhA1lNC2gKNOJeS5FI9tMOOq2zg9Wz2Bb5
 Sd5R/v86z25KpQtsa7mHxoPZCYjIMEoQ0EA+EeNX6z8kp+ATHTaZHxz5tA60jUCAYqFvSjE3LrN
 6RMLF2skLD1EalDGE3Z1M0qr56Wszn0YQjIuLaZfoB+NtI7Qjj3ROooRkxy8mKRafzNDL5twH7o
 YjCYe3lJii9CmWLxHX82wEtbZ0Wa/VT2jEqzukzo4Jv0T9FDZTUTJ083LE8gPgS2gb9ku+LaPFf
 BqJwu2VwZhTBxZ0Jt3nKxvHXEA+GUXzXkD9Os+UW8Y3zBG3lQCx2o/cZyABHYRyz3aeq8dBaQH8
 y2/8ToEDpJBX/9f8cpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295419-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:ntspring@meta.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D5D564393E

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
   inet6_csk_route_socket(), tcp_v6_send_response(), and
   cookie_v6_check() so fib6_select_path() picks a path based on the
   new hash.

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

tcp_v6_send_response() also sets mp_hash from the response txhash so
that a control packet (a RST from the full socket, or an ACK from a
time-wait socket) selects the same local ECMP nexthop as the
connection's txhash rather than falling back to the flow hash.  The
time-wait socket's tw_txhash is copied from sk_txhash when the
connection enters TIME_WAIT, so it reflects any rehash that occurred.

Setting mp_hash explicitly is necessary because the default ECMP hash
derives from fl6->flowlabel via np->flow_label, which is not updated
from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
cannot help either, as it runs after the route lookup.

As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
label.  This is intentional: only local path selection changes, so
rehash can recover from a failed path; the on-wire flow label is
unchanged.

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
created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
assignment in tcp_conn_request() and the full-socket assignment in
cookie_tcp_reqsk_init() are keyed on the packet family
(skb->protocol == ETH_P_IPV6), not sk->sk_family: a dual-stack
AF_INET6 listener also serves IPv4 connections, and the v4 cookie has
mssind bits that would bias TX queue distribution if used as txhash.
IPv4 connections retain net_tx_rndhash().

cookie_init_sequence() is split from the former version that also
called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
side effects are now in cookie_record_sent(), called after
route_req() succeeds so they are not bumped when route_req() fails.
cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
match the guard on tcp_synq_overflow().  route_req() receives 0 as
tw_isn for the syncookie path so that tcp_v6_init_req() still saves
ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
options.  The ecn_ok clear for syncookies without timestamps stays
after tcp_ecn_create_request() so it takes precedence.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 Documentation/networking/ip-sysctl.rst |  6 +++++-
 include/net/tcp.h                      | 20 ++++++++++++++------
 net/ipv4/syncookies.c                  | 11 ++++++++++-
 net/ipv4/tcp_input.c                   | 19 +++++++++++++++----
 net/ipv4/tcp_plb.c                     |  5 ++++-
 net/ipv4/tcp_timer.c                   |  2 ++
 net/ipv6/af_inet6.c                    |  3 +++
 net/ipv6/inet6_connection_sock.c       |  8 ++++++++
 net/ipv6/syncookies.c                  |  4 ++++
 net/ipv6/tcp_ipv6.c                    | 21 +++++++++++++++++++--
 10 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..9905f5aa2427 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2444,7 +2444,11 @@ fib_multipath_hash_policy - INTEGER
 
 	Possible values:
 
-	- 0 - Layer 3 (source and destination addresses plus flow label)
+	- 0 - Layer 3 (source and destination addresses plus flow label).
+	  For IPv6 TCP, the local ECMP path is selected from the socket
+	  txhash rather than the flow label, and may change after a TCP
+	  rehash event (such as a retransmission timeout) to recover from
+	  path failure.  The on-wire flow label is unaffected.
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
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index df479277fb80..cc71d84df42b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -280,9 +280,18 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 	treq->snt_synack = 0;
 	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
-	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
 	treq->snt_isn = ntohl(th->ack_seq) - 1;
+	if (skb->protocol == htons(ETH_P_IPV6)) {
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
index 7995a89bafc9..fc8e886f7791 100644
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
@@ -7659,7 +7662,16 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
 	inet_rsk(req)->ir_iif = inet_request_bound_dev_if(sk, skb);
 
-	dst = af_ops->route_req(sk, skb, &fl, req, isn);
+	if (want_cookie) {
+		isn = cookie_init_sequence(af_ops, skb, &req->mss);
+		/* Use the cookie as txhash so the SYN-ACK and the later
+		 * full socket select the same IPv6 ECMP path.
+		 */
+		if (skb->protocol == htons(ETH_P_IPV6))
+			tcp_rsk(req)->txhash = isn;
+	}
+
+	dst = af_ops->route_req(sk, skb, &fl, req, want_cookie ? 0 : isn);
 	if (!dst)
 		goto drop_and_free;
 
@@ -7699,7 +7711,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_ecn_create_request(req, skb, sk, dst);
 
 	if (want_cookie) {
-		isn = cookie_init_sequence(af_ops, sk, skb, &req->mss);
+		cookie_record_sent(sk);
 		if (!tmp_opt.tstamp_ok)
 			inet_rsk(req)->ecn_ok = 0;
 	}
@@ -7717,7 +7729,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
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
index 2c3f7a739709..9b3415abab1e 100644
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
 
@@ -955,6 +964,14 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (txhash) {
 		/* autoflowlabel/skb_get_hash_flowi6 rely on buff->hash */
 		skb_set_hash(buff, txhash, PKT_HASH_TYPE_L4);
+
+		/* Select the local ECMP path from the connection's txhash,
+		 * so a control packet (RST, or ACK from a time-wait socket)
+		 * uses the same nexthop as the data.  Only policy 0 uses
+		 * mp_hash; policies 1-3 derive a deterministic hash.
+		 */
+		if (ip6_multipath_hash_policy(net) == 0)
+			fl6.mp_hash = (txhash >> 1) ?: 1;
 	}
 	fl6.flowi6_mark = IP6_REPLY_MARK(net, skb->mark) ?: mark;
 	fl6.fl6_dport = t1->dest;
-- 
2.53.0-Meta


