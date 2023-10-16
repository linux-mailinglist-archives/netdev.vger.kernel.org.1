Return-Path: <netdev+bounces-41299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF0E7CA7EE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0712814A9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06526E35;
	Mon, 16 Oct 2023 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="IpuoSRGz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7123740
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 12:24:49 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613009F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1697459088; x=1728995088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R88kzgSWXdecZ1QHCNPqzsyScxq9uZZLEAZAtEAqN1Y=;
  b=IpuoSRGzz3G0/DLUcZZXX5Mk6c98VU2fkRoFRG433RpQ/PCvwqhSykBc
   VIezPQ4IwJNPlHrDR+AQIILyFXTMK+j0kxPQ3bZZd4MlMWUntb+rj+NiX
   qfqEvEweaglHdw1nVdvedvvZpemjhbqHTHIwDkLdyEsIJNmjpGm5z5qlA
   e/wmm4s8yBtVX1DyVA6B/c4/UghmjhwktIpB+wv65dQRMoTTXBu56vaEo
   7+ne8lSWfl10hqTITelixfB+wkD8sKhwH3+SPWBTrcaA4X4sGw327gZ5G
   JBXe4NTDvhuiFjxQVgTPfa3ogk3Ba3/YNDp9jkXDU+zgUJK8q7zMxO3Yl
   A==;
X-IronPort-AV: E=Sophos;i="6.03,229,1694728800"; 
   d="scan'208";a="33482075"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Oct 2023 14:24:46 +0200
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 65869280082;
	Mon, 16 Oct 2023 14:24:46 +0200 (CEST)
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
Subject: [PATCH 1/1] net: fec: Fix device_get_match_data usage
Date: Mon, 16 Oct 2023 14:24:46 +0200
Message-Id: <20231016122446.807703-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

device_get_match_data() returns an entry of fec_devtype, an array of
struct platform_device_id. But the desired struct fec_devinfo information
is stored in platform_device_id.driver_data. Thus directly storing
device_get_match_data() result in dev_info is wrong.
Instead, similar to before the change, update the pdev->id_entry if
device_get_match_data() returned non-NULL.

Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Admittedly I am not a fan of adding a additional struct platform_device_id
pointer. But as long a this driver supports non-DT probes it can be non-NULL.

 drivers/net/ethernet/freescale/fec_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5eb756871a963..dc7c3ef5ba9de 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4297,6 +4297,7 @@ fec_probe(struct platform_device *pdev)
 	char irq_name[8];
 	int irq_cnt;
 	const struct fec_devinfo *dev_info;
+	const struct platform_device_id *plat_dev_id;
 
 	fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
 
@@ -4311,9 +4312,10 @@ fec_probe(struct platform_device *pdev)
 	/* setup board info structure */
 	fep = netdev_priv(ndev);
 
-	dev_info = device_get_match_data(&pdev->dev);
-	if (!dev_info)
-		dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
+	plat_dev_id = device_get_match_data(&pdev->dev);
+	if (plat_dev_id)
+		pdev->id_entry = plat_dev_id;
+	dev_info = (const struct fec_devinfo *)pdev->id_entry->driver_data;
 	if (dev_info)
 		fep->quirks = dev_info->quirks;
 
-- 
2.34.1


