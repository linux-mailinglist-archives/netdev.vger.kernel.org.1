Return-Path: <netdev+bounces-60118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA081D745
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 00:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2661C2175F
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A49208D7;
	Sat, 23 Dec 2023 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8guBJqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66A1EB4C;
	Sat, 23 Dec 2023 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a234dc0984fso309312766b.0;
        Sat, 23 Dec 2023 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703374578; x=1703979378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEx7xfusdmQXhw9i1ARuI4xTKHuwCraW+mZTw9408Ng=;
        b=C8guBJqeVhRERRNaCa9+/2aGM2dPSEA/sjochhL+HECyet3sT5IV9UHmDFOWjn5Wvc
         26fxZqUYEEPmcVD5Rde85X0+topdoIV4mfrXYIHHOd7nlggxNuVR4zuLllz/SPfK4BSz
         +ICm9aemSLKjIqA+FGTbHI1U6yDhJCnS4gC8KOF358qEJTdUjqdQT54WqjMBLKcBGhw8
         2DMX7uK1x8E66S2ill87uvbvQGFciFEinjtQeNni5DNtkR4TZ5TKtLjqlcHaQkTwnlf7
         rUg2uWqNbjoi8Dvz57RXDDnRWdEqkAUDlLLEHKZ3UmRVfNHYzuCm78wbevYIltS8CFwu
         Pw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703374578; x=1703979378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEx7xfusdmQXhw9i1ARuI4xTKHuwCraW+mZTw9408Ng=;
        b=gf+0kb0j7cvqwD2XFKAkxIANMX+iAYZ9NGkyHHfOViXhT6+1LMBFduSslc9OvKN0sv
         Gg2n/Mvdn58W4dS4K41tvhJaJHgT22Uk97L4t4X2YTejqNzYmztma1UjMoD2OCOd9Vik
         qOAf5+ClF//NEkjnY2XwLdjTraX2aw140Q9wgQiCPFMCOnsdwARgIus1sKqWa2FxvitJ
         B1vBOkhjpCVFHL9Ftfr1QqG7HTyO6jHE2NHm9S8H+kiT6qGFSXBPky8hH8UWObFokCWm
         RDSRnpRt51QS+G7DyRmriiInEzQK4Do8cotLUHJVvf5sXofSAOvDmO9r/KHUbMxYa1DZ
         TcfA==
X-Gm-Message-State: AOJu0YzwelW4NWzRe0GZ5gl7SSgbD5QAwApGGGNlB0ICGrW+wm0kLtAV
	WsSYX494zPiC8jl9vxr54Ps=
X-Google-Smtp-Source: AGHT+IED6CmEiqkckDFO7TKKuz2PVr3JXMUmSXr8UjGO661pcIN+s9cs+OU/YKyJwYUNALMab8msJQ==
X-Received: by 2002:a17:906:74c2:b0:a23:6b80:c1db with SMTP id z2-20020a17090674c200b00a236b80c1dbmr1800681ejl.95.1703374577793;
        Sat, 23 Dec 2023 15:36:17 -0800 (PST)
Received: from localhost ([5.255.99.108])
        by smtp.gmail.com with ESMTPSA id gs16-20020a170906f19000b00a269910e708sm3473555ejb.206.2023.12.23.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 15:36:17 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hayes Wang <hayeswang@realtek.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH net 2/2] r8152: Switch to using choose_configuration
Date: Sun, 24 Dec 2023 01:35:23 +0200
Message-ID: <20231223233523.4411-3-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223233523.4411-1-maxtram95@gmail.com>
References: <20231223233523.4411-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of r8152-cfgselector, the following regression
appeared on machines that use usbguard: the netdev appears only when the
USB device is inserted the first time (before the module is loaded), but
on the second and next insertions no netdev is registered.

It happens because the device is probed as unauthorized, and usbguard
gives it an authorization a moment later. If the module is not loaded,
it's normally loaded slower than the authorization is given, and
everything works. If the module is already loaded, the cfgselector's
probe function runs first, but then usb_authorize_device kicks in and
changes the configuration to something chosen by the standard
usb_choose_configuration. rtl8152_probe refuses to probe non-vendor
configurations, and the user ends up without a netdev.

The previous commit added possibility to override
usb_choose_configuration. Use it to fix the bug and pick the right
configuration on both probe and authorization.

Fixes: ec51fbd1b8a2 ("r8152: add USB device driver for config selection")
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/net/usb/r8152.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9bf2140fd0a1..f0ac31a94f3c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10070,6 +10070,11 @@ static struct usb_driver rtl8152_driver = {
 };
 
 static int rtl8152_cfgselector_probe(struct usb_device *udev)
+{
+	return 0;
+}
+
+static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
 {
 	struct usb_host_config *c;
 	int i, num_configs;
@@ -10078,7 +10083,7 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
 	 * driver supports it.
 	 */
 	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
-		return 0;
+		return -EOPNOTSUPP;
 
 	/* The vendor mode is not always config #1, so to find it out. */
 	c = udev->config;
@@ -10094,20 +10099,15 @@ static int rtl8152_cfgselector_probe(struct usb_device *udev)
 	}
 
 	if (i == num_configs)
-		return -ENODEV;
-
-	if (usb_set_configuration(udev, c->desc.bConfigurationValue)) {
-		dev_err(&udev->dev, "Failed to set configuration %d\n",
-			c->desc.bConfigurationValue);
-		return -ENODEV;
-	}
+		return -EOPNOTSUPP;
 
-	return 0;
+	return c->desc.bConfigurationValue;
 }
 
 static struct usb_device_driver rtl8152_cfgselector_driver = {
 	.name =		MODULENAME "-cfgselector",
 	.probe =	rtl8152_cfgselector_probe,
+	.choose_configuration = rtl8152_cfgselector_choose_configuration,
 	.id_table =	rtl8152_table,
 	.generic_subclass = 1,
 	.supports_autosuspend = 1,
-- 
2.43.0


