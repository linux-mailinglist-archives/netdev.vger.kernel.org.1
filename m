Return-Path: <netdev+bounces-171298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD48A4C6E9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F23D1895596
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E122DFBA;
	Mon,  3 Mar 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qKvWM2jn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBAB22B8C1
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018441; cv=fail; b=tSwRcjCJuOaV9w15AJv4oYJrL7rynZEwyQEwMe1sKuJa5E2eZqYgVm84nMbgqMcOw6y8kB05/6YSf54o4Vd5WD7stuil2A2UQiX5k4SvLt6IBgaxHyw6HscDHeh4XbCqabypIPG2mQcADAF8getQGvXuoWVhH0F2PuzrM2qldlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018441; c=relaxed/simple;
	bh=KqWU23so06PZFyLp3WE3tqYxDkHldCy1P3kvJDrQbl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkciB9jyXxfUciXbODTUyhFFwMNwCPQK57mbiomhrUAlmKTQc0YOcQi3fxbtQlboMm1RJwDfn4c2SAvu2djMSpPbRXGfO2RbYcKeoz6CedkHR01My94HlLYr1JL/XwC7PY5YNeioCbXJ84UUYia4DK3Adl4+bbbD9MDTfacnONk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qKvWM2jn; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaFOMOU+O+FUYoQdwaWs955To8qEKCdL8HlPfOb9klnYeo5s60FdLZummkC/IjnBPp7LLWtx/h3an2LcGa5FQJiUAXrnK0ywbBUCzAfqPAFMJaY9sNTi5elbC02H7eG8RoG43nNMbCOOoNBoU5khU784T1FKAhQcM3NVBjTycxUjO4rsLRXFra5Gwz2NqAkjdNp3vNilAmDhJtbvWOD49U0e9boGX+kKWLC1zJNKDOH4Rmpvp2zXp+t+wEGfIPU7N8XR/JinAjKvew+QgCntbdBmtNFiktY9U2prDIk0DAv+HK1Ke8pWa0Zf9Dz0oMCLez5yiVcwb+FBGyZO+h0r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D/S7GQPnLgXnKNIubANsV15nNWPvprc+rgWdPTONCA=;
 b=kDxo00rXZXe94twRXJOXYvIC8KIxoaFUYyNjc/UBVewn544iGt6QNDiGnS8ttGPxFc0t+aaFjRjReTyXxleXMrSvByewQSKbgViFgbiU8l5yehHjeO4GaPTWL5kpesfGv5LCxFNEZQ1G5qQ4TVgmnjpjCWWk/ms6StnMh/oRcrLJn6jH+jT8GLl6BqU1qC9pSa5HMXkBpmyWZSMNLRWn3M7MF6Hkgs1NIH7pjsQRXYcwvk5EcEMsgEvYrxQaAUze5z/Zr6LqZ0hXA7vFbWsZ0h6PKPmo03osJPuZhwoK6yxfiCukYEecfBSbow/IYV9IilJvgGrpdwklxztgCnIu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D/S7GQPnLgXnKNIubANsV15nNWPvprc+rgWdPTONCA=;
 b=qKvWM2jn5ZLw2pfbrRGEd1kMl/msAIR9LwvWMHN2CIT+wPiTavmA7Tl1IPUxkCvDB35da32LzKTeUXHAdpNFSeN/kdVwnP/JTqAxJgQ5i1I9FiEqqAXSVlgj11rg+IFmTEkqH6BV++Ub+5onXlUhpl8KHAPKXi/yiv1oHullfdV9jaERcd70t2tI+nSbKMgsRsheEclp/zkVW5AplIS0dvNEZRcQo3hMOY7VBR9iyjuwB6nzYgRNz8P+3RPvrnUC0xnchMCfYb9s8iMT4OTYFveOUZ2VWQOFZjeBftu/8OZZyxFPhb6UcGa3Y1w1pF4q5S7AuT7tvOugpIFnxYeI9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:13:53 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:13:52 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v4 1/3] posix-clock: Store file pointer in struct posix_clock_context
Date: Mon,  3 Mar 2025 18:13:43 +0200
Message-ID: <20250303161345.3053496-2-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250303161345.3053496-1-wwasko@nvidia.com>
References: <20250303161345.3053496-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::15) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cfd729-fcb7-4a9c-6e03-08dd5a6e63d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXFpMkRrUFByV1lxZW0rUUZHN2xSQndaU0tnVkY2dHB5QXFyYzVSaStGbENM?=
 =?utf-8?B?WWlvN2tnVzZZTjZ6VFdhUmo4M01NK3dBdFkwT292ZDh1YW5SN3pZTHFCUDZt?=
 =?utf-8?B?ekFHdm85Y2IzRG44QXNFZjNhbUlMV3VIdGdEMWhZbFhBajE2aFQ5QWxOMTFr?=
 =?utf-8?B?SE81UTF6WjFiUFM4RHJuWVI5L1F2bDB1bEsxQXc4a3IwQy9TUmpEZlo1ZW5S?=
 =?utf-8?B?Ly82Z05XYnZmOXA1T0ZpUE9RYkdGY3lTMHE5YzB1ZEQ0USt2eVdjM3g2NVRk?=
 =?utf-8?B?d0tPNmhyTmlldW16YWl5Z2xpcWV0UXlCQXh1dVNOM1gvWWlYVCtZMDYyOWRp?=
 =?utf-8?B?N3FkaFFSbk8wMXFWQk03QXNDRmczOFRPeFBpSUR4NDBpY0lkTTFwc1NJejZu?=
 =?utf-8?B?ZW5XVitQVHMxUVJCQXJtcjB0N0xVU1BXUDFnc2pqOVZqVmovMkVNUWlMTndL?=
 =?utf-8?B?MmJQSXc5WWRKMXp6dHRQckg0YlpjeGZsREpXYkFYOWtGalJFdUpUdmZQM0pn?=
 =?utf-8?B?Z1dxczJBcGtpQm5CTVFHeTFGNGFoT2ZNTmNsYW8vV0h6ZndFRVFYK0FIZTdo?=
 =?utf-8?B?VnZselgwRUt6UnNTbXZIbXQ5Mk9OTjhEdzI3UWkvV0plREhDdS8zTWgzTjQx?=
 =?utf-8?B?Q1YwaU4rcytJclFVK0swK1FIYmZ3SlBlMVJ1L2FEMTVlT25mT1lmQkc0VjRl?=
 =?utf-8?B?bDNkcjVWOVU2RnNkY05tVlNrNDRYbHMyRFp5WTlZcnFlUjJzQkJkZld3TUdO?=
 =?utf-8?B?SllWUUlEVFhtb2MwZnRscGpkWlZ2cG53eDVsN3JuNnpseXhxMWQ1WmFUWkkv?=
 =?utf-8?B?MStUQ2tzdUFnNDVzSUVodzRYUnptQWswU05kVVRYVEhaTWtVREdSMmNlYzRS?=
 =?utf-8?B?MW1IKzF4NmJqRDRBWC9YeWF1eXNmRFhKQXJZN2N1TFdpRnVES2NrYmJvM2FN?=
 =?utf-8?B?L0ErWmNPT2VKdGFZSHJzd09rVHk4MHRSd0o4RmhaczE3L3FlUlZPRXdoNHpU?=
 =?utf-8?B?YkxKMFNuNTVuZldVM1JUc2tUNzRZcWRLcWw5dmY1VGNESThTN01XejJpS1dz?=
 =?utf-8?B?QXRBd2kzcTNuSW9kZjhCalVHMFVVaUIxbjQ3bWtoNThWZlhKZ3AzdThCMm5I?=
 =?utf-8?B?RnVOb0pRM3BjYk9tTnE3b3pPYjNtbUpWbHNvNG9wZGtxQUphSzA5OWFqMU5w?=
 =?utf-8?B?eDNuZU1xUWFpYW1kdEY4Ni8xd0F1WUdOOTN1QUFoeTNlc0tqM0hZTnJjSnJI?=
 =?utf-8?B?N0RGaHRscy9SVFMrYWZicTFDRkMxbFpzaUE1YnZyVlNIV2x6bndpWUtJT0Jz?=
 =?utf-8?B?ZmtpWFgrRVA5YlFjdE00c3k4YkRMU0FRZjI5SE95dmVERVNCaHNmT0pPWERL?=
 =?utf-8?B?M05MN0FQbDl2RnhRZCtyWWFVNnpjTnFNL1Rkdk1UNllRd0Q0Z0F1UFY5UU9t?=
 =?utf-8?B?NmorM3hVZlpKdkIvTStNMHBJN3IrWW1SYTVobXlHdjBkZnl5SjNxeXBEVVVH?=
 =?utf-8?B?cWxmLzA1TnVqMnlWRWhtVFZRRlpKa1ljaXhURXE3dnVkQ3VhQzlybVIxNTM2?=
 =?utf-8?B?c0pCNVdLeHpoYTRhcTBBMHQxbUR0Sk9Cc2ZEVUZUQXpRT3AxWjlYWkM5Sm9E?=
 =?utf-8?B?WGplaW13QWJINWlRQW5GWlRSMzVMaTBNdTBibWlHZDUralZHTkl6bkVPNlBu?=
 =?utf-8?B?dEtPRElaUTRmbXRtVHBUK2ErcFVmYzQzTDJrVjVveEhMRmlrQjRsL3pKWXBR?=
 =?utf-8?B?TWhwZyt6QXVCalRkK0xwNWZwVEdOSlVVZjRwZEdZbm96NlBZK1BrV0lzemhR?=
 =?utf-8?B?M2NicXJKaW9SaWs1MTc5SGlVNm1ZMlR6Y0F5TWxlalNOSlJZTmZhYjZSa0ZJ?=
 =?utf-8?Q?8cnM/drl82z8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9nMjFqMGhSS1Fxa200RjliYytJYktvSkpldy9oL0NETUF6ZDhWa2tCcmkw?=
 =?utf-8?B?WVg5M01IOEg4M3p0TW1MQ0plTmFzS0gxR1o1Rmp3ZEZJR0pJMXJtdFRuNUlN?=
 =?utf-8?B?QmJuVjUwUTN3SEFFdXkxN2pRTzQ1c003SWxTVnNFanptMnlaMVpYb3RhNzRU?=
 =?utf-8?B?ZnNlQmtwSGhSR29WMnhwQURKb241aVkrODk3WXR6anBnNFBxU0FmWnRDWWc4?=
 =?utf-8?B?NmVNbG1sR1hBbWhWclRSNmdmUzZjelVrMnlwTzhkSy9TOTVwWnYzTDJmQXdF?=
 =?utf-8?B?dWFaQnJGRkttUzQrRUpXRE5IdUh1ZzBBV2Eyc0NVYXRmTlViUWRPTXZJNjlV?=
 =?utf-8?B?QVh1QVJxRHYrRVdqaFAvcGkyTWhvc2hIMWlLUk81TTc2OHdyMFlSUVErVnZB?=
 =?utf-8?B?dC9oZ1BYbldyem1SMnpaWDEwZGZYL1Q4UE41WVNPV2ZZeGNUUy9rU09STFhr?=
 =?utf-8?B?b25GQWNnSVA5K3lzZVp0SUNBN3NNMmlmc0JPZ2hrckZERDFwdHJ5QUF1TlA2?=
 =?utf-8?B?SnQxRFFnc2pyUExYblZ0Z0lBTm1XUHNnekRuY0Zpd1JKV0dNVmFtTk5HTGgx?=
 =?utf-8?B?SjJkQzF5UURPckx2UVRDQy9MYzg2bDlDWHl6dzc1SVhYYnRTLzlMV1ROOUFj?=
 =?utf-8?B?T3hhN2dLT0hhakI4ZEZyMXhYSHkwZWJmR0lBVWJPTHNmc3lTSk5ScEhLSUNW?=
 =?utf-8?B?ZXZ1djBDMEpLaGF3cEN3RXZ5UlZNdUVub3ZxemswUUVVaHhYNmlWZ0EwRi85?=
 =?utf-8?B?RThKdlkvMC9DVHUvSXAwenNZcUwrZUErdHhJVW50K3Z1a2dPMlVZZ0I1OStX?=
 =?utf-8?B?MlZMOTlKdElJcTBpNFFsMjJpMlNLc0xjajlSOG82ZEYrN3c3TUxwekthUUtZ?=
 =?utf-8?B?eWp6TCtoUm5jVXlGSWVHRWxxb0pqR2ZLTExmajRnTE45Y2w3ZVdIaVpPMklQ?=
 =?utf-8?B?cXNRbGNqcFdtUmtJY0VoQTBaMk95cTJIUTBFOTVaK01sYVFVRVp5TUlaYjRp?=
 =?utf-8?B?NGdwWThONUxRcDloQTZreW8xZVBJNHN6UzJIL3lGUWZPNGVPMGkreDlRYTVk?=
 =?utf-8?B?NXg3YlR6NUJwT0VjdTgwQitFb21qekxsZXExRU50ZmZLR0gvNVpqSHlPZE5p?=
 =?utf-8?B?NXhuZmVVcjlHdW1Id3VWQllaWklVT1pjWDJRcTQ2NkxFdmVJZkFNSUNkYWVL?=
 =?utf-8?B?M3BxNzNOWTVOUDFxekJoalMwTGJ5TnhBNzdZVU1aaFE5WFovblZlL3ZKK0lE?=
 =?utf-8?B?ek1uTjNSM3hnV0Z4QUphdldib3pvMTYxdnVuME1ncG9TdGNxa2djeGlHVEIr?=
 =?utf-8?B?dzZvQXplbVZabjN3Ymozd0hQUWxZK2hSbmIxeTB3MzM2V0JxN2dkbWgrTWdw?=
 =?utf-8?B?L3AxUWNwSUJoalVFcGlrVlYzWVUvczNqNFB4K0ZDNnlDVUQ2UHlib1dHNFBo?=
 =?utf-8?B?M1A5ZVFpWmh3UkkvZ1AzR2pJUFN6TFR1bEViN0tmUmd2aE5RQjFJa3d0aUdY?=
 =?utf-8?B?VmtUNlJ6VjhVRktmR1V2OG5saUxlZ0s4QXRmQlRGcFVYYkR1RHJkcWMwZ3N1?=
 =?utf-8?B?a2xSUDdOYkdLbC9IdmtVUlZGYlBIVmEyYzNTejhmbjBrY2FtRnh2blBkVjhl?=
 =?utf-8?B?ZEFxZWoyNnFDNnZMMGtEeEVVeHlXQ1FFOHRJb09iZ05YU3NkeGJ4T3lJRzRz?=
 =?utf-8?B?b3JWZ28zQmF6c29yMHVrZyt2K2UrUXEyV253TDVGTTBLaXdMemp3TGFvb3ht?=
 =?utf-8?B?b3FIV0p3dGtZNHhTeGVtUTZGTWxlY21NNEZWRjFIdWNYZW5wV25BdlpxU0hN?=
 =?utf-8?B?N2ZtT1N5WkVjNjc1RVBWR2krUlZ3MDJPZjhyTFVKaVFqTTNnRDV6VUJzdUtI?=
 =?utf-8?B?cmZsbUlkaHVqbEN6Rm93YWZMeUpKaXhVelR0STU1a2lKb2tya3o4d2J6SCtQ?=
 =?utf-8?B?UVVqWTA1SkRmTFVtc1ZtQWhieUdkdGFhVWFIUVppLzBsRXpBSzUyNW9XeU5K?=
 =?utf-8?B?c2I0dXBad2JONWg1RFJTUzVKNTlUR1BpdzRWNFJSajZWNHhOekxIQ0VEU2xO?=
 =?utf-8?B?Ry96NllmazhJVWhYN0JDSVY4NGZ0ek45YzIycXArTWtxZ1ZFY3prbXpmcEli?=
 =?utf-8?Q?sHyMfxxlODRUpZlaW447yfAWP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cfd729-fcb7-4a9c-6e03-08dd5a6e63d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:13:52.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mu+mG6YBu3j4E9sEwaB3Ipa94dD+XzNKqIP/yKAAHUTHYwdsA3OLp353vsS8RPG29WzjaW66xpNOutEdElKKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

File descriptor based pc_clock_*() operations of dynamic posix clocks
have access to the file pointer and implement permission checks in the
generic code before invoking the relevant dynamic clock callback.

Character device operations (open, read, poll, ioctl) do not implement a
generic permission control and the dynamic clock callbacks have no
access to the file pointer to implement them.

Extend struct posix_clock_context with a struct file pointer and
initialize it in posix_clock_open(), so that all dynamic clock callbacks
can access it.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 include/linux/posix-clock.h | 6 +++++-
 kernel/time/posix-clock.c   | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..a500d3160fe8 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -95,10 +95,13 @@ struct posix_clock {
  * struct posix_clock_context - represents clock file operations context
  *
  * @clk:              Pointer to the clock
+ * @fp:               Pointer to the file used to open the clock
  * @private_clkdata:  Pointer to user data
  *
  * Drivers should use struct posix_clock_context during specific character
- * device file operation methods to access the posix clock.
+ * device file operation methods to access the posix clock. In particular,
+ * the file pointer can be used to verify correct access mode for ioctl()
+ * calls.
  *
  * Drivers can store a private data structure during the open operation
  * if they have specific information that is required in other file
@@ -106,6 +109,7 @@ struct posix_clock {
  */
 struct posix_clock_context {
 	struct posix_clock *clk;
+	struct file *fp;
 	void *private_clkdata;
 };
 
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c..4e114e34a6e0 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -129,6 +129,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		goto out;
 	}
 	pccontext->clk = clk;
+	pccontext->fp = fp;
 	if (clk->ops.open) {
 		err = clk->ops.open(pccontext, fp->f_mode);
 		if (err) {
-- 
2.43.5


