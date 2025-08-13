Return-Path: <netdev+bounces-213322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649EB248D0
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC1E1B66066
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CA2F658E;
	Wed, 13 Aug 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nc640FO5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602202F069C
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085746; cv=fail; b=Xqxgbeu26gZbg1Hkyn0M+SwjAFd9QMoWb8fVuUqgwP7/mT99Z/C2OfwyeLYgN1yBTQFSH1U7HhyXRRYJwuAAmn/GwzhTyGEWW9VVgmS/kKl5bYLV+KEwlEl1/NhQPY0qD3XtOGD6+ynk37SARVTlvbNXkkvv7t/Uokz3GS8C9ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085746; c=relaxed/simple;
	bh=+CSBkA5fyiau3VM+mrf1CmkAl9sWEuCK4sjeWZ11/eg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWSijWxDWUaI28k0zmN33ftfRJz5BPja4vTCzq5ADYVBTujRarJFedNiRNk0y90w3c9q5D/6tImrtCqc86Np+NFdDTySCoSTo6WANkj1l6huLY/GLLklKxR3bBTCekAIxZ7/p6bdc+IuRn7if6Qx8lrqrNMwdoI8hFsK0j6/7N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nc640FO5; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRam56VbJyPiQIM1cuQdNffs+oAZCOhkHy7j1tDhY5ucgF6ORdMUEYRiMIuYPBp8pJxuKiiLtiEKBgCxzvwhaUG7DSY84i+WDjhi+LX/wCWtegccuvkVUG48zJV/tP9qWsGXFRYUk1FGq1zkcMLXExD1YIkvPTmGKGRkA6wVg1yZSFB525RmXH7PBnXn1VC0tS6yw10S+nGz1UgXTpSfnFTAphNVEOYFIc704b9rLZW4SQ6/0xkD7B7aTQNvFJMr4umD/OtsBj5JHm4gtihW10ed/xu/V2j/GtdKdvz9BW4DIr2rqYYQ3LEXzUXkw0W6FkOliQin55CQR+Pig8vMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRAQbKcZaaw1bwPlcvlOSz3FHDMfYH0uuDPGQh3RzK0=;
 b=OqU+lSjKto3O45rCgoTKKbiJMoRw/Yix4MaDZVTPdGCVtq3+G9OQlkggSENVuPYsgLkoclkWMWdyAQSPRqiDxFHkVUotmgxrspVVGSC2+NlR2mDnJ7RoxQ9CufN/JRf8f/ZreWDKqfLKt2YPlVOA9LkrWCF4gAAnn82AagjWld+ZmNt2Sy0LIK5Mfoh/hqvRZB75OQyn9s7pHFWXmERIuHa9PuIfrHKDpsJrDpExMgM/alOO0IrJxUZpS4VzqE2H3ysTCjXqYqHLcxqPuyevQdNwzNkelmIxRgWtjnLICAQAypBVgszOzfZmfwO52ydIHbScoJ0LKOq5PA6oBA8lDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRAQbKcZaaw1bwPlcvlOSz3FHDMfYH0uuDPGQh3RzK0=;
 b=nc640FO5xOZo3wG7ZfxOiK1AnFPatzGzTCIWJh3pR91dU5tBMWxUO9pK5OAmkh3rM6jEy2wIITdF5NKo4xLZNfSd226DUJclk5fHdopD5x82LvJAyd4uifwacJ/GQztg7qV4Qkw1ajnKsci5bgA15WOGrU/gljocyQjJVw1ENoqfw0+hWE2VYDgIyDJqDbp1WkbkTLNRlcnVzm9zLQLtbhfmMT+icfKhf+mgdfpxUmuWBDlj78Y77pEocnpscsQ9E6AX53myDBqY/1wewbDu0NEiAaOV8EuQtOCWgmABFshrcKf6o1sAPtZgE8GtqnpNRHAryUCwkk54bLTJn3hJUw==
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 11:48:59 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::3f) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 11:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 11:48:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:43 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 04:48:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 0/2] mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
Date: Wed, 13 Aug 2025 13:47:07 +0200
Message-ID: <cover.1755085477.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 6761b2c4-cb64-428d-d847-08ddda5f63d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GiI3j7vilTX9n/P7sxT9yz7Jfy5J2yJ3YxjFUBaCz+b/tEMgU4/3Fpnvs3ef?=
 =?us-ascii?Q?M1xZvMTeNf4/maKr2AGitJ7jZpVsgbUFwn75AwryURluBB1zf7C3GZj2LFZX?=
 =?us-ascii?Q?fUED6PTx8oC2TsWXm9Nd83dEHW/pkno02wc2TG6sEx+E1K+0Fqp/m3opNaYe?=
 =?us-ascii?Q?p0+jjegqM2nqdmytl5rweva3/YTII9PNi3bQL6VIiQ3eQLXpWy3zRw/zGLUR?=
 =?us-ascii?Q?mrfGglx8Zo/SL/Fd2OM/BYKmXeuPKrFkiL37BB7w0hgQtoVkLG+z9w61Y5xL?=
 =?us-ascii?Q?tA5petVvPGtMZ+Fb4fe6F8M4ilM74wGWqaXFZii+WPDkyXlFnSpZpZc3qO7u?=
 =?us-ascii?Q?xYZjqNf3Tpxn4BiT20CVdgI+heECr/Ah9aRx83/JsKF3V6XYTIpmnThNr0Bu?=
 =?us-ascii?Q?qYT0FEruxVC4ayNoE+QrGuytK+CEB/cH0tNx8kqKa5ChKDcWVNn6dcgcBwOO?=
 =?us-ascii?Q?GXmyidZB9L2kvNLb+OP46buM3AEgB2Buv52fnx0148XCuagAhZemz4Pi50cO?=
 =?us-ascii?Q?5DtvlCTbX0VFbhaAb4hI7j/iBuf3RDNzvoVgtamYG+wkcJQgfkPWHBPiRDRF?=
 =?us-ascii?Q?Iva0htssJfJ9eiVaN2WNNbMwTckNChKYIo1GPtnrY+Gc7uwoPoQs2rHmYnTr?=
 =?us-ascii?Q?dVkkSjp3urf+C/JjAIZgTtIpzYiWxdBo7oErXvfeWDobgvUEQFBi7UxPIY0O?=
 =?us-ascii?Q?Inx38EiqO3Sd3Q2g8yjP7DvcTCqZR3L8oTnYwym0QZ60CvTHNL38jZyM3SNc?=
 =?us-ascii?Q?fDfHRSPgUZUl5Xz+NU0d2c4+gBDIZUxhgq0yfAyYAVa/eypc2r3k/U5QvXQ/?=
 =?us-ascii?Q?CS/OB7t8kgmiv9xC/XrKx+mazkT9SdA+Wzex8kn41ALe+CDNwzJRd4Ydu6MF?=
 =?us-ascii?Q?/gD2bPpp61fOHNokphqulbtTqQwwC9GC+xZuIxu+oagNYoERAJ99d+lbHIzp?=
 =?us-ascii?Q?sals+CQ0+ut9UYK/5F2zY4RnNFCwlbcegosEShJ/Ehu2ZZZibRSgfHB4b1pE?=
 =?us-ascii?Q?bMOMqvC53zXoAk5uOO8tWyrEMZc8Zhyx9+zrbFewEFQELfwkU9V/FfCXbpcX?=
 =?us-ascii?Q?KPTn1cVoa6sNm3FItpKtYcdiMpOesx1bLskF8k+15vuvUssTRas12MISn2jh?=
 =?us-ascii?Q?8DLzsRH3HzEqF1Ij66Ug/7bgjYcHcgMKmRf0Vo9Oe1YEsagxW3DHpvqJlrVl?=
 =?us-ascii?Q?KayMzrYLTsR2hx0B4unpHwq41BVYj7tCQWwixQ2T7f3h1ztV0VYsbT7J2Tvp?=
 =?us-ascii?Q?joB/30kNwlijYXUMZ2aiSc+/OE1SiofAomAbqYBsQNTKxHdXsHdPHIWCQZw0?=
 =?us-ascii?Q?kVFbkg1WwpjMbYid1aVr+NMAbquiNqi+HyVr1oYg/Yj5HEIw1HWgpOVcn2dJ?=
 =?us-ascii?Q?zSM+Z4kOOlEcZ/vLeXHfeaVwNHy3YXWoT/1WaA1qcz8mgNw+XtQTx77iOxV/?=
 =?us-ascii?Q?tjp6iQ4z6XCrZFU5SykylHGHys1IdWqCYIHqxDsk/ZKi5mxg21HJmXDgq10M?=
 =?us-ascii?Q?U8XCLrUTICMICbSPoIm56KWNX0KunC7WGNFF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:48:58.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6761b2c4-cb64-428d-d847-08ddda5f63d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

By default, Spectrum devices do not forward IPv4 packets with a link-local
source IP (i.e., 169.254.0.0/16). This behavior does not align with the
kernel which does forward them. Fix the issue and add a selftest.

Ido Schimmel (2):
  mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
  selftest: forwarding: router: Add a test case for IPv4 link-local
    source IP

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |  1 +
 .../selftests/net/forwarding/router.sh        | 23 +++++++++++++++++++
 3 files changed, 26 insertions(+)

-- 
2.49.0


