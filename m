Return-Path: <netdev+bounces-261705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOqDMmYSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 307651B255D
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D8330E1877
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36393328F0;
	Fri, 27 Feb 2026 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edz2+0Dw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF47332EA8
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163563; cv=none; b=KRGqsvIlw4onyh7KtCuedVTI5bTuns5mUXW3MHzmgdojxQBa1KAqt8bNVgaRgwh+x/7c3GvOXe5PkJYrpB/suJlUCnjLO/fQvS1XNwFeTq65lENy3/hsWFlyUjbniL/ao9q66qyLeLq0ROodRaVkXUMJnN962KrFqReouir3wrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163563; c=relaxed/simple;
	bh=4qXbuPSgOJoWPa70urEgNdNqQH1Ky+PMOHsEDpzZ1Y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W87xPkmWusMDEvJmMFQ4cD1b4s/am4ENsNQ7LN3iE9ErbrIJNu8mSkWMtIZUHl/Ypb8XdQqkvSUAhmlMxOthQKffP3oqTa7PuxvzJr5oWOybe14O0zR1+AOpKEeIySmiBbOVIFedYHaMXf4v3gmuRBIcPbc/O5jBDBXiRNsfKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edz2+0Dw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so961869a12.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163562; x=1772768362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEdJ5dxoRBCcSnyUNQqSfjxYRnfu75zmwbwCN3BmBds=;
        b=edz2+0DwFzT48a/B0kJExZHItiTimstPG0Pw6+XzSH8at4Y4GE38HbUKyKRpleJGf+
         skF9Yh4mkR5Pr6Xyajl/HoLKy5J46v9aek9eOoOf/woUYr56qi8OhsRJbenZJuQIkm4a
         8M3TPOhOAm/8B7mT3fg7l6iL3Fa48Usb7IBkGoLjcoJBoXdv6I+d2GaoAOvFyy2McfLu
         Uff0oJ0odPYFwiV/kIgb9n7NJUIQwt9FRqKpfFhLcJOAa/uBqSJUf8xXmixBhX10/oP8
         hVv76F52CtIdHonV2EDH4i3oSjdZqu1uU4hkIbuaZO47Y51Litr565ksyXYjk/j5McoP
         cIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163562; x=1772768362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEdJ5dxoRBCcSnyUNQqSfjxYRnfu75zmwbwCN3BmBds=;
        b=RQcQtIHc/4NhFVdDWp1CwKfm2rdZKwzRYR924hOmH6Qv/ZtiFmgcOva8d8vDpwlVzR
         Wyw/4zHhz+kqxj0qzI9ltBec3TkkxMgXm0RxfUqsPufkv5E3gurUcDTNg/DTY8famdyf
         LX6k2n3CEGG1WeW8ZjIIFqC9tHr1teAqdGpD5ry5H0Qbok7bPN3jOPj+PGzyjflidKU3
         FnKRS3qJTeoyQUsC0hs5RyHN/nlqH94OMLLWxR6+E6zcpAfHKlFYikxCD+SBk7lIpewX
         +U1Xf8H1gVDCC6okencq4wrG4a1WL9XmD+yW9BGAG0OTZkh0qUTWSKRc9rtaetHq3NT7
         F3lg==
X-Forwarded-Encrypted: i=1; AJvYcCVdLUQi4Kkyg/Ub6F7pGVFNG8BGXI2GNwg1RT1djFcwghJqXGCLwdiYOT9fPJ7Ek4ufmwAMv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4kfLk7T3ohOG5O5vtHLsiYavEJZTSVIMFvy1BY7VeZ0Jtast
	PspVnTK54gz+Xluw4eroGsFWb+JTqkYm/pJxbb9QNdtPTw6psH9kgdiVdNe3uVkPMPOoVDUmpyH
	XflZLUA==
X-Received: from pjiz1.prod.google.com ([2002:a17:90a:6081:b0:359:7f9:79b1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5847:b0:352:ccae:fe62
 with SMTP id 98e67ed59e1d1-35965c34bd3mr1309620a91.10.1772163561649; Thu, 26
 Feb 2026 19:39:21 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:32 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261705-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 307651B255D
X-Rspamd-Action: no action

ipmr_net_ops uses ->exit_batch() to acquire RTNL only once
for dying network namespaces.

ipmr does not depend on the ordering of ->exit_rtnl() and
->exit_batch() of other pernet_operations (unlike fib_net_ops).

Once ipmr_free_table() is called and all devices are
queued for destruction in ->exit_rtnl(), later during
NETDEV_UNREGISTER, ipmr_device_event() will not see anything
in vif table and just do nothing.

Let's convert ipmr_net_exit_batch() to ->exit_rtnl().

Note that fib_rules_unregister() does not need RTNL and
we will remove RTNL and unregister_netdevice_many() in
ipmr_net_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipmr.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 766668ec5183..d12e08c99518 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -285,18 +285,17 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return err;
 }
 
-static void __net_exit ipmr_rules_exit(struct net *net)
+static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
+					    struct list_head *dev_kill_list)
 {
 	struct mr_table *mrt, *next;
-	LIST_HEAD(dev_kill_list);
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv4.mr_tables, list) {
 		list_del(&mrt->list);
-		ipmr_free_table(mrt, &dev_kill_list);
+		ipmr_free_table(mrt, dev_kill_list);
 	}
 
-	unregister_netdevice_many(&dev_kill_list);
 	fib_rules_unregister(net->ipv4.mr_rules_ops);
 }
 
@@ -353,14 +352,12 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit ipmr_rules_exit(struct net *net)
+static void __net_exit ipmr_rules_exit_rtnl(struct net *net,
+					    struct list_head *dev_kill_list)
 {
-	LIST_HEAD(dev_kill_list);
-
 	ASSERT_RTNL();
 
-	ipmr_free_table(net->ipv4.mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
+	ipmr_free_table(net->ipv4.mrt, dev_kill_list);
 
 	net->ipv4.mrt = NULL;
 }
@@ -3264,6 +3261,7 @@ static void __net_exit ipmr_notifier_exit(struct net *net)
 /* Setup for IP multicast routing */
 static int __net_init ipmr_net_init(struct net *net)
 {
+	LIST_HEAD(dev_kill_list);
 	int err;
 
 	err = ipmr_notifier_init(net);
@@ -3290,7 +3288,8 @@ static int __net_init ipmr_net_init(struct net *net)
 	remove_proc_entry("ip_mr_vif", net->proc_net);
 proc_vif_fail:
 	rtnl_lock();
-	ipmr_rules_exit(net);
+	ipmr_rules_exit_rtnl(net, &dev_kill_list);
+	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 #endif
 ipmr_rules_fail:
@@ -3308,20 +3307,16 @@ static void __net_exit ipmr_net_exit(struct net *net)
 	ipmr_notifier_exit(net);
 }
 
-static void __net_exit ipmr_net_exit_batch(struct list_head *net_list)
+static void __net_exit ipmr_net_exit_rtnl(struct net *net,
+					  struct list_head *dev_kill_list)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		ipmr_rules_exit(net);
-	rtnl_unlock();
+	ipmr_rules_exit_rtnl(net, dev_kill_list);
 }
 
 static struct pernet_operations ipmr_net_ops = {
 	.init = ipmr_net_init,
 	.exit = ipmr_net_exit,
-	.exit_batch = ipmr_net_exit_batch,
+	.exit_rtnl = ipmr_net_exit_rtnl,
 };
 
 static const struct rtnl_msg_handler ipmr_rtnl_msg_handlers[] __initconst = {
-- 
2.53.0.473.g4a7958ca14-goog


