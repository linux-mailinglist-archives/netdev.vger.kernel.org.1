Return-Path: <netdev+bounces-217563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5DB39107
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C264614EF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F51E832E;
	Thu, 28 Aug 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lriOJ2gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063F20A5F5;
	Thu, 28 Aug 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344040; cv=none; b=KP59VCZ/joe988wipSRMe6mpCbbyecKEWH9Om6giXUpNZJwUcsaLqBmDUG9MF/wo9UBams6H7qdNYVA6npAiXuJi0DEc3lP5nhHi8oh8/iJVRgQdHPOHaknrh9n9f3B4tf0RpbP1pvrhSNhHDaz7Kz//X+yaJO7ERBirR7/f2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344040; c=relaxed/simple;
	bh=vqkPcdJQod0m5BVWyGwAjDrraADDRXWEMm73dgX+FNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYw8t2xYr+frA6uB1IirE85UAOukrwuuHDNSrNnEumogdyoLcLkkogqE65pQyt2FUbv2Q6dsMR7orxrOvaABE4mTafa4RQhaZIVLtIO6O3No/+4W84Lgn9UM0a+KeaNHk0X4Iu1XuBhIv8XX6E7St+fdfB76wrj6o5wLmYvVH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lriOJ2gn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e5f058so380446a91.3;
        Wed, 27 Aug 2025 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756344039; x=1756948839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaeoFshHMtgvD9F87e7oNCFPK7Xi319mzcoG27oQgjo=;
        b=lriOJ2gn3YS6d9rJfDb30f/GNSyhEw6713fl3QouL3Q5plsdttg7aYgCaBB8xM4CqS
         NdVVUXNttcjX+1VrIjGwBZNTsrd85vyQEC96b8b61xRpTNfB4qHpBgx+D4z3x5kqplx3
         XLxMJo/P0qqGsrTBT7f9sX4ZfW2MxdZnF7yw+BpQOF55lgWO/IkuYyFoCDAx00rmIHac
         Y5DfCclKvkIkTZWkhRD7nYdeT0VbhvLjQddV3Y/0N1XxC/xO/umwZBMxYQbl4DIgtHKE
         jDw2xNpBfFW3uAqZNlbNOEATTJUnXORDDmOMyePAVIH1Es89eounBjUDLOgn2AcwHD3x
         ZHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756344039; x=1756948839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaeoFshHMtgvD9F87e7oNCFPK7Xi319mzcoG27oQgjo=;
        b=frv6Y1rRKubZGcM2sq5ZfUZpjB6vZAAIZrdZKaATulpfIkP5sXFHDCLdCE8uhJjETR
         1UeUq/YA25+NnZHyNDBNhHbo8QwP0O+L7azAFGTzZoF4qMBSaPO2bFs/zLknNAiLI/3Q
         8k2dMT1Gym/C1dCkF5k3fD6IDu2RKsdp32nUNJcuHGjPK+tBYy+g66luHrTvy4mys/2/
         UqeyaHuON8PgXb3auLjltYEGcC37k5LPkHjQo79YpxkMNlHk+Et9697AMLk9AFER6F/5
         W8g7qiBaLdy6TkEHl1X4IZYxK4zerl6gL5k11/w5lCnDWXoCQUrqzdQI9eu1DBpxguKk
         VdBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMC8gTAGeHzXkKqnlXEd/sjf+bjxJhXuiyQx4i73INz6RgKiHEvKNfKUt+agA703fKUCLdQ5yvzexbxtg=@vger.kernel.org, AJvYcCXNK49Kzj454WMfbksz5brhO3rLKv3uNQKBCnJDfbxRRielL8RYp3INV/wGm9SIUyQSwmDSGh+S@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqTreQpq6tueXl9RbtnlN7rZFlbeMLjRmHx3LjoSawyy2CJwm
	G1P9oK8/M6/2tomiU4ZkfVhDQn4hrj5yaK76FZ+e9wdRlqo/aucalIoA
X-Gm-Gg: ASbGncvQPhwZkJGCudxlTECa2Y8Km9Ponh+aXx0CN6ozrS6TVdfg+s5BxCYATleDDS8
	zvaUswZs8buvhBOpOB8KBKJPa1pTKqOm4nVBugzcIgPbFmcFvsqtNok+bQsCmsVCYYeMZPXwEqQ
	6pF2FitAbPbGHzlRmfMkXEVlXxyFl3E3B87c/fsn6wsvsi+MhjO/GXMaY0EPhnghHbbsRj2X3VT
	QL3M7gb/xb5hzXuMffXu5qrWPPo0NNKXUpvgxY9/w5Y9+15BXgKJdOjPmeB1SHi3yOTwE66a1rt
	pgOeuCJHABKiB61v01d2zvorKca7NY2dj6d7wrYLTaNdS1K1rOWU+TeHiEP0Blo27O+J9aTaLTY
	9C6wi/T27IU9Q6E1GpZKthPSpNw==
X-Google-Smtp-Source: AGHT+IExVbmlhW+BfudU/4v29yLAXek2Eo2isnF5716D6BIHSp8I8nYhhwEadqaS4T4vkpWQ6KvdBg==
X-Received: by 2002:a17:90b:1d4f:b0:324:eb2d:7537 with SMTP id 98e67ed59e1d1-32515ea1b2dmr28118613a91.20.1756344038550;
        Wed, 27 Aug 2025 18:20:38 -0700 (PDT)
Received: from gmail.com ([223.166.86.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm9122626a12.35.2025.08.27.18.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 18:20:38 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] pppoe: drop sock reference counting on fast path
Date: Thu, 28 Aug 2025 09:20:17 +0800
Message-ID: <20250828012018.15922-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828012018.15922-1-dqfext@gmail.com>
References: <20250828012018.15922-1-dqfext@gmail.com>
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
v3:
 No new changes.
 Link to v2: https://lore.kernel.org/netdev/20250827023045.25002-2-dqfext@gmail.com/
v2:
 let pppoe_ioctl() call __get_item_by_addr() under rcu_read_lock().
 Link to v1: https://lore.kernel.org/netdev/20250826023346.26046-2-dqfext@gmail.com/

 drivers/net/ppp/pppoe.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 54522b26b728..4ac6afce267b 100644
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
@@ -820,11 +810,12 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 
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


