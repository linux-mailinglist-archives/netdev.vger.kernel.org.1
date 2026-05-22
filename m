Return-Path: <netdev+bounces-290945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BhVHB/jEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAE5BB63C
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A37830074E0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AC391836;
	Fri, 22 May 2026 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWGkGz/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF1375F8E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491605; cv=none; b=XJKNYwQcyiO3K5j9dHFOJEhCx5G9sCOvYeNe7X4iXfiFc7gmxaLhvRJJyRYNuFrswzNnc43q7gw8opFbVQuKz5Zz+GCBsedGVYPNJdpjYiBjROF2sh26UEVis8KDOwykuyImzt9wv/ne+4E5oPVtdAkqxWKUdE7nYETeywFXN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491605; c=relaxed/simple;
	bh=SLY2QHXIZK+6HmD0COdznPYqs0RR2gj+6WAV2y+otHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3KO/tnUPCZmma7qN/81CX78eUj9/5nzOGvgsG37iyjwdyJ0XmE64FhNMPFoCmIHER3rv7jjUBIUKMbSkjh3eSpG+LgJ8w7OZewkhfocsFXonUUKiEfo5KsaFI1eRH0Xt7YuDEkMuRX1xZK8JvgezUf9Rdsu8FC0yr9ze0wlXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWGkGz/9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C2A1F00ADF;
	Fri, 22 May 2026 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491604;
	bh=9OvmP2dxGmY+OODxRQ8855QRZhSjlYG3teGEH/xpFaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWGkGz/9+SMw043BodtJ6IqKlXq6crzcD7LtOhJdxJYt2MsvlpUz1uanPC9lbnQBi
	 IxFAtcda+1gwESM+vy56W/7vWRhF5D28xnsn5znzTSsFZMOa2LBfg5oBcE//MrptwT
	 WkpRoHsf4SLxVvKoyx3mBO+HyDiizPWtgrzO1ObJSfIxluqN3ablksGK7xngQ1tvEu
	 Zb/KCKnxyMo5eyS49Uu/VY+KyrSjNLvDkf/+4KRpcPCK4cUjJCdOBRn0XdIkRjpkiz
	 hPRH2jlB18RGA2l7T4BwfEi5M1CG6CHUO1YgwRARVNHAFXQHk+No0jc15IwjueRr2k
	 10YOdoPs8ol3w==
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
Subject: [PATCH net 2/9] ethtool: module: avoid leaking a netdev ref on module flash errors
Date: Fri, 22 May 2026 16:13:05 -0700
Message-ID: <20260522231312.1710836-3-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290945-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 76BAE5BB63C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

module_flash_fw_schedule() is missing undo for setting
the "in_progress" flag and taking the netdev reference.
Delay taking these, the device can't disappear while
we are holding rtnl_lock.

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
CC: danieller@nvidia.com
CC: petrm@nvidia.com
---
 net/ethtool/module.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 741f6fb25d45..392c03935e5e 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -319,8 +319,6 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	if (err < 0)
 		goto err_release_firmware;
 
-	dev->ethtool->module_fw_flash_in_progress = true;
-	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
 	fw_update->dev = dev;
 	fw_update->ntf_params.portid = info->snd_portid;
 	fw_update->ntf_params.seq = info->snd_seq;
@@ -335,6 +333,9 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	if (err < 0)
 		goto err_release_firmware;
 
+	dev->ethtool->module_fw_flash_in_progress = true;
+	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
+
 	schedule_work(&module_fw->work);
 
 	return 0;
-- 
2.54.0


