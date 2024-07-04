Return-Path: <netdev+bounces-109187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4892747B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55BB1C20C5B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FA01AC229;
	Thu,  4 Jul 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Hht+BnCu"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A571A0B10;
	Thu,  4 Jul 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090767; cv=fail; b=mUTyzQjYSqjMd2TEzhP3FaONEhBeVc2jLQCrCteG66kjfz0nlGQfIX45B3RO/3zF5GHCB2skiZp6ftJlVcsvaaNbwCoZRikARU/lzgrZOo6MVJHz97bDjF52eGdWq0GNZF02i9i6POwNBcmI8SDSYj5WTeaRJJQeR4JpzwN+AsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090767; c=relaxed/simple;
	bh=XmiDhDjeRjM71C4kBG4ZPS8UdfiX1JtLv72FZGWTjnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n+yY+LE5+18WgneMeMrNW2Db2jmvZqHEBwIKixiIl3ApT3qgOPmv5gFj6jt0oZG77Ls8lLHd82fWfIg2CBZT6EWd9JQaq1rzGi5fo3l9vOhxH8upxA4WNoQxwJyjD7uE+p+3CZ868v8Sjim6DnCAEVUrycayiu+Ebp2BJR90I6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Hht+BnCu; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA5zzfJcTXHYVd9De3le4I/tZN4Ta/KLeawJQzCimwC7lluH/0i9Bzcaie4/RO5in4YFw9ANkXiKXqEwPEuTeuEOYBNUOPzvuAfNPQttblv9orq/8h6I5yzc9MvjkdNZOipsdeXxCUzN6NGYrt4gneMa8/ebH+U5hOQ4kuLgCF14B+EHxgd5AzBMGFmE00WPy7Yo5oO3QVDx2G3qTt/6896fGBUuQZtbSdLpBQZx4MUMyaj9MnjeghnN6XEamkKU/Nr8tffFRKEwN9gU7OtKvLfNJQN+AfH3j+Sstx5EzscY8qrEG4lvdvMtNYmuQrsdQrB/9fyUYL/+KSMfUwgfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+B8gOjBUST5gXfci2c/RvePkdbYZ9aJVHil+ASr2TQ=;
 b=Ix36LMwMWaH+L54Ehd0pMMzcbv2HWhWaIobXQfNEgxJZgKYO27aB0uwUwgjKi3ZOK15URQLr/Wa+DwhMaCtB5DLJa40F71DbtjinZ7EkDAJjf9ak/KwHFDSgAy5hHfs1ZKzP/t0TgajjH3v8pLc3NvhoXSzsQ7QeTdFcodgIU7oPcyrXsR9xkQS086w2bQe90eloG61MJC5eP7AWo8ooJZi4Twvdj0QoxE7Kzt8/VL+E3Re563pKbzlJ0o1guVAL/uzF4RG4XLe4ll5ntLGb62GTsoDoIntr7ifjjSqbVO+FHksHSo+HoVgh1bLYMwvPrc3KMS2ETbJBgzK183rsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+B8gOjBUST5gXfci2c/RvePkdbYZ9aJVHil+ASr2TQ=;
 b=Hht+BnCukAqXGrunFPR9KiG9ja4erzBfej9R+bu0QIt/E9zFAyo+59eHjYis+AlWq3ZMICKpkdWhjP8WyU7TFvR+YT4+gJ1cz89dIocyvQjYLr0hXjBOmFan+hOt+J2RPdPqXBkaqA7XOLuWHqe5vef45GjPgjfONeGgvKbjrmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by DU0PR02MB10365.eurprd02.prod.outlook.com (2603:10a6:10:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:59:19 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 10:59:19 +0000
Message-ID: <113a83df-119b-4119-b720-61615713816b@axis.com>
Date: Thu, 4 Jul 2024 12:59:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] net: phy: bcm54811: Add LRE registers definitions
To: Andrew Lunn <andrew@lunn.ch>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621112633.2802655-1-kamilh@axis.com>
 <20240621112633.2802655-3-kamilh@axis.com>
 <f07cb96e-9a0a-4a29-91e8-6975e1a2df00@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <f07cb96e-9a0a-4a29-91e8-6975e1a2df00@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::14) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|DU0PR02MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 27eaf9bd-20ac-4c0b-30fd-08dc9c185a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmoyWlNBekdyT3pnTFlGME9zK2R5bVU2Z1YxcTRka1lwRGUwbE5QY1phMzJC?=
 =?utf-8?B?cFVxQmwyWVZwU1lnYUlZb05lOEpzeTZQYXRGSHFvd29ka1ZVMDNFbWQzeGNl?=
 =?utf-8?B?cmxnS0djSFZ4bzNKTzdBYkozYXhUVjJDUlRpVzBuZTB5L3ZZN0R6ZGtEWFBN?=
 =?utf-8?B?NnNkY3NGeUZldW4wWm9PbEU5WE02eDR3NkhoODJDZWVDdndVaHpVZmFzcDdr?=
 =?utf-8?B?dDZQcFNvS0V6Wm52eTkybGZJRVVuQVV2M0xDei9DSHpBTHdLVFlEc1F0ZEll?=
 =?utf-8?B?TFllWDlrbE9CVjhZWEh4dFcvaFFCWDduVWRYWVdJR2RGWXROV2FNSlJiSmVU?=
 =?utf-8?B?bXB3Y3lQRlZieGN5bDVnaThOZTl5TVQyMHFYeHNtM1ZOd2c5aVVjaHAyRTVB?=
 =?utf-8?B?d05jTVZ0ejkxR21tdFp1TC9LY2ttMk9wNFM3Z1JGTmRnSGwxT3g0OTRuS2Rw?=
 =?utf-8?B?WURia3hLUTVGcEZUMENneTBOSW9ZSUJrOHJuMTVXWTRsZlBjWGkrSXo0N2VW?=
 =?utf-8?B?dEI4TS9DQ21qejBMdGh4eVRvMEVtZHBzYW51eVpGSWFXVDA4NmFzRzI0S2do?=
 =?utf-8?B?enB2QXBVWC9IeVZlWktKVEpJK1U2WUNDRXBTRE5CQURqWFllOTFjZE9HM0pU?=
 =?utf-8?B?NExNOVpOdkRVNmpCSEVQWXljUSs5ZThzalBsOEc1U0Qwck1mYTd1NjRzS0pa?=
 =?utf-8?B?bm8weEUrQzJsTURaVzFwWWE1elJYYUxZd2NHeURlU2VyV1V0aldOWlZqRHVk?=
 =?utf-8?B?Z2REdmxMTW9GNDM1L3d3NVNNQmtUSzdNNmVMQTdKbmNHOWk1T2tES3ZEcHBw?=
 =?utf-8?B?Nk9pK2ltcVdqekE4VjlScW9oVHE5WkpyaHBCNVZoTHVLYlB1RWx3bnZUbXFv?=
 =?utf-8?B?UnF2Qi9lL3FPcC94dVJaODFudG5aRnNSUE5mZy9sT3BRNlZrTE9zZ25Pdmh3?=
 =?utf-8?B?U3IrSXdOclpnZHFVTnNvNHEyOCtPYnJpek01VXppMCs5NklJMGhrYyt3eUZT?=
 =?utf-8?B?NUM3UmtmY3lTTHRpdHRoNDU0alQ5ZTdhOHhRTGwxMmM1NHdhSGNOemFUT21k?=
 =?utf-8?B?dDJydTQzY3NTbFYwMnBGbVZidFpjd2JQTU05ZTVwTnV6Vy8wZ2EydjFSTjNV?=
 =?utf-8?B?VE84N3BOaUFiU0lmVlBNRkM0ZEVVNzdGZlVrOG1ueDBmRlF2dEhGQUxwbGNM?=
 =?utf-8?B?TUdvVTliOURWdU1YbG9PVTFtbXpybktLZ1c3VnNFdXhORG85WTFsMlV3WUpt?=
 =?utf-8?B?VEVxd2ZyQVAzZGZaVkdjTC9mOVUrMk56b3JkTy9zZ2RlR3FweC9FRjBjVW56?=
 =?utf-8?B?b3JYMC9ISkJsZVhFeDdkaFR1VDNmVXkvcm8yclRMMzJ4eWdlUnZYenlkRVhq?=
 =?utf-8?B?dVhta3hBSjFRRFA0UGNFOTNzMVh4NGpJSGYvNUdmMXFpNWx4Z21XdkZCN09r?=
 =?utf-8?B?RlBINk14MlJqNldiZjRjQ0ZqMU03b2gwTG42K3ROSXIzVTIyTm5HWUsrTTV4?=
 =?utf-8?B?QmJuUmVkRHArakZJNUZUSU5LRmQ5TTdMWVIwWWdLRTdWUnRQODhXcTFoRm9s?=
 =?utf-8?B?YkZQUEk4SFZqRCs1K3QvblZEUXlOQmZQdTArT2t3YklTZWtNQTNrc0hsNWR6?=
 =?utf-8?B?dStvZDI3V0N5b2tvNkQrYVVWM1dhWDgrVHJiVUN2Yi9LRmZMR1cxM2NuM0JG?=
 =?utf-8?B?Rzl5SXJPMTlZTEQ5SWh4TENpakVobVBpTFArSktvZVZzZG9TaTdFenNTalpR?=
 =?utf-8?B?WkJOQk8rQ0VLRzduS0V4VVBFT2hxdEVDVHBEZ1BKZlIzV3E4cUVMN1NPNjlJ?=
 =?utf-8?B?MGVvYzF1R2Nka0ptQ0psUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVFCSlR3L2NkMGp0WTZwWm4wWmJ0STVFQkwvTnBZQTRiNEYyOW9TY2dMUUhp?=
 =?utf-8?B?N0kwU0JmVGI5OUpoREV6ZTR1TEkvTFVuOE5YNy9mcUEwZ3dGcm9jbmNLRmgr?=
 =?utf-8?B?ZndsMm9CcGxGRWNoRTdYNUQ1dzhjaGc0c3FxbVJKSXpUNFFYMk5rZ0l1K0RQ?=
 =?utf-8?B?MzM0MUZ5Wk1ZcTVYRllmUG10MlIwWkRXOVNZL1p1ZC9ZSHNndVNiZFVkbk8w?=
 =?utf-8?B?THpYRkE0SUdWS0pHUE9rQXphVkdST3Y3ZjVMR1NmMXMvZTMvdWs0Mjh6SXlh?=
 =?utf-8?B?SGpQTXFIUkNualMvanFKVzRkQmxmalNPUHJ4ZEFwTUdRWWdPZDBtNDFVTGJx?=
 =?utf-8?B?Q0U0T1pORkhnZkRmcVFJZ2VWaHBvUXlwb2NRVUJsc2xJb3BoMzNaSVpwbzI3?=
 =?utf-8?B?M2pnd3hXMWxMZGhzTWdLSFdqaU1YR3Nza05GL1BiKytZcXVDU0puZ2dwV3E3?=
 =?utf-8?B?RXN1RmhVc2ZPamtLcWRwcEllMWtROEJ2STl1bHhsV0l6U3pOdFk5a20zb2Fz?=
 =?utf-8?B?QWRhcW5xTlhGZUxGelhtVGF5M2pEbFRieTdYemsveG9vaEZ3d01xekV5WkZT?=
 =?utf-8?B?MFlQU0RIWlpPc01BbStsQkNkOThZaWc4RXNvZ3FYK1VjVVFYSGZqSFI2N3Jv?=
 =?utf-8?B?NE9aRkdWU0ZWZ1AydGJoeWwwM29Yd3hKZXVFNXp5RStmZlhEMUJLK0ZYRGZU?=
 =?utf-8?B?TktqZTZOQ0FlYjRQSldsdlM1Z1RjNmNRNmV5QmtYWFZDOCtjUlBJaFRuT1BN?=
 =?utf-8?B?aUxPWTEvVDIxTEFxR1plOEpab1lDMlI5RVI5MjFXdHNFYlc3QlVWOVpuN2ln?=
 =?utf-8?B?MEJyREJ3a1ZYOTdLemhGSkwyNlR2NFFURW8vVU1mL3A0UTZGYStFcStITkVj?=
 =?utf-8?B?cWxyZUlwYVdUUGp0ZE54QVIxc1UvSkdHSWYwRStJQjUwVjN0RCtJQWxHV1ZR?=
 =?utf-8?B?d1ZzN2txTzRMdzYzaS9xSlFkLzQyWTA1RTdrZEZkMnZCZTFSdE05aDg4NU9y?=
 =?utf-8?B?UEFKais2Y1dPZitjNFFyWHhoWG9QWStvK1I0dmxPVEFEZFlZUXRoUUFtWXk3?=
 =?utf-8?B?bjdDWnRGUWYxQXAzbHVrUEhBbG92QkcrUTBRUjNzYkZ0aEg2eDZmNDgvRHRO?=
 =?utf-8?B?cDkvRG5Mb1A0aFVGbE13VlFjLy9GR1BsampMZzgxM091dXpGZ2tOd2tGZUkx?=
 =?utf-8?B?eEg1U3Y2NWtkTlVpdmZ0RTJ6TWdhK2dmdWdmaFdWWXNYMmtCQVZEa1ZDdGNX?=
 =?utf-8?B?aVEvUmhDNXY0TDh0VjFyZTZnTG40c2NZWnpRNHJpbmxRTWFoL2dZUWVIcVpR?=
 =?utf-8?B?clV1UitNRG1waUQzUzJjSzBpTVIxSytwc2Q4RVRvRDJCRzI3L3NheDhDT2xM?=
 =?utf-8?B?YmhNWXJwM2xjTnJGUVlIamVZbGc1QnBxMDJiUGVzOGRRcGZESW14c2FsKzdv?=
 =?utf-8?B?YkJMcHI3NmNaQ083QzRsRTBZVUhrb0VjSCtwVTByZFZsbXVEcXQ4aTRHQlB1?=
 =?utf-8?B?UHJCaU1CbWhIenozM1FXWVdNTXpTY2o3TTdtZm8rRG1BSGZ4KzRiTHF6eUFB?=
 =?utf-8?B?UHdCZEtoTlVURXBZTjk2K3pqdEJJdmpKY0k2eUVsMEcrcSt0UW1mUUFqNUZH?=
 =?utf-8?B?aHhBbmsyeWFCVk9OQ1UzalZsbEdWVkEvZzdsMG55Mm43V1h6VjZUcGg4d0s4?=
 =?utf-8?B?RVdqd1drV3RGdlBKUTZkcnJsTnhGM2V2MmpyazJBR2RSYVhIUHJlcDJheE9R?=
 =?utf-8?B?Qzc5cUY1NEJYRm1xUEc4MXB2R3RXbEVhNm03RG5vckNzSUNKbzJjSThIL3Nx?=
 =?utf-8?B?empvTmhtVzVlZURMU0FGQXkvejVieC9pb1R0RXM5anlmVUJTWlphclJyK0tG?=
 =?utf-8?B?UTRZS0JMcUpDNU9tZ3ZZZGVSRXc0WXZhbWtMeWk4VFVzNk1KaXllYUM0NVFn?=
 =?utf-8?B?alA3RXhJN3g3M0ZvdWpMaFRva2dDa0ozcHhMQ0hVU2hkWmcrSG81OGVJNm4w?=
 =?utf-8?B?QkwxTTE1amwrQWRpNUQrZW91YkZpb0Yxbm1Ka2VJeUhJcHMzT0wyd0lCTEF2?=
 =?utf-8?B?M0hiZkZ5dXZsU0hRNFRYL0VRbFFrR0dsZjYwZk40TnVobnVnZ1cwd1ZQWkhP?=
 =?utf-8?Q?hrho8Q1s7GKY9AVydhQ1F0wn3?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eaf9bd-20ac-4c0b-30fd-08dc9c185a6c
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:59:19.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Fk9qLL54SgGbIq5ZQ44KghmKBNrlpGclwtlUWO9rG/Fodpj7VVlffNFk92GuKk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB10365


On 6/22/24 20:37, Andrew Lunn wrote:
> On Fri, Jun 21, 2024 at 01:26:31PM +0200, Kamil Horák (2N) wrote:
>> Add the definitions of LRE registers for Broadcom BCM5481x PHY
>>
>> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   include/linux/brcmphy.h | 89 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
>> index 1394ba302367..ae39c33e4086 100644
>> --- a/include/linux/brcmphy.h
>> +++ b/include/linux/brcmphy.h
>> @@ -270,6 +270,86 @@
>>   #define BCM5482_SSD_SGMII_SLAVE		0x15	/* SGMII Slave Register */
>>   #define BCM5482_SSD_SGMII_SLAVE_EN	0x0002	/* Slave mode enable */
>>   #define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
>> +#define BCM5482_SSD_SGMII_SLAVE_AD	0x0001	/* Slave auto-detection */
> That looks odd. Is there something subtle i'm not seeing here?
>
> 	Andrew

Obviously an artifact from replaying the commits again and again... :-(

Fixed.


