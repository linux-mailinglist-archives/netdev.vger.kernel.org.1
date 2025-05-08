Return-Path: <netdev+bounces-188942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEB2AAF7CA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9A4A744E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8BC770E2;
	Thu,  8 May 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0fFx+/X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA04B1E7C
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700240; cv=fail; b=gRvEOGz2ai9PkytduBVM+GAWcSMPmOl4nvTlAHnOAQUtXcCDQzgyG2qgYbHvF6GlhfhQeNpuaud/CFUwXy4lZO1qzgW1GM7hYqdXDutFOnAei4Raj4I7V9kpAVsqkGHvUelN92zPA4x4wO/7qHdIp5xIQ7NXqjlBBMFghH+BMmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700240; c=relaxed/simple;
	bh=KjNwp2CqvSoM+rPK+EKWU/5SNYPjZmnWHPWcr54W9Kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poSPq5/Zww0GvFJBiXQ6D1QfSjKt4NDXzytOipth7Rmoxa/beW208gUfeRkHaYt+vayvdv3EYhApvc0tYLXuIX70Aop/4bvgJq7KZk8/tKcU96RxQoSQbVE0aPkQmy/O3X0MZO2z0JIH3DIerSx1UGKcYmdXh9h6eiiQ+52484k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0fFx+/X; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE6mZoPCiBslflfynhCNVkGa4rPzUs+wdyUU0tklUgkqrUElhYFy0uIueS68Wd8oF4q/0EiL3VLDE5R/S2OBkzfxRliDVx7Zy2Y7zr1N1dj2f618F7upbirWyqOipeEA3F2YCoKUhL0BTE7f/pCxh/uG3APlvsROZDeVbp1vwGc3olj5AouT7VoXBOU6XRrtLRnwhwG2Zi4krT1b0HDH1vE2qaHP3hnMWX6uK27dVKtpDNo2smsTiNw1PbaL7ZH74ueyLj7rUFy3jtlRtIS+NS23ajkCdmwnxslbWH4LDYnE+lt7WzRG9BoUjnC9EW+8FMBxNkjZHrnSzCMqu9PcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PvMwprZVScEJZp3iE7oRsaMYE88o645O/jOfP6mF7c=;
 b=rsvAeWhzzv0ptJ3doUqfGkjhoHtz51Y51ZgcD2LmMyXuDiopFZ4B4eISsaRzB+n/95/WnThkIeidqBbamczHN1YSr97026JF50uYO2buDMt2dokM27Gfo+7Xrm/pDYiuzWvrWi9vDEYJxwESxQcfiPolwgs7TVaY4jKEcuC4RuSCMNc5kilVoNVJ7DT93btWMnAAJWRg95djFfVRoKO6CFlRxRDcuv61u7b4W2bMBh9JdVNJ4/+u70Cy/qC7u3mLbpC8YahUvLqQKDkacafaNX453s+QjTHgO5EiK3d7y9CYAZ0wRIUpTVfQpLrY0P+3GGRhsoaPuqfC6BtiS2XAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PvMwprZVScEJZp3iE7oRsaMYE88o645O/jOfP6mF7c=;
 b=p0fFx+/XpwbCLC1E6YmPmcvOdKnE4ZATsM99SlbluSQj0Kgc/mW7mYis7poPfGkole08CiHzdavqTgiu9jOZ0MSHcQOmtiQyynajlZxaaoxY+M/C42VhfEM+b2vu9+H3aDiRyqVH+tgbNJDort9lz05nhFabfC+aIXdyPca4cVoKLLhCGM9Y3s8gFR1eTNmtvXRuSxRRO+xVvCGeywRKqRx+HNiyKX9ZIzyQ2ujDOtPAGObETYeXDQ16zrOvbqz59qyeMQDPg56aeIWEgiCW0gYClC3iKnuVl4dlc7yFJD0i0w9AYsEEkLYe+MTLbfS8AM5b8L33guUj3S4nGhMAig==
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 10:30:28 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::58) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 10:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 10:30:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 03:30:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 03:30:21 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 03:30:18 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "Gal
 Pressman" <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next v2] ethtool: Block setting of symmetric RSS when non-symmetric rx-flow-hash is requested
Date: Thu, 8 May 2025 13:30:34 +0300
Message-ID: <20250508103034.885536-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 081574dd-e950-4b4c-0899-08dd8e1b5a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OCVKZkEUPM4fM+CsHnddeZVfJ4EJKwZ3FV46hMV1QtAtaU1iqhOwBsAAtneR?=
 =?us-ascii?Q?HqvabLpSfXXMsRgCfG1bbx5Huu//fXD+gN+URpYDtDIujMsdvSGLYKHlwWYv?=
 =?us-ascii?Q?hqdeSUUnie7fQgmoNF62QFX/7Y1HEvXHpLYF8g4svx2Gqw+L6Y3vqtHopc7c?=
 =?us-ascii?Q?WATBLOH/8EzS79F9sXunZFl5XnZmB600mH1F2sJ6Csne4UYT61UZ/PVeHAuU?=
 =?us-ascii?Q?y/Scf1vKQYo0msAMptFSYpFrh+GXsHlRnGgiPY9zozhSs0hZWx6CrGxDMG7q?=
 =?us-ascii?Q?c7hstWEZBPlu07MBToyQndfVMyv29amf0WdgQrr3N1J3aL2Fu03p9g1KSxjr?=
 =?us-ascii?Q?Qj24TfCqzeZl3hMZ2+z1i7kMa7igUrYXYneo/f2a2m4hqSi1k+w5m/URe7bF?=
 =?us-ascii?Q?v2ybdeXTRauWXZ7aQzepZAyQP9ryr+5RWRvXikj3uKYBZL9OSiNJ064fQZRa?=
 =?us-ascii?Q?GLKHc2/HUK0X+VQQm9F9o6oCjyUvDekeZHI2QTEjcFFb+psz3CzJaFfTImGM?=
 =?us-ascii?Q?D+KGupy4QIA46odx0+10WBwYYDHoFsbOy9AXCNiDNuDNJxhhpy76FQ8dbX85?=
 =?us-ascii?Q?QMOa73hhtYhG3nS3rq6e2DlplMebFCl9JwA7YMZYTePearG9L9vYqy2m5R6k?=
 =?us-ascii?Q?7XYd2xFwtvR13PxJeUM/cq8WarG2wWvgMhnoMXlxUQ1YXWmg8R007FLPvdLq?=
 =?us-ascii?Q?CsJqklQSibZ14slgt6uCLoFy8IN6OMkaQvGPOdBnfdcOa/s3T4024W2G0q/C?=
 =?us-ascii?Q?leJa0YfBOA729Jzc8wZwRRIwidZNvZYu6C57Nbng13JaooD/pOKC/r8gYZai?=
 =?us-ascii?Q?5ekdU2I2v6/l8b8xTN8jcxvhGdmiWtldPppMbJnZ9Fho7DvOjAktuDtwMSaT?=
 =?us-ascii?Q?mdO1Rgtdutd1TfOUruyjR165JaVOnyw+gOIMKOKynx/xf+UDWNoynPKNd8zr?=
 =?us-ascii?Q?qZ9eFxCJipvxvFwM8tduF3Akh9GTotEFZHxPySSFDPnK9dKD0FiL0N0WpKfh?=
 =?us-ascii?Q?szlK1GM+pYhivjIw/pq5Zx3x0vORw2slRVmDaL8zCMBZaYT3u1DOY4nYhm0w?=
 =?us-ascii?Q?K0YKK7vd1UCB1hlSJMk0yrMyY4EfHoEGb+tOnaZgyra+bMEDn981vbmcpPSd?=
 =?us-ascii?Q?H3EMUix5048NKjlhSND10DBhTAMm2y/H8fh8PSCXd+a9LyWNg338/6tSexQA?=
 =?us-ascii?Q?H0m+MLAo63kfzye3KDZUiV4No1Qy2uFmJtY3M8nvByuO1xk1uD3T9WLcackU?=
 =?us-ascii?Q?qDWwFE0Z9d0s81/fK8vBk2/KRDWiTCKwUOYT1aAJR2EUS3ujC4a2GjvNJq9/?=
 =?us-ascii?Q?FqgImXvSXyjtchnHAmMWnZCjZZ4ScT0w/T5saNqulTFnfSCOibxIrcONPDWr?=
 =?us-ascii?Q?TR/+VFdkdd+NCbtAqNIp3KnsQ6SkZ1mgKor1VWht70rXt6BJ0SjIz7dsk/qr?=
 =?us-ascii?Q?GpG0p98vd31DAPMXiPgGqMxnr235374mit5Ld/IE1MP1ec2tlcloTczqwVll?=
 =?us-ascii?Q?K0NmhvP1x+gG3PRDBJLNl1HoQo6m4U+Bc94bb/yYN2M9NVufkjWsFv6BIA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:30:28.4890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081574dd-e950-4b4c-0899-08dd8e1b5a3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

Symmetric RSS hash requires that:
* No other fields besides IP src/dst and/or L4 src/dst are set
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

The conversion of uapi #defines to enum is not ideal, but as Jakub
mentioned [1], we have precedent for that.

[1] https://lore.kernel.org/netdev/20250324073509.6571ade3@kernel.org/

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog -
v1->v2: https://lore.kernel.org/netdev/20250310072329.222123-1-gal@nvidia.com/
* Reword comment (Simon)
* Fix comments alignment (Jakub)
* Rename FLOW_TYPE_MAX -> __FLOW_TYPE_COUNT for consistency with other
  enums in the file
---
 include/uapi/linux/ethtool.h | 124 ++++++++++++++++++-----------------
 net/ethtool/ioctl.c          |  99 +++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 70 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..707c1844010c 100644
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
+	TCP_V4_FLOW	= 0x01,	/* hash or spec (tcp_ip4_spec) */
+	UDP_V4_FLOW	= 0x02,	/* hash or spec (udp_ip4_spec) */
+	SCTP_V4_FLOW	= 0x03,	/* hash or spec (sctp_ip4_spec) */
+	AH_ESP_V4_FLOW	= 0x04,	/* hash only */
+	TCP_V6_FLOW	= 0x05,	/* hash or spec (tcp_ip6_spec; nfc only) */
+	UDP_V6_FLOW	= 0x06,	/* hash or spec (udp_ip6_spec; nfc only) */
+	SCTP_V6_FLOW	= 0x07,	/* hash or spec (sctp_ip6_spec; nfc only) */
+	AH_ESP_V6_FLOW	= 0x08,	/* hash only */
+	AH_V4_FLOW	= 0x09,	/* hash or spec (ah_ip4_spec) */
+	ESP_V4_FLOW	= 0x0a,	/* hash or spec (esp_ip4_spec) */
+	AH_V6_FLOW	= 0x0b,	/* hash or spec (ah_ip6_spec; nfc only) */
+	ESP_V6_FLOW	= 0x0c,	/* hash or spec (esp_ip6_spec; nfc only) */
+	IPV4_USER_FLOW	= 0x0d,	/* spec only (usr_ip4_spec) */
+	IP_USER_FLOW	= IPV4_USER_FLOW,
+	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
+	IPV4_FLOW	= 0x10, /* hash only */
+	IPV6_FLOW	= 0x11, /* hash only */
+	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
 
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
+	GTPU_V4_FLOW	= 0x13,	/* hash only */
+	GTPU_V6_FLOW	= 0x14,	/* hash only */
 
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
+	GTPC_V4_FLOW	= 0x15,	/* hash only */
+	GTPC_V6_FLOW	= 0x16,	/* hash only */
 
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
+	GTPC_TEID_V4_FLOW	= 0x17,	/* hash only */
+	GTPC_TEID_V6_FLOW	= 0x18,	/* hash only */
 
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
+	GTPU_EH_V4_FLOW	= 0x19,	/* hash only */
+	GTPU_EH_V6_FLOW	= 0x1a,	/* hash only */
 
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
+	GTPU_UL_V4_FLOW	= 0x1b,	/* hash only */
+	GTPU_UL_V6_FLOW	= 0x1c,	/* hash only */
+	GTPU_DL_V4_FLOW	= 0x1d,	/* hash only */
+	GTPU_DL_V6_FLOW	= 0x1e,	/* hash only */
+
+	__FLOW_TYPE_COUNT,
+};
 
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8262cc10f98d..39ec920f5de7 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -978,6 +978,88 @@ static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
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
+static_assert(GTPU_DL_V6_FLOW + 1 == __FLOW_TYPE_COUNT);
+
+static int ethtool_check_xfrm_rxfh(u32 input_xfrm, u64 rxfh)
+{
+	/* Sanity check: if symmetric-xor/symmetric-or-xor is set, then:
+	 * 1 - no other fields besides IP src/dst and/or L4 src/dst are set
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
+	for (i = 0; i < __FLOW_TYPE_COUNT; i++) {
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
@@ -1012,16 +1094,9 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
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
@@ -1413,6 +1488,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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


