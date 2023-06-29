Return-Path: <netdev+bounces-14657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D6F742CF2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1273F1C20935
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC56171A4;
	Thu, 29 Jun 2023 19:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B76171D8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FAEC433C0;
	Thu, 29 Jun 2023 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065349;
	bh=ZkpfVTv8FpSPMVgbkEwlj5m42xAIAHcl3ktcgmQASTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6An4/QNuIKOba8mLWi1MbPo4FAVpYZCey6JEhG55GPrU5ldT15d1WNdKqyh7VWD5
	 cejuCSHHdqYMEvSFQxRlh+H95xBk5Pc0ayb47SYCRZGgbhCfbD7Z44bR937orswquc
	 z3XbHguu/+eTgTXgP945UHogBdBXLekFHPPIdSH+60Sr8z+wnr+RKog3OtDHwh/8pO
	 JhykmPAwL84GOkyUcJRfQA6UAKtQmNuKBMKcpyCbeiQTOAbPyNHjW8nrgi3HC1OuGS
	 Qectq0j9PKz+uWwFLoa5Gu76B0fnXAnCqHKTwakvXaTqzOZZ3HKkVmRcuO8Vg4g8Qu
	 amE+JH159I7nQ==
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
Subject: [PATCH AUTOSEL 4.14 3/4] can: mcba_usb: Fix termination command argument
Date: Thu, 29 Jun 2023 15:02:23 -0400
Message-Id: <20230629190225.908451-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190225.908451-1-sashal@kernel.org>
References: <20230629190225.908451-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.319
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
index f7c3fc3dabfe4..01ef5cabdc11e 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -58,6 +58,10 @@
 #define MCBA_VER_REQ_USB 1
 #define MCBA_VER_REQ_CAN 2
 
+/* Drive the CAN_RES signal LOW "0" to activate R24 and R25 */
+#define MCBA_VER_TERMINATION_ON 0
+#define MCBA_VER_TERMINATION_OFF 1
+
 #define MCBA_SIDL_EXID_MASK 0x8
 #define MCBA_DLC_MASK 0xf
 #define MCBA_DLC_RTR_MASK 0x40
@@ -480,7 +484,7 @@ static void mcba_usb_process_ka_usb(struct mcba_priv *priv,
 		priv->usb_ka_first_pass = false;
 	}
 
-	if (msg->termination_state)
+	if (msg->termination_state == MCBA_VER_TERMINATION_ON)
 		priv->can.termination = MCBA_TERMINATION_ENABLED;
 	else
 		priv->can.termination = MCBA_TERMINATION_DISABLED;
@@ -800,9 +804,9 @@ static int mcba_set_termination(struct net_device *netdev, u16 term)
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


