Return-Path: <netdev+bounces-130524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A998AB8D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412EA1F23ACE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934C19CD0C;
	Mon, 30 Sep 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrnz8nAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851419CC01;
	Mon, 30 Sep 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719255; cv=none; b=ofoWgjZIIhVO698VRDV4oIZibRThGL0ZQ9l5aY1g9Rm2bozWpAPdW2aM5zArII2pnX8bH3Zw7AKOnDHAppmTUVOfVFPb2O4QecbXG068vp2WRY1ZUTpCGqos3BfbsBI+gOTuYmP6S6vb1oZilcvpEKjkQg/LpJZ99Azx8SrpW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719255; c=relaxed/simple;
	bh=fydThqOD5ClKR+Zw1FUAYrUkTY6IGp1FS2otAaIRZUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3lOvAlXr1QviydXYSWOz3nUrsSld3X2CH8xaFAmqe3FNbSdvA2j7yzxN+X3IwSLUmgs/3vbjb0eqwftH8eKT1fG1LUIBH6OVBOgPOiJdjFcDDcYeHiRHGD0KSmSitdkrcI9QWXCgm0GXFSlfmHXplm5Z+INJ1WAAYvAefhX9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrnz8nAp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71b20ffd809so3369842b3a.0;
        Mon, 30 Sep 2024 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719254; x=1728324054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydJgFVEkBtydwBIyqxhItq4Mj8+RadfMw1KRALqgz3M=;
        b=jrnz8nAp72Eb9sxP30nSyz1fBn6+zmsG7DeJFSU64ngj1ttyaiQ3V5yHSQB0RNduNe
         Kq6ht7Drq++IQMO+hqEbKlH/X/6FALiku3rNf9TxuocCE5q9nT8l9fNAKDP9rkTv2moQ
         Qj8nmqZFc3hP431PWhosTc4qgAhdeSp/L6S4QnBQMJiz4CR1RWdnH3FXomZBwzZ9n2re
         eyUYgEBWCkwhNkbjmifd6cQDl/u7kmH1CRUQ2sNHiAjwSZQH201huyaVUhpBlzjNyoEX
         K3uxfFPMgiL4PEQ00dYsZ25t12P0Ys5UJS7oJSTHwjNHmTihgYK2BloiPtM8Yd6k6tbr
         hRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719254; x=1728324054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydJgFVEkBtydwBIyqxhItq4Mj8+RadfMw1KRALqgz3M=;
        b=QbpL6vBSVJ8xHGT9mhCNmvRlPKm5K+ZX68ejGVMI7Drr5/plmCjmDkVFICZk5JDt41
         DhgvmshYjgOx5tJ1BeMVPaSE0PvVeZILIsdt17wgHo28hADMWLunlaZi2HG0a9zfIQlp
         XnKbSkV+87I6BgV3W4geGr3QCK11b3By+6eVB1za2pyPR0fWJwEsDfSrTY4EZAi8x9dS
         6LDPspKR5NlVbgI13AO4hrWBDzRjoWJA9O3wm2tQZMlb3BqFLBLd/a3MqlhaRsy07TwN
         sC6h/kBy1+q5AinMoudTHCBUpjpBq3eBBolOrBM7OKpItt3WqtMz//8f8rm4fShzmxQ6
         r5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXiIRquw5WtAipbHMhOabNKbN7Q2vPXTmi/MeST1ejnBwjF+gafIVewaUXU5HoaX5XUvEhpNHH5T8+CSZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXx/W5DcadFqurmwWZKSw95RI25BGW3wK1yowbrGqEBPxlooS
	86Gf/9KLJhhLG6fdwgY9o6POUIIsoEwKD1g5atL90VHgcw2+22WlaVnAI5Qc
X-Google-Smtp-Source: AGHT+IH4pJHIa6zedEn3iUXHe5dvnP5pSHtxEFNf2rXQZR0Ijn5rEnwhJ1XkkEEKekLhT8pTf4warQ==
X-Received: by 2002:a05:6a00:a93:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-71b25f8f777mr19253590b3a.14.1727719253609;
        Mon, 30 Sep 2024 11:00:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:53 -0700 (PDT)
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
Subject: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platform_get_resource
Date: Mon, 30 Sep 2024 11:00:32 -0700
Message-ID: <20240930180036.87598-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/rgmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 8c646a5e5c56..d116de4e38a0 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -216,9 +216,7 @@ void *rgmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int rgmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
 			   GFP_KERNEL);
@@ -228,16 +226,10 @@ static int rgmii_probe(struct platform_device *ofdev)
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
-						 sizeof(struct rgmii_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_get_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* Check for RGMII flags */
@@ -265,15 +257,6 @@ static int rgmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void rgmii_remove(struct platform_device *ofdev)
-{
-	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id rgmii_match[] =
 {
 	{
@@ -291,7 +274,6 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove_new = rgmii_remove,
 };
 
 module_platform_driver(rgmii_driver);
-- 
2.46.2


