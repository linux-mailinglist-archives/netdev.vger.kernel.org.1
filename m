Return-Path: <netdev+bounces-125271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC996C908
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE76B20B70
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8A13B780;
	Wed,  4 Sep 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo+WnXcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21AC62A02;
	Wed,  4 Sep 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483424; cv=none; b=ipqbz+naGvi3WxEFd6JeW6LkmqsFVgYt4e6wLPSdhv2XAlcUtGj4hqgtmhf0Udlx7KCJGztrQV19aUiV9wadcqy+1e68vMARbAIUZbizq8W39t/QjvdlI9qrWrljzmPwTT1DrGWBnE9n97uCNBojgAFkQsSAIPe9FJ0aoVcXaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483424; c=relaxed/simple;
	bh=VupcdStpyc7EtIYDrzaVslr/S3ydzdLj+0xdraUd9hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTyAMzogDDz0hd+CmY2SEJuRFjnKjevNBUxVYDud6woL55O9YXaF/F99Faz79R7DgKXbvpHQHz0krb2HJBWTejofIaZEyL5capGb1/su/rZEV++LVDNJRENSeST3pSEi3OYh9+dWvMDvNiY/87ozgjBaaWbr1McqfUyiUjgVrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo+WnXcf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-715cdc7a153so53885b3a.0;
        Wed, 04 Sep 2024 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725483422; x=1726088222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6eUNo9P+fL7OnZzluk8DnXPpvIOhLsMJ+xFQf0Ca1s=;
        b=Vo+WnXcfRWaqbC0JINcLsxV5SUxvk1CbyQoybwLAyEyrN4YSzkwCae/ItT/9hzuhXv
         3pz3gtTmsnghavqFea2kQzfOmuYVgciM4zOTEVhA6Mnb0EVBHmg8zBSeSEcTh2xqe/YB
         N8qXuxaK38k4xTuuSC08cCuQFgbme1F6BD/n41j3F4Z8WIgtxwSM2OrBHnTLzhIs7hwr
         /6fgyHglfEfk4hgGH82omlbVQQcpWtjnQ4Kxeqysn9vnTuGDPPdyMf5kRQJvT7H2W9Qo
         pZHVLlAHw2e+HqYuWwKL3pSwDL3RrBHN941ZtbQQtTTQEDah/QxrsVoeVHjyA53oXuQJ
         JM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483422; x=1726088222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6eUNo9P+fL7OnZzluk8DnXPpvIOhLsMJ+xFQf0Ca1s=;
        b=lRQDUm3IzOQKzahRz4WtltbsS4QOLtLmAGX0xbWxBHNg9vaThbRx6EKnkOOf7EHXKy
         gjeYBnCg1cC9VRb93nGTcSDUU21lwX2aimh+0J1zQ45FbtBgQEy59gpwsVbMqRxZrYeP
         86lsa+eQ+VPGYD1J+wxNkUkfhvGE35eyNmXXf6QBxmyZHp81SjCL+jy1CaSivGdzzBG/
         NRvY9otsXEnusSwwZ0wlhJIdaxX80W4gUGxSclS1UurZNqNxOV++cGlZK5XIiC3pbqBU
         1P9kPDMnnSUx52F4RA+lqD6GqlE+ubHqvfV2usfFbFoU3HFrJ44/t7YL1xh7kVflNpDM
         /5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4WbQyC+wsB6uUCPolRhmmX4dtAFZHdEIi7FO5smK8LCejy8JEpdd4Bt84g9ieWU6QKESe22dzeVHapg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQVSHcLznxWl7zoxPZHgR3mQctjyrB7pddwXm8tU8w6GIFBnM
	PdjdEFTp2U3L6xyE12qp4uMJWT0gX9DX49Lu9WdqpEUBLQNOD74I4ATmmu59
X-Google-Smtp-Source: AGHT+IH/BZwH4UrsEYWDfFunVT/72Gq7R+ke4UZZXEP93Ag/q3PpWYktGhGYkSUtunV+7xajBVzthg==
X-Received: by 2002:a05:6a00:3213:b0:717:83bc:6df3 with SMTP id d2e1a72fcca58-71783bc6f5cmr3025752b3a.11.1725483421698;
        Wed, 04 Sep 2024 13:57:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778533221sm2026166b3a.47.2024.09.04.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:57:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	ansuelsmth@gmail.com
Subject: [PATCH] net: phy: qca83xx: use PHY_ID_MATCH_EXACT
Date: Wed,  4 Sep 2024 13:56:59 -0700
Message-ID: <20240904205659.7470-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for the mask when there's already a macro for this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/phy/qcom/qca83xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
index 5d083ef0250e..a05d0df6fa16 100644
--- a/drivers/net/phy/qcom/qca83xx.c
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -15,7 +15,6 @@
 #define QCA8327_A_PHY_ID			0x004dd033
 #define QCA8327_B_PHY_ID			0x004dd034
 #define QCA8337_PHY_ID				0x004dd036
-#define QCA8K_PHY_ID_MASK			0xffffffff
 
 #define QCA8K_DEVFLAGS_REVISION_MASK		GENMASK(2, 0)
 
@@ -216,8 +215,7 @@ static int qca8327_suspend(struct phy_device *phydev)
 static struct phy_driver qca83xx_driver[] = {
 {
 	/* QCA8337 */
-	.phy_id			= QCA8337_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	PHY_ID_MATCH_EXACT(QCA8337_PHY_ID),
 	.name			= "Qualcomm Atheros 8337 internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.probe			= qca83xx_probe,
@@ -231,8 +229,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-A from switch QCA8327-AL1A */
-	.phy_id			= QCA8327_A_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID),
 	.name			= "Qualcomm Atheros 8327-A internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.link_change_notify	= qca83xx_link_change_notify,
@@ -247,8 +244,7 @@ static struct phy_driver qca83xx_driver[] = {
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-B from switch QCA8327-BL1A */
-	.phy_id			= QCA8327_B_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID),
 	.name			= "Qualcomm Atheros 8327-B internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.link_change_notify	= qca83xx_link_change_notify,
-- 
2.46.0


