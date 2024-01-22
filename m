Return-Path: <netdev+bounces-64642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA6A8361E7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C91F26F15
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF03F8FE;
	Mon, 22 Jan 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="We+6Dd40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C03F8ED
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922779; cv=none; b=BmjAC5rgVnimHZBSibo5naReCCeBLYVzKa3fLgc0Bbb0zBBzwx5nVGc1+iqI0PcImeNtppkbxOJDMkiEnZmZvO2UqZzhrYZYssRi3zowD56JdSWLy2R/U5bD+V1RDIuH7PneMLY3GVOcEex6tTq5z3HGhOaDpi5h2iIKF0voxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922779; c=relaxed/simple;
	bh=ApC04zQXIG+U7E3FSd9RmP7u5X0Hsw8NToht6h1EG5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jaXdEERwdNc9AR1wTOn2/9m4yFC1ZdQGDT5mG+/XvKoOl1xeNkWecJhvPWDQ1XigAK2+FwJ1IG9ZCgkFjGtbKVAx6Fn5vbMIO2oEtEjSrZJ2AQjDsa+BOWNtqKuFRxV29eGuTfulFDjzs9cf/lQ5pwqaC9D7iw3ocYYPEVOR0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=We+6Dd40; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42a32dff21bso37080251cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922777; x=1706527577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xogYlF2oxp9dYKLsyqApeNTZyiXgwE/X6+ecmtksWFA=;
        b=We+6Dd40me0Ea/ncT/FPdkpuXTvVIYqZWITMgvtmvcaawHf7H3JFNa319Wk3EiIwGb
         GdhrKo6x/6cvXXU9sN1IoURuMsDLXc4BziFFKK7Y07V0SZB2AqxXo7hDi4X3raTDQnsv
         ry5UOfJafWTwcrZ1wZ8uoZG013wBLYZGyGhVWrfdG6TxAnxSNmZUsBmUo01OmxFNP9yr
         WdjQOR7PuECnzSuJGw7/6VDcRDD7FYNy21yvNjWKwNVUYg6elFbqXFdJJ1Jxi846dx2v
         3t2BnAytTgApGz2HRRcmXAXNimwEFgh2CkKjJ+49kOYR12JmNuG7Y8n6/ZbZkqLZcYls
         7i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922777; x=1706527577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xogYlF2oxp9dYKLsyqApeNTZyiXgwE/X6+ecmtksWFA=;
        b=i6ycv0zn5oQgr3swOZ+42HZym0F6WjaY9l4tYY+R9XPjxwWs3Ba0yOVnYX/oPuGpqF
         OV2H6bCbVh9tBX/tDrBCRjvcXuN+VT5xsrjVyck9zsq7WczBAgjxN+LrjgMV13VkCxns
         RVgksB3fAdScusLE5tyXNiAJ4Sqn/iaJjAp0r0Gs1khevAWfyB2hmkc/Kx/FY67H4EBZ
         gA+dyDDbIEo5tTFanhJ1wh3bi7YOfzSop8lFxy6wz9qZ/QTUURyM6VdfaOYZ/drYuLq3
         HpT/3wm+DUkSww3YBAupYKY1Q/Z/+IOUdtrrgDskxnw8cgdD8h0TbsBOvB+ljQEFbUpk
         2oig==
X-Gm-Message-State: AOJu0YxSxmPL3rT+C5u3DOW0yueBqVvROr3kahorDpUQYFFfdQyJppUj
	b9APAbk/qFxOJ/0Ixd5tnnYZo1e+qoxqEJcFzbO3TU4M4LADuDOltkCbJsJi3SKa8XfbPbNInYq
	w8IrWdif5Xg==
X-Google-Smtp-Source: AGHT+IEqUD2+x17vbjYvLJ6DIUAXhFbh3rDjVAOF2kgXXarJsZkwHizW7CJ7ToFYU3P+ZYke9xNS7vooCR3arQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:5908:b0:42a:dc3:3155 with SMTP
 id ga8-20020a05622a590800b0042a0dc33155mr668721qtb.11.1705922776925; Mon, 22
 Jan 2024 03:26:16 -0800 (PST)
Date: Mon, 22 Jan 2024 11:26:01 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-8-edumazet@google.com>
Subject: [PATCH net-next 7/9] sock_diag: allow concurrent operation in sock_diag_rcv_msg()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCPDIAG_GETSOCK and DCCPDIAG_GETSOCK diag are serialized
on sock_diag_table_mutex.

This is to make sure inet_diag module is not unloaded
while diag was ongoing.

It is time to get rid of this mutex and use RCU protection,
allowing full parallelism.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/sock_diag.h |  9 ++++++--
 net/core/sock_diag.c      | 43 +++++++++++++++++++++++----------------
 net/ipv4/inet_diag.c      |  9 ++++++--
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/linux/sock_diag.h b/include/linux/sock_diag.h
index 7c07754d711b9bd04bc57f8ed08981849fcadb11..110978dc9af1b19194644151af5456b8c6644cf9 100644
--- a/include/linux/sock_diag.h
+++ b/include/linux/sock_diag.h
@@ -23,8 +23,13 @@ struct sock_diag_handler {
 int sock_diag_register(const struct sock_diag_handler *h);
 void sock_diag_unregister(const struct sock_diag_handler *h);
 
-void sock_diag_register_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh));
-void sock_diag_unregister_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh));
+struct sock_diag_inet_compat {
+	struct module *owner;
+	int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh);
+};
+
+void sock_diag_register_inet_compat(const struct sock_diag_inet_compat *ptr);
+void sock_diag_unregister_inet_compat(const struct sock_diag_inet_compat *ptr);
 
 u64 __sock_gen_cookie(struct sock *sk);
 
diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index 72009e1f4380dfdcbf43ed08791e5039e74f5c54..5c3666431df49b3c278ef795f11ba542247796a6 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -17,8 +17,9 @@
 #include <linux/sock_diag.h>
 
 static const struct sock_diag_handler __rcu *sock_diag_handlers[AF_MAX];
-static int (*inet_rcv_compat)(struct sk_buff *skb, struct nlmsghdr *nlh);
-static DEFINE_MUTEX(sock_diag_table_mutex);
+
+static struct sock_diag_inet_compat __rcu *inet_rcv_compat;
+
 static struct workqueue_struct *broadcast_wq;
 
 DEFINE_COOKIE(sock_cookie);
@@ -184,19 +185,20 @@ void sock_diag_broadcast_destroy(struct sock *sk)
 	queue_work(broadcast_wq, &bsk->work);
 }
 
-void sock_diag_register_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh))
+void sock_diag_register_inet_compat(const struct sock_diag_inet_compat *ptr)
 {
-	mutex_lock(&sock_diag_table_mutex);
-	inet_rcv_compat = fn;
-	mutex_unlock(&sock_diag_table_mutex);
+	xchg((__force const struct sock_diag_inet_compat **)&inet_rcv_compat,
+	     ptr);
 }
 EXPORT_SYMBOL_GPL(sock_diag_register_inet_compat);
 
-void sock_diag_unregister_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh))
+void sock_diag_unregister_inet_compat(const struct sock_diag_inet_compat *ptr)
 {
-	mutex_lock(&sock_diag_table_mutex);
-	inet_rcv_compat = NULL;
-	mutex_unlock(&sock_diag_table_mutex);
+	const struct sock_diag_inet_compat *old;
+
+	old = xchg((__force const struct sock_diag_inet_compat **)&inet_rcv_compat,
+		   NULL);
+	WARN_ON_ONCE(old != ptr);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister_inet_compat);
 
@@ -259,20 +261,27 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 static int sock_diag_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
+	const struct sock_diag_inet_compat *ptr;
 	int ret;
 
 	switch (nlh->nlmsg_type) {
 	case TCPDIAG_GETSOCK:
 	case DCCPDIAG_GETSOCK:
-		if (inet_rcv_compat == NULL)
+
+		if (!rcu_access_pointer(inet_rcv_compat))
 			sock_load_diag_module(AF_INET, 0);
 
-		mutex_lock(&sock_diag_table_mutex);
-		if (inet_rcv_compat != NULL)
-			ret = inet_rcv_compat(skb, nlh);
-		else
-			ret = -EOPNOTSUPP;
-		mutex_unlock(&sock_diag_table_mutex);
+		rcu_read_lock();
+		ptr = rcu_dereference(inet_rcv_compat);
+		if (ptr && !try_module_get(ptr->owner))
+			ptr = NULL;
+		rcu_read_unlock();
+
+		ret = -EOPNOTSUPP;
+		if (ptr) {
+			ret = ptr->fn(skb, nlh);
+			module_put(ptr->owner);
+		}
 
 		return ret;
 	case SOCK_DIAG_BY_FAMILY:
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 52ce20691e4ef1382da94473128e3c14c55bd542..2c2d8b9dd8e9bb502e52e30dffc70da36d9b1c74 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1527,6 +1527,11 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
 
+static const struct sock_diag_inet_compat inet_diag_compat = {
+	.owner	= THIS_MODULE,
+	.fn	= inet_diag_rcv_msg_compat,
+};
+
 static int __init inet_diag_init(void)
 {
 	const int inet_diag_table_size = (IPPROTO_MAX *
@@ -1545,7 +1550,7 @@ static int __init inet_diag_init(void)
 	if (err)
 		goto out_free_inet;
 
-	sock_diag_register_inet_compat(inet_diag_rcv_msg_compat);
+	sock_diag_register_inet_compat(&inet_diag_compat);
 out:
 	return err;
 
@@ -1560,7 +1565,7 @@ static void __exit inet_diag_exit(void)
 {
 	sock_diag_unregister(&inet6_diag_handler);
 	sock_diag_unregister(&inet_diag_handler);
-	sock_diag_unregister_inet_compat(inet_diag_rcv_msg_compat);
+	sock_diag_unregister_inet_compat(&inet_diag_compat);
 	kfree(inet_diag_table);
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


