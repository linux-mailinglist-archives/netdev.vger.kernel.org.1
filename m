Return-Path: <netdev+bounces-186104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C80A9D32F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F1C9C32E6
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EC21D3ED;
	Fri, 25 Apr 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l0foYBRG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF11AC458;
	Fri, 25 Apr 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614005; cv=fail; b=avymmtLoRyAEm6r4DHnlODpV0RoASs0NMvWgVFEvpLsFYPacqYUy7oySIyZk8le2y8/l6bRu2akhMO2/Hv5PsnXYMAn6jNqrPA0oPjY3DrJic053xfL6aKvZeuiBH/wE7GjXN0vRQGA9I6rOJvnBfNPTDAojd9Fcmy7HEiM1CKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614005; c=relaxed/simple;
	bh=83gevV/zTht4rl6U5TGN+Po5mumDve0Ldp+XM0l1rCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iaN/7jMzYiHiZKqo3KzkraMsM60sKMXvS9BMrwG7fix91mqJW/Rb4lFj+saip72Mrq/ZnNAlgi0tvYfNGNshPIfbFz6c0gGSpK0WsMRfhgGnjASD/Qwlx5yO9WKTAtnlq8bwRAvJ2hxTsu4stt3OebpKZIH4eJVIaIz4YqITuVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l0foYBRG; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr/Dd4LKdAftV8iKdCZNJ2e4VxvUtISneVMqfDQe+HZ8Fu5K7aCQqL925rwjUHvAy3u3xcHX3Ma6K1Zwu+QGK//kTWnnpDRJWuhyTlaIVlvVgOE7gV+7jrYOm8YExIpXtcy+Bw9V0QwqfgthFs+YEimsHzuwvAIy2uMwOAwMSOrCH7k4BY+JabCrOB/Q9R9DzaH1YNLwbTTPESQXB6/5Juslc0U+Bhd6fRZ/71VPcMsXTo+ZTPGjjlz5is+TLSm37lsJO6Zx8AADVErDygFbkPcC3wQjjT/GLx1p419rcJAhVdGMOxXd806F3RA19rPGtO6Qf76KWWRWTZEPQc6mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J6Kl+2vdyF8sbKsPipF/racixEChEPAjHaRGJCUZJA=;
 b=Y1NUtpxu7OtJLLOGDdsIRrO10sX8GIfYTxug0ljBc22h0s84xMFwNds1fairKzaXB9n4TiyAaEJNX/7zg9R1Gd+vDgp5EfdMqfXeuOVzZTVDKVz2IaR7JdCku+mTWNZDUJE9xrzhp5ZKH6jDGjYH36WurK6SEnmVTFLbmA/Hnufe1Gn14zs7PWoHm6kAOlrbw8EJGLBrVggZ1SYBwz2Ek7P3KLgffIzQ7v9wfOjab2qO4iSevjY61W5yljR0oql7mAKEAvt/j92STDxfpPwWOcv7ilVvD49XMIGv9HXKyghI5TIbhKFUijoXMeDunmHNqmwD9/Fi5fomRG2sV6B25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J6Kl+2vdyF8sbKsPipF/racixEChEPAjHaRGJCUZJA=;
 b=l0foYBRGQ+xinzSjVgz4BcuVQmkZu8Tx308IH2iQkpUVsUcmLwFtj9fo8SQXCmAF5ytQy1b6H5LyoaNnd83gDIAycTrhJWkJvAPygtIcLjGf5IHvJScAjc0tbmN5O63BTWpnh+ZSZb7L9+BD6SkdlMxrnPaCcDIJfy1bX0VwLok=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 20:46:40 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::80) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Fri,
 25 Apr 2025 20:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 20:46:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:46:38 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/3] pds_core: small code updates
Date: Fri, 25 Apr 2025 13:46:15 -0700
Message-ID: <20250425204618.72783-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 941566fc-032b-46a7-af8e-08dd843a4787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5185s4s5kWHmPTQWAn3TvjhtFwZqDnnmbOfzFrWZ0Pm4DYsAOulyNNHJkKfI?=
 =?us-ascii?Q?sLbs3APseCGbNSdzkkF2f2JkuOFNsxtP8zdfmJXqe/IG3psaQZjiGXTk5zS+?=
 =?us-ascii?Q?m/R9wXclhkDF1Ymp7bMauP6KcmLeP3XigxIGtRjXear6LI+EckRnQMZysxyq?=
 =?us-ascii?Q?U5/qdtSKJjfRC+c1lBrUNKxhM9ZRkt6rBi9J28of99O2QEcbSGJSGCwGF0y0?=
 =?us-ascii?Q?fy2f4qa8uGuNtMep2oOVknJ7HKpzs+C4eqxuA6lpYVfmlrP+jnMd1l4HdhgX?=
 =?us-ascii?Q?9iuKjFclR7tQ+l5y6TRBg0vj9k8raLAlUc9MUmvmUCway8fkhg+7QxZ62JW2?=
 =?us-ascii?Q?CJpHNSDc0Myzefr6qvcTCCFOzh+9MyT4onLtaMyxjv5kQz0lIvWVQ1ey8d/0?=
 =?us-ascii?Q?0afQhN4aWlVhjlMDPK/svHFGQrHyuFTCclNdqXFeJJZAZDm4urhOpbwKBnNK?=
 =?us-ascii?Q?YkJrvgmWgsDKuLI6wEzTMnsSkpRV0cgA9D5IcvRozXKkccZGscjX8BxgNvWM?=
 =?us-ascii?Q?LwidTyGOAY3doP5/NtPweUvoHz+8InIf9CZ4GBOGsn7bF46+OfhqFOZe1pt0?=
 =?us-ascii?Q?/2cTt6UKlG+BG+HJ2f3U8d2vp++K0HAgX88W8PlJGjlN9HwMcJlEaHV2+4St?=
 =?us-ascii?Q?QVnX4Ysij5pS3G/iC+Zth9hb/AdML1B+MVi4rA9dHcIA8/Unil1fffW/k5ZE?=
 =?us-ascii?Q?Oid4gYM5S1DA1JA8ZcIe016hybT+MDL4x/uf+Tqe54UuDGPcZg6Ehx5Pl4Ui?=
 =?us-ascii?Q?VpV9OB1DO/hniiIJ4JqWePPMfKsBPhGRN0Blmk/Ik/qUt/DHvQUOeUsZ8JHk?=
 =?us-ascii?Q?/gq79nKYQG37oyZDQksXZbGZ7KJ4vlcbAw5gl3vDu8EM8iA/Z2LQepcZ1ui7?=
 =?us-ascii?Q?kqO34tjlIFafeXxyyKCRpCyslQ0n2/7RY6KiOMqyO+QOWp+MbmjpnzBcKfmW?=
 =?us-ascii?Q?uLo3ewsOomKarzlwnPZc/FfhgpFqoGUP1fAvLP2Igp21Y8yfjLQM/PPUA9xC?=
 =?us-ascii?Q?iv5jUEL/3IubEV+NzdW2raFFWo2gu1NOGsoygp3V6HViZLZT32UniEW7RJJk?=
 =?us-ascii?Q?b0rxvt7a9645ZuREjT8yKHkyL1bp/p7GCSA00ATkevaK016yG75RJzV+qtOO?=
 =?us-ascii?Q?1CkMKAqE0N7XM+ZJ/NX4x1Y5bzdAlL8t+vzuzjRAhQwjoDWlxQhpQqdFZn8i?=
 =?us-ascii?Q?5j1b8JbXTRGw4QpZMUEWQkZtYpYjpxoXKFYhWYdxRYpse2z9CQkEG059km9z?=
 =?us-ascii?Q?sKzbvjwEKVqQM8KVxfS8JzWSiYO4BvM4MT5lTxauTLcvr3kMLYoZXd7QTEZE?=
 =?us-ascii?Q?vedouBoTBW4w3ZExvXkBJdyAVXErZZt/9Yh0mcchgs+JeYlEQ/kl2wUxeC7w?=
 =?us-ascii?Q?Ea70vE4a5PjIv01WHAm81fhiWgNSFOU2vO3BcPvvIP/jbaG6R6IVQBYX82K7?=
 =?us-ascii?Q?o4Z0lbqk7E6cSkkYzPqIsjrOCJVCxjI3N8YgGSCV8YALzzUxF1BLNAR5+Imc?=
 =?us-ascii?Q?CU0k4WDMItyMI3WuLr+ig5GPoQXBgvxfTMre?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:46:39.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941566fc-032b-46a7-af8e-08dd843a4787
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

These are a few little code touch ups for a kdoc complaint,
quicker error detection, and a cleaner initialization.

Shannon Nelson (3):
  pds_core: remove extra name description
  pds_core: smaller adminq poll starting interval
  pds_core: init viftype default in declaration

 drivers/net/ethernet/amd/pds_core/adminq.c | 4 ++--
 drivers/net/ethernet/amd/pds_core/core.c   | 4 +---
 include/linux/pds/pds_adminq.h             | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.1


