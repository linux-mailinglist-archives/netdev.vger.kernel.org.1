Return-Path: <netdev+bounces-132460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE1991C23
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF31F20C82
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B49417E44F;
	Sun,  6 Oct 2024 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPHPPbGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2217ADEE;
	Sun,  6 Oct 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181750; cv=none; b=GbLtPoY4F2kQF9KyMB09LYlVc9LQgWb9r1A37RFS/L1BL3VyofuDow3wi3HUdmW7Ozo4CXZlvOC/3msm2D+0OL30mRW2whIyMsR664UykMEIy0h+Cjij0Rqgw2p+LcYL3FDj3drD90siJu+JuaWsfP4DeNzIVD37JTUntdONDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181750; c=relaxed/simple;
	bh=eKiO/LEIBXXwlQ4KH7qVz+fyrkTR0L1Ipshtf4VGCgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrcntI8YtfcwY0sLOfqeCU1HLxdft/Til9Lx0tFVghkYcH+KuxXaRGHvLHqn28R2rG3Z9OqcyC3RKW/1dnwojQCZmqGhlArl8AXeS+NNYZeD+oft8noLN7GWZz9A+fp5/m+J+xQA+fJ1a/kDiTnJwkMxQkO+27ByFkH1P7wzVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPHPPbGh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so813218a12.3;
        Sat, 05 Oct 2024 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181744; x=1728786544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=CPHPPbGhsZqpRyLC3uRvKeTBVAt9ma1gkPZtrf6spfrNpZc4m10cBKv7oY0ju/7XkC
         QfZChvGCGPdxNR4FPhyeGNPC9h+/fAsbS4HS5SavBi8qPJkhI+el2acI6yWOCsJfzcrq
         YIiMuHdiGS9Te7tU5fV0BFg5hjm+vJ+aNj6nAWQDYBiLr+VHARJPDwtXLedB3XGpzv4E
         xl3hnjuydwe7PLoDhwfNWs5QzmnjxdT5oQyvVdTXRead1WcqXC2RUyo9wo1VpyvjMS9t
         pnOLgT8FbrV8KP9rA5A3Q/YgdfwAi+YaxJG6HUyxL+kg45uakhdVmAxtRNd1V1XvHt9I
         XS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181744; x=1728786544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=DNadMo93YRE/iqhc01J0ee2Cvqp4vAwvVciu4eAY+DghdOwJZD8HrS21AJ/KdnaKXN
         De8xI945kjuVy9s9NAVLflNbV9wQFSVEB/icSMG16OnpLEoWzew47p2WejTvejjwnqpU
         7huWY04euFcREM3yDcC3tlvgw26vX+1ZXCCLDFRta0zLGicCFwPZMrCohAE1QyKnsvuv
         I8F4HGtA4AwUjPa6dcmY8mD/Dz5HQ+ATiDPNap8t3U17mMQyl9OBHGyJkLaQ2eW9stdi
         3lByOXlXFSrmcbhEYFGYgg2PEmgnQM708mULUezqk/XVQtsoerPgk7DKM2mP9468gIOI
         gtTg==
X-Forwarded-Encrypted: i=1; AJvYcCUiaVZItzDzHHhjO8/td7KeQii9m9NoCux1BCrDzQNtCUL/D18tJn1QCJurj7mNGNzVG4PM/t+c5p4j4Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRqmrnWiJ1fwAlqBHSypQyzjMmvsLUBQTzCWpKFoY+vP+zPBz
	/8NtxVb2M5m00gQeV4CL0hsHITofRqIhAP7s9reTN74KBL8j2M5voUkvVg==
X-Google-Smtp-Source: AGHT+IHW3pdoO8XP4rbV/wB6frVIzxNVvG3SLixBgS5he01rdeXVTckME/MXmCnJJ5Oy8oqpJKkG0A==
X-Received: by 2002:a05:6a21:9187:b0:1d3:eb6:c79b with SMTP id adf61e73a8af0-1d6dfa231cfmr14360117637.9.1728181744411;
        Sat, 05 Oct 2024 19:29:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:29:04 -0700 (PDT)
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
Subject: [PATCH net-next 12/14] net: ibm: emac: mal: move irq maps down
Date: Sat,  5 Oct 2024 19:28:42 -0700
Message-ID: <20241006022844.1041039-13-rosenp@gmail.com>
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

Moves the handling right before they are used and allows merging a
branch.

Also get rid of the error handling as devm_request_irq can handle that.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index b07b2e0ce478..3fae1f0ec020 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -578,25 +578,6 @@ static int mal_probe(struct platform_device *ofdev)
 #endif
 	}
 
-	mal->txeob_irq = platform_get_irq(ofdev, 0);
-	mal->rxeob_irq = platform_get_irq(ofdev, 1);
-	mal->serr_irq = platform_get_irq(ofdev, 2);
-
-	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
-		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
-	} else {
-		mal->txde_irq = platform_get_irq(ofdev, 3);
-		mal->rxde_irq = platform_get_irq(ofdev, 4);
-	}
-
-	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0 ||
-	    mal->txde_irq < 0 || mal->rxde_irq < 0) {
-		printk(KERN_ERR
-		       "mal%d: failed to map interrupts !\n", index);
-		err = -ENODEV;
-		goto fail_unmap;
-	}
-
 	INIT_LIST_HEAD(&mal->poll_list);
 	INIT_LIST_HEAD(&mal->list);
 	spin_lock_init(&mal->lock);
@@ -650,10 +631,17 @@ static int mal_probe(struct platform_device *ofdev)
 			     sizeof(struct mal_descriptor) *
 			     mal_rx_bd_offset(mal, i));
 
+	mal->txeob_irq = platform_get_irq(ofdev, 0);
+	mal->rxeob_irq = platform_get_irq(ofdev, 1);
+	mal->serr_irq = platform_get_irq(ofdev, 2);
+
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
+		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
 		irqflags = IRQF_SHARED;
 		hdlr_serr = hdlr_txde = hdlr_rxde = mal_int;
 	} else {
+		mal->txde_irq = platform_get_irq(ofdev, 3);
+		mal->rxde_irq = platform_get_irq(ofdev, 4);
 		irqflags = 0;
 		hdlr_serr = mal_serr;
 		hdlr_txde = mal_txde;
-- 
2.46.2


