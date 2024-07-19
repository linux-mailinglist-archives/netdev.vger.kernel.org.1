Return-Path: <netdev+bounces-112184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE093751D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11908281CFB
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE8F7641D;
	Fri, 19 Jul 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P91P3LgQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82569959;
	Fri, 19 Jul 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378187; cv=fail; b=MYFB9lWNs01fiMqewxboIcXuaBUYnjodQdRfbtSLxn/KjSbF7Dy7OvZzM39HsM/GjWmtXWLbCcjW06JjZKk/2claKGwl/9b/uIlvgUCBkPYV232shcM1RLKRjuIy1mOZOewONGAJEQekq/CfMpmmkkK2Qti6GDCMkcWq2OsNadE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378187; c=relaxed/simple;
	bh=rbnuIzpPtEHxoXCMKJX+tDT6THeO4VZ4pk1fW6t2NBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VZDmy7b1FYwBEUk3rTNets+CLNLNsbmoofm0TlPiNwKQ2tniPtiDLfoidhCk6OmUS/izLnAors0z1eVtBZiTZvdPtzpIkvs+98hJin3HoCqVe7hpk/X/ObLO7pIQsawRPNYoBdsw7FdH6UY6xY0H6VhvV+Wx1vQoxPvt7KiQzHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P91P3LgQ; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdPdOx6BscaW9GmDRE1mGGqqOlL2bi6bJA75+xa1n/ou61G5k0yjNAX65Ua7q1YL8WFHYuNMsgbVfOONI02wqxrrwsm9mJlxP79Xaup09tPdfFqc4q1ad9JC5dGQvK/JWKlUYtoMtaHkJLuanTX+4mSAmq2dCxrvilzLHfkquVVjB38YY9SVE1RRs3KDcKp5NGvtJWGCuaIcReX9rim2TOdDIkbAZxjtcaBnLUJA3krFtQtRkO6Sp5SV0cQQT78jtbOFttHZ+oWypoGmTRns42XA8QI2tVL2zjKV6n8Jf/xKj1wjhRzAFMgGlF1Cghd+AdohS2ppMB4WpAr67QJRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftC+7e+OKxyGrVpM2QOTWOO2BR4mAfDpaPMPolUD8Ns=;
 b=ybLfNA/EDoZfiOY/ovHdXlapPms/LVw6P1odL2ubUUsXHh8woQPoGOiDab+SmRmSHXvr5NDArsfaYoPvDDTeuuXMb9Et0Ojrdfx5ERuNvMb08hSB4xCIx52ptNgKM9tvI+B3j4ABSH+BZPDauj1bOC2hVjzu/0K9t+qLrtSoqNesgUpmCFDorMUFBoUoEogk4Xx+sMTtGiNgPFS1Esmxbo4F3yp/p91oecNsEWU8SHDOT8LHxURF9ltLE4+VV0ho9MpQCaIsqub++FunlTRUjE3JaVYMYANsefC0A8JBunvvisS68Zm+XMBd9KQemIbujGzudIrW0+AtAzSLwRDKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftC+7e+OKxyGrVpM2QOTWOO2BR4mAfDpaPMPolUD8Ns=;
 b=P91P3LgQwzjCEFqlt4CT8TAW53oi9mhT8mTW3+NMJTNlYds0Q1rCWNLeEaEkQrq607O0JyqZchaeUOUTMFSGANURQYc2CE8ZCyGpU4K7ioLvVXYnJ57IgHRqV9fcqOJws0MIr6zXK8WrEwul7P6xm9bneIQoWMLjepJFwaoucRunudzPfp2dcJGZ5cq1hWOeQ7OybFX940aYUmegUXS42BZoX4aMivEjv6JLMFwe8tVDKTkB4tggO3Mkw4mG/abSJvGE8+qjoo228YQDRm4CQyADpOJz9wfHtF6HfXCiDeCTlmTuDY1d4sWGyNsHwwPzM+yuMelT0waxx+BQN1ebGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 08:36:22 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:36:21 +0000
Message-ID: <e5b5420a-4280-4c46-8a5c-d575dc74d3f8@nvidia.com>
Date: Fri, 19 Jul 2024 09:36:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH net] net: phy: aquantia: only poll GLOBAL_CFG
 registers on aqr113c and aqr115c
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240718145747.131318-1-brgl@bgdev.pl>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240718145747.131318-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 47beff31-659f-4c4f-bcbe-08dca7cdde00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTN1cjg0SytvRGovckNlQWllR1B5aUtES2NrMmxYQjhHcDhkaVVjVDZ2OG1X?=
 =?utf-8?B?RHdFQTlxaWsyRTloVitUMjEvZ1l4TW1JMUd2RTlTWkhrczU3cWloWEFyTGNY?=
 =?utf-8?B?MU5FcUg2S2owOVYxRzdsdGZEWkVnRjN6MG9sb09RT0gzWGtWZ1FCWHJTcmRE?=
 =?utf-8?B?YU5tRC8vSVR1K0JiWlViaUpRb2hjbkh2UkdOT24rSUR4dUZqa2ZiMGFObWNR?=
 =?utf-8?B?UDN5blJjWVh4dm4rK2RiOU1vRzRlakdlZWpCK0dWV0hDR2xVdGtNNmRxbDVp?=
 =?utf-8?B?RW9xOTVKNDJJKzcxc1lqL01na0lreHR5YW5mdVVLUHRCYStyclF4dWpZQmU4?=
 =?utf-8?B?bm84dVZSNmpPMnR2U1N6TjRBdGJWaDR3eHRiUWJtOW92YnNyQWt1L3FpS3Zq?=
 =?utf-8?B?WCtwV3VnN01CS1lWNFRpdUlqSWI5eTBPM3V0dmZPUG9YTHVJT3NDeDBKd3FC?=
 =?utf-8?B?UERlaTBKeHNJR2laZjJ0L3BDdmw5OFNVaTRDZ2NqUjR5blF6MDY4OXlDYXd5?=
 =?utf-8?B?elBRMmc4MkZjS2lSTnlVMzVnUVA5VEU2R0hJaGhjcXlpclBvV3I1cWdmZWZQ?=
 =?utf-8?B?a0UxL2R5TExVYXlqbG1FS0dRamIvZUltUDQ0RjdGSkhHRHJmSUh6Uk5vZk10?=
 =?utf-8?B?N3BpRWY0Qll0YzdPV01sQjI5VGhpUm0rVUJJbTlNalJnZndYZUZ6N2cxaWVp?=
 =?utf-8?B?NStUWlltVVY0c244YzNWd05rdEdZMnhsQzQ4VEJJTEM2RFhWV1dGYUxMTkJi?=
 =?utf-8?B?aVI5V2VqR3BCYk44eUpuS3ZOam9NMk1maHNUb1NJNlErK25TbVBRWDBpeWlO?=
 =?utf-8?B?c0ZWOEVIWUp5K3ZWS2RpWFZKRzZKRlNYNkRqcm91L2dvb3ZhK1BHQktaWWpS?=
 =?utf-8?B?TXRVcnpSdDRpQTRLV2lmWlFWMFZ5Y0NMYUR3TnFpME0zWUhjNy9WZ3J2Q2xO?=
 =?utf-8?B?NXBqMUxTQ3Vua2ROUldvZXZSaHhmeWxEUGFzY1ZmUG14cTRnL3p6MHdEUkJQ?=
 =?utf-8?B?MFh1ZVlEVG5lYWJYM0VWV1FPZFlZVk1DdWw4bUgrS0JtWTduT1VKOG9HcDNG?=
 =?utf-8?B?ZUlmeGVaUC9odFRERWZ5Q2xDbTB3VkgzaE5YVlBqbWlKZEhWTldmaEVzRkFN?=
 =?utf-8?B?USt4TU5BNk5YWEZ3bmpLTHhyeXNHM1lmSEllb2NIVjRweGd3WGpDWUdva3BC?=
 =?utf-8?B?bEtWVElJWUd4YUVUbjdET0Zzay9JY3dnSUxvdThpbTZya1N2WHNHSzJna3Ez?=
 =?utf-8?B?UXNtL202ZmhJVXBnMzUzYk5QN25ZMGZNMHQ3VHBWNlJURlZqVlV1SVVTZXhw?=
 =?utf-8?B?Q2R0cVBsUi9TMGYydGFRTzVJK3NmbmdoNzMzanY3L21RRjIyWWlZK0NlemZ1?=
 =?utf-8?B?cDJodmtYb3hPTUcvNjJSakg0TzBmN3ZmYVBYRzJ5R2prYXZpcEZhUVVuTGxl?=
 =?utf-8?B?Ym8zbnk3cGZ4a3RzSGtiRmNZcGRLOThFTmZMWXVVQ2RCOHhxVGprWnI5NDRj?=
 =?utf-8?B?NWtNUGduR0VjNFFud1ZoYjEwZ1ZHcDBWa0JnZ3hoaHNzOE1qYzlaU0Zrak5E?=
 =?utf-8?B?RklXSzljTTRXZ3pUMmErMVA2RGl2UXZsVWkwSE9LQ2JWMHNNeElZRGMyazdm?=
 =?utf-8?B?cEdaV3k0OGVadVNVMGxrQ2Z3QUpXdVBZdmxIclpNVmxZSE40Wm1MQnFteHhB?=
 =?utf-8?B?WDdyblhLbzgzQlo3WWMxNkROUzdkTFNvUmVpbUxsMmE0aGJ6Z2g0NFZBS0s1?=
 =?utf-8?B?WnMrQWpPMnVidXJXNHQzRE5kcTBDeHJBTmRjcEtjWlQ0clo3MGxFN0dqclls?=
 =?utf-8?Q?dalSXZ+vB1H33+Dm8lxc4IVysuJvSHAiRqSN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2cwNEpKZjJLWm9vaW96QXpVYzI2Zy95OFltR3BXZ09VUTVmNktPbW5pWURF?=
 =?utf-8?B?cVU0ZXJFQ3dnbGNmOTFQc0cxSSs2TGVSTG02TGlhZlh6SWJHRysxaHhpRzdx?=
 =?utf-8?B?YkU1WE9UYWhMa2hiZ3FyWGVybXBqT3hFWVAzNFJXSFN5dmRweGxpZkJLb0dP?=
 =?utf-8?B?VEhTUnJqeGNCN3BscEJMRW10UlRMS3o3R2FJZ0NaR1JiWHFhM3ZlbEtEY1cx?=
 =?utf-8?B?NGNINVgrbDUrV2VqZ0ZMeG5wd0t0cWNzbWNHbDJSL1pSUVdGbk1LT2tKMzBo?=
 =?utf-8?B?dEU4QklxUUFKYlZxRVVCK1dWOWZhS3AzUzVIdE1uck5PdDNCQm5pVkJzNWRy?=
 =?utf-8?B?T09nMGFsNWUraU5Ka20zOG5wZFpDem9NamtKRGhpc0lNZ2RqWEQ2VHBaYmJP?=
 =?utf-8?B?YTBlYXBKRSt4OFFhRVlPS3JPT1lFLzJIeGlaYlk4UHJiSVBGcWFncm8zVGdw?=
 =?utf-8?B?RXVQeDFoZjg2VlNTMG1tL3IvM2dCOW1LSUJSUVR1R0dCTTFSWkplT01yZnJP?=
 =?utf-8?B?cU15TUpvUXNGbGprdS9wTy96cnJySVRXRFRwNE9YbkdsbElWaVVOZG5EU1dI?=
 =?utf-8?B?V293QllxclM4dWZDNWY1MC80SHlhbmgvMWJXS2dBYnlXWjQ0aFpFd25CSS9G?=
 =?utf-8?B?WFc4VWtRQUpyVUtlSzVXTWFXdzZ2QndvSitScW9WdStXY3psNWlaWkRhN2hI?=
 =?utf-8?B?NWxmS0RDa3JlRnhsZDFiY2w3bmFqK1crZitMV1UxNXdYUGRrUzFiVWlkNU1o?=
 =?utf-8?B?UzlPTk9jcmxJVWNsWHcxUmNOV2NIR2R5cVJsYVYvb09rV0E3RjBCNUI2M0M5?=
 =?utf-8?B?MTFPK3JFZzAzQlgzUE8zUjVUV1NUNU1qNjBUVXRaSFVxaW9rditrbGVDWlND?=
 =?utf-8?B?U2h6dGpEUUx0VGtTakh4c2FQUVZmYk5SQ3piVDJONjlIMXJ0NGJzSzh2Uk0v?=
 =?utf-8?B?eUV1N1dNU25MMFI5MmN5Wk9ScVIvYktZbGwxeE5WQldINHlGZVRqalV2eVBy?=
 =?utf-8?B?dU4venNkNXY2NE5sdmdzdno5bU1RTlBHRjFnM3RTSWpvNjQwejdhWkZoZE15?=
 =?utf-8?B?SkIvYmdqM3lNaHNBRDI2ekNqUVUyQVJqUHo3WEdYYUN6ejZwRUFUaWdwQ0lP?=
 =?utf-8?B?QlVsMWgxTjB6N05YVFpMOXdYKy9lN3p0bjlycmpreW5JMzFIV01Gd1NKaVA1?=
 =?utf-8?B?NFlSSEhacTBYNUpuVkRWRUlXb1hkeEg3eGIxS1hUZlR5Z2dGM2s4YWNLaTdV?=
 =?utf-8?B?dzg4QW9wbU5jWE0vL1FkdW8rYW54ZEpIcmRuZmF5M3JockVuMkVKQWg3Y3BN?=
 =?utf-8?B?WGpTQUdFZFhhUW9lOVZPcExBbW1XeFF0WnpHajYxenN0YnlpaHVXNDR4T21l?=
 =?utf-8?B?U2x1K1FncmU0YmE0RkNHT2lVSFJTcXpGaTlSbExYM05YRHpRalJGKzRrSDBl?=
 =?utf-8?B?TFRDb2oxZG9odDVxSUlNVDUvQnRXcklMRkZmM0hBYzg2dW5MRExGaFd6bEhW?=
 =?utf-8?B?aWhqUDd4Z3VsV0w3aTZDaWZZNksrVVpvZ29sSDJ6YkFpYVFVZUVuclY3dXlV?=
 =?utf-8?B?K00wR3ZUVGQ1eHZqZEhPa045R1A5eENiU29KVTliRmZOQWZlOC9vbm5CcnJY?=
 =?utf-8?B?aHBmV0lGeEQxUkJwZktXdnl1SmVPd05sRHVoK2s2dHo0RU52c0Z4MU94SWxK?=
 =?utf-8?B?dWlrR3k0NXNRVU9VN0VvZWtWYVB3SnNrVEIyMEdBeTYzREZINjhobDBhVkFm?=
 =?utf-8?B?N09VOVczWUIxbjVyQTZ3b09OdDQ1NUhidDJKV3lxQndDK09wNjFQZDM0L1B6?=
 =?utf-8?B?bUQwODM4cW5BTGM3ZjByZzJLZGhFWkM3T1NJZnJOMllETFQ5bGpPYmcxcnk5?=
 =?utf-8?B?LzA3REpLOU1KUG1taE5DQmFXSkN6QlhZSnBmZ3N0Y3dNQ3JnSmx2MytjYTdm?=
 =?utf-8?B?ZndPZUU5dkZiQzlxR081WmMzNCs0NWVRRlgrLzcrck4vdTZPY3VsajFPWHVV?=
 =?utf-8?B?K1dqVmd3U00zMkJyaDBLNVJGeDJ0QWJaV3B1NzFHdm8zNkExVHFYcXpmT0xO?=
 =?utf-8?B?bS83d0Eza1VJSi9ZdXVrVjNtazNkNlM0SWlYL2ZDVlY2UmV3TXl1Njh1Z29x?=
 =?utf-8?B?blBrS0NRV2JEaEVPV29WUWZOYnhzMk1RZHR4dkNjZ1VyNFVOd28xL1pEZnpu?=
 =?utf-8?Q?BiMgKK7JMsZK53Hjyjb4R2Iq+xE694Lq3p59Rt/aYHIC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47beff31-659f-4c4f-bcbe-08dca7cdde00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:36:21.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5/6cduFAkJu/pevQ9cQOZDBw3mW9W6uLK3RPjqxwDazRIAUmB4w41F2myLklqtRU7iuH28f6AbYMQmZcCzbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306


On 18/07/2024 15:57, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
> 
> Let's limit the impact of the workaround to aqr113c and aqr115c and poll
> the 100M GLOBAL_CFG register instead as both models are known to support
> it correctly.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com/
> Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to start returning real values")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
>   1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index d12e35374231..6e3e0fc6ea27 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -653,13 +653,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>   	unsigned long *possible = phydev->possible_interfaces;
>   	unsigned int serdes_mode, rate_adapt;
>   	phy_interface_t interface;
> -	int i, val, ret;
> -
> -	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> -					VEND1_GLOBAL_CFG_10M, val, val != 0,
> -					1000, 100000, false);
> -	if (ret)
> -		return ret;
> +	int i, val;
>   
>   	/* Walk the media-speed configuration registers to determine which
>   	 * host-side serdes modes may be used by the PHY depending on the
> @@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>   	return 0;
>   }
>   
> +static int aqr113c_fill_interface_modes(struct phy_device *phydev)
> +{
> +	int val, ret;
> +
> +	/* It's been observed on some models that - when coming out of suspend
> +	 * - the FW signals that the PHY is ready but the GLOBAL_CFG registers
> +	 * continue on returning zeroes for some time. Let's poll the 10M
> +	 * register until it returns a real value as both 113c and 115c support
> +	 * this mode.
> +	 */
> +	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +					VEND1_GLOBAL_CFG_100M, val, val != 0,
> +					1000, 100000, false);
> +	if (ret)
> +		return ret;
> +
> +	return aqr107_fill_interface_modes(phydev);
> +}
> +
>   static int aqr113c_config_init(struct phy_device *phydev)
>   {
>   	int ret;
> @@ -725,7 +738,7 @@ static int aqr113c_config_init(struct phy_device *phydev)
>   	if (ret)
>   		return ret;
>   
> -	return aqr107_fill_interface_modes(phydev);
> +	return aqr113c_fill_interface_modes(phydev);
>   }
>   
>   static int aqr107_probe(struct phy_device *phydev)


This works for Tegra ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

