Return-Path: <netdev+bounces-14652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF396742CED
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F041C20AF8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A314A94;
	Thu, 29 Jun 2023 19:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A79168AC
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4158C433C0;
	Thu, 29 Jun 2023 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065338;
	bh=ipR/74l5F674INPP/QBXNT0Bbn/pJfWAc7I2SMxpX4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZpmFlC661bkS5WB+5OpFHBaoxWcChiPKz4ge9AXAeKqSEwO8dwkCtMg3hA1biLcF
	 0mo2CRlx/NX3Z5V9rKjl63INqJz1BmO2xcps8lQUiHhdpqWavPZIQ5amXfHWoHR/d2
	 G33gL/4abETdFaaGxNRziBQyg8nE9uPEnoDSA5cvt1NIeOyF3smMdb7raUVlU7X3cX
	 ohS+qKQTNV7V++hgSLFfQQc9w2cnq1S4GeNoJT+S6q6u4BQRjDnFsjmWFD2p0KWxQ8
	 JePimmjRt4hJK2hRqdfNK1yLBUDaMr49oM9fFC9DyaY2n/yaP9cZ3bA6llKSYbE1xZ
	 7XvZ/iaUXtAlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Yasushi SHOJI <yashi@spacecubics.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	wg@grandegger.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mailhol.vincent@wanadoo.fr,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/5] can: mcba_usb: Fix termination command argument
Date: Thu, 29 Jun 2023 15:02:11 -0400
Message-Id: <20230629190212.908306-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190212.908306-1-sashal@kernel.org>
References: <20230629190212.908306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.248
Content-Transfer-Encoding: 8bit

From: Yasushi SHOJI <yasushi.shoji@gmail.com>

[ Upstream commit 1a8e3bd25f1e789c8154e11ea24dc3ec5a4c1da0 ]

Microchip USB Analyzer can activate the internal termination resistors
by setting the "termination" option ON, or OFF to to deactivate them.
As I've observed, both with my oscilloscope and captured USB packets
below, you must send "0" to turn it ON, and "1" to turn it OFF.

From the schematics in the user's guide, I can confirm that you must
drive the CAN_RES signal LOW "0" to activate the resistors.

Reverse the argument value of usb_msg.termination to fix this.

These are the two commands sequence, ON then OFF.

> No.     Time           Source                Destination           Protocol Length Info
>       1 0.000000       host                  1.3.1                 USB      46     URB_BULK out
>
> Frame 1: 46 bytes on wire (368 bits), 46 bytes captured (368 bits)
> USB URB
> Leftover Capture Data: a80000000000000000000000000000000000a8
>
> No.     Time           Source                Destination           Protocol Length Info
>       2 4.372547       host                  1.3.1                 USB      46     URB_BULK out
>
> Frame 2: 46 bytes on wire (368 bits), 46 bytes captured (368 bits)
> USB URB
> Leftover Capture Data: a80100000000000000000000000000000000a9

Signed-off-by: Yasushi SHOJI <yashi@spacecubics.com>
Link: https://lore.kernel.org/all/20221124152504.125994-1-yashi@spacecubics.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/mcba_usb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 957e51a77d4d1..16fb4fc265183 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -47,6 +47,10 @@
 #define MCBA_VER_REQ_USB 1
 #define MCBA_VER_REQ_CAN 2
 
+/* Drive the CAN_RES signal LOW "0" to activate R24 and R25 */
+#define MCBA_VER_TERMINATION_ON 0
+#define MCBA_VER_TERMINATION_OFF 1
+
 #define MCBA_SIDL_EXID_MASK 0x8
 #define MCBA_DLC_MASK 0xf
 #define MCBA_DLC_RTR_MASK 0x40
@@ -469,7 +473,7 @@ static void mcba_usb_process_ka_usb(struct mcba_priv *priv,
 		priv->usb_ka_first_pass = false;
 	}
 
-	if (msg->termination_state)
+	if (msg->termination_state == MCBA_VER_TERMINATION_ON)
 		priv->can.termination = MCBA_TERMINATION_ENABLED;
 	else
 		priv->can.termination = MCBA_TERMINATION_DISABLED;
@@ -789,9 +793,9 @@ static int mcba_set_termination(struct net_device *netdev, u16 term)
 	};
 
 	if (term == MCBA_TERMINATION_ENABLED)
-		usb_msg.termination = 1;
+		usb_msg.termination = MCBA_VER_TERMINATION_ON;
 	else
-		usb_msg.termination = 0;
+		usb_msg.termination = MCBA_VER_TERMINATION_OFF;
 
 	mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
 
-- 
2.39.2


