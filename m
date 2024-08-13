Return-Path: <netdev+bounces-118137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FED950B17
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDC0B2186D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F226AC6;
	Tue, 13 Aug 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVzvZU/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDD37E;
	Tue, 13 Aug 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568733; cv=none; b=Tvfjef9fcokQg+zRu4mhLw5dV7j/1rJbiSSFwnLBsFPshJ/VYq9+ug2mRT0xMEAtXI1xRJrbUu1axDXeZyV5ra/ykbCqCVOAiKc+RK9c3WtUpqsaS10IyYoxrW7rTFPd/XSh+iBvLw/lphZJKPik/uHDVcasCWXlAqgiiOHA4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568733; c=relaxed/simple;
	bh=li6ot2ljL+bgvf9jRRm9Sp0DTwQJSC5oDY9A48rydas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbPjpnfkq2KbMzVkZr7W3v2IY1NxdKRUiIv1KF8HUMr/ifC3rmne08XNuht0eis+7+XEX/a9LRZHbgMu3EYPeFvhy+7wgvXq59Blqm+FcLYYMgedZB8tn1Jj+4Vo6zZd8dJlzeqYIRzlhZceMB4O+L2wCFolXgVYEcapsHBcTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVzvZU/z; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1e4c75488so344633685a.0;
        Tue, 13 Aug 2024 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568730; x=1724173530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vES9TC9dqxR38Zom8cCTR4Q9JQRRx8777KIJEbij9E8=;
        b=AVzvZU/zEiO2KkxCKcumO13Q4bSkaYmMj4mkss9b/7yVALEWrOngBBfQ8I+Ko1V2Bl
         nilmkW2w08dIBpyWzSMrZUanp2OfRMkK/xtphP6KuaOk9Jy3cyGY100DdxJtsN8LB3MZ
         ByHbJBymE55bntA4m7DKbZwbqSXZ917HuBDJo8428VRzgXpp79gHQxQ0Psv9veheElCr
         1M0Qr2jGbkjPs1xMPvcdk5LenMHLyXvPL/arwLPD2yTwLLDOb7K82Z7IP6VTU+sZ8L46
         vSb+cmDawRXLUtrED12oaLKoCfMDOeEQj4mrysYhd+ucIkJAs7cvDOhQk8q63DtzweiH
         aGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568730; x=1724173530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vES9TC9dqxR38Zom8cCTR4Q9JQRRx8777KIJEbij9E8=;
        b=kaypTkSDCdSzOSR2xHo9aOUUxtmHaODZFNVj06KkTqzt3ra7CaS8UPj3Mxy2I1upv7
         iGglGZkzaGTy8Rjld4FD7am4wUQmAOijhmIV9RBy2jxf1sGm81zQocJdJeyP/sKNzq+8
         Oz6emV5UltCKs2cOvpxifkq++pIOr3f2TD65Q5QnZ7h/x5UBdad0w855Gt3BVjmvcHJ4
         WcU31IneRaA6sTJnXZsI0k3+nzNs1+kFpVjcfTdgtX6Wgrn9rweLPupTaYKxAJnGXqhA
         SJIPmYbkRknrNs0U/SWeb6eGQNUOeWs/BvLqRdpTUAKMdShM0ec3RQ7oUsXCDZzxGq1V
         jqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGpvFsCTw7IqilxVZJogx7c5ah505n67fBcbvhc/apjldGzDeMYeOe5F+1NHwUlW0BxHE3laOI3ugtzcgPfa6OMMN9e+c1gUzz9b80
X-Gm-Message-State: AOJu0YzqTCg8oCa79pYMjfV1XytKDV65yGcHQcxcDw3sDffJtLD1l99a
	RN0ZgYc3scKfi4i3N08sZ/jCXaBzQGzghRH+DZjKHPPFWUzgo8BsCl32rq2d
X-Google-Smtp-Source: AGHT+IGFbjA1+xKemYdWOqR1BhN9JsERfAczIqba/7HmKM5wzTEvTHSZTPAfxsLTvNz48JlWNkZZ4g==
X-Received: by 2002:a17:902:c94d:b0:1fd:a360:446f with SMTP id d9443c01a7336-201d65c0d14mr2116465ad.65.1723568719484;
        Tue, 13 Aug 2024 10:05:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a947fsm15946425ad.140.2024.08.13.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:05:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next v2 1/3] net: ag71xx: devm_clk_get_enabled
Date: Tue, 13 Aug 2024 10:04:57 -0700
Message-ID: <20240813170516.7301-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170516.7301-1-rosenp@gmail.com>
References: <20240813170516.7301-1-rosenp@gmail.com>
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
 drivers/net/ethernet/atheros/ag71xx.c | 37 +++++----------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 6fc4996c8131..e46d10a5c28c 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -691,29 +691,20 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	np = dev->of_node;
 	ag->mii_bus = NULL;
 
-	ag->clk_mdio = devm_clk_get(dev, "mdio");
+	ag->clk_mdio = devm_clk_get_enabled(dev, "mdio");
 	if (IS_ERR(ag->clk_mdio)) {
 		netif_err(ag, probe, ndev, "Failed to get mdio clk.\n");
 		return PTR_ERR(ag->clk_mdio);
 	}
 
-	err = clk_prepare_enable(ag->clk_mdio);
-	if (err) {
-		netif_err(ag, probe, ndev, "Failed to enable mdio clk.\n");
-		return err;
-	}
-
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
@@ -735,22 +726,17 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
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
@@ -1845,7 +1831,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ag->clk_eth = devm_clk_get(&pdev->dev, "eth");
+	ag->clk_eth = devm_clk_get_enabled(&pdev->dev, "eth");
 	if (IS_ERR(ag->clk_eth)) {
 		netif_err(ag, probe, ndev, "Failed to get eth clk.\n");
 		return PTR_ERR(ag->clk_eth);
@@ -1925,19 +1911,13 @@ static int ag71xx_probe(struct platform_device *pdev)
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
 
@@ -1962,8 +1942,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 
 err_mdio_remove:
 	ag71xx_mdio_remove(ag);
-err_put_clk:
-	clk_disable_unprepare(ag->clk_eth);
 	return err;
 }
 
@@ -1978,7 +1956,6 @@ static void ag71xx_remove(struct platform_device *pdev)
 	ag = netdev_priv(ndev);
 	unregister_netdev(ndev);
 	ag71xx_mdio_remove(ag);
-	clk_disable_unprepare(ag->clk_eth);
 	platform_set_drvdata(pdev, NULL);
 }
 
-- 
2.46.0


