Return-Path: <netdev+bounces-132457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337E991C1E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CFD1C212F4
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3517BEDB;
	Sun,  6 Oct 2024 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHWi+FxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F0178367;
	Sun,  6 Oct 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181747; cv=none; b=X5qnVkg7oHzNfW3NUSUyINwFHutPrlYsaPBj6NC5MDnF4zff7bUycE1wTLXbnzn6H7AKoKtAfZk2v/MuZb1WE4jSZNdgB/7zBJaw6Ysz0+fa52a4k2SpXcP5RGxFXfBhvJ2YDR9/n4K6HlGcwpakKWZd9+ogZeFO2/6bPeqF+Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181747; c=relaxed/simple;
	bh=kih75HuZ1ZXc3JQHkzwuj//sPN9nSONeRe7im09vADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1MVt7ATJL7LMt2mPWeAuuILXjxZIxSw2Fl3FTXRiCFfJUSzgWLDM2hng5rAwKNxFpbiwd7rFZ28gk46jB4KyGvl5DKRu3Se8wpreQN0yvE5ixbHUPhC0oVUZU1g6p6fgVqYNM3OR08FoJ46fWhfDGPbSufYCm+MlLFqvOVzvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHWi+FxO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1980973a12.1;
        Sat, 05 Oct 2024 19:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181741; x=1728786541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=hHWi+FxOWtRfgjMkMjVWnfIBPuzqfRt8sfcBaL5Yuw0l71a4XBSCfmFR0CnKmNFLqg
         /aG7y7ifTmplNP+AHAmhztDwtncn4W+Ga2uy14I6sUCLD23SUPzix+qdw5+6KAR3TjRl
         bEmiFvMwig6o6NCs9i0Hc+nCvsMfiRlCsQttFnRnEqYA6NCjiJGPfnCE4wbL25JUf+M2
         rx3pn9gh0Skg2yoWOke+gLEP/9GGM5SvnuZnrtY8swwlsC630vxkTjQUh/vihBxWRWCA
         YA0wUzqtrfKQ5xKpY0Yyu0in6al1wSzCHV+9+J7k7mMwaKRXIzVnM0NpHq65hzGgK6hp
         ZZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181741; x=1728786541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=KsrTiaJyKnkJYbB8PB5RTxpN/k/loUD2eG4HqPnzjDeqYAO+/t23kCJadY5c/72BJQ
         i/IrK8v1lblJWgxteJa5X0+NeVkSy6qUx/CPcCFVSOKnM3c9bBXozktdc3/rAQ3HAzlo
         BPTfkzTRTwZV9f4GeysYy5XwUzZGwCjgrYkxyHr+Nos7onpo2egYPUu6Lmy9Wr7X21ef
         vdxoHoEeL268piwsJ9cLNzim8INc0BipLgWIxNjk4GZnusYKK+flRBvOAuqjLGlaxySz
         si+mpHpmn3z2BwsjjvSSasGTJMajIgsuba3YMyzPTdDveiOXenVbt6dRgEl1XkfWvbHO
         WjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3foyv5jQA3gXlZAHFAXHjmV1L4V604u3jfhpguWTxJNHqyfVg6J/Hzq3uYGzfqDw+gg2vnb3Z9wuAwpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKKtsTRZ9+KlPqmSzlDrp5ZevG/Y5wlo1MLtOHcufjvZkgtlTF
	4ojinLkVLDBnv+Ay87QATGlP22vgyX1+BJSRy5DKT6r2kHluRwQdgaeuxw==
X-Google-Smtp-Source: AGHT+IFPhKR7GQ4wNJbmoCs4peccILPfqn3lvDXQNeHck0E5mQFV8LUK8UUUYryb77T++LXf10K7tQ==
X-Received: by 2002:a05:6a21:3318:b0:1cf:3838:1ed9 with SMTP id adf61e73a8af0-1d6dfae3320mr9240858637.50.1728181741141;
        Sat, 05 Oct 2024 19:29:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:29:00 -0700 (PDT)
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
Subject: [PATCH net-next 10/14] net: ibm: emac: mal: use devm for kzalloc
Date: Sat,  5 Oct 2024 19:28:40 -0700
Message-ID: <20241006022844.1041039-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/mal.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index a632d3a207d3..70019ced47ff 100644
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
@@ -577,8 +574,7 @@ static int mal_probe(struct platform_device *ofdev)
 #else
 		printk(KERN_ERR "%pOF: Support for 405EZ not enabled!\n",
 				ofdev->dev.of_node);
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 #endif
 	}
 
@@ -711,9 +707,6 @@ static int mal_probe(struct platform_device *ofdev)
 	free_netdev(mal->dummy_dev);
  fail_unmap:
 	dcr_unmap(mal->dcr_host, 0x100);
- fail:
-	kfree(mal);
-
 	return err;
 }
 
@@ -744,10 +737,9 @@ static void mal_remove(struct platform_device *ofdev)
 
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
2.46.2


