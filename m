Return-Path: <netdev+bounces-78350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E879B874BF8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B72823CF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A751292F9;
	Thu,  7 Mar 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpUPK5qX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750583A06
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806041; cv=none; b=JvN2lZzruYkdWL4PWyXgjY5+6nMzSH/+QDAYVMc8QRdOCKK0MTcW4fbChEqyU8WufK/1zVRmpEP+4eiVK0X767WOWmlAqA31KcNjtVhqANDYSIahKs5JFjIPJ8PsZ3H66mnjMEKPrDae7rqsIy8yR7Guea4CMfck78MRMfjEMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806041; c=relaxed/simple;
	bh=sL1t0wZJ/4BUdsV0oUGVLrx/AHkbVdk6NuuF6Ke74Xk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ncamBVBS/3PtO9u9N+kL6Cc3lq3v1WXtaKsvB1yEHDtobFMVNNKxrVBrRdDciEue1o0mQjmVhDihaoKYHx5ilcH/R2cqrJGaB3lLdhUU4JdZnrXW422+jHhtNINPce8nQ+SYsTKyujWhXgfSJL2Ko+tKZk2U1+HILQiVhhIa5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpUPK5qX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1312916276.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709806038; x=1710410838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZYPK0MH2AVxZzL4N8oDmNmEYVrGo+kdYBVUpEuHWhwU=;
        b=zpUPK5qXEQ/qPemXdotQ7GQm5nV8BdJ2mX7De1nNzlNxMcgnVtymX8zKjoaoASYw4J
         RYvo1MDkvGLDhpY29CaL2ojlUGTNsSTsAlZUOC9x6NNiiS0iD/Ex4wo+IddZb//78Qwx
         FCDzsuvqJGNtTsF0PZ0ci+I7dHSkUxxXCnl7zjMJJZJurgHVHNAQUVuurHB/Wz+sOXv5
         WajSTdCa3p5igRX1wkdWB9N5xS7SHbqYZhinHZZue1mrxjVmudriME13auUH/TsX8oh0
         Xxhb4VKWNmrgI9027kMkWDokiWqemnWmvrfdKmGsSR/7A55+qo2nYdVfnri4Xz3KcnN8
         Aq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806038; x=1710410838;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYPK0MH2AVxZzL4N8oDmNmEYVrGo+kdYBVUpEuHWhwU=;
        b=SHhDCtg5wtvIsN5zZhGzJ3yGcMnylPjBvF5dHT25/mjFuMhxmkjYf3wo0eVYxybDHz
         DKFGT9AV9c9dx9VgGMCjW0XF9XBiIk0VuiU14gqx0fxjnvmZ30edgyedN+d/HpSh2pFt
         THYnxzFZPiAneEVEcIOKFGx2vpQBn+TitL2U3bzTAVLECCquNoSQpsIIhEIS1UchZtYb
         hxvRTfnFCy3/8kO2fmTOihInuWRPuKky6v1UMmRZ3zahaf1GnX2duVsa+ESK8ueFDfbQ
         gYFBFJghMca9GvOgm+tWBDzRGibSOfw97qFEMU/AZMAAbc8olbnMDieSOH0UKQpO9weN
         Is/w==
X-Forwarded-Encrypted: i=1; AJvYcCXaRI3e33lBy1u7PPiWX6Vu14LSz8a79B3s5Uc2MxaSMw20fc+cvP1r9bv4LHgA57iW1+ot3zjLvPILozkdoUe5vEJp0vZK
X-Gm-Message-State: AOJu0Yypqr/91EBP2flpFZ1G2xrZA6pgIhej3kwhpVouBPBtqErtMojJ
	5tJk/G+Q9i44jcBl+/HXzkpGnAX7WkAtwKpni1SWg0t/JTkGsWyhggPxDBH3SUOkfSFl7P+AK83
	z09T02LLXpQ==
X-Google-Smtp-Source: AGHT+IGPT0iNiF8RUKosm7Wn9/3amwYVj4h2LdQ1nvMQ4g52K0z/L+SbF9Tz0hexRvRwhygObhRhFX3ZxXq9Ug==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr4391862ybt.6.1709806038424; Thu, 07 Mar
 2024 02:07:18 -0800 (PST)
Date: Thu,  7 Mar 2024 10:07:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307100716.1901381-1-edumazet@google.com>
Subject: [PATCH net] net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Apply the same fix than ones found in :

8d975c15c0cd ("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
1ca1ba465e55 ("geneve: make sure to pull inner header in geneve_rx()")

We have to save skb->network_header in a temporary variable
in order to be able to recompute the network_header pointer
after a pskb_inet_may_pull() call.

pskb_inet_may_pull() makes sure the needed headers are in skb->head.

syzbot reported:
BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 BUG: KMSAN: uninit-value in IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
 BUG: KMSAN: uninit-value in ip_tunnel_rcv+0xed9/0x2ed0 net/ipv4/ip_tunnel.c:409
  __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
  INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
  IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
  ip_tunnel_rcv+0xed9/0x2ed0 net/ipv4/ip_tunnel.c:409
  __ipgre_rcv+0x9bc/0xbc0 net/ipv4/ip_gre.c:389
  ipgre_rcv net/ipv4/ip_gre.c:411 [inline]
  gre_rcv+0x423/0x19f0 net/ipv4/ip_gre.c:447
  gre_rcv+0x2a4/0x390 net/ipv4/gre_demux.c:163
  ip_protocol_deliver_rcu+0x264/0x1300 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x2b8/0x440 net/ipv4/ip_input.c:233
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
  dst_input include/net/dst.h:461 [inline]
  ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_rcv+0x46f/0x760 net/ipv4/ip_input.c:569
  __netif_receive_skb_one_core net/core/dev.c:5534 [inline]
  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5648
  netif_receive_skb_internal net/core/dev.c:5734 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5793
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1556
  tun_get_user+0x53b9/0x66e0 drivers/net/tun.c:2009
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2055
  call_write_iter include/linux/fs.h:2087 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb6b/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
  alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2909
  tun_build_skb drivers/net/tun.c:1686 [inline]
  tun_get_user+0xe0a/0x66e0 drivers/net/tun.c:1826
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2055
  call_write_iter include/linux/fs.h:2087 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb6b/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 1b6981de3f29514dac72161be02f3ac6e4625551..7af36e4f1647d8f2b6a19baa2e072e628170452c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -378,7 +378,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error)
 {
 	const struct iphdr *iph = ip_hdr(skb);
-	int err;
+	int nh, err;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(iph->daddr)) {
@@ -404,8 +404,21 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+	iph = (struct iphdr *)(skb->head + nh);
+
 	err = IP_ECN_decapsulate(iph, skb);
 	if (unlikely(err)) {
 		if (log_ecn_error)
-- 
2.44.0.278.ge034bb2e1d-goog


