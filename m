Return-Path: <netdev+bounces-168747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7FA40723
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9530642229E
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A120A5C2;
	Sat, 22 Feb 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSFtABSA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD7207DE2;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=A3rAKMRGPY3+uyyiYG0Mq0oFqHN1ESv2RIeArbfvmsjiELO7+zt58Y0RHu5AIn6uKKQ5Kts596M+nM2jpkYyphlZU668iZtmqPN+sYb3o27ZEyojMOX53YCUFv/pa8WTyJ6866ti5lhUmmW8pd1xkxR592ykDfMfv6rwV0NGHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=UUrKsZhL5vFpLPiJahoOw4BGomfwKD+WZtupeV3XsXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oV+AkV5vkMiuBp3MxM+/emG5eHhEshixyWq4Xtq8w8Vba1gpyf4na0XUtFT6nSr6GL06XwGRyFAJrEkL6jDNkGx40WOyGtFd3H6FKlA1vCbQe0IEroI8s5P7ziaweXRYGVUcYb0yL9wyCnSafOlCsM0/CdU9RU/n/FaMI03lQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSFtABSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47461C4CEF0;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217802;
	bh=UUrKsZhL5vFpLPiJahoOw4BGomfwKD+WZtupeV3XsXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NSFtABSACY37IFU/bMWi4MP/BLYGhl3A5b5m7Wn6ETpJ5IREUJF60+wpCZt+J+LVW
	 owrNv5Mfq3pWD3S4yAnAohuBiMav+RzJJ0c8e2a/JJC9HLo5n8w6QebDvUL6aLsbaP
	 tlhvzk9tLV9iNDvoRdhhL4YYpgMUljIXYcyuDbsg7YpA2r75zPGZwnYWhZaYu0a//J
	 xN5yBu1S44uGPZKbSFavO7A+p+sthpFpGcu6NgS0IRt4JDju/KXbbR7rMYxdSw1EtI
	 p3euivgPNfmMV1Ul9yvFs9zpdU1ZOstMLsLxe6RSFHRhV58FYgV6ezyCWD5Ml5HUtq
	 hrgqpjFff/48g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA5C021B5;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Feb 2025 10:49:33 +0100
Subject: [PATCH net-next v5 6/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-tn9510-v3a-v5-6-99365047e309@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
In-Reply-To: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=1511;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=xOtJekI9s5IMvhzbCahEFjKDIz6Ma1CAyDfHNfBa2ww=;
 b=bGYiCcyxBeJj34gDRuTXXFoFjXIsd8mCYQ+2mPVrGxyVvF42Iv1R3VrRySBesSklPKKiEHtgD
 I/TmPtVaqfZCq5FobtbbD3M/Cij9zjPVH4QmRypbpWLFdv8xmNCEtMk
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
index 173551ace1941bf825c9b3d1acd16be24b35eb84..f08e6d5cf2bb0091e209214ef6aca186503c48de 100644
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
2.47.2



