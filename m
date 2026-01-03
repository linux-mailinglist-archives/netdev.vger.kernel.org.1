Return-Path: <netdev+bounces-246652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1FCEFDAA
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 057B430380EE
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760B92F3609;
	Sat,  3 Jan 2026 09:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587212F6577
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433821; cv=none; b=kqykruLBA47n/ACp+wk9PTmVY1kD+OlPgDvRTbvB9ny3vL9qmQzvBHW0b4VHpw+iXFQFWDagI0FR9G6qhbHTcBeI3iuchdLulYNOpyMO5eojrvp4Lq+i1M+XmFT9hP102ehUR3wyiSgj+0WBqHE/sAJzli4PbXYe+jMuC61Ngvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433821; c=relaxed/simple;
	bh=oQAb+2QjTzCjB0ihqCeziEaHDoA4CY2MKFyp9DpKhA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMQb9xOaddPol1ConDxl66siTQDk5azMByoJ4aWcx4sDdwJP5DcDbuFc8Kxr+rMYQAmWQXgnJj29VEBLSEjvVVRnhHUhOyvQFsDE2PckG03XZ/onAigs4/zePtyy9NvuU4jA+EW4UuMhHgkVRf1Mo92xKE1cVoxarYVd16OS/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1767433802t6ff57b4f
X-QQ-Originating-IP: gORzoBPI/g8dU/bbr+Zh9nK4ygjqLr+4yRvUddrAldk=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Jan 2026 17:50:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13447758597635484042
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
Subject: [PATCH RESEND net-next v4 4/4] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
Date: Sat,  3 Jan 2026 17:49:46 +0800
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
X-QQ-XMAILINFO: MpwVTWUMI5u8jflka6RGSw7nI/qGfEcLkw1p7kHUheAsQsp1wrK4TvJc
	3nRayjKTnL0k9of2qcMkEETMlz2LGrPLRDrDnSdps+DUjH0DPUSFxgiyIdo8z14TKV9+67N
	mmYTyas7V/kkzJwaDvwtkVnmGSyhvXQXGzZMQ+iKVN1dNAjfTZMXKa73tkWCd1LLBMAy2y6
	QFG6b6xQVhqunzG6s/Pd8eFPcuA7jSOCAkfDtX07Ho4KVGq84AOH5whLoW0HMBUERkAaHSy
	0qe+PyPTvLzlItY900QdVhpkoV1KBk5UtLOgJlQkTWUe5kphmxlIAvJWe+hnFMGPhl8Kthi
	i+MJsesLUxEfrY2H00A+xS+3xW5GC5BvRstumn4pOpKtTd3N3Dzs7eJ63Kd7cpgWFTzWBzL
	XaQiBC8CoM70pYIQXKdugjZ5Lnb/3YbIhdrCs5kZBtSZlErX+/BWdIxv5iwnV/Q9AncwDRp
	ytNnhrBhMmmNIvoIPCJudRsgmji4v7romk58mAINouf+U4+qhG9NYqLkeISp0jWDAxVhSEH
	B8JaO0SJAcUkg7N2MKzapswdVj3e7Nx+LA+wvCnpYD0qPuHxlol+XKqCDw+ydLZaEDrbf8k
	W/eOLQhf+0Cz8Ku8yspF4yawrW2eX1jtZENPJaR0y3vyVYN/I6YtuAgUU3oXpb2varawA0h
	Vd+AuCLpGLYXCA+6uYXX1dEASHEVCDzZON/zWHVMzL/8YRvHHsMUcmteQLSG3vts6vNMsN8
	1R55FhY1Pt0ZVVDslz+tolZ/4L+sOJYOOAdLdyXOSOs5HXU5WrThM/82oo1ScCOLFiqul1/
	oDSS6sCv71fEWQ1EStD5zOYlCHlKY+8rZatpHsM/TBc5zu8F6CUXl+BhdoXtY5p3zcMZ5ZG
	bPhnvDTh58bvfanAP7t5ll8gzFMci1AVOpL85qJb5JW7Xfn6lUWXNHfJtWmHU9+DbleLir+
	b9Pu7yyi9uRjHJQqsDMcrHgzA6sMDZzuIG7/p5r4KpwVYHUrOLgkTc1AX7GJbJUThAf7q6y
	vb7ffYyypMr+fi+E0u53Dba8HZEemYZ1V9L8PXtbEcxZsY5HFZvPPkz5MwaMH9442peUTeB
	TmOiMcgVc3prnO0Bqwv0ggrztZiBTplhWRLzEuRsVR+
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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


