Return-Path: <netdev+bounces-290947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APoWJvXjEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:17:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAB5BB6C6
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37B58302C6E9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA583932E8;
	Fri, 22 May 2026 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZSHTW6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394F3921CC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491607; cv=none; b=t7bA2IuZ6X/fZ9AfxKKQxIRsk63qG6836iMwh51wH6X+JL6iZtsQvFinpm01DefqfwRRudXL3rDnIBabgqQYEf321Uo1FHf5JwVfvTkfRnEhz740ZNFjhxsxI/farNAN2w1/dObGu775COZCDUYzzT+m6ZtQYiyW73YxEqHjHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491607; c=relaxed/simple;
	bh=j12tTNDoUgRq9A+syIyQuLwyjfaonJCW+4rtrVaXSqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBpyekO2rhh87HHDOuRbns46AhuElfv2XnDPHXvB0jxDn8HZG+C4p3pReShi4tD/Px586h47cagizNo8i+pLZQT4VZ0QYtvgPy6xxOsRzS75lnRSQEde9Mn0+4ja1YocmiYL5GNsxVrIlZ4pTV6uMSNeV9X+8g8XaI9HJzemaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZSHTW6b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E761F00A3F;
	Fri, 22 May 2026 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491606;
	bh=sQSouXtT3SAFGMJQ1B56D7q+Kwgmj1EqvhCFbATq5DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZSHTW6b1WMdTerTfyM1UcyOOR0ZilObeGd7sBvfDgnzklNB+Li13Z8JdOxo4iEin
	 zON7rjAjRTWH1P+pedaOgcVLhvg0st19F9Y3qfWE3ymX0HhFd6yZR0fNEc5K+G+ZXc
	 WB/ztqtvsiXC9aKiT0Zt6Pzrumuevo3vPVwF1rLQNSaZ+Kb/5ETx15fU2GW454FhuC
	 Wf99+UBPDIx5ieIuc1tNpCVwKcs9YGBUWxjT4yzCkob9drgJvBMyaY+R33+3NRcGIg
	 U33kVPnQYr+4iSf9iPAgnOzNwbw3YnpS7xaqzgpaKbM/fuIejcCxTVHZ93HngJJ7wg
	 fVUFAgR6jKU3A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 4/9] ethtool: module: check fw_flash_in_progress under rtnl_lock
Date: Fri, 22 May 2026 16:13:07 -0700
Message-ID: <20260522231312.1710836-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: F0DAB5BB6C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethnl_set_module_validate() inspects module_fw_flash_in_progress
but validate is meant for _input_ validation, not state validation.
rtnl_lock is not held, yet. Move the check into ethnl_set_module().

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: petrm@nvidia.com
CC: danieller@nvidia.com
---
 net/ethtool/module.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index cdb85e19a23b..5b49004ddf60 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -120,12 +120,6 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
 		return 0;
 
-	if (req_info->dev->ethtool->module_fw_flash_in_progress) {
-		NL_SET_ERR_MSG(info->extack,
-			       "Module firmware flashing is in progress");
-		return -EBUSY;
-	}
-
 	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
@@ -148,6 +142,12 @@ ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ops = dev->ethtool_ops;
 
+	if (dev->ethtool->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
 	ret = ops->get_module_power_mode(dev, &power, info->extack);
 	if (ret < 0)
-- 
2.54.0


