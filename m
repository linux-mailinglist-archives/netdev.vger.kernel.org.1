Return-Path: <netdev+bounces-112165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600299373E2
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77B71F25B89
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9063E4315D;
	Fri, 19 Jul 2024 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48JqrG4+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526A38FA0;
	Fri, 19 Jul 2024 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369062; cv=fail; b=cFyXejnPAE2FuHL8rH+zATsfBXKUkib+adly7knSTqGhYx03d/vof+zOxgD+wSnkKWKKcRY6VpuAEWcNM7IssucSejkg3xxAnH0NtKCZ3GPPFCVE9C5wCmggYch5KEzvUshqLviz4cqi5PqkSVslTttCOO1YKARinGM3IniG3xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369062; c=relaxed/simple;
	bh=H3OYa0JGwt5zlmTfCaxYNkSyL5cKjby2EPPQbYUr+Uo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5usIJweHguqDh7QuSNNJVEUsbXpXTkCRUu0QOpcJ7297znO6/eVWaUo0khEKt52rp9vO9CeLFQgeKHPUlNDX9Ih9DII9491tdVVj7nHP6VvnUPSY6GD5Cdw4q1YGJ2qWHLNk3tmZgu7plkA9lqmAIWi7xl+tJLBtHN/PKXhP/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=48JqrG4+; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw90SD2Pk2AburF7fEuHFw9ApI3jsR5IxisEI1uG7zo9OQAV6lPfeAeixehW1tuMcRFkzGapptfcCBtFQGlJHSV5c6qkj/Bdi9g2VHe939KATJXC2OjVnPyRhUMyMqLEaxzUJo4y3g8gS30JVh4ivWnmfi+3iLfGA59HZ1BDDNnwYLn7GedyEP5rlgQc6BTYzRZ9LxS0mU7PjRHQz4Ul7c5Wi5uVrfZbQfYbQkjZNI/t3vGKnd3orfWwWUWkN1J3gh2LLvOvfZ10iRiocWbzHDsx8sb0GfHCVh20s0wU25Ows/9XjWw4xkjviY5/kK0xsersI3y3ZMUQLfJVNi4Oqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od1895//0taMBRV1jEjumzUGEdNodF75YJwFZNY56EU=;
 b=HPFfjRvd2xfCOiMwy+2Li7lyjI1a/qwe3GlSrCAZeO0uE8H1IM9vWFRYy9Lm3iQI/WVn3M83whdAztY7llev2EplmrpnnxAFuD9uf1W8xDpmsRUu75fGhPt1BBxFnTWTu+g2fYetyLNT8tnMKJ/uWIm3D81lTCoxKtjIvztqtlhZmq6C5PDWUkdsvIkGMrHW8rJEFGttDxdsSNy1gqM0UQeegVEZ2VOIqmze6RRyv58lm1mrfVcb2ntv8nFqYRiR/tJHeW9xEwEUfEW+SiGxXF+uEYXVX2o5qG0zP0DmqUASV4THdnBDPNcES2ot5wAy15ccW/Dc5qZfiXIromszhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od1895//0taMBRV1jEjumzUGEdNodF75YJwFZNY56EU=;
 b=48JqrG4+Fnqueb436ov0sE605OKbdeTh9BEQLlR/8RK0oRkdWB7zoAT0v54ehtXLl3NirnA7OoAO9nE7gXCaRhsfaA5DOXEq3IafIIPo/D4Qj+Aq85W3oHV4voCLnYEeTpTyLdGfpV5IodgwHp25GgvMCw6AQQLSfV9Ud4VfCFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 06:04:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Fri, 19 Jul 2024
 06:04:15 +0000
Message-ID: <e5a4836d-a405-5b12-62a7-e45b39fb12ad@amd.com>
Date: Fri, 19 Jul 2024 07:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <936eecad-2e98-4336-b775-d28fa1d87d76@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <936eecad-2e98-4336-b775-d28fa1d87d76@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::27) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6765e7ef-80be-42ce-e962-08dca7b89e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmVQWDkyNHNaTGhXdU4wNEhRRThLRElXem0xdFltUWlpb2E3ZEFNTFIvTGNx?=
 =?utf-8?B?K1F6a25DNWs3akdlMUxtMWNMSjFQbmt0Nnk3MjFFVUdtR2xrWlZXQWZzOWUv?=
 =?utf-8?B?VlRGV3pKRXF2S2FzSTZpNnVlUWRQODRKcHI2cnZKV1E4UHkvSTY3U2cwOVBt?=
 =?utf-8?B?b3hyTzNrTDc3Sm4rbVVnNzRFUjV4alBTV1IzdmJNQVpDZ0NjYndPQ3IzeCtz?=
 =?utf-8?B?dHBnbGJYV1pKcFVZendEYXk2TCtVNzlDa2thT016cm9La3NieHM3Wnd5UjVv?=
 =?utf-8?B?VmtieGhrNTB0NUVsSHNqYWI3bWpqR0dzVE1WcXk5a3NRYTlUVFB5OFVSbWti?=
 =?utf-8?B?RktkcklLcjVKcjJoLzlsWVlvUkJrTzd3QWY4UnhHNkJ4WlZkYU9SUFdxRzMy?=
 =?utf-8?B?b0U4TUg1NUpKQ1VjVVFhRWFZRUd3RDVNYWhPWnNzTEwvRU1QYzRkVkZvcElu?=
 =?utf-8?B?eXhkOUVGc1lIM0pRMGZXS09za2xzQTJ0NStyazN3MkRRdnJQOHlBTDFYUGVj?=
 =?utf-8?B?SG5nZjhXSjhXZ280V2ZiSGd1UnJPeUhZRnZ2ZlVJTGcwNGZCYjJETXdXREhy?=
 =?utf-8?B?cXg5SE1kZUVocFI2ZHhRVnFTTjZ1TE5YTjVCaUw1ckppdlVjWHQxSkMzWlJt?=
 =?utf-8?B?ZW9ackVOTStaQXk4NkZ1SUZSWEgzQkxPbGxCNEhXcTNRNHgvZCtrYm1oa1RN?=
 =?utf-8?B?V1N2SEVkVC9pSzhoL0ovMWRiQVpTZDIvTjhsbGplZk1BL292QlBCMXgwcDJP?=
 =?utf-8?B?S3F1aUFGUDZmekZPYWRsTFlNdW03UjJ6K1Q2UXFPMFFzc0lobURKN1dYdEcz?=
 =?utf-8?B?OVFGMUpwcnRyRXhaU0tVVEhJbjR5dHNOTzZ0aCt0NEJ3ZlhiTHVqaGtIQy85?=
 =?utf-8?B?dmZwQmtRbDBzLy9ZWlZQTHpQNVloWEhQTVVjNk5neDFURldDWXp3YTBxRmgx?=
 =?utf-8?B?NUxDWm5oWEpJZUhrZmJ0VDhtMTJBd1R4czBYYUtrQkFFeW5odXBqSFdmdHRa?=
 =?utf-8?B?NXMrMmlqQUdTNk9GNFVQd2ZNb3NsR3l0dmUyZWYxQSs0czJNcWpvSUtxRmVM?=
 =?utf-8?B?cW00RnFaNFNVQk5yZ1UvYVEzK1M4OFFOcW92WUhodlBROEV6OERKN2hmWGJP?=
 =?utf-8?B?eXB1cFpjd2lIWWtzSXc0QjA2aXFObzg2cUs3TDhIenZ5Qm9ab0JtaGVEOHYx?=
 =?utf-8?B?bGZQR1BFYlBmaUl5ZlFKRXZXM0JUK25NOVh3M1pBNU1IY3UzcFVJekNRNVU3?=
 =?utf-8?B?bzIxdGdROHVuRmVrNFZIaFRhdVd1dVdxMUVPY2FBcEtwalkrcCthSXkvRG15?=
 =?utf-8?B?WGpmbVhTY1dwNVBlQ29JbzFNbm9tcDBCQU9MbEU2SGY4ZkQydDg2eGE3eTJF?=
 =?utf-8?B?L1NoVTZIcjVybVpEVG4xK2xGQlFNR0YvY0RGUDBZN2t0ODRqa0JubDJtWUln?=
 =?utf-8?B?WVRlcGF3RCtyajJ3TDZUNENrbHcxVmgveUcvZkIwSE55MmxlYmhYQ0EwZnNj?=
 =?utf-8?B?alp2dSs5S1psZGd3d2E2SDNYakllcldvd3p2WCtMOVBHaUhnbUhzdmVWUmFL?=
 =?utf-8?B?YUpJSnlMaFRmRTk1dTJzYTBuVWluVHNQLzlmRU1BcjRZQmRsdzhoL2ZBL1kw?=
 =?utf-8?B?cURCazhrcW5sTnNzUWo0WnBQbk8zWnVrR090QXFoQ3JDQm5FS09VTXNkOGJa?=
 =?utf-8?B?V1k2azMySWppYUZyNy9GTlZNSmRQSTRHYmxybjVxaWtsZmUzb1NTdGdoY212?=
 =?utf-8?B?Q3ViRkEyNXRaV2UrS3ZqWWJKdms2Y3N3bzhveUhUOU1oSDlQYUhNdnZxL3BQ?=
 =?utf-8?B?MGIyZjN3TGVZZVNBNnRqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU9VTGFPWjJFMm1TYWxKaXY2MDZPM2NNN0ZGdGVzTEdRdmk1cVpsZzV5Z0RS?=
 =?utf-8?B?cjRTV2Vrd2djRFRmV1BmeS9nbmNIR2hrYXlzaFYyc2RBa2U1T2liVHN1aWZR?=
 =?utf-8?B?cHpFUW9qbmlTL2RUQVhtNnp5TlBmRVVNRUIzQ3FtUVhvT0pHSE9qcDlEOGw2?=
 =?utf-8?B?V0c1TFpqakhxaERqVm9kYmxDY0tIdHVmYUpDM3cvdUREcDBUME1vL3FnME1R?=
 =?utf-8?B?MmplbFFSeTFDRjFoWlZsdjZvRjQxTjlWQWZyUDVKUVlacVMyUmpFZElYeFpa?=
 =?utf-8?B?c09QZ2pRTnRQQWoyMi9nck9xVXU4UzhzcTdSTzl3ellaR2ZYUGtvWHdHQ2w1?=
 =?utf-8?B?aHJXTk1jcXNINHpraUVnQ3NJcUZMOHJWS2hoZ3BDYlMvUFYwTVhZa3BvZW9s?=
 =?utf-8?B?d2w0Y0dCMGhiaVVhOTYrdXN6ZVVKZEZvc1RmWGh3aDU3NTdFUWNod3RIeDVN?=
 =?utf-8?B?UHhMbjBuR05wL1djcjV6M0c1RGhjSXZ4K01HdU5xMEZBd2pWSThhKzZoSjFo?=
 =?utf-8?B?dDd5WE5MdmxZN2xwejlxaUZqWHRJY0MxRU9oQVRrOVhNMWZybEV3OElRL0Rv?=
 =?utf-8?B?ekx1NjdZVG9UVUlZY2xHOXp1M3hNU2I3cTJSWkNUdTNQaXdySkMvejEzbTJH?=
 =?utf-8?B?V0dJR3p4MklrcFFjNlcxOXJScnpzOHordEJWWjN3Tk5zaHZKNEFuRzEwclZy?=
 =?utf-8?B?SEtXZ2diODdWcmo4MXdPRUVGZ1dXVmJyeUNYRXFGQXcvbmZueWF2Ry9STjc1?=
 =?utf-8?B?VDFWc21UUno0alliRUFpR1VvKzdqUGpweDI0Q2tyVS81ekZQOHJmbk0zalI2?=
 =?utf-8?B?VmtoMW9RV2M4MFQ2NW9nNHhhTkRTdC9HMVVvTjFXaWh2Q0EwbFVBQ2Q2MkUw?=
 =?utf-8?B?VzlFZElNUUl0R0F3eDFWSTZvbnFJbnhGVE1JaHBSdHpKbXMyYTVNckR1NHVM?=
 =?utf-8?B?UGxvRk9qVHQ0SEVxV21pODhKQmF6NktpdFV6TFROY09vQlIvbDFtU1dxUUY2?=
 =?utf-8?B?ckFqZmhUZDUwQVpnZm4zWkFYREMyWU9yaUcwWlQrN2RnSzI3dmwyWEZ4WkJE?=
 =?utf-8?B?MWh6YjRwSVo1SzRiRHQranhtWVZJS21rTzB4SzErSU9pZUc1MkVHd3M0YW8v?=
 =?utf-8?B?b2pkNEhDby9aYU9IQVNPQ0lNSVFVTFAwVzVUakpkZmdaaitvY2kwaG1SbXlx?=
 =?utf-8?B?bnlmYjdGSmNIRjFaYWFEU004MC9rcG9rdTlNLzJyeDZKODJnQUtYSFFiMnRt?=
 =?utf-8?B?dkxhSE9OTWdPTW5aYytUQ0xmRjkwUmNDUy9hK2xxSGJhV2tGKy82cWxEcDUv?=
 =?utf-8?B?cktuWU5TYkk3c2FkWW5kNFNCNlZHWWQvSy9LNVJIZk9NNkx3YkZyL3lTaFp0?=
 =?utf-8?B?THRhQjBLUkliUm8wc2xpUGdUUS84Yy9selNxS1lyWTQyL1V1SUV0WGYwTVR3?=
 =?utf-8?B?dzBjcjVoYWZrNGxUVlNVVHBBdmlLMENYbm02M3lZdUd5WHNKWW1TQXFaSllV?=
 =?utf-8?B?YjdYM29yNlRNN1NSOGxoaVZhTWkrWWJTSitNNWpRMlhaY3pQZG05dkUvVDd4?=
 =?utf-8?B?dmNOc1Fsa3pLcVZaUndVSlQ4WnVVd2IycmpYdTJEb21MK2IwUFY3N1ZVV3Ir?=
 =?utf-8?B?eE1zbkgxWmFuRzNvYVcvcCtsVFd0TzZDSSt5RU1MTHhHYmZqZU1Ld2s5QVdK?=
 =?utf-8?B?N2x6WUJUZ2MvUFBFajIwQ0FQOEhGZ2tCN3JPMkR2NUo0UzE4dSt1V21yMUIr?=
 =?utf-8?B?Qlg0bkZuU3ZYb2EzYjVKcVFYWmo3VHBqMUVJb0dUL1BlaTRhNTlIMEl3SVpS?=
 =?utf-8?B?LzhydnhqaVNyMmZ6K2VENDJwMVA4U0NBbTdNYXpUZjB5MjNWcjN1eFFSUklv?=
 =?utf-8?B?SzQ0c3BUb1hhK01EVTNoVmVOK0tVOTVQS1BnTWZ1OTJDQjEyNmRxQmdsS1g0?=
 =?utf-8?B?UUd3U3FtU0g0UFhWM3VwU1l0QlQ3UVlZblN1ZFhvWHNiUS9nQnR3NFBHSXc0?=
 =?utf-8?B?ZWV4MnpkWFNWU2VIdFNNcmhDZzJMYzd3K1pzS1NweDVIQ3BiSmorSjZlc3RW?=
 =?utf-8?B?K1daQ005RFBDaXd2VkVBZXY1KzdpQkliYjF3WlNwT0ZCKzQ2MEFZTDVpdUMz?=
 =?utf-8?Q?63WA0BEC23PlgL2lok4v3C4GX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6765e7ef-80be-42ce-e962-08dca7b89e38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:04:15.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRmXouki8cb/J7oqNxdZHE4r9a9s05fu39HJWFERRQ9f6qpqCOwA1YqFoJ0DbGy+ONk8nlgaFTu6UDsf489NDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580


On 7/19/24 00:12, Dave Jiang wrote:
>
> On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differientiate Type3, aka memory expanders, from Type2, aka device
>> accelerators, with a new function for initializing cxl_dev_state.
>>
>> Create opaque struct to be used by accelerators relying on new access
>> functions in following patches.
>>
>> Add SFC ethernet network driver as the client.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c             | 52 ++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/Makefile     |  2 +-
>>   drivers/net/ethernet/sfc/efx.c        |  4 ++
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 53 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h |  4 ++
>>   include/linux/cxl_accel_mem.h         | 22 +++++++++++
>>   include/linux/cxl_accel_pci.h         | 23 ++++++++++++
> Maybe create an include/linux/cxl and then we can put headers in there.
>
>>   8 files changed, 188 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>   create mode 100644 include/linux/cxl_accel_mem.h
>>   create mode 100644 include/linux/cxl_accel_pci.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..61b5d35b49e7 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>>   #include <cxlmem.h>
>> +#include <linux/cxl_accel_mem.h>
>>   #include "trace.h"
>>   #include "core.h"
>>   
>> @@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> Naked cxlds. Do you think you'll need an accel_dev_state to wrap around cxl_dev_state similar to cxl_memdev_state in order to store accel related information? I also wonder if 'struct cxl_dev_state' should be a public definition. Need to look at the rest of the patchset to circle back.
>

Not sure I understand your concern. Are you saying we need to introduce 
an cxl_accel_state struct? Fro my work and I guess from Dan's original 
patch, it seems it is not needed, although I have already raised my 
concerns about, maybe, current structs requiring a refactoring due to 
the optional capabilities for Type2.

Regarding if cxl_dev_state needs to be public, this patchet version 
defines it as opaque for addressing the concerns about accel drivers 
need to be "controlled".


>> +	if (!cxlds)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = CXL_DEVTYPE_DEVMEM;
>> +
>> +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>> +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>> +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> I do wonder if we should have a common device state init helper function to init all the common bits:
> int cxlds_init(struct *dev, enum cxl_devtype devtype)
>
>
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops)
>>   {
>> @@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
>>   	return 0;
>>   }
>>   
>> +
>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>> +{
>> +	cxlds->cxl_dvsec = dvsec;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_dvsec, CXL);
>> +
>> +void cxl_accel_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>> +{
>> +	cxlds->serial= serial;
> Missing space before '='
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_serial, CXL);
>> +
>> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +			    enum accel_resource type)
>> +{
>> +	switch (type) {
>> +	case CXL_ACCEL_RES_DPA:
>> +		cxlds->dpa_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_RAM:
>> +		cxlds->ram_res = res;
>> +		return;
>> +	case CXL_ACCEL_RES_PMEM:
>> +		cxlds->pmem_res = res;
>> +		return;
>> +	default:
>> +		dev_err(cxlds->dev, "unkown resource type (%u)\n", type);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
>> index 8f446b9bd5ee..e80c713c3b0c 100644
>> --- a/drivers/net/ethernet/sfc/Makefile
>> +++ b/drivers/net/ethernet/sfc/Makefile
>> @@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
>>   			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
>>   			   ef100.o ef100_nic.o ef100_netdev.o \
>>   			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
>> -			   efx_devlink.o
>> +			   efx_devlink.o efx_cxl.o
>>   sfc-$(CONFIG_SFC_MTD)	+= mtd.o
>>   sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
>>                              mae.o tc.o tc_bindings.o tc_counters.o \
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index e9d9de8e648a..cb3f74d30852 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -33,6 +33,7 @@
>>   #include "selftest.h"
>>   #include "sriov.h"
>>   #include "efx_devlink.h"
>> +#include "efx_cxl.h"
>>   
>>   #include "mcdi_port_common.h"
>>   #include "mcdi_pcol.h"
>> @@ -899,6 +900,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_pci_remove_main(efx);
>>   
>>   	efx_fini_io(efx);
>> +
> stray blank line
>
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>>   	efx_fini_devlink_and_unlock(efx);
>> @@ -1109,6 +1111,8 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +	efx_cxl_init(efx);
> No error checks? Does the device expect to work whether CXL is setup or not?
>

Right. The netdev functionality will not be jeopardized because CXL 
initialization errors. If it is all fine, the PIO buffers will be mapped 
using the created CXL region, if not, PIO buffers will be used mapping 
at specific BAR offset.


>> +
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> new file mode 100644
>> index 000000000000..4554dd7cca76
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +
>> +#include <linux/pci.h>
>> +#include <linux/cxl_accel_mem.h>
>> +#include <linux/cxl_accel_pci.h>
>> +
>> +#include "net_driver.h"
>> +#include "efx_cxl.h"
>> +
>> +#define EFX_CTPIO_BUFFER_SIZE	(1024*1024*256)
>> +
>> +void efx_cxl_init(struct efx_nic *efx)
>> +{
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl = efx->cxl;
>> +	struct resource res;
>> +	u16 dvsec;
>> +
>> +	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PCIE_DEVICE);
>> +
>> +	if (!dvsec)
>> +		return;
>> +
>> +	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
> Seem like unnecessary kern log emission
>

Uhmm, yes, maybe something more linked to how PIO buffer end up being 
used at a later time.

>> +
>> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
>> +	if (IS_ERR(cxl->cxlds)) {
>> +		pci_info(pci_dev, "CXL accel device state failed");
> pci_err()? or maybe pci_warn() given it's ignoring error returns.


Right. I will change this and other similar ones.


>> +		return;
>> +	}
>> +
>> +	cxl_accel_set_dvsec(cxl->cxlds, dvsec);
>> +	cxl_accel_set_serial(cxl->cxlds, pci_dev->dev.id);
>> +
>> +	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
>> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA);
>> +
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>> +}
>> +
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..76c6794c20d8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CLX_H
>> +
>> +#include <linux/cxl_accel_mem.h>
>> +
>> +struct efx_nic;
>> +
>> +struct efx_cxl {
>> +	cxl_accel_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +void efx_cxl_init(struct efx_nic *efx);
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index f2dd7feb0e0c..58b7517afea4 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -814,6 +814,8 @@ enum efx_xdp_tx_queues_mode {
>>   
>>   struct efx_mae;
>>   
>> +struct efx_cxl;
>> +
>>   /**
>>    * struct efx_nic - an Efx NIC
>>    * @name: Device name (net device name or bus id before net device registered)
>> @@ -962,6 +964,7 @@ struct efx_mae;
>>    * @tc: state for TC offload (EF100).
>>    * @devlink: reference to devlink structure owned by this device
>>    * @dl_port: devlink port associated with the PF
>> + * @cxl: details of related cxl objects
>>    * @mem_bar: The BAR that is mapped into membase.
>>    * @reg_base: Offset from the start of the bar to the function control window.
>>    * @monitor_work: Hardware monitor workitem
>> @@ -1148,6 +1151,7 @@ struct efx_nic {
>>   
>>   	struct devlink *devlink;
>>   	struct devlink_port *dl_port;
>> +	struct efx_cxl *cxl;
>>   	unsigned int mem_bar;
>>   	u32 reg_base;
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> new file mode 100644
>> index 000000000000..daf46d41f59c
>> --- /dev/null
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/cdev.h>
> Don't think this header is needed?
>
>> +
>> +#ifndef __CXL_ACCEL_MEM_H
>> +#define __CXL_ACCEL_MEM_H
>> +
>> +enum accel_resource{
>> +	CXL_ACCEL_RES_DPA,
>> +	CXL_ACCEL_RES_RAM,
>> +	CXL_ACCEL_RES_PMEM,
>> +};
>> +
>> +typedef struct cxl_dev_state cxl_accel_state;
> Please use 'struct cxl_dev_state' directly. There's no good reason to hide the type.


That is what I think I was told to do although not explicitly. There 
were concerns in the RFC about accel drivers too loose for doing things 
regarding CXL and somehow CXL core should keep control as much as 
possible.  I was even thought I was being asked to implement auxbus with 
the CXL part of an accel as an auxiliar device which should be bound to 
a CXL core driver. Then Jonathan Cameron the only one explicitly giving 
the possibility of the opaque approach and disadvising the auxbus idea.


Maybe I need an explicit action here.


>> +cxl_accel_state *cxl_accel_state_create(struct device *dev);
>> +
>> +void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>> +void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>> +void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>> +			    enum accel_resource);
>> +#endif
>> diff --git a/include/linux/cxl_accel_pci.h b/include/linux/cxl_accel_pci.h
>> new file mode 100644
>> index 000000000000..c337ae8797e6
>> --- /dev/null
>> +++ b/include/linux/cxl_accel_pci.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> This looks like a copy/paste of drivers/cxl/cxlpci.h definition. I suggest create a include/linux/cxl/pci.h and stick it in there and delete the copy in cxlpci.h. Also update the CXL spec version to latest (3.1) if you don't mind if we are going to move it.


That makes sense. I'll do it.

Thanks


>> +
>> +#endif

