Return-Path: <netdev+bounces-38389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C967BAAEF
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BA92B1C209EA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476442BE0;
	Thu,  5 Oct 2023 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8A41AB2
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89415FA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUH-0004ju-5E
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:21 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUD-00BLGt-P0
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:17 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 69A6222FFD1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C71D922FF70;
	Thu,  5 Oct 2023 19:58:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7e7bbc19;
	Thu, 5 Oct 2023 19:58:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH net-next 07/37] can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
Date: Thu,  5 Oct 2023 21:57:42 +0200
Message-Id: <20231005195812.549776-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This race condition was discovered while updating the at91_can driver
to use can_bus_off(). The following scenario describes how the
converted at91_can driver would behave.

When a CAN device goes into BUS-OFF state, the driver usually
stops/resets the CAN device and calls can_bus_off().

This function sets the netif carrier to off, and (if configured by
user space) schedules a delayed work that calls can_restart() to
restart the CAN device.

The can_restart() function first checks if the carrier is off and
triggers an error message if the carrier is OK.

Then it calls the driver's do_set_mode() function to restart the
device, then it sets the netif carrier to on. There is a race window
between these two calls.

The at91 CAN controller (observed on the sama5d3, a single core 32 bit
ARM CPU) has a hardware limitation. If the device goes into bus-off
while sending a CAN frame, there is no way to abort the sending of
this frame. After the controller is enabled again, another attempt is
made to send it.

If the bus is still faulty, the device immediately goes back to the
bus-off state. The driver calls can_bus_off(), the netif carrier is
switched off and another can_restart is scheduled. This occurs within
the race window before the original can_restart() handler marks the
netif carrier as OK. This would cause the 2nd can_restart() to be
called with an OK netif carrier, resulting in an error message.

The flow of the 1st can_restart() looks like this:

can_restart()
    // bail out if netif_carrier is OK

    netif_carrier_ok(dev)
    priv->do_set_mode(dev, CAN_MODE_START)
        // enable CAN controller
        // sama5d3 restarts sending old message

        // CAN devices goes into BUS_OFF, triggers IRQ

// IRQ handler start
    at91_irq()
        at91_irq_err_line()
            can_bus_off()
                netif_carrier_off()
                schedule_delayed_work()
// IRQ handler end

    netif_carrier_on()

The 2nd can_restart() will be called with an OK netif carrier and the
error message will be printed.

To close the race window, first set the netif carrier to on, then
restart the controller. In case the restart fails with an error code,
roll back the netif carrier to off.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Link: https://lore.kernel.org/all/20231005-can-dev-fix-can-restart-v2-2-91b5c1fd922c@pengutronix.de
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a5bbdfa9a269..735d5de3caa0 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -154,11 +154,12 @@ static void can_restart(struct net_device *dev)
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
 	netif_carrier_on(dev);
-	if (err)
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
 		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
 }
 
 static void can_restart_work(struct work_struct *work)
-- 
2.40.1



