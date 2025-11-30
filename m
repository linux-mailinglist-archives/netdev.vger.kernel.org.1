Return-Path: <netdev+bounces-242771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D9C94C2E
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324C73A5A25
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60C23F417;
	Sun, 30 Nov 2025 07:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249ED27E
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764488965; cv=none; b=s6YaJAlbS2nJkwF+2dqeDOOVmd/e3Twt468OBQy7R3saHy7sRPBmbvkg8XWkFTnjkjMUOCObWrRRkAtbwAVPP1MKb8Ob833fSIdM5f3T1rfddnZV6D1MDG3LK+xs/RSilGCK6ndQ/A2mE/GEXh8kNWpqPzFWWFt1nttjMGm3R7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764488965; c=relaxed/simple;
	bh=DHpD9bb1h3vp1g+XeQh/hpEhuKm5Pv+vFfPtg4Urudc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKDaKLUwlqrU4TFLEhAx0fDJNyRChLf46FOZAQdR8TUP+UtVGLKAftWsNLqojpQzj/2J5dJec6nz6+iWif4bvbE3oexDYCdZpHW/T8I1uUSeH38449GixvWw1CGFF+F2T7FgFavi3/mma6ZIquDgUWktN7a9yTM9mWEURD0eho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1764488944t4c9b4f18
X-QQ-Originating-IP: NLjzU+xxJnLRJlln/Emw3qZ3Dj9C6UhQm1Q82jzb0GA=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Nov 2025 15:49:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12441560744698570349
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
Subject: [PATCH net-next v3 4/4] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Sun, 30 Nov 2025 15:48:46 +0800
Message-Id: <20251130074846.36787-5-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251130074846.36787-1-tonghao@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDQLqEGrgYqnqvugY2B0Na2LLvDEcqREINzqrsMnkkfuoJAjH3RW6aE/
	v1DKTqZDAA3j0drvuK9bPb4t783i/7QBKA82PLywPcUpA8423jhuaaCtwN66c8Mxt5SAsg4
	rTz4/0ja2ovn8//oztphQlW1Y8KFKSuUXmrzVogOg+Yc5kHE+XlbpK//+h7J7rfDNiYaJ69
	aOWNeu3n9hCNSowwysNQIkmZkUfSld8D30ALfe/3eJjhQa3KZfMMaajA8hglg4tpMHskAYt
	jYAJj3Uswbynn/uBf8b4w+Ahs5bujteUsS3LC8UgNEq2Te0yhOnjRZSPneFcSUFCuxR9Sk8
	9bdJHA+lzdiPiI/NPrnP/cJPdjXyBajm9qYjn8mnRRHVwBG2ndGXhgmYH/WmgSqhqOY8rh/
	gj8MeP1biWP+GYZntBOIWGiIAsrV6YW8sNp7n8xIu+3a+Ge5TQcfSEV4MoatXirKJZkZW4w
	Lml+uCOPbO8hulvoMOr7jaz7hmhh6pxVbdixWUPBjOtj/1Ou6+2ss00V7FAz88hCrRZErBP
	mxJKIFEwZ87qEe7wNKP/nJImSyxqfVSs6svnfGZw8F/3KSRBg+yhVaxm+AKZF+PA2i5bDfk
	b7K+W5/SDAE1kimFClvuhU2x1qmx1FEiL7jFIJbdLHfdR8oBfhpleTbJNJLXODmHln5mQ+j
	AHQoiac4lKDHK3HhyCLREFRazz8ar/wc7mMwgUopYUrwl6yLMacX71aKabD/3dVPtHAnYcy
	90+QTz6Xf6gMJbNVjUGjXxopFVZ89ql5BB/o+tJ9pKZ8r2++4hfkiT5QflnIEcGvXblzejX
	4RuXNBF7otvHP4i0pGHgsCuz+I9JzofRTcJI0DFhZoUksUovOxpG+O6e/xIhmCL/c6sB3lw
	RAX1tadH7/jlES2KRMHgDjqx9JeIlKP73Cf9P3ChERyt6mWF4pC/p/0tH4tUgus/k8so6bg
	+U/X7Sb3hzLczbl1hNPLCsvKbumTNJ/Wms2RGeT6awxs0ccQ1DrGEAJq3PLUPSxcY8pZXcS
	hYrMQVRQpoy1rzZwoGhfQjs9VeFXoV3kECCK3bP9LwX0zmWXz+U5ia8T1ztkv5Kc7OupQsY
	iWrGKHVXZf+
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


