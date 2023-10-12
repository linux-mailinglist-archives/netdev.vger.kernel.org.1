Return-Path: <netdev+bounces-40291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA37C68EB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33823282A40
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC320B3C;
	Thu, 12 Oct 2023 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A7208D3
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:02:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E93EB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:02:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qqraM-0000CH-Lr; Thu, 12 Oct 2023 11:02:26 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qqraK-0016dI-UL; Thu, 12 Oct 2023 11:02:24 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
	by dude03.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <j.zink@pengutronix.de>)
	id 1qqral-00FyMl-11;
	Thu, 12 Oct 2023 11:02:24 +0200
From: Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH net-next 0/5] net: stmmac: fix PPS input indexing
Date: Thu, 12 Oct 2023 11:02:11 +0200
Message-Id: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABO2J2UC/x3NwQqDMBCE4VeRPTeQ2JN9lVLCmo51IW4liRIR3
 72hx38O35yUkQSZHt1JCbtk+WoLd+sozKwfGHm3pt72d2edNbksCwc/SfW8VYnC6fDYocUHXsu
 WYMBT78BDGCZQg0bOMGNiDXOjdIuxjWtCM/7PT1IUo6iFXtf1A6TFhSSTAAAA
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
 kernel@pengutronix.de, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The stmmac can have 0 to 4 auxiliary snapshot in channels, which can be
used for capturing external triggers with respect to the eqos PTP timer.

Previously when enabling the auxiliary snapshot, an invalid request was
written to the hardware register, except for the Intel variant of this
driver, where the only snapshot available was hardcoded.

Patch 1 of this series cleans up the debug netdev_dbg message indicating
the auxiliary snapshot being {en,dis}abled. No functional changes here

Patch 2 of this series fixes the PPS input indexing

Patch 3 of this series removes a field member from plat_stmmacnet_data
that is no longer needed

Patch 4 of this series prepares Patch 5 by protecting the snapshot
enabled flag by the aux_ts_lock mutex

Patch 5 of this series adds a temporary workaround, since at the moment
the driver can handle only one single auxiliary snapshot at a time.
Previously the driver silently dropped the previous configuration and
enabled the new one. Now, if a snapshot is already enabled and userspace
tries to enable another without previously disabling the snapshot currently
enabled: issue a netdev_err and return an errorcode indicating the device is
busy.

Best Regards
Johannes

To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Jose Abreu <joabreu@synopsys.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: patchwork-jzi@pengutronix.de
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
Johannes Zink (5):
      net: stmmac: simplify debug message on stmmac_enable()
      net: stmmac: fix PPS capture input index
      net: stmmac: intel: remove unnecessary field struct plat_stmmacenet_data::ext_snapshot_num
      net: stmmac: ptp: stmmac_enable(): move change of plat->flags into mutex
      net: stmmac: do not silently change auxiliary snapshot capture channel

 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 32 ++++++++++++++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h  |  2 +-
 include/linux/stmmac.h                            |  1 -
 4 files changed, 21 insertions(+), 15 deletions(-)
---
base-commit: 21b2e2624d2ec69b831cd2edd202ca30ac6beae1
change-id: 20231010-stmmac_fix_auxiliary_event_capture-eaf21ea9c9fe

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>


