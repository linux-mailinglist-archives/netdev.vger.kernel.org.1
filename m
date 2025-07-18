Return-Path: <netdev+bounces-208148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47AB0A448
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03131C4312F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03632D94B4;
	Fri, 18 Jul 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0D6ZVSK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D7221297
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842209; cv=fail; b=BuyagqeL0yhGijDFtBwF8bEubGOzD6OHblq54x11Z5r+CDLBwDehCq0LFZkSYf1GVgBEwkh28EJVs+uMq4zzRO7HZJyvgGFGMhTOWLzDqdE/EnJ5hMYlfTUh+GxWMVMaMQ7Ml85ObWhOmrWMk6mbwgEuM5fbmcnNoCZIx00IqN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842209; c=relaxed/simple;
	bh=d2C3NituHM8TrAcxuBmUgXqFjw3Sy32GDRZLBZGrKVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uJXHAAIDFFmZ96HYWZstRTAeFoNoj63La7zIisv1GiDTjn4txgT8DHVIhznmuuj6xAkj3CQnbU99AwrXbOP17Wy19sBkzazuSNGaNKauze+fDQOinqr6vuJv2ECv0sR8NllF0PR5iDsZNol2yfh4aUC/8lgCBgMvwMYLc4uzY+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0D6ZVSK; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF70TlaP73WyNb+f7sxYYkwYn9F8C+scB+c9y6lmpogKKBIHPp+GLUjNWwNqkwR9oInEcOexECpTqKf9HcrciPN0iWVQJVRaAVqlQi7IYHstO+2oDRws0i7HF5TxMMxps4PyxlYLucxxEXSMGOLk6+2QAnw43m94Nm4pvrfiROcZ7T3yzkEood05SUO9vMUIyJyzr/4kM/pQxoP80UTNQVc5mM+Qdb1/8UQ3Y8QzefsKDLciIFRvITyjdpRVC6Bwy9WHUMLbBymebLChK/zCw31+psMmwkXJus2PDrX3ZoC1TiiOOPeZne2jFGaCVKEno1exz4ZgxJshe522hh/HXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF8OTi3L0gdkmj9SASBW7ESLEdHC4QczBqW+TO8KNKo=;
 b=QZ6HzzqHVyHDCoGdSwO83i/3aaRqOkBCfL+et7ltbk7JpWbjsTERPV+Cv4AqZIUMP87aX2qFT1Cav+/bYIL+0lD5md4+1LvEN+WxXY4r9YQ0Zwwey0qabUQr2pT9xnxaW390x+k6VE+g+QxUhxm7els4If03ZBGigvpumuFeMWpKVrvtwUx2dD7/x6UkcQFY4jdqthcX7f+N67TeW0GxksLWEp6wvtq5gQAix8s2bNgwItvduFhVo8ZpyNU/kTn/QSpIXRK8SBWlX4EE2RkmKrXlMABLn8SdeFrjfQhwjffS+RrlCSZIYE1cKnzNGzwnhbuiiW3sSjcpkQ88+F8jOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF8OTi3L0gdkmj9SASBW7ESLEdHC4QczBqW+TO8KNKo=;
 b=a0D6ZVSKATayZoDvLBY/G0ActzizzeSkhQoi+tp3nodKJph7xG79PvgUl5hjmsT1D2DsHjeT7HluXtCUeOMVfaquNfvS+r6VXKxkxQBEvbJRBq5kg+pBQkhU3BTvVKAggJqBWtlG2hgiREzJJKWZJD1oZZZRGhi0/cJrnOTYx4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 12:36:45 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 12:36:45 +0000
Message-ID: <5b5c68db-2500-4614-a0a8-b1f537e54238@amd.com>
Date: Fri, 18 Jul 2025 18:06:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] amd-xgbe: add hardware PTP timestamping
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 Shyam-sundar.S-k@amd.com
References: <20250714065811.464645-1-Raju.Rangoju@amd.com>
 <20250716170212.2a2cde21@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250716170212.2a2cde21@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::7) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1828472c-1fae-4b12-4fee-08ddc5f7c156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Szh5aHA4eUZXN1kxbFoxazlIOWVnY3RNR2lDdVFaek41eTViWTRmWFlHTGg2?=
 =?utf-8?B?S1FLbHVnSzZSYWFnTHU4QWdVMWZ0b2V3RW5OUmoreFZvZTlMZGhaeDVUMG84?=
 =?utf-8?B?dnFtcEtnYjNzQjdYRTVCS1dYUUgxTzBGL0p2M09GSnNYcllCRVpwN2pZZzBq?=
 =?utf-8?B?UkNjaDRWSHhXUFlDNzJkcW5iQmVvS2Z6ZWR5QjROSnRvYmdmeUdCUU8vc05P?=
 =?utf-8?B?MWtxRzdlS1FNWTBEbWQyZU5XQkcxMm5PdXZEeUdiQXpGMG1IcFJhS0kwZDE3?=
 =?utf-8?B?SXRHOVFFTU82SThXWXBwV2QzbWpMd3JyN3hhS1Vsb255ck1uZ2ZCeFN2TTB2?=
 =?utf-8?B?cHRveWt6UHI4TXBRTWVYOHZtbG00OFdFbTBQLzdFWjJ0LzlYVzNRaU84ZE02?=
 =?utf-8?B?MXE1azlFei9FdlVVaVB1d2RQYk44aEFRVlNFWGhNbHRmd3IvdzR4NnY1cjJP?=
 =?utf-8?B?WnFqTjdRNWxvS2xiSnk2Q1ZSWVVNd3RFMG9PbW9CZnlkMmFPaGFyNFJ5ZHZo?=
 =?utf-8?B?TWNEK0RyZHFMUCtScjRkZExJazNwem8vUWd2dUwzcC9ub2tUazlZYXFYell0?=
 =?utf-8?B?WHphcW8zV2N6OEJyWUJpL1JkbVpOMnFhSytrU0FTRFNlOVR6R01QaUJTZG94?=
 =?utf-8?B?ZE9IbFd0c2VIaHdqNEwrZUxYMHpUS1RGK0ZLcEFzdGgwVEwwZVVNS0F2Q3c1?=
 =?utf-8?B?dWlJZ051eVhDV25PclpENG9mbHpzNkl6WDBuYmJ4SFR2V1VMWVpwM1cwL0xS?=
 =?utf-8?B?NCtCM2tPOHdZUkIycXR0V2V1MHRyMFNCcm1GUEZ1czh0dzRuOTlhSDlyUG12?=
 =?utf-8?B?VWdEQkFINnBxNmw0bXdmcWRZNmU0ams3Wnp6bzZPWUE0WWREZkxieTVXYmdF?=
 =?utf-8?B?N1B5L3ZKZnArZXBWZEtFSTVJRkM3MGRuUzVRZWYyeVRSaEUyV2dWcmY0K1Ns?=
 =?utf-8?B?YUhWQ1RvYWhXcTRSWXF5MHp1Y2F6cjFqQUFWd25vRUZVQzFscTBUNjRKWis1?=
 =?utf-8?B?VDJkYmJXUDJaWmVWalV0NWF6bXRCaXdDemFQbk56NFVxSUl2SzhYTm9BaHRl?=
 =?utf-8?B?UDQ5b2Z0R0k5ZnhxVVhicGE4b0lXSzFLTnpKanVGcWYzay8rUnpuekhDVE44?=
 =?utf-8?B?VENYS3BvcGdvZFR5NXlqazYwSFgybzZzVjYwQllXS2dkM0VYVzIwcU1PK2Mw?=
 =?utf-8?B?c1ZOYjlNaXJtdDZEQk1yTG5zeTFMZVpTRktmbEtxdHhqbjh2emtxYjQ5djl1?=
 =?utf-8?B?VVNjazg0M3FvNlVkOVl5a1g5M2lab00wOE9NWTQ3cmNQcGcycWErdFBPM2RY?=
 =?utf-8?B?NUtSQXI4U0JmYk4vSDZCKzRxN2FRbkowa1ZRY1ZZSW5KMWZsVlAweDJYL1VL?=
 =?utf-8?B?cCtBTllwUC9Cb25DQWdHbDl4MGxhTVNFUVBRR2h4dUVYTWZTT3UwZDZ1aUNF?=
 =?utf-8?B?VjdsUEFzVy9icVQzN0F0a015M09HamxVaitXa2dwNmE5VHBwUGZacnp6UXFD?=
 =?utf-8?B?RFhiSWp3NXNaZHJQa3I5SW1rZU43cVVETGs3c2wyQjJKbkJJUm9zNFhreXor?=
 =?utf-8?B?OWpaVHFEMG5HMkVYQXRZRFdwQ1NMU0ZVZ0ZrRlE3WjZqNWFjMWhYTlptRnN4?=
 =?utf-8?B?ZWFQOEJXVzFqUnRpS1AvRGNaMHJ2OWpTRDRZeDhBTlVXeGl4VytRRnJxTmZ2?=
 =?utf-8?B?ZXV6NFBWb1B3dDQ1TjhYTFZNMjdla3NyZnBYc3FqODZITUtRSVMyYWRPMG93?=
 =?utf-8?B?bmMwZ29HdUMzK1pDNkk3c0N2eWZPcTNmaGp6WURCVmV4VjdkK01PS0JmaU0y?=
 =?utf-8?B?Tk83NGNPRE0vTFVEOVFRY1VJeUw3bDQ0Ym1wdk05MHhnckhoV0tkeDRoZXh5?=
 =?utf-8?B?RHRrSDROSjY4NWZQN3R0czFSL0cvcUc2REk3RnlVRFEvdUp6b3NpdlVCQkZu?=
 =?utf-8?Q?IIK9AQurfY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NWUTVGTmVSdWR5b2d0STRzUllwdEVpck5JN1lWcGovMDB0bXBmUkR6eTNE?=
 =?utf-8?B?RTNxWFJnaVRhZERDZ2hrMkFxMC9kdTE3U2FPeVgveTFBY2tndWJsZXdvd2kz?=
 =?utf-8?B?aHJkWlpRYUJjZXp5L09kWmJhMmxpclpDL2kwb29GOEg1L0orZnp2VEdQVE5I?=
 =?utf-8?B?YmF6NGZmZ09MNi9hc2lkWXJubmM5VHNrZVpBRDljcENPM092MWJqNEpvcHBP?=
 =?utf-8?B?ajU3VzE4NDlQTmgzZWJjOFFHR1kwZkNJeG9MUnIyNlpMcXJCRUluRkp4QnVO?=
 =?utf-8?B?SFRldE9Ra1VHdEI4VVUvT0hOYmtuWEJXL05VSWNlMTBsb0piSVNxOUw5K1VN?=
 =?utf-8?B?alVHSUIyN0xIdG5BTWx5dnJQSGRjU1FtYW1QS3F6NWlnTCtQdzUwYmZwdlE0?=
 =?utf-8?B?eHdISEhoYUtWR2lMeGI3b09aT2Z0S2NXQ1hDa3E2dWxSYi9iVmxYK0pCMXY2?=
 =?utf-8?B?RmQ1M0t4Y3B6bTk0MmppcUhTL0p2WGcxZ3FVMmlkemt5ODJoVWg4TytoSENn?=
 =?utf-8?B?aW9xUWpwc1RuOHZoM0paaDdXWVZkdGFQQmVIK3VndzJXSExhK3N5VFdobUJy?=
 =?utf-8?B?cmRRZE14c2hWb3Y5Vkh4Z0ZNbjRqaHpSVnFKWFZlclZ3L1gyaEdhUHlaUWkw?=
 =?utf-8?B?cGtPK0ltQkx4NUNHU0FzZmRZalhyYnZGU29wbk1Eanp6eWNqb01yT3h4QlVq?=
 =?utf-8?B?em9rQlluNTBLcHVaWCtnS0MxOWlqOVdDSFZteVdXOGpxR05teHJhVWN1blVz?=
 =?utf-8?B?RS9GMGIxNmFMNVI5dWQ0ZnpMaHZLVVlYeFZMWUFIRUZxRXl3bVVHQXV5SG83?=
 =?utf-8?B?V2dhNWlERjRUK1JxMnpHaXJoamNKd01pZ1BnNWxJbC9vZ29lSGZHT081RnhB?=
 =?utf-8?B?VlZZY1ZyVldUcWQwYklndjBYRFFxRnJmK0wzN0dBNnl2VFhVOEdJbE5GbnhJ?=
 =?utf-8?B?dWNpVFltNW15c0wrcm5PRHZIM2ZlZzI2SS9DVndJQTIvZTkwSUdoTG1WcG15?=
 =?utf-8?B?Y01Ud0pONnR5K3F2aVhuQ0tBZG5QNTNKeDJseVIwb0pCVFFGVGNPa2ZXSWRT?=
 =?utf-8?B?TmJVOGhJMkE4emlRWVR3aDNueURicVF4VFUwRlFLcXVSSFNqN1hJSit0WTh5?=
 =?utf-8?B?V3VKb1UzNzNNaWhXT3JSVTdXNTl5Yk1qRHZ3ZVc3YWhVcThrZXlIWTZsT0lM?=
 =?utf-8?B?UmIzUEUxVGhpUGptNG1ETGV3SlNIMEVzRFMzbWhwbHdoM09uOTlodnFWQkpQ?=
 =?utf-8?B?M3pDZjd2eUdORnA1U0lXQjVRMXRNYk1GaUlMTVJDVVI2OGxhUGx4Q2xUSG5O?=
 =?utf-8?B?S05YYnh3QnJlcHVNc2tTUTQ0SU9uOVpYdUNrMGxPcmhMZkRSbndsdmZxeitO?=
 =?utf-8?B?dURiRVFGaGw4bWVYcm05dDVpbW5oTGF5S3ZXUDBlMEgzenVIc3BjMDJob2J5?=
 =?utf-8?B?SlBjUlRjTkJWdEV3OU1xd0RyejY2bmc3WHI2ckJMQWd5MGMwU2laYVR4TEZs?=
 =?utf-8?B?ajZnM0V1dVdhOUk1K2tHUitFemV6ZHZiVzBrVVNTYVZxUWpTV0lIejJVUWhZ?=
 =?utf-8?B?b2x0L1VmTHFpN09OWnZBb2IwZGdscUptWXVaZU5EQ1dWTzJEZDhrTExXL09i?=
 =?utf-8?B?aTJQMFdNY1lBdXlJT1BGcGU1VDc2eG90MHF4VmVWWmdzMzRFVWRhNFhsQ0U0?=
 =?utf-8?B?SDZkWGprbVZPbXZxbWRLT1I1c1ZTeC9CSllsY0pibmR4SUROQm1JNFROSzVk?=
 =?utf-8?B?VVlWeGgvM1VvbHRMWnJRRzZJTk80dGdFQ01rVjBnRzFsVVczRTN0WUkxS3lQ?=
 =?utf-8?B?YUZ2Y0JtVUYzWlY3bXg3S0o2TEdNOG1BeU1YVFBOMHY0RmxwTDdoMnJMTmFN?=
 =?utf-8?B?MWFIY2gvR1hBMEFEMWljTDZVN2dmR3pxeGlSc0lNeHRlLysvdWorcW9VL21i?=
 =?utf-8?B?aWl6SU9OR0JtdFJKTzJYc1J6enU2dDZOTmc4aUd3SllBYWdLcUtJbGE3WFFw?=
 =?utf-8?B?NHRmc1NvMHR2aDFYWlFJa0xjTlF3MVYweHd6MjVSWkZoZ01Oa01kMzRpWHhE?=
 =?utf-8?B?ZmhmMjRaWm5HRXVFUVMrVzNqMmlNSHR1cWEwcFRVQytOYzBzZytTMjRUUXho?=
 =?utf-8?Q?UwURub5h7ACgtTidXow/D2BK/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1828472c-1fae-4b12-4fee-08ddc5f7c156
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:36:44.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTW/RTVonU0mDgLZxohHS7tSPPpsv3y356bW9V4gvZZuVM8zFRSgNPOmM+ykj6JhgysItXFLUL87KKlM2CWxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196



On 7/17/2025 5:32 AM, Jakub Kicinski wrote:
> On Mon, 14 Jul 2025 12:28:11 +0530 Raju Rangoju wrote:
>>   	/* For Timestamp config */
>> -	int (*config_tstamp)(struct xgbe_prv_data *, unsigned int);
>> -	void (*update_tstamp_addend)(struct xgbe_prv_data *, unsigned int);
>> -	void (*set_tstamp_time)(struct xgbe_prv_data *, unsigned int sec,
>> +	void (*init_ptp)(struct xgbe_prv_data *pdata);
>> +	void (*config_tstamp)(struct xgbe_prv_data *pdata,
>> +			      unsigned int mac_tscr);
>> +	void (*update_tstamp_addend)(struct xgbe_prv_data *pdata,
>> +				     unsigned int addend);
>> +	void (*set_tstamp_time)(struct xgbe_prv_data *pdata, unsigned int sec,
>>   				unsigned int nsec);
>> +	void (*update_tstamp_time)(struct xgbe_prv_data *pdata,
>> +				   unsigned int sec,
>> +				   unsigned int nsec);
>>   	u64 (*get_tstamp_time)(struct xgbe_prv_data *);
>>   	u64 (*get_tx_tstamp)(struct xgbe_prv_data *);
> 
> Please start with removing this abstraction / callbacks instead of
> starting to used them. They each seem to have only one function
> assigned, and there isn't even a null check before calling.
> They make the code harder to follow and review.
> 
> The removal should be a separate patch for ease of review.

Sure, I'll send a separate patch for addressing the callbacks. In the 
meantime, I'll re-spin this patch with the changes.


