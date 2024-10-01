Return-Path: <netdev+bounces-131059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0205C98C730
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FE01C213BF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7051D0940;
	Tue,  1 Oct 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC9NU5Rz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CE1D0795;
	Tue,  1 Oct 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816350; cv=none; b=YOhkylZKbYfaWdV8zCIkGt91fSpT+quwLY0UQn7RTScla9c2+1xvYjnpXBKNVD5/aP49UZSZZS6JVaKC7i+sfHnsoPkNc3d6lPb3rJeFs5kb8QnYJIjIeD8bzoOc79MMSUHkJZc/K7jDswNGqCMl2mu5iRfKCHJJB550gNgmGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816350; c=relaxed/simple;
	bh=eKiO/LEIBXXwlQ4KH7qVz+fyrkTR0L1Ipshtf4VGCgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNtBUF1iaEQVlOazmGDjBbB9cU6ni5CjcNpCLLBBR/E8nGEj7BsdmrRxm838FxyfeLlUDOnWHT98g+5pFjOWZdn04cXB0DXsDvICzS/7GV3+RIJ8zH3gyXijfE6e/fIHqcTavLYxdOVGnhBEVKXONastOMxZt1jM1jrrKWABWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZC9NU5Rz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71b20ffd809so4528775b3a.0;
        Tue, 01 Oct 2024 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816348; x=1728421148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=ZC9NU5Rzy5qyEZIVpJ9tT3lOfsTX4H+dZ/aYYe3AB9eyoagKVSaS8MoZzVBnxCkMtC
         h3b9+sx/K2oFkBBgdb9brkj4AcJtOjEXPkm94gjMiBdlwllDML1fsocVV+nVNIdhEKPd
         C4LftyTTw5qErRslT8W3OMmT/pz/NGvMYbwYxBwlMP6R707strFiMbzjgRJXWZYrvSoW
         W7u1z67pe5dX1VEyXYT7nKdoXkFc47kkZTzF0btaqCG1wlq/QQgLpFUFzy37HKlIaqsk
         Mzao3sjC86rbM3/Y2EyIJPwRKF19PbOLN5fo3/Ceb2WR+urnNe/oNTtVyBoFawRp9NHX
         qOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816348; x=1728421148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq4R22bB9X5Y2tGuUBetWh4QBzSEUK/HudSJSZz34VU=;
        b=IbWs+02U8tr7qC68fzTb4sHlr+nXVJf8jpP+P2Yk6fXkxsqgDXVmiTKDFZ4POh6mrz
         7eKdu11hkJZdUB8fS21bV5dHnX2Y2oWAsOf/G+Yd/kOJ6XajrOpJmdOlmw+GxC/CUL0X
         SM5zPuAM8NlW/mfLm82G2PeozX5y8rttN7SHjwph/tp1SltJcIqWKJLgBTQiS+DJJIOf
         exZgJb19d7wBDt68VjOMJn7E8ZqbKHfuS60C/Hm8cPx7nAHTc972pfpDDuuEkHxxVt6Q
         CAC0dTwE+jh2QCuGXs+7Mp0DED717HMr1/lcQFB8p6tsqu9vv2tA3FZkqOWv4mxVA6Dd
         fApA==
X-Forwarded-Encrypted: i=1; AJvYcCUlYJMYwQkwdGkjUIsLD68CKvIc7NBOYZq0o16VSzfwZk1wojv6ZavvnY6v2bmHYJSUN+tpHq59kkHwaPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkW6hyXnSu4SpTIE5HXgxbMQEl7d+99XgfT7OsRGf5EU16wsAQ
	hfNp1LBdvwhokSh0HcMAyL0OEhnPimimfNHBm1uDcZzeo/p+noxdY+CWhLJZ
X-Google-Smtp-Source: AGHT+IEciGVV/hoMrTmiuBt8dbyqzKLSexLbyVJuiGff+aDP4NS5+mdQCI1Bx+jJ/eCycGK2j6AagQ==
X-Received: by 2002:a05:6a00:178c:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-71dc5c67164mr1214460b3a.11.1727816348240;
        Tue, 01 Oct 2024 13:59:08 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:59:07 -0700 (PDT)
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
Subject: [PATCHv2 net-next 15/18] net: ibm: emac: mal: move irq maps down
Date: Tue,  1 Oct 2024 13:58:41 -0700
Message-ID: <20241001205844.306821-16-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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


