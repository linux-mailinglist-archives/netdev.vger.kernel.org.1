Return-Path: <netdev+bounces-220755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2784B487EA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4628D7A3B7A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5F32F60A7;
	Mon,  8 Sep 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GQGSpZ99"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C8199FD0;
	Mon,  8 Sep 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322526; cv=none; b=YqQqXlyeJxzsjY4jmDqJ/89fqYuLVEnQG14IgFzlIw5DSyLpBoOYoEfFciHm6O6YQ+s1Unm2bhiL4tZcK2qWje7y0Y369RzmhUdHClNrLYR9GSfnqxsBGi4AJzNbsHDGg2fDNp9hZ3iEXTlXX/3PCnpZCKcd2SA8mYlqnEQY9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322526; c=relaxed/simple;
	bh=3/IXwQYdzrb+8+Wl8ttL6K2OCageb+uA5sMyf5P3l0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnATcc5JsEx5h2VRE+rr613hqJLigsac1ODkEVIDh8eLtYcdRf24rShTc2n1XPuK2k3LVR4tFPiwrbKuopCy19YbXVVftCCKt3V6ER+26d24mV2usTOr25esa5cnNmHPXhblpXLIfylM2D6RiPm/W8CCqUP7CfuFbU0RCYYBsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GQGSpZ99; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58897tnB071848;
	Mon, 8 Sep 2025 04:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757322475;
	bh=oFCiZfEq7zIHjgLX3tsUwQj/pkDFixFCQPlJyAkDwDQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GQGSpZ99eQFK//CxcxfR+akZjjkzCRLtXRhKSEEgq5ILpPq/N4Os8ig1wPRyhurSz
	 SdG5ecm5CW2tMVZvREYZ5nohLg2iiNymwDcrNSuG/xkfv6HePCnWQVmT7zT2Gzy9cM
	 HcTOJL3yjzlvOociaIA4wj+NURzFxHX8XT6MK1oc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58897sR72896850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:07:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:07:53 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:07:53 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58897rvZ2355780;
	Mon, 8 Sep 2025 04:07:53 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58897qfx023020;
	Mon, 8 Sep 2025 04:07:53 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Luo Jie
	<quic_luoj@quicinc.com>, Fan Gong <gongfan1@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 1/7] net: rpmsg-eth: Add Documentation for RPMSG-ETH Driver
Date: Mon, 8 Sep 2025 14:37:40 +0530
Message-ID: <20250908090746.862407-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908090746.862407-1-danishanwar@ti.com>
References: <20250908090746.862407-1-danishanwar@ti.com>
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
 .../device_drivers/ethernet/rpmsg_eth.rst     | 424 ++++++++++++++++++
 2 files changed, 425 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 0b0a3eef6aae..20513a595af1 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -51,6 +51,7 @@ Contents:
    netronome/nfp
    pensando/ionic
    qualcomm/ppe/ppe
+   rpmsg_eth
    smsc/smc9
    stmicro/stmmac
    ti/cpsw
diff --git a/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst b/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
new file mode 100644
index 000000000000..7a9d94291de4
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
@@ -0,0 +1,424 @@
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
+Naming Convention
+=================
+
+Throughout this documentation and in the driver implementation, the following naming
+convention is used to describe the direction of communication:
+
+- **Firmware**: The firmware / RTOS binary running on the remote core. This takes the primary role.
+- **Driver**: The Linux driver running on the host core. This takes the secondary role.
+
+This convention is important for understanding the data flow and the responsibilities
+of each side in the communication channel.
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
+- Support for notifications and responses from the firmware.
+
+Magic Number
+============
+
+A **magic number** is used in the shared memory layout to validate that the
+memory region is correctly initialized and accessible by both driver and the
+firmware. This value is a unique constant ``0xABCDABCD`` that is written to
+specific locations (such as the head and tail structures) in the shared memory
+by the firmware and checked by the driver during the handshake process.
+
+Purpose of the Magic Number
+---------------------------
+
+- **Validation:** Ensures that the shared memory region has been properly set up
+  and is not corrupted or uninitialized.
+- **Synchronization:** Both driver and firmware must agree on the magic number
+  value, which helps detect mismatches in memory layout or protocol version.
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
+data between driver and firmware. The shared memory is divided into transmit
+and receive regions, each with its own `head` and `tail` indices to track the
+buffer state. The base address of this shared memory is configured in the
+device tree. See :ref:`Configuration <rpmsg_config>` for details.
+
+Shared Memory Parameters
+------------------------
+
+The following parameters are exchanged between the driver and the firmware to
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
+3. **tx_offset**:
+
+   - The offset from the `base_addr` where the transmit buffers begin.
+   - This is used by driver to write packets for transmission.
+
+4. **rx_offset**:
+
+   - The offset from the `base_addr` where the receive buffers begin.
+   - This is used by driver to read packets received from the firmware.
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
+      |        HEAD_IDX         |
+      ---------------------------
+      |        MAGIC_NUM        |
+      |        PKT_1_LEN        |
+      |          PKT_1          |
+      ---------------------------
+      |           ...           |
+      ---------------------------
+      |        MAGIC_NUM        |
+      |        TAIL_IDX         |   rpmsg_eth_shm_tail
+      ---------------------------
+
+1. **MAGIC_NUM**:
+
+   - A unique identifier used to validate the shared memory region.
+   - Ensures that the memory region is correctly initialized and accessible.
+
+2. **HEAD Index**:
+
+   - Tracks the start of the buffer for packet transmission or reception.
+   - Updated by the producer (Driver or firmware) after writing a packet.
+
+3. **TAIL Index**:
+
+   - Tracks the end of the buffer for packet transmission or reception.
+   - Updated by the consumer (Driver or firmware) after reading a packet.
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
+- The driver and firmware use a circular buffer mechanism to manage the shared
+  memory.
+- The `head` and `tail` indices are used to determine the number of packets
+  available for processing:
+
+   .. code-block:: c
+
+         num_pkts = head - tail;
+         num_pkts = num_pkts >= 0 ? num_pkts : (num_pkts + max_buffers);
+
+- The producer writes packets to the buffer and increments the `head` index.
+- The consumer reads packets from the buffer and increments the `tail` index.
+
+RPMSG Communication
+===================
+
+The driver uses RPMSG channels to exchange control messages with the firmware.
+These messages are used to manage the state of the Ethernet interface,
+configure settings, notify events, and exchange runtime information.
+
+Information Exchanged Between RPMSG Channels
+--------------------------------------------
+
+1. **Requests from Driver to Firmware**:
+
+   - `RPMSG_ETH_REQ_SHM_INFO`: Request shared memory information, such as
+     ``num_pkt_bufs``, ``buff_slot_size``, ``tx_offset``, and
+     ``rx_offset``.
+   - `RPMSG_ETH_REQ_SET_MAC_ADDR`: Set the MAC address of the Ethernet
+     interface.
+   - `RPMSG_ETH_REQ_ADD_MC_ADDR`: Add a multicast address to the firmware's
+     filter list.
+   - `RPMSG_ETH_REQ_DEL_MC_ADDR`: Remove a multicast address from firmware's
+     filter list.
+
+2. **Responses from Firmware to Driver**:
+
+   - `RPMSG_ETH_RESP_SET_MAC_ADDR`: Acknowledge the MAC address configuration.
+   - `RPMSG_ETH_RESP_ADD_MC_ADDR`: Acknowledge the addition of a multicast
+     address.
+   - `RPMSG_ETH_RESP_DEL_MC_ADDR`: Acknowledge the removal of a multicast
+     address.
+   - `RPMSG_ETH_RESP_SHM_INFO`: Respond with shared memory information such as
+     ``num_pkt_bufs``, ``buff_slot_size``, ``tx_offset``, and
+     ``rx_offset``.
+
+3. **Notifications from Firmware to Driver**:
+
+   - `RPMSG_ETH_NOTIFY_PORT_UP`: Notify that the Ethernet port is up and ready
+     for communication.
+   - `RPMSG_ETH_NOTIFY_PORT_DOWN`: Notify that the Ethernet port is down.
+   - `RPMSG_ETH_NOTIFY_REMOTE_READY`: Notify that the firmware is ready for
+     communication.
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
+   - Initialize the `MAGIC_NUM`, `num_pkt_bufs`, `buff_slot_size`, `tx_offset`,
+     and `rx_offset`.
+
+2. **Magic Number Requirements**
+
+   - The firmware must write a unique magic number ``0xABCDABCD`` to the
+     `magic_num` field of both the head and tail structures in the shared
+     memory region.
+   - This magic number is used by the Linux driver to validate that the shared
+     memory region is correctly initialized and accessible.
+   - If the driver detects an incorrect magic number during the handshake, it
+     will abort initialization and report an error.
+   - Vendors must ensure the magic number matches the value expected by the
+     Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
+     source.
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
+   - Notify the Driver about the state of the Ethernet interface using the
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
+.. _rpmsg_config:
+
+Configuration
+=============
+
+The driver relies on the device tree for configuration. The shared memory
+region need to be specified in the remote processor device's "memory-region".
+
+Example Device Tree Node
+------------------------
+Here is an example of how the device tree node might look:
+
+.. code-block:: dts
+
+    <shr_mem_region> {
+        compatible = "shared-dma-pool";
+        reg = <base_address size>;
+    };
+
+    <rproc_device> {
+        memory-region = <&<shr_mem_region>>;
+    };
+
+In this example, ``<rproc_device>`` is the remote processor device node, and
+``<shr_mem_region>`` is the shared memory region node. The remote processor
+device references the shared memory region node using the ``memory-region``
+property.
+
+Vendors can create their own ``<shr_mem_region>`` and add it to their remote
+processor device node i.e. ``<rproc_device>``
+
+Driver Configuration
+--------------------
+
+Vendors need to configure the driver as well by adding a new entry of type
+:c:type:`rpmsg_device_id` in the array ``rpmsg_eth_id_table``.
+
+The :c:type:`rpmsg_device_id` structure contains two members:
+
+* :c:member:`name` - a string that identifies the RPMsg device
+* :c:member:`driver_data` - a pointer to a :c:type:`rpmsg_eth_data` structure
+
+Overview of rpmsg_eth_data
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``rpmsg_eth_data`` structure is a vendor-specific configuration structure
+that provides customization options for the RPMsg Ethernet driver.
+
+.. code-block:: c
+
+   /**
+    * struct rpmsg_eth_data - RPMSG ETH device data
+    * @shm_region_index: Shared memory region index
+    */
+   struct rpmsg_eth_data {
+       u8 shm_region_index;
+   };
+
+Currently, the structure contains a single field, but it is designed to be
+extensible for future enhancements.
+
+The shm_region_index Field
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``shm_region_index`` field is an 8-bit unsigned integer within the
+``rpmsg_eth_data`` structure that specifies which memory-region phandle to use
+from the device tree for the RPMsg Ethernet shared memory.
+
+This field is used in the ``rpmsg_eth_get_shm_info`` function to retrieve the
+correct shared memory region from the device tree using the
+``of_parse_phandle`` function:
+
+.. code-block:: c
+
+    rmem_np = of_parse_phandle(np, "memory-region", common->data.shm_region_index);
+
+The ``shm_region_index`` indicates which memory region to use when multiple
+memory regions are defined in the remote processor device tree node.
+
+Example
+~~~~~~~
+
+The following example shows how to create a custom RPMsg device ID:
+
+.. code-block:: c
+
+    static const struct rpmsg_eth_data my_rpmsg_eth_data = {
+        .shm_region_index = 2,
+    };
+
+    static struct rpmsg_device_id my_rpmsg_eth_id_table[] = {
+        { .name = "my.shm-eth", .driver_data = (kernel_ulong_t)&my_rpmsg_eth_data },
+        {},
+    };
+
+Limitations
+===========
+
+- The driver assumes a specific shared memory layout and may not work with other
+  configurations.
+- The driver currently supports only one transmit and one receive queue.
+- The current implementation only supports Linux driver running on the "host"
+  core as secondary and firmware running on the "remote" core as primary. It
+  does not support Linux-to-Linux communication where Linux driver would run on
+  both ends.
+
+References
+==========
+
+- :doc:`RPMSG Framework documentation </staging/rpmsg>`
+- :doc:`Network device documentation </networking/index>`
+
+Authors
+=======
+
+- MD Danish Anwar <danishanwar@ti.com>
-- 
2.34.1


