Return-Path: <netdev+bounces-71240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64930852CD4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE585B24A30
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16341C72;
	Tue, 13 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mrKxNdLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F938F88
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817307; cv=none; b=jQ1aB/ia3X5FcyMGtIJSUes7iBrTSav15la+qmNfxROxoNVZiuog4H00zVQpePbSTzzXBvCdQbhv0b0KiDiX9oOYZQ4p3QKcp5vE4OyITWySyyjhsvSW6EG+IPs/0ZGlNRNtuubaFrnEXLkqx/LXX3uotc4h/fq8uYPu6S5Cdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817307; c=relaxed/simple;
	bh=L6m3PaHcpH7fTAmCpzJxhaBYogFtv5x2tXcok6WfMQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGMK3LHcQEwzvsf6gbS35EkwE4SrTbHzmTJRE9wMDO/tRCI4Aikn3XskzGnd/te5JsLcCGWD/U0qMrXBPkEj2LpVnmOIdfGtO3t8NWNIyeUxyfq7NYVqDAyZsTJV+Gt7uieTVe4Gf4uWBeh9KKZXAYqKMjdunD7Ra3gEq1LjIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mrKxNdLb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5116b540163so6022631e87.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817302; x=1708422102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTm27U9imY+diMQ+Cfy3KOx1XX4gyrrNl9Sty+DsGIw=;
        b=mrKxNdLb7i/l8a7tAAHtIRj/hsQhCoC15dts+sckLCqVwww+GCWFFwJWi+5xc7pKQn
         dp5SVHdRVA5WthHAuGx+CAHS34vOSFJjmVCBP6w98spy0duaDIawq3RWeZztc8oDU/5P
         T0uOUdgzwkG3+XX09OFswYBbgwoIzRH6eb+CtlBYDA7N7pluOG2thJWZwHhZL8QQpKjz
         LJs6tXeyo7+4F24n3fshfGl8AJNTWb5wgd8+Lr0hxVvmXuO0uNI5S9DLAKEF008eIZ0l
         qRSIVT3hHpOBbsdcFlYJl3UE6wCmljeok1XZXGGY3kQvX8Yef3O1sUi1RD284Gv8sKNb
         pjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817302; x=1708422102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTm27U9imY+diMQ+Cfy3KOx1XX4gyrrNl9Sty+DsGIw=;
        b=G71vTLNkRHKAr2fSgxQLdvQjeeewOelm/cZri3OZFG6rdxvH622FPohVi7z3ohYz5U
         ys9g3DdDqfGcHbBoyIUXprOsOAUo3BUYrMF8aAqRMBUNffZGWCHBnpNXG0waxS/TxgDD
         /5/b01UiAZ9Bg4Im1BTiWNdEGVgJRc4v5EF+YRF6HHFHmPgM8m4HCNUIgxUfZ7UBOkss
         HgV0AzfHBS519bY6WXwLOKF7qGxMZmGiS5zKyNp1inZp16C9ESlzirKb3HHaZVICxFfA
         9LNJipXom4fpGO9Lf+ck1JUoRdHBjh0siPaKs9LMi/sL+6IU11+Nw0TG/O3m3OzZWEaq
         bhRw==
X-Gm-Message-State: AOJu0YxFn4dY7EruRYfnLxMmZTdSNI4yCquL0aFcmC+mOcKMjL5FyNi9
	ftYmiTUD+35wummZHXxbNVEJPx4vq9uB6NNRa4CHpqZDYvqgkzjcPpcHYQ3jTtA=
X-Google-Smtp-Source: AGHT+IE6D7Ce4N4r0UsSCIlgDzqSmtZZx+1V8jIgoXg7ggocUWeATBSiw36gJjy8YajyPEN0PECjuA==
X-Received: by 2002:a05:6512:33cc:b0:511:75e2:6b5e with SMTP id d12-20020a05651233cc00b0051175e26b5emr7171150lfg.36.1707817302073;
        Tue, 13 Feb 2024 01:41:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjyHUR8jchFQdRr8F1L8nPt1dQno6MxmexiRb08RAy4xTMgBKVPT3usunHLtuz/wIcTmSdf3AAEbXhvyljapHU2VeLsXWN4mwuF8zL32zg7nsgUu0oAGPS1iHB964cw74Q4aj4xX0cEkjQlHTvMr6QQobIrIDRU2gwhyJRY1S4naFO40Rk/uaqEwagRzYbXR91NI3NTUtu5g4E5jNL2VcbPMRopQFamz1Ybeqh/pCZPgkPFjvor3cadv9sbJqNUaCuk3G0AzIVyDdJSeFHQB12+AIbPFrWUROzC2ZiowVgjllxtJ2rGMlncepbeZHw6XswzBg4qUfvwLZ/3WDzSXqT/mdUzWzTvCcHDCzeeOxNiMkNesQi
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 1/6] net: ravb: Get rid of the temporary variable irq
Date: Tue, 13 Feb 2024 11:41:05 +0200
Message-Id: <20240213094110.853155-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The 4th argument of ravb_setup_irq() is used to save the IRQ number that
will be further used by the driver code. Not all ravb_setup_irqs() calls
need to save the IRQ number. The previous code used to pass a dummy
variable as the 4th argument in case the IRQ is not needed for further
usage. That is not necessary as the code from ravb_setup_irq() can detect
by itself if the IRQ needs to be saved. Thus, get rid of the code that is
not needed.

Reported-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v3:
- collected tag

Changes in v2:
- use a temporary variable in ravb_setup_irq()

Changes since [2]:
- this patch in new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f9a1e9038dbf..a1bf54de0e4c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2747,24 +2747,27 @@ static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
 	struct device *dev = &pdev->dev;
 	const char *dev_name;
 	unsigned long flags;
-	int error;
+	int error, irq_num;
 
 	if (irq_name) {
 		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
 		if (!dev_name)
 			return -ENOMEM;
 
-		*irq = platform_get_irq_byname(pdev, irq_name);
+		irq_num = platform_get_irq_byname(pdev, irq_name);
 		flags = 0;
 	} else {
 		dev_name = ndev->name;
-		*irq = platform_get_irq(pdev, 0);
+		irq_num = platform_get_irq(pdev, 0);
 		flags = IRQF_SHARED;
 	}
-	if (*irq < 0)
-		return *irq;
+	if (irq_num < 0)
+		return irq_num;
+
+	if (irq)
+		*irq = irq_num;
 
-	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
+	error = devm_request_irq(dev, irq_num, handler, flags, dev_name, ndev);
 	if (error)
 		netdev_err(ndev, "cannot request IRQ %s\n", dev_name);
 
@@ -2776,7 +2779,7 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	const char *irq_name, *emac_irq_name;
-	int error, irq;
+	int error;
 
 	if (!info->multi_irqs)
 		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
@@ -2799,28 +2802,28 @@ static int ravb_setup_irqs(struct ravb_private *priv)
 		return error;
 
 	if (info->err_mgmt_irqs) {
-		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "err_a", "err_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 
-		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
+		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", NULL, ravb_multi_interrupt);
 		if (error)
 			return error;
 	}
 
-	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
+	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", NULL, ravb_nc_interrupt);
 	if (error)
 		return error;
 
-	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
+	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", NULL, ravb_be_interrupt);
 	if (error)
 		return error;
 
-	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
+	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", NULL, ravb_nc_interrupt);
 }
 
 static int ravb_probe(struct platform_device *pdev)
-- 
2.39.2


