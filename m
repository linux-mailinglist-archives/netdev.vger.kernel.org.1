Return-Path: <netdev+bounces-114135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA229411C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DFDB27A38
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C819F473;
	Tue, 30 Jul 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqNY9vHl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699E19DFA9;
	Tue, 30 Jul 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342341; cv=fail; b=M1YFoeVNZ2KvjCz0gIy2C64hIOKigC3t14ZUVPXn9VnofTLpec/nrA7YyIAPM2HTYFhTUcoHIcDSZeMCJlV0hgNHwxplsrgdE+vUzaRNgrbuKrjaniMw3/0s/EQS2P7RooATr61gQGysPLIvGfUo2UlRDWGUJIRwRMBT1UEnxOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342341; c=relaxed/simple;
	bh=J/EDUd3rj65L2OyT2xdJShRVL7PK1e4s0rfFfdyKFNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2k8hExL7/zJmT66rfMiUgp1FFqPXrW58zUjSdA6ZsPV0JPOr929JM9p0Tq8xR9iw1Y1xjq1uRX4U/ZFWnQ14sXO7ksUCE2LaBmF2uysbw2blaS6HwvF8qL4zUQFVZfUgW6nIxjEDgzYYLoF8sCiHXuZhDLJHmHL91JXp66KOFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqNY9vHl; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGW7w/9h3rl7LavKJCQoHwNeEF1Oga4v/WQveC85vMyxFjmZdxPvTzUxtV2ZtO6OU5EaREYhLdnJPwg4yp0q+4IyfDcHG3gwoLm3sHEyZiVuRO22peDUfo5JoTRMG9cnJQdZnaCeQf2L9kKxymD6zz1YM3UeYbWP9ydBgiXfBZkUFppecETC8YDdXMNYg8UaRwoDaqbKFr2dA7BIwIOfssgEK2FtsYjF7yRfsczRVJ323OkCG3k0SQcLaiWjYgFq1/QNhEZY/KnOW4q+V3OXiRYyR6xwwuQnyCMHY7wIcKApOw+9nP+95qVSYgI1T7/J0OCzMgb8XUgRuAFohvspaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eep7oOvjvAR6db+ITGAaccJsm8yzyT+v5vkr+7v4QvQ=;
 b=L7JrmZKDkmfEr0t16jj1OgVF1hv1QRwVsKtmWdPYfbnfeE7Ksy9v1JUWs0QglVNFheW4vQxxdfMf3ejdo4Nr7osXQLe3SDtSzFud+aV7GBLJGufOPWxx1pacdM8mF7pbSLFhLJ6GqdnLyZlv/uEkHjhL+P5ZFxxKZkhJgxmRINFHHol1xmgaFUMMUajOYbS2yv5IGDKbhz8DwhcIW5dBoi487DmWF8KYTwatn8hNAAMW3qDCcJM9U8Y+GmhBpqPUB5dJre9g0O0q7cEm+5tIJboy0yydugv2FO7wkGQcSEXOFUHXPuyyi5AtIEP29RFLmv1je1A8xtR9+Qw4zIwlXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eep7oOvjvAR6db+ITGAaccJsm8yzyT+v5vkr+7v4QvQ=;
 b=oqNY9vHlzcFpw0hiyhpgBrqrfsJ31bpN9AOH2HPU5ejbfbadrQchASxJqj4UFUJ4CHkr+HFEFF5ohyc/5N1PVXYz/SskWGHxO+zE8yENwhrf9kcS/k52a5FskpyjizGyfYJWsQVpbkIWJPzLYQdd61ZncUo9498ZwuZ6/GuX57fRrfJkCgezz1F4FU4nmuKLROOSizvj3r99ZRcz7gtfq51FolHmubcdHfT/fh4zKCCwjEMM5MIHDFzBkoa+XmNnR/JWoCsNEw0+KJZQzvwCSB/zvR3A8GsUfo384d7ASp+TRmTh5UT7Y23mg4CqjqZg0WbHk7zBdNNe/FjVAtJ5Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Tue, 30 Jul 2024 12:25:36 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 12:25:36 +0000
Message-ID: <9dbb7ecc-6073-4948-8db0-2ed584847f7e@nvidia.com>
Date: Tue, 30 Jul 2024 13:25:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
 <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
 <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
 <Zqi1O88vXK3Uonr1@shell.armlinux.org.uk>
 <22cd777b-ffda-439b-b2e5-866235aba05e@nvidia.com>
 <ZqjKi0iC83BlZ5PT@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ZqjKi0iC83BlZ5PT@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::12) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 777a1124-f9af-421f-6c23-08dcb092b734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU1JWUs3ZWozYU5DTHVMdU5QYmVOeWNRczhxTk1JQzRiQnd1RjN5a3o4eFZO?=
 =?utf-8?B?UjNsN3p2dUMrOWFFY0FZTkdIbDJ2Y0JOclZYUXhLc2ttMitiV0FkUlBZZUNu?=
 =?utf-8?B?NFE5UGhyQU1jZGhxKzZmWHIwcnNiaVR5VjB0LzZod0h0N1ZZVVlSd3lPYlBC?=
 =?utf-8?B?cEJKRHNVQVhOcm1WUEpOSHVLTk04SVREVjlnZHN4TkJicTM1ZUE0d0ZXRHpV?=
 =?utf-8?B?U1BYSXN6N2I0MHJnWW13WWErdmJyNHdxcE9OcmN5TEtxTVNSUmd5VEZMMGc0?=
 =?utf-8?B?Qm9nS294NUlBRytKNTZoWTNUNEU3V0VobmJVZ0tMVkEvczNYeTZ0QnJHOXcy?=
 =?utf-8?B?cnIxUDhhSTZsVFU1MFhOZm1BemJkTVdTZkFVZkpucENlYXdKOEt4NHBSVXVi?=
 =?utf-8?B?SDh0Rm40ZXh2RE1WMUZFRmtUaDFuWHlqQmxSaEVXYWI3Qk4wcDJYRmxJaXJM?=
 =?utf-8?B?UUNtZkorNmk2L2JtVDF2R2ovVVFKQk0yUnFsME4rTW5FRnNrdjFTeFJPZFFw?=
 =?utf-8?B?c1NnbzFuMWVEaVZJMzFWRWxrVXVWQXdMa2tXTUhhMTBLNVJaQm8xVE9aOEIr?=
 =?utf-8?B?SW55WVRLbk9OTnNTL0QwaFVDN1dSRlVWMUJiUjhZV214MDkycUE4NjBBVVpU?=
 =?utf-8?B?TWpXZE41LzBFSUZRTm9MNGszT0ZFQVJ3RWI5OCtQUkpUYkNhQ3BqMlE2dnZW?=
 =?utf-8?B?NFc0a0tYanFZaTZ2Y1BQb05TZGpHaHdlZDVLTFJ4VFZMREt2alQyOGpuWllJ?=
 =?utf-8?B?VHJNVG55dXVyZTJ1WkpHK2xZTFdoZ0RzZzVzTXRuTGJJYzBJaW0yK2Y1dDNY?=
 =?utf-8?B?MjNCb3VnSmFVWW13OE1BdFlWNUdOMUVDbXFsemdGYjBtZnFoSklDQUx0cDMw?=
 =?utf-8?B?OFFxRmpxQW9IK2Y3NDNTT010RnBObC9WNS9oaCsxYXQwakx3M0NuRk5aUUsw?=
 =?utf-8?B?d2hxWUFQUzVOaEhkNWNjbXprZWlGeG1UUkRPVFk1ZnNqWklJYVZ6dVNBM0pJ?=
 =?utf-8?B?ZXRTeVd2c28wWURHOFBtVk0xZVBlZmIva2l2Q2k2ZnVGRjlFbk5NUFJDQXRr?=
 =?utf-8?B?RG5YVU45cllTWk90RWtSaFl6cDFnNFFKK3lMd2pMbFhXdXFXekFHVDJCNEVC?=
 =?utf-8?B?OUhsTnBMRWdyL3JJZm9NNmRXNllmMlpaVWlqNkFkQ2crbStzaDRxc2g4cDM0?=
 =?utf-8?B?ZUUyNUdFM0ZoRnhWNm44ME1VSzR3VlU0bG5GdW9tTnNpVWFtbzJIdStOeU11?=
 =?utf-8?B?b09Jakh1TndiYVJ4c0FxQWZPVEluYzA4TWxkNUY5NWM5NmlNcUFlbjE5cWJR?=
 =?utf-8?B?Yi8yVkY2QkZSZlZzWVpDTWRJeDJidVZvM2JzeklkeHhya1R5WUlMVmFGTmQv?=
 =?utf-8?B?UkFTcFV3OWNRSGxtMUlFMi9lc2VBNmFFRzcxbExaTk9hRkJTdElxMWFZMVQz?=
 =?utf-8?B?amV0MEdUQXpnY3VrU1kydlN2eERBUE9lN1FXVU9IVzBaVG0yc2hLQW5Ea0Rv?=
 =?utf-8?B?MHllNnBaVmJMd3dsNGdLK1RmSFRjdU1FTDI5NCtjTTkvcUQwNVI0Nkl0RUMw?=
 =?utf-8?B?U05QMTJObGdZb2QwdHhPVStrMW4rUDk2U3Q5ZUltRS94YXBKbzBveXVnWVdh?=
 =?utf-8?B?NXhPbmt0MU5zdVRBcWlmRWFRazVSVy9ITmxIRXFjMGFwTThUYlJ4aStKVGNp?=
 =?utf-8?B?VzZ0dndvSFRhVUYwSGlVaUlkbGhuNE5DaTBRaUo3TGZCYnZoREVteDRCMUZy?=
 =?utf-8?B?bjJjU2c1K2I0RGFCMk5PN1ppTGNvMWNTQngwWGJ5bXJiUzNSSDVkenlPTmNW?=
 =?utf-8?B?ZTErUHI4bjVsU3ZYVUh6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVIvTUw5RHVUWkZ3NkZNaXhVYXEwTXpWTVZzQnd0RUg5VU1uQlNPV25YclB3?=
 =?utf-8?B?cCt6RGU2dzM0VkVUYzczdzRIT2V0bmxBaWxlbURjc0FFK1BmcnFmcDg3eS9E?=
 =?utf-8?B?S016bHh0T1Fvb1I4eTFNU0hlNGVPdXRzTXJySGJEbExqbXBlVXJSMVlmNEs3?=
 =?utf-8?B?RGljS2ZKdElnN3JKbFZKV2xtc3ZmUk1mU1VxTmhMdytacFpzVnQ0N09SeTFI?=
 =?utf-8?B?WUQwRVZ0QU5MOWo1Ti81QVZXa2d5MmtUd1N4T1NDdjlucWFXSEd3RExmVjl3?=
 =?utf-8?B?M3F5Y08vanJQdU9rUmw2clR4U2w1NmVTSkFYejdCTFN5eEpDVTdHcThNa2Fu?=
 =?utf-8?B?dHlGZVBRRmNKYW1qMjJ1YWpNVkhyZU9yQWZDZjlIb3JFVEdZTnZLVFI2cnR3?=
 =?utf-8?B?dXFScmNvMG9sWWJMdG80SXlXcGpGZEU3TmFTZ3kzTXZrY0dkWWVYMitYSEhm?=
 =?utf-8?B?S2J3ck5Rekk2b2x4ZFdOTWZYNGdlaVNoc3FacWZMTk8ycHByVzVLTkNRelpp?=
 =?utf-8?B?R1E5WGlWM3FYclNHRFg2ekRDSjdpR1FrZkhVVGdQQllZTkFqenBaczlySGJp?=
 =?utf-8?B?cmt6REdYVlpZZklmcFJxL3J3VmU0M0piUkpzS3A0Qk9iYzJHUWNZUGRQWWtD?=
 =?utf-8?B?YldsS1pJNitWb2VaSzhVR294VWJQTWZQTGxFNlJMRFZHcDZNVEV3d0Y3Uzdz?=
 =?utf-8?B?S2h4ZjB3d1Y0UlNQN2xqQmwyRFpmc014SjBZbUZyUzlpa3NJRzZuU1gwN2NU?=
 =?utf-8?B?eTI0SXB1eVoycDJRajIxVDQ5Z1FzYjlIcnE5dzNQcVphOHBjRmVuYjJIbmJZ?=
 =?utf-8?B?OXBVQTZMbDM1cjJKQzBiRUlncENjSTZnem40a1hCc0ZXOEI5eFh5ODI2Nnly?=
 =?utf-8?B?VzhpdWlNUWgrSmNlb0RZeUNkK01LVVFCQXNsWno2N3JUTld1SERFeDJub2k4?=
 =?utf-8?B?YmxudUZyWlJnZ3pFOVoyQUpSTnNSL3JqeU10NlI3ckhaVnBXVVFwazBYSW1r?=
 =?utf-8?B?dlQzd0dyQkkzRWhDcXgxMlZQb2ZxbFVDdlpPa3RWR0ZaSXNRTTV5RElFK3Br?=
 =?utf-8?B?V1hQWWJGVlRGSTd3Q050WWdicnZkb2kxNFoxY3hhbGJVZk05cGR6UWs5cHpI?=
 =?utf-8?B?TmpiZE9IdSt6MzJiRzdmTFlReE1HMGdvYUpmQWFyRmYyZUVSOVhOODVXaGVS?=
 =?utf-8?B?dktHSzl6SGprSEdlSzZmTDdTckY0cmgrTkQ2ZldYUDFkemtuYkx5WE4yK2FN?=
 =?utf-8?B?TUZyYWtPd1R5WE9KRU5DYXdsQSs2QVZDSUZEd3pBZGN6ckJldzdjUkZsTW9p?=
 =?utf-8?B?cTZVSm93S2N2ZzUydTAwQXUvSnM5VFg1VUNlSHBsUUM3NnhsUEhaVDNnazJY?=
 =?utf-8?B?TzRLcXRZSTZKbzJxN2NOeGdrOHpmTmVJVEtjL0toZmRkWmdnaXlvRUQ0WXBQ?=
 =?utf-8?B?S0lMdlR3T0E4V1hMZmU2NXpYR3VKd2ljQ0Y1SnVqWmdDbEhyM2lTQm1ucDUx?=
 =?utf-8?B?Z3VuQUU1OU9IMTJYRjl5RGtPemU3NlFTNmdhMXhoWnFzTUJ1UERxbWxMMXVD?=
 =?utf-8?B?SmhHckx5RWtsUDhYRVlRL2pwTFg2L1VpWkZXSzhnTUdxMUlPc1BtdU00Y0Nn?=
 =?utf-8?B?V0lLSE9hK1dRMkc5bFBsa2FqOUx1Y2FKWFY4RWxpY1UyZ3k1aGk0MGRlZ0Vm?=
 =?utf-8?B?YWpjZTU1UUJncFRJSWJ6anpxZkRXYWlmRjBOUTNkR3ZWRkZaTU5EdmZsSFNo?=
 =?utf-8?B?d0FRVmdSN3hlT1l1TFBJS2VXYys3MDNUNWc2N1ZoZzdvRk9zc3RRVThuUFFm?=
 =?utf-8?B?elNrL29nSFQzdUo5YitDRndiUnBDNklBV3Jzc1RzVlVITmk4SC9YbE5jejJL?=
 =?utf-8?B?amkyUU1Pc016LzJGT2Mwb2FhRGlTZFNWWkQyQ2dRVm1BL29tSyswc0ZyNEdG?=
 =?utf-8?B?RkNocXJYVTJoUHJDZ1M4T2c0Y2xYR3h2aFowSnEwZ0pzaW5HUndmWlUwMlZB?=
 =?utf-8?B?WVlPSHhXMHdsaklYTllKVGVSYkltMm40UjUwcklPdG9tN2JId096djNjdHk3?=
 =?utf-8?B?WWV0VUtwY2NPaUdaa0Jyb2c3eFZqZXcvS2l4STRtV3VGbW5nbC9HS0haQUIy?=
 =?utf-8?Q?jg/xMJ2lfDNzMqqEP2gtFtlVs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777a1124-f9af-421f-6c23-08dcb092b734
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 12:25:36.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PM+7fjxCiJsWlVz0241vfWUbZ7rI7U696QuwqAePxreSwPFAaj1p/K3/wZ30WdrwJpQhUOHAQTOvU3idcu2jLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542


On 30/07/2024 12:12, Russell King (Oracle) wrote:

...

> Hmm. dwmac-tegra.c sets STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP, which
> means that the serdes won't be powered up until after the PHY has
> indicated that link is up. If the serdes is not powered up, then the
> MAC facing interface on the PHY won't come up.
> 
> Hence, the code you're adding will, in all probability, merely add a
> two second delay to each and every time the PHY is polled for its
> status when the PHY indicates that the media link is up until such
> time that the stmmac side has processed that the link has come up.
> 
> I also note that mgbe_uphy_lane_bringup_serdes_up() polls the link
> status on the MAC PCS side, waiting for the link to become ready
> on that side.
> 
> So, what you have is:
> 
> - you bring the interface up. The serdes interface remains powered down.
> - phylib starts polling the PHY.
> - the PHY indicates the media link is up.
> - your new code polls the PHY's MAC facing interface for link up, but
>    because the serdes interface is powered down, it ends up timing out
>    after two seconds and then proceeds.
> - phylib notifies phylink that the PHY has link.
> - phylink brings the PCS and MAC side(s) up, calling
>    stmmac_mac_link_up().
> - stmmac_mac_link_up() calls mgbe_uphy_lane_bringup_serdes_up() which
>    then does receive lane calibration (which is likely the reason why
>    this is delayed to link-up, so the PHY is giving a valid serdes
>    stream for the calibration to use.)
> - mgbe_uphy_lane_bringup_serdes_up() enables the data path, and
>    clears resets, and then waits for the serdes link with the PHY to
>    come up.
> 
> While stmmac_mac_link_up() is running, phylib will continue to try to
> poll the PHY for its status once every second, and each time it does
> if the PHY's MAC facing link reports that it's down, the phylib locks
> will be held for _two_ seconds each time. That will mean you won't be
> able to bring the interface down until those two seconds time out.
> 
> So, I think one needs to go back and properly understand what is going
> on to figure out what is going wrong.

Yes agree.

> You will likely find that inserting a two second delay at the start of
> mgbe_uphy_lane_bringup_serdes_up() is just as effective at solving
> the issue - although I am not suggesting that would be an acceptable
> solution. It would help to confirm that the reasoning is correct.

I was wondering about something along those lines. We will go back and 
look at this.

Thanks
Jon

-- 
nvpublic

