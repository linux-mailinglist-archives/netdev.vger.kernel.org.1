Return-Path: <netdev+bounces-276310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOe0Hf/+1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22803B7E66
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D6D30480FC
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7498351C0D;
	Wed,  8 Apr 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FfxDCfka"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE68371057
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631922; cv=none; b=FCog1/hbB7ABDEoePxNIflyIWcz00akkVx0ADSODLL/Bgv4/1Glx39HCdBqxnBfKykY3IgUig3JGgEuypl3o8UXp4OMBWY4IYsg0ukUJ/swQUgmwOmL3q6Q5UEQ+tEtyrGRcZm+2ZYXiIoucqZYjl2Q4zYRYFRoGtdiOv4PpnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631922; c=relaxed/simple;
	bh=gQgtQZ9AsxKYJ2uQB26kbfdHN/K44k3t8+J02CeIEAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNYL7AqQOzDtnIqqKzecufyyfQ5LzClhh8Kktzi1KeGbgWt3b+N2KzuOHyp36qqGUOwAQM3Hr7RmryRf/HHUfeag6XfYy1VZnD4gAbCF/XmhEvznQfFRQp851IamuKcrTzZsU47l/oxVn6eXi1eGOFHYyBIn1P82H2itL+GwR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FfxDCfka; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637IaHQ72506663
	for <netdev@vger.kernel.org>; Wed, 8 Apr 2026 00:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=v3Ixz30
	QLlW5Oeb38Ly+m1oZRA3CoyhKGbhsl5Shg6Y=; b=FfxDCfkaE8pW/WGCeC/1NHZ
	qqsge1OZqwzLHe1Q0GUu1dIhJ7OsANsNIdCnGK6HD3Jfy/7JKrGeqLxRQG4QX97A
	gmjRV0fnKr6fE9ytMMk1Rgh1buSmvLcPgZTXGGhogx2GVRjQo3n+68cY1TjL3ePr
	3x9XCVsri5nxo4RU6DE/Ryk2OVVIuh3aUvczeeK6Tu3oXY7jnMoyrcCkPjv1ZCsG
	SG8KlVea/+T+i0jn3mqeOFCJDs+BVvlPYTFfKWMfdLlZimXC539agFdAyslHeEj0
	gbtvxa5mUFHPljNN0COts3/23qCuKgJVoGa7lHBZM7iG525tkmKRRASfaesSFBQ=
	=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcmt2hdn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:20 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4236c3b8f32so1798070fac.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631919; x=1776236719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3Ixz30QLlW5Oeb38Ly+m1oZRA3CoyhKGbhsl5Shg6Y=;
        b=CrdTi21a9TP7yUOSgdQEg+4BwqSxLR46V6UNbnG0zSR7gkAxXf60mOUGugIpo6/pAz
         NBJ3URL9zhvw8RrfJBMDzJ+TnEHnSipK4399QRHq2HKGGEf4hiYUmGoiLmZnMqCNSzoE
         RDi0Q3olVf9cXGsVAzc6yNKHXZpeEvpB1VqmU6skg6PvS25suMJd0RKarjiaCokJP7x6
         AefIRxrPsxMEKD/IlnuY2mCrXKx573tblhK45FsHYZzPZTexmkMoQFHJUGN/EyvEjInX
         HohV3Ac0+crsrVRQSLOKYGEbmBayrDIgLue0tFolU8L58UdjjHl/3JAdMupt2TLPr7b7
         emRA==
X-Gm-Message-State: AOJu0YzFUBMhabngonOyEflJ9mu6rEhibCldfIRwp76PgIGw9mgXerWP
	XokEw1iA3rC7RRMyUJQGM1NF0ftU2/SP5rMxtzgSsx23tAMJJM6to60RrLRMJns0Wqjrci19Xmr
	jCckEU3L8pGoDua3VghUawPr+Sz1QWORSolT+5w+1WkQFlrMJKO984c64GJhkS2ilISS/a2A7Gc
	R8v1041XRheMaBld8+h4l8+HxktTXfiDsbDTYc
X-Gm-Gg: AeBDievZ4GYL8OypKwjsep0iIAWIdRIjazY0YDKb5+rsc+gMhNNPL0lNh38KtcjpRGM
	EuHRoL7ctfQZhfo8JWNCZ3OZ+4sywvssH6xLHVeR/KIzlw6fhsUmF56xWpROS1jRXaXR2hdXCD+
	RK0XqzOL5V12KcgmjROMKVsUt8rP9JCwiYrkjNAlavJ4DBeeqESlQlKF3B+ZqxhcLK5/zWUqgjI
	aqlfkc+C9hYiahWFOxHUhU4ZwP4nnrN8NgMNF0y+23YxT7y/XDzugS6oAxG/uoN0asZgF+haiPa
	omjna2RfH6d2IrQzo3041lLGZF/Fh3GZQOq0515zeoT171IEZefEYI7KBL6YJ39JtxvRECvUskd
	hX7bkcFr+DA==
X-Received: by 2002:a05:6871:7282:b0:417:23f7:6df5 with SMTP id 586e51a60fabf-422f35aa008mr11496870fac.7.1775631919154;
        Wed, 08 Apr 2026 00:05:19 -0700 (PDT)
X-Received: by 2002:a05:6871:7282:b0:417:23f7:6df5 with SMTP id 586e51a60fabf-422f35aa008mr11496847fac.7.1775631918627;
        Wed, 08 Apr 2026 00:05:18 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaed6647sm16317732fac.2.2026.04.08.00.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:05:17 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org
Subject: [PATCH net-next v2 1/2] tcp: rehash onto different ECMP path on retransmit timeout
Date: Wed,  8 Apr 2026 00:05:13 -0700
Message-ID: <20260408070514.1840227-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408070514.1840227-1-ntspring@meta.com>
References: <20260408002802.2448424-1-ntspring@meta.com>
 <20260408070514.1840227-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LaQMLDfi c=1 sm=1 tr=0 ts=69d5fe30 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=itqFa7u1WzcY9oaKGDUA:9
 a=vh23qwtRXIYOdz9xvnmn:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: DLDiNQsXhHiMO5-j9owUO2nd6kUZbfOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2MSBTYWx0ZWRfX3Y8F9tOfYZ4U
 nM+AGTjS3o2Iq74dkeb0qD3UlWi/udWzHhjbmSJ/Gem3nNEF2pOghYRpOQzmB7En+6gurNrqq7E
 Ue032C/Z5KolD0OHHI25EMCMgGL67A/etlXxijGOOe6fllub9O75T11V3kY8PWCdl7j+mqeN0TD
 wFMUeb7Q4wgPBnSsKxI+xarTogV9EjFER0EiT9Wue557Sns72/XykgkR7UDSQYl6HgU77cfyPUA
 x+cGYJOsNP+yGEawEMUveoc0bezE2hFTIerhqIOG1Rb7GzywsTS+Xo/Kfyr09vRQq9U/ooGFlsn
 96VSKfKqIMzL3RCp+oLaHkoFnFCxcB5fxpQ61sMfJNJ2pQ5QXGbriU5+s7ncT/EzDqRBQn5AOSJ
 /EO6n4h2K6tcFTPs/+DSU46WNLMY9AAFCwbOrIBGp1YgZeDVftLez/iLT3WzdwAxSNrALwaik6P
 HZotcZl+6IrTtpaSyWg==
X-Proofpoint-GUID: DLDiNQsXhHiMO5-j9owUO2nd6kUZbfOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276310-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:email,meta.com:mid];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C22803B7E66
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
 net/ipv4/tcp_input.c             |  4 +++-
 net/ipv4/tcp_minisocks.c         | 13 +++++++++++++
 net/ipv4/tcp_plb.c               |  1 +
 net/ipv4/tcp_timer.c             |  1 +
 net/ipv6/inet6_connection_sock.c | 11 +++++++++++
 5 files changed, 29 insertions(+), 1 deletion(-)

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
index 199f0b579e89..27edf71effc2 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -750,6 +750,19 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		 * Reset timer after retransmitting SYNACK, similar to
 		 * the idea of fast retransmit in recovery.
 		 */
+
+		/* Update ir_iif to match the interface the retransmitted
+		 * SYN arrived on; inet6_csk_route_req() uses this as
+		 * flowi6_oif, constraining ECMP path for the SYN/ACK.
+		 */
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
index 37534e116899..3fd7acbe2c49 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -14,6 +14,7 @@
 #include <linux/ipv6.h>
 #include <linux/jhash.h>
 #include <linux/slab.h>
+#include <linux/tcp.h>
 
 #include <net/addrconf.h>
 #include <net/inet_connection_sock.h>
@@ -48,6 +49,12 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	fl6->flowi6_uid = sk_uid(sk);
 	security_req_classify_flow(req, flowi6_to_flowi_common(fl6));
 
+	/* Use the request socket's txhash (re-rolled by tcp_rtx_synack())
+	 * for ECMP path selection; >> 1 for 31-bit mp_hash range.
+	 */
+	if (tcp_rsk(req)->txhash)
+		fl6->mp_hash = tcp_rsk(req)->txhash >> 1;
+
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 		if (IS_ERR(dst))
@@ -70,6 +77,10 @@ struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	fl6->saddr = np->saddr;
 	fl6->flowlabel = np->flow_label;
 	IP6_ECN_flow_xmit(sk, fl6->flowlabel);
+
+	/* >> 1 for 31-bit mp_hash range matching nhc_upper_bound. */
+	if (sk->sk_txhash)
+		fl6->mp_hash = sk->sk_txhash >> 1;
 	fl6->flowi6_oif = sk->sk_bound_dev_if;
 	fl6->flowi6_mark = sk->sk_mark;
 	fl6->fl6_sport = inet->inet_sport;
-- 
2.52.0


