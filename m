Return-Path: <netdev+bounces-136889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6D9A3826
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F59A1C21480
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BE18D65C;
	Fri, 18 Oct 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXghQxu8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467218C34C;
	Fri, 18 Oct 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239102; cv=fail; b=WrS/ET2O0KXfFtNdFPoI6+SO1CcyF+Gty1FTgTbOzosLjxW2/dd2aW67wlSoaqMImVjaHA5zypHCtqB+QQAdjFh0i8PfM0eO6/mDNeC5crd1Ky5IGWGuDvzR1Xjg0om8vc04DS093Mj1UYcD/K0KPhx7cvUt59LXWhmTvMWxbHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239102; c=relaxed/simple;
	bh=0FAw/HCJhhs+zT1X72Pyg1Y6a7VfV5FzfDkE6Ubvx7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTATbvd1sEm4t+ki/yrRJ3HEpRhOzGpWl91BzD5wXJKJ6FZUsMKLJtI2uS9K+WHyHbugmp8VAGX/6up460DrD8xYiCaOJMGYDJpT0AEGDSmXXN9jCs9FA8ehtgK1taZthPYDalJY0Iu+BajMIYJUWOO7xEoMBz7K+wg0U8Nm9xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXghQxu8; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Thp5g9QPelTOiaB0a7jWZyXWvqQyqZ5g+8G6VanY2oNRpLZ5IsiG7qwGDtAaWBVrQcUIvdBOGAgb5UI/DYZxhREUNJy1KH8SUR7ZHCY3V5oujFOo+w6Pei+zRTbkoSXsFUSVwoCHZOJPL53sdbVFcB4TIOLunNCkKlGS5iu4X5aByD4bZukmVYBgaeH5i97pqN/mANXhaGwXd8HB+jl8jGAPSt7S6eyWChCxMKqvtz/K5S+g671jWARgWVgs8UIgv7R7ssa3PBEKzXIElM/hXuvX2Tw8C1tEpxOwlj7kBYbFdUd96H8UafXt4AXgEMiE9C1HuFMZo21c24pUEVKEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6m7twCzam9PykR90szhmiEetd0nTO8b/+shRhgfa+U=;
 b=FCAWgLlVk2B/KFwcmFymO+Ty6d9KWWSBmnRVf2r33KAh4PNoAQXufWrE+KDen+4LnE4xXnNiZ6LCKzXHvzuaZlBVRhwHfYX2zunl1wYGIRyiPCmk+QYripVOZ1vu4BfSq7Hm/lLgoEMjHrqhtHkjzJoXDAjfr/259NlPy+/PMCvkUCQs7XHkpCVIPLvanKouI2Jeq4v2l4d2cvYv62NObovZpYEDZm3J2MEz/tZlRwcF+GxD3TmUD4hF8Ssal+nqbSZqMlp3bV/QlHlKTZxV9rBglWAjOWuByjNcEZkj03Cr9R67U67CyxeWkQRd9gKVBTQsPN6pc7qeOSqfGI7KIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6m7twCzam9PykR90szhmiEetd0nTO8b/+shRhgfa+U=;
 b=wXghQxu8RSUH9cYLqvSsRZv/HAH0Ip5RcLVT4ZzKSxgl9aO+26P2g9GQ/zi0Y9u0iBSYdIIhS0lOIXfTiNkY7AKjEixAg09q87nGHtIjmnrIMz8/czxgnf+3NaK6lPLd676enYEPDtUYAcrcU52qm8PUfULD3g/ThwQklSrRCDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 18 Oct
 2024 08:11:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 08:11:38 +0000
Message-ID: <9f1d0a16-9c81-9165-8341-bc2982607f65@amd.com>
Date: Fri, 18 Oct 2024 09:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 24/26] cxl: preclude device memory to be used for dax
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-25-alejandro.lucero-palau@amd.com>
 <ae59e9a4-a4f1-4839-977b-b667d927c647@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ae59e9a4-a4f1-4839-977b-b667d927c647@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0215.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::35) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: c9557d96-f0bb-412c-6705-08dcef4c7d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2hFbVFOZmFLZUhndGlhb3dJSSs2MExBYWpSKzd2K1RjODRvU0dYMXJMQkFL?=
 =?utf-8?B?cXhZMjZsekFzRkdmZlZ4YTdudUVtQVNENjl2NFdaVE1pVk9hRHBjcUpKVVJY?=
 =?utf-8?B?M3R6aUZEdkY5dGI1ZXVWYlY4M3F4Q2Yra0lEQUJrYkZmTExXcDFjVU1xMUls?=
 =?utf-8?B?RzF1dFM0bExXaTJxRms0UnBGd1JIaUFMV1paY0RvSUZ4L2wrSlZJUnVxazlz?=
 =?utf-8?B?alpkamNOcEZLeVRnMnRMYTMxbVdoeGJEaEE2ckMvTUpDS1haYWdKQWsxUk5r?=
 =?utf-8?B?WDhxSDNlK2NLZ2poSk5yUGx1ODR3c0pMdExsZFZGcER2dkkrdEdjUE5DTlN0?=
 =?utf-8?B?QmhLWmN0LzFteE92VjZiSUpqYnlTNmZpNFB0Nll0WXNQeDkwaWlxclNDR2Yx?=
 =?utf-8?B?Nm9pQ2VYNUxSUEVkNTYyb0dFQmhZalNTT0lVOXEwUFoxSTRvaTFaQmpNOGNI?=
 =?utf-8?B?NlV5VkM1Q3FkaUNXZEJCNi9aTTN3L2ZkTkdkSS9CaWNPT3pUemw0MHFzaEp4?=
 =?utf-8?B?TnpTYkJtR1dtV01yUXYvRkYxeDJpa290bnhqRXBWK1FLdzNuTEhyY1loK3dQ?=
 =?utf-8?B?cnpKTVR6SUNsOFZRUWV0VGpNTXRYMXE5dkFObjV4L3hIakVYanptS0Z6NHJJ?=
 =?utf-8?B?dENERm84SUZQdWlaRDFBaXJ0MHJLckI2YUh3Q1Z5WHVkYjNtaysxVklNOXFr?=
 =?utf-8?B?eExoREppOU5KdGQzMUwzdllydHI5Skx1a1gwWGpkbVp2WGdMaDU1Tkx5MTll?=
 =?utf-8?B?QVBOQWl2SGJDMGhXRkQ3dVBxaFFFMFIyd1lod1JDa2JKS0dIRlN6VmhqdjFU?=
 =?utf-8?B?TFRsVUdxMWVqMGdsRWFOelRUQ04wSjd1VlBlZWIvaUVGNTNadEkwd0dNcjZF?=
 =?utf-8?B?M2dPczFabURaQk90ZE4xdGE2cWc3RDFOdDk4UVAyYm9Gb1NSbDRrYytYc0sz?=
 =?utf-8?B?SlJYcUFmNnd3QW5HdHFteDlENUUvVjBBNnZlR3VISDN3OURuK2pENlRINStL?=
 =?utf-8?B?SzVQZk5pNGtkT25qanFBWCtTUkdzQ3JjM0xmdnRKNGZKYWpnT1lJbzZOUzlF?=
 =?utf-8?B?N1V0Sk9KOUFsS2hQbkNPc3EzdkUvNmZ3c29MS2JzOUd5dnhhZTRlQ2hsL2Zh?=
 =?utf-8?B?SHBLQ2NOTTI1cUFHVTFlMlpFdlI4THp6MnBnVEZJQWFKS3hSVFE3ZjdRbU4y?=
 =?utf-8?B?RHRIQWhqZEYxTC9sa09tVjRIZDJOMnRxbG9qanhRTFdlaVlQOXdnQ0lPYUdX?=
 =?utf-8?B?eEFMZDBwc1FZcENMNm0vbUVHTXI5MEo4cDFzQWRuaTFKd29PeFZlcjBySVNY?=
 =?utf-8?B?WmVIb0FVUXRRbHBhRjRYeU81STdDenlUblNhSzNTVytLMU9kajh5S2FoTGtw?=
 =?utf-8?B?em1ieXJlQlFncTU4REJJK2VXY1VUZTNJYndvZGxlcHhnVWpNcU1lYUk4dmpl?=
 =?utf-8?B?ZGxUaDR6OU9BeHVWRFNYRUZoTjhxOGZqdVAvNnBiRlIyZnhwUG9LU0VYSC9o?=
 =?utf-8?B?ZHVDZERMRGUrdXBON0trR2kzaFVCbXdjWkR4MWM5TllwZlNNWlZnbkROWjg2?=
 =?utf-8?B?azk3YkN6bUgzUHFqbEVPemcrRld3cnVXSy8veG5pNVQwT3JvYjVldjdLL01H?=
 =?utf-8?B?RUVBUEZqQnkvOUExTURVTmVLd1ZaN2ZTcW02MkNnN2xCMTJ5ckxoeWVFVlE5?=
 =?utf-8?B?eFlmQXFrdm9IYVcxN2NwemNLZ1M2RVZUMUtMcUh3a0pnN05mUGJUdEVYc0lj?=
 =?utf-8?Q?KJKyDPz/jIFVoQrM+iWiNYXy3nI1SrwUQtA1WF1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXlzUW5ZdTU3Wm9GQVlNSGR6TlFQTkhkR05Uei8rTGdsU0FoV0dTbDZIYlJ2?=
 =?utf-8?B?cEdwNG54Nm40eXdITXp6cjJ4NGMrelg2aTUrSEZPdFVxdWtSMzN1UHlGc21h?=
 =?utf-8?B?d3k2UFJVVktaVUl3MnkwQjJwMFFkQWJlRmlVQVdaV0lXZHN5MmxyazBVL3BZ?=
 =?utf-8?B?VjVGWTBPZlYzdHZ4VkNGcnI3REZSZ2lNQWNZS0RCSTdkMVF6L2drbm9tTFNE?=
 =?utf-8?B?dmJ3cHNBMVAxaW1iMnVjZGN0SU4yMzE5ZXFyK0VINXdCYUY3eUF6aldkQmVx?=
 =?utf-8?B?VUlhVmhveUZlaWZidUFOcFRzTmd4TlYxN2E3SXNjZU1RaU9hNjNPY1lBTFlN?=
 =?utf-8?B?cHNzWURiaGJ4RDBRZmxrTUJIaXgvSzFlVnMrdUIzNm04UWNvQm5rRStGcy9Z?=
 =?utf-8?B?WjBvdTlIVzhybkZRVXRqdDRRVEJqWkE3T093Rk9OU1FwVkFQMEx3UlhqcU5v?=
 =?utf-8?B?a0RySmdJTTB5V2R2SHY1Yy85Vi9RUzlRTnRuSGpHTitVV3FCbzV4NVJ0SmNU?=
 =?utf-8?B?aUpMVjdGV01HR3UwM1hpVHZHVms2dXJURTBGazJvSlZrbzd6c3hGYzIrRFQy?=
 =?utf-8?B?Ni9EeW50MVQ0WFJFQS9Bb1RWRHR0SGV1aFRHeFc0bmJHVVRIMkszZy8yUEFh?=
 =?utf-8?B?SGdZcEZ3dUNyVjNkeGJKcEptNi9IcDVzM0VDZDl6eWpYRUtiYjI2VDRSeDlX?=
 =?utf-8?B?YitTZ1lmOG9YK0dlSzlPY0UwWk5yKy9ISG05a0RYZkJjRXBBYk1CU3ZnTEVD?=
 =?utf-8?B?R2xEQVZlRW5rT1F3VlBMa3hyMmZBczhldkE4Qm9xcG54dlZNK0IvdDVaNkdO?=
 =?utf-8?B?WEtOWThRUmVlQm1zaWxRV2UxVW43OTlWSWQrZlFlbHoydis5SnR4REVtOExv?=
 =?utf-8?B?RGFjb2VHUWo1RlRuVkMyT1hIWXpjcDVDTXU0eGhyS0doVnRBQzNYVmUvelBJ?=
 =?utf-8?B?cGF6bDl6cktrVVlxTWNmT3VLRS8yYkNKclBQMStBM1ZWcFFhWXozLzE4dy9K?=
 =?utf-8?B?WFNrcG9NREpWVUpFVnVOa3RqdHA5dkxQaEdGbEJudEFURjJDdkRhVWpnbGdD?=
 =?utf-8?B?K1BuY0o3Slg4SHZvcTBLRVZlbEs1enhoQXMrK25Jc21pTTlmekVCZGRsZVJk?=
 =?utf-8?B?VUtPUmdCK0wrc2VLc2ZPTE9DNEE5UlY1bzV3NWdoUkxGMjJSeCtBcXhxS25p?=
 =?utf-8?B?MGVlSW9SM0R6L0RnRmt0T0VRdWFnNnI5NENCM1lWOU5YWDhES1NDZmx5bUM4?=
 =?utf-8?B?dmU4TUNyN0YrYjFqSkxUdTY3VDVrS2NYUHBsZW1PUDhsamdDUkhnNCtoZzg4?=
 =?utf-8?B?WklNR3I5Ukg5cjdoemhoU2V3bEVCN0FBNHhhNUQ0U1NpNS95M1h2SFE0dTd5?=
 =?utf-8?B?enVrMmVLQ29zbUphbVlMSzZWc1gxR1FQTFFrUVB3dFpOUW5jSG1NcU9CcXR6?=
 =?utf-8?B?cDBnY0FydmZleFRtTEc4OE5Ba21YQ25aL2pQWWQ5dURMRnFWY3lxOTFZVU1H?=
 =?utf-8?B?VDhQZkgyYW9YQng2M0FIeWNZVzdoR2JEVXRhdzBYVGVra2J1UUFVQ21XNExi?=
 =?utf-8?B?Q2p4elUrL3g4SkpqUEZyb1F2TTVZdi82bWdvajJpQmlwT1pkV3U2K2NmMzYz?=
 =?utf-8?B?dnF1WnhMOWUrdWpyUWNva0NLNjNzVEk5bEFabjBGUHlqclBFRHFqRE9sTW5B?=
 =?utf-8?B?czRKTmxqY09zY1N0MFV0eDBnUmhySm5TN2x5MWtHSnVzK2hMTFRwTHVWVmRm?=
 =?utf-8?B?Nyt0TXE2VVhOakVtRE1saGJ4Sml2NlNQZkoyYnZpbXhYcDk2dUVCRitMUkFF?=
 =?utf-8?B?N3JXVmZsUDdqTXhWZkZmYXhyaE84WWludmdkZnN6UmlwU2ZSZmpSNURSM1ZH?=
 =?utf-8?B?Y05mS0c2Y3Q5c1pJWm96Vno0RHIzVmJYbzZseHJzZUhPQm9mL0JocWRETE1U?=
 =?utf-8?B?OCtLV0t4cnZodVR4SmJNc1hITG9jQy9uUHdFempLNGxaSytQRGNDM1hUa0dn?=
 =?utf-8?B?VG5LVllZOGFoM05wUzUxeitobzEreldUTHBsazNaZ2RzUmprdHRKN3krL0gr?=
 =?utf-8?B?dC9VZ3ZaUmRDY3Zhdm1KbnNzN1crZ3FIZVNObkowbzhhTzhRMGU2bzFibk4w?=
 =?utf-8?Q?V8VFD+QjZrMvppiQZg+Mrjb3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9557d96-f0bb-412c-6705-08dcef4c7d4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 08:11:38.0808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdpAhr1vRpo0P5hkCXffz3rtWWqmJoCE+eWfb2oqmHvtvs2E1z7Ylk4kuRt/g9QdfLMmQJTjokKSMhaL7lhCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747


On 10/17/24 22:50, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses.
>>
> I disagree that this is a valid assumption. I don't think that the device memory
> should be added as system ram, but I do think there is value in having the
> option to have the memory be available as a device-dax region. My reasoning here is:
>
> 1) I can think of a possible use case where the memory benefits from being user space
> accessible (CXL memory GPU buffers).
> 2) I think it's really early to say this is the only way we expect these devices to
> be used. The flip side of this is that it is early, so we can always change it later
> when we start seeing real devices, but I would vote to keep a more flexible structure
> early and if no one uses it oh well.
>
> My idea here is that whoever writes the driver indicates whether they want to make
> the device memory device-dax mappable, or do it all manually like you are now. I've
> been working on a RFC based on v3 of this series that has this (as well as the
> "better" solution mentioned in patch 22/26) that I was planning
> on sending out in the next week or two, but if the consensus here is that this is
> not the direction we want to go I'll probably drop that portion.


I understand your point and I agree dax creation could be required or 
interesting for some accelerators.


My experience when testing without this patch is the system is using 
that DAX even without any specific user space app, so the system was 
crashing because the CXL memory backend was not doing the expected 
thing. That is exactly the same case for our device, where memory should 
not be used except with the right format when writing. So the trivial 
patch was to preclude this dax creation for an accel/Type2.


I'm not against adding that flexibility now with a flag set by the 
driver at region creation time, so I'll add it for v5 if none is against it.


Thanks!


> Thanks,
> Ben
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 04c270a29e96..7c84d8f89af6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3703,6 +3703,9 @@ static int cxl_region_probe(struct device *dev)
>>   	case CXL_DECODER_PMEM:
>>   		return devm_cxl_add_pmem_region(cxlr);
>>   	case CXL_DECODER_RAM:
>> +		if (cxlr->type != CXL_DECODER_HOSTONLYMEM)
>> +			return 0;
>> +
>>   		/*
>>   		 * The region can not be manged by CXL if any portion of
>>   		 * it is already online as 'System RAM'

