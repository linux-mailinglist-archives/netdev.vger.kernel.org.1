Return-Path: <netdev+bounces-163159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F03A29710
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C38167915
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555B1FC7F7;
	Wed,  5 Feb 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/q2r/Yz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB21FC112;
	Wed,  5 Feb 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775819; cv=none; b=OQgJcSqBkyfyimzm42eZx0R1LUE3pdtH6Il7tMLtPWRz5cH+oARJzQOQCkJFFqkSC+b0dK8f6o3PJ8jJvDdI1SpjqvFQN9jEvhi9VYUjZ3qc7ps+0RtpEAwoowtVr9n6zPH+/Z7cmJBiDN2UnXoN8jn4nkoZ6yuqbQNECDHn6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775819; c=relaxed/simple;
	bh=JNM+xJCaItR02fuhdJjaI5OW53diysJABbpIdanaGOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qhc4LtsplBKnNNQn9C312lW/WOcBlDxd/9x0IGg4JEp5kx5QjTTltHmvHvvdKb2E2ZnpC1BNoxaE1AaOv39avIKHIoLYsLqKPvAu8nTkhRjUuIGnt6PvCTnIenUZ7fT6O5ml/OzVyqrWM0fabFzBcnlJzbJz3ujZhjlJSrv6AHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/q2r/Yz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so227695e9.0;
        Wed, 05 Feb 2025 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738775816; x=1739380616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q560iUflz9C+1XE8KBgcw0eVXI/n7mkGqzaVgKvz5w0=;
        b=L/q2r/YzY7dP6ZQGR6SAW6f26+Fl8Rb0mZ0TZM/0LWk5TpSavVNiXQUOwiVsLzxz5G
         pnlF1LncVnGbdH0p9zlgmOHZ2Fvg6DTw8syGuJSIXJkToskVM60+kJs6iOiXCinwBMLG
         1AfHQHy3H12EUIt76Z4YEexZB8x/nBVyc09j2/5f60A0n6UM2ndU+xbz2/9P11a0Kdq0
         f26uhn2nhfMNZmQy7LnCcrJ0eIjLBeCO6DAKqNRQW6Jg0fo0JSd72odnwO5Stau1OhUL
         61bZU4wa1nm9Ryj4agwq/DyDJxhWrOpaNaQkKYd2nyIlnUf8DL2qgKjJQJhMnqOK/bzF
         NP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775816; x=1739380616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q560iUflz9C+1XE8KBgcw0eVXI/n7mkGqzaVgKvz5w0=;
        b=Uipq7KtdwBex5Qzvp086NuZo85re/IlQ1xVycVRJhMkjBF6hM+13IL5ZkW9Su8OrFJ
         emrl/HqWPaGaT0kLxHOwq+VLR9Zkl9XcBEklICQAa7vqR3ZP/F4JjMldC97EYxaNlowP
         kd7uVh7vXO64a46P17r7m5Msbrbf/ekKhuUf1wJDtTu1CeiQrJFUoRkmVNcf6DqSLUOg
         qOFV3qUN3IvPk2/+JEQSEFgC7Xzd6PmorX7PSDVXdpLNuhpr9e7qQqq12OXD4W9VbGNO
         BHBYbkftqSS+nyHPfrFpTHeYaOwnjZUl/e4ZY3E2nVxMUTQYOn9pi7ASUnW4FJms06yg
         VHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5d7l1a9gNr6fZOFrPXi6oYKiSeFhdr4+s5G6re3ZvyhmH/0+OkV3pNffnCQsHA4V/1vOvSM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/nfly4iCs9hdt8qQBuO/ayqGU99CFirEGYcj6GOMWsCyyY4u
	f9DDj37W0a+7SS4e0nQIUYY+2/bQb/9+hK7RZmxauL3Dh52n+llA
X-Gm-Gg: ASbGncvUY0dZgZDrEQOLF+ELAJTYM8Zk6Hjq5JtWlLOq6FrFQFu2HaT7ue9+lVedXcS
	jMq+l25OLur0Jo9EwWWWymh8DpyGbwzG48Rww+yS9tTmv17vfNeDRCa+h4pACDnL4yKny5KEYvO
	LvdRMAUy//X3l8legyKL/VzHlxS/svqzrL6F6xu9H0Ssyo6uG8Y/IfBKfdLAHz5eWNmIYEfgFHd
	tKA7bADwU+cicwcISWQaPkRoDLA3AjaibmPjde0wH+XhaYvPy8VyBe5nvHDPZnRjiHn1LZzZQzy
	rZ6+KQrZmdrJ25vXn2lzbRdSo1Z6t4RE+c4PeRkRP7NKPQ==
X-Google-Smtp-Source: AGHT+IHMB3fg22IzIJLhEQCjY975z2jCxrV33MmGgePRsw5efnIW+BFXH2OR6PNKKfqSgZvv8zW87w==
X-Received: by 2002:a05:600c:5127:b0:436:1b81:b65c with SMTP id 5b1f17b1804b1-4390d43e2a7mr32846695e9.15.1738775815618;
        Wed, 05 Feb 2025 09:16:55 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm27185705e9.27.2025.02.05.09.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:16:55 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 3/5] USB: serial: option: fix Telit Cinterion FN990A name
Date: Wed,  5 Feb 2025 18:16:47 +0100
Message-ID: <20250205171649.618162-4-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205171649.618162-1-fabio.porcedda@gmail.com>
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FN990 is FN990A so use it in order to avoid
confusion with FN990B.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 1f3c05ed5236..2e493041c3bf 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1367,15 +1367,15 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1063, 0xff),	/* Telit LN920 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1070, 0xff),	/* Telit FN990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1071, 0xff),	/* Telit FN990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1072, 0xff),	/* Telit FN990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990 (PCIe) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-- 
2.48.1


