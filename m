Return-Path: <netdev+bounces-141634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D679BBD6B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87A9B21760
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B81CC177;
	Mon,  4 Nov 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="vk9hzPek"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022114.outbound.protection.outlook.com [40.93.195.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6C1CBA1B;
	Mon,  4 Nov 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745896; cv=fail; b=U5SpwfW15b7/2UHUFQhkbU9cgaWqpXbBq3ALMO5VTFpcS1QAf5q8ds2tEv/zgNQgZqfpNAO6nSdoAKVQBJcwU2yUYed/fQLFjEmRCyunEegjZi097J0Sc3KhyNl5dP+f7CBlHUHVGsFfdZZHQQJtYPrsR0p83VTDPSH/gvRvA6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745896; c=relaxed/simple;
	bh=xjlLYKSY2FkHXcH/u3jhHrKg4kvbSeeW8xsyXSdOoPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuLj8lEI1VhhbRjHmix+LuB4m7NEh5JSWJ1vdBQaQNMN6LaKiKUl3e+tXwRs8JoiMMii8G/zX/GBV/bMSIYByk3AESWueJbr60gx0GAIVb0Wc++ksAOh9zwWlSmkaPiTG8A/lhPUN0WMfrWNxn9baDOYZuAwhaCQfkHFoe4n0qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=vk9hzPek reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.195.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgW0bcC7xuM3O487pUmnlXXvaCsJBtCunjGAwAEWAK6mfy28wKRaB+TPtId88lnEsfUKj18q4d2BqCLl1HE2JKnlUHlmfsFhU8PS/r2IJt0E5Za5qWpoIGz8cSJyEcKvuxFdC03pjnpTn2kXRZ9oelkxJVk4c0z+B+5LuwUtkrU4YpNtxE/LaoU3bRrd9yla25s5zMEil8sV/y0Y8ne4Cru4a9ihoHuoclP0dQxFtYd1xj4c4FgIqWi2aXld38t7GqHX5ZpaBn8qNZpxRpejKd+Nc/14kEpLMbHWTqUY7yw7laaC5sX3lh1N70Imt6xbvp2cqT0KnhE2VHBj+nM82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngi9PVjjbu/NIx1c4xNoXGrhvrT+JDnWtUiB4IbqsZc=;
 b=eByAi2XqAp37jNJJvV8I7Op88FgDVu0vk0RBtBv9d+7JWP0gLDh9J5QATxdkERoQd67iWgV4uADQ6r7WVGIqqIUdbQBhCuZ1ww3VIYnoTMyjyjFeUbuBciqptZsHfgzUKMErrDXEP/TdCL7BwOXCeGbNv1+fkiVp85yolBUJWihJV8zfWI8Xz8MOMHm7C4i7CSE4v3NtawlrnJe1luWP7xpVj4ha6js+TwnI2qNaVsgD84uXUG5Il7GwKP5kgar9pKERfLl4z+LA1awUgF7BufFnuFMg02j8yKI0sFE3IU5YugVfSL805P1IQl6xVHt0uxP8Qosab6Us7Vu1NUJFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngi9PVjjbu/NIx1c4xNoXGrhvrT+JDnWtUiB4IbqsZc=;
 b=vk9hzPek41u0lbpaj8Och+IFMbdJxHovqNfISBprhv08btpe9J0EBhBzY9OwUaDQ0a8qG7/QW0QddwOOHL9kDwO/kqoALNhUMbkFOm75kRHnB8jel394Cn5YRi9TzAmMAs2dlvSyy0JElUTEwGsLPqZuSWYyU0zabkru3jFQ1UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH0PR01MB6953.prod.exchangelabs.com (2603:10b6:610:106::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Mon, 4 Nov 2024 18:44:47 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8137.014; Mon, 4 Nov 2024
 18:44:46 +0000
Message-ID: <fb13bbc9-9afb-4c69-bbd6-354db395813e@amperemail.onmicrosoft.com>
Date: Mon, 4 Nov 2024 13:44:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
To: "lihuisong (C)" <lihuisong@huawei.com>, admiyo@os.amperecomputing.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Robert Moore <robert.moore@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-2-admiyo@os.amperecomputing.com>
 <a05fd200-c1ea-dff6-8cfa-43077c6b4a99@huawei.com>
 <38fab0d5-8a31-41be-8426-6f180e6d4203@amperemail.onmicrosoft.com>
 <f44f9b12-5cb1-af1d-5e2f-9a06ad648347@huawei.com>
 <d9969244-8f4c-4f66-9ab1-064be665495d@amperemail.onmicrosoft.com>
 <6eba7c8b-000f-7be0-4a8a-53bf8d6dc25f@huawei.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <6eba7c8b-000f-7be0-4a8a-53bf8d6dc25f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL6PEPF00013E01.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1c) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH0PR01MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa663eb-1a5d-4b8f-6820-08dcfd00c172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUtremtyTFRXbDBBclg5S2hqWEg3VjMwSVMxV05ISS9IUkVhdm0zdjBsazBC?=
 =?utf-8?B?OUQ0ZEpRWVpqUDBJRVBYR2w4WjFSSG9oVXdKRWtYaWhZOGZZT3ZjWnozSG5W?=
 =?utf-8?B?TmtKNnYyYWhtTHRURjBMRHNRMnlHUCtqWjBiOWg4OENaRW1Dejh4THhDWjFV?=
 =?utf-8?B?a3A5d2c1QWVYMXhEbnZTYTZzYXExNHZuTDhXMm50MU9PWWI0OXRLeGtrZk85?=
 =?utf-8?B?OU5zakRiZjJlZ3A2YzR4VUJSWkhyVVRvTmdCeWpkMHRpZkIzcXBlK1FPcUMz?=
 =?utf-8?B?QWhWTkJiZzBjaCtvT1ExUUZOcTQ1dG5oMXh6TE96OEQ1cnVpcFp6cE5DZmc1?=
 =?utf-8?B?aElrT1dYZkRoNmwyN3F2M21WVmIxRHlaTTN5SFJZblhyTFZveUpIUEdBR2I4?=
 =?utf-8?B?czVPVFZHeTBXQmV5ckFaS3dpbE84SDhUcjJEdERISE1Sc1cvRlFYRVp0UE9V?=
 =?utf-8?B?L1hIOWdJMWVyZHYwenE1L2hvRXJreG1WQVNWK2NoTTBwSGxjNW9XZDlyN01q?=
 =?utf-8?B?Vk8veEFpRldmMVZ2aUZUemVzREkySmRmaWVLcHAvNW1SUHAxZzlydldWMnU4?=
 =?utf-8?B?cmpTNmJmYzk2NmdNOStoMm5TWWtWZnNiN3o5ZDZhbDRGMitGWENkdWtMK0tJ?=
 =?utf-8?B?SHpxWUNsTGxOeFdHQWJxdEVPZUdZeUhxVkdMRFhOWm9YKy90L1RNMUpRNFBu?=
 =?utf-8?B?cUFzczNEQzliWk1WYTlnQThZbHoyWDk3d1BpQ0tkZ2FybzRpazBSTnN1VHBt?=
 =?utf-8?B?ajl1WWJqR2Z1NmIrN0xBeVNLcnJRNnR1M3lkMVlicmhRemVKUGovd0ZlN1lh?=
 =?utf-8?B?OU1Iblo2NWFhY2NYbldhOTJLallITmxpSEk5MUdlVjdvdTJ2MEs3c1BsZ3Mz?=
 =?utf-8?B?OW5LTll5RkY4TUxhbTNMYkVocFo3eVVPek5qUDI0Umh4eGlBSkhkbG9tclcz?=
 =?utf-8?B?T080WnE5aVdFR2JUL1BpVjNqVWwwSFR0SGNCbVBwakZERStyWGV2L05iTUFC?=
 =?utf-8?B?U0RMYzk3b3dSbytYSHhUeHhMNXdOYlk3dDdkWHZZZ2c5VlJyS05yMlF5dE9h?=
 =?utf-8?B?b29TU3FRYjVSQzZkMENZU2JOK2ticWpoVnVCR04wc0d3c1ljNEkyZlZhdk9j?=
 =?utf-8?B?T1lxdUltU3VTeGM1bHhoWlBwaXA3YVhKZC9KczZvQzBnNkZlODJGYy8zOTVm?=
 =?utf-8?B?V3VldXFHWDk2RE95UUxKL2h2cUtOdWhSeGZLVjlSTzRibWQ3T1dhZmwxR2dw?=
 =?utf-8?B?ai9qRHdsMDkwRE5scW81NlQ4eU9DdWxUbkUzWUFaalQzNzFiQVFoK3FxOGNG?=
 =?utf-8?B?VW5jRzlHWEMwMWZuQWVoc0pma1Y2SnQ4NDdUY3E2NkJXR1BESWw0ZDRSVkwx?=
 =?utf-8?B?VkIvamdpWS9BQ0VhYW5KV1NBL1A0SkJnTDBsMFhNOWlQZDVEQW9Xb1FmbFhZ?=
 =?utf-8?B?eFU5emZOUmdxc1N1VHg4SVlCb1cwbWc3RTFkZ3F1L0U2T04yVDB3WkViUzU0?=
 =?utf-8?B?Sk5UMjhsWmFkWlppaGtFc1lxY21tQm9TaHZrV3h3c21XQ2pqOUlyMDBVODBl?=
 =?utf-8?B?Z2l6V04yUTdSNk5KalF5NGJyNkp3bWhtTkg1LzVQTjN0VG5jWkJub2N0WmZR?=
 =?utf-8?B?aG1ETGF4Zjg3dXRScmlkaWtvQU9UVWlPKzhralB5Umc2cEhmMUtCeTN5alRv?=
 =?utf-8?B?L3ZFb1VrL2oxd3h5aFE5VGd2TGFlWXR1Q1l0VDJzWHdmUk9EWndvRFFxeWFI?=
 =?utf-8?Q?Luc1C5yfN9kH/WKzK7AzFq8q96/husC5+CrqiPN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnd1UGlBQlljYWFha2lZbWJjSGJHcHMzbTA5V003bEtBYkJpcmF2SWlRVXZE?=
 =?utf-8?B?Wm5ZRU12cEl5b1Q2K1hOVmZuWHlVc3huemhQOUdRU2hUaTg1MnVEaFl3UjY3?=
 =?utf-8?B?WUlDcUpINm05blRZcGp1aUx3MGtFTHV0ejdualhnam5DYmNScGM5T2x0TkRZ?=
 =?utf-8?B?TVlubTRnNjhtZDFJd0lndnI1NkFjeWRUeTRWZ1kza21WTFFFNjVzd21FK05x?=
 =?utf-8?B?TmJNK2hJdC9nQjdLNlkwZnR1ZEF3THV2bGVmTWxKeHhkOFdnaEFMRHRub3BN?=
 =?utf-8?B?R3FvQmhydWRHMDIzdTZ1UkVXdTVueFk5UWhuNWY1aGVMNlFxWW9aZXNsa0Mv?=
 =?utf-8?B?ckg0THZKVHZUMTc1N3JjVy9ZRTZUVnI2c0JydzZ2SzZzaDRNNEZjck03UnNK?=
 =?utf-8?B?Z2IzNzJNd0FnaWtreTFvWUFDU0Jxc0grekRGaDBsTjZYSCs3MThpbndidHQv?=
 =?utf-8?B?aE80YUI1N1Z4a01PbWM3T0ZpR2IzMTNxcjl3aHBZU3R6eVJQM0diY25XUVR6?=
 =?utf-8?B?bG5HcWd0bThuL2NnK1pGU2YyV3hPVnNFdzZweTdrdkhJSWdMcVZuVGt3d2Nu?=
 =?utf-8?B?eUpnWWg2b2Y0RHlibFdVY0tuWmE3N0JodjlndFhtV09NWWNjTXdPbXBpMkMw?=
 =?utf-8?B?bnU3TGdsVkc2NXdRYUNmWTdDMHR0WmNsR0U1cmx5UEgzR2RsaDNsZFpvaUlW?=
 =?utf-8?B?cU5VWE5kWEdETXNVRFJkVng1MDZxZjBOeVRaV1ZUYUhodGFtL1FEV1p6ZU9s?=
 =?utf-8?B?bitiUllqL3ZRUlUvM0RDOUJhS1JXVmRmRldMN1ZSNE5MOHNvWUttd2R0eEpk?=
 =?utf-8?B?NkdWZXBCOVZ5eU82UDNaRWlnN1FJeFAvNFh3NXNYc3ZhMDlGK0txd1RsME0w?=
 =?utf-8?B?Rkpid3ZXZ28zVTFDMStOeS8wdkFTVmxsQmhOWWwrS0daNXFGTEdPN2NhQy9w?=
 =?utf-8?B?eWUvTk54SC9XR2k5a2JRTTdkYlQvZXQ0Nkl2VWhIWUZGeDNCdG1NZ3RCaHpZ?=
 =?utf-8?B?QkxJZ2IyZE9RZHQyVGt4d0NaUnowRDhEa0lVRzlzQzJ5MEtBanpSUUM1ZXRZ?=
 =?utf-8?B?K0JMMHJBUStsNEZtcTk1YVNBMk1kWi8zc0lGQVpnYkplQkI3NmZnbkV1MGpP?=
 =?utf-8?B?QUYyR2luZTJpTWlENTBwdEZPRnMyR0tRVmhETlR3T0RienB0dWxTaDhoa2h2?=
 =?utf-8?B?SjFmQldBQ1FLYVZGSHFtbWM0VFgxd3NtN3JKTy96L0N3dEhjdWJPQ1ExV1NV?=
 =?utf-8?B?ZmJpY2xuck1rNE5FTC9YSTgwSld3VER4TUwyZlBvV25YanFlayt2ZzVOaElU?=
 =?utf-8?B?K2MzSmNTcVd6OEpFbnlOenFmQ1dWQjFvZDM2U1ZqU2lpY3huQTR6MUVKc3dO?=
 =?utf-8?B?NXpjVkJ2a1ZKbmRnYWd4OUVFUGtGVTZWRjFGbUJKL1JnYlhseTZxZWRsRGZJ?=
 =?utf-8?B?WlBRQ1pRd2I5akJ5ZnQrSXNJK3BSYkE3WUl1VUtoc2RqaytVMVFlMHJQS3hp?=
 =?utf-8?B?SnBVd2MrUkFnWGxEcllaRGYwOFY2REtiTnYxWnFtU0paS1dnaVJKcTJKOVRi?=
 =?utf-8?B?SkVIaTF5cTJ5Mi9YWFQ5aUJBdGhiMUxiOFN6TXM0MGswV2VlYzRSU01iZHkv?=
 =?utf-8?B?R2FXN2NTaTFFSTVhSTlyOTM3Qk5xWUlsRHpZdC9WWEx6dUNnVmpjMkVaWDJM?=
 =?utf-8?B?UWdVQlJzdnEyMGhSajRCcVlkQjdJK3YyWVNJcE94THNMS1cvOHJITUNkL0cy?=
 =?utf-8?B?TGRjUG5jZVFjc25iQ1c4a1VIUG5UU25iOVY3UkYyRWRxMXNqR0lmYTVYT1Va?=
 =?utf-8?B?MlZjQXhjenJPWmQvbzBPSXlabXVCeER6VUFIcEdaWlVpeW9lVmY5WGQ5NHNC?=
 =?utf-8?B?YzVKaE1DalNvMXJDRzdYaWIwN0lxYmxjeUZwa1gxWUl1b25mbEQxTnNGMGF4?=
 =?utf-8?B?MXlDRk1VVlBvZXRzK1U3bVROcGcyUm12b3hVdWhWS1drbTFWcnhvMXlTOUZ3?=
 =?utf-8?B?MjBmSDFuZVZqdldyNFFWOGIyQ3VYU3lMdkNJM2lKVmRNZTdMaUJEbFF5ckxt?=
 =?utf-8?B?eWtaS28xcFBNQTFMY0N6V05jVGpicGZEK3Blb2Y4dUZKZW9XQWd6ZVJGUlVJ?=
 =?utf-8?B?UXdnajNRdDd4RnVUUnE5cmZ1TTZpUTUyU2hWbzdaR0xUb3M0ZkNVSGo2V1hT?=
 =?utf-8?B?YmIwNlU0WjJQT2MzTDZza0F4QXovRmV1T2VPWXVSTGFENm1SNWlaaG0rWGlC?=
 =?utf-8?Q?xuPVobSZsk7PO48n1KWidQuUsH5kkHQIjcXWAiY00A=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa663eb-1a5d-4b8f-6820-08dcfd00c172
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 18:44:46.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jepPfed5Y09FO8eZ0JG4YNE2vZBa40awo4rLGbPaE6hGf7tFG5fVs8swQTKKvXecCfPsXPUQ1ippRQogXtoOqNDfxWpPJtRdZCjuMPgAEKGVEMkprO4vfA6gfFA3X6eD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6953


On 11/3/24 22:17, lihuisong (C) wrote:
>>
>> I could make a further  change and allow the driver to request the 
>> remapped memory segment from the pcc layer, and couple  to the 
>> memory-remap to the client/channel.  It seems like that code, too, 
>> should be in the common layer.  However most drivers would not know 
>> to use  this function yet, so the mechanism would have to be 
>> optional, and only clean up if called this way.
> I agree this method.
> Don't remap twice for one shared memory.
> This remaping is reasonable in PCC layer. We can let PCC client to 
> decide if PCC layer does remap and then they use it directly.
> For new driver like the driver you are uploading, driver can give PCC 
> one flag to tell PCC layer remap when request channel.
> For old PCC client driver, do not send this flag, PPC layer do not 
> remap. So no any impact on them. 


I think we are actually in agreement here.  No double mapping, but the 
driver MAY request the mapping happen in the PCC layer. No impact on 
existing drivers.



