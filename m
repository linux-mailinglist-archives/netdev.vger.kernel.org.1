Return-Path: <netdev+bounces-190623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7546CAB7DB5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36971BA3EAE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035E20E00A;
	Thu, 15 May 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gjTM4P1h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0114D2BB;
	Thu, 15 May 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290066; cv=fail; b=EhcJv1Z/xd94/TkXEjo7WLyzZm+SQm2WU1DlCmbUIzJxSYI52FmOg7FZLcfr26fEjpU/VesvW5NjmGbBzxKz4+3xBmWtMuAQn1PE1m59pu1IGUEJxvC460hF4udbIwWO0Hf9BOw4AtQ+JE6H2wrZ6GmDgjah4eCHgwMS9Karxk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290066; c=relaxed/simple;
	bh=LJ+VlFMd3nbCh2uYxkmQhCXg6MpZpZDKKv+S+f1Q2RU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kiyq4nWPoCPDHGeUo4uE6gwemPhQLoW1O/R7gJ5zuSmMtV8JfOSh1bQSW+qImM2X+nq4CUv5eukkCNkIz1vIOJM967z6CrU3T40tLROyuZZ7bDF4BJTSedr+LyEIQMg4LFy+IXlt2AR908F+o0GbiP7p8YeEWezOto5SRewqj94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gjTM4P1h; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3//HU61pEV6E41FbGigrDw+XziUdAE/gnpQe+4QbYBStHMyiEGnkViHRf9UIeSFCiGzyEzg0i8PxktJVBPItdr7+Nojl/MOsgi2OzXDpVAy0m7ONJGOPS1V6gUX46Jsus0PO90Mako3KkZeOTgo9oPV7spkSLNJSx8pOw9yHMOMhmhw6iewSHc/UI6cauRkvRgrTBYO8pTxkbhtFIhBGvE0lJ7HdfUZwsxg33tFN2YHUa3078tZwoHCApzFX2hZPashv8GpYkGUeATL8jomf7FmbKCo3cuP+2g9knNIBsWqH0tsq7qCPTN1ilWctMH4gTIA2ZUt668a3llVwu2YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xag84aVXXbKoA33RxkLobpb+PM4NDmqk++wcPRpEdTI=;
 b=F1QQVF1F+YUTIbNiy863W+74ygRCexjLiuXUzcJjeFkFxUgdC1uJtHSA+1BFt1w+djJyHcs5at2B6L+eS7n236jznBzOvoXWlIYXviuDHMbuhuzkr8Hyx9rm/mxFMbvYmByansTyYbKVgXdE/IyJwmZBKK5njkkxC55Ry7w5CWXxURYMvOn646U6za+zVlQfEOLrICi2yGKR/UPirMRgkPmpmYnXFh9YK8jQJcm7+4x6TEiE/WYfs6wTGFpqLEqB8xJdb2BQt1fxnNFoO2YqTDRL8AsOiRElXI03k045LQswd+LVVICbADhR05GYdFJJH8brWNMzEg3KP2KQ3k+sBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xag84aVXXbKoA33RxkLobpb+PM4NDmqk++wcPRpEdTI=;
 b=gjTM4P1heTYVezJ2n9KWG7N5frSPAMrVPI8aMs6MrqK4rpiRqb4nkqU7HPv2lVnRv6t7xVSEvrXwRBLXDVkwFjSnXA9MWLcA6W0aSmsfcERRgT0/1+uVqJdvky98UZL3NhtBzwqyq+LdH2fr94bfIfHP6vmi28dJ3GJ3/1PA+GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 06:21:01 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:21:00 +0000
Message-ID: <7d561e3a-ae5c-4077-9cc8-c6711a5298b1@amd.com>
Date: Thu, 15 May 2025 11:50:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 09/11] net: macb: Move most of mac_config to
 mac_prepare
To: sean.anderson@linux.dev, vineeth.karumanchi@amd.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk
Cc: upstream@airoha.com, horms@kernel.org, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, linux-kernel@vger.kernel.org,
 ansuelsmth@gmail.com, claudiu.beznea@microchip.com,
 nicolas.ferre@microchip.com
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161416.732239-1-sean.anderson@linux.dev>
 <6a8f1a28-29c0-4a8b-b3c2-d746a3b57950@amd.com>
 <964d667a-c17e-47ff-b7d8-fb5b5a2f1eef@linux.dev>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <964d667a-c17e-47ff-b7d8-fb5b5a2f1eef@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: b05d424e-da80-4fc3-7cbb-08dd9378a91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZiZUVteGpEbzZxcWVFZUZ6eTlSWHR6c2x5RmJRbU15MFdrVEU0TkxNZDl3?=
 =?utf-8?B?SG1vUVRITjUyeC9nQXQ1NndpbC84SlhrWFVZK2FCU3VKaTFRckVpem9URytM?=
 =?utf-8?B?SGdzZE5Sb0ZYQXpFNUgvUTlxZ0lsTE9KOHBtVmR2NVdZb2V1amlWUXpGWWdC?=
 =?utf-8?B?QnZVNWd1YndocENlWmNQWjFTM2E0YzMydmxUNkR6MXZMT0xZMGVFUkJaeGFq?=
 =?utf-8?B?WXNWRDg1Vlh6Q2p4STA1cWVhMzRWMjR2NHgxbkpnOWUrcXJ2RUNPbHBMcHZE?=
 =?utf-8?B?SjMwdHhLdjNsUE1YdWN6WGtYS2F5c0h0RkZuTWtKTDR1d2wrbDdMdmZiTlk5?=
 =?utf-8?B?cnQ3Q3BGZW1JYlZybjVWNEp2YUtnUUhFeVdKWlJhSTJDOGordkY4NERjZFpI?=
 =?utf-8?B?enR5SGhDdmJvK1hZbzVNRWlFYmFXSTh3YXNHd3Y1TS9teHVZcWdZODJsVlEx?=
 =?utf-8?B?TnBpV3ZOYXd4MnJnd3J1ZmY1NDBTRGZMS2lGKy9vbHRqYlltMnhaempSTDBS?=
 =?utf-8?B?clQzQ1JDSGF3eHFsZU4xd3RnZ0JwZEFKdmRrdjRBL2JOdGcvdTE5SjZZZTJ4?=
 =?utf-8?B?WE9vVXdtYUV2SU9GR0NuTjgzdWRhTi9zc29OTE1vSTd1TFdISHd2MDFoM3hy?=
 =?utf-8?B?aTZDTXRMQ2l5SzU2dU9uTERHdzB2dTNLNStSb3lIY2c2cllKVldkSllIRm5E?=
 =?utf-8?B?ekladEp4QzVtUVMwM0dNUUNob0tlYmFCdlRqZnhJVUlZQ2FvcUtYRWtHTThY?=
 =?utf-8?B?NVZPd3NIb2orb2FOUDZIRE4vY0tPNkdSdGhKeWdPM203U2VCRnNxZ2hYdGx5?=
 =?utf-8?B?RDFUY2tzR3E2RVZnQnR0cjJZMjUvUldWaW1uU2wwYy82NHliQmhEMUVYQ29S?=
 =?utf-8?B?NWJjNGhrZ3NZVGljdU9kTmREdWR2QmNkRkU4VjBlZGRianowUTNWVnEzRzRV?=
 =?utf-8?B?SmxiSTgvVUx0Y2U5VTFIajBPbXVzRjhQQmxjTzhXenRpa0VmT0Z0clhmQXFy?=
 =?utf-8?B?R0dWc0pOeHZNc0VFaTJyQXR0cFF4SHlBd2tua05QSnpxNmYrWkxTTWo1M3Zh?=
 =?utf-8?B?VHpCVGZ0MEVIZWt4ZG9HL3l2dDNOSjY2OE9wWU82NkxRaTR3cmU5UEtiS0to?=
 =?utf-8?B?NjFPN29ESzErLzRuNjBtSEpRSUhNaWtJUFRtQWZua2JHNUdMS1hJQUtSMGVJ?=
 =?utf-8?B?WVZteWJUaE5nYnlnVEo4WXM3K3Q3OW5ZbzNteEhPMGtkdTNsZEh6Mi9Uc2ZZ?=
 =?utf-8?B?SkN0eEs3WWhtN3dhcVhsaHVKTHQwdG13V3NCMTN1YzZWdVJ0bklodDU5VG1F?=
 =?utf-8?B?YUNINmxOaHRDU0kva3dBQy9vb0NwaXNjcGk3VXBOa3o2YnFlUnU1cW5nSDBF?=
 =?utf-8?B?VnpIQlAyZUV0ZDhiaE5ybitkWU5tVGxnRURNcEowcEFWb2JSdHNURk9YOVN2?=
 =?utf-8?B?QUJrODNZS3d4RGtGSWVReUdrWDhHVFUyYUROaVBVQi91YlhMZ2FxbTJaUldE?=
 =?utf-8?B?bkpuSjY5d3U1ME5BYndRaHduL3gxRXRGUGZESlpuRU9QOENub1dDbm1ick5C?=
 =?utf-8?B?SE0vU0tER3hYS1JobVZsRm5ESW4xMFppQ2FkRmFhTVhEd1N5NFVoODZ3eE9H?=
 =?utf-8?B?SEtOdHhLakxtWUdESndxZkttNmVMWU92OXJoWEJJanUvejVyM3JHY1gzaXJa?=
 =?utf-8?B?OWsyOHVZejVtMGg5L2FBTDk2TVpQb0xYSUFwWTZZUTBWT2d4aFBJRjZtTDRr?=
 =?utf-8?B?dmxWZVBuMkVPUEhhazErT1ZIWkF5YVJVL1BpTnM5aElZeER6dGhaK2MxbVpE?=
 =?utf-8?B?U2N4VysvZThOb1p1a2ttQmhqZFdHSVB5WlZBUmR4T1MwdUhKbHl0dDIyeTVq?=
 =?utf-8?Q?qyPLQAqe68FjH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmZvN0RyWDllTXVRZ3BoM2RWWWRJQlkrQ3NLcHlTY1FwV0xPV25rV0c3M3dE?=
 =?utf-8?B?T3pJdUFWWnoxd3ZmY1Bpazkzb0psd2hlMWR6TVQ5dVNOV3hTWXd4ZmFzNHcv?=
 =?utf-8?B?eHkrNzVnU2piSVovM0phbk5SWWdqNGxkYjV1LzVJczA0Z2NtaUI1UXM2RU5q?=
 =?utf-8?B?ZGxmV1ZZTVZsM2x5SHNuakVuelU3T3Z6bC9EVExZd2Fha0J2RDBmdDFsZm1I?=
 =?utf-8?B?dWdnb3NPTGIxWlV4c05nbFllTHQ2cnQvQSswQ05OdjR5RzlpemhleXRRNlo1?=
 =?utf-8?B?SFpGUERkNDNwZ0NSaW1yMG4xS0piOXI0bmUvOExXVmxMaVlwbGoyRGVGSklZ?=
 =?utf-8?B?bUQraFdXL0tWTXpuT2VYSS9tSWM0T05IYlVncnlhRG1UWXZiT3FjY1k2MU5P?=
 =?utf-8?B?UU51OTAvZUpoNUhIekxWeDZ1Q09HM1JIQlZ0ald0S3hrZ3g0eGYxYnN1Q3Yx?=
 =?utf-8?B?dzkyc2FHS2dqaUtXZXVYVGMwdDg2aVpCZy9JQTNERlVnR2kxRVNKWWNvUUdk?=
 =?utf-8?B?cjhIc01TdWhsamcwRkdtV1JWMFJPRUFJZ1VyZkg1czBxU1N6aXdCNmE4bWU0?=
 =?utf-8?B?bVFjM0NDYmwxc1pNakQ4VjF4eUJnY0JlQnZkSEZnLzZjaDZSZFZaMFRCSHdy?=
 =?utf-8?B?aStGT2RjQmZRSjJxT3ZuR3BsQkV5R0FUbzEzU2lHZEVlTFVWbGJYZzJEOVdG?=
 =?utf-8?B?OUZuakZueStZS3c2QURFQytUWFJpN0o4ZGJ0MFo1MmU3OCtxYk50VGZub0pG?=
 =?utf-8?B?TzRWbFZmUXllRnVxdlBJTVlzT3BiY2dESXVNeVhta25TelJzR0c4N1I3bWR2?=
 =?utf-8?B?bmorc3FnNmYzcnV0REZaZmpUa3JINWNiTmRydGRHeG91TW5BTFVCOTBmNEpn?=
 =?utf-8?B?OFJuTWxScTEyaW1tbjlmNEpCL01IdHlaRHFuZStNT2krTlZSalNFZ1Q4RTF1?=
 =?utf-8?B?WndWeXVIV1pUN1J0SlhKMmhnUXN3SEZxamRHQU50cktJaTBuOTdqMUFsNnVp?=
 =?utf-8?B?amMzVmJDMGhlYzN5YUpPQ0NFcFF0V2k0dUNDUHhBYlFGWjMwYklPV3VXWG0w?=
 =?utf-8?B?Z0RZZjgvbGg4bStyeTNTVGdsOWVjRmhFQlRJNlI3VXhBWXdNRjJvMHFSeU93?=
 =?utf-8?B?c3VQcVJyWTcwNWc0TVdnN2wyWWZiQmZUSFByWUt1QWpIY3lqR1VUK1VEWDFk?=
 =?utf-8?B?QU1kRnljMEVWTi9HOFlpWkFxTlJ5M0NYSDFBZmJKYmtpajZpVTRYOFNoYkYr?=
 =?utf-8?B?WXlvY3dpZmVFOEZZUlVuZGxrT3UzaUFKV2dVMXdoSGlzbW9oa0FXRlpoOVg1?=
 =?utf-8?B?TlI1Yk5EbExBZG16Z0dIdGtGd2c5Q2Z0OGxnSlB4Q2c4a3NJbW1LV2lCYitV?=
 =?utf-8?B?blVPR3FUelFReFp6YjdGcisxWkNuR1JJS1k4Z0pHdlRiVTZvZ2djTWdyM1dW?=
 =?utf-8?B?SW1yZ0pmb2tiWEtTSTFsd3FrandZeFBlcUJvMndjNjN2eWh0dVBSSDFjZmJS?=
 =?utf-8?B?QnFTWVZyRUx5K3Q3WURyUStZaHFaTmVJQ3B2VWVnUFdNSjdKbksvZzhOeXJT?=
 =?utf-8?B?SDVnbzd1ei9LZmpMdnhkUTU2WU85Z3hLRTA5R3hKQUpldnpQQ3NYSVFiS2FH?=
 =?utf-8?B?UG9ucjhGY0lkNGlxam5sL3BsLy9SWUU1dlhoZnY2a0JMR0xwUFo3bytHVDRt?=
 =?utf-8?B?Vzh0V3l0Y0c0MHFMTStTUjZtK1VuUDRWZ09QeDZQZCt5VUdtS01JTEhIN29O?=
 =?utf-8?B?aTVvT09ZSHR6S0Vyb2l3QWJNS0ZoUWZRR1dxdkg0TG1HTGFJQnhKa013ckN5?=
 =?utf-8?B?N0gwbnBGSUxVZXUvRkpQeUpxQkVtUTNhbzg0VzVKRHk4Y0N5bFB6T0RYVnZo?=
 =?utf-8?B?enExVjgxN01IazZ2NmxvYm1JVGxxRW1HQ0QyRERxNGNFbXg4MTV3aEw1emo0?=
 =?utf-8?B?Tzh3YmhleS9tQ3JIYlRmS0ZNTW9JUmtRcjJpbHd0WWdZYzYvZTY0dW03U2o0?=
 =?utf-8?B?Z2RlekFPQ2Z0cE5NQ0dDelVFVjVUQXRNYmZwamRDL3B6aHpsYml1UWorOWta?=
 =?utf-8?B?MW95YWUybVMzS2NTUitMY3c2NjRETjJmWUlTK3FqaGw4cDNBaDNGeHdlN3Fv?=
 =?utf-8?Q?RIjW3Ek+JyxWe/gMmQc4A8hWv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d424e-da80-4fc3-7cbb-08dd9378a91e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:21:00.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGCZjq6KJharioAN9hpPDN+6LvLmYEA5EIX+OU+5e8zf9pVWo2xJ26jCSHoo+Pms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919



On 5/13/2025 10:10 PM, Sean Anderson wrote:
> On 5/13/25 11:29, Karumanchi, Vineeth wrote:
>> Hi Sean,
>>
>> Sorry for the delayed response.
>>
>> We are working on MACB with two internal PCS's (10G-BASER, 1000-BASEX) supporting 1G, 2.5G, 5G, and 10G with AN disabled.
>>
>> I have sent an initial RFC : https://lore.kernel.org/netdev/20241009053946.3198805-1-vineeth.karumanchi@amd.com/
>>
>> Currently, we are working on integrating the MAC in fixed-link and phy-mode.
> 
> I had a look your series and based on the feedback you got I think this
> patch will help you ensure the PCS changes stay separate from the MAC
> stuff. I found it confusing on first read that you were configuring the
> "1G" PCS from the USX PCS callback. I think you are using 1G/2G speeds
> with the "1G" PCS and 5G/10G speeds with the USX PCS?
> 

yes, this patch does help.

The IP was designed to configure all speeds (1G, 2.5G, 5G and 10G) from 
USX registers only, hence we are using USX PCS callback.

> Do you know if there is any public documentation for 10G support
> (even on non-versal SoCs)? That will make it easier to review your
> patch.
> 
> --Sean

The Cadence IP document is internal, but we can share TRM of our board, 
which goes public later this month. I will add the link of it in our 
patch series.

-- 
🙏 vineeth


