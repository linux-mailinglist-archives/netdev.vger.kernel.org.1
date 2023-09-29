Return-Path: <netdev+bounces-37039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967CD7B347D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 759C2284050
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5D51226;
	Fri, 29 Sep 2023 14:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036554F132
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 14:13:19 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F51B6
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40566f8a093so110952985e9.3
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996795; x=1696601595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNRpt9Ev9qofjAUYv+k7t3L+D1vFrS36bTS0B/xrd1c=;
        b=pr9aM9irCNFDsg/OcBK1bC6oUnVMDyuLm5bQOaNfP5Oovu7BhPCUoXh9uw+sLa+Qvz
         Omc00YjxnZYoRpmqg/du1RucIwWa1hURSEOoXB/J2d73o038kV0ZrzZkmXJ6V2iICAcs
         8RsYZXJvRwhlhyCN1Oyf2JixRYHBIwKrCfeyHsZHAnqIvIzvxp9Zn0+YDE4q/sWkYuLJ
         YLFHkKT5kaJXOoKdJuVwLvErDRyRuIopzuo5PRxuqbG9CqXewLOrokLkR4epXBGKY4ma
         tQ3jDhGzPwG+pEt+PRAwbHTBhkDEZ4qDf/cVmqcjJx8vY8E7KCnTD+4GH9SzxP1VRdyF
         easA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996795; x=1696601595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNRpt9Ev9qofjAUYv+k7t3L+D1vFrS36bTS0B/xrd1c=;
        b=EPZcFqEUqGONoc91pNhO/DS2FQ32MHAxBYAY5a7DS3APdNMOXge6n+UhK+3AO9f5d3
         OcDxeV/QTcNfPRTGmjbXEdWpdniSK8KvArvIHv10Ue/uZsFsQLIgrZ6cSKSYQoW6rI8s
         WhK6t/RoJ+9l2lLjlufNEssSB1XwwGRI/imhh9EhZYQMl1rgm0CYQHgpnZTQhqsDMbAI
         Mx/QsxIfRKVxPU2PJ4jMhUtCZWv994BY6IfL3nu0b9snhymc8zJHY3L43gizC1baLy02
         znOhmP8v+txOKBYZ/9zq5ASdlvVd0qcgjYOdaE6tF1NyX3x8hZtoiaoMvR4ihk8m1BVf
         H3bQ==
X-Gm-Message-State: AOJu0Yy6i370yduujzNQUSwjnEPd2fjDbvu+K9w3H1pSGPuevb/iSmeT
	PAzK5aehY6A9cul5Csb4UyUR4g==
X-Google-Smtp-Source: AGHT+IHKCX0kti1QYnGxtuftuXVEnDbY1KnIa1ODR2Iltbsppug2DD7npKiNeCBguSQ0LR6IP9vutQ==
X-Received: by 2002:a05:600c:3785:b0:405:3803:558a with SMTP id o5-20020a05600c378500b004053803558amr3964121wmr.12.1695996794851;
        Fri, 29 Sep 2023 07:13:14 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:14 -0700 (PDT)
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
Subject: [PATCH v6 04/14] can: m_can: Implement receive coalescing
Date: Fri, 29 Sep 2023 16:12:54 +0200
Message-Id: <20230929141304.3934380-5-msp@baylibre.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

m_can offers the possibility to set an interrupt on reaching a watermark
level in the receive FIFO. This can be used to implement coalescing.
Unfortunately there is no hardware timeout available to trigger an
interrupt if only a few messages were received within a given time. To
solve this I am using a hrtimer to wake up the irq thread after x
microseconds.

The timer is always started if receive coalescing is enabled and new
received frames were available during an interrupt. The timer is stopped
if during a interrupt handling no new data was available.

If the timer is started the new item interrupt is disabled and the
watermark interrupt takes over. If the timer is not started again, the
new item interrupt is enabled again, notifying the handler about every
new item received.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 76 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  5 +++
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a01c9261331d..4492fe0da29c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -422,6 +422,25 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 	}
 }
 
+static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
+{
+	if (cdev->active_interrupts == interrupts)
+		return;
+	cdev->ops->write_reg(cdev, M_CAN_IE, interrupts);
+	cdev->active_interrupts = interrupts;
+}
+
+static void m_can_coalescing_disable(struct m_can_classdev *cdev)
+{
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+
+	if (!cdev->net->irq)
+		return;
+
+	hrtimer_cancel(&cdev->hrtimer);
+	m_can_interrupt_enable(cdev, new_interrupts);
+}
+
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
 	if (!cdev->net->irq) {
@@ -437,6 +456,7 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
+	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
 
 	if (!cdev->net->irq) {
@@ -1091,15 +1111,42 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	return err;
 }
 
+static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
+{
+	u32 new_interrupts = cdev->active_interrupts;
+	bool enable_timer = false;
+
+	if (!cdev->net->irq)
+		return;
+
+	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
+		enable_timer = true;
+		new_interrupts &= ~IR_RF0N;
+	} else if (!hrtimer_active(&cdev->hrtimer)) {
+		new_interrupts |= IR_RF0N;
+	}
+
+	m_can_interrupt_enable(cdev, new_interrupts);
+	if (enable_timer) {
+		hrtimer_start(&cdev->hrtimer,
+			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL);
+	}
+}
+
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev))
+	if (pm_runtime_suspended(cdev->dev)) {
+		m_can_coalescing_disable(cdev);
 		return IRQ_NONE;
+	}
+
 	ir = m_can_read(cdev, M_CAN_IR);
+	m_can_coalescing_update(cdev, ir);
 	if (!ir)
 		return IRQ_NONE;
 
@@ -1114,13 +1161,17 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting
 	 */
-	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
+	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
 		cdev->irqstatus = ir;
 		if (!cdev->is_peripheral) {
 			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
-		} else if (m_can_rx_peripheral(dev, ir) < 0) {
-			goto out_fail;
+		} else {
+			int pkts;
+
+			pkts = m_can_rx_peripheral(dev, ir);
+			if (pkts < 0)
+				goto out_fail;
 		}
 	}
 
@@ -1156,6 +1207,15 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum hrtimer_restart m_can_coalescing_timer(struct hrtimer *timer)
+{
+	struct m_can_classdev *cdev = container_of(timer, struct m_can_classdev, hrtimer);
+
+	irq_wake_thread(cdev->net->irq, cdev->net);
+
+	return HRTIMER_NORESTART;
+}
+
 static const struct can_bittiming_const m_can_bittiming_const_30X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
@@ -1296,7 +1356,7 @@ static int m_can_chip_config(struct net_device *dev)
 	/* Disable unused interrupts */
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
 			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F | IR_RF0W);
+			IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1340,6 +1400,7 @@ static int m_can_chip_config(struct net_device *dev)
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(cdev, M_CAN_RXF0C,
+		    FIELD_PREP(RXFC_FWM_MASK, cdev->rx_max_coalesced_frames_irq) |
 		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF0].num) |
 		    cdev->mcfg[MRAM_RXF0].off);
 
@@ -1398,7 +1459,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
-	m_can_write(cdev, M_CAN_IE, interrupts);
+	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
 	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
@@ -2082,6 +2143,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_PINNED);
 		cdev->hrtimer.function = &hrtimer_callback;
+	} else {
+		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cdev->hrtimer.function = m_can_coalescing_timer;
 	}
 
 	ret = m_can_dev_setup(cdev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 520e14277dff..b916206199f1 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -92,6 +92,11 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int is_peripheral;
 
+	// Cached M_CAN_IE register content
+	u32 active_interrupts;
+	u32 rx_max_coalesced_frames_irq;
+	u32 rx_coalesce_usecs_irq;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.40.1


