Return-Path: <netdev+bounces-190003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA6AB4DBD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2E19E53B7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4491F4C8B;
	Tue, 13 May 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fT/jx1nu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589811E491B;
	Tue, 13 May 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123940; cv=fail; b=Yxv0oEYrC1Hr1FQm9sYm7d7iVdyL3Ocvm96jeqmR6SIWQ4ebsctr8yYqRV4UFdlYBVprOQ4b0yBxMiNAcRGtgp7F7StAFfFtUbkMnitw//MPNRRDV6M+Az/2wxPgeJ+7vFSY4RFns5JY54Zrdxt3QuqQjq3jjTxSCFdDyInMmo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123940; c=relaxed/simple;
	bh=G1DbvNJqGdafXPuSrJaNxTcQCaT7e9l2rOdeV9WOvCE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAzqPfeKasc1fJI98qb5vUUZPpsESMFetbQ31LWdDUSBC6X6siD0WJ5slGu8vaXoFuc410b4ypRIAYOBMhYf+HvKvr4o6wm4m2ROXpWJOVDIbNs8mbbhzauxkkeDcxyfNCXAi4IsWyZVFH/R7n81v9eyd+91mv7SVVZbFfLp3e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fT/jx1nu; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI5N5UIHpb1nY6Q1dJyuZO9Ds++sjpLUTJdUHoabTZanQbNft64/PDxxuB9AeZB+H0ryqBdiW5+a3hFGZkoek3Vjn9A7gHCRZfwG5KoD8fRjH+e64F6AXX3WaQ303n8lZp/8d/eiXSkfbSLdGRDiRs5S9ugx4SCPBEdGhj1rlYGhl9E8XjC2O6tIatBlhgazw+tRYp2rDUsPBX49rvlw2vf08zv6CImyTA9ymIEiDmhDfrjL58Fr18xrpJmnghy/imiXPNnJQrSPOrQ3JlIGOoaIxBAtUKu8ms5eu0jOXfye5H58SyV2NN8GQOdmvO9+z6wVyJWl442Pago7f2xGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGC816NX4IfEXO7Zf39AKXwS8fRbmWsnK96wgoUe08I=;
 b=A4jdAzkzChkZHiJh0Xh6bVRQ2yvvHZUEpaA2XF3WAiHRNDqy3i/1HyLIZPG/Jd8lg7QNz4tl9DYCuylHZm5sYvaiCvfH5XoxCYbmW4V3D5fRoS5ra5yCBQ2ycF1cbb3j96YxWARUHa9XE3DIw3LBbTbn7hLKRje1nMJPl+CeldQW7qlfNubQW+h38rlC011U+na7mXLr5YKzLZ6d5JfocMGkgRnxiaG3DIvGGKnOZTU65UraMpQCUwNshoj+S52+xC/It9xMVeOLVwoEElUs8cBPyMiYxzxakUGEomdAaag+bLiRmUSkzINN/hCn5Hq4Dxmcaf36ie2CXfJHoIO3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGC816NX4IfEXO7Zf39AKXwS8fRbmWsnK96wgoUe08I=;
 b=fT/jx1nuM87aq0BGcFprX0PW9mR0zhTpz39guThjid7znRSmVZF0EkgkIsX1soq39/BLTVw5dy7EJuGIE/nXyQ5Th9R39Ui8ekgy8btskBuEZ+Ev9kasqFDERydNLJjvkjo7OqaPwvJH6fskAzE9Yue3R9iUSkcXImoHjdJuigo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:12:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:12:14 +0000
Message-ID: <8342ea50-ea07-4ae8-8607-be48936bcd11@amd.com>
Date: Tue, 13 May 2025 09:12:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/22] Type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
 <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: db0c92ec-ed2a-4375-ce8a-08dd91f5de9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmM1K3lHOER5QkFjaHlyMjgxUTNEbE1GMzMvdU0wWUhSbysvYnZNT3ZMcTFQ?=
 =?utf-8?B?bjBkYTIwazFCQ2UvUE5mM2ZCemcvOW9SOHBmOWRyaldyTU44L0ZuN1FicHF0?=
 =?utf-8?B?OUV3V2UzSnJOQkY2UzQ4ZndHMzg2U2RFbWxIT2lrNHUxZi9zTHByaFpYbzRI?=
 =?utf-8?B?NGZ0a04vSmowdU1wSFY4NGFjenZXYXk2SXN4aHI4TEdmN09GdW5rY0RBa094?=
 =?utf-8?B?N2ROa29EYzJPZmYzaW8vWjVybVJ4ZXlFZENnWERpaWNHNjdJQmVSeHpvbVhZ?=
 =?utf-8?B?UGNMYTVQT3dqSmh3NEp6L0ZibHRNRmMwYzVRdUE5S0RrYzhwWFZLU3hrTkhS?=
 =?utf-8?B?cVM4K2t4dE9uQVh1b0ZZeUhiTWtoQ2Z5RHI2S28vSzVYRDRNekNLemVNUEZR?=
 =?utf-8?B?VDJrVEtvMDZvZ1JUNGhlK1NjRmdId1c0bTFjQjdIRk5nalBFMStEajFlb2lr?=
 =?utf-8?B?Njg1eGpuZWk2Vnk0OVJMRWlTUlpUQjBZYkhEU2Z4cW4xelViY2hoS05RVE11?=
 =?utf-8?B?bnE2Zk55L1lxc1ViNXZ2ZEtaRWQwd1QySzUzdzhCd0pSK2ZkZldsL0NmVGsr?=
 =?utf-8?B?bnROeGs3ZjZvNkhodTFPaTA0SWJUcHcrQ2dkSko3bTdRb0VMTy9xYzZuNEZm?=
 =?utf-8?B?R2Z5T3F2Q3MyekI2bHp6ZFdzVXFtak1MRGZEc3YvYlUrOXBUN09TOEFPaFQx?=
 =?utf-8?B?UjR1Mys1L3l2TVVEdjExMlVLVkgxYnZIRXBwSFBEN20yTVo3bzBpbXRVMmRt?=
 =?utf-8?B?SnlRL0hMRXNCVlhyQlNNeC9DNC9mL1plbktSbUV2NXlTRmdrMTBjOXpMTGpP?=
 =?utf-8?B?ZTBuNTl6bFhoVUV6Y3doY29QR2w4NFVLVHJiQ1NvRllMWEx0bGNNU1E4VHVa?=
 =?utf-8?B?SzUvcUROamg4ZEVZVEpjdE1haSt1MGxqNGJET0s5RzY1U1FaRjV0QjlOdzQz?=
 =?utf-8?B?OUZYWUh6WGRzd25hN3JBOVlMODFOb1dEcmsxUU80Tkc3MVpCSFY3T25SV0dF?=
 =?utf-8?B?ZDhVb0t2WEkzU0hvUGt3ZjhCT0lBV2s2R1hWNHFlcDk5MHVJMTJLcUc5OVZk?=
 =?utf-8?B?U1NXME82Z2FBMFFNblJFeHVEY0tSM0NjZjZCSStqQno3NlJDSWRBVDlISDA5?=
 =?utf-8?B?T0crbFlMVEV1blBmZSs5bHBRRjhFakFkWVVtdmVRZjBjRHVtaFJISzhQa2JI?=
 =?utf-8?B?Y1dmYTBpdkRHWXNxLzEvaUxUckRnTzhIcS9QaURxdG03NTFlZFV2S2hTaE1R?=
 =?utf-8?B?Z25xRGlwenBrZXRyTnhrQkFUcGdpeXNKaUhZMGkwTThYUy81a2RUc3YwV2Ns?=
 =?utf-8?B?cHpuNDIxcExDWEhhei9lTkpsR3VCWUhnY3BTU0hBT0E3NjVreDNnV0JZNkg3?=
 =?utf-8?B?RFVqb0ErcS93TGt1ajFYNFM1YlZBTFRMSUV5OE5FeEhWTXkxVnZJMXZ1bGZG?=
 =?utf-8?B?aWxBcDNHcmRVMTZtQitSL0ZUVGZJY0g4QkhTanlNK2VDYzR3ZlVEMktKdm9z?=
 =?utf-8?B?ai9CdGwvanB4aFFXMDBwMWd5eTB1RWF3WklFRkhBcEhESjZRd2k0dXU1TmYw?=
 =?utf-8?B?TGpua1M2ZTNBbFArUFpMSnBPdkJpMHFiTGt1b0M5UlpQY2lxVWV5aTdENFhl?=
 =?utf-8?B?U3c0RkZiaHFINVBQTkdid29KVDdtYWZ2WGlpWUYxSXhFSUVkZnJ6ZktyVkc5?=
 =?utf-8?B?U2V0YnUzS09IcTdQWXVPdHdzZ1NmZ3NMcTBvUXFPM1U4SUFwaGpvNlJ5Mm1S?=
 =?utf-8?B?aUt2Y0ZrSit5V1pkOC9TVlFMTXNZSE9lYVQ5d1daeHBuV2V3NUR6dEJ1VW5L?=
 =?utf-8?B?TXQwTnBEaTZYNy9jMWtBaG0zNWF5TlplSllyWHd2czhuQ0NENGgzK3ZDMXow?=
 =?utf-8?B?OVBURFpJOURwU2R3MHlodmxkdEpEcWZ3MkZxTG9xeUJ1a3VDbVcxVk4vV2VN?=
 =?utf-8?B?YzZIVDJRSWcyTUpwU2YxMk9mZGhQeHlKcWZ2VHBZRUM2dEZocHpNZ3c2L3ky?=
 =?utf-8?B?OEcyMWxiM0RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlgrdWFzY1lvSFJXcWdaK0MwbmRMOFRRQjdtamwzTDBrNmwrV2FmRlRIV21I?=
 =?utf-8?B?bjdPS2VtaW03WFNlaTZRWmQ2b0pvNHptSzdLamhCck9aSVVwWVhYUWljU1NP?=
 =?utf-8?B?ckgydWNGWjFYKzNaTGhkTWxpOUFsd2JtR3pNWExhdHAyVjd6aHhTa0Z5Zjha?=
 =?utf-8?B?N0owdU5sUWtzYSt1VEhrTVBmUFpxR2c5ZTYrSG1GUWxaL2JZY0ltRFBjR1F5?=
 =?utf-8?B?SnNkTHdLZkhjU2MwRVJabkdCaEwwV2NoaHRvaXlTMjUzQ29jNXViRWxaY0pR?=
 =?utf-8?B?T0dPUlorMkVBUCtjdUdqR2VXRjY4VE43VTgzdEswQkRpUW9JeWs0Q2pIRCsx?=
 =?utf-8?B?eWh1SjZqVG5yMVdvS3V0SitLUC9WeWhaL1UyTjAxWituYUc0T09FWEpQZ3pn?=
 =?utf-8?B?V0hENmlaSEpsTnRYUHJsSElnWVZJVDQ2L0FsUlRSQVlQb2d0RnNpYzJ2ZHE4?=
 =?utf-8?B?UzlWZmRPeFpzc1BmU05XT3Q3NFRGM2tkVVNDN0RQbk5DSEhLaGNsRTMvc2xJ?=
 =?utf-8?B?bU1lTGZCY2FtY1NsZ0I0Y216dXVGdlBOTnhBN1RNNzhObE5KVzlyS1RLQjAz?=
 =?utf-8?B?ampZdS8vR1RxUVJZODZPa1ZBYVVzMXp4UHVGYkY0UjhvdFl1M01sc3NxWTZz?=
 =?utf-8?B?YUxJWnd1TDJ0aitGTFJyQWxSVlBqL2xNd1RpZk55YmlWVlJFNDRyaEFLYmFp?=
 =?utf-8?B?Yk5jdDRNa1hxY3JYaGM5SU5QcWk5eVlQaXNMZHV5Y09HT3QzdXJDcWtJUWFT?=
 =?utf-8?B?Ui8wR0twUnJOSXljWlhCMzlnUXZ4RVVFZ3QvYzBuWG00WDRHdWJmUllUUE5v?=
 =?utf-8?B?WFhJZ29IY1FJSkxvK1dxcXJKVHlmZGIveWUzZkxmRU91RGtsbGk1VVM5Rklo?=
 =?utf-8?B?YTRwQ2wxa1I1bGRVOVJQTURoUFdJZ0hTbWZmbEVZNElNa216TjhMSmMzM29l?=
 =?utf-8?B?b0ZZUU5QNGtNcytPQUtsYTJyNGJETkZ3YXNUTmh6U1dDTkoxTGFubHRxMlNW?=
 =?utf-8?B?WmJrUzd5aUs3NkM2Sjk3a1o5dlZOTXhVWnYzUElIWUxpa1NCVk5ndlRTWXRQ?=
 =?utf-8?B?ZnNSVzdmV2svU2xPeG0weUVzSERaM05JaGF1UkFSdTlqc1hCMVROZHBJYTVi?=
 =?utf-8?B?RHR4dCtHTStYMGttZVpDMkkrbGtQc1ErTFFIV0Z5ai9ST3dGbnRLWWNwV3Nn?=
 =?utf-8?B?YWduMzlkbS9LYk94elE4c243TDFqY1FSUTVtUFY4b0VuQ2JSWTBFTDBBc3Uz?=
 =?utf-8?B?cjJFdjkyY09vZjhCYlpDRmozdkZRKzQ4aFVoeUh6cFlHcUlNRUlHVm5WbUJq?=
 =?utf-8?B?dkczQ0FiMjV2bnZvNWtSSnR2MHVoR2hEZ2dyckV5cDhTQzBaUnJrYnZ0S3JM?=
 =?utf-8?B?ZzRBa0JxcjBSVW00RHVtSWNSVG5CazZ6NlltK2oySXE5N0IxTkh4cFpBY05Y?=
 =?utf-8?B?ZkoxeUNjSHMwU05wbjJHUDJNbnhLNlJNWnlGa1RnT1lWbUQrTkhQZEFWNFpQ?=
 =?utf-8?B?SGlVakdwTUpHMVZzbExEVEZLcklwUnZVTFVGRlE5encrcFdGYjRwKzNHUndu?=
 =?utf-8?B?ZFhKNGN6ZldYaTdQMVZvbmY5elJoTGZNYkxEN1IrWXd5YjRtRmQ5TTMzZGRj?=
 =?utf-8?B?bUs2N3dEQ1FwTnlvQlNuY2lqUkJXNWxBRlBoZ2lhUCtzTjdRUXhST3BPb21Q?=
 =?utf-8?B?dlRwaWhKSFhwT2ljbHg5OTJUSUFxQ3h5TTR1U01tWGUxQTkwWHFKNlNJd3RF?=
 =?utf-8?B?T25HaXNaM2psS1VrWEIyK0plc1lrV3EvTkFqNmF5cDliVllaOG5QVDYzK3ZL?=
 =?utf-8?B?RXp6SmlISmJXQWp6bGpnYnMyL2xjaXpuWXpDY1hXekR2MG5CY1ZnV2tWVjFB?=
 =?utf-8?B?NUlhUWZCa3lwdElhWE54WUFCK0pSVXhXMTRoTjg5WXhtUG54MDRhZitJeVRi?=
 =?utf-8?B?ZDhZbkRzelZHVGNkNVFWT0oyRS8vNTVmOU5sZ1A4ZlNMY2krZEZjMndOazlQ?=
 =?utf-8?B?R0c4RGpISzFsTnVJcUwzdXRWTzZROEtYVUV4ejJBQVNPaFFMeERCV2I2aTJl?=
 =?utf-8?B?RzlhZHpjcFV3YzFTY2FvZDFENnlsb0JRNVRUd2N2L2tpVXhvMVRPNTNSWDl5?=
 =?utf-8?Q?j7WWkyLdi0sdMgdbiso0DTnWG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0c92ec-ed2a-4375-ce8a-08dd91f5de9f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:12:14.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfRT/oRQGce63+0KrY5cEWALDmIApIg1Awcd3l0EunIGFx2LhZO28UlH/GofKMig3aQpjmNI2usgTJ9uxWkxKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235


On 5/12/25 23:36, Dave Jiang wrote:
>
> On 5/12/25 9:10 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> v15 changes:
>>   - remove reference to unused header file (Jonathan Cameron)
>>   - add proper kernel docs to exported functions (Alison Schofield)
>>   - using an array to map the enums to strings (Alison Schofield)
>>   - clarify comment when using bitmap_subset (Jonathan Cameron)
>>   - specify link to type2 support in all patches (Alison Schofield)
>>
>>    Patches changed (minor): 4, 11
>>
> Hi Alejandro,
> Tried to pull this series using b4. Noticed couple things.
> 1. Can you run checkpatch on the entire series and fix any issues?
> 2. Can you rebase against v6.15-rc4? I think there are some conflicts against the fixes went in rc4.
>
> Thanks!
>   


Hi Dave, I'm afraid I do not know what you mean with b4. Tempted to say 
it was a typo, but in any case, better if you can clarify.


The patchset is against the last cxl-next commit as it it stated at the 
end, and that is based on v6.15.0-rc4. I had to solve some issues from 
v14 as last changes in core/region.c from Robert Richter required so.


About checkpatch, I did so but I have just done it again for being sure 
before this email, and I do not seen any issue except a trailing space 
in patch 1. That same patch has also warnings I do not think are a 
problem. Some are related to moved code and other on the new macro. 
FWIW, I'm running those with "checkpatch --strict".


>>
>>
>> base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
>

