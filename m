Return-Path: <netdev+bounces-245627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736FCD3C70
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 08:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB44E3008188
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9122126D;
	Sun, 21 Dec 2025 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHLwz4sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B81E7C08
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766302062; cv=none; b=HVW8GB3spB5NjYmH5wQODExcQSuW772wI2y8MvNL4KWsGVdkDQa3+yKyTgEfL4vJlx+S0850pFMD1y3lWgmQgM7Z6vTKOuDJahjgNqUdkARM9V2NW6JUpoASmIRAHth0G3sPaYzFId0XoFKptFqXJgcsDsQYugEcu/AOc2C1tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766302062; c=relaxed/simple;
	bh=OFBH9JXYTuzwL7xJMrI7r72JcUFWjPidM4uwnB32Ccc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Un4/d/A04NAwJh8XcV3LN7sb5+cEyGnxgiH6h7sAERGom4lwQaefr8ogaaERPNJaFHaXlw/tku7KIpojnEvefmJp29s10eu/L+ScqHH0Csbn9Eakd3QAtQsCWMV1L/WvfThyADuT9iIrsMH1OH5yqz05aaHyUpeyaTt6TgiwVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHLwz4sz; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c1cf2f0523eso2025064a12.3
        for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 23:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766302061; x=1766906861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5nVr4F2IsFNHBVH0b376Wrsf2MVlBQ/1H7ahoWdGv8=;
        b=dHLwz4sz7So8RNrbwwLCSLfsJtHM0U6KPbEFMsCzM13wBFtohj0PlzzDf0VAJGWYZf
         c8cKMH35R+wH8rQitTHyplf62U2Vh+bkZPJyKrknxAr2hQ1BNtOhGLT5D6PSyhI2E9EY
         DvT1kMbIS6fMDlDswnF/8Dxmj+ViZ/2XZM6G/kPnIymvig7hVr7gOsL22zdZLil/vUSY
         h25pkjbQymcGM2WP8mH1OZUMDsqnFzkGXw8cuc275pZrx6txcgVsnW/IKJ6Fg/de9A2M
         elk3LExmy5lyP9JsEM+mU2htsL5tl1HSGp7uZx18rpGWFdbZIHGa3BJSXPMzfCO4W4t2
         jjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766302061; x=1766906861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5nVr4F2IsFNHBVH0b376Wrsf2MVlBQ/1H7ahoWdGv8=;
        b=ppL3fl5sDUq7Gp/xSqgP4eTz9AYVlbqBkNbhlKPayd6ltk8yT2WJphciFtro4o8W5e
         vddegcUgNs1whQBGOnJFqOXwY4vcFkeudlBazhElDxE8yZ7jfyC/A+tDjOWP1m1qj1SP
         mJ5JTsiCf48z/zYXx9SynUjF8bYgtc5AdBBJCRVyp41i2ZSbFoRbJzC6W3SEDiEAIxUv
         mSy+LyTsJPc5FrkPfsX8MPQBZH2o/AwXuEFXVb1XGyBsIA20H7yQlIwkCxmydtbP3V0b
         UEqGaVqT8Yo3cesPZcfctBBCe2XP/Sm13POHCD9C4fU5Ct4WUuYOyuQYor9M4qhMfVzO
         6Hjw==
X-Gm-Message-State: AOJu0YyGeqKuCjeE0EkKIRdrSjh7gEDGJjyuek5BzkpTt0nJJFNngnc9
	V5g2B/FkD2AuY/C467lEe7UWE4BMVmrAdjiTggX/EKVSJAUJIIy04eg+Ca6BnbRIoNk=
X-Gm-Gg: AY/fxX7vcXY0qNViz9XF0coRKa2sWca2pf9p6BCjYEc6Ku8Q3cuqXq0SgSYQ19gO+mS
	YVCgKpGr5deEnHbb6RixnJ9hct0Sz2e0CHKv9k55kZLV8itMl1jlEMwUTem3veZBR+9Qmw1ROZG
	AYlhZzLQV2v3Jkt4d9OWQeJDSe/rMVJe1kcT8lFdDwMUZ9tzTjBd/27Px/lpVPndO4xl4L8bftv
	2Zbu5aQJ5cS8sU1vc7Qb84IVgY4/804jH0GfYxUIsfgbOYJgnu3O/xCoOkpH5wfe3tJXLxsYlAH
	zHtsAXp8xbc1XXrUQfSLlZp1/UZCE1de9Z9wTnXDlWPejJ3ghc7AC4KXi7lJSzYuugcnuLaY+b8
	YbMTo2fxipsUl0GWQfbTw1IB9L3hC8Kq9xwl4sZW8ggRruazpg2UQWXTyqRvki1vyTtOfi1213r
	IEDwcTalFgw3ozempq6FRqLYPiAAecLikiAxqyX8ejaey98V4OhEG1WYqPFTqKvvtB4PEv1kV0R
	xtg4DwcvAziZJuotqkEY2yJutDRjakEv8vpzCzud4ms7VFeByNDkAQWIiO5x05ZgPPpc9yZ39b7
	1ggVfRXzsK7sESk=
X-Google-Smtp-Source: AGHT+IHYhBbx1sfAleA1fyjs27t/9A+6UeX0264Df2HtgYmcmrVoMwf2Od39C4y5eb9Fjzzeuyceug==
X-Received: by 2002:a05:7022:b883:b0:11b:923d:7735 with SMTP id a92af1059eb24-121722abe66mr5765860c88.1.1766302060552;
        Sat, 20 Dec 2025 23:27:40 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm30289115c88.17.2025.12.20.23.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 23:27:40 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-stable@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH] net: usb: sr9700: fix incorrect command used to write single register
Date: Sat, 20 Dec 2025 23:27:32 -0800
Message-ID: <20251221072732.41426-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the device failing to initialize with "error reading MAC
address" for me, probably because the incorrect write to
NCR_RST is not actually resetting the device.

Fixes: c9b37458e95629b1d1171457afdcc1bf1eb7881d ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 091bc2aca7e8..5d97e95a17b0 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -52,7 +52,7 @@ static int sr_read_reg(struct usbnet *dev, u8 reg, u8 *value)
 
 static int sr_write_reg(struct usbnet *dev, u8 reg, u8 value)
 {
-	return usbnet_write_cmd(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	return usbnet_write_cmd(dev, SR_WR_REG, SR_REQ_WR_REG,
 				value, reg, NULL, 0);
 }
 
@@ -65,7 +65,7 @@ static void sr_write_async(struct usbnet *dev, u8 reg, u16 length,
 
 static void sr_write_reg_async(struct usbnet *dev, u8 reg, u8 value)
 {
-	usbnet_write_cmd_async(dev, SR_WR_REGS, SR_REQ_WR_REG,
+	usbnet_write_cmd_async(dev, SR_WR_REG, SR_REQ_WR_REG,
 			       value, reg, NULL, 0);
 }
 
-- 
2.43.0


