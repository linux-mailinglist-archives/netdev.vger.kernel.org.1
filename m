Return-Path: <netdev+bounces-116577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F394B044
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E37D282B8A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BF1420B8;
	Wed,  7 Aug 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu2NhX+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70061428E6
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057560; cv=none; b=m3GGNI7GtM2WTkrraa4H9aEPb+c/SG3D6efROqij/PQcoRTHPUSRJenFlQKblDVZQS1SLx1+2yMDhQFOvjQRxHVNDW+mffXRcdI0D96y98RfacrCsfrJ20tUvX49rccGZ969cHEL7nzIVIfI/rkHEoQwj3vdqjWQ8DSJqPbrQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057560; c=relaxed/simple;
	bh=w1RrrkpyITrHY3Rb2oJs9y5ax0uyqCtLxaMRhlDgEPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tk5IKUWUOM/+J3aEpMAIkxP1NVc0IYBg9yXn019f+kFn3od0EWf1PXs9YnsxHcYTAzOWbHblSgeQlzq8tqrUFVdU4eI7xSIrRy/y7z0P5QMEs7yHtE3abP7TFnwloWBigF4WmlJ5qTWLm77nvC7/rkDDWUYVuntGwMfKt3NfyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu2NhX+i; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75a6c290528so124045a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057558; x=1723662358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOIkwEZUwxFvM/gXaXvNplzeK+Q1xc4Nm2b67u825ho=;
        b=fu2NhX+iTvEnKlrpvsH3ORfNSSflKYPOL58+O0ndysYtGhLIqHZ/JARyiWp5Z1DzU6
         a2QhGlGIzOKnaNawx/4GOzmLjnXveU0Z4j3vdoKY/vpxQ7DUCStouHFbDHTPhY1tyoBE
         tgO6aWo3pYPBa7X75qv2lMUuCArcNge5RHDE8Xqf+rj/1vctAwQZ8vlHFUiHzzPvBDwK
         D+2Q3+7tZlfNQ84kUFrVGkbNTl5JuO0PUWohgkyjG2VZm19vQOZH78fgjeI+mtVpIQQ9
         LU55ZyibzdfVkeHcBYmQzSpMYjwxv0SxAM1p7eW3z9aCaiddfXdgoM4wrBDeTgxByzzR
         CkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057558; x=1723662358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOIkwEZUwxFvM/gXaXvNplzeK+Q1xc4Nm2b67u825ho=;
        b=xPdxLw2t1+ErquPhLIO0TNokiMyHimsHWgTKpBSudQHixQPAXaoDSHsZe4nf1cold/
         dE1SYEJP/FX6l3EdvCuaEfU5LCXkhJiCX4M/AUfqj3t4YtOC9tYHyYzNGL5ETwdqkG7+
         wNcumj8aqP9fZnsyqJGwuKNvjR3qiykWik9ssN5Yoy0p7cavzcxOneXeYFb07LY+B2Iy
         ZKlusby7iWPyOnd5eTCyxcLhvBUSOeXIF/HVIz/a6OYYqcR3c8FfPD11ekZJnpfIRF2+
         YhfWYVY9htEIkejMioNukHnJRPyfjV3ZMvWJ4c3NRUA8fdqLy6+ltx5lj4U+sav95T1Q
         00Gw==
X-Gm-Message-State: AOJu0YyLjvPNt5UUfxvNZyeoU/LzzvTuKAwDjoyerlqvN6Y8+VzgsXQv
	oWb1e4waoF00JOUZnWB9R8PSuPE84Bu+zVKQqN7vAzxTh17JKb0JSsoEVg==
X-Google-Smtp-Source: AGHT+IFv4sNuOhxmbpCm/5ZlDdSx7cGStIfa5N4xLCzW6fe3vPObJFiDbFEJBJ9qyl5IcK8OKsds8w==
X-Received: by 2002:a17:903:120c:b0:1fb:8a61:12b0 with SMTP id d9443c01a7336-1ff574e15edmr199447265ad.54.1723057557820;
        Wed, 07 Aug 2024 12:05:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b52bsm110672125ad.176.2024.08.07.12.05.57
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:05:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] net: freescale: use devm for alloc_etherdev_mqs
Date: Wed,  7 Aug 2024 12:05:49 -0700
Message-ID: <20240807190556.6817-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler and avoids having to call free_netdev.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a923cb95cdc6..3e3704ab464a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4312,7 +4312,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
 
 	/* Init network device */
-	ndev = alloc_etherdev_mqs(sizeof(struct fec_enet_private) +
+	ndev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct fec_enet_private) +
 				  FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
 	if (!ndev)
 		return -ENOMEM;
@@ -4342,10 +4342,8 @@ fec_probe(struct platform_device *pdev)
 	pinctrl_pm_select_default_state(&pdev->dev);
 
 	fep->hwp = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(fep->hwp)) {
-		ret = PTR_ERR(fep->hwp);
-		goto failed_ioremap;
-	}
+	if (IS_ERR(fep->hwp))
+		return PTR_ERR(fep->hwp);
 
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
@@ -4603,7 +4601,6 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	fec_enet_deinit(ndev);
-	free_netdev(ndev);
 }
 
 static int __maybe_unused fec_suspend(struct device *dev)
-- 
2.45.2


