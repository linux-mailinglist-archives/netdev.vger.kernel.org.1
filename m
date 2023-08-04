Return-Path: <netdev+bounces-24556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B576770992
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06625282625
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC841BF1E;
	Fri,  4 Aug 2023 20:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4E1BF1B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:19:17 +0000 (UTC)
Received: from mail-pl1-x664.google.com (mail-pl1-x664.google.com [IPv6:2607:f8b0:4864:20::664])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02F4C2D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:19:15 -0700 (PDT)
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-1bbc06f830aso17642255ad.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691180354; x=1691785154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQFjBf7YtxXmJlSdHAu4ArmD+GnCH3KaGA7nl8cwkTs=;
        b=UtRNJsHxz1UB+ekhwkbt9C6Dtk5h5XbMoumFtaOzkQEv7IxKftbaDFQN+lTKl/AbZq
         bbotrbh+PtwAHlsbd7VATsfzrz4K1LmfvsCb3eTyJ03K6PP/cWp9eLArYWEztxFf9mZu
         qakKdMsiXit6f/0Nrst3iazklcxEc0oshWrHoAkQBb9D9X+VIECWWFqTVMAfKzLyijTz
         HQaJGrX0+fu0JdVokc6FczhJrI7skr833dGmXo9fTWsYTy7aaCN3wihbZeuCJfUgouab
         kiyKrKRSQ5MPhOmof8V8SGYdOb1EbVdrzpXF7MfbtyK1eh6+GIxlxUO2eZm3Kc5enz2s
         HEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691180354; x=1691785154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQFjBf7YtxXmJlSdHAu4ArmD+GnCH3KaGA7nl8cwkTs=;
        b=bVbY4EtNWT6C3wjHUaLjP2bCcpVw2znkIkZtDPrH1Cl60LuA+gWUtJRPdJyjHeawDx
         UxxNOavqtWt769AMkKJvAK3fTW1SmUOYFXSs+dvH9yH1eV4M9FtpA+m5ND3m/XeEmLQ2
         KCH/+5ibgDnhXQ7s6uUgKUZlPZSegpuHpV9SzoxFPf47Z65lvaC4pjdgr2GQ78oQns9l
         K7tM5GDMjvNT8u9qJXL7OHTXdMhvJRA4lyTatgydMshQVVQk2UnAZFPS1L56FUcwdB0t
         tItUHoac9gI0gs7UHI2NUBQdjRKHzwEUjKCemRzvP6vrnXV4L8+xaQV7M2R/idY1pwjE
         O2sw==
X-Gm-Message-State: AOJu0Yy8g1nWGmcN59LQLByTffQUKdk+te9CS5IVZNP6CtaTssUtEwDM
	77gER6DMLIeGuV8OLIPMxg09+kV7SlVK1ltGO9SWAQfdeYL9
X-Google-Smtp-Source: AGHT+IG8HYHsBb1cwD/a6m826Y9iwPZnuIAKjiIHJsIkwHtJraIeAGfz9scoH18va3RFBbCIMIdNo+4mCugP
X-Received: by 2002:a17:902:f551:b0:1bb:c7bc:ceb8 with SMTP id h17-20020a170902f55100b001bbc7bcceb8mr768160plf.22.1691180354378;
        Fri, 04 Aug 2023 13:19:14 -0700 (PDT)
Received: from dxue-amd-5700g.libretech.co ([72.76.64.93])
        by smtp-relay.gmail.com with ESMTPS id q7-20020a170902a3c700b001b9dbb0e802sm377270plb.137.2023.08.04.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:19:14 -0700 (PDT)
X-Relaying-Domain: libre.computer
From: Da Xue <da@libre.computer>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>,
	Luke Lu <luke.lu@libre.computer>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH v2] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date: Fri,  4 Aug 2023 16:19:02 -0400
Message-Id: <20230804201903.1303713-1-da@libre.computer>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After suspend and resume, the meson GXL internal PHY config needs to be initialized again or the carrier cannot be found.

Signed-off-by: Luke Lu <luke.lu@libre.computer>
Reviewed-by: Da Xue <da@libre.computer>
---
 drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6b..2df516ed4 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	genphy_resume();
+	ret = meson_gxl_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= smsc_phy_config_intr,
 		.handle_interrupt = smsc_phy_handle_interrupt,
 		.suspend        = genphy_suspend,
-		.resume         = genphy_resume,
+		.resume         = meson_gxl_phy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
-- 
2.39.2


