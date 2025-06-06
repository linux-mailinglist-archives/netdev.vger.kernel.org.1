Return-Path: <netdev+bounces-195477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF7AD066A
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC1A188DCF3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCC28540B;
	Fri,  6 Jun 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmV6czw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5314AD2B;
	Fri,  6 Jun 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226059; cv=none; b=rTFIzEzBYYHMPAJ/Y4VPWEDVUpO/E8TKzU7wfZ23Klwfwoh/+muaVftgUrzdp2eE37ZgwvvVlGxvt8awRBs6s58G74+tc1Ff8T0uK3EcnhPTEWFuTm6GHFxvRH2b21Oq3OkR53RScQIwooxEwaBJVEielpdi+w0ABJPp2/QjqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226059; c=relaxed/simple;
	bh=aCBYs3HYbqHCtSKb89ZiDyardqdxI2f1i3HiuFqwWtE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqvAHktPJv8ke2iqPbNuNMbblq0nS5RJ3dr/ZHJNKnal+4B1AoF1SRdbu2H44b9Zmwn4B9qN5pHi+AUQi/9IpN/P1/rtENpYX3DCyRxsBeKsku8+OkFXvP+RluTSEHcSZnQLlDHLF8JuxIsajwgH6MzyWCbBXEgTAkEBgMF46Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmV6czw6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so15901545e9.1;
        Fri, 06 Jun 2025 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226056; x=1749830856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmxqTl8zXhUJWzbEhSbM4iH/Woj92FmKhTvp/ZOVPhY=;
        b=NmV6czw6ejLXnlWyTEEJFLctsgsE/QRFzEzZJ8WwO984vySQX34oUffkyLsc6t6Efq
         73Muksj0CijOTRtE+qZAATBcYWeE3jxF2nY7wgyHsu++ZeYUukVZ5RlEn6fyTMiLaPRI
         yYRsOqUtOKlGj0kRkN9pi84gx1+FOIe7NhiIi5Gdd7YirbAqY5VqDyc3l3Z3bl4+cIQy
         vbYF5iDIBfNlD8ZD8h9F4N1KDI4VKarkkc8+yHaoNG5Jg+WHy3w5no8xJ+XDF9kKDkPa
         RsD+2cwfzflvUgrbOXqIUfw/I93pQwKCKZ+5aKutRcfGH/+L1lcoTeUo2L5JHNk1LUiB
         Lo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226056; x=1749830856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmxqTl8zXhUJWzbEhSbM4iH/Woj92FmKhTvp/ZOVPhY=;
        b=KyEaaHXnIe3aawiPOyFxLS3tuVMXUDr5hfS4gzKKJSJEpaxfZH6Af/suu5Y2ZyFI5G
         x9o4m9otwMGwWbjvdUjUbnt5UsLkvl7Vx2PtAT9I0ZFK25TP+xzSPtIQY8II9kDoY8BJ
         8ksWa49eHYgQjILcwvHvEoO7bpBLk5gj6lrmYJvqHOD+h1i3J9C59joIpIQ3TDZ5KAsz
         1/GIrvMaHnxPQjR5x6IiBZFXE+iXO63wXUJbYFDUQSgTQTEkqsY+Ko4FfIvPYP6i0UZt
         ttQiN6OsAv4hdLnUejfhFH2sOUlemy2Z3IvByYHe2GtxQzqhwjRF4Ed688yrewRegLXE
         Wcsg==
X-Forwarded-Encrypted: i=1; AJvYcCWNtX43m4eFTlwqHzxI+FbBbZPAyFJQUOBVGf1akfG+PvIRajN09nnN+Uce5QHXgLmP5iKy/aj3IH6n6Ac=@vger.kernel.org, AJvYcCWyDxNGmDWQoQaGBKLDgUof0MfeTeXQ4Y78u3Po+srRClJqvTmlHUbyX1AqOgR1Apb1JQ/6VXkf@vger.kernel.org
X-Gm-Message-State: AOJu0YwByEYvl8iUMquLOS1EcEZZHNCe9fXAy8nNiY3W+3g6tGb0Yz1L
	NdKMi7r6BGfLaa2zFq3CJP/t+C/VMux9QTQsK/I1pY8jr2MupcBLweiYIcpx9g==
X-Gm-Gg: ASbGncsAzQx1T7aOgNxM3PEsbZ5T98tVGCtLdsaxyWnmi2CPTDbUbtwUmWwZ0960mSQ
	/JtKC4ZtT+G7vABrRNqQRPH4jUA9+VR6+yoCH1D6VSG1qxbr5a5idX18Fy2k1fA9LtfIX/K9yK5
	P0uu8Ihn+upWWZw7hsuM0u12ZDjUtoiXd03k+zvLQgC/q2f+tq2aGDGbcI54r65R/qs0s0oLRjx
	SsrrFOfWuTvLkZft8QRsLKyhQ94L6RR7ah/O8vdsrc/u9a2Hym5WIRM+jrylSNwQ9JIJJ/a4Mmn
	cMoAB/CFwBiHZwCuM0PrJxsigMg6gZSC17cqy5uSEIikUzKnuxurI3KYtxxdnLw=
X-Google-Smtp-Source: AGHT+IHSPmMAHUVKafg9JMqrfsTW9IVMgChgGgQ5N7vYRn20mw+68UMyYTnoSjJ3+qTqY0HgNX2N0A==
X-Received: by 2002:a05:600c:a49:b0:43c:fceb:91a with SMTP id 5b1f17b1804b1-452013512a3mr41720205e9.11.1749226055624;
        Fri, 06 Jun 2025 09:07:35 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:44e7:a1ae:b1f1:d5a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce458bsm28732025e9.15.2025.06.06.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:07:35 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ch9200: use BIT macro for bitmask constants
Date: Fri,  6 Jun 2025 17:07:23 +0100
Message-Id: <20250606160723.12679-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the BIT() macro for bitmask constants.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a206ffa76f1b..bfe27a7dcbb4 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -59,42 +59,42 @@
  *
  * Note: bits 13 and 15 are reserved
  */
-#define LOOPBACK		(0x01 << 14)
-#define BASE100X		(0x01 << 12)
-#define MBPS_10			(0x01 << 11)
-#define DUPLEX_MODE		(0x01 << 10)
-#define PAUSE_FRAME		(0x01 << 9)
-#define PROMISCUOUS		(0x01 << 8)
-#define MULTICAST		(0x01 << 7)
-#define BROADCAST		(0x01 << 6)
-#define HASH			(0x01 << 5)
-#define APPEND_PAD		(0x01 << 4)
-#define APPEND_CRC		(0x01 << 3)
-#define TRANSMITTER_ACTION	(0x01 << 2)
-#define RECEIVER_ACTION		(0x01 << 1)
-#define DMA_ACTION		(0x01 << 0)
+#define LOOPBACK		BIT(14)
+#define BASE100X		BIT(12)
+#define MBPS_10			BIT(11)
+#define DUPLEX_MODE		BIT(10)
+#define PAUSE_FRAME		BIT(9)
+#define PROMISCUOUS		BIT(8)
+#define MULTICAST		BIT(7)
+#define BROADCAST		BIT(6)
+#define HASH			BIT(5)
+#define APPEND_PAD		BIT(4)
+#define APPEND_CRC		BIT(3)
+#define TRANSMITTER_ACTION	BIT(2)
+#define RECEIVER_ACTION		BIT(1)
+#define DMA_ACTION		BIT(0)
 
 /* Status register bits
  *
  * Note: bits 7-15 are reserved
  */
-#define ALIGNMENT		(0x01 << 6)
-#define FIFO_OVER_RUN		(0x01 << 5)
-#define FIFO_UNDER_RUN		(0x01 << 4)
-#define RX_ERROR		(0x01 << 3)
-#define RX_COMPLETE		(0x01 << 2)
-#define TX_ERROR		(0x01 << 1)
-#define TX_COMPLETE		(0x01 << 0)
+#define ALIGNMENT		BIT(6)
+#define FIFO_OVER_RUN		BIT(5)
+#define FIFO_UNDER_RUN		BIT(4)
+#define RX_ERROR		BIT(3)
+#define RX_COMPLETE		BIT(2)
+#define TX_ERROR		BIT(1)
+#define TX_COMPLETE		BIT(0)
 
 /* FIFO depth register bits
  *
  * Note: bits 6 and 14 are reserved
  */
 
-#define ETH_TXBD		(0x01 << 15)
-#define ETN_TX_FIFO_DEPTH	(0x01 << 8)
-#define ETH_RXBD		(0x01 << 7)
-#define ETH_RX_FIFO_DEPTH	(0x01 << 0)
+#define ETH_TXBD		BIT(15)
+#define ETN_TX_FIFO_DEPTH	BIT(8)
+#define ETH_RXBD		BIT(7)
+#define ETH_RX_FIFO_DEPTH	BIT(0)
 
 static int control_read(struct usbnet *dev,
 			unsigned char request, unsigned short value,
-- 
2.39.5


