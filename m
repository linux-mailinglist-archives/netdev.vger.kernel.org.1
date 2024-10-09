Return-Path: <netdev+bounces-133872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A9997513
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C59D1C217A0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A21E1305;
	Wed,  9 Oct 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5sm/8z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07D1E1331
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499454; cv=none; b=cikbF4pOgE06KaNrUFyuTp+E5GORJBoO/ze8BUNSVEKKUNzkTf80d9T9K19nt/K1XY/k2we7XQhksSsqzdtV9B9bpjURdjZgYqzgzNYsmSBr0vF8rraXxcWr/gA1kq442/HOrXtzNJ2ID62gAtAoa1RBzG3W02+Qwy46z+NyQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499454; c=relaxed/simple;
	bh=OQkr6ZAA/DrRW6NsX1hc847jsnbcVIb1yQI5A7ZG7QQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgEql+s9cqBpxiDTshA4Co19C7mib8Io1n/pmb7rTldYpCjDy/Hhw4Bg6XOtvJFY13hichvKnOHJU+yWOfHeon8b6+Q65UiNc7lecpduggGT10Fn5Taf7diOjhGGtwiP9Soi+KzGO1z3sOSJIkUSlwMd+8V7akjBlbHnNisHrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5sm/8z9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso162703276.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499452; x=1729104252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNapo1VlcBbiHxg0tBKVZ2iSK7BFeqVQinD62G/1cF4=;
        b=B5sm/8z9CtFeumcQpV9jLHyjTwXX16aIICl4sPtmwZq+pBZeqsBFj7oOaYzZrFDpc9
         jqJyYuz/eXM4vpiMTUaQQiHUpxKwYdKhyb93TLfmd5TlpO1edaUJ5lDIJJYHmR0+yxWu
         CUGtuTnVkzx7bhLGdRpoIGWP+MwV7BeY0W3/2zz5wNzG9cj/49ytdrm9ZHSciFQ5lsDg
         b30wdN+w1u8bDs3uv9A/l6srz1F2FivWm0Z5VpHyxLUnna8qFVkTu6iNiHqu+DXAGtm8
         l0h8s0hhlWpJbLLE+AJI6zKi5z1pPqe8QbureNIhd2jExIhhIqp+/L99ad3fBUy2MSA2
         K/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499452; x=1729104252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNapo1VlcBbiHxg0tBKVZ2iSK7BFeqVQinD62G/1cF4=;
        b=BtS0E+18PiOhmqwBo7pWWsuXiToYIMhlWe1Al8e8Mfcw6qHsg5trNISeg5gO8s7Bwu
         t+fUr8EGpPouhhjHyU5M1t++7yFAcA1eKLSPN5kSAH71D+Ii9M80RBxzFYjen3Ib7XI6
         PBjj13x9WuvMJF7YKPt/sYAoX1xSBM5tIKAMR1nS5QsqzDFg1kfIH46ulkY6d7NI+VKk
         Q030GUrOr1n7S2+Wf7r9tBeHKeVpKyapHLydj/15pELxmav0QvD7Yk0QoAh9N5mbHuZR
         x7vhrTNwv9FZRYOslGb/VBYNGucvD9P99IUJpzb1eelPWjzQ2ijOvQzfPON9NSqT1Jap
         UXnw==
X-Forwarded-Encrypted: i=1; AJvYcCXjcozuWMBOQQrZLJ7k1nt2A7lEfM2oMFRTBTHbnNn7XHTcXxKymgTSCX1FzhdLIht4wTxOCYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPfvfyAN6qXLZ4ekQ+qy7YT4J+6IKt9ZCVKW10k6PgLWOmIn2a
	K42aLASFD5fX3FzcHINZUI5Mu0wAkAB2IGpJIELmEkimhOGF47r8GVq1Ju5bCpiruSr6Ki7K/dB
	u/T2oMP20gw==
X-Google-Smtp-Source: AGHT+IG0GJ8qpYbl6XIrr5LGu+3QQnPK+YNmW+W8q2+wSPL/BcSEslyavrCMfIzUauywEGNapLgpBUpRsFIg8A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:8287:0:b0:e29:4a5:4555 with SMTP id
 3f1490d57ef6-e2904a548b7mr1891276.11.1728499451785; Wed, 09 Oct 2024 11:44:11
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:03 +0000
In-Reply-To: <20241009184405.3752829-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009184405.3752829-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using RTNL to protect ops->fib_rules_seq reads seems a big hammer.

Writes are protected by RTNL.
We can use READ_ONCE() when reading it.

Constify 'struct net' argument of fib6_tables_seq_read() and
fib6_rules_seq_read().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip6_fib.h |  8 ++++----
 net/ipv6/fib6_rules.c |  2 +-
 net/ipv6/ip6_fib.c    | 14 +++++++-------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 6cb867ce4878423fbb9049e69445a6dbf8f31ba7..7c87873ae211c5fa80d34e8f3b8df0e813976390 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -394,7 +394,7 @@ struct fib6_table {
 	struct fib6_node	tb6_root;
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
-	unsigned int		fib_seq;
+	unsigned int		fib_seq; /* writes protected by rtnl_mutex */
 	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
@@ -563,7 +563,7 @@ int call_fib6_notifiers(struct net *net, enum fib_event_type event_type,
 int __net_init fib6_notifier_init(struct net *net);
 void __net_exit fib6_notifier_exit(struct net *net);
 
-unsigned int fib6_tables_seq_read(struct net *net);
+unsigned int fib6_tables_seq_read(const struct net *net);
 int fib6_tables_dump(struct net *net, struct notifier_block *nb,
 		     struct netlink_ext_ack *extack);
 
@@ -632,7 +632,7 @@ void fib6_rules_cleanup(void);
 bool fib6_rule_default(const struct fib_rule *rule);
 int fib6_rules_dump(struct net *net, struct notifier_block *nb,
 		    struct netlink_ext_ack *extack);
-unsigned int fib6_rules_seq_read(struct net *net);
+unsigned int fib6_rules_seq_read(const struct net *net);
 
 static inline bool fib6_rules_early_flow_dissect(struct net *net,
 						 struct sk_buff *skb,
@@ -676,7 +676,7 @@ static inline int fib6_rules_dump(struct net *net, struct notifier_block *nb,
 {
 	return 0;
 }
-static inline unsigned int fib6_rules_seq_read(struct net *net)
+static inline unsigned int fib6_rules_seq_read(const struct net *net)
 {
 	return 0;
 }
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 04a9ed5e8310f23cb7d947b732be5dd19916bf39..c85c1627cb16ed0bdfe4c6026bb0132cdd7be6b7 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -56,7 +56,7 @@ int fib6_rules_dump(struct net *net, struct notifier_block *nb,
 	return fib_rules_dump(net, nb, AF_INET6, extack);
 }
 
-unsigned int fib6_rules_seq_read(struct net *net)
+unsigned int fib6_rules_seq_read(const struct net *net)
 {
 	return fib_rules_seq_read(net, AF_INET6);
 }
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c6274647eeb413d0b9475aaa3ae6c..cea160b249d2d75d03c867d2298da76eb0c7114e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -345,17 +345,17 @@ static void __net_init fib6_tables_init(struct net *net)
 
 #endif
 
-unsigned int fib6_tables_seq_read(struct net *net)
+unsigned int fib6_tables_seq_read(const struct net *net)
 {
 	unsigned int h, fib_seq = 0;
 
 	rcu_read_lock();
 	for (h = 0; h < FIB6_TABLE_HASHSZ; h++) {
-		struct hlist_head *head = &net->ipv6.fib_table_hash[h];
-		struct fib6_table *tb;
+		const struct hlist_head *head = &net->ipv6.fib_table_hash[h];
+		const struct fib6_table *tb;
 
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist)
-			fib_seq += tb->fib_seq;
+			fib_seq += READ_ONCE(tb->fib_seq);
 	}
 	rcu_read_unlock();
 
@@ -400,7 +400,7 @@ int call_fib6_entry_notifiers(struct net *net,
 		.rt = rt,
 	};
 
-	rt->fib6_table->fib_seq++;
+	WRITE_ONCE(rt->fib6_table->fib_seq, rt->fib6_table->fib_seq + 1);
 	return call_fib6_notifiers(net, event_type, &info.info);
 }
 
@@ -416,7 +416,7 @@ int call_fib6_multipath_entry_notifiers(struct net *net,
 		.nsiblings = nsiblings,
 	};
 
-	rt->fib6_table->fib_seq++;
+	WRITE_ONCE(rt->fib6_table->fib_seq, rt->fib6_table->fib_seq + 1);
 	return call_fib6_notifiers(net, event_type, &info.info);
 }
 
@@ -427,7 +427,7 @@ int call_fib6_entry_notifiers_replace(struct net *net, struct fib6_info *rt)
 		.nsiblings = rt->fib6_nsiblings,
 	};
 
-	rt->fib6_table->fib_seq++;
+	WRITE_ONCE(rt->fib6_table->fib_seq, rt->fib6_table->fib_seq + 1);
 	return call_fib6_notifiers(net, FIB_EVENT_ENTRY_REPLACE, &info.info);
 }
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


