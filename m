Return-Path: <netdev+bounces-145768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0899D0AF0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7FE282653
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A8918C939;
	Mon, 18 Nov 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/LiJ9+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DF18BC3F;
	Mon, 18 Nov 2024 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918453; cv=none; b=UkzOF8tni9UoH61RZ80BmADXInNrJ8fVsob8+fMms8IdJSF4PF9w6MuOKxv/KrElcO/h4MNiRUDtPmsON2x8iPyaCaRllq97Ihg/jRd8cxxrErISzTLLQ65K16afCszaqFZH5sgzEJMvsfamhYYxV8A5bFBhLX/KsczO0MlcYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918453; c=relaxed/simple;
	bh=yKqQlgDvbxWBXdJnH+2SQxWsAjGR8brRbvHf6wRTHz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d0xFjZ2Z1jvN0WzyHTQ8tm1VZfPsmlVGDXxqabrsOaDCNnJbDhmchkyhs4prG5yD24bTxzxId5LvBrhcthLZFfhvZpOdFJIeEQX+RT6eWE7b2Dm9Z8taNpBSN7Ia6DcV9CQkuJEuMtCnE37HF+iWMnnZL1/b3tw/BxijKnP/qrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/LiJ9+A; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c6f492d2dso15972875ad.0;
        Mon, 18 Nov 2024 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731918451; x=1732523251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkSbdNRIUJlQANFk/zwDmvqLsXhMldYS43rY4RRFAzE=;
        b=h/LiJ9+A2jPNoMVbd07NnufUO5AwjtSxTLsluwiTieKg+KADKjf2b5OSeMKrh4WmOF
         Taw0nMdEwjdqgU/UNBOa9fIElMbaRrO5FjCs6X3L18tBw07wFFsBYNes4gSpTs8qxHJG
         qtTIaqdtG+JYwtfj/SqzvDb4Kfc7/8HF2IWBz6M1BVPZ9Q0xdnS0oubfFdtofxlsfjGv
         ZdahDK6ddmQ/HFAiGpxGZHpyueQRZp7ys0XVk1Jfht5CiJXwxwMWx8hsal9M3YhY1PIy
         o8O15/gG2vHUzHaWSEfgXjoPF5AipMvYxTpWvah7wqYIQaYMAnKsVefAgqskv/2577Z+
         qg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731918451; x=1732523251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkSbdNRIUJlQANFk/zwDmvqLsXhMldYS43rY4RRFAzE=;
        b=Lawjo4QK/msnMcGfj2hH7clWDYahE9P9I/D9YEqPZloW/vfywOHdp1aCPk49kI9h+a
         iJ+DgWkXqyv4jVS9J/aKS1nWBOKy8sYjyWKDebSsy1mqMgHyalXh30zLkDcjTpt1NVTS
         9gq+uizIlday6e5Ixcj3vsHLPhSldos0t0tP/GjHw8ZhekMPQhrkfKV0lFVVJuTV8fxT
         awdikL1Ko8Tj48Zwf01Fpzod8nHBgzH43Hix+eqZuqFGxwSIWWrwu2lSB9d62cXTy5wf
         gME7TJ9PJY8vngzpIgYE005AnElFHW8Kn1KK+KTfXDparNef7xKygp0ke/tpJ8ZqQ+3x
         4/OA==
X-Forwarded-Encrypted: i=1; AJvYcCV27Tomkge2V5IPtN8OL6Ou8iJBngGV56QNafVoj+gyiQrMWUTfIqZU3hhZUEs2VFJ7Gb6bHPAr@vger.kernel.org, AJvYcCVZKiIb/Cvda9a1Lswsf05aPflm1Hz2ij6ZIHBcD3QZ/QEkkUox0BMkdwYFAuGB126xI/sAZ3noFk3qvvSF@vger.kernel.org, AJvYcCVhmJUO3ZsyT+Htsseck1NeWd7QgxzEK7p+pUBTKaXsQL9uS4IXe0+cVQryhub1LntFIxfmqwMbLEbu@vger.kernel.org
X-Gm-Message-State: AOJu0YySn6pbtHc2IZ+ifLapixOAgUHyuugfHoj+p36Xs/UtHj2XRXVH
	AcSsVqwpTiwkXsb/PF05RTxrMtVZO/Z4U9Ffe8NDs4Gr1WMcw0GP
X-Google-Smtp-Source: AGHT+IEvoyj4wxb7J7Wh84n7jGX2+vtLnvotel8z2KtjVjP3hhCMcqWSJASSXlB0gPXXOqon5nxuTg==
X-Received: by 2002:a17:902:ec8f:b0:20c:a692:cf1e with SMTP id d9443c01a7336-211d0ed9a12mr171662035ad.43.1731918451221;
        Mon, 18 Nov 2024 00:27:31 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ebbf9esm51883815ad.45.2024.11.18.00.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:27:30 -0800 (PST)
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
Subject: [PATCH v3 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon, 18 Nov 2024 16:27:04 +0800
Message-Id: <20241118082707.8504-1-a0987203069@gmail.com>
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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 173 +++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  12 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  10 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  52 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 180 ++++++++++++++++++
 8 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


