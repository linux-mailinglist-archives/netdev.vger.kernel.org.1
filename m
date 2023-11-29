Return-Path: <netdev+bounces-51964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97387FCCD0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FA6282EC0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127C2113;
	Wed, 29 Nov 2023 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mT/7QUL8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3381735
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FgPwUhLOyHmdWkCzp0z2sStlE+WaN2TGHG8NUnvxCo0=; b=mT/7QUL8dZl0t5+nDId7hxeWs+
	2Ji4ypBVYCzxn7TgOOO7Qhar7jGEUqpGgYB+9LygNf6/7OKfBlq9zKf7MHSlUuRzFrdzLbRst5M4d
	J1jMQwiQtdR4msMm9iIXtLlReC1J6DzRQ1lNwPajo50w08aIf77HMJVbGg5UHGY3THD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8A7c-001WFh-AB; Wed, 29 Nov 2023 03:16:16 +0100
Date: Wed, 29 Nov 2023 03:16:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 8/8] dsa: qca8k: Use DSA common code for LEDs
Message-ID: <53a2be7c-731c-4a27-87be-8c42b26ce9a4@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-9-andrew@lunn.ch>
 <65669a29.5d0a0220.19703.34e3@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65669a29.5d0a0220.19703.34e3@mx.google.com>

> Hi,
> 
> I attached a fixup patch for this to correctly work. Since we are using
> port_num the thing needs to be decrememted by one.

I thought this might happen.

How about this fix instead? It fits better with the naming of
parameters, and just does the offset once for each API function.

	    Andrew

From 0789b95345bfa5086365051f95531fdb3d053e3e Mon Sep 17 00:00:00 2001
From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 28 Nov 2023 20:11:42 -0600
Subject: [PATCH] dsa: qca8k: Fix off-by-one for LEDs.

---
 drivers/net/dsa/qca/qca8k-leds.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index febae23b65a9..0aa209b84251 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -80,9 +80,10 @@ qca8k_parse_netdev(unsigned long rules, u32 *offload_trigger)
 }
 
 int
-qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
+qca8k_led_brightness_set(struct dsa_switch *ds, int port,
 			 u8 led_num, enum led_brightness brightness)
 {
+	int port_num = qca8k_port_to_phy(port);
 	struct qca8k_led_pattern_en reg_info;
 	struct qca8k_priv *priv = ds->priv;
 	u32 mask, val;
@@ -140,11 +141,12 @@ qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
 }
 
 int
-qca8k_led_blink_set(struct dsa_switch *ds, int port_num, u8 led_num,
+qca8k_led_blink_set(struct dsa_switch *ds, int port, u8 led_num,
 		    unsigned long *delay_on,
 		    unsigned long *delay_off)
 {
 	u32 mask, val = QCA8K_LED_ALWAYS_BLINK_4HZ;
+	int port_num = qca8k_port_to_phy(port);
 	struct qca8k_led_pattern_en reg_info;
 	struct qca8k_priv *priv = ds->priv;
 
@@ -231,9 +233,10 @@ qca8k_led_hw_control_is_supported(struct dsa_switch *ds,
 }
 
 int
-qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
+qca8k_led_hw_control_set(struct dsa_switch *ds, int port, u8 led_num,
 			 unsigned long rules)
 {
+	int port_num = qca8k_port_to_phy(port);
 	struct qca8k_led_pattern_en reg_info;
 	struct qca8k_priv *priv = ds->priv;
 	u32 offload_trigger = 0;
@@ -255,9 +258,10 @@ qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
 }
 
 int
-qca8k_led_hw_control_get(struct dsa_switch *ds, int port_num, u8 led_num,
+qca8k_led_hw_control_get(struct dsa_switch *ds, int port, u8 led_num,
 			 unsigned long *rules)
 {
+	int port_num = qca8k_port_to_phy(port);
 	struct qca8k_led_pattern_en reg_info;
 	struct qca8k_priv *priv = ds->priv;
 	u32 val;
-- 
2.42.0


