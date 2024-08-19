Return-Path: <netdev+bounces-119755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDD956D7F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB71F25972
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956CC171E40;
	Mon, 19 Aug 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="it3l6rB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33716C683
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078334; cv=none; b=UQcVLyrjGhsWPJrtSJYFoGfGxY/r0g4UTn7qzCrixxtA8VSEabD5SSNVWu3sR1gcSNBEw8E7Z0o70mzHPgOod0vyXVpaaXghhMUBioFD/Nz7RhKrVZ+/8WM4ohLr5Ne1maUL4pb4yMem5IHTqsPPnaIT1FVndfNV3N3YX21uEkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078334; c=relaxed/simple;
	bh=mwz+eB5scRaKMChxMLOVbPLn1aJGRoemg8HSzFt13Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Od+YDzDylGinDJvnDE5+Vp6KoDGuGOjgROS+jq4AsqKyHNJER7OYey+ni4C12KDzY5X+I06wPTTIO0EU0MaxMpCzN6xD/ZME0p3jn85fmTw2pqe1tQGCtYMv843yZ1Kqd3NPIWZJDqZM92mZSZmDLCapsnTcWEFZmoeKiRqvggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=it3l6rB5; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:42ef:82e5:ff01:56ce])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 44C8A7D9B6;
	Mon, 19 Aug 2024 15:33:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1724078013; bh=mwz+eB5scRaKMChxMLOVbPLn1aJGRoemg8HSzFt13Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next=20v4]=20l2tp:=20use=20sk
	 b_queue_purge=20in=20l2tp_ip_destroy_sock|Date:=20Mon,=2019=20Aug=
	 202024=2015:33:33=20+0100|Message-Id:=20<20240819143333.3204957-1-
	 jchapman@katalix.com>|MIME-Version:=201.0;
	b=it3l6rB5kSdPHIAwAHPwMep805I0tDnrMg055I90DQZ5s42VdjftXqbjiFtB6TFmJ
	 FzxIl03pfUJvZRGmj1vnD8RAbA5O1IiMUQTS765J/TVhGd+baRyB146i6YvOJeJeDY
	 +ragMZ5EQDaCXisue6Z5MxVRDMNX4FbhbhVPOxeiQmfKImH7PucWnuQuQVapKK2xzj
	 xFZ6GRSgFvmJXmZwZgUWjutIB+okZfl/bLBwcb44ibUDWse0sRFo0VjeP5wFotk2mz
	 1zHo65oyjoVfWyZJ2xWPZiLsDxPwzNwAb7+J9LBm+1qrriHj7/0xX5HJw+2UGHpiEs
	 9DP+TkC1KnEbg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next v4] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
Date: Mon, 19 Aug 2024 15:33:33 +0100
Message-Id: <20240819143333.3204957-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
socket cork and ip_flush_pending_frames is for sockets that do. Use
__skb_queue_purge instead and remove the unnecessary lock.

Also unexport ip_flush_pending_frames since it was originally exported
in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
l2tp and is not used by other modules.

Suggested-by: xiyou.wangcong@gmail.com
Signed-off-by: James Chapman <jchapman@katalix.com>
---
  v4:
    - use __skb_queue_purge (eric)
  v3: https://lore.kernel.org/netdev/20240816080751.2811310-1-jchapman@katalix.com/
    - put signoff above change history
  v2: https://lore.kernel.org/all/20240815074311.1238511-1-jchapman@katalix.com/
    - also unexport ip_flush_pending_frames (cong)
  v1: https://lore.kernel.org/all/20240813093914.501183-1-jchapman@katalix.com/
---
 net/ipv4/ip_output.c | 1 -
 net/l2tp/l2tp_ip.c   | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 8a10a7c67834..b90d0f78ac80 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1534,7 +1534,6 @@ void ip_flush_pending_frames(struct sock *sk)
 {
 	__ip_flush_pending_frames(sk, &sk->sk_write_queue, &inet_sk(sk)->cork.base);
 }
-EXPORT_SYMBOL_GPL(ip_flush_pending_frames);
 
 struct sk_buff *ip_make_skb(struct sock *sk,
 			    struct flowi4 *fl4,
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 39f3f1334c4a..4bc24fddfd52 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -258,9 +258,7 @@ static void l2tp_ip_destroy_sock(struct sock *sk)
 {
 	struct l2tp_tunnel *tunnel;
 
-	lock_sock(sk);
-	ip_flush_pending_frames(sk);
-	release_sock(sk);
+	__skb_queue_purge(&sk->sk_write_queue);
 
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
-- 
2.34.1


