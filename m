Return-Path: <netdev+bounces-153920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455799FA106
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D254188E773
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF01F63F3;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs3QyMc5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C221F37C0
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=KVAp1/h7s1fPiJu+ZbukluvDWS7uo/sf2cZ8PiBxRDaUNvZBGQeucmcQfqCS9dnf7TVthnRul8/FCLyu9rUvy7HH7pWmMPdiWCCOmfY+yqepxNx8ghpLviS6u9kle+vQiCmeHQVeVsVkSPMraTzl9tDcHyWNJHVqtDn5lrZ0qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=LF4r3TUhIiriC7pizuih5YUw2GtDAp3JKFgO9JsM6Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSqz/6pyMDRNCyuxGX92gVGeXHE8+J7M6NiHn+SOpSzLHrw0YggfGetjpRUbPaCrZhGVUzyFHD7lyT9VSZlSQbFDKKPXFU6k2cQvbbBwGuMYDh3rVOwTR/Bwr5BSIXJgFXMt7vJPTN+sM/V8+42lPIK7lR66ODGhHMhLN5Ucu0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs3QyMc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0654C4CEDD;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792252;
	bh=LF4r3TUhIiriC7pizuih5YUw2GtDAp3JKFgO9JsM6Ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gs3QyMc5O2d5gXohiggIW11D7awtsGpztSTLcUwafuzI1CMYUtNu3B9LTxF4/AWc1
	 Q67KMncV1Idgsbx+aiTpu0sDBJ7IauvuURbxahFdytVq2RmpxE+nwKz9vc5rTinDk2
	 RVAUNuvRKi8+ZeRcNEDjKUgLEISoyIVON4ItH7g4NqF2S5vECiBNIRbZdARLo0x5uf
	 uxDapMRWidcSExABIRO0Go5Eg0FANGc5FjCsk9WqNI1Dlh+DOLZzKz0YwJwjmznyvQ
	 P6mcgUhG35dd+Uj5pdVSFDi7zErtMvkbG7p7WfvZUpfFIgyqRG4CTTcVTTdFuqkjjR
	 /m4oW3/ikJaug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF118E77184;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 21 Dec 2024 15:43:37 +0100
Subject: [PATCH net-next v4 2/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-tn9510-v3a-v4-2-dafff89ba7a7@gmx.net>
References: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
In-Reply-To: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=900;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=c/rtS15NOP1nIPEz2Hiw4s/bc+vAt2cXoIC/6Lv6wJs=;
 b=WuXo++RpbnJdES65vArDwkqS9tiCNyaYynmE27iyvjev4QWUTvzJxC10y7cmFeaadsAanlTWt
 6tvltZQpK2aBbeD/0cY/pMOio0qC+zVqAWBcPtTfW0Qcg5c4BevEQAY
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Re-use the AQR107 probe function to load the firmware on the AQR105 (and
to probe the HWMON).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/aquantia/aquantia_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index bb56a66d2a48fab35eac87f75ad030a3ca6d9ec0..81eeee29ba3e6fb11a476a5b51a8a8be061ca8c3 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -912,6 +912,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR105),
 	.name		= "Aquantia AQR105",
 	.config_aneg    = aqr_config_aneg,
+	.probe		= aqr107_probe,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
 	.read_status	= aqr_read_status,

-- 
2.45.2



