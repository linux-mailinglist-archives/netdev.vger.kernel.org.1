Return-Path: <netdev+bounces-122027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6795F9B1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2504BB22D70
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE1198E9B;
	Mon, 26 Aug 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai2HhIRK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6351991CA;
	Mon, 26 Aug 2024 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700549; cv=none; b=h1uaBLD4bPpcsFmdNglCBYr93QISu3wOW2BVoRFB+LUP9QyE4ktlt75a3gjdFoKXR5h9stDQmfOh9pzRfCznUfRDLrE8jDD+jMtflLjCpquB0jXfckH8s2e55MP2dqWOUWTi3r0WVdgg+XyPMVoQfjrHonneEicS9HqWuij6A8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700549; c=relaxed/simple;
	bh=qzjw56VHpF1Hz1kmMdSmdxvPkhrxPV8tcnNAei8IWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=deRk0XVfduvWWN7dJ3IyAksjxe4fqMGS8E9S0+nju82/I4V/UiEVWNPmR0jDIgE2QPUrbsPEQVg/NuhFwvMaTG8jHt8uHmGxo27jwtrg6tTJVz7MTvSkmHCTz+AuOibG57RzILGEtRenDiOfo5QImX50y9wMu6AyzSsJ+eYuAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai2HhIRK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3178707a12.0;
        Mon, 26 Aug 2024 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724700547; x=1725305347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMwN6ORMriLuuuHsKwbn4hdZecy/CTM/5XoamAdu1eY=;
        b=ai2HhIRKNuT+C+8P3W8knK+pTMhYVbigJJeFM58q3B9U/yXjUa1Rhm3HlkgLuW42Ox
         gbOGyTcmXN9GZ+EceQdPLJuVGQ9/p4hnRyhgiWAUppNoNGY73xdjzlUMpI/DpBhPoSTc
         7egAbk4pBa9y1cpZEODtY1EzlrazLWtFCALEiXlNI1h2I+WYEM4q/Ng5oxxG2RVmXiti
         hplf2VMOQyJuAXkHyugeASVUOe7ElkAvjS+Tv2+CcYsH5/XbWDY15xLUe5W1X/ZA5da8
         fgE49CLGpUzZnY+TQeom6rTeiBCYv+oj4EJTfid1OIP42Kk/Dp5Bc28QuvWPdwFOkmVR
         lpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700547; x=1725305347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMwN6ORMriLuuuHsKwbn4hdZecy/CTM/5XoamAdu1eY=;
        b=L1D3i6gSgcUFalhBYcflGDmI5L/gXdQgoRrbGEB0EiQqUD6fM+56KjxBwKB27uLibh
         22ARDw65TaHOOikisGHHz8A46gfMxty8EQBMaugX7ux2OEO9dnVcN6kRF5/+hU/pREYs
         CQHonpBWcxBwENZgbQQmmx43ATO+t7vG9y0XKStsM40r1siIaChspTyYlrRi3Oz2oUnk
         WiCIHh7vP9xRJbjtRbZnKvBDztIMsPIwUO43JNb13G3CMvG07nDW/lQEaFtsm1vXivX9
         fboyb2+Ug+nxxWlXw61G0hTtD7P8Z3Mt8l7nr+02e55sJwQ5x+m/ZMrYIgPpTzVlXsLZ
         aNRg==
X-Forwarded-Encrypted: i=1; AJvYcCVBuJt4T5jEGMAxRU3diT0Gq/ycpPThR/T6ueh14FV/kWF5d1EufgBcFQt1s3tyncZpY/FdOJRAoL+o9SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEm+xFdumvBQaXWBIYrZeFSk33pTp0xbyhH4yYU5PR7GiJqfz
	t1LJAus/8UzudmSeuUyloR7cmoe2feB3+tetjr7CZ58iOCXNrZmxEMg2bw==
X-Google-Smtp-Source: AGHT+IGZBOQq4LU1i0WoA3ZjY6B8iOi/TvBihPp0Io6yp9XMO/kpo1VPn6S3z6ICZjKda/p31c5zmQ==
X-Received: by 2002:a17:90b:3804:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2d646d382b4mr13607741a91.34.1724700546719;
        Mon, 26 Aug 2024 12:29:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb913460sm12540972a91.21.2024.08.26.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:29:06 -0700 (PDT)
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
Subject: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
Date: Mon, 26 Aug 2024 12:28:45 -0700
Message-ID: <20240826192904.100181-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
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
---
 v2: don't call after ag71xx_mdio_probe. Already done.
 v3: use devm instead.
 v4: resend
 drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 89cd001b385f..d81aa0ccd572 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -379,7 +379,6 @@ struct ag71xx {
 	u32 fifodata[3];
 	int mac_idx;
 
-	struct reset_control *mdio_reset;
 	struct clk *clk_mdio;
 };
 
@@ -683,6 +682,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	struct device *dev = &ag->pdev->dev;
 	struct net_device *ndev = ag->ndev;
 	static struct mii_bus *mii_bus;
+	struct reset_control *mdio_reset;
 	struct device_node *np, *mnp;
 	int err;
 
@@ -698,10 +698,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
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
@@ -712,10 +712,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
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


