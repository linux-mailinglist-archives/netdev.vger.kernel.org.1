Return-Path: <netdev+bounces-130609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974198AE67
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9CF282D5E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0011A2645;
	Mon, 30 Sep 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq8pq7/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EE19F42E;
	Mon, 30 Sep 2024 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728196; cv=none; b=L//s8RFAEFwJLVgC5/INIZe+0SDzcvOjHCnKh2FP49Lqk4XVgGcLCZtaRHWdOA+OxuQs2JOqPOpLdpBWyqUP7xkuztj4k3cwVZzeoQdE4YZgG79of08ZWjrEQ/OyX9Shc3QFwJlWugY1tmS7ajAJjfQXnrZ0rGzOidyPiwdLjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728196; c=relaxed/simple;
	bh=+00jZr7ZwdmIjTsWoO4PkDFuuKcXZlqjKC98APiB+cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOC+Kupu0iN758El3zAh0kOZQOXV/OokrqQYiZNGnuQew3G8BimsQ0B2jLxxeRJYBE9JQvU3PSoZZJR+pSEdyBy85BBy3esM/EmsFinpw4187OTOb5cr2U+RhG8CUZa51GM57gw2GrPyVeOOT5evDvbe93pjFsiJvdtPBhpVd0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq8pq7/H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-719ba0654f9so4022150b3a.3;
        Mon, 30 Sep 2024 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728194; x=1728332994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io1U+Eo5Bo5el06fukNjEThXwdMFxIrkLZyBN9luQKc=;
        b=Gq8pq7/HAFI3+0STFpNLYGQtGU7TBzmg3h0g50mbJngIE3TiZXkEYksu71HAGXDdTx
         Hmq3+obFzfeQo0RoPF1++Fr3VUM1x8f68gESC1TfRunuv7+a2xFW5HKKTj3O2vFpE+24
         ksNzzbt0fI6cfvA9/rvjyeUhaSfJ52RzoWYSPFpzKwmyXHPmy/b8AE0KMuW5wAyptKjh
         tBAOmPzp3sRdLgXOLigfuZ6G8cMAJiavbaeB0UAnmkJn5UJi9NgWIFICUfUduoawP739
         I/0so9p1veOJFRKuIRnHlaWxy8L2vgb9kNNBWy9BM7pyDuNJtOWxsSXqjuuIy0gCVJ3x
         6xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728194; x=1728332994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io1U+Eo5Bo5el06fukNjEThXwdMFxIrkLZyBN9luQKc=;
        b=WLn2oD/MWJ6yKLlzwEo57RNKFmfYeCPsnGqM19HFcxVcZMHk7RloVO2bImTFFHT/dM
         /bMyCbc0bop6OYUHj7ffHPZuMCKvJX1xr3tVMY5O+MpX5bhTRYQaXcIS1vnXP91aAWFv
         z403slnmG97oh0qSA0BnwVRVu0eOHBsASLPuCvNFd5T25d/GxRa2f7Uleo4xXUbXTMmE
         6R2BfQdAq8Rmq50I1toq34kFXycSUCho/GFwd0FsQCExzmGS8omHakG4WBQ14SM56tp0
         X+CrF4N+WY47PlPENVI10Fk1XfadZaHyzvLgYhLmf7Xi6MY2mC5ZwyJho8CoOTBSrW+N
         Oy1w==
X-Forwarded-Encrypted: i=1; AJvYcCWxoK8pdEXr9gj3ROe3V5rwhR316HttcdJFTJedmvDDp2JQKEXyZRqiPoDEMVi4f7D9Penb7Ba/paFqzcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzngGJrgz4SMGPjlkizluMlBDpBBpiPooDSv+qOG65xWYYXCGzq
	la2dp5nQuylgYHgzQ3AJvF1xgdfIBq+Dq98wYnHvbWUC5CUH7U2iWfRCDtp8
X-Google-Smtp-Source: AGHT+IF43Hww0PXELZYBxH71jwdS0plXyTSozmTGjKIQZMRDWhvkPlOxU/aEmE5Vu8OGJSgD10GsYw==
X-Received: by 2002:a05:6a00:4650:b0:714:340c:b9ee with SMTP id d2e1a72fcca58-71b25f27594mr18938648b3a.1.1727728194295;
        Mon, 30 Sep 2024 13:29:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb3ecsm6812943a12.60.2024.09.30.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:29:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: mv643xx: use devm_platform_ioremap_resource
Date: Mon, 30 Sep 2024 13:29:50 -0700
Message-ID: <20240930202951.297737-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202951.297737-1-rosenp@gmail.com>
References: <20240930202951.297737-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This combines multiple steps in one function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index a9e18f7b16cf..36646787885d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2839,25 +2839,20 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	struct mv643xx_eth_shared_platform_data *pd;
 	struct mv643xx_eth_shared_private *msp;
 	const struct mbus_dram_target_info *dram;
-	struct resource *res;
 	int ret;
 
 	if (!mv643xx_eth_version_printed++)
 		pr_notice("MV-643xx 10/100/1000 ethernet driver version %s\n",
 			  mv643xx_eth_driver_version);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
-		return -EINVAL;
-
 	msp = devm_kzalloc(&pdev->dev, sizeof(*msp), GFP_KERNEL);
 	if (msp == NULL)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, msp);
 
-	msp->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (msp->base == NULL)
-		return -ENOMEM;
+	msp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(msp->base))
+		return PTR_ERR(msp->base);
 
 	msp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(msp->clk))
-- 
2.46.2


