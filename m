Return-Path: <netdev+bounces-109753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF2929DB6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC6FB22B6D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0133BBF7;
	Mon,  8 Jul 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EYDe4A6l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FD38FA1
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425034; cv=none; b=HgKL+IZ+CJD00yFmTooYu62mBNRDOILryqODKR54V6GIlQ/198UJPDWWneXA1yb3e3hqFjZZyZPkPPi1RvGPxGTCeQRtz8baAKD9yB1XyVCmGp4P/wEBjy2qLWEy7zti1+3EvSNg6ztdh1q6vsPi0j88REBdoLMFgS+slMkqoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425034; c=relaxed/simple;
	bh=qT/I0vbZRGDpE8yP1ELoiUDNULDJ0duW33V+A0EfTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyFD9E9Hw59sg2y58utFaVNJ0K0FzKE3DrwJwzRvFwb4FIbQ5DpNXkzOoiQLu0OW2njElcS1J1nuqqnb2USJTZxB3Za0JKZPCD+e4bSh6S9sIHFaO/s2xwiFUojNayiCN0N6yAWhmyRh0jkW2uwtQxsK0o8bk6L/zsIF9gsypX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EYDe4A6l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367ac08f80fso1386840f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720425031; x=1721029831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=EYDe4A6ljADu4uYo/+yKHjVNlJvACxZlSWBOvUy9AFzEaoIbWw8rxjdcodDmYPByO7
         Y70F5jkWV145zREBHbMGdBohy7VoKW9o+Hh2m0VZUktQ+mlKwdHW637wJW5JL3pSlye5
         m+o+obqdTKGGCspqf1WNoOUEmMZfCxXQcAQgTL/Cki+UfQ3D0t2w1WeoqM/WLiugX86h
         8pcZ99IFp/ViGgKLfph0A+mJxOg2jne95BgXB8ZJo8+UzTJRmpGtx3zwprRcGN5gY2zQ
         w8s7Me+filDnw17jy3mUQuxNDVDgnSnJ4LWSPXa3infDj0XV+c3+gS7DzqZwb4ax8WBQ
         S5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425031; x=1721029831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=UspWCqAZect2IIZjm9ZUrl5zzvRHSo9+tfLgqOW6i+j3Nu1wg51hSMsgu/dkA+Urlu
         8Mz50OBvbYkbgExZL/fhDFJ+l3y3NhHn1+rBYl7E3M/M4en9+lnoINP90PbMg7nVMVgw
         0Cz5nz4LdZTigZaqKiosvQt+4PlWMi/UPrAWzQ1498vI5JZibw66IveWhzOsFqyQStwy
         ZGD7wDdQmWTGaP+RjoIIJbqjCAmNXH98qiKdyldHZbN9RIu2L5xjKIMFnUkKwkb07WPc
         XKx72BzxjwqqgkvzrHRtPAU0lM/j/GzoJVqN/ooa+8Eoyv9OnU7m5w9EI6iczmdjXcTR
         yTKg==
X-Gm-Message-State: AOJu0YyRddAy8XkoIesU59TuRhWHP1wmaexSlYw4qZPKEFadT/ihO0Jt
	jP3JQBGWRdi+GH1QoijTjYQdsuzJ7dT6jgyBh4Swz+IgoLtxgR96MH0o1Rvwg6U=
X-Google-Smtp-Source: AGHT+IHVB2YXB4XGZU9hQow7TYKrFDF5hlVBHYX1Zn7NqJFValokpAL01XU7F8dmUnLHKfJPoXRn5A==
X-Received: by 2002:a05:6000:d04:b0:367:9107:9e11 with SMTP id ffacd0b85a97d-3679dd73c6fmr9802180f8f.62.1720425031243;
        Mon, 08 Jul 2024 00:50:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b5f9:a318:2e8a:9e50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679d827789sm10160055f8f.76.2024.07.08.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:50:29 -0700 (PDT)
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
Subject: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Mon,  8 Jul 2024 09:50:21 +0200
Message-ID: <20240708075023.14893-3-brgl@bgdev.pl>
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


