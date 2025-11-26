Return-Path: <netdev+bounces-241828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C786C88DDC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5D994E3D01
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2ED3112DC;
	Wed, 26 Nov 2025 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YQA3ioFt"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AB24166C;
	Wed, 26 Nov 2025 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148157; cv=fail; b=Lm3KerYEFKq5d7eI2NTRfvrbrq+yunb7BkQzRN1ma47M0lv2f4ZEKsK4nwWU/UGEcPiT6kXvebc7e8wmCUoUydOctHDsYx/LreiU8GKwnNAnqjKoPct8XG4XhkKWK66nvOdYzP+41+TpZXrmigy2Wh85DrlhVJWlBZPHQcEtV1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148157; c=relaxed/simple;
	bh=zLLkOdXha8CIkQJ2XmPe4rwAm3TocQvm0Rw057aTivc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HL2PVBQVft0azgf7ri1gf/S0G6gvpHhJKEau7+3D0Kk+GH21flCiYYqf4+/cBviR81dpQyAUAhskM7mZw4q2oNBecDLMrxD1MZMMDAhu5E9IxCu5OjErmDH7LuTvZkCel9fjtbYYhooDzP/HQUb3jZf/xzXGoDeCC74++mq6ORo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQA3ioFt; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpJm2yITQiOuku8Y80K3EN28Ts3P+iN7ytfK3iH45TT97aakEhf2vT71bYLgfa51sP+jqn+Ave3sSUxHikcZ/d9R7afLlSZ2owdQ3a4rF8ytLKTMBUZ6x41B0fNg1Z+GB3PnfJm25lnNQPlOPn5Tb0YIUpOIT+HuUSiAdvFZLi8H1fhqJ1ADE+/r+rK0nrbBN6xP62UqEy8bHOgU0u1ROTiee1gyLiiwBr9Jzl8gi5AOZf1n/9lm2eEnTCUj7reH9MGghuxHLOMsyCOrvGpnM5tWeXHTNvj4eaREiZ+BQXbUJTGE7IstGbeTPi5KfcLj1pPzylcplrXTEgt+InJkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsltPpmQZr9KAAlOafb1g+xggfVHqZv/tz22snXHza8=;
 b=jF4Ul1omziho2r7xOyFZgcEk7jqlnAjXBnuC1kGjgEUYsx5/ksJs6653kbPnWNeMVvH/4ZRPMrFzRanXsQqnZhuqooNJF9/hOyRaAwM5QdTKZ3DGRpRNetBa47kYDiWnvaLNj00u3vuCt2EDfVwpw2ViuNqCGTAsO2hvXvbBlJkWXlqoRQfLrj0IBZV55nDIjZpwNM9EZ8JojRI9ULGc9NM6mxMlK6p2VwN0q2Bx6joItyq3AdL1nkDY86B9lvHC0bFUdQR8SaOFwaLQhby4fiNnGK7nkils9bMJ3fofmKwQI9vjkY/WrHYBMDT8fEW+uSZYf/lq2DFjGOHj/aaRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsltPpmQZr9KAAlOafb1g+xggfVHqZv/tz22snXHza8=;
 b=YQA3ioFtrzLhftriQ4Qt9zRGhE4k5b+6ZG24qh0mbR9FK9v0wfiwylR2PG+0PfSFGSRNgW1KKLcj7PmWCXDczK1hX3tTMtxpvtm1nVBhMm1czd9g4W7E6id+EsFUxIZ0nhLYpaLfaQh94W+6nOZqw1B3N4htbXThWAFbujDe4CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 09:09:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 09:09:11 +0000
Message-ID: <34f7771f-7d6d-4bfd-9212-889433d80b4c@amd.com>
Date: Wed, 26 Nov 2025 09:09:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 15/23] sfc: get endpoint decoder
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-16-alejandro.lucero-palau@amd.com>
 <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <4aab1857efeaf2888b1c85cbac1fc5c8fc5c8cbc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0341.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 495408b9-431a-4f40-8cb7-08de2ccb769a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXJoQjkrZVFWcC9rWE1GSDBibnBoa1RMQzlyTW5OZEJoWjFpcXlTOEFPaVha?=
 =?utf-8?B?SjY4SVlPRHN4MjVoQkhZLzlYWk9xZEMrVkU1SGhZNTkxWXpQNlZRZi9FWkJB?=
 =?utf-8?B?WTd5TEVKV1Mrdkd4QjdsZSthMEtkVTM0VjNUQmFsVlkybGx2elFGUDRGMHp6?=
 =?utf-8?B?N2ZTM0EzWFRrLzhvOXJDNkxvV0FJSzdBYmt5cjFDemhMQXVtNDZYTGI5VXdo?=
 =?utf-8?B?RGJIR3hTT1pCWkRlalROSStjWjIwMDhJb1lxR2tZOWNPV2lrdzJVUzdON2dP?=
 =?utf-8?B?YVUxcTVKYmE5b3V0N2cya2Qra0sydXlIYldUb2tlcE5CWkI1T2hwYlQwVTlW?=
 =?utf-8?B?WHE4NVd5c2RuSzVIRG9POS90bHpqWnNxdFdtSExhYmU3WWhvVFNLSitvYjBJ?=
 =?utf-8?B?dnJRMk1qTnFJdFZPQmtKMlBWZ1lIR3U1bVlvMkJvZ1NvMGtYYzBkUWYwM0hX?=
 =?utf-8?B?RVRQbUhVQnlEc0xqK0haS0JhTjNJMHI1UUpyS0RoM1pEVzlNckFodkVlMWk0?=
 =?utf-8?B?WThVT29mNndlSFpOcWRGeTI2bzVRSFhEK1A5SGg4amxrL2h0UnkrUTRzbUxq?=
 =?utf-8?B?eEZtdlFVUm5sUHNXUC9wQlNIK2NqUDNjRWg1djQ1S1pqT1ZzY0R3a00yU2FU?=
 =?utf-8?B?T3VTODJETG11TDJRYkUzM1M4UmplMlE0cXFEUEp6OVRXeG11ZG93VlFNaSto?=
 =?utf-8?B?dGlEUkRKY1l2OThaaGtFd3pPU0xnSFZDT25JVk5OUlNDSHFzck9HRVVxMUtk?=
 =?utf-8?B?RVZnUXBKV1NvRTVyV3RFWnp2RFBSRHlYV3k5dHIweGZiM1RmZFYwclUraWJi?=
 =?utf-8?B?cFpjWUZVK2tqamx5L25MZ1lDN2gwOVc4d0FOdndGMmNwZytkWDZoU2V0RzVr?=
 =?utf-8?B?VnFmWENpN0x6bHlmc0tLQ0dPU3VLUG9VS1dkUnpDVVYrb2x1Y0ZYQ09NNzRl?=
 =?utf-8?B?SVNOdnZzaHN1ZDdjSTlnWXJRdFBvcENjQmE2dlVFSzd5SktIR3F6OUFzaXRI?=
 =?utf-8?B?WlRueXpkWVZRSndoMWtqSVlQMVM1SmNmNE85dXRhZW1IcVlOTXk4YldxZkps?=
 =?utf-8?B?amYvb2UxQnBvRng3L1VDUmkwR3kvZDB4OXlYNFFLMjdvckhNbE16QTF5Wjhl?=
 =?utf-8?B?YXIxUUtYUUhWWkZub2dDRGo0S3dNSFN0WURnczQwSVdnZW9Ca0ZWRVd2Nmth?=
 =?utf-8?B?SmxGWnV0UElGNFRqTGFtb2hZc3RsRHJuN0N4alg4cS9ub1AxdXNhanFkaWdn?=
 =?utf-8?B?TWtLbG16TkpOOVdCNTlGTzZVVFNocE9jYzc0OTNRQ0F0YTJxd3NTNE5zTGFi?=
 =?utf-8?B?YWN0bnY1OXdBRk9CMG1IQ2xNdDZRK0VPMTMvdmxEZGFsWXY0cEl2RzdWRXVx?=
 =?utf-8?B?UWdCUWhFR2xTUk9zRUJySGdYR0xTbTdxYVM3Vm5rNTUwbUlLVEROQlpRNkdj?=
 =?utf-8?B?VlRPRC9rTm96UTZ2d1BaeHZxNTlsenBBc2JwbFFTM2s1UTdnd0NMUkM0ZXJl?=
 =?utf-8?B?UnFSUXNKS3NBQXVsNkM0ZEN1d094SFgzRTVlNFZQeWV6TE1UZzVVVXNYLzRT?=
 =?utf-8?B?RlM0YkVWTUdKSFVjMjRrSDVBbjBuVFpSK2sxL1FNakE5RjdPY2tSZ3JKcEp6?=
 =?utf-8?B?Qms4SldLclFGNGw4MWNxS0ZYWlNIbXBNTldoU012Q3NzTHEzZ01CV1NtYW9P?=
 =?utf-8?B?OVBxRWszQ3RnNlFCVkpmMUJNNTZZMFhmOHBoclExZlcyYU9PVHVRUkZRZHRn?=
 =?utf-8?B?ZlB3U1BMWEErMWNXRXhFaktnL3ZQNTZFVjJISUlJL004YmhxR3h0OUhFNkdN?=
 =?utf-8?B?MGg0SE9SczBNR2xYcG9qb3gyL0hGV3NsbHRqYlVlTS8vT2ZTdWptaXcvUFFP?=
 =?utf-8?B?QndjOGZGbXcyMXFxMVFkdG1FN2s5N2ZLYU1PT29YZnkrdEFpYUliMll1K0cv?=
 =?utf-8?B?dWxVbjNpOURDdHpNTFF3RVNkdFlwOE5aQm5TQkNZT0VITmFYVnFJbmN4Mk4v?=
 =?utf-8?B?dWpYaEpVNnhDKzZCZkU0SVIxcXdBd010eDhmTWV1TGJuUklLdVFnelZLb2RH?=
 =?utf-8?Q?8RTi82?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDNQQzg5UzYralRhdmhSV3VmTk5LVEVsNER1OHVPa0Z3czRyYThrL1Q5YVZz?=
 =?utf-8?B?azQ0L2p3REdPamhyOG9wK2xmN1NZRjZVb2VvR3NXNXJOUDM5Snd2UG1vUTkv?=
 =?utf-8?B?VkVGdWpQTDdsVG4relZVM1hUR0d5bW80WEY4MEJXK1lyYy9jdTE0SmRVaGg4?=
 =?utf-8?B?UjgxelU1Zk9KeU16RGhFS0tlZVBMTWNjVCtmenJFWGhrZGtUM29JNU1IS0hY?=
 =?utf-8?B?TkV1YlBaYVVaV1FvTTNOeVdTNWFPdkhhNFlkazc3bU5KcEhaV0FMM0ttU0FF?=
 =?utf-8?B?WXFMMjk3MG1vZWhFL3BneGtva2NwcGdQT0tCSHJDYkxlVTJ4VWVYWHEvNTBT?=
 =?utf-8?B?VFdsdXpWRWloTVhmNElsMkdqdWVaWnFkM2U1QzNQazBZY3FDWEExcUtmbFRC?=
 =?utf-8?B?UHJHVGlxc0twR3pQTkRTODhLTVoyU2xKZEl2b0NpdlltL2xzUTRuUDZwZ1Rj?=
 =?utf-8?B?N3gvUjEvSW9SRGFDTjJRSWZFclZpZGZrTkJ0K0F1ZmNCR1ZPYW1kYjRLZzdD?=
 =?utf-8?B?Z2ZqNzgzNWhscisrQjNiNlhnRzJIelp2VEVGM3BVUC9vWi9pTld1d2lGUkRm?=
 =?utf-8?B?MXhGSUxFYjFBUFJQRDh5SUdsZkgxclRObTZEMHh3T1Brc3NSVFpvQkt1d1BP?=
 =?utf-8?B?MlJndVYzbTloZFgwVG5pUlIyZUVhZk1YTTRMMFNjYjcrbmxTeXduTVBQRHVj?=
 =?utf-8?B?ZHFBZFdUM1N4RHhaOU9ObHZ4VnQ3cXJIMkdJRGdOdzZEdmhsTDUrMjQxdlZo?=
 =?utf-8?B?NE9aOXVQQ1RJNkJSUUQxdmMrSUpHaFVWUThCU2hwV1h3UjJYbFQ0YmtmNjUz?=
 =?utf-8?B?a0Y5OWtJWXVEMkFiUE54TjdyM01zQmpGWHFXcmVwS3FiWXN5Vm1majVmVXpj?=
 =?utf-8?B?bm53aGx5d2lTb1VzRVY5dndTS1NhVXlQcnZJWlpzeXYwTGhxUnlZZmg2bjFo?=
 =?utf-8?B?SkMzelNOU09VeXAvU1htR0Mxb0JFQWlDemljRW43a2lHY3lwb2ZrRWExRkNq?=
 =?utf-8?B?VkFkd1E2RzZRcmUySFN0VjF4WEV3MHc1aHVkS3VjQ1AvaFZ6dGh3WGkrb0k1?=
 =?utf-8?B?VXhWS05IUkRhWDJhbnNBZS8yUjFXc1lORXVCL0tiVjNiNVlYSVlFUFJLbHA0?=
 =?utf-8?B?M1dHM1kwR3c2YzRaeHpkUHFVMittdW82cEMybWFpOVdKTktYNzh5b3JqclhU?=
 =?utf-8?B?OVJhc09lT0VROGRXbk9zWUpEZEZXVGpac3NYTW1wNlY3Qy9GUlhOOEZSZThC?=
 =?utf-8?B?L2JLNExGVEtJdzhPNHRSUjY3SDBzTTZORFlvVng1d0E4WTU0Y0JxWml1b2RI?=
 =?utf-8?B?dmszOHVzai8waFpkbXBvQzQ2UGFURms4SHRCYlJ6ZnYwelZnSzZBRVV0SHdu?=
 =?utf-8?B?ZmVzNWVJRjdDYVFCWHpvaHdoSlg2bWxad0UxOVhMRGtMSWNwN2VsdFN3MTBn?=
 =?utf-8?B?NDBmZnpTZitHYWtNMXBqaXFuNkI5VlFDVXhDZVBiTHJkZ0RJOW53VFZsV3Fn?=
 =?utf-8?B?cmlGVWRPRnZRcTFCLytBRTlPbkNvelYwbUZVcEp0WGE3bmdDOWZ2UFI1enIx?=
 =?utf-8?B?d0RPVkZpdkNnSUFFMjI0cHNpRmF3bjBOZ2daL1RRUXBTMXRpWDdCMWJYdEJl?=
 =?utf-8?B?ZzQ4SENTSGFQU09wT0VSZkxOaHVXa0ZNYnMvaVRWaytLaE44NDV2UThjOTdh?=
 =?utf-8?B?VlZCTUxJSTVIMEh6aERnYVZueDA4QlZPd0ZiRG14cjZrSlpmWjJScG9QREdF?=
 =?utf-8?B?ckdXMTJTUUZ4M0VZdW5ndy9LL1hyZ1c4YmZRR1hJVDV5eVh1andBUTl3alNw?=
 =?utf-8?B?ZjliT1k5RmVrTnEzb1pBaklMMFpsRGVzeWVaVVM1K1llN0x0VGFwb2FSbklZ?=
 =?utf-8?B?ZkprdGIzU0JuUjdhM0hKamtvQ3loekE5S3ozRVhYeFNJdFA5N1VYVkFFMity?=
 =?utf-8?B?UEhJNU1HUmQyeXBYck5yWmNRU2lGZlBvc1J6blRWWldJeHV2TVlGUGFUQjJj?=
 =?utf-8?B?SXV0MXMrTi9FUjFwVUxzSXVBeFRoRlRZeU1yL0dFeklYbkdYY1I0ZkFHVmdn?=
 =?utf-8?B?bHM1WHFkS2Z5cjdJZ2tCclgxVm1RbFBmYzVtVXJ3cDdmZTJuSmFJcXV2N0xM?=
 =?utf-8?Q?rRd5sXIu9ttJwByFQbURxqgCr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495408b9-431a-4f40-8cb7-08de2ccb769a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 09:09:11.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl4vo0hzgPd9mqIdOeT8NbA7LXCkL1WScogg83FWSQQRbC7rAmR+bRQqY6AdC5jJv8/bFbk+OleGvVPRkG9IiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812


On 11/26/25 01:27, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through
>> an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
>> b/drivers/net/ethernet/sfc/efx_cxl.c
>> index d7c34c978434..1a50bb2c0913 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data
>> *probe_data)
>>   		return -ENOSPC;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
>> +				     EFX_CTPIO_BUFFER_SIZE);
> I've been really struggling to get this flow working in my environment.
> The above function call has a call-chain like this:
>
> - cxl_request_dpa()
>    => cxl_dpa_alloc()
>       => __cxl_dpa_alloc()
>          => __cxl_dpa_reserve()
>             => __request_region()
>
> That last call to __request_region() is not handling a Type2 device
> that has its mem region defined as EFI Special Purpose memory.
> Basically if the underlying hardware has the memory region marked that
> way, it's still getting mapped into the host's physical address map,
> but it's explicitly telling the OS to bugger off and not try to map it
> as system RAM, which is what we want. Since this is being used as an
> acceleration path, we don't want the OS to muck about with it.
>
> The issue here is now that I have to build CXL into the kernel itself
> to get around the circular dependency issue with depmod, I see this
> when my kernel boots and the device trains, but *before* my driver
> loads:
>
> # cat /proc/iomem
> [...snip...]
> c050000000-c08fffffff : CXL Window 0
>    c050000000-c08fffffff : Soft Reserved
>
> That right there is my device.  And it's being presented correctly that
> it's reserved so the OS doesn't mess with it.  However, that call to
> __request_region() fails with -EBUSY since it can't take ownership of
> that region since it's already owned by the core.
>
> I can't just skip over this flow for DPA init, so I'm at a bit of a
> loss how to proceed.  How is your device presenting the .mem region to
> the host?


Hi PJ,


My work is based on the device not using EFI_CONVENTIONAL_MEMORY + 
EFI_MEMORY_SP but EFI_RESERVED_TYPE. In the first case the kernel can 
try to use that memory and the BIOS goes through default initialization, 
the latter will avoid BIOS or kernel to mess with such a memory. Because 
there is no BIOS yet supporting this I had to remove DAX support from 
the kernel and deal (for testing) with some BIOS initialization we will 
not have in production.


For your case I thought this work 
https://lore.kernel.org/linux-cxl/20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com/T/#me2bc0d25a2129993e68df444aae073addf886751 
was solving your problem but after looking at it now, I think that will 
only be useful for Type3 and the hotplug case. Maybe it is time to add 
Type2 handling there. I'll study that patchset with more detail and 
comment for solving your case.


FWIW, last year in Vienna I raised the concern of the kernel doing 
exactly what you are witnessing, and I proposed having a way for taking 
the device/memory from DAX but I was told unanimously that was not 
necessary and if the BIOS did the wrong thing, not fixing that in the 
kernel. In hindsight I would say this conflict was not well understood 
then (me included) with all the details, so maybe it is time to have 
this capacity, maybe from user space or maybe specific kernel param 
triggering the device passing from DAX.


>
> Cheers,
> -PJ

