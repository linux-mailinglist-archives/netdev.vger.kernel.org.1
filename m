Return-Path: <netdev+bounces-282750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHUhFLYq82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F090E4A08C9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D593034B08
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA13FB06D;
	Thu, 30 Apr 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKacfYwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA563DD507
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543229; cv=none; b=PUReex7ck1SFLZ5gA4JqcRsaCYsXaLZHSvXjWSpacerhOFhqaNaRSWUd5IbVmJ2cPk75HDNwDc0vt7/6iV4vIFCWOeY5AVOXy2OqMP9lfSJ8Wa3OKFpj/JZSS2c+XI3rwEIIkpyEOyHpKRwSbEirQXhx0BzrB37+rcR01YE9s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543229; c=relaxed/simple;
	bh=Oqan4uqhvChoOhQosRIHnhPq27AcSpxqCgrw4+D1S1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xl6exKw508sC+f0/duPzncSG/3CGzCwGgaEUmQ4oW3WhHtgtcuT0FOWgM0Ht8aIpSc5Y/+WUZ8irJztFcvaqBgy+VXNAcd5eDjrYqs0dhar7IWMzjlL019qNcAUpy3F+C2iUaPrIG+xCbKFKJQ5rz8J6rd6AllhOP0TWndfEQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKacfYwh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7bd5e373be0so32467b3.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543225; x=1778148025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nE2poV2xLyaBytToZrF7HqQpd1gsFiQAeyFpUeyKwH0=;
        b=uKacfYwhfkO2NIFQtWwLpQ1fPqzhSeGhNH1Dm9Hj81/9LknhqT0PkrwwH7y/sE9+U4
         SahcnKuakgahncldm5lcxerjnwrvsngItTJI1UkMYirNGuHcskzvRCZZZDKkHGfhOrPQ
         M2jX5TorvcNT/MfqgqlWVfdePyFFd7t0XYCGTlj4s3ti18KcCq501p+iWp2lUV9oGV1h
         nqyW6l0ZDOYjc0dRsR8z5C2wqt3TqyeMsiGDAhxRD7tp4vW5sqCTNXhviWX3iIvTzx8q
         LmeCV5vw5FIBJrPuX8HCkcQA6pGemOSUKzttSeHQJqD2RjvW/I+fXT4sohPKgCjsuw27
         LClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543225; x=1778148025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nE2poV2xLyaBytToZrF7HqQpd1gsFiQAeyFpUeyKwH0=;
        b=p82V7I7zz7zkt0s/VeIOewN75CSVtFdd34UNVCcgd+eNGB27oqXGBptdmxEphy1ZGH
         wLeijhC1Uy5FL02CwvaBBau8YYjtME2y2vpeMI9RQVBoe3cdh+oIm4BR4kkHoE2dN+q6
         t8fnCAwtl7/rHGh8GePAr8yr6fC7gDYcGZ5djE5YwsEqfHfRMOQbcZaOMtSVgLq1ZO9A
         WDViJSe29D1f4kYKCPbLWJK0hTmI438QwKpP+7YFtqOdbgFhQ7gceiNAYadEqKqoQQOc
         TGA8gxp566gzm+wgJPuewLWfaDOrTRMjGdh3gKZ0IGsZCStgWmZJ5y6LedHMz7jHtp25
         Z6kA==
X-Forwarded-Encrypted: i=1; AFNElJ8baK9fjBJb0KpEhQnEYCO1+lKJ/xxp/jRQxWMMmcyqAfikCgtDfQRaQ/nq+SMXUGlbwQer94Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSj7NHIMB5SPfztPwPTtuKk6XlRSd+xAUfdOxSgPcJtDd5LigF
	Gp5cdwfUr02DBWnRaW2e8zcF4Sj1dymghuuZw6GEsaCPJdwB7RRfTvwN5KQAkLH0OwauN+UTrbC
	MOeK+aRFa1QJBKw==
X-Received: from yxai10-n2.prod.google.com ([2002:a53:acca:0:20b0:652:df1f:642a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:c48:b0:654:2882:42ae with SMTP id 956f58d0204a3-65c18c7cfbcmr1613192d50.25.1777543224507;
 Thu, 30 Apr 2026 03:00:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:17 +0000
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430100021.211139-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] tcp: move tp->delivered and tp->delivered_ce to
 tcp_sock_write_tx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F090E4A08C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282750-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

These counters are changed whenever sent data is acknowleged.

They do not belong to tcp_sock_write_txrx group, because TCP receivers
do not touch them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 4 ++--
 include/linux/tcp.h                                  | 4 ++--
 net/ipv4/tcp.c                                       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index fecf61166a54ee2f64bcef5312c81dcc4aa9a124..f2eafc933b5fa6aff5222cc486c00c4dbd437f92 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -99,8 +99,8 @@ u32                           snd_cwnd_stamp
 u32                           prior_cwnd
 u32                           prr_delivered
 u32                           prr_out                 read_mostly         read_mostly         tcp_rate_skb_sent,tcp_newly_delivered(tx);tcp_ack,tcp_rate_gen,tcp_clean_rtx_queue(rx)
-u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
-u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
+u32                           delivered               read_write                              tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
+u32                           delivered_ce            read_write                              tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6982f10e826b4004f210ea22c94f0488e52184d1..3e20bffd6ae908f18c1a88ed97db78f7ea8989ae 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -259,6 +259,8 @@ struct tcp_sock {
 	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
 				 * total number of data segments sent.
 				 */
+	u32	delivered;	/* Total data packets delivered incl. rexmits */
+	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
 				 * total number of data bytes sent.
 				 */
@@ -307,8 +309,6 @@ struct tcp_sock {
 	u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
 	u32	packets_out;	/* Packets which are "in flight"	*/
 	u32	snd_up;		/* Urgent pointer		*/
-	u32	delivered;	/* Total data packets delivered incl. rexmits */
-	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
 	u32	received_ecn_bytes[3]; /* received byte counters for three ECN
 					* types: INET_ECN_ECT_1, INET_ECN_ECT_0,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4c8ef5d50339bfdf7da0ea8772b94..fe1e54321e181c307227c8f2f5a9c0fb2816c762 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5232,6 +5232,8 @@ static void __init tcp_struct_check(void)
 	/* TX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, data_segs_out);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, bytes_sent);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, snd_sml);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_start);
@@ -5258,8 +5260,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, srtt_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, packets_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
-- 
2.54.0.545.g6539524ca2-goog


