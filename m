Return-Path: <netdev+bounces-51907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877B7FCABC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792961C20E52
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FE57338;
	Tue, 28 Nov 2023 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="svhbgDuU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C765218E
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y7BJgw6tzMjYKoQXttp7oQOhMClfXBGm4j8xDRnuBec=; b=svhbgDuUwvEmTCYI/nKXwurzd0
	qjNUz5pG2D1Ddwhm25a4kCCN3Yr7lG0w625uT6zzAJbMXQRxgLded17nFk1EXK39TvKV+q8lsccTW
	4Y5Z8nMSt+vvNICzE0fWDs1WlMZhsg1CS5jcOor9AjkStva0Go58rzwc9c7BEA2NKpqM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VJ8-Lu; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 5/8] dsa: Plumb in LED calls needed for hardware offload
Date: Wed, 29 Nov 2023 00:21:32 +0100
Message-Id: <20231128232135.358638-6-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to offload blinking of the LED to hardware, additional calls
are needed into the LED driver. Add them to the DSA core abstraction.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/dsa.h |  6 +++++
 net/dsa/dsa.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 2e05e4fd0b76..19f1338ac604 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1249,6 +1249,12 @@ struct dsa_switch_ops {
 				  u8 led, enum led_brightness value);
 	int (*led_blink_set)(struct dsa_switch *ds, int port, u8 led,
 			     unsigned long *delay_on, unsigned long *delay_off);
+	int (*led_hw_control_is_supported)(struct dsa_switch *ds, int port,
+					   u8 led, unsigned long flags);
+	int (*led_hw_control_set)(struct dsa_switch *ds, int port, u8 led,
+				  unsigned long flags);
+	int (*led_hw_control_get)(struct dsa_switch *ds, int port, u8 led,
+				  unsigned long *flags);
 };
 
 #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index b13748f9b519..16e51020bc5e 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -492,6 +492,52 @@ static int dsa_led_blink_set(struct led_classdev *led_cdev,
 				      delay_on, delay_off);
 }
 
+static __maybe_unused int
+dsa_led_hw_control_is_supported(struct led_classdev *led_cdev,
+				unsigned long flags)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->led_hw_control_is_supported(ds, dp->index,
+						    dsa_led->index,
+						    flags);
+}
+
+static __maybe_unused int dsa_led_hw_control_set(struct led_classdev *led_cdev,
+						 unsigned long flags)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->led_hw_control_set(ds, dp->index, dsa_led->index,
+					   flags);
+}
+
+static __maybe_unused int dsa_led_hw_control_get(struct led_classdev *led_cdev,
+						 unsigned long *flags)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+	struct dsa_switch *ds = dp->ds;
+
+	return ds->ops->led_hw_control_get(ds, dp->index, dsa_led->index,
+					   flags);
+}
+
+static struct device *
+dsa_led_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct dsa_led *dsa_led = to_dsa_led(led_cdev);
+	struct dsa_port *dp = dsa_led->dp;
+
+	if (dp->user)
+		return &dp->user->dev;
+	return NULL;
+}
+
 static int dsa_port_led_setup(struct dsa_port *dp,
 			      struct device_node *led)
 {
@@ -521,7 +567,16 @@ static int dsa_port_led_setup(struct dsa_port *dp,
 		cdev->brightness_set_blocking = dsa_led_brightness_set;
 	if (ds->ops->led_blink_set)
 		cdev->blink_set = dsa_led_blink_set;
-
+#ifdef CONFIG_LEDS_TRIGGERS
+	if (ds->ops->led_hw_control_is_supported)
+		cdev->hw_control_is_supported = dsa_led_hw_control_is_supported;
+	if (ds->ops->led_hw_control_set)
+		cdev->hw_control_set = dsa_led_hw_control_set;
+	if (ds->ops->led_hw_control_get)
+		cdev->hw_control_get = dsa_led_hw_control_get;
+	cdev->hw_control_trigger = "netdev";
+#endif
+	cdev->hw_control_get_device = dsa_led_hw_control_get_device;
 	cdev->max_brightness = 1;
 
 	init_data.fwnode = of_fwnode_handle(led);
-- 
2.42.0


