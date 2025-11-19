Return-Path: <netdev+bounces-239827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6CC6CBDA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 05:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33DFC35CC49
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433732FD1B1;
	Wed, 19 Nov 2025 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAWbw/ml"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92D2F998A
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526461; cv=fail; b=n/PrrArcr5Ps1V6JKn3c+eBS1l31qlCKZEI1XbdIkDSuQHmArfBA8BkESiNcQSQO0M9naZ4bsoo2AZo8UWv8peJotjFFQ2GNw/+4H4fWjEjKB9It5gOD04x8W8+yfqPNsUZEfn3v1xvfl1iBpjN0Qb6OtCnwtd0EVra17E4XqLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526461; c=relaxed/simple;
	bh=dN7u1qb94eMo7XUfuStv3s6ILrNyCH8jdk1XfqDkSDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IUbmuFNvpYGd2YkgtV6FjHagl1g7sqtXsGMQhaqmKF27s6aOaUx4xfSpsLX3B0kHByQzOPdZnZeNPlfUznNQ0CIle5XG2au8E07hGneoQu+YkC2nPCvWlrp4oLMzuqVeqBbD+AAgxs6yjEjWaX7tlisrlw9yTziBdUJDb3CPX68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAWbw/ml; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkbLUCzslNcULrZr1wUZXZXQ86GkU1jw+B7CKkDjfrb7tFVsKT9q2CspX6x/YjljUpWBlPdbVajL+4VkB1WL8pqu+7niAnDOH/KQd/VqLqg0Mh+tv/fMm8WepX52LLDloSqeOXrnCck3tEr08oR46G0M9OqQX730j4F33gMayDR6hH1oOlymxhREMrmeJZqgJaGPoe5C5FZ9ddKpOVesn9pBPYi6iyNBFSFXaxSPYjguJuLC/IVqLUi0vB089Z4BnPd8YUtFxhNimeh86B9xQj4+0fN7RaJG8INEe0ptFjpztPob+Kg27+lJXBBTZE/8Z9jlGVAbc5piBZKMPdDJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC1zi1+Xka+aMC8K+SEJa5eLQAq5sdeG4X5Bqv26kJ4=;
 b=rtyUp90yHdFTfR9Pc8yXFdvtJ9V95ITMP81IFVKazK5NMDtbIcJZkus7pCv3jBxOIhASdUHeM5856JSwzjXF6HKqf9jh4rEI5wb2URn0A4ftaNIrDcYGvWE38b9dzGZyrHHZJPPoPsUe/te/0KTSjahDBSKX37k4/wV9TUhw7ohY7rRDOGJqAwhgO2i5mFNGO7OOOP7z6ylsbi4sQwhLHOQNmrTVIWjSYnOHeoczOMONEWE3k/Qc6T6dcYOQNRukCPXMPAYOXyOR4JprHekTiUKHt6hK2eSxCZZBhQepnHbRqm3B6pMXg5hsA497aqf2McxxbUsJdwTq0TTs1IA1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC1zi1+Xka+aMC8K+SEJa5eLQAq5sdeG4X5Bqv26kJ4=;
 b=IAWbw/mlyNPiUOWATTQ/Gz5tM6HGC94q09dqc5pyvz8b0cOg8RMuIFCXnYRTHXrzYBNJJNkKrBb55QcEMrz5XXP2+KsprUXAmI2Hw2DrxkNF5qsRxN8ScRF9EOkwwyLawVVkJDNclw59wPY+QEBAsSmgxZzXraQKlphK7RZmAeJTQkumeb+UL8CKLpaZ22J6BqeeLoCL+uSP5H7KuJiAzu5PECKZePBD7F9+e/BpmCnFjI5Udqy9l1BMr540P6pLW6FCmIOD0YMJbKd1t8a/4jmLoKPbzhqT8u/7S0qqVx2CzugpHphd2Ky/zn6yJXn8qci+giizjO680Cvnwy0v/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 04:27:34 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 04:27:34 +0000
Message-ID: <b89b3ab9-596a-4ffe-b6a4-94b3af31496a@nvidia.com>
Date: Tue, 18 Nov 2025 22:27:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
 <20251118180127-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118180127-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: d10e6bcf-1603-4251-75c5-08de2723f5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFIyYlk5d0c1V3Z1M2NLdXJIZVhOM3BhdmNMWUZSQmRvY0dXS3FDVnRXOW9s?=
 =?utf-8?B?UlFjdFdwTFhTSStJc3FPL1pWOVBTaFpLaUw1elRGODBSY3d6Kzdad0t4akdB?=
 =?utf-8?B?M1orS1QyTHZnNGdzU1VDKzM1L0NYZkxkU1BiL2ZmWjkrcWhGMVBrMVpqYjR3?=
 =?utf-8?B?UGpCODNHRG82dE5sL0YyOUI1WWVGNWU4Z0FJTHlRTjhYOGhHWEpSM3pvNW5o?=
 =?utf-8?B?cTJyY0RHOVIvcHNsUDVpT3dPZFRxUDk0SXByeE0wOHVQcWYxaDd5V2FyTzhV?=
 =?utf-8?B?c2ZLT0JtY3FpbE9RUWpZVFdqSFpxSkI3bHphdkZuL084WHZSamlvdVMyc2Jt?=
 =?utf-8?B?QlhCYUhEM0grbGhuYzlYYy96N2VNa21sZzU3QkdIbU9ZRGRCVEg4eSthQXVa?=
 =?utf-8?B?SEhsMEtRN1FLYWVDcTVqN01KRWdvaVRaWWdzWnFySEQzYlc0UVlwWnpSTjZX?=
 =?utf-8?B?RHJ5bjdZZTR1OTE1SXQ0Q3lqam9qZ0h4N0VpeXg4TjJFYTNZWTQ4cHFZUGlm?=
 =?utf-8?B?eXJRbFJhWU90bjhWZ2oyOG9KT3FGY052b2ptUy96cGtZbXdKRW1qTmd5UjNY?=
 =?utf-8?B?K1pJZEh5S1NIOEZobVR2azEwTFJZRDBrZEpyWk1Dc1lJcTdrS0xaT2ZyT1Nv?=
 =?utf-8?B?bWFOdllCR252cUtrcXRDdENyUWpKdFd1amsrUkdIM1JBSytwenJZWHMydHhM?=
 =?utf-8?B?VWJyaW9ybWw2QUdObnRaM0o0VXM2eWdYU1BFZWc1RzN6bkVBUFpGaHFmTFZZ?=
 =?utf-8?B?dlRlaGFnejNDdlUxVFl4aWMyZzlrVThFb2Y3UEVFR2Y5eEMwcXVZOTA3V0FF?=
 =?utf-8?B?Q3o5NnlvZy80U00xcGdPcGxoblVISmZJblpGUnc1NWtpcVhxT0Rmd0RZYVpP?=
 =?utf-8?B?eElrcVdUT09tSE50NFpTaWJDb3RBNWxUTE5YTS9ydHpsbXpmakJONHFUaFRR?=
 =?utf-8?B?bU83bWFNL1VGaEVXU2JOQThqNEl3b2tpMXZiVFpmb3BNNVhFdGNuR2x1M0Rw?=
 =?utf-8?B?eGpVUlVudExDeE5zRjd4elFYWmlPSUNEelRSNlhac1dNaUZqaWpYbUMzWFRj?=
 =?utf-8?B?U0xvVmRzNHBsRytuSmV6MnhYT3o4eDArWGt4Q3RJRDRGSGlvNjhFejZJS0Zh?=
 =?utf-8?B?K25tNE9VUW50WkhHSGxKSVVzU1NNaTVhUXF4K3paWlZIUCtlRkNBK3hHK2JF?=
 =?utf-8?B?aENJOWNVZXlHcExTU3lvK2dQTHQ1S0RWNnNKeDhOV2g0OE9TazFwMHBxSE1x?=
 =?utf-8?B?Rk15WWNDbWNhZEZzNGFvVmpFemJvWnh6WXRsbzlVdmNYUGIxWGFEL2M5YjNZ?=
 =?utf-8?B?NFRxa3dFQXpTL1FYZkFuYWpjd1pMd09TdjRqMkpGaW1qTmJTUUt3ZGloN3ZF?=
 =?utf-8?B?K2c4Y3pXc25WWTZ0MDUrMkNyRkdZSFJQYWoyVEkwdDNqeWtLZ1hvQ1kxTjgx?=
 =?utf-8?B?bTluWEVkWUJrZmV5THYyeHZQK2lyOW9nbWN4VWhNSVZUYU82ZjdnWTBJczhi?=
 =?utf-8?B?OUhDbVpWMWY2MTJrb2ZsSWxYcjIzbjlxSWhQcXpYMGJRS2pqTVlzTFNnS2wr?=
 =?utf-8?B?QjVVSnhZbzVnWHJhTzhMSVk1cm82TVU4cXVURi9tZk9xUzFwSm85VDlkRlBq?=
 =?utf-8?B?U1AvQ1VvRnV1ZDY4TEkrUlpVUXluTnVpeWJzUEVwc1greTI3S1pVdFNBTHZ2?=
 =?utf-8?B?TlhVNkIyOWRCTzVZVElONHI0Q0FjS2Zqbk00bXJ4bk1mSUptMytJMUtWNGg1?=
 =?utf-8?B?Q1Q1M1o2SWs0eHZLSG5OSm1SVHVkVm5TOVh6ejJYNnZ0cUlmOHdNUWs3UFp4?=
 =?utf-8?B?SmYwL3ptN1Z2c1ovcVVaSWlwOTJjL3N2YWJDN2ZTQ1ZPU1RlODBzLzlKY3RP?=
 =?utf-8?B?cWJJd0RNZ1BGQVd3S0F3VWlRYkdlL3NMZUtTMXFDR05ZMTMzOWxSWnMvZDFJ?=
 =?utf-8?Q?49YNWE+RSQ5rKpPi1KNRTEqHCuQVfY8p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0pwc1NaSnhSdG9TUEpYOG43a2w5MmFVVUNMelIrdUVyQTlBS2RjRU9kQUdi?=
 =?utf-8?B?ekRFRXU4OGJ2VWlYWnYzV0tXWmJERTJLcUoyRE8yVHRLUFN1V0JGRVFoZnJ1?=
 =?utf-8?B?NnlMZFZCb2VNTEZpbzN3bUh1ZzRCZmhVRzdhUU5tc05iWGQyNlpRYTJpSmFJ?=
 =?utf-8?B?RElHVlFqaTZzdGhYVy9CWlNzZ3EvZHQ0MldJTFRyUEFuc3dVL0F0OUJHRGlM?=
 =?utf-8?B?eXcvR1RISm1QcURzOHRPbGJSaHc1NVJqOUdITTdhL1JZeTV0NUw3Y21Dd3pa?=
 =?utf-8?B?MUpyQ2NtUVhCLzR0UFhXbFEwTitueCtpeGpMdHFQRFVmOVhpYlNCaTVONndU?=
 =?utf-8?B?SWpDWEJWK01pOVMvdzhSUHBZallNNHBiVERUNE9YVlFoL2ZaN0w4aExXRGpP?=
 =?utf-8?B?a0J2RnMvNUhMdi91UktYTFRrZ09QMWVxQkw4STNXK0Jjb2h3Z0xaV3FIc09K?=
 =?utf-8?B?aHM5ZUFhR2RMSzg2Tkp2akQrU1UrUUl5Ty8xVHVia21JYll4U2F0RkJsNkZN?=
 =?utf-8?B?YmZobUVCUGU3TXQyanZ5Q0FRRzJNNldFWnJibVZhNys3ZG5RYUoxM1RPdVRD?=
 =?utf-8?B?L0xld2padWJabCtDQVBwMGxZR1BxelFOS2hlZ1d0NE9Nbi9WNktvR0NRNkxa?=
 =?utf-8?B?OVRlZVVJbTBtcDRYajdvbDNsRTJyelZva1J3RGlrVnlTM3BRM1VLdkJGUEtW?=
 =?utf-8?B?NUZIR3Jvb1NVUldqbXdHOEl4aDhYL3k2SzU5Tko2RWtpMlFhK2ZjOU5zSko0?=
 =?utf-8?B?SXF4a0VHdHJSOVJtY1dMM3dYeDRvaTdnVkVVNXFDckxpVUs0ZHcwN2NCekg1?=
 =?utf-8?B?UlRCNW5EUFFKUVQxeGIvUHY5QUJ4MzFJbkRXTDZWbXVWMjVoMmRDV3VWQjE2?=
 =?utf-8?B?MUhtMnc4cWk1T2JjY0RnTGltV1hnS3Zid1F2RGFQUnFJNkV1T2tXTXlic3lw?=
 =?utf-8?B?YjZUTkk0clZjaWpzSi9MS0Q2Q1huRTloVkxrNDVlN29iM2hiOXBtWTJ6eW10?=
 =?utf-8?B?WU4vLzVFbG5RKzhUZi9CN0F3MHZUTy95d1hTbGZZTTBCODN0L0dCdFhWNktV?=
 =?utf-8?B?WkZUaXYxS2VpUld5V0RPRVNrelhuSzJDZkpBdGhZT2VWekF2RnlpTWtGVktt?=
 =?utf-8?B?NzdCdEF1bG5HWVJtUlIwaDFqY1M0QlJtQ1JYcEpPQXdDcFp5d29MTTlZVHpp?=
 =?utf-8?B?M2NHWC9XVjdIWTZKSHc5dy8vdFRQWENscXMxN3Q0SnF4eWREOVloYiswK0dF?=
 =?utf-8?B?QkVQSS9udDRHenRNTTF3TDd0dzk1VGNCak9MNUg3MzhPWGZQaEJhc3lYQUZn?=
 =?utf-8?B?djRkSmZZYkNnVXBRT255M3ZwZFlrVzRTQUpHdVA2ZVljNVpnbEJseE1WU0dq?=
 =?utf-8?B?TzVwa1JFdXo5dytxeHVTdnhHMVZLaVN0cE5FOTFDNnBRZGF5d2hjWnNLeTBF?=
 =?utf-8?B?SWFuVkRFS1c0ZW4vVkZJcmErOWhZOWVlWGFqdkI1aWZMTmk5L2ZUbEtzbXRx?=
 =?utf-8?B?SjNoT1M5WVdJU25pSCtlUEhhL0ZueXVtU0dnR01WTXB3R3kxK0RxMnByVm1k?=
 =?utf-8?B?M24zNTdQTjNBSHhhaVZLVkk0MG9Ua0NFTVhtVmFlemVvUmFNbmhUSDZlcFMr?=
 =?utf-8?B?NCtSQitvM013NHJpQUloeHNLWXZtMkR6Y1BkS1JZWEJLN1Bqek8wckFDOERq?=
 =?utf-8?B?YnVhMzJBaVhIRUl5WXpUTlc0M2JWZDZHcmdhRzh5bkhxRHl2YlBnZWhreE5F?=
 =?utf-8?B?K3FqSEdvZkVmWlVsQmFHYkRSVzlCYkltd01WejBlaDRIUE5kbjdpUkZEaStL?=
 =?utf-8?B?R1FheEJPNFM1UTZXNkZDTXY5bjhaSnlWamNjRzRoMXBRME9zQTNNY3BLdXp1?=
 =?utf-8?B?TllQRjZHSGUvOUpkYlhVbTc1OVgwdENpSjNWYU5Sb2lGZmJHb2g4RnNuUlp1?=
 =?utf-8?B?ZnlGYUhVWWQ0MHhrQUo5aUlOT0dwbVAwRGN5ZjJaSXBsVjZUNklDb2pFU1pW?=
 =?utf-8?B?YkEydG5BZEhqcGlHUWEvNkR0SGRiR1lVL3lORmR2ZlRhR2VlbjA2YVhzbzRv?=
 =?utf-8?B?dmZqZXFmeXgxM3FZVmpIV092b25jNUFMazlCdHNJNlZNYXNqck9SNzIxbHFy?=
 =?utf-8?Q?d1yX7vx+P2yNJgsKJgjWad0ia?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10e6bcf-1603-4251-75c5-08de2723f5f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:27:33.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUCQjfw6WTigYRJPE2qvKn6ScxjpabcesTebHWSBDE3Z+nLCtP0VDov1eqVX3TB50krRi9sKqsO0qKGvvyVNog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750

On 11/18/25 5:03 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
>> diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
>> new file mode 100644
>> index 000000000000..bd7a194a9959
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_net_ff.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> + *
>> + * Header file for virtio_net flow filters
>> + */
>> +#ifndef _LINUX_VIRTIO_NET_FF_H
>> +#define _LINUX_VIRTIO_NET_FF_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/kernel.h>
> 
> 
> I do not get why you are pulling linux/kernel.h here.
> 
> include/uapi/linux/virtio_pci.h does it too,
> and I think it's also a bug.
> 
> No other uapi header does this, it happens not to break userspace
> because userspace puts a completely unrelated header at
> the same path - uapi/linux/kernel.h .
> 

Removed it. Previously I had added the FF definitions to virtio_pci.h, I
guess I kept that include when I split this out.

