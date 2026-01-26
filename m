Return-Path: <netdev+bounces-253411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLwJCTVBd2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:25:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD1186DC1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9593302DF6B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4173B3161B5;
	Mon, 26 Jan 2026 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY9iHybw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F0330332
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422987; cv=none; b=M6AZ0nA+C28V4d5UzpJBQ5ZN8J5x/N5SMoL10cQ9Q/Ku/0ZxH79uZWeh950TnNQEvv3k4BnaoV3W8SmodJA4059Z482ACm0gyvaFC1IUaLx1GFYykTcaWBAeIYjbAJLrsUfRF9Wch0In49uYQfCKGj65ifovFumiOr35pqLv6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422987; c=relaxed/simple;
	bh=akcnJAPugsQeTgIwjxydursYndWIjQsiH+aGDF7fLnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fw21NDaImLEG1MJbBMYCCdG0IXfrWL+HncFmZUtjXLfRbXHyQTzy3X/cdjm6Zkj+vG1rsNOurjWaEg8QLo1O5xzPOLato0laNEo//TiSHDFYlTEW3XRR/FAsLBu+g7BilUtpLoK7ne4BPtd+OvPfJRqs3+ItCn13JgeZPu7bLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY9iHybw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8230c839409so3332979b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422985; x=1770027785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aB4VXKeNKbcLHh/83xthm74hAlM9LbeMyITc9rvDEEo=;
        b=ZY9iHybwvfsUuvt9mUUaQ1RjFFzitcm5zajMrvx4aqrZcKee/lOhB1lCKy8Q6tfXB+
         DijKNt26a2hClMTJXyHCKOqGp/cGat1j9m07Gz391qr8QGOiMUR40xDmNltyRSza1/ku
         IaVCRoOfn3kFraS0L0BDX1OZphej5oM87BFAT9t5haQBmk/Ubgm6Jwa+hX0rnqDsfDsA
         o3w0exdWGtqNibQDqcspy6//W3NobQxhcTwYwmRPUWmGcOnJkkwq506tiKNcyZb5ga4J
         VtORNfQBIsLhOaJ+c7iWtHF4UDX0vZXHXi94+orb++vn2T0ZvQJ9iq6WvzWhH4NWl1oN
         0ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422985; x=1770027785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB4VXKeNKbcLHh/83xthm74hAlM9LbeMyITc9rvDEEo=;
        b=Nu5kW5UFcxpZYk9Y0gfoI25SzpWfjM/uxW4XE8GwPZsNQCvP6e6i+hZ5oGxJZ8b3Yh
         b84liQKlBtVJb/pLGhPHHpKsfg8k3L6D5SQk+jsVBFGvgeAcf7K39vMKy5I9QvFDy04b
         T3OJs9TzOQg3UXQRXzamxd2udJ20jLgeXZL2keEbLF3S87Npp5BuJG3k1ZAzZTMAtupL
         JW0H9oU8hS5iYgBQ+1cU28RtTqwlpGX8aFs2//K8fnod6LK6MLWe6WdRuVkVNV4/5LuO
         fgvsCjzazZYTyYR0woxm2uWNPoxjrq2PxbInlOIHQToydaZOlTt/+MGOLKLxT2OneKet
         g26Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8JC6LNS5MpJLIdaq8wesKEgr8+KsuGN1zSZfT84RSItLZnof65EqaPE61X9N/xpUnQUJDzLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jVdHoHmf9O/stMEgOCKCWpXggCkmJm9Wf7CjpxMqwRXftmSj
	rIhJwdFnHjEg3r6J45BVci5XnF2ebM4ZM1QzxREe6zx2aCv6WIm+rqLh
X-Gm-Gg: AZuq6aI1rDbtDwBEqL33V5H6I4BA3b3wn06Kv+VBZqptto8uNMUxo6RIGVnNYzCltaK
	Uh90ulgsBoEmDVjRB1wsJLiQ0JBH7PlOSZ1v+i/GrE5cEjiIv9Ppo/8hIC0Z+SPY4t4tQEuDMp6
	NuKXpMtgYfhlxEoqNc2R8EWNvJJghSEbmvS5UosXshzNVXfySLx8vp4b+VITOxmtg0GiTuts7NN
	X0eEZg6utjkpgjPCmiQ7woVdn0iLGtMepR10EbgOAVtQjQVOj2+KBV08sXx98nvAPRgv89536v9
	QV/B2heccHboX8xI9N416dGnuAmrdbOJFJ2rJf9WlT7FEdmXMJXPSl22e/r00YBQPu1MPeQcggI
	OFC6JnRDY2jCbAVtJoOuL5bTE1ilXZjyVUQwJSjV/b/uBZOG8qDh8kh8tnnupkysQi10sR7b96I
	as4qFCi3PY7hSkHFTGY/VZ31cYHxx10x+UN/c9Xjz6q/xDhb1cfrKxQ732+MfDG5BVeDjZccl+
X-Received: by 2002:a05:6a21:3988:b0:38d:657f:7d87 with SMTP id adf61e73a8af0-38e9f0f4a4bmr3644339637.13.1769422984868;
        Mon, 26 Jan 2026 02:23:04 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd776sm84958275ad.26.2026.01.26.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:23:04 -0800 (PST)
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
Subject: [PATCH net-next v9 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon, 26 Jan 2026 18:22:54 +0800
Message-ID: <20260126102257.2619862-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253411-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAD1186DC1
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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 +++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  33 ++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  32 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  32 ++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 174 ++++++++++++++++++
 8 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.43.0


