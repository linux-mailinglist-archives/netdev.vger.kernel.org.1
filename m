Return-Path: <netdev+bounces-273189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEAiIrN9ymmR9QUAu9opvQ
	(envelope-from <netdev+bounces-273189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0135C2BC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3310230BE14D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778DE3D523B;
	Mon, 30 Mar 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="SgNtH1Fv"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558437F75F;
	Mon, 30 Mar 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877434; cv=none; b=XxxbBudyEdGu8TszSdpzLaWs3mU4PfYOFs3xsQ9WBiInqHSkjRkDxATFUVrWgXiDeXKaob0SJssdPrsD1IjuFrNUvZmrQigPmZ2/DuahDBxOu3oDJUrgpjGPeJWnd2r6b8GXJHjv++JYu6R9Q9/HiE9dcjiJTbMTTzE+VWLg1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877434; c=relaxed/simple;
	bh=5YhF6FKdqzylfrNrOK0gXUeArO/IGwe5hCoJARHZgAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4db1OIEEh32jGwvJzG+8Z+XhAlsfmwrE1/B/PYoCjevgWZWozZP/XPICia1Xu0M1s9ghhbFO4IADl3pbd+JH806tkPXACFEoW3xBhoGxruK43Nci2lu7ghkqhM90ioai+NcPgOe+ilTtTASut0LOqnZMEaKyXCDrYExQNHy3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=SgNtH1Fv; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 404CFE8392D;
	Mon, 30 Mar 2026 15:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1774877431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxcFZjE73jyWoRwAxSgnECQDbuLjien1jQVNIfj90C0=;
	b=SgNtH1Fv/zEP8gI/BxfKQo+LOT10ny1owFm8nHD4S5tGf2MGLYxKp0GI01fp6YJR0A1Unf
	tupqH4FELd2lTNXXE8enQTRj49sPiZmcPhdHa2OdQbWOIEv2W3Qke2K0tC3KBsbKe9teC7
	MJ9lhqZUpF+8TnqOf8oE2patMJtzAaCbnGpVC9k7hCJFKXc3TWmd5LBC0Kt3/Pu6DHOGAc
	C6NSUUBp13ZffsaVinKidUsttX9dAiBA4VC6mYNOZa16PVnGA01BURwLgqO30IH0qFYhFh
	ycWARAl/E/t5WwA4ncCC0cW8eJ2aDFKvaayOVLlmJEqwHXKhGxQJJokqC14xJw==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id Ql5i64NHGlQW; Mon, 30 Mar 2026 15:30:31 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 30 Mar 2026 15:30:30 +0200 (CEST)
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
Subject: [PATCH net-next v2 1/3] net: pse-pd: prevent regulator cleanup from disabling unclaimed PSE PIs
Date: Mon, 30 Mar 2026 15:29:50 +0200
Message-ID: <20260330132952.2950531-2-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330132952.2950531-1-github@szelinsky.de>
References: <20260329161014.2908509-1-github@szelinsky.de>
 <20260330132952.2950531-1-github@szelinsky.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273189-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: F2A0135C2BC
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
Acked-by: Kory Maincent <kory.maincent@bootlin.com>
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


