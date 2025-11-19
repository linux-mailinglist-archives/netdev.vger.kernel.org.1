Return-Path: <netdev+bounces-240094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F211EC706D5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC134E63E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A530BBA9;
	Wed, 19 Nov 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCJddXoy"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EF30BB8E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572502; cv=fail; b=os6x9G6CT6iclfmYN8RGqXliqWXbw4Rp016t+0H2KVJ/Thdzz/b4cCGMH2N/E3Y7RaOrGla3ZGNsaHf6joIG3IGoTl0hfkdFfh9iwiLkCDI1Z7ABK+itMGuj4OpeU8NUB8Al8I8mRgYIw3yxqRn3toKusz8/tLiLnxyfORdTLr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572502; c=relaxed/simple;
	bh=mlK0vGJ+/HL4NTnFpQiru0Q3hstVLSY1/YAqbMrDWpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBOjUF51duS51Z9LUmbQK4UpIKYQhqw1qEbqT7mg0daEigvDaQIuP5NGL1ojXINDOLwvO8bdEcBOCNlS1Vwst7eCDu09H9oUSkN94WU3LssRQDQqMwZUSTW4C3p1mYpmxQ6NHl1JC2KM0PBjsSZFHFx8IDgrLSXoDQSP4yV5kIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCJddXoy; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RETaL8zWfxIq7wG7LU8C3+BhCZ3KU0EEUDXKIQOFCncfLHGOFcaEIXiPpU0CTYPfJEuvEtxXplZ6qnSweKMFdB86I8NxSHmN5WFFvM8O3ooWFXXYAts482w5WUOJtLHtKNQYAuIGmpOcDHqGQ5YzVESgtME/uTiI47hgEkpt5W5Ch1G90kCb58NYTaVJ3XUhYqBLKV5tKMl1RhZh2BYD+tsdR19XKf8BDZ/RFhhY104zbAw5JwrkJDFpTbIhk2NZJo1MvNLpMyHuNijTHNjDDCowuD9yqwhmKZVODpybyRyAkGCddRL4MYwf8kEzWBlMlMQgatB3dkQrah6pmWLbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8+6azODKS1aurzvq+v28l6LoJ8CPh/0K+tznlmNrok=;
 b=sZYf/4wwyKLSmZsghR5w8RCVd3R9dUhyNQkZL9n3JKAhGBozjkFNzp+GL4U4taES8gmswi6BPBzZe6Bfh7fIkO0K5gIyetsBDE9LSUCAOxO5PlU6vPTHLCh51MI3i35ho0vVCzpISFAmt655bCruIPrXWQAX6C/CfjFh8SiHQhzRHMIYyFIKgZJRe6kpSmKv53TT2P87+zfqdZQO6n1ii9y91TJA27gKQqGi964itYOzypgQwQnf5rm18WLX5wfhOB8n1OXhIqoHfdY21Tjh2zn7XA61Zl1oRIaEavRGSrUDbBCGxiY8km3ql7eNXuVBskDyicwVh1loIweO/IimMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8+6azODKS1aurzvq+v28l6LoJ8CPh/0K+tznlmNrok=;
 b=HCJddXoyp0HvE9jKsjgNr9f2ciPc+SC7TPAv1YrcK9Bp1wHE7N+b0Hi/vW5ok5tbGUnG49PBoGLJPPZt6morbtvpdOSI870tfUytNk3Ob0I5hdXqJvaXo+u3az7YYafZkJ1xqkT6XMW6HNU3m9EKiM0e/TOo+YEIkgoeYew5k2UtagREuBYWKTd+4Qa2OSAHBd72dh6ZT4A6U0ASZmHQ+okn7XCIjRcKzmvTMTXZyKx5FvYfcrrDWDB8tvS85Zo/XnJ2BNKd39IHVTcPXwcQm1/bSrej0fNuBTmqh9DRgQAscKUF/ijj0bquPxRpK2dt9nVF8B0n9xXL30q8EZbhVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:14:57 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:14:57 +0000
Message-ID: <a81f3384-2a64-4ebd-b563-76d2d5237df3@nvidia.com>
Date: Wed, 19 Nov 2025 11:14:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 06/12] virtio_net: Create a FF group for
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-7-danielj@nvidia.com>
 <20251119043412-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119043412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:806:127::19) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 853cff2f-f8ef-4167-ea2d-08de278f2a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzBWaGlYQ3F4SXl6MEo4TStUVW1PeC83aWZYaml2eXZSOHlxZ0RMbU1kS2pW?=
 =?utf-8?B?UDZ1QVAxdmZhUmZkajVRNGs2cWlGZjFlYU1jYSs4alVvK1UxV25JaHlIdHVG?=
 =?utf-8?B?YW5lT01BY3UvWVgvWGFoRFAxSUlMUlF4bldJdFBCRFZySWY1WmZHTWlRQjVY?=
 =?utf-8?B?NUFka2JnRjhmSnNUa3ZjL2s4MWZaZVhzcVd0VmswM3JEUnhEeGZuTVVKVnAy?=
 =?utf-8?B?blpCS3NVeWR6UEo3ZUQ0am0vdlRmSEFBTzd1eW9TSVY1a1JXK0lCSW1aZm4y?=
 =?utf-8?B?U0IraEcvTmtlK0JYTkc1K080UG14M01rYTNETVB4Yk0rWG8wdENpQlVYM0hS?=
 =?utf-8?B?KzNJeXd3bm1NbjBqbER6VXIwZU1SUEdQTTJFLzgxNTNuZlBEQXJWL3gvS2c5?=
 =?utf-8?B?VmdSZmdJdTNyOEdTdWtEcGxyWTJDaitwM0lWSzZjV3RMTHNOemEzVkl0UnpE?=
 =?utf-8?B?WDVnSnF5RXNvaXhORTFEeTc4Z3B6a0FmL09lelFGSWdsVzNUS2lqMzNkbEV0?=
 =?utf-8?B?SVBWL0pEdUpISHN3WW05MGtZSTV5azNwdDBlVHBRa0o2ODEvSUswcE95OGlO?=
 =?utf-8?B?eE9UQ3FqcERWYVJHRGVuSzE3L1p1dEJTMVBzZVlHZzlId0htN2Y1NHN2b2tD?=
 =?utf-8?B?NjJPL3ExSFZqSjIwOXRhYzBWS0VyWmg3V0xKT3NmaGpFaG5mdTd4R2ZNZTZQ?=
 =?utf-8?B?eUc3STJkN0JGeHRQcElUQzJKdXdNOTN3T1J5K0trbUNPUHgxd0dydG5peWU2?=
 =?utf-8?B?STRmMTlYbUdJRUJuYVJCWVpkY3N4TWQ0a3JjbHNEVFR4M0cxUjc5STh1OGd1?=
 =?utf-8?B?aHNmbm5tTVlTRldFTnZudGFha3p1TDhrUmpZNnN1RC9BSHUwaVMyVEdWa0Vk?=
 =?utf-8?B?RE5tVCsvMi91UnRCYjh0TnNBQjVDSWE1MXM5eDNhcm85RGVnUFV4R1ZqME9v?=
 =?utf-8?B?SkRyN2NrSEE2YlE3UVA5MnkvL1hERkRTZThFSThadHR4Y3hpYml4VzVCZHRD?=
 =?utf-8?B?enI4MXRpODRYN0pkVG9DendtS0dyVzlhalNlKzNXeVZwbS82SzRWZGdJOHBx?=
 =?utf-8?B?Q2RDUE9IelkwTWNNSlNwdXlVVDFudExnT0tyQ0FYSm5KMWkrb1VRMUZ3OWlm?=
 =?utf-8?B?OW5xdWhqWEZScVJvZ3ZHaHN6ekl1K2lEaklLL3VjSkFtOHVqQnZDVTVVU0Z4?=
 =?utf-8?B?aEZobWVVbnRzTnIyejMvV1J1VkxxVlp2N0lEQWVLRUVaZUQvRExqczZscGN0?=
 =?utf-8?B?c0Nhc2NCV3lQOTQ2VzErbmp1S2Rmd2tqYUdtNVRpcXZsRUl2YTF3d1N0ZkN4?=
 =?utf-8?B?cXJsZStoTzJ4bUhsM1MzcWg5NlVuT3BSQUdrMHIxNGFkWktyTUwrNHpzSHRa?=
 =?utf-8?B?SWIvTEVsb0ZHanVQNThkR1B2aXhyUklEYWtQbTdWYTlOdE9PTFlqd2tUVGRC?=
 =?utf-8?B?cUpPbnRsOXRzYXU3SWxIRjBibzJIVVJFeStpRysycjFKd3BWZW14Y1ZFcHNO?=
 =?utf-8?B?QW94RmhsdEFwckN6VjY3SjFwbFViSUNIQ2lEaGUyQ2tyeG1mMWM0UFJiRmRy?=
 =?utf-8?B?MzhDMkVCOVFvNlN6NmRiZVVSUmZZbktwcFEvVS9EbDMxRm9yMC9aNDd5N05a?=
 =?utf-8?B?QUFudi9SZ2dFT1NSbWdRTzVvaU8xbXFwYnpWUWVLbHA1NFNxNERXTjNQMnRZ?=
 =?utf-8?B?a25GS0F6bTV4QzdMV1NsZWpLczdLeW42RzY5VnppM2NBVFJSZDhoaUs5U2dx?=
 =?utf-8?B?aTFKWDBtek5rQWNzU3RRYUszd2ozUDVqdUJWREgyTm8rSnBkRHlXQ0xSUndR?=
 =?utf-8?B?STB4SnhubXlHU09Fczl5Z1FMb2k1V0JqQUFpZkUxWUNwUFp0cldkZW1TWFlV?=
 =?utf-8?B?UU40QmlUcEFTNTJiWSs5OEJmMUovUzZrTUFjcStwWVQwRkRIdzBOQUs4TnJa?=
 =?utf-8?Q?Qo1uWFfIKJ+Et8Evy7RBfalMuP7HwcfZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JRL2I2aXlrU2dsWjg0RkpCY2NtZmw4OHFyeWdReXFpOTEyUnp6Zk5kK3A2?=
 =?utf-8?B?QUxrWERBYnd5MVBLdm5ZcW1yQnljaFd1TGNONkI1TC8xdUNsL0dxSnlNbnZQ?=
 =?utf-8?B?RHZpWVp1NWFrUW9BZG12MHdGT2hwS1NjdUQ0aVN2RWJIV3k1QmN2NVlHS1BM?=
 =?utf-8?B?RVhjV05wa2RLNTJYTTlkd3QwUnFqYXFiYUtlWk5TWUFqekY3YVcwSEVITlIv?=
 =?utf-8?B?aWNaaWlRdnEvdCtDeG8ydXpYMmVsenJuWUV1SHNtWlRZV3RaWXB5Smk3Lzd4?=
 =?utf-8?B?NWhQbXlzeENKeXdsMThaV3I4aUQ0SGQ4RlNpeGxER1Rtb2syMXpEcDkxelVY?=
 =?utf-8?B?ejNlNk9rTjFkWDhiZ1NEQTlFb3JmQmVaQVBYL1VNZGVnY2R2SjF4dWJySW1W?=
 =?utf-8?B?ZW1qUFJMamlWd2Q4SG1LbHFyVHZ4WG5hdnIwTjhPZ3dxajI2L09ZOVhqSkxR?=
 =?utf-8?B?ekhOWmZWWjFLM3NZYjVlQUo0MjJIZ3JQM3FrL2pmVGRuVWFOcmpmcEV5dzUw?=
 =?utf-8?B?STZQWkxkbnFCajB3Z0lBWHdCQm5MUUtDUEVNUlJzTXJjYy83eVZnbzk5NGQ0?=
 =?utf-8?B?amxoeXJpaGxsbk05dEpVdmM4bWdPVmZtTUZneHJYd0dudnhHTzQxcmxiWUUv?=
 =?utf-8?B?UVlxVUx4Z2VlTm1ZQlEwU1FGOC9jQjhxK3hxdVY1QkRNVFhVTGpVdUVDbWZm?=
 =?utf-8?B?bElrTGlQd3ltMFg0NlZKdTJSYWhFcmlQNWtYejEvUUszdEM1eWlGNXErT3Zz?=
 =?utf-8?B?dHhJd3Nwa091MDAwN3hjQ1VKN3prZUlKbTVsU1FEVzAzR0hOTGxJM2ZRam9M?=
 =?utf-8?B?MFBKajFXWWF6Yk5tcEtLVWtRM0x6Z2htaG1ySHlidGhjeHpzV0dGWmZlblN0?=
 =?utf-8?B?ZElnY2Jjb3J3d1JzSU5GaVRLMjJ2NjJVbHEwYVlYdW40RlhleDZTd3k0N2I1?=
 =?utf-8?B?Z3N1RnZJTy9uQWlHb2dXODk3ZFZzUkVFcDFKamNKZ0diRWxyVFFMT3dYYTlZ?=
 =?utf-8?B?OWp5a1ZLenhMbGVpY201dy9kSytySTdLb0FDdExYSGtXWUlndFJzRlF3b0VW?=
 =?utf-8?B?VjJ2UCtMaGJVcmJuejRCcnhnK0t1RWp3bVMzQnRvNzExdy9KVmo5YVgzVFhv?=
 =?utf-8?B?aVp6Ull5Z0FVeXJKWktSUDFDQkh1OGZpTHRrMWhQT1ZrOStUVXF2NG1RTHY3?=
 =?utf-8?B?L2RtOVkyTHE3UVdYTHh3bDdPVkx1NXdtK0lrWWVkcGZkbW5YVERwVVpWa09S?=
 =?utf-8?B?dktpanE0K3l4SEEyTWRhR0pwVjZLS3paTFdrSk9DYzlmUnFwTGxWMWxtTjlH?=
 =?utf-8?B?WGhKb1QrdEJaNlZFRno1MXJyWWtLMVNrNGNLbWt3M2EzeWQxeTR2czcrS0dw?=
 =?utf-8?B?aDFIY3cxeUhnZWF0SVJVTHlZRFFXS0VRWEs1d2J0aDlwc05oMEZ6SFVlS3U0?=
 =?utf-8?B?UTZkN0FNME02UTJRNTFhYTFBUnoxNUp6OGxLMHYrKzhWZ0pCMWxBTENoZ3Nm?=
 =?utf-8?B?QXA1SFFTS1R3R0NUWG5odTlReGhPQmJWR0ViZU54THVkZ2hqSTQ0cFJQZFNC?=
 =?utf-8?B?OVB6WXRyRlBudWpGb1cwV3ZGbFpBU3hBZWdrRnFOSGh3YWI0UnRSN3Q1S1Fm?=
 =?utf-8?B?Njg1Y21aWDk1SW5YRG1VdVZtd21SUWMrUU9ESXdibkZteUdNYzEvYVcvYXJJ?=
 =?utf-8?B?cDhUdWxBWERIQXZ4S2IwQ0FSTFQ0NTlLSU5TdmhmSUlsKzU2YkptVkZmcnJ4?=
 =?utf-8?B?MnVwUjZUU2QxOVNUOE95d1RCY3R2aEJJYTdpREpqTkxZR3JvZHRCckl6Yy9t?=
 =?utf-8?B?dXRkMU4wcHdRRHF3YmxQYXpLS3MvRTE0UU92Q3RmbUY0RlZkVjZZc1YzamxC?=
 =?utf-8?B?bE9tRXVTN0tDWDAyUDBjZEp3QWpMWWlvVU5ycG5uaU9weWorMnZYMTZYb1Jh?=
 =?utf-8?B?Z3g2VkFCaTQ2Mm9yWThvbjVRQjBGdDJuRnp6cUFUZSt3ampxenlTQUZHTWwr?=
 =?utf-8?B?OFVibEtZWWNDMVNuNXlVTkY2cVhGWTd6V2M2cWViSmh5R2VYdkRhSjZ0bkE4?=
 =?utf-8?B?dCtaWVIvWkljaWE1ZVgzL1BZSVJCUUQ1NEltOVlzQVFmUEdla2RSSFdUVU1n?=
 =?utf-8?Q?P4kja11jXAEqzZZJQjK3CDuRv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853cff2f-f8ef-4167-ea2d-08de278f2a00
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:14:57.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1Dm5pd5mhT0rPr2PbCXynnt3CAeyB+N9jFzx1L2BnsAfyow3wXNi7lzSQIobFhVE0bjY+c5e0fplAKD3wv7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

On 11/19/25 3:36 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:56AM -0600, Daniel Jurgens wrote:
>> +
>>  	ff->vdev = vdev;
>>  	ff->ff_supported = true;
>>  
> 
> So this is set here and never cleared.
> 
> But we never recreate the group on restore (after suspend).
> 
> sounds like we need virtnet_ff_cleanup/virtnet_ff_init on the
> suspend/restore path?

Yes, you're right.




