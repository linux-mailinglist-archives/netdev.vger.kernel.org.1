Return-Path: <netdev+bounces-301859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1vwdKGmxPGqOqggAu9opvQ
	(envelope-from <netdev+bounces-301859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:41:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C1A6C2AD9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iu+3Fx8c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301859-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC23302A6F9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 04:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44412D97BA;
	Thu, 25 Jun 2026 04:41:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96C17993
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 04:41:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782362470; cv=none; b=Kq3QfcBVYsCI+N7TEVpWjszqijY2qpnDia9uF0s4PnykABfrqsCSOQQQnC++2UsaQEb/YChofci/bEE49S1yQBsPqNFhueBmeMfTBRWvKC7twlVUo4ZT/gSoxTiVOTnuadGc5vFMAB3vVXwrPZuBqihhyP0IM/QtYO1rP+k/IXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782362470; c=relaxed/simple;
	bh=T9SXqfsO/EFq+dYj0i1JvBToxhsvtWDwvs2JRGi+kgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=riWaVk/OT8fBTvs1o+3HL9uvQ5s35jpqyvw/qiVFqzLgpBTWUIP3rT74oii7brP10g3+PM1+0Te5KPrYz+FTV4Qvf8v9hxJIjeL1KWHAcCbzN3XQw74Uoiev6UkPfGM1kv+/Qn8zJRfG81iPOY+V5uIpVkHg3gL5QVxVmsL+QmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu+3Fx8c; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37cbcf49deaso1186625a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782362468; x=1782967268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=iu+3Fx8coAKV5knhsLFROxTWx0fLwI0N/ouJgZEzDtLv9DIVB9iBq3IXQuzaGoADW8
         5FO86ON8sozd14NygaxVmx+i6fOp/GkaUgWQfqbf4GWF3YAz+7O1VtLUFVi754dG9+GD
         SDtWmu+ZlZjSW9hqIxWQZHy4wG+aVDKEQgkXNnJzE63T+owMTHYfanxbA06gYMUPtur2
         WLdKkKLJQbKLExVd8ic4nYjSEAG7QLv7Tr7cJ+19dcvMWxQHeOUjYQLDzcZdLREuKBuR
         UkORohXuwndO5GmaKNN/4LZw8dTSVyidMbOoC1h/COHzf+SSw7hwHBN+k22F8jhT37fX
         RXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782362468; x=1782967268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=lX9H4iBHV/SK3QY8gPE6J803X1aZOUra4Lsurt/XkPvugCvbl9RCcR8xBC3A/dFgRm
         X2Pz/B098B3xKuZOe1PbF9mzPfkPY6jDsOcu0XfZHUTkuqyh2ZQAsLi6tcgiGFDab31G
         pDbYtq+ZlikdnYdGpL/cOBZ/UXjccdoRxc7pX753RTpHk9Ib6DK3+CtReMzAMeBcoFEl
         cPmUzI2cHRLO/ponVqOI/h6pOYUy2bjha1XbA7CklGqp7DW9NTMsD4EIEdJqEE93rLPK
         SWSK0mCx9MctZ6oYNIshW1ERXBfNoCRLX9hQNQMi7pT6Fw4NQzhPnMrPUqdwxNJjQokz
         Pxow==
X-Forwarded-Encrypted: i=1; AHgh+RqK9zgJ++Vooa6l+8BqLVkYgVaVtWItlJEGFDXeKJGZfPfS33cUKFhuy3sRtpMMFto8MQLELSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh7LVNjbqTs4L7wUtQiNlF2ZeVGGdnFfoXMbN2r4VsmXIqNXG0
	8hfzJEyJ2A1FK9SczU+Rc9RrrX312OAMvKtiTXvlie7h8yUQkzghV012h4YcZU9U0jI=
X-Gm-Gg: AfdE7cknq0H53ROwwV9uxFkl6eE2d4lVmb+vy596anGrACFaqIrUX1vqPNT9UsSZPmH
	4/rxmlqeZ1AzDsDCcO4y3C4LeJ6NsiOL1ujzraSoki7lC+gOIUSXehCg/7dqFKvaOKTWLax/BeR
	9GuHAtneOqRKj17/3U4g8n2aW7y9eEzTADTEcXC7orzpsthlkxelUmB8bPeUSRkYdrVa5kNTUg2
	aSCK8s+XNx6sZMyfgm1MZq5BuUQG/WXzL7oOOvNRvxYKQT4CHjFkxCK5BWsEN2GLlG4oNc8AHxx
	Xe+hQwpm6e9gchzyjLdOhDWNopHxSNha3V6ZsAGV1uvXCxMaDkA2kyCp0A7bB4djOLbwalAyWlc
	WZYyUb7utR0m2IJtptTt6ENji6e4JC32WrKUmK5zElXpKkmI4RXwUCsNmeF8wB/alDOwhaGPyfP
	twmXqB0mDQP6hYFxGhNlqFv6upj3s=
X-Received: by 2002:a17:90b:50cc:b0:37c:60da:a9f3 with SMTP id 98e67ed59e1d1-37dfa263e84mr833019a91.20.1782362468449;
        Wed, 24 Jun 2026 21:41:08 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b96ec739sm887723a12.2.2026.06.24.21.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 21:41:07 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhangqi@xiaomi.com,
	baohua@kernel.org,
	Pengfei Zhang <zhangpengfei16@xiaomi.com>,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH v2 net] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Thu, 25 Jun 2026 12:41:01 +0800
Message-Id: <20260625044101.939070-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,xiaomi.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301859-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,m:zhangfeionline@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9C1A6C2AD9

From: Pengfei Zhang <zhangpengfei16@xiaomi.com>

inet6_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches the RTNL lock
is released, so a concurrent fib6_new_table() can insert a new table
at the chain head, shifting all existing entries.  The saved index
then lands on a different table, causing fib6_dump_table() to set
w->root to the wrong table while w->node still points into the
previous one.  fib6_walk_continue() dereferences w->node->parent
(NULL) and panics:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:fib6_walk_continue+0x6e/0x170
  Call Trace:
   <TASK>
   fib6_dump_table.isra.0+0xc5/0x240
   inet6_dump_fib+0xf6/0x420
   rtnl_dumpit+0x30/0xa0
   netlink_dump+0x15b/0x460
   netlink_recvmsg+0x1d6/0x2a0
   ____sys_recvmsg+0x17a/0x190

Fix by storing tb->tb6_id in cb->args[1] instead of a positional
index.  On resume, skip entries until the id matches; a concurrent
head-insert can never match the saved id, so the walker always
resumes on the correct table.

Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
 net/ipv6/ip6_fib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fc95738de..bda492634 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -636,11 +636,11 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	};
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
-	unsigned int e = 0, s_e;
 	struct hlist_head *head;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
 	unsigned int h, s_h;
+	u32 s_id;
 	int err = 0;
 
 	rcu_read_lock();
@@ -701,23 +701,22 @@ static int inet6_dump_fib(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
-	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv6.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb6_id != s_id)
+				continue;
+			s_id = 0;
+
+			cb->args[1] = tb->tb6_id;
 			err = fib6_dump_table(tb, skb, cb);
 			if (err != 0)
 				goto out;
-next:
-			e++;
 		}
 	}
 out:
-	cb->args[1] = e;
 	cb->args[0] = h;
 
 unlock:
-- 
2.34.1


