Return-Path: <netdev+bounces-126245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3E9703A3
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646A728371A
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43409166F1A;
	Sat,  7 Sep 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjH1YzYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A91662EC;
	Sat,  7 Sep 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734736; cv=none; b=hZKacyeHeelWmrYSYcEthJN1wRpXNU8O8kM1BwSejwTsROrNDEEC1CGoYDWkMJWHq0IVrft9Afpiw72tnqC8rImukkkRihUtfbh6WJIO5wkzaeAZm4DsV4ELNOe9CpIGt6Kfk2UFY45lQl3dHWutZhXWWdHVcMR1lK+DP9xjeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734736; c=relaxed/simple;
	bh=6UHB6oUMvL1d+ctYRTVBIucLnABeJIO/OQSm3S9Ymec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm1Ad+mDneBmNQLYPgWXdlYOQr8n6xSLmxUJblQgxx5YDjtgfjYO7WjLTmjfDCPLmOLSStW3LIOruXznWGAnyo0Wzt66qO5uEVLiOsiX3mb/AsrrC2efUoVhKb5k17d/jB/C9WDXrAj8tOir/YW4AX2lNQsEIBCGgCIfvLVSyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjH1YzYm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e482930bso363294b3a.2;
        Sat, 07 Sep 2024 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725734734; x=1726339534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caFpZnX0D2laxG9sbBS2ux7cswRR1JlGkryvwZOpG1s=;
        b=HjH1YzYmr+SAAZTnTeW/KC2u5cLGK9vae/i+ZxEJXmUXSa+diCG0iLQ+YKehrZdkPT
         1TlvejMyW6UkP/FxrO4rFTbB5rVA59H/QKGjEuH470lZXpWEtN7/6TU4U9XxB9blxMAm
         Wu0NeYRjR8y2JuBeD4MzwwxgdpgRFaNL0iy/u6oQroOhjcjj9bnO3W5mEaBRfz1JDdmy
         ieikohLWksrtm4OmuZ+i74sHXacWN8FtOQdURnLiMKxb+NriotWxCKt3cUcvkG8vOmVh
         0Qmq8/ZFY2mq5bd/qof58bj/4jZmTzbVAGPpLweTMTveXXLaMkaTpMdZxsxva3nBuB8n
         9mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734734; x=1726339534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caFpZnX0D2laxG9sbBS2ux7cswRR1JlGkryvwZOpG1s=;
        b=HWQJagRwzSgRMHVjhlh18GVULPTuh0u+NVGx8YYpKEYO4B+hthSW1orL9Fxs9bL7i3
         Iw7+T/1JJoMg6YZ+6S5ojs0Cep0FQncrhqa2zwF+bjM4XnaKfmubWrQUy/F75d7h55d1
         t9qxEqHcVNTI/jOwN7mdv2HJfkvpf4fc/qfINWMgDjjGNlSGybtcgrRA/7RSCQDDrPc7
         4n5D16H3oMQLd4N9SjALWyHPIYD/Cf4ROztiMC8M198Rbe99Gaia4IrFXArn2fBpOdU1
         iCymz/ZosiHXAsYjzwenLQpSbCChK+mOJF64K3cih2GXScJHJ7VVMftvlK9YnTYySR8M
         t/gA==
X-Forwarded-Encrypted: i=1; AJvYcCWBO2M8pELgCQMY7tJuzbkVhd3JeGkktllJ9B+a8rm2ObCmlYmE0V4Rk2uagO87N+DxlvoYIHgLkNoshbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhte49mlStG6OcjYwRHdVFCUarC9jMum9lmm49VBv0xJDaqFVm
	K6iszYHNHgng9w2f9SbBeu2aoJCdjSpqWmtf6CZOXBt5nQrdjglveiROhKBP
X-Google-Smtp-Source: AGHT+IFogc9X5fEtz1AHjsDPBJ7GZUVRzli3sxR7SoXTiWu5ae1V41i/NgRWJ7atX8jVMg6zrDWJ6Q==
X-Received: by 2002:a05:6a00:b42:b0:718:9625:cca0 with SMTP id d2e1a72fcca58-718d5e16521mr9117985b3a.7.1725734733855;
        Sat, 07 Sep 2024 11:45:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ab18bfsm1111239a12.88.2024.09.07.11.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:45:33 -0700 (PDT)
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
Subject: [PATCHv4 net-next 2/8] net: ibm: emac: use devm for of_iomap
Date: Sat,  7 Sep 2024 11:45:22 -0700
Message-ID: <20240907184528.8399-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907184528.8399-1-rosenp@gmail.com>
References: <20240907184528.8399-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing manual iounmap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 895949eee0b0..e06fcd920f9f 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3084,9 +3084,9 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Map EMAC regs */
 	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = of_iomap(np, 0);
-	if (dev->emacp == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
+	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
+	if (!dev->emacp) {
+		dev_err(&ofdev->dev, "can't map device registers");
 		err = -ENOMEM;
 		goto err_irq_unmap;
 	}
@@ -3097,7 +3097,7 @@ static int emac_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "%pOF: Timeout waiting for dependent devices\n", np);
 		/*  display more info about what's missing ? */
-		goto err_reg_unmap;
+		goto err_irq_unmap;
 	}
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
@@ -3230,8 +3230,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_reg_unmap:
-	iounmap(dev->emacp);
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
@@ -3276,8 +3274,6 @@ static void emac_remove(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
 
-	iounmap(dev->emacp);
-
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
 }
-- 
2.46.0


