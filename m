Return-Path: <netdev+bounces-136290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CD9A13F9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D459C1F22ABA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF69215F5B;
	Wed, 16 Oct 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNJmNUxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268442141B9
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110582; cv=none; b=lm6MpLpuDmfS2I2CNU1DCZZ6BuuNY9CH4ZZLIXeplrRcbq8s6dhUKlsl8pe/8dQtPVvVrGX4SccPQ6xt8Razr/5cOS/Kc2nL8iIfHFtxdxQwz76uKZdh0EfVdQHE87tdoQ+uIXmjoE3u5Lr3Y9JOIozPzjmuq2lm+K/6FERR2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110582; c=relaxed/simple;
	bh=d71sbytSZTH5v8jUEll04xUKmptXIwlE7z1lMyxHrjU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rXQe9PptDPcdfTlz/UFPAXhRmTmNMWhpFEhHk00/aRoJcTxwBBnULiXwfjxqgLwvQGvwki8POn9PxUCcavA0vwQf2MLciA1UdYU+CoyklhVc0LF3Yxn65L2cBQSXpXUxOVx6LRoLRMz++P6rpXgECwmemwceH0F+RSuzkGVA2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNJmNUxz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a998a5ca499so29948466b.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729110579; x=1729715379; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHNUz4Uf6wvpD0CooMgOiwqGM32xcZZVqf2J0su1UYg=;
        b=kNJmNUxzS6kyf8yZA2knI0C3x8C7z505n1RN6KU4Jrum45G/14gXxdn1BmRFHp01VZ
         hbwpIAKBYbNWR37jypcZtTVXciHL1Y5GFYAtti8eooBmBbwnKR0K3m1lab8lSDEldBz1
         qfvkK5PKIaVrYOavAttT263U263nZop5fYpGkEPkS3JtEZwcUFgbzUayEWYcy/BI8qp6
         zPAt1PlrcmpSHBQQg5S3jqJ6C6ge18MEzCR3XQF0M7aFYJkzM1Z2YqGmUYtKn4gxobxC
         7iK8xtzLWB3T3ej+KV3EcGh0WOdBrX+13SYiZr2clMNvJC2cAaFBDu5EhoHbE76JHj5z
         I4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110579; x=1729715379;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHNUz4Uf6wvpD0CooMgOiwqGM32xcZZVqf2J0su1UYg=;
        b=LQIy7XWumzV8MPG7gb5GFZPyhPQp8K+94fzR/haTb+/TmPPkbMRaOy2t5x7sFM2XwY
         lV+SNyuoRPDKoDEUShiG8MCX1OUnDkwgt6aotTJqcY78isYn9FOGfQFbIZe3m72ALt3p
         qJuQb+D2EpJpXb6uuhyKGd4lJtptzyh+xRoDdnIRYWJhPZkm57AAbVP8pSGwotxEU7l/
         X33mG/+/uEd4HISf5PXk5YiYmbj0t1uZ+FF/KOldfFa025e7psYvLzm8UDqEQHvlTSK+
         5hoKq9RgCMqUvHqLrm+5wbHxxO/QAE2THw47KFWjX8ni/3Qxk4deOO74xqOPWIHU3bDW
         nJ6Q==
X-Gm-Message-State: AOJu0Ywe85iqWpUOWkWSvxemmzNz0i6I5MRgI3Y9zqoyuwYZb99Mro6P
	jfrxO0rCJX5waUL6/syg9lG9TeTfVUboYrt6VOV82OpJyrdNJlui
X-Google-Smtp-Source: AGHT+IGT/giP/FTXXuL3R/51mZSAGW7CqLB3xQSHmvH9ZZ+6UK2bBCEbbLokksfZjuC6XD68F5lRPQ==
X-Received: by 2002:a17:907:1c9b:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a99e3b3329dmr1615057466b.20.1729110579205;
        Wed, 16 Oct 2024 13:29:39 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a554:2300:9878:3ee4:db79:2f0e? (dynamic-2a02-3100-a554-2300-9878-3ee4-db79-2f0e.310.pool.telefonica.de. [2a02:3100:a554:2300:9878:3ee4:db79:2f0e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a2988c56csm216745066b.209.2024.10.16.13.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:29:38 -0700 (PDT)
Message-ID: <d9c5094c-89a6-40e2-b5fe-8df7df4624ef@gmail.com>
Date: Wed, 16 Oct 2024 22:29:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: avoid duplicated messages if loading firmware
 fails and switch to warn level
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In case of a problem with firmware loading we inform at the driver level,
in addition the firmware load code itself issues warnings. Therefore
switch to firmware_request_nowarn() to avoid duplicated error messages.
In addition switch to warn level because the firmware is optional and
typically just fixes compatibility issues.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_firmware.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
index ed6e721b1..bf055078a 100644
--- a/drivers/net/ethernet/realtek/r8169_firmware.c
+++ b/drivers/net/ethernet/realtek/r8169_firmware.c
@@ -215,7 +215,7 @@ int rtl_fw_request_firmware(struct rtl_fw *rtl_fw)
 {
 	int rc;
 
-	rc = request_firmware(&rtl_fw->fw, rtl_fw->fw_name, rtl_fw->dev);
+	rc = firmware_request_nowarn(&rtl_fw->fw, rtl_fw->fw_name, rtl_fw->dev);
 	if (rc < 0)
 		goto out;
 
@@ -227,7 +227,7 @@ int rtl_fw_request_firmware(struct rtl_fw *rtl_fw)
 
 	return 0;
 out:
-	dev_err(rtl_fw->dev, "Unable to load firmware %s (%d)\n",
-		rtl_fw->fw_name, rc);
+	dev_warn(rtl_fw->dev, "Unable to load firmware %s (%d)\n",
+		 rtl_fw->fw_name, rc);
 	return rc;
 }
-- 
2.47.0


