Return-Path: <netdev+bounces-132699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A0992D93
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0645D1C22ADA
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732DE1D415D;
	Mon,  7 Oct 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mUKv0TWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC81D3560
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308470; cv=none; b=vDIti9mBytIgU5RVulgPyO8I/v5EuLcCYXNNpB2boGj3ASsrliYtkGJ2JjwYExkVlahMZ5mlTNyAIZcRWkPK/MakriQUck8cza6O0XBTxb26XzlJRscZnl2oYKbg5bgqCWR1xAmX41vwJUXvg2IPud0XRm0A7A7TVaGNoNBaVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308470; c=relaxed/simple;
	bh=PmL2xXE8BnzEt05PC++iV4GvglcxASXwdgQKwqxjv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kukt0Lk09uUuQyIn2PmO7RHU3xgx+WeNc0rRGUlQrefAsyzfGt1vAGhDnySL15aXXAcQg3pXndZfvpUTNplsj5vmmW+P6sCPQCpR4PmqvcBdy7uOjwcuYAqtcNHECBNbCR0MYmCaeUyFjx3za9UsHRm+4gzNUPWiwc4qud7QbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mUKv0TWD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so38377125e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728308467; x=1728913267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18IwUzJqtKG/CgmSwOnapNoHLokmBRx3kK5mOETO+Ss=;
        b=mUKv0TWDQWTnKCHNcSpMghXXqupaEfZ8UBWGpcnIAuJOEcCqEH/9n+UO2D0xScxhL0
         fJaT4OhpVtzFWd4wi5LfISYVWzdSEwEoQRtZZ3Ta6TkyXgucMpVzqDiSg5Sm9TwWVExp
         GFdFrJgBSWFJHPPZEKStQlbf9PObPGKBuHVPmkxFvtBaIJR5XvxtvYXLkHESse8omHQ/
         EzjCAHWEG3Z23iEO7vY0wAxPJx4DnHSG5WmvjL4C5pr2e8SvJhZjm58HeoLLPVnA3+vV
         oYSyBGi/GWOvRPHQlKl+lLGByB1xwIyxIauEwodXPP9n2x8/E2doam8Gd+sNL8/xdPZ7
         Jk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308467; x=1728913267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18IwUzJqtKG/CgmSwOnapNoHLokmBRx3kK5mOETO+Ss=;
        b=dchOQ2KDFF8SPekY9+XIb0OI+6/fyXMzG4w/NV9gRYw1p5H+s6TICIJrwywo+jdEwh
         l4AyBONuPq1se3KeY48I8REWZ3xyKVC4ohnCnPJwFGy5nL3THumhT16w96tq5vXPf+8x
         IpBfnSpf+M7oLTq7PQhndnpegrLDIDhTcbCuXrLv7EKVrpVfvQEXFhrkXI2ldGrHeFFP
         Hj2StUhiMBgXYIjE5PI4sdCSDw66LeVKaYhxhKyXhtA7qeEhjNypKnqqUZF36u8Bk01y
         by1cVZ0e57YQ2LGhiRmBY7LwzjpLmPpvWL1n9rU33xAS/bbNrotY+CliDVCuOecgA+aS
         B3Vg==
X-Gm-Message-State: AOJu0YwkbbWLyjJlxky/DZmQE1Izrv2xvIMMrB8WDY5yg7wfQnSUMa5P
	V+c1lNwAN7opVUI7Kggufjwt2JpaYtE0Yi4APZo6JjC1rnV5JE12ImR2fxx7JN8=
X-Google-Smtp-Source: AGHT+IHn9j8gKlTyGUNL6SJnMg/6TE1OAWoRwNw/fMGqK5wfF55HTcD6FZceAL/RR9mRJBsXvzpTrw==
X-Received: by 2002:a05:600c:1546:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42f85ab4746mr83561765e9.8.1728308466852;
        Mon, 07 Oct 2024 06:41:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f66csm5765373f8f.13.2024.10.07.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:41:06 -0700 (PDT)
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
Subject: [PATCH net-next] net: phy: smsc: use devm_clk_get_optional_enabled_with_rate()
Date: Mon,  7 Oct 2024 15:41:00 +0200
Message-ID: <20241007134100.107921-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fold the separate call to clk_set_rate() into the clock getter.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/smsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 150aea7c9c36..e1853599d9ba 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -627,12 +627,13 @@ int smsc_phy_probe(struct phy_device *phydev)
 	phydev->priv = priv;
 
 	/* Make clk optional to keep DTB backward compatibility. */
-	refclk = devm_clk_get_optional_enabled(dev, NULL);
+	refclk = devm_clk_get_optional_enabled_with_rate(dev, NULL,
+							 50 * 1000 * 1000);
 	if (IS_ERR(refclk))
 		return dev_err_probe(dev, PTR_ERR(refclk),
 				     "Failed to request clock\n");
 
-	return clk_set_rate(refclk, 50 * 1000 * 1000);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(smsc_phy_probe);
 
-- 
2.43.0


