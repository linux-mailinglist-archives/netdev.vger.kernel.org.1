Return-Path: <netdev+bounces-127649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0C975F36
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C771C224DA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5418756E;
	Thu, 12 Sep 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW5Km/b4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DE1865ED;
	Thu, 12 Sep 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109361; cv=none; b=Br6l5Z7cW5pZzW0C9a+a8TaYoPhF1Qc89Q4KhI6/DDo61cTRAQDjOCXjLcfZAITv85tYhmZPlyfgvTwcT1Y5DiajvK4jCv1DR43mIJyNiZDiNFjQPxvrQZHnTBKNotx5pDbN4cyR1/3ES+SgC5q3Q9OZeUHZZjh4bEfriXij+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109361; c=relaxed/simple;
	bh=YuhkxiKelW07zOkVj2Rxf9p0M25KQ7Taj3/ZESvg2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTwC/p387P8XxnIcaSqiV62ZD4iZgsj/o5p1gbsWTOHrWYsPM/FdnbcZKnvBkRZxV0sxgX7E+92cN/X6BD5El/K51o5RNV2YDPip77UKsV8AVxrX/tF/wkceZ9ZMaocPYFJ0gVbNrnLq56KMtQSTp9VVV23eGaKfp+QD4JohSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW5Km/b4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso384305a91.0;
        Wed, 11 Sep 2024 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109359; x=1726714159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlsJzSA2eH+FC3sZW03rQKJ3IOa/GsfL6MLaSKHuklI=;
        b=AW5Km/b4TiEYcueoxiesCxndyyflu5xgX+gbjbkyi+wE2cP40ljhv934dvqw4nIPOb
         iU0PMFrhWCpp/7T3pTeGxqiYyf3rsSnl3S5mSuk0fTEWL/88zmo6IGzRj2K+UUyMX1Cv
         5ogTGy1D92j9uReYg2dgK54Dunn9BB0WANt/OtsHdn5H5vVuhmmmkd6UMYuu7FmIiNju
         Ke8RfTbUq555JLsGOkSqjYdSilVIBI70NHfdFZ5d6Xk+wpv2XZPsPfjwodds5+5R1r1T
         38YqDKGFJECTB3QnoPxdFmNeLHYBKsV8iTOpb/uwJIQjRrdz9uPocDzZlcO/iDUUQVpm
         DvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109359; x=1726714159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlsJzSA2eH+FC3sZW03rQKJ3IOa/GsfL6MLaSKHuklI=;
        b=U3mzl1IKS51mk3zVlr1UntifXcWrEz6/Qj8RjTdBY2QLUxVWpTKnmswUI5jr/KL6I6
         IaF94lc8FTvuG02beJrJYpaAatYvFXyy7tz1qTMuPgRxH0m+QrmF7WnzOpkUWEyjOfw3
         L9SMvy1EE66rDKZ7eKfkLuGn5dIo8tnEcpsXLn9FxbIt98kW480dGMxCopwAT7YpMi/T
         pkL3CSBWDBi7JVMKkZEyef9hyTDMyeVKgX0vFCvNRLBDXvckH0XejkV2HktWBDTsfYE7
         zcb6o1qbFpUy90OMQ8imo+mmJWBRDwP0Pmspe3VzU1fegIIQaUvBmcqEazHGOKcSWJCo
         LF/g==
X-Forwarded-Encrypted: i=1; AJvYcCXLNoZxczs0eWBSLWwepVNyMbO3VITmAC5jfGuJtRL0pyfQJn1hB2TMGsQBfu9VyvX+mwISmDaeIwxSfGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAmlBGcN+YDROwTrLtCTF4THauZW1oZg/TEX9qN3Lz0W/LACD
	UmddEDmU0vwOYkNHis/Kv06mMojpiyGwyDWgM/eFxgHIwNkC+R2tHqY2hbQG
X-Google-Smtp-Source: AGHT+IFq4uLyJF+fHCXrCU6xczE4PGO7pby5jjXU+wmJ0XNIt4G6GnyJcM6GpJxvFWJaoQJB2uvfVg==
X-Received: by 2002:a17:90a:c28c:b0:2d8:7a54:51a6 with SMTP id 98e67ed59e1d1-2dba007dfc2mr1576106a91.33.1726109359598;
        Wed, 11 Sep 2024 19:49:19 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv5 net-next 9/9] net: ibm: emac: get rid of wol_irq
Date: Wed, 11 Sep 2024 19:49:03 -0700
Message-ID: <20240912024903.6201-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is completely unused.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 60c4943ca09d..dac570f3c110 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3029,9 +3029,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
+	/* Get interrupts. EMAC irq is mandatory */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	dev->wol_irq = irq_of_parse_and_map(np, 1);
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
@@ -3055,13 +3054,13 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emacp) {
 		dev_err(&ofdev->dev, "can't map device registers");
 		err = -ENOMEM;
-		goto err_irq_unmap;
+		goto err_gone;
 	}
 
 	/* Wait for dependent devices */
 	err = emac_wait_deps(dev);
 	if (err)
-		goto err_irq_unmap;
+		goto err_gone;
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
 		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
@@ -3189,9 +3188,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_irq_unmap:
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
  err_gone:
 	if (blist)
 		*blist = NULL;
@@ -3218,9 +3214,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
-
-	if (dev->wol_irq)
-		irq_dispose_mapping(dev->wol_irq);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


