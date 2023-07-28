Return-Path: <netdev+bounces-22359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B0767297
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8845F1C20C3C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A915480;
	Fri, 28 Jul 2023 16:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122514AB2
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:56:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4573C27
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj8m37Zi7iR/anyq4sJU5Sw2Kq4pGHhM0Ow5lv38bO2qhPjc22TwfHj73I+PaLc4IjT6OomXEbmnhCx3EGpFUBTvuVsWfG80ysYUZ+McOwsJrPMAtz/bFSEEY+4r6PRnBtQn4kijGy1eF7vc5oDQhao8uiX8ckBdjj8q6iq108fpCwR74EoWjzUMDWyhIb3x9hfAIXwBY3I5OjeKYhL/leeuQe0Bt0JWa3/ANXBCDHGx6IIOE82mFx1z6y9BM4ntujHKjSLiOZoY4YswW8FagYCWCYiXohFrS/KkgR72qKEj1JWUPKn6BHyN4gMRE07Tau1d93KGD3ixEO70xXtWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+O2vE11+iezuTjfrPswlkk5fv/dGy6MNJHeCp8ERYU=;
 b=LBjDzbMl99/CEBbS2oTPFnaX0z+z6NOAQSKG+/+DwvHbtGOwXKBzcMNYUy7WiOE/dRL3p1dghHL7SUrdhbFvwQeJdFXVcVByhaXXc5oUhHSPwWR3nnY9PG2OxUo8/IPWcpKLLjYxxVxgXoshZy0MzWLwRno7W+sMWtgEwuX1gIdo7mdurKyhlhN+RDShDeay+53Wgfb2y2/hG6YaYHFIIWr5ED4jx6/qGBcEGZAsxMLfiA5U57KtPJxMtHJgwp88K4k8K/S7HebgFW5eApmpgB0ogjbCmswwADADr556Hs4IYrAgfDMFSfuxAOKs4gCNinxmUcA+C84JmTNB4a77Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+O2vE11+iezuTjfrPswlkk5fv/dGy6MNJHeCp8ERYU=;
 b=Mnt2jZDF1BYt1xrWeppRvEdv7BLIY+SXXp7BxRf3GyrhbYPCyQd0jFaxB5NTofwwGxq2t8/KEnSdFkCAAC49DrGqGv7BsS1Oz4+PZnw2M/OekNX/KdN4wunKJDeEBKAX1KLJbca7yAI22r3JaT8n1eIUlqAXTwKGkCDFMBZ/fT4=
Received: from SA0PR11CA0032.namprd11.prod.outlook.com (2603:10b6:806:d0::7)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:56:02 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::20) by SA0PR11CA0032.outlook.office365.com
 (2603:10b6:806:d0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 16:56:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:56:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 09:56:00 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 11:55:59 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Andy Moreton <andy.moreton@amd.com>
Subject: [PATCH net] sfc: fix field-spanning memcpy in selftest
Date: Fri, 28 Jul 2023 17:55:28 +0100
Message-ID: <20230728165528.59070-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: b40707c5-368f-4869-0fc3-08db8f8b861d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lOpvUUuNw/hFWUaDKx9EzdHhhf7Y2wxLlSq6GIXjcv8DuTtIwKpHybvJG4Zli3RJTY8K8HRTUJ8K9gwNHWdjphldf/Z5Yr5btx91VdXATRSZFtgAaWoirhvrXfz/ch3aeMmCw+43q2wQaxkx6jL+GiHCCHprjBOhs3V49F8aw2xUiTNgdOf+V5qic9WeB6JHidsiOScaixvM3Q0wm3JWDKV79SIKkzCp6DW/YiYlE9zXqpqCFOgUXrIKv8fj2nEJwv+zwbckrLwoCu48r7RkYDxW8HFYNcB8Gryd1V5JvI+fxCVLx1/9SNLrGus/iWEMmrVLI9JYHy7ev4BDlQnBR9p/IubfKHGc+Gp8QIn5HRgB3iH/4PVZidSvdAdF/jbpLde9WsLme4D1vkmapjn2yv35Pu47bSEJLsACRX4Tj/bLKCVMZj1X3Nj1dknc4B7jNg9gEjlWMGd7OHg90UUyfxB0kCK9wtPFZprbj/OGHy3YLzlA5Nj3mtnFUM+4iM55/GgRrXYmpW64t311tss/gFwzSxdeAEDaIPRq35VvOGWqCrwSblZLs9ytTeeRBAqfu9t76uDBrFhxxb/G2yDMeikHZG6cBLSHnet3apUsr8vGWaBn+Y2Z4XqoJsDPgR5JtSEdsF997UycbNmOtJGBxQRuSrg1cFEzGMCgb9X7tH02cbTmd9YPm50bJFi+668hFntKnlihZzRI8GkR/6VUdKGMVVhzySRZz/RxQp2avQRWZh/vL4nvZDAvyRdDuwMmaFAeoTnJ14MgLJNy2ESVmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2876002)(316002)(2906002)(8936002)(8676002)(5660300002)(41300700001)(40460700003)(86362001)(36756003)(40480700001)(336012)(426003)(6666004)(81166007)(478600001)(356005)(82740400003)(1076003)(26005)(186003)(54906003)(110136005)(2616005)(70206006)(36860700001)(83380400001)(70586007)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:56:01.5709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40707c5-368f-4869-0fc3-08db8f8b861d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add a struct_group for the whole packet body so we can copy it in one
 go without triggering FORTIFY_SOURCE complaints.

Fixes: cf60ed469629 ("sfc: use padding to fix alignment in loopback test")
Fixes: 30c24dd87f3f ("sfc: siena: use padding to fix alignment in loopback test")
Fixes: 1186c6b31ee1 ("sfc: falcon: use padding to fix alignment in loopback test")
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Tested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/selftest.c | 23 ++++++++++++----------
 drivers/net/ethernet/sfc/selftest.c        | 23 ++++++++++++----------
 drivers/net/ethernet/sfc/siena/selftest.c  | 23 ++++++++++++----------
 3 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index 9e5ce2a13787..cf1d67b6d86d 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -40,15 +40,16 @@
  */
 struct ef4_loopback_payload {
 	char pad[2]; /* Ensures ip is 4-byte aligned */
-	struct ethhdr header;
-	struct iphdr ip;
-	struct udphdr udp;
-	__be16 iteration;
-	char msg[64];
+	struct_group_attr(packet, __packed,
+		struct ethhdr header;
+		struct iphdr ip;
+		struct udphdr udp;
+		__be16 iteration;
+		char msg[64];
+	);
 } __packed __aligned(4);
-#define EF4_LOOPBACK_PAYLOAD_LEN	(sizeof(struct ef4_loopback_payload) - \
-					 offsetof(struct ef4_loopback_payload, \
-						  header))
+#define EF4_LOOPBACK_PAYLOAD_LEN	\
+		sizeof_field(struct ef4_loopback_payload, packet)
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -299,7 +300,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 
 	payload = &state->payload;
 
-	memcpy(&received.header, buf_ptr,
+	memcpy(&received.packet, buf_ptr,
 	       min_t(int, pkt_len, EF4_LOOPBACK_PAYLOAD_LEN));
 	received.ip.saddr = payload->ip.saddr;
 	if (state->offload_csum)
@@ -370,7 +371,7 @@ void ef4_loopback_rx_packet(struct ef4_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload.header, EF4_LOOPBACK_PAYLOAD_LEN,
+			       &state->payload.packet, EF4_LOOPBACK_PAYLOAD_LEN,
 			       0);
 	}
 #endif
@@ -440,6 +441,8 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
 		/* Strip off the leading padding */
 		skb_pull(skb, offsetof(struct ef4_loopback_payload, header));
+		/* Strip off the trailing padding */
+		skb_trim(skb, EF4_LOOPBACK_PAYLOAD_LEN);
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index 96d856b9043c..19a0b8584afb 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -43,15 +43,16 @@
  */
 struct efx_loopback_payload {
 	char pad[2]; /* Ensures ip is 4-byte aligned */
-	struct ethhdr header;
-	struct iphdr ip;
-	struct udphdr udp;
-	__be16 iteration;
-	char msg[64];
+	struct_group_attr(packet, __packed,
+		struct ethhdr header;
+		struct iphdr ip;
+		struct udphdr udp;
+		__be16 iteration;
+		char msg[64];
+	);
 } __packed __aligned(4);
-#define EFX_LOOPBACK_PAYLOAD_LEN	(sizeof(struct efx_loopback_payload) - \
-					 offsetof(struct efx_loopback_payload, \
-						  header))
+#define EFX_LOOPBACK_PAYLOAD_LEN	\
+		sizeof_field(struct efx_loopback_payload, packet)
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -297,7 +298,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 
 	payload = &state->payload;
 
-	memcpy(&received.header, buf_ptr,
+	memcpy(&received.packet, buf_ptr,
 	       min_t(int, pkt_len, EFX_LOOPBACK_PAYLOAD_LEN));
 	received.ip.saddr = payload->ip.saddr;
 	if (state->offload_csum)
@@ -368,7 +369,7 @@ void efx_loopback_rx_packet(struct efx_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload.header, EFX_LOOPBACK_PAYLOAD_LEN,
+			       &state->payload.packet, EFX_LOOPBACK_PAYLOAD_LEN,
 			       0);
 	}
 #endif
@@ -438,6 +439,8 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
 		/* Strip off the leading padding */
 		skb_pull(skb, offsetof(struct efx_loopback_payload, header));
+		/* Strip off the trailing padding */
+		skb_trim(skb, EFX_LOOPBACK_PAYLOAD_LEN);
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */
diff --git a/drivers/net/ethernet/sfc/siena/selftest.c b/drivers/net/ethernet/sfc/siena/selftest.c
index 111ac17194a5..b55fd3346972 100644
--- a/drivers/net/ethernet/sfc/siena/selftest.c
+++ b/drivers/net/ethernet/sfc/siena/selftest.c
@@ -43,15 +43,16 @@
  */
 struct efx_loopback_payload {
 	char pad[2]; /* Ensures ip is 4-byte aligned */
-	struct ethhdr header;
-	struct iphdr ip;
-	struct udphdr udp;
-	__be16 iteration;
-	char msg[64];
+	struct_group_attr(packet, __packed,
+		struct ethhdr header;
+		struct iphdr ip;
+		struct udphdr udp;
+		__be16 iteration;
+		char msg[64];
+	);
 } __packed __aligned(4);
-#define EFX_LOOPBACK_PAYLOAD_LEN	(sizeof(struct efx_loopback_payload) - \
-					 offsetof(struct efx_loopback_payload, \
-						  header))
+#define EFX_LOOPBACK_PAYLOAD_LEN	\
+		sizeof_field(struct efx_loopback_payload, packet)
 
 /* Loopback test source MAC address */
 static const u8 payload_source[ETH_ALEN] __aligned(2) = {
@@ -297,7 +298,7 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 
 	payload = &state->payload;
 
-	memcpy(&received.header, buf_ptr,
+	memcpy(&received.packet, buf_ptr,
 	       min_t(int, pkt_len, EFX_LOOPBACK_PAYLOAD_LEN));
 	received.ip.saddr = payload->ip.saddr;
 	if (state->offload_csum)
@@ -368,7 +369,7 @@ void efx_siena_loopback_rx_packet(struct efx_nic *efx,
 			       buf_ptr, pkt_len, 0);
 		netif_err(efx, drv, efx->net_dev, "expected packet:\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 0x10, 1,
-			       &state->payload.header, EFX_LOOPBACK_PAYLOAD_LEN,
+			       &state->payload.packet, EFX_LOOPBACK_PAYLOAD_LEN,
 			       0);
 	}
 #endif
@@ -438,6 +439,8 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 		payload->ip.saddr = htonl(INADDR_LOOPBACK | (i << 2));
 		/* Strip off the leading padding */
 		skb_pull(skb, offsetof(struct efx_loopback_payload, header));
+		/* Strip off the trailing padding */
+		skb_trim(skb, EFX_LOOPBACK_PAYLOAD_LEN);
 
 		/* Ensure everything we've written is visible to the
 		 * interrupt handler. */

