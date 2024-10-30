Return-Path: <netdev+bounces-140548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BF9B6DE6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60152825D4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1EF21A70A;
	Wed, 30 Oct 2024 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D37XqUCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AC219CB8;
	Wed, 30 Oct 2024 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320674; cv=none; b=RX0xiz3qDR9te93VqdgWLmymUqvx4RF5AqcmUpyXOxw32aYo3pkr5awKSmsO2omVPtrpIKpqZGVmh9Jye2rvCNau86Ki4TeDxZGJVmzSS05J615oQFZ5jmEt0zLcrN4tmPE8tocCRNqecGkJCMRQfMzgI4sEaN1ohaxjGqrqvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320674; c=relaxed/simple;
	bh=/K5++S38XfNOZWH6vhXti7vJhwOaQ5IyE0gLS3qtgeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYPmWxj9fVxCquI+y6WPWe+w3w9WKG4Yx497+rk7+wqDXcNgNZaWcKGcMDRNQRkVO5JGVmu95kMet5vqkQr76PVNVWfRcW0WmnGVKUHSNXTYZQsp+eNSzgRhP80WJVdv3N9lvJ8f3/hg73l/pv3vaFpfZRpMR9f0P6LypSzTPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D37XqUCf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20e6981ca77so2923645ad.2;
        Wed, 30 Oct 2024 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320671; x=1730925471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VAXIt8AhQYwCN28Cvrq4oXREVihAdW454RUv6EGuGI=;
        b=D37XqUCfbDkkFHu2WHy4I4HcjUtNkxBUSPQMo61KQiKw9pV/IKna7W3ixT7vYcdFj4
         1t6EnDjJqoF3ADtX+Kq1jeIY8b6okjyEQyzcmuRQOCm6b7Z/RDwCOh41UMaPIpcXwshO
         UV5c9QH3n89D5RgcFGicq0LJIKAhphI52U6fzrkhNUrEv77uQDLpOp5vlXfh2Igs6E4U
         cw3nSYj9do5KUKwAHUwDEMYfcCf9gMHVfiVYMElA6Gskz66vsXFCCmYA1pAM62AJ2+kX
         Zg/wmC89ai11tjb2l08IzoQv0Fsxt9/jQK2dQHVg31qTlxvAf+dg9chamX46TbjkR/VL
         DOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320671; x=1730925471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VAXIt8AhQYwCN28Cvrq4oXREVihAdW454RUv6EGuGI=;
        b=C3ZPM0q1MomIGM7GGznGU5bCTb+aoFaccYkzCM7uENC73aKsvQViCrRIqnkXOY561G
         lfoJVIzqZedwYvy4Etz6tNGs7DDA4P/zhEfRrPTd8x78fBnAcguutit1zQV2+cr0N8vE
         YiZiKkkloUCynDJ6jJgYbd59A0KdSXmyj32N421/rpSieqf4Patw9axVtGlekZRTZ+nR
         r+4pLUBSVEbzg+AiGPZB8NjxAolJsQkWDvFw65KGc4pbiVy8ECbWGFU0wiO7PLE9sDZM
         ysowozZ9rq+T9PmPvNcZ2zycYPWa9h/xOS+mwP8lKYf8DSNhHg3CIk3tMg9bz2iWJ6uE
         BHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWmRNxSnk3m86EzYufPrzWx8VJN0i42taWKIFvdiQSeQfpSWz1Ky4maO3wBzk8b2BMQ5oJtwaalKiu96vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzV9xTBd+TMJOMnTI+EisGCmBf7zSp/PVzulZPhtxi6V2q7hd9
	p63trEtdqqMu6zpaf96oRITFSgSvCQtnIbmysXc/1heNzNHolJqlpj1U4Bkt
X-Google-Smtp-Source: AGHT+IFuVNdOWXsLmAfg6Yrfd5gyDTk3V7xa+havLkLzGaWG+VTUxYHZ1o3gc/txY1FyrH7kQ7sP5A==
X-Received: by 2002:a17:902:ea0a:b0:20c:b876:b4eb with SMTP id d9443c01a7336-21103ca9ebemr8403085ad.59.1730320671355;
        Wed, 30 Oct 2024 13:37:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:51 -0700 (PDT)
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
Subject: [PATCH net-next 11/12] net: ibm: emac: mal: use devm for request_irq
Date: Wed, 30 Oct 2024 13:37:26 -0700
Message-ID: <20241030203727.6039-12-rosenp@gmail.com>
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

Avoids manual frees. Also replaced irq_of_parse_and_map with
platform_get_irq since it's simpler and does the same thing.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 51 ++++++++++++-----------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index f1f5e805ebba..db9faac21317 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -579,19 +579,19 @@ static int mal_probe(struct platform_device *ofdev)
 #endif
 	}
 
-	mal->txeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
-	mal->rxeob_irq = irq_of_parse_and_map(ofdev->dev.of_node, 1);
-	mal->serr_irq = irq_of_parse_and_map(ofdev->dev.of_node, 2);
+	mal->txeob_irq = platform_get_irq(ofdev, 0);
+	mal->rxeob_irq = platform_get_irq(ofdev, 1);
+	mal->serr_irq = platform_get_irq(ofdev, 2);
 
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
 		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
 	} else {
-		mal->txde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 3);
-		mal->rxde_irq = irq_of_parse_and_map(ofdev->dev.of_node, 4);
+		mal->txde_irq = platform_get_irq(ofdev, 3);
+		mal->rxde_irq = platform_get_irq(ofdev, 4);
 	}
 
-	if (!mal->txeob_irq || !mal->rxeob_irq || !mal->serr_irq ||
-	    !mal->txde_irq  || !mal->rxde_irq) {
+	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0 ||
+	    mal->txde_irq < 0 || mal->rxde_irq < 0) {
 		printk(KERN_ERR
 		       "mal%d: failed to map interrupts !\n", index);
 		err = -ENODEV;
@@ -661,21 +661,26 @@ static int mal_probe(struct platform_device *ofdev)
 		hdlr_rxde = mal_rxde;
 	}
 
-	err = request_irq(mal->serr_irq, hdlr_serr, irqflags, "MAL SERR", mal);
+	err = devm_request_irq(&ofdev->dev, mal->serr_irq, hdlr_serr, irqflags,
+			       "MAL SERR", mal);
 	if (err)
 		goto fail2;
-	err = request_irq(mal->txde_irq, hdlr_txde, irqflags, "MAL TX DE", mal);
+	err = devm_request_irq(&ofdev->dev, mal->txde_irq, hdlr_txde, irqflags,
+			       "MAL TX DE", mal);
 	if (err)
-		goto fail3;
-	err = request_irq(mal->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->txeob_irq, mal_txeob, 0,
+			       "MAL TX EOB", mal);
 	if (err)
-		goto fail4;
-	err = request_irq(mal->rxde_irq, hdlr_rxde, irqflags, "MAL RX DE", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->rxde_irq, hdlr_rxde, irqflags,
+			       "MAL RX DE", mal);
 	if (err)
-		goto fail5;
-	err = request_irq(mal->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
+		goto fail2;
+	err = devm_request_irq(&ofdev->dev, mal->rxeob_irq, mal_rxeob, 0,
+			       "MAL RX EOB", mal);
 	if (err)
-		goto fail6;
+		goto fail2;
 
 	/* Enable all MAL SERR interrupt sources */
 	set_mal_dcrn(mal, MAL_IER, MAL_IER_EVENTS);
@@ -694,14 +699,6 @@ static int mal_probe(struct platform_device *ofdev)
 
 	return 0;
 
- fail6:
-	free_irq(mal->rxde_irq, mal);
- fail5:
-	free_irq(mal->txeob_irq, mal);
- fail4:
-	free_irq(mal->txde_irq, mal);
- fail3:
-	free_irq(mal->serr_irq, mal);
  fail2:
 	dma_free_coherent(&ofdev->dev, bd_size, mal->bd_virt, mal->bd_dma);
  fail_dummy:
@@ -726,12 +723,6 @@ static void mal_remove(struct platform_device *ofdev)
 		       "mal%d: commac list is not empty on remove!\n",
 		       mal->index);
 
-	free_irq(mal->serr_irq, mal);
-	free_irq(mal->txde_irq, mal);
-	free_irq(mal->txeob_irq, mal);
-	free_irq(mal->rxde_irq, mal);
-	free_irq(mal->rxeob_irq, mal);
-
 	mal_reset(mal);
 
 	free_netdev(mal->dummy_dev);
-- 
2.47.0


