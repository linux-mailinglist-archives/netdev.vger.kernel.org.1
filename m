Return-Path: <netdev+bounces-206049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653D6B0128E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3055A3A3F0F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 05:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F261B2186;
	Fri, 11 Jul 2025 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiElwQWn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10551111BF
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 05:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752210690; cv=none; b=tjT62a/izuMXfZeAz0i4059nu2rQ2Q2ljAYPMYQM6aILAvGT6nJZJb6o1HtkvEYpbW+8/WMflgowxKt1k+FFGaLBRzKTOnKudI8bIMjVLs4yWqbHk23hJegURw3DG6jwAODVFHZRvf5FLYD+g/3tK6SYYxAtlvZgYPhVDJhBWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752210690; c=relaxed/simple;
	bh=ZbukREG3/72qZKSJBbu5wDAj2Bn9O7UySP3aKyRq5TA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M8PCrmz0Pj9zB1HMZzFkCTeZOWAXbsykG+opuoEzQQwsBAXH30JgK4yJB03eRRIRVbPpHz1X0SZWwueezug/EekJJuQbHrmKZ09CtbXDHKsn6F7yOH4ADfGqnbbLm1CcvYAY3u/i0RHYym+oYn7IRPX46T/Qr+etPKSmTKVEd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiElwQWn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso2040738a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752210688; x=1752815488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lTGZrkd0aqEovccl2PzH/wQxGVk9sAtkVD8IQNPwIGI=;
        b=WiElwQWn4e2iaKJeKaaJtZaIoqoi0kTSnRKm2qd4rsLbFkF81vUI82EDiCCTAEdUEf
         AXLu0smMkriF/sMfj35BSkacoTYxb+xL85JfqdU9S2m0dDRxoXBvwqUFr4Y7KFhcAsv4
         e+YjkENcwohCIdo1WVtR53FSEEQU0V0juywqzh4ublLAgVCjqFJwCpDoHvtnw1k9/Z4s
         a6NAWcWyb/1iXAPW2t0SdwpOMQk0qz4P1YgXoWqLSF4aINEoTgrhCIQ89hAttMmjfitS
         SzCEUCs4q0iaNc8o6oLBCWgt/eteeFdWICjgodAM6Pae4oHgMZAXXb/UwncowMkDXfZN
         t69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752210688; x=1752815488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lTGZrkd0aqEovccl2PzH/wQxGVk9sAtkVD8IQNPwIGI=;
        b=GCoh92m0z2roWikBj4hOZCowLGTfWwokSqGAgUqDVkpM3Cut2SZmttcwJnQ2oge/Zv
         05OThR5i9wqkzsj4LCIRRj316Wtw6SE35FXwlFaH2+M3t06sah1VsC1jqpZlL7TK1Y2Q
         pa5I9OiAPbK2skQw/IFHhF3Vsg0u3jykt9Kqrs+vlwBourykHMDmIEzgOcv//VEUwlzk
         QSUthskzl9icGHGLXNcMeKgOJa8tNZtslD5MWRFKeu9ymWywEaaGLtxml4WsZXzmbtf0
         mv0mxwKfv+j07xw1THZWi/wrKZYzPPGHunqi7WlCiERdxFKFCYnB17jVXKhstfdau+XZ
         T+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUHxov3pscXFK6hvT/12JIctoD1EON06XOJ1ohJySL85FsQh0IIVXl5awfWXpgF+cs6Z/TyBS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMydRa7p/t3NnCW4MmhFJSInzoJYThVZX2MOBbQ+SNrzkRwTSt
	nALbi4HbSAuigLf3omJBMc3a999XDzm3LwdD9I4kaCwE6TpAXiR78HfiK6GaQubAo94jJOSRmE+
	fBLUu7g==
X-Google-Smtp-Source: AGHT+IHcH009zGUeO23m8twqonzWtg6CvEM7fC02PdGVu/o4aX3S5ncHM9LDZK8P4BBTx+BPeeRiKXrW2a4=
X-Received: from pfnn7.prod.google.com ([2002:a05:6a00:2b87:b0:749:30b5:c67e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d50a:b0:220:1af3:d98f
 with SMTP id adf61e73a8af0-23137e8e31emr2514368637.26.1752210688447; Thu, 10
 Jul 2025 22:11:28 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:10:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711051120.2866855-1-kuniyu@google.com>
Subject: [PATCH v2 net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a follow-up for commit eb1ac9ff6c4a5 ("ipv6: anycast: Don't
hold RTNL for IPV6_JOIN_ANYCAST.").

We should not add a new device lookup API without netdevice_tracker.

Let's pass netdevice_tracker to dev_get_by_flags_rcu() and rename it
with netdev_ prefix to match other newer APIs.

Note that we always use GFP_ATOMIC for netdev_hold() as it's expected
to be called under RCU.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20250708184053.102109f6@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Use netdev_tracker for other places ipv6_sock_ac_join()
  * Fix func name for EXPORT_IPV6_MOD()
  * Update kdoc

v1: https://lore.kernel.org/netdev/20250709190144.659194-1-kuniyu@google.com/
---
 include/linux/netdevice.h |  4 ++--
 net/core/dev.c            | 11 ++++++-----
 net/ipv6/anycast.c        | 11 ++++++-----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a80d21a146123..ec23cee5245d7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3332,8 +3332,6 @@ int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
-struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short flags,
-					unsigned short mask);
 struct net_device *dev_get_by_name(struct net *net, const char *name);
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name);
 struct net_device *__dev_get_by_name(struct net *net, const char *name);
@@ -3396,6 +3394,8 @@ struct net_device *netdev_get_by_index(struct net *net, int ifindex,
 				       netdevice_tracker *tracker, gfp_t gfp);
 struct net_device *netdev_get_by_name(struct net *net, const char *name,
 				      netdevice_tracker *tracker, gfp_t gfp);
+struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
+					   unsigned short flags, unsigned short mask);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
 void netdev_copy_name(struct net_device *dev, char *name);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e365b099484ec..19ddc3e6990a7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1267,8 +1267,9 @@ struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 EXPORT_SYMBOL(dev_getfirstbyhwtype);
 
 /**
- * dev_get_by_flags_rcu - find any device with given flags
+ * netdev_get_by_flags_rcu - find any device with given flags
  * @net: the applicable net namespace
+ * @tracker: tracking object for the acquired reference
  * @if_flags: IFF_* values
  * @mask: bitmask of bits in if_flags to check
  *
@@ -1277,21 +1278,21 @@ EXPORT_SYMBOL(dev_getfirstbyhwtype);
  * Context: rcu_read_lock() must be held.
  * Returns: NULL if a device is not found or a pointer to the device.
  */
-struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short if_flags,
-					unsigned short mask)
+struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
+					   unsigned short if_flags, unsigned short mask)
 {
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev) {
 		if (((READ_ONCE(dev->flags) ^ if_flags) & mask) == 0) {
-			dev_hold(dev);
+			netdev_hold(dev, tracker, GFP_ATOMIC);
 			return dev;
 		}
 	}
 
 	return NULL;
 }
-EXPORT_IPV6_MOD(dev_get_by_flags_rcu);
+EXPORT_IPV6_MOD(netdev_get_by_flags_rcu);
 
 /**
  *	dev_valid_name - check if name is okay for network device
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 53cf68e0242bf..f8a8e46286b8e 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -69,6 +69,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_ac_socklist *pac = NULL;
 	struct net *net = sock_net(sk);
+	netdevice_tracker dev_tracker;
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev;
 	int err = 0, ishost;
@@ -79,7 +80,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		return -EINVAL;
 
 	if (ifindex)
-		dev = dev_get_by_index(net, ifindex);
+		dev = netdev_get_by_index(net, ifindex, &dev_tracker, GFP_KERNEL);
 
 	if (ipv6_chk_addr_and_flags(net, addr, dev, true, 0, IFA_F_TENTATIVE)) {
 		err = -EINVAL;
@@ -104,7 +105,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
 		if (rt) {
 			dev = dst_dev(&rt->dst);
-			dev_hold(dev);
+			netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
 			ip6_rt_put(rt);
 		} else if (ishost) {
 			rcu_read_unlock();
@@ -112,8 +113,8 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 			goto error;
 		} else {
 			/* router, no matching interface: just pick one */
-			dev = dev_get_by_flags_rcu(net, IFF_UP,
-						   IFF_UP | IFF_LOOPBACK);
+			dev = netdev_get_by_flags_rcu(net, &dev_tracker, IFF_UP,
+						      IFF_UP | IFF_LOOPBACK);
 		}
 		rcu_read_unlock();
 	}
@@ -159,7 +160,7 @@ int ipv6_sock_ac_join(struct sock *sk, int ifindex, const struct in6_addr *addr)
 error_idev:
 	in6_dev_put(idev);
 error:
-	dev_put(dev);
+	netdev_put(dev, &dev_tracker);
 
 	if (pac)
 		sock_kfree_s(sk, pac, sizeof(*pac));
-- 
2.50.0.727.gbf7dc18ff4-goog


