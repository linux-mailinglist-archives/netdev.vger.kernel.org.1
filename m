Return-Path: <netdev+bounces-246227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B3CE6534
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79A003005FC5
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF329ACD8;
	Mon, 29 Dec 2025 09:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742B9283FEF
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767002005; cv=none; b=JSKZvSE0QAjnptcDlJQcjhBCUgeVqO0C6AsGQYy3D/34mc2CcOuYyAhPGtb1xhbTMKn/ZufOT2NtIh+vIOR42mSkGPVxBHH0UFdo4g2ExA2rId227M9llN7v3SH+E0YWAv7xopMngSSPlpZc7J3PdGtPz/nCTIToWhTx+Z2Moyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767002005; c=relaxed/simple;
	bh=oQAb+2QjTzCjB0ihqCeziEaHDoA4CY2MKFyp9DpKhA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTiba+hMvhDdGPJkQFsfPMUmLodDvioopQzTJgaN3GZqI8Vz8jpoo8N2ywrek0MhWqcB76NVFL4agoVJ+VtzVRQqGlAi5alxcxq9NnzNQQILPFayPVtDY8y2ekbOp/E2K1rktq1739vyNTOntfweHDW7VbyC1Hls/1CsG/O1Pyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1767001973tb0bda06f
X-QQ-Originating-IP: z+xaJwzoGMV41D+ilwCyBDRoN3iq4ZNTHlh1wJXAlFg=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 17:52:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2914368772822095623
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
Subject: [PATCH net-next v4 4/4] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Mon, 29 Dec 2025 17:50:18 +0800
Message-Id: <257075c732d5a40dd67d4330826ef66f08ab9222.1767000122.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MOJijf76Vc+i3uWEOEJ2GCavGjI3nHZNqHk3JIVoiq4F39LP/0uxVptv
	f2TA7l/K7vHsfFRfuk2H+MZkidVED8UGntQc+E/3ib9FTw1F18me8Y95GL2C72n9WhS8sb+
	n6k00UPDMqx7BQOvJKX+yM8xnjXF2cGT8NAvuFb5HpwuWNfvd5jf8IjtV5mv3Ce+1G+VOqF
	xOyaRkgp2jDLCDmn//hq7uONL+M0YKCVF4W5xCsB0427x7nO/uGDgXo1G3h/LWAmFl7EV9p
	o7Hu1RbpbqKrnnXYkl7cfDcw+nDiHtC2Ew8URXc1fwWZTaMsmDBhh7v+qfOkUOONezSPBjY
	UEZ2jPiAVdEJe15Uv6rD4IF/UOWtntIA1hhcmiTK6kqHSTG2et7RftY7eAw0Czk5ia//Lv6
	zh2Vh/Cd6uOdq+bu5NnaqzagF8CEYdcHx7kr6Tvoaf6xNkAqYN+HH9SWZ5NkY1jGmTJlmtq
	azP0Tkn+J9txbJbcydSkgdzSBUaNMN4TrL7yb1Ewqc5Injel6D2tCpCsYERWEBp8jHdHoIM
	zXaBrYVfGr0IW1WvA7AMumCdo04qxpJKpIeq859wXUR/o0WSTRf4T144o01qWag3kDhVU4o
	lN/KZG8ubjP/eX6tuVj7Glljvk325Yf9kvF6EF6PCPU2gMPM5gMgsik8iRF4LFrXtdD8Qcz
	nBPUsEUbVLkX2pMVVbulMFUCzBumd4WAfgsAM9oQOb9IZuJ7zwgPNIU7+So9zcsWZ25BXCd
	FmmDMqj/su8ykP5o/mIdpyG3yEU3F7/j+SmDEF8kiRXSQ/BVOGOnlB7QOuDNYDXQiBrQ29E
	eTxFq2KQPUGCZ3fiL6tlP42ED9iup6E6WJzqqwYq5XlPRspuGINa/9z3G9dwOoGqtwpIheX
	W9eGjWGWHDUzv0GjrDICHqqOVoTe6vt/PeP8aIlVMH6twBFfod4GbkrjW7Qi79z0NZCU3oE
	bDIQbXbsaPi4/eMVOw9E/+nFuCe+y4hCC4Fz115L2US7h/fp9ML9eg+j4zr2Er/ZV4DuAwL
	yI19loq6cws+jsKbwvpS/v+zdd0C3GN+xYlEMtjWlcZAPUv5WPrMKXyDQ+P9NH8NGLnpU5D
	5aJQEahktT99PgIILCeKFZL+Xzrlxq4SQ==
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
v3/4:
- no change
v2: fix compilation errors
---
 drivers/net/bonding/bond_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b835f63d2871..909c01f55744 100644
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


