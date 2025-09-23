Return-Path: <netdev+bounces-225576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCEB959EB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06286173B7D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390932798FE;
	Tue, 23 Sep 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UAkHcriz"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C442A80;
	Tue, 23 Sep 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626515; cv=fail; b=ZtSlbUbKjJsopZBmjI+9uAM96Yw0bUmNDl14T6mLVQtTFG4z0s+/fvtDxaSDO53jZZT3d+9vTiuBwGwYrNdFrWXXdE2t8YC+Dd8PT1vjXgaowCXveEC5Vcb3/1TAfG3zhiNVp0YTRqIUCAKycQnW9twIopXvO31B3XlrqXJ+0Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626515; c=relaxed/simple;
	bh=ifC9HYQk97DYUHr2nNgh+DA2VjLxwFu9hpt3zs96f4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xy5CeKaMpIVd1ow/AIHHqwHMTTYaoC5bbpDczUkzj4dp8Hl5DolfRTRO8iWpm4YOnOGjsR4tGlNaZM8oSrVQSrUkST6JMxDE2Gs/PNfmXCq+APRnStcsVlla3OY7iheU2liQMMmvRmhPpJa+7cje71wmtc5kQcPZmLpnP/V3vlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UAkHcriz; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4dixlHGUnyGONXamGEOuNWk9v/09dnpg3evQkjjlNUddDyEKOtGgDWG9ffadbeIskULyS/tsvdwobYLJTkWtz9pDpEDIe+dezVKzJMcvXJJm2FS9Ryen0V+uDqxPy9jFJXGV79FSxONKsQ/hqHSVWY9hHnDEZBaR7LPyfTc5flg0YDDtyrBt+rvfK9ZmCx9sr24DrKDarKtrnDN9/pl06Tb2JH7xfqO2CmkRWAGZn5W4jR0gH2E7L8KivEo3f1883K9+VVpRIglv/qWhQd2Gv07dR56uCQi7YLqt/ZpjZLHQTm6GTffA4XdSCjwDNhuxhH5ObHu91bWDiDI9So5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB+stNrMyPgWpsU+pHKUqi+efPvOl40iUGcT61+8r2c=;
 b=l7xn8JPLCeqfDm6ciLBNKC2zJKsao1eyi6u5dfIPGdLRa8H/cUQiqsvE5l06vbEKDE1hdv6TGYwuowyq+ProWbZpgMDxV8iLZ8pAwJW8vK4i8shUsm0QyTHGBklZFnUs7VLmp0POxxnv1VOUTir5CPkhBZlv7NkkjU4uVgdQ2jyAKDrepeznR8dHw/RYkdLfe84PHlxad3qvdJHkStzBdgmVPDcaaaxdK2Lgv8HS81hFVg5iYNoL+/fz07rpHqwIzjO8Ro1U/xw/IuRWKQeezmshT+1M2ySmbIr6ZLXzgTHmdvm15kCvcQONQaBLzyW6dyizgEzQX4wnX8EQm9ORHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB+stNrMyPgWpsU+pHKUqi+efPvOl40iUGcT61+8r2c=;
 b=UAkHcrizgOB1JkHx/7A2+LVqu3SPUEes4z0/9aPEJU6hUkF5TxrdVROhypeMvIDPvJyArwSMmG06MWsA/o2w1576eD1Sk/Uo6hpNzBILqViXr2mBU54z6DOw0khELdLZg8onxuJpRHjD1FDFqHMCOCz0/k3lctLCgY7G7+FDA+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 11:21:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 11:21:50 +0000
Message-ID: <7d80a32f-149c-4812-8827-71befdaae924@amd.com>
Date: Tue, 23 Sep 2025 12:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/20] cxl: Add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-2-alejandro.lucero-palau@amd.com>
 <20250918115512.00007a02@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918115512.00007a02@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:36::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a36a10b-34cb-4605-c1b6-08ddfa9363cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1RhSU5UQ29nbEdoUFAwR0h4b2FNVzRXOGJUb0FIV2wxOWF6a0Q4VWNTN093?=
 =?utf-8?B?c3BvTWhkOWNvWW1hMmRrZUJuS1prbmRaazg0TFo1UkRRUi9ldjZMZlhtdE1y?=
 =?utf-8?B?bjVVRjViYmJhWXgyQlJLZjlRVXpBOEhReXBpN3hzbW5udENSNHVNanNSSGdQ?=
 =?utf-8?B?MDlMcThWa2dEazVyV3N2NFJDeUppYk5rUjlUTE1wN1hlMGhPNWhBZkd3ZERj?=
 =?utf-8?B?a3FGek1FT3B1aW9SaUJRaHp3dk5wQm9JYXVXUFNKVlJGVDlEckJqRUVpOUJm?=
 =?utf-8?B?SEQ0cVlqN0RMbXFRYTYwazgwWXVUL1gzZXloNlBTN1FFb1NrZjIzY1NFK05w?=
 =?utf-8?B?Tkt0Q3pyOGhjTEp2cEU5SnQ2UkV1aTJqNEFHQ3BmRVc2SU9FWjJwZDFFZ2Rx?=
 =?utf-8?B?eTdsQVE0MmVrTjJTYTRBZ1JPTU81RlUrZm0yTGFac1Z0QUhScWNhMHVMTXpN?=
 =?utf-8?B?c0k2VzZWZkxoMWVJVC8zVitkY2JsQjJlV3hWS2szaC94d0lZekZZZW5zdUMx?=
 =?utf-8?B?ZnBrUlhIYWs2VFg5Y3R5eDgwUHh2SWpwbUsxS3NJck9uSUw1ajEvOURwa2JV?=
 =?utf-8?B?c1Q2Y2Y3WnhFZEdqOThxb1NUaUwrUkhlYTFSV0l5OGUxOU9UM1VmWnJFRHBS?=
 =?utf-8?B?MWRvY1RLSFpXV2hXc0Z0T2l0MlE0dnZ4ck1BMmJnNUdBSXJZc1pHVDFFM1VS?=
 =?utf-8?B?d1ByWTVueHdVdC9PZUk2b1hWR0NkMzR4UlhwZ0oybVVuY28reFkzQm9UaHhl?=
 =?utf-8?B?b1Y2YS94QStheWlpcjdFQ3A2R3crYWczMkxCb3k0dGhEVmNDaDhKRDR2aFZu?=
 =?utf-8?B?OWt4U2RONjRHdCs0cWtvcnpIbWF1c2ZVRDJHWHNPc2V2NmpUbkx5WlU2R3gr?=
 =?utf-8?B?eUkwdkxhWHprWFJPUlM5SERBSUg4bkx6d0lmekFWNU8waTZ1Z2VJbXFyRlA2?=
 =?utf-8?B?V1A5Zjh1WGs0TkJOMW5HSVhoMjFQdEdvS2FLSlVmSWhQcXVhWUV5MFNKa0FT?=
 =?utf-8?B?OENUaG90TjlVdHhoZUp3ck00T1BheHNTK0ZMK1dBQmlaTVp1czh1QUMwZEIx?=
 =?utf-8?B?b1dGbiswQkdYVWhJcS8wODFyZkhSdUFhblIwNUxDbVZPTlVPTWwzbU1lVy9X?=
 =?utf-8?B?SUFOYTUvTTd2ZXUxR1NWcEtWb2ZGVHNrSUowSzhrTWFtNmhNallmd2RJK0pW?=
 =?utf-8?B?SHlDZ0o0VlB0R2I0UkVobGtnYVlNUmRuaWVTc0w0cFlmUTl4NVo4WEtxOXZU?=
 =?utf-8?B?b1k5d2VKU3c3SnBKbVV5WW1kUVhDb05EV2lWd1FsdjdHRVFGNkhjS0hucTFO?=
 =?utf-8?B?ODRUM3RXa0VXRGNxRTA4UGl0SmkyU01wd0p5YlFqVXo4Zy9hcHhsZ0M4b1Q3?=
 =?utf-8?B?Qzk2S011SU15R3JBMUNQaUpkTUd0Nyt4N1VPMTAvZDBxcTRZTWpKZDlrZ05w?=
 =?utf-8?B?clNtd0p4ZEpiTFhTa2RITEFEVHlNTVgyc0lyZHVHZDdEdnFlOGRHMW5PTi9t?=
 =?utf-8?B?bVBUVC8vZklCMmR6Q0x0TUs4SVUrSDB4RVVmZTMzVms2VlpRVHVnV0pyaUcr?=
 =?utf-8?B?YTd0b1ByZlRRL3RjUUNaUGtuWmwvZGQxTzQvODRHbVFQT3JPWnQ5RmYyTDN0?=
 =?utf-8?B?OVhoZzBlbGRpNGNNSDkyeGxWak9CMkFXZVhBTWRTODYwUnFpaFRwUHozQ1B1?=
 =?utf-8?B?TTlSR2VLZks2ekloZHhta0RZSjZKYysyaWZFWGtPYS9PcjRXVEdNenFzQ21B?=
 =?utf-8?B?QkIra0dvQSt3eDFWVmZCTGtqL3U3U2NwN09BdFJ5QnMzUS95K3ZMOVFiNG5W?=
 =?utf-8?B?YkNrWDA4NWlYSmR4S0ZLaU1mcURoUk45c2xPeFBCVVlQQUpXY1E4UW5oWDJL?=
 =?utf-8?B?V0xMMmpmRU1zN3VkbXhzdjlVL0Q0VjRlTXlyRHFlU1BFYXZZT0gwREhqOTBo?=
 =?utf-8?Q?Gz4cvFZUF6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVVOdGlPcklPTTdRM3RDODlYSW4yUlpUMWZJTFBBMzJTcEJCSlVQajNoNWUy?=
 =?utf-8?B?cDJhSVQwRjV5eVMwMTlzeC9vNXgyRmZBT3BuL3crVGowVys1MXlyVG9ob0tF?=
 =?utf-8?B?ZGVQalFxL2lhcWJWZm12b2Y5RGk1bTdVTWgxekdqU2NTM2JmaE9ad2k3YU5Q?=
 =?utf-8?B?T0JVZEVrQ084Z3c5TklVVHhsVXBKNVhRTDZYOWZCa0xrOHI3L29reEwvOUdC?=
 =?utf-8?B?ZnZBc01HRDkrbkhYS0pVdjhBanJMVUc1UUQ3T2JCSlp6bzUyRnUxbUFpK3VF?=
 =?utf-8?B?TDNqVk9UOW9sSU9NcmJvaUFFaU1TaGx0V3JrL051YkFKNUZodGF2emVWM1ZR?=
 =?utf-8?B?U0d6dmVremw3U1JLMXhXL2QvRXN6amFCZzNQRDBOKzJsY0VSQmlHbWdYYUhU?=
 =?utf-8?B?c0lSTTFWTVN0SkdIVU5zUVJEbnYrLzZIT0V3NzNlTFFmT1lsUThkeGVFaEtT?=
 =?utf-8?B?RndaYlRBeHQ1NnVkeXRoSXg2b2wweEpSbEpTMUxObFpwSi9yd2tzU1l5aVZ2?=
 =?utf-8?B?TU85MnRQSHZjSTVDTlpjWEo1MEl1dVJJZjRHM1U4MmszL3d4NUFmM3d6eDBl?=
 =?utf-8?B?djhxc3Q4QUpWQVY1MzAvcFZESHRTNnphVDYvbUJOODNGN09PRUs2ZGQvVXc1?=
 =?utf-8?B?WDBNQ3NZVllEMkQzKzJickVZU0RaSmtZRlovNXBkaVRYOFlOSGlhMVo2aTc0?=
 =?utf-8?B?STV5djF1cHJjQWdIbnFwSnlPUzR1d0FPZ1N5aEE5RDBaSUFBcmdhNUVGYnFZ?=
 =?utf-8?B?a05aWXZhNi9sRE91dFBoOXcvZXVodXRHSDVOSk1iK0JFS2pXd1JMMEdXSnRO?=
 =?utf-8?B?UDlFM1VHb3laY3BTUlI5dGZVanAxOEhwOUd0aHhZeHovbDUrN0JkNDI2WnV2?=
 =?utf-8?B?VmZINFBxQzl5TCtaS3hvT2o5MEpteVdFNVE2UVZ6ejR1Tzk3VnNxbWtNUXRR?=
 =?utf-8?B?NWVwaVduZGNmSmdCK1FHeU91MnhkS3VJOFd3dEhyUGdFd1NIMDU2YUZoRzhG?=
 =?utf-8?B?UnNWd3NyUXh4VFlKcVo3UzlSN2hXOUZCdkRVeGRxdFlNcmdZOU41QU9JWUFX?=
 =?utf-8?B?c3dzMWtMSm1nZmZCUCtwNnRJdk1FZ043ZWFZbmRUOU12YWNsMVlKbklteElU?=
 =?utf-8?B?a1VPMXN3ajY2ekxMU1ZhYUM1RTJFRzMyVFRmMnorajJnUW53UHRPa1Z5R2J1?=
 =?utf-8?B?d04yQ2oxRDJ0c2svc1Z6TE5KWjltOTRqa1VlazVvRlpPOU1pZUVYOXpTUHBx?=
 =?utf-8?B?c2pLeTRpdE5HTitacnRSUDdwREphMk5TV3ltUEQ2S1BRdnd4SDZYVnVqVk00?=
 =?utf-8?B?RTZacUpiSGpaY2JkM3BkN1NrS0JMM3RiNlBBRjZHOCt4THR4ZXcwSWQ0RmhP?=
 =?utf-8?B?L2RDUjllMndSLzFzbFFlWjdNTDlzQVBVT0lFaDZuWUUzYnVnSlZ0NWloWmlC?=
 =?utf-8?B?WDlPdUdiZCtiaVpXUGJJRDJkdXVveWhrODkvMzE2Y09nSldBb2xvUCtEejdQ?=
 =?utf-8?B?NzZucTJ1TXVkSGkzK2NnS3NDY0pZRjFjdGN6dW9OMDJUcDQxUThxQzE5MHlJ?=
 =?utf-8?B?ajJxbW13cE1TWG5Od1RJR25LT2R3ektZOTh1Zms1WnByb3Y4MXFCQjJKaXYv?=
 =?utf-8?B?eWMzMkFkZ3VyMXg4RkwxYjJuQ0tZalVsSkhQY2lHa3UzZU9lMnoyVDV2a09a?=
 =?utf-8?B?a01vNjN0QzRSaTgxMkpBVGtDTGhJU2ptbGVuMjF6VzZZazdZSmlQZTlDWWFY?=
 =?utf-8?B?S0ljNTFXR3cxQ3haUHVkWUVZL0J6UUlRUjJ3WnN0aDhtVzF5UGx5SG1rVFJQ?=
 =?utf-8?B?VVVzbDFVMmhXcGs1R2JKdzh0aGQ1VFJDam5LRFVWa0dlMHpBMDhqU0c0Vm5y?=
 =?utf-8?B?MTdYVXlTVzJNUytOOGw3ZldjdXJra01maXBGSlE5TWVYdmhKUnlUZG5rdlFs?=
 =?utf-8?B?WmNSMlZEWWZ2RFZqZDlDR0V2a2xXQm5rTjNNaFNTU0twMW53V0FFRVVqa1dt?=
 =?utf-8?B?TFQvWHhiK3JtaGN3aFJuNE9rN1ZTT2JXMEQyUzhyUnNRMmVLeklIZHNVUWRl?=
 =?utf-8?B?RHkvQUJheGl2YUR0eUpjTDAweGNEVHhPaUVpZVBqeHJQWFpWU2FVaWlqTHJo?=
 =?utf-8?Q?jtRtTpZ8MBYbK8HwhQtF26zYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a36a10b-34cb-4605-c1b6-08ddfa9363cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:21:50.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbdoIFIoI5c3ne2ek8Uf2ON9QqJH3MT3QDqxOE0o/4ezZGqhg0UHHGyGUgl6PqDpVztF+UlkODaUnWge5Lefwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352


On 9/18/25 11:55, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:27 +0100
> alejandro.lucero-palau@amd.com wrote:
>
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
>
>> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
>> index 257f513e320c..ab8ebe7722a9 100644
>> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
>> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
>> @@ -347,6 +347,9 @@ CXL Core
>>   .. kernel-doc:: drivers/cxl/cxl.h
>>      :internal:
>>   
>> +.. kernel-doc:: include/cxl/cxl.h
>> +   :internal:
>> +
> Smells like a merge conflict issue given same entry is already there.
>

Yes, I'll fix it.


Thanks


>>   .. kernel-doc:: drivers/cxl/acpi.c
>>      :identifiers: add_cxl_resources
>

