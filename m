Return-Path: <netdev+bounces-252877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG25Euygc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:25:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33A78776
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F043024168
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2F21FF38;
	Fri, 23 Jan 2026 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HAZfGOBw"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BD2836B5
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185083; cv=fail; b=PisEhVPcrpmYOO/WDlVc3Xk1VzMVsQKTwEtLzPV9IV7M1BIKOceIGyuBR79XzZ2E40KxDpvdZ/WQFulmX6xNjBUQcfvF+Ak5HCS3zcWEKraRbM43zjE1bC2GD2BQb5uhDV/FaES472KIftQDGafctqRixxlsez1ejIts06NF6mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185083; c=relaxed/simple;
	bh=PI0c8AaiA4mZre9vYEl8sliDjSVBc4J9dOHrF8MieEI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IoJ+1IaWkVYia91Zs+2PZOwvhek7ZFgDzxcnWOfK4JM4xrAtlJEhy9YuD+88ahl4k8N9vJeAQmGYLr6KE69OjPBFmeUdvv3pwClG0y04PIG2Msa2Y6Zll4useLYJX32AbqTwcbQPBcuUvXHMS0EhhDuQRbwMewYTYTPSWc5EcqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HAZfGOBw; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neyyfoiVe4nRqN7N7zkCLopobTov3XfldrOwMBUz45eUShyM68kW0t3nPCfATCEQwRESMPS/ztCKuIVZ/oquSzG/ToZIZLW7QZM6uTq/axMPd0t7me5Ynf9dW0wt1B6OkwdblaAQDZoGzh9DYElzY7+cfUrsXAFshsgxTm7QE1zCYwK3U/Br93SMN/bbbf7fQ+8DI7OcavTZKglQzqayJmHGu/qtO0GD8uMGKQ86+w77lMLelBvbx4nwu8wQHS76bbzbT4uM/LO91UkXdSw+UhpmRUTB/G0EHHNflnMGzKuG7XDqrGoMaSI2N5wkusDDRfyOWJh9gwHeh+kS6eDHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlkeNYwDIp/x7G2tmAkTUkbuoNUoJuoqYESioUFuUfY=;
 b=kaP7SIAskymuVaQrFwe7t9gU5TQQT1CzdKFCWiIwO5CMqjz9dGLAuTezmYX1dj+j0w4LptTn/6bTDh1fC4gXD6TLCwIvrS9I86E51a7XetGPRwatfDQ+Ycgd7FfWSj4LUOQZGvV/f5mMIeQjw5AEyat+PsrzOHgGvHEUX+lYMgWraIMhtEBZ/Mq/3eg8rrPsnxbQYbsQa/zfPt5GVYv2u4aTUgIu5oYSsUNt+pJpsZXyJtwOcr3Ia94RRReq7u6OBPk6daFgY2s/LprjzJoxjEzeOwdyTGyKhGip22jDWn5/14URu6jBrffKXHEGiPxnh+09k40OINp+83gFJ6nUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlkeNYwDIp/x7G2tmAkTUkbuoNUoJuoqYESioUFuUfY=;
 b=HAZfGOBw9Lye5hUW9PI3aS+vhN1zxZHWvRwnYGXwvrhtzwDq7BLwYQQWj9gO/JPMjq+eOe0gt/31vg1wpCry1o2MnNCaL+YfsZbG4Jw5AjKPkRpcJC5nX2XKkNcDbxLzQu0FXQ3GCSpgO77hbYPBGEDyBPxxJR9U1XMLvmeeh88=
Received: from PH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:5::29)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 16:17:52 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::88) by PH0PR07CA0024.outlook.office365.com
 (2603:10b6:510:5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 16:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 16:17:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 10:17:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:51 -0800
Received: from xcbecree50x.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 10:17:50 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>, "Damir
 Mansurov" <damir.mansurov@oktetlabs.ru>, Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH net] sfc: fix deadlock in RSS config read
Date: Fri, 23 Jan 2026 16:16:34 +0000
Message-ID: <20260123161634.1215006-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e4a5a1-3808-4213-c405-08de5a9af56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0QKyKTo+MHSRnrOBEo1MX/C4FJ3sSdnLm6Dl7NtC/EdIaEkPHo6NpcrnnZb?=
 =?us-ascii?Q?601ev2sCYIrH6bxVGte7XI8QqZ2AS+rJYrsCGHVVwQ0lxBGjhY8FohbwlCVJ?=
 =?us-ascii?Q?wSygNfjkstHwfWuoH4294QjXaQzIyPcwcVHC4naMdZDFYBffg4/o5/k/Aq/d?=
 =?us-ascii?Q?8u7i3bNvzzl75KDpTJj0arJfHlZpBUpcO+xjhOPVwoqy5lZ3VxwyxKiqUXNp?=
 =?us-ascii?Q?PgDw1C8NBw27RrrMWdROjoHlGuMGQC4v5CwO7mxj4nz6I7kF2hV2STJFFfDf?=
 =?us-ascii?Q?kmoXziCFX70AZUSg5XSBkGIaX4QalGGo/c5ttJKee7dQYR4O35tZG801YRkp?=
 =?us-ascii?Q?nzNIf8S60A4Zc80yQv7uFcZRSnf7qqtxU0UOzRTSdcDoxByejAcZupa5AdEw?=
 =?us-ascii?Q?QKAKErKGOe+xX726yMAYrbTVBqzMDnt/xsXSxGd1sDZcYGFZZzsBj7hZyn7J?=
 =?us-ascii?Q?cTj2buCSzhCKONplb6rXuR/7XlXobYTzEFG6qVW+K83Xt4akPqeOx6W2Fo8+?=
 =?us-ascii?Q?LZr66CxUzsXbViXWxN4wH3X+Ftl+QveeH0c05rM+Sk4bGDTFlK4ql4KZSkIg?=
 =?us-ascii?Q?b6Li7QHNCDczpYxMl0u1HPOX9yfNGiMK7HIP6ck7cGq/KGyBJgtLc8K7QPfV?=
 =?us-ascii?Q?WrwJaJ7Z7FsAuSmPnC2Sx7nrAN+KYwRwG0WQoExx6qaLYL6aCAIeWh2TYx1f?=
 =?us-ascii?Q?VIuiNGDcLpNRLNub/CUzg0F2ouazhq8383cKklgv/Zm0ByxsLyKHLcxAioV3?=
 =?us-ascii?Q?8SlJKxzyK9jOKawwN+JQlNhyZf6sRjnz6lZ1Izn4Nj6QkfrvA22k2TuN5mcg?=
 =?us-ascii?Q?wtlgLisAu5h+SSHlJfrCfgfe9gLVqd4Zk+NPuaLk/o3WaZNxTiIP03UgTdIA?=
 =?us-ascii?Q?npzIQNKAbtBfVm1DSpsBz4fy4uRN+hRhOafRe/SYNRiXzj308Nf2FmpuKjXo?=
 =?us-ascii?Q?zQ/2GR46vmirah52DrXQJ76mI4hChjqRJPMEC0PMp1WhgPBbLp/5LR/ZaC8X?=
 =?us-ascii?Q?nmoPbPYw7NAWJOptwQjWobJkCmT952lZwHa9rR0ucyZR6yeqJM5VIV9QSByh?=
 =?us-ascii?Q?YrnWmTV14FOerwe9lIQ3UPpTHqjcM4eilMzOzaNmZILzrMvNriz8ZQFQx48X?=
 =?us-ascii?Q?iAzuIDyuOPxF/UXUQnRserfs/fSIZvfUQUyBm+Mtcqjax2GCYLJ3wcL3Eh9B?=
 =?us-ascii?Q?eXgY1GAqj9ubgZlwlnHkBtiu9yDUWi8yBQBuU3FSPTtbOmznIKX4PPawRyQN?=
 =?us-ascii?Q?RwVLlaZ0AUPmSe2utrISTUtZ/LeehEUTikqew+iji6v8oxnMBF/tBTOrNkAf?=
 =?us-ascii?Q?bYewLiPFUJPbUcwXv7tvPNc++IKjDmcnJBjDAIaX5SwTripY2ezGvyPNyDuY?=
 =?us-ascii?Q?1NYb4xZHNPTUDJGyJBm2T8a11y3bzkle+JFa45ZQHLG1t1IFA+4BGm1+/k9j?=
 =?us-ascii?Q?FnLAWg8jlLVdnezVkO+e4C/edo5sCLeBylESpdzAs3JndvO3iVfJlptZF1Wm?=
 =?us-ascii?Q?FwPuXSq9m/iV393EDG5X+3BePTQF7dttfB0H/2oRxSCCmpfsTDq3K63gGDe0?=
 =?us-ascii?Q?FLVEK498yJl54XK10ndiOyVylC+fBU1kQSRdC1gINT8Vr7IidWPSjgK0RVpB?=
 =?us-ascii?Q?d0DtcZAZJu/GLzsYFzDGLllrw0QLepPyxg0FI9woaR1la/xBhOJIyBmXvX0N?=
 =?us-ascii?Q?bqPLcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:17:52.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e4a5a1-3808-4213-c405-08de5a9af56c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,oktetlabs.ru,decadent.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,oktetlabs.ru:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edward.cree@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9C33A78776
X-Rspamd-Action: no action

From: Edward Cree <ecree.xilinx@gmail.com>

Since cited commit, core locks the net_device's rss_lock when handling
 ethtool -x command, so driver's implementation should not lock it
 again.  Remove the latter.

Fixes: 040cef30b5e6 ("net: ethtool: move get_rxfh callback under the rss_lock")
Reported-by: Damir Mansurov <damir.mansurov@oktetlabs.ru>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1126015
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mcdi_filters.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/sfc/mcdi_filters.c b/drivers/net/ethernet/sfc/mcdi_filters.c
index 6ef96292909a..3db589b90b68 100644
--- a/drivers/net/ethernet/sfc/mcdi_filters.c
+++ b/drivers/net/ethernet/sfc/mcdi_filters.c
@@ -2182,12 +2182,7 @@ int efx_mcdi_rx_pull_rss_context_config(struct efx_nic *efx,
 
 int efx_mcdi_rx_pull_rss_config(struct efx_nic *efx)
 {
-	int rc;
-
-	mutex_lock(&efx->net_dev->ethtool->rss_lock);
-	rc = efx_mcdi_rx_pull_rss_context_config(efx, &efx->rss_context);
-	mutex_unlock(&efx->net_dev->ethtool->rss_lock);
-	return rc;
+	return efx_mcdi_rx_pull_rss_context_config(efx, &efx->rss_context);
 }
 
 void efx_mcdi_rx_restore_rss_contexts(struct efx_nic *efx)

