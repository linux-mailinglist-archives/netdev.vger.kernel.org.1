Return-Path: <netdev+bounces-217047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC72B37274
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5111B27D5F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6B29B20D;
	Tue, 26 Aug 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gjZSRlT2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079231FE47B;
	Tue, 26 Aug 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233979; cv=fail; b=SkhJ0PArZQCVZkTvLsuww9NdJJ29Td/XIdR6rDmyKYOQ2lLut7olNKc3Kh8IiMnA13UT4Zct6tuLgWPRKFs0VbQoOaxGIB4wQG18z7POZOBuPGh3TciplycRTn2H+OmkCnDYj76BZjgC+CfHxf+BNEkaKQMiEAQ7Us/O935aTVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233979; c=relaxed/simple;
	bh=5SZijwEXrDH3N6FoNaOmlERI/Q/E/eRZwSjr26PVsxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTWKrSigN6sIjO/IVczpE5aOH2fwg+XDF2yV4sZWX0YNKP0CaGfygtXINsTBzhGfHtuj9lF5jvpFUoDcwu0tKqB9MdW6yTQfGJ0AJ/xpCwSz85IPEkeE7gSZVgLc0/1LUFZ385obb8pd301iMrKYCm3HsptjafVrZXqfyl3wjdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gjZSRlT2; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9ldY1qKhRbvcVsGKYB67LTj7K4FMDyrYYlq0WF2YkbGZ2afQxwHsD5CCR/EIWNtnn6A7aZxaNolzQureyBrq2YcFpUDOC272OmU5uU6wm9fQmVC77RHIdxcwWvQAeUfN9YJ/fe9fnn7UWaRuIBoXNPyPaFRorzlYnffdmm8wh3npyhbtOMOeE8AYrnpHTqBayvSMxGkeclQafaEMtU2ykgB+Ze7mKb3uksXXbmnEKas3/ubB2s4rSnXjYtKfVqhZBhpsUxPzyIN0WlB1iQiTA20UaajNUo1U+GzRjRf228HDE/CIBT7jvUnPkhH8CT4ZNgO4kTAnpZCIPPbPVYkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SZijwEXrDH3N6FoNaOmlERI/Q/E/eRZwSjr26PVsxQ=;
 b=cc2m6+hiKY+B4pFCipWCg7+a9rWoheviomo9tfMZIBsCzcRTaH2MB4EbFGYhSaHcR5wqpx2jy6NHG4NofCGkwV7zEeBD4yCid04TBAjMY+sH6uofyhcttK11dX62I6o0QeI8uDrJzvMlGJif/kukdUKqE6QKGOM85H1sCgxrDF0FX1pvSncSndonSlHn+HLbSU+iVwTofA+v5tYkpY8QaVdRTQOu+nhQVgASChP+e5jXb7XFkb0VDuNbIDBaoh3YwT0p/d1zQvMkPkulKnho/o/7UlbHxcV5m3rDxGjbw9UgbFlOEbmxCuTCxoJgJrskUeeAX9lTPPaJDb88SNZI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZijwEXrDH3N6FoNaOmlERI/Q/E/eRZwSjr26PVsxQ=;
 b=gjZSRlT2r+MhCh2grYu3cMrpCxPBm2sZCr+QVgI9xxeFPc5Oy/T9ZcG1tGz/fGTIBJnUU5WQXV9nxGi/5G9YiITiqy4dO8N/ErHDnUUa+03FGFpwpdXiL9I3NImJNqYu2aO00zuUSAv+4q7+Y2hwbfgR61wgpEQ5UG2ayYto4qTCa4zsHKY4VcmesYdzOoPlQYByRpKu2NG6XImGsbTi5zi45fzfeTZPaKySYsMrVNezIOpFmjV0PkG3sjybLimxSPy29gz8dPw6Gy9PrX6PP+JsEK2ItQg7MXhiKXrK7WqqMddVc0bW6UuYDKg6sTQq0fgRdWEXcFYB+Tl9Nj9bXw==
Received: from SA0PR11CA0160.namprd11.prod.outlook.com (2603:10b6:806:1bb::15)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 26 Aug
 2025 18:46:12 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::a1) by SA0PR11CA0160.outlook.office365.com
 (2603:10b6:806:1bb::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 18:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 18:46:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 11:45:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 11:45:57 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 11:45:56 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <cbabroski@nvidia.com>, <davem@davemloft.net>,
	<davthompson@nvidia.com>, <edumazet@google.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1] mlxbf_gige: report unknown speed and duplex when link is down
Date: Tue, 26 Aug 2025 14:45:59 -0400
Message-ID: <20250826184559.89822-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815121102.0653f13f@kernel.org>
References: <20250815121102.0653f13f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4cc1ed-2a44-4688-fff1-08dde4d0d4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aC3Ou0lTHJDIQAY8+po8pTTutGtJzB2SdM46vIj6NQlxRMqdpk3la14jHnrq?=
 =?us-ascii?Q?f1NpJ1HE1q66LK9XmoFGKLOoh0NcVNZU/KDr6rnokYBLZbo5KbgGHopmmDF6?=
 =?us-ascii?Q?b1aIormMjceb4Qd/PF0MhxG85aZUa4ridNPg7znB288NcPL6Dov5d80RKtfs?=
 =?us-ascii?Q?eL9T9MRAQvxqLEeO2V6iUVRXxdIP27LgyNBmSDGv/zXHDNB2P0pemkP5WcOw?=
 =?us-ascii?Q?9/J4KsCZmJXaBAsimR9R5Ho4JM6CYL3mvsGevYrwwwWgxtPEe1aVWAD5Kk/Z?=
 =?us-ascii?Q?OIGzM853WLbiGO68IQO0GOq2K/LbkMZUesRJeKSrX/YHuqjPYHRqU2jJzA3h?=
 =?us-ascii?Q?8QOdd5cfeQkgfnY1M4vNpsKZBioa69GgVtydqjzr561Bki0e3R7JRR96GD6S?=
 =?us-ascii?Q?ECAgQlU//1nv4BHm83GNrIY0tnrJu02IqKPEeIZCwjbjgnOtCBxKdGpRNz3N?=
 =?us-ascii?Q?WSGAFUVy112ZGWY1/7Kjj5FNskRn3lloQxuI2yfbBdFo9fJWjPDZCr+8xdhP?=
 =?us-ascii?Q?ht+6+o76x/YAeQMVlu2OESFNbRYPItcXYizljH2LX4uJp4HXASc3fYhlRji9?=
 =?us-ascii?Q?k7tuo+kIY6FtY3cytdTbiHBQzBZuSNzup51COKo/Lm6SX0NVbvIDQcu849RX?=
 =?us-ascii?Q?WuBF0Mjfu7W5gCAIL+iWSDyZc+djQnOHcaSqBwfx4X5r686n0gD9h1esxuvd?=
 =?us-ascii?Q?nwHtFzrhNrQIlNo2DJ/Kjwa0IK3oCpJI28EPmZXVDvKrlt7df6L7DrVvxKIN?=
 =?us-ascii?Q?tlAk6Va2e10/Xn1GJsCTegsNqC0d248ZMxJCG4184vV3212VQdTupOqYU7EE?=
 =?us-ascii?Q?AVugDeSnrzK7m2uAIGGsGXQco+XsBN+d6zddj4ehzvhjY3hlv0H/woINZqrd?=
 =?us-ascii?Q?MYRSdZRQLids6Z6ubLGqqNh5ys+B+6L70Vs8p/LcTU8oJuEHRWtlf9Jsh1bb?=
 =?us-ascii?Q?N2Bs5sDvWrg6dqK+WFHzMWdDzbGTZD0fANf0nyKnhwBX1HUlf5On9tnGhvof?=
 =?us-ascii?Q?5pYHCVncxFPmAeNLHTbhaKolSTX3VbyV9l+qV1hWYKf+SPOxouvu2Qdngx++?=
 =?us-ascii?Q?Ei4O+JXcrJmuGUrlWupiLg+qcQYpAhace79Ilw8FxtnTnT2lTlYovRHE4X+1?=
 =?us-ascii?Q?TNcn/7RXTbwtTVJnCx8+ovLIRwS4hPkM86ucD19yjdZr7TTxzZj1smEhg7XT?=
 =?us-ascii?Q?oPgk803x3zZeJgDkp98o/PE1tOHASiVgdP32lqtaL2KobpjDIIiIy0rFZp2L?=
 =?us-ascii?Q?Sjvj7UG1qJ38mxFzXyfREMGBzGwInOgIHPBV6hz/Bua1mOMxMv+E9zwAU/h6?=
 =?us-ascii?Q?EFge6LazTpmF+8gswEqqGiu7GxuMH46Z3v23VYxfTBuWgRRJ58vlcn3Q1f4h?=
 =?us-ascii?Q?NlJWjJBLhBMzJjU5M8z8NIShzwGatZNie726GbxA7wNniyhkuw47BZiH2bN3?=
 =?us-ascii?Q?2dd/+szQxNgsa3rBYa3Slb59m1T8594nshrqsT74QUW5DUoCfzOyZKg+NGEZ?=
 =?us-ascii?Q?gV7x84h1Xwd2eqTTIhIlyuUDCLSJK6z+V/1o?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:46:12.7361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4cc1ed-2a44-4688-fff1-08dde4d0d4a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

Hi Jakub,

Thanks for the feedback.

> If that's the correct thing to do why is
> phy_ethtool_get_link_ksettings() not doing it?

If I understand correctly, phy_ethtool_get_link_ksettings() reads
cached values that are updated when phy_read_status() is called by the
phy state machine. Doing "ifconfig down" will eventually trigger
phy_stop() in the ndo_stop() handler. This halts the phy state machine
and sets phydev->link without calling phy_read_status() or explicitly
setting other values, like speed and duplex.

It seems this is expected behavior with phylib, but I'm not familiar
with the implementation history. CC'd PHY maintainers for additional
input.

> Please explain what makes mlxbf special

BlueField is unique in that the phy is hardwired to an internal switch
and so the physical link between the phy and link partner is always
up. This will also affect what link settings are reported by the phy.

This patch comes from a desire for ethtool output behavior to be the
same when an administrative link down is issued on the BlueField OOB
(mlxbf_gige) and NIC (mlx5) interfaces. The mlx5 driver implements
custom get_link_ksettings() handlers and does not use phylib.

Best,
Chris

