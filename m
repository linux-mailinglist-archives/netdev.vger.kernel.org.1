Return-Path: <netdev+bounces-122692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB9962337
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117331C210C5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3204C165F08;
	Wed, 28 Aug 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qh4MZv+5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452D15E5C8;
	Wed, 28 Aug 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836772; cv=none; b=apbeb5KpZ7KQ8a+8PbXeWgHf7RuV6aB56eR3VPQEW8mt+Zjr9eVMtNbW192MhtC+g9KWWavvLVSkk5dqzaDpIfAJvhDaZXjVKbI59SB1fTANb4ggdhTg6q4nR6QRiY1rlCmlqM5D/kE79b3JpdqA8/+jub7vVprpFcQ61ojwcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836772; c=relaxed/simple;
	bh=75Ac1ux3wSiLTmmKs6fVjtGD6q9N5h4FJizhOL2dAck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fg8rTHmTK5bF6n+qmnTox29BVsU/tZWhQV0oM4VfasU7kGeHFKYw+Mxi3Gsr3z85rPoDCKuSmI9nSZkZb6pPow4c+ouVgQo1jHmxYWp2vJyK59Nr+AsPXYHnaEkJ6jcqbePJZmU3vVpmXf9TplssiKaHMLErB2LzixZNGFDI9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qh4MZv+5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J4aQ084245;
	Wed, 28 Aug 2024 04:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724836744;
	bh=ekYOuLexyebNgthzikEPIns81VKOgVjs/KtwLoaOR8g=;
	h=From:To:CC:Subject:Date;
	b=Qh4MZv+5OEg6xtPR6vseseUiVDdHTJUTW19UREVSF6KOPabqvRFvGj83Frh6UAGqi
	 w7UeB5Fm+NE1Qs7co71isMuzy/+G/oKONvJApudECg1MxeXPUvdW13+n/adAKyxPNu
	 hlo6lVxSd7JdtjpgEN7iSucLQJfjSP0NCNOSj0Rs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S9J4vs127084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 04:19:04 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 04:19:04 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 04:19:04 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J4Re009430;
	Wed, 28 Aug 2024 04:19:04 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47S9J3cS007457;
	Wed, 28 Aug 2024 04:19:03 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 0/6] Introduce HSR offload support for ICSSG
Date: Wed, 28 Aug 2024 14:48:55 +0530
Message-ID: <20240828091901.3120935-1-danishanwar@ti.com>
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

Switching back to Dual EMAC mode:
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
*) Dropped patch [1] as it is no longer needed in this series. It is
   already merged to net/main by commit [2].
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

[1] https://lore.kernel.org/all/20240813074233.2473876-2-danishanwar@ti.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=e846be0fba85  

MD Danish Anwar (4):
  net: ti: icss-iep: Move icss_iep structure
  net: ti: icssg-prueth: Stop hardcoding def_inc
  net: ti: icssg-prueth: Add support for HSR frame forward offload
  net: ti: icssg-prueth: Add multicast filtering support in HSR mode

Ravi Gunasekaran (2):
  net: ti: icssg-prueth: Enable HSR Tx Packet duplication offload
  net: ti: icssg-prueth: Enable HSR Tx Tag and Rx Tag offload

 drivers/net/ethernet/ti/icssg/icss_iep.c      |  72 --------
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  73 +++++++-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  16 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  22 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 172 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +
 8 files changed, 275 insertions(+), 92 deletions(-)


base-commit: e5899b60f52a7591cfc2a2dec3e83710975117d7
-- 
2.34.1


