Return-Path: <netdev+bounces-268027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMOWAyCbt2knTgEAu9opvQ
	(envelope-from <netdev+bounces-268027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 06:54:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C9A294E00
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 06:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25CF3006B31
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 05:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0172BCF68;
	Mon, 16 Mar 2026 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftrns3cR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2BF235063
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773640477; cv=none; b=QTj9sVRt2QegbBG6k9vzYns+BThol7dP2iW3P4FfK1MeD7glu6CpYs++I9FgKZuv2nbhY5k8t1fBNIT9CaCa+93cMqaRt3s1aOI8wfxZyLHaj+a2w9mBFXMHdPoEAFuPnh2F+BqIt/9gj3MfErpZIrgyJU08wQ8f9aAw2R0LzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773640477; c=relaxed/simple;
	bh=BQub5CtrtBLXTBYD51qXYVLkH6mMyIwqiC3kBL5acuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiMTgOM3s26+HCXW4+1iYaHlproAo5ZEExgYBZHAxwy4lTOx/8GwK+9ShTyTnraN4t49YGdOu5Nha8inCODCqNh5Go1o8j0hBK2Fq0VNm93wqkhm2kcHlLu+XmExhPi57CvHDnqB15KyYaG8ssrBJ5XJEgjLl8k7QGP/jZBrHAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftrns3cR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35ba2ae4df3so247575a91.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773640475; x=1774245275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdlLnxfYyQ6gERT5vAzpg0NqVjL+fMxqTNrrUUF0iL4=;
        b=ftrns3cRMliwFhldjx/NSWjUBkSyYAwBPC+MGJ3kd438kiZJoSCxTPNE/MQ0CEtdWl
         iRanhf6Ic6fithiw94T5rPFKM1xMfhNviyHyvLSw9u5Ib5YSlXNi3d5V6Kwj9y4r/IvH
         pAulM5v0RKzHQ52KC4eRjOUKu4l72cDz2BmkRCFwIf8rDUHPpqERB2ykU4zBuy676Qme
         D8QVYn/e20YHy42brW8ZXoreLYIJ8OQO/dTZu/EiiWuBL5rB3ZxlZCP6z/QQLR6w6Q/U
         riT2Oh68yttd2gmG52QkpUxviJb0BbHTaVtIUFdQJJYW2vsx4uRwuv0tNAbXpJ0Ol4JI
         79RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773640475; x=1774245275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdlLnxfYyQ6gERT5vAzpg0NqVjL+fMxqTNrrUUF0iL4=;
        b=r2EkvtqomNYnljr1wDqhCtT2db9/WbgiFM00Hl1sDB1WQLtRlUPwiMgDSQgdA0ShXX
         Pl/TvqzgFKw3TJ4vTuebPZ9QUhEtN76w5lUryHTKPEaYzG/iJRTYQqdTlZIMFqBTn5N9
         i7SFn34EhwigMdOGOlIQj1BD9O3aytuSrqLkr6bbr8Rz3diYA5RKYrVaLDq7Algijk05
         rRRA7mRNoX7TiRHEZTev/+E7dLoz9EnumlDdfJqlgGE+97gpY3vO4FqHErVeEr3Mi3nL
         iekfFO3LY/H+RSl915XFntkuvA9cgLdEReevLCIJub2hmA6HB81vF4Yv6hwtr2kCB9zH
         4p5g==
X-Forwarded-Encrypted: i=1; AJvYcCUbQ1hInOl4I71QisC2AHiCabOJcUsqEYZ2HISIfXlM3bYj1DfoSj5QXf04a7CL9z4xrhj+fRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsNhqdiiB8eVycefTe8/KEtBPQJfCYY0CV/DYz6yjYRwaBFY7
	nOhVvrCsIZMsezY8uKbdQKtwtkiaKfzy8Xeep1V6dJtTszb9lL8fTv+Q
X-Gm-Gg: ATEYQzzo3aNQDyg68RYAtqu43j2g2JaxUQfOEE4E7O9hUxImm6stIBoqtJ/RgzM4p5a
	Fjf5w9BfJHYd6c6NBrR8hzmSVo0MEx/wAZcklTr9+o4J9TW/kX7NHV+87RAMO5Kbfo4l7S9pP4r
	t94VmRG+j7gLZwx+RaQzPj7Jj0u29QM8xM6JlIOtR8A4hZwhHs4PYFssxY5nZJutByHcUdOAMPm
	jACfx0RAi76qtoQcDfaz+833Pz0AfN4bwTY9kjSIBeuR/FO+SPWCpL1NFYrpxUXr6ibVPJDOa/g
	qIuQrYNQf/t2JuY6xKSIuZ0ikxfSxKItZJmwEu/x9b1eq+nuI3L8LirIgOZok9Y23d/eWqkyKqg
	+lEMpC0UjhNY16P6l92JzfOnncWe/yD/IJvUeyZFVEb197gnw+M8p5/vgrfg2Tew7k2yBg498aW
	EcN8rq2+CpJ0t7W/8QhnZNkBA3mFTe/L5Q8/sou6aJOeuHFD8/mpIH3fzDho//Hzy1GVUGAdBGy
	5Y+pw9iohVs
X-Received: by 2002:a17:90a:d88b:b0:359:fd9a:c513 with SMTP id 98e67ed59e1d1-35a220a8903mr10935535a91.24.1773640475194;
        Sun, 15 Mar 2026 22:54:35 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9db7dfe6sm2166285a91.8.2026.03.15.22.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 22:54:34 -0700 (PDT)
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
Subject: [PATCH net-next v14 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Mon, 16 Mar 2026 13:54:24 +0800
Message-ID: <20260316055427.1310569-1-a0987203069@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268027-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 65C9A294E00
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


