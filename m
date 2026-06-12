Return-Path: <netdev+bounces-298471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uANODDuoK2oiBgQAu9opvQ
	(envelope-from <netdev+bounces-298471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DD676EF2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:33:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=swoqgCio;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298471-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF2F308AAF0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB5372076;
	Fri, 12 Jun 2026 06:32:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F423D28C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245959; cv=none; b=bQMgLN4+rkFR7Oj7JYhjxXIipWw/1o0gfvkpszRebeRKknXj9ppKpWzNeVT2QZvhDmnrIwQOENUcn5GY604QEudNavQjudFo5tuuM6StFrn688akyy7bn6Rw2sapvgjPtg2aSPPBRUQmMoAZpOxp9cHLdkanzm1x786mZrHiBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245959; c=relaxed/simple;
	bh=YLG4HI3KlTfiY6Po1rVHchoQ7h70JWT6mwmfPKE0ifs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0jlkZFHZtH0s4pbSezF2QskYNc6F7ooAQl1TCEVZ7vPryS0rbyvj76G+08UXPmRK5gFmpWRl8fQ5P38LCo18knOEFVluqZicWRNxrS29pYAF8jwocr1teJf7RlbcBbgdNV3H1wrup24yd2VUGN6LoMQ+zli4E4uzbReNy2MQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swoqgCio; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84238e83851so481271b3a.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245957; x=1781850757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouT4/0EnEXGITLuvsTyEdVlJxZvQptldR6Xim6QknVQ=;
        b=swoqgCioLf4IDKqRxTexnWbHJ19QPPsTrxNIm66CTrJLZFEJmsjNaZSTf3n3ua3/8u
         3yexuePq8LwySoMlPzZwTOIXGjYj/T8LqRCZAB8fFcQQ7ONO2hQJuvlYSZshj4A/plYd
         BzbdW/Y64QD9/nlbJWLOI4VFv6CPhsCPk9T7VGN2EnlaboUCtLu2Rx/5Y7a698vwm0T3
         C7T/Wc82+IjeJtrwvGZlo21yp4WFC0RanVFkBC7XSbbt/P+QX240Oas1PFFiIIeg3M41
         AZs34KL6mX0zlxB3Xe9AmwpqnwI+87YeQOTUT65KeEgohAIpmjMOh8QMDS214BQjRMk/
         aS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245957; x=1781850757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouT4/0EnEXGITLuvsTyEdVlJxZvQptldR6Xim6QknVQ=;
        b=pekKRMGAhgHu9IQW59c7Qa2aGRtnIMMz6+EMTMVOEIBt9rGNAdVGjHQJF+b9/0b7/e
         MHTMIpe8OnGi/3dtreY5PuQkMKOw49ttcDmE4/TLZwXccJlk1XwbjcVaEKNytc1te948
         5EcfaiWZez7XNshOoluw34YlGs3ikFDiOeSmzbnLZObocpcpcJmDS1imEZSuVML0nbeA
         WVJ1eMkNrY03FZmza6GyTlOFlkJ/zCuBw73f5LRBY7ZamLOGhY8StawjsaAxsYN/byZd
         G2JKxIEp8LJ9pdXK4DG0qPiKjmMfYKZW3rrFtJUGqKgtK0wO+jBHj4dPysFpMzsGzKUz
         QnFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Q8/h9cNskndjkYOrvK6NoaQkFNxJ04sA3VJ7fEGHqkQxSPlnu3t7q8SpQ06L+ZvghElaQQdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTe+Rzo56rwOiyUM/0AfvxnzRp1avFlmlgrtbJi+8DuoBexyM
	umBnRZOwOaTF6Mvm/RkoW104aF4sNQX8PikIP7w2W4o89hs0zD0vd3S2McN/WCVgAKLcOXHtpp5
	jGfW+BA==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:842:3bd7:f2bf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3988:b0:842:706e:ad43
 with SMTP id d2e1a72fcca58-8434cecab5emr1550922b3a.33.1781245957166; Thu, 11
 Jun 2026 23:32:37 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:08 +0000
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 5/5] ipv4: fib: Convert fib_net_exit_batch() to ->exit_rtnl().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298471-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A46DD676EF2

Currently, IPv4 routes are flushed in ->exit_batch() after
all devices are unregistered.

Unlike IPv6, IPv4 routes are not added from the fast path,
so we can flush routes before default_device_exit_batch().

Let's call ip_fib_net_exit() from ->exit_rtnl() to save
one RTNL locking dance.

ip_fib_net_exit() must use list_del_rcu() for fib_table
for the fast path on dying dev.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_frontend.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index d147471d1d8e..c7d1f31650d7 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1607,7 +1607,7 @@ static void ip_fib_net_exit(struct net *net)
 		struct fib_table *tb;
 
 		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist) {
-			hlist_del(&tb->tb_hlist);
+			hlist_del_rcu(&tb->tb_hlist);
 			fib_table_flush(net, tb, true);
 			fib_free_table(tb);
 		}
@@ -1663,29 +1663,24 @@ static void __net_exit fib_net_pre_exit(struct net *net)
 	nl_fib_lookup_exit(net);
 }
 
-static void __net_exit fib_net_exit_batch(struct list_head *net_list)
+static void __net_exit fib_net_exit_rtnl(struct net *net,
+					 struct list_head *dev_kill_list)
 {
-	struct net *net;
-
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
-		__rtnl_net_lock(net);
-		ip_fib_net_exit(net);
-		__rtnl_net_unlock(net);
-	}
-	rtnl_unlock();
+	ip_fib_net_exit(net);
+}
 
-	list_for_each_entry(net, net_list, exit_list) {
-		kfree(net->ipv4.fib_table_hash);
-		fib4_notifier_exit(net);
-		fib4_semantics_exit(net);
-	}
+static void __net_exit fib_net_exit(struct net *net)
+{
+	kfree(net->ipv4.fib_table_hash);
+	fib4_notifier_exit(net);
+	fib4_semantics_exit(net);
 }
 
 static struct pernet_operations fib_net_ops = {
 	.init = fib_net_init,
 	.pre_exit = fib_net_pre_exit,
-	.exit_batch = fib_net_exit_batch,
+	.exit_rtnl = fib_net_exit_rtnl,
+	.exit = fib_net_exit,
 };
 
 static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] __initconst = {
-- 
2.54.0.1136.gdb2ca164c4-goog


