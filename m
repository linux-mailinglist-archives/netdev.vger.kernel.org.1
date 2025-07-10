Return-Path: <netdev+bounces-205928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8996B00D53
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4191C5C4B70
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A32FD878;
	Thu, 10 Jul 2025 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nImTiIho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FC2FEE14
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180043; cv=none; b=pEWZxIafxsyRRGhBhUmq8WbzlXOgayjgI/NmjOVAAx3KCXKXZURUgZ4ZQ6RHlTeLXv+OjNbkPqXrpoL+3GetOeE0k0WG+yfpIeW5BlhvgUok5POv9I18yHBg17XgJkTtCsAyYVUCKl8gXTvDxAEf43mHvEKWvT5I/Imr9Q1311w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180043; c=relaxed/simple;
	bh=0Qp94EDbLdiPzxzhuDo1Mam5+zEL7hcKwNbecyrwyXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR2R5fYH8BAbgMP7AkcwxRTyAV5n6aKCNqZOui18NSodt9PFh+emw2KKsGC6fX8lFElTVtsc2JsUhcD6DUymXW916l6ksT9XsXP5GVqLPHAgXgAwfMqfguxMRghwVzKw83PZK6wcAI7/ZJwpnyIp0fxRTmvsBtHN33Qxb4A1u4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nImTiIho; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e1d710d8so19351365ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180041; x=1752784841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aMgp5I9IiQsdOojykGoavLF+ncd9kJkX7ZtbpoQzgk=;
        b=nImTiIho4S/NlWoQn0YlbK+fMA0C72LmEtkLmlLOMQw8lWgAsNm5a0YAc73cycm5EM
         I766LwhWJkqBBgLYOuUOQld9AMtmlr1kAEEkav9jG7C5jJn5GqyyVLyfNimctsA9jiGw
         5/nqNmkUg4h4a8fze06pzVLKeLxpybJnx7jJDlpUaXCeA7UfBRIBBnYEMzSA8Kxw64iq
         /rnwStkUSxV1OLssAt1pnVuHJZOajS3ezepnVIkTKw+R/FYPLf2cv9ECFf2gUM2gwsDI
         nzGFckR+Hpp8Juq0oN/unv1wHwlu/PCTKo0M5vXKXr2h30SSm3gNMS6jJ4ZfjIAHgqP1
         +VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180041; x=1752784841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aMgp5I9IiQsdOojykGoavLF+ncd9kJkX7ZtbpoQzgk=;
        b=AA7J2SJ3LSQWRRSHoWLMCBldfC/JFE7byJnCItbeTVPpRgrSI/1R6Il5rtCw7I8HpS
         GxLtZl+PFi+1EK6V1QANmrBVqX55atQ4AjlwcjmNXfesavr+CXJghXE2lClxYSeFBFZj
         KzG+JtZEIdxsfqVeqFvKY5KaL/lD82WLmkWbXStwqzEx2QRZPCBc8QDr/UsoY3GtbwHO
         thFF+gTf9/uk6BmZvq1OrSp+WZMNhfIHM+/KAIQDpJDEExCJ2WnF88CGUlCQ7iUkG3Mb
         8Yjv0XMqL57JpW1Wytlpa6F9huPktVTexaFI97mjNDdqIkdjkbhPpLrgNY/1dKI2scvS
         HeJw==
X-Gm-Message-State: AOJu0Yw22WyVbz/hThOo4D/BpFlb48uJorFhZMEaMn8QkwYhY4oUXAsH
	h1ZXM6uDcgf7j4i0tZfmOb/nfr7EFX2FIrM3ZUynhP9LEtreFFEgWb+8/WwB9OEt
X-Gm-Gg: ASbGncsSIJ/GZ4dPQmkvqYeevc3ZC7uMP/U91qyylUCC9AwZMLadSGP3BUh/UIC3kSx
	vpfuFg30utiqsCrDR9RNopK78c6sZ8oDIJAsWmoZl1BkEhB4tN/wyLg51YlD/4DQl2MJo5EExxf
	WBDgpLLm+bHD3Dfw/SDXuSQw8D9wqjDqVEyWt5jN1fsmpxkChr6FGmhDZLEYhCCRHHedG4QY/Ex
	cauF8AQZm0Bwl8YqybV9EmLzPX9RnNfyM9IUN35oeNbX9RABX0XZlmf6mqINFpUqftn0iVmuynF
	5Vyn8SZeYQY+RKqBsaZSWi2EQduVTJOG9JMD6WPDT4JSK/RPYZND8qk7JJEDciDNALVcw1sToI5
	UW3c=
X-Google-Smtp-Source: AGHT+IEQTolIZCH1Xxm6I/qUhDpBoBfxTj7w3rRIyNP5W8BZlqzhxYYDg9KsQBPXJGGCNMc60h07bw==
X-Received: by 2002:a17:902:eccb:b0:234:e8db:432d with SMTP id d9443c01a7336-23dede8d53bmr8895205ad.39.1752180040667;
        Thu, 10 Jul 2025 13:40:40 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 09/11] net: gianfar: remove free_gfar_dev
Date: Thu, 10 Jul 2025 13:40:30 -0700
Message-ID: <20250710204032.650152-10-rosenp@gmail.com>
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

Use devm for kzalloc. Allows to remove free_gfar_dev as devm handles
freeing it now.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 2e9971ae475e..a93244415274 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -467,17 +467,6 @@ static void unmap_group_regs(struct gfar_private *priv)
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
@@ -505,8 +494,8 @@ static int gfar_parse_group(struct device_node *np,
 	int i;
 
 	for (i = 0; i < GFAR_NUM_IRQS; i++) {
-		grp->irqinfo[i] = kzalloc(sizeof(struct gfar_irqinfo),
-					  GFP_KERNEL);
+		grp->irqinfo[i] = devm_kzalloc(
+			priv->dev, sizeof(struct gfar_irqinfo), GFP_KERNEL);
 		if (!grp->irqinfo[i])
 			return -ENOMEM;
 	}
@@ -811,7 +800,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	gfar_free_rx_queues(priv);
 tx_alloc_failed:
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3324,7 +3312,6 @@ static int gfar_probe(struct platform_device *ofdev)
 	gfar_free_tx_queues(priv);
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
-	free_gfar_dev(priv);
 	return err;
 }
 
@@ -3342,7 +3329,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	unmap_group_regs(priv);
 	gfar_free_rx_queues(priv);
 	gfar_free_tx_queues(priv);
-	free_gfar_dev(priv);
 }
 
 #ifdef CONFIG_PM
-- 
2.50.0


