Return-Path: <netdev+bounces-256729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GXhFApgg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB9E7DB1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B3D304B824
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D72BD012;
	Wed,  4 Feb 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kC0eqqxp"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3E285404;
	Wed,  4 Feb 2026 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217307; cv=fail; b=YXEzy/p3LtaTTG6b54wkgMKZgIalHe3+XbkKAiDkkUCg17SUvhbDvLZPNw3TnN0q9oJc6Lt8fKf5ujLrF2nB6k0cysk1yxuzXI+4dNDVROOvdlpw3pbVFb1Kl6e7hyMNuqgOAgesX1bpVQTdLH6zszVHQmHk88PI4bth/GDA6RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217307; c=relaxed/simple;
	bh=kO6ef33M51YT9rDY4YmFArc3UUGe5Gu887Z+pcgmL/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udbID6cz8ILVB0GhFZnXOd30B7qdslG9L6R2p9XZT0GGLB/e1/kTuT3y6avw83iIPcmH0vF+8UB4xnalvGYjCplR8Q+vESHI0dMmH0el7wDF14sJ3ZicJ51jR9t/sbrOhqP7Ciqz+1R9A2DEO3dJ7edllroAenTYSL+0JQ3peGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kC0eqqxp; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM2kbJyjZKACnXvUQnIi51gEOCO+RWyE3OiRw4LRUDhvGt8G2J3TpnkMb6C7GUpcrVafh6M3DAoTj+oxR61P93qCh9LIkqIB0dajoGtbreoWcL//SbZeHLCMW0OC9l7jBQLZVORGTR6P+nqSzk6j+tU1wwz3hMRJPCn09XotJ4AxFUZsagIGho1d/D2ZumgSjBu4yAsqMOGltd6qFkS/OXJPMdSXw/vkFv2F2qjmp691OGwq3ePwnNJOZ0/ypwu6WgmDSeMIz5PqnwpsHhY+lBjHyxhRq3nxg38yevpO2lRSX8D4JpsYeb1qUOmfHk91R6PYNYOT/yalPH+vErG/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXlxgRc+uSyrnjAoY5z+tf3p33Kz/wqtWR84z58TA0=;
 b=bpH3T8X52iba7e4/q3X/Tp1Qcrp9qCD1d7Ok/Ry35SYLHUHClSUX10l4hDcrARTqbf12KZ9DBaxowDh8KeW9A7TrdUOhO51TsXaI7/GAgpA7GCd+QUytVKxxcdDJyGhQip9wNKSrbBlczaEWB39UUye+aG9e8BjotJDvEp8gCwHFSw80TGGKQ1qsI7fmJv2045TFAilvpH8LC1rFru6asSKRDR1kR+XxMLDQbpbG/lwDTE0J5mH77zdq+BqzcIbbHx+rr0VEJFwwMqJHXgPZ67jWX+7jMtb53bEBzEI1AU2D4b08LXlIie2TD1oK11p4pAsyqCsXilZsMex1SqfpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXlxgRc+uSyrnjAoY5z+tf3p33Kz/wqtWR84z58TA0=;
 b=kC0eqqxpy5fsPEB9/iF0FFn7xjCi0HRHu20faYu6MmVVSfCw9bkotgC3BOPVbEeyfjN8K4meKSXJaRC4qzzZECUIfSBc1vTXQqhy4pMI+NBtGfFlfPkXAJHVx906sC67+y8DLTd7OXPgZHZ5KLMQk2+7YLhubEzTecnqlmIaTl0=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 15:01:43 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::c9) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 15:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:01:40 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:01:37 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <maxime.chevallier@bootlin.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 2/4] amd-xgbe: add hardware ARP offload support
Date: Wed, 4 Feb 2026 20:31:08 +0530
Message-ID: <20260204150108.883994-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1512b925-506c-4c5f-b179-08de63fe4d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbI0+bmrmhCh7rQO01YXlbCzGf+xWjN5dl7G4u+0dZgomtKfS7BwZkdqMGXm?=
 =?us-ascii?Q?vubvMwvcMgPSI91+Rj9o0Ui+Lcza+IuN7WQnvFDnAlCqiRw6HFVa3VbIClEI?=
 =?us-ascii?Q?wy9SMVJ103ivSohhKfiNVKVCwgqci4yec1QeI6q9OSmQ/4qKQc6QWrrF0dwm?=
 =?us-ascii?Q?3QoO/ODMUEqrtm9XOC0vwRPrjqGvmWioimXVyEGd6e64m1OHHJOSVT6CcdhM?=
 =?us-ascii?Q?6msVavQX9OmpuNe63yqZcklH0SR4f00C1BRry3nV+UqLFw+h5s/VPUgtIx63?=
 =?us-ascii?Q?hOFCAk3akwwfRUbKUCicfrjBi0FHsGLN7IBdsr5vXLenAYzaucipNf/5fE94?=
 =?us-ascii?Q?Gmmvi/NGg2B8ZdH9rrt7DPak3M6kQN07DszO3FoesexLiERoziCj7t8KTNBF?=
 =?us-ascii?Q?yFSQhr0aZdUt9zwr65jjxiRGj0cdu/7PruzAOx07hCxbzfuztGh4lViG9rJs?=
 =?us-ascii?Q?D2jU/D4uKmyEHejx4LRiRmuJ6vPgTDMEldT8nr8SDlzFD2Hsc6iL48nTDJu4?=
 =?us-ascii?Q?qn1F83rjawUQzLY3MTRUfBtwuBGJLhNt3RwTpd87J8wYGHm5d4Z48jk1uoNj?=
 =?us-ascii?Q?iP1KPsnZT2hH+GsjT2Dn+rAw2u/7UXGzQMcCKwmjtPqlqWv03fsaSbQE93S8?=
 =?us-ascii?Q?NOOicdVlRrj2G5kv9VZZuYLAXFU0iD5nnpWA9awRTUWebKbaQsyN8ukc+2wG?=
 =?us-ascii?Q?WU19qZ8wLftx0kruPNyv/3tPZ+yyvWJU69MupFvxi4Us/u3jpkKHFEYaJnTM?=
 =?us-ascii?Q?Ujt4TFtji75LfOUXzf9s3Wml8T5Hx889k42w7mELQb6D+FUvbeFIS0vyIxay?=
 =?us-ascii?Q?BPWFA7SAveFyoinhlQRd9i2bIvBTO2SppnprjVUICKddrci4nVPqx/GbZy1U?=
 =?us-ascii?Q?eiPTfLvxu/SSx38wsABqst8Y/fH+hP2rbsE4LnCCxsJuROajUBnBDMiy0SMw?=
 =?us-ascii?Q?MrbgtX8PwQxn/wWfqbvUpWFD8QsvoTp0ZHGSV1+yGUgLIv2NjhXJuY4H44Ru?=
 =?us-ascii?Q?XxOpg3TXKJyBh/rpeZn1fq3AnwBKSfr4QejpepDgk/6IuUb3/mgR1wNt7av2?=
 =?us-ascii?Q?ZQKCGOk2m/8K98c6CJi6Ld0hdRYap/99bwxXHrW8Cm2sfa+eAVuau/LbqCKh?=
 =?us-ascii?Q?644mnbm1rsl7u7GlEQvvO4wZrrf9jKo0GYwJBuzag8+2hTF3wg5478ZVhG9p?=
 =?us-ascii?Q?solGTa4Cc1cJLi7BXW515o3fw+q8Fmt6AlIBtPAVPf2cRS8lgAgGc02jPBVx?=
 =?us-ascii?Q?t+fVyQ6ns6oR4HCH4zsyfIVGWmnLUfaIFtKgzhb9gMqaedX8Uun4Re2ZVn7+?=
 =?us-ascii?Q?zyRlftBY2pr+9MCqKYpnKgi29Ix3uZwso78L8y7S7tEzEHHCPcjAV/YxVgZj?=
 =?us-ascii?Q?zmUWmnssytyK7dRgqPKTlBJ+ePxRndo8yDrN5hxUPwqt13a9ZTdJLZzxiwvH?=
 =?us-ascii?Q?V+nxTLbhZS7dZgKbG0yseCF2//5igpDpLPTWuiZEHlwoqeR+dcheNSGwwU4b?=
 =?us-ascii?Q?9j4zTH+r4eg13F2/lbDsft6x/WGx1XP2v2yJ3O9AzoDeJ0iKPqfdyuy4o4nb?=
 =?us-ascii?Q?vVnWniyD1iPiycomlBXDE2zpeRD+4vTZ/U2J7qCmcbYFdtUR6ZdB7+pEXOfu?=
 =?us-ascii?Q?E5NEsgJEfJF2ls2ulIVtCpAg7O4LOpTWwYqvtjkU6mMjPsTJgP/4YMoCNyD0?=
 =?us-ascii?Q?Z+nxcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b1gHOzWwCCTaBh/LhLuLv132PO6Yh7JNXujJORPELCSsdgzSGc2dUeAdkhLuqVL9JVwRQzzgf6eoViQ0CKcFIwXWsa3C39YW3f8QwnQjUkebplGfExt4LYou/Uja1ODC2ys7yPagBLftg5wwWgoWYGevqhCRgJ3wVm0Zqg7RQjPuJ7yW+G7IvEXpumCvHTbgVh+yW/jBGd/c2NLbD79CKU2NIBpMbrZg4sy+TMwPhIV+dSVLzCxewjJr75BBY276GJ2r7iXlyrKHWMQP4iH6CXC5v/O11TiEuRdWw9sghdvp0ZGwvp+pgM7yV2QNSJGUa+5p3hBbxmfEtdLLZCrrJyekIyTiOwycnroecDn2xHYQrmDSJewZOjDQuAxDJcm33J41rNb44CbwEx+QIh09a7hST3qk+L+goNHeUorIIFtKN82cR4L96zcH9MzQKx81
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:01:40.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1512b925-506c-4c5f-b179-08de63fe4d27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256729-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7DB9E7DB1
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
index 711f295eb777..522e71f2d6e1 100644
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
index c04a9c76bd40..c9243b4d7682 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3605,3 +3605,27 @@ void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata)
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
index 1269b8ce9249..a44973ae21a2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1334,6 +1334,10 @@ int xgbe_selftest_get_count(struct xgbe_prv_data *pdata);
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


