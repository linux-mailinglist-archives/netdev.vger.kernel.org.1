Return-Path: <netdev+bounces-232162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE8C01F2C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C51584EF52C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F8332907;
	Thu, 23 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3os3AM/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E47326D42
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231548; cv=none; b=NFlp45lQNtTfkmbgGTM6K7HTBY6kNM3zJyKQW53M58HMdcY1/eHAqBlpIb9s6uNuTpjmP4/OGLTFUaCeP3pkHJ1kBVSCj7jpjRK7HVXJJcJyd1PN0AZNW0wj2HohAgeDrHu/2I2uGAhI+h5yClzs1EuodCymdCISAt3vkXE9uR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231548; c=relaxed/simple;
	bh=K1TU1UHrq0DQiKTAOIZPJwfZQj5ABx8dAaTeOx2uq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSfQX3ryZq3Gan9CURRM9IPmT2wpBmGASCUnsxXrkpAGIpEDHPR9bCDj+/E+KIOOgf3nkslzEnC8ulbLaK/n2nBcMn1ld4c2t0UMMuqOfKWP+K1Odvv54opCyt3XjXIKciTwnuyxegeY06F30FMbV6wIAXEe3dUm6Y71puwufEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3os3AM/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47106fc51faso13273535e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231545; x=1761836345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=U3os3AM/c7KCovM3fO3wxDkrNRY1L8K+80gKfW5YvQC9QiuFM/83Upni10mad+Ybrn
         ZR9/dtIUV6oy6iHox7b5uPH69iwhVP22o3qS/d1YfZzlUBpiS/MGMdoJ3ehZyHa9kyw+
         Tz6FRKXqfq0y17TVFy5Qeqsday8qQUCMjpCmylnPNzl4rlw7SBY497yVLnErZIYIwdal
         9W+k00dESccvCtP4iyrA5Fo9qdBBqxxx29NN/lG0rOLTOroEiZjgKJGHG7d3UDOJezWP
         lAPjaWtBHoQCBrXPMgAbX4lLO+228JNLGNFopCUstDTK1fJihGGsZA6OncO1Ge4HorCa
         d4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231545; x=1761836345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=iT4VZIchlcVVRrFcJM+P3UmMaquFiW1NyuMuaoEtLC8ISSS2L22txKlRdKZu9yvYon
         PWXTV705/h93KLsRlJbd08iTfKY/oZ0330dwygNEFXlAzj/DBbz5akAJxkImmjU2l3gD
         uveAvlVS9eMvEAfmYIEurvZ23/SaXaaKpwTriFMQNPbJ8q9B8J/Jm33MeMVa74ne1X2p
         xwesSiCGnmsZUK/pPxdgKnqCNkeIe1hqp7H/y+z7kjhLU/IOO8MGsCIFW8MRGVPfE3c1
         Px8M7BEInINrPQTbf+scX41GqxK4c9H7clniYmBTimwChQiKzuTAiLyminT94sVguvTB
         Ss3g==
X-Forwarded-Encrypted: i=1; AJvYcCWO2O2fKvDs/NCsDrUXmHS2HC/PElT9Lb4w0IvhydPRU5mBEcQBq0DSHNZVuqc/b2F+3lvMSzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfQxfztNHRVgaCvs0y7fZXxD9kcC1UOcclNXC+HLgrMvef+fa
	83BkOIACno33HgHfAS4+naSAi9tmtELSMcIO4/RWtPcWzjDqdQfBw7Ku
X-Gm-Gg: ASbGnctiaH338OYACXIsfxEQc2o5zXhtJu8ppAOy0+hBR95QPHml70l2MttvNbnham2
	SpZlY3h/N6GeQRtwHxiA9DBoVHf2NGDHxMIaUwgj9jJTlv0zQsYDb1CSroUpKOJiKyi+vBYlhKU
	GiMRUNmmQBa5zeizK8zOgDTqY5jDS4ivw4utzz1YjQEImVDzvwhO5VUjOuwmJHSqRjyB+8nvdkW
	WJY7WyCvFcvGBFZj3bv+vRdgcRY09t8l7yigqivNZSWPhvbStOKeCn7IRhNI9kvLPfdl4BEam8m
	3kh6h8FmSSlGTnRujCn4wnsM9pqNdNNsXyq6VNejNlNux084V94Q8DLXkKjmOBGJqgEa3Iowd8D
	CeJRKRbDywpc73S/F6PNBiwUIkAgtXH6L32zwIJprrpNClVI2VxwqfK2FvtYuvU2Y80IFJZKkCn
	k417pJVXYwbeEyMuZ21y4ujXxp8QHsrw==
X-Google-Smtp-Source: AGHT+IGQzECuos+RCLjKO2dAeV8045JWlHC0U32i9kQFj54vECVk7KXnDT+AfzmBCj2mf9NTLyFiIg==
X-Received: by 2002:a05:600c:3494:b0:46e:4744:add7 with SMTP id 5b1f17b1804b1-47117870715mr200630635e9.7.1761231545275;
        Thu, 23 Oct 2025 07:59:05 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-475cae9f292sm39822325e9.5.2025.10.23.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:59:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 1/2] net: airoha: use device_set_node helper to setup GDM node
Date: Thu, 23 Oct 2025 16:58:48 +0200
Message-ID: <20251023145850.28459-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023145850.28459-1-ansuelsmth@gmail.com>
References: <20251023145850.28459-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use device_set_node helper to setup GDM node instead of manually setting
the dev.of_node to also fill the fwnode entry.

This is to address some API that use fwnode instead of of_node (for
example phylink_create)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8483ea02603e..ce6d13b10e27 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2904,7 +2904,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
 	dev->vlan_features = dev->hw_features;
-	dev->dev.of_node = np;
+	device_set_node(&dev->dev, of_fwnode_handle(np));
 	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
-- 
2.51.0


