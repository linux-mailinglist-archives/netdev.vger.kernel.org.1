Return-Path: <netdev+bounces-284570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHNDOl5H+mmOLwMAu9opvQ
	(envelope-from <netdev+bounces-284570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2AF4D32C7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658DA301C3ED
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE03CBE74;
	Tue,  5 May 2026 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mAKOb9fN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3E48C3F9
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009912; cv=none; b=Qf/GzPBgb4CN5TOUMUGjnrRHPT/p9SYLH60hKt96x8A8XNVoeCYowbtKAEaunpKlI1R3CB2E1fD5LThLDmHvZeUUMA7XxNaMnQqkAqh7IecR5PcqtGN6qA0mwuP/cqzY9yzf7VfaQo34CNkyMRsLMJsnDVrTZEPVSq8TNUFY/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009912; c=relaxed/simple;
	bh=NpC6y8kvQUfzumLytoXgHwd30sItcDGp/R51uXeEXvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptTAUnqgKw5MSfalNr7buFJsdM3iJhPSanYpOVjc6Fpc5AxXtBhhXR4RYT9g1KSupwT7XiQfad0QXkISTxfaPnnyLBPYaRyZiokb5jeqZpqNx7zuHCJf4rkpU+8v95rNxzOg6LbtD+8efJvDZWRyHu9ZV0kAfsvtbHS/mZmxFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mAKOb9fN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFn553475801
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 12:38:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=qwKJgGb
	qbFGoF9mXTN7LU1edhX4i1hjzt5GacUyFrYw=; b=mAKOb9fNXEsK5cfIGgMeyTg
	bIOCc9zI3IdlLoIiQFlzgS5WfEjG8OsRw9roMNPWlHV3hMmVtVOpKdt8vnuftqm6
	L0u/aMk775VIqHwA2ZpAfqTqlacdMISOtXnp/jo7P5i3DKNX1TuNIOpvaUVnYA8Y
	OBwqS9oSUIaYkVkBLY9wUj6UlXMbYuy2Gxubw5nKlAUysHoW+7/EBSZtH8K21afD
	yMjHTUAgDgl7w18M7pPR9XX5RyMP3KykuEsL9gxt+9kmW8Y92PW/LnKpq6NYEPhz
	/rpcnTWpXh7q2Zkrg9rOOrzXJEkk/eLkbq/V6vaxva+thGEdRuscKAkNHZPjNZg=
	=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwf0db0k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:29 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-479ef25c477so4343665b6e.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009908; x=1778614708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qwKJgGbqbFGoF9mXTN7LU1edhX4i1hjzt5GacUyFrYw=;
        b=MtnKwT7Hv+5hAlF7FQUSEcq6qekYPDkm8CtYqZIyVbFe31SCNcrVNaW2alY1yMOyem
         CXYXWFJ6r16lxfUy+M0ZI9oultz1qKtWTl76alAJ91bxQojLMk4nDjtcNO29RTHYC8cV
         UU8JqFuO8oCShYdDZl7ccsrTT4MiobalH9Ul2XMtXuEG0SXGNbGTTJDtUKhIEW6zIiDM
         crJacP/YM6qa1TCIgaDoxrQKTdpRHH4AvSsjIY3hqV++Iji/AnDwt3y6MSiTlWKJ1wgE
         Hymx+b9RkiNCJ9JpvDYw5VD7p9KiPsSTNNEIp6SRZEnG6oWStTn3HR3oZ0d/HqKsnvrQ
         n+6A==
X-Gm-Message-State: AOJu0YzNugnrb/dkQfCshrEk5PtB8E3/FXo5eMvuqnPnRjEC3EC1pq7v
	e+g+VJTBm1Sx1YKeZzmDgzK7AzdltGqFxN5FVAxsWQSE8jScqE//tIOyrJM2pMcvLe+X/tlv0p7
	aukd44Epqra3YFLYMgVifAg8QcezQLi/EBz4YD2Rc93wRkcSJf6i1on3r3WKxJx1mGZMmMFCtbI
	97ZC4ENw0aXlCumirlI145Pi53b+KNtrEf7R2Q
X-Gm-Gg: AeBDiev2zLdh7UVfoghWlOu9u5zoEONF8OUOPArjudPwR/R/Xln1F42Fz0kIbj5tt5M
	5Siq7ekf7dzyb3UcizQqcwVc7+ns9n+naeM0QKo9dPn3qPKq4ema2kDCfl/v3RT7hrOMJj62mh8
	B1p7nVEDIrnLKlx1Wi+lJnKwy5kKXf/me8KpcrzFHWR7q4ECKuqCxfl6pNXWzx2EOKGMFcBFbt3
	IxhJTDRgoPKz5VKSDlNa+hk0q9Gz7vEdrFcyW/E3AFneI1rfKYHhl/OjnJhO5GV2Qh3B1tMU8+s
	LnGrmrB8Sy0+tA5SmXeSbmJ4cz2a+23OM4+swuy+d/FxzzC4AdehRQEuiZX7mbkAx8OD1g/MHcF
	4BwPBNsXUmDqqhdnf3A==
X-Received: by 2002:a05:6808:690b:b0:462:dc57:f8ba with SMTP id 5614622812f47-48042459867mr300743b6e.27.1778009908442;
        Tue, 05 May 2026 12:38:28 -0700 (PDT)
X-Received: by 2002:a05:6808:690b:b0:462:dc57:f8ba with SMTP id 5614622812f47-48042459867mr300724b6e.27.1778009907924;
        Tue, 05 May 2026 12:38:27 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac8ef53sm10865261a34.21.2026.05.05.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:38:26 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
        ntspring@meta.com
Subject: [PATCH net-next v3 1/2] tcp: rehash onto different local ECMP path on retransmit timeout
Date: Tue,  5 May 2026 12:38:23 -0700
Message-ID: <20260505193824.2791642-2-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505193824.2791642-1-ntspring@meta.com>
References: <20260505193824.2791642-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y7LIdBeN c=1 sm=1 tr=0 ts=69fa4735 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=EGUsVzdc72UV7ebe_tsA:9
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfXxJ7Qu98AbCp8
 HUZbg2UCAIWNX61pC57hhoFJaS2JygsboHVGImrTxYqBQ/jHEJ56A7VgNqa4mfJUK/qXKQqIw/S
 mZ87vEgwZQHnFa+8ummM7kerMPY9afFeKRuoDb6I5grNqfx5vL0jS5ffJ+RsLTzjc43SPOb5FcY
 0i2QXhjFWqTIxKR+SQZCJR3hMawChF4UNzWx1OKZF3yUI5L6yzXOuu9LYzLlROalW+ugHjtaj3+
 qJeclMBtwr0AxQwUI51ycVLc0CVzBeexDabHEXKmiFluIA+CT0gUWWnaN+byIBgYuNVDj9bClLW
 ziep7FuVqBS2jENYIapGRMBQcpj6mTC0OD5upGvpD4VPrpL3OIV/FPZ7p8x6IJyEMgzISQ2tmxK
 HZpiK/KbMYNoXCFBgdm+DpKD2N5fyUE+UkQmt1VuAYb2N8LLC/hi3ENeIAbwwXZsD7oHUBPjfF2
 PlPo4KS9ox+kY6K2YUw==
X-Proofpoint-ORIG-GUID: _5Bi-bD0VwGijWOpMQ63I2KGVe4Wp2NP
X-Proofpoint-GUID: _5Bi-bD0VwGijWOpMQ63I2KGVe4Wp2NP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: 5E2AF4D32C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284570-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
and spurious-retransmission events, but the cached route is reused and
the new hash is not propagated into the ECMP path selection logic.  Two
changes are needed to make rehash select a different local ECMP path:

1. Add sk_dst_reset() alongside sk_rethink_txhash() in
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

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 net/ipv4/tcp_input.c             | 4 +++-
 net/ipv4/tcp_plb.c               | 1 +
 net/ipv4/tcp_timer.c             | 1 +
 net/ipv6/af_inet6.c              | 3 +++
 net/ipv6/inet6_connection_sock.c | 6 ++++++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7995a89bafc9..126dffd675c9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5020,8 +5020,10 @@ static void tcp_rcv_spurious_retrans(struct sock *sk,
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
diff --git a/net/ipv4/tcp_plb.c b/net/ipv4/tcp_plb.c
index c11a0cd3f8fe..0c067a54c57a 100644
--- a/net/ipv4/tcp_plb.c
+++ b/net/ipv4/tcp_plb.c
@@ -79,6 +79,7 @@ void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb)
 		return;
 
 	sk_rethink_txhash(sk);
+	sk_dst_reset(sk);
 	plb->consec_cong_rounds = 0;
 	WRITE_ONCE(tcp_sk(sk)->plb_rehash, tcp_sk(sk)->plb_rehash + 1);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPLBREHASH);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..d92f3ba9de81 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -300,6 +300,7 @@ static int tcp_write_timeout(struct sock *sk)
 	if (sk_rethink_txhash(sk)) {
 		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
+		sk_dst_reset(sk);
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
2.52.0


