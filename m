Return-Path: <netdev+bounces-66248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12883E211
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26B91C21E3F
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C221370;
	Fri, 26 Jan 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfSuuldz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F786224C2
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295548; cv=fail; b=Md3wk+gamRLmuw/wtUGHS+u54wx9atBCal+duveIU8HqV7TwHhpcgpFPRP5n/LAhagUoOp48pcz0aLeQ8UqjZH92LzHa3rQ2OpCVnUCLHCo74+gUw5C3alxcw7/CNxIxkE3OmEV3JaXbJ9FOmUnHHWS7nLR85CupsZAAc/H+Crg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295548; c=relaxed/simple;
	bh=ppR3HRUznf3gqzgZBOZdtXQ218M+Curd0Kqj0RcuMj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNo3NuHtgwkOG+8Uo0zm/eOT6T45k3jA+NClYV8cuamfui11HEEdUDge6yaVXNoMaDuzcDO2N7js6eT9T2pQsO9l+2pZlc0VIqFJGVO+AksXke/O2iF7Jr1CLWmQ3eZSD7w0R48RP7dFVyCFwR9ewYBpz1ZRk6m/XMDsfHU3Gk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfSuuldz; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9mmSAPTdwftMcv9xvR+qfUYeXYE9Ap2CN8nRjefsuzlKuDH35oZ7OIXxGGFLy4DrYFOa+d6dsRXe9KOIrtNIm0rotoCRBDc5URnX4CWMDzaHZGsP1+I0Jf0b0+adFSgaL6GU6/EZ2+Xp8wlK4JMSqDASuHu6a5ZcfF3nV0wckLSB0nyOFM/tDnhKuZIvX4V4na6Xy9soE8MXzG2Ic0m6XATOQ4XRqGg79Z2RbxMGJNSrEf7s6TL+tvPlmx+Cqx5AJB0hqJXEQ5gtuiMn5WVqvI5erD4daWMlfQZ2Q0Ak5nWydyIdCJi7lrdkIvPuV3j9unIfZ8BJQfgrGkS6+wHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu24xIh5HWed7guhU9jCUU2W+Zv7rJLPbafntToO9eY=;
 b=CkSLBBKUY58EAuvrlcomejAWPphc40cgp0RCDc9iBctud6RjKc4kvB6hnZsfA+QyMSCmUXMukdBQUlGCtRuXprqAs2C0mWwSn90lbo4+48LtmZ10sfTnF/tBLKjb78qCQOOwYPoLq1rWlFptuhD0MT3rcREJyLbpsuGRMkYdOYXGoWb1H2lUwcGr2e9l3mn9Nkp9NuzRMIWMSHT+S7S7sbiCN3xDqDp63ppDyVKDdf33/RyzY0utDDyzVM7eoUgM4gkeHsZRC7WqtOSfw+eF25bV020c+3Z8bpSPxAH98odblocWJMczHoeTWMj4gUhbQBjOGk0P1wy3ry4bvOxm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu24xIh5HWed7guhU9jCUU2W+Zv7rJLPbafntToO9eY=;
 b=XfSuuldzaWsE2lDCz7LXYI5h/JkRaQyJOgouVVRHuQDJdgPL9u9HaMeW30hFtsohpIrU03+Ru6t92DiUQixTQ0tLl4eUgRSJPzCR6k17wqnf8PlCZWLcQLZUtteTKWAJ21doW2SFNjtQZtF7tEkhduJ/DEQWPZAAcUHrVXgQrIO/xID8pcybivhk0hqOVnzVfgTgbk9M2KaOMOsVhCqiuuBJLfZAwV/mnW3uFpBp7F2K4hlkHh+SJV0mUPmqGUbkvDUjz2d/wGvv/tSDNDQCA/p5vKwilm62FwPxY1yRZZ8lT+YC3hs+gF58ty56HT0H+mvF3/Wy5pOkUAc9WTT5cQ==
Received: from BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 18:59:04 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9) by BL1PR13CA0418.outlook.office365.com
 (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.14 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:47 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:45 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/6] mlxsw: Refactor reference counting code
Date: Fri, 26 Jan 2024 19:58:25 +0100
Message-ID: <cover.1706293430.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: c68e83a0-fe13-455d-14c1-08dc1ea0dd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PKN0rAU5YjSxbQ5s4i4yk7T2dH/TShB2HeqDTvwurVUdkz7UEBUR32OKJLAKJreifXgF7ZCJZkjhqL/kt1WnCxEMvX+d4DFSK/RTjWjWmEc08zyAgXks+O1knLzQ0MkflNK3gbDy6s0u5F21QsoRNaKQB2zOhrok7ww3mVYD3aMVmXmGWI0vAX+k4rdoNdXQFiCueYJ9GwQEyWCLVWJzlq02aJYB6MWZqLBntKXMZkqvY2quf8uuGAghtmN16IqnER6yjES5cH/iUXJgXYKXlJIzel8QsXheeqsBsYHgSlIX+OUPYFfqRVpkmS49Ka4KUBC5ly6eE+oaE4B8eHl9FEmxdVTZd+d+C6n+yZlV+wZuKGDU8BbISmeP8dI0C2aoE/VKC3cUMHNqGELUrcYPxN/CIwbzIQTlEy9uWSqvrYj3U+uXQh5dA5auPbxykBtNKgEtBSyVEUKec7JQpNOnh+pAdwVLULjEQEXvNt+lKmAYle6rGn5A+ss29MGnPkDfDOQ2uoKNaz4SOrI6aRDiWf2xNkfe8S8suG+wfJfeJufhgPf0ucGhB03BqqgJG5Ry1mfLdjNX4LhhdYBL3DWsUYHZ1B5np0NECKlNL30/OZqYmcOv755hmRNpIuNNuXWX04/gMW6U0CVJBRihg4rC+zTu98h+9IgLyXlKFHmXSXfj6y+udzOoMJnYNh+es1kyEmSzcvIVlf7OJgZOvjYVmhdO5DazIEw6RmZaQ/KozIFTBRLDJabej4a3EIFB6sSO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(41300700001)(83380400001)(40460700003)(86362001)(26005)(356005)(36756003)(82740400003)(36860700001)(7636003)(16526019)(2616005)(107886003)(47076005)(336012)(66574015)(426003)(70206006)(316002)(110136005)(70586007)(478600001)(6666004)(54906003)(4326008)(8936002)(2906002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:03.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68e83a0-fe13-455d-14c1-08dc1ea0dd6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

Amit Cohen writes:

This set converts all reference counters defined as 'unsigned int' to
refcount_t type. The reference counting of LAGs can be simplified, so first
refactor the related code and then change the type of the reference
counter.

Patch set overview:
Patches #1-#4 are preparations for LAG refactor
Patch #5 refactors LAG code and change the type of reference counter
Patch #6 converts the remaining reference counters in mlxsw driver

Amit Cohen (6):
  mlxsw: spectrum: Change mlxsw_sp_upper to LAG structure
  mlxsw: spectrum: Remove mlxsw_sp_lag_get()
  mlxsw: spectrum: Query max_lag once
  mlxsw: spectrum: Search for free LAD ID once
  mlxsw: spectrum: Refactor LAG create and destroy code
  mlxsw: Use refcount_t for reference counting

 .../mellanox/mlxsw/core_acl_flex_actions.c    |  16 +-
 .../mellanox/mlxsw/core_acl_flex_keys.c       |   9 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 164 ++++++++++--------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  15 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    |  11 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |  17 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  15 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |   8 +-
 8 files changed, 132 insertions(+), 123 deletions(-)

-- 
2.43.0


