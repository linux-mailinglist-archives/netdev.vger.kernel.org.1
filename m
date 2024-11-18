Return-Path: <netdev+bounces-145824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAD39D1122
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58381F234BE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB719F103;
	Mon, 18 Nov 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1/65y0er"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA419D092;
	Mon, 18 Nov 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934884; cv=none; b=Jh1jw1nqEewUHQU2NvnZmfm7nZ//bpWB41ZoNeiU/aG5WjvVSSVM7pE8oFSp6Mqa0rF6T1zeOtO56Qc6UmXVHWSD1qy2HOFKypKNzTMfn/ORHUKo8FISS0LNWTz2dnqfngB3XpJp4yuSyQfwO5Qpr48fZ7PwT2vd1YhKQrKd4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934884; c=relaxed/simple;
	bh=ZHjrUlq66zs8efI7yyCOtRV2kHJYGGuesQuTNPW2bvI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=vAmfv0taEvLQI+dM9idh9uiC6oa+gKJxVU8XMwrtCr4JtAG0t1NsenXv3/js4BqRH8zQwnS6acKyplE5Y4qoRupVM8m3RpiUMx7twSnHT1YhsujfBybyvv6u0i648N1RXQgvZhKI2g4N6Otw0XGTebGXVCkKHKb9mxFXp1ox7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1/65y0er; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731934882; x=1763470882;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ZHjrUlq66zs8efI7yyCOtRV2kHJYGGuesQuTNPW2bvI=;
  b=1/65y0ermd99qnoJHPSp4spuqA7qNZjpPSV2Ila8CLBG8n80fthptI4D
   DXiwS43raRjy8v/ZEqkLdZ5aEHoStWZ4jO/9dX+Ps4GOVJVBqstw/P1wG
   W9f7vpONdDdqDGamadfEakz6xZvRemmPjrtKE8U8hMb3tyK05hQOkoULi
   44iBsifGiimQk1xFwlT+C45YxbRTzKntUT96YCSA3xRlVdiYtMsFnwEub
   Gdn/RyW9/vhTYq330bgcYvodwLYdjLUiFKsO/Epk3UvxwTqQHVIScqkhG
   8jzjSUpckI0jKpNTqvjLYNGxUwOTF/9bmshluXty7424sXBbeS2BoGecx
   w==;
X-CSE-ConnectionGUID: DbRaG4tGSXe42+jZNuS/Pw==
X-CSE-MsgGUID: 8tKiatfDTPeGBJ/uTe1xlA==
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="37994315"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2024 06:01:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Nov 2024 06:00:56 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 18 Nov 2024 06:00:53 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v3 0/8] net: lan969x: add RGMII support
Date: Mon, 18 Nov 2024 14:00:46 +0100
Message-ID: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH46O2cC/4WOS27EIBBErzJinY4AY2yyyj2iWfBzaCnGVmMRj
 0a+exgriyibWZZK9V7dWYmEsbC3y51RrFhwyS10Lxfmk82fETC0zCSXSgiuoKyW9h6+bDba7FC
 +cfMJAmGNBApCb9wwSq7G3rIGWSlOuJ+CD5bjBjnuG7u2xtkSwZHNPj0Es8X8GCQs20K381AV5
 +zXrZ+5qwAO0zANndCq0y68z+hp8QnXV7/Mp7XKP0jRPUXKhuTBmdF6bnQQ/5HHcfwAfTg1BkQ
 BAAA=
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

== Description:

This series is the fourth of a multi-part series, that prepares and adds
support for the new lan969x switch driver.

The upstreaming efforts is split into multiple series (might change a
bit as we go along):

        1) Prepare the Sparx5 driver for lan969x (merged)

        2) Add support for lan969x (same basic features as Sparx5
           provides excl. FDMA and VCAP, merged).

        3) Add lan969x VCAP functionality (merged).

    --> 4) Add RGMII support.

        5) Add FDMA support.

== RGMII support:

The lan969x switch device includes two RGMII interfaces (port 28 and 29)
supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.

Details are in the commit description of the patches.

== Patch breakdown:

Patch #1 does some preparation work.

Patch #2 adds new function: is_port_rgmii() to the match data ops.

Patch #3 uses the is_port_rgmii() in a number of places.

Patch #4 uses the phy_interface_mode_is_rgmii() in a number of places.

Patch #5 adds checks for RGMII PHY modes in sparx5_verify_speeds().

Patch #6 adds registers required to configure RGMII.

Patch #7 adds RGMII implementation.

Patch #8 document RGMII delays.

To: UNGLinuxDriver@microchip.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Lars Povlsen <lars.povlsen@microchip.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Russell King <linux@armlinux.org.uk>
To: jacob.e.keller@intel.com
To: robh@kernel.org
To: krzk+dt@kernel.org
To: conor+dt@kernel.org
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v3:

v2 was kindly tested by Robert Marko. Not carrying the tag to v3 since
we have changes to the handling of the delays.

- Modified lan969x_rgmii_delay_config() to not apply any MAC delay when
  the {rx,tx}-internal-delay-ps properties are missing or set to 0
  (patch #7).

- Removed 'required' constraint from {rx-tx}-internal-delay-ps
  properties. Also added description and default value (Patch #8).

- Link to v2: https://lore.kernel.org/r/20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com

Changes in v2:

  Most changes are in patch #7. RGMII implementation has been moved to
  it's own file lan969x_rgmii.c.

  Details:

    - Use ETH_P_8021Q and ETH_P_8021AD instead of the Sparx5 provided
      equivalents (patch #7).
    - Configure MAC delays through "{rx,tx}-internal-delay-ps"
      properties (patch #7).
    - Add selectors for all the phase shifts that the hardware supports
      (instead of only 2.0 ns, patch #7).
    - Add selectors for all the port speeds (instead of only 1000 mbps.)
    - Document RGMII delays in dt-bindings.

  - Link to v1: https://lore.kernel.org/r/20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com

---
Daniel Machon (8):
      net: sparx5: do some preparation work
      net: sparx5: add function for RGMII port check
      net: sparx5: use is_port_rgmii() throughout
      net: sparx5: use phy_interface_mode_is_rgmii()
      net: sparx5: verify RGMII speeds
      net: lan969x: add RGMII registers
      net: lan969x: add RGMII implementation
      dt-bindings: net: sparx5: document RGMII delays

 .../bindings/net/microchip,sparx5-switch.yaml      |  18 ++
 drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
 drivers/net/ethernet/microchip/lan969x/lan969x.c   |   5 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h   |  10 +
 .../net/ethernet/microchip/lan969x/lan969x_rgmii.c | 224 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |   3 +
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 ++++--
 .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
 11 files changed, 473 insertions(+), 28 deletions(-)
---
base-commit: d7ef9eeef0723cc47601923c508ecbebd864f0c0
change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


