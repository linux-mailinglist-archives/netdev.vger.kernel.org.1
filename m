Return-Path: <netdev+bounces-241447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7651C840A1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541254E8762
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E92FE58F;
	Tue, 25 Nov 2025 08:45:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A33246781
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060325; cv=none; b=UnB6bOrnRbTs8uE48u7+CJCyiGZGQ8Zo1G1a1nL4lxpx1OGP45M8pVwUneI2Nchd8Y30cOLGNW7+Se2ZgHhkZU0v9Iope6hzYbZua6HO5pFnPoySSLLNoRprzyzOGS1teealKYXl3ZsaiYWIAnqIf0GRjkftXfE3JkduIL7mxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060325; c=relaxed/simple;
	bh=4lFgiquHtQmNK8OfniI64/D994CE440l7ae84IsrDoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX4w1PYIsN/zaRDZAIGmFASr7VxYJGU35NNHB6MPlE+o4smxilHIhBsdveCN6OnMPaWFAElYJHdLZpat3Hwx+z3sAyy8aHN+h3jPspIHUHMjEBpbSQismN6fBzI6E8+B08VsctGnZhroI0IrVA6Tz4cXs291v2rzFRwmQC9OLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1764060315t87423e6d
X-QQ-Originating-IP: hxwfxPlkSSAz5LAT5HL9BnEwZGk/fp/JjGip+Lgvgxs=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Nov 2025 16:45:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2508824192360674490
EX-QQ-RecipientCnt: 12
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v1 4/5] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Tue, 25 Nov 2025 16:44:50 +0800
Message-Id: <20251125084451.11632-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251125084451.11632-1-tonghao@bamaicloud.com>
References: <20251125084451.11632-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NoFe3wCY3jEys9Gy4Xk5A+J++Pkwj/5w78+WDQXnuVP/923iyZvghMTb
	IZMYxOC4ZfD46Mq+W8beq4R4YryGGdIze7mw9ZX229G/9Y3ykGZbeih82+O1lJoZpE4WMyI
	dKUMWIoRLO76Kv/01nCDmG+x/FzQnX/NsQM1AZgjiOk9O/FaJLnQUIUjztGqJLjMRCZKX4u
	MXTJPahJn9dG/e4U0QO5brURavwS91Ql79P+iLnb/zvK0pHvXhV9AjxBFcduz1X/ZGPz5Vi
	zcHOUYDet8RjaIBSALQXw2pxLL89jBOcMDE8cxuUVUGJz57gF0+0Y1hUr8wU+xAwbOUphXg
	3D1/p2uTcK/AGy4gPifl1IFhMzN5QRjsUnVKKSUduis9/G2auqzubRho9+P4bKIafeIxAFO
	1wqDNsTdeF2J2ld9YvfPO/EpvSNt1CpwIJtLoLWD8x+jlt8hlzE866hNL9YV9e2aUBObftz
	tESPcWJ0YkBCsYAWwQaeNwXaHCSJfPKLq+oVYtEsKlfCTLGTRTMxD/dTzkTrY7F592cxbpy
	B7lnEjBrLgabWJNWWkdk3WlduvwyKt7dGQyy+4ZQoH90TtlopDxjz7xjrSi+eO6mcor19Rd
	aBpVIfRxUMcVuUL85p1itJNPrqIXHauLEjSOHZeHdbxqbjFBm+eNndXFACH2pC0O+Q9TI3r
	JCBCQnKVGyQUa98cZx/j+vilUnBdY+25LNaAZuW/3foxEYYOLpUsqPBDbflR/SjB6vE5BDX
	Xjqk0mWRjeLUOOzNphkn0hGUVxGOUuyhJ6TSFtRQIQtut0uwo78lamdqDrZEw+u+Vu/lg4B
	JrxcWxC2fZkHZb4sq0ajdraFTQEce/Apq57t0vCb4DkK7gWyuc4k5O822Qwug9zeH21T2fc
	qS/WVfPHPBEZwY9zUHmsAkRohhiUQlgjQuwINqIGk0cpmRt7Hon6vb26b8WmI93USSlbr8h
	A4ac+w7KDN3MdMcJ/lNKzu005G7wIGngpfFkRVg370k1U3xhNgubzztVVH7ceWYz+ezSN0R
	xwNv2o2p5VZ6kEsVySt7vxU2sN9AMFF/0s+6AirIH0aHOVJDQbPsgvYMx+2arIDdn4PlYw+
	4Gff9YLSTyc
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 025ca0a45615..5f04197e29f7 100644
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
+		   max(1, bond->params.peer_notif_delay);
 }
 
 static void bond_peer_notify_handler(struct work_struct *work)
@@ -2825,7 +2826,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || READ_ONCE(bond->send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
@@ -3784,7 +3785,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	should_notify_rtnl = bond_ab_arp_probe(bond);
 	rcu_read_unlock();
 
-	if (bond->send_peer_notif || should_notify_rtnl) {
+	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
 			goto re_arm;
-- 
2.34.1


