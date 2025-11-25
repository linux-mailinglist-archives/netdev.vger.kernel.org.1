Return-Path: <netdev+bounces-241446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA44C8409B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4F33A869B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C212DCF55;
	Tue, 25 Nov 2025 08:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC12DC32C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764060323; cv=none; b=GdJ5gkfb1kloOs+sA5uXbCVx9nRCCqyUxvutL9oNI33bpzSyxdaLt95ztmlkmWJRMGIsEiUt9kMPErEU6UWV43KZtyZZmoYNWSkJM0t5vLvfm1fGaq66IKciQw53AQMJMXwY2TfpqcUUqzA2c+KihQC+nLdb0YqEsLJEFco0wMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764060323; c=relaxed/simple;
	bh=sQxwH8ngyj+Uvq2vsiC0daH4cIM3/LE0P+05woSPAIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VI2nmBtKwngFH1JFQ1EQJfclMPHgfJZaBhpSYKlFwnU9D14f+4l74qFrJCGIFDPe596CwwV81K3qepuT2p3ooHgxQiuqEVVv0e1rKC/EK9fhRCqpmm2WHrWXkVwLlO7QSVQpiBlBwCd+/j4Ef2Rog0BAqNbupOgK9mhQjuGVYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1764060312tf7a617de
X-QQ-Originating-IP: KCT9vPfP4VNatmFPRDTL7XnJ3vpKIL7Jr25Yl5JdiVE=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Nov 2025 16:45:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2591354003068099089
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
Subject: [PATCH net-next v1 3/5] net: bonding: skip the 2nd trylock when first one fail
Date: Tue, 25 Nov 2025 16:44:49 +0800
Message-Id: <20251125084451.11632-4-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: NsKw77UaNFtDPQmUMUu3E7oiOB3EAAvPJ1NUqHMQXEZFwnecVTCZlb86
	u71y8kSyRBHgw4IlF9ugiqAPmaP6MGXD97sSplyjztgsnZBHiVw/f4JEUmPs2ntRayUaosJ
	GyiCto6L1jz3Tt24UmYEUPhibUg0YtEujK1F+WG/bvvBsiMzxThnRxl8EWoYHxc79rAmFlZ
	McxN2XhRoFlW+615nejDrgNzVQH/K+9dIxnHVtc51fyPwdnkv/IbjaV34WANGfwkZqxpTwN
	KWmnSou9JiJWeOEyzIqgS8IC+a0aBoNlAV0x+Jrvk/PNX78vanVQR47ELaiBkLTa0F65V88
	0Yo09R+nbTL/6BRLL05KSfTaKdGUmtYntG7nUAKKToXTZeuvC5W1FDGbaWUzMKzXZy9qxwE
	tb58YEUiE/C/NHqYNEceYVvxMge/Ko3nowuTjGeGZaNboPY5sbmIcIPWCm7wYbr4stdnHDj
	vsdQvd5eQZOy13cnsl/ec/bW8lX4Smai3BzxCDjKGKbb0v6L4qbsRXh+Ea9uJgHQ8BQmw/u
	va4ym3VmZXREWpW1wK7T5K9rSGjiVMmzUeBZCzqmB8RiDHHpRSySP6oVavhiO9tbZHzq/CD
	HHwHoXLark0Pv0IJQ/D9rEosYmg9qzDr/hBZ/sexEeCbO3Swd9wbQDUpXSkyUsUm8KueZ3v
	rJpX/guo8IVcGyHhqmshAGA1c3AuyN5YRJ2s49UdsL3h/ucbLiDAcLaztd5FTaDfo7KAPMu
	Y60TsgrXpD4mUU+dJ7tvoY/XPw555jg7pxZrmeJ/VsUl3ZoNZoAqQQOd0CXzAa87bzxU76h
	SBg6+ogauaV69PWm4JueR1Vgh9KDqx5X9wPU6Op21el9e1ANNI+H5dy3WbF4JXlfPPvefZb
	nJ6qNWPf1mPMgfMg79sLzLRLvkwkDnZBGUnDW6KgmHzVGMd8A6ATDLVxFth+tD6BvhcwRtg
	WifGr9PT1JfoFz3dbxtIhZDa8l7yN1ELePzLakYShgkeYSF6zoTbNwayyNGzaqfJEcBzqv+
	+zg6JtuYr2sQsBV1WhTnAkTgXn2xiFkcnF9e1Ud4BLMJJmhyqT3mN96F/6Vus=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
v2:
- splitted from v1
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


