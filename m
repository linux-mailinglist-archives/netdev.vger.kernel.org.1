Return-Path: <netdev+bounces-225903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5348B99006
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD08318993B4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD92D062E;
	Wed, 24 Sep 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IYlNQFOW"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA71F541E;
	Wed, 24 Sep 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704214; cv=fail; b=jP2p5YK8oUFoAZ5Bwtm2pkuDjSyjhVjQyML3VyICfhRUA0xVGjrzWebec1OLR/x+x4O3ufKUUd35AtbrwSwDwRwvYm1/sLpR3/B9/3eBjiah+eJdv1RGHCKAKe8tC3HxSYpfhWi4Y9cRTQ5rAu9dYQYInGEASIwpjMTLv1ItHd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704214; c=relaxed/simple;
	bh=TdAw9CbJR0+ifQ3pnrdre/o1VV/xEejXwimmYbUqWiQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTBj9hHStMasCmRXRJ1P7kiHJHJhcAG+P9kxm8no9aXGDsjmJYUse5jd1scWwvqc2UeNlEg/9lmdd9vY4LATsM3e+JbPZJokc2SW8y2zx74AO5Jp8qsSGtHvVmBb+PA1jTnbExzaNQ4rOn14/YaKLvrNf7avtYzWs4WRb/bHsEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IYlNQFOW; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7yN/sHPQ3gDK3PA8MkjIo/JgzjnT71e7g2SroV7ss/ts1I9NJMFFT2UHXdDz/kKZcImfcRkxpR7hK1BgAB0CS6y2Zcb+OPnTYbPvRTt5h8BonermMHbmO//GaG0b3jVu5mCAgbCyvjUV4VT+qn7yHvDlUz21mYQzvByAcOIGE/YRo86c+t7t7Y9RQ+fCK8pGuqp3cX5luYcsPvnJnCXnid+zbjlNBgrLHlUP4PJazOJz0myAzBATcGraeQdAcCVyuuiPDjc/LCxDW/JBBGmZOqWKWjiM36RZxCmiiMsYud9Xv9VSVuQbQfhxl5vTjWWatWDB/gHBYOy9jRPhU4fEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2uxvRO1D6bmJr/eHmtXgimNLavMUz2H4vsKNs5hiLY=;
 b=R1ylBREGrXj/aHzP+rzOcPnxuMue9jpgoHRg04vP58Gv+se37ZZPgYahIaZYEky2x2MXO41kA0wcf7tktZMjFz+hUmP7aITFWGhSoNZCSw9V42+vGHFn/g4XMF4WaunSG2B3xf9oCaYMdoKhq86TSoksVp3U91YX1Pix6hQ1zgIcT0uB5ZswFYy57V7vUMQra92uvj7owqIwhhkKh0IlgYn4TBaUC6S6oboZAmHB9uPWnuwBwgnr5IOI9IoRCqLCi1FxjIKK4vyBM4pyppsoL5v2ifeMWqKQx6rZb2lCV23+U8+JgbOe4Jayar0iZMc/yoaYDgSRai4/NJHzg0Oh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2uxvRO1D6bmJr/eHmtXgimNLavMUz2H4vsKNs5hiLY=;
 b=IYlNQFOWIXP/WWzs152paugrsVZO7fNxQQQGjeImvmP2dYcrX5ZV6Ts4LtFaZtc8ch5v39cox+lOX/Rx9O4wIOQyQmZNS5c+A09mAYbacPP1yoTVHVj+E6jYaWDAu0TJ/gMFF4g3+xPmjHCJK8lcFb1foAdURUnrz2Mcj1BQKQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 08:56:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:56:44 +0000
Message-ID: <75e09b73-e44e-40bf-8d9e-c20809694829@amd.com>
Date: Wed, 24 Sep 2025 09:56:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/20] sfc: create type2 cxl memdev
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-8-alejandro.lucero-palau@amd.com>
 <58917e54-5631-4e68-8e0e-bcff94c41516@intel.com>
 <1b86bfc3-61da-421f-ba3d-bd738232996b@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1b86bfc3-61da-421f-ba3d-bd738232996b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: eaee0463-6586-4f74-5b48-08ddfb484989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ukx0RGVra1FxaTNpdjVhMEk2UDdUVGhOWXV2N3lXRWs4R1lyS3lIVVVqL1l0?=
 =?utf-8?B?MFN0YnduYXBac0hhdlg0RUJpL243aFVEMzl2aHRNQVhCYWVUZGprd0xwSVRV?=
 =?utf-8?B?a2E1Sm1ORkVXTG1nMGZyZ0Y2TkVzeitBVGl0b2R2US90L3lCN0dPS2RRSVJy?=
 =?utf-8?B?ZjY4elRxcXdMRXcyUXJSZEc2VmZSb0FZVHl6TkJjcG9tSnFKK05nSnI4R2pq?=
 =?utf-8?B?V3NnLzBXMklhelJ1VkFjeEFyR2xHOUF5N3FwU3dwQUx0Y0ptTnpGQVdVMXpa?=
 =?utf-8?B?c3pMZjZxQjhCNHVhZkl4WnVBMjRDMjk0bVJnc2VqUCtlNmRiRUV4a0FOZFN4?=
 =?utf-8?B?OXVMMTRBZUxtcE8waWJjTlVxOU9INGRYejNoQUFwaHIvUjVUR1FNdnR6aFlC?=
 =?utf-8?B?Uit1bzBINGZqWTlQSnNzRHcvREJWSnZDRmtOVUErTTZaZ25PZkhUa1ZXREJL?=
 =?utf-8?B?djBnT1VaNFNsZHNkYlFHdUV0VGNFTWdjNUZZMlFOdStxcll1OFgwSHFpTTJw?=
 =?utf-8?B?ZlZxMXJtWXVDWjR5S3ZyRVk1UmlVUng3aGZOcnByYVIyRmdvejZEY2EzQ3BQ?=
 =?utf-8?B?UDZHTThQRXBObnNoZEgwdUtzZmNLSkEwcmtqZmlNanBXaG11MFU0SUZPdk1p?=
 =?utf-8?B?SUZqbTlaRHoxZlRoN1dDMVlDMkU1enA5bU90K3ROTVFuaTJLc0o4K3JjWExF?=
 =?utf-8?B?UlhXVjFDK2JjVHB6RHRRQUFzMGRXTUtTUmRFVnM0L0dSSGoxZkhsejQvSHgv?=
 =?utf-8?B?OWMvY29xdGZxdi9uUkRzakdoemhLNStCVzgxL21kMEsvSE5kRWZxSWZEV2hp?=
 =?utf-8?B?WGxSNWRVK3V4NERoN3k0WERyMU5sVEFMVjJtS0Z4Ty96WDM5b0xSTjBjcW4w?=
 =?utf-8?B?WHdFOFV6NVJqb3Ftc3VRZVN2NElLSEJHekVMNTIySFRLU1NXZ0pKN2QyWjVS?=
 =?utf-8?B?dXp2cFFMbzV1bkNwcG9oQmtGdXBsbVlQQnZDOFk3dG9FNnF2czlLbUpYOGtW?=
 =?utf-8?B?TTZybDZjMldaYXZWNDlkOEhqOVRxVjlSczRQOE84ZHBDUW1PTHZnaDJvNUls?=
 =?utf-8?B?dTZkK3dGOTFaOSsyNXdFVDJ2NTRGRk1rcEg3TFFiOEQvbXArZ2VWRTRtcnpD?=
 =?utf-8?B?OEJ1QU9pRnljbEswZXcxVkZMMW5qU3RaenJoOXl1bXlxanNOTFRSTTFwU1VZ?=
 =?utf-8?B?cTVmQWxVRHM2MjFLdnM5SGpaWjVEMk9OVXkzTkpSOGVKd3hDQ014bVpWdDhX?=
 =?utf-8?B?Y2IwYjNQODJnYTdjUFJVc2hienlRMERmSFBiNHZ3K2lsU1Y2K3lSOTEvTktI?=
 =?utf-8?B?c0RlMWhObi9PVGFJRlE4U0hUUEE4MjlUSmc1RWVwaXk3akl5RUZVS21xb2Fw?=
 =?utf-8?B?djJrRFFITW1CUjNJSW5zb1ZLMU41R2wxWDBOSVZsSmRTaTdzM0xDcUo4REdL?=
 =?utf-8?B?NGsrN09wVzBJZ3U0OUhxaDVXWDMvTndLaHF6QXpzQ3gyZ25SemZjd25EZVJ0?=
 =?utf-8?B?V3VpcDdUOG01YlhTbGNzMnRqYXhkbDBSYmErR0p6UUwzSnJUTStITitCRm00?=
 =?utf-8?B?Z084NnZiYVNCNnVzWVBSYmJQeUV5OWtCc0xBUU15dThEZGdMSEt4REkraktt?=
 =?utf-8?B?aFZNRi9vVE9WUXVIYnVVV1AvT3k5WWFjZC9URDJRUmh2bUV3YWl6RU1pREUz?=
 =?utf-8?B?RjJLQ0hsYVdHRDJzQ0sxc1g4NVpENGJDYkxlaVhoenpmOEwxck9lK2xkS2dQ?=
 =?utf-8?B?bHBUSmF5RitReG8xbVExVU9kQzRwb2c5eUx0d2xLYkFQUTc4RHJ6ZmtRVm0x?=
 =?utf-8?B?NmwzSHJVWFp4S3JCZ3JqQytmemlRWkN0OXVmMnRpeFNvRFJzWW54ZDF0WjVE?=
 =?utf-8?B?VWZYZ1EzYXc2cE8rOHpidFJ3WG1pd0Z0RXh5cFdveGIwWG40VGVrcC95S3FE?=
 =?utf-8?B?cEVYUVhndjBPOTRLTmplMFpjZG9vN0ZHa05QVDN2ZCtpRFFLY3BqZURYU2I5?=
 =?utf-8?B?S1U5VGUrZ3hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVZzakJTWnFZQm4yQlFCcmZJS2MyVExJSHBKekh4azNsWlJHTVM2eWpqc2Rn?=
 =?utf-8?B?VHFvWkJIUmlVUEtLWjZwVzQ4ejZ0TjNmVStqRm5MSS9DVldHWW1TWkYxU2pF?=
 =?utf-8?B?bFVTQ2JrWlBYRlR1VkJYeVUyWnIvS3J4d1pmMlhiZTk5UE5NYTJtem9IbzZC?=
 =?utf-8?B?Q3dNbEtMRXBJemxWOFNZWSt1Uk93SUlnazBKVzFaVEdFbVFzSGhOOGFSY3Az?=
 =?utf-8?B?MkpyeWk3LzdZWFZvQmxwNVhkeGMyQnZwYjI1aitLRjNlRG12VE14QkI2aDlz?=
 =?utf-8?B?YW5tNTI5YW9mNTB2SFZGMHVVSG9ubHBQREdDNUlrdHJzQ2VqUGdrZGEwMFFV?=
 =?utf-8?B?UXorNXFJUG5kMGVmUkgvbmtPYjBrdjgrRTdGMjRueU1YVHQzZkRMM2F6NDZS?=
 =?utf-8?B?RVc3Vi8raVhHaFVIZ3hucFRTMDFSdnVkS0pHaWpRdTRmUytTQkt0bVRsMVYy?=
 =?utf-8?B?MmxjRXBxc2dPTmIxR1dOWFlybVRyUXlmekJLdVdsRFA2bDEvNEhqLzdNQnpS?=
 =?utf-8?B?QWtoeGh0TDNRU1NHdW05RUJ1cXVQMHMwcVdES3NkOFV3TVRNeldYaDlVbWd0?=
 =?utf-8?B?YW5ibDJESm5NNXhscmNzSldMRUFvS0lPVzZiMGVpOFExdlJhc0NpeDZaSFY1?=
 =?utf-8?B?bmVBSFA5dnNFUjNMREh3b1owWmQ2cmwwMjRXYWdmNkRKMlM0aUg5MXI5N2tH?=
 =?utf-8?B?ckpKd1FYKzZBRkp6UUVCWXFSV2wzblZ2OEFJUXB2QXBZemUvd1JxNnowbUZM?=
 =?utf-8?B?YTVsZ3dvaHFhS1I4eU5QUzJLbGNXeWxab1Z1NkxxZTNFQlRzS1FEVy90dmlw?=
 =?utf-8?B?R3VmeWpsT09xUkIzazJ0WDAycHpVYjdmNGs0T2RWMWdvdy8yMk81eE5iOG5J?=
 =?utf-8?B?TFJXanRaQmVpeDN2QXUxWkwwaitHTzNuVWhjckwzb1dkcGIrTDZEUm8wWE1p?=
 =?utf-8?B?ZmM0b2MvREc2UkxNWm14dnZKLzBMRElMdUZ3cWNmbUFZWjN6Rk5uM3lLaWVE?=
 =?utf-8?B?VDlyaDltQU1SM1c3ek9iWXRteis3SDI0MXRCZnpsRzZQL3RQRmg2Wkg3TFRy?=
 =?utf-8?B?QWNwR2d1S09UN3VkbTBkWTZsYVJzU2lYY0o4WkJBQUdhZjFoS0VzT0VHSy9n?=
 =?utf-8?B?cHpuTjZYUFVkRlA1azF3SGxHZjVZc3VEMFVXWHFzcW5wRGVaR3lDQ3E2S2Fn?=
 =?utf-8?B?WFhTK3RaYnlkZlBkNWJ5RzhzQ1JodG5CY3BxZDl6T2ZGcEorbUp5RXRNQUhu?=
 =?utf-8?B?emhaWXNWTnh5OVVxSFV3NlBJNXJjLzl0QUNWMkNXcFVldXFMOVkyZmhDMjgz?=
 =?utf-8?B?ak9DMWRKVlNaYXFCeTBYNURpWUpRSzJpN0twT3htWU1WQnNoM25iQ0ZhZlky?=
 =?utf-8?B?QzdCdXlPVWN1TDR0TnA3WXNwTmdISmc3bVlRNjFrNU5INzhhRkdtaWtjbHUw?=
 =?utf-8?B?S1hlMUNpQm5EZE1MdEI2K01JV1FrSW9tOXR0RHI3TXBOZit2MXg1UzJJeEZO?=
 =?utf-8?B?S2JDZENDVTRUcW55RnNiYkY5Uzc4bFpFb3VVS3hpQmo4TVd5TDdWQ2dkOTVX?=
 =?utf-8?B?azlkVGprcnM2anZHMDNNZktlYlN3cEFDVUsvcUVobU9PdTA4VWlDSUpZdURB?=
 =?utf-8?B?YWRoSjMxUFoxNHQ5Q3ZXMHJRbzY0RXN6dHVQVktWK2JQNlFRMmR1R3lrVjc0?=
 =?utf-8?B?eWRzUlN5ZkQvUktPQ3RiZ2xHVThFL1kwVmErYzlOU3Z0aGFaQjNLSEpxQ2VJ?=
 =?utf-8?B?dDFMcDZvN3dodWs1WFp3K3dPRG1USldZcHE5aEc1ZUlHcndHOHJiOGRMYmVU?=
 =?utf-8?B?dlNvTGlMSW9GNjhFdDVIN21BTWFvVlNTMnh3dGRFYnU1NDFVajZaSlBmVmt1?=
 =?utf-8?B?M2UveFZxclJrNS9nSWRSZ0d1V2xmUFBKOFp3ekJjaXV5SVFoKzBSdEpPNEpo?=
 =?utf-8?B?QkxSQzh2cXMxUkgwb09iaGJXR1VnMG80Ky81bUlxbXJhRWFBMHpjby9oM0I1?=
 =?utf-8?B?Um1YaEZsYW9YMTRRcUpxRVUyTzdLMVcrSWxxN2ovQndsWGJnY2crbSsrS3A1?=
 =?utf-8?B?ZFl3cG1id1BiQjdGWE5aVmpZS1VTU3BGU3VIUHJRMjVWWXJ2RFRiRkp4N25r?=
 =?utf-8?Q?RhN+EZCvLVGoAHYz2etrrE/CN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaee0463-6586-4f74-5b48-08ddfb484989
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:56:44.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIi492jU0qohw7tjfzY3UEejCID9K4CBABkw+qoVWh0nnvpjt7EXYvkahL/LIDr0oqIxMoX5EWnO9cMK0HLvwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118


On 9/19/25 20:58, Dave Jiang wrote:
>
> On 9/19/25 8:59 AM, Dave Jiang wrote:
>>
>> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Use cxl API for creating a cxl memory device using the type2
>>> cxl_dev_state struct.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> with a nit below.
>>
>>> ---
>>>   drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 651d26aa68dc..177c60b269d6 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -82,6 +82,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>   		return dev_err_probe(&pci_dev->dev, -ENODEV,
>>>   				     "dpa capacity setup failed\n");
>>>   
>>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, &cxl->cxlds, NULL);
>>> +	if (IS_ERR(cxl->cxlmd)) {
>>> +		pci_err(pci_dev, "CXL accel memdev creation failed");
>> As Jonathan mentioned. Maybe dev_err() to keep it consistent.
> Hmm....looking at the rest of the driver files the pci_*() calls are used instead. So ignore my comment. Although typically device drivers use dev_*() calls and pci_*() calls are reserved for PCI core devices.
>
> DJ
>    


Hi Dave,


It is true the sfc driver is using pci_err and not dev_err* but I have 
been using dev_err in the sfc cxl code from the beginning, and I do not 
think there is a problem with that at all, so as I commented in a 
previous patch, I'll keep the consistency with previous error reports in 
this file.


Thanks


>>> +		return PTR_ERR(cxl->cxlmd);
>>> +	}
>>> +
>>>   	probe_data->cxl = cxl;
>>>   
>>>   	return 0;
>>

