Return-Path: <netdev+bounces-217133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698EB377C2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D574D2A6156
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B919274B46;
	Wed, 27 Aug 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUe5HIzm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A2D274B5E;
	Wed, 27 Aug 2025 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261868; cv=none; b=Gdyz1jbmxOscqyOb3k0n8vIEbO3v/oZx66LPvIfB8sC49l/dwTigkc1nQ95Kt4xYZohLj9p5sbGkYkr9f8BJD0hdL7ANFD8Yx2WW8rCSDEy9vdApNLI7QK82G3LAAEF4d42qeWm8weq15GtRscR8w5G+a1wSg8bB3+YZFzctzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261868; c=relaxed/simple;
	bh=UsH29VEzKGfjdoIrHKgxZpQuSteEnapr88KYuXyYsBY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvWCA6fIiPzxVU9WtvzMOTChdMSuMXoujeEOEIZ3giu8phTs5vt3ccgK3tSpFCE3iGbFpxx2GLNEHvGU/DYcxDXI2MLlqmDOjusoVdwD+hllbhZb82qxkHVIC6PFSHwR9y8NatbdKWY2yjIESPyHtjnk1QODA9i0Dny2Y038F1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUe5HIzm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2465cb0e81bso29829695ad.1;
        Tue, 26 Aug 2025 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261866; x=1756866666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELQPbA9j9oun69aUaju4EsWrSj5hAvjhLzmU//1o98Y=;
        b=BUe5HIzmizAPu37e1xSlBgpi5b0xj8v5spawOz7vHh/EcjF5qYMWF+dFtW7MBm8j5p
         KcScbUKl+rtwNtSopBmJ+7iMydPNYqiXZ7I9FLAGlzfoSurmNVe3eJYV7td08xCtDRPO
         4UWbURppgtqPDlh+l8GR7tQ9yHSjDZrc2vOU5qic4Py/ICY9pDns8yfkCLy3obMyXHSl
         gh+Bhw+0S8yuVsjhmvXCXvNENIreIGEsF+1qEB1w3L0acxAFF9ZULZsQga5zjbxpFsFH
         waZ30OYjXDH8vmIP3pPrtiqe/NBXdgSDeGkmb1JfXunD2OOo6390C44nGZWadUTh/MKc
         75XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261866; x=1756866666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELQPbA9j9oun69aUaju4EsWrSj5hAvjhLzmU//1o98Y=;
        b=GfWHJm6jEm8i3ukaw2hcEqjMzr4v2nhtzhFPs/jH3HQdpG0V8Fka/9DmzkmSqxMe88
         pcWWblOICyk1jXRmnS4kZBQqtOrCbiLgcMkqg8V6iTgWfK4DAXfJfcbKKtoai5wKfirE
         0foaVK0CDSjsC3UfOhnH+zKb+Hqxlq5+tBjjbdhaEOFRBKwFJmRvTtAFyhL6z3pRP69d
         zphzWE9Prz5K6qKahX6uyiPMZD8Bl3WRS7hqX66eRJukQ/JyFh9kH5HzSgWNkoFFxm6h
         R4+Q257WCY0o5QmcFaA7tP6oqI3CuGIDnElN8EBfJx2dOg1lVKee/fgF69484DxxOlJH
         KNhg==
X-Forwarded-Encrypted: i=1; AJvYcCUXfXNlnNSJMODZzB0DLqkUtM/A0oVY9K98f+R++2wI4Giia0XDEh2uZ9Lk9Sz2MJ9RKWBNbdI0ly6DJlU=@vger.kernel.org, AJvYcCW6zO8zfKgIdGS/wnwm3G4X4HoD76e2MLa8oyV4eFJNFUyoNUURjH2ea2j71rEcGsTFI5nbCleG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuu2owJCdnSbZpDiVhOcnYyKyE26P5bnuSjxT8qHytBQ6XAtBX
	sUfN6GYQ95ctBIbrXaoIXO65QwZf3kXYy3/0EFkmbUaz2UNzbj9RxpS5
X-Gm-Gg: ASbGncugrEtU1e/ZBXvp9oOX4Avq8TQ1cDDHYVAinfRLO/IdeqZp84V90GXv0e4uHpB
	E8XcIAFSSTMYmdB/kY3LMUm8qdDDoI/M6681yfInWz17W58yqeV3aU3ftko4XXcb3V9t36A64MZ
	dlDUcf5FPcdAsLGCgjkLEY3P+YZxRr2t0bDI66Uh/+E2CulTYU9S1QIu4FHFNy0zSeki0Bju7c2
	9zRNTqr1nRvNN+JQel/prJs1Pq69YzlsDMJ13a8DlKY3fJeiWMd3tP8hkfLZgFAt4+o+l+rD1Lt
	AEABF8KEmh9hpc65Ivpc8cRbJbhDMs6VikDt3bf2A8/CK8Qu+fWMOAc3jPKWBFn+8j5Iv/XzKKJ
	C3Wz9RqeN0hNpGoZO/WeCaXPfCg==
X-Google-Smtp-Source: AGHT+IEbGAraGZ8WRe5yJCiR8pmLgPtMlwyRDsX1/6XvFHQAcx/H+BrsXtOLxPFK8pW4k9Y0iM9tNg==
X-Received: by 2002:a17:902:ea12:b0:246:f090:6d88 with SMTP id d9443c01a7336-246f090736bmr105692945ad.34.1756261866048;
        Tue, 26 Aug 2025 19:31:06 -0700 (PDT)
Received: from gmail.com ([223.166.86.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2487928c46dsm24007655ad.68.2025.08.26.19.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:31:05 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] pppoe: drop sock reference counting on fast path
Date: Wed, 27 Aug 2025 10:30:44 +0800
Message-ID: <20250827023045.25002-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827023045.25002-1-dqfext@gmail.com>
References: <20250827023045.25002-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that PPPoE sockets are freed via RCU (SOCK_RCU_FREE), it is no longer
necessary to take a reference count when looking up sockets on the receive
path. Readers are protected by RCU, so the socket memory remains valid
until after a grace period.

Convert fast-path lookups to avoid refcounting:
 - Replace get_item() and sk_receive_skb() in pppoe_rcv() with
   __get_item() and __sk_receive_skb().
 - Rework get_item_by_addr() into __get_item_by_addr() (no refcount and
   move RCU lock into pppoe_ioctl)
 - Remove unnecessary sock_put() calls.

This avoids cacheline bouncing from atomic reference counting and improves
performance on the receive fast path.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: let pppoe_ioctl() call __get_item_by_addr() under rcu_read_lock().

 drivers/net/ppp/pppoe.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 25939d6bd114..b43b1a55e487 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -237,8 +237,8 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 	return po;
 }
 
-static inline struct pppox_sock *get_item_by_addr(struct net *net,
-						struct sockaddr_pppox *sp)
+static inline struct pppox_sock *__get_item_by_addr(struct net *net,
+						    struct sockaddr_pppox *sp)
 {
 	struct net_device *dev;
 	struct pppoe_net *pn;
@@ -246,15 +246,13 @@ static inline struct pppox_sock *get_item_by_addr(struct net *net,
 
 	int ifindex;
 
-	rcu_read_lock();
 	dev = dev_get_by_name_rcu(net, sp->sa_addr.pppoe.dev);
 	if (dev) {
 		ifindex = dev->ifindex;
 		pn = pppoe_pernet(net);
-		pppox_sock = get_item(pn, sp->sa_addr.pppoe.sid,
-				sp->sa_addr.pppoe.remote, ifindex);
+		pppox_sock = __get_item(pn, sp->sa_addr.pppoe.sid,
+					sp->sa_addr.pppoe.remote, ifindex);
 	}
-	rcu_read_unlock();
 	return pppox_sock;
 }
 
@@ -381,18 +379,16 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state & PPPOX_BOUND) {
 		ppp_input(&po->chan, skb);
 	} else if (sk->sk_state & PPPOX_RELAY) {
-		relay_po = get_item_by_addr(sock_net(sk),
-					    &po->pppoe_relay);
+		relay_po = __get_item_by_addr(sock_net(sk),
+					      &po->pppoe_relay);
 		if (relay_po == NULL)
 			goto abort_kfree;
 
 		if ((sk_pppox(relay_po)->sk_state & PPPOX_CONNECTED) == 0)
-			goto abort_put;
+			goto abort_kfree;
 
 		if (!__pppoe_xmit(sk_pppox(relay_po), skb))
-			goto abort_put;
-
-		sock_put(sk_pppox(relay_po));
+			goto abort_kfree;
 	} else {
 		if (sock_queue_rcv_skb(sk, skb))
 			goto abort_kfree;
@@ -400,9 +396,6 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
 
 	return NET_RX_SUCCESS;
 
-abort_put:
-	sock_put(sk_pppox(relay_po));
-
 abort_kfree:
 	kfree_skb(skb);
 	return NET_RX_DROP;
@@ -447,14 +440,11 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	ph = pppoe_hdr(skb);
 	pn = pppoe_pernet(dev_net(dev));
 
-	/* Note that get_item does a sock_hold(), so sk_pppox(po)
-	 * is known to be safe.
-	 */
-	po = get_item(pn, ph->sid, eth_hdr(skb)->h_source, dev->ifindex);
+	po = __get_item(pn, ph->sid, eth_hdr(skb)->h_source, dev->ifindex);
 	if (!po)
 		goto drop;
 
-	return sk_receive_skb(sk_pppox(po), skb, 0);
+	return __sk_receive_skb(sk_pppox(po), skb, 0, 1, false);
 
 drop:
 	kfree_skb(skb);
@@ -815,11 +805,12 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 
 		/* Check that the socket referenced by the address
 		   actually exists. */
-		relay_po = get_item_by_addr(sock_net(sk), &po->pppoe_relay);
+		rcu_read_lock();
+		relay_po = __get_item_by_addr(sock_net(sk), &po->pppoe_relay);
+		rcu_read_unlock();
 		if (!relay_po)
 			break;
 
-		sock_put(sk_pppox(relay_po));
 		sk->sk_state |= PPPOX_RELAY;
 		err = 0;
 		break;
-- 
2.43.0


