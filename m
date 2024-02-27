Return-Path: <netdev+bounces-75485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7F86A25B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3808E1C209C0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A95B15098D;
	Tue, 27 Feb 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmUZl8Ei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA214F961
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072587; cv=none; b=g3vyHZW/a+nEq3SWlF6YE6KYoHFuONOgen5CUjq3DMQhhBmp+rilvN/bGNZLq+9wCvnXnp4sV15MSR63HS1BJDv6Bywi7+0uAN1+XRASljzNTVg7cgI5z2I4VxORTsnS/HJPpcFCzCZ4rK2snO/3OCQ5Hdudqje1pVgxz0S+21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072587; c=relaxed/simple;
	bh=j2c4FvkWJJaRyddV95YKNUmX2dWDJ09T+2odyZTLbiA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V51lPIPDA9xGnO5TxpRgAuggm/6JhR8mrD7Xs4XWz5q0LOYuFYs784rDKVHt8KY00QXgG47/hykHaxBCWSz8t1WHty/HHDq15LF1HG2cyxgC3TYb8D4uuqS1flyLjQTtvLHfIN0U3FT1jDYzdICy6+D34JCpnqW4RNeESaETwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmUZl8Ei; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso413275276.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709072584; x=1709677384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+ZGCjtt8wppm3sIyy+5ny7AH7SbHjScdv6jTKDpF/0=;
        b=kmUZl8Eiz95M8DvYiNIj6GQUhRqFJRjyKBOq8vK+DXXiOAofyuTMjaMEYRX9S/ORXN
         8mpr3arZ8nyy9qVUpJsTj06inIu0BemMZMo0rrg8BqmWAyg63rjO/H/FjFvqKjwM36BO
         C2ATK+ZBINvaxYAP/t32hrewMiXLHktbSbGfnDceozF728hf7PXh2o/1JYz6PaQeNpyM
         uXFA6SIc7DVnLKhcVrpmagT62Yg9PvW6ILpABGu0Ww5BZJlQyujUZKmTfm1l6CyN5HiO
         VGSoeZUoYMwx57EphYVoIIdfG7X+CcMQySQHct89IXNQQ1OONnjXPw/rJSFO+vkINEuq
         xApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072584; x=1709677384;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+ZGCjtt8wppm3sIyy+5ny7AH7SbHjScdv6jTKDpF/0=;
        b=LOR/3RMyiRcOdYKxktCM5Vzjx0Iu0m/xV5zYFvQPGV0uL/SJpcFTa1rjF3vDieB+yf
         sBZg4/pwX7EJfAqxeJp8I+1sgFf03LA3+Oy1VFTLxlLjeZ97QJHXEWdAQ1uCpWUynULl
         yZuHAbixlQYt90vwNVoNJLwXGiajFzXs5IBqAo6/6/T1AkhKb8rM6bEjh0KgmzBnAKhO
         aAJoRz3nUhz9X8lFq1Of+X7c/mF/K976thGyfpXW56tmam/CsZxmJsymG2JzymMj4wW1
         5c2faDHdEiHOytYkfVGq/Fs4otlMZjmU4AZbQwUw6I1m/i5tP8N0TBccK/2kOZ4ceftE
         F/4Q==
X-Gm-Message-State: AOJu0YyNQ72ksQAEh/VzScCkwnBHX6DYr7ZCTSxRYJTkkl7xJVDcvo41
	sAcv5/gu6EkxnBpzP2QFLuwx553Pw5O1yR93nXP/WSEktVVXY56VY3KlwiWOHL/Hd3tj2n5Im+3
	V14AQpF413w==
X-Google-Smtp-Source: AGHT+IF03Lyufc7ZQjkLAM75CY3E/vbz4nwDB1A/ZtjwIzfICc9/csfFVAV2HNRaha2ugUZVIS2NxR8X9JGuxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a3a6:0:b0:dc7:5925:92d2 with SMTP id
 e35-20020a25a3a6000000b00dc7592592d2mr178777ybi.1.1709072584773; Tue, 27 Feb
 2024 14:23:04 -0800 (PST)
Date: Tue, 27 Feb 2024 22:22:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222259.4081489-1-edumazet@google.com>
Subject: [PATCH net-next] inet6: expand rcu_read_lock() scope in inet6_dump_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

I missed that inet6_dump_addr() is calling in6_dump_addrs()
from two points.

First one under RTNL protection, and second one under rcu_read_lock().

Since we want to remove RTNL use from inet6_dump_addr() very soon,
no longer assume in6_dump_addrs() is protected by RTNL (even
if this is still the case).

Use rcu_read_lock() earlier to fix this lockdep splat:

WARNING: suspicious RCU usage
6.8.0-rc5-syzkaller-01618-gf8cbf6bde4c8 #0 Not tainted

net/ipv6/addrconf.c:5317 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz-executor.2/8834:
  #0: ffff88802f554678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x780 net/netlink/af_netlink.c:2338
  #1: ffffffff8f377a88 (rtnl_mutex){+.+.}-{3:3}, at: netlink_dump+0x676/0xda0 net/netlink/af_netlink.c:2265
  #2: ffff88807e5f0580 (&ndev->lock){++--}-{2:2}, at: in6_dump_addrs+0xb8/0x1de0 net/ipv6/addrconf.c:5279

stack backtrace:
CPU: 1 PID: 8834 Comm: syz-executor.2 Not tainted 6.8.0-rc5-syzkaller-01618-gf8cbf6bde4c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
  lockdep_rcu_suspicious+0x220/0x340 kernel/locking/lockdep.c:6712
  in6_dump_addrs+0x1b47/0x1de0 net/ipv6/addrconf.c:5317
  inet6_dump_addr+0x1597/0x1690 net/ipv6/addrconf.c:5428
  netlink_dump+0x6a6/0xda0 net/netlink/af_netlink.c:2266
  __netlink_dump_start+0x59d/0x780 net/netlink/af_netlink.c:2374
  netlink_dump_start include/linux/netlink.h:340 [inline]
  rtnetlink_rcv_msg+0xcf7/0x10d0 net/core/rtnetlink.c:6555
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2547
  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667

Fixes: c3718936ec47 ("ipv6: anycast: complete RCU handling of struct ifacaddr6")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e27069ad938ca68d758ef956b8c36cb85697eeb5..953a95898e4adce877d153f73ce4ec4a127e60e7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5300,9 +5300,9 @@ static int in6_dump_addrs(struct inet6_dev *idev, struct sk_buff *skb,
 		fillargs->event = RTM_GETMULTICAST;
 
 		/* multicast address */
-		for (ifmca = rtnl_dereference(idev->mc_list);
+		for (ifmca = rcu_dereference(idev->mc_list);
 		     ifmca;
-		     ifmca = rtnl_dereference(ifmca->next), ip_idx++) {
+		     ifmca = rcu_dereference(ifmca->next), ip_idx++) {
 			if (ip_idx < s_ip_idx)
 				continue;
 			err = inet6_fill_ifmcaddr(skb, ifmca, fillargs);
@@ -5410,6 +5410,7 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 	s_idx = idx = cb->args[1];
 	s_ip_idx = cb->args[2];
 
+	rcu_read_lock();
 	if (cb->strict_check) {
 		err = inet6_valid_dump_ifaddr_req(nlh, &fillargs, &tgt_net,
 						  skb->sk, cb);
@@ -5434,7 +5435,6 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 	}
 
-	rcu_read_lock();
 	cb->seq = inet6_base_seq(tgt_net);
 	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
 		idx = 0;
@@ -5456,10 +5456,10 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 		}
 	}
 done:
-	rcu_read_unlock();
 	cb->args[0] = h;
 	cb->args[1] = idx;
 put_tgt_net:
+	rcu_read_unlock();
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


