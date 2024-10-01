Return-Path: <netdev+bounces-130864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1098BC66
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D236D2869E7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD21C2DB9;
	Tue,  1 Oct 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4JjN1Su"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC91C2453;
	Tue,  1 Oct 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786561; cv=fail; b=H40qqYOXza09g5rVPu8Q0thzVyBjhqyJ+PDN6XeZV/nWGtFKsDatd27Pj7V+fiR2q/P9zc59UufKudueg9fdpKIbUb1BzsfIVe8EkFgAV6joiv3l3m0+6H96dxcIky+Rfkf6HXmSPXYRDixjNUpAO7cIk4a55sIR2YSBmkYwchE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786561; c=relaxed/simple;
	bh=WG/cD69xDEYOTlmz1eijmmYamlDQUkZ3ijRb7Zjbw00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnbpFdsJtefUoXbz/NnkklqWT9/MISdbdw+1Ua8r+ve0xzTjlKYA48lYP4FqPTJI5MmR1dszJseb+1LAWrUH0FUfV1iGLJ7H3jnYgBAEgLrICcJMN5GoN8kbSltFM9yOkMhL82ccYOnX4xlqhAuk0pbAYZ7khuWGSmrNHOQfBp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P4JjN1Su; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3CG0eCizVmg+JT6GGnp0e4IbUpSTc3VO/6z4e1/OJ2njcoXnp4oLTofg/9RRJL+C85m59dP8Vq9+YcVVvPb9mh7ylO9sHwF976TrwqKTh2t0s27fcxhfM7rp8F2dVZf70xQiiDYfgdhHmM0STr4eHDzJwSwhNemBtX227o5KeSl9ugaxC7juPCRlxIb3I2GdWVuOgCUpGFt5FZsloO/KnDqscaWbNYaR2DjhXhiNRvm5R52AnnRXOjFPhSjt6xuPu1JhzX4CS0WaIwiQAzu4CjF5BfjHZdys39ywxBSF0UltAaZeGnFj/wGH5X7ezQWWpPswqRTv/qjQ0RwYjZ0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+bQ3i6TvED5KXHUQncJTh0l2Z9Xo2hueobuM9r1QlU=;
 b=QpkEi9O2WoaeHquOzwuOytJmD2ROWbhHKUJ1YIRl4mJ52mK5uGtEGZtw0/4ah5mlMYVB/CuyItxp4T3D1uQk85sCUkH65jTMuOA7FgvHNJDDhiQ1PEosv+gUDnfL6B17dhKXPJo5E66YBaA40ppkyeAU21U4IL5KMqQxG1+qeK5uJ0SvM5/jUa0lhJGAYeM2nxVHfJdiuLSPVuZmLsCLp4OvtapxuCJWUhbyfMgd+8cwPdCQb8g1QUiqlW7/9U/38B2KU5JYHJUfh1tnS9+j/EJDjOU3Ev75dhkhVPSiuDo4T+fEL07x9JqPSv+APyBChd6ob3WDAwW/HR/W4i9IGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+bQ3i6TvED5KXHUQncJTh0l2Z9Xo2hueobuM9r1QlU=;
 b=P4JjN1SuRbWRzgs7Jgasd22Pmv0QGP1KkSw3hWdqCX2Npur4y7aJ8dj51Gp3Be5QtdpEGGqk2Q5IgR8cCIZ4fw/b4u19ow+uURgpW+uQBn7tgf5rF2OumIlz50do6Pk6FjWInpaaLPxevTHt9DG5VpI/wILg21p4gPmrP+8NEALfNSaotiUFVKl/sYNe9beczyLVPOWtgdYxpEx+A948OfHv0szz6oFDP47KdFrO+b57rIoSsYleaBKIbY3vR5WrA5ZqdUKQ+0uL7h8k7ZOu90NVVPYoS2YPkyQOGYiUkp8hdoc6mDgZZooenp+E//M+Wj1qyvvlcKfMSC5E+VUBIw==
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 12:42:35 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::64) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 12:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 12:42:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 05:42:09 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 05:42:06 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <petrm@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v4 0/2] ethtool: Add support for writing firmware
Date: Tue, 1 Oct 2024 15:41:48 +0300
Message-ID: <20241001124150.1637835-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c42f431-b2a8-456b-bebd-08dce216865e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjvaC0rOt0D/A0prsOAUf6bgOC8JSAuZnC7uJRNLacXo9ddZf2VLunF7zY3O?=
 =?us-ascii?Q?OfbPtseSRtMlwBB3k3MfzbSyf9HlpbCojW0gj3JXbmJuE27Fd4aj4OH90qJs?=
 =?us-ascii?Q?q+JN3h539cABnc6SY6QvUrkm0OV3M+DcNS1lgezb2RtIUbE058L8DWO9yPpP?=
 =?us-ascii?Q?k1y+KxgZOCAI5EXCPsthvgDlq931nfMl3l59O5KIHvSoT2Ibz8XOf8SqsKSO?=
 =?us-ascii?Q?xlW/c/lC6+nZ8EjnS6ar0+owbP+wuajUwvmUvGoYz1tviHinMgECJFDO3qiy?=
 =?us-ascii?Q?7VhnHE8lRRyzHtz763MLdK1qcTqeF1ZOVodkkh3oVcQl/hjxTuvHJnn+FM5W?=
 =?us-ascii?Q?eph5pB7X1EixwOwVQrzXwuT8KivKoa+WMELTuqLTwUfjeSDOGkcCSWeE2j3B?=
 =?us-ascii?Q?GXbLW3hceMhn8iQ4N+humDgRxezK/msmaWd0/99QauzExNTiU2WwHjszuX/q?=
 =?us-ascii?Q?AXB4nrysWARTAmq46wPHeWZYRXI5b8ij4qMzE2HNUULNdfCs6sSotUkNQifO?=
 =?us-ascii?Q?pPEIjSK+xQPVFPSTPlk5pCTVkU6EZmmAZ0pJZDNABKfo0FFo09NpB6Fw+IgY?=
 =?us-ascii?Q?u1+NPODwlb+5AXfJrzQY53IW9A59z7Q9bxSiav1bk/G8huOKQxFqooTmjhSz?=
 =?us-ascii?Q?xG7+3l2TTJZvHFLtFXxUJA+wmEQF0791vSENsa9EKfXTHXJMBPagwu3Aj+eh?=
 =?us-ascii?Q?GwfUhue41mSnpUoWtLPzf2iyEEZe03hN/MwUMOaSOox/GM1tNPnL9/zJjv1M?=
 =?us-ascii?Q?Xt/ksP0UrPaWpZXnk7GtGibZsHKgYXYW8P+Rpyp+rw/x9S1gxA8gBwz3Yopm?=
 =?us-ascii?Q?by1IbTvWAn/3HJA85pG+LycBxsglZMTTvXRgMavX16HtLt0AkN2c6VTTkjoW?=
 =?us-ascii?Q?XM1b6W4/SLwr+DV3k02co8k1gjOa9g9mBrLyebSBtfchIM898rI//ZuCDUTi?=
 =?us-ascii?Q?U8sUnvGIgia/i9gCw4RGtJLqrYMZ6QfN3mJuB4UTgy327gNW592hRpTkSOJW?=
 =?us-ascii?Q?WtFAr/oUhRed/VWrh+tym1fAkEssDHuw6TLUU52KhxNP6xaJ8fu9IaGqjQvR?=
 =?us-ascii?Q?6iszSFjF+zYT8P71dNdR5HvSNvo79qfLf4e0Sb49ElBtB8CRs7Yx6vxM1Kdq?=
 =?us-ascii?Q?84lsmx7QVD9BQFhECxS0xVNmpe3ovbzfDnUZEq3DwzvVNXo+/HbckG71U4eM?=
 =?us-ascii?Q?gB3x5CWHWNi7ASA2PPaiE2sQuCGn1FYesbAnO9EsIuvChxGGJ7EkFqBbVMNK?=
 =?us-ascii?Q?B8IEobDL/ruuAXhRKclmHGTrQR09z4P3FfEQTHMzVGioVhSqNRWMOBWjEhcJ?=
 =?us-ascii?Q?inqfkXkfK2ZGUa84AQ/VAozXhiFLCKbQdemnxh0I9Q/2UvPpAz0GrlRPLUGL?=
 =?us-ascii?Q?8eIlHYikjfBU3EZ85xDSCJ7midaSm+CMM1UcvbwLBS67sbuGCP1eX8cdRcez?=
 =?us-ascii?Q?10mAyGMs+bU1Gcxq9icUWtq5QKvOjugr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:42:34.8313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c42f431-b2a8-456b-bebd-08dce216865e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489

In the CMIS specification for pluggable modules, LPL (Local Payload) and
EPL (Extended Payload) are two types of data payloads used for managing
various functions and features of the module.

EPL payloads are used for more complex and extensive management functions
that require a larger amount of data, so writing firmware blocks using EPL
is much more efficient.

Currently, only LPL payload is supported for writing firmware blocks to
the module.

Add support for writing firmware block using EPL payload, both to support
modules that support only EPL write mechanism, and to optimize the flashing
process of modules that support LPL and EPL.

Running the flashing command on the same sample module using EPL vs. LPL
showed an improvement of 84%.

Patchset overview:
Patch #1: preparations
Patch #2: Add EPL support

v4: Resending the right version after wrong v3.

v2:
	* Fix the commit meassges to align the cover letter about the
	  right meaning of LPL and EPL.
	Patch #2:
	* Initialize the variable 'bytes_written' before the first
	  iteration.

Danielle Ratson (2):
  net: ethtool: Add new parameters and a function to support EPL
  net: ethtool: Add support for writing firmware blocks using EPL
    payload

 net/ethtool/cmis.h           |  16 ++++--
 net/ethtool/cmis_cdb.c       |  94 +++++++++++++++++++++++++-----
 net/ethtool/cmis_fw_update.c | 108 +++++++++++++++++++++++++++++------
 3 files changed, 184 insertions(+), 34 deletions(-)

-- 
2.45.0


