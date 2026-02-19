Return-Path: <netdev+bounces-259533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCmqC7BKl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 951801614DE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8113053772
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732D34FF78;
	Thu, 19 Feb 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO89z3rE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05255350A05
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522684; cv=none; b=LwG7abCaJiNSWCzC7ZhrC/dJHO9JoVKOu1uPlv0tQe22gElpQOqztzAFg5oS4ljiQl9Hd4yY13cvart5w3rFjo2tSnj2bY6IS95JYPZv5QfTD82+x3kylh57zkSA//ixSlhpBiHrZ8QaBDl+DXSOmzOqjKIdYA1pbMZGY7n2d6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522684; c=relaxed/simple;
	bh=dB+9E3nzrtjd/qOUOXpfC24bJqJPvXgodPCr0tXF/YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqFPU25uRQ7xi2ZMeSLabkW/2weymIXucN435KJ58pre6prxMOrKXW+dyWa7wiYObZf/m8HfFPCGkn4LzfwUsrjYRwpfOpey2Y3BAr9U4bIqmZIiaJfYeAf4nZuySqtSr9ePtbSVoYltL9KBeLfE6RAKNmDyrQTsbn/sv5+Y7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO89z3rE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ad147cdf07so12009275ad.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522682; x=1772127482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMCvv9NsIrSIhsq2/2xVHVJbDQutQhyzFzjPn4hlTE=;
        b=VO89z3rEGSV2S0+YMXQ02umrETA7RDOPUAgpgZVSQRlduqaK6uPArhjfKIWshyf78q
         rzrrLe9Umf+4wS8hIOOw/0FUe0KHlJrGQ12Hg7DlQZ2Sfc9+t2CuApDR6hac6WHZaUla
         Jkmuhe2x4B8+WMvDEQlqIC/58qLwy7Hu7/rQKNtLyqCr/2DOoX7R6BNp99aTdaPfGJfR
         qENnZ3U96FXUkhYadNGhoyE1opIQSPq8QlbyrZOJf7EY4NFXMg/q57WVICv3bfU/7Lav
         J+1H0qFu7iZM+JzxWmQNhxKEfFf9BiOE39G5VXXi/FXfqtXaE4+JrclfhEVRHYvdWEEo
         iK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522682; x=1772127482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfMCvv9NsIrSIhsq2/2xVHVJbDQutQhyzFzjPn4hlTE=;
        b=mPl3BStbrVpz7Im1nFxYm0RNnN6RP+llZ+nEVLwoLWiFVFD6z8/EK8kQKBGe8I7b4A
         yRJPZrvSeSlY2GX52WrBN8Biy7dXFH/eoJOmQU3uBX8iec3QNXaC/tLK6KG+8p72v4sB
         VrHEn1n54NevJSEq/PhD7kvukCh3XM00dqOmcp39Ijxlfo79FnJvp2+9TG+gP63m2ttM
         r4/sn/Mq1ijGbkQ/usKLzyM1FuVafDmKAofAPQjSJPOW4zQsKPLojHMKq7SyxlD9o5ES
         jTgGVrFqz9mYI0jsTVQ1aJkweBDSY9C5g3eLr3OBzTALdaXih2gxEnkxUrJOxM0COou7
         ef/g==
X-Forwarded-Encrypted: i=1; AJvYcCWa8qcn8LJWnKWXIf3+5d0yMEoJfn076dEFMnWG2HE3Jki9g8r3EyfEG3QDQJIy+n1y/KXbvk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3+bQV3l3hHzGHPjAPDe+9S50RRsUoUWHZeWj633RW0evGsqD
	CS4vWomyCjOLcXPN0FmtEZERp5VUDBDPb+9OAwrqcjxtcFKcDLLmNPUxUSzMlTClsZKeu4t/2Aq
	0magehQ==
X-Received: from plch7.prod.google.com ([2002:a17:902:f2c7:b0:2aa:d7bd:1139])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b10:b0:2aa:e843:ab11
 with SMTP id d9443c01a7336-2ad174dd3c2mr156687835ad.28.1771522682201; Thu, 19
 Feb 2026 09:38:02 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:25 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-3-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259533-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 951801614DE
X-Rspamd-Action: no action

UDP TX skb->destructor() is sock_wfree(), and UDP only
holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().

Otherwise, sk->sk_write_space() is read locklessly.

Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v3: Use WRITE_ONCE() in udp_bpf_update_proto()
v2: Cache sk->sk_write_space in sock_wfree()
---
 net/core/skmsg.c   | 2 +-
 net/core/sock.c    | 8 ++++++--
 net/ipv4/udp_bpf.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 75fa94217e1e..3d7eb2f4ac98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 
 	psock->saved_data_ready = sk->sk_data_ready;
 	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501..710f57ff3768 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
 	int old;
 
 	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
+		void (*sk_write_space)(struct sock *sk);
+
+		sk_write_space = READ_ONCE(sk->sk_write_space);
+
 		if (sock_flag(sk, SOCK_RCU_FREE) &&
-		    sk->sk_write_space == sock_def_write_space) {
+		    sk_write_space == sock_def_write_space) {
 			rcu_read_lock();
 			free = __refcount_sub_and_test(len, &sk->sk_wmem_alloc,
 						       &old);
@@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
 		 * after sk_write_space() call
 		 */
 		WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc));
-		sk->sk_write_space(sk);
+		sk_write_space(sk);
 		len = 1;
 	}
 	/*
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97..779a3a03762f 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
 
 	if (restore) {
-		sk->sk_write_space = psock->saved_write_space;
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
-- 
2.53.0.345.g96ddfc5eaa-goog


