Return-Path: <netdev+bounces-205922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40355B00D50
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EF81C87910
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D22FE37A;
	Thu, 10 Jul 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrW4dkcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C02FD895
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180038; cv=none; b=Z0RZKJJqFzTkvuJrTXsXf0uzrPsnMdXRSz9GmfD2OTf4s6H4fOjKsQ8h/TKg20Onw7Y5NmJ482bbIEr7Xe1HoL9gmoCzsSTkXjVzRz+jYDlDvO78IC7e1MhoRRgfvyXOCj+/O6+rz8zVftCT9T6hhJRzklCq8mUErZQHMo+rH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180038; c=relaxed/simple;
	bh=tdIAuGHSaA3N+mLRsWZsqxe3buVLY9Tujd56IE8yD6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnV+euVc5GaesCmm09YeRNAg6iN+nK7mMcbEmxHmIi8BRwYmnrMMtqDKe1zKUY88b+nBfqnrDq+WUcrj9pGCFDmcu7HTpukRXfa/xC7BXyAZduoopaFZnTnj5m0/eFhC+NRvcCT3Jn2+ns0jiNxvUzRCXSSy0Y1B36ooCAqDty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrW4dkcK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3121aed2435so1475245a91.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180036; x=1752784836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+SQEXRi1L8PFYJwo09hgUdhKYIqqUoBBoa/kB5Ymhw=;
        b=XrW4dkcKlw1MGii93YxgFn+JtOICuhxUe8IRfqBaxCQ9H3JkR0mhjmuTV17P8r1EkE
         fB6PtOsz7VEQjeB52y3J53fiCHfJ7gA0nf970TYB9wHCvo1cO7t1g2N47lVbw3KHTK01
         uqS7DdM3vMyPnlxMim7VKYPZvWlQkzL9nOI5KMGVbP6URJ0Ne6xGSWVnI2kqAgeOyjLn
         VWMjVv+zrtPK+avbShkSvMCDH11njNWyBFUNI5jjvvb/rCaAvaO5TcEZHf7h4ZBE34ZB
         3oVTAqVgB0G1BL2jzaxSmgac5DCzVMFT8tzA373OpJfAEnORUB2RnDq9emufYDIO7FvY
         7oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180036; x=1752784836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+SQEXRi1L8PFYJwo09hgUdhKYIqqUoBBoa/kB5Ymhw=;
        b=e9ETUOsl/lGvN3LXUGk4/rhmxFTDVrCF4B2U1C6fDdJfxVplwdWy9YXGF5inAvvuAv
         j89Nsn+P8LUOzsvh027MUk3ZSXItOz16VHnwAjhWi1T3r0CbmIhEYe0RIMUVgzDj/QqG
         D3pq1slGRMEyftds05oK3gVqRCyZMnrukDCoNf27oyOgDzCpbp9oEnPsnnXNOvuBzmm6
         wWDzNNwnXXvEZB8/PZQdQA0v/nmI49WGShKlTgFx9PvO5x4Cj5iMp6CLJqi4Gy6REfmz
         cWlNZ6535O6QoItDEoIooR21jiry3rkzaVjCUitAAXinfGKcoD31ty4wpSjL4uciVQli
         I/VA==
X-Gm-Message-State: AOJu0YxTA6jm+v0ingYjmKRJ6+KcNbEOzy+k6JjZvgPC0o6NmVohwXSI
	yJlMrcidlcmLNbuHL1cOl+7PAjIPeDFJ3ik/RF/z7Vvag8262vHM5qRzgvslv+uI
X-Gm-Gg: ASbGncuj3FTSGI3FLVkQCgTwnXvdT0K/Wovg9GCTRY1MUajx061ssbyFiawiwjeeS9r
	fqQckF9+CuK8Wk5gRa3KQQBvdi8XJ5xKii3WksBFFuah4ouItx1eVig6TiJ2Mjpcge4aEA/B5/R
	4K7onia6tPnigmOpYKKYAdiQoluWR2EGyqwMm3g4Ry+pjXY7LB9Ln7zNtvB+pkBCXQJU9qIqiLx
	gcochDkQs1wYM1MUqoHzBdawyoHlJ80R7lwRJ3xzrNrxMGacaJQFO/rQ0BwXgsf3toB3ndqvpF3
	CfPzL+Lb2yFY/RRSMN8k3uq6s5nZzTBszenjPR9fKAw=
X-Google-Smtp-Source: AGHT+IHZH6IikF5Oy3CHcc68uZ14nkZ7scpPjHQPgLtnZ6WjrGgl1wwoLT5RtSxgvMX43IHXM2r+cg==
X-Received: by 2002:a17:90b:280b:b0:313:23ed:701 with SMTP id 98e67ed59e1d1-31c4ca66f84mr1073629a91.4.1752180035792;
        Thu, 10 Jul 2025 13:40:35 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 03/11] net: fsl_pq_mdio: use platform_get_resource
Date: Thu, 10 Jul 2025 13:40:24 -0700
Message-ID: <20250710204032.650152-4-rosenp@gmail.com>
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

Replace of_address_to_resource with platform_get_resource. No need to
use the of_node when the pdev is sufficient.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index d7f9d99fe782..f14607555f33 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -414,7 +414,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	struct device_node *tbi;
 	struct mii_bus *new_bus;
 	struct device_node *np;
-	struct resource res;
+	struct resource *res;
 	int err;
 
 	data = device_get_match_data(dev);
@@ -433,15 +433,15 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	new_bus->write = &fsl_pq_mdio_write;
 	new_bus->reset = &fsl_pq_mdio_reset;
 
-	np = dev->of_node;
-	err = of_address_to_resource(np, 0, &res);
-	if (err < 0) {
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
 		dev_err(dev, "could not obtain address information\n");
-		return err;
+		return -ENOMEM;
 	}
 
+	np = dev->of_node;
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
-		 (unsigned long long)res.start);
+		 (unsigned long long)res->start);
 
 	priv->map = of_iomap(np, 0);
 	if (!priv->map)
@@ -453,7 +453,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 * contains the offset of the MII registers inside the mapped register
 	 * space.
 	 */
-	if (data->mii_offset > resource_size(&res)) {
+	if (data->mii_offset > resource_size(res)) {
 		dev_err(dev, "invalid register map\n");
 		err = -EINVAL;
 		goto error;
@@ -480,13 +480,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 				err = -EBUSY;
 				goto error;
 			}
-			set_tbipa(*prop, pdev,
-				  data->get_tbipa, priv->map, &res);
+			set_tbipa(*prop, pdev, data->get_tbipa, priv->map, res);
 		}
 	}
 
 	if (data->ucc_configure)
-		data->ucc_configure(res.start, res.end);
+		data->ucc_configure(res->start, res->end);
 
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
-- 
2.50.0


