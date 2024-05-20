Return-Path: <netdev+bounces-97235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F48CA37F
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9CF2812AF
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 20:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D513A899;
	Mon, 20 May 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IM2hdUYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297313A407
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237722; cv=none; b=AnxeLqXvIZ0iAE2cPiFvIoOaVNSeab3CRThs+0WhS2Axjh7nWgZxraY/39ISkfVQyBXfch2Xwpq2KOR2Sgti5RW9rgsTrSkr7XWK1anhbtjcTXJE+7SGU1SrYOUPBOP7ef9YTO16/cpYskXmUsTLllheLjRTQO4daAS5HlWY+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237722; c=relaxed/simple;
	bh=KH7KLt1vLHj8lAyyx8nEvtd9Ch2hZ4E0zERhgbKhEpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKbtKHhtNZ8MnT68kIwV1aVJizPJB1E6YTd42yitHmvowE7a5pR8TG9+JN772mgizdgB/38xA65ovvIw4trmWeOjAIuh2Fa9SRrdsTC6hYCcFkkilIxrcfhLnSzcHD2MVi9odKSSa8JFdBLrZIQHmmqpaeElmYRd+UL3n4i5G9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IM2hdUYB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee954e0aa6so57424535ad.3
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716237719; x=1716842519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAPtcTBq5rQklg7My1+KHMw3K3I6I7ZSFTklmvsLyz8=;
        b=IM2hdUYB3iWRPBR7kgABs1XQxgueTzVDUdNmzbFAYE7m7OZAFVOcUSoDbrAA7yTqM7
         zc+c5geP7Q/Cj6TKfe9YOtcrYCsOq7d2oOLKxxnvp6yA7q3WPjdeEKAJGsKVKiGcsRmk
         Waoz7RNRxB/ZWK654A1OXFr8jYXHTxHLnmiNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237719; x=1716842519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAPtcTBq5rQklg7My1+KHMw3K3I6I7ZSFTklmvsLyz8=;
        b=fHRKNt53N6tloeThlZaDGhKEHUNApkgKWmL+xrLoTBQp227+aSu+jNri1UkvEX9vVb
         68YgRcFckJTX1t9dxu8K7cZIPDdczNz9S4h0rKOjNHdYurHJ/Y9+VbpWLxdX7n6CxYjz
         1BFHrGWIDleZ5CPB/mp2thcxE4/yBKFngMHnUv+3Mj9A7xa7zxOkoHg3WwBghzzQtta9
         hIGnTPh4hlLMLXQmiF0hmnDiMZW2rPOatib18xDgqAKzTxP0jAZIYuTktagoUdZp7zal
         FpHu1cyn2lMvyxvOPsGn09oIvJ4KKmT9BBSKcb/FWY0HCkSis4wVF+YusAc2+6/J6KA3
         NFLg==
X-Forwarded-Encrypted: i=1; AJvYcCX3RDQUd9EE+XzUz4bbUw+orVEJBCettuaQQN6OF5GywWRclAGP5mJbwd4afzQEqRYCnmTJLhgq+SUyeik+sTUUcbtSLDUW
X-Gm-Message-State: AOJu0YwEyEynP2phcaY+8r4k6YzJj8TD3jvoM8mCSq4iAYw7xOogY8v/
	fLpuQepitpWcre3UlZ1cIDZx6U52bEZru43euzf1W4s5R/lEl2y3KsaWw4vWzQgkeC4bd4sFyzQ
	=
X-Google-Smtp-Source: AGHT+IGox8QB8PBU2tVVtMM4gyfbOeKz51VVq/e4AHSre+WZ4yCg3glyJBr+5bnclNzM/WQaC0MSjg==
X-Received: by 2002:a17:902:64d6:b0:1e4:5b89:dbfa with SMTP id d9443c01a7336-1f065fde55bmr228544205ad.41.1716237719595;
        Mon, 20 May 2024 13:41:59 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:cd20:112a:72ca:4425])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bbde9d7sm213068255ad.106.2024.05.20.13.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:41:58 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] r8152: Wake up the system if the we need a reset
Date: Mon, 20 May 2024 13:41:12 -0700
Message-ID: <20240520134108.net-next.2.Ic039534f7590752a2c403de4ac452e3cb72072f4@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520134108.net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
References: <20240520134108.net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we get to the end of the r8152's suspend() routine and we find that
the USB device is INACCESSIBLE then it means that some of our
preparation for suspend didn't take place. We need a USB reset to get
ourselves back in a consistent state so we can try again and that
can't happen during system suspend. Call pm_wakeup_event() to wake the
system up in this case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 6a3f4b2114ee..09fe70bc45d4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8647,6 +8647,13 @@ static int rtl8152_system_suspend(struct r8152 *tp)
 		tasklet_enable(&tp->tx_tl);
 	}
 
+	/* If we're inaccessible here then some of the work that we did to
+	 * get the adapter ready for suspend didn't work. Queue up a wakeup
+	 * event so we can try again.
+	 */
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		pm_wakeup_event(&tp->udev->dev, 0);
+
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


