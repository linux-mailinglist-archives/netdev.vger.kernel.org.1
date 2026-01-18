Return-Path: <netdev+bounces-250804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD8D392AC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 05:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84A10301B83A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172D431AAAB;
	Sun, 18 Jan 2026 04:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC62472A6
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710122; cv=none; b=THQYBrX72phj1on/IH8ZnMsYtiBiQVVliY9o0XvnwmOXX5Veo0NREjmozH6LKNa1yml/llPKZE7cUob1sCRFvlL4zr99QqB9v8efuG2Lmla9eqwNj+iw0zEgggTxVG6ZuyIsOoNyNeLmyh8Br+t5ItvoiS7Q7nNoEl+dB2Tvxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710122; c=relaxed/simple;
	bh=iQjYBB6BpxEtzsHGAWDRNvZFjWDBoeBJBbJ30Jddc8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vu2O2fYCeAYdF3kkN4b0AsEVVVMiM1jz0PT1FwV4UdSk1nCgdzduINR9GpXvPyCwJCQba2Pw2GBGE0pzzZQVEQK4+trFeTVO12J0SzlezwEZkO3IH046Dr4QJU1G4QWCuRVIPz9RnVL5TOD6OjiP8h0AlGqFYKf77BpI9q4Jsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1768710102te784aca3
X-QQ-Originating-IP: nUWDbt0nJKF6jx0OLQPaz3ckEy1VMoYYCFhPgQLmzkc=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.15.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Jan 2026 12:21:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16283673152997798911
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
Subject: [PATCH net-next v5 3/4] net: bonding: skip the 2nd trylock when first one fail
Date: Sun, 18 Jan 2026 12:21:13 +0800
Message-Id: <9aba44f02163e8fe8dbaba63ff2df921bc2b114e.1768709239.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MxLPDZgbtN6ZjZEK/pdbsspQOPQLn9ZxLLbcJT7Ep9INDJN0s8CIBJuW
	sNxyK58lt8dFnIb64XgIKIMIBCcwGpUQ2snlVL0Xg4buf1nEIF5sb6DWY+4hcj/Wx+YAhJx
	4HHOIinX1QiNIgKQZzlnAnTc4P2l2EdrdMeDKmmvxa2ft8k2/4jeJNkjzsW2o2uPA5RBIu8
	4wLAUzHmbDeDZxC7rbengd/anO9uqQGHLVYIbgAveijXn7gMV2cmnC2YOkcm2L2KpEhLvWI
	Gk6jz5kLNWDULjxdys3GBoBRele9fOS7wX+uYH1tKtHngC0eN1vLapNQpH1shS1XOgLjxmz
	msS7YAm/IA1HKb0F1yhivgYuUM9CJLn3iBCYz8KvMZ6tTGgLQ08lX6KQ298HaMe3VNp0AXM
	Jwi9xGxm3pu0W7JPwdWHHN9sSluGf48lJoeazx0e9BLVdmBOWg/6u0fsGfuKitriF2d0Mxu
	53nOKCtUYum+NZJV78XEqEu7afnkcmKVZkRG18YY7C/ev7uGZTWzfn1jmCiQX5MPKU3VIWS
	xwU4U1ZfK4njIUqWxalpxa81u4aKNCFVJT4+y0V3cJrwbaogHUVm8V/xXvmWAkbtxdDOxjt
	fk0RvLwWrewPfJDKO0eyc90XZpQoZU5t7QiXaez3N28fxUOjF2wPjQ6FgtRIWoQ3LdD6HrB
	VecQYGFgpUDqOaHBccSu5tYDsfjFFcBiRD+Vp/OnenzhoCtjVASY52KhMpBdj0C0Z753FwT
	3kLXbRpM4iVzP7EXZDmeiI5qA+wTJB+bTIqfwiZ8fKF7t60F7T7JUGurx9o0myBiGzh56u5
	siS/YBrq6FlYGj+ZoJ3xL4CEZzBCIpXPbU68wGBLi/TY9oEcnvqAugSI+/NZ8gMD+1an5rV
	6tp0G1/MmmcR5SrcaWTdl5pUhsS9OpXakgYlkxGHBGbjFIN5it4H3wj8Mspq0J0hF0KY/cF
	emn6XFYBhU9iGH0EhEDisRgRSo3YdbEuWDQoozzJ6TKRZeAwFdgHbpHlZKdy1WCCbtwWvT/
	mpBDXEKIUAjgVeHASnqgsEK7PEQIi6vWqZWum3zfO67fFvblaYidzOePpxllkcAQSW3E6At
	Fm7HDUHB9QXrr2kNdPBUug=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2-5:
- no change
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only skip the 2nd rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 16418e1dc10a..98f391ac761f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3759,7 +3759,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_rtnl = false;
+	bool should_notify_rtnl;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3787,13 +3787,11 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
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
 
 		if (bond->send_peer_notif)
 			bond_peer_notify_may_events(bond, true);
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


