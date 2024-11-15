Return-Path: <netdev+bounces-145402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EE9CF64F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97388B31363
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606A1E47BB;
	Fri, 15 Nov 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/DcX5s1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A41E32D0;
	Fri, 15 Nov 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703318; cv=none; b=i3FgGDpVusQyaCKz0tKer0rM8wYcBhCJPaQFdWvvZobH+IkdkfzJoKH7VugGcKlHaptdlgyyzIUYwS9kvuVsvCbMmsR7yNfg1fNTUn0OAH2nMGXL44/DyUQPTXJsRQS2/Zh1x8hgBM/M+LryboD9gw04qypwqSDIYKAKlsNLTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703318; c=relaxed/simple;
	bh=UEe+01wXcA/6Vp2tXaLjKWUBpnQy8abf4E5ymq4FAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/Y+jqjEX3SXQqtFSsQv5fAf6Z4ai5WJiCTzhIm/xOICHNfsdEVfC3GeYINthxfehcb7Po7C+CmyLBZoQz6ggm67G/ZF2Vno+nh7XIIi6jM50G40stgfhhTO1C/oDi287AO0Zx8Ob4C96pMn3G/dFg+2VV2tzMn1uus8KplbJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/DcX5s1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1751215b3a.3;
        Fri, 15 Nov 2024 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703316; x=1732308116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCzzR8j2iKtf3UdeUk+5jPhNrUS+V0xjiwUoH7xZuyk=;
        b=X/DcX5s1sKwnCixHKiG4FRJXu0QpsiNqdoLcmCz72UmzLGBZxhbD5cBK12j3uDwWQH
         eX0/+2hnTPBsdaXW/wlV87CMIf95cI0CJDB7IhvHVSB0EXknKW5qdKGc5TSbRYujhyl/
         /vsQm1mgfIgR3w3YRjMubBNyo8JKZbCzqD9PuyWdycsBvlaNH9NVnGZajpnhnuULGKXg
         2YnXsEPh+rvC3YLuWChrGklhLpz/+CKoADpefx42dlUzneZlz/ucB3Zr1Xg9t58YsCtD
         HPc7T25zs9MbyUXDow6HhF3LWQA2csnitvSE9SV6/S492sVRfK7pPAkPdpP3BZpXaQo5
         aEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703316; x=1732308116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCzzR8j2iKtf3UdeUk+5jPhNrUS+V0xjiwUoH7xZuyk=;
        b=A2inNC7rQvW8xEFNkzfaszOktWC26RFmBU+ouOZCeRUd0DGZ/RL2XMG4ARhU5wglFp
         WHQoYdZiAhA7JRQNt2ldkCvkkZzNY0PItQi8sNNBQJAoSLvV9Rw8OlAmOjg6a008SPCB
         G0hoIEB39X7Yj27F+T14rKEBmCaaMPBaoFI2E0EmBGhkeL+F5ZVv9Pl4m0uQ6eLqhaL/
         b2cNYjPPALasjp7erkKdvlURazNrLev0VVswcSDUeWWEreU3HBFmUMLNqPeA8Ofrn508
         kge4gGf5tk7D6ptd4HYWaSnDDs3QLG5TvmhD6SQ/iymOV9Qa2G+f6b1QxIWQDqjSdwfc
         AIlw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvfoCG3beZz4iomLX6jBoq/kOhKshb4et7vzKpFLgRJKLaLmVoAFmSu5kEnB0CtpCbkDU/oub6PnLrsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ykhA92lVNf0tSphNCZ0n+HX+4ghPj6e15ettYFPYOS42szf/
	6S/i42O67SABrQ9VUtlhXRgn6iUiiMuOAoMaFByruGfirT2wxGEYsr4YmsUX
X-Google-Smtp-Source: AGHT+IFL47ThZoo8cJ5HYJNSr3uIMbpU6x823MSeax4aaN454AWVKRocDwEOEXhTOOuRH8VazRb3ow==
X-Received: by 2002:a05:6a00:4b54:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-72476f7c766mr4431850b3a.26.1731703315822;
        Fri, 15 Nov 2024 12:41:55 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:54 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/5] net: fsl_pq_mdio: use platform_get_resource
Date: Fri, 15 Nov 2024 12:41:47 -0800
Message-ID: <20241115204149.6887-4-rosenp@gmail.com>
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
2.47.0


