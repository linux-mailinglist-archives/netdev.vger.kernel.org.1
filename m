Return-Path: <netdev+bounces-178570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F923A779F0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779077A0684
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060C202963;
	Tue,  1 Apr 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACaxnbrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74F1FAC50;
	Tue,  1 Apr 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508009; cv=none; b=g7dhOAFaSp+BYExD/j3dnSzjhq7BpCnTwwf9aaksjyO4sIF1K4IA/pRZMz0LAlsBkkD6MLgWR2nnC0ahO0hybKSQmaTS9Yi0fgELuWRF8JyCVYwUbn127PB3NhuA7+KpwpexLjJWoQMtT7WrauxVGwwqjkU/6GF/V1D21JgB3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508009; c=relaxed/simple;
	bh=ceoqctLKCcbnOajnu47CcnpUXs373ivSmAbLGEWNX98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C8e9xBiQqdPIWPQqGMqmspendvdIvPYDr3KqD8RAIBbraCeLS0VXHe0tZl2omuqljm2l1jtNu2aJmN0ES0SVRTrYvskCU/SjgOERF6DCfjimOMucgtEmdQs0RaTiDk/A/8o++0pFHoV1OY1lMOjGDb+pFu7r6OC5iH6vpOF6R8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACaxnbrC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so38690325e9.1;
        Tue, 01 Apr 2025 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743508006; x=1744112806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CCF3/Qv9Ekc9KpUGlNmFhgd8mAsoihUePrT98r2Qqv8=;
        b=ACaxnbrCqfdZl+cc6tYdPBQFLz0rLP5R5c5md4wfFOXl9c592iYq26mxy4Peh+PHbv
         fdSiEiWBJSXMETWxBrHH+HMfQU/zP0PBXP3iY3JfMqQRl1PnroENAGzACnNPsyr/yIMN
         8MSba6no3Hcq+XNMNlELbzwfmtWYI01bNsTNW56aAXt+/2CFvrVddeA96XLVs8qQ1lS1
         6B2x54rJBD21J3dEJO9irz7KnyfEiS5xy+ZZLXbEqnRqXUP2PAw2VJWgoGNTuTdbDOhg
         hl3Ds7zrwsMNfxbibT3PVk8UJt6v/YouZi+Ze9oMsuJv5GTtGCGPpf3pzCMzVyzIV6yw
         lGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508006; x=1744112806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCF3/Qv9Ekc9KpUGlNmFhgd8mAsoihUePrT98r2Qqv8=;
        b=IMkt1MujyXmX9KOk6H3YdLMii6b1ZNdlg/IyLtQRAkH6yYUjJaYbiDgduQI0Fzp2bC
         RfXEK5L3Hbj1pO+mS+tvYSNHk0XOEjqHGIWOgM9FMXQucsoxHfiSzaO7nWQXp7VL2QOk
         3RkGNNymI418t+RKsHRf6gHDnuVm/U0xKYZ9LbpaePH143/ABE3hdw4UDyWdSIHEjiQm
         kzK8b6S9Hj4dSA9rfTy8JCgvr2YoX06w8+xksZ7yVDV5u+quc3xIphvn7JGqT8LFyKzX
         0CdJhYiVkGrn/wQxbqDet4QtB3TSYRZy+QNqX9yWpu0QdUauQND98/leGiRyeFiiW29L
         p7pw==
X-Forwarded-Encrypted: i=1; AJvYcCUDhMqI8xEHTVndIHW33uH/WiFrS2P/BkBxj5pBgIUkRrdUO+PyRIYdjzbWHz07ih+Fp4BOuHfmSo88@vger.kernel.org, AJvYcCUDwVX84seePegmoZudRyNxSEmJqvSQI9+ncj1It2+WMTPi8eA/jHw0Po2EQZCjPrvNOhBHbrtA@vger.kernel.org, AJvYcCXVcb2tusMgFqZ8SnjLGt36nofUYGZlpHPVO1HtOguA4GqOxgXGSkEQLR6E2bZG7Wx7wR0wnzQ/oivwu2eE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zCYnFoY1EZLAWkm/ZFUr3ALLtsVNKH7WHs6BLk/BtT4yLngL
	ZaVR9QcePGRZge7Jkq2xt0np3XN0J2Bh+xpYZuHMyAMxh5LQNQI5
X-Gm-Gg: ASbGncu6eZyb5euHxBZaB39yGV9YbW029wzOrgSicQjJfYLGk+5pyLmPDV5ymxtSVXI
	kkexEEFA8b96dIN6yn5duBqbZsQWcDMsqeVAYDvRS5itvVYwMhLtDazBKbkG8YIgTKusR4KWxbQ
	zpBalDH5YzcY/LTuZ/61UQN4tZgjg5RmjBUIznxvCVqBFH6W48T1MLE6hin84/vFDv13/qSdxLY
	bSt7T43ySYZsWUUSRT9dt6bVUutHG68rFu6WYYryssB269rOfNQ9GYMx0WTVrqHtMwjumwqWiaI
	huQ9d6R1HjN3qtaZZqqDLCrLEAriZo7ljt17q+0y+WITpyAU9vqsu8Lv5DOymaImM1dh/C+J++1
	1OMm5mDzHWUhcrzFLwytsy5wF
X-Google-Smtp-Source: AGHT+IECBdGy0veigc4dKDxdqeIRbDAyoVZxmglOTHF5tsWKDtaGPfK2VbavW3AsceadqMj/Ll0N2Q==
X-Received: by 2002:a05:600c:548c:b0:43d:97ea:2f4 with SMTP id 5b1f17b1804b1-43db61d3924mr119814325e9.12.1743508005651;
        Tue, 01 Apr 2025 04:46:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ead679894sm8148175e9.40.2025.04.01.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:46:45 -0700 (PDT)
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
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v5 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Tue,  1 Apr 2025 13:46:01 +0200
Message-ID: <20250401114611.4063-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/as21xxx.c                     | 1067 +++++++++++++++++
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
 15 files changed, 1316 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


