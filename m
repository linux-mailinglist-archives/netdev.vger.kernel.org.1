Return-Path: <netdev+bounces-213283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AEB24629
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B031AA4C2C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144EA212545;
	Wed, 13 Aug 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gyvn4o/4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BA212542
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078358; cv=fail; b=EZH9zj+4HAjA2Pj9gSILO09qi/sbIoBndQ2zdbz8wvkGpsLknuBrczxSlTDX1Hk6ybXeSm4nZbFsmclCXj74rzAMs4GdsUqZlH0i3OXJmrD/jRT9xSPnqbrpgde208isgdaswvB5XXLZon488PervMqDpUWUpQYplpVbtKyIAFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078358; c=relaxed/simple;
	bh=vpXlsYh2dMG6nttrTxFspwKUBhKUqTVtDuoYlW47wRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O0VBwi0RHPajU/MgB0HsaaMIQg6bMlo76wTn/1dkNCklzcLUfgGQWik5EShRtMKGgSU/nQ6BDw8tjQvIAmyO2QMIWMYcDilamTG8OURvTnMXOmKeFgNzgyFCxaa12We/vjCCf3nqzaYqJCbYODsk22Fw/8UKV0bqhHt8BLThdag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gyvn4o/4; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niIywRJClvO6PmB8FpITlZr4EV+D3QwJ/CkuA4KAAXWzZGo10hZPG4Hjc6rM5yb4dYCJmJoDehnkqBJpjDyAVq0Ih2VD22y6ugnkXg2Ey2TA9ioAsQrMj6lnfsxNbZ4uGnnB59V9uFhP6YCox+REUoktm60bMXI239EeKjHXKnUuB0EH+mmo0fuXuXud8mFegT22W72wNDtTBICWgYJlLftuzUhmph2r1Edlza7pPg1tdJeFTlxnoZKEV1HIp9yN482VRw1zjxXdCl43Vw9zvo/8y2bDaMj+Kf3PNAd+4HQk4kHsI8sewQyiydb1BPU3f6NKFB/adyRPc+0GPw6Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zGbH5u6xWkk2bb2ucJ1+ntfF3JShSvb+CqSMow9ofQ=;
 b=fUNDLAcy4kbB0LxJn9r4GV/AG/AXqX0hfEQ9VWaBpLS2RaDG5PQc1ECue4NceVac3utvmESLCO+gCMkyKnUEnB5xLyBRoS6Bdj7Wuf9p5e96uUJHH8MxGK5DIwCKCBIG1tGNwoui7FcI9m23Fdk+uWhlKj4aVDMbVcQ5QIxkF+Xj5bvwgpxyeudrOUIyZkrutgwrqBDLNOwmu5ikUZoKib4NOpkDfsYk4OmItQk+NhBsaR5/0LPMcRQhgWoTU2qh533fwKi0XBrENiqvZu60JpK4WmPP+l0zH8ttVX8/3lXWWm9mE9wXwpX9ov5Jh3Vb8Fh0T94T5hZwM88rBXxTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zGbH5u6xWkk2bb2ucJ1+ntfF3JShSvb+CqSMow9ofQ=;
 b=gyvn4o/4hREzTbM8a3V+lNlRNWhOyFu3yJkykyAk42SNciXVn6wcXf/5nx1wADjqzi4IlbCSK4TDGPtQcLBS1BfY0/0PFkFm+7fu6zY3PivmR7+qAvYX2UA2kHanW7iN4TFP7rTEfNDuxGP1ecJjfnF2DQOHS8TKPEdabwK+le0Mj6n86/zUiJrNkMc/4G8mlM7fSjFxDQxMnV3zlA8FfXf+BkiJaO5OzwHCqgZwdKL5bRzylb7PnsxPqezakYnZYvN6v/JxL0Po47zwID5I3y5vReCcSBbvSCqKd9xBUX8h21PaNzf6QSdqFsKT5eNf2wnFogZ/OnPu96AqAQlKoA==
Received: from BN9PR03CA0113.namprd03.prod.outlook.com (2603:10b6:408:fd::28)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 13 Aug
 2025 09:45:53 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::ba) by BN9PR03CA0113.outlook.office365.com
 (2603:10b6:408:fd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Wed,
 13 Aug 2025 09:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 09:45:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 02:45:34 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 02:45:33 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next v2 0/2] devlink port attr cleanup
Date: Wed, 13 Aug 2025 12:44:15 +0300
Message-ID: <20250813094417.7269-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: fed26bcb-121f-447f-0d6c-08ddda4e3162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zYeF6mbMpiv6zJa4x6Ti4+TMAXbaFHLkYCA3CQ2tz5SyifarSX/VxIDYPvLO?=
 =?us-ascii?Q?QrqGP8ktzvgMksiwbVS1x+5VGbOz4sffV/Fx7g8qIJKtzhxxebKmfU9cw+oB?=
 =?us-ascii?Q?AwEdinP7ImZyklKNoUMLmByIya6RYz6PWCBfarwnU/E8K47jJIgl99yln0k6?=
 =?us-ascii?Q?A7e1pJQXFIzpe/cRuMt6XsIbpFyMzrwOr9vcojnZxRm5qCmMvCZxWIRrJzL9?=
 =?us-ascii?Q?aPEqAbRxLK+Sa424w9Ijqq9YNmSXEpOyFYmPdUYFaddIcpjDqtKdlMlCm91C?=
 =?us-ascii?Q?KAurpO11s8ekLtSvgoczjnzBXOhKeHxAiEyrj/jCJRQ+Qf642tquTWou9VIf?=
 =?us-ascii?Q?cVB8oQOp5JHaERHzMiZvNM43q7D3Qa3DPEdy2hJ6AKkWVc2D/ltQnqBNihSx?=
 =?us-ascii?Q?48VGVWWeiu5IzUHHlcBhJEyZdM7tf3bfCpKzlpsdJj+L2Bn1Ayju/RMiS9hp?=
 =?us-ascii?Q?EYGfNPl3vzPXfx5Ft5fUMOAKYiqPDp7lx2duuWWAxcHLC1e8Tw+eSpfygWRL?=
 =?us-ascii?Q?8tgbKn20hUn6xKEdawe48C9f6Z7YCAestbnMmM9j42X51hVyA7SF3R7LKr6q?=
 =?us-ascii?Q?kDMQV38Iar2TOez5TgZtMaDnAnDsrK5cU7rS/plk0sDb2i08Qe3ScQXZyTrn?=
 =?us-ascii?Q?o3cLWcOeGLCJBDghCiPKu5nck96vDJFwlP/hrti1mvm55CDoUbcGAUqsEq7B?=
 =?us-ascii?Q?5xgb4GE0XiLDQU4lCdCc9aRbWk3qMPWe37Hm7FCteaJ9O7ev721nSnfusbPn?=
 =?us-ascii?Q?oo3ukIhXnrSJHzb7kMeUUY2J/SCiHDWe2nJtWv/2yGRAwKk2Wdh061ZEftGW?=
 =?us-ascii?Q?0mWfGTlpIkBZ+TuuqUWvxZCO+I+Sl1Jf1lzgVTYY4jBl6lAM1NnB+4+6/l1F?=
 =?us-ascii?Q?4ffQlsC/fMRRdGSiL+3FMqKwB/AFSKhNZKnN2AL9cGpZ5SjTYIMr82UaWtZR?=
 =?us-ascii?Q?cX2IrL15W3zi41r5WIq6NeVlR5lMJvQVMP2u1T2biLFmCKFT4ACQ9r5rvID9?=
 =?us-ascii?Q?WykZ3ZUS0bx9KZgupgUqi2yU0DlVyS71WknnIZiNTWnBcSEzBgaFZYpWqLsb?=
 =?us-ascii?Q?ThAjzrqu+QctA2OO1LTYbNxNH8zewM1WMGA2lpS3rv/2vaQ2nRvoAZO9K2yb?=
 =?us-ascii?Q?/zL4FU5ac3GC0lguEp7CgjudA7VztbNvXY4FwSa6q/YZqIeIoVTA5TrlAokm?=
 =?us-ascii?Q?B67pwd0dwNCBLI3UkepFr+npm44G57tk19/d1pjvwqXVDrkZb0OT5VxYTQe0?=
 =?us-ascii?Q?GZPpeFTGnhQDxq835Pm65j6qTFOO6ZRCwVqSVG3kxZYOUn6CJokXermzAcPx?=
 =?us-ascii?Q?ctsy+qqoxElPxlVexjmwXw1UIh3ZGNA9x5iTDsQBGYy/GcI0l3Gcdp1v6sNk?=
 =?us-ascii?Q?QpTVRRvmtX/rgi8WmoRDht1jHEu9VhqoXe1F/MNFhgyhON5pny/lA1TvLJdT?=
 =?us-ascii?Q?cZ44OHbU7QKN59yV9+aJG84oCOZvtyvJIAAll0Tdg6sgIW5pKFFR6+FCS24h?=
 =?us-ascii?Q?/M6e66zF0hu/xy7QH6oITFQEKby0qnvysTOa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:45:52.5419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed26bcb-121f-447f-0d6c-08ddda4e3162
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959

Hi,

This two small patches simplifies the devlink port attributes set
functions.

Summary:
patch-1 removes the return 0 check at several places and simplfies
patch-2 constifies the attributes and moves the checks early
caller

Please review.

changelog:
v1->v2:
- Addressed comments from Jakub and Vadim
- changed patch order
- replaced dl_port_attrs to attrs that matches implementation API
  declaration

Parav Pandit (2):
  devlink/port: Simplify return checks
  devlink/port: Check attributes early and constify

 include/net/devlink.h |  2 +-
 net/devlink/port.c    | 33 ++++++++-------------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

-- 
2.26.2


