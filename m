Return-Path: <netdev+bounces-132449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E828E991C0E
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B65B21ECC
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED716F910;
	Sun,  6 Oct 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn0snmzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016816B3AC;
	Sun,  6 Oct 2024 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181733; cv=none; b=bRKU1LAggQkRHNhK1hjw4VVuV+LkzUbF7tq6+KKLrFyIizor5d4WOtuiTdzV3vDjQLaqJZA1Jwlhxxg7yzEdo04wgI8PViwkmS7O59IoqK4EZreP3sLRu4XGvTk7PzoMkJKUVgySBmphXMGbMcTDvp9wEkER2o6OhBhEjFjnSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181733; c=relaxed/simple;
	bh=cGZYR46vn3S6kBIU/qW5wOJ10h0hXB5KoiQH4dgiaCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/OXbM8Co+EO0YrS9YsMvY0JqZh8z+g0H8rqJUOkMRLMkeP3kc1HTl8DKO2SSYZINGEJn10iFCZvFjJ6SWB2rQAhYd1ICnQCG+leLZjsO0lwRujPBsz3rGXv3RT3TpRgV0Gb+jEQUkiu7JwKYmVhOy8NWm5LWlgZ2+WyhICvHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn0snmzK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dfc250001so280082b3a.2;
        Sat, 05 Oct 2024 19:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181731; x=1728786531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZXLrsBCw6gVIeraVKvj6MQahlne4BpDoCPrU6lTBVo=;
        b=hn0snmzKtqaLRFlSDokUkIfHZFxx2nbxnE18U7hI5j8c/XCM0sQlCF3FBvYllXl+LX
         aYaDmkALmj8o3IIM3nf+A21XeQPBvqv4l19fzQtguADWcTSFW4POvJUr60JHGcCUtYUu
         RwT1rThvtucQe+JBaqQ2QxBCHYck6tOVVAlvPpR7pX99T4FHBR9W2VXJa3mvKgh74diI
         okvy6mKp3fWdKOZDjuqrDEMEx+aUgagaj+OrEyw/Rs08codlZ3Y64NJnSKa8XuqlJIuZ
         z3LYD2LZb7Sj+v0rmN0G7sAsQjI+UN5jFckR5Xi3IIf1533Y3RnB0tO3MuaF8ZiWjyAk
         zm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181731; x=1728786531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZXLrsBCw6gVIeraVKvj6MQahlne4BpDoCPrU6lTBVo=;
        b=wd5bdydlnZOxGYQRySJuLVAJDEdfw8sD6PiqySTtUqX/EgyveU0Os5ggNKn9zUaiiy
         otqLJ2dQmrg1fcXd2p5O3vx1TKjUJnnuxHMgRBZOX9ke10KmeQyK1kvZTpGQpeRAhd8x
         UdSdntWRQEiPhtcx3cZDAXqQP0FXkGlsDxHhjsO0LW2iUpQyaKsBiGPiKuS+sLWOMg+G
         AphRvcBDI74hqwxtdlwahpkzpvBqqewhfd8Fuu2VqvHm+ee9V25e0SEweLk9RHnLABmd
         2J5Xk8rENz9MIPEO5u3Ohl6JhsH0lAqvBgD1MEXgjyDh+ZvzgYjI6XObVmgAi234GEOQ
         iC9A==
X-Forwarded-Encrypted: i=1; AJvYcCXrdGX/2hniOBCX5hPiTpCMnpa2S7NPWIIdzzheb6vC5nN5Mkyjao71WTMTraCi7jsCRgKwXAIC922WQ8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEICLWvWXbRaFxZQxC5VamsLDpfVDAFGlRkjQrroU7h9twGV5T
	9GO7LJo1jubhaRTMelqwEWV1uyzVc8GENjCfA+7erHMOqnhBxFBmwCyvlg==
X-Google-Smtp-Source: AGHT+IGhBvdv+XZZ61TnkJvrsUwwh8dNSdU4vvOUV4bxp9Iq0lFzTfp7JY8zh3nhmrw3BcCZYY3trA==
X-Received: by 2002:a05:6a20:d045:b0:1cf:32d1:48f with SMTP id adf61e73a8af0-1d6dfabc7a1mr11274192637.36.1728181730940;
        Sat, 05 Oct 2024 19:28:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:50 -0700 (PDT)
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
Subject: [PATCH net-next 03/14] net: ibm: emac: tah: devm_platform_get_resources
Date: Sat,  5 Oct 2024 19:28:33 -0700
Message-ID: <20241006022844.1041039-4-rosenp@gmail.com>
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

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 61f70066acb0..9e7d79e76a12 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -87,9 +87,7 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int tah_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
-	struct resource regs;
 	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
@@ -103,16 +101,10 @@ static int tah_probe(struct platform_device *ofdev)
 
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
-					       sizeof(struct tah_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -126,15 +118,6 @@ static int tah_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void tah_remove(struct platform_device *ofdev)
-{
-	struct tah_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id tah_match[] =
 {
 	{
@@ -153,7 +136,6 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove_new = tah_remove,
 };
 
 module_platform_driver(tah_driver);
-- 
2.46.2


