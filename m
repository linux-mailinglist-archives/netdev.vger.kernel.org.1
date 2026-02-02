Return-Path: <netdev+bounces-255909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOlgBLPGgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F7BCE684
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81BE300229D
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE537419D;
	Mon,  2 Feb 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q3/3YS2D"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794C246762;
	Mon,  2 Feb 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046582; cv=fail; b=P7HkULg+pshzQSiSyA/C/eSV9OL0eiMOfETopmNvOv7niBYQBjYjFyGH25IB3i4Sw73EAw+EhGDZnFihdhHr2uVqTle0K3fR0AP82+3elFH4kj3EZ7R3UfJHApZaWhazTo3NPhjlUoWyJAVjDf+K99/a+uWxAemlVMU9mObRgKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046582; c=relaxed/simple;
	bh=RI+HOslyILUyYC8R2GvivRWZrIDF2LkoMUS2gPZ7L4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC/pft90KPYTyQ2zruP++6prwROniZykGq+Ryzd04GfRtrdjScyM8g3RhG4odCflfjm5MLNudbkNKCOn5m8/h7coarPOPAWJUqMkRpnTY+WDf1r27ZF5PhJtCnwqZtNJOqUipnUdYHDyL0dMqyyv/7/yIZP0QwNNdV32as9eDj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q3/3YS2D; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWGvlMr6vPgXjcWaRkX7U268JgNjK7z9jeChlgN2KfhRUyCCJ68ITyQVUULWgpCK7YGDko/josofDeqHhdnZfVOzBPmoexrOZUMcs2Aip0t/iamrr3hSTkJeCmoU47s2id0dLqTnCDofYHbeKj5Y16au9tShnKV/q7qhkfVFfYnxgmJhWCKGVtv+s6ITYMN3Cu5U9k9Ijwy6V91zn1TAU5CJX55vENCn+1SGr/TDmUNLvrpZXvGcacmcGSPz6OZSQiES9qreMd9CMf8kPGpVuybAp13LXKRSlKZjZfRYiw7sxth3ye9zmiwNda/4TS7BfU2tWseKFtZeTsfIWyYcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKsGUMRiQFel3OqRAJH4y4gWAjpsbfjV0QSjXx6SJEk=;
 b=HuRQyPG0OEKa335nFDjYo7u2hD2s3zSh1S15NED61OgG5k+p6LdS3ziopYmHzxgSnTTDHCPfb0Qeb/lDTlLup9xZYjWNIBH98XpyVYVHbHu9XZPT1CNnCkmN9M+s7IsrHJqsoYFUQ5X5aXNrqcanI0GSEAElYZXNq3C6/tfN+NPl0hyiGc5K96+Ot87Dxnkpf6H1vZe7OGX1O0MZo3d11OLVZl1gfuFJujRrz4fg/AIH357U9WAWzXUz0pcrKYHDMAdZyMs+cRNGZfvneCXrfORjfUCImkTQ03ii0hytVj4Iz3BcGgeq5j9EXX1liSV5PwRNsXvdMtmSh9GYCa4dDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKsGUMRiQFel3OqRAJH4y4gWAjpsbfjV0QSjXx6SJEk=;
 b=Q3/3YS2Dcy8SqlaY0QrpPDPs1cYRVmmxQVcpuTLESl+K1aKTPGf0EmlRSwc6yJ/7MPspI0CYhyxUfJavZfjPrVsEo3WT1SmEDpvRBHBZMkOMRHC26tAHFgM+rVqotl1aE6BAdm4EvFPCB+V/KVUA4iFZ06b/vMZYsbak89HK4nE=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by LV9PR12MB9831.namprd12.prod.outlook.com (2603:10b6:408:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:36:16 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::bb) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Mon, 2
 Feb 2026 15:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 15:36:16 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 09:36:13 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH 1/3] net: amd-xgbe: add hardware ARP offload support
Date: Mon, 2 Feb 2026 21:05:40 +0530
Message-ID: <20260202153542.1727429-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
References: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|LV9PR12MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aee7c1c-5f9b-4cef-a1ac-08de6270cddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LtU/NneyFLetyg9WUClAr4Jq0+jADJCCK5dGlBSjpdS0JvR0RB57ZPDi5gsE?=
 =?us-ascii?Q?F/W7xwjtQtPvzy8GxYrCeoUprFOjfZ3EmLoG4fv2nUqqlXc9GUaCAlIjWbM0?=
 =?us-ascii?Q?plzQCY3y9jGY6OORYmQetzuCqH5NZESYekRLubWX5Nl/nUmbw3xjO+aoQU0B?=
 =?us-ascii?Q?/aFuvlSEcgPn9cmH0uEkJhWwUQvtgT1Xy0alxmSkJETIJZwTdIUuUYkQ7wuT?=
 =?us-ascii?Q?xKizoWaCyYt4YPMXT77rN1TfWGrgunpm+8iPFbt0QOu9mUcYe0cmtI3JnGSI?=
 =?us-ascii?Q?MzIMLt1lO15wh6dMixL4MaY6nshGYCeL/IUX5v9sIPLtKWgRzey8/e7jmHzi?=
 =?us-ascii?Q?UC/ovBL0RtMUE1+17jpcTG7+ic3TCs4vxKDqqSpLCDaTfavSRce2Jro6vSKA?=
 =?us-ascii?Q?TB6Id4HrupKjOLHxgJSaSHR6Eo31b3LSBH2s5gPF+m/sLcZF75+Zfw0lAl1g?=
 =?us-ascii?Q?qKchG/g8rylHbM50pDuSKIjQBCYRaGovnw89EMl6vRQmZsb34nTTqO88iRv4?=
 =?us-ascii?Q?WJGZxOWoMXZO6USZvkC/f4hmyTNkOLUrKyiBwWE7Pqw79fOAKT50/jhrGhsT?=
 =?us-ascii?Q?nY1gkr1EFfes9B7z8mwD6CFmxeiHPJuhq/6oMMk294gvZ49bYkNOhqTo1bcD?=
 =?us-ascii?Q?yAE/viSi2A+xUIDCsVhdt0zuSRGXEADvAPZkg61yHjXmV8rW0Aje8KQ12jLO?=
 =?us-ascii?Q?ywvkCb5EW6tP/KnMrj7+PTbhnytgqb7FxkjUwKrukKfPGCaMvY+g1gwpJJd/?=
 =?us-ascii?Q?nDPeqTiMfjqokJLoV/Rpx7mJKB4GFKPLNHKoEMquJYtYY7Wzw9bt6VimrwtL?=
 =?us-ascii?Q?ojhfC7V/Vi0jadjTjeZTsb8INGBTfjun4N3fX84fR4R32t+AbclP+jdr5hs1?=
 =?us-ascii?Q?1tpCC+aflBXiNbv1JeIlK+F5qmD9AId34nW+MXpgib5FUo2YojsIKEPIftiv?=
 =?us-ascii?Q?rDp8AcstQUuQGs4ANN9HlgkIDbsOg1QNAYaFy8UZjGSFHsyTfsSrDNyOhV4E?=
 =?us-ascii?Q?FG2t+Ouuyg2ZdahBYGdL37OSZ7oK2P9n7apyrP+QObG9Tsq8yfTX/R6z6MOS?=
 =?us-ascii?Q?JXi4Y9iMZHPbGKUDksbcvuOWNIIgyTRnnyYBpvbl6DE/MmqznPbXt9coot+l?=
 =?us-ascii?Q?Alk5hibQ+4+G0sIVGcAdbCfJn/txTAQIahjpk/Oe6m/YlNDtMlP2vhca1Uqu?=
 =?us-ascii?Q?EDvi8jJfbRHZE+cX2Inr7VDe5hlu4JnWWfF6BJlt/J8Z7GcFh/+a/aTz5HA7?=
 =?us-ascii?Q?CXzaZ1Q3haYBjknvoq+pSKh4Wm6lPKMixl81DvZbyOP8bHNG7G/kgu/CJu8V?=
 =?us-ascii?Q?uvHm041vHsTXDbB0Y9H4AZG5yp5GszGK3QVIsX9miSlyZtWaw6YmI1CWaGg4?=
 =?us-ascii?Q?SMzoFZkL7FST7euj6nlBpEWq7+TZ9UUtjn0vbH/NsxAsugWygy0SP4ZeHB0R?=
 =?us-ascii?Q?ue2sQm0dgfam/42FMEMvkwkNCoAeLRCAl0gWJrnVEsV0PpPN698VgGNtAA06?=
 =?us-ascii?Q?haVn4MTNT7J9Tqnb1cgctgbY/mxtNZ/b25SyZRm5DHA4QTt+0SfV3c2RayfP?=
 =?us-ascii?Q?2mG01f6RNE0lnsS6qODSDsa5ApEz/01NH3KulDs7ah5e6ZkOwL7fGVR6nP4V?=
 =?us-ascii?Q?1ocfTzvB86/Hh0w+PN6X9WgboEwysZlL2iBlI8rmtcz4klS4Hs356YxDTdgq?=
 =?us-ascii?Q?QGqkPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1S+QaG7eWb8nwqS6sQc6mUwavWofMI1o9W/Oxz7A+FkfBKoFmGzuCNZEvUKPzIM9jRF9rZaDTwotvTQYKaLVxchrIwmeYu7qkL8kx6DkzP6WaBCf7sxSsjAd8aIIFBVhgUpbLB8iU3xBfhAFS+8UZtNrRYs0RqvcxfiWoPkmfTDUMv2yW0dReY9jsEwusbzzNTGR7vKOIKgEmHnH76gl1G3j4kg5Y/yAUZqmqXi+1BOQjbSMK5dOHLfmZiSUxpv9/8LK1CO7u67kcd1ztbUbJmYZHWpyXchEXbrC2BTkhBNVzCggtftthMtO8y4MM4XQJwbTPj+eO4KjJ/Akoji9+1T4o/KUKFxfGEMrdJ+kp23uU/W6a6zx9tpY2Jz+sh6Mx3PhdPOpJVl4P7F9Yw2H660HlkAe0bZplJSqjy5DhZt4zx6pnAYp5Qx81ouZyT7D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:36:16.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aee7c1c-5f9b-4cef-a1ac-08de6270cddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9831
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255909-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 67F7BCE684
X-Rspamd-Action: no action

Add ARP offload functionality to the XGBE driver that enables the MAC
hardware to automatically respond to ARP requests without CPU
intervention, reducing system latency and power consumption.

The XGBE MAC supports ARP offloading through:
- MAC_ARP_ADDR register (offset 0x0c10): stores the IPv4 address for
  which the hardware should respond to ARP requests
- ARPEN bit in MAC_RCR register (bit 31): enables/disables the ARP
  offload feature

When enabled, the MAC hardware will automatically generate ARP replies
for requests targeting the configured IP address, without involving
the host CPU.

The feature requires the aoe (ARP Offload Engine) hardware capability
bit (ARPOFFSEL) to be set in the MAC_HWF0R register, which is checked
before enabling.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 24 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 62b01de93db4..af95326c6b51 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -210,6 +210,7 @@
 #define MAC_MACA0LR			0x0304
 #define MAC_MACA1HR			0x0308
 #define MAC_MACA1LR			0x030c
+#define MAC_ARP_ADDR			0x0c10
 #define MAC_RSSCR			0x0c80
 #define MAC_RSSAR			0x0c88
 #define MAC_RSSDR			0x0c8c
@@ -400,6 +401,8 @@
 #define MAC_RCR_RE_WIDTH		1
 #define MAC_RCR_GPSL_INDEX		16
 #define MAC_RCR_GPSL_WIDTH		14
+#define MAC_RCR_ARPEN_INDEX		31
+#define MAC_RCR_ARPEN_WIDTH		1
 #define MAC_RFCR_PFCE_INDEX		8
 #define MAC_RFCR_PFCE_WIDTH		1
 #define MAC_RFCR_RFE_INDEX		0
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b646ae575e6a..761195911f13 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3597,3 +3597,27 @@ void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata)
 	/* Disable MAC loopback mode */
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, LM, 0);
 }
+
+/**
+ * xgbe_enable_arp_offload - Enable hardware ARP offload
+ * @pdata: pointer to driver private data
+ * @ip_addr: IPv4 address (in host byte order) to respond to ARP requests
+ *
+ * Configures the MAC to automatically respond to ARP requests for the
+ * specified IP address without CPU intervention.
+ */
+void xgbe_enable_arp_offload(struct xgbe_prv_data *pdata, u32 ip_addr)
+{
+	XGMAC_IOWRITE(pdata, MAC_ARP_ADDR, ip_addr);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ARPEN, 1);
+}
+
+/**
+ * xgbe_disable_arp_offload - Disable hardware ARP offload
+ * @pdata: pointer to driver private data
+ */
+void xgbe_disable_arp_offload(struct xgbe_prv_data *pdata)
+{
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ARPEN, 0);
+	XGMAC_IOWRITE(pdata, MAC_ARP_ADDR, 0);
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 03ef0f548483..bf08628a7ce3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1333,6 +1333,10 @@ int xgbe_selftest_get_count(struct xgbe_prv_data *pdata);
 int xgbe_enable_mac_loopback(struct xgbe_prv_data *pdata);
 void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata);
 
+/* ARP offload */
+void xgbe_enable_arp_offload(struct xgbe_prv_data *pdata, u32 ip_addr);
+void xgbe_disable_arp_offload(struct xgbe_prv_data *pdata);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


