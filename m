Return-Path: <netdev+bounces-107572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AE91B90E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F91C2144D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44D14373A;
	Fri, 28 Jun 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eYCTCnEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802113AA40
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561309; cv=none; b=Nxv7Cdlk141+6c06DQa5TU99HwfN/jSBsatX3Waio4QLdGAEGs5rC+kFktHHF33pm2xBv3sZ64xqSypB+dVPMT/ogh4p9tDg5G77zE7NdY42wWW4hivJRP3aoCfvNpQ6fYkK3fEkiXb68SB2glr4HIPV+sZ8cZFdEqF8W5RxW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561309; c=relaxed/simple;
	bh=Shw1Th3WUaSnOFjbNI7at32oQOt0mlvfcwXzXPPaV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/vtiJLzzEF4qFK/Cl8NESe1rOjaK8xcq7y1mbaHJ7jC62Lg294v49gzm7OQ0J8KHdH3q9juKi90tPGWllCol9/rkL1+azOt8UQWcbJ5FeEuMJpKooXJtPD7Pip/a2C87hpp1Yezky8n4lJ0dOKRlAW8+v4oSg+jhjg9horFOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eYCTCnEW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42564a0d3ceso2557985e9.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719561306; x=1720166106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=eYCTCnEW9krb5wwOB49xOqR70pINeYP8nForsejSWndxMk1O6a8RZU4piolXLK5jfd
         GDx6VtwFTDSXSArEqzVAmZ64K3HLhmBfAU905ndu0fVNjqzbozc3+lZbml+Ts5Mio/51
         PYVDVYAk3FkR1nFIcGKrmqikub0CAIoFaygvjf8Lcxv1/vz3chUTLznd6jVbHcOZBT2O
         2JlirM1AZXsatCosZWCNfyiMkDEyrHqK3pW/zx9ieFkQsBOmoXfoh8qsdc0FSSkMXGUV
         UbEqTRor0nteBH6ZgLbE3R80BFF9H8HZiktwTnPscrInKanxWmc6QXdjYZ4urYlu+/Wq
         5mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561306; x=1720166106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=q72qHrpN/4NcFHtW9LKs1odd7+sdOT90bmbnsmAx/GxtLae/vrRRwkP1H5QWfdgqix
         Kt+OMAK8wu7nyMmg8JiiR7yHGI/ogL9fyMTY4yigWJI2xxy3iu0nuQrPSvK6tv9cb2E0
         WPyESD3rrRPhQZvnwpTGt5V9XRSGa97t3NIAhWKvHCga3UI3oUO7m1MF9UhRVCZMEtjX
         8mKPJCWZ4kII6Eum0guN2AC3JPV6QjxeXmqURu1YJE8fEQ6s6qzyzs60yuV/o96MJbCT
         s3PRXtrX0o6aMIIrFEsHNhtJK0tuT8QU8GA2oblzC6vr+dc+5SWCp4q6MspaK4Rm0waF
         BEgg==
X-Gm-Message-State: AOJu0YwFsV0it2e3fqgt5eNtIQUFcFJCDfHXqmOkm/mXmkUDhoSNhYSb
	vy2xsV2jeKxapiND1h9GSH4XHmZrz5pdQJgC33SPAXrQPRa7Xl6OpHyHHpuWL6Q=
X-Google-Smtp-Source: AGHT+IGiifCBBUGGMqQmM14rawGqq2VVjYx/n1+aIjV9UA+xWr/8uLSHD6yzpx9zOlGgXbQYK2R+4A==
X-Received: by 2002:a05:600c:4fd2:b0:424:a7e7:e443 with SMTP id 5b1f17b1804b1-424a7e7e493mr65717695e9.12.1719561305874;
        Fri, 28 Jun 2024 00:55:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:cb0e:590a:642a:e1f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm23041705e9.24.2024.06.28.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:55:05 -0700 (PDT)
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
Subject: [PATCH v2] net: phy: aquantia: add missing include guards
Date: Fri, 28 Jun 2024 09:55:01 +0200
Message-ID: <20240628075501.19090-1-brgl@bgdev.pl>
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
Changes since v1:
- rebased on top of net/main

 drivers/net/phy/aquantia/aquantia.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 1c19ae74ad2b..4830b25e6c7d 100644
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
 
@@ -120,3 +123,5 @@ static inline int aqr_hwmon_probe(struct phy_device *phydev) { return 0; }
 #endif
 
 int aqr_firmware_load(struct phy_device *phydev);
+
+#endif /* AQUANTIA_H */
-- 
2.43.0


