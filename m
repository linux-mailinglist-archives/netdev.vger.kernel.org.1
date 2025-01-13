Return-Path: <netdev+bounces-157827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E725A0BEB4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0F16432D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE58192D8B;
	Mon, 13 Jan 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXWw7dFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DD1BD9C6
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788514; cv=none; b=Fjpsnmb7wsHzz/tiRU7wzwfiYnqyI1aJ3R5uR1OUpxpojBUrIX6PFT9kZsquOBEPm8NfOABthrqBvNxsNVKe5bIIJ0VB66iywYD7DrLdcfqS2rZf3Wk/EOnzo+fOp4Pv/KvrXAW1686ZcokVxUMmuLB3M0iusc75oM43ytGAhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788514; c=relaxed/simple;
	bh=QxHYq11v0GPmv07J5rZKycSL21t9qzWQyUMjeo36l8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WSWAQsyiFosDQ6sGx8K41nfTzvAWPQUlgAMbSI0vVGIjhJmlrDCizMPGsCReRIK689CcFXm//nvast7FuwAoSzk67N7vfUTK1oonIwwdtk09unGvg6RhyLhmuxDTSCl6/lk/I8SVkoM+o73HqIAb+KFgUiGckLBFR89beijGeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXWw7dFA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6c6429421so710967585a.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736788512; x=1737393312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=St5jy7jF6LFZ+72s60cKWVoQFCGimnvb7U/CKETQ1Jw=;
        b=RXWw7dFACk61qaR31m/Aon8F1rk/f6a6aqXkWHUqmP9pKHnGjwCa99H7VoYGiboNFr
         AbYq8vhX8FkMyM0zIo/HmqSiQlCi1jtXQjliuDxDjGDFrNSrASrWgftpnn4NpOsa3RpO
         or5IvLNeucSq9hssqcQr+NYVD2Jxmy4Aarw8QC1cmFvGucvYshRxQSi/gW6w9Q/j5pBO
         6YB4UcB3Mrz5VpyFUWlY6XaIfaQ0QWWA6HCiTf6dyh//8+oVqsgnDGQrIyqOxsQVTfvZ
         31fr6QGED5kms7hMlgtK8gJEgbVp7igAiKl4atIUddcJ8qTNEKmSJmf+WLfJtqrdlJ+p
         flPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736788512; x=1737393312;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St5jy7jF6LFZ+72s60cKWVoQFCGimnvb7U/CKETQ1Jw=;
        b=HDv4KvlRt1nLplj946DE6uyc5jqk9I1wN5+Y3vZuSxiehYUCTjCcwWcaMtR75guGiX
         s1Gywu90p1LMQVlVcwccxHLUNStIaQOc4tvRYGB8wuoqHUMtOWpFEaCgWuScl/hIDP7/
         q3Z8vxRvKRBzWGfXJBRQW0M9CcsMbXD4y/K3VHXscUr4WvkfC3Q1UcmluFKzXcEQC7h4
         s376TEOdtnzPFT9Lxz58L1Hvz3v9SOfz4ni+af5/h+XCn5Uf/BFgk5s8MZ98aVf0bScu
         gnToN9LQL7LqcYC7AA8y5IF3yTODHajSvemTbI590qONfyLKL0fz5ST4WtqbU/Ogq076
         MI0Q==
X-Gm-Message-State: AOJu0Yx4chMX7aGFPawSYLnWZ+I9vKkIsiMztJ86Sd2x4gNnUk5iPxzu
	D2glTUuYjpS48iZLn0iCnB96+fwmtQ93/IdIqRRzol2sAMXEWwzvGOcay/Fm90s945lSiqiSyV1
	B0NaoQrTEEg==
X-Google-Smtp-Source: AGHT+IHq/AXv+1J6e3npvquUzYYQn8XgiVr90W8AuMT2ud2EARHMo9C98Uqa/FkyN09Pm2a17XgAucWCikGCmg==
X-Received: from qkhn17.prod.google.com ([2002:a05:620a:2231:b0:7b6:cb86:dc0d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1729:b0:7b7:142d:53a9 with SMTP id af79cd13be357-7bcd9773145mr3499684285a.51.1736788511847;
 Mon, 13 Jan 2025 09:15:11 -0800 (PST)
Date: Mon, 13 Jan 2025 17:15:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250113171509.3491883-1-edumazet@google.com>
Subject: [PATCH net-next] inet: ipmr: fix data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following fields of 'struct mr_mfc' can be updated
concurrently (no lock protection) from ip_mr_forward()
and ip6_mr_forward()

- bytes
- pkt
- wrong_if
- lastuse

They also can be read from other functions.

Convert bytes, pkt and wrong_if to atomic_long_t,
and use READ_ONCE()/WRITE_ONCE() for lastuse.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/mroute_base.h |  6 +++---
 net/ipv4/ipmr.c             | 28 ++++++++++++++--------------
 net/ipv4/ipmr_base.c        |  6 +++---
 net/ipv6/ip6mr.c            | 28 ++++++++++++++--------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 9dd4bf1572553ffbf41bade97393fac091797a8d..58a2401e4b551bad0eadb9c5d4c341ddad48b39b 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -146,9 +146,9 @@ struct mr_mfc {
 			unsigned long last_assert;
 			int minvif;
 			int maxvif;
-			unsigned long bytes;
-			unsigned long pkt;
-			unsigned long wrong_if;
+			atomic_long_t bytes;
+			atomic_long_t pkt;
+			atomic_long_t wrong_if;
 			unsigned long lastuse;
 			unsigned char ttls[MAXVIFS];
 			refcount_t refcount;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 99d8faa508e5325c653c920855a52f24b661618c..21ae7594a8525a0df01ce01b801d0075dada0959 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -831,7 +831,7 @@ static void ipmr_update_thresholds(struct mr_table *mrt, struct mr_mfc *cache,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int vif_add(struct net *net, struct mr_table *mrt,
@@ -1681,9 +1681,9 @@ int ipmr_ioctl(struct sock *sk, int cmd, void *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr->src.s_addr, sr->grp.s_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -1753,9 +1753,9 @@ int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ipmr_cache_find(mrt, sr.src.s_addr, sr.grp.s_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -1988,9 +1988,9 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	int vif, ct;
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (c->mfc_origin == htonl(INADDR_ANY) && true_vifi >= 0) {
 		struct mfc_cache *cache_proxy;
@@ -2021,7 +2021,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			goto dont_forward;
 		}
 
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
@@ -3029,9 +3029,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index f0af12a2f70bcdf5ba54321bf7ebebe798318abb..03b6eee407a24117612d2254c5eb72e78f39c196 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -263,9 +263,9 @@ int mr_fill_mroute(struct mr_table *mrt, struct sk_buff *skb,
 	lastuse = READ_ONCE(c->mfc_un.res.lastuse);
 	lastuse = time_after_eq(jiffies, lastuse) ? jiffies - lastuse : 0;
 
-	mfcs.mfcs_packets = c->mfc_un.res.pkt;
-	mfcs.mfcs_bytes = c->mfc_un.res.bytes;
-	mfcs.mfcs_wrong_if = c->mfc_un.res.wrong_if;
+	mfcs.mfcs_packets = atomic_long_read(&c->mfc_un.res.pkt);
+	mfcs.mfcs_bytes = atomic_long_read(&c->mfc_un.res.bytes);
+	mfcs.mfcs_wrong_if = atomic_long_read(&c->mfc_un.res.wrong_if);
 	if (nla_put_64bit(skb, RTA_MFC_STATS, sizeof(mfcs), &mfcs, RTA_PAD) ||
 	    nla_put_u64_64bit(skb, RTA_EXPIRES, jiffies_to_clock_t(lastuse),
 			      RTA_PAD))
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 578ff1336afeff7a9f468d54c8fc47fddcaedbbb..535e9f72514c06ad655e46d3200c14298f584d99 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -520,9 +520,9 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 
 		if (it->cache != &mrt->mfc_unres_queue) {
 			seq_printf(seq, " %8lu %8lu %8lu",
-				   mfc->_c.mfc_un.res.pkt,
-				   mfc->_c.mfc_un.res.bytes,
-				   mfc->_c.mfc_un.res.wrong_if);
+				   atomic_long_read(&mfc->_c.mfc_un.res.pkt),
+				   atomic_long_read(&mfc->_c.mfc_un.res.bytes),
+				   atomic_long_read(&mfc->_c.mfc_un.res.wrong_if));
 			for (n = mfc->_c.mfc_un.res.minvif;
 			     n < mfc->_c.mfc_un.res.maxvif; n++) {
 				if (VIF_EXISTS(mrt, n) &&
@@ -884,7 +884,7 @@ static void ip6mr_update_thresholds(struct mr_table *mrt,
 				cache->mfc_un.res.maxvif = vifi + 1;
 		}
 	}
-	cache->mfc_un.res.lastuse = jiffies;
+	WRITE_ONCE(cache->mfc_un.res.lastuse, jiffies);
 }
 
 static int mif6_add(struct net *net, struct mr_table *mrt,
@@ -1945,9 +1945,9 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
-			sr->pktcnt = c->_c.mfc_un.res.pkt;
-			sr->bytecnt = c->_c.mfc_un.res.bytes;
-			sr->wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr->pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr->bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr->wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 			return 0;
 		}
@@ -2017,9 +2017,9 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
-			sr.pktcnt = c->_c.mfc_un.res.pkt;
-			sr.bytecnt = c->_c.mfc_un.res.bytes;
-			sr.wrong_if = c->_c.mfc_un.res.wrong_if;
+			sr.pktcnt = atomic_long_read(&c->_c.mfc_un.res.pkt);
+			sr.bytecnt = atomic_long_read(&c->_c.mfc_un.res.bytes);
+			sr.wrong_if = atomic_long_read(&c->_c.mfc_un.res.wrong_if);
 			rcu_read_unlock();
 
 			if (copy_to_user(arg, &sr, sizeof(sr)))
@@ -2142,9 +2142,9 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	int true_vifi = ip6mr_find_vif(mrt, dev);
 
 	vif = c->_c.mfc_parent;
-	c->_c.mfc_un.res.pkt++;
-	c->_c.mfc_un.res.bytes += skb->len;
-	c->_c.mfc_un.res.lastuse = jiffies;
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
 
 	if (ipv6_addr_any(&c->mf6c_origin) && true_vifi >= 0) {
 		struct mfc6_cache *cache_proxy;
@@ -2162,7 +2162,7 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
 	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
-		c->_c.mfc_un.res.wrong_if++;
+		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && mrt->mroute_do_assert &&
 		    /* pimsm uses asserts, when switching from RPT to SPT,
-- 
2.47.1.613.gc27f4b7a9f-goog


