Return-Path: <netdev+bounces-119128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57F9543A8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F761F21D07
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313447DA64;
	Fri, 16 Aug 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="x7SWycSQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5254645
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795674; cv=none; b=c3ad3A3SwJ68AMj/KHkvuLKi3+ZL1r5jRXQRlba7FZsoH4irKv2s1+0HpilwZmdzCMgJQhSoNVfwruu3ge0FxYYs7tvdBumMvTLMTTjfMNLQENM9B9kkpONE1vPFOtr2/gYp+hYfr7Re1Lxm506ig8LXQ0jG7rHpkS4r9sKU9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795674; c=relaxed/simple;
	bh=IAKrMi8kBQupYy6ukVEd5/cWKbm/mkvKIuqwFV9AEEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jsz6Vhc9tE3DxLVmiFJm2S1G0TUh/DL38vmaaFpMeveMwV0lshy/O21f2/duyi6XApmVIhGF0ySRPqmdaSj6Zmf5DPXwsb8goydAxQw+4OSV6hKZT4KZZGMMgYdTimgwtHEZmUx9eMUpx6h7Us4+QYUqIK4lVaMSmsHzi1Gl/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=x7SWycSQ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6905:da9:4f53:5f2d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 806707DA1E;
	Fri, 16 Aug 2024 09:07:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723795671; bh=IAKrMi8kBQupYy6ukVEd5/cWKbm/mkvKIuqwFV9AEEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next=20v3]=20l2tp:=20use=20sk
	 b_queue_purge=20in=20l2tp_ip_destroy_sock|Date:=20Fri,=2016=20Aug=
	 202024=2009:07:51=20+0100|Message-Id:=20<20240816080751.2811310-1-
	 jchapman@katalix.com>|MIME-Version:=201.0;
	b=x7SWycSQuKCAiJH2AF2b+X+buOsP3KqCxlvZx+DwcPOMzoXIsNIPrqSm/f5Y7jWAA
	 1WSpFtz+JY2aEBjRKLs2Sv/7G9gyniGetEam0n3h/HRtstJ9CcB2HsZfu2EiQE4lXe
	 WWrwP7RZfw6ebTS88Dflz+LX4yrzyeZ/FQ+i/4rcmkfSzYhS99eexeF7NMIJXQnEgO
	 kJw+EHH+ibwo0weVbL1i9ivM+UL2Fe62aX6tO3FKXlvN7nTbzOyj7HHH08DFwWgf1i
	 prnzRJodeYAqsAZB++wJjLbjWt1aJLXZhx3DirUSTesV+A4WltY8jhRAB0B29Q4tUD
	 4aBihlkL0X1eA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next v3] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
Date: Fri, 16 Aug 2024 09:07:51 +0100
Message-Id: <20240816080751.2811310-1-jchapman@katalix.com>
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

Suggested-by: xiyou.wangcong@gmail.com
Signed-off-by: James Chapman <jchapman@katalix.com>
---
  v3:
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


