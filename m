Return-Path: <netdev+bounces-205925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D248B00D56
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05561C87F75
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC122FE369;
	Thu, 10 Jul 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrylVnfr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E782FE30F
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180040; cv=none; b=LftbqJuN2kIAMO1i+Hw6cdJGVDFpkcUh7/gvELm+AafhpcHPsZlU9nNPghfi18bT7+oNh9M40tCtGFH2LW2W8tFvrGPPya2bNHgegRsEdjICT4x5HcMlWUS30ua8QpVphTVS37lWLRzaiDoMhhQCMzVggG0gDkKDOafRXNhQ6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180040; c=relaxed/simple;
	bh=gU8SItWMiYLnP3Py45oDGPh7uxjctTzjac2tgaXbdhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L33Rtz8eDuwehpkf1cZ/0trsJUfMm7oqRWhZ+23CLnhOCULfQsox2+iKmX6aj4tWovvC0aZWpk1dJ1IERRP1h6uTSQ73LlgTXPOq6UXEo8LgdLxw16MAQfmRk0O0Y/yczdwV+CnjUIb3HXo2vfXXpHEf2TUIOk39H1twBTPHTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrylVnfr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1329371a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180038; x=1752784838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcMPkU6MgjIRsgZ8uDK3k9r+5TTabwxdl0CAlLrvA6c=;
        b=YrylVnfrAiht1Vb9ulPDM/ZI9Y5c7zGSaD+5gyvmY8MsycH4bYyExrkqEF1R/a8HPR
         DFn0Fg+fO/lkfgw1GpuCyamxt4ZEwz2H3mrCsARjdqznyf5s1rag1t81DJwaGJRTrxB9
         fc2JfgdbBrGuw+CS6yZSLD9E1CQia6bUn2sIK841duX1FI1M/qYJAoT99rog0Dt/tHBu
         VH5G6RciQibaT94P4scdnTp9OiK+CnqSS9mH2RMQ74HH0HpAqok1X60+aI/ib+QbjyS5
         26+DFvI4DF223f/yBT55JbGzrsCTum0QNF8P+cQn+kMjgaYZTioS5ECdC2X8t2QuMEA6
         YxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180038; x=1752784838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcMPkU6MgjIRsgZ8uDK3k9r+5TTabwxdl0CAlLrvA6c=;
        b=MohIrWqQAXXFR1aHalTfVqbrP6rzpLsAmn+Q1sS6Q7s7eKizkesOVZWEt1lf9pHK29
         KKF3BEF9Kpfrv1cPp8Fw+8vnw3zuQ399GgMVbGNw3NbrXS3MZ2ha5gTF8J4+VORCxgIe
         5a2zWUWDLXP+yVXhY+CpJLm/IatJNnQHk/aFSSjPbGgGMsitGqjPjr0nyI+Y8BNoHvA2
         KjbffCxZx9p/+n3Y9VKyyvIpWFHghBwdOtXiAyhgnIYhaU9NiE6rusBz8iVlw5lzAHom
         ejGQTNaaY3Lrn3guzEjk2uw3QeJFr3/HbErYoJ327piphHQbjN5jJZGs2m6+0W24D8UU
         h0UQ==
X-Gm-Message-State: AOJu0YwcE86513QL9UqaPlLRsXuKWqdWNbru0zfjX+AVYkdrMu0gD6i8
	dAFwhRUf0zFbYiY1+/Oo4ClHtYXKGNfGFCjZ++RK+5JUY8R7Gwn3Dbihn5NOP4hN
X-Gm-Gg: ASbGnct/usAjy57fpnmUtSR7OjxgalDbVyVwP7P1KjvOPznk5zgMhaKTHwRev0aAXyy
	xFqSrbO1+JvqqhtaoSViEj/ateY2Dt/MJ83S0S6DC5o8UpxINdP7HsHgbuCp3VxJF25u2yo8prQ
	LGVl0JKkywmy9MeREV4DCYcbTa86bMu9dyWhzm4JDjYvXvha8w+iYMyfmgFrdFp6L7vcCvrLECj
	BaONNR2TFcu7KbzmAIY9ii4moxMKGLSvVFkWNWBZRTHWIz1g6rKuWorgVMUZaIEs/fNq8GXyrbx
	iBl7J5qEkjT03ExMTP3vamYzoTLF/kqPxHAcTn4034k=
X-Google-Smtp-Source: AGHT+IG4I/FIQwH1xHmwieQzZ9Vg+L3Sc+feZiMeUGL7sh0HoH5fw7KdWBbwzDYigvjhU+Gdhwa2HA==
X-Received: by 2002:a17:90b:1d03:b0:31c:3872:9411 with SMTP id 98e67ed59e1d1-31c4f586482mr68133a91.33.1752180038349;
        Thu, 10 Jul 2025 13:40:38 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.37
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 06/11] net: gianfar: use devm_alloc_etherdev_mqs
Date: Thu, 10 Jul 2025 13:40:27 -0700
Message-ID: <20250710204032.650152-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be a mistake here. There's a num_rx_qs variable that is not
being passed to the allocation function. The mq variant just calls mqs
with the last parameter of the former duplicated to the last parameter
of the latter. That's fine if they match. Not sure they do.

Also avoids manual free_netdev

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 7c0f049f0938..05dedb6c9848 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -476,8 +476,6 @@ static void free_gfar_dev(struct gfar_private *priv)
 			kfree(priv->gfargrp[i].irqinfo[j]);
 			priv->gfargrp[i].irqinfo[j] = NULL;
 		}
-
-	free_netdev(priv->ndev);
 }
 
 static void disable_napi(struct gfar_private *priv)
@@ -672,7 +670,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		return -EINVAL;
 	}
 
-	*pdev = alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
+	*pdev = devm_alloc_etherdev_mqs(&ofdev->dev, sizeof(*priv), num_tx_qs,
+					num_rx_qs);
 	dev = *pdev;
 	if (NULL == dev)
 		return -ENOMEM;
-- 
2.50.0


