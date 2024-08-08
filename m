Return-Path: <netdev+bounces-116682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E494B5AC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B25F1C21974
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E76E61B;
	Thu,  8 Aug 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3Ij0SnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04C241E7;
	Thu,  8 Aug 2024 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089485; cv=none; b=KN6Sl+lGSKRrpGmXEXiwkxaaOdfHWVDwFVKEX6K6hDzmGb6iP+PhP/ByGpwTV+JlaRcddrEXuvKfvMAenAqaQyRAWGkKTZtoXuY4pUX10+QE+n1hd9izlpcmXbpjwBQJiQ3myXFB1CbI2QOCc4mJY0/PpEA6CrP3e7awq3UCG1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089485; c=relaxed/simple;
	bh=9vPTol5hO98GUUzWWKc3daC6oe5+JoR57sxGAGL3TbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmxeL5kxh780jmIGaj4jE4eH6ea1dR0g/fvHCfJDSDWZlHty0PKjjA5fVGI3rU58vk/3c2VwmOLO7tpQySZAzlL6wuEv5kg0OqRvUKpzXJ1py97R2Sni79VIq5Qf21VC12WHc0F8t75Fb9LMV5FEtDTH3tIWS5wn8ieraCEwG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3Ij0SnV; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d82eb2c4feso327537eaf.2;
        Wed, 07 Aug 2024 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723089483; x=1723694283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EobWU1G2ui1urfmcOKK4v3VhiPFhXrZCBLBf1l4i7Jo=;
        b=R3Ij0SnVEDIh4xKSECNA5CtegNs7UsqkfBmwiZAG76yx4euQwsYadJssP0fs64t9lU
         NS3ePIEs/NsW7MLH22REiHjRRteaVe92KQOUGNVSohdOP1cZ53yrXWfV6bRaWk6Wd3rx
         7bwUB7pOauu8FQtaNPSDj+sl7nv0eIO1nJIzIgzpj/ohe/mPawldg/OGpOXqp81556lD
         nd4JOPI5tIhcIR0cDJzBfhaCtJv/Xh0ha/+eGjxn6uFPzELh31xK21Z9jAaBcWS2ifli
         t+rwMlNF/RjTog9hPLsDQoYvi7++d+fgRNlJ68msggU2lvBZRsTmT6RBo2lL9BOf90Tf
         Lq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723089483; x=1723694283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EobWU1G2ui1urfmcOKK4v3VhiPFhXrZCBLBf1l4i7Jo=;
        b=empCDsgNUbGcK8cLb3O/nCx09zMc6BrwgYoQV0BHhC5bdVA0UggDNwFv6eit8wFoYn
         JSH6wIYf1Jynhp7HnHAEMJjikDcX7wAXJ7OgHRG227FU6fHbpd34igdUBSL4A0CAkrB/
         nKXxFHuImxNeLQQUcX+tZyIOuxf9riCtragj5JNHi7xmOG7G+KYSy84BisIbV2jgp840
         Ey+kow42A8yoUKtlsAs1jRV9+oUGGlQdM8kk9So5ame+C0wx6aJtoqLil683k+5yXkrj
         9ZtoaYqgTzGrLLamXIAknJ6uNkhuvcLjtTI667HHeRWQk89Sdxm08+ODTnrUxxAiub/o
         hppQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF1AAwu/Kta1TCJ4cw2hM2271HzuFveBaxJwos6tvbV6yDsEttHdlPtQkypLMl+EHb9eu2ULlC1UT0U2147WJjuc1MR2yBMsHkuK0i
X-Gm-Message-State: AOJu0YxCBIYZTwlkYo4bVGZRDqssh8YuD82BrO69iQJ5VsePl7kWF+6h
	wh5pwl1xAF5K44+kvLYmdpUbnkjy6v3YHwyqBpOTGXLbNoC6K1zTjizXFg==
X-Google-Smtp-Source: AGHT+IEIkncM/RQcMj6HjZ3lkRMD+ETJZAB3a0tHNzTkFHV0IsMbFh/ubzRqK05Se35rRW6Etjc6kQ==
X-Received: by 2002:a05:6358:9203:b0:1aa:b887:2386 with SMTP id e5c5f4694b2df-1b15cf729b9mr89705455d.10.1723089482579;
        Wed, 07 Aug 2024 20:58:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346a9absm7713499a12.29.2024.08.07.20.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 20:58:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: timur@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qualcomm: emac: use devm for alloc_etherdev
Date: Wed,  7 Aug 2024 20:57:51 -0700
Message-ID: <20240808035800.5059-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes the need to free. It's safe as it is created first and destroyed
last.

Added return with dev_err_probe. Saves 1 line.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/qualcomm/emac/emac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 99d4647bf245..bb0d91dcce2e 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -608,7 +608,7 @@ static int emac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	netdev = alloc_etherdev(sizeof(struct emac_adapter));
+	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(struct emac_adapter));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -630,14 +630,12 @@ static int emac_probe(struct platform_device *pdev)
 
 	ret = emac_probe_resources(pdev, adpt);
 	if (ret)
-		goto err_undo_netdev;
+		return ret;
 
 	/* initialize clocks */
 	ret = emac_clks_phase1_init(pdev, adpt);
-	if (ret) {
-		dev_err(&pdev->dev, "could not initialize clocks\n");
-		goto err_undo_netdev;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "could not initialize clocks\n");
 
 	netdev->watchdog_timeo = EMAC_WATCHDOG_TIME;
 	netdev->irq = adpt->irq.irq;
@@ -712,9 +710,6 @@ static int emac_probe(struct platform_device *pdev)
 	mdiobus_unregister(adpt->mii_bus);
 err_undo_clocks:
 	emac_clks_teardown(adpt);
-err_undo_netdev:
-	free_netdev(netdev);
-
 	return ret;
 }
 
@@ -740,8 +735,6 @@ static void emac_remove(struct platform_device *pdev)
 	if (adpt->phy.digital)
 		iounmap(adpt->phy.digital);
 	iounmap(adpt->phy.base);
-
-	free_netdev(netdev);
 }
 
 static void emac_shutdown(struct platform_device *pdev)
-- 
2.45.2


