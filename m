Return-Path: <netdev+bounces-131067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9F98C781
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82A31F24EA4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1E1CEE9C;
	Tue,  1 Oct 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2TstskJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF11CEAAD;
	Tue,  1 Oct 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817731; cv=none; b=KXq7yxeiKHFRG3KOYTzncud3zAZnCQ8JneyzfxxZVCQ9WFpfNmRbpJD0jkhu0Z6d6Yc2iurcNchX9f+t+mdl5wi0RseMrMXqqma9+ld5//A8zDeaJ6ylSmbj3JPReAPWGU/t/U4shMzKjT8lDL8ZSxaHgUfQhpNRC8n+SYlKQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817731; c=relaxed/simple;
	bh=9Q5agciWdA2H/WJ7vJSOTUGmr/gveKXGkvwR3V8N9XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUNIlq9Co9I5MCFd8ZkKm2fj1sESiqxSXBTAMuWUys4Y/nYks9X+6jbi0D99jFpxgOHnNa5kXaLzySWeO8sKH21Cv6Ns7eJbbcXk46kl6E8zTQZTESedd+ISVo6NZKhb+bclXuaBYgWySwl3/VmflE2vm7Nj8jQTZwIGwURJTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2TstskJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-207115e3056so53283535ad.2;
        Tue, 01 Oct 2024 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817729; x=1728422529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf6XPBJXsV3C1pdORRthVZYcFYNc0YmjoVi/+fynFic=;
        b=i2TstskJ7N8+8NsafPjtJFWGEBjOlGlS4NSvWTw+H5WrPnnWstPHFJtSLI6i3rJzUo
         I+K6/wjm+YhCAh+YwwUZLwmpVSR+ZJ4lrCTCCaJkmUdfPXDeDcGGkSOvrFfcygwtmyRx
         D3KPH479ybiL3j+IUntd6UF4+L2qYGg9HWkXWqYMelP4hj+ioKPAHlgLuP87N2H7f3+F
         NL/ULia4wxeLoF70BnfGWr6zoga5gAwPddWdxa5IgZB4OcjevSq4FVfIQYPi0/zDmX7f
         iHVfiPIaiDReB6UwO7jxD8LD9GgRRhcG3Yr/343B4NuACxU6ATv+zN7M/JCefqxiliRl
         UX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817729; x=1728422529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf6XPBJXsV3C1pdORRthVZYcFYNc0YmjoVi/+fynFic=;
        b=pIMI/VT6kbPNP+hR6OkQ172zA9paRjdCW7GqGAzHJw7i66bndKe5cW0v3BTrgtCU6U
         qNSCjeDDLCbqbHC6aT45ohbxvJBEzrjP38BuaNsvVuyofPig1gjpuZVairxaNmvry/EF
         3E9f+6+McZ4FTSGHPbUmlZgVq+mCmSztCqCEqhYH7RwaXTbgGnB6vwShz8ZS1Fb0Bmvc
         qE+TyhUlhfWibIWuwwxQ3fPxYTzElNSizeow6DAijER+vJJzMJ2WYpnVQCF4Gro1Gywv
         Eyp7NGR+tK4BBmzy8C5sobHvxl7LcUGT+1yc9BrODcIpaY+KraUi6pgC9kaa2/kw0ij1
         BW0A==
X-Forwarded-Encrypted: i=1; AJvYcCWHoivBaDVnhpBGz4gK7p/p28XXm8Sdvv/q+hfs5mts8rg8hRmAJcn/KXhUOoScZIWdTsp5chyZxY7MY10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mNmiiTtPsLpTiuu/OmKv013bD7VWWNnuto6x1gvwb5nUm0kU
	8Gcq+Kl9gOUbYUM74mAbAb1uC9D6SKTKKH1D/WfT3w26H2Gw5kgMo4Nwjuo4
X-Google-Smtp-Source: AGHT+IE1gh4CPWQ9a7myNbF/0/fAZ7oWNfd3eupBEgKmKOPkijAW4+43Ffa8jr8XzPDqLPg2UMSwYg==
X-Received: by 2002:a17:90a:62c3:b0:2c9:6cd2:1732 with SMTP id 98e67ed59e1d1-2e182cad975mr1248967a91.0.1727817728818;
        Tue, 01 Oct 2024 14:22:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 2/6] net: gianfar: remove free_gfar_dev
Date: Tue,  1 Oct 2024 14:22:00 -0700
Message-ID: <20241001212204.308758-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001212204.308758-1-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Can be completely removed with devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index b0f65cdf4872..9f0824f0b2d1 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -466,17 +466,6 @@ static void unmap_group_regs(struct gfar_private *priv)
 			iounmap(priv->gfargrp[i].regs);
 }
 
-static void free_gfar_dev(struct gfar_private *priv)
-{
-	int i, j;
-
-	for (i = 0; i < priv->num_grps; i++)
-		for (j = 0; j < GFAR_NUM_IRQS; j++) {
-			kfree(priv->gfargrp[i].irqinfo[j]);
-			priv->gfargrp[i].irqinfo[j] = NULL;
-		}
-}
-
 static void disable_napi(struct gfar_private *priv)
 {
 	int i;
@@ -504,8 +493,8 @@ static int gfar_parse_group(struct device_node *np,
 	int i;
 
 	for (i = 0; i < GFAR_NUM_IRQS; i++) {
-		grp->irqinfo[i] = kzalloc(sizeof(struct gfar_irqinfo),
-					  GFP_KERNEL);
+		grp->irqinfo[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_irqinfo), GFP_KERNEL);
 		if (!grp->irqinfo[i])
 			return -ENOMEM;
 	}
@@ -818,7 +807,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	gfar_free_rx_queues(priv);
 tx_alloc_failed:
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3361,7 +3349,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3381,7 +3368,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	unmap_group_regs(priv);
 	gfar_free_rx_queues(priv);
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.46.2


