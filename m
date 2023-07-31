Return-Path: <netdev+bounces-22727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B55768F71
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818DF1C20B42
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCFE8485;
	Mon, 31 Jul 2023 08:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6C11C84
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEAAC43395;
	Mon, 31 Jul 2023 08:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690790577;
	bh=t10N72oEfrdWvctrgvxTa70mihQMypTsXP5is3fxQas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFMtHrIhFzDSxjMCDs1WdZHEIKSx1+VX1YOY/dFgDZvmbzMGfH3RP0d+HhZhoU19t
	 hZlT/E0OjVoFFCdn2M8gZRsVrZNFE2xg83Ly7od1GPm5C1479rkTdgj2CLZwfW4StB
	 Twg4NRjSSaCFE4FsvZnKpqxXBAEeeD+q1lGqu2NjPqo2pBNKFOQ5tJgchlY82DRpY/
	 y7G0cT1PMK0AtF+xJ/BnB89INOyuzs3Ym2JPcAl0VlkWU7chVbYhaAI4cIrdI563VT
	 p2H/YQNsB5sSXBMzPudyFIfUmPr6nK0XXZhNJbJcf8VxCiGpnxOSlqz7nQVXFZT6aP
	 dJpIUIMMVM3Cw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 05/10] can: slcan: remove casts from tty->disc_data
Date: Mon, 31 Jul 2023 10:02:39 +0200
Message-ID: <20230731080244.2698-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
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
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/can/slcan/slcan-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index f4db77007c13..371af9d17b14 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -583,7 +583,7 @@ static void slcan_transmit(struct work_struct *work)
  */
 static void slcan_write_wakeup(struct tty_struct *tty)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	schedule_work(&sl->tx_work);
 }
@@ -778,7 +778,7 @@ static void slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, const char *fp,
 			      int count)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	if (!netif_running(sl->dev))
 		return;
@@ -862,7 +862,7 @@ static int slcan_open(struct tty_struct *tty)
  */
 static void slcan_close(struct tty_struct *tty)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 
 	unregister_candev(sl->dev);
 
@@ -886,7 +886,7 @@ static void slcan_close(struct tty_struct *tty)
 static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
-	struct slcan *sl = (struct slcan *)tty->disc_data;
+	struct slcan *sl = tty->disc_data;
 	unsigned int tmp;
 
 	switch (cmd) {
-- 
2.41.0


