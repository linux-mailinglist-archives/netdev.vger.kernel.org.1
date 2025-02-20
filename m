Return-Path: <netdev+bounces-168189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04281A3DF7F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE6188B772
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928131D5CD9;
	Thu, 20 Feb 2025 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1Jvy+1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6588F5B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066821; cv=none; b=akRLsEE5dSQJISupBTQ4jFHkpYszEjQu1TFhjDNl49C6uHhDyJ7pYWM72LyQYimw8L/j8fjCt6KRzsNsiweF/Z0N+iXv73JGeE3+xzDpMPbFd3Hl/QbRNF+7MS5CUVOENmPq/5Ms0iig99KEQ2L1SRx4cBgQI0TjTTH9P/XYCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066821; c=relaxed/simple;
	bh=In2VJT90B5AbVOfSJT2HpgSaOJuRr0KFiJmIaA5Gddo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jWTkx7OduHSw/i4mcMlU5vKYfPPdCAspy1N16kLQMxLUMbV7Jy7wRq58302Hg3qvEAIvwSUWLknLcH8SLYNVtvo97LPXQJbAvIrkE4iSxeuz0+Qvg2U10vMIy702grN4fe0127hB4PoLuW9J5g6iroVb2gGHkoUOmtyUPjQFaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1Jvy+1t; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-47202b65720so21391671cf.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740066818; x=1740671618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlyGheRXC52SO80dqQ9cUtuqW77BTspJoeFhj28aOqA=;
        b=K1Jvy+1tZBsv6CpYIlOBsM9ypr1qxcXeNbiOlHnMw+K/TYFm5G48JAtCKtp4rtw/If
         7G7Sy/NMBOuNJ0oBTYA/GZb5O4pRuanrHbzzbk21ISw7gj2JIx9HzKbpFBA5Kw/D2W8J
         cWEPiS7Ig0DU8Y+gqQbAzr2MY4rpS/Awk1pkQSQYbOJnRBSxbbzrc+z4BfSseZ/nTBN8
         +nbRlX8HZpqGGkHEAY9dDe3Hk+WJMLzmUgIJWGMO2XgMTKgVpK48B2g9J3YIS+hAsa9U
         7n142Ncbk2DhnvwNCQhz/k8DjyNN2dYPoND+vjlIIqbunH7uVROyOTSCBqur5eqJDAKx
         LtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066818; x=1740671618;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlyGheRXC52SO80dqQ9cUtuqW77BTspJoeFhj28aOqA=;
        b=N1SRdJNCS6f9Y3ycGv3pWpX9SLFJjbxpqEnGG/qn01ZJqPOQt7Yq0Ciohp3xazVbMf
         SiuyhEgz3+k6CsLwjuBiGdKzeCNArPNJzA+N3wkXEYF6jOB1PKwXcoKD83ve4qz31WUN
         BGXBlK7hsfi22xsK4qJ7XrNnT7NbYiiAXq6kxhKo1Ec3SJN6ec+ytGB2YuGr8vl3Uto+
         zGjAUoAgs8cGW4W+bUh+IC6XwXNRvD4tGQAuaV4gNzft+XH6LsOxO9vaTXn6GbcvyWlQ
         g9gHPzd/z1bfyPCZL1Xc0p7taU+RXJGxCPysVRNbXyzTUd3pqGJfKewofxarTTjlRCfm
         Dtlg==
X-Gm-Message-State: AOJu0YxekM44I9hS5RLrG375VlUQvsFUwVvn8zDXRbxyUOfjALZa5bf3
	l4HsG5rtrM7GhHfAXRoZTwJrCsO/MdZzSFL7M8Ak8Ckj+ZPt9pjqpIIAGspVRaS9eKRkP62OwPo
	AN2DtUH5bCA==
X-Google-Smtp-Source: AGHT+IEfBLcBzQkTesDjOQqX/V6OdePXN/g6+N1y0MAAYhCnO1t8sJTXD0PsNiYmr77Wji+tkAXdKgINoiLA+Q==
X-Received: from qtbew15.prod.google.com ([2002:a05:622a:514f:b0:471:a6eb:18b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5782:0:b0:471:f6c4:1dce with SMTP id d75a77b69052e-472082d76fbmr104501191cf.51.1740066818739;
 Thu, 20 Feb 2025 07:53:38 -0800 (PST)
Date: Thu, 20 Feb 2025 15:53:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220155336.61884-1-edumazet@google.com>
Subject: [PATCH net] ipvlan: ensure network headers are in skb linear part
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that ipvlan_process_v6_outbound() was assuming
the IPv6 network header isis present in skb->head [1]

Add the needed pskb_network_may_pull() calls for both
IPv4 and IPv6 handlers.

[1]
BUG: KMSAN: uninit-value in __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
  __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
  ipv6_addr_type include/net/ipv6.h:555 [inline]
  ip6_route_output_flags_noref net/ipv6/route.c:2616 [inline]
  ip6_route_output_flags+0x51/0x720 net/ipv6/route.c:2651
  ip6_route_output include/net/ip6_route.h:93 [inline]
  ipvlan_route_v6_outbound+0x24e/0x520 drivers/net/ipvlan/ipvlan_core.c:476
  ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:491 [inline]
  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:541 [inline]
  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:605 [inline]
  ipvlan_queue_xmit+0xd72/0x1780 drivers/net/ipvlan/ipvlan_core.c:671
  ipvlan_start_xmit+0x5b/0x210 drivers/net/ipvlan/ipvlan_main.c:223
  __netdev_start_xmit include/linux/netdevice.h:5150 [inline]
  netdev_start_xmit include/linux/netdevice.h:5159 [inline]
  xmit_one net/core/dev.c:3735 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3751
  sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
  qdisc_restart net/sched/sch_generic.c:408 [inline]
  __qdisc_run+0x14da/0x35d0 net/sched/sch_generic.c:416
  qdisc_run+0x141/0x4d0 include/net/pkt_sched.h:127
  net_tx_action+0x78b/0x940 net/core/dev.c:5484
  handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
  __do_softirq+0x14/0x1a kernel/softirq.c:595
  do_softirq+0x9a/0x100 kernel/softirq.c:462
  __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
  __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4611
  dev_queue_xmit include/linux/netdevice.h:3311 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3132 [inline]
  packet_sendmsg+0x93e0/0xa7e0 net/packet/af_packet.c:3164
  sock_sendmsg_nosec net/socket.c:718 [inline]

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Reported-by: syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67b74f01.050a0220.14d86d.02d8.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index fd591ddb3884df2046b816bd57f0814f7f5c4dfc..ca62188a317ad436173215fa4552f1a188d99384 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -416,20 +416,25 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 
 static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net_device *dev = skb->dev;
 	struct net *net = dev_net(dev);
-	struct rtable *rt;
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+	struct rtable *rt;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
-		.daddr = ip4h->daddr,
-		.saddr = ip4h->saddr,
 	};
 
+	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+		goto err;
+
+	ip4h = ip_hdr(skb);
+	fl4.daddr = ip4h->daddr;
+	fl4.saddr = ip4h->saddr;
+	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h));
+
 	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto err;
@@ -488,6 +493,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int err, ret = NET_XMIT_DROP;
 
+	if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr))) {
+		DEV_STATS_INC(dev, tx_errors);
+		kfree_skb(skb);
+		return ret;
+	}
+
 	err = ipvlan_route_v6_outbound(dev, skb);
 	if (unlikely(err)) {
 		DEV_STATS_INC(dev, tx_errors);
-- 
2.48.1.601.g30ceb7b040-goog


