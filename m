Return-Path: <netdev+bounces-93347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71C8BB3D8
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5481F258C5
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415A158D7B;
	Fri,  3 May 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtrE++n9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C5158D6D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764072; cv=none; b=Gn8Fg9uA3OMXopO2KnM1rVxw1M4hYuo1f84Lz2moJnO1Cj1wNGFcZz3VZaFTQL90Y01+dkyCyKl+SOlnKhqjMIdbRzHc3EuaZKfSem09BuokQb0M1nur9GFZDs0RT8cVtNXYrm9EF6Bo0vW6f3N2TT6g1GfYcxppeskbEdjqomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764072; c=relaxed/simple;
	bh=fRjbT5NStrHvBG+rAmq+eyfDV2ZRKLzuSbh/toAiteI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AMAGi14gCv2cSF8OrOwd809jMU66z/xE/+bAEGj31Du1xNqFSq37ghKF3eVaGSjtl+NAKqCz0WjMlvvVa/bKaSGpPYdDv607bIVnSsixqQ0Vta1K7xelUwt+KUrHidOQiuxdQSv7Z9KQ7KlSCrPWnajOI6lmutP/3NgOHYWqvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtrE++n9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so63425276.1
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764070; x=1715368870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8/pGsIeiqYpc1qyip3qFRTTko/1kojG9TEz9vmOMQ=;
        b=mtrE++n9w2N8bhJpekQtOyxG1ISbKGxvTX/1ekriZ/VcoViHSuQbfWtRoOR1hYblEf
         04il5/G8zKoPjLsbitK04LqFstVoeQQGqZZlFfEjGq22i3R6MJikBcwnt0UyO8EDPzfe
         IEGsc+3KgJoPeQqkLyDQQGYGgGsKAJSA8Q9YxfXf4lWBRlR0A/HuIW0psoj1YpYGa4B0
         KGJ0CFdFi/lkhZu5mYqBZ7hXsemhHPMMae/ZlP7Ly+sGE5jAGLiKzzknQMEmLCaspNj2
         bTCsYSnDz/xfncH+jpf2SzylwBRppMxDMW8pS64DHEj3aRspZPT7r0VU/qrbIKQhxfYg
         xz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764070; x=1715368870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8/pGsIeiqYpc1qyip3qFRTTko/1kojG9TEz9vmOMQ=;
        b=i6pm+uVcsAUJWy4HwXsm9Xp2rJtuIgkiG3M7B86bMM6CpCFx3CJJ/OxKiwEKEwzneh
         MxIbtkjazHPIgiXfVUTwS3cWcuNHF0f1TYP1N/06mGEBqQhIp+Er7Ngst7kGFL0/8Pnp
         aADuQ40oCMvkrGVMLmZeJJje1UyIutBuXFCkH9bypRig+xSNt37Qbed5I/FmxhntVQU9
         AlNZeWZ+URi6XRws79Kpx2rhPpzjcgbJAVeXmOqz1N3eYgh5RJYbyaHdmZSduZlxYR1b
         DwRkE+18Hj6VIbvtYk/rETl8XQ02TNc0iJRTcrFo3ppSh2mqJ30uMgra/DJNI535nwm8
         I4Cg==
X-Gm-Message-State: AOJu0Yzx4wKuiDZ87QWeZCwSSpz9dlGuOYAst7HDFcKEjaX0LD/e3yrN
	1JpPTUmQeT16veS134ZyncuE99NHq14XjAAj68vgmWSK+wnQ0QUfhSpuzW0hHTMC1qUpqWih2g8
	eXLkOcwJf0w==
X-Google-Smtp-Source: AGHT+IHe7Mst5oE1XPHbOf89cc2ctM5rwmWKGEj+FFaUz9VwoRGY879/goYw4Ti0XkiEtLulGn7N047bxO7TQQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b311:0:b0:dc6:44d4:bee0 with SMTP id
 l17-20020a25b311000000b00dc644d4bee0mr475887ybj.7.1714764069937; Fri, 03 May
 2024 12:21:09 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:57 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] rtnetlink: do not depend on RTNL in rtnl_fill_proto_down()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change dev_change_proto_down() and dev_change_proto_down_reason()
to write once on dev->proto_down and dev->proto_down_reason.

Then rtnl_fill_proto_down() can use READ_ONCE() annotations
and run locklessly.

rtnl_proto_down_size() should assume worst case,
because readng dev->proto_down_reason multiple
times would be racy without RTNL in the future.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c       | 11 +++++++----
 net/core/rtnetlink.c |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 35ce603ffc57fa209dc9a57e60981a2bca5e6a29..06304f07146c7f672573a977b069e7f2c031122e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9223,7 +9223,7 @@ int dev_change_proto_down(struct net_device *dev, bool proto_down)
 		netif_carrier_off(dev);
 	else
 		netif_carrier_on(dev);
-	dev->proto_down = proto_down;
+	WRITE_ONCE(dev->proto_down, proto_down);
 	return 0;
 }
 
@@ -9237,18 +9237,21 @@ int dev_change_proto_down(struct net_device *dev, bool proto_down)
 void dev_change_proto_down_reason(struct net_device *dev, unsigned long mask,
 				  u32 value)
 {
+	u32 proto_down_reason;
 	int b;
 
 	if (!mask) {
-		dev->proto_down_reason = value;
+		proto_down_reason = value;
 	} else {
+		proto_down_reason = dev->proto_down_reason;
 		for_each_set_bit(b, &mask, 32) {
 			if (value & (1 << b))
-				dev->proto_down_reason |= BIT(b);
+				proto_down_reason |= BIT(b);
 			else
-				dev->proto_down_reason &= ~BIT(b);
+				proto_down_reason &= ~BIT(b);
 		}
 	}
+	WRITE_ONCE(dev->proto_down_reason, proto_down_reason);
 }
 
 struct bpf_xdp_link {
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 242c24e857ec4c799f0239be3371fd589a8ed191..6af7f00503b43d4989d0aaafc8b968216a6e77f5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1036,8 +1036,8 @@ static size_t rtnl_proto_down_size(const struct net_device *dev)
 {
 	size_t size = nla_total_size(1);
 
-	if (dev->proto_down_reason)
-		size += nla_total_size(0) + nla_total_size(4);
+	/* Assume dev->proto_down_reason is not zero. */
+	size += nla_total_size(0) + nla_total_size(4);
 
 	return size;
 }
@@ -1737,10 +1737,10 @@ static int rtnl_fill_proto_down(struct sk_buff *skb,
 	struct nlattr *pr;
 	u32 preason;
 
-	if (nla_put_u8(skb, IFLA_PROTO_DOWN, dev->proto_down))
+	if (nla_put_u8(skb, IFLA_PROTO_DOWN, READ_ONCE(dev->proto_down)))
 		goto nla_put_failure;
 
-	preason = dev->proto_down_reason;
+	preason = READ_ONCE(dev->proto_down_reason);
 	if (!preason)
 		return 0;
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


