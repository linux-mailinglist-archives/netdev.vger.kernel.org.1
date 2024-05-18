Return-Path: <netdev+bounces-97077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B068C90DF
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6481282CEA
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC6539FEF;
	Sat, 18 May 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jm4ei7Tz"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724245014;
	Sat, 18 May 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036198; cv=none; b=FTVY0nm2sbYarI8MlS19iOYYMOSxV270Zq1YrRN+Te2R8wTwbpiglXJMtjEt1u83PO5PcaPHhMgKkshVl/uHT9/TljYi+fTJFstcdsvvCZJGAF9tYtbftGjs7NOgV7OddZf59FEMP2JlF6QWhGE4WtIkDBCVgu5smzMgnlxsV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036198; c=relaxed/simple;
	bh=DEiNmpaVe3g+0xYtypFrg2vqcEb12rAGEvLjdXjUnjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ljto0o4ovEUudQFRa8Bwr9lPni5G5Og1P8lpHzrPIbYcqdSVt74MzQqLONM7IWAWaT35mLApdv5u+ACMkSq437/jX61U3rQjc+s+kO0pSYygYyu2FJ4tabRzVsvk/A/BbZO9jw2I5BSKBz0IcritlvIw7C7M+b+coCns6KeHIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jm4ei7Tz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgmw8110041;
	Sat, 18 May 2024 07:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036168;
	bh=UovvYxLe8eCCdaaAFq+U+PihUBOQSK8yJAiea02CXrg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jm4ei7Tz9gUDGDH8692Bz759toPMOy4crOZBXbe0SB6Qd29HNEIu5uYRtcHGBm3Db
	 FxLHIPMTzKgy38dYE2qPeBmoGnPbvpkMwJCbdo+83fLQmgJ6R5rbnVkLxN6H1P6zIR
	 5TMwF9FbzsKqAnMC3oLR4nZ8iQaBDxwElESiG6+M=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICgmRt017010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:42:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:42:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:42:48 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9I041511;
	Sat, 18 May 2024 07:42:44 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 02/28] net: ethernet: ti: add RPMsg structures for Ethernet Switch Firmware
Date: Sat, 18 May 2024 18:12:08 +0530
Message-ID: <20240518124234.2671651-3-s-vadapalli@ti.com>
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

The Ethernet Switch Firmware (EthFw) running on the remote MAIN R5 core is
capable of configuring the CPSWnG instance of TI's CPSW Ethernet Switch
on various TI SoCs such as J721E, J7200 and J784S4. EthFw is in complete
control of CPSWnG and acts as a server which allocates and provides the
resources to clients on different cores. All communication between EthFw
and the clients occurs via RPMsg.

Define the message structures used to communicate with EthFw. This shall
enable the Linux Client to avail the services provided by EthFw.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/ethfw_abi.h | 370 ++++++++++++++++++++++++++++
 1 file changed, 370 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/ethfw_abi.h

diff --git a/drivers/net/ethernet/ti/ethfw_abi.h b/drivers/net/ethernet/ti/ethfw_abi.h
new file mode 100644
index 000000000000..a857e920445b
--- /dev/null
+++ b/drivers/net/ethernet/ti/ethfw_abi.h
@@ -0,0 +1,370 @@
+/* SPDX-License-Identifier: GPL-2.0-only or MIT */
+/* Texas Instruments Ethernet Switch Firmware (EthFw) ABIs
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#ifndef __ETHFW_ABI_H_
+#define __ETHFW_ABI_H_
+
+/* Name of the RPMsg Endpoint announced by EthFw on the RPMsg-Bus */
+#define ETHFW_SERVICE_EP_NAME	"ti.ethfw.ethdevice"
+
+/* Response status set by EthFw on the Success of a Request */
+#define ETHFW_RES_OK			(0)
+
+/* Response status set by EthFw notifying the Client to retry a Request */
+#define ETHFW_RES_TRY_AGAIN		(-1)
+
+/* Default VLAN ID for a Virtual Port */
+#define ETHFW_DFLT_VLAN			0xFFFF
+
+/* EthFw TX Checksum Offload Capability */
+#define ETHFW_TX_CSUM_OFFLOAD		BIT(0)
+
+/* EthFw Multicast Filtering Capability */
+#define ETHFW_MCAST_FILTERING		BIT(3)
+
+/* Token corresponding to the Linux CPSW Proxy Client assigned by EthFw */
+#define ETHFW_LINUX_CLIENT_TOKEN	3
+
+/* Default token used by Virtual Port to communicate with EthFw */
+#define ETHFW_TOKEN_NONE		0xFFFFFFFF
+
+/* MAC Address length in octets */
+#define ETHFW_MACADDRLEN		6
+
+/* IPV4 Address length in octets */
+#define ETHFW_IPV4ADDRLEN		4
+
+/* Types of request messages sent to EthFw from CPSW Proxy Client */
+enum request_msg_type {
+	/* Request details of Virtual Ports allocated to the Client.
+	 * Two types of Virtual Ports exist:
+	 * 1. MAC Only Port:
+	 *    The Physical MAC Port corresponding to this type of Virtual
+	 *    Port does not belong to the group of MAC Ports which Switch
+	 *    traffic among themselves. The Physical MAC Port is dedicated
+	 *    solely to the Client which has been allocated this type of
+	 *    Virtual Port.
+	 *
+	 * 2. Switch Port:
+	 *    The Physical MAC Port corresponding to this type of Virtual
+	 *    Port belongs to the group of MAC Ports which Switch traffic
+	 *    among themselves. The Physical MAC Port is shared with other
+	 *    Clients in terms of the traffic that is sent out of or received
+	 *    on this port.
+	 *
+	 * EthFw responds to this request by providing a bitmask of the
+	 * Virtual Port IDs for each type of Virtual Port allocated to
+	 * the Client.
+	 */
+	ETHFW_VIRT_PORT_INFO,
+
+	/* Request usage of a Virtual Port that has been allocated to the
+	 * Client.
+	 *
+	 * EthFw responds with details of the supported MTU size, the number
+	 * of TX DMA Channels and the number of RX DMA Flows for the specified
+	 * Virtual Port.
+	 */
+	ETHFW_VIRT_PORT_ATTACH,
+
+	/* Request disuse of a Virtual Port that was in use prior to the
+	 * generation of this request.
+	 */
+	ETHFW_VIRT_PORT_DETACH,
+
+	/* Request for allocation of a TX DMA Channel for a Virtual Port.
+	 * Client can request as many TX DMA Channels as have been allocated
+	 * by EthFw for the specified Virtual Port.
+	 *
+	 * EthFw responds with the TX PSI-L Thread ID corresponding to
+	 * the TX DMA Channel for the Virtual Port to transmit traffic
+	 * to CPSW.
+	 */
+	ETHFW_ALLOC_TX,
+
+	/* Request for allocation of an RX DMA Flow for a Virtual Port.
+	 * Client can request as many RX DMA Flows as have been allocated
+	 * by EthFw for the specified Virtual Port.
+	 *
+	 * EthFw responds with the RX PSI-L Thread ID, the base of the RX
+	 * Flow index and the offset from the base of the allocated RX Flow
+	 * index. The RX Flow/Channel is used to receive traffic from CPSW.
+	 */
+	ETHFW_ALLOC_RX,
+
+	/* Request for allocation of the MAC Address for a Virtual Port.
+	 *
+	 * EthFw responds with the MAC Address corresponding to the
+	 * specified Virtual Port.
+	 */
+	ETHFW_ALLOC_MAC,
+
+	/* Request for release of a TX DMA Channel that had been allocated
+	 * to the specified Virtual Port.
+	 */
+	ETHFW_FREE_TX,
+
+	/* Request for release of an RX DMA Flow that had been allocated to
+	 * the specified Virtual Port.
+	 */
+	ETHFW_FREE_RX,
+
+	/* Request for release of the MAC Address that had been allocated to
+	 * the specified Virtual Port.
+	 */
+	ETHFW_FREE_MAC,
+
+	/* Request for usage of the specified MAC Address for the traffic
+	 * sent or received on the Virtual Port for which the MAC Address
+	 * has been allocated.
+	 */
+	ETHFW_MAC_REGISTER,
+
+	/* Request for disuse of the specified MAC Address for the traffic
+	 * sent or received on the Virtual Port for which the MAC Address
+	 * had been allocated.
+	 */
+	ETHFW_MAC_DEREGISTER,
+
+	/* Request for setting the default RX DMA Flow for a Virtual Port. */
+	ETHFW_SET_DEFAULT_RX_FLOW,
+
+	/* Request for deleting the default RX DMA Flow for a Virtual Port. */
+	ETHFW_DEL_DEFAULT_RX_FLOW,
+
+	/* Request for registering the IPv4 Address of the Network Interface
+	 * in Linux corresponding to the specified Virtual Port.
+	 */
+	ETHFW_IPv4_REGISTER,
+
+	/* Request for deregistering the IPv4 Address of the Network Interface
+	 * in Linux corresponding to the specified Virtual Port that had been
+	 * registered prior to this request.
+	 */
+	ETHFW_IPv4_DEREGISTER,
+
+	/* Request for joining a Multicast Address group */
+	ETHFW_MCAST_FILTER_ADD,
+
+	/* Request for leaving a Multicast Address group */
+	ETHFW_MCAST_FILTER_DEL,
+
+	/* Request to get link status */
+	ETHFW_VIRT_PORT_LINK_STATUS,
+};
+
+enum notify_msg_type {
+	ETHFW_NOTIFYCLIENT_FWINFO,
+	ETHFW_NOTIFYCLIENT_HWPUSH,
+	ETHFW_NOTIFYCLIENT_HWERROR,
+	ETHFW_NOTIFYCLIENT_RECOVERED,
+	ETHFW_NOTIFYCLIENT_CUSTOM,
+	ETHFW_NOTIFYCLIENT_LAST,
+};
+
+enum ethfw_status {
+	ETHFW_INIT,
+	ETHFW_RECOVERY,
+	ETHFW_DEINIT,
+};
+
+enum message_type {
+	ETHFW_MSG_REQUEST,
+	ETHFW_MSG_NOTIFY,
+	ETHFW_MSG_RESPONSE,
+};
+
+struct message_header {
+	u32 token;
+	u32 client_id;
+	u32 msg_type;
+} __packed;
+
+struct message {
+	struct message_header msg_hdr;
+	u32 message_data[120];
+} __packed;
+
+struct request_message_header {
+	struct message_header msg_hdr;
+	u32 request_type;
+	u32 request_id;
+} __packed;
+
+struct response_message_header {
+	struct message_header msg_hdr;
+	u32 response_type; /* Same as request_type */
+	u32 response_id;
+	int response_status;
+} __packed;
+
+struct notify_message_header {
+	struct message_header msg_hdr;
+	u32 notify_type;
+} __packed;
+
+struct common_response_message {
+	struct response_message_header response_msg_hdr;
+} __packed;
+
+struct common_request_message {
+	struct request_message_header request_msg_hdr;
+} __packed;
+
+struct common_notify_message {
+	struct notify_message_header notify_msg_hdr;
+} __packed;
+
+struct virt_port_info_response {
+	struct response_message_header response_msg_hdr;
+	/* Port mask denoting absolute virtual switch ports allocated */
+	u32 switch_port_mask;
+	/* Port mask denoting absolute virtual MAC ports allocated */
+	u32 mac_port_mask;
+} __packed;
+
+struct attach_request {
+	struct request_message_header request_msg_hdr;
+	/* Virtual port which needs core attach */
+	u32 virt_port;
+} __packed;
+
+struct attach_response {
+	struct response_message_header response_msg_hdr;
+	/* MTU of RX packet */
+	u32 rx_mtu;
+	/* MTU of TX packet */
+	u32 tx_mtu;
+	/* Feature bitmask */
+	u32 features;
+	/* Number of TX DMA Channels available for the virtual port */
+	u32 num_tx_chan;
+	/* Number of RX DMA Flows available for the virtual port */
+	u32 num_rx_flow;
+} __packed;
+
+struct rx_flow_alloc_request {
+	struct request_message_header request_msg_hdr;
+	/* Relative index of RX flow among available num_rx_flow flows */
+	u32 rx_flow_idx;
+} __packed;
+
+struct rx_flow_alloc_response {
+	struct response_message_header response_msg_hdr;
+	/* Allocated RX flow index base */
+	u32 rx_flow_idx_base;
+	/* Allocated flow index offset */
+	u32 rx_flow_idx_offset;
+	/* RX PSIL Peer source thread id */
+	u32 rx_psil_src_id;
+} __packed;
+
+struct tx_thread_alloc_request {
+	struct request_message_header request_msg_hdr;
+	/* Relative index of TX channel among available num_tx_chan channels */
+	u32 tx_chan_idx;
+} __packed;
+
+struct tx_thread_alloc_response {
+	struct response_message_header response_msg_hdr;
+	/* TX PSIL peer destination thread id which should be paired with the TX UDMA channel */
+	u32 tx_psil_dest_id;
+} __packed;
+
+struct mac_alloc_response {
+	struct response_message_header response_msg_hdr;
+	/* Allocated MAC address */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+} __packed;
+
+struct rx_flow_release_request {
+	struct request_message_header request_msg_hdr;
+	/* RX flow index base */
+	u32 rx_flow_idx_base;
+	/* RX flow index offset */
+	u32 rx_flow_idx_offset;
+} __packed;
+
+struct tx_thread_release_request {
+	struct request_message_header request_msg_hdr;
+	/* TX PSIL Peer destination thread id to be freed */
+	u32 tx_psil_dest_id;
+} __packed;
+
+struct mac_release_request {
+	struct request_message_header request_msg_hdr;
+	/* MAC address to be freed */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+} __packed;
+
+struct mac_register_deregister_request {
+	struct request_message_header request_msg_hdr;
+	/* MAC address which needs to be registered/deregistered */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+	/* RX flow index Base */
+	u32 rx_flow_idx_base;
+	/* RX flow index offset */
+	u32 rx_flow_idx_offset;
+} __packed;
+
+struct ipv4_register_request {
+	struct request_message_header request_msg_hdr;
+	/* IPv4 Address */
+	u8 ipv4_addr[ETHFW_IPV4ADDRLEN];
+	/* MAC address associated with the IP address which should be added to
+	 * the ARP table
+	 */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+} __packed;
+
+struct ipv4_deregister_request {
+	struct request_message_header request_msg_hdr;
+	/* IPv4 Address */
+	u8 ipv4_addr[ETHFW_IPV4ADDRLEN];
+} __packed;
+
+struct default_rx_flow_register_request {
+	struct request_message_header request_msg_hdr;
+	/* RX flow index Base */
+	u32 rx_flow_idx_base;
+	/* RX flow index offset */
+	u32 rx_flow_idx_offset;
+} __packed;
+
+struct port_link_status_response {
+	struct response_message_header response_msg_hdr;
+	/* Link status of the port */
+	bool link_up;
+	/* Link speed */
+	u32 speed;
+	/* Duplex mode */
+	u32 duplex;
+} __packed;
+
+struct add_multicast_request {
+	struct request_message_header request_msg_hdr;
+	/* Multicast MAC address to be added */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+	/* VLAN id */
+	u16 vlan_id;
+	/* RX flow index from which the MAC_address association will be added.
+	 * It's applicable only for _exclusive multicast traffic_
+	 */
+	u32 rx_flow_idx_base;
+	/* RX flow index offset */
+	u32 rx_flow_idx_offset;
+} __packed;
+
+struct del_multicast_request {
+	struct request_message_header request_msg_hdr;
+	/* Multicast MAC address to be added */
+	u8 mac_addr[ETHFW_MACADDRLEN];
+	/* VLAN id */
+	u16 vlan_id;
+} __packed;
+
+#endif /* __ETHFW_ABI_H_ */
-- 
2.40.1


