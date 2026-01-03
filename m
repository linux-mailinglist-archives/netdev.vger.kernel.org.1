Return-Path: <netdev+bounces-246650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC6CEFDA4
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C87301E6EA
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4172F547F;
	Sat,  3 Jan 2026 09:50:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAF21A95D
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433816; cv=none; b=fSt4BKj7QAG2NcxQgKG8x2sLh/BJXn9/pxVzSB7pkuHoH+8vI3ln8dXNiOzbA8RCm/YYbcRnxeBD+9ovUZ+/JpN/l/Nza7iK9XtQcYn81k55ZhSIQwY8ynUQ8SsP/Qi5qC0qrM8XXrGYWNjX6eamm0JfOAtQFQuFWyvCfWlgyos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433816; c=relaxed/simple;
	bh=0nxX+Ada4xYpvIdhVZQKdcuOPmLRVCKk8oK5wjxqEpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKZwOLHaA1mNvVgS03u4zAWjgSD5VOZUFqNb7PtmPvo+V5iwvn7u51sdJOEv3X8XGHioxxKWtIqTLU9ueYhz5b5Podtop+k1Qe+czcLs/lCZ4eclzHKrka6szsF46R5xGTamfi2kSYPqn4yMRKxv6LrXuN2p8ptPrx++WOWHJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1767433797tac3679b9
X-QQ-Originating-IP: nfaOOQ51jAvXVboZMJtbtuFJQUP4CQzCgYLtO2AvAeI=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Jan 2026 17:49:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2652864527616171101
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
Subject: [PATCH RESEND net-next v4 2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Sat,  3 Jan 2026 17:49:44 +0800
Message-Id: <f90e095be3df4c1649bbb46b5fd8d00cdabe0afe.1767000122.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: NbxtxvLq7lKKEVIPTE4Um8vJ8MH3SxWvDnRlnDHhPzGvbzmv9DFFVq2m
	F1fZ8Bh1MMDo+hx+dgQoXe5ZXH+oPDmXOtloFvjRS5WupBRIL9i020b0/zfQjYYNpCf38PO
	nfwejc+LrMGqazm5qRfmdTiyMkj3g1IGpVKyNFC9/hYtzZ1fkXppm2khkkhoccvtchThodL
	CHo37/spEaQB2SjYb6nOu/r2MzNDTZ0x0jxzuevALLWWt27dNMhcAcoThEqgj92SBR3qfuf
	/LWv5WjdjN9wLfTj100XjSPLXfkSmmPbPzZdZ0C00dW2eAZ4H6GF00sytdgu30GVKzA/5xO
	1WHnMY4F3gFeHMuixdlIj+kJVkMDlmAMTBtF4urHsQtpttBbgVXu4AAHgl296rotbS49awz
	EbhbQgos5ys6S/niOyzVtIZz6z3buvAZW7fJGhIXV/lI1ALy5xUgyaHh5DVWu/cS/6cQPQ+
	JWauPmMv030ys9BlcHPHlA5unL7FiMtFCRpuwx9NvPhUciyT/btX9/yFVchdX/UiKXQIEAS
	6vwWiR51y1ie+l/H+94pVCSHFwMHXTzgEFslthnocF+wABlgDQpdgbOBzl8HO4d0lgFZthp
	lWDdk6XavmPxrp85kn8JLj3xlxJZZ/RC4y5LjfqMP1kDMgs1EXBFGgiJGr4A7G0kLmPqSTb
	2ySaA8TFTkrN5JEb140gk/PQfbfHUSSc0laYl/if4LP6s7XrNCVxN/uKpvysN3VdbXnXQRd
	/2cvcf/KV0+TrezwsStTJXFyvOxDH0NNDFZjH+yDdbQ+WdEmvc/6j3jFN/a6J0OMwQVyw72
	aAM7zgrZT4YLGqxdML/aWJWbLzOioQBfVmksHhJFu/mF8Moxr6sC3h3JxwktCZ2LPra1YSu
	KWTZ5IuRc8QDq0zyoXysJ1T9N6hAM7StpmU6eIHSbkjP76ouxXPwcHVfgELe96j3AKToeYn
	pGeVnWiG7jzDPUMUWhVWfUbnsDNqk+Q+fUmYSNN/BHTHCyQRQ745BD1+EtBv/qpzpAnCgDC
	dC16a5OmmSGoX7ULMHj5nGKFm1j4Tioruizo04W8AD9cjoy5/f9UiFHPf0OOZX7tbOR0JvV
	aGnr6h06jmW
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
v2-4:
- no change
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only move the bond_should_notify_peers to rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index edf6dac8a98f..8be7f52e847c 100644
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


