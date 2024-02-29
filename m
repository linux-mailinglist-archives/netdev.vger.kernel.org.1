Return-Path: <netdev+bounces-76162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6686C9E1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F14E1F215C3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D667E10D;
	Thu, 29 Feb 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXI9CIzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817357E58E
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212331; cv=none; b=s74+/FOqjosyVjqYeTueYi/7zBMB4K8ypiYjfx0USCGR5p0SLoEtPXDTZgRGG4LTEZYANCWJ0p439I5hJxHTQRCeMSy/ZYnqp5bNIj1AIei0Avx26AygD9O5iWIPJWxfgs2tDFtMPoYlF+a5mPdOwGikXvKSFuZkrHZE3HFc/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212331; c=relaxed/simple;
	bh=oTFBH+1aNuyRcGEgK5qY1+I0JVxpTup9ufnaj4iKI8E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j9MqFUxfsb+xK7LYvRq9+VTa/kmYaRJ8j4B/gwodgmfqCCKfc8nrdNp2yk+5S3YndCuPn1izt+19wtCI2LKlI8dLv1MHOfJ1saBK1ipAzlTxhZrup7DxPJ/Fgt9ORvHqB8Oc8nQYkX2Xb1osEDnaAsMXzNH3elVa07u/DZSwbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXI9CIzL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so2257197276.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709212328; x=1709817128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E6QBhT0AEzDR8oVzh0nkmW1Xh2m+b3LBhMmYhjkysfI=;
        b=fXI9CIzLpez2M1obwvBlP64LTCRIzjHro3lae+sv/xgYejdlSmON5cbKDxkVfGh+yk
         bf2cuoQpcRluUsTkFZCnx628nT6O1ion+lIiiZELvsk4gdl/fhUbegq1C827flIDG1zA
         FPFUBbgHfxlu0f3bJlRsYp2ic98ExOVWAcjBf/ymJEK4mad6y+5LXmLFkLr83miUA9ke
         kSmYeEe5/24h7kR7nTjEFC+KkZb8Q4/QD4U7QVvDhCA87rBgagGPgMU1J6u8iuf0OuEl
         5+VjTe73B+7GvtT7UnKeUyoGYh3QQPxSQ70UlTwPEXrCDWs/1uUsb4cZ64NSs9sftMR9
         d6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212328; x=1709817128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6QBhT0AEzDR8oVzh0nkmW1Xh2m+b3LBhMmYhjkysfI=;
        b=rTEXEt3SEuGHgxkXnWkVG0KT8UW0Sm8pAJIR9Z5bZzhN6w8PCLxEAoViKbQYllkWuk
         lONo+UEqDCOHaFntHDA8bcD/wwhKbtzZJdUTT6exOMro0TvpbAg1cOAYdqC3a68DZGvI
         M2p/OWJXzGhyAxZQ37erB5NUDcUvoYsoZwg9GCwK0DJ+H73BcB51b6q1IbdNWQ1IkUYq
         22zIXsbYdTmR62PM59j0MiaqPQmkSsT+UsduGKtjSyStRkljMw5pVVzC48dThJlutLp8
         r63+6mGqZQZ3Jkn3o8otEfCvEKaDYhukju+wcUuBIjO6k8sEFh/O1nviZPeKDFyn8LW8
         +tOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhRf8OSy0QQEBj0Tp1Bl5j+ijETN3oK3tuOhYqltcx+ErT2SXmDuJjy4wiUlw6IGrUooWcxaOL9EVnX/akh0wnsLM82OSd
X-Gm-Message-State: AOJu0Yz8lkJS0JOuSDnoaJ0eatedQ90nTImrtmDKTT3ovjQE01TpFaBm
	C4Gkj1Vu2kHpzWc3t4LTIRlYhGGDyuXWfIqdK4lHYZagKnCSei9YGtZY5d34EwYgqHGEV5ummAR
	4A75vxGUsLg==
X-Google-Smtp-Source: AGHT+IEdXaKq04R/IYNGoCcBhANc0HFb0BSPL4I60VhGyZPsB73DUjxoZJFJK3iBqdXDLq4Vecc/ufLB9RNA2w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:110d:b0:dc6:e884:2342 with SMTP
 id o13-20020a056902110d00b00dc6e8842342mr496654ybu.5.1709212328548; Thu, 29
 Feb 2024 05:12:08 -0800 (PST)
Date: Thu, 29 Feb 2024 13:11:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229131152.3159794-1-edumazet@google.com>
Subject: [PATCH net] geneve: make sure to pull inner header in geneve_rx()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot triggered a bug in geneve_rx() [1]

Issue is similar to the one I fixed in commit 8d975c15c0cd
("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")

We have to save skb->network_header in a temporary variable
in order to be able to recompute the network_header pointer
after a pskb_inet_may_pull() call.

pskb_inet_may_pull() makes sure the needed headers are in skb->head.

[1]
BUG: KMSAN: uninit-value in IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
 BUG: KMSAN: uninit-value in geneve_rx drivers/net/geneve.c:279 [inline]
 BUG: KMSAN: uninit-value in geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
  IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
  geneve_rx drivers/net/geneve.c:279 [inline]
  geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
  udp_queue_rcv_one_skb+0x1d39/0x1f20 net/ipv4/udp.c:2108
  udp_queue_rcv_skb+0x6ae/0x6e0 net/ipv4/udp.c:2186
  udp_unicast_rcv_skb+0x184/0x4b0 net/ipv4/udp.c:2346
  __udp4_lib_rcv+0x1c6b/0x3010 net/ipv4/udp.c:2422
  udp_rcv+0x7d/0xa0 net/ipv4/udp.c:2604
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
  process_backlog+0x480/0x8b0 net/core/dev.c:5976
  __napi_poll+0xe3/0x980 net/core/dev.c:6576
  napi_poll net/core/dev.c:6645 [inline]
  net_rx_action+0x8b8/0x1870 net/core/dev.c:6778
  __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
  do_softirq+0x9a/0xf0 kernel/softirq.c:454
  __local_bh_enable_ip+0x9b/0xa0 kernel/softirq.c:381
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
  __dev_queue_xmit+0x2768/0x51c0 net/core/dev.c:4378
  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3081 [inline]
  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  __sys_sendto+0x735/0xa10 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3819 [inline]
  slab_alloc_node mm/slub.c:3860 [inline]
  kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
  alloc_skb include/linux/skbuff.h:1296 [inline]
  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
  packet_alloc_skb net/packet/af_packet.c:2930 [inline]
  packet_snd net/packet/af_packet.c:3024 [inline]
  packet_sendmsg+0x70c2/0x9f10 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  __sys_sendto+0x735/0xa10 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 2d07dc79fe04 ("John W. Linville <linville@tuxdriver.com>")
Reported-and-tested-by: syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 32c51c244153bd760b9f58001906c04c8b0f37ff..c4ed36c71897439fc8f6c11d069c88996e2a2a3c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -221,7 +221,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -272,9 +272,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		skb->pkt_type = PACKET_HOST;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(geneve->dev, rx_length_errors);
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (geneve_get_sk_family(gs) == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.44.0.278.ge034bb2e1d-goog


