Return-Path: <netdev+bounces-282751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFj7Dbkq82mwxgEAu9opvQ
	(envelope-from <netdev+bounces-282751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 929364A08D0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D4A03036D4E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B839B4A0;
	Thu, 30 Apr 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwPT0G1w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40973D2FF7
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543231; cv=none; b=rwge8IE+NCnUzFfIPmpZlwqFpW7/OpPTfFxxmBfqDZ9pGNUoi9yhc32pvh44QsVzOdAGOceRqCfkR8gM1pT4H/z0VDVnXRWs/ftz9hlYFwdMbiTISOVme0pZBAi0pisMjMJ3ntxHAv9i/ZEVLWzCFQsc5bx1Q0rErciR9iLPtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543231; c=relaxed/simple;
	bh=yMXj1S00MY1UBQkcskifNfuad3BUzzajJKjObq/gDI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+qmP5qyH0Du1WCk6q/u0/BRiX5Oyi6hOAc2wu885e+WsPWmOEvhJnsKDt+JRjOvm2tnYFf5mJm5crGhpvlPdBKKMqJO9nhdvXyKpo4JIMpy2us/wmcwFOQ5VVWYEsNPJ+Jz/NG5w50qstC8em3e+Tw6GXr0vaTjKXvgNJzejTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwPT0G1w; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8a16036c90eso19533036d6.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777543227; x=1778148027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THX8HobTlVoJ95OQyBwd0VEqxs16+9cnJ8m75yqFpWA=;
        b=iwPT0G1wlx82lORJ4SyISz3Q2kN3iYOTF3G56a8c4DdSLgUtA8Qsx1Db8YC2As28+O
         g+OI7lVU0th0/Q3Rxa4LC5q5baIpF++8O1Jd1GCDCufrPrGFRryp+OtaPxdrBeCLbe3v
         jBU9K/rkNTyUnDrK4p+AyhgOtHeXC5vVmccSrg5jxYi1P9qjrmipr/arYm/fASRMJUdY
         ey/z4ymuHZRR1YJdJ4FrHsPHHTbMPctVvGWoql2z5+II3+X+1I7iN2O9EQL3ZzBWI6Ys
         RdQnrK5SQEAL9drK/ebzFnPKCXb4vIOQWlmc5lJgNr0ikAoTUc3CdGJ8i8Juj323lulh
         NAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777543227; x=1778148027;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=THX8HobTlVoJ95OQyBwd0VEqxs16+9cnJ8m75yqFpWA=;
        b=gxeM2caMOwQb7k4FDpAm5XIfMCNQHQYdKCxcfy6Y0A50As/1X0ZVO7vCsdm4sdZZpK
         ANU5oNy17bgPCeq5qWRgdlt8k02axrhrmcPseiD6b8aN+qUtNo2vqCqj3o9wHcxe1XWJ
         5TNKmUHc5EpwzPQRA8jAEKQlkxDTt0QFVPiCjZyw12fuWxJ7gpjT4dNkSugsPTwaiYX3
         fVLIZN04pKg63/Ym/MHk1NkooIkzEltUloQo2TfvlZtZpFH+3t/TOlVXvVfdJQ/e/xx+
         CKivhC/XnDdbZSamohAfDC6+jnZDiIoYJY+UJkYraCwpOZ3MTWBoyfZWGAHcDaKKsJBW
         +h9w==
X-Forwarded-Encrypted: i=1; AFNElJ+Cz7FrEGfIHUQkoHcgfounO1J30bAPUknWz06Op8uKYmB7i7McMwvnpp707NMbmKgwimxDulg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC5jKLCOjbkEkYLHaWL5+Jo80sg5BxeT5XJCz3IJkzAUIBcCmT
	a2+p21XDOEOu8QcvH4RMqka9qzw0ysu+AZpTdU7z8G7G8qW91v9tfNmG3qCs86eDHiiSJHl0158
	UFfLy/9F2cZhVXQ==
X-Received: from qvbok33.prod.google.com ([2002:a05:6214:3ca1:b0:89e:64a5:5d7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:610d:b0:8a3:8f4c:3b6f with SMTP id 6a1803df08f44-8b3ff0189b7mr26478106d6.51.1777543226562;
 Thu, 30 Apr 2026 03:00:26 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:00:18 +0000
In-Reply-To: <20260430100021.211139-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430100021.211139-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430100021.211139-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] tcp: move tp->segs_in and tp->segs_out to
 tcp_sock_write_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 929364A08D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282751-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.960];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

segs_in is changed for each incoming packet, including ACK packets.
segs_out is changed for each outgoing packet, including ACK packets.

They belong to tcp_sock_write_txrx group.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/tcp_sock.rst     |  4 ++--
 include/linux/tcp.h                            | 18 +++++++++---------
 net/ipv4/tcp.c                                 |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documen=
tation/networking/net_cachelines/tcp_sock.rst
index f2eafc933b5fa6aff5222cc486c00c4dbd437f92..b914382cb8fd7ae739297180ff5=
101acb8dc8a14 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -13,13 +13,13 @@ u16                           tcp_header_len          r=
ead_mostly         read_m
 u16                           gso_segs                read_mostly         =
                    tcp_xmit_size_goal
 __be32                        pred_flags              read_write          =
read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
 u64                           bytes_received                              =
read_write          tcp_rcv_nxt_update(rx)
-u32                           segs_in                                     =
read_write          tcp_v6_rcv(rx)
+u32                           segs_in                 read_write          =
read_write          tcp_segs_in(),tcp_v6_rcv(rx),tcp_v4_rcv()
 u32                           data_segs_in                                =
read_write          tcp_v6_rcv(rx)
 u32                           rcv_nxt                 read_mostly         =
read_write          tcp_cleanup_rbuf,tcp_send_ack,tcp_inq_hint,tcp_transmit=
_skb,tcp_receive_window(tx);tcp_v6_do_rcv,tcp_rcv_established,tcp_data_queu=
e,tcp_receive_window,tcp_rcv_nxt_update(write)(rx)
 u32                           copied_seq                                  =
read_mostly         tcp_cleanup_rbuf,tcp_rcv_space_adjust,tcp_inq_hint
 u32                           rcv_wup                                     =
read_write          __tcp_cleanup_rbuf,tcp_receive_window,tcp_receive_estab=
lished
 u32                           snd_nxt                 read_write          =
read_mostly         tcp_rate_check_app_limited,__tcp_transmit_skb,tcp_event=
_new_data_sent(write)(tx);tcp_rcv_established,tcp_ack,tcp_clean_rtx_queue(r=
x)
-u32                           segs_out                read_write          =
                    __tcp_transmit_skb
+u32                           segs_out                read_write          =
read_write          __tcp_transmit_skb
 u32                           data_segs_out           read_write          =
                    __tcp_transmit_skb,tcp_update_skb_after_send
 u64                           bytes_sent              read_write          =
                    __tcp_transmit_skb
 u64                           bytes_acked                                 =
read_write          tcp_snd_una_update/tcp_ack
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3e20bffd6ae908f18c1a88ed97db78f7ea8989ae..89013be1519abd1713d42f93e18=
64fb1d61d303a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -253,17 +253,14 @@ struct tcp_sock {
=20
 	/* TX read-write hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_write_tx) ____cacheline_aligned;
-	u32	segs_out;	/* RFC4898 tcpEStatsPerfSegsOut
-				 * The total number of segments sent.
-				 */
-	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
-				 * total number of data segments sent.
-				 */
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
 				 * total number of data bytes sent.
 				 */
+	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
+				 * total number of data segments sent.
+				 */
 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet *=
/
 	u8	chrono_type;	/* current chronograph type */
 	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
@@ -324,6 +321,12 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets=
).
  */
 	struct tcp_options_received rx_opt;
+	u32	segs_in;	/* RFC4898 tcpEStatsPerfSegsIn
+				 * total number of segments in.
+				 */
+	u32	segs_out;	/* RFC4898 tcpEStatsPerfSegsOut
+				 * The total number of segments sent.
+				 */
 	__cacheline_group_end(tcp_sock_write_txrx);
=20
 	/* RX read-write hotpath cache lines */
@@ -333,9 +336,6 @@ struct tcp_sock {
 				 * sum(delta(rcv_nxt)), or how many bytes
 				 * were acked.
 				 */
-	u32	segs_in;	/* RFC4898 tcpEStatsPerfSegsIn
-				 * total number of segments in.
-				 */
 	u32	data_segs_in;	/* RFC4898 tcpEStatsPerfDataSegsIn
 				 * total number of data segments in.
 				 */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fe1e54321e181c307227c8f2f5a9c0fb2816c762..135a5db6c3fcc1e33227403fd93=
76642c9826412 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5230,7 +5230,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssth=
resh);
=20
 	/* TX read-write hotpath cache lines */
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_ou=
t);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, data_se=
gs_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, deliver=
ed);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, deliver=
ed_ce);
@@ -5267,10 +5266,11 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_m=
wnd_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_t=
stamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_op=
t);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, segs_=
in);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, segs_=
out);
=20
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_r=
eceived);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, segs_in=
);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, data_se=
gs_in);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_wup=
);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, max_pac=
kets_out);
--=20
2.54.0.545.g6539524ca2-goog


