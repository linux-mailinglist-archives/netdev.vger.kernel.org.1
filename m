Return-Path: <netdev+bounces-96460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264908C6091
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494891C20C51
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B193B290;
	Wed, 15 May 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NMI1A9Cr"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987323A29F;
	Wed, 15 May 2024 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753053; cv=none; b=lcJjnMwfDIHJqFeD17jXgBS4vaq3AGaWO/0lIIlDKnDj54AEEhiMVQFwPDmXCVNoIbvYT9On9KE/X9JygR68SOv0lALfrGQmsnXEx0ymRFIt3CDSmRifuUvfmQlUAcdPnH71I48nTnmbayBnj5CEvNwPgBb/ODJ8g5I7/78yZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753053; c=relaxed/simple;
	bh=VWwmMUM1Lbfr5IA5967p41DjlUsSHLh42TM5+wQa6Jw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWS6pt2mMNC4zHz0LgG84r2nv7slqLpIig9KCPkw1OVdaDr0Okr6ncyEJAm0I7HOUmZx3CTh/fB3zX+BLAVWDLQHcXTyzi3STvFKOrcs+Q2ISPg3ifQIbVeziWWl5UlTnWZMBT+ZzCWBYZ2wShPFMUP7zyNhDHtiStrP42L04OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NMI1A9Cr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F63OUw111891;
	Wed, 15 May 2024 01:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715753004;
	bh=DJC3n4YBr4mraORAIsBV0BhFeTokOltNjlCbCW87Qpo=;
	h=From:To:CC:Subject:Date;
	b=NMI1A9CrM1xKiE7bU+EGIphgRyeIH1qCWfZCb8yBlMGkey+WSNxJsVVw+Cn7eT1RI
	 FCMqnoO+/Ztjr5t0YR85Q3jVltaUvDaLzumZ4CGIXE8btuAEMJCCTsmEKrFfrbXXeG
	 2lwH8oO7CO4SNjSq7xYPM7puQWbG1oLgRk8ySt1Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F63OPO068741
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 01:03:24 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 01:03:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 01:03:24 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F63OhW038209;
	Wed, 15 May 2024 01:03:24 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44F63NVI021283;
	Wed, 15 May 2024 01:03:23 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon Horman
	<horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo
	<diogo.ivo@siemens.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
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
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next v4 0/3] Introduce switch mode support for ICSSG driver
Date: Wed, 15 May 2024 11:33:17 +0530
Message-ID: <20240515060320.2783244-1-danishanwar@ti.com>
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

This is v4 of the series. It addresses commenst made on v3.
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

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (3):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-switch: Add switchdev based driver for ethernet switch
    support
  net: ti: icssg-prueth: Add support for ICSSG switch firmware

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 306 ++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  26 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 250 ++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  36 ++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 477 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 9 files changed, 1099 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h

-- 
2.34.1


