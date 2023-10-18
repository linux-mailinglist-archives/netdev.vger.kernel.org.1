Return-Path: <netdev+bounces-42136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC27CD548
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3888CB2124A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03451171E;
	Wed, 18 Oct 2023 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D0D312
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 07:10:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEB9B6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 00:10:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qt0h1-0007Yt-S9; Wed, 18 Oct 2023 09:10:11 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qt0gz-002V9c-41; Wed, 18 Oct 2023 09:10:09 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
	by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qt0gz-003JoA-07;
	Wed, 18 Oct 2023 09:10:09 +0200
From: Johannes Zink <j.zink@pengutronix.de>
Date: Wed, 18 Oct 2023 09:09:56 +0200
Subject: [PATCH net-next v2 4/5] net: stmmac: ptp: stmmac_enable(): move
 change of plat->flags into mutex
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v2-4-51d5f56542d7@pengutronix.de>
References: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v2-0-51d5f56542d7@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: patchwork-jzi@pengutronix.de, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, vee.khee.wong@linux.intel.com, tee.min.tan@intel.com, 
 rmk+kernel@armlinux.org.uk, bartosz.golaszewski@linaro.org, 
 ahalaney@redhat.com, horms@kernel.org, 
 Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a preparation patch. The next patch will check if an external TS
is active and return with an error. So we have to move the change of the
plat->flags that tracks if external timestamping is enabled after that
check.

Prepare for this change and move the plat->flags change into the mutex
and the if (on).

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

---

Changelog:

v1 -> v2: no changes
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 300e673d2a36..6b639b62f778 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -192,17 +192,17 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
 	case PTP_CLK_REQ_EXTTS:
-		if (on)
-			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
-		else
-			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		mutex_lock(&priv->aux_ts_lock);
 		acr_value = readl(ptpaddr + PTP_ACR);
 		acr_value &= ~PTP_ACR_MASK;
 		if (on) {
+			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
+
 			/* Enable External snapshot trigger */
 			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
 			acr_value |= PTP_ACR_ATSFC;
+		} else {
+			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
 		}
 		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
 			   rq->extts.index, on ? "enabled" : "disabled");

-- 
2.39.2


