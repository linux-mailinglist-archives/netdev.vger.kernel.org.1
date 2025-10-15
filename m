Return-Path: <netdev+bounces-229471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F6BDCBEF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB98919A2786
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBB311966;
	Wed, 15 Oct 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vsJmWueB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27A30F933
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509945; cv=none; b=ohE/PzvHdykA9i83N0nNIM544Ea/rBexCl34Fj2Cwq+o0ezcsMxL2P3MNyp6fXmxlc2x5vrZXhkUPa7xUXNLfj7HO0bgwUqsNYkVWpdyLHJo3ikPPfMnskyegzl48QDG+sG99yqH+Bfcdcsftg/0g9gE3uTN7XMKNyp6jsQ6vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509945; c=relaxed/simple;
	bh=wcxQRCjh2iBlcjpVi3hwo9EDcTRpXFYBGEOiywasVvY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fDFWMJLha0yOmlURy2Hru/vBaYLu/FvCvExOfBX297A5FXPIE2knq4B13KPaL1gJh6Kn9jy6Tt/68RwNo8oRolJyr06Sc6zbE7/INnIu+5Oog8yCoAZZq+tuzMHEKy2/RtRyG+4XCTrhwHrIFcHR9d1EwxBJ94ftlasgxxusIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vsJmWueB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7493de81ca2so121850837b3.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760509943; x=1761114743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yb4w1ExYUBar84pW0wEeAarRRF4jtmJAfiYU4gsuLjc=;
        b=vsJmWueB3o3eOEkWhR4LLD6EqTymAhRDLyM0E5o1bz2D8pNw+4kwRKl5SwRAuE5cep
         tcpwFeouveFvM5PzHsmPhRNxWkqLZ2iI9OEGahIG+GnywxQkjyhWpslMqxzJ6avliu4T
         M0mAZGt3MYaxpUyixooboLXm/xpfYgfBAmbnOwxSAB7tta+bU13QvBig05tkTDXNMCx2
         A6HgrUwhqQQ5F9x7wmU7jtb8+WcND0CcFxfZTcr0xCE/jSIIW1Wnon+zULABAq7vBGGf
         EQpqPWADNcNWq9cAYsBm+oSxYSgOJdc8cwoXGxscMivHhzjWqGOV8rzgMVx3WGaj/7Eb
         vN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509943; x=1761114743;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yb4w1ExYUBar84pW0wEeAarRRF4jtmJAfiYU4gsuLjc=;
        b=iKS+c5syHfwfZe3WwSbAiWh6lZe5ONikTI1UqRyHrGBGYb2lLDwMYxztt96Nguiorg
         N6XpkNGnk6DMmfgP/TvtsVnb5w3rihTVagScuWah70Zi9j3pPbY3Z781k0r/cuSmyAJK
         5pbI1JZSK/b5DQdR1mLuQPO7WuNyUYX6fuvq7RV3+pvZBRovNBhQzG7gpOSTzK386aFj
         elJgT3o4m3bhgLzMTtkxmVRDm+EPiH+3zM1b7+y7w1AK6APC79mx+XeyWCK9ZWCC99yY
         5AVgrhiZp5YoH2n9lkP249EZlZiyO1FnOy1umpmjnL8t7cwwHYG+85LehMQ0HFU0DWjB
         If8A==
X-Forwarded-Encrypted: i=1; AJvYcCWT8A/QGROxvNdIP+j3SrUT4JBMFJ7Q5RKcslreTog56JYU9UZ7HaPekuUkqWu7WfJDRtVW6cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0b0ws6evqCZReas1aZ4cJ41HMBb/aCQ2SJq/4z2Ctbs1/XzF+
	LU9+hfPvqHDdY9CvaIO7obgqDWZFpssEtRCZ2a+b5t06Fy7rraXiYCBynawt9e3nGfaBM3aAEQI
	rTi/m+s6ubhs51w==
X-Google-Smtp-Source: AGHT+IHztJafiT03h9b660iZRvHnAcw4CVGoK1qs862laJEfA+/xH21ylcj3wUdwTs9SASOXrE2MD8jJmZYJCg==
X-Received: from ywpp26-n1.prod.google.com ([2002:a05:690c:a4da:10b0:781:61cb:492b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:88e:b0:781:4c0c:794c with SMTP id 00721157ae682-7814c0c9ce8mr47054517b3.27.1760509942819;
 Tue, 14 Oct 2025 23:32:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 06:32:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251015063221.4171986-1-edumazet@google.com>
Subject: [PATCH net] net: gro: clear skb_shinfo(skb)->hwtstamps in napi_reuse_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some network drivers assume this field is zero after napi_get_frags().

We must clear it in napi_reuse_skb() otherwise the following can happen:

1) A packet is received, and skb_shinfo(skb)->hwtstamps is populated
   because a bit in the receive descriptor announced hwtstamp
   availability for this packet.

2) Packet is given to gro layer via napi_gro_frags().

3) Packet is merged to a prior one held in GRO queues.

4) skb is saved after some cleanup in napi->skb via a call
   to napi_reuse_skb().

5) Next packet is received 10 seconds later, gets the recycled skb
   from napi_get_frags().

6) The receive descriptor does not announce hwtstamp availability.
   Driver does not clear shinfo->hwtstamps.

7) We have in shinfo->hwtstamps an old timestamp.

Fixes: ac45f602ee3d ("net: infrastructure for hardware time stamping")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/gro.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 5ba4504cfd28ec26f487bfb96645e25c4845d720..76f9c3712422109ad00f15f6804abf6a8b00db43 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -639,6 +639,8 @@ EXPORT_SYMBOL(gro_receive_skb);
 
 static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 {
+	struct skb_shared_info *shinfo;
+
 	if (unlikely(skb->pfmemalloc)) {
 		consume_skb(skb);
 		return;
@@ -655,8 +657,12 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 
 	skb->encapsulation = 0;
 	skb->ip_summed = CHECKSUM_NONE;
-	skb_shinfo(skb)->gso_type = 0;
-	skb_shinfo(skb)->gso_size = 0;
+
+	shinfo = skb_shinfo(skb);
+	shinfo->gso_type = 0;
+	shinfo->gso_size = 0;
+	shinfo->hwtstamps.hwtstamp = 0;
+
 	if (unlikely(skb->slow_gro)) {
 		skb_orphan(skb);
 		skb_ext_reset(skb);
-- 
2.51.0.788.g6d19910ace-goog


