Return-Path: <netdev+bounces-178553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74CA778B4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA64188F43E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243201F0E45;
	Tue,  1 Apr 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb1AqoYL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6A1F0986;
	Tue,  1 Apr 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502721; cv=none; b=pwlmRVwzJzBG9tpSSkPUydYxZuo1q0ZZY8mmY7tRh4lEHia5EZ9MYCumhMxIkNsyngRI3oxAn+060yClFQJ2GDCwt5UMbQhXFXDudHDaWc4LyQ6gPbwrHJI6NmFspK4YKbq1nPyar0rEkkBBTVcsksxUUpVA2O5F5sqCHCnDI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502721; c=relaxed/simple;
	bh=c50V6tQVBqAf9hFBVQTLRlrMxI4we7B1IjHR9mZdbbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIkyQVETBwUYgUU3LRGFKZF7j6VP/9UtdM2VF52MyNy8xNgrtK3EOFyPVmRWcMR7EN75GJC1HYxesNQ7+eWsIGkggl/GtPABglvhT8VN+PjjnGwudGI/8yvqQEFuwY4rHj8weUeg5v2NRbkVQgtC1gUS0B0qqxxRwmmP/7q5hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb1AqoYL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2255003f4c6so96363005ad.0;
        Tue, 01 Apr 2025 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743502719; x=1744107519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52Yyy6tKNAW68e/IV+CVhMLgP7UMspcJa+7anxM/WEc=;
        b=Kb1AqoYLJOX6XfCvFlRVhlDjYoj9yRrZIXnKYi3JBCx1l7Ol2m4v9l8nsngANsI8sl
         VLOj/6wiq5i2htMksfKZgaMSL0HbqoPsNe0/nSS4CIPEMkZ4lVD9MJ4M1dylU+3ueuNO
         Wr6nFz5QEqwqh8jNfzv0XoIRS3/ER1utZRHzPFwRkBzHks4Cq87io982L5KgTLSFZEd2
         237gJo469an1TPRKjoC20q29RZlUfO8WT5NGjK2saCNqoitc5n22sDu1Ac0Ho5ghI662
         1grXLm7J6xUhG4NQekbIuC5TqsLdExWD5sc29HXE71mXKY3ZU9e6hFrAX2G0ml6p+avr
         Arfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502719; x=1744107519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52Yyy6tKNAW68e/IV+CVhMLgP7UMspcJa+7anxM/WEc=;
        b=JQFmi+SZkIeZi9AemMoNz87A6sWqzI1SWIm3TPz2dHCyHd3YH4kJNKwXEllnWvhSu+
         G5UlvzJz6i3pHGSv5Ctg+K4DOfd+XbqeTuUOcOlC+RUAVIEZPDpE3/Y3A/YNNmgjyIsP
         9Il+Rt4PkUIw9I35H7LEVOBc0AbDD4Hu4d1RUdiEhwp7dDVpfJ9JT/8Lznp29j0VCBDk
         wr/642hWwAy8I+QIf9skQ/9w2fTP4EzKm+BBUoddIJLIcBNby+/8Uad10wOF02R3bjdp
         BjGcDyVVOhYs26whnTq2VmUtP0g/1K0D4MreYLCChAzIKmBmeE9fOtP+ZL1uVkOVzHhg
         JFmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbRwbZHwGr+cSU4nI66hz5HERCA0kCgahFmQMomqO16xIbVxg3pq9MSea5vGijaxcYCL6EWVwC5ypemCQ=@vger.kernel.org, AJvYcCWjeLIXBXnKA2lC3dp2NwssKjXrkaGX4tEXWTQtt3EyoZ3ixGK+Q/1ktwWCt5FBqOqZasRdWYpmTgjZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qnKafNKeXGtLjWrA89vLpntIoInKZfAH+sb9aT43RbunzjKx
	keeNAGw6aNR+/rva/MpwicgzEoiLDLk7ucBl7ugl4+MUQZwx4yZvm2QJ89bk
X-Gm-Gg: ASbGncvUzno/Ub1o/vOBM9Z+1e+IkHmFmlWQ9jVvo2BqR1dH/1oqTgXZ+2yd1jZNmDP
	yA3rWcZelkjzBXxV1HH4oZGx2QogpAotGvFSJCflniLylJA9+1ajnTnEUEjm8N3HM+ObOqOH8qE
	zHHOqHMSzq+MPYfLtydjiSfrs145zTNEePXf/52uiP+spKEtL1ULvGNz5qc3+YUIOpPPmTAtfY4
	hnmXY469d3F+j53IQtHUs52DKQzZMUOyAD6e1uvGQxZ5QCNYsxekIJXHJzTkzTkhIfMDo5l9VHS
	kuwGfPGEjWzTTcohhwxJuvQFz2MSVXQPzLaSqbKaiyxrip4hW/Y5T4Vk6bsh4CloNkFW
X-Google-Smtp-Source: AGHT+IG8E+nX/g9arCxFT9vcimbEEY6MEhX7K2Zyy7L+8Tm9Z+wZnUc/i/1mUf+iHWktCq32FC3BRg==
X-Received: by 2002:a17:902:f606:b0:220:eade:d77e with SMTP id d9443c01a7336-2295c0ebb1cmr39150275ad.40.1743502718774;
        Tue, 01 Apr 2025 03:18:38 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f8badsm84595835ad.246.2025.04.01.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:18:38 -0700 (PDT)
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
	luying1 <luying1@xiaomi.com>
Subject: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
Date: Tue,  1 Apr 2025 18:18:01 +0800
Message-ID: <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743497376.git.luying1@xiaomi.com>
References: <cover.1743497376.git.luying1@xiaomi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: luying1 <luying1@xiaomi.com>

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

Signed-off-by: luying1 <luying1@xiaomi.com>
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
2.40.1


