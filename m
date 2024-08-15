Return-Path: <netdev+bounces-118749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F9952A16
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F8D1C21312
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77074179965;
	Thu, 15 Aug 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="NFbpqKEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135A17B4E5
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707801; cv=none; b=aXsDI+YW1C1f0Yec0G9LWVzMNUcUrGchTkg/lCITgE12eIe1XJ0OduPPvmbmODLe8mpW+xjQeOvItJVGJ1vSPS9FjH1Qs6+z/st2NuaAQ4YiMOOlINhH6QcOHoJaIWSBjafB9cYob04+YpTEUcec+DpaKVBts6tVtrj4oRVHXSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707801; c=relaxed/simple;
	bh=P4pIVe1BYrGKxOEDHyqYXAYrTjEDVpHvcxwvLaFg7p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwMm5XAk8zQlC8BSbgjdMP6fAfjbT/iRWKm2+Wy75TQs36Uj7JRgjMDOpj3GtdeNK75DXDYGcrUt9tbvYYBttkYbmkPRXVLp/i7Kc1KYoLe9p6Qot5yFQUflnRIYHVDwmuh34GsamOUVNXCaVFawP/8AwBJi3eF22K/9dopym/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=NFbpqKEO; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:712d:ca1e:f0c3:1856])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 7BA2A7D8E0;
	Thu, 15 Aug 2024 08:43:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723707793; bh=P4pIVe1BYrGKxOEDHyqYXAYrTjEDVpHvcxwvLaFg7p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next=20v2]=20l2tp:=20use=20sk
	 b_queue_purge=20in=20l2tp_ip_destroy_sock|Date:=20Thu,=2015=20Aug=
	 202024=2008:43:11=20+0100|Message-Id:=20<20240815074311.1238511-1-
	 jchapman@katalix.com>|MIME-Version:=201.0;
	b=NFbpqKEOUvjMAlFRQD9j8PB1/pmvP/f/C2qv1M+PqlV86zetV5jnCf4rciHP8yvVY
	 dHjqPEoiFYnRqo5D7NjdYdQV+5T2PAZtVrgUu+NP0uvPkmdkI2eh+QTMM9JR7RGjjh
	 unfdqDZTQvZyz/GOMVzPJnt0/0ilKOnA6pFI919q1r1XP67mrQh2uRTfnc3FxVn9Q5
	 wl31MtWJMX0bVwgpEwxDXocse21bfukLxlF+WA6mSnbeGfCF1QDdqeS7CAbCwwe+qE
	 DnmWg+3S+1se41lZ1E7PdUmBDR0wWwikqK+wbjm0k8Pq8BNXfrRGJLY8IY2Iv08mTH
	 MOCsEJnBfAe2w==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next v2] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
Date: Thu, 15 Aug 2024 08:43:11 +0100
Message-Id: <20240815074311.1238511-1-jchapman@katalix.com>
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
skb_queue_purge instead and remove the unnecessary lock.

Also unexport ip_flush_pending_frames since it was originally exported
in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
l2tp and is not used by other modules.

---
  v2:
    - also unexport ip_flush_pending_frames (cong)
  v1: https://lore.kernel.org/all/20240813093914.501183-1-jchapman@katalix.com/

Suggested-by: xiyou.wangcong@gmail.com
Signed-off-by: James Chapman <jchapman@katalix.com>
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
index 39f3f1334c4a..ad659f4315df 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -258,9 +258,7 @@ static void l2tp_ip_destroy_sock(struct sock *sk)
 {
 	struct l2tp_tunnel *tunnel;
 
-	lock_sock(sk);
-	ip_flush_pending_frames(sk);
-	release_sock(sk);
+	skb_queue_purge(&sk->sk_write_queue);
 
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
-- 
2.34.1


