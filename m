Return-Path: <netdev+bounces-168954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF5A41C14
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C768169687
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3742580D4;
	Mon, 24 Feb 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mr+sdixR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB9247DDD
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395218; cv=none; b=iClYBjv73EPcZvjPUOrUXWSixUUTtRSb/2qON1IjP42zzebtRYGHsKFFFODhv3HCw3UNvKosT1dJS2AGGYPxkIoDzKDicZ154EBK18REPwZUxhq/dFDT2FdQqGuvM+6jRa8zBKuW2WIdDJbhFyyrdHxxNRpX2NRmwqBeYHnQ5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395218; c=relaxed/simple;
	bh=PUqb5jETLUmk2tu7N/8R89lUDLqxQzI1cLWHaAZIQTg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lWMjoYlTMYqGlfElzkpshcAcotsaD39/SUnwfjVJpFPsaOfVrXEq1LhhjQoNhfGHSCvIjPXOFAvK7W75iGefZTI09yfcCAS3cv4ntvAOWPv4fhfRNo9mjnvKql9PQf+A0e+fsnbcjeh/IimtK1QQtlmcWHFYy7bz7A+7K3C6WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mr+sdixR; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4720ca5b6bdso89326591cf.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 03:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740395215; x=1741000015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dFEE4OFOlMmuFvxADpTzBZuPGZJpkHtVsBBqBWFdM48=;
        b=mr+sdixR4FFCWOWm2FK0pnk75y3qHtj7abiu6Sj+mQJ8j0eGYR8FUu5NbQ9flb+Kyn
         o8/Ikm4xGdyu3PKr4QF8XY+jyYezFwb2ZQmaKpt4/VGVCsbtOyf0GQVFDRruGit5U2XQ
         EB8gyxrRXTFjr8xU78Jk5ciderJz/jEfrlrPILc1lf5XU/cpboRYaDaVH4BPhvQfTM+M
         QOGmTF5oXcbiouJPoIEPLGXdi5mzR8mLCMp6kmJvLl4XiZS5KPEKX1EpHX/viOgAq0lt
         KRPSyuXdgd2f0XqmSRfrH6SwWGQgJpb/o5tav1zNNQwYl7SehQGOeBvPATHbYWXUZpKE
         KzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740395215; x=1741000015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFEE4OFOlMmuFvxADpTzBZuPGZJpkHtVsBBqBWFdM48=;
        b=nwaL3efxYsGKOGCIQ+oFHOQwehkufDA0QWrfAhM/VBLv2T7862VetjnX9jFIObOmsr
         sOVDKLHlsbB3yViXSh1gxKSv0bjwM4F5+nYN4OMI8FF08p9RoYHE3QeQAvlCW6kXua1G
         oigRgAOEU1VY72oeyv0/CdeV+R9dOLwDB3PptL/K2/wu2ufPKGn88uaiHUTHxmM2sCAy
         2zlpVEixhqtv4ZsF1K459iP5sD/6VrfJ5jLV4310dJYd5ED/JvMBn+Ff/CfJoBne2rva
         zbLbDBAE09oL/aDuu64O3DnHm3/2yeH3Z7k7bgvuMmxkySKb/STfAvHrxlkSF7MJhFew
         yQrg==
X-Forwarded-Encrypted: i=1; AJvYcCUkHnAG2hRzvFZyEt6aMKYa87FAKO4fPiuQ+N5gNFF3nCo5PexbZl86O7gC0Vj+KHXkTXvvtec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rfR0SdNLJESEwlUHWiPX1f2u4cBILiT/qvpeUBvBDslbOiGV
	rrq/y+1BzDWnY/nJY9bet82e/V7URvpRKi8/bmFo+oBCWVYRH4JD25/ERWCx1YcMAvNKlXZHC2m
	UGCoHGwXvug==
X-Google-Smtp-Source: AGHT+IFQQoxT3FjLxdktnBJPK7FNAS3ufGPrtdHC5zXUsIzbmlyO2YCCYrcXQxitbGB6pjSmCYMJFiNZtV6CdA==
X-Received: from qtbay9.prod.google.com ([2002:a05:622a:2289:b0:471:f86c:c303])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:250e:b0:472:8fd:90f1 with SMTP id d75a77b69052e-472249085femr140050941cf.51.1740395215376;
 Mon, 24 Feb 2025 03:06:55 -0800 (PST)
Date: Mon, 24 Feb 2025 11:06:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224110654.707639-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yong-Hao Zou <yonghaoz1994@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
for flows using TCP TS option (RFC 7323)

As hinted by an old comment in tcp_check_req(),
we can check the TSecr value in the incoming packet corresponds
to one of the SYNACK TSval values we have sent.

In this patch, I record the oldest and most recent values
that SYNACK packets have used.

Send a challenge ACK if we receive a TSecr outside
of this range, and increase a new SNMP counter.

nstat -az | grep TcpExtTSECR_Rejected
TcpExtTSECR_Rejected            0                  0.0

Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/snmp.rst        |  1 +
 include/linux/tcp.h                           |  2 ++
 include/uapi/linux/snmp.h                     |  1 +
 net/ipv4/proc.c                               |  1 +
 net/ipv4/tcp_minisocks.c                      | 25 +++++++++++--------
 net/ipv4/tcp_output.c                         |  3 +++
 6 files changed, 22 insertions(+), 11 deletions(-)

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
index 848c7784e684c03bdf743e42594317f3d889d83f..b85dd84dda5c13471e2f62c3a4ffb11b22f787f8 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -186,6 +186,7 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
+	LINUX_MIB_TSECR_REJECTED,		/* TSECR_Rejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index affd21a0f57281947f88c6563be3d99aae613baf..2f0d2cf7cae45d824f8c506df3f83c175e794a0a 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
 	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
+	SNMP_MIB_ITEM("TSECR_Rejected", LINUX_MIB_TSECR_REJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 1eccc518b957eb9b81cab8b288cb6a5bca931e5a..a87ab5c693b524aa6a324afe5bf5ff0498e528cc 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -663,6 +663,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	struct sock *child;
 	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 flg = tcp_flag_word(th) & (TCP_FLAG_RST|TCP_FLAG_SYN|TCP_FLAG_ACK);
+	bool tsecr_reject = false;
 	bool paws_reject = false;
 	bool own_req;
 
@@ -672,8 +673,12 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
-			if (tmp_opt.rcv_tsecr)
+			if (tmp_opt.rcv_tsecr) {
+				tsecr_reject = !between(tmp_opt.rcv_tsecr,
+							tcp_rsk(req)->snt_tsval_first,
+							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
+			}
 			/* We do not store true stamp, but it is not required,
 			 * it can be estimated (approximately)
 			 * from another data.
@@ -788,18 +793,14 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
@@ -808,6 +809,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			req->rsk_ops->send_ack(sk, skb, req);
 		if (paws_reject)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
+		else if (tsecr_reject)
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TSECR_REJECTED);
 		return NULL;
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9a3cf51eab787859ec82432ee6eb9f94e709b292..485ca131091e58616b4f3076acc2ad7a478de89d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -943,6 +943,9 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
 			      tcp_rsk(req)->ts_off;
+		if (!req->num_timeout)
+			tcp_rsk(req)->snt_tsval_first = opts->tsval;
+		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
 		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
-- 
2.48.1.601.g30ceb7b040-goog


