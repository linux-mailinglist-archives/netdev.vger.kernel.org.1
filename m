Return-Path: <netdev+bounces-46405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78C7E3B9F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EE21C20C8A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0E2DF92;
	Tue,  7 Nov 2023 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBYs3nMJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0129422
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C021DC433C7;
	Tue,  7 Nov 2023 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699358891;
	bh=FcoNM3XJcP4DwFFhQmlw06GnbCF28OSKtSvDxuhdixM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBYs3nMJEQ5seGgjAoEluHNXFBtQ7nbQkpyOjf0WZpdk2pqP2OEkIESZsAESEGxUf
	 SJ+m6j/f/jrSVTHVvlYW+T7OWJkZnGVeynbQRrPB8Jr4Z3qczwm7LX7msPpaGeUDhh
	 XKIZ1WlgQxVt9sKrILbcYyAq/XyIbaDaqCYMlYLoGEzJ2o99BB52KXHOxfnk0ojyfp
	 GiKtI41r3VcXPdb2PlxfZfpsJcuuwQuhkwyCOGLQBjYGiUex2aQ7etHcGeH6VItgpy
	 O8KPo5QHw09IlKCHzttx+YBWI9KI18eNUlC4K/Nnw2N5o/onRRu/MSiS5hka3KgmgU
	 cALE2fAIGks2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/31] net: sfp: add quirk for FS's 2.5G copper SFP
Date: Tue,  7 Nov 2023 07:06:07 -0500
Message-ID: <20231107120704.3756327-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit

From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

[ Upstream commit e27aca3760c08b7b05aea71068bd609aa93e7b35 ]

Add a quirk for a copper SFP that identifies itself as "FS" "SFP-2.5G-T".
This module's PHY is inaccessible, and can only run at 2500base-X with the
host without negotiation. Add a quirk to enable the 2500base-X interface mode
with 2500base-T support and disable auto negotiation.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Link: https://lore.kernel.org/r/20230925080059.266240-1-Raju.Lakkaraju@microchip.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a50038a452507..3679a43f4eb02 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -468,6 +468,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// FS 2.5G Base-T
+	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+
 	// Lantech 8330-262D-E can operate at 2500base-X, but incorrectly report
 	// 2500MBd NRZ in their EEPROM
 	SFP_QUIRK_M("Lantech", "8330-262D-E", sfp_quirk_2500basex),
-- 
2.42.0


