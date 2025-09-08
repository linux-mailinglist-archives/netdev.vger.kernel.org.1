Return-Path: <netdev+bounces-220803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F4B48CC9
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A95E04E0668
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C52E9757;
	Mon,  8 Sep 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wUhA2xVH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62C1EE033;
	Mon,  8 Sep 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333019; cv=fail; b=DbJ9KsE4/9fsENdaXSPUbbOMRWoi13+1dnngZ95TOi3al6APnUFNtZOrlGvlq8MHgVEZbg9bumgLDV71sSQJQ22Y93vrqNUoYBW6qvoP68GRDAk/QptARvUko9GTlupy36ogn+glsmNkVisjc3Z2vBjFWIgBXgquDjQpH1M3vxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333019; c=relaxed/simple;
	bh=T2+glqxDs9KkmXl3ZZVFTZsk2AsiJb8Lb/ef//7Nbkg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cyrKdAgU+1n9XGE40cEnviKH19M+EinX06bno5cHn2g/pulsx/AD2PK9/R/gSKWLlfW4V3pH96a1eKKfqTxtcaR5IYN7pZlMIk9T+zr1rtOIZ2alse2IRE94hqakmI2NMOm3Z3MAups1/+a5l1ea7Mk2YiJV7YqM5cetjKwQwRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wUhA2xVH; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuKwo+aUltAAj7oWdhiesXOjDWtWuC+u6tvotp8+Pc4rnQusrI/yqhlJS17fW6jx2ftNSY0ggaHitbeBA89aUk3MVIC1jRUvcs5htHAO7d0eub2QeRyHqlfth/mKfP5NSHfBhi4iXRplzsc2V1Hmk/56cr1EtPA/wVmwDJt2Ic5WkOj3VklESMjZCzjjg8kAMuX1pCA83gkW3Jz4vaQfV/qsrsh81/BXPkdh6LYhKNDyWl617/wHv1ak6PrzgrUbYIcILmJfZtbcGr2A+8MVobd9d4qfyyOEwupEzdSxR6+HEVdVcEKeQ9Aw8GYn9jpsTmxh88JZdOWfyLF1eIOtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYx4gQZ3VUyfhyI9fdl3e1FeVAbRhHjGOKjYlJM/g4U=;
 b=BzlbVYraMpAl+Ig81qkbBYkRHz90O4aUyY2AKW2k4Tkzy3iYy7iV0aSdZWGDAljXInblJnx7QgMRAkBMBvl1F3TyHiDAunaDMmkiLTwPRqhzhj0xcduWs+dBtFJMuzmeMicFQW2JiF2+Y6oa0DRtcud4Qz3pPkcp7yFox6iA/cf6a37THi2QCc4pirsVRcAHeRWz4hBWU/4nitQb8nSeHFj+gFh1/ODPuWk8JmQyvIEa+WlyNOBbKrZvvBUSzyhvKOe2Ny4a/DPtr3zcKJIvRqhgFvwWz/hhK/VQ4SjLC2buKXREK55BQVc6hbRZplNpPWuKyMg29AtwyPWoxeGyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYx4gQZ3VUyfhyI9fdl3e1FeVAbRhHjGOKjYlJM/g4U=;
 b=wUhA2xVHMutxz8O/HMem4pRoRwsaMUvqUk9y1xa3R5EpBbMcnvKMeaw1UtcuTx877tuDHeeYRXQ/F/niNujX088Y4RE0ziH6qqvIGv9CZLzY1WGe8vTRWHG9qSr2fxS4Bao56wFiwsUpfMlKjRBmICAVgkJigpSuKTQVhiRwAe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 12:03:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 12:03:32 +0000
Message-ID: <d01f3420-04b9-45e7-aba0-74a1cfabaa27@amd.com>
Date: Mon, 8 Sep 2025 13:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/22] Type2 device basic support
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
 <e74a66db-6067-4f8d-9fb1-fe4f80357899@amd.com>
 <1aab20e65ba961d786813bb135f9edfc0cb6db0a.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <1aab20e65ba961d786813bb135f9edfc0cb6db0a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0461.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3f1a0c-7002-41c0-27ba-08ddeecfb575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3pNNk1mYVBnOWpRTS80TmQxc3NlWGpVc0ZsNmhSZCtXcDJlc0p4aUJId0xl?=
 =?utf-8?B?K0JSRVZ5T3pmM0xOOXBuUzB4aFRyRXJTV1djWGFGYW1pd3RMOTVNVGgwSHhv?=
 =?utf-8?B?Mmt5ZmNEbzJhRGNhMjBJQWxpRlpmdGd3ZjZyU0NLbXRsSVFXM0l1TTV5bG1X?=
 =?utf-8?B?SDRtb2FCNTZXT0tWOVg5TVdqbDFGR2dFSk8zMkxHc2pKNjNKZng4cExvVDll?=
 =?utf-8?B?M2F0dm1wYkZpTURBRXBkUlc0NXpHRkxRb1gwamx4VGJCU0QzY1k2RklDVlBI?=
 =?utf-8?B?Z0IrcW9lSEloLzhjeEZrTnZrMXZYeXoxNHpoZnBBWVJ2UXNyNFBON21UenZt?=
 =?utf-8?B?ODQxYTdWQ2ZyelAzdlJ5UmFsY2NsTGd6dVRvUVdWNWc3UmtjVVZsM0t2RmZO?=
 =?utf-8?B?SFJPNEorVExnTi91WkNhTDNWdkhralpqclByVU1nVENxejNGYU9ZcWk4QnNa?=
 =?utf-8?B?Z0t0c3lyRjJrc2VzMUxUQmZBVEVpMTNrV0t5eUlCOXR4QjlRZ2JYejl2RlZY?=
 =?utf-8?B?U2F5UHNyVGdVbWdrbHZiNitCYVI5ZTVtOS9Ldmc2QjB2QWJhendDR2o2ZFBh?=
 =?utf-8?B?WDBXOGVzdzRIZ0wwcEI0UC9hdHRxMDJQVEhlZ1lmRE1UNnhwUnYrbHlBaFZ5?=
 =?utf-8?B?OUZPdTB2SHFLTFQyNjJVT2RscmNtbGJCb1ptdDh3MDh5VTQ4TzdIRE9FSkZX?=
 =?utf-8?B?QUUrMzBKT2wwc055VDBLOTVJc3ZnYXI3cW1mbVhnaUNrNkM1L2VwS3ZzdWRW?=
 =?utf-8?B?TUhFQ2JEQUxwTGpVYWpWdVF5bDBtZUNyQlJSL2RwU09VVTdBRkpkYVdnZ1la?=
 =?utf-8?B?RG82VXp1WVI1ODlmZlU2MWMyNE1vbzR1UkVZeWttOFkxN0JOSTF0V1B0dkhE?=
 =?utf-8?B?aENyVU9rZDJtN1BSYjBUczgrajFRaEh0b0FxR1pjUmNtRlBnK3d3RXN3Vmo0?=
 =?utf-8?B?TFlBNkcwb1ZKenBtSE1aSVBTY21CL01lRjlzRElRUmZxYndNUHRWaHNZL1pD?=
 =?utf-8?B?M2NKdjBGbFI1S0ZLaUY3Uk5OYnFYTnptZjJoOGV2R3Z3dnFxa0ZGWEhyRC9n?=
 =?utf-8?B?K2JMbzR5R0xHL01ZRnNsRkF3QmpSRXg0UGpveGExTzZnT0o4ak9rUjlIOHNO?=
 =?utf-8?B?VTVESFBEV1NiUmNwVWUxdWcxc3dNd0dwVE96cGljYVhvaFRUdG54MVh0Mi85?=
 =?utf-8?B?dHVZV2lYQlZQTU5PNk5BOEowOG9Yakd4dnQrZ3VaSGF0VUh5dFBQSXVsdEZI?=
 =?utf-8?B?WUpyVSt1ZTBrRjAwQit1aDRNYXpvUStyVExVR2FCY2JEaTJwL2k1aUdMQ0tl?=
 =?utf-8?B?UWdYNzVkUlVpaVJWSnhPNFJZVExFMm5CRWxSUTFPejlJb093NFZkQWYxUWdy?=
 =?utf-8?B?STA4aXF3QmNETjY1aFc0bFlFSjJ3Y0pvNnJ6QkVSNVJWZnBrZzlFN0VSRzcx?=
 =?utf-8?B?cUI3akwxTHV4bkF5T3UrbjlyZXlKY2VFc0s2WVRQVXJNWlBjY3NTa21mOHo4?=
 =?utf-8?B?Y216Q3VnejVha0w5c1RaVU1mZis1eVVtZGwxSlVzdlhZalZ4Q0lqak4reWJZ?=
 =?utf-8?B?OFFMbUZSNDZZUWlTbG5sdjYzTFoxamJCRzh4TUMwWFpOVU9LTFR0ak1oVHpw?=
 =?utf-8?B?R3RpU0ZiZ2xObGFscGFHWWszQ0ppWGFUQ0pwRjRHRVBqT0ltcTRLKzBkNS84?=
 =?utf-8?B?dTF5b2tvbFZmOFBEUlF1VFJZN2JhTFBnNDYwblRZOUhseFpBbElyWXpyYjVR?=
 =?utf-8?B?OXhuaXdXY3R0STNub0xZT2JRemkwY0JPK2tCT3h6R0MwUFJneDJadkxKeHpu?=
 =?utf-8?B?SmZiUVA3bUNMMXlocnc5RzQwRUdwbUVVZCs5bnlKdk9rZEoyZmxUbG9qV09U?=
 =?utf-8?B?Zmw2dTVTVm1GcFczemtnRjNFVVhJQ09lYS9VdDhJT1E0OWlFNVpXSjB2NjFN?=
 =?utf-8?B?c2VGTkQ5cGdFcXBRT2dhL2J4TWl6eDk3dUloemQ2WS80dUlOZWRyUU9mYmFO?=
 =?utf-8?B?cE9hME1kTnpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9LazFtSUN1VU5MaEZGZmtRdHZMeCtIZk9UOVdxUU1xa3o0VURVVjQvc3c4?=
 =?utf-8?B?R043c0pEY245MEczZDhOWkxUMkh5Qlp4bWdPdXZGTEoySVo3VHdoNVJLWU01?=
 =?utf-8?B?cVkxVld0bS9sK3p5Z21ENDJ1MW94K3lDbE5WMm82MkJRUnhEbVJvK0VzMU1X?=
 =?utf-8?B?dlFZcnc1T3N3ZFFFeEtVNkJhTlczOHBFTStuRUFFUVJ1OEJxR3UyeVEzTSs3?=
 =?utf-8?B?ZEZXN1FFb21qZG5Oa0Y1OW1PelJRRmw0cXB6RGJyb0pPUzVhSU5tSmNmdW02?=
 =?utf-8?B?SnNiRmQxYTFFc0JFaEhieGh0ME9WOHF6djZKMW1VL3pWZ2VVY2lIQXR2OXZs?=
 =?utf-8?B?UUVPU0hNVlRkSTJMdDVxbXR1aFdaVzJ0azJ0RUFtTnhmK0NsWjRkNmVjTlNC?=
 =?utf-8?B?SUpZbUZhZittL29va0ZaUEVSUWdCMXlLVEFWZ2lPRHFDRS9MN1ZWOE55dXds?=
 =?utf-8?B?dFFkc2pKbmU5ZEpWb29kL0IyanRTdFdwL1VZM2VEV3V2dldJYnRMckYyRVNR?=
 =?utf-8?B?NGdKc09saEp6UkRkZ25yS1U5SmpWTElYa0RIYjVkTEc4ek01RFpxRjAyNEdQ?=
 =?utf-8?B?QmZBSVZXS3NYOE1yb053RFJyZHRyNVlIMnJuRmxIS0hKNTNHQXdqNWVDQmRR?=
 =?utf-8?B?S0Z4S2ovTzhaelJpUXhKT054YXpJMXd2S1NvZlZFTmlRSU55QW9VczNPMHFJ?=
 =?utf-8?B?QmtxT3E0ZHB0NWhFZ2w3QlRNc3RLaGNOSWtaY05iY2EwN0FGRStpZXRpaXJT?=
 =?utf-8?B?SS9XNG54QUhCaEVIaUJoRUU1dHE2cVVreWFkRktSeldtSzFsNGNUQ2ZiVCtK?=
 =?utf-8?B?R01TRVJTOUNrdkJHK2tYcTFnRm1OVmhtMVQxQ1dEOXRuMXJ2V21NTEVyRTRM?=
 =?utf-8?B?ZlZXWER4RUViSCsySGRydlRoTGJqc0t4Z1FVc21oRkU3MDZsZ0pCeCtxS1lY?=
 =?utf-8?B?UUxqdzQ4U3hYVDFoYWhNR3d6TFRWaExlcEtyQXc0V0FUQ1lBMnYyV0dDN2dq?=
 =?utf-8?B?aVBkTXZKY3p4V0g1VlNWY0hSMkloRXJvQlR4b3BJOFltOVp5K1JJbVlzZVZy?=
 =?utf-8?B?b3QycmxCSytzUWRWL0R3Y2UrNUV5cGtTRmRUUHJPWHJVcFVZd0dqRWR0VUlt?=
 =?utf-8?B?RTI4VHB3NnVPVFZJNjVMNHNQOTl0b21RQXlaeWcvQ0xMR0F1Y3dpNmhCVk9l?=
 =?utf-8?B?VzlibDZCZ1hHc000TmlpT2dPRExkd1RlVmNxREd2R3VsV0xQdTNGeFNBOHFU?=
 =?utf-8?B?YmhWaGsrZUtPZkZZTWJZdVA4b1dpRE1WSFBrRWl6UUplbi9GTWZ6SnNLMFVD?=
 =?utf-8?B?U0tieUR1YW5XcCswd0d4OVpRY2psRmtjZHNyVGJxQXNIS0FDWGwraklHb3h0?=
 =?utf-8?B?YjIzcEY3OGh1bGZsbGFuUGwwK1g2RHQwcEk0UWIzT3UrZjVJdjJZSnRnLzdX?=
 =?utf-8?B?NjYybkUzem9sZkJpWG1CM05POHhHeGw5TGpyWTRBSS85WVpYaEs1dlhKRlFY?=
 =?utf-8?B?V0s2R2dvL2k3RUxyaUVoeWFXUjk5b3hlRWdSNk9ldnF1N25rMWFpVkdXaldk?=
 =?utf-8?B?YUhPQkszb25sT1JGTExtZGVieFFadU03OHlZREpYNjhnazNraGJFMmdnbmlU?=
 =?utf-8?B?M3pZY2ZiVXIwMldoM2pxVnRMRGpDTWVuMXBMVkRMWnVCTHlacURINUg1Zk1r?=
 =?utf-8?B?TFJpcit2WG43LzFoU0JZbkljY3E2V2x6VG02NVRxa0F5d3pzR1ZKNExPbTJW?=
 =?utf-8?B?TktiVFlnRnhxMkg0T3RKUGdHSUI1bWFLUTEzU1FOZ0RrYXllZytNMzVxVFpt?=
 =?utf-8?B?anl0OFJlRVF0aEE1a0VVemRUSmp4WXNzN1BEZDlJOE45MG9Sc015dnM4elVt?=
 =?utf-8?B?MDMyVkhSRkNMcmNqVFpnbi9wSS9XQ0xmVnZ3WjVoY1d0L2h5SklOQ3JqZ1Ju?=
 =?utf-8?B?c0tIdjdrZi9FajBQaS9XWGZTN0Z3SzVIdGhtYm4zckdYK3VmbTJUN1U2ckVG?=
 =?utf-8?B?YUlpdS9pUVIrUVdrZlBGVFZ5N1lIZTBFUlBUYW5HRHgwbVBVMmlDcjlUdmRF?=
 =?utf-8?B?QXZYUngwczRncXRjWTdnUGx2TmJpNWR5SVpqMWRnYVJjSUFMdjRaZ2xtdmEv?=
 =?utf-8?Q?gCzk5PtTky2DKI+yocOXYO6I/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3f1a0c-7002-41c0-27ba-08ddeecfb575
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:03:32.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEfEFhuyFrD7LP/HH5FCXuIBnushRwEDkwTkrFzVGT5s3Gu1JJ0LeFCvgk8XbN7MjOV/ie7lMnaKlVLBchEyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665


On 9/6/25 00:23, PJ Waskiewicz wrote:
> Hi Alejandro,
>
> On Thu, 2025-08-28 at 09:02 +0100, Alejandro Lucero Palau wrote:
>> Hi PJ,
>>
>> On 8/27/25 17:48, PJ Waskiewicz wrote:
>>> On Tue, 2025-06-24 at 15:13 +0100, alejandro.lucero-palau@amd.com
>>> wrote:
>>>
>>> Hi Alejandro,
>>>
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> v17 changes: (Dan Williams review)
>>>>    - use devm for cxl_dev_state allocation
>>>>    - using current cxl struct for checking capability registers
>>>> found
>>>> by
>>>>      the driver.
>>>>    - simplify dpa initialization without a mailbox not supporting
>>>> pmem
>>>>    - add cxl_acquire_endpoint for protection during initialization
>>>>    - add callback/action to cxl_create_region for a driver
>>>> notified
>>>> about cxl
>>>>      core kernel modules removal.
>>>>    - add sfc function to disable CXL-based PIO buffers if such a
>>>> callback
>>>>      is invoked.
>>>>    - Always manage a Type2 created region as private not allowing
>>>> DAX.
>>>>
>>> I've been following the patches here since your initial RFC.  What
>>> platform are you testing these on out of curiosity?
> A bit more info for the weekend to digest.
>
> On my AMD Purico CRB, it looks like I may be missing pieces of the ACPI
> tables in the BIOS.  I'm going to shift to a GNR that is pretty healthy
> and keep hacking away.  But this is what I'm seeing now that I ported
> everything over to these V17 patches.
>
> - devm_cxl_dev_state_create() - succeeds
>
> - cxl_pci_set_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxl-
>> cxlds.reg_map): this is where things go wrong.  I get -ENODEV
> returned.  I'm digging into the BIOS settings, but this is the same
> place I landed on with the V16 patches.  The device is fully trained on
> all protocols.


It looks like the expected CXL device registers are not found by the 
kernel.


Note the sfc driver knows what is there, so looking for an HDM decoder 
in our case. If you do not have it, and not RAS capability either, then 
do not call it.



> Hope this rings a bell where to look.
>
> Cheers,
> -PJ

