Return-Path: <netdev+bounces-126302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6CE970928
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA08282343
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EF174EFA;
	Sun,  8 Sep 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOX616HB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9265171E65
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725818808; cv=none; b=Yi3wrpSC+PkuXwD3Q4iZX+uB1BNT1GT5UJyGCT8f0i9akmFxROgTSTANNBy3k7wYaFLqaVBaAzfW/rlmEAIkTbbkHisRwpnFzJRi71DNA+bOcWh7KdafTgqbcMhwKXQj82S7bzERUyDukLeatVsdAj8MCzjXa4eeWLPlU7dI5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725818808; c=relaxed/simple;
	bh=E35ypHId6uVOhZOxIAxyMp79rrcyqAykXp9uQUDjOJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V9dxPn+chmGfKZRS6qNWU0fVqabbG9IiRA6KVkEszrQnCFHV6gxw62ELtJwmJfJKecIQdeSBuB1cx0P2yg2ISKQWLBytppAXYXjuEE6UuCmLHRDehPSO5J6mjpz4fXZ13ZJubKyO5FrLhGEtlF3a0PYyyu+ncWYyvU70L10jp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOX616HB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068a7c9286so32523235ad.1
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725818805; x=1726423605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arQiQkMK0+rx/PDod6Avr3xX0a84jrlxgTnbdc7QY04=;
        b=KOX616HBkZm5mvOcPofVwRT7sf85nj8tL6kpo+uiSZ7kPqUdo5p70nqtPxRV1bGwPN
         zLUjBlkWfMe5qvFKStiHY4lSF2hhddDYSaeAppD2nSgYePtfI3ioabekjAI/4k7l0sfk
         iecpCFUcbu9QKs8Ll7b9oOgKjKYJcODI3f2n2FbpfqeYOJIbsDu/OHX0K+BMY/taXStB
         mFb5EJJUHvrj16buAQmQ7gZMlaxlwKqYVTZDd3QE7NV/mpvuLlLiFf4Y3+OA5QQDkcLK
         vptwQUdUgop2RSJh7abfnL+VivE/mnRaO/ZKWEO4aUTEIlPO3bfCfRerSkBw9jGAPtQS
         Zdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725818805; x=1726423605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arQiQkMK0+rx/PDod6Avr3xX0a84jrlxgTnbdc7QY04=;
        b=oSFMV1y7FHwPPCxYR0z/3ThgIenNhXp8oawPq9LAzE5G86FtMv7Jc8vs3RpYqUZUmF
         z3BLJJch3YxAyykqhJdGMQlQSW+rgMfWqkcknHQ12fRvFXnJN1sH0YHijHhd7ujYRQ6e
         +tiwNZyTOE+oIAKgvFHRcnXi0pitG2GmWHKtTwvSN/hEwwCI5Xef6vfMQ2oGy0Va0qH+
         hvbzfg/jx49VjBMj0EuvHYoKyX3d5EBAG8tDWxCShBJQoPLTrl4OAcSCSSfzaY6zvpje
         w2tzGNTVdrhDRn4Ysi773StNP4YxdFdrLi9sJ7NEamjxqq95YZVY6Wcad/6LQQINtI4K
         VzkA==
X-Gm-Message-State: AOJu0Yyv14kLlldzEB9v6uJjOvRJWbmnvmJ8lzWAR5zIM9JBO5xRh6UJ
	+VmmdhSP2+e3DBe3REtViDO8TnarCDP80oTdTI0+LO6Q4l2SYdQeXDOFqDIM
X-Google-Smtp-Source: AGHT+IHlThcej52XFrfLtcghpJa/uVoEWgczlAbVMwkTw8TAPnBFnb5euik/nrmPM07uxYS41T5utw==
X-Received: by 2002:a17:902:c401:b0:207:16b9:808c with SMTP id d9443c01a7336-20716b98155mr55266445ad.1.1725818804711;
        Sun, 08 Sep 2024 11:06:44 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:4334:4d08:284:9405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm22139775ad.91.2024.09.08.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:06:43 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [Patch net] mptcp: initialize sock lock with its own lockdep keys
Date: Sun,  8 Sep 2024 11:06:20 -0700
Message-Id: <20240908180620.822579-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.

As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
sk_clone_lock() immediately locks the new sock after preliminary
initialization. To fix that, introduce ->init_clone() for struct proto
and call it right after the sock_lock_init(), so now mptcp sock could
initialize the sock lock again with its own lockdep keys.

Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/net/sock.h     |  1 +
 net/core/sock.c        |  2 ++
 net/mptcp/pm_netlink.c | 18 ++++++++++++------
 net/mptcp/protocol.c   |  7 +++++++
 net/mptcp/protocol.h   |  1 +
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..7032009c0a94 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1226,6 +1226,7 @@ struct proto {
 	int			(*ioctl)(struct sock *sk, int cmd,
 					 int *karg);
 	int			(*init)(struct sock *sk);
+	void			(*init_clone)(struct sock *sk);
 	void			(*destroy)(struct sock *sk);
 	void			(*shutdown)(struct sock *sk, int how);
 	int			(*setsockopt)(struct sock *sk, int level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..747d7e479d69 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	}
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
+	if (prot->init_clone)
+		prot->init_clone(newsk);
 	bh_lock_sock(newsk);
 	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
 	newsk->sk_backlog.len = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..5f9f06180c67 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1052,10 +1052,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 static struct lock_class_key mptcp_slock_keys[2];
 static struct lock_class_key mptcp_keys[2];
 
+void mptcp_sock_lock_init(struct sock *sk)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+
+	sock_lock_init_class_and_name(sk,
+				is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+				&mptcp_slock_keys[is_ipv6],
+				is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
+				&mptcp_keys[is_ipv6]);
+}
+
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
@@ -1077,11 +1087,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	 * modifiers in several places, re-init the lock class for the msk
 	 * socket to an mptcp specific one.
 	 */
-	sock_lock_init_class_and_name(newsk,
-				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
-				      &mptcp_slock_keys[is_ipv6],
-				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
-				      &mptcp_keys[is_ipv6]);
+	mptcp_sock_lock_init(newsk);
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 37ebcb7640eb..ce68ff4475d0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
 	int ret;
 
 	__mptcp_init_sock(sk);
+	mptcp_sock_lock_init(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
@@ -2865,6 +2866,11 @@ static int mptcp_init_sock(struct sock *sk)
 	return 0;
 }
 
+static void mptcp_init_clone(struct sock *sk)
+{
+	mptcp_sock_lock_init(sk);
+}
+
 static void __mptcp_clear_xmit(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3801,6 +3807,7 @@ static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
+	.init_clone	= mptcp_init_clone,
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3b22313d1b86..457c01eac25f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1135,6 +1135,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
+void mptcp_sock_lock_init(struct sock *sk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.34.1


