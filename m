Return-Path: <netdev+bounces-272425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KjlAJwzxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:37:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC16340829
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6204D3072F49
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8D3CD8C6;
	Fri, 27 Mar 2026 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lItGnB3Q"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FC3CA488;
	Fri, 27 Mar 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596784; cv=fail; b=g1ZKSjyi9a4qTh3qXVpWH/UN2sn1CAwdF/I+5dlP11Fe4cAY/qDguIalwCDI1fKmGuUQbGSyS3yl/j78PSXjcX2Zo8lpw1ptybUHL1MWFFYao0X9KfoZ3MxBHutj3JQFxOi+TR6khp6KCjVsTQf0J5q0JAVgUibrb4GT4SDjy1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596784; c=relaxed/simple;
	bh=pHXua/xWyysumeCNu37/jfee0xC6dQL+UBiJ7R/2NLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JX4J7GJ0TxL1ZvgLLbfJ12Y5Ce2pWoGJuusgWFdb1K2a+UXAKLcQglcyKd3iFENxurUlt2Tt5Ebvf1I/JORmCcgQnvwevcgT09teuYTr7BHtu9FPykLJT8JNun+HwIo/lhuvq+GGRyFrxD3Y1clW13lp3mPjLrTbAZ8YLhGnLzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lItGnB3Q; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPI4prSzGhw8z4wUmYVC2bwNTtrJPOxBRq8hI77vQ8scFfjUkLI01zCPn7tzg5Oflh7vW76iHUn8oY60O2EDbcZf0/qsz8SGZKq0qsBVJ1nrpmtLbzaKsx0Fo8JRuFqqdWnA5CgmM7qPCBjF04asgmxBX/2SEKKufRHQP0i2j1ZbztlTgQNJtFhKt22atH9X2uAEG32xxMND4P/yQsAZ4pkFHv/qm7+RcorTWAmgC0Bt6D9T6mYw+VTrH0ijUs/MY7C7+hb7Dy7kgzhEnhzym50/OmTuPFUfQGlVgwKJAp9pFKLN+YmWS8EKIuYb+E6KOFb7BGz1h8ItseSP9hOltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xhSVILm6T/zSffCtH3N4fCnj9bYLNROyPODphCz3ZQ=;
 b=UzCnPxMU/F/ZK2pOvjOXLX2cE2Xokd3ItK6d0e/aQnxkc+2qe4lq/N5lhJRZqlELbbUKHMYaZBY0Jzg2RlREgE2QF90pBqV3sjaN6Fa/l0THe2e9kdd4K0+bp6sKpIe+PYKqHXyVM4xl9YUxC1joAdV9P2yLiolVxjbR+qEinoA+eUNhc47QylDQJWuRORm5ODSqHzm79PYGLStxTbPPgbWoCw01JHZWFZu7TCw3vrvse/6MswsiDPr7e2KRJ8zPnAa2Fg0osKgUHFJ3Gn4K2yS1SEGsVG9gCFwCDSJtY0WqbQzrdr9Lz9v/05J/cFqm+ZFcvzk6c+linhdbh7BFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xhSVILm6T/zSffCtH3N4fCnj9bYLNROyPODphCz3ZQ=;
 b=lItGnB3QVp50sq7I/eYjMD1ci4UP4TNfIGXTI4Sgrm25DM4POTVgBgPxJWn8C5qjMyY/UL0zEIXVFq2unWr6PECW47yjuY1cS4W2KLOwO4WUNQTKrHFirnQPsPoWhhWlIT7yO9QybJyon/zHvc1O9Ji3Ga97OsHjyTBeszvIock=
Received: from SA1PR02CA0015.namprd02.prod.outlook.com (2603:10b6:806:2cf::19)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 07:32:52 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::29) by SA1PR02CA0015.outlook.office365.com
 (2603:10b6:806:2cf::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 07:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:32:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Mar
 2026 02:32:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Mar
 2026 02:32:51 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 02:32:48 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Michal Simek <michal.simek@amd.com>, Sean Anderson
	<sean.anderson@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, "Ariane
 Keller" <ariane.keller@tik.ee.ethz.ch>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net V2 1/2] net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
Date: Fri, 27 Mar 2026 13:02:37 +0530
Message-ID: <20260327073238.134948-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260327073238.134948-1-suraj.gupta2@amd.com>
References: <20260327073238.134948-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b377bf-1fd0-4a4e-e8e5-08de8bd30e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ju541Tqzw+ZavXaPUEp9YsBMpQt2EFglsJZz1V4LcQywL0vKVaFyEL2RQCsjTkT6OnfylQm1Qz3nm8hfm1RHGMBARdo1YqkjadvNIoH0FFA2DX3lHXTgczuEDrYPhufcKUINfzVvAo0JKXrTpe7b/GcL/xdOkFkb/iSJ3WgIIWlA8H1UjPDGdVRfM4U53Thq7SUrcvJ+zdb+8saZhimgxivbDTSOBcQWq67ulDcR5Pmd580hKLZa6OzBwlbkzjbLKWAyzNbZ9Yt2TZl7i5RVIPmjTbumKotFtnrVfCaOttsM3UhYBidHr4cxC2SMpqfL6iDivWv51xFwbXuNXrSyWnYh5ekXkntSd9JPbH7v1PEmt9vihUM0AuLnvZCd1DRd1YkPr/SK4J+EG12ZRRw/YARvQjcs1YVkYmc2dUt8beSbZKPVsiwI6UOX19aUeqpbANxLLYOGlB2E09GG6Ml7QjbxgSo84OtLd/3sKD7Gum5bbIXZ3Ztt2qascZgaOoxlL1U+3BwtZalsAypGvFeZ97ITEoR7/kt3ozJWs/pbSklilhxVRtMNP4goelL5zAo7Ga8OmZaHZL7Ex5fL4XCoTh+BDUwGfSKFN9Y0TcJpyk62QginRWR8C3qgm6h/y/vDs+F9au/u+mQpwmMlvoAR4D7HQPnfdEgadKR6kJQnLlJPPilOppK8hUG5Rel2SzQMGNPGUwL1ipsR99DKLPNUJYF8tnAvPkmjyt21+0MpuFuDrVr9yRMxIrPp12jvE36VCRhx/qMVhDmeCnKk+PW2zQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yo5w/8UGI5N9JL3kNtFyxCDjL9CkFGBeFQSHGAFV5B57iheKWmO+ZZl7G0AtFObmpw7eOHSx4fn7Efb4n0skPoeVee5gbk29cXW08j1898h72xT5Lh/L8LdpfD8lkKR8ikmUFFmjIppEmNAKt1vesDeUzVDy5Xu7HADVxEm3PuZP+o4coV5VgVwxwDx4zrm0Ayfr1Z2DRX0JaCjN7brswEXOU0STIVdQPmX9p6qRbDAIK4Sunq60iVYSx4RhI+EMAqqap5otJyJGhBReCOPW/BpiXXMFquyl3FUBEF8EKorVKzskxk4cdnpZx9GLWbl6gZKYWLUB2fg6/jwIFEwwysLq6JdwIG964K9LDdbLN1gzbe54Yn7qZuM1bvtUb0VgxwqgpOeP8CSBX7RfDi7kaNgjuiiDjRfdLirHrUBCfGAVJ84bXUjyhNyufLVvXcRP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:32:52.2789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b377bf-1fd0-4a4e-e8e5-08de8bd30e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272425-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2FC16340829
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
index 5ff742103beb..fcd3aaef27fc 100644
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


