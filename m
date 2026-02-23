Return-Path: <netdev+bounces-259977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHFHKWconGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:13:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BF174A47
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C128A3059AFC
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A5035B621;
	Mon, 23 Feb 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dr/L5iTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53535B62D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841255; cv=none; b=up11+LzagmJFBVaohA6wz78NaJc9beWQ75dW9RrztzaYC4nBDFF1qQ735/P033dxzrjkY150MG1Xy4CxCnn8xxleKQEl9/T/M2tEZjJvpbA3QADs42Bo95cn0wOCdU7dbb6TT52zEDRnAv0SZ8ra1248bJIpiBryqH0I6LMlrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841255; c=relaxed/simple;
	bh=q4vqkAmVyVScfhM43LxyCyo0XqJUyZIFMaw9FNm2DB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YKPkK88wxUBzXyWEu2kHWeRd8Moits9lWv9c/jot5LeEALKU/Ukzlm2TV99CbCH7zI1Vz76hp/8F6qlW77eGjvTh571wCI875Zjn07eZil5nrpdQOg03V8dUXuJEBlv2SRCGsIKvuISy6EbJ1/kPngYCWkQcBYQGG8/xwnGcC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dr/L5iTg; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb4a241582so3900431685a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841253; x=1772446053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UOjtJeBCsbUXbwL85nwJY1K4EvPDQQKV+2WTQ7NQYg=;
        b=Dr/L5iTg1uTFNchfghMP/GDg+lNf8IM3ry7wjT7rof6+k9/nzK7v3RJi6GIt4x9BRN
         SYq0Agq1AKsyznw/vZVlHBUoXpOFjGFIaVhtYoWYLtwhImPdikJE5FRZswjxJuBJwYSK
         f8cYLRQyZ69h8obc7KSqE8oO+tJosJPhU+rb4+/MzO4mz4D6Pu7lGvPJ0LpI3M+zlmcc
         NSx9ld+QO8wteeqeLN0lqhy1HaNNIoYGi9075E2t/Xl0H5eYwcp/d4u5nu7k3f7Mg5mq
         LqGIy7cq2vw3zMK5jfupTJO5k1H/K/6bg5zLe+ynnC0eCc2EkOshu79nTMrAY+E3WiNw
         VYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841253; x=1772446053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UOjtJeBCsbUXbwL85nwJY1K4EvPDQQKV+2WTQ7NQYg=;
        b=OFUFn5Mrmokq4mMm+tm0T1XPsV74f0sZXuAzP1bh0Ue6dhz8mvSkoOxLTnUruLITAJ
         0TJMuBKBYye1lezIy7M8rBx3VmYoA1GX+tGARZF/lBIt5g3y6rGsxp2WSJH87XjQekvy
         gLLJi1n7GkC6Z7VfnHGCL4OBOyQ0f1BqJ5bnoJoio12FIh66aBEGJIh2k8GiJOo5cOOa
         988mWX7W/pl5OnhxKTRVG1MD9AmK/mO+q2zGtUEpFgNljBBQh9IsxVQXdiBiZ1IF3J9c
         xdK5DeuNj92MnQzY+fV4XV7/7LfPcz57O4n9l3M0ywm2T+RCzsm96MYt2BVdlkyHL2vT
         VIBg==
X-Forwarded-Encrypted: i=1; AJvYcCVq3aDcgLF8nrg9+o3PMxmWGhJIPwArHB0T862sF4XTq31RK4PCK/xJ1EKemA92PQwaD6Hunno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwOf50q1NK9tNpg2MDmwAJnEOfm9VqoNFLgPEh/2/rez/koFz
	md5CTk0+mVM8RP9yNorEuE3jIHR2x7a4d+PVSIfVVrq0+r8QAOCSSd3g/Z/CH7RS72U5yT2CNzJ
	TphJfZi0QKSFTxQ==
X-Received: from qkntr4.prod.google.com ([2002:a05:620a:2d84:b0:8cb:5ab6:5a6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bc2:b0:8cb:e00:8c0d with SMTP id af79cd13be357-8cb8ca854damr864187685a.74.1771841252585;
 Mon, 23 Feb 2026 02:07:32 -0800 (PST)
Date: Mon, 23 Feb 2026 10:07:27 +0000
In-Reply-To: <20260223100729.3761597-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223100729.3761597-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] tcp: inline __tcp_v4_send_check()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259977-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 379BF174A47
X-Rspamd-Action: no action

Inline __tcp_v4_send_check(), like __tcp_v6_send_check().

Move tcp_v4_send_check() to tcp_output.c close to
its fast path caller (__tcp_transmit_skb()).

Note __tcp_v4_send_check() is still out-of-line for tcp4_gso_segment()
because it is called in an unlikely() section.

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-9 (-9)
Function                                     old     new   delta
__tcp_v4_send_check                          130     121      -9
Total: Before=25143100, After=25143091, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 10 +++++++++-
 net/ipv4/tcp_ipv4.c   | 18 ------------------
 net/ipv4/tcp_output.c | 10 +++++++++-
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..3c84433f3d57b1bb29b10f41a5d9981145134237 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2382,7 +2382,15 @@ void tcp_gro_complete(struct sk_buff *skb);
 static inline void tcp_gro_complete(struct sk_buff *skb) { }
 #endif
 
-void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
+static inline void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr,
+				       __be32 daddr)
+{
+	struct tcphdr *th = tcp_hdr(skb);
+
+	th->check = ~tcp_v4_check(skb->len, saddr, daddr, 0);
+	skb->csum_start = skb_transport_header(skb) - skb->head;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+}
 
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6264fc0b2be53854598d7c37ce1c7928d2e0b507..da708aff06230615bdc9cc19fcd8b2bd91462eff 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -661,24 +661,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	return 0;
 }
 
-void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr)
-{
-	struct tcphdr *th = tcp_hdr(skb);
-
-	th->check = ~tcp_v4_check(skb->len, saddr, daddr, 0);
-	skb->csum_start = skb_transport_header(skb) - skb->head;
-	skb->csum_offset = offsetof(struct tcphdr, check);
-}
-
-/* This routine computes an IPv4 TCP checksum. */
-void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
-{
-	const struct inet_sock *inet = inet_sk(sk);
-
-	__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
-}
-EXPORT_IPV6_MOD(tcp_v4_send_check);
-
 #define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
 
 static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d02fc396753d56f210f9d3007c7f..29056d6fc787ec4ad4e3126634e5d52dacf6d700 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1496,7 +1496,15 @@ static void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb)
 
 INDIRECT_CALLABLE_DECLARE(int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl));
 INDIRECT_CALLABLE_DECLARE(int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl));
-INDIRECT_CALLABLE_DECLARE(void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb));
+
+/* This routine computes an IPv4 TCP checksum. */
+void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
+{
+	const struct inet_sock *inet = inet_sk(sk);
+
+	__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
+}
+EXPORT_IPV6_MOD(tcp_v4_send_check);
 
 /* This routine actually transmits TCP packets queued in by
  * tcp_do_sendmsg().  This is used by both the initial
-- 
2.53.0.345.g96ddfc5eaa-goog


