Return-Path: <netdev+bounces-226068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F50B9B955
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B08381150
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1717624679A;
	Wed, 24 Sep 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTycao09"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37660AD4B
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740564; cv=fail; b=Pv5t6zKEuIjQxFEKcXrHynokOfKzqSYGlViYBf+Ja2BeaGQeZqm7JbgE+JhZBVVLGqf+U96cKKWcdgiMMZO3WOeKvJJwThZ1rF0k0Q19V6iOIVCqTozu/K6QdMPsNjsWv6+pz4p/PxQBAs0E/CIxrA2qlsbAaheb0QT6gWgKdj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740564; c=relaxed/simple;
	bh=2HjMIC9sYWR4l1EpM7yrqEUcvYUGXqM7+BdpeGSpOEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USaJFbkfI5EEpMn6uWLHvyTLRxnwNKDf0oBKsSzsEjd+f7L2td1GYRr30WQBeutEiA+mN5Bf7YxsUIVy0O4b62MZP/ju/C0dTfkftYAOJFfWhFBRwSaj5u/Nw1VzRrPNt7cYsVd8c8p+DfmKeFF0GANO70lbeg83YIRzbHkP9v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTycao09; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0h15D4BeAvtltpz4bqF/aXcW/iSzsNW+SJyXAQ2lEwceCczLVNvS1jTAnziXRNl8+/LLleAjVqZEJu7bm4bNkc89fJwuFAHSpV9LDpZ9qdVgOuDRbt3EjJMppMcsdLtDQN78qJCQE5DjYwzzZru/F2k3ntyTbC9539UD0WozJLkZsdMbgqUhwqcJyjWbyaQzxxzqO4h4Gl5shahV882819U7Kx4IOOu2j3z8pEo7KqwsGEOy+gOPI86feYMcaxqfx8XJdwR/6GhGHOgRPaOgeUaf86nhiBlw3GLlD7iIRX0N14dZNO1YUMx5d3fPIw8LRPNh0mdg6yidNop+5iKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2LafqgVBmqZ7AeXa5v17SsycSwGZagubZbfPcrJhjY=;
 b=qxn0pW7SKrARbFKxjydw0JX3GOsdGCZ0SDCDwKBk1Qe1fYpB5XtW/GY2NtLoiOP087zrpfJDf/jGZ8hBeqnj/3JrUr7q2TziuH11487g3TdtB/8QqyYxnSL3Y4K8u0H32RaWGNAYqOyZ7hGVnZa48RzkXQG/KY0iBAkk4/rqbJcN5f3O0p99Lc4iPlNVpgKb++MDN471Qqas4jk+wgF86c3Em9cOJ78UPkC4hvPFj4dsA7PO/S9v0cL/gl9OxWFelc1BzbAJDdxglyxoYVYdqvARKQqqMY4hOTgUxAF+DELGb/08f5JYzQisc37CRJOOXA46WlVg0ltd8pio9Lcg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2LafqgVBmqZ7AeXa5v17SsycSwGZagubZbfPcrJhjY=;
 b=PTycao091ebNQtqwceFtH+w/ex6TlYO2KFFv+6qA/qVrRbOhhuR+KO6J+7mrMZcU+qJMy51GQFN6PmJajL0SSHP1mA9bVsl1txaD+Rj65dHvB+oO9za8s1V1h4o5u8IgYoDQILYPVt0Hzhfa1jN92DISjgIRnWsTjziuaKxA3fNczkqjL5TwPjc9WY09RLM/70nsCoNQqgw54q6hCzMgRLHPTDtz3M9F4RG+vGWc/LGAqZ45qH2z1gISWEpi9TLw/ZQvSaSmbJ6DvkaOHHY1mTukiSWQY18ISrxtJ990taZ2w7+5lVXg5jjb5gytkFmW53z/CEfACf32np13W5xRKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 19:02:37 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 19:02:37 +0000
Message-ID: <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
Date: Wed, 24 Sep 2025 14:02:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 Yishai Hadas <yishaih@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250924021637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::25) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 690bd9c3-d975-4972-478c-08ddfb9ced4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWJrc0VLZ3B2Y05yNHBNMHQ0VHlZRHRnaVFtYkhuZStFTFZRejlNWTZmeno4?=
 =?utf-8?B?V3hTZVdoWVRUaThUQ2dWd0M4QVN5M2MyMElxNGhOK2h5ek1JRkk3cDlPd2Mx?=
 =?utf-8?B?VEhIaVhVdERUOVJHb25Ic2lmNkJFNkNFM1YvTUU1ZS96NllHazY4TEd3T1Iv?=
 =?utf-8?B?eXhHdnJnV2xROTZrcEdCRzkyZ3JWL0tmb1hNNGNkUVMzdFlmbDBhOVlheFVH?=
 =?utf-8?B?U1ZLbDZldjlpTkNtSVNDR1oya01oVFZpV2xrTmROZm1RSm0vbmZndWJtZjJs?=
 =?utf-8?B?WWk1MjV6MDFYUmQ5THp3RWFkbUFqT3kyUEUrM3JoWmRzeTVQU3hXT0R1a1hW?=
 =?utf-8?B?YkV5alBxUDAxbWVMUTAyNlltdXJIUmhyN1ZyWGVyRTdiYzdXRVIwVENUdU5m?=
 =?utf-8?B?YVNhU3Q0dE91UUpDODFBUkJSZk1pNEY3RU5CKzh5clgrak5SS0oyODAwUkNy?=
 =?utf-8?B?TnBWSTJ3d3FvZXl5d1NwV3JmKzRLaWZESTFOcGdnVEUrcG5jb3hkRkJxSm9E?=
 =?utf-8?B?Mmc0WThCSi9Ra1NmWU5xYUFYU0dGOFpTRlJWTHFoOC9yeDMyZmpCQ1lFdkZv?=
 =?utf-8?B?VlF3dVBvM0RFYmpjQnNja0ZaNTBRTm00VXFsa3d2ZFJvb2Y1SGliOEptLzFw?=
 =?utf-8?B?dkkyRmNSYzNhUFJzZ2xNZEt1U3V6RGpJYi9ONzJhL28vblJqSTA5dDdSVUo1?=
 =?utf-8?B?enlQUU1MYXNOc2hXV0N2K0lFWjEzWjU4RURRcmMrMjlFaUFKY0lDemVtNHBl?=
 =?utf-8?B?RXVsUFNvbkFJczdUUkdCM2dyTXF2SzRUalFMSDc1MHNTaWsrSUYrK21uZU9I?=
 =?utf-8?B?c01qdnRUY1lQdHBOWFRnU0VEdktBUStPSXc3RnUxdVdUdFVMTXNKVThQclgz?=
 =?utf-8?B?ajhrS3VNU2R3UDNjNlNlVmpaREtYbU53WEcydEdCYVpMcWFyczFZanIyamt0?=
 =?utf-8?B?YS9UWXlQdmNXNmQ2UUxJSHROVDlnL2g4bmF5eU94VStDdzI1bllhRDlGenFO?=
 =?utf-8?B?WVNkbW9sSmxhTlAzTW1XZHFOeUF3ZlNXTTRiMmFyb0dSM0RxRi8wajJJMm5i?=
 =?utf-8?B?OUFsNCsrMFJaL1lmNTJ6UUdiZUh5MVBPZm0zZC9FR0JCaExaWk9nNVp6azJa?=
 =?utf-8?B?NWFTVjhIQ0pTQXFKeUF3cGxybis3R0hkODJyd0p6dGdkY0hsbzFZNkdzcmFp?=
 =?utf-8?B?TzB2SmpMU1FoUnBiM0ZOMHRpODVDcW1rVjBEalhJb1BtZVJzdVhGVFZQeG9H?=
 =?utf-8?B?OUdXL09zUW0ySFlqbllJakRJVVZHaTZNRnBybmp3RENKZFpPamRuZmF5OXVD?=
 =?utf-8?B?UDNxM1dEZ1ZSSzRkNWdIdFR0clYxQSsrUFJ6cENtc0s5Nk9FUlE1Mi90K2hq?=
 =?utf-8?B?ZDBnOFd0QUZGSmNsQ09DRXNkM0JMZUsvaFF0M3lGNkJaYjNKSzlqMWlHQnNm?=
 =?utf-8?B?SmsxdHk3cndtVjdZMFVmRDFYWTFNVG9Fd1J4K2M0R1NmSzdpR0pPeFQvRWZO?=
 =?utf-8?B?K1hmcUNjK0N5YndPQlZud1F4Mkh0UXI5RWRMQ3QrL1g0eHVOSXVteXBrME84?=
 =?utf-8?B?RFQ4QkV5clBIT0lpRkpFSm9BNFRldnNyRjlrcDlSZUpQbHg2eWl5ZHFXN2c3?=
 =?utf-8?B?L2VsaUI4UnV5NmpYZEtRYm0vd2d0THRQeXF2OUtFSU8wMFRQcW80aklRSUdO?=
 =?utf-8?B?K25vRmxkRTZGSG5GTXpYYzEvbUFFUTVWZndNYi9HN0Q3OS9tZG0vRVNodWNG?=
 =?utf-8?B?bWJjZlpBMGZuVm00ODJPWFpiaDZ6YVhPcUpwNXcwV3VlckRyQUZVcjRQL0JR?=
 =?utf-8?B?SVlmdXBDRnJsUFJQN1UvSTNDYzBiSkNTVmx5QjJaMTVnQ0VFdDBReXlPODVX?=
 =?utf-8?B?TUpRSlJRRytGZG8xSHdVQjBhMXE3S0VPWUNzbCs3SWFsSURlRkRWVFlQNE1W?=
 =?utf-8?Q?5kp44CrthW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3RLM0J1YTRXMkZXenJzN3VDYkZDVkM4UG5jTFcxeS9odU9pZzFIK2Qvemdz?=
 =?utf-8?B?ZGw1NEVLeWtSQkMrakR5TWdTYnorTWtoaFR3akxTcGFQRUtmNE9qdDJsZ1Vn?=
 =?utf-8?B?MlB2Wmtwd1FGTS9Ob1VqWjdBelRUV1IwZ0lGdjRYWlhkbG9aYU1BRGxIZE90?=
 =?utf-8?B?Y0RrcW1jTEFBbGxwZjlQdTJiWXhmQ3ZURlNLa0lpbTJ0VU5DKytqdkVRWm9I?=
 =?utf-8?B?OVpVTWhlbEsvZ3RLbi9URjltcXJnazFrN3doMDRBRlM2dVFyMzQrVjlHRDFz?=
 =?utf-8?B?bEpVK3JtWWdqQ1dlSzNXbTNEaUxCNVIxRUVLRGg2Z2I4SEpPQTBsTmZDYldn?=
 =?utf-8?B?RWZoa3pENWNubktGN1RDdEJleTlWelMvRHhidGtEMXpQN3hhTStBVFl4L2ZI?=
 =?utf-8?B?UTlqRk5uRHFhN25XdElSY1U4MENRSldHVVViMWNRT1d2MUVpU1M4R3lYNkty?=
 =?utf-8?B?VldzWWdrTkJYNUFWbDY0VUEzY0J3RXdKUFZvRTM4ZjZPUzRISXVPNHBwdmdV?=
 =?utf-8?B?dm1NMXJlNlgwRXpYNXUrVDR6NGJXd2RGSUFSMlQ2TXlUcmpiQ0FybmhhbHJq?=
 =?utf-8?B?amczS2RLaUxLMldCL1dyd0E2OUl2MlpWREh0d2pyRHRKT0loeGNZVW9aNmFI?=
 =?utf-8?B?dzhTTlpWQUl5cmpIL2RyeDZQRTMrU2hCVVpYOEZqNXl6bkJKUE1QR3VWZFVu?=
 =?utf-8?B?b0Q4S21jTnI4M2EzNmYzVHo4Rnk0NjJmb24wTzk2enNJa3BGaXpjeUtjdHRU?=
 =?utf-8?B?NGxEMHBhQzN6Q1FSZ3IvcjQrVXBKUE8vTTJUY3JOb2RnR0NncHIxQWthVFV5?=
 =?utf-8?B?b0pweUw2YnJhQ3R1T2dQVXJtTUg2MnI5RVB0OGkyWHlBUW9Sa3FEcE5HUm90?=
 =?utf-8?B?VWRUNVAyNWM3VnhDU2FGeENvVDV4UElYcm9pQXAvbkVXOUZzYmltQWpPSzFl?=
 =?utf-8?B?dWdFMnNQL2xOcU5qV3IxV3VJdUFZRzlVRGRsUXBuOWdXOHRWUGNuNE4xV3Fi?=
 =?utf-8?B?Y1FpbmlXQktLMSs5cDc5WDVudGg5eDduOXljMnd1YzlyM1hyZURyTXJtalgw?=
 =?utf-8?B?UVovTm83M2UraVdaT2FOQXhDYmtQQlJUc3p6RzFuakVObVJnZFNOQUlzYVZX?=
 =?utf-8?B?MVBFSk5MQVJZMHRoT0VRVkVTWnZWZGZnRzg2V2JFYlhYY3VyaGE2RGtOVDVR?=
 =?utf-8?B?MWJLTFBkampmeWJwdTR0Qk15MFpRSnlGbzhaclBZWFBmYWIyMnhtZGZkSW5B?=
 =?utf-8?B?Uktkb01jYlNQNGRzL3FHUWh4MU1pdmZ3eHRvU0ZVZVZaQUV3ZkJqTkV3TU52?=
 =?utf-8?B?WXJDNWNUQThTQ3BtcUFRU1pRc3dCOW1ydCs2bW9iaElwVUMvd1laaXNkVlFT?=
 =?utf-8?B?b0dhSjIrMnUyY0xCc1JrS2NyNm5jeXNBeVNZSVNsVHI4VEFqdzJDQXdrbnR5?=
 =?utf-8?B?MDVXM0JNZXdQNENKV0FHOUo1SUZ3cS9aVnJGMWFCWk1GNW9Mck9ERmR5Q05t?=
 =?utf-8?B?bWVRZWQ2aUdUYVhxUERqOFErOUYyUGJsQmJMMGs3eHJWa0RPWkpFcjRXNnpv?=
 =?utf-8?B?K056eWNXUGNycWlsOTVBbXFWK3Z2TlFrOXI5eFkrZUdNcThhUGNOeE9WaE1K?=
 =?utf-8?B?VlhmNndXbFU1aUVkWDRaZ0xrd2Q3bkVoUldMaUhtbVdxMjU1VUNpR2RBK0Fq?=
 =?utf-8?B?TndwOGJFaG4zQy9sYS9md3NNVXo5bGRUL1l4VUI1dXVDa3pBVWlyOURkNEFN?=
 =?utf-8?B?T0JoTHI4S3ZIb0JUeGNEQmNyOG93NGdibHdaZ1FNUkJSRFJkL0Z0S1c3ci92?=
 =?utf-8?B?ZXhOc08wdlhGbnJkenE5cHRHRFFab3dWbm5UcUpRdDdPY3dUdlBEekNEMXlQ?=
 =?utf-8?B?OFVFbElUSzNuNmxhK2ZKTElRRDV5TUtFMFdHeU1TdmgvRTJaczR0WmRNb2ZF?=
 =?utf-8?B?RHYyYitFQ29yU0l2TTVWWTM0T1dPb0VHdmRSTHljblcraEkzS3l0dlNFcEVC?=
 =?utf-8?B?TklCd0ptNlBpZjA3UG9GN3ZJY0g2YklHbmlVM2JXYkNLeFVZZlpHVnRGTWFT?=
 =?utf-8?B?Mm0rYWxPaXpZdFk0M3ZaelJMVmpGaGhaTGNjc21SUHh6VzlJb3lydndwYmJa?=
 =?utf-8?Q?Lx0Er2d/JloWZrzMYVJZy8dLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690bd9c3-d975-4972-478c-08ddfb9ced4b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 19:02:37.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP7WKY/PfE3VNaPrtA1eY8suHikEnDM3v+VHNRzF41oFc1PIFHZQG0JjAnx7z+e7l7ZLf9XrwNJBaOvQWo/8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093

On 9/24/25 1:22 AM, Michael S. Tsirkin wrote:
> On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
>> On Tue, Sep 23, 2025 at 10:20 PM Daniel Jurgens <danielj@nvidia.com> wrote:
>>>
>>> Currently querying and setting capabilities is restricted to a single
>>> capability and contained within the virtio PCI driver. However, each
>>> device type has generic and device specific capabilities, that may be
>>> queried and set. In subsequent patches virtio_net will query and set
>>> flow filter capabilities.
>>>
>>> Move the admin related definitions to a new header file. It needs to be
>>> abstracted away from the PCI specifics to be used by upper layer
>>> drivers.
>>>
>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>>> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
>>> ---
>>
>> [...]
>>
>>>
>>>  size_t virtio_max_dma_size(const struct virtio_device *vdev);
>>>
>>> diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
>>> new file mode 100644
>>> index 000000000000..bbf543d20be4
>>> --- /dev/null
>>> +++ b/include/linux/virtio_admin.h
>>> @@ -0,0 +1,68 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only
>>> + *
>>> + * Header file for virtio admin operations
>>> + */
>>> +#include <uapi/linux/virtio_pci.h>
>>> +
>>> +#ifndef _LINUX_VIRTIO_ADMIN_H
>>> +#define _LINUX_VIRTIO_ADMIN_H
>>> +
>>> +struct virtio_device;
>>> +
>>> +/**
>>> + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
>>> + * @cap_list: Pointer to capability list structure containing supported_caps array
>>> + * @cap: Capability ID to check
>>> + *
>>> + * The cap_list contains a supported_caps array of little-endian 64-bit integers
>>> + * where each bit represents a capability. Bit 0 of the first element represents
>>> + * capability ID 0, bit 1 represents capability ID 1, and so on.
>>> + *
>>> + * Return: 1 if capability is supported, 0 otherwise
>>> + */
>>> +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
>>> +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
>>> +
>>> +/**
>>> + * struct virtio_admin_ops - Operations for virtio admin functionality
>>> + *
>>> + * This structure contains function pointers for performing administrative
>>> + * operations on virtio devices. All data and caps pointers must be allocated
>>> + * on the heap by the caller.
>>> + */
>>> +struct virtio_admin_ops {
>>> +       /**
>>> +        * @cap_id_list_query: Query the list of supported capability IDs
>>> +        * @vdev: The virtio device to query
>>> +        * @data: Pointer to result structure (must be heap allocated)
>>> +        * Return: 0 on success, negative error code on failure
>>> +        */
>>> +       int (*cap_id_list_query)(struct virtio_device *vdev,
>>> +                                struct virtio_admin_cmd_query_cap_id_result *data);
>>> +       /**
>>> +        * @cap_get: Get capability data for a specific capability ID
>>> +        * @vdev: The virtio device
>>> +        * @id: Capability ID to retrieve
>>> +        * @caps: Pointer to capability data structure (must be heap allocated)
>>> +        * @cap_size: Size of the capability data structure
>>> +        * Return: 0 on success, negative error code on failure
>>> +        */
>>> +       int (*cap_get)(struct virtio_device *vdev,
>>> +                      u16 id,
>>> +                      void *caps,
>>> +                      size_t cap_size);
>>> +       /**
>>> +        * @cap_set: Set capability data for a specific capability ID
>>> +        * @vdev: The virtio device
>>> +        * @id: Capability ID to set
>>> +        * @caps: Pointer to capability data structure (must be heap allocated)
>>> +        * @cap_size: Size of the capability data structure
>>> +        * Return: 0 on success, negative error code on failure
>>> +        */
>>> +       int (*cap_set)(struct virtio_device *vdev,
>>> +                      u16 id,
>>> +                      const void *caps,
>>> +                      size_t cap_size);
>>> +};
>>
>> Looking at this, it's nothing admin virtqueue specific, I wonder why
>> it is not part of virtio_config_ops.
>>
>> Thanks
> 
> cap things are admin commands. But what I do not get is why they
> need to be callbacks.
> 
> The only thing about admin commands that is pci specific is finding
> the admin vq.
> 
> I'd expect an API for that in config then, and the rest of code can
> be completely transport independent.
> 
> 

The idea was that each transport would implement the callbacks, and we
have indirection at the virtio_device level. Similar to the config_ops.
So the drivers stay transport agnostic. I know these are PCI specific
now, but thought it should be implemented generically.

These could go in config ops. But I thought it was better to isolate
them in a new _ops structure.

An earlier implementation had the net driver accessing the admin_ops
directly. But Parav thought this was better.

