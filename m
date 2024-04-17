Return-Path: <netdev+bounces-88864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67A8A8D12
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB901F21B61
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4541C62;
	Wed, 17 Apr 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RfG/7jwN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FB3D0C6
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386368; cv=fail; b=YgPZQOJ/Jq17xmuorAqzykdtt/GcoJFa+X9TyNT/c+EtQUYkTYh60eRppRAPJSK1uD9KfI6UovXwjyQTOyiDnHSEg8M5jOg6j20bWnraoXcD+dVyIJOzk3T+fDFfV65hI8lOriD81R1ptkFhC23ZXnOqY2zLTz+WpzkseIlLBr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386368; c=relaxed/simple;
	bh=jgqEC0+hAc371XO46V8UyVrReQfg3lwIeQXa+NayMeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IbivKram8TR9nNBItFbSnIfQQeL9FYrtaU7pPIl92WiOCM+Vaa5BPnn0O8CRcT++2evR1NAelgRYpaE2e5Re2Icbjwlu4fhYJp/M9NOjMIEflDUy8LNxaXDvC8S5FBaD1Dii09zazC7kQjQ7BUpsWtVz540hlERAty/yNq2J4YE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RfG/7jwN; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeVkBp5ItLyx6dY+xggcKBXULWqSVmaU9hH1xkc8wHn+MXs0VTsVGQbduH9YCkmzaIv0bZUeEQbwjUasV/Gb/phg0S32x3Al+JKOXBhRg6Hvl40DzqzUW8WqDE/DCm7pFqzOfjI/RBrnUE9qU+RV+44uj+KvfDyr6uI6VExvJEfoEXPXnL2+Ec4laadAQSL+exL84mT9tCuSLFiOvI26CdQLAgeIJYq425cY8sS4mNUxEDcen/Dhb0MNa3TJA/KQBtFWI/vnY5uqkANePxePvWggc3Dchb41Fa0AhMW5lE4RVnEzQWXTpfdJamtyFeQRyKs+kfOo31pOlZ+/LoAt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJXSa2jeKERof9nIQI9tcfoWZL4xnpaDaW8XIpKSV0Y=;
 b=LekYZqt4SLt53U0/bN31jswcP8N6bCmSIqOzSlONVXU5oxEzYk8B0b0KIJaylKEYVHzMJNM5el9eSAbcECvW/jTz4Gte4gi/fn0IUUMGPcVargjsWPCTChz1ArLwKnFvQLVRX9qdt0rXhm4/Cax5xQoTGBTpbXturawJAqK6vUnjvbzptmnqGhN+BMA5RStd6DtA0f6WGRK3q5SfHyBLDyfK8mK1UsptzWyrQ06KUTTFgly2hqVEwajlhzq/1yvBGtbw/QMxLfCVdsg7NZZQ2XFKsXGc6ym/Alm6AdTkzSnRarNhruz/PmSN+QWiCgfDm8wHSI9btIebrAke15TUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJXSa2jeKERof9nIQI9tcfoWZL4xnpaDaW8XIpKSV0Y=;
 b=RfG/7jwNrQ4MUhVKaPzmaZkalqbqAgrNSVez0/axlEnp0Y4RjEI/ljln52tgs19SQk/ffqVqXLg0R7swoXMkrsYik0nG3pFdDcyGeZMQBb1/ZxRCKJo0sUuly1U8a1jBu2YsxNBn2isG5YsG5uru3nrBN8zPpII6ZCmHCGv+zk+c6TvfbZwZGbLbJ7X+Jl68TdisznwALoe1xqJp22LXWfvo7SHtVBbkFfJXtvtHhUX91jWwDRTgJzm65TXpWDkEgTcRJxBmRDFUDmqF8dU7YgTYkW1Zw4VTyNbY22HMXL6BKVFrgJo2wrTwIgVff560uqgk+LfsTXSIGqte3ECERA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 20:39:20 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 20:39:20 +0000
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
	Alexandra Winter <wintera@linux.ibm.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH ethtool-next v2 1/2] update UAPI header copies
Date: Wed, 17 Apr 2024 13:38:28 -0700
Message-ID: <20240417203836.113377-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417203836.113377-1-rrameshbabu@nvidia.com>
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a61b02a-11a7-435c-a018-08dc5f1e752b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l+yUfjqlLepghNMC2kwFZszqVIn9tg0iQrzF4lFYi8rRQLdceE5hkhLyGQyKepKj4gR7i7uIY7L9lmupIGkKmd3ezU1tQl+Tp7Zuo9Zm0JnYTYOxCqKpc4IVOPCCTr+3nvIL4wnCZ++1nP3ZWOAaudd2aT1VFK1eNFoDNOpNWPP1QCXuNIYk8ZIUYjsw0PXx/hQwqeN6boAZ5rzaCnmbH/sHXnIqrA5fRyoiUMKFyrxSnpx7bwuwKIQXD2j+5amFJGSDms2opGWnYtTHKyq0TG0Zc15Ne5sMomrZwZmFw4kuq9h1ppSqVVQITIwDyDVY7b5ptJX5qvVwpmcuN79guQGamiQUm5oDs75QgND9gZdab94n/f5c95Yrk1IjWZCkPPi86m0eNFPa8lPAwbh5LpGGrKvY82Ksz9WOy56BHUoe+nuqQLHELMLmY1r0+yIPkD8ursMtnCyp7JdvC3aoSOOrLlSg7JLw+NaK7Iv6lxj9IPCZjcFdFeo3+5c0deav9pwWJGtcK3x+qFXcdHaL2ClWNFKmKB/iy6gYs/YNIgxHlO5sfJCqZmXbga7VVXSJLN+aoXimeN1jpGSwiwDvK8ONZhcqMJoH5ESsJ2AstNaH+RUq5d+8h54XGGckCu2nIaQ6mBSfb2PPuZGXFE52Va8qrGqMV8leuwjIoYOvkic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LRd6iecQBBHJ1Ghs6Spq9QvfQJ2TFhCkzy9YkmFTAn1ENRS+j5gk52MU4p0?=
 =?us-ascii?Q?0jBDvCWhSMO5sn0ss2y8ftN1jmpnXgabPY23Fd7FgIXPHXtc9MmThYZJvpoX?=
 =?us-ascii?Q?Al8soyY9/wdw3hD2e5j5y/798T3rf4fQv/Js2wZ+9oaxXS+beQrBJVz598JN?=
 =?us-ascii?Q?cJukqhD1TMxfybpcmzF5Pzis7O1cYPkAWCE3pufWSPjIdVVjjSHiYEUuQxXR?=
 =?us-ascii?Q?TsiFBSa0W55rM5ZzHxZnaoGPojKJtMgxb5a3EfGbf83U+gpLF5XbPTP1D3qr?=
 =?us-ascii?Q?izprxP2sic+ofW9bSHEj3zBHN2FNv+d9xSstLgxEFXoRRa/gSbyddYr/9xtv?=
 =?us-ascii?Q?pJWNiRPF8rrr8Tadd65u/3rM9JH8lNW40MQ+wmeHMGd/tN3YVyI26BwYsaWX?=
 =?us-ascii?Q?EsAPF+KNke26dQgBdpjC3Z1LJoSfJNFOHwYOIxuemp393eE/seV9cqM42WEY?=
 =?us-ascii?Q?7e/Aq6ubxT+DoA5t2m2KLRtoNwsdzlF2Su3nAcQQ0dmEm435wq0UANUvYWDx?=
 =?us-ascii?Q?PeYxakRRVdaLObxHKsNKp+caGQoJ7dOFbge9jYX+LaYxN/T/1ToLJJvY2BS+?=
 =?us-ascii?Q?y3isL5uCBK7HI8NvsmGtiSuflJ8HeDc2Sb+3SULXn1e+Nq9e6A9W6NTkwldz?=
 =?us-ascii?Q?xiYKJl/tPFILCjATtz/SLcYWVY3Jt2L1P4m1QZNcBYgu0bANmiZj5DCiggFS?=
 =?us-ascii?Q?vZWX4fUkofgVmEAC98szUxhJ+/ltiyuOz0iJNVQM9m2bb76Df803F91rLH3w?=
 =?us-ascii?Q?QPhURY5ozJZA46O3U60QCXMUM1sCv8cIptrqSlZshHkdTklPqauqOlb0nndF?=
 =?us-ascii?Q?RA9HJTotm9V9WhVLLv9mIAaphDAboPvFGDlFis3TCyUdheV+nS7NBeI+DE9p?=
 =?us-ascii?Q?wYmVpI3RJyRP+jfO9YMRwBDx/sIbnpXI56bn+P6akKKrKmmWgUOreLK/mFiR?=
 =?us-ascii?Q?x4XWMKWxIHpYjJmta7bRGa4Z2UtLhTfACDhHlPkIfbhJY2mpRhmwjCRKZokC?=
 =?us-ascii?Q?rrga3pE2gssqunxCuZe2KA/k3NDB37e/yAJT6x2UHWw5drDOpTh4rDeAcwRW?=
 =?us-ascii?Q?EZ4ggOF337XpjTqqyp/U1CflmKcEKIDdi4ss5kP4iVVhY2h8Tn3EKq6sx713?=
 =?us-ascii?Q?neq7DFYVTkE6E0zwYdALbsABCPSTABUBBXFzSb7jy0VmC0TWkT09SDk7NNQp?=
 =?us-ascii?Q?7Me3P6K2ECkw//90GjqXWIAuYRnlmgQy8+ixnTRH+0Ky397C4yGZZ83stMOW?=
 =?us-ascii?Q?lhdAHD8XCj+xv+TN/djGvwMCK8VipQarEpW1d9EUGx/Rh9hDeoxzM6wKAPiH?=
 =?us-ascii?Q?24s/az15m04ax2xFbnQFTGOhJuZGI8F1YY5XBujy3HUs+GPfLFlOazQwnlws?=
 =?us-ascii?Q?NlHTQFKEx8RpIl+OCxUCGYTW+sDbj85V/d0J/aqwwSPfcd64sXIXAjGoCeID?=
 =?us-ascii?Q?GuxMMa7Buw+eHVVZg4Jb+CTUOHKumcSpECQnL+SNmFAxjqU6rCe9KQT2WakX?=
 =?us-ascii?Q?LoWVMuWDco3/ri8WgUV92aZTxfbzj/X+owPjSQkV5Xyf6PYUU1PGfjuIMsSx?=
 =?us-ascii?Q?VeU8aBkpX5G07sSvPnzNaS7g1yZSaIvIEZkrvh2j4XEwzVjxHfhI/EBvh/1v?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a61b02a-11a7-435c-a018-08dc5f1e752b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 20:39:20.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3cXYMLWl4qBkazWsnWJulGLAu9W5ev3yb5ZMBVBkZBE62+RTpirUrdafupVw7+F9E28+sUh/uREtSmDy3jYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

Update to kernel commit 2bd99aef1b19.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Updated UAPI header copy to be based on a valid commit in the
          net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
          the catch.

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


