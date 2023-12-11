Return-Path: <netdev+bounces-55951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97880CF17
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB20B20F02
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC864A9AC;
	Mon, 11 Dec 2023 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOuflSDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADAD9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:11:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d30141d108so5280605ad.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702307473; x=1702912273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjZ1Q3i+wwEmoaOAEivvc7ulbH4UVbA72KsZePqHS/s=;
        b=HOuflSDFImwQKauYTvTgDYF3QpXRZVnrThFvyJyMCZ1o4kJUJnqppZbYcddW2t+cGE
         +Q8mqfPOdC5SmVxey9C1YiXiL2Ova2ht6hGA6rnX74X3GJCTCEEWW+lGv9tJu/HR7L3M
         /LWmrEb42+9zVbmB/HvszMEjHqWoYb4G/jX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307473; x=1702912273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjZ1Q3i+wwEmoaOAEivvc7ulbH4UVbA72KsZePqHS/s=;
        b=h0FPGV40DX25+tBE3RK3YEF7cW/8R24j4oePFzjibnUsCjpxg+RP7XNPNYc5mQYm/Q
         f3iaNzlo6OmTnXeOb7wnGm71YQyfUvG4FqLuyPVButKtuFDfSJIKyUXPio5c6+/R8CvH
         ZCiLLoWsMKJ2RJNF4fWQcKZSYwHsvd3VMu12ietGfIU33vPKaHh/RIifm9jGMoH7Dd+m
         e9XutGjgozKQ7hFBtFrqAnfWhXupURaNJYU193cduNtBgqoIRoQj8KJRIh41GsInOY3R
         CZ/88SeN/kz0KBALhntnzhMPFUCZHVoATUaWnAumkk6k+sBhBwAly/bKOCvIg3qeCEHS
         K7UA==
X-Gm-Message-State: AOJu0YzkbfxAr8QVwEkRtRleQKiwaBg9ctLkx7TU0jh4AjXOoCVX67Q0
	/wul70nI9kbaJZ2hm5eQd0NxMg==
X-Google-Smtp-Source: AGHT+IFpOCNYQ3yPBkwpNjfl9h9ryDhS2AHuurPpRtWodHZQ65S7qlnZant5AJQUmuF43IAOCxjBCg==
X-Received: by 2002:a17:902:e74e:b0:1d0:6d5d:5e4d with SMTP id p14-20020a170902e74e00b001d06d5d5e4dmr1735616plf.59.1702307473507;
        Mon, 11 Dec 2023 07:11:13 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id a18-20020a170902ecd200b001d058ad8770sm6787897plh.306.2023.12.11.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:11:12 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Brian Geffon <bgeffon@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date: Mon, 11 Dec 2023 07:08:14 -0800
Message-ID: <20231211070808.v2.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
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

A USB device with no driver is an anomaly, so make
usb_choose_configuration() return immediately if there is no driver.

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

Changes in v2:
- Return immediately if no driver, as per Alan.

 drivers/usb/core/generic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..2be1e8901e2f 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,7 +59,11 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
+
+	if (!udev->dev.driver)
+		return -1;
+	udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
-- 
2.43.0.472.g3155946c3a-goog


