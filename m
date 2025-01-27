Return-Path: <netdev+bounces-161128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC073A1D853
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD08B1881906
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7E3EEA9;
	Mon, 27 Jan 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JZq3tu+3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JZq3tu+3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BB17D2;
	Mon, 27 Jan 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988100; cv=fail; b=Etyi0LSIoPvXF+jsmEAT2vzeLEvhsGJc0cY7m3dFV99MluHorP+MCgM16Hc5AOiyKKv6Sd5/EYR+KM0qnDeKp3W3GnhUYnum2YLs9qC1XgkVPkjPHm0pWFwGOruFbk8rCLEpXbo+wchn2h2UxU2zimc5XjmjYM3KeYfAZirBKl4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988100; c=relaxed/simple;
	bh=1I8TcwHdx6wqHrohN09M04yZrLIAB2rFJ8KmRtb5f8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1LR4ALSaUrWAV8DwxAdc07x0YNUlp3bOYkynRuMEf13096iTeGRPnhNBnmWnfNzGPuzJrpbpfOu2NIGzLRSDslvZNffyfAiYn+boplwCXjOpyuCd4JLzjdzqCclMlUuMd61SR64K5dDQHGT43BtxVYGxlQEfXMoTKUUPZvRkpY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JZq3tu+3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JZq3tu+3; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=guwYcLVsrpjdIlucsKa9/t8beQkIdb1JRCVwxQ2xDwr6S3TTn1q1TjwBbKUkmcY563wynDohNAyb7Madt7/x7wBqwN8wJGBkTYjV15EiqsZBWDhxx1SL1pMuzPemoae0vcHA+DfOo/0AmZI2Ra58wGwcIoFeemkuLDwo19MtFFB5FtGYCh10Lyvr+DmKoTi/Gcc/NCEnr0O5P2O8Xyo+n7qlatZ3clrWQvCOSpiCJ/W8gwipYq0JD38np/s2ZZMZBEaASuHYMbDvxhAvH4qs3eyNV6k92dgYSZE7nWljb6cND2is0xA1JRNvvZ/Hp0VqMMV+G9LFsWaGi6yKVGlhbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a78Qpx4aGQeQ36SamlYXdYp+hDFub618eEcWBSRs0wQ=;
 b=mEzy1teroHj6K45DsiwfdK50u3ge4vBvMXgxW6dLsetVIBWYNtiyru8T2pOfXzO7/14FeGjOupr8YftpzbOC9dLO7lnCTxtYrqIpsSUU3pMCVq2rGltBU0z2bzZ5Dxq9dnT7qACVmlP28HC+RI9dwLD9GOI6GavlKhpdn0lMmnmnnOkSIoR9hqYvLxZ7qI+kOdIQH8Vg/Xg7wP8u4uFdICxtVtY/N7EOdKCJpUStZQsmtQItwwpak7gaQQFEPZpB46xwq6GUqi0FlUQc++OXzAS3mwzSfPialhm45fYWU3qGzwZDeZ6aKZZS/e5HWHnt6tBE1Zzw4kRWKKg+2suAPg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a78Qpx4aGQeQ36SamlYXdYp+hDFub618eEcWBSRs0wQ=;
 b=JZq3tu+3H7j5jTzL1tEO8f1BhR/jj/kU2u7vMnFRGySq0S7ppRrm0C5DveyNjaKEjg+xhSydLX5Y53VQXtZy6I4IECz81Vhe5nXwKd4UmTJR0xPopunHfv4z6oTZFdLnNhj/OAwzCCu61FlSpecNs88fj7ep3og2s18rM7+QxRM=
Received: from DU7P189CA0002.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::7) by
 GV1PR08MB7380.eurprd08.prod.outlook.com (2603:10a6:150:24::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 14:28:05 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::ab) by DU7P189CA0002.outlook.office365.com
 (2603:10a6:10:552::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 14:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Mon, 27 Jan 2025 14:28:04 +0000
Received: ("Tessian outbound 3f086efbd534:v554"); Mon, 27 Jan 2025 14:28:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 25f10af17a2a610c
X-TessianGatewayMetadata: i0n5Druadf6gXeVJRN3BDnieti7mScMBq6JXcpVfLs7z8YSsjmjsps7st6C6izSofeLbBlMVVao0EFqYy/sEZCPleGde9EXUbFCjrFvsIdaHlGtBN9MAwvwV3LxQigg8mT1xwJxDIY3DLRHY03s2gw==
X-CR-MTA-TID: 64aa7808
Received: from Ld681c6116988.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 103DA619-CFFA-4979-8376-ED7CE4ABA4C5.1;
	Mon, 27 Jan 2025 14:27:53 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld681c6116988.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 27 Jan 2025 14:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjp68Qfh5DTh+5cSDoPmTXLd7xvnM1kBcKKtCbWTXA7daVcf3vOWTsypx0hioo0wouxcSKMBHsdZ8RbFwq8ES+kD7yjij+q8RETkPMQGnfYn8GW2so9hUDTmyrT++Z2UQE6X7R9ykzMAQIZF1TTi8Zqo1Pm98RtOItHxyk0ddqr/NeZmYLFaO2auNmq9Z4Krp7mdkBsNXZ4pHIJt43EkPkV9EvCf+7flZcFiVLD/QYLQ/XH8csR7rMEYow5vYMiBuE/Mpw0PpnxNIl82SL5cruM201tJbO+SP+btM/Gi4cw2okk+A+Uh4CLUsYQrIf7YVl/WlRkINrx2BhpZ717jhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a78Qpx4aGQeQ36SamlYXdYp+hDFub618eEcWBSRs0wQ=;
 b=E25geOq0pPI7D3AToEdcGM9w+XGrnCNV+6xSUvINPCNs2rfOEnt0KbP01g63nd8dDQ2jEGr3EnNjlpszzmZfqtLH3+hEoxeI4Gc88PP1rByFV3DQFpL+gEurnkReUfKAYQXLhfRs2VJ+8p2cGZ06oV7OugfV+ZWdkAmIQXzqbBc+U+BFTlY0SRYH+lam5l3Mn11aQQzdhnVEAJZAByW+zrLHe44b1eWhecb1Znjrg9xV9mBJ29i3lfkgRDWk7SnxgilVJBz28kKM834ga4ORS6qdoNQmhjh41dHKGWWHpAki2pzSrlvSQ/7Uxmd7179/t0I8jna9BHgc+pQ6u8NMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a78Qpx4aGQeQ36SamlYXdYp+hDFub618eEcWBSRs0wQ=;
 b=JZq3tu+3H7j5jTzL1tEO8f1BhR/jj/kU2u7vMnFRGySq0S7ppRrm0C5DveyNjaKEjg+xhSydLX5Y53VQXtZy6I4IECz81Vhe5nXwKd4UmTJR0xPopunHfv4z6oTZFdLnNhj/OAwzCCu61FlSpecNs88fj7ep3og2s18rM7+QxRM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) by
 PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 14:27:49 +0000
Received: from GVXPR08MB7894.eurprd08.prod.outlook.com
 ([fe80::1abd:e6ef:5647:acb8]) by GVXPR08MB7894.eurprd08.prod.outlook.com
 ([fe80::1abd:e6ef:5647:acb8%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:27:46 +0000
Date: Mon, 27 Jan 2025 14:27:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, Guo Weikang <guoweikang.kernel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrea Righi <arighi@nvidia.com>,
	Patrick Wang <patrick.wang.shcn@gmail.com>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <Z5eX4BjErq8FsNIa@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
 <173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
 <20250116193821.2e12e728@kernel.org>
 <Z4uwbqAwKvR4_24t@arm.com>
 <Z45i4YT1YRccf4dH@arm.com>
 <20250120094547.202f4718@kernel.org>
 <Z4-AYDvWNaUo-ZQ7@arm.com>
 <20250121074218.52ce108b@kernel.org>
 <Z5AHlDLU6I8zh71D@arm.com>
 <426d4476-e3b4-4a95-84a1-850015651ee6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426d4476-e3b4-4a95-84a1-850015651ee6@kernel.org>
X-ClientProxiedBy: LO3P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::17) To GVXPR08MB7894.eurprd08.prod.outlook.com
 (2603:10a6:150::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB7894:EE_|PA4PR08MB7411:EE_|DU6PEPF0000B621:EE_|GV1PR08MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ea032b-33d4-4ca6-3ccf-08dd3edecfcd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?cR/3wFrkCjRTk+DOj65aMKMZARg2Cr/d91bG61KBv5d3FvFjQRZYSWy1Iu3J?=
 =?us-ascii?Q?D6ebqT/3KPi6DyTWrBtyrzVYxqInc/GJOSZD5fvgxyNZA8yw5BGu9sAp3KBB?=
 =?us-ascii?Q?5LZtBkH2lyY0S1bHkI2JkgVN1pHkUfAMxXyideiFIaoSGiIfQpjzCi9B7p1a?=
 =?us-ascii?Q?GY8eqnOBrv1iLKnezqKPbtmmIqmDt0XU/ssCWTTzSt1SPbN9SByguYEmSTis?=
 =?us-ascii?Q?255d2j3MAmIQ6m5/6DGLDZg4PldgWnXZKxnyzxnOPZ5CKfu7qWlY+afi85kT?=
 =?us-ascii?Q?M3u8gK5IqbnD8LGWjvFBd4x8fc2ySLGYshkOFQu5fu3+UumUe7aDQ6PQYFMQ?=
 =?us-ascii?Q?sCjRhK9v1JSlrbHwdU0aVWaby2CdkJlAkKokHwNCfY+g0GfcKGvJG8wC2n9J?=
 =?us-ascii?Q?PuHxxOa0ci8kWSu1v2jyX0iFQOWpms5z5w8kHH+hdiAJ9O4jRpLLZFJjtyMQ?=
 =?us-ascii?Q?4VSLvd4Zr/i2B0KyC3oz5YHjGwZM/lZ493dG/ZzPKDRRob+FRV+J0es6ehgN?=
 =?us-ascii?Q?mXntA5Hb2d0TW43iDsva+2LZtzX3mrD/rVTU7Rbs6gExO9xX2DjwlVT/dyZV?=
 =?us-ascii?Q?6nMN50OqxomNrKRWpWoypSX3b2FkP4wQW8sW6lRNt0+dY0jgzq1i5paKcfQt?=
 =?us-ascii?Q?sevvoBtABvpe+cDWl/veO9emJdvLe2AYDLDYG4Y/yFfBfh2AsdI5o9qo4C/3?=
 =?us-ascii?Q?qyFpUKOn2N5IZqSXDJvKCyYbGqu4zLE1TmufZGH65PZDxGw9Oue2vfmemc6m?=
 =?us-ascii?Q?czyCxBbWpkTaB4W5oquXq0iTJpgpwnokjRncvIds17IlkPr1EWcXqvYqiYbz?=
 =?us-ascii?Q?3rfODVatQaMyf/670i/fKqllS+BsNIfNts1UbJYwr67y0JZg9jQ9R+f7BaQJ?=
 =?us-ascii?Q?5X8Oohg6hECMQXOGBPItPc/SmKGGBTnlYvgCNXJPV2gis+WGZJ5TJhDuVuFz?=
 =?us-ascii?Q?KQT445FyCuEBdQFiYRk2rMoets6dBpdIvMEuZSNjgMaFfD/69+DlKwZe7TBh?=
 =?us-ascii?Q?ILrYbfGRpqGqQ77uXVmsYy6U42QwNtWRaCioDJbjGs+beMk7ZOUzjSSecjHV?=
 =?us-ascii?Q?4rJXSDJ613gx38DFwrGnpLZGui2U17bBmsCm61s9Mp3cPkwMwws2caK+ctiu?=
 =?us-ascii?Q?mUNtz3GMIGKyKTT/7T+eKySctU0d0AHPZashv0C37KGXf4aKyvPKV06cMG2w?=
 =?us-ascii?Q?GR+pywFPUIC0DhFtXHU3w+01iGjka8+rAZA73t9Izvo2hOEZkWIsijTVQO1s?=
 =?us-ascii?Q?nehPwNfCPCBSTyrtGIm2LlEvmaslOZwe2slYdfcD2wyGl+nn7EcHHQz7I/Y/?=
 =?us-ascii?Q?+T7XrGdywXe+QCru1iuJr+l0+RtdZGvcISMOJJ6hV7/2c5gcAwL3GBCYhlXU?=
 =?us-ascii?Q?26Wm6OoeNvpwGEvqbVXWoJP7hbjS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB7894.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7411
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150::21];domain=GVXPR08MB7894.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6be52272-c88b-42ca-51a8-08dd3edec50a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sIztOn8fOq2d8HjQmDLZxqk4vmq1MYlHuXkFeMyYwSk6GPaYIWMsyFGLNJA9?=
 =?us-ascii?Q?oe4XNnXFvfvWPWQRL9qvMW1oXHQSLLeMMtPjxPWi3j+MTOKoVrgwfdcjk1ib?=
 =?us-ascii?Q?PyulIb6LSV8W9gIzRNhdCTP3JXsKi0TkEUc2/R7U7CaVvJMhiAfiBYnZq/Dt?=
 =?us-ascii?Q?MxqWprPd+wK6PlisiEi3QxniOwbsFqJIVbjX0pR983xlYFd8HlQDqq5guozj?=
 =?us-ascii?Q?RYh/Ryi41so0o7pDvB1GxbqrmCZZu32CMUNFT9nNlNWUQwkcWdPaT1WJJzQ5?=
 =?us-ascii?Q?P7cflZiHs7JPa66JjbITsNVbe+7vs60UUD9FcB6eTXNjPnUR2KUxGNGpIYyp?=
 =?us-ascii?Q?4FyvIucIr5vmg5Z+JGEZ02XX7osHGGKROQI9mLaQG6bRGIfM7neyG86B1oWT?=
 =?us-ascii?Q?lDfhKws4daE2Iw37CDwYrpQEf5Bi6USAUrZxrz3p3c7INkGmDQ6WwE02ht6I?=
 =?us-ascii?Q?LiAPVrJFzlbB7Ars3KLKyUX/Tt/Ubwe4Jx8mO26E4HRQt1sMZIfBMRKGKt/S?=
 =?us-ascii?Q?28s0Dh4uRWMrfku8g68ACJFP16XwdcImZnPL/2t3tnrtGKcMThUOxwL+OXsY?=
 =?us-ascii?Q?kgAiytSH4TcMQiV1f8QJlWonbeNMUI6q2XpS2wHn9qNKqnjYsI7HcD+ulk3M?=
 =?us-ascii?Q?LFMB5VYVXyjFd8pshCV0oLNGFqFHjf0Q4nNlwpAqV3wDS//eQZMtPQ6o8gKd?=
 =?us-ascii?Q?UUi/DrIQw5cuTtxamzahRYMW2qNHfWTmJOrbVY0YzKL+X2j3rXvtU8XxsRV9?=
 =?us-ascii?Q?QHitWaC/XvBal8YAOLRSxRgFa571kaxBkcoKpXsHMvpuhONtVlIae/+gcpZ/?=
 =?us-ascii?Q?v9zW6GNmp1x3W407kL6fDQFKLut+1c8x95Xrpl8VgPFi8CZDOxBMHP0iUPeH?=
 =?us-ascii?Q?Y3fOO9r2aj3DGB/DJ2d6VfOwVnmKo+dS1yXVpiWKAJTvMM/fLi1aodfPwgS9?=
 =?us-ascii?Q?bp6XkYssbIzoyj91Q/qrcCWcNcBrakOpXlTHl85HEYnDdjgA6WkTxHK4AePO?=
 =?us-ascii?Q?p7Jt2g+EzFMm++VWLG9gQF6LWa2Pd2VE9fRyTvScS+Ct7+9OjPrBv1uhb1eh?=
 =?us-ascii?Q?fT8QOdLOw3vkc3pxFjFGheLZC8gaNCepa3GQdCeGi088T7XfQnvhrNRRhLUH?=
 =?us-ascii?Q?PHGEmvk/6hVTbD5dpQ1ysN/zyoArTh/yz2OcmZFvnmsF/5aDwONivX7FmEuE?=
 =?us-ascii?Q?Ma55j1Q+auXHwRbLyGp1BoZLUQarbc38Ny2dvAw9SOQFj9OLoJ7VGrOA4s6w?=
 =?us-ascii?Q?Ii3zrSJiX5yt8gSTbqw8Wj654HJt5oM1/Jh+poyC2N267uBJIQYmLzdbLtuz?=
 =?us-ascii?Q?h4iDuU5GoZuo3CKIRngLfaDv99fMvEtMNP2QH9lSO/4emK4zLrB5bHoG+fvz?=
 =?us-ascii?Q?dqAa3rxPWIa0LJZg17J+XCTp1yg1rR8/BpicHQZNlAuKSQ4p/nfszG/XwyaG?=
 =?us-ascii?Q?7GWpdzhpeVplkQo2bP5u+HYkSbblt2Sa2gixPOsKKxaigtj/Jne93CzBKQgC?=
 =?us-ascii?Q?/h0gh8TrWEzc81A=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:28:04.6161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ea032b-33d4-4ca6-3ccf-08dd3edecfcd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7380

On Thu, Jan 23, 2025 at 06:11:16PM +0100, Matthieu Baerts wrote:
> On 21/01/2025 21:46, Catalin Marinas wrote:
> > On Tue, Jan 21, 2025 at 07:42:18AM -0800, Jakub Kicinski wrote:
> >> On Tue, 21 Jan 2025 11:09:20 +0000 Catalin Marinas wrote:
> >>>>> Hmm, I don't think this would make any difference as kmemleak does scan
> >>>>> the memblock allocations as long as they have a correspondent VA in the
> >>>>> linear map.
> >>>>>
> >>>>> BTW, is NUMA enabled or disabled in your .config?  
> >>>>
> >>>> It's pretty much kernel/configs/debug.config, with virtme-ng, booted
> >>>> with 4 CPUs. LMK if you can't repro with that, I can provide exact
> >>>> cmdline.  
> >>>
> >>> Please do. I haven't tried to reproduce it yet on x86 as I don't have
> >>> any non-arm hardware around. It did not trigger on arm64. I think
> >>> virtme-ng may work with qemu. Anyway, I'll be off from tomorrow until
> >>> the end of the week, so more likely to try it next week.
> >>
> >> vng -b -f tools/testing/selftests/net/config -f kernel/configs/debug.config
> >>
> >> vng -r arch/x86_64/boot/bzImage --cpus 4 --user root -v --network loop
> > 
> > Great, thanks. I managed to reproduce it
> 
> Thank you for investigating this issue!
> 
> Please note that on our side with MPTCP, I can only reproduce this issue
> locally, but not from our CI on GitHub Actions. The main difference is
> the kernel (6.8 on the CI, 6.12 here) and the fact our CI is launching
> virtme-ng from a VM. The rest should be the same.

It won't show up in 6.8 as kmemleak did not report per-cpu allocation
leaks. But even with the latest kernel, it's probabilistic, some data
somewhere may look like a pointer and not be reported (I couldn't
reproduce it on arm64).

It turns out to be a false positive. The __percpu pointers are
referenced from node_data[]. The latter is populated in
alloc_node_data() and kmemleak registers the pg_data_t object from the
memblock allocation. However, due to an incorrect pfn range check
introduced by commit 84c326299191 ("mm: kmemleak: check physical address
when scan"), we ignore the node_data[0] allocation. Some printks in
alloc_node_data() show:

	nd_pa = 0x3ffda140
	nd_size = 0x4ec0
	min_low_pfn = 0x0
	max_low_pfn = 0x3ffdf
	nd_pa + nd_size == 0x3ffdf000

So the "PHYS_PFN(nd_pa + nd_size) >= max_low_pfn" check in kmemleak is
true and the whole pg_data_t object ignored (not scanned). The __percpu
pointers won't be detected. The fix is simple:

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 820ba3b5cbfc..bb7d61fc4da3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1689,7 +1689,7 @@ static void kmemleak_scan(void)
 			unsigned long phys = object->pointer;

 			if (PHYS_PFN(phys) < min_low_pfn ||
-			    PHYS_PFN(phys + object->size) >= max_low_pfn)
+			    PHYS_PFN(phys + object->size) > max_low_pfn)
 				__paint_it(object, KMEMLEAK_BLACK);
 		}

I'll post this as a proper patch and I found some minor things to clean
up in kmemleak in the meantime.

> > (after hacking vng to allow x86_64 as non-host architecture).
> 
> Do not hesitate to report this issue + hack on vng's bug tracker :)

Done ;)

https://github.com/arighi/virtme-ng/issues/223

-- 
Catalin

