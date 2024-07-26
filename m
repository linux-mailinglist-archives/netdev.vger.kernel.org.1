Return-Path: <netdev+bounces-113299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077593D97A
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8685BB232EE
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6E6154BEB;
	Fri, 26 Jul 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NlYD3o0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854215351B
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024011; cv=none; b=mm3/u2Ptp3tDXXzmdn311Etb0+F8lZ6oCf+NBJQYMOORQMtSXNEDex+Pqo+RH/uaR235stfE2HNKb+IT7dPhwddTNvAvCjqbV+AZjy1U1fqTv2Iw3TN/9jDI9NDlwHw1CFpWh4Ne4V0BTod0xaN3OQWinPl4bFA743pVIxu8QA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024011; c=relaxed/simple;
	bh=kgU2ysUlTalRtPMUoLD7OgezubN/PKKaPGTiUiaW48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBu5ow+0fn0OB8Ex/XMuyw6GuyTXi1j+NDqCb5aJpvpqQMou5LXmCUSlJUs1e/s0liS7XVxZiEElsmp738Nf/S0tCv5M0OO9T8YbY3IBw17CJ51WWxch8azhnw57rgmcw3oUfmXGQEU/5L2xAGurrUo9cj2K5LLZ95N/NHMUohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NlYD3o0Z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso2909331a12.2
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024008; x=1722628808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QclbSBAyJmUNV1FmC5rcCovTowLRmYkjOf848LBChQs=;
        b=NlYD3o0Z+f+qqZo503CsGvzWfjqwbQffSLp7v4bVtDGEAqtbj5HSGNxxXIQ3EYT0D3
         R93FAtVr02vR4SDdn0EOiveR4Ib4JikpmrGQJ4Ss4avFzBJknzUfUNMuEShCSbJ3+b8t
         x1xxzR1ZvJ2D4GiIHsLwDnJG3IsyDRscLBQRp5qRGOjhpkycUFaHBgu8kulP16AM4WD4
         hDH+kzrwCReG6tXU1B3qsA9XP/l55cPv3BWV9kjpBYIIc7mpm/eQjqjDqm73UU0HY4a4
         YcgQOK2hbACT2YemAX1E5i1FJKkX8e2R9lLYPzkWl6I2kT5AfI1z6s+bWkXlcQnHPho6
         XcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024008; x=1722628808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QclbSBAyJmUNV1FmC5rcCovTowLRmYkjOf848LBChQs=;
        b=funvyYHZNSgk7MwPU010bAxIo1lCjVohoiI1u65IVn8GMyFIuJmx5O2U4b8SdnQSwE
         9qsRDhK4lp+9lxdzvirQOO4xaswknXohFb7EXtn7082X2hwbDgi1vrEZyHV8lY3dVynM
         Xz72siNe+WZhUgEpREMpL+OCNIicX8wdPodN/l7C9R5qn5IeUfBgRfLHB5/VIuQM9kTb
         v4+MkcmTYrQuObjhWkFXeEpISasXPNrOExQlR3G88LGS1hcNQRRKc2m21d7tAwp66was
         xdEds2k9QOlxzkOmE1LT6PcgiGnCuHTL7KkMCw/6GDUSSXKawBRc+0ijxChXS23VA817
         ECiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWniXAKgNlwaSlOeP88durQ4e+Un3+D2eWuMWv+CbPC7/f6Vm3NO9eDH6RCG4SrJEp/G1s0cp1gy+e1rBBvAC5fpBWGf3RL
X-Gm-Message-State: AOJu0YwRh3QEy4YUV0AYsf9/7bJgvUxcY988Nn5/nCDN8HXBf8/t4R55
	DY4nUqdDxyYl6n8Y51WdGeDVm4c625BAn+DvNcDgxhhgLO5MwkdnkV9Bdu6Nfwg=
X-Google-Smtp-Source: AGHT+IGBz2/F4chosPYowE/GtxDK8/p2E686h0ildr36QYwqG2G1z5tpS2ZWzxOnfdGhbz9kV6ILlg==
X-Received: by 2002:a17:907:2da8:b0:a77:c824:b4c5 with SMTP id a640c23a62f3a-a7d4004414bmr37367666b.18.1722024008110;
        Fri, 26 Jul 2024 13:00:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:07 -0700 (PDT)
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
Subject: [PATCH 6/7] can: m_can: Reset cached active_interrupts on start
Date: Fri, 26 Jul 2024 21:59:43 +0200
Message-ID: <20240726195944.2414812-7-msp@baylibre.com>
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

To force writing the enabled interrupts, reset the active_interrupts
cache.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index bf4a9ae76db9..7c9ad9f7174e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1542,6 +1542,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
+	cdev->active_interrupts = 0;
 	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
-- 
2.45.2


