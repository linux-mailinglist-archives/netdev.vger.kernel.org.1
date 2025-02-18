Return-Path: <netdev+bounces-167458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA935A3A5B3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE631758CF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19F1EB5F9;
	Tue, 18 Feb 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9+MEJHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611621EB5DD;
	Tue, 18 Feb 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903613; cv=none; b=uc6goQfHqjJfGmpEsnPNEoBqUf2hdCyXcUoCOZtlhAOY0ElCWsCNwZnzuzG309CPQtCEN9mxIdgIxw5mOgMDu2W/i2xUKQRpz/IDWQBLOqD650TWEMLe1yzIAsLyIpfZuz6fQVVELeXTssRt4LTPpBaDsFO4ZiU09tyZTWT6Hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903613; c=relaxed/simple;
	bh=a7xxArifSqoUNuUiASsUcLtWKFdUe5cdQ6OHmWqqMec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o+NqTfolhjkzl+CLCTwRJgKTzHBC7YNpexzevvuA1iyHcvocYUpQ32eu3PV2o+j6V/GGfQidTyOtEbgAkas9kpqDQ1nfoZUHlo4fWe9uhuiD3Smgp4K6kAV2lZ63trJ/8vn9KLmxl8E23RrrdvKl6WweIRm57LO6zNt+rOUtJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9+MEJHx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso510305466b.0;
        Tue, 18 Feb 2025 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739903609; x=1740508409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0wku/+vbQC6cNSgh1t9pHcqc2r6GMmksAaZN9T/kDg=;
        b=B9+MEJHxG0Be1Y4SLjKLgDfeY+M/Ni8ooaIFE86nTA2FFihDj+ppk0KA2+NuZp26Px
         klODwK6HC94QKE0iIAaOscmVHKC7ixIV38l3psdcClCVgwtT6OmS6RMvHVG1LbMw7ilQ
         jL41JIRRE8JkIgMynOKA6YstwguaQiXZIAFn50JKx0rioHb7UvPNklJkQDn2xEQK6DDB
         vnF4/y17X4Sxj2N4nPiVZSd9e9xaLdEF/YsEQ+rGVUrMMSVo1bDtdjDUvIBueTg5Phr6
         lE/qbjYAZhJF6rdZEMb803DX+1BHXPX0bA0LvitEXnW/GVZJaXHUUb3vESEGXUSAzhp4
         HJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903609; x=1740508409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0wku/+vbQC6cNSgh1t9pHcqc2r6GMmksAaZN9T/kDg=;
        b=rGf0o6Wob6u1+FYds+PT4LHIloMXlqrUQ2Kh56iQ8jQyVFBLY/paOfl2Izk2hMwcvF
         SV72O6XmXmUJrt67E+NcJFYzWNYv9P0LsUYJ2D4n4fVO/tBqQSTSiN6kkB7zw+mthq1Q
         AsdrItP+8AyG0zeS82PD9HnRd9cHv0lXajdnm3yyzIDRp9dlbYRzOgZ3MnB0Lbmzb1qO
         ekQl67ERSzYwgRCoW793XeZqJNcpGj7rcyUKZJNQKS5zjiTGWTubPOWgEUFmIHTcz2ly
         ylllBUskpQV02Kreg8yoIAHcM7KUR77l3iAOzqELnESR3/e7gJnFErMa3OmHCGwm0FZv
         LPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSa7qB0QedB0OjNoe9L4XDETQDdZ4SOx8A7eUiWSPp0Fqm9Z6IMwN9uSRnp7AScbHLJ+otK67yGytzTiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ODYa6IWYXTnrzx8UrTYbn5hX2RNEK82MBjVfnskYzzmh84ZI
	GDSqE4P9hFUpx9TrhVDi2KN6hvBufboI0TsFDwCvnQvMzAwDPPZcU/g/aA==
X-Gm-Gg: ASbGncs77y2Wawg6xYwtlDT7F9lwTdvykBf3FW9Gv3Un8nfup38q/8s+jXGScSSCqNh
	joqk/IsIJe9zCqO7PvL6x98BUE05UnAXsfcd4IqPvpCtvNavjQ0Eu7O2uSG3XX2MjmI+hmxR1yo
	rEgQzI5+5tWxeQzH2liKlCcAplO04YRJLVzRIUk0//vsJ4gB2TQPov7Vb+5NXXnno73BEiiECHB
	/cabjgR1xk/mZtiIBSOq4EKBuZ/gw3XombUW0NgXv+jCoZKulXzmwRnN/edeLsDrDzl1ioSRPa4
	8emLCj+54YSaL3d8cn0=
X-Google-Smtp-Source: AGHT+IH1RkH5dR4zJimoGShBmnj/PMPC8b+qa4Bmpw90tbk84qegAfDOW+rFTCagJ9Ej9of6eAwgLw==
X-Received: by 2002:a17:907:7e9d:b0:aba:d801:9d31 with SMTP id a640c23a62f3a-abbccebd0f4mr65233366b.29.1739903609091;
        Tue, 18 Feb 2025 10:33:29 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:625:3600:3000:d590:6fca:357f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232039sm1106649266b.9.2025.02.18.10.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:33:28 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Tue, 18 Feb 2025 19:33:10 +0100
Subject: [PATCH 2/2] net: phy: marvell-88q2xxx: Prevent reading temperature
 with asserted reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-2-999a304c8a11@gmail.com>
References: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
In-Reply-To: <20250218-marvell-88q2xxx-hwmon-enable-at-probe-v1-0-999a304c8a11@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

If the PHYs reset is asserted it returns 0xffff for any read operation.
Prevent reading the temperature in this case and return with an I/O error.
Write operations are ignored by the device.

Fixes: a197004cf3c2 ("net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 30d71bfc365597d77c34c48f05390db9d63c4af4..c1ae27057ee34feacb31c2e3c40b2b1769596408 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -647,6 +647,12 @@ static int mv88q2xxx_hwmon_read(struct device *dev,
 	struct phy_device *phydev = dev_get_drvdata(dev);
 	int ret;
 
+	/* If the PHYs reset is asserted it returns 0xffff for any read
+	 * operation. Return with an I/O error in this case.
+	 */
+	if (phydev->mdio.reset_state == 1)
+		return -EIO;
+
 	switch (attr) {
 	case hwmon_temp_input:
 		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,

-- 
2.39.5


