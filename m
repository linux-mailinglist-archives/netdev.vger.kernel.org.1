Return-Path: <netdev+bounces-105023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5317E90F740
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27EC1F2618E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28430158DB4;
	Wed, 19 Jun 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hrtixH+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AE54FAD
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827015; cv=none; b=D2G6taxOb7ny4lzibN5H8L72O95xk0GXYsY3PylKZ1sEsW6itKWozhJNmCBc1vJuCANXzOX7IOabm7LVzBCqW8mP9IGgndQt/9MoSjHi7zvKqCK7vZ8aFDY8crM5x+Gg+ZXBkuzUz/iOPTJAO5iH8glpT6GpEhusjUn2NcD4k80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827015; c=relaxed/simple;
	bh=EVjAxQSA5XRmnje/rYC0vrhjlPHAMPGT4KGztbFrJgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvVkF/0MjwhX9TcXAjvzKDGVbo83BRJgXGMYltYCtbLyiBcfbXVUiQOtIKzXXMg2hjGQ8ix2rW2CIhIPl+SfBRvju6LNdYuAcCInIJiYcg/GSIW7DuXwnWlYexKZK/M+h3JoHw8sex1w6pUqULeFPEocshaOuqZuXupJILMTXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hrtixH+m; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f51660223so7132166b.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718827011; x=1719431811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbX639EEP7rdInf34Qquyp64lkrK0tS24YEBoryitwU=;
        b=hrtixH+mWDaUZOxECcvbyxUmoIsMuOmpsdzBMjvwR77MlWdc1N2hvM479IjY8CX7Jd
         GBAKU0G0jfwy3bYaENwF7PpOBhbYdOQ00+XAFA2l8QBRbjLNTO9ARDPPGH64GRlAXh9z
         qEtk7B3i6TimGKTEa6MxrwevpCZztTK1XbGn7eM20Z1JuTzhP+zQAr8q1/ryBNr5OUss
         jfCXXhomXR3FISuj1Xwmtf9ry7hM/WobzR6PHsk/wAgmcSCSmUyIzwkQ9OwyMkwFyl3z
         ltcsDhVmAvVfwYs8dh2PanNQHL6WWeL/8PHKRJT9FvRqHPFOOtRf7LYJUSBdzj+cjPZm
         3DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827011; x=1719431811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbX639EEP7rdInf34Qquyp64lkrK0tS24YEBoryitwU=;
        b=UWf7uMVSBWd4Pw28DOUfI1nHr1PgSOz4KA2+ZaHsH0M3dMf4bHNx6JxqfXV6MyediE
         ZkYDikwdZHkxRt/mohFWB17H3M1Cxnh9pwv8zt9OMC0jx9yE53UaY9Es9AMB1v0i91kN
         WCHiHF02KzEPi+wAOnNgZMlkk2J44yTQAMowMfWRk3u5JSyNRGV0Qi7jdD7P+fYP9AdV
         IHi6DPjzKhFkZ4AdDBJ07G7ajQ/pJ4pwo3nEf4Y8L2l0QVWwF/U8vcbir00xh07A160D
         SuEy43NEp3je3+xBx/JJFwDvffEHYS1k/B+Tg+0f6LmSt1YGroDtzUO1/5jqpbLkV9ir
         e2yg==
X-Forwarded-Encrypted: i=1; AJvYcCXw1Ve+7qU1WNZHN9WyQpGN2Zmbzunf6/u7S9rG6Q8FH4kAQAS3FMsQCx7272KDqz9ZHBZna2EYG/NC9m1TlzM2QZPfg2dq
X-Gm-Message-State: AOJu0Yyue260VekeXpULyT568pphGUr7CMDGGFcqkwfH/CETENEcy8SD
	akKnQKU19h7Ah25/afR7qzrabAwNHEACIip1mWliWuAfjSqDk9OF1F5OnuMyyFE=
X-Google-Smtp-Source: AGHT+IFmScV0FS5fe4OYER4czsBWIjw9z9oEO9PLIQ8o7vlollj8c1ewSUiUm8rZdyxJ/OE4rPzfQQ==
X-Received: by 2002:a50:ba82:0:b0:57c:dd3a:f399 with SMTP id 4fb4d7f45d1cf-57d07e4167bmr2095140a12.12.1718827010292;
        Wed, 19 Jun 2024 12:56:50 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9d90sm8770630a12.56.2024.06.19.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:56:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	netdev@vger.kernel.org
Subject: [PATCH next] nfc: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 19 Jun 2024 21:56:31 +0200
Message-ID: <20240619195631.2545407-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=EVjAxQSA5XRmnje/rYC0vrhjlPHAMPGT4KGztbFrJgA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmczfwuIY5J+8HOJM/hvTkOyO+j/v2Tp/uQa1Id RS/zGQ5I42JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnM38AAKCRCPgPtYfRL+ TgbzB/9zMOijQVU84ZBuWjZz4n7pyvKZPXGG4phAZ6PWnaOftYpkVKY0qoK+XGRSx9Bh9ZcQYP3 Yf5cgnufjG82QHWuyPj8by3eHgKWfGluE/aBOKlm30xqHC2kdo/Knr32T7MfbIxEQv/uEWhitk4 sJ1pIrF56Os4i4mY/l1Xe/M6lcQLNtlc2GTBKGHK8RSkVGYaoa943/mUgWUgyvCU97IhKzZFJk+ 34HDqZySUtBFtVFQHDyh0L2tz/QuI2e5Hkw1t4Za7h35ah+0KoseX+fdyMAk1FQpcHnn28Duw/z pInhhmkDWtD/08c3ZFjqdTkZa0DoKTVl5iAes+6zMW8035DL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/nfc/microread/i2c.c | 2 +-
 drivers/nfc/nfcmrvl/i2c.c   | 2 +-
 drivers/nfc/nxp-nci/i2c.c   | 2 +-
 drivers/nfc/pn533/i2c.c     | 2 +-
 drivers/nfc/pn544/i2c.c     | 2 +-
 drivers/nfc/s3fwrn5/i2c.c   | 2 +-
 drivers/nfc/st-nci/i2c.c    | 2 +-
 drivers/nfc/st21nfca/i2c.c  | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index 642df4e0ce24..113b2e306e35 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -277,7 +277,7 @@ static void microread_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id microread_i2c_id[] = {
-	{ MICROREAD_I2C_DRIVER_NAME, 0},
+	{ MICROREAD_I2C_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, microread_i2c_id);
diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
index 74553134c1b1..39ecf2aeda80 100644
--- a/drivers/nfc/nfcmrvl/i2c.c
+++ b/drivers/nfc/nfcmrvl/i2c.c
@@ -252,7 +252,7 @@ static const struct of_device_id of_nfcmrvl_i2c_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, of_nfcmrvl_i2c_match);
 
 static const struct i2c_device_id nfcmrvl_i2c_id_table[] = {
-	{ "nfcmrvl_i2c", 0 },
+	{ "nfcmrvl_i2c" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, nfcmrvl_i2c_id_table);
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 3ae4b41c59ac..a8aced0b8010 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -322,7 +322,7 @@ static void nxp_nci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id nxp_nci_i2c_id_table[] = {
-	{"nxp-nci_i2c", 0},
+	{ "nxp-nci_i2c" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, nxp_nci_i2c_id_table);
diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 438ab9553f7a..132c050a365d 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -249,7 +249,7 @@ static const struct of_device_id of_pn533_i2c_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, of_pn533_i2c_match);
 
 static const struct i2c_device_id pn533_i2c_id_table[] = {
-	{ PN533_I2C_DRIVER_NAME, 0 },
+	{ PN533_I2C_DRIVER_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, pn533_i2c_id_table);
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 3f6d74832bac..9fe664960b38 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -44,7 +44,7 @@
 					 PN544_HCI_I2C_LLC_MAX_PAYLOAD)
 
 static const struct i2c_device_id pn544_hci_i2c_id_table[] = {
-	{"pn544", 0},
+	{ "pn544" },
 	{}
 };
 
diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 720d4a72493c..536c566e3f59 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -245,7 +245,7 @@ static void s3fwrn5_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
-	{S3FWRN5_I2C_DRIVER_NAME, 0},
+	{ S3FWRN5_I2C_DRIVER_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index d20a337e90b4..416770adbeba 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -257,7 +257,7 @@ static void st_nci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st_nci_i2c_id_table[] = {
-	{ST_NCI_DRIVER_NAME, 0},
+	{ ST_NCI_DRIVER_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, st_nci_i2c_id_table);
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 064a63db288b..02c3d11a19c4 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -573,7 +573,7 @@ static void st21nfca_hci_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st21nfca_hci_i2c_id_table[] = {
-	{ST21NFCA_HCI_DRIVER_NAME, 0},
+	{ ST21NFCA_HCI_DRIVER_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, st21nfca_hci_i2c_id_table);

base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
-- 
2.43.0


