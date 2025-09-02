Return-Path: <netdev+bounces-219051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED4B3F926
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD91188A85D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08E2E36F4;
	Tue,  2 Sep 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XD0wKaYN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C2E573
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803130; cv=fail; b=LUl4ligpqlumhQ0ri8v+FWZkVwJ1bSc5A7u0K0LWNdOasAwN0t7NG+vmxOODME/DbinAPOMjOkeRDP39Q6DfDN7JY98T/rEXJa/wAFdEWmA176GFJ3pRE7DqvArnKPmwbzZfQFmBa5XZpXkZd05uI8w6r+GcQXGcMfqboYTZSUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803130; c=relaxed/simple;
	bh=5OoyGxlSCZaT2/mfj3eEXcvKyVcEmC5CsD+Hec7SG+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uuxuRiOULdrIN6ovENCcHmQW22pqAgZNBXGCQHV0iVJfJUDP/zhPUT2hrNQBVGcgplRqR8rguDM10oLx3TC32sN3U2KkLvsqaCdQU/WkFmT06QT8v9AfPjrxcjSbk8YvcARsAwVIvBX2Kah7RB9GJJ5YW1U21aJUoYcH85iEckk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XD0wKaYN; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdXlhrojZmglSXzTIcObBQ62uTMoGI/ZBhKKpErtYmUo/iC70Mi3OTXnZeP1lMAzz79R+kjoHhRvZpngqoTDSGIbkRfoUGx8Ww9rmQBC73YH5BLM4sVQ+J8Frm4w8nazkcDtZWYfKCTKpNb1Y/lNZZCqJATQ1LYQRuU/U3rzoZ7yxYOQ+2nQVnbdyfsdUqJwNNykPyqku0bddXWMQj2JDMwGIae6en2N6gpqh99O56V7M5Ymp6KdmeDUUHslTkBqiYGFZKlNq4m+5qExVv3lty0SVMqolntkvW016UckNUdjCTXJ+z3/JniQdRykRPPXQRepkbZvuyknrGzSRlSFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggOxEkp0FNv2Ue7XnCDBP3v1aUnOLhXaZX1RYMxqoNA=;
 b=Ouemb9IoQIU7DsTpFlL2B0zrx5hVPyUqU/Io9RRsQNf2AlGlF0buzxv5XDisClIH13IjOSEExLVDoLFWqBKKqrxMOzHYEvLTuwh7i6zS0ElzsVKIPzz3JRvvmqy+FLe3Dls69eMwMeDeVimg5GIYoNVHnJqwyQRz6A3qY5fgA0aMiIITkkCLFbGftajZUedXA24g3zbegzQgfiJm+nuIvxH/p/CAVcSjjOHsZevvhUfINh9ASNTBScBikQel7hs5G3UBNHp6ZesfvwYLuoG5Ea/XbmsTXijbAN0wp9F0oWD1KZsplwQy+sOWZMTBpfHSDLW5g/PZ6EncHoy95xNoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggOxEkp0FNv2Ue7XnCDBP3v1aUnOLhXaZX1RYMxqoNA=;
 b=XD0wKaYN/T2DwWuAvITgIiteliIFCYAOq1EiiQGVSyFybbIT95BPwJwBRMnvFKJRqdbrb1fJd69dsd6A9alEyuOjVPBt42iYVI0roWu2VlkoiX/q0/yEFg6HiUQJt6pG+xT/V5TU7nXvpSftV5jeY/bdnicUsizxdIJc1baNK+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Tue, 2 Sep
 2025 08:52:05 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:52:05 +0000
Message-ID: <1968814b-3f1e-436b-8ecd-e885be324ba6@amd.com>
Date: Tue, 2 Sep 2025 14:21:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: macb: Validate the value of base_time
 properly
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, shuah@kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
References: <20250901162923.627765-1-chandramohan.explore@gmail.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20250901162923.627765-1-chandramohan.explore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::11) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ddbe6c-b024-4b79-c47a-08dde9fdfded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDlHKzhjV3BtL2Q1bUlKdHpsd3d6UHV6dys5RkJlYUp6cUNDUXRqMjF6VGJG?=
 =?utf-8?B?TTl6UWtUU1I4MDZ0OUp4dTVuZXg2TXVEKzV6LzlYZ1BrS2kzWndIZktnNDJ6?=
 =?utf-8?B?Q2Jmcm1DWjJ5c2lCUUc4OG1vaXlXMlNYR3NMazgyT3VRTUhnYngvdEFFM09a?=
 =?utf-8?B?cDdNQmFhNUxaTG1RVUFPeUlmZGVBNjA1a2o5K0dlbFV3WlJYOVhpZnNKaWRU?=
 =?utf-8?B?N3JOemdNUGN4ZDFYY0p5VVhCV2RhYmNSSmhzNGJpNEtmZ1VLZ0V2S212ZEtP?=
 =?utf-8?B?NnlGU3h4VE1qOGVLQ2xiSU5yaEEwNEcwMklJS2daRXdTczZnNTFPSkpRTHRR?=
 =?utf-8?B?eWlneGhycmJGdlZvcHJoS0d0SWJTWWtuQ0VrNmFtUmZGN3FGSkRqbnZQS1BN?=
 =?utf-8?B?ZklTd1U4d21aekhXSmtFU09scWo3ZFE4Z1VEeCtvRzR5L1JDa2VOdkpJTktY?=
 =?utf-8?B?bzlrTUJ2WnBlM3lNTDFTaG92eXFkdUpPMU11blI0TFZVbm1RWGNRK1k1emlW?=
 =?utf-8?B?eXd6c3h4VWxINktpVDRKTEIxdjhoN2xWRytpYklqS0l0QXFyYmhPT1RaY2ds?=
 =?utf-8?B?bk5OOWhjZHdqUWkvbkRXTkpjWTZBd2FOSmF4dWpsQSswSE9oYmRsWVRVZC8v?=
 =?utf-8?B?NG9vUjZTcjFxWHZQYzc3UUFTajJJSU93Vmt0R1owZkN0dDRLeS9wSzMwd2o0?=
 =?utf-8?B?aUF2Wk1pODZDem00cTlnek5iKy9sQm9iRVprdmlTTGhSbkk5YzZqK3VqaEVW?=
 =?utf-8?B?RmEwWmwwbnByaDJGclBUcEpZMWZ2SWd3UXEwZFVkWUxLZGhnWjlvRU9sQTkw?=
 =?utf-8?B?WFNBMXlWT2piZTIwRUJ4cHZqa0s2bThzY0UwTElwK3NMcEtUK1Ftd3Q2ckxw?=
 =?utf-8?B?T1JIU0lIRUo4cGhNT3oxd3E4Z0tCVmRudVQ2Qjk0U3dlaXJXVEVHR2c4aHZ3?=
 =?utf-8?B?bzYreVREalpaT2hUK1ZVZ2lveDZqOEJ6RzBKMXEveDg3YmtkTlAxTDh3dHpW?=
 =?utf-8?B?WlhySVFrK2dGOEpiN29JVklDNEN0NE5EWm5BTjlsVEZ6RnhaOUxkVFpoVzVy?=
 =?utf-8?B?MWplVkJRU3UzcTNqSzVDL3RvcC9CVXBkQ1NDUjJsbk5EVUs3aDBkaHhTSmVM?=
 =?utf-8?B?WFFMNmkzRFFnU25mWTNMMXE5VGxQZ3E4UXZ3VGprUWNXMWFmWjgxbHVlZlR0?=
 =?utf-8?B?SFc0Sm1SMlFiNzRPTUtsZmZMeUNocWZJaWFqVjBHOWhYdk9rUmZlWnJvaEJL?=
 =?utf-8?B?RmViZFJGUS9meEE0NUovenRlcDhyRHlOWFRadFVWUGY5MFFxOXNsWitSN3Ex?=
 =?utf-8?B?SXNIc2hHdWdBQnZDTUNsNjM3U1hadmxjUTZXRkxXM1lTYVZVWmJ3U3VkSVA4?=
 =?utf-8?B?TGxnVkppU2NTbmJJVVFqTWY4UUYxNDlzL29OQnY1NzVwMzlhREVNSWtCVkFr?=
 =?utf-8?B?SllQN2Zna0ZXQklUVEQvMUh6OTUvZEdpTzV6aWN6QkxRdTR5dEVoaEwzNFZD?=
 =?utf-8?B?VERId21jdlNDT2ZmZ0tKZUJkY0RnUUJjbDNsMnZtcG55K0F0dm55TmI0a0RK?=
 =?utf-8?B?eGVTckhkMERtSy9DZCtNRW1ZWW9RMTFmbml0T1BiNmpHV0d1SnVnNU9SVUVm?=
 =?utf-8?B?dkJid3NUenN4MjFJUDZEN2dPM3N3UVdMZ3ZCZXlGNkhEdUZseHZacW1WcTNQ?=
 =?utf-8?B?SEo4dkZ2b3dtMXpNQk56MVh5aEhLSUIyM3dxTXBtR1lOLzNxZVRiZ2tEYWtn?=
 =?utf-8?B?NXhGOVlSNjdLZnR1RkhCR2c3dklrV2c0a3RwbUJZRXMyWjJ4djJJNTVEOXRZ?=
 =?utf-8?B?NEZzUm92WG0zWDhmTkw1SmR2L2V0RGhrampmT096c1F5QWVRaHNRU0FuSFRO?=
 =?utf-8?B?bVJCaHJZUDhST3NZaS9VbElYZW9FWS9CbjBKZnF1T1k2TnZzOFlQcGRFVU84?=
 =?utf-8?B?TUdreGEvNXMxaHBndCtZSTdwSGlWaFoybUJkYi9wZ0YrOTAvUWJnTU5zL3o0?=
 =?utf-8?B?bWtDa2hldkxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUdBbEg4NWp6ZG1kMnQ3Ly9XaHpibHhoYVVRL0ppMEtLMG9GMlQwSmxsNmk3?=
 =?utf-8?B?SXhSd0JIMERoODJBazZIMms4Y05Yd1lBYW9wNTVyWVlJZG15cTNEWE9pQ3Jq?=
 =?utf-8?B?Zkl3UFNvMjZXK3A3QXJ2WnBnNG1VL2xpa0ZyN1I5V3NmVzZyb2JrVm0zVjRW?=
 =?utf-8?B?Yko0aUxyUE0ySTdTNlczN2JJU1lRQmVyM1dyVzVrMzhoc3JBUENheVRPa3ZI?=
 =?utf-8?B?WW1sZjhrQ2JESHJkQTZaUnJvM1J5YXpRUktuSytDczArNlBRQldPaDczZGxv?=
 =?utf-8?B?NTd3Qy9adDFRbGZhakNzR3hFM2JNYXVpMkE4cksxOVd2Nks3WElpc2NldnJV?=
 =?utf-8?B?ZkZ5VmIyekxWd0ZBQzFHR3ZsODhCL1lPQkFXcmRwUTZCZk5aVU9MdEk4V2xQ?=
 =?utf-8?B?cWEyZGd5bW9SY0VnbXBrZ25qQ2dRcVlDNUk3cEMxd0ExQzk0dlVLNk14alRE?=
 =?utf-8?B?T2c2bnZYVStFT0plMkNMdk9tK3BsbGU4a01mL0FsemVRdkVOQ1ZlcktETGZS?=
 =?utf-8?B?bGVWTDNTdkNUbEx1ZXorT2Vpdjg3VklRK3J5em10Mll2aUFpbWUxNUluOU96?=
 =?utf-8?B?UWt6Vy82cEdpcHRmZUN4L0hKQTdDeHVoeXRRTGphWlNsSklWTFk5N3JmaGZr?=
 =?utf-8?B?NFFkV0pZMkkwTCtJR0lDZERQem1GRFl6YngvZmY0dEJxZysyV0tGOEM5anR1?=
 =?utf-8?B?REdJRXNFMlhhV1ZxVVFIeEpTU1dUbW81S1NJUXZDY2FWQmcyb0dvVXo3ZGJV?=
 =?utf-8?B?d2JreDVzSEV1RmcwOVo0U2lsMjZ5M1p4YXVTNkE4QnpUQlNVY0hFNERvZFdT?=
 =?utf-8?B?dnpFSXd5NWxQdDlQUFdWd0ZObWxkMkR3YVFsV1czZFFST0RMRCtVNXdmY094?=
 =?utf-8?B?aXRSdTJKT1c3OFg3V1Q4c1pRc1U1L2FXSWozc0o0eXBYb01zd0ZDQmM2TWx3?=
 =?utf-8?B?NlJZUGFUd2huQTdzK24waTBSd0x2STZWc3FOMEw0S20zcXYydW90TXhOaWda?=
 =?utf-8?B?bURPUERyWHUzMGwyUGlnR0k2QmVPTDMyWTJPSEJWc25pN0Jvd1NvV2VaNXRl?=
 =?utf-8?B?ZWU1Vk9xVmZGMTFHbFFFeTFzVGdHVlRyRzNQRzdsUTh0Z3RKU3RBSGRqOERN?=
 =?utf-8?B?Qk1rUG9WTVdZdVBmdXU2RW01WGZVQXlZRHBvSnhiQ0R6VExTTk1WUENrY1Fq?=
 =?utf-8?B?ODQzOGsrT0tybDRadVIvdlpvYW9xRnJ5TW9RKy9jaVBTRE9TTWU1R3lKSVps?=
 =?utf-8?B?aG9KRmNRVzNHU1htUzRsN2lTaG16OWZyZ2JNcTdkK1BMaWRMMXgrT1VHVnlv?=
 =?utf-8?B?YW5vV3E1aW5LUG9OT1RZbTFYUUhBbEpwaFI3bG0xVFpGUEx5REVKVWJNc0wy?=
 =?utf-8?B?Q3BOUEhZTU1xTVNJQTI5STR4b3hDcXdZY2t5VEF6cy9tY0VyelU0dUUyOW90?=
 =?utf-8?B?SUFQc2oxN0R0KzN4YldSRXlzam1HYkw0NVR3ZHBnU2p1SVZLcXhHcGhZbFRO?=
 =?utf-8?B?S2hSc01Cc0VQUVF6cU9wd2UzUURzUGJRemU0WmlRSzh5TG9wYjFzc3BvK2wr?=
 =?utf-8?B?a013UEdrcXpvT3lIQXNjVzl5TTBhbExXMUsrQ1ZCSngyZDZnUi94ODZtZG5t?=
 =?utf-8?B?Wnd3algrU2NyVmtvZ3VKZTZvR05WbnhZK2l1dlJBQlRwaXp1dzd2NmI4a0kr?=
 =?utf-8?B?UzZlV0NsSE9tdUlZcWY2QVh6Wm9aT3VYYXdtNXp4c0RiK1V3dnozbkZ2ckp1?=
 =?utf-8?B?eHRSLzgvdEs2KytZMGEvUEgxZ2JqRDBGVjA5MXR2SmczcmkvUlAyMnhadmps?=
 =?utf-8?B?WlM2NlByN2RIbzFQRmVkTHorSTZ5cG12OU1pMkxEc2hneDZnUTZ4Tk5kenRC?=
 =?utf-8?B?eFBnMEtVVTR5Z3Zoam8wb2dTOTJEVnZMcHFXYjRRa1RoQllrblIzZ1R3WExR?=
 =?utf-8?B?NWsvbFBHa2tlbWxQWXl1a09aL1d2eHRFMDFDQzQ0YUhTUUp5ak1sT2lieVND?=
 =?utf-8?B?MUVhcHFEdFZOY0xGdGM4QWNxNGVsSFQ1bVRyNTRaZ3A5Rmw2TGNha0ZUM0lK?=
 =?utf-8?B?M3VWNjNGRkt5c2V0RzNmb2lEMm5MNW9TYzEyOTRzVUh6cTVZK0VWZDVVVWNN?=
 =?utf-8?Q?5RwwSKj1DClDtJPHiJuWBjGGg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ddbe6c-b024-4b79-c47a-08dde9fdfded
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:52:05.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqQFgsx3abcOlyIgwcivP1g3zMI+PSUa0/YRs8oOY977FvvBGIBJCptsUbCxe3vP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257



On 9/1/2025 9:59 PM, Chandra Mohan Sundar wrote:
> In macb_taprio_setup_replace(), the value of start_time is being
> compared against zero which would never be true since start_time
> is an unsigned value. Due to this there is a chance that an
> incorrect config base time value can be used for computation.
> 
> Fix by checking the value of conf->base_time directly.
> This issue was reported by static coverity analyzer.
> 
> Fixes: 89934dbf169e3 ("net: macb: Add TAPRIO traffic scheduling support")
> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>

Reviewed-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 290d67da704d..e9b262a0223f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4104,7 +4104,7 @@ static int macb_taprio_setup_replace(struct net_device *ndev,
>   		return -EINVAL;
>   	}
>   
> -	if (start_time < 0) {
> +	if (conf->base_time < 0) {
>   		netdev_err(ndev, "Invalid base_time: must be 0 or positive, got %lld\n",
>   			   conf->base_time);
>   		return -ERANGE;

-- 
🙏 Vineeth


