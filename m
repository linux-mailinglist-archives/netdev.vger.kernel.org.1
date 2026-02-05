Return-Path: <netdev+bounces-256899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GV3Lwv1g2kwwQMAu9opvQ
	(envelope-from <netdev+bounces-256899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:40:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A80EDB89
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 02:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F95E300461C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001E299A82;
	Thu,  5 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO48R8tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70334299937
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255613; cv=none; b=q9wLfOFrjZBdYHas6M9oEo32Yo1KaS9qnbaIh2rExvj5RExgLAAa85/WFc4gO30nzxOTAOyM1QZl8T3SqKuEWxIoW8AMOY31C5+x7oWm6uNxyJjT8gPnBKXnRCuZXe4YICICbSSpwyt0tLI72jdqOe8hDSmcp2VNylhyw4m3GXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255613; c=relaxed/simple;
	bh=Lex1mU1UJ+ZNbaSm2gg+0dx71BwPDukXY8AEY6eqwDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILp4iPG5adJYmAWBmJrE5DzRcmk5SLTyfTnkXWEYk2sttu1MHEpSrmY8Kdk7NQFb4LvQopdaV5/kIY/Vt8sJmkt+xHnHUCKNLeEI8ypa/kErrOj6rO1sxOwayLI+SVLcxTVW2VoLxKgBnFTAcbmu69oGrZl56Pc+Y7eckH/ahyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO48R8tk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352e2156450so134753a91.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 17:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770255613; x=1770860413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OiYqbF7y0kWC3l5ZGq7AIg+QHWt4yVe6CopFDBbu9A=;
        b=iO48R8tk4HbepNlaaC3BG3fQNwP4IXl58dwiFNwBFZv+gNcOVKXGBekzDFate27BwL
         ga5AtU9+DmSEJoJoIN7oVZyZPRmJubiFZ2RM6zPOZ3NlIE6Cj/ohKQSeMyeLG0UuwMsp
         oLhl9HLsMLOsvIpdsKUDvZOQFPLKJnNt6Oi7s5/88GFmwbk2mklfu3akpuveD6b5Nz90
         bb0jQS3yUgpv1KSP83MTfNR34CR39JUIdJI9Zn1Z4QwgTxYqVPULhLoGSrpXE0hcYOe6
         M7qMGq6QMIm31D1Qu70/kfdnr4Ehr39j/JIXDCT1N7lbPrjxRQWO+Fw6DieposNxIGOb
         c+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770255613; x=1770860413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OiYqbF7y0kWC3l5ZGq7AIg+QHWt4yVe6CopFDBbu9A=;
        b=H1QK2n/bBfJBKGtdYDBDWcgX5wbjD468ymlQWs+Z55z5oJRj49NTJOKPyn98rLhUNd
         b33/5aWTH2X18wM+ugfqxoi9t9pigwhIKXQe54lEUq2Zc8BvBkEW5Aq+wOub0u5Il+DO
         mYKiPZx5Hy4MO32rSv7JYgC/KnPXyYk2d1zbFHTDNOIB3+k+6B6jII16h0qDKBMZipi6
         6iqrNKC7JJPJdUd3v7hqvn330uGj0PO4CxQP1NKf0ygThaveIcUcUkkuuV79XU5ZEpCy
         WRpiv9BpPvpOa59T2GuWrP90MB+/gsoHly6UA/1Zp0v8ySdhV8Y8yeI03Bf/L4/ndg3d
         yV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVisn+NnscHF+t590ye8/DXM3DgRzUbHzG7YgZGvEHl5Cm8FoTmgcjMWPnEZUrh/54mFKEssYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9lz/qXEP7uF+Mw+eyY1tVfzX7vAN6kuCcOQcZMCiyHbAhsBr
	q3AcncwjrftwZ5HDkV1r8Tzt3s1OIfdxtA7nOPtL9wltJCbTBbXiHdIZ
X-Gm-Gg: AZuq6aKQ7KJVuBtXsB/3e03S2XxHOWhyL2W4vDaxEAn0AtD/Nf8MOYK1miMz4S62Kp9
	bgQt1sOOs+lvu2TGEgevwNyjJNSPdP2CzWHGkzLf/k8DpurzcNWbQN15xZDIJ+q5BPqIUTjRYMw
	jyOUquXGovr7/kG+1se5QiWES7wM4N0cQBmvrCo73jJH0SQ+z5dM6zowwq2Yz7t0AmIiN//c02N
	kXEC9kOlJ1X8KQrf/GATLW+CXxVA0Zv4zU+m7WyC30SHISxWye+6D2BapNKxsKBTdkFwjSO9tkZ
	QtHd3Df3TYOR07+loVawzK8m+AKwwhdC90pisRpwipRGmQR1BtKD+c1uihdgxhPWf0X+iybSm/y
	ho6P93859KUcC5NYQ4d4SZaPUjM7Lp81FDcACbOPGbxlvkj1R3YXNgtQvYfhqkW4464l4w5zXlC
	qNobqh0T/vJuXk9qIEwvMtYTlBWdQnfI817lc0GxXlGKmbylrSdalwNwjbZnPDHft0NXEaF6ce
X-Received: by 2002:a17:90b:3e48:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-3548712209fmr4771036a91.15.1770255612635;
        Wed, 04 Feb 2026 17:40:12 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c487a7bsm673571a91.16.2026.02.04.17.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 17:40:12 -0800 (PST)
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
Subject: [PATCH net-next v11 0/3] Add support for Nuvoton MA35D1 GMAC
Date: Thu,  5 Feb 2026 09:40:02 +0800
Message-ID: <20260205014006.735408-1-a0987203069@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256899-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6A80EDB89
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

 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 126 +++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  25 +++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  24 +++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  44 +++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-nuvoton.c   | 173 ++++++++++++++++++
 8 files changed, 406 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

-- 
2.43.0


