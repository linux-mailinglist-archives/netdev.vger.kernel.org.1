Return-Path: <netdev+bounces-265189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCMAEi2ZrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:31:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2E22DB75
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 391C530098BC
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC32D9499;
	Sat,  7 Mar 2026 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUO+L8lE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C662C3245
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919082; cv=none; b=r8f3pmkPduUAP9Qt91p2EnyareTeiGDng5TZJteA4wjxUXEM5aNrtRjE9xxndROOCi79tRCt6xZcdzT8L4EwOkgyFgXXFhn4NXnCsQ2hBbX1j/WciirpjKgaBpsKNMi1n635Vxx3Ui+GHZ60n6LcRd2SvlqfVlULiYMOb9Ylyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919082; c=relaxed/simple;
	bh=THA3bSVQzv73wv2LgwqQEn2CkXKfTFif1AVKB23g0Uc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DgbsPWC7Xdp9RFy/AZQB5PY0laUmVrUU5iKriiDfpgGDxGYJUFxEPWlE9+4v26IoTO5P3Nl8kQ/+2XhQsgPloqPcYUMUj+FlCTECqON7FVCEyyl5uTTD4L2kkVRy0iaJMgx4N/q7KthMaxCWPRbhwTXvgcrxOjAGIUpU6CWL3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUO+L8lE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so8928495e9.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919080; x=1773523880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D3yVBrm0NO/kyrzRjsGOfgFPVCo6bv+SX/DHuerXF6U=;
        b=gUO+L8lEXI0sxVkxX85WtmMlruQoBPG+PqaVDgOQvifBAb1CPKPMFApg2o3BjWUTh5
         AdXrtAJU24/Y4NYyetQ9i1aPpg8qEZXbuwqmOIBoemOMjFAJIPpdXmgjDhRniPgo6849
         OvtcA+ivRDTYU/YSm8V46R485u1hMWJHxEV1KEyar6nlovqgs7yzyNdF+xvhkFyA5EJ9
         UBU/Ngk/32937P0J/OApZVcfVtoq4lkK+qh4PB0ktc+oit4h95xmLeVirAfhPYaygdmF
         FJ7+6ypqk1iFStmj0xASpu5SXojAdy9zqFv2hSpw4R7fQKERhGarZoEZPHWdV+fPhNrI
         9D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919080; x=1773523880;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3yVBrm0NO/kyrzRjsGOfgFPVCo6bv+SX/DHuerXF6U=;
        b=mDQseRgQO+rOecRcxhg1bX0CIOBlcnVQ137nh+F8Q7qvZ+t/KDPevaTmmx6CXe7+BK
         +1Ox8J+JHUgz2hYRd8wns2Fq2/98gHXnh5UBf16J7OphTndkSzTOzouKOgA+j/D29XKe
         yytN4o6X4b0lE10pTcfLVEKseUEsgnLLn42lepT8wYvG7ycMUNNABbRbZnBxO9UxKM5v
         zUiaHu+Iyudg5J76NsfgsfSwhJ5vYewSG6jMNi3fYvOeDnGtet5mHm8nsPjXGlhj/adI
         8xloByNSVpKxpWPQ1oSFu/cLzx0fMRnLLp9rZ+1TtITyNJEFdt9xCgUBMYYWpaX/nJk+
         ZPxg==
X-Gm-Message-State: AOJu0YxZqHVx2MmijM5hNdy8nrbAcMDc7jg+f0XdFDg956jhqu7RPNDO
	pvo5rMSgTMbPtdLlF9WWsI+xDwxUojfsdWYTMssgy5oc7M3uVJleUA8Y
X-Gm-Gg: ATEYQzwGTzzPWWYPDvhuJGwJ+yhegSIuXoseOxykfn+m5iBfbraNG/icOU79QlwtyrY
	P5ke/hrcPm7VHBIYU7FgHJ/IUCF9gkBnoCb/PTSdsfDP7qMj3h+FdbAIxgT3FklPYwG+hMyyc4W
	DOA/mk/WfTrTSz4IMfEdG8gQRZDewtKTkuiCUIbRzpxikyH0wtkIkl+KYS8AkMMKmQnEshXD789
	htVW8Pc0sROCfGusXFEyJ3bX8tqXOxizgw+Ri4KEVFP4utYwZVxYhPXxREUND/sXd9u3P29sQLc
	2d8K9w6ioX6XCwrV6YT5ebJGvWIfYeNO6pSISsGM94TIfLivRwlYti5PXTdhxsSqxih19dWcsNm
	pt/+4FNW99CbuOBPHfx67sbAr1DbkN9Gk1DKVAj7Gr8hTBQEjRfzgbg+wUTujOWzZn5rF8YPtjX
	PFcVNgYtma3LtJ3nBen3Yrvde59ySJV2aZK6Bgl+SFbt9YsiUBnvN/9BapiDTBRIM7265hVHVYX
	hngx+IIl/x6RQ9R5YGxd0FzbABIUwE28D5qV/SrBmFvGSHT7Eo1lRzcZnGYj2no6Q==
X-Received: by 2002:a05:600c:a117:b0:483:7eea:b185 with SMTP id 5b1f17b1804b1-4852695aedemr85218335e9.16.1772919079827;
        Sat, 07 Mar 2026 13:31:19 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852767d8e4sm127214005e9.2.2026.03.07.13.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:31:19 -0800 (PST)
Message-ID: <d7a8bf27-690b-4d69-8237-a8c12ffd28f8@gmail.com>
Date: Sat, 7 Mar 2026 22:31:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/5] net: phy: move mdio_device reset handling
 functions in the code
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Language: en-US
In-Reply-To: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D1B2E22DB75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.828];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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



