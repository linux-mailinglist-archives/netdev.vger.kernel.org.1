Return-Path: <netdev+bounces-232330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C786C04250
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4553AD666
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65CA25D1E9;
	Fri, 24 Oct 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iXJ0aSpr"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A11A9F90
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273598; cv=fail; b=lqYd2LJlPpRBa2TAMc8VRX4ximUmRD4a49vxP7oaCvvIOe/r+LBYFUSJgPJCYYtNbJaJL53w4/BQrZUCPLpDNApllOWbRy7MGiAgoXVXgFmnekSXoHEMEKVWNjdUz07aS7tjpkGf1UK+w44Cxi6DfBBo15W2PhpdpsVz9mFdQOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273598; c=relaxed/simple;
	bh=+7BtmcFPy7bz+iZq79MiFHtiZ5gDirpfCaCfzJuaKSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUWJrUMi5OUBw7bgNUSpKb5rnDqnT2wIBSGpmllJcv9rZRQX+Qig20+KzLbcIMaclqyi0GmSkftcTSkvTH/49vc3tcpZUtEMkvjcoP0d53cWseLDQJnEBlSmGiFT8AKEAV2j+G4KHTAesDU/PAc5p1pfPUerZpuRP0+x+FoH4tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iXJ0aSpr; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtOzsUuNKziNNQPYUIlk/qwmBW/tZITtxzIvCrs0aDNAfYNifi3jaSZYMan8ji0zouecLi4dba3Db+5D7872hPkvaOykU04ryuAJHe/Q6Sq8PpFFWbSan9BEqaQY0dKWQ/RO7Fpmqk8R05NU4TdcxXBYOWK+Qk1NTOdzJvwOtC+1PjA8WScMXuF8y9zSX3mlxkxOtcSw+PiJjxrDL7EHmtUMQpNIPo8VVQdzmSwdUp4c64suLSPFWuJRp0yYFdFDYLOjMxWzDiPd0XchLOosQ4jSJvNliES6MUbAkXA8lMtBU47vAfiaM/mvScVdrFUeBIplh52y+CLHEcygHN1CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KWtjsLJ4WbBiNplnjUyDpsAiYIu5p9inXVEctKfJpw=;
 b=DD2rQH2NZSWHIzSwo3shh1fkDWzFfg/Actz+vdnZOgZPaj69mf65NgCLdO+obbfSLyzIARItAfI766h/Pd65lY4h8SaluDIa38QUAXNcsACV00ZGufzLXA7ckOtofbq3kKRifiYTg2aa08lTrR3RyMuEaCBH+6aRqQh0X0aI+rha0BS4v1NEaNJG1hO9YO06pUQ+gVxLO5wYk33r4eRA0Y672bH+gNgfVuq+G2v6TmAH2vR6Dvn6OZXnHIMesSPuY/nJX6qe6Zh/zc0WewIAc1I1E2S+Z14QgqRjQTOeQwLPviVPUjyebSF63zHqn2oIloj2wS+65xmIPrPSv1aUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KWtjsLJ4WbBiNplnjUyDpsAiYIu5p9inXVEctKfJpw=;
 b=iXJ0aSprLrXVXLiGgVD/08cr9GqpGe1SQQpUXKKRgeri/5MXS/8rgPuEiubq+dcviWKZBO2qMHVRIVpEru9ZtdXjSU1gd1YDrhkTyb97ePjb88/+Xg0zr2+1NxKGXql8XjKxE6WvKKNZx349PptuBrzFWSHxiHcakSzWAL27mvFcUeaohY94Gz5dSmpWwAWhjs1dI22Nnjp5Gm7Ln5oBnQFEC+lkmI1YwHDNcdJA7XNjNQn8a4wzpokgFawvh0qxkcr0f8crQ/RCT/s4o5Zc8ggRLvFxLffTN0aMnjOpEq9L1XbXG9IKJ6Wws48FfpboPKAI5gaED+G3jDv1yN4iWg==
Received: from BLAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:335::20)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:39:52 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::f8) by BLAPR05CA0039.outlook.office365.com
 (2603:10b6:208:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Fri,
 24 Oct 2025 02:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 02:39:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 19:39:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Oct 2025 19:39:40 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 19:39:38 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net-next 0/3] xfrm: Correct inner packet family determination
Date: Fri, 24 Oct 2025 05:31:34 +0300
Message-ID: <20251024023931.65002-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 491ea02a-4dc0-4a75-7b23-08de12a69bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VP5rPXNJuB8gzThvKuRh/2muozGwgsYh/5HkzjxkE7wnZdRF4HzdsBeLFrr5?=
 =?us-ascii?Q?Af1RbhQ/81Gpcw8QXr1eb/Z1FLDiZl8N3A6xV2px1c/06fsFnraF2Jpc9ewS?=
 =?us-ascii?Q?FJSD5OBEL+XJecwFUbW8hsEwcdvB6BWvRKawNL4VVkyonu9MXDHzHsXK9lbM?=
 =?us-ascii?Q?MCRI2RnzYhTuRoCFbgXozrWBL5GM8U3K7x+oustTyQi+ffloj9svyswK9ZG8?=
 =?us-ascii?Q?P8Z1plhwZBiyoej/IMvY5WGJtYRsOlV5jH1lQsO4X8NlrIxj661tF8epbsAY?=
 =?us-ascii?Q?eP7ALuzcXDdlpIy2hBWgHfk98KjhsuNpWILxkXVnGeWN5uKdvTNHQ2hNYPwo?=
 =?us-ascii?Q?K0SLHcf0DS27tBE7rhakGGTc44lvfWDust093PDhGqlKD97WkZcqwIXwcwwX?=
 =?us-ascii?Q?Gf0nT9jVi1Uppu6aBIj5RYcIp9dEAf8diATttLje83UphGgSxW2E0cxKY1iZ?=
 =?us-ascii?Q?VQBGgDUaaguaPGaIpn1NSWdjAAtttGfit6YPNb5voZPVpqn72oftLiRMScLM?=
 =?us-ascii?Q?nPL2WRRrF0eWS9UlfKLLZhKQqCcrO37sDERdA+Eg7LmDY+zhAxqUK31WIBkC?=
 =?us-ascii?Q?aUjdViIKXFMiss2pb0NqSCkoNhxs6Fr4bBweUaJ8qiBsVVeSpqoiQdiW6Wq8?=
 =?us-ascii?Q?xfej/2CgoPxYoN9AHlsd53vyhni1J98tu9MwQ0sYXCZNcL/+PvnJg0/LQaOd?=
 =?us-ascii?Q?WphbAvTrI3TR41CkPwG0JZ5jecBJTJQvP0EB+N3tT4Gkk9s1Ahoa4V9xsE5L?=
 =?us-ascii?Q?2973hgR8IRC1gZQWFR/m17nJJkWBnWooQUGw+Ks2wXYCC9KIBkojkwseufNk?=
 =?us-ascii?Q?jHehlwV8EG4mpePwq8TFtfMbmpHHa3bxmCtDH9hd63wZO/bSmqBRZ/JX6IL1?=
 =?us-ascii?Q?5yM4/7HwM3qRkWdkDmkAsNQfemaBpTttF945kgDN6nF3/RQIOe20GDVBmjs/?=
 =?us-ascii?Q?ZE6LIgozVWzlV8f9RYQpmWhhVa/gWY27j0m2qtxLzqmbYE44xsJfAx/ViaMU?=
 =?us-ascii?Q?rtFQadPnUareY4+yC9aESYNZY7TX4M5yAW2nSCGRffz2mc5M81Olour3YyQk?=
 =?us-ascii?Q?GAzM37kC/kEcj2Va5B9A/0m/0AfSsKrAIqI+4ChONMxGM00pVBwyiPgQ7QtG?=
 =?us-ascii?Q?tdlswyGSirLjhdSnb5ilxe7usUK0sjajzvu2xVg7s/6PzRndLCquVt234Gd4?=
 =?us-ascii?Q?xLt+cyttfVF776DCBv6DtqKfHLUieG/2eOb3CvU8SA1cCECFNh3Vt0nkwuxG?=
 =?us-ascii?Q?yk0DsAC7r/hfotV5akq0F7khauZ+a1d3ua/zsW/M7mnIxl3EaS33vD/iw5IB?=
 =?us-ascii?Q?U/uARWUjLLCD+wFMH49Zuvnu7IpHI5Lc04jzbIKO8X+x39RSbTZEMEdGaXme?=
 =?us-ascii?Q?K94pY8dGVS39kEA+6Fg3QA09AUHQKiJ8NoKw8hBht5Jf/zJHGX0Nt+C9Hv3+?=
 =?us-ascii?Q?mWLe2iQrp/cd0N98TzX123x07uqQ5NFFlIpdMDrDaprB/WtqvtBiQJRcUKoE?=
 =?us-ascii?Q?AqeJe3Nn1ukqWh7ejcE8RYDncRNERdplEwd9vtVJdcVutyIBdvkQZzXkBUxm?=
 =?us-ascii?Q?cCJNvCsZ8P9gfqahRB0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:39:51.7494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491ea02a-4dc0-4a75-7b23-08de12a69bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

This series contains three patches addressing issues in the XFRM
subsystem where the code incorrectly relied on static family fields
from the xfrm_state instead of determining the family from the actual
packet being processed. 

This was particularly problematic in tunnel mode scenarios when using
states that could handle different inner families.

Jianbo Liu (3):
  xfrm: Remove redundant state inner mode check
  xfrm: Check inner packet family directly from skb_dst
  xfrm: Determine inner GSO type from packet inner protocol

 net/ipv4/esp4_offload.c        | 6 ++++--
 net/ipv4/ip_vti.c              | 8 +-------
 net/ipv6/esp6_offload.c        | 6 ++++--
 net/ipv6/ip6_vti.c             | 8 +-------
 net/xfrm/xfrm_device.c         | 2 +-
 net/xfrm/xfrm_interface_core.c | 8 +-------
 net/xfrm/xfrm_output.c         | 2 +-
 net/xfrm/xfrm_policy.c         | 9 ++-------
 8 files changed, 15 insertions(+), 34 deletions(-)

-- 
2.49.0


