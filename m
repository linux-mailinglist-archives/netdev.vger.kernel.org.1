Return-Path: <netdev+bounces-263088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOubNt+npmk7SgAAu9opvQ
	(envelope-from <netdev+bounces-263088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:20:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AB1EBBEA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E0DD306F7B3
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B138C2C9;
	Tue,  3 Mar 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep8eRfAv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A63815C1
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529620; cv=none; b=isuqwaCvRGcSG0T6/+lf4htw6F7MG1dqnNRcqs2LGc8JIQ/V03B3oI4p/svOL3Fdn9SUa9kbvxruj7tIkXV9jeug/247cAl/ESXW5SO9Ug3y1POruM1f8bpJWpWYAG5tphGQzkMJDD0qfVGoW8lkwBQGR4JfHbOwf+1XdIA5iUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529620; c=relaxed/simple;
	bh=my9e4whQpD8mV2f3iFrPhKENfMZMudiUnVazjbZAeAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvHK2d0/oG9mE5zqqJkD/V/8IjthmzkDxuHWh4Ra/9BmL4lpew88NKZprT5vc5KeDu/BssEm+6EHsJMmHrtyOWOm6G2tPwz6cMVoLtclKkoUMkGpeXARAOSGowvf53ulRr1KULcT710VT2KDF8ePbooQuqralTfzKzzWNSOlEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep8eRfAv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae4988e039so14720605ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529618; x=1773134418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrr8Af/aGKB61i0C6ukavupGQsufCcEMWOAgZ+sFvK0=;
        b=Ep8eRfAv7wq/63oe589EHFotisw73b7RqPe54E1x/qEnScniE31wRPHqmHHQeIa1EI
         HstL/0PyiUdytbluIc4/++ByH/a5xdd9AKpqQBbomwHJwKr7dP178TCFORl7o9TTUpdN
         ZByBksQlDII1sQtEzIUiPwnUiMjJeTHpFcea2S/1zAaAlHN2aFIuHemB7NUmI+S1kPzJ
         mT/lyh53beqGmY70rK+HRMz4kc2uwSUzUfB1mH7Bijw+watZiI5lhahRwsn/AJO+Dv38
         OXGAPdtFlMIRQnsWt47tN7/UVZPtoOb7UKDSpTgcZxxnrj59cU9+OskRMppKim18DtDU
         al6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529618; x=1773134418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrr8Af/aGKB61i0C6ukavupGQsufCcEMWOAgZ+sFvK0=;
        b=I9iuKCZLPG6sxuKEUffN1gLSRn/kU/ZxRSg3oQx57hfQge4gvJeCOvzQux0dhoN7fZ
         YBP06Uyd5ty8lfEmjbQ6sNywyEgDrzzJg6B8m9HPXrVBPr3zKXF7jFwFI7y6rLhXx4+L
         RLPNWO1j68fDgCa81Yd0fmkIsb94xZqb/POMouHUonTaefj5c0pZpy4T2W2MnYP8DpwF
         kCFFE/DQbM9RGknyL9PhN91rtqCEi5reT0zOT2oCRsoUJvvoKJjK1P+HYSBA7pl5enki
         JabfpY96EWd6+3GGHRmVD9t1M87mol8iLvFuRjItiy0rHcWxNkJ/UDz/IiYKfgaJTA7a
         Hulw==
X-Forwarded-Encrypted: i=1; AJvYcCXehLmffSgSabeqWHUlLEx8uNPkAbezekyxYlIVWwAitZl68D06C4HiFkqxNXK/vJV8c5dbnYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPUVzAZ9J8Ri5ZcQYBHw6xC8cdg6wSeItW6Gj7GB9bW2PhFt9
	tpDl4nfLxXSokT9UYJhPR7MEBs8u/PtNV1CXNQlLmI4Jo+xyBEHe4JlX
X-Gm-Gg: ATEYQzwHToAw3RuP2/CGmn5pMLZcLBHVZ7kDKeR0fejEVDSF1V9INCC3aHnD/OHwZ0q
	cwd/gV+XHdOH8fb5K1MzuM9h1Eeue6yFpuY0/RWpXyWQZo+BnooPnWx/SRUdOwgbQG9Sbs0zhOC
	oyR4j7ZKYfIKSGVnwq5uZA8SYj/Q3xWzyFxVyB+4FAf3RNRmL5p5HchmDch/YQf2eCvWDIEh6/t
	RUccfp/lajX1UTtj6XkXH5KyPvdNSRv8Xb34jjCC2FHW5CMRQTHJHMevP5AgE14clA/sZwDUgkh
	Tqdd1Urb2Kg0mPAl0DiF9tjtggH/xrnfDm75/LKdeTTdfXBZrAbjeLfHu8T//2EEfkRAXIY72Jd
	ErLqO9XpE+wo8Dlb6qXOR5DOrJGshINynIyQ9c529G7lisRvionpPhi8Sv8De9ZKEdPEWZySN5C
	2l3tHzk+dPsVpI9ONZm3uHC9cswc6B+Ga27D3W0+sHGgMHyH8LuCzn3pBuWYSEja8aV0MTzW77w
	R9ut8JVRUlm
X-Received: by 2002:a17:903:3bc8:b0:2ae:5a70:477e with SMTP id d9443c01a7336-2ae60cb2da4mr14189425ad.12.1772529617675;
        Tue, 03 Mar 2026 01:20:17 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f996sm158777475ad.50.2026.03.03.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:20:17 -0800 (PST)
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
Subject: [PATCH net-next v13 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Tue,  3 Mar 2026 17:20:03 +0800
Message-ID: <20260303092006.263715-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E2AB1EBBEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

v13:
  - Fixed YAML with dt_binding_check
  - Added callback for plat_dat->phy_interface
  - Updated PHY-related setting helper function
  - Renamed registers and values to avoid misleading names

v12:
  - Drop private structure nvt_priv_data
  - Fix error propagation to preserve probe deferral
  - Refactor internal delay handling into a dedicated helper
  - Move FIFO and filter configuration from driver to Device Tree
  - Update DT binding to include "snps,dwmac-3.70a" compatible

v11:
  - Propagate syscon lookup errors to allow proper probe deferral.

v10:
  - Update DTS/DTSI files to follow proper hierarchy and port modeling

v9:
  - Fixed file permissions. (YAML, driver, DTS)
  - Moved phy-handle and PHY-related properties from SoC dtsi to board dts.

v8:
  Changes since v7:
  - Rebased onto the latest net-next.
  - Removed unused symbol.
  - stmmac parent driver now reads hardware features directly to support
    Wake-on-LAN via magic packet, so PMT-related overrides in this driver
    have been removed.
  - Update dwmac-nuvoton driver:
      - Update the license to GPL.
      - Improve the description in Kconfig.

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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 131 +++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  25 ++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  24 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  52 +++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 136 ++++++++++++++++++
 8 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.43.0


