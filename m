Return-Path: <netdev+bounces-82826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F988FDFB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC71F215A3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98C56776;
	Thu, 28 Mar 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NISt0/Xd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D646549
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624972; cv=none; b=kMXpMcYiTYtfisk/ig/4NnI73mQu6bMbIzuVGs/jdajxw6MaeYE6F4LZHkZEUAT8lwcry3Z/D+onEvAXFd15Hrm1ZCKjSSktmAl8EWW3l/KuhDzS+xUm5TeQMitpprgIPqzuwwCddqA4eCY2bJJ7AiVxc6p1XjxMPm88RE61MbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624972; c=relaxed/simple;
	bh=7PGV55uxWvx9uWHP+aQwPJgK5jvJF/9ILxLrW0nNBbQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mbsAs9n5+GwAN6z59VKOkMfui6LGrxEmEN+br8oXuN8aRVpFpEOskzOpfTlkZP75YKucnOhm3Hs0BKEQZm0imLEFCEib+tH6grsvghGT5zKGCHPW359bSHkCG7bWVDZV9+tLUInGQrI1+2u08glFULG55Q6DaNqgC+3KCNUa620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NISt0/Xd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so15163087b3.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711624970; x=1712229770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mKhIpgR1oVXQWsU/MpHaGnHIXxWfv9ksxSChP2NZaEY=;
        b=NISt0/XdgvAdajo03gbrNgQlx4Y8njX9eT/1QRgOFag29RXyq4EMVSyROea7Rx/obr
         eccrqagenSSaeafBHNsG2TzTDg2HpCa19cDIxoCe3Dj0vt/uvSl6Hz2M+n6ShWxlc+Wq
         dkf2afF12jN1yAFShMVV89b4xTkWW0jU1DDDlLKaRZLMVAKfBkiiFdOgK+PpG5vrUlaG
         Z5E++zjSY4dnuZiOucCDR9cBl1aHg1wfcCI/tcIn9Wn+on8oWNumAsCm+JBifApB4Y9Z
         47xl33jfV5sId6c7hKIEaRm8ajkVRL/q4xYVuh/SmGfK5IZZAud9Ut4AOftZbWmc73Sr
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624970; x=1712229770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKhIpgR1oVXQWsU/MpHaGnHIXxWfv9ksxSChP2NZaEY=;
        b=b1ewQRehp1cYCAgOfNbGAc5WoFbknfX40B4e3zJvIMXrdy1Jct/p758LA3Rxy69q1y
         S1/4Kd9PtKRWPTuN6c45IfesqgJ3JRydowuV16OwkcUn5HRF2hJcdVMXZfzx6okHFcCn
         KchMolQvMtbVwSGKgWj1tE3/i8+Qs/t9TbTqXFhQoD5R2nBldRH6JQonds3xuxbEvdlJ
         17b0ipMkB6da6FNI0EX+e/yA/IzXp9Lmd/hNj28Wf3zj5+hjovSy6C6zqc4l8wE+0qiB
         hgr+lZW4uZNGkd+abPjzrtFwiwGx8xp5frXQiUGpFPC7TA/AnIWxXuXlDR8v/ECk28w2
         xzmQ==
X-Gm-Message-State: AOJu0YwGfpnnt/IaQFUEcJBJ1gJcnpHHmm4+XDTUqcp69J5B/DcQtjRv
	BM/Juy8nJuV3Z61EE3xGFN1z4jWkxEnaxtd7Dlr1RB2fOHDJjJ/b04TINzhHG/uL3+zQhkS1oMG
	XXwKZJI3jqg==
X-Google-Smtp-Source: AGHT+IHYS7AjHg/LUHZzXMJx3g3W6FFFIVEvkVi9uDtiM893LBen8UkwAgYYRdxi12dBJ3T6pSbEMfxPSwFLIQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b11:b0:dda:eee6:8e52 with SMTP
 id eh17-20020a0569021b1100b00ddaeee68e52mr844252ybb.7.1711624970434; Thu, 28
 Mar 2024 04:22:50 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:22:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328112248.1101491-1-edumazet@google.com>
Subject: [PATCH v2 net] erspan: make sure erspan_base_hdr is present in skb->head
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

v2: Reload iph pointer in erspan_rcv() after pskb_may_pull()
    because skb->head might have changed.

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
 net/ipv4/ip_gre.c  | 5 +++++
 net/ipv6/ip6_gre.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 7b16c211b904473cc5e350aafdefb86fbf1b3693..57ddcd8c62f67e493b74634a793592fcd259e04e 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -280,8 +280,13 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
 					  tpi->flags | TUNNEL_NO_KEY,
 					  iph->saddr, iph->daddr, 0);
 	} else {
+		if (unlikely(!pskb_may_pull(skb,
+					    gre_hdr_len + sizeof(*ershdr))))
+			return PACKET_REJECT;
+
 		ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 		ver = ershdr->ver;
+		iph = ip_hdr(skb);
 		tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
 					  tpi->flags | TUNNEL_KEY,
 					  iph->saddr, iph->daddr, tpi->key);
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


