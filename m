Return-Path: <netdev+bounces-53859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB5804FF1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FDE1F21484
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247394CDE4;
	Tue,  5 Dec 2023 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmeio4F1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD394D5A
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:13:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso34998101fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701771180; x=1702375980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXlQaeUuU2Rs5eCGSNaHUGrLdMffLi+fdFpFaCyMPBg=;
        b=Pmeio4F1pgUmg58p6FxcokcS5AcLcqCuift8iTroEXIsYhOF/R57VoujiZg4b0Ux6J
         xnzjYVn98vrfwLN0ho+wDf51BZLzaX4YajsuylLWYB6xKWCHAlrK9xbPFeI5gkRYiMqO
         nt+gEUwdRcZYlpTNYut/igzeCBAvJzluz0MIEoJncC9uIBe+9py7B8T6FrWww0v+FLmQ
         8pk6pRHrvrxjZKXivpVgOxrSDWhJSSmZfFnGVBelPPGS10dM6EXiXnt3CA5ZEKOXpvlf
         R1AqY1tEulYcWX/c6q4Saod1uDqhbhkpF3VWSVMRs3jUAKtyeFd9mGSpN1biqce5tseL
         pFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771180; x=1702375980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXlQaeUuU2Rs5eCGSNaHUGrLdMffLi+fdFpFaCyMPBg=;
        b=QIzUnYb3mVligX9lffC1ikP7pw23dRKfQN2/zS9Em/F4N9JzpMrgs2ilZwKwd31pmm
         6woM9p9xFLybHzyB39h3ETJNoTnP1rTT1xbaBFiZsbhrGOy43ByHlTonTbNwcV/lPFzY
         xWud3L3VvnYzfiNE5r6EUAd/cNYax3d3T7PfS39ClhfPiuC72eS/GfvqRas3j4IR3a+C
         4dsVEFkbRAyUqv9wJv/IZnnWbYDT+t8FXRzSACuLEpyKhP33ziXhCVkxHUF6XpB8pS2/
         sno+Gv66fbKI+1Aqyt8ivSn5xMCLxgQ513pCGXvh13EwI8kWh7i8Sw/jesLPu4RbK2ji
         SwZw==
X-Gm-Message-State: AOJu0YzRtY4L9ZNM6LGdEe7adzqyjAvXpiXcU2BwOnVONB8pdfugmfr4
	Pla3RaGuzQo6K8UFKSfh5sA=
X-Google-Smtp-Source: AGHT+IGnOpdeCArBQvMHmzmZ/DpJ/9PfYLNtF96SoDC7+30SthoqORFjSB+gEpMuLWPFzC5Y89P19w==
X-Received: by 2002:a2e:9803:0:b0:2ca:c81:ba9f with SMTP id a3-20020a2e9803000000b002ca0c81ba9fmr1245212ljj.80.1701771179855;
        Tue, 05 Dec 2023 02:12:59 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906518a00b00a1ce56f7b16sm97435ejk.71.2023.12.05.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:12:59 -0800 (PST)
Date: Tue, 5 Dec 2023 12:12:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Danzberger <dd@embedd.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
Message-ID: <20231205101257.nrlknmlv7sw7smtg@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="65e6ubmiezwwwdic"
Content-Disposition: inline
In-Reply-To: <20231204154315.3906267-1-dd@embedd.com>


--65e6ubmiezwwwdic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2023 at 04:43:15PM +0100, Daniel Danzberger wrote:
> Fixes a NULL pointer access when registering a switch device that has
> not been defined via DTS.
> 
> This might happen when the switch is used on a platform like x86 that
> doesn't use DTS and instantiates devices in platform specific init code.
> 
> Signed-off-by: Daniel Danzberger <dd@embedd.com>
> ---

I'm sorry, I just don't like the state in which your patch leaves the
driver. Would you mind testing this attached patch instead?

--65e6ubmiezwwwdic
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-microchip-properly-support-platform_data-pro.patch"

From dfc42178eabe54d0bf76440f0721b920702a78f3 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 5 Dec 2023 12:00:05 +0200
Subject: [PATCH net-next] net: dsa: microchip: properly support platform_data
 probing

The ksz driver has bits and pieces of platform_data probing support, but
it doesn't work.

The conventional thing to do is to have an encapsulating structure for
struct dsa_chip_data that gets put into dev->platform_data. This driver
expects a struct ksz_platform_data, but that doesn't contain a struct
dsa_chip_data as first element, which will obviously not work with
dsa_switch_probe() -> dsa_switch_parse().

Pointing dev->platform_data to a struct dsa_chip_data directly is in
principle possible, but that doesn't work either. The driver has
ksz_switch_detect() to read the device ID from hardware, followed by
ksz_check_device_id() to compare it against a predetermined expected
value. This protects against early errors in the SPI/I2C communication.
With platform_data, the mechanism in ksz_check_device_id() doesn't work
and even leads to NULL pointer dereferences, since of_device_get_match_data()
doesn't work in that probe path.

So obviously, the platform_data support is actually missing, and the
existing handling of struct ksz_platform_data is bogus. Complete the
support by adding a struct dsa_chip_data as first element, and fixing up
ksz_check_device_id() to pick up the platform_data instead of the
unavailable of_device_get_match_data().

The early dev->chip_id assignment from ksz_switch_register() is also
bogus, because ksz_switch_detect() sets it to an initial value. So
remove it.

Also, ksz_platform_data :: enabled_ports isn't used anywhere, delete it.

Link: https://lore.kernel.org/netdev/20231204154315.3906267-1-dd@embedd.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/microchip/ksz_common.c      | 21 +++++++++++++--------
 include/linux/platform_data/microchip-ksz.h |  4 +++-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 9545aed905f5..db1bbcf3a5f2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1673,15 +1673,23 @@ static const struct ksz_chip_data *ksz_lookup_info(unsigned int prod_num)
 
 static int ksz_check_device_id(struct ksz_device *dev)
 {
-	const struct ksz_chip_data *dt_chip_data;
+	const struct ksz_chip_data *expected_chip_data;
+	u32 expected_chip_id;
 
-	dt_chip_data = of_device_get_match_data(dev->dev);
+	if (dev->pdata) {
+		expected_chip_id = dev->pdata->chip_id;
+		expected_chip_data = ksz_lookup_info(expected_chip_id);
+		if (WARN_ON(!expected_chip_data))
+			return -ENODEV;
+	} else {
+		expected_chip_data = of_device_get_match_data(dev->dev);
+		expected_chip_id = expected_chip_data->chip_id;
+	}
 
-	/* Check for Device Tree and Chip ID */
-	if (dt_chip_data->chip_id != dev->chip_id) {
+	if (expected_chip_id != dev->chip_id) {
 		dev_err(dev->dev,
 			"Device tree specifies chip %s but found %s, please fix it!\n",
-			dt_chip_data->dev_name, dev->info->dev_name);
+			expected_chip_data->dev_name, dev->info->dev_name);
 		return -ENODEV;
 	}
 
@@ -4156,9 +4164,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	int ret;
 	int i;
 
-	if (dev->pdata)
-		dev->chip_id = dev->pdata->chip_id;
-
 	dev->reset_gpio = devm_gpiod_get_optional(dev->dev, "reset",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(dev->reset_gpio))
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index ea1cc6d829e9..6480bf4af0fb 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -20,10 +20,12 @@
 #define __MICROCHIP_KSZ_H
 
 #include <linux/types.h>
+#include <linux/platform_data/dsa.h>
 
 struct ksz_platform_data {
+	/* Must be first such that dsa_register_switch() can access it */
+	struct dsa_chip_data cd;
 	u32 chip_id;
-	u16 enabled_ports;
 };
 
 #endif
-- 
2.34.1


--65e6ubmiezwwwdic--

