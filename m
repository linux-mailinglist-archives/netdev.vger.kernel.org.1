Return-Path: <netdev+bounces-242769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8137DC94C28
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 038AF4E194A
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9E233D85;
	Sun, 30 Nov 2025 07:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251223C519
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764488964; cv=none; b=QMnrqdDqDXGvSi5+P06Dd3pFcnYd6RDTnsFn4THaAp4KMkkNW+fbpG+b+qJ5Sbiijbe7b/3lyXFdBoHPph+pE+IoGKCYL30zpO32cnlFs843yPXbC0ZAr8FbcTpbNdiOh+i8f2G/uolctlOvanhqI+q1IBePoHFT1EbcVgYlTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764488964; c=relaxed/simple;
	bh=Z30wU3mOTjQ75JyO/CuuHKcEdD9qBqqXx6OefOh//OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGIcAPIOcfM0t0GWPoA3ePFo3DieR1GDpjDU1Mc4Fo6mdScQBGD9KIekWq2WdOtYdRfsGkjJ27MUrqlltxhHeOfMt5EEu5rQk9a++ASh1YuTVrlLg5T6k6txCxVNomP3XZ+1a37PAveUT3Iaraf792GNM01WN/AWb2TgDmDvFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1764488941te881df84
X-QQ-Originating-IP: 5aPkwVp8U0r+Lk6rbhMA940PsgNFASkGqHl2BHG7gt4=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Nov 2025 15:48:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13429476591396923906
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
Subject: [PATCH net-next v3 3/4] net: bonding: skip the 2nd trylock when first one fail
Date: Sun, 30 Nov 2025 15:48:45 +0800
Message-Id: <20251130074846.36787-4-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MfMKp/VE+ZXdx0vNWQJp/Tz3yo9DLlDa4os75YWncRUzvxDv0QsHpSgj
	XF+LtW/WWdcTDsL7Xi75OH3kT3io+q7Gmls5sJ78eTVjS+0pZ0FBPa58zy3s01LYT+XBKPb
	xry/IiWRL6LRh6KqnnwITn64pMRgAu18stOW48oubPeY55Ml4DLULvTpp4/DGFdRX/BvAvz
	2Ev5DwYiTMEXUjQhHwD/blwcylMamDRnYmRlKxBQiG5gq4m0b3sk9j886iqziAgzcJF9NBe
	uY9DF5R3sPnDftWls62JfOnPBYaTsQ0E8hLny43ZOwua//RDyXogmcbq7jZuiSJdNo9fJWC
	EDS1lTRwrsm+OQKwzEtoYDgzQEREmpFTT7F+0wdgSyU6bzWa1rs9cVHzIV0kZDX984bEBZ1
	erR7ilQBxpu31St/E94sqteOspryp1ZOuWUrq/18kAA2cZ6aw2nG1Gn+hAynP9nff2uo+YP
	R74A+WzqzHuWp9WShIfiqbaCdcPBLH870JnISzoZnV6sYsHjxAmqMbW6lNxc91gCfgPuU2t
	dLOSHIGWzfWi2bJlZNbuSkLCfzk/vGj04TRegSu7X539S96BbZSvTyNBhR4ypmEMxlUuGH4
	jTcI4reUJ2nknanvSyAhjXV6aqd0t0RsJaFrAve0ZA6Kek5t82PuBB7PZwBWiJ6HOAJeJI5
	FCBNmbG/8EUWOJvbmfK5X55J8cczv9abR2/GV8zmTFowlM14GrGKt003sHjft6hyD5yVOGz
	9wjTJQW8uwWA8a4VWDCf5ooesIRtuaa/EoaWKnzcH2uBZCnh1US6vFDMIv9fKh4iLtPIUnl
	FZZs7fhRdxYGgXrcsMhqSVEONPaIFaSXupXs/KYATuMSYrbpMfhEMGJcAZr0bqPvMDres5C
	syChf9Szhf+XP3xdCGcb3m8A8K24IizPP6ToAebXnx5Ok2D7uKZ8H0qyUoaJ0w0itvW0PXo
	+dUyDGr5Tii69GrB16RdIxwNT/VnYGSBbgY6jV4FGpCrzKJaYFSukR4pVmMtSD4zjMnWoJs
	YqZU3nH7abKDuYBjTza0PjjttnvQO+nqWwzGBbZ4IaA/FuMlKLKDgcDnEX06kShI7JorSsk
	g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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


