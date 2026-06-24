Return-Path: <netdev+bounces-301672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nsHbIWbmO2pNfAgAu9opvQ
	(envelope-from <netdev+bounces-301672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F401D6BF01F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:15:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=JpRHnsy1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301672-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6C63086901
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D423BED37;
	Wed, 24 Jun 2026 14:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8663BD653;
	Wed, 24 Jun 2026 14:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310427; cv=none; b=Yexs3+XQXvxS+Py07gHNQfW838nGUQD97G4RjD/1aJxQpv1exHpG2OO1RkJ6hV3w3/kFEEylZEQ/gwpUDjuuWtqi6ZLwPt/ARahbR2Lwjx9nJHls37YC0w9mWE2KgxBT6DFPOs0BeCom4G2m9pkYk3K414p69E6MKM4xf6Ck+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310427; c=relaxed/simple;
	bh=qs4HdGGXnidMeXPJoY99yhlSz/Oo1iirDN7Wu9FHlco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCg5knoZASRYzVZpqnKMKTwfx+h7GYJz4bfsyaSWY0wMw7lk47s1YMnLi6L7tnePaVyYfCiYj3X5etN+lX0fgpZjgl4y+241SExELfemw7VpCy9/0+N+z4T+KK2PJEuwBEQOkqw5hHRdnRDzzTBm00jPKJtMcYpCye7it1PQfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JpRHnsy1; arc=none smtp.client-ip=113.46.200.221
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bD1mdxzpceNQDEF5KCevWSq4lzcjd2fEFXJ9CIadwxs=;
	b=JpRHnsy1EP7FEhzMjc5FcDl9DkeTsZWL8Qv3TQ0986pZijeYCGwdUeWRVdPpzKLMybJL80q7U
	SAPvVpBXf0c4cLOfS0CNcUBp7BQB/xlMnPMsWhP8mrL8t+ZoDJdL8TJapKMRDU2P4MRB31Zi0+L
	jyKf0Qy3QKUDYZpvCtF66bM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4glkFw1W6czRhQQ;
	Wed, 24 Jun 2026 22:04:36 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F79640569;
	Wed, 24 Jun 2026 22:13:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 22:13:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net 3/4] net: hns3: fix permanent link down deadlock after reset
Date: Wed, 24 Jun 2026 22:13:18 +0800
Message-ID: <20260624141319.271439-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260624141319.271439-1-shaojijie@huawei.com>
References: <20260624141319.271439-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,h-partners.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F401D6BF01F

From: Shuaisong Yang <yangshuaisong@h-partners.com>

Fix a critical race condition deadlock where the network interface
remains permanently Link Down after a hardware reset under specific
ethtool sequences.

This issue exclusively manifests in firmware-controlled PHY topologies
where the driver relies on the IMP firmware to arbitrate link parameters.
Standard devices driven by the kernel's native PHY_LIB are unaffected.

The deadlock occurs via the following path:
1. User disables autoneg and forces an unmatched speed, forcing link
   down: `ethtool -s ethx autoneg off speed 10 duplex full`
2. User re-enables autoneg: `ethtool -s ethx autoneg on`. The netdev
   stack passes cmd->base.speed as SPEED_UNKNOWN (0xffffffff).
3. Driver saves req_autoneg=1, but before the interface can link up,
   a hardware reset is triggered.
4. During reset recovery, MAC init reads the un-synchronized runtime
   state mac.autoneg (which is still 0/OFF), misinterprets it as
   forced mode, and pushes the cached SPEED_UNKNOWN into the hardware
   registers, causing the MAC firmware state machine to freeze.
   Meanwhile, PHY init reads req_autoneg=1 and enables PHY autoneg.

Since the MAC is frozen with 0xffffffff and PHY is running autoneg,
they mismatch permanently.

Fix this by:
1. Intercepting SPEED_UNKNOWN/DUPLEX_UNKNOWN in
   hclge_set_phy_link_ksettings() and hclge_cfg_mac_speed_dup_h() to
   prevent it from corrupting the driver's cached valid configuration.
2. Save req_autoneg in hclge_set_autoneg().
3. Aligning the state judgment in hclge_set_autoneg_speed_dup() to use
   req_autoneg instead of the un-synchronized runtime mac.autoneg,
   ensuring both MAC and PHY consistently enter the autoneg branch to
   eliminate configuration discrepancies during reset recovery.

Fixes: 05eb60e9648c ("net: hns3: using user configure after hardware reset")
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fb12ba77228c..d176100d3e4c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2585,8 +2585,10 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 		return ret;
 
 	hdev->hw.mac.req_lane_num = lane_num;
-	hdev->hw.mac.req_speed = (u32)speed;
-	hdev->hw.mac.req_duplex = duplex;
+	if (speed != SPEED_UNKNOWN)
+		hdev->hw.mac.req_speed = (u32)speed;
+	if (duplex != DUPLEX_UNKNOWN)
+		hdev->hw.mac.req_duplex = duplex;
 
 	return 0;
 }
@@ -2617,6 +2619,7 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
 
 	if (!hdev->hw.mac.support_autoneg) {
 		if (enable) {
@@ -2628,7 +2631,10 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 		}
 	}
 
-	return hclge_set_autoneg_en(hdev, enable);
+	ret = hclge_set_autoneg_en(hdev, enable);
+	if (!ret)
+		hdev->hw.mac.req_autoneg = enable;
+	return ret;
 }
 
 static int hclge_get_autoneg(struct hnae3_handle *handle)
@@ -3343,8 +3349,10 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 
 	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
-	hdev->hw.mac.req_speed = cmd->base.speed;
-	hdev->hw.mac.req_duplex = cmd->base.duplex;
+	if (cmd->base.speed != SPEED_UNKNOWN)
+		hdev->hw.mac.req_speed = cmd->base.speed;
+	if (cmd->base.duplex != DUPLEX_UNKNOWN)
+		hdev->hw.mac.req_duplex = cmd->base.duplex;
 
 	return 0;
 }
@@ -9313,12 +9321,12 @@ static int hclge_set_autoneg_speed_dup(struct hclge_dev *hdev)
 	int ret;
 
 	if (hdev->hw.mac.support_autoneg) {
-		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
+		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.req_autoneg);
 		if (ret)
 			return ret;
 	}
 
-	if (!hdev->hw.mac.autoneg) {
+	if (!hdev->hw.mac.req_autoneg) {
 		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
 						 hdev->hw.mac.req_duplex,
 						 hdev->hw.mac.req_lane_num);
-- 
2.33.0


