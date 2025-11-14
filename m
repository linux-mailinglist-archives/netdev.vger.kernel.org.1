Return-Path: <netdev+bounces-238647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E80C5CCB2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 890B3353D3D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10312C1786;
	Fri, 14 Nov 2025 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n7Z+bM8H"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6C242D6B;
	Fri, 14 Nov 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118663; cv=fail; b=iRHVkA6S6kMK7dGPy+IsOPM/KXugkSeqhqpvc+bQv4lmjVos7WfbAtRJHe/HW+SN6evHe79NJj8aE3ZDEbqs5ZcV99iEHdzT1vfA3RwwX8XwIK2sObEXUnROZ0RZst769MFcNdRGlXmY7EayIV+auRAxOy2/Pydukmy66lsNKJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118663; c=relaxed/simple;
	bh=l6P8q+zwUV2zEAo8sFk/FpfP4iU7uAN0Ba9bMsVR8YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bn/HXSCBrfb7vEmIGWNFhToUBbdhb9MjnHk1459IeIQIIb3Qkl7K6ygHXssP2jGG8XsWE46f5IUagqrR/BJSPYZqLEE+UFa1I3MJZXI/BqY9judFHOFRLnN1vS51SiEYpjVXV88iSZdm67A+GigzlNTDx/3UOZhTikLpfJ3On2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n7Z+bM8H; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWuQ4rXGy7bEctaxQQ5KAFi1BHAtdQ+nIxpCogJISDSAAIOC+SaLe3JArhLpeOJDg9i10IHukj8vLl+EgrId6ZBG1v4niCRFvK1GFdGNE2RwMYuGpOkzJde2wzIQJvfawJQEd2cBC3BPaR+13ZXD8l6IkmyZl8ZITOGtbiCycU57QYBSr9iy6OTVO8m6m9usCHwjQ4+zqO3CsqrsZZ9N3HX02DR2Yr3RSZ8/wdFMiGGCqgdPgBKgc85knKLcjQxQttoRIEdDEdqtYNWfIcu0c5glkTtdP2Orzci98Ip8SEj/DInwwGwwIBEOXIXF67BKNc/C+6oHD5cXUJraMqHwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tidcarM2rDv6Hblg/ZcrB48L9fzoDIZWPonVaz8asaQ=;
 b=Un37SnHmJ6mINnqSON0PfBH3WPqvG1VzeSVz2Ps6bw1An9yesUnqbFa1hU7oFdV2x1O3eUrfJg5xU+AhFJRej33GWwWjd4R4ZYcyNCrTgPbeDgvoWNhhYmcvWQADjcbhzvOtfUweJFNnCrXyFS8HKfEHUvzgKaAFHRIDlJrkPdF0WFFtUPb3fYJLjMPrOWYmjXcd5/DJJ5eG5KheUSkuOPLTDka1OECsK2m4tq9mWTjTt78vm39DVg67OCkMX2PX5EsvlC5gk7rd6FGUgAHdF4a74hAXgKKGnBUqtyNBUsJJiGBUUpBmNiOfI+thMPiWnxkuL2IsU1BfuoOFVUNmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tidcarM2rDv6Hblg/ZcrB48L9fzoDIZWPonVaz8asaQ=;
 b=n7Z+bM8H7gd9nByESzgEXf9XXp9l5ky9mOuEa2IN7cc1INo8CqaH/E+J+y089XN5L8bxMS9RLN9LPK7AFdpMIuPkvj86aEq4NnE3KEKrAxdiZMxQuMe76WMSJ4K1ZrCT+Bw1fEaNuVPgPREzpjPHi0Qzp2OklIAKiOUs6wR9ecg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 11:10:56 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 11:10:55 +0000
Message-ID: <374f8a2c-df06-4df9-8816-d91d3236cd58@amd.com>
Date: Fri, 14 Nov 2025 11:10:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/22] cxl/mem: Arrange for always-synchronous memdev
 attach
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-2-alejandro.lucero-palau@amd.com>
 <20251112145341.00005b4e@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251112145341.00005b4e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: c6413db6-bbe4-410d-9b98-08de236e7ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0Z6cUlFQTRyTmNIbUxJQ0gzYXFlL0ErSkhPQk8vVFJhcnJkcU5qZlFZdmVM?=
 =?utf-8?B?UFVhTVZWTEJHT2JjSWtpYncvNzVYWlJNWDRpV3NiRFl5T0lhQlh5RjRuendW?=
 =?utf-8?B?bFk2RXZHUzM0eW42LzJNSGZmSDVjRHZ1T2pZcUx3SGNTYXZkc2c4eWg0QVpR?=
 =?utf-8?B?djlDRkl1d1p0RjdkYUlhbjd2YmliZEZ0aVp5MEpaV3lMa2MvZk5VdmZUVDdG?=
 =?utf-8?B?K1BlT0NSQmdrNExZYUJsZ2d4RE05blhjR0I5ZEZUYWpEaTNERWZXSUpOMGp5?=
 =?utf-8?B?cHkzNVQrcEpYZ2h4R3lQMDlnY3pEL2MvbkxWS29HeThyR3lVaVdnY3pSOXJn?=
 =?utf-8?B?TGc5c1V0TzVlYUcrOXZwYkFlZGEwVUZ1cnJRVE50SW1pdEgrRzRJOC9yaHdN?=
 =?utf-8?B?eVNzaEZRQkM1K3ljZERoREdVK3diaSs0TEhzVlZtYjVGUFg1ejMwa0hmbnVN?=
 =?utf-8?B?LzJQQUZxL1ZGamx5UUZYL2paK2VIa2xleCtKcXVZekJFMGM5ZTlFSEltUFE4?=
 =?utf-8?B?QnJPLzZSOEJsOFVqYVA1UFpaZHBGUGx0a1FIcHFFR202UGNZNVFEQi9TZ1ov?=
 =?utf-8?B?azdRVk40OXlDS2FzcXV1UTJxZ1RodzdhMkhsbm1PVEZDZ0xuejFwRXp2QlUv?=
 =?utf-8?B?WmZFNWc3L0d4NzN0b1JQSmQrTHAra2RCTHowdjNKdzJEeThvMjU0a09rNjM4?=
 =?utf-8?B?djFHdjJvSWhrdzh1ZWtJYUNUUVFvSlVGNkx2SE1pN2JrZUN6TWd4U0FFVzBW?=
 =?utf-8?B?Ymk2eHQzZkhuK0NBN0krWFRSdGpCWWJabUVIS3BsK3kxRzVka2k3bGNONWlP?=
 =?utf-8?B?cUhlU0EzRWVyK1Q4cWx4Uzc5eTlpQ2pDM1kydTFNZnI3YmIySFRSWU1xZVRn?=
 =?utf-8?B?NDQwdGNOc0FhVitGenpBRW5TMEo5L3Q2Z2JYVzFTUW1NR0VUMkNYM3YxY0c0?=
 =?utf-8?B?a3VuVWYya1VzTWluUkFEYzFQUWZVOW5zODV0WEpRYTJYYnJMQjVLMTB1NWtE?=
 =?utf-8?B?M1ZDUUZ0MDVVZ2ZSdVVmbk4wM3RHRENyUkxRWCs2K2ZQNzI1Y2FaQi8zcGd6?=
 =?utf-8?B?d2h0ZWYwZE02a1p3M2RFR2xNQzFvL251VWE0VTdqRjFTUWtCaTB4UWVldW5q?=
 =?utf-8?B?WkNBWVJ4Q29Gb3A3eWhlMTRiYklMek5GQ0duSTNZYVFwRlVGY01TRDE2MUhC?=
 =?utf-8?B?aHlMeDFQVDRmcndYQ3UxWlM5OFBMZHY5OE9jb3pBbW5DUWpFZUxFSGxPZUFt?=
 =?utf-8?B?UGI5c3VWaTVmNi9PeENLWEllYUh1b0puNHBLSnZ5azN1US85Z284MzVLdWVZ?=
 =?utf-8?B?aGJ6ZG92R20rcDlFMkZrVTFoZjAza3lmMnVmRjdyNE9neXowNlZUK3RiN3d2?=
 =?utf-8?B?aC9GVzFhdUR3VUoyY09tV2FxeEpoN29TYlgwRSszRnRnSTl0VzdxQUtsdWZV?=
 =?utf-8?B?cGpLa0svc21sZjgvWnEvSHFYSDZoa1d6eEJaTTNrM3laL1VVYWtvT0p1VWlh?=
 =?utf-8?B?K3J6ZkJpbitzVDJnNmp5T0NyM0w3WWMxMFUvcTlrZTU3SzBXNzk5SWk2QWpZ?=
 =?utf-8?B?K1FvL0Z2SStPNDhRMTllRzJOS1lwL3F5WlVxY3BOMW9wYjMzZDJqMktXRUZo?=
 =?utf-8?B?Z0lBdCszUnNXVWM2KzBRcjc5akdQU2xkT3ZNb1Z3WGc4dXpaemtuaytpdEh3?=
 =?utf-8?B?WGQ2cHRIR2ZGVnh3M09VVHhpYk9pcGI2emNLdzNpbUZQcnp2N3h2azVUdXVk?=
 =?utf-8?B?SytsMm9YYWhKZHZuZFpxczVLTk9xaWlLRU52aXRaeHZJY0w2ajJrTFVPcXZJ?=
 =?utf-8?B?bkFRR2Q3QmFWTUNLcmR3c0dXNDZDNXZaejNIRUVKM2VHU3hDeEo0ZW5xZ2FT?=
 =?utf-8?B?YnJvYjZ6SXhsYTJTQ3laTVBFK0tvS3dPMkF3T3BBNmhLUUJFTEtJK0kxUGg3?=
 =?utf-8?Q?y8TMH2hS91s3PhfrworFLWWJ2tmVZ2dt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUgrVHFmOFh6ZEJYVnJTQkVQWnNuL1RYcjFjN0diMmpVaDB3Y2hZbTQ4TktH?=
 =?utf-8?B?N0ZIMUlTK3FEN1pqMk1ldDZDNUVnbGYvN2NyamVaN0g2MVF2dU9maCt6MkZM?=
 =?utf-8?B?UVpXL0FHc1Q3bTVGMVZ0bWIzQjFITDJqc3AvcmlQd0M4b0cvVXNnNGsra2Qw?=
 =?utf-8?B?QmQ4a0JtNm0yWFAvWE1EZXVTTSt2SXVoOXBQME1OY0RoZHhvNFRPa1dIc0cw?=
 =?utf-8?B?MHhXUCtadmUwdWpVNnA3SVZDL0h2Q3Yzb1pvbVFJSmxHUkFJdU53b0hRSmhY?=
 =?utf-8?B?VGhpZ0poc1hwNkJxNi84RTV1VjRxVGl6N1pDUTVqSTNRZk5HTnVLSTFUdE9B?=
 =?utf-8?B?aHlNcHQvbFpXNmdWTitZeGpMSVRURXFud1R3ZXlGeGE3cExGakI3U3VYQ2NQ?=
 =?utf-8?B?aWpXWVJjamZFQllaTmpueGNJb2g3QlExS0hSQlZjSFNjWXZlcjEwMnB4L1h6?=
 =?utf-8?B?dGkrazQ4Nmg1SXZMQzhVR3lNWWFGQU5lYzBVWDMweTdTZXF6RFliK0VjYTZV?=
 =?utf-8?B?NWs2aUl6eGNiUkE1ckJCM2JOUjRRVms3a09ZQlFqL0kzTitiNjFyRXdZcjVM?=
 =?utf-8?B?a2c5Z2xLNi9rSFlVS1dlTXJEaXEwcUpXTWl6TlZUcEdjMStvR1NhMjlOSTlO?=
 =?utf-8?B?cGhGWi9BNDFJWjdUT3N4UG1vd2l6dmpKa2hPWGFncERGUnkyc3IzaUdIb3pK?=
 =?utf-8?B?ekZzWjVRQkJqLzd6eFJQanpuZjFMMUttTnJoZXdmZlVyVXpxdUFHMXdtWkV0?=
 =?utf-8?B?Rk9EakpIbmVzQnVZaGgyOFJrWGdENjBtb01UOEY2Y1NRQWNSVE1zUVd1TTlL?=
 =?utf-8?B?Z2ZkQjFORXQ4TDNhczdlbmtSZmdYaEk5S2h0UnBlSFRnbUUyUHFnNjRDQ3ZR?=
 =?utf-8?B?dXV1RW4zNHN0eXMvRC9KckFOeDZDb0F0RUdqRVVsMUlhck9CWFhSVmNLTlZX?=
 =?utf-8?B?Z1dHOStnekZnVmhYNmZ3eUo4ZFUrMnh3NUoxaFlMdGIxcnhWN015YTIvTCs1?=
 =?utf-8?B?TGVUT01OSXg1TExLTlZKZDhGY0hCSGdSazhERkQxK01rNzJrcXhFa1ZmWGN3?=
 =?utf-8?B?K3pqVDJ1S0J3ZE9FZ0s1UUdFQStDOUovVHJLZnluNE1PT2UwdytwU0xXem9G?=
 =?utf-8?B?NUdUUjl0b0t4ZnFMV3djcXdmbEl0ZDFZR0pPTnhOZ0pzRHcvN2JoTEphSktQ?=
 =?utf-8?B?RlA2Tlp1OSsvU05jMHNrRXMxeWtLcVBNcjh2NkRIeHphRzZnSUdQVFc3V3ZN?=
 =?utf-8?B?enlzVUdFbDcwSHcyenFwNVpBSDRMbktwaTRVRzRWQmhxOEtGTzlTS2dTR0N0?=
 =?utf-8?B?TGRycHY1MlVYcjQzM1BkTUs1UkpUVWk0SkNVSVdNMnFFeUU3aGY0aVl4Wkk3?=
 =?utf-8?B?UEFFcHA2a2hwYkdXNTUxc2Q5M1B0ZXdTazhJVzRZbDJLVXZza0EvaGw1eFRG?=
 =?utf-8?B?eUptTGRtc3Y3V1YvMWlTSldGOXVVcnNwSDlSWit4RWNUR0FPWDcvNU1zVnNP?=
 =?utf-8?B?dXRSVDNjNlRNd2ltU3BjNUxGYWVjUEI3bzF6ZkZvUHJkTWYrbXIweUZYL1Zn?=
 =?utf-8?B?YnpNRmoyYmxrNGlJR3ZVZFdhOXRhdkFhb0tEaUpRWVJidHBHMEdGc2x0eS9J?=
 =?utf-8?B?ZkliaG9QVXVmNmlVb3RMUFl4S3M2Z256UU5BSml1dk5DMHU0ZDlQN1ZoUVB0?=
 =?utf-8?B?ai9DT0xhWTQ3OFhlay9OS3lJdVA5S2YyVms5TWJMTjhNOTBFVUpTdWJsTW9T?=
 =?utf-8?B?M0FHTGN0QnN3Q0NHMWFNcHJsZGlDV1BIdUlBblNabmZLTXE1SWlBS2IvR0s4?=
 =?utf-8?B?UmJKYkErRDVXcG5OYitaZFlnVC84Z2wyNmxRTWN1NFhNdVRETzQ2UGVGa1Bj?=
 =?utf-8?B?bVpLZE1BT0IyYXBkY24vZzJsVSs3UlBJaWFWd1dpUWd2SlZRU0VWcm9zYzBk?=
 =?utf-8?B?UEkxeUprSlMvUERHUDhSSnE2akZnZkg4YWt0RDdONURUUFg3UlFHcExlbCto?=
 =?utf-8?B?SGprek1pSzRXRDZiYitHQTlKaVZHQU8wTVc2NGVXZmpnWExYdFRsaXI4ZldE?=
 =?utf-8?B?QmFOQ21ZaG82MGdGSm5vTk1ncTFoTTdBaUhxeFRBcmQ5SkV4RW1ZRVJTUlEr?=
 =?utf-8?Q?CqFZKDnfVR+c9ewFtq5SROnub?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6413db6-bbe4-410d-9b98-08de236e7ac9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:10:55.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBdQu29kaCtJnNlkJO4BeIpNWjO+HxvtnivQ1UpIwRRNDBLBfzlKkeJVnp83eFCrAO1vFSnEcGvIrYoW0u4ajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095


On 11/12/25 14:53, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:36:36 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> In preparation for CXL accelerator drivers that have a hard dependency on
>> CXL capability initialization, arrange for the endpoint probe result to be
>> conveyed to the caller of devm_cxl_add_memdev().
>>
>> As it stands cxl_pci does not care about the attach state of the cxl_memdev
>> because all generic memory expansion functionality can be handled by the
>> cxl_core. For accelerators, that driver needs to know perform driver
>> specific initialization if CXL is available, or exectute a fallback to PCIe
>> only operation.
>>
>> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
>> loading as one reason that a memdev may not be attached upon return from
>> devm_cxl_add_memdev().
>>
>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>> preclude needing to export more symbols from the cxl_core.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Alejandro, read submitting patches again.  Whilst the first sign off should
> indeed by Dan's this also needs one from you as a 'handler' of the patch.
>
> Be very careful checking these tag chains. If they are wrong no one can
> merge the set and it just acts as a silly blocker.


Hi Jonathan,


I did the amend but it is true I did some work on it. Would it be enough 
to add my signed-off-by along with Dan's one?


> I would have split this up and made the changes to cxl_memdev_alloc in
> a precursor patch (use of __free is obvious one) then could have stated
> that that was simply moved in this patch.


OK. I think I was fixing a bug in original Dan's patch regarding cxlmd 
release in case of error inside devm_cxl_add_memdev, but I think the bug 
is in the current code of that function as it is not properly released 
if error after a successful allocation. So splitting the patch could 
allow to make this clearer and adding the Fixes tag as well.


> There are other changes in there that are really hard to spot though
> and I think there are some bugs lurking in error paths.


I did spot one after your comment, checking cxlmd pointer is not an 
error pointer inside __cxlmd_free. If you spotted something else, please 
tell me :-)


Thank you!


> Jonathan
>
>> ---
>>   drivers/cxl/Kconfig       |   2 +-
>>   drivers/cxl/core/memdev.c | 101 ++++++++++++++------------------------
>>   drivers/cxl/mem.c         |  41 ++++++++++++++++
>>   drivers/cxl/private.h     |  10 ++++
>>   4 files changed, 90 insertions(+), 64 deletions(-)
>>   create mode 100644 drivers/cxl/private.h
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index e370d733e440..14b4601faf66 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>>   #include <cxlmem.h>
>> +#include "private.h"
>>   #include "trace.h"
>>   #include "core.h"
>>   
>> @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>> -					   const struct file_operations *fops)
>> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
>>   {
>> -	struct cxl_memdev *cxlmd;
>> -	struct device *dev;
>> -	struct cdev *cdev;
>> +	struct device *dev = &cxlmd->dev;
>> +	struct cdev *cdev = &cxlmd->cdev;
>>   	int rc;
>>   
>> -	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>> -	if (!cxlmd)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>> -	if (rc < 0)
>> -		goto err;
>> -	cxlmd->id = rc;
>> -	cxlmd->depth = -1;
>> -
>> -	dev = &cxlmd->dev;
>> -	device_initialize(dev);
>> -	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>> -	dev->parent = cxlds->dev;
>> -	dev->bus = &cxl_bus_type;
>> -	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> -	device_set_pm_not_required(dev);
>> -	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>> -
>> -	cdev = &cxlmd->cdev;
>> -	cdev_init(cdev, fops);
>> -	return cxlmd;
>> +	rc = cdev_device_add(cdev, dev);
>> +	if (rc) {
>> +		/*
>> +		 * The cdev was briefly live, shutdown any ioctl operations that
>> +		 * saw that state.
>> +		 */
>> +		cxl_memdev_shutdown(dev);
>> +		return rc;
>> +	}
>>   
>> -err:
>> -	kfree(cxlmd);
>> -	return ERR_PTR(rc);
>> +	return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>>   }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
>>   
>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>   			       unsigned long arg)
>> @@ -1051,50 +1035,41 @@ static const struct file_operations cxl_memdev_fops = {
>>   	.llseek = noop_llseek,
>>   };
>>   
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds)
>> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>>   {
>> -	struct cxl_memdev *cxlmd;
>> +	struct cxl_memdev *cxlmd __free(kfree) =
>> +		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> Trivial and perhaps not worth the hassle.
> I'd pull this out of the declarations block to have
>
>   	struct device *dev;
>   	struct cdev *cdev;
>   	int rc;
>
> 	struct cxl_memdev *cxlmd __free(kfree) =
> 		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> 	if (!cxlmd)
> 		return ERR_PTR(-ENOMEM);
>
> That is treat the __free() related statement as an inline declaration of
> the type we only really allow for these.
>
>
>>   	struct device *dev;
>>   	struct cdev *cdev;
>>   	int rc;
>>   
>> -	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
>> -	if (IS_ERR(cxlmd))
>> -		return cxlmd;
>>   
>> -	dev = &cxlmd->dev;
>> -	rc = dev_set_name(dev, "mem%d", cxlmd->id);
>> -	if (rc)
>> -		goto err;
>> +	if (!cxlmd)
>> +		return ERR_PTR(-ENOMEM);
>>   
>> -	/*
>> -	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
>> -	 * needed as this is ordered with cdev_add() publishing the device.
>> -	 */
>> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>> +	if (rc < 0)
>> +		return ERR_PTR(rc);
>> +	cxlmd->id = rc;
>> +	cxlmd->depth = -1;
>>   	cxlmd->cxlds = cxlds;
>>   	cxlds->cxlmd = cxlmd;
> These two lines weren't previously in cxl_memdev_alloc()
> I'd like a statement in the commit message of why they are now. It seems
> harmless because they are still ordered before the add and are
> ultimately freed
>
> I'm not immediately spotting why they now are.  This whole code shift
> and complex diff is enough of a pain I'd be tempted to do the move first
> so that we can then see what is actually changed much more easily.
>
>
>>   
>> -	cdev = &cxlmd->cdev;
>> -	rc = cdev_device_add(cdev, dev);
>> -	if (rc)
>> -		goto err;
>> -
>> -	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>> -	if (rc)
>> -		return ERR_PTR(rc);
>> -	return cxlmd;
>> +	dev = &cxlmd->dev;
>> +	device_initialize(dev);
>> +	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
>> +	dev->parent = cxlds->dev;
>> +	dev->bus = &cxl_bus_type;
>> +	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> +	dev->type = &cxl_memdev_type;
>> +	device_set_pm_not_required(dev);
>> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> -err:
>> -	/*
>> -	 * The cdev was briefly live, shutdown any ioctl operations that
>> -	 * saw that state.
>> -	 */
>> -	cxl_memdev_shutdown(dev);
>> -	put_device(dev);
>> -	return ERR_PTR(rc);
>> +	cdev = &cxlmd->cdev;
>> +	cdev_init(cdev, &cxl_memdev_fops);
>> +	return_ptr(cxlmd);
>>   }
>> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>>   
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index d2155f45240d..fa5d901ee817 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include "cxlmem.h"
>>   #include "cxlpci.h"
>> +#include "private.h"
>>   
>>   /**
>>    * DOC: cxl mem
>> @@ -202,6 +203,45 @@ static int cxl_mem_probe(struct device *dev)
>>   	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>>   }
>>   
>> +static void __cxlmd_free(struct cxl_memdev *cxlmd)
>> +{
>> +	cxlmd->cxlds->cxlmd = NULL;
>> +	put_device(&cxlmd->dev);
>> +	kfree(cxlmd);
>> +}
>> +
>> +DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
>> +
>> +/**
>> + * devm_cxl_add_memdev - Add a CXL memory device
>> + * @host: devres alloc/release context and parent for the memdev
>> + * @cxlds: CXL device state to associate with the memdev
>> + *
>> + * Upon return the device will have had a chance to attach to the
>> + * cxl_mem driver, but may fail if the CXL topology is not ready
>> + * (hardware CXL link down, or software platform CXL root not attached)
>> + */
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
>> +	int rc;
>> +
>> +	if (IS_ERR(cxlmd))
>> +		return cxlmd;
>> +
>> +	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
>> +	if (rc)
>> +		return ERR_PTR(rc);
> Is the reference tracking right here?  If the above call fails
> then it is possible cxl_memdev_unregister() has been called
> or just cxl_memdev_shutdown().
>
> If nothing else (and I suspect there is worse but haven't
> counted references) that will set
> cxlmd->cxlds = NULL;
> s part of cxl_memdev_shutdown()
> The __cxlmd_free() then dereferences that and boom.
>
>
>> +
>> +	return no_free_ptr(cxlmd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");

