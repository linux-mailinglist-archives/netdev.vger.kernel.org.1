Return-Path: <netdev+bounces-209248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE8B0ECA4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296B83B8892
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298227A90A;
	Wed, 23 Jul 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dc0yvBqD"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55127A131;
	Wed, 23 Jul 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257855; cv=none; b=U/ToqfpqG8FKGMRkz/0Z45mRkBsqhaG0mnHFLOQZHjItqa+QkURWfO8djGOxl2SwmPK4xmWoeU9iWSv4z46G7vP9CqdZhIu9GV3KGYQM6elIBzN7zWHYlvekBUi80EWdhvSTx1UNmFSOeQx1nw9vYv4Jm832WbxNtiRA4Q0WOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257855; c=relaxed/simple;
	bh=in6aCh8OG+DIgT70sSqbf6rBRdXsO3IskACYFmdI6aY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgNxXIjGr+BDnkJZeUYqYuV7A5jCkerRsyaRJd2vrPqS1xZGA+kBZKR6qvijlfvbYZTOksDlzaVQGLpbU4s6VGu19SOXr+n6BMXtNQbCOCT+xsfsjtwCpilkFV8cqHXsm7E/1gzuRLVoKKu4VdMsWD1FsULe2oZRAMB/4M5KnlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dc0yvBqD; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83Sn51223384;
	Wed, 23 Jul 2025 03:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257808;
	bh=0Ybm8y+09b48ASpOGQxtkH7SHUZzEVtplNLuU/J9K3k=;
	h=From:To:CC:Subject:Date;
	b=Dc0yvBqDZax9AHS3O15+YBkPMxBeHwqkydQ/ggHCw9a3LYpontOSGFl8Uew1Ginp8
	 gCBx8uqiYla5rC05/mHXMuzACXeS7JkO+kAHojBShYC9CNiQWNiTnm2wkll2pUExeX
	 YoWFMvoslaIneEqjAOTB08BF68DTUNSursF0j60o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83SlJ1619052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:27 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83RlH2365773;
	Wed, 23 Jul 2025 03:03:27 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83QkL015933;
	Wed, 23 Jul 2025 03:03:26 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/5] Add RPMSG Ethernet Driver
Date: Wed, 23 Jul 2025 13:33:17 +0530
Message-ID: <20250723080322.3047826-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch series introduces the RPMSG Ethernet driver, which provides a
virtual Ethernet interface for communication between a host processor and
a remote processor using the RPMSG framework. The driver enables
Ethernet-like packet transmission and reception over shared memory,
facilitating inter-core communication in systems with heterogeneous
processors.

This series is a rework of [1]. There was comment from Andrew Lunn
<andrew@lunn.ch> to modify this driver and make it generic so that other
vendors can also use it.

I have tried to generalize the driver. Since there has been lots of changes
since [1], I am posting this as a new series.

The series includes the following patches:

1. Documentation:
  - Adds comprehensive documentation for the RPMSG Ethernet driver.
  - Details the shared memory layout, communication protocol, and usage
    instructions.
  - Provides a guide for vendors to develop compatible firmware.

2. Basic RPMSG Skeleton:
  - Introduces the basic RPMSG Ethernet driver skeleton.
  - Implements probe, remove, and callback functions.
  - Sets up the foundation for RPMSG communication.

3. Netdev Registration:
  - Registers the RPMSG Ethernet device as a netdev.
  - Enhances the RPMSG callback to handle shared memory for TX and RX
    buffers.
  - Introduces shared memory structures and initializes the netdev.

4. Netdev Operations:
  - Implements netdev operations such as `ndo_open`, `ndo_stop`,
    `ndo_start_xmit`, and `ndo_set_mac_address`.
  - Adds support for NAPI-based RX processing and a timer-based RX
    polling mechanism.
  - Introduces a state machine to manage the driver's state transitions.

5. Multicast Filtering:
  - Adds support for multicast address filtering.
  - Implements the `ndo_set_rx_mode` callback to manage multicast
    addresses.
  - Introduces a workqueue-based mechanism for asynchronous RX mode
    updates.

Key Features:
- Virtual Ethernet interface using RPMSG.
- Shared memory-based packet transmission and reception.
- Support for multicast address management.
- Dynamic MAC address assignment.
- Efficient packet processing using NAPI.
- State machine for managing interface states.

This driver is designed to be generic and vendor-agnostic. Vendors can
develop firmware for the remote processor to make it compatible with this
driver by adhering to the shared memory layout and communication protocol
described in the documentation.

This patch series has been tested on a TI AM64xx platform with a compatible
remote processor firmware. Feedback and suggestions for improvement are
welcome.

[1] https://lore.kernel.org/all/20240531064006.1223417-1-y-mallik@ti.com/

MD Danish Anwar (5):
  net: rpmsg-eth: Add Documentation for RPMSG-ETH Driver
  net: rpmsg-eth: Add basic rpmsg skeleton
  net: rpmsg-eth: Register device as netdev
  net: rpmsg-eth: Add netdev ops
  net: rpmsg-eth: Add support for multicast filtering

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/rpmsg_eth.rst     | 339 ++++++++
 drivers/net/ethernet/Kconfig                  |  10 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/rpmsg_eth.c              | 743 ++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h              | 305 +++++++
 6 files changed, 1399 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
 create mode 100644 drivers/net/ethernet/rpmsg_eth.c
 create mode 100644 drivers/net/ethernet/rpmsg_eth.h


base-commit: 56613001dfc9b2e35e2d6ba857cbc2eb0bac4272
-- 
2.34.1


