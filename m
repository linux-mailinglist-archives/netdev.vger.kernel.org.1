Return-Path: <netdev+bounces-117820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03FA94F740
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578E41F221A5
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BE1946C1;
	Mon, 12 Aug 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi/Z3Gi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECC193084;
	Mon, 12 Aug 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489629; cv=none; b=jJI6QZks+3fi2g7uko40qxR8NF3fxdI6s40Wr+TOMnCwgLiPEvyfeKbu0EJnz9QytFOmrKyku/cyR+vjoMJ7w4QYbJA9I82ejS2RIVU/+Ytsrv7lwN1rHScLRfdS1Zm2u+QcKH0jUhXQ2Dtq6sK/2nQa15fpgPcwM0Xc+ATdwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489629; c=relaxed/simple;
	bh=pRmkRoYFgiZLudNyo3/6lDIChkGxS6Z7skThQCnsJrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwO0vHAtckuivztdRgkfF729twTIF8KHtCC0LH4xC2Jz36CIqnwx2+UY8INB8dKIKwE8DhxJWLNjEMh051vGerbXzIpbVFiSyIPQ8K/X6L6pSV26riXC4hxCmYnDzBGDGZum/Vl4U2CRymJoXtXW/8OSb2uEf2qKPucX81kcF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi/Z3Gi7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d162eef54so3340759b3a.3;
        Mon, 12 Aug 2024 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489627; x=1724094427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8rtduMWyL2CM0wvkXH66IK8dzqk0Z3EWzXwEhI6VvU=;
        b=hi/Z3Gi7mjJ9r3fPNgPI4cy7FpneqJjHZzAa0rvh/mCnmZ6fyQzEVyTK78NT3AIrjC
         BiNW+rfCzyRT7InwTaoWCp1Qhy7ii8BYayw6cYvh92s2HQumxMxV6qNTQ7nXr+LHloSN
         CqAQbXI3cJ8GC7ISYbANJnDHXyJcWmyX03479t8MxyfHDZnEqL84Bxo/OXWZXVatt57V
         E/lcM4D4WN9oMHtNJ5MVkBNzdsa5rPTNe73zblIoOrr34DLZZXiDZ4dSRnpsDtb+yDPb
         ttau1E/66I6s6BBq54QviSIrdBrQpgKWS0gR4kFXfXDDaJ5sE56RWLcAGvW09qoqMW1Y
         AWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489627; x=1724094427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8rtduMWyL2CM0wvkXH66IK8dzqk0Z3EWzXwEhI6VvU=;
        b=OhcryNG9Np73dQgJ+BtrBgeEAhQSLJ8AXhxU3kHfSz/LB/if+9lkIsV0HVLW3WKNQd
         Tzw7XLGGkiFNBwz64iEuiCgbslysut627+Gm83gWX2R7omOOpBx9YPqsPUih9WrOGVDz
         4Dg6Ol4Wup5tVH6ygaCxvsk0OYNOTnPpjdX+eoNJ3Ftd8ipeSXWwBagVDCKjZkz3gZZo
         H6NHSWWEJkISzYOjTNl7CjJHwSujKKUvUHNujkj8muon1MzHa3Oy1Ivbw2kgL1d4jvXH
         PqxHJb9cRbqFcUFQ4EqxyJprZrL4EXxqXsn8cjcmrjucBcu2zOZCATkPRDhYfSc2vPvB
         7ATQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIqB06sQ/cYXRP9k3XfxsdMIH9GwXjzkMZR8XNcx7MvyZNDewRiyIwP5cUp4XPLvl96GOV0OEPxHcZ4rmxHC3CVAg7kxh17xeiVbWJ
X-Gm-Message-State: AOJu0YzzgTjlB3z2zPZg+41jwUW81H27LVb3Ncx2/xaTVz2FQytrmbM3
	sM1jhvoT/tEmbzgs6qrn4NGV1hDjSHL3ZJmXVf3UA5/5OCvnkzsoEd2mvBSq
X-Google-Smtp-Source: AGHT+IEkSnfY39aCo5vUc90gn+FltfsrMK1jvA/EtEA3PEqS4ZuR1VfAkCKEbGa8b2Icl4tqiurs0g==
X-Received: by 2002:a05:6a00:17a5:b0:70b:3175:1f4f with SMTP id d2e1a72fcca58-7125516e5b9mr1419957b3a.16.1723489627186;
        Mon, 12 Aug 2024 12:07:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a7facsm4334495b3a.59.2024.08.12.12.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:07:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next 3/3] net: ag71xx: use devm for register_netdev
Date: Mon, 12 Aug 2024 12:06:53 -0700
Message-ID: <20240812190700.14270-4-rosenp@gmail.com>
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

Allows completely removing the remove function. Nothing is being done
manually now.

Tested on TP-LINK Archer C7v2.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 1bc882fc1388..43f0e2cf987f 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1923,7 +1923,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
 		platform_set_drvdata(pdev, NULL);
@@ -1937,17 +1937,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void ag71xx_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-
-	if (!ndev)
-		return;
-
-	unregister_netdev(ndev);
-	platform_set_drvdata(pdev, NULL);
-}
-
 static const u32 ar71xx_fifo_ar7100[] = {
 	0x0fff0000, 0x00001fff, 0x00780fff,
 };
@@ -2032,7 +2021,6 @@ static const struct of_device_id ag71xx_match[] = {
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
-	.remove_new	= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.46.0


