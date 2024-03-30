Return-Path: <netdev+bounces-83532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293AA892D6E
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 22:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84B62831AF
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CC74AED7;
	Sat, 30 Mar 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJKucHwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928713BBC7
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=aLktRl1KDgxoJmfO2sgo6KOMHyelT2+eO+LTIB5KLdPEpUAi16ylMHNfCi2YLhHTDLmFBUZCx11fTj3Vk/NmaOxn4Yy+nBBD9iP0ozNUsSzymdik8r+lHy993Yck2vxgQUIZBvhQ4v0x3pKhx1xYE+3r7YqXLOZ9w0XyKRTVwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=5cyk0mZPWqkezr+FTKCeHWipPZpAG9tXQ3TzxjeoxaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8Xowd4NXVFFVNAkqLaY2Qkgugi9JeD7GNxA0JehFyxlt63guA1ZGjj/alCZ281ENY1ca+ZfgoWia2/BycIciBgnt8GubRPzSvPNaxFhon7h0IA69pdd/qLPwrwYs2JN40+yJiI6jckGb2np7rCTawPdx3X/m8xbJAjkw38PgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJKucHwX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34005b5927eso2171900f8f.1
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833027; x=1712437827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=HJKucHwXrs4b+FQTF6hdlAYPCdImzzrwtKGc8WsGB3iqZORS5FZiTchupghwbi6xhW
         nH2y5k70ij9tBg3at2AB7dFP725wvz3R6/IlSOX9rnO6kffq33CUA9Ah0e7w4OACxwJF
         t+zxZmzHsxz6iW91jVortuqf1UbzccU6ZkTS+PJsVnU6DjYPP4bFXbE/XEPYhfmC7bQD
         8Oe45c6tRKF9FfsKAL0h1ZdVFfjXPGX+yOCEcOXsW25gVCO7OVqGdAs1HZF066/XdbCx
         DAw5j6aDvhV096NR6iMdpR8R8vnFO1pm+fVLUTKX+pDE9Sog0XM3gmovmBpUd9Re+QcM
         x8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833027; x=1712437827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=MfvuAXquBv6NrEmma1V4rinXIuoB0uwf/arhSCOlhuu8R7ZU/Fr6kfq5bFj64QPx/8
         NZcy+pI4T7C5nfBvvbolfDHuvhMi6zvnx2ZNhlA/GHure2VRYXAiwAgxMyMdxqHUaz8P
         Px9gk24PUUS1hbMOyym2T5Y3NgNwdgBaAmgq9MS9AmaB54Beqq3Au9bMHL1siLmj+tst
         jxGf49OgfrvZgq5mEcUWJfYAwtCINNT0Tgq1F1SnnUkC2t0NC4lihD9SwJ/gS/Ez2Jq7
         YFXErDuKQnTjYW3fsMWIbFt5a5VoO9fBxdi9NDD0hp42XjfA0qOAGxxrh0so8D+SifqF
         Q4Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX0tviT99vDJ3Ff8bv+rE9a+gRZQ0FfTVMhbcnPDryH8daqhIcKbZ7fchphprxFEZeXQgLVxtTQf2YgjfHZ0RVv96f1dmXT
X-Gm-Message-State: AOJu0YzxgDTxtYzx7jD1TiYpFQ46Ya8k4ZlMXwARwZO84vX+50jr+HVR
	01y/gkugKlCuc9sPwW+OXIVqa5xncHlSA5XEixYhfaHDNvfNTYXPpre96RFG+Ck=
X-Google-Smtp-Source: AGHT+IERt4faZXoAKcqd32SoGypbspZ5AI2Z9HzqC72LYU0X3G22k6IsrcxS3SxIiC2LoT6Os1c6mw==
X-Received: by 2002:a5d:5222:0:b0:343:357f:6650 with SMTP id i2-20020a5d5222000000b00343357f6650mr3848599wra.45.1711833027100;
        Sat, 30 Mar 2024 14:10:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:22 +0100
Message-Id: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index c8166fb440ab..79ae01507a8a 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 static struct spi_driver ksz_spi_driver = {
 	.driver = {
 		.name	= "ksz-switch",
-		.owner	= THIS_MODULE,
 		.of_match_table = ksz_dt_ids,
 	},
 	.id_table = ksz_spi_ids,
-- 
2.34.1


