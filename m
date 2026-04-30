Return-Path: <netdev+bounces-282754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNg+Ipgo82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:02:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6C4A06CD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6EBF301B5B9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E73D2FF7;
	Thu, 30 Apr 2026 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/xaJqoP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A13E0C45
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543241; cv=none; b=StxVYJrRvVHwV/MJGb2/qpGciI57F6VN1mofHCRIaAPk/Vbihp8yCbOtev8JK5XO2XGP8N5X00iC+RZEPqiv0ERmTnPNpDIdsxMvHIHOvxcD+oblz5Mt9VIUJcVoAnBClae2fVM3hFM+ie2gmvx9c3Ou7f6FhGl8QZyqzFN/vao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543241; c=relaxed/simple;
	bh=ZWClYsxf5muJlxF05/t6kFGuCP3ISEREq21OI+RqS0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MORJsZ7F3APf0j/hMxgCt9d6tQ+Cf3AjzepuOoU0vNLjUiDuS0UZn7cnRN5DHaW63qoi7BiF7H+3MiX+mrzNf8wzKMt3GtLp2H1v4gdUSGzDJFF/S2NObPxFZ5HrZcibN9aXaECsogdANEHkkOZBMzE3Ulyhu5lpNXkx9qvl4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/xaJqoP; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50f13da9684so6711861cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543239; x=1778148039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=43TtLx2C/4ifIFprUOzCUkAg1ejz2E8Z6pdDjUE2GE8=;
        b=J/xaJqoPVo/aaQ/xOaNXSaavC3wkTUqo3VwnZZafJADkcODwBUwHzXwgj1j9B+FUGR
         h/I5MvuvQ2fb+X8yuHUfbwbmvHPOi8TGyy6bbc/K2/l2ZE8mft8sizRLTs9YptZkiYTH
         fVGnxt/tVflVDcKVcdtFjY6ghaZimBNtEBHmXP/cddeyonxUh3zHvDT1TQ6P04fw84km
         JkUqRZXxLm9wYNU0T6HFe4CqMB7ucZc1FoqAUzqQGA3H2zZJv5a1dkLjdCkypbn605d8
         X6xwYoHEbAJWrw4da9Na3AcGJzvrWMgN7Q9Px9TIOfPAib5S6Ue12nC6gwFJvEK8JiyM
         6Zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543239; x=1778148039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43TtLx2C/4ifIFprUOzCUkAg1ejz2E8Z6pdDjUE2GE8=;
        b=rmpbFu5jU9S8eiJeI82qDLHolEXS8CDqQS+6booHd38VnHkd58OWXz2MOE3ULK0LR3
         652E1NStuV6Gt9oZJbmBFyLhqi9qMFSL4R1wNdYNOV21JLPdBLovBcxGwDUlM/akr3fL
         k6Y69gLo99ivYjD/0TxJlhnpE8eQgUHS9n22zlQgW4aRgGQOLi3jjovndbRxZK+gNy9J
         DESqkgxDyHCsx7B5fDU+fotvM7LI2R4NtW05SibF3NdHRbTmZfGwPKQqA9lU6Jh2kjPO
         J7IYLGFIwn355KzOOyOfKJAPWHh8nSR6LNk8acCyu/jDeSIHAUhQFsQdZi0OWbJn64Z3
         C7dA==
X-Forwarded-Encrypted: i=1; AFNElJ/Aytu8d7A8R6Trw9+oQr22ZmI7+CCiXC76NXPvjEG9i2rX6QMVXg2VMGNaLgBqapYXUTD5e3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyirk4gIPRou42gVG2sm9ADti0JFpGajnCwifX9aUECsvXHmg8M
	brwVnLszN7rLUFiU6a4rHFE/VgrWauC958/WA7I54VtnlKtMf+7wOujnG1WSF58O1CpBCfVDoNg
	qMckdYBDxyrhhzQ==
X-Received: from qtbbb5.prod.google.com ([2002:a05:622a:1b05:b0:509:10bb:c5b8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1116:b0:50d:9931:7054 with SMTP id d75a77b69052e-5102ab43aacmr29185471cf.15.1777543230185;
 Thu, 30 Apr 2026 03:00:30 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:20 +0000
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430100021.211139-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] tcp: move tp->bytes_acked to tcp_sock_write_tx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 96D6C4A06CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282754-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

tp->bytes_acked is touched in TX path only.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 8 ++++----
 net/ipv4/tcp.c                                       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index b914382cb8fd7ae739297180ff5101acb8dc8a14..0f6088c4ab8bb872e7fc86f02479592e84c0247a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -22,7 +22,7 @@ u32                           snd_nxt                 read_write          read_m
 u32                           segs_out                read_write          read_write          __tcp_transmit_skb
 u32                           data_segs_out           read_write                              __tcp_transmit_skb,tcp_update_skb_after_send
 u64                           bytes_sent              read_write                              __tcp_transmit_skb
-u64                           bytes_acked                                 read_write          tcp_snd_una_update/tcp_ack
+u64                           bytes_acked             read_write                              tcp_snd_una_update/tcp_ack
 u32                           dsack_dups
 u32                           snd_una                 read_mostly         read_write          tcp_wnd_end,tcp_urg_mode,tcp_minshall_check,tcp_cwnd_validate(tx);tcp_ack,tcp_may_update_window,tcp_clean_rtx_queue(write),tcp_ack_tstamp(rx)
 u32                           snd_sml                 read_write                              tcp_minshall_check,tcp_minshall_update
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e9adc88b73b43c39c734361da149ad29ef48e922..d3650f04d94251ebef6f1bae296adc33a5491768 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -255,6 +255,10 @@ struct tcp_sock {
 	__cacheline_group_begin(tcp_sock_write_tx) ____cacheline_aligned;
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
+				 * sum(delta(snd_una)), or how many bytes
+				 * were acked.
+				 */
 	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
 				 * total number of data bytes sent.
 				 */
@@ -349,10 +353,6 @@ struct tcp_sock {
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
 	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
-	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
-				 * sum(delta(snd_una)), or how many bytes
-				 * were acked.
-				 */
 	struct {
 		u32	rtt_us;
 		u32	seq;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d25698a0e6819cb4d3563461bb1ae89d5104669f..7211d2c669b8e4ac15b3a6fcfc572f7199e310cf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5233,6 +5233,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, data_segs_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, bytes_sent);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_mstamp);
@@ -5282,7 +5283,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
 }
-- 
2.54.0.545.g6539524ca2-goog


