Return-Path: <netdev+bounces-132070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA609904C7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705A51F227BD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316FA2101BC;
	Fri,  4 Oct 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+VgZ2AN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E62139B0
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049651; cv=none; b=cmGqGg+x5B0j0i6Yv8YrPikFjhqLduKXmZ7cqtzT9Y7sX8oXb2DySyWi5Hxev3BlRPp5TMxOna7/CuD0VwK+yJyUz4N5ad4R3qAYprDCLwFPJcLvwUnGK/D1/S7ESPJf9EPHCGUw+vimiU2m8i8zsJUlqldqxRiClDxk3+0dPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049651; c=relaxed/simple;
	bh=FTzNJNOMI0maseYOV5BKV36sxfk5x1kC1qb63hOFfew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p8bEn6uQaCMzfBBJbhomj0h/NwimonIqYVd4SwEIJaQju4SiBW2ZeDVQvwAIckiMFZoiOKhc9AC9pSVIPxeL4ZLn4Lh+zs05OrF9uQueJ/W05aw444ySXUrPKRL3YziapN4B+EreNRxB6e1y+sPxN5D9gRMELogxg1mtoJXX9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+VgZ2AN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2605ce4276so3636890276.3
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728049648; x=1728654448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA/hAHSrZwcpgvbZKlPEB+5PNe5KsZLBA1YCK5/7P1M=;
        b=s+VgZ2ANf2eK9aom9grXoMBeaMN0ghWzxQglpRFHqg7YgFCUSs2rSL8mShwC5RCO9W
         SDJNfh4/rZk7EZYypR8ONb2yOz521i6mtl/mb2gebxaKmMPbKGYxHB0fDNn77jVUilQ+
         yRoSW/uiOOv+sWirhFLNl+u8w5euje5Sb1M1KmvyOcMQM98rKhs2kqYk2+lYpO/Nh567
         cPpC1CPEPFS9Pe71lvZGfPbvZF/L2GBc+rUMvK+KNvfwsL6pRDIG14W38FjFxGzasLSw
         BF8mqGpO0p8bJzM07QNL2QhmbzHDJqzJGDXkxEAetNUvgDKN7ynjaZqkIs1ZMaLW99EE
         JuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049648; x=1728654448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA/hAHSrZwcpgvbZKlPEB+5PNe5KsZLBA1YCK5/7P1M=;
        b=m9YJzFxzzD61e5c1Sbw4wr/9mZddAnEzwy5vxLmvpdwgPzF5Gx07C6UtdHAXR1Bc/I
         7tLJpbtd/5Oix/bfE/Ss8iVbXppdcwgHv8oAkJbsUyozltnUHzI9ApF0F29ieedTbW3j
         joJZ3tygiGiM2ut000ATJFePyTMr10lQLJ9+LREJb9YSJQz1QgUubokRN2ibg7h/rIeb
         MF/ibEhgax0i9/gE+/IVHUAaTAviXVQIP5AEnVkK9V+gDOfMpG8wJGbVhtn74Sm8NTdb
         ItAOdptpIbriyAJ4MdCwJ7Njehh/6aKVMYkx/8AzjNWmQmCXebQqiRlfPJWAzlMouq47
         eBVg==
X-Forwarded-Encrypted: i=1; AJvYcCVCgPvLsCninLTqSHOpG0HL46atx0Kh0IoP/Q84lv4LomfxN9PCfz3L0ZutKFp3aolQLvFPSzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OWh3r77cc+JZ2VZMIr/yYHMxK0/9MxfwBwJWhbEJzVQQRBz4
	+1xIoKoFRqiQK4HJIJ96891zqaSuX1XfooQOTwtm5TviwnJFvikKNR4XbRV10G/OFWW8tJ27Jrb
	BIDkp9mBDmg==
X-Google-Smtp-Source: AGHT+IEVnbC477oBfefyG9in4R227iIWNg6crArrYdA5kArbITMF48+AbLXrPc268uCT8ozrYM6oiBvkecnzdw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:49:0:b0:e0e:c9bc:3206 with SMTP id
 3f1490d57ef6-e28936e2e94mr1949276.5.1728049648419; Fri, 04 Oct 2024 06:47:28
 -0700 (PDT)
Date: Fri,  4 Oct 2024 13:47:20 +0000
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004134720.579244-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004134720.579244-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] ipv4: remove fib_info_devhash[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Upcoming per-netns RTNL conversion needs to get rid
of shared hash tables.

fib_info_devhash[] is one of them.

It is unclear why we used a hash table, because
a single hlist_head per net device was cheaper and scalable.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  2 ++
 net/ipv4/fib_semantics.c                      | 35 ++++++++-----------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 22b07c814f4a4575d255fdf472d07c549536e543..a8e2a7ce0383343464800be8db31aeddd791f086 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -83,6 +83,7 @@ unsigned_int                        allmulti
 bool                                uc_promisc                                                      
 unsigned_char                       nested_level                                                    
 struct_in_device*                   ip_ptr                  read_mostly         read_mostly         __in_dev_get
+struct hlist_head                   fib_nh_head
 struct_inet6_dev*                   ip6_ptr                 read_mostly         read_mostly         __in6_dev_get
 struct_vlan_info*                   vlan_info                                                       
 struct_dsa_port*                    dsa_ptr                                                         
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4d20c776a4ff3d0e881b8d9b99901edb35f66da2..cda20a3fe1adf54c1e6df5b5a8882ef7830e1b46 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2209,6 +2209,8 @@ struct net_device {
 
 	/* Protocol-specific pointers */
 	struct in_device __rcu	*ip_ptr;
+	struct hlist_head	fib_nh_head;
+
 #if IS_ENABLED(CONFIG_VLAN_8021Q)
 	struct vlan_info __rcu	*vlan_info;
 #endif
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ece779bfb8f6bec67eb7751761df9a4f158020a8..d2cee5c314f5e76530ac564f49b433822bb0a272 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -56,10 +56,6 @@ static unsigned int fib_info_hash_size;
 static unsigned int fib_info_hash_bits;
 static unsigned int fib_info_cnt;
 
-#define DEVINDEX_HASHBITS 8
-#define DEVINDEX_HASHSIZE (1U << DEVINDEX_HASHBITS)
-static struct hlist_head fib_info_devhash[DEVINDEX_HASHSIZE];
-
 /* for_nexthops and change_nexthops only used when nexthop object
  * is not set in a fib_info. The logic within can reference fib_nh.
  */
@@ -319,12 +315,9 @@ static inline int nh_comp(struct fib_info *fi, struct fib_info *ofi)
 	return 0;
 }
 
-static struct hlist_head *
-fib_info_devhash_bucket(const struct net_device *dev)
+static struct hlist_head *fib_nh_head(struct net_device *dev)
 {
-	u32 val = net_hash_mix(dev_net(dev)) ^ dev->ifindex;
-
-	return &fib_info_devhash[hash_32(val, DEVINDEX_HASHBITS)];
+	return &dev->fib_nh_head;
 }
 
 static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
@@ -435,11 +428,11 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	struct hlist_head *head;
 	struct fib_nh *nh;
 
-	head = fib_info_devhash_bucket(dev);
+	head = fib_nh_head(dev);
 
 	hlist_for_each_entry_rcu(nh, head, nh_hash) {
-		if (nh->fib_nh_dev == dev &&
-		    nh->fib_nh_gw4 == gw &&
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (nh->fib_nh_gw4 == gw &&
 		    !(nh->fib_nh_flags & RTNH_F_DEAD)) {
 			return 0;
 		}
@@ -1595,7 +1588,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 			if (!nexthop_nh->fib_nh_dev)
 				continue;
-			head = fib_info_devhash_bucket(nexthop_nh->fib_nh_dev);
+			head = fib_nh_head(nexthop_nh->fib_nh_dev);
 			hlist_add_head_rcu(&nexthop_nh->nh_hash, head);
 		} endfor_nexthops(fi)
 	}
@@ -1948,12 +1941,12 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
 
 void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
 {
-	struct hlist_head *head = fib_info_devhash_bucket(dev);
+	struct hlist_head *head = fib_nh_head(dev);
 	struct fib_nh *nh;
 
 	hlist_for_each_entry(nh, head, nh_hash) {
-		if (nh->fib_nh_dev == dev)
-			fib_nhc_update_mtu(&nh->nh_common, dev->mtu, orig_mtu);
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		fib_nhc_update_mtu(&nh->nh_common, dev->mtu, orig_mtu);
 	}
 }
 
@@ -1967,7 +1960,7 @@ void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
  */
 int fib_sync_down_dev(struct net_device *dev, unsigned long event, bool force)
 {
-	struct hlist_head *head = fib_info_devhash_bucket(dev);
+	struct hlist_head *head = fib_nh_head(dev);
 	struct fib_info *prev_fi = NULL;
 	int scope = RT_SCOPE_NOWHERE;
 	struct fib_nh *nh;
@@ -1981,7 +1974,8 @@ int fib_sync_down_dev(struct net_device *dev, unsigned long event, bool force)
 		int dead;
 
 		BUG_ON(!fi->fib_nhs);
-		if (nh->fib_nh_dev != dev || fi == prev_fi)
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (fi == prev_fi)
 			continue;
 		prev_fi = fi;
 		dead = 0;
@@ -2131,7 +2125,7 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 	}
 
 	prev_fi = NULL;
-	head = fib_info_devhash_bucket(dev);
+	head = fib_nh_head(dev);
 	ret = 0;
 
 	hlist_for_each_entry(nh, head, nh_hash) {
@@ -2139,7 +2133,8 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 		int alive;
 
 		BUG_ON(!fi->fib_nhs);
-		if (nh->fib_nh_dev != dev || fi == prev_fi)
+		DEBUG_NET_WARN_ON_ONCE(nh->fib_nh_dev != dev);
+		if (fi == prev_fi)
 			continue;
 
 		prev_fi = fi;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


