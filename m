Return-Path: <netdev+bounces-115668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62499476E3
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C457281087
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79EF14A634;
	Mon,  5 Aug 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4iKi1uw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A681143C4B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845214; cv=fail; b=F3A1xrzWKZ65tRKN/Tr8EYRpOXJmDy4ACMCx2Y6jmOQkkaL0r1K6Og6HJFkK9N/mbv2c/87qIDfetZrB0hJe62TGvAZvyYuB/0Ml8WghD+xxKZgUggFcQWcBJQ32bP06AEU3AP0Ju3+w6vVHk7+aVTvYm31r0hYF9qh/Lxm+aT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845214; c=relaxed/simple;
	bh=BgM809vKgIxKeybE04zU8tRE8gkplUZNYkgRiBCnLPY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bJDe4tVNOFIrWkAT/Poik8qvN2gUorUoFMrzBJ3gHy8lyDztymFjXr7X7+2b+Glr1dUAKJt7433KWrQZOvSw4ITU7knqjCD6s/V3ezP1vGVUNeLRDKNp7gFKjosRzarUeytXXGSnQcvdj39kdPed6GPeFN+/PsJ8sMwSa8IFwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4iKi1uw; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEMbKMjJysrakoXkbzjTnABsgQX8zpeFxSR7PQ/c/GsUlEnu7l6gwbQZb7azbDkU0hpDr/2lG5jfNmck4fJ0YOLOxJ69a02eZN3ATBitKZeZnVqQq7ArIE2Y7gtkuR1091mJoiDIoRKDQANeJfekSwBKfteE+FGA8cGS6sRbiY1BuJ1YzZE+4+0PE8+VRqAUONj6yU+OQd5QJ4H1tSTr11hYmgIP7VQM56XIuFJo0mni0P9HMDb7L8pSksjOAnc/k9oq2BCkdmC8CM9ghqn/tRYrx41RyQtq1ZTHDINz64DSV4pt7i9btsYQJ+oI2NhSPnIqgNXqKz/5VqFAK9mx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgM809vKgIxKeybE04zU8tRE8gkplUZNYkgRiBCnLPY=;
 b=zRZuJ4qjpekD15J3d84zRyKyuxSGO3WsK7NMS9EkbUJ4gaZbLBxVVneZvL92gCHBoCWruunNUIJqcdyMNlWtFdM2BNHOvQ1K9pbKJisriUBFe8ClbMVMlUq+u3JNr1rlvL+O7uT4ktDAA722l0LWsFoa8Tn9VmOmTyRDnaRPKE9M1yh/hXGTLmEFyLK1jz66bgKiH+gYeDB5FD2eOukJPHWI917tSFyxw6doHA3lEa/z2eV+8ysvf+OpaO5YB2buw5d62KovL2plp+Ml2zT6xyuQkBDIuaqo2FawxMze81L4rfYfFnluGAkG2a6kHtnCrr+CjR8c5KMHqi5HYfuMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgM809vKgIxKeybE04zU8tRE8gkplUZNYkgRiBCnLPY=;
 b=S4iKi1uwR9mETf8chH7jTTJj5cCz9UjoKtMlR34SWbY8MD6l023ABQ9CVeeVP5hB4ckG38eS8NeqbplfQ50+ejslhHk3AWMrV522UjXAgs1VftA1f7wcGlhLvy4sGUFRJaua4T1gQCR6+6n8tu+fVO1wjtBkRO1zFvA8xSPNxDcH3JJBRddy5niJTSso5YeeCwCAHsKUY27HU4+xCbdvZNpPaY1rxTdJbuApc6mI+Ip8NAK2XDvaa+W9V3oIjb+fJ0UdvN2FrYz07NK5u97kKPaQIK1DBFM5nnlSDuJJyVq6uiPTKvSNO1e20VQ1l8Kqlq2tTje8fiHr/r3W12jywg==
Received: from MN2PR06CA0010.namprd06.prod.outlook.com (2603:10b6:208:23d::15)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 08:06:48 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::2a) by MN2PR06CA0010.outlook.office365.com
 (2603:10b6:208:23d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 08:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 08:06:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 01:06:30 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 5 Aug 2024
 01:06:25 -0700
References: <cover.1722519021.git.petrm@nvidia.com>
 <20240801155207.1b1c7db9@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net: nexthop: Increase weight to u16
Date: Mon, 5 Aug 2024 10:06:17 +0200
In-Reply-To: <20240801155207.1b1c7db9@kernel.org>
Message-ID: <87bk275r7n.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: f5571ee7-356a-4cb4-c9bf-08dcb5258e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VniEzmbR33lQVc1MSFcbqyWMQdlU2SOAl2fgDlv1/TGk4C+B0i6FkMCO9mHY?=
 =?us-ascii?Q?zEJjauOu0Vyocw7uMTqHHnscTD/+h44a/kJWnUiYx1nHiLzmYQWyYp1Vog2Q?=
 =?us-ascii?Q?9mb+l7sl67HCDzn6bldsI0OI8BxgWFbtjohQ1G/FbGKXNFXt1bpdOoJfvp+k?=
 =?us-ascii?Q?hQIKzDm+ycZluBFrA68zRirKRUlER2Voy7uSgytZlisJFSFh6KeECGKEApZu?=
 =?us-ascii?Q?83GcvWNNFKL9eI1AwonZgU1qr5p46knqnmqS3ndaefGDcNK6Ef1s9Vz6RuGM?=
 =?us-ascii?Q?BokRDjRr2cuQh99gGMg2khZ+UlOw3G6Ie71Ou6NdE/kQNszcvhRRNXf1Bft/?=
 =?us-ascii?Q?DTVWvXTpNqOkXxUDfEQgZbrxGm04L3rndCx68g1RyVgnVUh8CHpxvd0yv594?=
 =?us-ascii?Q?nvjU7XrvSM4N8OHAf0FYszDjrJSJajKqIHnIrHaZMd3fS6ZsJ3x4ble1HnAf?=
 =?us-ascii?Q?jWyqI2TBYNvb4sXMKBXkaq3SPUBu4ZJJTDH55//pIpRRbcS8PV8aQ1akLWcS?=
 =?us-ascii?Q?cVF0N90JbeMHN+YQs3LTbeoWnTLtJSNwWC44zJmjrlCr0MbTn3Vqq7gNckoj?=
 =?us-ascii?Q?WcUYE7iZHYA/pHNyghKiUR/6XAqOqow3W4W9G84Exf1YcaeZAog1d0TJcD94?=
 =?us-ascii?Q?7lmIQHMOqOovQqPy6oJfA0mFrifBNxThncs0qjos0NDZBujZFjLYydq+UTLj?=
 =?us-ascii?Q?Pln8w6jyvQx5mw0of+DPmSpMrgBnBLlzA6sal42tbArjVgUHziC2eFkdalq3?=
 =?us-ascii?Q?Tz9JTgtFXM/9ijyogCcfnp4ulVWYj4WbJjOKuyOJW52js8u+zBn2dzp1GXac?=
 =?us-ascii?Q?+6J3+Tg7pA2wbN1i8xofUBBWcsGdVF6Rj2C4eQ4MU4/Jk/NEQmdQhJFxsFO9?=
 =?us-ascii?Q?1kp7t5xzM8DcLZipGnJN2WXjlg6Z/Q5TS2JnN/Hb74PXTzNz8rHzcJn4hyub?=
 =?us-ascii?Q?cJJjRaQjE2Aaqfcfjdj6a4eXhuVjHpvKxhdKpRRhajCRQlZR2ZLlxdfj8DXc?=
 =?us-ascii?Q?txfP4k4fo2HUUo2tRRmL3aNhTpMd+2pimpvJ2xHh/pfrncTPEsNlz3mvEuBY?=
 =?us-ascii?Q?8QfHo5V/+1u2y/ms3O9MLpGhaE9h/Q/QRpprMJpenKAVdfiTcvwHxV59xyyh?=
 =?us-ascii?Q?VaQwfIjAlb+orSn3eXlItA1p8WfEo1+7koYHtD/fXbYVRViMzF/QyXTV9eN0?=
 =?us-ascii?Q?J/x1huS/ATp/Ntg82IidABSQPoEa0QU4B3EzSlfcV20jWBJfSx2cg9uZpMh0?=
 =?us-ascii?Q?Jd8MWr2tcjvaRncftpO3Keg2voQVo44LNo3UVf3C7/pQgYDRnDUSnsrVWe2g?=
 =?us-ascii?Q?e29Rab4HlNIuta5A5IddmV+9vYhaX2WIaCf/hYSA9grlUiNBfz/dZrk71HKv?=
 =?us-ascii?Q?9GC8tMoVcyvA/ZRAXyl8yPPu2LHBb/mZIC21OwrRo4vqopr+JSt3Fv0+hBLJ?=
 =?us-ascii?Q?Af0xdkkqAaHtJ7XIS5+topCDcmUBNKTg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 08:06:48.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5571ee7-356a-4cb4-c9bf-08dcb5258e4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 1 Aug 2024 18:23:56 +0200 Petr Machata wrote:
>> Patches #3 to #6 add selftests.
>
> Could you share the iproute2 patches?

https://github.com/pmachata/iproute2/commits/nhgw16/

