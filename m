Return-Path: <netdev+bounces-107197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C7091A466
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072B91C209C6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF713F42F;
	Thu, 27 Jun 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1gUPtnZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0113D61E
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485943; cv=none; b=RmDVGgdebTLkLZqtVjexJeQM6IjoZLXY9GkqmYyUVwsvqkivxejc3VDRHryXdRcyAaa0LD3h/P+lrxj1YH5n6oTltJFTPopE5ugjcJnb1XbcACzpe5UlY/aB3klvy7j3qBtnaSTGZX37P+GS+GI0mK+G2lm+exJbqfZwpGAqBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485943; c=relaxed/simple;
	bh=z57g3uCdvjXuRj49fNkurZjircHT6W0I1kG0XtfOLUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+xgShF/2DvKYRmSVrE2MMHZXtwk7ZoMepHGDu2/jXRY/FQ5caCC6Nk3izeAl+E9j9MbLhvRveqIqW+jhm0Gb+APj6rwX6UtjedhID/1mnZfmbbZ9ZAiiS8EPaHzTneOWZfOe60fKWus24SSQ/PLfAdUZXmvg9xmJ/7Tl9IlQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1gUPtnZU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe785b234so85702241fa.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719485940; x=1720090740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZV0c9kgiqV8gG3kEpoX0nM65939kr+amcfqyF8vm9s=;
        b=1gUPtnZUKXMT3HWJJWbDGlxdx/+iiCwHRMwC4O7pWuSI8GvD2VmXp2LvXVAydQvTw/
         LB96yhNu76oyLDEL+FyHBMehzj2TN6nWihoLKLR0gixc99H1VtLmBgn4Et/apdRSnI1I
         4/j2CdOg1ASrtdi+chjVbhgaTPn3TOX0z3589Qi5x1GSirkDT54Qdb2imvldPiOLrluy
         wYtpChWuCrsvkcBUwXBSAgrGTnaFIy1v5AWYQqQa4L9BAAx+8up5LRVMv0GdrgotWzj0
         OL5qzjj5s+3oNznB92S6nmHgYC6PN1bVg2S+FUqJQLCShsgudD5bGOFBhP1GPvQwCeqk
         c8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485940; x=1720090740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZV0c9kgiqV8gG3kEpoX0nM65939kr+amcfqyF8vm9s=;
        b=K/riqziEJdLNR3zzLHoNrsJmm0m9qmop9SjJ2Yg2zAVh1fH1XG/tpUzKnfGyRIMAFk
         PDJR0MG1cH73D9W9iXt1eD6vkn4AtswIrhhWrRKRLA9c+F3hYjK9+zCFgxG6eUhj8vsT
         822yPggMQ9QVWi3OIW/IBbguAh/3cP/F3L1Y7a554l0rTHC13iupOte7YzcODyxPqL+n
         FfWFInzv1xxm+5hzW7RR+rhUnFlmEQ8NPS/v3itZdoJiSlEYALKrekjOxbn4n8Mt3UdZ
         b7cQSi9wh+5/l+HXWGx/Nx6QNPpeaO2LKL/Va6zZ/ojsUJl/T76g/mXihH7UMWNMq6Ve
         x4Cw==
X-Gm-Message-State: AOJu0Yx83IIfWtBsA0TMDy8bsiZkkTP114iMO8m7kqd+Gh4jIGAuKY0R
	UamI3AqJhNmu9M8Tuqfp8QKF1Cec0GVDua+1/sdo775wyGoS67C+I31cgUL8IFwCwGAd42eDUGJ
	D
X-Google-Smtp-Source: AGHT+IHKnaB1GKK958LRMoxlWlJjZVfp/KDChOu1D0p1jZTWC7mugwsykvQ9bMn2+NsTJbJLR8HYXQ==
X-Received: by 2002:a2e:9001:0:b0:2ec:56ce:d51f with SMTP id 38308e7fff4ca-2ec5931d31emr96371381fa.20.1719485939978;
        Thu, 27 Jun 2024 03:58:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8246828sm61612895e9.5.2024.06.27.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:58:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH net] net: phy: aquantia: add missing include guards
Date: Thu, 27 Jun 2024 12:58:45 +0200
Message-ID: <20240627105846.22951-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header is missing the include guards so add them.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Fixes: fb470f70fea7 ("net: phy: aquantia: add hwmon support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Added the Fixes: tag and resending separately as a backportable fix.

 drivers/net/phy/aquantia/aquantia.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index c0e1fd9d7152..b8502793962e 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -6,6 +6,9 @@
  * Author: Heiner Kallweit <hkallweit1@gmail.com>
  */
 
+#ifndef AQUANTIA_H
+#define AQUANTIA_H
+
 #include <linux/device.h>
 #include <linux/phy.h>
 
@@ -198,3 +201,5 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+
+#endif /* AQUANTIA_H */
-- 
2.43.0


