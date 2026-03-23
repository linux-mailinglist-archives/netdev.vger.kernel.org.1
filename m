Return-Path: <netdev+bounces-270456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGz6CtAUwWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-270456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:24:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94A62EFF9F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DED230160C9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C9366570;
	Mon, 23 Mar 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRoK6Drb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A438B137
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261086; cv=none; b=faqngAWFug0X/M7HK4n+t3KTYIOEKqetWuLY3sIrlaYd9nFg7+2hJw8ahz+vdsPI2S7f9oR1asXRDHnByt1Pee/UVp78BYRfXRkPeSTQEt/tjGyZzysU8XR2tjUgnyutVsMoOBSnpNr9heMmqhoU5urISurN+1E67SkLrGpSLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261086; c=relaxed/simple;
	bh=3kzYLFxHha33KjHomXc1YKd7gi/lFY4K2UDQVfrSaFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmJF0ETBEQNYTmYanPJHN62qD+Cxi/oWwO//d7ig9RFxd1KTNZ3Lmmh//Z3+CM4u2Uqhx+D4uVydFsT7O50oxJ5e2G4Qjym+W9+Sc9Oot6b2bbesXtA654YLPNtQf/TF5gk2/arAHdGF8yA5KNdybqOP4Weq02cwL+8GYrS2/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRoK6Drb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8296d553142so1971b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261084; x=1774865884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHtEe1e7RiyfO6lLZp+boVdOJK0KK9ZEoEY9OocgKBc=;
        b=iRoK6Drb/5V+c5/6TL7H00fUlsgI9PiLijuxI6dzDH8RW6tF0zCQewKaDYhE4RRWKS
         LpVH1TDM3XPtbQaVJjxDIKE2lGgUWN1qwPIrtXfyVrnyUucXAJbuxzw/MbKlv+pbKkrI
         zZ0WFAGP89LkqCJD0phbYkvsWE40sshfL5HTTl+HWb15vw0vo9cmy2itK59lYGTc68EU
         eBzihAb4Fhl8J2bLd/tvmydbTF+dvqgAw78gedece9p2ShtXYqugGJcOAdisn1yLjWnX
         pS/RFCiUIp3Tk46M0yYROnseqpgPduDzgRWPoBZbOGJ4E5WSHbghOsjx6DrJJ05+k+C0
         ukTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261084; x=1774865884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHtEe1e7RiyfO6lLZp+boVdOJK0KK9ZEoEY9OocgKBc=;
        b=N6gyJ0QZxtWCjZ3QDV6E1wjNmOLpP41Fg/ElWni5xkuAlRq4HUz3cusEr2EoEnsTfb
         nFJhdplE8nmAU5EwBQJc/ZfagpZChub0L1pMInKl3/5ZfYXjG08jai7FfGf3msRvvqdY
         mZlfVA1/v2vkAxvV5GpCq3LdOK5InlRTgL0iuSrruUM+VoVATpCFibQs2cspTMAsIbug
         BtHwoIhcwKpQys5Gzt6CRtgUdvll/BGQQed9NjQzHqoBGa1TFVhkb8sgmJwmBuhEN6fX
         /qFN8lHOxKBe2AO4scM9aL5xdbonACqFiaG0oKEQMwMiOd2EUMiWxQXgFWghzpcfzQId
         xyDw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/C1AX3mth5SbHZFjKr7cvf0IRIeQdhodEt1KsKwWU6UiUEnSaDUOO08eLH3NHpclH6hVs5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkF0bqgpPOgf2IX1nr3fq6G+6thqP4Es0kilhT3uYVwoFrsh4
	QV5O/QfDYx4oA0HlVDi4lxOobJ+xLsd4GlXR2NVGhhMO7l7SBOgO1jGR
X-Gm-Gg: ATEYQzx5BmAxhLn+Sx64oTScc01vF5lgOeae7K4tVapbJVy/UH1ShajwKbeP/nffdIn
	+NFj0nHDN8f1MFMB47joERIb5yOQOfiM8//YPiNai+Qnr4maXUfRrljy1MqPVsGbk/6jsMZaIDq
	iBmGLFOcxJUaUEsuwx2nLo8D4A/+2jlaCaNHAkc2CZQgi4jkLca7t1ITzbzzSwzfi50LHzS7wW2
	g+FK/ZE/4qcUqsR7gS8UXjoTk/II0OAebvhOZ7OVbpNzHyRCGIpM/Ghd5gckTadItdeyO6PEVT8
	ewN/Xdme81QT039WaPs46xciPnd83a5rdW/fomrPjCzClOwooKuhrkEf1XaWG4+TwoVh5sUqptk
	5smDyp4UHP4orP7fVK92MkV3JP7NYfp1HPzjXBxN2DLw0zCESWpMn+Z5CI09fG8aeIa3oaJXs05
	vfVqOmng3ND5CajR0ZxzpvPfmHRxIf25in82gCq6+l2V2q989UpF6A9wGJyx0H1XFhp5cddJ2zw
	5x4nJtOjSlI
X-Received: by 2002:a05:6a00:2195:b0:823:3078:f684 with SMTP id d2e1a72fcca58-82a8c35d2bfmr9312586b3a.32.1774261084178;
        Mon, 23 Mar 2026 03:18:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04220d9asm8630779b3a.60.2026.03.23.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:18:03 -0700 (PDT)
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
Subject: [PATCH net-next v15 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon, 23 Mar 2026 18:17:53 +0800
Message-ID: <20260323101756.81849-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-270456-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C94A62EFF9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v15:
  - Return error correctly in probe function.

v14:
  - Fixed dt_binding_check compilation errors in the YAML file.

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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 140 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  25 ++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  24 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  52 +++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 136 +++++++++++++++++
 8 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.43.0


