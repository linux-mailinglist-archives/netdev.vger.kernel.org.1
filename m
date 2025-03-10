Return-Path: <netdev+bounces-173434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E420CA58CD8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EF6188EE2E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29181D63FA;
	Mon, 10 Mar 2025 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4fpOjqM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EB1D5AA0
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591435; cv=fail; b=ihmlM/qesbPXmlZykL4TvNuPQB0g1GjolwEJvRokg8LJPwVNLLTafygQrjIzhgSfInFEbjPDPsi2jHmI8ElOlRPrGhk0OEHTSi9qIG2iX5JLETZDhelO8mGnHLmVVKhYwotfCdYLnspM2YZhS1+67X4i65euEfxYCS920AKSZgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591435; c=relaxed/simple;
	bh=tvr2Qr1q5m037+/ndHFhMvBAU/W7KXBNsSj5hJZOog0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JfCsfisnDWAzz3eoQ0nYleZ2JYiRYLTgq0InunDhXEORkSh4ERLOpCdKSQT0z37bAxIq0KkVBCxV+xKXkPsUbVLqwXjGC9ZYfZUIe2TenRjzdJD7BRMYSmV1ynNufccP9vP5SNQxgngfM5CAX1YozX/ti+W3epNzTXHQnc9rip4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4fpOjqM; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhOaI/FCjcsfODqJm1iVgVUxerjlpLADZDfBzFHqe8fkG0UtfS/FN1foXVdxpqWMadwXsGjfmQf9mxY7dlgAwYzVtjUXs2o7yZmwe163W9TWK/SbXrgjNPDJ8qlP8ZZxECIUbMpx6puoTNzumg/Lz4bM3AaDhzbTbnaM436spI/3hjoXLY0l1WeANprYN/wTK5YR8H9K1jiTvQbnR2avhhF67rsIrRdUbRE/fHkRBKCRjliPVkDZb2udsCkpVDSUugUO3DnKJn+aeVWgopoSawjf8JFD7IAYLbFcFusia1gU/SJqBq5nfVU1hVz1y8tQ6Gs4VFyOMjYBuz4bGPaVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S50aKYUgV/4d5XOIKyFNN39Q/vtirsQF7oXq701dRkE=;
 b=rq0lCOYjTzCsbXilZbxdhWKCXPjJ5iaMVfPLVxcw0NXdtZI+hDFyK6V4Ndh4W6+syS26g/6BfajFiN2peFvyYwztdckWc/ZkF9NFms6IZOb7c+j88UczM5FSVfHEN54a4OJ5IgFG5r5yu3lXcLGok3en96F2Gzsibohbtw7m2xt/0LSCja6i6/QCwKFcAfWSyJYNPGySQfvteOWsOOOC08/ekVvYiFwwisYneFzj1Z/l2JaoZbIWe3d/acl+DBuYzZ9A4HCgFESbBx0EuvV2SI/JDTj6x7XwHWdf3MqMA0fFhU0kgxm8e+ONxFIof8bTKo9ojzkquqINSs3CnMceKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S50aKYUgV/4d5XOIKyFNN39Q/vtirsQF7oXq701dRkE=;
 b=o4fpOjqMn7lu0aeGRkVkXrEta8xnjp15MsvCuJaoYGxSBsFGiSXBm1KsuCZWdqeiUL7rEUeBUwrX99xVG7L59obuofkax+RUP5JtXyUqVYvDCjmL9D0aPZoCmPF8MHeLiL/wajKdI3oZsHUbHGrWAkkpRpmAGUqqX5xUJrnsZezGDKPaYUSNhfhdI8yUQp/kLI+Uzxw002IuXY2B/1Nt7+mRimBqyKek3P+5K/zXddgYPcg6F/JxJlu1jApB6J08UJdly703xCPvq8KNDhsmNjEjSvSjzv51N9/Ywalkb04lyY1+Bo07nI3GqXQGCjVS5fxzx3FMC4/Nvph3Z0vXbQ==
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:23:48 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::e) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.16 via Frontend Transport; Mon,
 10 Mar 2025 07:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 07:23:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 00:23:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 00:23:33 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 00:23:30 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "Gal
 Pressman" <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] ethtool: Block setting of symmetric RSS when non-symmetric rx-flow-hash is requested
Date: Mon, 10 Mar 2025 09:23:29 +0200
Message-ID: <20250310072329.222123-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: e8188387-8a22-4111-c2a8-08dd5fa47f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pa4fGilgCZqyAH2leG97wMnKP8upoNPZ2eJr2hH2CHNHipHjRawJIhE4gIZC?=
 =?us-ascii?Q?7uM74WHO8RurD1i7BaTceYsJAIWKQn5WAPKVP3quWUZQIyAcwAKGwl9KYQDs?=
 =?us-ascii?Q?6TQdq6Z820UCjM0KwR+n4B2dDR7nY87DaOT4VN+P82Fisf6oXwoqpf3ro4Ij?=
 =?us-ascii?Q?N6nD8PAn8RxnRsEpSdf0lMU7XVu1f5E+FMB5pmJi9UMaXh0ZCHkJg/lorGKq?=
 =?us-ascii?Q?FnN0DhL2t6gry/7ZU3nD91sCmiV4mZYP5nGADIXbpYg1eGpi6hRcgzOyFYqb?=
 =?us-ascii?Q?hWQSEfDJcTMfOejlhdg5P2AfLPDApICto2+7l5FiCjHfex+pVzxaildbFrl9?=
 =?us-ascii?Q?JXBATrZL4Hbz+M4yihMgCf1n3xpGOYfwBrAZib9M5gtgN0aQMJ6wx7HSKCWY?=
 =?us-ascii?Q?KJB9Hx5Aj2UQotvcGiGzP4OG/5YqlYnJnfzTEDtPoAu0rWf9an9sIjerrq0E?=
 =?us-ascii?Q?5lk67xUL8ouOV39yCJPA1KXmVfn/vWfRmGPKCmolmPq/A0wLFpp7+teWN5bB?=
 =?us-ascii?Q?49+Yk65ai+/Vh//FOq3ul7/pI2JZTe5/sEKOq8hb+1Fle9Ze36lsjRVWBbWo?=
 =?us-ascii?Q?G/F75kqLkoxWrStW5ysiml9ZolKHIzp85NyJ5/f499ad7/NHAg9m3dP7u3F6?=
 =?us-ascii?Q?Pw5B0ivlKr+QubIK/VQfDI2tmA9oRjAaBfvE29vVFK1Al+v7zeTsYryMX3ml?=
 =?us-ascii?Q?4/ANIo7AYYtPi5maUitoZjz4NaA/1ij0Bd3L9AG/A/u0ZbsDM6qvwW4PujIb?=
 =?us-ascii?Q?Nyp1qTFIxr2Emqf0hH7HU5z+zoqHXw5Eqth1NnNPvvO0L30p0/AFw5NWr6lz?=
 =?us-ascii?Q?CMd5FivImmowSbNv8u9b/V6D0bm9QTT/q9JTexVYgus/LCNsu2B0VCDUzUug?=
 =?us-ascii?Q?NANXM2a2YMDqjokuREivNsyZxoB2r0g6QtkWsqDl1Uh5DVG9XlLbYz1zVMk1?=
 =?us-ascii?Q?o43xfdmQn6lQYV/psBpEaJGXlzzymc9SIwx1GIaaG2MRsiwJgUAAuXFZnn6l?=
 =?us-ascii?Q?lFJimrGMR+UqFGB/WgJIHvVvjO9zcZdZ1ZfDkuTs0ZndiQcEQEKkzJn7dtFr?=
 =?us-ascii?Q?YKBfeO/5MQNbTIcR7QjBXjRrviFcQAajMO59fRzWPX/fqYUn3vjgBwm4n+HU?=
 =?us-ascii?Q?EjzAr4LCO0aFF+RQckKuLoiE6fXKIqo2L7X2vpNDA5Vk9G558QNE/Vd5Kpuh?=
 =?us-ascii?Q?xkv9hyOAGLqHO8qtKJLXsgMRg0Q+C+oE7iIOJfBxdH+YVerPU4VH+bhfCFm3?=
 =?us-ascii?Q?W7bfuZqeHv4gYHQCfzF+I5ySX3NSf3MU1O0i54u1Ja3dIqaafUe9FpP+9QRA?=
 =?us-ascii?Q?DOrlkQFMSur4UwsS0YF+DKt6uYe4rKXBKZlAbHmlhDCv4FE+FbiezmkF9ufg?=
 =?us-ascii?Q?zoPwg+1U1UCkYT/0bAZxndU4E7H0FmCPmDw+GQZoC/Two4FaZX41m2vWBHhZ?=
 =?us-ascii?Q?G1GHAvYHUtP/sZU5Iw53ino95YEwJDlQgycKjofz/H+u8rCxA6iIFTAm6Kxy?=
 =?us-ascii?Q?hIdso+skHPnZIcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:23:47.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8188387-8a22-4111-c2a8-08dd5fa47f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

Symmetric RSS hash requires that:
* No other fields besides IP src/dst and/or L4 src/dst
* If src is set, dst must also be set

This restriction was only enforced when RXNFC was configured after
symmetric hash was enabled. In the opposite order of operations (RXNFC
then symmetric enablement) the check was not performed.

Perform the sanity check on set_rxfh as well, by iterating over all flow
types hash fields and making sure they are all symmetric.

Introduce a function that returns whether a flow type is hashable (not
spec only) and needs to be iterated over. To make sure that no one
forgets to update the list of hashable flow types when adding new flow
types, a static assert is added to draw the developer's attention.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/uapi/linux/ethtool.h | 124 ++++++++++++++++++-----------------
 net/ethtool/ioctl.c          |  99 +++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 70 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..d36f8f4e3eef 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2295,71 +2295,75 @@ static inline int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
-/* L2-L4 network traffic flow types */
-#define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
-#define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
-#define	SCTP_V4_FLOW	0x03	/* hash or spec (sctp_ip4_spec) */
-#define	AH_ESP_V4_FLOW	0x04	/* hash only */
-#define	TCP_V6_FLOW	0x05	/* hash or spec (tcp_ip6_spec; nfc only) */
-#define	UDP_V6_FLOW	0x06	/* hash or spec (udp_ip6_spec; nfc only) */
-#define	SCTP_V6_FLOW	0x07	/* hash or spec (sctp_ip6_spec; nfc only) */
-#define	AH_ESP_V6_FLOW	0x08	/* hash only */
-#define	AH_V4_FLOW	0x09	/* hash or spec (ah_ip4_spec) */
-#define	ESP_V4_FLOW	0x0a	/* hash or spec (esp_ip4_spec) */
-#define	AH_V6_FLOW	0x0b	/* hash or spec (ah_ip6_spec; nfc only) */
-#define	ESP_V6_FLOW	0x0c	/* hash or spec (esp_ip6_spec; nfc only) */
-#define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
-#define	IP_USER_FLOW	IPV4_USER_FLOW
-#define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
-#define	IPV4_FLOW	0x10	/* hash only */
-#define	IPV6_FLOW	0x11	/* hash only */
-#define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+enum {
+	/* L2-L4 network traffic flow types */
+	TCP_V4_FLOW = 0x01, /* hash or spec (tcp_ip4_spec) */
+	UDP_V4_FLOW = 0x02, /* hash or spec (udp_ip4_spec) */
+	SCTP_V4_FLOW = 0x03, /* hash or spec (sctp_ip4_spec) */
+	AH_ESP_V4_FLOW = 0x04, /* hash only */
+	TCP_V6_FLOW = 0x05, /* hash or spec (tcp_ip6_spec; nfc only) */
+	UDP_V6_FLOW = 0x06, /* hash or spec (udp_ip6_spec; nfc only) */
+	SCTP_V6_FLOW = 0x07, /* hash or spec (sctp_ip6_spec; nfc only) */
+	AH_ESP_V6_FLOW = 0x08, /* hash only */
+	AH_V4_FLOW = 0x09, /* hash or spec (ah_ip4_spec) */
+	ESP_V4_FLOW = 0x0a, /* hash or spec (esp_ip4_spec) */
+	AH_V6_FLOW = 0x0b, /* hash or spec (ah_ip6_spec; nfc only) */
+	ESP_V6_FLOW = 0x0c, /* hash or spec (esp_ip6_spec; nfc only) */
+	IPV4_USER_FLOW = 0x0d, /* spec only (usr_ip4_spec) */
+	IP_USER_FLOW = IPV4_USER_FLOW,
+	IPV6_USER_FLOW = 0x0e, /* spec only (usr_ip6_spec; nfc only) */
+	IPV4_FLOW = 0x10, /* hash only */
+	IPV6_FLOW = 0x11, /* hash only */
+	ETHER_FLOW = 0x12, /* spec only (ether_spec) */
 
-/* Used for GTP-U IPv4 and IPv6.
- * The format of GTP packets only includes
- * elements such as TEID and GTP version.
- * It is primarily intended for data communication of the UE.
- */
-#define GTPU_V4_FLOW 0x13	/* hash only */
-#define GTPU_V6_FLOW 0x14	/* hash only */
+	/* Used for GTP-U IPv4 and IPv6.
+	 * The format of GTP packets only includes
+	 * elements such as TEID and GTP version.
+	 * It is primarily intended for data communication of the UE.
+	 */
+	GTPU_V4_FLOW = 0x13, /* hash only */
+	GTPU_V6_FLOW = 0x14, /* hash only */
 
-/* Use for GTP-C IPv4 and v6.
- * The format of these GTP packets does not include TEID.
- * Primarily expected to be used for communication
- * to create sessions for UE data communication,
- * commonly referred to as CSR (Create Session Request).
- */
-#define GTPC_V4_FLOW 0x15	/* hash only */
-#define GTPC_V6_FLOW 0x16	/* hash only */
+	/* Use for GTP-C IPv4 and v6.
+	 * The format of these GTP packets does not include TEID.
+	 * Primarily expected to be used for communication
+	 * to create sessions for UE data communication,
+	 * commonly referred to as CSR (Create Session Request).
+	 */
+	GTPC_V4_FLOW = 0x15, /* hash only */
+	GTPC_V6_FLOW = 0x16, /* hash only */
 
-/* Use for GTP-C IPv4 and v6.
- * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
- * After session creation, it becomes this packet.
- * This is mainly used for requests to realize UE handover.
- */
-#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
-#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+	/* Use for GTP-C IPv4 and v6.
+	 * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+	 * After session creation, it becomes this packet.
+	 * This is mainly used for requests to realize UE handover.
+	 */
+	GTPC_TEID_V4_FLOW = 0x17, /* hash only */
+	GTPC_TEID_V6_FLOW = 0x18, /* hash only */
 
-/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
- * The format of these GTP packets includes TEID and QFI.
- * In 5G communication using UPF (User Plane Function),
- * data communication with this extended header is performed.
- */
-#define GTPU_EH_V4_FLOW 0x19	/* hash only */
-#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+	/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+	 * The format of these GTP packets includes TEID and QFI.
+	 * In 5G communication using UPF (User Plane Function),
+	 * data communication with this extended header is performed.
+	 */
+	GTPU_EH_V4_FLOW = 0x19, /* hash only */
+	GTPU_EH_V6_FLOW = 0x1a, /* hash only */
 
-/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
- * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
- * UL/DL included in the PSC.
- * There are differences in the data included based on Downlink/Uplink,
- * and can be used to distinguish packets.
- * The functions described so far are useful when you want to
- * handle communication from the mobile network in UPF, PGW, etc.
- */
-#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
-#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
-#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
-#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+	/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+	 * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+	 * UL/DL included in the PSC.
+	 * There are differences in the data included based on Downlink/Uplink,
+	 * and can be used to distinguish packets.
+	 * The functions described so far are useful when you want to
+	 * handle communication from the mobile network in UPF, PGW, etc.
+	 */
+	GTPU_UL_V4_FLOW = 0x1b, /* hash only */
+	GTPU_UL_V6_FLOW = 0x1c, /* hash only */
+	GTPU_DL_V4_FLOW = 0x1d, /* hash only */
+	GTPU_DL_V6_FLOW = 0x1e, /* hash only */
+
+	FLOW_TYPE_MAX,
+};
 
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 77d714874eca..aa1473bbeaa8 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -977,6 +977,88 @@ static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 	return 0;
 }
 
+static bool flow_type_hashable(u32 flow_type)
+{
+	switch (flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+	case GTPU_V4_FLOW:
+	case GTPU_V6_FLOW:
+	case GTPC_V4_FLOW:
+	case GTPC_V6_FLOW:
+	case GTPC_TEID_V4_FLOW:
+	case GTPC_TEID_V6_FLOW:
+	case GTPU_EH_V4_FLOW:
+	case GTPU_EH_V6_FLOW:
+	case GTPU_UL_V4_FLOW:
+	case GTPU_UL_V6_FLOW:
+	case GTPU_DL_V4_FLOW:
+	case GTPU_DL_V6_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+/* When adding a new type, update the assert and, if it's hashable, add it to
+ * the flow_type_hashable switch case.
+ */
+static_assert(GTPU_DL_V6_FLOW + 1 == FLOW_TYPE_MAX);
+
+static int ethtool_check_xfrm_rxfh(u32 input_xfrm, u64 rxfh)
+{
+	/* Sanity check: if symmetric-xor/symmetric-or-xor is set, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst
+	 * 2 - If src is set, dst must also be set
+	 */
+	if ((input_xfrm != RXH_XFRM_NO_CHANGE &&
+	     input_xfrm & (RXH_XFRM_SYM_XOR | RXH_XFRM_SYM_OR_XOR)) &&
+	    ((rxfh & ~(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
+	     (!!(rxfh & RXH_IP_SRC) ^ !!(rxfh & RXH_IP_DST)) ||
+	     (!!(rxfh & RXH_L4_B_0_1) ^ !!(rxfh & RXH_L4_B_2_3))))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ethtool_check_flow_types(struct net_device *dev, u32 input_xfrm)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc info = {
+		.cmd = ETHTOOL_GRXFH,
+	};
+	int err;
+	u32 i;
+
+	for (i = 0; i < FLOW_TYPE_MAX; i++) {
+		if (!flow_type_hashable(i))
+			continue;
+
+		info.flow_type = i;
+		err = ops->get_rxnfc(dev, &info, NULL);
+		if (err)
+			continue;
+
+		err = ethtool_check_xfrm_rxfh(input_xfrm, info.data);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -1011,16 +1093,9 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 		if (rc)
 			return rc;
 
-		/* Sanity check: if symmetric-xor/symmetric-or-xor is set, then:
-		 * 1 - no other fields besides IP src/dst and/or L4 src/dst
-		 * 2 - If src is set, dst must also be set
-		 */
-		if ((rxfh.input_xfrm & (RXH_XFRM_SYM_XOR | RXH_XFRM_SYM_OR_XOR)) &&
-		    ((info.data & ~(RXH_IP_SRC | RXH_IP_DST |
-				    RXH_L4_B_0_1 | RXH_L4_B_2_3)) ||
-		     (!!(info.data & RXH_IP_SRC) ^ !!(info.data & RXH_IP_DST)) ||
-		     (!!(info.data & RXH_L4_B_0_1) ^ !!(info.data & RXH_L4_B_2_3))))
-			return -EINVAL;
+		rc = ethtool_check_xfrm_rxfh(rxfh.input_xfrm, info.data);
+		if (rc)
+			return rc;
 	}
 
 	rc = ops->set_rxnfc(dev, &info);
@@ -1412,6 +1487,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
 		return -EINVAL;
 
+	ret = ethtool_check_flow_types(dev, rxfh.input_xfrm);
+	if (ret)
+		return ret;
+
 	indir_bytes = dev_indir_size * sizeof(rxfh_dev.indir[0]);
 
 	/* Check settings which may be global rather than per RSS-context */
-- 
2.40.1


