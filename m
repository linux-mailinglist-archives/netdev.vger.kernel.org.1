Return-Path: <netdev+bounces-55577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8912380B6E5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 23:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FA1B209C5
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 22:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E891E53F;
	Sat,  9 Dec 2023 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BszDxU8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3F126
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 14:37:43 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso4270828e87.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702161462; x=1702766262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqJRFlwxsfiVKyDlwfpoYMdqM7isSkg6QDTGbvkMOH0=;
        b=BszDxU8Wpl8nlxDglINRoTOtCfbb/hdgTg/39s+m1ViWqkdNK5wTAd4qbOZRRdE52n
         OlTRYX9uZqKF+qUrj2gyzYUhSzzRAjRByT8YQD6ljCui4BUW4R0vV4ySgauAl0Ez1uS0
         fAUVza67HWvBVjRZnlSvhDLBJRbjF6GkPehlkpTwJjHqzwM7V2dckcqWxppITFcp1/W/
         30iagF5RrA2J/RMEN+1JtU6alKNGo7UuL6X7M8lXjbNNNN38r1dloXmgEb9qwMy9fNBx
         gHirf9FVide5eMcQq/THycjEtzyO2uL86fm5fVRivNktBJbuXk3fHmafhAR+3Pmvuhv7
         KZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702161462; x=1702766262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqJRFlwxsfiVKyDlwfpoYMdqM7isSkg6QDTGbvkMOH0=;
        b=K59FiJrhjQ9S6UrqFkE0JnIWecDOPihOdCLsFm245kuK45RMjJEIIFuJGOKKiAM+Lx
         9TW3YIeXkHNjYawF5gQR9qTutksVlF7breHzuZ2cBlAS/ypqAjSccIUgp0cmd0pFFF79
         K1o5IxJ8OhLTk3MOqtLu9nBqRWQQQEaFj7Dciel1IMy1x8fe1ZhyTqKYLy9l2tPLMX40
         TbLcUJcDaR50Qt+vDiKJgesukYng8+OrsuB0sC/kpnwTqhIObHaKm5L7okXsq8tzQxrK
         DEwRW2F6s7rtNqu+cRV99VeptOWoEcFgiALAq6JQ3ZPvf0LjEDsuurfRnk2gxIluvvSL
         ozHQ==
X-Gm-Message-State: AOJu0Yx3ymJxF5DKp7EUNhyJkKBQ4tRYfbHNJWttfmdz3bSEt/R5AmX3
	yiUNL7Ki4FuV+k+VegwuSrWnCzaWhaee0DZFDEY=
X-Google-Smtp-Source: AGHT+IH40BZK1HEjvA3VyzPIsuHG7CAeX/jb9pd77hPNv6lRZ9pxiSVZfi/TZ0DpHeizvfJHvRC5mQ==
X-Received: by 2002:a05:6512:1598:b0:50d:1a0e:c94a with SMTP id bp24-20020a056512159800b0050d1a0ec94amr863093lfb.0.1702161461881;
        Sat, 09 Dec 2023 14:37:41 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050c0c46e1desm634885lfb.33.2023.12.09.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:37:41 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 09 Dec 2023 23:37:35 +0100
Subject: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
To: =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The MTU callbacks are in layer 1 size, so for example 1500
bytes is a normal setting. Cache this size, and only add
the layer 2 framing right before choosing the setting. On
the CPU port this will however include the DSA tag since
this is transmitted from the parent ethernet interface!

Add the layer 2 overhead such as ethernet and VLAN framing
and FCS before selecting the size in the register.

This will make the code easier to understand.

The rtl8366rb_max_mtu() callback returns a bogus MTU
just subtracting the CPU tag, which is the only thing
we should NOT subtract. Return the correct layer 1
max MTU after removing headers and checksum.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 48 +++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 887afd1392cb..e3b6a470ca67 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
@@ -929,15 +930,19 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Set maximum packet length to 1536 bytes */
+	/* Set default maximum packet length to 1536 bytes */
 	ret = regmap_update_bits(priv->map, RTL8366RB_SGCR,
 				 RTL8366RB_SGCR_MAX_LENGTH_MASK,
 				 RTL8366RB_SGCR_MAX_LENGTH_1536);
 	if (ret)
 		return ret;
-	for (i = 0; i < RTL8366RB_NUM_PORTS; i++)
-		/* layer 2 size, see rtl8366rb_change_mtu() */
-		rb->max_mtu[i] = 1532;
+	for (i = 0; i < RTL8366RB_NUM_PORTS; i++) {
+		if (i == priv->cpu_port)
+			/* CPU port need to also accept the tag */
+			rb->max_mtu[i] = ETH_DATA_LEN + RTL8366RB_CPU_TAG_SIZE;
+		else
+			rb->max_mtu[i] = ETH_DATA_LEN;
+	}
 
 	/* Disable learning for all ports */
 	ret = regmap_write(priv->map, RTL8366RB_PORT_LEARNDIS_CTRL,
@@ -1442,24 +1447,29 @@ static int rtl8366rb_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	/* Roof out the MTU for the entire switch to the greatest
 	 * common denominator: the biggest set for any one port will
 	 * be the biggest MTU for the switch.
-	 *
-	 * The first setting, 1522 bytes, is max IP packet 1500 bytes,
-	 * plus ethernet header, 1518 bytes, plus CPU tag, 4 bytes.
-	 * This function should consider the parameter an SDU, so the
-	 * MTU passed for this setting is 1518 bytes. The same logic
-	 * of subtracting the DSA tag of 4 bytes apply to the other
-	 * settings.
 	 */
-	max_mtu = 1518;
+	max_mtu = ETH_DATA_LEN;
 	for (i = 0; i < RTL8366RB_NUM_PORTS; i++) {
 		if (rb->max_mtu[i] > max_mtu)
 			max_mtu = rb->max_mtu[i];
 	}
-	if (max_mtu <= 1518)
+
+	/* Translate to layer 2 size.
+	 * Add ethernet and (possible) VLAN headers, and checksum to the size.
+	 * For ETH_DATA_LEN (1500 bytes) this will add up to 1522 bytes.
+	 */
+	max_mtu += VLAN_ETH_HLEN;
+	max_mtu += ETH_FCS_LEN;
+
+	if (max_mtu <= 1522)
 		len = RTL8366RB_SGCR_MAX_LENGTH_1522;
-	else if (max_mtu > 1518 && max_mtu <= 1532)
+	else if (max_mtu > 1522 && max_mtu <= 1536)
+		/* This will be the most common default if using VLAN and
+		 * CPU tagging on a port as both VLAN and CPU tag will
+		 * result in 1518 + 4 + 4 = 1526 bytes.
+		 */
 		len = RTL8366RB_SGCR_MAX_LENGTH_1536;
-	else if (max_mtu > 1532 && max_mtu <= 1548)
+	else if (max_mtu > 1536 && max_mtu <= 1552)
 		len = RTL8366RB_SGCR_MAX_LENGTH_1552;
 	else
 		len = RTL8366RB_SGCR_MAX_LENGTH_16000;
@@ -1471,10 +1481,12 @@ static int rtl8366rb_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 static int rtl8366rb_max_mtu(struct dsa_switch *ds, int port)
 {
-	/* The max MTU is 16000 bytes, so we subtract the CPU tag
-	 * and the max presented to the system is 15996 bytes.
+	/* The max MTU is 16000 bytes, so we subtract the ethernet
+	 * headers with VLAN and checksum and arrive at
+	 * 16000 - 18 - 4 = 15978. This does not include the CPU tag
+	 * since that is added to the requested MTU by the DSA framework.
 	 */
-	return 15996;
+	return 16000 - VLAN_ETH_HLEN - ETH_FCS_LEN;
 }
 
 static int rtl8366rb_get_vlan_4k(struct realtek_priv *priv, u32 vid,

-- 
2.34.1


