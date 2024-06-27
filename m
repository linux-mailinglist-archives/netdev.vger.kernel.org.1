Return-Path: <netdev+bounces-107226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FE91A54F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D561F24E90
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E801552FC;
	Thu, 27 Jun 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q8n0qOnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BC14F114
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487832; cv=none; b=jpFdvChBT6maRgSpOTAAnw/maDmTVw08XXJmSeMZ1fPcHTzpQBnmz0VRCUm4biEcNbZdLEVnQiWr1NJOhu39zX2Mn1R56ohAQryq5ifIjzWmWGz7cOJYLhzH6bfEvWHc1jSXKH/rAylceI/8LcgjjxoZkc+iZMAhJnBLRuuuuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487832; c=relaxed/simple;
	bh=qT/I0vbZRGDpE8yP1ELoiUDNULDJ0duW33V+A0EfTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEo+IP3lMJJkJmUAoZvE48Y6OGbG81S0Z5Gb4U04wzerorrwS3uZyZji0qPH1zn5HrZSHL1v8InBn+hDm2Vgku9f3VpezmxFZvHII9jnV1vrqIxuzmy9oV+gPOVkcNBIICvh9E2saCx7+Mc3BXbYT4z+uNP/D8dxgBAb59vI4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q8n0qOnU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so5967706f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719487829; x=1720092629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=Q8n0qOnUBq9zJJWxJLsFTL8v5H7teQ9On6bxDJyP0jsB6I6mB75nXCNLLKnSoqyYem
         E9W6QZ+JOZ09VPyTutcSLARe4Vv/+ZldjLhJZSKOuN5VPQMsFq8uuwhx0uj37T3koeOm
         WmJrNzsniWv8nfu8cwjZBtsd2iwPuDBK/fdMotY1Qh/eyvLn7VwbGRF4KBDWXaerNf1V
         P9y/klJ/J5RF7f+YH9JGGf3+ZSMfjLJOZUG2qL/VwnSaHbpioes4EuOOROvsqWurLAvZ
         BtWhzgOOQleLdtaBIEE3qMAR0/hk6Zf+b5o8e6mHVaEHcr3Bh5X1NxIBGrEffzTi0QIt
         ZPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487829; x=1720092629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=YDgS83hjzqUPXPW8iDz3oQ0oI55TOjUyVozlF53S1xTN5dhhAN724z6Lyjy/qcu9Z4
         U4jpwGob2A/AkVPk/uClJwvLFCYgbTJmd6LTzFKlcj/vZqd9pCQMqDlIYW1GPqL0Htjw
         FtOhYoG38ydhHH4S6xc9HPDN/geBdYV1b3+7vPTe+FpYWuxm9NpQWEq9MfGIdjf5sDkc
         H/PhZ4ymYfZUw+5NqT6Xj2A8TVEJjyRlybWQduu5yTzdA/eTeiNqemNp6AMs0cvoxTpq
         K8oixR9TGh+KjPWoCAGuYnpsRoaTjGt/os/4b7du62H9a/kyD6YpzzVFuFNtXFeyhsvK
         eGAQ==
X-Gm-Message-State: AOJu0YyY6G/0PmdmO0zBauYlLrPy7EB0hL2Og1/s8uaTpv4WpN6d1Due
	dCsDa/O/MKXAVIG8ymmo+aUS/rIZVQVdTlacmWVTBncOHC8XHnI1WPz3S3DN56g=
X-Google-Smtp-Source: AGHT+IE3DkKA/w8nX9UijesIIy/Krp9fMCKxcp6E1gIBE/pfr/ALQIhI6+lVmY51WFB5RS6DUQEf8w==
X-Received: by 2002:a5d:518c:0:b0:362:3b56:dbda with SMTP id ffacd0b85a97d-366e9463e46mr8283279f8f.9.1719487829229;
        Thu, 27 Jun 2024 04:30:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699ae0sm1504111f8f.66.2024.06.27.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:30:28 -0700 (PDT)
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
Subject: [PATCH v2 net-next 2/3] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Thu, 27 Jun 2024 13:30:16 +0200
Message-ID: <20240627113018.25083-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113018.25083-1-brgl@bgdev.pl>
References: <20240627113018.25083-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Checking the firmware register before it complete the boot process makes
no sense, it will report 0 even if FW is available from internal memory.
Always wait for FW to boot before continuing or we'll unnecessarily try
to load it from nvmem/filesystem and fail.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 0c9640ef153b..524627a36c6f 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = aqr_wait_reset_complete(phydev);
+	if (ret)
+		return ret;
+
 	/* Check if the firmware is not already loaded by pooling
 	 * the current version returned by the PHY. If 0 is returned,
 	 * no firmware is loaded.
-- 
2.43.0


