Return-Path: <netdev+bounces-105796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF95912D60
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04E81C238CE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8A17C23B;
	Fri, 21 Jun 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW/pJovT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22017C22B
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995239; cv=none; b=fkViV5Kw4eXak+rHIlLp9gJ8NDycv6jRPA+hLOQO9RduBpDQd1vnmJbzSyay7CmeUPTW0BMS42lWXObcStc2NoiQHEUByRnvyzw28HRpqXJckmFeiq+TVQWccopLb/Q4Bu/bIR8XRoYfpLTtJlKAFcqPY8B6s7lsADNzS3X9Ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995239; c=relaxed/simple;
	bh=cI06cWMeiiaaHvVrivHUrUMAP27szVAGIwpicbm6Rjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVSr9gKgXgMJxsYZCz8LNpSPyxgQ0274mR2VPjzAfieliUyN7G89qOzkDkEks5mGBiExrYD8LuWeoH6FITWOWPqJ5DZ11E08xELBaXukieRshKEbnRkPBlFIO0MuIiXNScV/hm3oWo9CufSpwDqfzz24PKfPBA+sAlstGC4H/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW/pJovT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c19d338401so1172442eaf.0
        for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995236; x=1719600036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=WW/pJovTrMxVoUJCWqWNuEmgUHsKG8R4Aq4hJO57rw+3P649TtXTb2+c0omQMINVa4
         J+z1R+rQ6qHFOkHPkReJcySxmMIDTN67RQEun5b4cfP63gc6nkYoGMqfj66vSZ7cd5ez
         85wUIRLMg/ZGBP95g6I7YbvrMlvnYWYTD0ETWXOzksDoD5ku/9VQ2PCm+Ra1PnOhtNc2
         QHGMkCe90uZ7xaYOsVnHJZ+LNv8L95ebxuua1CgS/zJzmki5OKPXpSiPA04WA3IHy9cC
         BnfPA0FkVYhF8ag1hGMgXYe167SL+unl+qcoJzx4SCL86tct76pzICcryIeufPHxYdkX
         RmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995236; x=1719600036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Duz+R7OD5yozyO0xOdsWZmjZsXtc7sydmF+n4fo7yxk=;
        b=Om/xs64P7KsvLZWWWUTIPi70lHMwfHosYkagNSzxGHGE7q8sT2+FZUwrvXeDUYNbiZ
         4WQI67ZnwoBtZsOKdWik1/EDTcEQZ6Hzb2odIfHVaI/40IsS3+XoW9h8KQ9fi/XIOMyM
         atEEffVUK6jFANx7+o5QmTPUnMkRNT7wmmWaM4KT/LpbEJLK+EhdfwxvwFKWMn0WKzil
         WDaFjNUFCyGIVz9DvMNUnvEEWqgg6brYkFjVBalsBK1cCZH1TT6oReHhOB0grpq6+jea
         E7p6zJvFOVi45T1vi4Dy945b37rq46KicibTAmGHUoV1KOIyUF/zcAy1nkzuuZtioz9p
         HNmA==
X-Gm-Message-State: AOJu0YzPUW7ZQOYLrOa1YdC8IFy4mlP95aR2bpkVMaFbWNXXPD1L4HQW
	7z0X1ijOzWSM6LeQOayu5SY32v9CMfSYJiPn4QFo8wzkOzuNGwLTeq50Tw==
X-Google-Smtp-Source: AGHT+IEElhGP4SyDwI2vFwFMs21TmOSGUPY1gFHuDyf4s+3m6eaQlGzSfEBUhrjw/qomlW4lFa5P4A==
X-Received: by 2002:a05:6358:7e41:b0:1a2:1344:e753 with SMTP id e5c5f4694b2df-1a21344e974mr601779555d.25.1718995236335;
        Fri, 21 Jun 2024 11:40:36 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1443984a12.31.2024.06.21.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:40:35 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: netdev@vger.kernel.org
Cc: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 15/15] net: mtk-wed: Convert tasklet API to new bottom half workqueue mechanism
Date: Fri, 21 Jun 2024 11:39:47 -0700
Message-Id: <20240621183947.4105278-16-allen.lkml@gmail.com>
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
APIs throughout the mtk-wed driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 12 ++++++------
 drivers/net/ethernet/mediatek/mtk_wed_wo.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 7063c78bd35f..acca9ec67fcf 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -71,7 +71,7 @@ static void
 mtk_wed_wo_irq_enable(struct mtk_wed_wo *wo, u32 mask)
 {
 	mtk_wed_wo_set_isr_mask(wo, 0, mask, false);
-	tasklet_schedule(&wo->mmio.irq_tasklet);
+	queue_work(system_bh_wq, &wo->mmio.irq_bh_work);
 }
 
 static void
@@ -227,14 +227,14 @@ mtk_wed_wo_irq_handler(int irq, void *data)
 	struct mtk_wed_wo *wo = data;
 
 	mtk_wed_wo_set_isr(wo, 0);
-	tasklet_schedule(&wo->mmio.irq_tasklet);
+	queue_work(system_bh_wq, &wo->mmio.irq_bh_work);
 
 	return IRQ_HANDLED;
 }
 
-static void mtk_wed_wo_irq_tasklet(struct tasklet_struct *t)
+static void mtk_wed_wo_irq_bh_work(struct work_struct *work)
 {
-	struct mtk_wed_wo *wo = from_tasklet(wo, t, mmio.irq_tasklet);
+	struct mtk_wed_wo *wo = from_work(wo, work, mmio.irq_bh_work);
 	u32 intr, mask;
 
 	/* disable interrupts */
@@ -395,7 +395,7 @@ mtk_wed_wo_hardware_init(struct mtk_wed_wo *wo)
 	wo->mmio.irq = irq_of_parse_and_map(np, 0);
 	wo->mmio.irq_mask = MTK_WED_WO_ALL_INT_MASK;
 	spin_lock_init(&wo->mmio.lock);
-	tasklet_setup(&wo->mmio.irq_tasklet, mtk_wed_wo_irq_tasklet);
+	INIT_WORK(&wo->mmio.irq_bh_work, mtk_wed_wo_irq_bh_work);
 
 	ret = devm_request_irq(wo->hw->dev, wo->mmio.irq,
 			       mtk_wed_wo_irq_handler, IRQF_TRIGGER_HIGH,
@@ -449,7 +449,7 @@ mtk_wed_wo_hw_deinit(struct mtk_wed_wo *wo)
 	/* disable interrupts */
 	mtk_wed_wo_set_isr(wo, 0);
 
-	tasklet_disable(&wo->mmio.irq_tasklet);
+	disable_work_sync(&wo->mmio.irq_bh_work);
 
 	disable_irq(wo->mmio.irq);
 	devm_free_irq(wo->hw->dev, wo->mmio.irq, wo);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 87a67fa3868d..50d619fa213a 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -6,6 +6,7 @@
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 struct mtk_wed_hw;
 
@@ -247,7 +248,7 @@ struct mtk_wed_wo {
 		struct regmap *regs;
 
 		spinlock_t lock;
-		struct tasklet_struct irq_tasklet;
+		struct work_struct irq_bh_work;
 		int irq;
 		u32 irq_mask;
 	} mmio;
-- 
2.34.1


