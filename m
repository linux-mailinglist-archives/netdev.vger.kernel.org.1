Return-Path: <netdev+bounces-51263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11837F9DD8
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3991C20D2A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553418C2D;
	Mon, 27 Nov 2023 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="y5FSJzHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D04E1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50baa1ca01cso2338758e87.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081696; x=1701686496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVSAHbxZoohnOH7jImii/DY4owc5b3zp1Hwe6YQy5wU=;
        b=y5FSJzHksCLkhTeR1wb6xnBEsXuTttvnk3Gj3TnEo+Jimgymwoinr8YvYDEixbFHok
         mtjDX1aum1F5NULvOVTnJvuDlDoXuhWUYvlwjSQeOksHzL+l/fXX0ialZaqgc+RE4XCD
         OQhvVPacTfKF4sFgpHr6Ct+kvnulc58WqhWhNku13yFNO/ru16wRITEc5RM7QlK7pVJv
         Dgw7HP7Dhili2GaA4KOeMIBnqb64Nv3unhmG4F7Dy+97R3R05puXxLhculxUiQ2ueZC6
         fo1o1p9tMCLIsbMh8czU5sWTpXDNDUeI9dXaG0EG9/a0cr6jiJudG+4qIVBjlB7Qjver
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081696; x=1701686496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVSAHbxZoohnOH7jImii/DY4owc5b3zp1Hwe6YQy5wU=;
        b=V8yLLEaTOlpgopQ2bBdDTkaSOR75mhybwisEAqUt7Q3/3Ktt93w+am+1udaGIe4BTF
         oekMvqP07r4CMJxR9tO4vOiGFr3HSSHPEWRspgFfeSi9tA2ASigoOMInFHzRD7B+vzyl
         wlxKYB42YFOo8jxS4RePJNivykAxy6TAnjShmXq9FaqhYIODr6Grg2mZr0mm1D1wSSwM
         2aNiEfPMjLWJRiDUHvLszrO0JzKfYHqvopiehzWPTiG1SlNU6eS8sj2Z6VQ5KbtSD4eT
         xJ6+QJFkrugdslh2ANQnhCGKEgbh1H2R2Q+5Ba8YudyMW1Iym8fn6Lqn3Li1xaIX2VBZ
         ql5g==
X-Gm-Message-State: AOJu0YwzXm0M3qK4QqRq4mZmeClMWZRY5W5wGTTWJ9K/R4gdcRz9o4+D
	wiA5dVWcOhOZ1vN429yQm9yy+Q==
X-Google-Smtp-Source: AGHT+IFX7bNX12KRNlnqIDKFrEARfjiZuo+r+3ozDbjLMUk02p73hgrg4SGWJZUpk3cWJXj78xYChw==
X-Received: by 2002:a05:6512:1105:b0:50b:a69d:b8bb with SMTP id l5-20020a056512110500b0050ba69db8bbmr5175114lfg.49.1701081696442;
        Mon, 27 Nov 2023 02:41:36 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:35 -0800 (PST)
From: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Date: Mon, 27 Nov 2023 11:40:45 +0100
Message-ID: <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

This commit conditionally sets the collision detection bit on lan867x
and lan865x phys on changing PLCA enabled on/off. The intended realworld
scenario is that all nodes on the network run the same settings with
regards to plca, and when plca is enabled the physical layer guarantees
that no collisions should occur.
In a practical setting where it was tested running one node with
collision detection on and other off, the node with collision detection
on dropped a lot of packets, leading to a poor performing link.
Worth noting here is that the phys default/reset to plca disabled and
collision detection enabled. Thus this change would only have an effect
when changing settings via ethtool.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index db84d850b165..3b1e82ecdf69 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -23,8 +23,10 @@
 #define LAN865X_REG_CFGPARAM_DATA 0x00D9
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
+#define LAN86XX_REG_COLLISION_DETECT 0x0087
 
 #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
+#define LAN86XX_COLLISION_DETECT_ENABLE BIT(15)
 
 /* The arrays below are pulled from the following table from AN1699
  * Access MMD Address Value Mask
@@ -363,6 +365,27 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan86xx_plca_set_cfg(struct phy_device *phydev,
+				const struct phy_plca_cfg *plca_cfg)
+{
+	int err;
+
+	err = genphy_c45_plca_set_cfg(phydev, plca_cfg);
+	if (err)
+		return err;
+
+	/* Disable collision detect on the phy when PLCA is enabled.
+	 * Noise can be picked up as a false positive for collisions
+	 * leading to the phy dropping legitimate packets.
+	 * No collisions should be possible when all nodes are setup
+	 * for running PLCA.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			LAN86XX_REG_COLLISION_DETECT,
+			LAN86XX_COLLISION_DETECT_ENABLE,
+			plca_cfg->enabled ? 0 : LAN86XX_COLLISION_DETECT_ENABLE);
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -371,7 +394,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revb1_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -381,7 +404,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc1_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -391,7 +414,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 };
-- 
2.40.1


