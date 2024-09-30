Return-Path: <netdev+bounces-130539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0898ABEC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFA01C22C1E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114719ABBD;
	Mon, 30 Sep 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwjDx+b5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F2199FCD;
	Mon, 30 Sep 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720311; cv=none; b=k/FUnmsSx0Epkv2ldmDI1JCOcKa4Wi+X3qq6riOc1uubLXIgGy1hqolavarmy6RNuIhBxLEd87ovx0LGIF4vrU7Hrr2wP1FkjikcoTM9CIizH5828rTln6QMNSvtiOyzqae8SGltak3q/2TZiAtM/RsDErEoZ0Ucb0loi/lO34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720311; c=relaxed/simple;
	bh=J2w0NK0mEOp+LmcZQ6HcXuYL0pgsoyNbTzZX+qkTdSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0m4gi4jLafaDtFbKebnpWmawsfb7zglKU8o/VlU1fGXDtIAICVI+aXglmjP6mMC66MDMYm8145uYrOPFxx8kk739D9N8g6ggGPLV2r2HSeomMBP5kPTsEoQykODM4EB/MN4UxSMhtIbfU3T8K2TfNBY9X/meUA2UchiVgJr4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwjDx+b5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b1335e4e4so42728825ad.0;
        Mon, 30 Sep 2024 11:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720309; x=1728325109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPUoZMLAK+WibpLUoFoyAZDdX6Yikvf8jxcRrCws23I=;
        b=dwjDx+b5li8+HOzXZecXbPjEzr2C65J1tuLmlOYWyoP3TG+sYAjEAw7C5F4lT/yUrl
         C4YKnezC2FVhz0pMoxSrGgo7wZ5+glFkKylZzrj9JRWKv3gnZV5tMo6oI51GDkp3nKXx
         HqK3QDmam7a2gsMDxQgygR6GDfCalBVNctygHOZ2BvII3zXsgBIKN6rjqNeZUUU2OjPE
         l89T1P+0ru+MvSYyRx3t/+qQy9sTY/81R++RKSRIdsxruMZyI6xfMKeRPPU1GTiY7iPW
         ZHV7rebGGuVXeSZwhvVC2HX77Gr9yrvAxtZ16fWSZEUUCUWnE8U1xzyrTSOCjfvvihHc
         WDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720309; x=1728325109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPUoZMLAK+WibpLUoFoyAZDdX6Yikvf8jxcRrCws23I=;
        b=oxAXhBIZozVUFX06BWnFHr0amJzNcNtIxK8OnvZBl1cl2MBu2/7yd8nyVXRO0c5UEy
         LlCqTjP05AzaWS2/3AVrvUd8RYRsUppJcs3sJF7uXK0xmafhXTCqXUYJ8foaWCYecUAc
         HPxcurg1JRwWP6seZnusfYSpjEKPVlPeQkAkQJbvbr9pjbTGwaEslBHZHMxJgYGP51L3
         3dNBbScEQ5k3s3Wx6SgAObvNcjeWN7P0Fy3B+WCv1DC3DRcIbFZLosy9nroxi41fUWe8
         DD/jQkDOEWxQwSGo5pQOLyWhzCvsc7uCCXEqFPYb7gOTetjvPk8Un9Ech0pDX0pmEBLT
         TnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwolqVTkys6uyk6oSv1qf3mGKYvk/H7eTp7iV48AP52zu02WQ9xPXmzzRlwkd9msDSZhHwocceicjEPss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNE/bku0tNi11pHIHzLzrZHyv24DbA6VTqUXtjd1N6wvItnlo
	Z1GiZqVHzUQQh1c7XzcusqDe7difD+JAM0EPTCLlMpFLJ3HoDvJI4/jJV95I
X-Google-Smtp-Source: AGHT+IHZXpE14UMKh+i8Ji81+V/x+oL4tWR1eYeUjhIBxCMZ8CMfbgZ3rcEAjy6eCcfpd1VmpC11Zg==
X-Received: by 2002:a17:903:2285:b0:20b:6d5c:8ed with SMTP id d9443c01a7336-20b6d5c0b9dmr87195915ad.61.1727720309072;
        Mon, 30 Sep 2024 11:18:29 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 2/5] net: ag71xx: use some dev_err_probe
Date: Mon, 30 Sep 2024 11:18:20 -0700
Message-ID: <20240930181823.288892-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
References: <20240930181823.288892-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions can return EPROBE_DEFER. Don't warn in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 9c85450ce859..195354b0a187 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1822,10 +1822,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 	}
 
 	clk_eth = devm_clk_get_enabled(&pdev->dev, "eth");
-	if (IS_ERR(clk_eth)) {
-		netif_err(ag, probe, ndev, "Failed to get eth clk.\n");
-		return PTR_ERR(clk_eth);
-	}
+	if (IS_ERR(clk_eth))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk_eth),
+				     "Failed to get eth clk.");
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
@@ -1836,10 +1835,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 	memcpy(ag->fifodata, dcfg->fifodata, sizeof(ag->fifodata));
 
 	ag->mac_reset = devm_reset_control_get(&pdev->dev, "mac");
-	if (IS_ERR(ag->mac_reset)) {
-		netif_err(ag, probe, ndev, "missing mac reset\n");
-		return PTR_ERR(ag->mac_reset);
-	}
+	if (IS_ERR(ag->mac_reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ag->mac_reset),
+				     "missing mac reset");
 
 	ag->mac_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ag->mac_base))
@@ -1920,10 +1918,9 @@ static int ag71xx_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 
 	err = ag71xx_phylink_setup(ag);
-	if (err) {
-		netif_err(ag, probe, ndev, "failed to setup phylink (%d)\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "failed to setup phylink");
 
 	err = devm_register_netdev(&pdev->dev, ndev);
 	if (err) {
-- 
2.46.2


