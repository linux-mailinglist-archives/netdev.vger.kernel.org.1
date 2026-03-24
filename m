Return-Path: <netdev+bounces-271116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJLmNLmlwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:54:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E130A8BE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0EDA3049AA2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E65401481;
	Tue, 24 Mar 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4UF9aRFR"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF41DFF7;
	Tue, 24 Mar 2026 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364053; cv=fail; b=GMUlD6fTNK1PUG8msPIVzRiRCVzdw8+QqgOZtVZtGc3Eoz1Xgli+O/F7R5+bPNRMEocozyMF4NALRieYsJHcvEa7LRSGRYZvPsLLI7PDUiLtFwPVDitmFnbjmAxbY93DIeYBeFcXNWCZGomSOvICqdT69vLznSsjua8qImsq+wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364053; c=relaxed/simple;
	bh=ocG6lbN5HsC2TWF5SZKDGmDEIWMjFEkeV+c7Mfm1jt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEMgB2dgspWMvcYMwpQhdVrzjgOGodoDFthyukuwiWC9k30uCnDkA9eF4i9urn8fH45W3ra46XIRJSrT6XSpKvM6feX5BuIwXWNcRWAgTeESe1CqILQpJWw1RqBI9x2YFPnw+i/YofxPCloVgrlOZTdkITKJQ5R6H/gbQIUR2ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4UF9aRFR; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKArF0PvvH1yymg1Oo/f3nrL9maZiIQ/kS1Sp/II9OWKx93xjUafcaaNUk7Zv1ZxjOuM8ey1nzVzT4Z1HaaBhsdJWBryEXjSMQCa+PPqBtr3GoFBPK6Nwvw/mvq4JuBVMHx6belS/p097gy55Hz8dg+AkO4jc1bWskdy0/TBiMD9NJm3/ZEb33qYp2Gbqhwfq/QmHSW0sJqYXFRWCg9A0S5YGE5dw3pn5xn0JUaeG0+T203NWJD58LvAdntWyhkr1X8lfazKGMkHlUy3Jf7tWVu4MF8pAsjKLRWUidK6ig117o4AUh5cvUZ/zerxmmjtBhhPAVusNTcBIQXVp9Rlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKyVlC3L3q/GFrdIQXeJf3+Fpo3lYHSQW+ig37+Y0tg=;
 b=QoLbGqBgZG2Lh3QhhJ8OwxbJivoq2RIjo+56HEeFrK2EdzguR5BQs9o/Ys9DqXS6L5uCkAPJNXBAVGZeCZ76AY6lpj8Vo2atz9mzzm0unC0O4Ej+ohvMAcsDMpPmA8y9gPiTMnZ1inYFS+vF3fwiw2/z/FopOz+ovpVM6iOX2ZRaM1QjkIfnp7ftAx5j+vypguwywJWKpTbWImX5vWEfML1uidSJ4NTkavzKh770WPiM5w4AAfeEe90TN41qCRcA0qTLbWZELxRlo4kphYKHUJPvgadj6FpL2ZeWlJtixMkqIpFH80w9jbXgggl5bUb9XKni59ou4hobyAgMhbT5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKyVlC3L3q/GFrdIQXeJf3+Fpo3lYHSQW+ig37+Y0tg=;
 b=4UF9aRFRAEhVDVPyhAMhfh+rJTsSXwYx0QRmqv3/8AFMpt3ICCZeefpz3M/V1ok6TZUE8Dd6mVnNi7rSvVeebYGVyq8U0y6FuazchYrYenHIUH6f7+38S3vxjhDZrPGhSWmTr2X7IH5DueWhNpIrmlxYac1Pds1aKW4KDwfSBZY=
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:54:05 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::5d) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.6 via Frontend Transport; Tue,
 24 Mar 2026 14:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:54:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 24 Mar
 2026 09:54:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Mar
 2026 09:54:00 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 24 Mar 2026 09:53:57 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net 1/2] net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
Date: Tue, 24 Mar 2026 20:23:51 +0530
Message-ID: <20260324145353.1899248-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260324145353.1899248-1-suraj.gupta2@amd.com>
References: <20260324145353.1899248-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bd650c-1948-4812-e029-08de89b531a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Luze1oHRHbb1xL+/AI2VNPRWsPUVgEq0gxLzIXivSTDqkt0WlqZtY2wT6OtTE4d4YQZzgDSTivcbTLoC/P/C4fZDXOKzBhb4vNB4rVlxGfjgoMZE+mbHzwfR9VxRWBxXQPKrR5WXqJFV+mOmFAYQE96BZKQiJSx8RQUcIoG/NSc+Bre9CDhNJWw01wJHORIWBZD3dgFZZq6nRLp8wDN/JDeA7jbGC4q8Ag+JR3A2LE/upGZDRLxZMoIo3L03sa09BoimPTM3xXzkBLo1Pu2tgAUT76t2NXe+V0e+yhutq1UV9SxghwdUvSvoR6YWHwLVshWPXQaF/05g4qtELeZlsKrpgXtYwrYmy++OMIINz7FRdPpiaXV9jpDrnId1/NK+7NRy+vdE/saF2nDeKrDK6Xi+iaQQsJ6DZCXX+eJmm293mJJMo2nJKNtcac9f32guWpDD3xHtrFShcl97vBj7ig5r3cd75pdUBdIoF8XpP12ZrW4dMMgE6+SJuNW6R/kp+3y3zksT2LO+/JQyLFGNdkTv5zxt9HMyu0QMWr7FMBOcLh/kDJ7LZQL4c+CEEsy/Z5WSwb+0ew4i9/fD9RJJlsIAh8bKDD1p3SHcbMoKb+vaEN8ymnai0fwWhb0m3yU0fdOKPYOeNEb6R2WsWZwrYQmeFecWj/5eiKwnmu3JOzRs2e+RzDsZo5XUecNxhe/M1TwaUQviHwd+fZoNWaCOW/eneZAqvSLKxBVxse41nkohYWuYP/ZTTszJBpRFyA5sp21bTwncXB0gI0/fcbOK3A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H/6p7MMr1Z1OmzC6E7sevTkVX1d7Spg2LSBGr/vL98I4XZl3vVE4lyPwT5h/6jir5hP8fFnybP1mDh7VNs4ODzeMItKUxsuBOBqLGhcc96qwsPCXX56KQOLTJdoxC7PjhFd3NKqARdL9VF359w6I1fOfe2wkE9VQLUksLwRfp4T3nP/W8BOrIZFiTE2nhhcePvdLLxwgsxxxfZlDY/BbUd9hfMSKCmPMMvhjqkVCeA0d7S7R2aWTHWdrI0865OQNZPFwEPbzucO3CJqQg70cfDieJFywmWcN8prPWR2M8T5Dd6IqqpOkNzbuQgEQhSv03SmNxhD/HUxPJgkRSDzRBCuk5BM089rTsTdosuPC38iLbThc4/zHmgZ7DN+/xYtIsQBq++4hMK3xs3uZ/gC1c0MrhyPy6IF5qU/xr76VsA6juh69vgXDQnO1FSykYGDu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:54:04.6846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd650c-1948-4812-e029-08de89b531a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A53E130A8BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The XAXIDMA_BD_CTRL_LENGTH_MASK and XAXIDMA_BD_STS_ACTUAL_LEN_MASK
macros were defined as 0x007FFFFF (23 bits), but the AXI DMA IP
product guide (PG021) specifies the buffer length field as bits 25:0
(26 bits). Update both masks to 0x03FFFFFF to match the IP
documentation.

In practice this had no functional impact, since Ethernet frames are
far smaller than 2^23 bytes and the extra bits were always zero, but
the masks should still reflect the hardware specification.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..602389843342 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -105,7 +105,7 @@
 #define XAXIDMA_BD_HAS_DRE_MASK		0xF00 /* Whether has DRE mask */
 #define XAXIDMA_BD_WORDLEN_MASK		0xFF /* Whether has DRE mask */
 
-#define XAXIDMA_BD_CTRL_LENGTH_MASK	0x007FFFFF /* Requested len */
+#define XAXIDMA_BD_CTRL_LENGTH_MASK	0x03FFFFFF /* Requested len */
 #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
@@ -130,7 +130,7 @@
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
 
-#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x007FFFFF /* Actual len */
+#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x03FFFFFF /* Actual len */
 #define XAXIDMA_BD_STS_COMPLETE_MASK	0x80000000 /* Completed */
 #define XAXIDMA_BD_STS_DEC_ERR_MASK	0x40000000 /* Decode error */
 #define XAXIDMA_BD_STS_SLV_ERR_MASK	0x20000000 /* Slave error */
-- 
2.49.1


