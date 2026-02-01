Return-Path: <netdev+bounces-255638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FYYEm14f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC90C6614
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2A4300A61F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E56248F47;
	Sun,  1 Feb 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VrCacndC"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136E23DEB6;
	Sun,  1 Feb 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961328; cv=fail; b=WhGxaT02aOlKMhME9Jtwto6TxkSJL2+FrzhvI18wW7IhzNL7Hp3SRVWgQaWfJemHO3Nr3HLsZweSIra6Kmz6b6zhgfIXEtrvcfnQqGjb+UrShRAKbZz+9b6S4q+HcriOQ/NRhjtg9Z7dJWNw4alze0DIo4Tya0qd9YSbDpmaV7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961328; c=relaxed/simple;
	bh=yDFERQPrhNzpYY9VPq+KZCawy8W3P8OCT9zjZv2cnLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWMilx+7tFZv3XencJjrv1p32vJwM0wA+Bh4nDQb/QGGuMscgVc5tYMnadnoLjuS9EFj/sCSBlDiWjfjR69Y1/RYrltDkIIH7qdgbViYTzvmngiXbq762UQwwd9/8SH51b3Xu0G5gNFeEtjByZft3RTMDfcTeg5toocnKr4w5BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VrCacndC; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdNSI4XGJL0gBb1mstNA9DgY8SZ+47KbbtgUJXPIcp/k2N5rjNtOGjGC8cuYmOp6CQuGdrj4IVuqxu3v7Uqh+PGKuRQFbafTxy+YVTnWBVlCVtM6kDnnwjtMCj1ZPMjcA91GaVefd4yULrPwOOOkINBYs+Yybq47BKvrWQpmEeWsfN9yJIzsuB1WjQyxQcTfS4p1Axec2jc5lX6WySKzSt49wzKRNVPCgLH4iCe5Sfa62D+oni0Rkb5lOQDWNHNbpTGqFlwbI8xtPwT2YgOFb9Xi3N/3Kx6ykAaM7o+RC+e3UqBi8M6fTe0Xtn2v806vO4Fe4jmXBPHgMGqUpodFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFYKV8EYJoB60XOboAHw+4PkZ+e5dvbijpJojg7PA8o=;
 b=kTYGThy8PTGNBitx4yTiqAZ++UU/+OSRihaxdD+uyx0xn927NOCtymHWuyZ5aQ2bamt5Fhh78t3tsrDsAjgsbJn4MvH8yMFtkaQ/PE64iwe/FRN9BXwAoa7Giom9FPeJo4pOvNYza+RMyHOUrNi69v9JIyzChZSgWt/CHmxJfbSOPWeBfT/NTWpz8M6lnl/bSO9lfD1+MHn6ceOb1kLm0+rd0KZ3TqIKLsd7M+5FMJblRR+b9gZNSli3CsahspZUztGX5IAM1dEL9hDJ0DxImio6iUWRj6abXxCKzFbGnBsIoGtbtNC9X4M+Ptvqq4s4k1GJ8vBCeBcZAt7xvab65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFYKV8EYJoB60XOboAHw+4PkZ+e5dvbijpJojg7PA8o=;
 b=VrCacndC3k0jwhyyhOG/zdZUmdfyx7sGK8luaB9FZtCL17WSI/E6k712v+8KfVKF4cj8g98XllQaYjmoJxmsb+jBaow9MRN9ZHWoGYypt1K6I1szXaQSZ4ri+ZhB78frNEvx2DmfjHyhfhYUGIrR8Yo9bnzrjjKf4ncIGBv3LoE=
Received: from BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:55:23 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::d0) by BYAPR06CA0072.outlook.office365.com
 (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:13 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:12 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v23 17/22] cxl/region: Factor out interleave ways setup
Date: Sun, 1 Feb 2026 15:54:33 +0000
Message-ID: <20260201155438.2664640-18-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c62ac75-e2cf-47ab-5283-08de61aa4ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xplwaIvNjJUiiGLEBickgW5SLZEXJvLMg6QpCMBXk8veCLDLo1mxrIKGnmLb?=
 =?us-ascii?Q?QOQiYM8TpCKIgQmSI0XKjlsFWkh+6aSImXAX/RDTXhJI6ZN7ZQmpCF/keQJF?=
 =?us-ascii?Q?0B6ar8VdvHcqfkLRFM3UNcYyS4izuHgJS2M6fkxn4gU+uaEPS0TWgOmy+yVE?=
 =?us-ascii?Q?bU/N0uTBzdjOTM4hBZuBQAzQ6tsieY5c6UbraHwMoPllHe0MzqkrZ9tSdsyH?=
 =?us-ascii?Q?Q6Z/Kz84mG73uG9+B3ui4fsFZTdEAtZ6zmQiQnHpQK0kTmzXuQEVoI1ZW7aR?=
 =?us-ascii?Q?EK8eusgPR0Z4719t0m0ioajk9Z2dIeBTuxCPHQAn3l4vAy0xVDxJv23xxcwv?=
 =?us-ascii?Q?Q7n4MM7skNAeHprjfmoVMGmErYalBivurVzAgaKOQ03sAmGQpynBqCQZd8Cz?=
 =?us-ascii?Q?hzwFsDP476rMsQ7/IYrNPqhU9uJL7pk/L1IQrfF41aDe2MMoKOPwvSHngd/v?=
 =?us-ascii?Q?tYoJ8pTI8TgmkIa8X3Ugn4EZLXEL8WsRbksisw9S2zHk/MYDYqguZO136w9O?=
 =?us-ascii?Q?AVcogmZPHEgUK3f4KA9w21SohDkI4qKK5fymAoyYBqdSuhUkzrGZcYbO9q0J?=
 =?us-ascii?Q?O9JDu1HUkj9/l1gvvRRzjitn5CeXPUu5AaitPeCt8CT+gLhboAmR9oy5Y6q1?=
 =?us-ascii?Q?AB6ZELQ2/cUMEq/DpsJUU5yEOGBPkFqukUU2/xAYhAzXGkqI27/a1mJsdauE?=
 =?us-ascii?Q?kb+nVFNUuLcTiozS2KzFbhdL9x4DSGwoLIPPEj904jlirT8bOOsZ+pcjmsAv?=
 =?us-ascii?Q?Z1pSMn1/bUq+WephnfanChRxuNnXQWaSY5kiY2GrMLeiaWO1DbeLEEPd2TAd?=
 =?us-ascii?Q?tyc3N+JOgNfJAlrPC9kNo2+DcQvc6F7cXm2oxoROJ2b+Sm1Wnu8o9LPsHU1U?=
 =?us-ascii?Q?/J0aJw+Qh4SfD3AeIoreQ1VhOi1nXnd5w8Be2Gwzuih+xap6iKU/uddTW1BL?=
 =?us-ascii?Q?8+Bb2UEOkv766ksqXm6W/yZ0rzCve7Q61MiWKNcPvTC+coCFllJQG3jWU+v+?=
 =?us-ascii?Q?SHf5Neyb+aiTZI0SnMQni1XTkRWzlPyOdZva4+bKlMZjeqm5t8aZKzZxXtkL?=
 =?us-ascii?Q?JPa6mqzmFsAfnW/Mgq3s9yU9Iutmcf2zahgnrRncDZpPTnDpwbBgeUDpOoWb?=
 =?us-ascii?Q?gfJkRy9F+HXOeUXBEjcDMg+qj4XOlza8KZAkT9KOseA+Yvn6AGK5yKeIyixC?=
 =?us-ascii?Q?Ga0wjo2tX2lHgI0a1FJex8GRmaaLIBszpoGVnOzg07ySj5COiQ6sDfpKWf6X?=
 =?us-ascii?Q?S+7FYda7JiddOeDSYnHAtPYSAJYS015WqQu5aNPpOL5mimoFppmA4Ky4CRKF?=
 =?us-ascii?Q?Y0uPb6kB2hF34TY9j/aBm8L5m04uwNdpRkpXZInLyz5mUZZA1nmQ0HfEXNx7?=
 =?us-ascii?Q?62SizrtlbXnQmYj2oisLdXpIxRYf88XC9wJpePCblyyOECTcni4MaWw39hNI?=
 =?us-ascii?Q?yF6OONc+/T2jziEUTGvtNTWbqTzGAvaemy0XII/g9UWR7ykt6sHoeEv764pq?=
 =?us-ascii?Q?oSd23lAmB2BT/xKoNeB6EqcRUrZBG6ljCMQg/s+s2WcDRRnUw82EXiz8H84s?=
 =?us-ascii?Q?F859YlX/Pn6W/mIKylT40nisQ1x1HP1hfpzSzHczY7v44L1RNQLr9S5CRJpi?=
 =?us-ascii?Q?X/uLobVP3VX1O/m/9L2H0qgd077NPkFq6IZnZHJ4vlpNKpgWN+b1yKJLG0kM?=
 =?us-ascii?Q?E+RL3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xt2XRpx37qtXgniMHL+eLgRvoFR+TG0QPOcxJ8/p2jKOudZKBmOfQSy3/3I0DEkOv8TCIhq6kuwzoG1PVEEsbNBw091xO6NMlDRi9OSCGql9KfwpDtl+rVbg1B4Dke9e942xuRJ1DqX0Ecn0Kf8+pVH1tqePjSJORpri9ukzU6gda3W6quADmsZG1Usq8XE+eGNe/TN1eih9VJY3rtrehFfmB4xTvVLrOiyY4UUBzs0OzPsFrpV4k7O8kHk+C1CrxUk4hynCKFZ3Lmg0GQJI+YsUAP82eVPFO3mpimxqw0dxLMKjzaScJLooxwPAkI4Cyz+TjKQ3Z84fxRiaXNyFVZSmzird2AQeA59WVc6ShrcW//ulLsJO21oxbhDs027Er9lyPQ0QkeFTQ3TqgytyhBRNNQz0Y31u3uGXHFX38zX4Gg9WTIlVEDPwjk+EM8hO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:22.7628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c62ac75-e2cf-47ab-5283-08de61aa4ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255638-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,amd.com:email,amd.com:dkim,amd.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: ACC90C6614
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup for interleave ways.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f53b2e9fd9e6..ece1d3df7cf1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static const struct attribute_group *get_cxl_region_target_group(void);
 
-static ssize_t interleave_ways_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t len)
+static int set_interleave_ways(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	unsigned int val, save;
-	int rc;
+	int save, rc;
 	u8 iw;
 
-	rc = kstrtouint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = ways_to_eiw(val, &iw);
 	if (rc)
 		return rc;
@@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
@@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc) {
+	if (rc)
 		p->interleave_ways = save;
+
+	return rc;
+}
+
+static ssize_t interleave_ways_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
+	if (rc)
 		return rc;
-	}
 
 	return len;
 }
-- 
2.34.1


