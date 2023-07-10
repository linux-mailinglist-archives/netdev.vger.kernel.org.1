Return-Path: <netdev+bounces-16358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A074CE1C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D4E1C209A9
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266EC15E;
	Mon, 10 Jul 2023 07:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06871567D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:20:13 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BECEB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:20:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBY-0008Dp-C1; Mon, 10 Jul 2023 09:19:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBV-00DMe9-Ax; Mon, 10 Jul 2023 09:19:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBU-003jlu-Km; Mon, 10 Jul 2023 09:19:48 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Wei Fang <wei.fang@nxp.com>,
	Simon Horman <simon.horman@corigine.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Rob Herring <robh@kernel.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Li Yang <leoyang.li@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 0/8] net: freescale: Convert to platform remove callback returning void
Date: Mon, 10 Jul 2023 09:19:38 +0200
Message-Id: <20230710071946.3470249-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TkFJrQ3hly2E7ZLecW5hxiPTXLPviTcuFnxLd6aVHn0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkq7EEdv8rROspu6T+WuYeWU9WEhP/nVM3uBaYe RYHuYT2ZpWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKuxBAAKCRCPgPtYfRL+ ThtbB/9k+NYqB1wXLRyKEdH6cUwEKSwa0zvI7aKo8QfrxZoUfkWPDVMwq29jCFqAsOYgF/oYjd0 /KZrQ8NylM4XKfwLFf1Uo1+IPsvNZAqcAdYzbWAqjqdwfJllMyz6OH73oCkzwwRm0Kco6GwFU+9 Q2UUxv9GgWQE60hOkRuwT8NuWfhiWiuwRa6azi8SwcfMm/tI9wDqo9KdYdt37wd3uZCczAETU1r sPo8ut/YwRbf/rmF+M+xTDoqTNkoJeXycP0EtP9iERN+UjUiyk2nesow4AFEEG5X5ikJeoGWIXu d5IkfGGektutX6PxltOBS5Q2DBNg/IAOMuVbHu4mHwi7PJhu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

v2 of this series was sent in June[1], code changes since then only affect
patch #1 where the dev_err invocation was adapted to emit the error code of
dpaa_fq_free(). Thanks for feedback by Maciej Fijalkowski and Russell King.
Other than that I added Reviewed-by tags for Simon Horman and Wei Fang and
rebased to v6.5-rc1.

There is only one dependency in this series: Patch #2 depends on patch
#1.

Best regards
Uwe

[1] https://lore.kernel.org/netdev/20230606162829.166226-1-u.kleine-koenig@pengutronix.de

Uwe Kleine-König (8):
  net: dpaa: Improve error reporting
  net: dpaa: Convert to platform remove callback returning void
  net: fec: Convert to platform remove callback returning void
  net: fman: Convert to platform remove callback returning void
  net: fs_enet: Convert to platform remove callback returning void
  net: fsl_pq_mdio: Convert to platform remove callback returning void
  net: gianfar: Convert to platform remove callback returning void
  net: ucc_geth: Convert to platform remove callback returning void

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        | 9 +++++----
 drivers/net/ethernet/freescale/fec_main.c             | 5 ++---
 drivers/net/ethernet/freescale/fec_mpc52xx.c          | 6 ++----
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c      | 6 ++----
 drivers/net/ethernet/freescale/fman/mac.c             | 5 ++---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 5 ++---
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c  | 6 ++----
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c      | 6 ++----
 drivers/net/ethernet/freescale/fsl_pq_mdio.c          | 6 ++----
 drivers/net/ethernet/freescale/gianfar.c              | 6 ++----
 drivers/net/ethernet/freescale/ucc_geth.c             | 6 ++----
 11 files changed, 25 insertions(+), 41 deletions(-)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2


