Return-Path: <netdev+bounces-282753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO2CEIko82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:01:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B34A06B7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D642B30197F3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA173FB7C8;
	Thu, 30 Apr 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYfyKuxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B93DCD94
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543236; cv=none; b=cc0/d7ax6zPuaB0S76m49YkC72Z+Cbng1QWFppShRSlCY+pF1UEokWNgVPGQTuF0cPYfS8bepfb/LbIXDPoelowauU+SJbdKCQiCF3zgaF+FnvJZOy+CS+33Xk79OgCcNAe8fhYuGrqTdhjiFgwL9B6jcwLEaXeXOEwKkQRm4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543236; c=relaxed/simple;
	bh=2Vbgv/CC5GbKVJSeYxcn3qPklec+6l2n1AWxgb11ca0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPfzXHn1qKv99tcJZJ5QmrAbI6u1//CWsA52NYUU80v6Qe4GoGhkttdX8qA/zuM7qNsl8sImw0ntdOZshWAdEmfAcIMnLgj2OCpaD6mn+OLW/Q0e59fzT0WWpFFda44W7oNplX2eic74jmnHMmTqIna9RA2iqIALaH/IjeA4WGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYfyKuxZ; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-649df163c11so876176d50.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543232; x=1778148032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qITK4+/8MPDr2MQdI4k0vatR/xGtON7ApqXrXvYHCeQ=;
        b=MYfyKuxZyS5Enp+OlMsQjeQ/ZuZyBtN8eZf6j+BPyeXAf89okkiuyu3s0uEEg18Isc
         l/4D4bOkRWOiYwS34xmSTYQj6ADIouhOzs+ZxviotXtHdl7ati+VowCc165jmvOg5Fzx
         KeciJgRy0cl2EyQs3XTRIvelFUZqGlngkPw/Ez3C8FNEIshZY02nvIXE51WB6T1oruP9
         CanMCR3PtReB8qpuR2ushKsclM9HfuwANCj9tYWTmPzELBQwDaB+dtfprdgcVJE+u0kM
         2fn5fAkjD+bNwaHvedA6te2gt3PhqoPRLOk6oFJTYtKZwILStLXhtJ0fcVjBKEjGcowx
         D+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543232; x=1778148032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qITK4+/8MPDr2MQdI4k0vatR/xGtON7ApqXrXvYHCeQ=;
        b=nWMrG4rS7pFNn5AThZEW5r/1vyGq3ZQItqYR3MtTQP9P7NAX+nBLs0/TE7BrpMSSKl
         4OELr0zblw4fbSkNYMiXKG2Ct99tstxeiprxDpdb0WG4syWtbb1NCmjsDCOcIWkeUYaR
         XSZwHymRVOn4xFVl3du6LSHgaVkhYkFK0ORS8oDFLHG9pWS+RjGDb4FCYMk0sQZBaKgA
         TYIqHrxZiPNMpM+8uKL+cvpX7ymDR470t14k948Ay3+3xoaNR6s7sOULCbzKuW78ripQ
         QzyRzvZ8J3Tf3PeYA0rpyFESPKkwpS1B55oRbAUAdx3oEkagM9XvfgqQ7f0YAxXe+wM/
         NOVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tL37cY7SkDWGBKOqxUX+8jz8uVsepTm5+6hrHvmqGWVfL7opTSh4a1u5YVKKTh1nj63azb/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGFo9CFvMYtsekLSKbJEzRrq8DStmfgVREMwlBDB/MXx6J/rv
	7qqz6AoWQnouL3P57IDL27NjpWirDI5Fcxpd/zJ7nfohHUPbNoOZA/wqNd6fxt2W9JJlpv201hK
	uQY+twQjLtBm5Fw==
X-Received: from yxba10.prod.google.com ([2002:a05:690e:c4a:b0:651:aacc:eeb4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:2451:b0:649:ed08:1a01 with SMTP id 956f58d0204a3-65c18de27b4mr1082747d50.35.1777543232334;
 Thu, 30 Apr 2026 03:00:32 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:21 +0000
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430100021.211139-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] tcp: move max_packets_out, cwnd_usage_seq,
 rate_delivered and rate_interval_us to tcp_sock_write_tx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BA3B34A06B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282753-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet.google.com:query timed out];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

These fields are used in TX path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 8 ++++----
 net/ipv4/tcp.c      | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index d3650f04d94251ebef6f1bae296adc33a5491768..8a6807082672a48a62292fc9ba9776297c7cc670 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -276,6 +276,10 @@ struct tcp_sock {
 	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
+	u32	max_packets_out;  /* max packets_out in last window */
+	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
+	u32	rate_delivered;    /* saved rate sample: packets delivered */
+	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
@@ -346,10 +350,6 @@ struct tcp_sock {
 				 * total number of data segments in.
 				 */
 	u32	rcv_wup;	/* rcv_nxt on last window update sent	*/
-	u32	max_packets_out;  /* max packets_out in last window */
-	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
-	u32	rate_delivered;    /* saved rate sample: packets delivered */
-	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
 	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7211d2c669b8e4ac15b3a6fcfc572f7199e310cf..21ece4c7161216093e15b295b0a79db23ad406ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5247,6 +5247,10 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, max_packets_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, cwnd_usage_seq);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rate_delivered);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
@@ -5276,10 +5280,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, data_segs_in);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_wup);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, max_packets_out);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, cwnd_usage_seq);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_delivered);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
-- 
2.54.0.545.g6539524ca2-goog


