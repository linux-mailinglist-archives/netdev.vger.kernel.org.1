Return-Path: <netdev+bounces-145400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447199CF644
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4000B24678
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620FD1E261D;
	Fri, 15 Nov 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DomsSIB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAC1E1C03;
	Fri, 15 Nov 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703315; cv=none; b=p6qP9UlJjPEaJFymbum9FacmZ4Jqt1ByQC9CBEA1vdnWSkriILlTU33zKSL+p5kJ2y6zEKhHRz32VsvBPe3j4vLNkcey9lR4vU+c7b9RTSi3ID3Bc1vPY2hFXBQH0TpCVkmaJK0LPoX73TNuLb+p/MrQ91GlKMUmnagRak5EzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703315; c=relaxed/simple;
	bh=pu3JL68bu1cSv6fdM/I/ECn8R8R6/lc6ICYA0qYjMkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJlkhutuUe32FyfH4WaWYyEN3IJ4gdiBGJmtGjL3xzDzrLt3rsy2kL9UV9jdEmC1xytHshtt0vKDrvV6rz2nXnyf+Jg51wzTxepZNlRG/FPjqXig+pFKjGHl0uP0aPL93dxhaygMx+8aYMCVPgNFF0FounTWxNuJWfSt8EBIfDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DomsSIB7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72467c35ddeso1757998b3a.0;
        Fri, 15 Nov 2024 12:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703313; x=1732308113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYLEpqANoyEmd5NTjy3oJeHuyxF++RP3Dua5hSNSzO4=;
        b=DomsSIB71RmIm5K3aX+Pd7UI0+rToMiSpUbMHF3kj3UUNimYPHgSvcCzp2Cvh6FqDJ
         30rnfKjX1bWmHKN/BBzXdDYU1BbkEk1VtG6DqoCdhK+gHdBTjvyAMIFUb8kussuwHKVl
         o9Fs5YNAnQsRBr0QLnDTS/4c5IshLdOv1Er1sniCxC9GcWej2v4HLrVTFryG4C/1jA/4
         TOfHfUNc8HUpJPscfpwIN8cXBHosDZZdLAfn3FAG5sepGts21vvII4kVw1gDSFiV2FUx
         nJkKIo4x3rvTr6hkJ/RhOHWMHF/M85enNT8qEuh+lb49cufBqTuNgbt0PFkhclZjMrvL
         Y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703313; x=1732308113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYLEpqANoyEmd5NTjy3oJeHuyxF++RP3Dua5hSNSzO4=;
        b=Qq4LMIMMAy6BjZ5qDauriJA7TwjxaSa/ea5nKu9xYbDOqE85oH7h9osYZb8y0WagXv
         cHPBZ82Ma+x/kKlC666yaRO4NNAxDUzXtySICZ/qvnLKicaYw+UzKEwglj4zYzIYd/At
         4Jl+D2mqolHsz8vNh5qz6VBkCgnOohJ9F9Jx3W9Ck29jcZyXnAnLkpHstFhoqe0ObvjT
         TXQ/pohbJJ9J+w+f67zhwyfx3Wff+dftPZuSV8lQeVTIKl9VPlRC1P7UKTDgC9CyzxNy
         NXUYWB9A9anXO14kN1oq3U+sxi+qxBq28boYTtIaOVc/jKixWflyCqIeSuzbTTaP+e0U
         /RRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYRnGNvzfm9vtN00jEsr6QoRDTzaQQ/H4CKlt/0C9Iy+1ygTVgQn6psljSGZCn3vIOODuoOASE3x2GW0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U1H+BGNUI6abGDt1XkxoVUtyj9OobYiE1IQNtEmTmhR+zVUF
	RtHaHj9mhhAxHdHjUiIgZ13wJ4xrKbYwxdV8WlVe0Lk4DAJ7nxxrwDHOsNA7
X-Google-Smtp-Source: AGHT+IFk6vhQpSbCke5UFwKgbExv7XQwqvmbYHXFA3gerYBKAV/VI3K7+irT2LhyYyOA4Vn6Tr53LA==
X-Received: by 2002:a05:6a00:3bf4:b0:724:6804:d663 with SMTP id d2e1a72fcca58-7246804d6ddmr11355726b3a.1.1731703312417;
        Fri, 15 Nov 2024 12:41:52 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:52 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/5] net: fsl_pq_mdio: use dev variable in _probe
Date: Fri, 15 Nov 2024 12:41:45 -0800
Message-ID: <20241115204149.6887-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115204149.6887-1-rosenp@gmail.com>
References: <20241115204149.6887-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving &pdev->dev to its own variable makes the code slightly more
readable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 26 ++++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 56d2f79fb7e3..108e760c7a5f 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -409,16 +409,17 @@ static void set_tbipa(const u32 tbipa_val, struct platform_device *pdev,
 static int fsl_pq_mdio_probe(struct platform_device *pdev)
 {
 	const struct fsl_pq_mdio_data *data;
-	struct device_node *np = pdev->dev.of_node;
-	struct resource res;
-	struct device_node *tbi;
+	struct device *dev = &pdev->dev;
 	struct fsl_pq_mdio_priv *priv;
+	struct device_node *tbi;
 	struct mii_bus *new_bus;
+	struct device_node *np;
+	struct resource res;
 	int err;
 
-	data = device_get_match_data(&pdev->dev);
+	data = device_get_match_data(dev);
 	if (!data) {
-		dev_err(&pdev->dev, "Failed to match device\n");
+		dev_err(dev, "Failed to match device\n");
 		return -ENODEV;
 	}
 
@@ -432,9 +433,10 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	new_bus->write = &fsl_pq_mdio_write;
 	new_bus->reset = &fsl_pq_mdio_reset;
 
+	np = dev->of_node;
 	err = of_address_to_resource(np, 0, &res);
 	if (err < 0) {
-		dev_err(&pdev->dev, "could not obtain address information\n");
+		dev_err(dev, "could not obtain address information\n");
 		goto error;
 	}
 
@@ -454,20 +456,19 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 * space.
 	 */
 	if (data->mii_offset > resource_size(&res)) {
-		dev_err(&pdev->dev, "invalid register map\n");
+		dev_err(dev, "invalid register map\n");
 		err = -EINVAL;
 		goto error;
 	}
 	priv->regs = priv->map + data->mii_offset;
 
-	new_bus->parent = &pdev->dev;
+	new_bus->parent = dev;
 	platform_set_drvdata(pdev, new_bus);
 
 	if (data->get_tbipa) {
 		for_each_child_of_node(np, tbi) {
 			if (of_node_is_type(tbi, "tbi-phy")) {
-				dev_dbg(&pdev->dev, "found TBI PHY node %pOFP\n",
-					tbi);
+				dev_dbg(dev, "found TBI PHY node %pOFP\n", tbi);
 				break;
 			}
 		}
@@ -475,7 +476,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 		if (tbi) {
 			const u32 *prop = of_get_property(tbi, "reg", NULL);
 			if (!prop) {
-				dev_err(&pdev->dev,
+				dev_err(dev,
 					"missing 'reg' property in node %pOF\n",
 					tbi);
 				err = -EBUSY;
@@ -491,8 +492,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
-		dev_err(&pdev->dev, "cannot register %s as MDIO bus\n",
-			new_bus->name);
+		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
 		goto error;
 	}
 
-- 
2.47.0


