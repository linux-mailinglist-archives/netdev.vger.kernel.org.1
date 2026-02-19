Return-Path: <netdev+bounces-259430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GqXH6jolmmNqwIAu9opvQ
	(envelope-from <netdev+bounces-259430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:40:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5615DEED
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7EA3013A84
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17130E0E9;
	Thu, 19 Feb 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cShmUtm"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE22F3632;
	Thu, 19 Feb 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497618; cv=fail; b=DDFW1KKC92789+GGqBr9oJEH86WdIbls5jUtgTQGf6OCINDcd/5Cfv1wFFvDKgJf+IoxU41byb9jiaqhbhciKP0uCShGcfYq34mOAd/QN3iTXBx97M6I+4FmSd30dZVSHVMN38iDb2VVTpUIE5g4WMWB3bauecrxeY4XhL3EyuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497618; c=relaxed/simple;
	bh=I02+um4OVkHPgFgNowpK14QSpYvYcJM1rM3mH3K2cjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lu42eOz34B16ci31O6EAX2qeiT4JJMC50aLDeV2Za1oCxJlbH6sUCmHSy88FcVUWx8HRtDGI1c7c2+xBYVqQgsMVYpqGsdYAyYSMKfE1Zz3gcLlbvtDKtLqDxo/tXzmAHhS0K8s+mKK+qlU8uzMNcG965LRn0NN2CQ99lyLaZc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cShmUtm; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ+0C1JDuR2iHH5wU1YHaWuA6qBSrR7vulHDnHmpym34lbTkv3A5hmJZU86bQe28JNpPzQVFQmujB3gKhkfJVFdsj2jSYJIakdsBgDsJ0YGyl8p/KeSwFZwdfSpq4cE2lqd/hacJBw4AqeR5PTEM5VrrPMuvbZqg0BoJVhQjxoYT/mhRodEJ6ZxD4df3v7MXftycY8yxlOwkx2eHimVVVbAX/zx+Mm/t2cTVGnDex7yPn+oTAy7ZLLJQkToBb/+KwcIrIfzpLUEwzK4n/SAD83JhUYHQUDNlJdB3W1yzF9poKec1H+9VxdfNDoMWRIWZlbewW/bsqcNgMAI1ATq/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3zJmNSUtg+4miGhjoiqjtmxf0BHN20yllzSAmPhdEs=;
 b=f27Y/qUoK/4fAqWsKKul7TrgZ/mUGmqNmUOvTnncNzv+4QDm+d+IGQ1EYExyOsmBRg7UZz1VFGmwIXm3C0bhxCXbUMBLsYzYdXVNUyYd2xz7piwlco46KS5KKViBSPKvtshBt0Q16VjbqLjJKS4Kq1T1u/Tx/gJK15ZV6S5UuS1guk0Ptco8uUluf7uKmoLCXDOZuAZ8UIOCZUv2tzCdYAq93e3cqk/RJqpUgiZ91NgiQxOnAYtvDJI+xb7XBLHEV1Mxkfhksu6F1spcQf/97M+6UMugNkEH1Q5UPAM3p4tSv1xL1Qnh9VX0bhmYNfZ93MM3xhtRnA605hY4/uzRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3zJmNSUtg+4miGhjoiqjtmxf0BHN20yllzSAmPhdEs=;
 b=1cShmUtmMDM9lAlTp63YN0GlGE8ujVXYDZ+5e+UenAqoq8LLVFGeEBNTNcTQa6b/lyLo+wpCkaSFZOoAdkzvwxLAAYLdKP3LxR0iq21NkhOmFAX7izqHqcx2ky0bV7HKcXvsAypCNCj2Cye/JtKgFj/jKewVOgy/7NBl1t6o8pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Thu, 19 Feb
 2026 10:40:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:40:14 +0000
Message-ID: <62be78b6-1d5d-4b5f-aaf7-62996536c97d@amd.com>
Date: Thu, 19 Feb 2026 10:40:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 17/22] cxl/region: Factor out interleave ways setup
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alison Schofield
 <alison.schofield@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-18-alejandro.lucero-palau@amd.com>
 <383d7089-d7ca-43ab-8284-694e60729770@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <383d7089-d7ca-43ab-8284-694e60729770@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e13a59e-9b13-494c-1fd5-08de6fa343b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHVsVkFrK1ZjdjVja0xmUjl6MkVmWWNXaG9FZk45bnhzNzJXcms5Y3JiQ1RX?=
 =?utf-8?B?UEJkNWdNV1ZlS1V2cmppR08vNWs4aEIybWNUQ2RBZXZWNW5GaXAxTDJkVk1C?=
 =?utf-8?B?ZTVIdGQ0Z2pIZ0NmWHVOZnBUcGM1WnRVeVlKWkJCSnVtRTV3cmV1WE9hVWQ1?=
 =?utf-8?B?VTFPUEExZVNVNE9hRTVOR3BPUUdES0N3dG1YR2kra0hwcEQyZmV5cG9wUkx5?=
 =?utf-8?B?VnRoUnI3K3dsL1lMblhxK2o4bEk5K0I0MFBuVWhiMlZpUUpUTVJNZHlEeG9B?=
 =?utf-8?B?TTBSZFIxM1BId21hVXhUcnR4Vk9vb0NCSFpIYVkyYjgyVnlCWWRuKzhjKy96?=
 =?utf-8?B?cUpwWm4rUVA0QVFvbnRhaXJPcXN6OWJ0MTlmRWM4Z0tBMGpqb2hsRWJUTk5i?=
 =?utf-8?B?aE83QzhvMmc4Z1prdlZsZ3Q2cEtJa0JyNm4rby9CeEFDdUxZajFxbXJHUmlt?=
 =?utf-8?B?cEt6THpjclVCZVhUaGpxNFNpTmt1MEs5L1h3ckhiS3FmcGtwRXJZT0FsK3Fk?=
 =?utf-8?B?bE5uZFVmQnV6Wjd3aUFPVCtDaDUzOHM4SzJkdXN0TytDVU5oMkdEeTFDYmxJ?=
 =?utf-8?B?Zks1bWdMUVZlUlRlR2Z2c0szTnE3UkEvenpJQTlxWndKQWJJMzUvNlpMbXlm?=
 =?utf-8?B?Mm1SZ1hpc0tSc0xac211eXMzejFtdlRVVUxzYndxRFNrdlJVQUZVSlBIbFgr?=
 =?utf-8?B?aXhlaVNkUnd1ZjdNRVI2eXJnbE9ZZkdPak9TcURrTUlxZHF4TFBUdmZwZFRz?=
 =?utf-8?B?Nzk3cndVZ3NkNUZKb2tBZ0IzaEw0dVl1a0t4QTZ1bVJpSWNNbmdlQVQ5aUJq?=
 =?utf-8?B?cDF4NEFXUmZoSkEzWG9peWtlYVdIMzRwT3k0d0V6dS96WDRyTVBoUGhZekkr?=
 =?utf-8?B?a2pkYkxUNjNLL0txQkNJeXgyMkc4ZjA1ZUl6cWtyeGd3aGNuL3F5NG5MRjRy?=
 =?utf-8?B?SEhXOHhCMTRjQXZBY2swZVNMQXZKSzZOZW9NZHA0QUxIR0xXNzRkRWxxZUNY?=
 =?utf-8?B?azRldW53MGx1MHJ3TmRTVVZnUkkwWWlRbDhTTy9KZmJicjQ5Zm0zVDh3SFFX?=
 =?utf-8?B?YWpEdmNIZURTZkM0ZUhBYmR5VlAvV0RnaU5kbWdLaTgraGM3NjBOY21VbGwz?=
 =?utf-8?B?RTNoTDBFcjBmbnVySmRCQXhHZWc2SUpYMWZKSG1GOXdRTlVBbE1hN3p1RGs3?=
 =?utf-8?B?QWhTVy82QVVWMWdiUEg2OWZlWEJwNjI1OTJpN1o5YWJidGgydWxKMC9MWGRV?=
 =?utf-8?B?UHBFZUJmNmdPeHN2ZGJkVW9NSVlhYnUrSVJJUUFZcTdzaittWkUwRmw4MElX?=
 =?utf-8?B?VXB6aXVTeVFNNWJXUkw1N0p2SjdFbE5SdWtmV05qUWJyZndXb2ZFeHRZYmhv?=
 =?utf-8?B?NWZ4ZEQzL0wxME82VDg1Rkx0dzNLS1QrMmNLYkxack9SUVVEb0xteExVMm5L?=
 =?utf-8?B?UkJiaURrUVZiWWU2MHdNZXlnK3kxRUZYRUU2UWZTcXkvQVYxZ1RuejZqaitU?=
 =?utf-8?B?RnozYjJsczhEV2dIc2g4VWRPNStJcllKZFF3SjJiSGpnK2I3a3o3WXBFU3I2?=
 =?utf-8?B?OU9ueklPWXJZaFpBeUNQUHlWaXkzL25RSE9RV1huNHk2ZWk4bkVWeUphSUpx?=
 =?utf-8?B?S21tS1dCWU1RRzM0UURocEtyejlUbnJLSVR4S3dsNE1seXMwWncwMWZZRW9Z?=
 =?utf-8?B?SmtGTXA1SDczeC9IR2hTN2d2VGJ1YTYwUTlRQUZpcVpmS04vcHJ1K2ZQaHdm?=
 =?utf-8?B?ZDc3VGk5Nmk1UjJPTk1XV1Y5TUhGbHFudDkvVVJRckNjOENuV083QThlQ09D?=
 =?utf-8?B?UnJZOHJmUlYrVFZnek1TbExmc3daWjJYTCtOWG9CbUhiYXdoSExHY3ltVVVU?=
 =?utf-8?B?cEVmSnRYelllbGhsLzVUclF0eVNVdU9SdnIzdEZKUUY1bjFra3lUVHQ2bEZk?=
 =?utf-8?B?TTU0d2wyblhyTmdKcVBidzgvT0NmK0g5OGthanVOeVFpVTFtK1JwTFREbWNM?=
 =?utf-8?B?UnBkRmszTFlNRnd2V2dzYVh0V0pUMkQyWW92L1Q4SXpuOTRJTmtoTDdpZ1BF?=
 =?utf-8?B?VWJLb0REdXQ3OVVxK2pSVzRGUmN4ZnNObG5aOGwwZ0gvUCtkdDArajVTWHJk?=
 =?utf-8?Q?0WRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cERZSzVMbzhhTGRhbDFUR0RzRjd0RVYweWI4ZG0wVEZpSUpKSjJiOXpXYVhx?=
 =?utf-8?B?M0JFWWpVT0N6VjNHc00rS1RQU2REVW9Ba3FnUi8yYjQ1TWNyYmcwWVM4eFZF?=
 =?utf-8?B?L3hpS0l5bFlaWlVnQngyUnJSTGlKejNUdGNiSGwwOTRCNHJBSmFtL2w4RTQ5?=
 =?utf-8?B?eElwUVduOEhDWkVnL0lLcVFtNU0ybW80TkJBT2JTTGs4amk5bUt2SThDWGhP?=
 =?utf-8?B?cFRGWnk4Mm5IbW5ZWXhDSU9IOUIzRkdqbFRWTHhZcmlmTWdTd2RaQ012b2NV?=
 =?utf-8?B?dnE5VEtFQ0lpU0hjVFFBTDU0dEszc1g1MWNHTEVFcHNJVGYzdk5GWnVEK3Nz?=
 =?utf-8?B?TG9rVDFwUHRiTzJKNFJvT0lucDJnRUp3KzcxVXpOZzh1ZXF2ZU5Sd1dlaWk4?=
 =?utf-8?B?WlhvbnEvc0UvRlFNNmd3MEQzdzRBWEZkKzRwUmNOa0pTWFJNWUQ4YUZxT3Zh?=
 =?utf-8?B?UFJScGQrakxITWJBVjh0N2dZdU1wOWZkaWlxeVR4WWxBUkFSOEZmZjF5bUtQ?=
 =?utf-8?B?Qk52YnhMNFErUnNIOGhVNXV0YVBDVzMxcWR2Sm9pZVVKdEhtN3ArQnFIdSth?=
 =?utf-8?B?VnU5M2x3S1gzNnpmRTgvejV3SXJMTDIyMlJpWWRVN1pLYTRTKzJPS3J1UU53?=
 =?utf-8?B?RTdacmlPczZJT0ZWQ0luclM3eEFhQlRTVnVuL2pEdHd1U08wVDhIRDFPQlFZ?=
 =?utf-8?B?VDAzVkxTbnRYWkZwUlErNEUxMjA0WW5vWnFMN2RRZUl5b3Q4d20yNkRSUTUy?=
 =?utf-8?B?N2xlYm9rNDF3NktOSXFHTlQySk1DNlphd0h1WHRUWi9tRkQxQklVZHJrWnZh?=
 =?utf-8?B?Q2hxcXRjQ2tQZkJFNlJjenZPUStxVWNVK0JYNWVPR012LzVFelZwL01NTVNo?=
 =?utf-8?B?SnYvMy8zYXIyaDlBTXBVa1VQZ0FBdjZKcEk4S1IyOUVNekZ3T3pDcmRvdUph?=
 =?utf-8?B?ZnhWdG5mVG9UMHY3MERGZlVHeWsxd0lLUWE5ZVY1eXQ0bkowVi9jZzJJVUQ2?=
 =?utf-8?B?OUZaL0ZhRnd6UnRLcGZZblpFcmR5S1kyd2FoTDdCYkNrYzByWHd2dlpkZTdS?=
 =?utf-8?B?ZEVTc3U4Szc3S3ZESStMMk5RbUxIQ0RXWWE3OFVDNkErK1hiSzNBNnoydjMv?=
 =?utf-8?B?WlhnczAzZVNYeEM4cW5rQlRhSjFVMDR6WUZuY1ZvcUt2Mm5uazVpL2d4VDdj?=
 =?utf-8?B?YmdHRzdOcVhISU1qUUg3aldlRW4vWG00ZzdmVGh6T2xqM0cyY3N5VzNmcVkw?=
 =?utf-8?B?c29wd2NrL3NaRFhwSVBiekpCR2YzdHpWVUxFbGx5Mjl0dWJ6ZjltRnpwOXhD?=
 =?utf-8?B?ZHFnUFNxblpJc1l5QW5JM0k2K1E5OUcrVVF2NWhkNHZUT3YyL3luL1lGQTZQ?=
 =?utf-8?B?dDNYazRXNnNTMTQvNkpySHlyMUxsQnBieUdWR0ppbzR2WDlLWlA1K3FCUEFH?=
 =?utf-8?B?bVpFbUliYXh1VDRldnFZMnN3QXlpSVhQMWxxRVZBT3VJaEc3VmdkYnlsYTkv?=
 =?utf-8?B?NVROeXlGbzkrTXkvRDE1MVF2UlQreWhoa0FLd082SHdZeVJIdnpBcXBXcUpi?=
 =?utf-8?B?T2tGYUF5U2RzM3ViK1lOTGYxMk52NkVhcTBQamFrcmF6ZWhFc1VXNi9ZMk5R?=
 =?utf-8?B?cms5K1lxK2xMeFFLcWVSdEpSUCsrZ2pVMDBrTnBPemxiUjZSOWNnMkxQZ2JK?=
 =?utf-8?B?SkNPa0dwc3NERTFVWm5xdDVwYXJ2YVozUjRnTkZudElyQ0FtQTJSMXNXR2I4?=
 =?utf-8?B?c2xsY05yRTFYQUxlWmdvYTdQWkNKMk4rMTFWa3plWHVKUWZTVTg1Yk5pWUsr?=
 =?utf-8?B?dEJ5TTQwWG1WaXhvS1FWS01ZcW1nMHZCeXJMQzNNK1FLRitvZTdCczhGQmhQ?=
 =?utf-8?B?MHhXU01xbnJadUllcHgzUkpYbThRMTBEdXZHR3VGU3RmaS9HVVd1c3MxMEt0?=
 =?utf-8?B?aUt6dW1nOG5YUVBOQVo5MDB3R3hQZ1ROZ3R4ZXBHaEl6NFhhdnQyKytGTmo2?=
 =?utf-8?B?VHVabkpnR29kaG92VVRYTkZkSnVJbW9ISGlaaTltMnBxTXQwMkNFYWYrV2dl?=
 =?utf-8?B?dW55eGRpS3ZnNnFWak1XOUd3dFlMU1Y4R0hxK1c0eVhRUWhBcTk2c05iYUVj?=
 =?utf-8?B?VFlvdWVoQy9CZk9Cb2pxUzY4dVUxTzRCMitrOWRLU2RTbmp1ay9DeDZZS0dU?=
 =?utf-8?B?NVFiczc2RGdYd3A4cGlWWE03eGoxdHB4MjBOeUJxUmk2YjBwbEwzQUZSejJw?=
 =?utf-8?B?K3RtVm42cnpmUkVOdjExb3E1RGFqRlhGbzNvZng3ZkM3VW85OUgrU01FVnFz?=
 =?utf-8?B?ZURCcTNDd1pRVTJrbDRLVUlCU0FTU2ZrMXhRbVl2NmJzSmtDbnJ5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e13a59e-9b13-494c-1fd5-08de6fa343b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:40:14.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJQiNh+ADYIAevgGsqnhY3bxOYKTDDrLOOJXKruxg1qlxHWwtjO6iNlvicIf1VKHnpaXQsQNjiMsiie97mL8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MSBL_EBL_FAIL(0.00)[alucerop@amd.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,intel.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 2BA5615DEED
X-Rspamd-Action: no action


On 2/11/26 22:11, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation based on Type3 devices is triggered from user space
>> allowing memory combination through interleaving.
>>
>> In preparation for kernel driven region creation, that is Type2 drivers
>> triggering region creation backed with its advertised CXL memory, factor
>> out a common helper from the user-sysfs region setup for interleave ways.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
>>   1 file changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index f53b2e9fd9e6..ece1d3df7cf1 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>>   
>>   static const struct attribute_group *get_cxl_region_target_group(void);
>>   
>> -static ssize_t interleave_ways_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf, size_t len)
>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
> @val should probably stay an unsigned int. You pass an unsigned int in the sysfs function, and the
> function was originally coded with that in mind (same with @save below).

Good catch. I wonder if I should just change the way the value is 
obtained, using kstrtoint instead  of kstrtouint, as those values are 
used for cxl_region_params fields defined as int. In other words, it 
seems doing that simpler than changing all the other places you mention 
and the structs involved. I can not see a reason for using unsigned int 
so I think I will follow that approach. Tell me if you think otherwise.


Thank you


> With that cleaned up:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>
>>   {
>> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> -	struct cxl_region *cxlr = to_cxl_region(dev);
>>   	struct cxl_region_params *p = &cxlr->params;
>> -	unsigned int val, save;
>> -	int rc;
>> +	int save, rc;
>>   	u8 iw;
>>   
>> -	rc = kstrtouint(buf, 0, &val);
>> -	if (rc)
>> -		return rc;
>> -
>>   	rc = ways_to_eiw(val, &iw);
>>   	if (rc)
>>   		return rc;
>> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> -		return rc;
>> +	lockdep_assert_held_write(&cxl_rwsem.region);
>>   
>>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>>   		return -EBUSY;
>> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>>   	save = p->interleave_ways;
>>   	p->interleave_ways = val;
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>> -	if (rc) {
>> +	if (rc)
>>   		p->interleave_ways = save;
>> +
>> +	return rc;
>> +}
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>> +	if (rc)
>>   		return rc;
>> -	}
>>   
>>   	return len;
>>   }

