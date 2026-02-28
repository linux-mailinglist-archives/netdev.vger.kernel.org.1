Return-Path: <netdev+bounces-262242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LkTNEFqo2mACgUAu9opvQ
	(envelope-from <netdev+bounces-262242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591C1C9747
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47FE630B2DF0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7F3D5220;
	Sat, 28 Feb 2026 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWTxhdIm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B223D413D
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317099; cv=none; b=i8y2ODznmMc/1A8gwyM2ABlKwY7qmHCwIaDyvWJwfZauwphtPDpUhwxhC+0BnHWUBWFshMLvVgnjhVYoGFog5QkWOkUhH2rABIWFVoxsCO+OWmHYY65kUfW+YJCYLXdPGHLuv3NmIFADQIV0n+v8iQXBC19zSK4xcgunUYsjgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317099; c=relaxed/simple;
	bh=WCkO26aKMnQK6Br7wlE+6vRrhOucmRK3aIERTgI8zs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQDfTujlKUacTeJemO20qt9PYTsJa3+CVZPxFBUFG52sjOg5cx1Y8J59gJJJFlSYgQk25jOJYoulLm1RGXdRm0hCN1R2zreIWZbtOuDGQ2OH+f9eD6x/380l1FAyoBhUzN/4bjpHVgqV771JrWV8//b5bSPwpOATUNkll2Wiyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWTxhdIm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2addb9ba334so31115475ad.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772317098; x=1772921898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZtopww28UDgef9H6bgED2tYKmbirriYIM+1Lzmlizc=;
        b=rWTxhdImmFCu0gRdKDThEgAkk0myjAB3vBHyw/TcQU1e41TtnBQHgIOlerRoVAmrw7
         MfRAUVQv6EKbXGg+I0uuD6+bzo6J84yIkevO32t8kJz5TdtnUaG3GyjuScx37gVOensQ
         S2BweWpjXEpEwPzwcS31uYJ1jW7pXNGmp55x+QRicaHR7SxtFCjR0qaN9uC3lRmNTmZY
         uq25W1onePcEZS7eY84ow5Sf47UHweEOUVMN777J9DwMwYBG51PoLKAo+T1pgvMPOTaM
         iSAB60p0V4pf7gLzTxE5SnMhh/LBdYSSRmnFn6abDq5TwbUY1HVBopeLJL4kVPckOOzC
         VsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772317098; x=1772921898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZtopww28UDgef9H6bgED2tYKmbirriYIM+1Lzmlizc=;
        b=Rt+PBM9zTiNEUgF0Ff27igWyRvGF1ePvBldBn/eo4pffx0zQxg0oaRClMM+4lIFk8N
         mU/vFQeSUJX4otJJBGkPev/XAMVbEAllhlNjfYmWLYl3AAx2YA6xLtCcpxPBFzaSMG+t
         zuoFW959dqAkCKHyaR5esRyACpvuUkOE8FaQF7LXQzCIGInsRMtLC0e6TZt61w0WwxXw
         ne8Br0mjTyok0q+WEsap2Q7EuRiB+dX29xj80d6crOWAtwAvE0+diLJpvd2BRBOTQTpj
         vv/eg3RaVKxUW74S9211qPlif7M8RIJ1X6niDw2OuWIeDcn97CKNM0Q0hgC7xctmbIJT
         pqJw==
X-Forwarded-Encrypted: i=1; AJvYcCXPwhpXcXw+5jFWQ0Ml9VM9k64Mt1QTUQkUniEeS1p/znx3twqyfU9mE0VnPWf8ObaL6Ktker0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5viPzGuOrzoYnAeQOn6yNhDEo1lPsoZxWV/gUydqquUw0Ikjj
	juP/JTHsYlGmHTqBXgqV4N39f6O2Zn/s3un8Hy156HfbmBc4Ms7hbpVxURYEXMXgwsTKH/M0jr+
	LfzDhCg==
X-Received: from plri16.prod.google.com ([2002:a17:903:32d0:b0:2ad:9a22:9aef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1250:b0:2a7:cb46:706e
 with SMTP id d9443c01a7336-2ae2e47e0b7mr70051135ad.35.1772317098006; Sat, 28
 Feb 2026 14:18:18 -0800 (PST)
Date: Sat, 28 Feb 2026 22:17:27 +0000
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228221800.1082070-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228221800.1082070-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
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
	TAGGED_FROM(0.00)[bounces-262242-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6591C1C9747
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 7e2aa2026f01..72761c8b2930 100644
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


