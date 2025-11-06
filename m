Return-Path: <netdev+bounces-236211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992AEC39CBC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520FD3B68AE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D655630B519;
	Thu,  6 Nov 2025 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+7au1CE"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7E747F;
	Thu,  6 Nov 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421028; cv=fail; b=L8wlpbw9tjtOjBKNW+fRb5oy3qPZtdFyjAxbx7bcOdvkgpRFtrbRz0BObJskOdlofMC4ygr0wCuyUXSr5siMjD/pp9v7N/ih4x7wzkgehb3F3wflklTBjlaO7JsAa/k11zFE28QbPG51HCyPBLTOHb7sV1XWUExUFG1BQMkZjL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421028; c=relaxed/simple;
	bh=k16nDUN/5X6g5mhQ5kmNja/3WwHux5MCI3Uu2IBxS0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N96lwa9IDRJUoC4+H3JDCmsPlATLl9jK/Sxf6JCf/6+lREefiBwBvLqqg3UhbGIIm/hkkl4Xo38d7zSelOXW4Y19Sak+BioxvdOvq8Ns7hZir3hLBt4PRlgCYWDYUGvxWEIAKb3zx3GZWNJzvDJo0A603loN4KAJze6LcC4Kp+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t+7au1CE; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeX/4d+OIQOh0dWFRi3ryTuQQ2IkPjprkHT9Th3FcHJ4+JvwDfgoKPrlqrPNrERAxnA5gRJwaCqC3848mBsqXvfc7sebeYXlXhNxyTbyiMbCpSZ6vNZgimRmSO6nqYZKu/IsH3W+0ysZBFHr1RRLGmC7X9FEBE+j75era0HhDvZajMsdKkd9TB8iHsmr2GZRDEcqAptDXXOtoHxBtWOlL0XSKuM69HNZnQ8kDn7wOOdS0gJMT3fhY+4TD8qSystzXJM/p4Pv1Q/+OEqeMQRkpxqC+er4pTmJf1Ss7fyXGRDbcVBAKN6lx0gOg+2XSGb09R0zarzvy+YErxJ+snVujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX4jT/zmEvlSE5OpC2TicBnOhnZOBAVSvHAib1iwpRc=;
 b=jGw7k+8rz8aIySBZi4ogGGml0oXflQx+f0UUBMtPStCApfxI++fBjeZ6NoBHAZw1OMiLCez07OLpFh/XpmPt+qA2/J1fYelPD8JBeclJUkldQ2DHDsCenH6WvOTXneHwbXhmrzK41kCcfDILCZ/pEnd305b5qZZBDcLrpUCM418YPJ6RtmPtbijXWR9KLLgfUKFPLHLO48nFk+dz9FUkoNgozHe7Od5XX458WiTfRRbBLOgD9jYZkB/tNbGeqtTfjC0Tzxd4Jf+H+HIi293Gp4duBiZumGdz7rSW1XYyW7S1hkOvMQ40RgCndYXkKDIBiwbMe5Q+kgM1JNSyXiLyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX4jT/zmEvlSE5OpC2TicBnOhnZOBAVSvHAib1iwpRc=;
 b=t+7au1CEeSSwozUz2FK/z9+ePCAnLwU3p1fDZxxSue/AyBXshHNZZwJr0fALpwMxthMAdAY+FPymylkARvKW1BpgXkx8I/GYVDY1Z9Roq1a0Hu+IMtne8Vf0npLfY5JFOX0U5L2M3yIK0503txGxzw8vFTk/AYXrGgP6QGZ4NuQ=
Received: from MN2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:208:1b4::32)
 by CH3PR10MB7233.namprd10.prod.outlook.com (2603:10b6:610:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 09:23:43 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::ee) by MN2PR15CA0019.outlook.office365.com
 (2603:10b6:208:1b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 09:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:23:41 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:23:37 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:23:37 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 03:23:37 -0600
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A69NXmm1034235;
	Thu, 6 Nov 2025 03:23:34 -0600
From: Aksh Garg <a-garg7@ti.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH net 0/2] Fix IET verification implementation for CPSW driver
Date: Thu, 6 Nov 2025 14:53:03 +0530
Message-ID: <20251106092305.1437347-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR10MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: fcebaaeb-ad90-448e-3ee6-08de1d162ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zrY7DWFjUtaUC1x9TElx6IR67oKNICOJ4EGVegRqyLuHK9vpy+OIVOUVLpG?=
 =?us-ascii?Q?p/wAGpHmHRPr1Npmwe2dUNGHohBhuRQHnlHIuKdLz7mca5pJwP9pcuBUi3vW?=
 =?us-ascii?Q?75BMr3k0+LhUAjlHmZc5JWej9CJESJnGwqlXqxRKNFITVrlmT/A/PNHLNJlP?=
 =?us-ascii?Q?ReYc9QEihCzy0ZSIlYc0+aEjAbRBt2JOdfe3FM9kdTiLFwDgRrLmyIaGmAD+?=
 =?us-ascii?Q?ycmPCUA2TT0iPDcC7fIxnkvvVoRGPcG9URIXC9blOXyuvGazp6taCQIr7CAS?=
 =?us-ascii?Q?oEclM76g3C6KlG7D25YzPNOyluZ4Ki1tXDKN13cK6CxKjhp0emgsAxHcz006?=
 =?us-ascii?Q?6rdaiXDWyGVJ6tZbh8Mwf8AveVk0DnZkbKs3GQarR9Qw1nZAjG/XPA4VJg1f?=
 =?us-ascii?Q?DLerBDSPguVKu+5LqQuBQh5AWlMMoEWmguz1TKpG+ms5CcFbTTEXKJmio9gF?=
 =?us-ascii?Q?DmHXVvY5RYeuJBQXnrlk2/rvelA1ENrzcHsn+7IAEfUJa9dPl3eUtJmT8sVV?=
 =?us-ascii?Q?V2FZoluolJXoswqkTWy4SDmrYoBdKxNJmDPjDAtfEM5ayFj60D8q46IUiCPP?=
 =?us-ascii?Q?P1SCYqNXiPyr2GGnmhOPj4/OIw6TKB8Q/6StZspZZ5jcpz4bfeuRa5cN6ZA2?=
 =?us-ascii?Q?QnOGgeJrZ/oBTtmUo44xyBCKuo8XoSeVhHk/joMQuHd7ln9UOiyOK9msE8sM?=
 =?us-ascii?Q?k6CNVzj5uT45eoJY81AkKw6ABtc4VY62eY412kEPQmDfJd6/e0Me+L4QZT81?=
 =?us-ascii?Q?gSeBifOMUFD4NIr01qFoxBxOgpKYWbrwvETwpykvGqLo+FJzd0bj9ML4kJXP?=
 =?us-ascii?Q?3F4caD1gGo9dE0NwkZ9+HqrrL5lUeeDYNAQmjILO/ILEHqEpjApeWqRYH0SP?=
 =?us-ascii?Q?yibK3Mgage6pYvCM8MLq+ptzHuOddgoYVkPpPfEIttls/yLeVfU2sqgwePPH?=
 =?us-ascii?Q?/XhsP2lXFjdVnFa3ZUB8vvSCbZ7ZORVI37bw5pmbeemjbs9DAKlUFWfpDW/L?=
 =?us-ascii?Q?3qujlA/UptX4AnYLFzfzaB5EKZoIEo66rgPgrqV4Oa4zzyo8ni5WTQuGWVOd?=
 =?us-ascii?Q?4GNm9TPxuQtaATZoEPLeRS0rxdu+B4EnEWBVjOpW6Exp2VYM3ypkjf7NHKkx?=
 =?us-ascii?Q?cq28UTEj97spi1GWlgb6hUrX2VplW3Rb0oG1b4V+mKHa8CpFK596MvwNSXbu?=
 =?us-ascii?Q?J3KHQAf1BlSw441+zYxN2hHYjzDgdGvdIeN2+hD6/aE7tA5+ve6a9kKTbMWq?=
 =?us-ascii?Q?+0aNv2BvA4tVFZMU039UA1HrPiDQ9TQOyKXSXirUqZdcznezAG9lAjJY6NFj?=
 =?us-ascii?Q?TbsezKiALgrA1OeC7yFiYfrXikinX/9fwHgezdogzISfL4uvsFLHAyDpZgdn?=
 =?us-ascii?Q?Me7lTRGU2HBRhx7go8Pr7Fi0MWa/xRqu2jaWpu48UdgNJnzss5XRTw/10cJg?=
 =?us-ascii?Q?V7bU5ELljmT3ku4CoXJ1pEUUq9bHrm+HWIVtUC0zef/GUgublZc4R87KNu2C?=
 =?us-ascii?Q?+gxYiBDtocHMwinV0U5wF1K5MWw//o6dcC/JNSCsVAbeXCWd372ccVvYLS34?=
 =?us-ascii?Q?esAaEOToxWNxzzzIGC4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:23:41.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcebaaeb-ad90-448e-3ee6-08de1d162ce3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7233

The CPSW module supports Intersperse Express Traffic (IET) and allows
the MAC layer to verify whether the peer supports IET through its MAC
merge sublayer, by sending a verification packet and waiting for its
response until the timeout. As defined in IEEE 802.3 Clause 99, the
verification process involves up to 3 verification attempts to
establish support.

This patch series fixes issues in the implementation of this IET
verification process. 

Aksh Garg (2):
  net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
  net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism

 drivers/net/ethernet/ti/am65-cpsw-qos.c | 51 ++++++++++++++++++-------
 1 file changed, 37 insertions(+), 14 deletions(-)

-- 
2.34.1


