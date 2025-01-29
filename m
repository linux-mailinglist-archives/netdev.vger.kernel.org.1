Return-Path: <netdev+bounces-161431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5EA215B6
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A167A1B87
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 00:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD0516631C;
	Wed, 29 Jan 2025 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXFDzpJ1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839B176AC8
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111441; cv=fail; b=HrtjKpHz6rsBJZov2MpNkMYabbJuIFRKj/+Nv3+s4pKjM4OsnmkWQhsnpT9UMzyk8KGxn+uAaVP1i2IUo6g3Bi1PV+On2XICz1XeQQJMyzczG3qXI0j/onuMinfnEKKbvIVm1ZeBFi7ytiETlxOV+0sh+iAu5NsMIUPkchcL5f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111441; c=relaxed/simple;
	bh=LIvh6gdZXNzsxa0HgNcE7AFx4+JRvLNRfJHNGCRMm0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XFnWbw6fOatG169Q8qbTDvMCJ8eXLcTQJ9J21c9R74AHKb+GazD2KBiTcOMnGIJvzjLJmoBvXFMKkl8/tepCBgdc3O0OSnfcP/yRYNIh9iWgmsLNIBBRslO/UK0DRK2zayZvmXk/WhogrNfo/3c+O0xsj6hOIY7nHx7m5StMUxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXFDzpJ1; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twd6q5TKd1xoZZV3Jpnk6D1Zbabd4UDY7cxhr3gX5kz7+TtnpXIXlKRe7HiTuNcyKFTjtrEFKeFeYF8tvo6WEk2/X1ru792M/oaZlwR+/VIRt+zmcNTHzE/nQfexF2Dd4mDn6M3NqVIdDC7Ze0vg06Ph7ihfYWoaiaHk3wDn6kLH7AFw/eQ0tzVES1lBwpIcOy5Y7mBKoMr1YdsOLEZdmN3nN808wBu4UP8dKswXkUtH2MRYdS39x2O67Zj/+tTllDVJChocROlHp7AkVmk7Nku+GlMU7l72OVteanSlM1tTXV+hmlkj7ajYtqaJpssIWA1/xgz4kXwNrIjlaFJGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdLkb3ow0Jtk7KryxLsrlQcMMjkyR7NLh58zl5mcSo0=;
 b=OloFGBjB9knPe3d9nCpXj3172UM63bxR9gh/xs9rjBGBiL4DxCmHprCayZ6H/h9i3x4PJALVaP4XqfKUL1u1ZkvQ7ZWA8POyEDZjxqbl34jPtRfHH7v75XeCAVSQvVrlA758VahXsEn/UBkXJ8b6KBRUJPZkY1PswFH35UbUHmIjKRLlcV0Se0SfDlUIm27+9UQJCT7mke9swNfIgYEEp0VEj6dYFNjE2jujtjVEq/t0bPee8QzVQ86T3HEpm+QyKx22zeGg79BERp9DrHrFGct3cnlPIWWq0YLrT6QATxzfLoUGr/S/QZrsn9swNKiWLxGu3euC/2592OxctbvEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdLkb3ow0Jtk7KryxLsrlQcMMjkyR7NLh58zl5mcSo0=;
 b=SXFDzpJ13O+g1GCH7Ep7MGkJqXjzCUvW8lJhEVEWMHfnhEhNUdA5N73z+NMM7hs1aLFGML40piivjwd8QWLcrNFJ0yUhAk+C9dTSPqUoa4dpyRKoBZAO4pOCRVMg3y3ZplNymGas7ILKJsL2blW9E/IOnTwdXzd0hMUkeGkLRSk=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 00:43:56 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::a2) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Wed,
 29 Jan 2025 00:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 00:43:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 18:43:53 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 0/2] pds_core: fixes for adminq overflow
Date: Tue, 28 Jan 2025 16:43:35 -0800
Message-ID: <20250129004337.36898-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc28ba1-be3a-4126-538b-08dd3ffe028a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBP83XwhzseiLpaQE1n14827fzj0e99hUpzse/YIoxuIIYLSUtmQ7ArvCICY?=
 =?us-ascii?Q?qQT7rVh8qs+GIFiO8lrFWn+VFaU9ZlM+eR51LhCgbi/GJQS0n02ZXIRQ+inl?=
 =?us-ascii?Q?zmFaFuMwQiLXmLkbvqa0XXDH6cusf9rdOQwDUxJ3miHRdfGOv1+kWNwNLI5m?=
 =?us-ascii?Q?jynev3IalEaWA2Zr8Mr37ZKXmla5K6/qKMPID3WnqA7+jR17puK75/MDGVsc?=
 =?us-ascii?Q?TRoDrsUQgqolt66irHUaaqapX2TywpJinVZAAlnPFMJlB/H/31LiZUReGYfT?=
 =?us-ascii?Q?laTtUriaxc+XLCYPWsiUnS6JjvvzRgO2k6IMCGc4xSeM07Pi+QulSvWEVwAN?=
 =?us-ascii?Q?GU1e0s4c+AucqKu6jSDVlzUneHoVubMNZ0jX7oLawTuF0EJ3cmEyNX06HJYT?=
 =?us-ascii?Q?Q1fZ4oI2ZmwiUd5DFc0u4+s8KkO3RVfvOZNpbEy84swiL5UkqdQX6RLv/4jA?=
 =?us-ascii?Q?tsGT296xaJ6gNGdolwvJhFkk0fFTWLxQDKqEl/u+WYq0Z4P3ElQmKZCnO2R5?=
 =?us-ascii?Q?gGLXq3ZhI9onZcx0cWYnElVufK6h327Wp348leU0PJvetGg24nq9QLeQHqg5?=
 =?us-ascii?Q?OI8ekIrZoIJWRyaA2gbr1dMZ8dF+5lV2QmzsufkM2PtsMN/E82Z9mlqh1Q/T?=
 =?us-ascii?Q?B8Nq12T30XJ0LxZjJITr4hEbZrrPqDIdrgcx5QJ7imMlWCjmUZkoLHPo/bY6?=
 =?us-ascii?Q?afAb2hWd60zYEgHsmirHEiIiVxbdceYpJm57fuKNmtAImD+qaDco/nQf+X0j?=
 =?us-ascii?Q?HsW7rlHrdo3ak8mAN+srKZzs9d15vHtLN5V97+1iuCN95FS7tUdgiVox7gPb?=
 =?us-ascii?Q?Qf2Vf0bqwWQ2TxA82Nnc3SFrefLfNPMkfqqjVx1i6iygU5ceS9jMBZ1T78Tn?=
 =?us-ascii?Q?yzRQwgqSPWMkZSg4MiBTCVJF43PPPo24oN7lkYQWoPbmJthzbD/cVRkTEgek?=
 =?us-ascii?Q?Iw6rEi8lIrMG0O+HO0oHRuKw/Vn7mLHFsW29lWxMIr2TyMeEAHhQtbBTvIux?=
 =?us-ascii?Q?OYOqZJNqW3Vggg8twPHL1Pw5Ecr0nl7JlKb80mDO4E98NkjC3aCp2NbPQXdh?=
 =?us-ascii?Q?We9Vf3ouQqFnULfNWu332BkOWcGjwU/5NAgYfXbugkzKvmCTyzQgZa+EQJ8m?=
 =?us-ascii?Q?/grQ6IEg2B1+H0xM9+mRAeb4DfuyCrnX4UXj+s/I57UyBaoaS5QEUThiuZon?=
 =?us-ascii?Q?j/oA+CYBG8TUQipT9shuIv1fmMAZRTCEoeoFPD5Ni+XVXSDOLwZM8w7O4Z9v?=
 =?us-ascii?Q?4aIxMkdy6zhvULFhtLZtQx1fsEHYBmn5Ty6ZnSYVaB0zYN8XnthnAIJBaJSA?=
 =?us-ascii?Q?+4YDbzJR4huKRLpBaWXtkwaa4LSeYdqVH0qsdIp+KiA0i/Cn2bQZMVSUqsTd?=
 =?us-ascii?Q?dDBjV3G9HBObqzGO+VFpDPx/1ggsWnRx3Hz6beUgZvlC4i8hwq4MFxtTfYf1?=
 =?us-ascii?Q?l0XQ4Qhht4Is2edf+yZNDNFCZavW43cwle2kyyvB46Z38S4KF0q8jiYN7yKW?=
 =?us-ascii?Q?voQtzqS++aod5vo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 00:43:55.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc28ba1-be3a-4126-538b-08dd3ffe028a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

With recent stress testing we found we could break things by
running a large number of VF client requests at the same time.
Brett takes care of this with a couple of fixes to our adminq
handling to add a tighter limit and a retry mechanism.

Brett Creeley (2):
  pds_core: Prevent possible adminq overflow/stuck condition
  pds_core: Add a retry mechanism when the adminq is full

 drivers/net/ethernet/amd/pds_core/adminq.c | 22 ++++++++++++++++++----
 drivers/net/ethernet/amd/pds_core/core.c   |  5 +----
 drivers/net/ethernet/amd/pds_core/core.h   |  2 +-
 include/linux/pds/pds_core_if.h            |  2 +-
 4 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.17.1


