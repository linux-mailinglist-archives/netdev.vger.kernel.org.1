Return-Path: <netdev+bounces-130626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010898AEE7
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A248C1C213FC
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B7199EB1;
	Mon, 30 Sep 2024 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOR+313s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38DBEDE;
	Mon, 30 Sep 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730994; cv=none; b=baSCJC++GzDumVgOmUtTr4arGHXby9J7gwMWXT7WnhbneW0uCiDmRZ173xKZY8KclUbkWFRKjNZnEZtDClod/rPGV6PMHBnU6MHR11R/H6RovEuBgoZ7ZWbjlssAxDvmDJKkQXiYuT/Hbic4gwFyzuZQHLG+qmKeebTbaS1o5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730994; c=relaxed/simple;
	bh=0iT2muv6N8GB59/rnCdOQR9MS9PuQ2IA4RdBJY841+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEe+ZHcz4xnwqM4+eIkqIOr5S+iXGTdWFrxZ+56O6k1VnbfDlp3uU8OLdbEBHdyCimZRbL/6t7aoUgWuyiRR7QcNuPFM70qyLHIe37qs/C6AeEjCKO/eZJkg5I0H5Y32OvUIHOOaolZZiGCeEp9cf7u5iEseq9T1g25qnzLpX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOR+313s; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so3519244b3a.3;
        Mon, 30 Sep 2024 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727730991; x=1728335791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxqgnSClXAm5hKOjKA4L3emBAnz+dj8s/AGR4GTblOk=;
        b=AOR+313suW3LvGkT3ElzRgAhLz+7IywGlRUY6gfRBvtt9pwAETimQ0zKmwQjTu0blx
         CxmOTZ5C4pMjhYbThrUDqlmhERss1yOz5ogeTt0g8RwBu0udMHwlYODTM6NV/VKZTvvC
         wK4+Y0r77Cbg9FpLBnWkuvLPAyYKTTyG/sM7h/SKgyO3AYS5Ye2lU4kyJLI+omHCbOko
         eS4gCg/G7O2LYBBZuNPWfSrGAsaREQqqoFGbGfh6tPJcf01bVyAKBL7s2WuYwR+dtM9P
         SyMXGpAs4j8AZELwr7vtF7kC16fRgiLwkxUEfqTP8NedOZwpjhfH87K3gWawfEhs4/PI
         hvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730991; x=1728335791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxqgnSClXAm5hKOjKA4L3emBAnz+dj8s/AGR4GTblOk=;
        b=Bg5mgpt+c64p+C8MqpsIvoex+AGY03i952W6afARcxhEt8Znox7AEm4mdEnz+PyeWx
         qXd3aQahp5mB2zoO/YOIb1eVY47W4saOM3YAaHBfLPHMpQerapS5JkcYh5U2E9HtEzIv
         vwJkZOXg2y4rfz7TwMyGnSdSK2WUv3k8qv0ECJ8yz5bextPg851EQnxGc2vty20LP0K4
         vJcuVL0H0YZ4V9u1qCXZq6crdXEpHFDwBY0EiE7gCNnKBJ78AnDNBfBp5K4sZLsihbQT
         sDzo044j+hYvbkakmhGCfnrfQXUcjsLVs1dnoNuK0iY60cBt7SHlR+9DBipXEFkwUXnK
         k4gw==
X-Forwarded-Encrypted: i=1; AJvYcCX6di0ehYdbfhobSbfdc0dkfR+VdTgEmiYSJ9krIo7wG4jbOmgYYSUCkz7sthvbKGrTw4e5GfuYOMYStHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRj2xWCnIlJTOAcZeMbokbL8trqW3gbZW5zy6LqJbOX+jtcI+x
	LVdWNAW+AhPGhtGB8C1LoWZ0w44YA2BWWnptCW1HW3PZXYJ6969+lW+CR9wP
X-Google-Smtp-Source: AGHT+IEadElrdky6O1NFT1uokCFwG4qLH9ZPPD4Tz1X1yTy3jL8r57HyQBpG4vxkl2gimna6LNi5LQ==
X-Received: by 2002:a05:6a00:2d9b:b0:718:e51e:bd25 with SMTP id d2e1a72fcca58-71b26083144mr18939445b3a.25.1727730990826;
        Mon, 30 Sep 2024 14:16:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265371dbsm6681387b3a.207.2024.09.30.14.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:16:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	tobias@waldekranz.com,
	anna-maria@linutronix.de
Subject: [PATCH net-next] net: marvell: mvmdio: use clk_get_optional
Date: Mon, 30 Sep 2024 14:16:28 -0700
Message-ID: <20240930211628.330703-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code seems to be handling EPROBE_DEFER explicitly and if there's no
error, enables the clock. clk_get_optional exists for that.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index e1d003fdbc2e..67378e9f538a 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -348,13 +348,12 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		if (type == BUS_TYPE_XSMI)
 			orion_mdio_xsmi_set_mdc_freq(bus);
 	} else {
-		dev->clk[0] = clk_get(&pdev->dev, NULL);
-		if (PTR_ERR(dev->clk[0]) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		dev->clk[0] = clk_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(dev->clk[0])) {
+			ret = PTR_ERR(dev->clk[0]);
 			goto out_clk;
 		}
-		if (!IS_ERR(dev->clk[0]))
-			clk_prepare_enable(dev->clk[0]);
+		clk_prepare_enable(dev->clk[0]);
 	}
 
 
@@ -422,8 +421,6 @@ static void orion_mdio_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus);
 
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
-		if (IS_ERR(dev->clk[i]))
-			break;
 		clk_disable_unprepare(dev->clk[i]);
 		clk_put(dev->clk[i]);
 	}
-- 
2.46.2


