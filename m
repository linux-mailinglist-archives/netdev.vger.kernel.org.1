Return-Path: <netdev+bounces-177870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28520A7270A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 00:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A318175432
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3EA1C84C5;
	Wed, 26 Mar 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iazabXPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3EF12B94;
	Wed, 26 Mar 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743032148; cv=none; b=mVqBMul1tIzTUO/XJ3PVWzI7tirR53C9SF82+W2LQ0PIvfJIJVdAbEydzqKF/O1UtA7vmqW+HqtsNa/UbsF9nzwifU2rK8HNe/gKziRe1/nv5GODVzuSJINGoMH+s/XycQPKmkHebptax0zQ/XhUA5JL20MaHMESUyi1pXa3qw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743032148; c=relaxed/simple;
	bh=c3Tt3+vA8Yxr0G/PExjzWPiNolYn45ZBU8sWBesmmJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Qz3V4dtWJcZxalyjqe7Hkfvf0EqFK3+Oqmiay1+KkpHy/Ib5igieiSLbg7k3BXR4tgHfUVPDr/8B3sP8JYJY4bv9t285AHgSCoz+fgNUWXFZvrk/U4VQ76iFh7mjgHxvTh1LbCpQM703m1Ry518TlTMJxQWMQ6GGL58qUJVe+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iazabXPb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-399676b7c41so160292f8f.3;
        Wed, 26 Mar 2025 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743032145; x=1743636945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=we/QPj4/3MU8rZEsP3ihZT+uv62gYAHG2SRF5+Uz4Ok=;
        b=iazabXPbdC0pCcMgs+waJxgApdRDtYLs3Gje/plFMPWxCu+HI8mwe0xlbwecS/8Vy2
         ywEkKML1GhlzdFbzP106OvlG3EafCXoGw38PBm8WwrG1SK3wKLwhqK3KPeN4uVu0TkS+
         mmwz5hwgazp/n/9uijrJNIEr7f7Ar0AXQiuUmxXogZWjVJ2xlXbSaMH1+nWNivhv3Djc
         tozuK6nVS6kt8oufuDUgeNRqbqnBb1Xw2L5b8VYdjvCPOvyUqtv+rBIaL5c9fDXjWVrw
         ci1t7rUD7z5MLQ0UCgJoZIuKA06cBEXRnQBbIlj0PX1pQ1XkU7DVcCigSDLqtUmiRjjG
         Vwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743032145; x=1743636945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we/QPj4/3MU8rZEsP3ihZT+uv62gYAHG2SRF5+Uz4Ok=;
        b=ojUeEKy1vRMIU6ax3DDXS9EWKs3JON6cWd0yc5/9d2ckQRdLXfsFRGWFAQaXqo+CLJ
         v7iB39wNFQHEsOA+9ZwiqoaqiOOeCSrZe7adTOhQcU52INn0vX06AScfCZcQnFhi/hWb
         p+6TI2loidUoUuKOZ0bGAlrJ2oCcdqHQ8T65MN31b+0ZX/rPzKq1h3suA504qj3jRydA
         BGhFo3344djZ3OkqiP1Lf/F7IDGQXwD2vt/1c4FlUz0VCXTdT6NKiOroBH/TNukH5veo
         adPJnR2Cq8poQ4lolyIuFA0KJcZrQjwPI9zImKHaB0krfoeZKvlgmRJBsJWSHOXTLbnO
         VfUw==
X-Forwarded-Encrypted: i=1; AJvYcCUNirrn/B94S5QdjHAIuSwGtRo+R36HtQMjbE3YdSRSXxm61c5RYw6WCmzhYEkqA0A6+3xfp9eZ@vger.kernel.org, AJvYcCXWFkz8rqUxmecjlyN+97wsqbiRA5FDM4injkuf4MEfzVYI9MALpIFuyZhFrxrAunuVEaBW7pKu0efBUfOC@vger.kernel.org, AJvYcCXxieCK39NQvkaunNkHrorLYnjlDeWrYlS5RjcC0jTbfxtawxufi02y4dt4uzz03xKMMbaAVYZ4EmsV@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRGeCyky76EkhKpiMwjoGpHgsTgiF6YFyRvPjNiUL6J9y7brd
	6Ot6UVYlsGJ41vR5k0ROQwN2TAldkCW1YRKmQj3LQ7t4KzPsX+XO
X-Gm-Gg: ASbGncvzW6DnrRg8UKmebpqC3Ct96HnjyoLTAHXwJa41k6q8w9Sq0tjpQwpBC7rB/5P
	36+nxxSTnWkihW5LHOJOD/zOcX/3kmQe+0wZgHUgR7h2t0A6fNeZ94edh/TZyY7HV/y6dnr84ki
	F3bLHWK9MNCTMxKODWWvfLrEHAKXVHT2IcpQOmJoQX/6nq2/xlG4gcLrUJStcJpmLiXNFNbmoEk
	ZHIPRNo5mjcBd356JzJChJRZ48HVwjCjNHoUayZlaiHIY2xcdUvNQiGqCVSHaexMQceC2U8pbo5
	Id5W0fUznrRgp/4/qmFxPh8/T/gLCZSTvuNV6zEN3HqU0qyP/Rj2KXm2MVizJm8mYu0M5P7HCv1
	Qb+DF50E0B1Rzww==
X-Google-Smtp-Source: AGHT+IHOgo0Z65SXbJ5BUuNgAMcHgJl03EH5kSMASa4VaMtQeNOZlg1TIjgiJT44LMqx3TjJJMHinA==
X-Received: by 2002:a05:6000:18a4:b0:390:fd7c:98be with SMTP id ffacd0b85a97d-39ad174bf95mr1034790f8f.19.1743032145059;
        Wed, 26 Mar 2025 16:35:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f99579bsm18390328f8f.19.2025.03.26.16.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 16:35:44 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v3 0/4] net: phy: Add support for new Aeonsemi PHYs
Date: Thu, 27 Mar 2025 00:35:00 +0100
Message-ID: <20250326233512.17153-1-ansuelsmth@gmail.com>
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

Changes v3:
- Correct typo intergate->intergate
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

Christian Marangi (4):
  net: phy: pass PHY driver to .match_phy_device OP
  net: phy: bcm87xx: simplify .match_phy_device OP
  net: phy: Add support for Aeonsemi AS21xxx PHYs
  dt-bindings: net: Document support for Aeonsemi PHYs

 .../bindings/net/aeonsemi,as21xxx.yaml        |  122 ++
 MAINTAINERS                                   |    7 +
 drivers/net/phy/Kconfig                       |   12 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/as21xxx.c                     | 1048 +++++++++++++++++
 drivers/net/phy/bcm87xx.c                     |   14 +-
 drivers/net/phy/icplus.c                      |    6 +-
 drivers/net/phy/marvell10g.c                  |   12 +-
 drivers/net/phy/micrel.c                      |    6 +-
 drivers/net/phy/nxp-tja11xx.c                 |    6 +-
 drivers/net/phy/phy_device.c                  |    2 +-
 drivers/net/phy/realtek/realtek_main.c        |   27 +-
 drivers/net/phy/teranetics.c                  |    3 +-
 include/linux/phy.h                           |    3 +-
 14 files changed, 1238 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


