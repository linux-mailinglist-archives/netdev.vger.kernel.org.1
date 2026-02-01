Return-Path: <netdev+bounces-255635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gt9MEJ4f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A23C65FD
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA61303DA98
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB29243387;
	Sun,  1 Feb 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l98pXbRT"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A2223DC9;
	Sun,  1 Feb 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961321; cv=fail; b=YDClKjPGs8Fs2UL+voKjjGDU1KBC65YdsrteNsoA8QiILAg5bK8yHf06K1cL/mi2D7e271i508qIBRtypzSLtlz0+0l0e0rG7zYeUUSOPHxkaU9+9neG0rsra98PMEBmdEvuIsJL1V3msr3zJ9mTaQbYpV9+Xumm7mUKEQp7wKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961321; c=relaxed/simple;
	bh=M2n14HVFwFEi9nSKNSj+a5R+QjwIpD9+Ri84tlPDrj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4KrU46UCd0LxvWB4SBrqzzTfbJmpmk0uz0y2eRBcUidsJJy+z3wpz7cJpqy/YOAhuesyOsFgo4Atyth0Cd5ybIg7nUa+o1ODRUwVU6aLD0kCj9fi4VQpVPv6Ck339XylKs7ywAre8dkMExuv+LCz2EY6jFNyWfp21/rMmDFfeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l98pXbRT; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkbZttYUKDyh6RS13XrSlcOw+SicT0gwnpetbU6ETAAaAcvFBwKdU8olZAcFJfuy9yhHO2keEjvH7gMADLODJ65pmi0mEWIFI2/IahAaCyDes1M2RGi0hzxdX2iDNhkrvA2OneeIlGW4GX9WGovYAN/Py2vGa71/3ixIYsUrhjuA0rKdlo0KJnetTBi4nDxJcEDClW6MRsglZF1Nlxvu5CG0MvBK5DF4SP5dxv2O0t9wb60zyMYqNrkqG2640PyzL+uhn5iG/A0J4fbMgRY/8pkyS8MZ4u4DAhshOamoXgtA6KJGpaD5R9P33neMQZfLyxc4YngCT1HSsxI+cZqvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+E+F/CXsqPCcrDgcR1Bi0cbMmPuCPTmI6tO17uP5zw=;
 b=JOlC0U15aRorjUuLZcl3YQ/yz1x3xR9EbwrrHbP2ClCPLrnYbC3+7E/5xtg/Av9Z3MEEQKnxVMseTQTdch2EKhKyOm1yWH/eyqxRcLz/tocThA+6eVxxUt2itnGTPgZ7SiU/jTIWfpOSU5SgIy8XVqjgz4oIM/8m/qqBOfu2o9UW7RcMzX3gRH1pCBW47ni5R3wVDkVeRqLlfui0roDcN+yg9OrEo5Eb3NWuz6jWg2K0szUO/u7GgQpgpY7bHip6GAmSyQrfikEoov3kZN/2ppP5ixRB0HCP13+jA3Dx8G8hk89pxkCAdJZywM3/ED5Ds9MP+pnrUAi9RMpilOVbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+E+F/CXsqPCcrDgcR1Bi0cbMmPuCPTmI6tO17uP5zw=;
 b=l98pXbRTrPsOu0TjYz+CWrUg85avHTT7MEYO5Ztnl2T2s1C2HUVqFc4rs3bFeoXsCQjyaEfOFi/BvwNINy7TeLepEjOJlrZ2vaWjlXjXshAMYbxroG8aGoqvBZM3IDRSI8bKIBr56TFQYmy5GUh/T/I8BELD1gbo5t4kGqFKx6o=
Received: from CH0PR03CA0430.namprd03.prod.outlook.com (2603:10b6:610:10e::15)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:55:14 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::4) by CH0PR03CA0430.outlook.office365.com
 (2603:10b6:610:10e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Sun,
 1 Feb 2026 15:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:55:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:55:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 07:55:07 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:55:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v23 13/22] sfc: get root decoder
Date: Sun, 1 Feb 2026 15:54:29 +0000
Message-ID: <20260201155438.2664640-14-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c14056c-3af5-4f8a-f2d2-08de61aa497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqoHNlfjI+wYh82T0wHwA9LHVCuOzrV4ZA3qBQjBo83/9PXjwFiDD5HKlylH?=
 =?us-ascii?Q?a5g/FdqX/AXNO++AzRhHq0oyYqqOTQYCPsWn4uAOResi9DBZZ9qGU6Tb93Ve?=
 =?us-ascii?Q?HS3Dh2sb79y7vKbI4PwDKJIdNS4UDYbtUtCD+IMFM+aHbxfThSLB/f+DnK39?=
 =?us-ascii?Q?o1BAx9Y2rms+i2IVtJL+nzy3b+M681TQqlrrsCsGqTFF9ucdC91Gw+LVLf9g?=
 =?us-ascii?Q?v1tvH85mlUrGm1vz3MlBs4WgaoRxinPzgFh3iHmAQyGjMKY+wL7iIo4keUIl?=
 =?us-ascii?Q?j5ETnVV4eJZNFC58zyZEMgMtrfccKYzexthnO89mfLeSevaVE4t8Dz+fYznk?=
 =?us-ascii?Q?0ILdoZypp1tMdSQ+OZe2/cNeYMbPrY+3YPGgfgQHc+0GdNd5gwhoLLTDTlVo?=
 =?us-ascii?Q?iEHb6MwOyTH11vATcDr/P3WUO3+0Xdy4dF2UtNwaN0kR3+A6dflLgNMK1l91?=
 =?us-ascii?Q?GUTQDHn6auD2kiglLXEd74uIfSakpBMGsoOspQCGv+RDFQkvcWvm48XJKZH5?=
 =?us-ascii?Q?Ylf7H/++/7zxaiV859ZbeYhoungTkxf1MJtbf63NwRclEocgBPgmcGm84GTi?=
 =?us-ascii?Q?e3zQ9yxIN0RlKM6EJrlN7YvLyM3MubQd7sNwGn2xDfE2E3tdO2bgMujO42bp?=
 =?us-ascii?Q?JeMg0v5pKmcOy1v+9WovpELUoRJVWof9ROwxD++S7Lz5XZ1K08/NN50V3Qqz?=
 =?us-ascii?Q?9xrDoiOFiu1O43P90iheQAOEh1+WOHT9o6CUbSbbZiWMR6WMC8G6L+mWYfID?=
 =?us-ascii?Q?48mFFiNiXTE1IRMJlZclWaNRHFilTap5BDY4x2wBnfjU5qhFOLMXPLWNYWxn?=
 =?us-ascii?Q?cVOKRRT7uj9fQrOQPm73q/df1n8bTgdW/z7r66EDA+JZEqx8TQ2DukmCe/va?=
 =?us-ascii?Q?K6u5N1dl3z8ctEyWtdhD8Lpuwjan7YUw08ss9ayvX40w2SaYYdzCI4wlLp6U?=
 =?us-ascii?Q?YKxn8eH/BhhINOa61VaPaMg99inxvuA7NhGwCTbGwg1X+Isgso7DtDORdRyO?=
 =?us-ascii?Q?xSViQLZySNUp7H7/fpH2ddLc3+sgUSHCX2o96BYB53t8gCYKS6S/W9V1P2Ps?=
 =?us-ascii?Q?XRzymbv3Mx/9k9G6rFknU65Ri6tGZpE+qwXk33uuS98138CkgFEtQKTCH4/Z?=
 =?us-ascii?Q?9Tr9QQkaDGPiHJk95WIcY3uwoQ86OoRyLePi8Id2ZVtRqvllgdk/zBzT9PxT?=
 =?us-ascii?Q?XIJUCtYGl0SBePTQ4DMbiA7sJ9Od6pyy2g6Bs9fXG/j7fCIyJioABs6JZnBX?=
 =?us-ascii?Q?Bt4LszyjQXuCY9i7hIWmSpGNZZIrXItroavJooOw5gtkrtxG2xlo4zcO8RGL?=
 =?us-ascii?Q?28uPexlDLCa5lE1wYvoCDLu7qI9JDWr9abndEoiTQHm/uXvlgysyLvhZFhfC?=
 =?us-ascii?Q?hfmOvPngs+WuIjew3bgGL5er0kCNnZDjxUnr6B2wL+33ljQFJne7M4jfku28?=
 =?us-ascii?Q?H6VbtcnNVx7cWyJbZryCXv1CzvwRrHdNCzNPwFB7mt7R2pv4XfRI3DYFpZPz?=
 =?us-ascii?Q?P1I0Bo7qNhMJBltmPm/URbUyqTkfs2Jdv+qoQHXq2oJnxk/Qbncxtibdtqrm?=
 =?us-ascii?Q?ZDgyF6GmBYHHH7ChOI9ArBn3/tyKlExCULOwYQR+x7kPNKqgJZbqkKK8tY2P?=
 =?us-ascii?Q?h5UWTJEqpBtjx1OEch+9BKdF3sS8/f38VR91W005szOa7Ob2YuMT5G9ZyyPw?=
 =?us-ascii?Q?jpdhrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	60ap68nzTjUmFnDQy9aT+EJEvz1TMapp95sZCR9CpfaNWNJRvhJleMxz+Bm/SdS5pYaEL+VCiYGx9Fb2d9jG6dNcp3FCZdr3yNV+Sa9qTEtDn52w7tifHxorWz2xAGkJ+22ZVxLSTXDidRNPE4aGyFELVjOw5H6TgUh9CUQqoZmJHNjlBuJY+Z23u4e67mV+wK7xbf9SSDZuIF63TS7ncG1+NYQZ2I1C9QrYE7pWDvvVyH8QAHOMX5VLQxV3fhOZ8amAAXvQmzN3VAbzT8V8i29rQ8NlXvMdwMQjFEULHZvcbQkLa8KtmiVKBkp56KPEjR/wcUUUeSmq44PksFLADC5EUWMtIse+qKLUaA6si+TcFXk8Sk+QzKO4RR3NlU016Nb4zy1njHbZO86Zngv7A0sUIqkkmYtYzhbmPa2Tr0YK4o+F5oSSHwKBq3pka+QH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:55:13.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c14056c-3af5-4f8a-f2d2-08de61aa497b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255635-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 26A23C65FD
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting HPA (Host Physical Address) to use from a
CXL root decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/cxl.h                  | 15 ---------------
 drivers/net/ethernet/sfc/Kconfig   |  1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 26 +++++++++++++++++++++++---
 drivers/net/ethernet/sfc/efx_cxl.h |  1 +
 include/cxl/cxl.h                  | 15 +++++++++++++++
 5 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c7d9b2c2908f..d1b010e5e1d0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,21 +220,6 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
-/*
- * cxl_decoder flags that define the type of memory / devices this
- * decoder supports as well as configuration lock status See "CXL 2.0
- * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
- * Additionally indicate whether decoder settings were autodetected,
- * user customized.
- */
-#define CXL_DECODER_F_RAM   BIT(0)
-#define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
-#define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
-
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
 	CXL_DECODER_HOSTONLYMEM = 3,
diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index 979f2801e2a8..e959d9b4f4ce 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
 config SFC_CXL
 	bool "Solarflare SFC9100-family CXL support"
 	depends on SFC && CXL_BUS >= SFC
+	depends on CXL_REGION
 	default SFC
 	help
 	  This enables SFC CXL support if the kernel is configuring CXL for
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 3536eccf1b2a..1a4c1097c315 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	resource_size_t max_size;
 	struct efx_cxl *cxl;
 	struct range range;
 	u16 dvsec;
@@ -110,9 +111,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			return -ENOMEM;
 		}
 
-		probe_data->cxl = cxl;
+		cxl->hdm_was_committed = true;
+	} else {
+		cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1, CXL_DECODER_F_RAM |
+						   CXL_DECODER_F_TYPE2, &max_size);
+		if (IS_ERR(cxl->cxlrd)) {
+			dev_err(&pci_dev->dev, "cxl_get_hpa_freespace failed\n");
+			return PTR_ERR(cxl->cxlrd);
+		}
+
+		if (max_size < EFX_CTPIO_BUFFER_SIZE) {
+			dev_err(&pci_dev->dev, "%s: not enough free HPA space %pap < %u\n",
+				__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
+			cxl_put_root_decoder(cxl->cxlrd);
+			return -ENOSPC;
+		}
 	}
 
+	probe_data->cxl = cxl;
 	return 0;
 }
 
@@ -121,8 +137,12 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 	if (!probe_data->cxl)
 		return;
 
-	iounmap(probe_data->cxl->ctpio_cxl);
-	cxl_unregister_region(probe_data->cxl->efx_region);
+	if (probe_data->cxl->hdm_was_committed) {
+		iounmap(probe_data->cxl->ctpio_cxl);
+		cxl_unregister_region(probe_data->cxl->efx_region);
+	} else {
+		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 961639cef692..9a92e386695b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -27,6 +27,7 @@ struct efx_cxl {
 	struct cxl_root_decoder *cxlrd;
 	struct cxl_port *endpoint;
 	struct cxl_endpoint_decoder *cxled;
+	bool hdm_was_committed;
 	struct cxl_region *efx_region;
 	void __iomem *ctpio_cxl;
 };
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 834dc7e78934..783ad570a6eb 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -153,6 +153,21 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+/*
+ * cxl_decoder flags that define the type of memory / devices this
+ * decoder supports as well as configuration lock status See "CXL 2.0
+ * 8.2.5.12.7 CXL HDM Decoder 0 Control Register" for details.
+ * Additionally indicate whether decoder settings were autodetected,
+ * user customized.
+ */
+#define CXL_DECODER_F_RAM   BIT(0)
+#define CXL_DECODER_F_PMEM  BIT(1)
+#define CXL_DECODER_F_TYPE2 BIT(2)
+#define CXL_DECODER_F_TYPE3 BIT(3)
+#define CXL_DECODER_F_LOCK  BIT(4)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+
 struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
-- 
2.34.1


