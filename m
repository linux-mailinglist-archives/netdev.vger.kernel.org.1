Return-Path: <netdev+bounces-130595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D420098AE39
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6F1F20FEB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDB1A265A;
	Mon, 30 Sep 2024 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLm6NUoH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BC1A254B;
	Mon, 30 Sep 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727881; cv=none; b=uV520wjUmaemLuE8GsusDfHX6m92c/NT+xkrKPpEuhxIeHNkT8IHSQNQ2KcMsUQS9qbxPD/8obX/vYm9+3UDfXFHpsGfdwxmJKuXqxFWJ0Bd1GMHySJK8psnvlnoZaEumeLFPfVX8o8Ov9jNNSxfpyD+Fo5332JWX+Ir6FLWFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727881; c=relaxed/simple;
	bh=+2YbOAsmqGFAN3DsO0ZA0iMaXoNb9kIy17mhXGFmZDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5sguFA1r9tOAgUNoZq4NKmzyQAeOx+uhk6Uzd8FByGDTHHHW1EoPVWoCoJ8NP7/XblI1evJSEuvVlNDdk4LbGL/ooMBguE0LjsZqHmyJDAgvK//9XbR53GVZvQpP/s/mOc9eKafbHoi7CHEflkQ/RaFPGSvds+dqYfsEsi7m9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLm6NUoH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso3501128b3a.1;
        Mon, 30 Sep 2024 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727879; x=1728332679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULD/SZGendmtIkaIIrGrKxIivyFI3b2S9pE06yiU47M=;
        b=KLm6NUoHfydSYV2SMdWeISDE0FsT8es3op8LB0iNyUup116RlHc7jFR+Ey40s1hG7C
         WNXnD3NJkSobiwC4ld6dm8bjVkcbUOyGMsBRqaeBLcJK3+I7LCmwLXsviFIpTZkVdFTd
         C5e7Hf8X6w21Xg0Etpp1Fjsk/k3rDaDdXxYkyf5kXJKvjxfSubC3ADTqqjH3I92suYbh
         IBK0/LY9RREIy9Iykcfm4GH4yFvUPT/dxutiqsk/IECxYW3jLieynj/CbKYRQn+o7PNa
         plblIynWTsK21HGQv9qipWMm5uYMyVb2wB0ssVsAnDjBVLpYbiVdPJloN+3CJNfW50Fc
         UueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727879; x=1728332679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULD/SZGendmtIkaIIrGrKxIivyFI3b2S9pE06yiU47M=;
        b=wZ9U/F4imGRgrysqO4+daJUTPSq2G2a/uiWKwI2I9CJEkbFYFnSMAF8J/PgTEGT++T
         wtKsJ02QPTE/7YSxKndf/94i37/Y8ZaP7C1oT/RRriYmtv4Fw2JFO7Nv8ks6vH31Wkc1
         eZ/3ZyFgyWCg6dTK9qr89MAPUNUveTaMIqi3JYVwbfEYqrd4V3IUi79D/6cwVg0cm3uA
         qMEcewbUrqHYv1VLEMd3rjI524J7J4Av33vLnoWX36xIr9mKAyrp/ltSVXEr3TXJckle
         cUzPg9B0/ZHPH1+bgQX3A3YjNYwC89yzvAoHHqBuk8UNiwJvil1xQW9zQBrFUk2Clt4s
         U1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWALALM3RK8kUeQ6+/N00zpgXKCEEcZvC8k5MnaDf5N4u4rgGME9uh1ED6lUkn88Qn1xitGtaftxT1mH/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOL+q8WwYCLGI8a4uPAAO85cu0X9gir6r0PCYSxvc9bnKnNlF
	p9qsbkE60H2PXcky0yE0j2E8O7MsYSSbpBAk9SjXKNxKX69bRE7nDfI9adhk
X-Google-Smtp-Source: AGHT+IHJn+3sGPKEGZZ3Tgifv4+SIpxYDrPYVVzDdi3bhQNpzECkQraYEWtZyxRoav5wejuMhG5FDg==
X-Received: by 2002:a05:6a00:2d9b:b0:718:e51e:bd25 with SMTP id d2e1a72fcca58-71b26083144mr18746774b3a.25.1727727879048;
        Mon, 30 Sep 2024 13:24:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 2/9] net: lantiq_etop: use devm_alloc_etherdev_mqs
Date: Mon, 30 Sep 2024 13:24:27 -0700
Message-ID: <20240930202434.296960-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems there's a missing free_netdev in the remove function. Just
avoid manual frees and use devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 94b37c12f3f7..de4f75ce8d9d 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -601,7 +601,6 @@ ltq_etop_init(struct net_device *dev)
 
 err_netdev:
 	unregister_netdev(dev);
-	free_netdev(dev);
 err_hw:
 	ltq_etop_hw_exit(dev);
 	return err;
@@ -672,7 +671,8 @@ ltq_etop_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
+				      4, 4);
 	if (!dev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -690,13 +690,13 @@ ltq_etop_probe(struct platform_device *pdev)
 	err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
 	if (err < 0) {
 		dev_err(&pdev->dev, "unable to read tx-burst-length property\n");
-		goto err_free;
+		goto err_out;
 	}
 
 	err = device_property_read_u32(&pdev->dev, "lantiq,rx-burst-length", &priv->rx_burst_len);
 	if (err < 0) {
 		dev_err(&pdev->dev, "unable to read rx-burst-length property\n");
-		goto err_free;
+		goto err_out;
 	}
 
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
@@ -711,13 +711,11 @@ ltq_etop_probe(struct platform_device *pdev)
 
 	err = register_netdev(dev);
 	if (err)
-		goto err_free;
+		goto err_out;
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
 
-err_free:
-	free_netdev(dev);
 err_out:
 	return err;
 }
-- 
2.46.2


