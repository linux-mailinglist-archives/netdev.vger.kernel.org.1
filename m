Return-Path: <netdev+bounces-248248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEDD05BFD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CAB0306F8CC
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12B2FFF8E;
	Thu,  8 Jan 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHCDhwtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7926E17C77
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898938; cv=none; b=Bc0YBJQIHH142KrGzMu5aQfGtk4n3FHWSXjIm9BXC9iHrxW0kQXTZNnZTQ+w+uGhxyzyuIUw10Wfh4GToDGpl5k77nAjymHTxrlAya5erjdR5a2GVSuaSU6irv2JoU8gmxeAkealecySWLulhXrITIibznc3ux2DYY+JMHHSf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898938; c=relaxed/simple;
	bh=bmsgJQjLk29OJNvpvfRINdDYgS5i02EpAdv8qvo87Tw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q2kpvrpwPl3OMtiLI04PXkQ2mw2qBexo3DshTU0u4ai/EPd7oakJw+S7WbpZcpYMheHAwWTfUMBCMaDeMqt/7GREjhhXfffcS/Fy6eMqCuGNbtLSeF9wG+qtWsYIkqUzAu3IkxC5wz10nOpFnvQP93GvzGJEMDlwnzAxaWByQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHCDhwtm; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-93f5fe52b10so8013742241.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767898936; x=1768503736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EDj2Vvsei5534FITWHXTg4wgHwlaEiMeQ4aPR0lt8yc=;
        b=RHCDhwtmOqicAg4CLfIlTDSZ8/msTZx0sECgx391anqQIVBx++1SvLKUhDBR4icjFl
         xdEqCcy6JiwuO0T1BrvndJj6btg30SsQ85+Tn39Z4MWEbtd1y3VdHNJFH0ivlnqxShAX
         9J25KOby1Q/GM0/Nx1yZfNOfURjEH6lxOhQRnXwpwbasSrrNbid653TDXB++utYh0TrU
         elVeP0ej1YvgxldT43ppnv/+dfpGLFkiIB9VtoiqCRvBV+4egE93koKTVRFYlSBwuskg
         NAM5c6EZ64+ESJoRFR88cknnQvYXtzny+kk60+uAv6nq18lwCLC2ftTqbDls7hLm/oMH
         OfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898936; x=1768503736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDj2Vvsei5534FITWHXTg4wgHwlaEiMeQ4aPR0lt8yc=;
        b=DeCtOGMh2CY62Rn2930/7PNmHDjbbUEdYd/Z6Vcyp7W/AiFwWqbCYEk95xxLtOQrwB
         sYwCRbxhiI7NYAkqkhEBd46bZO7pBmC6N31yjs/38OGI/ij1llK3NfXbf/H9DMCZA3Wt
         YZniCToUHCPUXSN00LfzvCqDZHWQUzm7s6T79KIdF93v3qG55wQ8wPKi4VtL7TZWlUoS
         x6rUO0FLMqmS8CbeFw9KMkeZeCyZkihLK4XRvIvZzXxJMSSZpQtomWnefX02vzC46fmp
         y5SHa5Ic8VQqyhZ3fHGeJUaM7kW3LP/ZxaUVTQoFKYiEoZxBOf8VThj9MCYaEuVLkKkq
         P7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXqZBvGHzbzX7VfagoEjQAINKzTEcuRKnMykY6OoIDlOPAGBB/8PeWCaReivJnA8KUgzUFdyTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6s/IiIp9VSwpCNvCJ4O+hDkYQrIxL5nWqihB7qgU5PJT+msQs
	XEbFGKi+5LcObf8SJb8mM4lszbgyAoV8sR6U1zl1WdutDflI9MW4DodZY5xdKuNwCR+Za7Rl16S
	OPwIB4Vh4MzzPXg==
X-Google-Smtp-Source: AGHT+IGjC8bFQ9AcUYDDWAL6x3CrQ/3mMjNLHg/HzJ3BeRqfNzWWSQYax9ZrU8zE3tM17cQ0oE0szEbJNCZNqg==
X-Received: from qvbkr16.prod.google.com ([2002:a05:6214:2b90:b0:88a:27b1:923a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:548b:b0:5d7:debc:ae81 with SMTP id ada2fe7eead31-5ecb1e8dba8mr2758918137.4.1767898936044;
 Thu, 08 Jan 2026 11:02:16 -0800 (PST)
Date: Thu,  8 Jan 2026 19:02:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108190214.1667040-1-edumazet@google.com>
Subject: [PATCH net] ipv4: ip_gre: make ipgre_header() robust
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Analog to commit db5b4e39c4e6 ("ip6_gre: make ip6gre_header() robust")

Over the years, syzbot found many ways to crash the kernel
in ipgre_header() [1].

This involves team or bonding drivers ability to dynamically
change their dev->needed_headroom and/or dev->hard_header_len

In this particular crash mld_newpack() allocated an skb
with a too small reserve/headroom, and by the time mld_sendpack()
was called, syzbot managed to attach an ipgre device.

[1]
skbuff: skb_under_panic: text:ffffffff89ea3cb7 len:2030915468 put:2030915372 head:ffff888058b43000 data:ffff887fdfa6e194 tail:0x120 end:0x6c0 dev:team0
 kernel BUG at net/core/skbuff.c:213 !
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 1322 Comm: kworker/1:9 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: mld mld_ifc_work
 RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:213
Call Trace:
 <TASK>
  skb_under_panic net/core/skbuff.c:223 [inline]
  skb_push+0xc3/0xe0 net/core/skbuff.c:2641
  ipgre_header+0x67/0x290 net/ipv4/ip_gre.c:897
  dev_hard_header include/linux/netdevice.h:3436 [inline]
  neigh_connected_output+0x286/0x460 net/core/neighbour.c:1618
  NF_HOOK_COND include/linux/netfilter.h:307 [inline]
  ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
  NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
  mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
  mld_send_cr net/ipv6/mcast.c:2154 [inline]
  mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
  process_one_work kernel/workqueue.c:3257 [inline]
  process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
  kthread+0x711/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Reported-by: syzbot+7c134e1c3aa3283790b9@syzkaller.appspotmail.com
Closes: https://www.spinics.net/lists/netdev/msg1147302.html
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_gre.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 8178c44a3cdd48c5a737e9f4e5696ad8f9fbd4cc..e13244729ad8d5b1c2b9c483d25bff0e438134b5 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -891,10 +891,17 @@ static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
 			const void *daddr, const void *saddr, unsigned int len)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct iphdr *iph;
 	struct gre_base_hdr *greh;
+	struct iphdr *iph;
+	int needed;
+
+	needed = t->hlen + sizeof(*iph);
+	if (skb_headroom(skb) < needed &&
+	    pskb_expand_head(skb, HH_DATA_ALIGN(needed - skb_headroom(skb)),
+			     0, GFP_ATOMIC))
+		return -needed;
 
-	iph = skb_push(skb, t->hlen + sizeof(*iph));
+	iph = skb_push(skb, needed);
 	greh = (struct gre_base_hdr *)(iph+1);
 	greh->flags = gre_tnl_flags_to_gre_flags(t->parms.o_flags);
 	greh->protocol = htons(type);
-- 
2.52.0.457.g6b5491de43-goog


