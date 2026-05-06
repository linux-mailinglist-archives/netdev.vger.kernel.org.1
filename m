Return-Path: <netdev+bounces-284753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAdtO5/7+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:28:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB64D7DA2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBAA130512B0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436803E317C;
	Wed,  6 May 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbkuiFuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FD3E316B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055867; cv=none; b=XJhFjv0uw4cUbS9TLXVqDb3ELnXfXuF8WLbE/+4syts+qJjRCXMxdeaUNsP/czRC32s43ykfkt6/qw8fzd5sUHxTWstgzPxW5oY7cOiunWBMHUyLGjiSDqZdPzxjzVP8HzaRTxYldEPqXxrvl8prUiFGOdnWxEapRuxvnz9PGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055867; c=relaxed/simple;
	bh=/Fl6Eup1KJku7VmBbKrDm8Q65djqAuVDuYeegE3umw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1fL6Z7+oPAIBJUhoIlfsikuSc7zbR8YQnKoS1DNYdXNP+M84vbP71D5zTCKoJzXJsH51Jl51gPQFRRa26CIr1pOk9n9k+MiG54yQtEJobl/X6goSdojZuC83zXeMBO0u+124xgb2VnEhshL/925kdgHv3TKr/2bT6uNHN0D4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbkuiFuT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-364c5317d67so6267806a91.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778055865; x=1778660665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaLjuq9Nze0HU4z8sneE7fCkabZfqnOhZ8tEew7UUs4=;
        b=GbkuiFuT7rd/q+q/a9Ckw4xtBrwtxlry9JRwTCPCtTK14g4pVYAPqbZUVy5MreOrbr
         w1f8Rw2+N+t/xK0NiikQ5dmO6VsUtrkgORxNv0HLSl9582BD4idkA50bHF/dCAEic3nd
         7BDjCppxJEqLujHos6wAI4+4UeSmdVMopV3P/hmYXn2u7WvcdXTINa8eizVMqq28VoPQ
         vC/PpNdF2pf6pN8RWiEdV72UWTRj6VRTUzK7Mx4pYRclLjevLJKo6BjyuvMCCK0UaW1R
         vUM22iCtUvcozP6Oaymg9oW0EfiZUvFvIxX5YLqyPLcFtDjvddcc8AEdR+xdnA8Tbj3U
         7qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778055865; x=1778660665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaLjuq9Nze0HU4z8sneE7fCkabZfqnOhZ8tEew7UUs4=;
        b=VEEu+x3gFVtWMUGhwDenAA8WXAtiMk/q6ZAWXVzYQ8jfbMexEInobLXU5gFde1THto
         dQMmne/xwgI5rUcCRFff/VSW6zG8vEaS0WA58KrSbK5g2UQXyjfjwJzg6CF+9V9a1tVW
         8YNbstIFEB97hYWA+R1AsgttvKhd3PsnkVzEBC48xeV4A3DYbqg/467wkibr619501L1
         aByvgDXy/HJ7xd3DfXP1g0NPBcwg/xLynqS0whxuYImUjaDyQoxfx1AfmnqXXj48ABZF
         4s3/mNX0Ein4APV7OtMjj9N979OmbtUwpsfnoPdVXa3hkyeQeOydEnHzE+1ICsmPpRwl
         tDaw==
X-Forwarded-Encrypted: i=1; AFNElJ9d9xNcDJh1jOVAVsm2FMz0nKQndZLAswiyjhNiD2ynD81K9TJ/jcFJBkyck9FR/pPqz9vCL5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsgoWJiSZBptNZ08iZjpR8DCjoJ1LdWFXR8Om8NiKRBX5vUrZ
	+TyQYpQnQzCJiuvJKIdcId7aEm4FIYMZ8T+KXWBnhR9Dkt/Sf87eCAca
X-Gm-Gg: AeBDievwgM/v3LqjfSoOy7oz5HjM13Sk8WI/NDei6peoke+4bxgYqO3Lhex0+7Wd7fH
	Vb5u/WJV/SIgeYwWiY8IR/EVouyUSdFt/gWOEgg7WCorEvkPU6zOdedVGP7rm0AnvL9UmoRCXrn
	NqnD7hUm5kUhcdp+kxLGnFiF33Kvhkiv3JE074xomO9Va/ICt/bhOrVuLbK+HzRMSl6jrVYrdM9
	pf/Bmt29FYEx3cQ6o3YRfu7NInEmeMIiAvseUw6jiJNoj3xEkxL5JW5aF+R75gdyY1pDtxuqPLi
	ZcsJyLq3Ib0G2pRt1fHrpmjpIZ4eS6uOzrLQSXVSz9Xn+PkSF3h5KEA0HqKju4zxq3Jdhe5oz/7
	NL2D+/0XnRqGbnau8xpacNcU8AdDAb6xLOc7eb5sfh1UV9S2TRipBDUeNFCC1iG5OlsSEA/4Jz9
	4T6oVY/9EBUDCqIq9HdBppqlv96cvIw4MCwMYkHsTWt64fJR1O9IUsQ3QbTfI=
X-Received: by 2002:a17:90b:5343:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-365ac7808f4mr2213995a91.26.1778055864948;
        Wed, 06 May 2026 01:24:24 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b12a1eddsm1000293a91.6.2026.05.06.01.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:24:24 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: [PATCH net v8 1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
Date: Wed,  6 May 2026 16:24:15 +0800
Message-Id: <20260506082416.2259567-2-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
References: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BBB64D7DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org,ntu.edu.sg];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284753-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

mem_check() in net/ipv6/ip6_flowlabel.c reads fl_size without
holding ip6_fl_lock. fl_intern() takes the lock immediately
afterwards. The two checks therefore race against concurrent
fl_intern, ip6_fl_gc and ip6_fl_purge writers, which makes the
mem_check budget check approximate.

Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
fl_intern() into its only caller ipv6_flowlabel_get(). The
mem_check() call now runs under the same critical section as the
fl_intern() insert, so the budget check is exact.

With all writers and the read of fl_size under ip6_fl_lock,
convert fl_size from atomic_t to plain int. The four sites that
update or read fl_size are fl_intern (insert path), ip6_fl_gc
(garbage collector, the !sched check and the per-entry decrement),
ip6_fl_purge (per-netns purge), and mem_check (budget check), and
all four now run under ip6_fl_lock.

This is a prerequisite for adding a per-netns budget alongside
fl_size. The follow-up patch adds netns_ipv6::flowlabel_count and
folds it into mem_check().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_flowlabel.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index c92f98c6f..a89746431 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -40,7 +40,7 @@
 #define FL_HASH_MASK	255
 #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
 
-static atomic_t fl_size = ATOMIC_INIT(0);
+static int fl_size;
 static struct ip6_flowlabel __rcu *fl_ht[FL_HASH_MASK+1];
 
 static void ip6_fl_gc(struct timer_list *unused);
@@ -163,7 +163,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
 					fl_free(fl);
-					atomic_dec(&fl_size);
+					fl_size--;
 					continue;
 				}
 				if (!sched || time_before(ttd, sched))
@@ -172,7 +172,7 @@ static void ip6_fl_gc(struct timer_list *unused)
 			flp = &fl->next;
 		}
 	}
-	if (!sched && atomic_read(&fl_size))
+	if (!sched && fl_size)
 		sched = now + FL_MAX_LINGER;
 	if (sched) {
 		mod_timer(&ip6_fl_gc_timer, sched);
@@ -196,7 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
 			    atomic_read(&fl->users) == 0) {
 				*flp = fl->next;
 				fl_free(fl);
-				atomic_dec(&fl_size);
+				fl_size--;
 				continue;
 			}
 			flp = &fl->next;
@@ -210,10 +210,10 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 {
 	struct ip6_flowlabel *lfl;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
 	fl->label = label & IPV6_FLOWLABEL_MASK;
 
-	rcu_read_lock();
-	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
 			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
@@ -235,8 +235,6 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 		lfl = __fl_lookup(net, fl->label);
 		if (lfl) {
 			atomic_inc(&lfl->users);
-			spin_unlock_bh(&ip6_fl_lock);
-			rcu_read_unlock();
 			return lfl;
 		}
 	}
@@ -244,9 +242,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	fl->lastuse = jiffies;
 	fl->next = fl_ht[FL_HASH(fl->label)];
 	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
-	atomic_inc(&fl_size);
-	spin_unlock_bh(&ip6_fl_lock);
-	rcu_read_unlock();
+	fl_size++;
 	return NULL;
 }
 
@@ -464,10 +460,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 
 static int mem_check(struct sock *sk)
 {
-	int room = FL_MAX_SIZE - atomic_read(&fl_size);
+	int room;
 	struct ipv6_fl_socklist *sfl;
 	int count = 0;
 
+	lockdep_assert_held(&ip6_fl_lock);
+
+	room = FL_MAX_SIZE - fl_size;
+
 	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
 		return 0;
 
@@ -692,11 +692,19 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 	if (!sfl1)
 		goto done;
 
+	rcu_read_lock();
+	spin_lock_bh(&ip6_fl_lock);
 	err = mem_check(sk);
+	if (err == 0)
+		fl1 = fl_intern(net, fl, freq->flr_label);
+	else
+		fl1 = NULL;
+	spin_unlock_bh(&ip6_fl_lock);
+	rcu_read_unlock();
+
 	if (err != 0)
 		goto done;
 
-	fl1 = fl_intern(net, fl, freq->flr_label);
 	if (fl1)
 		goto recheck;
 
-- 
2.34.1


