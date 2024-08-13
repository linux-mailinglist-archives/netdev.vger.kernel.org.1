Return-Path: <netdev+bounces-118247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FCF9510B9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75555B20C8B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BB1AD3EA;
	Tue, 13 Aug 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dR9s9OGk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086C1AC438
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592502; cv=fail; b=nznOB18ChS6DmevFS0TETj67DK4RYSkwn8x7l1yEjPGcxrDVlpJ+q4MUKnbXc1GvUimg2gw7oeP8u95EvDFN2/xZlst6+87zNSNS/pUKVCSgatuLXAoStNRIEx3yv8ALGD/ZaCCfXOXL95Abb/P1ZPWisk+QPgMZxFIDGl4bAlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592502; c=relaxed/simple;
	bh=hX7kIkMYAx/2zXqJI/Lw+hSbaA3mnjn/O5t3rXuJGVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cqw71DXKhxrGm/IGVQVoWKbCIdOZ63CWc3lBSlY9DfMkcI91My2TEMR/s0xk+ppQrm4K5uFVlwda/FNNQIW7P6klXFKGg6lg+1xGNp18Hp3ukIcfGbunQHpEpe8pWvvP4aa5AXEmYelmFTPH6I4bk3CyVNPodBD4wpjCQlK0rBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dR9s9OGk; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2mJkOrC92T0WibmfcwOmf2jXdyxqbGjtQavhpmdmIdZzxwPGj2Yhy+EmrStBibXsE2K+tzAfF2QkiwTZAr4CMsDtN557T/5l/Jc4yen+UNOPfsse5o6cihAXGdTFamYDj8HrfGkkiVvGsEW9p3HK/GtU/tsQPCZk1RKuaLzNn0N/QP+3Uvi85Qr7UMaNBL1i01mr6Z/wtvjLgZqFnBw8pbY05hvCquV0NjUCqkthjrNSzI9fTuTqUphKvTojCgySmi8iqje/8WfJFwVLBHowOSbBaSSdgEUrXSElpISShaLLX3OTbMqhdCIdLzE628cvvnm58G4wG/YU+JrUgIvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClGvt041ENhONi06yMcn0660VZE1DTjmriS2Ziwy4r8=;
 b=fdUxDEJRQzz4cNHCQIPd6mNh83aseIZfInJ1lUaNmva6rRrwuQ5gSnSRdJKNXjCm/btnvz9xlUdUF6RqnUwwQCayxesklyNNVq5TP0POCSyzw6zVJC8I/c78p4NlTBvoG9cW8vaPydx720h5kIolJFj/hutN7n4MndE6zhvY2trYrKVruBQ26/6Enle/5CAw+p5ik/HudE+bEPOW+j8GvF+7/JmTwrCibqaEF1hAG4WPuki2MmJdfKBfb+hzuN2fx8JQYetEJK5Owq8pOe4PQDmWDywVnfNQipb2OEo47NPgqlw+v4OZWt1RG9OM5MvP6sct8qb+CblaM8IeAmt3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClGvt041ENhONi06yMcn0660VZE1DTjmriS2Ziwy4r8=;
 b=dR9s9OGkRR/Lw29/RntLe9P8z/b4DUjlOW19Kh6YAV3HWFukchihG9pASH1PHW2iiXWoHfRTaRO2Oa9dBxsknytpuRQvaex0vE/j+FSz2hUitJP0eD8rkq319eDkn96L6FRgSOnn6XI3hMMaUQZkQ4UJCKdrl5+8RWWti3PV3qk=
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 23:41:38 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::5d) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17 via Frontend
 Transport; Tue, 13 Aug 2024 23:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 23:41:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 18:41:35 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 1/2] ionic: Fix napi case where budget == 0
Date: Tue, 13 Aug 2024 16:41:21 -0700
Message-ID: <20240813234122.53083-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240813234122.53083-1-brett.creeley@amd.com>
References: <20240813234122.53083-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba1de87-4308-4551-7de0-08dcbbf1798b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+BWfz1VHVuiwBgotTHWK2llPZrivQMqZe5joDOekSCpo5Iw0ZxJZA++GR4Pv?=
 =?us-ascii?Q?hCClQw3mHwmP0olJSqRmQ8LUtuW2I5EOnurkW7ATxh0+bGqahShWKQ4CSaE7?=
 =?us-ascii?Q?PiKWLAfqEPQMc4hQlW5wnYtD9VMYI/yz4pnbu6WFv3Yb77M/I2IYiTkeChk4?=
 =?us-ascii?Q?2kM0bkg0Xqry/xfQ5M6vmnvwa/a2s+XnCbJ+Qmtpg392LmDxAU/W+XJsAEno?=
 =?us-ascii?Q?543JGfKkoSM+GX1miaxPc7GMFiyUwbXAv1XVW+hVOttsjg+UTp78dIbfbxyN?=
 =?us-ascii?Q?LNnkqfJoUAF2ILEMv+zMqMr8zRJlq7kHe0NXMNvNDskozDpcIdDntHIiM/u8?=
 =?us-ascii?Q?wihLZH7SolPICISD4ZT0A3dfv+pYuqiEZr1WNwirDZYfYjy6DBMfF5FhEQsv?=
 =?us-ascii?Q?EIeUrDGTm64/Ov57ICci2gaGMP04Og0G+NHOOGEBmZV1DezTPl2ygDm8MClV?=
 =?us-ascii?Q?Y8BoqPWnsTRHg8MYmBAsCurYhsHBC0CSez+tKotsEnIU/Aakk66k6h+7zRsk?=
 =?us-ascii?Q?jjUXHjEyHEYoMalbFylJX4ER6pztgpp8Cdee2nwxJ1fCesuhl7he9Bul/jhs?=
 =?us-ascii?Q?h8d9seqkOjKOi6vSumfBsm2tczKBxA5GbgqPJdAhDrQKDM/YIfTvLkJk3Q+r?=
 =?us-ascii?Q?Zjl1ybKqMIwZDfcITqPY3a+XkZDvKihIa/RJcLTspNBjgKPydGR9ge7VCXyP?=
 =?us-ascii?Q?4YD9u3Tgx5azSYIaws9YPxT7jVBb4Q8T02Wt1x2OWhzivsDq09gmW4vVuSsZ?=
 =?us-ascii?Q?9l+v4WSGkhjfDtxd4a7qlxy23C1GYjhtoN0/XYkhbHk551GRtWxMiS+11+tS?=
 =?us-ascii?Q?GUCHJQ3tpEOdBdXi7Lz/WL8LKGUXFTXBjXU6FbGiNNOCFLnrQmi0GTLMLmEU?=
 =?us-ascii?Q?avtiJywDaZOWof0CnyIcPfgs/wPRHHbrXuNiMwAUlRR0RYgVZCwwz92d77iw?=
 =?us-ascii?Q?9h8Dyv8K/PdKkJrJGiGPodwtDntG6kuDImky2sg8lvYIQE/vZrncJ8D93mmo?=
 =?us-ascii?Q?m+iXWf2F9PSoJbd/G+CXkar3fougZi/JMowNO8bgPimaLN0n5etkjDi6Jezh?=
 =?us-ascii?Q?MKYPoJo63rKQSRGXshD9TRBzkkB3eAovM4jWHqrBenMGZiq49JmLHPH1AozL?=
 =?us-ascii?Q?wC9mLsJ87tUQk4WsZwWtzWYPs9qvgft3/rHqTV4A0gpBCDrnJrTO1gq4nSIz?=
 =?us-ascii?Q?D215gn/7ixlDTAb5cg3GUmFsOhsPvRm+zuaK7ek0OUbUNFYuuKu3wwyTMBfs?=
 =?us-ascii?Q?auxUSDgnLeX55kEnOf5h9yBNzUY98SyS525FxtnV0L2JtsQFOI0/XyJCWc5b?=
 =?us-ascii?Q?60rk7xPnMlnzaYUKQug7Bj/IQAn38xZmxh8v3wm/xObZ+IdW59N5bXsajSlI?=
 =?us-ascii?Q?UsUObVjUGTGxX2hfz+W/PWwr7SAfnHEa2cp7QVqR4ovXv0r1kYL1yVMnBc20?=
 =?us-ascii?Q?QCA8V6gHBoAv+lVcGlL4wyrz+d1l+vSL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 23:41:37.9058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba1de87-4308-4551-7de0-08dcbbf1798b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

The change in the fixes allowed the ionic_tx_cq_service() function
to be called when budget == 0, but no packet completions will
actually be serviced since it returns immediately when budget is
passed in as 0. Fix this by not checking budget before entering
the completion servicing while loop. This will allow a single
cq entry to be processed since ++work_done will always be greater
than work_to_do.

With this change a simple netconsole test as described in
Documentation/networking/netconsole.txt works as expected.

Fixes: 2f74258d997c ("ionic: minimal work with 0 budget")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index fc79baad4561..8557d672d269 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1261,9 +1261,6 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq,
 	unsigned int bytes = 0;
 	unsigned int pkts = 0;
 
-	if (work_to_do == 0)
-		return 0;
-
 	while (ionic_tx_service(cq, &pkts, &bytes, in_napi)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
-- 
2.17.1


