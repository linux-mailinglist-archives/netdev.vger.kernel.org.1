Return-Path: <netdev+bounces-113296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0F93D96E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E76E285C96
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A0149E1A;
	Fri, 26 Jul 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UnJcUbJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D48143759
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024004; cv=none; b=gfej2DuLwyDfB6xxCINLKfuViLSQxueo+8dfaJXDGxHDhqkmsjfUivg4h6GvbjO1eIYKCBZQxdzy3tgoAV4iqTTdksxEkUrjlDQkpcNdsP4wFuholcdTuLJSEG14U1z6y1PUR1RKg8Pv0ERRH59TcclLKj9tyFKtoONeOIOskvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024004; c=relaxed/simple;
	bh=X0Lb8mIRnjkJhheZaa1C9/ChMOXWk5LNcIzDjYItBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p73zmL4OyMNMnFfZtPSMFyNzVu10tKDjoAzfoSHONqLUpGmDqf53pr9oU+kr806IE3aLyNNEiQ2HEBk0Nj8N7+TiyP4x3iz+icjze8xyQ9sjks31njbSl9QGT8cG6lYFjbbOnDvKUcDs3185DX5YQ+RADsCf4UTrgXmIhnNBMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UnJcUbJr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so6321816a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024001; x=1722628801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=UnJcUbJrDG9Cq804yVbehwjGAd++KrMBOQzz716Pwcnv2sym3XrA7RBcmayl3k23cg
         vMQhICD4s+3vEUxb9aUAyDpJrAkQVB8rdJgqUGaYZmVyjxg6W74kTpM8c/ysgNJmK2bW
         95aGCuNTw6nVqAFvvfRHF44wWPcd/ejbxP0XEDWNzYS3HrLt0s3YjajH3NPktFKkGINP
         xejpMzWqF+zG/Wdz3P8g6AoXkGdbWurp+mRQM2tRWa8Po1K3/fER+akwyvplj1C6K1qg
         5kD14gKfLDLB1JKgcfk5+CtiYDCj/++PoUAHuI7r4Dh+9hTGnwfyESrVP3WezvKWGqoI
         fgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024001; x=1722628801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=ShRSc0jcRn/O9UdoC+6zv8FfEbI+VhUE1TXt3Wroq2f88b4jt6qtmmG39iI3ptSyrw
         mG1Dt4wHzCFkdkWGoSDPo7HLim+Fp3VHd2qOdy48cHNk7PwTs1pdz7NEB0z8mlNmNNb3
         88bG5XizueJ+W81ZUEEiBK0zfeq51bDex4vbaF55XIVFXMtb16FxrUmooW2Rs4jGBstc
         jD+L5xCKLy0WpxQCUcULlqiESGBVB+DeuCFPKfRd1/nwrmsAPXowRKqRamgu58EZUQOm
         XhuypGEi1xBQQM3eRYBHMywT+ZYrXyRXGqPXTZ6M0ELQ8x9KEssuEPYN/fopvqSqNdxW
         Ugxw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Z+5u5Ry+TCXC2mUSNaSlD8pb+mxuXTIJkKdzsAbQP77UcAdsxBGgHj9304iwuNk0ypUhVrSjEtyPPsEDetM2vwR719SM
X-Gm-Message-State: AOJu0Ywrx8PtBi2bvbsNpUlEvJZspjWdfQaxJFtqDOkgsK5rFK+pbZdB
	eTNF4D5xGdoBEdqAhuMwv1F791aD6FTJDs36W2dpCOdP+V9L23v/6BLnguQxayw=
X-Google-Smtp-Source: AGHT+IGLTeby7IgSps+WCZxoecp8rEY41Qs9z/KH8R39SBVZDRYsG+VUFkY5AJGG2wUOq14cKvVarA==
X-Received: by 2002:a17:907:7f88:b0:a7d:2772:6d5f with SMTP id a640c23a62f3a-a7d3fa3f8bemr56915366b.23.1722024000997;
        Fri, 26 Jul 2024 13:00:00 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] can: m_can: Remove coalesing disable in isr during suspend
Date: Fri, 26 Jul 2024 21:59:39 +0200
Message-ID: <20240726195944.2414812-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to disable coalescing when the interrupt handler executes
while the chip is suspended. The coalescing is already reset during
suspend.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9d7d551e3534..fd600ab93218 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1223,10 +1223,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev)) {
-		m_can_coalescing_disable(cdev);
+	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
-	}
 
 	ir = m_can_read(cdev, M_CAN_IR);
 	m_can_coalescing_update(cdev, ir);
-- 
2.45.2


