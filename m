Return-Path: <netdev+bounces-64639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA548361E3
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF63295BD1
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507453F8CA;
	Mon, 22 Jan 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCCl77nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E463EA92
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922774; cv=none; b=kq/I1ofjOds2+N9yMBqDjuUsrSl/r1ayJiBegkN7vhdoHQYuP82FBa/jDHb5QBXZGlPcdWgjZE/ujRaFyyTxJyevQCsOGfb/Xveudlv4rT2h/niJoH2geBKy7CuQMyh1x9zvIPQCIgAlB5p5IluLiO/bPJnGsgUbxgfBu6oaUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922774; c=relaxed/simple;
	bh=5Ud5xUgcc3hy19Q7k+QyyDg5nj/Y0PoaYt1IYGO6gpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUiWkGMG2+LzYWeKlUA7a8bIrINkj0CRTs0nDlc7HlbgBCBxAyk+mEMXuoauWRVg2pueZKxDMgzaXv4rq9JoVbfhxuGS8T93j5CFopwWMBp891fzNi2qAjjFRA8me7uhEfVRkyHQazp5DzAIqVhwrrwfAnIDfxR22BA3A/Y2A1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yCCl77nr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc26605c273so4398898276.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922772; x=1706527572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/drCrVe01fDIk7+UaRaW3evGz/Eder0yYufv6U04EpM=;
        b=yCCl77nr0pVZySLdooOX3uGdd3J6li6Y/JCAuFU8pO31D2aSmh1I5Y0ZcBsx5+f1j+
         rR8Ihe+rL/mYzkFOCO5DnYkTeV1bOQkRKZ1NuNZR7OhyxLEEAPu0aeqlt7f5KP1eg2cx
         PcSA/6RgZaPU7ZDGi7FNe2U1X1IvXkrpzb2EBT0jlPgWPBsNUmiBmhq5wmF+AkijzzGl
         hhUxivRjaAX1QG7zj4y8Jw/xzvyJC4mVPptlQMoblrx8tg5GCSd/Y90xud7jiM7UOIwm
         UaqdAWxateAG/82Yc0TUX4zss8P6sGwmkTAFbqeSdyKBw40meURYcZIf4PJh7KksHjCt
         D1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922772; x=1706527572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/drCrVe01fDIk7+UaRaW3evGz/Eder0yYufv6U04EpM=;
        b=ZK0UqMHv2iY5ESsU9jJE4Jqq4OMiai8Sz97jUnwyTQ7wBIkpKrqcPx8uE2AAa9HAUX
         UxCd17zzXvVwpW4Jpa3zlKYgL6592+P7JVX2FzWt8LsHAoWTO2RUplBmQCiV2xi2eB1I
         7Tm+oyq1r/azhG2LuUoEkdQr7AwENnnc815f69xDtynV2SHfWBxY7rkY9WO5maDCzEBu
         2H544fApiCfOQ/Q3HSP+uJHvCgDrgpeZJSQrnRJi27q20KfFt5V6wEAK5K+o4UYEoEcx
         AbsMN9JDubYNyvscyFFGyrHPMTWqcgA9ogEHcskz0bGAi9a9cH48f6NdjQaeSQRsF+fu
         z7zQ==
X-Gm-Message-State: AOJu0YxGNpHtXemN6sLrKCGh/qVvuuxM7at7DyBEHPsgiwBuFhGMb+2o
	gG1jj3ir8QMXk92+zUPzHKW9b3RBl0MMT3LF7Xlxs5khm35s42NzmNbbusPyHIj4QEa8gNMOSrT
	EQ1ui36/FxQ==
X-Google-Smtp-Source: AGHT+IHgp36NCe/rI4qiSdshaOROF1B1cG+lddlxoIq3Y+fpMo1JB3HvuxfCp3patLlqWwMh8ethZ5GjAulOjA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:68e:b0:dc2:354a:f191 with SMTP
 id i14-20020a056902068e00b00dc2354af191mr1913347ybt.10.1705922771825; Mon, 22
 Jan 2024 03:26:11 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:58 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-5-edumazet@google.com>
Subject: [PATCH net-next 4/9] inet_diag: allow concurrent operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_lock_handler() current implementation uses a mutex
to protect inet_diag_table[] array against concurrent changes.

This makes inet_diag dump serialized, thus less scalable
than legacy /proc files.

It is time to switch to full RCU protection.

As a bonus, if a target is statically linked instead of being
modular, inet_diag_lock_handler() & inet_diag_unlock_handler()
reduce to reads only.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c | 80 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9804e9608a5a0294b3ffabc4b5bb87ac1b96b09e..abf7dc9827969d7e8061420be8629730ccce5449 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -32,7 +32,7 @@
 #include <linux/inet_diag.h>
 #include <linux/sock_diag.h>
 
-static const struct inet_diag_handler **inet_diag_table;
+static const struct inet_diag_handler __rcu **inet_diag_table;
 
 struct inet_diag_entry {
 	const __be32 *saddr;
@@ -48,28 +48,28 @@ struct inet_diag_entry {
 #endif
 };
 
-static DEFINE_MUTEX(inet_diag_table_mutex);
-
 static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 {
-	if (proto < 0 || proto >= IPPROTO_MAX) {
-		mutex_lock(&inet_diag_table_mutex);
-		return ERR_PTR(-ENOENT);
-	}
+	const struct inet_diag_handler *handler;
+
+	if (proto < 0 || proto >= IPPROTO_MAX)
+		return NULL;
 
 	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
-	mutex_lock(&inet_diag_table_mutex);
-	if (!inet_diag_table[proto])
-		return ERR_PTR(-ENOENT);
+	rcu_read_lock();
+	handler = rcu_dereference(inet_diag_table[proto]);
+	if (handler && !try_module_get(handler->owner))
+		handler = NULL;
+	rcu_read_unlock();
 
-	return inet_diag_table[proto];
+	return handler;
 }
 
 static void inet_diag_unlock_handler(const struct inet_diag_handler *handler)
 {
-	mutex_unlock(&inet_diag_table_mutex);
+	module_put(handler->owner);
 }
 
 void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
@@ -104,9 +104,12 @@ static size_t inet_sk_attr_size(struct sock *sk,
 	const struct inet_diag_handler *handler;
 	size_t aux = 0;
 
-	handler = inet_diag_table[req->sdiag_protocol];
+	rcu_read_lock();
+	handler = rcu_dereference(inet_diag_table[req->sdiag_protocol]);
+	DEBUG_NET_WARN_ON_ONCE(!handler);
 	if (handler && handler->idiag_get_aux_size)
 		aux = handler->idiag_get_aux_size(sk, net_admin);
+	rcu_read_unlock();
 
 	return	  nla_total_size(sizeof(struct tcp_info))
 		+ nla_total_size(sizeof(struct inet_diag_msg))
@@ -244,10 +247,16 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	struct nlmsghdr  *nlh;
 	struct nlattr *attr;
 	void *info = NULL;
+	int protocol;
 
 	cb_data = cb->data;
-	handler = inet_diag_table[inet_diag_get_protocol(req, cb_data)];
-	BUG_ON(!handler);
+	protocol = inet_diag_get_protocol(req, cb_data);
+
+	/* inet_diag_lock_handler() made sure inet_diag_table[] is stable. */
+	handler = rcu_dereference_protected(inet_diag_table[protocol], 1);
+	DEBUG_NET_WARN_ON_ONCE(!handler);
+	if (!handler)
+		return -ENXIO;
 
 	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			cb->nlh->nlmsg_type, sizeof(*r), nlmsg_flags);
@@ -605,9 +614,10 @@ static int inet_diag_cmd_exact(int cmd, struct sk_buff *in_skb,
 	protocol = inet_diag_get_protocol(req, &dump_data);
 
 	handler = inet_diag_lock_handler(protocol);
-	if (IS_ERR(handler)) {
-		err = PTR_ERR(handler);
-	} else if (cmd == SOCK_DIAG_BY_FAMILY) {
+	if (!handler)
+		return -ENOENT;
+
+	if (cmd == SOCK_DIAG_BY_FAMILY) {
 		struct netlink_callback cb = {
 			.nlh = nlh,
 			.skb = in_skb,
@@ -1259,12 +1269,12 @@ static int __inet_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 again:
 	prev_min_dump_alloc = cb->min_dump_alloc;
 	handler = inet_diag_lock_handler(protocol);
-	if (!IS_ERR(handler))
+	if (handler) {
 		handler->dump(skb, cb, r);
-	else
-		err = PTR_ERR(handler);
-	inet_diag_unlock_handler(handler);
-
+		inet_diag_unlock_handler(handler);
+	} else {
+		err = -ENOENT;
+	}
 	/* The skb is not large enough to fit one sk info and
 	 * inet_sk_diag_fill() has requested for a larger skb.
 	 */
@@ -1457,10 +1467,9 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
 	}
 
 	handler = inet_diag_lock_handler(sk->sk_protocol);
-	if (IS_ERR(handler)) {
-		inet_diag_unlock_handler(handler);
+	if (!handler) {
 		nlmsg_cancel(skb, nlh);
-		return PTR_ERR(handler);
+		return -ENOENT;
 	}
 
 	attr = handler->idiag_info_size
@@ -1495,20 +1504,12 @@ static const struct sock_diag_handler inet6_diag_handler = {
 int inet_diag_register(const struct inet_diag_handler *h)
 {
 	const __u16 type = h->idiag_type;
-	int err = -EINVAL;
 
 	if (type >= IPPROTO_MAX)
-		goto out;
+		return -EINVAL;
 
-	mutex_lock(&inet_diag_table_mutex);
-	err = -EEXIST;
-	if (!inet_diag_table[type]) {
-		WRITE_ONCE(inet_diag_table[type], h);
-		err = 0;
-	}
-	mutex_unlock(&inet_diag_table_mutex);
-out:
-	return err;
+	return !cmpxchg((const struct inet_diag_handler **)&inet_diag_table[type],
+			NULL, h) ? 0 : -EEXIST;
 }
 EXPORT_SYMBOL_GPL(inet_diag_register);
 
@@ -1519,9 +1520,8 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 	if (type >= IPPROTO_MAX)
 		return;
 
-	mutex_lock(&inet_diag_table_mutex);
-	WRITE_ONCE(inet_diag_table[type], NULL);
-	mutex_unlock(&inet_diag_table_mutex);
+	xchg((const struct inet_diag_handler **)&inet_diag_table[type],
+	     NULL);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
 
-- 
2.43.0.429.g432eaa2c6b-goog


