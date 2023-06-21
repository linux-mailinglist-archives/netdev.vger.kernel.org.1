Return-Path: <netdev+bounces-12638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EF738566
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B8E280EDF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621219E59;
	Wed, 21 Jun 2023 13:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2019E4B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:53 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A201BE5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:29:39 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qBxtx-000762-Ry
	for netdev@vger.kernel.org; Wed, 21 Jun 2023 15:29:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6F23E1DE94F
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6EA101DE891;
	Wed, 21 Jun 2023 13:29:18 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0cae09eb;
	Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Thomas Kopp <Thomas.Kopp@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/33] can: length: fix bitstuffing count
Date: Wed, 21 Jun 2023 15:28:57 +0200
Message-Id: <20230621132914.412546-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The Stuff Bit Count is always coded on 4 bits [1]. Update the Stuff
Bit Count size accordingly.

In addition, the CRC fields of CAN FD Frames contain stuff bits at
fixed positions called fixed stuff bits [2]. The CRC field starts with
a fixed stuff bit and then has another fixed stuff bit after each
fourth bit [2], which allows us to derive this formula:

  FSB count = 1 + round_down(len(CRC field)/4)

The length of the CRC field is [1]:

  len(CRC field) = len(Stuff Bit Count) + len(CRC)
                 = 4 + len(CRC)

with len(CRC) either 17 or 21 bits depending of the payload length.

In conclusion, for CRC17:

  FSB count = 1 + round_down((4 + 17)/4)
            = 6

and for CRC 21:

  FSB count = 1 + round_down((4 + 21)/4)
            = 7

Add a Fixed Stuff bits (FSB) field with above values and update
CANFD_FRAME_OVERHEAD_SFF and CANFD_FRAME_OVERHEAD_EFF accordingly.

[1] ISO 11898-1:2015 section 10.4.2.6 "CRC field":

  The CRC field shall contain the CRC sequence followed by a recessive
  CRC delimiter. For FD Frames, the CRC field shall also contain the
  stuff count.

  Stuff count

  If FD Frames, the stuff count shall be at the beginning of the CRC
  field. It shall consist of the stuff bit count modulo 8 in a 3-bit
  gray code followed by a parity bit [...]

[2] ISO 11898-1:2015 paragraph 10.5 "Frame coding":

  In the CRC field of FD Frames, the stuff bits shall be inserted at
  fixed positions; they are called fixed stuff bits. There shall be a
  fixed stuff bit before the first bit of the stuff count, even if the
  last bits of the preceding field are a sequence of five consecutive
  bits of identical value, there shall be only the fixed stuff bit,
  there shall not be two consecutive stuff bits. A further fixed stuff
  bit shall be inserted after each fourth bit of the CRC field [...]

Fixes: 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce function to get data length of frame in data link layer")
Suggested-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Link: https://lore.kernel.org/all/20230611025728.450837-2-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/length.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 69336549d24f..b8c12c83bc51 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -72,17 +72,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
+#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(67, 8)
 
 /*
  * Size of a CAN-FD Extended Frame
@@ -101,17 +102,18 @@
  * Error Status Indicator (ESI)		1
  * Data length code (DLC)		4
  * Data field				0...512
- * Stuff Bit Count (SBC)		0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)		4
  * CRC					0...16: 17 20...64:21
  * CRC delimiter (CD)			1
+ * Fixed Stuff bits (FSB)		0...16: 6 20...64:7
  * ACK slot (AS)			1
  * ACK delimiter (AD)			1
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
+#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(86, 8)
 
 /*
  * Maximum size of a Classical CAN frame
-- 
2.40.1



