Return-Path: <netdev+bounces-124976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7F96B7C3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF091F22E7F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5F1BD4E9;
	Wed,  4 Sep 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e8OuRh2d"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00F1CF5CC;
	Wed,  4 Sep 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444330; cv=none; b=eauFxoiKJex5TyX7MzuOlUJtWO8ai3KZEwPGRL7hwmlGHrPbi/eiQ8T1Am2Ze240ZIBSnpaJQDdbaKnHodLCqgyTMBgXVxIkXmcQamHHvfnD0Bs4F97LdrgX1r9PMVDRacRowk5FBuW+mfpRrkeOaqLIhfS6XSvnmPLKsTBRJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444330; c=relaxed/simple;
	bh=5l2i2okKPqvYTs8EGZAWCDUJOEdgaSBocY+x0vAelOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qobYT4EoLph9TziBbsMDvoQHtsdjsAMZO6Otl3smgp6rcmqim6Fhg7Pk5E/RssKNRzgWTNmNGwVyNgCBpSN2TT6Vcy9bIB+DO8w/QmJwiRmQyL4HrCcgAeq5VrrMPKcOrJL8zq194Efcf0A5ONnePuYmfha9g1c/iKkveXSolVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e8OuRh2d; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484A58x4018386;
	Wed, 4 Sep 2024 05:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725444308;
	bh=FWJxQrgh2tcprMfZJve26f3H5lQR7tw0D0xxXlUZqws=;
	h=From:To:CC:Subject:Date;
	b=e8OuRh2djMRnI5TA8KIVS5MeRDzC7Vb4BdG+WaUnYTtEgcC3bMlmxzrHfWAVmoWv+
	 b+9sS+KNUJuFufyV2bl5KkAcwjSE3d4RgMG49TPevXP9xUivnq6gJ6pQGicBvxaNlv
	 Ml9H3lsyAqTJLF7hs01kW3+XM9AdnWj4SXKvlY5k=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484A58MP012702;
	Wed, 4 Sep 2024 05:05:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 05:05:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 05:05:08 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484A58YP029403;
	Wed, 4 Sep 2024 05:05:08 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 484A57X5015357;
	Wed, 4 Sep 2024 05:05:07 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Sai Krishna <saikrishnag@marvell.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v4 0/5] Introduce HSR offload support for ICSSG
Date: Wed, 4 Sep 2024 15:35:01 +0530
Message-ID: <20240904100506.3665892-1-danishanwar@ti.com>
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

Hi All,
This series introduces HSR offload support for ICSSG driver. To support HSR
offload to hardware, ICSSG HSR firmware is used.

This series introduces,
1. HSR frame offload support for ICSSG driver.
2. HSR Tx Packet duplication offload
3. HSR Tx Tag and Rx Tag offload
4. Multicast filtering support in HSR offload mode.
5. Dependencies related to IEP.

HSR Test Setup:
--------------

     ___________           ___________           ___________
    |           | Link AB |           | Link BC |           |
  __|   AM64*   |_________|   AM64    |_________|   AM64*   |___
 |  | Station A |         | Station B |         | Station C |   |
 |  |___________|         |___________|         |___________|   |
 |                                                              |
 |______________________________________________________________|
                            Link CA
 *Could be any device that supports two ethernet interfaces.

Steps to switch to HSR frame forward offload mode:
-------------------------------------------------
Example assuming eth1, eth2 ports of ICSSG1 on AM64-EVM

  1) Enable HSR offload for both interfaces
      ethtool -K eth1 hsr-fwd-offload on
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-ins-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-fwd-offload on
      ethtool -K eth2 hsr-dup-offload on
      ethtool -K eth2 hsr-tag-ins-offload on
      ethtool -K eth2 hsr-tag-rm-offload on

  2) Create HSR interface and add slave interfaces to it
      ip link add name hsr0 type hsr slave1 eth1 slave2 eth2 \
    supervision 45 version 1

  3) Add IP address to the HSR interface
      ip addr add <IP_ADDR>/24 dev hsr0

  4) Bring up the HSR interface
      ip link set hsr0 up

Switching back to previous mode:
--------------------------------
  1) Delete HSR interface
      ip link delete hsr0

  2) Disable HSR port-to-port offloading mode, packet duplication
      ethtool -K eth1 hsr-fwd-offload off
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-ins-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-fwd-offload off
      ethtool -K eth2 hsr-dup-offload off
      ethtool -K eth2 hsr-tag-ins-offload off
      ethtool -K eth2 hsr-tag-rm-offload off

Testing the port-to-port frame forward offload feature:
-----------------------------------------------------
  1) Connect the LAN cables as shown in the test setup.
  2) Configure Station A and Station C in HSR non-offload mode.
  3) Configure Station B is HSR offload mode.
  4) Since HSR is a redundancy protocol, disconnect cable "Link CA",
     to ensure frames from Station A reach Station C only through
     Station B.
  5) Run iperf3 Server on Station C and client on station A.
  7) Check the CPU usage on Station B.

CPU usage report on Station B using mpstat when running UDP iperf3:
-------------------------------------------------------------------

  1) Non-Offload case
  -------------------
  CPU  %usr  %nice  %sys %iowait  %irq  %soft  %steal  %guest   %idle
  all  0.00   0.00  0.50    0.00  3.52  29.15    0.00    0.00   66.83
    0  0.00   0.00  0.00    0.00  7.00  58.00    0.00    0.00   35.00
    1  0.00   0.00  0.99    0.00  0.99   0.00    0.00    0.00   98.02

  2) Offload case
  ---------------
  CPU  %usr  %nice  %sys %iowait  %irq  %soft  %steal  %guest   %idle
  all  0.00   0.00  0.00    0.00  0.50   0.00    0.00    0.00   99.50
    0  0.00   0.00  0.99    0.00  0.00   0.00    0.00    0.00   99.01
    1  0.00   0.00  0.00    0.00  0.00   0.00    0.00    0.00  100.00

Note:
1) At the very least, hsr-fwd-offload must be enabled.
   Without offloading the port-to-port offload, other
   HSR offloads cannot be enabled.

2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
   must also be enabled as these are tightly coupled in
   the firmware implementation.

Changes from v3 to v4:
*) Simplified ndo_set_features() implementation as suggested by Roger Quadros
<rogerq@kernel.org>
*) Maintained 80 character limit per line wherever possible.
*) Returning -EOPNOTSUPP whenever offloading is not possible.
*) Changed dev_dbg() prints to netdev_dbg() as suggested by Alexander
Lobakin <aleksander.lobakin@intel.com>
*) Squashed patch [1] and [2] together as hsr tag ins is dependent on hsr
tx duplication. Also didn't add Roger's RB tag from patch [2] as the patch
is now merged with [1] in patch 4/5.
*) Implemented emac_ndo_fix_features() to make sure NETIF_F_HW_HSR_DUP is
enabled / disabled with NETIF_F_HW_HSR_TAG_INS as suggested by Roger
Quadros <rogerq@kernel.org>
*) Added Roger's RB tag to patch 5/5.
*) Modified commit message of patch 3/5 to state that driver will be back
to previously used mode once HSR is disabled.

Changes from v2 to v3:
*) Renamed APIs common to switch and hsr modes with suffix _fw_offload.
*) Returning EOPNOTSUPP in prueth_hsr_port_link() as suggested by
   Andrew Lunn <andrew@lunn.ch>
*) Dropped unneccassary dev_err prints and changed dev_err to dev_dbg
   where applicable.
*) Renamed NETIF_PRUETH_HSR_OFFLOAD to NETIF_PRUETH_HSR_OFFLOAD_FEATURES
   to make it clear it is a collection of features, not an alias for one
   feature.
*) Added Kernel doc entries for @hsr_members and @is_hsr_offload_mode as
   suggested by Simon Horman <horms@kernel.org>
*) Dropped patch [3] as it is no longer needed in this series. It is
   already merged to net/main by commit [4].
*) Collected Reviewed-by tag from Roger Quadros <rogerq@kernel.org> for
   PATCH 1/6 and PATCH 2/6.
*) Added if check for current mode before calling __dev_mc_unsync as
   suggested by Roger Quadros <rogerq@kernel.org>
*) Updated commit message of PATCH 6/6 to describe handling of duplicate
   discard in the driver.

Changes from v1 to v2:
*) Modified patch 2/7 to only contain code movement as suggested by
   Dan Carpenter <dan.carpenter@linaro.org>
*) Added patch 3/7 by splitting it from 2/6 as the patch is not part of
   code movement done in patch 2/7.
*) Rebased on latest net-next/main.

v1: https://lore.kernel.org/all/20240808110800.1281716-1-danishanwar@ti.com/
v2: https://lore.kernel.org/all/20240813074233.2473876-1-danishanwar@ti.com
v3: https://lore.kernel.org/all/20240828091901.3120935-1-danishanwar@ti.com/

[1] https://lore.kernel.org/all/20240828091901.3120935-5-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240828091901.3120935-7-danishanwar@ti.com/
[3] https://lore.kernel.org/all/20240813074233.2473876-2-danishanwar@ti.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=e846be0fba85

MD Danish Anwar (4):
  net: ti: icss-iep: Move icss_iep structure
  net: ti: icssg-prueth: Stop hardcoding def_inc
  net: ti: icssg-prueth: Add support for HSR frame forward offload
  net: ti: icssg-prueth: Add multicast filtering support in HSR mode

Ravi Gunasekaran (1):
  net: ti: icssg-prueth: Enable HSR Tx duplication, Tx Tag and Rx Tag
    offload

 drivers/net/ethernet/ti/icssg/icss_iep.c      |  72 ------
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  73 ++++++-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  18 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  22 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 206 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +
 8 files changed, 311 insertions(+), 92 deletions(-)


base-commit: 075e3d30e4a3da8eadd12f2f063dc8e2ea9e1f08
-- 
2.34.1


