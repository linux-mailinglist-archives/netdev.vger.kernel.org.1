Return-Path: <netdev+bounces-240073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63EC7025F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BD1534B7F2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441136CDF1;
	Wed, 19 Nov 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fF4lI0lY"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0997636C0CE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569485; cv=fail; b=lfi7dApntXXsGSlktp7cf8rAH4K+3eQ0fbiLyXJE5Umjj2VgtTzcNAZUrZ4+pQsdC9qKEQweVYfpaVCq6ydoDSdB94Ej4FvUVEdsV4dXhDSZUOhwYkwpdUKXCjuFHGq0qI7hWW5A4JLcBSfzmL9MgJDapzjIbU9AQ1eAO1yFZAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569485; c=relaxed/simple;
	bh=eKvtHHvMu3RAh2Q9RPZsD5tJy709tsCpPZwApQw8LBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ayro63ww/Pam3aKf7/9rtD8v/ABzGLOVAszXbZL9JM1hRHI6fRMYS5Vz99HChDCd3nTK3XdRtzynY1QhHsgeEfwrUVI5nvHYWdTq2D/WbWGLlMcYcCjVtaALPZBWgiEtl0AbC9WEadKQcGznan0xmC8T72q1oZ6V5/fCPajarpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fF4lI0lY; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOX5mmia5PLB3F5BpRQbdjBKJPB2Yi1KQITcAO6+5qsS89sHBColqJSQqxQKqYT24uCfkeMFjCvFSKkSbLJDyDjxzItCDuzsWHi2j5YwRulAKknJtn3ULCHC4c0oK+4IXpwoSI/s+XF6PP9tll92vGtzQbHaugctAsuw6xsLB89+svlll5uIEM4bvXbWXEMMqB+OfAE+X04pPMsFtW4dUCwC8RtpqKZJvgwdUMIZxf/gTTjxDBmzeBNoX+8aWuptHmzh5wrYCzazHUhIWhv5zN2ISZGCs4rCEmfnwQAWijrPKkREFGSRpYrJfibXBHoos9gf45RIrtdhkXNgrXDukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KuF2er85dpOMDacKJfsMS1XZr9r140lmUDXv4tdEAs=;
 b=bsk1oW4XgaYt1wOzuSbPasFdaNVYWVEQw4bQKE44QDFWa+Yhw1VKm3/3dACDFTlQPv6gd+VvNq/Nb5GfiKIzvJ1FFc7mucF8Ffw4Ow0niZD+TUo963VjsFxuiz1MRWvzECKMsQTAiY1jM1LRu4J/8khXo6fIjQ4v3R1s1KCzPxKbbI8y30z8F2NjHnjhlTYcnXyHPNHuoOxlWVX3qo4uxFLD3bYFG+gMsZJDYO5Qp8oxJnnW7Ld2OANi+vksRj8jsHhjONTXFCiKJchFmi5rWVGvHn0EhC3Vpd2Xq9Afo4Cf4AOl54F9tNYnVBzATBloZDc6SQMg5g9slYJ6hLGomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KuF2er85dpOMDacKJfsMS1XZr9r140lmUDXv4tdEAs=;
 b=fF4lI0lYUrClqeOR+aO2M4qDkyCHtEjzCipqALAnZqgIuoCQmIHZcU+q0LCIiTE9b/55FhB6beqEScQxlJyB3rWpHy0qReO+7j7rs2GST8etxoPrHNcahvqGDp3Upyu9jpWY98yIXYivefdEtRxOZFkRqT31Z9FKZSHSzl2zNiRZx+rk/7GbIdOSUwgSBsy8ErWMZQ46S4Ig8rNI8xSkY0fbEd5IXXd7ski18h6d3xhQABoT0U702KvHEniRZc0YYU+KKsFMynxgHOYHMUf07bEnGF3leDYlS8EkMkniZnfPKQuEgct5NaVPoh5Y3xakzfc8i/aE4iMBeHSWY5NiPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:24:36 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:24:36 +0000
Message-ID: <5df616a8-5f0a-4349-9cfd-3edc5c152e2f@nvidia.com>
Date: Wed, 19 Nov 2025 10:24:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 12/12] virtio_net: Add get ethtool flow rules
 ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-13-danielj@nvidia.com>
 <20251118134544-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118134544-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:805:f2::44) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 028af564-4884-48d3-4635-08de27882128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkdlaDJ6WFJVZ1R5N2pyYTRwdUJtMTlqQm83SEpYem5tcEZabDBTYnUyMTVB?=
 =?utf-8?B?UldhTXRBTGRpSjdhNi9BUWJ0cVpORlMwNzNzQVk3VUFtREc3NHVUUVNjc0ZC?=
 =?utf-8?B?WllzL1FoNnI4eTlvRlgrZFNVNnEyT0NrekZrY0FkWTUraWpqbC9UK0hXUDcy?=
 =?utf-8?B?dkxoRXB3UityVnQwRFFHVktPT0xvanlrMjBSMHRNSiszU1EvcnYwN2xMWnJr?=
 =?utf-8?B?RWRIZlA5WDJXMEJPWlRJL1lBTUVGSjJBTUE3YkFPckV4a0F6Qm9VMmFqWlZn?=
 =?utf-8?B?bi9hcVNycHpWM3VsT2ZEODVCTDVCeitkeDNHUzZWVHdGUEZKM3lYZTlVM0FF?=
 =?utf-8?B?cTlUYjhTOHRlbkFSTk9kZlZacitWSktqTzRtN3FLL2pRWnFrSDduOU9PZUoy?=
 =?utf-8?B?eTNvOFB1cTFNNE1IaHFGazhUam9laWFDU2l5RS85ZGRHRSttTmh6NHNneVps?=
 =?utf-8?B?YXJVWENjZlJKSE5QRExzNG5hOFl5UEo1QlBTUjMrQmx3MkdRRTVZWmgyT3Nw?=
 =?utf-8?B?QzVRL1RnUjZybzg0MGJBMlZ3SVF3QUU5MnNYcXFXNVB0bXFEbWRCaWxIT3g0?=
 =?utf-8?B?SEh2UzRMVXR6N1BZUHNoUFBtU0ZiN1BLaUNxRUhZSjRyQjl5ODVmLzZaempu?=
 =?utf-8?B?NnhnSGZCUkNERng2dU80M0JtNllYTnJlMmlCRjdHNzRJbHM4WkhmWkZ6V0xa?=
 =?utf-8?B?K3ZIRkxKc2oyNlRRQklJZlB6cSt1enV3ck1iVHA5MTkwTW1CODFURTdKRjVn?=
 =?utf-8?B?WTA1TGVSZTVJclpCSTdkWldHS2NrekRkODBjQ2lJbmVaYjlOQjNHeXJlYlZa?=
 =?utf-8?B?MW5hNEtOR2lFbnR6Qms1ODdvSXZrSENjU2JiNG80R2M3VXBPRG1XZWNGbmR4?=
 =?utf-8?B?ZlFOUlJJaHFPblZWQXkvcW5LRG0xYUZXU2xwb2I5ZENBSDdtMmR6b2kwOXBJ?=
 =?utf-8?B?VURucHRVTHA4WEhQa1pabzY3UnJFTjh6WjBGRFZXdGd1MzN6dDhWb3FscjRL?=
 =?utf-8?B?ZUY2TlJ3eUtvdzVPUTZyT2dYZk54b3RoR096TVNDNEZLOEJXOUVlL2ROd1ZS?=
 =?utf-8?B?aE5YYWVjanFnY1ozL0JkMHgvL0pRZnpEWi9jc3FlNHQyL3QyK3lsdGFtejRt?=
 =?utf-8?B?MFIyODdteWJKTFNxeUdpUFVhZUxWejVyK0loMUNKVHNxTEYzZ0ZGZXZZR0p5?=
 =?utf-8?B?bGZOd2lJOTJ2ZzF5OHJrWWRTNVdWSmZVYkdDS2Y3SC9KK1VTcTg5dlRtVFVm?=
 =?utf-8?B?UlVVbGF3aDhyRCtVcDNjN3VkdG4xZUluSHVyWUZyR1JHTUtjNHFtbG1kUzVk?=
 =?utf-8?B?RWc3aythWFlhS1JrOGtSVmVrQ2o2SFNYeGF1WGI1T08wRjN0OVNqbkdJbi9p?=
 =?utf-8?B?dzgzRFI2eEppclpCRUZiVWpRQXNidnh6UEhVNUhCWm9MY1VaZnl0eWdxcVRs?=
 =?utf-8?B?QVpGWnpiKzJxMVc2QmJiNzNoYVdpV2ZqV215TElLM2ZEaFdrY2NuK1V1aklt?=
 =?utf-8?B?T2lNZHJuZHFPSjA5UWhRRWdkZkVENk42RUNmUG9XcXRkK1RkTFAxY0IveE90?=
 =?utf-8?B?czd2QWVrSUE4b1grNXoyeGNTdmVMSmpKUHV1L1UzZ0lZZjJJVVVvZ3JWbm5s?=
 =?utf-8?B?a1RHdHdnalQ5NHVoeUhreWV6UlVzYlc1ekZ3R2hkKytjeHB4WFlEMmVEVHJD?=
 =?utf-8?B?eHRVTE1FU0daOEdoRGlQMFJnZHdSSElWY0orZk0yMXpmYU5uNkU1N1dsNG41?=
 =?utf-8?B?MmlqNmlQejhBZUx2M1o3ZXZGNHFiLzBzMlcwdDI0Q0tEMm9CWThEWEpTakh1?=
 =?utf-8?B?QUtZNTFwbUM5KzNzcWhaMkt5UEJYeHNGYUx4Z054UkEyTjgvcld6OW9zMi91?=
 =?utf-8?B?c3NSZW5MY2JyUUN4SWRmNkFWZGVIamNlWlpGT0tVR1N1UlUwRENLMEU3OE5W?=
 =?utf-8?Q?cxXW8VQsfJF087V3+Tbz5DGmYZ76UqI+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1UydzAwelh1M2FZbzgyYWZHZWpqbkZ1SHZDT0t2UXY0YTJINjN1UEZEMkcz?=
 =?utf-8?B?dWw2V2YyN2Z3VGpPeGdVaWk0QTFsSWVvS0VmQ0VjRVM2RDJDQTVhekNmQTJZ?=
 =?utf-8?B?M0NJdHlsNkE5ZXZiRmdzdDgvT3hxdE1qMWttd29jUWthOE1hYnRYdmcrb2dG?=
 =?utf-8?B?cS9jYmRneXNQd3NWK0lib0NDbURTTVhCQis3WHluV2plK2N4Z1JzRHhjVWh4?=
 =?utf-8?B?ZGRGMGRzcHk1c3hYRW4wYWZJRjFnb3U3L1hGLzJDRnZMWFRyZldDVWFaVllZ?=
 =?utf-8?B?TzRVVlk0Y1YrZ1dEaXpEelF4UTNMdkxwaTQ4aGI5YzljSUV0S1J3T1U1YVBj?=
 =?utf-8?B?aVJKRElPOGZGYlppbEdDSFRJZUpEMXVtNmkrVzhOZnZHZkVDSGNlUHRaa0Zn?=
 =?utf-8?B?dGhEWkxvOWdQeXlNUnBNZ2I4M2c5RHFiSHN1RkJlWkpHT0ZBWEhCVXZsL1hh?=
 =?utf-8?B?VUlZL01aREVVMXc3TVNKWG10aldmUzZTRmt1b200WGMzYkVaRWovcyt0a3lw?=
 =?utf-8?B?b1ppam0xSHBqZkV0WGN1R2k4YmlrNDBmLzBBd2RrOUR2Q3k0amJsaHNPZVVk?=
 =?utf-8?B?MG5URjJOMVltMVJXZTNUWERjcVhvOWRPK0htZHZCczVtVFRpWkszOUdSMzJO?=
 =?utf-8?B?YkxxWDZ4NjQxRlcwR2NuUG5BWFRjVm9URWRHcXpZOWhUbjBQcTZldzFYNnBM?=
 =?utf-8?B?cVhUbUloekhxS1RMUUYyYlNsQzZvcHVoc0ZQTXFYZG9DSlBVRXpNUU01WnE5?=
 =?utf-8?B?ZXlSZnBjWTI5ZG1DaUlUK2x5cnFMcXZBazE4amxpbjlNaTR5dzBSL2hrR2J0?=
 =?utf-8?B?N1FOU2VHS3FraExJcGtxTFZYZ3ZKKy9FbjhLMW9hWU9NaXhxRHJpVytVbU1a?=
 =?utf-8?B?bktnVkg2RUpXTDJqdklwemFvNXFTTWRORkFZUGhZNHBjbDBDOFpvaHcwdURU?=
 =?utf-8?B?R3VpZzVYSmV4VGNEdE13SUZUTi8zT2pKYzQvTlVmZHR2WVNBZWdFbkdXSFNv?=
 =?utf-8?B?K0RSS0pYQ3VsVUp1MmU4Q2gxejh1L05jRWgvcTlQakJhY3VVaDVGQnA2VVp6?=
 =?utf-8?B?dllXSU5wTDNrQVA0Uzk2NkxlV2ZUaTV5Qkt0M1Z2cEVUQng2YXQ3OHF4MGxm?=
 =?utf-8?B?dmZBakRHN1ZyNFVHWVpUK1YxdXhRTW5JQUtpeXROMC9WNWFTNFF2MTRnSytv?=
 =?utf-8?B?U2lhUFh6L0ZNOTI0RTZrSi9jWGVMSGlhRlFzM3VuMjlFRUg2Rzh0WW5WRkhZ?=
 =?utf-8?B?THZYekZuTE5GZGZZdW1PU0JvSkdEMERHRVpjdEV1cnZMdnVwQjR5bjlrU3d4?=
 =?utf-8?B?b3UyTmp1QVJ5V2hnTWpBNHpNSDM2ckZicXNGNDlxT2taWi9iZ2tPV080aXJx?=
 =?utf-8?B?Y1lWTVpGVm9kaFVzcFE0RlQwODhxTlFCdjg3UWozU2FzVHFRem5ueVFSdUdH?=
 =?utf-8?B?dG5DUldFbmFLVFdWUFBBSnByLzNRZjZtam9WRVpmaCtBb2xISmFOTmxQS3Nv?=
 =?utf-8?B?ZytmbEdYZ1MydFZwTk1WQTl3MVlVRWNCbVRxZVB3V1dhK3BVQXpjVDNzbjVM?=
 =?utf-8?B?V2YxWTllUC9iem1vVlExSTA0VHZBZTcvMlpxUjZUYURsaHZqRlJLMlJiK0Vm?=
 =?utf-8?B?VXpNbkIvd1JranZNeUJURE1GbDJjVnBxZXNsUzlUakZLU0EwYnhpSzI2b2xP?=
 =?utf-8?B?dzBISkRXWFF6aXhWWSszZ2VxbnBqazB2UFJFazRHL0E1Vno3TDNsU1JIUkVI?=
 =?utf-8?B?Q3BpcTE0dUt6bStjME5Yb3dvTE1CdVlIRDI2Y2g5aklRNXZhbnJhLzJRdkdP?=
 =?utf-8?B?Z0I0Uk1zWU4xM2tYV1EybE9NVzF0T0Y3Tk5kVytNNmk4NENDckZlMEoxTDMy?=
 =?utf-8?B?R3kwZDNrR0l0SzVDdnAxcFR4U0dHK3RPckVZUGhJaGExemp6V0xielJ0Y2Ry?=
 =?utf-8?B?UURkQVduZjlSVzV5M1IxZE9sS21JZllFcHZpb2VKcHIxbDZ5djRqclBjcVlk?=
 =?utf-8?B?UVpCSlM3UEZrcWx1eC9WNGtvaHZiNmdpWFVpcVRzMloxNWFQaUh6TU4xU2Fz?=
 =?utf-8?B?WXgybkF5VUNsTUpZUXBlRG1KYloxMG85bVQ2bnhFU1Bmc3UzbUJYYkUzUlZH?=
 =?utf-8?Q?1GqA5i1szvd3tMu5YkswWWrjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028af564-4884-48d3-4635-08de27882128
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:24:36.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbiHGy71JnJso49qznMw9JMg4nZWtJLDzOpDGSWO/S5DuVv62wpsNLeuKxuQ37dBbj+GcXllKwFH/xd00xmnrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

On 11/18/25 12:49 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:39:02AM -0600, Daniel Jurgens wrote:

>> +static int
>> +virtnet_ethtool_get_all_flows(struct virtnet_ff *ff,
>> +			      struct ethtool_rxnfc *info, u32 *rule_locs)
>> +{
>> +	struct virtnet_ethtool_rule *eth_rule;
>> +	unsigned long i = 0;
>> +	int idx = 0;
>> +
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	xa_for_each(&ff->ethtool.rules, i, eth_rule)
>> +		rule_locs[idx++] = i;
>> +
>> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit);
>> +
>> +	return 0;
>> +}
> 
> So I see
> 
> 
>  * For %ETHTOOL_GRXCLSRLALL, @rule_cnt specifies the array size of the
>  * user buffer for @rule_locs on entry.  On return, @data is the size
>  * of the rule table, @rule_cnt is the number of defined rules, and
>  * @rule_locs contains the locations of the defined rules.  Drivers
>  * must use the second parameter to get_rxnfc() instead of @rule_locs.
>  *
> 
> 
> Should this set @rule_cnt?
> 

Some drivers do, and others don't. I'll take the most conservative
approach and use it a limit, then set it at the end.

Also left rc uninitialized at the start of virtnet_get_rxnfc per the
comment in a separate email.

