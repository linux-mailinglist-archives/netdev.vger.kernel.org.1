Return-Path: <netdev+bounces-153923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5BB9FA10D
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F2188F3A0
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21721FCCE7;
	Sat, 21 Dec 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9HQdibO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E551F8928
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=gnr43H1l7UujK4RvRzPte6+jtPIPC6bFDL215sQOsnMN0dH5Fyu3Rc3/J4JivGmYHe9dn4sodhtE23mQCzJx9a4wAD0CWFynwMApp/sPR6Lts7RSHHCr+3Jc1VLTgpNelxUw3FHWwHMgk3PjZTVfv1wPkOBKQm9pEWp0dymILzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=epKzIsy01ss7mJddFLIQkvPHCqFqexBBVNzoeUmEbM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhLHikJR7/XTlgT1I9B1ctpDHHHck/Ux0V3/QQeNtog8KXH3hFMp0Kzg7sQSFsB3UgTvP7UyGKqcf6qNktb+WmnsDPv1sMgkhzRrLMvnG7sf+ErmjqEamwn0VNN0i3YnMw48kTDSjox4SynxKQpK3RITx1aiJ2oPcPt+YH6yEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9HQdibO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 003E9C4CEE4;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792253;
	bh=epKzIsy01ss7mJddFLIQkvPHCqFqexBBVNzoeUmEbM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H9HQdibOLLdMtvWRO8/xmvpY8jhr01UERigbM9KB934VAmckgsLwglSjBTmzU7sAA
	 fnKQUC3jLIef74MZtC/Ilz4moMiAlwzCVbsx2dQKRZZEOsNd4MhdQ3yhdimCEoOA+q
	 CKudGKCbGJIdIpw8yfxpRNM1sH/kLgdEg9e8N1b2Zbx8mHEySCXRMv/ccjOIuWwFkt
	 vDo36rgAYRsEXq03lDgOiCpK+7tA07NAHmy+AJowH0F3pqPTaLdslGxM8Z7lk0h38n
	 mDChqcj8UDXZrXaVYROLjLW/ol2n02b1PTM7RZ4qmmCmVI33K+11YVQzlAaXL79CJ7
	 pg3REEmETijkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB4E7718D;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 21 Dec 2024 15:43:41 +0100
Subject: [PATCH net-next v4 6/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-tn9510-v3a-v4-6-dafff89ba7a7@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=1511;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=6apzNuE5PcS/8NGOzJUIpqEBfEQylvzI6hEkJbjkA0g=;
 b=R2ADHASermc9YTrB58g3h66Ze5sw3Ow0RiP24AqtEp5O4L6Yh3dVn5LaYlRz5VnrXhpTblPC4
 OGYLlaOF07IC3buUrpF2obEy0NnLPF2a5xhdnWPtZ/dq7AyJORBBG1A
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
3 is unclear, but may have something to do with the length of the preamble
in the MDIO communication. If bit 3 is not set, the PHY will not be found
when performing a scan for PHYs. Use the available tn40_mdio_set_speed
function which includes setting bit 3. Just move the function to before the
devm_mdio_register function, which scans the mdio bus for PHYs.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index 3607ffcb2ee54e70009fdde0d59d27a9b8a88b6a..1db71cdbd09c140eeb281cfd6ae6429c72f70055 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -199,13 +199,13 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 		}
 	}
 
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
 		goto err_swnodes_cleanup;
 	}
-	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	return 0;
 
 err_swnodes_cleanup:

-- 
2.45.2



