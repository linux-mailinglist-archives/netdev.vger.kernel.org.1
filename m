Return-Path: <netdev+bounces-97078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025368C90E2
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835B31F21D9D
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EB3AC36;
	Sat, 18 May 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kwxAuE8x"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB04501C;
	Sat, 18 May 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036198; cv=none; b=lno5wbcGbb1MpOqvTjkyErJcDFX7LUwGJZ3h5ko1akghdjnV1zmzAcqspQC0mOe2eYOVzbLsjX8k7WccAxERFDgWaHTkQxc7vz9lsf6aZ7f7gheQF9G+8n7akPtAjkxUN3DpjPv3iqAzpa59uncs9fwmPTES0ctmD6fcu3CcHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036198; c=relaxed/simple;
	bh=Koe1sNrTYjSZCLuUcQozRg8Jzt4dLoVCuqgb/Y44CoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6GdKNlVb7BYNQVFCfpL8r+wPBIR7nTCV6EnRGWNXIoqjztirArCadzQoJJaw/B78IWf3tq9sEG6Mh7TGMN7zfem6mjvYewgA22H5R6/Mi8V/QlhuDLyUnWWFXi3FlVhOybkc922LMfUFiBk7ZqoRgX8Rl52lZvrb3fZo1Z3t3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kwxAuE8x; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgi82002707;
	Sat, 18 May 2024 07:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036164;
	bh=HErwNj3FkwqS+RMt1FiDnjhDBqOllwZh3tB5aqDrELw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kwxAuE8xfN+7xRaYrs2/AEkk3tRY/NXvAHHzKxgumDdYginJ4lNPIj9F76RhQsQFc
	 b8jcT5viEvTCyC7wwioIWcgPFt+Q6aBu14FpOxIP92ARA96wKJyCFFwHMmCFX48rIS
	 nVPnA4kMQHYxGpBLOFce0Oofkro8G1bXLSzmDe0k=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICgivo129113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:42:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:42:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:42:44 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9H041511;
	Sat, 18 May 2024 07:42:39 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 01/28] docs: networking: ti: add driver doc for CPSW Proxy Client
Date: Sat, 18 May 2024 18:12:07 +0530
Message-ID: <20240518124234.2671651-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CPSW Proxy Client driver interfaces with Ethernet Switch Firmware on
a remote core to enable Ethernet functionality for applications running
on Linux. The Ethernet Switch Firmware (EthFw) is in control of the CPSW
Ethernet Switch on the SoC and acts as the Server, offering services to
Clients running on various cores.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../ethernet/ti/cpsw_proxy_client.rst         | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/ti/cpsw_proxy_client.rst

diff --git a/Documentation/networking/device_drivers/ethernet/ti/cpsw_proxy_client.rst b/Documentation/networking/device_drivers/ethernet/ti/cpsw_proxy_client.rst
new file mode 100644
index 000000000000..46bff67b3446
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/ti/cpsw_proxy_client.rst
@@ -0,0 +1,182 @@
+.. SPDX-License-Identifier: GPL-2.0-only or MIT
+
+==========================================
+Texas Instruments CPSW Proxy Client driver
+==========================================
+
+Introduction
+============
+
+The CPSW (Common Platform Switch) Ethernet Switch on TI's K3 SoCs provides
+Ethernet functionality. There may be multiple instances of CPSW on a single
+SoC. The term "CPSWnG" is used to indicate the number of MAC Ports supported
+by a specific instance of CPSW. CPSWnG indicates that the peripheral has
+(n-1) MAC Ports and 1 Host Port. Examples of existing instances are:
+CPSW2G => 1 MAC Port and 1 Host Port
+CPSW3G => 2 MAC Ports and 1 Host Port
+CPSW5G => 4 MAC Ports and 1 Host Port
+CPSW9G => 8 MAC Ports and 1 Host Port
+
+The presence of 2 or more MAC Ports implies that Hardware Switching can
+be enabled between the MAC Ports if required.
+
+The "am65-cpsw-nuss.c" driver in Linux at:
+drivers/net/ethernet/ti/am65-cpsw-nuss.c
+provides Ethernet functionality for applications on Linux.
+It also handles both the control-path and data-path, namely:
+Control => Configuration of the CPSW Peripheral
+Data => Configuration of the DMA Channels to transmit/receive data
+
+The aforementioned configuration supports use-cases where all applications
+which require Ethernet functionality are only running on Linux.
+
+However, there are use-cases where applications running on different
+Operating Systems across multiple cores on the SoC require Ethernet
+functionality. Such use-cases can be supported by implementing a
+Client-Server model to share the data-path among Clients while the Server
+owns the control-path.
+
+On TI's K3 SoCs (J721E, J7200 and J784S4 in particular), the Ethernet Switch
+Firmware (EthFw) running on the MAIN R5F core acts as the Server and
+configures the CPSWnG instance (CPSW5G on J7200 and CPSW9G on J721E, J784S4)
+of the CPSW Ethernet Switch on the SoC. The Clients running on various cores
+communicate with EthFw via RPMsg (Remote Processor Messaging) to request
+resource allocation details during initialization, followed by requesting
+EthFw to enable features supported by CPSW based on the features required
+by the applications running on the respective cores.
+
+EthFw handles requests from the Clients and evaluates them before configuring
+CPSW based on the request. Since no Client is actually in control of CPSW and
+only requests EthFw for configuring CPSW, EthFw acts as the proxy for the
+Clients. Thus, the Linux Client which interfaces with EthFw is named:
+CPSW Proxy Client
+
+The data-path for the CPSW Proxy Client driver remains identical to the
+"am65-cpsw-nuss.c" driver which happens to be DMA. It is only the control-path
+that is different.
+
+Client-Server discovery occurs over the RPMsg-Bus. EthFw announces its
+RPMsg Endpoint name over the RPMsg-Bus. The CPSW Proxy Client driver
+registers itself with the Linux RPMsg framework to be probed for the same
+Endpoint name. Following probe, the Linux Client driver begins communicating
+with EthFw and queries details of the resources available for the Linux Client.
+
+Terminology
+===========
+
+Virtual Port
+        A Virtual Port refers to the Software View of an Ethernet MAC Port.
+        There are two types of Virtual Ports:
+        1. Virtual MAC Only Port
+        2. Virtual Switch Port
+
+Virtual MAC Only Port
+        A Virtual MAC only Port refers to a dedicated physical MAC Port for
+        a Client. This corresponds to MAC Mode of operation in Ethernet
+        Terminology. All traffic sent to or received from the Physical
+        MAC Port is that of the Client to which the Virtual MAC Only Port
+        has been allocated.
+
+Virtual Switch Port
+        A Virtual Switch Port refers to a group of physical MAC ports with
+        Switching enabled across them. This implies that any traffic sent
+        to the Port from a Client could potentially exit a Physical MAC
+        Port along with the traffic from other Clients. Similarly, the traffic
+        received on the Port by a Client could have potentially ingressed
+        on a Physical MAC Port along with the traffic meant for other Clients.
+        While the ALE (Address Lookup Engine) handles segregating the traffic,
+        and the CPSW Ethernet Switch places traffic on dedicated RX DMA Flows
+        meant for a single Client, it is worth noting that the bandwidths
+        of the Physical MAC Port are shared by Clients when traffic is sent to
+        or received from a Virtual Switch Port.
+
+Network Interface
+        The user-visible interface in Linux userspace exposed to applications
+        that serves as the entry/exit point for traffic to/from the Virtual
+        Ports. A single network interface (ethX) maps to either a Virtual
+        MAC Only Port or a Virtual Switch Port.
+
+C2S
+        RPMsg source is Client and destination is Server.
+
+S2C
+        RPMsg source is Server and destination is Client.
+
+Initialization Sequence
+=======================
+
+The sequence of message exchanges between the Client driver and EthFw starting
+from the driver probe and ending with the interfaces being brought up is as
+follows:
+1. C2S ETHFW_VIRT_PORT_INFO requesting details of Virtual Ports available
+   for the Linux Client.
+2. S2C response containing requested details
+3. C2S ETHFW_VIRT_PORT_ATTACH request for each Virtual Port allocated during
+   step 2.
+4. S2C response containing details of the MTU Size, number of Tx DMA Channels
+   and RX DMA Flows for the specified Virtual Port. The *Features* associated
+   with the Virtual Port are also shared such as Multicast Filtering capability.
+5. C2S ETHFW_ALLOC_RX request for each RX DMA Flow for a Virtual Port.
+6. S2C response containing details of the RX PSI-L Thread ID, Flow base and
+   Flow offset.
+7. C2S ETHFW_ALLOC_TX request for each TX DMA Channel for a Virtual Port.
+8. S2C response containing details of the TX PSI-L Thread ID.
+9. C2S ETHFW_ALLOC_MAC request for each Virtual Port.
+10. S2C response containing the MAC Address corresponding to the Virtual Port.
+11. C2S ETHFW_MAC_REGISTER request for each Virtual Port with the MAC Address
+    allocated in step 10. This is necessary to steer packets that ingress on
+    the MAC Ports of CPSW onto the RX DMA Flow for the Virtual Port in order
+    to allow the Client to receive the packets.
+12. S2C response indicating status of request.
+13. C2S ETHFW_IPv4_REGISTER request *only* for Virtual Switch Port interface.
+    The IPv4 address assigned to the "ethX" network interface in Linux
+    corresponding to the Virtual Switch Port interface has to be registered
+    with EthFw. This is due to the reason that all Broadcast requests including
+    ARP requests received by the MAC Ports corresponding to the Virtual Switch
+    Port are consumed solely be EthFw. Such traffic is sent to Clients by
+    alternate methods. Therefore EthFw needs to know the IPv4 address for the
+    "ethX" network interface in Linux in order to automatically respond to
+    ARP requests, thereby enabling Unicast communication.
+14. S2C response indicating status of request.
+15. C2S ETHFW_MCAST_FILTER_ADD request to register the Multicast Addresses
+    associated with the network interface corresponding to the Virtual Port
+    which has the Multicast Filtering capability.
+16. S2C response indicating status of request.
+17. C2S ETHFW_MCAST_FILTER_DEL request to deregister the Multicast Addresses
+    associated with the network interface corresponding to the Virtual Port
+    which has the Multicast Filtering capability.
+18. S2C response indicating status of request.
+
+Shutdown Sequence
+=================
+
+The sequence of message exchanges between the Client driver and EthFw on module
+removal are as follows:
+1. C2S ETHFW_MAC_DEREGISTER request to deregister the MAC Address for each
+   Virtual Port.
+2. S2C response indicating status of request.
+3. C2S ETHFW_MCAST_FILTER_DEL request to deregister the Multicast Addresses
+   associated with the network interface corresponding to the Virtual Port
+   which has the Multicast Filtering capability.
+4. S2C response indicating status of request.
+5. C2S ETHFW_FREE_MAC request to release the MAC Address allocated to each
+   Virtual Port.
+6. S2C response indicating status of request.
+7. C2S ETHFW_FREE_TX request to release the TX DMA Channel for each TX Channel
+   for every Virtual Port.
+8. S2C response indicating status of request.
+9. C2S ETHFW_FREE_RX request to release the RX DMA Flow for each RX Channel
+   for every Virtual Port.
+10. S2C response indicating status of request.
+11. C2S ETHFW_VIRT_PORT_DETACH request to release each Virtual Port.
+12. S2C response indicating status of request.
+
+Features Supported
+==================
+
+The set of features supported in addition to providing basic Ethernet
+Functionality are:
+1. Multicast Filtering
+2. Determining Link Status of the network interface corresponding to the
+   Virtual MAC Only port via ethtool.
+3. Interrupt Pacing/Coalescing
-- 
2.40.1


