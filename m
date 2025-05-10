Return-Path: <netdev+bounces-189486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762A0AB2580
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 00:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECC64A151E
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B467209F38;
	Sat, 10 May 2025 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgbRyeJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39E1E32D3;
	Sat, 10 May 2025 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914789; cv=none; b=UQbcDmy7CpaeXbmqIoU1FlCrA4S9oLZ/ulQQUlYv7nNT4+ntplSH2fT2G0jhIZ06AAGbALlT4Fn6lD7bJUeFP7u54DZrlyhAiO67D4ef+WZ03/4KrYjX+XqmuTtL9AUAsENOniWEtnXUUvVZoznz0kEDIupTlR7AehT00maThqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914789; c=relaxed/simple;
	bh=zSiB3uTUnnC7fa1t3nkFty3+b4G4nNESd0GfgGgIkjY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dEjcUaX7/irFQDhKFD/FWJ0nftSeUd4hvaumalmfTKOIJj3bz/WyTIxo75cYeOSwBhiVjJKI7Vu0ol4eoWpiFNoIyKMs/1+SKcujonU3Qje4dXJA8UDO2CiRI7Xn7Fs/Qac85mMP3PPI3uu29yYDYOK5ZXanYaUvJ/HiWMvYr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgbRyeJO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so2206403f8f.1;
        Sat, 10 May 2025 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914786; x=1747519586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LG+NNAQvHbKy1P7tkVwWg422mh1Fq8L4q+wYVc5vaI=;
        b=AgbRyeJOatg0ot1bgd56dQjdKvlso0QRA03zIiHjMyO1kMJ26CaU7VZ40sNdSCueXF
         S39UL+xZc560ZHkmqAsqtHXMF9sBbBsDLjulUehNYsMHFqWuyIrgE576RwM5xTBWkkuG
         Qd4pGGVSWCyk7TM9LEnSG0opJObdmIoyQcFWA4EYvd3tndZ/M+PdQhg0x5nbeCIN3tOp
         5R9sbah2HSawlDeJTMQWS8C3rj2MhdnOw+ABvaPH57maS7ufZiHtctdgUvXMYDQQt/FU
         jDT3V9gHOIH19yjsmYkiJv06l2mMK2v0nx2iejaAq3yEx8XGbSUpxvmdVjwcwRORcSCC
         CtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914786; x=1747519586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LG+NNAQvHbKy1P7tkVwWg422mh1Fq8L4q+wYVc5vaI=;
        b=mFQ8j6ASP/eT7r4ejqhz8KVQh9TuonndAKuGXKQzujGK1KZUP3xGuFT8agRVI5aaxe
         yBojtK9gjM3PE50yBq6MSVC9ol/KvNjpng2eT2guf8g0KlqlLNfIT0mfP0aanVK9Qi0I
         8jBIP3cSghuHyA6zDdvqzUbWZerqNkeMxB8ArGJG3xZMF5PBocFuzy9WEXiSWQxgW3Y8
         L+jB52+zykoKS4NDN+/fB2kmH+wjrvSbLcSUH+8jtqx4kyVLAA6URyP9FWV53z8DXzrR
         3mTs1cMPYKLkjQhcbiQCjMgzRebfkjx/T45O2Uo/G3MEpJlBZooYqPGK89TxnRj7Kkba
         vxjg==
X-Forwarded-Encrypted: i=1; AJvYcCWA7L0bE1pUv4s0+FJ7r0gtW+fiLp6rFNg/yd1qnY8+JG5ZFJd3ueSSPqHvbsrrpee6xnGA4afg@vger.kernel.org, AJvYcCWHSCcTURsSAEXT4E+TdFuadry9YNYfwSk6n2ZMDSlvuusPNg4cFKt2eQqFALT/vIC8Hg+pFagb7KQ/2dEG@vger.kernel.org, AJvYcCXHmCStKg77bBxI5LFx/7fUhd9iXHWs3HWX29v1LrgIOCsj0A45+sLL0y4Kfj/6qnmzIl+qTaBvAOCo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3erVWNANaIM33b8QgDXxSxMGziIELMhsSZZycZwtSNTJTfOMr
	+WAEz9ziAarSSQuyE9rx1QzMtZ2sY+FUvE6/cjfdrS9/tF3JiUnWSo03pA==
X-Gm-Gg: ASbGncvuV/6wDK09CTku9mPp1Ep0JeE+Pio5aVRC4EL4LCCeDW1k6Sh1ZoWEYvnJg0e
	fQIH9nQ8p5R3w+6noLuRiBjJWtSoT/3L/rQLWbze85ryR5pnyK+0ZU7hxfBsUege3K+yBtFDCNx
	hYtZwEAymSuFmagTcsZhkkmTw1qtTdVwQQoIsmD3rMLwU9BTU0PGGr8LPWBdOlouD8AmKXOQWed
	s5T9GYR3EiVeyXve85MZHjlHcKzr/hqtXO8fJhRyHV3JjMF2ihAn1paCSBpGoDkeEEd6YNt723i
	FQuNyQeG395XwN+cYO49UcaiuSkv8v4ZDQqjl89c4jrVnMgeUQ6I7ihXRu7x3BI16P0SCCYMboK
	pmFQSM5EB8ztlOBaDi+nJ
X-Google-Smtp-Source: AGHT+IHusFH18QUpBtSO47eI9+3IhGFOgH8q2Q5q1f5i0nNwLKDcjEi0UNKCPpdbocaLgecqZjaBnw==
X-Received: by 2002:a05:6000:2a1:b0:3a0:b9a4:e516 with SMTP id ffacd0b85a97d-3a1f64577fdmr6810108f8f.17.1746914785480;
        Sat, 10 May 2025 15:06:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm7477940f8f.75.2025.05.10.15.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:06:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v8 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Sun, 11 May 2025 00:05:42 +0200
Message-ID: <20250510220556.3352247-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
to setup some configuration and require special handling to sync with
the parity bit. The parity bit is a way the IPC use to follow correct
order of command sent.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x7500
before the firmware is loaded.

The big special thing about this PHY is that it does provide
a generic PHY ID in C45 register that change to the correct one
one the firmware is loaded.

In practice:
- MMD 0x7 ID 0x7500 0x9410 -> FW LOAD -> ID 0x7500 0x9422

To handle this, we operate on .match_phy_device where
we check the PHY ID, if the ID match the generic one,
we load the firmware and we return 0 (PHY driver doesn't
match). Then PHY core will try the next PHY driver in the list
and this time the PHY is correctly filled in and we register
for it.

To help in the matching and not modify part of the PHY device
struct, .match_phy_device is extended to provide also the
current phy_driver is trying to match for. This add the
extra benefits that some other PHY can simplify their
.match_phy_device OP.

Changes v8:
- Move IPC ready condition to dedicated function for poll
  timeout
- Fix typo aeon_ipcs_wait_cmd -> aeon_ipc_wait_cmd
- Merge aeon_ipc_send_msg and aeon_ipc_rcv_msg to
  correctly handle locking
- Fix AEON_MAX_LDES typo
Changes v7:
- Make sure fw_version is NULL terminated
- Better describe logic for .match_phy_device
Changes v6:
- Out of RFC
- Add Reviewed-by tag from Russell
Changes v5:
- Add Reviewed-by tag from Rob
- Fix subject in DT patch
- Fix wrong Suggested-by tag in patch 1
- Rework nxp patch to 80 column
Changes v4:
- Add Reviewed-by tag
- Better handle PHY ID scan in as21xxx
- Also simplify nxp driver and fix .match_phy_device
Changes v3:
- Correct typo intergate->integrate
- Try to reduce to 80 column (where possible... define become
  unreasable if split)
- Rework to new .match_phy_device implementation
- Init active_low_led and fix other minor smatch war
- Drop inline tag (kbot doesn't like it but not reported by checkpatch???)
Changes v2:
- Move to RFC as net-next closed :(
- Add lock for IPC command
- Better check size values from IPC
- Add PHY ID for all supported PHYs
- Drop .get_feature (correct values are exported by standard
  regs)
- Rework LED event to enum
- Update .yaml with changes requested (firmware-name required
  for generic PHY ID)
- Better document C22 in C45
- Document PHY name logic
- Introduce patch to load PHY 2 times

Christian Marangi (6):
  net: phy: pass PHY driver to .match_phy_device OP
  net: phy: bcm87xx: simplify .match_phy_device OP
  net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
  net: phy: introduce genphy_match_phy_device()
  net: phy: Add support for Aeonsemi AS21xxx PHYs
  dt-bindings: net: Document support for Aeonsemi PHYs

 .../bindings/net/aeonsemi,as21xxx.yaml        |  122 ++
 MAINTAINERS                                   |    7 +
 drivers/net/phy/Kconfig                       |   12 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/as21xxx.c                     | 1087 +++++++++++++++++
 drivers/net/phy/bcm87xx.c                     |   14 +-
 drivers/net/phy/icplus.c                      |    6 +-
 drivers/net/phy/marvell10g.c                  |   12 +-
 drivers/net/phy/micrel.c                      |    6 +-
 drivers/net/phy/nxp-c45-tja11xx.c             |   41 +-
 drivers/net/phy/nxp-tja11xx.c                 |    6 +-
 drivers/net/phy/phy_device.c                  |   52 +-
 drivers/net/phy/realtek/realtek_main.c        |   27 +-
 drivers/net/phy/teranetics.c                  |    3 +-
 include/linux/phy.h                           |    6 +-
 15 files changed, 1336 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


