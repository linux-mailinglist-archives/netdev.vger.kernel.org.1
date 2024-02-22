Return-Path: <netdev+bounces-73938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581585F618
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10661F25D95
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF19B44C84;
	Thu, 22 Feb 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2tfIGAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E64501D
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599036; cv=none; b=ekyEUcTsILHpo1+mom6HgNbTvcWbWbiCG8y8Q1Cabno4LwFiIM5oZug5K5LF99O61yR64SBxTmtCeFqi2Xr6dsiPh5FTP+w3fZROzhqL3FTOj2Viumwgee5NXn/6kyUg+c4LVbtLhgGEu1f//GIVnROC4XrJQKuDOIBHKVW46u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599036; c=relaxed/simple;
	bh=MJvZ+gQDvthgylkfKVw7JiV4Bca7Rrs8ONvuQGoAa1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9hs0u/w8wWCbAM1VmsW+pGhCzyhZbV1cNQLgztDpNLFK5MtlG+NTuv87xeSNb5CwVgKmuJfFrk1cQYxoVhOwxXAzmUQzBOvupSSC7X76/UWWvP6oOWXCtKlz2UB5HYbndTq9FwkMCV06T7MDJEK89uRpAa7+jhlHesaThK6p/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2tfIGAc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so13524962276.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599034; x=1709203834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HUz/hrVYG3wBhnXG7mHSZKDtpkcWF8qh9wKf2fr9yM=;
        b=g2tfIGAccHQR85hGZ153cu7v+bTr/AqWokHFL8VoGkUym1fw3gU7m1Ptqi0TP/2X9o
         XNQwBfFhrkm3cOOqTc4IOGlmAqyxpYg4444viMEv1LSD0riJETpQDt8vtdskRei6s9jZ
         riqGIfIrrTbMxdcpkIZrBwYLiZQ4I2f9SAjtSXVHe54dbzHCCFTkyy1X1Oyqj/lZo9Ut
         P/sX9RBKuFHzdDKnnVHxZZorWWYWbAVB5klzqx0Eus0h8g6ZrATm1Ch00ayVpLOYz86a
         Wf2mZYAzHWbRiwg94hYo8xCp4UdeQWffCR71krTluxF+WQpnOgrrJ205HzOUR3vsTz4d
         Yjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599034; x=1709203834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HUz/hrVYG3wBhnXG7mHSZKDtpkcWF8qh9wKf2fr9yM=;
        b=YPxtK4f94/iJJBrN6ea3i6iJozS5fsCoNnzOpzZvEDvCvJsNUeMpleUcS9+v28ECCu
         Aq9izkM1qsDufKWZSXx+tKSqAxL96C3XhQqzbFdJjwLbbihYANiJbinkuYRRvECP6Ya1
         Sua+5KWY9aDnNrp2z8couvKxqtoa8oUCjluuM2euvxk/6JbzfHcHPohiA5EuChVP1pYK
         1pQmNpwvfeBmNZcVRdPrKJEWTR60nFXckNjpT+TRXj0JZVXoP4TLDQleyQYfVwOaxFbI
         hhIv6loS8jNdlhQ5abmMca7Zq/qekJiQxvC7T103Lz9A2cH/hZEchAmB2iJlA4qAGDXa
         b0gw==
X-Gm-Message-State: AOJu0YzxOrwjZTjWFPT1P4rHkpPTOe0DD3vMxkqB682P0EfK8JvlF4Bo
	qkxdNSzCvSI6/KT2WhipxCXg22KYUUSPAJLoYyCdzkOr8jrCFTwbu4qjDMFcSgRXaazsmKDkOqT
	vCVhNA/Mggw==
X-Google-Smtp-Source: AGHT+IEv/zB5FtoiyrpYBX1+JfM2uL1B9eQnh3mQaccRqNBv6cIeU0wZR0mNCF796e+pjQ5de+6QTT2xxI2jUw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1109:b0:dc6:d3c0:ebe0 with SMTP
 id o9-20020a056902110900b00dc6d3c0ebe0mr522785ybu.0.1708599034014; Thu, 22
 Feb 2024 02:50:34 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:14 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/14] rtnetlink: change nlk->cb_mutex role
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit af65bdfce98d ("[NETLINK]: Switch cb_lock spinlock
to mutex and allow to override it"), Patrick McHardy used
a common mutex to protect both nlk->cb and the dump() operations.

The override is used for rtnl dumps, registered with
rntl_register() and rntl_register_module().

We want to be able to opt-out some dump() operations
to not acquire RTNL, so we need to protect nlk->cb
with a per socket mutex.

This patch renames nlk->cb_def_mutex to nlk->nl_cb_mutex

The optional pointer to the mutex used to protect dump()
call is stored in nlk->dump_cb_mutex

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/af_netlink.c | 32 ++++++++++++++++++--------------
 net/netlink/af_netlink.h |  5 +++--
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 94f3860526bfaa5793e8b3917250ec0e751687b5..84cad7be6d4335bfb5301ef49f84af8e7b3bc842 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -636,7 +636,7 @@ static struct proto netlink_proto = {
 };
 
 static int __netlink_create(struct net *net, struct socket *sock,
-			    struct mutex *cb_mutex, int protocol,
+			    struct mutex *dump_cb_mutex, int protocol,
 			    int kern)
 {
 	struct sock *sk;
@@ -651,15 +651,11 @@ static int __netlink_create(struct net *net, struct socket *sock,
 	sock_init_data(sock, sk);
 
 	nlk = nlk_sk(sk);
-	if (cb_mutex) {
-		nlk->cb_mutex = cb_mutex;
-	} else {
-		nlk->cb_mutex = &nlk->cb_def_mutex;
-		mutex_init(nlk->cb_mutex);
-		lockdep_set_class_and_name(nlk->cb_mutex,
+	mutex_init(&nlk->nl_cb_mutex);
+	lockdep_set_class_and_name(&nlk->nl_cb_mutex,
 					   nlk_cb_mutex_keys + protocol,
 					   nlk_cb_mutex_key_strings[protocol]);
-	}
+	nlk->dump_cb_mutex = dump_cb_mutex;
 	init_waitqueue_head(&nlk->wait);
 
 	sk->sk_destruct = netlink_sock_destruct;
@@ -2209,7 +2205,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	int alloc_size;
 
 	if (!lock_taken)
-		mutex_lock(nlk->cb_mutex);
+		mutex_lock(&nlk->nl_cb_mutex);
 	if (!nlk->cb_running) {
 		err = -EINVAL;
 		goto errout_skb;
@@ -2261,14 +2257,22 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0) {
+		struct mutex *extra_mutex = nlk->dump_cb_mutex;
+
 		cb->extack = &extack;
+
+		if (extra_mutex)
+			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
+		if (extra_mutex)
+			mutex_unlock(extra_mutex);
+
 		cb->extack = NULL;
 	}
 
 	if (nlk->dump_done_errno > 0 ||
 	    skb_tailroom(skb) < nlmsg_total_size(sizeof(nlk->dump_done_errno))) {
-		mutex_unlock(nlk->cb_mutex);
+		mutex_unlock(&nlk->nl_cb_mutex);
 
 		if (sk_filter(sk, skb))
 			kfree_skb(skb);
@@ -2302,13 +2306,13 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 	module_put(module);
 	consume_skb(skb);
 	return 0;
 
 errout_skb:
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 	kfree_skb(skb);
 	return err;
 }
@@ -2331,7 +2335,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	nlk = nlk_sk(sk);
-	mutex_lock(nlk->cb_mutex);
+	mutex_lock(&nlk->nl_cb_mutex);
 	/* A dump is in progress... */
 	if (nlk->cb_running) {
 		ret = -EBUSY;
@@ -2382,7 +2386,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	module_put(control->module);
 error_unlock:
 	sock_put(sk);
-	mutex_unlock(nlk->cb_mutex);
+	mutex_unlock(&nlk->nl_cb_mutex);
 error_free:
 	kfree_skb(skb);
 	return ret;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 2145979b9986a0331b34b6ba2fda867f23d0d71c..9751e29d4bbb9ad9cb7900e2cfaedbe7ab138cf4 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -39,8 +39,9 @@ struct netlink_sock {
 	bool			cb_running;
 	int			dump_done_errno;
 	struct netlink_callback	cb;
-	struct mutex		*cb_mutex;
-	struct mutex		cb_def_mutex;
+	struct mutex		nl_cb_mutex;
+
+	struct mutex		*dump_cb_mutex;
 	void			(*netlink_rcv)(struct sk_buff *skb);
 	int			(*netlink_bind)(struct net *net, int group);
 	void			(*netlink_unbind)(struct net *net, int group);
-- 
2.44.0.rc1.240.g4c46232300-goog


