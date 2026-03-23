Return-Path: <netdev+bounces-270486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNazL+IkwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BB12F1422
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22D9F30059B0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50D397E8E;
	Mon, 23 Mar 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uttQf0Vk"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6551397682;
	Mon, 23 Mar 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265533; cv=fail; b=ksB14yjTEuwjt3ppwlh5y7F6BbKW8SMTECVnlt43HpIxQV0W5HBZ0RD4xxr+7fUwor1Qx10e5vA3y5tlqavF/pQw0q6rd5g2IYdDAUeYDn6Vfy1v08FJpBsv/yy7iPoeFUT8MmAY4bgpKNF/6zvuh52x6PBL+G3U8kUSx5G1caQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265533; c=relaxed/simple;
	bh=2awkSaJ6Bvh+w3Dt8zf0fvoZ8w3N9m97e76qlwR5Tvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqSxajkJB6LkKrOh0xWgK0KdumYzVHO4zkf0gr/99qi94aQa7HRr4XWGGSL1xeJ+cOwdzlPabJEiRBYyPAVRtyTmcAzAAdBDwvDRC/j5rpNb9P+H9UBg0zhZ2kxRtvwUQGlPtSUMNbX/Kr5OUHFJ2RinCJCHAzrdJBf3p5mdhUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uttQf0Vk; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Li8Pahle4nh9GV/YSVm96rGkRFmkyPu0nAzBN+JDcOFgp+LxP9vxHvXClP/fhv+ExcJAeJdoP2Ve9ojQFb7ezCpIKSZJc3YGD6At17oGRWscKj9sPJHJq7WQ97a+EqqlxtjDubdIAxeoiarXcEiZ64MDLkjAdjsF+Q8bzJweBVu+xdGoe/Fj5IwnxG8KzUvHl63r0g17wvJ6X0rkNnSM0S41f4g0U05Q7rby/wWkr55zVkQJmlXNe3lJPQjDHkGSr5FJmlFUJYDyosuPcKA239gOtjnifoi8axlaguo+bGsDPE32Ar29Ih51qEt9bKkWYCYwd0L20yb/lr1LnmNodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjYSBzIa0LqO1E/5nhnWceqKy4KergFgj0Z2T97TsYM=;
 b=LbVN9u/yff1E1X5k7ydwTbtGVUyloRIyep8DrGsx7zUM1bcP3N214SLsDXoMpFB6ZlyCUljWqe190rTBMSk97uzpsNPNjrRzZdFRQzK1moNRldbNjHn0GDQDcxRElYjqWdx/NGU6VF5wkX5qH7FnZ+n9jmeFhcPaB82GFpxYSB4DzHB7XB/1Vpw9J0XUJiTF+mpbfVoXekIP3tzROEI+f/iUtOgBINB4M+IYJckBSHlh7edKKSdBwmTpogtwxtHHbj3jHhQH8AyBYEQeRpHgx70VG/OHkjCo/ots1SSjJlKst/NVgLuP1HkXco6zdGNELBOSqK0p0SwuZnZI/FFdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjYSBzIa0LqO1E/5nhnWceqKy4KergFgj0Z2T97TsYM=;
 b=uttQf0Vk69eV+e2QSHUdWXt03xiJKDQLrMDSVFuufMMUNdRDlQwFzIPgABj69PVw0krOlZ46REHAdV/grzLNKcAXk9DmBG7DlH0L1cbqRfI7YRKNNGYwCDiQwirm+yswYTzvDYr+jPkRnMEPvlBL3VK0yY7sWdHhy5Vj+Q8xd9o=
Received: from SJ0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:33a::13)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:07 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::11) by SJ0PR03CA0008.outlook.office365.com
 (2603:10b6:a03:33a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 06:31:33 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:32 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v24 05/11] sfc: create type2 cxl memdev
Date: Mon, 23 Mar 2026 11:31:11 +0000
Message-ID: <20260323113117.2352709-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8203c5-d892-44af-1384-08de88cfd098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NKNGy5SgQMT9TJCzx1fjmPFYVN092lsAu/v5tMWlaKw37QSx1pUDcrKWSCsUH5uz6+dyrDcr2VlsShJ+DTk9ux+7Kq4MJmOURlTXhwmbNGI9OFMLvq3hpQNxc3Pj4HgSyWtdxf1JPu2uR2fJywdlN6cTMDEb0IjdbYEe4zM74vxzSV+ec9CpemOXkXIqtRM6LhQdMIhqcGi0Aq4s4y20NkOmeR8FrJW3b7z1HS4dwYlNJx5rIzVEvZ2e5Nver/X3C13ti89yPo0pyT96qd33Uxl1Ot+U5VYLTIfQv3BzdSov5rM1b63/P/kcDzYPiSsm2xb0X4VEUb/M44bGHqPg9pFS/lD15EW4u9IUjyVu7geg4AwmrAb8K2h/6Emu6f17JHRUfqTqfa2L/dd/0s6goYJmeFft3V8viIKZ+ECp7DOcZY5W/Wpplsc8g1ECIIfSooLqVV4Tyi9K1/mbuCl5mRuxGli3blRhpdQ+6iJeyRUnSlVPk+/p1Y4QbkHWJV/XiPiFscyxEnucMBSn6KMt8ZDqJGkVR44USkXsKHhmrAEIcrsdL8kbWP+HB0AIAdHKyptGegIj3rroDwy6kAJY8VoM2JRovz7Mf+PFhUAOAhdMU6MhcO1eh93OopCS8E9wQOq9PbheRHugHr6pvmioAFQsSVsqSawdO3hRlKuRdgupGiLiIPAamTnjGQw+GZ19PuLF0Mp4I9GrcWh3D19+iYMP/Y5aVbw0Q8GSoIKTPTAcQfQVQl/EjJVIfxw0j9+7V9ayOUMXojJ/OPetJeyxIQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R+FmnEQI1aQ4u+6ulOwEe6iLUFFuwArw3D59FLMXoXtwvqsnskj842xn9K/2zL6mAlgNVokBt9P7dLGurF0MZjol/BpdKDrMLF3ryaOnQwKclfsgFs02dRhN7f4gHphBXj4Su0D8Xs08QFBD8HdCXqivhKyfUBy8snoGkuvsfHpR/tkM1x85b0+N7FhcoNJB9IQdOnLKwqQSCMe14YUBGIxalWuufyU9jEtY3YulrBFJEhcrR6p282NdhLRsW+XKUjkuni0FweOJ4KBOgOf/r7UXeIsxVA8WE2O6XZffX0TAuKxZHJ0RSljHLby96oEylv6G/EfFtESY7pCpdsF2qtaQ4Rdr4mSm/eF/mi0mRRosFB6COoB8OXV9rZpGmbq/4CDMsWf0EoDsOdBynnyCio/+cEpCZ2+ZXAWDWpXUBtyxPiDbvEAQBT1h4KxyJUky
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:07.1454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8203c5-d892-44af-1384-08de88cfd098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,samsung.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270486-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 62BB12F1422
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index a52238ac9eaa..22a7d1d95425 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -76,6 +76,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


