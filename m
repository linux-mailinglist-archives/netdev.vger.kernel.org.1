Return-Path: <netdev+bounces-261133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI39GHqyn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A81A0298
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E2D30C8D2A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56CE37AA91;
	Thu, 26 Feb 2026 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEzLs5rR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744137AA80
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073416; cv=none; b=LrkeUP1Fg9v2nwp99vx/Xp6WEeq7T28km0IncXuzzKwNLn6E1QRUQc2RxpV63tijT9keH74Ig8n2efDCc6F6tOS1T64URAZFkmyPE+tZDDgrmNi0eqfo1Tn0Rkp32ehS8wPFxWuC2zU8p1srJUfBx/2/8PXIYsDeGMtXIjq+2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073416; c=relaxed/simple;
	bh=VDo+w0CyyEJ4kcSEGgacAf6OSR8P8qQo1DZo2Q/Bw7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrAr/0bpqYO6sbuOMb4GlrgrVwHQDIFN/W8VF8qks6BScovj8DHNXFE7E/rzna2VQco/QLQzz3EZRNrUSy5Qp966TTLz/UO5mcETNbraZyCTxJEp+8wqDQlv1Z8NrWdbfwS8QtNTW5/6bGZGAB0KAO+JN5WFkTCFecCBmxAcK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEzLs5rR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70ea2f7d1bso201353a12.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073415; x=1772678215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGcegAKxn6KPl2Gual+q5AoMW6DeXlNBlqVeAxuVBVc=;
        b=JEzLs5rRHipNTqBqxEkR0SZttZ5OIeYAaviVHyZfAyeyX4FC27M/Su+VQBdZxf9qwG
         LyWK5SkK/FUtv+42tjvPRO3rNppUdUxb+V4akZPDyOOqRJMrsH2ZtiEFCEZtpZAjMnAs
         Hsc5zuewr7VTa6Hmej5NOWyiCRoYORJTq/sgB3wwdACO3uIlhF5J1YSizeQjBvilnqGP
         KMReCHkQ/uJPl22TAk9u5TwV5/yGoKm5BfXBPA8D/mOsy7MV29uripeJYhvDnEKVzYHG
         gUjWzeo6YF9dPaJMn4zvJ0hwmLtVSgWxjhUhF+pg0FKRlmb91GcP0y3AEI9XCfo75GrR
         DtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073415; x=1772678215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGcegAKxn6KPl2Gual+q5AoMW6DeXlNBlqVeAxuVBVc=;
        b=qOhMiRdBjgsVmhpfYYFkqs5VtQFgR9x9lkP0MP7kFeZlbxntcnWZqh7SabnMRfRSUc
         uDA6B9SbRy3uuRuYd+BjNZEEWvxMR76fvlzBAM5fwz4k9A/dQgFtBEHjLJ34G4BReI+0
         7TRpqJnlGe1ulaGwh7Zms/8zYowXjoWsW6z7Ym3S3jhKDEod1NMEKfCPuLq9MihTfQlZ
         AxaWJh/x1aSgyf+SMPSmPTcXm33obtJH+a7i4plgHG6EU1lRJQWIW0RW34Ridkq2q+eI
         Ns+AQulo5CWF91pEJc0IdKILQVrxEAenv6+VAkeoCdEIh0w7a7CIEffbhx4gxt4YJpfi
         1SgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1OxYqICokIWsSJGX5pgWeEZvSzfx6vil9s/e9fRSYd6KbErwgXJOhX+IkTEY3w7C8bEsj2JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJAFCYE8+F+0OfEpApUwVYw8C3W2vXSubFDCdZaaGm4+hMlbb
	tBjFCZ+RRVJRaqauKvcUE5vigiewKccbwH+HH0X0pW/qPLHI0CntT25CiuksMjec8u0RaOnLeQg
	QKPgrqg==
X-Received: from pjbnp11.prod.google.com ([2002:a17:90b:4c4b:b0:353:31e9:fe44])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b8f:b0:38d:f405:709e
 with SMTP id adf61e73a8af0-39545f86711mr14985130637.48.1772073414618; Wed, 25
 Feb 2026 18:36:54 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:21 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
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
	TAGGED_FROM(0.00)[bounces-261133-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: BD2A81A0298
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
index 3fb50307fc2f..3526c9afcb03 100644
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
2.53.0.414.gf7e9f6c205-goog


