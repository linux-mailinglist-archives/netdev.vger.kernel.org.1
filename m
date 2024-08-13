Return-Path: <netdev+bounces-117961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527D950157
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96481F23783
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7EB17BB2F;
	Tue, 13 Aug 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ckxUkD7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E08BF3
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541963; cv=none; b=H5+B1b3dsOCLyDjY4/iq2r0Mk64KW0LVYyJIEvOKBbZH/hbHrCX/izfDHXyMYzdZBLr8tEhRyodhZc+99493akm+lcuOxtF7K42TVZMz4xAC3MaPHFzNPCkFahxEsSXZXeGwezN3YorvGtxSpHv5jdRjBhE8zdFrgSzgnrMvATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541963; c=relaxed/simple;
	bh=MV6v4jSkO2tXUxVTHYU3dl7iZFPsR2ylTKMKZkVBxMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTCOYCXRpIQFW+/N6H8o3eyEAJRnMzFLfb1ocEKtx9tXMAQZ+dkoxAzUSHW+WRz740ngwrc0poCAFy0GExE7Ywg8p8L7GaFt6EKYgU0ufne8c7ZD1JLsH5z6BSe4ekt5ibqW9kC1kmo5CWy+wAfixC4GpEMaLqUGtAbEor3DMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ckxUkD7S; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:af87:af35:ed7:5bd0])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id DB1927D948;
	Tue, 13 Aug 2024 10:39:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723541955; bh=MV6v4jSkO2tXUxVTHYU3dl7iZFPsR2ylTKMKZkVBxMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next]=20l2tp:=20use=20skb_que
	 ue_purge=20in=20l2tp_ip_destroy_sock|Date:=20Tue,=2013=20Aug=20202
	 4=2010:39:14=20+0100|Message-Id:=20<20240813093914.501183-1-jchapm
	 an@katalix.com>|MIME-Version:=201.0;
	b=ckxUkD7S4tWr7jTEaHmVGBq1yFse2g7H9EB8LLsiIh9nAjV2AP6ihPAym58HM1hGd
	 l00h9qiFsuFGqnOklqnd1CSHHxXbBuV/dBmXJoxY6JGBMkn3G+ouzmMJ8xdRCN6tak
	 vJCkmRnKiF0sQeSHwfWvRDb8oVPO/m0ZS899NlwiieWNgeCn+g6vF+DpDtzRAC780q
	 AWWNyJSdFupoz2JHKLhCadzUzThyFpZ8+YjpZpi+6jKMzJsix3CSvnmsyOYfcDE46C
	 tLiy2pSzZF6E3Pqc0vx/m2gn0TSxamYraawRun6OdfGgKymKp2sG66v2MxGy4barZW
	 nc0E1KprMr5qg==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
Date: Tue, 13 Aug 2024 10:39:14 +0100
Message-Id: <20240813093914.501183-1-jchapman@katalix.com>
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

Suggested-by: xiyou.wangcong@gmail.com
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_ip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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


