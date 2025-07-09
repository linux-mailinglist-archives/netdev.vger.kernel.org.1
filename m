Return-Path: <netdev+bounces-205528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D3AFF148
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A751C83A40
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B103222577;
	Wed,  9 Jul 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOM6duQy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160323B62B
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087709; cv=none; b=dgAz3J35sKefMeNPhWbtXeE6PnbmJjpFNYfV1gFZ4eNCBBx+mGb21gY4OkopmftV0BxJETt3RTLrFsr994zz4eAQiTmu8nZX9zKu+E5VRPVI/BYAM6hejrOUlVx8yUDsTsJPflnjuQPdAx1FOG6PEVjOlCEvBYh4T4Xs4ca7tkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087709; c=relaxed/simple;
	bh=4SDQqQVxcxlz98kvoSgBgI9FiVboo1CzKkWI1mtqqcI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=au2jBB7Ltap9KKogDPEo47OSW4/kQAQ+EuvaIM4Tfo+/lTM4DmDpvZY0IhkeFQn32c67sgwVAehoixwu+OObR/dKQVquRZ+Y0oYFQU9RDwj/vN8//zFIqD7P+wgpWcv8NFdnjPx+1F0ROnLwMSIOcsoXOhHw265XefQejE1vZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOM6duQy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af0857f2so257202a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752087707; x=1752692507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DH06xcjaoyKJpgDHs3r8UB2aiXaTE3tzu4k28eppqh0=;
        b=zOM6duQyOb7/ZAu8kbHbIOf6Nvq24JdF5C1082tZX0CjnlSWdOR/PjiwoOLfDxuptK
         oNpBBFtk/5GpJcAPTYufaVY/u2ShgGt0HWxqFOaE9p0qE1tRdhDcM8lSONYb4CplmeQn
         K9cPE7GsS+f3ocUI4PyZJmt1VzHqmZKemSYHShFz8Vd9r8B2ILt+fz7mhmZ+8vSt2Wui
         pbvYLW4xpMLldTc/IlAjBWS9i9ZvFJnXRv16plMxWfiUsvUDCOoggmODVcID3usYGOQ2
         Rc8PHFkOiHr5p06We1vJA57BcVaaJwxzaUMHdYIrMe8l0oc4ysAR0AUNFzFeMVS7rzmp
         x/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087707; x=1752692507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DH06xcjaoyKJpgDHs3r8UB2aiXaTE3tzu4k28eppqh0=;
        b=oteV3fyybuGLhnX1Sv7zTPb0ttYSfGuET+oNtll2cpjJ44vZQYFYrrv9lQLtd3WTFL
         KfAp9CRtjrrUMA5YiG12NTTZyR32FYbZuBu3UWSFjA9Wys0Zx+p8Bu2swC4vJyfzowdS
         UnCG861ns6I4E65wobFSVmBYNm3UohPtH/j+5uDjXwOcpZRFs0KBRT90cTRkvnWSrmWg
         7Wo8A7FFU3fygcurlDdIOgIs25vqEu2nJQ8H1blzwwvTEi+glReEyQoHPtC2HNfOBgqJ
         HOgBr4ZdpVBTzfSTVWhTekgX6aHvPcTsXh7vS2LlVSTqkpYZGXtMBk6vAsG6ElzGzz/4
         4Q3A==
X-Forwarded-Encrypted: i=1; AJvYcCWHDfQqOMhBt0SYRpPHq/Ysj1Klr7dhZbdHj+UqEvWyl5XORlrk8cA5IdSaz2s/2gDVAAjSftI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXM25BBoSoKMggotJDzCA6hbueZcrKH0sgQyMyqBZPmmyAGVg
	NZJq3lA9QZmxaNxde1GBehZqE8CEtv4biEdLH9zPtExY9SnZI+EVNZGb6D8uNuKdefmAR7Oq5UD
	oHKd3kQ==
X-Google-Smtp-Source: AGHT+IF36+RhGZwFyhoVbipmiG/0gnBhCdeylF/SsozHX/t/emEsLkCxo9mPEvZq5CayN4Qt1pF7xXU7Wmo=
X-Received: from pjff11.prod.google.com ([2002:a17:90b:562b:b0:312:4b0b:a94])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f8a:b0:312:1c83:58fb
 with SMTP id 98e67ed59e1d1-31c2fd26fbamr4980819a91.1.1752087707008; Wed, 09
 Jul 2025 12:01:47 -0700 (PDT)
Date: Wed,  9 Jul 2025 19:01:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709190144.659194-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
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
 include/linux/netdevice.h | 4 ++--
 net/core/dev.c            | 8 ++++----
 net/ipv6/anycast.c        | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

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
index e365b099484ec..48fa8b9836016 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1267,7 +1267,7 @@ struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 EXPORT_SYMBOL(dev_getfirstbyhwtype);
 
 /**
- * dev_get_by_flags_rcu - find any device with given flags
+ * netdev_get_by_flags_rcu - find any device with given flags
  * @net: the applicable net namespace
  * @if_flags: IFF_* values
  * @mask: bitmask of bits in if_flags to check
@@ -1277,14 +1277,14 @@ EXPORT_SYMBOL(dev_getfirstbyhwtype);
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
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 53cf68e0242bf..fa7f0c22167b4 100644
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


