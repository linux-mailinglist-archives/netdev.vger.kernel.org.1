Return-Path: <netdev+bounces-131069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCC98C785
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B124A1F25023
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793411CF2BE;
	Tue,  1 Oct 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDnSgdlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B61CF28A;
	Tue,  1 Oct 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817733; cv=none; b=kK3afjzDs9m2Wibn1ll9c3Hkj6sTBEWsVzaKGNbEvZNMKNCjVmTgw4A7BVSQZDGqmOZ+F3wT9nOvpATjafyMZkVGREHxBbXFf/F55xLvxrt2zUvVlhRMDA5nqTU6ZFwsk7zSIiLWuBsuinbut9vGCWT9dlz8ZI1aZL91fbcajCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817733; c=relaxed/simple;
	bh=Fi+ECuYMHlGLDL8STuDo19b4YsDm6goZ0VDI8gcOZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpq+E0MsYsumPO/wuw3DuP6kLuXuQ5D367PlNbEFLTXfvSBXLnbkbuzeiu3H9RY8ujdV2MO7yNSbMFj+FLoAl7RJHKVo9RxNCS+yxHIlNL5PValJj3fwXXksIHXfyLDMJKu5QPLgrMaH/m0R4aI0cOIM3SVqTvhAxGbIa1rWuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDnSgdlm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20bc2970df5so5326055ad.3;
        Tue, 01 Oct 2024 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727817731; x=1728422531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oefF03u0ufsPVzfuPqkdhg2BxRUbFBRgPpQWx4Hepeo=;
        b=cDnSgdlmJvzGjUDuHkatbgx/H8yf9TcWwSXbW1yLdXhwgysi3WViyhG7kCLuWVivLT
         qrxbMfR8sR5OxtKbP+cqtRnKAwpOPc5ZS8+9dqsVxS7pkfh3JUcFdZUwpfCTsR4Jsv/m
         1JQd0OGucBKo4nbcsqjero4reFWFp9CVTWLuh2ClvTo+q/dWeXc4x31kZayHOA7zRukG
         BsJT7I90QdA2hA0qyt1aVd6uoXIjgNfwLf9mvfiXfYQj8ihV+ETNbdQM/zIPo8nJLTtR
         A4VfE2jc6dHGoixQSr3ESK6V+ZHF1dpuHpELPiE9NpwsfKqLr/gkfM94/41b00/BhD0f
         kHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817731; x=1728422531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oefF03u0ufsPVzfuPqkdhg2BxRUbFBRgPpQWx4Hepeo=;
        b=NtEDnratiNqzZHgvb7pTE1ypvi+TvLi1NRksmNu8ccX2Ed8K4mJXsRNeKKd08sV7Vn
         ixBXViJaEm6h/DjewwtiGfRACcq3ed0XswymyAJ0j5W8tG9VkBqhJaP1EKeqzfwPg6EY
         1gw6tLfw85O7Nw5r+YLINPnlHa5M5nVr9JHBz9Ig9Q81wGwhQ90mDYrSSvxFsdSsFMO7
         cqfo7t+f+GSr2toXgGvL7P9Lo9fzTqE2gLXSPsPcQNyMFYuDPn769XS3DZ2XwNCX9WDx
         0i1B1gnqKxxEw9d7mOIZYY68D6/LFIk9ycqt6ju1ZrMZhffOisx8Fa5ghe2Vhkgi0J8/
         B9jg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsBlOi5T2anUIMEtb4qoLpx4oIIdZ4/w6TqMkC7SPQZt1jLEhQyOFFq2pV9ZLhekQYgOpiwBlIys2ato=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGPa1PBE3CTXaz5RLbu0TKYJ6u6APDibF6/HvZuc/Jpw86R1fQ
	qrRNyog5ajJeYT5+XuBZAS3xKpA+AXhI4mym32xP2/woMybWpAnkjJVyUgMZ
X-Google-Smtp-Source: AGHT+IHaphqiFkMaYdlPMI+fw+y+7TMDwH76R8Gof4MQ+OL6pIBsTof5KGkAADt+gcw0if6tN2fT/g==
X-Received: by 2002:a17:90b:3a85:b0:2c9:df1c:4a58 with SMTP id 98e67ed59e1d1-2e1846a6a16mr1309690a91.23.1727817731284;
        Tue, 01 Oct 2024 14:22:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f8a731asm47144a91.34.2024.10.01.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:22:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	claudiu.manoil@nxp.com
Subject: [PATCH net-next 4/6] net: gianfar: use devm for register_netdev
Date: Tue,  1 Oct 2024 14:22:02 -0700
Message-ID: <20241001212204.308758-5-rosenp@gmail.com>
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

Avoids manual unregister netdev.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 66818d63cced..07936dccc389 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3272,7 +3272,7 @@ static int gfar_probe(struct platform_device *ofdev)
 	/* Carrier starts down, phylib will bring it up */
 	netif_carrier_off(dev);
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&ofdev->dev, dev);
 
 	if (err) {
 		pr_err("%s: Cannot register net device, aborting\n", dev->name);
@@ -3338,8 +3338,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 
-	unregister_netdev(priv->ndev);
-
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 
-- 
2.46.2


