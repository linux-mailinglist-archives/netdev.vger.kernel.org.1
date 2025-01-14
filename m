Return-Path: <netdev+bounces-158259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56300A113E4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC503A2318
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220B2139B0;
	Tue, 14 Jan 2025 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EucL4WUZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4E2139BF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892654; cv=none; b=e7R/Ti93zEZ/mIN68VspqNmDQI7VIln+bs3rYp2GQflPD+Sloa1RDU+lGg1ANPMhZh+l4lp8RCRZ/pbe5cIEmDzfZDSYxct/ZubJABxcVtx1tG7aHu+Ulg/XraJNT9Av8Zjc21HkAuJq4EvTu1KGvvtOdc16+T84gQOtGRHIGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892654; c=relaxed/simple;
	bh=7pgIQF27IyKrH8/3vhQe4Y0WbK5YwYnxjYZbggvRozo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SmIAu0Bk7WzWzW7GNmo1YKwwpIFzlyggI6H+8VYSOgSR/wa8GutHivK10G+Jv2oE8g9jZo9xoGCz2qRYRL6HD8MEIG0hwJYR4zsnVclYH/fSnjLGttF+4YQRumqY4i8gDC+qBl8BQhUZVjwi/Q3iEy1YMrqdjzW7WA/BVFkR1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EucL4WUZ; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6df9ac8dcbeso206980816d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736892651; x=1737497451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ar0f41NeRhn+VAPwcHwTjUfvhoeFLVCwapTrRJREbX8=;
        b=EucL4WUZuV3/9MPLzoJNHwiYNVad6XeruM7CEJj2Mn9YqIZpcioS0TQpjkR5MFcZPT
         UgBgTJcYFpF48SQPZvyzfVgjqdq5RaZwwodQkGY3CgesdS+r2JuBwEj3dkaIUFGlqajV
         OUVBMV3AV7vCXCCztxx3w0EWhOf7R1+4zU8LFMAyV9TZjIfXL532fIRAf7sZl+nNGz5C
         oR+PYC7NaehOne074QNNXeFpv2d2QC7mazob628hkOjIAtLxdhLkBkjpXGZwu7pT1H3i
         5PGfxtBL+cbktUDt23YkcQsuQAvTyK3urUaqG3n1TNr5PhEXoSc3I4HOU0085uiRpmki
         pIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736892651; x=1737497451;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ar0f41NeRhn+VAPwcHwTjUfvhoeFLVCwapTrRJREbX8=;
        b=r+4XTNxiEOxukOzn1Kx+2q7SRrFJt0i6phEc3DF6yYF4LJxrs8XBTfYPtbsXWCu3S3
         MbhcDtTJfuvi/QtHRAZaLgvWlCWgUuzUlYL+Pl2B9eri73tU7k1gKrs33I6awXCnoDXc
         gFrLErLxUJvk/ZOnHZA49dnbvcXrBjC1qli9g3QN+u1TiYO5s/tZDUvhtuXVcY+giNsY
         xEGRVognOyGb+XoTyD3cMWNYBi9yJKE4wnMRQKbE0Vg2Ln38BqyhniY6mTGRtl/9CyEj
         Gt19OH5O8UbcQlloHXINrTgxbldWoE7/UWHjWre7oeIGQQF1hHi3HItPRcw6lCE9jrcE
         L8uA==
X-Gm-Message-State: AOJu0YxvIl2bh6qt0Q07nPfJdoY1i2u64DZXyxh5ZK1/pjHlqv0IM6x9
	wmDhjk78Rp2vvsPAZ9BZ1qWlvwamQF5Xqs/OfeLHNPOrcMtdyvlin9whOC6LQKaZkouwe4SDzAl
	qr39G1Vz4+A==
X-Google-Smtp-Source: AGHT+IEN8B5ZTjG57iuh6k0sPaxruInz6i7P4z93wlI4tYW4B3Bn9vxKClqDwu7YpcgHOwYpY5r4vuZkZYRV3Q==
X-Received: from qvbkf4.prod.google.com ([2002:a05:6214:5244:b0:6dd:d513:6126])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:23cd:b0:6d8:7c82:e542 with SMTP id 6a1803df08f44-6df9b1ce1eemr401220506d6.4.1736892651250;
 Tue, 14 Jan 2025 14:10:51 -0800 (PST)
Date: Tue, 14 Jan 2025 22:10:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114221049.1190631-1-edumazet@google.com>
Subject: [PATCH v2 net-next] inet: ipmr: fix data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
---

v2: fix drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c (Jakub)

v1: https://lore.kernel.org/netdev/CANn89i+G_GfMCYwbYEq7+XHbqjxPWDrA9dRJ35pTQji1xuB+Rw@mail.gmail.com/T/#mdbd49117673fd077214b938e3800cbc43be27ba6

 .../net/ethernet/mellanox/mlxsw/spectrum_mr.c |  8 +++---
 include/linux/mroute_base.h                   |  6 ++--
 net/ipv4/ipmr.c                               | 28 +++++++++----------
 net/ipv4/ipmr_base.c                          |  6 ++--
 net/ipv6/ip6mr.c                              | 28 +++++++++----------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
index 69cd689dbc83e9b2a1508b8d160f07159081c7cc..5afe6b155ef0d5c9c3048c5f33f4822ebc8a7ac2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -1003,10 +1003,10 @@ static void mlxsw_sp_mr_route_stats_update(struct mlxsw_sp *mlxsw_sp,
 	mr->mr_ops->route_stats(mlxsw_sp, mr_route->route_priv, &packets,
 				&bytes);
 
-	if (mr_route->mfc->mfc_un.res.pkt != packets)
-		mr_route->mfc->mfc_un.res.lastuse = jiffies;
-	mr_route->mfc->mfc_un.res.pkt = packets;
-	mr_route->mfc->mfc_un.res.bytes = bytes;
+	if (atomic_long_read(&mr_route->mfc->mfc_un.res.pkt) != packets)
+		WRITE_ONCE(mr_route->mfc->mfc_un.res.lastuse, jiffies);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.pkt, packets);
+	atomic_long_set(&mr_route->mfc->mfc_un.res.bytes, bytes);
 }
 
 static void mlxsw_sp_mr_stats_update(struct work_struct *work)
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
2.48.0.rc2.279.g1de40edade-goog


