Return-Path: <netdev+bounces-301740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5702Fg8QPGqyjQgAu9opvQ
	(envelope-from <netdev+bounces-301740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:12:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAED26C0436
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:12:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g37jeFR4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA090300461A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF536A372;
	Wed, 24 Jun 2026 17:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DE22425B
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 17:12:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321124; cv=none; b=hAX1AmRyvoXrp1SIEXxw2jJ0vq4safYxt1WrgsoRaK4bSTu+AyyNhD9PhAGBPR+l1vNfUbaoP+YOjEL0zyy3lXJRlRLGOsM6bp6ae31GjTAIY1eOVRttcb/EtSsqmYLEeZZVEVu7orTHnMUjb2MYjEfxNZC45CHXKzUE91+wu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321124; c=relaxed/simple;
	bh=XtugoDUHyCxTBmmc/KSnG+kuSkK/+jnA2OY5DePedIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jpZcJqnjiD2yUb0+Rt3KudP1n00B7YEQcSGE3RO7LG/RMyLB+5EznHkyXRYMW1xGFz8+U7oqQUzzPqxVjnZakH7V7uAvzJHxAJ/daI88/NCdrWjHkssWuhsmwnQ4Xjxjafeb6J1Bg2Kg35tygl0nU/413V/xMKxTT6yAWn9APgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g37jeFR4; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c7ed771dbfso5537235ad.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782321122; x=1782925922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ln2cjlowuhQ2wq3O17qu9usdU419WXsuKBMsnaTupVA=;
        b=g37jeFR4cvLHge1twDZdfMRSIV1UTX3A4KsmNhaOOJtoZhlKFa1S9pKdK9r+D6nXrT
         VQKdELyoD2KEUfVBO6aq/TFl1J/I4FSNJF1ZtW8t8VDHp7bsju9Z3jLar3spffd+Wh4R
         wQ8MGpFlRyEJ0PcF20TIpwobbv0F42BGNRj2FQZwIP0ycSiWyKA8LjDAdqDJGD1P5npt
         ksiPEl3IafyxIwnEYKCAGPlr012V2DeIGPBkj7Wa2THwji6O3hhvlW9SFuze7tGHQmc1
         Or6u4Ww+WroV0xHeIGp9WpdtjG93/vPdpm5+RvvHMwqbD3CPaE16tpddgd0Ii1QTtqiR
         BHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321122; x=1782925922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln2cjlowuhQ2wq3O17qu9usdU419WXsuKBMsnaTupVA=;
        b=QW+xYVUTRbh9sRtUoPsdUHNg4jOvrzJfuiYey3ftPULSX6uhCkqz1j3bN768tELAVD
         IM3Qa+kCFSiBtYi+1wuKLpXCAxB8Uc9dqR6so6p8Hht9VVK4htCNaAPmuDjoz+6iwwvf
         8Q0WcdMNVhnC0m7Wcy8sPcVCfw+2Zv1vuRop0+o9+uE7tLb65qacmG4MS8t4exo7Rdmc
         C076y2U22vV8/UGRsUzWHCOcrZUx33Fl6D/ZsteOV7b0BM4RUUdi+5OKU6DBJ1UdoOqS
         MmBcqHkRbKllDXQFVcOaG+lAiY6jCmmU0xKzqvrkba/TaGAHirS7cHUTLiSrfzsudbkU
         DBew==
X-Forwarded-Encrypted: i=1; AHgh+Rpw3yt1vT9zeHEBHW4klaJMCdWLa05pSTPENLPRDi7nwS6sGglsUgpvsSU7Z4igBggzVZLzCK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdLl+1TslQ8BNwCxfE1xphv6DO+YixrfvfgBG9qHamWkv2egY
	/n5SD3qs1zKbl7ryzvCSvWaLzewtSfA9H7Y2bLWdW80gAVfkR+pL297/
X-Gm-Gg: AfdE7ck08Fwu2jLG2QlvGj0BpT8H70GkUeHZy/ZDEZ2mSLd6bd/8UsdultrzaPMIWnP
	vHd41vPF05Hkb6ufM9PHYzBhqswduo+YethJgk2pvUtDk7w93WYxNZXY9XG+wv1hBvm3og9PM1E
	EMgizyNZT/GZ9SM5vZr/BHGZbe/S4joNH2VPpe1aP9qZ8SRIPoeksqWH2JD+6WBgIv64h9fFvyE
	aZbr3yP5JvSmIOiRd91n7vpU1yQe0vo9Jqqip659deHZWSiQqjRNmQyzaK4HbU3lLKHhHY57w8P
	3F1Opykc5rBUNEiBKsCCN2JCQybTTkjKBOxDQGIdOZXOsCz0TRmhP9BtRmsN/avAjrKyDJgY7wG
	TyrZtCJ9uZyFBI4RtBzTernXIxU3nTHkEy39lEVISqoNfO53bnrLfv7KQOTSQ1Fb8giNUXbxUbl
	TSjC7uRnaGI9SQ7NxabyrgAnCWuos=
X-Received: by 2002:a17:903:2410:b0:2bf:9760:b94d with SMTP id d9443c01a7336-2c7425daab4mr198372125ad.15.1782321121971;
        Wed, 24 Jun 2026 10:12:01 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63d245asm2286285ad.58.2026.06.24.10.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:12:01 -0700 (PDT)
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
Date: Thu, 25 Jun 2026 01:11:56 +0800
Message-Id: <20260624171156.822055-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,xiaomi.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301740-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,m:zhangfeionline@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangfeionline@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAED26C0436

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

Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
The same crash was independently reported in a production environment
(kernel 5.15.137, triggered by ovs-vswitchd issuing RTM_GETROUTE):
  https://lkml.iu.edu/hypermail/linux/kernel/2402.3/02068.html

The crash is probabilistic and occurs in fib6_walk_continue() at the
FWS_U state:

  case FWS_U:
      if (fn == w->root)
          return 0;
      pn = rcu_dereference_protected(fn->parent, 1);
      left = rcu_dereference_protected(pn->left, 1);  /* crash here */

The crash dump shows fn->parent is NULL.  At first glance this looks
like fn is a leaf node whose parent was freed, but closer inspection of
the walker state reveals fn->fn_flags has RTN_ROOT set — fn is itself
a root node of a routing table, not a child node.  A root node has no
parent by definition, so fn->parent == NULL is correct for that node.

The real question is why fn != w->root despite fn being a root.  The
answer is that w->root and fn belong to *different* tables: w->node
(which became fn during traversal) still references a node from the
table that was being dumped when the batch suspended, while w->root was
silently redirected to a different table on resume.

This misdirection happens because inet6_dump_fib() uses a positional
index to resume across batches.  Consider a hash slot containing two
tables [A(pos=0), B(pos=1)] where B is large enough to require multiple
batches.  On the first batch, B suspends mid-walk and the loop saves:

  cb->args[1] = e;   /* e=1, position of B in the chain */

The RTNL lock is then released.  At this point a concurrent
fib6_new_table() inserts table C at the chain head via
hlist_add_head_rcu(), making the chain [C(pos=0), A(pos=1), B(pos=2)].

On the next batch, inet6_dump_fib() resumes with s_e=1 and iterates:

  s_e = cb->args[1];   /* s_e = 1 */
  hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
      if (e < s_e)     /* skip C at pos=0 */
          goto next;
      /* e=1: tb now points to A, not B */
      fib6_dump_table(tb, skb, cb);   /* called with wrong table A */
  }

Inside fib6_dump_table(), w->root is unconditionally overwritten
before the resume branch is entered:

  w->root = &table->tb6_root;        /* now A's root              */
  /* ... */
  } else {
      int sernum = READ_ONCE(w->root->fn_sernum);  /* A's sernum  */
      if (cb->args[5] != sernum) {
          /* sernum changed: safe reset, w->node = w->root (A)    */
          w->node = w->root;
      } else {
          /* sernum unchanged: w->node untouched, still in B       */
          w->skip = 0;
      }
      fib6_walk_continue(w);   /* sernum equal: w->root=A, w->node=B */
  }

The sernum guard was intended to detect tree modifications and reset
the walk, but here the two tables happen to share the same fn_sernum
value (a global flush had previously unified them), so the guard does
not fire and w->node is left pointing into B's tree.

From this point w->root and w->node belong to different tables.  When
fib6_walk_continue() traverses upward and reaches B's root node
(fn->fn_flags & RTN_ROOT), the exit check:

  if (fn == w->root)   /* B's root != A's root, check fails */
      return 0;
  pn = fn->parent;     /* B's root has no parent: pn == NULL */
  left = pn->left;     /* NULL deref -> crash */

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


