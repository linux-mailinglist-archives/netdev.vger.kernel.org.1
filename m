Return-Path: <netdev+bounces-215217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFFAB2DB0D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466E0A01781
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0692EE610;
	Wed, 20 Aug 2025 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DC4vsa5K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A12F0C6A
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689466; cv=fail; b=GB5UH32poVP/2gzE1eUL0dMjbcn4RuiCiY1xqL8Fl/DSCADm0kaVtPLFwAcOlc+80MQ82qTVECIaVeWKXHP9c5PmmJuJz3dfF+hZmTZvJWxo/cteT9BIebh16VzYgUtYf/DHvwHB/eArb9Cr1W0CaTLWO6UQ6cQIVShdB4t+VYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689466; c=relaxed/simple;
	bh=N/LOlZw+ZEreXLn6SdU85pR6PZzLdBlqYgUq3iM/LVs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FFHwK9mZsM4Mj8zSRtjrlMsVIXnB0HwX4p4A5oE9ZmWJYwLbsir4zp8s+t3Zy7Lli1mn1+0YQOtjzRcodvh+TDPjPRn/Bj1ykC98mVKglHXSH3GiFgHI7wW9PSZ6CKMbNjdO1AembVvOxNfFFVlEuKSJB2xqdiRxLrKe02AbjGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DC4vsa5K; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBZ2B43/hOklpvczC09MK2GN6YsrLmHv4pCkqsW2v2yasBzUro+apXDzER/g2rqtrEvEKxRVTksyA9cyixBFuYvlHgIty78IVRYixc8mKKCraCMJZRxQ5bcNGay1P60skcLKc2FOtyl5PEHNlsDeodRrpmg9ptVH3VbntXzh7ONIY9BVU5tQxHkteni4h+I2b/+r57xAfJbCv55lEPBHQ1p8XLjnlLWCxwm4pAqXYL7zSUonGLO0IVKYAA4oF2KGZBIk4okQl/p70pYgTNeHJpbR7FcWaWm+Xyf6zRQnDJ9XBmCramc2uovSY1Frk67ZKP07NudJrXLGnVPsxmF52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhOKIl2qbkv/bsk2vyTESC81E+hAm8D494+a4PkiDmI=;
 b=t/lqoKkWxjbRdX3wqtcYkeIzAbzo8m74QcgG/Becf8a6M17jaC8WbjUE17bkQQdMg37qmzr8aig1Q0/YyrmVom7rMPMHgiIIWWL6Fza4wny9eMAW2YnziU6BaOH0+THjr877N6EwaDp2ky26sg5ewF191SxVZ7QiRTWKP4m9of0ODNVMpKBVwkYWSZESpFzO/1/7Hp+ntMDBSOlukagES9mJjR/P0vS4Jt04GM/uQpmxmcSKhfOnaKCxQtncC/Iz5n7vI8LKwAD8CWVfvHs9lBmUKxmdmtZTu93Qysl1cldrYeyQpTcO+/syFW8eywqzulFJeSIq9g+nBg3dApc49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhOKIl2qbkv/bsk2vyTESC81E+hAm8D494+a4PkiDmI=;
 b=DC4vsa5K1+z/qlyuYUmEQvZFUElpfhoeGIJJKtrm31QZIC2DyJRA3lPzELWomPmyJnBBJZhAJq7/cwGQDnCvlg25NKcvPG6jDiHp+igsh88JfL/rD2RqHzYq1aeZqOOcgJBEveMi8vboyIwFcXZMTBF8LZW6htsuXKu1Dt3gr16iYY4fenQGES9wOWMvJece9RUFCASwinXLL3pLwESoaZvbvxnXGybXQpTcARpCtwvRn82psBCrcVZMuWOFMz1LiS9eY+Kmm7FXEg9Xd8PjWMdkaPi6dF4fuTEJgQEH/UsY83zNHFoGUCcFi4tkH/pQV2TAgVC0ecwSsLQ0iscphg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:30:57 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 11:30:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 11:30:42 +0000
Message-Id: <DC77YRDDLDV2.2RNW77Q8HPLTH@nvidia.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <almasrymina@google.com>,
 <michael.chan@broadcom.com>, <tariqt@nvidia.com>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <alexanderduyck@fb.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next 11/15] net: page_pool: add helper to pre-check
 if PP will be unreadable
From: "Dragos Tatulea" <dtatulea@nvidia.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <davem@davemloft.net>
X-Mailer: aerc 0.20.1
References: <20250820025704.166248-1-kuba@kernel.org>
 <20250820025704.166248-12-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-12-kuba@kernel.org>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 55475a2e-c670-4508-64d8-08dddfdd0793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHhCSXVLODhjTHpyd3o3YUc3U3Y4Q3c4TW5MT1JxUE44ZlREYlNyWGNBcVJN?=
 =?utf-8?B?bWROSXNpK2Y5VVlqR1VkbHJNY1B6VGllMnhaUEU2V0JCZkQ2dTVzUlV2Njlk?=
 =?utf-8?B?bmd1ejUzYWNlbGhFOHREMkRCQVEzQ2QvMUJtMFFSYXdFeW5aTDNkTlRhYXZN?=
 =?utf-8?B?TFRpUUcyTTFtcXRyNlU3a01JckhxRnd0T0dtQ0tveVRXeldyK2dmcW5JckF1?=
 =?utf-8?B?TDVueGgyRTFJRkFXRjRFYXR4NXA5L0hKZ1RwM0ZYTU4vZm11eUFqckxVZGVl?=
 =?utf-8?B?MXEyQjJTWm5QcHBhSVREdXdINDJzRVhFUFFNOHBvM1lPSmdVVjdUaHhYT25k?=
 =?utf-8?B?L1lXdHhOS2d4YUYyUjdIc3IveENJSk1KTk5UUE9yVGFMWHNZMmpxczhkNkJ6?=
 =?utf-8?B?VDZadzlEc2FCYS8wQXRYNnU4S2JCSDVHWHpLQWRNSjhBSW92Q3RrVkhwaktt?=
 =?utf-8?B?TEVISEJSTnNUL01yVitaVDhyaHR0NzNDZFQ1V3hNOFZFeVlsYWkxd0czL1Jj?=
 =?utf-8?B?by9zOG9UNEdpbWpMbW1NVzR5V0xDLzhhNmVJaXlseUlmM290N2FxNnpIM0Zi?=
 =?utf-8?B?bnpZanBIMkpaZzFITmlEWlBGWjljU1cxMkRMZ1RaOHFjSXdsNTZ3eHh2ZUJ5?=
 =?utf-8?B?Q3lvYk9YaUd2eGNuMjlQRWZ1ZWp5eDBKQTVrZUdIZng4YlBoQ3NqUHpRSERT?=
 =?utf-8?B?c3VRNTVISTBKZFcrMk5UaWVaTXJSNC9qUlhFcUhQQnViWjlZd245VXY3SkhB?=
 =?utf-8?B?YUI0c2xQNTR1TnlITnQ5NEpuZzFMMS8vR2FrRUdYZjc4V01KRDJnMzZwYU9U?=
 =?utf-8?B?UWh0clhxdFphQWRmZGNCZzZLVENXTnhMUDAwNkNiVlpIVzh3TmFKREFKZEVU?=
 =?utf-8?B?bGh2K3pTVWk3ODBhd0xCbE5YS2tPeVpuNGFPZUpoeGRKWk8ySDRJd2YrejFF?=
 =?utf-8?B?QkVyVytxZTNnNll1SnYrb2wyZmw0VDRvc0tIeHUwVVgrN2JnZE9NY1A0empr?=
 =?utf-8?B?cnFHMWVUdDhIUzFUT28rcmNUYUFCVldOQ3ZnRVc4UDFlaS9Ya3UrUlZUcXlP?=
 =?utf-8?B?SkpLTFV1QTZ2cG11WFQzY2RiNGh2a1pHaUJ3WGM0TXExVDY4cFlzVzFTL1NM?=
 =?utf-8?B?a2djc3JhWWgreU10b3RrY1FBTHMxWVUxVmxCZitFS3F2ekRacDhSNmlGZmYy?=
 =?utf-8?B?RDdOSVZzNzI5VjRmV211RHVJNTBjWUQzZW9BSWtZMVMzaXJJRFBqVGdHS050?=
 =?utf-8?B?ZXVkVHNINlJiaXM2M0FXdDFBcG8xd2k4VWdvSDM3dUdUUnpKUzlEeU1ZUElu?=
 =?utf-8?B?UVZheFpIRm00K3YwZ3M2UERnRkVyNjZ0M2lHUG4vb1Z6OElpQnNtTUIzNG4x?=
 =?utf-8?B?VWFmcEtjeUo1RHp3eU1aR3lwVnZmRkNWeHhuV2JSZFBjd2JZNkVHcUdnVW5r?=
 =?utf-8?B?WlZ1ZUZ1N1NXQU5wbS9RU2pPNmlMTjZCVmI5cTVzZ0RiYnp1L3NEYkZKVTJh?=
 =?utf-8?B?UlZkeW1jYVlRejcxOHRraHQ4ZnFpYmFGUmxTdFpDa052Yy9HTkhZTjIzRXdj?=
 =?utf-8?B?MlhXc1FucmEzVDFKTzFmV3lWWndLcUcxUzBveGljNEh3cklTQjcraTBNeDRq?=
 =?utf-8?B?b25OY1pYUkVTU3ViWWMycWhHUWdBQzVmZFdCSVg5TlJxVzVoSWwxajZHNUZR?=
 =?utf-8?B?UDEzS1o3cFRMcEp5QU5YYWY2bmVLNjN1U29UTFpkN2FkblU0SmlqUHNYZFdP?=
 =?utf-8?B?cFp0c0xaaFozbGJoUEhycXhBanJBcm9SaUhKTEs5UFlIaUFGOUJWcVVWQko0?=
 =?utf-8?B?NXVOYTJwWk9ERlhmeWNkM1dFZi8yMjI0d0JLekdZa2ZyYTZBc1VEYzlUcThp?=
 =?utf-8?B?ZTVLRytkdlZKc3VVSGVPUmFQSHh0am9VTGZCS2hrenQwRTU4cnRkd25UNHZr?=
 =?utf-8?Q?7mAw64TMGME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dTZzc2UWNJRUtxaWFaLytSSWNXNE9XU1FsaVA4TTlGZS81SEhaL0ZHY0ZW?=
 =?utf-8?B?Z2Y4Wk9wUkQzVGpGUVZ0bzBqT2RPU0t3MXhGSmMxVGNTeEZQL1I3ekhLN2Ji?=
 =?utf-8?B?b1Z4KzJTN0pVWWlIcUs1d1RkK0sxWHZlOTNURGFHaGMxQnI3dnovS3ZyeVpI?=
 =?utf-8?B?eHJ2cnExdEtJNTBFbUx2aW5FNlNRSlBQaHdkeTIvUWtod3h6UnZLMkU4K3pp?=
 =?utf-8?B?WFVZaW9kOWhWVUNJRnZaVll6VGJSV3ZMdVoyVElTcTZEakpxcm9ZWFI3R0RB?=
 =?utf-8?B?OC90eWRoWHBmQnZnQTZSRm02UnhWQnJ6Z251eUREOFp1QnVGbS9MMWlLb1R6?=
 =?utf-8?B?ZFYwVy9Sd2dFMitscUdyUzE4QmFxS3M3RE1VVllJVTZMSm9qc1NtUnBVc0FV?=
 =?utf-8?B?bzBWbW9EOEx6QmIzR0Npbm4vTkpvUmJYemNRb1dWOXdHS0J1MnBYdG15RUM3?=
 =?utf-8?B?cnZMRk9pR1BsOUhwTnNsUnpnb0RFckwwOUhCVENaWC9sZ013czFnVjFOSG1X?=
 =?utf-8?B?T3lVQUlycWZmeUczOTY3MkVTUG5iVEJmVVdpMWRodHlKTE5TaTJzUmVzdEd0?=
 =?utf-8?B?YmJuSTVWNFhOcVg0MEN2bEJCU2ZHRE5DQlNDb0ptVjNsQ1ExZU1UL0JPUG5o?=
 =?utf-8?B?eXZTRVdJQXJXUitnVVZLQXlSd1ZuaGo3STJ0Z1c0UTQ4U3p1N3FiVU9DUU1w?=
 =?utf-8?B?WUhiMklaeVdMaTg0bUlKMytNNWZPenBIUkxlK3dVQmpKbkpMVXJWWXNjOUFB?=
 =?utf-8?B?WWV6YXg1MGRxUFloREZlREN0alZNNWh3bFNVUUtKY3M4NzZEckN4UHREMFNj?=
 =?utf-8?B?cnkyVkZpNWFTUnBzbUMzQ0FwZ3pBaEQ1TUtuNXFGUGkxbUV6SzdOTkxKZG1Y?=
 =?utf-8?B?Z2Y5bExEaEhzWlJIcDFUVjh4S3J2bjB1R25TKzI5dDF6R2VYUGZmRlQ4Z2ds?=
 =?utf-8?B?TUlPbEZaVEpVbEN1YkNJbkNkTkNYUmZiMzAwUGh2YXl2M2Z1SGxSeUJmdjFU?=
 =?utf-8?B?bnRzQnFEcmtMeUpOMDRqZWZ0Wk5PNnBJUjcwUHRUVzdHMWhCL2xHNnppM21s?=
 =?utf-8?B?cnhCeW5jaTcvK212YWlmVzlDSUR1OG1ENGNOdjJxSXhRRXVCcGo2bG45c2FN?=
 =?utf-8?B?SWtXKzhtZEo5cEJTNVNZMkgyQ0FRZ0FjTnd0MUV5R05pbTRjcWpteDJaWjR6?=
 =?utf-8?B?Yk5vYmh2VXFpRTJkOXdDVVZ2ZFF4K3pzNzVIZDdBeWRNNm9UUElGWWpyUjdZ?=
 =?utf-8?B?ZUJVbzduVEhJUHZuUHRIOCtvQ2kzVXliWjFKRjZoUE40ampJelJRdWQ1RzV0?=
 =?utf-8?B?T1Zxd2d6bnNKSVhJSllQVWJjQUNmRzR1b3NFUFFFSGx0TFg5OTNaNXpmV2ly?=
 =?utf-8?B?bURZR0R5dGhTSjcyMWpIRVpoVWo1eStTTTBqZjN3SzFqSFkxaHVaZ0RpWCtM?=
 =?utf-8?B?ZktvZ1JwcTJJbDdBcTc2WlFVTUM1Vy8yWEw0RC9mdFFnazVmQ3JNZjhtb0pu?=
 =?utf-8?B?YTFoUWpMakY4dEkwMTlzTFU2SmFENHdtbWwxbWszb1RpTHBGZzhDMDloWlB0?=
 =?utf-8?B?Q1V5eTQ4Z0ltV2dNdU5qWTFmNzVVTlZMYTFxdHZoL0xzcTVDdHMyaFZ1MmJr?=
 =?utf-8?B?VEhtK0gyQjlHY1JieU5LdWtUeWplN0lxUXgxQU9mbW1LTWR6Z2NVclFlaDd5?=
 =?utf-8?B?Vm5xRm1UTXBKN2F2dVd6SDhRTlE1Wjd6aWVWa1pOWXZLdW14WVZLNExBTjZF?=
 =?utf-8?B?eGRsdXR0NE5Hb296SzM1U0lFNzQ4VXNYWkJpWE1YNWNaTkVTNmJUa0dPTTJr?=
 =?utf-8?B?YmE1YXdPUVd6TFkwYjM0TUxTeTYvellZeVlDUG5ZRnk2NkRtdENTeWN5eHlZ?=
 =?utf-8?B?SE16bU5CQTdoelNWdWFRUnl6bCtDR2FlM1NJWXdGOEFDSGxQaFpMWmgzUCtB?=
 =?utf-8?B?V1ZraHNuZ3ZMcmZEaFYvMWVNRklHVkdYTnhocU45Vnd2ZmtwdW1uazlUV0pv?=
 =?utf-8?B?RGJIQ245SkZKWnZNWGpZcXNOYjhWejdWV2FmZVlqVGtpL0xPVE5uUjdsTWd4?=
 =?utf-8?B?dXdRN3JCUDRzWHhsLzFzeXkyRWx2N2dGNEI5SFBWNkxJLzJtS1QyaWZiR0tu?=
 =?utf-8?Q?agTmBN87EKbwh/vi9ywAxpzZR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55475a2e-c670-4508-64d8-08dddfdd0793
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:56.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOez4HKaE5awSTLJ6c/9iadaPNuzWSrGfrmWFi5L6ynu51Gw2ks7HZjcbdM01uHijgwUFv6SLI80ZG5PC7sjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

On Wed Aug 20, 2025 at 2:57 AM UTC, Jakub Kicinski wrote:
> mlx5 pokes into the rxq state to check if the queue has a memory
> provider, and therefore whether it may produce unreable mem.
> Add a helper for doing this in the page pool API. fbnic will want
> a similar thing (tho, for a slightly different reason).
>

Thanks for taking this up!

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/page_pool/helpers.h                   |  9 +++++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++--------
>  net/core/page_pool.c                              |  8 ++++++++
>  3 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/help=
ers.h
> index aa3719f28216..307c2436fa12 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -505,6 +505,15 @@ static inline void page_pool_nid_changed(struct page=
_pool *pool, int new_nid)
>  		page_pool_update_nid(pool, new_nid);
>  }
> =20
> +bool __page_pool_rxq_wants_unreadable(struct net_device *dev, unsigned i=
nt qid);
> +
> +static inline bool
> +page_pool_rxq_wants_unreadable(const struct page_pool_params *pp_params)
> +{
> +	return __page_pool_rxq_wants_unreadable(pp_params->netdev,
> +						pp_params->queue_idx);
> +}
> +
Why not do this in the caller and have just a
page_pool_rxq_wants_unreadable() instead? It does make the code more
succint in the next patch but it looks weird as a generic function.
Subjective opinion though.

Thanks,
Dragos

