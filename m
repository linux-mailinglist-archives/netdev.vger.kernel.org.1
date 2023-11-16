Return-Path: <netdev+bounces-48269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B107EDE16
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F0C1C2090B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C35EAD4;
	Thu, 16 Nov 2023 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yvyu7QSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072D189
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 02:02:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so769068276.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700128938; x=1700733738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QoeflHPTX3YDq7hFqq6GAvQzQfG+wy5mKb5LRYXduA8=;
        b=Yvyu7QSbidbdbrmfyOUQMQa6MMvmRYj0DTilWUZ/j4iYKGisPQp/CnoREqCVNPcw4u
         je/UTIxnXLEaCeyTiR4/odRDplJt6HwUT2JICYYghEc9lV6lN4FVuBDqXSUXW6781zr3
         y1YiZl4pSDnqQyMAl4q0GWw1QGRAmZ0pdBBs9DPzRDk9orvkm07xSR/8ONuh7yWsYPxM
         4MBC9j5k1R3t3XiB+cKHjJ5Rmh+18h7WzCHnxjdjVVkqaI+AHcDr67LUggpHd+87dMip
         icn1GDyR29dlphEWZg6pQ3cBk23lGU5tnMQGxyAHGNGMfcOWAo0o5bMmFAXSa/9cYX59
         pX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128938; x=1700733738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QoeflHPTX3YDq7hFqq6GAvQzQfG+wy5mKb5LRYXduA8=;
        b=pP6lQIZ4ebFPV7ogrgzN4yzD3vu17dr3uAqC0kVwtpYk2AgXp28PcqayFSgoGmQ5CI
         dICAwhxA3Wq7K/5TxOxkyUa0ZWzp4QLV8oSLKTzsAQoRGw97jldoRIH9RbXnmFETWh3a
         zC0Nio69QHL9/4R1bw96Wt6X+u+0Owd+cxeDNGpIWfTjnekY8do0XILqTrikI9Mqw3iE
         +JspokOx337N074xA62ZmceQkM4MLTCcSwKw3bTiXNI4k6QOBVEOn3ZwB57ZtYnLb9b6
         DNRmb7vpGm0mPqsZvIzh9a8ehpGCXBlW7JE0U0G8B62VHwUOv6s7yRoOAItA1h44mI3R
         FvNg==
X-Gm-Message-State: AOJu0Yz3yDw6cwGawIN+TPhNZAOyjDZbEPzch91wYhyS/2kUEzUam+jO
	XuCzFFl6FYi3vmWVHetMzCZHKPgblW4PHg==
X-Google-Smtp-Source: AGHT+IGqGmA5p+nUSZR/UPoSTSoArr/AtQBqfXtcIvleJFs0CPPxFARzbbbplgWnt1RPs9NRRrbEvIqB0a9XTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:302:b0:da0:567d:f819 with SMTP
 id b2-20020a056902030200b00da0567df819mr375186ybs.10.1700128938691; Thu, 16
 Nov 2023 02:02:18 -0800 (PST)
Date: Thu, 16 Nov 2023 10:02:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116100217.2654521-1-edumazet@google.com>
Subject: [PATCH net] wireguard: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
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

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.43.0.rc0.421.g78406f8d94-goog


