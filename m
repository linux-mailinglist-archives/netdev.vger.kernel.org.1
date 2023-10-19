Return-Path: <netdev+bounces-42823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5C47D03C8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC45B21615
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C33E003;
	Thu, 19 Oct 2023 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mJKT236v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CE3DFFE
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 21:22:22 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67216170F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:22:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1caad0bcc95so966905ad.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750522; x=1698355322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnNGbLW7qt7iCk7mMHGMAddsK60XJWuQhT2YB53euOU=;
        b=mJKT236vCiZInq58GSZUUNJTwGBDT/NiD/sCiCfQm0zYT4U2Z/pz85LnVHXM3GPIyr
         Ddfs/8LqksWxLTeoaLFz7duQwqTgZFrp2tIPVs+K+2YwgDAoLMTWvCRZuPBQSmL+WbP/
         ZGoQqxkN2LiQDvzAI6u97yruxs/gCvK/awSgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750522; x=1698355322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnNGbLW7qt7iCk7mMHGMAddsK60XJWuQhT2YB53euOU=;
        b=G9IiHSBUhkGfL613+pt2FA9WDb6emLtn7vVgQfIFjzVpsG1uvFC+N5F0IdXjpWuoXd
         mqJ9fIoLAHSbqLouoRDAekVq0iknLoBd9R6VUDll0RI+KmqPvRRWfTvavjnzOtoru7k6
         dsUbJ/94mpO4c4Lxz51doAU8nvQ49Icw8UAD/qqBaLBou0W0iZOXgCsUzg2KqzICMnjB
         yfwWyPyjjavmZiYVhAKHIrbCCkN6uN6irKOa0EpXDTcQrW151u01znyWBor4UlVjBRqa
         IUPAI4tB26J6vS9mKg0OMEseotGDCtygB68Yh9PhcxtBQM0C/vLSZZCLM3GHX3OX/eq7
         zNDA==
X-Gm-Message-State: AOJu0Yw1fYyhWml01P9PVecY8lu+zBjn1gJmiNS1NCv4PMsqZ/Pdgxmm
	eKkeUyZcuXA4T0uUnwZtaHjU1MiQkkJvpLx/3TlFHQ==
X-Google-Smtp-Source: AGHT+IF3bXxPSJdrhl6bqlgbIwKci6c60kHargJ7UbbdQB+/jGmwBcV1dYWXAVIQRmJ86ZukAT2PUQ==
X-Received: by 2002:a17:902:e887:b0:1c6:3222:c67c with SMTP id w7-20020a170902e88700b001c63222c67cmr115595plg.23.1697750522398;
        Thu, 19 Oct 2023 14:22:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:22:01 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	linux-usb@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 4/5] r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
Date: Thu, 19 Oct 2023 14:20:23 -0700
Message-ID: <20231019142019.v4.4.Iaacab4e73761e7bd9bb622b30a804c5d20bd5b4c@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019212130.3146151-1-dianders@chromium.org>
References: <20231019212130.3146151-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever the RTL8152_UNPLUG is set that just tells the driver that all
accesses will fail and we should just immediately bail. A future patch
will use this same concept at a time when the driver hasn't actually
been unplugged but is about to be reset. Rename the flag in
preparation for the future patch.

This is a no-op change and just a search and replace.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE") new for v2.

 drivers/net/usb/r8152.c | 96 ++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 888d3884821e..151c3c383080 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -764,7 +764,7 @@ enum rtl_register_content {
 
 /* rtl8152 flags */
 enum rtl8152_flags {
-	RTL8152_UNPLUG = 0,
+	RTL8152_INACCESSIBLE = 0,
 	RTL8152_SET_RX_MODE,
 	WORK_ENABLE,
 	RTL8152_LINK_CHG,
@@ -1245,7 +1245,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 static void rtl_set_unplug(struct r8152 *tp)
 {
 	if (tp->udev->state == USB_STATE_NOTATTACHED) {
-		set_bit(RTL8152_UNPLUG, &tp->flags);
+		set_bit(RTL8152_INACCESSIBLE, &tp->flags);
 		smp_mb__after_atomic();
 	}
 }
@@ -1256,7 +1256,7 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
 	u16 limit = 64;
 	int ret = 0;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	/* both size and indix must be 4 bytes align */
@@ -1300,7 +1300,7 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 	u16 byteen_start, byteen_end, byen;
 	u16 limit = 512;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	/* both size and indix must be 4 bytes align */
@@ -1537,7 +1537,7 @@ static int read_mii_word(struct net_device *netdev, int phy_id, int reg)
 	struct r8152 *tp = netdev_priv(netdev);
 	int ret;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	if (phy_id != R8152_PHY_ID)
@@ -1553,7 +1553,7 @@ void write_mii_word(struct net_device *netdev, int phy_id, int reg, int val)
 {
 	struct r8152 *tp = netdev_priv(netdev);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (phy_id != R8152_PHY_ID)
@@ -1758,7 +1758,7 @@ static void read_bulk_callback(struct urb *urb)
 	if (!tp)
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!test_bit(WORK_ENABLE, &tp->flags))
@@ -1850,7 +1850,7 @@ static void write_bulk_callback(struct urb *urb)
 	if (!test_bit(WORK_ENABLE, &tp->flags))
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!skb_queue_empty(&tp->tx_queue))
@@ -1871,7 +1871,7 @@ static void intr_callback(struct urb *urb)
 	if (!test_bit(WORK_ENABLE, &tp->flags))
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	switch (status) {
@@ -2615,7 +2615,7 @@ static void bottom_half(struct tasklet_struct *t)
 {
 	struct r8152 *tp = from_tasklet(tp, t, tx_tl);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!test_bit(WORK_ENABLE, &tp->flags))
@@ -2658,7 +2658,7 @@ int r8152_submit_rx(struct r8152 *tp, struct rx_agg *agg, gfp_t mem_flags)
 	int ret;
 
 	/* The rx would be stopped, so skip submitting */
-	if (test_bit(RTL8152_UNPLUG, &tp->flags) ||
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
 	    !test_bit(WORK_ENABLE, &tp->flags) || !netif_carrier_ok(tp->netdev))
 		return 0;
 
@@ -3058,7 +3058,7 @@ static int rtl_enable(struct r8152 *tp)
 
 static int rtl8152_enable(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -3145,7 +3145,7 @@ static int rtl8153_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -3177,7 +3177,7 @@ static void rtl_disable(struct r8152 *tp)
 	u32 ocp_data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -3631,7 +3631,7 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 		}
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -3663,7 +3663,7 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
@@ -3705,7 +3705,7 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
@@ -4050,8 +4050,8 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
-			break;
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
@@ -6009,7 +6009,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	u32 ocp_data;
 	u16 speed;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	r8156_fc_parameter(tp);
@@ -6067,7 +6067,7 @@ static int rtl8156b_enable(struct r8152 *tp)
 	u32 ocp_data;
 	u16 speed;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -6253,7 +6253,7 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 static void rtl8152_up(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8152_aldps_en(tp, false);
@@ -6263,7 +6263,7 @@ static void rtl8152_up(struct r8152 *tp)
 
 static void rtl8152_down(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6278,7 +6278,7 @@ static void rtl8153_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
@@ -6318,7 +6318,7 @@ static void rtl8153_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6339,7 +6339,7 @@ static void rtl8153b_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6363,7 +6363,7 @@ static void rtl8153b_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6400,7 +6400,7 @@ static void rtl8153c_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6481,7 +6481,7 @@ static void rtl8156_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6554,7 +6554,7 @@ static void rtl8156_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6692,7 +6692,7 @@ static void rtl_work_func_t(struct work_struct *work)
 	/* If the device is unplugged or !netif_running(), the workqueue
 	 * doesn't need to wake the device, and could return directly.
 	 */
-	if (test_bit(RTL8152_UNPLUG, &tp->flags) || !netif_running(tp->netdev))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) || !netif_running(tp->netdev))
 		return;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -6731,7 +6731,7 @@ static void rtl_hw_phy_work_func_t(struct work_struct *work)
 {
 	struct r8152 *tp = container_of(work, struct r8152, hw_phy_work.work);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -6858,7 +6858,7 @@ static int rtl8152_close(struct net_device *netdev)
 	netif_stop_queue(netdev);
 
 	res = usb_autopm_get_interface(tp->intf);
-	if (res < 0 || test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (res < 0 || test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		rtl_stop_rx(tp);
 	} else {
@@ -6891,7 +6891,7 @@ static void r8152b_init(struct r8152 *tp)
 	u32 ocp_data;
 	u16 data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	data = r8152_mdio_read(tp, MII_BMCR);
@@ -6935,7 +6935,7 @@ static void r8153_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
@@ -6946,7 +6946,7 @@ static void r8153_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -7075,7 +7075,7 @@ static void r8153b_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -7086,7 +7086,7 @@ static void r8153b_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -7157,7 +7157,7 @@ static void r8153c_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -7177,7 +7177,7 @@ static void r8153c_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -8006,7 +8006,7 @@ static void r8156_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
@@ -8027,7 +8027,7 @@ static void r8156_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -8102,7 +8102,7 @@ static void r8156b_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
@@ -8136,7 +8136,7 @@ static void r8156b_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -9165,7 +9165,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 	struct mii_ioctl_data *data = if_mii(rq);
 	int res;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	res = usb_autopm_get_interface(tp->intf);
@@ -9267,7 +9267,7 @@ static const struct net_device_ops rtl8152_netdev_ops = {
 
 static void rtl8152_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (tp->version != RTL_VER_01)
@@ -9276,7 +9276,7 @@ static void rtl8152_unload(struct r8152 *tp)
 
 static void rtl8153_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_power_cut_en(tp, false);
@@ -9284,7 +9284,7 @@ static void rtl8153_unload(struct r8152 *tp)
 
 static void rtl8153b_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_power_cut_en(tp, false);
-- 
2.42.0.758.gaed0368e0e-goog


