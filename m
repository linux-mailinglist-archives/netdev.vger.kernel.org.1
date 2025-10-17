Return-Path: <netdev+bounces-230565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4ABBEB261
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FADB4E8CD7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663D32ABC6;
	Fri, 17 Oct 2025 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="F9WAXNJQ"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022132.outbound.protection.outlook.com [52.101.53.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD02A1CF;
	Fri, 17 Oct 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724261; cv=fail; b=scXmovsYBHAUO2T9MmlDNsZ3MDno1WzAv5WK8vIIrqG2Z6xpGdDTOFRlJ6eMZBwBdE3bbUY3pbUd+FNxrOvn/NLpPwG0kTTZGJV6mHVNKARJS92/pEaBGIsRbl6vhbTVluravds8mtTkG26q7cWljTIty52SGcRmPZSOKGfu70w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724261; c=relaxed/simple;
	bh=bQTarr/yCMdiHZBsKXEM7aop4oT9O+pYyFEeVh357VM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KfG+NqSfF3bTjGA4tJuaOj5EFIuUraou6dF+L6ASpjHIUOV+2TH0dPx13bcm3vkcUd99yfTOjzfVr6Xiq9mo1/8ZK9hzBn4bSScMOxp24cvU1ASydCMEB9tjO2CFtKTjYQ0j3J8I18H/WKAD9guXUJ6L8V8NQIPSlf3IyVwrkCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=F9WAXNJQ reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.53.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETlqY1a7ACglrXXLTSzmFm5fVPeyodv5yOVmXjsm71IHecA2roV5p60Ni1XQiElgQivGk7yn9BywS3ncZtnmoziEDkEN82W3zPwSI0Key56hczbnMbrbBXe6tL62oVaiGQRhYln/HbNn//ri9CIFaE2TT+NN9uUxb/W0v5i3oE9ZgDcHTwuCtc07WGOVXXDb/EOk3BxU6nHa8Evs2lZgceIi8AF6CBsKF4VRJ60I4llYTv3ZHygS2nxt6gS2gZIct1udjarjVP3eY3QCpxhOBBPsRzxl9VwMe7xnWuWzKMDogArYLaB+7rsXqy98OsZ2DMzkcq1LS5vnBlSqCw3+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSFRrNX5K1M2e8g6VVXSpXuF38RMmhyYZyLnYxKCn4I=;
 b=ZDscLWTEV+4MaX5g9IrMOBUn6n2vVPqxUFNXYWUBpelLYdyh03MLLZ3Z2HxU++KEzDICVBouJRxLBBumjbveQDH9z+ukibQhDQeQU/i3AcWvwMPDjfkrEMza4Qh3p2E7fnBq0MzV9uqClnnuADEcUPczUCNl9R2ophNu/HFp6PVm0v/Xxb1i3DpnE4b5W/HGMAqCLgczX5zG4HmoZZNc1R52DM/Pe1yfkdq5G3CHZ8OtGayGUUt+ybRGb5zwtAVtyWTFeOj2mKobHW3Fs4EyBYCPcsVzboUg4SO9eO9nqCvKWm5vui8aB9W0Nyj+9la4Y9yR41jJfWT4KrvhNzVsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSFRrNX5K1M2e8g6VVXSpXuF38RMmhyYZyLnYxKCn4I=;
 b=F9WAXNJQo/qjPuUlUsga9xQ3nummP8sFrVT03GbHgdJwm7e4LxRJhDa4Na6iVJY+qftCiddWdyFRbiCIUU01eI4eCiJQOGFBdYX2S48MSCfFBDgY6CbV513x1UfFtS2A4IqgsTBUHzLQcmILl9Nj5In+z5fh1ZuvblcFQlxYUjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH7PR01MB8882.prod.exchangelabs.com (2603:10b6:610:24b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 18:04:17 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 18:04:16 +0000
Message-ID: <a2d1273f-9e53-440f-b278-c6f53c76dabe@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 14:04:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 1/3] mailbox: pcc: Type3 Buffer handles ACK IRQ
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-2-admiyo@os.amperecomputing.com>
 <99aa7b2a-e772-4a93-a724-708e8e0a21ed@amperemail.onmicrosoft.com>
 <aPJ_8XJyse50Tgfx@bogus>
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <aPJ_8XJyse50Tgfx@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0132.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::30) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH7PR01MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed876e3-4ce3-4494-f5ae-08de0da795f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0JDVU5JZXZ1QTNBbkcyc25manBiSGNzaXdYdHFzSFRtWFJhcWM3Tm40V2d3?=
 =?utf-8?B?WkhGczhyTi9POU1pa0laZ0QxSlN6YVhkaTEzdzlGT1AxZllxcHZVVW1RUmZp?=
 =?utf-8?B?dDczQmxJd29OY3ZDUHNLNkNoVDhmL0o3eXFJRVlOQ01US0NKNnpZelZRVStV?=
 =?utf-8?B?MWpkZXBzSDIyYXBCOFNZWWlXa1Q5dWFSY09DbnN2ZVAvZUNhZzNHTnRnSDI2?=
 =?utf-8?B?ZGJlMEVQd2JRSUtqa01SZVEzbjlUR2RqV2xyTWQ0WDV3ZzJRcGZTNzd1SDFY?=
 =?utf-8?B?WmJKVGZDeGJhRlozSmpja3pOaHZCN2pHZDk4cWdrMTVmTDcxSWwzeURqbmw2?=
 =?utf-8?B?TGJ4V2VaQ21NcjFhVFFqY0MwbkFpZ0FaTVZVd3AweTFsaDFIL2pSOTBqZnkx?=
 =?utf-8?B?cjd3cHFCUWFzUzJqRFhrZmVHZ0RiY2RGQjQzMTNmdEV6NndrSkR0L3ZIR1RW?=
 =?utf-8?B?dllyckdRT29NM05wTkV0TEkwWmdSQm10NGRlUUtmUlhTblcyNkRuNWtQWFRo?=
 =?utf-8?B?YlJTOTJ3eU1uREl3N0dVdnZ3b0hwWVAyaEFOSmFBcXhxdTlPVEVkNlBHMWpM?=
 =?utf-8?B?Y2V1Zkx5SlJCVW4wQ2ZzRnlXVzdFekZQdTJINERKVmNaUEFmN2xxaHNrZjk3?=
 =?utf-8?B?eHJXRU9HTERISDA4Vm1qemNFWnhyUE1GdVFBeTBSZ3RVR1lBTnV2bU1WbTJU?=
 =?utf-8?B?WU1oNkZkK3BEVGJxRk0wTm1ZVHFHaFE2YThXQWVUOEMyeWJjbDdpbmJiZnNt?=
 =?utf-8?B?VVFBbHJ1dDJHSXpTRGZSRVNmbzIwTVdtZURHbTlCUTVoZSt5NXhMZW0raGx4?=
 =?utf-8?B?OCs2Y0RmOXlWSW01NWJEZUg2aGd6eFJiV3FodWdFWlFZdVVzejh0bzQ4dXRL?=
 =?utf-8?B?V3lmMWtUNnNNNDNVZU1QbXR2NnJpUFdJOWNuRC9TWGY4WVkyaUM2eWZpcUsy?=
 =?utf-8?B?SE5pZVhkbjJDTmhGeE5GMkRhamtTSEQ4dkxhZXJxaE1sd2k3YUM1eGhMOTdU?=
 =?utf-8?B?Q2MrcWc5UzFhY0U1Tkdud1NzMC9iMjVOV0lRWHJvZ29ZdDZITWhKNVdubjFq?=
 =?utf-8?B?NXZOQVpwRjZMTjBMWVRvVFUwVzZmbnN5Z0V3dEtEVm5RU0NPeStnNzlvemZZ?=
 =?utf-8?B?ei9JTy85bUZEaG9WT3JtTDBoVURlOGROWUNwaDBpbTExeXNhZU5oRkFsVUJa?=
 =?utf-8?B?bmF5cE84eHp0cFlTWjZsQ05uSjV5T0p4akhEU2UvZlZNN3crTlFjdU1qc01W?=
 =?utf-8?B?RzZBWDFLcDNKbWJzSHQ1OWhHWTl5VDdHREExVTcvOEJLRXBpMDRtN21YUTNr?=
 =?utf-8?B?a0E4UGlYVEZKR1RGZ2NTVGdBRDZkQ05sZEliOE9FK3ZpMlZDcmZLSUlTdnBS?=
 =?utf-8?B?RkFVaFFkSXNoRTEyQzdwMnlIeWJzWmVpNXgySTZMWmJHWWtzZUhRYlNjbTNR?=
 =?utf-8?B?WTZpdUhwWUU4VENDOGhBT3dvZkxDNnlZQnNjcXc5cDh1d0FBTDNxVm5sbWF6?=
 =?utf-8?B?Vi83R2hIRDl2TEIzY29jYW9YOW5iWHhENDdISFNqZ3BDT0R0OXlFOVY5MDY3?=
 =?utf-8?B?ZnZwVFpjNXc5UzdiV0lrdTdwOUtkMm5TdmxLb0lqWS8xQi82M3duWnFmcXJW?=
 =?utf-8?B?ajlsbk85SThwUmhPTVhvZ2FjNjhrMGZYa0pPcnJUcDNJSTJDUWxDUUhjNi9R?=
 =?utf-8?B?dm03S2tqVkIwb2tKRkU4aGZ2ZVR3MWN1a083NGZiWG0zalEzMDNoQXlSU0dF?=
 =?utf-8?B?SmxFVlNJcmVKbmI3TWhaM3ZTYU5TNFRNdnZpRGtjOHRRVWpwRzNJbnl2S1Bk?=
 =?utf-8?B?cXUyYzBaMEZYekEvcjdoZmhzVEh0eXU3YjZGRU5YQnQyUlhEbEJ0Zmc2bUpR?=
 =?utf-8?B?K1Q0V2dIYkp6RWF1alVxVCtUWkxDZmppRExDdnZQaHJWVm1DdXhyTHErN2Jw?=
 =?utf-8?Q?Hez1CWd+KIqmZhtoPBdkTVBB3xjXstYs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWVCSVArSW81eWdnY0tpRTRxaHlsdzNOZGpzWjI2Y0lWbUFZek5uQVZnNmI1?=
 =?utf-8?B?Q0V1eFo4N0RURlhQU0IyQWZhemFER3NMSlpHRWVGeG92ZUhBRnd5aEdQdkha?=
 =?utf-8?B?S3AxU2FESUpKMG02SWtxdEM4Nk9EdjE1UmlPbFRyU0s5U2NzZEdLVGkxWnlj?=
 =?utf-8?B?eGMzVXA2cDJsZENtOXdhUjhnY3EzMUgyOTU0UE0wYVBIS1RXdStpU1o0NGtO?=
 =?utf-8?B?Y3lFdjhXZ3ZlMXMyZFk4RnozLzc5OTg5dHQ2aXR6cldUNHRBOUhPN2Z3RjBK?=
 =?utf-8?B?SDMwRTNXL2EwdjhWd2VQckpyV2wwSytMMktGUkhUaDBmZkk3RzV6VnJGQm9o?=
 =?utf-8?B?VUdxeVhONERFOGx0TCtvN0twYUZlQ0prTTRkMXhxb08wWXBXaDNJTWIvVTUr?=
 =?utf-8?B?R0ltT2VyNVdaUkdna0gzMXFFQ3h2alhkTElqQm1uemYwaUg2NzBlaTNZbFZa?=
 =?utf-8?B?UmE4REIvY0tYMFdOaDZDRnlDb0J0L2FsMUh5M09RVjErN2xHVTJOOGRHMGVL?=
 =?utf-8?B?K0NGL2VFYjUyZ2xGakNsMUY1eFhaT3d0ZE1QdnFIcmFCVnpZeWNMbGd0SW1I?=
 =?utf-8?B?Y2k5djFYRktrYzhyQWcreVdKMlFDR2htV3pJSFdxYWtyWlNmVjRGOUtKMUxk?=
 =?utf-8?B?d0VWZ2VHa0ZXUmFKQXg2UHZLd0RiUGVrUUdaSUpxYW55L0xlYVJ5QkVMaXZj?=
 =?utf-8?B?aVRqMldKRGRHdVd0Tm5nZzlVaEtVVnpiaUlNNUYxWXlTVHh6ZXBoUXhUa1FU?=
 =?utf-8?B?K2tvMWY2ZzlxNHVCUFEzbkVOVDdsSzlaOVZSd0JJeGZQL3hQTGVLMG95Wmxn?=
 =?utf-8?B?L3FWRG5SWURqOXFsdHoxRTdoZ0E2L0tvaG12QjA2SjZ6dFlOeVg5RVlJeWln?=
 =?utf-8?B?NUVyWDlMQlV5U2Z0QUYvaXhkNG0vV1RROGkzTS9VRHNtQUhpSFg1ZStxQkJG?=
 =?utf-8?B?bS93b2JJM2VQKzRTMWpIcjZuYjc1d3l3ZU15aDZFUEpFQ01FM29RYW5idUJF?=
 =?utf-8?B?d2dvY2tsNFo2ZWpuWC9PcXFYZEczQXRySHdKVENMNGZGaFp2VXg4U3ZKOFZF?=
 =?utf-8?B?MlJ5Q09OaWY0c3Q4R2hXTGNkc0pBeFJwSlRLMkpKTy9SUVpreHlFTTZENU9W?=
 =?utf-8?B?Y1RjVGRDb3d3ZjlWSFJDNTh4RmkvTGVIRXBFRXRQRzBEdTdvM3Rkb0VMUlRB?=
 =?utf-8?B?QUMyOXViWnN3MlRXVVZHL3V5K3JUUEF2eUV3cTJKSzZNVjBvOGNEcGQ4RHZi?=
 =?utf-8?B?QVA4Y0RTdGZBYTh5bk0wOUVzUmc2SHZSTzczUGNGZGJCeHpuRVRrZTFLUGYz?=
 =?utf-8?B?b2JRRHM0OWlueDA4dE1ac3hpemlLN24zaDBDenNxd0tlcnFQcGhSbUpTc1pq?=
 =?utf-8?B?djBqUHl6b2M1ZHN4aXAxTFJlWjBoWUpsMW9pekQ4Q2FjQXkxd01BY0dyUm05?=
 =?utf-8?B?bzZDNVBpcG5kUVRvQUhPT1VMVmRoRU51RmRXM2owVzlGUkxKYUQrM1BVWWV3?=
 =?utf-8?B?dFZRRjdsQlpGMnZSczdZYUFBbTZqTGFQTkZHOW1HUVZ2b1A1WlVqK2FoakQz?=
 =?utf-8?B?NlBKSzM1c1RUWm1hN0xZM3hRTjZleXN2Q2k1QTRzU0laODNxNEhiSkt3NTRG?=
 =?utf-8?B?UkZVYXBIbUJCVWJiWVI1Q1FkU0tneVM2UjZYWm92OURYelVjRmZGSjJId2NS?=
 =?utf-8?B?bDUwQnJrTHNVdW5BNFhGQStVQkVXdGF3VU8vdXZ6N1JUNWlNaWUwQUx6bmFi?=
 =?utf-8?B?Lzc3UXhndHRkelZ5RVl6NGY3VzhzNlZ5blFhQksxTzdMN2VmWUZ5L2U2dWlH?=
 =?utf-8?B?TGhsZFR2UWg1RWRhU3dqa0xxK0JQTko4QlNSY0tqaU1MamtqSm02Vjk1UzZU?=
 =?utf-8?B?OThrRy9CcjRUQnhvM1poL0lOQTdwSkN5WnNlTTNSM1BaNjRiV2JVdjZQTFAr?=
 =?utf-8?B?RlNwZ29TczNYL1BIVTBkS2pzeUZyd1hjTjVyRHkvTUQ5cGQ3eWpoY0RmYlFy?=
 =?utf-8?B?MEVVWmw3UUZMc0psa1N4VnJITnM2SWw1ZVM0eGdjTUdEaXhSYnNmbXo5RkNH?=
 =?utf-8?B?cG1icTlIRXJIUXdGblU1VHJXckVRLyswc0paMDNvWWFGalJEOEpaZElEaVha?=
 =?utf-8?B?Wm80SmtJd0ZybHVjejBqdHl4QXpoeTI2c05DTjJtN2YyZlBtQWs4bkxZME56?=
 =?utf-8?B?dHlMUmFLZ0ZNcWFXQW5TaG0xZ0FJK0FxcHluN0pKVEd2dVprK1k1MzNYeHdC?=
 =?utf-8?Q?QKBT+j/iT62efzYxM74CZFs9lkamSZKj+HcnFVxvV0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed876e3-4ce3-4494-f5ae-08de0da795f7
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 18:04:16.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zv6Gm58v0JWz4H07rzH+NergHopTXuqREouRpqomsgaKMMZ5Zo5fRMhvuWiEmuDkIEvjRaGY+VPKgjGQKbwnRv4UV4fEOpwMi18lmEO9RdjhPPawBMMFn/Se6MH+YWlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8882

No need to apologize.  Thank you for writing them. And you caught 
several things I had overlooked.

I have tested the whole patch series with both my MCTP driver and the 
CPPC drivers.  I will post an updated driver (with fixes) in the next 
few days.

On 10/17/25 13:42, Sudeep Holla wrote:
> On Fri, Oct 17, 2025 at 12:08:07PM -0400, Adam Young wrote:
>> This is obsoleted/duplicated by Sudeep's patch.  I am going to rebase on his
>> patch series.
>>
> Thanks for looking at them. Sorry we just cross posted each other last night.
>

