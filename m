Return-Path: <netdev+bounces-166434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B96A35FDB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DE57A0418
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C141264FB9;
	Fri, 14 Feb 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alElYHhg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D51264A71
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542029; cv=none; b=k8NArNPSSeNTpmAvjYoYL3Od/xGNlDvhmX+rOkvfO5aszwjeySjB8kAPMCl24RI+j2ev23p2uhgxk5jh9yWCTpbxAZkFqcA7NnznfkArJetgjiAZOSiMmngkAU58PIGD5KUY8VEjTbY4VrBYRPGiWBoV04iG0btuzj+NGZV8jG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542029; c=relaxed/simple;
	bh=ktEoy+KXx9BFRbEPZYCQvhuIBQN8txNCPAlE+1d9QOU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cPLXHDkS0Ym6xHjixctelDiR9atLhShlUb7YLGydSvGngy7GcNiT4a7Qpo/RinQJpH57pUAcPXA+D3ssFVqbFONCrV2V7bySt/pU834Bv17JIKg8XxYLc/HGWVfqce8PDVbXwSv1SBEvrG2VJJBuxuAtEd7kSYo8r1T4FDQ33Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alElYHhg; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471bd14a944so22146531cf.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739542026; x=1740146826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r7Tmu5o9btXDUbqdBjx2LEc7deiCxNCnqNor3oY9wMg=;
        b=alElYHhgUP4DYpQRcYj79OTk7mI9j4/Iyj16yP0HZONe8eylifIe0SUZI9XxP63WIF
         7L46CvXhU12YQI05pxQKWIHVVDWGmuglx7wBmsEMLgUUOTf/KGisi0PnQnK0VEGjhwhN
         Vown8QGDYpS/gSAq3/1oXxxJu2YTu2WaXHPRrUVIg8OzBgpNwXHPS+2oiASFQZO9lG9F
         TTqmUD1716l7TGRC9RURtFWQh6H82E0vAtHgb2p216f0YtFm/BpttqIFFvGKTf956UCD
         pT8qSkhnilZbRZ5K1cnHShxjsAalLG+pBHthwZQTI8uv/GCrvPNFyNW70533Co/iyJbP
         3mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542026; x=1740146826;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7Tmu5o9btXDUbqdBjx2LEc7deiCxNCnqNor3oY9wMg=;
        b=UvBbHVgwMEX2OKTQo9cUCAO0Zoaqp8Y6AllqZ31y1fBlyjIfh4HGeLc0ah5zlxS6eV
         aI/Is99hxcxInuSHd1CnL6zyeICgELCQth6sS/SSNHwwROyBt6LFJSH1hUYS2IRBOEGp
         4sexRQGWz9DT6zAq6vEv7KO+oQJs1zip83awxPkEbTO6NVhhQT0OlF23hEJg08wUR90x
         0ZE1+JoTYnwJvRe+tLEbMmdrFcd9poXMxPKFR+zROoAsNQIWKpIoY0pT+C9Q5VZleodZ
         9JbjUAmuhih6lZRQV91kvSx8Ig8u4Fh46LY+aSf0E1h5QVOXqLCxMSwDOYk724sAIv0Q
         lQdQ==
X-Gm-Message-State: AOJu0Yzrx7GknHqc4CbzL1g2+Dg1WT3z9doMbRKplX2CuImeffRTet3H
	eE9FRT6sXQWxEjWzkA44BqTefYTNzVoGP8x8GdaYyscl8K/o3ElgGt3vTmETq6HNpNeVrOzUK/U
	tbD+dlCY/tA==
X-Google-Smtp-Source: AGHT+IGIKZEoCsXXr1LKbq1kHXRn5peF+HzjyyKQj5TNUXuBCL5BW1CYZSUTV7Hz5Fl/+/jNJj+bqbzKGOJZmA==
X-Received: from qtbfj21.prod.google.com ([2002:a05:622a:5515:b0:471:bff4:313f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4a0e:b0:471:c0e6:d4bf with SMTP id d75a77b69052e-471c0e6d5c8mr101186521cf.0.1739542026743;
 Fri, 14 Feb 2025 06:07:06 -0800 (PST)
Date: Fri, 14 Feb 2025 14:07:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214140705.2105890-1-edumazet@google.com>
Subject: [PATCH net-next] ndisc: ndisc_send_redirect() cleanup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ndisc_send_redirect() is always called under rcu_read_lock().

It can use dev_net_rcu() and avoid one redundant
rcu_read_lock()/rcu_read_unlock() pair.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ndisc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 8699d1a188dc4a15ac0b65229c4dd19240c9c054..ecb5c4b8518fdd72d0e89640641ec917743e9c72 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1680,7 +1680,7 @@ static void ndisc_fill_redirect_hdr_option(struct sk_buff *skb,
 void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 {
 	struct net_device *dev = skb->dev;
-	struct net *net = dev_net(dev);
+	struct net *net = dev_net_rcu(dev);
 	struct sock *sk = net->ipv6.ndisc_sk;
 	int optlen = 0;
 	struct inet_peer *peer;
@@ -1695,8 +1695,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	   ops_data_buf[NDISC_OPS_REDIRECT_DATA_SPACE], *ops_data = NULL;
 	bool ret;
 
-	if (netif_is_l3_master(skb->dev)) {
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
+	if (netif_is_l3_master(dev)) {
+		dev = dev_get_by_index_rcu(net, IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
@@ -1734,10 +1734,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 		goto release;
 	}
 
-	rcu_read_lock();
 	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
-	rcu_read_unlock();
 
 	if (!ret)
 		goto release;
-- 
2.48.1.601.g30ceb7b040-goog


