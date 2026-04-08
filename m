Return-Path: <netdev+bounces-276284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDqdMljo1Wmw/AcAu9opvQ
	(envelope-from <netdev+bounces-276284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FE83B731C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37FC303CC0A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A235AC10;
	Wed,  8 Apr 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9XuKVVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB835CB81
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626261; cv=none; b=E8sInXoICFSyrcX5HBDWzubrmwInZIxy3t1unpRmrUO32nBnnegHQh/svtASpP7WeYLTTGKGdpqEVRzGWDTvkMJG2iy7d+HkVk2al1NHZEi3YLgksHXO5TFUp7VR5NBHJDT/4HSRsz2Xk8ZrW91K4X2kLETlz3JgtPEAGhVBDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626261; c=relaxed/simple;
	bh=lbgRgN14X3CUpEJv6dKvS7/nLgyBUL/xeX7e54cB3vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJV0zRrjCRfZpD/sRYFt35KgZxTx1/VhDT4GyBq2TNMYZ2XpeZ/K28Kg1LyiiPQNUIcOONsZ8SoIMD3sF8MHuER9/cTV5K8pdESfqk3EKKRCZ+XhuSSCQ7a5iGcejSgTvcY5CIV9yuhrE7tXgOsrShxB0P3D6DYOIo+XcIlpBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9XuKVVQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so256174a91.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775626259; x=1776231059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urUQup7dc3mN1NcxY7RoIdIVM9FIVTCa2CM6teh2xWs=;
        b=X9XuKVVQzyf1uNrAsZv2JeOT3Eimmq9bJZhqQHk/XiEAngwYi0mqWQEao2jhGGUtQa
         42Nmxt5nUWbDz6jDMPZmY3OIDPIk+qIJHdT1u4YuDbjLmd06TT4fQ7FB8Y9lN2ZhPfNj
         0SdCg+aK5MVzoRXF2eStfhPPdepi5rDJ0aAiZWiDtkHYtJOSQ9gn7b80AWspHk+R0+4S
         aQAME9aUX8mtg2c4P/lK4S/Ch5nNk/olwHOctQzKq+IEzS4YSkk3X/1e9U97n360USsk
         8157UQIMkj6ky1H3/BmDq05JSPoOjoGhau7jPYZLvmiUSYKcHJ3U+qGImOfQhxBY3xi+
         yvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775626259; x=1776231059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=urUQup7dc3mN1NcxY7RoIdIVM9FIVTCa2CM6teh2xWs=;
        b=R7ae4CBAtyWLw8FkYMAQV4J6YrOCf9CwjJN8lNTYxRqUKo2z5hf/bGIvuawpvonih1
         gV2WrZpaZPSThhLvm/Z8b/fb1vK4JfYXuhq5nbGenm7CSqRc4gN3bpPWXdva05+KPr/9
         MduOUngjan+Bqbm+M3kPJV9t9PlRTIt/LN3alRUC6GKMCFT8WJnI6Gu6DYGWRPIZz1Wa
         OsEGYPBW3PBgU/2TPJ14aiCVQXVoPvYPPfm/Royu7wLXVi7z7nbC/nZELlV7ago/QxAX
         KK3qjpOOy3bXNasrXuOh5BBaajoWRr6OYj8x61Z5IBLSBeOkijlciWX19dhyq/kR/Q7Y
         mIhg==
X-Forwarded-Encrypted: i=1; AJvYcCWaV9AF+Sg8R1LfFwb1kAr8ynJg7fy2Wc312scYtpyMsPUO9f2Z6AUtcHSzNQTH1tLWtDYN0U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiEPEplPMRHIV5K/Tr6apf/iabBkKcn6w+1z9fDlezCQzR6X/
	Jdu8kWHLMm/BTAk5Nb5XMhte/TvjD94djjj9INZ+v8gf3N4p5fyyLZSQ
X-Gm-Gg: AeBDieupHJUL9hr+AOFaMrkvvMfnJGVjmotGuKjXjbAgKR7D837LiQGKIPaU36p66DF
	LbnnmALY3CTo6zNaf1UlC59eO9PaO+LQt14epHVjqFLm7R8FFGg04PPSKChn1pFYwaoefWduEzY
	/PLvLHsTZEZo5BWtuwMd+h+2aZ/WlOzf/S4lXudZUoVsTQhqeLeC1aYtLtt8pQ7k8PdGyms9WBW
	FAdPwbXj/+j9lZ53OXX+6gL3XthHyIl46JteqSXLA6QYvdXsuWYdsHa1ceVdplnueiya24MsEFB
	TjK+3D5Ybk9bhlFUJZFXiFHYYKibxpSqUpUQSpGN1pMiLiTqbd9rww6eU2aQNUilas+vrmvIgaC
	9oSuH3SEIE0io2WgUj68Op5K28+DcvXnebtWaqzC+F2ihdJZmea4rj1UQCfV+tMsN+fQ//YlRf3
	m+/EmxGj3XsugJTTuXlsbkeEHX8ZtTe6y0/P8pdHvNxQfFvLSsr7Vi31FIvGkK/Db7yg==
X-Received: by 2002:a17:902:e94d:b0:2b0:6365:217e with SMTP id d9443c01a7336-2b28206efdfmr182824215ad.15.1775626258494;
        Tue, 07 Apr 2026 22:30:58 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d098sm181673475ad.13.2026.04.07.22.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 22:30:58 -0700 (PDT)
From: a0282524688@gmail.com
To: tmyu0@nuvoton.com,
	linusw@kernel.org,
	brgl@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ming Yu <a0282524688@gmail.com>
Subject: [PATCH v2 1/2] mfd: nct6694: Switch to devm_mfd_add_devices() and drop IDA
Date: Wed,  8 Apr 2026 13:30:36 +0800
Message-Id: <20260408053037.1867092-2-a0282524688@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408053037.1867092-1-a0282524688@gmail.com>
References: <20260408053037.1867092-1-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-276284-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74FE83B731C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ming Yu <a0282524688@gmail.com>

Currently, the nct6694 core driver uses mfd_add_hotplug_devices()
and an IDA to manage subdevice IDs.

Switch the core implementation to use the managed
devm_mfd_add_devices() API, which simplifies the error handling and
device lifecycle management. Concurrently, drop the custom IDA
implementation and transition to using pdev->id.

Signed-off-by: Ming Yu <a0282524688@gmail.com>
---
 drivers/gpio/gpio-nct6694.c         | 19 +------
 drivers/i2c/busses/i2c-nct6694.c    | 19 +------
 drivers/mfd/nct6694.c               | 83 ++++++++++++-----------------
 drivers/net/can/usb/nct6694_canfd.c | 12 +----
 drivers/watchdog/nct6694_wdt.c      | 20 +------
 include/linux/mfd/nct6694.h         |  8 +--
 6 files changed, 43 insertions(+), 118 deletions(-)

diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index a8607f0d9915..3703a61209e6 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -7,7 +7,6 @@
 
 #include <linux/bits.h>
 #include <linux/gpio/driver.h>
-#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/nct6694.h>
 #include <linux/module.h>
@@ -381,14 +380,6 @@ static void nct6694_irq_dispose_mapping(void *d)
 	irq_dispose_mapping(data->irq);
 }
 
-static void nct6694_gpio_ida_free(void *d)
-{
-	struct nct6694_gpio_data *data = d;
-	struct nct6694 *nct6694 = data->nct6694;
-
-	ida_free(&nct6694->gpio_ida, data->group);
-}
-
 static int nct6694_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -403,15 +394,7 @@ static int nct6694_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->nct6694 = nct6694;
-
-	ret = ida_alloc(&nct6694->gpio_ida, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
-	data->group = ret;
-
-	ret = devm_add_action_or_reset(dev, nct6694_gpio_ida_free, data);
-	if (ret)
-		return ret;
+	data->group = pdev->id;
 
 	names = devm_kcalloc(dev, NCT6694_NR_GPIO, sizeof(char *),
 			     GFP_KERNEL);
diff --git a/drivers/i2c/busses/i2c-nct6694.c b/drivers/i2c/busses/i2c-nct6694.c
index 1413ab6f9462..7d8ad997f6d2 100644
--- a/drivers/i2c/busses/i2c-nct6694.c
+++ b/drivers/i2c/busses/i2c-nct6694.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/i2c.h>
-#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/mfd/nct6694.h>
 #include <linux/module.h>
@@ -134,14 +133,6 @@ static int nct6694_i2c_set_baudrate(struct nct6694_i2c_data *data)
 	return 0;
 }
 
-static void nct6694_i2c_ida_free(void *d)
-{
-	struct nct6694_i2c_data *data = d;
-	struct nct6694 *nct6694 = data->nct6694;
-
-	ida_free(&nct6694->i2c_ida, data->port);
-}
-
 static int nct6694_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -155,15 +146,7 @@ static int nct6694_i2c_probe(struct platform_device *pdev)
 
 	data->dev = dev;
 	data->nct6694 = nct6694;
-
-	ret = ida_alloc(&nct6694->i2c_ida, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
-	data->port = ret;
-
-	ret = devm_add_action_or_reset(dev, nct6694_i2c_ida_free, data);
-	if (ret)
-		return ret;
+	data->port = pdev->id;
 
 	ret = nct6694_i2c_set_baudrate(data);
 	if (ret)
diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index 308b2fda3055..8ce2c4985aab 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -11,7 +11,6 @@
 
 #include <linux/bits.h>
 #include <linux/interrupt.h>
-#include <linux/idr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
@@ -23,35 +22,35 @@
 #include <linux/usb.h>
 
 static const struct mfd_cell nct6694_devs[] = {
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-	MFD_CELL_NAME("nct6694-gpio"),
-
-	MFD_CELL_NAME("nct6694-i2c"),
-	MFD_CELL_NAME("nct6694-i2c"),
-	MFD_CELL_NAME("nct6694-i2c"),
-	MFD_CELL_NAME("nct6694-i2c"),
-	MFD_CELL_NAME("nct6694-i2c"),
-	MFD_CELL_NAME("nct6694-i2c"),
-
-	MFD_CELL_NAME("nct6694-canfd"),
-	MFD_CELL_NAME("nct6694-canfd"),
-
-	MFD_CELL_NAME("nct6694-wdt"),
-	MFD_CELL_NAME("nct6694-wdt"),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 1),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 2),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 3),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 4),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 5),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 6),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 7),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 8),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 9),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 10),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 11),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 12),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 13),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 14),
+	MFD_CELL_BASIC("nct6694-gpio", NULL, NULL, 0, 15),
+
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 1),
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 2),
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 3),
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 4),
+	MFD_CELL_BASIC("nct6694-i2c", NULL, NULL, 0, 5),
+
+	MFD_CELL_BASIC("nct6694-canfd", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("nct6694-canfd", NULL, NULL, 0, 1),
+
+	MFD_CELL_BASIC("nct6694-wdt", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("nct6694-wdt", NULL, NULL, 0, 1),
 
 	MFD_CELL_NAME("nct6694-hwmon"),
 
@@ -307,23 +306,18 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 	nct6694->dev = dev;
 	nct6694->udev = udev;
 
-	ida_init(&nct6694->gpio_ida);
-	ida_init(&nct6694->i2c_ida);
-	ida_init(&nct6694->canfd_ida);
-	ida_init(&nct6694->wdt_ida);
-
 	spin_lock_init(&nct6694->irq_lock);
 
 	ret = devm_mutex_init(dev, &nct6694->access_lock);
 	if (ret)
-		goto err_ida;
+		goto err_irq_domain;
 
 	interface = iface->cur_altsetting;
 
 	int_endpoint = &interface->endpoint[0].desc;
 	if (!usb_endpoint_is_int_in(int_endpoint)) {
 		ret = -ENODEV;
-		goto err_ida;
+		goto err_irq_domain;
 	}
 
 	usb_fill_int_urb(nct6694->int_in_urb, udev, usb_rcvintpipe(udev, NCT6694_INT_IN_EP),
@@ -332,11 +326,11 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 
 	ret = usb_submit_urb(nct6694->int_in_urb, GFP_KERNEL);
 	if (ret)
-		goto err_ida;
+		goto err_irq_domain;
 
 	usb_set_intfdata(iface, nct6694);
 
-	ret = mfd_add_hotplug_devices(dev, nct6694_devs, ARRAY_SIZE(nct6694_devs));
+	ret = devm_mfd_add_devices(dev, 0, nct6694_devs, ARRAY_SIZE(nct6694_devs), NULL, 0, NULL);
 	if (ret)
 		goto err_mfd;
 
@@ -344,11 +338,7 @@ static int nct6694_usb_probe(struct usb_interface *iface,
 
 err_mfd:
 	usb_kill_urb(nct6694->int_in_urb);
-err_ida:
-	ida_destroy(&nct6694->wdt_ida);
-	ida_destroy(&nct6694->canfd_ida);
-	ida_destroy(&nct6694->i2c_ida);
-	ida_destroy(&nct6694->gpio_ida);
+err_irq_domain:
 	irq_domain_remove(nct6694->domain);
 err_urb:
 	usb_free_urb(nct6694->int_in_urb);
@@ -359,12 +349,7 @@ static void nct6694_usb_disconnect(struct usb_interface *iface)
 {
 	struct nct6694 *nct6694 = usb_get_intfdata(iface);
 
-	mfd_remove_devices(nct6694->dev);
 	usb_kill_urb(nct6694->int_in_urb);
-	ida_destroy(&nct6694->wdt_ida);
-	ida_destroy(&nct6694->canfd_ida);
-	ida_destroy(&nct6694->i2c_ida);
-	ida_destroy(&nct6694->gpio_ida);
 	irq_domain_remove(nct6694->domain);
 	usb_free_urb(nct6694->int_in_urb);
 }
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..29282c56430f 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -8,7 +8,6 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 #include <linux/ethtool.h>
-#include <linux/idr.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/mfd/nct6694.h>
@@ -725,15 +724,13 @@ static int nct6694_canfd_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	int port, irq, ret, can_clk;
 
-	port = ida_alloc(&nct6694->canfd_ida, GFP_KERNEL);
-	if (port < 0)
-		return port;
+	port = pdev->id;
 
 	irq = irq_create_mapping(nct6694->domain,
 				 NCT6694_IRQ_CAN0 + port);
 	if (!irq) {
 		ret = -EINVAL;
-		goto free_ida;
+		return ret;
 	}
 
 	ndev = alloc_candev(sizeof(struct nct6694_canfd_priv), 1);
@@ -796,24 +793,19 @@ static int nct6694_canfd_probe(struct platform_device *pdev)
 	free_candev(ndev);
 dispose_irq:
 	irq_dispose_mapping(irq);
-free_ida:
-	ida_free(&nct6694->canfd_ida, port);
 	return ret;
 }
 
 static void nct6694_canfd_remove(struct platform_device *pdev)
 {
 	struct nct6694_canfd_priv *priv = platform_get_drvdata(pdev);
-	struct nct6694 *nct6694 = priv->nct6694;
 	struct net_device *ndev = priv->ndev;
-	int port = ndev->dev_port;
 	int irq = ndev->irq;
 
 	unregister_candev(ndev);
 	can_rx_offload_del(&priv->offload);
 	free_candev(ndev);
 	irq_dispose_mapping(irq);
-	ida_free(&nct6694->canfd_ida, port);
 }
 
 static struct platform_driver nct6694_canfd_driver = {
diff --git a/drivers/watchdog/nct6694_wdt.c b/drivers/watchdog/nct6694_wdt.c
index bc3689bd4b6b..2b4b804a1739 100644
--- a/drivers/watchdog/nct6694_wdt.c
+++ b/drivers/watchdog/nct6694_wdt.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2025 Nuvoton Technology Corp.
  */
 
-#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/mfd/nct6694.h>
 #include <linux/module.h>
@@ -233,21 +232,12 @@ static const struct watchdog_ops nct6694_wdt_ops = {
 	.ping = nct6694_wdt_ping,
 };
 
-static void nct6694_wdt_ida_free(void *d)
-{
-	struct nct6694_wdt_data *data = d;
-	struct nct6694 *nct6694 = data->nct6694;
-
-	ida_free(&nct6694->wdt_ida, data->wdev_idx);
-}
-
 static int nct6694_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct nct6694 *nct6694 = dev_get_drvdata(dev->parent);
 	struct nct6694_wdt_data *data;
 	struct watchdog_device *wdev;
-	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -260,15 +250,7 @@ static int nct6694_wdt_probe(struct platform_device *pdev)
 
 	data->dev = dev;
 	data->nct6694 = nct6694;
-
-	ret = ida_alloc(&nct6694->wdt_ida, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
-	data->wdev_idx = ret;
-
-	ret = devm_add_action_or_reset(dev, nct6694_wdt_ida_free, data);
-	if (ret)
-		return ret;
+	data->wdev_idx = pdev->id;
 
 	wdev = &data->wdev;
 	wdev->info = &nct6694_wdt_info;
diff --git a/include/linux/mfd/nct6694.h b/include/linux/mfd/nct6694.h
index 6eb9be2cd4a0..496da72949d9 100644
--- a/include/linux/mfd/nct6694.h
+++ b/include/linux/mfd/nct6694.h
@@ -8,6 +8,10 @@
 #ifndef __MFD_NCT6694_H
 #define __MFD_NCT6694_H
 
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
 #define NCT6694_VENDOR_ID	0x0416
 #define NCT6694_PRODUCT_ID	0x200B
 #define NCT6694_INT_IN_EP	0x81
@@ -82,10 +86,6 @@ union __packed nct6694_usb_msg {
 
 struct nct6694 {
 	struct device *dev;
-	struct ida gpio_ida;
-	struct ida i2c_ida;
-	struct ida canfd_ida;
-	struct ida wdt_ida;
 	struct irq_domain *domain;
 	struct mutex access_lock;
 	spinlock_t irq_lock;
-- 
2.34.1


