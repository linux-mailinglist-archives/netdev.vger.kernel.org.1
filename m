Return-Path: <netdev+bounces-149806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430C9E78D7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9051281B9C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D520456E;
	Fri,  6 Dec 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="HoMz1uQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BD1D90B1
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512910; cv=none; b=G95GAdv1i7jixr8m5GPgBdmgYlKc3jOgcH+HGZrrwxrk079I71SCJevzaW9FxrXGLifc0YmM4H7nQjB2+kSI3ZhySxj0xzvKD3fNJniiQgb1OfCsoLRrYBgX6SKHSRI3seHs+WWmASSd+oGtd6GDiqMi2kze2ZXzSWIooyfExlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512910; c=relaxed/simple;
	bh=J1wLyzO5W9j22me9P5kEa5FIRVr4K39X5lpjOH5Mlbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aM3PjHlh9BiOy1P8KefS20wTm7YQGUaU9MmmAmxunJ7IaiaVgBCopOrZK7Gt/H/VLx65U9Ix9SmElZB6CwN4VYNKPDLJLDI4iL40xpxRt2Q1aIB7Qo1YAYCivOzBeGmTMzt1JXnlQY1TFH8DCTQtJVPllwqMqesq65QplyCi+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=HoMz1uQ8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e3a227b82so203311e87.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512907; x=1734117707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5NOSdyB6WjlvcQgCrw9n8rSk8sPjoBbSdt8losq+os=;
        b=HoMz1uQ8dmjv2njQLXj0xHIWahsuG4ZfnHU9zCMi+mg+1UDUQu94d2VgY6MEkEiDwm
         ccMZgIs+phJjBaOrko6woeeHf0jpmObFuNDwHO0/0fpQ/9DOrryHdI02FDBG0AA5pcML
         r1ib01AqBxZtq4r0oh7SUFuk7DDL569VyVgFQNi9Sz1NWBfJnT6xhWnm0IqGos515utW
         GKVUNFlN8TZFamKbVlodfCd71nTIdd+5VTUskh99tb400OWVuff5MEiJgKNHnQyhBmB3
         HCxtpdKk6XmPYsR7g4Vq4cx4+/bD+41ewp9Egl7FyGZLHy9WpBeGLx1DUhKlY+6prRYX
         +hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512907; x=1734117707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5NOSdyB6WjlvcQgCrw9n8rSk8sPjoBbSdt8losq+os=;
        b=b2q28tzdmbp+b1YvWRJDK4lydOC1SZ72flFRhjSkHGZTwRT2ySppNIZzO5Ald5OCHL
         hloexCQXL2atWvGexIaRdLfOUnsDReSTOY1NzcIZYWSZODq0P6Pn4jqefk345UAihpVT
         IovoTpMSpD0tkSzC5FOXZ/hY/jUrH+lIck8b6sJYX1tgmG1jesNx3u4IrDHsKb72+K4O
         iZRjGE1FWaiL3AS2lGn/kec5zlBG0BkQMmzmRV8wsRF2n96oTc+t3eaNcus+IFEJ6bft
         4ruo7PevtYzmJFFfQ7iYAPSYvkwaP1tTa27yM4eqwKYzxDuuz7orNuJB867/fPu4oSv3
         j6Rg==
X-Gm-Message-State: AOJu0YyE7BVg4VTDqv2+opxI9EVRfvyE4IXmXISt91hIfUJeyI3LHQVI
	FfxSHFJ0ay/2x+N7MQZcF8t6VKBoaK8zO4HNHcf3tIuCoASgRdPaSJEcvNkQHck=
X-Gm-Gg: ASbGncv0Zu09J7ejq3Ayfi6iM4DMV5NYao+p6LFuOQ4tqCXs1xcCW8pDe1pT2MqiICr
	UWsfLFaMXACHfoaeDyyvOouodHeft6yOKhEHg+6aWd85wqoIK02cZs7Umlva7z9HMjkSVVWTi/S
	fl1dJa3JjjjYyS+PyeibERutoI5k4hZtqO1U9dLeqqFNzefri8DJe29nkgGtg0Ka/KBc51xkc1N
	4TmuqPr6gcTYZEuxTtli2+hl8vLbVIFLNDGkMtRMHs7KRRtVKDeAcqNGZe5N5gE
X-Google-Smtp-Source: AGHT+IEkrNNKRE22p/N7Vgw2gN9RWXvT2Tt4dnHwGRo3syIX1cQ2Ucr9kBvwLbKypCn8l/wN+oLarw==
X-Received: by 2002:a05:6512:2812:b0:53e:3729:eaf7 with SMTP id 2adb3069b0e04-53e3729ee24mr1674109e87.34.1733512907374;
        Fri, 06 Dec 2024 11:21:47 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22974f20sm590041e87.70.2024.12.06.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:21:47 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 2/2] net: renesas: rswitch: remove speed from gwca structure
Date: Sat,  7 Dec 2024 00:21:40 +0500
Message-Id: <20241206192140.1714-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192140.1714-1-nikita.yoush@cogentembedded.com>
References: <20241206192140.1714-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field is set but never used.

GWCA is rswitch CPU interface module which connects rswitch to the
host over AXI bus. Speed of the switch ports is not anyhow related to
GWCA operation.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ---
 drivers/net/ethernet/renesas/rswitch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index cba80ccc3ce2..8ac6ef532c6a 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1902,9 +1902,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	if (err < 0)
 		goto out_get_params;
 
-	if (rdev->priv->gwca.speed < rdev->etha->speed)
-		rdev->priv->gwca.speed = rdev->etha->speed;
-
 	err = rswitch_rxdmac_alloc(ndev);
 	if (err < 0)
 		goto out_rxdmac;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 72e3ff596d31..303883369b94 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -993,7 +993,6 @@ struct rswitch_gwca {
 	DECLARE_BITMAP(used, RSWITCH_MAX_NUM_QUEUES);
 	u32 tx_irq_bits[RSWITCH_NUM_IRQ_REGS];
 	u32 rx_irq_bits[RSWITCH_NUM_IRQ_REGS];
-	int speed;
 };
 
 #define NUM_QUEUES_PER_NDEV	2
-- 
2.39.5


