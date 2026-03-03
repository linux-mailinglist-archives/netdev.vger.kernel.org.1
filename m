Return-Path: <netdev+bounces-263378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIisG7Eyp2kjfwAAu9opvQ
	(envelope-from <netdev+bounces-263378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:12:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2654A1F5BDF
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D3CF3043BC3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FECA4921A8;
	Tue,  3 Mar 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="is6di2Tf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9036C9FA
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565167; cv=none; b=r48070sr1SyABOKI6/wP4Z6kNs4xcfGaJQfB+YgmVT84x5AU0rAvURAtjp2vJVhQhjbqUUJP0jh/HMSdw5DwhSOoRyAFHb2/I28zgGLEg0XODPxqaXNdPjiP2VM1UrRgUxIacrW8/CZ/ahz8eUhcOHsaac3SYa4tl2Hr47b3WKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565167; c=relaxed/simple;
	bh=Abkw9pkCk+QxahPEWR177FQbBf9vgu48YQYz2hNYnvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HNv6XOHRM7TXdx0Ll+wb4UX2NpfdR1mNVJdm6RRfxwAQDz2so+EIOvx1Nq1UQU3fyCmx9dwp1eykGXpMKTqP3ogjYYFyFMl0hx+ro839NZJIsZZ3qav/CX3Fd6tyTPp4MCBDhLkOlYve6+hMAfq/iO7xJ3d+0CUD8bFsT5ybowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=is6di2Tf; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89a09295650so74509566d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772565165; x=1773169965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wek4UAiOX4L7/yT5GwgTA/PHDtJFiqJNLE5BoYSdezM=;
        b=is6di2TfzCyVLkeN/8gmpVFhb0KXLGrITnLYpfb09t6b1GuCW8zknnLEA+9nQVcbKh
         MsB9t8ZbqPvC485DvIEJskCdMogui1R4mxoX2FrFAT+hh7nuu0UtbKgEg4MofchaISWq
         kWNXv3HPCkPkG8Qgn7HD8FpQW70jH/WH66lPvRDDjLl82ybdLk///DQAwRJKrZWHCsBy
         ODYOIfotOB9sL76PJ+RS1w5QNZOM/7qxoeqfvPVf7HYWeTsjyb3O75aNnVucmqOOLTTD
         Ah8i4hV3gs+vhHB1RchS8Ht2SEJGC2C8mHTyWJsq3d8fKW8Hl50ODdrUJ6gXB6g+PhOr
         VHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565165; x=1773169965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wek4UAiOX4L7/yT5GwgTA/PHDtJFiqJNLE5BoYSdezM=;
        b=HoH/kG+uMiCkmBo+lRbAvtcWeSoI4qPy5UvSSy1plYaoNsOPK5MydNFwuAXuhpZGe2
         QdMFtajK3QORcoJuOOYVenecAlo84OdEkKg2G7/YHnU+YJgUJhIGMNw1xPifcy4kooLE
         smx6+8/Sdu+QVnaqNUlconeCSfz7mzoC+dJ5L/Q0reBVGgMJUn00U25h+pX8+8n5iOMT
         5UJfnbWXF2/OIIvH+zuh3zhxdmQ79b/HyG4gvfMme4IbPej02BJadIDuwu2pKbxPqMAj
         OK0xJxgNPCnvKhfebzT16DSkNhA7oLoHtn0ARJB8TpYeG0UmPZLCCjRprlmNLEkqe/if
         FdLA==
X-Forwarded-Encrypted: i=1; AJvYcCU63H/MueB9wbVcBnhUlaPDNXJnqph+uNdiY9ThYKbvIVUdkd4dkEBv3pd9U1gQW6GeSgh8/C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV8loyBd/GbnGf3bH0tmH2/WsKWJ4N/1kIkD72LptHwhdn0yW
	mMr9W2t/bRBJs7rMEJchyZACFytTejlV6Ym2RouOaBItkqYghAiGEj1/aQJCnEH43pvGgV9ejZ3
	o1tOEeBs172QKSQ==
X-Received: from qknop44.prod.google.com ([2002:a05:620a:536c:b0:8cb:4c74:5ab9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:459f:b0:8c6:e2a5:9715 with SMTP id af79cd13be357-8cbc8f1b6edmr2433377285a.55.1772565164642;
 Tue, 03 Mar 2026 11:12:44 -0800 (PST)
Date: Tue,  3 Mar 2026 19:12:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303191243.557245-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_do_parse_auth_options() to net/ipv4/tcp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2654A1F5BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263378-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

tcp_do_parse_auth_options() fast path user is tcp_inbound_hash().

Move tcp_do_parse_auth_options() right before tcp_inbound_hash()
so that it can be (auto)inlined by the compiler.

As a bonus, stack canary is removed from tcp_inbound_hash().

Also use EXPORT_IPV6_MOD(tcp_do_parse_auth_options).

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 1/0 up/down: 131/0 (131)
Function                                     old     new   delta
tcp_inbound_hash                             565     696    +131
Total: Before=25223788, After=25223919, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 54 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c | 54 --------------------------------------------
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1790d2fa75ade77cda8d0a593e689ea4432734dd..5997e0fb7a45fe74b692009f7275bec7671b5341 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4987,6 +4987,60 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 
 #endif
 
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+/*
+ * Parse Signature options
+ */
+int tcp_do_parse_auth_options(const struct tcphdr *th,
+			      const u8 **md5_hash, const u8 **ao_hash)
+{
+	int length = (th->doff << 2) - sizeof(*th);
+	const u8 *ptr = (const u8 *)(th + 1);
+	unsigned int minlen = TCPOLEN_MD5SIG;
+
+	if (IS_ENABLED(CONFIG_TCP_AO))
+		minlen = sizeof(struct tcp_ao_hdr) + 1;
+
+	*md5_hash = NULL;
+	*ao_hash = NULL;
+
+	/* If not enough data remaining, we can short cut */
+	while (length >= minlen) {
+		int opcode = *ptr++;
+		int opsize;
+
+		switch (opcode) {
+		case TCPOPT_EOL:
+			return 0;
+		case TCPOPT_NOP:
+			length--;
+			continue;
+		default:
+			opsize = *ptr++;
+			if (opsize < 2 || opsize > length)
+				return -EINVAL;
+			if (opcode == TCPOPT_MD5SIG) {
+				if (opsize != TCPOLEN_MD5SIG)
+					return -EINVAL;
+				if (unlikely(*md5_hash || *ao_hash))
+					return -EEXIST;
+				*md5_hash = ptr;
+			} else if (opcode == TCPOPT_AO) {
+				if (opsize <= sizeof(struct tcp_ao_hdr))
+					return -EINVAL;
+				if (unlikely(*md5_hash || *ao_hash))
+					return -EEXIST;
+				*ao_hash = ptr;
+			}
+		}
+		ptr += opsize - 2;
+		length -= opsize;
+	}
+	return 0;
+}
+EXPORT_IPV6_MOD(tcp_do_parse_auth_options);
+#endif
+
 /* Called with rcu_read_lock() */
 enum skb_drop_reason
 tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9079bc963f818924831298fdf35a2ba7c317fd1d..c27d11c3470bc90f7694938ed22c50ca3d1e4409 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4714,60 +4714,6 @@ static bool tcp_fast_parse_options(const struct net *net,
 	return true;
 }
 
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-/*
- * Parse Signature options
- */
-int tcp_do_parse_auth_options(const struct tcphdr *th,
-			      const u8 **md5_hash, const u8 **ao_hash)
-{
-	int length = (th->doff << 2) - sizeof(*th);
-	const u8 *ptr = (const u8 *)(th + 1);
-	unsigned int minlen = TCPOLEN_MD5SIG;
-
-	if (IS_ENABLED(CONFIG_TCP_AO))
-		minlen = sizeof(struct tcp_ao_hdr) + 1;
-
-	*md5_hash = NULL;
-	*ao_hash = NULL;
-
-	/* If not enough data remaining, we can short cut */
-	while (length >= minlen) {
-		int opcode = *ptr++;
-		int opsize;
-
-		switch (opcode) {
-		case TCPOPT_EOL:
-			return 0;
-		case TCPOPT_NOP:
-			length--;
-			continue;
-		default:
-			opsize = *ptr++;
-			if (opsize < 2 || opsize > length)
-				return -EINVAL;
-			if (opcode == TCPOPT_MD5SIG) {
-				if (opsize != TCPOLEN_MD5SIG)
-					return -EINVAL;
-				if (unlikely(*md5_hash || *ao_hash))
-					return -EEXIST;
-				*md5_hash = ptr;
-			} else if (opcode == TCPOPT_AO) {
-				if (opsize <= sizeof(struct tcp_ao_hdr))
-					return -EINVAL;
-				if (unlikely(*md5_hash || *ao_hash))
-					return -EEXIST;
-				*ao_hash = ptr;
-			}
-		}
-		ptr += opsize - 2;
-		length -= opsize;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(tcp_do_parse_auth_options);
-#endif
-
 /* Sorry, PAWS as specified is broken wrt. pure-ACKs -DaveM
  *
  * It is not fatal. If this ACK does _not_ change critical state (seqs, window)
-- 
2.53.0.473.g4a7958ca14-goog


