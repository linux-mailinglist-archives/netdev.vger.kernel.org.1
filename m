Return-Path: <netdev+bounces-127251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998D974C4A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EE9286371
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4613D50B;
	Wed, 11 Sep 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C/aNJF02"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75913D510;
	Wed, 11 Sep 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042592; cv=none; b=jc4s2YY1e096vPExUSf24Q1n3q4QkVqhLOzH1ov7UQU6KHn2IWh1qq8CgkYRGQ0OXq/wQTQghoXRTdvLz4qhwvHNCYFldDQaVv9J5qWyFBy39OJMNfbiT32AwozP/JgdDm59GrYnBvb/J/umhPe5pKW08veLDDQ5TyKAwGg64lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042592; c=relaxed/simple;
	bh=xORRYaOI65Nln4gdGbFiF+cXnA6mtFGHnoEkL0is48w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KE77bvzynfBjoX7nqFfSm/vNzHaaSv8GcnRMhE0Tzax9b47HgUaTZ/rbd5pGBk6oo0zMWPvmZGPQcUCjYsY7/x6upYfBF479TVcTEAuZWjneNCQG6jmpFYwHS8U+h77q6cRFVglmDf9Z6PLF0oaRr5pYOf9FMYRaH/uqkEiNgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C/aNJF02; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8G6SK044012;
	Wed, 11 Sep 2024 03:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726042566;
	bh=d1PHMLAifrqnQnQ87o9A1quYM6RpIYl7JQF3tGF2juY=;
	h=From:To:CC:Subject:Date;
	b=C/aNJF02QDNKp8cyqP46TX+Kn59xWo1EH70RsZGtfk7GlsqOWR4H9yB2lQrO4iH5j
	 aG7dq7226MCHZx+Ows3DctFRNKb90M5NdnY2GjmlqOhUvdrVjCN5eVir8987jHkNrs
	 Bg+PwMO+vsOJ3nHWl3nY7irFC6FWZHdEfuW5VZ28=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8G6qU092044;
	Wed, 11 Sep 2024 03:16:06 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:16:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:16:05 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8G5bn011414;
	Wed, 11 Sep 2024 03:16:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 48B8G4Es032107;
	Wed, 11 Sep 2024 03:16:05 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <r-gunasekaran@ti.com>, <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v6 0/5] Introduce HSR offload support for ICSSG
Date: Wed, 11 Sep 2024 13:45:58 +0530
Message-ID: <20240911081603.2521729-1-danishanwar@ti.com>
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

2) hsr-tag-ins-offload and hsr-dup-offload are tightly coupled in
   the firmware implementation. They both need to be enabled / disabled
   together.

Changes from v5 to v6:
*) Dropped ndo_set_features API as asked by Roger.
*) Modified emac_ndo_fix_features as asked by Roger Quadros
<rogerq@kernel.org>

Changes from v4 to v5:
*) Fixed warning reported by kernel test robot [0].

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
v4: https://lore.kernel.org/all/20240904100506.3665892-1-danishanwar@ti.com/
v5: https://lore.kernel.org/all/20240906111538.1259418-1-danishanwar@ti.com/

[0] https://lore.kernel.org/all/202409061658.vSwcFJiK-lkp@intel.com/
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

 drivers/net/ethernet/ti/icssg/icss_iep.c      |  72 -------
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  73 ++++++-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  18 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  22 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 185 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +
 8 files changed, 290 insertions(+), 92 deletions(-)


base-commit: f3b6129b7d252b2fbdcac2e0005abc6804dc287c
-- 
2.34.1


