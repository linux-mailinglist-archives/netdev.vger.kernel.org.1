Return-Path: <netdev+bounces-169362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C35DA43922
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A416D7A41CA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B2266B61;
	Tue, 25 Feb 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wn0K90o+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC9266B5E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474662; cv=fail; b=iedXbP2zYtCW0+w7vaPcJjOFwrhK0Ne4hTNea0lccftu5ryWPYBleFy7aaBoi08MAoopnOjh/BNiMng0K8fUGFhsB5g8V5b70WC9fN7kdn7cJWCbwcq3PV6xSOQA3MEzpmy/vgozPEK38cURu07ni1IouN7Grtu/YNwVpUtRjDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474662; c=relaxed/simple;
	bh=tly8zG4/k1WKSiKWycIet/C52NFzCNLUI5Zw9hukI9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWsH/iD5uOErWZAlDLgyEkLygFQggIcO8+zIblxEFwHnNecMS+5qSwWf7cSIEm7Ue2NaP2szQJU+WcNU726iOISXQuzF27bR0ZT2815HaZRSNZK+WbYYLm6AgAH9fEAdIyIhWmY9xlxq+QYL9YVGVIk3hMuUo4k19ebHhI3u7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wn0K90o+; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY2ExbDmus/hBEOP/Td/WNzTxMQWwJKODlu3hs5A0HHPrb4yGZ2/xOHF6NO6+52caYHdxnpJqLy1YTp3LgF9JrHZ8UWmN1dR7EXUzN8L9emFi4zFZc2L/Yjpi0QiNM44X0bV62P1h8XnBwtz9GHGPMhjuWDmOgkJpE6aH0NLvsk6hZ1eaMHuh9Ru9MEXnoNdTpC1fyCkadlWIFDR0SW3Sul6OyZz7p1qeVVfXhLXzrUhGF33xsYySHEKzlyFt58TFvy+HkjXEnIbzrOpokwX/XuzWiQFS3LdrSgXCkhVJ1Q+lSy15eiQOseAgn8bGZeR9KlDJ2gyCKhiSMwje41Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvkfJmuxTCIG06rZCADtd5h+Yhz6gSrhaYRvZLv7NSc=;
 b=xMKzvY19SH1ZFROX5SDv16nAEDbv4VwSrBuULtPLhRrZ8qXzN0wIdbPXGvcxxS9uCreykp2rnqKSwUPCxpSe3BMp7aU9t1NFjx+Yc1Eb6prnN/SX5TUx6uzY4Ex2Gk7O8jde/q158QGOPsOA6MAOwhXsauBscsF+FsN3Fj/tmPHiDI4gQQCplY03AmWy+kn9gno4xv9ULCdBlMxC24OR6mPibshCH/ovP1HgUJyNfZWeI6NeOFb39sfJ0iCo+BGzECHzz0Npbxbi17CT1R6ojXhyIyn/4tcINYzYaT8YSwu44ON5u2XKyjbWpjwCO2bl49sHiAQIzICxlUOmnDeyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvkfJmuxTCIG06rZCADtd5h+Yhz6gSrhaYRvZLv7NSc=;
 b=Wn0K90o+hgmHDs/K/ZwehFaMRekTNbySnUQZDux1ZxsCb++Gt0amqebTrGaBqg1KUYYSil+/HsS6NtXlm1wTr5qtoEvk2oJBsJoZzGVfEYJ2y4i0ZrohfYMa0s4Pb8iOJ7NObBygfYl1wFFhbAc66YH7tHCq5TSXig4P2RI5prExXOilKIM5SNE/RxHlkOqwU5QXAEWEkTIwJ23bPMWpJncV00ceRhg5LAsJWnRw1hdyRMr0+CC9Bkpic3v3hR1PehOXtFG5KGiCMSc5VVioPwDx9Aa101kwgbszbcx5Bo45+U54iu5hyk3y/WET5ep2kISlNGMG798wuV3LH9Nnhw==
Received: from MN2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:208:234::33)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:10:55 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::35) by MN2PR16CA0064.outlook.office365.com
 (2603:10b6:208:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 09:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:10:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:41 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:38 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 1/5] Sync uAPI headers
Date: Tue, 25 Feb 2025 11:09:13 +0200
Message-ID: <20250225090917.499376-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225090917.499376-1-idosch@nvidia.com>
References: <20250225090917.499376-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: da6f769f-fb38-4702-520f-08dd557c4f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwGvqU96s1+2DiQHx4myAJMJFvXWggGMW50LFD3bAXZRWwozkzYIcGQg29Nz?=
 =?us-ascii?Q?C/mIaFr4aYrD06GMpKHJl2LkglSPI1I/NMOaQWfqj9QkWaqv/+ahAML325Ll?=
 =?us-ascii?Q?AO5lVXd1A3fXmyc5c65g/Jff5pJeMyBb7xL6fQmfYWzBfpGr8VQ2ksJMehSY?=
 =?us-ascii?Q?19EIBtuxo5RcAntJypclZNaydgyqUfHnfUsGVL3Qsh30yCnOUFxYh6na+v17?=
 =?us-ascii?Q?pwF2p/tVbg5OPMvMjHZbLsuFH4kRBCKJRSMwp9K7EIVO/cvVu1DkGWEgl+Z6?=
 =?us-ascii?Q?b17Vl7gCcV2uqZ+NtAAmiY/FwEEI9dOD4rKHEJqQNpMSdyE7tNPcn0/hcnzd?=
 =?us-ascii?Q?mqGQxvfCiPa5dkRVtNTxeQoS5Qh/26KgKo66wjJe57W5PaNXrMghVKiHpkSp?=
 =?us-ascii?Q?ViRNKMP6uDCdwnc9xM3XuGnZJGdgpv2Z8YSTWDHvbjafluxTO7OE3aHkdYq+?=
 =?us-ascii?Q?kqhKEjsbAvVR0euQaQ5fb9bn78OCE6XlRvc2BgRQ+qFABThM44ajcxMGsqNM?=
 =?us-ascii?Q?ki3w/BJy9ZR2gGwu8DlbuZmzdAlz4z8+W+4NAGOw1lvV6xIKFXhGrRLU1MJZ?=
 =?us-ascii?Q?kSXGEpekaD3i7xBSRKodXuMgMvUpavQOf6bWHBDQign1OTdoDDr3f/eZ2tmB?=
 =?us-ascii?Q?/UVHYmcUNH2CAugAbdCvbSZy0vU8JSrRSnT0H2vAlRfJxQFH6ZVhGs7BpUPY?=
 =?us-ascii?Q?XRq6Io5pRWdNgCbW8t5qskPEtwL60iFuh8EaZdyB9/Hs2Y3USu0unRw3QPFL?=
 =?us-ascii?Q?YHCHZs94LVtQX0LmQIGL/UqqB1YiFB5jqcjlBnU9qd6pzY6hTpxojQTUfA49?=
 =?us-ascii?Q?/Id/hX3ttvC0rdBywQcTV51vwEyex8ltA2IAG6h5KKo3OeyopH5JI5jkv8z6?=
 =?us-ascii?Q?CO4mcBl+B5bJpwPFTOmVlhvm1E9Ry00Ls8V7fu0njMnmnT1lVa/9+iT9kxON?=
 =?us-ascii?Q?MjNeJKtHR0moiQBHPpegzNRWvFCMH87cpH8R6lNKqRwGd5o7wnPj5GxxfgV8?=
 =?us-ascii?Q?6WNRBVcSlTbPkjeZH+ycdbGoFO/169SUS4Q6qD36/myvTXolQYr6lRjnuVOw?=
 =?us-ascii?Q?uvAYe2Sx/Dh7Djvrmq/bXCsfxhXilpO11NYjIT/mJpCWts/S8sMUC5d//AeO?=
 =?us-ascii?Q?/Dd1Zp1fVPIVb9XmmzXW0PABqDavfrZW8B4PUbnBCxaTzYqykYF0Hm1TBfff?=
 =?us-ascii?Q?MpoLwA5T646DBeTBvVmN6sldOD9D7CsHytmtAncZNxX7qc19m5mglR64UuxH?=
 =?us-ascii?Q?2FAHLDzOa0eXb0oMo/F0znZJD86lo6xAZNF7niGT5P1RGu7eNnJXmSNfKzxO?=
 =?us-ascii?Q?BF/6QgbwPvVwGx+Ke/qVu2lPEGNDhvSXyfZLCJ5b1MfkYAUK4YVlq3tnQQIj?=
 =?us-ascii?Q?YZpOlGUEEJomGzsBuq9xyuGY50nIBYytljpHrE50mZdE94l0MRfK0qXr8J19?=
 =?us-ascii?Q?eozECMeK1/eoNiHEIJPW77shGD3QE1xCUDAQbW4GnBUFeYNlW6y9C3WFU7Im?=
 =?us-ascii?Q?shAZWOo5lmmmP+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:10:55.0072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6f769f-fb38-4702-520f-08dd557c4f5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index 00e9890ca3c0..2df6e4035d50 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -70,6 +70,9 @@ enum {
 	FRA_DSCP,	/* dscp */
 	FRA_FLOWLABEL,	/* flowlabel */
 	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
+	FRA_SPORT_MASK,	/* sport mask */
+	FRA_DPORT_MASK,	/* dport mask */
+	FRA_DSCP_MASK,	/* dscp mask */
 	__FRA_MAX
 };
 
-- 
2.48.1


