Return-Path: <netdev+bounces-256320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OGkHQAJgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:41:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE7DAB6A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3815F30346FB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BE23AA1AD;
	Tue,  3 Feb 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMaQf2TU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22F3AA1B5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129658; cv=none; b=LE3DMjC4deKux9N5R1OwEckvuAQasQSFxoLwsJMuZZdDyWaG2tOWPdO/GU0FY0NOp2BnNkGCIf9RBQtMz8qCZYLLKAgkoPO4HdcVxdg/PlVFyzhjhq+rcUzzJW7mSRR3loDawGlkkdvoJ1EEUbO5+YWKChSoWIG9wRBITNo5+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129658; c=relaxed/simple;
	bh=bufmR8isNAcmqVKwRF2F9LTDB2ri9F+mCoGlTm+p0fU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lusQ37AU9xohllsX6/Kw5U6c01FO4YVzM+UnTvyDOR5NFcHOYm1A3XEqJuXZHKt36remUJAIH2cU2Wb99mhNE2h527Xb7GYdRt4BpdD/IY5IqMcKXgeMl8S3Vq8hsYUPwBabeS5YAkz13YlSesy78D2i43qjPm0Xbz51aYY9l3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMaQf2TU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6ad709d8fso251436485a.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770129656; x=1770734456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJIo7YeM0Ar5YQFxSbzJMlGYj1ttnLmgiT0ZVX95veg=;
        b=IMaQf2TUJuKvhBL/XZ2972kIoNcVGt0wQyUlVMy/LiQVVT/hPFnGWZ0mJV52SW/Jh+
         4XFpp0qi6k2UMlI9oEoAF8UHTFJZrb2HE0hOBOKyKhgUZ1wUApwRCYp5D9a+/UhT8I66
         yuHfUbvIkPy3DiPDxacETRElH5iNlI1Rj8TJGyUUXeizAcoXPvSdRPMNGlhjEQSkc28h
         Tfv4XDMzJvGlKF4R3EtnGeNdFvZzAlR4mU5D6WNy10WSROZDgCa/oz6Gi/Y0NcqapEwk
         B3buHHVhElNPRStsIe9ybu8OqakbjmPCZRO85vymsCipftjg9FCX390VDw1KhEx1Y2yZ
         ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129656; x=1770734456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJIo7YeM0Ar5YQFxSbzJMlGYj1ttnLmgiT0ZVX95veg=;
        b=oZVir4Qvsm2wSfdymkJNDpL7COIeSrm1+drNUyKusIxs+hGI2/f1IIPZBOjl8Y0qtK
         gkEOKoTKcoAlGQ9eKzw3fiIqPEXqTDXMSxcd/cEpcXDGzr77TQqLaGiboU7SA2jNVze/
         qD8iuamcUdhm9xIgghu9/nk47zd3SbAKlUgeAGyhTjZbHuPMXvGsA7U3OWXberEpLQIH
         qmpEIHg6VmEEtIaFgeX2jsppYpZH3YJVTuggUTWr8yLzMCugiiIfFp+Wi/dWhImRCb3s
         MqCWk0ecy2BJXS9JMvl3S7g1pXdXvB7YHg6t83F0Ue29m4jDQpR/OToWs2B7k9w9r4SA
         3Uaw==
X-Forwarded-Encrypted: i=1; AJvYcCXkQ78f64LrpCztkGpzh5CBNskzpuDewwkrW3zCaO7wH7fYfQfDHVISlnZ/z41srthwZxbbCr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSU/t6VP0yIyIVa0DzG+s2EEMdaOLaaZvVSNv3jFqTq5bET4H
	1VgMwuO2VNTIJvlmR7MMNBPJ+sHKTYaXYE/tLHF3JsoJMlo4LQavezp+T1ppNzzLUq92dO8S8ux
	X9FyHThpXQfVovA==
X-Received: from qknsk10.prod.google.com ([2002:a05:620a:3a4a:b0:8b2:e8b5:a3cf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4407:b0:8c0:9cd8:616a with SMTP id af79cd13be357-8ca204a98eemr339580485a.42.1770129656352;
 Tue, 03 Feb 2026 06:40:56 -0800 (PST)
Date: Tue,  3 Feb 2026 14:40:51 +0000
In-Reply-To: <20260203144053.83193-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203144053.83193-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203144053.83193-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: inline __tcp_v4_send_check()
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
	TAGGED_FROM(0.00)[bounces-256320-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CDE7DAB6A
X-Rspamd-Action: no action

Inline __tcp_v4_send_check(), like __tcp_v6_send_check().

Move tcp_v4_send_check() to tcp_output.c close to
its fast path caller (__tcp_transmit_skb()).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 10 +++++++++-
 net/ipv4/tcp_ipv4.c   | 18 ------------------
 net/ipv4/tcp_output.c | 10 +++++++++-
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6c12be2cdd4d49360a6d43caa56f2fb327163033..80f84564cb3d2b100e46f85fd9ee33d2c6ffe3c2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2368,7 +2368,15 @@ void tcp_gro_complete(struct sk_buff *skb);
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
index 01fd563472608cc10744d3a5d4fb998b83c4be97..7537adf0846f4fe7e0a1dd1cdec559a982329cc1 100644
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
index f44d60d13b9ff4d59b05be76c4c3001142451df7..cc398b7fdcba9ffddf2e43179b89fc5d14be51d7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1477,7 +1477,15 @@ static void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb)
 
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
2.53.0.rc1.225.gd81095ad13-goog


