Return-Path: <netdev+bounces-152914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F29F652C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC951889B4C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7D19F429;
	Wed, 18 Dec 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2zEMTpt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF7161310;
	Wed, 18 Dec 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522294; cv=none; b=QUYRc4bu0nXnFsT0MvEyXgkUhYAiBX0DzVKL6UL9ofh/CaeFDxhUnMrRiBy4Rl96Cwm93Xik6/BR86YFMFdXG8PD3k+pihDkVwz05vlJ1wdpXHU9qaGMszL/dOaf768twAqDsxqcNm5Yh5R914kfyVSKeyYWsX0VsCdMqTb7+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522294; c=relaxed/simple;
	bh=zBuVIqDY3NtB6DJeIprj5FpD5Ipbfc7yarlluivt5Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4RriaOsdt1sFI5AIldj3NAwXw379dJ876Fs+51t2PXt/sVMdnPs2K0/FxlpSViLpb4+kbMSlwWsYKlrCA7O04+c9g4jAC2Gg7Iv8VvdoLkH31ztSefbwBqIuaB+F3GPchw6weEYcbiaBX/hMjaoCaXvn4oyelk19wsoF4VfGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2zEMTpt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso4937441a91.1;
        Wed, 18 Dec 2024 03:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734522292; x=1735127092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyj8Ap7K1BZAQuE1yfehu91/jP7Zjmb2nNdeir2Wyz8=;
        b=X2zEMTptckpeVUZZT0D3Zx404q8mLDTeHdSgH6SirIIyc4Y76i1MQrfMWVWwJJ/mSG
         g+7Xc7MGpboSqiG/1qbBYcSGzT0eu0Hhq3jFbG6/b7hDX9P96I66I7ES6fhhkF0Srvyr
         W2TJ7tSW22jrz9n+EW+cs90HU/UH2YN3zW7/2LV+JmwPocZ5EvJ1OfrEm24zmuMEIu1a
         kBzvJ6EriUyrl7uNFacw5ltMWFOUtxzgX6/Cy80o6YNtNLQYkY1DC9WYUFFRzHjsxVMc
         z0YPzqWDtHP4qeBGAW1cWLkvnr2a1R0AbyAwRyKjEUcnObM5VqU+1bD10Cyj+mIyzxia
         f4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522292; x=1735127092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyj8Ap7K1BZAQuE1yfehu91/jP7Zjmb2nNdeir2Wyz8=;
        b=RQrsRoj9zUvrxmZVAhU0o+zWkxIyHx2znJsu4oaW7aMUfkvzf8dnoIiW6R4ii/Qrpp
         IA4t74xPPnyb/CKAtuK2uPqtsabaV7AdG9N1iBdiv9pLlxIaErqxVGH57iHADW86RAAd
         tVHWj0+ZazLk+vRM95rHpLBdFu90itNcvTFuX2NU3qldV/ivlMJ5AO7w+yqVRuod5gUT
         K263FeUlQeU8w5id2bsmm8OVUGI+TPbvumhb0sdcpIyToguui6x/7wkleZEtqwzyg8pa
         xe8sDmg9XqsiUWzvmEYP8W+/hpjD1VNSbdWLKjwAOveA78e08AQyah5QnybaGkmGf+Um
         VLmw==
X-Forwarded-Encrypted: i=1; AJvYcCUD/PferyOykuiwRZs7sg59j2zQFL4Zn/HcM3uLMeC/8dFUXQg7ReFhPx81QRDcdeGb9CJyCe1f@vger.kernel.org, AJvYcCXfC89hUAsark0SjGpNo+9YK2Ec9Gu8pD/ClLa6Vo3CgspCbv1oNaTTieJZELzmkuDYmn2DwrL0ixOq@vger.kernel.org, AJvYcCXuZ/IzJIRpGow3Pd7fA2nbnpd6PWY1ufHcGJ6M5QsAvlnsCr9PKMat+duLpGFUsI0whxz1IsHjm4mZ6U/W@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr4OjqMNFZlsLlQP6r3zmKBWmYRKVVoI6huHrQilah3z4APZ6B
	PZ+FCSmP6JMFkdsetGdIciDz1Q11+M3IbG0uX7qTl/7VcC0Cu0SE
X-Gm-Gg: ASbGncukoPEp87xPew0heVrIO72OPiYm7haiIvRW4HH6zBtFlAk/KcPBcJQMuFKxYu6
	Rai0JF7TGpzoGfg/ElYAe3xi+2XalzOTwwU626YiihfgTGaB/CbokzNRjsKazUm2nt9eXRyL/EJ
	zYaNO788Na+ltuKjTHo9ydz14hM7gGFZuXLQl5OJEOn0H2h8ukxGeJ/ZHIlI4490No7GI2sMF9z
	fA3LasM5i2TBVwvLpBw7MQrYkAH9GvFk6uQGK7pom8MDW+YU6UUuhhlCCdEAs/0H2KQd3++DBX4
	vflrIavDkoW7dbTmYMAEyw==
X-Google-Smtp-Source: AGHT+IFRyIbN8ECWy6DzsuI2osZG7JECHco2/VwojjYl5BcOV/Bt3FlomuUurW8aE5vh8OivSmLSeA==
X-Received: by 2002:a17:90b:5251:b0:2ee:4b8f:a59c with SMTP id 98e67ed59e1d1-2f2e91fe20bmr3243768a91.22.1734522291709;
        Wed, 18 Dec 2024 03:44:51 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62cddbsm1324362a91.15.2024.12.18.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:44:51 -0800 (PST)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Wed, 18 Dec 2024 19:44:39 +0800
Message-Id: <20241218114442.137884-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is submitted to add GMAC support for Nuvoton MA35D1
SoC platform. This work involves implementing a GMAC driver glue layer
based on Synopsys DWMAC driver framework to leverage MA35D1's dual GMAC
interface capabilities.

Overview:
  1. Added a GMAC driver glue layer for MA35D1 SoC, providing support for
  the platform's two GMAC interfaces.
  2. Added device tree settings, with specific configurations for our
  development boards:
    a. SOM board: Configured for two RGMII interfaces.
    b. IoT board: Configured with one RGMII and one RMII interface.
  3. Added dt-bindings for the GMAC interfaces.

v5:
  - Update nuvoton,ma35d1-dwmac.yaml
    - Remove the properties already defined in snps,dwmac.yaml.
  - Update dwmac-nuvoton driver
    - Add a comment to explain the override of PMT flag.

v4:
  - Update nuvoton,ma35d1-dwmac.yaml
    - Remove unnecessary property 'select'.
    - Remove unnecessary compatible entries and fix items.
    - Specify number of entries for 'reg'.
    - Remove already defined property 'phy-handle'.
    - Update example.
    - Modify the property internal path delay to match the driver.
  - Update dtsi
    - Move 'status' to be the last property.
  - Update dwmac-nuvoton driver
    - Use .remove instead of .remove_new.
    - Use dev_err_probe instead.

v3:
  - Update nuvoton,ma35d1-dwmac.yaml
    - Fix for dt_binding_check warnings/errors.
    - Add compatible in snps,dwmac.yaml.
  - Update dtsi
    - Update dtsi to follow examples in yaml.
  - Update dwmac-nuvoton driver
    - Fix for auto build test warnings.
    - Invalid path delay arguments will be returned.

v2:
  - Update nuvoton,ma35d1-dwmac.yaml
    - Rename file to align with the compatible property.
    - Add an argument to syscon to replace mac-id,
      with corresponding descriptions.
    - Use tx-internal-delay-ps and rx-internal-delay-ps properties for
      configurable path delay with corresponding descriptions,
      allowing selection between GMAC internal and PHY.
    - Add all supported phy-mode options.
    - Remove unused properties.
  - Update dtsi
    - Modify syscon configuration to include an argument for
      GMAC interface selection.
  - Update dwmac-nuvoton driver
    - Remove redundant device information print statements.
    - Remove non-global parameters.
    - Retrieve GMAC interface selection from the syscon argument.
    - Parse Tx and Rx path delays by correct properties.
    - Update configurations to support Wake-on-LAN.

Joey Lu (3):
  dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
  arm64: dts: nuvoton: Add Ethernet nodes
  net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 ++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  12 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  10 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  54 ++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 182 ++++++++++++++++++
 8 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


