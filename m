Return-Path: <netdev+bounces-246653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C21CEFDAD
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF8E301A1B2
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C724B2989B5;
	Sat,  3 Jan 2026 09:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769981F1537
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433953; cv=none; b=eAiz/QX0jUi0tucOS0+suAEJ3D28A5z5hCHYdmtz4Ih8R92KmE/7/ZLBAAz8D8qoBSiHVbZvyKZH3bYqQhncywD/UvVPgrM1pmCzEwAN4uFdXwgZ3KPZ9zwtDP5qCuUWqzl5ESjdEerJ7nd69rFIpx2KBgnFMylLOJA/Iw/GT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433953; c=relaxed/simple;
	bh=g5Dcg6mAhcaDCqdSMd+X2n3kFu8GIg3DeMoRiTucPRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lv0I3ki2Cr+jtsxP9R6XEtKpNNqF/rpC56/8mupoZEA9M7LMvkt7chzJwPA/VCQXUZvrZ5j+rHgvihrUIu8PVZSBJPly/yZucRH7RnAF3j09uP/nwS0gUIZxYz1FWBwW5X7X1M6Q+EgWs8DFP2EWSAqldaRc9TV10xF0+GpCXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1767433800tc1ca541b
X-QQ-Originating-IP: St1N+xbQn4s36TEwTmNdJBQh7MWcLxWUsCIPQ9tp1og=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Jan 2026 17:49:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16836140657508015296
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
Subject: [PATCH RESEND net-next v4 3/4] net: bonding: skip the 2nd trylock when first one fail
Date: Sat,  3 Jan 2026 17:49:45 +0800
Message-Id: <407cd5746d5ca673efd731fbc299abd493f6bf30.1767000122.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1767000122.git.tonghao@bamaicloud.com>
References: <cover.1767000122.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OaubhcMTRB4zBa0JskfhHolbExhyoa0KGJl7KyugvfLWoFIz9gnak+hU
	of8Pek+TeGRbL/YVJ4njSGoBKp0G+CGwyh8xB+QafvdYOsL7XsAHsMEWg4Qubh2sc6tUw3A
	jXWt201L70X95ozTB3sbVyJaISpmLMymwvspLqrgMW3+wr6TYsi661MvqHx0ZnzL4C5EPl+
	ixyoJSn5z9w4qyBfW2MYwzEyIxXvCg/BEir3D/lpVgOlmhr6lAOy1YJHnrb9F+OaKwF7vHx
	gnBDNuTnHpn1Sb3+opDCMfUMSi3gJjTTy8ySo/ubEeMBD3f7NhpDPY0WxPNa7hEoXKYkxsw
	fdojfeMtQ2RFy7fvA8Tta+2Bbo4pHZqJRBJAhilfWFNTiSv9hWFbzJbO+YSAiYX9tMzit5Y
	wrfYnk9dTWGhFoGlQK9qNXYr7zUEBLm54s2JZdIV7hO2P6qBjkTyXn4uNpBzmAnUhIQEUBy
	PYM4pDVUmdCmweiMPIEAr3uG5m+ybK3Oe/OTw9ak6pOEUN6sDdDyvS6mUbi9c3z8+c22x1o
	0WKXTvD2EX2VMWNi4vNWkR8KuVDPD8mb8o910AffVxtIADv11ulYgLGI/kOd/sbD7xuIzhj
	BnE71MM8IxXd6kBp0kdZGdj3NA1XUQYObkwhA2nYhRBkaLVXlabckuRLVRzQPytPY32oohz
	ldHGD04bLHB7t9ItSZrujvqssry/LjqHJoWy5dx1tX0kAUO0+AyrVXsgutGuG6iY1Cr/t7c
	jwLwxm/HL8tkcDQbFHa8bAUdn4vC77aXy1ltreB9PSDlIOCthxgzwyKqVxxgBrzEXTV+3Ne
	oMf9r5aQITO2vnNv7bI6ilu3RYITghxRK91uAXn54EP1HDnKpvQWZq+hKsG4BdqcQaMPOJR
	2ME8g0f8LgNodnZbUQ+b4+mMtizS8qAg7vgs2ntk17NL5RxuyyB34grSLYP1oYJhKmrLGl+
	lH+CAr9qd4XWzspIT631FZHxKM2oP2JdT8ZgpgAjb9uEjYXc/ZYo/Vx79N5dafqOb2f6/Z0
	ggkBEeNQVXfni3gTXas2oIWmRxU10WD7JMWxM59YvH+4q6EdS4llLvlkkd1k4l+1lCaQsxE
	6+E5yCIcEJRi1rpDy/m/z41fRhfeSGq1/kK+hOPolMC2bB7eMa4qr2baIDccts9xA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

After the first trylock fail, retrying immediately is
not advised as there is a high probability of failing
to acquire the lock again. This optimization makes sense.

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
v2-4:
- no change
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only skip the 2nd rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8be7f52e847c..b835f63d2871 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3756,7 +3756,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_rtnl = false;
+	bool should_notify_rtnl;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3784,13 +3784,11 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	should_notify_rtnl = bond_ab_arp_probe(bond);
 	rcu_read_unlock();
 
-re_arm:
-	if (bond->params.arp_interval)
-		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
-
 	if (bond->send_peer_notif || should_notify_rtnl) {
-		if (!rtnl_trylock())
-			return;
+		if (!rtnl_trylock()) {
+			delta_in_ticks = 1;
+			goto re_arm;
+		}
 
 		if (bond->send_peer_notif) {
 			if (bond_should_notify_peers(bond))
@@ -3805,6 +3803,10 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 		rtnl_unlock();
 	}
+
+re_arm:
+	if (bond->params.arp_interval)
+		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 }
 
 static void bond_arp_monitor(struct work_struct *work)
-- 
2.34.1


