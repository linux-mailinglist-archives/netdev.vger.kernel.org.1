Return-Path: <netdev+bounces-112592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC993A1FB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4F7281B48
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B50F152780;
	Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="vh7Yy0WW"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ADC137C35
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742713; cv=none; b=JDUdN3ZHcg3mOyUj007Cxsro9IsDyypPC37MHvmcq6bCkP/E9Ht2YlrHQvLpSi6BKScJGuSitEivbLfiZMP7Hu0aLvWlbzHt9kvajPDme40vSVEofIVtU50CD/GPan+iREh2lsc539jp/q1Ey6N4n/1qj3At6ihtOQ8x1h6uuGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742713; c=relaxed/simple;
	bh=VE7yj3tP2lPXlfAiG1eIKhYkzT06WlSIwoLknWtjrJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYUmYHYTfethYNh3C8MF4nQvlOFqhQ55H/xT2xdrJZA7cTwK5Ti+XMNoH6Y4v3Z03mIaBjry0j1jEH4dh1NLpFQQ0gz9T9oHqEoGOsBBRKt7KnmTMT5FMFL4jRw6OA61zmbFJSDIxe44vpwBoCHlaPOx6rSimoMoo9vB1wZz3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=vh7Yy0WW; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 5F5BF7DCB8;
	Tue, 23 Jul 2024 14:51:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=VE7yj3tP2lPXlfAiG1eIKhYkzT06WlSIwoLknWtjrJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2003/15]=20l2tp:=20have=20l2tp_ip_destroy_sock=20use=20ip_flush
	 _pending_frames|Date:=20Tue,=2023=20Jul=202024=2014:51:31=20+0100|
	 Message-Id:=20<25737cb5fef11f8da3577589872944001913982c.1721733730
	 .git.jchapman@katalix.com>|In-Reply-To:=20<cover.1721733730.git.jc
	 hapman@katalix.com>|References:=20<cover.1721733730.git.jchapman@k
	 atalix.com>|MIME-Version:=201.0;
	b=vh7Yy0WWnrO/6SlvpAFGtHbc+bT9AQAvvN8EuSRrRAR29lwA2nSk+cz5JbauKG9Gg
	 nZCrWGh2OHifBbC7t/qxOuPTz8XxPuMbjALwQYsUT1paGJ5TpsF4WGlcNitVBdh8XF
	 jA+ohJNCgR/WfW7gWX0atIDPJU8RoBar5k9t7mJ8NOl8UrgOcJF2Y0090/sm7KNf5F
	 xkj1Se5yILwbIJlXWK+PwqSdUkONl9jj/yOv3wG5C7zcxtBppqcH8AxtAfMbVehbPm
	 IaSFRaEfNZsPbhnIR+FIDn8TekE50kTibLRroCnQap8utdb3BCmXVpTIIueCT3vqdT
	 xQqKcFm0oxP1A==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 03/15] l2tp: have l2tp_ip_destroy_sock use ip_flush_pending_frames
Date: Tue, 23 Jul 2024 14:51:31 +0100
Message-Id: <25737cb5fef11f8da3577589872944001913982c.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the recently exported ip_flush_pending_frames instead of a
free-coded version and lock the socket while we call it.
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


