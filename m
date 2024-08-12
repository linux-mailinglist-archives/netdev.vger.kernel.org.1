Return-Path: <netdev+bounces-117818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6694F739
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942DB1F21165
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B084192B7A;
	Mon, 12 Aug 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUEDR1vZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6751191F64;
	Mon, 12 Aug 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489627; cv=none; b=bBsC1TtXjhPcei6+cPcM44Cfz7tKF8LUvpyXmm4v8p9wqINm7UYQfcz13LQs6ReSylvCcLKhpYR7FkxMIB5OH2dlmLombmZav+Lxha2vYSq8ll1KLtzCURkUYH3QAE9Em+TuKrEEaWlTp3OB0l3Aj6i/o5TKXrZtaIO1YiEiPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489627; c=relaxed/simple;
	bh=PmfjsPkwoMyKZmnVipaJf4BtNbSMO6r4u2FqsyAYGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKQKZHwB5PU+rm5c3il8G+gWrPbmEmLZ3/PcwS1/FJFv2IOshhGHVSKs4yagbJBNh9H+LTgl5cELBlkJBrnXAStZEhBjmi6SHe726XbrIbFk/PFyJdduCX2y0SChUOAExx+XPfGwq6DH9OKFLOgXgdxvsOROqvc9znFQOVSpu/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUEDR1vZ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5cdf7edddc5so2478159eaf.0;
        Mon, 12 Aug 2024 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489625; x=1724094425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyIBQiEnxSsXMSN6/sunCSyG3lR9BUjpwKs0G0nNSww=;
        b=YUEDR1vZ+1A7UVCYZZ6GX/xNcUHN0yrg5TxOxgjL515xVebmZBxly4YKeB482ZVhEu
         AUQLRMq9T1wR1X22gwyDuIoiaIXW6fchJ8h7WYtoUI93TtAmRXbbKQyMXe7pNekmr0Ii
         rMiGWpQcU4rao/d6Hjr7gK7K9cvjcu4DETUkooTWy0EBCkLvFSfo5cux8Q5pJSjdg5Ol
         MfvuT7CaFkqKf0gxdFcmGhWXZ82AnzupfDo2YN9GUG3KFLVyqxn7cohrDErMYUliT0kz
         2q/bAofeoXNNj2bpZ4OdwdqSZfOhhyKT8tXl6fP7s8nl7GTsig7E4O7YVmm4hy4/GZYA
         Wf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489625; x=1724094425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyIBQiEnxSsXMSN6/sunCSyG3lR9BUjpwKs0G0nNSww=;
        b=F7D62iry3muwAskdapbMqekSZ/aGl9MlNG+fLkfNodWzijETfTNmemVEaYkZj84Ahp
         TvRkN3nStQWMgatS7lOTV1OlzlLAvTnNKxwcx1ApaKkfArxKxRtgNEIf/zFCVt9hBob6
         blIIw43oqeRc6lzscV0ma9+bA4llD/npejgJwhFRBUGVYXrenv6myym/7S86EA0VSLAg
         iGVPwnBIP0P8TO3sH3c7odfNSWajSGNEbvJ5sdoaQa599c2xx6DAdp5k/fkT/cP29Q6q
         BoGF9npkLq8uWJWVClIaUTzbToOkoVRfcrWiZ4KzAZVqSc8ZLZT+9RkuohLJBB0deTxx
         gmVg==
X-Forwarded-Encrypted: i=1; AJvYcCV+d311U8B2slZi+lLpEzi//6yalbXfBGF16MC2tI/E44veqCdxfZfCgOHX64/Y3KV50x4QZP/GNSC/EX9/slAifW1H2z8gP59I3Lv9
X-Gm-Message-State: AOJu0YydjJE0SmqkEZwbeG2Z91WK4sj0eoerTX5Jd/s5oJcKtk6hq46K
	5qWbzKX3mWfIbGy+/7RovQDIws6i0zIc6cVgpAEfMg85mDVR/MOXNvRKqaAX
X-Google-Smtp-Source: AGHT+IFKu35adwBoGSuqDhdo+vOlDK0+wmUIMg3DQdvAG7JFaHhp+AGQqyM36NetOkpmCzrtG6JMrw==
X-Received: by 2002:a05:6870:158b:b0:261:bca:4ac4 with SMTP id 586e51a60fabf-26fcb61d82fmr1329195fac.9.1723489624760;
        Mon, 12 Aug 2024 12:07:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a7facsm4334495b3a.59.2024.08.12.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:07:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next 1/3] net: ag71xx: use devm_clk_get_enabled
Date: Mon, 12 Aug 2024 12:06:51 -0700
Message-ID: <20240812190700.14270-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812190700.14270-1-rosenp@gmail.com>
References: <20240812190700.14270-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removal of clk_prepare_enable to simplify the code slightly.

Tested on a TP-LINK Archer C7v2.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 31 ++++++---------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 6fc4996c8131..c22ebd3c1f46 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -691,7 +691,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	np = dev->of_node;
 	ag->mii_bus = NULL;
 
-	ag->clk_mdio = devm_clk_get(dev, "mdio");
+	ag->clk_mdio = devm_clk_get_enabled(dev, "mdio");
 	if (IS_ERR(ag->clk_mdio)) {
 		netif_err(ag, probe, ndev, "Failed to get mdio clk.\n");
 		return PTR_ERR(ag->clk_mdio);
@@ -704,16 +704,13 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	}
 
 	mii_bus = devm_mdiobus_alloc(dev);
-	if (!mii_bus) {
-		err = -ENOMEM;
-		goto mdio_err_put_clk;
-	}
+	if (!mii_bus)
+		return -ENOMEM;
 
 	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
 	if (IS_ERR(ag->mdio_reset)) {
 		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
-		err = PTR_ERR(ag->mdio_reset);
-		goto mdio_err_put_clk;
+		return PTR_ERR(ag->mdio_reset);
 	}
 
 	mii_bus->name = "ag71xx_mdio";
@@ -735,22 +732,17 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	err = of_mdiobus_register(mii_bus, mnp);
 	of_node_put(mnp);
 	if (err)
-		goto mdio_err_put_clk;
+		return err;
 
 	ag->mii_bus = mii_bus;
 
 	return 0;
-
-mdio_err_put_clk:
-	clk_disable_unprepare(ag->clk_mdio);
-	return err;
 }
 
 static void ag71xx_mdio_remove(struct ag71xx *ag)
 {
 	if (ag->mii_bus)
 		mdiobus_unregister(ag->mii_bus);
-	clk_disable_unprepare(ag->clk_mdio);
 }
 
 static void ag71xx_hw_stop(struct ag71xx *ag)
@@ -1845,7 +1837,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ag->clk_eth = devm_clk_get(&pdev->dev, "eth");
+	ag->clk_eth = devm_clk_get_enabled(&pdev->dev, "eth");
 	if (IS_ERR(ag->clk_eth)) {
 		netif_err(ag, probe, ndev, "Failed to get eth clk.\n");
 		return PTR_ERR(ag->clk_eth);
@@ -1925,19 +1917,13 @@ static int ag71xx_probe(struct platform_device *pdev)
 	netif_napi_add_weight(ndev, &ag->napi, ag71xx_poll,
 			      AG71XX_NAPI_WEIGHT);
 
-	err = clk_prepare_enable(ag->clk_eth);
-	if (err) {
-		netif_err(ag, probe, ndev, "Failed to enable eth clk.\n");
-		return err;
-	}
-
 	ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, 0);
 
 	ag71xx_hw_init(ag);
 
 	err = ag71xx_mdio_probe(ag);
 	if (err)
-		goto err_put_clk;
+		return err;
 
 	platform_set_drvdata(pdev, ndev);
 
@@ -1962,8 +1948,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 
 err_mdio_remove:
 	ag71xx_mdio_remove(ag);
-err_put_clk:
-	clk_disable_unprepare(ag->clk_eth);
 	return err;
 }
 
@@ -1978,7 +1962,6 @@ static void ag71xx_remove(struct platform_device *pdev)
 	ag = netdev_priv(ndev);
 	unregister_netdev(ndev);
 	ag71xx_mdio_remove(ag);
-	clk_disable_unprepare(ag->clk_eth);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.46.0


