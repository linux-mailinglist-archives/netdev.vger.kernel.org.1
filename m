Return-Path: <netdev+bounces-223277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E3B588E7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFABD5206D0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70871581EE;
	Tue, 16 Sep 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As0mvFIR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3372155C97
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981171; cv=none; b=mWVzYdI5QlAIh+XRL4Ryb92xmfZAZYGgTovYXUYxTrmeRLQqv6NmByPrKx1gjqeIjZi922GUTsepuQiRj6OkCAMOavjpqE0HH09cGHCqJDr+ER9BKLzmvCTXuBWhoV7xm56EhAfhIxwUSWDab34jEI9OgThtjBComFVdwoA/gYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981171; c=relaxed/simple;
	bh=B9iXRqVukdG5dQox7VpxoFqAWFbtlwcH/aaegLFK4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTXIxZeU3anKUgWS50uSbbYRy1wwZA1qwMTKIwAMNxl/G/lp5jePLVHPk3c8PFcRyPIUIGZ7kEFjLHFWA5fwSINIb/MUuTAKztU7fBMIiCBYeSZqV4wCtP5cLdI7XP7wUPKtCbzz5UYYMF+vyV/nE2zXcQMYw+QCFF1Xo8g1ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As0mvFIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36C3C4CEF1;
	Tue, 16 Sep 2025 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981171;
	bh=B9iXRqVukdG5dQox7VpxoFqAWFbtlwcH/aaegLFK4Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As0mvFIR1s+ChXQl/9aR01XgHCLOXDrPMFjxnZKGc2QhCrTUy7eBb1UFgpt4cARTO
	 9pn24URv43w1ILVOT9kHr8SrW4P8/HszZPomjqLQBem6MdnKYCWiH/8zaoVSEWGigC
	 p39d3t20F2sXE3skfl7mbwkputOxKRoLIYzVD3PNvVouB+G88r/W74dZ685v8VnKTR
	 ityvpVvCaE7ITScn1siXkfXvuKdjVFFLUOmA5iqE3tJA6NGmhh0WMuHXC9AA7jmYnV
	 TI7M/zz/EUBGHgKbf55AK1N+wFIdUWsADJOkklkh2AIw6abtAvZ+Vd1GvGLkQ/kpTV
	 BpcR2GIFGB7IQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 07/19] net: tcp: allow tcp_timewait_sock to validate skbs before handing to device
Date: Mon, 15 Sep 2025 17:05:47 -0700
Message-ID: <20250916000559.1320151-8-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Zahka <daniel.zahka@gmail.com>

Provide a callback to validate skb's originating from tcp timewait
socks before passing to the device layer. Full socks have a
sk_validate_xmit_skb member for checking that a device is capable of
performing offloads required for transmitting an skb. With psp, tcp
timewait socks will inherit the crypto state from their corresponding
full socks. Any ACKs or RSTs that originate from a tcp timewait sock
carrying psp state should be psp encapsulated.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v3:
    - check for sk_is_inet() before casting to inet_twsk()
    v2:
    - patch introduced in v2
---
 include/net/inet_timewait_sock.h |  5 +++++
 net/core/dev.c                   | 14 ++++++++++++--
 net/ipv4/inet_timewait_sock.c    |  3 +++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index c1295246216c..3a31c74c9e15 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -84,6 +84,11 @@ struct inet_timewait_sock {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	struct psp_assoc __rcu	  *psp_assoc;
 #endif
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff*		(*tw_validate_xmit_skb)(struct sock *sk,
+							struct net_device *dev,
+							struct sk_buff *skb);
+#endif
 };
 #define tw_tclass tw_tos
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 384e59d7e715..5e22d062bac5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3915,10 +3915,20 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 #ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sk_buff *(*sk_validate)(struct sock *sk, struct net_device *dev,
+				       struct sk_buff *skb);
 	struct sock *sk = skb->sk;
 
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	sk_validate = NULL;
+	if (sk) {
+		if (sk_fullsock(sk))
+			sk_validate = sk->sk_validate_xmit_skb;
+		else if (sk_is_inet(sk) && sk->sk_state == TCP_TIME_WAIT)
+			sk_validate = inet_twsk(sk)->tw_validate_xmit_skb;
+	}
+
+	if (sk_validate) {
+		skb = sk_validate(sk, dev, skb);
 	} else if (unlikely(skb_is_decrypted(skb))) {
 		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
 		kfree_skb(skb);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 1f83f333b8ac..2ca2912f61f4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -212,6 +212,9 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		atomic64_set(&tw->tw_cookie, atomic64_read(&sk->sk_cookie));
 		twsk_net_set(tw, sock_net(sk));
 		timer_setup(&tw->tw_timer, tw_timer_handler, 0);
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+		tw->tw_validate_xmit_skb = NULL;
+#endif
 		/*
 		 * Because we use RCU lookups, we should not set tw_refcnt
 		 * to a non null value before everything is setup for this
-- 
2.51.0


