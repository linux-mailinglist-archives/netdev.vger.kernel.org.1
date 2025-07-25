Return-Path: <netdev+bounces-210056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B54EFB11FC9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1641CE4E2E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E961E833D;
	Fri, 25 Jul 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONnRLM7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39610FD
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452454; cv=none; b=DOQtrBhUmPX0x+BMQjojiw+roN3VZRcJgqhFo7h4TFOLHm0FPkGPH2O9E+GmIkzhTK3klgpYfu/guCVkq6jdt1WaYp9I9qXSoDyd+0sy16dufjDGohVOWb+8yTJrCI8P5ojlqkB24PzmAFIqS+ajcNQ70MJ2rrYSh0dGzWzU4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452454; c=relaxed/simple;
	bh=dH9xBgLOdJdFQjqXs3bO1LnsPdeeRerakKd87Aso1iY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t8lO+k3+qG/2z+Y0IKP6xrIuwuFxHDxhoQwGzgnZOCXriHNJFnfW1rxbsb85Y4wHK+ZTEuV9v1XMSy43bqk4Z1GZ9SzaqAbBfSZBcX1KfLQE9uE10V1SzEORl/8+8zsFJfY+lO6p4pmFFsa03I34YGje1Tof0mvZQX0j1VC2k/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONnRLM7R; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab401e333bso68720781cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753452452; x=1754057252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z60/rfIr+shfVsna/JmHBnbxO65XMJQ2fycboQ1wLI4=;
        b=ONnRLM7RInDDg6t601NWmawJsr47+SeKjGnFd73nk6INzDvPy8AAGo7eR88ZsWdFv5
         xEjVrgH5yLvQJr1B2HiM9VpiB5qMTo30MyKuP8kQEs1CsQUk8QKy2k7u0eY4Z1GJzjls
         ObRzLe+JlH7zRec4VVcMKbtFoyVAGvIffm2Twp6hrL5YgdtVtc5Hr4Xag9prZheZRDSq
         B14lD7aPeds4WsmwwF66EgRhZOXWVp5xGzuMFpnKS7CoqEYG0kBbChmfKeFYuu7/RthF
         p7Mjx8eMmhKZM6uanUSDlMFsXmpclbsbFsPGVM5ceMjhNCUddcAB0oWYaWbRoAsQGfCE
         iDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452452; x=1754057252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z60/rfIr+shfVsna/JmHBnbxO65XMJQ2fycboQ1wLI4=;
        b=NGI5YyZaXTlSm/eTXtVKvteC7gCmsxcw0MBosIckZHSdmeAskzEk5GPIBAW5JzZov5
         P2i3aKIXBBeozCpsdjYdRUTi0S0RoBYaFGGzTIC4Vd6qzSy1qwCec6TAk/LW1yV4loGP
         p5QFCZ+8ihpqpW/u4Bjm1OACiLx2wOlcp4mKXf/FOchub/Y2+HpqlTDQU0CKUuKrzTbU
         6Lz6DB/frA3jRE/bdL0mgZ9KeNu8W0PzkZsugMSPtYz+O5BXxyOYz99rkuS+0DnFNKEf
         SHQhc6tkpTwveQbN62t1tAFQeLiN789MsTY3hf4xVOB9dJ5NGxQWUZc8o1vDlqpu+8py
         FO4w==
X-Forwarded-Encrypted: i=1; AJvYcCURdGFzYOh4BmqXhWaz6gzwd/DlNX+8H7Wukp2R0tI9TPjP/yhBSqeMiaLuTDoHQ/Yor1OZu+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYjKT0Ycb+b0GUo9vk/LuDf0S3zRmmAjnoEnBmfjkCTHQB8XI
	2mB5J4MLaTgTKviDf6cN9BT3c8QXf3kuTuNdMYAE+u2262IRRNrzYJjRmwFUvqzXEqiDQ2FPaR4
	hcXb2FXPMakz1Bw==
X-Google-Smtp-Source: AGHT+IFCZAVLky1nZnQQ+fAK6ZHi4fLLCZaQR3YUlk7PKVLeQfdD9KA3Mf1P/DJwE2qvK4LnoW+alOFIh0fYQQ==
X-Received: from qtbcd12.prod.google.com ([2002:a05:622a:418c:b0:4ab:9ecd:a145])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:286:b0:4a9:7366:40dd with SMTP id d75a77b69052e-4ae8e8d4d9amr25951151cf.19.1753452451581;
 Fri, 25 Jul 2025 07:07:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:22 +0000
In-Reply-To: <20250725140725.3626540-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725140725.3626540-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725140725.3626540-2-edumazet@google.com>
Subject: [PATCH net 1/4] ipv6: add a retry logic in net6_rt_notify()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

inet6_rt_notify() can be called under RCU protection only.
This means the route could be changed concurrently
and rt6_fill_node() could return -EMSGSIZE.

Re-size the skb when this happens and retry, removing
one WARN_ON() that syzbot was able to trigger:

WARNING: CPU: 3 PID: 6291 at net/ipv6/route.c:6342 inet6_rt_notify+0x475/0x4b0 net/ipv6/route.c:6342
Modules linked in:
CPU: 3 UID: 0 PID: 6291 Comm: syz.0.77 Not tainted 6.16.0-rc7-syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:inet6_rt_notify+0x475/0x4b0 net/ipv6/route.c:6342
Code: fc ff ff e8 6d 52 ea f7 e9 47 fc ff ff 48 8b 7c 24 08 4c 89 04 24 e8 5a 52 ea f7 4c 8b 04 24 e9 94 fd ff ff e8 9c fe 84 f7 90 <0f> 0b 90 e9 bd fd ff ff e8 6e 52 ea f7 e9 bb fb ff ff 48 89 df e8
RSP: 0018:ffffc900035cf1d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc900035cf540 RCX: ffffffff8a36e790
RDX: ffff88802f7e8000 RSI: ffffffff8a36e9d4 RDI: 0000000000000005
RBP: ffff88803c230f00 R08: 0000000000000005 R09: 00000000ffffffa6
R10: 00000000ffffffa6 R11: 0000000000000001 R12: 00000000ffffffa6
R13: 0000000000000900 R14: ffff888032ea4100 R15: 0000000000000000
FS:  00007fac7b89a6c0(0000) GS:ffff8880d6a20000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fac7b899f98 CR3: 0000000034b3f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
  ip6_route_mpath_notify+0xde/0x280 net/ipv6/route.c:5356
  ip6_route_multipath_add+0x1181/0x1bd0 net/ipv6/route.c:5536
  inet6_rtm_newroute+0xe4/0x1a0 net/ipv6/route.c:5647
  rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
  netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
  netlink_unicast+0x58d/0x850 net/netlink/af_netlink.c:1346
  netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
  sock_sendmsg_nosec net/socket.c:712 [inline]
  __sock_sendmsg net/socket.c:727 [inline]
  ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
  ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620

Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 net/ipv6/route.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 79c8f1acf8a35e465ab1a21aca50a554ca6f513b..9f92129efa05087d435575aa84c81b30430db249 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6321,8 +6321,9 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int nlm_flags)
 {
-	struct sk_buff *skb;
 	struct net *net = info->nl_net;
+	struct sk_buff *skb;
+	size_t sz;
 	u32 seq;
 	int err;
 
@@ -6330,17 +6331,21 @@ void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 	seq = info->nlh ? info->nlh->nlmsg_seq : 0;
 
 	rcu_read_lock();
-
-	skb = nlmsg_new(rt6_nlmsg_size(rt), GFP_ATOMIC);
+	sz = rt6_nlmsg_size(rt);
+retry:
+	skb = nlmsg_new(sz, GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
 	err = rt6_fill_node(net, skb, rt, NULL, NULL, NULL, 0,
 			    event, info->portid, seq, nlm_flags);
 	if (err < 0) {
-		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
-		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
+		/* -EMSGSIZE implies needed space grew under us. */
+		if (err == -EMSGSIZE) {
+			sz = max(rt6_nlmsg_size(rt), sz << 1);
+			goto retry;
+		}
 		goto errout;
 	}
 
-- 
2.50.1.470.g6ba607880d-goog


