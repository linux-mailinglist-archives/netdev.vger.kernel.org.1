Return-Path: <netdev+bounces-113297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCA93D971
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E9C1C238BF
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47014E2DF;
	Fri, 26 Jul 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vE8wLO46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED017149E1E
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024006; cv=none; b=OAV9M29j11yw74MQbseM57/RMuZFr1E/JfbubERn34gEERGWbZXYDsKml4EoSqqsqs6M5lfXiIZ1ZzdFkez6L13nMDA/I7eEVkxIe2+VXR7jrTNWsjEP2eGN/ZEPn5Osj34ctoilHYS/Or34uATgGZaer1V8rw9yrjGlXvrIVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024006; c=relaxed/simple;
	bh=EbgGe2gsLdH2biBweP1nqPyr3Zg50Y1HA4LdIiHtm3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+TXX8VFA/jPOn5Sa6n+wVycwwZfr7GyXg/tb5VEV6FxuZ33Yp7mCttY/TIAr4AobrDMgV+aoblwo+IALWxGLZI6slD61wMHFMP53R+xE01Jkzx9ejE6kjxq9hHg7M6N7fRTDa15hVKK1tuoyKrG7azUr4L3jncWvXcCajBMDbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vE8wLO46; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so256508366b.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024003; x=1722628803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=vE8wLO46tz42t4+EsgXj+WRE4wNMAzeRXioKCIhmj+m/AiV3tN3sLLwv84HFS1+HM/
         kMoguvHy4wsBHXuGaxgFnH9TwN5JzbqUcYcG09nuxFCQHPI0dt1Rr56yCiQZKkIl57Fe
         F38W+bZg2IuT6eXoRhTQkOYCp4QleVN4TpiYzjr5jrLN7WyU1/lv9RRAet9EPo6kb00t
         dpBZWeidfzzi7vGPOGPYkUthyQJlGpar+eJxmjYvnqzEGwdfOM+JDUYwR6XuOrX20Swl
         inSB/U5ESurF9zn6DOG+aHUv7Buwfqjcz1Irta7IOBORcDIN3IIJ6IbzCbbJqdew4kB5
         gRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024003; x=1722628803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=mL4onmgdDH5b3ryBAbzr5C/AWsfa176PvbenmBM/C3dX0Sm8Z8pfNUka6aFq9y6Hyi
         d/6BSmnmF4TWbSB6ZxL8HVRppJJs7cCBGnNlLdbi7M1rhP1idtz8i2uaMtdCgFrcqY2G
         ecuscWivRLchOzbJXc7RZcUB93kmdMLhd7d5BtX6QoMYLYFF2fvZ6VEh1Nm/mAdpGYno
         aQLAQYE5hrUxQCxKmuEOo32+qVf/6cgbb/VdQrKi3YlRP5XfpLN3qxYhrq5G7jd/VQgz
         R44tMyvxz9sI2vzQLFLubLaE4Mj95chXaW8RcF2A77qv6CZo6q22fHe2Gsiz7PU9xoeb
         KGXw==
X-Forwarded-Encrypted: i=1; AJvYcCWIOSBJBv//EMFpxZr06NNP7xgIgS9UrJFO3gIQEo/Jo/RRkVd/mP5HMwlq9ViVp+ql2cspCf1KcUTCYoHuEiRxPASCddwJ
X-Gm-Message-State: AOJu0YwMR1twJnY6An7RPENVBK3qm4Oo2b2J2FpzvCo4VruwHmcBDPYo
	ppp7PJy+oCRjboO1ThGY7t0Qt7Ky0UQR5+7B9PZY4keWqQpKgd9qNefR5PlKauYawnpqV3mH8PX
	K
X-Google-Smtp-Source: AGHT+IFTEGZPICz8oxt3K4AgX4DGGbn/vDQD5wGVMFK8bcxJxs67PXzAxqfUJbBP4LD3EEqv+kU6xA==
X-Received: by 2002:a17:907:2da7:b0:a7a:ab1a:2d65 with SMTP id a640c23a62f3a-a7d40160769mr43935566b.67.1722024003367;
        Fri, 26 Jul 2024 13:00:03 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:02 -0700 (PDT)
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
Subject: [PATCH 3/7] can: m_can: Remove m_can_rx_peripheral indirection
Date: Fri, 26 Jul 2024 21:59:40 +0200
Message-ID: <20240726195944.2414812-4-msp@baylibre.com>
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

m_can_rx_peripheral() is a wrapper around m_can_rx_handler() that calls
m_can_disable_all_interrupts() on error. The same handling for the same
error path is done in m_can_isr() as well.

So remove m_can_rx_peripheral() and do the call from m_can_isr()
directly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fd600ab93218..42ed7f0fea78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1037,22 +1037,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-
-	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done < 0)
-		m_can_disable_all_interrupts(cdev);
-
-	return work_done;
-}
-
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1250,7 +1234,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		} else {
 			int pkts;
 
-			pkts = m_can_rx_peripheral(dev, ir);
+			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
 			if (pkts < 0)
 				goto out_fail;
 		}
-- 
2.45.2


