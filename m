Return-Path: <netdev+bounces-97075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46498C90DA
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DC2282857
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E791347C2;
	Sat, 18 May 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lHH0ivHS"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D32BD18;
	Sat, 18 May 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036179; cv=none; b=Esid9cLY7mYE99tIi0R2pA2MMZx3D+7CAawgqTwxtuq/fU11DbPiTNcdJeRFUicBNZdbUx/leoSKzYHnMWATRhzyZa8YkcQ2y8CMrNLI+6KtmnFZ0wAGLF5u0EnR7WWAYcJJu+JMjichj60jTaUQFmoKtP5vw8q81eN5ecSO0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036179; c=relaxed/simple;
	bh=jkwcA8lU6445icT8Qbn0CEc/G3PrmJFVPGKG+bAHoRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsA8qAbPKPDP8y4NvQNsz8qZimO90B7yB8ULUFSocrkzt4d/K2FOKpL6/Mdp760gveJs+BWnpeCvHv+ZnPwjrSkNuaHuXRWJtJZpJvQtWXA5Weg73aqC1mk1OE0yM6nHrLyHAQhdGXMhcCAr6nedgUwocSFG0QrdGspGqQswTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lHH0ivHS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgd1p017224;
	Sat, 18 May 2024 07:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036159;
	bh=GABHN3I8j/LnTKYeasLQZjr60IN5cf7RrpoPavx4GZY=;
	h=From:To:CC:Subject:Date;
	b=lHH0ivHSTfSogbPiCKihZq3+HPS92vqkHGJa2g4z4i9Iz64ktpAAW7PFxwzmYIb6r
	 vX9uCTW49+xGWFm8cqPV6p9J9Vd33i2Ud4FaH8NMTq81ycKTOxo3zkqehwvRiz4UhV
	 +3dLMDssnXS4CTlBXWRcNTje8eEtmyCCp8q2DZZ8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICgdFv003852
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:42:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:42:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:42:39 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9G041511;
	Sat, 18 May 2024 07:42:35 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 00/28] Add CPSW Proxy Client driver
Date: Sat, 18 May 2024 18:12:06 +0530
Message-ID: <20240518124234.2671651-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series introduces the CPSW Proxy Client driver to interface with
Ethernet Switch Firmware (EthFw) running on a remote core on TI's K3
SoCs. Further details are in patch 01/28 which adds documentation for
the driver and describes the intended use-case, design and execution
of the driver.

Please DO NOT MERGE this series. I will appreciate feedback on this
series in the form of both documentation enhancements and code review.

This series does not depend on other series and applies cleanly on the
latest net-next commit:
4b377b4868ef kprobe/ftrace: fix build error due to bad function definition

However, for purposes of functionality, device-tree changes are required
in the form of a device-tree overlay in order to mark device-tree nodes
as reserved for EthFw's use.

I have tested this series on J721E EVM verifying:
1. Ping/Iperf
2. Interface Up-Down
3. Module Removal

Linux Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/0972e74383cd1ec16e2f82c0d447f90b

EthFw Logs corresponding to the Linux Logs shared above:
https://gist.github.com/Siddharth-Vadapalli-at-TI/28743298daf113f90be9ceb26c46b16b

Regards,
Siddharth.

Siddharth Vadapalli (28):
  docs: networking: ti: add driver doc for CPSW Proxy Client
  net: ethernet: ti: add RPMsg structures for Ethernet Switch Firmware
  net: ethernet: ti: introduce the CPSW Proxy Client
  net: ethernet: ti: cpsw-proxy-client: add support for creating
    requests
  net: ethernet: ti: cpsw-proxy-client: enable message exchange with
    EthFw
  net: ethernet: ti: cpsw-proxy-client: add helper to get virtual port
    info
  net: ethernet: ti: cpsw-proxy-client: add helper to attach virtual
    ports
  net: ethernet: ti: cpsw-proxy-client: add helpers to alloc/free
    resources
  net: ethernet: ti: cpsw-proxy-client: add helper to init TX DMA
    Channels
  net: ethernet: ti: cpsw-proxy-client: add helper to init RX DMA
    Channels
  net: ethernet: ti: cpsw-proxy-client: add NAPI TX polling function
  net: ethernet: ti: cpsw-proxy-client: add NAPI RX polling function
  net: ethernet: ti: cpsw-proxy-client: add helper to create netdevs
  net: ethernet: ti: cpsw-proxy-client: add and register dma irq
    handlers
  net: ethernet: ti: cpsw-proxy-client: add helpers to (de)register MAC
  net: ethernet: ti: cpsw-proxy-client: implement and register ndo_open
  net: ethernet: ti: cpsw-proxy-client: implement and register ndo_stop
  net: ethernet: ti: cpsw-proxy-client: implement and register
    ndo_start_xmit
  net: ethernet: ti: cpsw-proxy-client: implement and register
    ndo_get_stats64
  net: ethernet: ti: cpsw-proxy-client: implement and register
    ndo_tx_timeout
  net: ethernet: ti: cpsw-proxy-client: register
    ndo_validate/ndo_set_mac_addr
  net: ethernet: ti: cpsw-proxy-client: implement .get_link ethtool op
  net: ethernet: ti: cpsw-proxy-client: add sw tx/rx irq coalescing
  net: ethernet: ti: cpsw-proxy-client: export coalescing support
  net: ethernet: ti: cpsw-proxy-client: add helpers to (de)register IPv4
  net: ethernet: ti: cpsw-proxy-client: add ndo_set_rx_mode member
  net: ethernet: ti: cpsw-proxy-client: add helper to detach virtual
    ports
  net: ethernet: ti: cpsw-proxy-client: enable client driver
    functionality

 .../ethernet/ti/cpsw_proxy_client.rst         |  182 ++
 drivers/net/ethernet/ti/Kconfig               |   14 +
 drivers/net/ethernet/ti/Makefile              |    3 +
 drivers/net/ethernet/ti/cpsw-proxy-client.c   | 2354 +++++++++++++++++
 drivers/net/ethernet/ti/ethfw_abi.h           |  370 +++
 5 files changed, 2923 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/ti/cpsw_proxy_client.rst
 create mode 100644 drivers/net/ethernet/ti/cpsw-proxy-client.c
 create mode 100644 drivers/net/ethernet/ti/ethfw_abi.h

-- 
2.40.1


