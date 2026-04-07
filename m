Return-Path: <netdev+bounces-276176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDZZOXR11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC1F3B4FB8
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ED4230651DD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAED137D12A;
	Tue,  7 Apr 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6d9Pwrk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2237C91E
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596826; cv=none; b=qSfYNoUFk5ez7KumjtWpkSuN43hnijMk1DRzKfkq4sIbNVB9NNN+dCyvP34nRfkuYZMKhB8AMKxkoCTdJyVK2E5V1r8vyG1EtsC7Nd0eSfQC4AT0kQ7U2viKVW52/xcmllXNfIjXZmaIULmk9NNfm7NPwWmhQQPs+pctSZVCbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596826; c=relaxed/simple;
	bh=PMQZuuy5AfuCL4BbGvel5RuD4La0BFd4w696/1ydzSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kUTB3kyrZXyf2z8KA/mmLfW/l7CWtO54oj3s4EkwNdCUP7bPZOvLpl/ij5RXpegaRy2W/1Zgs3+QlncUDKp3JUoU5lFk/k8md3GvGHiXCkOMraUiTCN6OXrQ3GGdpKXAaOOjc4G9fY5SqchE/ZcZLM6M7i3LAdcUrcfc56CIPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6d9Pwrk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so1724451b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596825; x=1776201625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJg10AjZP+4d5prQ6SKPR/goghc+zTECvweVbOHF5Lw=;
        b=o6d9PwrkUoEg/V9iaNWqYmu6ZeEdoSeOfjAPv7/3CXs1Dmr3772/glV3c94mBu7PjS
         FUtPv4lfXHEiqkw2ucMgDKKu6alIy+RxvTHDuj+N35Cy7h3Y2szN45/CmntPdpswfEH3
         eCdPWrp13ZKLquLn4HftgZ6UGmmsDinSdKMGfiA/IZ8tr7W0M+OzJeMAVzozZmaCBjTB
         WyFGvjZCklsS5WF/wU2Nw6suJtwbEfAGb1tunpmABTnZ8j3ij5fon0rEWILDQs45MIFw
         P3edCrEj2Oaf3Bcl7lfd2Cn+Rf7igPXIvzT+xWMYdEW2a04XFHu78CaSdwBHZOhqKmON
         6Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596825; x=1776201625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJg10AjZP+4d5prQ6SKPR/goghc+zTECvweVbOHF5Lw=;
        b=H9hZjBtyh7Qr9wTNcKn09Fa00aE1oX/5vUWXIoGnF66BhN/fr4vA94oOCYfPTWupH3
         6iWqHFLKzHHTmXVY6WZ7G9qXRLYLOxxvyKSX2zbCYWu2gTcWi0BzdtiwbHnrND9/Y9rr
         PD0iSlukyhfQRXOYmo4BB2+9UiBzhVAZJ97fVy8VUwTqSx3zPdO6CfRjFIFMm3CF8GnJ
         WfTrrLaAY690rfhKVYqb+6bjhOSHWc1lHL9c12G4vWo1B6CUqwEI44oHMWCFOlK7U02N
         vQjigDo4JZsavz3vHoBTqBOmdSVYoqnKajJkq7EcGpzTq35dnVm6aPU5nnHvUiqvA92w
         w3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm4QlS3vDnFUsih9b+QhNrwkGvz41nYqgTlr9yZ512acBioib2rqZezyHJLjcWXT2G2D224y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDcRt7LhkdFI/wCw6FchvKTajdC1ozBNDY4RJMBRBjWBP+pG6a
	qeckArwayoZmjyXjWHZAtk5S59LYk+RbVbmM7LzzFNV+5YY5GKEptBbV2I7k8TF0fOaX8LoSlUs
	f2yyHJQ==
X-Received: from pfbfb10.prod.google.com ([2002:a05:6a00:2d8a:b0:829:9082:12ca])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a824:b0:39f:43c3:b895
 with SMTP id adf61e73a8af0-39f43c3c171mr11754405637.57.1775596824747; Tue, 07
 Apr 2026 14:20:24 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:46 +0000
In-Reply-To: <20260407212001.2368593-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407212001.2368593-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-14-kuniyu@google.com>
Subject: [PATCH v3 net-next 13/15] ip6mr: Call fib_rules_unregister() without RTNL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276176-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC1F3B4FB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fib_rules_unregister() removes ops from net->rules_ops under
spinlock, calls ops->delete() for each rule, and frees the ops.

ip6mr_rules_ops_template does not have ->delete(), and any
operation does not require RTNL there.

Let's move fib_rules_unregister() from ip6mr_rules_exit_rtnl()
to ip6mr_net_exit().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e5a1d2c48b1b..b1443fb65b40 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -269,6 +269,11 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return err;
 }
 
+static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+	fib_rules_unregister(net->ipv6.mr6_rules_ops);
+}
+
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 					     struct list_head *dev_kill_list)
 {
@@ -278,8 +283,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 		list_del(&mrt->list);
 		ip6mr_free_table(mrt, dev_kill_list);
 	}
-
-	fib_rules_unregister(net->ipv6.mr6_rules_ops);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -336,6 +339,10 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 }
 
+static void __net_exit ip6mr_rules_exit(struct net *net)
+{
+}
+
 static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 					     struct list_head *dev_kill_list)
 {
@@ -1364,6 +1371,7 @@ static int __net_init ip6mr_net_init(struct net *net)
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
 	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
+	ip6mr_rules_exit(net);
 #endif
 ip6mr_rules_fail:
 	ip6mr_notifier_exit(net);
@@ -1376,6 +1384,7 @@ static void __net_exit ip6mr_net_exit(struct net *net)
 	remove_proc_entry("ip6_mr_cache", net->proc_net);
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 #endif
+	ip6mr_rules_exit(net);
 	ip6mr_notifier_exit(net);
 }
 
-- 
2.53.0.1213.gd9a14994de-goog


