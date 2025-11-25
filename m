Return-Path: <netdev+bounces-241445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F4DC8409E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CBD3A868F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C992DE1E6;
	Tue, 25 Nov 2025 08:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF92FDC26
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060323; cv=none; b=pIZg0nxLted1hzMDNqM9fktueNy3Qr9/jrnmm+2rojMUA2Bx7nKNgjYyFSdLHorzNFW+l+WSKZrXXThjeTxONRNk1acMXTf9nkDJHVulU0cdDHLgBMRxPHk1O6cvW1QWWpLVIGqih+6JN5c9iyHzRM2sRYAOVUgUfASxtXooIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060323; c=relaxed/simple;
	bh=BTTWQLvD6qlQfaBYD+z/qAbZscfufS3cTQrfm7hZau4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3XJUlsRcNuqULuZkXUEcEioJqHpW+HCb7IiuGk/ywMB/csVUCYpmbwekxPogTmSSlqUp9Nxw0Zqe7x9aSw73ywteejbeLsH3TA7d+rbL1geXiaRgy/exA42XS2ePUc/g3f5W5odwCbljXu01Rko6QyiSH6wUdFwISe0eocmJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1764060309td70411d8
X-QQ-Originating-IP: isQfHWj9DTsF7MeiZVJIGalbK7tiipL6i3KMlyJyARU=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Nov 2025 16:45:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 572638618153813546
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
Subject: [PATCH net-next v1 2/5] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Tue, 25 Nov 2025 16:44:48 +0800
Message-Id: <20251125084451.11632-3-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: N7MSp95pYuqVr/QaIpd6bYcwDrxhS8E9ZNK0HzqK+6+G5hfOAcNbDZgq
	nM08ZqaeKvozhNu+yoiQx0+C5WcWp80kV3WFgEPbUulZt/pM2Uryu253PxWmr4pazZi0/xw
	xsGbv056UawO9jzXOrknpOP8BEPMkawOkFoZC6oJLgaK8xI3Exn8RKzFjn5VDX96rRvKaqp
	l7shTfN3Zaa4B3g5KaepDP0LYYtPfnTAWiUOGHtxBHLQrEn7mfUbW/EbdQAaTR5tU83WO6j
	JKsDeCQaP+AZFFM3kogBr3XANPp2pQztXYUwYA07qg83wnIMcpCAqTp9mbKNfqpAKMdN3g3
	FsfKHWOs8k2JIQ0CBHaN+gvHovg/nUGMsuu6W/bckikqUETCUPPSVZLLwN0psnfdHWvuRDt
	0gCtTilHQ/Dm9pxFQfaJOsbKfccVf2PSUHy64stpaYom0GLJbUzQZn9necz6Tz/v1+20D3/
	Jo8Ely88EVnoJP4TiI7/5n2CkCavc+p4MxValfn4l7UQvUQrfpHHy/iEalOrenCDqkn0naO
	GBDRa0aRNy53ikzXgjXu2oJQrOJ+jWc/r9MulonyA2EUQsXdW3SdW8BNbhMUZcSsMpUbRVP
	tA7lWPQkPtrSO18g60IxuhekkVlxQluBjzh1o0Vfa7w/VUg7EYeLWfMnhD2h+FSMAiFuBMp
	XdG/5Wp0NpMDq8XFSDWbOlZquX6TLxu9MhBPZjwhwp/xkMMZG0OqNrcJcbyFcJyYjvm2asr
	h268XfNmr8NAFppkTw9OBBQ3ldX+kG9yXa7sJaQWKNB3qQ50M2FPsw0KBk9KuZP+/DGkBYY
	Gnabo6uKng4CgrNAhlGOjOppnm/pkl1ktvNesYy1zYn2NDvgQ2xswkzYzxhGNhdFyWcN/eE
	uDoMZyDqPUccEt1POSPNFHYCzDRQhYgY6XrH+49UeZoFz9lJpdOvcZHjn/f3oDPb/qalmys
	pn69DPi0dj6IwQZoGOpnbfwgrJyg75gr2VArDs5A35nZcKfyflUQWewn4pqN2J91lyso3oD
	j69S5mKLVIxJPM4QVx7DYhTpoF3d4TT6OkkExuXw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

This patch trys to fix the possible peer notify event loss.

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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
v2:
- splitted from v1
- this patch only move the bond_should_notify_peers to rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 811ced7680c1..1b16c4cd90e0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2809,11 +2809,10 @@ static void bond_mii_monitor(struct work_struct *work)
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
 
@@ -2822,7 +2821,6 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 
 	rcu_read_unlock();
@@ -2843,10 +2841,10 @@ static void bond_mii_monitor(struct work_struct *work)
 		}
 
 		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
+			if (bond_should_notify_peers(bond))
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
+			bond->send_peer_notif--;
 		}
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
@@ -3758,7 +3756,6 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_peers = false;
 	bool should_notify_rtnl = false;
 	int delta_in_ticks;
 
@@ -3769,15 +3766,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
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
 
@@ -3794,14 +3788,15 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	if (bond->params.arp_interval)
 		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 
-	if (should_notify_peers || should_notify_rtnl) {
+	if (bond->send_peer_notif || should_notify_rtnl) {
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers) {
+		if (bond->send_peer_notif) {
+			if (bond_should_notify_peers(bond))
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 			bond->send_peer_notif--;
-			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-						 bond->dev);
 		}
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
-- 
2.34.1


