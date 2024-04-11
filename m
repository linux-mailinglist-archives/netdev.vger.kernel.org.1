Return-Path: <netdev+bounces-87026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F858A1599
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277421F237B7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295714F9DC;
	Thu, 11 Apr 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQOfo/wJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3014F13C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842424; cv=none; b=DJE/Ki4ylR5y4A4VAqjMnLdfvmqC5bSzX/iRxEXTNVGNYH0Zng/um5IWWyAchdGrNkyLQ8owtj0ZlIJHRfg5p5ASkewENHaMMeC7KQ7FY17nd1ZDW0fyZxvoAo/TXaxc9MVZVYKENg/awDdiO7U/H4nGDxOo0fmMG7Vj6zlvd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842424; c=relaxed/simple;
	bh=DQ6Qf5EwwILmRze6B/d5l88LGl7W1rvlFzle6fNTeh8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RzF/4d0VlXWHK3BkDZLCFxhX6rzeJYgV13sHSCBtrFR6M7v5m7y0X7lp0Ds4V7LJFxcJKtg3Uo0y4xMWBlTpHRsX9OMqTSkU3t0CTEJ2uX97FyBaIyMkmZ4tKZp2AcjF1HizbkI3z/PcGwjEMpTH2wBC7CZNxBVM+wkemgcCWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQOfo/wJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so10460095276.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712842422; x=1713447222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vmYVEheapt1fOA+JO7PC34b2pVFmxJR1f/N7nO6pXig=;
        b=iQOfo/wJfGRmgQxBI+qK9oR6V5V7XUUmQIsVutyYxD7+i5AjpgATzqCGMwUKPA9WaG
         xRhRUBQgkW0FlWNFMyGPPvHjoUuTarRph4qyjx8ULGwqtWV6hEznFBrN+46rOak9php9
         nOXi64Hr1nPyHqppj4Lf+iaRLxf9iohEKWEIAv9WPqMuPLVP+/E7ScVX+D72gugzsW6G
         BUc6deKcHeyJNaP9Rg16kSKy4gXov+GAZnfax7lSFlsh+B2GUy3xx0/Y6Ap1vYZWKvQC
         RmhvcuV70SISSDYla5Qn47sPgyASuSSlFWfKbBzAmw40rnryLHOwDLe/F75y9mdeVGlS
         w6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842422; x=1713447222;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmYVEheapt1fOA+JO7PC34b2pVFmxJR1f/N7nO6pXig=;
        b=hQnuXzArvkyMANLzZ6G7K9H9qJus0pnvcSaEku3lWrCygagSmNodcqdZA+QPQdtjmo
         2R2YACp/1JDVyeGzaZ2arUit/EMpNofMIRrlzz9vuWZbg9wPRCsLQJuol8PX2FKkLeMU
         NomwjruUiRxlkXE2YrjJCMJHo+B+mpS8ZIY/dJv/3fEqGAIF0oZLlZmOE1moA6fXnxf+
         U8NqxBBNtLc1pN3h+SZVXJbwy+5Qk9raEraZtoBofud4acPeHRSuEo3X++FtbSlvH/b+
         sQCPlTCQENiEf4o8dEZ2kZ9CyYjA3zujuLw+qQ7vsQ1jOrJUa/3lzoAmEko06QGF+tFw
         Ohww==
X-Gm-Message-State: AOJu0YzA4QDZmWdbM22K8aJZmS4jPkJjI2QgPn+plDcQv5wcZQtge/hL
	cFIJKMpqM4/fIsH0yeWJtj3KHeqpierTw7L2GexVq9yTX2hCdA5BZQjU8PhZGgHUZA5sjub1N6Z
	q0lNtYgMaYQ==
X-Google-Smtp-Source: AGHT+IGa83UFxAU8A0T4eg6mbDaquPntDl6S1jiVXTl6oWY7BlhHHqNt3xLMfZ6+9jW2Gkx4af5tCHxvzU+Psg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:70a:b0:dc6:dfd9:d423 with SMTP
 id k10-20020a056902070a00b00dc6dfd9d423mr544540ybt.3.1712842421636; Thu, 11
 Apr 2024 06:33:41 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:33:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240411133340.1332796-1-edumazet@google.com>
Subject: [PATCH net-next] fib: rules: no longer hold RTNL in fib_nl_dumprule()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

- fib rules are already RCU protected, RTNL is not needed
  to get them.

- Fix return value at the end of a dump,
  so that NLMSG_DONE can be appended to current skb,
  saving one recvmsg() system call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/fib_rules.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 3f933ffcefc3732ede48669cf0ab9e94fed46aac..6ebffbc632368168b621a3ee888ee558e88e2d4f 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1142,10 +1142,10 @@ static int fib_nl_dumprule(struct sk_buff *skb, struct netlink_callback *cb)
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	struct fib_rules_ops *ops;
-	int idx = 0, family;
+	int err, idx = 0, family;
 
 	if (cb->strict_check) {
-		int err = fib_valid_dumprule_req(nlh, cb->extack);
+		err = fib_valid_dumprule_req(nlh, cb->extack);
 
 		if (err < 0)
 			return err;
@@ -1158,17 +1158,17 @@ static int fib_nl_dumprule(struct sk_buff *skb, struct netlink_callback *cb)
 		if (ops == NULL)
 			return -EAFNOSUPPORT;
 
-		dump_rules(skb, cb, ops);
-
-		return skb->len;
+		return dump_rules(skb, cb, ops);
 	}
 
+	err = 0;
 	rcu_read_lock();
 	list_for_each_entry_rcu(ops, &net->rules_ops, list) {
 		if (idx < cb->args[0] || !try_module_get(ops->owner))
 			goto skip;
 
-		if (dump_rules(skb, cb, ops) < 0)
+		err = dump_rules(skb, cb, ops);
+		if (err < 0)
 			break;
 
 		cb->args[1] = 0;
@@ -1178,7 +1178,7 @@ static int fib_nl_dumprule(struct sk_buff *skb, struct netlink_callback *cb)
 	rcu_read_unlock();
 	cb->args[0] = idx;
 
-	return skb->len;
+	return err;
 }
 
 static void notify_rule_change(int event, struct fib_rule *rule,
@@ -1293,7 +1293,8 @@ static int __init fib_rules_init(void)
 	int err;
 	rtnl_register(PF_UNSPEC, RTM_NEWRULE, fib_nl_newrule, NULL, 0);
 	rtnl_register(PF_UNSPEC, RTM_DELRULE, fib_nl_delrule, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETRULE, NULL, fib_nl_dumprule, 0);
+	rtnl_register(PF_UNSPEC, RTM_GETRULE, NULL, fib_nl_dumprule,
+		      RTNL_FLAG_DUMP_UNLOCKED);
 
 	err = register_pernet_subsys(&fib_rules_net_ops);
 	if (err < 0)
-- 
2.44.0.478.gd926399ef9-goog


