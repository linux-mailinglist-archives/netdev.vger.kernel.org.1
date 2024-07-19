Return-Path: <netdev+bounces-112209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DC937608
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66355B233EA
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3715983CD5;
	Fri, 19 Jul 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="LH7qPLeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1B83CC1
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382340; cv=none; b=gM19rk6PyxbMVZiw+KV++vuhclUQZzaRPaC1ui4yxOLBu32o078OZjuiPRLaxjqhwxsFmd5BjWD7exE8ihfVB7BK8GcvWE0KcjbN6JIJMU42uAOEWJ6BErxkycvWR+Ruf+tdNwmUpk4anB/aT8BMwaEr6hl+RKH8Es1pKWMR37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382340; c=relaxed/simple;
	bh=ShGVMtgc0hDJDLEQjlIXd5oij4dB7J9Ckvvpo/zXXW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MetZhzkbB9COVywQsdrQvNAlGb9AX++5VqPHGZw22ZZ9E/Uysd3RRQnYNYINbsbwEG07q+Uyy/Y6+xFQ6WwnAD0DNMnmPzdESWlksCdAepF9IPKQGErPGEURP9pPGoHDXGP5erIF9U40srd921tZaPj2IUQTUZ0x/ZntnPWo7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=LH7qPLeJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4b03fca0so1547535ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1721382338; x=1721987138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+46O4rQZG+afw+seJ1aSaqWCwYwoT6C2GKWC2dXu30=;
        b=LH7qPLeJ5oDjNXdzUNCD6HY2pWYfMfQIwFCkawOgYztd8FgiOlJGhQN2hVhARRCJFR
         2Duo+8oyw9NxxC/nLwIAkodsU+lyy3SY10652JDtvmFfkgZf/GwXU7a9B150iHLCKp9u
         936QCxutx8BTszNyShZvic65rVws85BhqfXxBqqwCC1ElAgZOqb5AYno4NH7nK5oy1G4
         sch3R1WyQx8CByyJFIkx6JR3qRNRTMw2mNpmfTYbDEjQCuYPrBGbqbp/haNo242iGXa8
         iv6Tho/aaHX8qXoBDG0K7MRXnn8XgUSkUYPxCS1jNBV/82r0Eu8OCww8KWHGXzqc473O
         DxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382338; x=1721987138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+46O4rQZG+afw+seJ1aSaqWCwYwoT6C2GKWC2dXu30=;
        b=DHb0okO/tKCur1DMJGhieLsEL8/AItBlS4/HTOQmq8Je7T1v4SQoKyXk5VxeJkblV0
         1hej01L3tD69TTOqJsViyWC2KIo+DiDxdrnMdMn4SZarNi0xIzepfT5nsTT5ECATbQWG
         n/BEluGYamaqmeFZWcMDb7qGYkN20lFC5L1YofsekavrOgIg+GaVrQc5B5Q+pkKVomcq
         Wssf/7jk2mBMumMmEMH74qXYkCslu/F2iEQ0OI6UbP4HgCwT6MmfkDBT819LHGjEM9ey
         WllO0DGUQo1rHFYI5ARBDeL2HUZLOu0iptph2aoONIXrKJp43Lo0eW3VaelRW78ymDvV
         XAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtzotWMB15IoK6NE/RFqAJXh1ri8KZwPy7rZYow+tpgc/zKRyT5OFKEcve/FmpP9uKqZL4IDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmFEHqaXF+eHZvN6Uq2g0Vmt0G97+NRaHjVugx90ZjCRGu614
	mQdSsvETf2n049xmuxxvklm6k4vqZyQewvQjaC48S9uP/9TOZWoCQh/IiIBhIg==
X-Google-Smtp-Source: AGHT+IGTvpfyGkQSzcGiWO9xJsSuPVeVkrZ5bQM0dG5A4we5XMAn0a2gFht26kLa5ZsN/Jp0o9awzQ==
X-Received: by 2002:a17:902:b195:b0:1fc:5b41:bb1b with SMTP id d9443c01a7336-1fd5ec8ab33mr13929205ad.4.1721382338043;
        Fri, 19 Jul 2024 02:45:38 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:8899:6437:d031:b9ec:7ff1:6aa1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f67esm819025ad.96.2024.07.19.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:45:37 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Fri, 19 Jul 2024 15:15:10 +0530
Subject: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
To: jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=ShGVMtgc0hDJDLEQjlIXd5oij4dB7J9Ckvvpo/zXXW0=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmmjW1FCj3t80L4AIBRXHK9xB7rRLJ+43vNde2f
 nHTW8A6u9uJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZpo1tQAKCRAFzvXHieVa
 dOQKD/97OqRvHiNgAtedUcGy81V44GNPmt+MwamaNqBs/ESpSxZaZCBUmXU4Ikq6jWKM50k3gPs
 noxPI8ZwpgwqTW7CHvQu+FwuugPwOVub4cAskF4MXDPP76puggUF0gL9/aXCPvEK+sXyuNbeLJL
 6hmdiavzI1oqVENYVkxIBsbLxA96T9Dtsj39CMz8spOurWjl0IGziLRfXd8k1Dj9JfqCTwJHiNM
 x0FPeS+QYjzsoTVgrdowKLtqqevOvpCrMF3Shj1OvmMcC3qtA1/2UgIC1LZ+SDqh5JtkWZfvAE+
 0IeEPi+N4r5fIzon+OKlQOiHBrzTMp42V0T0+5IkV1DSPOL0oNS6tTqdWFsDs+iJYvi2y9wHidT
 W1jl8/kw9OkiiGlZBlUgCXw23HfXhaNzkzozWAAFEvJagEQbeYSSxyoKNnJfmGLIV3MKcMXnaRd
 RJAfOS3aJ1liKybxkDjWyGIQWXxpfDTxwgOLWS6rCzmJmY+5FHyGeRaM5wHlaeNSeDisOjD9Vyj
 Z+jwPRSmqHGM165PaH8qRilV0E1hv+fqYbIw+82m/ETIwS4kovzktB6Sr/6r46tj9WmNwSSqZP3
 DGuLmkFSVdV26vPHrjce3pwcXqWtayCdAT4pbydSURatbZzt84eX6Fr5koTF0g8ZNLqGBH4RES9
 Ot0J23ppRG8qbcw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

boot-gpio (along with reset-gpio) is used to enable bootloader backdoor
for flashing new firmware.

The pin and pin level to enabel bootloader backdoor is configed using
the following CCFG variables in cc1352p7:
- SET_CCFG_BL_CONFIG_BL_PIN_NO
- SET_CCFG_BL_CONFIG_BL_LEVEL

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
index 3dde10de4630..a3511bb59b05 100644
--- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
+++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
@@ -29,6 +29,9 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  boot-gpios:
+    maxItems: 1
+
   vdds-supply: true
 
 required:
@@ -46,6 +49,7 @@ examples:
         clocks = <&sclk_hf 0>, <&sclk_lf 25>;
         clock-names = "sclk_hf", "sclk_lf";
         reset-gpios = <&pio 35 GPIO_ACTIVE_LOW>;
+        boot-gpios = <&pio 36 GPIO_ACTIVE_LOW>;
         vdds-supply = <&vdds>;
       };
     };

-- 
2.45.2


