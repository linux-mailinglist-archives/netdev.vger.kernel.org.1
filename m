Return-Path: <netdev+bounces-261122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DlOCxGsn2m1dAQAu9opvQ
	(envelope-from <netdev+bounces-261122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:12:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B81A00BB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884F330037D9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102E374720;
	Thu, 26 Feb 2026 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPWob0Dj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103A17A2EA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071939; cv=none; b=LjpmfvQYLXdpGA+oQ1dQ2vguB6/bNwQ/KdQmfXk3YAtPyZFolgEfRbtszErBlnR3PgSkFQESArnyE4xRTGzv/HRy+UCaXx9KNxwdZmY3uURsDr6UeEMAxVn40qfoI7SbgKo7u6JsaOin2n9btiBJ/uBwVQsR+YLEZE6aEwTwhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071939; c=relaxed/simple;
	bh=+orr7kYXfOvNC/mR3Z0b1f98AwTwNlX8vtKfILvKOok=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mSDK+DlXf19P59hYXPNI4yOZEAk4R0yHqPSkaB6qHYpukTugBnvWsvZE1/i0JEwcuOBsGRs63sBb3mujX6Vi86t+9UJ50L7Rc8cmAnWT7LvKQrVagnfMwt/zU9sFt7QslUgwsPF8Zb/BqcvvjV2RKMae2DWuyvl0p3kReYuBMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPWob0Dj; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70e610242so256211785a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772071937; x=1772676737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8x5PMqoCU2sVal4Rvp+zYR8oS4mEgBVna2xiVUJcyVY=;
        b=BPWob0DjKZuFibMRhQznCPvWywWU4GE+/bq7diCP0pgd9nZM/NQqn+RRoZPAzjIeDa
         Vk+hyU5h3vpsXk6cPKE5HVHde5dei9nKvj6G+3Gs5b4Qi+ErrQUO6dxZnlZXRRnpMsgk
         xMuiw5qF+kAOyrS44dIbi5iQHb4ihvG2+BxD1Lp7gA96xQZ2cbVd2wt5kcpqWSGY6CuV
         kw+tLBNpoaj/8e3hgIv79+wfFaQiQ3vMJnIZRteFc6YmRC4ddZHZnTgn5s0DnCC2YWtQ
         mZ2kV3OJO41PrMTRsVcn6rDNe+PL6EwCLXCNS+Q+GjuLAYHOf3Mjw0/jpSJFiMZx0kZd
         XL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772071937; x=1772676737;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8x5PMqoCU2sVal4Rvp+zYR8oS4mEgBVna2xiVUJcyVY=;
        b=P+V+1s3xSRI2WBZjKVpXjWT6xji5BPkibGtwPjFpR17WTRuWb49hjlT4CTzPDDg++l
         azw8qjuJxauBsxrrtc3QvC/dszIHTcaDeVpolYihWRhR73UhxLGLJk3+qb0LfPUzzptw
         beArEM3WN4J+7Ge19x0cmMQR7F9hZPENPh9bpSt0txL631UDqilvaCRZtwiWIaue1o4t
         rQSoQYfgGxRC4dCDbv8JHNG0NDoqynKw3EzQxQ56vw5hf5KaAX8K+XxqUzyQ/pszT7ME
         VPc7YmW3GVkx2Umh7GZa9e5cz+bi34cwEPApJNpUllhInIZPHK//mUgo7JBS6gSB89qb
         R+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOXJR3qkL+8RNXgGQcpEhg1N0bThZYSBK9p2On3kpExNudx/2UWZFe2oWKAE0XXewo3m4El+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrBJGfTX5LnrrgvpgXGOlmiGZ/LUzXW6GNWLSFHKcXQs8WGy2
	FaNQNRmihsQs0oiJTF2oWHQe/ZKTXzJQJIu7LwdHk9VUz13lECtrzsGJnOQ1s/b7JDyRfgJpXEE
	k9LucvO8AurIjRw==
X-Received: from qks6.prod.google.com ([2002:a05:620a:4c6:b0:8c7:d46:dadb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:254b:b0:8b2:f191:2b3a with SMTP id af79cd13be357-8cb8ca65f09mr2387527085a.53.1772071937278;
 Wed, 25 Feb 2026 18:12:17 -0800 (PST)
Date: Thu, 26 Feb 2026 02:12:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226021215.1764237-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: use try_cmpxchg() in lock_sock_nested()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261122-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C8B81A00BB
X-Rspamd-Action: no action

Add a fast path in lock_sock_nested(), to avoid acquiring
the socket spinlock only to set @owned to one:

        spin_lock_bh(&sk->sk_lock.slock);
        if (unlikely(sock_owned_by_user_nocheck(sk)))
                __lock_sock(sk);
        sk->sk_lock.owned = 1;
        spin_unlock_bh(&sk->sk_lock.slock);

On x86_64 compiler generates something quite efficient:

00000000000077c0 <lock_sock_nested>:
    77c0:       f3 0f 1e fa                 endbr64
    77c4:       e8 00 00 00 00              call   __fentry__
    77c9:       b9 01 00 00 00              mov    $0x1,%ecx
    77ce:       31 c0                       xor    %eax,%eax
    77d0:       f0 48 0f b1 8f 48 01 00 00  lock cmpxchg %rcx,0x148(%rdi)
    77d9:       75 06                       jne    slow_path
    77db:       2e e9 00 00 00 00           cs jmp __x86_return_thunk-0x4
slow_path:      ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h |  9 +++++++--
 net/core/sock.c    | 13 +++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 55b61e4b0d8318887d527e919fc1103d78ac6d14..84c21fb38a28406e387dc33e0fb5decd18893950 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -81,8 +81,13 @@
  * mini-semaphore synchronizes multiple users amongst themselves.
  */
 typedef struct {
-	spinlock_t		slock;
-	int			owned;
+	union {
+		struct slock_owned {
+			int		owned;
+			spinlock_t	slock;
+		};
+		long	combined;
+	};
 	wait_queue_head_t	wq;
 	/*
 	 * We express the mutex-alike socket_lock semantics
diff --git a/net/core/sock.c b/net/core/sock.c
index cfb2a6209946089669882cdbd5d1b36c53838989..86185f194d64b4eea0835ee0f9b53fda184c73cb 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3780,6 +3780,19 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
 
 	might_sleep();
+#ifdef CONFIG_64BIT
+	if (sizeof(struct slock_owned) == sizeof(long)) {
+		socket_lock_t tmp, old;
+
+		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
+		tmp.owned = 1;
+		old.slock = __SPIN_LOCK_UNLOCKED(old.slock);
+		old.owned = 0;
+		if (likely(try_cmpxchg(&sk->sk_lock.combined,
+				       &old.combined, tmp.combined)))
+			return;
+	}
+#endif
 	spin_lock_bh(&sk->sk_lock.slock);
 	if (unlikely(sock_owned_by_user_nocheck(sk)))
 		__lock_sock(sk);
-- 
2.53.0.414.gf7e9f6c205-goog


