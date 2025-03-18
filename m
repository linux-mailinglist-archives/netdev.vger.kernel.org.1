Return-Path: <netdev+bounces-175909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F8A67F45
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400F74223EE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02A206F17;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFPNxIDq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C92066EE;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335638; cv=none; b=FPUw0ZKPA/fqrDP3IIzUUwfKNfZky66raft+s8lH/AYZhxG76cWS5z+dH8A/EMwx1rQ+f0eB+xZlINbXxq8wHX+2T9m+DanGI/kLhqi1Vrj3AZqpvLAIF0Ks3RQWpZWuGRlZUyJ8vq7sOspiy4yiTBH8+RovuZEVokSvDavGSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335638; c=relaxed/simple;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2Of4Z9EBcNeciekckvJy7GclwZgF6oc7Giwc9b8MbJY1v4UppkPqSweXNYPFMCl6zdtyEJjg3HHgL40nlHe8bD7Ozbc0GxkQsXdTXDq8ikGPHoKoC++9gFdIPCxA/AYvDyCUmkvcQ573Me0OeigJJwfST2tF96P5LzM6qv0ZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFPNxIDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D1C1C4CEEE;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335638;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qFPNxIDqHWrOotzEkBskJSYskV3ahW/vogwMALoclJhArgl/xqVFO/p7vQn8t/K77
	 zPVmN+xVRCYP2cXDTumuCs/JJtjpP3ynnyrhysmCN9pWiBoqChWyOPqeBHkWfOuFI0
	 a33DEIvymKEHgc3KM/XnC/Piy6JA9lP+tAVwrmndndFKYyJEM4kEil2vXUoUf1Zo/e
	 tQf8lRT1ymc8KhUNvPjwueX0lQn+EU/dvIhp6z039gU1rKkPRUHKapmec95s9t9krb
	 hJlFcw1iLiqb28rG0lDajNHACh1wD1aQ8a4S0mvbzCDC66LnW+ggRgvnabWrk6Mzqg
	 WBHFVbzPtR9aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30611C35FF3;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 18 Mar 2025 23:06:53 +0100
Subject: [PATCH net-next v6 2/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-tn9510-v3a-v6-2-808a9089d24b@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742335636; l=900;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=vEeavGZyiKSDFemLfNRy5gMMBOs/2nb7oTqi4HS4XIQ=;
 b=oyS43WSmFx+ES8/DCIG31nGgeWDUQTwWPqExHYDP2jF5t8uGejyNcJrapyPFocBk6keS7d/XW
 nryh0EyZZzwAIAVPoK51rUwaYAimf3quiDzgS6eYCKungHUWiTmNpdA
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
index e42ace4e682aacf56199b7fdb9613d20f240fa27..86b0e63de5d88fa1050919a8826bdbec4bbcf8ba 100644
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
2.47.2



