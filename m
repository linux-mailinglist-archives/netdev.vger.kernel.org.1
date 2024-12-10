Return-Path: <netdev+bounces-150884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B409EBF37
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A605B160F2B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD391EE7DC;
	Tue, 10 Dec 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HTsdwchI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393D1AAA0F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872873; cv=fail; b=Efzn7M7pJUShTkxk/QdcZrgFLGNEb/3InetcwLurlXwak2SwA39I3ciRL3qrQ5vzRZIWISpWxDZ3O/QLfns0n5Dj4FWvfJtClO3FZlQUyvi0hTkymPR255XrUV8OnEVLHwPvEyAUv/1JY/G13/geTRo4FDUljTjX+35RlmK6BBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872873; c=relaxed/simple;
	bh=e9pY0BNdYFNYKOlRd3FgovUMJh+ymVh3x4GqpACwXvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pIYI5pFkxT6hx38z0Zoh6jL5LigR4JFf+q/WLVUkG2PHoRfZlXIy26eTzDY4JH3EJTWveOrvFg2/xUralPxkmBe8/H3M7BUVN3F7VpXMDR7sMauI1rmd0qmDXhgTT7sfIeRYcrrxKckm5q/WMXLOKgBoqffBe5zS9v+/DeNQlGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HTsdwchI; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kju/jOl44Rf2OeGXY82BoQeoDrsMEI1V9V8fzbqXgxxxaBaKzvfdM+tN+9YWww67AvrdOCJPYnnEGU5kSYHh5bSeas5B+/myYUlZQ3lRpQFA5yEjt5h3SHe5BjYgVZxSxr40k/PWfaKz/EXfMsgk2A5tN/kJFMTxphCABfrnxokDLbMEra+93JgSNbZ69bp0/JvDw6m/VT2jE16A+U86K875zlYc77sBW3txWpy9vr3N83SnhXeEBQ9jtRL9T/cNWdOvT51k9PQgZ3Jy6JPBm9mPGs+ZLMrHLKZANnyeJKEZEK3o8GsIgT4BN+s6D+CmYALvGJe4DZRiy5MxK9nBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4KHxoFTK2dRjgIo60j2qn9Kubsu9hH+8lQts2BDyEE=;
 b=VUt0i3d5qFqJtQ97oI3NixSSu7FbzQvoOUi0q4bSIRw3941NHsqChl3MRr4vZROfLRcQtLUT+wNUy6efLjM7cTSWr5wsgY0LiGj9eWEwA/6USsIHRRD74kO0eWazkxeM5GWQsnjh69apFgc0Su4HAI662RQ7u/M3h33/Petpb6fuXskuKZZyH1J2GtcWM+bW2uuTAUjpIq1FGCClFwQ77Db4yrREwD1ZpqrG4tyVWd5Yjr0aWTsb5wQQFDlNH6XBINe5pgRLQrTh+29CGEvPOabOf/NH8d4jE9s7/rO/xGbBej2gFvmcC9PUzLckwS5D0s2bilsiJ5vvLlBfCpCz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4KHxoFTK2dRjgIo60j2qn9Kubsu9hH+8lQts2BDyEE=;
 b=HTsdwchIlgHqtNXYxtv9bv9bEdEIpxu9Thqu4N7JC5AQiAkUAcF8DwAywp/R6nA4mK6wmrbbV8hAl1gaF7zVpeWgV31sAXSeHK8sKOb9bXqFvm9CHS/Y9KI30SKRuQ/k5tQtXiuv5N+EgpZT3ThAiKfWUS3ja0RC6I1DJYmyjKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 23:21:08 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 23:21:08 +0000
Message-ID: <b044a65f-ad68-4d30-9e98-876de8f55faf@amd.com>
Date: Tue, 10 Dec 2024 15:21:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] ionic: add speed defines for 200G and 400G
To: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch
Cc: brett.creeley@amd.com
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-5-shannon.nelson@amd.com>
 <4acaaf9e-211f-4bc3-9886-a05cd5d0e7c8@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <4acaaf9e-211f-4bc3-9886-a05cd5d0e7c8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8864d9dc-b9ac-49a0-0fdd-08dd19715375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGhCdDh5WERrVzM2N1cycGhsZGhuai9QclhrVWFib2hvVlV3N0lCei9nR014?=
 =?utf-8?B?Mld6YllVM3ZWQ1J5KzhFVnV4OUlSYnNRQkdmbi9SaE4yMGFZVU9OY3Rhd1lz?=
 =?utf-8?B?KzI5OTA3Y05MRGdFRjk0SzU1N2RWWmt5eDczSjZ2NVRlalROZFdrc282RTU1?=
 =?utf-8?B?RGdzQXFXZFRGbmlUV29DVDVEY2xUVGhYdGVFWkpBREgzY05uSHgvQVR3WDMy?=
 =?utf-8?B?NUt3Y25nWEd1RWZDR3hZWHlmUVFuYU40U1NPVWVGVTNkelZrd0hDL2ZQZHZn?=
 =?utf-8?B?ZlRsUGI5UGtFcmJXSXBvTHVhSy9BbVA2aEkwcWRyUk5SdjY0Rlkwb1lrVE8x?=
 =?utf-8?B?OURNTE44NU1VRVYvQjNpbDR2QUV2V05jTEZUb0xHUDJHMzFJY0Nmazh4Y2RK?=
 =?utf-8?B?dG9WcWxZcmJNSUlncGtIaXVLNkgrRUVnWEJCYjB3WlQ2RXU0SHJXaEE5dUdC?=
 =?utf-8?B?VVZ0aDA4Syt4MEVvRW5taEk0MVNaNEI2dUxTUElJdi9kKzNjV2JIeGYwUkVR?=
 =?utf-8?B?NGMzQW5ibWo0OUphRHJYblRha2l5YUtSY3BncG5RWXVsczNiL0xUK2VDRVRB?=
 =?utf-8?B?OU05NVlpMzVyenY0b1hrbmlWVWdYTG5taXhDdytmcWNvbUJpbm1uNVdRT0Fx?=
 =?utf-8?B?czhuY2doem1SZytKMC95UktLNnE4VWZja3JSWHA1TndWWVJHR0YzMDA3M3pP?=
 =?utf-8?B?dXBSRUs4bTF6NUZsQi9Gd1BKTXpDMGFxbEMvQldmWVN0R1lzNGlDQW9wS0g5?=
 =?utf-8?B?ZnNZdEVUcFJFd0NjVndSMlNEUUkyS2hBUkxjTnJoNGtpWEU4ckdxVmlTT0lT?=
 =?utf-8?B?NWRRMXNRVTlSQTVuQnh2ZXNSNWFWV2FGOE5XZDNmdnErWDhiVDdrLytKdU42?=
 =?utf-8?B?dnZGSkttazQvNDM5U1p1MVh2R3I1NUpwQTl1amNpRGxtRmRoTlVPNlpmZ3RN?=
 =?utf-8?B?emxxSU1rRk4wWktRWCtyOXdhejFKRkUwQXp1b0NwMzhzeWEzY1BFV0JyQTA5?=
 =?utf-8?B?L3loekc3anh0ZmxnbUdQWHZ3WldtSFhNdjZyL08vUUJKSFFvNkdqYjZFYmRB?=
 =?utf-8?B?SXlHTldveUNLM2VLZ3M4eUs0VjhUaTczeHdqUTNTQThCV1E3KzN0WFZCMStu?=
 =?utf-8?B?bktZL01ubmRMVjF1dkpOcFAxTThzeVVReDhKN1p5bDgwZ05QeU1KUTdmMXlW?=
 =?utf-8?B?c0h2clpmNzJMa3B1Uld5NWF5ak45R1hPTWlST1dDNTVac0JMKytBTWxnNHlY?=
 =?utf-8?B?cDFOYmNUQXdES0lPczRXK20vdEhXcTRXWjA3NjRVdjk4U1lqSjBQZHVDMk5Z?=
 =?utf-8?B?eE1EeUt6L09mOFZ4QTFBQ0dDamljcTBwMmVmNFd6cmRzenNsOXcyMjR1K2w4?=
 =?utf-8?B?M043WTZBTTZHY3B2M0JGc0pDd1pwZzNnem9MWjFBSFI2Y2thOE5lclhjdlpi?=
 =?utf-8?B?OGdMcm5XZUs4T1FRdU5HRWxpeHJKYXFEM0dZZDg4ang1NjhGZlJqZ1RpVUEx?=
 =?utf-8?B?MUczdm13MmZmaUl2c2h3cGhPRzJTSjRnUFI5K2M3cnk2bS9MNGx6WEMxLzZG?=
 =?utf-8?B?c0pldFFucW1qN2I3Zmw5VjZMR0ZDVlRVUW1sdzZUbmwxZ2VJYlhaZzM2MDlG?=
 =?utf-8?B?TkNaSGVDRWdNMVVKYk5pSmlkTzVsRkhkZlJJaDVBaThCcEdKNjVsdXMyU3lG?=
 =?utf-8?B?Uk5SWUt0K0RPQVozT1pXZTg1cFNXNHF2enhCa0lCdWNkQWdVZ3RmM1FZU29D?=
 =?utf-8?B?SDRQN05VUUtHaWxrb2d0Q0RyM1NxdVRyQ0ZXelNMaGlBWXdPZXIrMHVuV0Ni?=
 =?utf-8?B?NWJFaVFkUllBanoyV1R2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGU0RjZWdk1rSXhyZjZ6R2RmZ0h1bUxSUUc5dnlJYXVYZi9TRnlTN0UrY2p5?=
 =?utf-8?B?eFo0Tlcyak5Tc3F6dytzM0RyeHJ2Q3JlVGZjaEMzYkRsQWRpTnNjaUpIL1Mx?=
 =?utf-8?B?L01pcnM1T3gyNktHWW5xcGVMR2dVa2d5RlVwUndwNVlra2l6TGJzZmcreEJM?=
 =?utf-8?B?ZGtxNUd0MlU4bWV5MjMvcUhsdjJhNVcya2V5WFR3NlRGQmd5RzBMTW9lYTE2?=
 =?utf-8?B?V25vaGVsUi9HSGt5WFBDZ005ZHEyQUpML0VNNDdVN1RyYjJ6cEFpSzBYUGNo?=
 =?utf-8?B?VVV5SXhKT1FoQk5UTjU3ODN3ZkJsRzJjUFI3Zk52VTVJaVIxMFNKZHVqdUEy?=
 =?utf-8?B?ZDJDblZhWE15c1FBTG5YeVAxSk5MNFBjRU9aUWk2TVQ2ekcrNDljVDZ5SGQx?=
 =?utf-8?B?aGpJdGNpdmxOc253NU0zMWJwMUJ2SXhuT0pJWThRc2hMWjBVcVZyTUxOYnov?=
 =?utf-8?B?czh5OXFuRk5vMFFGRnhPZmVIVXVYWThlNmxZR0RnYy9pdXJGa1g4cmEyajdj?=
 =?utf-8?B?TEJRdU1GMlpySHhEcXhaaWNOc3ZLOGRrWjJGUkFSMWh4dTBuVXdaMkpVV3F5?=
 =?utf-8?B?NlE5UUp0V2ZrWStQNkFlQlNuUW9iSFZBWVFzMWtZbmdjQ2Z6SElqTVVwZElq?=
 =?utf-8?B?dlE3TmRGOUhhaGRXcE9XZm1wVm81dFhneXhNa2pZaTBOVGdFUjhuN3NWOXZj?=
 =?utf-8?B?bXdubHJNNEJ0T0x3T0FSL0lZUVNWbklXYnFPMTcvWjBNZTVDT3kwNmd5VTFM?=
 =?utf-8?B?RGxMbjRzdkh0NFhFbmduZ2xmWWJWcnVSdlh5OEoxKzIwdVU3YTFGajdLMU1v?=
 =?utf-8?B?LzJ2SVgzVWs0QmNDQS93N01hQ3EzcENkMEVoVWIrdENuSmVRZnUvRHN0RmZq?=
 =?utf-8?B?Mk14VmRMYUdId0NSU3lwRk1QMCtjYlEyL2lkMm5nWFdZOGdXWHpoN0d0TkdP?=
 =?utf-8?B?WC9MdXZ2a0FTSzMwN01TYXQ5Nnl3a2hlSzMwSVhDNU04K2xpMEdNTHVKblFh?=
 =?utf-8?B?M2Rqd1YxQXJFNnlTcXF1MzZ0dGJ2bWtyeEp4TDVOSVkyaTlJbjZIUDNveDR1?=
 =?utf-8?B?d3p0U1JJUGFZZXk0N2JIQ3JMZHN3azN5SVhEOG9zRFdQM3p3MER5b3hrZXpY?=
 =?utf-8?B?WGFGWHcrZHJ0R3R2a0cvakhEWUJ2QngrYUE3R1dMS2F1SjhlMDZvVkZITVdi?=
 =?utf-8?B?YmE5OFh0eU9JWVErTEc5MHgvTFdDL3FkOGVKbmgrY0c4bU9lTitrc1k4Yjc4?=
 =?utf-8?B?anhPenNLempqSmJFbENrcUhFZDVFbFVUWHo0aWp2bk5hVVcyZjBEbkVWYk9K?=
 =?utf-8?B?T3J6VXhqWHVVOERtTktVNzBuVWhCOSthMGswR2JVcTlxeXdiYnQ2RlhlZyt5?=
 =?utf-8?B?bEs3WDVxWFlzblBaTmsvWkpiRnJnOW9iSEcrVGVNcVZWNkxoeFd3L3dicXNM?=
 =?utf-8?B?YWZmUTJrL2tsbjFrV0F0UmJzR09xVVZjMUxkdWNKZkVLL2lzdjViOXJneWpR?=
 =?utf-8?B?WjlmRytyYlZWRFd3MTAwbE56blVmSnJIM083MTBaMCs2bHU0RXBIa1FCZitI?=
 =?utf-8?B?MjdRSEZBc2V4MVNPLzF4TTlkUE9OSEtPQ25iMFFHQXhCaUZ4TlI2MUQ0amRP?=
 =?utf-8?B?Y0wwZ3A2cnBmY1FEODNpTk5mekp6M1JJNEFpcytDVHFCZ2gzaEZwSE5uWndP?=
 =?utf-8?B?LzlQOW4vMTZoVWdmaDRJbGhqaW9PZWk0R0NCamFIK1FGazA1QzJ3SVNjM1Zu?=
 =?utf-8?B?SzRTb1hoZ1lCR3JHeG81UzlHdEszd1gwVFdMblFFbzN6ZnU5WjEySTN3dDh4?=
 =?utf-8?B?cUFGV0hGR2RXM2w3NThQYXZGRWlSMTYwQ0JJSVlkYUViSFBaa1hpYUNhbWF3?=
 =?utf-8?B?T1dXZFFYU0dFcVhxemQyV1hwR0JhWi85emNlMThXdnFSN29IUEFnYjZDYi96?=
 =?utf-8?B?VW91YUFFR0tIOFZDeG1nQmo5cDUwYkk4SkpXWHpUTHY1UFMxTURUc1QzczZa?=
 =?utf-8?B?MUU2cGlhTEk0eFhKeDltdlBualA2aGVraCs0d2Y2RGZuOVVPQ1R0Q2FYUXBN?=
 =?utf-8?B?bGltOXRFL0FxNDVuYmVHc25TNjU1eExpdGVsUjAvUlFPNU51cmc4RWNsaVBn?=
 =?utf-8?Q?vbmgwSkift5wDw1n5xjdteOk8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8864d9dc-b9ac-49a0-0fdd-08dd19715375
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 23:21:08.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpXXBpTA1x8VnJbPzKYuSZn7hO86yVJzCC66Srv+Qtqh2KGlxU/KRz3UpBBjCGf5deszkes+KBhCorHEeTg59g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976

On 12/10/2024 2:53 PM, Jacob Keller wrote:
> On 12/10/2024 10:30 AM, Shannon Nelson wrote:
>> Add higher speed defines to the ionic_if.h API and decode them
>> in the ethtool get_link_ksettings callback.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
> 
> You might consider refactoring the ionic driver to use the
> ethtool_forced_speed_maps_init interface at some point. See 26c5334d344d
> ("ethtool: Add forced speed to supported link modes maps"), with
> 982b0192db45 ("ice: Refactor finding advertised link speed") and
> 1d4e4ecccb11 ("qede: populate supported link modes maps on module init")
> (though it looks like the latter hasn't moved to the ethtool function).
> 
> This saves a bunch of text size on the module.

Yeah, and it would get rid of the silly CamelCase code complaints as 
well.  We'll have to take look at this in a future opportunity.

Thanks for the Reviews,
sln


