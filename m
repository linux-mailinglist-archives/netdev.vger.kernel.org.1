Return-Path: <netdev+bounces-272209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hc5FneCxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:01:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAE833AA20
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4DB3307F550
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D3426EBC;
	Thu, 26 Mar 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SgFCCtie"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC3426D29;
	Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551327; cv=fail; b=PtCHz/XyCA2iybvDLRcXxksB08NXZakKEYPvWUovCABYq7ngkU5zJdWlaGpowrEk64WdPuQ05LeYhXnacbpKOnOpDWOSTW3iaRZvzvUF4OswaCygefT7cRxELFTPjyvG/kkmkrvzd+2CgrsBvMlzJyBU/WinHSndtepsHgSB6I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551327; c=relaxed/simple;
	bh=Hj51bsHEaR9q/eCWx3OGIikyeRR1ixuhNrGD2+8ONs8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNa8LAmigiiFrCkZLYHdTgKBY/voPuMTk+dFRwxX6wp0r4Xlf1GmSsP/Y3IcvmyTDrs+AY6O/wdU+KXcVCZtLuhpvy5GlWXSv+yqqOTvTR73vbLUHVfUcG8d6f8bXee2nFyX27HhCFP8rgrMj8D9LwDBiJeU5fnSK6M/L3vaFrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SgFCCtie; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yibpGYJ6JzKfv2ADy2NnRLyK3wXfDjCQrJfMzOkUCXC9XqTLqTpbafXXYZgyu+9H3pb+oRTQ5TOxMO5XP5whx1fPzCi9UmY2BOdgITZlNxUCOr+02GFs12B7DDpXqCO+JlpabA/5rvxKr99eTZX/ruAhmPojZvVbmOq+W5ZUFEMs+cXXVR72wT2XMisMTAikrBOGBhmJsWFVj2DJx8VykxnK+/NbmQN2B2qZkBRExRSkdu7I9fFcpPyjvkuXdvffeTvq/opDpJrDo6PBvqpg4UYgjCJ16Xn2ESSfHwtboMw8xh0ij4JHdTspQzUMevri7Od52gs2GyMKgVshdSaayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiz0L0xlqs4WTumHwdZBH2LzZMDEmvkBffFlvoDjP4Y=;
 b=q7zy2f+61ZtRZeFaRYYBXNPf0o9K9F/HaaAjQ68NgVlELtv5zNkYoD046ge8+S5sdNoxOf900iX7g2kbqjiN/IBy989ohrC/HGxGWZXsKMFyQ0dY/57ZcK3qSgwKkjVOTvs0p8mcEuD9ENfK9b/CsPiHO91sMWoTLCC/3ia3T9DtCgrax2RU4It+0BK9yjQbCThJRhUQDTMPwge6CJ/x3WCOETutQZgkckmfkJPKDRWf821WLB25vuqAkPfUivQ/GyvlUQb3eUU8rFfAg/0RK13hc92RxxqlVxGyQhHmqyk881nZDz7w+w7FTBlYkdd0kHGBTR6Bs0rHzFtVboartg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiz0L0xlqs4WTumHwdZBH2LzZMDEmvkBffFlvoDjP4Y=;
 b=SgFCCtiepgktmUk/JEQrivSmY8wvyK2x99Iz8Of0c0vZRwgWALu2sET8udTPun27spQV46Hvvb0tnaYxOzpyBay/Ru1CetzaJ8i+xGJO9HXAUjmKgB51zyHw/c0tvP+RUw0X7QdvATGZwSGlyNIzeQPE4iZOlGuERt08R+TjiZE=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 18:55:18 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::d5) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 18:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 18:55:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 13:55:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 11:55:17 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 13:55:14 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net V2 1/2] net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
Date: Fri, 27 Mar 2026 00:25:08 +0530
Message-ID: <20260326185510.3840084-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260326185510.3840084-1-suraj.gupta2@amd.com>
References: <20260326185510.3840084-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: e296ebdc-198f-4b46-6eac-08de8b69396d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	19uRujjrEswMKI+0E316OhnR0/Rv8AsmwjlegCV7aiYb48sAjz2b5gyy0JUAlQsRtMcxHtxX7F2iNYa/GZNSVYqTfNVOk9iguo/lsAL7izDWK/pzqAmA5zJaVJI+3AvZSt5kn3qG8ulwnZsUsLU3+7fSy/tPGGulc82URtskSOvIr5w0kEKZdWXEsMGSHYudZhu3mqqzoto+ehBAW7i6kYvwT26ciXaYRofl0blPayzTuzCJgOCgHSJ5NHfmo1xIJDtJpYyH5cPQg0yncafz+8rZDw7/Aq0YPbkkRZT3jY3T5FCd7LKXOZ4av4dzzkbKLEVNxDD8+AAxFfKf3YFEIOIu7kE/wJvOfBXPorkV1inxuZ2DmKY9rXnspoirohzJEEov5MPtqREagUqPhi/5y/11ZX7pHI8mk56yjJfodVLdvxMRtzCmpos1VlzNJAajGPTI6o03NLWhBmOFksjSCsejLYGHHf41syY7YcOUdWdsv6zME8Q1BBH9zNdvAMGfoVO247yT6PsOe0KU7yKGwgyFVl+sNmLdnwpzn+er9y9/KODST+6feu3D0zJVBNlIws0HyeELiHxUFz4J71KyILVfarJjcTtjxxq87okxgCMHqMcwzsvlujTg0OJk+YATKdvQ18UM0BwnKf96UqtDoIdUbXQJyMTsr33OuKPbrPDvirNjz5zs26tV8Lu8VpFZBYmTNXH6jqMrnRIXMq3KgRJqd/mJI/p+HxKmr7sZYbgdx1y8J+yfAj86OeUXSr1TEPNGvW4AVHYeVFngUgggrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N5UtcK8fBvoMaUXXB5aENkLiCgWdTAozMHPhX+oGR4gWSJ+qsjy5L3wHFa6ZtafedHKAevzhR/z0Q7WlqwlNc6F9bjF2564ONykwSAK2ioaD9uYjUUE9/77hP8yGQ5xiXo1W+IOjKQF0XqkKlYnjSY0d/WoXCZ9dKZLUZkVjiH8uLkil84NEHHqr3wdyoS0p24u0/qDxX1OIGv/0ZyxkKio5bw3i3dzytxqSvqD9brUKj+WUhRiX02eaTwGlkX9GkawRObl/iPH4uoGmm/aMqErFVHXnpnXO3x5yuD5lCV1jpKzcuSaZbN455LIQdfvhMYy1enGSCIOLB+2kCmk87hu8PJ69sZj1wUvSiPMK/+8lEymXwuGLYhHiKAVElBPBNQQ5qSv1I3eDWK+CPvnbqTjxSdOHC384vVBfzhZQ/Ulchvx+9+HLLelSaa26fpZK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:55:18.4107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e296ebdc-198f-4b46-6eac-08de8b69396d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272209-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1BAE833AA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The XAXIDMA_BD_CTRL_LENGTH_MASK and XAXIDMA_BD_STS_ACTUAL_LEN_MASK
macros were defined as 0x007FFFFF (23 bits), but the AXI DMA IP
product guide (PG021) specifies the buffer length field as bits 25:0
(26 bits). Update both masks to match the IP documentation.

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
+#define XAXIDMA_BD_CTRL_LENGTH_MASK	GENMASK(25, 0) /* Requested len */
 #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
@@ -130,7 +130,7 @@
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
 
-#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	0x007FFFFF /* Actual len */
+#define XAXIDMA_BD_STS_ACTUAL_LEN_MASK	GENMASK(25, 0) /* Actual len */
 #define XAXIDMA_BD_STS_COMPLETE_MASK	0x80000000 /* Completed */
 #define XAXIDMA_BD_STS_DEC_ERR_MASK	0x40000000 /* Decode error */
 #define XAXIDMA_BD_STS_SLV_ERR_MASK	0x20000000 /* Slave error */
-- 
2.49.1


