Return-Path: <netdev+bounces-210733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C1B149AE
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DE73AD806
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840826AA98;
	Tue, 29 Jul 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZl/kO/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70755259CBB
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776133; cv=none; b=k4swlu3r1uJvNuP1WHc90fH2hk01B8OMTz3rnirsokFqh3SO8hI6tnTFesiU3bL8jyWnxfKI1WCg9iyoJPT0saYJkWhvAiysaVFcB+bZUPeSGy1+NnzkG7zCMtt5TNEpmwTIsSkTFtl/KKZk5awOrP048FhNjduHntQYEGbQE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776133; c=relaxed/simple;
	bh=wVwDOl//elXR1DxYqIj4MJKfPX88vPO6LAXuEFbEh98=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=frmyv//EGbQeyh7Vf7cSzHNpqCZBguyc25F4GO0HZPsC0/wRccF6ZLeju2YYSQXQPNdMpZlyng5waHlH068Tjb5pbHDyjsNULfVqJNU59hB4CbKWb11PM00FVdrRCDkr38IKIdcBb+eYZ31a6bwwBK8Sr2b6JLkH6k5i7tbAFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NZl/kO/L; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e03ac1bf79so416021185a.3
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 01:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776130; x=1754380930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M7TwkNAk8QHVaE8heo5T8sT+VxS3EibT06hIWnrlp3U=;
        b=NZl/kO/LknzQ4NUugmk0v4bS3CJTQdoKxA6yUTsTF0OtWXp/iKk4DjU5hMtyQhPoic
         vjM8VNHsblWDjFO5QbyRE6CcBBuWsTDMP/tUX5sSCalQ1g2buxx1uiHnVvBGXK9kDojh
         /kQwg53aH2uUGKzTd7ZZCy1ILx0yjeng8u/80thcAZzJYwrLddz/3+eDQ8HEJSfLQycC
         YWdUVB586saGijWQGmvxtHagqdgUcI9QjM2eZ3JUfulWT4I+wH5Xh2NzU0UIaxRFRqhy
         z5sZyTTO9UwTL4krZsxwNvT4ZsHLa/Jkp6NLRCSzxM8Av1smrq/HxMqp9fXysXSh63KE
         rPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776130; x=1754380930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7TwkNAk8QHVaE8heo5T8sT+VxS3EibT06hIWnrlp3U=;
        b=tuVjyziXalLhwQpAZgXYmAgtOL7D7awDIjXAAv3HA4PAwZjSQC7iNGPc1spMTyyRxM
         ib9jH+1s8xFDxF0I9HirVPMq7xsQIYPp6hoWZBhIcEpdcuUVhm7jeK6Mrtg+FVB1Biok
         9x36zfiXXsaaIkfc6mGOKMACaaVCyAf6OYaX8h1b1W0ncPilmLZvi+Garc3xYzlrAijv
         DOqCVAjf7CQVIwwQZntSqMHPOhjiCHiqf4qxURalONcXNJ2RO55EsDs6zEr1S3QSB5Hv
         frY/BhEdHcrlu/iPF+sI32+VgRB3Dyu1jD96al44diTZMzKCV/GZYuTmBM52Y1YV+Shq
         zzUw==
X-Forwarded-Encrypted: i=1; AJvYcCUBOaRdoh/GvsrWjqs16A1I2QxhOiOSF7o2KhsMLMvxTY5DZMWV2FExtvbXB13cK26CyKz3Pxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pXb1uHcqDSeU0p7sx26o9t6dHmoezfsdSCwciDjq/xmyEsUz
	n4KHyMYdkOzUEB+u4S2NZvOfyZlKtketa83/b/emvy12vO9e5uU1w8GnjfGd40rkLI7B8+kN8WT
	u0lR9P9QbMNoTiA==
X-Google-Smtp-Source: AGHT+IEPFQFtBHGlNqFXJnRWJRHtZgY+nKvoqO+n560zV/8P23fGx8zuiUmrkz80liYGeFLkMbXa9H214uarMg==
X-Received: from qkox15.prod.google.com ([2002:a05:620a:258f:b0:7e3:2bff:7905])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a91b:b0:7e6:2114:d577 with SMTP id af79cd13be357-7e63bf6af25mr1764738285a.19.1753776130417;
 Tue, 29 Jul 2025 01:02:10 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:02:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729080207.1863408-1-edumazet@google.com>
Subject: [PATCH net] pptp: ensure minimal skb length in pptp_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Commit aabc6596ffb3 ("net: ppp: Add bound checking for skb data
on ppp_sync_txmung") fixed ppp_sync_txmunge()

We need a similar fix in pptp_xmit(), otherwise we might
read uninit data as reported by syzbot.

BUG: KMSAN: uninit-value in pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
  pptp_xmit+0xc34/0x2720 drivers/net/ppp/pptp.c:193
  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2290 [inline]
  ppp_input+0x1d6/0xe60 drivers/net/ppp/ppp_generic.c:2314
  pppoe_rcv_core+0x1e8/0x760 drivers/net/ppp/pppoe.c:379
  sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
  __release_sock+0x1d3/0x330 net/core/sock.c:3213
  release_sock+0x6b/0x270 net/core/sock.c:3767
  pppoe_sendmsg+0x15d/0xcb0 drivers/net/ppp/pppoe.c:904
  sock_sendmsg_nosec net/socket.c:712 [inline]
  __sock_sendmsg+0x330/0x3d0 net/socket.c:727
  ____sys_sendmsg+0x893/0xd80 net/socket.c:2566
  ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
  __sys_sendmmsg+0x2d9/0x7c0 net/socket.c:2709

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+afad90ffc8645324afe5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68887d86.a00a0220.b12ec.00cd.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/pptp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 5feaa70b5f47e6cd33fbaff33f6715f42c4d71b5..4cd6f67bd5d3520308ee4f8d68547a1bc8a7bfd3 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -159,9 +159,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	int len;
 	unsigned char *data;
 	__u32 seq_recv;
-
-
-	struct rtable *rt;
+	struct rtable *rt = NULL;
 	struct net_device *tdev;
 	struct iphdr  *iph;
 	int    max_headroom;
@@ -179,16 +177,20 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 
 	if (skb_headroom(skb) < max_headroom || skb_cloned(skb) || skb_shared(skb)) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
-		if (!new_skb) {
-			ip_rt_put(rt);
+
+		if (!new_skb)
 			goto tx_error;
-		}
+
 		if (skb->sk)
 			skb_set_owner_w(new_skb, skb->sk);
 		consume_skb(skb);
 		skb = new_skb;
 	}
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3))
+		goto tx_error;
+
 	data = skb->data;
 	islcp = ((data[0] << 8) + data[1]) == PPP_LCP && 1 <= data[2] && data[2] <= 7;
 
@@ -262,6 +264,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	return 1;
 
 tx_error:
+	ip_rt_put(rt);
 	kfree_skb(skb);
 	return 1;
 }
-- 
2.50.1.487.gc89ff58d15-goog


