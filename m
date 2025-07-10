Return-Path: <netdev+bounces-205920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A1B00D4E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0545C1C87351
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A52FE313;
	Thu, 10 Jul 2025 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyml8kYF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB420296A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180036; cv=none; b=HYl2zRkUEmAxf7jRu0OyrhI0um6c4hXwD6EfQ/teGNaAso18o5KE9VellcD/Q7ln101phDubXkLaZSgLvhpAGr+4APISo2TK+HgI3oual+g+E5ZxwT494a5EBK5DtFPNDYDRtKgHRL5kg3vS5u0HCdnZU6ohu3LxCCw8M5BAf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180036; c=relaxed/simple;
	bh=gd5KLYaEpjGqodIFpHaM0kcT5vJlbrpOfOBKnjVAIr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0JrzG7SDTBaU++GXYeMIZp8ZU3NwTJNUraoCazIfoZBTIu1ScRTO+xvDY3YWdPdgQWsqIdEOJMuOXsgRfSSVbPehVmqR6AM3nGiBF8wcgekJBq8F2UmNtRtV+MhsWEi3wd2W/hopdDGmW/ggsTXPbJEqQH4VoEaBGkDjrDieWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyml8kYF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b390d09e957so1540360a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180034; x=1752784834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/PveNvqtl2MhFlcTet57lEN72T4kdWiheuFAl4Xxr8=;
        b=Eyml8kYFM4ihXm1O8u5CH0t7zNN65gxapEV8ivG6jxtRHd++OPNd8T9VDky6I57a9v
         j/btnQs9azj/rrRNzYPYmyO/k6KJd8EaSiX14yCCvZ/s1HepZaAEZGUyF18DnThvME5M
         h2z0DyP1tTpXbSTFX59qvNycUqWF/oCDE47I8gZD3sfjMjkmekBZmM+RQw5T2vCoKVuq
         CKmTGTzhdWtV3T/kQtWOOQpT+vkXM885HPWd9RgVb5ujrMHLVEKam0x2BaoIjp3OVQ1y
         mR0Z0rO2AD8wwbbNA0RWWc45jceAT0JLQNQhZ/nExdNE+MSpq8ptbxZBaHiERf3TFl/r
         hS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180034; x=1752784834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/PveNvqtl2MhFlcTet57lEN72T4kdWiheuFAl4Xxr8=;
        b=ffkMIaLbKD5qMafuYVMNSwcEcYy9XPmmCxcMhfUxRrO5I8YtvxIMZCLh2jgCcxrzwI
         IZmRJFMl0R9ljIRXP6lUyvWRUdD5HrPsD0yvU5qYDC4Krj7vN2EofhzJrARyJ/WgkeYk
         18629dCkC3phxl3yUBIU7lC1pwSvGz6+C6+iyV/NQ/JKhzKVLaTAjd1QgmTMv7Zmm580
         wt0g5MjYTbhqpMzFQqYzkP3JFx/phNvpi07dLiIaxZradSpzQ83Y6rGwFD7qSZ0k3/3u
         SPSE0EqXLVT9ZCwkdnCAab7pcTDrQ3larlLd+dG11PykpFlvIJU/e/SVRbMrVt90kKEe
         m5Gg==
X-Gm-Message-State: AOJu0YznkDAVPam05OyHcwKW1wRmFw/gj3pKbVG4mkfNUNjBzWhTVn3A
	NC4Ye8bBWCueDffQBA30joGk7pymylGTJvhUeGLb3zrB7rz2GirXG6kCbiiR4nc+
X-Gm-Gg: ASbGncvhWBED5hFMLuuX1lkkKQSwkg3Ei/RVeCXTDCAUKl1H/9ts4jPqlOzbtdFkwIz
	vVErz/cNYVoss+t1o0CPQUcC8SLD9w5klBp+Nfhbf7jZBb4rjqz8snAju1RkDxBS+1NdYdysY6M
	vlcgBX1e/aW7MWyY7Pg/WMIMbOA+q0LgtHPCqJRA59RB1a1m5hr4umgWvGESSEaKauR/xRJGMhX
	rLGEsqfqV7mZpn/E4oqLPD5s6SmcIiMcE/JBnqNQeTg1YlNvAsJRuyLj5y2L5g2lpXbjnnSqfm5
	otZXocLr8yPpMpphEaC182d9M+3wxBELNRJSY8KLUIg=
X-Google-Smtp-Source: AGHT+IHtqSinzE9XIb0l6gteOecHZnYstzGifE29XKKbYYAHa/R+caFW2WiYuvWANkb0j3uUl/4b8w==
X-Received: by 2002:a17:90a:d407:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-31c4f4b547amr82272a91.5.1752180034300;
        Thu, 10 Jul 2025 13:40:34 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.33
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 01/11] net: fsl_pq_mdio: use dev variable in _probe
Date: Thu, 10 Jul 2025 13:40:22 -0700
Message-ID: <20250710204032.650152-2-rosenp@gmail.com>
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
2.50.0


