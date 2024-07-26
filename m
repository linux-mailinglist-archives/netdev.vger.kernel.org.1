Return-Path: <netdev+bounces-113300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420B93D97C
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C163FB22862
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD4154C10;
	Fri, 26 Jul 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EDh3v0EF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7615099D
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024011; cv=none; b=B8oJHN7s8sLPTkP1EH/xnxTPK57IVO09W2H1tVP+XD9QIzgrG0l/pbTjHy5nTb/V+3aPseQyETnLr4pzGqtrefDeAo94hsfwWoTmTEGt/3lZg1KQ3T6Fo9Z4so+aW/8hTyZdnyUX/S51QNHetYO/NTgYG36yjVF6QZIkffmY2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024011; c=relaxed/simple;
	bh=t6EwZ6i4na0n8NMTSrZB1GIshA5X1Zsp8851eUofPjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ6cEUIW2Zgd9r0Ep2Q42uQ07HoVXhwZfEvhKCxtceEwB4Rn5GYIXN5IjaTIyXRSN6SXmiR86ADU5WPU/pjQTpOJ3KcruyGE12wTCKAZhyTv11vL5ysfhFB8CYLx+3KRoTqV/ShV5659fw9w3aIbhzoKTyCDfZZg5gaR6ETKd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EDh3v0EF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso167681266b.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024007; x=1722628807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6vACS09qfMp/6TXOWUchSNtennyGoJCWfR5pa4HeUA=;
        b=EDh3v0EFWYqQmztkws5YnVxrv1SuxKZ8kmQRNhuc5bTBh/bYHU37tPzY8fKgRtfVyN
         2xIylUEHb2cLXibbi1af4e9HjV+A8jnEhnwBXncpSIdYUxnJl5R6d0R/RDpPnKTJoeEX
         Rd223ZHVWOSba2uKp2XM1rpY4/Ghxp6E/P7t2uQFjwHX/X7JeAznwy4wXkvm7ORml0p9
         pCSmBNAx1QoywM+k3EhxU2QAFLVHiU8zkkvcBKkrKZCL4zZQ/crpYlM4RVj/0t8SDADP
         RXhh2gl+8gpoVAD6qfu2aiGdZ/2DLMRLrWJe6EQKC7otVZ/jWcBcFR10yCCt+SeLp8OP
         I8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024007; x=1722628807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6vACS09qfMp/6TXOWUchSNtennyGoJCWfR5pa4HeUA=;
        b=OERvcVwCtuXIOw5aKd95COU1RyzbbBdIgqvtBqsK8nih+I3aTbyLy9UAFdGjJixded
         YQLnM0ipksuvYv4bpXlT1lHfyUlS4AtkuGFJGmgl8NkkQcXYvhXbB23/f7sm9/QmN4ea
         3p+M1i1xv5GUY7fGSuSZxPLqH/ipVar46MT09AvjEJmvae/YGxue+VD3P8WR7QNOFra5
         P7ydZnCZZqA/RT3tOinGmuM27JvZ12PEwXPku6r5K/mJnpSmDCF4/sZvnH5QK+PAP1Lg
         EmNhfZXI9Vx8X3a/384ksssRWV3aX3xFnDt64FpiHbP4bqaxh20Acl2rFA8JsZY6am/E
         kfHg==
X-Forwarded-Encrypted: i=1; AJvYcCXnJnDg1alW2WGSD8irEuA558GCwChDbCaeAwQJCWu20sMfEpzulzhNh1IYGrxln2d+GfyQ/rcDRHMnnN85zPirUoZCGHtK
X-Gm-Message-State: AOJu0YzM668+/wysQRmuWJmmCMJbQiud+iwR+hz7b9LyfliwqUSZBoHs
	HRPRwN3ttSpvw3gAX5YzFE4L1J4Kxpj4Tsc134Hmx75knrrYQ9bt+jUnsrZPjMs=
X-Google-Smtp-Source: AGHT+IEvy1txv1WUQfzxlMFCu8wRQC6RbvPsAnRENjxXb+mowGIzRFW6VNoCJbR9EDAeoYQ9pEjbew==
X-Received: by 2002:a17:907:7e92:b0:a7d:33f0:4d58 with SMTP id a640c23a62f3a-a7d40128730mr45428566b.48.1722024007043;
        Fri, 26 Jul 2024 13:00:07 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:06 -0700 (PDT)
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
Subject: [PATCH 5/7] can: m_can: disable_all_interrupts, not clear active_interrupts
Date: Fri, 26 Jul 2024 21:59:42 +0200
Message-ID: <20240726195944.2414812-6-msp@baylibre.com>
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

active_interrupts is a cache for the enabled interrupts and not the
global masking of interrupts. Do not clear this variable otherwise we
may loose the state of the interrupts.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e70c7100a3c9..bf4a9ae76db9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -483,7 +483,6 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
-	cdev->active_interrupts = 0x0;
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-- 
2.45.2


