Return-Path: <netdev+bounces-88473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C617C8A75C6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E372B1C2110F
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228B3C47B;
	Tue, 16 Apr 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C3D1Dgpo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0FC39AF2
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299861; cv=fail; b=N2tOH0YfCLmtM2dq7lIGR1cQTo1hpryCWU6Z7hWn2YwPW3elIM/v+YhaW0NBf5FuTcuG2NZxeR7laBSVjnekke8pulHU3vs/r8w8LAKPf6emGG/54udIoQJG47dy6Koy0xXXH7DL7W9Q4qjK4RoKinxqYzZSzPAWiHtkbUfECn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299861; c=relaxed/simple;
	bh=Mw3AhzMSWnxLNi/PTvR/jSnxdeTVM5FVWR8AA7+Esco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fP4KNAmABzIQSV6Otp8b8dvEY7Lq6BriLe6FX6RkXggIby9/CusZm0F2aAU4IicvdNUAl1jttvanq6M6TsTgR+pdjJDvn8/S94cvnQB8IG3Nid6UdZYEAGgPNXpraklQVRidrbjSrVvGi8kN2LRbGnU+tLUtAGyjczW/LlonMX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3D1Dgpo; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by5Wh5M/SOoM7g4jiwYMo5ILNXrn2014AWJtYOY278YHadRgIw57bll39A+FDY3sCdd4UmmDjT9R2iFUk87nYRV0FH/oYiXlXZhj3yKOudlOOJk3+vzT3DbqixNb0JnYE5HQbvluDGoIzMmMxZhPqtlNLjBpO8MBWZYXkzITrRVjmmJcOve+fClJ/HyZFADAi5P/PB2WrNJKGxOdRVyRTvm4Aj8kIfc27zx+pMOFK3IWsDcBPeDy0DB+RK9axwG3P6OtjcRJfkh2bS0b02uY5flKZXZtL0+wZ98XeP1UxSOs9uOrvpsBc9vJ2tww5bXpf72vZvyqugalaTLVjDeliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21UsHgksy/uvzGE1ohPzxaw9SmVYP+XhkGXrRblKqkg=;
 b=ATYQQp0wnl60remqLrtfxFiI/oUTF6b2wR5aJXI8VlFNo4HRUzLe2hks3c8ARs2208ZLwYZUMC+YTy6mg82KjMHx05pcUzypISLMF4slNVC49A9GpJrIL85DMnB+F+H6N8V/sn5G6A5d0QG6TKGB4NJQXb37jXV3nvuJhtzlzy8Jh2Lb0stiW/0xRCB4gdLMXP6SrR/2rJ3iWdY8eWCU657QqapPK8BMMheSTUhHKlggPRo4gx0HsTwWpVyZGWteL/peZLyK/i3b33RUNDonT2HF6KlPgDEpre8zOrHz6rmQZNaHJQ3sr+LETaVGTu2O+zZqarSygRFIxLi3qC+oSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21UsHgksy/uvzGE1ohPzxaw9SmVYP+XhkGXrRblKqkg=;
 b=C3D1DgpoaiW/NtVpAJTtYzFNZZxRPufusQISOrBT46gozbHPeXbHyuUEdlRm7Y5w01kjHuJVFkfFw6H1n4MvwocrYrPTnIRUhrnkKDFjHQo0TzbW9uD94Ul/q8IOOqBVxCbReMOwVszTKhBkfmai0FxnuVLYykQOGW6IJ6Mn6nKREWu/yShedukXmG2W0NuGdVZAmkrc0soiEqH4fs07Ywsza27JZeOTokHiuLmFFiQ1sCberthxcxMEGwMTaFw87aJRDT5HJtDNKS5Vrv2KTIss8sSVMc2CieO7r6l/tCjaVvZSBrjzS7kRtGFQiCIq8mw6y+quHJPO1/YTlHpgJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 20:37:35 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 20:37:35 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next 1/2] update UAPI header copies
Date: Tue, 16 Apr 2024 13:37:16 -0700
Message-ID: <20240416203723.104062-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240416203723.104062-1-rrameshbabu@nvidia.com>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d472b4-6565-4d8b-a290-08dc5e550ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yILBYwPplp9jBLUgIu3S3LiDCSLNd+VaLGgkkU7Iz2ca1EwSIQ4I3WYoleWI0lD/Z91NFOieM8NaiZ3XuIKsKBN6/cStZOsRcYcuM2FrlTPAp83v9IumrKMlID+X32kH1OQ63cQO/FTIf6pIKYJgRAV2qPgW+8iUPp2pb7EXvjmCbfsg1NzmPaV//1KGEixVgbeM7GkvncFmw4eLDnQZ/kEJVQovfe11hNItGOhYm6WSqllKo8/U4PAo1j5NYM/lLwa+yOsp3FDpVZsrn6yboSr7VWW8xTFPfoLBXajm5/Me+b7uMXD4NgHcVBwcndndCfmBSZPy+c41ArN08GVteRunBnp6LLHhbClwaOxIBfUp0SvIm5wUG2VAt8OSWZxH+KnYoEd44jX9OEMYRH4zwrKizWzFhkTXWeWHgLo8/yXreJqAkzDC10ZsWznO3xFUBrzZAscCdTUUBs2dmYeW08vnzDQn/CtOWGd1ykE5fx/9RTi419GnwDVwmnQ5h1qHYme09SpG/jHpDzootxG5glMF5ipv4j8RZMnfzSEJGAxpsCiuJETf+cjw0v38l3i+hdIGswv5ZjLlByvI3hfkfxeKnEUrzZOLE4yMnHcI5WcmM+4XSkK+hwjvPbC7zKCkMOfvihQeM1FVQeF1GTGHOU+tWQ5caPIJrpLu52nnw2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?De+/BDDa+yuD/gLbg3KLhCvhUlOyEp4BtHa/tfy9YC4KHlRiRongnZz92/OE?=
 =?us-ascii?Q?gwqiRg2QdQyFE+jUoUh7JR4+759Ke8RAjVSjk8Ud02NNyMrJWZk/jvGNso3f?=
 =?us-ascii?Q?svUAE6YURyUE1As5juKBZ1sTx6fgUQG+1ScGy8FjZgyZvKBpU4jUZERuCCaA?=
 =?us-ascii?Q?VxMJfGzoU0GXg9Cv38vEfv7wwj6Mi8UI9xVb13d6QAAXWyYtnANHXu0L/mfg?=
 =?us-ascii?Q?axdZDbrqX2OuEQqMyljufpuFRgDNUKhbf7FCIAkTSrPdpw6HhD7dewkL5Sd6?=
 =?us-ascii?Q?mEwVNcHkQVJzlQQ4jIpL30rCNqzj/gswhuID+MZYkBt1Y4lO9S+lRQz2au6w?=
 =?us-ascii?Q?MLbT7NZ9XHRwkIOaq7EQFPnz2AL/Zn45/xJaScDzTtZKteWZjo79h5iAvE74?=
 =?us-ascii?Q?J9CTV1ECbOAhCiKspa3d6qDFPyokSU4Gli8m2Ut/iLF9ugFQwyI/i2iP/kDD?=
 =?us-ascii?Q?3ROCbBw8SdVQreCLAomaGKe9rBKWECi+Z0U/PfyzxPEcaRmH3Ww+85Z041hd?=
 =?us-ascii?Q?rvOqGvaOcrXTLqHpAm8ZFusV65lUpYw1rWx3Rma2gr8ib7xKNBvUwdYPLjEN?=
 =?us-ascii?Q?vZ96gegWZ7Z+CMNqKJSNimp3d4PaoNUrCuJrM8ywUnSvlTPqLPiBLG2nbs7k?=
 =?us-ascii?Q?yUwzBZfL0XaTX6lsSYkKwW7toWr24X1MdfNXl0rBjrdP1Wx0aM2zeoVGQIit?=
 =?us-ascii?Q?A69przoV/XsRf7tr7HKoTNpQnb4PuyIbR78maPWWk1klbusZU2lTqhDULGCT?=
 =?us-ascii?Q?Ux6ZnhruVrXzZMDOVAPewVBFPMle5dVhQq7TWgDScA7fMcyNTop1/tHbM5h/?=
 =?us-ascii?Q?97zvWJWtIBCdbF3RYObAAKoG1IpkhM36aUSQ+feQtKuJBZoiCvYLdhe1NuYy?=
 =?us-ascii?Q?QivrXXXFOP7kjS74ZzKhSirU3xoyIYQwmCDDwJyL5/kIPfWDWpALPnygD4HW?=
 =?us-ascii?Q?NmWwFXRnPvq5NyI8KwWtoLzirNTgA+gzMtQ+BysM/2qxO9+qjqMK6B8TXrkU?=
 =?us-ascii?Q?ERPDTjX5nsccLS0NLIHjBwPELZCShg4miIGIlr0+lOjt3ufudiiB4UG5yFSU?=
 =?us-ascii?Q?6cTS6zWLgcVf9Ph94dkjJm4N8AFihAc7CJ9ie5YyfDsjw6NcpX7yhTPlRu5B?=
 =?us-ascii?Q?RMl/pPjUwlqluUbmbCNwHopA3plN5Ve8JXG6u/HfCY6FYe84Ud2XEWMJ7Lfw?=
 =?us-ascii?Q?xbWrrMM4gHrw64tVGq35nHOJSWdLMv9mvP8QPAj5/4PRBev3YYHbzVS5mPWm?=
 =?us-ascii?Q?78gNhREhDjylgqs5fYaNPxRiVmFCUdEcWo44pPGfMdEW+VxoMHPegT6+QdXk?=
 =?us-ascii?Q?SKjqxDO9nKZO4uePsIy//hnlmnNj4EFE7DDSS3ulbTDNpSyUtQ/vEf1e148Z?=
 =?us-ascii?Q?mPpr4TaGy3hEJs28ZgoJ3wJeEKzogJpH/qF1O92Lnp8nJxbJc56o/uUSn28g?=
 =?us-ascii?Q?VFPLv8fb/07sWfoO/j9kRn49QZE1ApGNcXGpIExp/hAO5BO3+RpTP7EkekOj?=
 =?us-ascii?Q?MJ6mYtaytisPwAT2JTuphXc5hKNjzSiU56Mu650DoCh6HXSqBvUNFS6TkPCd?=
 =?us-ascii?Q?WT4ms7CsvWbVzwj45oUeA/UQawHVu1xnCNyZ0twnP0AZq1YB+lSDJoefRovD?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d472b4-6565-4d8b-a290-08dc5e550ca0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:37:35.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j98o5ZzKd7SETt3Asy6UIrZNUcAHdsTqTLBr1xzxLk9oHkmZnvtyiqqCAuWJ5QQOKyynkQHn4DkDShbLRYnerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Update to kernel commit 3e6d3f6f870e.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 uapi/linux/ethtool.h         | 64 ++++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink.h | 30 +++++++++++++----
 uapi/linux/if_link.h         |  1 +
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 70f2b90..4d1738a 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -2021,6 +2021,53 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	IPV4_FLOW	0x10	/* hash only */
 #define	IPV6_FLOW	0x11	/* hash only */
 #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+
+/* Used for GTP-U IPv4 and IPv6.
+ * The format of GTP packets only includes
+ * elements such as TEID and GTP version.
+ * It is primarily intended for data communication of the UE.
+ */
+#define GTPU_V4_FLOW 0x13	/* hash only */
+#define GTPU_V6_FLOW 0x14	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * The format of these GTP packets does not include TEID.
+ * Primarily expected to be used for communication
+ * to create sessions for UE data communication,
+ * commonly referred to as CSR (Create Session Request).
+ */
+#define GTPC_V4_FLOW 0x15	/* hash only */
+#define GTPC_V6_FLOW 0x16	/* hash only */
+
+/* Use for GTP-C IPv4 and v6.
+ * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+ * After session creation, it becomes this packet.
+ * This is mainly used for requests to realize UE handover.
+ */
+#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
+#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+
+/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+ * The format of these GTP packets includes TEID and QFI.
+ * In 5G communication using UPF (User Plane Function),
+ * data communication with this extended header is performed.
+ */
+#define GTPU_EH_V4_FLOW 0x19	/* hash only */
+#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+
+/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+ * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+ * UL/DL included in the PSC.
+ * There are differences in the data included based on Downlink/Uplink,
+ * and can be used to distinguish packets.
+ * The functions described so far are useful when you want to
+ * handle communication from the mobile network in UPF, PGW, etc.
+ */
+#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
+#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
+#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
+#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
 #define	FLOW_MAC_EXT	0x40000000
@@ -2035,6 +2082,7 @@ static __inline__ int ethtool_validate_duplex(__u8 duplex)
 #define	RXH_IP_DST	(1 << 5)
 #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
 #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
+#define	RXH_GTP_TEID	(1 << 8) /* teid in case of GTP */
 #define	RXH_DISCARD	(1 << 31)
 
 #define	RX_CLS_FLOW_DISC	0xffffffffffffffffULL
@@ -2218,4 +2266,20 @@ struct ethtool_link_settings {
 	 * __u32 map_lp_advertising[link_mode_masks_nwords];
 	 */
 };
+
+/**
+ * enum phy_upstream - Represents the upstream component a given PHY device
+ * is connected to, as in what is on the other end of the MII bus. Most PHYs
+ * will be attached to an Ethernet MAC controller, but in some cases, there's
+ * an intermediate PHY used as a media-converter, which will driver another
+ * MII interface as its output.
+ * @PHY_UPSTREAM_MAC: Upstream component is a MAC (a switch port,
+ *		      or ethernet controller)
+ * @PHY_UPSTREAM_PHY: Upstream component is a PHY (likely a media converter)
+ */
+enum phy_upstream {
+	PHY_UPSTREAM_MAC,
+	PHY_UPSTREAM_PHY,
+};
+
 #endif /* _LINUX_ETHTOOL_H */
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index 447d922..2503b26 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -117,12 +117,11 @@ enum {
 
 /* request header */
 
-/* use compact bitsets in reply */
-#define ETHTOOL_FLAG_COMPACT_BITSETS	(1 << 0)
-/* provide optional reply for SET or ACT requests */
-#define ETHTOOL_FLAG_OMIT_REPLY	(1 << 1)
-/* request statistics, if supported by the driver */
-#define ETHTOOL_FLAG_STATS		(1 << 2)
+enum ethtool_header_flags {
+	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
+	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
+	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
+};
 
 #define ETHTOOL_FLAG_ALL (ETHTOOL_FLAG_COMPACT_BITSETS | \
 			  ETHTOOL_FLAG_OMIT_REPLY | \
@@ -133,6 +132,7 @@ enum {
 	ETHTOOL_A_HEADER_DEV_INDEX,		/* u32 */
 	ETHTOOL_A_HEADER_DEV_NAME,		/* string */
 	ETHTOOL_A_HEADER_FLAGS,			/* u32 - ETHTOOL_FLAG_* */
+	ETHTOOL_A_HEADER_PHY_INDEX,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_HEADER_CNT,
@@ -478,12 +478,26 @@ enum {
 	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
 	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
 	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
+	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_TS_STAT_UNSPEC,
+
+	ETHTOOL_A_TS_STAT_TX_PKTS,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_LOST,			/* uint */
+	ETHTOOL_A_TS_STAT_TX_ERR,			/* uint */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TS_STAT_CNT,
+	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
+
+};
+
 /* PHC VCLOCKS */
 
 enum {
@@ -515,6 +529,10 @@ enum {
 	ETHTOOL_A_CABLE_RESULT_CODE_OPEN,
 	ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT,
 	ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT,
+	/* detected reflection caused by the impedance discontinuity between
+	 * a regular 100 Ohm cable and a part with the abnormal impedance value
+	 */
+	ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
 };
 
 enum {
diff --git a/uapi/linux/if_link.h b/uapi/linux/if_link.h
index d17271f..ff4ceea 100644
--- a/uapi/linux/if_link.h
+++ b/uapi/linux/if_link.h
@@ -1503,6 +1503,7 @@ enum {
 	IFLA_BOND_AD_LACP_ACTIVE,
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
+	IFLA_BOND_COUPLED_CONTROL,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.42.0


