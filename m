Return-Path: <netdev+bounces-217562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E07CDB39105
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CD81B21C96
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F5E1E51F6;
	Thu, 28 Aug 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNHyIatq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FE523A;
	Thu, 28 Aug 2025 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344034; cv=none; b=PdAAxjvhvkIpz2Afwqg+CfQTGzCkPNZbesztUSWEd597AtQgoKUCQXGvS5/CV8vss2+xWjIr/l+YIoCRTahYsReHCEm1UNYPqzKV9YEtHudnyVS/fy8BlPw5f97laJ2/846PufVZX06pBWVA6tvokO7TIPI8BxCRg60WapnyPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344034; c=relaxed/simple;
	bh=KVQ9jhSuIGwlWzl1T2A5LzckWKt6aeTzj7RhzSOBQzk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dpod4OiUvqDqc6SsDd4cMZWB6gs7lBVrWUYPgCDuDtTKXG8kDJs3ybsjZV6C3b2VWIyJ8j7Oxe9QllFpcESRqESclhCqvMXm561QbFCoE7VtFBktXT6gH39wBQakBfr9JR4czq3ItL7riEIgwpvz2NlFW4iNblOKFz6PICo+QJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNHyIatq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7720f23123dso442419b3a.2;
        Wed, 27 Aug 2025 18:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756344032; x=1756948832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bD6RGeZjK9NgE8HepDzM77xqMEuOk7DRuN9l+Ring9k=;
        b=kNHyIatqrHY4yrw5pJNAc7YcaKl2W9nBKI0CK08q8gxAt0L2eiogz1RTzMl1FfAqsu
         DQ+sbHzrLTQYbhHkw816UyqexLfXasN59cPxEsPSKfRjse+BklWh/7K37dtZ53bspM1s
         3Ve6I7coUR6lfGaTd6sPTklW0dmbcjFF7z8/1H+dj19rPc0lK5cPmJV0a15hfsG8lBXC
         Efa+BtQ+TbkpRHptb/LdSS6zge4nlsTWyUAZdr3X6Gfr5f6hJZCW1+AU7VoVlkzhJP5l
         Axia730/4YVdKSypnr06tyA8epQGw1R8ZlYSsX/rk0om4rJ8gdlEbf8s4bxdjDf/nWan
         gp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756344032; x=1756948832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bD6RGeZjK9NgE8HepDzM77xqMEuOk7DRuN9l+Ring9k=;
        b=CY7CdSWGK4tBGHccxfaF6nGTTohbkXzr9cpDLjkLuCa5Nj7ATmaf5W6XrlOkQMAkd+
         RDy6eFeuMT9r7Ulaml3flNgulJdGzfINL9tzWzb1+f7DhD9QpTUVBeXPvJsyupSt1MA6
         7D8SI7/O1I2WX050cfnG6kL2il6MqXbB5ApKVROIK6aaOIRLmkm1eZJQ5R2a4ZZ8Eehv
         65wbxcd+xh3DnfLxzNdaaRVhadWBvumQGxwJGzfernZFLWL74s8GfMK2nHjpz5OZp+l2
         p51hSzGC8gHVepo0f66Y7SJLISnuWfMo+D4u+a1ycsRLrnJijUoeepoG58mETBxy648a
         tiYA==
X-Forwarded-Encrypted: i=1; AJvYcCVDiauCr4PUu9vfqbSUXuAglGMqb3XOBgL2lUfo58E1Sy+uI3MDTQUGyfPE1vLHIbHtvWJjea0Xn6y3XIE=@vger.kernel.org, AJvYcCVseMVDrSI42IKEVMRar7pjTC4QQul5BUj1rubZ7z3R8vVaXz90efFlbi95wHjqwu6zV0Qdn+tE@vger.kernel.org
X-Gm-Message-State: AOJu0YyadfzGWNjZCtQ0BKqenhfW1NOleUIJf+gQeRSIipibj6zLMeEB
	7b2rctQP4thcckhf75124+iCeO3czptzG/wXvDdqbeAUMdpCL2w1uuZLfUl3cxWcGk0=
X-Gm-Gg: ASbGncvp68dzsRUvwiRF7jPcN2Q1uKL0Y1YahKkfiyE8B1DPzmXMm4RPqaZVaA7tPIi
	b6jSXa2GPQzNR6TqPbed6QkTOZhQTPR9k+V5lfVNFM/mScQko58x55ibfIBf96cMvip/Phv+0yO
	I8DP+mE/lP5l65BNekEk9yTF6IRoGCVHgVmtwjmKN2xCMSiRXMXIG4BSp/fAJQ8aoQep6TlI4Sd
	7UNbliCtVMsiU7BHW6BwgVOUYQrpZbURMYgFofD8YuxuCeLwZx4KJ85wpr2kl+viQZBJJWfzIBu
	Vlk5TOOQ1T5sINo1Z2juGfr8JEESWf8pGC/PFg4cYkroZ24b1g0pHq9RDrXg/bM2Cabyb1jXVoN
	OSwFjCFX51zLpMCE=
X-Google-Smtp-Source: AGHT+IGHbEbdc80JHLt22SbiQ2XiiJXYxLgzqh5cDMa3fJsrwZ7G+RbV29Dpo04JmDsWXoL4XspXVw==
X-Received: by 2002:a05:6a20:a106:b0:21a:eabb:ab93 with SMTP id adf61e73a8af0-24340bce27dmr32170801637.6.1756344032030;
        Wed, 27 Aug 2025 18:20:32 -0700 (PDT)
Received: from gmail.com ([223.166.86.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm9122626a12.35.2025.08.27.18.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 18:20:31 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] pppoe: remove rwlock usage
Date: Thu, 28 Aug 2025 09:20:16 +0800
Message-ID: <20250828012018.15922-1-dqfext@gmail.com>
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
- Move skb_queue_purge() into sk_destruct callback to ensure purge
  happens after an RCU grace period.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v3:
 Move skb_queue_purge() into sk_destruct callback.
 Link to v2: https://lore.kernel.org/netdev/20250827023045.25002-1-dqfext@gmail.com/
v2:
 Use refcount_inc_not_zero() in get_item() to avoid taking a reference of
 a zero refcount socket.
 Link to v1: https://lore.kernel.org/netdev/20250826023346.26046-1-dqfext@gmail.com/

 drivers/net/ppp/pppoe.c  | 94 ++++++++++++++++++++++------------------
 include/linux/if_pppox.h |  2 +-
 2 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..54522b26b728 100644
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
@@ -528,6 +534,11 @@ static struct proto pppoe_sk_proto __read_mostly = {
 	.obj_size = sizeof(struct pppox_sock),
 };
 
+static void pppoe_destruct(struct sock *sk)
+{
+	skb_queue_purge(&sk->sk_receive_queue);
+}
+
 /***********************************************************************
  *
  * Initialize a new struct sock.
@@ -542,11 +553,13 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 		return -ENOMEM;
 
 	sock_init_data(sock, sk);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	sock->state	= SS_UNCONNECTED;
 	sock->ops	= &pppoe_ops;
 
 	sk->sk_backlog_rcv	= pppoe_rcv_core;
+	sk->sk_destruct		= pppoe_destruct;
 	sk->sk_state		= PPPOX_NONE;
 	sk->sk_type		= SOCK_STREAM;
 	sk->sk_family		= PF_PPPOX;
@@ -599,7 +612,6 @@ static int pppoe_release(struct socket *sock)
 	sock_orphan(sk);
 	sock->sk = NULL;
 
-	skb_queue_purge(&sk->sk_receive_queue);
 	release_sock(sk);
 	sock_put(sk);
 
@@ -681,9 +693,9 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 		       &sp->sa_addr.pppoe,
 		       sizeof(struct pppoe_addr));
 
-		write_lock_bh(&pn->hash_lock);
+		spin_lock(&pn->hash_lock);
 		error = __set_item(pn, po);
-		write_unlock_bh(&pn->hash_lock);
+		spin_unlock(&pn->hash_lock);
 		if (error < 0)
 			goto err_put;
 
@@ -1052,11 +1064,11 @@ static inline struct pppox_sock *pppoe_get_idx(struct pppoe_net *pn, loff_t pos)
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
 
@@ -1065,19 +1077,19 @@ static inline struct pppox_sock *pppoe_get_idx(struct pppoe_net *pn, loff_t pos)
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
@@ -1085,14 +1097,15 @@ static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -1103,10 +1116,9 @@ static void *pppoe_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
@@ -1149,7 +1161,7 @@ static __net_init int pppoe_init_net(struct net *net)
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


