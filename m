Return-Path: <netdev+bounces-65944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0A83C985
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8533228D1B0
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486B481CB;
	Thu, 25 Jan 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqjiHPoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A14130E48
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202365; cv=none; b=PN5PpTGaVGsmu8go7wWf417cSdMKqFFX22pILA3bNP0BC0CGLRL4j/Vmb5DOhjfN3BUbcAvM0EkC2XeWa6yIr8Ysg8HdLM2xUi/HoLefbCZ5YdnynDNYhWZSo51gR7KApl3ApEG8kTJabUNNFG4QGHFLVZ9SvQNMUQckNttNloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202365; c=relaxed/simple;
	bh=3q6K306e+o6cuaRLWQxBM7YeXzXJ7PSvaOb4bEE4wVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YJ4zNIwo7xCGdiQRHNp1RUuab0GVZw9UX84P2l+4oLN20GfQXiO2X+8za39YrgchXQkSToFW/Zv0XfhLhDfOa5dDK5LIjJhpj/jzaNevjem/nyljVp5PKWdduuzyQzwWSzCpoq9/UPYflmhR/zTtyc0R6gku9sGKASNRPcc711M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqjiHPoR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc237543b74so8825018276.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706202362; x=1706807162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CCj0lpiyAlN+5eqKQe9RcZhhQlqR8KA9QxE5fc/7fMI=;
        b=rqjiHPoRrKtnaHnBTj2wDOoihyzXJexjmtETrIQrUTUwh6YNtkVK5gDryQGtpQZE1N
         5n4ntKOYiR96f8mvMm5A9jlRQlbqLm3CSKViCojpQVnhv4Lq2CMPOyi6mEMymb6jp1Wt
         hs1ipO2/l4OaPjrv67x2WlJ0raKBNH/6WFZDs/jAQi7ybQQid3A4Li5zEU99xLIQMDX7
         OfmJ7f/snLO+f/19uVnS/4IRidh08P6JRgvyPg3rm687hXghtGaedaRAIDX64egsxEdD
         XWrF8gd2KL0leQBYP8X8INMId2z6wgRalVyk3G97D9x30t53kZX3uxmU1aS5E7yNXlQX
         nNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202362; x=1706807162;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCj0lpiyAlN+5eqKQe9RcZhhQlqR8KA9QxE5fc/7fMI=;
        b=WdVemib6WTtFu45Fto1kKjTjrlioaxWyNXspow0lqdBmDZma2RNIRlyMcvVVTH1rQs
         oRCOEWinb3FkyOLasgfJ9OoK0Sw6Si5Y/LJOaJORulapobX5qCPvtKxoAkQ2OUOq7r6q
         PO9LFD4qHQlQVRuD1mLQ5ZHWJ5FnLHL/zs2Fayq4hGo3xaKCBRhsVNJyiOnzsI7QUdv2
         Hs897VLIgD6dPegKONBNgBgWbLLj760u9t/S+ocGz3fvzpMmWYZGq7mhv20hAfhmeK5/
         T8V68tUMS9tsNmDB6lWXYMNfh0NEcbO8YYHo952ldH+uApHgeNGBNW+mR7GlRDkcl6zL
         MI5w==
X-Gm-Message-State: AOJu0Yy3c83NKnenZItO2whUloF2s6xy+Ru6m94xO96B5UBKWhtthHmB
	JD2e51paTrNUM82ESRYaVUtsg8oxnLD6sMEXGUZj6YcGEWWt83ddL7SPWyLsr+k+QjnzfKp6vCP
	fFLetcWsgNQ==
X-Google-Smtp-Source: AGHT+IGh54ieWwkZxUJRLNmpqvtwOAbT4Xj4MXDcSgnWenL6kH8fxJ3mi/rllWTJzsnAzKlhLEGKiLhjJHJ3GA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2587:b0:dc2:5273:53f9 with SMTP
 id du7-20020a056902258700b00dc2527353f9mr13702ybb.1.1706202362462; Thu, 25
 Jan 2024 09:06:02 -0800 (PST)
Date: Thu, 25 Jan 2024 17:05:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125170557.2663942-1-edumazet@google.com>
Subject: [PATCH net] ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found __ip6_tnl_rcv() could access unitiliazed data [1].

Call pskb_inet_may_pull() to fix this, and initialize ipv6h
variable after this call as it can change skb->head.

[1]
 BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
  __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
  INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
  IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
  ip6ip6_dscp_ecn_decapsulate+0x178/0x1b0 net/ipv6/ip6_tunnel.c:727
  __ip6_tnl_rcv+0xd4e/0x1590 net/ipv6/ip6_tunnel.c:845
  ip6_tnl_rcv+0xce/0x100 net/ipv6/ip6_tunnel.c:888
 gre_rcv+0x143f/0x1870
  ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
  ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
  ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
  dst_input include/net/dst.h:461 [inline]
  ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5532 [inline]
  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5646
  netif_receive_skb_internal net/core/dev.c:5732 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5791
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
  tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2084 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x786/0x1200 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
  slab_alloc_node mm/slub.c:3478 [inline]
  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
  alloc_skb include/linux/skbuff.h:1286 [inline]
  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
  tun_alloc_skb drivers/net/tun.c:1531 [inline]
  tun_get_user+0x1e8a/0x66d0 drivers/net/tun.c:1846
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2084 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x786/0x1200 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5034 Comm: syz-executor331 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: 0d3c703a9d17 ("ipv6: Cleanup IPv6 tunnel receive path")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_tunnel.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 46c19bd4899011d53b4feb84e25013c01ddce701..9bbabf750a21e251d4e8f9e3059c707505f5ce32 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -796,8 +796,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	int err;
+	const struct ipv6hdr *ipv6h;
+	int nh, err;
 
 	if ((!(tpi->flags & TUNNEL_CSUM) &&
 	     (tunnel->parms.i_flags & TUNNEL_CSUM)) ||
@@ -829,7 +829,6 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 			goto drop;
 		}
 
-		ipv6h = ipv6_hdr(skb);
 		skb->protocol = eth_type_trans(skb, tunnel->dev);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	} else {
@@ -837,7 +836,23 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		skb_reset_mac_header(skb);
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	ipv6h = (struct ipv6hdr *)(skb->head + nh);
+
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 
 	__skb_tunnel_rx(skb, tunnel->dev, tunnel->net);
-- 
2.43.0.429.g432eaa2c6b-goog


