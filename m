Return-Path: <netdev+bounces-18390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03A756B5D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3991C208A3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756BC145;
	Mon, 17 Jul 2023 18:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B293C141
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:09:50 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6110C4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:09:47 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qLSfJ-00088X-J9
	for netdev@vger.kernel.org; Mon, 17 Jul 2023 20:09:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4EB4E1F3975
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:09:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C32611F394B;
	Mon, 17 Jul 2023 18:09:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bb67d14e;
	Mon, 17 Jul 2023 18:09:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fedor Ross <fedor.ross@ifm.com>,
	Marek Vasut <marex@denx.de>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/5] can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
Date: Mon, 17 Jul 2023 20:09:38 +0200
Message-Id: <20230717180938.230816-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717180938.230816-1-mkl@pengutronix.de>
References: <20230717180938.230816-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Fedor Ross <fedor.ross@ifm.com>

The mcp251xfd controller needs an idle bus to enter 'Normal CAN 2.0
mode' or . The maximum length of a CAN frame is 736 bits (64 data
bytes, CAN-FD, EFF mode, worst case bit stuffing and interframe
spacing). For low bit rates like 10 kbit/s the arbitrarily chosen
MCP251XFD_POLL_TIMEOUT_US of 1 ms is too small.

Otherwise during polling for the CAN controller to enter 'Normal CAN
2.0 mode' the timeout limit is exceeded and the configuration fails
with:

| $ ip link set dev can1 up type can bitrate 10000
| [  731.911072] mcp251xfd spi2.1 can1: Controller failed to enter mode CAN 2.0 Mode (6) and stays in Configuration Mode (4) (con=0x068b0760, osc=0x00000468).
| [  731.927192] mcp251xfd spi2.1 can1: CRC read error at address 0x0e0c (length=4, data=00 00 00 00, CRC=0x0000) retrying.
| [  731.938101] A link change request failed with some changes committed already. Interface can1 may have been left with an inconsistent configuration, please check.
| RTNETLINK answers: Connection timed out

Make MCP251XFD_POLL_TIMEOUT_US timeout calculation dynamic. Use
maximum of 1ms and bit time of 1 full 64 data bytes CAN-FD frame in
EFF mode, worst case bit stuffing and interframe spacing at the
current bit rate.

For easier backporting define the macro MCP251XFD_FRAME_LEN_MAX_BITS
that holds the max frame length in bits, which is 736. This can be
replaced by can_frame_bits(true, true, true, true, CANFD_MAX_DLEN) in
a cleanup patch later.

Fixes: 55e5b97f003e8 ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230717-mcp251xfd-fix-increase-poll-timeout-v5-1-06600f34c684@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 68df6d4641b5..eebf967f4711 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -227,6 +227,8 @@ static int
 __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 			  const u8 mode_req, bool nowait)
 {
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	unsigned long timeout_us = MCP251XFD_POLL_TIMEOUT_US;
 	u32 con = 0, con_reqop, osc = 0;
 	u8 mode;
 	int err;
@@ -246,12 +248,16 @@ __mcp251xfd_chip_set_mode(const struct mcp251xfd_priv *priv,
 	if (mode_req == MCP251XFD_REG_CON_MODE_SLEEP || nowait)
 		return 0;
 
+	if (bt->bitrate)
+		timeout_us = max_t(unsigned long, timeout_us,
+				   MCP251XFD_FRAME_LEN_MAX_BITS * USEC_PER_SEC /
+				   bt->bitrate);
+
 	err = regmap_read_poll_timeout(priv->map_reg, MCP251XFD_REG_CON, con,
 				       !mcp251xfd_reg_invalid(con) &&
 				       FIELD_GET(MCP251XFD_REG_CON_OPMOD_MASK,
 						 con) == mode_req,
-				       MCP251XFD_POLL_SLEEP_US,
-				       MCP251XFD_POLL_TIMEOUT_US);
+				       MCP251XFD_POLL_SLEEP_US, timeout_us);
 	if (err != -ETIMEDOUT && err != -EBADMSG)
 		return err;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 7024ff0cc2c0..24510b3b8020 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -387,6 +387,7 @@ static_assert(MCP251XFD_TIMESTAMP_WORK_DELAY_SEC <
 #define MCP251XFD_OSC_STAB_TIMEOUT_US (10 * MCP251XFD_OSC_STAB_SLEEP_US)
 #define MCP251XFD_POLL_SLEEP_US (10)
 #define MCP251XFD_POLL_TIMEOUT_US (USEC_PER_MSEC)
+#define MCP251XFD_FRAME_LEN_MAX_BITS (736)
 
 /* Misc */
 #define MCP251XFD_NAPI_WEIGHT 32
-- 
2.40.1



