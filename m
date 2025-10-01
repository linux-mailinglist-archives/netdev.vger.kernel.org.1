Return-Path: <netdev+bounces-227480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA02BB070A
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA14A2D5F
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D72EC563;
	Wed,  1 Oct 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBSpN/gT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA22EB864
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324466; cv=none; b=rmOrogHIt+4cUOi/m2e/wn1f3tYoniqIDBrj5ToLMQph4uP5aX9jB8093uYN5bP30s4oD+Y9Zdm/ac8S2sc6Iax5uXp8ksCWr5dzWPQwIsyo0eFpIqO+v48cclPO8WECT4opWyv4Xk5/jSsZ1vMZjpLV3AnOlBsLiAXWkZvhCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324466; c=relaxed/simple;
	bh=5o423ZijRvd8zuSTV5jup258SDTngq09c6GvYer2C1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qV2HYkAuXtp/vUd+Nl5HSZStNat1hCujgsuoVo+C/72HhVikdntJoQ1iFW4y0KYNb1gvCxOKopfhcGTOgiSsAnBf5wRSzpdjeoDYNw8LRPPA0D875ZwMTsYWnO9Fm/L+FXJuW06JNZOxgyqlpgENXkR2rxqeq7AV+vZhFRnGSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBSpN/gT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782e93932ffso3914397b3a.3
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759324465; x=1759929265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCTEJhugcYnaoj/BbhJFZS8Yru0sn+mS/h4vRBTxOWU=;
        b=ZBSpN/gTcUNQzuoRLQM2ZWMU5eEII2WEGyVZYx37w4F578Zc/2UuQ3ehmZjwcjbGad
         0d60oiOJTQOVgAmFZT84oFqRhuDbwHUTwU/rsPB+NzqHZQ8Em8r0WFCbJu911liZ9sOl
         bgU31V/KjOz6571B3RhiciyPpfqdlzS6LU06DOgHrqkcqYNANKrxM+aodu7qlqB1/btq
         Oy+AMA+RpQFPcqOUI5ElWxyI8nVo742m/GxMsijimNbtoBrx2r67AUTWq87c+6WC/Fbb
         h9W7Rd3xk84k5LN0Orm0bbDVQO0VFjccD7ndHztnaPHAi/rFzr2fLS83XHD/P9WdPbZr
         h12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324465; x=1759929265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCTEJhugcYnaoj/BbhJFZS8Yru0sn+mS/h4vRBTxOWU=;
        b=m+gPl+thlyvq+sS5ambm4GUWsZh6BozMOUKIwvjk9UmBvmw2sfQ/YbNpEmdjaSgdgo
         /WVRbNJ9dd5Y8thJICMNLoWK4c64DLInKwFY6OALxodiMDjbRnCr9Uq/xW22VxBqM+6s
         WDU8/22z614ZUoFZLfNG9BOrYP0Gm1mF1EKI/VBEXBMxh/WeBg1vKwi2xB9rdr1pTbUZ
         K8N3YHhci7IC4O8IUU6sOx8N53+codk02H5Su349z95Qx2N/5zwKiIEII0wBWcnhI9c+
         BvZTJ3P6L8lVudP6L3q5FoF4QWjAMw37RC/9W9WML1ziFHX6fowC+gc/H4JMllP6YTCE
         x/dg==
X-Gm-Message-State: AOJu0YyrYOdn9ubLoeQY8AB+YLtOERB5LikAAwTxcND1lBtANwTKM2Im
	/Tmy+c2svoPwZa0nqimkdmi+Tp7sPWii7Gu2Ze8GcflxGtnhMQnT8y8H
X-Gm-Gg: ASbGncsbLVBP9DOKKB/MXz7mHXSImWSgcOAveSYXt/wJFPZoRho+eCR1qlJp9hQoSnf
	utUuXYsYpANuWMZxgyVbi0XZpzif0HuVcxpbObiX9XCFEt8apRD1ekwBj7VhDDDD+uXjlTbCvi4
	FyZ/fkVIw5M4DOTG+SzXMTPsQHmhuqumjAr9QT+KQv5zyKxp20ivthbb5GlOInpq1HRRNs7oJGY
	wgx3MUKP8YZPmGXuDyybhmFLgYkZs1Sjhhc3+i4NSOwtDlID2LKZTz0W1tHOQx1gN6q2WUjtP6y
	RdO+mfzJtikzkwsRfx5F/YHqAGBTbj9y31jI1Mh78C81HuHqk/eYGhITtuUjGGrlnLJu7RDwaqG
	bzsr0cvjlG/vCtwWv2BBM8fcrNixw8eC8YSghX2OwF6wgCSOiyZzCFn4a1h4C8XOVsJVtomCcAc
	Y5iANvu8gmZud/4gNb7yhnrXcyXsn/KZ6wqi4sndZ4HWS5ppQ=
X-Google-Smtp-Source: AGHT+IEmzoGxhoPxh6/P3t6DmI1zkLDTL0S0tBdY+wi8AVFx9T7GOFm/8D8Q0FXSalhenNgGW0DD0A==
X-Received: by 2002:a05:6a00:98f:b0:781:1a9f:2abb with SMTP id d2e1a72fcca58-78af422e5admr4501627b3a.24.1759324464584;
        Wed, 01 Oct 2025 06:14:24 -0700 (PDT)
Received: from debian.domain.name ([223.185.128.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b231ebsm16308139b3a.52.2025.10.01.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:14:23 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net] net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset
Date: Wed,  1 Oct 2025 18:44:09 +0530
Message-ID: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->chipid is used in lan78xx_init_mac_address before it's initialized:

lan78xx_reset() {
    lan78xx_init_mac_address()
        lan78xx_read_eeprom()
            lan78xx_read_raw_eeprom() <- dev->chipid is used here

    dev->chipid = ... <- dev->chipid is initialized correctly here
}

Reorder initialization so that dev->chipid is set before calling
lan78xx_init_mac_address().

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 
KMSAN didn't detect this issue because dev->chipid is zero
initialized from alloc_etherdev

 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1ff25f57329a..f3831ecaaec1 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3238,10 +3238,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	ret = lan78xx_init_mac_address(dev);
-	if (ret < 0)
-		return ret;
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -3250,6 +3246,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	dev->chipid = (buf & ID_REV_CHIP_ID_MASK_) >> 16;
 	dev->chiprev = buf & ID_REV_CHIP_REV_MASK_;
 
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
+
 	/* Respond to the IN token with a NAK */
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (ret < 0)
-- 
2.47.3


