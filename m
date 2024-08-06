Return-Path: <netdev+bounces-115934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB566948760
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 04:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960E328582B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA4AD5E;
	Tue,  6 Aug 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLOX3o62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920976FC3;
	Tue,  6 Aug 2024 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910607; cv=none; b=hqzvugwaAGauumTMSBMZmPiFpfxv0E5NCQ589th3rnQg/rvhe9y/T1BKq0/OKDGOr+OCuT9O9juGKu7YrD2/la30e8a9bOU2txOfk21b+hcWN8Hk/4oDBjooDd7id0KPShc0+8HtIyZUtf/6fyL8uTuUIp1NkklsVsy9PaY4OPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910607; c=relaxed/simple;
	bh=ebSWJSj/buxW44/rQoQph4W+aePCGg6KpmYyKZK1snY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qR5CMqjd+kA3skC3drdhC1mH8ZRI5VALyKXqrN9iaVtkaspQDcAidubL6o+0JUtCOiV57ZcDna+9aq8ALjQl9AlecrochmeIf7yzC8O/OxR1DVh+XogY/ow0iY4v0I+anVfII58KIclkZywJFAvHy36JCT42uT677aYj/8Wa+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLOX3o62; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fdacc4129fso56835ad.1;
        Mon, 05 Aug 2024 19:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722910605; x=1723515405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7mvtGZEsuHPzWX3pW4fYKh4Cjh9maArqhFHH/gvuGQ=;
        b=XLOX3o62pxoWuviVbBdJtPthPCgPAfXVRvQoyWVxmzUshThtmNwBdZJvc0lrzU4Owq
         2wD4tg7YxS/deJujva6dqirXdDjVqsAn68t3bxsz26VPbYbRJkaeCAZGFanQ2mZ1ArYM
         YcsUfITjsl6NyPoMx3WymRZIYj5VavOCDuN0Z0ENFEGQU0ssPDwsagVL5G3pcnPS/m25
         7unbNMRIKhpAvyCfZyAZaJfIl58xhIXEgpIebY6ID/0Qdxob2uFpOXURhnpw3NyJoKde
         lYUWB4XOw+kI40mlSN6LRwVUYQGM85uDMFUwoczIUplfGTQYITiI7U9DZFX77cjo1wLZ
         2VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722910605; x=1723515405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7mvtGZEsuHPzWX3pW4fYKh4Cjh9maArqhFHH/gvuGQ=;
        b=WAddRhowbTRVn8FzmALfpz9ic4LIhZ8dbhd6iq+tmN+Gq+26WX4F1mOrY69LJE0yrt
         49EeVC6ZxqisFVIR4DbEOz61V687dQajGZiEbzMlju9D1ORzFYz2Kpo+z+HhksIbgxhQ
         aXoNwazHvsulrz5M4mz3oZPfrh4YSH0o+iaFiuwkN0qxavUiLpoqpZISXcdATNNSAgYk
         V0GoQk5wqqPVfogabqDeykHNGhFkKEMQ4xGAEQVj3usQ5yLUP2/jWlWcDR4Uasxp9QK+
         G9eG3HICDLHSvztPipseCTTPYxaxrqxlW/rXwPbH+D9B47TWnFpEIx/+19o6+f8Yt0Lp
         93Qg==
X-Forwarded-Encrypted: i=1; AJvYcCU5vCn+nH0Jc0anXn3dsMsIRlhSfn3xe4/wcdbFCIpni2i/W+LerRJFhwpcRZ+VFXlOt1wn9ktH@vger.kernel.org, AJvYcCV+tp1bWEwre5ziu3gqZsZYtU2w1jymHluNxd2zeOZrPPHENlm0Jfoze0M9Veoy9q77nfr+0uG8EB+mlto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nVpI3er4OuPAJLeRxjcBoBafW2aKF4RLS1TpJIa8aV/bIGM8
	QXl8U8qQcSpXpnomxPqasvQ1mui+Ny8zyrDrWaWe1aptFNUqra2I
X-Google-Smtp-Source: AGHT+IFGIIZ+nhDuGefYZ1y1WVR21yakH6dk3osLDORN1mCGnbZ1+JngnuuwyDq0uaosvESzYiK9fg==
X-Received: by 2002:a17:902:d505:b0:1f7:3ed:e7b2 with SMTP id d9443c01a7336-1ff570f16cfmr91474625ad.0.1722910604865;
        Mon, 05 Aug 2024 19:16:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3668:14ca:30e:638f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929ac42sm76095385ad.267.2024.08.05.19.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 19:16:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kuba@kernel.org
Cc: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH net-next] net: fec: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
Date: Mon,  5 Aug 2024 23:16:28 -0300
Message-Id: <20240806021628.2524089-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.

The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
allows the compiler to evaluate if the runtime suspend/resume() functions
are used at build time or are simply dead code.

This allows removing the __maybe_unused notation from the runtime
suspend/resume() functions.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a923cb95cdc6..8c3bf0faba63 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4606,7 +4606,7 @@ fec_drv_remove(struct platform_device *pdev)
 	free_netdev(ndev);
 }
 
-static int __maybe_unused fec_suspend(struct device *dev)
+static int fec_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -4659,7 +4659,7 @@ static int __maybe_unused fec_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fec_resume(struct device *dev)
+static int fec_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -4714,7 +4714,7 @@ static int __maybe_unused fec_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused fec_runtime_suspend(struct device *dev)
+static int fec_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -4725,7 +4725,7 @@ static int __maybe_unused fec_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused fec_runtime_resume(struct device *dev)
+static int fec_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -4746,14 +4746,14 @@ static int __maybe_unused fec_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops fec_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fec_suspend, fec_resume)
-	SET_RUNTIME_PM_OPS(fec_runtime_suspend, fec_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(fec_suspend, fec_resume)
+	RUNTIME_PM_OPS(fec_runtime_suspend, fec_runtime_resume, NULL)
 };
 
 static struct platform_driver fec_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
-		.pm	= &fec_pm_ops,
+		.pm	= pm_ptr(&fec_pm_ops),
 		.of_match_table = fec_dt_ids,
 		.suppress_bind_attrs = true,
 	},
-- 
2.34.1


