Return-Path: <netdev+bounces-131449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355E98E84F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7352883E5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DD12DD88;
	Thu,  3 Oct 2024 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgWVA9vV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B4126C04;
	Thu,  3 Oct 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921514; cv=none; b=Nhcm7TYPW09Fa4MLw24XYNl7uoSSXgweAR1HHLd0BPksgV1eQkit1+KsBWU58amVLofiOf32FNnXoxeVUWG8Fizuqi1ckwJGKD+f0At4lk4iAAtQexLx0CSnl+tLe60KWJuzLVmNbH940y+d+Xtw1fU+1LIK1gcy2T/i4Tl+wa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921514; c=relaxed/simple;
	bh=FHY66iZ1UrcrbeXKE99B9ikoT6GAi0J+noOtDA2DGFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpP6oltg3Y59ouwLKtvLKfuVlRReEMB+9iACkjLBZTi1pywd23qM/HJT8xSxroL62n7iV34dmWamVHnudToRzzgo0aV+Rb5OOGn34PXn8XRf1rLEuqEP7x/JmtxxdVKCy0P5Ad7q+wVDvufG6ipmp4o+VpU9X7p5u+7P12x4+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgWVA9vV; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1010298b3a.1;
        Wed, 02 Oct 2024 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921512; x=1728526312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCLbZsayLlcNqhgpjNVIbKiCMjSAjR3dphSfWdGQgSs=;
        b=HgWVA9vVH0BZk9vSwTDAW/6ofl5f0EebjzH+RT777xnEKClVALAv8o7l5D23C0rY1U
         K+qCcP1SCrXcn7dR4gYzYPQyo+KJbA1GeqcOXhpaw9vwpHqbqXCK9XpFTgtKlQ+H8nj9
         B9wGjXsPfhYyKWXWOCjAoAv+UnIrnW61BzXwcu41elkvy8jmeKTVtO7P31DWcCU6f+9t
         j2ID6LspBjF5WNBisJj287ADcE/Fbbvw4EuBKJ7Hz/nCgBV2+jB4BsLoalkmtHI2Lb8G
         nTn9J7cjAbOfy2r3w5Bf1O/uMm0k3GIqiwm/piJeoK2M2ZBjqu2zvq6XVXV6RAq0k7z4
         KmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921512; x=1728526312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCLbZsayLlcNqhgpjNVIbKiCMjSAjR3dphSfWdGQgSs=;
        b=UX5fLYyOE3t0155pIU+TzcRgDUu3+hIBDWmnW0DCWlfFEkXb3rLzinzzqN7rWjsQEM
         4nn2d0cQo58jVpS35Pn22hBA81/p2PVlVVdBhEkmqCbsOIOgVbvCKNdjbdqRNHCRN71J
         urvUcWGRcB2uio6yQaN2aDGWMxeI2wRc4BeTKLGdBaVznfTclYfJ0xIQGcza5gcfryyc
         AlClxrnn7sqGonIZPMvoADDZD8hE6Kht4n/CN+1e80On9y7KVEAYvbFUSEdoGvayz+vX
         gUKP4RN0FwUtulqq0LNvNglDnuMBdPLlCwy9gwkr7f28VqV6Tt8EcX0ZUZOlzX9Web5I
         Mvqw==
X-Forwarded-Encrypted: i=1; AJvYcCXtxFRlVjqr1hiZA3b4qxmDbLVbEAuCkF3ERbO0Fc7ucOTT47JsJE5pNA5xYBMTrKDSXmvd6gIIRGXh3FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUV/Uy9Uz+WGg4EIDeuLpvdtXAlgiazMOWhb4swiGb7tkjhaT
	/lD3cuVnyGVQujpyozLunTRFaiuZuFi7FEGUDmCB1A0Bd5irDEXy+Nk1z3uz
X-Google-Smtp-Source: AGHT+IFYo+Qepu0Oo6lHgwoU8p/K+itY91wC5VZGRaifHXiVUN2lzbfcEShW7ixCJiENAmHyNYAYog==
X-Received: by 2002:a05:6a21:3183:b0:1d2:fad2:a537 with SMTP id adf61e73a8af0-1d6d3a8dfd6mr2501384637.18.1727921511873;
        Wed, 02 Oct 2024 19:11:51 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:51 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/17] net: ibm: emac: rgmii: devm_platform_get_resource
Date: Wed,  2 Oct 2024 19:11:28 -0700
Message-ID: <20241003021135.1952928-11-rosenp@gmail.com>
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

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 8c646a5e5c56..25a13a00a614 100644
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
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
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


