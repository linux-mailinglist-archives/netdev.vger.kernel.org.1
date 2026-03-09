Return-Path: <netdev+bounces-265654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIcdEqD+rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:08:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB623D5F0
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECFDC3026BCE
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A128CF6F;
	Mon,  9 Mar 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6+tR9FP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73A295DAC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075764; cv=none; b=pNfVmue30Hl9997uOKd+llf6jjeTDFH/KQdHXXJ0IgL5PnxwOPycPiOUBA5mU+lIYBVX/BQZ0xdyHSX3MSa5mz8hLvPMciDSi0TT7gJeCoEclIQz6nSvdf4jd3UMD8Hg6JybUp8vdyESD/h90eQw2RRlkAigiYZ4+nakpM0ZyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075764; c=relaxed/simple;
	bh=THA3bSVQzv73wv2LgwqQEn2CkXKfTFif1AVKB23g0Uc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X5RLdooXNSCMT35TDj6EzWMkR1m4KcK60Vts9DP5/oapgX2/cJBpI6wrYjtQJ198/Rd8o2cpR3nciNwMsIINRmiZSbFZLWNtlv5bxnv5GATu0kB2vuho+z1m1NKoEAPWM50pqzY3nvWCO186n76XaKFiugzGozgY+kAPuoSTsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6+tR9FP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so13704705e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075761; x=1773680561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D3yVBrm0NO/kyrzRjsGOfgFPVCo6bv+SX/DHuerXF6U=;
        b=G6+tR9FPfBiGoF9CdAI4+Zh6kAkcG/QMRUoKI3s7cSTDZuU/Cl8bTZBERPGh4G8Oq+
         eqRrBwICvug+mbLsVxx2pDjupDyLhQpx+bDaYnNDRYWT+TEzNYyJdPdlz7n5E/n8B2nZ
         1mR7igbX1Pu1p6T7RZdgqt57IlrGswjpXZB4erz9tbfgjwNUvDtKJAxNkbbUtuMXB29T
         8YPbjw0NHZbYoMe+Us2BPvpDxik204vxm3Zeq6xCI8Ftg9PDq2Kvj6/U6D7ZBCqg942l
         VAV+X00UvXv6/9eH/yDWsgFZ3Ra3m/Jj6VWsMwcavrc3dV9/hnJqwe7F0vfxDfhIHhGm
         bqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075761; x=1773680561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3yVBrm0NO/kyrzRjsGOfgFPVCo6bv+SX/DHuerXF6U=;
        b=VqN135Dxt08calqox/YKS5hIwHqUrcxWZ1dLgCKMg/W+SsM3sQdITz94FfkTspql8z
         OZufX4/lALkvNedKYXB5zCqOo4bfqMOr156TK63jHTh2ctOfIFAbRLgYQnMKGJoftHIA
         9i6RwhFjExyo0Z2r3CIB3r6BLcYPr65wrD8P0IprhhX2Q849yAtKqEMKXrd4vEGEcrEM
         0XgD6lCQJfwWFNDqkebVAfeFQZ6LA4AU9Wjeyh41m08vkTiBO7yE4SOibi0Ho5aKXjci
         gyPPiidkubNAAPFfsiAkVlK08vLmc1px2kaP0HYLXjn8j9Lrj8Xtp98n8tqcM3f/JNTQ
         +/oA==
X-Gm-Message-State: AOJu0Yx6156W2GvJqfz4TuId/6ByBfn3vAwgD5NEz9S8yFaKgah3O4A0
	3uYOO5Cfu/Y/dQFioH8/+ggxkWqM7v7PLQjClmkXdn05sCuev/+WQMiO
X-Gm-Gg: ATEYQzxI8qM1lnp0kXKf9jeTuET1EKxjxTj+HQk0uuGnhOH0zAXzXFSsjuMHBV0d6/2
	vc+pj9e5TXBWwmB5O2h3TE8hrZpACvl9tXQlH9CllsP9crIJS7e+4gU6piDFt2QSSsL9BmVUmaA
	IxbLnB2aj4Tar7teqqmhYskVCVunY6nuivGqcjfWGgqHM9T1IWCaaWAuwoh0m5KKl9hR3PShVOi
	YPRwAfUwDuCghjutt9MQNx7+ZlyBiO7sEiLFJXKx7mV/LBXOfskLqAogMOII4cMyUTXZEWkOhFE
	tGeyqOpQMvTfJVJ+OcntbIYSjp99lq6QP4sOUp4ntg/eIBSPTyhVRV1/5WJM5oun7qZ1dlrHgxQ
	QjR73POz3vGm35ZynCkk9XfVH5nkxWZhGsbn60phzIQ06MJviGrqBhI3zC1O4KtxBf7yNOqd029
	PJDpEzXbEN3132PwbSpFrIrUFAodrd7+IGII8h8ma0Azurpjs0JwR5dJItPOoFQv7oJjNCMK/UZ
	XHMLCOFGCsVcH648tSY/4GsVxTn7sxwBl+ODM2SMhPnclGoZaQmF3cydNQYAE10g7yycHy1YA==
X-Received: by 2002:a05:600c:3b0c:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-485269188admr199557965e9.5.1773075760400;
        Mon, 09 Mar 2026 10:02:40 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d? (p200300ea8f46ce0005f97f3c5f9a2a3d.dip0.t-ipconnect.de. [2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aacd81sm4246225e9.14.2026.03.09.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:02:40 -0700 (PDT)
Message-ID: <8ea1a929-33b8-49ee-afe6-355f5a7d2bd1@gmail.com>
Date: Mon, 9 Mar 2026 18:02:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 1/5] net: phy: move mdio_device reset handling
 functions in the code
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Language: en-US
In-Reply-To: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CEB623D5F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.808];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

In preparation of a follow-up patch this moves reset-related functions
in the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_device.c | 162 +++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index b8a5a183819..da4fb7484c7 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -24,6 +24,87 @@
 #include <linux/property.h>
 #include "mdio-private.h"
 
+/**
+ * mdio_device_register_reset - Read and initialize the reset properties of
+ *				an mdio device
+ * @mdiodev: mdio_device structure
+ *
+ * Return: Zero if successful, negative error code on failure
+ */
+int mdio_device_register_reset(struct mdio_device *mdiodev)
+{
+	struct reset_control *reset;
+
+	/* Deassert the optional reset signal */
+	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
+						 "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(mdiodev->reset_gpio))
+		return PTR_ERR(mdiodev->reset_gpio);
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset)) {
+		gpiod_put(mdiodev->reset_gpio);
+		mdiodev->reset_gpio = NULL;
+		return PTR_ERR(reset);
+	}
+
+	mdiodev->reset_ctrl = reset;
+
+	/* Read optional firmware properties */
+	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
+				 &mdiodev->reset_assert_delay);
+	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
+				 &mdiodev->reset_deassert_delay);
+
+	return 0;
+}
+
+/**
+ * mdio_device_unregister_reset - uninitialize the reset properties of
+ *				  an mdio device
+ * @mdiodev: mdio_device structure
+ */
+void mdio_device_unregister_reset(struct mdio_device *mdiodev)
+{
+	gpiod_put(mdiodev->reset_gpio);
+	mdiodev->reset_gpio = NULL;
+	reset_control_put(mdiodev->reset_ctrl);
+	mdiodev->reset_ctrl = NULL;
+	mdiodev->reset_assert_delay = 0;
+	mdiodev->reset_deassert_delay = 0;
+}
+
+void mdio_device_reset(struct mdio_device *mdiodev, int value)
+{
+	unsigned int d;
+
+	if (!mdiodev->reset_gpio && !mdiodev->reset_ctrl)
+		return;
+
+	if (mdiodev->reset_state == value)
+		return;
+
+	if (mdiodev->reset_gpio)
+		gpiod_set_value_cansleep(mdiodev->reset_gpio, value);
+
+	if (mdiodev->reset_ctrl) {
+		if (value)
+			reset_control_assert(mdiodev->reset_ctrl);
+		else
+			reset_control_deassert(mdiodev->reset_ctrl);
+	}
+
+	d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;
+	if (d)
+		fsleep(d);
+
+	mdiodev->reset_state = value;
+}
+EXPORT_SYMBOL(mdio_device_reset);
+
 void mdio_device_free(struct mdio_device *mdiodev)
 {
 	put_device(&mdiodev->dev);
@@ -108,87 +189,6 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
-/**
- * mdio_device_register_reset - Read and initialize the reset properties of
- *				an mdio device
- * @mdiodev: mdio_device structure
- *
- * Return: Zero if successful, negative error code on failure
- */
-int mdio_device_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
-	/* Deassert the optional reset signal */
-	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
-						 "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(mdiodev->reset_gpio))
-		return PTR_ERR(mdiodev->reset_gpio);
-
-	if (mdiodev->reset_gpio)
-		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
-
-	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
-	if (IS_ERR(reset)) {
-		gpiod_put(mdiodev->reset_gpio);
-		mdiodev->reset_gpio = NULL;
-		return PTR_ERR(reset);
-	}
-
-	mdiodev->reset_ctrl = reset;
-
-	/* Read optional firmware properties */
-	device_property_read_u32(&mdiodev->dev, "reset-assert-us",
-				 &mdiodev->reset_assert_delay);
-	device_property_read_u32(&mdiodev->dev, "reset-deassert-us",
-				 &mdiodev->reset_deassert_delay);
-
-	return 0;
-}
-
-/**
- * mdio_device_unregister_reset - uninitialize the reset properties of
- *				  an mdio device
- * @mdiodev: mdio_device structure
- */
-void mdio_device_unregister_reset(struct mdio_device *mdiodev)
-{
-	gpiod_put(mdiodev->reset_gpio);
-	mdiodev->reset_gpio = NULL;
-	reset_control_put(mdiodev->reset_ctrl);
-	mdiodev->reset_ctrl = NULL;
-	mdiodev->reset_assert_delay = 0;
-	mdiodev->reset_deassert_delay = 0;
-}
-
-void mdio_device_reset(struct mdio_device *mdiodev, int value)
-{
-	unsigned int d;
-
-	if (!mdiodev->reset_gpio && !mdiodev->reset_ctrl)
-		return;
-
-	if (mdiodev->reset_state == value)
-		return;
-
-	if (mdiodev->reset_gpio)
-		gpiod_set_value_cansleep(mdiodev->reset_gpio, value);
-
-	if (mdiodev->reset_ctrl) {
-		if (value)
-			reset_control_assert(mdiodev->reset_ctrl);
-		else
-			reset_control_deassert(mdiodev->reset_ctrl);
-	}
-
-	d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;
-	if (d)
-		fsleep(d);
-
-	mdiodev->reset_state = value;
-}
-EXPORT_SYMBOL(mdio_device_reset);
-
 /**
  * mdio_probe - probe an MDIO device
  * @dev: device to probe
-- 
2.53.0



