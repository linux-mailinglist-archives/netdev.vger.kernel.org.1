Return-Path: <netdev+bounces-74550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0949861D4C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336B7B237B0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B58146019;
	Fri, 23 Feb 2024 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7MIt7a3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449513DBA8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719058; cv=none; b=jurfGUllvgHOCzs8aLrFFGvcumz0yRWy3jswF/sckC6fTYc5jlf71qY3UI3A6+2Ij+QmeXGhJk6PEKyoIVQkWylaGMpaP48cPtxQrA7sJSdSq8JfpsIJFW9C2ijc4Rv2vuDfnRM5ljKF9d9nmroedXSTakDnGPPLzORdYQ61nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719058; c=relaxed/simple;
	bh=8Y2RTzagFiVJPrNEofLS7qdXzTwILaNFYPnkh/0C+7c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sImHdc0q21s4Y9NHLmntIHkfJkB8QUJ5tAjmmOZDGcj2FF5phVMgx7WsnPH04eyphLEaxlbxBMrJ3wQC4rbiW59EI0A/D09JOg1zJ0UJ931KT6BKkZ4hy7LBrNijIGiQ7p9zYOAv6Zpu0QqBuvoDgZUaI964IQhCSee0el+bmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7MIt7a3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f38d676cecso8448207b3.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708719056; x=1709323856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DYYs4PX75D+/fg0ev/CvQmnGgTYkWYrfZ0x11AwITk=;
        b=V7MIt7a3VdDtzBduFRSSNB8HNxvaTcmbQymzw4fmxPYJPKxFZM2JzuBIcXeRnwYs5k
         IgaMSiHj0zvAjOG34LWfm2eRcV5agpPa8BX8E/t93+q/LNREAppSfzzB1ADDowt3RL2/
         fHTrQM3BSgJqFN1iSUW8IuNTHLghVVDY3+wZ6qu0my1ab3dsm2J2bt2AMIB7x4Zfs1lN
         xlgh3vsENfrERamjYmlJ+wKJctPIRx9uGI50Krwz004i76vhn2dGbpxIeklclAQ/R9sf
         YpBhvgudEy6YL19qU2yotXsAEQx7iXI6R78dBXXx3LJpP3VE6a1ImukkIja5Pf+OezGx
         8L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719056; x=1709323856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DYYs4PX75D+/fg0ev/CvQmnGgTYkWYrfZ0x11AwITk=;
        b=NJZuVxA7SfyhZGYlsYGDm4b8txXzG2f1E7atVKwfJ92zdknqfTISSAmj7/zPCyh7GW
         zxu0BquQxEuy7wUGHV57Z8cNqpwNjrfJ1CIJS15XViiPmnN1JoQCv59EYohhNoJlGWDo
         ufRGn9usGm846ABZgebehgWvVhzt6sYqBwsW2wMr+501a8+0jcQ+G8btOUqi9Okvalry
         uYznj3S11K0iz6Jc/YGS1c+iyKOfKbVcPuVLzHrnVEu36SFsmI1mPG29xAGvY6XMd5QY
         wZUUYjPLw7Kt7IyZJ8Zt9Osk9pl53Lq4C5EzLDB51p74K7I0M/JVjlohkpktBIysymFw
         e8xA==
X-Forwarded-Encrypted: i=1; AJvYcCUGkfTFN7tSfCIEfZTk8uDxgiDBKVSFbJrJLbiwQbrK7IQS4XPzXPyV/KlDPkWijRVPbqJVMe81ypgVRMudA6FijdftrBg4
X-Gm-Message-State: AOJu0YxRtnkNVmowIkGqbZgcUizbacwmYDvHcpi1EQTSHxYXOuQ5F88o
	JArweKqUHyAanF804Pcg+L62/qwPbICPs9cMhGZI4Yil3GSUEnZD8u2+EvNFK/YhjZdt5RKykLo
	8PwM7UWdoVg==
X-Google-Smtp-Source: AGHT+IHuCWLtonqR+DUHB/n+M5AlgweBEGr9s1IFQRExcgVDiVF01h/8eK5j+UZNYqBoPm0ugOBKT6yUcHc8Xw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8003:0:b0:dc6:deca:8122 with SMTP id
 m3-20020a258003000000b00dc6deca8122mr194512ybk.5.1708719055994; Fri, 23 Feb
 2024 12:10:55 -0800 (PST)
Date: Fri, 23 Feb 2024 20:10:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240223201054.220534-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: anycast: complete RCU handling of struct ifacaddr6
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

struct ifacaddr6 are already freed after RCU grace period.

Add __rcu qualifier to aca_next pointer, and idev->ac_list

Add relevant rcu_assign_pointer() and dereference accessors.

ipv6_chk_acast_dev() no longer needs to acquire idev->lock.

/proc/net/anycast6 is now purely RCU protected, it no
longer acquires idev->lock.

Similarly in6_dump_addrs() can use RCU protection to iterate
through anycast addresses. It was relying on a mixture of RCU
and RTNL but next patches will get rid of RTNL there.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/if_inet6.h |  4 +--
 net/ipv6/addrconf.c    |  4 +--
 net/ipv6/anycast.c     | 61 ++++++++++++++++--------------------------
 3 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index f07642264c1eb622e57b9ce0715e296360a4db6e..238ad3349456a3afeab6c02172a9e2d681d2ec9c 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -144,7 +144,7 @@ struct ipv6_ac_socklist {
 struct ifacaddr6 {
 	struct in6_addr		aca_addr;
 	struct fib6_info	*aca_rt;
-	struct ifacaddr6	*aca_next;
+	struct ifacaddr6 __rcu	*aca_next;
 	struct hlist_node	aca_addr_lst;
 	int			aca_users;
 	refcount_t		aca_refcnt;
@@ -196,7 +196,7 @@ struct inet6_dev {
 	spinlock_t		mc_report_lock;	/* mld query report lock */
 	struct mutex		mc_lock;	/* mld global lock */
 
-	struct ifacaddr6	*ac_list;
+	struct ifacaddr6 __rcu	*ac_list;
 	rwlock_t		lock;
 	refcount_t		refcnt;
 	__u32			if_flags;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c669ea266ab717a9cbe6081d62a1f5b3c6e301f5..479c5777210acd0e3827241cb72025c4f66c38d0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5313,8 +5313,8 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 	case ANYCAST_ADDR:
 		fillargs->event = RTM_GETANYCAST;
 		/* anycast address */
-		for (ifaca = idev->ac_list; ifaca;
-		     ifaca = ifaca->aca_next, ip_idx++) {
+		for (ifaca = rcu_dereference(idev->ac_list); ifaca;
+		     ifaca = rcu_dereference(ifaca->aca_next), ip_idx++) {
 			if (ip_idx < s_ip_idx)
 				continue;
 			err = inet6_fill_ifacaddr(skb, ifaca, fillargs);
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index bb17f484ee2cde62632f95fc3b3370618b116049..0f2506e3535925468dcc5fa6cc30ae0952a67ea7 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -296,7 +296,8 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 		goto out;
 	}
 
-	for (aca = idev->ac_list; aca; aca = aca->aca_next) {
+	for (aca = rtnl_dereference(idev->ac_list); aca;
+	     aca = rtnl_dereference(aca->aca_next)) {
 		if (ipv6_addr_equal(&aca->aca_addr, addr)) {
 			aca->aca_users++;
 			err = 0;
@@ -317,13 +318,13 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
 		goto out;
 	}
 
-	aca->aca_next = idev->ac_list;
-	idev->ac_list = aca;
-
 	/* Hold this for addrconf_join_solict() below before we unlock,
 	 * it is already exposed via idev->ac_list.
 	 */
 	aca_get(aca);
+	aca->aca_next = idev->ac_list;
+	rcu_assign_pointer(idev->ac_list, aca);
+
 	write_unlock_bh(&idev->lock);
 
 	ipv6_add_acaddr_hash(net, aca);
@@ -350,7 +351,8 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 
 	write_lock_bh(&idev->lock);
 	prev_aca = NULL;
-	for (aca = idev->ac_list; aca; aca = aca->aca_next) {
+	for (aca = rtnl_dereference(idev->ac_list); aca;
+	     aca = rtnl_dereference(aca->aca_next)) {
 		if (ipv6_addr_equal(&aca->aca_addr, addr))
 			break;
 		prev_aca = aca;
@@ -364,9 +366,9 @@ int __ipv6_dev_ac_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 		return 0;
 	}
 	if (prev_aca)
-		prev_aca->aca_next = aca->aca_next;
+		rcu_assign_pointer(prev_aca->aca_next, aca->aca_next);
 	else
-		idev->ac_list = aca->aca_next;
+		rcu_assign_pointer(idev->ac_list, aca->aca_next);
 	write_unlock_bh(&idev->lock);
 	ipv6_del_acaddr_hash(aca);
 	addrconf_leave_solict(idev, &aca->aca_addr);
@@ -392,8 +394,8 @@ void ipv6_ac_destroy_dev(struct inet6_dev *idev)
 	struct ifacaddr6 *aca;
 
 	write_lock_bh(&idev->lock);
-	while ((aca = idev->ac_list) != NULL) {
-		idev->ac_list = aca->aca_next;
+	while ((aca = rtnl_dereference(idev->ac_list)) != NULL) {
+		rcu_assign_pointer(idev->ac_list, aca->aca_next);
 		write_unlock_bh(&idev->lock);
 
 		ipv6_del_acaddr_hash(aca);
@@ -420,11 +422,10 @@ static bool ipv6_chk_acast_dev(struct net_device *dev, const struct in6_addr *ad
 
 	idev = __in6_dev_get(dev);
 	if (idev) {
-		read_lock_bh(&idev->lock);
-		for (aca = idev->ac_list; aca; aca = aca->aca_next)
+		for (aca = rcu_dereference(idev->ac_list); aca;
+		     aca = rcu_dereference(aca->aca_next))
 			if (ipv6_addr_equal(&aca->aca_addr, addr))
 				break;
-		read_unlock_bh(&idev->lock);
 		return aca != NULL;
 	}
 	return false;
@@ -477,30 +478,25 @@ bool ipv6_chk_acast_addr_src(struct net *net, struct net_device *dev,
 struct ac6_iter_state {
 	struct seq_net_private p;
 	struct net_device *dev;
-	struct inet6_dev *idev;
 };
 
 #define ac6_seq_private(seq)	((struct ac6_iter_state *)(seq)->private)
 
 static inline struct ifacaddr6 *ac6_get_first(struct seq_file *seq)
 {
-	struct ifacaddr6 *im = NULL;
 	struct ac6_iter_state *state = ac6_seq_private(seq);
 	struct net *net = seq_file_net(seq);
+	struct ifacaddr6 *im = NULL;
 
-	state->idev = NULL;
 	for_each_netdev_rcu(net, state->dev) {
 		struct inet6_dev *idev;
+
 		idev = __in6_dev_get(state->dev);
 		if (!idev)
 			continue;
-		read_lock_bh(&idev->lock);
-		im = idev->ac_list;
-		if (im) {
-			state->idev = idev;
+		im = rcu_dereference(idev->ac_list);
+		if (im)
 			break;
-		}
-		read_unlock_bh(&idev->lock);
 	}
 	return im;
 }
@@ -508,22 +504,17 @@ static inline struct ifacaddr6 *ac6_get_first(struct seq_file *seq)
 static struct ifacaddr6 *ac6_get_next(struct seq_file *seq, struct ifacaddr6 *im)
 {
 	struct ac6_iter_state *state = ac6_seq_private(seq);
+	struct inet6_dev *idev;
 
-	im = im->aca_next;
+	im = rcu_dereference(im->aca_next);
 	while (!im) {
-		if (likely(state->idev != NULL))
-			read_unlock_bh(&state->idev->lock);
-
 		state->dev = next_net_device_rcu(state->dev);
-		if (!state->dev) {
-			state->idev = NULL;
+		if (!state->dev)
 			break;
-		}
-		state->idev = __in6_dev_get(state->dev);
-		if (!state->idev)
+		idev = __in6_dev_get(state->dev);
+		if (!idev)
 			continue;
-		read_lock_bh(&state->idev->lock);
-		im = state->idev->ac_list;
+		im = rcu_dereference(idev->ac_list);
 	}
 	return im;
 }
@@ -555,12 +546,6 @@ static void *ac6_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void ac6_seq_stop(struct seq_file *seq, void *v)
 	__releases(RCU)
 {
-	struct ac6_iter_state *state = ac6_seq_private(seq);
-
-	if (likely(state->idev != NULL)) {
-		read_unlock_bh(&state->idev->lock);
-		state->idev = NULL;
-	}
 	rcu_read_unlock();
 }
 
-- 
2.44.0.rc1.240.g4c46232300-goog


