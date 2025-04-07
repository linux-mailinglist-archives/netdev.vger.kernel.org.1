Return-Path: <netdev+bounces-179924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6FA7EEE0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBB17BC8F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7F21D5AF;
	Mon,  7 Apr 2025 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjMvqXnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211321C163;
	Mon,  7 Apr 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056606; cv=none; b=mVaH6XrHXgKk2MpEkwcSUZWEF28vjx3NZ0VDzwo10KLWQVA0uYuLOF3Z0GwzpOjdw6oPwWik6PCA48OBy1OIFAVZ/hehoJAS6Wui4PP9FqjOa5UFvTds7uvjI93I3A6GTmw7r1M8qMG6BjTbnDUf0BglgBn9RpMhXJjJphxf5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056606; c=relaxed/simple;
	bh=ERy062MaXYEMpOq9pVBPU0EENIPtNdOr5VwKYRjtcno=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LRTJfOyVBi1GfYU/+pVsB7FxTL3KredsnIolK51/QI+gkm9gY8cTJcJBUVqwoSrGrQWK/diDN4E/gOShpqXjlG7Eq22SQp+UDyKAFHttygAhHfZ4miGvvCVbjHhamzqwB6iHcQt9eZ/LQgjhSPRxaJi/lhJS0ws04i0eoy2hTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjMvqXnm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso32445115e9.1;
        Mon, 07 Apr 2025 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744056603; x=1744661403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss2dcIp8/XGhFoZ6d9EjxaVbxySxC4PAeVk+6InKMq8=;
        b=VjMvqXnm3CUP27ahFqsboImJxr4hZeluY/NIPT34zXrQwDi+GLedgMANkGa9UB6yrM
         R8YxDA7EnyW8AH6m1coNctDKz6Gr0YyU2ybgTRTi3QYw6gITQkm+/Dwk5M2AwKQCM6yu
         r6YKg+rX09F801mJRSIOakOk8qxUYTgH0Eb/yPwIHA2nC2Gquir2gZCIWayStrLEu+3d
         vztg55Kq0a8pejemkJn3PqDd3oQnM3rbtq/jgWl0jva4YpgDjF0GAqEmG2kTLPmqD2Am
         BIkAHNWe18tNbmYBrjDH0FS+ZhTiTqoc11nITr1MMu/yOGw6Dycl1UAQdpOqfdruSTAv
         JvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056603; x=1744661403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss2dcIp8/XGhFoZ6d9EjxaVbxySxC4PAeVk+6InKMq8=;
        b=kRTna10jLrxiAA0AnjBZtPBaVcwCBP3ze4GueFpJHVRRqSkN0VgiyMWApgxzR58dd3
         utTSuTtDPeGYu+VKKebhN9prouKy2EKwo8uaC+bh8Yf8Hi1/VxPcp1mkV+26GlI8KtgF
         Vcf0bdJz28b2XLGrAVex+/PhtNMNofk+UTasqma3310eiPq3MP64KazpD2CkIxafM7l3
         usz5dH4Nl6iTc2Cb1lpLju7Nud2WjU3dZcjATyv/CI7f4buXeCkkcoxeyxT49tXYmh9e
         kRv8cmrp3aWcY4yV8pck3GutqUgEeMqWK2Hu1at0wmtF7mGVFor5LIaMnv+kUgwFU0aY
         9UDA==
X-Forwarded-Encrypted: i=1; AJvYcCU/WfbxE0460NXmpLkfR+bDbgrIfLqKIgUhPucLWePJHk55XTlK834AsWAPItBWQHjXaSdgH5OQjexciVNB@vger.kernel.org, AJvYcCW6w0nFedvfgoojZioHFBcWZcFItl2lsqm9OXRjD3OWLWxLkq1qDzPoeFrnBUZcSwjvYdzE8Bp4@vger.kernel.org, AJvYcCXnzyHNSXz8NDzc9QFsrniT3sEnU33HpfCMPIhDcQ4Gp0zhvV+Mib/Szu8PTsSqUEJCZtaFG7oDTNr0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aeu4OmbK7ct7fOPWmsc6fLWH+FJRTekaK3N0GxCnSfA08OuI
	K754cyNWkCJBpiRnI938UojFW5YGjHQgrc3zB6Qd9VZhRMSSPN4D
X-Gm-Gg: ASbGncu5UrNtVFHupc+IMUVNbel/SofbJ1IM1MsJEUw4yEpdsa0U01ngcg0seX1PsZb
	6i4p0AU5n7rPWbIYYJ3iUGrouwQqAxs0Np64RVqyHrtKHk8wZqBvn7PLhpJvzJeULTFQHW9S2lm
	xLFkNff89u+fSNZULYhSd6cZaH7SYFs29qobjeXdGFz0oKGYl8TN98uCFsroh3M/paVWsv7x3EV
	ePX3lFZrKbXL2b5e1Gng2rEZM1DyOp31Jfl9ZytyxbNEtMeotXHgp3IBVO+LhuBy7M3JoBKTVf+
	iojAMMPdDwp73LJKc5PVsZOJ55aAdUejFjIoJHdSqLt5eN9q0itDvNWYDlTrAVlWeq4M1R4FGqY
	PWef0XCW5i+euDw==
X-Google-Smtp-Source: AGHT+IF8ef4R6qNnvbrNmC7Ukp30vFGX0jbs8UY3uBD+rEeaG56tyPhSpCKhv6fQ2giSj7BZwUHsBA==
X-Received: by 2002:a05:600c:470d:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-43ecf85f23bmr98068065e9.11.1744056602684;
        Mon, 07 Apr 2025 13:10:02 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec34be2e6sm139605995e9.18.2025.04.07.13.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 13:10:02 -0700 (PDT)
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
Subject: [net-next PATCH v6 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Mon,  7 Apr 2025 22:09:20 +0200
Message-ID: <20250407200933.27811-1-ansuelsmth@gmail.com>
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


