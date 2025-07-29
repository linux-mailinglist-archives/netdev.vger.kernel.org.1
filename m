Return-Path: <netdev+bounces-210763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26723B14B73
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079981AA46CD
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0FE2882CF;
	Tue, 29 Jul 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BraoWCT2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7C204C0C;
	Tue, 29 Jul 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781914; cv=fail; b=SczrogoRfVbnJ4U1fn4DstIjuP89GFMWNNdMxfht8lDbTNXs4VKvdwr/iJm5ptSNOcv9NReZSUkQ7ntC56XvCajzl2wOqbIdi02iza4qqRFezS6yrHHGpLWsevrtaxQ+gsmJu44Y816H+gVqtxBL4p+Vs2Ya8x8BwN18ygdgens=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781914; c=relaxed/simple;
	bh=JkrV01Kkv4sAb2lTO0+4FVYs1j6+w0n6u7wArdKRbHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WD34Ob2Q+p/7Hdr8L9WGZy6SVR1+JIk6MXPD/ydcHZSiv2suOCFx9fFjcmmvreLq++kArm4YlIb4HNjErGEaFp49ZvRyk9CGWjQqBKgYk7YO62QIPsm//t6hqbJ4j6caOaQRAyQj7M32pJQro+/aSGgjTdRvVUUf5xt+Wx/wpD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BraoWCT2; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvThiqsbB4UUsZ0DrpjMFkT6WPF+xhxxOmCxzOhtrdZxK3xlgUDK26P4PkaleIvvSplT+ycUvdBtQV7qSuexCloQ7czfSBK67TDucsuUe0fMZ0o0XugtGXgrLItQ18MTMFV/QHRWGysMjenTsnMj65r13Pm9MCqKOuAWjksJa0zE7Uf5iT5TY387CQk0K/0vJtSaYhy+f3/m/9TocRwjVYfjp5LEftfIAxGPuTqlm/meXf5u6NuhzjqhHRDVz/Wujb/tlFazU8eKqeaKmRcM3bwHO8S6ztGbCbvY+MtvKmfqReW5fl074hLDFJW64wBSvsVgJvFL6nm3JOiyNONZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it5XUuOAkWFRd+DuWV9/onWz4KgWjMfY/6z2x9DI2es=;
 b=GX7PRH6ZNWm3c+aELY0hEuydMYWe/HoiTjETcZBWeB4jgRcpoHyWt6e9+AbGZn/TmslBStS9f8Iezcz8mr5VTAgWoyRscEkcVCkl308+bR+IgqUuIcCsNix8EJbOYtRirZa1kI4Bc+2b6nZnBuKBU+TopwS1sR/CUnZbW8+4GjjsEZzuZGJiKs7J70zHiHLcjkd9Ry952sREQrmMRrVotz/F46l8UXSVYNJWdAY9HBJJhzxryRAFiWKHbMB0yjbZW8JsptXfqrzhtniEr1D0eigVaOezMq89NFiaxeSSgZWYiA0co0GF7N4Zogg3vcN4q0wj77AU0RUk4DutLyA/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it5XUuOAkWFRd+DuWV9/onWz4KgWjMfY/6z2x9DI2es=;
 b=BraoWCT2YGlRkSPJzon5ZGtrC377KLDheN9pzIM6eHrjGg7AE0H1r6ql7fuyEWYVrqD5QzOlYDy4QIK8rGuust2v2wWozPUh5+eftxOdcHODEhrWZE2iIajWVJ1MGEgwucy5hlzb4LFAMMgXrEo3rroRVqlFR7JTX2r3YGv3mOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 09:38:29 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::3e0f:111:5294:e5bf%4]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 09:38:29 +0000
Message-ID: <c810ec30-51fc-427b-b6f5-15c3284c0ef7@amd.com>
Date: Tue, 29 Jul 2025 15:08:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload
 command interface
To: claudiu.beznea@tuxon.dev, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
 <8c34af6e-9cd0-4a2a-b49a-823be099df55@tuxon.dev>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <8c34af6e-9cd0-4a2a-b49a-823be099df55@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::17) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 097a34bf-981b-4c56-b53c-08ddce83acfa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENrTFRaTm4wZUNsSGdGYWY4akZTaE1GU29wcG9CdlpCOXByaVZVN0lBYjRi?=
 =?utf-8?B?dTFpWGlQK0FDRzFpbnMwVlZkZzRkbGlGTEgvb2hiWDJLeXpZbklNd2tCbzlH?=
 =?utf-8?B?ZkQrYU5ubE5uckVrZ1ZrQU1RVmFkdVlMWC90cTRQQWcyTXRLSldIQTVPbCtQ?=
 =?utf-8?B?ai9XYnB1NksrRXJZRHRTZjVFZVprZUlwL0VBTXdzalZxVTN4RG5hYkc1VG5a?=
 =?utf-8?B?dEJyYWh0Y0dDNUlWWG5td0FtUnkyeUU3dGdhRmwrMXF5ZXl2NEZ4c1NSUy9W?=
 =?utf-8?B?ZWtRWXdLWjJ5Ny9qTzBQazFMU3IxanNnMy8zT1h3RVRJYjRjVVQvVDBGV1dn?=
 =?utf-8?B?emY2cEJjMUxhcnNTMmRWem9ZcVdHL29tUGdWemNRclFNaXZHdHJmWUdnYktk?=
 =?utf-8?B?RkMrMU55bktZK2NFMURiWkw4V1J0UDVpYThmY3FpSXI4Yko1eDI0ekJBUkpO?=
 =?utf-8?B?NXJpNkJoVmpLbjhSZ2xvZ3ZxMTRuUFJpKy9mdkNaNGlweDB3UVJzODlOVG9Z?=
 =?utf-8?B?bGdQblc3LzAxUDJZY0hNdzJsS1VxYytvTXlsc1NhWWF0Ly80R09wVlhpT3ZF?=
 =?utf-8?B?QWR0RkEzS0RTa0VVNkxyV1puREthd1k4djNHays5VHVYK2pQRG5CNk9CdEVM?=
 =?utf-8?B?SzgrYmg3SWpWdlVrT0N3ck1BZUVySlNpUW1pVzluVThsQjFYbURaN3VqOHB6?=
 =?utf-8?B?QmpFZXRGUzVvZExGNWlWeFpmMVI3Q3NaNXhtTmJ0UU44S09TR0c5WUozdFZl?=
 =?utf-8?B?SUtadXVRckxraDBWVDVwOTdDaWo0b2oxTmtaTlZOKy92NlBha2k0TGlPZ1Q2?=
 =?utf-8?B?N2pFNm0xN0JJZUdFWmlPSWtEZ2EwN1YwY3dUMFp3blhFSVYzSjhkVDUrVTg4?=
 =?utf-8?B?WTVwV3B3bFZYWGxxb2o1TVhYbEZha0Vsc0xraHdoMFV4WDhXQ2tPS211Mmlu?=
 =?utf-8?B?L1dSRDFtd0RPd2Q3dkI1NVczV05WdGdZanFMME5RbnM0U1M2VWNvRGlPM0Ft?=
 =?utf-8?B?b2U3ODducFYzUGZaa2NkdXc5RFpyT3gzNEYvYzVmL2tLK0E5WDFlQm0rZ1U1?=
 =?utf-8?B?U2JPakRXeCtHNnE1ckxjSmJIdTVkKy9WeE9HN1Ntd3ZMM1RYam1qT1g3SHdq?=
 =?utf-8?B?a3M4VGgvbzZGR1UwY0N0RUU2Q21uQklSUmhCSDNJT05HVDRrZEdWQmtJdnZP?=
 =?utf-8?B?QmJYam8zcXkvZThvUWJBOVljTkx1cGt0S3dmNVJJdmUxTEF4Q3RFZDV5MFlC?=
 =?utf-8?B?SWIvTkhnNUEwcGs0ZlVzNFEvVXU2SndrWDZlbmV5eDFnU21CQ25DeXh5MzJm?=
 =?utf-8?B?N3k4dlpVRWFVVWZWOUhkSEZCZWFMdnVUYUpXWXYzWXhUb3BNd1g4b2V0YmxR?=
 =?utf-8?B?T3JqSm0xczZzYWpIa2pCMjRXT0t6UVhxQXgxVC84czJWZXlZT2J1S3F1Uzh0?=
 =?utf-8?B?S3MwejFrbUdNK0lrdEF1UFRyL2JYaDRRellwMWpteEVTR040ZHZDVldNcTBE?=
 =?utf-8?B?VDl4T3Y3YVFVeVZCeTE1UmlqMTAxOHVIclI2TlBaSFRDMHcvcy9XYXFTMFYw?=
 =?utf-8?B?dExWOXBBMHQ1bkpMQ3BmZ3l4SDE2amhUN1IwdkxLTS93UEpQZ2RZL2VDMlpI?=
 =?utf-8?B?d01uL2pHOTFUZVVMS0o5VG9GTXpxRlc0Nm1DOWVQQjZNTmFFeUFzbG9FYks0?=
 =?utf-8?B?Y0lqUzdLa3VkdDRwQTRxUmNsWVlQY1lUeHVRSjR4QWM1M2pFVlQzeFJuTnJ2?=
 =?utf-8?B?NzgxZnF5UTE4SGM3WkpYZXoydXdsK3FMejFFK2NKSGlOZGRGMXZCMFVKRDJn?=
 =?utf-8?B?ZjlXMjhUVHF2dER2U1FYR1RNQ0ZLRVd2eHcybmpCMXU0UlZkSjN0ZXU3NmZt?=
 =?utf-8?B?WHlDbzdOUUFRMGpMNEwxUVI1MHRrM3BnZWxvYWgzYm5PNGxWa2tHR2FvbTVt?=
 =?utf-8?Q?qYgHF9ymPDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QndRSXlrc1Fsa1c5SkFZL1I5T3hEV3RRRFFMRE1HZnBEMVZaQ0pEVFN6WFhZ?=
 =?utf-8?B?K203QmhtTGZObm1aeDBhekw5a2VUVFo0alpxakdYV0VCVDdSTFRpSkZEbGU1?=
 =?utf-8?B?R1ZZRVlvVXhEY05BaFJINXB1Tit5cUJlaE56WjJ4OU96S3QrL3g2czYrSVFZ?=
 =?utf-8?B?Smk3Sk5Telh5YnhYam03VUxSaStqdTArYzdtMFdsMVA1andmMTFpcnBkMzF3?=
 =?utf-8?B?SmVUSHBXWVYwZm5jL0c0ZW9ENUdCNVFscW9VYUcxRXdlU0orRVl3Mzc5T014?=
 =?utf-8?B?WnVVMEkrNHo5c3ZwSFA4Y3p3MlJ2Ny91Smt6eDBlTm41eUZEWjE4dkZHeTlh?=
 =?utf-8?B?Q0dybElrTHV4dG5BdE45ckV0aEZLVXVDcHpqNHY2T2dRR1AvNGdkUzV2SjFj?=
 =?utf-8?B?bmM2TjNGZUhvYUdWejUxZExsWWMzakRUeHB6WkJLaCtHTjNQVjhENVJBYjdy?=
 =?utf-8?B?MFlGbUdweEFjVlJCMUFjNm1EcXlRUy9XdHVSZkpPT0dOb3k1Q1RMSnh0bTRR?=
 =?utf-8?B?bFZYa0xicGEwMVFFa3hOaFB0QnI0eDdIV0hTN1dpK3h0OHJCdnZHem8zVDcx?=
 =?utf-8?B?SWhKZCs2WW1tK2J5Q0tVbmFyYXh0UVhuWjZaaFBOT0RuV05CcFAvb0p3Wkpq?=
 =?utf-8?B?TGVSNFZJYXRaTEpicEJINjZkVGNKK3VJTk00RlJKRzBaKzFoTUliNXJOL2FQ?=
 =?utf-8?B?K0swYXI1UFJSTVJHU0NJUC9uVUNYZDd3ejd2Zy9FRXkzTDlwREVUQ09FV3VZ?=
 =?utf-8?B?MkJ3cHpSRnczd1h6a3RKdnNLRkowY210M2FyRFdqTmxnbndLQ3ZKeXlWdkVq?=
 =?utf-8?B?VmFRQy84VlpMMnJqMU9FZFR6akZHdU9OSWtXQmpoR0NKcW9ZK3NSVTJQOWs5?=
 =?utf-8?B?dFRtQ21DaHFpQ0Y1T09zaGFFYklyRmk4K0xXOTl2Y1JRRmlCaENobHpaOVVW?=
 =?utf-8?B?UUtkZVBCUnVWYkVKM1Zva25XRVJHUEx4ditOVmw0RzZERXRsdEZzZURFOGtn?=
 =?utf-8?B?NWRuQmNnbmwvSWJiVWF0dWpacmdwTnE0YlZoRmRlemRqclIzM0hPZGF1dmV2?=
 =?utf-8?B?TGMzVndoWjJmWFFGY2xNTXpJZnpLVE5oMlpvNnJ6ZFQ3b1BkWlJsYTJPU3F6?=
 =?utf-8?B?Zk1xREJtSjhUMDBKYzJ3THI1bHYvZ1BqWGRoK0w5TlZlN3c2SUZSL1dkdVJN?=
 =?utf-8?B?VnZoNTJkZllpOVhqVTkyckJubU11YzBpa3p0RW43UHZ3TS9TKzY4V3VrdHFm?=
 =?utf-8?B?OTh3VFlnWDcxNGUzMVhzNUVXYkQ2ZWsyU3MrekFrdk1zQXFoYjI1ZXpkRUQw?=
 =?utf-8?B?Y1dNWm0wV2NYVUxmamZSK3orSGR6VFVwTDhyM01Kcm9BUEhBdVA4TjVxSGEy?=
 =?utf-8?B?bFZMZVNWeDM0WTQyVUVCZ1JWZjBNa0d4SlVkY0k1V1F4TWZIdUhuRjhRUHlU?=
 =?utf-8?B?dmNDTXhzdGlPT1RsaUt5WVhJblZxU3V0eHBpZzRkN3VHeE1GM1pXL0hseklm?=
 =?utf-8?B?Uk5ad2dicUgraUErT2RpN0wyM0tseVMreVpSNW10YldxWG0vZUtDZnVCckJM?=
 =?utf-8?B?UFVPVTQ2Sys1bTJTZ296bGI1QWpWTndNN2E5d3dzc1ltT1lhUk5PV1pPVWIz?=
 =?utf-8?B?SkwyNXFFUERhdGQydUFMU0NhSmwza1B4NkM1VGtEbDJjTmdmZVRLbFViMlNX?=
 =?utf-8?B?ekRLblFaeW1LMC9CZis4T3B1OHdYMXVnVEN0TGx6dmYyd2szWVFGL1I2V3Z0?=
 =?utf-8?B?UXF5bnplSmJUcFRxaHVYdHZ0U0UzTVFtL0ZPdjZpVjZwdDdlekRWU05rTDdD?=
 =?utf-8?B?cmRUZ1ZDVjR2elZhUTU1MExEWTdVeWZYbVg5dUtHbHNCbXlFdy9xRVc1MThQ?=
 =?utf-8?B?bnAzYnRhbzhrNk9HZWZNWlN4dnlkSXBWWWlhaEFLbjAyRW90Q0pIUUM5MmFG?=
 =?utf-8?B?bFNlRm5MK3hOaWdwaXExazc3cEwxbXRWVTZZcXRBbE1zZlhkR2tnejJ5Vi9j?=
 =?utf-8?B?dmx0MGphdFg5Q3hlcWkyVWlVZTl3YWpOS0tPOUxDTjNHaGhRWUpVRnZjRElU?=
 =?utf-8?B?L0xFRzZvZlpDRFpPNkVOc3U3V2pmSlJ3LzErNGJNak5FbUUyd1FZL05iSTZQ?=
 =?utf-8?Q?4JTsehhjBiIuCwCCzFx2eu/Om?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a34bf-981b-4c56-b53c-08ddce83acfa
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 09:38:29.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MyZV3HakYqRNZfPqVQV6IsOCOhxPtSg72s6Z9GtsHSth9784pSqi3L0CJdxMCC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

Hi Claudiu,


On 7/26/2025 5:59 PM, claudiu beznea (tuxon) wrote:
<...>
>> +    int err = 0;
>> +
>> +    switch (taprio->cmd) {
>> +    case TAPRIO_CMD_REPLACE:
>> +        err = macb_taprio_setup_replace(ndev, taprio);
>> +        break;
>> +    case TAPRIO_CMD_DESTROY:
>> +        macb_taprio_destroy(ndev);
> 
> macb_taprio_setup_replace() along with macb_taprio_destroy() touch HW 
> registers. Could macb_setup_taprio() be called when the interface is 
> runtime suspended?
> 
> 

Nice catch!

I will leverage pm_runtime_suspended(&pdev->dev) check before configuring.

>> +        break;
>> +    default:
>> +        err = -EOPNOTSUPP;
>> +    }
>> +
>> +    return err;
>> +}
>> +
>> +static int macb_setup_tc(struct net_device *dev, enum tc_setup_type 
>> type, void *type_data)
>> +{
>> +    if (!dev || !type_data)
>> +        return -EINVAL;
>> +
>> +    switch (type) {
>> +    case TC_SETUP_QDISC_TAPRIO:
>> +        return macb_setup_taprio(dev, type_data);
> 
> Same here.
> 
>> +    default:
>> +        return -EOPNOTSUPP;
>> +    }
>> +}
>> +
>>   static const struct net_device_ops macb_netdev_ops = {
>>       .ndo_open        = macb_open,
>>       .ndo_stop        = macb_close,
>> @@ -4284,6 +4316,7 @@ static const struct net_device_ops 
>> macb_netdev_ops = {
>>       .ndo_features_check    = macb_features_check,
>>       .ndo_hwtstamp_set    = macb_hwtstamp_set,
>>       .ndo_hwtstamp_get    = macb_hwtstamp_get,
>> +    .ndo_setup_tc        = macb_setup_tc,
> 
> This patch (or parts of it) should be merged with the previous ones. 
> Otherwise you introduce patches with code that is unused.
> 

Clubbing all comments on patch organization:
I see that patch series gets merged into 2 set only.

1/6 + 2/6 + 3/6 + 4/6 + 5/6 ==> 1/2
6/6 ==> 2/2

Please let me know your thoughts or suggestions.


Thanks
-- 
🙏 vineeth


