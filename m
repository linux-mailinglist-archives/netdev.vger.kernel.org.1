Return-Path: <netdev+bounces-122529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4BD96195B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4E91C231D1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55F1D3643;
	Tue, 27 Aug 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kPnqQ8Ja"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512276056
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794824; cv=fail; b=IlGYmJsEEgNcvk+XI5la/+GQWmWRDg269O9sQJO1wzDaTxSIPrSrejG1dvlEhoh3Lvpm+pgCGuJYo9jkk+vTi4rANfqdsfY6FEpFmZAk93n64P5CxCYyrq/NljqSRuyJ6c+BQbEpfHNeex7uKStxB6H+05f0Qc1Mo9lnqQrNOUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794824; c=relaxed/simple;
	bh=vu4YQbWZOm6qhX6+tDrIiz3zVc3aPekVbsOOHz2l6gQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/bEMuTExrzySNneghnmd8AsuFe8c0+5zdV4dTj7aCuq8ukx4uVtN8Y2o6K+es/uMJTM1jkKMmv5VYhao7oqadtrxr7hWGupGoK8As9rVWTTjI1H+OVRCOiF6An93R/ouC5BNUx4OukPsToDfvBT8n8mtHxceMwbx1Hy+z50TbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kPnqQ8Ja; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3iy7KNDwR070FdZb+2xxMHc9JEZN/goufGI5kMVo60XKJYospAg5kpHS6io9y+k/yHQNrmDegIuWjlZRqtCXdxMF2g9xJruEn2bbRlEIL6b3xp0oRw4bsPlT7x0PWOglH5Nl2MB5rxL2XEiT6SwOJYKK1hc51Rvmhm0FfJFld+5EENJq8ufFiRzJaQ/HnJd10Zo0Y7BHSiUBEQX9AFShzV3uI/xyPOycGcGTOIfP4DjxpSCVwPCJ+OA1fsL+ztOlCyBR/yrctskd72a62/Rx3nzZ557ceqUyNqJjxZsAhQQP3zx+0hrJGkBamA7gVTFNJ1aUSWn+g90AJ5ekbtAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYMzbL7Wyf13dcqAmL39WkdX719UUj1XQEfZHHs1iDA=;
 b=yaNOqoJev3ZUxkVNfLvMB+b+wfmQLri/xqlIH1h/oNTWBSHAc01PffnJ427yWzai7ZQNrEJJvP8Xw8S+LXs2siBlLnnCEpl4XBDDpFqCMpklNWAygJo6D+nETHRmQ5ZBNtvupC4bGKEVCN+keRIrhzp7DCEWzI333dB0JJQ6jW5MzSHUehF8GcpV6YwiEzagTfN31ti0p9gA6YFxNvPvX4nGzptOfvcf7BwLmyP3IdUrELqVjlwq459niYZ/MFPxwCsyfbb14RgIA+xouJyWSNIHwsf33i/x+3BWxNzkxXpAgoD7ptz8H+S3rVoIU1asYXdUzbojacUUcJWjjLBJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYMzbL7Wyf13dcqAmL39WkdX719UUj1XQEfZHHs1iDA=;
 b=kPnqQ8JaKcZl4RsJ9wRKZya9aVluTREQUImTQ2y0zwemxfX29yBjO7lc0REP9RX0cjl7HyyBfWOWnQqSs3uclTIX/Puh4IS637Z6Qg4z0diZbcX6L8EiAsQKYiqTVDcksdeE4VW7OzCixZwKUlEX/H0m5n3OVSKpEdKqXx7EpHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 21:40:21 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 21:40:20 +0000
Message-ID: <4dfae14b-2d92-4561-9c79-688bde2e347a@amd.com>
Date: Tue, 27 Aug 2024 14:40:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/5] ionic: use per-queue xdp_prog
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com
References: <20240826184422.21895-1-brett.creeley@amd.com>
 <20240826184422.21895-4-brett.creeley@amd.com>
 <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <Zs28CpU2ZkglgUiZ@lzaremba-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5803cab7-0b15-49c4-68d3-08dcc6e0d9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXl0QVQ0ZHY0bWZJMjZWV2I4aWlrZlFjdzdaeGhSMlJieUFRTGpWK0xXVUJ6?=
 =?utf-8?B?ekFjVGoyRlZ5NFhiMTdGMVRrVWEwUVBIdjZJUWJubUFtTWdyTXpnMk1zZ09Q?=
 =?utf-8?B?VjhUbkhIV3F5NVQ3S0xOQVUxM1ZSWklqczVDYm4yR1p4bVFNWTJrb0gxNElB?=
 =?utf-8?B?QkZ1cVN0Q2xwTEZvUjh6U3FlSFlmWXZ4MWljT1UxNWtOcjNLNnpnVUc2TW5w?=
 =?utf-8?B?YmpIYklGQVJWS203cWxtMWQ1TDdnTWRMenVqUHh2MlNvK1FyT1RQd3VKdlhD?=
 =?utf-8?B?OGRsV2RpNDdKc2JoRnNBakJmRUhhUG4yS2dweUlZUlRKVGQzN2pCZ1FpSlZv?=
 =?utf-8?B?MEszd0p0Ry9PbFdBR2hKdGEwK25ReDl2Ky8rK0tsQ3FEZjEvQUtGZE93ZUNq?=
 =?utf-8?B?ZDgvN29PeGd0MEhrN2tZNjFVUEhuTGZkSThWNWJveDE0K0JiZ2NQVXZVRS9I?=
 =?utf-8?B?RWVOZS90VXNmSVRvUkpRVzc5dTdEd2k3SiswU2l5eWhLWGpua0hxaVBWczhW?=
 =?utf-8?B?MHRFTG02TkRPaUYxclVDVjFva1hnTlRCcnREVitwWExvWmJSRlBYTnp5YXJl?=
 =?utf-8?B?anNPcTB5VVp2bDRlT205b1ByY1Z5dnd4akZFdjNKNWVwbkV2eHJIalBxbXRL?=
 =?utf-8?B?MjdvZ0QxS1l1VitnRndkaDFYamxFWWR3MTJISG9tRFR4MWFiWDlGMTB0ZXdR?=
 =?utf-8?B?dU5idmZyWVZWZk5lR3ZnWXRkYTVVOG1GUk54U0hoeVYvVmxNSU1EeUVKVmZw?=
 =?utf-8?B?Z1ZxRHRsb1hnYWpCUEFZS2ZOU1h2ZHNpTjliSGNZMFR5QVBpdytCR2hhcmdr?=
 =?utf-8?B?Z3FLcHh3a1N1WXR2cGdGbzNKZmdVMlRKWDlWWE82STUxZHloZ2lBMUJRZEEx?=
 =?utf-8?B?VWtxQ05HNXNrZ1Boa3FXcm0raEE5ZVJMeGNUaVh4b0hvcnZzNFhRZUhzdWg3?=
 =?utf-8?B?amE3M3ZnK1QwTmtUbTYvTHlhWHhwVmxkZVlhN0NtejAwdzlMbFJObjc2MGRl?=
 =?utf-8?B?Qm5xcUl4bWpadFR4dnJ3aGd1Tk42cThkcXQyUjMyRzNqTFozOUhpdEpacEQy?=
 =?utf-8?B?b25aMmF4Q0VmQy9weVkzZHhEc1lXcDExSm9WSUIyVkJJK3l5UWluaUJETjEw?=
 =?utf-8?B?RVMrVXk1VUlzdzRLZVVvaTVqVW0rZ3ZuN2d5ZXl3R3dtL0d1VkNEOWhITU9j?=
 =?utf-8?B?cFhMVGx2MjVGVDRPc0tSQWk3djZpamlKd21sMGRvd3BwOE9aeGRHZmhEdUYv?=
 =?utf-8?B?ZyswSWtiNlZtcVRuQXZFOHFsSnRxSGFZZnFmVlMxWU4rWlhGQStRR0FoanF2?=
 =?utf-8?B?V0ZWNGpYclF6Q0s3eHZVQnNiNmZQb1p5dm96SXpqU0RSd0tDZ1d0ODRRTGRI?=
 =?utf-8?B?Z09FbWFUYU1lTEFoQ2NqTTJCVHZUVDBwbEluRndJUVdJaGVmaU1OQlhMLzRR?=
 =?utf-8?B?bEpTMklMbndFdFBna1BZaStLQ0xYSDdac0IrbHhSZnlZdGNBYm0vekZ1YTd1?=
 =?utf-8?B?SzZMclo2dUdVblc0dFBsNlRPS0ZFNHhxSmo4MnB2NnE1ZFdTbE15Q00wOUU3?=
 =?utf-8?B?UEtRUDR2aGREenBwR3I0UE1McjZncE9vaG82SWpDYXpFMFBxZUtLOWY0YVRn?=
 =?utf-8?B?cFc4TkRMYmU4V1RLUXBGUzE2NnhBaS8rR1FmWFc3Z2pMWGlWQ0JYMmt6ZnI4?=
 =?utf-8?B?ODR4ZDVKTTlpU0JoL25LK29sTVhOTURJVTBhQVBUT1NMdlJmd2JlT3YzRkZQ?=
 =?utf-8?B?QW1hNjhkOTVwanA3a1J3Vm1BTlEvckUySlhKZGxHdEgwQU56cTdCMUQyN2V4?=
 =?utf-8?B?c0k0RngxNGhSV1M0aDU2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1FiWXRiVU9tUkExZ0JNaEsrb1hHNjVKSDBKcW55WUJxcVh5T09EYmtnYXl1?=
 =?utf-8?B?SWhqODd5MXlDSnpMR2lKcDZCVXFhN3lnY3VWcC9BTmc4UEdFWWVZdFdRRDNo?=
 =?utf-8?B?UlBCR242OGh1QVl0d1dIMFk1MzZXZHdPOTFBMnlPS09sNmZ4eWU1SzUzamov?=
 =?utf-8?B?QTJUNnp0NHN5VHdMaFpTcVkvZlRJNmErc0R3RmZqTUUxRVhIQ1lKQWlZQlJk?=
 =?utf-8?B?RHZMRkt4dHgrYnpZcnlzdWEwUzhWdHNyb3c1MVh0UElqTEF3ejFLN2tnVmNi?=
 =?utf-8?B?dWJsaVhJMEw5THJrdzY1OUxqOEk3dzFZVnFCMGU3V1ZVUG5JaXZ1ME9sN0Nr?=
 =?utf-8?B?MlZYWEpzdUQ0WURVcWJvVVpmTjZFS0EzUjJaNlVieStWa09ueDZEUG1CVlBK?=
 =?utf-8?B?VFVwV1k3ZzdRZVpRYU5Fd1gvVjdDRDlqZmpHdU1PMHNHVGtobHFhd1IyZTdP?=
 =?utf-8?B?bVNKeUF2cEU2OXI5YXZIWmtUNGNGNXBpTm5JTmg2OWUzQzVENVp4NStsQmIy?=
 =?utf-8?B?QmlMMklmTEVqMjg1cWdxK0Q5WDlFeCtXR0JBaTN3TDVLMUhmNFd5Q1I2MWFE?=
 =?utf-8?B?Wm5hclZMeW9KVTFwbURIeWpGUkV2aDlaTlVxZnRFTURmZ1h1bDBKSXdBLzNO?=
 =?utf-8?B?M2NoUkd0OGcxc2ErUkF5R3hubDdnL3pYcCtIblRaYVd4SlQ2MElIWmZvM1Z6?=
 =?utf-8?B?Vzh4NG44RjVyZkFSL0xjeWtNNTRwZG5KbWFTWjhLdkdWMzAwZzA0VWdwYkpL?=
 =?utf-8?B?RHIzYkpRaFVyVVAxUW4wUXl6UEZUVkl1ZU96c3dLNnlmayt3TnU2alE5ZEVV?=
 =?utf-8?B?QlBqdkEwMTZxQmF2STExcU8zMndEMnVRWUVCZFlqZEFnKzFkbGViUlI1dkNV?=
 =?utf-8?B?S085MGxPTmJGSzJ1RU1id0ZYSjZBL3k5UCtISk5YQ2FGL0UwWTlja0d6Yy9E?=
 =?utf-8?B?Uld3WERTZklUdXVTYTNNWXQrMWNjL1V4ZGF6Y0FtVHkrcy9IWkdQV0J3eU1k?=
 =?utf-8?B?RmdUekhMeEFVSm8zWlRzOU1rU3JwcDlSaHBVQWpWVk1BYmtJR1N0VHEwOTho?=
 =?utf-8?B?MDdvYlNPN2VieHdXajZNbEMvaUtqTFNQV2lEdEN1ejFBbFVzSU5KNy9pSXcy?=
 =?utf-8?B?clZ4L3dWeXlzblJKSVJiS2xDYWtUUU9STG1NUFY1NENQOEZ5UGNFWjcvSTRh?=
 =?utf-8?B?cmxQNEV6WEhGbVRJSGttOGIvbFluRWNKVTlYOHp6Qkd6MTdFUUZ5Q1I4aGY1?=
 =?utf-8?B?TStwRU5ZRjJSNjJyb2FMR0dSOGxQa2ZtZ1F5UVhsejYwUEE5dXFvZzZTUzlN?=
 =?utf-8?B?MzQ2WCszbzB3blRocG1Bdk9zNnVGZlpJSEQ4NEFoaW9WVUFsNEk1RTBmMXhX?=
 =?utf-8?B?Ry94cG9Pd2ZKTGpXUkZnV1h4NS9kUGppZXNaa1ArZis0eHk2ci90WmUrbnIz?=
 =?utf-8?B?N1ZkcXBRV0hQSllTcGlNaHJpakZkdWk1cEt6VUxuRjdZUTl6UGRnU3BTMEZ4?=
 =?utf-8?B?QUw1NFp6YzdCZkRSUlJ6azJ2OGhHRUsra084Uk9Rd3NaTUIzMlJaY0ZSbWVj?=
 =?utf-8?B?V0xvUEZ2YTRYQWFuVDZXUTF5ZWtOc2FEQVFKNGxTQVpEWGQ2T2JSYjBZWjB1?=
 =?utf-8?B?cWhnNEFaSDRrWS9kbnA3Y0kyVG1ocHFMeGZCTzE1UVIzTUR0NmZaZW4wakpT?=
 =?utf-8?B?VXVZTnIwaDFYZnRibGpaQ1IwQktobEJhV3JuM0pXcWk1dVNEVlZNVkJmMXVU?=
 =?utf-8?B?ekRkNHlVVU5wLzErcDBjUmkwc3ZQUWRoVmZLT1NHNWRiSVdsZ1U2cXdaazdE?=
 =?utf-8?B?WTMxRkFaNWRQR0RNajlFaFo4dmlzZXlZRjhOeGtVSmIrTlVsblhDbnAxOUIr?=
 =?utf-8?B?MXRpS0lRd3pwL04ycVh2SWhBQTZpNjJaOU9NV09uc0NSeDdCZUdpL0xnby9K?=
 =?utf-8?B?Y1JldFY2YU4zZDB6Y0ViTDVYT21mRm1WTlVkT3dBYjl4MWdmYk9ZZnBNUDBr?=
 =?utf-8?B?aTNwdEJ1RXJjNUpLV3FvQldnMzZEQkVSMkhZSTNHTjRicEVvdXcyL3dRMUp3?=
 =?utf-8?B?Y1ZIb2docGZEditNQk82VzYrM2RQbnhxR0djdnp5N09PRGZmVVRHM3VsNyt3?=
 =?utf-8?Q?oj8DDs7VMhXBZ7BqFTCX7n+S1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5803cab7-0b15-49c4-68d3-08dcc6e0d9b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 21:40:20.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQbegjcZBrfe5Dc0/nX9XFdOFkjZpurRiTBnSSvH2oTv2dUYaYe1IuvrM1YDor2+CKKEmJE+/OQkI7znJJcGtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147



On 8/27/2024 4:44 AM, Larysa Zaremba wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Aug 26, 2024 at 11:44:20AM -0700, Brett Creeley wrote:
>> From: Shannon Nelson <shannon.nelson@amd.com>
>>
>> We originally were using a per-interface xdp_prog variable to track
>> a loaded XDP program since we knew there would never be support for a
>> per-queue XDP program.  With that, we only built the per queue rxq_info
>> struct when an XDP program was loaded and removed it on XDP program unload,
>> and used the pointer as an indicator in the Rx hotpath to know to how build
>> the buffers.  However, that's really not the model generally used, and
>> makes a conversion to page_pool Rx buffer cacheing a little problematic.
>>
>> This patch converts the driver to use the more common approach of using
>> a per-queue xdp_prog pointer to work out buffer allocations and need
>> for bpf_prog_run_xdp().  We jostle a couple of fields in the queue struct
>> in order to keep the new xdp_prog pointer in a warm cacheline.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> 
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> If you happen to send another version, please include in a commit message a note
> about READ_ONCE() removal. The removal itself is OK, but an indication that this
> was intentional would be nice.

Sure, will do. Thanks for the review.

Brett

<snip>

