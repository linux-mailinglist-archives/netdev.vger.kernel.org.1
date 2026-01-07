Return-Path: <netdev+bounces-247886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7755D00262
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1BE1301471D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069E303CB6;
	Wed,  7 Jan 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="16U86wz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AB1E5702
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820974; cv=none; b=B5x43R6SxI1QL6rZW9UwoF5jjasAA5/ix8pZ/8epS08q/meRQcxKTfgwXtr5CqNPlqASgtlL4tFp79WVMVv2Pe8xpfhFESTIalSu3fEPgHBNQRIA4YWBNNg4zsp2dtKrDeqg8JqGYun2wVo5bwvOL0Y3zGQevvKODbQmeZy4tWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820974; c=relaxed/simple;
	bh=QdJhUoNv5rrVT5Bcz9vG+KIgbE8lctJNpTxe/SnKSIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hmO//oLQFIkd3WGB78j+4IMmpKq3qXRPpxVAw7Lr5Dih7NjzqpWQ5NYNrXTPaGx22OsVXkQaXuEN+rlG8EV7CZqBJbuq+oF4hJBO3ODppWcnospBpjxPAI5oa1FLEu8ookzb+sMFgP2k9s5NgwPxcpD2w3wZpiMXWwBLPDJd6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=16U86wz1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b24383b680so978232985a.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767820971; x=1768425771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncUyNfxp1tKqPdXXUZU761b7NHbtt4WBodxttjnVx/U=;
        b=16U86wz1gR9KrK7w0XqtNT/4SuHzIoKyKwkXsqffOhm+SDqt8g3xyz51XRlQR/FVAg
         Y9FG+C/tnIQlhvXqcv2pOMamWNsbhFWB/NaNbMonkCXWauJk2MObct0zC31HTDioDcLk
         eUbtzlNsInpd1xbxrggRvOkyHCnB/035jFzvjXM85dCaajlHzl8NYGJcG4fxHFwrXcxg
         CdC5W48nenM/8Vc2b1ko25aBCP6r6J4YKEb1CyhS24jB8qk89MCSrqwaKUVsPw8vVfom
         AK8VfWHL7wjvFtHAx9VbLg9uSTUK+WW65NpzunyK9Nm1T05GZRXZFOx/wldRi6sXN+nY
         jTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767820971; x=1768425771;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncUyNfxp1tKqPdXXUZU761b7NHbtt4WBodxttjnVx/U=;
        b=tZ3feuzST6mbd6baqySsVMshGIi5BMnHnOTH8RoXqzBY8aiXbrBJ2lbIg7/fvhVQ/A
         s55yZUy1csrlYSiY4p+wk1a+LDeB3mYsVR17aOFoOICy+G6i7SKwj9Pxh8G5gS+Nfl+C
         eup/9up1qvi145OT/JVx8xe5L+bY77rP/YsTG2FMitSeSbClmRU9Ti89m8QYoaxYnxUm
         ApDpOumuqdJm7l9ZG8i9qaS50ZbRSeS4oELUjZI83tbvEtFjky/x7WK2q+2KXWH7BR0t
         YNvAq/bCbqWlODW6/8i713ss1GPS+uSpQsxx+H6tQDfBdS60tSFJseWctX4a3DjX6K5Y
         md9A==
X-Forwarded-Encrypted: i=1; AJvYcCVG3nFXuqPygycVtkccdOiBjdav/BuG0TVvj7TDDTmE/XaExWLM//UBSLdhhrQQCZSVJ0aHb08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2A4WOy/PfKrid8ZjKEhRf+oThJb/2uz6jVnRx3C/4x99HVXV
	khQiqR3Aj4+tQ/XCWvu4kfrRuIshB20n3aBVJX5Fm8AfD1/Nnx8Co2tiP3jWxPnlYjt9CrwQgFK
	CJaoQRm1dASg8Pg==
X-Google-Smtp-Source: AGHT+IHLWgAzclw1nBM/ff+pviVF427z51M1ShxISa3v1jDGDSXsP8ppfc2enYUo4S10bI6bUIJlVvTE8fjZTQ==
X-Received: from qkdd8.prod.google.com ([2002:a05:620a:a508:b0:8c2:3e7d:fd1c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bd3:b0:8b2:1f8d:f115 with SMTP id af79cd13be357-8c38940a409mr540310985a.65.1767820971574;
 Wed, 07 Jan 2026 13:22:51 -0800 (PST)
Date: Wed,  7 Jan 2026 21:22:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107212250.384552-1-edumazet@google.com>
Subject: [PATCH net] arp: do not assume dev_hard_header() does not change skb->head
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+58b44a770a1585795351@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

arp_create() is the only dev_hard_header() caller
making assumption about skb->head being unchanged.

A recent commit broke this assumption.

Initialize @arp pointer after dev_hard_header() call.

Fixes: db5b4e39c4e6 ("ip6_gre: make ip6gre_header() robust")
Reported-by: syzbot+58b44a770a1585795351@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/arp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7f3863daaa407624359e8309cf9d661e1cdb03ac..c8c3e1713c0ede6dee1e4ae795a66d26bb534c43 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -564,7 +564,7 @@ struct sk_buff *arp_create(int type, int ptype, __be32 dest_ip,
 
 	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
-	arp = skb_put(skb, arp_hdr_len(dev));
+	skb_put(skb, arp_hdr_len(dev));
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_ARP);
 	if (!src_hw)
@@ -572,12 +572,13 @@ struct sk_buff *arp_create(int type, int ptype, __be32 dest_ip,
 	if (!dest_hw)
 		dest_hw = dev->broadcast;
 
-	/*
-	 *	Fill the device header for the ARP frame
+	/* Fill the device header for the ARP frame.
+	 * Note: skb->head can be changed.
 	 */
 	if (dev_hard_header(skb, dev, ptype, dest_hw, src_hw, skb->len) < 0)
 		goto out;
 
+	arp = arp_hdr(skb);
 	/*
 	 * Fill out the arp protocol part.
 	 *
-- 
2.52.0.351.gbe84eed79e-goog


