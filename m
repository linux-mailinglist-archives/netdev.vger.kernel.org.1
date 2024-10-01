Return-Path: <netdev+bounces-131051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D808598C71F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCD91F25669
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD41CF7DC;
	Tue,  1 Oct 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ1WVtUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22A1CF7BD;
	Tue,  1 Oct 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816339; cv=none; b=Bvg70LKGj3BBGqgXGHsfERaCsRrPg0/fT85AQzclVqTXHKbIMLob2zKKxQGJshqjxcSBSQ53LSkme71gg4qNAmp7NzZKnrWtnkGdBI8tBnFQNfAD3EaXf+CYAII4KjnV1NIg+m9RIJPWtcz8un8bHPVI44jVGWNlEPSpuFg9ozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816339; c=relaxed/simple;
	bh=R3/zEAcwhIv1vvXu5eqLy8v9T/QO1blsvg8rxiWDF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhBEYMFzFybx8stilWSmKPH+pQWONIFG8A3urve5044/1BIrwVtRVj4ZuFBxRi9ZFpN5kAhb+uJVJnsQ4Sngy3OfJi/2Cbs9xfI0CM/tVfaHhwLq3Who9Ov1uwZ69Q/0P6GhN+hkh1boZcUpdYidAm5/93fuUyHnRVlUI4VMlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ1WVtUr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71798a15ce5so169626b3a.0;
        Tue, 01 Oct 2024 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816337; x=1728421137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=HQ1WVtUrQ722GAWlMtLRLVJM1b56TfLV9+A/0EOARvJ1aGCol14LrSr0jZmchghoV5
         zD2y1ACb14tGubKFZVvVZ+N9l2xcMOXRzC0X9Et2q8WKqGtWxQ2ZVs8vYhyX//UblK3N
         IW5KbIBzZklgeVO8C512fPOO9rXdluOZFMKU9JLXy/Rm8VxMcs54PmkZA3EsaES2FP7m
         6am25P+Ton68do5SCXyzysoaHWfzAhWPtfLBzFcwv+XrZAhLksrRbmfxHsjSzLCJAXdL
         bwnhn+Df7PEXS/plsz6ufF7JF7uZjWo6JsHi/XjDS1CZtorp87jfdsrD6EivachsyD9j
         GrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816337; x=1728421137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=fIfxkqpyvFloEa4K0OT5vgGSLBByU+k0JZ7B6/O7ISEwxMuaPdvOzdXWuGihP7ab8m
         4V/jUIdI6KToGpGzOaXj0MjXkrKcKZsvNRKADGkBr9nTb6zFE89YiKUigmLKBDJwxTow
         wO7EuC0tG1tocSgS+PZyWnZjioJnU91bcJeOEobVb0TN4vh92Vro18Djr8CFzl/MWSx3
         cnzG+l2fcDfhqsjtlqkiO9siqQ0bI4JWqL5zkRKYC1QVDwzbw7Bg542/PyknUbPt09r8
         +R9BSTdWps7hmRFRC64X8s32i3lfeUukammR77/SaSAvNa3HZvED53Ozfrk9oA9ka5FX
         BrAg==
X-Forwarded-Encrypted: i=1; AJvYcCVGH1QMaJZoPzranKBtfkhkZclj6SpERQqiLdrtWtCxoIjaZ4g6XuXTG6R2B55pPub8w75JK9J+invZWfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEQAcjljubIK4PhZ4r4tDHaIk+L7xWmfq2e9LEZofEVz6fOat
	QtmZoc09Jzv3NNpGv4iue4lOlzNWL2GaCOnzQs0uKmHnqcpwDQopC7JrSzlr
X-Google-Smtp-Source: AGHT+IEICARG8cGqNN3HJIvgRnic4YE+VxZn1idnnY403ZTunAJB3pdd6mecAa1Sm8o9KZO9Gx7wvQ==
X-Received: by 2002:a05:6a20:43a8:b0:1d5:118a:b53a with SMTP id adf61e73a8af0-1d637725a12mr1432978637.21.1727816337032;
        Tue, 01 Oct 2024 13:58:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:56 -0700 (PDT)
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
Subject: [PATCHv2 net-next 07/18] net: ibm: emac: tah: use devm for kzalloc
Date: Tue,  1 Oct 2024 13:58:33 -0700
Message-ID: <20241001205844.306821-8-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/tah.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 8407ff83b1d3..03e0a4445569 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -90,28 +90,25 @@ static int tah_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct tah_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
 					       sizeof(struct tah_regs));
 	if (dev->base == NULL) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -123,11 +120,6 @@ static int tah_probe(struct platform_device *ofdev)
 	wmb();
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void tah_remove(struct platform_device *ofdev)
@@ -137,7 +129,6 @@ static void tah_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id tah_match[] =
-- 
2.46.2


