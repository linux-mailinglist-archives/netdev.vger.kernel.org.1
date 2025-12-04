Return-Path: <netdev+bounces-243660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D855ECA4D72
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 19:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2311C307C525
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900529AB15;
	Thu,  4 Dec 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmijJPig"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D92ED844
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870743; cv=fail; b=F/3h+P4aA5AyMWw5j+VX9hvkyE9eCnhTeUFS1/t2oSv1/IidU/zC6KplUQDrrzGaftQKS0bKXNm6YXvHJ+pgLyvDKsvknP7OlZWXMBthmyxwtWuVEnAtYUaA+1oenHbhL/lrcaZS4U4s+/Pdm7Fy8eaKTxu2MxUf+JUQWwNEnJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870743; c=relaxed/simple;
	bh=01RO8/k/FF1TMmEpD/y8xdmS2ExJgOpPG/pjvKIsafU=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pxx1gQ85ixOaLHl2EaOCVWvS4iJkysLzWKDZjCUZQYci03nG0Fm4k92O858x3Mp2YMV2HwRFAuLfL9F9yOqZBBTkR8sKA+KXrBzn3Tpj/U+vQs8vd6SpKHvjJnpwHNoHeO6O/YvUm0ISsv6pp+X61M01xzlBP83cwhNMIFXHSEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmijJPig; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTxnCZ0iebGCA+0m2bmdm+ACk4IkBJFMA9l1Njl9+6yLJrOi+zTi+TWVT9Jd4OP3HXR9+f3Lb0HSkLFQUhfWVcot+9+F0p5aZCYQtS9C8zCIFppm+PlaV3uc9ogEVdm80wCl7pp9jOlt8L1vQHZE4Cm8pyERh20EbgKjKyRlmBkDnDwiC46rehuAoEdM85XX72SEKCPyGWC+4LXDW0ayfnx87F5bF5gQqD8N2rZimBZuQbPMRLkQyl2Vv+Oy4Xvd8sBICy42n3DJN9R0q/vPnjCFTTHgTRiqwcdKmSZoFuRvY712FcxugD9fdPWtjiPU/O/RbWXcXDxlCiSv9UgboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czg0hbfJaOJNEbMbEMsDzgA4jV6zJZD2v3bcwaNvei0=;
 b=kKH/pH/Calkgx1z5bBS/nvaYJff2zDzzaEH8+gfs86DNTUYRCbUv9BGDbf5QM9ix2fXf23RCc5/CDONuTudgEMI1vQtTJadVm9M526FNv2ThSWMEMLcwn6YnHQN4DcpbYknMIfhVDgr58/6K9A0Sazkig+OtZ27xJyqZPX0KxZsXtBz94y3va+cdtGwqdsf4zpggfZ/ozzK0ZG6c383m1unEFYXSjuqfozk+wGdXtr9UV7i3yWgFqDEH/YBRBISpc0818Go4DQsqJG/eKL4dOC1ejjO2Z0zxVVgtvaRrgyVVv8GqkkqPk0zaAgYSXFUNt8qiHxn/z/2a0/Es4gHGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czg0hbfJaOJNEbMbEMsDzgA4jV6zJZD2v3bcwaNvei0=;
 b=jmijJPigc+c5W2v1girp/+NrOK6qrEbS+atAqylqofRbbB1AQX+85SWYGIAJmNvfOiYFYLF0FbnN1qJPK2nSYk9lFRax2bkHKuAKmEpi7jFQKdN78mB+1h5cfvF6kfTnJZomlQ1Dzqp4tTgsfrINN2jTYd9KD7sCs8yqAEwxhYsQ/uOKGLtuZ35aULmCJ5viXVeNX0ZtZoxDFPfSfJrheqdtueuwzXQTsK9JSZ/ZGvOScxlu8xQ6JWTZ1o5jPVB0pmVDJALzPyFH4T8v4N/zl1nO1rttJ+rEsCSQcDRZaGhGBAfKXDEKHr0GZHz2PIfdqriar3juDKR3n4nzQfPmyA==
Received: from MN2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:208:23e::22)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:52:16 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::41) by MN2PR14CA0017.outlook.office365.com
 (2603:10b6:208:23e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 17:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 17:52:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:51:54 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:51:52 -0800
References: <20251203095055.3718f079@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>
Subject: Re: [TEST] vxlan brige test flakiness
Date: Thu, 4 Dec 2025 18:46:30 +0100
In-Reply-To: <20251203095055.3718f079@kernel.org>
Message-ID: <87bjkexhhr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 0930897d-3dd3-4fa0-ae76-08de335ddcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zK1u652qk8FO6enVJ6a/ex7b/myvJaEmZKdjoa00Uv3xYzLxwOMXKglSy550?=
 =?us-ascii?Q?lNXekQtvAkJfYGyELlRVRusy2iEmmIItGRxffAiwQL2s6xuK4KbQMyutbo00?=
 =?us-ascii?Q?HGHr43H28AJf39HSed8c+11j2fspLpHPDhtdn0j8BKSlsZ7s66aBf/GHoccU?=
 =?us-ascii?Q?37Uyhe5SdV4m19HXZSqQ8shYYtOyPFcwdl0f5B3FWzxo2482b545/eCGH66t?=
 =?us-ascii?Q?9lzI+uiaCi6LC/UF7AwSQkUPc6uvUlesXLBjflGcu12mngwRpfLVAKfJWLJo?=
 =?us-ascii?Q?Zmds4qNTBiYab6rmWkAwsyB1fnH55nTNR0ZQxH2BMF2GTHLvBJhvxOJaV+/P?=
 =?us-ascii?Q?ihCgZo7vQh0BG4LpxEmlxDCeyUv+m6tqMHV4pMVB+LZdG3JXOEvZgouKq5jT?=
 =?us-ascii?Q?rvvpQ3h9W5tVYw2kN+DQBoMAuvK6+VVs/wlAz4k9G3CTR6Fg2H7J5MOd0dzx?=
 =?us-ascii?Q?e3bsHkv3mQwh0xSbEyUshVDLoQ9ZUXp21UolebKu01YjpGuwZr60pBZWPuuy?=
 =?us-ascii?Q?qR8NnpZrinIPnENDKnarS2AlD40e7sZNJsOO0jI9kkWQfdQFIvtHh4+FAjR2?=
 =?us-ascii?Q?QIazGxD9tgUVR6UtOgpvS9VtDJFshRIv59K7881HwM4aN6jnbFIRyq2ci8dF?=
 =?us-ascii?Q?74zklrd82Fv0SrSPVvKPaTXIeHwLpwaXYBhN4qEwLEt+37pWxXJ5m6q1C32t?=
 =?us-ascii?Q?xdEXVEzozjNnGWGcTtr9ESfxX9j25DDMwKyWhhlGlHVT0I4GGfporQkgs8QG?=
 =?us-ascii?Q?nQlL/RHwsnF5Hy29Pq91hClHI8Nz2ovSMXoaoPS9CpBe9pwo1wztC50w2Cmb?=
 =?us-ascii?Q?ezwpGaNJ7aiwT30Wvlo475S94iYnumws5XRCrZus3bMGJlKWz5SkYXmtX+Te?=
 =?us-ascii?Q?F3oBtZS5xNsOUvzjGodt0Brx1xWjC17mrTwF2OUt6w9P+n3db87+m1FHrLD7?=
 =?us-ascii?Q?jy2fpyS1Qlbj3vw2luOaa7d4pUmjhlm0+GJTLsSxCaWwK4y8yKkMCZzY+sve?=
 =?us-ascii?Q?ra3J4L3LqYfikkusBtjWBqyZbo3/0GjpQcYe2jvQPI3QMjtnvIv3ga6XR9fC?=
 =?us-ascii?Q?KOzDu5GcUMY6Bqc62KfWnXl2AnmGCzWGAV/ahBsSq6PtmoLCCwAfmSLO+g75?=
 =?us-ascii?Q?OYnBqFj4GIJ++oYrNunOZay6AXeT8trUlT6nupmEKxDIv+2RDtAwazLBSgjs?=
 =?us-ascii?Q?0WMNtojApt2WfP/TQdY4nxA5NdWgOLpCj8lMrcYJzOI1sBGXcqBdho5pqHi3?=
 =?us-ascii?Q?sQeaB2jwL0d0mC9mH3eRpSdAz9pC/zj1lgxBDcE4wRwu6iyWbPL+V8X7SGdQ?=
 =?us-ascii?Q?Hfcv7SCWVaqQAgKG5c6ExxNA+ihvJnrEYktE3ZFJKCFVwtmgH+8UiigckgoD?=
 =?us-ascii?Q?tGC1iGxDgFX2Th5RPHQYddY6NMPp9ZZIKQ7ntD0crT0py2wGpFbKzxYGX7Yb?=
 =?us-ascii?Q?111fOx7k8V4S9+9lUDkZpZ8ldCT2v6+P+Q6kfF1Finx2FWzumDba5uZqs8Cd?=
 =?us-ascii?Q?/Z3gsT0CI5pW+WGx7t4NXqcocSy0zb0i+1nchNbG5VOADCdZ7v7KiOISVE8u?=
 =?us-ascii?Q?egUYctLYr+Je138tNfk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:52:16.3055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0930897d-3dd3-4fa0-ae76-08de335ddcf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431


Jakub Kicinski <kuba@kernel.org> writes:

> Hi!
>
> We're seeing a few more flakes on vxlan-bridge-1q-mc-ul-sh and
> vxlan-bridge-1q-mc-ul-sh in the new setup than we used to (tho
> the former was always relatively flaky).

You listed the same test twice, so that's the one that I'm looking into now.

> # 141.78 [+13.13] TEST: VXLAN MC flood IPv6 mcroute changelink                        [FAIL]
> # 141.78 [+0.00] Expected 10 packets on H2, got 11

I can probably reproduce the same by removing the vx_wait() sleep.

> # 141.83 [+0.04] smcroutectl: mroute: deleting route from lo10 (192.0.2.33/32,233.252.0.1/32)
>
> https://netdev.bots.linux.dev/contest.html?pass=0&executor=vmksft-forwarding&test=vxlan-bridge-1q-mc-ul-sh&pw-n=0
>
> Perhaps we should make the filter more specific to the test traffic?

Yeah, we match on just the VXLAN packets themselves, not the payload,
because matching on the encap packet is a bit annoying. Then it gets
confused by some ndisc garbage in the overlay. We can match on the
inside using u32, but it needs tweaks in a couple places. I should be
able to send a fix tomorrow.

> LMK if you need access to the system.

