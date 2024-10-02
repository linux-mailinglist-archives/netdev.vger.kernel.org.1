Return-Path: <netdev+bounces-131196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B4C98D2E9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8509E1F2318A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED51CF5C2;
	Wed,  2 Oct 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EyMkUR8a"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D81D528;
	Wed,  2 Oct 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871439; cv=none; b=LAykxHfMgfZ2kDxM4YlkItYdlKNJNkYtdBiGVqoTaqpW5sJKIgP27dZr49YZuKrrP13g2+Tai0rad1ln1mJpuTcjF8C/oOLN+nxs3QB1XObxIJ2dNIrinxwm9nWqE8rD6NGH7y6XSx//er89nrcbwuh7RItwzqQhSlpqxgwAhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871439; c=relaxed/simple;
	bh=VwXs5fEe6ukIjIqGiGAYX3ccU5a4WTWtTjyPSmJJNBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i344iopukHQTwV2FhkrTU9PesdCspsCboscdwbrmbJC2oMz2qVoSmgbB1gwwAL3De8U+VCT/SrNxYLaSGv2xGsn20IPQnyQKWD26H63YnfhdRGsME2AA47OvrW9jYjVxVLlWLEgzuMbacW2dzdP6D9+jdnCVk3/lcNGZ+j44LG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EyMkUR8a; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AE371BF203;
	Wed,  2 Oct 2024 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727871435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ri8ksjifMMww37ON6x9puX9cUhDswF4KROFlLlgVHzg=;
	b=EyMkUR8a29dSYOD0t0LJ+GcttxURC8M5iQG2tGgq3X13Djn5U7o7Q6tCfdu418PeSNXMyc
	AkVuv8vY8HftjNLPI2mQ7nkYu+PaiiO9wISPQOSLRUFb4e4ooMyh7norv9eQCTMPVQEaNH
	AO7kHUrocCrfIKG/V5xWiLOCk2slkkaca2A+CFO779S7iVDncRMJaEwQnic/2ZeEpBsPgm
	6VdWXIGI3YLyToBV7kmnH2PF6Mjcv3++DAk2uBtZgobLNs5bSoZriHCUQT81q3mzfQ1ic4
	bfQ7V8Za/KO4rBncUpNT27EoDeBFPNGNztOC/q2PylCMTvOHJSOvpPq0FP9ntA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kyle Swenson <kyle.swenson@est.tech>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: Fix enabled status mismatch
Date: Wed,  2 Oct 2024 14:17:05 +0200
Message-Id: <20241002121706.246143-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

PSE controllers like the TPS23881 can forcefully turn off their
configuration state. In such cases, the is_enabled() and get_status()
callbacks will report the PSE as disabled, while admin_state_enabled
will show it as enabled. This mismatch can lead the user to attempt
to enable it, but no action is taken as admin_state_enabled remains set.

The solution is to disable the PSE before enabling it, ensuring the
actual status matches admin_state_enabled.

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

FYI: Saving the enabled state in the driver is not a viable solution, as a
reboot may cause a mismatch between the real and software-saved states.
---
 drivers/net/pse-pd/pse_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 4f032b16a8a0..f8e6854781e6 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -785,6 +785,17 @@ static int pse_ethtool_c33_set_config(struct pse_control *psec,
 	 */
 	switch (config->c33_admin_control) {
 	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
+		/* We could have mismatch between admin_state_enabled and
+		 * state reported by regulator_is_enabled. This can occur when
+		 * the PI is forcibly turn off by the controller. Call
+		 * regulator_disable on that case to fix the counters state.
+		 */
+		if (psec->pcdev->pi[psec->id].admin_state_enabled &&
+		    !regulator_is_enabled(psec->ps)) {
+			err = regulator_disable(psec->ps);
+			if (err)
+				break;
+		}
 		if (!psec->pcdev->pi[psec->id].admin_state_enabled)
 			err = regulator_enable(psec->ps);
 		break;
-- 
2.34.1


