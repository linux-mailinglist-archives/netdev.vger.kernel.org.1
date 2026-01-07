Return-Path: <netdev+bounces-247821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23EFCFF41A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30AB733BE568
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0639B489;
	Wed,  7 Jan 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fp0n/jSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26C3375D5
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803494; cv=none; b=hCbBBlXBje4APhcQhbH+P0ROJyYZvKpFyNDihEpaNxgJ+hN/225wvIY/9pWlQcSmOCZaM2hlS9Y3C2BIj+kn26OplNU56bNZwg8buVW5Ve+Ww/8J+FNwZInPoLtuDjg5FIJo9zawRhxlIwn4jJEKF2VG1pCEcqpEW/x/hV1rg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803494; c=relaxed/simple;
	bh=rEbtVm17COp2bSRQL2nOO+J4q1cPepurHt1DpV4W0d0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=umfIjSHxeKPvve5WbN/kCo+Wt7p/xRFtmyaprhd99LQ/pXs3jYHy5f1hGs5dwJnH7unlxn+l3mYUXiyXgCYZQ0zMSlOTH4whuzDK7MYrTrAkLSR35b4IvVeYC9UI8KhuzFkaz36++BWnMKqZwEoVJ1oDW3cM+KsaB/LmGSAcCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fp0n/jSt; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c1cffa1f2dso282823085a.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767803471; x=1768408271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/45qKNuLWLkkcRKD/im6tKWY7vYLyg3nocbJRtmrbz0=;
        b=Fp0n/jStyqrk9vLWywhsjBB9DVSzRyU3WwzXjh/0T71AoJRTClgnW9EJdzgjLk01tF
         rlk36Sa1vzkNMr3P6fAce0KqJWiQ4WP6HmzBqNDQKXSjDA2uLMlQBCZlMizW0z8f/0ha
         EkJEJ2zeNdl+gLl5EEUgcvsc4MKpgHFm1+goHOkIk+B9FUxr4jpYyh2eMQWgwCTGuEZZ
         Kj7cz9A20NU/Id2b5JWKDrBN3oLBQpMolCIOCirkYJl1NvQs9B9Ftj+gkxPD4L1Bb0Rq
         pFSEcRnOi4yWZTyO73ihkd8rCjhiXtDZi+0qBFZZzoWQbpODCPO/97X+Rg0SPS3GMQW0
         hwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767803471; x=1768408271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/45qKNuLWLkkcRKD/im6tKWY7vYLyg3nocbJRtmrbz0=;
        b=CFPxgmnnUaAYqazE2aiZb3sDccGq/j6iEi/g3T3wLt7boSAGf3wFLrCE9LW/iJbugK
         h8yjkhGDjdNfjcywRgEXKa6KA0WVrcbfskw1KO8dFCNcemd+3gqca2lDhi/9TjAenQhV
         ParOgvwY6GADxevwgp9CwB0YcaRspjKT5ZCkUatB9yEs+7BjI/zEAWIlyFSBLpbLbekm
         SUQgiqMs1lhFiDm6RhZ+feplMCXwTR4p9dAGZDxxES+WinDSCIthXBNhkDS5R3O4nYuW
         NFKq6LB2p/FBsaMIAXLefs7sNAPShAskKyAGR7gzpMAg/rg7kQXY8/ehrmO3zxUoV3kq
         uraA==
X-Forwarded-Encrypted: i=1; AJvYcCWLEqoBXSQ13gZgYU1krbc1S1n8cSTQ1k1eqNhAxqyzdtCMYqnvcywLw0oh8RxDC2rS3Gt+g+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSn3rZOni0JOz1h/e1qmzbOw9UhAoWlXqoc5qlScL8kMirYKXB
	Po1lslXsuaCI1rNoWmcN1EPTP35ajN4R27/mplyXs98n1IgVBsLkC6lHdiJbj6QJByLJcpVij1N
	nafbxnclNAr4qTg==
X-Google-Smtp-Source: AGHT+IFOUMxLYkJ5adWq/SEwXpkv2af9PVrtVjs+I5D6H/UOrCZbWpauI84NcuLehrntAWkjhjZoEawIfg+V9w==
X-Received: from qknwc12.prod.google.com ([2002:a05:620a:720c:b0:8c3:8d4a:4a58])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2a06:b0:8b2:e1b5:a4d5 with SMTP id af79cd13be357-8c388b807a3mr457645085a.16.1767803470823;
 Wed, 07 Jan 2026 08:31:10 -0800 (PST)
Date: Wed,  7 Jan 2026 16:31:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107163109.4188620-1-edumazet@google.com>
Subject: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Blamed commit did not take care of VLAN encapsulations
as spotted by syzbot [1].

Use skb_vlan_inet_prepare() instead of pskb_inet_may_pull().

[1]
 BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
  __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
  INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
  IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
  ip6ip6_dscp_ecn_decapsulate+0x16f/0x1b0 net/ipv6/ip6_tunnel.c:729
  __ip6_tnl_rcv+0xed9/0x1b50 net/ipv6/ip6_tunnel.c:860
  ip6_tnl_rcv+0xc3/0x100 net/ipv6/ip6_tunnel.c:903
 gre_rcv+0x1529/0x1b90 net/ipv6/ip6_gre.c:-1
  ip6_protocol_deliver_rcu+0x1c89/0x2c60 net/ipv6/ip6_input.c:438
  ip6_input_finish+0x1f4/0x4a0 net/ipv6/ip6_input.c:489
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ip6_input+0x9c/0x330 net/ipv6/ip6_input.c:500
  ip6_mc_input+0x7ca/0xc10 net/ipv6/ip6_input.c:590
  dst_input include/net/dst.h:474 [inline]
  ip6_rcv_finish+0x958/0x990 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:318 [inline]
  ipv6_rcv+0xf1/0x3c0 net/ipv6/ip6_input.c:311
  __netif_receive_skb_one_core net/core/dev.c:6139 [inline]
  __netif_receive_skb+0x1df/0xac0 net/core/dev.c:6252
  netif_receive_skb_internal net/core/dev.c:6338 [inline]
  netif_receive_skb+0x57/0x630 net/core/dev.c:6397
  tun_rx_batched+0x1df/0x980 drivers/net/tun.c:1485
  tun_get_user+0x5c0e/0x6c60 drivers/net/tun.c:1953
  tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
  new_sync_write fs/read_write.c:593 [inline]
  vfs_write+0xbe2/0x15d0 fs/read_write.c:686
  ksys_write fs/read_write.c:738 [inline]
  __do_sys_write fs/read_write.c:749 [inline]
  __se_sys_write fs/read_write.c:746 [inline]
  __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
  x64_sys_call+0x30ab/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:2
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4960 [inline]
  slab_alloc_node mm/slub.c:5263 [inline]
  kmem_cache_alloc_node_noprof+0x9e7/0x17a0 mm/slub.c:5315
  kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:586
  __alloc_skb+0x805/0x1040 net/core/skbuff.c:690
  alloc_skb include/linux/skbuff.h:1383 [inline]
  alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6712
  sock_alloc_send_pskb+0xacc/0xc60 net/core/sock.c:2995
  tun_alloc_skb drivers/net/tun.c:1461 [inline]
  tun_get_user+0x1142/0x6c60 drivers/net/tun.c:1794
  tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
  new_sync_write fs/read_write.c:593 [inline]
  vfs_write+0xbe2/0x15d0 fs/read_write.c:686
  ksys_write fs/read_write.c:738 [inline]
  __do_sys_write fs/read_write.c:749 [inline]
  __se_sys_write fs/read_write.c:746 [inline]
  __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
  x64_sys_call+0x30ab/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:2
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6465 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025

Fixes: 8d975c15c0cd ("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
Reported-by: syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/695e88b2.050a0220.1c677c.036d.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 6405072050e0ef7521ca1fdddc4a0252e2159d2a..c1f39735a23676174839814b7c27e8b690845508 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -844,7 +844,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
-	if (!pskb_inet_may_pull(skb)) {
+	if (skb_vlan_inet_prepare(skb, true)) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
-- 
2.52.0.351.gbe84eed79e-goog


