Return-Path: <netdev+bounces-240019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C58C6F52A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE5D53857F4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9496B36656F;
	Wed, 19 Nov 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qya0VrTz"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EF1274B5F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562241; cv=fail; b=XO/6BE3UJBmK00k7YaqMdLK8m5sSOvB3ChvqKgQJNjw294vVkUYFYvsCkQFaJI6F9ygGhRtCfeRjdn4PNvlb0es/OX1DMrfmbFqKkxe4MPREADaNiH/eoTFgxgWzNVZE6hEW2Ez8G0MkMO6f5AFU9PUou4x9UIdO59Cczh0s3Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562241; c=relaxed/simple;
	bh=8TCZVEZ21hYbryo7gJU/N3cdoN2QPCzats+pIwVkvk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mK847l/rcKU2xroLjfyGcsTBLN5VMHpfssyFNdPKz6SwmenVpSfEgWlsXot7pKdFeocS1RbZzSkxqs4j70F1VSAkMhYej61ISnpAhajKThov/fjDi4EkWoln/sB9KVbs7POSlLROSvooldqHqxPbTTgWrswn3P5S1ClxfnwbFCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qya0VrTz; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLfkq0btGQiZeOtKW1kk5Uh6r8QMNzhT7ASpPsiC2l1jQ1baKZnrisD6AZ6Pm973HTyqrI4teqk75sJHSG1B1rV8siim+IWgKHohPjDdxuxPtBhxcb8NeXYNF0nys195qjHJiG02XhvxchQSkox1RCKDE7lWK6+HSq8jMcx9Cny8WV7Wm7CeP3+BTGMT4tm+Br2v3hkvHeSj34RT7HUv4eAj+Wck7BxE7OCOY/P5sILvP0fVoQ3umVl8hfVooVy6GNmJRKH5pyvLoKjAu2lxe8tTw+lVBCw9ywD86T/nFSGyKR0apZeToVsfWiJ0Ud9i7VFVkOEVs+ot1otG71nTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFva/56UK+PtWt/zFgy8+H35f8tsYBdrhURljGPieas=;
 b=EpjrGbunyz53talPNy1SayNoIoGP+ZxacvH5EQi0OmjlZJTps+OEYS3KIWoGqxZsbvJswLl71wxpTinZkoPFI+fpCsDZc0A7M44d+n6hjFLhBOld/mzzErukLG8t3ELlt2M0QBZquZrIuKnVvp0Q3XlRNS8laZaem7Nm5SNJkHmEeZjYaIjxIw3CXm/6rau9tpaPJDaNISh/wFY7Chch1+P8Px4NisVTEKWh8VwwoRagecbBomKs0s0zAhzWlU04E0LqoDj9CbqIhBJA0VtwOisFkdr/hpfPuYv27+VubM3FHUbXkPEH3dslG4WK8pYb24XZ4EZbpDMsw0SP0ezYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFva/56UK+PtWt/zFgy8+H35f8tsYBdrhURljGPieas=;
 b=qya0VrTzgDzVnwPrqlzFrlKRmsLEw2tIP0jJ4jaNEIAQu3ZvwI3SqBf4ehBy8QMH5/FJzqTMrFD57hG5/mptgwCmQo8TDlo3m6NAU8HS1kXbP7LBpFYAe0KL5GomrH53JumWUvY3Y/Os4iq8adViz9NAflf/RO8n3AxeygeO4BMQs62qXSAzDXhwbmFMTOxbWyys6ofpiK/piNMTKY2d4ItN9OjvFvwUJizQ1v7Na8VR878Q44hqIJ9qW71Lusq/rjOTDiZAyDBXhvVAU0IxbH0oaZgXpAUG1A+7V9K41TNtXAursnZUZn5yZan7q1efexndkriC5NaNSrbpZgnKoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 14:23:55 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:23:54 +0000
Message-ID: <36be8055-bf40-44dc-9dcd-2adfed2a3df7@nvidia.com>
Date: Wed, 19 Nov 2025 08:23:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 01/12] virtio_pci: Remove supported_cap size
 build assert
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-2-danielj@nvidia.com>
 <20251119023725-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119023725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:805:f2::14) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: b8016aae-9118-470a-9306-08de277744d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1NtT1h4V1ZqcXcrbFE2U2N0RnFYVWFQSnNacUI1MXB2OXhGdk45aXNOUnJs?=
 =?utf-8?B?N3lUU09uNktkSlpleTBoRUNOdFdWTDZjYXV4aG13RWFEQ3B0bXJjWnY0cE5P?=
 =?utf-8?B?R1lUcTAwbThKbGNFSlVxRE9ldjdEUmRDQ0xiaTRCMWJBaHYvNVpWQnJjVCtQ?=
 =?utf-8?B?Zm1iNjdLUGUrUDhSZHlXdDZWTG1RL0h1ZmJGQ2gxMUFlTTdES1lka2FxRnh3?=
 =?utf-8?B?THR4RDgvcW5ibjNUeTJxSjRwWHE4N0sydXV1L2dySjd5TTE3cnF3U2NES1pu?=
 =?utf-8?B?c1NMNFRxTSs4d3JiQU0zandZcWtwM2toSlhSbS8zbXdiRUp6YlZXZUJNblZR?=
 =?utf-8?B?OFpwYXYydnQvYnNRU2xCOUE5VGZvdTZMbit3bW15cVJlYWpUeGp3U08wcVBq?=
 =?utf-8?B?VHdZS1dBOUlzR3FNWnRSTUFZYjE0MTNTRTJzV3ZSS0xUUlkwVS9GWHFCVVpV?=
 =?utf-8?B?MWw3aENyV2ZrQXEvK1JhREh3S1lQaHJsZ0hvQ0ZDT21zR3dEcnloeWhST05R?=
 =?utf-8?B?bnIrc2pxQklxRjRESWZrbEdqWUR2YUx5bEVFaHdxYUpvdGpMbmh3WThkVFZ3?=
 =?utf-8?B?UmRmb3JyWkNJTWJQUEJoOWxBYmRLdlNHRUJoODFyc29nZzlOTXBsbTNvU1kr?=
 =?utf-8?B?QkZNcDByN2xHd0o4d2Jyd3VEVDFxNnBadjlEU1BqQ2lhOFBrcnRIMnBOeHVu?=
 =?utf-8?B?UERicUM1WmpyYjNHclB4YjhUeUJnMkxYMGtZbmtyZWcxakVic21WRjFudFFS?=
 =?utf-8?B?MXBTV2YrS1g1aVA1VDZmcWUyQVhudDk2M2JDQmFBb1hKUER5Qm9ieXB0eEt5?=
 =?utf-8?B?L1VtRWFYb1lsSWNLNFdPNDdMMEg1Smp6YjVXWnZBdTllSWZ6eXJVL2ZIamd2?=
 =?utf-8?B?V21KeGdMNnY2ZHpSQTU1S0pqY2ZhcEVKTGhUTUNCdmNJRHVjcm54WmtKeVE1?=
 =?utf-8?B?aWdOQ1YrT2tyaVJidWxESnVqK0MvWmkyZnlJcnA4bExXeHpERUVaeUdOQlJs?=
 =?utf-8?B?WllKMWVlWWJDMEp5WFJGK0xaL0VDSFc3RVZjc0g5ZXk0NkdHcVlBVEtickhV?=
 =?utf-8?B?TEdNcUNsaWNKVW5KMzRWVDIrd21ISlhHOEJIWTJHWUM3Ly9uWUxTa1pjZUth?=
 =?utf-8?B?elFnZjVxYVlOSHBESGpxblhHTVc2NVpLSHVlRDM4cHVVdnBlQ0pOOVlDc0tW?=
 =?utf-8?B?UGx3VkxEckZPUVNtQ01vazVtdHMzdHhuenlzSzNwbEdSa1hFVlFsRUxpMHNZ?=
 =?utf-8?B?OEllU3VIR2VKVXVqbUxRMm43ZzJaeE5vbHpqYkMyc05CT095RjMvTEVObmdw?=
 =?utf-8?B?ZC8ycGVKTHlBaXJlT1hlOVY5U1Y2SEd4WGdwUktqTGtPYkg5enp3aTJ2M2RC?=
 =?utf-8?B?U2FJS055MytHT01FcDNTRFR3UmNpYUI1QkpiSTN4UXMxMFFoOFRycjRCREJY?=
 =?utf-8?B?TENLZ0xFdkNrNnMreFRwY2FZNzE3OGdrQ3ZUVmlla2x4NE9kT00rczh6UDVu?=
 =?utf-8?B?ZWJFOFBGWEo2R29pNnFqOEwrUUFlbnVsRzB6YUhFUGFIc2cvUmNTaXNUc2du?=
 =?utf-8?B?amQ1bWdLUVpLak9MaUsrMHNaUnJlSGRrZEJLdG5rNk1vcjZBelRvUzdkNUJW?=
 =?utf-8?B?WWFoRGdNTnN6cW8vVXNvaFBVVFNoeFlESmtMb1lGK3R1a1BtcXlFQ01rNjJl?=
 =?utf-8?B?cW9LN253UjZoUVN4VlhNWEkxZFlLZ3NqN1dvNVlDY1hQcTd2U0M1bHFHNWVX?=
 =?utf-8?B?UTZkQmFvQ2NKaUpIdnFrS0VLZzloMDZrc1RBcC9Jd0pTb3ZIRm5CY0xxUEFY?=
 =?utf-8?B?QnpYUVdycHFaQkZPZ3IrT3FEMndqa2UzYllrRzZzZHhwNG5KSGJzTDFKdlhn?=
 =?utf-8?B?THN2eE1kaDcwTHVMSmxqNXpOa3djMHJPTU5PVExhc0s4YkdQWHRkVzB1Y3g4?=
 =?utf-8?Q?etmndMQ8k7vMSKkShdwcmc6ozShvhobJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUYwSmFFTDVoUWlrYzB2a0x5T2NrcVBuTDJWSGxVTHorR1U5aC9hbVRBaDcx?=
 =?utf-8?B?enNla005Y240WlpoazlJS0drbjVzbjNVeTV1Q0IvL3Y1a1FIbGJMZVhaQnI1?=
 =?utf-8?B?Qm50cXV5NTNQdlZTMWYwYmtDU1VEUVE5NitPemhTOEl1NG1HSS9NT256TzB3?=
 =?utf-8?B?U1FGeUdVNVVRbVBhVHM0RiswS2lGSnZGVlpnSXN2RGV1TnZ6clJ5TFkrRzNh?=
 =?utf-8?B?RW5KK2NoUzZsTkEzUzNqdDRVNHdtR2thNkE5cVZLOTJDN29WYnBCenREVFpU?=
 =?utf-8?B?cFU1Qjc0NnhMN0krRWhmeGhSMXBKZEg2dThwTU5IVHlEYU9EN3lLRW40N2N0?=
 =?utf-8?B?NzJaQ083ay9HenNSRythUngwMWpZeEZqZXhKVkZMa1pkcnFCWGRhZTBMWmo3?=
 =?utf-8?B?d2FUWUdhOCs0MWJ4U2ZFVXkrUFF5VzkwNUc0ZHNFSXBKUktDVFdlMEZ1QWh4?=
 =?utf-8?B?ZGhVWmh4TDgxdTVHYVpnQkJLVk9nRjBRL3ppd0NhYVJEY2djMThPbDRhK3RD?=
 =?utf-8?B?VENhK0JOTGkrckxia1phaFVUMzR1dmdGckpFcy9zMVBTQms4SmJMT0JiQmtL?=
 =?utf-8?B?UUxzWm5odkJ2bG1YeWVOTW04S2tnekZMSGRGMFJGRWhIeTlxbzVSNHBoNXl5?=
 =?utf-8?B?S2QwT3EyZkF4eUt0Ull6ZFQyS1B6TjFFWnpGK2lmTjNtL3pKU2l0Z25wZ0dN?=
 =?utf-8?B?eFZmbVFQK2w5SVZZbEFMd1B3VGE1YmlEWklldHpWSkQvV2ZleFlUZkZlMHNV?=
 =?utf-8?B?dDlhNHJQaHNKRkNXR1Uya1hyYUp3UnNrTlZjQzREYnZEVEFxK0JVSVBaRzZE?=
 =?utf-8?B?NTlFLzhWV3VSNVVUVlhFV1YrbzVaaUhhR2N3ajZGUDkySlhOMFdYVEhTZ05z?=
 =?utf-8?B?OVN5N21XTGdPckpYQ2l5R2tVN3duMWtDSWxnN3c1bHY1ZENtU3B1Uk9EMThk?=
 =?utf-8?B?TEhTZDZsNEZOSDUybUk5czg0QlJKeDJGMjB1RkJxSzVmaDVzVzNRL2l6MjQy?=
 =?utf-8?B?Ryt4N3E1N0RPVkpnYllmTGVhQU9DY3UvNm85OXhnbHVFNnZxZjBRNXpuZWF1?=
 =?utf-8?B?MU5pNWQyS0RpdDlrcUh0bjBjMUpoSkluWkZJZTRGdFNEK09jdTJMUVlpUGdj?=
 =?utf-8?B?VloyRGpGTUpxWUpseHJGL1V3eWpieEl0ajJUbTJPck5NUUlKelFZank1NVpR?=
 =?utf-8?B?OVlMV3c1YnVVL2dnM3NGNTVCS0M1cGFkTUZKMElvRFIvckQ1eEo5YS9IVXhW?=
 =?utf-8?B?Qk9LVGIrbDQ3KzVzYnlaMy9kS0lkVUJVUFRYdkpvV0tHTjJaWUo3MXhMT1ZZ?=
 =?utf-8?B?RWVTamVHUjB2Yzcxc0JrdWIrRDBTWEZtb0VIWmd3QXNNSEsrVE9nT3N6dTFI?=
 =?utf-8?B?cXFNeFZaaGlqMlVzL1gwc0FPK2RvaXIvVXJYWHhkQlVwY2pFa3pmTm5TTkc2?=
 =?utf-8?B?SW9lRXpYQnRGWG94NDNUdGlac1hNcWNML25yamU0OWtCOHFRMDhhdTdRLzVQ?=
 =?utf-8?B?cjBDQ3MzZFM4OWJZWDI3WExwVFdMWVhFa0NMN0ZudzRMUVcvaXF2cnF1N1Iz?=
 =?utf-8?B?Q2trOG1pQzVVUjl4QjhrNXl1VDd1blhjSmZLYVV2ZFpGWTdLSUFKaUJZZ292?=
 =?utf-8?B?UVFYVEk3S09ibEFWUUhpVTgxY3hybDRhQ003ZG5DdVN5K0NFU0hKVmhHcXQz?=
 =?utf-8?B?YUZhd0h0SnRQeXd6ZzJNYVlFWUk0M3I5K2pnNEowN0dHZkRUMzIyMHpRZ0lY?=
 =?utf-8?B?OWpqMGlmVDhQdzNOcVJZU3pXSGswd0paajQ1SlAreU96eGdJMnBudWx6eFdH?=
 =?utf-8?B?WkhLOUxSWGZkMzRIaGNtaHNINEcyQXhXU083RGRVUEltWlZzWHZZRjR4QlBX?=
 =?utf-8?B?dGQ5clptRHRUbmo0c2w0TnlVV2lpNCtBQ2FCRVE2TWtKV0M2ZkhQMHA3Y3hv?=
 =?utf-8?B?Z0ZzejJ5Si9UTVFSd1dxSXN5RzZ6MEN6clZTVlNKUGcydGQvaHZvaHA3ZnhZ?=
 =?utf-8?B?WWdGTXk2cFBVYVhSQ0ZLem5xa1BHV2UzS296YzMrSlFqbXJHRzIxcjhEa3Nz?=
 =?utf-8?B?aUJtMnJoUlVzWnlRWGhDZkVoNHFpWmNqUGYyT0pzRWJrVVcyV2wwOHk2a0Fx?=
 =?utf-8?Q?OJcKIE9aCxdAJ40W3BF8M+YKF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8016aae-9118-470a-9306-08de277744d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:23:54.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbZ2SrTc8oODBmwzk/J/wRV9NNZDktereAx1vgQ8xjD7ukZfDLZDtk5aXFbZugDKBhnjjRPAIPuY6CG4+heyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

On 11/19/25 1:38 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:51AM -0600, Daniel Jurgens wrote:
>> -	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
>> +	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
>>  		goto end;
> 
> It's ok but a better way is
> 
> data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)
> 
> giving the compiler a chance to do the byte swap at compile time
> on BE.
> 

Done

> 
> 
>>  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
>> -- 
>> 2.50.1
> 


