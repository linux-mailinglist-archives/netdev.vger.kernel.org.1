Return-Path: <netdev+bounces-227347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4938EBACCBB
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC871C8631
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB12FB968;
	Tue, 30 Sep 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="th5fdSWa"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66E1B4236;
	Tue, 30 Sep 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234611; cv=none; b=IF6PbmS3TwXLNLYfdFmm8Bh2R4ITyr9EiRVdWVx03sPhMQEmmGnuAwBZRWMGOtf/eGDQLVqLZvzryM/5Jt1BMjPPn43LF6QWPrAKDCOmi5Db213bNh7zB0MXihZnmfTDEXnp2Id8deFzhHs/eYQh8nH0Ljfjux+W4Frfs0bo0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234611; c=relaxed/simple;
	bh=ZDMQtBSx/tempIWhtSRAyTG12Gi0CmsJXbMINLSdMd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYvv1wTHF2z6eiWVCshkrfh/V7n24c57ZCuLTjbgaHoJNWd/oBVJNGXGnO1DLRhqmhxJ5Wd319cf8g3CzfHUr8/HcdWmQ9NpORqm2D8meuPKW5jaUxs/+MxUxKczA5ReeuJ/VifkPuDTHUX4kF66JzeXicQVVF5K+0TNaMOCsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=th5fdSWa; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58UCGMaD2911947;
	Tue, 30 Sep 2025 07:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759234582;
	bh=DT3kmmoCh/QqwpiEzn8+Wg1aSuJs0OQeflPRtSBj4OA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=th5fdSWa2pS7avy3CPJi20Rcr43GmjveGr5yG7lxHBPz04lInhVXVcAnRRVeLxUB4
	 3t1yDltwFhdAVvwDWGlfnzuyFhC8FWsGNjRxE1nC6r7Dp3jAjwQBaGhtV5Mig33r7C
	 LC9mXPRE53fe3cFLlAb5IXcJS2LRNrroEKj5u3xg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58UCGMaO2114239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 30 Sep 2025 07:16:22 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 30
 Sep 2025 07:16:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Sep 2025 07:16:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58UCGLwc2892161;
	Tue, 30 Sep 2025 07:16:21 -0500
From: Nishanth Menon <nm@ti.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: Santosh Shilimkar <ssantosh@kernel.org>, Simon Horman <horms@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/3] soc: ti: knav_dma: Make knav_dma_open_channel return NULL on error
Date: Tue, 30 Sep 2025 07:16:08 -0500
Message-ID: <20250930121609.158419-3-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250930121609.158419-1-nm@ti.com>
References: <20250930121609.158419-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Make knav_dma_open_channel consistently return NULL on error instead of
ERR_PTR. Currently the header include/linux/soc/ti/knav_dma.h returns NUL
when the driver is disabled, but the driver implementation returns
ERR_PTR(-EINVAL), creating API inconsistency for users.

Standardize the error handling by making the function return NULL on all
error conditions.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V2:
* renewed version

 drivers/soc/ti/knav_dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index a25ebe6cd503..e69f0946de29 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -402,7 +402,7 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
  * @name:	slave channel name
  * @config:	dma configuration parameters
  *
- * Returns pointer to appropriate DMA channel on success or error.
+ * Returns pointer to appropriate DMA channel on success or NULL on error.
  */
 void *knav_dma_open_channel(struct device *dev, const char *name,
 					struct knav_dma_cfg *config)
@@ -414,13 +414,13 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 
 	if (!kdev) {
 		pr_err("keystone-navigator-dma driver not registered\n");
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	chan_num = of_channel_match_helper(dev->of_node, name, &instance);
 	if (chan_num < 0) {
 		dev_err(kdev->dev, "No DMA instance with name %s\n", name);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	dev_dbg(kdev->dev, "initializing %s channel %d from DMA %s\n",
@@ -431,7 +431,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	if (config->direction != DMA_MEM_TO_DEV &&
 	    config->direction != DMA_DEV_TO_MEM) {
 		dev_err(kdev->dev, "bad direction\n");
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	/* Look for correct dma instance */
@@ -443,7 +443,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	}
 	if (!dma) {
 		dev_err(kdev->dev, "No DMA instance with name %s\n", instance);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	/* Look for correct dma channel from dma instance */
@@ -463,14 +463,14 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	if (!chan) {
 		dev_err(kdev->dev, "channel %d is not in DMA %s\n",
 				chan_num, instance);
-		return (void *)-EINVAL;
+		return NULL;
 	}
 
 	if (atomic_read(&chan->ref_count) >= 1) {
 		if (!check_config(chan, config)) {
 			dev_err(kdev->dev, "channel %d config miss-match\n",
 				chan_num);
-			return (void *)-EINVAL;
+			return NULL;
 		}
 	}
 
-- 
2.47.0


