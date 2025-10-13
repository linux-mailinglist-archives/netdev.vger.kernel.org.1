Return-Path: <netdev+bounces-228899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5BFBD5AE5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98883420E3A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FC2D7DDC;
	Mon, 13 Oct 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6+FqQVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43E2D73B6
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379452; cv=none; b=VPt7yU3meoTzczrtlwcBHTAPx/Of2UNcnZOpkdT4u4tPyyNztd5TYL0xveXNHkwibtLUrbDURolUXRiLe0v4+z5BTzDJO3zeRm1/ppFxNDo9RDneZnAqI7rr+h5FhW6YyRQcveDJiFf1hXjH0eFW2+2FbymvceoXJDePDpowj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379452; c=relaxed/simple;
	bh=lTRDsCs/D5gFRcFqRPKy43626K0S1gYzb3FNCfR30zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTgt1uMzM2H2jpJDwe/JN4CMq7Z733BETFO6vziSCwh2lbAdbHJ4DxYr7mLDrpbbz0AeqN8Z6zSL0/YE4DE5BbI53H711nj1NlIbsZp2AvzUBdtQ33r1EPorQHWqanaDDtFPrZ9dhjpJdU2AxZbivfx2AcgFvcCX2i5tba4b7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6+FqQVN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27edcbbe7bfso53865775ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760379449; x=1760984249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DINigu/lDIdPD/xwaJPV5YAdp8XbvaeBDX23woL7nKQ=;
        b=L6+FqQVNS0oFT9ozdBBWP7pdTaj4G3KCHy18nimmIHLGNnxTmdeVG22/16kkjGCIu8
         K+TGQgR+rrAY9MhTjFXTFjgzIPipWHMEeKMqCicF+RgbrP6gSRygqknUyj4XbIgtjBKD
         QlxjlLCQQxrqfjnjF8GJ3tYYg7NrLzQw55Vft1qQkb/Ez095yVQVGu56x1WSdWlbwsLF
         3WMfb6niwP18M4t3ZMNEY4ntCHEeELqiX7Z7oTzhgOsMCbiuIDxXYzJzJOrScK9Bijsv
         TJjKjaa952davfP+32aqougTHZBT6IlZf1gQWA9qizI9fPwU+JtVvuUKyumbryw6FKhl
         IsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379449; x=1760984249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DINigu/lDIdPD/xwaJPV5YAdp8XbvaeBDX23woL7nKQ=;
        b=Kni5LAaiyhptnPzagyQpL3TUBgY89I8SyleM3bWbRYSA3dkGt+hic0Fi9BX5zbIKqB
         EzCsrpUeWixHvB5C8RIDvdhdYyyrDYsO5wEfcGHuLlY1TIpBZLnK2SLrXEsbu5GPR0hb
         kHypzR9P/tAGCV7nLSBfP23Sy5hOn/bIqtS0foFvHchkuMitWmbMLaacmw1d351Uxp3v
         bJXEdDZwkyTac96VZih3HzlPlJmioW2mpIdV9gEffilz9jt1LSGf3sQF5AJMBEh9DNHl
         Af15FCoVWK3VvrCJCL7n8ZjI8VDjwPSeuxLtSFwB1Ih5uQtGCa3NARqEE0uc/cicK09r
         uYEA==
X-Gm-Message-State: AOJu0YwdfGiV0N/oX2bEz4Rpm6QIGWJvsvxGKqWf99EflySpbYPvjwj2
	k1qcJKnDmLfqJV4akpBywwqgbiWZuRXQoqDux5EpwJJJgK4WfKGRD1Sq
X-Gm-Gg: ASbGncsWPm45BvJRmxO/oTowlqHTypYEKLkO/JgcpA5Jn3WeY4UIZsFCrKzha/xkyJX
	CPoIQqJ1hzmEVCsnUpJjX5aAGnczfyAEXTpJhJGi7RBiFvtMLEwc1LpJnP2KrJgAbeU8GRgo1W3
	IOo06hgg40ARH73/Eh3sgwgCpZnvKCQ0Xr5mUvWzxst/UBcb/DN0j6vdNhBM0MnDXJPE+7mLZwd
	y8muP4A5QR6da0m741g/2gBs64KejCvaQc6DNmz0HtZR24wPiVveYuncA+JUghOwZrCkqEGCRkW
	W4OFS/ROOZJpyr7AB1l+rCedYmLNbfe8J7gZrrp8gdQpi26Khs0eRcMm/IvMcxPVCsYBarjUsXk
	MJAltgjxncLTKjHkVjnlSbEvvd3gxflw0aNIbV0RlyJAfRV6Jm6E9zcixIiLnxFqZLTcWtaagrU
	1Zzy3vrMVYlK6wbV2v9plnblYNHZDC1iUb
X-Google-Smtp-Source: AGHT+IG7x5vmQvO6Mjl28H+yolG/h8BvghF5Ba98451r81jzZMgiuy0qWbUXeKg4Zw+kpWpfF0h6HQ==
X-Received: by 2002:a17:903:2343:b0:25c:b543:2da7 with SMTP id d9443c01a7336-290272159e7mr227818555ad.9.1760379448997;
        Mon, 13 Oct 2025 11:17:28 -0700 (PDT)
Received: from debian.domain.name ([223.185.134.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm140182275ad.114.2025.10.13.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:17:28 -0700 (PDT)
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
	khalid@kernel.org,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH net v2] net: usb: lan78xx: fix use of improperly initialized dev->chipid in lan78xx_reset
Date: Mon, 13 Oct 2025 23:46:48 +0530
Message-ID: <20251013181648.35153-1-viswanathiyyappan@gmail.com>
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

Fixes: a0db7d10b76e ("lan78xx: Add to handle mux control per chip id")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
v1:
Link: https://lore.kernel.org/netdev/20251001131409.155650-1-viswanathiyyappan@gmail.com/

v2:
- Add Fixes tag

 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 42d35cc6b421..b4b086f86ed8 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3247,10 +3247,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	ret = lan78xx_init_mac_address(dev);
-	if (ret < 0)
-		return ret;
-
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
 	if (ret < 0)
@@ -3259,6 +3255,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)
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


