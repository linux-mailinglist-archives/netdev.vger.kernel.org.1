Return-Path: <netdev+bounces-130999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980698C59C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75628B221E9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBD1CF287;
	Tue,  1 Oct 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgqkxQoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CF1CEE9C;
	Tue,  1 Oct 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808381; cv=none; b=tiuma0ip2mvJo80tzq0D4kzCK6rS1XlJwWTC3T6dutZ370q/EzLiD0lZD1YwMrr7ZO1ueLCn/eq5VHCpSjb6r7d3zyazzZKxHli6UeJjXm0h6F4GDzFASbWVYirclk2Q4pDrk7DPpmKVjSKYXHBMLwEdXVY1bWbNo67ZxCXHa7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808381; c=relaxed/simple;
	bh=fI8TqUvkenD8MKRItkOfndP9FbS6xNUBuWmVFpeuOm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AweiCpvRKNHufoz2zvHBT2iwX4Km0m8Xj5x1LKaJ6ODFMDwFZ9ZOgfQ82lbBR0ykvn3AA4x1lICgwG1OqoBRlMTb692X6e7XzXV3YlnR+ntBx+lX1pLt2Be31gjRv2RPSTDKix+eElsQurZXDbLtgEDn7WiKQFKDNBeCq8CIaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgqkxQoI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bb39d97d1so9042825ad.2;
        Tue, 01 Oct 2024 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808379; x=1728413179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psQ8za/3DIn0xibnh4ZYDayf2hGKFHVv3+R+/mtl++U=;
        b=HgqkxQoIWDU1a4xXeTE2Vg+f8alg4nich23pMQQQl7fU2jctZ0m/Ic3HyRpoqt4vms
         Q9ER9b91gXKravL8ikx8DDIJue64QADE6ZWFcACaLXLEdNRNiZHV53gAC7CFyuT4sEEd
         JFqHXg6Oqf3DPhpJ+kzjTWn/ENQsMYsmCTm+5EETIZHes7G6Dj4+YsJvnkAg/oaqzgww
         9TVHUBapwAbQqC5nFre9q4OIzXycN2uETtgylNSdiBxanfNBBmZ0W1PptNGQsSDQrEsZ
         /nJZduMKSPbIO1dlr4ZhBFQggsuUsdG80ocolSbFe23/5sy29Rb0q4WbhfMX3074IV3l
         CJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808379; x=1728413179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psQ8za/3DIn0xibnh4ZYDayf2hGKFHVv3+R+/mtl++U=;
        b=mVYuJDihCEwI/nlo/Mkm+drbuFzRrIxnImiJLvN9ftQQmUvKAnHQ0c8vOF5Wr5/Ju9
         mZVzxcttUwG+FYYOqz76PZBQ32J3Qeo5GFQx94To96bcBCJaYiA2LMmJtd5hSDPx7Pjc
         jJoLf4KwDsX+LdMpWoOackOuRETDskuQHnNof9ylXij5BcZ5Y8T8G1bQ7kcKcF4M1JdP
         5uLZJa6BPAHkTNFtLL5nVdAxPddZo3FBgQdc9lf+wK/eX8eNUu6CutZRyIOeapZwDGp5
         kMq/PyqCRCIUFoFQVQJWw9sWrR+3ktBK9ENNn8R40gGWtMpLxr/OigLu5k2Bmr5LVl2j
         ubhg==
X-Forwarded-Encrypted: i=1; AJvYcCUWOT2tSqnEjS95JV3uTUUbiXt+tK9HvZflyee2TBum4TMN3T0deP6C3hUl6R9zY+XxRBjCdM4PkKX6yxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5F2o1HUkgp43PdzV5gMHwkIvXoBybpwziVlmip/vpvjTyQJZj
	Vn6LKdWUaFi+IYT71LzJzbPfK6tIYHBWm3il9Q74ArYGlcTqhX1KCEPPoBdn
X-Google-Smtp-Source: AGHT+IFVvh93jwQmfcnfI/PtarNMVEhS9ZNmnvP7Nna1JNQ573NA8WSAMAGUgo9CZ9hJyOaNnB4Hjg==
X-Received: by 2002:a17:902:e743:b0:20b:a0ed:2455 with SMTP id d9443c01a7336-20bc59e5250mr8072405ad.20.1727808378672;
        Tue, 01 Oct 2024 11:46:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCHv2 net-next 07/10] net: lantiq_etop: remove struct resource
Date: Tue,  1 Oct 2024 11:46:04 -0700
Message-ID: <20241001184607.193461-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of this can be simplified with devm_platformn_ioremap_resource. No
need for extra code.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index bc97b189785e..3e9937c7371a 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -90,7 +90,6 @@ struct ltq_etop_priv {
 	struct net_device *netdev;
 	struct platform_device *pdev;
 	struct ltq_eth_data *pldata;
-	struct resource *res;
 
 	struct mii_bus *mii_bus;
 
@@ -620,28 +619,13 @@ ltq_etop_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ltq_etop_priv *priv;
-	struct resource *res;
 	int err;
 	int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get etop resource");
-		return -ENOENT;
-	}
-
-	res = devm_request_mem_region(&pdev->dev, res->start,
-				      resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev, "failed to request etop resource");
-		return -EBUSY;
-	}
-
-	ltq_etop_membase = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!ltq_etop_membase) {
+	ltq_etop_membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ltq_etop_membase)) {
 		dev_err(&pdev->dev, "failed to remap etop engine %d", pdev->id);
-		return -ENOMEM;
+		return PTR_ERR(ltq_etop_membase);
 	}
 
 	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
@@ -651,7 +635,6 @@ ltq_etop_probe(struct platform_device *pdev)
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
-	priv->res = res;
 	priv->pdev = pdev;
 	priv->pldata = dev_get_platdata(&pdev->dev);
 	priv->netdev = dev;
-- 
2.46.2


