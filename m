Return-Path: <netdev+bounces-176089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A04BA68B93
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C17016D847
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66B2566E7;
	Wed, 19 Mar 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzgcBfQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B362561AA;
	Wed, 19 Mar 2025 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383360; cv=none; b=Q6OhQGQqKBs4xwhivw2I7H4kYlq8M6rDJ1551KrvGHqANXl3/aE9cflw4oYvp1VvaYEIdzk+cWuju49U/VoHmudaAbImyG7mckqR6/BbRirFOUAPSK4as7vZYWqOjGI6/qP8WxKpEQoRw+SV1lc36WtcBnV1BMceVfvdiKFjC80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383360; c=relaxed/simple;
	bh=zl6mHtQV+ZU1gIP6Tu6sH5DzDDCDv5gaX0PKfL0UMSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojXF1WFRrAe5+gARdE5QQVTjk0ICZE/t2sXTUwXOZEfPjfUz+XseHBZHpResOFqoFITVW/+AZ45xLFmsqRGJSAyQj+XYJZAe3u0kYUCXxO5D1Z8sPJ26gqufJvmrJa/yuQ8k5X0t+LSBVHAYhI9XdWYnitYvigUhzfSA+WrDNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzgcBfQm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso31712585e9.2;
        Wed, 19 Mar 2025 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383357; x=1742988157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmnLqMstgAFg7ssuq9RhKNXQtfwhVeH5LoQjqlH9X9s=;
        b=TzgcBfQmD/dPt1H2soLLQjXo8wm7FibdTyoCn3O+L73a1dVn/XnyQo2SxTSa5FFdT2
         c3H4twqLa/u1vka0qOPBmPVfL9vNF2rHS4Vf/Gx5a0XCJnGuT9asimbkkch6YJJYJwnd
         c/Kx+FmeHQa7BIR+e3jK4ky9pmUETEfpmwDeQ7+w1h2wDQqsgVDoxrcUSwlMSuOlEl8m
         ztmqvyarLa7sS1SLjRsQlGegNe8HLklGpM63fnolrgCxtmWy6IK3x2D+Ijdju4w7Lq00
         L9wxCVUNwXRgVbZTmJXG7e5hPzlyqt7PwBWWheCDjVlb2ozV0Cduk/2plKIRr0YuGDZh
         S6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383357; x=1742988157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmnLqMstgAFg7ssuq9RhKNXQtfwhVeH5LoQjqlH9X9s=;
        b=SeY3DApx6ft/ZpmFUYk1PsCTus08c37azVJppGYqvP+cgi/Db5WiPDONWCY3FwQvlP
         hRzSsQ6tDy6DhGqpZ6ZEwDYMhTdnuCmIznbIH+7BDIUaCZ+FqSHAxN1AkH1rH5TaDew0
         ecQpa9FYkOeVOTr4bXlzO2j9oGDFDY0GmaEVhEr7nRNYeJIUJXXh0fU+9+uPXkDbI7F5
         0ceFfS1X0no9g+31QJE+CNoGrqSrCHVMy7Idg8/xw+UiJ3Wd7kQ1cqZV6aujvIq+joZu
         xlbKK970bWhBBwX2O0Ex6fXqCqZlDhLBTGIL5qWGrbMieJO71DOf+CCVbA89C0GPtbYj
         KV+w==
X-Forwarded-Encrypted: i=1; AJvYcCVvF/zmfjf1FvNrB539APcaOew05yzRlkzvOKpZbdNQ4hd7ejdSEcY4YE1Pe+V+P0RXETu0ADETnn8TG68=@vger.kernel.org, AJvYcCXI4qtuqMpvcA8Z5g2OCCRCLZgFVwkQamY0HbwXez03iute5gmqGHxSLGVICFjivbO5VZNTUdIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMIwFAeyZJLoE+dSi0YeiARxSWf8573GXiJvbAo71X6311tTy
	uYASXuI+o1OMdea8fyLZG6z0hQAWyRSrU/o1kugthnpdsWKf1Rhs
X-Gm-Gg: ASbGncuVquwh5uW3mkIhKmZdN1HhxpmO/dZwmFABvzygW99yrSqv3CWBqVE1DYyFVxO
	SdFVeq5cQ4hyQIeRv34jDIa7Lb3MzXZyH2XLd1Bwexcy3deHDKjiAJXnpCDIcKPdR0hRG/jslaU
	iXUE527606KvosLd36uR09V/B/3Elk3ju3X2MNzbT75bSryig5LgE6pL1QPQZjaFdB6v5oJFkUp
	k3D3/A5SApIP6y7lBPz8Yh2UDkm2rICv8ezgDexfGFmbU5CbayvyYApL0kW/6bXCOOK3tOfKN2w
	XODrGVGLTOJzJCUvI8//wU/ueDW++5CqF93uHYIe+AUH
X-Google-Smtp-Source: AGHT+IGThtIACP4EnrX9+iEIa7mQjXDoJ5u4Y3diPXjPa7xzN2QhsMdiAdjIcAWdwck2/2Vz8CUqEw==
X-Received: by 2002:a05:600c:348e:b0:43b:cb12:ba6d with SMTP id 5b1f17b1804b1-43d437802c8mr22122825e9.3.1742383356427;
        Wed, 19 Mar 2025 04:22:36 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm16129995e9.8.2025.03.19.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:22:36 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 3/4] net: ch9200: improve error handling in get_mac_address()
Date: Wed, 19 Mar 2025 11:21:55 +0000
Message-Id: <20250319112156.48312-4-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319112156.48312-1-qasdev00@gmail.com>
References: <20250319112156.48312-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_mac_address() function has an issue where it does not 
directly check the return value of each control_read(), instead 
it sums up the return values and checks them all at the end
which means if any call to control_read() fails the function just
continues on.

Handle this by validating the return value of each call and fail fast
and early instead of continuing.

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/usb/ch9200.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index 3a81e9e96fd3..a910aea0febe 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -304,24 +304,27 @@ static int ch9200_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 static int get_mac_address(struct usbnet *dev, unsigned char *data)
 {
-	int err = 0;
 	unsigned char mac_addr[0x06];
-	int rd_mac_len = 0;
+	int rd_mac_len;
 
 	netdev_dbg(dev->net, "%s:\n\tusbnet VID:%0x PID:%0x\n", __func__,
 		   le16_to_cpu(dev->udev->descriptor.idVendor),
 		   le16_to_cpu(dev->udev->descriptor.idProduct));
 
-	memset(mac_addr, 0, sizeof(mac_addr));
-	rd_mac_len = control_read(dev, REQUEST_READ, 0,
-				  MAC_REG_STATION_L, mac_addr, 0x02,
-				  CONTROL_TIMEOUT_MS);
-	rd_mac_len += control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_M,
-				   mac_addr + 2, 0x02, CONTROL_TIMEOUT_MS);
-	rd_mac_len += control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_H,
-				   mac_addr + 4, 0x02, CONTROL_TIMEOUT_MS);
-	if (rd_mac_len != ETH_ALEN)
-		err = -EINVAL;
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_L,
+				  mac_addr, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len < 0)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_M,
+				  mac_addr + 2, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len < 0)
+		return rd_mac_len;
+
+	rd_mac_len = control_read(dev, REQUEST_READ, 0, MAC_REG_STATION_H,
+				  mac_addr + 4, 0x02, CONTROL_TIMEOUT_MS);
+	if (rd_mac_len < 0)
+		return rd_mac_len;
 
 	data[0] = mac_addr[5];
 	data[1] = mac_addr[4];
@@ -330,7 +333,7 @@ static int get_mac_address(struct usbnet *dev, unsigned char *data)
 	data[4] = mac_addr[1];
 	data[5] = mac_addr[0];
 
-	return err;
+	return 0;
 }
 
 static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
@@ -386,6 +389,9 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 			       CONTROL_TIMEOUT_MS);
 
 	retval = get_mac_address(dev, addr);
+	if (retval < 0)
+		return retval;
+
 	eth_hw_addr_set(dev->net, addr);
 
 	return retval;
-- 
2.39.5


