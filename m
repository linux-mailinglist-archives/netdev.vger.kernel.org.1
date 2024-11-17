Return-Path: <netdev+bounces-145691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF39D064C
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 22:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A796B21C46
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E671DDC13;
	Sun, 17 Nov 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJmtlOtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4849627;
	Sun, 17 Nov 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879096; cv=none; b=HD/CGvcK1sx8nQvM8fA6GQWK8ylw+hLtPBrrWxF5M3SbFe0NSJtgxDtKbFOOhM2Ph/Mq5bBVkxJCUP4lA8fdFE8C2znBfQakQ11nGeo/GGthjSNMz03Ui/KZX/HF309zMc5SgsfK53juRtRW3GYIhtMw7g7tnsiyg1PRYeqgEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879096; c=relaxed/simple;
	bh=WetT4KCWoqobKHA1jyiEvTHpEHivM3duZhF3iopc4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP9qPIgM5e6/2neO/XTNxER+PIGw4cBpJZKHW2cztJcaBkI9kdjt09Yl3rPiHoMmqrH4lF+LaFNS3tbZFuZlbI9wTxeQFKj/FyyI88W9vpWqBH2ukzeYTXKnNRtp/EqDZW8GD3flBX9mvg1TT+TieoBpUrEMwBHA9sEpY/RnakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJmtlOtI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21145812538so27476625ad.0;
        Sun, 17 Nov 2024 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731879094; x=1732483894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xlv6opsF0xbu6Gw4XKogPA2B7SDuqsnkMJ1U4QmmKM=;
        b=RJmtlOtISRoWsJeC3l1dER0iC3MDW5l7H8XLj2TsS0R8VMD83OLm2+222rpAljjAfl
         Du+uncsHVrEL58WCqNj0yl8TiG2PhNwPGtSVkRR9KaHZkuDBKQs8VeIgYNQlL1CuMl+j
         dyvIPHPfmDJLpjB3dM/7DEUtuZ/fE+4sP42R1Vt6xs60Yhu2GLh3YKlyBTchE39lMwUa
         /sk0w1khkAObKy16iP8CYU2L6eWVZURfkkalEuj+U3/gJgBjJQKIK4xewmOJF+Mcr6X5
         HBSI+sOUocQDj7RLcAlcjaH9BmBA369YuwWfncfAKuSOYUO+TT2VDYyLlXAENThexH30
         nq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879094; x=1732483894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xlv6opsF0xbu6Gw4XKogPA2B7SDuqsnkMJ1U4QmmKM=;
        b=k3GhwY6juAMrixXlOVnWzkoFYeHusMIhJfTZqyi79CNkm8idrTbVjoX/4w7kkOUT/9
         0VNn3G0PjFnemk65q2IhvhKpY1f7MNdbCNGyF5sCdB0T+lD3eBwzfrbMVC/fsmmeCkku
         HGyIER6mVe71/trbcpVtN25tJg3zzp4wFpaGH4XhuX/oG4h7xGtBzn7fj2RvdS+nWKqN
         vRmpTOJfbWdwTH+6ePP5HtY7HAYtrO0c2Cb5lmzKl2O1HkH2N6iW9NSWNq2WEVsLNxtm
         Wp9m8LZMW3io6VZSyvLfxvVtn7P7HU3rmVURPtX7Gy8wkxq8svpR2TA4AWCJcLGEVPlZ
         U37g==
X-Forwarded-Encrypted: i=1; AJvYcCXYX+UUSJYZFIEg+Q57Cn9OYoziJHDX85ljkH57CQepe8GGd112CtOXxtCV37qFkb6OKwtVbv0RdzhgVgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7SVc67zwBSET2L6xHmYTLHG9tMZ2nhLejGcpy4/hC5dc3iTQ2
	2gXx9rjMjzq8X9WpSPlMgVBKRl7P8TYJO0gqmArBLGb2Pn5RnmL63rYksA==
X-Google-Smtp-Source: AGHT+IEbPo7/RsqoqYS1R2HSOkld3HYam7F/UlIkNnwEVGlYkSMVGrwODRuekp+yltSTXs1c7iiZmw==
X-Received: by 2002:a17:902:d491:b0:211:d036:1794 with SMTP id d9443c01a7336-211d0ebc504mr162073895ad.35.1731879094258;
        Sun, 17 Nov 2024 13:31:34 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54299sm44277805ad.254.2024.11.17.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:31:33 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: mdio-ipq8064: use platform_get_resource
Date: Sun, 17 Nov 2024 13:31:30 -0800
Message-ID: <20241117213131.14200-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117213131.14200-1-rosenp@gmail.com>
References: <20241117213131.14200-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to get the of_node explicitly. platform_get_resource
already does this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/mdio-ipq8064.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index 6253a9ab8b69..e3d311ce3810 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -111,15 +111,16 @@ ipq8064_mdio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ipq8064_mdio *priv;
-	struct resource res;
+	struct resource *res;
 	struct mii_bus *bus;
 	void __iomem *base;
 	int ret;
 
-	if (of_address_to_resource(np, 0, &res))
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -ENOMEM;
 
-	base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!base)
 		return -ENOMEM;
 
-- 
2.47.0


