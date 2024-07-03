Return-Path: <netdev+bounces-108998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6F9267DA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520141C20381
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1C186E32;
	Wed,  3 Jul 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vg38uojI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96717F51A
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030309; cv=none; b=HyqztfmWaeGfdN9PjIhhdVLi+mqu7kZDcWqnk/Ml19anQgtTzNBiY/CQDXd7rGJH2JY8YELHYZ2eUT4EOYhgyi5vCGnRVybDuRtaL9+LjZcLskEKidsRx3pl81B0dgcHgy5Gbea5ODwsmt3Jw2UPHe07aE7rvIrY8JNwguuLUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030309; c=relaxed/simple;
	bh=jWXm5HXtzueAdOKs0xkvy0vrctXsPXlYa1NTbuL8g2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/Bu2WKQZ0z7fussjXnbbW7O2oHekC+VRrWrkfEt7M7KdEDpT0w7dxW26QJeN4aCGAGHozDOgoCK3omglLiSydwYNOg1LAVhOMHFaFMMnpExuyKoBEWNtkrbZNyb776KPhQONG15+A5ZNhja2z0+jWfXQlRPKedg69d4m0nsRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vg38uojI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424ad289949so41336145e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030305; x=1720635105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kBFfRtBXCq9sa5mQ7/2X3hV4yzjNzYCR4JfLOEXbOQ=;
        b=Vg38uojIkMxSSdm9JsrvkHn6xfHJzBYRR/lXSJqlE5NFUUShcDzV7S4K2tHPTQaF/h
         Xav27pnZim9poviIcQECwbxrxcl0teOI/RpOuCib1r+Z6P8iSYkXojdUNenZ0YzaI9NE
         zzu7C16ZuIc80xxqck4TSCcJLZTb9ulXougxwxGxEbt92aTDhiqHQfio9ikCtZ+lkpiF
         s2b5bCOCeSYRnRRYUhlxVJoUWyLT1DJ5XbMMrIjWn2IxKV7JhgPodCG0B3yVEBL+XOsT
         thOSXeQb2YxMSBswrjCIHDlADMa223B6T4mn6FpIkqcynZhPO+rnF8njFLMj3YaZCi2Q
         fKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030305; x=1720635105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kBFfRtBXCq9sa5mQ7/2X3hV4yzjNzYCR4JfLOEXbOQ=;
        b=JxzO7BTH53k7QHZMU7Zf5vZUwapV46LjdzcGWJw6IBTHwTiVfFlQMfn4uRurayODhp
         081ie3kRxeNuRjPR2qeKRN7d0ENXPxOFKIJrc8f8ScAZAkSPGlnCbStqzBDwM8Pg0Y8V
         tV2DBNTfGsQCmMkKDxHwGdUGcO6EwGboWDmqfG9ywwohqHVkWBW3eslUKkKpGB7sSPqH
         bWs7q7CXWFxubXlGhALGwkxHVpclgR3dVQVtSE3myXVmo8vQhYjHTgooaFegiwJhyMKy
         ca82CXyPTEVTs9vitcJDX/OCWgbZCfsswVYJEmEYPzOjrimbbvspxXZ+kNZMZV57MDoN
         MUIw==
X-Gm-Message-State: AOJu0Yxbu3R5Rkr1EINDE0IF6wy9aJ4RyF5Lw+6VW5np6MSLpg8HK2Vk
	L35zHOUSSGGH9ToxeyguD4MoT1Xkoz3Opfr0clW6W8oiHoRNt/RCitEExkb4Egg=
X-Google-Smtp-Source: AGHT+IHM+xqXXphyV0243nkSSyEh8redY5/z5ZwzWVJUApzS2y/iFov786LLxvohO46F5A7aYXHiYw==
X-Received: by 2002:a05:600c:22cb:b0:424:a48f:4fe0 with SMTP id 5b1f17b1804b1-4257a02122amr89775755e9.26.1720030305343;
        Wed, 03 Jul 2024 11:11:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:44 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/4] net: phy: aquantia: enable support for aqr115c
Date: Wed,  3 Jul 2024 20:11:27 +0200
Message-ID: <20240703181132.28374-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series addesses two issues with the aqr115c PHY on Qualcomm
sa8775p-ride-r3 board and adds support for this PHY to the aquantia driver.

While the manufacturer calls the 2.5G PHY mode OCSGMII, we reuse the existing
2500BASEX mode in the kernel to avoid extending the uAPI.

It took me a while to resend because I noticed an issue with the PHY coming
out of suspend with no possible interfaces listed and tracked it to the
GLOBAL_CFG registers for different modes returning 0. A workaround has been
added to the series. Unfortunately the HPG doesn't mention a proper way of
doing it or even mention any such issue at all.

Changes since v2:
- add a patch that addresses an issue with GLOBAL_CFG registers returning 0
- reuse aqr113c_config_init() for aqr115c
- improve commit messages, give more details on the 2500BASEX mode reuse
Link to v2: https://lore.kernel.org/lkml/Zn4Nq1QvhjAUaogb@makrotopia.org/T/

Changes since v1:
- split out the PHY patches into their own series
- don't introduce new mode (OCSGMII) but use existing 2500BASEX instead
- split the wait-for-FW patch into two: one renaming and exporting the
  relevant function and the second using it before checking the FW ID
Link to v1: https://lore.kernel.org/linux-arm-kernel/20240619184550.34524-1-brgl@bgdev.pl/T/

Bartosz Golaszewski (4):
  net: phy: aquantia: rename and export aqr107_wait_reset_complete()
  net: phy: aquantia: wait for FW reset before checking the vendor ID
  net: phy: aquantia: wait for the GLOBAL_CFG to start returning real
    values
  net: phy: aquantia: add support for aqr115c

 drivers/net/phy/aquantia/aquantia.h          |  1 +
 drivers/net/phy/aquantia/aquantia_firmware.c |  4 ++
 drivers/net/phy/aquantia/aquantia_main.c     | 40 ++++++++++++++++++--
 3 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.43.0


