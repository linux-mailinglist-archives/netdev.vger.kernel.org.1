Return-Path: <netdev+bounces-13022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479F739E54
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1892818F0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01051C766;
	Thu, 22 Jun 2023 10:19:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A71C75E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:19:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983CA10A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 03:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTafQhERILi6uYFwb7zrzB+/Z43c/0CMJD27YqhIb3xZ1LSZXhDZI8sf4J0NI8HM6GEbxXF2sI1puq1NF6wYIhFNFAXB0an5W9T9QzM6XA25IfPkdkSIfQS3d83Y30s3s0FOGkZLel76dsCjaj5+VkAJY3IyhAsuga5uZSyftMJDgKr8t6Mv/wYGjhAs07PyJunzl2QGpFnfU/l3oZ0N0cikOi2vIn0TP21E1FKFWGyB49QurfUjB0e/2jCgsC2Os9XMJLMhrbyta1NBe7POJeQSRNMgyKXOa4dMeI3kynZUFXCmeAZD/Fo3FbcXuZy5aCcJ4s195eBCP2zoVNpHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en0CbAXcXPCyOIyiMEXpohMeeXF8XZ5uGJuwBcfit/w=;
 b=R/2kCDiJBElzsitdUBijNzwRj3LpU0XIa9BkZSlJw31kE0nsR0M/76Vrq164cHkVYIx86zT8uwwoUUe9jYdg4ujgsGV5gLwg5Q+oRZZ4T2NIYms6cCVO59rpUsQb4LvjVkNXqXLtSMx/+gkgyEKBk39QhK26honYIGFF7mit9Ob8/wjzeBOwFAssK3g8LqOJk/Q3144ZO0QOa93YFNUWk2DTVh7m85+M7m+3y8ngg7bJ9qB887oppMNHIM1kZ0kOj02PRXqTKhzBQ7QMq/ugtxb4+yFNukxzV80pDD122YyjPF8/xs61uBS6lygbsWVGK6JoZdChsWCinO/eYCTGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en0CbAXcXPCyOIyiMEXpohMeeXF8XZ5uGJuwBcfit/w=;
 b=ZjYbyvFidpiIvhg0tav5MF3PFSrU+dgbNvqM1WtMbbKghPqAsxMXY+6Y8ZRtCm0WRKQLGPqZrdC7EsmHmH50JZOrtjuV6xLnD5ouoJ9RuLH1KVAhC7IJHfIebLmD7bR6wwnGJh9oC9btvpe0JL+FNhmFKgBWbOcnleMwsuMOw6Y=
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 10:19:53 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::e6) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 10:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.3 via Frontend Transport; Thu, 22 Jun 2023 10:19:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 05:19:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 03:19:51 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 05:19:50 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <arnd@arndb.de>, Edward Cree <ecree.xilinx@gmail.com>,
	<netdev@vger.kernel.org>, <habetsm.xilinx@gmail.com>
Subject: [PATCH net-next 1/3] sfc: use padding to fix alignment in loopback test
Date: Thu, 22 Jun 2023 11:18:56 +0100
Message-ID: <441f4c197394bdeddb47aefa0bc854ee1960df27.1687427930.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH2PR12MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: b111e59a-711b-4924-67e4-08db730a3804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tcd7P1BDqIkXIOUMWHGE1bGxCd5+6FKAYsUaOThUFX8baFQ2y22L+pAHGw8MBrkAaRvaI5LksXvagIOw2KurcWmFVRk/OeCJEcDydHxeJNcMp+g5KsPwhjD8Bil0cblTkqAOfTAcC/+nPbxG5KQgshBGy1FrKpQQwErzLf05/x2SqLqrx/krLNhvaIz8OKGQXaKLkjF/c/BnWHzls+KbNrDaF/lhO4NuoihlLVWzdSCpG1ZT8+q0PeNGy3aI0Vopq+ipZboKVqpVffjMUx2JPTkiLvp+djgYLDyFKwvnSQUoKZ3lKXPeaeOQHzLquVftZLOwscbKCbx4KGudZcsnokAbPcoLCRkU6E90lqwe25gBiX8PfvezbAGDpEf05B0qvW8bN56cKsrIOHY/4MsnSi5NQhFre4ipAUHCn5lDGpCeFQUcHowNGTJQ9m25tzx793ZAjR5BpZz5JxXzEmoiz09dMpQzWtxufwie5WghuVq2A7TYmjkx+Bh9EK5EJaLURsXxgV1fwS3ADYFgMEjB978ll9XjrwETtMSaoAxQK6t7GqcBZZZ8OiX9407W/FX7R3n/fj4Ns/kXNoygUF+nX4gjitcYuA5kDqu+xla3ja50WIIwk8j0mrovTC6Rzj0IhV9Qpdgl2oueHq2FnZIza1aWGAF8I6eowfFtoBj5RCUPQyMGuiKtqC/lDi+okCcbSRkJqzJ+HDAez2CaeSCaXGuiAUF0PVVg0TYUWRpLgu3hVsovQze1GeUjVJhRAUKx93vOZznPZk77pOaymqWrGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(110136005)(478600001)(4326008)(186003)(26005)(9686003)(70586007)(2906002)(82310400005)(8936002)(70206006)(8676002)(41300700001)(5660300002)(316002)(356005)(82740400003)(81166007)(2876002)(86362001)(55446002)(36756003)(40480700001)(47076005)(426003)(336012)(83380400001)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 10:19:52.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b111e59a-711b-4924-67e4-08db730a3804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add two bytes of padding to the start of struct efx_loopback_payload,
 which are not sent on the wire.  This ensures the 'ip' member is
 4-byte aligned, preventing the following W=1 warning:
net/ethernet/sfc/selftest.c:46:15: error: field ip within 'struct efx_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]
        struct iphdr ip;

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/selftest.c | 45 +++++++++++++++++------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 3c5227afd497..74b42efe7267 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -42,12 +42,16 @@
  * Falcon only performs RSS on TCP/UDP packets.
  */
 struct efx_loopback_payload {
+	char pad[2]; /* Ensures ip is 4-byte aligned */
 	struct ethhdr header;
 	struct iphdr ip;
 	struct udphdr udp;
 	__be16 iteration;
 	char msg[64];
 } __packed;
+#define EFX_LOOPBACK_PAYLOAD_LEN	(sizeof(struct efx_loopback_payload) - \
+					 offsetof(struct efx_loopback_payload, \
+					 	  header))
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -282,7 +286,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 			    const char *buf_ptr, int pkt_len)
 {
 	struct efx_loopback_state *state = efx->loopback_selftest;
-	struct efx_loopback_payload *received;
+	struct efx_loopback_payload received;
 	struct efx_loopback_payload *payload;
 
 	BUG_ON(!buf_ptr);
@@ -293,13 +297,14 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 
 	payload = &state->payload;
 
-	received = (struct efx_loopback_payload *) buf_ptr;
-	received->ip.saddr = payload->ip.saddr;
+	memcpy(&received.header, buf_ptr,
+	       min_t(int, pkt_len, EFX_LOOPBACK_PAYLOAD_LEN));
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
@@ -307,7 +312,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that the ethernet header exists */
-	if (memcmp(&received->header, &payload->header, ETH_HLEN) != 0) {
+	if (memcmp(&received.header, &payload->header, ETH_HLEN) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw non-loopback RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -315,16 +320,16 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check packet length */
-	if (pkt_len != sizeof(*payload)) {
+	if (pkt_len != EFX_LOOPBACK_PAYLOAD_LEN) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw incorrect RX packet length %d (wanted %d) in "
-			  "%s loopback test\n", pkt_len, (int)sizeof(*payload),
-			  LOOPBACK_MODE(efx));
+			  "%s loopback test\n", pkt_len,
+			  (int)EFX_LOOPBACK_PAYLOAD_LEN, LOOPBACK_MODE(efx));
 		goto err;
 	}
 
 	/* Check that IP header matches */
-	if (memcmp(&received->ip, &payload->ip, sizeof(payload->ip)) != 0) {
+	if (memcmp(&received.ip, &payload->ip, sizeof(payload->ip)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted IP header in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -332,7 +337,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 	}
 
 	/* Check that msg and padding matches */
-	if (memcmp(&received->msg, &payload->msg, sizeof(received->msg)) != 0) {
+	if (memcmp(&received.msg, &payload->msg, sizeof(received.msg)) != 0) {
 		netif_err(efx, drv, efx->net_dev,
 			  "saw corrupted RX packet in %s loopback test\n",
 			  LOOPBACK_MODE(efx));
@@ -340,10 +345,10 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
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
@@ -363,7 +368,8 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload, sizeof(state->payload), 0);
+			       &state->payload.header, EFX_LOOPBACK_PAYLOAD_LEN,
+			       0);
 	}
 #endif
 	atomic_inc(&state->rx_bad);
@@ -385,14 +391,15 @@ static void efx_iterate_state(struct efx_nic *efx)
 	payload->ip.daddr = htonl(INADDR_LOOPBACK);
 	payload->ip.ihl = 5;
 	payload->ip.check = (__force __sum16) htons(0xdead);
-	payload->ip.tot_len = htons(sizeof(*payload) - sizeof(struct ethhdr));
+	payload->ip.tot_len = htons(sizeof(*payload) -
+				    offsetof(struct efx_loopback_payload, ip));
 	payload->ip.version = IPVERSION;
 	payload->ip.protocol = IPPROTO_UDP;
 
 	/* Initialise udp header */
 	payload->udp.source = 0;
-	payload->udp.len = htons(sizeof(*payload) - sizeof(struct ethhdr) -
-				 sizeof(struct iphdr));
+	payload->udp.len = htons(sizeof(*payload) -
+				 offsetof(struct efx_loopback_payload, udp));
 	payload->udp.check = 0;	/* checksum ignored */
 
 	/* Fill out payload */
@@ -418,7 +425,7 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 	for (i = 0; i < state->packet_count; i++) {
 		/* Allocate an skb, holding an extra reference for
 		 * transmit completion counting */
-		skb = alloc_skb(sizeof(state->payload), GFP_KERNEL);
+		skb = alloc_skb(EFX_LOOPBACK_PAYLOAD_LEN, GFP_KERNEL);
 		if (!skb)
 			return -ENOMEM;
 		state->skbs[i] = skb;
@@ -429,6 +436,8 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 		payload = skb_put(skb, sizeof(state->payload));
 		memcpy(payload, &state->payload, sizeof(state->payload));
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
+		/* Strip off the leading padding */
+		skb_pull(skb, offsetof(struct efx_loopback_payload, header));
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */

