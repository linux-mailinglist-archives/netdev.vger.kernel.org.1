Return-Path: <netdev+bounces-131071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F298C789
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7756B1F24F07
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2F1CF7C5;
	Tue,  1 Oct 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc3guapQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AD1CF5E8;
	Tue,  1 Oct 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817735; cv=none; b=NYgpQ2ud9P1vhV8fFeqv3xcWg1YKGzcXO+2CJBzCU836kKu/uSuEoF4ZNOQwzyCYB2NT/DF7ycvTcdGfaw0evA58u5ZIXCvIXxIUPGd2psek036fmZN5j4IMT8B76BPSTYInk++E62AesueiCSgXlyze5+dXaMjCwQ6O0icKOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817735; c=relaxed/simple;
	bh=koyYEeR5HN11pk9/ElqN2hDHdB83gfCX3Cgnt9VKvw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+G+GeC3LEF+cIbPjeUviVstVHXlqF/CW3mHTrW6ZOX1dD4x6usbzK9R3hmpoB8qIUzu8Vha5wfDprXUMLr8eOT+sEAP+hNLf3P/ZWSV5KFEcWu3R7qWWwdaygA6hb0rQXMatXdPQWtPPuYFki+K9IVRgangNzTtXoz1BPfH8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc3guapQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso164780a91.1;
        Tue, 01 Oct 2024 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817734; x=1728422534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKbA8fFdky5oW8OnyEI3WYz8g/QfgSnOjbnn2zla0ck=;
        b=hc3guapQDzmlrWmUbFnkC/5ztdxw/IrqgjpdQDTXrJhJIoTAQZQQ7oDQOl1/RxSVEE
         Vuwn+D8ofCgMDP1xPEZA9J8VJ5ssCrvRnHDPdrtH1zKiIiFjm5QLGz6487W5vzpHbrl+
         oxfR56K8JhhuYty/UI18h0Qw8oDDZttu0lHl3bnGG0LIxsB+gFcLmWVkutJhcP69MvIr
         luBFb8IHkVKCW5/v16VCTAzK8qxeJG9e/07lAstVAkCVFEKntlCM+5YeKIoi8QWiHe1w
         o/YANbuz2Jr5/zViVLJNrUm2BO6y+qRefAbbYkLvnekIWRMfC1taluXeW/ILpi1WXH+x
         bwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817734; x=1728422534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKbA8fFdky5oW8OnyEI3WYz8g/QfgSnOjbnn2zla0ck=;
        b=Qn1GQ+S7wPJiunBC3iclO5H2vOkgyOglXgU70uvZpTPBsUhP1qtxSoWGZt9piWLQQI
         gBCNC7pENuA2LCCf+rjcpO6IvUgxqPKD6qbgCdNMWTFYGaVo6t5jE0MTeH8CpuUmeuKt
         gddPs1Wyx/HhedrY5s8swV1h/StIwaLGwPRGvxLE6Y/gx+EsQc4/30awh6yRjfq/ndZZ
         rKr3rGy28UPgx9MZuv7aEVke5xMX5UfPyUnwF55F1EhYe0vI7jmbre9wifBDqRgWYmC/
         RW4xOKnQKoXlBcRIf2B7Z/j7PGhIcJJOtW1eIb+GiLbOCpk9ba+oiymik6g46zgSASMH
         LYWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIIAE0MF/fkNNqPysNY393xIKhnUPPwHa2+q7vqrCWOvPeemcm/4FnI5ziI+zzJsy7J2b5DQOFkRS2c4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJYaBp+nnc/5G8QMODnaIIunrnB8Y0CZ95xEqf22OWTald3+c
	aWM1+T/b9x5rBkq79nKLx+8XrlS0PnXaqoACqPYoilbQAB897XD7R2ociIeV
X-Google-Smtp-Source: AGHT+IHyiaJ63rtVJ6JDEYDWdud4DyoFh2zxGza9w241E9der5D/TE9vnecuksGpMHZcOh3z3/B9AA==
X-Received: by 2002:a17:90a:7448:b0:2d8:3f7a:edf2 with SMTP id 98e67ed59e1d1-2e15a272c6dmr6901122a91.12.1727817733757;
        Tue, 01 Oct 2024 14:22:13 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 6/6] net: gianfar: use devm for of_iomap
Date: Tue,  1 Oct 2024 14:22:04 -0700
Message-ID: <20241001212204.308758-7-rosenp@gmail.com>
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

Avoids having to manually unmap.

Removes all gotos in probe.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 26 +++++-------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 78fdab3c6f77..96eeef0d6bd3 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -441,15 +441,6 @@ static int gfar_alloc_rx_queues(struct gfar_private *priv)
 	return 0;
 }
 
-static void unmap_group_regs(struct gfar_private *priv)
-{
-	int i;
-
-	for (i = 0; i < MAXGROUPS; i++)
-		if (priv->gfargrp[i].regs)
-			iounmap(priv->gfargrp[i].regs);
-}
-
 static void disable_napi(struct gfar_private *priv)
 {
 	int i;
@@ -483,7 +474,7 @@ static int gfar_parse_group(struct device_node *np,
 			return -ENOMEM;
 	}
 
-	grp->regs = of_iomap(np, 0);
+	grp->regs = devm_of_iomap(priv->dev, np, 0, NULL);
 	if (!grp->regs)
 		return -ENOMEM;
 
@@ -698,13 +689,13 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 			err = gfar_parse_group(child, priv, model);
 			if (err) {
 				of_node_put(child);
-				goto err_grp_init;
+				return err;
 			}
 		}
 	} else { /* SQ_SG_MODE */
 		err = gfar_parse_group(np, priv, model);
 		if (err)
-			goto err_grp_init;
+			return err;
 	}
 
 	if (of_property_read_bool(np, "bd-stash")) {
@@ -727,7 +718,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	err = of_get_ethdev_address(np, dev);
 	if (err == -EPROBE_DEFER)
-		goto err_grp_init;
+		return err;
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
@@ -775,7 +766,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	if (!priv->phy_node && of_phy_is_fixed_link(np)) {
 		err = of_phy_register_fixed_link(np);
 		if (err)
-			goto err_grp_init;
+			return err;
 
 		priv->phy_node = of_node_get(np);
 	}
@@ -784,10 +775,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	priv->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
 
 	return 0;
-
-err_grp_init:
-	unmap_group_regs(priv);
-	return err;
 }
 
 static u32 cluster_entry_per_class(struct gfar_private *priv, u32 rqfar,
@@ -3293,7 +3280,6 @@ static int gfar_probe(struct platform_device *ofdev)
 register_fail:
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-	unmap_group_regs(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 	return err;
@@ -3309,8 +3295,6 @@ static void gfar_remove(struct platform_device *ofdev)
 
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-
-	unmap_group_regs(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.46.2


