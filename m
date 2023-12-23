Return-Path: <netdev+bounces-60117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A581D743
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 00:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE821F21E0A
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 23:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB01D6B8;
	Sat, 23 Dec 2023 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuV4PJFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F451D53A;
	Sat, 23 Dec 2023 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-554766d5ceaso1235190a12.3;
        Sat, 23 Dec 2023 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703374576; x=1703979376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxAwVffICgZgnvkf9i6jEa55fTAlwYeW47z9VTGjJBc=;
        b=cuV4PJFvl5wHbAnNFI6i3k/6Ksg0k+b8JP13wYhlIeBRr+NCaGADySGxdANRyoQcEm
         03fLKh0RDl8fuJRokrrGUcR++Ofwh5aTVGdA9cYKFS8fHfpWIw47T2a3wsZMQVrSjrJH
         Zd4rAwjVRsKDatQtT36ZpN6emId+/FQSmwW81358rs/BMdkW84ZR/QfaRZp3y2vmkDwv
         +Un/4XiSDRaI150++jxfpcMhJ1149BAmadTeEEdcWPKW5n0TDfS0XS5VuFIUdu4Pis28
         qhTBFF8IH6XflFqH0jE1zxjJNIZjX0pOUaDmbZAgqzrfEBtryKYWKlCjAj2ogx1DgF76
         iMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703374576; x=1703979376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxAwVffICgZgnvkf9i6jEa55fTAlwYeW47z9VTGjJBc=;
        b=arwVMLcAHtJcDQjvMtjp6Oy7ujJn82jfRPoQpiCoroC7cG3X4NlnwqbaWPSqtKnq2+
         WcjOxJBu0gJRgQNgDFkL2a03clpU2BG51yReq7KRKMsMXNTWPoeITJ5RZOXvwHtHV2cL
         RSepcq5uBU30o5wBv9sb1q1n5bTP2wy68Z+UJRiT5/tFyw7DPzeFqTtKPmKeU9Y/X0v4
         8YDs2T6efnpfLJLsQ2CM1iPTuXZYpu5NWDjaqbpGgPeMwj6yuour1+i74kRjTLiSKEPn
         UzY8zO+AsbTSvHZAR3fz/qLRRNsKNc+qry/T5AF/9OmPbJ/hchekT1rpmatCn75NFd7o
         AhQA==
X-Gm-Message-State: AOJu0YzLwUNtb32vYyxWtxyH/Y/ZA89Az8YDXT8ZEp1O5R4kp3D+byl4
	x0ZupGDcRKHHvlRsXFV72F4=
X-Google-Smtp-Source: AGHT+IG2H4GUtRqMWAnpiZokIOZ/Tmr7TebvSbHOTZWm4bHW4VBi/2kji+vpQDOKJBzb85qg+2GwkQ==
X-Received: by 2002:a50:d756:0:b0:554:7a21:241e with SMTP id i22-20020a50d756000000b005547a21241emr1408048edj.40.1703374576312;
        Sat, 23 Dec 2023 15:36:16 -0800 (PST)
Received: from localhost ([5.255.99.108])
        by smtp.gmail.com with ESMTPSA id a14-20020a50ff0e000000b0054d360bdfd6sm4404930edu.73.2023.12.23.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 15:36:15 -0800 (PST)
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
Subject: [PATCH net 1/2] USB: Allow usb_device_driver to override usb_choose_configuration
Date: Sun, 24 Dec 2023 01:35:22 +0200
Message-ID: <20231223233523.4411-2-maxtram95@gmail.com>
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

usb_choose_configuration is called in two cases: on probe and on
authorization. If a usb_device_driver wants to override the default
configuration (like r8152 does to choose the vendor config), it can do
that on probe, but it has no control over what happens on authorization.
This breaks the intention on machines that use usbguard (all devices are
not authorized by default, and the permitted ones get the authorization
a moment later), because a wrong configuration ends up being selected.

Allow usb_device_driver to override usb_choose_configuration
specifically.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/usb/core/generic.c | 10 ++++++++++
 include/linux/usb.h        |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 740342a2812a..a1bc4f875d37 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,10 +59,20 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
+	struct usb_device_driver *udriver = NULL;
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
+	if (udev->dev.driver) {
+		udriver = to_usb_device_driver(udev->dev.driver);
+		if (udriver->choose_configuration) {
+			i = udriver->choose_configuration(udev);
+			if (i != -EOPNOTSUPP)
+				return max(i, -1);
+		}
+	}
+
 	best = NULL;
 	c = udev->config;
 	num_configs = udev->descriptor.bNumConfigurations;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 8c61643acd49..4f59b10f2fdd 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1259,6 +1259,8 @@ struct usb_driver {
  *	device.  If it is, probe returns zero and uses dev_set_drvdata()
  *	to associate driver-specific data with the device.  If unwilling
  *	to manage the device, return a negative errno value.
+ * @choose_configuration: Called from usb_choose_configuration, allows the
+ *	driver to override the default configuration.
  * @disconnect: Called when the device is no longer accessible, usually
  *	because it has been (or is being) disconnected or the driver's
  *	module is being unloaded.
@@ -1283,6 +1285,7 @@ struct usb_device_driver {
 
 	bool (*match) (struct usb_device *udev);
 	int (*probe) (struct usb_device *udev);
+	int (*choose_configuration) (struct usb_device *udev);
 	void (*disconnect) (struct usb_device *udev);
 
 	int (*suspend) (struct usb_device *udev, pm_message_t message);
-- 
2.43.0


