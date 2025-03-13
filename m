Return-Path: <netdev+bounces-174583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B31A5F625
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5843A189F20F
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B2267B07;
	Thu, 13 Mar 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHcXZMjH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F18267AE8
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873317; cv=none; b=prs7DNiPv6Z9Jdbe73NiQvKx4GqRWbza3edTjXoIsmq7UaVOUBM8a1j13o0/3gTcHQdSC4M17hg7DW/JMNVfy0vZB6wvQ7msM5zbw6bEOCR1OYA3iTAzk/5sjG28kaXZASQ9xKn5AHX369CuV3t42yvqjC3dtXnVQUYhIy0SKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873317; c=relaxed/simple;
	bh=ox5sPsgfn5qp2vKxbYdXZznttUL8jCEkximgmtRHOA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmzLArq4GhwXyzi6G8g7mC+2gkvRw5IkmowD68pkUD60MPAnqM1L/RPYFg9BDAxDhdyJ8CV3yUn5GBgGpK3+f8sImvNGeY8kH35OnvJl0UkdKOsT8sfhjkrfvTfNjGDbNa4MuiGpgJr4CHV/5/oRv7BJ7qfuvfWYlV/FX+8x1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHcXZMjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF9C4CEDD;
	Thu, 13 Mar 2025 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873315;
	bh=ox5sPsgfn5qp2vKxbYdXZznttUL8jCEkximgmtRHOA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHcXZMjHX4tHwhjiOopmHs4vpzr2GXm6zDohbcKaqSB82Ov2oSdqxh60LKFnW5cm4
	 ejH4omnN/hOp+JOwnjncVk8CFViR+Oc9wzb/ig1eT4quLiTQdYULVGM7UYnsbCMC47
	 0u6SNId8mPXx77ngWzMh9bc0HS7moblKLcp+ppVKSDI+jmCAJJrhiI+ErJli2ovXrp
	 wLso19nMV1a4YiEy3WS7h3NCEON5lylIJHDLg3eVOqmoqS3Gfi1DxmkosOo1CzqrMH
	 J+JSnkw5pMc0wObIEOmXJ3d5AAkxq9xCubVs9l8wu8jNYu37GR5LS4RUm46+Vd43rP
	 unHg8Ef50o8Ow==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 02/13] net: dsa: mv88e6xxx: fix VTU methods for 6320 family
Date: Thu, 13 Mar 2025 14:41:35 +0100
Message-ID: <20250313134146.27087-3-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
References: <20250313134146.27087-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VTU registers of the 6320 family use the 6352 semantics, not 6185.
Fix it.

Fixes: b8fee9571063 ("net: dsa: mv88e6xxx: add VLAN Get Next support")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
This bug goes way back to 2015 to commit b8fee9571063 ("net: dsa:
mv88e6xxx: add VLAN Get Next support") where mv88e6xxx_vtu_getnext() was
first implemented: the check for whether the switch has STU did not
contain the 6320 family.

Therefore I put that commit into the Fixes tag.

But the driver was heavily refactored since then, and the actual commits
that this patch depends on are
  f1394b78a602 ("net: dsa: mv88e6xxx: add VTU GetNext operation")
  0ad5daf6ba80 ("net: dsa: mv88e6xxx: add VTU Load/Purge operation")
But I don't know how to declare it properly.
Using the "Cc: stable" method with these commits tagged would mean they
should be cherry-picked, but these commits in turn depend on other
changes in the driver.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 99d8d438e465..aa8ebe9d6bdc 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5164,8 +5164,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5212,8 +5212,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
-	.vtu_getnext = mv88e6185_g1_vtu_getnext,
-	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.vtu_getnext = mv88e6352_g1_vtu_getnext,
+	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
-- 
2.48.1


