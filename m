Return-Path: <netdev+bounces-144572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887949C7CF9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1503E1F22D86
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89871206514;
	Wed, 13 Nov 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4aSj21k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C315AAC1
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530050; cv=fail; b=OqJO2h6juDc/78QwiXSCVrpKdqSCaLc/Pfu57cbOs49Qkll9ZjQyt2aHS6NZ9ExeBGP378burc9odJ3IKrMpYiiedbIXmNJ8XN4oeM1T6kvJ6UtjuT6TgIhsbLjmnM/d09CXrj1owvUjjwnrWaPmi9cYecHsDqKRfXeFMlerYzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530050; c=relaxed/simple;
	bh=mH4MrCUtDf6/rxfRCFUkKxJy6q16vaSzIA5BTOtdOTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akmK4LoB3CECYfJp/GuQNX4IC6u7FHHvNDO3Fydcl8SiBOKr3Tj/QxKspRMFZ0y5cy4M6cM/boMhN5xuOAPJtHCkBsHTfpUBkwaBCI5fc240mJhngOYETaGEB78nPWG2+Ho1gV9iVEdCHHJgt3OXAwdnBRUZvEtRXC6q9uilT2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B4aSj21k; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDx75I6Zn5SVlxQPaFqAusifn8a9QzYfRPOIB68SO+qPUk4S8BBO1SHhlh1IsujlXgMQsoAt8OklC98Rg7VmKV5cKHufIYz0mbYkDEV8HAeHytSqrt5kSW1gkMWt5j9gE/khAc/CaSWBquxuSLVw82wsBunogDWnyZ7LeztkdrTkzHcxKtcaadZrJTn6OgC1qX1TOMTKzTSF2HxE+sQsUksUvzXzYa4s+3ZRcbhgDp4Gm2lfQVdWRl0l8LsOmvoqeTzAXYsjCkGLDZmm6mvgSMNFe3gSxWZRZ8ben7wLHcvXAFs5kIGEaR8QowuCbYZSIC2VkkBKeU3ATcr9z9KH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH4MrCUtDf6/rxfRCFUkKxJy6q16vaSzIA5BTOtdOTE=;
 b=gQO6F9uHHMLclpD3McoWy0PWtnfYJICQ6mDRDdzKC17Ni8lEv/0nCRqbrCKcuYURpKBRZCKfU/GfLEgn4zJnlaMockSqPdUqgb4FnjsHsgdFRHihu7o/Cz56csh1edsGuAAYaOr06+CogH3RgWFmrXTm5G+yUAVuvd8ji9mh9J5jFiK1syD6qVLKBbh6ZNtdQdLqRxHyspoUd9fAbxfkPUvS/no/5vr+DA3XBOfAF/HlnG36mdr9ztvDxkO9ACVN28Of97kqxLweGTw/WDx4ceKG4iiv5kW/SQ7Acs9b4gk2Omq4aLnT9cpHjeeoY6L8Btg7R+2SCXQWf8jsXWHzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH4MrCUtDf6/rxfRCFUkKxJy6q16vaSzIA5BTOtdOTE=;
 b=B4aSj21k2P1iwWMtp2xSgnrdLMlJePvnK8xrI1BtW+q9nmxuLxy24B5JIs/OHQJvy3waHSF1Aya90OPeC8DfLaognOHDsebRN7Twa6QKAeVUYFqj2hWqoj+XM3yhaXEvF5mZJ9al7U+ikjw2wp0gEx1LsUP5zLqUGXjVsNNGwlTMJ7DDxacQH996pm0xPxOwxxmkCljUA2B7EtD4iYjw2a07Pt5hDwM+oH8h2xdaPZf8B3CM9I9v9lrEpRNpw13rnAO4JVg4oRWSgbQ+jUYIvbtddl18rORkilW1F+ql9qewcW4E/soiXU5vXuoYt8JSl+BDah9VrvRypXsFR6+TFA==
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 20:34:04 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::40) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 20:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:40 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:38 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [RFC PATCH] devlink: Introduce rate domains
Date: Wed, 13 Nov 2024 22:30:37 +0200
Message-ID: <20241113203317.2507537-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ad679f-182c-45c7-55ae-08dd0422834a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBKHFrjZw8VLgjSBU3OfzJQNI88rFf9vuL4NMuOqFYgo4+07Y27jqPZ1yBi3?=
 =?us-ascii?Q?uKlPCXRlk8cCCGT1dK2HmYx3s83iXQl4yV2Uq4zB1Kf6bQ8ZjGyYJufFMq5o?=
 =?us-ascii?Q?HcednH0CZFM03/hD9eaZZNDY4hxZdYx2OcrWFJHpr0E9W05ED/X18fgTJkvN?=
 =?us-ascii?Q?dcSCsJJEjwj3OjeJGWGc9Wh0r0eNUaFEX6PG2OVTGXC2dtEta/tdhYoyRbKj?=
 =?us-ascii?Q?WClEpoDJ7OE01pS4QyBnJW/4XB4S60U3X9UsqbTMljcDhVborYi4IigdlgPi?=
 =?us-ascii?Q?oXIMBzy2Eajl/r9IodgKbZQ6BTFfYsZnNeYhV3pyz3IT18bsrSWIIbJmSIWx?=
 =?us-ascii?Q?oQq+tSDlCElJKxfhggRRJr3oTpIqZ+ylMuoq8Xmiw12dj2/RhUfYUX3QtLDi?=
 =?us-ascii?Q?dEMNeG46Mkys47fuDxUKmhvPSVXGIfklkTVJBM8CQrpwZvVA9y5sVjMiq98K?=
 =?us-ascii?Q?LAeyzau5BfIAHh3X9SGRzbI/JQzERmVfA0FYz6MUWLxcX/4vIkCvcctXMn4o?=
 =?us-ascii?Q?lR4YGu/aY4LL6Ppk9AA3Lyj1BsyHqQ3Xq+wvfZaHAKz4+oAk3W6Mvr0qXsu0?=
 =?us-ascii?Q?rW/yxIMKx+/zId55ZIE6liVcvtRAxgRmmw5ES9BSZkAdRjNb80Brc2P+Vzbc?=
 =?us-ascii?Q?OuedBoNIypKxpom6NRJxVl8O+XZ2DFvY07MvRaBzk/vIdY5wnwwEb6ePKVVv?=
 =?us-ascii?Q?cUp3nYM8ZdkMvuEghQr2JwkszwRcF6GNLu9lAlma/13QYN3UDXgNOFRwN3Br?=
 =?us-ascii?Q?RnZAAMxj0h14MkqFtxcjWsbkRJLBWbfFS333wXCJbXYN4EGaznM2oMDcXoYA?=
 =?us-ascii?Q?toPcgax3jcdl+ibt+3H5/B3JSH5UDI5ETl4luvcyBSvAdK5nMcE7p9H54753?=
 =?us-ascii?Q?AZD0IfmgBsAydWV/14v+YTOv7DfN/HpogrxnakAXh1Fj/2yz9fUbrkun8Y0W?=
 =?us-ascii?Q?81Kbm83KvkGzniyiSlAZ7jVznnx34SU+ISQCHSG06rlmj6tRRHRDEjqC2VpH?=
 =?us-ascii?Q?32A3BDcWQKwu3M9D2urxufJEhdGk5MfGTwq1jUbdOXeRKe+CgByz3HcNrgSl?=
 =?us-ascii?Q?pHgEdhAO1lOu1Ls3rNSzbrcTOFdvJrd1KMTB95D9SRd+gM1nCJ8nQabZNwok?=
 =?us-ascii?Q?CEt6EIwtpldjOr42LpHkHpILrmBozDV1unSb/GMCwWmTifZepEnMdrFzH5mF?=
 =?us-ascii?Q?MMAAXZsbgtBNegfNgkVKm02QsLcwzop6RJmUybuQmbfBAFEeJ9hP9Y55GFL5?=
 =?us-ascii?Q?TjUHqNENFba6nY0TkDG1CPM00zDmXniO9KMW/21zVBSIEXeNwXm2AXD1rNee?=
 =?us-ascii?Q?9VWQyKc7xKOwu9T2kqXPADg7j+oRlGsH2E7iYquGmnV4d6cDeGeoyGUiYljZ?=
 =?us-ascii?Q?3mW2nHi6evooBPEz9OuSLFHRBcd8PIANoUPw+atf7LjXS5nATw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:03.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad679f-182c-45c7-55ae-08dd0422834a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335

Hi,

This patch series extends devlink rates with support for tx scheduling spanning
multiple physical functions. The full explanation is in the cover letter and in
the individual patch messages.

More context for the series:

I have tried and rejected several other approaches, because they do not work:
1. Acquiring multiple devlinks locks. Requires defining a lock order and gets
extremely messy really fast.
2. Using a single global rate lock in addition to the devlink object lock.
Cleaner than failed approach number 1, but feels like a regression back to the
global devlink lock days.
3. Using weak references instead of pointers for parent relationships. Doesn't
work because I couldn't find a way to fetch the associated priv pointer of a
parent rate node from another devlink without acquiring that object's lock.
4. Jiri tried a more general approach: defining a shared parent devlink object
to represent the hardware. That object could then be used to store devlink
rates. Unforeseen complexity unfortunately threw a wrench in that.

The approach in this patchset is well tested and it works. But after some
discussions with Jiri, he's not too happy about the added complexity so I'm
sending this as RFC first to gather opinions on alternative approaches, if any
exist. I want to ask people if they think the approach is good and if not,
perhaps suggest alternatives.

Thank you,
Cosmin.



