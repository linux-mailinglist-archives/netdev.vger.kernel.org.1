Return-Path: <netdev+bounces-41694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380777CBB57
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EA81C20DC2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA4125BC;
	Tue, 17 Oct 2023 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LbvZLVIK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD958494
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 06:34:24 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641CAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697524463; x=1729060463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJC+xqvMODnmxG5jOSBHxPHb8sryXV6O75Epup1Ki2I=;
  b=LbvZLVIKsOKDw/PPXX2mipCiE3R5vCWzoP24+SwvzbsSqsed2EVJRphB
   rM8MWUZhj/SRoOiat6EfZauNMQcRw+PH/kHYfyR1IyypiUtncz/myRK37
   kU/Gr+MBupculS/yz20tICsOzo0OcdLUIZXWeiuzrbckWOZxwbrAl4K8w
   KLzXtmGuAwOtqcM0JuEnRuavryzPGbhSb581SsYQhvx9+Z8yEOfrQQ6WZ
   iIJwsm6ZT3qcgm4wK1Dwy1ktzpnsFqZFbAj6wHy9OXvWbpAAFb9HeDLhS
   He/JkIyeOfynNg+2rF77/lgw/WsYz5hV51NXtopsGXXRGrUprNu9jLJTA
   w==;
X-IronPort-AV: E=Sophos;i="6.03,231,1694728800"; 
   d="scan'208";a="33494790"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Oct 2023 08:34:19 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5F2CF280084;
	Tue, 17 Oct 2023 08:34:19 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/2] net: fec: Fix device_get_match_data usage
Date: Tue, 17 Oct 2023 08:34:18 +0200
Message-Id: <20231017063419.925266-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
References: <20231017063419.925266-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

device_get_match_data() expects that of_device_id->data points to actual
fec_devinfo data, not a platform_device_id entry.
Fix this by adjusting OF device data pointers to their corresponding
structs.
enum imx_fec_type is now unused and can be removed.

Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5eb756871a963..2530463be2a1f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -222,30 +222,17 @@ static struct platform_device_id fec_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, fec_devtype);
 
-enum imx_fec_type {
-	IMX25_FEC = 1,	/* runs on i.mx25/50/53 */
-	IMX27_FEC,	/* runs on i.mx27/35/51 */
-	IMX28_FEC,
-	IMX6Q_FEC,
-	MVF600_FEC,
-	IMX6SX_FEC,
-	IMX6UL_FEC,
-	IMX8MQ_FEC,
-	IMX8QM_FEC,
-	S32V234_FEC,
-};
-
 static const struct of_device_id fec_dt_ids[] = {
-	{ .compatible = "fsl,imx25-fec", .data = &fec_devtype[IMX25_FEC], },
-	{ .compatible = "fsl,imx27-fec", .data = &fec_devtype[IMX27_FEC], },
-	{ .compatible = "fsl,imx28-fec", .data = &fec_devtype[IMX28_FEC], },
-	{ .compatible = "fsl,imx6q-fec", .data = &fec_devtype[IMX6Q_FEC], },
-	{ .compatible = "fsl,mvf600-fec", .data = &fec_devtype[MVF600_FEC], },
-	{ .compatible = "fsl,imx6sx-fec", .data = &fec_devtype[IMX6SX_FEC], },
-	{ .compatible = "fsl,imx6ul-fec", .data = &fec_devtype[IMX6UL_FEC], },
-	{ .compatible = "fsl,imx8mq-fec", .data = &fec_devtype[IMX8MQ_FEC], },
-	{ .compatible = "fsl,imx8qm-fec", .data = &fec_devtype[IMX8QM_FEC], },
-	{ .compatible = "fsl,s32v234-fec", .data = &fec_devtype[S32V234_FEC], },
+	{ .compatible = "fsl,imx25-fec", .data = &fec_imx25_info, },
+	{ .compatible = "fsl,imx27-fec", .data = &fec_imx27_info, },
+	{ .compatible = "fsl,imx28-fec", .data = &fec_imx28_info, },
+	{ .compatible = "fsl,imx6q-fec", .data = &fec_imx6q_info, },
+	{ .compatible = "fsl,mvf600-fec", .data = &fec_mvf600_info, },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6x_info, },
+	{ .compatible = "fsl,imx6ul-fec", .data = &fec_imx6ul_info, },
+	{ .compatible = "fsl,imx8mq-fec", .data = &fec_imx8mq_info, },
+	{ .compatible = "fsl,imx8qm-fec", .data = &fec_imx8qm_info, },
+	{ .compatible = "fsl,s32v234-fec", .data = &fec_s32v234_info, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fec_dt_ids);
-- 
2.34.1


