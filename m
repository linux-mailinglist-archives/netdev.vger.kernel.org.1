Return-Path: <netdev+bounces-209486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50DB0FB2D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC98B963405
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33832153F1;
	Wed, 23 Jul 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wygj/4lL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671A1A23A0
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300501; cv=none; b=ri323S5QZOiwW/cgEJVU6vGMm+q52Pk7hgWsx1z68gGTn4+51Qq08hTXIiFQne9mezaYxFi4F1dNQEs8JicoiNediFrQKsfIeCAoRySjlpVFo0r+AfeXWgPVkhZLdx14PFKFA+qgxT4FOMJfV4R4qjHpOQaJRY5WsBU0PlzF8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300501; c=relaxed/simple;
	bh=zp7K8TDhHz7f0oQCCCHnOFm3TZmOBIzAV0Jm+84Bag4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PdI5dy/k4vYqxFeJSQ6XGyjrkj89m3/MyOjDEuMT+t9KrfluucC38Gl/7mS3NtOkvsuwZXmIR5sRiGga8LGMPuvyKaDT5RLD7pDiZv1i9NfrpaM1xVrUeQvVIuazaLNfoJgoflHZbb8p0CZ1eyfXR6Zdfgg88w7G5qrWnF7Ssuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wygj/4lL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f13ef248so230593b3a.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753300499; x=1753905299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/o96rHaBqkn4juUorQ0ZXUvs2xTloSPhlRAGJTQ7+w=;
        b=wygj/4lL+74wVOykCXT5aLT8OyHpusBvs8uH8udCSoctCl1Dx6S7p5NuQkRr5e90Bj
         UmDcaNwO3xEOY3e1lI9SUUZ67AsMtfk/bOf7bCLTkhb8ZakMCJ4liRm6ZDWIL9N3RgXI
         VQ2fpgsL8hLUaqs8x06d+T9QqNf6qXg7r1nlt51dpox4RKmL9+jNc/boOtBVHj/6gM9N
         LaDgaAbvMlzLqiKM8PpHxvccRzUX0YOO+6Zzy5QjLY21kluNKBTXy/Fh8yVvieIxaVCw
         RFx2aO1tsyM9k6aLWPnzhfuU0vi6KJ4bxYySl1Ji1767c+Pr8LWGDfqssq+tDGMlbfo/
         3SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300499; x=1753905299;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/o96rHaBqkn4juUorQ0ZXUvs2xTloSPhlRAGJTQ7+w=;
        b=ZxmBY7MYApK2qVQzVsd39LpkzVx2ZmksAtOe75wy1+x8BMlri6LapB1GY11a+2z5uO
         ja6aJLc+bTP1DitMHlHHoYoK5TiySfVdgEIbQXwAB5UbjIkQLLfU31iuHplg2qGGSB68
         4e1q9JJyrxHhGqM71ZBDKBvhdhc1fr/3nPfcWRDI4FiBVTs2foLlsZcWRssxJrGbnmZQ
         yXQpoJAgnWR2Xq7ZDS0N37+0Uu1Hvk5JRK74hLA1jWR4dRuc0De5HVky4+L1kGsE/G1H
         oN20oPAbsQTMhJ+2RlGaGkzqRt2RiGYz6FqR2CDgizDQkQJe49O7iMphHUA8MbVspnZV
         qVwg==
X-Forwarded-Encrypted: i=1; AJvYcCVxu0tyA9VBa11fqAPKt0kBpsq++A23dFqtTWs6NAeGPrRcGJ0ODVXDMWoOKD8+UM1XC4/R4VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZ4kJdBhHpf8CI4bqnPE2l/R/oHmxVY5iRm6zUCN8SUzEpsU7
	SXCxBL19cKOrIdOXTokC7CuvI/pyUsVTDHjySAG3Ji0sUcmT/fDH1Tj3aG4J46hyt6ubhKebKHP
	DTGxJ6A==
X-Google-Smtp-Source: AGHT+IHHnfpirAXwpp5xgzIppj+43AHqV4CfEjzvj2SYLLVEDbu0VS/xlWKLZxStVHP0LD34bfF1vNiiX/k=
X-Received: from pfbhr20-n2.prod.google.com ([2002:a05:6a00:6b94:20b0:747:abae:78e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1acf:b0:748:2cbb:be45
 with SMTP id d2e1a72fcca58-76034de13b5mr5231490b3a.15.1753300499429; Wed, 23
 Jul 2025 12:54:59 -0700 (PDT)
Date: Wed, 23 Jul 2025 19:53:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250723195443.448163-1-kuniyu@google.com>
Subject: [PATCH v1 net] neighbour: Fix null-ptr-deref in neigh_flush_dev().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Gilad Naaman <gnaaman@drivenets.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"

kernel test robot reported null-ptr-deref in neigh_flush_dev(). [0]

The cited commit introduced per-netdev neighbour list and converted
neigh_flush_dev() to use it instead of the global hash table.

One thing we missed is that neigh_table_clear() calls neigh_ifdown()
with NULL dev.

Let's restore the hash table iteration.

Note that IPv6 module is no longer unloadable, so neigh_table_clear()
is called only when IPv6 fails to initialise, which is unlikely to
happen.

[0]:
IPv6: Attempt to unregister permanent protocol 136
IPv6: Attempt to unregister permanent protocol 17
Oops: general protection fault, probably for non-canonical address 0xdffffc00000001a0: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000d00-0x0000000000000d07]
CPU: 1 UID: 0 PID: 1 Comm: systemd Tainted: G                T  6.12.0-rc6-01246-gf7f52738637f #1
Tainted: [T]=RANDSTRUCT
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:neigh_flush_dev.llvm.6395807810224103582+0x52/0x570
Code: c1 e8 03 42 8a 04 38 84 c0 0f 85 15 05 00 00 31 c0 41 83 3e 0a 0f 94 c0 48 8d 1c c3 48 81 c3 f8 0c 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 f7 49 93 fe 4c 8b 3b 4d 85 ff 0f
RSP: 0000:ffff88810026f408 EFLAGS: 00010206
RAX: 00000000000001a0 RBX: 0000000000000d00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffc0631640
RBP: ffff88810026f470 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffffc0625250 R14: ffffffffc0631640 R15: dffffc0000000000
FS:  00007f575cb83940(0000) GS:ffff8883aee00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f575db40008 CR3: 00000002bf936000 CR4: 00000000000406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __neigh_ifdown.llvm.6395807810224103582+0x44/0x390
 neigh_table_clear+0xb1/0x268
 ndisc_cleanup+0x21/0x38 [ipv6]
 init_module+0x2f5/0x468 [ipv6]
 do_one_initcall+0x1ba/0x628
 do_init_module+0x21a/0x530
 load_module+0x2550/0x2ea0
 __se_sys_finit_module+0x3d2/0x620
 __x64_sys_finit_module+0x76/0x88
 x64_sys_call+0x7ff/0xde8
 do_syscall_64+0xfb/0x1e8
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f575d6f2719
Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff82a2a268 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000557827b45310 RCX: 00007f575d6f2719
RDX: 0000000000000000 RSI: 00007f575d584efd RDI: 0000000000000004
RBP: 00007f575d584efd R08: 0000000000000000 R09: 0000557827b47b00
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000020000
R13: 0000000000000000 R14: 0000557827b470e0 R15: 00007f575dbb4270
 </TASK>
Modules linked in: ipv6(+)

Fixes: f7f52738637f4 ("neighbour: Create netdev->neighbour association")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507200931.7a89ecd8-lkp@intel.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 88 ++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 49dce9a82295b..a8dc72eda2027 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -368,6 +368,43 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	}
 }
 
+static void neigh_flush_one(struct neighbour *n)
+{
+	hlist_del_rcu(&n->hash);
+	hlist_del_rcu(&n->dev_list);
+
+	write_lock(&n->lock);
+
+	neigh_del_timer(n);
+	neigh_mark_dead(n);
+
+	if (refcount_read(&n->refcnt) != 1) {
+		/* The most unpleasant situation.
+		 * We must destroy neighbour entry,
+		 * but someone still uses it.
+		 *
+		 * The destroy will be delayed until
+		 * the last user releases us, but
+		 * we must kill timers etc. and move
+		 * it to safe state.
+		 */
+		__skb_queue_purge(&n->arp_queue);
+		n->arp_queue_len_bytes = 0;
+		WRITE_ONCE(n->output, neigh_blackhole);
+
+		if (n->nud_state & NUD_VALID)
+			n->nud_state = NUD_NOARP;
+		else
+			n->nud_state = NUD_NONE;
+
+		neigh_dbg(2, "neigh %p is stray\n", n);
+	}
+
+	write_unlock(&n->lock);
+
+	neigh_cleanup_and_release(n);
+}
+
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
@@ -381,32 +418,24 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 		if (skip_perm && n->nud_state & NUD_PERMANENT)
 			continue;
 
-		hlist_del_rcu(&n->hash);
-		hlist_del_rcu(&n->dev_list);
-		write_lock(&n->lock);
-		neigh_del_timer(n);
-		neigh_mark_dead(n);
-		if (refcount_read(&n->refcnt) != 1) {
-			/* The most unpleasant situation.
-			 * We must destroy neighbour entry,
-			 * but someone still uses it.
-			 *
-			 * The destroy will be delayed until
-			 * the last user releases us, but
-			 * we must kill timers etc. and move
-			 * it to safe state.
-			 */
-			__skb_queue_purge(&n->arp_queue);
-			n->arp_queue_len_bytes = 0;
-			WRITE_ONCE(n->output, neigh_blackhole);
-			if (n->nud_state & NUD_VALID)
-				n->nud_state = NUD_NOARP;
-			else
-				n->nud_state = NUD_NONE;
-			neigh_dbg(2, "neigh %p is stray\n", n);
-		}
-		write_unlock(&n->lock);
-		neigh_cleanup_and_release(n);
+		neigh_flush_one(n);
+	}
+}
+
+static void neigh_flush_table(struct neigh_table *tbl)
+{
+	struct neigh_hash_table *nht;
+	int i;
+
+	nht = rcu_dereference_protected(tbl->nht,
+					lockdep_is_held(&tbl->lock));
+
+	for (i = 0; i < (1 << nht->hash_shift); i++) {
+		struct hlist_node *tmp;
+		struct neighbour *n;
+
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i])
+			neigh_flush_one(n);
 	}
 }
 
@@ -422,7 +451,12 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 			  bool skip_perm)
 {
 	write_lock_bh(&tbl->lock);
-	neigh_flush_dev(tbl, dev, skip_perm);
+	if (likely(dev)) {
+		neigh_flush_dev(tbl, dev, skip_perm);
+	} else {
+		DEBUG_NET_WARN_ON_ONCE(skip_perm);
+		neigh_flush_table(tbl);
+	}
 	pneigh_ifdown_and_unlock(tbl, dev);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
-- 
2.50.1.470.g6ba607880d-goog


