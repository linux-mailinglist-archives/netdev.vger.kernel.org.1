Return-Path: <netdev+bounces-276215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPJxKyuh1Wnk8AcAu9opvQ
	(envelope-from <netdev+bounces-276215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF023B5B0B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E7C3026159
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675726B95B;
	Wed,  8 Apr 2026 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Um+eCvxq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144C2580E1
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608088; cv=none; b=QidR9bwEDVPY7SwvRPxYUQlJ4XcWW9dlQv2p8+D/jOozH86tBdbM7YxthByHku+kfZOd/dc5R+V1xmI4eEKBWH0t3QgXb81fuvWWJcTdRlx+EstCeox6dXPNBcXHemJicF+Y6QD3C9Y+yresNat8/5N7ZE/JeTuGU6kkyjqxIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608088; c=relaxed/simple;
	bh=RbzkeOoHAbOAnKMYhMJXgpeVh6XSq+zaxiOMWFMJWnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql7bQh7HpMah3O4kIY97Z2As2kGSd9Tg7NrgGOnKYcgAg+QGdNHqStDw+4LdkVSHBssoH5GE/sq4VSqxgG8Tk3PPZZ9rBlX6uLFfmCsWkOyegdbnSCxwm1OAGwWurueq9BWosMWcYAYSnqGubSBfYFWII0/+TIRRLJdnSjNZQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Um+eCvxq; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637HFCC32110041
	for <netdev@vger.kernel.org>; Tue, 7 Apr 2026 17:28:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=A9bTQZo
	E1ZXQ1eHtkXqq/mNthezmKBZ0Jw54yS/Cx4o=; b=Um+eCvxqiwoCuxF3Tk3dBCh
	oO3ddBDFRkxO4ZCGs6dD29oMBCUZltOp6k6bvzKI09I1VR55+Q9FJhdGqjioiMHP
	g+putn+5YEutD4AUMcoa+Z2Am/86u+oeDRwUbmlGT9MnRitXkgMu+oIVyaR5jYEf
	GRsAVGPzcsqh5F7EkygwsyQrO2CcYej++Ug2UMmU2yYZOt+JSwyRPthZ8ee3Xzqq
	Z5WVQ/MD4X/u0eGfJFabhsqCIwmgmhqIAJUL4H7XSyOwsiraDvAlU+TdsrNSquZl
	iBH1Sq2hqcF5BrGStsMaHq2xDl1WeOve8BFlZuifHnCFryJ8qVVFWzMWBKThMuQ=
	=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcmt2fxqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:28:06 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-467dceb8e77so12674581b6e.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608086; x=1776212886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9bTQZoE1ZXQ1eHtkXqq/mNthezmKBZ0Jw54yS/Cx4o=;
        b=XJ+BIDQq2LBf8VZJXQNJkRkDr5NFsBDiZadGzUR6mhnaTpbYBQwRknIj9VHkrLSVzx
         fBHpF+byuHTF892jOb+/vUD6cProIYZbPnFwHsdUy6zL9q3PoaiWtZ0O6UcSf118tYNw
         hFR7ViCZomyZsDPOPlyMcgiBekP9Z9niotZcY+FIS5MUjLETx6PYtNz2M4ZWF6zrLOGA
         pVYLYue72u1nqo8PZ3AU/euSDS96r4zNiTqX7ghGuTsGmFrNuL154vbfl8jXNzYIIO9w
         r1OL+sIQe7WTcc9CIIl80/7tE41fm3Ux/BwsMRHvHbL02PgX7kyLn5RGYnRBF4POUufN
         kVNw==
X-Gm-Message-State: AOJu0YysD3UZ9ypz590YThXCUGEUM6IMfK4ftt+pQ1uPPpEvhtVEDGeM
	hNwZE70RyKNXrv6dJcCb34x/xru9IdI5nzJY7+T+DLIZ2bal2qnHF1kbuztXnV/wTHLs8e+mBmw
	RKrbDjUnSckSHodpxkZWwzy2OtRzhgUBYFfexn7ZHTvh9SpNyOdWGoe7/WGAdjLyWOhC3o+7rf4
	D4GBR4YdkymYpXmHmpfjGycf1wVUI1ZXITUkld
X-Gm-Gg: AeBDievO9gflmqiAnyvJ39m8dlF7zmQ3mcHJC9czPgFRpw3KveewC+2U1MqfjAq6zMd
	8adSPQk6Gmp0bJi0Vz6anNqozG+7u14xHqwezdUYmS9B6qPKOcPTngngbekl68sfp9/2CVnkZP0
	xFjcMJvw57ntBMLvrzTQKGJVG5qSlnkr07jxH5zWjZnhZuJAUpaTn3yAcSOyV92/o+Bl7ix42do
	4LMvMlLt9f0BixF49CT0+ut4WXs1nLmLTnoe+2s3FNwj+fecWOKKQxPEDZJZRkwtD0pZhrho6s0
	Dtr6teNF1CxXupfQapsiXRevjgeNOXRF89xbcdOxjZFDhf0Jc+zzyiG8EQqIsmIDAlgLNMQgYKB
	CzK+MNPIgDD0=
X-Received: by 2002:a05:6808:17aa:b0:462:acd3:4c64 with SMTP id 5614622812f47-46ef54f5498mr9879553b6e.5.1775608085542;
        Tue, 07 Apr 2026 17:28:05 -0700 (PDT)
X-Received: by 2002:a05:6808:17aa:b0:462:acd3:4c64 with SMTP id 5614622812f47-46ef54f5498mr9879528b6e.5.1775608084970;
        Tue, 07 Apr 2026 17:28:04 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4757665c7c5sm1238981b6e.1.2026.04.07.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:28:04 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 1/2] tcp: rehash onto different ECMP path on retransmit timeout
Date: Tue,  7 Apr 2026 17:28:01 -0700
Message-ID: <20260408002802.2448424-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408002802.2448424-1-ntspring@meta.com>
References: <20260408002802.2448424-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LaQMLDfi c=1 sm=1 tr=0 ts=69d5a116 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=itqFa7u1WzcY9oaKGDUA:9
 a=pF_qn-MSjDawc0seGVz6:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: o-dwqj6b1uirg5jGZWDnfYalmpu8jVme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMiBTYWx0ZWRfX2jzSndNhe3ty
 To8YAIefZzZ1es6Bb4EkRO9tdSJWH7W1i+bLuaH8M/U/uU+2opmU0Zh9xAvXC0ASAvqCwzFFyGn
 lMafpwDYTMN796Wajwfpz0X2emC19scpX8iZOpcwbhRRymNZsiVhVMDlce9brqCJRXlSy9UJ5XH
 5MErC3aeZx3SGyh1E/Co7B9UN8nEFZuiHVOfdT7Q9/x/JrC/cpqfFGtJPHVQyucok0Yt8ZosmlF
 0Ct4qp1Udu2wqz157uRMsDlWjcrXXo7AZqRTvPQssgA35HyZVRtUhHonBsngi2YUcT8gK/uokK/
 PF9+gw1Vz9Etq6NOKmK75vf4j10mFHZZ2vapWOKtNlihQdNDgv6dVasHCZ32u/sFtdNOW0HO0by
 /BwwlPw9yqO5DlDaMhEiiQCUi1VtgoJWYHWNVyeru9wiPY6vblMPL5+wc8stkfJ/rGP6YO1WEP1
 E0u1XXOxfHp+viSbESQ==
X-Proofpoint-GUID: o-dwqj6b1uirg5jGZWDnfYalmpu8jVme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276215-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DF023B5B0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add sk_dst_reset() alongside sk_rethink_txhash() in the RTO, PLB,
and spurious-retrans paths so that the next transmit triggers a fresh
route lookup.  Propagate sk_txhash into fl6->mp_hash in
inet6_csk_route_req() and inet6_csk_route_socket() so
fib6_select_path() uses the socket's current hash for ECMP selection.

The ir_iif update in tcp_check_req() covers both IPv4 and IPv6
because it was cleaner than gating on address family; IPv4 is
otherwise unaltered, and not having autoflowlabel in IPv4 means
I wouldn't expect a new path on timeout.

It is possible that PLB does not need this (that there are other
methods of reacting to local congestion); I added the sk_dst_reset
for consistency.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/ipv4/tcp_input.c             | 4 +++-
 net/ipv4/tcp_minisocks.c         | 9 +++++++++
 net/ipv4/tcp_plb.c               | 1 +
 net/ipv4/tcp_timer.c             | 1 +
 net/ipv6/inet6_connection_sock.c | 8 ++++++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7171442c3ed7..3d42ab45066c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5014,8 +5014,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
 	    skb->protocol == htons(ETH_P_IPV6) &&
 	    (tcp_sk(sk)->inet_conn.icsk_ack.lrcv_flowlabel !=
 	     ntohl(ip6_flowlabel(ipv6_hdr(skb)))) &&
-	    sk_rethink_txhash(sk))
+	    sk_rethink_txhash(sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDUPLICATEDATAREHASH);
+		sk_dst_reset(sk);
+	}
 
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 199f0b579e89..ef4b3771e9d8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -750,6 +750,15 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 * Reset timer after retransmitting SYNACK, similar to
 		 * the idea of fast retransmit in recovery.
 		 */
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6)
+			inet_rsk(req)->ir_iif = tcp_v6_iif(skb);
+		else
+#endif
+			inet_rsk(req)->ir_iif =
+				inet_request_bound_dev_if(sk, skb);
+
 		if (!tcp_oow_rate_limited(sock_net(sk), skb,
 					  LINUX_MIB_TCPACKSKIPPEDSYNRECV,
 					  &tcp_rsk(req)->last_oow_ack_time)) {
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index 68ccdb9a5412..d7cc00a58e53 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -79,6 +79,7 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 		return;
 
 	sk_rethink_txhash(sk);
+	sk_dst_reset(sk);
 	plb->consec_cong_rounds = 0;
 	tcp_sk(sk)->plb_rehash++;
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index ea99988795e7..acc22fc532c2 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -299,6 +299,7 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		tp->timeout_rehash++;
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+		sk_dst_reset(sk);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e116899..2fe753bb38b4 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -48,6 +48,11 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	if (req->num_retrans)
+		fl6->mp_hash = jhash_1word(req->num_retrans,
+					   (__force u32)ireq->ir_rmt_port)
+				>> 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +75,9 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	if (sk->sk_txhash)
+		fl6->mp_hash = sk->sk_txhash >> 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
-- 
2.52.0


