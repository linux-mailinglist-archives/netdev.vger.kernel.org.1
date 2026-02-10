Return-Path: <netdev+bounces-258028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDkRGCLBimkeNgAAu9opvQ
	(envelope-from <netdev+bounces-258028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C509E11713F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3587300184B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 05:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422922D3733;
	Tue, 10 Feb 2026 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juAXZvOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F732BF32
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700960; cv=none; b=nb3gj8JR77ATN0RjgwX/KVVEA5WLSLEA8TXYm/4bDexA+q9w503PnDpfhokPsd0f0Bcv7aqjLecg7NjeJpfa/wp1sij7oB48A6TPFbTDfMxv2jEx/jXDRcj1c//tG1XuQCxPzt6FBOaoGzcDJkjzhYaA6HEldPixoOAx/gxX5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700960; c=relaxed/simple;
	bh=O8l2fAzrgh6aNA8Ul4ZorhabRZLemD4a+0f4S3xUxRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAsi+6C5SDDyt7s/TcD7NyVEiL2wIPBgw2Uwp8af7MdBADHjgBnx0yjHJmqLjpBpr63YQ9HIusvtZnECjpnVrDokohrAePMGS9575pwXIKCJu7RA46zkPZS3m3ZNU461+E8ugNZCyoFJ6U7Qxe5Ei02rC08iLZmn6b29x99dJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juAXZvOo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso2032025ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 21:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770700958; x=1771305758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slGvVNRI6DMwxYRFHCioIZD1AV/VPFPU5qKmLSzslyY=;
        b=juAXZvOokRAmIl1g+8Q6yaHGQd3dvMDfxtrfP1CwRhahv4GA/ufy6PiY2XNSacCw1E
         0bSi7cJIgaKZ+IMeJq03Rvp2YnzmKPGKX0IvO8tefMUicM9oDJP6Pq41CADZZayL5uhU
         x9aqYey8OaZ7cYJuRqLT2cYU1SFceFYwzbvcDD7B6d1E4qNP16oYXqJ/SDEQ0vjJ0djf
         n77TOLwecbbGWlkh0VOLPy9YZPh5NdOxt5kKlUPbugyF7kdgCB+oZpMEIy5ceX1BNWFB
         j1og0QNijrOy/UMsTWLqjDPz+8Q0DIQloLEjOUQc/hXsOJVqRrNWC3DpSQHNqBJf8BdV
         zL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770700958; x=1771305758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slGvVNRI6DMwxYRFHCioIZD1AV/VPFPU5qKmLSzslyY=;
        b=YJ6SFO4C9JSLijDf3/ZfMdumGV49anF4chAmV0D2VsFSDEP4eqeRRt161QnJHGywAE
         TVLqL7D14TEmeiL/Ze0JEYGwrvBib/UsyHLjNojkiSSsJUTyeoKcc/0d3VudOC7pbxzI
         wi9DjClBSPXKw0XNsS3BFPrpboUTVJIMp4uov4UWpIw2aqFUamO8sZimGp/RTuiB0kNg
         /sxLclpz/JDTXAf24sSQLvSqf05SfUS+mB7IQnUJPy5yONRuD4nkUPTtEuh66Bfew0JN
         LUeUPJOSBrfjAtALpxQtsokX1Q/gVPOqLQyydy2tyPh6UfseClX4uD1RFteiTtgQ/1ai
         8Y9w==
X-Forwarded-Encrypted: i=1; AJvYcCWpx90lcyuTEfJxJard/S9YlyX8XB+jb2Tjn2xgJk2UPQDAM+vcM3B90xvTdnq1furxpF9U86U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfBs+9wwj0ST1yap7VtN5TIWebUYY79QQjik2yxzeDyQRzaZuE
	ZhQGXkTZ6zoOSgdvk6HjHawXgj94Bc9vPZuLzne1iAWR9qDJ8iDisrdE
X-Gm-Gg: AZuq6aJpTTlTsGud+CYklBh7zOmj+QL+N5PsLvE9t3t8T0DJBCdjysn56+qrxlgUK5I
	6x9EPA5deHGOwECoVQJlh/UvI/0/VO9SVY1JeNKl/Koy2AeiK4Fv2CxGdiFYN0pk+Xvq65OX5iX
	xGwnug0G9dkqfMm4lLxpIP5maZwdGscpgZS1syI73j9mKUpT06s+QzJihO2YrtZmBzqRDKB083z
	xQq3Gihso04MB1fgW1YH7YkgLLV5WgXU/0zq8Jis3Ffm969h7TpCEg6OF3c7N8yZ5Oe34iNhMyR
	IlOmEZ9+7vef5gPZjGddPqbWRF5Sl49be1/7G2gOhUa1zkccn9kcqe8GDnYwqsriesGm9YUzIGG
	j5E4Bp9Mke5fE8f1LVMnR3Mmm96MaUMEEAag36tFR4GIpFkfUuU81FEQEJslRrJSDtoZyhDNf6A
	8YMpjV7xy81R+mhDSocAG4W1XVBFVhurgqz9QZwDhkwrozCuz7QS6YlFpU5qKhqtL7tFo+OW1bE
	HNZs+NE28lv
X-Received: by 2002:a17:903:1a0e:b0:2a9:4450:abb7 with SMTP id d9443c01a7336-2a9516fcf6amr158575295ad.39.1770700958109;
        Mon, 09 Feb 2026 21:22:38 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951ca59f4sm122114275ad.43.2026.02.09.21.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:22:37 -0800 (PST)
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
Subject: [PATCH net-next v12 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Tue, 10 Feb 2026 13:22:23 +0800
Message-ID: <20260210052226.3005666-1-a0987203069@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258028-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C509E11713F
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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 133 +++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  25 ++++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  24 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  52 +++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 139 ++++++++++++++++++
 8 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.43.0


