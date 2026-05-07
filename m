Return-Path: <netdev+bounces-285328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IElVLR6S/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE14E92B8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F1F1305899B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD83EE1E2;
	Thu,  7 May 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="jhrE80Ck"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3C3EF0C6
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159946; cv=none; b=Frji+OnPKShoRhIvrJUxgWf4ChjW8EQGsAbSxJQgW9a8bU/QqX77R6hWhcKHgdNJF0BMTzFNuqbkHUpLvH7A5j80B4aL9Vhp0YmF0B+LL7hkzJRv8xcvYUhxRS4cSzmIE2HCbB/nHLq4MCZ3waALgG+64skYwMNCABfzTRxICaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159946; c=relaxed/simple;
	bh=O2Ko6MMDPswq+2WaGJcwYPfRmAJ4xzGSNytJFy3ZRYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oo4OTvydzdTtAeVo1fV1ownCVmX+x+G35CgeKheUxBEKlE+IetigO6G5upVtGIMVhvi8y4zCnvpQQkoaSvDfIX8HHfcImTO3n6vjXzEp8hTSqI9z3hlDElSb7ac3iYeDy6D2xVaXR/5BTylFbQEto7e9IGgcL5ieVPLtuMzOgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=jhrE80Ck reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=IWxnW7r6EJ
	ztc7KWkI3CWk9w5pZdQa0xURcl43HTPuY=; b=jhrE80CkWZocdcKomi91Sgp7cp
	9IUmpuOSjmewJt3oCtRuPKtfme/r4d+PqZZtfKSUMG9pFITjSUbFPQMPITZ014Ls
	ueRcp6NTNZw9JspG4h+Mw0S9N7H6Ianm+rmqx6uhCOfRJIIhaHFWpQbmwZeizPSq
	HSVlq8C9bYJ7sLVIA=
Received: from hotaru.tailb307d0.ts.net (unknown [58.19.27.109])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkBW+bQokfxpvpbzAQ--.4741S2;
	Thu, 07 May 2026 21:18:33 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH net v2] net: ethtool: fix NULL pointer dereference in phy_reply_size
Date: Thu,  7 May 2026 21:17:38 +0800
Message-ID: <20260507131738.1173835-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkBW+bQokfxpvpbzAQ--.4741S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5Zw1UKr43Ar1kJw4DXFb_yoW5ZrWkpa
	yUGaySqrWxJwnrJrsxJw45CryYvF4fCa45t3y2k3yfAr13WrWFqFWUKF18t34F9rykXF43
	XF4rJa90gwnrCFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUvg4fUUUUU=
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/
X-Rspamd-Queue-Id: 35CE14E92B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	DMARC_POLICY_QUARANTINE(1.50)[uestc.edu.cn : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_PERMFAIL(0.00)[std.uestc.edu.cn:s=dkim];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[std.uestc.edu.cn:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.992];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[2022090917019@std.uestc.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

In phy_prepare_data(), several strings such as 'name', 'drvname',
'upstream_sfp_name', and 'downstream_sfp_name' are allocated using
kstrdup(). However, these allocations were not checked  for failure.

If kstrdup() fails for 'name', it returns NULL while the function
continues. This leads to a kernel NULL pointer dereference and panic
later in phy_reply_size() when it unconditionally calls strlen() on
the NULL pointer.

While other strings like 'upstream_sfp_name' might be checked before
access in certain code paths, failing to handle these allocations
consistently can lead to incomplete data reporting or hidden bugs.

Fix this by adding proper NULL checks for all kstrdup() calls in
phy_prepare_data() and implement a centralized error handling path
using goto labels to ensure all previously allocated resources are
freed on failure.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
Changes in v2:
- Add Fixes: tag.
- Expand the fix to cover all kstrdup() allocations in the function.
- Use goto labels for a cleaner and more robust error handling path.
---
 net/ethtool/phy.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index d4e6887055ab1..f76d94d848d6d 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -76,6 +76,7 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	struct nlattr **tb = info->attrs;
 	struct phy_device_node *pdn;
 	struct phy_device *phydev;
+	int ret;
 
 	/* RTNL is held by the caller */
 	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PHY_HEADER,
@@ -88,8 +89,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 
 	rep_data->phyindex = phydev->phyindex;
+
 	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
+	if (!rep_data->name)
+		return -ENOMEM;
+
 	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+	if (!rep_data->drvname) {
+		ret = -ENOMEM;
+		goto err_free_name;
+	}
+
 	rep_data->upstream_type = pdn->upstream_type;
 
 	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
@@ -97,15 +107,33 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 		rep_data->upstream_index = upstream->phyindex;
 	}
 
-	if (pdn->parent_sfp_bus)
+	if (pdn->parent_sfp_bus) {
 		rep_data->upstream_sfp_name = kstrdup(sfp_get_name(pdn->parent_sfp_bus),
 						      GFP_KERNEL);
+		if (!rep_data->upstream_sfp_name) {
+			ret = -ENOMEM;
+			goto err_free_drvname;
+		}
+	}
 
-	if (phydev->sfp_bus)
+	if (phydev->sfp_bus) {
 		rep_data->downstream_sfp_name = kstrdup(sfp_get_name(phydev->sfp_bus),
 							GFP_KERNEL);
+		if (!rep_data->downstream_sfp_name) {
+			ret = -ENOMEM;
+			goto err_free_upstream_sfp;
+		}
+	}
 
 	return 0;
+
+err_free_upstream_sfp:
+	kfree(rep_data->upstream_sfp_name);
+err_free_drvname:
+	kfree(rep_data->drvname);
+err_free_name:
+	kfree(rep_data->name);
+	return ret;
 }
 
 static int phy_fill_reply(struct sk_buff *skb,
-- 
2.43.0


