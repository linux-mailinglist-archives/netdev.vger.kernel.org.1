Return-Path: <netdev+bounces-113698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913E93F99D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D370F1F22F92
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299F1598EC;
	Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="jqs2I9Mc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272A7158A30
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267497; cv=none; b=RnElnnNouI9hDecxcn+ZGgrnu3vO/j4VW4vOhnf5M/UovfRcKZ6tR71dDPllIMSskbgFfdCICEhwiNUWbmqaDBy7Bwvzg/l5/tKi0DPze8Ov+9adXqqdlG+M7fVyvnzQvgy/9Gm8ymQNpptsZ5X6Z8cmJwfph98gGdYW5qX+nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267497; c=relaxed/simple;
	bh=Ew0XeQ+fh2/XZSpPp/yD0eYvnngadodiRmK9HwWtnbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V46KeyHw5LrF7VNoR5bJR/pSbEeRX4B4xYnufev0XmQ9+HJlcM5EeARijFWaWJq5JidAUs6qErtBmdo9bwwfWq13C8TPX5Aexru4m1i4RoxxQGAW1XWfiQ0EncK4TZTSEgUiqmniKtI18qmU5JckbtoaQSUKQpl9kmTjl27KDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=jqs2I9Mc; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 5A6B87DCAF;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=Ew0XeQ+fh2/XZSpPp/yD0eYvnngadodiRmK9HwWtnbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2003/15]=20l2tp:=20have=20l2tp_ip_destroy_sock=20use=20ip_
	 flush_pending_frames|Date:=20Mon,=2029=20Jul=202024=2016:38:02=20+
	 0100|Message-Id:=20<8491d89e8ae68206971f35c572190ac8b7882c1d.17222
	 65212.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.g
	 it.jchapman@katalix.com>|References:=20<cover.1722265212.git.jchap
	 man@katalix.com>|MIME-Version:=201.0;
	b=jqs2I9McRnxePHSIgueVl+DnJy0t1hOyo7ddA2c4xPyNzfgjbk/SoYizAgdvft57f
	 Zcu+JjpbEjd6lA2mvk53dNe1HJTzJ/n5iYog7K5yBqXd9+qmahUklE4Ff20O1Zanlz
	 Y35jo0ZPgmaBcjTth3LmzIB1nVuY5D49mTuv8j8K67kY9rS7tX+bwjTwV3NR06I2qO
	 qr8Ietj0MMHmqg7CxjyMgUZ2kQeQfeZ/2rqauWGaTQTzWO5sLB4pFO84GhsJfb/U4D
	 tvSryi0OINTc04gaK8suNIi/BtK7hPtDmRTNeEFUH9mecnhA5CF1lVsFyCjAgUY19k
	 VKCfQyka5tLnw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 03/15] l2tp: have l2tp_ip_destroy_sock use ip_flush_pending_frames
Date: Mon, 29 Jul 2024 16:38:02 +0100
Message-Id: <8491d89e8ae68206971f35c572190ac8b7882c1d.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the recently exported ip_flush_pending_frames instead of a
free-coded version and lock the socket while we call it.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_ip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 78243f993cda..f21dcbf3efd5 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -236,10 +236,10 @@ static void l2tp_ip_close(struct sock *sk, long timeout)
 static void l2tp_ip_destroy_sock(struct sock *sk)
 {
 	struct l2tp_tunnel *tunnel;
-	struct sk_buff *skb;
 
-	while ((skb = __skb_dequeue_tail(&sk->sk_write_queue)) != NULL)
-		kfree_skb(skb);
+	lock_sock(sk);
+	ip_flush_pending_frames(sk);
+	release_sock(sk);
 
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
-- 
2.34.1


