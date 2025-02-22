Return-Path: <netdev+bounces-168740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2CA4071C
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD47A14AF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86548207A22;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEwhkXR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D857B663;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=ArRR0CMmljt1Sx7AfTeg/OmibaLedr9Vn9DfzIOe3tbhO2uWmg4r5kHcrmiVodmtrNJQZG6IPtQDZr53tC+BKWzS1yLI6y8mFvAWPM0gitYzNzh2AwwXGqXSeGScC+F8TUKTG2XXYOKdY83sZADqEf3502G+e+iwECy3/6tKsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMUr45/OlCfVF/KK7CvCyZolhEYDGG61d84gOPG+vtnPisJemLbCIeItjX3w/nYgH/kuy5QCH//ovVIEZVEEQ7itAvw3YRE2yLXQmm0heY61DnqoT+FgIdFCKG571whmn75zqh3FFYHEOFGt78xVBbCKXTCPx+0JMQD00GvpR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEwhkXR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEFBBC4CEE2;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217802;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FEwhkXR9LUR/bop/0d4N29ntW4WlbEk0X5MkeUJC10zXs2RpZrdYb8IvUaYH3V5wZ
	 DHCU9/Gi/yLRVmqsV7g62W21sNFGCXGGu8uuOSRlWymc1+orXz09vjUsSX0O75MIJN
	 Sv0cp6FU+2NcqHkOfeM/Xa/h0VRC0gIhCKQq/zrAnF14fKHnN95MBDYFxjH7VRV+Zo
	 MwhiYuRdmhXfU8PhBOUoN7OLfZvCioDspcXOAKfyf+SN+cA9vM/CAlvc73wRqc7Elh
	 IbnJJ9J+qUFOgytLSPGdyy76g6QyEGI5fbYgl7v3IqPxWjPI6PCRA75eyj+cY+4i2G
	 ww0OgcWkybb9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E2C021B7;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Feb 2025 10:49:29 +0100
Subject: [PATCH net-next v5 2/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-tn9510-v3a-v5-2-99365047e309@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=900;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=vEeavGZyiKSDFemLfNRy5gMMBOs/2nb7oTqi4HS4XIQ=;
 b=M76uCELxw2oNUw0404E9UpC5aH3+YSASttZAWCbjW2m4nm+jr5+babv/nwMqwhx8BNvvd9QsU
 5DHoScLr+kCCfr+r5wOPDkiBnpVzxdER3TXdEE6/VF8Mdx7MGWOJCMz
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



