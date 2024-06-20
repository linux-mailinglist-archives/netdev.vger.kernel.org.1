Return-Path: <netdev+bounces-105359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F668910AD4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252152827CC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B41B0136;
	Thu, 20 Jun 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wvh59zhy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250671B0103;
	Thu, 20 Jun 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899158; cv=fail; b=NcsBh/rQB56MakGCuPxg3DPrjwW9qkjwaL45P9KyzSYUYown0CNnI/fFrUICI3CJ0MP0TB5M7jnkCeEvMOUMejXKz+A+Zy45Q45GmCwUlEMsN89YaeHbk+rTLDdInNWVFU36Iuh+z9/S4AosiSZuDaKfL2OEhSKUCYwYwRa+1R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899158; c=relaxed/simple;
	bh=NZhgd7QJKFGcbtBhyhXDxDtFPN+clAQfKJLlAjuqql8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qQw0O728jRshpvLuxjanqxybZFKDd6GEDLwBw5tIwgJDqbLeJqJ6dhkx80NDlVOvBLQ/oJxJWYMjxwMvH9tQiDVFq8TbOH4k2XDQfyALeZc/j7snZneVFDXATkooVG7XYmmtjKvhI4rcvJIkkYTIJTgYwND0MjEIAcxCacIXcnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wvh59zhy; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi7bsd5LDezrt+AKrhTtsv7QZreDslVlf1MnxuW88uUagzbxJF9GQtdGXyTJIjhT5Rl7oOXjbV6oq61SlvLJns51gEnbUKrP3o9hx6q6ZHwCHAPtZJs0kMScEBafSY3ZULDe9QPnhJjMlBlg82rnTC8etFTRgqgdJbclUDIEw7Xue2uyM/7g++JH1Oi+VjxlB/MK0FNaWWymoAcZqVARoXllVCQYCXiapWY9TCpRSksdFXGchsEoQYg2jn7+O1KYwbo2dskjg7BdujksPnayaVTBjS0HBRRvAa1YMR289Et3OnG0pDPG7/7Uw/wASRHy6sJk/kAdbPn1dAsn+a2v8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV/nFju6vbssOAP8KhD8lBJRy2CEtUpZ4pjvs0vXAd8=;
 b=PiN+0SYXiae03bHfNCB5MV+dLiKwCiN7zYUSljBxYSIw9bXz+ynISA7I9Az1KyQDurqzFZN7WnSzNsgn9TUsWiUzhSCGqYYImgpSN7vralAFNaISFjuqhpZltUeOabY1hC5GRheJC1zDaDDV3VBh5K39Tc9tq5QTgF2uL6ybhqeo6/546AJc55oZMIkbj+12ZQzBGQqR/UDqWp+rJobmWevYy+4AUMgIDqvyZvMjU5cukLk9eq9ZtfWr5qunrcOzaS9PEykTzoKTc45LzhA39hEuFcnHkRSYIkoQV27NLi+BixF9JMWw3vBEMKwDktAKNe+SCWe7yQgjjAcIOj38UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV/nFju6vbssOAP8KhD8lBJRy2CEtUpZ4pjvs0vXAd8=;
 b=Wvh59zhyvxfJhLaFyNPmhGevo8+JR4ORdcyCDKGlkrtz9p0u9QwBf5yqCuaBXkT93dlfDR6rt0Jk0mSPbC8IrDtiQDlmfC8/51fkMI4Mn7Z3zLrtJL5Tlv3wiZc0I/DSjOG1MjJpnheJsDSlMrRgxdClz8QMbKjGpRPpsd5mREA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 15:59:14 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7698.019; Thu, 20 Jun 2024
 15:59:14 +0000
Message-ID: <616a10c5-9c72-4221-a181-6251e808b9b8@amd.com>
Date: Thu, 20 Jun 2024 21:29:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/4] net: macb: Add ARP support to WOL
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
 andrew@lunn.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
 <20240617070413.2291511-4-vineeth.karumanchi@amd.com>
 <20240618105659.GL8447@kernel.org>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
In-Reply-To: <20240618105659.GL8447@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f9a816-fc9a-4678-107a-08dc9141ee55
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjFtb0x4WEYyUURPd0dBRWpnN2N6ODFMYWFUNUtwelpzNGwvRE5qcmxZSjhR?=
 =?utf-8?B?aTNxYU5CNTF5clU3bFJ4Uk1PekFSQkZCckdLYzlsdk50WGZNUnlnd1ZxeTht?=
 =?utf-8?B?WHVnYURxYTc1R2NKS0NzaHhHSS9HRjZwcDl5cWx6cG90UVl3MjFBVEszQjFi?=
 =?utf-8?B?dEo1dDNJdHFRMXVWR3RBOE1ZYkFBTlJ4NkxjRUVXQzlYVVNrUTZJeHN5a1RE?=
 =?utf-8?B?d0VZaHZ1NGRmbUN5UUdkVk04S2JwencyZ285S1NrZlBPZTlPUUE5YjFaZXhS?=
 =?utf-8?B?MXZENGxGUkJsZzlycTEwWkZ1WXJ0L2xqNDJGb0EvU2lqUFczQ0tFaFV3NG9S?=
 =?utf-8?B?MU5hY1crUFZ3V2R0S05qL1ZkbHJ5ck1zSStxZlMrT3NTZ2Q4TnA2RzhUVnFt?=
 =?utf-8?B?ZkgxSG1sMzR5OGp5MkdaSE51dzUyZTBJTmduZHRnWlVXWFNJTEFMMzBiWjZy?=
 =?utf-8?B?bFB4QlpsQ3JuanlVbWhHTG5DQWtqcVB6c1laT3pOSEtXOVZNTTI4aDNQazhG?=
 =?utf-8?B?ZlJFWTFVb095ZXlzTDlTc0o3WEhjbldoMk9kSzNqeXZlZXdOQ1hwY3MwOURQ?=
 =?utf-8?B?ZXVHa01sWUkyUTNrNTF1TzA0cTUwYTdrT3VvMTFkRFY4MkUvVzVlS0Y5YTFZ?=
 =?utf-8?B?b2FGWXUwNTNrK0hSemZpR0ZCVzNtdVQ3S1BnQ3ZBVjZEL1ZPdStDb0svRmpy?=
 =?utf-8?B?SGdYWVRzVkNSM0VTU3pvUjhRaFZ0QzV4SG1LakVIOFBhY3BxRFlDMzhnRnc3?=
 =?utf-8?B?WnZ5QkpkUlcwb0ZnRHp1bnpqT1M5VzlITFg4Rmtlc0lhYjVVZC9td0wwWWhY?=
 =?utf-8?B?TEx4dnV1MER5UkMrbFd2QUhFSHA0Umd5M2hyM1NEVkhhMkhVcWp5VUhIU0dt?=
 =?utf-8?B?bW9YRUVORGZQYmtGTkZnSG94bUFIVjJwNm5Ed0lMNlBWdzI4c1pKOTl0L1Ir?=
 =?utf-8?B?OXB0MjYyQnNHRm81U2xtNGN6ZGMyWlVLbUlUOGtrWmpiOSt3NEkreGtsRTRD?=
 =?utf-8?B?OWJNUUZqZzQ1TGJrTEExMXd2QjZraDZFVDI4UW9sVHB3cVNqaU02RVRhZmlO?=
 =?utf-8?B?QTdiL3p1eENzK2JCbWNkMWYyc1JlRUpGOThyQlhZb2hSQ05yRGZDMkZaSlBk?=
 =?utf-8?B?M2VnRmVaOXBiQ3dyU2UxNXJhQm5UODIvdUhYWFRSL09ZTWM5UDFMV1VzL1ZZ?=
 =?utf-8?B?VExLczJFV21kMnpXZm1RM1ZqQWJlRkphcWl4WEcxWnVUNlNjZmlCaERWVnVC?=
 =?utf-8?B?dU1XcGhia3NqRHk2YXErVjdwRkhlZnVFRWlnbnowS1pud2pUSnlTV1NuZjJx?=
 =?utf-8?B?Tm9BUS92MFkwTjdlbUNxb0dxb2VFZ0FhVHF5SUZvN0k5V1orN1VBb1JWMGwy?=
 =?utf-8?B?RkphMHFna0I2cGxOVGxhMWZOcXRrRzZFL1dVQnVyVnJEdGM3UlduWlFOYS9E?=
 =?utf-8?B?T25jU1QwbHFISk5SRzU0TVVXUG9FOFJESjFUd2gzSm85S0h4SU1nYUh1NmpY?=
 =?utf-8?B?NVZyQldzOTNFM2h0MlZFZ0pmd1RyZHUrSkdWUkwxdjIxUHVQZkQyaXN1dFdk?=
 =?utf-8?B?WWdPbDBETGFYcmVnQnB4MW4yZEdSdGNTamRwa29uSFkwYUc5RitNNGpRR0dT?=
 =?utf-8?B?Q3o1Ym4xL0kwTUkxc1NQbC9tWGtERkZxek9TTHFQTmtVYlpGOFhYNzR1UWh2?=
 =?utf-8?B?K0dya2RDdmhLRlVYdTB5dFo4NlBWMTU1aEZkSjhuZUdVM1lrWHI0emR6NWtL?=
 =?utf-8?Q?fThw4pUNurXu7PSOx3VPYTJZXoFyHfQpWMXRk3H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy9XZGFWa21TMkhZNUs2b1BWNmRoTS9IUUowNStYZG1HTm1VL1RUM3pXYTg3?=
 =?utf-8?B?VnViZGpRellSMXhiMmhiOTdUR25uMHRYLzVreGFPemxnZDY2SDZ3N0FBL2U4?=
 =?utf-8?B?VmFuWDRWYkFqSzluS0xRSjRnTlZKd2hEdkJ1M3hmSUVMQzdQcTRVU0krUm5Q?=
 =?utf-8?B?L3hwMlVKSEpsN3BnTTUrcGIrZCs3MHZ4a2JCb1EyUUh0YUVQek9WeTBwZjQr?=
 =?utf-8?B?WkFFWEFROFM1dzFkT2hPOU00cTJkOGVCTnh6b3dua1hTNjRxdGowY0poZnlT?=
 =?utf-8?B?MFBGaG91NUg1RDNTZnl4bDZEcDBzMU5WRWJwM3gxcTN2ZjVNbU9QWGNsWnBU?=
 =?utf-8?B?QUZVOXJTYVcwa2tLakxtd3pwMEJUZWR4WjZOMFdySXpIUTE3d3hJTzB6Si9F?=
 =?utf-8?B?dXp5M014L1JyNURaYmRMUUpJR01oR3d1bWtZYngydDBBcjdNcXlydEk0YTRJ?=
 =?utf-8?B?UlJxWnR0dVhlMnBDWExMVXRPS3RSVTV3dVY2VHhzSDRzN1d1ckZicXgvbnJ1?=
 =?utf-8?B?V2NLTlhSMEtrV2lwZ3RUUmd4VXlYSTc3VG1ZK0lGMVVMV1IyUkUwYzhrdERD?=
 =?utf-8?B?RmJ6Wnp1MjVKeHRIMllWeVJpVDJzZTMvZmlFWjVoam5NbjJ3bU5TS3h0M2tV?=
 =?utf-8?B?OG9RcFNtSExFdjdRYythZ2hOUHFkY3JRcm5uSFB1ajJRS2dpc2JiTlo4dFZw?=
 =?utf-8?B?Z00zdWJjRTVWbWlDK3lMUUtPdzhHbW5QWlVzRk42MDhXcG45dEVFTHEwZmor?=
 =?utf-8?B?OStyY2xTTENLMloyOTlUUDdRanFuUTRHSFIzOHhNWXczcGR4WnFhVGxLMGtX?=
 =?utf-8?B?Z0pCSWVuZUlmK1MyVHBCMWlCN3ZaQytKbW5qa0JxRERoTDBZVUZpcVc3TmFv?=
 =?utf-8?B?NERtcW15cUFRWUxNTWp2N3dpaWMzM3ZVTlFnY0I0NEFETzZjODVOM0FIcjB3?=
 =?utf-8?B?NnFadkgwTGxKOS9IZ0Y2L3I4b1BOQjhOYmFkL3hUM0tHYU1PTTJmUHJFYk01?=
 =?utf-8?B?endtdW1HbVhWdkZlVXFOZzZHelFKMXNMbi9yMXMweHJNdG5XWG40YUwrYVNQ?=
 =?utf-8?B?RERkTzFNOTdxbmUzcm1oQTBsQTBVTTFPQjRsYXMyOFF0bndJVGNtekpjZytx?=
 =?utf-8?B?VEp1bDh5QjdZaDgreC9US3ZZdDlVSFEvSFcrdXhtQ0dXYWRad2Z2NUZLSWR5?=
 =?utf-8?B?ZkR0MWpJZVFtZkFaQlR6QnVLcVZQUENVM09Tb2x4MlBCaUhRd0NNRVNSR2FC?=
 =?utf-8?B?M2NCUENaeFdhcGY2dlpLWldyT2ZtclNPRGxXNlFZQ2JVVmtCOXRKV1dGeWtt?=
 =?utf-8?B?MXViNWRIRFNUQUZSQzFPcGZIUDZuRXAxQXY2T3Z1VFgzRmI5R1BocWEwNnBu?=
 =?utf-8?B?Z0pRb1dpS0ZPaEcxeTFEUm1nMGhxU29JM1RwRUpocnZFVjBpeE11bXBFUlhI?=
 =?utf-8?B?U2pENkNXMlh4ZGVJYTZsSXp6Z0tSZjRXQ2l5bzF1UE14WXJSMmp2RlVjZUE3?=
 =?utf-8?B?ek9UR0RoQVBUU2gxMWZrMi9MMkh2MWdCTS9SdVM1YnE5dUNqOXd6KzFLNFNl?=
 =?utf-8?B?NnZiVWNJSSt2ZU45N0ZpQTV3MzFLVXZiRXlkRFJoVWszNzZaVStCQ2o0a0dE?=
 =?utf-8?B?TjNtTEdOcTBpMTAvSW54dzZNaDFvUWtzK055dG9HTW93WGgrTWgrc0Myazd6?=
 =?utf-8?B?UU8zc3JzQjhJTDQrMlYwaitRT3h4b0NnU2dWTHpWMXhhcFVrZDVZajkyY1Rk?=
 =?utf-8?B?YWJXZTJTS3NHcVFOa0ZHQjllMGROZmt2aFZaelVacUxLVFZOR2JNN0JBdXpG?=
 =?utf-8?B?N0FScDQwZHVzYlp2MExGRnluSHhRTWowVm1sYVZwSE82Z2NPU2FWYWtSd1dT?=
 =?utf-8?B?VDJzaU1kZGJZeTRsdnFPek96ZVJYUkxoZWk3cVd5d2l6UVZVQWthNDJRYWtt?=
 =?utf-8?B?anFyQ2M4dmEyS1pRN0g3MHUvZmpEdzQ3SmxQNUFGZlpZOW5JMTRGU3F0Q1VM?=
 =?utf-8?B?U1JQUzFXN1pCMEdvSnBPK2R5VEFXNWcrUXZpTDVVd2xwVU1janorMmVaV3NB?=
 =?utf-8?B?VFBzTUZNUlNTTXFvK3JuTUdZVkc2M09HMllTanhnS0xIdnd3U1BUQ1BTU2FE?=
 =?utf-8?Q?H87gd6t0HxVPtCbH1AmnYVYdv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f9a816-fc9a-4678-107a-08dc9141ee55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:59:14.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH/FXscibvF75/aB2Ib+Xs0eaBDnk62i1xo8+Yo7DUp9l6wZuh5953iCwESUDbVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

Hi Simon,

On 6/18/2024 4:26 PM, Simon Horman wrote:
> On Mon, Jun 17, 2024 at 12:34:12PM +0530, Vineeth Karumanchi wrote:
>> Extend wake-on LAN support with an ARP packet.

...

> ...
> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> 
> ...
> 
>> @@ -84,8 +85,7 @@ struct sifive_fu540_macb_mgmt {
>>   #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
>>   #define MACB_NETIF_LSO		NETIF_F_TSO
>>   
>> -#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
>> -#define MACB_WOL_ENABLED		(0x1 << 1)
>> +#define MACB_WOL_ENABLED		(0x1 << 0)
> 
> 
> nit: BIT() could be used here
> 

OK.

>>   
>>   #define HS_SPEED_10000M			4
>>   #define MACB_SERDES_RATE_10G		1
> 
> ...
> 
>> @@ -5290,6 +5289,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
>>   		macb_writel(bp, TSR, -1);
>>   		macb_writel(bp, RSR, -1);
>>   
>> +		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
>> +		if (bp->wolopts & WAKE_ARP) {
>> +			tmp |= MACB_BIT(ARP);
>> +			/* write IP address into register */
>> +			tmp |= MACB_BFEXT(IP,
>> +					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));
> 
> Hi Vineeth and Harini,
> 
> I guess I must be reading this wrong, beause I am confused
> by the intent of the endeness handling above.
> 
> * ifa->ifa_local is a 32-bit big-endian value
> 
> * It's address is cast to a 32-bit host-endian pointer
> 
>    nit: I think u32 would be preferable to uint32_t; this is kernel code.
> 
> * The value at this address is then converted to a host byte order value.
> 
>    nit: Why is cpu_to_be32p() used here instead of the more commonly used
>         cpu_to_be32() ?
> 
>    More importantly, why is a host byte order value being converted from
>    big-endian to host byte order?
> 
> * The value returned by cpu_to_be32p, which is big-endian, because
>    that is what that function does, is then cast to host-byte order.
> 
> 
> So overall we have:
> 
> 1. Cast from big endian to host byte order
> 2. Conversion from host byte order to big endian
>     (a bytes-swap on litte endian hosts; no-op on big endian hosts)
> 3. Cast from big endian to host byte oder
> 
> All three of these steps seem to warrant explanation.
> And the combination is confusing to say the least.
> 

tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));

The above snippet will address above points.
Consider the ip address is : 11.11.70.78

1. ifa->ifa_local : returns be32 -> 0x4E460b0b
2. be32_to_cpu(ifa->ifa_local) : converts be32 to host byte order u32: 
0x0b0b464e

There are no sparse errors as well.
I will make the change, please let me know your suggestions/thoughts.

Thanks
🙏 vineeth

...


