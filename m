Return-Path: <netdev+bounces-288628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJq8CP9dCGpglQMAu9opvQ
	(envelope-from <netdev+bounces-288628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 14:07:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84455BA53
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F2FE3012CBF
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015463D567E;
	Sat, 16 May 2026 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1gUesYh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629F37418A;
	Sat, 16 May 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933244; cv=none; b=KR9Hjz8FttPRtbkc2F2l3GwFZAH92eM80NVDdwLIQk/AtzV0T3c90mlYD90adSZxaXTkanTEmRLvXf0mAU/xvisL1GimL3wZesfq2x/rwFSAv0Y6sJIAzUEXwVr1Cv7PkHcYIrqsuMqbKIljJtSDb6SyglGTCwjkwD60j3VNObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933244; c=relaxed/simple;
	bh=di2Nx7xIU2JWNo5WwYBFMHkUwxrrucvWso4uehXJl2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t4MtsHp2DzjbR4BZF9wJaa7yLWE5oDV8nEJIddfs/ZX0/3n/Bkiowram7yWaIbJ08eU4zg0jrjyFRVjOiBj1HW6tKVyzvQXa9kDpCSb002NneNcIlqCtAz34B1K72ToNzuCJofks1cuiLgk6WsuMfWZb7JaAyFb4BeBG0FMrNCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1gUesYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B491C19425;
	Sat, 16 May 2026 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778933244;
	bh=di2Nx7xIU2JWNo5WwYBFMHkUwxrrucvWso4uehXJl2E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=O1gUesYhuiSxvo6Md8M61qX41NRYZ1D6yQf2JxV0EJ3kIESriwLqjC1ULsVPio/GD
	 fSHBxoM/44goSB3KsnYC4bFxpHPvSPMonE11nkDvbAxbldA0l3Ap59PSwNbLthkbTn
	 gjV4MsQl3AmUkVXtPV7Y6nUbmaSIqV/Kk24f9qsscDkd3mqMTRcDKeuq+oYyXTly3D
	 KQV1NiXErQE5/B47urAJ1AyCfMrrJwBFxTJzZFHzDWsnks4cgezkOmee7cMuhRBISJ
	 I42dQhubIb8I0TrTORh/wlcrysRT7dGarIUoSpO7maZJKuIky8UsKItUwNvKJWWp+F
	 jMIrR2CYfx5pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CBCCD4F3C;
	Sat, 16 May 2026 12:07:24 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Sat, 16 May 2026 19:55:18 +0800
Subject: [PATCH v3] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
X-B4-Tracking: v=1; b=H4sIACVbCGoC/52NzQ6CMBAGX4X07Jp2W0E9+R7GQ+0PbISChRAM4
 d0tXPSqx9nsNzOz3kVyPTtnM4tupJ7akEDuMmYqHUoHZBMz5JhzKQQEbyBMHQRDQGggun5oY3q
 LTxgilaWL4HVd37V5gLH6pPAguck5S8ouOk/TlrveEle0jl9bfRTr9c/QKEDAySEvhFJC2OKiG
 7s3bcPWzIjfavxRjUktc5Tq6AuvJf+ol2V5AyxLRqVBAQAA
X-Change-ID: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Carl Lee <carl.lee@amd.com>, krzk@kernel.org, carl.lee@amd.com, 
 peter.shen@amd.com, colin.huang2@amd.com, kuba@kernel.org, david@ixit.cz, 
 luca.stefani.ge1@gmail.com, brgl@kernel.org, mpearson@squebb.ca
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778932520; l=3257;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=AMSt9loXPyaoOpf5Py15SrUAJJFo8zGMLjoVxukd9fM=;
 b=e8EQLMWG6SkcKINegth5pIbCvRerCIZ38zgG62J9x+VNmzI8PCoOO/6oiL+tPg0EpWcZkk0Nm
 DACZRtwbQc7BCNz+cmTy412m4yDEbV7F+7D9KVfqmuIGFDlula/QlE3
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com
X-Rspamd-Queue-Id: 8E84455BA53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288628-lists,netdev=lfdr.de,carl.lee.amd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,ixit.cz,gmail.com,squebb.ca];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[carl.lee@amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,squebb.ca:email]
X-Rspamd-Action: no action

From: Carl Lee <carl.lee@amd.com>

Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
IRQF_TRIGGER_HIGH), which can lead to interrupt storms.

Use the historically working rising-edge trigger on ACPI systems to
avoid this regression.

Device Tree-based systems continue to use the firmware-provided
trigger type.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
Some ACPI-based platforms report incorrect IRQ trigger types,
which can lead to interrupt storms.

Use rising-edge IRQ on ACPI systems to avoid this regression,
while keeping firmware-provided trigger types on non-ACPI systems.

Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: krzk@kernel.org
Cc: carl.lee@amd.com
Cc: peter.shen@amd.com
Cc: colin.huang2@amd.com
Cc: kuba@kernel.org
Cc: david@ixit.cz
Cc: luca.stefani.ge1@gmail.com
Cc: brgl@kernel.org
Cc: mpearson@squebb.ca
---
Changes in v3:
- Use rising-edge IRQ on ACPI systems to avoid interrupt storms
- Keep using firmware-provided trigger type on non-ACPI systems
- Refine commit message to focus on regression on ACPI platforms
- Link to v2: https://lore.kernel.org/r/20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com

Changes in v2:
- Add missing <linux/irq.h> include for irq_get_trigger_type().
- Link to v1: https://lore.kernel.org/r/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com
---
 drivers/nfc/nxp-nci/i2c.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..266dc231c47d 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <linux/gpio/consumer.h>
@@ -267,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
+	unsigned long irqflags;
 	int r;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -303,9 +305,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 	if (r < 0)
 		return r;
 
+	/*
+	 * ACPI platforms may report incorrect IRQ trigger types
+	 * (e.g. level-high), which can lead to interrupt storms.
+	 *
+	 * Use the historically stable rising-edge trigger for ACPI devices.
+	 *
+	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
+	 * provided trigger type, falling back to rising-edge if not set.
+	 */
+	if (ACPI_COMPANION(dev)) {
+		irqflags = IRQF_TRIGGER_RISING;
+	} else {
+		irqflags = irq_get_trigger_type(client->irq);
+		if (!irqflags)
+			irqflags = IRQF_TRIGGER_RISING;
+	}
+
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_ONESHOT,
+				 irqflags | IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");

---
base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60

Best regards,
-- 
Carl Lee <carl.lee@amd.com>



