Return-Path: <netdev+bounces-25378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93272773D21
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A961C20F31
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F308168C6;
	Tue,  8 Aug 2023 15:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CB14018
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:58:04 +0000 (UTC)
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCB5B8E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:57:52 -0700 (PDT)
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-6bca857accbso5000296a34.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691510249; x=1692115049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkyQ6QEBJ5R+A4KzXauS14DJOe2NQamik93pPPAJ9ek=;
        b=fZyxVHiRYYoEehpsh4JNeqndwH8yN7AVL8hzaUCj6C32BMnJkovPdMIPuDZZvU3f9R
         NyBSqFLvOA+skLLOhmO7ZSnfsAk/Kpu+i7y7V17wsusp+nHY8DrvxWmiDbqPzhZBqoh7
         bR2vDISVn+FW8rVlZliEMjBoCzjD+arlFXoXrCUpqIYTpxPxyc53+oSHRVyaLTs6kbUg
         Oj3UvuQ0fSyDCCP4a7rWFBTLqi0PRmXon72FqjJ3tmpmWmqaxl4sA4jh5yv2VXiPspL6
         xLr2kiRMreVWEU1v0I5gv53u9fee0qh/5rK+l+zTqr5ufeU7tAn3ahVluDo/O94SOQ78
         Ryfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510249; x=1692115049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkyQ6QEBJ5R+A4KzXauS14DJOe2NQamik93pPPAJ9ek=;
        b=e7ZYYrCE/24x8uRrn0pe0wP/rQspeuaNwecsVDucW7FHdE6z+VL1qE9q8JNmOo2kAr
         PttS8X7fnIP4Mcd+Y0s3HgBm5LrEcu/wSkvdnQoVQb3oCzTCBExjQm+wHVZJm4Bj8ycR
         kV5IWocy94P7dkB8XkC6lnezS1d3UMeKQFDtQYi7QEp4qJqvjQWaHGkMUNoFacuh7jOG
         o2Q4bVnoxH22DC+tZmPEcPWAa/W5b7E+J646mtNTIxRyhB9/fLbibSneckljY/gaRUTV
         ReSTDitJP1hxsk6nbrrI7wr6Umgsti4UFAozXiOxgF2pBJ0YTcZOcL7oQmBxJ7oic4fq
         yOvw==
X-Gm-Message-State: AOJu0YyiR1z2oEen83LsHedYCIgtdULXELyNuaxfLVyIag22/6lgHSm0
	PAa5zFERMe29qtTwaVSfkxMTXqS61XZ40UE+xx4hUNlxlehq
X-Google-Smtp-Source: AGHT+IGOiebSl22GAJa1Vqszzuk5r+Le/tkscMQwKLAbyswQsnfaT24eZusPYQGYRv08JMU2SVc/f7X59f9M
X-Received: by 2002:a1f:c1d8:0:b0:487:1962:7495 with SMTP id r207-20020a1fc1d8000000b0048719627495mr6886859vkf.1.1691470841920;
        Mon, 07 Aug 2023 22:00:41 -0700 (PDT)
Received: from dxue-amd-5700g.libretech.co ([72.76.64.93])
        by smtp-relay.gmail.com with ESMTPS id c11-20020a02a40b000000b0042911ed0da5sm584619jal.11.2023.08.07.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:00:41 -0700 (PDT)
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
Subject: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date: Tue,  8 Aug 2023 01:00:15 -0400
Message-Id: <20230808050016.1911447-1-da@libre.computer>
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
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After suspend and resume, the meson GXL internal PHY config needs to
be initialized again, otherwise the carrier cannot be found:

	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
		DOWN group default qlen 1000

After the patch, resume:

	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
		group default qlen 1000

Signed-off-by: Luke Lu <luke.lu@libre.computer>
Signed-off-by: Da Xue <da@libre.computer>
---
Changes since v2:
 - fix missing parameter of genphy_resume()

Changes since v1:
 - call generic genphy_resume()
---
 drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6bce2..bbad26b7c5a1 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	genphy_resume(phydev);
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
2.40.1


