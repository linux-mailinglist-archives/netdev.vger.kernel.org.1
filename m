Return-Path: <netdev+bounces-69745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31C84C771
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51301F277E4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932902577C;
	Wed,  7 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="boEf44Zi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09E2555D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298364; cv=none; b=aK02oRnOjlsEfDxjQA54q+5PfEybZwDbkzz94THG7thzbKhKC03eKPDrCS5R3xfa4OzCmC3NvToun5SYdJalTwwjNc3bLRZ8Qa+P9UiDWf/DDlXaJIvmJr8dl5ZvMWpX+wpRhzdPxNhIMn+eI7RFMovDowV3159T5BgWTRobHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298364; c=relaxed/simple;
	bh=5VZ7dGu/fwlCWqyr+EDaPjpuqBWXjgLnu5FVMH00+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/PAU75oexXRXpllH0d4+6sl3b/YsU2tNJ8/y2JUwbZ6Z4U+L2aINaNZaMLoYi6qtbfOvu/QBH0Yq++3cE9+gvuhVdrlL0Yv6AwJmUD6gvAs3TJPjf0Pl8fwwPIRcKgXrOPAqDij+mq/hAS4WmsQkujeao7p4JvJ6SJr7YFSN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=boEf44Zi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so51523466b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 01:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298360; x=1707903160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwhCN6py93M7HXamLiAm11RCgKXR81T+J+TrhTuD/Bc=;
        b=boEf44ZitufQVvYPTYXqizTK5N8Xv+lbh8I9jop+SiMr59mrza7WkxHaWZS5xmNDwu
         JNf3YN9ExaA5IKCFSrxRm03ffurJZz5UK+N/DjO9t66T8CDI493r6ffmEs0YVUtF9A6L
         f6k6QrsUabL0grXEhCNX5L2t+k7OXN+vp6eu0n4q34y6N9+Tf1IWdlr630kZ8JOoYwWy
         YuKGOLKWuxidY72W1aUxFRj63kCaREzLxBbs40kSpE6K0ld3s183BKiAKikO2pvTudij
         Sr3NNW+g3m7yN8fvqyRQL48HGzqKF9wKuOm8Py/oNcXi+JFVhLbY/JLRma8v3dy31hcD
         YsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298360; x=1707903160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwhCN6py93M7HXamLiAm11RCgKXR81T+J+TrhTuD/Bc=;
        b=M5toKpdv7Hp08BgqlRLBAQSyO1cPxawr2qNfpZRVlyfxTbq3AC9CdgZ5Lbl0yFSRi4
         Tk1ryZ5PwYrbsV69LUMLVeRncA6nq6eWZcmctGhgtYIMzKw+84IR0J80NgH9bKVF64Od
         o690jmRZ3tFO1KUqR9QOEAoGwLwdpKtIGq3FUIN0ZpuGPFnYYMq1WWJNC2SAOgAoE3Ld
         ymG7lTgYHLzxFOna9XCw+j04Ll/vaOTjGCq+3H0FIn/dh3W86O/GurbTgc5mk1+LMPrp
         es4JM+kWh99FHY6XzT6Fg9ao+saCK89ph6juo9BDD2rMqnUqIpvVCmscejSfkV+FiYoc
         2Nyw==
X-Forwarded-Encrypted: i=1; AJvYcCV/3xmDxqaGO+tGh8xCC1W4x/A/F2TtumciUCn7bqAznC9Zz/oD1eOiIiwIRgNAI/flcRJhHpm9ulA0Gpk1hDWuPkiy5R6M
X-Gm-Message-State: AOJu0Yyf4sX9xzvzylGe8ps2OqCjzAY2jv5f/5Uu5PtFvgGRx1WFHTUV
	Q3G/YnbT1eH9ZyBLQxrxIjcU60Pde+9CBPpb25WzCeZhpqB/NDsxh3MzxoMYmKk=
X-Google-Smtp-Source: AGHT+IGGsoOjK6egKTFxCj0ahbBmSR3vAvVawfHOmvpg6msEvzXhQXrp4xwEg+/uysanGgc5V6knbg==
X-Received: by 2002:a17:907:7676:b0:a35:e22a:9d15 with SMTP id kk22-20020a170907767600b00a35e22a9d15mr3388506ejc.8.1707298360575;
        Wed, 07 Feb 2024 01:32:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuh8Iv5sowmr1IHugcOdOW9Ou3IC606WKoRi4e3STMov1s940meOKOROCj3PPJ97UxTfIbtTvWMVvzVyZsS81zOJMPTdQaWvgJBMNrrW1Mv/32KCB7UL8Ha2xwHgWOcp4YHfbH6Rl/Lhyt+nh+OykHytm1fBllYXRH9rFJWhvIHolhtlDwXmZkvjH+OnaEiewMCXHJUnQHk+s8yoYsEBiiAW10f6mj2qmTWVD7XtYHyFvtZfdNY0bhNgGtB9YScHU8X+1QkBza4cdyfTQz8AnPtonAZ2tWGN2bbIiYEx2LQn7EJ3cloTYZ6vX6NPXrakEg/LESPT6mpR2sHv1K+b2ArVHnxGpGdHGoLfe2D6jKXPoCX52okWyxqm47nau6OgND5Jk94jdNCWdD0CthRi/hKMxRycGnEaUwi++6+KDlj1B0VnGZ0G18RrTm
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:40 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 05/14] can: m_can: Implement transmit coalescing
Date: Wed,  7 Feb 2024 10:32:11 +0100
Message-ID: <20240207093220.2681425-6-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the coalescing implementation for transmits.

In normal mode the chip raises an interrupt for every finished transmit.
This implementation switches to coalescing mode as soon as an interrupt
handled a transmit. For coalescing the watermark level interrupt is used
to interrupt exactly after x frames were sent. It switches back into
normal mode once there was an interrupt with no finished transmit and
the timer being inactive.

The timer is shared with receive coalescing. The time for receive and
transmit coalescing timers have to be the same for that to work. The
benefit is to have only a single running timer.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 33 ++++++++++++++++++++-------------
 drivers/net/can/m_can/m_can.h |  4 ++++
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b76fcf5f3889..9b3e8e09f3aa 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -255,6 +255,7 @@ enum m_can_reg {
 #define TXESC_TBDS_64B		0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
+#define TXEFC_EFWM_MASK		GENMASK(29, 24)
 #define TXEFC_EFS_MASK		GENMASK(21, 16)
 
 /* Tx Event FIFO Status (TXEFS) */
@@ -432,7 +433,7 @@ static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
 
 static void m_can_coalescing_disable(struct m_can_classdev *cdev)
 {
-	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N | IR_TEFN;
 
 	if (!cdev->net->irq)
 		return;
@@ -1115,24 +1116,29 @@ static int m_can_echo_tx_event(struct net_device *dev)
 static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 {
 	u32 new_interrupts = cdev->active_interrupts;
-	bool enable_timer = false;
+	bool enable_rx_timer = false;
+	bool enable_tx_timer = false;
 
 	if (!cdev->net->irq)
 		return;
 
 	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
-		enable_timer = true;
+		enable_rx_timer = true;
 		new_interrupts &= ~IR_RF0N;
-	} else if (!hrtimer_active(&cdev->hrtimer)) {
-		new_interrupts |= IR_RF0N;
 	}
+	if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TEFW))) {
+		enable_tx_timer = true;
+		new_interrupts &= ~IR_TEFN;
+	}
+	if (!enable_rx_timer && !hrtimer_active(&cdev->hrtimer))
+		new_interrupts |= IR_RF0N;
+	if (!enable_tx_timer && !hrtimer_active(&cdev->hrtimer))
+		new_interrupts |= IR_TEFN;
 
 	m_can_interrupt_enable(cdev, new_interrupts);
-	if (enable_timer) {
-		hrtimer_start(&cdev->hrtimer,
-			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+	if (enable_rx_timer | enable_tx_timer)
+		hrtimer_start(&cdev->hrtimer, cdev->irq_timer_wait,
 			      HRTIMER_MODE_REL);
-	}
 }
 
 static irqreturn_t m_can_isr(int irq, void *dev_id)
@@ -1187,7 +1193,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			netif_wake_queue(dev);
 		}
 	} else  {
-		if (ir & IR_TEFN) {
+		if (ir & (IR_TEFN | IR_TEFW)) {
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
@@ -1355,9 +1361,8 @@ static int m_can_chip_config(struct net_device *dev)
 	}
 
 	/* Disable unused interrupts */
-	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
-			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F);
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1394,6 +1399,8 @@ static int m_can_chip_config(struct net_device *dev)
 	} else {
 		/* Full TX Event FIFO is used */
 		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFWM_MASK,
+				       cdev->tx_max_coalesced_frames_irq) |
 			    FIELD_PREP(TXEFC_EFS_MASK,
 				       cdev->mcfg[MRAM_TXE].num) |
 			    cdev->mcfg[MRAM_TXE].off);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index b916206199f1..1e461d305bce 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -84,6 +84,8 @@ struct m_can_classdev {
 	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
+	ktime_t irq_timer_wait;
+
 	struct m_can_ops *ops;
 
 	int version;
@@ -96,6 +98,8 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames_irq;
+	u32 tx_coalesce_usecs_irq;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
-- 
2.43.0


