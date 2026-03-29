Return-Path: <netdev+bounces-272935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMKxNWdPyWm/xQUAu9opvQ
	(envelope-from <netdev+bounces-272935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F773352D0A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12BFF3028C03
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E723815E7;
	Sun, 29 Mar 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="W7oLiZk2"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA73803F1;
	Sun, 29 Mar 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800645; cv=none; b=s79g3KjPKOCqAyqvct3QbERImoavmPuDNmihVnM9cCHYkjwAE5oJapALQMFL4OlRA/hhgLSq3GuXK+qhXI7Bjk0XO8HImfuMSxre3kcucRQAwhyv8l6APDairpJFRsJ7Jlp0m5VQTCUBQmTM9ekUAU43gtdxXbLaJLuINKA3uI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800645; c=relaxed/simple;
	bh=FjPBmb7sbxh3je9T4zb4X3mtCrGESVIQyoIpNQcSEk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f//1uP10LFPoKycC5PcbBd3O9L3ay0tg0APW1XaW7WJURMDUSTOcls6pJ7E0O77moiU26LiirR12uDFULf8yTekpzl1VfJ0euewWUbjr+IVfTcOhgD2KjUECXRlvOxgdAvI3iMbGj0RmK8nusmOncKFME+mKERxmRNuWp+Xy+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=W7oLiZk2; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id EE378E83A8D;
	Sun, 29 Mar 2026 18:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774800641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50/WO8MSecnkND79syf2COkGlyNU/ras3AKDpgbmDKA=;
	b=W7oLiZk2zdZ8QbaTC5VlyUwVwwBTs9YPnXYhxYJ/XAs+HqiZon9FCPQtRqo03i7FwCWVF2
	xSKZbPTyEuL86e9WGpv3PNIp6fAknL/KQiFrNAxoZRdwwD3bFTGe5PPG08o5anTygjUc3L
	BQz6OC1cq4pVdOpg3fegcbb2TmL+bXugz2+Jzm/lWN0tPDXSmRNmZ5/xbb8DImUKgho+HW
	ko+A+5jkiYoOw0e2LtqASUiwLik+QYxOMISaBjnIKPB3pFfIM2jOfjE2PWjwBzwfKFcq9D
	rQ1C1HRTK/wfvVFKJofi/r+Ng4bQZC7WlDfeCetKF40nWFHFrnThLFeSftQbEw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id P1DlYMwhnskw; Sun, 29 Mar 2026 18:10:41 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 29 Mar 2026 18:10:41 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH 2/3] net: pse-pd: prevent regulator cleanup from disabling unclaimed PSE PIs
Date: Sun, 29 Mar 2026 18:10:13 +0200
Message-ID: <20260329161014.2908509-3-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329161014.2908509-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
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
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272935-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid]
X-Rspamd-Queue-Id: 5F773352D0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PSE controller driver is loaded as a module, its PI regulators
are registered before any consumer (PHY) acquires the corresponding PSE
control via of_pse_control_get(). The regulator framework's
regulator_late_cleanup then calls pse_pi_is_enabled(), which queries
hardware and sees the PI is enabled. Since no consumer holds it
(use_count == 0), regulator_late_cleanup disables it, killing PoE.

Add an admin_state_synced flag to struct pse_pi that is set when a
consumer first acquires the PSE control and syncs admin_state_enabled
from hardware. In pse_pi_is_enabled(), report unsynchronized PIs as
disabled so regulator_late_cleanup skips them.

This preserves the existing dual-path behavior: software-tracked state
for software-controlled power domains, and hardware queries for
hardware-controlled domains. The admin_state_synced flag is only false
before the first consumer acquisition, which is the exact window where
regulator_late_cleanup could incorrectly disable the PI.

Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 13 +++++++++++++
 include/linux/pse-pd/pse.h    |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 3beaaaeec9e1..566b07c336bf 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -421,6 +421,18 @@ static int pse_pi_is_enabled(struct regulator_dev *rdev)
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
+
+	/*
+	 * Report the PI as disabled until a consumer has acquired it
+	 * and synced admin_state_enabled from hardware. This prevents
+	 * regulator_late_cleanup from disabling unclaimed PSE PIs
+	 * when the PSE controller driver loads as a module.
+	 */
+	if (!pcdev->pi[id].admin_state_synced) {
+		ret = 0;
+		goto out;
+	}
+
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
 		ret = pcdev->pi[id].admin_state_enabled;
 		goto out;
@@ -1431,6 +1443,7 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 
 	pcdev->pi[index].admin_state_enabled = ret;
+	pcdev->pi[index].admin_state_synced = true;
 	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
 						rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 4e5696cfade7..b86cce740551 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -260,6 +260,7 @@ struct pse_pi {
 	struct device_node *np;
 	struct regulator_dev *rdev;
 	bool admin_state_enabled;
+	bool admin_state_synced;
 	struct pse_power_domain *pw_d;
 	int prio;
 	bool isr_pd_detected;
-- 
2.43.0


