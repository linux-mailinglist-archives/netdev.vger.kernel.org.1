Return-Path: <netdev+bounces-209253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D35B0ECB1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CCA7A9D27
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5A2836A4;
	Wed, 23 Jul 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H2rIgjCu"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE5281369;
	Wed, 23 Jul 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257862; cv=none; b=QVJm9vZgSb0wrdDBjvLTnF09CWKuozGcPxl92MX0KkhTU9IB0KwPeyW9jWgZrQciHiXINlNrG9Itg0Ehfbx+miicZAFlvMjYIj8os9fMmoRq1MSHeFabgyAhqPFSGZ6QWP444E3x9AlAueb2pQP/XilG3qCjrghZ13L0Jr1VKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257862; c=relaxed/simple;
	bh=AqpMlJ1BSP9Swinfd7sXPYHR1l9IrdpRfu4SEx/a8zA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntaEgjJjwgkdne7JrNUK2GiZEGPoDl+osKLLKtn89qKFplBWwMqRSqLo/7aZ8qnM0rG1IZ6yDBB68qwz3oWY7VivvinfHNcnfQAOLzW0pmRStCymZidRQy82WBFhp0jUm0Vv3zJjwOKrRZKA8WWw+qQkJdbJTdnp9UxV8Y+JGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H2rIgjCu; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83UVw1695117;
	Wed, 23 Jul 2025 03:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257810;
	bh=mvDX6DOV8YuWwDnj84Y8gAsL48e8sIoeavomIPEepuU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H2rIgjCuKKEd2RvAaxowWfB93X8BVVvA8DPvfobv9K5UrrMFS/xHmdQyPWeRH/KRx
	 cotXgRavjssU8daP6yi1fTmgiOWgVXN0lUbHAQOwdfvQmJ2wyyQDFhzhMKL/ltO2nC
	 jJllTdaGUpPoyOYZmEWe8MrD+SooqiRMdv7J/AwM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83Uxn1619069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:30 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:29 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:29 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83TDU160345;
	Wed, 23 Jul 2025 03:03:29 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83S7V015945;
	Wed, 23 Jul 2025 03:03:29 -0500
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
Subject: [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation for RPMSG-ETH Driver
Date: Wed, 23 Jul 2025 13:33:18 +0530
Message-ID: <20250723080322.3047826-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723080322.3047826-1-danishanwar@ti.com>
References: <20250723080322.3047826-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add documentation for the RPMSG Based Virtual Ethernet Driver (rpmsg-eth).
The documentation describes the driver's architecture, shared memory
layout, RPMSG communication protocol, and requirements for vendor firmware
to interoperate with the driver. It details the use of a magic number for
shared memory validation, outlines the information exchanged between the
host and remote processor, and provides a how-to guide for vendors to
implement compatible firmware.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/rpmsg_eth.rst     | 339 ++++++++++++++++++
 2 files changed, 340 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 40ac552641a3..941f60585ee4 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -61,6 +61,7 @@ Contents:
    wangxun/txgbevf
    wangxun/ngbe
    wangxun/ngbevf
+   rpmsg_eth
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst b/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
new file mode 100644
index 000000000000..70c13deb31ea
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
@@ -0,0 +1,339 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+RPMSG Based Virtual Ethernet Driver
+===================================
+
+Overview
+========
+
+The RPMSG Based Virtual Ethernet Driver provides a virtual Ethernet interface for
+communication between a host processor and a remote processor using the RPMSG
+framework. This driver enables Ethernet-like packet transmission and reception
+over shared memory, facilitating inter-core communication in systems with
+heterogeneous processors.
+
+The driver is designed to work with the RPMSG framework, which is part of the
+Linux Remote Processor (remoteproc) subsystem. It uses shared memory for data
+exchange and supports features like multicast address management, dynamic MAC
+address assignment, and efficient packet processing using NAPI.
+
+This driver is generic and can be used by any vendor. Vendors can develop their
+own firmware for the remote processor to make it compatible with this driver.
+The firmware must adhere to the shared memory layout, RPMSG communication
+protocol, and data exchange requirements described in this documentation.
+
+Key Features
+============
+
+- Virtual Ethernet interface using RPMSG.
+- Shared memory-based packet transmission and reception.
+- Support for multicast address management.
+- Dynamic MAC address assignment.
+- NAPI (New API) support for efficient packet processing.
+- State machine for managing interface states.
+- Workqueue-based asynchronous operations.
+- Support for notifications and responses from the remote processor.
+
+Magic Number
+============
+
+A **magic number** is used in the shared memory layout to validate that the
+memory region is correctly initialized and accessible by both the host and the
+remote processor. This value is a unique constant (for example,
+``0xABCDABCD``) that is written to specific locations (such as the head and
+tail structures) in the shared memory by the firmware and checked by the Linux
+driver during the handshake process.
+
+Purpose of the Magic Number
+---------------------------
+
+- **Validation:** Ensures that the shared memory region has been properly set up
+  and is not corrupted or uninitialized.
+- **Synchronization:** Both the host and remote processor must agree on the
+  magic number value, which helps detect mismatches in memory layout or protocol
+  version.
+- **Error Detection:** If the driver detects an incorrect magic number during
+  initialization or runtime, it can abort the handshake and report an error,
+  preventing undefined behavior.
+
+Implementation Details
+----------------------
+
+- The magic number is defined as a macro in the driver source (e.g.,
+  ``#define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD``).
+- The firmware must write this value to the ``magic_num`` field of the head and
+  tail structures in the shared memory region.
+- During the handshake, the Linux driver reads these fields and compares them to
+  the expected value. If any mismatch is detected, the driver will log an error
+  and refuse to proceed.
+
+Example Usage in Shared Memory
+------------------------------
+
+.. code-block:: text
+
+      Shared Memory Layout:
+      ---------------------------
+      |   MAGIC_NUM (0xABCDABCD) |   <-- rpmsg_eth_shm_head
+      |          HEAD            |
+      ---------------------------
+      |   MAGIC_NUM (0xABCDABCD) |   <-- rpmsg_eth_shm_tail
+      |          TAIL            |
+      ---------------------------
+
+The magic number must be present in both the head and tail structures for the
+handshake to succeed.
+
+Firmware developers must ensure that the correct magic number is written to the
+appropriate locations in shared memory before the Linux driver attempts to
+initialize the interface.
+
+Shared Memory Layout
+====================
+
+The RPMSG Based Virtual Ethernet Driver uses a shared memory region to exchange
+data between the host and the remote processor. The shared memory is divided
+into transmit and receive regions, each with its own `head` and `tail` pointers
+to track the buffer state.
+
+Shared Memory Parameters
+------------------------
+
+The following parameters are exchanged between the host and the firmware to
+configure the shared memory layout:
+
+1. **num_pkt_bufs**:
+
+   - The total number of packet buffers available in the shared memory.
+   - This determines the maximum number of packets that can be stored in the
+     shared memory at any given time.
+
+2. **buff_slot_size**:
+
+   - The size of each buffer slot in the shared memory.
+   - This includes space for the packet length, metadata, and the actual packet
+     data.
+
+3. **base_addr**:
+
+   - The base address of the shared memory region.
+   - This is the starting point for accessing the shared memory.
+
+4. **tx_offset**:
+
+   - The offset from the `base_addr` where the transmit buffers begin.
+   - This is used by the host to write packets for transmission.
+
+5. **rx_offset**:
+
+   - The offset from the `base_addr` where the receive buffers begin.
+   - This is used by the host to read packets received from the remote
+     processor.
+
+Shared Memory Structure
+-----------------------
+
+The shared memory layout is as follows:
+
+.. code-block:: text
+
+      Shared Memory Layout:
+      ---------------------------
+      |        MAGIC_NUM        |   rpmsg_eth_shm_head
+      |          HEAD           |
+      ---------------------------
+      |        MAGIC_NUM        |
+      |        PKT_1_LEN        |
+      |          PKT_1          |
+      ---------------------------
+      |           ...           |
+      ---------------------------
+      |        MAGIC_NUM        |
+      |          TAIL           |   rpmsg_eth_shm_tail
+      ---------------------------
+
+1. **MAGIC_NUM**:
+
+   - A unique identifier used to validate the shared memory region.
+   - Ensures that the memory region is correctly initialized and accessible.
+
+2. **HEAD Pointer**:
+
+   - Tracks the start of the buffer for packet transmission or reception.
+   - Updated by the producer (host or remote processor) after writing a packet.
+
+3. **TAIL Pointer**:
+
+   - Tracks the end of the buffer for packet transmission or reception.
+   - Updated by the consumer (host or remote processor) after reading a packet.
+
+4. **Packet Buffers**:
+
+   - Each packet buffer contains:
+
+      - **Packet Length**: A 4-byte field indicating the size of the packet.
+      - **Packet Data**: The actual Ethernet frame data.
+
+5. **Buffer Size**:
+
+   - Each buffer has a fixed size defined by `RPMSG_ETH_BUFFER_SIZE`, which
+     includes space for the packet length and data.
+
+Buffer Management
+-----------------
+
+- The host and remote processor use a circular buffer mechanism to manage the shared memory.
+- The `head` and `tail` pointers are used to determine the number of packets available for processing:
+
+   .. code-block:: c
+
+         num_pkts = head - tail;
+         num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + max_buffers);
+
+- The producer writes packets to the buffer and increments the `head` pointer.
+- The consumer reads packets from the buffer and increments the `tail` pointer.
+
+RPMSG Communication
+===================
+
+The driver uses RPMSG channels to exchange control messages between the host and
+the remote processor. These messages are used to manage the state of the
+Ethernet interface, configure settings, notify events, and exchange runtime
+information.
+
+Information Exchanged Between RPMSG Channels
+--------------------------------------------
+
+1. **Requests from Host to Remote Processor**:
+
+   - `RPMSG_ETH_REQ_SHM_INFO`: Request shared memory information, such as
+     ``num_pkt_bufs``, ``buff_slot_size``, ``base_addr``, ``tx_offset``, and
+     ``rx_offset``.
+   - `RPMSG_ETH_REQ_SET_MAC_ADDR`: Set the MAC address of the Ethernet
+     interface.
+   - `RPMSG_ETH_REQ_ADD_MC_ADDR`: Add a multicast address to the remote
+     processor's filter list.
+   - `RPMSG_ETH_REQ_DEL_MC_ADDR`: Remove a multicast address from the remote
+     processor's filter list.
+
+2. **Responses from Remote Processor to Host**:
+
+   - `RPMSG_ETH_RESP_SET_MAC_ADDR`: Acknowledge the MAC address configuration.
+   - `RPMSG_ETH_RESP_ADD_MC_ADDR`: Acknowledge the addition of a multicast
+     address.
+   - `RPMSG_ETH_RESP_DEL_MC_ADDR`: Acknowledge the removal of a multicast
+     address.
+   - `RPMSG_ETH_RESP_SHM_INFO`: Respond with shared memory information such as
+     ``num_pkt_bufs``, ``buff_slot_size``, ``base_addr``, ``tx_offset``, and
+     ``rx_offset``.
+
+3. **Notifications from Remote Processor to Host**:
+
+   - `RPMSG_ETH_NOTIFY_PORT_UP`: Notify that the Ethernet port is up and ready
+     for communication.
+   - `RPMSG_ETH_NOTIFY_PORT_DOWN`: Notify that the Ethernet port is down.
+   - `RPMSG_ETH_NOTIFY_PORT_READY`: Notify that the Ethernet port is ready for
+     configuration.
+   - `RPMSG_ETH_NOTIFY_REMOTE_READY`: Notify that the remote processor is ready
+     for communication.
+
+4. **Runtime Information Exchanged**:
+
+   - **Link State**: Notifications about link state changes (e.g., link up or
+     link down).
+   - **Statistics**: Runtime statistics such as transmitted/received packets,
+     errors, and dropped packets.
+   - **Error Notifications**: Notifications about errors like buffer overflows
+     or invalid packets.
+   - **Configuration Updates**: Notifications about changes in configuration,
+     such as updated MTU or VLAN settings.
+
+How-To Guide for Vendors
+========================
+
+This section provides a guide for vendors to develop firmware for the remote
+processor that is compatible with the RPMSG Based Virtual Ethernet Driver.
+
+1. **Implement Shared Memory Layout**:
+
+   - Allocate a shared memory region for packet transmission and reception.
+   - Initialize the `MAGIC_NUM`, `num_pkt_bufs`, `buff_slot_size`, `base_addr`,
+     `tx_offset`, and `rx_offset`.
+
+2. **Magic Number Requirements**
+
+   - The firmware must write a unique magic number (for example, ``0xABCDABCD``)
+     to the `magic_num` field of both the head and tail structures in the shared
+     memory region.
+   - This magic number is used by the Linux driver to validate that the shared
+     memory region is correctly initialized and accessible.
+   - If the driver detects an incorrect magic number during the handshake, it
+     will abort initialization and report an error.
+   - Vendors must ensure the magic number matches the value expected by the
+     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
+     source).
+
+3. **Handle RPMSG Requests**:
+
+   - Implement handlers for the following RPMSG requests:
+
+      - `RPMSG_ETH_REQ_SHM_INFO`
+      - `RPMSG_ETH_REQ_SET_MAC_ADDR`
+      - `RPMSG_ETH_REQ_ADD_MC_ADDR`
+      - `RPMSG_ETH_REQ_DEL_MC_ADDR`
+
+4. **Send RPMSG Notifications**:
+
+   - Notify the host about the state of the Ethernet interface using the
+     notifications described above.
+
+5. **Send Runtime Information**:
+
+   - Implement mechanisms to send runtime information such as link state
+     changes, statistics, and error notifications.
+
+6. **Implement Packet Processing**:
+
+   - Process packets in the shared memory transmit and receive buffers.
+
+7. **Test the Firmware**:
+
+   - Use the RPMSG Based Virtual Ethernet Driver on the host to test packet
+     transmission and reception.
+
+Configuration
+=============
+
+The driver relies on the device tree for configuration. The shared memory region
+is specified using the `virtual-eth-shm` node in the device tree.
+
+Example Device Tree Node
+------------------------
+
+.. code-block:: dts
+
+   virtual-eth-shm {
+           compatible = "rpmsg,virtual-eth-shm";
+           reg = <0x80000000 0x10000>; /* Base address and size of shared memory */
+   };
+
+Limitations
+===========
+
+- The driver assumes a specific shared memory layout and may not work with other
+  configurations.
+- Multicast address filtering is limited to the capabilities of the underlying
+  RPMSG framework.
+- The driver currently supports only one transmit and one receive queue.
+
+References
+==========
+
+- RPMSG Framework Documentation: https://www.kernel.org/doc/html/latest/rpmsg.html
+- Linux Networking Documentation: https://www.kernel.org/doc/html/latest/networking/index.html
+
+Authors
+=======
+
+- MD Danish Anwar <danishanwar@ti.com>
-- 
2.34.1


