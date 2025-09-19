Return-Path: <netdev+bounces-224707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAB8B88966
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A701D5A21EE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30662F616F;
	Fri, 19 Sep 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cGZ3B0s5"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E82F5A17
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274524; cv=fail; b=LT/HMqYb9EgcUiB2blcSZ3PyYs7B/tot5WiIYRQ+OKtaQbwJc4H7bRLDDkNpXrN3+oE7P+urqfLn3ctLp4S1Bv45+Bag/Imy/0p2xWXGSFuO+nxMEFWmtbpcdDaaldNWlicCOPqrPx5uxSbfDJgBreKb3HzNDkbZQDCfjqFIaso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274524; c=relaxed/simple;
	bh=kiHLHXTYO/rrSO0LFF9EKrutrA6UpfJfwMTRsY7gh30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUUnllTth4YXlhbFKTQ4al+3c8y3ov5oxoi4fviiE/tYN70zGGn6hn5B6ke+k2rlrIYrmU1MBweylYdR82VVaDM0ahIQZKKDAwc60gVE12QLEkdhTCatcLVYzeLqrwiAXxXxPQNGedQwS7XuzEV3BS8Cd+ok5bPCDCf5fRegULU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cGZ3B0s5; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFUgj7jeGRpeXlSXTsmq6P48RMjyQvVKccRhgpvK3AOFfXoEGI8d0NxSqfK2JA7/cF90SpmWp0+7jr/FpzBUY3DlZJ41gHbWmHesNmMqAZLzh0vsCaghEONIHPj3PGq+lyNf4p2gPbCfo+8i8SXg/drzRFhNfT6URb7AXWZihACylkI9GtQSqAVGvglxBeJ+AtV8U8G4DvVbzu8qN98VV15DX1/6qThEyktubZYzSxk8ess4eLUBWj5NOf0vzCcxN9/3+rvzeo8zRiKbdoq51ARS10MaG+xABSOFuGWOqkGJ0N685tssjup1oHfo/uO2w7oZTSoN8m+YiNy/GACTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiHLHXTYO/rrSO0LFF9EKrutrA6UpfJfwMTRsY7gh30=;
 b=IzAUrgfGcOxW6rXYUgdtof7edt2Cjqhzi47rlHg0hkMMx7709RcSzjeIMq7H4VBHcDsve0f6CpUAoxl67P74Mkch+af40LWpUop8LkxL7KxMdSfHEp4P/jJhjwpKDitS3KBVjmDOrPwPl0J3PRo6hZ0u352nxiSrAfI1PAJqJVXUdzuz6k7QTPhegYWtcBowJHnoloFDW1wB6NVwRqVMlyHvIHmgKkIZIL7wi2IACGSitmp1WbJ29PSWdu3zrwPx5q/EsYROJ7T4SbEHeXN3X5189KRlLbgOa9K0UCnGcCbX1sKl8oFd7d+X5nTLNOrpngi9LTgmPqXC3E8WJVB38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiHLHXTYO/rrSO0LFF9EKrutrA6UpfJfwMTRsY7gh30=;
 b=cGZ3B0s5pSDFF3M/qjuilm5epxK/GEY7Tu9N+EJQzr893ulSdmEgqroek3MrK7w85wbXUEFmENGbkdt8wUFOtcbe+5gTgV0sH8G1lkADyDYbcXADbHEMtArqbyUiY1xfzU/obReJ+FVlLqyKWEO2ZP+1Fy7vyZdsa41KlfiJPFHaZlZcClNW4M6AAsKOD/9ccnrii9CwmbQJd7jhjIIlvZwSF2annmofyPTgzZvhqrF1Hjzyt9clcFUZkU1GOMDXb7AOsej2MpWVBMb+46AGATO2vdUsaDorj+gFQ7fy8pRiBn8JojKAYQvEs+RrlROnblsoWjuJHbp7kBsGVSKXkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by BN3PR12MB9594.namprd12.prod.outlook.com (2603:10b6:408:2cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 09:35:20 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 09:35:20 +0000
Message-ID: <850622a8-79a9-415e-a40b-fbb26542e065@nvidia.com>
Date: Fri, 19 Sep 2025 12:35:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] net/mlx5e: Add logic to read RS-FEC
 histogram bin ranges from PPHCR
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Yael Chemla <ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-4-vadim.fedorenko@linux.dev>
 <20250917174638.238fa5fc@kernel.org>
 <4d3a0a08-bda4-483f-a120-b1f905ec0761@nvidia.com>
 <20250918073551.782c5c25@kernel.org>
 <76611a9c-4c53-40a2-96c1-e1cf5b211611@nvidia.com>
 <20250918084000.1b4fb4f4@kernel.org>
 <f84efe86-098f-4783-85af-4289f62804e9@nvidia.com>
 <20250918151845.32a90e3e@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250918151845.32a90e3e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|BN3PR12MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: be3021f2-02b3-4825-4d1d-08ddf75fd953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVZLbHZqODVVNk1DajdHTWwvMWJKSW1BWVBlUkVVeXFuVzJicVQyKzAzWTAr?=
 =?utf-8?B?V0Fwb21oNSt6OGNwN2M1d05HOXNtVkxPL0ZBdXRCU1pkcnRHWERVaG1lM1Uz?=
 =?utf-8?B?Znp2M3hMQXdIUktkMzI5SmJXUDYwT3h4Sy9nZnMzd2I5eHRTUEFoeU5oalVr?=
 =?utf-8?B?M2RIbGxvUUdlOVkrRUp0NXNOc0RoNExMZ0FVSUpPekx1Q1ZGWXpnWEMzTitm?=
 =?utf-8?B?RGJtZno0ekcyK3RremJQNGlDcGNvOGtEc0tDUzc0KzZ3RjhLVWhjOXhibWt2?=
 =?utf-8?B?N05FVklRWTN6Vk8yWVU2NWpudmNENGdHYUlCbkZDcElDUWZXdWoyZHBYQ3p2?=
 =?utf-8?B?MGtXczk1UjgxaTd5UG1tS3V4eWxOb2pxNENhRi9DZzF6SG5hemN5VVIyOWlx?=
 =?utf-8?B?bDJxK2J4SGNZVDNkcXpQNit6UWFsS2Y4d0lnZTA4NDd1ZVpOOENuSHRVckxp?=
 =?utf-8?B?R0U4NnFkcGtCZjZLd1d5Q1VFeWhBUTBlTFN3UUN6MG1pSHFsMDhiTURYNmps?=
 =?utf-8?B?M1NIdXVhQkNBOWdVYkVscEpNeU02QloxRTMzbGJQMWFYZVZmOTBjdmxGVHZ1?=
 =?utf-8?B?WWUvcEVrRzVJL2FOeFVGQzVObWlFTUE2SGMvdExPNXlvRUYzby9rZ1BnWDQz?=
 =?utf-8?B?K3V3YmFyT3lGREkrUVJxQWZXQ1VxOE5vSHJDNDNId2xPekNQOWdSZW01dHpz?=
 =?utf-8?B?OWFPKzV6YUxZKzJUVStvYWV3UXdJcWhlUUhkQUFaQmhpcmtUTG1Eb2pQRDVx?=
 =?utf-8?B?aVJabkl1QXJJRTBmQytwdTVOUngzRWVSWHBxbm9kdkJaN2RsK3JJUmRMMTZX?=
 =?utf-8?B?NGhvQ3R3a1I2RVd5emRPNkFXRThqVGR2bi9BaUNtL2ZVLzN4bXFNUGZkWW5R?=
 =?utf-8?B?aEQxUmhlTitpblREb1hYMUQzSnp0NkxXQiswQitZYjBsNXQxZldwMlF5N29P?=
 =?utf-8?B?V204RDUyYWRJeTA5TSs0ZGlRY0k4SnNGS3lyNDlvSmUwbWY1aGtrSm5VYVp3?=
 =?utf-8?B?RFJnSHBuR0RIVnpZS3V0MUVlYjlWQ3VUcmtMTVVGbnB6NktXeWJLV2x2K3lH?=
 =?utf-8?B?U1h3eGlYZTRBVGQ0K3UzOFFRSDlLanlmY1BhMUhLYWYwNlVPMlBWcWJPR3I4?=
 =?utf-8?B?Y1I2R1FwM3VZRDBpTmtVc3Q2WlZIUVAwbTVDZHdTdzZmblhCZ3dCTFhWbG8v?=
 =?utf-8?B?M3B3dWpwdHZUVGRVSGN4MGYxenA3aC8wSXM0RGFYd1hWRnBTQ25YYzQ3Uk1N?=
 =?utf-8?B?THBXVjdVTGMvTTZMWEpyWlU4ZFFrNHFUaWNHcjVPeEhlcDdHNWRKVXRBLzZW?=
 =?utf-8?B?RkFEckVudHhJQTFFbU13N29lOVVqVmIzNllod3FPOTRxNkRWYkRXU01JL29S?=
 =?utf-8?B?S1BYOXZjTFBCNjlGTTZDRFB6Y1NYbGRtV2NzZHM3MDdvbVkxcGRDMU9hcUdI?=
 =?utf-8?B?a2IzclQyZUlnaHdVU3BpQ2VjZlFBS2ZuMlIrTXNzOWtZZHhRUUtqYlJ3Mmt0?=
 =?utf-8?B?bTdteDlJKzRlSjJRNmZLMWE1REhoQ2J3NHhqZkJXRFN2LzhrZzVQTURtaDY0?=
 =?utf-8?B?NnZaRmEyNkdvM2wwdFVFQmRscS9iMms3MkNnOGFuOHpRSzlBcGN4RFFYSmh3?=
 =?utf-8?B?MzQxWk5zK3dKNUMwelI2ZmdPRTNITEdld1dUSzBtSlFlZm1mbDNMZ1BISmV2?=
 =?utf-8?B?UXlZUk5lZXJ0Q0pZZksrSEJhWjJiOHplSTdzM2grVEhmY25VbUhmV0FCQ040?=
 =?utf-8?B?dEpJS3ZWeUhtTUUxMVpWNEpleEh3WWRTV0FOWVZGVTJ4elQyUExsdTdsT0dv?=
 =?utf-8?B?YURXNkVqRmliQlJ3SGRKdloyL3V2V3BpKzVYZGxwVDUyZW9nRmR6ME95cVRw?=
 =?utf-8?B?eEtYcWc5bktpTTVMNkNHcXBDVm5QQisrTUFKK25aSXhMKy9CUEM1WlMxaHlx?=
 =?utf-8?Q?aLX/VNs3Vb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm8wU25UdjlRQVI0QVBSKzA5OXFGZjE1ME13eGZGSC8zODNvbG5UUTY1c3VI?=
 =?utf-8?B?N3VVNlhCL3hSYndmcEp6ZHJ0MnE2bzlyL2I3UStQaTlaQlNYcjBlSFQ5cXcy?=
 =?utf-8?B?a1kxbitLUmtuM0JWMXRhY09IWGpoZUU1ejYrYnU1Y05PKzRVZ0Jud2dlaVIy?=
 =?utf-8?B?dUp6SkVzRXF3S2QreUZERTFzYlVob2VocDc4TTEraXRZcVhmWEp1d1p1NmJX?=
 =?utf-8?B?RGVHVS9CUUZQSVF3YlgxaWUzc1hNMkEwSXdmeDExVVVQWFBNOFErcm9OR0NZ?=
 =?utf-8?B?L3hKMnN6V3JGNW00UVNGTU56SkdpZXRDS3Vld3BZWTJuS0d1Y29mR1FMYzJx?=
 =?utf-8?B?UnBGWklldUVJOW1ZelloVUg0ZVdZUWdNL00wak9vV0tKZXdtRjQwU2lmZW1J?=
 =?utf-8?B?Mm11RndXMFNJT3UxSzNFWUdtbFlUT3VidHJsRFMxWjVEZ0JwTlEwbEh6d01G?=
 =?utf-8?B?a1JmbE9sb0piRjFyaUZvRlRnKytrL2EvdUgvamZLeHFqVzRuSnRjekJ2elc2?=
 =?utf-8?B?WUdNZUdtaHU3NWxJNnVXVnFhWnY5THB3cVZkd01rMnFXcUhoY3VtTDRlelVL?=
 =?utf-8?B?Znc2RFdhamZWUDdHMktzQkNRNDJqQkJPZXhZYUxnOVJITjA0WmVQZ2Z2S280?=
 =?utf-8?B?L3ZNMWFiWUl0YzJOaDY5bGFYZnkzbkhPc3o4aFdTWlFJWFV2ZENqWW9XMm83?=
 =?utf-8?B?K3ZlMzZBY0swM1h2RDVpM1h3VFcrL0NiM0VjK21PdkxBb1VhYUlxRTJ3S0pX?=
 =?utf-8?B?NUZwZ1hmRG9yQ3FyQ3lIMWRmNjl6YWxXSXJzTTJoZnExcjBJMEQ5NzdMdXhS?=
 =?utf-8?B?UnJwNkdwY1V5M2FKemR6clNCbWFWSFBkOTE4L3BDZXJXc0NMaTh3V1AwS3Vi?=
 =?utf-8?B?ZjNxMUFZYUhGNnZ5Q1pJNUVscloxTzRZSEphVFA5UW44aml4aithMlF2U3c2?=
 =?utf-8?B?Z1Q5Y0VmOThIZlJBSUsyWU1CMFhtVHVqbWVRZ0tmRWx4eEFsZFg2ckxvWk1H?=
 =?utf-8?B?aFVMeHo1Vkt5VzVQbzMwZDlMMUZmU0VzTVIzWHBHNjgreHYxNGh5Q2lkU1Rj?=
 =?utf-8?B?eFdtcnZVOW1odFUrNDU3N0xpRWdlNnRpQUx5TVNjZXlCRk9Ua2V3WGg0T2Rq?=
 =?utf-8?B?d29vQm1Vb3RTekNoZnBPUXdualMrVFZWejN4NXprS2hMV0dhazIyK3FTaGVo?=
 =?utf-8?B?MHVpWTFscEZMM09leHVFeEZJL1VwbFl5eWZ1cjZKTWNNSmFGeDFVa2ZJbjlS?=
 =?utf-8?B?d25rekFvRmx3WTVpUXVLZGUzREFDbGVsMmRYUS9YWnRObFdtNmVmOCtUeVFP?=
 =?utf-8?B?bkNETUpFd051Q1dyT21Za1pjam1jY2FyTHVTRExvNCtQRk9xVG9IOHRHVDZ0?=
 =?utf-8?B?Y1pFcXo0MnA3eFRpVVpiVXJDWCtLVFRxNXB3Z05kaElab2UzOU4xdWxHT2tE?=
 =?utf-8?B?UmRjR3gwdjN3V2FrU2ZBSVRFbHpBRXozMzk4WTlYcWttRnpNWmlOQkJucXc4?=
 =?utf-8?B?Sm94ZWRuV0JVRnNQT1ZVcmZQMkxPdWJ2bEVVUTVtdGxPVzFiSjdQTWFCK3Ni?=
 =?utf-8?B?V25VajdBeTFiWUlMWGZSSXNwWnNHaVBPMW4rQkpwREtSelVTSG1rVFpWRGNr?=
 =?utf-8?B?VUF4MllVaUtzMXh4djNhbmFRa29KeXhIM05lUGdhcUEva096UmYra0FIMStx?=
 =?utf-8?B?dzd4Ny9jTFplNTdTYkhReGFtZGQydFdYckQ1NXdYamxFSHFKcHpuMGxxeSta?=
 =?utf-8?B?NmpaNnIxemxDUmkyaDAwUUF1Qm9PSk0rNVZESmsxVStRRzhML2x6Z0ZtWmVr?=
 =?utf-8?B?SngyNVEydlJJNmpRbVpuQzZPYmRXRmlqS0RNV0NodW9zVHdsT0RlMmxhRkhK?=
 =?utf-8?B?WHd4TVBqQTlFMkpUMnJFb0FpNExQR1Q5SEZiSlJuaWFOUFRxZXlWZTMyMkNq?=
 =?utf-8?B?ei9tR1VUaGRxSmZwV1B4aDVvVzhlYnFRR3dVZGRKQTVYSTRwZjlKTmpWYmRh?=
 =?utf-8?B?ZUhhQ1pNNDhleXQvbHRtTG56R3gxTTJXNTF1RW1pTkJIZkVnTE12WDRWdFJl?=
 =?utf-8?B?b29hQzc5WGlSWjFHQkdVbmY5V0R4emtsS2FxSUpDNHFoNjZYVlNmdWg4N3Y0?=
 =?utf-8?Q?/ss7/ixAuv1dA3MhOJBfQ/vpr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3021f2-02b3-4825-4d1d-08ddf75fd953
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:35:19.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHFC4hzzhr4LModA/ctf6lrjvZVy/sYSHDxHDpLdgoxaD2x1dPZvi3drigmgAmxzna5/Y8gTSkOO/k6hKK7lcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9594


On 19/09/2025 1:18, Jakub Kicinski wrote:
> On Thu, 18 Sep 2025 22:41:38 +0300 Carolina Jubran wrote:
>> On 18/09/2025 18:40, Jakub Kicinski wrote:
>>> I understand that the modes should not be exposed.
>>> I don't get why this has anything to do with the number of bins.
>>> Does the FW hardcode that the non-Ethernet modes use bins >=16?
>>> When you say "internal modes that can report more than 16 bins"
>>> it sounds like it uses bins starting from 0, e.g. 0..31.
>> The FW hardcodes that Ethernet modes report up to 16 bins,
>> while non-Ethernet modes may report up to 19.
>> And yes, those modes use bins starting from 0, e.g. 0..18.
> Which means that the number of bins doesn't really matter.
> You're purely using the bin count as a second order check
> to catch the device being in the wrong mode (and I presume
> you think that device in the wrong mode should never enter
> the function given the WARN_ON_ONCE()).
>
> Please check the mode directly or remove the check completely.

You are right, the check does look like it's combining two different
things. I will add explicit checking for the mode and keep the
WARN_ON_ONCE() to guard against FW changes or potential bugs.


