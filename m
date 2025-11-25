Return-Path: <netdev+bounces-241448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 721ECC840A4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F11764E7EF4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F0B2FF150;
	Tue, 25 Nov 2025 08:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19392FE573
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060326; cv=none; b=SvnskU6o5g2WazrM3qwHR9AesniP/FiigZ1fJSopXr9fgh/R+dwiaEzGCtKGvVWq+7bJ4D58D5Zh9PmefFGZAh9Zf2lwd1I9Z7D1HvtimaQlayqwz+ZrnM8zB+exxo0q0PQ3W05OGcEb5RmcEvVyfbXaprxwWH/aFKFwlF1bzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060326; c=relaxed/simple;
	bh=hlmlvNULGVgiXFFksVSmsTs24nl05u6cx6gJuy3H8VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PB0E9W83Wr/qIULpqdzPGYHYiwWtgHflghPs3/VUKb8ntw2eccF1dPEbTe9Q3TmnW2qE1FJZFwPxN77ufc098qv9zU8twBPZRoUFbNOGYxvNzs8ulEC2HeU/hfqZgixDu6FhSmwJSOZdbRFgBnnNIlchQzV8QXQHlm/PQbIFOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1764060317taae6e411
X-QQ-Originating-IP: eJyjhDeKsvoyWswehe0marjY7yonzxbl62bFqHwprAY=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Nov 2025 16:45:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11330169741582049507
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
Subject: [PATCH net-next v1 5/5] net: bonding: combine rtnl lock block for arp monitor in activebackup mode
Date: Tue, 25 Nov 2025 16:44:51 +0800
Message-Id: <20251125084451.11632-6-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MRTruzTSNhcYeSGDO67YKOsDV0XPjFom3rbGR/r+p4gS4Mtf85Y9S/27
	klzR9BtWOLu9AIUitYEFz9O/m6YW9czxL/J5j3hvn28ZxYdL9V52m72aRPDXmr2WIKHSJu3
	0D7dVeu9PYFlCjgxr3izygwRXjWx+nI4OVVm6Ai36zQKtweBqi4/QNs+2cZbW921jwtFcmH
	CHTizoGwCTWYoGQiLMbcvP4j9YE+my3i4YyAdNQ55bccT1FSZw9+a/IvDUuYh+e//T+Vkus
	Bd1QuxWsHX/nu8y+7Rl5lgnORta/jkQmYW7Jl86KZHdUIwpJkQ283fFBJbSqlywDLUtm7Q4
	tYXlbYi8cQZbb5PSjARHgmcaGp2tIONV1WhemQ2Lr+TSr2bLZSkvVzVfWCGKYpZSdUhsUe5
	N0qZCy8PH8UvLgKqkGSO5NgZLPZvFGSn1qUcr+3Zi8n54IEtZEV0CLTEGIUL3YLSgzRlMwv
	b9j0kQHauAAUK7XWUrwPozVQhDyhf0UYMUz5Aw8vBc8NrYtRLcOiFDs4cEJaShOCks7ug78
	AOaP+Eqzkz2kgUARUwGUO7uiN0HAl5M5CYQzq3RmcIn5nwEVOmvXEQ10eGpdBbqsyIOYhg6
	fAOri5JkXv6LX0DSxwgAs7XQw5wjFjUbrY9yvSapDQmTpOzxtdy7HdPWqUM5XkYRYBNj8F7
	3dILsz5BnX/4CA4D8CO8NNOF4uE/g4i2LDf2JaQ9iPUTsjokvUFkV+kF7FYSHxAXD95YLFG
	rssVuPXXbnGIJ/LPelq0Jjr5vT7aGsWcY8o5OHY0uuZP+1sOZj+rcJBYKaANIpXAZreUJwX
	kknEeZjI/YJSOdK4K8xdDoOJDwBmgO3QYmDYVamoMH6cjoWeogOGZjUQXqW+UaIpPi/+7x8
	R3tF6d+9IafeRyw66WQWZC0wC0waSiOrCXvvWb3FM+Xv/321uBBLQNcD7qVYATrD3plOEeA
	XTcXWnDwC+3sG/+qADhQcO6ySAHV1x614a6Q5C825XpA4J12vh7IoiSWZlBj2wzuwTp6fzv
	XxltrQow==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Place all the arp monitor in a common critical section, to avoid requesting
rtnl lock frequently. Note that mii monitor also use the common critical
section. It should be noted that the bond_ab_arp_probe() sending probe arp
may be lost in this cycle, when committing link changed state. It is acceptable.

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
 drivers/net/bonding/bond_main.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5f04197e29f7..f827f88e7acc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3757,7 +3757,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_rtnl;
+	bool should_notify_rtnl, commit;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3767,36 +3767,28 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 	rcu_read_lock();
 
-	if (bond_ab_arp_inspect(bond)) {
-		rcu_read_unlock();
-
-		/* Race avoidance with bond_close flush of workqueue */
-		if (!rtnl_trylock()) {
-			delta_in_ticks = 1;
-			goto re_arm;
-		}
-
-		bond_ab_arp_commit(bond);
-
-		rtnl_unlock();
-		rcu_read_lock();
-	}
-
+	commit = !!bond_ab_arp_inspect(bond);
 	should_notify_rtnl = bond_ab_arp_probe(bond);
+
 	rcu_read_unlock();
 
-	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
+	if (commit || READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
+		/* Race avoidance with bond_close flush of workqueue */
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
 			goto re_arm;
 		}
 
+		if (commit)
+			bond_ab_arp_commit(bond);
+
 		if (bond->send_peer_notif) {
 			if (bond_should_notify_peers(bond))
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
 			bond->send_peer_notif--;
 		}
+
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
-- 
2.34.1


