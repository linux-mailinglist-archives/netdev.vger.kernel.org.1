Return-Path: <netdev+bounces-290946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLxQDSTjEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32465BB64C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A176300D9C9
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA4392828;
	Fri, 22 May 2026 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSzNZqMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90708390610
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491606; cv=none; b=kLP4sN/sDUrsFYCgNon5Q0qg6ObyRP5xS5MUr1vlB0a1ItgzlKyV9ZCO8p6t04QcSIWTIpH1sJLdTcHBALWDRX0x5C4yxmANcZse/jJQvB6hv9oAgIpc6Qci+5yurbAI1BZEJeqV091kX+88Y8V1iNHgvpSP6iwwq+UIAm2KG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491606; c=relaxed/simple;
	bh=Th+c3oQt7HajgEjJIWPN+b1ReKcSqY7BpXNkRXvXl60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz9hYkJ56htHpvRsMaMOiRCcMcwby4s/5Dd5bV9iNYViRNt9dlnpMqgnApnL3yoZdLHLJERfhfROD4VjsEoDFgJ/iDYs1RThQkZBSYBB68oHG/NhNyKVJyzJNEH3A72ETVzXJ5lHPEYw1jH3/8mSlPkFxoCHbSw3LrALh2wtAko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSzNZqMQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D01F000E9;
	Fri, 22 May 2026 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491605;
	bh=Hqx5GV0ByjubbTXtqCuQDOfD+XTS5t3KbDL47annsoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mSzNZqMQ004XTVNvZ4w33Qft2aQUmJY6okn/dxUfOIke5DiFFBugj+3UtCcD8OIhV
	 R9FIc/O33ZfTRC5ukJ8xneEhnCu8rE2b2IDelLVrSzyDW0tMmn1BEX2Vs+QLfFuGcG
	 8NOHywD9VqIF0T1n+ZK9bblgBUHNzGgoO9U0kO4C8N6J/CO3beOiIuzpvow/sJ0Z/z
	 GJfDm4uwC407fujmSdoAoiav0DCNpXoote5yx/e7d1oCvvs+LCdvUw59s6rirwhKvt
	 du+hm4NulA+n5Or6tUqgaQ/eZtoxrVIDkl62BG6b+dmzULGpG72QdkiCO/TR0Qkb8n
	 6Witx84j1bw1w==
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
Subject: [PATCH net 3/9] ethtool: module: avoid racy updates to dev->ethtool bitfield
Date: Fri, 22 May 2026 16:13:06 -0700
Message-ID: <20260522231312.1710836-4-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290946-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email,nvidia.com:email]
X-Rspamd-Queue-Id: A32465BB64C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When reviewing other changes Gemini points out that we currently
update module_fw_flash_in_progress without holding any locks.
Since module_fw_flash_in_progress is part of a bitfield this
is not great, updates to other fields may be lost.

We could use a bool and sprinkle some READ_ONCE/WRITE_ONCE here
but seems like the issue is rather than the work is an unusual
writer. The other writers already hold the right locks. So just
very briefly take these locks when the work completes.

Note that nothing ever cancels the FW update work, so there's
no concern with deadlocks vs cancel.

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: petrm@nvidia.com
CC: danieller@nvidia.com
---
 net/ethtool/module.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 392c03935e5e..cdb85e19a23b 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -221,14 +221,22 @@ static void module_flash_fw_work_list_del(struct list_head *list)
 static void module_flash_fw_work(struct work_struct *work)
 {
 	struct ethtool_module_fw_flash *module_fw;
+	struct net_device *dev;
 
 	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
+	dev = module_fw->fw_update.dev;
 
 	ethtool_cmis_fw_update(&module_fw->fw_update);
 
 	module_flash_fw_work_list_del(&module_fw->list);
-	module_fw->fw_update.dev->ethtool->module_fw_flash_in_progress = false;
-	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+	dev->ethtool->module_fw_flash_in_progress = false;
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+
+	netdev_put(dev, &module_fw->dev_tracker);
 	release_firmware(module_fw->fw_update.fw);
 	kfree(module_fw);
 }
-- 
2.54.0


