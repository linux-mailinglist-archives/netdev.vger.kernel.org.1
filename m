Return-Path: <netdev+bounces-256321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDeBERIJgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:41:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9EDAB71
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00699300D0AF
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E83ACA46;
	Tue,  3 Feb 2026 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeehfEAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32F3A1CFE
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129660; cv=none; b=E0+Cvqr2onkx/elDEsyIbxyYIumLltfFwuizwuMiiDSRIbkj6fNx6urg8XSI2Oajv2sO4RvRYM6+86ebvNRfoaOpcQtyD+Gei8G1cQyBHyHC76ZcHlAang+CyR/zSHzwhVx9l7YtOPT7U+HcYQp1reTHCQ+tvNXeBuawW0QUjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129660; c=relaxed/simple;
	bh=wwd3OZacg5GUCFZnFSXV7gqjBKmaOq4whtDwHJkNVM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z6/dBOV53ZS2p/DAozkNVNkrnRTmngSHJzxmw6SR+pSoPhpE/OgReyK5xD/Zp7PcLCSqiQsRk1mvJXNvdO7QFymBotdQjSZ56Vu98rdNZzXIb+utfPcqIUfHsQZCzz88oiT0oYdV3h7W3MLKRPAEjLUkoqjGWTfS3whKk8SygyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeehfEAp; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70a62ca32so1750178785a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770129658; x=1770734458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlOho2/h05NwpTDmj25mR5j0ETQs3XlRwug7OGIdxRU=;
        b=CeehfEApguPNY1YU0dT5gHcwXICunmgRBywkDcXpSLD9nniRjLxNG0PYZKWarTLgfc
         Q2OBGRmNX02SxUAiMkWeLnzeq+Vq9Smpw2mvxGAIZh7L3Oe/2pZ4WOJZtIia6kR69+s0
         H+NRN72gOhL2eYLSuwPL5gKAxgX0YcNs3CMIhs30gwll6GqjusSaOMs44XXomnZ+89Xx
         N1efa2Ocy3YdBmg4WOaVdpCooi7uf54dob04+hBxz52ZsxQ6U4KBsvmgireI5/GK0ffa
         F/G/YZq6hZ6wm3TBjktIo9le4rh7p5Wpj5ai+za0zrD2ry6A8gWkC9lQJ9dugrFbGkqF
         CA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129658; x=1770734458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlOho2/h05NwpTDmj25mR5j0ETQs3XlRwug7OGIdxRU=;
        b=wKvj8bLlBlbqrt7K+zv42hFRpCNXoOFNULnQd8LGVf8RvyYg9OnRTTJ9mr5FIRIHS3
         sBjigiiX6a+/Fw3Jx7LwZSAt6en9UCNh6t2MXleTxa04Qhp2YjKekL5cdbMhDIZa1bC4
         5HdDMohaS0LTY0LWs0KICOsSpcjEBUY9dVe4++OFbGxR8jKssSal9Tixn6gf/8htBIfN
         fyyCqZ1XSe1jU3HD36n6qr7du81iBHSKapm7w3+AD9koF8tZacigKhzlZQZBtEl1VnE+
         LGs6+UbAR27c6lnxlL4/CPwyLM2yKncokm4KbmjpKQyoTSW4HoTme/vc7F6ipyIeBlLJ
         5uEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqF30mOot8majOnhFBAT4j09+YcgvTSmDPr+/0/R+VoT+Ba5F4GrFiD1DU/GQRp/C9/K/ZvbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLQKc1oFt32u+sJud5U5FsXOHOLFgcdtCXKd6div5EJ5WIUsk
	B307KFOGh/nDey5FJOuUHRa2/o7ydxHhgFtZmQZ7HKnAsXxktXW4whKMgAzxTbuN4urKQwqQZGQ
	LD1lhFlwRI0obVw==
X-Received: from qkdd6.prod.google.com ([2002:a05:620a:a506:b0:8c7:d9b:8846])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:25d2:b0:8c6:a82e:16ba with SMTP id af79cd13be357-8c9eb32c3b7mr1881320385a.84.1770129657913;
 Tue, 03 Feb 2026 06:40:57 -0800 (PST)
Date: Tue,  3 Feb 2026 14:40:52 +0000
In-Reply-To: <20260203144053.83193-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203144053.83193-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203144053.83193-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: move tcp_v6_send_check() to tcp_output.c
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A9EDAB71
X-Rspamd-Action: no action

Move tcp_v6_send_check() so that __tcp_transmit_skb() can inline it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  3 ++-
 net/ipv4/tcp_output.c | 20 +++++++++++++++++---
 net/ipv6/tcp_ipv6.c   |  5 -----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 80f84564cb3d2b100e46f85fd9ee33d2c6ffe3c2..b9bebf5df4aa6ecf6f421400fb93cefb4104e5aa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1124,7 +1124,8 @@ static inline int tcp_v6_sdif(const struct sk_buff *skb)
 
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 
-INDIRECT_CALLABLE_DECLARE(void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb));
+void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb);
+
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *skb));
 void tcp_v6_early_demux(struct sk_buff *skb);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cc398b7fdcba9ffddf2e43179b89fc5d14be51d7..8c1731b544f42cfa1e7629dde128e969b60d2343 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1487,6 +1487,16 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_IPV6_MOD(tcp_v4_send_check);
 
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_checksum.h>
+
+void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
+{
+	__tcp_v6_send_check(skb, &sk->sk_v6_rcv_saddr, &sk->sk_v6_daddr);
+}
+EXPORT_IPV6_MOD(tcp_v6_send_check);
+#endif
+
 /* This routine actually transmits TCP packets queued in by
  * tcp_do_sendmsg().  This is used by both the initial
  * transmission and possible later retransmissions.
@@ -1648,9 +1658,13 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	/* BPF prog is the last one writing header option */
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
 
-	INDIRECT_CALL_INET(icsk->icsk_af_ops->send_check,
-			   tcp_v6_send_check, tcp_v4_send_check,
-			   sk, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (likely(icsk->icsk_af_ops->send_check == tcp_v6_send_check))
+		tcp_v6_send_check(sk, skb);
+	else
+#else
+		tcp_v4_send_check(sk, skb);
+#endif
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
 		tcp_event_ack_sent(sk, rcv_nxt);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c65a5bfd322a1db5dc3fbc406e577f0ccb044c23..ca01b11c0ac959e4ee18dd388c3d17e8a4c88761 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2015,11 +2015,6 @@ static struct timewait_sock_ops tcp6_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp6_timewait_sock),
 };
 
-INDIRECT_CALLABLE_SCOPE void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
-{
-	__tcp_v6_send_check(skb, &sk->sk_v6_rcv_saddr, &sk->sk_v6_daddr);
-}
-
 const struct inet_connection_sock_af_ops ipv6_specific = {
 	.queue_xmit	   = inet6_csk_xmit,
 	.send_check	   = tcp_v6_send_check,
-- 
2.53.0.rc1.225.gd81095ad13-goog


