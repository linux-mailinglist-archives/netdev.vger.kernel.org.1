Return-Path: <netdev+bounces-131060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEED98C733
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2895C285877
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB96F1D0969;
	Tue,  1 Oct 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLeVRkEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0041D07BC;
	Tue,  1 Oct 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816351; cv=none; b=g9sDjlSmgpXulcBePpuTYWqS4Pgyl8ycNaRViB7tG/pgK6MQudYjxWHg1+ugGqwjwpGWZkhoCIm+hbguttFO/Ngqii7UnsSuv6zrsHgMmu2+jaT0BgpXbk8RtK9OpjR7rm2Co5u6cRERVj6TvWmgYUSO/4KxGFrXuZsQ+yKG22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816351; c=relaxed/simple;
	bh=/0DU2D4l0suTpTwxFVnBC2pcYA9TXDtFcn/7RuksLhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6caJo5/FLucnV9Li7sfsE5BhU9n2WPEufCDncqg1xJEH/mB8B1U88ooM53CfFaZf7blOK4csjluYitfRyZe7C0ABHFxsd4PajH2WMYkCs4rYrsUYYZa+t+/5QGfQdCmcbxIqwh+/A4P+LSLtbWkhcr7nqMsFQsYn9YoVYJJvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLeVRkEP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso5009052a12.1;
        Tue, 01 Oct 2024 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816350; x=1728421150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK/BBviZxJUtdFW+6zpJff7e0YBzhNFMUMwbSlcUsKw=;
        b=lLeVRkEPwbccx5TJyRqTH8kwXPisMb05YWUmop/fncW2RKIo+ZjhkfauxTvq0085uh
         ndWmLCDM3IFZuGcjaHIZWbUebJrIMmNKQ1WWqWNT3RVWfU6i6OXifGQrInOPHGd+3S3Y
         AixqgVAzO4FwM5sUsQ3bT1AHgK6HkjBj18ey/PYStdD0tFSagbAO7Zl7D34oV61jukmY
         tmqh8NbbvfaxLo3BCVNRWCD1a39RFu9DCEF0KM1ey5/4RqbP0Zaz/ybyF526yEGWoncv
         TWDcBfU1NHSPxJoXbWt7hf7RXbWb9nHDhJFLa+cDS5i2bdHFG+RFgZd7uJckRZM26qYx
         frAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816350; x=1728421150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK/BBviZxJUtdFW+6zpJff7e0YBzhNFMUMwbSlcUsKw=;
        b=JOHWrkWfnwQLr86g41/e6pHBIeWSVZnFF9f50tRzUc+c6T2MCfSb0wKudHnzezs8iX
         oPt24EL/ZQ0XxewZaC2bvfp3DQm+awg45AO0o02sKFfPriuMDQDhMSaQtMBBawpqyA7Z
         h1Pl9NrLxFbMmzA9/AftKEWEg8zigOoiwqm4MA7jxYaHAPPhPqNX9qlPEcaJQfUan1pY
         6eT9OmcYP1xz1TYSQiXrq/rvd6GlMRkE30UG/6UqNZLth1UgHS2DckEaXG8SL3tn6zVE
         CE7Z4mAm1DLIG2k4GEo4sbBqdf/L9MbOj2uXKcs9rMLfbJ9jZIka7EiNGfXaBox4daij
         TxEw==
X-Forwarded-Encrypted: i=1; AJvYcCV5BS0zcMDqqiCIvBXW+d/FKXsQ/ZmuU2xtC2ja++FLJFXuEwSQyODqd7blCqsTMkBGdlNw4InRHabfOsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqlzVEC7B7Xgibq1ZJI3+LMOMI0BCYiDCbPuhsU12V7pRFnsI
	mTIEuqMOtBa5pQKCowO+N6Rw7C7/FZFS15WEs9UaOHKf5nEPFGOARXUmwEhz
X-Google-Smtp-Source: AGHT+IEqR3Ntnw9FH4GLtsZ5pJzLemMtDGf6vcKhQouuIUbDygeYNjlSsb+48YPbkHKPpeFOt/GXsA==
X-Received: by 2002:a05:6a21:3a96:b0:1d2:bb49:8e6a with SMTP id adf61e73a8af0-1d5e2d7b851mr1593055637.34.1727816349675;
        Tue, 01 Oct 2024 13:59:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:09 -0700 (PDT)
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
Subject: [PATCHv2 net-next 16/18] net: ibm: emac: mal: move alloc_netdev_dummy down
Date: Tue,  1 Oct 2024 13:58:42 -0700
Message-ID: <20241001205844.306821-17-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes a goto from the probe function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 3fae1f0ec020..71781c7f6dcf 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -582,15 +582,6 @@ static int mal_probe(struct platform_device *ofdev)
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
 
-	mal->dummy_dev = alloc_netdev_dummy(0);
-	if (!mal->dummy_dev) {
-		err = -ENOMEM;
-		goto fail_unmap;
-	}
-
-	netif_napi_add_weight(mal->dummy_dev, &mal->napi, mal_poll,
-			      CONFIG_IBM_EMAC_POLL_WEIGHT);
-
 	/* Load power-on reset defaults */
 	mal_reset(mal);
 
@@ -618,7 +609,7 @@ static int mal_probe(struct platform_device *ofdev)
 					  GFP_KERNEL);
 	if (mal->bd_virt == NULL) {
 		err = -ENOMEM;
-		goto fail_dummy;
+		goto fail_unmap;
 	}
 
 	for (i = 0; i < mal->num_tx_chans; ++i)
@@ -684,12 +675,19 @@ static int mal_probe(struct platform_device *ofdev)
 	wmb();
 	platform_set_drvdata(ofdev, mal);
 
+	mal->dummy_dev = alloc_netdev_dummy(0);
+	if (!mal->dummy_dev) {
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	netif_napi_add_weight(mal->dummy_dev, &mal->napi, mal_poll,
+			      CONFIG_IBM_EMAC_POLL_WEIGHT);
+
 	return 0;
 
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
- fail_dummy:
-	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
 	return err;
-- 
2.46.2


