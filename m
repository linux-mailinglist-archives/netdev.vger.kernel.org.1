Return-Path: <netdev+bounces-140547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79809B6DE4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86EC1C21B5D
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9B21A4D5;
	Wed, 30 Oct 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0aKRU7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD43219C88;
	Wed, 30 Oct 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320672; cv=none; b=czsAms/a1oUM3sni7CH7ZvVxH2RAWfI4G4PXt+IsvuP2BLnqmXC+cAevd8U6KbF3hPTav0VTFxmCxlxEs301afAmpTGhoeDO/WG7zkQ+U0EwS2je277ydE1PPqcEZH6lE6GQN9nrJAtpFC63KmGWVtrxknpJI6QNka80iIUYU5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320672; c=relaxed/simple;
	bh=Pippea4A0H/5O0N0+1LmmcHeawuPIfLMq79gNqGFIEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeUTUaW6i/Io9lyV6wLrjd76YUZOQmy3sKJ7WLpqs6gBpj1OaV9H/aQcXrC91HDxOg4ldbe3QEpO2tAGeC2NDu0fCDw6sM7jzyNQSEFa+nUyrp8qc1X4g/bfk7EibtAtm3weWJ+7ZY2ayZAxi/l5idnkaWl+RvQWK/nBObmxfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0aKRU7u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbca51687so2662885ad.1;
        Wed, 30 Oct 2024 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320670; x=1730925470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FexutNNiNogmeYOctg/LStxLING3hlfbG5xuaoCRTR4=;
        b=l0aKRU7u18SmSalbSZPqREU0Q5M7Tp9HdzhPSnticY6rtzOH8qqZ0h817qRKNt/BTK
         zOJAOGHsDj5pV780Bz8O4wPSLZcbKjAeDaIYLrftEBRhgMlYcSFcm3P99LwW+jQd63+U
         fs6l48HMbvA7Wv+fvunHf8L2AMMHaZxIMD+VqugrA9WK1N7gu+Pyf7VhYO9H9axEZE9A
         KaEmzf4R+gzGAj3894MWThQhLRdgv2gZ7/9eYo3ivU5HzehRbjxc8805jGeZV0bsp3wq
         8Q8xc0ihcY2DBmD/sVOdpziptroRCCBR7+KwpZSrq3h7h1o6Fc1P5RDvNEjx5A8go/Zu
         bNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320670; x=1730925470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FexutNNiNogmeYOctg/LStxLING3hlfbG5xuaoCRTR4=;
        b=hTvra9lnnxOH/OQQSXmiFuMoyP6UaeCmuYHipmZEnrTLO4XVvA53ZyjdgS/hXk8wFy
         5xoAHeVcaL2b+O/UO6ITvfRcT/o9vnsFkWK3fvcYcKAJc+I8FpSNpFo2bSu8u6Ufgqzl
         ymirafOkjv3jgQWK1K8qoNJePop5Jno/BT0pfpkfXqLYAfQ/Vh2TF/ws0JiLaLwNDkfX
         Uy3uvmwUwKoEOfcn27TwQ3FO2MfbJuDGzrDXVBHhWkfpXmfxUF8ovl0gS4GkBjkMA6fJ
         Y1gk98SPn2FogtBteE84UsDhnluugOvA0fUNphNms5RjHpGqpvHDNKANVYRq3/IDHTKw
         f4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWGcCujQFh1EFusgR/2WLszWRnJuMzJSUAvGIAWYAJ/b5c9B1bfZ8aIN2qnB7wVMURHK+kJoupqWSGNaQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKCl6WxMuzZrcyy5v/zqSZRJJAVmocmCBS4zhNaW0Qm66GeHf
	ybW5leHsOGx3X+OeCLBZEz31sIy3aXrXs9jTQQaKN8cJZmCrNXFTpZjNv5+K
X-Google-Smtp-Source: AGHT+IFD7vdoW72C+WLtt6VoJCNQSDzctDbRK+J1vSlX514kcP7Pnoagz8rZLd9TehylYidOrhF5Cw==
X-Received: by 2002:a17:902:f64e:b0:20c:ef81:db with SMTP id d9443c01a7336-210c6c01188mr222383835ad.28.1730320669927;
        Wed, 30 Oct 2024 13:37:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 10/12] net: ibm: emac: mal: use devm for kzalloc
Date: Wed, 30 Oct 2024 13:37:25 -0700
Message-ID: <20241030203727.6039-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index c634534710d9..f1f5e805ebba 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -524,7 +524,8 @@ static int mal_probe(struct platform_device *ofdev)
 	unsigned long irqflags;
 	irq_handler_t hdlr_serr, hdlr_txde, hdlr_rxde;
 
-	mal = kzalloc(sizeof(struct mal_instance), GFP_KERNEL);
+	mal = devm_kzalloc(&ofdev->dev, sizeof(struct mal_instance),
+			   GFP_KERNEL);
 	if (!mal)
 		return -ENOMEM;
 
@@ -539,8 +540,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-tx-chans property!\n",
 		       index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->num_tx_chans = prop[0];
 
@@ -549,8 +549,7 @@ static int mal_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "mal%d: can't find MAL num-rx-chans property!\n",
 		       index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->num_rx_chans = prop[0];
 
@@ -558,15 +557,13 @@ static int mal_probe(struct platform_device *ofdev)
 	if (dcr_base == 0) {
 		printk(KERN_ERR
 		       "mal%d: can't find DCR resource!\n", index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	mal->dcr_host = dcr_map(ofdev->dev.of_node, dcr_base, 0x100);
 	if (!DCR_MAP_OK(mal->dcr_host)) {
 		printk(KERN_ERR
 		       "mal%d: failed to map DCRs !\n", index);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	if (of_device_is_compatible(ofdev->dev.of_node, "ibm,mcmal-405ez")) {
@@ -711,9 +708,6 @@ static int mal_probe(struct platform_device *ofdev)
 	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
- fail:
-	kfree(mal);
-
 	return err;
 }
 
@@ -746,10 +740,9 @@ static void mal_remove(struct platform_device *ofdev)
 
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
-			  (NUM_TX_BUFF * mal->num_tx_chans +
-			   NUM_RX_BUFF * mal->num_rx_chans), mal->bd_virt,
-			  mal->bd_dma);
-	kfree(mal);
+				  (NUM_TX_BUFF * mal->num_tx_chans +
+				   NUM_RX_BUFF * mal->num_rx_chans),
+			  mal->bd_virt, mal->bd_dma);
 }
 
 static const struct of_device_id mal_platform_match[] =
-- 
2.47.0


