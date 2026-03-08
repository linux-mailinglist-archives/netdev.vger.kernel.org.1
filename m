Return-Path: <netdev+bounces-265289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2VYkDSxtrWme2wEAu9opvQ
	(envelope-from <netdev+bounces-265289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 13:35:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB99230343
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9404300C5A5
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBC03624B3;
	Sun,  8 Mar 2026 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLlyJ8Px"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554691C2AA
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973352; cv=none; b=Ieatt5I+GTBhrEkwbeobt1wBwGU1cEu2A/hIKF1x/9hZC+EHpDrzkbfcS1nPpm/v0Rfk4IsV3G/81CUpYVOS3NSRfz0kjls1M3UYpXzxog5P7hapxeswmtYodr6XCdstApHjcDdlc3nGTAo+D5QCg2Wlvev60cClFVadq37M1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973352; c=relaxed/simple;
	bh=BLP4EHMTJo7ud6x3h8Y19JZoYsVURv94CowOFwFYz1w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U6sbqcHTdfzTuoP39l3Acq7+Sjcm99BifYR5eneLaI02WEPgG9V+3m63exEqvatsFq+dqXKRiHjPcF6YNaAiK8lFlRtqIdQpGR0stTwNguFyElwuCCZAACcGAGMAqmeTEsbF22ichMGaMr31AVVfIDkJIa7DlYAaJ04l0zgPYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLlyJ8Px; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-509159f57e0so22414971cf.3
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772973350; x=1773578150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcMOggaXpxvb+Fj/Bqdg+kK6E9wWEk+cp48WrjgSzTE=;
        b=pLlyJ8PxRqADY5+KgapdERjtT/uAG+8pdGQXuRbzTJ1AV5YcrvcRW6eRUK7S4d09j9
         iuAsc9Y3OdWDwc2XLR1fCX7rhKq2E9OrfC1J6xFNDXDP/42AqVD/CNZqFQJ1inBslBT7
         18U8yHrAtHDZANXvy944q0fgE1W8cxMaYUj2SDSxdgV5RGES/+mRxomx6p807yCzZvMu
         4EOfIVojr1JqpE+mU4sqQ8hyRcF4DA4+sVcNnAKew9oHb6ix4ECWz40ht1kFcoUk0O6v
         qZ0A0b3JeaG9ycXHGOkLCTEUX3xd5qUZN/2926MJdDCtig5elTu8dloIYDtOH+GFcl7Z
         NVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772973350; x=1773578150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcMOggaXpxvb+Fj/Bqdg+kK6E9wWEk+cp48WrjgSzTE=;
        b=ArGw/VitsHO5PqErM4UPEE9sjFliKVJJ0T7SAzImM7yntXV6nt5/PrryubHUxPj8ZE
         qUxnMsTY2PRybuxyu8qgUN9TFnQjQnwGndDysYlk2+AeyGY8Phf2sb6wM4phnjtFXmAO
         nfSO8tJsUytI4FNAhFTuQtrzyzrtGATPwBpMBhOp1WcsHMujCsdz/lvNSOvV05BoVDdh
         p8JHJAR2F61i9grJjDtLT4FCsNTw88LYWJfFY33xWMvGEJhcb01OBD3PUpxEaE7zRdJa
         SRkzD/QPIfYD+U4AK7X1uS5vIL+usVyRJXQ6YKHaiBXCQ7KZX4PqvbKP2FM3EC6B0owi
         ng9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXryADrd0VG5gKdiHh2dpMlWL1NHumQ/xahcfkhNVISi9onlC6oIh7qX3psYwwq3q52EljuuOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVXqwf/k4+Mx4OthkgkUlIZmtkt028x7hd8zxB3lDt8LvFfmX
	MDfVh1SAHrRalnNts+fELLx5/MaiOHTAw7l3bQS0T+14QwNj7hXIW+/odWWvJnFROSu6UOJPAOh
	2RdcBRyLgiMh+3A==
X-Received: from qttt15-n1.prod.google.com ([2002:a05:622a:aa0f:10b0:503:301c:93fc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1308:b0:506:9944:8cfe with SMTP id d75a77b69052e-508f46c90e3mr104817931cf.15.1772973350149;
 Sun, 08 Mar 2026 05:35:50 -0700 (PDT)
Date: Sun,  8 Mar 2026 12:35:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308123549.2924460-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: inline tcp_chrono_start()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6AB99230343
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265289-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

tcp_chrono_start() is small enough, and used in TCP sendmsg()
fast path (from tcp_skb_entail()).

Note clang is already inlining it from functions in tcp_output.c.

Inlining it improves performance and reduces bloat :

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 1/-84 (-83)
Function                                     old     new   delta
tcp_skb_entail                               280     281      +1
__pfx_tcp_chrono_start                        16       -     -16
tcp_chrono_start                              68       -     -68
Total: Before=25192434, After=25192351, chg -0.00%

Note that tcp_chrono_stop() is too big.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 25 ++++++++++++++++++++++++-
 net/ipv4/tcp_output.c | 24 ------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a6464142380696e4948a836145ac7aca4ca3ec15..392a1de0d3703b3535431bfd90732186bede3bd7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2160,7 +2160,30 @@ enum tcp_chrono {
 	__TCP_CHRONO_MAX,
 };
 
-void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type);
+static inline void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new)
+{
+	const u32 now = tcp_jiffies32;
+	enum tcp_chrono old = tp->chrono_type;
+
+	if (old > TCP_CHRONO_UNSPEC)
+		tp->chrono_stat[old - 1] += now - tp->chrono_start;
+	tp->chrono_start = now;
+	tp->chrono_type = new;
+}
+
+static inline void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	/* If there are multiple conditions worthy of tracking in a
+	 * chronograph then the highest priority enum takes precedence
+	 * over the other conditions. So that if something "more interesting"
+	 * starts happening, stop the previous chrono and start a new one.
+	 */
+	if (type > tp->chrono_type)
+		tcp_chrono_set(tp, type);
+}
+
 void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type);
 
 /* This helper is needed, because skb->tcp_tsorted_anchor uses
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..00ffb09d2c624ffb82488fd57dc5daca8a31c96f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2904,30 +2904,6 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	return false;
 }
 
-static void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new)
-{
-	const u32 now = tcp_jiffies32;
-	enum tcp_chrono old = tp->chrono_type;
-
-	if (old > TCP_CHRONO_UNSPEC)
-		tp->chrono_stat[old - 1] += now - tp->chrono_start;
-	tp->chrono_start = now;
-	tp->chrono_type = new;
-}
-
-void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	/* If there are multiple conditions worthy of tracking in a
-	 * chronograph then the highest priority enum takes precedence
-	 * over the other conditions. So that if something "more interesting"
-	 * starts happening, stop the previous chrono and start a new one.
-	 */
-	if (type > tp->chrono_type)
-		tcp_chrono_set(tp, type);
-}
-
 void tcp_chrono_stop(struct sock *sk, const enum tcp_chrono type)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.53.0.473.g4a7958ca14-goog


