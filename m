Return-Path: <netdev+bounces-105783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD65912D51
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343E828652F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED017B423;
	Fri, 21 Jun 2024 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONcC0T6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81BB17B419
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995214; cv=none; b=NZUeqVbA4NZFewPxWts6AG+VPUIBNnNgy/J7LkSf8E0/O9gxRaTTx71BkXNzi/Vbe5Unq0iCy13UIHFrZ2FXiy5daQFpq+Wsk116LnJ4/KdStOllz/RLxgYmjJrlkH5Ue0HM4CpP1XXYOf7lX7w4eg64iRQkahenMsnPudfyVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995214; c=relaxed/simple;
	bh=6SvRW/yxoNpZwoYZMTVDeEIcDTd9jfiBS9x45YxGCMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOcPnkqDD4YinoQ0N1Rlt0eI4VYOYapu2H4P8NMasnD0LA5cIkNjpAZnNkpkQfd0+wu+4/eAv8wCTKE49eouXqDY/8NRr42k70mvCNdvj/eM+C6xpuCZqDD9EOCEFkOdRjzfyWvXfgO5Yy3qx7nFrV1MZOhyhHua4OqRcW3eCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONcC0T6F; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1acd482e4so1272487eaf.3
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995211; x=1719600011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mB0wI3bTOL8Z7NkoFf7Yv1HR9LADL20dFoU50ttk+I0=;
        b=ONcC0T6FUUlnewE+MNHbvlDPP7Q7gw/e+hMp6Cu93c34f9SiOF379mOnARu2jtWyqn
         chrissdXlbl6FicBUBnwnECgugZxSCYHOG1Ddr9++7LhMeDTroCL2psQkUfumzaryfZD
         W+hDNxDCc0gNLGWXznRrBx1Xj+9n30IFZeoE4Ev3MUnFOvWuP666DLM1ZntZs8AwehFm
         Zm/EUcM6FbEAXwSqA7fuRWNHs4IWeu6nplmmlA0+d5PMx5bYcxhdbgy11K7xjYIODwla
         lCDFtM3Ju9GAqMLP6a8sgocgaSd+YLlsFCiYysSJf5UEe+AHqXABfwQhW743ui6FzRkL
         +dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995211; x=1719600011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB0wI3bTOL8Z7NkoFf7Yv1HR9LADL20dFoU50ttk+I0=;
        b=TWfiWr2JzLSLlGnlvuF4qQX7G8l1QoZnb0Ghmk9qOWp4bN9yJ6OjYM1p625qQaFdhg
         4SEkLNBGP+JcBf2z+tk9R15M9tXgvHZyFRBiWwHDXTLyvdAoe6TIovHbO8H8ga7/99Kp
         nhOL2aDCv0snuBURdniZ2TLSynTKPC8eWyn4uEZl7hImHPCXGQ9o4mNgL4IyYBMF+Zem
         cqIixhNR7gHCUOuKl/O/UfYgyAViZKqZ3uaUrJCak/Tnlm1+ATTi5hmhtIQuRSAjSnJP
         CmMKOkfuCa+UKqwYvXrTU3W64VDlWkP5K4y4u1YCGNa4TNxf5+cQmIZJME+/1H3+0zY7
         /oFQ==
X-Gm-Message-State: AOJu0YzlHnWjSKK4dzZthOmH4bMMAlsdzt8cZARwlrjXy7rRyPpDKHmM
	Yri6GCda1FBiw5KfDjoFS9hoXm0hqzRA/AoTIZACJ82wBoxOtxeC1zg2aA==
X-Google-Smtp-Source: AGHT+IEzMY0fLvXQp+vJSxRH6ffRDmcnYfIYdcmRA44feJCo6ebepaSAcrhQ9ftAPsS6AsljIIYfJA==
X-Received: by 2002:a05:6359:4c82:b0:19f:3789:7601 with SMTP id e5c5f4694b2df-1a1fd6065fdmr1066031055d.27.1718995211135;
        Fri, 21 Jun 2024 11:40:11 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:10 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 02/15] net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:34 -0700
Message-Id: <20240621183947.4105278-3-allen.lkml@gmail.com>
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
APIs throughout the xgbe driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 30 +++++++++++------------
 drivers/net/ethernet/amd/xgbe/xgbe-i2c.c  | 16 ++++++------
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 16 ++++++------
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c  |  4 +--
 drivers/net/ethernet/amd/xgbe/xgbe.h      | 10 ++++----
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index c4a4e316683f..5475867708f4 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -403,9 +403,9 @@ static bool xgbe_ecc_ded(struct xgbe_prv_data *pdata, unsigned long *period,
 	return false;
 }
 
-static void xgbe_ecc_isr_task(struct tasklet_struct *t)
+static void xgbe_ecc_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_ecc);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, ecc_bh_work);
 	unsigned int ecc_isr;
 	bool stop = false;
 
@@ -465,17 +465,17 @@ static irqreturn_t xgbe_ecc_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_ecc);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->ecc_bh_work);
 	else
-		xgbe_ecc_isr_task(&pdata->tasklet_ecc);
+		xgbe_ecc_isr_bh_work(&pdata->ecc_bh_work);
 
 	return IRQ_HANDLED;
 }
 
-static void xgbe_isr_task(struct tasklet_struct *t)
+static void xgbe_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_dev);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, dev_bh_work);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	struct xgbe_channel *channel;
 	unsigned int dma_isr, dma_ch_isr;
@@ -582,7 +582,7 @@ static void xgbe_isr_task(struct tasklet_struct *t)
 
 	/* If there is not a separate ECC irq, handle it here */
 	if (pdata->vdata->ecc_support && (pdata->dev_irq == pdata->ecc_irq))
-		xgbe_ecc_isr_task(&pdata->tasklet_ecc);
+		xgbe_ecc_isr_bh_work(&pdata->ecc_bh_work);
 
 	/* If there is not a separate I2C irq, handle it here */
 	if (pdata->vdata->i2c_support && (pdata->dev_irq == pdata->i2c_irq))
@@ -604,10 +604,10 @@ static irqreturn_t xgbe_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_dev);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->dev_bh_work);
 	else
-		xgbe_isr_task(&pdata->tasklet_dev);
+		xgbe_isr_bh_work(&pdata->dev_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -1007,8 +1007,8 @@ static int xgbe_request_irqs(struct xgbe_prv_data *pdata)
 	unsigned int i;
 	int ret;
 
-	tasklet_setup(&pdata->tasklet_dev, xgbe_isr_task);
-	tasklet_setup(&pdata->tasklet_ecc, xgbe_ecc_isr_task);
+	INIT_WORK(&pdata->dev_bh_work, xgbe_isr_bh_work);
+	INIT_WORK(&pdata->ecc_bh_work, xgbe_ecc_isr_bh_work);
 
 	ret = devm_request_irq(pdata->dev, pdata->dev_irq, xgbe_isr, 0,
 			       netdev_name(netdev), pdata);
@@ -1078,8 +1078,8 @@ static void xgbe_free_irqs(struct xgbe_prv_data *pdata)
 
 	devm_free_irq(pdata->dev, pdata->dev_irq, pdata);
 
-	tasklet_kill(&pdata->tasklet_dev);
-	tasklet_kill(&pdata->tasklet_ecc);
+	cancel_work_sync(&pdata->dev_bh_work);
+	cancel_work_sync(&pdata->ecc_bh_work);
 
 	if (pdata->vdata->ecc_support && (pdata->dev_irq != pdata->ecc_irq))
 		devm_free_irq(pdata->dev, pdata->ecc_irq, pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
index a9ccc4258ee5..7a833894f52a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-i2c.c
@@ -274,9 +274,9 @@ static void xgbe_i2c_clear_isr_interrupts(struct xgbe_prv_data *pdata,
 		XI2C_IOREAD(pdata, IC_CLR_STOP_DET);
 }
 
-static void xgbe_i2c_isr_task(struct tasklet_struct *t)
+static void xgbe_i2c_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_i2c);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, i2c_bh_work);
 	struct xgbe_i2c_op_state *state = &pdata->i2c.op_state;
 	unsigned int isr;
 
@@ -321,10 +321,10 @@ static irqreturn_t xgbe_i2c_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = (struct xgbe_prv_data *)data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_i2c);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->i2c_bh_work);
 	else
-		xgbe_i2c_isr_task(&pdata->tasklet_i2c);
+		xgbe_i2c_isr_bh_work(&pdata->i2c_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -369,7 +369,7 @@ static void xgbe_i2c_set_target(struct xgbe_prv_data *pdata, unsigned int addr)
 
 static irqreturn_t xgbe_i2c_combined_isr(struct xgbe_prv_data *pdata)
 {
-	xgbe_i2c_isr_task(&pdata->tasklet_i2c);
+	xgbe_i2c_isr_bh_work(&pdata->i2c_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -449,7 +449,7 @@ static void xgbe_i2c_stop(struct xgbe_prv_data *pdata)
 
 	if (pdata->dev_irq != pdata->i2c_irq) {
 		devm_free_irq(pdata->dev, pdata->i2c_irq, pdata);
-		tasklet_kill(&pdata->tasklet_i2c);
+		cancel_work_sync(&pdata->i2c_bh_work);
 	}
 }
 
@@ -464,7 +464,7 @@ static int xgbe_i2c_start(struct xgbe_prv_data *pdata)
 
 	/* If we have a separate I2C irq, enable it */
 	if (pdata->dev_irq != pdata->i2c_irq) {
-		tasklet_setup(&pdata->tasklet_i2c, xgbe_i2c_isr_task);
+		INIT_WORK(&pdata->i2c_bh_work, xgbe_i2c_isr_bh_work);
 
 		ret = devm_request_irq(pdata->dev, pdata->i2c_irq,
 				       xgbe_i2c_isr, 0, pdata->i2c_name,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 4a2dc705b528..07f4f3418d01 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -703,9 +703,9 @@ static void xgbe_an73_isr(struct xgbe_prv_data *pdata)
 	}
 }
 
-static void xgbe_an_isr_task(struct tasklet_struct *t)
+static void xgbe_an_isr_bh_work(struct work_struct *work)
 {
-	struct xgbe_prv_data *pdata = from_tasklet(pdata, t, tasklet_an);
+	struct xgbe_prv_data *pdata = from_work(pdata, work, an_bh_work);
 
 	netif_dbg(pdata, intr, pdata->netdev, "AN interrupt received\n");
 
@@ -727,17 +727,17 @@ static irqreturn_t xgbe_an_isr(int irq, void *data)
 {
 	struct xgbe_prv_data *pdata = (struct xgbe_prv_data *)data;
 
-	if (pdata->isr_as_tasklet)
-		tasklet_schedule(&pdata->tasklet_an);
+	if (pdata->isr_as_bh_work)
+		queue_work(system_bh_wq, &pdata->an_bh_work);
 	else
-		xgbe_an_isr_task(&pdata->tasklet_an);
+		xgbe_an_isr_bh_work(&pdata->an_bh_work);
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t xgbe_an_combined_isr(struct xgbe_prv_data *pdata)
 {
-	xgbe_an_isr_task(&pdata->tasklet_an);
+	xgbe_an_isr_bh_work(&pdata->an_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -1454,7 +1454,7 @@ static void xgbe_phy_stop(struct xgbe_prv_data *pdata)
 
 	if (pdata->dev_irq != pdata->an_irq) {
 		devm_free_irq(pdata->dev, pdata->an_irq, pdata);
-		tasklet_kill(&pdata->tasklet_an);
+		cancel_work_sync(&pdata->an_bh_work);
 	}
 
 	pdata->phy_if.phy_impl.stop(pdata);
@@ -1477,7 +1477,7 @@ static int xgbe_phy_start(struct xgbe_prv_data *pdata)
 
 	/* If we have a separate AN irq, enable it */
 	if (pdata->dev_irq != pdata->an_irq) {
-		tasklet_setup(&pdata->tasklet_an, xgbe_an_isr_task);
+		INIT_WORK(&pdata->an_bh_work, xgbe_an_isr_bh_work);
 
 		ret = devm_request_irq(pdata->dev, pdata->an_irq,
 				       xgbe_an_isr, 0, pdata->an_name,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index c5e5fac49779..c636999a6a84 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -139,7 +139,7 @@ static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 
-	pdata->isr_as_tasklet = 1;
+	pdata->isr_as_bh_work = 1;
 	pdata->irq_count = ret;
 
 	pdata->dev_irq = pci_irq_vector(pdata->pcidev, 0);
@@ -176,7 +176,7 @@ static int xgbe_config_irqs(struct xgbe_prv_data *pdata)
 		return ret;
 	}
 
-	pdata->isr_as_tasklet = pdata->pcidev->msi_enabled ? 1 : 0;
+	pdata->isr_as_bh_work = pdata->pcidev->msi_enabled ? 1 : 0;
 	pdata->irq_count = 1;
 	pdata->channel_irq_count = 1;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index f01a1e566da6..d85386cac8d1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1298,11 +1298,11 @@ struct xgbe_prv_data {
 
 	unsigned int lpm_ctrl;		/* CTRL1 for resume */
 
-	unsigned int isr_as_tasklet;
-	struct tasklet_struct tasklet_dev;
-	struct tasklet_struct tasklet_ecc;
-	struct tasklet_struct tasklet_i2c;
-	struct tasklet_struct tasklet_an;
+	unsigned int isr_as_bh_work;
+	struct work_struct dev_bh_work;
+	struct work_struct ecc_bh_work;
+	struct work_struct i2c_bh_work;
+	struct work_struct an_bh_work;
 
 	struct dentry *xgbe_debugfs;
 
-- 
2.34.1


