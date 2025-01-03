Return-Path: <netdev+bounces-154902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ACDA0045C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE6518838FD
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1B15B111;
	Fri,  3 Jan 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqpwzUUD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC725634;
	Fri,  3 Jan 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735885990; cv=none; b=YorDbJY00NZbIaAlqJcz0DhrR0VvJRrlf6anSAd+S/KnFJTwPpQw6FmUMV1hRMlFsBYSNgm1o8laYlaToW3/ze8K8VWHWrTfCV5WXcmSgmnDs18isbCsW5sstr1Eu4lHkDArDFlRa1S5uPUweK12/1RYj8vSQGAZEDzWyN0KpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735885990; c=relaxed/simple;
	bh=tSYR9DfEoka4Ii7B+4mvl+hYbS0m+gBKb1VYT+T3gM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnW1jQw52oV6RmmgWPHqBRx31VKH64HQA0f2rYUQO+d8GZQyXnqSNsSRkWY0BKRRFMT7DBMY4Bp67+5fsUxJGGLsQLvVTsGEOLzoN+VPcO4Yn0SnnD6Tynyg+LLNlP0u/zJxtRJEnWH3N2k7WeVHFNjYoGDq6+TSpEYe4KiOKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqpwzUUD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso12356452a91.2;
        Thu, 02 Jan 2025 22:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735885988; x=1736490788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JYhGYLehzzVS4jEYnaJXjDH6Mz/6G3WSbJlmci9/3A=;
        b=lqpwzUUDdoq0z+x4EILNigXO5aMDuDVhmUHCrtCipnVPK2wDVItgiaT8hFcQFAu4t7
         VpfWSdp8p+06EyVM/pb3ubmRPfY6yTsdlQ4RuiR7GEBgma+tN6L+yY+B1jJgCs91j9GU
         KmQxaIcBoA8EKfOpzife440d1DIBs1W1TdFcgbSrC09jcq72lFmBknz4otS6VTlRPJZa
         li0jwyP8fRgQ/LYmHqNIa5G+B5c3AHuu88PXUVKU09U7mha50g7VB5kTd498L5h7k7Vv
         NbWDpYwub0VSaTeUWwdHgKenQFCS8Aby+keWteZhDYXUBHNBz7bMN2MDHrD24cCbh16P
         FxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735885988; x=1736490788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JYhGYLehzzVS4jEYnaJXjDH6Mz/6G3WSbJlmci9/3A=;
        b=vaoefhzQpT49TXUgIPg+MRt0kZGBJel/pPRZYSrqkTS0Kh0b/k9Ih2mBW/+lNOHWEG
         K8bVsTc0wzD2t5opgJGzetv69q0miP/XqBTWDAE8WrBup7p8KzoZVWvFBdd5Qz4+r24f
         fviDhhH9yBpAqRtuPFg3XpbUZkUGbSJSlXEtqS9vDLyGWhWxvZbcdRpH8txXwtbZa8x5
         oZZDtQrKWHepnahnFLE4MKUi66c3qM8NYqikfLjTWBPWlTR6WzPkY96awFJhFjFNFi4O
         AqVq6xXM9fodP6J2AYl25T3G+bb0fO/I4shj+lvWGAtTtu86o/hYJF9g33JUYFB03h7c
         RLlg==
X-Forwarded-Encrypted: i=1; AJvYcCVU9ff+eTht8h//WAH0pUFGDEgHoPsG5snMdNQm9KaM19+RpoGC3N0mMwZuEqQKdf9y1mkc34lz@vger.kernel.org, AJvYcCW9cy1kgdoR4lIrdj842TrZdqstnHoweanOXQKTdnkRjMI00vKPLAcRcMVNMDgTpxXqJSC5Elo2Ru7kytGG@vger.kernel.org, AJvYcCX32AUY08bDNKo4o61i19UCzRVV0FxmefPJrCo6S5BhBnVa/pOLSEyNmb7qhgKM4JFKBzwz1HfaEu+a@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5sfMEFKMb0VmhI4ZAaliMqdzi6XOeMlcjrK16WCekDgyitge
	tt/iQ95Wpe6QZhmMHzoyZZyng+9GpMlM5MMGqhZf4w7HDrT0wccG
X-Gm-Gg: ASbGncuDdCGsTUZexJ4avvkl3yR0Ty2+WCcbIBVuIK0IZ3/2MzrJ18VuAH2PKLD8I25
	jE6D4Xv2y8AEXdkU+gIvpKxCM/YFZymuNldJoflYgBITUhcAyhljjLB9LhzdPx6YamIAyBC4NVH
	PiHTChqi0mKg4zXpQfu5vQ9c3Ut1sDii3kGXS0G4OKZyUW1x3OBoTr8hl4YXWNCeR5KgzKwvm2h
	3m+FWKrRIXIL+SPDYYwLBPSgQGzRt9zMO/sMEaA23kdoORfiS4JUWIzvQ2YWthp8bWG5i0PrimF
	7LbW5RLaLKVXYd5esxv0sw==
X-Google-Smtp-Source: AGHT+IEg9FrZ5YUufYh0MJJtCtJUyPbNJMmGsbwn8DtZhoDwMHr36/JHl3HeB9+5mO4uV2/PACAAPA==
X-Received: by 2002:a17:90b:2e10:b0:2ea:8fee:508d with SMTP id 98e67ed59e1d1-2f452ec2e82mr73280088a91.30.1735885987768;
        Thu, 02 Jan 2025 22:33:07 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d89asm29427805a91.46.2025.01.02.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 22:33:07 -0800 (PST)
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
Subject: [PATCH net-next v6 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Fri,  3 Jan 2025 14:32:38 +0800
Message-Id: <20250103063241.2306312-1-a0987203069@gmail.com>
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


