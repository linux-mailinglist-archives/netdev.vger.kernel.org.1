Return-Path: <netdev+bounces-130990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B730A98C566
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447731F2559D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79EB1CF2BF;
	Tue,  1 Oct 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZdeVXie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1571CF293;
	Tue,  1 Oct 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807371; cv=none; b=IBYqD9ZY8U3sevvXkSd8JMusqdjATh2nHeBUCd+1v2k9YpjiCRYSzimS1in9lFcUtMsniA9OAb+scRWYNZHR5UMGjfp3hvyvyFOh8guVB2GGZmgeIuJHqvz1usGsOFAD1mZ9TWH/UtSeZA1VZ1QYDV+xvsyI6fw+xmUlUx2xCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807371; c=relaxed/simple;
	bh=5yjkC6YExtO3uf8ed6K9yODndT1J9WrA8/wPT3wPRzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvXVYfbnWpgA91JxTVplXZJT3QTZTbRyWZ0UXQVolCjOifEiZmsAl8kLDSYYjhH9n1Fz7ivfQx6QhAiugRL8U6fDiZchZR8SEGehbbhCU0rsuagLVZdCc+fKKT8bLkwXUxfzAldXJ1NyFj54z9wISw9p1l8O7S18J7UhBhFK0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZdeVXie; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e6299191so3162651b3a.2;
        Tue, 01 Oct 2024 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807369; x=1728412169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlwbjCnpCbTphdFb+H0V+2QdmOG77Vw2ZnVKuqpgYbs=;
        b=cZdeVXie+lF0QmSNzh+AUK/RletAqr4BPJzSWuPcUV3+2fhk3xpuQB9urOdcvgaBxh
         Idq6zrqMfNu2SRR3R8J9La9OMAhQwqMAtJdhXSyVLUDA6epL5Ar8mt3ronV7vNUGZ59D
         Cbu55glJy7o/OF7JOnR7ChvnaE1DTdbtPxyAEodW9cv79P8gjHnazb5nbqMjzbE618mX
         ZQsdC/9+Cn5jNrBJNOJe2SQjtdFe+yA2BNJrKd42u90dlx/dEtpkFISsrc3sMSLdTFuV
         OY14J8Si6qAAbiaTBaDKGYz5K8Ojts/TcKgoFK6a1r+y+p129cArIzx5BOaN6ysPLryo
         9Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807369; x=1728412169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlwbjCnpCbTphdFb+H0V+2QdmOG77Vw2ZnVKuqpgYbs=;
        b=JYPR2FgEFUFzsf+FWqUc0Zdao2jokWpRGtbK5yUTEsIcFEibI9WxAooVDSH0kjRZjR
         NtKV1SGl6sfrdSoRip7OaJkCidTBXFDnrbM+R0nn0IMOPzMippwK55vI5iUE97rX5Gjq
         pNWczesbaNaLuh1Si5GzqKG9APDIBUU276r6ET1pqW9uvtWZPAYFalBX2DcSOkYcQmV9
         mZyiSWK/6PyRvxczuHUhK+WA+rLUG4LlRxkhwKe14KYVumLSOeacE30w9LhMcgGsUXMW
         xkar09TMGpORE/diRKdCBA2/iT2awNgU041119S8rKhrQT9UR0I0epfl7ZY2tlbbSfaf
         Dbzg==
X-Forwarded-Encrypted: i=1; AJvYcCWC9wt2QQF5qEu/CbWG3HdubsspMfgLA6gLjypiK5IOLBkQw/Cv3wzboKpsalaJkReYDTvcYvsfLOfAI6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpRZKuPFFr2gpK3LdM3jTz9Qvj0gqzvC0CAWrqK+jsGn9cY1C
	PAvlgBu015Gn1nIpLwL43K4DPLjZOXemaA6Urfdef+bLbCzhBLnERavMku5P
X-Google-Smtp-Source: AGHT+IG5T8CTRv0LIJW6TPROAeJu9QkwXVZQPRanIGYE+jSloz6ifICltiu4ta0m2N3jDQSOMJXJ9A==
X-Received: by 2002:a05:6a21:1509:b0:1d4:fcd0:5bea with SMTP id adf61e73a8af0-1d5db0cc895mr1128991637.6.1727807368993;
        Tue, 01 Oct 2024 11:29:28 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 8/9] net: smsc911x: remove enable_resources function
Date: Tue,  1 Oct 2024 11:29:15 -0700
Message-ID: <20241001182916.122259-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With devm cleanups, only one function makes sense to have here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index c4c6480c0ffe..77a5b766751c 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -359,25 +359,16 @@ smsc911x_rx_readfifo_shift(struct smsc911x_data *pdata, unsigned int *buf,
 }
 
 /*
- * enable regulator and clock resources.
- */
-static int smsc911x_enable_resources(struct platform_device *pdev)
-{
-	static const char *const supplies[] = { "vdd33a", "vddvario" };
-
-	return devm_regulator_bulk_get_enable(&pdev->dev, ARRAY_SIZE(supplies),
-					      supplies);
-}
-
-/*
- * Request resources, currently just regulators.
+ * Request and enable resources.
  *
  * The SMSC911x has two power pins: vddvario and vdd33a, in designs where
  * these are not always-on we need to request regulators to be turned on
  * before we can try to access the device registers.
  */
+
 static int smsc911x_request_resources(struct platform_device *pdev)
 {
+	static const char *const supplies[] = { "vdd33a", "vddvario" };
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct smsc911x_data *pdata = netdev_priv(ndev);
 	struct clk *clk;
@@ -393,7 +384,8 @@ static int smsc911x_request_resources(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
 				     "couldn't get clock");
 
-	return 0;
+	return devm_regulator_bulk_get_enable(&pdev->dev, ARRAY_SIZE(supplies),
+					      supplies);
 }
 
 /* waits for MAC not busy, with timeout.  Only called by smsc911x_mac_read
@@ -2330,10 +2322,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
-	retval = smsc911x_enable_resources(pdev);
-	if (retval)
-		return retval;
-
 	retval = smsc911x_probe_config(&pdata->config, &pdev->dev);
 	if (retval && config) {
 		/* copy config parameters across to pdata */
-- 
2.46.2


