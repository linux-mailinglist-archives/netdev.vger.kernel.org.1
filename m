Return-Path: <netdev+bounces-123516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D196524F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B19F1C2458E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368661BC9FB;
	Thu, 29 Aug 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYd+OAZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B91BC07D;
	Thu, 29 Aug 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968129; cv=none; b=jrYCpymoUMUSixIyabRxZiJmRVWKFsxHvw6/2NEPWSk/nXoBB53edEYpE3xoz7Z8QoqzKLZEWYWLy7mt+8Kh7ZVn65mz9e+0BluQigRolAsgIs9FlQ1szKXPNRfxicGuw9O8q9Qxv+i00E2Sc1Ef97pOCMShLisOnJG4dJRsD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968129; c=relaxed/simple;
	bh=itybp7DyH1Cjv9Ex8+Xw9r3k4ffsNQLKDTZ09I1GNmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr6DV6dejBHoryHupp6yjzD58uZfCUQY4KEICoikzKGpUt5GcApysWt0Kk/rDioT0ITsiae3XAUs8QAhOac3VMo0zS3XTA7nLzF1KpmdYLLprJtQEeTRvbhT/PqNTkxtvASEYZfsDCXlOf1182lu860+03Joosj82g2gRuwv1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYd+OAZl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5dd43ab0458so668501eaf.0;
        Thu, 29 Aug 2024 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968126; x=1725572926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZLpENSjaZtJ9PRB+Lbx2VcX+eLUuNb31MGeOnkf5DY=;
        b=jYd+OAZlIbkshrJNGO3rGjMXWTmcMgzNbPW9slML8ArDnwQWMT1+C9mLPOWOA+txMj
         vAS7BPizVZUMUREmwUutuA9jn52sDMGAZz5L30pQPlFpc2Y2wHaAVPU2ydsBYU5m5PAs
         hEb3Oek9KkAfFqQDemjLLv2czB1iEcxPF7rdTBnWOrJQv5xB6ohNmHcoM4SzBq3Y6AoH
         EEN1hGxxQMcA0yBcJViIv0oaZvpd5nMIfZNRWZarqcQbllHp5eG1SEgwccxpIOmd60kK
         h7aRCbuHz+AcTANcej/S+irs6I6jeszLx8D/qGQPH11/rFkGsCzbvF3rD3mUlQVC77+o
         3NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968126; x=1725572926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZLpENSjaZtJ9PRB+Lbx2VcX+eLUuNb31MGeOnkf5DY=;
        b=Q4PZYrgIAGVE5J2pMhKRRBzLlgb6nMaasizgwmPxINfYjTLBl0RIHj2vaipXZJZH+v
         7AqdiSCAQPncQhUBZOtzoOEIOY8M3FOBApFXOOnqyy4BuVTknK9uAFyVcLmA1M9B4fYF
         hELMd6q0iqKKk19pc1GQ8O3DSCL6xqrirnuwWtF0kMPKbZTSuQZJdxe/lOqoSDUu4Znj
         MFLOtZpEAGrh/2/KROoqSGe15ta8OhgDrtYUXchovLZtVo5X8At3NBeLJKtqeh+t0HV2
         6t7eGHoBbomVoPCRwt52sGIES78n04ypzomnerCA7WCyUVidOI2UXZdDXLIrNG/UyMFR
         Bgvg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjsyYVrexBD2sBUa+ltrjIfJ4n90dLHi9uB9WgbVDxXOUpMFlXGELpAWKcrtO2SzAJ+PRkhN2muTLq6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2CyA5xIwo8nLs39yMXC2CV/c/fybIvdLlZMu25u2l6WtWsYE
	jfWwOun5xtukuxL5RZkKFLp2N/q5kGPQROEiLSsQtsEzO73nX8mqn8UUI3DG
X-Google-Smtp-Source: AGHT+IGi6/JnFAKDmHJiix8wTxTSRF9e9TWfXZ6G7JU7GHAKv50aJy2Pu0jw6/5/FwJxUbkzAtISDw==
X-Received: by 2002:a05:6358:9385:b0:1ad:282:ab1f with SMTP id e5c5f4694b2df-1b603c35c8cmr552422655d.7.1724968125663;
        Thu, 29 Aug 2024 14:48:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 4/6] net: ag71xx: get reset control using devm api
Date: Thu, 29 Aug 2024 14:48:23 -0700
Message-ID: <20240829214838.2235031-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the of variant is missing reset_control_put in error paths.
The devm variant does not require it.

Allows removing mdio_reset from the struct as it is not used outside the
function.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index b2e68e6eae12..d7d1735acab7 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -379,7 +379,6 @@ struct ag71xx {
 	u32 fifodata[3];
 	int mac_idx;
 
-	struct reset_control *mdio_reset;
 	struct clk *clk_mdio;
 };
 
@@ -690,6 +689,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	struct device *dev = &ag->pdev->dev;
 	struct net_device *ndev = ag->ndev;
 	static struct mii_bus *mii_bus;
+	struct reset_control *mdio_reset;
 	struct device_node *np, *mnp;
 	int err;
 
@@ -705,10 +705,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	if (!mii_bus)
 		return -ENOMEM;
 
-	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
-	if (IS_ERR(ag->mdio_reset)) {
+	mdio_reset = devm_reset_control_get_exclusive(dev, "mdio");
+	if (IS_ERR(mdio_reset)) {
 		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
-		return PTR_ERR(ag->mdio_reset);
+		return PTR_ERR(mdio_reset);
 	}
 
 	mii_bus->name = "ag71xx_mdio";
@@ -719,10 +719,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mii_bus->parent = dev;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s.%d", np->name, ag->mac_idx);
 
-	if (!IS_ERR(ag->mdio_reset)) {
-		reset_control_assert(ag->mdio_reset);
+	if (!IS_ERR(mdio_reset)) {
+		reset_control_assert(mdio_reset);
 		msleep(100);
-		reset_control_deassert(ag->mdio_reset);
+		reset_control_deassert(mdio_reset);
 		msleep(200);
 	}
 
-- 
2.46.0


