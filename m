Return-Path: <netdev+bounces-46413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B77E3BDA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E6D2810D8
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E342E3FB;
	Tue,  7 Nov 2023 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5i4AnjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E492E3F5
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B55EC433C8;
	Tue,  7 Nov 2023 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359017;
	bh=J61bFAhNYJImoXP4iAcz5dX9zulW1SGBjxGSdZh2ENw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5i4AnjM5ajfOA5nRqe7THWO6Fjn6usIS3cKmwV+SKLIE/D9KN7QvWE4pypPN5nVI
	 Kk61ZkL082BdHCY3iuaJa/doxxC+cdi1W8rzxDS3tghuUriF0AiayJwuALyCVTHxRN
	 1D3YzR9obnJTLUtPNVr1O2ZjODDeVsUGvw1TrUOQOW9DXS2lPtq4b/fmy2bg5GIZPa
	 Gm2NJoqMI/7VaefFppNeqyIwwRe70Xd7eaEKbzDCevQeCzn/iQDj2go3SyAyVSRy/a
	 Gh8RTTQYU5U2D9/7I+nztvVC5xw9D8JYLX1tTFSLFal5lLtEHf8HxpmMi2a8ZBJODU
	 MT4dxt2eUtlKg==
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
Subject: [PATCH AUTOSEL 6.5 19/30] net: sfp: add quirk for FS's 2.5G copper SFP
Date: Tue,  7 Nov 2023 07:08:34 -0500
Message-ID: <20231107120922.3757126-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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
index 338b9769d91a1..f411ded5344a8 100644
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


