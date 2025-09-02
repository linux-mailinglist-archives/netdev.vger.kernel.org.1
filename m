Return-Path: <netdev+bounces-219066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCFB3F9B6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D233ACD98
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59F2EA473;
	Tue,  2 Sep 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YFZCdqdw"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0D20E6E1;
	Tue,  2 Sep 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804124; cv=none; b=GyH3jypbbxH9dl8UmVXUSqQoobRPoPdIe9xqdqITTdxYd7ooIS7x11V1qc6kwCBPNu/ZbMkw5Fkx2wMx/f20r99hnbuCLrvp/AJP4hdmyI2JKM5JDz2lngvjK9xaInLRCiFY+bjiiFVeOw3G9e4M3NM2eITEFsproj25SAJRiRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804124; c=relaxed/simple;
	bh=THzX+EN7VTzLuUULbWMGm/unxefBSjJEmc+4sbmh/uU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFrZV8s751N5qvm1m1IfgCsAskHp3/fa4ORx6f75gKjy+3o1uPDq+0HLVh/OyiNwGR2kPrhgruXiFKx0c9Rp8X2psm8nSfb+5jYaKbKjZjSAPYIDRuO3xnRW+7qGlVLv1CZBZp2k1IMDBfyAa9mjIKgXwcXhXzOE3pEb/92gxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YFZCdqdw; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58297oXq2552615;
	Tue, 2 Sep 2025 04:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756804070;
	bh=nqogwPdlvq7AEEvwLHEeyKv2i7NgHAJdNmEi0OQOf7s=;
	h=From:To:CC:Subject:Date;
	b=YFZCdqdwq8yWUw0jYqrSif1z5Sq/uO4sktL2tGSXazw135W2ZJhfv+aADvNRBKR7E
	 FMmuA0tTpaWL21CA5pZkOKq8QHstztcFJ9fNkhhryP/vQ/TJfK0I9F4yREHlXyy6VN
	 r37/IiL51SdDKA6cbDrdE14X3vJcxQh2dJ5lrmL8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58297ow52171631
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 04:07:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:07:49 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:07:49 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58297nDR1001478;
	Tue, 2 Sep 2025 04:07:49 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58297mND020814;
	Tue, 2 Sep 2025 04:07:48 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        MD
 Danish Anwar <danishanwar@ti.com>, Xin Guo <guoxin09@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Suman Anna <s-anna@ti.com>
CC: Tero Kristo <kristo@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next v2 0/8] Add RPMSG Ethernet Driver
Date: Tue, 2 Sep 2025 14:37:38 +0530
Message-ID: <20250902090746.3221225-1-danishanwar@ti.com>
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

Key features of this driver:

1. Virtual Ethernet interface using RPMSG framework
2. Shared memory-based packet transmission and reception
3. Support for multicast address filtering
4. Dynamic MAC address assignment
5. NAPI support for efficient packet processing
6. State machine for managing interface states

The series begins by adding device tree binding documentation, continues
with  core driver implementation, and concludes with platform-specific DTS
changes for the TI K3 AM64 SoC. The driver is designed to be generic and
can be used by any vendor that implements compatible firmware for their
remote processors.

This driver is designed to be generic and vendor-agnostic. Vendors can
develop firmware for the remote processor to make it compatible with this
driver by adhering to the shared memory layout and communication protocol
described in the documentation.

This patch series has been tested on a TI AM64xx platform with a
compatible remote processor firmware. Feedback and suggestions for
improvement are welcome.

Changes since v1:
- Added dt binding for rpmsg-eth node similar to `qcom,glink-edge.yaml`
  and `google,cros-ec.yaml`
- Added phandle to rpmsg-eth node to dt binding `ti,k3-r5f-rproc.yaml`
- In the driver, shared memory region is now obtained from the rpmsg-eth
  node in device tree.
- Dropped base address from rpmsg callback. Since base address is obtained
  from device tree, no need for rpmsg callback to share this base address
  again.
- Dropped usage of pointers and strictly using only offsets while
  communicating to firmware.
- Updated documentation based on the changes in driver and bindings.
- Added "Naming convention" section to documentation to clarify naming and
  various terms used in the driver and documentation.
- Kept the naming should be consistent throughout the documentation and
  driver as suggested by Andrew Lunn <andrew@lunn.ch>
- Added device tree patch in the series to clarify how the changes will be
  done in device tree and how the driver will use device tree information.

v1 https://lore.kernel.org/all/20250723080322.3047826-1-danishanwar@ti.com/

MD Danish Anwar (8):
  dt-bindings: net: ti,rpmsg-eth: Add DT binding for RPMSG ETH
  dt-bindings: remoteproc: k3-r5f: Add rpmsg-eth subnode
  net: rpmsg-eth: Add Documentation for RPMSG-ETH Driver
  net: rpmsg-eth: Add basic rpmsg skeleton
  net: rpmsg-eth: Register device as netdev
  net: rpmsg-eth: Add netdev ops
  net: rpmsg-eth: Add support for multicast filtering
  arch: arm64: dts: k3-am64*: Add rpmsg-eth node

 .../devicetree/bindings/net/ti,rpmsg-eth.yaml |  38 ++
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |   6 +
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/rpmsg_eth.rst     | 368 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  11 +-
 drivers/net/ethernet/Kconfig                  |  10 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/rpmsg_eth.c              | 639 ++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h              | 283 ++++++++
 9 files changed, 1356 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,rpmsg-eth.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
 create mode 100644 drivers/net/ethernet/rpmsg_eth.c
 create mode 100644 drivers/net/ethernet/rpmsg_eth.h


base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
-- 
2.34.1


