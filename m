Return-Path: <netdev+bounces-163096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F185A2954B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8CA3A33BC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23201DBB03;
	Wed,  5 Feb 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxwHKbOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8C1DB127
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770697; cv=none; b=TXVjJ4cuCPRYx9aSuT9qUySyMpuo/1HfUPr0oiIWO3f0i6VzUzyvl2kC9oX24E7duq2xIjxMMGd+JwzGXKabTpxI1YNQ8M/LPooyRkNPkF6Gm6CH+Dd2AP/NJ6KSlVh9sbGdmegY8EFxwjabwA7hX70sZaDiDiq7gW/ub7vHi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770697; c=relaxed/simple;
	bh=u+DZYCZ71qEmcoaM8BqYeimI8o1k+MxdZFJa9VQVe5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKZFJl+83I0KmyEWoZWUk0Zs3c4HZNTHfzPNroEMCkFbuqr02MlepzhpFZE8EoKIqhZmFgBdV+pbX5AbCAoxTZcAD+pzymHkAPXPTBoU26ZhKaslkfimMhrmKQN9SbU5fdSQrYyD0SxTx5cvSeAN9wq4eOWv/oI6KoIjC2RXeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxwHKbOW; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46dd301a429so143134601cf.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738770695; x=1739375495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkUZ2e8rWS1eur8t+u5qtaW84WZ8tA0iHVb0xvGzMSA=;
        b=SxwHKbOW+JAnbtQ6D5t4AIV4ufQGCIDpYATiwx6S2OIWBGYdkIiFw/PRcTByZOfntn
         gIcluCx1Q5xX2DFxCCYbZKRw6k6NvzT5BjnTUaLdW2rN7ApcloV134Z57OBUfqDNTkzu
         N3V0O8fKZiPsgbr1p25NWSYcWQ03+buHQKo7aoI6ww1yMAiTiMbbl9MhOfywhB0+6B4d
         vWwB3zmSGEDSSQKOFk9nXVygrKORqR1K5t51J4jB2zjWNa2pXsTg3rVA8V1wmzqTudYR
         ldIJ/LY5SwpbARWEaFvGY8i24suX/cAKLdkqz/eMP+8U110mHF9xy44Mfnqeo+wNliRu
         uZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770695; x=1739375495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkUZ2e8rWS1eur8t+u5qtaW84WZ8tA0iHVb0xvGzMSA=;
        b=HUOF4kFAZSWfcCrgUIt7+o0yrmNOYoFaLCT3ElhhNiZ+5q2N0f2xhFoZRb+Jssfu8t
         Fk4fgWPZmauCj9CzdqPLp6rduPjRGxFrxmtsNaNq923s+CRiJR7VikNXOsF6W2Uafldo
         NCrqBHM9xdCaKMU1iF+koFw5BO26rZ2kFZfQ9Nn5vareIuuVatthUDQ25rECeH1P3TZd
         7/8A/Ggfq5+OazyH0/crT6lo+vTvXWpaqawnok993DDAMuevc0bC5goXEQDS8SZOgRNQ
         Rt2Oz7/M3JvlSIoj4pebX2Q5dwvldL5rWLMXV28MOIDlGUUxkx03xuuqc7GhxiYX+5wF
         vHZg==
X-Gm-Message-State: AOJu0YzEAbsqMxYIhMZG7IsAXxjQQX78K7+iTxv5A0pyBiKOMv4UQL47
	z6mHD5CKIhsT0dnZ43p7oiZFgTvoFkrEjblpO2VDRa8Ejc6hpCZ/AfnPkaf+Ri5oeI1ZkNZBB7O
	sdR2kHg+tZg==
X-Google-Smtp-Source: AGHT+IFLKxDzKfAGHl5zrgXfoiIZb4rgaIU3svpbMHUsdpbH6OVCRB58g8yp07a4Toi4vlR9iv0vBT+noLXN0w==
X-Received: from qtbeo9.prod.google.com ([2002:a05:622a:5449:b0:467:5293:b05f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fcc:0:b0:46e:4de6:8a06 with SMTP id d75a77b69052e-470282df32dmr38040241cf.52.1738770695183;
 Wed, 05 Feb 2025 07:51:35 -0800 (PST)
Date: Wed,  5 Feb 2025 15:51:18 +0000
In-Reply-To: <20250205155120.1676781-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250205155120.1676781-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205155120.1676781-11-edumazet@google.com>
Subject: [PATCH v4 net 10/12] ipv6: use RCU protection in ip6_default_advmss()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip6_default_advmss() needs rcu protection to make
sure the net structure it reads does not disappear.

Fixes: 5578689a4e3c ("[NETNS][IPV6] route6 - make route6 per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 78362822b9070df138a0724dc76003b63026f9e2..ef2d23a1e3d532f5db37ca94ca482c5522dddffc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3196,13 +3196,18 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
 	struct net_device *dev = dst->dev;
 	unsigned int mtu = dst_mtu(dst);
-	struct net *net = dev_net(dev);
+	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(dev);
 	if (mtu < net->ipv6.sysctl.ip6_rt_min_advmss)
 		mtu = net->ipv6.sysctl.ip6_rt_min_advmss;
 
+	rcu_read_unlock();
+
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-- 
2.48.1.362.g079036d154-goog


