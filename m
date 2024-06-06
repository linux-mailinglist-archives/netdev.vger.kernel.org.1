Return-Path: <netdev+bounces-101544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCE8FF54A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30CC1F25ACC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F06E5FD;
	Thu,  6 Jun 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXAyVMRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17596CDBA
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702152; cv=none; b=s1UbucjbTtUCHori+iW+ofBP2tCa0JbcP60ebAiDGdrIVBqG2aBAZd02JWo2q8nxJV56CJo7Ud7+7fmm1uZ2tErSCiMW27rK7VkZG3qk2EcHm+a2TthW3oKBwSAitQtQ+DnQkN7+Tz2B0LBVHwUKPi1VHgKgk0hR1//n528F4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702152; c=relaxed/simple;
	bh=n0dbB4AdJivzv4EkA9rwHWYMY2TIYG3i3n4Y9bBwfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgzgEgDxl1TltDAdpPAWj0cqIJ8MYQcwcYaeOCWCGyXQ2sblgIq0bQonkaiLvIQQBVhAbH7zbWnlnirSYGoLoWBpQrDwuHvyRxgU5mWZ1oz5LGU16LNQfq38kHKV1MAJoxOiaga/9X/Z2JgAqG1ZjiqvJIFgT326sykk1r/u/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXAyVMRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E47C4AF08;
	Thu,  6 Jun 2024 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702151;
	bh=n0dbB4AdJivzv4EkA9rwHWYMY2TIYG3i3n4Y9bBwfkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXAyVMRimm1uVJ03i5mrpC8zYMw0WCUpsemlHSnViKOi1eY7i2VawSXhZ+d8J2SFg
	 yAjhenB2ezBrdouwSZtUHCHAvexSDYH0vMpNcmp0cFGqRPi0lfkHql3KnvWw4CIYF3
	 DnJ0DI2B0Mh/SdMqdx1abegg3hjhlh8qlC+5crjTZflH0aT34U/JyNvfNoTY1+JJWX
	 S9MAv9KCHSnuBjjmfqN6RsBWL+klgbLKWI/MP6+RKLPsxKICPIyBhHgJHNOsVaZNUl
	 mQId6dv0kDHri4cIE1fogrWOFyxAB+TBydQha8AqF0G4ksB0qOaMxOU2oF+vbo9OvQ
	 xvrMBpFPVf++g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@gmail.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	anjali.k.kulkarni@oracle.com,
	Liam.Howlett@oracle.com
Subject: [PATCH net-next 2/2] net: netlink: remove the cb_mutex "injection" from netlink core
Date: Thu,  6 Jun 2024 12:29:06 -0700
Message-ID: <20240606192906.1941189-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606192906.1941189-1-kuba@kernel.org>
References: <20240606192906.1941189-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in 2007, in commit af65bdfce98d ("[NETLINK]: Switch cb_lock spinlock
to mutex and allow to override it") netlink core was extended to allow
subsystems to replace the dump mutex lock with its own lock.

The mechanism was used by rtnetlink to take rtnl_lock but it isn't
sufficiently flexible for other users. Over the 17 years since
it was added no other user appeared. Since rtnetlink needs conditional
locking now, and doesn't use it either, axe this feature complete.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: anjali.k.kulkarni@oracle.com
CC: Liam.Howlett@oracle.com
CC: jiri@resnulli.us
---
 include/linux/netlink.h  |  1 -
 net/netlink/af_netlink.c | 18 +++---------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 5df7340d4dab..b332c2048c75 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -47,7 +47,6 @@ struct netlink_kernel_cfg {
 	unsigned int	groups;
 	unsigned int	flags;
 	void		(*input)(struct sk_buff *skb);
-	struct mutex	*cb_mutex;
 	int		(*bind)(struct net *net, int group);
 	void		(*unbind)(struct net *net, int group);
 	void            (*release) (struct sock *sk, unsigned long *groups);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 8bbbe75e75db..0b7a89db3ab7 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -636,8 +636,7 @@ static struct proto netlink_proto = {
 };
 
 static int __netlink_create(struct net *net, struct socket *sock,
-			    struct mutex *dump_cb_mutex, int protocol,
-			    int kern)
+			    int protocol, int kern)
 {
 	struct sock *sk;
 	struct netlink_sock *nlk;
@@ -655,7 +654,6 @@ static int __netlink_create(struct net *net, struct socket *sock,
 	lockdep_set_class_and_name(&nlk->nl_cb_mutex,
 					   nlk_cb_mutex_keys + protocol,
 					   nlk_cb_mutex_key_strings[protocol]);
-	nlk->dump_cb_mutex = dump_cb_mutex;
 	init_waitqueue_head(&nlk->wait);
 
 	sk->sk_destruct = netlink_sock_destruct;
@@ -667,7 +665,6 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 			  int kern)
 {
 	struct module *module = NULL;
-	struct mutex *cb_mutex;
 	struct netlink_sock *nlk;
 	int (*bind)(struct net *net, int group);
 	void (*unbind)(struct net *net, int group);
@@ -696,7 +693,6 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 		module = nl_table[protocol].module;
 	else
 		err = -EPROTONOSUPPORT;
-	cb_mutex = nl_table[protocol].cb_mutex;
 	bind = nl_table[protocol].bind;
 	unbind = nl_table[protocol].unbind;
 	release = nl_table[protocol].release;
@@ -705,7 +701,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	if (err < 0)
 		goto out;
 
-	err = __netlink_create(net, sock, cb_mutex, protocol, kern);
+	err = __netlink_create(net, sock, protocol, kern);
 	if (err < 0)
 		goto out_module;
 
@@ -2016,7 +2012,6 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	struct sock *sk;
 	struct netlink_sock *nlk;
 	struct listeners *listeners = NULL;
-	struct mutex *cb_mutex = cfg ? cfg->cb_mutex : NULL;
 	unsigned int groups;
 
 	BUG_ON(!nl_table);
@@ -2027,7 +2022,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
 		return NULL;
 
-	if (__netlink_create(net, sock, cb_mutex, unit, 1) < 0)
+	if (__netlink_create(net, sock, unit, 1) < 0)
 		goto out_sock_release_nosk;
 
 	sk = sock->sk;
@@ -2055,7 +2050,6 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 	if (!nl_table[unit].registered) {
 		nl_table[unit].groups = groups;
 		rcu_assign_pointer(nl_table[unit].listeners, listeners);
-		nl_table[unit].cb_mutex = cb_mutex;
 		nl_table[unit].module = module;
 		if (cfg) {
 			nl_table[unit].bind = cfg->bind;
@@ -2326,15 +2320,9 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0) {
-		struct mutex *extra_mutex = nlk->dump_cb_mutex;
-
 		cb->extack = &extack;
 
-		if (extra_mutex)
-			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
-		if (extra_mutex)
-			mutex_unlock(extra_mutex);
 
 		/* EMSGSIZE plus something already in the skb means
 		 * that there's more to dump but current skb has filled up.
-- 
2.45.2


