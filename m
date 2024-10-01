Return-Path: <netdev+bounces-131057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE54398C72C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6E4286139
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71A1D04BD;
	Tue,  1 Oct 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEdYJizs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA361D0480;
	Tue,  1 Oct 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816347; cv=none; b=KKF/IcSFVZc/FvAeAFRipJOIYl1BD0vEcYp91I0VySHDyRexFlrkVapg6rJMsz+WAEBMs1GwK3PwXx3jP18QPGMoLBz/JDsm5u/tjTbH+hH9xcxAZoDywnKbu5X5paryEAtK6zF3mzO6/YYNGpIaftQCsqgi8QPpuovwZwJRiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816347; c=relaxed/simple;
	bh=kih75HuZ1ZXc3JQHkzwuj//sPN9nSONeRe7im09vADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mD+Nz3ZsrfDUyfpGRTqyvy7cypbfAIVl1MyfFxbqHpgQ7fLSr5XEKBdh1xJWYFZCANj0fbDUtSBOVbgZbExLrI4CzO/Tn9pm5X1xeGSLWhj6YjNjjrJ4KaxtyStihfQheIViScB5tUc/1Z3u/h5VVUnygAfN4TsyFp23zNsxiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEdYJizs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so143472b3a.1;
        Tue, 01 Oct 2024 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816345; x=1728421145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=iEdYJizs2gYyID5wiR64E/pt1edqBYSeAO3BEYiO3ZYpbvmXO4oVp1oBSp3HlfCB+p
         OvQNcTtMMoTrRaAvPDaPzydtlxq6QtqqNVYdqaBo9D3brIEjgMPk59caC9LNCdrO4qV7
         CHiVAGIxnfbrwgQupUKT85n+l7se2vFwoP7waCg6fAUjTXriT/TIQjq6J11ws/+a0aRc
         ORGE6ZGwTgg7ZnPG86xXJizzW87uKOYyZmYIkgmB+obJmGWoeHR/N17ZM1WzHxXfj6kv
         W3hU6FSHvODYF8IaB1ZM4pDeu4HA0hOsg70FFlbq+5ajn9vrnTVmuY/AUllb0ZeVgewj
         TI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816345; x=1728421145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUV0cdXbjkkkderKYay9dxBu1U/jTzVeigZXhXzokHI=;
        b=r8MG911U/bfXJ3B1Yd2nGSo6Yc+S5dNpO03XKP/OxSOIHSJQLy/MN22OcR01WTok8E
         5cS00S4AUcj6yp3Qscx8FgO8esf0cl94slOnqbcaDk8Wn6eygV11NralGE1nfJhskpNx
         4Vyl3sQ5m3OKYmZmltxt/eHo2c9SkPbqErcMO5O76i5NADFc/gnROhXFGgQqd1SFxLz9
         bqJLItqkZWIb+Dg24ESmKHJL056HVi6+y67aHhMgo1Ts191UUuCCqnp1rNoLad3Kfa0g
         xYvwx2Q71cpvSqIB2A8nmnJvl8eKW8XDKPqzEWSktDDNzmbKnzVcyDINgiwVwCjyMy9A
         hxMw==
X-Forwarded-Encrypted: i=1; AJvYcCUXPn0BmzY1K4aTwLGEfm/4GE8H7JRDeZSRM6c9EwMyOWXuPuABLFsL5Im928nYP4YIrLU06sQK1ZdKqiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPG4GcHlM+NuM+GMznIgy+NV88z6fnbOh1HK2ju3fomWBV9Bk
	X6d6kQ/vF/YbtUBmi//u6RfJP97v9rIobDQ8RdJM1XNLNAYdq+NgvwfAXzVh
X-Google-Smtp-Source: AGHT+IEPxzvNScKQNQm7dPkLR90wp5u61+WvMqPKalhuzUb0NjIffa1x8azk9U+tSHd6wFEUw0mLTQ==
X-Received: by 2002:a05:6a21:3996:b0:1d3:1fea:27d8 with SMTP id adf61e73a8af0-1d62e1deae6mr1303764637.5.1727816345372;
        Tue, 01 Oct 2024 13:59:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:05 -0700 (PDT)
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
Subject: [PATCHv2 net-next 13/18] net: ibm: emac: mal: use devm for kzalloc
Date: Tue,  1 Oct 2024 13:58:39 -0700
Message-ID: <20241001205844.306821-14-rosenp@gmail.com>
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


