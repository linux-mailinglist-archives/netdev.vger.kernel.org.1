Return-Path: <netdev+bounces-248863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA98D105DA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 655243009866
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AB3009C3;
	Mon, 12 Jan 2026 02:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FB303CA0
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185793; cv=none; b=CKJlYyQrdqi2MjDOx/oDSHIIdYAfMAAwUWAsb15KH9NUOV/UyqtG0bzTmkyDA9/05Dz62qMTUAGGgr22qxZvWLJIzdMsAwv/7YP6z3cTNF4FRP5n9mS+PvJ8UhqPIWmiw9lk3LiWXr8DfBNWcBTagYHVTd02MKBAp1k7pFHYK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185793; c=relaxed/simple;
	bh=g5Dcg6mAhcaDCqdSMd+X2n3kFu8GIg3DeMoRiTucPRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEA/aVscH2L/iqV6HAeZS8lOpJs9LjRWtmABV/uHkpcGmpbXS8JDNKGb6vDvplcBKqYkpfZP1zHXmYOXFUh0gYUSsh7T59c6q3Kj8f7I0Yjsk16Di6O+QSDm4pU1jHTLemDQVx8j5Kh3jjxPXE5PAkBLtDt4IBYx0BQOtw1aWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz13t1768185778teacc7c91
X-QQ-Originating-IP: kEUrcvRzjPbUegroHrSYXUEqy1TwFlULGOG+CaVeu/I=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Jan 2026 10:42:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9373764509123652227
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
Date: Mon, 12 Jan 2026 10:40:50 +0800
Message-Id: <e90a599a58a3738d69a2b879f31871afa223d7ab.1768184929.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1768184929.git.tonghao@bamaicloud.com>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N9n/4fl2T9vi5RtfMmfE0NNsvK2uTbk4m567E++5Q8IQu7UlCTraQJ6H
	905y6Jt1Wp7/yIlGHP3VV8zkqHkaj1mJrD+/FjCNpt+fd+ECZDl3IFvW+O4Q176e5CPNrcX
	70riSO+fatuDxMXJnhVqOEVhJlpLuWlAuQWB9FGaJOvTLaq5L9fnSId+D2oopWISmJdqcWL
	0llARDJZFv7qRIt8j7h593ZaA06CIvd8+Xrz+m/KYQuJ3gTDU9lGJ3nC5suXcK75yfaxgvW
	3ayT+O0Oq6qDDxmv0hm3NeltImom6eBMpM+KWJn/RS7KTsrd52tuzkJunAtm48s75IY/x5m
	T4cdtsvJU6eq6ZMt0D6CFA4guZ32HxQr8tqT6+tP5hYjVIUQRNuGRXztSVqaR1qj9ljbQc3
	iDhdI3lf+g8K9VeOD1c5ajgEaRo/ALTXJ7/GCDc1AdcT9IbGnKkvVzme9+yaOqOMq57UTnP
	LKBjFUP5XjI06FZFuMpCJ2ABiYfUj9uCUANYV1W9iVxt1fQOzc561tdKh/okSRsRyuzoHIw
	t7UiPBh/VaPdV3cjtZDfMCbRBMwJxPGa+AmJCQo8eznKqFW6IEvzbb2Ba76tqC2l6qcmWln
	au2i6gT11kXafkU9mS8MM4lMq6bK2vMGABjPH2Xev6T9w+U9KH5anFgOt85YazRmW3j8Bas
	mwfZJvupDYl8mK5/8CocDNSgwzM56cuxa7ImPW2lYQOT1Dd3ATJvfIjYODE023CnmjF3m2C
	BPZ5h8Tlz11Z+J+Yjkaz4akIuNnasgnhH4VXMvH7dLrdFz3aAecB0LAcCHtPpGSt0CEGFoC
	AgcNuc4qdTxJo5F/dJxSiq8ZcjuOLnHgDBLFS6vq1IhuIgHFcrwGgPDpRK2I4hDCgOkIEb2
	qGeVQkDWi+LOMzGqIkGRBjIooU+u4N948mTsGuo4l8CWar92yzPiglLO8LwycCxEZVEaJAx
	VwRhQvyjtGm+C/d6lVPii1k8ksnH7SdWnspznarklAaBJBjkj1c0EPfq+h0QOb51pEoZwP0
	0NO/A4cFnWeQwsZfnHmY0R81vvHqYoB39+fS4jb/G1KB6NBrM2/rems6sr2HE6w1wdaPNBD
	gesUddoadhe10dVApgOxMw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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


