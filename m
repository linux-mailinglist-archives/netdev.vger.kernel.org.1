Return-Path: <netdev+bounces-158958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB7A13F98
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4967D188C895
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEC22C9FB;
	Thu, 16 Jan 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PBC50GO8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C526AE4
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045563; cv=fail; b=Zc+NXxYqABQJchDXBHayibwDamFpU9eIhb65WwKgm38BeM+yHtVIHBGoTrqJE+IteSCyP0PQm3Dt3VUSfx4jnZ28XQ1Io7k76bGQ5cRbL0wQTtDdzmkvkkKpWQ1f7LbnQL0C0JH3+JJ738ERKvZeuBA/vRSLrksM8ylaQcY833I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045563; c=relaxed/simple;
	bh=Z4ewPjhP2aFwy6Q1BqJhS5ZCo1zl1CgOG/Sn8nrrKFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lr4/bFTtG7oOc1zt7vn1FvYHpqO2ghu4X9kQ331WIXJAMF8m6yq8eE/2cmQeONYVXzP2JGcwca7lfZX95aW3Toi0Ncrmp8GsZkvOEranwGGC4qrg8dcktSiayPcWFcHgTpAzVf1l+czd0p6C687VlozKJ2VcEADIS3gjSKTb/vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PBC50GO8; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc4HYlJKe5epua3aGLTF8aywH8hOROgS+wm965T85cLknz/ZwiSSrCeICB1v3+bSw9X9qt2StSeb6UUnooYB75KoWLoOeQQSoIccAC2GWkCUxJVm2vKL/e4/7heOlTsPMePFkvEfVnb+yhsNOd1l/8976vd1LiEMWgXmlOXIIQ8/b6aNHWUsEObUinFDZDM6CmyTZutHPCI/uxLQLgs9LDUIZNgdLuTKjjalVWDnG5T9i3sTKNNFLpxjj+k4PlOUMT0YohkYM90dElV9zfJq3YxD+LHVuPTLbhiUr/ARfsCsj1kxbLU+bwNUvDfLg0Tc+HkiVjvEVcbdNrIUcGoEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJdEdkfUlEKWjh58H8VadeO5YENUqqB96upE8CN9sTU=;
 b=D705otdfb2TEJuE5s9Tc1/goRAzIwrftYitCX4R13V5VVkPgQyFJGQH62iBGm7TO+UuL0mWbDuPaFNGZ2k0zDkN9i+HfooY9QPMR0O6s2fX7ie1Cnpkqo6QqwnN3n2N+DPDoCkWDJvO33lXIFmYnDEiyyhQLiplmf3XAN6I3fZtkoDjpg0l4Id/xTBGahguylsMtummoa3OwTzBAjTqAh+2ZM6SahDeof5dEh55VbTDINiH6ytkR4LUn3rX77HpLNjBLyM++MZhi3sfAhnkZeUA4euE+wXwAkj+jdOvovoVDWkaTJh6WMXsWmxe1ec+Zojhw8BpTdOStKoniuSuKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJdEdkfUlEKWjh58H8VadeO5YENUqqB96upE8CN9sTU=;
 b=PBC50GO8jULq+sp+FVvFbiBbKv7lEz1nu7OKZvVDTPIjiRkf/iQYpxs7f28bXkxyuH7FYV7uiN4/Oy50Q0f5CKeTYU6o6hTcSf8+8WLutC+Z0gotTLWT9JhLZS1n2IB1n1Lol/hEgwlvHqlG0Eb8m9IIiCrG7XbzEh367kFufk0rV3kAiCmjrtGhcToDfkgOBX8KZa4a2LHCiRpmXzIqpoEogNgPYF4tOeiQqvvAqv8aLBGWUQqNNyk7i+9RrXujV1+ynigIyJb4MG+h6rVxWLJe07roAUwnxEtVhCk6KZ4X8x1bdrn96TTpwB0XGj/BGmqn4FMtYwTSVCUtoL4LVg==
Received: from SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::33)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 16:39:14 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::47) by SA9P221CA0028.outlook.office365.com
 (2603:10b6:806:25::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Thu,
 16 Jan 2025 16:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:39:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:38:59 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:38:54 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 0/5] mlxsw: Move Tx header handling to PCI driver
Date: Thu, 16 Jan 2025 17:38:13 +0100
Message-ID: <cover.1737044384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: e2908b05-f9e2-473c-e072-08dd364c4fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7jFV2OnbeWMgm2krjASf87nN2LuK9YDgaassKpo2N70KJjBki+6vLX5kVIe?=
 =?us-ascii?Q?8E7U+DpDAsorA+Oy+ICPtEmd5CIW4MR0vlhWV2v8FKN/KTZtjQpJ5OiwlsVO?=
 =?us-ascii?Q?BVycgg4ui3lnFhsMfhq8fYoTi430wb9kGC/ruvneNuaIJRH73NlcbCFDi4T4?=
 =?us-ascii?Q?DUQaMBCpow6O4THGGw4egyAEsep8PW+fnHEvSEY3AmLylZJTUCu8mfNT79vS?=
 =?us-ascii?Q?DBkttBcSSDOywE2xdN3nJXIORVL7mORK4tMJC3RKDSQTCrdjfiN2hENWzaez?=
 =?us-ascii?Q?0ke9U9ssjwW9mdAVy0humpi8zjBSeLjWqS2Ik6IU4aOhl+Bxi14W2eem9jZR?=
 =?us-ascii?Q?3fiLJms38YZnnC3ErLNrzlYihOxQ5I4VX8Cpa/udGHDF1lDXDHwCLw1ciuiN?=
 =?us-ascii?Q?BHjzTJvVtdYOMSfeh9ydYLBqmZ6Ug9xESnES5A8X0eg0WMRISu+A0sqPSu1/?=
 =?us-ascii?Q?R3+84QqMJhjJRJwQWrt+8yZ2fVuNSEx6dpHTs63pbkfv2rVainVeUY35FCB6?=
 =?us-ascii?Q?0V0+cmpA0dI2+At7iB44mYVoXsqhKRtwQjbUY6deX1vw8tyhfGxNczyyZGP5?=
 =?us-ascii?Q?p82L5XdtyLoO5hcRy37o3W8ncwdymPxArtHbulEwjMhC7tj1JpqXj7uVzRCz?=
 =?us-ascii?Q?KiRoUJJ+jmofpn91T8ObFVjvBNYhpxhDmh1mgyfHPRBia7xfjJz7PFxDRye7?=
 =?us-ascii?Q?yzgznJZzE0EN2hz3ldEc+1sWibpWilChMt2uww2/e5MC/LsWn1f6eRDpVVzR?=
 =?us-ascii?Q?N8Ar6ryaD8DOgxk87ApEK0WDkGMFxB2h/rCAAegBePe1JDhpu0MmRR17ZD2y?=
 =?us-ascii?Q?Uv0YMyzm+qIYeGo2vQnVxg5q7kcXWjMWXyy5F+d3Z+fBldo0umr1UE5k4Age?=
 =?us-ascii?Q?/C/iqB+RsdK874gxMeCzNa3xOIa9kvTHNmP9xYIJrIm+nAMdcnHWNbSsikH2?=
 =?us-ascii?Q?1QXToBDkW4HDh5bDZAPj1IpulAlk1q0Lz1qRIDMDA3V4lls9i938PLhUkwZE?=
 =?us-ascii?Q?nVC4UKS3hM9ZciNNJDVq5cMdODjTVokh5wTkmxdy7U1vRvFKg9dZg3y1TEX8?=
 =?us-ascii?Q?kgyTlOvigmEvzro9osQARFDdzA+TEWxxTlVZgRA/gIGht8EO0LKm/dPi3YHl?=
 =?us-ascii?Q?N+Mr6mehUCTkOZ/Bj2fpm6/XUEYr3EBf5Q2bL0zyH8QvVWg+tlaanUlNh3tP?=
 =?us-ascii?Q?vQMqcggOwgkuMI1cQLcpisMK5eAVCwb9OWxIHXtt367C12Hbp8TUlbClf63y?=
 =?us-ascii?Q?zJkv/nPhkEeUSI964Ol1C14sHcQmN3ewLR4DsPx468nrVY/IlpjIm4Q9TnPp?=
 =?us-ascii?Q?vcZw+S1Qrw3+ZoHt51vL2GMM+tW4tZfCFzyIHUTDBBWBU1xl3EIz1kz/Oynp?=
 =?us-ascii?Q?Ru0Vu9hXu2qXA7y1WLRTYYbS7pG66Pnw2HJIrDc91Dy5CyEokOo7IEyBmbai?=
 =?us-ascii?Q?o8AfuUFj77ashoRqhqGeSBGVe0eBwBqh8fU5J41LNAXdEl44EjkHmJh6hj7g?=
 =?us-ascii?Q?c6eRE6e/g3+iqT4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:13.9560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2908b05-f9e2-473c-e072-08dd364c4fcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830

Amit Cohen writes:

Tx header should be added to all packets transmitted from the CPU to
Spectrum ASICs. Historically, handling this header was added as a driver
function, as Tx header is different between Spectrum and Switch-X.

From May 2021, there is no support for SwitchX-2 ASIC, and all the relevant
code was removed.

For now, there is no justification to handle Tx header as part of
spectrum.c, we can handle this as part of PCI, in skb_transmit().

This change will also be useful when XDP support will be added to mlxsw,
as for XDP_TX and XDP_REDIRECT actions, Tx header should be added before
transmitting the packet.

Patch set overview:
Patches #1-#2 add structure to store Tx header info and initialize it
Patch #3 moves definitions of Tx header fields to txheader.h
Patch #4 moves Tx header handling to PCI driver
Patch #5 removes unnecessary attribute

Amit Cohen (5):
  mlxsw: Add mlxsw_txhdr_info structure
  mlxsw: Initialize txhdr_info according to PTP operations
  mlxsw: Define Tx header fields in txheader.h
  mlxsw: Move Tx header handling to PCI driver
  mlxsw: Do not store Tx header length as driver parameter

 drivers/net/ethernet/mellanox/mlxsw/core.c    |  21 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h    |  13 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c     |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c     |  44 +++-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 209 ++++--------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  11 +-
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |  44 +---
 .../ethernet/mellanox/mlxsw/spectrum_ptp.h    |  28 ---
 .../net/ethernet/mellanox/mlxsw/txheader.h    |  63 ++++++
 9 files changed, 176 insertions(+), 259 deletions(-)

-- 
2.47.0


