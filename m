Return-Path: <netdev+bounces-55439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F84380ADDE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E91C20AC2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6B41C9B;
	Fri,  8 Dec 2023 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4BlyNZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0A10E6
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 12:32:08 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce94f62806so1697200b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702067528; x=1702672328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2mQlIlH8/Z8tgvJ/zwHnI8QH4gOVcIFjCJw+TXnnTk=;
        b=C4BlyNZuX0vmWiywMiDGcgYLLtThyzY7EqukTWLvqaoLBkfEkaOCCAlU9XXuJPMOqF
         MxSr6/JUGCvuEKavfvhjy+99Y2Y66ayNTY8LzDl2kIvmsfphNMKQpAmheuyYS5KuXkhT
         Met10JV2pE+2z7KRmybincabz6tU+eRbChw0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067528; x=1702672328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w2mQlIlH8/Z8tgvJ/zwHnI8QH4gOVcIFjCJw+TXnnTk=;
        b=X81gOsOpsuJ4BjcMdiWy1rbGji2bwLVT4r7gcIICW6silOcUXzVu0aDTosDmcMYX7W
         spI64tKPLFRHKfzfGkCGy+s7H9mOKMrYUGrZUJrBFJ640ttwZai+TPF5+bvjlALiYeQB
         qloKIgxnQBBNX7zYUhSnOnCRpuYDhz+nSqIGHnl3zCtUuC7gqm/aSDjDfv0KZATl4mnO
         2ewbLK8ma2whvcro8vsYzanctu3O2oaHI81D/Uzf25oGSiQdQ46Kaz3TBik82Kg/FMwu
         LjFKAO+AbcVmu+o1Ziefl7y8tqfLJnTLfR3fYafRUT7BG7/CINO9tYaq7yhw4zCJRGGm
         k9hA==
X-Gm-Message-State: AOJu0YyJTnA3XRDprbofWMad9uBmkcLVS86+rahlbO5C43U1xJtKMiiw
	EasWVTM/FcLuPOmQXfGcYvIVCg==
X-Google-Smtp-Source: AGHT+IECgUmTr570zRuFQm0Wq6yqwNKiCLWdOUXopkyxmxMUTqTpcoylkRBQTtmdDdr1KFvNsC8w6w==
X-Received: by 2002:a05:6a00:2387:b0:6cb:bc06:b058 with SMTP id f7-20020a056a00238700b006cbbc06b058mr775362pfc.0.1702067528378;
        Fri, 08 Dec 2023 12:32:08 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e1ca:b36e:48ba:c0e0])
        by smtp.gmail.com with ESMTPSA id n24-20020aa78a58000000b006ce4965fdbdsm1995691pfa.116.2023.12.08.12.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:32:07 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Grant Grundler <grundler@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Hayes Wang <hayeswang@realtek.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date: Fri,  8 Dec 2023 12:31:24 -0800
Message-ID: <20231208123119.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's possible that usb_choose_configuration() can get called when a
USB device has no driver. In this case the recent commit a87b8e3be926
("usb: core: Allow subclassed USB drivers to override
usb_choose_configuration()") can cause a crash since it dereferenced
the driver structure without checking for NULL. Let's add a check.

This was seen in the real world when usbguard got ahold of a r8152
device at the wrong time. It can also be simulated via this on a
computer with one r8152-based USB Ethernet adapter:
  cd /sys/bus/usb/drivers/r8152-cfgselector
  to_unbind="$(ls -d *-*)"
  real_dir="$(readlink -f "${to_unbind}")"
  echo "${to_unbind}" > unbind
  cd "${real_dir}"
  echo 0 > authorized
  echo 1 > authorized

Fixes: a87b8e3be926 ("usb: core: Allow subclassed USB drivers to override usb_choose_configuration()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/usb/core/generic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..365482347333 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,15 +59,19 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
 
 	if (usb_device_is_owned(udev))
 		return 0;
 
-	if (udriver->choose_configuration) {
-		i = udriver->choose_configuration(udev);
-		if (i >= 0)
-			return i;
+	if (udev->dev.driver) {
+		udriver = to_usb_device_driver(udev->dev.driver);
+
+		if (udriver->choose_configuration) {
+			i = udriver->choose_configuration(udev);
+			if (i >= 0)
+				return i;
+		}
 	}
 
 	best = NULL;
-- 
2.43.0.472.g3155946c3a-goog


