Return-Path: <netdev+bounces-227304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C4BAC214
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E381920508
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0B257427;
	Tue, 30 Sep 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRyzqPCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD491D5AC6
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222154; cv=none; b=eh2Pa3Yxn55t2AVgSRPTc4jd/mpzWckH3NM5xAYRK87rgTIiTD5MI1lOANGuMqUBImvtnCOwugpl6r1ip/IJxzb1CYAvW969ixCvk1gcdYjE1upU7Wf18E/3PmNrRd1hfjnTDKIPuQPj48FHzOaJ0RXew/S6Z1Ic3To5KUp+QwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222154; c=relaxed/simple;
	bh=FaBjq+b096JR3LdKULnMiCshllEkboYo4jX4SHLBShU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aTZCGP+Yp0qM0I2wXvhy2q6k9YSm6OxJFO2aTFDlS4PDjOJJejw0oI/ugruQ7+uQ2f8f1xFM+ncBCQ7vol7iGLblfDnvWafkXwx/tBgTqVvOKrCnaC7keBLnnqa8p+ZizmTNbZLyFcNEWIJwAUuhi0Ouo06jfMd+KPm4zxN/HUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRyzqPCL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77e6495c999so5620482b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222152; x=1759826952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNx5UNuWQA/zkctg0q6HtsfqKmsRWnVIXyFIJxaX1Ro=;
        b=SRyzqPCLlVX2tnaEhDXJj8j0zBSe8aj4cQBz/RiyhFhgQTZmSnAeYkAIN5YQdXgJCd
         tONuV7VDGke9GRE16Dy1WGhEs3q470nEG14QDtoQJhQU0WDue6K0INWT/31Ec98CA0ki
         1MV1rKSAUpqCMgW45ftOG6uyzPIWUatN3STKG7GAxOdRMkjsaXfkov+U4xNYEUPM0jeC
         GSodKLX+FOOOGnHOEfMyVPMxMrXvmYBRN9jndQzqmP6ZJEWVX9CeoM+u2+v/ITNeoYxW
         +FrrTJe4O6gEdZd3xh+y4e/pNjdf+G4J1JAoQmsCjRLXJFEk52prSiKfw8+VmiUnHi/3
         V/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222152; x=1759826952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNx5UNuWQA/zkctg0q6HtsfqKmsRWnVIXyFIJxaX1Ro=;
        b=SA1FcfkeyUMGZRi6RH0L5vqIrYBmendUUAZcVqtwcn/MRin9I/Vzz+pzqcZ4MlVub+
         dfrZ44JO0ZE9pTsNtPbpbHw1yX7TM8jn2ybWnG4p/H7ZTD5pl+ePa3sF+luQQRyYf8zY
         nGwiro9P62mxIlz9/K05QcauSvv9sAPlxLzaOU2O93xc4BmqSjY9rAS8axzFz4nS2jgA
         W0Xb0MEuFqzBp/rp5AvafbUASmhWZcc6pqchJLhklURiqCW8CvPGjjUqtuUCIItuET23
         yW7S7m7d902yZ0VXXXau40UGlxPjwjCtbzXVMjuOOUdqNJvZ67LjM7wuOtukF/cnIO+h
         bk3g==
X-Gm-Message-State: AOJu0YzUD8TV9UhFOv14ckoNTwdP68muooEX7R1AlsFDYs/7Mjb15HAd
	IdtvKEthuKlPr+Ao7GKFY0tqFHz86ptEVC8O0eQX5mFS3c8KjUkhDmXw
X-Gm-Gg: ASbGnctWriXyYQkW274XY20naHcHcvLJ9G1oplaCWTQiWQ9cGbMsU3xlNsEh8vDC99R
	tzWAZqc7CQ7FmlmMrqot0dnoxFFXfpRlKRY/NgYZL3Nty3z9nefL/q688bNzEAZGHHJOnG5lx3y
	IIIJXzJymHLuJyLjbbm6B1uVSKeEW8Fz1Yxy8cHFJnUugoyClqzegWmKNtW1bHnpL4ndnJ2ACUp
	GKbB9E2WY465nqavecREOuOgypRWx5IMsJhDqwQaqbCgUq9HhP1pecLGot0sIUSIraxri6xDAdF
	8HTvxcQ5Hh0qAZIJ3EF14Wr2/BD4MtpPS3yoOpZrYp8S/fPK3DKS2RphWRPSyQKYQ8XWwmxxtUK
	KcgwDOMZ1OLtzjtG1qDRxGCJuMR3dAjahHiC8u8Oa7Z8VyHt9n+y84EQpROcxLda/lTPDxFAPJQ
	gvE4YrdncRXA==
X-Google-Smtp-Source: AGHT+IE30L2/jMrX7//iknNI4i/8WYK8VmjjjICdaX47Vb7tDhZeTRtCGU+Y0joFglyA+Qss2C08tQ==
X-Received: by 2002:a05:6a00:4fcb:b0:781:2271:50df with SMTP id d2e1a72fcca58-781227153f2mr13698060b3a.19.1759222151659;
        Tue, 30 Sep 2025 01:49:11 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.102.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06e72sm12894187b3a.83.2025.09.30.01.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:49:11 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhanuseshukumar@gmail.com,
	syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Date: Tue, 30 Sep 2025 14:19:02 +0530
Message-Id: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported read of uninitialized variable BUG with following call stack.

lan78xx 8-1:1.0 (unnamed net_device) (uninitialized): EEPROM read operation timeout
=====================================================
BUG: KMSAN: uninit-value in lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
BUG: KMSAN: uninit-value in lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
BUG: KMSAN: uninit-value in lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1095 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x999/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766
 lan78xx_probe+0x225c/0x3310 drivers/net/usb/lan78xx.c:4707

Local variable sig.i.i created at:
 lan78xx_read_eeprom drivers/net/usb/lan78xx.c:1092 [inline]
 lan78xx_init_mac_address drivers/net/usb/lan78xx.c:1937 [inline]
 lan78xx_reset+0x77e/0x2cd0 drivers/net/usb/lan78xx.c:3241
 lan78xx_bind+0x711/0x1690 drivers/net/usb/lan78xx.c:3766

The function lan78xx_read_raw_eeprom failed to properly propagate EEPROM
read timeout errors (-ETIMEDOUT). In the fallthrough path, it first
attempted to restore the pin configuration for LED outputs and then
returned only the status of that restore operation, discarding the
original timeout error.

As a result, callers could mistakenly treat the data buffer as valid
even though the EEPROM read had actually timed out with no data or partial
data.

To fix this, handle errors in restoring the LED pin configuration separately.
If the restore succeeds, return any prior EEPROM timeout error correctly
to the caller.

Reported-by: syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9
Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: The patch is compiled and tested using EVB-LAN7800LC.
 The Sysbot doesn't have C reproducer to get the patch tested by sysbot.

 drivers/net/usb/lan78xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1ff25f57329a..d75502ebbc0d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1079,10 +1079,13 @@ static int lan78xx_read_raw_eeprom(struct lan78xx_net *dev, u32 offset,
 	}
 
 read_raw_eeprom_done:
-	if (dev->chipid == ID_REV_CHIP_ID_7800_)
-		return lan78xx_write_reg(dev, HW_CFG, saved);
-
-	return 0;
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
+		/* If USB fails, there is nothing to do */
+		if (rc < 0)
+			return rc;
+	}
+	return ret;
 }
 
 static int lan78xx_read_eeprom(struct lan78xx_net *dev, u32 offset,
-- 
2.34.1


