Return-Path: <netdev+bounces-250803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3DBD392AB
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 05:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065CC3012DFA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21EF3148C9;
	Sun, 18 Jan 2026 04:22:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA5298CB2
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710121; cv=none; b=YsEaKBXjB7z9HBiSkgVLG19es2xbgHQbW9lZ4xspwqHm8dXV00m+vi3szSVB8zuzOxVrosYP//NnShuFyTIfOApkALemy25wRl7TnLBWI+7ep/67/fTVmLsqHKW2by5R1RgbE/sgjDMVO/lwEwHMGIFzdtXMb4n6x1QaQuLKPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710121; c=relaxed/simple;
	bh=uPD6DVwr9w2eaSSgHIbusgE8dokLyqtBnly6BdBZ8/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqiGFVOMmkWR/nWiysPileoz6r3ufQJOxPK2hQeM8qviKpo1GO8PcpqTlSiSw2q2jmGBhDnzVW0sef/bChydQ2nwNfQFjMqG7u9wP1nnyR7+7S8k87P3KHhL/IVOV41tUF5XUqofysIZOSnDy2wiftehsSgfYrw2Ge8xKXWUNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1768710099t61dca1b4
X-QQ-Originating-IP: Q2gtq7TkpXSiSLDQrBunaZp7XdhgQOrU17xOKSP9lq0=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.15.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Jan 2026 12:21:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13237282989489601471
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
Subject: [PATCH net-next v5 2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Sun, 18 Jan 2026 12:21:12 +0800
Message-Id: <78cef328822b94638c97638b89011c507b8bf19e.1768709239.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: OCnNLGxuhE2ogqarva0+DDrcaCemSQkGUwbSz3Fg7oB/Xb7j0uG448Mh
	YO505g8Q60xtZUCk/agt/J3lkb3IwOAKQQ365DBVOv1x3R+30ZOAV+PM5tW1g7qDPfdwuxN
	4k8A4Wkpl77K86EhZXPHwik3LA3uL+Mp4kH4w3jqbAPyabdgtiRnurKFt1fn4gRMO4CvPls
	NqU/UP8lN6LiyPac9QrIFN5XBXvsY8hiLaII+gORBbokxCNzch6VrCmXnmCYLbw2BIQ/9bB
	FiKNKjqFkqXP0g4DI4JNgWRkIayxb3fzdv5O+8XBSOGhM6HbilSqlUNxkp/+0HUhbmW8hYj
	M4uK0lvA722IMGKxirroWw9alXrA4IAxhl7l86Qww7ekVzrGmZ7dr7d7f+2an+K9ELGU6jF
	iPsIcAaEo7eeNuJ86R6nWM4VU6j3PBLa3ULZ6rz/icBtJ/ltQR+/+SW+sEq+KimSt7Ki3Ug
	uG3Oj4sziBLXGpW2iH6fCFDrTj7pcLaOwwHRT7IfCQxFUHdTLad8Nnt20Yw0sC0N3rHsF5L
	hhq4kMY5Wz0ql/MUexwj92ezXFino8pV/3PVDlJ0MR98r80MnSOO0UlZNLgxPIefPWXR2jn
	b9ilcbuVJDxr1wOL2jximz2wXDIO3PAgq8jrevvo43BO56tyz7ikwDloe31/gA11ld4A6ec
	UdAuY/8OJlE5UHEJ3zMUfLiRyOfbchnaDFVM4yhUHedgxh9x2l7piEoVzitks7vG4kIjltQ
	pCm69QsdGGqHmfGu1MPtZnRF3GDw0f+xNBp3lCGEC5tl6+AUK7E+Nt/qhvu/5hFZD91s+Sc
	vSu9Udutv3n8ucKJRVNKj75BeNgqw4Ca+i9ST6blArxwLp6jpZa5J3/SiW3+6Q7/wkW+OZv
	VCDtlZwyx9KdKgoyV72hBX/mB8IUA7s53/jWRe8Jwm2hNdK5w9+GWV+GwKHBSS0vL1LnbLD
	02uyiaSChYE7i90l5kIh7fZ1vvKzakEDGg4qhexwmNKm7X+UBmRWcnVyQr4s3SrDuUfAugr
	9gaX8AcionuC70OaK4fPXZ+e+KH/jHtgLY0ADxzqdMsDJV2pt4Q6F5M/2j2SlzkVwQQqhvZ
	NTKR9gXyr9a
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This patch tries to avoid the possible peer notify event loss.

In bond_mii_monitor()/bond_activebackup_arp_mon(), when we hold the rtnl lock:
- check send_peer_notif again to avoid unconditionally reducing this value.
- send_peer_notif may have been reset. Therefore, it is necessary to check
  whether to send peer notify via bond_should_notify_peers() to avoid the
  loss of notification events.

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
v2-5:
- no change
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only move the bond_should_notify_peers to rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 353b0c8a0ca7..16418e1dc10a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2816,11 +2816,10 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers;
-	bool commit;
-	unsigned long delay;
-	struct slave *slave;
 	struct list_head *iter;
+	struct slave *slave;
+	unsigned long delay;
+	bool commit;
 
 	delay = msecs_to_jiffies(bond->params.miimon);
 
@@ -2829,7 +2828,6 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 
 	rcu_read_unlock();
@@ -2849,12 +2847,8 @@ static void bond_mii_monitor(struct work_struct *work)
 			bond_miimon_commit(bond);
 		}
 
-		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
-		}
+		if (bond->send_peer_notif)
+			bond_peer_notify_may_events(bond, true);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -3765,7 +3759,6 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_peers = false;
 	bool should_notify_rtnl = false;
 	int delta_in_ticks;
 
@@ -3776,15 +3769,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
-
 	if (bond_ab_arp_inspect(bond)) {
 		rcu_read_unlock();
 
 		/* Race avoidance with bond_close flush of workqueue */
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
@@ -3801,15 +3791,13 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	if (bond->params.arp_interval)
 		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 
-	if (should_notify_peers || should_notify_rtnl) {
+	if (bond->send_peer_notif || should_notify_rtnl) {
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers) {
-			bond->send_peer_notif--;
-			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-						 bond->dev);
-		}
+		if (bond->send_peer_notif)
+			bond_peer_notify_may_events(bond, true);
+
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
-- 
2.34.1


