Return-Path: <netdev+bounces-152284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61029F357C
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412BA16802D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132F2066C3;
	Mon, 16 Dec 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vqmuPP+q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13516206283;
	Mon, 16 Dec 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365468; cv=fail; b=FTwzkBy/21VlnmPS8K9nrNMQbHs0q4fQyR9ZQwrgUOYUAagExRI19tC3ktNthRerHa+rB8YqY1UEb/LnsQ75W10N7/TnadnPWEw/OGq8Uy9jHYygJR2mNnU5AmpJMMK14pV2iP9l2A5MF/sv+QDK6XcL4jdjoP3PSlfS9WXhcZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365468; c=relaxed/simple;
	bh=Kts5pHg0p9lDp0ND/HTqcKAHiEM2YhABi3Hs0gMgStc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbwkiYfB9wWVeUNgf8qGvL3rb8u14E2uL8aX1lwJAJSbYSjNjuIrwpgkYwhoQ0nDZ9LkGQW8LFrMnTS6TwrpB+yEtg2TQrtO8XlmjoV15C9rrQKaL3E+H/glTyHuL5Ljj71KzGqOMq+5eGgIKH7U1pxs70jS/nyY++KoVbdf6V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vqmuPP+q; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2YAElYnQs9xVgOn0SheTKv59G9kZlYrUvWrGRbZVOHxvt2WNXrgAHJn6hoHPnTCCyA+DrHMTJmdyX/1ro71O1P5FdxWOFJtI+eiobbHinBqiTIDlRPoE5el4Jb2AW8ZQXXYfJqkbSPsGmNUkxWCo+NFRSmYjxVx7oPUSifhYQZMHiTM+/eZ1O9mLMXJYf1wvbzas4L9vvu42jonrJL7njUJcEAHKj67WWbleWpCuK5db2Qd+SjCkyl5dCvO66eekmtxeOWIJGMDMCuRHeIKU+lU6Ejjog3TLDLaOpzDGkbw0I/ggDYzpenQ3waPLsfx6kN6MUnWqKrckGzvUGeetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwFgCeOME0TEVvrM3Eh0ovFxeGiT8pf8FmUBiJk0qx8=;
 b=rIArO/6wzRNSeGLlSSUM4ASBVibwtmv4H4AYkh4uSkvBtYvxfzxOhMH2CE84NoIsOD1xY9mt38noYGYi2UfvFhKT/5cC/MOmF6k+0fDz8rKNgj3jJ4NAZRDiZqMI0wZ/EBCskX9Xv4FoSe8wu/NXeI7ixknA2AZDkYXeOXEtZSIbkWu53AIQHgMRAVW5fvbIVjzrfvQZLSoz5KQaVyCvAgjV25CBGC6Njwt3bv8mr1alm/De25mlNvGFQW3KZv0zB87p5TsKtsmqHU0W8b9qqhVJr9jV/D8oAuveCgyzLTO7MGd8GZv/zdf98kxJ4mbtxy/dPfplJl61k6sfoLs80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwFgCeOME0TEVvrM3Eh0ovFxeGiT8pf8FmUBiJk0qx8=;
 b=vqmuPP+qkEBUFjiTQuQHq3g+dW3WaADCuwlef9/2Few/ebaDnXdB6swKMrEhbJhZxns7Z7h/R2S08/0SoVN/+6ET/f2h3G2uwLYAeqLf0ykPFP3FIYGk7XXtJnJk1eDHMCxKGi1fBSgI9DcyF8Pcj905/E9yibe3jjz+zqgMIDQ=
Received: from CH2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:59::20)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:03 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::13) by CH2PR03CA0010.outlook.office365.com
 (2603:10b6:610:59::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:02 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:00 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 07/27] sfc: use cxl api for regs setup and checking
Date: Mon, 16 Dec 2024 16:10:22 +0000
Message-ID: <20241216161042.42108-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5d34c0-e30f-46f5-deab-08dd1dec3cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IKIFDOjkESLOIwD4rL/+N9rBPmPe0AUQuPAzCyBRM8HiyFCcYpgNoWtSE69?=
 =?us-ascii?Q?8kDsdZ86Qiy/gUd2HuO12J2scFzxiUNWJYjxoMJxtXZZonDDoPJgJ9rwBb/0?=
 =?us-ascii?Q?PlRna1rRE2YCvRF3ckbLzsOEDnBE9vSqj9Akie0wnzOV4FkheB1S/9SDCof/?=
 =?us-ascii?Q?yBfAUADpDttdvN8vm6GO+Bv/eO4cPDnpgGyEipGRCI9U90yz0cw4dNrCrEyq?=
 =?us-ascii?Q?5fc0F9PIJgTt8RR2e5y382iR3/yr/2roqZowF4OVgaAopVrZl4eoMXG0CauK?=
 =?us-ascii?Q?3nQApCCq8gZvHKSbXATa3/ve0lo4fujY8o+lJ2s4CB1JhkPs6fv/tIX9LT8a?=
 =?us-ascii?Q?Coi4GK+DfELE4HPz1rzaunREkE8Tz5x59TdVemhO+UM0AMib2vH+0htZL7dP?=
 =?us-ascii?Q?KbD/8zyHgBrvQFeBn5KIlJ/3P+/CVWcRJjNfVhFT14OCSJ6MvKDR5X21LU8P?=
 =?us-ascii?Q?wsWvryjieKmM2bkX8CLDQ0HmYEHhSKrXRk4mY0dh3m+FCgQHJO/0NyAQOjzw?=
 =?us-ascii?Q?oT7JXGjpLAor96fImYD5aUzrKl7lPm0TWaliwjZnmYM3oJs4JbsH4iM2m9ql?=
 =?us-ascii?Q?Kz0pzZtUZM/4MQOhrdMd/5wXa1i1wazA4jGFKL7Uknkj5w9LaJRHWUorDogU?=
 =?us-ascii?Q?mseRB8IHZjjUdmRiWmbjwIlFo7t4XDBXLwZnU7nzKtwV37Kjrji9yiQVYuec?=
 =?us-ascii?Q?uPTjyKHtrQM135CB0G33xFQX8eHyu23oLIB0VJx0HCmOYV+ky4vqj6PsUNs+?=
 =?us-ascii?Q?1iSaiRfjdV3eUuYn5usJNAsOzj/GkWHd8zi+FTjPW2yJ+BkeyKEebS+/ABr5?=
 =?us-ascii?Q?5l3y4emNJIMCKOFWAqDe/KKRbJ1HKipP5e0dY9HAJzDrvP6j893W31cdEaja?=
 =?us-ascii?Q?XET866WReJCfMXmdqBXTvnEVIg0E18/XdtvmA9gWqaiqDgg7jrPHoMJPqyGB?=
 =?us-ascii?Q?iwiBV3QADAt9TkNnxScq4aEUFf3uzx7yl4S3MtDJaTeksmDLqBwyedBRWl/6?=
 =?us-ascii?Q?tNpgwYah4c472H59lkZm4Qn/7fgEBYi+b+1hXWLv9bXcFT43fWX3yHeBeza9?=
 =?us-ascii?Q?F/FAmLRRoR6Coic07S0TrONy2A2Hsoj9pIl91xY88TO6vvCgiQjM93lZDzgL?=
 =?us-ascii?Q?5WZrnJGB75Wdua/xB2mLuivJ723dBxjbjNluWx/22cBESGqhrLD5KGCwKM0j?=
 =?us-ascii?Q?sshxRO8SKnJ4i6mmoPWHMMsjyrnkmyAUlGT64Siauz8svf+xWCerhvx3i9V7?=
 =?us-ascii?Q?Kzku2w3X/b9JGiw8wQf6ryqaIXPliuRtkE8fBrWsRqQNfTuTP/IC98FfpXj4?=
 =?us-ascii?Q?bDINZHiHNsIw8X3G8mnJG5iRm7bkPQb87foYYAtrzsw1L2VCSlGaO7pECorh?=
 =?us-ascii?Q?ppocxCpDylUAZH0LNaKJ/faaIUtwd3IgNo+2EcKfCXKftVUBeSm4ZzfUc39n?=
 =?us-ascii?Q?1k0d85Lg9d1EUdebdvOBnga9C/JN54irBPpWKVytnSu1D/jysXHtiEyTPyrA?=
 =?us-ascii?Q?ve7twwWUiqLY2s7WA6jA4w/SyJrfbXO5Gi/s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:02.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5d34c0-e30f-46f5-deab-08dd1dec3cdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 356d7a977e1c..d9a52343553a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -21,6 +21,8 @@
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct pci_dev *pci_dev;
 	struct efx_cxl *cxl;
 	struct resource res;
@@ -65,6 +67,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_resource_set;
 	}
 
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err_resource_set;
+	}
+
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
+
+	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%08lx) not as expected(%08lx)",
+			*found, *expected);
+		rc = -EIO;
+		goto err_resource_set;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


