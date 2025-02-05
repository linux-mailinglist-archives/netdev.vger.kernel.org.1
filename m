Return-Path: <netdev+bounces-163088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964CAA29542
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316EB3A71C8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D919539F;
	Wed,  5 Feb 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZqrekVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586B192598
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770687; cv=none; b=bEDR03gTwjHroqbOoH0s9AhHzdzYbcYi0R5USIzlPVjNo2oloP9t3pX8waVRcxrmzklqg48nQYwn3Gai7Glxl5gA/c0quCjmkygnCqtA5cD/eZMdSHx22zOjvoYNliy/XI90ykLnMcuR6Dc73MJmRNG+11SVm9yRKY30T4jbe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770687; c=relaxed/simple;
	bh=BjDBT6Ld/KkPV9e18e0rFMjRoUhNxwx0+3f23tk62VA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=etyNI42fOODdD1eB9b5SX4/f4S6klbL7TvdQD7bQbpQzxf4aBOovMgD8GhasFV9H/vvDPizgKJF/gg51kjlko7afg1/4z+xY9Y5Q7FopmXplnOuthRCJvy3d1tGgT/HKT9aro5F3iimlQR4Eyv9Nr+yhbq62AXIoTICl4H8nB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZqrekVH; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6ecd22efbso217687285a.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770684; x=1739375484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=VZqrekVHdvGvH1Vf9dv6emBB+8UEdNZy8+8aH3RMrmnIFqPPvT0n8kNDXN8N6FLO8t
         S7pc7MdwvTuSCeQDvR0JZxQGfoB6EtpGdE2J1Y4/KMWvQFLBbNrX4mDovA6akoWjkuYc
         OL9uybgVXE6aCZtw0NX27iDdBAEBiPT2p4cj2yCknxXgXmud+VWc18DS4i/eqdqzUUuH
         EFWzgoU4PAprrmP8qdcHdB7tz1QgkEmd2cICFt4IdGr/CKayHb0wUUz8uZpyltpKBpiA
         rnaKvz0gQk+kKi7GcEXtCRz3Etxn3QR3Ag8zM1PKZoRTvCTyQlZ+pdEbSLQTkPe+gjg6
         zT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770684; x=1739375484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFUTWn43E87kH4WvQpJOMQwE5y357mjWskRk2Y0FDpo=;
        b=GDYb7sW9aP8/759Sm+3lmUAdG6Q1mXrOCUfclLVHeS8446OwTeaY2a88rN0wbew6cZ
         ozMdxW9bKfWMMeICO4U97dt4d4XM+8M42Pcfke/Tl9f8eo1JJPs5DCGSfSXg4BukrdSd
         59KfsDMVo70PPrJq064HwXBaaFEVw86a6vEik0kkCMnYUIyYMvtNaVCOngOCQLwsvOLN
         W77VZz+zKX2cW9KusfhOBFVc1fPRvwrLOldqCuppNQzYrXWs852iDVBmf0ge/M5wHjRG
         VU+Rh59EsiptE71mS1mhymv7mmQbJJi4+aeJZKUwNaPG5hjkZ2jO41fb2gLT4gltZg5z
         tYIQ==
X-Gm-Message-State: AOJu0YxiYVFBVtpn8tCd/Q7knRTIc+88rnBAnBcKzPQrJXbxJIiWHTwe
	a2BQ9vrwtn7gUfBVe00pZtHEnIApLgZCTj97LO4iJeZjGq7y0xiiYJS7p3QI5+WdsGTlSRimi1F
	EN2qguIpvPQ==
X-Google-Smtp-Source: AGHT+IENwIwyNlm4WcVRoWMuKWAGEuHfcG1l9gl3G+Z8JY9plrBqcC3Eb4M9F4GZR4EkZQAzC3YYWXgsp/spaw==
X-Received: from qknpz5.prod.google.com ([2002:a05:620a:6405:b0:7b6:d922:f129])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:19a8:b0:7b6:f278:fa9b with SMTP id af79cd13be357-7c039aa5e42mr562966985a.12.1738770684523;
 Wed, 05 Feb 2025 07:51:24 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:10 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-3-edumazet@google.com>
Subject: [PATCH v4 net 02/12] ipv4: add RCU protection to ip4_dst_hoplimit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip4_dst_hoplimit() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: fa50d974d104 ("ipv4: Namespaceify ip_default_ttl sysctl knob")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/route.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f86775be3e2934697533a61f566aca1ef196d74e..c605fd5ec0c08cc7658c3cf6aa6223790d463ede 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -382,10 +382,15 @@ static inline int inet_iif(const struct sk_buff *skb)
 static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
-	struct net *net = dev_net(dst->dev);
 
-	if (hoplimit == 0)
+	if (hoplimit == 0) {
+		const struct net *net;
+
+		rcu_read_lock();
+		net = dev_net_rcu(dst->dev);
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
+		rcu_read_unlock();
+	}
 	return hoplimit;
 }
 
-- 
2.48.1.362.g079036d154-goog


