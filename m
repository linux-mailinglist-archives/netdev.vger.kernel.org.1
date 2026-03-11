Return-Path: <netdev+bounces-266565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO/9Myw/sWmtswIAu9opvQ
	(envelope-from <netdev+bounces-266565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B832261CA6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4113441EE4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90F3E3141;
	Wed, 11 Mar 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo1m1vQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F733E3D8D;
	Wed, 11 Mar 2026 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221203; cv=none; b=VAXvRaXn9DH3GzlK7+rLQ8LRYFPVrFVq8/YgT0Nl+mE4mjY4jto0NX1mMSeeKriagYD3xo/fa5lyYWJHNX9nlIRsLzrnDq78UmpGH9lPcnAWttM8q7we4+KU0WVe/I5r6S4MEwS4PvlcEEEgSRuboj7MhWZbEjY8GKMEQwT+7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221203; c=relaxed/simple;
	bh=2YgEmPb/8Z5ies75f85PikO3mop/46dFbxulERPGDEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=RjMjfh4rG1/WiZ8Hxt9DvjB3TurYlaMqUAE1HqQUYYvVZzEFQhrhnVVM3jYvbVbLwiKHafu64/9zUsKXXoBOWs42xrb5qeQL00w+sNtVshrf3Mn+fDroUkSf+w8JlUJYbM2tv4/Dw8jNWlbOPOkwntpfeORHPBIrNz9meZouaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo1m1vQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A16C7C2BC86;
	Wed, 11 Mar 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221202;
	bh=2YgEmPb/8Z5ies75f85PikO3mop/46dFbxulERPGDEo=;
	h=From:Date:Subject:To:Reply-To:From;
	b=lo1m1vQxMJPYPxVRLEfwSsXUa6HyH2HnFjpGRvXHm7w6feEnERo2JNaJ1O+N09oqF
	 rrU6AfWVqs27omlQgl2K5vDOendlFXjqV/kDZw5Oi+L/zQab440vQFNX8QOXXLFlqB
	 KRr+atf8zQn/lQZGMrtdUXaz7w5xiTOKLMRKuRzXhcv9c0glKfVgliwCBwcqTwLB/m
	 ZegedTK+f6OJPzppOP/ra5zRPqFP2oRZ33CUgsJ2Ih06CLCBHudPr7UDKSdib1js4Z
	 p0SqUlZmnSoHUtixcDbvalQGvejpVX77aa2R0T7DzsKp/0H6I2Uh6b+X9FM7eJ4MQ1
	 fRsoBxrVcVwuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB7F104950E;
	Wed, 11 Mar 2026 09:26:42 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Wed, 11 Mar 2026 17:26:39 +0800
Subject: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
X-B4-Tracking: v=1; b=H4sIAE81sWkC/x2N0QqDMAwAf0XyvEBbp7D9iuyhi2kXJlFTGYL47
 ys+Hhx3BxQ24QLP5gDjnxSZtYK/NUCfqJlRxsoQXOhd6z1qItR9QSVBCYTGZZutarbiZpIzG6Y
 4Te9IX6QxPu6hax31DmpyMU6yX7vhdZ5/0iMdoX4AAAA=
X-Change-ID: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773221201; l=1872;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=d9zEHKYZOWYj9HwgrSBRqAmlYHUoxnu970Vb9ocM+pQ=;
 b=PnTogQDYUwT2GIVK/ooEsD/zYmZXSC3pbnlbEbs1ziFsBf74kT27qLCG4pIgr8wN+zjSny8JF
 VwK4kMt5viMD7VLb1IGsh0A4SNk2pe7yvn1DGgAV4KToY8R3Xo4lLGs
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com
X-Rspamd-Queue-Id: 2B832261CA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266565-lists,netdev=lfdr.de,carl.lee.amd.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	HAS_REPLYTO(0.00)[carl.lee@amd.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:replyto,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Carl Lee <carl.lee@amd.com>

The driver previously relied on IRQF_TRIGGER_RISING when requesting
the interrupt. This was removed to rely on the trigger type provided
by firmware.

However, some platforms do not propagate the interrupt trigger type
to the IRQ descriptor, resulting in interrupts not being triggered.

Use the trigger type provided by firmware when available and fall
back to the historically used rising-edge trigger otherwise.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 drivers/nfc/nxp-nci/i2c.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..6339586a6a1b 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -268,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
 	int r;
+	unsigned long irqflags;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
@@ -303,9 +304,17 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 	if (r < 0)
 		return r;
 
+	/* Prefer the trigger type configured by firmware.
+	 * Some platforms do not provide it, so fall back to the
+	 * historically used rising-edge trigger.
+	 */
+	irqflags = irq_get_trigger_type(client->irq);
+	if (!irqflags)
+		irqflags = IRQF_TRIGGER_RISING;
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



