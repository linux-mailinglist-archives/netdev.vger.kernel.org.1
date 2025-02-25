Return-Path: <netdev+bounces-169533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1010A447E4
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A503A6FB8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8A4194A59;
	Tue, 25 Feb 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuF/+PQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D20192590
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503453; cv=none; b=F6vejzULlGjggkcaGJmR3KwK0OPJCak3OiHVvQbQmIDrtsciIVCUPu0i2mqiwnf/s+lxkahpG/vvIcIvnvk/O+ro1mr7aVgSn4ZJBvvGJSSm6Ty3AJ8FDpt3cBb8N7hjxBC1WXDDWxpPFVBwWSaytGH7yXqJfqmX2GQ0OyqjZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503453; c=relaxed/simple;
	bh=hE3roQvAPi8R7ODiGLb9uxlCAFrEG2WFaHvORI+FEYY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b7xPaWrkJ1vOE2XHt5pAVO/NqlV4aPY9bQaCDC4CbLFQuleJyVW9jwhNGB5Eiu+DHMKutgpqoTQ3+x/kqhb89Ua+ifqZLtATevpkEznKv+xSUz4SevJD7b5KeBGOxIM33IWZw+uGHSvG0NSDVUBoqfAPARurjCcPSGME2ctfBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kuF/+PQt; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0b7ee195bso1196162985a.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740503450; x=1741108250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HahNWZG3Qvj28ZxW51ubfCQbIb9BiMhmlUgjW+j94rQ=;
        b=kuF/+PQtDfXsCo9P1eik4I+z5hJDWtlBZSTKmxNNMkDeX6QT9GV9nDClNAwtbtDlWS
         5+flwh7CVmMnjP2Xp+OSql8HyJZdK0H0zhXTVi0XD92MUUeVjgZjTsPzA9YhH5CQ+PcX
         nT9+rMlm4MmYIufCPz6ubltCkSA31sKYaoa3hWF0KIjMDrUJIKX5QFmchaNWNzOgqrwq
         gi/bUi1aBaRnhmk2OWi5Hujml2UVQPI8vP8NvyjC/RIhrjXq4mmS6CQm2s866anYYqv0
         3rHmwYa0zq+6vgABv3veiLsT4rjyJNcw1kwKw3u+I82m0jXQUprKJwtsHrEB3Uwcjr0S
         b6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503450; x=1741108250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HahNWZG3Qvj28ZxW51ubfCQbIb9BiMhmlUgjW+j94rQ=;
        b=IoahOE1imgot68ic2/lRhAIxJCR1eu8Ids85VRroJjzVJ8ygyBI8/1yCVdVkLCJfor
         OQ0ZztN/AT4Yuw75kQ77GQHg/ZAac2M7pI7VADN9ER4qe/dQtdIvUeGg7C25BkAeMW9+
         nwD8lw9HUdQ2bE/KwG+HiPBZhfpMEnuPbQk1cDOQo09k1+c2dPsgS4HMKg7JnHF54GKC
         eYEzbGMWGtutrzrCMs55a4QSme42h6skemxh5GzllYVpVuZi/SoqARPrPRs2eN0aW6gZ
         d1Xp9ZY/u/UKJ7PXMzV/0mqmtFJpAvUxxA3RTkSM56UdUqW7S/jLQHnrQlT7mtVDLEFr
         eJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVe/qMWSog+XhnP1hSqIj8F8sRvpfOhrrVMMe4IthaVP9VLVRahDjq8ICoo+NJZFMJAXeG57pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTg/ydDo88UKx/MJAvkhNAEy4eONN2qGrI1Q2d3zCj1tkakMB
	QS6thCygeo+gUTzxy8iWF4lynHKz6PQOqmnR96edzx+t5YIzagx3bizmCLpv/5y7SbwdHVzPPxL
	8tfYURwoVAQ==
X-Google-Smtp-Source: AGHT+IFvumpQf7Yl652XlILF0U04kxqrbgqIAQZrF4ZWCKDNuRuYI+2KTsfFrLE8nKdPbL4sLVxiCYANkTEs5g==
X-Received: from qtbcp6.prod.google.com ([2002:a05:622a:4206:b0:467:83cf:bfb9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2916:b0:7c0:ae97:7fba with SMTP id af79cd13be357-7c0cf955b78mr2094655485a.43.1740503450064;
 Tue, 25 Feb 2025 09:10:50 -0800 (PST)
Date: Tue, 25 Feb 2025 17:10:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225171048.3105061-1-edumazet@google.com>
Subject: [PATCH v2 net-next] tcp: be less liberal in TSEcr received while in
 SYN_RECV state
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
for flows using TCP TS option (RFC 7323)

As hinted by an old comment in tcp_check_req(),
we can check the TSEcr value in the incoming packet corresponds
to one of the SYNACK TSval values we have sent.

In this patch, I record the oldest and most recent values
that SYNACK packets have used.

Send a challenge ACK if we receive a TSEcr outside
of this range, and increase a new SNMP counter.

nstat -az | grep TSEcrRejected
TcpExtTSEcrRejected            0                  0.0

Due to TCP fastopen implementation, do not apply yet these checks
for fastopen flows.

v2: No longer use req->num_timeout, but treq->snt_tsval_first
    to detect when first SYNACK is prepared. This means
    we make sure to not send an initial zero TSval.
    Make sure MPTCP and TCP selftests are passing.
    Change MIB name to TcpExtTSEcrRejected

v1: https://lore.kernel.org/netdev/CADVnQykD8i4ArpSZaPKaoNxLJ2if2ts9m4As+=Jvdkrgx1qMHw@mail.gmail.com/T/

Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../networking/net_cachelines/snmp.rst        |  1 +
 include/linux/tcp.h                           |  2 ++
 include/uapi/linux/snmp.h                     |  1 +
 net/ipv4/proc.c                               |  1 +
 net/ipv4/syncookies.c                         |  1 +
 net/ipv4/tcp_input.c                          |  1 +
 net/ipv4/tcp_minisocks.c                      | 26 +++++++++++--------
 net/ipv4/tcp_output.c                         |  6 +++++
 8 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index 90ca2d92547d44fa5b4d28cb9d00820662c3f0fd..bc96efc92cf5b888c1e441412c78f3974be1f587 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -36,6 +36,7 @@ unsigned_long  LINUX_MIB_TIMEWAITRECYCLED
 unsigned_long  LINUX_MIB_TIMEWAITKILLED
 unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
 unsigned_long  LINUX_MIB_PAWSESTABREJECTED
+unsigned_long  LINUX_MIB_TSECR_REJECTED
 unsigned_long  LINUX_MIB_DELAYEDACKLOST
 unsigned_long  LINUX_MIB_LISTENOVERFLOWS
 unsigned_long  LINUX_MIB_LISTENDROPS
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f88daaa76d836654b2a2e217d0d744d3713d368e..159b2c59eb6271030dc2c8d58b43229ebef10ea5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -160,6 +160,8 @@ struct tcp_request_sock {
 	u32				rcv_isn;
 	u32				snt_isn;
 	u32				ts_off;
+	u32				snt_tsval_first;
+	u32				snt_tsval_last;
 	u32				last_oow_ack_time; /* last SYNACK */
 	u32				rcv_nxt; /* the ack # by SYNACK. For
 						  * FastOpen it's the seq#
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 848c7784e684c03bdf743e42594317f3d889d83f..eb9fb776fdc3e50c2ecfc6b36d5472f8f65b5985 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -186,6 +186,7 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
+	LINUX_MIB_TSECRREJECTED,		/* TSEcrRejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index affd21a0f57281947f88c6563be3d99aae613baf..10cbeb76c27456ae7f220acf0a22203bad6bbc53 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
 	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
+	SNMP_MIB_ITEM("TSEcrRejected", LINUX_MIB_TSECRREJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 26816b876dd8b37626a3220da71fd697b997e147..5459a78b9809594e4c9e5a69dd1156a3e0cc06bc 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -279,6 +279,7 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 		ireq->smc_ok = 0;
 
 	treq->snt_synack = 0;
+	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
 	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 217a8747a79b5a52216dfde4b25569586eef90c8..d22ad553b45b17218d5362ea58a4f82559afb851 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7081,6 +7081,7 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->rcv_isn = TCP_SKB_CB(skb)->seq;
 	tcp_rsk(req)->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
 	tcp_rsk(req)->snt_synack = 0;
+	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	req->mss = rx_opt->mss_clamp;
 	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1eccc518b957eb9b81cab8b288cb6a5bca931e5a..4f87406ddbcd4420425c60fe4f625c7f5a2241f5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -663,6 +663,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	struct sock *child;
 	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 flg = tcp_flag_word(th) & (TCP_FLAG_RST|TCP_FLAG_SYN|TCP_FLAG_ACK);
+	bool tsecr_reject = false;
 	bool paws_reject = false;
 	bool own_req;
 
@@ -672,8 +673,13 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
-			if (tmp_opt.rcv_tsecr)
+			if (tmp_opt.rcv_tsecr) {
+				if (inet_rsk(req)->tstamp_ok && !fastopen)
+					tsecr_reject = !between(tmp_opt.rcv_tsecr,
+							tcp_rsk(req)->snt_tsval_first,
+							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
+			}
 			/* We do not store true stamp, but it is not required,
 			 * it can be estimated (approximately)
 			 * from another data.
@@ -788,18 +794,14 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	     tcp_rsk(req)->snt_isn + 1))
 		return sk;
 
-	/* Also, it would be not so bad idea to check rcv_tsecr, which
-	 * is essentially ACK extension and too early or too late values
-	 * should cause reset in unsynchronized states.
-	 */
-
 	/* RFC793: "first check sequence number". */
 
-	if (paws_reject || !tcp_in_window(TCP_SKB_CB(skb)->seq,
-					  TCP_SKB_CB(skb)->end_seq,
-					  tcp_rsk(req)->rcv_nxt,
-					  tcp_rsk(req)->rcv_nxt +
-					  tcp_synack_window(req))) {
+	if (paws_reject || tsecr_reject ||
+	    !tcp_in_window(TCP_SKB_CB(skb)->seq,
+			   TCP_SKB_CB(skb)->end_seq,
+			   tcp_rsk(req)->rcv_nxt,
+			   tcp_rsk(req)->rcv_nxt +
+			   tcp_synack_window(req))) {
 		/* Out of window: send ACK and drop. */
 		if (!(flg & TCP_FLAG_RST) &&
 		    !tcp_oow_rate_limited(sock_net(sk), skb,
@@ -808,6 +810,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			req->rsk_ops->send_ack(sk, skb, req);
 		if (paws_reject)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
+		else if (tsecr_reject)
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TSECRREJECTED);
 		return NULL;
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9a3cf51eab787859ec82432ee6eb9f94e709b292..0a660075add5bea05a61b4fe2d9d334a89d956a7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -943,6 +943,12 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
 			      tcp_rsk(req)->ts_off;
+		if (!tcp_rsk(req)->snt_tsval_first) {
+			if (!opts->tsval)
+				opts->tsval = ~0U;
+			tcp_rsk(req)->snt_tsval_first = opts->tsval;
+		}
+		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
 		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
-- 
2.48.1.658.g4767266eb4-goog


