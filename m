Return-Path: <netdev+bounces-84423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44389896E54
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674661C253DC
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7EC141991;
	Wed,  3 Apr 2024 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovY4ZbXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EB73506
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144337; cv=none; b=X/My/Hnv2pg4fJQ2mfjYTvGDCbGgHMiTADS0Ktfy07pV0qBT7mPyaKDksXeSfbrYivjBshZVvb9rn2HGo0EY+56clkoa6poM69MNZJK566otI328Fki3deKONn6DVhXYkzRjSqWFEE03I88olgOBeVodU4GB5lFMsUfBSu2Juok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144337; c=relaxed/simple;
	bh=RoTBXY8tt8di2P7Gsp3f2sX1N4FJAGDheM1L6+5mqms=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CoY4WWvk54CVtL6kIoNrf3rDgQmQJ1syxhFiTucXYYNTp/2wklYoGu7nqZtIZL/NPrxtscn2t7VNNKzzAq18WKdLuWeyE0TJ2C2QpvszIbVca8TwohluryDwTm52zhLgJ+Crl4VVGzMkw/WNnuECLTUdSrxs0LgQHthjVbYKaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovY4ZbXD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615372710c4so21519737b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712144335; x=1712749135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ucl0Gv9qrqJz3HF/Wp/Tu9m2p61bezEAQ9mGwD3UQYY=;
        b=ovY4ZbXDthIuTD2Q4Zt032EIzMFf7HVRmQezznnfCMLBAEEqAf3z9US6TNmz5cBO4K
         Xc61gAm5GztvIM+5mPoydDVZXJh+tHcbylVZsj1Vx/AIHu5TdcttfcdwS4mzF4o9RNre
         JxMtE04yC/lDSr7Kq5ebOu0dSV/Fcu39j3nGXD04Wz9jeDjsKMI0jq40da3u71bSO7le
         yK8YcQbfULyz55H4EuMv8Z2GNC+PeqXK1KFu1eqeXrQ9o0mL8WjxBxJYLVe7T2Wyev78
         VYOmMeo3zgqbQjf3TCfy8/N8hHY4Muiiw1YBEO/Fik7Si5FLqwM76dy4R+HJ861sEsaY
         pkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712144335; x=1712749135;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ucl0Gv9qrqJz3HF/Wp/Tu9m2p61bezEAQ9mGwD3UQYY=;
        b=UpWAkSwTnz8QluQIGFfNBmIaQux9tk0qqsNI5BCqezJtTLWhK9WIT2qprt7E32PdaY
         Mvn1ZQar+N/vQIL3uec2iRoe5KjmDjR1pZrij6EowbymdpzNUFqFRMXW/LXOXC4h+YwX
         NYgrYyiftp25pOn0HUWnEJNUSXbZH1FR/ZJWCrAtnEUABb6H0a981Ar449LL6srYuaK2
         Ki9xS57GALsWNZPnj0RVDx4E1CAG0nvZUOT5282YuEeJCvwQFlu8KZKlzmddjv2DpU9X
         NdrnIwr8wZH/7tek/6L3/6Zqbb/smfND/WMLdrhckOWPmaPR/dV2YLZJcUiiFloQKsqd
         dqAA==
X-Gm-Message-State: AOJu0YxpT2lOi3ohBghZIShyJlcmn05Ui7+8i5aUueHEGTpZXn3MGx+H
	jhAp9xfQSDFADqWHuzZ5S3lcNNSKb6WzdH9YrAZkRlRd4oTTtJFnNmV+QfrzfrshwY6DQU/b8js
	Yf8EtgzBXeQ==
X-Google-Smtp-Source: AGHT+IEo+YkrSJGQ5GjHJxzQS81n37ul0YJ0ZTcdt0Ow/uJufBAtp8vC4JdKQIPkvPhiv+rXcX2M998A4UiEpg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:161a:b0:dc7:4af0:8c6c with SMTP
 id bw26-20020a056902161a00b00dc74af08c6cmr1025754ybb.6.1712144334804; Wed, 03
 Apr 2024 04:38:54 -0700 (PDT)
Date: Wed,  3 Apr 2024 11:38:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403113853.3877116-1-edumazet@google.com>
Subject: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>
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

Add skb_vlan_inet_prepare() to perform a complete validation and pull.
If no IPv4/IPv6 header is found, it returns 0.

Use this in geneve for the moment, I suspect we need to adopt this
more broadly.

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
---
 drivers/net/geneve.c     |  4 ++--
 include/net/ip_tunnels.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

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
index 5cd64bb2104df389250fb3c518ba00a3826c53f7..41537d5dce52412e15d7871ec604546582b10098 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -361,6 +361,37 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_network_may_pull(skb, nhlen);
 }
 
+/* Strict version of pskb_inet_may_pull().
+ * Once vlan headers are skipped, only accept
+ * ETH_P_IPV6 and ETH_P_IP.
+ */
+static inline __be16 skb_vlan_inet_prepare(struct sk_buff *skb)
+{
+	int nhlen, maclen;
+	__be16 type;
+
+	type = __vlan_get_protocol(skb, type, &maclen);
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
+		return 0;
+	}
+	if (pskb_may_pull(skb, maclen + nhlen))
+		return 0;
+
+	skb_set_network_header(skb, maclen);
+	return type;
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
-- 
2.44.0.478.gd926399ef9-goog


