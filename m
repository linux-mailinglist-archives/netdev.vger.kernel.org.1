Return-Path: <netdev+bounces-152712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFAC9F586B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37622164452
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE761FA8E1;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="razbLG2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDF1FA149
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=Tw7Xo8cXsV4Jhum3aj/yILFR/vDqc057LYq5IqcMMTAgja/WJYy9bvQmR2feBWQ95ZUXGsEJBwGg518CgwOzEIpfl/vv4116cp2yNhKvLDUbgk8764gStSsloY9C29AI6be7YVk56JjKUf8S0t9i9VslunbMPh5bXLe4GVNlqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=rRM9rqY105gwQ9Trpekhtf0qrz7Ez72hvagUjR58WZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ag7XWneknV+7oh87v2l/lYZyhhMiiSfb/hxvuhEiWFdYQTsVta1Olq7bFCe8maaKjvUpt1kdTbfffUFQ8mp7swG0fC0YsygJPbtk/5hLdmzBcKeJo4JCBbPEhSiVijeknaTInVi3Az+60g0YIb3Ms8ZzYc4rSDhADvQ0TXFaFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=razbLG2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96C6C4CEE0;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469659;
	bh=rRM9rqY105gwQ9Trpekhtf0qrz7Ez72hvagUjR58WZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=razbLG2oqTILUSxuBdWNC4DFSB47QFpzq2ZqGD8dGgpaEvQX5vprkuGQzpUzaAL3y
	 gAH7bHho96FmBlRyMCVE1tVv0BS1UFOLghtaPQew0hmi5Xrz7VMp+snG8RrmF1TPi5
	 UH2XpNUi+xBPiHDI8MtgrND8zZ2tuEfZsLEgd3AmFWtK7jdn36fRzUg2CJ+rjFuve0
	 ZIm8zL0vYQpE7emEI2B0+bsV/c8E2+8+HfkCRWnkeCULZS2IbTZt/Dn0xfQltVrWB8
	 IkCBoBzoDU2J4uLC+sRrUi1eeaYRB9SqIN94iLRG/+4ThKkrhAgAqtpxzloLuA406+
	 e1mti0L/kwgQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF750E77184;
	Tue, 17 Dec 2024 21:07:38 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:34 +0100
Subject: [PATCH net-next v3 3/7] net: phy: aquantia: search for
 firmware-name in fwnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-3-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=1126;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=sG/QOhA4xYOILxJWUzC7JzkduHQAxfV+9Kfu79XgLf8=;
 b=RAEsfviHllTrrSMjRCk4d8V2+3Uj6IZ7twUyHWixDd9gJbuvAwYf5MYPGXL/M46f2efq/mZfl
 oayOmiOF7RwA1NqnaSst6+0n6DskvNPUkY92Cs9hbZUOI4HGYUiHJ0i
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Allow the firmware name of an Aquantia PHY alternatively be provided by the
property "firmware-name" of a swnode. This software node may be provided by
the MAC or MDIO driver.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index dab3af80593f51ff6dc670dfb54ae358c2458c40..bbbcc9736b00e1cfa193f4398889a4c172ca27a4 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -328,10 +328,11 @@ static int aqr_firmware_load_fs(struct phy_device *phydev)
 	const char *fw_name;
 	int ret;
 
-	ret = of_property_read_string(dev->of_node, "firmware-name",
-				      &fw_name);
-	if (ret)
+	ret = device_property_read_string(dev, "firmware-name", &fw_name);
+	if (ret) {
+		phydev_err(phydev, "failed to read firmware-name: %d\n", ret);
 		return ret;
+	}
 
 	ret = request_firmware(&fw, fw_name, dev);
 	if (ret) {

-- 
2.45.2



