Return-Path: <netdev+bounces-145403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 435FA9CF658
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E228B2D5B7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3B1E6DC9;
	Fri, 15 Nov 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0o47x7t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B81E4120;
	Fri, 15 Nov 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703319; cv=none; b=My++3MOfRPjZbPJc/nl7xFHcAfun09XT8lr8DXUHuZW8bIcUk/5JuS9aKD14zMF4B+9fKIBeX+paY99vFEDuGh69pyc3orDx51kXCT7z0efbfLnpWwmqK7cNoiz7C9dXdjmP2oXUTUEFMpYS0uWBhQsx+mELQM+z6HzEyQ/xPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703319; c=relaxed/simple;
	bh=bxNdSWBFOuU160wYi2ZuwoNG6N1rmqN5rH4LXYxLWWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg+y6LI3HOtb7XqD+47N2vbqosITsh9ExCdQ0New3n9LcHnZgATW9KfLWGhVlP8PofDjRgXs0agoRbUq6XEHLHmr/5EOBQVWQ4bil4Xe0VoVhx+PHr79SFh35RNbdLIX7RPc0o5Pu+Xp9c+sAdE2vXmxWH2X+fcT2e6AwsuJe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0o47x7t; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7206304f93aso45735b3a.0;
        Fri, 15 Nov 2024 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703317; x=1732308117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ2w1hRvX2gv5YNJeLZGgNGigEr7WSReYY3PlM5Kufw=;
        b=V0o47x7tQ4MdoBkguKQD1KsRn3XkdoFQ2i35HE4nb+554Cf0n1QmeWLzkImonC3X/L
         XLGytN0sQ8+wdire1KQSI1kkfnsKk6UD6u2+5uHx/LY9+cnMaBfGcpLZ+2mDJIkBJz2X
         SygdETRGDWFqEQGGhsRevE/NaoO17v29scY0HPjQOjf+yYN8IPpNMa8eiFPdw7srJuNN
         Z4y4VaAOCZqAgXLB1eIC79zPaFIfyyTlQm07DXcaqc+ND8IrhbuUkOGG/JNTr4kC5Bq8
         eI9jPnThIatk0oWAk2koqhjAEfbSuwWWSASZCqpWdIbO7MIJ1qDaRS8xzT9Nfpqo98ee
         Oxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703317; x=1732308117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ2w1hRvX2gv5YNJeLZGgNGigEr7WSReYY3PlM5Kufw=;
        b=HdUh+3Ta/meoFXq1V8gzY0SpBoUBtCMFbqAJuggYgem/o2mw/u8s4xnMlODwQM/J0y
         dILV9Uggb2h4GNg0byCi2YdCzjLw8wboqUqQYzXDnDHQcAikVYMWEgnlKem0yNwNSFtP
         WtEQZq618M89HS8LDxfjB4QsLIT2WQ/ZMA9EFIDyAZKr0ceD2YS31UwTTRgzK2RfsiiL
         pVYF4gLfjcrNkiGCYc+BQ2dXGr3zgLiKs83egBJZAFtEj/jX0X7kjH0BqUHM5sYjy5UI
         v1Zs4v64D87f515LVUXl6+d/m0BnVjfTb4rXg65KkObv7Cny8wopOVJPilniEUWLOBM6
         0Eyw==
X-Forwarded-Encrypted: i=1; AJvYcCV5ai9c+o7YVbgLeKnVtUz8GjSZx4pJEfFH9PJclmCKs7rpytG3cDjM/slSHoDZVkxYJJHydFGQeQtsxIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF94rpa+mt8wQvGAzpcxCscvhNayFH/A1MM8bMLbNKFuou/UNw
	IZ2NCFIDuxCAPgIPA8cf6pFFt3V9Rp5lj+Unhq9WpxrvX4KA03FYZGbRdoMN
X-Google-Smtp-Source: AGHT+IHfZ7d3aaomlm9+JfgSOZe27g0dYGIVKOtrqV6lk3DqQx/mXWLXlOXI2dERnGMXGpqp5PXyJg==
X-Received: by 2002:a05:6a00:1144:b0:71e:4930:1620 with SMTP id d2e1a72fcca58-72476b724aemr5354852b3a.3.1731703317047;
        Fri, 15 Nov 2024 12:41:57 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/5] net: fsl_pq_mdio: use devm for of_iomap
Date: Fri, 15 Nov 2024 12:41:48 -0800
Message-ID: <20241115204149.6887-5-rosenp@gmail.com>
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

Using devm for of_iomap avoids having to manually iounmap in error paths
for this simple driver.

Add a note for why not devm_platform helper.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 24 ++++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index f14607555f33..640929a4562d 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -443,7 +443,12 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
 		 (unsigned long long)res->start);
 
-	priv->map = of_iomap(np, 0);
+	/*
+	 * While tempting, this cannot be converted to
+	 * devm_platform_get_and_ioremap_resource as some platforms overlap the
+	 * memory regions with the ethernet node.
+	 */
+	priv->map = devm_of_iomap(dev, np, 0, NULL);
 	if (!priv->map)
 		return -ENOMEM;
 
@@ -455,8 +460,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	 */
 	if (data->mii_offset > resource_size(res)) {
 		dev_err(dev, "invalid register map\n");
-		err = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 	priv->regs = priv->map + data->mii_offset;
 
@@ -477,8 +481,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 				dev_err(dev,
 					"missing 'reg' property in node %pOF\n",
 					tbi);
-				err = -EBUSY;
-				goto error;
+				return -EBUSY;
 			}
 			set_tbipa(*prop, pdev, data->get_tbipa, priv->map, res);
 		}
@@ -490,16 +493,10 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	err = of_mdiobus_register(new_bus, np);
 	if (err) {
 		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
-		goto error;
+		return err;
 	}
 
 	return 0;
-
-error:
-	if (priv->map)
-		iounmap(priv->map);
-
-	return err;
 }
 
 
@@ -507,11 +504,8 @@ static void fsl_pq_mdio_remove(struct platform_device *pdev)
 {
 	struct device *device = &pdev->dev;
 	struct mii_bus *bus = dev_get_drvdata(device);
-	struct fsl_pq_mdio_priv *priv = bus->priv;
 
 	mdiobus_unregister(bus);
-
-	iounmap(priv->map);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
-- 
2.47.0


