Return-Path: <netdev+bounces-176861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7E5A6C9C4
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DF1B65DC7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFD1FBC97;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2ha+JQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F01F1513;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=Mw8124rkdLIejuzI9gG2nferWId7SrOtx6FV+O966mXNLOqzTDsFTm8/O6OH0hHuLexvabZ/Bh+qsXokfVayksqUlVg5PDmm/67rvRCwWj30F4nRkNXc8ck4N34beuYh9KjZTUwJacjGBP6XvAg6REAcFm9EnJSxcE/JGWLwptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6T40J7rl92IEm7xt0PtrcExy8GwJfHXxNYKmkqgW8t2H9NiTXgAD2JiPJuaP5Z1QklErTfjxCJzJm9nO3Pq3PL6tR/vMejQVzfAp2D17Bfv/6zU8YBarByIYZY+cCQVlJDJNsy6tKFgT+D1+Kf/Bt/qXWk8CLX0uSyf4SkHWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2ha+JQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9795EC4CEEE;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=uVlmDwv5wWEDBvC4S2R9sJZkHok3EH5U4Ugh6RJb8xM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I2ha+JQYe3dzev/q9ktnGVInz4y9JyTH+DDURH4ztWnOf75AO0/poddtzNt/el8Aj
	 Sbah066bbnzQqWzhVtqntqgfBSC+fNmBKSUToiEsimmR8ah8Peil9EYctbyLcZJmqp
	 ZN3EJ5Pf8yJBtEyKbtf0dDtUIxbbFhQdOgIRbrSew1PaS2+oY+Peeo3S9Uuk9MCCjj
	 hr8TG8QF973JLYyHekhHRuyqCR5+YxUHc90qOp63DJ7FyKc9HTDXOtniC/8MNF8GJy
	 2Cwv/qsvLsaoDigrITmv/rde0UN+hUWa605XUIfnmFpYD1vcKCG3Hlp6ukzzP3ZcEk
	 s9ZSxZyAhY5/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906BEC35FFC;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Mar 2025 11:45:54 +0100
Subject: [PATCH net-next v7 3/7] net: phy: aquantia: search for
 firmware-name in fwnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-tn9510-v3a-v7-3-672a9a3d8628@gmx.net>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
In-Reply-To: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=1169;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=0zRi7Vk41IU72s/8DzrXAvCvexTz79in+5DW1aumMeg=;
 b=sSuPYpE50VbUFZaI7BYuD57IHP6bJEcMIOy+tTBQ2MO78IvnFAjXubb9ejGSMd4ugpSBtfY5A
 3OSA+wRq3s9DnQhxtHyRfXD8sWBdAxpFVEkR4y8pSEAnevNh/vCQfnU
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



