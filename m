Return-Path: <netdev+bounces-131454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1E98E858
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B3E1F21B1E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52705145B0F;
	Thu,  3 Oct 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnsOAvEi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513913F43B;
	Thu,  3 Oct 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921521; cv=none; b=cRsTy/PS6SzGQCI7uYecVRT9qKxPXTEmSlpq6Z4DuUegzDRm+wyLcJsKC0/yKXLi0Pd3rQD3m8C6VhVPf7eBL7+2WN/Vr3CtFE+3nBxKIiL2Naz+xyMogK5Ghgn1st0lXe5mKRs9K3P3iiAVvPcKsf56CDK8hyR21Of9wiYiu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921521; c=relaxed/simple;
	bh=eKiO/LEIBXXwlQ4KH7qVz+fyrkTR0L1Ipshtf4VGCgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSh1qwEpk3IT6cM4s0kJ5rcyQ1UvFMVJpOsXSoWkGys6ZIUOwnhjO0mbynPab1xCzvRWXZsvwvZcAkH4rbDnOpBvCXL+bDC8Mh95NuIbqwIEJhRzgPnL25pu9u0Hp/GWR//2OCE9SNBlV/ePcPdJvDXsDC1P7ee84x/tMCgmSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnsOAvEi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71db62281aeso359162b3a.0;
        Wed, 02 Oct 2024 19:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921519; x=1728526319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=NnsOAvEi+JNt1kidodFV6XIMveCOcaEgetRDVeH3pOBtMWnCBGCVKhTLOjsKNRC/vC
         t+HBmjzwh7Y326RbO8dKQE61EhriRFb5PnUrBNfPw+3RovtBzamkH5Muv9iBOUq5PBTh
         G2SGaVX0fb9RFDb9OICeGR/9KMivUHpH3Fm7RUCMdHaoSsEQdTlEdIG/2jP/RDz4MNpy
         ARjapVH8NhCr6Juwagop5+iAbjYqkA5CBcBEkWcjlicrmBrayEKjPmGWD1rj4RY2vQw4
         F+YBKg2t5wE8wq37LCwLGNX1/Ez6TzCZ/kFp1b4d8nByC+g5fjlOKABRU2PVf+vPfTk6
         d5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921519; x=1728526319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=YCWZ8MA4b8lgUVIW/3ieJi7OW4+eW/vCmEgEsGfeE2ILxdFfckT28Qx1P6CxQG/iRj
         8F6QMoqwne65vNFxKaZL3CrIlxW/5VXJqwleqJUu+s8s6Nm8ys+n8W4xaEFyFVo2isDZ
         GMsaoZE1s+kZAowrteNMsLCOG9Vzqo/1vWq0Q+4PpXLfiyWO6TN1XivgQceVAaWY8E6R
         CO8YmpGHmUX6FgTPEGL76Y6HaoeP/C92BwhYQhg0EcC77YUEd1hqyXOPuYobn98rJKLF
         BtvyP95eVMsFoV2fiPZrbN10Fdquvb3wLVAN3jHG8W8YqdQTDXp/r8+q3yWVPjG18wf2
         9sZg==
X-Forwarded-Encrypted: i=1; AJvYcCXAbZ/0xOOTmWC5lwNrat5I91oMnjV8a7pnZXcJSSyZE4Q8bmUJoO1cfydZN64ADjL0WUsnwoyckEhJyi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2j8YXdv4temmHROk1irqXIJTjaLeF+p1No3K0CdjWF4rK0J5
	vWT0LGUgwxCNlKokdmXPWvFnwy+t3E33qhEXQ7Wa6fLk3QmVdDyQeqSrRV9H
X-Google-Smtp-Source: AGHT+IHdFDAnWJyuNqtdEN+Sl0V0X4v17yo5GpnvTbubn1kty4hisPgzI3zlijnZbApS427Npn6yDg==
X-Received: by 2002:a05:6a00:3908:b0:717:8a98:8169 with SMTP id d2e1a72fcca58-71dd5ae58b0mr2448519b3a.1.1727921518968;
        Wed, 02 Oct 2024 19:11:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:58 -0700 (PDT)
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
Subject: [PATCH net-next v3 15/17] net: ibm: emac: mal: move irq maps down
Date: Wed,  2 Oct 2024 19:11:33 -0700
Message-ID: <20241003021135.1952928-16-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
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


