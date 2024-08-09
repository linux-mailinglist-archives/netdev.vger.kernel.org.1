Return-Path: <netdev+bounces-117287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C794D779
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3306280C92
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6416D4F7;
	Fri,  9 Aug 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+4X1BZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA643160883;
	Fri,  9 Aug 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232314; cv=none; b=EOLs8l5yR7eaJTwINSbLy16x2JV3FFV8HukhHRVN59fcm1H22RBc927U9c9QIyeLvMQPoj/F65tn8IdRgP1jMYqQsSYdmDZfmqwzBsJ6vKqwCAW4jc6FdR6beCUfCPYtEruVZZ44w5ji82slDzJ8iFDGHL3Xw8zzVwHgFZs6TnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232314; c=relaxed/simple;
	bh=MUIgI0Og4nEqKaqgSG8ih/xROp2NjP1rKYFpIp8+vC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKP6F+01MbzcnkMM95Cl2Jhb4Z/PzHgVFMOvLW8s/t/Qo8q7c7XURmChH4b5E/Rz/Ku/IzO4Xl61g45IJZgYaLBpHpKrYMTtRuBSAhm0kK33+Z0JGCfvKwhft5eUN6d/8ziBNLu7qkL7egBAAZcDou1pI0GHYH0CVJPBad1hU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+4X1BZj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f149845d81so27353331fa.0;
        Fri, 09 Aug 2024 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232310; x=1723837110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToeSXl+vM3WNVB6qyUTcA+LVhXh+7FU6kYmOVQ0FknE=;
        b=W+4X1BZjRD5N40dHcTk6OtWfk4gUM/2Cf0aaMuc23YsX5alPo071xWUP87PB9dhBvF
         gSlMIqzo1mtwasMtM9qOlMNLasgcobQnqpB+QHKR9/qOsKKBmF1qIQaNxxTvGT+wIRfn
         P7AdkwlY/w8LAQW9VwZyVuEe7A2DNSGKBwt3Fcv/E+eUwH/E1geh8/PPfcmqPS3g8ov2
         nz0LtNmBCW83HJLWRO7vU49N+Pl4tlcq2ujJplaxtfQz/FkvmAbve4QKcYFYpA8VXOeI
         y6k9maFJ/ov/z/PmGs2Ec/1XYwvNCIL1kbtIrigPnBtEanQ55MQO5nqWGHoxJ/Igu/k0
         8lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232310; x=1723837110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToeSXl+vM3WNVB6qyUTcA+LVhXh+7FU6kYmOVQ0FknE=;
        b=IMLybKEKM82VWcab4i+7QRK8gGLk5iprXCxZOAV3v5XII6YucBARLChr6yRUAoErq+
         TGlBsFO32B+Dlm0VJGa/EEavBHTZwELaWGei4jAl8mxnCcHh99XdcQ8Nz3eVtWx3vYar
         ZdhFoI7bl9/X8VGZjSuAn2fyvi5JB48Twy/4HPxDVnOIyTGVoUOe3mHLt4BVoCL/gwEc
         sn7+ER/R+yo7sffsuUrBk+35qCgD6F/e/F+wXvxXVPSmvXV9mZoXcYuJWwO3cvy3Ziuf
         xXYGJZuhuKWwfOGTSahCLew7H3ruGqDrBhIPW5FQl8teRI4ZkV9TXofJyg8J8qoL8YL2
         dWeg==
X-Forwarded-Encrypted: i=1; AJvYcCUiVit/gbege71V7BDVMv40QsTBwkp3NG1PbrFtQXBiYf2q8GLb6D5gBFEVlEwhoASWkeC3dP0ZBsKaB3UeyK0rdEI3pWC/Z38kJ13B
X-Gm-Message-State: AOJu0Yxf2xU4zx4thP3sCOv2Z9u3kQl+lLG7B5tyy84myQHVxPPp06/4
	/afELqMkp7UdurzmJlUITIrYZWPBQdPd2O9UZaL6X0m/UV9Tew/DYnMpMrpm
X-Google-Smtp-Source: AGHT+IFoUoqtHP3+J0aLZSfxAPkik547Kb93xmKUBljA7YDmwMP6PtBGU17Q0i0IW3CqK+UCuHDisQ==
X-Received: by 2002:a2e:f1a:0:b0:2ef:2c87:3bd7 with SMTP id 38308e7fff4ca-2f1a6ce6ea0mr17738631fa.37.1723232310129;
        Fri, 09 Aug 2024 12:38:30 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:29 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 5/5] net: phy: vitesse: repair vsc73xx autonegotiation
Date: Fri,  9 Aug 2024 21:38:06 +0200
Message-Id: <20240809193807.2221897-6-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809193807.2221897-1-paweldembicki@gmail.com>
References: <20240809193807.2221897-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the vsc73xx mdio bus work properly, the generic autonegotiation
configuration works well.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v3:
  - removed MDI-X with disabled autoneg feature (it will goes to
    net-next in future)
v2:
  - resend only

This patch came from net-next series[0].
Changes since net-next:
  - rebased to netdev/main only

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/phy/vitesse.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 897b979ec03c..3b5fcaf0dd36 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -237,16 +237,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int vsc73xx_config_aneg(struct phy_device *phydev)
-{
-	/* The VSC73xx switches does not like to be instructed to
-	 * do autonegotiation in any way, it prefers that you just go
-	 * with the power-on/reset defaults. Writing some registers will
-	 * just make autonegotiation permanently fail.
-	 */
-	return 0;
-}
-
 /* This adds a skew for both TX and RX clocks, so the skew should only be
  * applied to "rgmii-id" interfaces. It may not work as expected
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces.
@@ -444,7 +434,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -453,7 +442,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -462,7 +450,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -471,7 +458,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
-- 
2.34.1


