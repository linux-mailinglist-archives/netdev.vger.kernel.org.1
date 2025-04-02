Return-Path: <netdev+bounces-178735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19058A78980
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5601893F94
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD623371F;
	Wed,  2 Apr 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbyweyVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E72AE77;
	Wed,  2 Apr 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581215; cv=none; b=cWrEH6TiQNRxbAPEdRJMRiPK0ZfzV3T1CuDxebL+wUinxkxCjGvWwWeTQtlM2blwm8LFOLeoF009OlaFdAEo97/vLESV05xVHwAEVqSb3597yfh1EVRYqTOed4m8XURQ6BwEOhynDyf4aQzscsgwFp7ld9QVyeJTXjvYmKwIdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581215; c=relaxed/simple;
	bh=/VjWcZ5cH+0vCcujemH1+2cZi3cTODx4qemJPcVGxqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBlRV5LJh/F9+rrXqgJ5QJmZ1jKZusJoGKmLUP5veYFO6hhVo1z1i/7F5jRx1BB6d3Qzuv+BmravGYnQjcdbX/BU2kfEtLrg2iSfUI4cC5B0tfCTCfGB9cHT0Wg6v0DE8wRWXCCnpH5a9ft4VZFP7yNaPdcdzsaueXeuy7J7jnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbyweyVm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so54767975ad.2;
        Wed, 02 Apr 2025 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743581212; x=1744186012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKmxocXjRUA/4+7XD5VePtJPwnQ6HQ3HUsu9TwT0U+k=;
        b=mbyweyVm18wNPgYVsVVIosOcHGlMsdziUE8wJDyHMtPrEYQ6dhGFFjpsjP21PS0Vjp
         gRkRM2Qk57OJ/TirXoi+iq4Uem57lBNZipFCv7Obgord6K6LOW3OpBs01qTVz2degCGU
         8iR8S4/U+o7AEU8pmXp5JM63O6ume6RCaeRH8ziSLvoW4nXONAYzUczS75/p30t/gg84
         WhBtYxgKJBW0NiiuKSoDq53ar5No66+D+ZjZmA8atCa0j1dtnbGs4RSJmJVai0kP1s1f
         ypJrYNjiiOoSpTy12z78/ZRf8IZpGM0wFkB7oBixk8lm8AfXZK69l1mOuRo8BJQXFN0A
         Wayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581212; x=1744186012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKmxocXjRUA/4+7XD5VePtJPwnQ6HQ3HUsu9TwT0U+k=;
        b=VOnhvo/3HvdoeKQ+LTc9zkqOXjRMygCJPuh8ilrW2+3Vv1jL4wpXJbjf6dniXynC9F
         bFSuJqmRuXojP+apdoRDbplx2cyMvY+0241vIg0KmIgLoFjukSps8IYYfj6mb+R2+O8X
         SYuxASjloUoouS3DrgySUQbZer5s5Xi+nVjREnTGLDWIdZL70sp+Lp3Hdt8g8sP91BmL
         IEZcgBvZoGdCotWKbD7W8eTxZ8U4u5+ZRwLpWUX1A37ghuOy7HZs72dNJzlcFoOE56AN
         Xnyvjyl3kLher1ykrX/pRqYOxOtJ3ImJm7c1DS8fTequ3645u7HqI/C/jKQ7zN2S+T6p
         3Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCWMk5/NPa8KAetucwFUeyNQgGatGNpvJefnMTijNrDiRY7vT+jV8m0VwMdyFEny10U6ljN6sSqqiY5r/c0=@vger.kernel.org, AJvYcCX4aymH/Ju3YIhM2gUOtQV5BmOZ7CD72nf06PL3i8DmJNAtxPWuyge9MPvmOWD2abSlO4MnuGM6/ykD@vger.kernel.org
X-Gm-Message-State: AOJu0YynalgDbEUfcujj1LLLm7+oD4IJ0tJyvK7hKZY8CIzvzSKvD+wF
	h0X8xQeGk0mWJuJypu6dy8sb4sm+Sq6Mwc/IjPsINYxRygj1yK5/
X-Gm-Gg: ASbGncsuorqi6CSXFPfG6/8A0SluLhtfRORlJnbLafhF2O+UUFZlQvKPOblrjceYXlr
	rfikwQTuq5dKYcryQBlnhL4PKPf9U7fEk7JBtTyZAcjfvK6kPU8dScuJ3WJ4vqm6HY8EGPvEfCI
	CrNNsYSu3Bs3c/axqgeG2TR59aTVQQf5gEqAjTReVlTEcMzIUDlFOUaBzJNAOwud57ZPIS9noQh
	rqBdA+RKIrkUld+T4McU6rMpVujhfVUq8vD9JXhlM2ZcsMTRwNh3EQYC7/RbBkbb87zDqoe93SX
	OK8rF6fNfbSJOmh4AB1AbCyzwx6JbxTW98ZoHrQmUoxy9zuqKs//IbeMOnTrUsP3mmB6
X-Google-Smtp-Source: AGHT+IG2F8OBzvyqb24RWg2VBhzCvhJab9tiERehzg+VCEhjAAZnxtN+DMo7uNe4mpJxkLUIzqh6TA==
X-Received: by 2002:a05:6a00:1945:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-739c784f91bmr2353308b3a.3.1743581211895;
        Wed, 02 Apr 2025 01:06:51 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710dccbdsm10639665b3a.179.2025.04.02.01.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:06:51 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Ying Lu <luying1@xiaomi.com>
Subject: [PATCH v3 1/1] usbnet:fix NPE during rx_complete
Date: Wed,  2 Apr 2025 16:06:29 +0800
Message-ID: <11211b6967816ce4eac2ff5341d78b09de4f6747.1743580881.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743580881.git.luying1@xiaomi.com>
References: <cover.1743580881.git.luying1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

Missing usbnet_going_away Check in Critical Path.
The usb_submit_urb function lacks a usbnet_going_away
validation, whereas __usbnet_queue_skb includes this check.

This inconsistency creates a race condition where:
A URB request may succeed, but the corresponding SKB data
fails to be queued.

Subsequent processes:
(e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer
dereference (Kernel Panic).

Fixes: 04e906839a05 ("usbnet: fix cyclical race on disconnect with work queue")
Signed-off-by: Ying Lu <luying1@xiaomi.com>
---
 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..5161bb5d824b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -519,7 +519,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 	    netif_device_present (dev->net) &&
 	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
 	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
-	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags)) {
+	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
+	    !usbnet_going_away(dev)) {
 		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
 		case -EPIPE:
 			usbnet_defer_kevent (dev, EVENT_RX_HALT);
@@ -540,8 +541,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			if (!usbnet_going_away(dev))
-				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
-- 
2.49.0


