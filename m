Return-Path: <netdev+bounces-216775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C377B351B9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C581B6147F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2002271448;
	Tue, 26 Aug 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auAy8aQN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FED270552;
	Tue, 26 Aug 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175649; cv=none; b=YimOKKlxyVS7k75dQpE8+77l1qF7AY/VMDPyoVj0aNTg5JZJKxm+z3+7v6ygDWkxBdYAkic0FSv/O7/uu2Po5L7hD3wsikwfUF2hKIQxVLmfqbBzNi4ikBTFuTHm5WbW+b8T68g0ZXpfrRcpyMyr9TgWCLjc6h3uLPawXIg42SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175649; c=relaxed/simple;
	bh=k1t/LlnP/mkmSDWHsuqbxTK6w4ah9P86fcPx29Zj5FM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngnogCZzPNWAWwslfBQhp3tzw/0I/KlUKNoHfX/f8INx3qa28BsLDv2/RkCRyNXbj7D3LGYuUE8DsL+pJJeWQlJzWHYpYkI+zx17EUpqu0okhLJLQhlSBhTs5HSrVxoDwRgPoSBXlA5zzXoiEqWHw8z+nzkF7oppfRtAxDuuMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auAy8aQN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso4126426a12.2;
        Mon, 25 Aug 2025 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175647; x=1756780447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8dc5k8ySPQdrP8Vl4etItDSHUs3VsNRqUXLfLTfByk=;
        b=auAy8aQNZx1Tm5800YIYCePodKISlgm3JTn9YOEt6w2TeRrnSyUey5lu+4bocSYeJV
         eeQpiLE1hHvm/y8mzarKBwil0cNyndv/StreJru0liYb/7jR14reywoNTf47c1fxM/6I
         h0ROlGsqqmF05h6io3UvQ8DYzCGQywnIZ1WaKG1gcG8UCWVpSrrdvCJ6CfD02FJuVv5t
         YmXnAeRP3WnYrKBltQjHCxQsEu9Vx3CpXVnUkBPjd878CNgEgOEexo74T85YUVRaCEbB
         FsKfPbjJ0RAsJE6LNAl8+IJmoHVhjT2ku7v9IjMcRvS2RgDk1sU7m5pPMkdHhs7sEDsR
         1sZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175647; x=1756780447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8dc5k8ySPQdrP8Vl4etItDSHUs3VsNRqUXLfLTfByk=;
        b=ZkTXMmeOurRdAN3va6VNdL6e4W7eKIB1+JdK9k83TGAVqBRsL57APydmL/a3kXUe9M
         k0TlrnhNoomqRK+rkustDTLAAMU0cPKZCEDATx2CfqbvjCMJmQ7UJ81AcNxd4auB1HO5
         3aitQrjzFrH7XYTnP8Y3nkBmWE0zmT0NBiVq9uyFhZmxqSILFfdDwHCqWLHVhkCf+Vzl
         5dfOGCrcp03/OU/wJxUiGGGGPRviDj0kTLucvnQBJEO3K6tQH9ctafDkwmrWtjGFHEry
         jT+lGq68g0odMJXP68ckzMj2fCwhvGm81wthzrFYktJ/TV52eVPfZfl77dtTvRCUspAD
         1G+w==
X-Forwarded-Encrypted: i=1; AJvYcCWRhgLRUtD+mp0eqHp0icGtmYLfRr0Kq9fgItcawzCGPd0O2/pAelzIZ7gR1qy9bOoCPOgIOJXU@vger.kernel.org, AJvYcCWgIFtEM23CczQk8yPuqwJ+DxGNnzBVCkvSa9kBJ2dsAkdLAPDdKMzOab1NVmarubzFXmVqelWJ366Pc/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgteZfarkLNL5yFNpCX86jO1SHQhS5uSQBmJ1h9TLe07KdBSm3
	+oeDUUApHBS+Q72DBrHUfaJf3Lee6uD4640JAXM7yuLMJxrzXelS+Y/m/BtH97MD
X-Gm-Gg: ASbGncs5r4NDQj7s9Cm7v32Q7SCQW9NlNuGUYGaYpMt2MYHB9GKEubBYlj0eGtqJq/T
	18jcAMNPbBnRbkHYR/HG4atifUQDnCd5bqIseUNsTL9GqUBFRqS9CgULPZ6VlsBCr9UOD4CWY2J
	gkJgREdiCh2fjYjmD61MJuN+j27seJGI1U9eORBThU1maRpvOW8SGHfyJ87T7pSg+RdmZqSffl4
	WwfdRp50cxhGG5OIw0fqaAKnJJLu3RMp7wrdpjI+full7d2xVYtaZxB+r/nVdJRmsrBIfMhaks2
	dXhI6wUWfpVCEfrBkVM8Ya7bT4I25pAV6Z9n9R5dUm2nyAycBSItNEPkKnzqVDX9TpGGjJ6s3OB
	hGL7+AI5HgmflBg==
X-Google-Smtp-Source: AGHT+IEZEkMiDPYB4UWLJJK+iUI9w5Tg7HExiLm7M5IS6Wss4H3kb6aFo1cHeikYq90r+vUchusisw==
X-Received: by 2002:a17:902:c40f:b0:244:99aa:54a1 with SMTP id d9443c01a7336-2462ee0b77emr198007205ad.7.1756175647304;
        Mon, 25 Aug 2025 19:34:07 -0700 (PDT)
Received: from gmail.com ([223.166.87.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467a6f5489sm76072815ad.144.2025.08.25.19.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:34:06 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] pppoe: drop sock reference counting on fast path
Date: Tue, 26 Aug 2025 10:33:45 +0800
Message-ID: <20250826023346.26046-2-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826023346.26046-1-dqfext@gmail.com>
References: <20250826023346.26046-1-dqfext@gmail.com>
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
 - Rework get_item_by_addr() into __get_item_by_addr() (no refcount)
   and add check_item_by_addr() for existence checks in pppoe_ioctl().
 - Remove unnecessary sock_put() calls.

This avoids cacheline bouncing from atomic reference counting and improves
performance on the receive fast path.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 drivers/net/ppp/pppoe.c | 54 +++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index f99533c80b66..70a7e1e88799 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -237,13 +237,30 @@ static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 	return po;
 }
 
-static inline struct pppox_sock *get_item_by_addr(struct net *net,
-						struct sockaddr_pppox *sp)
+static inline struct pppox_sock *__get_item_by_addr(struct net *net,
+						    struct sockaddr_pppox *sp)
 {
 	struct net_device *dev;
 	struct pppoe_net *pn;
 	struct pppox_sock *pppox_sock = NULL;
+	int ifindex;
+
+	dev = dev_get_by_name_rcu(net, sp->sa_addr.pppoe.dev);
+	if (dev) {
+		ifindex = dev->ifindex;
+		pn = pppoe_pernet(net);
+		pppox_sock = __get_item(pn, sp->sa_addr.pppoe.sid,
+					sp->sa_addr.pppoe.remote, ifindex);
+	}
+	return pppox_sock;
+}
 
+static inline bool check_item_by_addr(struct net *net,
+				      struct sockaddr_pppox *sp)
+{
+	struct net_device *dev;
+	struct pppoe_net *pn;
+	bool ret = false;
 	int ifindex;
 
 	rcu_read_lock();
@@ -251,11 +268,11 @@ static inline struct pppox_sock *get_item_by_addr(struct net *net,
 	if (dev) {
 		ifindex = dev->ifindex;
 		pn = pppoe_pernet(net);
-		pppox_sock = get_item(pn, sp->sa_addr.pppoe.sid,
-				sp->sa_addr.pppoe.remote, ifindex);
+		ret = !!__get_item(pn, sp->sa_addr.pppoe.sid,
+				   sp->sa_addr.pppoe.remote, ifindex);
 	}
 	rcu_read_unlock();
-	return pppox_sock;
+	return ret;
 }
 
 static inline void delete_item(struct pppoe_net *pn, __be16 sid,
@@ -381,18 +398,16 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
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
@@ -400,9 +415,6 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
 
 	return NET_RX_SUCCESS;
 
-abort_put:
-	sock_put(sk_pppox(relay_po));
-
 abort_kfree:
 	kfree_skb(skb);
 	return NET_RX_DROP;
@@ -447,14 +459,11 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -790,7 +799,7 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 
 	case PPPOEIOCSFWD:
 	{
-		struct pppox_sock *relay_po;
+		bool ret;
 
 		err = -EBUSY;
 		if (sk->sk_state & (PPPOX_BOUND | PPPOX_DEAD))
@@ -815,11 +824,10 @@ static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 
 		/* Check that the socket referenced by the address
 		   actually exists. */
-		relay_po = get_item_by_addr(sock_net(sk), &po->pppoe_relay);
-		if (!relay_po)
+		ret = check_item_by_addr(sock_net(sk), &po->pppoe_relay);
+		if (!ret)
 			break;
 
-		sock_put(sk_pppox(relay_po));
 		sk->sk_state |= PPPOX_RELAY;
 		err = 0;
 		break;
-- 
2.43.0


