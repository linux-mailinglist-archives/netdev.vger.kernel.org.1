Return-Path: <netdev+bounces-226296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A35B9F18F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ADCA7B927F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEB2FD1A1;
	Thu, 25 Sep 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nyo6X36R"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79C2FC89C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802208; cv=fail; b=qloHwolJtLJxZHIAyq7d0Cy6izXxaOQ25mSpvJEW2mgUYNouw0hxYKACQWA7eO7YXSbwLf/87PLDTCgU60LMVGlJMW/dUc/EhU6ivtUuFxwYy10EK/66YlHxk38dQzgEbWHcow5DUXsLoo+vLgPUsbWE+T4aMpjkH44PQrTNa0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802208; c=relaxed/simple;
	bh=kjqK+l2pc+COBzbAXQP0nbt8vJwwU6CaWnSZ7nwVM9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzAAmSiIARCimXRdMuI5PX/pxkEkbE0n7gGG7db0Nt1bARMqMr/hQHXFQB9PZKuFOhm4Lh+LzoJ82oT3IVmSESERPxCv4Qb2aDJQbRqH/uys9wgP/W1hSf+YlJRqR3zivQfI0URV/2ggHLn54hRF78BTAuwZ/1DJOu1mNoLMNJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nyo6X36R; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY80sblVO44m+1NKoSYCbRqiPjS3uVDSowx21mPn/4I9Q6p1Cu0DDTSGbVpXM5rvL2IQGLIUO+4pMQ7amI5pT70T5/qzU0PEXin1rWsHfJDQXCtXo6uZAq58yLsZK1TxQE1TWw9fdzNl2gZ7DBcaZD6fzxBfhdM/7A9X2bEIGAy+4G8jqaWk9O7PHoFXv005V1w6YbgH1msWIskiCpqHv5ce1SvKXnHLVhdWOdx7fBDEH2qvryYFjD+P0jWweTlhiDDm+iK7x+DudKLXAzSYorn5SQl8cTyTfuynYBqgWqeYuzhoJEapevcwoejuhd+yP/fLB20t92aR6SbNPz1g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzkiDgqmsDT8FLN38V9vwYHMBqm3KhkggBu/wvuZkic=;
 b=sQTRHVvxEe0b/YpvFnjSAVcQg0ChuADEf/T4oYez6620mVWhocR1nA+pQieG8tAo/AP6r4sEBWaG43sIi+5Me59lD5MVobPRY7IssKzLBWhjKaSkfImdyPi6JbuL7jPk5YWFZfbUJM7gWCsWDxc3rBxYSb5b+Ixe31vtgaHi4SOpbUlDPVpXgXkQunzPVCFkm5kA9TNb/riXuooN8cyotMTTAsOJboYxNVID4vUw3ddZmC+fZfgK0BQ5ZXeBv0HPTfAZzYREac+h8yKTsLW+QT3IP6+ff1GUYGee7epldDnpzRDUD3rqmSD4M5usxuVDQqKJP2muJtYwzCdVDtUjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzkiDgqmsDT8FLN38V9vwYHMBqm3KhkggBu/wvuZkic=;
 b=Nyo6X36RnlsZzZHUETwyrVGVw/XcW+gnWSx8BFJYpqvHoKtfiMfOAGKMK8gzp4WNpu/8KWqGAqWnNmi9TuHV7vE3RxO7uK6C1j7z2oops5m0TW/japn1FrvCWGqynhDPv/ZkcyaqcxvTr/AiiXk0Kov/gH225730jJGgS74xITDNMMvXKc+QAjLtsRxPe2jmnrnDEm6+AR9fltb5cGFUUKQ5brR8byw6+/HL6RkwcDIl1JmBgQc5sICLHdrdSuYjZlNJHLvYT3ZUbnDPoljmRyH6f44aQa1iRTewUq9GOey/e+ORz16lS3DvpozsgCg3ZNTFoFedKvvOOQdnuwaaIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 12:10:04 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 12:10:03 +0000
Message-ID: <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
Date: Thu, 25 Sep 2025 17:39:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org, alex.williamson@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, shshitrit@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 Yishai Hadas <yishaih@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
 <20250925074814-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20250925074814-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: ce012ef4-6222-4979-171c-08ddfc2c7561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3RMMThaU1BqbDluaENrb1RnYjZ1TVdqZHl6M3JJdnltdDhqTmxqaEdTRWM0?=
 =?utf-8?B?R3ZBckRJaVR5UzdJMGEzQ01EeG5WaFZNalFFc09qdDNpT2orcUg0M3d6WHFX?=
 =?utf-8?B?UHoycFU1T3ljTzg3Wkt4dlArNU9RZkpJNVVYejFzU2hIUTNySStJWkpNKzVY?=
 =?utf-8?B?am5tV3ZXYUdZRUFGbVh4MTdMRm1XTE4wdDN0b2dWTDhuY3I1QWxZaDlveGNS?=
 =?utf-8?B?d0lEcEtOV2xGeHBGRzlYZFhPRkFEUG9KeHpZdTJxNlN1L1cvNWRwZDZxS25L?=
 =?utf-8?B?TmFLVTNLSFU0TnBjZEkvOXUwck0vQ1NSbUJqWDZNU0c2Um1iRU9wdDExRy9w?=
 =?utf-8?B?ZlZHSTFRSlFpZ0hGVzVSeWQ1M1lOUGdUcUs2dlFMT21ldDVGTjlpTWNtaWVq?=
 =?utf-8?B?NFFTVm5nTDliSm9zRDlZd0pVZnZMQ3dmMlMwalhEL1ZSS21XMnJBa3NPWkRy?=
 =?utf-8?B?OTlIc2hSQ0Q4U2IxQTlXRjlMMzlhc2tEWC83ZjlFdm16eEtFVlRPeFMwNW9U?=
 =?utf-8?B?eXlLdFZlb2ZxMWZHL1l5Zjd5QXBGdHNQY2xiTEhjM2s4TVFhOTF3dUtLRE1L?=
 =?utf-8?B?SVhieE0vbWpNQ1V1UWcxTXFRblhMTE43Tk81LzVFaWlUbEZkUmNhY2ZHZTVN?=
 =?utf-8?B?TFFTSGZadXM3TkRrS3AyWWNIVTl6SzliQUlmdWNkeXFHL0tvY1JWYXdZVGlE?=
 =?utf-8?B?VmNBMGhKQUx2djRnS2lNU2JaT0RYWDRZSk9YUWVLQzNvZkVpN0ZiVnVKOStG?=
 =?utf-8?B?UUJCdjZYc3VFOFlwMWFwUnd1cWs0NTZLdm56MXIyMVphYmVLSEF6S1hxYzBy?=
 =?utf-8?B?MVJVaTROMDRBaDltTjg2cm1zQkpJWTRrNmhBRGQ2WjNRMDBuYkxWc1c3U01I?=
 =?utf-8?B?MHo3TjBFUmxJVWhyZGZHamhBbHJYYUdFZExxTWRvWUJZM2R5RVdJOXV4WWdG?=
 =?utf-8?B?NWNtZVFPeWtSbDhrdXdEQ0tuUXd5ZFpUUDE0clBlMXB6Qk9QaDJaNkx5Y21X?=
 =?utf-8?B?eWpUSkZDSHFqRVVOR1EyOHFNS0xWWDZrbTA3NHhoamxwOXNHRVpsNGdhRW1n?=
 =?utf-8?B?ejlwTHVEWms0ZldWbFU3eWFDR20wa29WaXc3ZVZoNGZyQ2RWN1RKSkI5czdm?=
 =?utf-8?B?T0x4dnNHWmJDdTJzWWNyelNrOS91cUQ3NEk5aHA1VW53UVNhR0ZVbzNpTUR5?=
 =?utf-8?B?QjQ5cTV1U254TEZnK3JUVEFyMmZBeEJIcmhrbVFzV0QwNDFubEo4ZEZMS01y?=
 =?utf-8?B?Vm5TK0VicTlQemIzMkp6eVlEOHRET0N1OU93bkpiZEM5cC9PelB3ZWVkWkhl?=
 =?utf-8?B?aGdHSkFzOWNya2ZTdDBIZWxiT3FLQ1Z2aHd4eEIySjB4SXBrNlllSDBmQkFm?=
 =?utf-8?B?QWl6bG81d1poUEMrZUk0UW1NYkxvM3JWNklwaDd1aEZCcldRZkxPaS9FOWJ1?=
 =?utf-8?B?Mk40ZEQrbWY3NUFGTVpHREJUVkV4VENrS2NFb2x1RXIycG1WVlBXcDhjVzdr?=
 =?utf-8?B?bjZWZ0JKMDhkRjJVQjZMbEMzeDRPbTRWcytGUUNaallWM3ZWdFFJL3YrOGNm?=
 =?utf-8?B?L2pDdUdNczhNS1lzV1pOelFwS29xbnVxOGFvNVVzNXQrNHlsa3lSM3diWDlZ?=
 =?utf-8?B?TklIOEQvNm5CcHVGb1pSK3M1YkZTQVpzZldoMk9GUXNTdENyaUhEVElHRFRI?=
 =?utf-8?B?WFhETFFic0hjYmEzQUJqTUl0R3Z1cDV0ZzA4bjUxOW1hTkVib1lJcSthL0JL?=
 =?utf-8?B?TmJLWElpejRxQkEyYkFkWUlDNXRlTGVQMExuc2lPaFdWMUZiZlhiK1RhbHhv?=
 =?utf-8?B?WjhVckRvYlAxd3N0dmRrTTVnRnAxdThsTVZ5OVQybkpxUFg4dFJmWlUxZWpx?=
 =?utf-8?B?S1RqYUVBNWFBcWNIYjJCUGUzTk8reGFhaHJKbHNxb0ZRZk9IVEF0eTZ0ejJH?=
 =?utf-8?Q?lI57YjBOIVI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1V0T2lsKzJNaUNyRzEvdmV4RzYzbmh1dlhGN3FMa3BnTFRiSkt3N1pxSGRI?=
 =?utf-8?B?bllqTzE0SFBVeUdxQkxVdE1LT0QyK0dDdnk2Uk9DRTl5dWJwd1NwMEQ3YWl0?=
 =?utf-8?B?N1dOWU1JZVRsSVNDSmFqOGl1RTVLMkhHYzM2QXFkQ2pGdnJRZmJXeFN1R0ND?=
 =?utf-8?B?cDVMWHk1amtJTFRxcWJBZzNkS2NRNVVhbWprZW9vM3ZrcjY0STlBQ0dLZzBh?=
 =?utf-8?B?SmpMT2JGVmhDNW9kUzVtSlA1TW1iVTVxL1ZaN3RTdkVmV2crV25BYjRyR1g1?=
 =?utf-8?B?NG9veXhmMVJITzhIcEx1YzIyOVVwTldXZUxLdDF1M3J0ZG9WMTAzZXYzdjcw?=
 =?utf-8?B?OXN2QkM1bi9YTUhuUWdhZ3lhSFN6cEdFcjljL1FveFdnVnkyVmE5OHJrZk1W?=
 =?utf-8?B?QjVhcUxCQTdnamRJUHdaL2cwb1llRklaYVJSQytyc0xSY2ZYNzMvZjdJckpL?=
 =?utf-8?B?THBySkdHZjNzVHJJMnYrYWxLRkRUNEVTREoyR0ZENXdLVUlJWGZQMjN1enBl?=
 =?utf-8?B?eG5NVUlEQ3RRWGdWTDBWdldEMmxQWEpjVmM2cTBYQVlzNzFDT3NoeHhLZmMz?=
 =?utf-8?B?cUtIbzd2OStydmRYa1hjcEFEMVp0UURFbFl0WkZzcVN0aGV0Z1Zyc3BaUWww?=
 =?utf-8?B?OGdUSnlBUkRLQlpQMXlod1EvV2FYdHEzZkRybnBvc1NEZzI5Rkg5dGd1Mnps?=
 =?utf-8?B?YStmTnEzTHUxOHZJb1AyTUs4R0dIMk10SHpqRjFpWlZDSWhUUEphSWRRQWlu?=
 =?utf-8?B?V1ZZRXNIU0UrRmZ6VXIzUEUrK1l1TDEyK01MNEUyU1VlejhyQ3BxblBUT0ZK?=
 =?utf-8?B?c0JscmlldzhFQTllakFaT3Z6bWQwM1lvUkxQR0tqaDVVb1hTeVI2SkNMczZ1?=
 =?utf-8?B?ZHlxQS9sTWlQQmI3aUczTm9zODJFWmpXd1QwMmRqT21kSkhrKzRvZDBSTlly?=
 =?utf-8?B?bTdkaHpLRFlhdkdDMGhUamNpZFpDSVlUTU42SE81eXQramowT0g3UEJLeU0x?=
 =?utf-8?B?MCtGKzdHL01UaUFhMnRVZEp1WXkzYzdQTEZaQVVHd0pGSmN3cVRkeHNOTGgx?=
 =?utf-8?B?d1JzMFhkMDNPMUZhSmV3MmhudEZDaW51SGVEaFo0YVRKVHJMQjJIMmpBTDZX?=
 =?utf-8?B?R0w3OFNlOHJ1UG54M1JvS3dYMW9VWVQ2Y0FuRTBaZW5vOTMzeTYvQ2Yrd2do?=
 =?utf-8?B?c0x5aVBUOUs5Z2ZNV3hPcmtIY0k4Y2xRYmp1SmdDWldtVGhrZ0haQUY1enZk?=
 =?utf-8?B?K2tlN3hQemNkdmhLeG1tWW9GRlR5N1F0TDhPUWFnOUFURzhnY2RXbDZvdW9C?=
 =?utf-8?B?V3h1enhSVVMrYkxlTFFMQmRTWjBpbDZOQ2tJdWdVR2JiS2tPTnBPUG02U0Uz?=
 =?utf-8?B?MUxBd2dtZUhJUnZHYk40cDZTOWNhalA4SDlXTUgvNFJxOW5lZU5VY0ZaZGQy?=
 =?utf-8?B?Q0lneGRRMHZSU0tLT1Qxblh2VWhVNnkxemFxUXlCQ095L2Z4bThoOU83Rml0?=
 =?utf-8?B?UnpiaWpMdHBoY1gwWlhtblI2dHQrRDRKeEswWnl4RmFIK29hNWhub05qZU12?=
 =?utf-8?B?dGpJeVJHM2pKblg2STRvSFNyUWI0ZEdSVTlxVDFIbUJRbitrUFBic0JqVkVs?=
 =?utf-8?B?ZHlaUmJWdkxraFVBMmQwNUdFUXlLTUI3WmFydEorckNzMXZVb0RpNWNkZ0U3?=
 =?utf-8?B?ZzQrN0FxRzFjMDZpNzVJckhPV3VEd3ZvdUN4czdzaG8wL0YzQlZ0SEwyVWxh?=
 =?utf-8?B?eS8vaVZrbDlTK25ST090cC9ib1ZUNkdRMU5UMExMUzZTck1mNGFsMTJiZU1L?=
 =?utf-8?B?UWlldjRzU3BPQmlMWUduVkVucVAyZ0MzV08zM1hBQjdwalBYb1d4ZkY4UEd4?=
 =?utf-8?B?K3cvWjFhamNUZ1RZYmtOb3FObWVXeXNDTGRSVnJqWGxic3NPb1pCL3BMUTdl?=
 =?utf-8?B?NE9iN0N3eHhQZ00yN2w4R3VEVnhLZk1YeGJta0l6TDlGOGFvSjJMQVBQSThQ?=
 =?utf-8?B?dUFjemUycm9rSHJnU0l1akp2V2tSYkxwUStsRkp0VmduWFNWR0daZ0dtV1dt?=
 =?utf-8?B?T1AzZE9WdU9PYUxKTE14TXQ3SWV4UFFoaitMTGxibTNVTEtKU25rMUpmZkNq?=
 =?utf-8?Q?GMREQtgr2Ya7mUw7rLgeP0VQf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce012ef4-6222-4979-171c-08ddfc2c7561
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:10:03.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3cPD1+D1JbjkrZfHjyAA+4nPzZeQTuN5flXv8yjjRbTj3Cc3Y4uiiEmMZZOuh5AX8Ft1tbhMRS7PQsQIOrheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124


On 25-09-2025 05:19 pm, Michael S. Tsirkin wrote:
> On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
>> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
>>> On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
>>>> Function pointers are there for multiple transports to implement their own
>>>> implementation.
>>> My understanding is that you want to use flow control admin commands
>>> in virtio net, without making it depend on virtio pci.
>> No flow control in vnet.
>>> This why the callbacks are here. Is that right?
>> No. callbacks are there so that transport agnostic layer can invoke it,
>> which is drivers/virtio/virtio.c.
>>
>> And transport specific code stays in transport layer, which is presently
>> following config_ops design.
>>
>>> That is fair enough, but it looks like every new command then
>>> needs a lot of boilerplate code with a callback a wrapper and
>>> a transport implementation.
>> Not really. I dont see any callbacks or wrapper in current proposed patches.
>>
>> All it has is transport specific implementation of admin commands.
>>
>>>
>>> Why not just put all this code in virtio core? It looks like the
>>> transport just needs to expose an API to find the admin vq.
>> Can you please be specific of which line in the current code can be moved to
>> virtio core?
>>
>> When the spec was drafted, _one_ was thinking of admin command transport
>> over non admin vq also.
>>
>> So current implementation of letting transport decide on how to transport a
>> command seems right to me.
>>
>> But sure, if you can pin point the lines of code that can be shifted to
>> generic layer, that would be good.
> I imagine a get_admin_vq operation in config_ops. The rest of the
> code seems to be transport independent and could be part of
> the core. WDYT?
>
IMHV, the code before vp_modern_admin_cmd_exec() can be part of 
drivers/virtio/virtio_admin_cmds.c and admin_cmd_exec() can be part of 
the config ops.

However such refactor can be differed when it actually becomes boiler 
plate code where there is more than one transport and/or more than one 
way to send admin cmds.

Even if its done, it probably will require vfio-virtio-pci to interact 
with generic virtio layer. Not sure added value of that complication to 
be part of this series.


Dan,

WDYT?


