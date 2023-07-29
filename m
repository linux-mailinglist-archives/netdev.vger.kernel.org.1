Return-Path: <netdev+bounces-22536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D14767EEE
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30BC281C99
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE716432;
	Sat, 29 Jul 2023 11:55:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E1168AA
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:55:24 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B13C00;
	Sat, 29 Jul 2023 04:55:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31771bb4869so3098639f8f.0;
        Sat, 29 Jul 2023 04:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690631719; x=1691236519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfBFXLrOBDfsMdVxv/cKnvMiArytdOBrw7zZET7q5qM=;
        b=IrbJYMmu02I6mT+quaOTXQEimBZCPtAQIJ1LcwiJAdsCdftuE3RjQsL/s3RUq22oz+
         JU/7dBwSfB+upNbRnQipOzGDrTDmfJJSLiOXbXxJU1an54IYtsVF5TF3KPz8AfiBWnuB
         C0BXttuLXqcCOmZ+AngNEKm6TQPP//OkY760EAWQVngvO06iQMMD0gUtTdiEpgpPERB9
         jOyxURNnYEqzORUBhvWkQEx4ZDPfvgdPAC198TVcySh8M90bVqL6PUP3CVjRZ3obozh/
         0Xh6RqxpD4mdTLLunQipOgqvynyFCfp9jMXID5MGdLyRvc0n837XMBd0luosGS0DRcs7
         H8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690631719; x=1691236519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfBFXLrOBDfsMdVxv/cKnvMiArytdOBrw7zZET7q5qM=;
        b=LK/QOr9WxfqhWsep79kL9BCB8I0GBQywWMdIkBQb+00SRaFIz4b9SznbusHqjq/81h
         b0X243TrItEiy/LgCDY1O0s0DSYBnYTsQSEVK4W7n0NlvXA7Ls3B9or4RoVu3dlr/URG
         w63WsQLcdvbtVZV7x1FI/U9mgHBJtiZ0Yg0CzU7Q2XcHbMk6BWVq8Y/AJl5Bl9+nVyKu
         8P76t5Axrs0S/YNx1zhNsNZH5erxsveczKovcdFJK96vxhNs9G1ReCikTXLCvpLcZkFL
         VhzNfotGKlM6kxqAMIcIUfda8MI/MeSMxXyOMuWBwWOEJt7yjEXy5SjMghYNxN6eHWJ+
         mDPQ==
X-Gm-Message-State: ABy/qLamWkhQ/ek9iC57I5MgZMgULZigiYDq/X37+dcA5V2HkxWtvMpt
	xFfAsc42dkT50LpWk5ydKtM=
X-Google-Smtp-Source: APBJJlH2vXn3qDgO7L+Z6G8fK+drDnG8bvhmhIhGUk3nGydGT8gtwfiIIHZVwtj/ZosJkAR/x01w7Q==
X-Received: by 2002:a5d:40ce:0:b0:314:1313:c3d6 with SMTP id b14-20020a5d40ce000000b003141313c3d6mr1807231wrq.33.1690631719386;
        Sat, 29 Jul 2023 04:55:19 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm7295289wrv.71.2023.07.29.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 04:55:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Atin Bainada <hi@atinb.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 4/5] net: dsa: qca8k: move qca8xxx hol fixup to separate function
Date: Sat, 29 Jul 2023 13:55:08 +0200
Message-Id: <20230729115509.32601-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230729115509.32601-1-ansuelsmth@gmail.com>
References: <20230729115509.32601-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move qca8xxx hol fixup to separate function to tidy things up and to
permit using a more efficent loop in future patch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 78 +++++++++++++++++---------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 6286a64a2fe3..81c6fab0a01b 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1756,6 +1756,46 @@ static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
 	return 0;
 }
 
+static void qca8k_setup_hol_fixup(struct qca8k_priv *priv, int port)
+{
+	u32 mask;
+
+	switch (port) {
+	/* The 2 CPU port and port 5 requires some different
+	 * priority than any other ports.
+	 */
+	case 0:
+	case 5:
+	case 6:
+		mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI4(0x6) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI5(0x8) |
+			QCA8K_PORT_HOL_CTRL0_EG_PORT(0x1e);
+		break;
+	default:
+		mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x6) |
+			QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x8) |
+			QCA8K_PORT_HOL_CTRL0_EG_PORT(0x19);
+	}
+	regmap_write(priv->regmap, QCA8K_REG_PORT_HOL_CTRL0(port), mask);
+
+	mask = QCA8K_PORT_HOL_CTRL1_ING(0x6) |
+	       QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
+	       QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
+	       QCA8K_PORT_HOL_CTRL1_WRED_EN;
+	regmap_update_bits(priv->regmap, QCA8K_REG_PORT_HOL_CTRL1(port),
+			   QCA8K_PORT_HOL_CTRL1_ING_BUF_MASK |
+			   QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
+			   QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
+			   QCA8K_PORT_HOL_CTRL1_WRED_EN,
+			   mask);
+}
+
 static int
 qca8k_setup(struct dsa_switch *ds)
 {
@@ -1895,42 +1935,8 @@ qca8k_setup(struct dsa_switch *ds)
 		 * missing settings to improve switch stability under load condition.
 		 * This problem is limited to qca8337 and other qca8k switch are not affected.
 		 */
-		if (priv->switch_id == QCA8K_ID_QCA8337) {
-			switch (i) {
-			/* The 2 CPU port and port 5 requires some different
-			 * priority than any other ports.
-			 */
-			case 0:
-			case 5:
-			case 6:
-				mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI4(0x6) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI5(0x8) |
-					QCA8K_PORT_HOL_CTRL0_EG_PORT(0x1e);
-				break;
-			default:
-				mask = QCA8K_PORT_HOL_CTRL0_EG_PRI0(0x3) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI1(0x4) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI2(0x6) |
-					QCA8K_PORT_HOL_CTRL0_EG_PRI3(0x8) |
-					QCA8K_PORT_HOL_CTRL0_EG_PORT(0x19);
-			}
-			qca8k_write(priv, QCA8K_REG_PORT_HOL_CTRL0(i), mask);
-
-			mask = QCA8K_PORT_HOL_CTRL1_ING(0x6) |
-			QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
-			QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
-			QCA8K_PORT_HOL_CTRL1_WRED_EN;
-			qca8k_rmw(priv, QCA8K_REG_PORT_HOL_CTRL1(i),
-				  QCA8K_PORT_HOL_CTRL1_ING_BUF_MASK |
-				  QCA8K_PORT_HOL_CTRL1_EG_PRI_BUF_EN |
-				  QCA8K_PORT_HOL_CTRL1_EG_PORT_BUF_EN |
-				  QCA8K_PORT_HOL_CTRL1_WRED_EN,
-				  mask);
-		}
+		if (priv->switch_id == QCA8K_ID_QCA8337)
+			qca8k_setup_hol_fixup(priv, i);
 	}
 
 	/* Special GLOBAL_FC_THRESH value are needed for ar8327 switch */
-- 
2.40.1


