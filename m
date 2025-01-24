Return-Path: <netdev+bounces-160781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E13A1B6FE
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703F016D69A
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397E5D8F0;
	Fri, 24 Jan 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="slaN8QCF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C270808;
	Fri, 24 Jan 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737725896; cv=fail; b=MCdtKK+FMgWYWfdwPCRe6cdcRrf9XkFPQJot9dJ//JFxzOkBuNYH2H7uTe9MIbx3d8OrVHug0itcCE+5CYKr+gIGo9OOAgnUevk+ZG+IDmn2BjYH1RNUKUe2I15lFFIA2eT0wlsOrWVP8sIPMd9Mn5LSwvyEsz4QoDeJrNu0tak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737725896; c=relaxed/simple;
	bh=uMZxnAXRmJRslSV0yLpjve067EU3amSvVtSvj81Cfv8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAlcVAyhsYSDJEmjcWAlubWNruaklBM3PzckPqiS705HEGC+IUA7f2/ZVflyMYERQWjSRm9gvgaQfI7Tx2XppwtXh8h1SM42gr7n3P+u21wHjvuYeXUNOvpzz03Z61uzLKljGw0DyuZuTSpj1y3xIWNcVgDxAd4qyl0RqcQLnNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=slaN8QCF; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgy443Lm1ewZCZxM50YGmhWpWBuGvwfApBo6A95k90hsHd4YmtG9pnJMHhKx5Nv62ylUQRbXbwonSX6euD3a0/cn86QOPeZqFOnWd3RG0GwnZMV1poI7jOx5LxIm3GhnWS3XF7YsTp+h4IpD6pFY9KWzVVy1ymoYVjIn6S07aDNVNji6AH9aKn/7I8rYIQpnwwwAGkVaZ+tix10eTCJ4hCQzG08m/wwvgpT65PL4hsrRsloHv004z7UUp5vWel20dH4Zh60Z6nGRy3xNp41NFH0I2krwxWuArijOZBP7cfZXwDuMSdhO4BiaZl+njsIJQ4I6QVDrFV2zvnkMs/LkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA6/w+JgpxiSzDRYr/rcY2n+AqyA/9bI4BQr1Xkxwj8=;
 b=uNZeBo+qA1+6rCvXc3vlcd8waAx7+n4pfGvMGBgcO+xch6jwoklCyKQpMpA0NGA1HteU1fWQeXbQpbwRjWrP2kmgbqAPDuLbf85zwgwah5YFSkeYoT5JOvYSKiK+0G+RvpJRHAoBzKoMvwZ4AxcsAyVkYJYp7o58DEd/lxeR6R67RlvZ6Km+KMS+zeK9/HiJkUcpdmtYckrhI9CPJTX/RhnOOPmddzqdfJHDEAIlNiWrmyEOKxhJUkMNUIEw8jgDupE0iPP31K5CXbtcqIf38XXFBilmDTuKg2xMGUyt26FBA8LjGivKNhxcpPKtBnVCIvVLcoT1rAFR4YGGzWRASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA6/w+JgpxiSzDRYr/rcY2n+AqyA/9bI4BQr1Xkxwj8=;
 b=slaN8QCFHUIG98Pvx2Yc2ZkpbffOIXh/35b1C9PDdqHc7xbqaK18DZMO6eN4a2UGjqGC9LDaRDls4xr29Kz1jJsz2DXM1J93zqRMQ+24yRcKEONJDjsNM6X/yS5dKrTrsiFkRl8Bio6+278byXYpofMz7O0Ra8ucHeRlSZkA6bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 13:38:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 13:38:12 +0000
Message-ID: <0074a468-b324-a015-b346-2c49332d161b@amd.com>
Date: Fri, 24 Jan 2025 13:38:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/27] cxl: add type2 device basic support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
 <677dbbd46e630_2aff42944@dwillia2-xfh.jf.intel.com.notmuch>
 <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <677dd5ea832e6_f58f29444@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0306.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: dedf0e94-50f4-4206-9331-08dd3c7c58d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjhTdFZZSEFybWdoVDlrS3dkU0hFMnVUeThzRWRvNkRaTUUrUEE1NGY0T0ty?=
 =?utf-8?B?TndnMTNMODRRR2ZLNS9qd0JRYk5mTnFSZ3p3V1VZNmQrckNwSEJrR0RYNk5F?=
 =?utf-8?B?KzBqSlZLRUszRm9VYmF5WXk3U0JIdlgvWmpFSjRPVTMxYzZMbXljcW0yZ2dr?=
 =?utf-8?B?TnpPNTNpS0JOeE92YUZqVjZZd2hpZXpnV0tFOGZkcndlcjFIbTZDZmM1MGQ1?=
 =?utf-8?B?bkFuQnlRZHBnSFlQWnY1SHlrMTVqZ2N1VnN1bnNzNnFXZFVFc1d2aGtGaG9P?=
 =?utf-8?B?T2M3WkVYekxkcUhIYk1xN0V1YjFLZHN0eVczWktMQU1mWEs2MFliWmVaWVBH?=
 =?utf-8?B?TGs4bFBCK2xFYTZzOW1Tak9vd3BYVC9YVE82dEI2NzBTcHF2c3RqNlVvYjdq?=
 =?utf-8?B?THNqbnd0ZWhDT0dTcHM2Vy80OFh0a1ppODFQY2Vta3p0cjZrYnhVRzl5dkdT?=
 =?utf-8?B?MWxtQjIrci9FZGp6aHZ6RWN4aTltYzM4UlhoWkZMTkhDaGRuamFCVVpzYlNO?=
 =?utf-8?B?ZU4yYTNyMEJ1U25kZGNmMXZrRExNVnRyK2RXUGJzVDVXYXA1T2F3TnVwS29V?=
 =?utf-8?B?MWg3c3h4VFZnZGY5WmNxZFdvbGxwTm5PYVk2UTl3QTlTT0EyVGFqOW53cVl2?=
 =?utf-8?B?bUNnby9sVHB5ZkZrSkhlL3ZYdjY4NUswYVdLUlVjbmN0VitIeit5N1NJMERF?=
 =?utf-8?B?QUFLQm5rU3pNakFvWThyRU5jTUVJY1dkSE0vaEpLZExURC8xcEdHMDdvNXV0?=
 =?utf-8?B?bFo5QThBUXk3Rm9vWjJlRzVDemlJWXpVdGROVklhNUsxSjhtL3N4S2g3Z1Qz?=
 =?utf-8?B?Y0RZNmhuc3F4cDF5MGh6VjRuZytPQ2tIdnFZZUdvclNXSE42cjJBTHUvdGpJ?=
 =?utf-8?B?bis3RExGN0xXZzlndnBpOEliZUNocVJDM1ROYk1rRHQ1aEE3YmtNdUpUSjds?=
 =?utf-8?B?a3hGYlV1b0UwRy9jL1dOSDA5UVZGVHlJUmtwRVFqSTV1amZ5bndXcnIzaHpL?=
 =?utf-8?B?S2o4YnpxdEtWcHpJdFJCL1dDd05RR0puNnp1WU5TSEFFOVEyY2hsdjJ2aFlz?=
 =?utf-8?B?MlBZeFNIWjlaSis3aVNmVFhBK3M5REVkeDEycmVQUzQxdWxyNi8wdXlxRXZr?=
 =?utf-8?B?aHhHMUg3aWwwM1JmZVBQNVVueHQ4aU1IL1Z5TUpXWndFWWM0TlY0QlROY1cv?=
 =?utf-8?B?MlFUanhWN3J5WFBMODVHenpYbnZDa0JRa1BadFFPSS9iQnc0Q3dYRFpwL2RV?=
 =?utf-8?B?dCt2UE5PdmFiWW1pSEpLOFlSVHorRE1odG9iNC9zdHk5Z2d1aWFybW1YZG9v?=
 =?utf-8?B?VDExSGdWb0k2dmRpTXFmd1hSU2NBMWdwS250TEtOREhWZ2lhUTVkNkh0czlV?=
 =?utf-8?B?S1kyQWpmL3lwQUpaeVpRVDJNRlhiMTYzYU9lRVpKVFdpdkR1aUJ4ZDBXeHAw?=
 =?utf-8?B?YkUrUHM1L05ac3lYQ0ZHNGl4TWNPdDJ6bmJGejZ6cmg3MUExTGhLd3hSYk03?=
 =?utf-8?B?T3FBOGtRQ3dVcWtuVkNmOUwxSkVvOXFUYTJYcFgyT2dBelVyS3FiNEN5UEtK?=
 =?utf-8?B?VFV2Q2Flc2hITUd3elJnL1QvZUZ5RlBwSjNqcHd5VEZlVmN1K3VTRkFHQytB?=
 =?utf-8?B?VUZRSkw2Qi9GMnR2aGhIMHUvTWpXaHBNaUxaMS9TWG9nRUN6aGtJRHowbkp0?=
 =?utf-8?B?bEtQYnFiY3ZXT0RmUTFpeWEvclhZdkZ1Ly9zdG9QNTFGQmxPM2lxRzB0U1Vi?=
 =?utf-8?B?bTQ5bWpidXNDR05Dbk5Bc1c3WXNXdXIrNFdWNEpvTWxQMGpySC9yNDVlVmFO?=
 =?utf-8?B?OU0zbU1xcFNieVJwLzRxOHNVMndjcnRLQzV3RVNXS2NFS3pweFJ1S2JUdGJ5?=
 =?utf-8?B?eS9HcWtZcTNsSzYrdnJCMm10YzhQcFhySGNXcHY1WEIvcXRGVEVCWjFBM0pV?=
 =?utf-8?Q?wdUAXnK43UiDBm4RQ7R0NE9bVmORcWWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTVSSWRnQlVyNkNZdnZXMURzOEJweUlJQVF4TW1jRHAxU3ZPUzR2cVRVVVRR?=
 =?utf-8?B?MzkvR0tId1Nzb3FvcXZIY1JocmZ4RmRyblpIakowS1BTNTRsdjJ5eHdJS1VO?=
 =?utf-8?B?NGFaY3hhNnhvbDRPbkk0THBySFUyQTNBQkh1N1MrNFl2SlZ4QmRhc1lyUVhN?=
 =?utf-8?B?dXJpS1VQYTRZZ1lPb1BYdHdGdldyLzRJcnFvLzR3aGZ2SDk4RjdoeVNyOEU1?=
 =?utf-8?B?cmFvOUF4eE5SQVM2S2ZHUGN4Vlg4emN4cS96ZGxBUUJrRHMrYk5YMUt5akVG?=
 =?utf-8?B?RWlYS25MSmZSNDZtdlRXK2t6MEF0NmlGRG9qY0dleG9ZeDREcjJoVC9XR1lP?=
 =?utf-8?B?dTZ5WmhQeVRMeXlxWnFnYW84WW5IYXo2UDd4UTdjMGVtaFdET0ZwSXdMNVJ6?=
 =?utf-8?B?SjI0c0h3WVpEa1hWakYxMU1JcUFCZWYwM3hDN0VsWkVmQXBXTmlsU1gybm5x?=
 =?utf-8?B?ay85NnpUd3pxc3FIRGZucmRvM3dXbjlRZk1ORitwRzc2YWNCNkJQdVgwYzFu?=
 =?utf-8?B?cEZtcWwwRENyeTVPQXRDUExqbG4xdUc4K0k4amxGcEdNN29NUndMYVUrNnRV?=
 =?utf-8?B?ZTE1M0ZjNlQ3UGFpZGdIQ0xwdHZLZzJaaVBvZUx1OG0weUVvZ0tiR0kwUFBZ?=
 =?utf-8?B?OHVxL2hnVWxLRHFlMklKeG5uYldWU1c3c0wwU0txOE9ZNm1oTlVXZ1huYnVT?=
 =?utf-8?B?Q3lZaHhubldZbzEyUzZGZkpqbVNuRCs2M0VsVnVhYUt2YnRFbFFic0ZSNDF5?=
 =?utf-8?B?elErMTBHSEo4cndQNGpBY1Z1ZTRNN254dVNXajdlbVc0RWNFWVhrUEVwSzlp?=
 =?utf-8?B?b3owUFRhQmh4NDVHSVpWSnFOVGxUcmc3R0pCVGJLTGlPOUNWK2RJcUwxaGFi?=
 =?utf-8?B?Sjg4Zi9XY0Nad3VOaUxyb1VUL3VYczA3LzRqa05xYVpnaDcrdzcwZTR1Zkhl?=
 =?utf-8?B?aXcwMjh0VTA2L0xrSkFFYi9QWFM4dTA4MXlaR28vYzVIUWFqSE04OUw4eUxp?=
 =?utf-8?B?Q1ZZRTFhTTRscDRSQ3RDSFhPaER4ai80Mk1zUUorWGxjMkJGZHIrbGtobDRE?=
 =?utf-8?B?QzJZcUNtSU1COGFWRzBab2RoOGJTKzJKd0p3bC9YVHVkeVRXSTRIM0d0V3lK?=
 =?utf-8?B?eHlMT1hZUVluUENrczliYzhXdUkzT2xsS05XdkNyM2FSNDFmclVqWkFCamhL?=
 =?utf-8?B?QU9uUkJlaEYyTHNmYWM2WWl5U1Z0Mkp4a3RWNE4wWUZmWlRFd1NwVkRrN1RW?=
 =?utf-8?B?c1VDNGQ0bXowSEN1MmtCQjNiNjJPdTFiYko2YkN5elZ2NGJrdXVvUlV1K20y?=
 =?utf-8?B?b2NmWjZHZDdkUGtkQlJiZE5ERFBUcDV2M1VjUWt5bm1OV1kwbWVRdFJ1amdj?=
 =?utf-8?B?NEt6d2lGemFURHNlY0oxUzFoU3R6cHFtcXR0RVRmbzBSWmlsbDZLTVR6QWxM?=
 =?utf-8?B?U3BJRVFPUVlicThBbWpUeGVLRFR5R1VORTQ1VWprc3JkNGZ1U2VDN0NlWUNR?=
 =?utf-8?B?djBLYnd5bnhrUGxiL1VaYUxGb2Q2Mk9RNjlCR0llOVNnKzhIV3BxM1dFY2x3?=
 =?utf-8?B?WmdESmpTUnhoekR0OG56Rnh2MzdOV1g5WW5SeUt6YXJnZWxwWDhkL1JHQW0v?=
 =?utf-8?B?NnR1TUFRU0VTRGhubGZ6U05zcHdKWG92U0Y0NnJIQ2NpRXp2YW9WV1lWYVlF?=
 =?utf-8?B?YnNNZ2kxTTFIdllwTHVrQ1V3Y0ZvVUFWanhKZkNsR2MxcVFzRmdpeTFGOWJ1?=
 =?utf-8?B?TStwWno2dWZjRW8zU2t2SDl5bUxPWDdPaEErdHc1RWtRZVcwb2EvVSsyWnpM?=
 =?utf-8?B?Vm1UdmpkVmh0cUE3bFF1RVRRY3pMRndPbFFKTUFPeTY1NGdIbnJyU2ZxUGhQ?=
 =?utf-8?B?c3dvUGtmekptOUhYKzlwa2JmU0FjcFJpUUJmQ3dZNkVEVGRNcWlKVEJGY21w?=
 =?utf-8?B?OUM5WXVhM1JGd0cxVGh5K2FuUVlHZmp6MURWV25EQ0dVVGNlYm5ZNkRtL1lr?=
 =?utf-8?B?SmhnalJNNmdXMWYvZnVmL0tSNG9GUDBvdGlPa1RLOFRrZnR5WGRoR09ZMGJE?=
 =?utf-8?B?bDBqMDAyNkRsNnJra1hoeW54Yk1OOVU3TUJZNU03YjZlck54VjBFcHlBd2Nu?=
 =?utf-8?Q?VsSHpeY5GFim8OfXWerzzvSvo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf0e94-50f4-4206-9331-08dd3c7c58d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 13:38:12.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enJ7rqS2VzgeD7+zgGjTZsfmL11uPvYC4OupiA7TwRxA2PnR3ZFP80Sz35BKqRM/qO7WQL74fRNKsOHx/HDpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822


On 1/8/25 01:33, Dan Williams wrote:
> Dan Williams wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>>> (type 2) with a new function for initializing cxl_dev_state.
>>>
>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>
>>> Based on previous work by Dan Williams [1]
>>>
>>> Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> This patch causes
> Whoops, forgot to complete this thought. Someting in this series causes:
>
> depmod: ERROR: Cycle detected: ecdh_generic
> depmod: ERROR: Cycle detected: tpm
> depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
> depmod: ERROR: Cycle detected: encrypted_keys
> depmod: ERROR: Found 2 modules in dependency cycles!
>
> I think the non CXL ones are false likely triggered by the CXL causing
> depmod to exit early.
>
> Given cxl-test is unfamiliar territory to many submitters I always offer
> to fix up the breakage. I came up with the below incremental patch to
> fold in that also addresses my other feedback.


snip

>   
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial, u16 dvsec)
>   {
>   	struct cxl_memdev_state *mds;


I wonder if we need to differentiate this initialization from ...


>   
> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec)
>   {


... this one for a Type2 device. It is for sure needed for Type1, but I 
think it can be shared with Type2 since there is a mem, a pmem or both 
for Type2. The only thing to be different is the memory type.


This helps with cxl_mem_dpa_fetch being called by accel drivers with a 
mailbox supporting the CXL_MBOX_OP_GET_PARTITION_INFO command, and for 
those with no mailbox the same information can already be there 
hardcoded by the accel driver, same for those values obtained from the 
CXL_MBOX_OP_IDENTIFY command. That function would need an extra param 
for not requiring the CXL_MBOX_OP_GET_PARTITION_INFO command implying 
all needed cxl_memdev_state fields already initialized.



