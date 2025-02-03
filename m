Return-Path: <netdev+bounces-162006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABB5A25212
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 06:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E731D3A4713
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7B112AAE2;
	Mon,  3 Feb 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5PXWv/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572486355;
	Mon,  3 Feb 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561426; cv=none; b=b53X+hCUEwdrnVLMoVJKoA36nZa8OGvcG57SFuoKbxjLslgPdTWw4FMn991ecTw0rdepO1h/rtK4fCcRut1PMAPxxJYrQoyHrSL/g9sCcO6B42jGtXKkQJIR+bHqM3Qrfy1KH1ZlRsczWLH2gIUxSze06AXpPx4biSBx5j09bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561426; c=relaxed/simple;
	bh=auSOcwIiAravbYr639Krp/AZ8pXk/IF/2JGAtH5PQf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUK3rkVD/VAQyQUfOTOZfZbchB4KafGX9PTiEAXJRWa9yb4/ZeqXy3PzjuGzmiIm8SDd4DyQMqeG3asW9se5crfuzpKtKfNUVRgTDstoLmJBpG60ocFC0KhgvqrMjGQRxpiL/0lmYwImO53ZZIP4X3IoTxIaxNUp8gaeLBT+YmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5PXWv/+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so69267575ad.0;
        Sun, 02 Feb 2025 21:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738561424; x=1739166224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FGOb/kuuSUyymnQVyBkrBupzFYWT4l1pdvKkJ2J+xI=;
        b=H5PXWv/+mn2M6twPzSWLizqzg1bPShmfsObk2M9ZEG+wdZ0l2nYSQm+R/99TJ0vR5X
         5mtgq5+FMeRnLmbjuT9NW6uyZFdFEuuwtlj/Nxc9eWsfMvtg1S+xwaK/qAaHEqRnAc5b
         tKYg4Hd8t7UxeHWxgDlzOprCHWAfMi0FL4kmEhGqMfjMTOffSo3ElHFw5EYRI43RGSYb
         +9DZ+XKFX2n47mFJ7sD7dyD0lO1pj0WmOfnGsot3usoZ756HXVI3JqpreHV6uoHLm5KY
         kzM66j8rUoupsvrrNXOfS13+3sXSVwm0EjUU2bFAeYTAqr557gz+Ww2UAQh3CYpP4Pl9
         4CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738561424; x=1739166224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FGOb/kuuSUyymnQVyBkrBupzFYWT4l1pdvKkJ2J+xI=;
        b=fZ8koBWraMVupxNzyq6tRBvpO+ts61zQ/PnBgitq8Jsk4y+fgxQlrl72HPx36RB2V4
         ZdAtWGXlSM12QGi+pQJC0o9IaSBFzvD24t1FjyxpQKZjOlqVLvfd+oMQwi33AEn0U5Yc
         UMP/gviNt28vEpH+UKiL3yX6v82DXgFBGNKiVy4yY/64bHdbXZhHFJxA4Q1V7Ac2AEy8
         UG3bVCIIbv2w3nDAe5XvxvPvp65/8bUpgVbkwAQCtkH7PPZ4VvUf5gOBvMfJyNU5VZdZ
         pL3NsYSRjFmZ0TkQ++DzbrIT5EExy4iP72i1OrAW1XxB5j2gESkx6VnihHH1VTD6kLIM
         3LCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu0VlCDy+i/2AdHhPHQRdHEH4HUIFIvnbSZzfnrTh7Vf0NUJ+Z2is8LeT6WbY/nzT2JrZ4vQwP@vger.kernel.org, AJvYcCX/p7JPiBKBDExG2HtZYOy/lsxL2VJhWP03K6AukVTLwQTOv+7GoBAXNBkquPLusVr0AELs/vrmpHFz1akK@vger.kernel.org, AJvYcCXfq17BqSGcjxCiO6naV3xYX9ulI2w0fVW8vy7a1lgMPiadlMKhHkaQ+/Z2eVt5arq8GlQcWV/vPtoY@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsX1HLdLUX/XFkeIuaep8oN5MwydlP5vQ7gnH8QIkoz1YbJbF
	siJ/sWgelVkJ+9fOeEnvQgqe3t/dNO2gHHS5D6dBZQpDPTGc4yo9
X-Gm-Gg: ASbGnctiHAlU3Z7E+QoHut1BP7HQkZOpSNC8AesZ9Z7cArE3f0Xc4YNy1OxInoTqh6f
	tAeSjNcVTH4GKfFZrR1EneLn47klJklE5RrSg3uoih5KvJaX7ru7OGC55Lgi6fx45GdPUnQE2F1
	9259eYIL+Ngc6+oEeQf8XV6oywZcyECtLB2FRhxA0gmpnEvUdFmRsyhnXITSWhghp0XnvMkt7g3
	UIleGjM1yXe9rF0ha6FcqJZ+4zDaV91NJThDXdYB3SW3x3wYu0mc7d/lfKjovcTZmosnS4XlH+5
	O0zKXDVeQGSOqM33eebNKqsM4kEwZEGO7G24Y4JSN/pSk8Ug8vdrxGH0
X-Google-Smtp-Source: AGHT+IFZo0ftKSRImunKlJXQj0l7sQfkYC+YNDQdjmv/qB1QLAW3j7xBuAzdPaBhuWUb5WL8D9R29g==
X-Received: by 2002:a17:902:f546:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-21dd7df98f8mr329030855ad.50.1738561424238;
        Sun, 02 Feb 2025 21:43:44 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5fesm66894555ad.132.2025.02.02.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 21:43:43 -0800 (PST)
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
Subject: [PATCH net-next v8 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon,  3 Feb 2025 13:41:57 +0800
Message-Id: <20250203054200.21977-1-a0987203069@gmail.com>
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

v8:
  - Update dwmac-nuvoton driver
    - Improve the driver.
    - Update the license to GPL.
    - Update the description in Kconfig. 

v7:
  - Update dwmac-nuvoton driver
    - Update probe function to use stmmac_pltfr_probe instead.

v6:
  - Update dwmac-nuvoton driver
    - Use NVT as the previx for all functions, structs, and defines.
    - Remove unnecessary comments.

v5:
  - Update yaml
    - Remove the properties already defined in snps dwmac.
  - Update dwmac-nuvoton driver
    - Add a comment to explain the override of PMT flag.

v4:
  - Update yaml
    - Remove unnecessary property 'select'.
    - Remove unnecessary compatible entries and fix items.
    - Specify number of entries for 'reg'.
    - Remove already defined property 'phy-handle'.
    - Update example.
    - Modify the property internal path delay to match the driver.
  - Update dtsi
    - Move 'status' to be the last property.
  - Update dwmac-nuvoton driver
    - Use remove instead of remove_new.
    - Use dev_err_probe instead.

v3:
  - Update yaml
    - Fix for dt_binding_check warnings & errors.
    - Add compatible in snps dwmac.
  - Update dtsi
    - Update dtsi to follow examples in yaml.
  - Update dwmac-nuvoton driver
    - Fix for auto build test warnings.
    - Invalid path delay arguments will be returned.

v2:
  - Update yaml
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 182 ++++++++++++++++++
 8 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


