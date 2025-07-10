Return-Path: <netdev+bounces-205924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E2B00D4F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C63B5C4AA8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2532FE39B;
	Thu, 10 Jul 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGhgm1ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBE2FE37B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180039; cv=none; b=DLICK0PCb2zSA9R3sYW2/Fr5TJj2ZH8N5NHrB+dMJ2/4hMSEPcL0Ngi0h1xS4DccxQqNuTbsedqQyzTN0Piwspk+kY/egO6E1yNoVIP5OdCP/Qk3C61jNrKV9Ltb1t7ia4ubUMQDIfdy6U73Pz+naCWo9paCiDJb6/hPotLmTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180039; c=relaxed/simple;
	bh=LMyGWsJgFitu2IFXjPx/OTV5wypj/pJ9gzshMpYqkuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jp45AexTI0cN5afBwvt5IZ0U9Kv6Ek1wXwwhdD/IU8O5izMTqag0eO1uz0UaXasEjVU0vzodIGnzHRQjJZwk1HTYiNxETamCNzxDrrnMpam68lP2ptG1n7QeRjBtjuT5+VM/a1pGWQSwz3xe1Ybq337/7QbHlgtc6l+T9RMrhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGhgm1ij; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso1234915a91.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180037; x=1752784837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwlHxzP1+/lzPSiypOtbhHArlXQnsb8UpP96crGyuKc=;
        b=JGhgm1ijcRDdTU+nyP/zigTNMxgOb6Iv1BGWQ8M36SZKuNYZn6E5k+Ih6t0G/0mDRi
         DGCnU9og50LBW9Wfh7Z8HXzdJ42HljSswKBotdA5JqFGll7Fwv86955KmQagf2XgoH5m
         extrIRYxTL0uL/aE++OJMhfL5+RccN/zmmoDZjqW8UkzFvVIt5zHJunLYlCAYVETu29/
         d/5P5KZvUJaQTd75r9b3FOhqS3ca98ujPg7Uy6YPXA5yQIYUL7iHeHvKdNDEjfM4TzyK
         3TvhCtOG6/Lqa3ATPCM3kBmQckuYhvbyuwPgfyqV2Vu1Uu4uo0hgbihivxXyl+cJlj3q
         zwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180037; x=1752784837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwlHxzP1+/lzPSiypOtbhHArlXQnsb8UpP96crGyuKc=;
        b=PU8iGEDO6aIbKSFNVLfveh9H7eWNhm3jH7E1Tar8JCT55I1Y5w8UNIca0wMzZv7rS9
         xqaa9cTiQ55i4ASysJ/wlugQufaxgxRwtMa/Z1gUZCowS6pjV1+4hh5himV29PjZbtEO
         3EpRxLAMTcd2bjvWUNzBB4vSTZxxIwghgQExMjgi2HxJ94GFNnOuwnTfXJ4A0LlSmiWo
         8APSV0SD2HAwj4kNZboynWcVBDEipz+01wIFHv/RMyPWep2OmX05dKcmR3QbhEP3+O9O
         T+wLyUhLNiFjDZxoA2GS2Jw/y6hsqeuS8VSy7iz9BcSMjlQusoXUhLhk+71XqbDVqgrM
         SYtA==
X-Gm-Message-State: AOJu0YwBWUAjKdtbwO6PfeMs1xYlZMlR0qnpbyl2+1QXxYSjKqKatrnf
	SEn91+Cnd00re95Fxe57PPYqTPwebb6lyKSLnvqQpo015QQSX59iheGALTAmDbXn
X-Gm-Gg: ASbGnct6wO1KBNDZXaMfUI5kwo4aS3VGqrMJkDSarh16qmG/P0ILnKHqvpBU5i4+YoK
	6ZjW8CXky49GRJri7O6/+SfxnTp9X8c2aULG5F8Mm8ucyawRY6BOdbPZG8ut448IEr23RzC+gLA
	KmBQ9x1NjvG3eAlqO2z3tq3ATIC6H3OrKBGhUsIZptROgQXjpB2Msn3ZPlrmBMCldjZnYdEPHvJ
	N4TdaN/kI6N9acXQgHhwXYFHf8xme17kZ1OtgMihXDA/YetUR0kPL7q9eNJjL3tKblaKbYSyuZe
	Mim6N43h0bv0ErrThg8XOS7RtTh2jRboqrGzEIUzeiES9aqfOfv0+sFO9baK/nB+/BLgRVdzVO9
	FflA=
X-Google-Smtp-Source: AGHT+IF9bTkm5wRShLQ9wAWaSMJ5xn6Rd4U7RtDsn3zM8iXHLtv7TxU4N8BEnA95gVtIqu00O8vsTw==
X-Received: by 2002:a17:90b:5387:b0:311:ff18:b84b with SMTP id 98e67ed59e1d1-31c4ccf09b8mr1003868a91.25.1752180037381;
        Thu, 10 Jul 2025 13:40:37 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 05/11] net: fsl_pq_mdio: return directly in probe
Date: Thu, 10 Jul 2025 13:40:26 -0700
Message-ID: <20250710204032.650152-6-rosenp@gmail.com>
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

Instead of generating two errors in probe, just return directly to
generate one.

mdiobus_register was switched away from the of_ variant as no children
are being used.

No more need for a _remove function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 640929a4562d..12b6c11d9cf9 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -415,7 +415,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	struct mii_bus *new_bus;
 	struct device_node *np;
 	struct resource *res;
-	int err;
 
 	data = device_get_match_data(dev);
 	if (!data) {
@@ -465,7 +464,6 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	priv->regs = priv->map + data->mii_offset;
 
 	new_bus->parent = dev;
-	platform_set_drvdata(pdev, new_bus);
 
 	if (data->get_tbipa) {
 		for_each_child_of_node(np, tbi) {
@@ -490,22 +488,7 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 	if (data->ucc_configure)
 		data->ucc_configure(res->start, res->end);
 
-	err = of_mdiobus_register(new_bus, np);
-	if (err) {
-		dev_err(dev, "cannot register %s as MDIO bus\n", new_bus->name);
-		return err;
-	}
-
-	return 0;
-}
-
-
-static void fsl_pq_mdio_remove(struct platform_device *pdev)
-{
-	struct device *device = &pdev->dev;
-	struct mii_bus *bus = dev_get_drvdata(device);
-
-	mdiobus_unregister(bus);
+	return devm_mdiobus_register(dev, new_bus);
 }
 
 static struct platform_driver fsl_pq_mdio_driver = {
@@ -514,7 +497,6 @@ static struct platform_driver fsl_pq_mdio_driver = {
 		.of_match_table = fsl_pq_mdio_match,
 	},
 	.probe = fsl_pq_mdio_probe,
-	.remove = fsl_pq_mdio_remove,
 };
 
 module_platform_driver(fsl_pq_mdio_driver);
-- 
2.50.0


