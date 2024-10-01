Return-Path: <netdev+bounces-131058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6298C72D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272381C21BC7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361721D04B6;
	Tue,  1 Oct 2024 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD6fM2XR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4061D04BE;
	Tue,  1 Oct 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816349; cv=none; b=UvOw+yZw5K9OMbo3Ew11uubfSEOak9fCmmTiYujbUq3LJKLMlOALSz0ZcKNav9sz3xRRct3iFotYgGQkEggtSYMraa8rM+aAw0Q+lwzDsivgdZ9izrIEGyMT8pkzks8azxLR04GK5RFStHVeVt9BQ7kryamiiql4DhpvahyP6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816349; c=relaxed/simple;
	bh=tPMaKKCrP3tEFhfNaUWKZ/JHAt5j/C2Ms8f8SpstWRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D29bLxqFBd/GT52j3oOX4yWysF7y+I3qyp1O9DqF/RN51U47zmVTkxcx50ZUYl5bEcnsumxlg9VclsNdbpdTDx++2MJ7oWqVvQolYMxu+0q0T0aS382QWh8CCSax4BTpXMosVXhCemZXNdfaVjjc9/ep232M4BxkFuO0z6ThYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD6fM2XR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7193010d386so5144570b3a.1;
        Tue, 01 Oct 2024 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816347; x=1728421147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=ZD6fM2XRLw0PajlHufPELfPGlqQfmACA4v9lLMOiTa1QbAlkdpTBgMWChe31jSKtZi
         xNX9u0BvuESd/YCCQj+ABsnMVuR+awhKJSBDjBVgXq/lc4nCKMdS3vvXD13DoDwQQvjN
         Nhf1IHITaB2wk8q4mGemWRULapui3GQD94Fd4OWTNaiiLdqh8IUu5kE1aWKCkqj2Otcn
         D8SVUoe2T2maLtNwMQewjHVMFhClTbtkcJ6GWwwduB2VSCbSZaazsnhOIcSOOVbPRxB4
         kd6ctkXvavS9n6WEKepgEMVa0wBEHBEiV3Du3YvF/eYUfPOiAbkt5Nz+I29/pjkSZn2I
         X+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816347; x=1728421147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2CvXoVohK/pulVhxC+r21/PlsTS5FXZz7L5qVXfWFU=;
        b=AwGo0w78w8U8Ei0wIt0sMjzmOuUZNcEXISWc0vvXp3dCgyDZtEF2yoE/WeNp11zIS3
         sT0OpRSgmijD5bqX8uCuk5BEaKZdFoRxiuEEtTAn8qrtnI1O9RJ4U5MUe2pwlfQIP56e
         YkMEO4trzAdC8/5/DzR0K4Fy3s0V+21r5SM1G1q3/E/1d0IfbCJCLagDu15KO6bi7gAC
         xMfuXw2gYIGM/6MF5AUT0vbwrGGcBAwc0budRsuRIuOdSuS6SXlDQhnH2YpGicMYurNT
         CVu6EEuBBrUjGkXPk9lu3NtEo3nRgwEMSZLxw9z801iqVoYwqqAjRk74fDY60Gju7dlu
         WwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqetJxO5Lk7OJfI6mk1YMp6a2iT5jtinVEPmj4q8xJTDv32SKhACqMbSo8VMBU2x+m/DWh+l2ovoKNeiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+5bylTDOkIxeCTR90GeSEP/xpesyMr+P9Yjrht/xL3AYlw9a
	H6sQS+vnCCbqrxtjRvzYvHR1xxs4Mn5pp74yd6DqwlNy2zcBcye+LTcjNOmB
X-Google-Smtp-Source: AGHT+IExqskSEPlAaAbl03P2c1voIEJdJ164dJl1VdCiwHO8F0nt0h1G2m7qpC6svetf+ya9cFr/Gw==
X-Received: by 2002:a05:6a00:21ce:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-71dc5d5c02emr1486774b3a.19.1727816346801;
        Tue, 01 Oct 2024 13:59:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:06 -0700 (PDT)
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
Subject: [PATCHv2 net-next 14/18] net: ibm: emac: mal: use devm for request_irq
Date: Tue,  1 Oct 2024 13:58:40 -0700
Message-ID: <20241001205844.306821-15-rosenp@gmail.com>
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


