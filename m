Return-Path: <netdev+bounces-249110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9A9D14566
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8EC6300518F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7B37BE85;
	Mon, 12 Jan 2026 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeh7ZzgY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75637BE6D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768238787; cv=none; b=WCJs4LRpXNgIAz2bVmyhS/HPtJrbN+ZVBYqOH1SnY9mx+d53sCWPFmzH2Fo48wkDTqrF8tZbTiSGuMKX1Qu5VyP979gSMSPknTwY2rA4ngSYBviQ6oZq3oBgD/Lp7nHoH8PlMm32MHQtisuTMNWqthMLWQdKiYhrc5eLL9SRb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768238787; c=relaxed/simple;
	bh=pVzeseCGTQjYnn9NrHy5k1f8dONmqCxqxqzzsQCYVyI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XQV+7XRor33FyKE82sHsK5eyvTbRcmCcbSxiiVx4gVFPTLLdNKDLhAx7rcMuR9+jShmCViEvp/uTgSlyMFj/JExPiah8HJ6TSHWoX2zj3yG8jbMNGQlGWVFLwjYQ/3r8dJLFUaKsmcciJJLb2tVzI4KbzsDneneaM7LAu858FiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeh7ZzgY; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-645592c1b59so10222974d50.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768238784; x=1768843584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dayk09/m+Nfda3ixgXC7gUsRzkBW8nWV/PvEEGeqODQ=;
        b=yeh7ZzgYGIu3thS9QfSHKDtRpdoyefk5Zy2CLU5x1Bju93c21ShknahWiFjQSFqv0c
         GXpqNUT5ONkwdj0yXC4Phv9GSZwnifCE111E0d/7P0KHFBPCbpuWIovcHwHmF9FxgnVS
         /Bdbhc7pZXTj8h+8lGLp2m2gnRCc+LUohMDuXeggVJ7yej5v3vqKLcZChSkBP4n87jxP
         HEKz9Rx1Pa51Tpwn1gbbKelWWMYMr77+vaTOzXSSfPVObc80xNkCtqAyzp7g9BGjAL99
         uSEy/7gswwDOs7T1D+GsbOcRfuJI8r31ifvnSl8dXcgL6g2q3i5zZgOvHD8eXqM2Gg3g
         BMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768238784; x=1768843584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dayk09/m+Nfda3ixgXC7gUsRzkBW8nWV/PvEEGeqODQ=;
        b=gfbjttwFsllf3rSpZuKw2A+JB/R4tnFf8XL8H88kr4pxIweOaLqMhhlSzKPv7nPstl
         8uCNfJZRRq8eNW2AQBppIuBB8E8CD82RByxZ3tVE07wy6kMJedX6KuWCSoFBr+1alvlY
         odKKUQzcxQxmCf+9nvbNtOcIl+l/r345KpGKhWCorOHRU7H+q+3q2COXwj1gEYRsK/8V
         UFKf64uhECRoMNpcCQPdQHHLdU5Qrtdhw/YUPqC1fMHDteE6zCn/Gnjd0PU/C7DGgvJ3
         x4woqePkU7UjJE09eCk8LAy+8fEmoo+V5A6yWzj7NW5UCTjsfTUALHTn1j8A79MzuqEZ
         v9tA==
X-Forwarded-Encrypted: i=1; AJvYcCXbxgjZxMFOdrTRe1KyYotAcnASXE8wzAm0SoI5NEp8G09/+LBxvEGS0R/NswvDxRwbSisxI1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3//GlglYNBtv34AknNitHSeWvZ+4qmuuVgfihPq9GWZ3Fctw
	XDIEiD/VuZ/rb1QubMWvmwy6GtUWZ3cSvAhQP9zmghHBVGmnez92Ypxje7hy7Bwpgik5EHp+fMv
	SoCFEoEmNjsx5SA==
X-Google-Smtp-Source: AGHT+IF8vGswqeN8Xozk20KFck02xUrpvGvdH1VyN0KV0Y1bSVR1I5TR+1yW4M07Nwbceu02rOmefkiRbaFtCA==
X-Received: from ywzz2.prod.google.com ([2002:a05:690c:a702:b0:790:acaf:4494])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1405:b0:647:108c:15e with SMTP id 956f58d0204a3-64716c38402mr15610420d50.54.1768238783639;
 Mon, 12 Jan 2026 09:26:23 -0800 (PST)
Date: Mon, 12 Jan 2026 17:26:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260112172621.4188700-1-edumazet@google.com>
Subject: [PATCH net] net: add skb->data_len and (skb>end - skb->tail) to skb_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While working on a syzbot report, I found that skb_dump()
is lacking two important parts :

- skb->data_len.

- (skb>end - skb->tail) tailroom is zero if skb is not linear.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/skbuff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d9c47b45a4a19b228b151456e5051..61746c2b95f63e465c1f2cd05bf6a61bc5331d8f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1312,14 +1312,15 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 	has_mac = skb_mac_header_was_set(skb);
 	has_trans = skb_transport_header_was_set(skb);
 
-	printk("%sskb len=%u headroom=%u headlen=%u tailroom=%u\n"
-	       "mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
+	printk("%sskb len=%u data_len=%u headroom=%u headlen=%u tailroom=%u\n"
+	       "end-tail=%u mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
 	       "shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
 	       "csum(0x%x start=%u offset=%u ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
 	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n"
 	       "priority=0x%x mark=0x%x alloc_cpu=%u vlan_all=0x%x\n"
 	       "encapsulation=%d inner(proto=0x%04x, mac=%u, net=%u, trans=%u)\n",
-	       level, skb->len, headroom, skb_headlen(skb), tailroom,
+	       level, skb->len, skb->data_len, headroom, skb_headlen(skb),
+	       tailroom, skb->end - skb->tail,
 	       has_mac ? skb->mac_header : -1,
 	       has_mac ? skb_mac_header_len(skb) : -1,
 	       skb->mac_len,
-- 
2.52.0.457.g6b5491de43-goog


