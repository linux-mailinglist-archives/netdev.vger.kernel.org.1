Return-Path: <netdev+bounces-55961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65C80CF95
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AADD1C21452
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C074B5C4;
	Mon, 11 Dec 2023 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHOc7iw1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858A8DC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:33:10 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c68da9d639so2586867a12.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702308790; x=1702913590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9nyIKtamCpicw2WPRHA84FcbnZ7MvQb17dWhMR1seM=;
        b=bHOc7iw1f4LInPU0QY/OUI5mmSiPL9kHRlaIduOgjj64lFRxdRmMH3bCzmKG2qpTS+
         jcg99u6XCshn+QB6m/gKVtGCLws1aYJKdq26J0SgtYK5Q2bSPGLnqos6P2Q6XQYENYwB
         57KZA6CfkPopVR7wkD0qLH1LSTscBL6xIYqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308790; x=1702913590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9nyIKtamCpicw2WPRHA84FcbnZ7MvQb17dWhMR1seM=;
        b=kZsAYivBpQo2HgoMKAXMJSF/+4fUaUb2qmzu/qlb28fNSKKE1WdPeXMiz18GaVnVU1
         2jKrL0VJXeyLtKqYL6+odGF32eWcUKmNqBEPjP7ADr2UFPny6eV74R5uq0NjFoJKTHGI
         jIh2AgoL8ykI8lyLWSL5jy8KoTdl6oJihE7sC18vrMHFJG0Ip3uTNiEDcvIEUs7SiR1S
         cv1zbxszjwkwY0vSDte8tuKyljpwJvjQ7WMWKi3APRbI/FLA2q7lpcOaaRtb25uOQxxv
         paGCuHk4A0nyYPQB3RqsX9x/HRDg5WRzfCZ0nsj7Zq35Em/aFGF1IRjQFE5/O2MUu2sO
         A4gQ==
X-Gm-Message-State: AOJu0YxtTuoBOU3ZCJYHH3Ew0k6dOVI9nXH8f1/I/t3SHsWYZjP4zuGq
	hFhnWow7A0SdTFsSeDqx/P7teA==
X-Google-Smtp-Source: AGHT+IEJ82IJ2l2KnYVTDw2r7IaBgHAFat5OWA0r+Y0uPDs92zOArKh4IAJKuOYTNG1KJWot5LRlFQ==
X-Received: by 2002:a05:6a20:8f08:b0:18c:3260:e20f with SMTP id b8-20020a056a208f0800b0018c3260e20fmr2612497pzk.33.1702308789981;
        Mon, 11 Dec 2023 07:33:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id x1-20020a63cc01000000b005742092c211sm6299572pgf.64.2023.12.11.07.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:33:09 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Paolo Abeni <pabeni@redhat.com>,
	Brian Geffon <bgeffon@google.com>,
	Grant Grundler <grundler@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: core: Fix crash w/ usb_choose_configuration() if no driver
Date: Mon, 11 Dec 2023 07:32:41 -0800
Message-ID: <20231211073237.v3.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
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
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Add comment in code, as per Alan.

Changes in v2:
- Return immediately if no driver, as per Alan.

 drivers/usb/core/generic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index dcb897158228..b134bff5c3fe 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -59,7 +59,16 @@ int usb_choose_configuration(struct usb_device *udev)
 	int num_configs;
 	int insufficient_power = 0;
 	struct usb_host_config *c, *best;
-	struct usb_device_driver *udriver = to_usb_device_driver(udev->dev.driver);
+	struct usb_device_driver *udriver;
+
+	/*
+	 * If a USB device (not an interface) doesn't have a driver then the
+	 * kernel has no business trying to select or install a configuration
+	 * for it.
+	 */
+	if (!udev->dev.driver)
+		return -1;
+	udriver = to_usb_device_driver(udev->dev.driver);
 
 	if (usb_device_is_owned(udev))
 		return 0;
-- 
2.43.0.472.g3155946c3a-goog


