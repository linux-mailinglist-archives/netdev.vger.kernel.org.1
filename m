Return-Path: <netdev+bounces-152286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D749F3580
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E1716A547
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DD2066CE;
	Mon, 16 Dec 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0tzLHCU/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541972066E8;
	Mon, 16 Dec 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365472; cv=fail; b=VQzMeohSNK3tlMJIwGIF9kle6oOWwCZP9jIHcgAodWUT2UBwnhB/5tW/06oTifRuNtkj+r4YZtAqUel2R+dAM9/I5s8RLE8PyI6dujUEgRz1bB7lt6/mJEa/0vLgA/8bWLvwXvpzmepPuXwT1uQOj3kmIu+uHwZfsfHy8+nkFtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365472; c=relaxed/simple;
	bh=Qf0o92+gQaWtO4dM5dSppafrtPnARuDpGAAPJv9Vy1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaDXvM/APywIKCp7z0uEisMiO/gxabaK3MHQChPdcGsjZf7iVYU33WwcHPoefk41L7RrbcBLKCpfEwBidfN/AmFFycPkx45jtQoEHQKuIsshHPngmfcBsNCKG7t4D1Ti60THJRHRPl/c8I3TTPkbWo2pOXX18BcnzsUTnnwDpf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0tzLHCU/; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0GNgFibJ10G1i9PSj2E5zSD+fxrQast3IbnWKYi49n7evq/UqdWn8utEONzgFcYBmmTTttlrUeP7xkvYagzSmTGPC290vwFqKnm+eJ6sgFjXM7Ck34udUz07hzQ+bF7/RtnWUA5h5aRrXjirLP3SWGzA+S+WU6srWhuCbZ3nG35FthDm63iW5yuGayEsIFXIvjOruviLR6QPDhLXl7no6zvTh/YfZ/Egl4oPMNs+zSgsV0SkkiWSgpwtNV24he70i0XI1GJwehhV/fenWINWZqBisiMyhUb+9JzV6Oc5/J/DQy3peMilT9Rc8h0S+6ZGDwfOybfg6o+TOKiZb3y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcLqUbiTaEdHfIofMRm6VJy9xB1LJwnq48OqW5ix3Vw=;
 b=GFcn8LN72P1qpoeMCp3thnFO1NlszD2YPBa6jmEsL9Oe3xCJeXyX1HCj8eRwAK246Ldj7uVM+fgtT2t9t9Xk3Ls6zFnNZ4GMipSKrOsDnzWx6ktpdRyhUo70PCOTAzZ8QS6ObeMXAtkwU+ut/pwMvkLsV1abgTWKmFD+Exg5nVP8uD4MY7EMW0EDSqCU97ZM2vS4oQs7hHOtZDnvJ5Fm/2D63INsNH9Kndj9t1vbSisB/PYpxJrF7g/KthlwLE0Ok3THxk3mudmB4kdGdGZw05q9fz03jvGmfTwqq0d/e/cYIREVSpiajRHlDkc+w1ykhYz2YcFM9e1/udL+DQODbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLqUbiTaEdHfIofMRm6VJy9xB1LJwnq48OqW5ix3Vw=;
 b=0tzLHCU/Fl8SygZxo2wM29qbvu/MEktd4TNw4JpgNsTgathv/aSa5G8Wt8qNzFKpwa1evCu2rKaqUe4RvC4Rx1v4nRn1XiSPbZM/y4cs6Vf/Hs2s+hVwMxGXPLOLTvCXeHpX3cS/qYrK5Oz2u+VJGrqCsnwaBtI+9vbK3ZrZ3C0=
Received: from CH5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:610:1f0::7)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 16:11:07 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::96) by CH5PR05CA0017.outlook.office365.com
 (2603:10b6:610:1f0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.10 via Frontend Transport; Mon,
 16 Dec 2024 16:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:05 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 10/27] resource: harden resource_contains
Date: Mon, 16 Dec 2024 16:10:25 +0000
Message-ID: <20241216161042.42108-11-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 2096645a-2c3e-4032-e347-08dd1dec3f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SQ/67Q7/7eV+iRpxUnqWYfwNDdWQNSA1jH25pVHRPnHc0aqL+oI+wNvm/I2S?=
 =?us-ascii?Q?N0FBy6I9PR56AwN0s9AxqdpVfz8kb1gKrDD6heM80B8ltyNUtjqLg8n+05x+?=
 =?us-ascii?Q?pP3VLxv32xnfeHjxIgFHKzapYyu0Y/pdy5qrhqOD23ERHYkIJ59I+6MDaLDi?=
 =?us-ascii?Q?Ob51DjW50tjNRoeK5IH6GeKbvwkD5coVDJGNdHvJroTKFZ186qgnOpGpCdFN?=
 =?us-ascii?Q?PTZGAOxYkqOfMHJO1v2heQ0dyxIfAYJCd6ZyAnEDT97Qm21r1y0Fkm45VOri?=
 =?us-ascii?Q?kAY9DBLOBaMuY/PkVugHzB4nONcksscPbrdfLQv3kk8ln/0IFttnb169OHH+?=
 =?us-ascii?Q?jMcQzbOK94fjYMJxWuvciyAVY9MKv99UeHlBoUSP4JEhUYVM13yzow4m7kOt?=
 =?us-ascii?Q?9aSO6X+8IEqNAS4em1tJZCTiEJTy7QOjwNOQ2WUjhO2CFKXIuE/ZKRBtIQ6i?=
 =?us-ascii?Q?TeRfLreCWpkEJcvHimjQAjn3Nb3RtfzOBqBTv+rVvy9jrzqtxLt6Lh1DZIU4?=
 =?us-ascii?Q?WaGPh2026UVFAvl06B0Wf6hxgUVjZa0yYVPcSNlKLd+LtZdgqILQQznIreko?=
 =?us-ascii?Q?jfUtSh3h75cGyW3KP8gKurexV43ca7mnvo3CzdZwObW5F0lBFgfGRCfeCwqJ?=
 =?us-ascii?Q?6IeAixbmQDjq8zbYqd+vCunBADZvFyTLmj31F7JMvYsjCm4XCkXiav3oCkie?=
 =?us-ascii?Q?Rz0JgVDVnGRCs/YMDChYNWBeDOmPqyuM7S47K1ToxOYUa9Yqhif2GoXXaVnp?=
 =?us-ascii?Q?4wUSMDBIrWDlosLvcAr4SPqQ/qGk/crREbqzwlt2uxS2QlILGpD5UOIUoeNj?=
 =?us-ascii?Q?iQwpP/UBgjD5iTvV9FvYtAiEau9DBJlA7ii35t+nsJ90fNS+QTGg8VRSlXA4?=
 =?us-ascii?Q?zgqeBC16scW24tgPcxTsP5KHS7sI6GT4ts5lSVNR+IpZ7cBanueCTL9uP/xf?=
 =?us-ascii?Q?KJEti8+WwXFak3Qhf3aj6AxROENkZ7UncDs0iwV+zgHziJaS3OAqf559a4e4?=
 =?us-ascii?Q?kp955P3E7Uu6Fwv+UipjNmslbjId5ijyHBinfuINOEUUoBoRgt8XkS3mzysR?=
 =?us-ascii?Q?Saq2ds8vkq195DFSzmixj330SqIYrh0oqdXvZee4YTBDyx+uxllQ5xA7c/0p?=
 =?us-ascii?Q?hnQ8zYv8wViVLRZ0s956u9tuId/BcJRBx/rkx9Pt955KdLl9RCM/ttbdooNk?=
 =?us-ascii?Q?mZ5uzpOTpj789Y4MaNM3HgLczn/J56VrBtZlNzX2tVGyJbg5+rehUiPhCdaY?=
 =?us-ascii?Q?3mqGJ3AKb0qossgJPVzjKfNA3Al6Mzm1KEACqX2bhdq/pg9o5uHjO4VjI6OW?=
 =?us-ascii?Q?HwPZgUk0m1oCfoKXfSwSFzjJMmOX7jFEBx1e5hCQ40M2HM1HG17iwr5GpF5+?=
 =?us-ascii?Q?DG2Ctu/1EKKtPhBdzbi3/DE0b/BPIdPAResCMwxIeTDJ/SNJpp0qSy2t+EUr?=
 =?us-ascii?Q?tw2SqSTodFkS+QbOh0WbJphfevoI2ld7BfgKrcrshwk0Jl81MpsyZclTN39b?=
 =?us-ascii?Q?SnLZIjvDwVmGL8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:07.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2096645a-2c3e-4032-e347-08dd1dec3f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

From: Alejandro Lucero <alucerop@amd.com>

While resource_contains checks for IORESOURCE_UNSET flag for the
resources given, if r1 was initialized with 0 size, the function
returns a false positive. This is so because resource start and
end fields are unsigned with end initialised to size - 1 by current
resource macros.

Make the function to check for the resource size for both resources
since r2 with size 0 should not be considered as valid for the function
purpose.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/ioport.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5385349f0b8a..7ba31a222536 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -296,6 +296,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 /* True iff r1 completely contains r2 */
 static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
 {
+	if (!resource_size(r1) || !resource_size(r2))
+		return false;
 	if (resource_type(r1) != resource_type(r2))
 		return false;
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
-- 
2.17.1


