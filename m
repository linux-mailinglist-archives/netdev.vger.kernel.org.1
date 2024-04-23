Return-Path: <netdev+bounces-90404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E52718AE078
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AD5B23A76
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A65A788;
	Tue, 23 Apr 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+GZQbw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04156443
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862831; cv=none; b=StlU9TDb1v8OEXJ3rfMQNa1MBXUGRKnwfdlMeWRXmD/Ywzk/FLw0WFX35/Kkvyqmbp++p/RrGw9lpjhQ6r2FyN5j/n9tl8265/e/duRV2NPxDBzbHVyKE04pte41jidFaqhTORKxOoF/VKPpqMz+t41QNWzNdrRpkl/g6zOZVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862831; c=relaxed/simple;
	bh=PMXpt3oUBGf6RhbHU9YTyK2cMQRbrJwlqjA4ecWS2Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eip4LV/5pyA33rCYMoMiCGrXaaQIUKi378hRyaLIOwWOKmVThVY6IcRRJpy8am66139065/L2Ap2+dtjwVJ4cPpsC++o0FIdB2R3KDHRLb0NmPeNpOoib8xvecK5DIf1BgP2X7pN9BCEuydQVXGiDSneGonoCQGlypx+x/WFlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+GZQbw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCEAC116B1;
	Tue, 23 Apr 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713862830;
	bh=PMXpt3oUBGf6RhbHU9YTyK2cMQRbrJwlqjA4ecWS2Is=;
	h=From:To:Cc:Subject:Date:From;
	b=K+GZQbw6i8aVj7FNuJ1Brta19SHgPpl1Bk9CIP0SwM7OqPp56v25BmJl8HCcX2KtY
	 8rpcxZTTVERNl1pHwPZz35WARRwL64+Sm0nio6xNymCDIQVR5yVcSf3fNr87tyHnzC
	 l0F1H1K7SPA9tiymmPfjFruXQD+etNLN45CsHyek4xmjE9A9vfpEAW2joa5r6aQklO
	 87VmYV07cPgOynFuMvBcid+oX06mfU0wawQYO7cQvprt/3U7W7uNuHt0IYgZcXga08
	 N3utwh8b06OZoRie44nz9WbKCIjJAg7Ex0K5JcgIA7vwMVDnDpDV2sxb6VI9yIeBPB
	 gzA30DIz2FQNA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net-next] net: sfp: add quirk for ATS SFP-GE-T 1000Base-TX module
Date: Tue, 23 Apr 2024 11:00:25 +0200
Message-ID: <20240423090025.29231-1-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

Add quirk for ATS SFP-GE-T 1000Base-TX module.

This copper module comes with broken TX_FAULT indicator which must be
ignored for it to work.

Co-authored-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
[ rebased on top of net-next ]
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7d063cd3c6af..3f9cbd797fd6 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -509,6 +509,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
+	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
+
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
-- 
2.43.2


