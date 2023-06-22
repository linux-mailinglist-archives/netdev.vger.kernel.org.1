Return-Path: <netdev+bounces-13024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB1739E67
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A081C21081
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB331DDCC;
	Thu, 22 Jun 2023 10:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366E01C75E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:20:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D0107
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K++vRNVksoUv9VRNYC1fyuFx5mj+fTSGA369YpiZYB6mWcdIZ/nE+9vJRbx62tFhkJzJPUjzfrnjbSRAxQA6q3EAy6+4Z4UX4dTd1jdF3VJv7c3eOoqXRJB65OvuAhCPlEPN6eJL/jIsLUsNR+FIIL4DAZKp5mI6uYSaTaJ7+G4y3Xm7t7uhRw7B0mQQKHVR1XxKsjd8xqJzTeCR/ZRJ7CtzoL//Et7JV81sjGvuTM+koIv78M5NEdqorMMLjZWwktqVBqWZQV2HUGzAXuya7lpZyWk77rQ3PONqt7uWzdrXfX9bfEoF7z6yYIx6XdL8MPfNKutFiOrPlERPQx1pYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxU0Rz1DHYpaz2WtW3jE6AVBtvHwiy10XHSM59u5S/I=;
 b=WbwB1PBNNi1gyxzBkkZ7WA9yLY0TVRx+4uOkXxvKEYCnnjOsl4zYIzqi2d0XlU6NXbYo0B8aEE4xQoEXBggLEbaUefhR0yAopNirp2GdEjF28DvDzPrSjPnNa0HVGGUubtP/qefkDcFLG2DQP7QIW0Qh1r7ynltGjiR1/1Q4cCMhQdauVwNkqG+LnqITUFFuG3qYBwAsu55kop0M7khKx97JI3IMQGOCrSGzRbHgacXoEEt6qkNKDETqGxkcGv/JNc4pUGau1w4Eszmg5b9LT537itGz7WhhIougDkWMMSPR4VWLXNmSbbDFPAoFIlm0FtB0Jm4w5NOMVid6tn8ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxU0Rz1DHYpaz2WtW3jE6AVBtvHwiy10XHSM59u5S/I=;
 b=IHxJPQ22Gkpqe4YoNcy4mYtIiahfvPrd6qhEDmD+2Ipz4OlwJxEuILHSwp9O2vxSpYsC4G8wPjNynPqleU0kPX08jh8gMdPRzt63pcfTSpAod0JgT8SMUXN6Z9Hct9M9+9+7m+QUx6BqnjvTxTug2U8+pwoG7NHV9xHdSTpCALY=
Received: from BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) by
 DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 10:19:56 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:94:cafe::52) by BYAPR01CA0048.outlook.office365.com
 (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 10:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 10:19:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 05:19:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 05:19:54 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 05:19:53 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <arnd@arndb.de>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 3/3] sfc: falcon: use padding to fix alignment in loopback test
Date: Thu, 22 Jun 2023 11:18:58 +0100
Message-ID: <5d8ac654310dd65065bd520f3258bb05b4ba411b.1687427930.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1687427930.git.ecree.xilinx@gmail.com>
References: <cover.1687427930.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7809c1-1a84-4901-def1-08db730a3992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	84oIr8XU9GTAbZjhFcEHfPf//zQ6nVx3TqRic0v+fqV+QMsKDDw9OpCA7Twrf1jdCTowvb5KeRDifaZGCi2aFF4+QAv8QkV2lq/UP9l8fy81/ObY7GBkdWdGUL8101217nYtD3W4QjGHFRJ403zNtaSkV19CAar0tj3YzjTYq35zFeRo52JtkmqsguGhdlEGxnmRVIOkeF72xBSR5p0ESBVG8R0d1eg2a/+c3zF+BHrolgC/zLEbIjJcIc1L37I+YJTFtxmhwf5O18z4p8c/dq0sXbNUOYRTJzieusIpKF7o84oSi16msl5d0Ne0VPfR3LxkTfBQPud/5WNwdfnzYwGPAkiQd+Xmr9zqMAAeCyuSdzUmBUZDOeuhfd9Ks1k3zAGaEPxIR9OrYkY+t9jJCYF3bekRgogacLdYLAdsWQ/8oLhSR2FSea3JF4fOSOq6n+hmJGOCbKL0P0WRqySIgjfY8FcvP6qQ6et/RA+Gomy/sNeqYJPnLLeHJHsg8FA+IIZ9SQiPCI1Pf0glQEZBnbHz1AHcRCT8yACQmjyxMj0QfV3LPWaZZV7LW9TamaoIxJqyhYAKu3ialHHGwMXdtroiVz26rbJxDVBLybfA/dbVx/5rwjPdwQSrUa6hN5SpjgVf+hnIQKrp/woPPBVOV7zQ7vjE7nyOSxMCQ4G4mnqtyREkL3H/OFb3yuX4lfT0XDjVj+Pu1tXmisYVZ2TeeyQLnKEBecBxsm0DuOwi+/Cxci26puSRhlFdhe+ApWCrZAONwXxLsylJL8EQrGt3YA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(4326008)(316002)(8676002)(8936002)(41300700001)(9686003)(26005)(186003)(54906003)(110136005)(40460700003)(426003)(336012)(2876002)(82310400005)(2906002)(5660300002)(478600001)(40480700001)(81166007)(356005)(82740400003)(47076005)(55446002)(36860700001)(83380400001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:19:55.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7809c1-1a84-4901-def1-08db730a3992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add two bytes of padding to the start of struct ef4_loopback_payload,
 which are not sent on the wire.  This ensures the 'ip' member is
 4-byte aligned, preventing the following W=1 warning:
net/ethernet/sfc/falcon/selftest.c:43:15: error: field ip within 'struct ef4_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/selftest.c | 45 +++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index 6a454ac6f876..5fa3e745a525 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -39,12 +39,16 @@
  * Falcon only performs RSS on TCP/UDP packets.
  */
 struct ef4_loopback_payload {
+	char pad[2]; /* Ensures ip is 4-byte aligned */
 	struct ethhdr header;
 	struct iphdr ip;
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
 } __packed;
+#define EF4_LOOPBACK_PAYLOAD_LEN	(sizeof(struct ef4_loopback_payload) - \
+					 offsetof(struct ef4_loopback_payload, \
+					 	  header))
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -284,7 +288,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 			    const char *buf_ptr, int pkt_len)
 {
 	struct ef4_loopback_state *state = efx->loopback_selftest;
-	struct ef4_loopback_payload *received;
+	struct ef4_loopback_payload received;
 	struct ef4_loopback_payload *payload;
 
 	BUG_ON(!buf_ptr);
@@ -295,13 +299,14 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 
 	payload = &state->payload;
 
-	received = (struct ef4_loopback_payload *) buf_ptr;
-	received->ip.saddr = payload->ip.saddr;
+	memcpy(&received.header, buf_ptr,
+	       min_t(int, pkt_len, EF4_LOOPBACK_PAYLOAD_LEN));
+	received.ip.saddr = payload->ip.saddr;
 	if (state->offload_csum)
-		received->ip.check = payload->ip.check;
+		received.ip.check = payload->ip.check;
 
 	/* Check that header exists */
-	if (pkt_len < sizeof(received->header)) {
+	if (pkt_len < sizeof(received.header)) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw runt RX packet (length %d) in %s loopback "
 			  "test\n", pkt_len, LOOPBACK_MODE(efx));
@@ -309,7 +314,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check that the ethernet header exists */
-	if (memcmp(&received->header, &payload->header, ETH_HLEN) != 0) {
+	if (memcmp(&received.header, &payload->header, ETH_HLEN) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw non-loopback RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -317,16 +322,16 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check packet length */
-	if (pkt_len != sizeof(*payload)) {
+	if (pkt_len != EF4_LOOPBACK_PAYLOAD_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw incorrect RX packet length %d (wanted %d) in "
-			  "%s loopback test\n", pkt_len, (int)sizeof(*payload),
-			  LOOPBACK_MODE(efx));
+			  "%s loopback test\n", pkt_len,
+			  (int)EF4_LOOPBACK_PAYLOAD_LEN, LOOPBACK_MODE(efx));
 		goto err;
 	}
 
 	/* Check that IP header matches */
-	if (memcmp(&received->ip, &payload->ip, sizeof(payload->ip)) != 0) {
+	if (memcmp(&received.ip, &payload->ip, sizeof(payload->ip)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted IP header in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -334,7 +339,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check that msg and padding matches */
-	if (memcmp(&received->msg, &payload->msg, sizeof(received->msg)) != 0) {
+	if (memcmp(&received.msg, &payload->msg, sizeof(received.msg)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -342,10 +347,10 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 	}
 
 	/* Check that iteration matches */
-	if (received->iteration != payload->iteration) {
+	if (received.iteration != payload->iteration) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw RX packet from iteration %d (wanted %d) in "
-			  "%s loopback test\n", ntohs(received->iteration),
+			  "%s loopback test\n", ntohs(received.iteration),
 			  ntohs(payload->iteration), LOOPBACK_MODE(efx));
 		goto err;
 	}
@@ -365,7 +370,8 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload, sizeof(state->payload), 0);
+			       &state->payload.header, EF4_LOOPBACK_PAYLOAD_LEN,
+			       0);
 	}
 #endif
 	atomic_inc(&state->rx_bad);
@@ -387,14 +393,15 @@ static void ef4_iterate_state(struct ef4_nic *efx)
 	payload->ip.daddr = htonl(INADDR_LOOPBACK);
 	payload->ip.ihl = 5;
 	payload->ip.check = (__force __sum16) htons(0xdead);
-	payload->ip.tot_len = htons(sizeof(*payload) - sizeof(struct ethhdr));
+	payload->ip.tot_len = htons(sizeof(*payload) -
+				    offsetof(struct ef4_loopback_payload, ip));
 	payload->ip.version = IPVERSION;
 	payload->ip.protocol = IPPROTO_UDP;
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) - sizeof(struct ethhdr) -
-				 sizeof(struct iphdr));
+	payload->udp.len = htons(sizeof(*payload) -
+				 offsetof(struct ef4_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
@@ -420,7 +427,7 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
+		skb = alloc_skb(EF4_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
@@ -431,6 +438,8 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 		payload = skb_put(skb, sizeof(state->payload));
 		memcpy(payload, &state->payload, sizeof(state->payload));
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
+		/* Strip off the leading padding */
+		skb_pull(skb, offsetof(struct ef4_loopback_payload, header));
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */

