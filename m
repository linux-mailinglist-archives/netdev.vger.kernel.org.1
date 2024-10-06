Return-Path: <netdev+bounces-132451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4884A991C12
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F53B2211D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD1173336;
	Sun,  6 Oct 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj71HrSy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE161714B3;
	Sun,  6 Oct 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181736; cv=none; b=gphVhDujWrqHCvfZJ6VfYAdNLV7T1Vu4ZA3RgXot35PoybyI1vPEovxsGqm8DqKbLV4ctJbsrFW2VrLEBb/0xp4vNbdvFGIiTXqAsJBUFLrzlDy9xeT0NtxHShvUv9pzPMqbSRqeGQaPtXKurCfIXqdDkK2nJpX1BRmF8YPksb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181736; c=relaxed/simple;
	bh=/cSmNYS6svmoBzDEWOXGBTlXUAGxIIXjQhNn2B2N0g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czZlSkV5e/7NU57LQ8nTNz0mVJ1ZC1mLH01JdH8lHSDPjKKssOf8/kALrP/65eLUK8h1qLeJZs9vHRp8yXN2F4x89YakV4dD3an3zpA/dH/YFh9DxC31xHK7I4XkFXxwOWrf5X+j+mFJyZXyEPhoabe0RO1wP7Lqu3XhOaeZ9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj71HrSy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so75022a12.0;
        Sat, 05 Oct 2024 19:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181734; x=1728786534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZMKp6EdgP+kd80Kbn0C8MSGwrx0pm3qzbGcN5gpVOM=;
        b=Lj71HrSy+TajlJDjLtoC5Rn0PGMS2iKkhP8YfuXxnoSJSA1tbPBZBNLLADlfpobvVa
         O88Oz5wL3DmO/pUuXrGAY32ttsmle2nGHlzlZXlhHDmhtBmcrXr0yqqQC7R+MLTwY52x
         p2lScyE12+qwJSNy6qV3UPklgP4yEGfvDa8Oi6BRDzdJF2cwOP2PXv9i08JozNbrSc2f
         KGK26oR/72Da0v0h1rzmE+Uc3Fad/sBWY7OD1yWII/se3jr3vscwJBdZIUHtUQn2W306
         hrGfMIQrXEMwgYialUIwXhorMgbZWtsln+sGMsnbPgHwYrd+VQF67Ln8Wjm/iijbjy7f
         IPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181734; x=1728786534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZMKp6EdgP+kd80Kbn0C8MSGwrx0pm3qzbGcN5gpVOM=;
        b=HrJGTFDQ+OgfmoAlWaAF3effDcsmfc2rnIwWIh1ezdWCBhMin4/Pt4sMARxX6XJq7N
         JbPfTEv/SSAyHmyHPd5dXr84NU59GRIMCxacaFqc7EP/n2o4su28Odch68O33eO//N7M
         ud0T4XkKDjLelCV77hfJr/ukO5XcjNOEQ5DMhCQHc+LVU3I43LZ68VhEJu6rWfNIsbel
         pkdoL+EzQK7rqtGVOA0wiE7D7ppvx0DwbzCA8ZDuzMhEu9mOAqaI41n6copcD9MnJAA+
         fs0AmI1eN5xZEBDw92gAhmiqPzXxF6y4qGxHfHUZ/iDrENbt0gxkQsPTf/wi4AYkUrfI
         K+PA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCyQVigDSP9n7tuyjWrpxdMGL1RBq+yKNIfhsOTd3/EA9Q5DaKH91fVP43QUnkUxIqXSlfA3AJ9ssUz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkT0RrH8iFyXJeyIAI0UN+o5XZodQwdzSrfAN//EAv2HzUVMb
	PPnAeg7GmIo/8rBWsiNklNYekjvmATDTaHBLQfelQhoebGy554IdyEc3sQ==
X-Google-Smtp-Source: AGHT+IGfNBLRL0S1yfRCd/wzLRD22Pu451gWjQMiWrNTkqQBp9rSFdLMd5DYhqzy+XAysPHGILntjg==
X-Received: by 2002:a05:6a20:d521:b0:1d2:e8f6:fd4 with SMTP id adf61e73a8af0-1d6dfa476b7mr11267759637.27.1728181733778;
        Sat, 05 Oct 2024 19:28:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:53 -0700 (PDT)
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
Subject: [PATCH net-next 05/14] net: ibm: emac: rgmii: use devm for mutex_init
Date: Sat,  5 Oct 2024 19:28:35 -0700
Message-ID: <20241006022844.1041039-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 8c646a5e5c56..c2d6db2e1d2d 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -219,13 +219,17 @@ static int rgmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 
 	if (of_address_to_resource(np, 0, &regs)) {
-- 
2.46.2


