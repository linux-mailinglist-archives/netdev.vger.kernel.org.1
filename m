Return-Path: <netdev+bounces-282189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBbnB6Nj8WnhgQEAu9opvQ
	(envelope-from <netdev+bounces-282189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BF48E173
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 857DF3019BAC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2835AC0C;
	Wed, 29 Apr 2026 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch52RqRd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321034CFA1
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427358; cv=none; b=UYtchH6Tx5sw9H9CkYwJpv2WbatCUwpj09Y8dLQFmpm8chWfuXJJ3GN4rxgr+h8aWuzNIGt0y7piyXkhMrEG6M/1+aA7L/lpKgOLiaIn/n8AiV2OAftaLvAORvZOjhcMJzFIwaeJb4WSCRKYaRp97RrPvLgYc9Unv0EO62K6H4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427358; c=relaxed/simple;
	bh=WjOvNm/TKReKmZOdR7SDTbrz/R6NmleNO5CAcd1D+tk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YPUBRulvRsjB9um/JlPS8s4y2+u8x3rmBGLxAlRg8VT3pdB8MnKhKu/JcISmbeY5PJtepgOjg+xY5/J8fEets1OlAOQy4bSQoLsbtmSCP/7D4zqA1Ukci6cxx0JVsL2OkismAqRkZRYr/AJjK6vYay8i2aaPxNcuMcpunOPDr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ch52RqRd; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8eb52a22e85so2286609885a.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777427355; x=1778032155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yd/OcuF12mo6zDv2fgwGElQ1AJoZ3zDU1tnn8bv6lBk=;
        b=Ch52RqRdvJU6UrQkp/dbg1FidTfIwyVrvern+/vpn6KvkGQfnEt24bOCl7w5vcYmQe
         S70OrHdk0vAIEEoE8E+bjDT4RFTnxK7Hiq6x1d9apt+qWwDuB6aNgRPy+NnZxJ3102cv
         +yYi2U0dOF8Gc6wfmnFPrXMGA5e+XaE0FPmQMZ50tkgB4PCkTnycuHJw/sPPVEGBnEGN
         M7IDYL6rbgWPP+Ec2O5Xp7QuOsWOF/lCe6OpKa39vPOp5xxom91S29vjDuNYLSXhyXB8
         LjDkfql9xMFb6MzXrSkY55yImUQeKvy+CO7U1XDcPl1xgwelElDxm84EOOV+bklbtZKe
         D3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777427355; x=1778032155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yd/OcuF12mo6zDv2fgwGElQ1AJoZ3zDU1tnn8bv6lBk=;
        b=KIC6h6HXT6J1C8qYX08UQ1io5GoXH9/RsytN+wsi1e3E0zVJWGjPMpO7knf5Uvpsb6
         6xL89366PZQrDRP9gsqMFKTaN+TardKC3PyjXG1bGUI+KB5lZ1WdjIYZYloW1/OQ4CPv
         deydFf5SyzO7wjjk5zj88jYvxjazUnXA5Sc+ySoYQYjWtU9CPHAAUZVfmncPyBi0SncJ
         ubrKVO8ZS9PgHxnFVkd7Qp9pW5ws9WVq0ecEpM13dN3mHLft3aes6fL9fiU4gwbLgRkH
         UWglO+vhdf1ucKruuHcYut8nNE4WmjFfr0dteKCHJiWdKm3KmTFDrknF+6xgg3w5lNhm
         MH8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LVyttr52Cguft3gnVr4r1dmXggKgoKSyHOUzGpGt2KmIDDiL+LB14bC3iF406vDxGrVRe/CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQkU0QpqE00lN8EnoSADc7ZNMMHoUHoSwMM7m6kVbfJIAvOpB
	yTaWdGSZDQkoy9qZdvnkSJId3gzLl0wewHuN81zZ4VUqneYksVRxuvrXHOwVxBU5BSgA2fOz3ah
	Z5scxLzZ/hjfWDg==
X-Received: from qknro11.prod.google.com ([2002:a05:620a:398b:b0:8eb:29c3:b17b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4101:b0:8f1:7ce7:5aee with SMTP id af79cd13be357-8f7d803099amr860825085a.26.1777427354704;
 Tue, 28 Apr 2026 18:49:14 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:49:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429014913.1043836-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: add sk->sk_synq_overflow_ts
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 669BF48E173
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
	TAGGED_FROM(0.00)[bounces-282189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

tcp_synq_overflow() and tcp_synq_no_recent_overflow() are currently
using tp->rx_opt.ts_recent_stamp to store a 32bit jiffie value.

Use instead full "unsigned long" storage, as an union with sk->sk_stamp
which is not used by a TCP listener.

As a bonus, we can remove time_between32() from include/linux/time.h.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/time.h         | 13 ---------
 include/net/sock.h           |  5 +++-
 include/net/sock_reuseport.h |  2 +-
 include/net/tcp.h            | 56 ++++++++++++------------------------
 4 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 16cf4522d6f338176f1fa753360e8bdec2c7bc8d..7554e44ea4a9472d306c770e2e6d2907ef5f244a 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -84,19 +84,6 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
 #define time_after32(a, b)	((s32)((u32)(b) - (u32)(a)) < 0)
 #define time_before32(b, a)	time_after32(a, b)
 
-/**
- * time_between32 - check if a 32-bit timestamp is within a given time range
- * @t:	the time which may be within [l,h]
- * @l:	the lower bound of the range
- * @h:	the higher bound of the range
- *
- * time_before32(t, l, h) returns true if @l <= @t <= @h. All operands are
- * treated as 32-bit integers.
- *
- * Equivalent to !(time_before32(@t, @l) || time_after32(@t, @h)).
- */
-#define time_between32(t, l, h) ((u32)(h) - (u32)(l) >= (u32)(t) - (u32)(l))
-
 # include <vdso/time.h>
 
 #endif
diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c3687056b67c8de44fce9842dcc365ec..ed1e52de43c3394fae74f45a85527dec08c7ec48 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -548,7 +548,10 @@ struct sock {
 	struct pid		*sk_peer_pid;
 	const struct cred	*sk_peer_cred;
 
-	ktime_t			sk_stamp;
+	union {
+		ktime_t		sk_stamp;
+		unsigned long	sk_synq_overflow_ts; /* tcp_synq_overflow */
+	};
 #if BITS_PER_LONG==32
 	seqlock_t		sk_stamp_seq;
 #endif
diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6e4faf3ee76fbd86e2c4ac6ff13ead5c9a9187d6..a6beda5dca40777e27ef071d777081fd8af6ea03 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -20,7 +20,7 @@ struct sock_reuseport {
 	/* The last synq overflow event timestamp of this
 	 * reuse->socks[] group.
 	 */
-	unsigned int		synq_overflow_ts;
+	unsigned long		synq_overflow_ts;
 	/* ID stays the same even after the size of socks[] grows. */
 	unsigned int		reuseport_id;
 	unsigned int		bind_inany:1;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a7446cb18c245e670ba49ff574dfaff7..78ca1e336321da50953e6268c4a5d5185eb7791a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -634,56 +634,38 @@ struct bpf_tcp_req_attrs {
  */
 static inline void tcp_synq_overflow(const struct sock *sk)
 {
-	unsigned int last_overflow;
-	unsigned int now = jiffies;
-
-	if (sk->sk_reuseport) {
-		struct sock_reuseport *reuse;
-
-		reuse = rcu_dereference(sk->sk_reuseport_cb);
-		if (likely(reuse)) {
-			last_overflow = READ_ONCE(reuse->synq_overflow_ts);
-			if (!time_between32(now, last_overflow,
-					    last_overflow + HZ))
-				WRITE_ONCE(reuse->synq_overflow_ts, now);
-			return;
-		}
-	}
+	unsigned long last_overflow, now = jiffies;
+	struct sock_reuseport *reuse;
+	unsigned long *ptr;
+
+	reuse = sk->sk_reuseport ? rcu_dereference(sk->sk_reuseport_cb) : NULL;
+	ptr = reuse ? &reuse->synq_overflow_ts : &((struct sock *)sk)->sk_synq_overflow_ts;
+	last_overflow = READ_ONCE(*ptr);
 
-	last_overflow = READ_ONCE(tcp_sk(sk)->rx_opt.ts_recent_stamp);
-	if (!time_between32(now, last_overflow, last_overflow + HZ))
-		WRITE_ONCE(tcp_sk_rw(sk)->rx_opt.ts_recent_stamp, now);
+	if (time_after(now, last_overflow + HZ))
+		WRITE_ONCE(*ptr, now);
 }
 
 /* syncookies: no recent synqueue overflow on this listening socket? */
 static inline bool tcp_synq_no_recent_overflow(const struct sock *sk)
 {
-	unsigned int last_overflow;
-	unsigned int now = jiffies;
-
-	if (sk->sk_reuseport) {
-		struct sock_reuseport *reuse;
-
-		reuse = rcu_dereference(sk->sk_reuseport_cb);
-		if (likely(reuse)) {
-			last_overflow = READ_ONCE(reuse->synq_overflow_ts);
-			return !time_between32(now, last_overflow - HZ,
-					       last_overflow +
-					       TCP_SYNCOOKIE_VALID);
-		}
-	}
+	unsigned long last_overflow, now = jiffies;
+	const struct sock_reuseport *reuse;
+	const unsigned long *ptr;
 
-	last_overflow = READ_ONCE(tcp_sk(sk)->rx_opt.ts_recent_stamp);
+	reuse = sk->sk_reuseport ? rcu_dereference(sk->sk_reuseport_cb) : NULL;
+	ptr = reuse ? &reuse->synq_overflow_ts : &sk->sk_synq_overflow_ts;
+	last_overflow = READ_ONCE(*ptr);
 
 	/* If last_overflow <= jiffies <= last_overflow + TCP_SYNCOOKIE_VALID,
 	 * then we're under synflood. However, we have to use
 	 * 'last_overflow - HZ' as lower bound. That's because a concurrent
-	 * tcp_synq_overflow() could update .ts_recent_stamp after we read
-	 * jiffies but before we store .ts_recent_stamp into last_overflow,
+	 * tcp_synq_overflow() could update synq_overflow_ts after we read
+	 * jiffies but before we store synq_overflow_ts into last_overflow,
 	 * which could lead to rejecting a valid syncookie.
 	 */
-	return !time_between32(now, last_overflow - HZ,
-			       last_overflow + TCP_SYNCOOKIE_VALID);
+	return !time_in_range(now, last_overflow - HZ,
+			      last_overflow + TCP_SYNCOOKIE_VALID);
 }
 
 static inline u32 tcp_cookie_time(void)
-- 
2.54.0.545.g6539524ca2-goog


