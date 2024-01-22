Return-Path: <netdev+bounces-64641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA68361E5
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801EA1F23310
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D923F8E7;
	Mon, 22 Jan 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLnuOsi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE033F8DA
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922777; cv=none; b=oib+Ynjmi0ZuSfr5qgUb0sPhhStXraM2aWKTAR3jkuENVSfSM13qpvUMWhk+cSzZuWqfzbHhdibmylddh7K2l4Uo1Qk0/+4pKZExRapJ+sSznvOmOipDkJFPyEGltjLK9OcGxC9vdckd/nVoR4hIEinqneDR+5OWcdmXi/aqEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922777; c=relaxed/simple;
	bh=vxidMbCYXyFohTbN76O8AW0qy18C/53GKZu87KgqYTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wy0rsgvUQ2iUCHaRMzp88H/93abegf7kS9A3Wz63rSuWk3Zn6EPSInuNeSBz0BAvOnqIW2YrED2zLqM5/gvM28FGRhtxqcF+JDRZ7YTHibF/UrGx29PM/pC2tCEBuwbBIlIDUB+L0Ay3/zpCYBfN4XBjB+t3rikJWGsI/KyS2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLnuOsi+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc21b7f41a1so3761120276.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922775; x=1706527575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxIpnoRhiJc3HKPPtqnbyr1be8f5Qn7V1jQs+qyhD2A=;
        b=xLnuOsi+rbjBWri/Cf+62GR4W+YLR+eYJxDfpaQWwC19MfXWblgt126H5e2ElI9QTI
         uj6fDFg51upw/FM/kqkXopVpyRmyMOTccbqB79SdKwGVlDujDAZMY+TbDXzgVdTR/Iwg
         5jWK2S4f/Jrt7LsMas/htcGrqcxFsuKKFSK6GvzcHWcIvCJqARWNV3are4vKBPdvE/yg
         tz1ysplu/XNkEIhtCB1b+mboH2glniw85dRXobriu28xF09ROlBKn2DYEGNMky7wd4KZ
         coVvvP6f8i15dWzaacyiJau24xlBgk+gGo/l7IblQCLSLNFVa7ebjldLMLoTlKdkF+Nz
         b6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922775; x=1706527575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxIpnoRhiJc3HKPPtqnbyr1be8f5Qn7V1jQs+qyhD2A=;
        b=Df+P2oc1lD060Uj+bgeLy2ClRkirgdXQord2FdU3izZ8bDEvb3QcqHgZK4LdUknoXI
         nsC6meTgFW425t2HM6H2ZcOS/btyYcUpk8DiAxJA4ZcT1aISVma5DoXU1H+Ju/6xRsxU
         boGyck+lLDl7RB6dN/BNWezTComG0lU3wafEhFAspa/Q/l0UrBCRwdnTAfFT8gIrNh3q
         /EpeoFAbpXDyN0r40B4/bfG+Sm309FZ+XaSD/6NHYgMo4L2NbQhJRxOxbaU5UH+/Xdnk
         ESPAJ5kdgi/txWopBJXO5Lr4UJwfxML30nRtKJ6NuhA688kuxb7zW+8zBmy7Fqs+5cFK
         oNnA==
X-Gm-Message-State: AOJu0Yyo92iDwo57QQ0eVn5Aka11Z7fhSLQbdOQsllxW+hZbpsjznhea
	geRC7Gv7BE87R+YKp6yGLytSfAM8QbcS6w8ceoDrWrwCKGmyPg6oErRxmp4udL2RIWUtw/mSwL+
	7vJJgAxvp7A==
X-Google-Smtp-Source: AGHT+IGqTIu4rzlOq2VVTvzztBL8EImU4MOHkhIBW4nGo6ZPgjnHp95J6OnPPeq+USGF3SgBU7rAW8voo/1xrQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:90b:0:b0:dc2:3619:e94e with SMTP id
 a11-20020a5b090b000000b00dc23619e94emr294710ybq.6.1705922775153; Mon, 22 Jan
 2024 03:26:15 -0800 (PST)
Date: Mon, 22 Jan 2024 11:26:00 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-7-edumazet@google.com>
Subject: [PATCH net-next 6/9] sock_diag: allow concurrent operations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sock_diag_broadcast_destroy_work() and __sock_diag_cmd()
are currently using sock_diag_table_mutex to protect
against concurrent sock_diag_handlers[] changes.

This makes inet_diag dump serialized, thus less scalable
than legacy /proc files.

It is time to switch to full RCU protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock_diag.c | 73 +++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c53b731f2d6728d113b90732f4df5b011a438038..72009e1f4380dfdcbf43ed08791e5039e74f5c54 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -16,7 +16,7 @@
 #include <linux/inet_diag.h>
 #include <linux/sock_diag.h>
 
-static const struct sock_diag_handler *sock_diag_handlers[AF_MAX];
+static const struct sock_diag_handler __rcu *sock_diag_handlers[AF_MAX];
 static int (*inet_rcv_compat)(struct sk_buff *skb, struct nlmsghdr *nlh);
 static DEFINE_MUTEX(sock_diag_table_mutex);
 static struct workqueue_struct *broadcast_wq;
@@ -122,6 +122,24 @@ static size_t sock_diag_nlmsg_size(void)
 	       + nla_total_size_64bit(sizeof(struct tcp_info))); /* INET_DIAG_INFO */
 }
 
+static const struct sock_diag_handler *sock_diag_lock_handler(int family)
+{
+	const struct sock_diag_handler *handler;
+
+	rcu_read_lock();
+	handler = rcu_dereference(sock_diag_handlers[family]);
+	if (handler && !try_module_get(handler->owner))
+		handler = NULL;
+	rcu_read_unlock();
+
+	return handler;
+}
+
+static void sock_diag_unlock_handler(const struct sock_diag_handler *handler)
+{
+	module_put(handler->owner);
+}
+
 static void sock_diag_broadcast_destroy_work(struct work_struct *work)
 {
 	struct broadcast_sk *bsk =
@@ -138,12 +156,12 @@ static void sock_diag_broadcast_destroy_work(struct work_struct *work)
 	if (!skb)
 		goto out;
 
-	mutex_lock(&sock_diag_table_mutex);
-	hndl = sock_diag_handlers[sk->sk_family];
-	if (hndl && hndl->get_info)
-		err = hndl->get_info(skb, sk);
-	mutex_unlock(&sock_diag_table_mutex);
-
+	hndl = sock_diag_lock_handler(sk->sk_family);
+	if (hndl) {
+		if (hndl->get_info)
+			err = hndl->get_info(skb, sk);
+		sock_diag_unlock_handler(hndl);
+	}
 	if (!err)
 		nlmsg_multicast(sock_net(sk)->diag_nlsk, skb, 0, group,
 				GFP_KERNEL);
@@ -184,33 +202,26 @@ EXPORT_SYMBOL_GPL(sock_diag_unregister_inet_compat);
 
 int sock_diag_register(const struct sock_diag_handler *hndl)
 {
-	int err = 0;
+	int family = hndl->family;
 
-	if (hndl->family >= AF_MAX)
+	if (family >= AF_MAX)
 		return -EINVAL;
 
-	mutex_lock(&sock_diag_table_mutex);
-	if (sock_diag_handlers[hndl->family])
-		err = -EBUSY;
-	else
-		WRITE_ONCE(sock_diag_handlers[hndl->family], hndl);
-	mutex_unlock(&sock_diag_table_mutex);
-
-	return err;
+	return !cmpxchg((const struct sock_diag_handler **)
+				&sock_diag_handlers[family],
+			NULL, hndl) ? 0 : -EBUSY;
 }
 EXPORT_SYMBOL_GPL(sock_diag_register);
 
-void sock_diag_unregister(const struct sock_diag_handler *hnld)
+void sock_diag_unregister(const struct sock_diag_handler *hndl)
 {
-	int family = hnld->family;
+	int family = hndl->family;
 
 	if (family >= AF_MAX)
 		return;
 
-	mutex_lock(&sock_diag_table_mutex);
-	BUG_ON(sock_diag_handlers[family] != hnld);
-	WRITE_ONCE(sock_diag_handlers[family], NULL);
-	mutex_unlock(&sock_diag_table_mutex);
+	xchg((const struct sock_diag_handler **)&sock_diag_handlers[family],
+	     NULL);
 }
 EXPORT_SYMBOL_GPL(sock_diag_unregister);
 
@@ -227,20 +238,20 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 		return -EINVAL;
 	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
-	if (READ_ONCE(sock_diag_handlers[req->sdiag_family]) == NULL)
+	if (!rcu_access_pointer(sock_diag_handlers[req->sdiag_family]))
 		sock_load_diag_module(req->sdiag_family, 0);
 
-	mutex_lock(&sock_diag_table_mutex);
-	hndl = sock_diag_handlers[req->sdiag_family];
+	hndl = sock_diag_lock_handler(req->sdiag_family);
 	if (hndl == NULL)
-		err = -ENOENT;
-	else if (nlh->nlmsg_type == SOCK_DIAG_BY_FAMILY)
+		return -ENOENT;
+
+	if (nlh->nlmsg_type == SOCK_DIAG_BY_FAMILY)
 		err = hndl->dump(skb, nlh);
 	else if (nlh->nlmsg_type == SOCK_DESTROY && hndl->destroy)
 		err = hndl->destroy(skb, nlh);
 	else
 		err = -EOPNOTSUPP;
-	mutex_unlock(&sock_diag_table_mutex);
+	sock_diag_unlock_handler(hndl);
 
 	return err;
 }
@@ -286,12 +297,12 @@ static int sock_diag_bind(struct net *net, int group)
 	switch (group) {
 	case SKNLGRP_INET_TCP_DESTROY:
 	case SKNLGRP_INET_UDP_DESTROY:
-		if (!READ_ONCE(sock_diag_handlers[AF_INET]))
+		if (!rcu_access_pointer(sock_diag_handlers[AF_INET]))
 			sock_load_diag_module(AF_INET, 0);
 		break;
 	case SKNLGRP_INET6_TCP_DESTROY:
 	case SKNLGRP_INET6_UDP_DESTROY:
-		if (!READ_ONCE(sock_diag_handlers[AF_INET6]))
+		if (!rcu_access_pointer(sock_diag_handlers[AF_INET6]))
 			sock_load_diag_module(AF_INET6, 0);
 		break;
 	}
-- 
2.43.0.429.g432eaa2c6b-goog


