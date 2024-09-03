Return-Path: <netdev+bounces-124700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E796A7A2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C12849E2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5FC1D88C9;
	Tue,  3 Sep 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtVGWKub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093719146E;
	Tue,  3 Sep 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392601; cv=none; b=YhWz3sRnY4ELnT4kFVvYNcGr6/ZnGYmi37HRbuUMRDbsc6DizBb9CYTXy0jMnz5vt7uFZhwV1dPJf48s6MwL/9C/caTIa+GpbOswbxGp+WaEO+4MsYpWa5xkV5WhOdvEnWbh4Z8DY0Sr3MAFrSK8jXtOD3H4ADI13KHtn9x2vR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392601; c=relaxed/simple;
	bh=Kbytasq71n7TZ4AmPFNnHyoD8fiyS/BnZezEfZaL+kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyxAW4bJpb4n0XdSi7w8Ee3saq3sQCqXxTdDbS2p92ozpbPthGU6ETFnJvOBTn9X3zORhmqlcuDVE4r2MsHNavjbK5e9811O9c675thdF8Qz1WKTGNTvWCLM/D6iEwjkZq+g5sVztBsXxUDDsOxcdpJdf2q5kLtSqyibEEokaP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtVGWKub; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-204d391f53bso40838845ad.2;
        Tue, 03 Sep 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725392599; x=1725997399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twVF2G1UOixAdHqeKrG2eRrcvQZELS9sIkw44+Ffhao=;
        b=NtVGWKub/iSQjTy+500ft57Ge0+dNBSuwmQZ0Ri2/gOGT6NOkcET+tcp6/CunVSjV3
         9PzyfEWx50tWV6LzvhCMCeYy2Ri2jDbIhMRqAhfGtLPmmTM2HAix2OnOu0YlsYvWdlN/
         +XoEUqPwpMW8QxNyNil2Zb1ztFY7sQHA0RNIAEOc2KdmdHZGPTekkFZyrAMEdhrNgDjA
         I9wAwQtmP7nj/xPOZSiD8wYPd3tR2o86Iuok7HMi1XAWMtJcuF8EG86NDGxK9/jyBRvq
         kNJGj60Dti3zU1Azzc9sbdEjo+KDMxZZWUx6jfX8ATe5f5r9AoXg76kNam8ms90DsZlw
         O5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725392599; x=1725997399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twVF2G1UOixAdHqeKrG2eRrcvQZELS9sIkw44+Ffhao=;
        b=tG1XNEV7+uY8P79QFjFcUkdazf8hvVfat93sqk41brLUDtsVOtyoCbGkMdsnuBwUSC
         uMlcrjHFMSeRPFUR4XfQGQqZkgmvIlcaUQ6EIw4a1IhBuubGPLN+i0Y95zuw56QYakWY
         r8kvKm/04u3dZVY44RY/srajWz1hfznGqHA/gWVt+uFHgPa8Akjdg9G7/FVf24YJzJcR
         IV7mKELg/pAvbPtRLoxBvvqZQ5WYAkj4cEXiDU5NYi2AjflwFh1j5grB/m8qge6UwsKF
         6IgbeRSJhABMjYnYwfgY/Z+xS5cULOtV+MoRmmabp4RjBLa/+JHI/Jln8LxXKkRqGnCB
         sg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYiewI9AHar9117nRF6edJSbXssFWsQQBowMHXmqf+jrtOypS3xHurXWKhXZUH8Ab2vMqGoB8m64dQlmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRyCOI4DIu3DaDMM6lNvp1RCJWC9zq1zDuk9y7pUomw02LasT
	pPN6bdUq8b8tAgoP5ody9+pHm43RWbMBkIhO1mWI6BBmCJ6BAwEk3jS6yabK
X-Google-Smtp-Source: AGHT+IEiUxsp8z4vKUZL1gW3K66t/atgu0OlBgai+cXNeuBdpHvFZvtQOh2EH2aldKoCaFVZp9EUDw==
X-Received: by 2002:a17:903:2303:b0:205:4bc0:1993 with SMTP id d9443c01a7336-2054bc03268mr109289565ad.6.1725392598914;
        Tue, 03 Sep 2024 12:43:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm1979505ad.182.2024.09.03.12.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 12:43:18 -0700 (PDT)
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
Subject: [PATCHv2 net-next 3/8] net: ibm: emac: use devm for of_iomap
Date: Tue,  3 Sep 2024 12:42:39 -0700
Message-ID: <20240903194312.12718-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903194312.12718-1-rosenp@gmail.com>
References: <20240903194312.12718-1-rosenp@gmail.com>
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
index 4e260abbaa56..459f893a0a56 100644
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


