Return-Path: <netdev+bounces-116867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 820DE94BE7E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F406B20C63
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2118CC1E;
	Thu,  8 Aug 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fI6QuV5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF724A33
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123500; cv=none; b=kbwwtgCvGprFZfdKYlSEfZAr/F2vHibxDKkAwUjQAfGEDUZ9zCD5tMkcTcSzRsbOInl/ONZv/3NlU/RG/HoBdxxxZty/xZL34eYbesPGfypjL5xgwYNQi6zBOHXS/v1aAaXp4yTa1Riw0usWBFzrqKpXoYLwrem0p21JFV64f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123500; c=relaxed/simple;
	bh=z0wF5/DsHofxXVeO4ZTAg8RY9B+Nv2dlVyDhMPJy5Xc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SM+t/WLMsRy7k1rpC1vy+wskb6mgMJnhfS3Y3QwN71mLYsqJ9J2n4ws5FqiTXv2afUinNYA25m58LA/8yrym80h7BlA0Uaz5CoSW1yDGqSMN023kxU3veVoYWmpG7DhP4gj8DFz0JWce+tDrPc+6XSDDuuObAIKrT6lr+xOL8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fI6QuV5+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0baf2a2ed1so3073123276.1
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723123497; x=1723728297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eq5pkd26vFRb0yXorRbn2L0KGs5TiRJ/jRcU6k+Nfwc=;
        b=fI6QuV5+ayqiA+Yq8d3Mqg7DHUhLBoBViqL4sytCbMEtG1vNhM6JnLvSrb2NxxU3E5
         36No6OWwSQj6pyhI+gEATlyWyg0tFOmVZQdXUcP0Wr3YKJ1GPm3Nsc6oCTgacjNJn/z1
         yFNi+PG3vie7U/4CG7RtGX6DW6SY7Yw1j5aX0O+8uigUE2OnGfLhf8la4KI6qBDjmLLT
         6q7Js5nONXxHbBcKaZgbYSMlq0JeJkaspZlCo/j1VPrSameLeABCfMfWPNl8eMdQrnOT
         WckM63AMyqCO/sG90vZG1hnSzDOOP/O/ehGSx36hbm9j/lpstJ0h1bO6ncK+weVMa+VM
         tqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123497; x=1723728297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq5pkd26vFRb0yXorRbn2L0KGs5TiRJ/jRcU6k+Nfwc=;
        b=XftHi8/IzwoX9DW2AjfZnwt8bXrKWnRW0z9wIEJHjy0fgvHr4dBWtNMHrCv/OnUf9+
         HBmwdRDnrwGPTcO9qBGD/VBsy6poR57zsriCvCb1FJ1w9riasMMTgA54+iRkE3mZya3s
         vM+kePIZrQDO+1f3YVGZxD7/uDEI54SKBxRjXJWsef/qJAKM9RRP4HJIOOrj6g/fmdQu
         +6YgL6AGfIJlK5z4eq7UEcrF6hE/oWF17utI8CgOsi7BEypLLeEY5yPhztmWiLkxjkvW
         MYXY4vQ7fUiMFRf9NvCJCXagfg/5FPLRCpHePE1RVtMZA8l3PW5dpEcLXU544Pxt1x+g
         tLGw==
X-Gm-Message-State: AOJu0YwQyzTlUmHESuhos6bojMLZOyhzlR1DtLmIV7n8e6ivHB7j3Ux6
	fol4bIDCNmi79RQaHKDlVUAXzxYKrwm+LSIBeAiE5+cNSDyqXeVIFjtp8UsTEMiCWGZXV+FccyM
	4J3Sa2vT2MA==
X-Google-Smtp-Source: AGHT+IF/JmGVpr/eHJyQgd8LepVl1CqWAD95vTR7MoV+7Yz5WrSGjriLPJJNGIKGSKTEUESKkxDomoLT9YTQEA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:eb10:0:b0:e0b:e23a:9713 with SMTP id
 3f1490d57ef6-e0e9f6e9261mr45230276.1.1723123497143; Thu, 08 Aug 2024 06:24:57
 -0700 (PDT)
Date: Thu,  8 Aug 2024 13:24:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240808132455.3413916-1-edumazet@google.com>
Subject: [PATCH net] gtp: pull network headers in gtp_dev_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Harald Welte <laforge@gnumonks.org>
Content-Type: text/plain; charset="UTF-8"

syzbot/KMSAN reported use of uninit-value in get_dev_xmit() [1]

We must make sure the IPv4 or Ipv6 header is pulled in skb->head
before accessing fields in them.

Use pskb_inet_may_pull() to fix this issue.

[1]
BUG: KMSAN: uninit-value in ipv6_pdp_find drivers/net/gtp.c:220 [inline]
 BUG: KMSAN: uninit-value in gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
 BUG: KMSAN: uninit-value in gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
  ipv6_pdp_find drivers/net/gtp.c:220 [inline]
  gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
  gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
  __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
  netdev_start_xmit include/linux/netdevice.h:4922 [inline]
  xmit_one net/core/dev.c:3580 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3596
  __dev_queue_xmit+0x358c/0x5610 net/core/dev.c:4423
  dev_queue_xmit include/linux/netdevice.h:3105 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3145 [inline]
  packet_sendmsg+0x90e3/0xa3a0 net/packet/af_packet.c:3177
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  __sys_sendto+0x685/0x830 net/socket.c:2204
  __do_sys_sendto net/socket.c:2216 [inline]
  __se_sys_sendto net/socket.c:2212 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
  x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3994 [inline]
  slab_alloc_node mm/slub.c:4037 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
  alloc_skb include/linux/skbuff.h:1320 [inline]
  alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6526
  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2815
  packet_alloc_skb net/packet/af_packet.c:2994 [inline]
  packet_snd net/packet/af_packet.c:3088 [inline]
  packet_sendmsg+0x749c/0xa3a0 net/packet/af_packet.c:3177
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  __sys_sendto+0x685/0x830 net/socket.c:2204
  __do_sys_sendto net/socket.c:2216 [inline]
  __se_sys_sendto net/socket.c:2212 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
  x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 7115 Comm: syz.1.515 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024

Fixes: 999cb275c807 ("gtp: add IPv6 support")
Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/net/gtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 427b91aca50d3a370e4ad00071f0c477fefa5076..0696faf60013e0669ceb4aa39dfbac17ad741540 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1269,6 +1269,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto tx_err;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	skb_reset_inner_headers(skb);
 
 	/* PDP context lookups in gtp_build_skb_*() need rcu read-side lock. */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


