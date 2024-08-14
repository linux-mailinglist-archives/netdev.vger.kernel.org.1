Return-Path: <netdev+bounces-118362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F048F9515FC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771B0283B4C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3213CA8D;
	Wed, 14 Aug 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lyxbsx6H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E520DF4;
	Wed, 14 Aug 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622445; cv=fail; b=jrxXVnKrxjID8rFLFIYBqCl4Rrrx1Q02Nn0Kg5FDR8TlVej8k/jc2QBMom2i4nm5vW2h1Vozxc+wpK1zBDU7wFIGO4EEHZHGYA/ZPqxQry8owQTgdQVqVl73dGsOAHeFOgpbXm0YcnhuyArK74wQklrIm/VwkeSUVFM3yEIsxzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622445; c=relaxed/simple;
	bh=V4JPL96Px+U5JDkVDquJRhkyj7OFwIU0MyES27/G8Vw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kDHMbzmihQpHh91868JQbKCztixsg0Y6Zm+FglFSM38ys6NoMORRDnteCaYIkQySMraaNZkD9P+LHZrQN1nRNLo3gsRyu1cwUJL6pJupilCBQZoMGx0PR+ad+WUaweaFA8tpAjHIVuvbjvlHPau05xMFKwlkzc5sLJcOiSeZBHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lyxbsx6H; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAqDjp8j8CMKN9h1k2iv3oSWLX6M20zxjjJYHnvbBwO+zKWXAszRY8d82dV/hOIr7zJlIuVemaiKQKeS8quUXQMEznojdwUyIYsjDR+7yaMAhfQiYTq5ogSIGS2PpL7UBetuCA8gYrBIJijdZM7MWP1A+LGsOePUh3S+w5O3l8k0VDXe8uBrGiEEoX/eVPB2GofHUcHYJXYzQnSxznGhkAozBwzcqhjmfZHfcCH8qnlHH00hIN7USMptjKc9y0mqb+If0FCk1FFyml4+azB+/AjC8TT4qNyE5C+QsSACNywCmwGAI/gStIpn4Oyu9ev/JRtIw+VzAA3DicyqfuSvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIX2yohfsbihLvDEBU5kR76G+wSRANhO9/LVUkRwMrQ=;
 b=SFsrXVZOV1YZuRp6q5KxQkFH7cKhjJgq5nJybesl+YE7WBG5sed9pOOdYLiCyP7Ry7foDkT19qZHarMpam3xXeZ9mVaSdN5FPEG3zkWQ8QI/4J/k0W986yKyQOsERxl+6e/IhWiqYdAjfQJALkaSDSFUKam2ndoTi07IKWUg+6D0eh+/HgvG2fTmMnqIvU53l8heH6UhKKiWrXrkSebMCDi5FRAYDjlKOS+EiQZU8WMv1Fs63hYW+WsNFXfWFKO//XE7LWEdI70+ZL5DGe1FWESLbRlIrkJeUNSDJibWHN9/qdcOtahB3FDxUidLleN6a+1nd7/mcGBuXWNcRTLnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIX2yohfsbihLvDEBU5kR76G+wSRANhO9/LVUkRwMrQ=;
 b=lyxbsx6HUBSkgTBL7JNZ187n25Lvjb4wh5jSrB88lFs1X/Itzl/xLP0bdZ3ulTJQDnqw6KoyUXHdAlOu8sn4jt9UebKNUXX6FF4WH7QVUMWiOIFGJzznvHvj2W3n1sNtpklnA5nOvymsnXNekIECs4U4oWeTv43SbLdR2+OKpPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 08:00:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 08:00:40 +0000
Message-ID: <6f9dc18e-6f47-e276-2388-68e1d4dc581b@amd.com>
Date: Wed, 14 Aug 2024 09:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
 <abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 18336921-f4fb-47a4-c8ac-08dcbc373099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RuOGZQdWZseEliVi9KRWdPM1dYWlBwc3MveXZNUmFZWGlhazB5NFJld2lM?=
 =?utf-8?B?bGJzZVdWVzFTeWNFa0NOeGF2ZklldzFPMFkzNWwwVU84UHo0RXJTODU0TzFP?=
 =?utf-8?B?REd3S1FMN2IyVjFZVlJYNSthNzUxamNDcUFOcEpkRVlJWXhXY2FsOWZQVmtK?=
 =?utf-8?B?WVB3aTlodkVIUGJnT1JyQTlkN0N2eExjR0Y3a1ZKbGY0ZDNieTIwdFNMMjQx?=
 =?utf-8?B?OU5GZm8xMGtCZHppbzZPSm1wS1MycERnVzNGN29RMEx3dDlYWjE3UW1ncit1?=
 =?utf-8?B?Y3VNcUxPWHhCcHUxRW9OVUZHU2kvOUFGUGhOVmQ2SGxvZW5ZbjRpdmFvdjVE?=
 =?utf-8?B?cndoYmNWNTMxTFNYMFB0ZnMyRjhuUjVTZFA1QjNOd0IyUnFKYm5QS0x5Z2JZ?=
 =?utf-8?B?bW95anArWk9rZzBXd3p5N1lkY2xsQmFCUHlsR0pyektMTWdDZGdHRTBHbzNW?=
 =?utf-8?B?ZG1tWnBZcWZLMjJxU1RYZFBYN1pFV1hvK1NMNk5IRUVhRng1UndYTEtJUmZu?=
 =?utf-8?B?aTNYM0ljRFkyTWpkZk91dHJiMkdLU01acThGSkZ5L3JSS3pGZVJrMnNLOHpv?=
 =?utf-8?B?UDVBeGlXcVB1NkFUWGtDNnA0UUdhdTFZT3Radk5pZmVyTEFiMk5tb0JPLzR0?=
 =?utf-8?B?eUZFZE9IUXRsbWFxNDhVTVJjcGt2VnBiVzFPR1cybVFkcVo5VUNxY3lCekdV?=
 =?utf-8?B?UjdHRmdWVjk0aHJ2VFc1V1JCS3dnRXJUaXQyTGsvcWp4aWNxczRFYkQzY2Fa?=
 =?utf-8?B?bXF5LzlDRnJuTFhNcm01Z0JRK3UwenVhTDVPbDR5RHpoNTdNN1Zob1BGNWIw?=
 =?utf-8?B?UjVCSGZZeTR2QlU5cnlwT0VubktlaE16SDNLUE83TlVIVjY1aGgyeXJkNnJh?=
 =?utf-8?B?TDV0bFZBeGRVNHBjWlNnU1Y5ZGFvdHp1VlZMdVZuOUd6UW9JZEhVQ0FibEE1?=
 =?utf-8?B?bmtwVWxtLzE4ZFZ2Zm14dDh1WFBYK0M5U2VoRjA3bjEyS255L0pNdmRFWTdw?=
 =?utf-8?B?VUdsM1JqR0Q5ZmNhWUdvMlpiM1lobkRVS2ZTMVBoQXYrWS96UkI0ZFE4MmZ2?=
 =?utf-8?B?OUg4c1lYd2wxWWtMS2hiZnlrQUoyTDNRQS9BYWR2eUJualNzQUVUdEJVTG4w?=
 =?utf-8?B?dEN5RGxBTmRqQ0hnamN5bitlNVB1MVB3VjRJdCtQZlNQTTZnTnY2TUJZRDRS?=
 =?utf-8?B?SHBWazNTdHZwMVR5WFBUd1E2czdQSEJhdTZJeDRrN1NnUlAyRzVZV2dMb1Iz?=
 =?utf-8?B?b3V0Y09nZzFjOWxJcjFaR09zRFJNY0QreUk1UHV0NUkwaEU4RjVUTnVVQnFH?=
 =?utf-8?B?dFBnNVRsR0t3T05ZQU92U3p6QlVzOEdDdzYxM1phSmpsTFNVSGxnZUJZdnMz?=
 =?utf-8?B?MGY0bzNHdkpaTVVTUE9Qbm5aN2x3VW5jQURBaC9MQncydHV2NG9lazY1UVlK?=
 =?utf-8?B?UmZROU4vOGFQbkZsak41aExPQ09tK1I0N3N2d3hQNnlCK0x6ejN0TEJjMldR?=
 =?utf-8?B?RFFSaWZEVGZUUUlDb0F5SnFZblpRVC9XS1ErTHU2dlRLcVZ1UlZDZmxvR1Y3?=
 =?utf-8?B?bElHYTVBRml3VVdmOWdqWXlGazNpcHJWRG15NkhtcTBnT0FpNGdaSE1LS1ZV?=
 =?utf-8?B?ejJYdFl5WVIwYjFGVk54MWg5VmtWQktKbjRoTlBTTUU2VHNMeFZ4WWJnWW5I?=
 =?utf-8?B?Nm9MV2hhbFFHVjFyZmQ5VHFLVHhFWHZwZXFiVHBVdHBqSjV1Rk1jOU9EZDJT?=
 =?utf-8?B?eEV0dXhFVUV5RUJwb1JhZzdkajBWZ1E3YW9ENUNGdEUrREFrMWhJL3Y4RHo0?=
 =?utf-8?B?ZGZESXdZdEJNNi9JQWlYQnRzWi90RmZVVC9QYUlnSDNXQ0RWcTZpM1FKT2hI?=
 =?utf-8?Q?fThPGBp2FRnlY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm0zUU90bDQzdVFYc2h2RDNvcVd3UmNXUExPc3hVZlRPeXJvL1pUa3NyNjlo?=
 =?utf-8?B?WjloNW9OT2FCRGV6dVJpZGFFQmV3eGMreXZ1emJvMnM4c1B3SUdFQTN6UzFL?=
 =?utf-8?B?K0hTdTc0M2J0Ry93REd1QkIrZmpQVnN3dHI5QnowZmhuK3hCY2g1bHhvOVhs?=
 =?utf-8?B?TFRNYVc1OFkzVlZXaTVYSit4eFFYd2pSRFpKaGRpMFF3VWJRVUdlY2FPL1V6?=
 =?utf-8?B?RnpVWXJpUXVRZXhKVXFyL3E0YnVzNHVRaUczaVkvUERndzR1N241V3FCNURU?=
 =?utf-8?B?SDdWNW9ncVRtRW5WVHhta1JPN3F6STZqVHZnd001Yit2aE5QcHBLNUsxWTlC?=
 =?utf-8?B?Q29sOFVLckFJVWdUVDNDaFZyc0NzNExJRlIwT3JHMFk5cWVZMGcrSGR1UHZT?=
 =?utf-8?B?M3gyaVQ0K1o1UjJGMnJpVERNV29ObUVPWEkyWlRCSEhmaFgwZlljTld4bEpY?=
 =?utf-8?B?RE80WUtDbjE3L2FBRGNDaVFyZEg0b2MrSkY3ZDY3L21QYWVHS254aFFUZTFY?=
 =?utf-8?B?azk5SkF2Smg5NmY4aXdMb3REL2NpSTJYb1hMY2NvOTJDcU5reE9kcW5IcWJn?=
 =?utf-8?B?YkJ3Uk5Xc01MYjlGd0t6K0xQaHowNWY2V0FQL1hpVUNkUGVIVk5OQmNLNWlI?=
 =?utf-8?B?ZWdlOFV4WTRBS202bEc3QnVLZXpXekI1dzZqbkhoS3FkSnM3V2hpQlB6aHRy?=
 =?utf-8?B?RGZSNG8xckVTMDZNQkZQNUE2N21sZzVmUThIZDVnVGJEK21YRU1zZ2J5cUdq?=
 =?utf-8?B?QnJCL3lFcDlDaklJaTI1Qzc3eklXQjNDVStReGIxR2FuVlJYeThWR2RobkFx?=
 =?utf-8?B?aDRNcXZMOVJTOW0rcS9rQzV0cnF3MGFwM3h1Z1BMd2Q2S01HcTBtZ3FwUExO?=
 =?utf-8?B?S05QSEpidENwVEhqNVBiTnFGTnMrY3NBYlJPMHRtbmtWRDB3VkJXd0wrUkU1?=
 =?utf-8?B?NjFTc1lxdWN3bWF6UEVxOFpPZmQzZVFWMGJKUGJNY3E1OC8rSkhDQkZRYUJl?=
 =?utf-8?B?S2ZCc1U1ZjM5OUpKS0FXSWxiVVRwclJoTHFORFhVNzhueUFyeFZETXdicG5Q?=
 =?utf-8?B?QklYRS9FMFFoZW9kODZRdTJ0MXlwZjc2ZFVVSnQ0TGxGLytLUS81OEIzYnUx?=
 =?utf-8?B?RW5saENwVTZqUzMzWDlmVnBlNDBJRkMrck9ZVFZiOE9zRHJCMnNLN3JYUnNt?=
 =?utf-8?B?emR6TWF4RWNteFY3OFZZZzc5Q3hITHFDYXUwaDdTajVBNEZISlZLdHBYTXgr?=
 =?utf-8?B?MDE3N2psVmdrRDBzR0VEVjFmTlYyVjhBblVVcWpEeDVvOTlFQjc5azEzZlBR?=
 =?utf-8?B?MXZZWDhIME9aSlo3SWRrUjJyaDJGQjM3V0pyRkdZKzl0ODcydkM5b21LMzJ5?=
 =?utf-8?B?ZytYd1BURk1RK1FQd2ZZZTJobDdNN0tvOThhT0ozNk1YclZpc2NWa1Q0WFBm?=
 =?utf-8?B?UmVwSDMrOVl2M2JaMU94TmFrWlBoVmM4MlkybVpxL254bXNSc2dXT3pTK1RJ?=
 =?utf-8?B?TVBoSGpRYWczQlpGckJtUUJoM1JkV05CYWszaFRsTmgvVks1SGhsVjJaZzhY?=
 =?utf-8?B?N3dIL01CY1BZc2lucTEvV2ZUbmRCZytrelpyK0xmUUNRY0xpM2xERWJDTUhs?=
 =?utf-8?B?WnQ4cDhCcHMxNGNnQ1VEV0FkZjM2Ny9sdCtZcHRjSmxhWUdsNmFVNDA4Qy9R?=
 =?utf-8?B?RktRS2U4MitmWlh3TXdXQnlNamVjZXNFNGRUbk43MFpsaEI2VHVrTmtaWHg0?=
 =?utf-8?B?b1I5eG9XWkZ1cDI5alA3VlFOa3I3WnFIWkUydktyWityVHNieFh1YStHYWoy?=
 =?utf-8?B?VGNFcU95MlUzRDJvNlU0aTJyNXBXK1YzT2dwUHVhR1EvUDltVkVtb3g4Yk9G?=
 =?utf-8?B?QUszZW5aTHo5ZTdYekJXU0k4bGg0QmZyS0hXOXo1YmMyOER4elRiYytWaWND?=
 =?utf-8?B?MXFBTi9PUVFiSlczWUtaNm1jNnZHd21GZXoxOEVURDhqcFF4eWhJR3JVVGNN?=
 =?utf-8?B?dWI4Q29BRGV4UGV3WkZWaVNjcGdtQkRDcHBGK1l4SERGb3Y5OTluRC9PeXFu?=
 =?utf-8?B?SmhlMFY5UG5sZHJ0dFROR1pkMXNiNytlVzFvbWFwb25KMVNRY3hDN29yRC9Y?=
 =?utf-8?Q?P5UQ+IYPeuJ6ue74nB+0FnAy1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18336921-f4fb-47a4-c8ac-08dcbc373099
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:00:40.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PBS2DLH9gPQnUYllJMeepZfB1bfPHTemWWuUD2nuh1edNX1ALzBcu5c0OkdcHq6s9OFjxb1nkUwhzxA7/vYPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433


On 7/19/24 00:36, Dave Jiang wrote:
>
> On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Create a new function for a type2 device requesting a resource
>> passing the opaque struct to work with.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c          | 13 +++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>>   include/linux/cxl_accel_mem.h      |  1 +
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 61b5d35b49e7..04c3a0f8bc2e 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>>   
>> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)
> Maybe declare a common enum like cxl_resource_type instead of 'enum accel_resource' and use here instead of bool?


Yes. Thanks

>> +{
>> +	int rc;
>> +
>> +	if (is_ram)
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>> +	else
>> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
>> +
>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>   {
>>   	struct cxl_memdev *cxlmd =
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 10c4fb915278..9cefcaf3caca 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
>>   	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>>   	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>>   
>> -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
>> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
>>   		pci_info(pci_dev, "CXL accel setup regs failed");
>> +		return;
>> +	}
>> +
>> +	if (cxl_accel_request_resource(cxl->cxlds, true))
>> +		pci_info(pci_dev, "CXL accel resource request failed");
> pci_warn()? also emitting the errno would be nice.
>
>>   }
>>   
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index ca7af4a9cefc..c7b254edc096 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>>   void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>   			    enum accel_resource);
>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
>>   #endif

