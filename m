Return-Path: <netdev+bounces-239854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69351C6D2B7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id DCA2729329
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697B92F617C;
	Wed, 19 Nov 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JupwR7tH"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6802E8DEC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537744; cv=fail; b=hygIYa+PnIIJx6KXSZdnalLOWmLFLmcD8+XwDMas8YKpgUN2FAd6C5SqlR+87/SJjgeIGfSb/55xR32PRyBpcv7evvyF09CCATuzxD6UYO6KJ075grzkgZhmrZ4qTfkV0aoalxpGVcLzXrNd27+Ze2SuJ/c+TjNFgYxNn27a6NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537744; c=relaxed/simple;
	bh=NysTD6n5vK+UYKa2ZZ6rMLxYn02CV12c/gQpvcuMjC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rmXM0lenUPWzRwPzkgNpx86x0bFTwe8Q1jBaQAmSy9aX4nfsvF3cQLOx3dlk5mIr94w+Z+WoC2DzrY2W6O6e9a+jxZyNipsjtLJWkqxsTaIubk0RUaTKw0bz+Bxc3pObG69KoM5ZhMZZiTbRERVnIz56ZCr35aykphuUGBjc7WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JupwR7tH; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0KzZXdeKwNdWGJk1oeaDSiFP1sTDVvksujGNsCO3/N9ZsM9j1dTfjpZVfX/b8pGqZqvlD2DrVsdQQDFmig8lamuLaHn3DK4FdhSrDoU0h/3K01DoDsbncvfOtBhte4L8bajIVRImaFOE5o6Zel69eDrCl+WzrMDGt5RwQWhrq+SA95tlG4z8lveQpX8/QxBC0hP+bUc+nD7EEnxGY8Abm04loun04l56lrCD+k28iTOU8aCcfZbHkBqSKlT5myZOhf+AJaLyrNZOE5O8X2g5F9CdC/0KVu7r4HM5JPRTWqr2SlCNjH+BqNs3ckJCo4/AShOZJzNe1t7EMsgdhRIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K52X7idRAM91rxzNO7/H4SGmihA39n0a4AD+u8u0d+Q=;
 b=KqYFiWzZjGEbOKDHdLY8GpAN1wZx8WpzQOTpnBzRKbXBh1l90od0McE03Pp4x+2p9E5sO4HdP3UtpNGXm8RfKjPVey10gxdGenaZnj0ZLjpyQVnc8EFHKHo7Vex4Khef1UEz7txMfTToqZErUTi5gSEihcmyYL2KR/Gr3GYcLgziW1WFpIgXmJ6m2sYEeAEiJj+KEtDIOJWgqtE3VN3RTt53gFyIO9eedzexz+AY6LX0bim0ng9oWtXaKkrezGTEGtQ3LBZwzP78x0yqVKNqUHVQLPPidD5pZZWDL/lPl6GvT3u729BL2SEX2S4VO2He87SCm0HgBUzhfylU2IzYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K52X7idRAM91rxzNO7/H4SGmihA39n0a4AD+u8u0d+Q=;
 b=JupwR7tHUPkEStpElwWQwS+2imN7J120l2Ru9cNcdNS1/yq1RdKJ/pxfLV/OblhhOsKo8B7VNvTsSkgT+REMtgQUcZXIKHpDwEMpPYfFc4rB/VH1pT0hLeCltsfUDQakQUCbgSgbvlnuzZgvPAYT9xURYH1rnFGQyxlFudZmJUxWpO82JY9AuBRGgjj1SF4joLwWgn5SaFiiOiS74J6HYLN1w7EXEhqlX1HHitjAJFZ/wHGnn3MwrPkP5vC6bnju0ajEA4JQ2x09R/RDSLbZuy9BcXYFC0HmGVL0wkYYPY0g+btI7LwUIrFKzVupipmbBHUMAE3VyZYTuYS4FMiWIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:35:40 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:35:40 +0000
Message-ID: <b49d6c7b-ba39-4f9e-9e75-b3f186fe8e0c@nvidia.com>
Date: Wed, 19 Nov 2025 01:35:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6
 ethtool steering
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-11-danielj@nvidia.com>
 <20251118164400-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118164400-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0102.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::10) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ac2e91-24a5-4f3f-cd31-08de273e3d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3FwT200aGIyQy9FdkNUMXAwK3BUbno5OU5jVUw4eGdHSUV3bVRRQ2F1SUUy?=
 =?utf-8?B?VmFNUXNRU0Q5UzNiWnMxaEI0WFJDTDdaMFlqOUtTWFhCZ3dudXUrRXl6UnBN?=
 =?utf-8?B?bGVYNGFCVkJIbjZDZmMzYWI4RUV4TTV1c1ZFc2duakd1UmIvSElQUURNU1Ru?=
 =?utf-8?B?aEpId1VScUl6Q2dnMnRINlVySEVhcE50UVRGaXRkWG00S2Z0UUpmc1ptbEJD?=
 =?utf-8?B?MlQwb1R2b1R5Z0Q1RFo1cERjbU01bjNyWExQYjc5cGtLdjV5cTZId2l5TzRj?=
 =?utf-8?B?cGhNclBKU1BWaDlPdW15UnVOMS9kdFJYdkJUVVhTd3lYc2Fqai9uVWVoejR5?=
 =?utf-8?B?cDdPSm5GekNnSDk0VWwrTHh6bkxyQ01MUFVHTFhkSkdCYkVTU3B4bDROZHdF?=
 =?utf-8?B?Y0JiWUxmSGpINStvdUlnNlJEbHhhbEp4VjM0L3kvN2dHNlBQSEUvN01XMjgw?=
 =?utf-8?B?bWZRbXdzYW5uRmVJWFB2dXBpUW9HYUpySlI4c2ZlREpDY2FCeW1UbFlMeVRs?=
 =?utf-8?B?ZW15ZVNjUGVKZ0l4Z0l6bCtMd3BwRnlnRnR4WkNmdFR2SkxPODYvUThISlVq?=
 =?utf-8?B?WVJab2hsUm5tVUNGaENHa2JYdVZGMXR5Vzk4YmtZT3lTUDFLQXNTd2FGRCsz?=
 =?utf-8?B?YUhSUlliUzBXM0p2cThiVG9vSWVJd01zbW0xQTh0WUlCNnp3Z2w3TlV5ajJs?=
 =?utf-8?B?N293c285ZXM3NEF3d3RNS08vV2hpODhDM1JXRTNEdjhRWmcvUjczb1hyMFhI?=
 =?utf-8?B?OUkzTW81TFI3N3R5eVI1MzF5aFR4aGxuMEVsckZhSTNtdEhNWUpkQ3h1SXhm?=
 =?utf-8?B?SWFDdktQYjJmQ0lRNFMyWmVxajhBRUljNXMvQm1ka2JWTlU2V0xyc1Awcy9v?=
 =?utf-8?B?VVZWNzlQY2Rlb3NOcmV4dHNhdFdCVDJIOC8yWmZ0bCtkR2ZXZUVySWRaV25s?=
 =?utf-8?B?V2pMMGpuVlNtMEYyL09scG5qZzhWQ0lrZWZacUdLa01IaFJiZVpabWJmVFRG?=
 =?utf-8?B?MWc4aHlLTGV3LzNjdEdmOGErVDRtbWtNdnozS2ZFQk1LNUNraC9Gak93SHdj?=
 =?utf-8?B?ZWxoeTRiUFU5b3VCRm96d293bDI0NURyQUM0QWpXd09OaXdHV2ZFaXFjQUFn?=
 =?utf-8?B?QSsxaWxuek5JbVp1dzNBZU4zbEMvbXdRUndMOU9CdHJxclhPQlphZUVzQ1dx?=
 =?utf-8?B?SzhKdmpWUmk2b1l3bWgrYzYxbTdWNHBJWDB6QWJlZVFNZGJ0UWZmclhZSUNo?=
 =?utf-8?B?NTc5eC9mczJpNW5YVCtpenBCRUc2Q1hZN0xlWG9oK0xaSnBVbUx3VmFpb2dP?=
 =?utf-8?B?MFdlS1JHQVBqT2k0K2pNenFhUkxhMFlkZG8zeUpGZXBMdlZBdUx6MnorMHRY?=
 =?utf-8?B?N0VuL0VFV3Q2WFFMaUd1Mml6VGFlSnJDaVhnSnJxcTlOeFBYRnFuYXU3dTdt?=
 =?utf-8?B?OFFoK1M4amNQb3hYOExEUGdjcUgyZUdINDUxYkgvU1VoREtWQ0U1V0VxUm1F?=
 =?utf-8?B?VG4vVEF4MDFSenp1K2plUy9Id0RnTkZ6a0lLdHNxYU95cDRFdlNJenl5VDJm?=
 =?utf-8?B?aUVKd3dGTDdCN0p6ekxUNHpRanpXU1cvYjB2Zml6UWh1d2cvQWRsRUxhRkJK?=
 =?utf-8?B?VlY2S2NEclFScnNoRzB3YTc1TUlWbGlBdHlYWVVNVmJiZVVtYUJKcThYZlBt?=
 =?utf-8?B?SjNQV09PMlMvZEgxWHhtWktBa0pPUE5CRWk2TlBoOCtIQjlnRTRCb0lya1Ns?=
 =?utf-8?B?WVNGY3Njb01ldVhvdWE4TWh3dnd4M0EzVkd2UlFJQnZia1BKUWhEblNwRGJM?=
 =?utf-8?B?OFg5cnFZRGtYUkpDdDB0SWZTdGQ2UTVzK0g4TisvUmhBY1hQU1R4dHUzb2Vh?=
 =?utf-8?B?eVo1RFBXNU5VdmNhQStLbi9TMmZkM2pyOGlOaVF0K1hVOW16eERIbHFKdjEy?=
 =?utf-8?Q?l1sraGqxV+YjKVqxnMZbqOvJl9MbRttV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3dYZ2tzUC9GMW9iNUZYcWlEa3Z4cXhCRmZ6Y1U2MGxySzRFODhtVSt1WVRw?=
 =?utf-8?B?YlUvSVRXSStsaHNTNEJBUm1WejkxZC9NNWJvN09IL0NWZXV0enppZExUM3d2?=
 =?utf-8?B?UWI1RTk2S2lMYnJwQVQ0WmgyTHBpRGJjNXEzdFZSWStpQTF1UVh6T1E0amp4?=
 =?utf-8?B?YmFUT0l4RDc2bGpMVTRCQzh4blFyQ2hET1pvUDNOYklIYmZQMjRXemg3TDJp?=
 =?utf-8?B?UmphcTgycjlxTzdSZE1sSGNoenR2c2UwSlF0UmxYZkQ4aVBYc0dNcUt1MUVO?=
 =?utf-8?B?VTluSnRiVWRCUk1lYnlNZlZxTmIvZ21zWGw0TzZoc1huc2pYRkJRa1ozQWpz?=
 =?utf-8?B?emJSamF1RGpmNHA1MkFoTnhyeTlmRzNwbnowNDBoWlBDdFhOR1pnQndnbUZN?=
 =?utf-8?B?endFUTYyeU1qRm0vYkovRE1GbUpHQ3NVR1lEZHhaL3d2MXNkeDdZRFFuQUda?=
 =?utf-8?B?b0M4Rnk0Tzd5cEx5VWFsQ09BR0dvcy85Nk9QWFU3d3FVRmxLM1R1eGRkSTRX?=
 =?utf-8?B?NnBoTi95OU5FVG9aMWlRRDg4SWxIelNYb09JNmxFM1B1V05MV0hLYTNScUNh?=
 =?utf-8?B?TXNISGJCemJoaGJjaTZJVlBUZGZYQ3NIbEhyUEVXWnZCUGJnL3FHZHFVeGZV?=
 =?utf-8?B?NU1DYnZPd2MzYmptODQzcGRaYTlIRExUaGZGcVIxcm40TFB2VjBuMDZHUDZC?=
 =?utf-8?B?NUZ3cEJRQi96WTRObGdrN1lFbkdlSitPbTZNeUJhZE5Yd1pPRWljeGpId2tB?=
 =?utf-8?B?eS9DQW9zRjFqK0lYeTVuUFY2bGMwRjk2YzNUTjYybVJrZ1FMRUVIa0NZa29p?=
 =?utf-8?B?bHNZdHVPdDkzOUt4TXFwVXJuMkN3aVpJWHovTWxCb0NMOVBlSXhmN04vRzNm?=
 =?utf-8?B?MFIzWnhuRTlHekJVVTZYMnNDQnJ3Z2xDVHRNUGZkMGVYOHFSeVVuSFJBaVZ3?=
 =?utf-8?B?a0VxcFNacXlWWHBpVUgzN05EL1Y4c3crV2M1NXVkSDFSUWkvaTZXdkh6K2hT?=
 =?utf-8?B?d3hPYTBNYlJFS3ZRYUFiczl4TEJ0enVVclc3bUxxMlV2eWNoYVFKNCtVRHNh?=
 =?utf-8?B?UGR4UERRRDFDdkJRdno1eTk2N2FVbjRKNkJSRmVjenV1NGdNQmt6bVh2LzZB?=
 =?utf-8?B?SDYvSU54aW1KUURRdHBsUFBrVCtiR1VxUmZqNFd3aG95TWl6U0xMN0VqV3dw?=
 =?utf-8?B?Zzl3WDY2b2Nxa1ZUVzZONUJGZU42NVNLclBwNVVvL1pyRCs2ZWxDa0VaUXdV?=
 =?utf-8?B?RDZUdWcwb1RvZENmVkxUTHBaeGtIZ2dndVpaY1FhK3MybEF2TlM4N0FIYjVN?=
 =?utf-8?B?Q3lMZDVKQ1hWNFA2anVSL1RsWXY2WTkwTzIvQUx0VW81L1hiRmtIWXBNZTA1?=
 =?utf-8?B?cEZoTk8wek05Mjh4d01LQisyU3kwQ1Y1WCt0akdWTGNhT0wzaTJOOW5BY0Rm?=
 =?utf-8?B?QnZHZUhMSlRnZTNMUTZPQWFxKy85enYvQTBqQlVaS21ydUg2Y1NNVjBXUDkz?=
 =?utf-8?B?SFJRRGNqZmd1L3Fnd1oxTWI0eldqcElCT0g1bmhzNmhJa0oyekZPcTUyellN?=
 =?utf-8?B?c2dPTXlCZlZNQXUxUXJ2Q2FMQ25oWTNGU2dXOHY4NE15c05pWUN1Q1RrN2FL?=
 =?utf-8?B?aVVWcVNwQkd4MkVUYkQ4WTZ3WEV3L3o3MElWV2RGOUNJdWN6UVhQYy9vTEZM?=
 =?utf-8?B?aHI5VkJINUYzNGFmTGdIUWMydmxXaTZER09lRGV6TG16emNrK1plMWp5a21p?=
 =?utf-8?B?T1FGTXZLWU9Nem8zblkwM2xCNzNEclo4MjdaRTJWdUlkU3dRSW9QdnVWM2J3?=
 =?utf-8?B?cmtiOFRVbDZMUFRZTWpva2ZZZndoR0phdWZBdmkxQ2JQenc5VUJyR0grMzA0?=
 =?utf-8?B?NXluVm53bGxGckhMWFJrdmIxeTFXWTVmaktlOS9PUzAyejRuWHRNSVJpWmNV?=
 =?utf-8?B?UHFnTTRwMStycmt1MEt5T04xT3VQY0ZmZnI1OVFZamhCOVBlRmhUaVUyaHVW?=
 =?utf-8?B?VmZHeVEvZFlLZVF1SzUzLzNGbmxjL1dtVElNdiszblZCZmZwUGVoUTY0Mi9r?=
 =?utf-8?B?YTQ4aUdIb1dLK2tqcXVrVy9yMjByVmNocXlKb3NiUDZrb3k2SWE2aXdRRTl0?=
 =?utf-8?Q?XtAs8JTlPKNFtvGRsJJLlDEpx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ac2e91-24a5-4f3f-cd31-08de273e3d01
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:35:39.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH6Qd7qbRVZ8V1GzW9u+P8+ir3rOBTjxw6UpBlSc1KYsIDuQ62orZpUi15loJBBCWECxF3OXaJWrYTp4vTcVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

On 11/18/25 3:45 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:39:00AM -0600, Daniel Jurgens wrote:
>> Implement support for IPV6_USER_FLOW type rules.
>>
>> Example:
>> $ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
>> Added rule with ID 0
>>
>> The example rule will forward packets with the specified source and
>> destination IP addresses to RX ring 3.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> 
> I find it weird that this does not modify setup_eth_hdr_key_mask
> 
> So it still hardcodes ETH_P_IP for all IP flows?
> For IPv6, should it not use ETH_P_IPV6 instead?
> 
> how does it work?
> 

Your right, it's works because our controller use that field. Will fix it.

