Return-Path: <netdev+bounces-144308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ABE9C6894
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6467B22AEA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C101714BD;
	Wed, 13 Nov 2024 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFqdBp2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A816EB55;
	Wed, 13 Nov 2024 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731475201; cv=none; b=OU1dJOAzn2cQD5TKo3bqB3X5K0IFdz43FcDU8fIcFeBcQUh8vb2tOj4YvBI40oezueqjrnUW1N5zQvGGwYn0REVoRLmeHUQCzrX1po6EHBKLKADg53WECSNxwmZAtEj3k5uRJBxUoG6UGAnOAYHlnfKS39Mj1vkxg8mKBqfsJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731475201; c=relaxed/simple;
	bh=F7uHLhnUpI9W2kazlu7g5726ehWjTWM9euD1ENlmya4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YiA9OUboZOD2ic6giPZ89JcSe3U7NC4GXbxCmajQdJLnsg/LLvNyEiNJJapAkymcAE03yuRVsiZZE7x5yzCSsojaoXmiBw2jS+0oqI3yINF3fPZu9dpD0ylcI06tq2Vn06gWLIC5/x4xFtIt5mQOAD4VUy2zaIWwxnLcGoNy1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFqdBp2r; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so5361127b3a.2;
        Tue, 12 Nov 2024 21:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731475199; x=1732079999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwuqnvj/nbrL3+EwHhwq8mWZzBCYb5TWiIcYxHRcvLE=;
        b=WFqdBp2reEcA5bMuDl5pJHFTAnYz+eRbimlgdygvSwEJZgtni8mWIaz2cOvNQhibch
         1CqfZvwC/NGrk+J5hV6luo3Da02BZnVweHy6lcOx1Xw3jAS9n+avmUNKe4OHiMVFJdzf
         apiNryf2+4RKvBOIgGriIt2IW4MRULzJKpZLTylF8Ne8m+cWJCMsNSWE/d3+7nrdKPGy
         6lXNB0e9UAjymsXTnFNJdoKEhc3ZAOMdD4bNVj5w3FOr/QqBq7QjUo7KfgYKIo2QbVD1
         gV1bSOJvqpRlkxLAVsvEOUanuTXpzM9hOs5Ty82dJqkDLNpWyecio+Y+i473goZoMcX/
         IarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731475199; x=1732079999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iwuqnvj/nbrL3+EwHhwq8mWZzBCYb5TWiIcYxHRcvLE=;
        b=lt7s8a0SkHHpbCTygtgEtI9S25YiZJ2TPpz2/AhGygSyjZz3zzZMKS+ufa6VdfRuH8
         aaNaQ+c1RF4DGC+YJBpOM+A5U9dAmPL0mjjsHgovxqFZ8BY/QNvnMClEOsLzzxporSlj
         FO93YBtQ0r9I9lTKF6twmJh6T4Snae284W+qCbjlmLD+tnc+n2axlknpCq1xaGDX5/yt
         T56RNc7yg4DdDJVP2A+U5N1fWWdj4SHPdlQNx57p4mBiX+jY5U5yOTqwa3LgTRnThEru
         /9ARxDf3P0gKoAM2Ht5nYOEvRE5u3YgGitVlos1ajE5dNYXDurdwts5MdTDWk12lKem4
         SKaw==
X-Forwarded-Encrypted: i=1; AJvYcCUqRXApSW2qQEDOQngAvXXUPEi/KZETZymlWcYYITT8bgNaPaaU7D6nY0AT7amsxx97cY7elOdcvBLA@vger.kernel.org, AJvYcCV+z4ICCPohSOHzMUz6MYfpWQqJ05Nfq2VSLd2DtNNuqSYSxsrrMFX9WH2qR4AbkvO6nLbeRCmo8L4KwAka@vger.kernel.org, AJvYcCXaN2lGI0LnZYN+Avm/n2nbcDDMdgqMAIGBu2Hj6Fj5pPibzQJLUIV/0GW8SY+ZPVqmbXwCX09s@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6Fum2GQM23TqFn/ONvpnJuExLU/pcVdGhq0xEjGgdVcSqGgk
	ufsea0gl/mku5ew7/dKDlld/whXVQih5R8uknZkwMiCrGopcASdY
X-Google-Smtp-Source: AGHT+IHHLuQHdAS2u9WN0pIMIXl2KNf3Ujr3Tnj71CU1NlZaH8WrIseMiurWt5EYjyMM3qTV3eIdXA==
X-Received: by 2002:a05:6a00:2385:b0:71e:7887:81ac with SMTP id d2e1a72fcca58-72413349148mr23941105b3a.16.1731475198540;
        Tue, 12 Nov 2024 21:19:58 -0800 (PST)
Received: from yclu-ubuntu.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aaa01sm12644376b3a.100.2024.11.12.21.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:19:57 -0800 (PST)
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
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Wed, 13 Nov 2024 13:18:54 +0800
Message-Id: <20241113051857.12732-1-a0987203069@gmail.com>
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
  dt-bindings: net: nuvoton: Add schema for MA35 family GMAC
  arm64: dts: nuvoton: Add Ethernet nodes
  net: stmmac: dwmac-nuvoton: Add dwmac support for MA35 family

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 170 +++++++++++++++++
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  12 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  10 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  52 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 179 ++++++++++++++++++
 7 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.34.1


