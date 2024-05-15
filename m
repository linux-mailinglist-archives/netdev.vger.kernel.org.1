Return-Path: <netdev+bounces-96614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A940A8C6ABE
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288321F23417
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84441802B;
	Wed, 15 May 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRSFyakS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00B224CE
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790958; cv=fail; b=nswSlj+tum0YKOrzzY2sE0shvekO4gv/NH1aUeo9hWS4i+IHYB2Nl83zXecqYUVR0D4jBUUCacu5nTrhAZE6+lVDnxvr+Q9VgwZtFJgB0kuWcaMsDD4E310XxVAVWEx193KcJ+E0+npkv4P090zDq0LjpmZsMeD+iUMN1rnfx/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790958; c=relaxed/simple;
	bh=tD9hjVwTeaamfqFs1yoK/pOaXOcfgoRxuu66BnO7EVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V+KKHQMaTgXnHHHAngSi1QC4U/DRVTHfXbJswAwGaoBOLL7qwOCrlHLPz6HXXlrludfPWdfq3vuwcp9ZC+fnLHsciPHSs62A1Jw12YwazMW73AFns4TSCAzhw02bXiewFBKmNsGPEQw5jfMAWhhh+t5tCtcI+xC8g/TxHY3tyfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRSFyakS; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMb5fzZ1xKuCXQjnO3S8OkHbWypLQ+SWFkQeN6H1bi+CJCxOPTEohsZsr4jT6tvQJ1knJGt3tymiZLrIR0iW81vgTrMQbelLwC45TZF07GacSeBbcbg9utFaMYwLGnG0QMx5JT/3TYsrUSb+6ps7upuqUiidLPqW5V11jLBsCexqyzR+8C2DL+HrUpn2fTbPxLKFHZmV34LB+rIy6vhWt8G3IZpoqM2CYHVOydacaJe74W5jsTv/qrCyf+z9bLOYPUcG1vVV8CBXDsCP/RPxkWqMjwsjn31w1hSwIaBAIX0DMFrrHH4KcDok/gq3smZZSmqT8JzM8U88RdP2v2IcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNDBIxO2lLdrgzzHH/BP7BsmyZmMotQCZKayCj1blxo=;
 b=FQaY/+/D9JXqXD1FC6gjkB1FgMHfHtQGqKomGH0CvDiERHYet8FE0AkheukMrTsfjrRaEXaWS+fGxLAUhXWI0RbyV6g3o8Zdomos910+TUGXDcEb8IB80qAO4gYG1z0IcPn93107xIQN8SqzX2+wVmg77yFun9OogSA11tQWzWwpntEMVOMf93tOdYIa6VqYyQyRk1zV73iI6veOZsnWqzJGsmzVWqw5fBbpHxq1imKmvwa1l4j0/vU4WEnJ25mGwfGZAT5rF8NLfCWdK6Dv81tdLXMyj6eQ7CO+lJvkc1TPDNOHWa9IgW8sHnT3vpCa+fLpx93GmEvMCZFm/a9q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNDBIxO2lLdrgzzHH/BP7BsmyZmMotQCZKayCj1blxo=;
 b=xRSFyakSF1ETuxezg+ZyL1vlbN3bXQJhszkftE9gZtB013BSARqbWDM6nVtJ4Kpj7B5/mowXLHvLYa/FMHu3fHiwzxiYTUfHZtZQOqwfxhso1Mqy92ELP9u6bGWj4y9n6optFwISpvU9Gv19a023FmWOfmrHjVlQzXiERt/ThoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 16:35:53 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 16:35:52 +0000
Message-ID: <5088d3c2-210a-42eb-a4f4-5c1817f88832@amd.com>
Date: Wed, 15 May 2024 09:35:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com,
 Eric Dumazet <edumaset@google.com>
References: <20240515163125.569743-1-danielj@nvidia.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b059872-3e25-42e9-c58e-08dc74fd160e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUhjbk1DM0tmRWg4ZWUrL0JRSXFzdFY1VEFsMlFyMTZkUmhNbG9rSmJCQXU5?=
 =?utf-8?B?MzR1WW9HeG9QZHVDcitrY1hwL0k2cFpSOWx4TDdvdmRnMG9CMVMzTWVaVXlw?=
 =?utf-8?B?TGdpcUpQbXFSM2xFOXhnT0hReXRlaFlIWDhRU2xTKzlvS1BEby81bjQwcVRJ?=
 =?utf-8?B?ZklDei93SzJvWWFPdlM5WW9sZWZYeVZ6MzNZL0tsd29yZmhhbjVXV1FxSEhw?=
 =?utf-8?B?V3A4K3ZpOVVERVJXeXFvQTMyaW84UGdWWmJXTHllOThPZzZZdnFhcmpPVzNQ?=
 =?utf-8?B?Y0pPcC9xOVMvMGVRNG9VYktQTjlIQnVjeEpzbW11VlhLdHcvOURoYjg5Ti9X?=
 =?utf-8?B?L1k0NTh0MHRqUVN5SmVycEtUK3hLelBrdUNPS3BPOVhnNUVJRUpwdytrWmpR?=
 =?utf-8?B?THE0WnZ3NDBXMHRPNDcvN1cvd2M2QXdFK2JkZkZaYmt0TE9qMHRvNk9oN3RD?=
 =?utf-8?B?VVc5a25LeHg0cVEvaGg2Zi9MV2FWS3Z0ekNPVmNzS2RkcS93SUp4V21kNzJ4?=
 =?utf-8?B?alVkQVpSSW50dWZjSEFTeUhUR1lucXY0QVBpTmlPd3d2SDhyS0FTcnNUYkxB?=
 =?utf-8?B?L0pDblQwQlZuZkx2K1d2NU02aGJIT2Y4QUJ0eUxwa01BdTdtbG94Wk02MGNR?=
 =?utf-8?B?WS9TVThXOU9hSU5pSHFLZGozK3h3V2pMSExoa21Zek93Vms5Qk93V0ltNFk4?=
 =?utf-8?B?dnJNdk1PaDhDVDlPc0FZQU9wU09JM29ibnlSYUNBOXpoV0ZxNzRSNXMzSEYx?=
 =?utf-8?B?K2xOc0lTNGdiREE3cUNNeVNWUGg4ZWpUTzZ4Wkl5eHAzdkNkaW5qcU9Ed0V1?=
 =?utf-8?B?SlUvbUJPdzUyV1BDdko3WHBtZVFNVUdiRXNHNlZXRVA2SnN4TjZHaDBoTUZa?=
 =?utf-8?B?RElZZ09iS0pibzNRRmhTY2pBb2NzelpYQUcxeExldWwrZEVBcW42RjVvb2Ri?=
 =?utf-8?B?L2VMR1ViMEtXSGU4d0tXVS9FWE51VVNqZUtjcjNuemhYNjRVVUwxTWpoTkY4?=
 =?utf-8?B?eUVjQk12T05oNm5PR3Q4MytUbEFGQ05tdllUbGhhaGg4c1ltR0owQU1KVW1v?=
 =?utf-8?B?NkRFZlJsWjBRYVlrZFJYemFoSVJGb0VLYTA3UzhGK1ByeThGRk5mcitBVWJq?=
 =?utf-8?B?UEZRenFJOURpUE5qa3JIbDdMSXkyT28vWThYR09Jb0JrN2ZIUUQyZmRkMEVa?=
 =?utf-8?B?ZlB3MGZvR2kzbEhQc1lPQ0ZrVFE2RlhzVVE3S1YvR2dQVlQrY01NbnZ4OHVn?=
 =?utf-8?B?alUzcjRJZUFjUjY3UjJ0S0s0c2FKeERSQ1grK1NFK2ZTUG5SSG0rM21YM0Ni?=
 =?utf-8?B?eVBzc1YvZG5XcFM3d0tvZFRWS1B1S1JtL29mSG8wZzRkN3ZVQ2hIa2t4S0JL?=
 =?utf-8?B?eFl2TlpianFFdkZLZGY2dkJTRE1sV0wzVHJiOWJZLysxQ1NnZDBQTE5HVlkv?=
 =?utf-8?B?Umc5QU84TTd6c0FlNE94aHFSeWZjRjdyTzdiQkkrdGM3Umt2bGQ5cGxkazhL?=
 =?utf-8?B?Vmx6ZFhvWkVsdEZ2d0N1R3hZNHdlaFlIV1dMZHZKeUVtVzEzVzBUcGJMVG9H?=
 =?utf-8?B?ckJQVnBFMmxBTTgrR1V6MzMxQy9nOWxSMldFNWNrZDlmcnlkeDd6cCtpVjJo?=
 =?utf-8?Q?HWr8ZTR+NAjVq8Q1+j+CpNkeN6Z26KVU9SGBvvQDTVdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXl3WHRjS1dCbGIrYkd2N0ROSUlvWkpkZlNWWDdueWVLUzBNeE9vRkk4aEZz?=
 =?utf-8?B?VXNzUkpmWndXWUlyY1VsQTZPYnQ1a2RsUm04Q1VvR3dISXZkSVNnQzFvb2lo?=
 =?utf-8?B?Zk81UXR0eTQ4NUlFSnhDQzkzcWpOclJySXdoL1RVWnBwY09TODRWNG1OV2RD?=
 =?utf-8?B?MU15MEdJQlNTUTV0UWlROEpDTVhnaFh6V2RYQlRaYVQrYnQwNW9OcUNoMW9n?=
 =?utf-8?B?RHpWMFZ4RTFIbG4rYm5YaThjU3V3Wno2RXUxZHJMNm82V2hTdU1ydnZMdER5?=
 =?utf-8?B?bW1wUFFmUlhMVitOZ1hMVWNLd21relNIdVpxOElKd3p2dnlYMXM1V290ZFZC?=
 =?utf-8?B?OGw5OTFWSnYraktYcHFmTVNiWVlURFdPTTloQW5GODQ0Yk9mZWhNUmxtVUtx?=
 =?utf-8?B?U0lZQ0FYQm9Ba2dHdVIwZ0pXY1FHcjdQWTZkaWdRdHlnMXlicVVzUHp1d3lR?=
 =?utf-8?B?QUwvMzB1MkRrODF4SVFzaWpIQ1RHUk1kYzRSZXRmKzUxQUNLL2lESk0yQ0xj?=
 =?utf-8?B?TTdhemNTYmM5eGNPekZrOVVjWnNoQkczYzMwcTE5S0VidVhtZ0w3YWZ4bWdn?=
 =?utf-8?B?Ylk1WVJvaHQxWU5VTExCWFZZamxhQ214b1ZtNXcvSkVJeEduOW9RdkFwT040?=
 =?utf-8?B?UnpIejBjbnpUZG9oSUh2TlpjYUc3ZUt0ZHVEckd0Y0lkcHNJa1JWdy9CTjBY?=
 =?utf-8?B?SWVxbUExOUhRc0JScEFPdVpxa3ora0RLd2JVdC9IKzJOUkFKaWtCemxwSUVL?=
 =?utf-8?B?VmxTZFkyR3A5Q3JuUy9Nek9uR2lha0YyVXNvNUJpeGJGdkRkV0lBOE5RZXYv?=
 =?utf-8?B?UnJUd2xpcVZtZFJxTXdVNGxvUHYvTEdnblczOE02ZEYrd0ppQnQwMnRZTDhJ?=
 =?utf-8?B?bmk5ODJTM0s5RXloWFp4bzQzS3cyRFdjeTJMUzhOYmQ2SDNPRGc3YmEzUmRU?=
 =?utf-8?B?ZnNOM1FKV1NyeDNGQnN2WGI0Q3JjZkgrcWdDUkFnY3Y4MThBUVZRN0lpeXMx?=
 =?utf-8?B?SnEwNXc0cW1pT2pKTEl2V1ZjNkw1b1RMRkNSa3d0ak1Cd0paK0JScEpKT2li?=
 =?utf-8?B?d0NTYUExblp3bVdWQ2F6Vm5QQkU3U0gyN3JuWGhSbEx2RURaRU9NeEtRK0wz?=
 =?utf-8?B?MmlnRVFyUnZzRXR5aDB2TGhyMU9haU9IMFVjY2NCd1FpbmFLSXMwN0FvVFBX?=
 =?utf-8?B?eTJXczd2VndNZWY2aEVoZ2g0djJ1OVhzS0NyUWhiVTNvMnRKOXdUMDR3dy91?=
 =?utf-8?B?ZDBHMzNtWFFFMnY2U1BnY2hEUlA0T25xc2ZZRHg5QjdEKzdpNDVIaFZpTU5q?=
 =?utf-8?B?VkxqcGY1bHVQZENUYVBjTFM4YkVRVVk0cEtWdzJnY2EyRmFMSEJxMmlFdXRC?=
 =?utf-8?B?Um9HQUdJNm0xeUs5d0NtU0xRc2hvaWMrRlV0clViTkpYNmtWZHR6QWtOeHlJ?=
 =?utf-8?B?c0M2VzVodEJZT0NQN0hreWR3UFIzNlBQakd4aXFCL1NrWEhZK004SXFSUTVa?=
 =?utf-8?B?TlBOT1Y0QmtVR0hjaU9ZOTV5ZCt4YWFwTXhiYnpwNUYrbG44TVBqUXd0UWlW?=
 =?utf-8?B?UzJ2RUNuRzE1WTE2Y0FzU1dOU0l5Y0JZMWtPM2cxREh3UDZUUUlmWWJwTFhL?=
 =?utf-8?B?anluRGlVbHgvd3laNmVXQXMzNXF5TjJzUTZyOXppN2t5RU9SR2FMZ3UxWTQz?=
 =?utf-8?B?ejVqYThyWVRIZWs5M2ExSFp1aGtSQ0hWUllBOUwwSEFCb3hUakQvRytOaUNR?=
 =?utf-8?B?bU01bXBmcHkyQ0VNSzBHbGlCYW5OS085aU5EdXJyVW5TTm9JTFN3dU0veHNI?=
 =?utf-8?B?V1dxNzFrOTF2T3h6Q052dTlJNEFPVnlQUzgwL0UrMUR4NnhiUzRiNDBNWGMw?=
 =?utf-8?B?NC8rS2hlTnlrWk9yaUFoVzJWVGljYXVuS3NSSlFGb3RxSUVwWUFYUjRMejBF?=
 =?utf-8?B?eUliZTMxUEhkTGJ0MGc1RmJtdEkxMFJqU1ZLTy9LMnhNZCtSUERDTEFrenVy?=
 =?utf-8?B?RVZ6WHJIbzhNWnhuSDhSbHZydnp5NGxSYmo0akFzeGppMG5aNG4zZVdqYkIy?=
 =?utf-8?B?UFJXLzJnc00vak5lNlhvajBsTG5DbjZGVVI5RkJlVWxRMzFEUjRDdkRqNDdG?=
 =?utf-8?Q?Bbl08TkedoiKX+g4nLKFwCMJ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b059872-3e25-42e9-c58e-08dc74fd160e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 16:35:52.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTztBiTvnJ7yP4++TpEgCWaj7cv3xkVTxKbheImfVLsiRoDWfMbsy3w5rO5ulhm4NIS8VAgbLy9bYtNnMclrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244



On 5/15/2024 9:31 AM, Daniel Jurgens wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
> v3:
>          - Changed to promisc_allmulti alloc to GPF_KERNEL
> v2:
>          - Added fixes tag.
> ---
>   drivers/net/virtio_net.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..4e1a0fc0d555 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>          if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>                  return;
> 
> -       rtnl_lock();
> -
> -       promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
> +       promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
>          if (!promisc_allmulti) {
>                  dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
>                  return;
>          }
> 
> +       rtnl_lock();
> +
>          *promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>          sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
> 
> --
> 2.45.0

Reviewed-by: Brett Creeley <brett.creeley@amd.com>


