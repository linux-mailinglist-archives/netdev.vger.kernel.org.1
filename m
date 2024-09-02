Return-Path: <netdev+bounces-124290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1467968D2C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43901C21069
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D892139CD;
	Mon,  2 Sep 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0VBJFiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93F5680;
	Mon,  2 Sep 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300939; cv=none; b=UMJLk/UdgYRt07tYWQsuI9+2LB1wZgAKAawoxs4BnDLsQ7fnAViJk2/YoMMH1uO2VW4qBOMQ+HNhMj45FFGDfxxVJY0ZgicnHn9GN9Tuwjh42LzAu8ICHlM8qWmfNfarWpiOqP/JKyE3XK/Yj1od/qAoqHdgR/R2+7Dz7sAwYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300939; c=relaxed/simple;
	bh=U4PcNnx+tTc60z7zpQ78dqWgGU8LYCy8cARMM3w73e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ0HxhxokaxVPaWYqYo9o7SvopwAjCazKxCGFys14YoFJXQ/+EdGgHEtxkki+H4d9/r+b7nuppfe0nUiXmlZoPDwFE6Q/50rFkj+ta1FYFjlvZHhT/8RKqzm35lOeynVAqs8imLF4XInJ9MfLMAWMTJXHTcQFZzUJskl3RRH1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0VBJFiN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714287e4083so4040545b3a.2;
        Mon, 02 Sep 2024 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300937; x=1725905737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtEV84BBq0rZJHR4vDOH0nemlHNjQdE0nFpOJPWT6Yw=;
        b=D0VBJFiNPRz9YLi8Ice11BrnW1jPZ4gbyRHuuOSmRxYCBIMIAQs1xxE0sMd3gibq7m
         9m8oFExT5LEef9NdsHIuLz3WMUawOXpNenpfC4QbuE5u7fyCOYA4lXS97yqwIhtc3WfU
         RMOkvr4NPye8EaiJZ7UgZBX4a/zZ77QDXg2/0nSFOILrxvDtzFc/dtNIRiLR6H5pIKEI
         IbrT5yIe4ovmj8PN6mI0LDFlSt1dv6QPjfEhK4WcjMlTvjtPDyThrTVddfutPHyuVu+B
         S9TXponwQeNqtHqljjB0wQeCrRBQwMKC2Fq3d6sbyzDAH0sz72sbVSsHLS8vj9Rf3/vE
         +KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300937; x=1725905737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtEV84BBq0rZJHR4vDOH0nemlHNjQdE0nFpOJPWT6Yw=;
        b=nnkgA5Ty7jP5IB5wwECdAny+W+TGaZApnG9yn7XVP3W/YUhn//AuWiXMnwWdrh4ZSM
         RHSZRK9i+cjkNGlwQpfaU1tBEeO9fonQIeFWs9MVK0FIELssr/XiBZE/Z5ksrmQAx6J/
         euuU3M9GoTQqSgRRv9tFxkKJmW/n8ugjDIcFcBPDR4es2oC4Fj/WKTM9TJLUbKV0Fwye
         CzAhIV+wId/n9GKR7RxPerMI2VDwqpBleA9KYmjKrqf4izSAEVtseXpi/eX4SWTCibQH
         2eqm0sArdGR0++NEUhWjcXChBIme9t76KLZ5lTJNhNo4/bQnSL5Wn1WPJgl7t64Ege6W
         i7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHfGRialuzHhIFddQiVu1fY0RSECtSIWx/s6O08Hgsh4b0shM1aKnXQRq91BaS9SmgaaJAgdT6JZAsQfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IokmGkUPBDEr+1D5rKEPLoFnDdmkuNFSzbRzlt1cmplBxIS1
	HZ+hdDfeMb849ojJO4MbsvTBcL79KjlE7ECRSGSm5O7nSY6MOLjc07v3cYEX
X-Google-Smtp-Source: AGHT+IFAQ11/9AuEJyl+KhjlsXP306dSSn4RXBScsJJJoUemj0tRAs/T/azTrV6IcSOXYd+7BF5HfQ==
X-Received: by 2002:a05:6a21:e8c:b0:1cc:dedd:d8e8 with SMTP id adf61e73a8af0-1cecdee3b51mr11145692637.9.1725300937100;
        Mon, 02 Sep 2024 11:15:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH 3/6] net: ibm: emac: use devm for of_iomap
Date: Mon,  2 Sep 2024 11:15:12 -0700
Message-ID: <20240902181530.6852-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>
References: <20240902181530.6852-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing manual iounmap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 98d1b711969b..1a4c9fd87663 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3082,10 +3082,9 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Map EMAC regs */
 	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = of_iomap(np, 0);
-	if (dev->emacp == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		err = -ENOMEM;
+	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
+	if (!dev->emacp) {
+		err = dev_err_probe(&ofdev->dev, -ENOMEM, "can't map device registers");
 		goto err_irq_unmap;
 	}
 
@@ -3095,7 +3094,7 @@ static int emac_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "%pOF: Timeout waiting for dependent devices\n", np);
 		/*  display more info about what's missing ? */
-		goto err_reg_unmap;
+		goto err_irq_unmap;
 	}
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
@@ -3228,8 +3227,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_reg_unmap:
-	iounmap(dev->emacp);
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
@@ -3274,8 +3271,6 @@ static void emac_remove(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
 
-	iounmap(dev->emacp);
-
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
 }
-- 
2.46.0


