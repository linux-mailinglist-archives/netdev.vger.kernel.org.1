Return-Path: <netdev+bounces-226280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC197B9ECCB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E787178D30
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FC62F2902;
	Thu, 25 Sep 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtcFNBcj"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF02F0687
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797135; cv=fail; b=FxTbHp61KynZl0Ky/NCtdQV87rYZoZPsSGPtPKw2UJuRAWR+QhxRiwQFMB7svszsSEZil4h5TtymYG10Ln9QHdO5yMCwdefWdzTVz48rggbqiF0x9NT6Ay5BeDDc9rY5+ymj/Tb4ouC8xVx8qn3mbJU7+xDAY7nBgfAIARPLJKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797135; c=relaxed/simple;
	bh=rJG6rA1psHt48o+6MwNddhy15l7eA72r1AXbcwjKEMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzFrVFv9N/qkESwmKHTmsCYG1H/1WNC14kAQo0XD9GAVE9zO3auTI5sr9cNotWsNYpKcDkWngmFJI71KsUsyI3pWu18kJGsFzQynI3wPpqGVcc/VAR8cCrRs6ZFVoAVOxdwoJ91M9pTGYToi6J5JCIo48tCVyc7OTmuzfTOB0lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtcFNBcj; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEW9SgVXe6o2kJpcv1WSLuDMrPq4JLgAhF13Uoaq+ENhQvMfBYoN9MwUFQ4HP476n5S4ZA6bK0kdwmyrxIsCSJNwSQzXGNbqVJkbnimhnT/XI2eCRzq97zXCVBk0gm8ihemigYQBbr/4I6jhekPgToieBZlz06EeZd+E/umpjwbrtchJYdEsimHvKAaOQWkHHj5hJv0rkG69Bx8IfypqqQiq8Sd+BxaRPomjW9TfHEzdEZUz/mUWGlMEJxmtgSl19nGtdFGEXXXOaSOrX78IojzTuGLIiQbI9dzITilkOpto7E4HBFAFgt7SIQX3kYryNegSeTC0glWDvriFsbkEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1F4m6KtUyLzvHxro8cEpw5DKsHu+cCtQp2z+/gxCP0=;
 b=Ptxs1te6HGaI54DEi3ZuOXDKHaqvwzOdWiqBFOtXKTRKLM1SprXQRH0OJ8YVeY8PZ9Ar67SmnXrMTlhRlwUFVHwlbja41AsTsqy4ImX3Gum7mWD2NjM0kEU4i0pVDDGfSi/pOuEfaf1RhZMiqXwhyUyJP4UqMs0tP+Z/y8E/shmqkTyxJJ+YbTFqgpQNzRUzBV8bR2kPSKBeUYBchPnF+9lHRAbYcZt1ok+vwhgRtq5F5B+dhi21u+D8b5t9U0KvHwdbVRepXjKWyT/tEWXt7w9TsRQHjpd+hXol6DifvnJQJO9WqXrg96k/7y3V7Y1qNNmIQMMs+Jyye1a4Rh7Ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1F4m6KtUyLzvHxro8cEpw5DKsHu+cCtQp2z+/gxCP0=;
 b=LtcFNBcjIbA9Boxr/9Xq2a713ZDap2+uHCvY+Fzw6gwYjyUrDp2tzGBL88lZqihBDy0cO3/qjlSqIpgj0fEt2aghVGY1ocNUa7Qi10fLl2dF6A+hL7AxJoSbDwKtIfOMYYsOgzwPkmoGuplYuh1u4h1DzloUXRnqoqjacLZ+X5u8IYYz9wu78tDZ9Fx9TfG3jdqB4W3osKw0RfII903t4K7NI1QS0WLEwHRZR7QxCumXf4/JLDUEb58KmlfX5FpAi0WW6MM3n6SveGBwAXP/CLXyqD1FyuA8kVlHMeGfuL8x6iSZwDWYQgbuHAt2OAyhk7aKJAvEo53U0vQEp/jIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 10:45:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 10:45:30 +0000
Message-ID: <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
Date: Thu, 25 Sep 2025 16:15:19 +0530
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
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20250925062741-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::17) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: a09b0530-55a9-4841-1369-08ddfc20a531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlE3YW5QRHM4cGhzS2dQMHZkOU5qcU5CRFkwRlpnT2FhQXhZd1BMME1rN1Zu?=
 =?utf-8?B?eEp3VWxaOTR2ZWNnWXNVaDljTzJMN3dCY1psenhYbVJoTVl5ZFQxdDRjRUUv?=
 =?utf-8?B?aGlzcHdPS0sxQWEzcHBKSlZja1BiMXhCM203RWJRSlk0REUrbmlZc01ZSDJ6?=
 =?utf-8?B?UUU0REFpNzMvYWJKT2FZcUw1SVNLMkU0VFhMRTdtUEhRdmZtbGN4cXdFWlhD?=
 =?utf-8?B?bXhnVWVXWVZoSCtjbTk4OXpSbnFqcTRieEJDQkc0U0dzMGlscjJmSnliSUhz?=
 =?utf-8?B?cm1JeHI0Y0xZNVhrMGFFck5RazBiRy9hcmhsdlNMTjh4eU5BeUplUE1kWVR5?=
 =?utf-8?B?ekd0dkF4MGdoRk5ETTd3bjMrUzZVT3NEWEZKYkQza1cxTU1BMGFIakM1cnE2?=
 =?utf-8?B?YkNYOVY4bGk5cTdYZ05uMkZvYlVidXhGLzZmTFdybjRrRE9mSDBxNGMyZWF3?=
 =?utf-8?B?bVNXaDg5dVpiQTdwWHN2aGt3bHQ2cXVhcEg2Wk5PYXdlSVpHeENERUJZTlFG?=
 =?utf-8?B?ckJnSGFPb3ViUi8xREYwV1VhajBhVUlHMFR3VXNCQnh0MHVVWlpuZmN3ZzZu?=
 =?utf-8?B?eENJOERPTFFvZk1QWitNV1Flb2lETWJNMXhIcCt2a0RhS01TdDNzdUhmM2Mr?=
 =?utf-8?B?SldiYzRCbDVURzh4QWtmUGdpZlNnT1BHWkFXWFMxTVI5dlRTMDM1QVpobEhv?=
 =?utf-8?B?ZFNyWFozYzFGN05TNU42RGZMYUFEbmhCb01Hb21CUDhBVXNybjNmSFh0UG1k?=
 =?utf-8?B?Nm8yU1BCcjVaVWNqdlpTSThvTkRMT1JEZlc5Vzc4a1BSNHRxMzlxNnNBOG9R?=
 =?utf-8?B?cUd1eHRzZm1LNDI3TmpmSzZhaXdVZ2czN292M3pSZ3ZHK3N3UEgveER3QnNQ?=
 =?utf-8?B?ZjdhamVtRkZwcnYrREZQMUdOaTcrbEoxNlpNbnlZakN3emdtSWZpV0ZIaWNq?=
 =?utf-8?B?NHVHMTZxMlhwazRldFJyWGRmYllIazdoSHZXT3dFeWduMkhaQXg3eExCYVFu?=
 =?utf-8?B?WDhabVlhT09OUUx6WURZYmFkSXlDMncxVTRDVVZYL0djOWpjWXFVZHczTHl5?=
 =?utf-8?B?K0VhRm4xMWdnYTBaSXhLNXhQUnI0V3VsbzRBOGJSRlRaSUlmZHQ2ODAzUmRL?=
 =?utf-8?B?eDJ6dkhmNDBjMm52cEVvOXpUY2t0M2Eva3ExL1FmVXN2SytlM0NWcjFEeTJM?=
 =?utf-8?B?cHNXZklvRU9vbi9CeXhPVStmMDZHbkxvdFQ1UVA5WitSSlVrR0EyWG1nbDFJ?=
 =?utf-8?B?YnMwWDB3Q3BNU1JiSFF5N3dySFZiK2o5UGhKKzQ3U28zV29PMDhCSlV3TW42?=
 =?utf-8?B?ZGErWHRteFRCSjgycTg1QmZCVnBMSFZRcHJreE5HOGVvd1hmT1pZWm5YMTJx?=
 =?utf-8?B?L09mLzgwMkJoLzJLTG15R0FiNzE1b20rRWEvd1ZWcEh4S2FWR21ndUptTDYx?=
 =?utf-8?B?TjhtT3dwTjc1YnErZEl6UGZnZ3d1clhNd1RDY0hoMDNPaUZLdnBqcUVqYlI5?=
 =?utf-8?B?NlNtSi9lSHYxZzBrcnQrWGx6cVU4NFNWUHlqQkFBc0Z3MmJiQVhON01lNFZr?=
 =?utf-8?B?MnArSFdXaFA1NlEyYVowY0RsTGJybXg1S0VzeEtHOVN3YXZJR1NiVVorSGRs?=
 =?utf-8?B?Q2FPTkJrcTQxeTRGTzkzTGQwR01KMWV4akVxalRWMklmWjNNaThVb1ZLRVZO?=
 =?utf-8?B?djVKcVAxazZtNDVHcWpvRGRmanduNXY2RlgvY2xmVlZIN0lXcjV6cUpXQ21r?=
 =?utf-8?B?eWxCcmJJMm9DaTdpdTZqMWF1bGtzOVczQ01OSXUralQ3YW1xV0djVkJ5aGlT?=
 =?utf-8?B?VFFKTW9PcmpqRjlDM1lZLzVjeU1lS045b0ZPMG5JcVliWkhDRWg1VlljdGZP?=
 =?utf-8?B?T1BOL3hDU0UvOFpTNnR1ancyamQrMFFRRktObFFSSmVGWnBWNlpKOU5OT1Nl?=
 =?utf-8?Q?N+clbtqa/ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEVIamNUeER5ZkI0ZWtpQnB2K1AvVjFNYjBwdGl2djdrV2ZiRGhRSDJ3bjZh?=
 =?utf-8?B?cUE1bm5XMldoNmpZYUFTN0Y4L0ZYOHBlK2ZxZUZMd1NYOVBDMEVoTlFnNFVI?=
 =?utf-8?B?Tm1XK2dFam5tMzd0ZHNIZTRFMGJ3WlFIM052NTFZWWNpL3NiSDNia29GdHY4?=
 =?utf-8?B?QjloZkVWQk5VUDREUXJ0V1doK0YvUHQxbmpvSE5WaDlob0FlZCtUM1dHbFAv?=
 =?utf-8?B?bjErNWJMb0tiS3R0MDUyN1JYOHpHdFhIMnRJYW9ialExTU5SYVNibDVTWUxE?=
 =?utf-8?B?TjhoM0FWcDRJOWFEV2tOVDV6MkR5N2FTSTlsQXg3TnFrZmhnR0tBVEFWQ2lP?=
 =?utf-8?B?aks5WEU2SnBTUXQvVjBkeUVMVVQ4Y0cyZXNHeXlaMVJFNTFYdGZLdWdUSHZm?=
 =?utf-8?B?aHRjVENhanlhc1lNdUVMWFF6WFMrcWRWTERMUmNUSDBRWnNudFk0bmFJZmNQ?=
 =?utf-8?B?RUNMS0tCc2p4L3VteWZ6WXlxTGd6bkpidEV2ekUySlRZQzEzWUxGVE91TTcr?=
 =?utf-8?B?YTV3dGtXQk4zVGh2Nk1FK2pmSHJRM3dHVy83U1F5aWZDbTU1MUx4WXdaL0Zt?=
 =?utf-8?B?dDk3UnJRZUtSdWJSQW1QQk9kM0cvaC9MVGpwbnRpNVdpU1dDUEMxL3Q1Smtr?=
 =?utf-8?B?SVNtK3YvdE41VDdBdlUycFBaQlJUdGh4Qi9OYlMzdjczeHVPSklnd2Vsdzc1?=
 =?utf-8?B?ZEd2emlSYzYvYmVlSldyUEZsc0N6ZWRGQklhamVmRktrRUMveHNIQnAvZTY1?=
 =?utf-8?B?L2ZlMW1VNzVCOC9nZGJ0QkJlTTZTNXQ5aXRrQ3pCQUF5cFZrQ0lyTE90ZEJk?=
 =?utf-8?B?NlBpbXhsYUY1VjRUYXNOS252a25sbVYyMkJyenU4aDU0RlFYWHhrejBkWm9Z?=
 =?utf-8?B?TWRFR1hJTGRQRFFmcjNnSjU1YmxZRENCeWk4V3lVYjVDS2VtNEIwTVBrbnBI?=
 =?utf-8?B?eXE2eWJGUHJBNjJSdVg1WkdjMFVzODV5MzIrOW90QjhCTkJWQXF6RVlITVNR?=
 =?utf-8?B?ZVVBSG9rbEx5Qng2dmZrVnQyREFIMmF5N2FPRzh5OVdjQkU5NEE1eCtxQ2pT?=
 =?utf-8?B?a1JYWHdjNm13bUZhN1lUWlQ3N05FbWN0K3hRVkROSFl4QXIvQ1gvM29KZnpE?=
 =?utf-8?B?N01Hb0lZNWQrRVNJOWxKWlhncXVuOUVvNTN1Mk42RmlHT29LUUcxUHpkZGU3?=
 =?utf-8?B?dzg4V0lXZTE2K3UydG84eWZ3TExRNWVncTlPcTF5aHRJcjhHUWFJMWJwTU8y?=
 =?utf-8?B?ZHE0eTZyZEx0cFpGNmhJS1c0eldYZXM2MHRhYU5rNHlNYm1SV1BqOThQSVFP?=
 =?utf-8?B?NDg3VitTanBGUTBpMXhRazdVV1NDSHdqQzFiWWR4N1NFdGRqSXhRTEJCU1JG?=
 =?utf-8?B?VkZOTnFwcFNYamE0YmZUK2RrREJBR2luNGVJUXRZRU9KZEdNaUppdUpTQU1Y?=
 =?utf-8?B?VExGTE50d0NqU2tCQjJWVmNXeHdwRTEwVVpkZDZycFpMWHZDQVo5bHR6cEZh?=
 =?utf-8?B?bHh2UmM2VHg1cllGellIVXhtaGhDVlJIdTV6YjY4ZlBaNnRFSTgvSHRNY1V3?=
 =?utf-8?B?TldIYkJBajlLWnZEcHIvcU9zOGVKVUNFZ0RKRnZMZ0NwYjJaYzFnWkRObnVB?=
 =?utf-8?B?citXRUxra0VybTdGWWx0aEFwMk40Y1hVbkFoTm9uUWtmaHEvY0pQMlVEVTk0?=
 =?utf-8?B?NjlxWTlqNi8zQjFnZUlxazlVYTVDS3NjWnN5eGFHa1l1bXV2bHA3R1RiaWZa?=
 =?utf-8?B?VHprNXZSTXFtbldVUkRZazNNamIvclhycFVUN2lDRFJRL1orcElSVWtqN3dT?=
 =?utf-8?B?MnNJazRNRDRzSXRsUE9LS0o1MVV1cFhwZXJPa0JPdytZWXdNdHlFbkc0cm9r?=
 =?utf-8?B?R0RMT3NSWDgvc0ZJb3VJaGdFVW5jRlBWeCt5OTV3NFJCck51bDFXZzdlcytB?=
 =?utf-8?B?Y2pKQldnS1JVcGU1cVB4akh5dmw4UUwyS3poL1hHUUMzZ0xwb29WRW5IY0Jx?=
 =?utf-8?B?UUkxa1FqSDVXNVlPQVRTbkNFUnhhZXRmT0RudzcrZjZxMk55a1pRZTZUTEtp?=
 =?utf-8?B?aEhNU2NEbjhTczZiQ2JBRHBNWHpRU3FiNGxMMjE3ZnFMRUl3SDBCZ2JLTHNV?=
 =?utf-8?Q?tv5sEN/4CgzH77568AsnxXF3O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09b0530-55a9-4841-1369-08ddfc20a531
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:45:29.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvrdSOe4//6GaiDtt7XGQVhBPa2GMBFS4nzLGBpTSdSlO8/MMCxT9L7kwrz7hQnxgB/Ej0Q+i4tK97pXOccWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233


On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
>> Function pointers are there for multiple transports to implement their own
>> implementation.
> My understanding is that you want to use flow control admin commands
> in virtio net, without making it depend on virtio pci.
No flow control in vnet.
> This why the callbacks are here. Is that right?

No. callbacks are there so that transport agnostic layer can invoke it, 
which is drivers/virtio/virtio.c.

And transport specific code stays in transport layer, which is presently 
following config_ops design.

>
> That is fair enough, but it looks like every new command then
> needs a lot of boilerplate code with a callback a wrapper and
> a transport implementation.

Not really. I dont see any callbacks or wrapper in current proposed patches.

All it has is transport specific implementation of admin commands.

>
>
> Why not just put all this code in virtio core? It looks like the
> transport just needs to expose an API to find the admin vq.

Can you please be specific of which line in the current code can be 
moved to virtio core?

When the spec was drafted, _one_ was thinking of admin command transport 
over non admin vq also.

So current implementation of letting transport decide on how to 
transport a command seems right to me.

But sure, if you can pin point the lines of code that can be shifted to 
generic layer, that would be good.


