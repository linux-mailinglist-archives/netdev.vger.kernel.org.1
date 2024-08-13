Return-Path: <netdev+bounces-117929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BAE94FEF7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77E3B2114D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62176048;
	Tue, 13 Aug 2024 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fqa8U33+"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B136BFC0;
	Tue, 13 Aug 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534993; cv=none; b=loc/g0r67TJ80UMxPjrgEUiDFCbDEeDPRGa9fccdGsS79s0vrbFZ3Uq5FjhanXvdfIqXaTRc9xJ3crbzO6xdFhJ9yli70qWxUJdoZIKZc/nRjn92tn8h8O2Z8zWAP8Zn/1dI3QjultUVSY/9CpDom5oqBPNxrH7vK9+e/SQf3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534993; c=relaxed/simple;
	bh=lO7y/ykZycuZGhGSqBoExlsPzpEu4qzTNGz32eEnpgk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNzafr7vjzn7D2RbWvGWfHlQ6G2nbAqD6ikD/UBzap846eTHjkn9+o5KkoEKtKecVsJUcRGL0RPhmK+H58SLxmjjnu+/OeDN1z4L4tgzBSIi415h/gD7oHTtQYNFSH00GKzQzOdJquzGoAlg4au2SnnoTawFD5PdFZ5Xs8LAmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fqa8U33+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gaF7119095;
	Tue, 13 Aug 2024 02:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723534956;
	bh=v9l96O9yf68qz5Yj6hIzDOX+wl1EikjY2B0QdiBfiGM=;
	h=From:To:CC:Subject:Date;
	b=Fqa8U33+T5/oarCZffUQddinohLPnc7NGZ4TACLb7S47Yh5jJRB8FC7LecCf1hI7l
	 DNWjgYhQXTkiOfYiaQFeIPPQ8KlvsZQQED0BBNZAmvVVUBkWoLT5WwBxowRfPUtb4F
	 kwlROesyXwyL6iuVgzhabLLWhzAxEyzQmhAAut70=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D7gan6056076
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 02:42:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 02:42:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 02:42:36 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gawn025644;
	Tue, 13 Aug 2024 02:42:36 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47D7gZTA008707;
	Tue, 13 Aug 2024 02:42:35 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 0/7] Introduce HSR offload support for ICSSG
Date: Tue, 13 Aug 2024 13:12:26 +0530
Message-ID: <20240813074233.2473876-1-danishanwar@ti.com>
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

Changes from v1 to v2:
*) Modified patch 2/7 to only contain code movement as suggested by
   Dan Carpenter <dan.carpenter@linaro.org>
*) Added patch 3/7 by splitting it from 2/6 as the patch is not part of
   code movement done in patch 2/7.
*) Rebased on latest net-next/main.

MD Danish Anwar (5):
  net: ti: icssg-prueth: Enable IEP1
  net: ti: icss-iep: Move icss_iep structure
  net: ti: icssg-prueth: Stop hardcoding def_inc
  net: ti: icssg-prueth: Add support for HSR frame forward offload
  net: ti: icssg-prueth: Add multicast filtering support in HSR mode

Ravi Gunasekaran (2):
  net: ti: icssg-prueth: Enable HSR Tx Packet duplication offload
  net: ti: icssg-prueth: Enable HSR Tx Tag and Rx Tag offload

 drivers/net/ethernet/ti/icssg/icss_iep.c      |  72 -------
 drivers/net/ethernet/ti/icssg/icss_iep.h      |  73 ++++++-
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  16 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 187 ++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   7 +
 8 files changed, 273 insertions(+), 95 deletions(-)


base-commit: 0a3e6939d4b33d68bce89477b9db01d68b744749
-- 
2.34.1


