Return-Path: <netdev+bounces-175911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E6A67F49
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CFD3B70D2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD5C206F2E;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpcvd1MB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F472066F6;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335638; cv=none; b=N1U1SaiEBOnb83EKi89gPEyDkLVDsS0RXv7P7hei3aMwtLUFSR6K30+g7rCMH+ST4x3tu8D5U2VzEuKJb2NHhteLEXE56o67lj5903sSvqlPL0KxrF0iFzxOB0+6q+iP9lokz2gpvwTOqnXV0/yTqoeyAPnVHJ9Pi+KMu3TGwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335638; c=relaxed/simple;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FezV9qd5o5wlnMYGDeENISpvLLjmxU3JwekYx3LtrJTjHZ0+skxvrrqY1iXBQHQFjpMVjaCUqfHU2dpyWju7b8gQgG7K+UzjPvr9aeNV/nrNw63WNf4Mnphc3/CaVt3ADkZF6Rh8vi+hlxG8MUC53cP6E4zpXFH+JvyY9ZM354E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpcvd1MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55C0AC4CEF3;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335638;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mpcvd1MBrrRREIdkVUa4WzT2SuDi0YmnCQYifhwvQysF909Ee0gPWRqExURJfB3Vd
	 xSOsBzRHMRHG0jxK8BYuh4Z4vUZyS/qGY25WkvSsY1fc7oQyB73A9cfkDIe23gS7G1
	 NV0Fb+rygcphFa1lokkY0ZETbi2499I0Dlx4ih+gBm80mjaLED1Fjs4FlSxSwKlM29
	 G5qgu409vuBghB6LM0UhE5fqDpBayuVBgYOygEdI/gRwD2/T29S9Dc6ovs7OuJUsqB
	 TxWol8aFn7EKVF+4JuQyEmZ4Hs7I7mKB4Un2wrpy8y4wwCK3YaFinPm/3Yupu12j0c
	 f/jBgEzYhZLWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F59C282EC;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 18 Mar 2025 23:06:54 +0100
Subject: [PATCH net-next v6 3/7] net: phy: aquantia: search for
 firmware-name in fwnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-tn9510-v3a-v6-3-808a9089d24b@gmx.net>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
In-Reply-To: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742335636; l=1169;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=0zRi7Vk41IU72s/8DzrXAvCvexTz79in+5DW1aumMeg=;
 b=wljGj2lw59kqmSW492zIjI0eH+/ZzkqBoEAr3NxRMQVviKUuuXPSKoqzlIXhsJrqbPOzpT1Pb
 OsnPbeNqvnQC7RsbKyu6Qi6Tu36+aX+oV9cSuZDHYtIjPJnzAsFuK14
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
2.47.2



