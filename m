Return-Path: <netdev+bounces-216774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7DB351B7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1FE17FFB7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734C1F4179;
	Tue, 26 Aug 2025 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi1Tcuh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FD1FC3;
	Tue, 26 Aug 2025 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175644; cv=none; b=cm64AotTNjANI40oHeab/MPQv7TO+UKsnkjkE/ykiGmm++gXycIXnQ7NMw7JpzocHyYvqncOTqcr8oi3YDfqc4Cpgi1yMsrpoRk5XK59EGfk/1PwKc7y+dKXMi7YyzvIt/Jy3eUW6YnVUQzaUU9Eftdny8+HHu63X2y2t7rLmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175644; c=relaxed/simple;
	bh=0fB6SZaVSS7UyDWirAgkBz+kwMfPCPYlJc1N5SISi2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DfFiRzZU57pKKzlFWDxBLy6N1tN3qLTwooORs6wvR7QZElU/I+63z1CgPvYzyg7aMmJcRe0O6fTJ1z/Fk8v0yAhYkw0rYkFRSLmZjAJnL+r6PTWoVI1JblEx/TNcjPk8P0gDe+ad924V4ef4xAqunHPk7UcS3jtI6bqcBHwRLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi1Tcuh1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24680b19109so21154585ad.1;
        Mon, 25 Aug 2025 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175641; x=1756780441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFcri2paOGy6bOzwBR8SkIvo6pm0SDsz/XVeAilXmVo=;
        b=Xi1Tcuh1hl7BexUAWFskmYOEXppXlo6QVNCvR74GWuciZAxcvs0P0FArNHFYbQIgQa
         RQl5sCdqQ6WyQEvht6oWNTx+knrQjzNzIHb0g/1YVFsUT3DNNPJdri2aEefSgL+dlaUx
         5lGD9P3e0+PodOarLKeYyeOuTHHEln0SJqFxHF7cHSmeX1S0F1BtWMP69Kxb5ykMmtf2
         PPpnJ3XL17S9Nq9PUoDTcZBXcEOF1ELFyY9NHO5yTQBIABn1IaNVWNAtqyW+KQJrPmPD
         zKIMPp3z6f9mvQ7VFI83HWaTYOaNQpU4+G8di37ergBwrZWxTRqi4Mcj4/sf+d8WVVK6
         JQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175641; x=1756780441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFcri2paOGy6bOzwBR8SkIvo6pm0SDsz/XVeAilXmVo=;
        b=wfOsCpYtCyF4A0X8CuuQOxmaTh6UvZr5tP8QclnINMpjfzBjEW4TmSiRgjCzEjGYEb
         KP4jNCoQEvve4qqF9LsFaFf7K1PExYflBsiDJKx60LksEi95WyxcAHX2PWsCdU3ENp76
         pNFAbVdypFkWa/Q73KHDQ66xM5/VgonumFek0mlLISUCGU1Iy3ickBxWUY+5u53OcsEN
         ovPoO8j9OMQsjMf/+oanImJHNRDXiQKKqHas9TZfqWdNhUAFut6y08j1NwWLV5VjeoNd
         VjPcsGrtrNK1+KkozjT5S0sIaxLyZnmhkCfvnZe8cx5bgEnAbfmsYPKIjp2T6wtQWpEC
         JCkg==
X-Forwarded-Encrypted: i=1; AJvYcCU2JtpXSrBuTt0M6XrdkEqKxjXP38e9sh5IOC7ncJh6iMUaO23sZZGHIN1hvaOevrCk/XX/Bfrs@vger.kernel.org, AJvYcCXkZYebRIK60alo15bcSqnczEwcAOBVgEM6vLwyETC9nIqaGC4eTCOYOVbajUHEo4j+cP3agVsdTxVd6HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCyGIp2+VuFElhgcLy1BCcI+k1qLewmLcLfj3UeA4dv5j5pjk
	AYrrzmlIqhjDPBo88QJbdZDPvSxgMRHnRr/l7hk7sdINL2XcsroKPheV4W48KKXj
X-Gm-Gg: ASbGncvKDumaYSACfOx6OmFi1qjp6TgLTTTXs2Qmi8pJJJtxEy90IfZM6fBLLjiHjPE
	h2IIDlduaYxb9Ltlso5FwmUNdNJ9Oo34uqrqfB+TvHiVGoXnsyA7gx2KXupUTYd1rd9HEpfnrTM
	5xUZl/lurDDdZ6p9Vophb3EJ+ib4vH8tulZnzP49+EoIMRknbY7Tr1stgoWOeN+iQ6mhgzNfYO5
	0tE4bE0gIPtzYmTFrP8JRe5ElioGcrwEmyC8FYp9U0p6juX6t/ThS0HO+iIbuhDadkuAL+kcbgx
	xprBcZhiBT9Kkjff2xVfjRcPx/QS5NbR7LhCKUcKXjAk2AzbNm45HvlnnAqOPi7wA3WD7PfTcvE
	cQLfHedWT1P1IAA==
X-Google-Smtp-Source: AGHT+IEXgilS/+BmoIPiFSWCXhYfPZjwhyAkPsabtZu0D6t+DI+efG0AYGRRV4wHYt7cRrl3FPhzkQ==
X-Received: by 2002:a17:902:dad1:b0:242:9bc6:63c3 with SMTP id d9443c01a7336-2462efaa3b8mr195938865ad.54.1756175640709;
        Mon, 25 Aug 2025 19:34:00 -0700 (PDT)
Received: from gmail.com ([223.166.87.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467a6f5489sm76072815ad.144.2025.08.25.19.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:34:00 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] pppoe: remove rwlock usage
Date: Tue, 26 Aug 2025 10:33:44 +0800
Message-ID: <20250826023346.26046-1-dqfext@gmail.com>
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
- Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
  period.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ppp/pppoe.c  | 83 ++++++++++++++++++++++------------------
 include/linux/if_pppox.h |  2 +-
 2 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 410effa42ade..f99533c80b66 100644
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
 	if (po)
 		sock_hold(sk_pppox(po));
-	read_unlock_bh(&pn->hash_lock);
 
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


