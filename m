Return-Path: <netdev+bounces-53069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246918012CB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4341281F21
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F15B4CDFE;
	Fri,  1 Dec 2023 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDMaHPE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD4106
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:31:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cdfb72172aso1096657b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455494; x=1702060294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb01GRQ68eUgyc84/+R565jrsla/E08IXGMB+9OJhaQ=;
        b=CDMaHPE9v+9nZO1+SszfsPXIqd5f9EKU4uSBGbv1Y4TY0nJrfMWfAWojTNRklK2zbC
         hR+5Yj8xV5FTAQgFbGKrhcgCqH2GfoamqawzP3Yk2fZV5Mz3MRIe3bJvEdBIV8bghoNk
         hZXDMoPP+Xpadr+B1n0cyypEy99oKiAsU5V0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455494; x=1702060294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb01GRQ68eUgyc84/+R565jrsla/E08IXGMB+9OJhaQ=;
        b=T9XXf7IbbbDBQv5l4FIyEzPJ9Wz1U6Gn6xQD6GqlO9GC3FeAeRRtb8nX384p6O6bb4
         dmfCMtfWBKERBVw5bbOitDPReQAzoyMTNK60CCUpzJZZbLbNAmtSy1K+OVmWIBL5Tt6Y
         C1vgS6MwscsUM6y7VhBWnyiKmwSLe3QBmuXiVVTHzt1/VpyG/JQ8gednQi7j5WeTZ5rA
         2JK33sss2lKN4uPPUCAZ8AM3EEf8zxB6ETphI1GNMDs+zh5PgfidLwmJiZTeg4ysCGT9
         v/MgcKEc0kNPLyScgfRajnif+9frk6FMXjb1w0Ioy5AClI3bggsH/sQKTZemTwhRT8Iv
         BU7Q==
X-Gm-Message-State: AOJu0YxMuhaKFhi+bC8KmwrCJjsyJCKA2TbVuS5/2KhTavcG0B82/h6o
	G3ek8j4tRRcE0dR+6XwvMxYB9Q==
X-Google-Smtp-Source: AGHT+IE8ytyPVbqRYk7CYLOc1dseuNIRRK2+hGKn1jZLFV3Q171b71RSlG8/WIPvAesDpkr5kxX5YA==
X-Received: by 2002:a05:6a00:3016:b0:6cd:dc2e:a444 with SMTP id ay22-20020a056a00301600b006cddc2ea444mr8860209pfb.27.1701455492435;
        Fri, 01 Dec 2023 10:31:32 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11eb:92ac:94e:c791])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cdda10bdafsm3306926pfu.183.2023.12.01.10.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:31:31 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Grant Grundler <grundler@chromium.org>,
	Hayes Wang <hayeswang@realtek.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	netdev@vger.kernel.org,
	Brian Geffon <bgeffon@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: core: Allow subclassed USB drivers to override usb_choose_configuration()
Date: Fri,  1 Dec 2023 10:29:51 -0800
Message-ID: <20231201102946.v2.2.Iade5fa31997f1a0ca3e1dec0591633b02471df12@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231201183113.343256-1-dianders@chromium.org>
References: <20231201183113.343256-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some USB devices we might want to do something different for
usb_choose_configuration(). One example here is the r8152 driver where
we want to end up using the vendor driver with the preferred
interface.

The r8152 driver tried to make things work by implementing a USB
generic_subclass driver and then overriding the normal config
selection after it happened. This is less than ideal and also caused
breakage if someone deauthorized and re-authorized the USB device
because the USB core ended up going back to it's default logic for
choosing the best config. I made an attempt to fix this [1] but it was
a bit ugly.

Let's do this better and allow USB generic_subclass drivers to
override usb_choose_configuration().

[1] https://lore.kernel.org/r/20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Allow subclassed USB drivers to override ...") new for v2.

 drivers/usb/core/generic.c | 7 +++++++
 include/linux/usb.h        | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 740342a2812a..dcb897158228 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,10 +59,17 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
+	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
+	if (udriver->choose_configuration) {
+		i = udriver->choose_configuration(udev);
+		if (i >= 0)
+			return i;
+	}
+
 	best = NULL;
 	c = udev->config;
 	num_configs = udev->descriptor.bNumConfigurations;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 8c61643acd49..618e5a0b1a22 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1264,6 +1264,9 @@ struct usb_driver {
  *	module is being unloaded.
  * @suspend: Called when the device is going to be suspended by the system.
  * @resume: Called when the device is being resumed by the system.
+ * @choose_configuration: If non-NULL, called instead of the default
+ *	usb_choose_configuration(). If this returns an error then we'll go
+ *	on to call the normal usb_choose_configuration().
  * @dev_groups: Attributes attached to the device that will be created once it
  *	is bound to the driver.
  * @drvwrap: Driver-model core structure wrapper.
@@ -1287,6 +1290,9 @@ struct usb_device_driver {
 
 	int (*suspend) (struct usb_device *udev, pm_message_t message);
 	int (*resume) (struct usb_device *udev, pm_message_t message);
+
+	int (*choose_configuration) (struct usb_device *udev);
+
 	const struct attribute_group **dev_groups;
 	struct usbdrv_wrap drvwrap;
 	const struct usb_device_id *id_table;
-- 
2.43.0.rc2.451.g8631bc7472-goog


