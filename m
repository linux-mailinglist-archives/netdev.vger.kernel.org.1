Return-Path: <netdev+bounces-157587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCFFA0AEF2
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24913A43AA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386A230D3E;
	Mon, 13 Jan 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDAEIQVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB5231A21;
	Mon, 13 Jan 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747777; cv=none; b=cCkWsuB4iSpz7hnlFoIFqYpyaFomESqbzDIMSZZv29CR/QclMeBZbfs89vLMO1QmyOnorGapJ61zu29DZq1upbRtB7zN81qKPbamlLAvfakd246xdk6RLk02UxYhB5ZCuP5vGQFaxOsE/PbXFk/emXSPft2WPW+x9J0jQ+DpbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747777; c=relaxed/simple;
	bh=NoZTOLI0Jqi9bqOBRnp6rMReokednWOQjHoLJHtOBGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sU7urlqauNJz6RSh7F3FL+LYwsBKBlLTxBypljX+dUOY64MpvOqE3Rfqh6syQw9CWejaH38xHkkwKoPw4Py/CkyiGdlEKr1xFO3X2dgLqRLvozhJ6nnr82IiD80uKcekcUTw013Ya5O5XwdBM9MrvgCvW0fDIcROzmJnESmHeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDAEIQVX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f44353649aso5189607a91.0;
        Sun, 12 Jan 2025 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736747774; x=1737352574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5kSRwp/LQmi9TB9FOxDQuTUZ2FNweKukw5dyy4zYRQ=;
        b=jDAEIQVXLH5Pl/m8RKN1U08AnAhozghYqw+eA5waI5wIHtUel0wa+DwszGKF8HzLU0
         2n0+lDr1FmZHR6Aa7j3DzT7zyfkMiqgbhwyUoSSie/iUSbJBY6xdKUF/5fe/vDfhGbIx
         t3hN7+v4TvJdXIsE9j4ETLPG2mToO3QMI6Bsyn+1Rkni32eKvedl4c0V2zwZ0hjRjYde
         oHcjahiFDX86ABQN5WEG3IFe8U13L2tExWIiKsqBB4HGcXFtHP9am383YMlS32NwOU6q
         27kiRLB5tJhrV93kNaQ1VzFbFzanbFaiOUhpoLijoozeuMm878GTh2hh7VtyGcGrsKAL
         LTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736747774; x=1737352574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5kSRwp/LQmi9TB9FOxDQuTUZ2FNweKukw5dyy4zYRQ=;
        b=AwL/VZlNkC0Oi5X1iDZr0JseCXzPM5CXq0R771HiDEhjoAsxgaA//aAeZdGNRjhEz1
         us9OV+ik+JxU3rPDyTbxOqN0SyK5MgGfGSlpQ/lEIZeY4bx0+XEI+a1JewIydZjS/qXt
         HyUgoRUFRJX/MNbaWnTHPRj0B7shjgObg45lfiPZ7Sw+XZyzXw9gasLeeXcW76WibwwE
         QkUusCefazQMEBLzJWE4NFe7JxtngoUWZEGFxfeQsJQMur4hIgKeybUcNcrzOlRee0x+
         0709RwBs4pOSPlCF6AfCMXSqRAtfo3XyzfwnrvgH/dxy+6gMLyiPGuorxFF9tSPJbvVI
         DzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL/98ddmxUZy+EWK1O9mlGGsInJwdOPU4X81phlkbCDX2uKdCfvcSdA7TeTXIaYP8b/ef5u/DfaC0+@vger.kernel.org, AJvYcCXfBGY+5x0TcvDhfs6XjHeyQ1wIUEs05qZNrqcVujQbkit9uzEf6s5NwTuAUI5tYyy4h2XXRuOSWsmtXIKU@vger.kernel.org, AJvYcCXu+Nnic17J8HfA44ZvTAGMu5q370XbgNfFnzzZ5BDDbRonNbk8i1O4Y6ktj37lpW+ou5Kx16U9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24xAYG9jUMa5B3oeZkynW9zoQkZCnWzsWlE26o0oqkFgvBz/r
	gz6nLNppkhszgXbMnn8Zlk/wJNRmau8W6rQ+SNDZ4dyV2fi+Lk6v
X-Gm-Gg: ASbGnctVVvCafhO2B2S/syAV4kYLUC3kHj3Pp2qODTyGyqQOINA2PCivcpoCYFBS5rJ
	d+zlKVeXVhYqXwsGyet+vcO75QNDQ/jNBHsgooobrlzmGBedk1Be1VzypFclX0ndU7DxrDtC3sz
	M9OyJnLXRS+W/8YkyizE/GhGTI9YIyQ5FrNHVmJWKgUGY6jClrR+5jbRLDwjgKq3XZngCM8/6w4
	211xRgWmfpnFDC8/VfkSGaSxwyUzybO1vIYhofWX2tD1CC0NdxEYozRpt+ozZQDIPWFPLMR4KMp
	qn1im6y47wQ4mIYpdMt28g==
X-Google-Smtp-Source: AGHT+IFmIR9Ae+L9E2pmOyCcc+X8PWxnJne3SU6MtRQ2xXHY6ezLUBmNIufZB6pkQGPkrrzXMSDgtQ==
X-Received: by 2002:a17:90b:51d1:b0:2ea:7fd8:9dc1 with SMTP id 98e67ed59e1d1-2f548edf181mr30621775a91.18.1736747773860;
        Sun, 12 Jan 2025 21:56:13 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55942188csm7768806a91.23.2025.01.12.21.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:56:13 -0800 (PST)
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
Subject: [PATCH net-next v7 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon, 13 Jan 2025 13:54:31 +0800
Message-Id: <20250113055434.3377508-1-a0987203069@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 179 ++++++++++++++++++
 8 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


