Return-Path: <netdev+bounces-178031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DCA7410B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E50E1894905
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C31DED7B;
	Thu, 27 Mar 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCY3hxiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898D125B2;
	Thu, 27 Mar 2025 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115564; cv=none; b=jMlCjwt3ADQlc0rZrIiMUUlGprR0VUgZuUQ/rr+dbD3uq1gIbB93Z3vUYjXfC4EDLADIzn95oX92lEigGkicGg6k6BlsiRfGxMNxHoXhIX1obY05mIxumESxCONnzxgOu/pskXmE/37I+2bqERvSi3+50kiq4i0bCXfGbGc3RvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115564; c=relaxed/simple;
	bh=KUqEm5MnoAUzKHmKnlVh1eJvguqmc7pQUCkCF/Bg8gQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=chQk4cWuaI1dgr3hUpn66IoQgt96NMotxxc9dgvAECovd7sMJaF3ekFXSwkvN38rv1Emrp52R+cEQuKPuIoqvmhy8xxbeOojZ4VF0Do8/YOpUKLy3Swv6fMPjEOM3l97t0vTdekJtoeRZKbh5dkoqq87OBYw1ZyMRdSIN4e5Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCY3hxiD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac56756f6so1155932f8f.2;
        Thu, 27 Mar 2025 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743115560; x=1743720360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iadl/X2QlPSCcfkOvJqcMDrid10XKLM+kB+mM4Kp2q0=;
        b=QCY3hxiDqJDzPS17Q+tK8KX7TzUZDYV1b3ladZNcaTsiDnpzY9oJIILWBUvgX0h9ZD
         au6N9jQ/zj1mtfc8zhnKv03Oq+yWcc6ELo0WllU2LYNNUtGGX5SB48QHsxNIN1GT7f5Z
         7BNJdk7l7EgoxeMaF1a3yM3++WHP2kMYYUYLGjKba/WPC5hRQzU5h2PGksHs9fgm8RKc
         dmdl+4lnZXc92kYx38V/uQok3aYH9iWC19Qo8alV1g9511tGWjgk/BSRcNd+DFWcgQBQ
         /dVVVq3dpSyKoH0Tmx/XvOn0XyAbHony60WVYnu9McfjpsgiYvjYfdn9js24F2V8iB+C
         VGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115560; x=1743720360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iadl/X2QlPSCcfkOvJqcMDrid10XKLM+kB+mM4Kp2q0=;
        b=QkeYMwV6jMSqUAHRM803ZzOPkPBTNitndcMmva0EzLhkvxZ9ltGMraj534PtJuD7Ka
         aZY0f7CJrhA6q3y4fc45O83iw2jxRc1Jw8Nq5aIRPn2fRkpQpARhY6ogVwUrcuboNvHt
         DJADbq2z+VM64Vp0VuiGSqHJoopo13QWdqpGTXpGmYw484vM5TrGTuCGc/731Y7zTtg5
         JwH9cZ3sb0V4JE1z0GYPpRS3L+QBWcY66AZIgBDptn1pDrE+p0lUdABeFR0lIAciDgY8
         97cyYrgvcH9BdDqWYX0ue/XWeTAVIelbBq+0hhcq9XcPgyBBNCUhcNaWgMr8vz+ZgRBo
         EvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX7/QIH4KkDtkqMfBhEAFGFKwCDOAPtlspgXuQXU8DGn13FNUdMNPo8BQvjoRf0qgBYy/r2KQY@vger.kernel.org, AJvYcCWgRDk1oSl5tlwXZN/EYuTymUFEAlEApHcN5MzMhtPQ2UO5S6n7Ojcu7W6/fDb0cqI0ZUo/jPgJwJhJ@vger.kernel.org, AJvYcCWj0fNo1l6sUlR6MbfbH1k6GPY7e65jk1PZae5DGEeFlC55LhCut8F32ibB6/q/9ZLReDtfBdhrU7hd119u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Tai6x7dF0mGIaggm3TTS3St7ZJ+3Nk+oGA8ZJzWCx5dsvASr
	r0fNfTpeJj5ESuxR9l55CwKkatyQAmDP11zR8zdMsKSbar5BMsfE
X-Gm-Gg: ASbGncuw4fyYS4IxrIx3GBUN7wMwCjmVhXV72+XTP8pNW/JCkf40KzzVUlhfaAlfFiZ
	5vLd+N1C2uRF/JiAWnuzcvFvt/1LpyHTte3JeYfWmANtYOeM9As82t6McXpxhV55PixrU6Epc4X
	NZtA/ehVONmYM3C33J2cYztqspMCemGkrJITFLt5bFKM1xpctgbS5NtpzCeywuQEyab3WmaYI92
	XCKDbGGBON1s66kF/orSyOaHFMYUcPbbpG0y3EU5JMDKI2UB1adolvsSAjOFHRrvc3kzqaLENFi
	iyrD1EUvtcOF7geheaBBqr5RrSR3h5vb7kqruveFDmESGGhdBBudIt+LaDHKfUEX/b/Nu9HE+Wq
	GvOkDqBlvlYNv/pa+WbcNsdd0
X-Google-Smtp-Source: AGHT+IHG6b2pXNoI79W9j+T6uUy15MIOUaloxrlYtXSIowcduSIPRTMiiVzMI/VB6P4xxuOiUrbFzQ==
X-Received: by 2002:a5d:5989:0:b0:391:47d8:de23 with SMTP id ffacd0b85a97d-39ad175bcacmr5363249f8f.31.1743115560231;
        Thu, 27 Mar 2025 15:46:00 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c0b6588dbsm789476f8f.2.2025.03.27.15.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:45:59 -0700 (PDT)
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
Subject: [net-next RFC PATCH v4 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Thu, 27 Mar 2025 23:45:11 +0100
Message-ID: <20250327224529.814-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/nxp-c45-tja11xx.c             |   35 +-
 drivers/net/phy/nxp-tja11xx.c                 |    6 +-
 drivers/net/phy/phy_device.c                  |   52 +-
 drivers/net/phy/realtek/realtek_main.c        |   27 +-
 drivers/net/phy/teranetics.c                  |    3 +-
 include/linux/phy.h                           |    6 +-
 15 files changed, 1310 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


