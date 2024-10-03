Return-Path: <netdev+bounces-131453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A598E857
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E745BB23920
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DD145A05;
	Thu,  3 Oct 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGdMD9Qi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CA13DBB1;
	Thu,  3 Oct 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921521; cv=none; b=QA9QpPVo9J+YeEhh3QlcQU/MG4fdtADSKcMvPZjrE63rID5Zs7vR0etEE4SkGvQNfMW2QdeFIyVfvGmtshVoq9yg3wtbOrTopZOy1y33UqPb/6cGMz+4b7YqxvsZFubjE4XlKhbk8lPJ7IUbFuH7F7p7CClLDENC4sUrPvJx9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921521; c=relaxed/simple;
	bh=tPMaKKCrP3tEFhfNaUWKZ/JHAt5j/C2Ms8f8SpstWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzb9EOb+/t6/CsOrdjA1CDakMEUErYm++/WWrExvAg7ik/zkUQIzMxZkw/H5RlJATTxwDg/08p6LUw6tVHNTNYdnhlRPa8px2OAEPHPzr739y96rSSACuUIDYhdsMtekLbXTwex6DVnMV/QkyJGIKE+FQr29H8bXCzt6eJykXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGdMD9Qi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d704704aso459335b3a.3;
        Wed, 02 Oct 2024 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921518; x=1728526318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=JGdMD9Qi0JMnL6xx9+hm8+q3AJdh3yN52gzJciGEbzsVtUWk5QvGCPTn11f6Bib7uH
         /L6JPRaWYqPhXAqLVQy0SIcPP0xwweg7qzrcZzObvtgubAn+kWiF6FQF6ZbqDIseq8zL
         CwtUhOK2n0bWkSn5BwsHHIDeg05fcyr25TASWR+AGFJRTn9iJTFCAzBPHod4tnY2vUFY
         x6MPR08zOMEKYLLLgoIBQFMqIMz3DiA0Y2AUkPHr4kY+4akmcYm45SvlO62edJgIHPzX
         9dKluMD/C7lu7ys5EcnlE+1FUJRO6vMlS4IyMMqBcfVo6GRIFjQuDfRgILkJTRLoJVFH
         Zpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921518; x=1728526318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=iQ8B8vXZ6qNiI1TK4KXft8gwY/F4y7rlqKbmOEeCSYgBC3cjwQPvoFgW48qui+4ojq
         SsiLJ02Pw9sRCbV9tJrk3kmrph955kcqL56k2CUV3ZD5viTrn36t7DqtsKJYmKwLL14W
         RjZ5uKZa1RKsWjvokHXiSwKlTKwonT6j0iHi7d1kUf+uopL1BOT861FCW9LuUSCHOtCr
         vTE6EtB4H99edzLsf3OYshXOCqo+ujkvgedguLBajScB922dLg0+ypVusJZKmwXx4eCn
         EaieA1wgDsxo/OIhsa4Dx7mkIbZUkrczeLlWPOleT5Ww3fvIEJ7gDMzf4beBpseJDgI/
         0T2A==
X-Forwarded-Encrypted: i=1; AJvYcCXvzj2fWB+76Pg32S6XI0hoUX/CFukgeBEhQKn+dSBHXlJzfX1VQwMGaxXEgrHrjoZfHUKmhZVqu2pdKOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtET+z4pYVacriuiuiUskIWBSdjZoNekd7eXRKRIxIg1a98Eh
	r2SNhqdZNOOIkznWZWKKmWXtsZc7CHwyifeHBc0UodUZdaZlI9155Tt+5S8J
X-Google-Smtp-Source: AGHT+IEs5Un/Ry7HvMhIlekhzfz3MZuxu+S6gQ8h3zzfnHjxgOKkY31gHARC526qPiGpU/0tzLTvPw==
X-Received: by 2002:a05:6a00:3d47:b0:718:d7de:3be2 with SMTP id d2e1a72fcca58-71dc5c924cemr8222034b3a.14.1727921517692;
        Wed, 02 Oct 2024 19:11:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:57 -0700 (PDT)
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
Subject: [PATCH net-next v3 14/17] net: ibm: emac: mal: use devm for request_irq
Date: Wed,  2 Oct 2024 19:11:32 -0700
Message-ID: <20241003021135.1952928-15-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
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
index 70019ced47ff..b07b2e0ce478 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -578,19 +578,19 @@ static int mal_probe(struct platform_device *ofdev)
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
@@ -660,21 +660,26 @@ static int mal_probe(struct platform_device *ofdev)
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
@@ -693,14 +698,6 @@ static int mal_probe(struct platform_device *ofdev)
 
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
@@ -725,12 +722,6 @@ static void mal_remove(struct platform_device *ofdev)
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
2.46.2


