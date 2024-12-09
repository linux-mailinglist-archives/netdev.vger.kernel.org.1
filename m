Return-Path: <netdev+bounces-150301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729F9E9D69
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA6283559
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD361A2398;
	Mon,  9 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQ3VPKwJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC715853C;
	Mon,  9 Dec 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766462; cv=fail; b=Ovb0pdhopUavFlZdE/N9E9dQp52A6Gor3yn5UHn0qOONRoc0HZ2oXfM4UO0602O3fc1jnS++WorHMfNeK8baXh5bsh9I3NbyoTo3yhQpIA8Q2sLpoGvUmq1m1lrU+yjrQ6bUk89TmVQ9Lnt6h9BPcEMQTJS/1WbnIeWTJtqQbcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766462; c=relaxed/simple;
	bh=ZMkgAnSg1SFpn0+3iTaUzX2t7ivaLndyBZ3dsJuUjp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=csjJGMzOsTLvMb2CkCi0wiaaHBv4XsvQaKsUuu+4vS0OyS6UoAWzIQF8izM+E1Y2lS8y4iQ+2No5M+M1NkQsYXAsOzSZdcG7cx6BMbp16N0N2aXRBRW4JbViwTV6HKs3y5BGFjO0oDBB/TCwT6NL7UrC5N5D5Nnerl/90AlB6hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQ3VPKwJ; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDFVTCRlEehyYxfKtDKxEOuxlyAP0NjacRTi1us0Hbg/ORboqUFStPak+wzt4uQWhaY08GIr/nPNKa1/O/nM3xt670cADhT+q/r7YL12HEOGl7wHs7+Ud/IUwq9oz6LasovcfMhoXJtVx7on8KrNTNM3ZZdJaTDvD9egHTLJ1pm+PWSwSW3mtZUGoXI4NVXWbAfLgCPAiZSohgquxHhwyvLf9Gomti22c2rwgGWQXUxqBIIqx7s9Nhu9vovSaKT32zEHb4t9/gc3TJfwmes8qOITlEcQaN8KcYCIq2HqP9secxaY4opL7mqEa8k62/WblqAQ+hWJ0ff/86uYUPL+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGL8SJ9rWcYQ2XGl+yezT9icptPsTF29VyWREQ7pM7Q=;
 b=bce9NiAYVla8hUfHWFPhIkCts/kzmZHDkmU637vFOLJtsRyJ8Ba8GdW6BMOSx/ga43AoMTeVcdLAaL3bfTFBh+hdMxn3Uc+L9sTcXBqTgbreS+gtmUHoCzq4l2ikNmcgWHDxkuyRyyYBnOFxKOYTC7FiWEiLWJ9aapbbulXGCKksUWvYmyMSuJ/OBaWwHVCwL8av4AAtYtzeaguLGsduq4ftwgcZFFRAIDOQDXq2svslQ9WLmD4ZQ0nh/ut5NUhn/jVRjbCMHM8ZjfJHZHbEs1RdVJAqNgOrMo05PLEd+w4P9wmup2WNLyPAy4M1zJSHfBp94A8+bldmO8AKB1qUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGL8SJ9rWcYQ2XGl+yezT9icptPsTF29VyWREQ7pM7Q=;
 b=QQ3VPKwJWDMJ3fOnB/deJvW06apNBG1ObYWdn1qraViNzETHfSv63iAC+Qhfa8g29dRhe3ry1p0WQ+Txp7ZYtIPNVyox1GqWnYgMBs2nC4/IfcoVyivyCdOAnmtczIV0zHnXaRS34KQA9seYS8wmkZy0UrdUkqQ8fXJifTJOy44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 9 Dec
 2024 17:47:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:47:30 +0000
Message-ID: <ca44d9f2-d946-1635-897b-1c8b78145ead@amd.com>
Date: Mon, 9 Dec 2024 17:47:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 26/28] cxl: add function for obtaining region range
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-27-alejandro.lucero-palau@amd.com>
 <20241203205355.000079a4@nvidia.com>
 <57793990-1350-de8a-efc5-86dee5b215e2@amd.com>
 <20241209182945.0000082c@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241209182945.0000082c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 279a651e-957e-488b-76b1-08dd18798d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTFUa3FNUm80aWxNNllFR2R2STdpT2Z6VEgya2FtdGxMTTFndWpkaVllK3Bt?=
 =?utf-8?B?YUNubHhiOUFKYjl6dkNjSmE5cDJtQnI5bWZlTjgvZE9jQk9sRi9aaVE4dFVz?=
 =?utf-8?B?cEMrMmxRQktmSDRmK1FMTzhMV3k5ZDlIY0QvV21jclFGdlZTRjNBeGdOdE9Y?=
 =?utf-8?B?cDVvMjl2clVTclNyTi9IZHM0TjU5T1lkaWhqdGxsU2hnVU9FWGxBUk9NVTlN?=
 =?utf-8?B?R1JjTnpwVW4rZjlJTVJxcU9tWVRieWpiUmJ6Ritrd0ttbk43YmJhak01ZUxn?=
 =?utf-8?B?S1hjL3YyYVJGemZ4Rm8vYmpsNmM5VUFOY0VsdjBUZVBrc3hQVXVKRnJvdWlk?=
 =?utf-8?B?VVZBWHJUb1JBbDFhYjNkUkVMS3RJMFA3bW9rNGpkYmFKS0tNTnhjZEtxVjZs?=
 =?utf-8?B?d1lscVYwNWJZcG1UTmowOWFzQjA1L2srRUhFWmRnT0NYV2FkNGdMbFpxTmEy?=
 =?utf-8?B?YkhhcUl6ZnZYV05TUXVCZk05RFNibHQ2d3RxNEw1MHBkY0RnRHVjKzR3UHdm?=
 =?utf-8?B?NHlZUlc4YTY2b2Q4YXdodGlNK1l6QnRzeVdZcnJFZ2tlZmZHMndyeHNQeG5V?=
 =?utf-8?B?WTVYVGc2Y0JBb3hWQkxJNEZXU2t5bUhERFhPc2YyWS95Z1hqVTFzMVZBWHFG?=
 =?utf-8?B?ZDJxM3p4eHJlcDhuR01rUi9XSGppRHBHdUxWZHBjcXYyZU5hVVFzZllRNTkz?=
 =?utf-8?B?U055NXp3eHc4TExIbGdUOUp5enJMY0x1dUM0WXJ4VU9CaTBoUURhU0F3WDgr?=
 =?utf-8?B?SisyZkVVeWhtNm91Rk0zRGxSV1RRbWVxRUJPcVlJL3orSGFKWURteXV4NUJ0?=
 =?utf-8?B?blVETXFFbEs1cC9RMGNZUThXZWg1U3VwU1lnaTFwTDA1UXFrTjY3aGw4NVpT?=
 =?utf-8?B?S0ZuWk5KUXpoMXZUbC9xLzAwN1RhelJPKzR3cW91SHdiaERtVTlVRFlsYVBT?=
 =?utf-8?B?REtidzFiUUlpQi9velRYWDl5UXQyR09kTzh3U1dKYUJBMDlNK2VQZllZaElh?=
 =?utf-8?B?eTQrNTE0ZWh4UTJNVVN3WkVUYS9TN0ZmL1BHM045QTdUS3hPNU5ZT1pScGJ5?=
 =?utf-8?B?dkJsMkVQL1M0S2Y1Z0NtVi9wanh3NlBLQXZVSGFsditIdFlNQWNvRXV1M2xO?=
 =?utf-8?B?N3hSL2E4U2FQeDhjRGJEczdGYWJHaSt5cmY2QnJ0bmhrZjFCTTE3eUNlZ01u?=
 =?utf-8?B?b0doZDRTYm1JM0V3dG13cWNpSHYvOXU1NU1mTU52UWNzK3QzcHpreWd4SHFT?=
 =?utf-8?B?b29XK2I3S2lmSTloS3RyOGVhM2FHSUFpejVaQVgrV2NZdFdrSlJqYnRDS055?=
 =?utf-8?B?NFR4dWV3TXVOU2pidWMvd2ZMOVFBb1lTZ1MvZWVTSUkvK3dobSs4TG5nbDdZ?=
 =?utf-8?B?NGc0UkZkc3dqUlkyQkZvQjJCd0xVRkJscG9tOTNWS3U2U3grdWdqY2xzbnp1?=
 =?utf-8?B?K2VocWpEV3BvQVZicGJia08yYjFPaElhMWRLMWJXQ0doMnBpakFyd0xwM3Ev?=
 =?utf-8?B?MWJIU0JWOHhRTzFVNGRtWm5aSk9JVnplZzUrb3g2RHNKWExDOWhJSDRnWGRV?=
 =?utf-8?B?ZXVMOW5Dem9OdW1CWVM0dkt4b2REdzYrMHJER2F1eTRmN0tERSt5QUFYNVlO?=
 =?utf-8?B?Z1FvU3h4bTV5N3B2ejBYQXNRWWFOcy9XWWUxcWxoUHFmU2ttdTB5elBydXlw?=
 =?utf-8?B?dysvTHdXc1FYZ3NUczgwSjQvejkyWk5aKzZJWDBQK3dhRG1sWEFKUnFYRldV?=
 =?utf-8?B?dEZTTGk1QWE2cWl6OVQxWXJIZ1prN3RnbUR0dFRKZ0N1UTR2Z3hDNUJZeFZH?=
 =?utf-8?B?SXVZQzBVb0UxQXlXZXFJZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDUxTnI5NFR1anVSQVYzUUxHRmYrbEV6LzAxVmEzQVd3VFM1YSt0OUZReCtD?=
 =?utf-8?B?OUZnc0h6eUdJQ3ZkSS81UEUxbHhwbElHb3p4K21kL3ZqZWU3WDZtQmk3OFhM?=
 =?utf-8?B?Yk1wYVcvNkhaSUNqNUN6U3ZXUWFCb1VPVFFnNlE2TmlxOGwwWGk5aUNtVm9H?=
 =?utf-8?B?bnpKakg3Ry96RWtiaGttMm1hd2VZVzdSQnJJU2RrUjBDMTYyTExOSVVSOEho?=
 =?utf-8?B?YzFQMkxRYVJ2TGpROERjSTB3U2xvZnhmbWVuNVRYS2FnZnovcVVDV0pDR3M2?=
 =?utf-8?B?UjdUZGd4bjc5YzhVVVBDSjlWU2RaUWtQQWJCaFFMd3Y1UzBoa0dNV3RweEh4?=
 =?utf-8?B?ZTRhb2I5MEMwNENRcmN0VWtRM1VONFNJdWtrQnBGTFVJL1ZUalNFNzhVZ3VQ?=
 =?utf-8?B?WFc0Tkp1citKQWlSempaVGhVQzE2TDhDVE1vTWE3NUR5REVJVXA3UXRTMzEr?=
 =?utf-8?B?SDRzMm91ekJZZ3lraCtBalEwbjhpalRDRFduRzJUR3BkOEFYNnArQTVDVmNO?=
 =?utf-8?B?cHNQMk9FMlg5V3VkYm84QTBjKzBudEp1a1MyYk8zK0VpY1d0OVRVY3lOSUZF?=
 =?utf-8?B?Nkg0NzNEMnpIOHhMcjVFRUJic3NGZG8wVmxvRThwVnFLNWsxN0xPSGplV1Zj?=
 =?utf-8?B?RDdobzE1TCtaNWZaeEtPUzhQQzhPRFQ4cHMyK3YyUnc5Q21STXdxNDI0Zkp2?=
 =?utf-8?B?WUlQMnlodHBreW15RWM2Q3RZV0ttM2F0NDN5NXkzMnFEWlVhUE9XVm8rMG45?=
 =?utf-8?B?UnVubUE0czRySndNaE5XUzRrRXk0dzM3QUN0bnV5TXhYV0tHbTB2UW1VMVhl?=
 =?utf-8?B?bmxtemZZci9xQk1vZlV0TzVhc1lFNy9vbm9PNm5sZXdJNWtHVlRUVHNKa2JE?=
 =?utf-8?B?UDdBV1hhbSthYXV1QU51Z2I1WUhMcDQyU0tqWmRocHQ4MCtpT3NkdFprOGNt?=
 =?utf-8?B?YU90NzNQOWRtSFNqVGJESTJic1JMcVBLbUFMSmxOeVdweGlXTlJidlY4NUJ5?=
 =?utf-8?B?UGhUTmZXZ0Z3VmdtQ085a0d5M2JtZVJUTWtwdUdDY1ltSExNVFA3V01jOVp6?=
 =?utf-8?B?aDVnSjRzMXZyaTRUcUNBV2Jkc0d2QmQyMWRFWCt6bXlSYmE4OHRyL2pxUGFw?=
 =?utf-8?B?ZVNYMXlvWXRucWZ6SE5wZkNHWStRZjJhaWt2RDNtTEx6NGd4NnZ0ZFhDckV3?=
 =?utf-8?B?c2ZkdlpScnNaNmRCSVE1RytwdkQ1b3hxZWFmRTdkemhHdnJtV0NoVGozamE3?=
 =?utf-8?B?OHNoRStGY0cxOGxGM211WnpOMktEdElaS2hNNHdUczJKbUtTL3hEcVVRaEFO?=
 =?utf-8?B?TUtyWHBCbWhoaTVNSDNqTWZydkg4NTlya2dvSmlFUVZWcE9QQ0hxVzBEdWxh?=
 =?utf-8?B?R1lBeXFYL0pHVlc5N3VuK0JRV0Rac0JQNUdBdzRqWE5kT3RXMmVKZVdOYUZX?=
 =?utf-8?B?NGhlRVFKWXRmVXFBVWsrOTRrbDZMWSsrczd4TGJwQjJlZHZEc2lDV0xHL1h3?=
 =?utf-8?B?bjJkOGVjS0Z1SXY4VWoyT2FleDF2U1JkSWwvS2VsaTlOTU9aR1RkMEFYaEtZ?=
 =?utf-8?B?SzdodGlreVlKV0trMTZrcy9oZi91V2J0cVVLckd0RzQ1ZmkwV0Y3OTdyMUw0?=
 =?utf-8?B?ZW4vVE16L2hIUkNaaDd0clpYSm9yQjlXOVNveldHRnJkcytPNXU2OHJpZXha?=
 =?utf-8?B?MlF5bklBbEVpYXgrc0h6ZDRFUWlMUVloWXI1U25HSWZGQlBhTW13MmlQS2Rp?=
 =?utf-8?B?dXZ1QVpXMzBSa1V1V3A3UEtQMEtsZi9tY2NEZFpWZGNySHd3YTF2WEplRThN?=
 =?utf-8?B?bGZnUVozR3hrTkxxdzVGdVN0NWU1R05XQmtCYmV6SElHdXJuOTJNeC9NTUVq?=
 =?utf-8?B?SXhQYk5FdGFVU0RreCtBbTFiR3JRdktXbTgvN1ZtV1BocHo4YVpmY0VEMDhI?=
 =?utf-8?B?MjZyMkdXaG5RaEM4Q2VUWlhqN29YOURud0lIaDM4T3R3cUVqOHRsUkVVQmtS?=
 =?utf-8?B?SThKR09qQlVYMW9BYlFJbjluVUh0ZkNNOTBSRlV4WDVTQ2FSQ2pCY280YmpS?=
 =?utf-8?B?eERTYWlja3FlQzA2NGNEVzU5WHZYdGRkL1JlWDNzSjRJNTQ2S21vZ3BCamgy?=
 =?utf-8?Q?yu1GM7YKVMkE4XQ14F9zBDxF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279a651e-957e-488b-76b1-08dd18798d8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:47:30.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXt33Y10RlzoiN6T3nb72NzNjGRt+29xZB3n9fjK75XT+w53Hpit9b/JF3MDC6gFfojNlRbCLVaj7VqAHFM3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533


On 12/9/24 16:29, Zhi Wang wrote:
> On Mon, 9 Dec 2024 09:48:01 +0000
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 12/3/24 18:53, Zhi Wang wrote:
>>> On Mon, 2 Dec 2024 17:12:20 +0000
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> A CXL region struct contains the physical address to work with.
>>>>
>>>> Add a function for getting the cxl region range to be used for mapping
>>>> such memory range.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> ---
>>>>    drivers/cxl/core/region.c | 15 +++++++++++++++
>>>>    drivers/cxl/cxl.h         |  1 +
>>>>    include/cxl/cxl.h         |  1 +
>>>>    3 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 5cb7991268ce..021e9b373cdd 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -2667,6 +2667,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>>>    	return ERR_PTR(rc);
>>>>    }
>>>>    
>>>> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
>>>> +{
>>>> +	if (!region)
>>>> +		return -ENODEV;
>>>> +
>>> I am leaning towards having a WARN_ON_ONCE() above.
>>>
>> Not sure. The call is quite simple and to check the error should be
>> enough for understanding what is going on.
>>
> A sane caller would never calls this function with region == NULL. If
> that happens, it mostly means the caller itself has been problematic
> already, e.g. stack overflow. someone wrongly overwrites the pointer and
> the caller is not even aware of it. Thus it calls this function with
> region == NULL.
>
> In this case, we should not let it silently slip away. We should have
> WARN_ON or WARN_ON_ONCE to notify the admin that the system might be
> unstable now and some weird stuff happened and memory was
> randomly over-written.
>
> It is different from the second check, in which the caller is sane and get
> a error code.
>   


It makes sense.

I'll add it. I was close to send v7 ... :-)

A bit more of work but it does worth it.

Thanks!


>> In this case any error implies a problem with a previous call when
>> creating the region which was not likely checked for errors.
>>
>> And if a log is necessary, I think a WARN_ON should be used instead.
>>
>>
>>>> +	if (!region->params.res)
>>>> +		return -ENOSPC;
>>>> +
>>>> +	range->start = region->params.res->start;
>>>> +	range->end = region->params.res->end;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, CXL);
>>>> +
>>>>    static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>>>>    {
>>>>    	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index cc9e3d859fa6..32d2bd0520d4 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>>>    
>>>>    bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>>>>    
>>>> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>>>    /*
>>>>     * Unit test builds overrides this to __weak, find the 'strong' version
>>>>     * of these symbols in tools/testing/cxl/.
>>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>>> index 14be26358f9c..0ed9e32f25dd 100644
>>>> --- a/include/cxl/cxl.h
>>>> +++ b/include/cxl/cxl.h
>>>> @@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>>    				     bool no_dax);
>>>>    
>>>>    int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>>> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>>>    #endif

