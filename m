Return-Path: <netdev+bounces-239849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B605C6D12F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1603353762
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBD2E0417;
	Wed, 19 Nov 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkgtX5QB"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2521E5205
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536743; cv=fail; b=WnkhBvOikHj9wxNiClRYnPNDeatCz9BTZLBQBc8Vkto2Ao66K+CfXl7vqaMjgvRjTpGN5sIIqxyesrdkcUh5f9kAlf8WzCJti/8FasEp7WzQ+iBM/IJX9mxJCdBTNqWCB/Widn3p33DSQLYP0xsklS02qe8taO2oMFGutz3FghQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536743; c=relaxed/simple;
	bh=Q12r/fIQiGKtoXIRf7mdb2cEgyXiRp+vVafcuduFceY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVKCQXm0Uyf4yC7Se70mnavvk8z3D8E+LJwtLoxTW7LO+fy6Nj1cxoIKwojwzPIRiczFs84XgcQHr+O7GFs1VUiafKVlZlo/u085aWIhTo7hJu/gMzZDiInPGxtyXdpdBqLYZz7mb7iK2ih2rJYY0BMSJfAZ7JvPjcZJZ0XGwxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkgtX5QB; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJtn72totxmI+WIo8h754/+0n3YtilcKPJB8sGxDl0hUOAL/zkLvOTnO+z99nJQdVClDaBi0UStXxcYvRvMHrAaZkCVoKfuq6F+x0H4J7z0bbKbDCEzuRTOuynSyAuZsxXp8vai6D5kytpX8r/Ar+1XmySjU1m30UjOuk0ZgBC+D6kdE6ls9KM6Hd5O67Edxlq6dkxBFlDe1UALfbgnSzpzVfE+ODYZEIjijZ7X2KwSlaVLbUiVacbV1aqiMBBlOxWU7BgZ+DDHcm/tQvjaiz3cY/CH0VexKlZAg3heJtcVAR6H8mzpmK86UBFuwSd7UVdCAnqhPKwMxrUL9zzwJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrug1ra+Ih1wkAgaOEIrtmEOsVcaCPMAcEMHKOcy12I=;
 b=ymRSurxZxjFqfaNq4p0mB9DCxTsaIk7RKYf3xWW/Ib5JDHupqD7UhCa2RC1EXQmfdZxk4Hcjlw7ivK47uHLTnwiSLrmoIBWekcXe2eHq8L89nXCj7/Hy154zbw765oqxS7DZZ9ZUcNCwNN9NB+tgyxj7m0dKCNxDcyTJqKldnUbOmNCT0MC1ZjgVCOtu2Sfb+N/olSHa7vRSitaz4r4n9Xg4qHhR9wdBP4bIMwvtrXq6M4rz5yS9LJj7KeoyGSWce1xr7ufI3vahmTVFDVLRhe35TnM9DWfeqxXvRjCIAlC5/VReDXTfK15ZGFws3GyKvtoCQ9dYlkbGkXYnPY6epA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrug1ra+Ih1wkAgaOEIrtmEOsVcaCPMAcEMHKOcy12I=;
 b=TkgtX5QBj/lhydxfVQunaWKy0gt/6CF30c/wA5B+idFII+8NXepNLtRJEJW76fnwPjVIFIUH2acGaM8z5oYLXayqsm4ym3vDazCH1h8tLymWsW4qxhi453bsVbyUofSQMjCiBU1rLmJWvFDETr2IUefg6gRAKFvBq+64W69hmWVec3ejpHWqR/QsIyiqmSpXb906Inn9mBDTZtdtGQMz+QN1vVQL9lVjgPsT0hJEaMjSfAvZtNnhBVEegVBG1QayYgPNpJGe5RhNkJIaKYMKnGKH7fJArZa4kBXJ6XTCd/6aogh1BNUvqh/wj5CTKqbR5OlGIL9WR7YfaWTF8qHcFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:18:59 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 07:18:59 +0000
Message-ID: <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
Date: Wed, 19 Nov 2025 01:18:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier if
 possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119013423-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:4:ad::39) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ca315f-0796-46b8-d703-08de273be843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0RPVXZmS1VIamJ1NVp0WnByb1dvNm1FaTBUUkRqSzFnaTRicTg4Z08xTGlX?=
 =?utf-8?B?MWNpWUhJYWhVek5TeXBwQndZNTFwVUpKQ29yU0d4aGVyWk5lbnJSVTNkTnI3?=
 =?utf-8?B?K1g5THcyWC9VaWpwbENCbTV4dlpzbjhKd0N4c21Fa29yYnlZbVQxc3pxMnJC?=
 =?utf-8?B?eDFDQm1uZW9hMjQyZEczSEo5RWcrVFpoMWJOcXhHamFLL3Y1YWIyYzNUeTJm?=
 =?utf-8?B?RjBOLytQYnY0dkZhRUx4V2Z6UXhHVExURmo4eVhpZktvQzExUVJYTFBXMlFw?=
 =?utf-8?B?dTllNXJsU3J1bzRPNVhtTnU5RFJFWGFUcThIYXZ2R2pBSkF1SlkzY21zSitQ?=
 =?utf-8?B?YVZnK0l0Mi9SUVU5c2RzajlsRzVPQ2JsWkQycjY5UGZERHRVZklVcWRNNFpK?=
 =?utf-8?B?RXcwR1hvMisycmFKbmhCdW9QRUhYSWhDSXczako4aXNoQW9WUDc2YWlOeUFz?=
 =?utf-8?B?M3AwcXlEMnM0VktycGZpeE5KeXVMYTVLQ0RxaERISVZDZnlmUXhxK3B6NFc3?=
 =?utf-8?B?aHV5WlNlYnUxRDBSMzd1dkJHYXpoL2FwSG1rN2J3WHpIZHJkdmpDQWJZM3RB?=
 =?utf-8?B?ZGI3dWE3R2sya2RnQlVmRE9OaGJwdXBJZFArbDJKTTV0MmZ4UVg0eHlQcUlY?=
 =?utf-8?B?YzNGY1dSbHhGSGFlQU05U0w1cTU3bCtiY0RTbFdCWDF2dmt2TVdTUUswbUlL?=
 =?utf-8?B?R3BlRjVpSDV4aFk5UzJWMk1KTXRISmhDLzRHRFVQUkJvQjJSTE5GZTFQeTJl?=
 =?utf-8?B?QUpNZWVzWW91SmxwT0xtenhJTHRJbTBidmsrdlVZUkJUT24zSitweU9JWG0r?=
 =?utf-8?B?Z0xWS0NZQ3l5MVlrc0JRQ3QxVnJUSnZZR3lhUlprVXhXbmJkMEdNU0s3OW1V?=
 =?utf-8?B?dWZweGdPZ1c1RWxJUkdSN0QzeWl2TlhHZWZsS1pmbXdLRTFLMlJjalVPQy9O?=
 =?utf-8?B?anE0NnI5TEdiSmFqeFZubnkwOUVibGFsSHkxNmtzRmlSYm0vZUd3ZXpjbDFn?=
 =?utf-8?B?MVpWN1h0bkdwUTNScDMzczlsRXh2MXNPWXdzMXRDWGl0QnlaVkpTOWxDNEZZ?=
 =?utf-8?B?b2h4c2RhOVl0WU1FbmxVczR0MVJhMmJMbWpVaDZBaFNlcW1La0lwUHh2WkNz?=
 =?utf-8?B?Q3pNMzJTc3lsRGhlSDJKOVk0NWxjVTBMeTNRWHpkK1Jud0hOeGtUaThvYzlC?=
 =?utf-8?B?cVpmT2thb2VFWkhzRFQxTWRCZ1EzWk80K1praDhUNWdIbFlDZEdOYXdUMlJQ?=
 =?utf-8?B?aklocjlCa09xdU1KdEZURmE3TnlwZlZOKzEzUm44T29lZUw5WkNMNDVZR3hJ?=
 =?utf-8?B?QlJRVk1WQVhETGIyM0lRNU9NaXhnT3V0bzkvVFRna0FPR0tTaGEwRmtYNHRx?=
 =?utf-8?B?ZGVMSTMzbWU4U0YrcSt2MHFwMlpQSmtNcDNZYnlRb25SOHRwZGNiTWxtUWJm?=
 =?utf-8?B?RWF6bXJTYjJYcWJJSjh0NVpuNWlFbkUvMkZRQndmcGpIcy8yd3ZEMU5rc0ZE?=
 =?utf-8?B?WUQvNzF6TzZMektRcXRnanIzS2JzWjVoeHhIRVB5VVN6b3BNOUptbGEzeitv?=
 =?utf-8?B?VjJpcUJ4dE9xZjdJMC9yMHpGelNVT09qeWtYbFdWSS9uejNoNDZ3bVRxMVo3?=
 =?utf-8?B?MStuQVhMcWREZEQyTzR4dlFDZk9pY1cxRUVpSHoySXJzZ3hGWnFsbUlRc2VI?=
 =?utf-8?B?Y0xUdmt6aHA0UmRDb2dndWF3R24vdWtXazI4V28wOVFTUlpkdll6K1ZkYnJz?=
 =?utf-8?B?TUwvYWZpYkErZmVmR2tyMVc3dWF3VFFqTmV0Q3pLWndWcmpYekRkbWhjbklB?=
 =?utf-8?B?ZkNaY0gwOGJyV1BndndZN1IwcnRCM25mVEpBYmZzR3lSbEtZYzVsSlFGYzRD?=
 =?utf-8?B?Zkk3aWYvbm1vbWN2Mm5kMGRBQzg5MGRFMXVvSHlYY3F4WVh2VmNhYWorZDBG?=
 =?utf-8?Q?MaZoy4hizYM5Xd4akSmnNqqm2V3MDOmN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZ1ZjZLeDdMM0lGWldSMDZHNzZ6TCt3aSs3N1ZkUkxEQk1aeTAzenNEOEZK?=
 =?utf-8?B?SnQwZldualNLQmo3OFlOZ25PaHBRaGc2amFaazhXckVtVkVUK0JZcEN0ZW8v?=
 =?utf-8?B?bzh1V2srWFRYNFljdG82bFJDYThRWmZROTVzOHRWZ1N0NEc3Z0pJTTJiL0Zz?=
 =?utf-8?B?dmVzNjJGajNRaVkxSUZxUkd1dW1ZYms4QnBzb2N1RERKUWdSVkpLR1Vlc2ln?=
 =?utf-8?B?bUJDeGQwSjRhWUp3dzMrMWE4Q1p4TE1nTXEwVXRXMTAvNkFXaklWeVF0UmJl?=
 =?utf-8?B?OXJwMFFaUWY3dE9Za3hBdnl5UTltNit5Z2RSVTJoT05Ob050Z3FiUnZDTWp0?=
 =?utf-8?B?bWNLaGRVd0pWakl1TnJUWWRiZXcrWEo3R2x2MkxEMW9BcFZ6Rk1zWUl1ZkNm?=
 =?utf-8?B?enBTYXB1MEhocXpRbldKQjQrbUMvYnJDSHRCMFQ4Z0RBdHVEbTZCbFN3Q3hr?=
 =?utf-8?B?ck81ZVdGeXM1S2w2MlFKRXVPNFBOL2hpWitBdlYxaExiTUViR3dDZ3pzT0tW?=
 =?utf-8?B?WEZkelMwbit5YXZIUUdNcjZTWkYwRmJOV3lzQTJ1QkVaRWVyVXROb2ZPeEMy?=
 =?utf-8?B?VCtlOWJhdjZ0VW1uME5OcytlUitqUTdSQ3d1ckNISkRQbnIwaG12NEVWUWZP?=
 =?utf-8?B?MGkvUGNtd2hzRXdPRERsZFBmSTloUFcwaHVuNi9Dakx1UGR0YTNPMEVEdXE0?=
 =?utf-8?B?US9CZDlML3ZwcXZtNm5UaDFJZ25XemUvWDJaSW10YU9hc2RKQVZ1bWlPU3Iz?=
 =?utf-8?B?cDRJRHhNTy90R3ZYNmF1WStKSEFSVmZpcHI3M3BlT3ZETGs1QVp2U1VFU0lu?=
 =?utf-8?B?NFZMU0oxbDdwZTI5emtoQVB5clRpaHZwSGw4aFFwdkxPOEx1cXJDQWFHUlpl?=
 =?utf-8?B?SnAreTlYWmlzWlNjMmR4YkhDYmUxbDVZY2hiejN4eDVVWGJUcExiWnhhTEhw?=
 =?utf-8?B?a1lyZ0V5dGJWd0FXbmZiU3IxR0pmLzNPT1pLZGdER0xTTUFTSXhpSURrMjEx?=
 =?utf-8?B?dkhRbkZXS3gzWXpWc29hNmYzSmVZQXZsaDlQZUNKeFVPb2xkenZRQ2ZZRnll?=
 =?utf-8?B?VXhkSlJwQnlpWmxUSzR6dFhWemprcStzRzRGVWRFeFV0bVFrSHpNNDJma2s4?=
 =?utf-8?B?cXVSZ0Z6K05XRjNSbnFvcjN4NHlBbHhtRzNIdHRKUjRGcTJkZ3VBaG1jY0RV?=
 =?utf-8?B?VTN3bXZSOFlMcm1jMXc2ckcybjFablZyTmhORVkvVHdxWmxTdDM1UDlvQkdN?=
 =?utf-8?B?Zy9INDNFanArN3orZVdDeEg4d1FWVng0dTVPRzc2OVVrblAxNkQ0QmwvZ20x?=
 =?utf-8?B?NUJrRDBvR1FWNUZqeTBZOWkyclJBMTRZTEVwZ0M1RHdlSElndnk3ZTJZdVJS?=
 =?utf-8?B?WUlHUUU2MWgrQ2JLQ3lBL09JbTVXTC8xMkc5RTdINVlBcXpGNE52S0dPUjMy?=
 =?utf-8?B?QU5BSmllalRGNStDOHVORmVGbUtwWVlYRTk4UXJkemFzN0tva3J2UFFiTXpq?=
 =?utf-8?B?K1ZWTWhEWkhiSkxKd1o1VHYrVTlFbHEwdEZzb3QzbHU4Rk05bk9zbVZiZEtN?=
 =?utf-8?B?UnBTelc0dVJOcTJDdE5xbVhiSHhVMU1oTVQwWnF3akV5cDBNTnVOdjlzbUpr?=
 =?utf-8?B?WTNxUzdScWhlT2xHMUYweERzSVR2ays4ZEFmdkVTR2NNM1lUK01xUkNZdDZ4?=
 =?utf-8?B?WlVrR2RJdnBYc20vWXVaaFNMN0txRjhHZDQ0ZU42elZTc0s2QkpHM1NySmtV?=
 =?utf-8?B?VzFIWExLNDNTYkU4M2xCeWx4cmhVN1YxSUVTRzc2Mzd4SlRET3dEcnUycVlp?=
 =?utf-8?B?QVRiZDVPQjV0TmE4ZlpqWkRCTzVCQ0tMbmtZcnRlbzhuMU9aOFJxeStLZGV4?=
 =?utf-8?B?eWtuQkVvRzlFSmJwc3dvdXAzTnRXV0YxUVNPMmZzSmFZTDFwcmgwai9tRXV4?=
 =?utf-8?B?ZVRkbHB4TmZWWkhqenRBUUY3QUpQTnRRbEVxcDlYdVBxaDNLbGRUejM2UnFE?=
 =?utf-8?B?N2IxRm00L3NHay9TOGJhR3lWZXAvR0dsamRETVRZZG9mWG4yVnhzQnBVbDg3?=
 =?utf-8?B?VGhZZ1VHYmlxMmZ1Mmp4UGRnN1lIa2h6NndLdVpnRkRpd29QRXgxTElrVFBs?=
 =?utf-8?Q?ppSh58aJPEKbL5WZD++Znozw2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ca315f-0796-46b8-d703-08de273be843
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:18:58.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQndss2kdvuVHzeQmACsRe5+qZ7r8ABkzIyw89VYgeTst97dZcT+5LebdrvKSpuvQYY6XhrIu2wk4oNDihUsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
>>>> Classifiers can be used by more than one rule. If there is an existing
>>>> classifier, use it instead of creating a new one.
>>
>>>> +	struct virtnet_classifier *tmp;
>>>> +	unsigned long i;
>>>>  	int err;
>>>>  
>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
>>>> +		if ((*c)->size == tmp->size &&
>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
>>>
>>> note that classifier has padding bytes.
>>> comparing these with memcmp is not safe, is it?
>>
>> The reserved bytes are set to 0, this is fine.
> 
> I mean the compiler padding.  set to 0 where?

There's no compiler padding in virtio_net_ff_selector. There are
reserved fields between the count and selector array.

> 
>>>
>>>
>>>> +			refcount_inc(&tmp->refcount);
>>>> +			kfree(*c);
>>>> +			*c = tmp;
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
>>>>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
>>>>  		       GFP_KERNEL);
>>>>  	if (err)
>>>
>>> what kind of locking prevents two threads racing in this code?
>>
>> The ethtool calls happen under rtnl_lock.
>>
>>>
>>>
>>>> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
>>>>  		      (*c)->size);
>>>>  	if (err)
>>>>  		goto err_xarray;
>>>>  
>>>> +	refcount_set(&(*c)->refcount, 1);
>>>
>>>
>>> so you insert uninitialized refcount? can't another thread find it
>>> meanwhile?
>>
>> Again, rtnl_lock.
>>
>>
>>>>  
>>>>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
>>>>  	if (err) {
>>>>  		/* destroy_classifier will free the classifier */
>>>
>>> will free is no longer correct, is it?
>>
>> Clarified the comment.
>>
>>>
>>>> -		destroy_classifier(ff, c->id);
>>>> +		try_destroy_classifier(ff, c->id);
>>>>  		goto err_key;
>>>>  	}
>>>>  
>>>> -- 
>>>> 2.50.1
>>>
> 


