Return-Path: <netdev+bounces-137047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044D9A41F4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2021C22E41
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1B1D7989;
	Fri, 18 Oct 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOSt/oVW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081A768E1;
	Fri, 18 Oct 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264088; cv=fail; b=LLDvaHB5VaWqVAczmOqgrE1eTL59jwaYWIVtTFm0dBpmWuNAbMtnKjIvikd27iA0dbU2WFiXQ8FXQnrOWhXGyRDSkh68382L2K6hcHmxKljBvn54f5UW/UGd6aupKVexfwc0cILFMd4UpCu3QLAcTSP/ybIx7wdo2vRc5TNt+WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264088; c=relaxed/simple;
	bh=no9txGadVMbOkZrHQnKVdYYUGWfQ1ifProCZ5zZdyXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Loa835ycdfbiAxUxGWL3gM0No7lMGS8vYFnZRIylBfQq8hIpxIUEC0dOymhdshKF7cfSPQm7VGx2ZH0UxnCHSfRstxUWN73Vzyqo9oMcJhLLk/vxe8acUlA4ZwhOqIEYBmVaY0YtTJkh8nNkg0fEe5R36hFniEbskYk59+bB8no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOSt/oVW; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2ZjnSRdLhYt/PrTosi873he7uCe7ii/QeOb2YrTnqdCXg3PsB/C2HX2HwXrg0lNIDj21OiYj40klaGdcF7MgoXqmE1LpIJlt3F0temKsJ8E1K0j5Avu45+f1OENexUukffmsPV5QHyyA/WLDlyh6IbTR1AzKduvbJ2eOne/Bibk2Pa/wQwj8Iu7wyUwQPa00zcOEcTw2gHW4VofbYYxlKFU39oW9YN64XTtI+Mo/K3xMxCzFol/XolbFodIK3FCWDP3LoXLBNSpJ4JKhFUqUtXHe9Q99XT8uj5/VyWW/Emirzjw9ZzRq+LqJmIY8hX8InWEcJi21wP1Vanhk+GoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzFyaRUmUzeoBMPi0a+jy4Y7Opw3nTk8zy2W1bSMCMU=;
 b=xkc6hmxa3aDjGvYPJA1sknZSL0H3XYgz0TlMNYP6uRFjbkV3+xdhG6IFuHWVVzRmmmvUfbsSJzDP1DNozh+M9H2+OkxFsmh/h1wrsbyD0VZ+rhNvDl7DmRUjWOncFmC4OYk9lROP5BfUo9AtOQGqcOQ1z+GeE+XlohgTq6IM92wQHZ3G9dYYoS7qGINPTSKD24Y/VdoRVkh6TR/ZGj911pdJKyKUuqYGoKM9gB51UVcfp5/RkSbnXUjFeGMiP95gzI47+uR49aHSAyeCNf4cGkANpbv3zcYMv+Cl7Vwn8kWOaiZZRz2wHKbOsU8EOD79NbLXILJpBJUo9ReJHn0rkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzFyaRUmUzeoBMPi0a+jy4Y7Opw3nTk8zy2W1bSMCMU=;
 b=EOSt/oVWRDa+yBW3naYmjfMgfOMrILI5jjSYIc6KkSRkY9CYLD3qo3OYyBIg69OdCxTmTSGjQT3PelFL+i/Q479TTeqSYHpeZ51w8FBhGbDTIWRYX7koOQtytAQeRPGA/zfWskuW3Vjw3f3ChFYIfxYXxXdSfo4/zex94h/6788=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 18 Oct
 2024 15:08:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 15:08:02 +0000
Message-ID: <9ca37921-91de-6bfb-e086-9da2e7fa757a@amd.com>
Date: Fri, 18 Oct 2024 16:07:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 07/26] sfc: use cxl api for regs setup and checking
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-8-alejandro.lucero-palau@amd.com>
 <4ce8cc04-71fd-424a-9831-86f89fcd7d2f@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <4ce8cc04-71fd-424a-9831-86f89fcd7d2f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 30309f9c-c6f9-4659-e00f-08dcef86a8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJRdDI5NFl3ZHBWa1ZuZ0Fuc2VNWWtwQzZpaUVmQ0dYbFFORjBteUVmT3VC?=
 =?utf-8?B?YTIwUTY4MTVtTzY0OXk5VE5WbndxSVNQREt5bURqaG5QRzF6TmszdWUvaHpX?=
 =?utf-8?B?TzJpaStMR2VZeFRmL3NQdHFwZFV1RXJwNGlJaHNCZnRkQ0JCNmxqcnRIU0xM?=
 =?utf-8?B?b01Bd1VYQjQyRUIrb3JXVE9lUHhoVW92ejMzS2pCZy80RFByZmVLaitsNEtt?=
 =?utf-8?B?R2hoNW15alhFRWxQVHZ4L3BHcTdEcVNlNGlKL0RsWndlNm1UVmdnM0dmVXB1?=
 =?utf-8?B?N0VPODJTV0tCbGJQN3ErT0NhdlV3QWdzVmcrTmJLcnBBRnkzTXd6MjdmUURx?=
 =?utf-8?B?a2JqTVkyc1FKZmFVRDdrWngyL2hud0xLRHU0Z3pSY0RkRzRDbHpNMW9Cd2Vj?=
 =?utf-8?B?aFRQc2FqOEEyMitaL29wVm0yODhyaEl4R1NESFJlVlpzOHFuN1I2TlkzT2Z3?=
 =?utf-8?B?T1luclBzK1Rnb0NlU3BNS3EyNmFyTm1LZUtLa0pqYjl0NysxU2RCa0dCdVF6?=
 =?utf-8?B?eWlhL1h4Z2hmSUYrZ29uUEJGVjhrTjE1L1A2ZHVuMFM5Sk1yMVVrZGVuSVRp?=
 =?utf-8?B?Uzhjc1hXM2Fmem5pNzBPVUpaMEtna0dGaUo3VkV5ZGR2NENOKzlpTUlZOGpS?=
 =?utf-8?B?bzZjYXF3aEJoS3EyUnZSVUlzVFNTdTlFemZybGwveUM2eElsVUprbkFYRkFu?=
 =?utf-8?B?SGltMXV3SzlocHhKMS9LZE15NXB3eXJSV0VEcTR2NFZ2VEJkMDRoaUNzcndX?=
 =?utf-8?B?MStyN3BiWENKWkkvUmxJUUxadEFLR3crOXo1TnZwQmtwLzRCNTdid3Q4WU5V?=
 =?utf-8?B?d0xiUnc3NkNEdmVyUWY5QVp3VmhBbGNlMnEzSENYbi8ycktFblc3Q21LWVJ3?=
 =?utf-8?B?SFB1Mm5FRWlBdEFQTmRmRDU2UTFVeldNSERDWkxsTUJiV3pzc0ZyK1lFY0Fm?=
 =?utf-8?B?ejQyMWlFbGZ4UUlrbXVxNm8vWnBxc0RLS2JDMmFyRk0vVXE3aGZaeDg1SDVY?=
 =?utf-8?B?QjhBY1E1WjQ3M2ZTS242TVk3eU9yN0l1TDc1TElVM1RnTXcxZmJYc01yUWFQ?=
 =?utf-8?B?eW84YlZNSkNERmhyWllHeHdXc2ZjZE5sZlhnZjdVU0JRdGt0M2g2K2djQXIx?=
 =?utf-8?B?cVNjQmJmVWgvemlEYld0NUpvVzNGRVJTbXdDMkNwaWxKZGlSdERVZzArVHRO?=
 =?utf-8?B?d0M0OFFiY2lXdkJVdytQYkFMSjVRa2tndVlaWVZvb0R2MHU3dE54T2hJNmlH?=
 =?utf-8?B?RkhtajJFdEFLU1hXT1ZIKy8wTDVFUitjajFPd2VMUlVya1FHQnhtZnNjTHha?=
 =?utf-8?B?TWxlR1NmdEhvU2hISkJKcGJRYWYybXRvZVZiUGN4ZUZlYS90SVF5Y2Z5Vk1B?=
 =?utf-8?B?bWQ3UEJpOW9BVThRczQ2aWxuR1h5MzBaZHh5cXBnd1V2UzZKZSt0RmFuSGJJ?=
 =?utf-8?B?V0hHcXhvUW41bTJ2YmVyL2lJMUFOY1diQVBjSVhQMjlteTRCcXNXRDkyRU5K?=
 =?utf-8?B?dHBzNXg4ZEJtV2FVVTBTWUlHRmdlRE5hNW1IM3krUHNsdnZVeVE3MGdseUJt?=
 =?utf-8?B?NDVBdUVDUElOUFMzdkFvTlNmTFB1NWJsUW93Z1J3TERPN1FuVUhvVElhMm1i?=
 =?utf-8?B?T1JTL29ScnZnQWk5YTdvd002N1ZwQTFlU1lUMzAvSUdhRCtBRm1JYzA1M21G?=
 =?utf-8?B?WXZmMWFxVERzSEI0ajdLRVN4ekw0WjhTRVRtckYwWk1mclRmNjFVaUVMT05R?=
 =?utf-8?Q?fvRb4VVaYEwI1AVyoXcGZwUH2Bt6uxDGm/ooYAh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNtSGg3NEJTdytSbzhoOWJ4eU8ySWlRWWpYajk3WVB6Mi90N0tVaVZ1Lzlh?=
 =?utf-8?B?ZitZaTY3ODUwQkRPaWt5d1h0ZCtGRjZJVWVWMTJrdGhDalQzaVNacGJYazZY?=
 =?utf-8?B?NzhJYzY0M3Jla2M0YVZraTBKUWdad0FNMGhtdGgwQkRNK0JMUldxWHRKUEVE?=
 =?utf-8?B?WWhOODRGeTVDbGoxTHdEbHcwbWlyM0xiWWIxeVZpVnZOSjREdTZkM1h0OWZl?=
 =?utf-8?B?VEpZMUdKNU5nUjJVNFM1U1J3M0F0ZWw1U1YwekI2d1VRbkhHSlNSVHJmZnpH?=
 =?utf-8?B?ZkNRa01sMkZZbkxXajgxdWNvVEJjV01OaUtheG8yb0huR3FReTBQMzdzS2l3?=
 =?utf-8?B?dng0NjJrdVJ5RWsrdXVDNnhScFpwb05NU1g3NEV4MUFrL3NRcDhLWk00VHZ2?=
 =?utf-8?B?YVdDK1lTQ0FNTFJXY0R3SHFHaEYwYTlJRVNWUEVlZHpNbWNXTHZXQldkMmZ6?=
 =?utf-8?B?N3lkNUFxQ2FVR21xTnRuRFF3UFpvamF6TEZwV3NKMWxadG5CWm1ENXN4cU94?=
 =?utf-8?B?cmV2eDUzRW9JM1EwMWFJQld6NHFEaWthRXpJSldSSU5vSzBnZjVrUGd5Vi9T?=
 =?utf-8?B?bmJ6a0dTMk8rRG56QzBvYlRrZUhuYUJ6Vnp0dWhZS01UcFBRaG9kOGJsczls?=
 =?utf-8?B?OW1CREl5aFQyQnJCSTNQSTRtME05b0tDQ1dhNWdaVzBMM25UTEtaWFI2YTRL?=
 =?utf-8?B?SHA4bFNCZ0pUZGI4UllxTnpPczFIWVlUaUt5c2VPdURIbjdSMWhTQyt2ZXhW?=
 =?utf-8?B?UDlqMG1rdnBhODhNaG8vc1VtYnc1akVmaEFha0ZjdjFyY1RESHZ2cFlBaXhu?=
 =?utf-8?B?ODZKWE1NeXNHQmdkVlBkcFgwZ3IwVG5rODNmdW83YXFkUGdrWEdrUjFiV0lE?=
 =?utf-8?B?YzZmM01TYzJXRWFmc2d5M3BDeDF3YXRCcFIvdXJ1V0xrK29sbER5WS83V0NN?=
 =?utf-8?B?TjdHTXBXMzcyd3oyaU00ZjkxY2tib3V3T2tVTXFyZFIrMGxYVkIvNXBENDcr?=
 =?utf-8?B?YTBDODlUM3JsenQyWmFFNEVDZG1EMmQrYzJTQ2ZzaEYwczFCZVN5NUswbkpM?=
 =?utf-8?B?cTRjdEF2NmdQNlc1UU5ES2c1MWFLMDlicU9zbEd2UTV6a1g5K1VnbG1KN0pE?=
 =?utf-8?B?R2xQUVpIL25hZEg4M3RzbzFTT202OVJiTFBnUVdDUVcwR3FhYk9IOEJXS0I1?=
 =?utf-8?B?TXpjZXNLczJJWnNqQk5yc2ZIYUhKTWFTVjE4Smd5Zk4zRTUxM3FvR0Z0UnlP?=
 =?utf-8?B?VGpOY214M3UzZmppQnd3V3ZISUdDN3VFOTlPZEpINTdMRWxVajY3ZnVhRXNa?=
 =?utf-8?B?b0hZTzRUREVrWU5aOHEyMTlFVkhEMGVrL2FTYnFTVmRBV3JEVWREM0hSeFl4?=
 =?utf-8?B?Q0RwTHhDc3hvUjFZUEVQODBzeFh5b0pnMmJPL3cvbjdsM0JQWU56ZVRld3hV?=
 =?utf-8?B?dlRhQVVDU214NWdJNFkxaFdCRzhCWUZKQ3l5U3hsRWIyb1dhZUNSd3pHNUdl?=
 =?utf-8?B?aFNCeE1scVZzTlV2a3hLSlUvNkk4Rzc0UUpzY0pCUndscUhZZysxNkF0KzY4?=
 =?utf-8?B?VWg2dnYyTGJKbE5qZlZybnJTR3V1WXMyZWs3WkU5VjFVSXgySFVPRUlwLyt0?=
 =?utf-8?B?YWxvYTVPcC9SL0k0TUo3ZUEzaHBmVnk4bnJDZlNpdUY2eno1ajhpTTRlU1dj?=
 =?utf-8?B?dEw0RUgrUFRvYkJTb2FzVkdLM3kvb0xBYzR1USsrNWFRUTdWcXpzbWNvNmsr?=
 =?utf-8?B?U05DcmdpWWRCQW1nOTl2MjYyMDN5eTB6YTgyWlV5MElMSnEwenkwWXhNTU9H?=
 =?utf-8?B?dWloTUtLWndLQVpIRUs1Q0dydldGLys4NlFsMElITjVGZU5jbTJlNHBQTzIv?=
 =?utf-8?B?WC8yMlZzRjlWYnBvVkQvcXdBUElUcDlWZFMxbVE1NUVhVkVuT3YvYndHWEo4?=
 =?utf-8?B?YW5PQkdNUXZWeEMyeVUyKzhBdGtKaWtwT1RpZ2h1b1FVYldJSy9KclFtN0Zk?=
 =?utf-8?B?TEU4MWtERHRzcXBPWnVPcW1SV3lvVzExeVFXVktYNmJyQmpvOVFydkorYlY1?=
 =?utf-8?B?YlB1YktuSHZrcEgybzJQcVhha241UXNKaXNOSW1JeThTUW5ya1BweFRUdnlm?=
 =?utf-8?Q?ZDRuREG+EnXdJ8PtZIEVYFMCN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30309f9c-c6f9-4659-e00f-08dcef86a8df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:08:01.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nJmGaPZcqObyv7U47sVjAmy+CEDA6BW0odNP5LofJ6FN65bl70AgJ+2gCd1yX83Co+i/HHuPOrX8DZkrKoiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856


On 10/17/24 22:49, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index fb3eef339b34..749aa97683fd 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -22,6 +22,8 @@ int efx_cxl_init(struct efx_nic *efx)
>>   {
>>   #if IS_ENABLED(CONFIG_CXL_BUS)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>>   	u16 dvsec;
>> @@ -64,6 +66,23 @@ int efx_cxl_init(struct efx_nic *efx)
>>   		goto err2;
>>   	}
>>   
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		goto err2;
>> +	}
>> +
>> +	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));
> In some places you use BITS_PER_TYPE(unsigned long) for the size of the capabilities bitmap,
> while in others you use CXL_MAX_CAPS. Right now it isn't an issue since CXL_MAX_CAPS is way
> smaller than the size of an unsigned long, but I seem to remember Jonathan suggesting this
> for future proofing. So, I would suggest setting CXL_MAX_CAPS = BITS_PER_TYPE(unsigned long)
> and using CXL_MAX_CAPS everywhere (or just using CXL_MAX_CAPS as-is). Then, when/if there
> are more capabilities we can just increase what CXL_MAX_CAPS is set to.


The reason for using this BITS_PER_TYPE here is because with 
CXL_MAX_CAPS, as it is defined now, it would not clear those bits not 
covered by the current value. Defining CXL_MAX_CAPS as 32 in the enum 
would solce thais problem. I think that is cleaner than doing any 
masking depending on CXL_MAX_CAPS so I will do so in v5.


Thanks


>> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
>> +	bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
>> +
>> +	if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
>> +		pci_err(pci_dev,
>> +			"CXL device capabilities found(%08lx) not as expected(%08lx)",
>> +			*found, *expected);
>> +		goto err2;
>> +	}
>> +
>>   	efx->cxl = cxl;
>>   #endif
>>   

