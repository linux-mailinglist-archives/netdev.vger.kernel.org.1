Return-Path: <netdev+bounces-116789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685294BBF3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFAA1F20614
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3718A95F;
	Thu,  8 Aug 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dJY5qws9"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36915444E;
	Thu,  8 Aug 2024 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115303; cv=none; b=pNgjrwqLhDB8ZCCmBkxsX4lE2Oxzc4U0TEZAo+qjBwnLXYSbIs9r/o4jnQ9VKfs7aooyRKzDk0xAYfKO+yR4RejGq5DN1/DIa6r9QbmZrzMiwcDYO8lE5z/RNsTF9qyQU8BJsDGuYpN8nEn5MG1y+/IYzefKsTY4QmnCi8czCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115303; c=relaxed/simple;
	bh=pn5gbqt6Ww3+ceamKAsPpOvM4O3wGKHnFrIUp9UqX1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSHKml6Vddhcajuc5lZ/eGQxopVlw3CxopWhDh4pLHb1I/tilYncvMSxfPrntiPuE4R745bjG29M3CsOF7QHwXB7WMeuBrYDLpFwI+9Xf5Sa5A2pAtOKhlfxDwGxb/7n9f63V5GkYhQDciBia/BlFMIGunLKF25grHxeT02Uxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dJY5qws9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B83iq130423;
	Thu, 8 Aug 2024 06:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115283;
	bh=OYmqZvXDg6xl4E5wCck2fmUGcqhLJC4qchZVAtvvSXc=;
	h=From:To:CC:Subject:Date;
	b=dJY5qws9zRJCO8toXPBESpWgAxqgkKkwF5TyrEPb2XxaZI8kNBqq/9kU5GZpG0cn2
	 npjpGWE7+gIKm7mn6ai1i9JRIgBKW8wvdklVkdCyJdsITGqRVAD4WjqGxaZQNdndPD
	 3TDMtZAuxjhu/34LbouwEWEomiRh5/Da7xf8Ay3A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B83ZD081467
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:03 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B83Xt070844;
	Thu, 8 Aug 2024 06:08:03 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B82u7011983;
	Thu, 8 Aug 2024 06:08:02 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next 0/6] Introduce HSR offload support for ICSSG
Date: Thu, 8 Aug 2024 16:37:54 +0530
Message-ID: <20240808110800.1281716-1-danishanwar@ti.com>
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

MD Danish Anwar (4):
  net: ti: icssg-prueth: Enable IEP1
  net: ti: icssg-prueth: Add support for HSR frame forward offload
  net: ti: icssg-prueth: Add multicast filtering support in HSR mode
  net: ti: icss-iep: Move icss_iep structure

Ravi Gunasekaran (2):
  net: ti: icssg-prueth: Enable HSR Tx Packet duplication offload
  net: ti: icssg-prueth: Enable HSR Tx Tag and Rx Tag offload

 drivers/net/ethernet/ti/icssg/icss_iep.c      |  72 -------
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  74 ++++++-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  16 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 189 ++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   9 +
 8 files changed, 277 insertions(+), 96 deletions(-)


base-commit: 222a3380f92b8791d4eeedf7cd750513ff428adf
-- 
2.34.1


