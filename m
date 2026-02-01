Return-Path: <netdev+bounces-255643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMRjI4l3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63855C6595
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85B6930041EC
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187E2472A5;
	Sun,  1 Feb 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3wS/fTyH"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1344246BBA;
	Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961332; cv=fail; b=p5KrSt4jAqCE6DN03Psivj/v1mI2N40KQ0TqaYeYOiV8cTDmGfwqdncQ/UnMpDwUJDDYdHQlntx2scA4GGGekYTUOvK5eu6Wa1TDSLLv9HLtm808iXhd/OCLbS8mt1x9jK7ovWMduxVYe44pmxQ7CEg3+2MpS2RoAub1BGyJK7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961332; c=relaxed/simple;
	bh=ZFLjmOPJIX4IGVuOqfsW38LaztjGYBvKeneYqsjDAX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/L+QWfsX/Eh36vejMkxan+95cWPSvvqDcUSH8AfUqcQVvW8utVlPPCnARcvl1BiptBvDey+gZVRzoharxAwEGuya5T/E/GL2/YNISs10Eb6Tsc2phzwSpjV6IpIWMUIlcqtrcgwpY10vW0UQy7znH1j+d7y/xs6qSphWLqTCK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3wS/fTyH; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKZEu1JCh1z1yIJa+nmIZf4yA77mEMgbU3BGEgGJ5xpot1lnIKRIK2lAdK+kFa2zVtGVfjoxWOwMP/3nR/wOWYSfoksT44M0aiHXaz33wX6qAS+mQ3f6ZNHq5+nOeXEZSC7YtdsmvM2xDzxq3zSxPyZrT4XruVrAU3eA3JAXnqbP7O1Xi+r3bIcqhsHxy1Epg5842YMNjoF6RozFaCB6viCNdQVudQBKgRw5SOH8kqW4F9ANuoiMojwL2o2DzWJxrxPJ6OHs0DncozOA4IKLSkU6/8o5uDCx4eCid5nH3AENBmGl4JTknA3+Fnlf7RApLq54aR3FuLiFodA+so3wuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/RbkdGhM3SCo7JlIGSdJ7edjtAExeG2oz74ybJe/GU=;
 b=F16U56R+TNXDaMjPvRs3KDU5OAlV6htGr05ycpqoKcItg3/FPdSMAVsaIMrq7sPEiLLXgEDNZIoNmv9zrBAK42x5thyridT8IvmFqp/wFqMIXUyfMZkV1jDR1QrrC6RfnO3lCAFEp2RJBl062KlGH6673aTJN9IUH+ckjq8PxXCW6gUPYSzo9ReoFptUmL5pITTDuk7rnhy8XpSqG86inSN9vHIEuRYimI6rm9OEmZqNEFITV5B1FKFc2EXaV4NYHUnPuosOpyIKPeGWHwSURqlnAd8EXCkFA5VEmlSxFGhRtvMqV77mePJa7dhF4y/1V3ueAp6zPE7kM8VzKPTSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/RbkdGhM3SCo7JlIGSdJ7edjtAExeG2oz74ybJe/GU=;
 b=3wS/fTyHbIr+cj6ozgsEC5zRkhQ0Mdz7YSHq6R7yTawhAuoCXhwODiwEmIOkrtxwofsDZlKSeez8g4ZgE85z5njWDE7Rqw16qoRWRQfyJcSTr83R0U5esOPwGRK5PaFGF09tvL8VJW0z6Jo+acwZUpdE0qeA/hzccdv6vT1kXo8=
Received: from BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:26 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::b7) by BYAPR05CA0040.outlook.office365.com
 (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.9 via Frontend Transport; Sun, 1
 Feb 2026 15:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:21 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 07:55:21 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:20 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v23 22/22] sfc: support pio mapping based on cxl
Date: Sun, 1 Feb 2026 15:54:38 +0000
Message-ID: <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 526cd232-6870-4183-e24c-08de61aa50f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oFMfuz5AQfPWEtAhlQYwUOepFPjluOKXr754dB4xibhk4Gm1NVywZzx4Z+U?=
 =?us-ascii?Q?DlcfLtSF10/JZLRD7DUU1U0IyCeaHs/X1Qc23e+fAcfuBQR8D/Ce7RqVHCKK?=
 =?us-ascii?Q?wNXDZjPjqtVcmporJhRStXLSg07XyLOp+ozlhB6xsJWKhyaWb+o0lp1focNx?=
 =?us-ascii?Q?gN5VZXRO8HqtXLCbbykTUAjub4+ImCeXB/i/sVB+p05Act4+OsEOcAv8kNb6?=
 =?us-ascii?Q?aBjBV+45tNmehjpDUmySA40WA5PixvUmZ1iRualvHCnW5MmcashrrKGaCagH?=
 =?us-ascii?Q?vULTKMabKCH//g9Bxwc8vKcR4PLwelFhNjoUq3q2OvQyK7BjrCE6Ky/vLMW3?=
 =?us-ascii?Q?U/tpx6HZi4OMIZ+qlkxkcl3IUSVm3Olg/IzN89VNtg0P9eg+HyTxwtGKZ3Il?=
 =?us-ascii?Q?jOYXj2kM2zJRwabm/vFX3N4h3gNfelSsj0MG10xbkjLW58YM7/NvGJ6MpD5W?=
 =?us-ascii?Q?HigaBnEkiiFeI1n3qEgu3IZ/zjT2WLtgYm9uGxW/qGN/xeVpCiNZIbXY/TQX?=
 =?us-ascii?Q?kJw9YTawVci9UqBgcG7FPmhm2zeOrtWwMZ1kwd/1JW0hj4qB4d0fHZZN4PAC?=
 =?us-ascii?Q?vnnY/PJGD3owsp5nfuCIVtna5GuJxLSTJYKVYJXjweWQPqMP8iKZ2yb3puP5?=
 =?us-ascii?Q?wQ9uLDIUWyN90zmWda8/0tNnSnPj/96n3SaeI3NMSdjfMLt/BmIPRuztHzpb?=
 =?us-ascii?Q?SM5Kt1jklbph5Ht/4hdu0zEsz31yGHCrcn8NkMumBHxF2ZDoZOw6My65S90z?=
 =?us-ascii?Q?J1cj0V5ekce4QFisfYVw2Vz9FnQ3sDCnU2Eh5+Cj8CkBHTdoBCFIo8WQ9/5T?=
 =?us-ascii?Q?wwtNqfGrA7baMI2xbvT2pcE+DDpNVnNDDvqJJitxj5BGI7Tv9tFq1ArgnnBR?=
 =?us-ascii?Q?ylFBkUqOH3Hg9nuSW6RzWsiWWHpkD5VBhMi6xYc+xZRwA77V6dH8C0Yu+EXC?=
 =?us-ascii?Q?gmWv8VSsaPNouXUz6Rfpn+Tqj/PwI82JvR5BXrFeY4/OoxMq2rnc00IGWHzf?=
 =?us-ascii?Q?Dem+WHNZ3KfSuq2m05NplzRA1Xm3YShJQVwxWGqi8Ou9jDj7/1D/ghNiRC7w?=
 =?us-ascii?Q?8sK0YqCTYbZNJnViP9nC68pjzgVglgIBsygZ6E0JAjSZ4kCdh4ys5trSoPKX?=
 =?us-ascii?Q?sGLuZ6Jql2ZxKBHssxoJtSIMGJdwDtOOk+Vt+zR62h9BYJqLIHPIxGE+FsaK?=
 =?us-ascii?Q?+dbjnfFNZkNBrOirbA0kmnhe5hNU8mKcTpMbNFDSkWLQMU2DhqnKAYbM04ue?=
 =?us-ascii?Q?1g7CtMDx1GsGxNpc4hGRqnUCNtEWUmb/RN4RI6U+kZMgwKjYsT7oHEx7Mdl3?=
 =?us-ascii?Q?0god2/MGK5Xo5VaTVUgTQ8wDuOFjU66JvhFQ4vXJToaiJBCP0ndAiWXvdSND?=
 =?us-ascii?Q?h18ReW1lB/KSQmxLhaAr7bC78IB9+IPcI8wM+c7GJDZeF8jBBghvPvV/usvY?=
 =?us-ascii?Q?mBOzfpwJb11CbPcNl2FfauICAetWqJAcIENsfqi+152+GdhP8rxkDcqVgfEY?=
 =?us-ascii?Q?DT6bdA9sht6MWi+6mBFOIcwQObMEzK27QAGZDaK5egzP7IdrgmdQ98M6hWas?=
 =?us-ascii?Q?pwW/Jty+j0bHt1inOboOQs9FAeY5z7DAdnLAM+1NBVIMVbcg4v0rP/IgnX1p?=
 =?us-ascii?Q?cf7AXOwzs9xMnoOeOxTbMNLDMTr/0q28o4mQTqqDjdPeBjSS2hIa/UuAlCQf?=
 =?us-ascii?Q?IqAc7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oKh5oGi9dSp9Zk+Sz8F5F4muClZHk+1AhZSpRhd7Ol+o+8l7SRmlpSbkC+JSDVMk316i+Bi5VvcGwbAzOTDJmbQ+SPGopwryialvFyQPI8mbGeHYxuQUiLFqjnB5lBwxUYvlCgZ7ENzIpHh07RMzoo8RQq/GpdTtF9PxpYdnfYxU7rjheaKX3LPP68gLguGssqWb3Y6RZjYXaYflBi+F+jt/wzKLySsQ1SHKY5cgu+HBKrMEtW97ePsI5OxL/S9dDQ0VkjBTYfQJ5QpQP3h0zTEQ8Km0VnsGgi6onQ0R6TgkWCp/gwW+GhBAGJKK/8RcE2oPfQJcT0PbTFrRdQI4Y1li0MHIkFxt05ITGjl1tHvj4AUXG0qvYvkXIUGrTowVCbHCokhEuNt67cUV4z3VO3RdXroX5klwJXzm4lFWxAwF6jeKNcM1M979usKI8x/u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:26.2795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526cd232-6870-4183-e24c-08de61aa50f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255643-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,huawei.com:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 63855C6595
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

A PIO buffer is a region of device memory to which the driver can write a
packet for TX, with the device handling the transmit doorbell without
requiring a DMA for getting the packet data, which helps reducing latency
in certain exchanges. With CXL mem protocol this latency can be lowered
further.

With a device supporting CXL and successfully initialised, use the cxl
region to map the memory range and use this mapping for PIO buffers.

Add the disabling of those CXL-based PIO buffers if the callback for
potential cxl endpoint removal by the CXL code happens.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
 drivers/net/ethernet/sfc/efx_cxl.c    | 33 ++++++++++++++----
 drivers/net/ethernet/sfc/net_driver.h |  2 ++
 drivers/net/ethernet/sfc/nic.h        |  3 ++
 4 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index fcec81f862ec..2bb6d3136c7c 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <net/udp_tunnel.h>
+#include "efx_cxl.h"
 
 /* Hardware control for EF10 architecture including 'Huntington'. */
 
@@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
 
 static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 {
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	size_t outlen;
 	int rc;
@@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
 			  efx->num_mac_stats);
 	}
 
+	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
+		nic_data->datapath_caps3 = 0;
+	else
+		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
+						      GET_CAPABILITIES_V7_OUT_FLAGS3);
+
 	return 0;
 }
 
@@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
 static void efx_ef10_remove(struct efx_nic *efx)
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	int rc;
 
 #ifdef CONFIG_SFC_SRIOV
@@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
 
 	efx_mcdi_rx_free_indir_table(efx);
 
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
+#else
 	if (nic_data->wc_membase)
+#endif
 		iounmap(nic_data->wc_membase);
 
 	rc = efx_mcdi_free_vis(efx);
@@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	unsigned int channel_vis, pio_write_vi_base, max_vis;
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	unsigned int uc_mem_map_size, wc_mem_map_size;
+#ifdef CONFIG_SFC_CXL
+	struct efx_probe_data *probe_data;
+#endif
 	void __iomem *membase;
 	int rc;
 
@@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 	iounmap(efx->membase);
 	efx->membase = membase;
 
-	/* Set up the WC mapping if needed */
-	if (wc_mem_map_size) {
+	if (!wc_mem_map_size)
+		goto skip_pio;
+
+	/* Set up the WC mapping */
+
+#ifdef CONFIG_SFC_CXL
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	if ((nic_data->datapath_caps3 &
+	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
+	    probe_data->cxl_pio_initialised) {
+		/* Using PIO through CXL mapping? */
+		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
+					   (pio_write_vi_base * efx->vi_stride +
+					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
+		probe_data->cxl_pio_in_use = true;
+	} else
+#endif
+	{
+		/* Using legacy PIO BAR mapping */
 		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
 						  uc_mem_map_size,
 						  wc_mem_map_size);
@@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
 			nic_data->wc_membase +
 			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
 			 uc_mem_map_size);
-
-		rc = efx_ef10_link_piobufs(efx);
-		if (rc)
-			efx_ef10_free_piobufs(efx);
 	}
 
+	rc = efx_ef10_link_piobufs(efx);
+	if (rc)
+		efx_ef10_free_piobufs(efx);
+
+skip_pio:
 	netif_dbg(efx, probe, efx->net_dev,
 		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
 		  &efx->membase_phys, efx->membase, uc_mem_map_size,
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4d5f3974e51d..c13e1f2bf7ea 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -11,6 +11,7 @@
 #include <cxl/pci.h>
 #include "net_driver.h"
 #include "efx_cxl.h"
+#include "efx.h"
 
 #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
 
@@ -138,14 +139,34 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
 		if (IS_ERR(cxl->efx_region)) {
 			pci_err(pci_dev, "CXL accel create region failed");
-			cxl_put_root_decoder(cxl->cxlrd);
-			cxl_dpa_free(cxl->cxled);
-			return PTR_ERR(cxl->efx_region);
+			rc = PTR_ERR(cxl->efx_region);
+			goto err_region;
+		}
+
+		rc = cxl_get_region_range(cxl->efx_region, &range);
+		if (rc) {
+			pci_err(pci_dev, "CXL getting regions params failed");
+			goto err_map;
+		}
+
+		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
+		if (!cxl->ctpio_cxl) {
+			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
+			rc = -ENOMEM;
+			goto err_map;
 		}
 	}
 
 	probe_data->cxl = cxl;
+	probe_data->cxl_pio_initialised = true;
 	return 0;
+
+err_map:
+	cxl_unregister_region(cxl->efx_region);
+err_region:
+	cxl_put_root_decoder(cxl->cxlrd);
+	cxl_dpa_free(cxl->cxled);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
@@ -153,9 +174,9 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 	if (!probe_data->cxl)
 		return;
 
-	if (probe_data->cxl->hdm_was_committed) {
-		iounmap(probe_data->cxl->ctpio_cxl);
-	} else {
+	iounmap(probe_data->cxl->ctpio_cxl);
+
+	if (!probe_data->cxl->hdm_was_committed) {
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 3964b2c56609..bea4eecdf842 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1207,6 +1207,7 @@ struct efx_cxl;
  * @efx: Efx NIC details
  * @cxl: details of related cxl objects
  * @cxl_pio_initialised: cxl initialization outcome.
+ * @cxl_pio_in_use: PIO using CXL mapping
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
@@ -1214,6 +1215,7 @@ struct efx_probe_data {
 #ifdef CONFIG_SFC_CXL
 	struct efx_cxl *cxl;
 	bool cxl_pio_initialised;
+	bool cxl_pio_in_use;
 #endif
 };
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 9fa5c4c713ab..c87cc9214690 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -152,6 +152,8 @@ enum {
  *	%MC_CMD_GET_CAPABILITIES response)
  * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
  * %MC_CMD_GET_CAPABILITIES response)
+ * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
+ * %MC_CMD_GET_CAPABILITIES response)
  * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
  * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
  * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
@@ -186,6 +188,7 @@ struct efx_ef10_nic_data {
 	bool must_check_datapath_caps;
 	u32 datapath_caps;
 	u32 datapath_caps2;
+	u32 datapath_caps3;
 	unsigned int rx_dpcpu_fw_id;
 	unsigned int tx_dpcpu_fw_id;
 	bool must_probe_vswitching;
-- 
2.34.1


