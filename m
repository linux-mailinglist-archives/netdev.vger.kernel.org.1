Return-Path: <netdev+bounces-97234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D528CA37C
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 22:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0851F213F6
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6E13A414;
	Mon, 20 May 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c5qDFkTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C913A3EC
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237720; cv=none; b=uQ+eC8xxIW/PTCFq2k/9xjIXp8Ym+3PruQe/czDq8BoKwWRebjumN7MiAHSU4OUdiNaoieSTeo3flPeY1UQznwtF8Lct/5Moo+jf0/JOMi8ycJYS82h6IcKRJy24kCrwUpe6q52m6qiQuj6aj6R8E5eq1jw4qQEdNH1C0XPEmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237720; c=relaxed/simple;
	bh=KLAoNg3lNimMGEM1iK1E2E71QyftAe7H7PKPd5zQpd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfMenHP3H6iS4Tx6ulQoR+OV9YjXG+vWzgotd+D5Z62tQahRPlQj8tm2i9lETE+J5bd0tNNtnAYmEfsD0+8uY+6Ut/5BZPht4ulhDk6Ggdd+SB1TdBHiEZVu5nGpqMkE2w6WfXRz4px+V5bwtJoQGG+Xz6IwYr04gbeXAUnnLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c5qDFkTd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed835f3c3cso20662875ad.3
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716237717; x=1716842517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7tYjQOKUhhyypRv+20xcgSB/ZPEIGDyWUW6MmS8mUM=;
        b=c5qDFkTdGW/PkzxKKeC19A10gpemAfXqRD6QFIiBGcrWjQH1Yk+DMgRZ3sUkWVjUvl
         uLnSjKX+gueJ2JS0QjrZNiYu46IoGMT9W2buQcHovUkMTpVVJET65QI083rLJGQheHly
         WwaDX5m+tO054qE1Ukf/NgHLlcam90K0hLJGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237717; x=1716842517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7tYjQOKUhhyypRv+20xcgSB/ZPEIGDyWUW6MmS8mUM=;
        b=GF4q/JwOo94yVA29fAF70/HT433SxA99HJ7gSAV5birjPO7ESkuo22ObOGNoYl9tse
         FKMlTnO3hbg4PzMz2JoSa1i1f+DfGaiJPivb3zc1zmgpASIFyc4j05OE9l7wZRc6CedW
         TR0suXY9a8dNqHhwn9joIRVLqiP5EvUE7Htyn1UfWYPVVQz8Jopg99jev+J/wp6i477h
         NB2Fhmx5QKio1f6HH8/T1c6TNhNK5iVm9jjDSuaCr36pvHMmnmLcev3MlEHcCyPJxHcA
         YyQ0nbRwxmUH9n3Q4nBjCpxDmoVrvY+wRrPNoj44d0WUTariYmgHS3bRT3eLxhnP1ycF
         Xyeg==
X-Forwarded-Encrypted: i=1; AJvYcCXnhV9WyCJXwu7ngz4Uh5+8z91h7fm8Ja9RVt0isrPm2iggWwv25HQjpRf2mmdngA3rzXdJX0tohIQg7Po1TemiaKjy8Iz5
X-Gm-Message-State: AOJu0YwldmdMG1Au8Iyn3hCgO2qWBqZWS2EXo3yCLnFG+PjQvKHrg5Nd
	bjKv3OrVKqu7eKr0iOcgIP0e/LTdkz2UVH+gLQLjdvKHLRL+7UupPh5ROXZ6ww==
X-Google-Smtp-Source: AGHT+IGUEKmCgcmIHfXp6npZuZGjuJx5A/FAe7BpLxOGHhZPiMoBvbnihDQpbFMwZRHpWh2syWfS+Q==
X-Received: by 2002:a17:902:e54d:b0:1f3:590:71d9 with SMTP id d9443c01a7336-1f3059073f7mr34219075ad.2.1716237717581;
        Mon, 20 May 2024 13:41:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:cd20:112a:72ca:4425])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bbde9d7sm213068255ad.106.2024.05.20.13.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:41:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hayes Wang <hayeswang@realtek.com>
Cc: danielgeorgem@google.com,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Grant Grundler <grundler@chromium.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/2] r8152: If inaccessible at resume time, issue a reset
Date: Mon, 20 May 2024 13:41:11 -0700
Message-ID: <20240520134108.net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we happened to get a USB transfer error during the transition to
suspend then the usb_queue_reset_device() that r8152_control_msg()
calls will get dropped on the floor. This is because
usb_lock_device_for_reset() (which usb_queue_reset_device() uses)
silently fails if it's called when a device is suspended or if too
much time passes.

Let's resolve this by resetting the device ourselves in r8152's
resume() function.

NOTE: due to timing, it's _possible_ that we could end up with two USB
resets: the one queued previously and the one called from the resume()
patch. This didn't happen in test cases I ran, though it's conceivably
possible. We can't easily know if this happened since
usb_queue_reset_device() can just silently drop the reset request. In
any case, it's not expected that this is a problem since the two
resets can't run at the same time (because of the device lock) and it
should be OK to reset the device twice. If somehow the double-reset
causes problems we could prevent resets from being queued up while
suspend is running.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 19df1cd9f072..6a3f4b2114ee 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8554,6 +8554,19 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
+	/* If the device is RTL8152_INACCESSIBLE here then we should do a
+	 * reset. This is important because the usb_lock_device_for_reset()
+	 * that happens as a result of usb_queue_reset_device() will silently
+	 * fail if the device was suspended or if too much time passed.
+	 *
+	 * NOTE: The device is locked here so we can directly do the reset.
+	 * We don't need usb_lock_device_for_reset() because that's just a
+	 * wrapper over device_lock() and device_resume() (which calls us)
+	 * does that for us.
+	 */
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		usb_reset_device(tp->udev);
+
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


