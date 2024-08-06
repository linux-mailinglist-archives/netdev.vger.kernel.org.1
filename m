Return-Path: <netdev+bounces-116159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98170949525
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5330F287913
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779053E24;
	Tue,  6 Aug 2024 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvckkT0V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386584D8A7
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960131; cv=fail; b=QkElGmSaTgIet5x5avmhgq0YroCt+QDY7y8WgVa+TcJCjS7adsw0YfEf74soQmJJKDTSIGg5p9NvgiggFitTZdnYJuT/91Fzqr/KB6nPBZs93dncsEsqfS8KqEcKDgeoIs4NydY6SGxcOmcNS/N8f8OVNT9IGT5Fh2+jcoe8Bck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960131; c=relaxed/simple;
	bh=qSq0XVX8W+3FFWLNlk9rm+IKdwlqPK05AGsQUMDMZfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlDOP4nkW0a6iangp5AEXEf0rCc29ks46UtnBJJ54vYvYswxPeIXAA2S39SL7DEb1f4UUlM/Kwz8MkhfGX/BtnEsth9qJiHvB/qqR27IzVQK2PRgVoXqWQGq/NH8LBVzKaBAFy/lL1jN1nbRY6nUCcxn8drlfxlKVYHsNtS7oC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvckkT0V; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txo7d5ZzOX0BQOx6A6YHcLevf22VEa01eL0r0eYNFzAAoVZ6tn/pzXf62H0slmbggRDHBdJnjE0ryFfa/mcCoTYshOXv1fxhZaw2nJlvDn/c9gMxS1kcXrl4Ns4Ir02tc57SFe0OBdswte+NOlF0tswE+S3/aHxji7d0GpolKIxA1lNJoBChrDkMTJNU4JlbB2GVBI6duBk3zDMcaEhKNSlIxTe+MlGYdV9p3F7SanW6wDefDiOhB7pMlJOYOOkOz6qOHb/rsShO3q9/ZEwQU8hxLq92p8nQTYan2VeMoAfnWXsHcnP38tBbTpCfeYPwByhhL1j5HaBu33skjCez5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICZL35DcWih5uEkNbfxgkkuxArmBpYjizUFU4RkXLvE=;
 b=uhPGw3skzzSThVVrF2+t6JHUdfDPWP5MjUNU7f0qP2UJzCd+89UTvj6HMUKu9myXLdp80f/s8ub+AOnVDm9+wWQGdb4htNOaN2RdU/yrtYO/PWlv/yHuavOR20uJM9v0OMKrC4ZBBMrk5iX5kyMpFJgbR5pQsZvyjhHcgB0m8ZRJOn5w4UvhpKLs4n88pWdmSW8qEw4RUe65e8GzPpOMRKOYN9g4vzl2WtUWjiXQPDLSK3lAR5SSC1qDmaNM8Jj1Kkes48vWp0M19n+eJNpZ68tCvh5ufD791V3jusS7gcIQzPskt2xZitdHR/zuq/OC11ugk8bAgBHfW+gdGAm+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICZL35DcWih5uEkNbfxgkkuxArmBpYjizUFU4RkXLvE=;
 b=NvckkT0V515SncxrkgwShk1CDDlORwD5tMXvOAi07XVw7PJQYP/uBJ6YrDo4Uf340VQ3XiQ/BBmc177KEYQTNPzhAUO4kvPdFTJZsCvUvU/DKVUn9k/hHs8f+lsFEN5d6lW+paSQrjf0nO7B5dCwwi/4qBe8nQv2CZ9Qu8l8fMs=
Received: from CH3P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::23)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 16:02:06 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::96) by CH3P221CA0023.outlook.office365.com
 (2603:10b6:610:1e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Tue, 6 Aug 2024 16:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 16:02:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 11:02:02 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 6 Aug 2024 11:02:01 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net] net: ethtool: fix off-by-one error in max RSS context IDs
Date: Tue, 6 Aug 2024 17:01:26 +0100
Message-ID: <20240806160126.551306-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afc1dcb-8da2-4a1a-87eb-08dcb6311eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBhetak4eMFmvibAYp05Qp6MtexT8guQwhM8OUQEzpeZBke39ZG7j01f+NDp?=
 =?us-ascii?Q?JT3cg4W5FpX87qJqoR0C9iyhv0Xg+XEsumJVsl0fd+8QYTLR3HA8czNDqCjG?=
 =?us-ascii?Q?FuxjySd+wwMsoRPDBfq4EB7qAsOXR5l09maCcaYlqGp67DFdi8TrIaAzSLJ7?=
 =?us-ascii?Q?FpmWTAozZVM3oN5mJ4HiEuaja9gl2l9YAu86FpCQF4ivcSuWg859+Gqf3ckg?=
 =?us-ascii?Q?Jw+tufM3TJ7fPVYLwL6qPP5UVoZmisZufqZfEbYiuXG/FEQ97ejh824MHrC4?=
 =?us-ascii?Q?UTquLRVbg/gXSaqIxDPzzgxTXxHw0Ushv7BfQ8Ac6BukzDbbZZs9ncLv4jVa?=
 =?us-ascii?Q?uI5dpfQCx3T/D9K6ry0ENi39wJf9WIV1zRQWnIiOsxzO+GyLh4/FZ3mmEMwQ?=
 =?us-ascii?Q?6A+mvDZ9i1XWbBO9v4aobHvvf5ewmtBEFwUkDTjZybk+13wC8uQkiU90ZLV8?=
 =?us-ascii?Q?/N0yiwLEZglcZb2mifMPJXOO5rSVMFa9WzuZiRhfI5b83jeQsFoL70NcEmKn?=
 =?us-ascii?Q?fvVXJuRCk7CQpyG3DY1wvRZ4N5ClKEB+fYEqcQ4VPBtZGs3Ov2lXqCnSBBKl?=
 =?us-ascii?Q?Pi4U5LjL/2x8/mfSOfY+31B4uoJDonOvJzvvVuWgk5Q/qUUg5vfgz9QJeEEK?=
 =?us-ascii?Q?dm80GNzWAyoq0dFGAgMnKn8kUgGsh16tE/ta/CNLdY+wnsrGNczJXxjUcbfL?=
 =?us-ascii?Q?kdeC83dFfAPrzeXIGLZnQaMMnGzPt9H2HG7rQYE3B5zgLefV4DdMgj6Faslj?=
 =?us-ascii?Q?Ei8ChyH5tSi/ktEKSmH4+Hc4bxx0NK+/uIKp4EfpElg6eeS6XOYnchiTOBZE?=
 =?us-ascii?Q?2n+1kc+Pwe23U+7en55ldodVYnBmvZOpnfFMTG+9Q1tpHDKdzBbYDi2+535f?=
 =?us-ascii?Q?Dv1c1Si6/+pS15fWYg4sAuyiNtJBjcxvKU7fNHcF+A8b2+K05f/ohn8QeLKE?=
 =?us-ascii?Q?nLs9FrjgxMoXAESd0JhlWxQpUF1ORrgE9a0CLP5rNlXDhjfYkvRovayyQ6+d?=
 =?us-ascii?Q?S6wPZzrNMBGs3oQoYpCBQQwDF9lwUkQD+aMoZ6zax2eqv26ovvla1p643YI+?=
 =?us-ascii?Q?wYanq+GTKIMM+HSbFY3AFJc40gYmcwUCOpxSE3zICGmId/0gB8vBxWBYs1uK?=
 =?us-ascii?Q?M4b1FlRxbTtajQwLj13gdpk7wm0Kt6NFqUilLXlvz4j0nzzmSYLyC40+L7VM?=
 =?us-ascii?Q?rwSe6P+Vy2f8b2uC1yjeYH7enGBFgK60UC5KVYx0qbnGWRiCZHPoUNoicSjD?=
 =?us-ascii?Q?mH1+x41qJCQZrIeRwgE4d07SALWAH7kqnpSHK0e0SkiVyb3oxnKkWepjnY7a?=
 =?us-ascii?Q?uRDfbaUMnB8jCJnJOw3/Nkw1AhrhBojYF6mVQlyMM756E7ppRhXmHRpylO7r?=
 =?us-ascii?Q?11i2XYcpYDroMHT/eaiDYOzlffWlpuaVZtaHv2okjqkSGfMpzPdKnPr/Dtfm?=
 =?us-ascii?Q?dzIF5xkMyF5SGq3cCnLYIdVe5yuH1Fc/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 16:02:06.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afc1dcb-8da2-4a1a-87eb-08dcb6311eb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

From: Edward Cree <ecree.xilinx@gmail.com>

Both ethtool_ops.rxfh_max_context_id and the default value used when
 it's not specified are supposed to be exclusive maxima (the former
 is documented as such; the latter, U32_MAX, cannot be used as an ID
 since it equals ETH_RXFH_CONTEXT_ALLOC), but xa_alloc() expects an
 inclusive maximum.
Subtract one from 'limit' to produce an inclusive maximum, and pass
 that to xa_alloc().  Special-case limit==0 to avoid overflow.

Fixes: 6603754cd914 ("net: ethtool: let the core choose RSS context IDs")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/ioctl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 8ca13208d240..de34ea9b9665 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1453,8 +1453,13 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			u32 ctx_id;
 
 			/* driver uses new API, core allocates ID */
-			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
-				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
+			if (limit)
+				ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id,
+					       ctx, XA_LIMIT(1, limit - 1),
+					       GFP_KERNEL_ACCOUNT);
+			else
+				/* match xa_alloc's 'no free entries' result */
+				ret = -EBUSY;
 			if (ret < 0) {
 				kfree(ctx);
 				goto out;

