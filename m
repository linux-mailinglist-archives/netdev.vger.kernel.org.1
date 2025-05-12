Return-Path: <netdev+bounces-189827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F75AB3D33
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F63119E4A65
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099D267F74;
	Mon, 12 May 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jf215Tp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F32262FE7;
	Mon, 12 May 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066294; cv=fail; b=BJg+Zn2663sJ5v9urwh0O9uczzQenKkyuUXfWbRONHZozajwCH6Hv1yX3XLneHCRsTrGUd5VYykMDa/uWvmMvOE5zrxpI1iRPCW6Zq9iBxUIH051tBdVIcHJDTK9qbgm+aTxvLVAD/wt+A2tOtbFTrmlN+mZNI5agC6d5BrxBQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066294; c=relaxed/simple;
	bh=ObKQCyoY2r1kA9jYe9/RWWLSrai76CJCJZ7ayYmqstY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHJMc813YDPpG7g18XVmvUbN1iH4/hvaf3oCzX6F8mgwG80p/1Nq9WdUNeOjm4L9l5rLW2+dONc3B7PrwWJLR2Vd4GXeFa4yEbTLndJrwXUw9BeScDBGEEzhEEX37noqAKntLKtKYMs4Iil8F6MchG9rRGJbUrUXV7lSzrozcvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jf215Tp; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAo026JPL5gy0+OeQYZU8VvyPm8Sa9soaTdhZSJ5FVpTTA4h84CgjBNqmAoHWfUB1t9tyxFGRnItlSCma0qwN/fek3nY0DJWs9mO0OhMa2xTeT0vtHI+UVyrQ5npPa9i98qYRlNN5jkC1Ai6iTnsAaDp+iTqmpsjufeUb4wqIFTH+vnXueq0m5ScTJK6kV3gYUVmikLywIOP0bdRiMUaOLt8f8/XZZJcPJ66FbaWQm6Ek2Vqqchkoq8Ee4nhsC/fz4VpgEx2Ro/sgcMEdu2vq+quFLXc+w68gRV4GzUS4vgkkdJ6wwCj0B9l9376MddystNvFVMo5iLzKbGDFCBP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyn8x1YFCjgMQzkovPB4W4hvQ5wRPsCnjScQdVi6XHE=;
 b=ZbbvrcE9ISoPVlWFVOJBpUzaNwkWXqQe5dUWqP0kTyfqGl0Fv78seg0behSQyG1XYD5NNwxqGaMU1shTpObe2woB/mbSrX3WummLerOsfLI0/ZNDD+j0ZOGw2iVg12QWWc6SyzUUibYXN2zQmjwmaGqlUnbSPojhf9nwKvRddkDwoplziW2tpC4GsNlXh4jnW9GlsdmIzkln9Brdz5UDaz6EYpxwsewfwL3QFpeSHxKUY61XC2RRYaUNP31PaXvDEoMmr0dnPgqpunlVL7mf1T4jSj/b19aISrlH4F4so+sJ/b2/hU0D1komWuw65Z2MngdOHGJvQmcNLnXqSujf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyn8x1YFCjgMQzkovPB4W4hvQ5wRPsCnjScQdVi6XHE=;
 b=4jf215TpTD03QSoeFNr+QpOX0kzPZKTrDSlHeLSHJ5ZdQpiXPT5m6BZX6z07A0OAB3U2lE66r5rCnaFV9aL2gXLAQyLV7Yq/GofA/5Jf+7Ytcdum12wC3bkJqxmsZwmqvuLQayZTcpM3Gwma5fOFzKb0eZ1RLfIWuK2gpVd5/Y4=
Received: from DS7PR03CA0350.namprd03.prod.outlook.com (2603:10b6:8:55::27) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:30 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::a7) by DS7PR03CA0350.outlook.office365.com
 (2603:10b6:8:55::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Mon,
 12 May 2025 16:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:29 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v15 16/22] cxl/region: Factor out interleave ways setup
Date: Mon, 12 May 2025 17:10:49 +0100
Message-ID: <20250512161055.4100442-17-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: f7910d58-1944-491a-434b-08dd916fa834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDA6FI6DV1ceKph0I5NrHujb+9vRCKmMnK/+rIAm8E04LNUDd6lrYdiuDSLL?=
 =?us-ascii?Q?TF7vs3GAvxmGJ7A41vi+wn8OOJPDkPuZuhrLRWz+z91DUDcL1sQVvwDyFnku?=
 =?us-ascii?Q?laugY2MKxLfJXLIG1FM3eCa32mx1zx0A2DCnXk9ld6cwYDcu9dzVUid4qo9V?=
 =?us-ascii?Q?ZHcXLAYQ16d9UeKG3tmx6Tf2UykonI3Q+DOXq9RUYJyYWnjhrEKtjd5bNZut?=
 =?us-ascii?Q?k9fx+8D3lTMGIXcOAJp3TQb2+qnSedeJLoDKWuQcMu9PDv0m4ruEHD7jlyD+?=
 =?us-ascii?Q?576y7xx82oVyBl+YpFWasX5EUoW/gdmboCl+g50tcKQ0zDG+EO+WfxL3ZpEt?=
 =?us-ascii?Q?etkUm33oboDxS1p5YWI88LUQENCt/1GOyMZX0/xNkwoq9xAiTITGUxFreiwO?=
 =?us-ascii?Q?oVwl5FJ4y5t5M+utiqLEJLf3o+1ir4xvo2UKdFYMwTcvJKspi1fospTfdmHe?=
 =?us-ascii?Q?qrzowVBkUlk7LmnmKuJ+yW+AajEeZJIeW6I1xFzCWdvoMc97Jbkp/OVateyl?=
 =?us-ascii?Q?PEVrFLM6srQzvHjb9Wa2NSHqzWpqWLANVXMeX3hT2zMJZpaRHGYEcLtWtkSS?=
 =?us-ascii?Q?TpzFdiEy8b0ibzjJE1i0f13WjZWV84IYUzYMM61HgQyuEhirbAikQDM0SaFq?=
 =?us-ascii?Q?lKrY1YrJhmOm0VFJzFEevFaCquq1sxTelrSOuGpfwfvXBVquC3RB2P/GS/p5?=
 =?us-ascii?Q?NkWg4xY5iBq1D9XlRG/b54L4UCICSR8EmosVNpRRunsS39u4jSoaDTyHt2GD?=
 =?us-ascii?Q?EXZmV64qxEPszO55zOAFYOuzXaDKDuQR+xaEoju1HNypF+Vov1JcWAaG0rB1?=
 =?us-ascii?Q?smfTGY22yqPEkJ4v9m0T+5t0gIy6uPSv0QopKGMSmFCQkbKBZ3fu7IUZY1r3?=
 =?us-ascii?Q?fHppuqwdqOevg1UkS9LgFDI/zkfWcQpy1AGj4t0AaRfaCujuuX/+hvc+fx9c?=
 =?us-ascii?Q?3inPy6XMCu0AhLTpBfBLPKf2Zms2mC5EPv5DxWm76I+gaXzHilorw++VJlN8?=
 =?us-ascii?Q?M/Zd8gtSAqLOAhcKwrgy8sYpM3BCMvsSAUSw1n0KFjtcbhP+oauxvFYZeuAJ?=
 =?us-ascii?Q?9HTevrS6ROV4dUTN+glvvP1f8QJRP0KIG5jdZ1+G40Ia8NTmG1am19Y1Cjui?=
 =?us-ascii?Q?GdCM857PHTmaq+0JdYdY26qfLV0X5EwhXa6OE2oWsfIjcFOlFPdkXSOvRjeK?=
 =?us-ascii?Q?hXq7g7b5hR9w6lC8wq3cipXRfQBB62+pEllaOMlGktCFvSfsZEoZRbeTZw4q?=
 =?us-ascii?Q?OJ5qM6zURgZ1kHs7+I1DjevDbNnBukXCKEP8DfcRlwHii5r2/BBWnLMR45Z+?=
 =?us-ascii?Q?kq9XTftocP1zj5kn3DWrKhO7X0YJ5KnmQ9VTXKMwK5/v3Mzt72jUwuaqqFCI?=
 =?us-ascii?Q?OJcm7EiqXlDyFjmIMHUdCI8MDbumU/Woc9Hw9kEJebfnaqmLMHbglQw0rslq?=
 =?us-ascii?Q?sg4U3SCFmfrgI1pKA2dNgnkuc20Fflmk/iVl+piCf9yFIpJMYqtHsoPXGnLS?=
 =?us-ascii?Q?2qvZ47LQJnNLgtThL2NPBzRuAR2aaGmqAMgO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:30.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7910d58-1944-491a-434b-08dd916fa834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

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
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 466ac8e6e2e0..d97c4a6a67cb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -463,22 +463,14 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -493,20 +485,36 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
 		p->interleave_ways = save;
-out:
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
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	rc = set_interleave_ways(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.34.1


