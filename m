Return-Path: <netdev+bounces-81281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB6886DEE
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418F6284260
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734845BFF;
	Fri, 22 Mar 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V78BROy7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4C4776A
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115890; cv=none; b=OFonLlBz/nwM6I5fwM+gmv+k8xNGT6ZsfdwkVSy7ZGgKnZexvBBzXXOCT4LEKlnZ31Na2F7H1dJuVd+P3b3qp+k14fn4HT6A+ZvCHCQzkjnxNN2mRLVzpIqsNxwer8CcTq2EIUZ4XM+aHjnyU2D5hK3ExhCoG249YCfb7zulJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115890; c=relaxed/simple;
	bh=BD2VNn8XGBc3XDYFjksLLxUhYv+7ubBM8PjDnwd1weM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GBS+g6K4JHir2YcSrD8/8KQgobp4ZluRmS8qp1/rSRtlxsO6JOwyjM3R7fn0uwagttyhHM6Sh+D8+Ut3eJ3EJNRf0NMP4jGoeyR0ch6pSRNb0KfjeY27lmKefu+qz/gepmnbA/bBUuTq8cVmTxMi357q7zOqJ3NzXO10CJrHCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V78BROy7; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-789ea357429so237681685a.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711115888; x=1711720688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWer4X813f49OWVtLu/iFFK078vRkQl5d0a5vdvUv44=;
        b=V78BROy74Q1uDwgl1VOscvaVEMiCrPyGZ2CBLp/nbQnzWSDZP5cLsK3iOXyr5jeyge
         jquqMzcios9mk8wujbUGvgz7BcqgBm3eoaHioTEZu7YR1XOCfJWxnVa2EXHi7auizYVd
         3vDk9e8EfpvrxQdmGGqebv98H87thBpz7jyk0wxfYXSeaxBB9JxwYt/dyRXPRqjZAfSC
         GfkbeHI0af1EGR7v955Yh19fbofG6segcsjkLFL7VfIx9uVGepIVEYNDquXeyvZp7UGb
         nKHtoc0DcqdsJxwFsv52dob9Cy5SY+lm5cq6iT/fsFOx43lOLz8yQyXYyM5YZ3F95WqW
         I7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711115888; x=1711720688;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWer4X813f49OWVtLu/iFFK078vRkQl5d0a5vdvUv44=;
        b=vpQTuoxZDAp4yYRCVKJ0b/Js44cvouxpSJZ3bOb1ks4XQY9g2H8fJUqch/3WzN8gZj
         /NDUe08iWdHLKeQsTKkfBxHKCbV25xOpPin5Lctr5GXQ0mkfLpXiZAUglOH+hyoRPEOh
         21pVY7p7XgJf6DwzcdO5hQLDbcbcP/aRe09p+iGnQSDZa0c+xpOamWUb6aO/1g8V/nct
         4WdEmzeuzPyn6sRhSQAzuzgwYnbAX+vTiVTiO/J9Bu0CvYpwBfZnPSd7Z/XCxb9uLL8b
         bE2GcYSkenwCIyeiEQiIfQIdrgw2MHhe6L91PtJn7FiE9kLSn9uXj02Fyk7tpgYoGoZM
         PCQA==
X-Gm-Message-State: AOJu0YxKU1XZ++IDk5FPS7shSZ4dPHnHcFHFAauZkfnTexIHkWmeC6Co
	P7Az8si3SDNDnvo+Sl99e5ZSbnufLNGWoCBl8kMqvSIbO3MNhfxhiKUM8WMS7Jr8qcLDFeNZgyL
	iBeRoCDxYLQ==
X-Google-Smtp-Source: AGHT+IG5ihslp/6wTuZ6aFzSqMqsUoXNzq56/8tDxdtLkoehAKrap6W/tnkNMhHme3FUDsTehVrkTfa4mo0blQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:3953:b0:78a:3ba1:9ba8 with SMTP
 id qs19-20020a05620a395300b0078a3ba19ba8mr13233qkn.4.1711115887644; Fri, 22
 Mar 2024 06:58:07 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:57:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322135732.1535772-1-edumazet@google.com>
Subject: [PATCH net] tcp: properly terminate timers for kernel sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Josef Bacik <josef@toxicpanda.com>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"

We had various syzbot reports about tcp timers firing after
the corresponding netns has been dismantled.

Fortunately Josef Bacik could trigger the issue more often,
and could test a patch I wrote two years ago.

When TCP sockets are closed, we call inet_csk_clear_xmit_timers()
to 'stop' the timers.

inet_csk_clear_xmit_timers() can be called from any context,
including when socket lock is held.
This is the reason it uses sk_stop_timer(), aka del_timer().
This means that ongoing timers might finish much later.

For user sockets, this is fine because each running timer
holds a reference on the socket, and the user socket holds
a reference on the netns.

For kernel sockets, we risk that the netns is freed before
timer can complete, because kernel sockets do not hold
reference on the netns.

This patch adds inet_csk_clear_xmit_timers_sync() function
that using sk_stop_timer_sync() to make sure all timers
are terminated before the kernel socket is released.
Modules using kernel sockets close them in their netns exit()
handler.

Also add sock_not_owned_by_me() helper to get LOCKDEP
support : inet_csk_clear_xmit_timers_sync() must not be called
while socket lock is held.

It is very possible we can revert in the future commit
3a58f13a881e ("net: rds: acquire refcount on TCP sockets")
which attempted to solve the issue in rds only.
(net/smc/af_smc.c and net/mptcp/subflow.c have similar code)

We probably can remove the check_net() tests from
tcp_out_of_resources() and __tcp_close() in the future.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/netdev/20240314210740.GA2823176@perftesting/
Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Fixes: 8a68173691f0 ("net: sk_clone_lock() should only do get_net() if the parent is not a kernel socket")
Link: https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318RwRgsatjw@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Josef Bacik <josef@toxicpanda.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/net/inet_connection_sock.h |  1 +
 include/net/sock.h                 |  7 +++++++
 net/ipv4/inet_connection_sock.c    | 14 ++++++++++++++
 net/ipv4/tcp.c                     |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 9ab4bf704e864358215d2370d33d3d9668681923..ccf171f7eb60d462e0ebf49c9e876016e963ffa5 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -175,6 +175,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 			       void (*delack_handler)(struct timer_list *),
 			       void (*keepalive_handler)(struct timer_list *));
 void inet_csk_clear_xmit_timers(struct sock *sk);
+void inet_csk_clear_xmit_timers_sync(struct sock *sk);
 
 static inline void inet_csk_schedule_ack(struct sock *sk)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index b5e00702acc1f037df7eb8ad085d00e0b18079a8..f57bfd8a2ad2deaedf3f351325ab9336ae040504 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1759,6 +1759,13 @@ static inline void sock_owned_by_me(const struct sock *sk)
 #endif
 }
 
+static inline void sock_not_owned_by_me(const struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(lockdep_sock_is_held(sk) && debug_locks);
+#endif
+}
+
 static inline bool sock_owned_by_user(const struct sock *sk)
 {
 	sock_owned_by_me(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7d8090f109ef4e794a13fb6ab5d180b16bafb59d..c038e28e2f1e66bf10c7f67ffe073e6790b2d6ce 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -771,6 +771,20 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
+void inet_csk_clear_xmit_timers_sync(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	/* ongoing timer handlers need to acquire socket lock. */
+	sock_not_owned_by_me(sk);
+
+	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+
+	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
+	sk_stop_timer_sync(sk, &sk->sk_timer);
+}
+
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
 	sk_stop_timer(sk, &sk->sk_timer);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d20b62d521712ae7982b1e73fddf7d4be0df696d..e767721b3a588b5d56567ae7badf5dffcd35a76a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2931,6 +2931,8 @@ void tcp_close(struct sock *sk, long timeout)
 	lock_sock(sk);
 	__tcp_close(sk, timeout);
 	release_sock(sk);
+	if (!sk->sk_net_refcnt)
+		inet_csk_clear_xmit_timers_sync(sk);
 	sock_put(sk);
 }
 EXPORT_SYMBOL(tcp_close);
-- 
2.44.0.396.g6e790dbe36-goog


