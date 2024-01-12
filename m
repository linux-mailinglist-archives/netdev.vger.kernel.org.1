Return-Path: <netdev+bounces-63258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2E82BFC3
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F41B23C3A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A66BB31;
	Fri, 12 Jan 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGFAaYgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51E96A02A
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e617562a65so121141247b3.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705062497; x=1705667297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Bga0YpPLMBHaia2rFV9M5TpJ+mq6cLrQmgk/RtvnSE=;
        b=MGFAaYgbE5Fd1iMUkolt2DZJwNi7MXGbgDqcin2Ef/ks8WS7hilNolmLwYgu1qI490
         l9ROOTtRGwaZhWgZDNPp8R7gwTpuW0AV9HxtcTT1+d4IqAmkL3dVF9b22ntmpRQPkJt8
         57XplTYwj8EoJ+xM4ZxFfD10wmI+KWLhaKW/7PwCusH8X3SQvgmhwlS7HqaeOKoIeaeO
         9Gnxu13olM+Ohik4ofP/uwVA2ODS09tIgQdmKOGwl4XupwVX4gqHIswZUM1fKdGXa8oc
         uJi5QhYL11+ebYgiG41g/Bft9bdZN7wDJzDN98YKu2c42TzBz+ftpJW8Q158EBRe3Cnw
         P9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705062497; x=1705667297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Bga0YpPLMBHaia2rFV9M5TpJ+mq6cLrQmgk/RtvnSE=;
        b=qwGkURDIdx76quTqgOMBEwILZ4QgJuNKWJoGrxAbzTfULK2DiQUPq63yecGw5sGMyR
         M1I7P5hjLStOazPCpqAlYwSlZKzNhw2FIoRrBhcolDnPva0S17Xwca3SW3kikvqbfVZM
         SmDGYG1S4dx3OxGERY7LYERpN8o4hR6Xtf4yRMIwyQtMywW8BmfHH4YNax7qn3q+hyM6
         B2f5eLYGn4ht2ClTWzuT9Za12kkCOWjzVCMSkf1ALMyqSuANC2eHXPLOmyAe32Bb8I5A
         ROugbhnWKxLStnNfMVpLqdwerOswT9vmz6jeVfAsp2KgQ8JjwE7+sGG8IXaH21dWQVM1
         XJ7w==
X-Gm-Message-State: AOJu0YyiehRyUNFNEkRc6eBTq0ZFTRGa0b/qB7ZMQKclBSqkf4UC6JBm
	Yf5nuuLV5I/GWNTZwslPfvm4+v4yI2f+RDZpUnv8
X-Google-Smtp-Source: AGHT+IE/7lKkl8rIZxmEPu6Rk0SzN7cB6jJgEcG2iXo8/3qOpzSr5w3p4fdhwc+lWRAvyYDIhCWcptZO9cLtiA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2286:b0:dbe:a31e:712d with SMTP
 id dn6-20020a056902228600b00dbea31e712dmr284792ybb.11.1705062497680; Fri, 12
 Jan 2024 04:28:17 -0800 (PST)
Date: Fri, 12 Jan 2024 12:28:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112122816.450197-1-edumazet@google.com>
Subject: [PATCH net] net: add more sanity check in virtio_net_hdr_to_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot/KMSAN reports access to uninitialized data from gso_features_check() [1]

The repro use af_packet, injecting a gso packet and hdrlen == 0.

We could fix the issue making gso_features_check() more careful
while dealing with NETIF_F_TSO_MANGLEID in fast path.

Or we can make sure virtio_net_hdr_to_skb() pulls minimal network and
transport headers as intended.

Note that for GSO packets coming from untrusted sources, SKB_GSO_DODGY
bit forces a proper header validation (and pull) before the packet can
hit any device ndo_start_xmit(), thus we do not need a precise disection
at virtio_net_hdr_to_skb() stage.

[1]
BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline]
BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
 __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/netdev/0000000000005abd7b060eb160cd@google.com/
Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 include/linux/virtio_net.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 27cc1d4643219a44c01a2404124cd45ef46f7f3d..4dfa9b69ca8d95d43e44831bc166eadbe5715d3c 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,6 +3,8 @@
 #define _LINUX_VIRTIO_NET_H
 
 #include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -49,6 +51,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 					const struct virtio_net_hdr *hdr,
 					bool little_endian)
 {
+	unsigned int nh_min_len = sizeof(struct iphdr);
 	unsigned int gso_type = 0;
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
@@ -65,6 +68,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			gso_type = SKB_GSO_TCPV6;
 			ip_proto = IPPROTO_TCP;
 			thlen = sizeof(struct tcphdr);
+			nh_min_len = sizeof(struct ipv6hdr);
 			break;
 		case VIRTIO_NET_HDR_GSO_UDP:
 			gso_type = SKB_GSO_UDP;
@@ -100,7 +104,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
 
-		p_off = skb_transport_offset(skb) + thlen;
+		nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
+		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
 	} else {
@@ -140,7 +145,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 			skb_set_transport_header(skb, keys.control.thoff);
 		} else if (gso_type) {
-			p_off = thlen;
+			p_off = nh_min_len + thlen;
 			if (!pskb_may_pull(skb, p_off))
 				return -EINVAL;
 		}
-- 
2.43.0.275.g3460e3d667-goog


