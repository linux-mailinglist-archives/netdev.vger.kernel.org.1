Return-Path: <netdev+bounces-241737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16178C87DB4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF03A4E7461
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303A30BBB8;
	Wed, 26 Nov 2025 02:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83C30AAD7
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124784; cv=none; b=mC50s2Cw6crgoGFDtHEgwcTjqiHB0Af0yXkSrWl/J1/HKNj4vfDI/soaj4oNyKMY3QxMS2f9Je245iTO3qLsO8S0HkmMM3xrHb2Ame0cEkcrhWKcxr6ksdRcZ1fs87uXtZCLF9H11VP6xY2H9HdMDhWLL8Dqhz/RCFB6bsCpHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124784; c=relaxed/simple;
	bh=DHpD9bb1h3vp1g+XeQh/hpEhuKm5Pv+vFfPtg4Urudc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GC6UbYHQuw884Y6Ezypy6Xkj0uCynVSG98z2fzaLTBXPoME6lFAx9yLVTEKOQLkNcxOfNM9a1a/xkwZmywFC16YNnCYOGeAT3iiSTU1N+4+yDnR3kFftb8c/tA2yDUX41JNKW6eNpwmVtCcImg2Lmo+ZzaPfjh6866SqV66NOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1764124765t306b1f9e
X-QQ-Originating-IP: WaECX9YYXZWuzMDNGv/XzVfa5592WLm6RCNTACG0SCU=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:39:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14428042333653094087
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
Subject: [PATCH net-next v2 4/5] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Wed, 26 Nov 2025 10:38:28 +0800
Message-Id: <20251126023829.44946-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251126023829.44946-1-tonghao@bamaicloud.com>
References: <20251126023829.44946-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MI8wNaO5eJcQgQt+7GwXYm7znIOJpURXGpSTaljzKvUMM3+qpEuQXfkE
	ydjWdxACmU5BvIMhuvElen1lQCu987Y4UWp7PO3V3B6BPvxSHHGN9sgGDg8YNcNUX0Hvcri
	k3k3VpCPuzavN80Xig8EJf4WTAsgON8Ypjs8MUYvTE7UDhs5OjxlJryUA8cxQp8BE+v2bnw
	qFy9N3DQe+FANPYWPU+v55IPiYnICKBEcvx7Wo0BDFctg/p1WX3up3DE9Em8sN0G25YIv9s
	rRkOyAneGh/WWWx97VDHuTk0KsU5CHLsGnFhgu/wjWRBEJf5syeqxVbAvGxXXAybAldKqzI
	SnfSFP8Ht/x1holpGIAp7rMO1pCIOcMw2hzGpxaR19fFpaNfp7iRorff0nmqc25qsujj2xx
	J1f2XDpyBaPGtNb1VHfVVpJqQ2Qr3gYD59oJ0E+Ag827e0U4BZQxy4JdgA6ahoHCJ9xLt8u
	5pfWg0vw0cz6UVjfIarKMJ+1c9cMUrJJbh1iaKTT5/6qSHopZNP54R0lqkXXC9yBSCvI0Pl
	K6813MMWjYJMir03X1eAOCC2sv0TPRh+Pn3wz6eK7mkeWRT0HM5U9OQEfi6nZvIw+iemCV8
	Kz1SW4Ltn2IC539YP+hxY7qBUcWB+1dHBInc0tjrC5OYvmuswD4YWFqHwWkMma8uUb9Or4M
	uURI8pMEd1y1+SQYZLV5pzbSOSAkq/L/R/ebcKIPNHWnzclNk3i9UNidOU6CFQYmp9i7iZx
	e0MzORBlyVsBiI8V6GKjEE/HkChHiJn3AWoTywoEvblQawfHDrryaqEjVuWDiCGSs5sWj9J
	sxIz9faM36Sn/uaSBjoowDyEMgybGsSh/Rwr0wDcSrManHjrszNuW2Zz3awoDz6hxibmFV3
	OIjNL6qJ/IzshgsIFLIDfOiNGfISJyPuboMxYzw7g46wLXrypKXqJFpJb5PuNnf7w2jpiBS
	q5/a2HDUiRpjcnq4zPhpcBPE4BK+N9jUzJQ5y9Gjih0vy512ktGSQ8bkwTDYyNoF5FMy58o
	n8seeoD0f9AHj0hPp8K37Ale62Ndxe0VRU6ABSqcmNGx1L43QxnlDWsOsQptLzt687eYUkg
	m7DjVXnjmBSFZgXokX8sK0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
---
v2: fix compilation errors
---
 drivers/net/bonding/bond_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 025ca0a45615..14396e39b1f0 100644
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
@@ -2825,7 +2826,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || READ_ONCE(bond->send_peer_notif)) {
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


