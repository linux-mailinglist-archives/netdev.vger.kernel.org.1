Return-Path: <netdev+bounces-147968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AC9DF8F1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE7D280F13
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA722EED;
	Mon,  2 Dec 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJQxfXYh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C81804A;
	Mon,  2 Dec 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107023; cv=none; b=CNU60f2ZEBOS5R2RXqInaoi1OLtSH0SAjE88NcqpHSrb1ZxGUf4e7WwWkaxv6ZHgXdUCoN94DSdwUqDtFksKEWRxJ3nnl9XgkJVyC8vwfdpirUWvzKr7eEbbZeUUtmEZSEhWDGFRiyv5+4EfEwREWLgpsIr72A6xZtWePkHF0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107023; c=relaxed/simple;
	bh=pir5yKyEtGvMf5i/5wpsq70+zVsXts+joZq/b77jr/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8A9GgbiJYOtLDGbceWS+XGSmY+ThGwlUwFD3Xrg4p8jv7gfrX5amepYbO9YRWtycmnv71UUn4K+QLrmKP/opiqwN3UM2OnxUk+6FZ1uE6V0f+dv9DKVNjj8FxA68Qo77czf+8D3p0cX1maQBzVmUO5ygpByT+xfOicQFAn600Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJQxfXYh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215909152c5so4022025ad.3;
        Sun, 01 Dec 2024 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733107021; x=1733711821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDFs4/7sYxUQAdmK+DmPfpiIkb/3lOGS37ALBYfbAeQ=;
        b=QJQxfXYh6GZY4sRrdwaIggjr7nRU6gtar1RQOscER7MTYzyRvGayPXZmT3TBzKA4Xs
         HQG3v1/qRxvlaMBBZmFez2d0VmyTolqeWHuDQjR3hIcZFwW6iDwDfgC2U3rKFToWVPc2
         /WUBRL6yhf/FjLNp5rFwDCO4xsTtYk+79Xvb0D6rjbbks0WAPKAGxO6N0S+j1wwNjZr7
         qNPb7KxDkn0TzjmUUO4tS5Vqcpzo/PjTkvZfUwHxiOT39IqqLtU/U5cIt0i7mmxAXLPA
         oHZJbhKynqpPK0x8KqqU5VOetgUKt+l+vZIngT+6WnapmK/5xuB3tVxkGzTc8lKY/c4Y
         w3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733107021; x=1733711821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDFs4/7sYxUQAdmK+DmPfpiIkb/3lOGS37ALBYfbAeQ=;
        b=MPy0NlfkRR5rQih/hm26mtEsAAR0yqkU+3rzrJUyBIniMXESsV1qZ9bdg6YPbT2+z7
         YZddSOnBA9dzbsC/vYeqNZcQuOiMhfDXPxDRkOuSWULUK3Zhjd8VJ5+9fcpEZvN45Xc3
         dHmubEXuwd3qjDgsXpVYRzosGrsXmfgrozJT5jjJgJV7Q4olZE2NfM3tzHNMdLGllrAW
         iQMwL7x0wZfvy4dUy4ykR7YEt2Tfj5tqUdRViHUx/fClK8MNKiDD7mBV1GTtoruNRV5U
         sugzvXuaB43ZuQvsfV5dMU+UZnhQHOZGGLtjhO8sr+RpBqRRWgpcgSpUNAKhEuXXrRNj
         H4nw==
X-Forwarded-Encrypted: i=1; AJvYcCUXUKiYoT4DNBT4fNUiaRU6PkaobZz9I+Fp0d/GZ+N9er3py0y1Z53iaFf79Pdt0O0ALpr5hF1U@vger.kernel.org, AJvYcCUgpwCem0aRrL1T3alUIO5S/kDHyM5FxC8Mdcao0wyWDyWo+vpbJinwsos88huvSqNaIbbKWdgy3BGrGHmr@vger.kernel.org, AJvYcCVzfy5M8BRSmu4y5LmYppXovvoKMSYwCQgODNOJ9hJZ3Mo5jHiLxjysDfmKwLmsnGUJpU/tgojc2iP+@vger.kernel.org
X-Gm-Message-State: AOJu0YywjKtwEeEtKOPd3w4RJ2iGTz2s6+9AkvXbPddIU0Dnrb5uLxw5
	d8eEWzymvyohhiXkLD6QBsBNyNe5sdDETUG5MdikoV2//iBfqDVF
X-Gm-Gg: ASbGnctV4lzzw7p5YPc6L150E0eIt+eAi2/zc/vzxDvOCZsk4do4s9b+ivQ4Z/A81X1
	mwl8VPe2SThcTJvMB/dSqurCYA52DDP2myU7TyqEiukuojlAQIiw/mjOJbMzN6rysRBVJ8LZRQw
	0gVkkHC3IUZdoQHuxTYUvElbfrwHZN35bcoIiDCPb/rOzSg66BnQNM9t7UTBcQvj2S+YjMkInJH
	mheKEA7ZNY8RQC5SVXrgxwLlTwhBh6atbA6yhdyRKTPB1WUJYVwUPDmFxY9EdHDAfAPOexwXpHs
	OpSIxrvHQSkJsmw=
X-Google-Smtp-Source: AGHT+IGLWJOBt6A4ZzleNpaTexfFquv9ndvXCA2owoRgs9f4h1shTttjNxjyQrv9s0g8p/Xs1tMZ1A==
X-Received: by 2002:a17:902:d491:b0:215:4e40:e4b0 with SMTP id d9443c01a7336-2154e40e808mr142897375ad.9.1733107021039;
        Sun, 01 Dec 2024 18:37:01 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebee334sm2306375ad.67.2024.12.01.18.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 18:37:00 -0800 (PST)
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
Subject: [PATCH v4 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon,  2 Dec 2024 10:36:40 +0800
Message-Id: <20241202023643.75010-1-a0987203069@gmail.com>
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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 134 +++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  12 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  10 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  54 ++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 179 ++++++++++++++++++
 8 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


