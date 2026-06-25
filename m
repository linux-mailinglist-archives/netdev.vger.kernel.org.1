Return-Path: <netdev+bounces-301816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +lw3HhaDPGq1owgAu9opvQ
	(envelope-from <netdev+bounces-301816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:23:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A656C21BF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:23:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=scuo3Hrv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301816-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301816-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930C0303259C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161E368D7C;
	Thu, 25 Jun 2026 01:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CD1EDA32
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350612; cv=none; b=Uje9a8nD63KRexHT7g0KpDOxgkwE3NiNDzFRyYUFDRMMDdlVAQFrN/XFLwpOLiyfYFfoUU9XeZqp7jePHNdkQjNuJK2+81obOG4jvq5OycLxogNQqACoYvbymWY81ILDLaBv/gyT/WDXAVbyTx5Rx45lYJvMgq09Pqkf+AShmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350612; c=relaxed/simple;
	bh=T9SXqfsO/EFq+dYj0i1JvBToxhsvtWDwvs2JRGi+kgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDUuVaoW0tWDHSV+NiV5Bro2x0yOi3SfWmWUblO8IcTA4eefqK5P55Hm5D0izL1DGNPkfQYHrku7pwLuiS+8T7LSIfuNzQVGVIKnvSy8d1mdtTRMqcZC4vT47jUf9Wqufqijor1ljBjP/LsS6OXtqiHJFMOm066RfHjlP+PAWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scuo3Hrv; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84231305a80so1288708b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782350610; x=1782955410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=scuo3HrvN19gg3/FDGHEjXterTIX6YzCTf3YrL/mgSmklMg4Pteu1ASWq1ze0TSCI2
         tOrTjJdKq+7S7XmstRqQr6yTDXDOSlx9cYtLYHXfxoV2/y1FczGB3ro2FfglXUwhmKab
         LXLPT30WvAmspm8uTJpCYgjC+tXR/petEfS3eRhUkgJn7H63aH/T3VDvG/zW3HuGcvfj
         xuS/20SWarkTSodAqtwWa74ZxVLOsyTSQNpk4wc0UtM+qbOJQMmrO7n5ObRwnoEXAF+R
         zciHVu8KPB6yT5Zrf9r1ZmAfmrCIqqVBwPkytSNt4lsj1d3MRFnQp7sqAZCM0l16tC94
         /0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782350610; x=1782955410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWrI8sitTaDcWEaHG+ZnIRCNC7VJeTwjUrHgR3uWgo8=;
        b=PiV8RQTlU2fp4IVUAPP7Bw7okflcDyLdR8th5isAO5+/RmStidd0Kk34/sVvZHuRf6
         0crc83cfhGdo2PAOFjV4PHl/8Ddm0OMQWs9UpmjGRn4rYWjSPZWkhcRhFZR39MRBkK7U
         bYd92OpSxc0lQIhzDNL0T3sQf3aT/SjSi0HpDmESKGoFloXok/++4g9VowZk6ULnDQFA
         rNWcuDZiQIV4dQkRLeDpCe89BwYs/DQfovRWRX2mwbreNDyxMUHsfql0EyU1jVYs9xC+
         PuyAYGRn5IN4Sw68HDruyjcLmNhOwltNV/7F+S+37rY78BX85rGJpXHqyqlldzzktHLK
         9OZg==
X-Forwarded-Encrypted: i=1; AHgh+RowRWLWGuRTcvEraHWpUID2WOz2D9uD0D4Bog6aatLPbs5OkRA/fb3bJEtDKjgupZxAj8EZdoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZ914pjJmXtKghVOTQiz5qTtEbjBH2edEquzEN+IYkacpHG5G
	Jic3LEoPWPC+VTkYkXmHiGPTftKGuzG5kC+dC+q98hKd2u7AEmkTLUEM
X-Gm-Gg: AfdE7ckO67WAmI1wlRJH0rc3/AFKd/ghyHrsWJB+66vxxrXgeaK1+8GJJnqYbJh+rDw
	Xs3jgFvBaw12Vyu4wlKKd5fUBlxHfvsT6FBviOY3yGaiUNj/xxJLlBOjlJvMDO3emhGLDN0aGs6
	n6hxhTmX5ml4hzu9nCPDDNoqGdsNLADb48B2ypGl+LsGHFkCVWZrthWBNze/SxRymGLgaDQF45D
	U1X5Nr3KeEtt4L90WOOLMnBEjIfxzArAITo20GJpJZUfZ3cCx8NbreVwuChDpItv7SPGhA4Xh9z
	FXwZccpAjgeSmRA93+pDjXRw9fdQ3W58aMiC6lFWCUpAW+ayUSj9wYsUBIusk+oWMieoW5eUpRV
	1g+kGjjfB4gSrSNUD9WSBMb0b5qneX9qfhKQ7cfhu23/+sSSXwlcaDrtBXuF+9sVIYl+jGHBzMG
	1RPYOgkPCTXkgFzX0m7Ox4N2giXDE=
X-Received: by 2002:a05:6a00:2396:b0:842:377a:4dcd with SMTP id d2e1a72fcca58-845b3b1dc40mr642354b3a.43.1782350609949;
        Wed, 24 Jun 2026 18:23:29 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a4002bf0sm3272475b3a.25.2026.06.24.18.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:23:29 -0700 (PDT)
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
Subject: [PATCH] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Thu, 25 Jun 2026 09:23:23 +0800
Message-Id: <20260625012323.892346-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624171156.822055-1-zhangfeionline@gmail.com>
References: <20260624171156.822055-1-zhangfeionline@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,xiaomi.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301816-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3A656C21BF

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


