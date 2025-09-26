Return-Path: <netdev+bounces-226709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EAEBA45AD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1FD3BA9A1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0881EF38C;
	Fri, 26 Sep 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAQCGGwP"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99641FAC34
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899319; cv=fail; b=ENnrLyraE+HmVA5VcSgQ1viqqTr1W0PAgokMrhUfbztEWU8wHTKBFOELWGJhGe+yzM2O0cAFG04CaKR1k4NQqWBAmMnt738pd4JiajZYSbNlg+tnDzz4AcFCOFhDnNOBZo78EHknnBlcJBUvpOAQzgZdfW3fQKG1QcBIX74Vn+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899319; c=relaxed/simple;
	bh=kOGSRdY7OxAdVKRRFataOoHekELYi1Ai9LX6tSQGVAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5VSpXvTPpATxy8ecMIDxo5IR2oCf/KmZ9xku/QvqfqI8WtIt+LXhFEeZEUaflJ10e0d8GjCoOY30gO6FXAVpSke7B29vCRC6gIyRFnXEvfJwkBKms085hqnwZ4GvQQywgg2SwRrSleSdsaan+ZCQfK+4LmNjqSaR51ssvF1k88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAQCGGwP; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqYii2jnj+LeBYWKe6JkVlfKmHwq92tAqxw/tzWz1VGvwh8Z5CkGVO937fM0p1zaKTOPqG8hfEHRR0WJRsB4q/MD8T2TVPNE9EOu/JnX+jjBVEtFju+uHxYxbNLB/RVxNRnmWXtN3+btdOo1Vxt+aafOW/IchabZlWwwPCsg01mVXFE1Zh2NkUJLnke1cyxevi6AJ6ca5ClNWj2NFzXnjbcyYKMBe2qKupgzNnB8F5L3LQ0t8k3gEst0Wj6qypIr8zXsBtC2rMmzik/v91g+1bhgaW6alcn3fF1uVdluwN6x7CjSJY7YJj1+y/eUU3TKEmMb4NL8z15+Oq18+Q01LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmff/H7DMCVaKlCWUwdSbcckX+MQt/9C77iwhcew03A=;
 b=YNPCGUjnO8dHGo1pblFVoSPWa44hxSge0EFchBci40t30CGVTm3WZ9WmVe2aIf5qnPbrvfafKq1VMBTl8XAbj0+gUK7sYFWPQD/exdNtn583t3nuFF+bo3rdSwbGdykq2lzlcgxplEAhw6Za8GX6bLBtFo4aYGIETZeODGrP5D6U8si6N3tXA7g1L6adKXQMYLi+d/pkVBh6oNMLIjgCgr5Knq5tr/q3DcQnM2jly90OugON2uGbsOuW+TD8RBHk9sqeAWaPQ0cIzi2UVMvPd7co7SuglMxC+QF+pYswh9DA64/B/RP+KxX7H3U7qIh0rnZbhjPmJBgtQd/cJYUuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmff/H7DMCVaKlCWUwdSbcckX+MQt/9C77iwhcew03A=;
 b=kAQCGGwPRRDixkYdN8yje74qgk5YlKddMLFWFBuDvCj5zldtIshgaSsU0uNczyaglbadOrugS89NPBm8ADzQP8T5TNqprE68aeO9AjCRHk6XtEuDVczxxeashjkHMmlT3N0G+kamWHKZLRyZALCnsk2v7zBv92uoczZILZkkZcR7PmFd4xc5a1TgBA5I+K9jdfIVhMFzo2Mz/trFtaMxJrelATY+ONAqHe93y3LmUgH7HIO70Z8hHBpvmZU0qObz0pPyNKiJjA1MuBNyVzdyaDrGlpgkn89EQtxwKgBBPnp2JHRkYQ87zATuj9vjlvr5k8a5XBis8we/aSVccqE6uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:08:35 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 15:08:35 +0000
Message-ID: <3b3a8537-22f4-46c3-9142-78a00e65d43c@nvidia.com>
Date: Fri, 26 Sep 2025 10:08:32 -0500
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
 <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
 <20250926023237-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250926023237-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0160.namprd02.prod.outlook.com
 (2603:10b6:5:332::27) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9386fe-a077-4cb1-ccae-08ddfd0e903a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGF2VCsrQU1NdCthdjcyMkVyeTQ4SHFQU1QraU5tM3c3WTNNZ0J1WFlySkhC?=
 =?utf-8?B?cE5OQmVqNDFzVmNWbzFHaFd0ZWV5cDFtWVV1ZnZ5WmpVWnFUeHNjZ3VPdlNO?=
 =?utf-8?B?UUl4dExIMFFWb08xakFDRkhwQkU3bENFOEo2L254Rzk3ZVpabUg2RXBGelJ4?=
 =?utf-8?B?amVrWFcxRmljb1dhME4yMUxybC90WnBnKzJQLzBOU0o4RUFYVFp1bkpyTUpy?=
 =?utf-8?B?SjlPakxIaXVub1BKNW5ZNTg4QnU4ZmliTFdWZittZmcrUTRUSStwQldjSWpP?=
 =?utf-8?B?dlE2TzRxR3RKWlMvMUUrcisxTE5kNnl0Q3FKQklnc2JObUMxSnRZNGkwaWlF?=
 =?utf-8?B?T1JxL3l0TE1VZkZNTXRqVUt4MFAvSjhZNnFHYWtSYTRQR1BqbmFjMkFyWmNt?=
 =?utf-8?B?MDZsSUh4MGQvalM0VXc4blFKM0pVdkhkTGJnZEEwWmEyeW9Odi93ZG1VVFMw?=
 =?utf-8?B?MG1OV25xRWozR3l6Ym5hM2VTNHhkRVpPb012QzcyV0x5WThRYVl2bCtzQWJ3?=
 =?utf-8?B?RDhQa3ZocVJmdXFqTlJrNXVjWHNiU0pEWmh1dmovaVZqYmIyUXVKa3VxOExk?=
 =?utf-8?B?bjNyUlo2eGcrWDgwK1l1cGFQNFNrbFNEYi9FQUxjRUJobFp5UlBzcmNwSWJQ?=
 =?utf-8?B?bUpseURDS3BTZnlsT2FqSm1FdkhQS0NZSHJ4THJxeHRidHlsYlhDcVY2R21l?=
 =?utf-8?B?V212YnpicWs4R0NsTFRLUFhuSUFoTHFmeHdIdktHOW9nSS8xdi8rREdmUkFV?=
 =?utf-8?B?dDN6UXNLcXdtaUF4K1k5allRUURsRFdoMGJyaTY2cWN3UDQzQ0NSVGFCUnZP?=
 =?utf-8?B?Q0xOc1BKeTlCL0F2M09jamJwVkV6eHlwYVBEVEU0WDR5MjZTaE9BdTNFTDlj?=
 =?utf-8?B?d0o4clhiM3I3NWoxU3JtdGFBNE9zTURRSWFGeFV1bjNETUxRaTVhbS9JNDlq?=
 =?utf-8?B?cEdqN1RjS2VkRU5Mb2dEVnFvV290ZXJHNU5IUzNMQmFoa1p2N2FiV21uV0VY?=
 =?utf-8?B?QnVQSE5icXZrc1h0T1ZIaVQzbk94UmZJekZWNnBLV2dFb1VUd3hHYWFaSWRq?=
 =?utf-8?B?RTVIelg0V2NYR0liQVRaVVhmYkczU0QwYmtINnZmaFVWazlITSs1ZTEwYkp2?=
 =?utf-8?B?dDlQb2l3SlB5bXkvSHlEK1ozT05BOFFhNGlwMFhQWUYvUEhrdXg0N2NnN3g2?=
 =?utf-8?B?YlNja3Zwakg4NXpuYTV4Z1ZnTFhLNWlZNC8xbzM0VHdHTEZwZXVaRUI0VFNv?=
 =?utf-8?B?a3praXQrRCtHN0RaY2lid0FwaVlIRlZYRUQrRXYxd2wxUzJXSFhiKzVDRWVQ?=
 =?utf-8?B?OXUrbHNOeklqdWFGU2xjMkRxaG90YUIrYk8wb05KT1VXeWRuU1lWSi9qR1gx?=
 =?utf-8?B?UkhZL0VVVmRYb3RLMXZ0TGtUYmFETUNNSGM5L0NoU3dTejlhbDFOakJxSGxQ?=
 =?utf-8?B?ZGJZMzcyRkFidysrUEtxdFRjd29PZTBhRzN2SllPZDk2dUVPRXIxK1NxWEda?=
 =?utf-8?B?bTRuZnp0dUNENjVwWW1MZ0VYYjIvSnU5UFdYTGZOeDBZZVpsc0c4WExKZnU1?=
 =?utf-8?B?Y0ZWRXU5OWNLUkR5bE5pSnI3clRrbGxmSFlSbVlQU25ZUXpIdXBVS2dWelQ5?=
 =?utf-8?B?TVhLVjVsTXNzRkRKZDI3b3BTZC9UcEhRdE5WZ1VZR0FaT0t0VXA2Tm03UVRN?=
 =?utf-8?B?ZG1qcmNOeEg0ZzlIeFpyWXdTdU14VFJidjE5bDA4ZzVxcDVxRDJkYXpscUk4?=
 =?utf-8?B?ZkRqTGF5b2YzM0xYZXo2OGhhUytLVHRXcWxpWDJwbmdiaEpvd3BaSm1JZDZu?=
 =?utf-8?B?RmF2bkw3MmtZdUYwZjVHMEwwcTE1RzlKWnRJV1VLYmZSWDZmZkxaYVFyQ1Ra?=
 =?utf-8?B?ckxGYitWU0F2cTVhNFpQSmtOYWdNd3AraGl0VS9IUys3RkMram1jYWxvUnJJ?=
 =?utf-8?Q?PiZ7jGqVGITuN6+iAV2ZE8zFTjHMhwzJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZ1K251dFpxZE95c1NyYXczY3ZCajFhSHBhbVNaT1VzZko2RzFaNFZ4OXU4?=
 =?utf-8?B?RmY3TVJ0dlF1aFFYS2RYZjczdFZOY1RsMFRaNkpFaHUrTVZxQnkzOUhnK0ti?=
 =?utf-8?B?UFVtdmJ3bHFBaU1tNjg0cG54RkdWS1l1cW1zclkxQWxURUVnNVp4REtsQStx?=
 =?utf-8?B?REJzRk1rREpsSDVwREFVQy9pOVRBTVVnS3p0bG53SlpWTlNDMXc1RTdheTZO?=
 =?utf-8?B?QXplTzVpQTNEME91VCsyck5jVWZPZk9vejNUR0ppWk1JdmZGeGdFcjZTRjQz?=
 =?utf-8?B?Wkx4Z0Z5Rkl5TWpObDA5T1hJZ3IyM0diL01LYml1Q1FkalF4TmVPZHNYZFZa?=
 =?utf-8?B?OEIyc0wrMlZKOE9kdEgzNDF3MCtFZFZybnVacmRXeVlDZXh6a1lQeEhnL2cz?=
 =?utf-8?B?OVdFYWRTazZhbWVhcW5XQ2Fod0ZrN0J6OTEzZ2ZhckhxMkU1L2pJbmZVN0l5?=
 =?utf-8?B?OFlWaXVhSUhJaGplcFpVVC9VWGM0OTJGUXRoditvV0pIajJiRWlETklWVTFF?=
 =?utf-8?B?S0JQT3NsclZaTW9FWnRNWW1uYjVzOGlJeFNhbkxsWDZFWGk2dUtyc0l5ZVdE?=
 =?utf-8?B?Zzh1Z2sweDZPUE56bDd5Y1Job2dFN2JIbC9JRHNKcjBxcjkyYmJkTGhzZHla?=
 =?utf-8?B?b1ExNUhhNHpNTEVpZVhrYlVLc1RISWpOTVlRRjlqektzMU5HZGUwMTNmYVVM?=
 =?utf-8?B?b0Y4TmJOKzJTRWZLOGZkNm10aFFiYmY3NzJRTkZYV2ZHeDhqNDRUQVlXdnNj?=
 =?utf-8?B?ZmxzNjVKeURNeUJyZ3ZzYkMyUEsrUXowWnN1akoyeFJiVVJhalVBeW5RcjZH?=
 =?utf-8?B?czJCNXhRSko5Y1JTNDl5OVNZSWlSZ2pWREJISTA2SVpOU2FOdFJ4Zi9LTmgy?=
 =?utf-8?B?V1U3WnNCS2s1RnBjME9nTjhTd2hQNzZGanFBR0JoUlZVRVNKbjBPLzhBWVB1?=
 =?utf-8?B?M2puWGhDdVM5UDJZSlNnUlRvVlZaT1Q2TksrOVFxYllsRll6T3J3UnZwZSs5?=
 =?utf-8?B?cnBDdDJwbGh4akhZWEdOdElEYzhTM0ZCSTE1K2lIazhDaWo1R2lFZkhDODQ1?=
 =?utf-8?B?OWpvd0VRaE1uVitUd09IZnJIajlzQkpycTY0WUNyaTluai9FaWNzQUNkZU1w?=
 =?utf-8?B?VkZVOTVVNUJBNjAzRGlBSURveEp5d2FNRmpZekJheG9oeDZmbzRGa3JqbkZp?=
 =?utf-8?B?SCt0eEdXZkhzdnM5cm14VUVpekUzWCsxSjVOeTJaRkozOVNQT3lUa1hwUjRV?=
 =?utf-8?B?SnlqM280NGh1dmZ5cHg0QlJsQUFxeEUrQ1NUUGx4QkxaRXNwSCtRVUJzVlBi?=
 =?utf-8?B?eW1MUjFoc0RnL3FHYlI5a0RWdk83bzdPZVNPbXZkMUxrb0FUNEJGMGVqYkc1?=
 =?utf-8?B?NEJ4SzJob1o0K2wrdm1pbU4zOERtb0swZ0hKWlRqd0FnT21KWGJST3lvMUFL?=
 =?utf-8?B?YWZjRHUyY1ZtUUdWRSsza1hGRWxrME9jUGU3em5ZV2NlVkx4ZG9uKzZKdUpP?=
 =?utf-8?B?OExKUlg1cEFiL04zQ2R1WFdHTmxHdWFTUTZDOUREbGVPcWwxMDdQbnBlL3hJ?=
 =?utf-8?B?N2JZRFFJbTR0NDA3OUR5ckQ0aWhVM0dXd1o0eFlvQ3BzUUdBRmtxQ3NwMUs4?=
 =?utf-8?B?bndOMzJDTVlDNm80Z1lNVk0yeUtlbEdoYm0rNWYwaU5yTDNHNVdJRVU3MmRO?=
 =?utf-8?B?UFE3OVJnK2lWcC94Y3VOQnFQWnBCempDTUhsVk9NZ2ZnSjkvVDZTdzArUDA3?=
 =?utf-8?B?Tm9SL2tPQ1Avc1J0UmhvKzl5V2pFTEZDWXlrY2d5c056a1FxNFA4dTJoMXNL?=
 =?utf-8?B?U3Ivc1FJSUtDRnUvcVd4NHJIRnRiMCt1Sm5KcStDMTY0bmhyYmJaOGp0LzVL?=
 =?utf-8?B?STNhdFVLS20wV1BzRjc0alRuKyt6c1NzMHNISzJwQ2RKZnM4RHFtbGlEQ05j?=
 =?utf-8?B?c2lZOHpuR0pPZlVRK2NaUU5ldHhjcnJySEdWYUJlY0xvK0lUcTdTeVpZQ0lu?=
 =?utf-8?B?eFhvR01oZ3VzWGI3V2NpZFBXVC96Q2FkdHpwQVg4RnhnOXhxOFBJNCtWUGx6?=
 =?utf-8?B?SFdJUTZvRnVqcFVVeDZKY1JUSVpkcGxHbms2Mm52NmZuSkMrT0Y4aHoycitO?=
 =?utf-8?Q?MyuPPRJfRZPjtuyll7GWRyeVh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9386fe-a077-4cb1-ccae-08ddfd0e903a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:08:34.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+lM+pHQkFTpW0EhUaN8aKdARB3uTVh8bFUHk3BBS+7cyBxu+S3ZBsY3GofiVMwmInd3R+jW8IFmhQNPYLcDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

On 9/26/25 9:26 AM, Michael S. Tsirkin wrote:
> On Fri, Sep 26, 2025 at 12:55:11PM +0800, Jason Wang wrote:
>>>> Looking at this, it's nothing admin virtqueue specific, I wonder why
>>>> it is not part of virtio_config_ops.
>>>>
>>>> Thanks
>>>
>>> cap things are admin commands. But what I do not get is why they
>>> need to be callbacks.
>>>
>>> The only thing about admin commands that is pci specific is finding
>>> the admin vq.
>>
>> I think we had a discussion to decide to separate admin commands from
>> the admin vq.
>>
>> Thanks
> 
> If what you are saying is that core should expose APIs to
> submit admin commands, not to access admin vq, I think I agree.
> 

Quick overview of what I did, to not waste a v4 if you don't agree.
Added config_ops->admin_cmd_exec. virtio_pci_modern registers
virtio_pci_modern_admin_cmd_exec to it.

Moved the logic that had been in virtio_pci_modern for building the
commands and returning the data to a new file file virtio_admin_commands.c.

That file has the 5 functions needed for cap and object creation.

