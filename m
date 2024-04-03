Return-Path: <netdev+bounces-84547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3A897408
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F9D1C24052
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD8148FE8;
	Wed,  3 Apr 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeyZV1U1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429431494D3
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158221; cv=none; b=JYEwB8iZIqwQoAas7fbs4ylZ16Eokiic1l865JM2kkU4Mi3jNH6Sy6qUOaVrA3z3DpFwX6qIE90xIuXSfOYi62y9w3SGxmRy2pR5KRVmXK2ou9lbe7rVzbedHYtVNkpucagQBmNqdPHeLW4usf+uB2R7Gc4GIc1oJYAWUGdcRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158221; c=relaxed/simple;
	bh=fvBm/Ng5BGeiYEoTwmU52XnJR3tnGyQZxkdPnBnZmtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EwBVKW9uHLNFMEK+7aTKdXHO7mN7HMgjChJfw6UbqJ3lHlqznInjRfClnEdqw8nCO2FrAOFfKY8TNqfkEjiiH4QY1umvJ9oxGXz+hioIODlRrofS91QqIIVQgb8p+LrC/+Vzp/MDVzQ4I25e/G9CLgAhisaXfHG74ZPNFbMMi6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeyZV1U1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60ff1816749so96505197b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158219; x=1712763019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KKLYXBPRIABpF/84xTaN9PdiIJ2LKsuEOBkvgWSBE88=;
        b=YeyZV1U1Q5a3tlJBQlTljnwBOJuKUidNO+O4NInPZmyP9urDb2zQTWC0zF6Ff0OFI4
         u9tjwf9pkpjUinuaUATI0+1wIbq3jIE0ZUN2XMBlTpWdHAI6BuBJsr0x3Lboo5l3naCJ
         kgBozirCpQsOWUGjhK1Tzk09XEq/OYGXDPAqoHC184yFbvjVeJWMBrZ++RC8fijD91dY
         psvAyUDBi76LF2QVDhNiUZ68eKy9WcKuUVgJipVn7KxPJIHfToqwwG0GJVIuPgOC4jcs
         y2t9votfiDoCRTqSU4Zg3ihET5wS94QSIT9VjqoKlfzVgJPe4rCYgpVvtyjB/YPxsJXp
         EorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158219; x=1712763019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKLYXBPRIABpF/84xTaN9PdiIJ2LKsuEOBkvgWSBE88=;
        b=POq79XDADpz2td4uNUvc0uHqMiISV8+RR2DloLi2IrIZpq/+tgNS1BRR/sZ0/VvH1Z
         sZtYnKH6FxNr+easAJao85z+FKeSMhu/ggUZqiUfaKsJwEPmZcw+1Shtm6Pc82gFn2m7
         omsb7U4P9CWG0pW6cA9jMmMLU7wedRv6rmtdthYE/oXI8YpV32wrmLFQoxtx8GWUXZ66
         C0sQKhHqyFrXimUE/+SKqCtwBfN85eL3N4J+Dtssox2U1huY8/1F5r4wonf9R0Xj/MWN
         BEsi8Zlys6uAtXFqY+ag+mJhbq+dHzT1pyJ4OucHJiWnGMPzC2MJ/+5jOfBQyPD+lz3Z
         T5PQ==
X-Gm-Message-State: AOJu0Yz4Wkmr7Z7STjAOqxuPcJK/gNX/7SK0K7DEsTbn0t2ITDkAQ9n+
	dQ7Tvv0FVvZRn32MPEWtzEbzQt/T3jfywVXm+M9tGDZTbmFDNLw5Gbi6NuDAtSbklOtI/VpOikO
	wb9MY4V32Sw==
X-Google-Smtp-Source: AGHT+IGHwENCFb3gFpbzCDbX8mkblBTu7sNzbweZxsJ9m/SHWIoTGUSNU/WDqb4hwtp2CSPRmFRhygowMUdkdQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1ac9:b0:dc6:b813:5813 with SMTP
 id db9-20020a0569021ac900b00dc6b8135813mr1071780ybb.9.1712158219177; Wed, 03
 Apr 2024 08:30:19 -0700 (PDT)
Date: Wed,  3 Apr 2024 15:30:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403153017.426490-1-edumazet@google.com>
Subject: [PATCH v2 net] geneve: fix header validation in geneve[6]_xmit_skb
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"

syzbot is able to trigger an uninit-value in geneve_xmit() [1]

Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
skb->protocol.

If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
pskb_inet_may_pull() does nothing at all.

If a vlan tag was provided by the caller (af_packet in the syzbot case),
the network header might not point to the correct location, and skb
linear part could be smaller than expected.

Add skb_vlan_inet_prepare() to perform a complete mac validation.

Use this in geneve for the moment, I suspect we need to adopt this
more broadly.

v2 - Addressed Sabrina comments on v1
Link: https://lore.kernel.org/netdev/Zg1l9L2BNoZWZDZG@hog/

[1]

BUG: KMSAN: uninit-value in geneve_xmit_skb drivers/net/geneve.c:910 [inline]
 BUG: KMSAN: uninit-value in geneve_xmit+0x302d/0x5420 drivers/net/geneve.c:1030
  geneve_xmit_skb drivers/net/geneve.c:910 [inline]
  geneve_xmit+0x302d/0x5420 drivers/net/geneve.c:1030
  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
  xmit_one net/core/dev.c:3531 [inline]
  dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3547
  __dev_queue_xmit+0x348d/0x52c0 net/core/dev.c:4335
  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
  packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3081 [inline]
  packet_sendmsg+0x8bb0/0x9ef0 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  __sys_sendto+0x685/0x830 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2199
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
  packet_alloc_skb net/packet/af_packet.c:2930 [inline]
  packet_snd net/packet/af_packet.c:3024 [inline]
  packet_sendmsg+0x722d/0x9ef0 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:745
  __sys_sendto+0x685/0x830 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1d0 net/socket.c:2199
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5033 Comm: syz-executor346 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024

Fixes: d13f048dd40e ("net: geneve: modify IP header check in geneve6_xmit_skb and geneve_xmit_skb")
Reported-by: syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000d19c3a06152f9ee4@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/geneve.c     |  4 ++--
 include/net/ip_tunnels.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 2f6739fe78af2e8e90c0a3b474c2e99c83e02994..6c2835086b57eacbcddb44a3c507e26d5a944427 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -822,7 +822,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	if (!gs4)
@@ -929,7 +929,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	if (!gs6)
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cd64bb2104df389250fb3c518ba00a3826c53f7..54c87eab769e8b8e7c9f98a9c21c7e922d1ca3c6 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -361,6 +361,41 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_network_may_pull(skb, nhlen);
 }
 
+/* Variant of pskb_inet_may_pull().
+ */
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
+{
+	int nhlen, maclen;
+	__be16 type;
+
+	/* Essentially this is skb_protocol(skb, true)
+	 * And we get MAC len.
+	 */
+	type = __vlan_get_protocol(skb, skb->protocol, &maclen);
+
+	switch (type) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		nhlen = sizeof(struct ipv6hdr);
+		break;
+#endif
+	case htons(ETH_P_IP):
+		nhlen = sizeof(struct iphdr);
+		break;
+
+	default:
+		nhlen = 0;
+	}
+	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
+	 * a base network header in skb->head.
+	 */
+	if (pskb_may_pull(skb, maclen + nhlen))
+		return false;
+
+	skb_set_network_header(skb, maclen);
+	return true;
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
-- 
2.44.0.478.gd926399ef9-goog


