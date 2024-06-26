Return-Path: <netdev+bounces-106902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E876F91805B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B931F265D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F611802C2;
	Wed, 26 Jun 2024 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLVBZiE1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C47149E06
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403119; cv=fail; b=Xjl9Thx3se6CtbI+uuomTJl3T8ws1xHSYzx6eey6el1W+S+wLTKAc4bvy2Put8xGkaKpSDpDEKGL4FMG3SQT4nS8wL8sMyRMUtJQqMtDYzlDRnIiezLaiSEJM12v01ndDP/WGQ7UI+B89EdEakOLW1EFgMzw+l6b0YhFDwvi9mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403119; c=relaxed/simple;
	bh=Y3ZXxlnKKzmFC0fqnTwo3mRHuS8t3uSlnmJpreClzl4=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=BZfJ5id2CZC/AbNZ81hBqgXvydIobeZCZnKAfWdqQpwQEyxFLSCjcd1jLLzpecfLwdXAQ6lVn+m+RJIkI1vUlh2yA3eHomwI+0mr4YNLPCVpIwkq2V2b9ngAX99Dzeyr+D8jGR5REUqHez/Y+bcPF7vgJt57UFSNocs6SJafYOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLVBZiE1; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPR/lsR9yUWPKaHrMzl1aFlrwqHAL/wko3tJq+e5FRc1G9OtiFroVm3vRDxqcElz2leQXdL8OpM1RJ8wV0/Y/yoFdoN3h9T1RmeYJmdLuoiFLMXEKmKP1jo8a9IddciTKmArXFcXSvlJrOir/oEqOhNXmrLSa4u3uiZyf4Y/Ackzb/rMjVg4qlKoNJfdzJDEOHR921avZhkvhyJFegoS/qykD02xQWM5TsrskxTrucOg0DW6ZWpO6SNJ76/sQwdaNbHQ/CTcLmQ8wDhCIH7oekg8sfQ4t8Zceeb9WQZJOeBPzjHo5Z5NQjWqi9Gi6TkPnHkkb3ysO9CAV0PCV3HGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3ZXxlnKKzmFC0fqnTwo3mRHuS8t3uSlnmJpreClzl4=;
 b=VqsYAI5ICxKsEpBQswlq2sx7gQMzZGzq5gtt8RiOmLUVRDCsb+HZH6l2ezQpzbpMzt2qGC0X5lM8wiy04HpepM77hBobaER7tH6jiRotBEsv9rZEMoRf31t23ysjG6WQSx9y0bgdRKFguqxTUVrx27kkn58lq83PAbReQ/ZCURzpYUmJmntHA8aj8hD5F4jskM8Q/hXobFP0tI/XHrBOLECbCJ9LToxL4NngjKPfsuxKbzy6BzbnOb7qH7U1zy8/8Y+FDWp5YWd6muehBBzbcrFmwuO+G4Q3GfhwYBgIPUfk1sI0yxp6Ey1rYMwwHxNavQ5K5CTkPALBhr0/ZI/NaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3ZXxlnKKzmFC0fqnTwo3mRHuS8t3uSlnmJpreClzl4=;
 b=DLVBZiE1xTuRCfQxmsmJH5+e11bfW0LDfKGI8o5Z28FpQdzvv3/kssM1431U6KSTjPM/Km9C1MOXcwrG/v36V7RcOURp63oGoVaW+LvSodlYmLqd6h18ccKAb8S2oTtmxZvjyxiPT0gF2Pqdyel5zQQ1YR8zPuYNc8GY/9UlWZ1q/oT/w6lXnjC3B78BUcWK7MBZ+421Y7zEXPM+bVMzdeaz6Tn1dulaLzZBDf52QwputTkNsLDowW6INVpLwp/Cg+LpRcxS3lib5UC2B1oOILDnZz3YU17jW3MgQ93VFGPrl/eHp9qu0QH1LXgjqISg2AmcBDWx6shqPL1zlJB/LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 11:58:35 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 11:58:35 +0000
Date: Wed, 26 Jun 2024 14:58:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: gnault@redhat.com, netdev@vger.kernel.org
Subject: Matching on DSCP with IPv4 FIB rules
Message-ID: <ZnwCWejSuOTqriJc@shredder.mtl.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO6P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::9) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: f06c2fd6-0ffa-4b01-d2a2-08dc95d74ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfSkQdBMk+0tk917iBBMivDiot60sHa6ueINKje/uh1DzMHgDSUh0047sKZk?=
 =?us-ascii?Q?e3gXa68RQMq9QKlUEbEVRROyYgoQiJ3SMf1t5mn0M82/GTojtknxfBc7xUBv?=
 =?us-ascii?Q?uGCroa5cotEbmJfi2vZDu8LaTWc6uP02DWpTvokpFuOF8XXMS4PVCThvtoKy?=
 =?us-ascii?Q?iJ/hd6awzYqARWWPgD7QAgLiiMCDxPVHbeXXswC0NMG//+PIlEnVBlpcdtUB?=
 =?us-ascii?Q?ujAQb3NE8tvn00w2uAp3c1lRICJd8jRkuD6b+iZ4eUmOLOczo95+Vc0czeX5?=
 =?us-ascii?Q?q/wPJF6eo2zUu4rEelcC63ogo3JC/jVDoJLxFZ4v1Aaku1NOApW028P+PLcP?=
 =?us-ascii?Q?M1pXMmfgX7n4ZOkcCGTWCBwwScNwU9i3+ZGd7Qv/nltbn6o2WferiO6S0nLr?=
 =?us-ascii?Q?IOQ9CKjPHWz2Te7B0KuQPN1+10VZxovM8JhA9BrHQHV1ivMG4JSFYdlf1bLm?=
 =?us-ascii?Q?mtnJ8uY9roVXIW7zXuAm/uQeM7IUs+fAfAJvuqwCVdeouOGQAqWGDyWKKzXH?=
 =?us-ascii?Q?RTNydGeMrhPWFVE5ewyrxwAEWeWQLmJK7nJbeJEUzt8Bq6XV9upOxRkCkTOY?=
 =?us-ascii?Q?EcOMiP+upTgGIDS3HMEdMC6ybUX2gwbLBieSjyFRGL7sa/EV+rivjg/giHHa?=
 =?us-ascii?Q?6t7GgWugd/i78sjZnu55Mr9cU6BzYuEqhKFoO6GWtt/2g9v5AtDP4fpYr5NC?=
 =?us-ascii?Q?tyTulWCqzVQGn+aZHoeOw7A4cxT66otaDsnCih5MOBHr+AmaEmJAvFpJ6KUX?=
 =?us-ascii?Q?L2Ywe/zFL8RYmdUEKyPQE2u3qWg7T39BuH3Tms1BWhvcN+bUIyQT37W6Ugkz?=
 =?us-ascii?Q?qERQaRvtpT+BFJCt0kAZQyB3MzHEXsMBbMY2UU+tIDe3YZYEGmvDv6r2qvxm?=
 =?us-ascii?Q?Z+86UTxn7hdFOWX9TNV2M91Gkc6nf42vfiz8F5vgWdttfcZa6J8JNzZQwmvI?=
 =?us-ascii?Q?VQr7CyCgCp8YfWkzLBmFfYxkKbJK7pBxpiuHKur9zLM8ftLI0hvoQ4Quo+OS?=
 =?us-ascii?Q?OJ3tE42dgxZuvcaAjLoXd0ojTl31YVl6oZKCT5a+KSqOrdZiZbQ1LSjuKAB6?=
 =?us-ascii?Q?X0/BJXEb/ezqy174t6Fe0VlGoj5buh9YkLtiskYpchdeXvw/9yUlp37d/+f6?=
 =?us-ascii?Q?eS1u0Nq9w7NqIO6R8eJ6iIZc0GD4GSvyJvVfx71MPy3v+zU4w9mUUQ4hz82C?=
 =?us-ascii?Q?awZfBNNTidA8ZjSsspF/on0rIOu9042Txlpzk8xU+s+AUF4AH5NNnSmEUAZ5?=
 =?us-ascii?Q?YqEQttRjbZOUI1PIx2E/OugXVopgG7l3+auMO5/tJZYFNb0sWeroNTTiEmYk?=
 =?us-ascii?Q?tFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhSUxb6VflL5uowJlNUeWP90/vaI65ldqQucv0PnqAKxU7ZUlQOXRhhbmqX4?=
 =?us-ascii?Q?loDJ45zlhpA5cY+qnN4ORtQ2elGrC48Yq8SMVnyApTfcKPClJUTSu/zlJZ/s?=
 =?us-ascii?Q?5mp4I30021mGqDA9okusIcCzv/waOv94HwnHIOn1mDT9QrCQTDpUaqeHHUzA?=
 =?us-ascii?Q?ydrlbRc9YoYn4KtggAInopLtXuClbMCiBQT7hRuV0UOc5L2qXZ2vxyvOpziu?=
 =?us-ascii?Q?85Fn/tyQ3SRg9qmN8c3zckCbRzBLvvo0nbAAKe+shqtWRDL/M4LPiIh0cJ1r?=
 =?us-ascii?Q?yXVNJttZlQSDx08/0pvsAPf0L+G5BtTaLZkcQ+8kfBUHAVPDF81PDC0IZulD?=
 =?us-ascii?Q?tRYUrq7mct1EHoOkZlc5Q6H0uZKUw1j61o4I4cmlzswUPcIZ8Z8JEgHfViPO?=
 =?us-ascii?Q?ZT9UKTA54L6HxUKlsQOdClgFcXcH4Iw3k/8thgU1hlEjjOyM+dyF8hDgugRb?=
 =?us-ascii?Q?Ql7mRE1ytI8mJNTMSzGHBSU+OaFZmjWOD/hGLBMvyBlHEv4FxbvzYOS9+3Xu?=
 =?us-ascii?Q?klRzwXgz0OFlqiYMUq3dEyDrEK7e3XsLCxI2ZGBbRNxSrd2YSg15t0mGuM9z?=
 =?us-ascii?Q?L9K53MDpAkE9uhcYphXWgUZ7GqmFzeNL18IGmvIDGYTt92q+9HoHWrxwfjRc?=
 =?us-ascii?Q?1o5Xd1S4U+Xx5MPbUrvj48wCUJfaZ7TXcS4pRv9SRSepopY2nr5XDyEW2Lt1?=
 =?us-ascii?Q?+SsbfVlG19RxIAQasByX5FSLPWoIv/xkKnzE5odT3yEptkAJ7iUmgYgwQqie?=
 =?us-ascii?Q?vsLQ9RblMatpACdreQDi9/+R4FcP4CFHkEssed+WLFLucH0MPloHkCNIgE+0?=
 =?us-ascii?Q?EZgn1qc7xPl/bFYCWZ/NVJEB8vfKYf9asyPz5OL/2qXMgyorQla9teZXE1ha?=
 =?us-ascii?Q?LMomfVE/3ppvqgYcPyVpHJVauVljq83Utz1zaA4BxQ6JyWRsF2ECSOVQbuDX?=
 =?us-ascii?Q?uFU9Tdg9g58Gv4w4I1hmGaQiGz7E7ciP3S6Wr7GiLVsQuR74nbYF7K6kcFby?=
 =?us-ascii?Q?foGX1Qdtn63Dkaz1ifllKYRLGsJlwjPkLBbbrs8RVs8KIsyeN3bumvITgwNM?=
 =?us-ascii?Q?LLCHyZeOscQcB+B06ZYDfRfSY3r8Yy2slgHW3fr0HbBpTsE9NrFKdtOhQAO1?=
 =?us-ascii?Q?Dt5rM5ocQ5cGmAmtJbIBRNaLEVaGbYqdDwpGY/dBxDrvSX+y62c3Im5Y5LJU?=
 =?us-ascii?Q?Wnxzt5RMAnp3GFHG8F+qcxrfZ/o/msdju8iYBU6oj6x0odnGCoESSQzb8/fg?=
 =?us-ascii?Q?/tLwUMfkrcTn8np3rIw7qlj7VaK2C6qL4tZC/1HArh+hnFayRD9KOKsyi+IO?=
 =?us-ascii?Q?hA4yhF8tXBah0ZJTlgTTfuwPIuN6N8IWqY5iW304phbHq2oHaRYnpMVBGxLf?=
 =?us-ascii?Q?yoUKRUMWwmeZjtAOrUIm14o6RmjCEu6tNldQY8yXP1ov7cooCeVyT/f3qGsi?=
 =?us-ascii?Q?VRvXZX0SybrRcsZp3swL1vPweRz3QdyrTv8FxkK02f5Dq0AMPyImd3WzB9WE?=
 =?us-ascii?Q?HfwTk0SRdhTzQi5NSKCrbhLx0wc+XAwDCpxx0cDUPR3lKc2fodgI0cshiCd7?=
 =?us-ascii?Q?EFS+aXFKBvwIfZL1DUQETFih38itU/6BU9vJSOBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06c2fd6-0ffa-4b01-d2a2-08dc95d74ead
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:58:35.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BfKtwqWrKPEZUOEOy0qn44dtURGvtHcFRarL9pL8YawRdXYyi3caN0MuxSmPOTtie6rgIWBguqcQa8Nq831oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

Hi Guillaume, everyone,

We have users that would like to direct traffic to a routing table based
on the DSCP value in the IP header. While this can be done using IPv6
FIB rules, it cannot be done using IPv4 FIB rules as the kernel only
allows such rules to match on the three TOS bits from RFC 791 (lower
three DSCP bits). See more info in Guillaume's excellent presentation
here [1].

Extending IPv4 FIB rules to match on DSCP is not easy because of how
inconsistently the TOS field in the IPv4 flow information structure
(i.e., 'struct flowi4::flowi4_tos') is initialized and handled
throughout the networking stack.

Redefining the field using 'dscp_t' and removing the masking of the
upper three DSCP bits is not an option as it will change existing
behavior. For example, an incoming IPv4 packet with a DS field of 0xfc
will no longer match a FIB rule that matches on 'tos 0x1c'.

Instead, I was thinking of extending the IPv4 flow information structure
with a new 'dscp_t' field (e.g., 'struct flowi4::dscp') and adding a new
DSCP FIB rule attribute (e.g., 'FRA_DSCP') that accepts values in the
range of [0, 63] which both address families will support. This will
allow user space to get a consistent behavior between IPv4 and IPv6 with
regards to DSCP matching, without affecting existing use cases.

Adding the new field and initializing it correctly throughout the stack
is not a small undertaking so I was wondering a) Are you OK with the
suggested approach? b) If not, what else would you suggest?

Thanks

[1] https://lpc.events/event/11/contributions/943/attachments/901/1780/inet_tos_lpc2021.pdf

