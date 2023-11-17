Return-Path: <netdev+bounces-48693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E038F7EF449
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7083DB20ACB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E00328D2;
	Fri, 17 Nov 2023 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGzpLw5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB0D5B
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:17:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso2543708276.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700230655; x=1700835455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q672V32c6aOkNy0wM1VkDi/b7qHbgbgk590/M+FBRgw=;
        b=QGzpLw5ORn8WDOjysE2WEzIdc2xGD+8FBtamAGtjh7UFhE7qPQrubtUZaPswY2UK9e
         QFXoP+MuqjGIToB9Z5HTqVuMiP3g/J7VRXtcFndApb1rrnpKUnfR2vHmS0sbMGxqLZGu
         d6q97UnknReYUbb9AWxLLNzda9HVIybftBez9LW46uMvjmLDCAIcv+bIGyONJ1guTdEf
         xueiP3d5NYmwAss2RsHhnERQyD70fvkUmGT0jcR7/pzUgB4ad9uZih7mX+jVlOr8Hbz/
         YPdQvUDpELyCJhhY29a/V4wps5GZX6RjOaL858qBv5cup2lekbRdHM0VHh4xz4bpKhpo
         iBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230655; x=1700835455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q672V32c6aOkNy0wM1VkDi/b7qHbgbgk590/M+FBRgw=;
        b=DMqWvFxbdMbegLh8XHpSLobf2iOcsFqryVA2x9lPqUeoCMdDLR/Ul1HpE+ppYQpxFL
         kGftTo9vuJWL3bLNk6H8NvScYXWwRNwZIqBo50DtDpSk+JitSj/ihU0hXJME4iTZbYow
         cHS8quLEI1Pqr5A0F2NQ3GTmX2SQip2rEd0zOmXJRy1ufUck/et9i05l+u9+7yVRMSgn
         FE8Wx2IVXEGk81moT7X//S9nRM7kNCSgrz0PMa8OumgWPGUrbod8rH4XPBaVpz3ADLKw
         lHCPSKrLC5uiqfS1YhUAP3xDy0ri5oLrKuYkEY4gwecPW/1pcGVRbibCETT/qSqTiL3D
         sFuw==
X-Gm-Message-State: AOJu0YxGbLtqT29dxoxCMX2O+aU7G/q9jpGXVuEHtBq0EFA1EIMFyokG
	Dhm6fLuo+7lW2oUAqyKq6SrKFFuqXMoUaQ==
X-Google-Smtp-Source: AGHT+IHCpgbvNbLch0DLjexV3V/FVPkie7esmivC+Mv23HobcABjo09NMOx++eE/Rk5AsYFpQ1zsVw9zfBiYSQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:206:b0:d9a:e3d9:99bd with SMTP
 id j6-20020a056902020600b00d9ae3d999bdmr452862ybs.5.1700230655021; Fri, 17
 Nov 2023 06:17:35 -0800 (PST)
Date: Fri, 17 Nov 2023 14:17:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117141733.3344158-1-edumazet@google.com>
Subject: [PATCH v2 net] wireguard: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

wg_xmit() can be called concurrently, KCSAN reported [1]
some device stats updates can be lost.

Use DEV_STATS_INC() for this unlikely case.

[1]
BUG: KCSAN: data-race in wg_xmit / wg_xmit

read-write to 0xffff888104239160 of 8 bytes by task 1375 on cpu 0:
wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
__netdev_start_xmit include/linux/netdevice.h:4918 [inline]
netdev_start_xmit include/linux/netdevice.h:4932 [inline]
xmit_one net/core/dev.c:3543 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
...

read-write to 0xffff888104239160 of 8 bytes by task 1378 on cpu 1:
wg_xmit+0x60f/0x680 drivers/net/wireguard/device.c:231
__netdev_start_xmit include/linux/netdevice.h:4918 [inline]
netdev_start_xmit include/linux/netdevice.h:4932 [inline]
xmit_one net/core/dev.c:3543 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3559
...

v2: also change wg_packet_consume_data_done() (Hangbin Liu)
    and wg_packet_purge_staged_packets()

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/wireguard/device.c  |  4 ++--
 drivers/net/wireguard/receive.c | 12 ++++++------
 drivers/net/wireguard/send.c    |  3 ++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 258dcc1039216f311a223fd348295d4b5e03a3ed..deb9636b0ecf8f47e832a0b07e9e049ba19bdf16 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -210,7 +210,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKETS) {
 		dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
-		++dev->stats.tx_dropped;
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 	skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
@@ -228,7 +228,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
 err:
-	++dev->stats.tx_errors;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return ret;
 }
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 0b3f0c843550957ee1fe3bed7185a7d990246c2b..a176653c88616b1bc871fe52fcea778b5e189f69 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -416,20 +416,20 @@ static void wg_packet_consume_data_done(struct wg_peer *peer,
 	net_dbg_skb_ratelimited("%s: Packet has unallowed src IP (%pISc) from peer %llu (%pISpfsc)\n",
 				dev->name, skb, peer->internal_id,
 				&peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_type:
 	net_dbg_ratelimited("%s: Packet is neither ipv4 nor ipv6 from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_size:
 	net_dbg_ratelimited("%s: Packet has incorrect size from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_length_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_length_errors);
 	goto packet_processed;
 packet_processed:
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 95c853b59e1dae1df8b4e5cbf4e3541e35806b82..0d48e0f4a1ba3e1f11825136a65de0867b204496 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -333,7 +333,8 @@ static void wg_packet_create_data(struct wg_peer *peer, struct sk_buff *first)
 void wg_packet_purge_staged_packets(struct wg_peer *peer)
 {
 	spin_lock_bh(&peer->staged_packet_queue.lock);
-	peer->device->dev->stats.tx_dropped += peer->staged_packet_queue.qlen;
+	DEV_STATS_ADD(peer->device->dev, tx_dropped,
+		      peer->staged_packet_queue.qlen);
 	__skb_queue_purge(&peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog


