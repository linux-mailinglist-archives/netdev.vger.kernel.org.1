Return-Path: <netdev+bounces-201907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49648AEB640
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9B640600
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1052BE7D0;
	Fri, 27 Jun 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHUvna2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628B2BCF45
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023546; cv=none; b=XX9+Xb53558r8tayWOILPncC8TGFLMD5fpKe8Lnqe+gc4drqOVU4Z260zy8FwSobaANE12k4ZExtIA2s3uBSjwKGxKCPzZ/5MEiBRkpYHwIsnyvFz+atUMI4MflPzcb3wo6zJHwhNALyXJwVU7nVyX8usMt7lz9ussLL8UlgIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023546; c=relaxed/simple;
	bh=sut+639XlqNF4pEU2RCiJ776KFrsVV2/SkxL6Xbu6Zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AcCAdxG1MnN+qn421ZRsnnDuUOPJ+3YBPzjL2G2PCzM/Y9JjPjDrW6o2fT8i9QP5MsMtqUHANSmRfk+x9qjJ33a3DLh9kqm7N7U8bmpO5/aTY05OVMCxNgOyDoVpLJnO41J+NhzxA623mOrqM+36zqmJhnGhnHTdwUyVSSYIx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHUvna2L; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a762876813so34788781cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023543; x=1751628343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3PTnr3/d02QKCFg8yPNMJV9H6s/LAwZ7V1qOZVEpLk=;
        b=PHUvna2LCoN275QJ8Hu2QY/TvX6Ab74njXHoA7zWltY1x1kR8PnxgiF3Nt0mjKBdhb
         bPPvOgCui7jVDcfnShGvZj2SKmJp9/kiv8UdDwgxK0UsAO5JcOG41vT8dd9etbHZ94/Z
         n3yLsvQN29+i0TFMrxm8Wjs6RzP5I/QVGILvAO1T0QCbf9WTWyT+Ql3nVxCRzMb+d7sp
         Hyb5yqiinLCPBvjDVz2tkbCO/R0CLsQejG9lCNwFi9JY/2gnzA5b5yknMF8D7NrbrPPa
         c/pu9ZrY0u4YFIf6Lgh65oaMZ+UhSSFpCESJqdC3RrxKhN+NWNtlLNtk1rkyp8vSBDY8
         rTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023543; x=1751628343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3PTnr3/d02QKCFg8yPNMJV9H6s/LAwZ7V1qOZVEpLk=;
        b=uN/s3vdF6wTuwPmiuIQ/yOIQd0FTFRTSKZkj0mt5O+18cKmAZZT4ZABHcm94Aygv3D
         XvEDIYF2Zirp9sW/KdLahdBoMOfkbWnsv9c2HzkaIqmu37WEhN826YoOhrtkAUPWbiyg
         RmSxsLdvxAUkozKgIN2/TWSofm7mRZyDkerqO6NCiRAncVb4Igx84fF3GCnlA7Rxmrjh
         GM7sZ/ciwx50OinSfyLRckxejfWel9nnj/sdGVoxfC2MTmtN/CiF7VHlTXKF8kxSeZSn
         lc+PUlUAfwKEdTlKW7l6L91HyyVTqCHXKRBFoEbQphiLG9yvhEdmQEP/ZZPB6gNoZFCy
         IOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT0jkcDnZVz96ZSPBThMIn6Xav1XSngIQWShhp5w3PxsZLgOGBSdZeMkjnvpoNzJ+CD8JM6SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ds1wx9yQTwavEXu7N0qgo+03wG1E10/aUBu+Q6MdDz8oyLiy
	jftO6Sujt9k8c4TVZRVX/Vvp5Tvf1Xpq8BDegDqBSSB5Jh6Y5qPAyS/aZGVlEnVLnILZO/qGFri
	Rg0zDP4NGoC3KdA==
X-Google-Smtp-Source: AGHT+IE/tyvbK0xMGcAxQG5nK9N3Nkce34Wgtljl13F+2H/F15IGXF2SMe/zcfkIkqAo8gYj5Fh12FM+njofuw==
X-Received: from qtbcj9.prod.google.com ([2002:a05:622a:2589:b0:47c:de02:b269])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58d6:0:b0:4a1:3b18:598a with SMTP id d75a77b69052e-4a7fc9d42f6mr46155701cf.5.1751023543425;
 Fri, 27 Jun 2025 04:25:43 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:20 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-5-edumazet@google.com>
Subject: [PATCH net-next 04/10] net: dst: annotate data-races around dst->input
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst_dev_put() can overwrite dst->input while other
cpus might read this field (for instance from dst_input())

Add READ_ONCE()/WRITE_ONCE() annotations to suppress
potential issues.

We will likely need full RCU protection later.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h      | 2 +-
 include/net/lwtunnel.h | 4 ++--
 net/core/dst.c         | 2 +-
 net/ipv4/route.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index bef2f41c7220437b3cb177ea8c85b81b3f89e8f8..c0f8b6d8e70746fe09a68037f14d6e5bf1d1c57e 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -468,7 +468,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->input),
 				  ip6_input, ip_local_deliver, skb);
 }
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index c306ebe379a0b37ecc5ce54c864824c91aaea273..eaac07d505959e263e479e0fe288424371945f5d 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -142,8 +142,8 @@ static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 		dst->output = lwtunnel_output;
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_input = dst->input;
-		dst->input = lwtunnel_input;
+		dst->lwtstate->orig_input = READ_ONCE(dst->input);
+		WRITE_ONCE(dst->input, lwtunnel_input);
 	}
 }
 #else
diff --git a/net/core/dst.c b/net/core/dst.c
index 8f2a3138d60c7e94f24ab8bc9063d470a825eeb5..13c629dc7123da1eaeb07e4546ae6c3f38265af1 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -148,7 +148,7 @@ void dst_dev_put(struct dst_entry *dst)
 	WRITE_ONCE(dst->obsolete, DST_OBSOLETE_DEAD);
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev);
-	dst->input = dst_discard;
+	WRITE_ONCE(dst->input, dst_discard);
 	dst->output = dst_discard_out;
 	dst->dev = blackhole_netdev;
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d7a534a5f1ff8bdaa81a14096f70ef3a83a1ab05..75a1f9eabd6b6350b1ebc9d7dc8166b3d9364a03 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1687,7 +1687,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 		else if (rt->rt_gw_family == AF_INET6)
 			new_rt->rt_gw6 = rt->rt_gw6;
 
-		new_rt->dst.input = rt->dst.input;
+		new_rt->dst.input = READ_ONCE(rt->dst.input);
 		new_rt->dst.output = rt->dst.output;
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
-- 
2.50.0.727.gbf7dc18ff4-goog


