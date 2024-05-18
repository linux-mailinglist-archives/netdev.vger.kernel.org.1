Return-Path: <netdev+bounces-97081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E38C90EB
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3011C213C1
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C860275;
	Sat, 18 May 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BuVbKCln"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880055769;
	Sat, 18 May 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036205; cv=none; b=YdQrJmj38KZNBPmFFLrvs2imM3Z/Z7yoeBd6IY3sLuyIp7zHv5dPRJWqwip5GXlj8KocmlgA0hsKOro1H9VAH+yV1mb628EBHV4oYqEqmvcCxV8UFJJrtxqdeLOqdMjSMkgmploHX/G8GUwBSAM8nI2sONuew8m9FphqGrlWfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036205; c=relaxed/simple;
	bh=WakF8jtak+0vhjK2bTssbvGciBkwho7oY9NxlB6Dk4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmayRKrJ2ZpOgbGdeeEqzOK10Q9J+U9RLAk2x/QSI0bXdZ95tx7aY1qdMExN4ghGoAh1EG5anGeGcwKnRwaJpqlkPuE9iNNV6BdcOXZDgh1LANcXxPBBBvq/HDvtP0O7JLJ5SioeCZM/NRopUuNTbfnNGM7IOFWbPGt9E2V3orI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BuVbKCln; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgwI7054945;
	Sat, 18 May 2024 07:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036178;
	bh=7W1O2S0BwQFiS8C4UlqWrhgt+Eb2BDTC/PMCiQH9kFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BuVbKClnYEFrQc+h+7tH2watQFyB6h9lJayLTQ2YRplfIRgnfSzPFHxj/7caPwJ0H
	 DT/LkpCGiEwfIaET38ypLFiPGLvHcIM/AV8Bxuj//OEAHjPfreilxLxrFL4Pb3/V2Z
	 CJ/4VNRcdYWcNPDCKUMBqN5yeba1XF7M4Hfl4Jvg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICgwvZ129183
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:42:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:42:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:42:57 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9K041511;
	Sat, 18 May 2024 07:42:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 04/28] net: ethernet: ti: cpsw-proxy-client: add support for creating requests
Date: Sat, 18 May 2024 18:12:10 +0530
Message-ID: <20240518124234.2671651-5-s-vadapalli@ti.com>
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

The CPSW Proxy Client driver exchanges various types of requests with EthFw
to achieve desired functionality. Add a function to create request messages
that can be sent to EthFw over RPMsg-Bus, given the type of the request
message and additional parameters required to form the message.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 140 ++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 91d3338b3788..3533f4ce1e3f 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -5,12 +5,29 @@
  *
  */
 
+#include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 
 #include "ethfw_abi.h"
 
+struct cpsw_proxy_req_params {
+	struct message	req_msg;	/* Request message to be filled */
+	u32		token;
+	u32		client_id;
+	u32		request_id;
+	u32		request_type;
+	u32		rx_tx_idx; /* RX or TX Channel index */
+	u32		rx_flow_base; /* RX DMA Flow base */
+	u32		rx_flow_offset; /* RX DMA Flow offset */
+	u32		tx_thread_id; /* PSI-L Thread ID of TX Channel */
+	u32		port_id; /* Virtual Port ID */
+	u16		vlan_id;
+	u8		mac_addr[ETH_ALEN];
+	u8		ipv4_addr[ETHFW_IPV4ADDRLEN];
+};
+
 struct cpsw_proxy_priv {
 	struct rpmsg_device		*rpdev;
 	struct device			*dev;
@@ -26,6 +43,129 @@ static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
 	return 0;
 }
 
+static int create_request_message(struct cpsw_proxy_req_params *req_params)
+{
+	struct mac_register_deregister_request *mac_reg_dereg_req;
+	struct ipv4_deregister_request *ipv4_dereg_req;
+	struct common_request_message *common_req_msg;
+	struct tx_thread_release_request *tx_free_req;
+	struct tx_thread_alloc_request *tx_alloc_req;
+	struct add_multicast_request *mcast_add_req;
+	struct del_multicast_request *mcast_del_req;
+	struct rx_flow_release_request *rx_free_req;
+	struct ipv4_register_request *ipv4_reg_req;
+	struct request_message_header *req_msg_hdr;
+	struct rx_flow_alloc_request *rx_alloc_req;
+	struct message *msg = &req_params->req_msg;
+	struct mac_release_request *mac_free_req;
+	struct attach_request *attach_req;
+	u32 req_type;
+
+	/* Set message header fields */
+	msg->msg_hdr.token = req_params->token;
+	msg->msg_hdr.client_id = req_params->client_id;
+	msg->msg_hdr.msg_type = ETHFW_MSG_REQUEST;
+
+	req_type = req_params->request_type;
+
+	switch (req_type) {
+	case ETHFW_ALLOC_RX:
+		rx_alloc_req = (struct rx_flow_alloc_request *)msg;
+		req_msg_hdr = &rx_alloc_req->request_msg_hdr;
+		rx_alloc_req->rx_flow_idx = req_params->rx_tx_idx;
+		break;
+
+	case ETHFW_ALLOC_TX:
+		tx_alloc_req = (struct tx_thread_alloc_request *)msg;
+		req_msg_hdr = &tx_alloc_req->request_msg_hdr;
+		tx_alloc_req->tx_chan_idx = req_params->rx_tx_idx;
+		break;
+
+	case ETHFW_VIRT_PORT_ATTACH:
+		attach_req = (struct attach_request *)msg;
+		req_msg_hdr = &attach_req->request_msg_hdr;
+		attach_req->virt_port = req_params->port_id;
+		break;
+
+	case ETHFW_FREE_MAC:
+		mac_free_req = (struct mac_release_request *)msg;
+		req_msg_hdr = &mac_free_req->request_msg_hdr;
+		ether_addr_copy(mac_free_req->mac_addr, req_params->mac_addr);
+		break;
+
+	case ETHFW_FREE_RX:
+		rx_free_req = (struct rx_flow_release_request *)msg;
+		req_msg_hdr = &rx_free_req->request_msg_hdr;
+		rx_free_req->rx_flow_idx_base = req_params->rx_flow_base;
+		rx_free_req->rx_flow_idx_offset = req_params->rx_flow_offset;
+		break;
+
+	case ETHFW_FREE_TX:
+		tx_free_req = (struct tx_thread_release_request *)msg;
+		req_msg_hdr = &tx_free_req->request_msg_hdr;
+		tx_free_req->tx_psil_dest_id = req_params->tx_thread_id;
+		break;
+
+	case ETHFW_IPv4_DEREGISTER:
+		ipv4_dereg_req = (struct ipv4_deregister_request *)msg;
+		req_msg_hdr = &ipv4_dereg_req->request_msg_hdr;
+		memcpy(&ipv4_dereg_req->ipv4_addr, req_params->ipv4_addr,
+		       ETHFW_IPV4ADDRLEN);
+		break;
+
+	case ETHFW_IPv4_REGISTER:
+		ipv4_reg_req = (struct ipv4_register_request *)msg;
+		req_msg_hdr = &ipv4_reg_req->request_msg_hdr;
+		memcpy(&ipv4_reg_req->ipv4_addr, req_params->ipv4_addr,
+		       ETHFW_IPV4ADDRLEN);
+		ether_addr_copy(ipv4_reg_req->mac_addr,
+				req_params->mac_addr);
+		break;
+
+	case ETHFW_MAC_DEREGISTER:
+	case ETHFW_MAC_REGISTER:
+		mac_reg_dereg_req = (struct mac_register_deregister_request *)msg;
+		req_msg_hdr = &mac_reg_dereg_req->request_msg_hdr;
+		ether_addr_copy(mac_reg_dereg_req->mac_addr,
+				req_params->mac_addr);
+		mac_reg_dereg_req->rx_flow_idx_base = req_params->rx_flow_base;
+		mac_reg_dereg_req->rx_flow_idx_offset = req_params->rx_flow_offset;
+		break;
+
+	case ETHFW_MCAST_FILTER_ADD:
+		mcast_add_req = (struct add_multicast_request *)msg;
+		req_msg_hdr = &mcast_add_req->request_msg_hdr;
+		ether_addr_copy(mcast_add_req->mac_addr, req_params->mac_addr);
+		mcast_add_req->vlan_id = req_params->vlan_id;
+		mcast_add_req->rx_flow_idx_base = req_params->rx_flow_base;
+		mcast_add_req->rx_flow_idx_offset = req_params->rx_flow_offset;
+		break;
+
+	case ETHFW_MCAST_FILTER_DEL:
+		mcast_del_req = (struct del_multicast_request *)msg;
+		req_msg_hdr = &mcast_del_req->request_msg_hdr;
+		ether_addr_copy(mcast_del_req->mac_addr, req_params->mac_addr);
+		mcast_del_req->vlan_id = req_params->vlan_id;
+		break;
+
+	case ETHFW_ALLOC_MAC:
+	case ETHFW_VIRT_PORT_DETACH:
+	case ETHFW_VIRT_PORT_INFO:
+		common_req_msg = (struct common_request_message *)msg;
+		req_msg_hdr = &common_req_msg->request_msg_hdr;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/* Set request message header fields */
+	req_msg_hdr->request_id = req_params->request_id;
+	req_msg_hdr->request_type = req_params->request_type;
+
+	return 0;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


