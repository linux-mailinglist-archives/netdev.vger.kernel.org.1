Return-Path: <netdev+bounces-82815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D716E88FDC5
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA80289D64
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C33657C1;
	Thu, 28 Mar 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hr8y7ZXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE34A18
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624199; cv=none; b=cJJyXzaYhkfghofOf5a+YK++ZYqasgWrpnGurqbAxywCEU0zXopI0PGVaW7tjkDboYDL3EniUb1flSQyNR0C9FsJi6mHSBB+CHXpPlr7UjQNdPKs7E9cUSP3BdZiKCfGcg0uGb43qqVQN1qTNp6TA3kEddKfQTs8juQOM/3djNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624199; c=relaxed/simple;
	bh=eii91AvqU5izxCTmkNTeDL+/sNBXTL7UgDq/BqZl9N4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WFwna5xUw/w2VJCOPw0lDy5zNuYIzL2G2+R3tf+djUWQg8IInNk6ioo0YoUuIDO66C9U+gJoa3exXaKei6zKSykcG21mi1zoj8WrmOvPFX042rz0UwCfUmOOS5cf0zcBZsD8A7/gsh9MIHot/tFUxvnI3cHza1Y1PGiSApS2Irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hr8y7ZXs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0815e3f9so12891947b3.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711624196; x=1712228996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TDxo39nxktPX80knVMrpE2uJT+uHr8GTxfK68WWyz7k=;
        b=Hr8y7ZXso7/chhjvPIPHjzANIokT3PEqKHt74GOD/3XaSpFhJzAJqsaWB0d+Ghx35q
         1FJTcNlpOJeFrtzC/0A8Gr45wtbjOgM+LaHk5w0Xml22X8QITCtukiqF16P8HhqwTKSR
         IgysHIg2UZekXbP8SVELaUMG8yIBU+IJNxAEu7u+vYZ8AxcvTkAJR62PU9N0Ew/wX3yj
         tAKdSGgQz+a5guiuFPYSyVjEI9LKJnPxcdsWwvR4409wlqgDTCmxdmC+F7y5ER4rn6GJ
         H34WgArX6juRycEixhz748bJL/5fUZh+dL/Ch5bHU4ErV3Nc7L6AS3C34FyxQAyq7z/s
         KnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624196; x=1712228996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDxo39nxktPX80knVMrpE2uJT+uHr8GTxfK68WWyz7k=;
        b=Zo4fgP3DFISjBj/13B3vImjUyZjVGD+EeM4T51fiVJi4Ma4NYq6wFfXw80i7cD1hel
         +LRkQQSBSykG5oc14/sQ4u/MsY4hbTzhbtOs5M4HZPUjV1JtRaKJcsLC3pEH3AptXeYl
         MkHxnhm7qZRZC6WaGYtiqqg2K4T5E6NZyTExr/Tz5YTmrYRHYHzHywhAcAhiPAdyqmMH
         wk6SABj/g1251mHp2T1SyNdwSrvye1x8Gsk1J8quCttUQjN0Oufz2HdO/+u6O9sSTTaM
         fGYHWGuzwyG1sr0kdIt/nbo1dkCfCCFPLHbJITWwd42c9ZBacclyYjcwNVHR7a38hUr0
         evjA==
X-Gm-Message-State: AOJu0YznAuXzfBAN2SVkfoG05nkhBZQZy9EBkfHShhIQ1WPRqE+arIUF
	fuWmMlxlvaZB8oLzAeEKTmDSDsAJChZGeF075Fv0jNJX+ngsIehk436qJIdXYq+vX8XIFCczsUd
	2WQ9CMSuPcg==
X-Google-Smtp-Source: AGHT+IFGIIh8flyu2eMkKjURgoZED8BASejoPuXC/I1ll+X8VRGxMQeDUrrVdkOCV7QeqAh3Utp7MielR9n0xA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b11:b0:dd9:20fb:20a1 with SMTP
 id eh17-20020a0569021b1100b00dd920fb20a1mr192182ybb.10.1711624196498; Thu, 28
 Mar 2024 04:09:56 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328110955.1026716-1-edumazet@google.com>
Subject: [PATCH net] erspan: make sure erspan_base_hdr is present in skb->head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a problem in ip6erspan_rcv() [1]

Issue is that ip6erspan_rcv() (and erspan_rcv()) no longer make
sure erspan_base_hdr is present in skb linear part (skb->head)
before getting @ver field from it.

Add the missing pskb_may_pull() calls.

[1]

 BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
 BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2756 [inline]
 BUG: KMSAN: uninit-value in ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
 BUG: KMSAN: uninit-value in gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
  pskb_may_pull_reason include/linux/skbuff.h:2742 [inline]
  pskb_may_pull include/linux/skbuff.h:2756 [inline]
  ip6erspan_rcv net/ipv6/ip6_gre.c:541 [inline]
  gre_rcv+0x11f8/0x1930 net/ipv6/ip6_gre.c:610
  ip6_protocol_deliver_rcu+0x1d4c/0x2ca0 net/ipv6/ip6_input.c:438
  ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
  ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
  dst_input include/net/dst.h:460 [inline]
  ip6_rcv_finish+0x955/0x970 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ipv6_rcv+0xde/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5538 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5652
  netif_receive_skb_internal net/core/dev.c:5738 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb63/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3804 [inline]
  slab_alloc_node mm/slub.c:3845 [inline]
  kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
  __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
  alloc_skb include/linux/skbuff.h:1318 [inline]
  alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
  sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
  tun_alloc_skb drivers/net/tun.c:1525 [inline]
  tun_get_user+0x209a/0x69e0 drivers/net/tun.c:1846
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2108 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb63/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 1 PID: 5045 Comm: syz-executor114 Not tainted 6.9.0-rc1-syzkaller-00021-g962490525cff #0

Fixes: cb73ee40b1b3 ("net: ip_gre: use erspan key field for tunnel lookup")
Reported-by: syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000772f2c0614b66ef7@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/ipv4/ip_gre.c  | 4 ++++
 net/ipv6/ip6_gre.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 7b16c211b904473cc5e350aafdefb86fbf1b3693..56982d6fb0cd6c39a0e769e130fd47460873b0d4 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -280,6 +280,10 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  tpi->flags | TUNNEL_NO_KEY,
 					  iph->saddr, iph->daddr, 0);
 	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
+
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ca7e77e842835a6d153891fdca7dc8f196e0a2ba..c89aef524df9a2039d223fd2dd7566a9e1f7d3f4 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -528,6 +528,9 @@ static int ip6erspan_rcv(struct sk_buff *skb,
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
+		return PACKET_REJECT;
+
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
-- 
2.44.0.396.g6e790dbe36-goog


