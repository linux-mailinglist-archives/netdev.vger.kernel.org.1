Return-Path: <netdev+bounces-259414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO8DE3fPlmkZoQIAu9opvQ
	(envelope-from <netdev+bounces-259414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:53:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D415D205
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1DAE300DF71
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668A1DF25F;
	Thu, 19 Feb 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppKLfVS/"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAF334C25;
	Thu, 19 Feb 2026 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491188; cv=fail; b=Qs66UhXbyAQ96UVXGnXYNIF1d/RR6x3WDzUCr9iXRLEr/S1TDF7LQH7/GBMaZj2XKKYD/Kzf/zZH+gqGPm7e2HI/We0f7VgBl+Xwie3ZU1vZcrHglw0cDGdlzPs1XeuyWV743COF8m0qNJxqVOmZ6FdJYcvtsypFcDu+khJO2cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491188; c=relaxed/simple;
	bh=0WtAHDpf60fszl2LkBSvLNOJX6y283eoblVPNWaCc6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=otSwTlZDhTbuAZyAaxMStI/FL12xr9UDCKKUdy43IPTbVya0IGms+hIhZ7yEcGkEEFvLetIOyPAYr/aJZUBfSEqRpF/yY8v/UnWZlBWwF5ocJl8TDMmkp9+2BiNxwNNL/xQustKeSk6hqNQqZeerV598uvUDHsJgwmZxEDHEtFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppKLfVS/; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1f/1NjaCaHCJ/Qtxa0326eiDWUe6K+faQhLI9/L0K7Oqjz9VfE4M2Fe6C8YMPjIqEIh4wSnnLT4TpKbd7in63ipsAg7G6+qpSavCZsGAzqkrYIyqYjXckSq84RrU+RgedZipt7wlVEKU/ZZgsqRBm7ZrODDRBKANyCyHg5Dq+phynawwB4cjBIGhpU7QTr9XjQZYAJ8m/H+eL/B2z3T52Mc1SztzbT+XDzyx5qq19AhrNiA3OzfUwoT/CUVxt66BrTCeyDEswqjvCApqYrPdShsnsORh9oxD/zWU42B6S9EUDqsqwAFDNxhxuHC0wtnJuVecx/T1zllYblaz/33AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A/BVnGROES/F8ByQ3EX8A2JtL98zpUhebiCgnuqUGs=;
 b=KMhnF1f9X/Qlu7lN7Ng8Bsey1ZH8prAOaEwvAJvLMYTxecZcVrsYhvmp3yEa12zIhQ4x16A2zgtiQZ5qYlrclUinWPVn4p/WRlJwj+9jT6kMAZwHYDLsMz4UIGoF1J61Vv5tTwbT5l4WMHoV5etOgJYXocUWYYmEEuvK4dskaAUaQqFLMeJA4uP22Ki3itS0kABLyiD/fjSUwU2Rk81isrwzasyKtc9KScFSzLX1hU8XKH/Z6aCrwGzN0XaFW8pmLCMkPZlYi/j0/6dIdGYjJMST7TjBgWkcxbnAVCP3YFl8A9gTV+91wNkfKSpPaTYAVIQ2MtZlKy82qooLNwcMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A/BVnGROES/F8ByQ3EX8A2JtL98zpUhebiCgnuqUGs=;
 b=ppKLfVS/87KXatTzgfJkvoM/zlZEn6EhjkeLiVdL9MRDhNobXb9SksgZyB+HtrEZOxQ/X5jvBMrnpZWvlryo5UKr5ZRH6Qcc1q+kyGU54v2c+rYha0z8TGiCnMSU3wD5FhYt8w0TGic9mJj+TfzKDTVdUWoM+nytAvye11X020M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 08:53:03 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:53:03 +0000
Message-ID: <befd908e-8659-43dd-8ae3-38ca8e3327e9@amd.com>
Date: Thu, 19 Feb 2026 08:52:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 01/22] cxl: Add type2 device basic support
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-2-alejandro.lucero-palau@amd.com>
 <571b10d2-0b07-4121-8444-1f92a12c32a1@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <571b10d2-0b07-4121-8444-1f92a12c32a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::33) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 67970b74-f21e-44b0-3f20-08de6f944a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5RVUNMVlgxcWhNZmJrUlNhS1RTYkwwTFpURmVxNGgvY1lpRGlxQzJKY0lK?=
 =?utf-8?B?U3paTXpkakM0aWtqYktlTml4YTRpZ1hwNWNFUTNoOXVrNjZrZ0lhb1RXM3JH?=
 =?utf-8?B?QzF5bWpZdVJvVG1VVHdzUVp2UmduaXZQR3ppeDFYWVU3Q2M3SmtDOEhrK0Vr?=
 =?utf-8?B?VEVGSDdKaWJldE9GaFZYQUVaYTY4SG01Y1ZXWXI0MXE4ZmM2TllXaVdtV1JK?=
 =?utf-8?B?Y1h5cWttL2FlR21qTGIrVzZSbzlYRW1EaytFcnNtdmJJRmsxSTRraFVLMEVa?=
 =?utf-8?B?cXZ3NHBHU3FkQThDaGlxZXdwdnJ2U0Q2RDN0ZlA0WktJQ3JXL29aZS9iRDhR?=
 =?utf-8?B?K1N2MXAycTBRMkZCSm9obEpidVFHN0RUcmpCMGFVUmQ1ZWlmR2tFdUdPeUd2?=
 =?utf-8?B?bGhicmVQSlVzM0RGNGhjTGpPYy9uNVVIRndES25wWUo4UmtheHRoTGJxMHZt?=
 =?utf-8?B?RzFsS1p5Y3dyLytzbFdHZDE3bHZFWXQ5LzhDNDhoUkpLY3JEQXR2M2dhQWN6?=
 =?utf-8?B?TFhEcFU4WUF3akdOTFBwOE15LzZZRDExZVRxSE9qRE1lalZsdDEzNkFsL2RY?=
 =?utf-8?B?UU9vb0J4Mk9LRGN3TlVScTlLY0t4Y3hKNEtwdHZzSmJHYy8vM2tQNi9vWkp5?=
 =?utf-8?B?c05GeWRTeGpmcG4xOW9VL2ZFNXphR1Yxek1QYXljOTlVSHVxRW1SdWVLWEt0?=
 =?utf-8?B?T3JDUWQxZHhEaEdHSFZaSWxtZkZxSW91NWtBUHNqeERjTERXdFhqVjZWQmhh?=
 =?utf-8?B?SFNuS1d0RjVHWG50THJpSDJCUURxcTU4clVVVTJTSWRONkpKTDNzZGpwQkI1?=
 =?utf-8?B?RkxVbi9OdlU2RllFNTJnUkY0L1h0bEhmMUxvRmluaTRNMWppb0g4UWk5Zmho?=
 =?utf-8?B?V01mVTVBSUx2TjZzKzd1aUxMWDEvV3c0TWNrTWM4dHFWUXc4cjVqb2g1NU1w?=
 =?utf-8?B?dURwZUZTeXBjV0lCWnpNbC9VTXR5cG5BR214UmNEYkZDeGJvTEsvWHgwV3R4?=
 =?utf-8?B?bStKM0VMTXhWbVk0Q2RLWlVNMzAyem1nNWdVZWRTMmo2Vk9zeHdKSGdEYzRK?=
 =?utf-8?B?TEJqWDVLZXZrcENCTEx0OFVKejF1TW5MbmQxdC84eXMrczA2RUFXRy8vNkhk?=
 =?utf-8?B?RkxaYXpQZXJPRWxTcWFHeHYxNXR4S1VQY2N4N3ozSzhCQzYzVjdwRXgvbUsy?=
 =?utf-8?B?OFpFb3FCdmdrbXI2RGxMd0YwbnhUTVlxOTRKcmJFa2hWdXhOZVV2Z3BuNzNv?=
 =?utf-8?B?NUxGNGxKbkdac0hEemcyV2xRYXlPRmgxN2lqVnFmUFg4ZG92WUwvMlFDbUwx?=
 =?utf-8?B?MXZ5elhXSWkrU2xkaERJRG9yVXVQUHNTV2wvWTJ5UWQ4RHJVRkNyTElpeEtv?=
 =?utf-8?B?d1JaN2c3V2hDQkZId2k3NkdwRlBIcDBwTXlPWDQ4MXdUamlRQzMrWGV6ZEpu?=
 =?utf-8?B?WkpPU2NSNWY3RENQSlNvLzV1bVUrMklwUWJCd1hUNjd6OGxDQWQ4Ym9LUnU4?=
 =?utf-8?B?TUx2c3MzVGtBaFE1T0NaTmF6QzV1dkR6a2RxK2pEUHZOeU9jNlgrZkNYYjJW?=
 =?utf-8?B?dnpPRm1wYnZXZlUwVDQ2elczR0VlRDZ4eXN3VnRqTkZ3NTR0UldCTUh3aVNu?=
 =?utf-8?B?SEROK1JyU3ZiOTR0NC95ZGk4N3NHcVNyTEtYbUZYSmhJd1dNRlpJd1FrV2Zs?=
 =?utf-8?B?VjBKL3FYN3FuMzJiWWJBWklGZERubGFva2h6d2pQemN5MnE0eXAyS2VOajFM?=
 =?utf-8?B?b3NxaVpsQllKM0V1U3M0ZHlBYkpQRk9pbVVuUjJJdDdLWU1IWEZVSThETkZZ?=
 =?utf-8?B?U2NCUlA0Szk5eUlEZ3Fma3hrUldlb2dQUE1NSi81c2M3ejQ1Ry82ZW9BN28w?=
 =?utf-8?B?bjFySmFjSDYrNFhjNWNNMVpLenpnclFPWENqRVBqRUZNbWRXbk5NdDhETU1v?=
 =?utf-8?B?em1Pa1NWMjIrWWRXeFEycmEvc3lQVWFQc1VlbzhCaFlYeGZYc3ZZRXl0Ynlr?=
 =?utf-8?B?a0JoRklGdGhuZ0NHVGVzNSs3RVZyOUdiTk91NE45dXl1aFZQU1NEMWwwMzFT?=
 =?utf-8?B?NE1oM0Rwc3ZGK2ZlYjVFM2FsaG1Zb2lFUXgwNXh4VXYwTFJFLzNUdk9ORmF4?=
 =?utf-8?Q?Odls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFNQ2RSbm9WZzdDTWdjdnZ6RFZXM2o2cHFZUzlKbkVIMDJIZ09hODh6aDhH?=
 =?utf-8?B?YS95aFp6bVhrdElVTGhiME9zQUoyZm0xL28xdkxSYUc3czFpSndqRjkzMDlN?=
 =?utf-8?B?SkljZEd0VW5kUmFaKzJOd2FScExOY0tBc0I2b3NWWHluN0grLzVrZGc0OHMz?=
 =?utf-8?B?N1pvV093VWdSY2FwVzBGb1VPTklIV3FBT1lZVytqRExaYzVHWDFBdjllUDZB?=
 =?utf-8?B?bkZ1aWNrdjZmeGFuRjh4RW1abS9hK3daSWg1TmFPbmtwQUdtckFGYUg4ekVI?=
 =?utf-8?B?N1VWSFZOSW9ZTDkrUDhOaHJFS0Z4VkV6d3Vtc1NUbktpWWZ3d1RPR1VUUklE?=
 =?utf-8?B?ZXk4U2hCVkg5UEM4ejB1MTQrQWJWVTZJTUtMckxvK0g5M282aWpLVkpLQnF3?=
 =?utf-8?B?RUlraDgyazNyUU02N05vUjlJUzdQTUVNZ1ZuNUIwdWpaUHYyMmNjNE5zb29U?=
 =?utf-8?B?WVRIdmNxWHdZSitlZmZqbGVETXRoV1FQZWxpQjJIdVA1SjVvS3hXVUxDd3Uv?=
 =?utf-8?B?YWpHengrNmRHWkZ0bVRNdU9UN2tGOFh4cms4ZHBNam5NNVFkdE1qMm9qVm5I?=
 =?utf-8?B?MW0vOWpEVjhnNlQrNDFpUVJSWURQKzNYMWV5UHFZSHZZMkpUeHB0dUc3Z2RQ?=
 =?utf-8?B?dXBWOGFWMWlMUzN6T2p0TDRDTnBNS3F5R3VoSm0ybjFJZmRydWRwN21iaWVD?=
 =?utf-8?B?cGxneVhOdzR3dTNzK2g3emFHL0laREh1Rmp5ejMyeXlPS2RIR25LeGRkM0FO?=
 =?utf-8?B?bUZsQ1ovUDBHZDdmMVFOekhlaUxiRGpNOXJCQTJIcGFsNmlhd0hSWFl1amNr?=
 =?utf-8?B?Q3lMVk15MHMyQTlZNy9ML0VKY0pKcWRXaEFnQmdqRTFIa1dvOFNJREVpOFRh?=
 =?utf-8?B?TUN3cEFZYm5vblEzRlhHR0Y1TTVxRzVRbmJOc1ptcG44ZW52azBOa2NtL09t?=
 =?utf-8?B?R2NnK0tEeFFxVGRacUpPeDB2UnJwV3dIS1QxUWhJQWlDQTlQRXVmSWpYY2xR?=
 =?utf-8?B?djkzNURVSWFKV3lmRzdoK2liNE9LbEFiMFFodTlnQm9SSnNkS0VHa3hnVUhj?=
 =?utf-8?B?MEE4VWI2MnJlcEl1b055MjFRRFEyTUMwYmJTM0xNZExtbGJQd1lRbG1PaVpm?=
 =?utf-8?B?VWo0cWpsblJpT1dBNzBpK2Yxa3ZlYnFLOHQ3VmIyamNCMk5KQnFhQnFOdlNu?=
 =?utf-8?B?TmdFdkVsRXo2VkVHQXlscXNGaXZ4Q2JteGJHOEM0NVpjZnExTWRRRm5WRlB4?=
 =?utf-8?B?QUt5WE5MR015UGE4WStWS0tpeEtNY0RlRWNnOVVEaVZBam9iMUlWZzFycnEw?=
 =?utf-8?B?dGR6aTVwbE9NblNVcjlWK0dLNUpwbHZTMS9rMkVaMnExTDJYcVpENmFzL09T?=
 =?utf-8?B?d3dDR29WckdIZ1dxK2RpdmovWGF3cVl0elBmSThuQzhsYmRzc29UWWczSzh1?=
 =?utf-8?B?RWp4QVdiSjN1cHc5SHNOaURla09CNmpJWlE5WndmSXJDZXdtc0ZNeEM1bHQ0?=
 =?utf-8?B?bVFxS0pmL3ozZW9Nb0doa0dkZXd5b1ZXSUtLSHgzRHg5R2g1Vm5DMDhxT2Jq?=
 =?utf-8?B?TXVWYld6U3JrRllTTjgrMzBXZ29pc20rMHVVdVNKV3F0VldlL3JLc3pPQWRx?=
 =?utf-8?B?cUxlamE0TkoyMjJacUVCdkpRWm5HclZKcW0wTDlLSnVZNzk1WnhsY1BKc1pk?=
 =?utf-8?B?NFJiYThKZjNVQnk3M3E3WkJPVloxaEFuZFpmalRKbmtQQXNsMlhWK3orOWx2?=
 =?utf-8?B?U3gwSnZWeWlBTDdKN1Fiam52RklBbXVGdHM4NURsM0ZZRW9XQXpCZC9EcGFt?=
 =?utf-8?B?U1ZaK3QzUnpJaDlQeXMraGhnQ3hTenFrQkNMNDRYWHowK0pkTmY1YmExZ2RK?=
 =?utf-8?B?K3ZEMHo5UHpERFM5RUM0RStEZDlMa1pFdSsyUHZhQW5WRVBSV0gzZGRSWWVl?=
 =?utf-8?B?eDJBRTJndTdSWkJQbGdVWkxoKzMxRkxaQ0FVcXFoQjg4alpVdkVLc0NOclJr?=
 =?utf-8?B?c3Q1RkRqL3RHb2J6WUxBcFB3VVVKeHMrM1RrY3JaT080WHdLd0tiZ0JwaENG?=
 =?utf-8?B?NkduRjFpT3JkNDh3clhXTGdKdWFPc1N4d0NBc0p3WlN4UkVNR3JzRGp2NjRQ?=
 =?utf-8?B?c0hLbjZsVXZKUCsybnhOS2tseE93djlkUFNXcTJOT1hLU3lGU2EyY0xJS0J4?=
 =?utf-8?B?VTEvOEE5b1VhNGx6eG4rczlIUGl5Z0twc0taUXU1bVNHNzlpOUllZTdwUTBs?=
 =?utf-8?B?czJ3c0pPaUNGUHE0U1E4M2hsVlFMRnV3THRWRUkwbnYzZTZrQmNPMUdoZ2hW?=
 =?utf-8?B?djd1OXBrUlV2UjdTalZDYlFEMnM0RHZoeDI2TTVBTEh2OUl6Tm53Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67970b74-f21e-44b0-3f20-08de6f944a52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:53:02.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNhIvAwBiMCKapH5U0qfgzU6rtfV/+8JIGwhn4UcONHT+eCYoxe0U/qPgkoASupuMJ/Ji029xVA07L3uIsN2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: 645D415D205
X-Rspamd-Action: no action


On 2/11/26 22:11, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>   drivers/cxl/core/mbox.c      |  12 +-
>>   drivers/cxl/core/memdev.c    |  32 +++++
>>   drivers/cxl/cxl.h            |  97 +--------------
>>   drivers/cxl/cxlmem.h         |  86 +------------
>>   drivers/cxl/pci.c            |  14 +--
>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>   tools/testing/cxl/test/mem.c |   3 +-
>>   7 files changed, 274 insertions(+), 196 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index fa6dd0c94656..bee84d0101d1 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1514,23 +1514,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>   
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec)
>>   {
>>   	struct cxl_memdev_state *mds;
>>   	int rc;
>>   
>> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>> +	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
>> +					dvsec, struct cxl_memdev_state, cxlds,
>> +					true);
>>   	if (!mds) {
>>   		dev_err(dev, "No memory available\n");
>>   		return ERR_PTR(-ENOMEM);
>>   	}
>>   
>>   	mutex_init(&mds->event.log_lock);
>> -	mds->cxlds.dev = dev;
>> -	mds->cxlds.reg_map.host = dev;
>> -	mds->cxlds.cxl_mbox.host = dev;
>> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>>   
>>   	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
>>   	if (rc == -EOPNOTSUPP)
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index af3d0cc65138..22d156f25305 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -656,6 +656,38 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +static void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
>> +			       enum cxl_devtype type, u64 serial, u16 dvsec,
>> +			       bool has_mbox)
>> +{
>> +	*cxlds = (struct cxl_dev_state) {
>> +		.dev = dev,
>> +		.type = type,
>> +		.serial = serial,
>> +		.cxl_dvsec = dvsec,
>> +		.reg_map.host = dev,
>> +		.reg_map.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	if (has_mbox)
>> +		cxlds->cxl_mbox.host = dev;
>> +}
>> +
>> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>> +						 enum cxl_devtype type,
>> +						 u64 serial, u16 dvsec,
>> +						 size_t size, bool has_mbox)
>> +{
>> +	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
>> +
>> +	if (!cxlds)
>> +		return NULL;
>> +
>> +	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
> Nit: Having a second function to do the init seems overkill here, especially since cxl_dev_state_init() isn't called outside this
> function. I'd fold it into this function instead, but I'm fine with it either way (especially if you were told otherwise before).


Hi Ben,


I do not remember why this was done this way. Maybe some initial need 
which disappeared later.

I can not see a reason now, so I will do so in v24.


Thank you!


>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops,
>>   					   const struct cxl_memdev_attach *attach)
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index e1d47062e1d3..3eaa353e430b 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/node.h>
>>   #include <linux/io.h>
>>   #include <linux/range.h>
>> +#include <cxl/cxl.h>
>>   
>>   extern const struct nvdimm_security_ops *cxl_security_ops;
>>   
>> @@ -201,97 +202,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>   #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>>   #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>>   
>> -/*
>> - * Using struct_group() allows for per register-block-type helper routines,
>> - * without requiring block-type agnostic code to include the prefix.
>> - */
>> -struct cxl_regs {
>> -	/*
>> -	 * Common set of CXL Component register block base pointers
>> -	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>> -	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
>> -	 */
>> -	struct_group_tagged(cxl_component_regs, component,
>> -		void __iomem *hdm_decoder;
>> -		void __iomem *ras;
>> -	);
>> -	/*
>> -	 * Common set of CXL Device register block base pointers
>> -	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
>> -	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
>> -	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
>> -	 */
>> -	struct_group_tagged(cxl_device_regs, device_regs,
>> -		void __iomem *status, *mbox, *memdev;
>> -	);
>> -
>> -	struct_group_tagged(cxl_pmu_regs, pmu_regs,
>> -		void __iomem *pmu;
>> -	);
>> -
>> -	/*
>> -	 * RCH downstream port specific RAS register
>> -	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
>> -	 */
>> -	struct_group_tagged(cxl_rch_regs, rch_regs,
>> -		void __iomem *dport_aer;
>> -	);
>> -
>> -	/*
>> -	 * RCD upstream port specific PCIe cap register
>> -	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
>> -	 */
>> -	struct_group_tagged(cxl_rcd_regs, rcd_regs,
>> -		void __iomem *rcd_pcie_cap;
>> -	);
>> -};
>> -
>> -struct cxl_reg_map {
>> -	bool valid;
>> -	int id;
>> -	unsigned long offset;
>> -	unsigned long size;
>> -};
>> -
>> -struct cxl_component_reg_map {
>> -	struct cxl_reg_map hdm_decoder;
>> -	struct cxl_reg_map ras;
>> -};
>> -
>> -struct cxl_device_reg_map {
>> -	struct cxl_reg_map status;
>> -	struct cxl_reg_map mbox;
>> -	struct cxl_reg_map memdev;
>> -};
>> -
>> -struct cxl_pmu_reg_map {
>> -	struct cxl_reg_map pmu;
>> -};
>> -
>> -/**
>> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
>> - * @host: device for devm operations and logging
>> - * @base: virtual base of the register-block-BAR + @block_offset
>> - * @resource: physical resource base of the register block
>> - * @max_size: maximum mapping size to perform register search
>> - * @reg_type: see enum cxl_regloc_type
>> - * @component_map: cxl_reg_map for component registers
>> - * @device_map: cxl_reg_maps for device registers
>> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
>> - */
>> -struct cxl_register_map {
>> -	struct device *host;
>> -	void __iomem *base;
>> -	resource_size_t resource;
>> -	resource_size_t max_size;
>> -	u8 reg_type;
>> -	union {
>> -		struct cxl_component_reg_map component_map;
>> -		struct cxl_device_reg_map device_map;
>> -		struct cxl_pmu_reg_map pmu_map;
>> -	};
>> -};
>> -
>>   void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>   			      struct cxl_component_reg_map *map);
>>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> @@ -497,11 +407,6 @@ struct cxl_region_params {
>>   	resource_size_t cache_size;
>>   };
>>   
>> -enum cxl_partition_mode {
>> -	CXL_PARTMODE_RAM,
>> -	CXL_PARTMODE_PMEM,
>> -};
>> -
>>   /*
>>    * Indicate whether this region has been assembled by autodetection or
>>    * userspace assembly. Prevent endpoint decoders outside of automatic
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index ef202b34e5ea..281546de426e 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -113,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   			 resource_size_t base, resource_size_t len,
>>   			 resource_size_t skipped);
>>   
>> -#define CXL_NR_PARTITIONS_MAX 2
>> -
>>   struct cxl_dpa_info {
>>   	u64 size;
>>   	struct cxl_dpa_part_info {
>> @@ -373,87 +371,6 @@ struct cxl_security_state {
>>   	struct kernfs_node *sanitize_node;
>>   };
>>   
>> -/*
>> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
>> - *			 HDM-DB, no requirement that this device implements a
>> - *			 mailbox, or other memory-device-standard manageability
>> - *			 flows.
>> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
>> - *			   HDM-H and class-mandatory memory device registers
>> - */
>> -enum cxl_devtype {
>> -	CXL_DEVTYPE_DEVMEM,
>> -	CXL_DEVTYPE_CLASSMEM,
>> -};
>> -
>> -/**
>> - * struct cxl_dpa_perf - DPA performance property entry
>> - * @dpa_range: range for DPA address
>> - * @coord: QoS performance data (i.e. latency, bandwidth)
>> - * @cdat_coord: raw QoS performance data from CDAT
>> - * @qos_class: QoS Class cookies
>> - */
>> -struct cxl_dpa_perf {
>> -	struct range dpa_range;
>> -	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>> -	int qos_class;
>> -};
>> -
>> -/**
>> - * struct cxl_dpa_partition - DPA partition descriptor
>> - * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>> - * @perf: performance attributes of the partition from CDAT
>> - * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
>> - */
>> -struct cxl_dpa_partition {
>> -	struct resource res;
>> -	struct cxl_dpa_perf perf;
>> -	enum cxl_partition_mode mode;
>> -};
>> -
>> -/**
>> - * struct cxl_dev_state - The driver device state
>> - *
>> - * cxl_dev_state represents the CXL driver/device state.  It provides an
>> - * interface to mailbox commands as well as some cached data about the device.
>> - * Currently only memory devices are represented.
>> - *
>> - * @dev: The device associated with this CXL state
>> - * @cxlmd: The device representing the CXL.mem capabilities of @dev
>> - * @reg_map: component and ras register mapping parameters
>> - * @regs: Parsed register blocks
>> - * @cxl_dvsec: Offset to the PCIe device DVSEC
>> - * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>> - * @media_ready: Indicate whether the device media is usable
>> - * @dpa_res: Overall DPA resource tree for the device
>> - * @part: DPA partition array
>> - * @nr_partitions: Number of DPA partitions
>> - * @serial: PCIe Device Serial Number
>> - * @type: Generic Memory Class device or Vendor Specific Memory device
>> - * @cxl_mbox: CXL mailbox context
>> - * @cxlfs: CXL features context
>> - */
>> -struct cxl_dev_state {
>> -	struct device *dev;
>> -	struct cxl_memdev *cxlmd;
>> -	struct cxl_register_map reg_map;
>> -	struct cxl_regs regs;
>> -	int cxl_dvsec;
>> -	bool rcd;
>> -	bool media_ready;
>> -	struct resource dpa_res;
>> -	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
>> -	unsigned int nr_partitions;
>> -	u64 serial;
>> -	enum cxl_devtype type;
>> -	struct cxl_mailbox cxl_mbox;
>> -#ifdef CONFIG_CXL_FEATURES
>> -	struct cxl_features_state *cxlfs;
>> -#endif
>> -};
>> -
>>   static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>>   {
>>   	/*
>> @@ -858,7 +775,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>>   int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
>> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>> +						 u16 dvsec);
>>   void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   				unsigned long *cmds);
>>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 1cf232220873..24179cc702bf 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -911,25 +911,25 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   	int rc, pmu_count;
>>   	unsigned int i;
>>   	bool irq_avail;
>> +	u16 dvsec;
>>   
>>   	rc = pcim_enable_device(pdev);
>>   	if (rc)
>>   		return rc;
>>   	pci_set_master(pdev);
>>   
>> -	mds = cxl_memdev_state_create(&pdev->dev);
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  PCI_DVSEC_CXL_DEVICE);
>> +	if (!dvsec)
>> +		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
>> +
>> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
>>   	if (IS_ERR(mds))
>>   		return PTR_ERR(mds);
>>   	cxlds = &mds->cxlds;
>>   	pci_set_drvdata(pdev, cxlds);
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>> -	cxlds->serial = pci_get_dsn(pdev);
>> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
>> -		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
>> -	if (!cxlds->cxl_dvsec)
>> -		dev_warn(&pdev->dev,
>> -			 "Device DVSEC not present, skip CXL.mem init\n");
>>   
>>   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>   	if (rc)
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..13d448686189
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,226 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2020 Intel Corporation. */
>> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_CXL_H__
>> +#define __CXL_CXL_H__
>> +
>> +#include <linux/node.h>
>> +#include <linux/ioport.h>
>> +#include <cxl/mailbox.h>
>> +
>> +/**
>> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
>> + * @CXL_DEVTYPE_DEVMEM: Vendor specific CXL Type-2 device implementing HDM-D or
>> + *			 HDM-DB, no requirement that this device implements a
>> + *			 mailbox, or other memory-device-standard manageability
>> + *			 flows.
>> + * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
>> + *			   HDM-H and class-mandatory memory device registers
>> + */
>> +enum cxl_devtype {
>> +	CXL_DEVTYPE_DEVMEM,
>> +	CXL_DEVTYPE_CLASSMEM,
>> +};
>> +
>> +struct device;
>> +
>> +/*
>> + * Using struct_group() allows for per register-block-type helper routines,
>> + * without requiring block-type agnostic code to include the prefix.
>> + */
>> +struct cxl_regs {
>> +	/*
>> +	 * Common set of CXL Component register block base pointers
>> +	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>> +	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
>> +	 */
>> +	struct_group_tagged(cxl_component_regs, component,
>> +		void __iomem *hdm_decoder;
>> +		void __iomem *ras;
>> +	);
>> +	/*
>> +	 * Common set of CXL Device register block base pointers
>> +	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
>> +	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
>> +	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
>> +	 */
>> +	struct_group_tagged(cxl_device_regs, device_regs,
>> +		void __iomem *status, *mbox, *memdev;
>> +	);
>> +
>> +	struct_group_tagged(cxl_pmu_regs, pmu_regs,
>> +		void __iomem *pmu;
>> +	);
>> +
>> +	/*
>> +	 * RCH downstream port specific RAS register
>> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
>> +	 */
>> +	struct_group_tagged(cxl_rch_regs, rch_regs,
>> +		void __iomem *dport_aer;
>> +	);
>> +
>> +	/*
>> +	 * RCD upstream port specific PCIe cap register
>> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
>> +	 */
>> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
>> +		void __iomem *rcd_pcie_cap;
>> +	);
>> +};
>> +
>> +struct cxl_reg_map {
>> +	bool valid;
>> +	int id;
>> +	unsigned long offset;
>> +	unsigned long size;
>> +};
>> +
>> +struct cxl_component_reg_map {
>> +	struct cxl_reg_map hdm_decoder;
>> +	struct cxl_reg_map ras;
>> +};
>> +
>> +struct cxl_device_reg_map {
>> +	struct cxl_reg_map status;
>> +	struct cxl_reg_map mbox;
>> +	struct cxl_reg_map memdev;
>> +};
>> +
>> +struct cxl_pmu_reg_map {
>> +	struct cxl_reg_map pmu;
>> +};
>> +
>> +/**
>> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
>> + * @host: device for devm operations and logging
>> + * @base: virtual base of the register-block-BAR + @block_offset
>> + * @resource: physical resource base of the register block
>> + * @max_size: maximum mapping size to perform register search
>> + * @reg_type: see enum cxl_regloc_type
>> + * @component_map: cxl_reg_map for component registers
>> + * @device_map: cxl_reg_maps for device registers
>> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
>> + */
>> +struct cxl_register_map {
>> +	struct device *host;
>> +	void __iomem *base;
>> +	resource_size_t resource;
>> +	resource_size_t max_size;
>> +	u8 reg_type;
>> +	union {
>> +		struct cxl_component_reg_map component_map;
>> +		struct cxl_device_reg_map device_map;
>> +		struct cxl_pmu_reg_map pmu_map;
>> +	};
>> +};
>> +
>> +/**
>> + * struct cxl_dpa_perf - DPA performance property entry
>> + * @dpa_range: range for DPA address
>> + * @coord: QoS performance data (i.e. latency, bandwidth)
>> + * @cdat_coord: raw QoS performance data from CDAT
>> + * @qos_class: QoS Class cookies
>> + */
>> +struct cxl_dpa_perf {
>> +	struct range dpa_range;
>> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>> +	int qos_class;
>> +};
>> +
>> +enum cxl_partition_mode {
>> +	CXL_PARTMODE_RAM,
>> +	CXL_PARTMODE_PMEM,
>> +};
>> +
>> +/**
>> + * struct cxl_dpa_partition - DPA partition descriptor
>> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
>> + * @perf: performance attributes of the partition from CDAT
>> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
>> + */
>> +struct cxl_dpa_partition {
>> +	struct resource res;
>> +	struct cxl_dpa_perf perf;
>> +	enum cxl_partition_mode mode;
>> +};
>> +
>> +#define CXL_NR_PARTITIONS_MAX 2
>> +
>> +/**
>> + * struct cxl_dev_state - The driver device state
>> + *
>> + * cxl_dev_state represents the CXL driver/device state.  It provides an
>> + * interface to mailbox commands as well as some cached data about the device.
>> + * Currently only memory devices are represented.
>> + *
>> + * @dev: The device associated with this CXL state
>> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
>> + * @reg_map: component and ras register mapping parameters
>> + * @regs: Parsed register blocks
>> + * @cxl_dvsec: Offset to the PCIe device DVSEC
>> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>> + * @media_ready: Indicate whether the device media is usable
>> + * @dpa_res: Overall DPA resource tree for the device
>> + * @part: DPA partition array
>> + * @nr_partitions: Number of DPA partitions
>> + * @serial: PCIe Device Serial Number
>> + * @type: Generic Memory Class device or Vendor Specific Memory device
>> + * @cxl_mbox: CXL mailbox context
>> + * @cxlfs: CXL features context
>> + */
>> +struct cxl_dev_state {
>> +	/* public for Type2 drivers */
>> +	struct device *dev;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	/* private for Type2 drivers */
>> +	struct cxl_register_map reg_map;
>> +	struct cxl_regs regs;
>> +	int cxl_dvsec;
>> +	bool rcd;
>> +	bool media_ready;
>> +	struct resource dpa_res;
>> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
>> +	unsigned int nr_partitions;
>> +	u64 serial;
>> +	enum cxl_devtype type;
>> +	struct cxl_mailbox cxl_mbox;
>> +#ifdef CONFIG_CXL_FEATURES
>> +	struct cxl_features_state *cxlfs;
>> +#endif
>> +};
>> +
>> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>> +						 enum cxl_devtype type,
>> +						 u64 serial, u16 dvsec,
>> +						 size_t size, bool has_mbox);
>> +
>> +/**
>> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
>> + * driver specific struct.
>> + *
>> + * @parent: device behind the request
>> + * @type: CXL device type
>> + * @serial: device identification
>> + * @dvsec: dvsec capability offset
>> + * @drv_struct: driver struct embedding a cxl_dev_state struct
>> + * @member: drv_struct member as cxl_dev_state
>> + * @mbox: true if mailbox supported
>> + *
>> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
>> + * struct initialized.
>> + *
>> + * Introduced for Type2 driver support.
>> + */
>> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
>> +	({										\
>> +		static_assert(__same_type(struct cxl_dev_state,				\
>> +			      ((drv_struct *)NULL)->member));				\
>> +		static_assert(offsetof(drv_struct, member) == 0);			\
>> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>> +						      sizeof(drv_struct), mbox);	\
>> +	})
>> +#endif /* __CXL_CXL_H__ */
>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
>> index cb87e8c0e63c..79f42f4474d4 100644
>> --- a/tools/testing/cxl/test/mem.c
>> +++ b/tools/testing/cxl/test/mem.c
>> @@ -1716,7 +1716,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>>   	if (rc)
>>   		return rc;
>>   
>> -	mds = cxl_memdev_state_create(dev);
>> +	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
>>   	if (IS_ERR(mds))
>>   		return PTR_ERR(mds);
>>   
>> @@ -1732,7 +1732,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>>   	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>>   	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>>   
>> -	cxlds->serial = pdev->id + 1;
>>   	if (is_rcd(pdev))
>>   		cxlds->rcd = true;
>>   

