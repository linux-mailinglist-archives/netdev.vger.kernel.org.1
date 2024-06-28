Return-Path: <netdev+bounces-107712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD3B91C0FF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64C4B20881
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A71BE855;
	Fri, 28 Jun 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2atWoaw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B487B645
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585099; cv=fail; b=PBTCPHYtRz+OCbkV6MWueXrqp8BycVUq5YbGxRBQDB1043g8MUaD0hjawoclGbBdKcRMr3GCta42YI4uM6N/iPtSJjIyZchfFOUhVOO56KQvGorihdaswQoslsP4Zp+a314rqUyEYsiNBehtl7EFjkwFJlYGsc77QeqLfFSlxGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585099; c=relaxed/simple;
	bh=WU8JbM8+DASkYGmFTniTXd7bOQ5bCWZtRUjnstj2Ysc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=boU7CiBOPpQcE+O7y2zIQuXooH2FxUGc3rqj3Um2OliqUJUeVzfoekY6cmCKhknblyixkoO8cCGoc0Y34qLlZh2T3ls6TDGb/BO0I5DMUIEGpbrJKx6brSwr+qX2h7yzYILh20bZRBcDQMRxvt7wABGf/YhFh0vMuSikSHgi0BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2atWoaw; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3YjOlCCzYHOUq5kHDR1jvGLDavpMuVuKE/QX1rBXM68ZXk0cFxMYsZoIHxl7VLoe0JMNjthKlrY5xMJ+hToFuCvgvy1hz1hfi2Qs4CgByVHjhyw4HKEhfptY6PxY0+HgqLFyyDh5yCS4TSPF6USc5g6fgZKo2L2kTzxH5Z2dIJmL+tjoBNaFwfoxeRTF9CwydXdcWD8jZUgCQDVGBb6PrROzfe7Md1QXUBWiRjlHDWnOdUKLAe8F8u4gNiKT46cRhZ8qSZCfhukZ3rOtWta//eLt7ZG+c+btLXZfBW8oZNGpadW04QR4fH2ClSEkrN+uDJiZNs2MhMw5PQsu6ToCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU8JbM8+DASkYGmFTniTXd7bOQ5bCWZtRUjnstj2Ysc=;
 b=M4Dez05dGmFs5J5FUfuYFFe8O5VULKsqAbjEQu2+Wz//oVn5WCS9S4NtIXh74RTkq8RlsXhG2JL749cS35AM2u4hfZK5bI+fVenIGkgOOf/ptonXRwdiDfuR++jP2h8eqXKFyuuPBA+nI28vLAYpG6wZQl02+jESJnMwCV1TqhcH20Jq8P4N6HBs/PaSFr/wDgloaUIK1RiebBzUVgkVAfqPkzXtYNjXfUtlp+0hQX7OQn4jPQ60vEpMl8bLRzjLoDqtux9WU4l21uxzFSf2zS3BzFrpYBSl2gdDfvyolhHqFFTkvAAdfrPrSxISdVYCYykr4D1ZrKHn5eTJPnyt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU8JbM8+DASkYGmFTniTXd7bOQ5bCWZtRUjnstj2Ysc=;
 b=Z2atWoawXDUIC3JLX6m+t9tNjS9uyuacCcQV00qu7zlXuAV8dNDJRtPdWsxhFzUhuJxPCN8uQO7HeRqKJbK9aodoCOlgn6ryS+rlmfmIT/oCqjUhFxORUybkzT644DF+cSCDsJtQQM7q70XxHCtpHx/xJQ1SfMvb2AyS7xK6ja3yLJERccaA7ze3YfHIb/f4XyBodyV+pO7mL/1FmIs2zdKIOMod7XpwnzeJTYQEB46eX9qEI6MrUUvsXjvaGMq6tgX7wq36ZVWKaQBtMqbBxzrYKn+s/jQaKdNYvSkyi53/JglRP5vzVnHmkMp7v2Pyrod+yeErKwUGHh3CxWkp9g==
Received: from BL1PR13CA0224.namprd13.prod.outlook.com (2603:10b6:208:2bf::19)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 14:31:32 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::2) by BL1PR13CA0224.outlook.office365.com
 (2603:10b6:208:2bf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.15 via Frontend
 Transport; Fri, 28 Jun 2024 14:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 14:31:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:31:09 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:31:05 -0700
References: <20240627185502.3069139-1-kuba@kernel.org>
 <20240627185502.3069139-2-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <petrm@nvidia.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] selftests: net: ksft: avoid continue
 when handling results
Date: Fri, 28 Jun 2024 16:30:49 +0200
In-Reply-To: <20240627185502.3069139-2-kuba@kernel.org>
Message-ID: <87r0ch87ha.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 33baa5cb-13ca-4b14-d23d-08dc977f018c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iHlLuz2gnVkYT3tFbkhX3B6qjADyRTgtF1jXE0n8Dyg3yDPWIrkE09YZtLzZ?=
 =?us-ascii?Q?opo2MAieKRxYhbuXue+NhSakwCTlv5GQrn+D1iUdC9hy+Z3EdMPxbyCXEpYz?=
 =?us-ascii?Q?ZeJPNjmc2d77kurDeyA85FLf8/15ce4nJNOMShw8SacpPNfbZ0T4CvielxSe?=
 =?us-ascii?Q?MTd8UHpNLOc5+DPPdX7Zvx/4GqnDJUB6uqY9bIpgjOSKW1pM3Tm81A5Lzn/V?=
 =?us-ascii?Q?uMUh1gvg0VQlwVhdLIGdOpbyLuRKWjgrNr8WL5d60i8y5OAQLW7eIAiGpCI3?=
 =?us-ascii?Q?RWqqsdceEe7A6DTJGYnQ0hiNTiIOMyG1AEhUUb9Frn0EDXbJ9MsWpsPvBUlE?=
 =?us-ascii?Q?0rKdYY/RO2UBbe8G5Tbv4qC0AzDOC/AtNsQMjqkfZxc6txWQEjK3YfPwpBbM?=
 =?us-ascii?Q?zLylzPurw48QfLDKV327BBX6kEZautuzRX4ecO8Rntw2Rz5YYej496uJrpUI?=
 =?us-ascii?Q?BCL7Qz/19EQMqAgC0MLrIJDP4XVR6CAe0xwHTPW+zzOUT7GZFRg7tbzSvTbW?=
 =?us-ascii?Q?HrIlHmyzqmY67P2vVn2HBtijEGhZrnUDZu+pQ1wGMvbn2bP7cXiqG8v6hJXo?=
 =?us-ascii?Q?U2x+hJ+L9f/X8Ru72Hz04bHq9M6VMJdoN7M2s6JOzOHK4C2WJMqQ3Q6rvcb5?=
 =?us-ascii?Q?rTGXZQkAsk4cKGvw8RTFzeQvou59HB04TAGqjq+lCQAcP220SXFWm38GWAU8?=
 =?us-ascii?Q?FNywyjG9t+79qa254Gh4LLvdfrJyBc8y4WGXrztMlMqeogY+ddvgZ7cqhCux?=
 =?us-ascii?Q?yg54Iu5tu/2RZJzqlW2X//HFwFChwve39MEHnKhL81U7RLwDhhpvpmfKE1PS?=
 =?us-ascii?Q?p33BbWKgCIgaVV+VWXUakyNjDb69WUL3/mjpvjsY54mSPpcXrocY/g4rzGVE?=
 =?us-ascii?Q?F7gYzR5xcj4O9qlgs8IZIqQv9o4cAmwGVYRC5SkcHmjw8ptLbZfKnk/nNFef?=
 =?us-ascii?Q?p/fOfKUzi14m7RD1chVREjkv8yNsL9DBAqiD8N3sG+jY8yss3368poEHVMYE?=
 =?us-ascii?Q?vPJ1ura1Taaz5nlAZ/646VQdwnsKhKT4K8loAkAxphpSrPwvz2xLTU+eXgSs?=
 =?us-ascii?Q?YGSqDSftrCR8kcKM4m0ZXYQ5wzA2JvNgXGqfT1FSR/3v1j3/cWJ/KbMtEL89?=
 =?us-ascii?Q?vjiXGnbfoDWLDQUwp8W44mpVRvQfGbc3oPOPrO+srGjDAqzayZEDOk0js3yp?=
 =?us-ascii?Q?341DVRp8RHm+Gfojks02SR3qc2dB+s2kdxPUXdsY+kg1fPibvMh8/+/lFUjg?=
 =?us-ascii?Q?amXZi3Gd6yS26Pza6/ZUUta3mgFfx8JfOgDyqeGHbPPAZSig7w9tibyiGTCG?=
 =?us-ascii?Q?HTeS9JIlrEgJypuwdY66Qiv7aunRvxPzl4jZwVuF4GoIuJmDmXZJITYNoSCM?=
 =?us-ascii?Q?AgYs7RAzbQPPBDd2DNlioMcIa7RidmH5m2bGZevPtRc2zEPPBA0eyd3+Vp7Q?=
 =?us-ascii?Q?bBSvStzGSf0AeRezYXXM7v/P9UgaZ0Hu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:31:32.0852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33baa5cb-13ca-4b14-d23d-08dc977f018c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245


Jakub Kicinski <kuba@kernel.org> writes:

> Exception handlers print the result and use continue
> to skip the non-exception result printing. This makes
> inserting common post-test code hard. Refactor to
> avoid the continues and have only one ktap_result() call.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

