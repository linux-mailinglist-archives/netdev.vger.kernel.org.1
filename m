Return-Path: <netdev+bounces-171631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3FA4DE92
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911073A7F72
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E539202C5D;
	Tue,  4 Mar 2025 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2f/dQOQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0378F33
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093167; cv=none; b=iXQJ1/BgKByOnfPE3cl1XZ9pllcZD5UStDVFqu3w9IVU6YJ6KYkYD1IBdIF7L/O9kroDkLsCFbC72lARann4kd93Jj2EE7nO36Preuho0AobMnC6iUUAKmWAvxFF4383C6qw/iMjKJ17J0aYmDSuIc+H9odQVoqbMVJYJr0llfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093167; c=relaxed/simple;
	bh=lPRKPzvTcps9JV09E7gq6HkwNHtLyclXGmmloVpycYI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uAdc+bQXqIuDIivyhL+ALxVZQ+KpkkbnCQMIHOQv9/lMO76iusAFzpKPcs6W4fDDhuykcLHWzOWag7Y/Udc7OGRQ1HExQBQbl62fZXQwh+Vi8gC924IIn2W+bNRCGGqvH6YclD37J4tUARPaG0I8N6YVtWT0H0gsgnzE+IYvkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2f/dQOQ3; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0922c5cfdso1060181785a.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741093164; x=1741697964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O5r+kY8uUQea4h260mSXV7pnzmcmmQTW924JwHkA6cI=;
        b=2f/dQOQ3qUcOqR1CAb2zKaLi3VoWND8Il8DjNIosZDCYi6dmESYMhnCiPQTY2bVVZH
         aqmjhd7HO7zqXhcTjagO4QW2yXE1eTzhqw5StK9YC6p2aQOnRwzCj/PRM7v/Ax37uMcu
         mQ/FoAFZEyJtldt1iex+7IgakeBSZ6wGDeolswiE5Ld8H5Y4qwaPswBuM54UXFJS1zun
         DSggA9bOxSxhiteEqCImmmtuEbNnmBsB0hdwYIs4YCMTr7nqIMuJAp3fQ3hBSRKSwYOg
         qd6JTJ6qOQzqSlyw/OU0riqJp7fU6RbdCXcbWKX80Wxm7HvLOu3dO0J/mOmoLfRv1Rn2
         mAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093164; x=1741697964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5r+kY8uUQea4h260mSXV7pnzmcmmQTW924JwHkA6cI=;
        b=hRjFZEv7ydxvsLYqoV0ImVzq8xOoVNBQWE8DPuPMxDfDXa8TNoySkOFHaWniKqOnI+
         ijF3vdUV3e96+zVQPsO4vpl1Dng3rrXDvOc2bu8hRj6hOIztptbBROcX8mQbND4q9lap
         E2UYDb4ARA1CzMJ2eNtreLUDILnUoz/LLL43bMwF6kPm3RcpNplrnm/4ggzarCSWMwbo
         sCVlzzHuLv6JAOcn3mmLXskkOhaO5TZgt7n5cSuLUIA23TL+PFFLJBVl95LzTW2OY4h0
         RTnno7ycUfPo6K0kQNtp85EYIWerSu1FHEx4dgxBaiRyEoYLGyz9Tk1pugfp5aEZOzMf
         thZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqlB8+IsMpH+XD/T1r2zWfvOYOMek2FG52xP/wDSi5pE5jUldkRF7/t0EBxqWOMe38pxSR1/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSs+mONLuUXPGwTLkpGDspm0ZzCAeXmp3CrsjzmzV7aS2DAqS
	iOjAX5wJCJmEliTS/vjxAVFcTfe0o7AeeTJU9r5oQ9+i7H8jf3fBwwq4C4NS8Pvnj/5oOLBDXwI
	gBLoTEsVKdw==
X-Google-Smtp-Source: AGHT+IFfnydFMNCps8JnmdN5jusF091lD9RcD2vvQC5GdrK43vNh9OSGxIHWfhXVw8rkPI5XChN0QN1n1+G5Yg==
X-Received: from qknrv10.prod.google.com ([2002:a05:620a:688a:b0:7c3:d67f:c321])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4113:b0:7c0:c650:e243 with SMTP id af79cd13be357-7c39c4cc9b3mr2646106185a.30.1741093164455;
 Tue, 04 Mar 2025 04:59:24 -0800 (PST)
Date: Tue,  4 Mar 2025 12:59:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304125918.2763514-1-edumazet@google.com>
Subject: [PATCH net-next] inet: fix lwtunnel_valid_encap_type() lock imbalance
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

After blamed commit rtm_to_fib_config() now calls
lwtunnel_valid_encap_type{_attr}() without RTNL held,
triggering an unlock balance in __rtnl_unlock,
as reported by syzbot [1]

IPv6 and rtm_to_nh_config() are not yet converted.

Add a temporary @rtnl_is_held parameter to lwtunnel_valid_encap_type()
and lwtunnel_valid_encap_type_attr().

While we are at it replace the two rcu_dereference()
in lwtunnel_valid_encap_type() with more appropriate
rcu_access_pointer().

[1]
syz-executor245/5836 is trying to release lock (rtnl_mutex) at:
 [<ffffffff89d0e38c>] __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor245/5836.

stack backtrace:
CPU: 0 UID: 0 PID: 5836 Comm: syz-executor245 Not tainted 6.14.0-rc4-syzkaller-00873-g3424291dd242 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_unlock_imbalance_bug+0x25b/0x2d0 kernel/locking/lockdep.c:5289
  __lock_release kernel/locking/lockdep.c:5518 [inline]
  lock_release+0x47e/0xa30 kernel/locking/lockdep.c:5872
  __mutex_unlock_slowpath+0xec/0x800 kernel/locking/mutex.c:891
  __rtnl_unlock+0x6c/0xf0 net/core/rtnetlink.c:142
  lwtunnel_valid_encap_type+0x38a/0x5f0 net/core/lwtunnel.c:169
  lwtunnel_valid_encap_type_attr+0x113/0x270 net/core/lwtunnel.c:209
  rtm_to_fib_config+0x949/0x14e0 net/ipv4/fib_frontend.c:808
  inet_rtm_newroute+0xf6/0x2a0 net/ipv4/fib_frontend.c:917
  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
  netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:709 [inline]

Fixes: 1dd2af7963e9 ("ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.")
Reported-by: syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67c6f87a.050a0220.38b91b.0147.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/lwtunnel.h  | 12 ++++++++----
 net/core/lwtunnel.c     | 23 ++++++++++++-----------
 net/ipv4/fib_frontend.c |  4 ++--
 net/ipv4/nexthop.c      |  3 ++-
 net/ipv6/route.c        |  6 ++++--
 5 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 53bd2d02a4f0db374b3920386afd12b0d7cbe6a0..39cd50300a1897883b9e4a6cfe95da257a5d007b 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -116,9 +116,11 @@ int lwtunnel_encap_add_ops(const struct lwtunnel_encap_ops *op,
 int lwtunnel_encap_del_ops(const struct lwtunnel_encap_ops *op,
 			   unsigned int num);
 int lwtunnel_valid_encap_type(u16 encap_type,
-			      struct netlink_ext_ack *extack);
+			      struct netlink_ext_ack *extack,
+			      bool rtnl_is_held);
 int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int len,
-				   struct netlink_ext_ack *extack);
+				   struct netlink_ext_ack *extack,
+				   bool rtnl_is_held);
 int lwtunnel_build_state(struct net *net, u16 encap_type,
 			 struct nlattr *encap,
 			 unsigned int family, const void *cfg,
@@ -201,13 +203,15 @@ static inline int lwtunnel_encap_del_ops(const struct lwtunnel_encap_ops *op,
 }
 
 static inline int lwtunnel_valid_encap_type(u16 encap_type,
-					    struct netlink_ext_ack *extack)
+					    struct netlink_ext_ack *extack,
+					    bool rtnl_is_held)
 {
 	NL_SET_ERR_MSG(extack, "CONFIG_LWTUNNEL is not enabled in this kernel");
 	return -EOPNOTSUPP;
 }
 static inline int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int len,
-						 struct netlink_ext_ack *extack)
+						 struct netlink_ext_ack *extack,
+						 bool rtnl_is_held)
 {
 	/* return 0 since we are not walking attr looking for
 	 * RTA_ENCAP_TYPE attribute on nexthops.
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a7948ae3958257de1518685c7fbff..6d3833269c2b47584b8f0daab2e45b2b4953f3ca 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -147,7 +147,8 @@ int lwtunnel_build_state(struct net *net, u16 encap_type,
 }
 EXPORT_SYMBOL_GPL(lwtunnel_build_state);
 
-int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack)
+int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack,
+			      bool rtnl_is_held)
 {
 	const struct lwtunnel_encap_ops *ops;
 	int ret = -EINVAL;
@@ -158,21 +159,19 @@ int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack)
 		return ret;
 	}
 
-	rcu_read_lock();
-	ops = rcu_dereference(lwtun_encaps[encap_type]);
-	rcu_read_unlock();
+	ops = rcu_access_pointer(lwtun_encaps[encap_type]);
 #ifdef CONFIG_MODULES
 	if (!ops) {
 		const char *encap_type_str = lwtunnel_encap_str(encap_type);
 
 		if (encap_type_str) {
-			__rtnl_unlock();
+			if (rtnl_is_held)
+				__rtnl_unlock();
 			request_module("rtnl-lwt-%s", encap_type_str);
-			rtnl_lock();
+			if (rtnl_is_held)
+				rtnl_lock();
 
-			rcu_read_lock();
-			ops = rcu_dereference(lwtun_encaps[encap_type]);
-			rcu_read_unlock();
+			ops = rcu_access_pointer(lwtun_encaps[encap_type]);
 		}
 	}
 #endif
@@ -185,7 +184,8 @@ int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack)
 EXPORT_SYMBOL_GPL(lwtunnel_valid_encap_type);
 
 int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int remaining,
-				   struct netlink_ext_ack *extack)
+				   struct netlink_ext_ack *extack,
+				   bool rtnl_is_held)
 {
 	struct rtnexthop *rtnh = (struct rtnexthop *)attr;
 	struct nlattr *nla_entype;
@@ -207,7 +207,8 @@ int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int remaining,
 				encap_type = nla_get_u16(nla_entype);
 
 				if (lwtunnel_valid_encap_type(encap_type,
-							      extack) != 0)
+							      extack,
+							      rtnl_is_held) != 0)
 					return -EOPNOTSUPP;
 			}
 		}
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 6de77415b5b3003895bdee9e7fc36d3553c7c01a..3f4e629998fab4e2ae241c7efe40d9d162f8f517 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -807,7 +807,7 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		case RTA_MULTIPATH:
 			err = lwtunnel_valid_encap_type_attr(nla_data(attr),
 							     nla_len(attr),
-							     extack);
+							     extack, false);
 			if (err < 0)
 				goto errout;
 			cfg->fc_mp = nla_data(attr);
@@ -825,7 +825,7 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		case RTA_ENCAP_TYPE:
 			cfg->fc_encap_type = nla_get_u16(attr);
 			err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-							extack);
+							extack, false);
 			if (err < 0)
 				goto errout;
 			break;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 09a3d73b45baa1e18f656bb4354bf2c9f707fe13..01df7dd795f01fe560c9f7d3bda2d9517b8368c9 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3187,7 +3187,8 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 		}
 
 		cfg->nh_encap_type = nla_get_u16(tb[NHA_ENCAP_TYPE]);
-		err = lwtunnel_valid_encap_type(cfg->nh_encap_type, extack);
+		err = lwtunnel_valid_encap_type(cfg->nh_encap_type,
+						extack, true);
 		if (err < 0)
 			goto out;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ef2d23a1e3d532f5db37ca94ca482c5522dddffc..fb2e99a5652911a26bdb4b2bd0b867a688afdc82 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5128,7 +5128,8 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_mp_len = nla_len(tb[RTA_MULTIPATH]);
 
 		err = lwtunnel_valid_encap_type_attr(cfg->fc_mp,
-						     cfg->fc_mp_len, extack);
+						     cfg->fc_mp_len,
+						     extack, true);
 		if (err < 0)
 			goto errout;
 	}
@@ -5147,7 +5148,8 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[RTA_ENCAP_TYPE]) {
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
-		err = lwtunnel_valid_encap_type(cfg->fc_encap_type, extack);
+		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
+						extack, true);
 		if (err < 0)
 			goto errout;
 	}
-- 
2.48.1.711.g2feabab25a-goog


