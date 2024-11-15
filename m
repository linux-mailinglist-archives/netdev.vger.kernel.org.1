Return-Path: <netdev+bounces-145404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558839CF648
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE74282CEC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249251E883B;
	Fri, 15 Nov 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1dmWGRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980001E6DCF;
	Fri, 15 Nov 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703321; cv=none; b=d00eS+Rff77RHwW18VuClTda7qaojqp7ybypSIW/ZIHUmiTabzAJQcJAXIajCzOkMaiJVCv3h3g42sVDZVyni8Nh5tKp/xqAWtgmCQuRgqoMTjie9r4vrCoYtRc6zWaIuonymvcACGyFQMUmTrRqwn0oHbl5+n9EZm8soRB05Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703321; c=relaxed/simple;
	bh=atjNlLzigxLFocWOYZ3P9pm/bgS/RCNfQxHKO7I/vHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWWoDNV1Cp1sbAFfr9vD32/nW/lzpfp4E1hrtpgBc84Ys/MZO6RJSJ09dSD0Iw8GNS6JGDdy1bCWSgxf/4NJ3tlRxa4070CI//FWuLyGrbbFHZ62QSqZIiou0UrXV0lXRX+OwocZkdIT1vAuniMuZMdXCy6gu1N3oZoIIFyoSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1dmWGRN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f12ba78072so1766835a12.2;
        Fri, 15 Nov 2024 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731703319; x=1732308119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNJMkhvDACNxbVOybBT2qMig0uprGHP3aEgGM+RIyTQ=;
        b=f1dmWGRNq5GqWy6RhwX6EhXh6sdpHQIqAQLBoons3wJlYoMNi0LCs0T2AoseiIDg+h
         PgbGoUBqGggk/wLpJe3tn5XEC14VNbXNLlig09dQSCXiaEFaiZpfXUrqIEd0VstbAQUx
         RVkrYPjfpLLPocTGaE0LrLi7SesfBWwvR8n6sowjOG5A0bLjxNRrYjMujtvbap0bts08
         pd/edyDG8pOXaYNeSF5lclwulL+cjVbmIAcjCvnpQBef9i5zdhck1Z7W6EKyV1LsmEVN
         02RRY7YwGBB9eeTXabOeH/A8fIhf3LVDAUeurGth6Jy9AOztxLq4IGxVXMHRsVOw+Uun
         ixpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703319; x=1732308119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNJMkhvDACNxbVOybBT2qMig0uprGHP3aEgGM+RIyTQ=;
        b=bZk6L6MX9Vy76v+M/Zii7qGq1xKExMeJT8bTZIsj9JAr1Fa0ceZHjIW3FM6h2XqwNg
         k++TDxLXwvboD+PDQJ+BG73+pHZyM2a4A6hAahkAJlmOUfs+8mgFLXDXeA1AwfWmCrYg
         egYo9k/AoW3HDn5FuDWj4p+gJKfKIJIoMyh0DqYvlhrFzAOTPmrmultRQIguO5pBhBOE
         XF4IA3UaO5bPQBvfn/T2zxSvz4ZUpeBd3cO4C8AbkpzoR512trbUpvMhOoP1g3LURk4a
         OS9+HhSgduVfBx48RZ194n5wGomx+JmBB3dOVyOr7tQ7EQz5JnW7bNn2730+DWoJMOzQ
         gcHg==
X-Forwarded-Encrypted: i=1; AJvYcCUoyyTzS2LApCRsgc3uWfZBkwa4e+alxybOlpCYVPwBMSOPZA8mxkjRlrvkI3W5Gzv6ZuJ3dLWlmaJ3nEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6L7K29IyueIlatHYwFpnvLGmqXO4D1PyvF7oXUsXsaYIzCBq
	VOwKGk5u8m+o4RONMMTmSyUbAy4iNryU8OflxBnPexgWLByWbhbIWtw+nVyI
X-Google-Smtp-Source: AGHT+IG4dLahHtutDalVm2ymCu3Q/BejwwfktlNjcCOSUUEWRykLPVrhxmsHRMjGgB7cdIbmX19kEA==
X-Received: by 2002:a05:6a20:2590:b0:1d8:a9c0:8853 with SMTP id adf61e73a8af0-1dc90b39de6mr5457055637.23.1731703318673;
        Fri, 15 Nov 2024 12:41:58 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1ffesm1782744b3a.155.2024.11.15.12.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:41:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 5/5] net: fsl_pq_mdio: return directly in probe
Date: Fri, 15 Nov 2024 12:41:49 -0800
Message-ID: <20241115204149.6887-6-rosenp@gmail.com>
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
2.47.0


