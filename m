Return-Path: <netdev+bounces-241735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B03DC87DAD
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0CCF3556C8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC330C343;
	Wed, 26 Nov 2025 02:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91566308F3E
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124778; cv=none; b=nYeytVjqqx0kgnQdCulBqyucEvhGLfQbNqNjCFIvcmb18ATSYGFv86ygxPMvl8Ypme//UxM9L3tCsxpsy202+YkHjpI8jQcg9pAyLc9/m3UvgZraV8PNbVLCSTk/VoSMd3+EftJHtLipRoM4BHcntPPx9ndxa1sZIOtrBT0yk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124778; c=relaxed/simple;
	bh=Z30wU3mOTjQ75JyO/CuuHKcEdD9qBqqXx6OefOh//OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byfgW+maYk1IHjqU9KLgEX5ybDLsGLY05hBDo5Ew9XtzPeA/dXa0256+E6nyfJOu+ZtSt3/JLD478G8VbTR9Idd32KU/jSXzFg8AzFqPc+U75x5Ln9Sm1aeOiKj5949SYAvh23SDuKqSo2/VU1wkramfw3se2lE5fNoUxob18lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1764124762t5ff5936b
X-QQ-Originating-IP: tAtPKygqTPDC5AqjIHV9yW4/sW/Q+AsTVa93nH+Tb4w=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:39:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5659905734882288333
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
Subject: [PATCH net-next v2 3/5] net: bonding: skip the 2nd trylock when first one fail
Date: Wed, 26 Nov 2025 10:38:27 +0800
Message-Id: <20251126023829.44946-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251126023829.44946-1-tonghao@bamaicloud.com>
References: <20251126023829.44946-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OanpiDkno5AWt/FNenlmP6cI87wJ1ZdXYlIjI4em4ybFSI8a1BPpNP/K
	hVx9JsXAR7QHSGBC611Gd2D3jdV6bEL+j/v5w+mrBaYrR0K4ZKxAEOkceHufSJ3jGTVYSMZ
	tpxGa1QqVcu8rvcOWr8DFnzdK1Bz7S1Z8JUcVrWqyTb01RL99re8Xz80yRT7m13kRRMMfqE
	TEzg7oicRr9g/sIS8ooQreJ1L6i3mQYVN4dFkH83wiCJMxAAuRsMKkzNxpmbMd9bm7v1J6e
	A/2/v6f2qrWRdCe1mEx3DfSqcMRpSFjuI2FMVsywGKiVq/YO4SXI1LLLOM+Cb0zrHWlL4hc
	it0OcgX7+H/6K/W7AEu2eJxcUB9KgLcXDccDb7kiFl5j8Yba31z/7Ta2F90b+hUfgnLcwGx
	MXsTYvqcOn2CgbfrNLuIhwmsRdwEfD7MSKjvdLtcJthOwpnw9/x0daWLR1RucTNAsdfPEPI
	LFnoC/mtsmfBOiYKFj4DjC9rEIRfkOTJoO6oJAZtj5XoiPTS/RLkHjnAER/aI9uxTMqPVOk
	3QXPqA7IZ11YT37E3M52vt2I+AxKu4/ElpHVpHrawdldbSOsjlWMjrfPiV0Uc8Tr/YxHXje
	1/AnUoZZ63VraJTYF4Md3Oejuqar8YJl2YArJcW5Dee3QuLv3kotdaxdgMOiiTA9hPoOjE/
	NC5c5cPeyn5KTIJ80Jpd08FPD+26rNhMDRBIG/gGGaCUAcTQqlCLk01UYdzckynD7DC+CkU
	F8jcBCX6+YF6dE+s3IptmpELkzon2ovyseUR+Ki/vVjqi6tLOQkgPGMvqXDI8mqLO8CWoCf
	uOJz+ZpRYMdtQ8ECzvYLl1gUeSBFQQh4muV+/dUbDpaiA8YadvD2F0OZvz+nRevymB/jgIv
	W2g74wb/K1/k3lsyMUzyj2BwawNRaJl6c50Szuv89EWG0Sk1swTu1iR7SNexDblCQffMw5N
	+uOPRageg3GphwKk/ttOeVPJm5a5UsTHvN/PDxpqp/6bBr/YoiiJlPD9sJkn/5EJJjCiO2F
	wEfnBQDFCCTCmThPfBBOsEW1Q8ANoy5zAX0icjBl8fugHOcXNI5aV5MsyJpUr42XtoYqmnS
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only skip the 2nd rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1b16c4cd90e0..025ca0a45615 100644
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


