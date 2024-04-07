Return-Path: <netdev+bounces-85487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C089AF6C
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 10:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF5282882
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156211720;
	Sun,  7 Apr 2024 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RCRkpxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04915AF6
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477171; cv=none; b=k1k3A8ovsLP9lA61ucXD8soE4yJB79sMXZ1BlrCx/LZ3N88h1+/cmGrtg6tS7fJ80DvurZh8Ol5N1RSK6iF/aNjWW2CNVLjSAw7tXCkTWoU5XHCCpYM87FxxC6XN7NNNhZCMSNvT2vSjLXlKDKMjECTI4myymrrzZzbkynsy0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477171; c=relaxed/simple;
	bh=Mey5rJ2GRiTMoCRHwXY/DlCztDmd8UnAbGEoXw2v4P0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jTQM1xMqPfQhR0ctlssa+B+iPGacGnJIY9MXy3ZNSiUYdrrwy8G3C9m6q/I0aqOUcAWlRrp0hFWHS+bgXjxF053vR0X9eD1tt2Uw0eCmZnvqCvg0QWmLkXiPi/NL5iZfnqJ2UH2ErxR4/UTPrpQf6/T3Qz9bymWS33aIT9TYKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RCRkpxZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso6193282276.1
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712477168; x=1713081968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sygACIauSmYUglo7+/NhK1xXhkGeqqP6XusXRXxtUQg=;
        b=2RCRkpxZ9lNDEI55gksVr+Of3nFrOuBTTj81JHqqMxqSQwuRWSG/SVqWJlIoF/7U3X
         qJSBfvWHwCO64uGFDe51oaSkVQzCl9RxM7LBpkJeII0uuvEAgERtFs/SFM1nCJ4PiHAs
         mMzhQIx3e7skotJjwad7Y2hCpDbXbslWiZrtPrp3/1vPkCdPb+s9NnCPX5uBegBDeyHq
         z6QVtJ20+d/fcu8au85Mf7baqOfyS2TESRTaACDmCfoF2ijLS9iPgiOgYd9vRhKaePi2
         g++ufITt1nc5uezESqYZIGYBfKWSYAF+6Fx1OhpyL5HqtNS51Rg/vRfe+aqT2EWMHJaw
         4+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477168; x=1713081968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sygACIauSmYUglo7+/NhK1xXhkGeqqP6XusXRXxtUQg=;
        b=YuhFRAX4SK0ugKn0RPUupdeWAbzaThJrCAGBSQwRn96Ltn3mgXp8k0RFFgIGeSuasm
         bhcWh6W0YdT3hrfKV2c2x5UE0Pvq0AZ9Zp3uzjUiLHxikN/Nc8qddldIa0Q+hBkq+eNv
         g8NexhRDVfunk8MVp/mCoQoynRbtdkabC5HgsgLExTci2juwvkKnFsYBI2Q19m2UPHL0
         6M+SzoBSKofWgssAkVEwzlWgPN8izfw5qeZj9lzW2FB+p7Rvn5NBTk2IDqzbMKusNNY5
         EOnl4sJY6CtOGjA59O9Q02sbg5hZx5EBijoNqP/WxSzGSYEQ2+CHY9oBXSlggBgNJw3Z
         bkTA==
X-Forwarded-Encrypted: i=1; AJvYcCUMliArYXuakASJ2KTsW/kVlUuJzn1zZY9qdYj5XJRX/jQJcwxMTuVJXzFY/2v3Bz+Aa+/GIZSw8Gxw/DlaBJ7tcpwDkCJ0
X-Gm-Message-State: AOJu0YzsesD1TzY+JxZI92/kgv8x4FUBkAPO3W60cMHgicYpcfODogLK
	oXbcgAH0aIb4huGJbekyuuIuuULQJLmj5Lbek4vb24dK2mBXtNgAEE5UrL5jMZFYrAkUr5hTv/v
	+IPEQtfY8TA==
X-Google-Smtp-Source: AGHT+IE80Moy+di+bIxWKOq9h6t61vlZd0PVMzrQd+0tIUCxJ+ypVW2rp46B7BtGJMfJzB/QAmBWckAE8+cvcA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18f:b0:dd9:3922:fc0e with SMTP
 id t15-20020a056902018f00b00dd93922fc0emr464913ybh.13.1712477168208; Sun, 07
 Apr 2024 01:06:08 -0700 (PDT)
Date: Sun,  7 Apr 2024 08:06:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240407080606.3153359-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: display more skb fields in skb_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Print these additional fields in skb_dump() to ease debugging.

- mac_len
- csum_start (in v2, at Willem suggestion)
- csum_offset (in v2, at Willem suggestion)
- priority
- mark
- alloc_cpu
- vlan_all
- encapsulation
- inner_protocol
- inner_mac_header
- inner_network_header
- inner_transport_header

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/skbuff.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb9bb70e89d47abda5daca5d16aae2..21cd01641f4c047c9a7ff2924b686b5a42535f81 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1304,22 +1304,28 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 	has_trans = skb_transport_header_was_set(skb);
 
 	printk("%sskb len=%u headroom=%u headlen=%u tailroom=%u\n"
-	       "mac=(%d,%d) net=(%d,%d) trans=%d\n"
+	       "mac=(%d,%d) mac_len=%u net=(%d,%d) trans=%d\n"
 	       "shinfo(txflags=%u nr_frags=%u gso(size=%hu type=%u segs=%hu))\n"
-	       "csum(0x%x ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
-	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n",
+	       "csum(0x%x start=%u offset=%u ip_summed=%u complete_sw=%u valid=%u level=%u)\n"
+	       "hash(0x%x sw=%u l4=%u) proto=0x%04x pkttype=%u iif=%d\n"
+	       "priority=0x%x mark=0x%x alloc_cpu=%u vlan_all=0x%x\n"
+	       "encapsulation=%d inner(proto=0x%04x, mac=%u, net=%u, trans=%u)\n",
 	       level, skb->len, headroom, skb_headlen(skb), tailroom,
 	       has_mac ? skb->mac_header : -1,
 	       has_mac ? skb_mac_header_len(skb) : -1,
+	       skb->mac_len,
 	       skb->network_header,
 	       has_trans ? skb_network_header_len(skb) : -1,
 	       has_trans ? skb->transport_header : -1,
 	       sh->tx_flags, sh->nr_frags,
 	       sh->gso_size, sh->gso_type, sh->gso_segs,
-	       skb->csum, skb->ip_summed, skb->csum_complete_sw,
-	       skb->csum_valid, skb->csum_level,
+	       skb->csum, skb->csum_start, skb->csum_offset, skb->ip_summed,
+	       skb->csum_complete_sw, skb->csum_valid, skb->csum_level,
 	       skb->hash, skb->sw_hash, skb->l4_hash,
-	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif);
+	       ntohs(skb->protocol), skb->pkt_type, skb->skb_iif,
+	       skb->priority, skb->mark, skb->alloc_cpu, skb->vlan_all,
+	       skb->encapsulation, skb->inner_protocol, skb->inner_mac_header,
+	       skb->inner_network_header, skb->inner_transport_header);
 
 	if (dev)
 		printk("%sdev name=%s feat=%pNF\n",
-- 
2.44.0.478.gd926399ef9-goog


