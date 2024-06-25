Return-Path: <netdev+bounces-106402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C491617A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7921F21353
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1771487D8;
	Tue, 25 Jun 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2uD61klg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3418E1F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304746; cv=none; b=P3FEqY6e76CqtQufpbsm/BrLoREQ5LPa1cJF1B6E1kzeemo/00nLGN2yarRZK37i8hj8oKj9Th3cYoMlB5uj+sPh7QlgIGgXPzkru+fJoi3sllNkzaZgahSLB9t60fMRtukfj69FdcSAKiprdvsbW+L26he0w/vcXcYgOqYbF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304746; c=relaxed/simple;
	bh=Kke7UnbWTK5JFWCmdQuTGbunuJXeMWfz5crzx5UI6EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkKjvsFducAjb6hcSCIjg8ZrcKo67cPQG/P1SF6B5UQ6hfKi3GdxT4/fG5g/x4tsnlVev3WzfQRjRidfGSL/BcE+tgA7XRklmMnh6E4jFkJULbAHarpsKs4TaYry2+sRfKJwPWylIaIEkz0Dov5KcdJ2BAD62oiJDgjSVj5SPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2uD61klg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fe81a5838so287624766b.3
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719304742; x=1719909542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnN5q6BXMt44DouJMDpElAwv3RsDUfeCm8yIO7mo8zQ=;
        b=2uD61klglRXHciYx1o/MVv2QLI9Z2YUAVbcX4d/xH4JIXPm/V1I+ruzgGz+vc5TEA6
         DJSucfltH/0DQGk6dz2zmosg497il8JgKve8CirkRw3NTIO6VhSdnUBFJCPMHe5vc5gD
         xMvZxtlXJ+7Lzgcs2J69KO57dTBmR/DyF5K54gB2dghmq4BLTq8AzniJ3c50hg6bhrAa
         24ycwSnTX193DAQTEuTv/hPwm4FJAy2WgAevvXXtqB6RHMVuIY6NG6tdpzkTS1t79VYF
         +tTUU2NTI1B6DB2l9NQG3lKNOWWlnKtbkulbWdqNnysvMIl4RuuPZXHGqF7v5CZVUeAx
         RBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304742; x=1719909542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnN5q6BXMt44DouJMDpElAwv3RsDUfeCm8yIO7mo8zQ=;
        b=ett2ktNaCzngmGGDrlYm3yAn30qzYrUI23N4qX9/Laobm6ATfc+Fo2V7X2btdHkeqA
         Y1VCqMOmutXNIqIOKGZRWGxO8revpu9FAAso3yrIXE0DkaZ/jUgghlmyXn8WgGwIf1sA
         fIrHvfjxiRpk4kxGAQGzHqyXiplQXGMvwUL64NZ2knldNjWQtOt+wmlnpe0r+LSfvjDQ
         bmGKjxv0w48anyph1IH8XDOjvXlvxZF7pQPBHsJkQl4CMxWNU9gQH8f0tVePa85yf3Y+
         FGp+5MI3NhmMkgBYsQodcVZNic9p66MkrDtje/g9X4DWsiKpP0vRYYuiNl4wJcKY8TV7
         UyAg==
X-Forwarded-Encrypted: i=1; AJvYcCVYvm9K4ra2zZgpOAY8pgrf93Q6GH6knPOU1VVp9n7YXYJg/dcolyXYRMQnx3hNT51OlQQtGZscEa6li8BLwxMBLB/T5KAG
X-Gm-Message-State: AOJu0YwAztB+dZDVz8XtXf9gDxOU5dZkX3SxszACmOB9y1LtJH5Qud8+
	dgH54X5jPZk4kfutKxv9/ADreWQ6mm7t7y/X4xemaSFjd6u65sL11OBRlXSgt8E=
X-Google-Smtp-Source: AGHT+IHaO5ThL8m3j2wMCA1GebjRGHcAoX1EgSMJPc+SrTIiPDeZlTTDnJCCMCGlNolYW0xDo8SMWQ==
X-Received: by 2002:a17:907:a649:b0:a72:5e5e:adcf with SMTP id a640c23a62f3a-a725e5eaf7fmr282340766b.63.1719304742040;
        Tue, 25 Jun 2024 01:39:02 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724d917f1csm234598366b.39.2024.06.25.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:39:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	George McCollister <george.mccollister@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Tue, 25 Jun 2024 10:38:53 +0200
Message-ID: <20240625083853.2205977-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4437; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Kke7UnbWTK5JFWCmdQuTGbunuJXeMWfz5crzx5UI6EY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmeoId4DskdMPDKmv6LTMlBUP9gXaMue2vH5Ztj wRgf9N/79uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnqCHQAKCRCPgPtYfRL+ TifdCACTFRIPiUNixKritxWONh5wQ4ujWE3EFeE3DX53w4aghDCaCpVoD2ICWnkqBUrvXfGGRvH n3GIsyTjGR9KiOSw9Kyw4dL5R25yZUzaeFwqBJgilI1qnFhJYy1mzi3N/fDe+sEWb095uPHuojl SWDCaSezvqPR18quV/F2YkPVvq9wVsQ8cH020t5fBXT51wAaUgzTYfN9/BN8cQuBXDNGEMsAdtu pQ8oL7SAbz4U8MvxrIjS/Cz47O9Wl7KySrhM3p9YuxeY9w5MOrwbUsy2N+o1fQmiUth5cuHc/rz oMOIwQ3enQxHwqCYWqYtmFXkucmr3GbYHOrWUp888uh9+DQE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I'm unsure if I should have split this patch further; per subdir of
drivers/net or even per driver. If you want it split, please tell me. 

Best regards
Uwe

 drivers/net/dsa/lan9303_i2c.c                 | 2 +-
 drivers/net/dsa/microchip/ksz9477_i2c.c       | 4 ++--
 drivers/net/dsa/xrs700x/xrs700x_i2c.c         | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 4 ++--
 drivers/net/mctp/mctp-i2c.c                   | 4 ++--
 drivers/net/pse-pd/pd692x0.c                  | 4 ++--
 drivers/net/pse-pd/tps23881.c                 | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/lan9303_i2c.c b/drivers/net/dsa/lan9303_i2c.c
index bbbec322bc4f..c62d27cdc117 100644
--- a/drivers/net/dsa/lan9303_i2c.c
+++ b/drivers/net/dsa/lan9303_i2c.c
@@ -89,7 +89,7 @@ static void lan9303_i2c_shutdown(struct i2c_client *client)
 /*-------------------------------------------------------------------------*/
 
 static const struct i2c_device_id lan9303_i2c_id[] = {
-	{ "lan9303", 0 },
+	{ "lan9303" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, lan9303_i2c_id);
diff --git a/drivers/net/dsa/microchip/ksz9477_i2c.c b/drivers/net/dsa/microchip/ksz9477_i2c.c
index 82bebee4615c..7d7560f23a73 100644
--- a/drivers/net/dsa/microchip/ksz9477_i2c.c
+++ b/drivers/net/dsa/microchip/ksz9477_i2c.c
@@ -72,8 +72,8 @@ static void ksz9477_i2c_shutdown(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ksz9477_i2c_id[] = {
-	{ "ksz9477-switch", 0 },
-	{},
+	{ "ksz9477-switch" },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, ksz9477_i2c_id);
diff --git a/drivers/net/dsa/xrs700x/xrs700x_i2c.c b/drivers/net/dsa/xrs700x/xrs700x_i2c.c
index c1179d7311f7..9b731dea78c1 100644
--- a/drivers/net/dsa/xrs700x/xrs700x_i2c.c
+++ b/drivers/net/dsa/xrs700x/xrs700x_i2c.c
@@ -127,8 +127,8 @@ static void xrs700x_i2c_shutdown(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id xrs700x_i2c_id[] = {
-	{ "xrs700x-switch", 0 },
-	{},
+	{ "xrs700x-switch" },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, xrs700x_i2c_id);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index f0ceb196a6ce..431accdc6213 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -702,8 +702,8 @@ static struct mlxsw_driver mlxsw_m_driver = {
 };
 
 static const struct i2c_device_id mlxsw_m_i2c_id[] = {
-	{ "mlxsw_minimal", 0},
-	{ },
+	{ "mlxsw_minimal" },
+	{ }
 };
 
 static struct i2c_driver mlxsw_m_i2c_driver = {
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b37a9e4bade4..f9afea25044f 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -1042,8 +1042,8 @@ static struct notifier_block mctp_i2c_notifier = {
 };
 
 static const struct i2c_device_id mctp_i2c_id[] = {
-	{ "mctp-i2c-interface", 0 },
-	{},
+	{ "mctp-i2c-interface" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, mctp_i2c_id);
 
diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 6488b941703c..820358b71f0f 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1194,8 +1194,8 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id pd692x0_id[] = {
-	{ PD692X0_PSE_NAME, 0 },
-	{ },
+	{ PD692X0_PSE_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pd692x0_id);
 
diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 98ffbb1bbf13..61f6ad9c1934 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -794,8 +794,8 @@ static int tps23881_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tps23881_id[] = {
-	{ "tps23881", 0 },
-	{ },
+	{ "tps23881" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tps23881_id);
 

base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
-- 
2.43.0


