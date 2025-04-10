Return-Path: <netdev+bounces-181166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F1FA83F7D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790634A0883
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012FF2686AB;
	Thu, 10 Apr 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdPDMXmC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23189202F71;
	Thu, 10 Apr 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278921; cv=none; b=MjRFjjBFalE0SQIBRPGqnXeagk08w20IM4ayGVNRCcFLadAaokW9eIMBj65/qkb2H34SCC21Ikg9ENPXYjZOZbHFuQOASi9/LChdl1APAK0CS/qEBZ0qNht7uYyKwznO5VU5FU40EjVNv0bOFjPeYrCq4y6chAQZ/d1xFlrMtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278921; c=relaxed/simple;
	bh=/orFv0AtTHLY5ElQLQO2B8ifFr0ZQhJFVLRGysobIKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OGAeZABl6VjtHRoC02kLJsbiDmRNaWkbjQKjNIn131Ih2ZDg2pJtScuRdFRtLfzzc0DjrED/gInoTzcDphzTu2Qh7q/FzgmNyD2nb37/ugcYWnF184BLs6kX4SYUtIBF7ZS/vi+3sjVlbtxkprZ9J3GPWGqjr9TV7Z1F5Bu8tcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdPDMXmC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so6307195e9.0;
        Thu, 10 Apr 2025 02:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744278918; x=1744883718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ryLqYVQRXhUxLUXXF1P7mjvbMh3YZ6sx7CjC9Lhfcx8=;
        b=UdPDMXmCu7J+QtYOlNScjPfISDKCs0pMaqg3Gri2hF5IG/+4U/TpzCEpvU67+2dIpI
         H969ckxFxNj+RfU8bLhX8RHqvpBM9GnhjoB4mmrtrYiM7ak57bfUx+Pn97tpUGN2I0Am
         AUi8LKNorgi/rxQkoJvJHxgTqxjgNDWnngbENGxoH/li4Qu2ah7OUl/gEc/YmCFmS2ix
         T1ucTk0vHruibQS/KL3FFKP3ZdPDcTDqHm+c4dPQBcAUdDXFJ6ivFKDb6L1SmOeUKolr
         pV1OAV4LodZ7YB39BKB5E5mydBA2RyojO8OisJ686rwijoMyPbLtV5Z6qMkAL4u4uHSb
         qhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744278918; x=1744883718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryLqYVQRXhUxLUXXF1P7mjvbMh3YZ6sx7CjC9Lhfcx8=;
        b=iWWi/5q07CtHzfL6pjNHKEqjYGIZm30SXm7JYvs7qnpGD3Eyk5c9HYEq+XV6csoo6T
         7uFP5n61eRr1X434bb0Wv5BSzXFlt0BQHCghkmZ6RGaRyzXuerjQjMCXXqd7n5KyhWdX
         F9r/9G/+DFKQdTHLFZTZumVOEL4/wGSW0AVWhh23BpecqXUfQrkgWtmtPK+q4CR9iWZH
         xFiGvvPTd0LueDRPAH7ifibtFTIAPreZIoCTLSrVaYxqohiML/AauCZELc4lxnmVHZJU
         4ZPbn+fV4E/XI2DKBDvxA0rP/opc3qj05hSDKg970U2w4XiGLiboEK2ShVXNx8l7qTs+
         0atw==
X-Forwarded-Encrypted: i=1; AJvYcCVbeGjPuqDJSMSjcPtaf0WQRhJgIS04DbHFhG7Hr+GMAtKHvc6jF2I7iBjhi5DtFzXoLvXvSgfy@vger.kernel.org, AJvYcCVz/oGTrF1YGnJAVJiy8+mY5xP1k3GT1k0r+lkq5Da96+ZhnYQhYRtW2inym9I9HiN4G8dJH+DY9jFu@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGVcCXKNI/K1b3EVZIOy7+aNAPJQZxs66Zhs04oNkfqybBko5
	SNWDkQDPm7Tp6ua5GqT/iLt3iLHs0XI6BwpKSL0Dl+6GoCpAAwN4
X-Gm-Gg: ASbGnctnu3qB1qD0ax4097DRT6S/9yMI61/qSPi0ovAz1aqq1YgAZzX1hhiPpewUvq2
	xCgd7RAe22SUwOqyd+elq3o93p4zfZXdzBvTDG1nyfu18eBWaFPHbWCPG9App8PZv2aLubD0W8d
	utUUG26t06PHjiUjWDyH8yEkF6gF20oP0Bvq8WAA1pgZVr4f95rLFU0EmjB7O7VqQN7wkwd4Ti8
	1FBwzwyp8ugz5ciCjJ7ZOLBGH5KYNFjF0vTnn9Mx78Volq6btu6HNar8SqGJ58JuWRzz4vec/q3
	G5ntLLmD+a0vVgMn9JkkaJpKSfkoKBJgu57/J5MgtD4muwwUf/rVSSYs8yumiMxcJn1huA91b3r
	/2OV2dPv0pg==
X-Google-Smtp-Source: AGHT+IFuW8aDgUFFbxNmVyV7OtI/+bEW/yfspJiL9uGNZh8woACFhqAcrsoteXlUhCOPi//w6xDfsA==
X-Received: by 2002:a05:600c:1e0c:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43f2d7cea33mr23224105e9.18.1744278917348;
        Thu, 10 Apr 2025 02:55:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f233a2f71sm45404425e9.15.2025.04.10.02.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:55:16 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.or
Subject: [net-next PATCH v7 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Thu, 10 Apr 2025 11:53:30 +0200
Message-ID: <20250410095443.30848-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/as21xxx.c                     | 1076 +++++++++++++++++
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
 15 files changed, 1325 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


