Return-Path: <netdev+bounces-259978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ms1GYoonGl1AAQAu9opvQ
	(envelope-from <netdev+bounces-259978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:14:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D23BD174A9E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BAAA30F65F5
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43435C182;
	Mon, 23 Feb 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9T7w+xe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5235B633
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841256; cv=none; b=TfYvX04fuKMo6Cco94KptjSoxjpIUIh02SIo9HPJ2nF/ppqB572tCIa/UyPHlDME+P53gZNqJ4VHdlrDajgIxAlMGa2uOhB9xXn9wa9uHlir3cxvHqZHd6OYDgG7GYGwQr6chPu+qfmvx9wRA8YIQrTIzEBMUOgdbiG18pNE/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841256; c=relaxed/simple;
	bh=irUcSyD0HilIcxvt3MYjmnj5VygDV4+xsm/x+TexWTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=joAGC6ZR79lwtTm5sknYrgOqvtY0EDkNdaG/FdOd4oaDL096mfkW8GrHflsMifBaemoA9UJUroRzpT/1Jw5aBoWFC3J+jetgBVBzKaYNl7ApQfoteJ9R4MRfKwhUfm+3+vzdFjCzJxjW9nM2043Fbg9/2RMfNNtfcnZiV6Ih0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9T7w+xe; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb37db8b79so1410200785a.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771841254; x=1772446054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAUYKr9qpNNZgLuVJLd3ak7Qtx7EV5xjai9JPBfCv/U=;
        b=j9T7w+xeQ3szMSaR6+b3H2At/A9dpEk2ZSjSMmceDoLPBj5CHUqONmprQIyOvkYq3D
         F0cIE5kTsZSCldB3Oy7ht2iATnzsddXgd3UpCXRrOQzQHZYjBcENr6uu1SgMgd+KbOb0
         mr1jq3IpHX5NOy+na/m1dMMbnFqta2qh//qkCviV3x0VzSKh93LQxwUAg9B+OXL9x9Z3
         exRGjPbwLkKCn3q1YSy6pSGcUoxjtcxgrlABDWCqAYFQTQoE/vCXC27mbbQ2rGPzlQGr
         9ksSYQVeY1fuhCjf5IynpXbafmOcTmuC0mIuF7jBqBAISKlYvmJ60HfUdUNrT8MeA5r1
         F1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841254; x=1772446054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAUYKr9qpNNZgLuVJLd3ak7Qtx7EV5xjai9JPBfCv/U=;
        b=Fp+d1kT96DkPRNvKFnNb32fz8unscHZ8lUqUMyXeusmf8ob4vLdZ0e1KdTK94nDcku
         a1PWiqEW+nwR/3D8hcR/NMYqU4Yiva3KfrrvrmZT4geivaYIm70haMLhGPOfZO4BH2ya
         8C2Y97gpVDAV7xN6Ya9TiV90MWdd03K2SQVDkyaJYsUKp7QflXUCR4L3KQb8EadZsJPJ
         tE5ivtINPWxQgxJoDpiGycmjlZgYHDT64tl/jA+58HpYxMWKzG+rDbdQj3Zq92KfefLu
         xG5xIepNN/TiY3RJFmNH2A1sFijivhDD7JTMXjgymuUJNRw/oH2HUIbe8h97fmJcKMJ+
         LB3w==
X-Forwarded-Encrypted: i=1; AJvYcCW+J5xC0aLJXUYpBU+VJwhwNpIjcxRO8LYxAgMoXqxscnpedf5UMHkX/NdLlBKakgN1bydupHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5xWIdTi/1WraC9sXC3BtIIhEZSijTk3yEvp1yNydGE361L+50
	UFHlMIl+Y68GjddaPLNm4vdXpZMJc6Fsk2b8v5vfqKEzoCH5nQzfyUn4HZXRChw1ED3LevNV4Ww
	CYDbG9RFz+7nPFw==
X-Received: from qkjb16.prod.google.com ([2002:a05:620a:cd0:b0:8b2:8123:3e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8d12:b0:8ca:105a:298f with SMTP id af79cd13be357-8cb8ca82016mr719490585a.68.1771841254158;
 Mon, 23 Feb 2026 02:07:34 -0800 (PST)
Date: Mon, 23 Feb 2026 10:07:28 +0000
In-Reply-To: <20260223100729.3761597-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223100729.3761597-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223100729.3761597-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] tcp: move tcp_v6_send_check() to tcp_output.c
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
	TAGGED_FROM(0.00)[bounces-259978-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: D23BD174A9E
X-Rspamd-Action: no action

Move tcp_v6_send_check() so that __tcp_transmit_skb() can inline it.

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 0/0 grow/shrink: 1/0 up/down: 105/0 (105)
Function                                     old     new   delta
__tcp_transmit_skb                          3321    3426    +105
Total: Before=25143091, After=25143196, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  3 ++-
 net/ipv4/tcp_output.c | 19 ++++++++++++++++---
 net/ipv6/tcp_ipv6.c   |  5 -----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c84433f3d57b1bb29b10f41a5d9981145134237..feaddce9d80523a9e7bd9db4c691736859c48c91 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1132,7 +1132,8 @@ static inline int tcp_v6_sdif(const struct sk_buff *skb)
 
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 
-INDIRECT_CALLABLE_DECLARE(void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb));
+void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb);
+
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *skb));
 void tcp_v6_early_demux(struct sk_buff *skb);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 29056d6fc787ec4ad4e3126634e5d52dacf6d700..fdddb16630a5108607496bfdc4d603baa43de621 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1506,6 +1506,16 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
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
@@ -1667,9 +1677,12 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	/* BPF prog is the last one writing header option */
 	bpf_skops_write_hdr_opt(sk, skb, NULL, NULL, 0, &opts);
 
-	INDIRECT_CALL_INET(icsk->icsk_af_ops->send_check,
-			   tcp_v6_send_check, tcp_v4_send_check,
-			   sk, skb);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (likely(icsk->icsk_af_ops->send_check == tcp_v6_send_check))
+		tcp_v6_send_check(sk, skb);
+	else
+#endif
+		tcp_v4_send_check(sk, skb);
 
 	if (likely(tcb->tcp_flags & TCPHDR_ACK))
 		tcp_event_ack_sent(sk, rcv_nxt);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d10487b4e5bff87d4ff2a7b912a826964101a163..306ca0585b4a60fcaafcbc9656a5fe36ad21d1b2 100644
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
2.53.0.345.g96ddfc5eaa-goog


