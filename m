Return-Path: <netdev+bounces-90042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0218AC933
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FA7B20F57
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81664A98;
	Mon, 22 Apr 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhaQGu5F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6152F96
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779092; cv=none; b=EvKiKlNU3FzObdaelDbHenSOcBQ+IDdx2jpSQjtwUDQLEAy4J6Fi+0mRmOC3Kw4N6N3gXPaDQTiwsdH+JSvlgEi3x0utgsE7TU7VojcJ+DKQssuOARvxB3sIcq7Diyn1ZztltKPitfUyAP1pEmCsC82fuf+2ulaBQyyXSwjNtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779092; c=relaxed/simple;
	bh=dYAYKUPe7HxeAfTBnafmssqy2FHNs1fz5JWVxLDOoSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q02QpU11lHzBH+8hGoMFhxF+SNOmFmyg18KZtX/T47Vy+IPnjAx74AA0cXrCcyNWVCqHEjmrCj+1LtY25OFbFH8wzj/SMV2M0GpywR4duV9u8nVxgokeQEGdiCODcGpiZd+c4G/UTkxsWN5jyKRL9FaGq6cedooKxrZqcTgqLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhaQGu5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A30C3277B;
	Mon, 22 Apr 2024 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779091;
	bh=dYAYKUPe7HxeAfTBnafmssqy2FHNs1fz5JWVxLDOoSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhaQGu5FPFmzPHcDj5UWEmp/kK/Pis6Dg8bn4g6jxR+2EssgcB1w3AkXyr0GO3Jyi
	 gofuBGDB+rIIF9Bku5n9pUJiSrGe5oP6Wgq+RjlDcNxRwf0epjRLCoQvSyCf9zZrJB
	 bHpKVYh81dD2OiDEjAirRe24P1odMmkDB3vL/+qSLLdaCOA+kCFsp7bDKM+1Np9VOG
	 8kA5P7KUu66Qd+X/7esyW9f9vzCKxXx1nhmnfvuocK+fRgYiLSo3oBJHfmss1qF2FE
	 MqMG8pkRiAmQUrZPKXFWpxXVPGQ4M48rJaBYL1hZLXt7nZbNRmqK1+djV25wQ/Or9Q
	 MKu0rfXeJQPIw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Simon Horman <simon.horman@corigine.com>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore 2.5G copper SFP module
Date: Mon, 22 Apr 2024 11:44:35 +0200
Message-ID: <20240422094435.25913-2-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422094435.25913-1-kabel@kernel.org>
References: <20240422094435.25913-1-kabel@kernel.org>
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

The PHY inside the module is Realtek RTL8221B-VB-CG PHY, for which
the realtek driver we only recently gained support to set it up via
clause 45 accesses.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
This patch depends on realtek driver changes merged in
  c31bd5b6ff6f ("Merge branch 'rtl8226b-serdes-switching'")
which are currently only in net-next.

Frank, Russell, do you still have access to OEM SFP-2.5G-T module?
It could make sense to try this quirk also for those modeuls, instead
of the current sfp_quirk_oem_2_5g.
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


