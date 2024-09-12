Return-Path: <netdev+bounces-127641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E8975F26
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A19628567A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D594126C12;
	Thu, 12 Sep 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwwGieyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBF86126;
	Thu, 12 Sep 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109350; cv=none; b=dR+zIFz9/cuVQMewXCKdojJ3GFz6tECqYN8KQP7/Nt2mqgRrBeOHlKoB65dDWY1fucL2M6Tk0AgZXHE9C65LCbf+3YwJAutkrEXISqyXmiYGyjC//bPmPFpNGrEyPhU91qQLSaysIRpOK20rj0uyY9GddAWRW9p2P5BtqK/UfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109350; c=relaxed/simple;
	bh=aoXk9arIfv3ecnzbz6memLs14hzaDhWaeSs2rtozQkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0+xDfqyy1Ihj2L0zWTLTrOkM+Gay/dR9Cr3rqvad1HpPeuee3yiF+NLnB/cUQLL01LqyT/EcDzAzWrIyEfoIzEM1k1TGaPfcaoghfQtslwjJbVQuC+WQY24Ue9xS/MTJzqf9+IRMJeygVm2OVMGKlfLvK+msRdJCUcR0CBdfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwwGieyF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so310269a12.3;
        Wed, 11 Sep 2024 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109348; x=1726714148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXGljPI9SoQttRL3JczIBiwQbDmmnUm1+/a0VChwsQ8=;
        b=IwwGieyF1uXhYk58p8AHMsUPq3lZeqzV/68LgbtaZ5yNcOVtMrJx157E0+Jug/LFUz
         yAALCzyQWYxcoLiqEknlBMAXaoSJ6Wtsbbc1WIPn6UI9BiV/QKwE0u8cyy2LA3Lys1Hx
         pU0tu/SF6T4UPhlYkMdvvvqZi4e6my/KEaCwi/gCVTgSqQ9UaVFy5xAXHbwZhyDtsw8u
         k3FwPNuJ1yWszFxmGGWsBCIpxFVYXi0gQstEr7driIraIAmkbWTAHoj2vg0IfmLO5/Ne
         DWwPgoIWvMmLd9V3gXHKiowqCk6tfzNz5QDv+h22ZMbb2xOWEYwgvoN8WvZ7W87rPFK/
         qu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109348; x=1726714148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXGljPI9SoQttRL3JczIBiwQbDmmnUm1+/a0VChwsQ8=;
        b=mtrWB2xqG76LfzBZF3D0mjZlGdBaCc/BQXncHFzvr3mDMavUvQAphsu4DuFP+GTTRe
         2UeECjm/ywuvKCsj4CBGmedama4R/ViQI4cWFCHt8tTr+TGF61jEWhgCS8bi0ElETkfs
         BoQklqSiIRblW3p6qpgLXtGZt4xHRfOfppNJklB1/j9s4RgQCmfxZUKCQ50YgAULLEum
         mtEGWZB//RIQndL/4WlF6eD8v8nz4xFue5sqHQS7AUTVqTwfIa2uhepW2wdZxZzIFJ47
         yjYr2vGpqNddKlLp7kS2KFKHG47ksijK/y5jGO0bCdbhclx9I24WNdUR+adCVcCmEqLz
         KdIg==
X-Forwarded-Encrypted: i=1; AJvYcCUIACSngMQED7IjhagNBM9WTqiYw8q2lPdNowuZEH0cjSG8w5j74tBViQ4f690lIkTroogCaquJzi8zB70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5acvsDXEvzdvXoAs4wAMK1BveTXLgZjUEbcMA78EocqmMnUPd
	EnrkAXA3IAkMDyr3RNR1DubY6vvX17jDlTOaJ8MqnYPgozeWNTJvWoI81Srj
X-Google-Smtp-Source: AGHT+IFoGD1B7jwJYlF5TCar891eksJRHKY0yIeiCDC9yJVTsnzh7Z9gm7ofQn5vFFNsAPha+u4pDQ==
X-Received: by 2002:a17:90a:684c:b0:2d3:d414:4511 with SMTP id 98e67ed59e1d1-2db9ffefa37mr1467150a91.24.1726109347734;
        Wed, 11 Sep 2024 19:49:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv5 net-next 1/9] net: ibm: emac: use devm for alloc_etherdev
Date: Wed, 11 Sep 2024 19:48:55 -0700
Message-ID: <20240912024903.6201-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to simplify the code slightly. This is safe to do as free_netdev
gets called last.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 6ace55837172..0e94b3899078 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3053,7 +3053,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Allocate our net_device structure */
 	err = -ENOMEM;
-	ndev = alloc_etherdev(sizeof(struct emac_instance));
+	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
 	if (!ndev)
 		goto err_gone;
 
@@ -3072,7 +3072,7 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Init various config data based on device-tree */
 	err = emac_init_config(dev);
 	if (err)
-		goto err_free;
+		goto err_gone;
 
 	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
@@ -3080,7 +3080,7 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
-		goto err_free;
+		goto err_gone;
 	}
 	ndev->irq = dev->emac_irq;
 
@@ -3239,8 +3239,6 @@ static int emac_probe(struct platform_device *ofdev)
 		irq_dispose_mapping(dev->wol_irq);
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
- err_free:
-	free_netdev(ndev);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3289,7 +3287,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
 
-	free_netdev(dev->ndev);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


