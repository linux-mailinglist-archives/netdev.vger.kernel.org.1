Return-Path: <netdev+bounces-218492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D5B3CA43
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB455E0763
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B77277CB3;
	Sat, 30 Aug 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCFfXRae"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257E214210;
	Sat, 30 Aug 2025 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756550275; cv=none; b=Ew/kB2yeZwAp2lxpqsrV1LBynrQ26gKhG4oRMARgrejPbqlmkEoHO4MaE2Vn4JLZv8MxHPX9ks14i/dqUSMVwl/T+5jJ/qgBuS+vXhjI6Y1XJJVGi3pmuBJmM6i4A/Ph34//f/M0ngeiGV864Cvxkvz8YofpgVj3WWq7uEloYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756550275; c=relaxed/simple;
	bh=92s0xkNcJcNFoJTJ9YgU0ubfeA/k4I5bNPkZ8gIr1Ck=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dFJMV8oGTw6oApXhnUDIyg+l+Y08kjf3dzPiE5T8QcrNveVr93aDdWMWIZBUE+M38mWl5E0G4tSwsNH1HcROMGAhoPqwHBLoORF2MPcsdTvtUhGpnMlZYFgoDvXFhb/RHakZdUuKfK8tx6pJqk1SYqBzFRnoOBtY/yciFXoB7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCFfXRae; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323266cdf64so2458401a91.0;
        Sat, 30 Aug 2025 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756550273; x=1757155073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdmEievJd3EEga1bSy7r02AJQvZ6G/baQRGFflIOctY=;
        b=GCFfXRae55wuiQLHyKXWQLd3pOZZ4vEUaJmy+PWtP7ui0i3hnEG7mUFjQWAI3Po4O0
         QO32fTtZJRgQosMbt/IeE8QqCQB9AzX1Y/1n8hPVU+M8QPdX6tNCna3/77EoCkmJILiI
         SlRYiJcgu5I1Z1UJ0TGqKEE+vh3/qBgzGF/Zd2Oxq4ttjOFgAza6IRhWiHW+JY1/+zii
         XYhLhFPxMmzwZ+edAvCCs82N6V2vHBD+rtiRO7RFZtKQMutml8bEw7A2YdGGTtaV7ndf
         lTBhMF0AGGdy5iuCOeDB/UEU4Tnuc3D6wq9vsPcjTFyExKYxexpsaB6BzXtkLEOf4oDH
         EPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756550273; x=1757155073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdmEievJd3EEga1bSy7r02AJQvZ6G/baQRGFflIOctY=;
        b=tPZ7OMyinQY2XzdyJuXxFlgTSqrJ/j+5KgpV+gtCY0J7pA/WwWxff+yU4B4bAhhUbl
         yi7nwTl0x9aHqq6KhMUeKTGTws9yl29KyT+/flclYsVof/FTq6DdJ51u5eLyT6iHfvLq
         sJwcL2Zy08qQ7RVXuwdiKgIHbYSs3HlRWDrGMqFzL6zyaFk2sZP+qHmvvPPFsiZfzb4l
         sP5f8TVMnooThRddm4z47GX6s2H8D2ZEQ0JRjb2iQ8sJkIBYu8nmVjjOKTOGJx3QSqJe
         RdgR6qcoWVXM8o1pKBvBRAkNrk3uyBWDwYSu24lM5/u+voODwQmlCT2EReXTWznsfZc8
         fmVg==
X-Forwarded-Encrypted: i=1; AJvYcCU3hTrB9qEpFHXLtmWA/lWrYqaB89hlCgdH1Yve2jm0HBpnz2Ca8n7oohNdU/SmWeh1BQpc1ZKn4xeN9+0=@vger.kernel.org, AJvYcCXePO82u62aQlL3/fLS5KbexjSz/vonQu27VMHrBOLYB5lq/yEa4jWNi+bSvDe1L2hLNqlQuqa70ehO@vger.kernel.org, AJvYcCXlWDcBagh5eZiTNJlUuqs93PDrB983LCCTbPaN0ZzvNSsDAqTFnIq3QTBoIzeqCBZ1CWpDDeOa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rvSfQJJRVSnfi4d3v+nAYtlRK0+T6isQwyU76+68pwMADtHm
	VSRyJpcSqUcVbUWhRCKVtaehR5i2z9dp//PEV1EW3auvSQ6zyyz96+Ji
X-Gm-Gg: ASbGncsHopqa+R9vTQjqh4txoNbyLbP2V07tNVDtTv9idKFvUlj6d5vseW+VaqKtvDS
	rJgjr9q1DaSY+E+M2IBzHt69rommogBiqjCApwuk5U0bnaJ/7xrBBLcYPQjkv4fg+JHkwhaE7P/
	eCTgox+rdAHZGrRNFOv0uEp+5phf5E1eoWlMAIHdUKEpJS0v9ygolT6vWrmx5CAjqYFDTcv2bbq
	dZnJ3Nx6HHpMXagLVSascjuZkb4F5DvMG3TfcVmuN9RBAXoqLyBKBRzfVdE97cCRDIOqnBye4gH
	ahI5eKBVaJa83CompeyFiPdprdrGTfFxCFemCwGVqhZYDgv2dwb6BHxfb5S183a8LxKhANVRqls
	RbWkd60HmzG1LsOUKdN5locsJfEoLgP9Un/vXkWSV9870IsoFuEvsxjMbHsTzhRUXzNUpWxlF4c
	w6ejGglUGx69mRWFU9t7kFNJH8OSLwi9atb7jh9CWnULxO3A==
X-Google-Smtp-Source: AGHT+IFbTIicJ6cs6FlAg9iL117Ehvwbzc0ORL6rHnLDCmiNTAlFUCldexDRLUdmq14XMrH3ElwbjQ==
X-Received: by 2002:a17:90b:4acf:b0:327:6823:bfe with SMTP id 98e67ed59e1d1-32815412a3fmr2366254a91.8.1756550273475;
        Sat, 30 Aug 2025 03:37:53 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.36])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327d9330b73sm5446673a91.4.2025.08.30.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:37:52 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Max Schulze <max.schulze@online.de>,
	Miaoqian Lin <linmq006@gmail.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	David Hollis <dhollis@davehollis.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: asix_devices: Check return value of usbnet_get_endpoints
Date: Sat, 30 Aug 2025 18:37:41 +0800
Message-Id: <20250830103743.2118777-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code did not check the return value of usbnet_get_endpoints.
Add checks and return the error if it fails to transfer the error.

Fixes: 933a27d39e0e ("USB: asix - Add AX88178 support and many other changes")
Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/usb/asix_devices.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9b0318fb50b5..92a5d6956cb3 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
 	int i;
 	unsigned long gpio_bits = dev->driver_info->data;
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		goto out;
 
 	/* Toggle the GPIOs in a manufacturer/model specific way */
 	for (i = 2; i >= 0; i--) {
@@ -832,7 +834,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	dev->driver_priv = priv;
 
-	usbnet_get_endpoints(dev, intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Maybe the boot loader passed the MAC address via device tree */
 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
@@ -1256,7 +1260,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
 	int ret;
 	u8 buf[ETH_ALEN] = {0};
 
-	usbnet_get_endpoints(dev,intf);
+	ret = usbnet_get_endpoints(dev, intf);
+	if (ret)
+		return ret;
 
 	/* Get the MAC address */
 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
@@ -1609,4 +1615,3 @@ MODULE_AUTHOR("David Hollis");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_DESCRIPTION("ASIX AX8817X based USB 2.0 Ethernet Devices");
 MODULE_LICENSE("GPL");
-
-- 
2.35.1


