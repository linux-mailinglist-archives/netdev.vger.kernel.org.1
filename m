Return-Path: <netdev+bounces-104391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7790C607
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380791C21BDB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2F139CF6;
	Tue, 18 Jun 2024 07:39:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2D13A3EE
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696342; cv=none; b=MjpxghefulK6AVf1HOR9sJinOVEGG7TJbwU1Jp8UukmwTy8Gqatht5HCWJirkntgeIlLRF/74I8a4JS9C5fSWovI2Gn249MAL7qFeKKMQbmzaayJlcBHOBsinZ/bY8arPNk2BqyFAKLdCZ/8ZSr8ZDXxdb9GTUJGn5cCzLChHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696342; c=relaxed/simple;
	bh=Gd03mbowtSYklKdd1Gyrdg7KQJcOs1f74nXTgmCrzOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PSjg9NvvGWvCJKlRht4HXPWn0dLeHj/mAMIfK0atL1ZGRsQ2aMh5M39B4UH6rm5QxUSBLY6pViqZPC7/CJX00ttUzGTSncuiU7e1r2pmfQs36DWDDWOS04d/3Aq8hdJdQqrM5zZUK1N2HVREcppdG7zUd0Dk+5hbugA2Gawd560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sJTQC-00043W-BO; Tue, 18 Jun 2024 09:38:28 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sJTQ7-003AeO-4v; Tue, 18 Jun 2024 09:38:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sJTQ7-002bEI-0G;
	Tue, 18 Jun 2024 09:38:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Tan Tee Min <tee.min.tan@intel.com>,
	Wong Vee Khee <vee.khee.wong@linux.intel.com>
Subject: [PATCH net v1 1/1] net: stmmac: Assign configured channel value to EXTTS event
Date: Tue, 18 Jun 2024 09:38:21 +0200
Message-Id: <20240618073821.619751-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Assign the configured channel value to the EXTTS event in the timestamp
interrupt handler. Without assigning the correct channel, applications
like ts2phc will refuse to accept the event, resulting in errors such
as:
...
ts2phc[656.834]: config item end1.ts2phc.pin_index is 0
ts2phc[656.834]: config item end1.ts2phc.channel is 3
ts2phc[656.834]: config item end1.ts2phc.extts_polarity is 2
ts2phc[656.834]: config item end1.ts2phc.extts_correction is 0
...
ts2phc[656.862]: extts on unexpected channel
ts2phc[658.141]: extts on unexpected channel
ts2phc[659.140]: extts on unexpected channel

Fixes: f4da56529da60 ("net: stmmac: Add support for external trigger timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index f05bd757dfe52..5ef52ef2698fb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -218,6 +218,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 {
 	u32 num_snapshot, ts_status, tsync_int;
 	struct ptp_clock_event event;
+	u32 acr_value, channel;
 	unsigned long flags;
 	u64 ptp_time;
 	int i;
@@ -243,12 +244,15 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
 		       GMAC_TIMESTAMP_ATSNS_SHIFT;
 
+	acr_value = readl(priv->ptpaddr + PTP_ACR);
+	channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
+
 	for (i = 0; i < num_snapshot; i++) {
 		read_lock_irqsave(&priv->ptp_lock, flags);
 		get_ptptime(priv->ptpaddr, &ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		event.type = PTP_CLOCK_EXTTS;
-		event.index = 0;
+		event.index = channel;
 		event.timestamp = ptp_time;
 		ptp_clock_event(priv->ptp_clock, &event);
 	}
-- 
2.39.2


