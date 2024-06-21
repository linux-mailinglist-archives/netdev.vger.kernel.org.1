Return-Path: <netdev+bounces-105785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F12912D53
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D53287B97
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBB617A93D;
	Fri, 21 Jun 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGjMqo7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156617B43E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995218; cv=none; b=ZXnpSieQAUgHlidRuyNMB18z27RSrfmGJDF6797xG7m9DJ2XaA0OJ1/GT+7Gsewnr9/arTG6TAfhKJqbbp6J+vTGqUkyTX+HSot5GjPL5vZYPm9vbwXfp+FN1EdHTNbUDw/PoLmJ/LtVwHXVqBRpP8YXAi2Lj0CqUaia8qB6V4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995218; c=relaxed/simple;
	bh=iWmbrGxooEyBj4VWQ7emVHug9EYg04S4JxaGVSqV/yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0OJv3R57IdnDs+vqkx6Q06/VoF/WX0WD8KOXWmGeWqhsLlAwqc8ug8ODBycRn+AetIA/iCvXm4/wY7Ysg+q+VXUcpJzRSCKYEu30AEAeYyh5mZP3ETSF8F6zhsdh6SuhuqFplu/yVxM77vGNABGIrxJzeYnRJceHJi3rRWFrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGjMqo7r; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c1d6064557so606271eaf.2
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995215; x=1719600015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiWssLGa6hq6n1xcfQQ/01ONDxIRNpw6q3yCritF5Gs=;
        b=LGjMqo7rQPL4g0PeF1aBZeBRGWqJNUeym0WtlDptmS+NBQDZqlYK62lxDQlDXIRcIc
         W9JEU4p7f+N6D9Owt8NwVfkOixslM+oCsMIuT3UhFtZAWFMDe9YB0L0uhSJ1oU6cIQyr
         RIanXviWKm8/J1HEbTqlU7pTAL4iOsTcTNDr5ELz20rvtwXiw9tcHl7L3q0cSaWIVAtk
         /H3BD7FU1/pRWU7CoEDvCc2nN2DhTjMOJHwo4YkiFiD1AseQSI5FN+4b2E+/Mb0loCCb
         uipDRlSiYHYOyyxgRx9XVNv8gBwjzrlwkgFTvYS8vQrRhpcLiKaAZro/KZO31C9gpSsI
         xU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995215; x=1719600015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiWssLGa6hq6n1xcfQQ/01ONDxIRNpw6q3yCritF5Gs=;
        b=Yq387cRrBhNDCBZdFRNx8xyoMwhu248gPnm2fOWN7b3dJPMZrBhjIALr7+JYvPO2GJ
         xp/oWFitNWiizqmZamOv9gEsF6bz5zSe+5U+UxTY3Uozf0YXBGB/nFwJeTxqmidwuGoy
         Rs4ltBmQ/GzS7pFvam3NaN0uZDvMUy0/yvNTUcDsPBim2P4fSoGk78G184ydCgcEJb4g
         UQfmKtvdpNu0ZOkDaopSpjX9qGOCuy75mS1ad1ZkxOl7i7nbE2R3gCdJMZWyXHk9ZXGv
         K7K/swo2X/APNUcdj7XuKnQOPbkDx5E9qhhy6h2Xmf+5DyN98p2Z8+EyokBIkJw8Zcio
         qmag==
X-Gm-Message-State: AOJu0YzdsVfLnNKKHAkDtFadhngVV2qSqcEX6Gz0DPla+4xhSckAroe4
	V4bQqIEAutxzkl1fJ80haCqSpRXleZMgk1Hnq2VhtFN2H3VH//9q51FR5A==
X-Google-Smtp-Source: AGHT+IGB9QkWwriXM9vxrHe5CUsrWWUWZDARsRh9DihBDKfIj09V5wSlscZZtix8G0XK9d7JHC/xow==
X-Received: by 2002:a05:6359:2c49:b0:1a1:fdee:fb68 with SMTP id e5c5f4694b2df-1a1fdef09b7mr732296655d.23.1718995215125;
        Fri, 21 Jun 2024 11:40:15 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:14 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 04/15] net: macb: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:36 -0700
Message-Id: <20240621183947.4105278-5-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621183947.4105278-1-allen.lkml@gmail.com>
References: <20240621183947.4105278-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the macb driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..e570cad705d2 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -13,6 +13,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/interrupt.h>
 #include <linux/phy/phy.h>
+#include <linux/workqueue.h>
 
 #if defined(CONFIG_ARCH_DMA_ADDR_T_64BIT) || defined(CONFIG_MACB_USE_HWSTAMP)
 #define MACB_EXT_DESC
@@ -1322,7 +1323,7 @@ struct macb {
 	spinlock_t rx_fs_lock;
 	unsigned int max_tuples;
 
-	struct tasklet_struct	hresp_err_tasklet;
+	struct work_struct	hresp_err_bh_work;
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 241ce9a2fa99..0dc21a9ae215 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1792,9 +1792,9 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static void macb_hresp_error_task(struct tasklet_struct *t)
+static void macb_hresp_error_task(struct work_struct *work)
 {
-	struct macb *bp = from_tasklet(bp, t, hresp_err_tasklet);
+	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *dev = bp->dev;
 	struct macb_queue *queue;
 	unsigned int q;
@@ -1994,7 +1994,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		}
 
 		if (status & MACB_BIT(HRESP)) {
-			tasklet_schedule(&bp->hresp_err_tasklet);
+			queue_work(system_bh_wq, &bp->hresp_err_bh_work);
 			netdev_err(dev, "DMA bus error: HRESP not OK\n");
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
@@ -5150,7 +5150,7 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_unregister_mdio;
 	}
 
-	tasklet_setup(&bp->hresp_err_tasklet, macb_hresp_error_task);
+	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
 
 	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
 		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
@@ -5194,7 +5194,7 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
-		tasklet_kill(&bp->hresp_err_tasklet);
+		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (!pm_runtime_suspended(&pdev->dev)) {
-- 
2.34.1


