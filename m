Return-Path: <netdev+bounces-121138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739495BEEB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6653B23BF5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575A1D174A;
	Thu, 22 Aug 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn1BB4lL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339E6D1B9;
	Thu, 22 Aug 2024 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354882; cv=none; b=baBdI6K9A4bis71nqjMoA1TzYQuAQTJmPqDfflmEmeT9Qw6MX2aR+Eee4V0f0sV/FGIiWeK/EGcvM9K7LE5pkkEmiPwnLFLmYRc+AXP4h+ETvZCoODUvx8Cd6SY34DHTWJybTgYcD009EKeMyHYqEAKAWVl3UWVC4zTWvT3b+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354882; c=relaxed/simple;
	bh=EPGJDzdbvkYAIF7+d15WcOPZS1rKpxbUpbB1Tlwo/fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+avIojPSsTjaRMr50KYNu5bvp+DDaJzVxvSuErsN3d2i+jFwTwoLmP4pw8ytCgi0zl++2DVjME45OT4E3B4FJ/IDQH6fs7SQn5xBAkID4kmF1sozjd6S03Tz2gT2k2YJ7Ln7/nY3H2XAgWWeaL4kyUdMXcjcfPUUdwf5xU2bxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn1BB4lL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20219a0fe4dso12368465ad.2;
        Thu, 22 Aug 2024 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724354880; x=1724959680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJeYo+1wAomlBYX6urDi3gtg4xQnrWhVqDHvLS4DoaI=;
        b=Hn1BB4lLfV9OjL0V98GXYHEpYQforiFzgCRtiqvY0msNENy7KRIaDiQ7eFLeR5JZfJ
         3RDSMwvarEOmafhESRWzgoUd6PJqZ88Q2U1SD1TDRuQjx42UVMWFty3sqmJRNzvstfa6
         9HEYTmr+ZXGDO4CM8XA10m/igVjSQZ/tkXNSh9TbCnY1WLrJj8rYIjUs8yUfEX4lyoUG
         UYCje21fr6sZD0s4M7pfqNL02236KIFODKfKfKqFBa/eetHXzJjykUKZv61vicO3T8sf
         a9wYJc+LHsSsup84HQxEXtzF17vuBzWa1gNKJ/DI13lDBmT1sRs8skFduCQJyL84lO4D
         WrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354880; x=1724959680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJeYo+1wAomlBYX6urDi3gtg4xQnrWhVqDHvLS4DoaI=;
        b=vcILUoXv0LbkGjg7Q2GMho9ZK6VjRVvK/nrb+EFAvCQY4biwcwfC1NeWNq8AL2PMfx
         P+2mHQ3y5O1+mmNy0HpX8n6vD/4XMgjzBe+oMkO8sofKGfG6qlwJ4tZIDs1luYipvl4t
         oL/PLpRVhsQwyAJJ9nFQH9iIK0OBAP1oNdbDzMxPUhL1eUNG8iBFgNiVKNFIIEmFxCmW
         FXsoJninTCfWtNFNk0PkRY0vwSY+PvacuSBIWvPIVAo6j0bpdchoFSA3wlss3bGipAgw
         IzLP8yvRdSNZ5X5GagLWlINJFGlugb7i/2u1a1c6XpxMvPc0tFkYmzYPt+VrjIgOPnRT
         rltw==
X-Forwarded-Encrypted: i=1; AJvYcCUhGkhgJNBlytgFx9iTXebyE2cd45PBKDaIrlSta6f+HuTPcyOWeeYW9IaY/a93Q1nQq3W/vnYbv5hUcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOArjbySh0Vy4NjvIuM6/4pjTSbzd1bXcDAAQnCEhJxRId4T/1
	1Ja/lVF1fh2IE3QVeLoQSnD1gTKG9nU+X76dUN758V1xq7SmPix1EVEUWQ==
X-Google-Smtp-Source: AGHT+IFjJbwYupcp7z0d6j/7Abj2ZR7pOHq39Ze8L6i6Jcn1Lfl3L3x3EqyMXTXuSXrXy3EsuwJd8Q==
X-Received: by 2002:a17:902:e80d:b0:200:abb6:4daf with SMTP id d9443c01a7336-20367d45d53mr81933075ad.39.1724354880110;
        Thu, 22 Aug 2024 12:28:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm16115785ad.157.2024.08.22.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 12:27:59 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next] net: ag71xx: move clk_eth out of struct
Date: Thu, 22 Aug 2024 12:27:52 -0700
Message-ID: <20240822192758.141201-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only used in one place. It doesn't need to be in the struct.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 95da34c71b34..89cd001b385f 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -381,7 +381,6 @@ struct ag71xx {
 
 	struct reset_control *mdio_reset;
 	struct clk *clk_mdio;
-	struct clk *clk_eth;
 };
 
 static int ag71xx_desc_empty(struct ag71xx_desc *desc)
@@ -1801,6 +1800,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 	const struct ag71xx_dcfg *dcfg;
 	struct net_device *ndev;
 	struct resource *res;
+	struct clk *clk_eth;
 	int tx_size, err, i;
 	struct ag71xx *ag;
 
@@ -1831,10 +1831,10 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ag->clk_eth = devm_clk_get_enabled(&pdev->dev, "eth");
-	if (IS_ERR(ag->clk_eth)) {
+	clk_eth = devm_clk_get_enabled(&pdev->dev, "eth");
+	if (IS_ERR(clk_eth)) {
 		netif_err(ag, probe, ndev, "Failed to get eth clk.\n");
-		return PTR_ERR(ag->clk_eth);
+		return PTR_ERR(clk_eth);
 	}
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
-- 
2.46.0


