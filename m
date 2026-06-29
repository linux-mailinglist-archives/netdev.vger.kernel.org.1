Return-Path: <netdev+bounces-302767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dGwJBdi1QmorAAoAu9opvQ
	(envelope-from <netdev+bounces-302767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7C6DDF20
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jN9s0XfJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302767-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD16304482C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0511C3803CC;
	Mon, 29 Jun 2026 18:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2730380FF1
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:12:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756754; cv=none; b=WajiMNcMMtzyS8Kv8A4jPWjhkrAENJz9zcG2Hm8ul09ViuyCZ0nArKMJ6qwLdNMr//NIaGWud1IqIaTJjzvgvOAkA+YCeLIf/5PJ/IxZXkcYjD94wB1LFwNuxRfkakSrPA1TMw6sUhnLHJMANUbR9oxzp3SKoNTq6ZXxGCQeRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756754; c=relaxed/simple;
	bh=7RKCowRGBMaXVVpImDoOd6T9osaFQb6cLqDtgOOGGsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b724Z+hsldfO8k5ABgzWhLvMWSmfFXm5gVBfkU9l2X0wiD7Ekra0oVKHn45hGV+Qaq2C5OrOmRuIyigupd/SK4Jbvdyi8nBC2EtCoh433wwTOb2S0hX91oyMS+capvPPgToM830M4ssfpAFzzx2ntD7nbe2CfqR3lnbpYaFNa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jN9s0XfJ; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8895156101so1594000a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782756753; x=1783361553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sn+UFEb7Aq5Gryo/B/T/4+RVu6xrdWuuujuzWZ4T69o=;
        b=jN9s0XfJb1Uu1iOKuxwaooXdZTdPEyubu6amDcjjMnhPLDMWGGZEzm62aPoWxodE03
         9hOQ4GukOJxSUfKiVcoOer6ehFaOnCwf0uCI5yCmE2n9VsH9FbJAA96AUPHDb6LPkVMf
         3cw6OWYU5WMXW0d5oni7rjn+9k5Oy3O30Vpj1YO/ql7QwYiISkvK6d7HB3128aepOCyO
         M09bg/VUWkQYHBSkP/JDVMnD+478GxDhmLvA8kvykyHHNUAXdhw6EiMbKo7pp4wV5WNJ
         RHpFGhV1sqdPi2ArJznCTyKd/0VVINeyZwlFcA1NtXrh7xAZv9aczr23Dz5zy2EboOHo
         7Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756753; x=1783361553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sn+UFEb7Aq5Gryo/B/T/4+RVu6xrdWuuujuzWZ4T69o=;
        b=Q0ipkAzeiRerTa2NXgkH5Qbfw9jgrqqNk0QIENXyV1Xwuh9lMFhr8Gbt7xA/nW7H9Q
         OVMdZi9dsuJBS0g/DHBO4GkjGwG9mlXgKnenWqgpQEJpqI9c+fOZCdfnyze6xWHrxaVr
         69uBazVYgUfTdtIvVBXnQerdyjzF1MYDakE38SBMLsm3JDpMVRc2iHIizPxYeiWOIXgN
         t1WKa6oHHFwAuT1QduZ1BPlK3TuW7cp6NhJWC2rBSLCMCt/1/g8tWtz+ag2YFy+9nHOE
         cwiW2qSkVInuFIt3fcZKxpmQeLCeWO5hq04JPsjJZ7c+VaB6s1HDOSyh4lq9skK2hrA8
         k9eg==
X-Forwarded-Encrypted: i=1; AHgh+Rop2bM2Q521JXcngXJxqdixf78A1lbvjF8/Dj0J/Ww+Ks1tJTMPaQmBCVj/1qQnkknPM6aegA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQVZNloJxIpZUmZyCYSa5AMh5eFGy+NVEW63MBsIMyuZc2iPL
	lUXJPqydUPXSZZQKygFnNQp2jGKXP9yQ8oZXIFpmxjTg0Tmafk7LOkRBvhc6FLXHBS9BZu9/YI/
	u7IIbJw==
X-Received: from pjboo8.prod.google.com ([2002:a17:90b:1c88:b0:37d:8595:7a08])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d444:b0:36d:66d4:270e
 with SMTP id 98e67ed59e1d1-3805259220emr333761a91.5.1782756752873; Mon, 29
 Jun 2026 11:12:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 18:10:56 +0000
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629181226.1929658-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/10] ipv4: fib: Drop RTNL annotation for net->ipv4.fib_table_hash[].
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302767-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73B7C6DDF20

fib_newrule() will drop RTNL except for the first IPv4 rule.

net->ipv4.fib_table_hash[] will be read with no protection,
but this is fine because fib_table is not destroyed until
netns dismantle except for the merged main/local table.

fib_unmerge() will continue to be called under RTNL, so other
readers (fib_flush() and fib_info_notify_update()) just have
to care about the concurrent hlist_add().

IPv6 and IPMR/IP6MR also take this strategy and use RCU helpers
to avoid data race against concurrent hlist_add().

Let's not use lockdep_rtnl_is_held() and rcu_dereference_rtnl()
for net->ipv4.fib_table_hash[].

Note that commit a7e53531234d ("fib_trie: Make fib_table rcu
safe") started to use the _safe version in fib_flush(), but it
is not needed thanks to RTNL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_fib.h    |  3 ++-
 net/ipv4/fib_frontend.c | 23 +++++++++++++----------
 net/ipv4/fib_trie.c     |  3 +--
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index c63a3c4967ae..0a35355fb0f3 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -302,7 +302,8 @@ static inline struct fib_table *fib_get_table(struct net *net, u32 id)
 		&net->ipv4.fib_table_hash[TABLE_LOCAL_INDEX] :
 		&net->ipv4.fib_table_hash[TABLE_MAIN_INDEX];
 
-	tb_hlist = rcu_dereference_rtnl(hlist_first_rcu(ptr));
+	/* Only fib4_rules_init() adds fib_table. */
+	tb_hlist = rcu_dereference_protected(hlist_first_rcu(ptr), true);
 
 	return hlist_entry(tb_hlist, struct fib_table, tb_hlist);
 }
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 336d70649eb9..54eb72695093 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -126,24 +126,28 @@ struct fib_table *fib_new_table(struct net *net, u32 id)
 }
 EXPORT_SYMBOL_GPL(fib_new_table);
 
-/* caller must hold either rtnl or rcu read lock */
 struct fib_table *fib_get_table(struct net *net, u32 id)
 {
-	struct fib_table *tb;
+	struct fib_table *tb = NULL;
 	struct hlist_head *head;
 	unsigned int h;
 
 	if (id == 0)
 		id = RT_TABLE_MAIN;
 	h = id & (FIB_TABLE_HASHSZ - 1);
-
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist,
-				 lockdep_rtnl_is_held()) {
+
+	/* fib_table is not destroyed until ip_fib_net_exit()
+	 * except for the merged main/local table.
+	 * fib_unmerge() is called under RTNL, so other readers
+	 * under RTNL (e.g. fib_flush(), fib_info_notify_update())
+	 * can safely traverse the list with rcu_dereference_raw().
+	 */
+	hlist_for_each_entry_rcu(tb, head, tb_hlist, true)
 		if (tb->tb_id == id)
-			return tb;
-	}
-	return NULL;
+			break;
+
+	return tb;
 }
 #endif /* CONFIG_IP_MULTIPLE_TABLES */
 
@@ -206,10 +210,9 @@ void fib_flush(struct net *net)
 
 	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
 		struct hlist_head *head = &net->ipv4.fib_table_hash[h];
-		struct hlist_node *tmp;
 		struct fib_table *tb;
 
-		hlist_for_each_entry_safe(tb, tmp, head, tb_hlist)
+		hlist_for_each_entry_rcu(tb, head, tb_hlist, true)
 			flushed += fib_table_flush(net, tb, false);
 	}
 
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index e11dc86ceda0..d1d342d7148e 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2137,8 +2137,7 @@ void fib_info_notify_update(struct net *net, struct nl_info *info)
 		struct hlist_head *head = &net->ipv4.fib_table_hash[h];
 		struct fib_table *tb;
 
-		hlist_for_each_entry_rcu(tb, head, tb_hlist,
-					 lockdep_rtnl_is_held())
+		hlist_for_each_entry_rcu(tb, head, tb_hlist, true)
 			__fib_info_notify_update(net, tb, info);
 	}
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


