Return-Path: <netdev+bounces-248865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90FD105DD
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84FBF3000B59
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF563009C3;
	Mon, 12 Jan 2026 02:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED16266576
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185801; cv=none; b=XKRQpxeCwMAgMEGhh1SU+p+C9NHNRQjJDjY7sZRR1it/xFmxKK6/km1irj4B0qMlKofO0gnjqPKbefjmPG1lgM4voEh8L5GTetXtoHTrD1rZ1FC7Q0Qz2SWJhQ/wrhmLXSe4Pm+Z9EDaRQwioTOO5KVk1RnJneGOW4RSuvH4ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185801; c=relaxed/simple;
	bh=oQAb+2QjTzCjB0ihqCeziEaHDoA4CY2MKFyp9DpKhA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaIxr30xD2U0RbZc14hNsy20vlxi/7iF7jQjniijV06GSBW53YWpsRYYlL1ssJz9SktSOYecqPTPE+xYX1nSyOmH5yV3vxCbcQIhRIxYcj9RRp9lLlw72Lh5mOZ0A2OaPGQz+IHcSqGGUYu5Xo9f3ugE6e/pQ7W9Dfm5iA5yCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz13t1768185782t40df39af
X-QQ-Originating-IP: GabkaX1N4jf8AtmpEpTpwwc6Bo/tAPWjrvYQ/VUIuFw=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Jan 2026 10:42:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4871000304720290591
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
Date: Mon, 12 Jan 2026 10:40:51 +0800
Message-Id: <5bf134412fd558dc80fbf97a149964f536a59cb7.1768184929.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MDSqlvH8sYTtrCF/XAqOgdjgWBJF+k5V43/iXJncH7gTD1bEBRJjzgXA
	vH5p+xwFxqnygrrvoQa6/8l8SAEs1VVF0XBu04njAq3pWZgbhC24IDZurFMArqD7jUGqeT5
	SzwasNbsYHXm6PhMeMHOJCqUKmgi/qD3+EaA/1osaOzJt54vZhZwUX4Upr5ocBeYe7ONRGE
	iBM5k5zeQ7aghvSYU3jJ0azv/BZt1BFHhZKdQYRccfsB+J3+Bcqls+AfUU+HHlEUPjxYB37
	zbS29oBnQ2FAYic+tkzUfqQAY/2Q4omjbNlRPZS5LW7ZcCKL8PdO6xj5OVa+s4CG4cinf7u
	76PjH1kBOVoUv1BPKiPOL1swjwbDGU1KvrkD63aj8i1VApD6LH79NwzJRddntpJGCB0B1Fr
	JKms+/mFNFxuVMN0pmNdR6QozwdiMojXiBPqTGYRweTfvsITnJPLrL7x59i7cuaFRkwdZ8i
	e4Ql8Mfl41eCyA6VreZNWbSh8mj/TTWIk6YR4zyrC1cSG3JC45RlXFgnC9e6SKonXV3E+Zf
	P7pU+6JeT2Go26IdzO4AH5XuQia6k79yyjpjUid4A7eqekWEn3OeTEVJi8SyQExpKG7Jlac
	d0edtWg4LCDuAVdOtV638V4Qf3Yw3KhQzYMqFYccxXhivx5UzLrQjcxb+at/hwP+UGmRkgX
	xY0LlyTV0aMscEMvum1/Dqir4aDoxT77J4AXeoFTLmceZm8oyz8AKBT6HuUFArYjn2RhbQJ
	xJvcOJ5gBpWmWpP4I56PE+TrFi8k3jXO//hBh3ViuKwIv/LDfbcGot9Z8BxXke2Fc4gdXRJ
	vMOlOgUmOO7OV84MGf8wMsBPD5wdGa9PfrcI5f5MKWdJ2/aw9bTm299rlIBacTrwkpI/M7p
	pm6sElzVv/ia3UZR5xsO5eFDk5ESVLFEnz/qfegPx4bgn7sTV5WVkY+g+YsWQfivuJEdBtx
	KvpUk4hKNAvl31TmBEMLVMhob/GDFdX65XS1IduNdb+6DVMrM6jaHpkhu1QCHlNV8li8uHP
	eYoJ2qltE9tCdjmutBqfC99q1/qFplrrSLG63DhJh9TGgmpUyMHML9NgzOtxH2QX8cnD6OR
	p5lnEhxC4zXXmzY/12M/eyF2odNVPrF7JLqbCZp7CJv
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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


