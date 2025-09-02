Return-Path: <netdev+bounces-219265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B91B40D40
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC25E7AEBF3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989622E2EEF;
	Tue,  2 Sep 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFpC4JNw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC5285C82
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838168; cv=none; b=gRZcAFW69j21YP/mrpwwJLlrK93Eoj0O11r8DECqzpDNU+ythcq6r/WqHXdQUO1cjktTK7Vw8CZLI/U+9QUC4qhVaFxDlA1IeupU2ZVCtoQWQVkXSvaq0fdjSRj4oBeaIQB+C82rWXqVXTFwhETFJR+mPRpanggue78oO5jKQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838168; c=relaxed/simple;
	bh=+lR7kCyHZhQF8+QuyiSmryR0R4ZuN9GRZA/wTlm4nIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FNOUeZX7kUH6TesV67NuMUJ3rYZ//IgDDqaQ5OmI706Ih+/FlqqCDByrneQiJhRTSneWiZcJPNWpKOPhGGzMNJrdSougNxRabFmPyClTElcppHWBwUPm67Jlf9YMXoIXWSIcnVRofHbAYfa6xA8RHgv10HovAau1jC2yNQVCaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFpC4JNw; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-531b80dfb93so575246137.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756838166; x=1757442966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBKdIghYoxsIUrtM36J7PMaAfVJdDZBAPjI+jsHfCWc=;
        b=uFpC4JNwWduhuP/zAX8H3wmRRYle+XZkZizEcvmM18uAM/j31IgOLm0x7vxl4JaVOV
         wNMzeFDfpNw/xg+vUtfeE2T4nLRsMczZ9VRh4OOiQSluEstN1x3YqSOQO54fEcCs9glU
         YrKFyNA+lOHATtZ5UyXNlrsSZqXp2V5/3eqMVx3lN6rgqA9A5Oz6YMEk1NqtY5jNXDPB
         QWfkmA5RB9DJ/eVTPf0yjrW8m2kUft+b5NYBnHdXA/2tZoy7KyQjfpbIKHuhVLTiBIiD
         F5VnZ3UYTOeiYJPbcv1a3Pvf6RY9LxP0NBudF6ZmCRbjtKXYb/GgoDt6e1TrzNxYudAp
         BkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838166; x=1757442966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBKdIghYoxsIUrtM36J7PMaAfVJdDZBAPjI+jsHfCWc=;
        b=LNLEsxP32NM3DaEB9M98soUHHnalwryNXurUZjMwQVH3IUEZXG/datXDRZtK+kNA0X
         DGJUbm9TrjaqbRSA+3c4DKI2jWfXoZIs2ziy1uISauAiAIu086DuKwIhGpOgNaefEql+
         oYNKKFllOOwnA4IdlTjDq7eBtTdDxUw5Lwt4gS8Sf4eug5cDjmunIJvVzcVr+XVXkkHj
         qe3iXJyaGVYKcqqGIN7AhwT9990mRddV3JZlmV4jJSSca2a4viaAUNKzwxZAHVO8Sj3V
         vo6cMACKAfN/Ex5+Yyk8FMrWuZEyhxXPomZpFyOPT44A4UgFgGx40vP3MfWf6bq5RdnL
         AC7w==
X-Forwarded-Encrypted: i=1; AJvYcCV5Nqc6+NtxHkfscSb+DM1cpAM7I2+HpNyoO5m4bn29GW17tuzH9ugDnnFLdEklrId6Qv2uPsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOqwNow2kJKZWHCEsIfDrXMqqK9cqXY0Vf3MHnPQ1h9NFfoJV
	Z9jbp763YZH2CETZMIEaiGvRL5a6ClAf2WqBrQnc6rVw+l9AY9nos/QpWSEbrRGqwCcXsM948dc
	XFNz4NvNf8Hp7Xw==
X-Google-Smtp-Source: AGHT+IFKnW/pS8SCZkl4XxbLtc3+43830vMRkW3tkf+HP5uoMQOnF9/9IAmv9PGurFDfzt+KeQhvL4YEhkTlng==
X-Received: from vsbkb42.prod.google.com ([2002:a05:6102:80aa:b0:528:cf85:ec60])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5809:b0:523:2838:7366 with SMTP id ada2fe7eead31-52b1933a5ebmr4214450137.1.1756838165738;
 Tue, 02 Sep 2025 11:36:05 -0700 (PDT)
Date: Tue,  2 Sep 2025 18:36:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902183603.740428-1-edumazet@google.com>
Subject: [PATCH net] net: lockless sock_i_ino()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of commit c51da3f7a161 ("net: remove sock_i_uid()")

A recent syzbot report was the trigger for this change.

Over the years, we had many problems caused by the
read_lock[_bh](&sk->sk_callback_lock) in sock_i_uid().

We could fix smc_diag_dump_proto() or make a more radical move:

Instead of waiting for new syzbot reports, cache the socket
inode number in sk->sk_ino, so that we no longer
need to acquire sk->sk_callback_lock in sock_i_ino().

This makes socket dumps faster (one less cache line miss,
and two atomic ops avoided).

Prior art:

commit 25a9c8a4431c ("netlink: Add __sock_i_ino() for __netlink_diag_dump().")
commit 4f9bf2a2f5aa ("tcp: Don't acquire inet_listen_hashbucket::lock with disabled BH.")
commit efc3dbc37412 ("rds: Make rds_sock_lock BH rather than IRQ safe.")

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Reported-by: syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68b73804.050a0220.3db4df.01d8.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h   | 17 +++++++++++++----
 net/core/sock.c      | 22 ----------------------
 net/mptcp/protocol.c |  1 -
 net/netlink/diag.c   |  2 +-
 4 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..fb13322a11fc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -285,6 +285,7 @@ struct sk_filter;
   *	@sk_ack_backlog: current listen backlog
   *	@sk_max_ack_backlog: listen backlog set in listen()
   *	@sk_uid: user id of owner
+  *	@sk_ino: inode number (zero if orphaned)
   *	@sk_prefer_busy_poll: prefer busypolling over softirq processing
   *	@sk_busy_poll_budget: napi processing budget when busypolling
   *	@sk_priority: %SO_PRIORITY setting
@@ -518,6 +519,7 @@ struct sock {
 	u32			sk_ack_backlog;
 	u32			sk_max_ack_backlog;
 	kuid_t			sk_uid;
+	unsigned long		sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
 	struct pid		*sk_peer_pid;
@@ -2056,6 +2058,10 @@ static inline int sk_rx_queue_get(const struct sock *sk)
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
 	sk->sk_socket = sock;
+	if (sock) {
+		WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
+		WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
+	}
 }
 
 static inline wait_queue_head_t *sk_sleep(struct sock *sk)
@@ -2077,6 +2083,7 @@ static inline void sock_orphan(struct sock *sk)
 	sk_set_socket(sk, NULL);
 	sk->sk_wq  = NULL;
 	/* Note: sk_uid is unchanged. */
+	WRITE_ONCE(sk->sk_ino, 0);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -2087,20 +2094,22 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	parent->sk = sk;
 	sk_set_socket(sk, parent);
-	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	security_sock_graft(sk, parent);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
+static inline unsigned long sock_i_ino(const struct sock *sk)
+{
+	/* Paired with WRITE_ONCE() in sock_graft() and sock_orphan() */
+	return READ_ONCE(sk->sk_ino);
+}
+
 static inline kuid_t sk_uid(const struct sock *sk)
 {
 	/* Paired with WRITE_ONCE() in sockfs_setattr() */
 	return READ_ONCE(sk->sk_uid);
 }
 
-unsigned long __sock_i_ino(struct sock *sk);
-unsigned long sock_i_ino(struct sock *sk);
-
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 {
 	return sk ? sk_uid(sk) : make_kuid(net->user_ns, 0);
diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce63..158bddd23134 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2780,28 +2780,6 @@ void sock_pfree(struct sk_buff *skb)
 EXPORT_SYMBOL(sock_pfree);
 #endif /* CONFIG_INET */
 
-unsigned long __sock_i_ino(struct sock *sk)
-{
-	unsigned long ino;
-
-	read_lock(&sk->sk_callback_lock);
-	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock(&sk->sk_callback_lock);
-	return ino;
-}
-EXPORT_SYMBOL(__sock_i_ino);
-
-unsigned long sock_i_ino(struct sock *sk)
-{
-	unsigned long ino;
-
-	local_bh_disable();
-	ino = __sock_i_ino(sk);
-	local_bh_enable();
-	return ino;
-}
-EXPORT_SYMBOL(sock_i_ino);
-
 /*
  * Allocate a skb from the socket's send buffer.
  */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a287b75c1b3..e6fd97b21e9e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3554,7 +3554,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent)
 	write_lock_bh(&sk->sk_callback_lock);
 	rcu_assign_pointer(sk->sk_wq, &parent->wq);
 	sk_set_socket(sk, parent);
-	WRITE_ONCE(sk->sk_uid, SOCK_INODE(parent)->i_uid);
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 61981e01fd6f..b8e58132e8af 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -168,7 +168,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 __sock_i_ino(sk)) < 0) {
+				 sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
-- 
2.51.0.338.gd7d06c2dae-goog


