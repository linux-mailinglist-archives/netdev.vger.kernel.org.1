Return-Path: <netdev+bounces-176859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A88A6C9C0
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C024E7A7D58
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC01F9AB1;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN+FPRGv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BC1E98EC;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=ao5f+D5BfmY8ikXcMm6HB0hhsP6Jn/FwAVMQQnbDn+GZ/qKW4f9dgwauWDLNAdTGeObNsnTODhaPJGdZVSA2IPx8Uq9nkac0LWMOYoNLtg17stgb/viHFz5Gy5tpEWr1AFwm5P3VjsoSWNRk8497OtgLGRfFprWR5M/9Ay5emsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luoqY3xxGl+K26q6c3t1OP5OtDkor7oJimSbFlSyyBhXrGW915t5DeAcjkx8QNAV9VlmC86M5BOCOm6UvBqRoRURIfUIr6G1KCV8xkvV3WGE/eB3vuq76CIoxdsMjsI4EXjBQTJ8qp+OXUjGjtcaRFzMoacw7bNCfy/vgPB6KJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN+FPRGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D8A9C4CEED;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=YMuS4jq16SQY005HovXWqkuXwTsXCArwDObAf38rCgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qN+FPRGvQ7jrD4mY8K9/+cs0SmExkL6nMTsNey0vo8ttPRIr0UXe4ZSPAsNisqIJF
	 ASAch7CpEVr3/Rqn7EmOa4FOSOExQxMW6tbvrZMDKR6Ut98p0LwEiNgiBJw+tkkg6n
	 So8ZmSBVLPw/mqOnIO3XFzQOVn33W4dafVkOnRbds5m1S1WjGdUE0zv83pfWcXDhUW
	 9BqbUknTVz3vt9ab6ToZ46WZ5HEbHX8anYBUHeDG63Zl6l8rNwp5FMxefMFciRC41t
	 +LeetMDV7DjsIN6paHbwVMLkUWR/GGnH87wmSQCgueTsIWicONW7eqUsJ+bIwmFImn
	 QASVbZiGTxXuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE5C3600A;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Mar 2025 11:45:53 +0100
Subject: [PATCH net-next v7 2/7] net: phy: aquantia: add probe function to
 aqr105 for firmware loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-tn9510-v3a-v7-2-672a9a3d8628@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=900;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=vEeavGZyiKSDFemLfNRy5gMMBOs/2nb7oTqi4HS4XIQ=;
 b=NrBz3etyWZ8DkFcMAlVhUSvqUGbeYUtAKAjnx9by5Hve6YA0Nt0I9itwtk9xMmfGuewQHOJjm
 A76ERMrz8R0Ae5cIcH7RWbuQHAlYZNA0+qjTCmvjrKyk1Om6WkrCBmZ
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



