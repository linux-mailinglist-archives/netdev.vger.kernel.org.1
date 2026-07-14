Return-Path: <netdev+bounces-307559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +YPDE3+KVmqN8gAAu9opvQ
	(envelope-from <netdev+bounces-307559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874B758211
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VG6Xj81F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307559-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C703300D46E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8938418A56;
	Tue, 14 Jul 2026 19:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0EA418A4E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:13:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056435; cv=none; b=gnDzgPpkC7mhrT/fmT8jnKfUwKHttSH102BtR86D/li4ugx0fxef/M30r9Fu2FCZQGOAlIpYZ0Bvun04Rc2h85TRJneDbWkqi+IzXC2qGU7Yv9FSOOIU9LAr/3soY2VSTCcMseilVtSIRg94atmvCWsmPN4AUv0jml8ruL+u2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056435; c=relaxed/simple;
	bh=OnzeXub9pWgszEs+eJAfiDhXWiRA2b94Y2FtZMmT++0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRlYFVI95SUnC2LXjYKkTKdodJjfSofRbNPnbl0erqYcbXepXsdTtxU5tXvYFsHYNYNlXEFWtDhYJdo2MejN2cdIYNCr4gB/BwCx5JAUDd+tlysJMb5CGXUq//YFG1MLG+njJ8ynqNMhRklaPkCzlEr6HbcravEnSwC8/VkHrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VG6Xj81F; arc=none smtp.client-ip=74.125.227.128
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so32732215ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056434; x=1784661234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvralJAhtjQC0agihnqVt6yZC+MGkbFen1qSIili9Nc=;
        b=VG6Xj81F5S/ZRaj0v2iVgPjJ2r14ha6lo1wSa5w+l2PWo1XW/IDkwyzUbv9MMGQs+I
         I3CADMXKTKcTJ2NESpni75slX3bt3A4J/ZUfIIxH/GN+QLoyTHWxiuuGyTOmcWsl0Qfu
         QLW+1jE3CVV/OJLobPl1QhgRXme8o1qVJHARIGzKZcqyd46YEA0SJ1vN8hv5IhJyu1g2
         gTLzpJO5YLFF2BHjXBHmzpOyCflb15wDrjn7XqdSn0y+My8p8kLBTcowoZJjK9bEIFAZ
         cjhrW1NvT0oJKsyLgpB1wLk8dBlDBJPIW76BuHMIqUybLLxPXQVHTg3IE5fu+cmnsNyh
         mcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056434; x=1784661234;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZvralJAhtjQC0agihnqVt6yZC+MGkbFen1qSIili9Nc=;
        b=adDuBli33IipkO3/U7KrAVV0thACqikaFoMZDcoHZSK3nkWxe4qcoogGM/nTooWyz1
         F1LwLNA3BwtH/UoCGnjE9e41/a27B7s/uYmYQUBfj/0jpzBl1X7+jn1XGAztfdfw62Va
         i18B3BQIvC/88SZXw9gjAGU8fEvmL3Mntl8sU6vFzGpLRSoEUU8hZ8/KuFxRw6hePb3C
         oKkTng2YchG65zLFw6xajpmJoiyaFJqphD3r/A45+iir5vUCmvStFBooeLYaZMoPyDyi
         nuCowK3M23tOl/Tne5x/XZuIxWTUAlODpTxz2OVqgfOq6wLyQacbO+5NN6YA33cMA7qD
         Zi5w==
X-Gm-Message-State: AOJu0YzHBWDMm3SZvbsBxJGzhPAtHUHaVN5rDA66w1n5tTGjT1LsJckd
	8GsaZPKqbhRbhGWCANv2YqsHQftnMfj7BrxuHxT75mUw9F0yqJ4EZz4f
X-Gm-Gg: AfdE7cl9Ne6fo2sN/bkGNfjCAZbgqh2IECYjMioV0GUNLhEtOERC9sLIYNnrkUx+cEV
	Teezl0IBMpIsC/5mYcd/iUg9hZZp0iv4YK54pw8Gf6T6Wi6kqRRshABNHhOLHKHxUvggBJwYPlx
	0/SIOeFtbuhVLxO/ntOAvqA0BTyYOKgmf/EV2WUvg7o9U4hc1tKiLgaOdMG5u0s3gwZZ0taN/OQ
	3Lj62CXxt0JBWVoRHfQuk1daCJgHwfc52VJUY6XDJbVEHUlFSrjpQ9Hy/KwbYs69t1BV67lOUpS
	YUBN3DJKPKhbdyZwFAT1tDr7vEMEkEz5WXaly96Ldi5VOFJkIomzmMDbmRfEf0BrqSoxkwKtI/c
	MPHekCUVDs3NGJHADsVjOmJNN/7Al5ZM+OAXiOsar8YkEJMqqo9Fhif+2KA8Kw4q0XjfxT6f4lH
	8CkYAD4tAcJKg=
X-Received: by 2002:a17:903:2f0f:b0:2ce:ed59:7044 with SMTP id d9443c01a7336-2ceed597127mr47465305ad.30.1784056433646;
        Tue, 14 Jul 2026 12:13:53 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:13:53 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 00/10] net-next: add basic support for RK3568 XPCS
Date: Wed, 15 Jul 2026 03:08:28 +0800
Message-ID: <20260714191341.690906-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9874B758211

This series adds proper SGMII support for the Rockchip RK3568 SoC
using the integrated Synopsys DesignWare XPCS, along with necessary
fixes and refactoring in the stmmac core and XPCS driver.

Motivation
==========
The RK3568 integrates a DW XPCS accessed via APB3 and connected to
a Naneng Combo SerDes PHY.  Several boards (e.g., Ariaboard
Photonicat) use this interface for Gigabit Ethernet.  However, the
current upstream stmmac driver does not support this configuration,
and the XPCS driver has issues in SGMII poll mode that cause the
link to be reported incorrectly.

This series addresses these issues by:
- Fixing the XPCS driver's SGMII AN state handling
- Refactoring stmmac PCS lifetime management to allow platform drivers
  full control over PCS creation/destruction
- Adding a Rockchip XPCS platform glue driver and wiring it up in
  dwmac-rk

Series overview
===============

Generic:
  Patch 1: move XPCS lifetime management to platform drivers
           (introduces pcs_init/pcs_exit callbacks)

PHY:
  Patch 2: DT binding for Naneng Combo PHY SGMII MAC selection
  Patch 3: implement the PHY SGMII MAC selection in driver

RK3568 XPCS/SGMII:
  Patch 4: DT binding for Rockchip RK3568 XPCS
  Patch 5: add XPCS and fixed-clock nodes to rk3568.dtsi
  Patch 6: improve SGMII AN state handling (fixes link-down recovery)
  Patch 7: implement the Rockchip XPCS platform glue driver
  Patch 8: wire up SGMII support in dwmac-rk
  Patch 10: update MAINTAINERS

Board enablement:
  Patch 9: enable SGMII LAN port on Photonicat board

Key design decisions
====================
- The stmmac core now delegates XPCS creation entirely to platform
  drivers via pcs_init/pcs_exit.  This is necessary because the
  generic XPCS creation logic would override any XPCS set up by the
  platform driver.

- The Rockchip XPCS driver creates a virtual MDIO bus over the APB3
  registers and implements address remapping.  The generic XPCS core
  handles all PCS configuration via phylink_pcs_ops.

- On RK3568 in SGMII mode, the MAC clock is fixed at 125 MHz and
  cannot be dynamically changed.  In-band mode is used, and the
  generic stmmac set_clk_tx_rate callback is disabled to prevent
  incorrect clock updates that would break RX.

- The SerDes and power domain are attached to the XPCS device tree
  node rather than the MAC node. This reflects the actual hardware
  topology and simplifies the dwmac-rk driver by keeping all PCS-related
  resources self-contained. It also prepares for possible future QSGMII
  support, where a single SerDes serves multiple MACs and would be
  more naturally managed under the XPCS node.

Testing
=======
Board: Ariaboard Photonicat (RK3568)
OS: Armbian (trixie)
Kernel: 6.18 (backports)
Result: The SGMII interface obtains an IP address, SSH works, and
        ping traffic passes without loss.

Notes
=====
- When testing out-band mode with set_clk_tx_rate, only 1000Mbps
  works on both TX/RX; 10/100Mbps only works on TX side.
- I also noticed that the PHY (YT8521) reports 100Mbps/Half in out-band
  tesing while the PCS reports 100Mbps/Full if using in-band.
  This looks like a separate PHY driver bug.
  I will address/report it independently after this series lands
  (or if a maintainer points me to the right list).

Dependencies
============
None. All patches apply cleanly on top of torvalds master tree (v7.2).

Questions
=========
1. Patch 6 (SGMII AN state handling) touches generic pcs-xpcs code and
   may affect Wangxun NICs.  I don't have Wangxun hardware to test.
   The original Wangxun-specific path is kept unchanged, so I believe
   there is no regression risk.

2. Would Heiko Stuebner be willing to be listed as a co-maintainer
   for the Rockchip XPCS driver?  I've added myself in MAINTAINERS,
   but having a more experienced Rockchip maintainer on board would
   be ideal.

Related discussion
==================
Previous attempt at SGMII support on RK3568 by others:
https://lore.kernel.org/all/20221129072714.22880-2-amadeus@jmu.edu.cn/

Also related (runtime PM fix for xpcs-plat, sent separately):
https://lore.kernel.org/all/20260704214808.1566710-1-coiaprant@gmail.com/

Acknowledgments
===============
This work was inspired by and builds upon the excellent work of others:
- Serge Semin's Synopsys DesignWare XPCS platform driver (pcs-xpcs-plat.c)
- Clément Léger's Renesas MIIC driver (pcs-rzn1-miic.c)
- The Rockchip TRM and downstream OEM drivers

This is my first kernel driver series.  I've spent many nights
debugging the hardware quirks on this board.  I hope this can finally
replace the out-of-tree OEM code with a clean upstream solution.
Any guidance during review is greatly appreciated.

Thanks in advance,
Coia Prant
---
Coia Prant (10):
  net: stmmac: move XPCS lifetime management to platform drivers
  dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel
    property
  phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
  dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
  arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes
  net: pcs: xpcs: improve SGMII AN state handling for Rockchip RK3568
  net: pcs: xpcs: add Rockchip RK3568 platform glue driver
  net: stmmac: dwmac-rk: add SGMII support for RK3568
  arm64: dts: rockchip: rk3568-photonicat: enable SGMII LAN port
  MAINTAINERS: add entry for Rockchip XPCS driver

 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 126 +++++
 .../phy/phy-rockchip-naneng-combphy.yaml      |   7 +
 MAINTAINERS                                   |   9 +
 .../boot/dts/rockchip/rk3568-photonicat.dts   |  77 ++-
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  45 ++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  44 +-
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |   7 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  87 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |   7 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   7 +-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  37 +-
 drivers/net/pcs/Kconfig                       |  22 +
 drivers/net/pcs/Makefile                      |   7 +-
 drivers/net/pcs/pcs-xpcs-rk.c                 | 526 ++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c                    |  31 +-
 .../rockchip/phy-rockchip-naneng-combphy.c    |   8 +
 include/linux/pcs/pcs-xpcs-rk.h               |  11 +
 18 files changed, 1008 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
 create mode 100644 drivers/net/pcs/pcs-xpcs-rk.c
 create mode 100644 include/linux/pcs/pcs-xpcs-rk.h

-- 
2.47.3


