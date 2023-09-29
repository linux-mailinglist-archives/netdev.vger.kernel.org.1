Return-Path: <netdev+bounces-37036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B37B3472
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C7A921C20985
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D34E28B;
	Fri, 29 Sep 2023 14:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C418639
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:13:15 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC51B1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4060b623e64so4731405e9.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996791; x=1696601591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP9/EZvDGvUhVhFYEHkXRFR3oagSwM5LS3r0l1v/oX0=;
        b=28lRs+NYbbeM0bA5/GrRJqSLdiQSOYhzXbDzzapk0rTAte25ZBHQVS/imDpiwxEWiG
         Y0SJhkoPlGvaYBpUUQQV7RHKDkpGXE7LaZKNVwcn/ftAIMHxfuyQL8XEGPQ4FMgfAAKw
         1iYYdImnH/7BICRhNjFuqZkdp1K2Z65vjjCVxn/1B+nLb/hqrssUZRa3mqL470GSG03a
         KAtAaB/54tFDREGSO1qIACI7Texs1q5iAnWDOAyEOg/DNDXQSDdgixQg8KciK8LuTNEz
         DvYQKxNGf3nOl0LjmQ2c6QqRRUlkEc7txJ7Sy5OLNBnSdRpSnVqjE5HbrgNa0H3r6ki5
         qPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996791; x=1696601591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP9/EZvDGvUhVhFYEHkXRFR3oagSwM5LS3r0l1v/oX0=;
        b=RO6bF2kyj8h927+PGaXFIt89gvxx8iEaSFM98wj8PG8rk4Nv//CZwni5xFqP2cFUst
         0mru1hsDIKSlO5dDw2x41KfnFz2zzz9ZZXAaC4l2f1cOtlWvqRjXujcgGBiD69Vqe8YQ
         yseWNENlkUMNpzteK8Ke3Mv5e48Qgr7z12Q0EkFo1DDwEeEfSMelWloEIEI06IqhJJte
         CEHYPxl+2EmF8oHmthrIQDgzjgk/r61LphbYjwTW3z9hyEMKFdRD7BT9yL0V5SigjY2K
         sdeejibq3oJtuXR4Awoch5vy6o4lpm2Uvc+r1TFQ2BXpDeWv3aTBL9CuKCv0r4tiAX5J
         ML8A==
X-Gm-Message-State: AOJu0YwIz5tyYubGSDRUqEEYIjdakLTvzGDgcs6zbVLBllg/VtNFtIFn
	EEzgdib6CoBuEJDMSxFo9jsYsQ==
X-Google-Smtp-Source: AGHT+IEmWzM5o2DT05f5B27KnYXBxNpyUowGumypr1SzDf9sMKih3uNX6PnyL9ltcQJ5Ys8Uoh/b5g==
X-Received: by 2002:a7b:c7d4:0:b0:401:c8b9:4b86 with SMTP id z20-20020a7bc7d4000000b00401c8b94b86mr3917397wmk.9.1695996790513;
        Fri, 29 Sep 2023 07:13:10 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:10 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 01/14] can: m_can: Start/Cancel polling timer together with interrupts
Date: Fri, 29 Sep 2023 16:12:51 +0200
Message-Id: <20230929141304.3934380-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Interrupts are enabled/disabled in more places than just m_can_start()
and m_can_stop(). Couple the polling timer with enabling/disabling of
all interrupts to achieve equivalent behavior.

Cc: Judith Mendez <jm@ti.com>
Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..2395b1225cc8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -418,6 +418,13 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Start hrtimer\n");
+		hrtimer_start(&cdev->hrtimer,
+			      ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
 	/* Only interrupt line 0 is used in this driver */
 	m_can_write(cdev, M_CAN_ILE, ILE_EINT0);
 }
@@ -425,6 +432,11 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_write(cdev, M_CAN_ILE, 0x0);
+
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Stop hrtimer\n");
+		hrtimer_cancel(&cdev->hrtimer);
+	}
 }
 
 /* Retrieve internal timestamp counter from TSCV.TSC, and shift it to 32-bit
@@ -1417,12 +1429,6 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Start hrtimer\n");
-		hrtimer_start(&cdev->hrtimer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
-			      HRTIMER_MODE_REL_PINNED);
-	}
-
 	return 0;
 }
 
@@ -1577,11 +1583,6 @@ static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Stop hrtimer\n");
-		hrtimer_cancel(&cdev->hrtimer);
-	}
-
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
-- 
2.40.1


