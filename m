Return-Path: <netdev+bounces-101543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCE68FF549
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43612287A49
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB261FF4;
	Thu,  6 Jun 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtwCLvND"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E561FE3
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702151; cv=none; b=qIDPgNuM8hKCrtbfq5tEBM0h7aQXHyKvFxL791f4xyPiL1N84k6YQZAceYKDUB9d9Ko4N68hUgcL6o4/94QW+yaVUKEg8SKBM0f4wu3pvntXUK7dkojRAXnyL5TO/nFQ0BWpohal2OKu8eJXV74+cvAtO27/r4Jx54ZX94QFSrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702151; c=relaxed/simple;
	bh=VVY2FpjaLBHe/FY6sne+fimfml6Uh12GXQr+lFQl6XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw3jymgxrfr2tk4Tht6zJCIyxUZRRGq1+h1Ilq8MKtvv9tdZlXn6C9r9nSUT0wGo9wjj1tfW9WjZ18+Tt0Nx/pZ3c4LeOh146TgimhDa/oCkBhYYJ60RtBuOdKQb4oZS8Hhda9z3ZR9h0pdqNClD8uT0kn/uKOKJ98VduoUTQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtwCLvND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C236C4AF07;
	Thu,  6 Jun 2024 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702150;
	bh=VVY2FpjaLBHe/FY6sne+fimfml6Uh12GXQr+lFQl6XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtwCLvND8qPoABjqvDKkVnBxVBPjM0BDJOwYImC23v8OY0fj9Dqez24MX3UtrlQEf
	 cy46CO+Xy6neqvPB9FM8B43Ac2IOP3Y2oxUwT+dvhL74Vlhw3NvFbDVrKxQulbRpyZ
	 uv7LUyXHawEeeIxcp0Zp9F9zYMEXhTrHt+ws5CZQ5eVeLqNXVGX5TiHvppfonO8dTS
	 5JD8zxma5cn9k3qiHlGBFIbyWRCD2mBXwmpPf+2vExMm3Q7Y6VA0zwOHLCRWiE4Gzh
	 HocBzo6zrnnngGdh5tA2XUv8uSo7JuUfVr2bAMmJ47tcSIxYF+v893wQaYHW2jRlNk
	 3rrKisFb4H3Sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@gmail.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] rtnetlink: move rtnl_lock handling out of af_netlink
Date: Thu,  6 Jun 2024 12:29:05 -0700
Message-ID: <20240606192906.1941189-2-kuba@kernel.org>
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

Now that we have an intermediate layer of code for handling
rtnl-level netlink dump quirks, we can move the rtnl_lock
taking there.

For dump handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE we can
avoid taking rtnl_lock just to generate NLM_DONE, once again.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/rtnetlink.c     | 9 +++++++--
 net/netlink/af_netlink.c | 2 --
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4668d6718040..eabfc8290f5e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6486,6 +6486,7 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
 	rtnl_dumpit_func dumpit = cb->data;
 	int err;
 
@@ -6495,7 +6496,11 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!dumpit)
 		return 0;
 
+	if (needs_lock)
+		rtnl_lock();
 	err = dumpit(skb, cb);
+	if (needs_lock)
+		rtnl_unlock();
 
 	/* Old dump handlers used to send NLM_DONE as in a separate recvmsg().
 	 * Some applications which parse netlink manually depend on this.
@@ -6515,7 +6520,8 @@ static int rtnetlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 				const struct nlmsghdr *nlh,
 				struct netlink_dump_control *control)
 {
-	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
+	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE ||
+	    !(control->flags & RTNL_FLAG_DUMP_UNLOCKED)) {
 		WARN_ON(control->data);
 		control->data = control->dump;
 		control->dump = rtnl_dumpit;
@@ -6703,7 +6709,6 @@ static int __net_init rtnetlink_net_init(struct net *net)
 	struct netlink_kernel_cfg cfg = {
 		.groups		= RTNLGRP_MAX,
 		.input		= rtnetlink_rcv,
-		.cb_mutex	= &rtnl_mutex,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= rtnetlink_bind,
 	};
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fa9c090cf629..8bbbe75e75db 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2330,8 +2330,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 
 		cb->extack = &extack;
 
-		if (cb->flags & RTNL_FLAG_DUMP_UNLOCKED)
-			extra_mutex = NULL;
 		if (extra_mutex)
 			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
-- 
2.45.2


