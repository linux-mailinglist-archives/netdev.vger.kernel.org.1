Return-Path: <netdev+bounces-217132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97097B377C0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440AD3BB609
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95350273D66;
	Wed, 27 Aug 2025 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hET9raGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF1199935;
	Wed, 27 Aug 2025 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261863; cv=none; b=MZj1/GZiCwLih6W8FH+VMKo4maSuIL0l52OKUcDHWOTT/6r+lhxQtpuserasymsDJDraYxiTFTpMCu7i7+yZoBfz4ouQuxVUDnNRKxTG5G1TSsdhPRzz7R+/aC/fH4OfNYXEGcLPkxXGImhS0x7DTbOW0eO7jcrBKyPjOUsvcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261863; c=relaxed/simple;
	bh=sxOxkcwPFJJe83z8NLVl4H7dU8+QYSWmA72RaHjej8c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DlnDv06zknjcmLL9xuW80cYM2RL3NIO55q5sj7/u56pOw2ezr/yr8/Q2lRwkr2IEdPuq+Vb2dx5IY7Wnl97Myh2gbYK0+YTDvXAaZBgXkUrf7qdsIB5DghyRMMtmWzue59jNax3DMG7ep49sgCetnuN/wXAWza623MbELTbSE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hET9raGO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b49e0686139so2804623a12.2;
        Tue, 26 Aug 2025 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261860; x=1756866660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/0y6ODHXbSKkHBUSChmQ31RNrPLbBCqbSbD/IEHPVg=;
        b=hET9raGONTkb95WbY/WMCQluF0Ciqj1TFwu8JblsPMxvatOfBjiT2Vu1lqGzT+iFTV
         A8JOz2oyaDCgS+yXcJK2SnSU/PDm3Ga9h+pL7i/780VKcKQWAA3SwW4bME5ISqMQVXzV
         gI2rQZf8IJYifsFUDPMh+wfoNNdKXEs3F/kxEbl8bKdYRYm/K1Pj1TAPDPvWWk1aR7pD
         r3ba1n3fIYs3HdxBZa3jAvrID+iqCXNGO5VCSKd9EBH5nvSKijR2RkK/UeZMYfIOaQdU
         yc7nrXMd0xprt3XCjfQQURwMuCRonMYG5phYItl7hmZXemV0aKErB684daFjfkkpqL8Q
         noGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261860; x=1756866660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/0y6ODHXbSKkHBUSChmQ31RNrPLbBCqbSbD/IEHPVg=;
        b=pbrIuL1Vsdk79WDgZZJQ4MxOskXFi5VGei88C3QKrlCLAH+2owWAq37tK2qVsuvSoA
         1UZ11sYHBOUfJfE6UA2S96HKSHWogpEOD3M7KPsGTcX51Y6ktSdVTviePm1oiJJAiBfM
         jlwZMQKOeB4gCFe7BgKHg+QfH4Dy7BXnMA3ZxlLnRjD7TtyGdHrXFzwDA6v2DXpu8B+k
         x+Dm0Rmb8h94oVZoQPS4lX3eks7WCK50Qte5hcVnWv/H+UjGH+a6Z/F1TIONgOvRqaUj
         SuynicWRDP6q+RIJ8zFIg+0hdCTeCKShPeCg7piGhIxUK0pF7MRVrJvyGnbHELxGQijs
         75QA==
X-Forwarded-Encrypted: i=1; AJvYcCU3lxaXvSeLgL0Dcpx4QT8pYvsehkllK7FZmhbOYT2gGa9ocj5sRw9V/mZ6QuNZPMyF8aCSc9kxas/qauY=@vger.kernel.org, AJvYcCUNyITjA45k8DQUIfdeMURV/dNlp0wCgaTDntTMOoJBLM1zMjfvj0sjVTPmD4hX+P3R9rF/k/jt@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFvFutM7ub2oWT3W5zp1Cp9BBa3HCyVXQL9/ZNbUJtxEq0Nwt
	yx+sMZIuLDRjqc67FYdqaX3Wft2xp6vxn3GJYathy1x72+gqWWcW9NjW
X-Gm-Gg: ASbGncsFgz800DxVqtO7TMBdruLRNJdlp4po6arqOSoFUa1LGz6KuiQHV8Q4og0Grx7
	zW64J2ST9NFxvmGO/rIng+lJ/CmNyEccbq6M3M0BGmK85XKfWlX5OTL0Z7pPMtIGiYqKy9ZPhRN
	lWmpPubzFPjOFF0XxDVfv2bbmKLrcqyB1eq93fk/gqyrmBi/M6KQRE3wpY36hVwQpdZw6AIAynz
	mMjkbEbwhZyt/1maBrl4z+Vby8fAG2NJ1l791++hri7QmNg9RJlL+b/ytCYEbFmjoXzniUJQ0Ay
	xdo6Ie3XteGiBnFQfE2h7mgRe8CKlTaNTTnJD9y8nmuagIebkT35m7c5mTWvKhYDWi1j0J2XGuk
	jjY3Hd1OvXwoj42H85yE8xorNy8HGr5lR29CH
X-Google-Smtp-Source: AGHT+IFpfwwSLNhAmtVzUJPXhBIMqrvSIOU0LEzHyH1GYFuQOl+vmVZDp8id2ri+fpt7ZDWQxVdHKQ==
X-Received: by 2002:a17:903:190d:b0:246:ed0b:9927 with SMTP id d9443c01a7336-246ed0ba955mr93277255ad.60.1756261859703;
        Tue, 26 Aug 2025 19:30:59 -0700 (PDT)
Received: from gmail.com ([223.166.86.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2487928c46dsm24007655ad.68.2025.08.26.19.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:30:59 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] pppoe: remove rwlock usage
Date: Wed, 27 Aug 2025 10:30:43 +0800
Message-ID: <20250827023045.25002-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
lookups and a spinlock for updates. This removes rwlock usage and allows
lockless readers on the fast path.

- Mark hash table and list pointers as __rcu.
- Use spin_lock() to protect writers.
- Readers use rcu_dereference() under rcu_read_lock(). All known callers
  of get_item() already hold the RCU read lock, so no additional locking
  is needed.
- get_item() now uses refcount_inc_not_zero() instead of sock_hold() to
  safely take a reference. This prevents crashes if a socket is already
  in the process of being freed (sk_refcnt == 0).
- Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
  period.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2:
 Use refcount_inc_not_zero() in get_item() to avoid taking a reference of
 a zero refcount socket.

 drivers/net/ppp/pppoe.c  | 87 ++++++++++++++++++++++------------------
 include/linux/if_pppox.h |  2 +-
 2 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..25939d6bd114 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -100,8 +100,8 @@ struct pppoe_net {
 	 * as well, moreover in case of SMP less locking
 	 * controversy here
 	 */
-	struct pppox_sock *hash_table[PPPOE_HASH_SIZE];
-	rwlock_t hash_lock;
+	struct pppox_sock __rcu *hash_table[PPPOE_HASH_SIZE];
+	spinlock_t hash_lock;
 };
 
 /*
@@ -162,13 +162,13 @@ static struct pppox_sock *__get_item(struct pppoe_net *pn, __be16 sid,
 	int hash = hash_item(sid, addr);
 	struct pppox_sock *ret;
 
-	ret = pn->hash_table[hash];
+	ret = rcu_dereference(pn->hash_table[hash]);
 	while (ret) {
 		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
 		    ret->pppoe_ifindex == ifindex)
 			return ret;
 
-		ret = ret->next;
+		ret = rcu_dereference(ret->next);
 	}
 
 	return NULL;
@@ -177,19 +177,20 @@ static struct pppox_sock *__get_item(struct pppoe_net *pn, __be16 sid,
 static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
 	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
-	struct pppox_sock *ret;
+	struct pppox_sock *ret, *first;
 
-	ret = pn->hash_table[hash];
+	first = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
+	ret = first;
 	while (ret) {
 		if (cmp_2_addr(&ret->pppoe_pa, &po->pppoe_pa) &&
 		    ret->pppoe_ifindex == po->pppoe_ifindex)
 			return -EALREADY;
 
-		ret = ret->next;
+		ret = rcu_dereference_protected(ret->next, lockdep_is_held(&pn->hash_lock));
 	}
 
-	po->next = pn->hash_table[hash];
-	pn->hash_table[hash] = po;
+	RCU_INIT_POINTER(po->next, first);
+	rcu_assign_pointer(pn->hash_table[hash], po);
 
 	return 0;
 }
@@ -198,20 +199,24 @@ static void __delete_item(struct pppoe_net *pn, __be16 sid,
 					char *addr, int ifindex)
 {
 	int hash = hash_item(sid, addr);
-	struct pppox_sock *ret, **src;
+	struct pppox_sock *ret, __rcu **src;
 
-	ret = pn->hash_table[hash];
+	ret = rcu_dereference_protected(pn->hash_table[hash], lockdep_is_held(&pn->hash_lock));
 	src = &pn->hash_table[hash];
 
 	while (ret) {
 		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
 		    ret->pppoe_ifindex == ifindex) {
-			*src = ret->next;
+			struct pppox_sock *next;
+
+			next = rcu_dereference_protected(ret->next,
+							 lockdep_is_held(&pn->hash_lock));
+			rcu_assign_pointer(*src, next);
 			break;
 		}
 
 		src = &ret->next;
-		ret = ret->next;
+		ret = rcu_dereference_protected(ret->next, lockdep_is_held(&pn->hash_lock));
 	}
 }
 
@@ -225,11 +230,9 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 {
 	struct pppox_sock *po;
 
-	read_lock_bh(&pn->hash_lock);
 	po = __get_item(pn, sid, addr, ifindex);
-	if (po)
-		sock_hold(sk_pppox(po));
-	read_unlock_bh(&pn->hash_lock);
+	if (po && !refcount_inc_not_zero(&sk_pppox(po)->sk_refcnt))
+		po = NULL;
 
 	return po;
 }
@@ -258,9 +261,9 @@ static inline struct pppox_sock *get_item_by_addr(struct net *net,
 static inline void delete_item(struct pppoe_net *pn, __be16 sid,
 					char *addr, int ifindex)
 {
-	write_lock_bh(&pn->hash_lock);
+	spin_lock(&pn->hash_lock);
 	__delete_item(pn, sid, addr, ifindex);
-	write_unlock_bh(&pn->hash_lock);
+	spin_unlock(&pn->hash_lock);
 }
 
 /***************************************************************************
@@ -276,14 +279,16 @@ static void pppoe_flush_dev(struct net_device *dev)
 	int i;
 
 	pn = pppoe_pernet(dev_net(dev));
-	write_lock_bh(&pn->hash_lock);
+	spin_lock(&pn->hash_lock);
 	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
-		struct pppox_sock *po = pn->hash_table[i];
+		struct pppox_sock *po = rcu_dereference_protected(pn->hash_table[i],
+								  lockdep_is_held(&pn->hash_lock));
 		struct sock *sk;
 
 		while (po) {
 			while (po && po->pppoe_dev != dev) {
-				po = po->next;
+				po = rcu_dereference_protected(po->next,
+							       lockdep_is_held(&pn->hash_lock));
 			}
 
 			if (!po)
@@ -300,7 +305,7 @@ static void pppoe_flush_dev(struct net_device *dev)
 			 */
 
 			sock_hold(sk);
-			write_unlock_bh(&pn->hash_lock);
+			spin_unlock(&pn->hash_lock);
 			lock_sock(sk);
 
 			if (po->pppoe_dev == dev &&
@@ -320,11 +325,12 @@ static void pppoe_flush_dev(struct net_device *dev)
 			 */
 
 			BUG_ON(pppoe_pernet(dev_net(dev)) == NULL);
-			write_lock_bh(&pn->hash_lock);
-			po = pn->hash_table[i];
+			spin_lock(&pn->hash_lock);
+			po = rcu_dereference_protected(pn->hash_table[i],
+						       lockdep_is_held(&pn->hash_lock));
 		}
 	}
-	write_unlock_bh(&pn->hash_lock);
+	spin_unlock(&pn->hash_lock);
 }
 
 static int pppoe_device_event(struct notifier_block *this,
@@ -542,6 +548,7 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 		return -ENOMEM;
 
 	sock_init_data(sock, sk);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	sock->state	= SS_UNCONNECTED;
 	sock->ops	= &pppoe_ops;
@@ -681,9 +688,9 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 		       &sp->sa_addr.pppoe,
 		       sizeof(struct pppoe_addr));
 
-		write_lock_bh(&pn->hash_lock);
+		spin_lock(&pn->hash_lock);
 		error = __set_item(pn, po);
-		write_unlock_bh(&pn->hash_lock);
+		spin_unlock(&pn->hash_lock);
 		if (error < 0)
 			goto err_put;
 
@@ -1052,11 +1059,11 @@ static inline struct pppox_sock *pppoe_get_idx(struct pppoe_net *pn, loff_t pos)
 	int i;
 
 	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
-		po = pn->hash_table[i];
+		po = rcu_dereference(pn->hash_table[i]);
 		while (po) {
 			if (!pos--)
 				goto out;
-			po = po->next;
+			po = rcu_dereference(po->next);
 		}
 	}
 
@@ -1065,19 +1072,19 @@ static inline struct pppox_sock *pppoe_get_idx(struct pppoe_net *pn, loff_t pos)
 }
 
 static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(pn->hash_lock)
+	__acquires(RCU)
 {
 	struct pppoe_net *pn = pppoe_pernet(seq_file_net(seq));
 	loff_t l = *pos;
 
-	read_lock_bh(&pn->hash_lock);
+	rcu_read_lock();
 	return l ? pppoe_get_idx(pn, --l) : SEQ_START_TOKEN;
 }
 
 static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct pppoe_net *pn = pppoe_pernet(seq_file_net(seq));
-	struct pppox_sock *po;
+	struct pppox_sock *po, *next;
 
 	++*pos;
 	if (v == SEQ_START_TOKEN) {
@@ -1085,14 +1092,15 @@ static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 		goto out;
 	}
 	po = v;
-	if (po->next)
-		po = po->next;
+	next = rcu_dereference(po->next);
+	if (next)
+		po = next;
 	else {
 		int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
 
 		po = NULL;
 		while (++hash < PPPOE_HASH_SIZE) {
-			po = pn->hash_table[hash];
+			po = rcu_dereference(pn->hash_table[hash]);
 			if (po)
 				break;
 		}
@@ -1103,10 +1111,9 @@ static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void pppoe_seq_stop(struct seq_file *seq, void *v)
-	__releases(pn->hash_lock)
+	__releases(RCU)
 {
-	struct pppoe_net *pn = pppoe_pernet(seq_file_net(seq));
-	read_unlock_bh(&pn->hash_lock);
+	rcu_read_unlock();
 }
 
 static const struct seq_operations pppoe_seq_ops = {
@@ -1149,7 +1156,7 @@ static __net_init int pppoe_init_net(struct net *net)
 	struct pppoe_net *pn = pppoe_pernet(net);
 	struct proc_dir_entry *pde;
 
-	rwlock_init(&pn->hash_lock);
+	spin_lock_init(&pn->hash_lock);
 
 	pde = proc_create_net("pppoe", 0444, net->proc_net,
 			&pppoe_seq_ops, sizeof(struct seq_net_private));
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index ff3beda1312c..db45d6f1c4f4 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -43,7 +43,7 @@ struct pppox_sock {
 	/* struct sock must be the first member of pppox_sock */
 	struct sock sk;
 	struct ppp_channel chan;
-	struct pppox_sock	*next;	  /* for hash table */
+	struct pppox_sock __rcu	*next;	  /* for hash table */
 	union {
 		struct pppoe_opt pppoe;
 		struct pptp_opt  pptp;
-- 
2.43.0


