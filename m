Return-Path: <netdev+bounces-90401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F28AE04A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E67B258AF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6D5647B;
	Tue, 23 Apr 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0lN8sJk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888556446
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862252; cv=none; b=kyPNL7MvYPpiw2TazLtiNDGycVTdrzS+6I2Keb+25z+IYQf/+ZmMYTrbPycDkePVGGZIjZ0VJpMyWug8CoLQRgu1RfT7gIwJX+eoOfNZKV3OOPPDJsx8t39bPmsuwoMI6A/GOiJ1D8brErod8uf0Q6QWhTodzXT/seA2C3HTJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862252; c=relaxed/simple;
	bh=034A9j2Pcc5Nt4sebWXFrUpQzsxIQNMSNmIYgfqkfM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcBpOjchsfYjVePEOJghUYJZVIQfZEEJLbfLRentbMCdtKsAJZklaZ4jyKPDHFHoiOZrJrVsZO93PFfcm2WU0hsW6DHc/I1hSZUohvQuIOMazeOjXrRhQssu9epa9luDeDH2zIJPYiNyutVpz8v300gyQDJ8cVNuvG4RClEIZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0lN8sJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCA1C116B1;
	Tue, 23 Apr 2024 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713862251;
	bh=034A9j2Pcc5Nt4sebWXFrUpQzsxIQNMSNmIYgfqkfM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0lN8sJkGjhv5WqJ/Q0zSOyWhsxJRn9g0aFke/dWREFQGo0sBXUqlaZTWwI17u6Ww
	 Wycqy2pMUUBJHF8ozVCq5jDEnvsJlmx/yqzE71BVOfL+1Sw6qq3yQM+/aCBNNMgh3I
	 LFjHC4EiE6nYqFqxwfA5EU4nrviHJvQ0mvnUrq6NzaoznL8VQTkwIl0Q3YI/u8HF/2
	 tnMT3WLWJwX2eIpmURK4737f+1YxcDI2AwQoh8dg4cK80VC2zIseZRP0/+SudqPr/a
	 2oiHiEuN5ms4U0q310OQLVpGdLphHm8lHpDcyjPSTctvbrbNSBxb5PTDd3+fDsBLUN
	 n4nAt7F0VcwXg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 2/2] net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module
Date: Tue, 23 Apr 2024 10:50:39 +0200
Message-ID: <20240423085039.26957-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423085039.26957-1-kabel@kernel.org>
References: <20240423085039.26957-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enhance the quirk for Fibrestore 2.5G copper SFP module. The original
commit e27aca3760c0 ("net: sfp: add quirk for FS's 2.5G copper SFP")
introducing the quirk says that the PHY is inaccessible, but that is
not true.

The module uses Rollball protocol to talk to the PHY, and needs a 4
second wait before probing it, same as FS 10G module.

The PHY inside the module is Realtek RTL8221B-VB-CG PHY. The realtek
driver recently gained support to set it up via clause 45 accesses.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
This patch depends on realtek driver changes merged in
  c31bd5b6ff6f ("Merge branch 'rtl8226b-serdes-switching'")
which are currently only in net-next.
---
 drivers/net/phy/sfp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 1af15f2da8a6..7d063cd3c6af 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,18 +385,23 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
-static void sfp_fixup_fs_10gt(struct sfp *sfp)
+static void sfp_fixup_fs_2_5gt(struct sfp *sfp)
 {
-	sfp_fixup_10gbaset_30m(sfp);
 	sfp_fixup_rollball(sfp);
 
-	/* The RollBall fixup is not enough for FS modules, the AQR chip inside
+	/* The RollBall fixup is not enough for FS modules, the PHY chip inside
 	 * them does not return 0xffff for PHY ID registers in all MMDs for the
 	 * while initializing. They need a 4 second wait before accessing PHY.
 	 */
 	sfp->module_t_wait = msecs_to_jiffies(4000);
 }
 
+static void sfp_fixup_fs_10gt(struct sfp *sfp)
+{
+	sfp_fixup_10gbaset_30m(sfp);
+	sfp_fixup_fs_2_5gt(sfp);
+}
+
 static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 {
 	/* Ignore the TX_FAULT and LOS signals on this module.
@@ -473,6 +478,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY and
+	// needs 4 sec wait before probing the PHY.
+	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
+
 	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
 	// NRZ in their EEPROM
 	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
@@ -489,9 +498,6 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
-	// FS 2.5G Base-T
-	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
-
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
-- 
2.43.2


