Return-Path: <netdev+bounces-226571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B7BA230A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390FB1C23716
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9F247287;
	Fri, 26 Sep 2025 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gug7c7Q/"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767A1534EC
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852775; cv=fail; b=bnN4y2GHQyevIZDVdLOXqQ7O7rk6E/GPnrrHkg8Koe3v9aGAuauRyaTMOlEcK/0EgVT7CwpmvtkAWulb+RBDU1BksrrAAHYEThgeOE+O//rzvlnJB3Lvzno06tBqFWboQw5ZkSeHHmtnoAp4Z8Jnw/CnNl/YJSOc3FjFfs6FyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852775; c=relaxed/simple;
	bh=AWEOaExCxrIaGOTYacuCe2KbtcnAndTq0qsRISQF9GU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mWV93lWFQTtLnWJBu6rGaa5r9L1R29KKsX0UIUqaqdsgww/uOiTiHqZKe/9fGOUC1g8ucuAKxVvF9HeH0daakAxb3iKv/2iYLUtYOBDY5xumpaRi2oICejNyqFVYDpCY2mIHRwfPgvtmD/LX5rptJMEqKdCJRF+u2M88VkuqNt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gug7c7Q/; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrjFi1pORq74FuxzJNYzgwhMaBX8fIhpQVQh1sL+oloYf3CiOHK8tUZn2rx9PwW6s8Y5bqLPZscUYqrkprj3XEr+kG3PVPbJt6etJuJ2UgVvSVpwgJIM5VJtV1ACqI1u3tHgopHTJSALhTuufEHT4eC1GF6+B8/S529n1g1OnZGUk0sdj3GE46KEv8OzeVliq6vXllOckGIwTWRd/nrCTLbZZuR1B+3kVtM4/L3TVipGmDJ3y49HEAds4XMd/IGawyq1B05KQTOlkL1oo10F+qOLbWpSxwEf6wo347UZc8RczIFqZz/uB3k59f/IyDaK0XiG4RSEJ4+E9+qU5zUQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzFFGdUnDGaxPgDWXhPyc4sTf2NyQv1REMN8qU/fG+Y=;
 b=d5lRgFyKhOGPPhUGUS6FRTlGMMNk4uCapO8V4BoZX2dQHa+czCF5CFDK0jrMRwntcu+9zFE/kbdaxIb2OZx8hoo96aNPuhoiaTwWf2B1br7GeBsAoTBc4kF7VVP6GsEcgJnj0y/YG2WcZ5CyPNKq+jOYCfr5JtaGjO0Bz6yTNtVnXI6oA4E3JccE+CIW97jG25aTavcXyhpY2jNtlT5vfv/Is36a8YYsNlqGFQh5RjLeiAzV51KL+JBsU2FAT8zDYLmUkaq8hMT3qot4IvbGQf6neNuiygqih8fcnlhcttwwGaPJLmiRaZgcLMkZaYrAHix9D7f/gr/CY2Z38AGs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzFFGdUnDGaxPgDWXhPyc4sTf2NyQv1REMN8qU/fG+Y=;
 b=gug7c7Q/fuHidZO7LHhAbFDIDzm1nHaxmcUSehGBUj9iglmihz7DOH2E4dvc1NTPlVSDqT/Iir3rSiUxPInryOOLTc0zt5zdlLUaE9b8Q7lp4Z78tlfW6vD2EdBZZnkudvy4+rPbTQZKJzNFZ/ZNzTObxUuOIry3B/o2XIRv6Q3X9AI0pcaKyQib5vYlEHRaK8q89mp948IIf8f3LhAeku6VXuXDekgdbhi3c6f+rfg6pjm41X3/G+iNnTK8WOx6hiqqUphO9VRIh4V8REdXGHtQg+UwpsBRLfyEE9PyC0+5aE/c4WDvG8Pqw+xoSRr6PWR4QOXm2FQDXp27cRt6fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:12:51 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 02:12:51 +0000
Message-ID: <3097d7ee-b2e7-4232-9a80-fd7f33bb9fe2@nvidia.com>
Date: Thu, 25 Sep 2025 21:12:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
 <20250925170004-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925170004-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:806:d0::25) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cdfa8d9-ebf0-4bfe-190c-08ddfca2322a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1pjOVZsL2xYQmVhQ3RTZ1hyZzl5MlR2Y3VSWFNOY0ZrZDY2bW1JdEdOUi9h?=
 =?utf-8?B?bVg1ZVZpMmJTME9zcGVLK3pIdWdOWHp0emFyR3NZWDFiYlJrcVpibHA4YUV3?=
 =?utf-8?B?eFRNZW1PRUQ3Y29hZlE2VlpnYUtjT0pKT2szY2FzbTZIRGZyWUFjYVM5aXAv?=
 =?utf-8?B?ZlRCaHM5Y1l0NExUeC9nWkdsNnFCSENlSVFXeFZTNjU3RlB6NldoV05JMFdW?=
 =?utf-8?B?RFFNM3l4azZLQ2ZrdmlqTTcrZTdWKzVaZCs3UWVOQlZBb1JwVTRocWV3cjdR?=
 =?utf-8?B?RTFVUzdsajRvVmtjc0dFTFViOGJuQmd3T0JuZndNbkZQWW9hMFBjK0RRVUNO?=
 =?utf-8?B?YUlsWlc3OWpzRXhtUzBNNjFsWnJKMDJSS0ZoZHE3NS9kVTlQRTl2c25QWFdM?=
 =?utf-8?B?RXg1VkpOTDE4Qy9MeXRLajFMdHVVSzdTL0EyOXNBRGdZV3RwMmRHdUpmbUo1?=
 =?utf-8?B?RWhJM042djRxS3F4cnRaeGZqQ01rd3QrejBlbUJMeHJKUHJuUk56UzR4QU5Z?=
 =?utf-8?B?ZkFERnEyNEZkQ0tmQWxvaUd5alZJUmdXeVlhTnFsalR5VEd0VUcwS3BrR0Nr?=
 =?utf-8?B?OG9qT2ZVWWpTQ2xsK0VFNFZyejk1bnR3em93NFpVS3lZOTFLTjFVczU1ZGVU?=
 =?utf-8?B?TXg2Yk9UZVZsVmdWNTdGYlFrSnVncE5tWnJLbjg0TlZRWm9rNUlHK296OFVl?=
 =?utf-8?B?NW9xNXIyRWNGWlRkekFUNVZOdks4eVpuMitBT0YrU0toMjAxTDNzbmhZajZ3?=
 =?utf-8?B?dVVwdCtUUHBodUx3S2c2UGpJb0xXbzdIM2VLYVhnREFMQnIrcUljeFZSQ3Vm?=
 =?utf-8?B?NDhndmw3MVVubElBbW16b2Z4L0MvWXVGSVMyZWsxWUR5RG1lak1xOC9hSDdy?=
 =?utf-8?B?a1J5Qk5Hdm4rL3pSNGVVaFVTOXl2dnRnajc1RG4zTVhrNmladkM1bGVFb1dI?=
 =?utf-8?B?djFES2xxaTA2ZVdVUDE4bkc5OXpiZnJPbFlSZXhoUjhFaGpLS29KV2d6YjBt?=
 =?utf-8?B?d0FvZ2d5S0JaU1EyVnFzODZidmM2U1UzWFNHd2RRWjdBL1B5MXhEcnJnYkhy?=
 =?utf-8?B?MVpXNEwrNnordkxFVUkzOTRLS3VIc0R6NCtITHNiY2hkeFhQM2krRFZsM0pC?=
 =?utf-8?B?WndOeWh4NVpVSVlLbHpXdEt4d0FOV2w1cWhSaCsvUG14M05UQ3BmZFJjeUxQ?=
 =?utf-8?B?SGxtSmtrOUdZT0pFR2JRb3RmOVMvMFA2VE1tRlFGaTgwcCtpSkZFVVhINnFJ?=
 =?utf-8?B?aHR0elVvaVFId0xoNVMxZzNuWno3ZDd0RUlQWmZPbmdvYUNrSkVqVFBGSDRN?=
 =?utf-8?B?V1U2SUJoZ1kvdWpWZm5lQnJ6THM1MkFRQ0dRQWpJVHFQbDBuNXpzbzBDL2Rj?=
 =?utf-8?B?TURGbTdGanNqRThIZGJBL3R2VlV4eEZlc0tZWi80d2pmcU11ZnVpSWJiTG54?=
 =?utf-8?B?UG1RSHZzQ0lncTBvcW12eHplM1g1TEsxeWl0YjdzU09UZlVwUS8waVlqTjFX?=
 =?utf-8?B?K0VnUmxITzFpYTdxRGNhbUluenB6SXM1c1BXZStTb0U2MVp3emdvNFdpaGI0?=
 =?utf-8?B?UDJiTllPWkpYN0c5MFNJcUE1TzA4ckZFdGtFUlJnb0dURGkwa05yRmkwdklx?=
 =?utf-8?B?VU96VWpXd2JrWGc5NTRZdk10V3RjMWRUdW1YWHZSbFV1TzdYUXpjMDd1UkFQ?=
 =?utf-8?B?NFQvMHltd1JpczRLMndWYWQ4ek9uZlNMcWE5WWtYK25lSlV0RkNtSzVWaE1K?=
 =?utf-8?B?T3pKOUl2R1MyWDJFTU1tYUQyamU1SkI3R0dydUdoZXBCcENNemhmdnR2WkRs?=
 =?utf-8?B?RGJVc1ZId3ZyL2NDSnc1S2RmajcxeEE2ZUJ0UVdyVjB3SXV5cU05cXo0WUdJ?=
 =?utf-8?B?cVJQWXBpSk9sMDEycGZtRWxpMHRiOW1NZDBZU0xwSnVOZzhwRndZSm1VUGps?=
 =?utf-8?Q?9ONq8sOv6MnT5uwxiv2gLLsCsBj1Pswc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VJeiswbldTSEE1Z1RXSmloYVN6b1NpY0NhSVpjemdDZnF0VDJIOVRWN0VW?=
 =?utf-8?B?RFRSWElPeDYrdVdHT1lmclE1V1Bna2JXY1FlUXIydzhSZlUrc0R5c2RlQjdw?=
 =?utf-8?B?NERVNlRxUW5jY1lPaEtNNng1cXNhZGtLVXpSL2NyZVpkTlBBcU5uT3IvTzVt?=
 =?utf-8?B?SnhQYlkxTFYwVE5mS0Y2ZkZVUkdxMzBrNTVmY3VkV3E3eU53RzNVVENQMmls?=
 =?utf-8?B?OXBNZEFmRzY5QldiQ2ZVUTZLY0JIWWxoSFN3RDd6OHFZRkVRUVlWaHk0V0lV?=
 =?utf-8?B?Q0Myb1ZCZ2ZTZUNXOFY4THBnamNHRjRGM1AySWE0blZTRDF5MnlTN0pNKzcr?=
 =?utf-8?B?MUJRWTlXYXF1MEtQUlVKLzI0WkFLTzBCcm51Z3VhYzVLa1hLMnJBT0hqTWc1?=
 =?utf-8?B?clpyaTdlaU5oMWRweGJpbGR0clNvUklyT0k2SUI2bjNjS0xSTCt6Z2tueUY0?=
 =?utf-8?B?TEZHeDd4TThGWlFCNmtYc2FHa0ZzY3FwS0oyT0thODFYcFloeDF4YjJKQUQ4?=
 =?utf-8?B?WmVnb2lISHdrVVFoenJnZlQwOVEvY1JkTW5rRW41ZU1KRWhrNHN3MjczYmwr?=
 =?utf-8?B?M1hQV0hVcnRJOFUvOFZIWG5xdXllZGxoV1NsdTVDVnJRNEg3QzlaQ084cE10?=
 =?utf-8?B?ekVIbmZLYkhFSXViQmViekx1VmhoRXB4UjBKYXFzc3U1NW8xNEoxa295WUc5?=
 =?utf-8?B?VFVrWlJPclp0cVdjUHFPQzZrTmZvK1dzdUJhWVpDUURoK3lRNUs2TWhHcHIw?=
 =?utf-8?B?MjZDWXgxQ1Q4ZkxJc0ltMnFsUlgvc04zTzJ6bFhLRFBDSFRiZTZDS3RVQWho?=
 =?utf-8?B?ZlozWTdIMDFFZFdPR0IyOFlhRW8zekxxeHM3OTEvVVhaME1DbS9tNmZQYTZq?=
 =?utf-8?B?R2JKZGhnRVI3KzkrZnlQbWFtTjJOZllmU0hua2ppbm9CQjEwMnpJRm5ZZjVZ?=
 =?utf-8?B?WnBsZHVORkFwV3VXL0FuVmpDRVBCc1hOa3l2bmVnaVlBVm5HeFBJSGlHVmFK?=
 =?utf-8?B?OVh2M3hETHRXTG9zOXp4QUFXWnN4cmhwK09qaTRSelpnR0NMbVp4VjYvaEJ6?=
 =?utf-8?B?dTl6Y2lWTkVhcE1waGhYOTBseWloa1ZmaldUWTQ4NGRVdXZEdXBQNXpyZFM2?=
 =?utf-8?B?cEkzc09nRVVSUjlZTTU3L1lDWDBzY25sM1o3TU8rYmt3d1J2aTUzeWdZSUVh?=
 =?utf-8?B?b2tZc3ZMQ3dYaytrZmJER0VUQUdKS2xNaXZkS0JkTUI2c2NwVFMzR2owYXVL?=
 =?utf-8?B?b1hOUEp3dkIyRDNsNGtqMUp1Z2hKVUZubWVhTkI4SEZrMWtJMm1uTU9uYkN0?=
 =?utf-8?B?YVlaRUp2cnFwQkdsODRDdVZIU3BFYzNJQWRRQmFJSytiZGgyQnM2WXpERlBS?=
 =?utf-8?B?WVNDMklHWW1GdTNkRVh2b1B0SXFzOXB1RFpTMFg4dWkvdkdyOEtDQjMvWW5H?=
 =?utf-8?B?ejJQakwvVWRsK21VSG10eFRqK3ovKyt4UHNlME1YSmMyMDlMZmZqNDRuVnJ3?=
 =?utf-8?B?QThTZXRaSEtiMG1nL2ZVbDlrNTlPYWU4TTdaU01VeWNzZlp6YThQdGkzdjIw?=
 =?utf-8?B?cUYvcHZMcGUrWkNLMkR5dVhjc2szMVJmTTdicGlZdm9DT2RPK1kwQmw0aWQ4?=
 =?utf-8?B?TVNJTlVlZ0xWUWgvRGJqTFRrcnVvNGFXazltS2lUTXpINFFvS1ZSeENXN3FN?=
 =?utf-8?B?MUlCZWVvank3bzZMaWo2NnNhcGJqVWFOcjJJWFpVWEQxdkdmbVNFeWRvTHFI?=
 =?utf-8?B?aFJ6VmpidDZ5QS9NREpxcUd1SEtwSnJoV1lockZWL2w4Q3R1ZlFtTHEwak9O?=
 =?utf-8?B?K0toRXR6bkcyTDBvemNqQXFkUS92RHl6WWkybnVmMWxVYTVqN0dxT1NDeldG?=
 =?utf-8?B?bjlNUnp5SEI1MzJjR2s2cDlHQXJFV2ZpSHVCVTB2eGJOaDZ5MnNKNFlyeHE4?=
 =?utf-8?B?ZFFMeFJtVHM5U29YejUzMUZMc3FvYWh6UGtnTWQxSC84VnZRbWtldWxaRjZN?=
 =?utf-8?B?WDRNR3NTVlEzY2FzaWFwM1AyTCt1bXBaenZablRLdlZZZGJRNW5na2k3Qzhi?=
 =?utf-8?B?Nm1raTJNQXNaNFFiM2VTRmthQkRONXR4cVNYS21KYmRlT2lIVVlGOXZaVWIx?=
 =?utf-8?Q?iJO3dcEB0c81rck0jzoP/9ZHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdfa8d9-ebf0-4bfe-190c-08ddfca2322a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:12:51.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeeYbu1/R4h8pxYRqJbKB0xYYUUuJ/A67tWRqT/UrQs5qNljC73BKrBGN7Tn9U5uBiCfZoQGxse9qJSzNTq9cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303

On 9/25/25 4:01 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
>> When probing a virtnet device, attempt to read the flow filter
>> capabilities. In order to use the feature the caps must also
>> be set. For now setting what was read is sufficient.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

>> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
>> +	sel = &ff->ff_mask->selectors[0];
>> +
>> +	for (int i = 0; i < ff->ff_mask->count; i++) {
> 
> 
> I do not think kernel style allows this int inside loop.
> I think you need to declare it at the beginning of the block.
> 

checkpatch didn't mind and there are many other instances where it's done.

