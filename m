Return-Path: <netdev+bounces-150801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C99EB95A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028D5188A32E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68334207E18;
	Tue, 10 Dec 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dBuUHiWa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9D154C15
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855474; cv=fail; b=df2e79Pw7SMN69ObUwhNWT0ga0eyoJh6ZYGMaaTJZIyOvg6M5w7p23UjT1PcIWK5R0DldhFf4gwVlAG2JxXJPeGZECyQOyjCE0eMV2GuF1mRDcteo01z/oGBJZfldB8+q7Le/ZiZ1bigoXcM++pf7h6N7QOXYfpZUBuxq7SCGu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855474; c=relaxed/simple;
	bh=YokaQ8eN0GSdDUXdCcHahvZM8Wo0H22kuYCnofSqnWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJEpFtXSoPS4XSYO2tZ1tRbuM+3gzxZN31HUKGPv/d03JAENS4blbRJfKmOIzAHf8pO9bhPnbBQk2iyR7NS/J59C2iq0gLI0zjvafKx1oWmgkKrwDQqQtqle5l1Fl7ReOWUc5RDDXelvIKvDcAFhy2xusySIYq6DYiE6wL1HbN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dBuUHiWa; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2F1K7ZPrWGt5cPOCTUaZwq4oguRNO+8pCKh/zfl0qyAHKi+h7O+COdV3Z9jIzIjpIGLeC4aZn8zLpsYEjOf+0pHgfCC3HS5cd4rrzBvCp8k5KGrp+FbGxn+6cHHu0roFjidK7bhp9J179mxHwlJO6NiFXMYJtd6rMLpntJH3h+yd+JaTzqqbz7K/1I1kUmWYgjSZAgez1YNbzTta1OqKkPbKFwSukf22SBUCjEW9+y7aVIv4TNCfHZEhQT3O7WrcjCBcyNaXQn2YzwgytuHN80Fr1VcUi9D6DF/O7MfvdyyiFe4NFXZ5eGZfibIhvOeCNPXNPwhI4gr7CpX5E6JCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEmpJvTh4Oo32A4OKtngJjs1ckU20Gm39iITIh+myNM=;
 b=nWNolyBryrYtWkhCGtAzDEXdk0qN96McVHPQSwQRRu+BZa/7f1zpUJejh/pz3CmZ82WAVBOqBjsV55DXo8ku5T7qljPeF/TaNgktzzjUso41wrKv7qTK3GTobswnsdjK7ciMjQNlZKzHilpl397eQRPjQ7HKceHO4SNyY94S2It5Gtsr6vV9EfKpecw9gPDEL765ir8+gh/oitl1FqgzwsiZMyyM+tbNBz+7tCmDdsPP+BsrVraxqRqEI9LrLIdP6d0lz1HkqhLFRseKo1IXstDLRnK5OXWs5Ojgcbkx+TfoFTbDBthTRjiuGUdoVPSXaJHRhN4AB3yzgGzLvomMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEmpJvTh4Oo32A4OKtngJjs1ckU20Gm39iITIh+myNM=;
 b=dBuUHiWa6Y+qO4oKsHzADoT02py3HcuhEoq7bESpnPbKd1Z0ug+vxcbYO5NS/BB5iavvLGppe+ZQqydljONC9KPPvJipUVQdodMzEVoa18W1xqddl/QU+HjxGzzE352Zd7+z7Vmn/maBR5tIW6FuePSZKerZJaAp1VCSEpdlFSQ=
Received: from DM6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:5:bc::30) by
 IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 18:31:05 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::9b) by DM6PR13CA0017.outlook.office365.com
 (2603:10b6:5:bc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.13 via Frontend Transport; Tue,
 10 Dec 2024 18:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:31:04 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:02 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/5] ionic: Translate IONIC_RC_ENOSUPP to EOPNOTSUPP
Date: Tue, 10 Dec 2024 10:30:43 -0800
Message-ID: <20241210183045.67878-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210183045.67878-1-shannon.nelson@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4a3d59-5efc-46a7-e74d-08dd1948ce7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xfGOqBJpX8Lt4JDTnn3bmLG8S3sCKEcsjD83mm4Cq3nnaT++RBSH9Mm3CAp?=
 =?us-ascii?Q?XvZa78B0CO7duqqZgSY7wZL9CBiRan2B4xtIpdQ5MGFaDUTMPVwIfz61KtmQ?=
 =?us-ascii?Q?RcHQ1sjSSRB/3150HCowcqC3C3gwCE0sUBRrqaHpJ+nGHCAbC7lhYNwfauUA?=
 =?us-ascii?Q?upGT1gzoHs0TgDK+PASc2hzQiG2s0yQ0GZJWqKvjaq10AhXi7zeGWQ+pQj4r?=
 =?us-ascii?Q?RmuP0sIB3plg/DFCk9KKqpkEJPnZ/Oc+GC+LL+ibEUqJyAsO18W8XnEJR78t?=
 =?us-ascii?Q?DpoM9WTp3/2gliL1lLyWNSVzZtQRU6aH/Y+jH5pBflqavqGuF1ZTqukOaN2l?=
 =?us-ascii?Q?al5qXuERKdKEpwsdPE5e8woiRjCV4z+O1b335q1jN8alN0jgvs03JjJ9JJIY?=
 =?us-ascii?Q?JqcQaYnKXsfGdkZKNsF9gTRhGITkbJKV2q0HpcIB3h30yeAA4XONq9KnCuK6?=
 =?us-ascii?Q?nvg2GWE5Ub17imm72zsIe0BXpe8BCsPcIVwmv97tr+20oOBloWpcjFNo/tBT?=
 =?us-ascii?Q?cU6Z6hg2+Y7WVePXoLtRQRSnDyD5qX0iOF33uS5hmaSfXwootGV/dV+n871o?=
 =?us-ascii?Q?rZxu4m3VlzYArTuk5Riuz/Wp2V/OOlB+9OkWTjV+FV2WJI2krPUJr9cLbhyE?=
 =?us-ascii?Q?koEi0mdx5RGEG9KKGlmFmQQFvhq3CMsZ19Pgwj59dc4pSfoWXvARhOFDkMdG?=
 =?us-ascii?Q?KwH4PzNJxjTGZU6m8Ac6xcHrWBeJtRWBXqfGD4E/Nl1OiyRhDyyj3Vx5QFw/?=
 =?us-ascii?Q?drXtJN115SJl0S/T6+2dDQyl+bawWgmM3yi3uSdOhlZVW0aO7EOnTNiSsh8j?=
 =?us-ascii?Q?rdhWArsp4qy1ZMgpF6/BCoMVg8kkZQUtlSX6Zkx2IWxg14HfrifMqEoNFQtW?=
 =?us-ascii?Q?muhHGM0RgCClMs3zp40XHGHgDL5jE8CeDoE2peA7d1C7mU9dqd4m0YuqGoR3?=
 =?us-ascii?Q?mJtQ1oyXzW0H9DGzTnKBgzVDsDDzWIkac4/yDmjVtTOCroChBjCVAUfATT3g?=
 =?us-ascii?Q?8sT8genKKmm67jES0CecGhQGqIDWv04uaKg7udqDGRy21d8C7fUdjZ9/YmB/?=
 =?us-ascii?Q?MmErWhpXUNJ3SQecLMEgRJ/pH2PfHvJohwQ96z1uMweKZRr+u+81/Fp9Oflc?=
 =?us-ascii?Q?0Ize0e4Z5SpAIxxSrOCHQh4x3kPNP8px9y6NzExrk0dEv3TX6swAvqS4zmfy?=
 =?us-ascii?Q?nvgAbi+ppWVgGr4tXnX0fDBfl9jr/9e91GTgoVEef/Bm87W+/Qt3+9v5tN81?=
 =?us-ascii?Q?7AZdPaXMziC4gQB6d8nbPs/49saEtKYLDn/yPGYWhQ/flqVurJd3gtAgXWXe?=
 =?us-ascii?Q?rRyyiucUABtjvjg45C/pGf11yU3VCvbTqa46Xq0qHoWiXempQtxT0aXri6eX?=
 =?us-ascii?Q?ruC6rnt2NIfeLUuZF58srGTZuZAk3QUbKnBk+8LuhZlDgynS4BjeONXm/5vu?=
 =?us-ascii?Q?lGviwcJGdAK0gegjO4N4yfrKwQiBVm0k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:04.7951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4a3d59-5efc-46a7-e74d-08dd1948ce7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468

From: Brett Creeley <brett.creeley@amd.com>

Instead of reporting -EINVAL when IONIC_RC_ENOSUPP is returned use
the -EOPNOTSUPP value. This aligns better since the FW only returns
IONIC_RC_ENOSUPP when operations aren't supported not when invalid
values are used.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 0f817c3f92d8..daf1e82cb76b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -81,8 +81,9 @@ static int ionic_error_to_errno(enum ionic_status_code code)
 	case IONIC_RC_EQTYPE:
 	case IONIC_RC_EQID:
 	case IONIC_RC_EINVAL:
-	case IONIC_RC_ENOSUPP:
 		return -EINVAL;
+	case IONIC_RC_ENOSUPP:
+		return -EOPNOTSUPP;
 	case IONIC_RC_EPERM:
 		return -EPERM;
 	case IONIC_RC_ENOENT:
-- 
2.17.1


