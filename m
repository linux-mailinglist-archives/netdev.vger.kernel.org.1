Return-Path: <netdev+bounces-208454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B29B0B7A6
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD01A3A5E2D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC322256C;
	Sun, 20 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xVlT/UtP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B528E3F;
	Sun, 20 Jul 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036142; cv=fail; b=QUkNAfv5Mbmev7F7RIWiPvVxuZVzpNiyXgT2hk6FIP9eF5KAWQJPWiaaP/CBdXEizvkeevZncitjFL27VialpDRvshDIfatSuk1hoNCeii8cm0YdcrD7F70l42Zb7RtkaZoQV8yn0jdL5CjVnf4k4brPrr0SvC/MeNsYBQlna5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036142; c=relaxed/simple;
	bh=EMivBwjuoq2aZ7E2e0Ms5Xo2lY+qGypssACD/Dm6wck=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bAZVgYNLg7K3O1l5OKVZw+TDqA54b2nnGooCmgNfeZ04UzJ6YUHMUWHJWbby1tpMjU/qe9fxrfDkIvAnJ4HFVE6ZOOv5mehKHpEDmLep0w4Sjmk7qWtbcdWPOz+HuZuacUXXrxXH6qOflPSTVXjr4YLnacMA7Ba/QUT5sKvevP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xVlT/UtP; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1aJd4B3OYdzH4qzescWclOpoz2gCv0NcW1CmOGhRNDKXp+SP9NswQy44Y+8CaU6xDQ51GtpruvMLoDWc6mV5nkO08+x6fT1HCXviZKLt7u/WaMHlIx4Q54Uxi08vW94G++ErI81dGT95x1q7z2hUi7R543gbcmHvRpixyXEOidFOt9HJS9hX41cANxVgYH9/6+TEMWPrNHwGaNWMErXFjnYQISG9iO+zAgNoLEJsll2I61CM+Drh3WcYDxuNiRFl2CtTJFH9ia0dF1lMDFM2YE5DLsOiQe/KlJUMQ86aUhPpE4fLfcpb8g6x4EoX5RdsFb/KjN/6Pp+A69Bc4anHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARMcMs7O4+rF5kIJdFg1fPCzIk9ZkZAZwE5Erto9UE0=;
 b=a3Et4Hs29Hmr+5sSod2YRPCR9ySALYNTO6q+/sA3gRlEsIKci8XsQHj4dgP41OjJqw2j0DkGdXRwTSR4/cRtDDERqNVDNq6no7y5PiaqOiozk4TelKhR0Svwr6/AO16z9UIRR9wjf59Q86X9f3HZySL4wNZSJ4LGRpZ8bauP7SL5jB6Vu46/WMb0cljjqkJN1JQJYBJA3J0V4g2Aw7hMLltrkpfl5BAV/3ZNz/bPgWPhQJMU3YUvZfhebt/Km25mfdw/fV8w1EvRoRgDxxddTRWQiuF9BbAuJh354B/hwrtKaDMla+RGmAm+Fdoo6y4ghLvgrvOfK/E4vmVJVqBYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARMcMs7O4+rF5kIJdFg1fPCzIk9ZkZAZwE5Erto9UE0=;
 b=xVlT/UtPNjOa9Q2mD2BQG6VuzhOIUh+XrEibGi81/5i9DRsSV1D/zMTuEyADZn7IsHn3uD2WhAyBFs7BeK8u/XVvV0tk6Jw3sZ9mFPoEUzxlcUvRGWXtEaDCg0rySElgxDztA2IMOkDM5N37qt5eGwTPX5POLAQXrUrVJ6Y/fcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Sun, 20 Jul
 2025 18:28:57 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8922.037; Sun, 20 Jul 2025
 18:28:56 +0000
Message-ID: <e2ee64c4-4923-4691-bcfd-df9222f2c30b@amd.com>
Date: Sun, 20 Jul 2025 23:58:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
 <509add4e-5dff-4f30-b96b-488919fedb77@linux.dev>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <509add4e-5dff-4f30-b96b-488919fedb77@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::10) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 940bce73-f5b9-41b2-aa80-08ddc7bb4985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVWTHlmN25FTzdVNDluV3UxeW5YQTRxRWNWbTV5cmpmbFJZbGlObWE4c25G?=
 =?utf-8?B?YXVSQ2xMMWlyYTI5ZnZoelJVbzR0WjU3Si8zUHNoNmRlM01ndzJDeG9vNWFw?=
 =?utf-8?B?QjBoMzZLbXRndkx4VmpCNEwwVmZHckJkVE9NejB6Z2Q3R0p3T0Yzb2NiZGpp?=
 =?utf-8?B?ZSs3cjVXYUdqV0l5YmcwU1h1VHExbGRtUWdOa2VOSzRJWmVkK0dZSGlEWDU1?=
 =?utf-8?B?WkswY0NHTVJPcVAzZlpicnA1NEtwYWpHbFJCa200NnFscG43ZnNZYjdQREpQ?=
 =?utf-8?B?bDJNVyt5VnU5K1dMbExmQUpLVTJDYURDemFHOHloaUZaYWV5ZHpmcks0U3Z5?=
 =?utf-8?B?RjYybEtrZzhFUW1RMFVSdUpLa2loTmlsN0h1UnJseU82bUlTTElSbnZWT3dz?=
 =?utf-8?B?bnUyRzk5YmNyRWk0YUkzOGRzWTVTZWRtRzhya3d4cDFvQWlwcTdxd0dSNTBl?=
 =?utf-8?B?aTc0aGlmdERKQVppRlZwSHhWOXJQa0EzU1BZMGxzT0d2dTFTQlNXU2JtV0dl?=
 =?utf-8?B?QlZFVnZaZUJVNVVGRFQ2Ukg5VUtFWjhnSDRUWldIUndPWWhTd05QbDZoeXdG?=
 =?utf-8?B?RFJseWZxL1ordFhNanpaSUpuL2dNc2I4Z3NENTIwSnl1dVdOdTVmOVRhQTh1?=
 =?utf-8?B?NVc1cUpJc1hFVlNCWFRoTWtVdm5CNXhjY1J4RE04eFFPM2QwUExjbTdtWUFK?=
 =?utf-8?B?dzJ4M3ZOTUd0SUhldUhkVEQzMUQ5TXA0TUFxNmx6N0RVRDZDT2hPclp5d1NZ?=
 =?utf-8?B?bkZLb0JWSHdab1JaeHNXVVFLOTZkNjVJVGRENjIzVFREanh3ZHVxWnBZRnRw?=
 =?utf-8?B?aEFSeGYwUSsrRHY0eUQzM2lZNHVuZFFnOUpkVDkzVWlacExjRForbTBVVU1N?=
 =?utf-8?B?bnhrbUFFeEpXTTBhOWRrSzFGeWdza0FqWGpiaWlCRUkyM3hQUkZNczAxVWhq?=
 =?utf-8?B?YjN4VTJ5K2RHTEZONkpSbTF0R3hHZjRxWmtLbmlPckl6ZXF4Y2JSQVBsT0Jz?=
 =?utf-8?B?b2VsU0luSThHWklPMFgzRzYvTFVEaWFNaTJxKzQ3cTlqZUJUWkVhak5PZ2dS?=
 =?utf-8?B?Tm0zdFJsUzJoaXZFajJHQmpvcW1oY1pIaGgxSjJHY0ZsaGFlckQxZ2xlemVh?=
 =?utf-8?B?M2hMeFA1ZUpobVNmTmRjaVF6MzdoQTV5ekJ6U3RlS1BCd29qUjdKRkRaTHo2?=
 =?utf-8?B?QmlRNlhrVkdCWElXenhubnlwWkU5cENzYXRlN0kxUHB1aldDZnVxbHV6bXIv?=
 =?utf-8?B?NHRCNmhvQVN2c3QxNVdxQ3p3T1pZT3JJTy9ORjdSRkVhN0o1S0dWMGQ3RFVq?=
 =?utf-8?B?enZveFZ1c1ZnN2dQeWNjRWhBQ0MrWWE1OGMxQWgrNDdVMXBZeTFTb29zVUdw?=
 =?utf-8?B?M1FuNWdYOC9SWWpYSnEwZDNjSVJ0YWVPSGhkaUtQdWN2NDNsMXBPNEc0Q1A3?=
 =?utf-8?B?bnVsMzA5dmN5dkRrbUZ3c3RIU1A5RWVzRFhXdWZvQXdXOGUrcWFUM2RuRytN?=
 =?utf-8?B?N2g0NGNPelZmcmV3K3ZFYXVPTHA3blZBWnVpMGFneUw1SzR2QVE2Wk9iK0p2?=
 =?utf-8?B?aStCcFM0emswL0wzSkRpSWMxVGduMHVSNGdjc09SMWZIL0VzdXpTK0kwZGNz?=
 =?utf-8?B?UEw5emM5aHhaSm9tbmlwVmdxT3J0ME9yZmxKMTA5Z2dhZUF6NzdqK1hxOWxw?=
 =?utf-8?B?eElPbzFOUU5qeHYzRWV3TWNGaDlmeGlCVTZrMVYyYVNWRWRMU1JCOEdHdnBt?=
 =?utf-8?B?WVRpVGVJZ3ZnTzN0aXRPUmlWaE1XYWpFRjVRWFo2MUZ3cFFDMEdXL1p2ckQx?=
 =?utf-8?B?VmhCVXZMdklaeGNEeGpUOE5KZ1I1cXYwSFl3N2VqV0pCSHRneFYydXJVWVNs?=
 =?utf-8?B?TE02aVJmbk1FL1JFMjlrb1h4ckMxcTlER0U1ZzNPbUVGSUhXTkRJUzVoMGxO?=
 =?utf-8?Q?EQnOLtnc+Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjBWaTI1WXFyN3NzcnVQMjIxdGtpdmV6dkhmOWJlS3gxdVNDT1RYSHRIYjRp?=
 =?utf-8?B?OHVGUEtXK0x6KzlGa3pPOEJCSzVSNVNQMjgzQW9vMWJSdk0rbDcxM2ZxeUpX?=
 =?utf-8?B?VnlEMFpQallqc014SVpvRFVLQy9Ib1p1cHMvQkg2OUxpQVc5aHpZSVlBMDMy?=
 =?utf-8?B?dS9BbitNMzEyQTZVUFNIQWpCWTdTNUQvSXF4aHZpS1FuZEU5U2pWektlT1BX?=
 =?utf-8?B?WlJMWWNDUEtpMWNUdmZZM1htcmI1WDFWbGZ6aW5YZVQ4UXdWM0RGM3NZYnlW?=
 =?utf-8?B?eVk2eUVvSnV4R25OQlZyR2VGRk5jTVNLaHRNb0NTeGtCMmdORFhTbm1zcktB?=
 =?utf-8?B?WllxQ202dG9HVFRUeUZDbEZPK2V0dFdUWS9nOXJNaEJqVTM5NVI5UWUzVWp3?=
 =?utf-8?B?dzEvWDB4T2FsdStHSDB1QUw2RmUvV2F5TW9NYiswUm1yV0paSk9YT040dFIr?=
 =?utf-8?B?UFlyTWkyMC9YRDdaTGw4dWgxZ2dLQzZoZ1hCeHVMUmNrbXJMOXF3VUNuNXEw?=
 =?utf-8?B?REtVZ1JCZkZFam1maHU5RVpiVldCN2MwMUpVZDF1aDJ6NjBKVkxsYkUvRVZv?=
 =?utf-8?B?UnNTSjlDb2hib0lpTVNweGVOSEF1aDJyWFFvWnVQTlJ5TGVjNy9BcEZxcXJw?=
 =?utf-8?B?RUhCcXF1UXFzZVU3RVI3RVk1NEJwNW9MRnJZNW5aaTNMTVgrRFJFdE5OQThx?=
 =?utf-8?B?b3l3aUhVN2xjR1U1cVZKczVXOUJXM05OZldrM2hqV3ZBT1JuUVhXbTk3OXRZ?=
 =?utf-8?B?U1Z1MFBDMDVVV2x6ZitsYVdqcjBsaUhxMzZoTWNyeTBHOVBzbm5uUlJySDh5?=
 =?utf-8?B?dG5wRWRLSTNCRm5aOWlPcmNGNzVYOVozbloyckF1bjZ2b1pjMFFKY0FrZGY2?=
 =?utf-8?B?ZGZ4dlhTSkdRV2R2dDBwYit4cm83NGdFK2kvSmtQd2dOc09rdmVCRTQ0dkov?=
 =?utf-8?B?WFhKZ0V5SEVYR2dRRzMxM1YyOGl4MisrUFhrZHZ5V05qQmNYT1g0dGdUL0ZX?=
 =?utf-8?B?bER5MlNxOG42a3B1ZEMvakJxQzV1V2t3N3dMVHg0RkRTb1ZpUnRrMlJuRTFs?=
 =?utf-8?B?Y05LeUovMFRINlhFTitTTFZIOURvVStBM2I4d1hvWlhmbWZBWE1mTy80cmY3?=
 =?utf-8?B?OUd0OEk0MmQ5M1N4L3NwOHRHbjFtdFJaOXNPY0RwbHF0NjlQY2NaaGxweFF3?=
 =?utf-8?B?REhYcjFRTlQzT3YwSnZWZHJTbEg4MXFvcEVnbloyd3phN3JiZ3E2TEFWeEQv?=
 =?utf-8?B?bmVsV096NTRxMXZIZTdIeVVzZXhMTG10VERScmVJMGlyYmpOaVJpdmFHZ3JX?=
 =?utf-8?B?Q3oxT3RJajZPQkQ4YkQyM1plYnpmZHlvQ0lvOUd2T3pUSGlQa1R5eFlIaHAy?=
 =?utf-8?B?MEFva0FURCtXN25LLzVwOEVXM3p2RU0vZm5teFhKalFsUHZlaG91MnVsRUFP?=
 =?utf-8?B?T3dHT2xQU2p3eGkvZGp3WGlxNHRxbHoveVRFajVrNHRGamo3QlUzMVljL2hl?=
 =?utf-8?B?N3VZN3krNVhtZko4UWxpWXRONzRYSU1GMFJsL25sZ1RVeDF5Z2FEZFdKbDBU?=
 =?utf-8?B?ZXl4TU5PSkZ6TmljNVFJRjBjZkk2a25xZU82YU5DVDRFNUxsdHJOUVYvZGtn?=
 =?utf-8?B?UDk5SXlCMm53N2dOMkJFeXhDQmlZZ0tpd05DN0Q4STVxREZ6VDE0a2FiMkZ0?=
 =?utf-8?B?aFE1V2xLbWRVN21tNlNSenZ6Mkt2Sm1RbHdDRGQ4NXJDYS95M3NoeHlmUUVv?=
 =?utf-8?B?SThJU2RPK3FzcUtyNUkrVStVMmF2SkpnNS9Gc3R5N1BvTnBtTURrbWZhMFd6?=
 =?utf-8?B?M2xoc29Xdk1Sb2VLQkFTb2dNaUVhai9FMEdWYUxmOVBEeXBYb0luS0RVekpU?=
 =?utf-8?B?a3Z1UzNkemRuUDhPdEc1UDN0L2RZVUtTb3ErbmYweFY4US9tRmN4aCtVakRZ?=
 =?utf-8?B?K3EzVjVhVzZyeE8xQ3J3L00vSVp2bFMxdlB4c1J0T3VReCsvb1Vmd0laVzRz?=
 =?utf-8?B?NjJYWmtpdEFBeDVjc00vcExzMUJWODZndUhoS1U2NXE5cTdQZWdYWGpDTXpu?=
 =?utf-8?B?N1BPQ3RraGNIVXlmcTJ3dHQ3ZEZTMC9tZGR1cW8yaER5K1ByODA5OEMydFRj?=
 =?utf-8?Q?JkU45rHD+9ODESyrsKPbLaX39?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940bce73-f5b9-41b2-aa80-08ddc7bb4985
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 18:28:56.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GROAqqyIZ3L9fnpqyDt7B3O9qQopvx51qCIacLuPPo9yOOUUvz2ZH6kFs80lx6SkODr00RmL1/DmxIkj1bp1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039



On 7/19/2025 8:46 PM, Vadim Fedorenko wrote:
> On 19.07.2025 08:26, Vishal Badole wrote:
>> Ethtool has advanced with additional configurable options, but the
>> current driver does not support tx-usecs configuration.
>>
>> Add support to configure and retrieve 'tx-usecs' using ethtool, which
>> specifies the wait time before servicing an interrupt for Tx coalescing.
>>
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/ 
>> net/ethernet/amd/xgbe/xgbe-ethtool.c
>> index 12395428ffe1..362f8623433a 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device 
>> *netdev,
>>       ec->rx_coalesce_usecs = pdata->rx_usecs;
>>       ec->rx_max_coalesced_frames = pdata->rx_frames;
>> +    ec->tx_coalesce_usecs = pdata->tx_usecs;
>>       ec->tx_max_coalesced_frames = pdata->tx_frames;
>>       return 0;
>> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device 
>> *netdev,
>>       struct xgbe_prv_data *pdata = netdev_priv(netdev);
>>       struct xgbe_hw_if *hw_if = &pdata->hw_if;
>>       unsigned int rx_frames, rx_riwt, rx_usecs;
>> -    unsigned int tx_frames;
>> +    unsigned int tx_frames, tx_usecs;
>>       rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>>       rx_usecs = ec->rx_coalesce_usecs;
>> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device 
>> *netdev,
>>           return -EINVAL;
>>       }
>> +    tx_usecs = ec->tx_coalesce_usecs;
>>       tx_frames = ec->tx_max_coalesced_frames;
>> +    /* Check if both tx_usecs and tx_frames are set to 0 
>> simultaneously */
>> +    if (!tx_usecs && !tx_frames) {
>> +        netdev_err(netdev,
>> +               "tx_usecs and tx_frames must not be 0 together\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       /* Check the bounds of values for Tx */
>> +    if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>> +        netdev_err(netdev, "tx-usecs is limited to %d usec\n",
>> +               XGMAC_MAX_COAL_TX_TICK);
>> +        return -EINVAL;
>> +    }
>>       if (tx_frames > pdata->tx_desc_count) {
>>           netdev_err(netdev, "tx-frames is limited to %d frames\n",
>>                  pdata->tx_desc_count);
>> @@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device 
>> *netdev,
>>       pdata->rx_frames = rx_frames;
>>       hw_if->config_rx_coalesce(pdata);
>> +    pdata->tx_usecs = tx_usecs;
>>       pdata->tx_frames = tx_frames;
>>       hw_if->config_tx_coalesce(pdata);
>>
> 
> I'm not quite sure, but it looks like it never works. config_tx_coalesce()
> callback equals to xgbe_config_tx_coalesce() which is implemented as:
> 
> static int xgbe_config_tx_coalesce(struct xgbe_prv_data *pdata)
> {
>          return 0;
> }
> 
> How is it expected to change anything from HW side?
> 

The code analysis reveals that pdata, a pointer to xgbe_prv_data, is 
obtained via netdev_priv(netdev). The tx_usecs member of the 
xgbe_prv_data structure is then updated with the user-specified value 
through this pdata pointer. This updated tx_usecs value propagates 
throughout the codebase wherever TX coalescing functionality is referenced.

We have validated this behavior through log analysis and transmission 
timestamps, confirming the parameter updates are taking effect.

Since this is a legacy driver implementation where 
xgbe_config_tx_coalesce() currently lacks actual hardware configuration 
logic for TX coalescing parameters, we plan to modernize the xgbe driver 
and eliminate redundant code segments in future releases.

>> @@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device 
>> *netdev,
>>   }
>>   static const struct ethtool_ops xgbe_ethtool_ops = {
>> -    .supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
>> +    .supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>>                        ETHTOOL_COALESCE_MAX_FRAMES,
>>       .get_drvinfo = xgbe_get_drvinfo,
>>       .get_msglevel = xgbe_get_msglevel,
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ 
>> ethernet/amd/xgbe/xgbe.h
>> index 42fa4f84ff01..e330ae9ea685 100755
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -272,6 +272,7 @@
>>   /* Default coalescing parameters */
>>   #define XGMAC_INIT_DMA_TX_USECS        1000
>>   #define XGMAC_INIT_DMA_TX_FRAMES    25
>> +#define XGMAC_MAX_COAL_TX_TICK        100000
>>   #define XGMAC_MAX_DMA_RIWT        0xff
>>   #define XGMAC_INIT_DMA_RX_USECS        30
> 


