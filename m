Return-Path: <netdev+bounces-295464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fdOHBZwAImriRQEAu9opvQ
	(envelope-from <netdev+bounces-295464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495A643DAA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YsbhEWqY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295464-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295464-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75118301BCC1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3633C53D;
	Thu,  4 Jun 2026 22:47:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E930BBB8
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613255; cv=none; b=g2bD+7oaOPQLIS1KpvYDPbX0KuEKYL6YHqd5O4FQ/hlJXW4PVfJDtltYXaoPfFRBSQ0DosQQHYBPl1/wlzmNmP6Ti0EENQdwpfTr/1Sz0mSiaf8zw/irlnCoK/F2zco8ijGRbjkBhAekDPF229UgkijeHauD3zf+pxuI0A41Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613255; c=relaxed/simple;
	bh=BzcXQKD/yrPU9UkHFgeVhSkgiUlgGfje4YnWri/9hFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cp/8FZYAjxpv7HuqyjP6S81eLI8ccuzQXCISyDRobR7P8F9gV1qUmfOlBxTpvRNjKdGG253iHIHVUfiQj1RxaUwyH9xjjP3WYMGe7wtRPE7F9lA2yvRWM+5DO7htZ/g+7kusX15A0zskIKxcPVhad7kTMWhC2479wszVfjsrFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsbhEWqY; arc=none smtp.client-ip=209.85.215.202
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so697221a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613253; x=1781218053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hS93QHUhKTC5Mqk2wjkFWr+qJA+1CM25zSZnEPzPg84=;
        b=YsbhEWqYEzzbwePpy88/f5TRhFMHrDXyFq3rxBwetraRAqmS7gdazRFuioTSQ6+GbE
         abRcMfRU5oJ9qHo7kz7bG/j2vk0qDNowkyMl9imNJwab9Bc2+an4+lNGB1cDdLgTIfjB
         ImYYT0OTa8vOhqbpZnrRanViyJqA86LWsqlacG1Plj0oYb/CXOxSX8YRHVL4AQ/7A6z4
         7ExLt7ClZRSDsEq6IM21HDjeLsSihmvG0og0Dbi3i6kh06erueSTw8nwk6b6jftFA++r
         6Ay8tvPGi7Co7qcx2vrLc6P2kjHa+c+GICcScVTnCsum1K7HHSpiELU7o8/mYlY6UcFX
         w+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613253; x=1781218053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS93QHUhKTC5Mqk2wjkFWr+qJA+1CM25zSZnEPzPg84=;
        b=bftOACpXqw+u7W3drdBcx65XMsZpDegP7XT/Htf6vMgMsRqAMgXojwPv9QiXrhdp+k
         1T4GNIWHARhW0iOMJYv9tvdpMTbZkb2k68oN7DQOkiAMKXy3m0H9CKvP8VmO/kHLYVcI
         N3pkguojw9x8HMPn8uRsIXvuwpDIx+oLtF2mPL+ymY3UFLLBFcm8EnSonUJxpNBP9IEN
         2QQ5qxX04rCOLNJujmsL/CDAGvl26ErP3rBwQinNhwHINXmMS+KzYFzsaHVT9dui45yc
         jdgNozj/aYCYP9Cuw6aZpCe7tnpi41iRrA6ndzOK4VPm7DvcQOHOfGgybZP9BI/uaItN
         a7DA==
X-Forwarded-Encrypted: i=1; AFNElJ9wEKmq41cx0XwQYwIUfV6ZQJCMi7a+D6cw3fu/K7bG4uzBlLmm0ylnlqRTXGMAYoMJxZWA5iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcvc0vQot1ncTjE89LGbl0dgIXZEwFJfO+5blMwm031RmeJ74W
	VoBCNzBCkKtYCAr+u2i62bIfp/DX7wo8vh8T3FNRtZxGbASxeWWCy9U1g9VarzoC+tZuzCLwMrV
	NAqvDTg==
X-Received: from pgvt11.prod.google.com ([2002:a65:64cb:0:b0:c82:743c:ea8f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2c11:b0:3b4:7c33:296b
 with SMTP id adf61e73a8af0-3b4cd00b6b6mr1131681637.32.1780613253231; Thu, 04
 Jun 2026 15:47:33 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:31 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-14-kuniyu@google.com>
Subject: [PATCH v3 net-next 13/15] ip6mr: Remove RTNL in ip6mr_rules_init()
 and ip6mr_net_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295464-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1495A643DAA

When ip6mr_free_table() is called from ip6mr_rules_init() or
ip6mr_net_init(), the netns is not yet published.

Thus, no device should have been registered, and
mroute_clean_tables() will not call mif6_delete(), so
unregister_netdevice_many() is unnecessary.

unregister_netdevice_many() does nothing if the list is empty,
but it requires RTNL due to the unconditional ASSERT_RTNL()
at the entry of unregister_netdevice_many_notify().

Let's remove unnecessary RTNL and ASSERT_RTNL() and instead
add WARN_ON_ONCE() in ip6mr_free_table().

Note that we use a local list for the new WARN_ON_ONCE() because
dev_kill_list passed from ip6mr_rules_exit_rtnl() may have some
devices when other ops->init() fails after ipmr durnig setup_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e9560205b547..b13ce9c2c463 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -253,10 +253,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 
 err2:
-	rtnl_lock();
 	ip6mr_free_table(mrt, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
@@ -272,7 +269,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt, *next;
 
-	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
 		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt, dev_kill_list);
@@ -345,8 +341,6 @@ static void __net_exit ip6mr_rules_exit_rtnl(struct net *net,
 {
 	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
 
-	ASSERT_RTNL();
-
 	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
 	ip6mr_free_table(mrt, dev_kill_list);
 }
@@ -427,15 +421,19 @@ static void ip6mr_free_table(struct mr_table *mrt,
 			     struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(ip6mr_dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 			    MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC,
-			    dev_kill_list);
+			    &ip6mr_dev_kill_list);
 
 	mr_table_free(mrt);
+
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ip6mr_dev_kill_list));
+	list_splice(&ip6mr_dev_kill_list, dev_kill_list);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1384,10 +1382,7 @@ static int __net_init ip6mr_net_init(struct net *net)
 proc_cache_fail:
 	remove_proc_entry("ip6_mr_vif", net->proc_net);
 proc_vif_fail:
-	rtnl_lock();
 	ip6mr_rules_exit_rtnl(net, &dev_kill_list);
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 	ip6mr_rules_exit(net);
 #endif
 ip6mr_rules_fail:
-- 
2.54.0.1032.g2f8565e1d1-goog


