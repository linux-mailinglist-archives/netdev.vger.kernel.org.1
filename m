Return-Path: <netdev+bounces-201919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9BAEB6D3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35A21C6057C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0F2C1594;
	Fri, 27 Jun 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfgbZuC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89E2BD025
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024806; cv=none; b=elmvKzUUJYfk3QD7qeBGmxBj4OP0mpWX0yVvMJbaeVdCRBtCpXl/AyNOBLQ3XahVqUj5aKQ2jZqbUyZwpUMMcuR605HKQl1d/lK3oBFTyYg62icLMl4c/uriGqM72hLNY25JTi1U2daPiO0wWAlWX1bBdKZcIXXpX8Z49er+lKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024806; c=relaxed/simple;
	bh=RK14avDElPlL0EERgP1yMNUtiCfGAfu3yhaSarhMKNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJgzL9HZ1P6A4zad/ArHksxV3oqCAu0oJsQ8fYWrOa9xi+H7tWAxil+gKUz7TAFpd3x0sAOTBVivHZK2/+OSxY0thA4E2cJriGCTH726SL73rSjUJMFZin4oB9j8o7et5jqir+AwyuG8X24gN2FsHmEKc3tWHRTGAU7RzeIGK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfgbZuC4; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a585ad6726so65239341cf.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751024803; x=1751629603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdnKmTa+KSkRAVLiBYawQ/7ji9kFGcaBOv3DGKCVRxo=;
        b=sfgbZuC4ewcFmdmiTibdTaB1rL5WP2gWp3hmVaHcHeNNwUY3zVp0rXGI+TG/bHRsCw
         2z/IVknuOgkeQOIMYAV3fYk4wIoxup0mmq2LYXC1iElEIBaB5c1k7Dejn/JyoB+03AVg
         oRvG+MGl6QPC5+ya5NdwjRRq85sDH22zU/pprmhzVLVcbtuDosGriVoRh6luHxUx1B1s
         KBqVKuf1pD/2Zj/XOAS6v2fJcZrIW/FPRYXhPcE/I3SRda8DcyEaFmPUzzHGFfEBBI+8
         jT+nvQ7JgEGP1IWL7GgrsuhJVX0SXllRHg3APSFUWYe4j16kryVdMgvESerW9YXvo+HD
         ZP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751024803; x=1751629603;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdnKmTa+KSkRAVLiBYawQ/7ji9kFGcaBOv3DGKCVRxo=;
        b=Gdf1qUOS+zD5/nXeCGgJn55OHIZUINt5wZqopor4/7RX+KJhXt36KYGM59yfbrioYA
         jDrsgZFLBZIh/8M5mPAm8fMelcJNHrQwTEBSDg4R05SGrhEFMbDekR4qCdgIztMFR6rX
         jA1/ezwtTIj23UMlw6g88n+vPQDWz5tUZ6WDvXZtsvJRSvj+QvmA9iEPoWeDezxAps4z
         i0FOZJXIMB4SsPvD3ivGBdjpjRUl+DRpGYWDmm+2yR+WVGVmKh+k8TD6VsXuk2wkOSxJ
         OKj5yE4L+2aoDo4UX4wz1hED9t5teD65s5hS3OTQ2WKAb13XtOToEqzepbc1zPIWg1/e
         N+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVVC0iMDVyHWjPVZ835AEjb1fHfdfYT3mqw8h82OlSYRkvfXhvdfS8+qkxSsDxF0lupYO1r0QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5Q1ZgAfXaEaGl8kMTnW2TPxlc7rrKemrgiVPbFpAWaBWJzEM
	k89AqbQzLowTL8kajQ2/g4JMDataU785W7qra8posgSV4WHiQ8t9jEtXcHJYX9kx+H0JOSTZeHM
	id+t9M7rX5O3RNw==
X-Google-Smtp-Source: AGHT+IFOTOg3Na/u9rTdFvEQxNNLU9MVVQyPR52nWHco467AOehFdRndV48qTmtq9ehNc5IpURl4eqeNq4mIJA==
X-Received: from qtbez7.prod.google.com ([2002:a05:622a:4c87:b0:4a5:87ef:74c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:16:b0:478:f4bd:8b8e with SMTP id d75a77b69052e-4a7fcaf50d1mr52993681cf.39.1751024803259;
 Fri, 27 Jun 2025 04:46:43 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:46:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627114641.3734397-1-edumazet@google.com>
Subject: [PATCH net-next] net: ipv4: guard ip_mr_output() with rcu
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com, 
	Petr Machata <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Benjamin Poirier <bpoirier@nvidia.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found at least one path leads to an ip_mr_output()
without RCU being held.

Add guard(rcu)() to fix this in a concise way.

WARNING: CPU: 0 PID: 0 at net/ipv4/ipmr.c:2302 ip_mr_output+0xbb1/0xe70 net/ipv4/ipmr.c:2302
Call Trace:
 <IRQ>
  igmp_send_report+0x89e/0xdb0 net/ipv4/igmp.c:799
 igmp_timer_expire+0x204/0x510 net/ipv4/igmp.c:-1
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x61a/0x860 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x286/0x870 kernel/softirq.c:579
  __do_softirq kernel/softirq.c:613 [inline]
  invoke_softirq kernel/softirq.c:453 [inline]
  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050

Fixes: 35bec72a24ac ("net: ipv4: Add ip_mr_output()")
Reported-by: syzbot+f02fb9e43bd85c6c66ae@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/685e841a.a00a0220.129264.0002.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index f78c4e53dc8c161e334781970bbff6069c084ebb..3a2044e6033d5683bda678489f6eaf72ea0b8890 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2299,7 +2299,8 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct mr_table *mrt;
 	int vif;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	guard(rcu)();
+
 	dev = rt->dst.dev;
 
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
@@ -2313,7 +2314,6 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (IS_ERR(mrt))
 		goto mc_output;
 
-	/* already under rcu_read_lock() */
 	cache = ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
 	if (!cache) {
 		vif = ipmr_find_vif(mrt, dev);
-- 
2.50.0.727.gbf7dc18ff4-goog


