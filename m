Return-Path: <netdev+bounces-101131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BCB8FD6D3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E0DB25E32
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88919154449;
	Wed,  5 Jun 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="BJcDNcuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C9B154C11
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617303; cv=none; b=Mf/iSAjfUbmRWSaFI6M7jdJ0wtxnWSZqxZBZUE4UqCKCNuemIB6+DuykG3ehmJzloDv1G3nBoO6LbR8M4S0ENcGv6d2DScWz/e+mrXwQbP/iZj/HuTvYNCyfhHxdWK0t+7hPQW2/qILyGYvWBSqR8zjkEJZGfuTEsQpWElADJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617303; c=relaxed/simple;
	bh=8+KzmAseRwYuap2YctBMNPnphwGzX37Qq/+HLRe5qrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rc4zVdqywl6JkUNkDTQ8yu7krgn3GxZLbZki2gSJtX/oOtuTCq398yWaYKcJv1AozJ4sLUpOCyPGIQoA3Y78ZqaKCw9G0B8AIPf7OhtTzStfia+PkUaGPQdHZ22Zfhj1DL6sAJxmhx4kGDBhBu07+chdoGDJtjPz18ACBlKQfVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=BJcDNcuZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so178103a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1717617298; x=1718222098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aW60LEj6j9GwU2MV/alkjrJr7iIEbZOcwkGUz4aZGww=;
        b=BJcDNcuZGmqO5Gm8iPaEyR0KSi2JGmIw0LhaJkOMTZpvF0bHGLNu1sAeuKY8cYMXxl
         jVBNf1E1rP9BaVVy2N0srKRd835VX/wAIJkgOckVYA9sJqdUZNi98DuoA96IFW2yIBWt
         zPZ/kj6PFs2QDkuT9GuInzm3SrNeVGxMyPg+n1bWmLHIXLwhe5A3491h41fdRsOlbLvV
         geQjLU6K1SKJ1bFpf43tWLBnUPyR50P0QBY0GLYhcX97C2RSkqE/ginWmtno38V09uqa
         T6nHIju+89DgJpKKS7isILRwF3sjVbeSTYz0kFi/Xce4IOlWGKuc6zLmXC/I/c1qjhYX
         zGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617298; x=1718222098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW60LEj6j9GwU2MV/alkjrJr7iIEbZOcwkGUz4aZGww=;
        b=XMPBS/88wd1WKBI9vFuTQXgI73t2oWjIZcg0cfgpD349yC6YZNOjn1rsbIPKIPXyCo
         ArfhxHbsXb3iH7Wbtn7aQq3C19FamENRa5Aq4MLZpRVyVRXBO/nky+TS7sKFJS4X9qv4
         /U2Bo/fGfFNJniBHjfKo6x9zoendRl/gq30slj4o8SbqWHhU1KMUphH43viSn5f3ucr8
         iQNJHGny/5DzWmkk2mHnLr4JK5cno6Nm8Re0+ReWTi6GSIgrIjAYC8gzKF35V8l571wv
         HdqEGpWTMv1evsSyxiuYepacZCFr4Uisy3mY6TLxOxxr7wtOBAL0tCrInuH17utIDJm1
         3WuA==
X-Gm-Message-State: AOJu0YwHbjgoTnhjHI89Kwsm7WOygPxyjEdAua9NNX+EbsMGLaR56Xqf
	sm3jzg/FisUsFZ0sy1mpCeRgEcPdnbs7xKzH16zjnRnC4e9U/ItWYGnnx20ir2dLzsSxhuzToUS
	umw==
X-Google-Smtp-Source: AGHT+IHHL1tKrTtaTAINDfE/QNTh7PkGsKG05Gk3k6mtSz4qA9CpDGgq6e315B0wEYQZjxe/LVDAfw==
X-Received: by 2002:a50:d6d4:0:b0:57a:303f:94c1 with SMTP id 4fb4d7f45d1cf-57a8bcb236fmr2374720a12.29.1717617297899;
        Wed, 05 Jun 2024 12:54:57 -0700 (PDT)
Received: from ntb.petris.klfree.czf (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57a52f5cbd3sm7448769a12.12.2024.06.05.12.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:54:57 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] ip6mr: Fix lockdep and sparse RCU warnings
Date: Wed,  5 Jun 2024 21:53:55 +0200
Message-Id: <20240605195355.363936-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6mr_vif_seq_start() must lock RCU even in a case of error, because
stop callback is called unconditionally.

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table
should be done under RCU or RTNL lock. Lock RCU before the call unless
it's done already or RTNL lock is held.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/ipv6/ip6mr.c | 52 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cb0ee81a068a..bf6932535d6d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -411,13 +411,14 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
+
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
@@ -1885,17 +1886,21 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
 		vr = (struct sioc_mif_req6 *)arg;
-		if (vr->mifi >= mrt->maxvif)
+		if (vr->mifi >= mrt->maxvif) {
+			rcu_read_unlock();
 			return -EINVAL;
+		}
 		vr->mifi = array_index_nospec(vr->mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr->mifi];
 		if (VIF_EXISTS(mrt, vr->mifi)) {
 			vr->icount = READ_ONCE(vif->pkt_in);
@@ -1910,7 +1915,6 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 	case SIOCGETSGCNT_IN6:
 		sr = (struct sioc_sg_req6 *)arg;
 
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr->src.sin6_addr,
 				     &sr->grp.sin6_addr);
 		if (c) {
@@ -1923,6 +1927,7 @@ int ip6mr_ioctl(struct sock *sk, int cmd, void *arg)
 		rcu_read_unlock();
 		return -EADDRNOTAVAIL;
 	default:
+		rcu_read_unlock();
 		return -ENOIOCTLCMD;
 	}
 }
@@ -1953,18 +1958,33 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
+	switch (cmd) {
+	case SIOCGETMIFCNT_IN6:
+		if (copy_from_user(&vr, arg, sizeof(vr)))
+			return -EFAULT;
+		break;
+	case SIOCGETSGCNT_IN6:
+		if (copy_from_user(&sr, arg, sizeof(sr)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
-	if (!mrt)
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	switch (cmd) {
 	case SIOCGETMIFCNT_IN6:
-		if (copy_from_user(&vr, arg, sizeof(vr)))
-			return -EFAULT;
-		if (vr.mifi >= mrt->maxvif)
+		if (vr.mifi >= mrt->maxvif) {
+			rcu_read_unlock();
 			return -EINVAL;
+		}
 		vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
-		rcu_read_lock();
 		vif = &mrt->vif_table[vr.mifi];
 		if (VIF_EXISTS(mrt, vr.mifi)) {
 			vr.icount = READ_ONCE(vif->pkt_in);
@@ -1980,10 +2000,6 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		rcu_read_unlock();
 		return -EADDRNOTAVAIL;
 	case SIOCGETSGCNT_IN6:
-		if (copy_from_user(&sr, arg, sizeof(sr)))
-			return -EFAULT;
-
-		rcu_read_lock();
 		c = ip6mr_cache_find(mrt, &sr.src.sin6_addr, &sr.grp.sin6_addr);
 		if (c) {
 			sr.pktcnt = c->_c.mfc_un.res.pkt;
@@ -1997,8 +2013,6 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 		}
 		rcu_read_unlock();
 		return -EADDRNOTAVAIL;
-	default:
-		return -ENOIOCTLCMD;
 	}
 }
 #endif
@@ -2275,11 +2289,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
+	if (!mrt) {
+		rcu_read_lock();
 		return -ENOENT;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
-- 
2.39.2


