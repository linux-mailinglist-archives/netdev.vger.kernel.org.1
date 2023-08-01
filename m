Return-Path: <netdev+bounces-23063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C976A8DE
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1281C20D30
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951E4A15;
	Tue,  1 Aug 2023 06:22:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A63FEF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D5CC433C9;
	Tue,  1 Aug 2023 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690870966;
	bh=b2RgmgrZgvx8gY0C2fKs3oh+azWjdXtoP4cL2Idz4YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7RwOb7oUztbzNAhEda9ikSF6FSSik48MGrDJVno2hY8EGt94fNSgeklPels0sqy/
	 ekGIXqs1rIX+lqgmqiCbMJ4RRQqhD0I5PFZ5U61ItHDTgxTDSnrbo/i5NWHKr672TQ
	 u16Gr0Sz9UP84+M11kkSOn6ZOabbRqBP5eWlBuNewTTrVrc2Kznm1/ABduiVtBx1+U
	 QGPlRY38tDc7yiDbuYiJUFTXVT3J+jbcRG+qRv/iqzg83wIYgsmwXaIvf5Sm9BLS7I
	 QMWbmKg77O4YVa+uWl2K918TxGce9WZNxM7BlhuiKbP8sOnQwTGTZqeVh/WozHA3hI
	 cFS4s7uOkcCyQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Max Staudt <max@enpas.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] can: can327: remove casts from tty->disc_data
Date: Tue,  1 Aug 2023 08:22:36 +0200
Message-ID: <20230801062237.2687-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801062237.2687-1-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tty->disc_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/can/can327.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index dc7192ecb001..ee8a977acc8d 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -888,7 +888,7 @@ static bool can327_is_valid_rx_char(u8 c)
 static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 			    const char *fp, int count)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 	size_t first_new_char_idx;
 
 	if (elm->uart_side_failure)
@@ -990,7 +990,7 @@ static void can327_ldisc_tx_worker(struct work_struct *work)
 /* Called by the driver when there's room for more data. */
 static void can327_ldisc_tx_wakeup(struct tty_struct *tty)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 
 	schedule_work(&elm->tx_work);
 }
@@ -1067,7 +1067,7 @@ static int can327_ldisc_open(struct tty_struct *tty)
  */
 static void can327_ldisc_close(struct tty_struct *tty)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 
 	/* unregister_netdev() calls .ndo_stop() so we don't have to. */
 	unregister_candev(elm->dev);
@@ -1092,7 +1092,7 @@ static void can327_ldisc_close(struct tty_struct *tty)
 static int can327_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
 			      unsigned long arg)
 {
-	struct can327 *elm = (struct can327 *)tty->disc_data;
+	struct can327 *elm = tty->disc_data;
 	unsigned int tmp;
 
 	switch (cmd) {
-- 
2.41.0


