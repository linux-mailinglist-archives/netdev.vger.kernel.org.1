Return-Path: <netdev+bounces-256120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOvNCRSDgWlNGwMAu9opvQ
	(envelope-from <netdev+bounces-256120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:09:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4CD4941
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D87FC300C33A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BF328263;
	Tue,  3 Feb 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IGBnBf9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37B34B1A5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095377; cv=none; b=j69AYLTZ/eV00nBl0TOsOC3Ves/xXzAAGS3C4EPdNvfFsp+c9WXHMk/bP0mpWzzxQdf1nLWuX2dEwfLctGhK8u/SrsqpmfSvjlFGvhnz36uKZFwDKl2ZhCHamcChq3/OSR0zenTFcoxMY7FkugNuHtMADkBM0eA5gZ8nm/nS+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095377; c=relaxed/simple;
	bh=ohtuwr/MfO9H97hAXFTvl0Gc4d0vGJoX+527vhJMTTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hG926toBDgMcoEUoDtGdUxjw/wEA4dkF7RD217NruX/EAcY9DY24SHXteSqyQVxNC2WyZm77hT6Q6FRF7HJnmsSPY3+iJYMdgJ1Bo8p37BdulF+LRNdR/u5x3qVP8OVsEkZFGBckhWlZak+Aa6wBimQqVKYdHqOt/v3TwZURYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IGBnBf9s; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c882774f0dso238859685a.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770095374; x=1770700174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=brTOy9a+S7qRtFGyoJyJDBz+7iLljsJDV0XzwAxRkAs=;
        b=IGBnBf9sfK4u9/ZmQC0vOKtdyMCONz5h3o6moQPyrUsy5q/GkCXUZfS8q1bF+ozynU
         JZm4t7eKRLIlPVYtS9jXlqkNxASpOZSutSIT13DMQRWHnGfT4yMpCM5R46d2kU0CJ9XM
         KamOXFlNctawYJ7sFrRGdPnCR6AzKM1KOnBEhm1wraP7+r+DHteznJ5wRieQhASucKad
         5VNpBzZQVZQSXmSTgTv5XyO8Uzbj0dAyKwRfflIROQpMFzN9NhznHCKbZZQJJmNRw2ow
         aAYpkkiPxpu96hFkd4WpXwPB7jLQYBCLL+tbJCZQqOxi8QHsuTLCJqVjh8AL3umJYB0f
         u6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095374; x=1770700174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brTOy9a+S7qRtFGyoJyJDBz+7iLljsJDV0XzwAxRkAs=;
        b=P7JBrNU/SZdW1j6IEHf7jyn7xyI2NMjtsvfJiNW1XpPWNLfSulgUgFFA19CsiBn/Iv
         wRC/OxkZqmnj6wNbujGvloeC9PPyQ5aXL9l9M2KSJ+qd/a5wr8hqGpeAf8TYJAaa1ZdC
         oenH2vXD9L8Q+tvnxkaTQGCMae3Ttlz771EuiUVH4P7CdcnVNWMnpN3mPq/AIiEYWIwp
         74XWwF4E44Or/xeo3JfOdlThavyEP7gFzByishSZ6XC0S3QUF7TCx1GQXndyxv2nS23B
         JTwe93dj/RKLPG0YejLvCwlZcbpbJTX2ypaFkWx11eVaAnPrw6u+fwVdu6pilRJEXRK8
         GkNw==
X-Forwarded-Encrypted: i=1; AJvYcCWv+dOt8lulo8vavZHrJw1dyig60JSGEr3SXRmY8d11lUwvSBQEmqTq1XZJOOg04saEjLAbURQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75IWRcWwRBK5NJASkZFejMI1a5UZV+cuuM45kgBgi1vFtPh2N
	nB3U8IBhlOnSMDaWIl1eP6SkXLKGa1DyHYQuZSfSU6IoyiIF8ZIZj6cANTpxsK1D0h22VxnA9gj
	CKTbcpr36h3T/sA==
X-Received: from qkgv2.prod.google.com ([2002:a05:620a:a82:b0:8c7:f62:2219])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7084:b0:8c2:e8b3:7c3a with SMTP id af79cd13be357-8c9eb37c7f6mr1735613285a.87.1770095374580;
 Mon, 02 Feb 2026 21:09:34 -0800 (PST)
Date: Tue,  3 Feb 2026 05:09:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203050932.3522221-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: split tcp_check_space() in two parts
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256120-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 72C4CD4941
X-Rspamd-Action: no action

tcp_check_space() is fat and not inlined.

Move its slow path in (out of line) __tcp_check_space()
and make tcp_check_space() an inline function for better TCP performance.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/2 grow/shrink: 4/0 up/down: 708/-582 (126)
Function                                     old     new   delta
__tcp_check_space                              -     521    +521
tcp_rcv_established                         1860    1916     +56
tcp_rcv_state_process                       3342    3384     +42
tcp_event_new_data_sent                      248     286     +38
tcp_data_snd_check                            71     106     +35
__pfx___tcp_check_space                        -      16     +16
__pfx_tcp_check_space                         16       -     -16
tcp_check_space                              566       -    -566
Total: Before=24896373, After=24896499, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    | 10 +++++++++-
 net/ipv4/tcp_input.c | 13 ++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index cecec1a92d5e..0da2cea7a676 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -762,7 +762,15 @@ void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
 void tcp_done_with_error(struct sock *sk, int err);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
-void tcp_check_space(struct sock *sk);
+void __tcp_check_space(struct sock *sk);
+static inline void tcp_check_space(struct sock *sk)
+{
+	/* pairs with tcp_poll() */
+	smp_mb();
+
+	if (sk->sk_socket && test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		__tcp_check_space(sk);
+}
 void tcp_sack_compress_send_ack(struct sock *sk);
 
 static inline void tcp_cleanup_skb(struct sk_buff *skb)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 10f864179982..500e1c922c7e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6089,16 +6089,11 @@ static void tcp_new_space(struct sock *sk)
  *    small enough that tcp_stream_memory_free() decides it
  *    is time to generate EPOLLOUT.
  */
-void tcp_check_space(struct sock *sk)
+void __tcp_check_space(struct sock *sk)
 {
-	/* pairs with tcp_poll() */
-	smp_mb();
-	if (sk->sk_socket &&
-	    test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
-		tcp_new_space(sk);
-		if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
-			tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
-	}
+	tcp_new_space(sk);
+	if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 }
 
 static inline void tcp_data_snd_check(struct sock *sk)
-- 
2.53.0.rc1.225.gd81095ad13-goog


