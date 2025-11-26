Return-Path: <netdev+bounces-241907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBCC8A1CA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5703B014F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3A328B40;
	Wed, 26 Nov 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="JwXUBcv8"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B33239E9D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165365; cv=fail; b=GDfis/S3zXcwBPdtEsmdHs8x2JGXjbrY/TqlT2pNifX+BQW78cdGq1dlb84L75lqGHvsr9tKvkgGUIY+LNa/043EHCfsB8DB4FIb+tnItKR/40y6FofYyhIap+z0Zhe3CGqxaC8mdTWi3xPM0Anvv9i9ZOecqstxQQmEVcW2xZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165365; c=relaxed/simple;
	bh=9QOGjBSKx2FOJ5846f30PO9rAI2Z1gfOHmmxxb9GV/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBvIghU4vzyBps6BfI1v9f/YmT4u8a62K7tYEo6NJHVpM/E6MYZM2MgaF3QvjiJe2lscpNP7XhG01BMlvqJ05RMIQbyW5MXNuYNOMVb8QQNg/RxSWj/L2Mb3NaE7plyaFy29kZwQVjgXOgrOZskJB44Q8Ai22kKYNl70Oqn6YJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=JwXUBcv8; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck8mSKd963O67aCrqdT/naMyiy4vlDjmhY24HYOeRhie0/ZXQGyngrrgG1Pf8F+GsX+I0y9GpHT5RFPo6s5bom5gB68QJM2+HDKf2pJ9VpzDjAv+kGFiPWOg71zREGcrlGVqL0AYQf+Ca5YCiFg1ujM4x0+LY+c9cVj2GGoXPIAZ65/hxAhhPb6l1oTriTVm+ewZYI5Ds6a8lY2kbM6K67KYeMDSgz9whPD+rk73cVZZLaBXCqqB6dojfcHUyrnUYjFvOdsTlDV3jCRDoqP/pPX9GVOFaRQiKwq20p+VqEL4FT5muYwcOUxJgwAQNHG+ydUnpkxAYA98XWXZBhecxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiXUdzENInuNQGjpBvuor3Pame4tn+0PYf/c7xQAA0Y=;
 b=lfbuCUOWhpxGncJDaYpUryvip6Lu/Tw4Idcq1e+yMRCnnHOO6DwFs/Au+Y7DvZvsq4P7Y088pc3W5Liz3DwFZs7EbgTlb+KKCzYymJW6bKBG5Qj5uUapHEPmKpWPZgmqxNpmBL2sExwGxUPD79wmh8jKXpW836j7YEPbd2rVUMDkEXuHHTDneU8esc9Fhj560/vZKpUPQ8QbD/2eLv/nOKUhORV+sByW0kMO6pDgD5soSYEClWkTKQ24tplNk4p2Nz0Tz6alTNUf2pYAHK413nlGV9nMinqke2vSoNkVI0Vqt7k63kf2E2OCddqxSooJiGS1Ky7cp51zPO6ZqORVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiXUdzENInuNQGjpBvuor3Pame4tn+0PYf/c7xQAA0Y=;
 b=JwXUBcv8LVzs1UE4L5l5jbHf9oEGKIw2TVUIrxrPG7A5ganuIq+kkDwPvH4Z80GsyUsYdOHAzLQCFFYhAtddzrk74TD8tBvHcdLISxCjpCMCxtYxuJa/kMZmrpmi2sh3PlfafmfxT0D2USSd78kUYPh97Pk/bPCm7f2uzY1SgJo=
Received: from AS8PR04CA0181.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::6)
 by AS8PR02MB6790.eurprd02.prod.outlook.com (2603:10a6:20b:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 13:55:59 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:2f3:cafe::42) by AS8PR04CA0181.outlook.office365.com
 (2603:10a6:20b:2f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 13:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:55:59 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Wed, 26 Nov
 2025 14:55:58 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 26 Nov 2025 14:55:58 +0100
Received: from pc55631-2335.se.axis.com (pc55631-2335.se.axis.com [10.94.180.160])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id B17B5473;
	Wed, 26 Nov 2025 14:55:58 +0100 (CET)
Received: by pc55631-2335.se.axis.com (Postfix, from userid 18910)
	id 9E1AD438B5DF; Wed, 26 Nov 2025 14:55:58 +0100 (CET)
From: Peter Enderborg <Peter.Enderborg@axis.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	Daniel Golle <daniel@makrotopia.org>
CC: Peter Enderborg <peterend@axis.com>, Peter Enderborg
	<Peter.Enderborg@axis.com>
Subject: [PATCH net-next v2] if_ether.h: Clarify ethertype validity for gsw1xx dsa
Date: Wed, 26 Nov 2025 14:54:06 +0100
Message-ID: <20251126135405.58119-1-Peter.Enderborg@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b072d237-2bc0-4930-a8f0-2adb7eb81043@lunn.ch>
References: <b072d237-2bc0-4930-a8f0-2adb7eb81043@lunn.ch>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|AS8PR02MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 700eb388-d04b-4cb5-5f71-08de2cf3873e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HCNY1RAJ4rl5MLZJ0uM9ySI4jhjBvlBLsuOe8zdk+0nGQEzf7v0SWMJGCdnz?=
 =?us-ascii?Q?QTpqGoNeovSoHPoLrnJaRaUZLnu22iRfepXT8I8oMB53rvHmeJc4U4hIKjl2?=
 =?us-ascii?Q?bKe5e6tqDqo531WWyousKUyefE5GLOmVVwIhv2+lb8Yw55+LQhWtFOSAbJV8?=
 =?us-ascii?Q?1+eoFDi+HbYp4apoC0LCA3xl8e0RSUzib8tsGDi4QY5bfqAukwfy84DJdMN0?=
 =?us-ascii?Q?NgpYmBN7IWQV/oAdsdyXqEpsnvSZDig5qqzP1b7fCVD4CeMMG0zqYiLNCnLb?=
 =?us-ascii?Q?OdvD8fT27uKi3oH32VvEzWeqRf9BjYGvbC+EeAyVCYrB3uJhxzncOpdmuX/1?=
 =?us-ascii?Q?7kODCUZGBDv888xsRpCHH7fkp2xxSQsY3gjghCevGGEgHG3jnHs8hBB9u2nf?=
 =?us-ascii?Q?Q315T0GCz31/UHiX8ucvTrzYPm0SwgrFam3AURxLPFH/PUgLm1dtDcHMrt7e?=
 =?us-ascii?Q?T0C8z2buqtU/vXm9jSs39du8a5mLDeZbHgOVIRdYAJjWjprYS3Wwu6INOf8K?=
 =?us-ascii?Q?qLsXeQAXgOb2NsJqlF2B38QmtD1991HepkD9PN1JUuz5N7wLFU6hrenAAuQe?=
 =?us-ascii?Q?OCvU89nCTMvD/q45AZGJw8Y3VxoHjftZCsy8FKlmbs/A0G2pOH4bmYC7q4CJ?=
 =?us-ascii?Q?Mq/uR7+hOC10G6v3hw2Yq9rTHVw7JfN0V426UBkGJ6s/8fbVCG8LajW0HJJs?=
 =?us-ascii?Q?B1oaD0Cicyzabp8omWze3mVD/nrP+IGzzlTXDmFfRUi2RRiBW7gl0XakxiBt?=
 =?us-ascii?Q?YzN1hl8ndZk8puUsyFFTegbR3bVyfGZZmVRqG3UNR37QC0LCXdO7FakOSMJh?=
 =?us-ascii?Q?xdHcrk44b+OSQFFuwfKPXhsud6TrIzFObeBBFvTynCrcRGTFFMVxbXlQJ4Fn?=
 =?us-ascii?Q?yqdnXmvgy3M6A0jM/c5tBFWJkt27BtsTvUWnCwQDqq2iXO++9DnQYyeiMUNg?=
 =?us-ascii?Q?sWUE52Tq3Geh3R0hfMEwpDAY+VsTavitCuNhnb45j1PB5sYT4Sjcj9aLaatf?=
 =?us-ascii?Q?+xfNb+Zg2tZWW3Neez6HYGcYymh/jKYYEUetG0mo0nG7Rq3nlptmoWGXmDMR?=
 =?us-ascii?Q?A6mL1DT4+AQrvUbMTnZIuAsTz0ybNLqJK/9m/KQRWjzSD+cdZ4wFXYfYfEfy?=
 =?us-ascii?Q?ItXQodjenLTMvt3p9rWK/TEvKshYgMAmYnehqZLyoW8wWCXUqGVxshCIh4Hd?=
 =?us-ascii?Q?ASpAGil5ADjy5pynsRQCo8bev9lxYe5TMLGiS9amWK2U6Qfy0MLPiFfo+ghe?=
 =?us-ascii?Q?F0V0gfNWTOsrh3MNwqvBoYUdtyBeUy67osB1IHkxuLiGXwaQIT7mSZIraZuY?=
 =?us-ascii?Q?K7t9OBoWDVBRlLFQ8jVQy/ai3B7q9DnjZ5id7qtcV70aq0v5KWHLI5aLOl7J?=
 =?us-ascii?Q?9NgyKSrIEPDNQBO/+LBdZq8rJlR5knb/tAu3MSxZ2Fv7zvTx8+jGWUXB9dMn?=
 =?us-ascii?Q?LT7wwTJ2Ga+tzq7eWAfHi9I9/fsroWCZThHzfdig5k4N2CiA1kfCiHiza/7L?=
 =?us-ascii?Q?QQBhMYQcVE5yGAUOUVCzOU5gtvYIM4hNb7UbeZ0jqLGr9Ab3S1VVV59PkjPx?=
 =?us-ascii?Q?iR+0Hp4dptjJsMXq9wI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:55:59.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700eb388-d04b-4cb5-5f71-08de2cf3873e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6790

From: Peter Enderborg <peterend@axis.com>

This 0x88C3 is registered to Infineon Technologies Corporate Research ST
and are used by MaxLinear.
Infineon made a spin off called Lantiq.
Lantiq was acquired by Intel
MaxLinear acquired Intels Connected Home division.

The product FAQ from MaxLinear describes it's history from the F24S.
The driver for the gsw1xx is based on Lantiq showing it's similarities.

Ref https://standards-oui.ieee.org/ethertype/eth.txt

Signed-off-by: Peter Enderborg <Peter.Enderborg@axis.com>
---
 include/uapi/linux/if_ether.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 2c93b7b731c8..df9d44a11540 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -92,7 +92,9 @@
 #define ETH_P_ETHERCAT	0x88A4		/* EtherCAT			*/
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
-#define ETH_P_MXLGSW	0x88C3		/* MaxLinear GSW DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_MXLGSW	0x88C3		/* Infineon Technologies Corporate Research ST
+					 * Used by MaxLinear GSW DSA
+					 */
 #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
 #define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
-- 
2.34.1


