Return-Path: <netdev+bounces-98124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFBF8CF8BF
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D905DB209F1
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EEA10A36;
	Mon, 27 May 2024 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="caIVx4JP"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868610A11;
	Mon, 27 May 2024 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716787699; cv=none; b=kRc4Cg8jOgD+0T+N+pgkiAGqecD8Lup/nXtJdeTZMJh9MDFqRlbOQINZm3ebG4OeAQNfvL4b2sC/VK2lYARgoZpkZyzTD8+5qRcwUGHMOf0vgMBiwReptlpHwKq0iRmxIgaevshFLI9GWnSwVkDfM3OnkFCfQgd87GSyxXLPY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716787699; c=relaxed/simple;
	bh=CNxus2CCNqvShcE9cqtxnCeXIfBc67UjEwZ3slr8ORw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMq/6qaG6cs/nlX3JvemoKo3Oyfjs2RFbLSc4S1Inr6LVrU68k3TJ2x4ZkpNVUM2Id4/dFmAhmXrCAvXSL3PhAtjmSOlpqSUYWnRbKWBKfPVpL/JKDkQl4DiIX3rgsjm4+UYYgxL3GuqelTIo3Vi4U7f2ewHZ+wchdZ922GDNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=caIVx4JP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44R5Rf8c058834;
	Mon, 27 May 2024 00:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716787661;
	bh=L+CvMDzS6vXLD/Dg72nwo1GVyQ/2y/No4xs6kDqVnaU=;
	h=From:To:CC:Subject:Date;
	b=caIVx4JP1k06z/PWA35qYVFr6fx6yb6o2Neo6ILT6uaYZZ5WEsGgnMNwYJ9CA0rmt
	 VJoEi8/lNauHR1x5bL73diIfqVna3E+LdDlLRW2FWzZ/MK9KnwpBHSBauc8H2qEs2X
	 6CPB0nyyoEfAhCV8b7ekxmgX1iv5UJamrkNq3GMs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44R5Rfwm119812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 00:27:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 00:27:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 00:27:41 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44R5RfYB020474;
	Mon, 27 May 2024 00:27:41 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44R5ReV7013472;
	Mon, 27 May 2024 00:27:41 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn
	<andrew@lunn.ch>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v5 0/3] Introduce switch mode support for ICSSG driver
Date: Mon, 27 May 2024 10:57:35 +0530
Message-ID: <20240527052738.152821-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds support for switch-mode for ICSSG driver. This series
also introduces helper APIs to configure firmware maintained FDB
(Forwarding Database) and VLAN tables. These APIs are later used by ICSSG
driver in switch mode.

Now the driver will boot by default in dual EMAC mode. When first ICSSG
interface is added to bridge driver will still be in EMAC mode. As soon as
second ICSSG interface is added to same bridge, switch-mode will be
enabled and switch firmwares will be loaded to PRU cores. The driver will
remain in dual EMAC mode if ICSSG interfaces are added to two different
bridges or if two differnet interfaces (One ICSSG, one other) is added to
the same bridge. We'll only enable is_switch_mode flag when two ICSSG
interfaces are added to same bridge.

We start in dual MAC mode. Let's say lan0 and lan1 are ICSSG interfaces

ip link add name br0 type bridge
ip link set lan0 master br0

At this point, we get a CHANGEUPPER event. Only one port is a member of
the bridge, so we will still be in dual MAC mode.

ip link set lan1 master br0

We get a second CHANGEUPPER event, the second interface lan1 is also ICSSG
interface so we will set the is_switch_mode flag and when interfaces are
brought up again, ICSSG switch firmwares will be loaded to PRU Cores.

There are some other cases to consider as well. 

ip link add name br0 type bridge
ip link add name br1 type bridge

ip link set lan0 master br0
ip link set ppp0 master br0

Here we are adding lan0 (ICSSG) and ppp0 (non ICSSG) to same bridge, as
they both are not ICSSG, we will still be running in dual EMAC mode.

ip link set lan1 master br1
ip link set vpn0 master br1

Here we are adding lan1 (ICSSG) and vpn0 (non ICSSG) to same bridge, as
they both are not ICSSG, we will still be running in dual EMAC mode.

This is v5 of the series.

Changes from v4 to v5:
*) Rebased on 6.10-rc1.
*) Dropped the RFC tag.

Changes from v3 to v4:
*) Added RFC tag as net-next is closed now.
*) Modified the driver to remove the need of bringing interfaces up / down
   for enabling / disabling siwtch mode. Now switch mode can be enabled
   without bringig interfaces up / down as requested by Andrew Lunn
   <andrew@lunn.ch>
*) Modified commit message of patch 3/3.

Changes from v2 to v3:
*) Dropped RFC tag.
*) Used ether_addr_copy() instead of manually copying mac address using
   for loop in patch 1/3 as suggested by Andrew Lunn <andrew@lunn.ch>
*) Added helper API icssg_fdb_setup() in patch 1/3 to reduce code
   duplication as suggested by Andrew Lunn <andrew@lunn.ch>
*) In prueth_switchdev_stp_state_set() removed BR_STATE_LEARNING as
   learning without forwarding is not supported by ICSSG firmware.
*) Used ether_addr_equal() wherever possible in patch 2/3 as suggested
   by Andrew Lunn <andrew@lunn.ch>
*) Fixed typo "nit: s/prueth_switchdevice_nb/prueth_switchdev_nb/" in
   patch 2/3 as suggested by Simon Horman <horms@kernel.org>
*) Squashed "#include "icssg_mii_rt.h" to patch 2/3 from patch 3/3 as
   suggested by Simon Horman <horms@kernel.org>
*) Rebased on latest net-next/main.

Changes from v1 to v2:
*) Removed TAPRIO support patch from this series.
*) Stopped using devlink for enabling switch-mode as suggested by Andrew L
*) Added read_poll_timeout() in patch 1 / 3 as suggested by Andrew L.

v1 https://lore.kernel.org/all/20230830110847.1219515-4-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20240118071005.1514498-1-danishanwar@ti.com/
v3 https://lore.kernel.org/all/20240327114054.1907278-1-danishanwar@ti.com/
v4 https://lore.kernel.org/all/20240515060320.2783244-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar
MD Danish Anwar (3):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-switch: Add switchdev based driver for ethernet switch
    support
  net: ti: icssg-prueth: Add support for ICSSG switch firmware

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 322 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  26 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 250 ++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  36 ++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 477 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 10 files changed, 1113 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h


base-commit: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e
-- 
2.34.1


