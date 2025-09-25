Return-Path: <netdev+bounces-226231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B9B9E5B2
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B249F4A205F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68362EA179;
	Thu, 25 Sep 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1NlTM/cZ"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E482EA16C;
	Thu, 25 Sep 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792466; cv=fail; b=YGsyK7rbASAuiOryHnN2qU+9Vh5FsalD3zT17MY1SfykWNdwBUnFDxPZyxfCUq4aJkxUWmMqaVMsXg/yszuIfMpn24LtHL2t0AQc3oKJOHmpyLVHaOhoNDexs5Maola2ciVVwoMG8p9PYCDkB0DlIOLsymO48q1B/+ZIvLzZClA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792466; c=relaxed/simple;
	bh=lCvd9wPUJzJ08NrhC3nBJ//RQfhdR8/hFJJ8V+NE6yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TAJWQsXHq3tb8A8Ohq//OU3la+xuZuThWeKg4+xjtAjaGaI0+pvgx2XaVecMtsNb149X4pSlrfyfgOP4mOnpUI9JaA3BKlFQ6h/XxszfTzWOKVO1GaJxjjszt/1tk/XlXlKbAJ+XOQMCY8CC5M1xDHq6dH9wE6JDGGk448hIiFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1NlTM/cZ; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftoMWqpeEnxd0DNylToISpgi3UZM2KGAS643yeGPCQ596Ww++yplhnuahG6peDqEcCDqEeJ8CsWjQxjKXxUbFezPapjsq9zdRrKpchNC6ZaJZUyq3xxGg5si9UAdTrzw/fku+Rm/VGVMjzU4uqd0X6KbaPYb1i0G9IMj7R32l9a3TWvP6gBEBRDSSD1ykiPC/EVS8rWoSyB2dVzblbJ4XeYEUNea2RwYcH8TxvBtVV/HQamuRcGSDt9WXTzB4EsqKYIt3Ac3Eb5DSRzJlbJyKe8VHCJ2Q/94u5NIOsO2ak7S7ExF3ADd2gcG3wVhL1EjkRtP5lBUYawbkqeYFR15Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2ygcKLoxGhuxBqInPbExuzFbqVdp6rTvFlvL8Lh0Kk=;
 b=Z0o3ltZlOSovptkPgEcfnHpb3WZ00LoL5ZKUk/Mat9+Wm9Cf3S4BAyXKTbD1Qqq8l3ejbmkneJ3hUO0zq4uNApgPSISPpvvaCaaMvYc8OPk9toqgd+2xk+f2t+qaxEPGnM1wbWRd0FbxREMyio5cBm4SObpHT0eI6r/o38gwlFc9sm2SN1/6a0nHyWUanhP+WXW5c6F4HlxQzVFGlcJXFkJ6jToJOLO7kIVLKwfK9Ym5Cl5aUGwffDUR5f3L1M40BkETMI+yuFM5TwPABiP7Or0+fj1Jde51hWXACUQ+PggUkESexo8UHJ0IiEm1eY/Uk8DSKCCXHLVY4BsCcGE5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ygcKLoxGhuxBqInPbExuzFbqVdp6rTvFlvL8Lh0Kk=;
 b=1NlTM/cZLdv8Wfyx+YryLZnKheVz5ACztOjQZ/BmU6bCbe35VjXcsDiuEiaOpA9u6OodSRDRVnspJ6nV5vJx1d4qMfyHgqApqzvlMDoVrXi+Wh6Zk3sHgs0WtpiNIsxjTurtwhoH/XEGeVos42C73sYHnStIBBbO3I736NPu3Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 09:27:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 09:27:38 +0000
Message-ID: <d790f40d-c211-47d4-a76d-3cd43306cc67@amd.com>
Date: Thu, 25 Sep 2025 10:27:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 03/20] cxl: Move pci generic code
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-4-alejandro.lucero-palau@amd.com>
 <57a45831-9a62-4b74-a0bb-d9b0a91c8705@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <57a45831-9a62-4b74-a0bb-d9b0a91c8705@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0488.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: a6247e2d-5ac4-43fc-2704-08ddfc15c507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmpCUEhsd2t3cGNyb1pCblNFNnpEN09URGlxY2l4VWdpd3QvLzFEdE5iQ242?=
 =?utf-8?B?UVBnWXVDN1NNT0ZyNjZXRy9TSHVBdTVObjVPY3lNMXo5WmgvUHdBeWJ4UlFt?=
 =?utf-8?B?NU9XMXNVd0N6VVNmOXJtcGQ1UU9Va1JocmUzQmhMbE9WRC9kMUhKRXVLR3RG?=
 =?utf-8?B?b1ZiOFhxUW0yci9NT0VZWUI2dUMySEk4OUF3Z2FVdnhVRnRmU3ZMalRId0ZV?=
 =?utf-8?B?MGhTclRpNjh5S2lEMG1XZDgrWnhjRGpBbXFNZ3U2OU5vY3VheXl3RzlYbjNu?=
 =?utf-8?B?a2psUHZiOEhGTTJQM2s0Y2tneXcvREJRTXFJa0NBNzJNTURzZEdQdTlaQlRr?=
 =?utf-8?B?OWM0cTZxTVZyVEExYTRod3hYQTlCWkNXa20zZVI5WVY5end2bGZUbC8wRWhm?=
 =?utf-8?B?QkZ2TFhLMzAzby90VTNBKzRrVnpGSEFDbktDdmxBSmM5amhkQVhOQy9CTjFW?=
 =?utf-8?B?T09jTVp6eklZbDlwWXlUVHJUMmNWekJFSytOSlhlNVBnTElnZzhoeE1jaHJ5?=
 =?utf-8?B?clFmRnJPT1RTZWJjZjR1TE1DUzRkeDRxbitUd2FhQWZuN3h3NnQ4WmJwTE5y?=
 =?utf-8?B?U29iNFVyMjVLbEdGanc0ZGRiRTlqQjgyL0k5NzRPaDZacWgvUWFrMGVDcUpv?=
 =?utf-8?B?Zit4R00zc2d0c09IWWd2d3JHQm05RTdyU2F0b2wxYjhmdG5BZjhzUkZWY3J2?=
 =?utf-8?B?dE43ejF6S2dQNHQ5VXRaOTJHNjBZeVhwVW9uS3poUUpkOE41YUozUkhBcmI5?=
 =?utf-8?B?MS91WC9NMDBNS1dTaUp1ekRzYnE4QXE4SEorZnRHZ0duR0RoY01HdVBGQXUw?=
 =?utf-8?B?TWVyUjFPSW5oYXJJRGZ1QS94eDJ5a1h5aCs2Qzlub0RVcmJKUGhzWmE0S09l?=
 =?utf-8?B?aTJGT3Yxd3lhQTJVRm8wejRpdmE0cUxHT3MxYUZNRy8xUkNWMmc4K1ZEajdr?=
 =?utf-8?B?NXFaVnRQWTdDMktvbE5xZkVuUHFPY3k5WEhjQWdPb2RXL0xOSDZuMDFCSUk3?=
 =?utf-8?B?M3ZtZitCRDFpQlNYNDNXOXM0QklROUFGMjdTU3lxTC9USmFKaDErM1h3SFZW?=
 =?utf-8?B?ajJlRW92RUZiaGs1R2lqTEsxQm9vQ3lCQ01JK2hLVDZacmlQa0NOaDIzSURn?=
 =?utf-8?B?a0djQ081Y3NLWWdTd1F3MUdOdFB6VHZUOHlaM2phNGhWS0hZZGF0Z2dRZEdF?=
 =?utf-8?B?ZW1qczdRYkZLRUdRSlJIWlNZMlNYODV1dkhJSWVUaGdsc1NRaDNucFlMcVRQ?=
 =?utf-8?B?aDVuVjlSTk82WlJNTGZGNjdlbThpd1NyTnZWaGJMd1hKZ085di9JVC9TZlBK?=
 =?utf-8?B?dXBNeWhNWkpNQXNmdXc1TTdZTjNleUJ1MzEwYmprSEswRUdmT0lNTDl0Nm1K?=
 =?utf-8?B?OWE1SkM2ajJiTGVlMFlhK05UUzd5OFhIT1lEZmxDL0JNTVJsZ205aDNQZE9y?=
 =?utf-8?B?dzI5Y3RGbkNzZDVpd1dSRWdacndWYlpQTXU4Z0phdTRxeWJJVWp5TGFvdC9K?=
 =?utf-8?B?TVY2N2wxcUppaGxrWEYyaHJIcjV2blFIUHpZYlRGRFhpcEE4ZURsRGcxci9U?=
 =?utf-8?B?TmVJYkVFcFRPN2J3SUR2Ry9oWld1WUpMNHk5VnY1aFllblRsM1d1WVR5bUd3?=
 =?utf-8?B?Q0RlYmEvVUxFYnNUU3BZdTlEQ3NQTEJERmpSdE5pVk9sS2JKRXp0RHRpSFZv?=
 =?utf-8?B?d284RWlhOWN2L3F1UEJ4VVBxTmxIVlNROE5OK084L1BpK2ZtamNLajV6OUxQ?=
 =?utf-8?B?RjZUUE9DTEhMbjM5N1h2eG1NTHBXb2ZGM0FRQURSVmg5THJYdk16MkQxaGRo?=
 =?utf-8?B?WG14MG1aVElsTGhQZ2QwUis3Wk9tRk5TZ1lQRDl5OGVGdEp2NzNsbmkvMmdR?=
 =?utf-8?B?SjBlQjhuRjc3eUI5ODRsSDVNeEdBZnVNSDQwSU41SWExY1p6YTVOYUhUTVg2?=
 =?utf-8?Q?0tMksWAJrG3YQ4HOboOkfARVWwdBYzvI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnFRVEFvVUZzL2hib2VVYXVrN1gxL3FkQ0tYSFIwMFFOVHJtV2R3OERKalVW?=
 =?utf-8?B?RFZ4emJwME44SG05a2dLMWE0Ymw0SHVYVy82MVdTQ0FpZnB5cmQ4cThQcDkv?=
 =?utf-8?B?MGRFMU9iblVsSVNjV0QrclVJTThVZXhvejdTeVpPbmRqRGkyNHJVcEQ5V0xr?=
 =?utf-8?B?WlZsajIxN3JOUy80UVRHOUN2T1N5bzNucU83M2hnNGlmVWFvdDVxblVKcUhp?=
 =?utf-8?B?eWNsd3kxRjFwV3Roc2RYTjFpMjdSRi8zbUlURzQwOVAyMy8wdlJKby95dDkv?=
 =?utf-8?B?bW94UGpYRS8xVTZhUEJmRUFobXEwZit1UXlnQTBLbU5YZlFFMVdLVGFsaGVu?=
 =?utf-8?B?VnBrbTFMYlJZcHZoK1dJTi9ueGg2eGc2Qk5iWXNSYmNVZzJ0MlZuK1pabmlu?=
 =?utf-8?B?V25CTysxb3FtQ1E1cENaaDRCbUJyZ21QaUd0RTRZcFFxYi9QQjhPTDFONTVj?=
 =?utf-8?B?elNNbDJRblVJQXhPSHBzNjIvUGhzS1JpdnluWE1YWlFpVHI0OXNJa05pVERq?=
 =?utf-8?B?bDA5OGZKRmZrVHV1WmZFd1JCQllSeHZMZWZPMjJRYmdlejh5ZE9HN2NhUmxr?=
 =?utf-8?B?SWJIRGlPank2SGlkTHFseFMvS2c4SDF4Rmx1M2FOcVNEdlg3VG9rTmk1dUpC?=
 =?utf-8?B?SFdrKy9IQStTT094OGVWZkU5SkJKOXdkVW11N1dMcUg0UlN5d1Qzb2VFa2h5?=
 =?utf-8?B?THZNYkJKck9oQWlxK0dVSGN6MEdvSWp3UXlzaUovbm1ZQ1d3MHFvTFl1V05H?=
 =?utf-8?B?ODQ0Nm9uQ3RZSVhnemU1eUhzQmFqVExXeU82d3BVdEM3YTNtaTdNZVp0a3hp?=
 =?utf-8?B?YUFxamRMSGhQeTVWOEtSa1dQN0F2aTNIRHJGYksra3VkQ1pNR2xQaWU5K3Rk?=
 =?utf-8?B?NHQzckpnLzdRQU9ESzBVelROL3RaWU93ckp5cG1EZDJpNkU1YVhzUXZlUmxZ?=
 =?utf-8?B?VkJxK0RWMkJqRlZQaUtHOVpYanpGTzVOR1cwNWdZRXVUeDB0SXV4TzZJdDBo?=
 =?utf-8?B?UzR4Z09Pb3NJYjd5bkJTaGxQeTF5K2hXdzZBRDdNYklKMzFOcFp2TGM0OE5v?=
 =?utf-8?B?MWVKRUZKVERFaXExRmN5TElXOVlPbGZqN1o0VXRkeUoxcUQrRWZ6Y3ZoZGpX?=
 =?utf-8?B?bVAxVHIrV2EwaGhaYTIzeVUxNkM3OFhxVWtmTGhnclFCUUN6M2FwSTIyR3Jz?=
 =?utf-8?B?TmczaFo3SUtqWmN2VnVrQmZtL1NoU0JNMkJLTVdZYkdnTTZ4MTU5b3hidU1n?=
 =?utf-8?B?N0JKVnEzcXhhSHZVMkJ4K3BXdUx4YlpBaGNQVUYrVTBzQ01XaWxYNHpvS1Y1?=
 =?utf-8?B?VWVJejlPOFRlWi9FcU40SzRrV0loK2h0cGhQdFBBS002a2l5T3c2eDd0cVND?=
 =?utf-8?B?b3NkMWlWa3JWRXB1K3Byc2xTMGtrNGtwZ0ZXUXl4d3plYmFraDFsN3V3b3Ix?=
 =?utf-8?B?TjBmNlYzQUQveEJzYUx0S0svaHhOZi9rTTJwUTl0MVNhZnFqZ1QyQXZSSUFw?=
 =?utf-8?B?a0YyRHprVFBoODYxRGkvWEN5UWYxN2loeHFYWFU2bmQxNEhYMi9DbTJ1ZTd4?=
 =?utf-8?B?ZjA5QUV2cHBnR3lIL2xSb2NBUENHeFhXVktUZDJISEdLNSt4aUp2OHZ1TWNi?=
 =?utf-8?B?UzZ2MUkwNFVTa1dZT3UzcUgzLzlFZlEyN2xuWUozUjhrMHIxN1I1Qm82NVlh?=
 =?utf-8?B?UzV6cTAwMDRMRFZwM2VIb2NFMHNxNmU2Z1h1cVB4OGh6amFjSXBOK096eTFV?=
 =?utf-8?B?dDNwa25sUUJtYTN3bHFYckNpcWFSbGRjTURNMnpaanFWNHpwQ1pkdWdUZW9G?=
 =?utf-8?B?bjVRVzhtL3Q2SDRtTEFYSWpoRVdEeW5RaktZaTFzR3lHb2dwWUpOSkRuSGtM?=
 =?utf-8?B?RVhEeFNTUk16anE1ejhGb3lhYk5yZG1kMnU3NmRYKzlsOWdxeHZvV1RHNkV6?=
 =?utf-8?B?TVhwRHo2VkJDSzE2YWV6N3dPcytIMWJ4VnBrNklweVFiTUFRRzRydWlkY1cr?=
 =?utf-8?B?UnV2RmtURnAySzFuUThtaUpGK040VVFtSEpZOHhQdFBUampDWTAwUCtDTEQw?=
 =?utf-8?B?NWhTZzlaU2kzR2ZBYUFIN002ODQxOVlJZ0dyamxqeHN2d3BNdlpzdng3N1VS?=
 =?utf-8?Q?MT85dVEs4E1XxZdtO0Q4QUmO6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6247e2d-5ac4-43fc-2704-08ddfc15c507
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:27:38.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESuW38kGGoZx4BSb0haodTZTHp0ldfXjqe+l+WtRvokWlFNrF5nOq7wBibnDA2JQhF0jVPV7jWbOmrGFqMeJMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263


On 9/22/25 22:10, Cheatham, Benjamin wrote:
> On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>> exported and shared with CXL Type2 device initialization.
>>
>> Fix cxl mock tests affected by the code move, deleting a function which
>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>> setup RCH dport component registers from RCRB").
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> [snip]
>
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> index 5729a93b252a..d31e1363e1fd 100644
>> --- a/include/cxl/pci.h
>> +++ b/include/cxl/pci.h
>> @@ -4,6 +4,8 @@
>>   #ifndef __CXL_CXL_PCI_H__
>>   #define __CXL_CXL_PCI_H__
>>   
>> +#include <linux/pci.h>
>> +
> Unrelated change, it looks like this should be in the 1st patch.


Yes, you are right.

I'll fix it.


Thanks!


>
>>   /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>   #define CXL_DVSEC_PCIE_DEVICE					0
>>   #define   CXL_DVSEC_CAP_OFFSET		0xA

