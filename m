Return-Path: <netdev+bounces-181450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A5A85087
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D3B468292
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1254C92;
	Fri, 11 Apr 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5FnVkZU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FE1096F;
	Fri, 11 Apr 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331553; cv=fail; b=o4wsJbjsckVqzVWx2dUvL4crt7VltazaKmFEfUS08hykVkNQ3aD3WFZ7tlURtlN7wlU5XtNGgYH8YC9BNbwCDUJe2jWIbyHAcC+Xclm93yM7AMxW7QbLHvo2gq16yHVnwpI+ZasD8pKgLXjs6oNQBqBJbA4IcB+oFwLZhMubBCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331553; c=relaxed/simple;
	bh=7a4q9aoG02tcYOdJzOH31Eyho3q7/1kQKBhQ5nCq+5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X59C+A34WN/09Mpfzv4kaZNJex2fG+nu9ZOZAViImaG1+URsTyJJUJM6z8iElrmR5bMW1dVDWrS/nvFobXCnjIiOJt5TGx2/K+0HP7JNklmBKMxiJg0XM45d8j8VtmhbQv+JnBHGPhc2adfKndJzsgjfG4mIhAFSgJqDTgUTogc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5FnVkZU; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFJppV8L761QygL+O9OffkUtMRiIqvXNFuH2Qg+QRWrapt1CnoGbI8ZCshBTlmLogrV1KTesKWFm7wCl2o+8A11gyOqEHefdUZzclrwpxkW2TU43yHLHcEkHwMcM9JeIEZmx2QZA9hxw80T66uvnKIPiVMdUl6eGymR2Tq2dGFVzHWA57UFMo9ElTCF0gAXzRaYVVIHcJEBF4fbuZfod0a98CFv4Mvug+F3YW5io8z3pDE0QAhhkmBR24K+tkjkn7ildPmzSfIWhRc0LRVlFo+HMy5M+JuZjxSc+54RLhrLuVAV0IqxYR+cff9VZEFX0PNhcQ8o0bTtal9aCnHOR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TXsAd13hLIZ6YS2WG9fsyHYLvqNMVXH2dtCkuSMPO8=;
 b=O9jMW5dB4t8huDz9BO2BakKZvNrXeKnPf296I01l9usPSmzKjEZ759O2aGCohpaRuy+su03It0AeZaVpbTRe1f/Rmg824ISEQeT9tB3PwzTMSkVmMdDq4UrlOblj5PFZ8LI/nUE9nAi8S4Mr3Tixad6iOg4zCQXEe3TljZw6h7Ec6HmRN+UvvOXBqRPte42p5YF+WbSfAlgRLY9W+Q+awfTAXxA4NR91xwDnSjn+iUgbNmaUUFj4jhKoeSGf4uoKFw1qBggMUcw/Amm/sg2JBwOxGO1FNUK5jwCGSW0Gx8R2ZrfBwRpWgBnX/GiBy+I50wR2NFpy/CxuUMQEtSoQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TXsAd13hLIZ6YS2WG9fsyHYLvqNMVXH2dtCkuSMPO8=;
 b=d5FnVkZUDpO9tVnySU26K9qTjopPcnw8a/0rEqrZjieh3EHROdgLo5WiVLbbS/pEkZyFeli1FFNZ1i4gpPDEsPLbZhP8EeruZlKCbxj4rW62yKO+WdBXXj93w71kQkPj88AWpsTqIgwLR/0K/eRsQHia0QofsBwqYXlxAh6v3xk=
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 00:32:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::f3) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 00:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 00:32:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:27 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 0/5] pds_core: updates and fixes
Date: Thu, 10 Apr 2025 17:32:04 -0700
Message-ID: <20250411003209.44053-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8131f99a-b955-40e8-b80d-08dd789056da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbeNETqQezuRZmBd+XJ0D0B3VFy09dQtotww+AOQmR7LwbNOLmuEGi6nAk3i?=
 =?us-ascii?Q?CFqUavGACsmlGuEukJlF+JAfba1+09N1qaGgRZcVwUUZx5ax4draGxm6Ac+G?=
 =?us-ascii?Q?Ahuvy9ADiMy856OJ3y+5GOnKzuroAhe1g57crhCG4mnFYdpjLelydI4adHCG?=
 =?us-ascii?Q?tn4U04wCMtLbfW+phycJnd3dn3LNJE8PvMPVFmFXfZWY01+atVXw30uRMgoq?=
 =?us-ascii?Q?N5NyUIdfKCZGT6sEDnTt0lTqq1bmhyIZmmNyy7o72D5Iw2QFwgmPH+UzzRLl?=
 =?us-ascii?Q?y+IlwzXkGwUHpyVCv57av1P1VaT5d6yrthNl0dKFe0FQZapK4wb4DQsexwyq?=
 =?us-ascii?Q?DVH5DecKjHt3ghmnj7+3ehKNaWy5sKsbx4GR8tq38zuLNuk6+5n4s5ptVX5B?=
 =?us-ascii?Q?nUnO1sboDW3Ew8ep6p7UX8gATTukem+7lcUVM9vZ3LV0GKH+s42gsWXCn7Nw?=
 =?us-ascii?Q?Y9edrf4zr8YYcdIw1Ew64RaFFdURE++99/JO8ZbmywLU+7vQgb7di/Nqzzyq?=
 =?us-ascii?Q?lbQqMSBT2KoyKhwIPlbTlNF4dtkSFUBpCJWIwxy6Sm61O/wtNLqNlQ5PueCp?=
 =?us-ascii?Q?WACfSXvHTBt2umNUIkPER5SM7owGCjPDu6bhBxIvRhDYamLBG4VLT6vAbjQi?=
 =?us-ascii?Q?A9pKMqQtkU8etIZeAvD09cUIdGwmxdN2rpmjWwNY3mKzs767OIHaKuFKb82O?=
 =?us-ascii?Q?jdHfN3GeLNzJUKYO0QkmlAvQEcPHtsShz9zOiClKWYy8P4JzjQGVKsf6paTc?=
 =?us-ascii?Q?q0u3YyVG8NYthbELJ6KbVVzOg+qpM9Ej7EovJV8Y/PVqudKVo8UghpZGdA++?=
 =?us-ascii?Q?w9e+PEez7NRZNuthpJUGqjM+eVddqgLyYyINc1esJhB8iAamb42JrJNLVbVG?=
 =?us-ascii?Q?7AakcyufKNWZiuQ6QiPTJXuDHxuem3NocxtXFswjhSApsuwgqLj4KzyCObfd?=
 =?us-ascii?Q?dxKKXchlejllwctpMvaez/IZ/O66PwU2Cpf2fWk2uhvogeNfcAJ+io4WD/yT?=
 =?us-ascii?Q?ozzv+w9mV4tYWyWKDKCbhTfUAjU4dpEef0ask/qNqhKtjfK/CLcmOnTD7Cno?=
 =?us-ascii?Q?i1sgOwwTdVQxdpOocAPqDFv/EQLNC5jeq6C0q7ZaucUONczp5NE+9klLtsJf?=
 =?us-ascii?Q?avYgDgWoG97G/B+dUc0bIX8jdUjgIXeOyhzZvdyiqMYa4yJIKlq21T7SCX6T?=
 =?us-ascii?Q?WKnESf6ZuBQPM/xOksVbV9FaHCLHaeJcOUA4v5C6aKPhF3r0hBes3NyWD+PU?=
 =?us-ascii?Q?d52Wwl8aFHSdS/n71JBr52yfBW0JdOAeqH/sgSCIQK7JvP9tospimdLIR9/b?=
 =?us-ascii?Q?mYGoDN6RjeNDAro/9DwjA95TEaDDArS/2YcluHb5k+RZTkmzAEcO50D7+ABY?=
 =?us-ascii?Q?7vuPKfWC3TPPJ3EtOB+6Icks3B3m5EqRtbi/8bjhhWi+zy3FIKNyuYBU8gAz?=
 =?us-ascii?Q?0q1MVgtQSo1HP7QZvMhrIIEDeBmXFfM93wcGApO/hjDs6q3z+MvTgDGXCNpO?=
 =?us-ascii?Q?tDnfpNY/j6YE/btHz2c4IH9WaV4xPWmAW80W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:28.3495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8131f99a-b955-40e8-b80d-08dd789056da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

This patchset has fixes for issues seen in recent internal testing
of error conditions and stress handling.

Note that the first patch in this series is a leftover from an
earlier patchset that was abandoned:
Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/

v2:
 - dropped patch 5/6 "adminq poll interval", will send for net-next later
 - updated commit comments and tags

v1:
https://lore.kernel.org/netdev/20250407225113.51850-1-shannon.nelson@amd.com/

Brett Creeley (3):
  pds_core: Prevent possible adminq overflow/stuck condition
  pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
  pds_core: Remove unnecessary check in pds_client_adminq_cmd()

Shannon Nelson (2):
  pds_core: remove extra name description
  pds_core: make wait_context part of q_info

 drivers/net/ethernet/amd/pds_core/adminq.c  | 23 +++++++--------------
 drivers/net/ethernet/amd/pds_core/auxbus.c  |  3 ---
 drivers/net/ethernet/amd/pds_core/core.c    |  5 +----
 drivers/net/ethernet/amd/pds_core/core.h    |  9 ++++++--
 drivers/net/ethernet/amd/pds_core/devlink.c |  4 +---
 include/linux/pds/pds_adminq.h              |  1 -
 6 files changed, 16 insertions(+), 29 deletions(-)

-- 
2.17.1


