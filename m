Return-Path: <netdev+bounces-104989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD990F65B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77C71F242EC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8601159565;
	Wed, 19 Jun 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B7PTfcsD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAA158D99
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822768; cv=none; b=iyBufmkMfc1qcAOe1tk87fR00Pxc5fPa90CJXeWioKcBtITBXshPyqbvIW56ByeAgnv7KbuWVpEFj8d/WxoTj6rfQbAXfkv13gGBB4o6bYFEjkXPJuS0FcNFx5Eu4sWy5TJigICZbyW25P5QXo7FV0AjHpxxrjbMlayjmfcEuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822768; c=relaxed/simple;
	bh=Gb2AtUPIZLOqvCXJxTsfKyEo0Y1lWpbQs78ViEnJLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvF/B3XliPlwU6RjPXJSxJNoxrhDDYQbBd4iZJHc2Z9kWlEX2TzcXfPaQ422AzUcscPke15lpTkbnZ6lWYnv6sWy5kL1CtIuTSRgZQ3j6SYsEn3RGdCVS4XyALD67uxURtR2waMC9TxCZ+bIYgatCQv9gw9cEg8Cg9iAK9MnCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B7PTfcsD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3636c572257so93282f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718822765; x=1719427565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2ZaP1GIFake6LOudA2QCXAqpH6bV7MuTKm6aVLhChY=;
        b=B7PTfcsDSXbyDcRg9LalOo7qedZye4tGXhCXAUYV48UBq4EeFq3zXLSEFXIFH15DwS
         oUvk44dQT9R5xrlkPM3AKlXs9sB9kEJp0C18gHErO7vhZgQY2FW54XqJPWT7/sEZxPDk
         84tI+EyOaLCtidTCer3PAnRXUD96FHMDoPjitlmfdVvdeveDCIzf7EFVVgxWut4H76Ml
         u3RROOmLoFmhvd3KiZGk74KGk4MDKHTwEcbjxOfD8L2MvCX1dhiaD5A5DpTHIy41YyRA
         oFhvWRb/VaA9lw+hYTCmWYtPUZ4987dm/73v5MXBsqPNMRANjE5dV5XIK7y64EP36h4Y
         UFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822765; x=1719427565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2ZaP1GIFake6LOudA2QCXAqpH6bV7MuTKm6aVLhChY=;
        b=sBHUNz2cIqKuBYo6c38n1Nh+CUgxK/OPMVlxZpw3VrYXX+Y0yGlO8UGv+Cj9QivR8p
         O2wPEu2dOxzQ6r3NAlipVrPv1oOTdUXIDmxujsQicdu04TY0Im5fIM/LSTkmd2RvGX0j
         yGv+ml5MplarutMpUa43VBSq3iERwK32jbkFrJ3UH6uy3CJLwb/K1UXd6LwJlV8H2w6e
         NXInYT2RlUTh8wntHayJqPJpDV0XpspB+m1XO8wpGL8qEiXn2M9gsDx6xSiAZ0gH4sk/
         QBzWiAp/BM+O7lvg97yxhfkie46EuqDy2+mPJzgFTQxUcKlEJrj1l88MspOqxLf6K6Ki
         QR9w==
X-Gm-Message-State: AOJu0YyTrrLLGLzWgzvQvZcartpP7FofuzoDHkkXVlwNk24V8Rcb61pr
	FOKppGLhZ0FPPBoSv+yqgYqOoq8Z0ElDqF9Wq0rHZ/9yh3FAHD8mA9iYogfj8wc=
X-Google-Smtp-Source: AGHT+IFHpgEdcFxPeHRNEDbOoGGaHbIDTAIRX4vjn/KLZAdtQ8VVBfo3vmxuKjBv7nIHdarP5mwF1w==
X-Received: by 2002:a5d:590c:0:b0:35f:1eba:cf66 with SMTP id ffacd0b85a97d-363199905dbmr3314238f8f.61.1718822765554;
        Wed, 19 Jun 2024 11:46:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36098c8c596sm7594156f8f.14.2024.06.19.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:46:04 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 3/8] net: phy: aquantia: add missing include guards
Date: Wed, 19 Jun 2024 20:45:44 +0200
Message-ID: <20240619184550.34524-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619184550.34524-1-brgl@bgdev.pl>
References: <20240619184550.34524-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header is missing the include guards so add them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
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


