Return-Path: <netdev+bounces-246226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F60CE652E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DAF630010CA
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32328312D;
	Mon, 29 Dec 2025 09:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B323D7C5
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001988; cv=none; b=W/7RtNMWD3V6outCfOXkL7Kdvi5s8+q+Ffc/2VrGDl9T7kK1LNWt/urbGUnwPnEQ16oX7DsvaCg9u3u19+eQ7fsAfg74HxnaLErXDD677Rv/fmXRVjKi3VgtW62mOA8M2w0ijWaYmV8zsk5b7IjN/3oWjGcdYEJnc5rywbwRgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001988; c=relaxed/simple;
	bh=g5Dcg6mAhcaDCqdSMd+X2n3kFu8GIg3DeMoRiTucPRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcmxBlU9CukC2yiJbGEnl7RuKWxBHbH9XW7W6YnButzsZJJz15cFt64QoCrubUX/sVw9ELT/nJZrPf+ZkB2lob9wZVKeoZ4Iq7PJKM/Lf4VC+Wex1qjdUsmKsZsuuzd/+qBOLxd2FMlvago4J8YoQqm/3kyq0R9+Ft4PxpygqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1767001970t1dafd055
X-QQ-Originating-IP: s+8oHj+omzzo4X2hXKdQQhBDBoiaKpXkb/xPCvCJ/rQ=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 17:52:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15048736778371849792
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
Subject: [PATCH net-next v4 3/4] net: bonding: skip the 2nd trylock when first one fail
Date: Mon, 29 Dec 2025 17:50:17 +0800
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
X-QQ-XMAILINFO: MYNcaOm1VPp0jcVJGmcxcRdkNwIdtFeF8sI9DDC8jC8/lRu8wuGwYtO1
	qOYqJaQ9W/6PhPLaVI2kWYGO8b3sVHCuSM6tprsmVZyIo5tfBHKdNeq9WnUYk6JTza0K+R4
	VFu8eRPzlU1CDanzschAgTXZibFLGioxIyfByAzj3Qb/r6rUZlByxkTzE3XZWzExAukCgg0
	CBNGAQLSfkuVDub336URvscpIQnnKLqElaBulR2GCylsgVZU3JA6Ztlv6VK1NRp2PL76Oy2
	HXYQ2Z7VubFd1VHm2y1yjEzFwxPXIws+I2qG5J8obQzg2jZk7VL60hTNBhHKM2NWUFi4TRQ
	J3RnAoUo0ffLo2LdwpJzKgXT20QwaNgdbo40/7EJzyWBKHM2LZ/vLHc8vREbRXcIensDSYE
	tNGCrq4a7vtHSBDpZD87JIMNSk8p1WoBdckSWXmIg+SHHbPFCFhOqX7bBoAEpco05GY8mjF
	zUPuf2Vq0i3fiBor/dFgbgqUOQLvhY9mnK05xiQGEiijz/O64z/Uu1j5lEx2bhkDN8Xu4HW
	ik5jjE2YvsxLWZiPjkVDQ0mSrM2Vpa6utFiA5oJjqzcf8nOKooSzlbIwlGvcV7yHuFz9O1C
	tWuDYZaMbsAJpmHtyqtN/zeAyc5NBcIDhxC7Xf/zLAsAOsVz8GFV49CaFjGS7/087UIsSJq
	USUbVWsA0oNlSkoEgvUU1uWIyNpCSdBf+peI4Gy1B3tgQ/CVgTfScCDQdpLj9L9Jcyb4FAR
	WsTPYckGN8uq3qw+GJFXnW89r6vW5FR6LnYzx6Z35RYoQk85lPR1cRiz6QYZ/vMKAcZ67LH
	/3fi4uXijuyl1PgR3zHbmSLU5lMCiWkaiLDP3AL7Od5UyMQjHt646o2PbihX8yJY1Qvuufz
	3NLmgDLpTceQT6MIXz7bBhf1CS5tnPkkvB/GfZAncBoaWRWH/R4eRdKMzwNYO6Rz4OdtYS7
	KFu5r9eluFVbdfCHZ3H84MjTx7n+XH2hSI/iSJioqK9Fi/jGkk0CUt8X3nTbPtT4xR6up64
	y06X5s7rEn7hfy9nVUfZPKlUk1rHNQQGXnCf7zMC6uzeLLT3yeOguNQGfRn7GrzN8/QXrou
	r4oNyouqocgqMdJU4flKJQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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


