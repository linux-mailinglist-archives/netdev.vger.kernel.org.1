Return-Path: <netdev+bounces-18418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8E756D5D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BD71C20C02
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B15C2FE;
	Mon, 17 Jul 2023 19:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69741C2D2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:33:58 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5145594
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-316f9abf204so2287239f8f.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622435; x=1692214435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIKKNO44whimUl3lod4nAoGT5peZzIzk6bZkSLL9pZE=;
        b=NXaj3ISQ1xDhBoS7qpXZXLLGL3Czy+a33D5G+IeaUpgnWcVHN/zkgdZrxjivbFaWNj
         qXuapcGw3diWsTwSwNOkGMtlfgAmFCFuyYw2SWvf8ynNTUrPW0VLRCF/j3F4AdJbqZay
         JJ80p7o4wJfpUn0HogNfpxu+5EyG53cUWQHeshRGBsG76df7RB7SJYGCOym0knuEZLqQ
         3SAy0DWaEqN7JaBioHd8LfkiR/JJqarqXQQ8kVXx+cqh/usk6cAAYVodI/VUTNmAwiqJ
         vET303/rDc/jV5SBFX9B927IuMippIVft10TBgiijljFK/8SBDBwMWyLQUitYW6F0/TD
         OWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622435; x=1692214435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIKKNO44whimUl3lod4nAoGT5peZzIzk6bZkSLL9pZE=;
        b=ltljam91s+Fs2wQrDQyy19jAZPxbDvSeawojpt3mmdnvaGOvMIV11EdE0qCjRfyhut
         /7WX4LxtsSAC6IEBf8Q71TzbfsuOHMtl6+WfFqqrCewdo1GdIpTbzFZvlut+EqIJK07E
         3CbDNVR2Raq2sXLqbcT/1uM1K1LFttO3woCnadH4r/79X7SakEmc4G+u6wreh54zvc/w
         HEdb84yWjJo7Hh2K4UqkYhon7t9zun314UR9qX35SWT+i+WmG+Og2RewcN34VmgvUJXl
         rkYSQZL729kQZYGH8bpOxpmuT+uDA20DIA1KVoEz+XMiqcYQx8CgL676Ad4c51E/yCpi
         9mNQ==
X-Gm-Message-State: ABy/qLZ1pEkKXOJzCcoQFHif4PZbTfqVolJ1ukBk/yCPS2Us+z3E4c0Y
	9uzucy9Y4y0vsFt0Mx560/pisGp+ls999A==
X-Google-Smtp-Source: APBJJlGsI2ieHBedSGoxerMWKlAA403tGtKfy8nU+jsbV6el+XVfwn7olewkYXuKe1cmM10EtaBSeQ==
X-Received: by 2002:a5d:6dcb:0:b0:313:e8b6:1699 with SMTP id d11-20020a5d6dcb000000b00313e8b61699mr10382021wrz.55.1689622435389;
        Mon, 17 Jul 2023 12:33:55 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72:0:5cdb:47c:bcfa:4c2b])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d5507000000b003142ea7a661sm280944wrv.21.2023.07.17.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:33:54 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	francesco.dolcini@toradex.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eichest@gmail.com
Subject: [PATCH net-next v3 4/5] net: phy: c45: detect the BASE-T1 speed from the ability register
Date: Mon, 17 Jul 2023 21:33:49 +0200
Message-Id: <20230717193350.285003-5-eichest@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717193350.285003-1-eichest@gmail.com>
References: <20230717193350.285003-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Read the ability to do 100BASE-T1 and 1000BASE-T1 from the extended
BASE-T1 ability register of the PHY.

Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
 drivers/net/phy/phy-c45.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 58a6bbbe8a70c..8e6fd4962c486 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -899,6 +899,14 @@ int genphy_c45_pma_baset1_read_abilities(struct phy_device *phydev)
 			 phydev->supported,
 			 val & MDIO_PMA_PMD_BT1_B10L_ABLE);
 
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_PMD_BT1_B100_ABLE);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_PMD_BT1_B1000_ABLE);
+
 	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_STAT);
 	if (val < 0)
 		return val;
-- 
2.39.2


