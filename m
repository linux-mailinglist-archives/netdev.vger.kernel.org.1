Return-Path: <netdev+bounces-202770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC23AEEF06
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483317AEC58
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083E25B1E0;
	Tue,  1 Jul 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IJhBRQ5b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC125B1F4
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352153; cv=fail; b=YvZsk1mjk6SWoRR3fiEEpCv/EGwSYuuEajMvdBfyl0pAWZUNptephRwkCTC8V0VouEFCL/0RrPF943pLRTnL+HsL5MgmSBOP2pXfDcdrYw9sNb3ACqrr7j52KoqCFWA8eYbV+GWXkV/kac8eRaApv/qBOs3Cr15YACnNYRIn/n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352153; c=relaxed/simple;
	bh=9hBqMRZ7hoO4EKnlsOSAxEZa/loPQKFkqGFv4St9df8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ClA664QoHANpLRVONy1r69w1sUUxFLKwVerRlwPh07PEzm+avz+dHxcpp50f9/jlc8zkWH1mZMkhv+P7VqWz55B16wNNhIFqdrfb6+I5+zlsJx6wQXfFqQKLoHA7Ue/Xn/kHrB5iSZGX47LzgxUJ9qC+bOOw8bi69xeihaE8qGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IJhBRQ5b; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7dmVqG/XDmlxYZvk2AMMZpAWUYTn/Soe5Vmb+0G4m90eD9T8EMvgJxKESrxcrxYf4spky8/bPbhcnyzjlF+l+x4wqJD+Zm8PIFgz28JsVE3Gw/pNRx1QrG2YikXK1czlr6uzQEQPVhlrvHIMcMu0UQQAH7nA7l/Zq4ZwprdHOMEuCBS0pTDQhfb7xNaF14Zf4XuOIND4k5tur7asw2pjCSsl6spZrc3dIvtz2MWtvRxUuZdO1PL5pBcNOkxWSfytFdgRPBw1tKbXhW2PE5gncAoDNROISVVMpoSLF2/+EHTikFJJ/+X9v6udvIc32r0Kk9T/GNpUariWEM0iTk8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z+mZlQ8VPafzuFJiZijv6kDFrSEjccJeSJvYcUeZPU=;
 b=qO4ZtgkFuZdd/OfCTn2CNe2e2Xp+mEZKoTeY/s35d7sabFwQTBL3SBe0mJaoXoUneAgIxRGSBjfMRscNygNtuoUK6XZtd9ACkWiY4vevmkwHZsyoLGrryjCKWeYifFROr0G/eEfBT2tuBpcKbQ+bmdv1fZYmUo+VyhUvnekm+oesc1Cyp57I4l/BmdsLpP63toPrVImdHyR+uSaaOUIZfYOfRlGFnZYRgeZjg1thn5NCxdQKBP7I+IllKbrVdGSTfJNzQ47SQ/UeIj/izwzyysCdi27CwfRu+PLYFyLentK0wSwqiYkR69O4RAI02dKrlcDWBNQ2qhMrrUY5wY4Pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z+mZlQ8VPafzuFJiZijv6kDFrSEjccJeSJvYcUeZPU=;
 b=IJhBRQ5bd5Wy9XNQ8aU/2IfyIjyk/iBz+kv2AgmvGd1q/3EHuDVUZ0sdopTvSK0mlv4rrelsziroQiVNwlSllOUXAIbCYTDXmeOUDr6FhKQ4Hu9QwYlVK4J3n7WwObZLTMj+ZELdNSKv3cVhS3jQXQo3OV4bPNtAC0CER40PK74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 1 Jul
 2025 06:42:29 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 06:42:29 +0000
Message-ID: <ef471e23-e0e2-4e7b-91a7-c56569e526dd@amd.com>
Date: Tue, 1 Jul 2025 12:12:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] amd-xgbe: do not double read link status
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250625095315.232566-1-Raju.Rangoju@amd.com>
 <20250630181225.38a67e11@kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250630181225.38a67e11@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8195e14a-a842-4cd2-de54-08ddb86a72a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M01qN01ZakpkTm5aMEFKb1RMUG9qdndxVUlXS0M2WUNLSUNIVWNKNG1mWnd2?=
 =?utf-8?B?cTMzSDExT1IrS2ltVGdxOFYvNVlVL05FckxGMXI0TEJsdFNiWGR6OEcrazUx?=
 =?utf-8?B?R3lrTmxjcmNmL29jZk5IM3dUbklFVmY4dnZUZVlMa2dtaEdpT3B5eUVsWlg1?=
 =?utf-8?B?endNWExpYUtNdEJRVDhOeHE0dUZZMGlFamxUTHlZNk1GSVNyV05ndW1pT0tQ?=
 =?utf-8?B?dkxpTDR3N2JNdVdTbU50M05BM2cvZzN6cS80TDBuZFNkK3FkenFmdFFhM3o4?=
 =?utf-8?B?UzVwMTFnZFFBYVUwMjlPb0FNUGp5NTRldGdCTnlqc0h2LzhHSDExRlRlMUlq?=
 =?utf-8?B?ZmMyYmNPcG1OekxWWHF3RHdZcHV6Umd5MWU0QjFlazZ4SURRdXB5QmFYemF0?=
 =?utf-8?B?TzNpd2dGQmxSU1ZlSmtvOGxZRGdIQnRaME5vNzVsbFZONWRIWitiOFRMTFJk?=
 =?utf-8?B?MFRRUTRzWjlEZU9BMXFyVjczMUFnM3h6VE5sV0RidjFQWlg4RVgyd1MrRUxY?=
 =?utf-8?B?ZmcvRDE0RUFMd1VZQWdqUWNLU1FVK3NLczhRT1RlcjFpSkhGUE4vZUcxRXk5?=
 =?utf-8?B?czN4TERjSUExMW44cHFzczFsZGtNUzFKZWJMQ2RlWGJMSHJ2cGFLOHk3b0Vy?=
 =?utf-8?B?aXlDMEFxUzh3RUhQUERzbTRQWkFBMTFoU05tNzFaV1lWWGpkcjdkSnNFWWg1?=
 =?utf-8?B?OTRITk9PWlVOUjBwMHpBRG03L1JsYXJTUzQxaEN0a0NXN0FFQ01IYTA1Nk5B?=
 =?utf-8?B?aW95ZFJJR01MYzZPQTk5STEycmQ2RlNyMmEvNitPZ1lUSVA1cVNQMTdHWHlv?=
 =?utf-8?B?dE5Tc2hmeTc4eGFjbjFnd2JpcmZHY1pUNG90cnR0bk5oT0lOSldVaDI5cW9z?=
 =?utf-8?B?d1dnNnRIekdiZDNkUGVORXUrZVFmQUhTS1Nabk9DcVM5NjcvQ0ZNb0NOZW5P?=
 =?utf-8?B?by81TFlFa1V1cmNuY2NBdlV4UXd4ZHR0QjdMY2Nxemh2Mlh0ZktNNDdadU4w?=
 =?utf-8?B?Z0NmdWRiYTJ6UlJveFdsWjQ4a2JXcWlCVVdmeDdPNVdRbG92QWprUGJKQW55?=
 =?utf-8?B?OS9VZGlmMVpjRFlSOUxSeHZSNnZUaTd5MW5NTm1xQXhLNzhid3M4RTJ6OTRO?=
 =?utf-8?B?T1RyMXc1Q1ZmWTFUV0FuVFdlUk0vSWlkdENONlBKZ1dpMUdXdHFJNHh6MTJC?=
 =?utf-8?B?THIrZFFEOUVSSU94eFd5VC9TZGNYckFFZFkxNUl6NmxNNUJYQ2h3aXpiTHNx?=
 =?utf-8?B?UHNKc2hzSGlzd2t0eTQzZHUrQkpRa2dyVW1SU1B4VTlrRXFHZGNINGl1S2p2?=
 =?utf-8?B?YjdieDN1MnZ1UmF4eUQ4cElXUDY5NytQY09UTUtVREpoUmpLc2RPWnY4eE9I?=
 =?utf-8?B?R0Jxb29XTWpnQXQ5eS9DamtWSm0zKzY5QXBMUksrNzhmTGhMeEpaU1pFWkpE?=
 =?utf-8?B?VWVKUXhrSEY0blJrUG1wZDhaRk9iMitGb1hKUytQWitJM3BmeElrWGp4TTBN?=
 =?utf-8?B?Nk1UTk9yc3pqOXFxSHBKR3E0anFlcXZkUk1abEVKUk8vclhqM0pDdmpYQ1Y2?=
 =?utf-8?B?aXhKTGVGZUpaSjJUSXBoUzE5RlhuQ0RBRGZ0SGVBQVBJMVZlL1c1VnNhSDVC?=
 =?utf-8?B?eXVQLzZhVWFJZjU0Zk9RdWhJOUZ4V3U2YnZCMHNSaWlhTzArcVpQNHJDdjZu?=
 =?utf-8?B?ZFlpQUtmeGVPWk5VSEsxUDVHUFcySUxIVUQxMi9WTWM0WHAvT3J6NVhaVjh4?=
 =?utf-8?B?WWJrL1huRUJUQVJXVGxwNEROME1tay9GOGxjVnhJSFU0TVg4eGhqRmhZMndZ?=
 =?utf-8?B?NjJSMzAzandmM2lpRm45QUNBZkI1WEdVNVRZbzBOVVBBRDRwengvck0zL0JV?=
 =?utf-8?B?ellQcTB2cTY4OS9hK2pqcFFjNGh5VXkyLy9yTDlsQzhFbWJQT1pvVkNHMDEw?=
 =?utf-8?Q?Y5dg4jCcPlU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExGRU0rTGQ5dDAwOXJRaGZPYVJrYVVoVHJLbENkRlNKVDJXaVhsSlY1cldB?=
 =?utf-8?B?enI3WldZOFcwVjNjdlhDcmZpeWx0MlFyTG0rOWhidTdkdU1NNmpFSnZsL3NR?=
 =?utf-8?B?eHhRd1orUEhIOE9scTJCa1R0a2RiQnF6Y0c3Uk8rMktKTUVTOWtwdTF2eHpj?=
 =?utf-8?B?NDl4ek5hZUkzNFJrM0IwQkgyUTgrOGRlOExIVmJESXMzRFJtTEZGQk5Xb21U?=
 =?utf-8?B?S3VGdU1qT084SW5qNDZaTHpRWUxFQ1NEUWxEcWFGZzNRL3kyN1JoU2djVDdC?=
 =?utf-8?B?c3BFVURhMWgwOGxwcWk1NFNQMXZSSlNWTFdDdGlRU09sTE1RaWpVbjlwcktw?=
 =?utf-8?B?dDVIRGdYamFDMEcrZFlsMnNaaE1EcVR0OVFvSnNDeng2c0ZwdUt4RHpVVEh2?=
 =?utf-8?B?djN6T1dmRnVSZmxzWE9zRitLcmV6WEpxZ0pGbEh5bUlRSEhvRFVPUUQ0Q2Vv?=
 =?utf-8?B?WnprQXYvcngvZndjTHRnNk01eEo4RzhtbTZEaDZhRm11Um9uMUE1dlR1LzJr?=
 =?utf-8?B?TFBhOVpLYVdNVExMYmpqVWdIY3h5SzVkaTJPMFYxd1JMY0VDRE9BVUo5cnhR?=
 =?utf-8?B?L3JWUlVZLzJSRmN2aWFSTjduUTNWQit0Z29MRjN2Tk9FTzdDSDJHUFo1T1U3?=
 =?utf-8?B?VzIwdkRjVm9Bb1FMcTVRR2hrVnB0d2w1VGNlM2tBeVFMZXZqVUFibW5yMVpr?=
 =?utf-8?B?QXFISGJxUFUvaTZUdjJsbTNNdEZTcVl1cndmRTJKUFozbll5d25abnFMaGpJ?=
 =?utf-8?B?cjZnT1F6MG1uR21ZTExZNWxTMEZaSXhINDBFMkxWTURKeXB6WiszRENyYnpr?=
 =?utf-8?B?MkJGYk1uRGEwTVZ6c3VjbHdaTUhKYmdoRUIzUGFNNGxCekFDME00TDUzYWE1?=
 =?utf-8?B?ekRYQzhjT1B3eENPdFljdkJSaG9lMXJMM0pZNEFvWGZua29HMFJrckJOVXJo?=
 =?utf-8?B?eVpGekxTbTQ3ZWZCWVhkTnJ5NStvRDRDZVd0OHdnQ3FCSFVtNkhUNjJ3YlhM?=
 =?utf-8?B?SE5YU2twaEFpQzhrbHZmelRIK0p3QysyRGZLOUd2OE1SREpuL1UrT1VlUm1s?=
 =?utf-8?B?Z2lNK3VTWWUwTUo5bmwxRFUrdTQ3N3UybGlVaDQ1UG1TN2xwUXJhNWZraGhi?=
 =?utf-8?B?aU1DMXVIRmlZSTcrWjA4S2gvK1dIN3B2aVpIM0FsTkJsTGEzRUI3SndzV2ND?=
 =?utf-8?B?VmM3NThSMUxTUlpTU1BNSTE5Sk5WLzNiZVJacDJ3RnBjWWFtaHoxWTZDbjBx?=
 =?utf-8?B?TDlqK0s1MGhnbGVYRk9naXZlT2dlN1NvaG44bjd5cVRlTi9vei9QMmtsdEIz?=
 =?utf-8?B?WWQ5bm5BYjVXbis4N2FsNGUrSHo2cDlDbWpxSG1uUnNXZnMxRTF5a3huL21W?=
 =?utf-8?B?cmZDaWFyQ1VjSjVGdlFnMXppQ3YyUGQ0dEtiK2k5ZHZBYUljdWJMYlRSWE1S?=
 =?utf-8?B?a1ByRGZ5TXQ3cStzK0VKb0lMWWNiYUZ5RkNaZUdGQnVEQks2QlRuRlNUNUFO?=
 =?utf-8?B?RDQ2ZDJ2bm9FQVdBMlFocjA1a0ZWZmtjYk1IZXFySG9WdUFLYld2ZTJYL2NS?=
 =?utf-8?B?OE5vR3V0RFgwUm1SUEFSVi8vS0FnMFR0anFrUUxtWnhtVWY0cElkVlQ1dmQ3?=
 =?utf-8?B?MHM4Wm1XeFJIZ21OQTV2VWp3anlWK1RGRjVGZW5wdEZuQVJQZDU3clF5UDBY?=
 =?utf-8?B?NFpHM2FBSVM2c20wby9mSG9sVnc1T2Nrd2pNL2lxWVVkYVZpcHhEa2NVK2lC?=
 =?utf-8?B?QUNlYjBqbmdOQ2FzL0FYQlZLZlJKbDJTQ1JYVzk2UUdBTlA4MU0zTVk2NEpk?=
 =?utf-8?B?S2kxNjUrWVhPVFd3ZUdDTWtJWXdPRFcyYUVjNWxjeTV1TVVkMXQwRkpKdEhj?=
 =?utf-8?B?aFVsZ29YSEg2SUxNS3NmVFRMVW5xWUo3N0xuS0QvVHFFYTFoRTMzdUJJUWZN?=
 =?utf-8?B?T3FRVDVvNmIwV1hTb0tMandvUXdtQlhDZ1FpTzBkTEg5eXZ1TzFhRVJZY0tQ?=
 =?utf-8?B?bVYvQzFNU1dtWnNZekl0RmRoVmEwK1ZiYk1veENSQ3BDRzJ1MWJhQjlEdWZF?=
 =?utf-8?B?Q21YcmF5Y0F6VkliU1h1Rm9sREhldHdma1ZLZ0Y1RkFnWEZnekV2RkcwdjZx?=
 =?utf-8?Q?kCsuhnbTfKRL49xHMcSR18Fz9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8195e14a-a842-4cd2-de54-08ddb86a72a1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:42:28.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqEFucKN3+f1+NE7NQhhDup6KylJIaNu2s2IBSZaqI3I+pJ6NuBSXcnaufzqnsV/8A6ZbNq6js14jB6w237fAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258



On 7/1/2025 6:42 AM, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 15:23:15 +0530 Raju Rangoju wrote:
>> The link status is latched low so that momentary link drops
>> can be detected. Avoid double-reading the status to identify
>> short link interruptions, unless the link was already down.
> 
> Took me a minute to understand this. How about:
> 
> The link status is latched low so that momentary link drops
> can be detected. Always double-reading the status defeats this
> design feature. Only double read if link was already down.

Sounds good, I'll update commit message accordingly.

> 
>> -	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>> -	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>> +	if (!pdata->phy.link) {
>> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>> +		if (reg < 0)
>> +			return reg;
>> +
>> +		if (reg & MDIO_STAT1_LSTATUS)
>> +			goto skip_read;
>> +	}
>>   
>> +	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>> +	if (reg < 0)
>> +		return reg;
>> +skip_read:
>>   	if (pdata->en_rx_adap) {
>>   		/* if the link is available and adaptation is done,
>>   		 * declare link up
> 
> Don't use gotos for normal function control flow :/

Sure. I'll re-spin v3 with the suggested changes.

> 
> 	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> 	if (reg < 0)
> 		return reg;
> 	/* Link status is latched low so that momentary link drops
> 	 * can be detected. If link was already down read again
> 	 * to get the latest state.
>   	 */
> 	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
>   		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> 		if (reg < 0)
> 			return reg;
> 	}
> 
> 	if (pdata->en_rx_adap) {
>   		/* if the link is available and adaptation is done,


