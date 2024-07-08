Return-Path: <netdev+bounces-109754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44470929DB9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B11F1C21CF2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBD47A73;
	Mon,  8 Jul 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bcc6folD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607A3BBE8
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425035; cv=none; b=KpLHyKOodAtm6ouxQCGMg3a6O5uDwfsKxHtC0e4vGt6aK+sEYx4JHuzwyHR+W22BlfqN4FP+0kp9qVWnxH8+OBcT5Y69kP/3N/Td0KYB08OlGMDqQRMO22NXS/1OmLZ+BsSOSRBKem2Q5872+KgX5r+ZfyhehdHqSdQG9RxAZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425035; c=relaxed/simple;
	bh=I8ZVS0D82/R3RtH++gdSA2BpSL5i3uiqUGmj0KpPRmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQcMwPNsfaZKaxqgo96MlhQFDnio1jYR2eMqaqbXIgImCiIrqSsnkXUwlOF27sLWnC7Iq9h8VW/fFzzSHeTaVR1NEvb+SEvx+M32vlXlX+iJjpLoeOfHzH35V0C2uqfpcdxdPeFDADYeWslxIdNCARgiDQwR7JiBddlKlufd4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bcc6folD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4265ff0c964so11138685e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425033; x=1721029833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=bcc6folDJj1sY3nQvsG6Hz1slvmi+IszcHp3OwgDcz2dOitWgcqcih05h5W7ivgjlo
         Fc4VXFXdk2MJ1aPEbW7+Zp/NrQbaLPZhUiLjg6/u+v8OeLCq8obv422hEtpe8LuWiVuq
         SPDxOotlvvL1GXT1yzseeNNnyn8tABxBnWsvgDeBo8Qs34cMOgsDcpLDXcJ0EV1zRJK1
         mrvjGzTtN02whD4l1WgyRPTBNfyn+MRVuknSD3g8jjPLCMF7DHOVRgynAV4tL8j5FZ5S
         HckPw5xragSqy4YILi+DMSw5ds1OlH4WygbljVdqkNFADPcb6NgCvHPPbFlBR77W+SdE
         yOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425033; x=1721029833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH3kXkonM31DpQhN/1Hxs8pfB1Bit5q7zwIm1RL/Mck=;
        b=OCtQZJqYMjcLQwABGtLt2SzjsJP711+r9+rhLCfwPd4xdzfNuQRjb39wb4ICMzJR9v
         EHumbpLfis4q5OPUU9EIsYjh2EnmZfQ+HGoi59WQypB+HFA130rBOh4MlnpO203W6x9H
         BL8bzc7VHzp+pVt7IGOOXjEtMXiepXy5wo1tdcbvS+AGgNkUpskcb4J6gUKdwmbMmkKY
         R43WtM0v2sdLChy8cWnHVsgfRKFsFogWe6T81Fi8ufZROFRotq9PxZ2VFZ5Wa+CJAn09
         9CSsPCz/7iAN2crRJRxMLt5kNbFVp2apw7FJqA6Lxy+NfGNQsuNY1oXSXfxihdXwJi1l
         U4dQ==
X-Gm-Message-State: AOJu0YxB/egXJJfxyUbG5tT3DL0H5+4vdl4gIS94fZZMZcETK9USccIQ
	UBNHRP2LNp5NPIFauH6+CUpxKCj2766mIoCCtQcNnwwGbgmJQ18D9GsavP7ADOM=
X-Google-Smtp-Source: AGHT+IFGHXf42qjKEYiucDNY+VpgnwFXf1LC7psqdBVMRctd1Pm+BjeZFIZfnElzKyJyj7JtJC18Lg==
X-Received: by 2002:a05:600c:1d03:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-42666675d11mr20254685e9.4.1720425032668;
        Mon, 08 Jul 2024 00:50:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:31 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values
Date: Mon,  8 Jul 2024 09:50:22 +0200
Message-ID: <20240708075023.14893-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708075023.14893-1-brgl@bgdev.pl>
References: <20240708075023.14893-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When the PHY is first coming up (or resuming from suspend), it's
possible that although the FW status shows as running, we still see
zeroes in the GLOBAL_CFG set of registers and cannot determine available
modes. Since all models support 10M, add a poll and wait the config to
become available.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 974795bd0860..2c8ba2725a91 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -652,7 +652,13 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
 	unsigned long *possible = phydev->possible_interfaces;
 	unsigned int serdes_mode, rate_adapt;
 	phy_interface_t interface;
-	int i, val;
+	int i, val, ret;
+
+	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
+					VEND1_GLOBAL_CFG_10M, val, val != 0,
+					1000, 100000, false);
+	if (ret)
+		return ret;
 
 	/* Walk the media-speed configuration registers to determine which
 	 * host-side serdes modes may be used by the PHY depending on the
-- 
2.43.0


