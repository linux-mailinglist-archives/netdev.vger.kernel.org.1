Return-Path: <netdev+bounces-254765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBCNL7NBe2n6CwIAu9opvQ
	(envelope-from <netdev+bounces-254765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 447DBAF86B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD769301F30F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138852EE607;
	Thu, 29 Jan 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VyBPzejb"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D139284689
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685353; cv=fail; b=K2qO9XNoUM6BJOL8XN4HRszm4gbFd1G9di85X2yiSe8rnkj5LZ5WefBncWK/m8a9YpNqwqC6Z34r6pIlnIlrH60WqS4P+iOFmeJlLoPzoIHZ11b9OcWCKPzlG+n6RFSwE+mDUPdTs/tszxEEVZIvYNLoMNuZ29x5ECraQ5Q0orU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685353; c=relaxed/simple;
	bh=eE5aQkQombT3Nhuxs7LmR0iFCWh8YSgw5HfxYFMIUhA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RuFpQURxKZQJ/mItNHurrkb3ciLZ7nx8iQyM1l5b9tTbrfL/e8vH7CJIWoNqrQgRNED/1OyaockmKs+2DwbWETKHJl5m0HAIa38QUJL2fMTemMlIGJMpS/pmZZPan83iQXtktgp+1T/dH9sV47VFImjgIWNyoiYDBeoRGpuMtEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VyBPzejb; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojfQ154QXfS/gsn8gOmKQ9l0EXybFWv29T9/XReO5wdPET5BHIL1qssXjT+aN6XPzLcjWiPN9kkEzvm7ncAR1Ye1Xcn8kYfvQhBwzQJAC6wvhFmD2PAQJII/UzGShmvdMcEm8FILdfj4VdKyD7weEXKzAQtxlf9pZg7wzegUM+QXVC9ZF4V0Z6ZKCGUknwkBjVQ1DvLi0a5xGZN5WJLEhrj036gkR0lsQBqSDFtIspL+BgVF/tIxNHq84bVCR8/hDZRDTbW2zVaYP9U2k/AlBcDdNfp1DdUHGXLSMkMUb0L0JvSQ4qqFnTu+nJaoBqW9PaZpVCKzBRXuz0dHAuR8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWcdz/ow31G2CgRxOOtn99dxaxM7kAz2f67mNEwmaMI=;
 b=kl62kGhhRN8PvsiHWEfDcYKz8XDN52hZnydW96SfWblE+NbM6X2h0QFLmEQVjOX0Z386Oc/mK4Vd6l/NaxvZrP1ABaPlaMLpzxjsqeYR0ERMNHgp5Iy969VnGTFj5T+ZMXGar1Pk3Ax94N5PwINo6y5MJuShUGdbSMx/IZRlD1HkTEsAH4zmRQOH3Cumh4jRdJml3USLiXq3Qfb+HJAbpidDyfhSqitSbgCWty0SB95ajuVCZRNUeWnLSIwvmoNM8WEUaUdpH5HML63h7YaeuMzn0R6kOOOYemNtKg4EcOwKn0mWnPuYQJZH0CPxzySajidzxQuLPiG94icIAUeyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWcdz/ow31G2CgRxOOtn99dxaxM7kAz2f67mNEwmaMI=;
 b=VyBPzejbhk9+Wz6noZCNLwoL6xYf09x5HGhxFjce8HDxL8EdgPsV5ABHNvVCzfxe3IZyrviwpXAMKGyK4CDUdk4KAvnG6cHPOzNWndtOErSxKhVC/SyPyMLYnjMjPl/+NFIJAywhlwxhVgs6q3GFji/1kTaRUgkPmbWKMkD9+uM=
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 11:15:47 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::5a) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 11:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 11:15:46 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 05:15:43 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [net-next PATCH v2] amd-xgbe: add support for rx alignment errors
Date: Thu, 29 Jan 2026 16:45:20 +0530
Message-ID: <20260129111520.1567097-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf3b3eb-84e9-403e-9a90-08de5f27c04a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?raQHAe7dgWch7iZxRwNBMiWe7LhNBMLj7Wa+SeSUQnjE6J+12uIS24p9kXjh?=
 =?us-ascii?Q?u8C6UVbx9Tjsu7Cl+SBkvwGZYaDQFNzGpgawgWbmD07RKTMiJjt0etuqNx5g?=
 =?us-ascii?Q?VMqmPD/Ef96DzQPKiU5CAMm0v3WDfyvSksawdBTD3wKv57e+IIdAZu8n986L?=
 =?us-ascii?Q?DBCvgKvbdpOr+ZRQ77GefJ+ZDd2kan5H+8hMbWNSN1I/juGOAh0rPxt4O93j?=
 =?us-ascii?Q?pBT50h6oENBZzRnWHXtDpSZTEgQxJlO8LS7CG9IONbIf0ucBUmRMgRuhMU8x?=
 =?us-ascii?Q?Be9y4B5SH3bo8bAXmEx9mEGbaFKvfv+erffaGGXEN+Tg9hGd2PNBFG0v7i+s?=
 =?us-ascii?Q?dDua45H86+/52Kc3trXoL6ALbxzHhcF4fZwBgnIAGEIGAfwmfBe1KbOkIz+m?=
 =?us-ascii?Q?DAQP4WMoM7+5L7N0saIMLHBc2v4Ra5JQhTAj2rdZgolzF0I2MWpHFaUdsUPS?=
 =?us-ascii?Q?B9O+f0+SIcEXWulIE/hrLD6D8sSg4F2bAy1nnX8ikkNNK2tWb0KHalt3dsGa?=
 =?us-ascii?Q?q5PHtcWSpULvFinUtjFSD1o+9HvSG9zceYo2D0GBSeaSo9lsOS24RgLP2RnF?=
 =?us-ascii?Q?+Q5dARs/190dFk6zk6z1ViiuGV+Q+vdznrOTOVMM9tLVLl9Rk9ECu5XS4UjC?=
 =?us-ascii?Q?Sufczl/V10hLrqg3xhJspR+lhS6RH7va+QJSGytZFIhD6IFPDKqhm65L2zha?=
 =?us-ascii?Q?on5qO9Z6k0zu8A0JtWkVbBnb/G473WBgozo4Q3Hzl3PFjvNyEVF8AT/L0HtJ?=
 =?us-ascii?Q?tXRy00d6Tst+ry2n/7cVCf4su2q7+ZtfON+PhDa6NVjoAU77fEeRMQvgP4sf?=
 =?us-ascii?Q?j03OKaK6awJEN/gsTOopLFodCV3TVkmL9fGSu9BUyzAjHJU+cDPojU2dgVKp?=
 =?us-ascii?Q?sxjH2x/2z5R8PVcf6cDcKXgOAdIGeDhbzD1wjH++yx5tJptz6hoHrW+XitRu?=
 =?us-ascii?Q?N0PclymU/a+pzfwYWxDEeUKqmUJKgJC0gH9Tz8SdPGjtJjLGbjJGR4CG2fDl?=
 =?us-ascii?Q?oHFYChvAKBLBRwO6AJrQ6IlPbLvLnKL9NICOFjUXx5RVpxPXbEtllP+fsjX/?=
 =?us-ascii?Q?kGqgWiqCRzxZlflrzy9QaT5nJpBrhRIZnDTRHqvYtM14OAB8jEZb6SFekxBb?=
 =?us-ascii?Q?ovlVzPTxetE1PxqjhYPXCqzqcv4On6nItx9Xjxbe/k8WkJNOgl+sdSleq4KI?=
 =?us-ascii?Q?pCNB5u4Vj4sxRZ0G/K45autg7o3hfsbk5lhfIapP9Jfk0tJEswPh75OcjUuw?=
 =?us-ascii?Q?nafhNxKbFHQs0zSsgZPYVEmj/MpUdpqpKLa0sgUkSZ5ZzrJO3l+eI3ahw4sN?=
 =?us-ascii?Q?GW+TrZsv5J2M8p6L+wOfIq22VOZk2V8wzcCY2bJ1MFwlERC/vepy1ZNaK8Ap?=
 =?us-ascii?Q?KNPvk1DOZDUln13fu/W01S2aLorFVl5G3vouQC+O/cYsKC9bQhgGLE1pYKuf?=
 =?us-ascii?Q?Mh2PM7TcK5hAr3rqlVw6nvcYCxQzosd1FOHwG5iQ3a61xpqhJDHCEBKrp51S?=
 =?us-ascii?Q?mNLr/VYJKPNMVem2N24QUP9eU9+c9A4huFLqfvMGxMUAbMesQXk5QvX2Oq6a?=
 =?us-ascii?Q?rOhrU7zx/MVTsoT1Cu6/2ErmqJESLuCow4DKyLNO46BDYdTQWCo8MJDeuAji?=
 =?us-ascii?Q?LxInPeKkXvxLmLoto8ZCDqV10N7p0sC4hMWzt1DYo6jR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:15:46.6798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3b3eb-84e9-403e-9a90-08de5f27c04a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254765-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 447DBAF86B
X-Rspamd-Action: no action

Add the support to read the rx alignment errors and update
them in the standard rtnl_link_stats64 structure.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
 - skip the duplicate instance of rx_length_errors

 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 8 ++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 1 +
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 62b01de93db4..711f295eb777 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -598,6 +598,7 @@
 #define MMC_RXVLANFRAMES_GB_LO		0x0998
 #define MMC_RXVLANFRAMES_GB_HI		0x099c
 #define MMC_RXWATCHDOGERROR		0x09a0
+#define MMC_RXALIGNMENTERROR		0x09bc
 
 /* MMC register entry bit positions and sizes */
 #define MMC_CR_CR_INDEX				0
@@ -658,6 +659,8 @@
 #define MMC_RISR_RXVLANFRAMES_GB_WIDTH		1
 #define MMC_RISR_RXWATCHDOGERROR_INDEX		22
 #define MMC_RISR_RXWATCHDOGERROR_WIDTH		1
+#define MMC_RISR_RXALIGNMENTERROR_INDEX		27
+#define MMC_RISR_RXALIGNMENTERROR_WIDTH		1
 #define MMC_TIER_ALL_INTERRUPTS_INDEX		0
 #define MMC_TIER_ALL_INTERRUPTS_WIDTH		18
 #define MMC_TISR_TXOCTETCOUNT_GB_INDEX		0
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b646ae575e6a..c04a9c76bd40 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -2794,6 +2794,7 @@ static u64 xgbe_mmc_read(struct xgbe_prv_data *pdata, unsigned int reg_lo)
 		case MMC_RXUNDERSIZE_G:
 		case MMC_RXOVERSIZE_G:
 		case MMC_RXWATCHDOGERROR:
+		case MMC_RXALIGNMENTERROR:
 			read_hi = false;
 			break;
 
@@ -2997,6 +2998,10 @@ static void xgbe_rx_mmc_int(struct xgbe_prv_data *pdata)
 	if (XGMAC_GET_BITS(mmc_isr, MMC_RISR, RXWATCHDOGERROR))
 		stats->rxwatchdogerror +=
 			xgbe_mmc_read(pdata, MMC_RXWATCHDOGERROR);
+
+	if (XGMAC_GET_BITS(mmc_isr, MMC_RISR, RXALIGNMENTERROR))
+		stats->rxalignmenterror +=
+			xgbe_mmc_read(pdata, MMC_RXALIGNMENTERROR);
 }
 
 static void xgbe_read_mmc_stats(struct xgbe_prv_data *pdata)
@@ -3129,6 +3134,9 @@ static void xgbe_read_mmc_stats(struct xgbe_prv_data *pdata)
 	stats->rxwatchdogerror +=
 		xgbe_mmc_read(pdata, MMC_RXWATCHDOGERROR);
 
+	stats->rxalignmenterror +=
+		xgbe_mmc_read(pdata, MMC_RXALIGNMENTERROR);
+
 	/* Un-freeze counters */
 	XGMAC_IOWRITE_BITS(pdata, MMC_CR, MCF, 0);
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index b5a60a048896..62bb4b8a68e1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1838,6 +1838,7 @@ static void xgbe_get_stats64(struct net_device *netdev,
 	s->rx_length_errors = pstats->rxlengtherror;
 	s->rx_crc_errors = pstats->rxcrcerror;
 	s->rx_over_errors = pstats->rxfifooverflow;
+	s->rx_frame_errors = pstats->rxalignmenterror;
 
 	s->tx_packets = pstats->txframecount_gb;
 	s->tx_bytes = pstats->txoctetcount_gb;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 03ef0f548483..1269b8ce9249 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -659,6 +659,7 @@ struct xgbe_mmc_stats {
 	u64 rxfifooverflow;
 	u64 rxvlanframes_gb;
 	u64 rxwatchdogerror;
+	u64 rxalignmenterror;
 };
 
 struct xgbe_ext_stats {
-- 
2.34.1


