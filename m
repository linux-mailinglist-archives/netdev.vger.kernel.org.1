Return-Path: <netdev+bounces-250806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD0ED392AD
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 05:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EAA73014A32
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48303128C9;
	Sun, 18 Jan 2026 04:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F23093DD
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710133; cv=none; b=sujG1eEjHzReO+ALkICj/XWKGh/bpB6IcOjgZHRlsK17oMXM/cZNpBtlj1oIDb4KH5+eA8N9eCvJo5E82CqV/5fTgTwBAPRTmqX1lyRYKp71SmfYPM3XgVWkZb5Bk1nhvUq6S/oq2li++zaBK+9Ud548tN2nqmQq5fmwASRJcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710133; c=relaxed/simple;
	bh=Ml5THvALwdvX1KEacMujqtxqaaW2Cmu4tpZeRVSnm8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeIplUBR/LZ3wXRzBqZknDTVIHe2/MrSmGmP3EcDwoGrpRXmPYSeD6qFEVTRx7PW0FV3nRlQISeBEHH6qrL0YRzfJEXLASz8Sy2a83ymhEHSnrdxWNFw1POsL78qMzNRbwrSVDj39peKfLADjycviWvKAG/CkryFjXveh2K0mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1768710105tfa2b9990
X-QQ-Originating-IP: MZk9v2JTaQjzP+eudBnEbavb1+NR2iUbLUt7cjlVzqg=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.15.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Jan 2026 12:21:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1425187152050529491
EX-QQ-RecipientCnt: 13
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 4/4] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Sun, 18 Jan 2026 12:21:14 +0800
Message-Id: <c1dcc53442f4d0f67beb9e0a3e7a7a6a2c94c47f.1768709239.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1768709239.git.tonghao@bamaicloud.com>
References: <cover.1768709239.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MBlb9jzPUvXQS9QxxDGmDfCw9J6o7vkN9jnbzh8+Alq0nJoYWBy9WWtx
	z8txmVShmvvrLltS0X2H2k3X02MJt/5Ya2+iB5T5Pzy95JHawf7IXvtI2yYBrB7PV2qJQY1
	QYJ2L8U5JeaURc/iHz5ZMMqbRmLEMLXZrVRizbyesqJabtuC146ckk0gobUFfiiLVFviKNu
	W3lqNSxqUtc+pVzc+FZFznJpeZYny+WZ1eS3bBDR/S/1l5EBKQDioZjoK4F9/0CVLB256lI
	xoR8RnMoY6nqMxKA/fMBRuYsyDi0acVN8oy6fSTB6qvq3qlmA1fg1x06T640ISrlOXjNio3
	isTwyiU3UJunkBBIN1AFalEpHoFwnBSVwblS2dfOUe4OlErtVV2qgKxeq+SXFPRymdYH1uT
	3IqKX0glLNEhPevJLWDqnZoiJd/+qQNUv+v7muLn7c8tRVID5Uht2WuWwIBxE6fDPCgW8HV
	C3gcEjoLdhpQjIvU8gTXaiz6EJfCiNxW7KI7SJkpAIj7njZqpOoPwZ1m5ZH4hlrpA6BR07Q
	t1RFbDBpu9N8G/abq0OVXZTOQ0JNbLV1fGHRTr99es/BU/VRhIpUpVX4j7w1tOVvRhH90dF
	dhgilsDq8ptQwYiMHuWsTKqXjSbmumPUUQSrO5pJCDelXiRr7YjARPqrAfq0Ju7W4uNutGN
	kH4xPxgGwpoUaOsOYCYHMqDJc1ZXRZoiMjc/UcyYgpqx2q+RTAkp3OXcQiwdH/owNmlclRr
	+hnoeOjYE7FLNyF/YFdmEY/CU9Ys4sp5RFpoLcvIfBET+2/zJjXUzEoXglTU7k9u2RiKb96
	gul+3umW0Q80De7sAc3lNa1ckjCI3Ot0NQvM4M4uGnPoYGe46RB7OKj14fEGYPeGX9/uej4
	AHVzydRo2Ct1+HDWcoR+C6FJ4yya79WFPwTk3j/A6JJOAYuEyNVxtvMRtFxbudlgf8j3Ptl
	xLai5SIj9cX25Wsjg1vFJBkMXhCisnItGg6RNDV0PML5Mq9MU1ZnPxIqoroxt8wOQw+Uc+U
	Z6Mqf75Ts+Z+U6KWjlKkEwipLe4zj7YN2qHZexkl7Tbx+HoIP63DQQNd+sINWxnc0NrwdNL
	g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Although operations on the variable send_peer_notif are already within
a lock-protected critical section, there are cases where it is accessed
outside the lock. Therefore, READ_ONCE() and WRITE_ONCE() should be
added to it.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3-5:
- no change
v2: fix compilation errors
---
 drivers/net/bonding/bond_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 98f391ac761f..b7923d052a8d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1204,8 +1204,9 @@ void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay)
 /* Peer notify update handler. Holds only RTNL */
 static void bond_peer_notify_reset(struct bonding *bond)
 {
-	bond->send_peer_notif = bond->params.num_peer_notif *
-		max(1, bond->params.peer_notif_delay);
+	WRITE_ONCE(bond->send_peer_notif,
+		   bond->params.num_peer_notif *
+		   max(1, bond->params.peer_notif_delay));
 }
 
 static void bond_peer_notify_handler(struct work_struct *work)
@@ -2832,7 +2833,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || READ_ONCE(bond->send_peer_notif)) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
@@ -3787,7 +3788,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	should_notify_rtnl = bond_ab_arp_probe(bond);
 	rcu_read_unlock();
 
-	if (bond->send_peer_notif || should_notify_rtnl) {
+	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
 			goto re_arm;
-- 
2.34.1


