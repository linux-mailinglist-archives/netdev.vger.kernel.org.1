Return-Path: <netdev+bounces-237050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15C1C43D47
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205903A0855
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3521E2EBB8C;
	Sun,  9 Nov 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKZ9NVzr"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744712EBB9C
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690618; cv=fail; b=nfPTBTil9mAns5ATJAQI9rurqIYc44bqeE9MEcv6SfRszFE/cv/Q8KnTkLrOZOC8SxXExwjAiGy41o65CNvUHQoVIzIJp1HKQc6qLbGTAgmL/4m3ue8kWKobv220S9I8mHXVPOFuBIl+s7Sr8mLqsA1kmTqo0ZXifTdL8NMXGPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690618; c=relaxed/simple;
	bh=FejNdNGWsHi0lIh5+3hTuT1WukRiA2yS9aRXiz7syj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PvGqHswXGJLlJxyhixCAjKysTfsbMcsl8sJH5zi28kaStnfZxhl/u51ZNrqg+jTPBR+pCTFLKAu1jGQIq5aKDP1DVxV0Qm2Lz0DwB6pQahvlShd1zTvKMp7tmaQukQyohqxeMQF24eeWKZkNF0mhefAsf6nv72UjOX6dWY4mRfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UKZ9NVzr; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czTua954gcvYpQl9pGl08M4NstkVhhUhC8qAwNaS7WeKFKYuJQjN0GY9kGqzcgeAWqstsclroXz3gprPFq+PfRDEZnpmnzcesBKrwdVbrHj8FD93ALhCvTegEHxRbjGE7x9LOO/GZdLw8jJOUsaKK+qdSn6e/0MG1aM/d8nvgZQI332wKv+g1VF7AlGJ2W+s2uMSNNlfHsfjnK9EQjV7pWtlsjRi2hFsLJRaIu8RxgUI4D03/gVggeAi74nMfZuavUhJH1A4N9NAU0Zi50FvIAEvCCKPfyXzUlVAy3g92MJnQRAduuHEcNImJngyF6jkvfV9R6M27FdYFC9mcXG+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHVJ2GIbbA4ol237UKLOJVxH3naNhOA84AAgN3cZyxo=;
 b=UkKH0wZvEnjuLikkbMGnJY06m0wWeqsmydwG/qKScj5vXtTDiV/YIgkQR/AqAyKRQ6os4vTxjUB2/rLyL4UEiDhGOr7juOmsi+UvW8fG6JGGCShUJp5pVwoZC5q6Bvs8V1iBzKPdOaEif/tLm6Bj0auXaT/6AYRgcVGoh5e9vvT3FXxQa6DYzKMJ2QUrQGaZGyvh2tM3eyMQUsMyJzE+c49E+jimu6XvFsallTBWy7RzmopgPfTbcC1DlNFSZRMv7LveQ7Q0kCbmjiZG/5i+NJk50HjJLzx56Lj4BMdaBfyxI3kNKKNvG8mYEgVnhZY5FGKBQnKTiEiElBI3zYWUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHVJ2GIbbA4ol237UKLOJVxH3naNhOA84AAgN3cZyxo=;
 b=UKZ9NVzrgs5gvzlDAm2xWpd9VQsQf/VHLVM0wpBHmW40pazZ4rB2NosxTSZEn1pyyNPci2/aNSooDj+ueLKyqnxdrObTouzIFleM9zDOsMu+XKoJ9+90Og2z8xGl8l3j2EHu5OIvJKPqmQm+8ieZw2LbPEE1C1FF8IU4I6ETUwH/RDJoP3E9My27RDrztgvRD2uF1ZXnbOdZaFjkGnuD2GreUVdbnyo27+krvtLWFaLDOFa7gT2onrggmqpg2fycFWG/oJzcRpNxdijnf2D6tqhJ6YBoXFq1n8EZ67AF66Uj7mNf2D5yMT0YYI/P/nWT/tv6YDgVeSstfEiz1Ki73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 12:16:51 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9298.012; Sun, 9 Nov 2025
 12:16:51 +0000
Message-ID: <1f46970e-8bbc-45ef-98fa-250cc1649ee2@nvidia.com>
Date: Sun, 9 Nov 2025 14:16:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: specs: netdev: Add missing qstats
 counters to reply
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <20251105194010.688798-1-gal@nvidia.com>
 <20251105171359.4f14b199@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105171359.4f14b199@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e918f0-328d-4479-746d-08de1f89dcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBEdGtiUmN5dU01SzRTTWUrMnd5dXJkQlBCYjRXY3ZodmYxZlhqeW9ZOUhq?=
 =?utf-8?B?dklYRFcxS2JEb3BOYWtiR0RvaWl2OW1RQjBRODlHYnFuRGZYZkVDQVhBQll2?=
 =?utf-8?B?ZmUvYUtUK3VYZysydmtiOWRQWHRkM25ha3VqMEI2eGkveElqYlRWaCtMbFJE?=
 =?utf-8?B?MG5pa0hueTl3SGJTMnpHU082cEMrZGVSUUx2Y0FzNWVaOHVJRlRsanhyTFZ3?=
 =?utf-8?B?UzJQK0JBbUNzOFRuKy9SVkdPUE5JSVlPM0l1eFhjK3B1WFJHbzh0SjBwOCsx?=
 =?utf-8?B?REFvMVlFVmtZVTZWOGloZzBEbXNMYzRNNEhvOW9WR2F3MXY3N1ZqRnNsSnhI?=
 =?utf-8?B?d2VUR085ckIxVStoM05mR3VWSm1yWmgwSlRFejh0RDJzY3g1Mk12YnViOFEw?=
 =?utf-8?B?QXZnRGFGNmRobzJicUF1bEJRRCtwek53ajNBYnhzSXRmOFJLYndCc3h4V2p4?=
 =?utf-8?B?RnhGcXpGanY2amczUThJMDZ4MCtaM2ZLMmh1Y0Rhb1luNUd5OWhnM0JvbDhq?=
 =?utf-8?B?Syt1TlhQalFyWWljWUhsdktIcSs5L01CcmdhNHNQOU1ZcWVlcVY3YjhqVjQy?=
 =?utf-8?B?M3dyZUV3eDBCTjh0WE1tVng2d21xNnJWSkVsaXFWS0hrUE1xN2ErZHg4Q1RR?=
 =?utf-8?B?dXZUeTFBb3BadVpONzFMOG00M3V5NFpuUzVvWHJqOUJQU1pNVzNsNGFEbkJH?=
 =?utf-8?B?WDZsTzF3eWpad2EwaGk1bUNYMyt5Z2MrMmlVckZIeTIyd084bGIzUmozZldD?=
 =?utf-8?B?SUwxN0x4OEhka2lPbHhQRG1xZERPMzNITHJramNacW56d2FXdWxqenpMb205?=
 =?utf-8?B?VktwbElLallmTTVJSGxJcWpLN1RIQUw5U2taazloYUxYSFVCVXN4cEJGdFhh?=
 =?utf-8?B?L3ZtVCs5YVFzcktZNkNYTFJzVGhvK1c0dURXSTRCRDRCK0pkMEZoVnludVlj?=
 =?utf-8?B?TnhlTEowaXF0cVErYS9jK05RV0VPTy8vWjZmUlZwOXNYdUhjRzFVSGo2c29n?=
 =?utf-8?B?Q2hSYy9VcTFlNE1UMnVBWjZMUm1SRDlvdXZWTEd5ZFpHOCtFeWU2SGhNV3Jv?=
 =?utf-8?B?aXdxWEE1Qm1Ld2VNVVNYUW41TWgrZWsxbnJtczNxaTZBRmROWXZYQUxmbTFK?=
 =?utf-8?B?UEhxWm5EcmtpdW1zcnljenJRU1FuTHlkUlFyYlhWakxWOHdUQUhLZnZPZFly?=
 =?utf-8?B?Rmkrc29zdkUrdzNjK0puMXE5aUp4WkNzYmNjM0dMSlZoNnJoNGQvOG9udEJV?=
 =?utf-8?B?YTVyWEZjd29HNE8ybmhmWmc5dUFoWmR6NWovNDNpdlpqUVpGcVN3YjNrNXNj?=
 =?utf-8?B?UHVYRFgzSEtDVys5Z0prMG56VHlnencyTHV5S2hNbVRQU0RBUkZKOWJLUk00?=
 =?utf-8?B?UFlydFZkS3A4S1I1OGZwbDlNVzVHZG9XdmZCQW9OdzRKNVJCaDhiVmNBWjVR?=
 =?utf-8?B?cGo0NDU2QXV1ZXdmS2xRT2VUZjZBbDlzblg1bkdqdmNEcnFYdFk2eWxxWkRw?=
 =?utf-8?B?RTJMYWJvdkM1aktzOHV4eVVjUGY4cjNpVkJUZGROUDIybVkyRzNFOFh3b0FV?=
 =?utf-8?B?aTJqQXlxeDd6RlZjWXZjUS8wcktlamtTLzJld0ZscERIL0ZodC9VRUo0R1Vx?=
 =?utf-8?B?UHZtWEVlUHEzeUVCOWlIU2pGSUxtb3ZzMGQyVE5RYVBLU0lMV0hqYmkwUk9R?=
 =?utf-8?B?T096V1poenlsYTUxaHA1MngvUjBGMzhwSjZGdnhBeUM4QUlGMnB1SDdUbjVv?=
 =?utf-8?B?OU9wdDByTW9oYVcrUFlqcVVLaXQyWFprSExnL0s3d3RpbUkxcVJTL09pczJO?=
 =?utf-8?B?UmN1UnlPbGl1L05zRjlXMTRUWW4vRk9SM3prTXNxUDk5ZmJrZWZjcVd3VFQy?=
 =?utf-8?B?RWtGT01oc3VUbW9VTDNUS1AvbnNUNThGczdUeXMvcFVyZjd2QnBsckM3Z3k1?=
 =?utf-8?B?TFhKR0puY1ZMYmFJUjRtdUNFdjFZaGR4Q3RWdjhrTWhKQWQxUXVCUlRBMitn?=
 =?utf-8?B?OEhrRFh2bFhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDRkU3VtcXRmSlVnbEpPZllOM3RobVpoYmZhMVE0bW1JTVRjZDZ1SlJpSnlY?=
 =?utf-8?B?YnFaT2tQOEtBaG14SjdzeFdIbEFZT3M5bGN5RkRQa3EzTUpmNitoN2tMSDJQ?=
 =?utf-8?B?Z0dZVTRrZk8vQ1gxVzRGR3J6NnczVnk5RDNpaHBVV1dxS0xnRXdtSnFFL2dh?=
 =?utf-8?B?QWZvNkFWSGRBVVplOTMzWTF1T0dzUXFPMmlrTENrZ2w4bTFLTTVIenRvVU92?=
 =?utf-8?B?SkV3Z0tZTmIxbnBuMWJzcnZSd0FEb1lzak02WUZjdGZWV1FaMkNDM0R0ODRW?=
 =?utf-8?B?TVBNMnl2ZEpNdXZQUnR1ZllVcU92dm9DcjJwNlRhOU0vWG40MTQ1TmtZeHc0?=
 =?utf-8?B?QUZYOHRLTVVsOWVreFEyWURHR2lLL0d1OHRFVG9rWExmY3NrUW5GRlhiYkhN?=
 =?utf-8?B?VVNZbTNKRnJSenRraUdUcjRpNlZMd1M3bG4zRHRIa2E2a3l4aWE5a1dOcTdx?=
 =?utf-8?B?OUZqNEd0clNQaUsvNXNmaE1Sd0FoYjkzSk0rdWlCMWZLTW5SV3Vld1ZJNzJJ?=
 =?utf-8?B?ZUNOTzlkZ3l5QWtNc3VoSndwUWlGbFh1V2RFYVorYTJXV0c3Q0ZZZC85UDVX?=
 =?utf-8?B?blJEMzFWSEN6RzZpYkNuZGwrYWc0OTBQM0RNY3FiSnkxSnEraXBIUk1BanFL?=
 =?utf-8?B?UCthVWlYbHVKNmRqZ2hlT0RVU0VKVnExd3J3eWFJd090b2c2SHpWY3lWZElW?=
 =?utf-8?B?QkZKeEw0T2MzKzQ0OERoaUJrZ2FRVnFZMnh4MFhDYnZELzJUYjlUY2xUYnQ2?=
 =?utf-8?B?QU1WMkJuTUZ1ekFWQU9zVmdNUVQwRGtUcFdMY1RPYXoyRDZhY0FCSHdCZ0lw?=
 =?utf-8?B?azc3dlpSSnpkcmNnbnZIYmJNUmk4N2dYai8wOXVrRmFWRmthNytlSDU4ZVdu?=
 =?utf-8?B?UzN6NmFZSkhoWVhWY3kwUkgzS1dWSmllZlRheGJPMU1NMVpSUnNSQ0R3Zk5u?=
 =?utf-8?B?c3NaSC9yaTB0cVpUUWV6UjRDM2JyQ2VGTFI2WEduejZaQkxTOE5XSGswZ1FB?=
 =?utf-8?B?ODBLeWhJcWtqeXhrSHNLaWp6YXR1TnFFTzk5QU9NLzRNWnJVOTBzaHJpRmV5?=
 =?utf-8?B?SWgyTWZuRUI1ZDN3MGRHVmVHN2JtL1I5TjhhOTdNOFppZVdJNUd3alA4ZTBt?=
 =?utf-8?B?RDNhT2JBczVXVFB4MEQ3QXl0VldEci9YcVRmcXU5WHB2eDVyQUZQVkdUMDNO?=
 =?utf-8?B?Z3dqL0x2ZUJjNnZUaEo5N050aE9SUUJvL09WTWUrM1c3bW1kZnorSk90RzFm?=
 =?utf-8?B?dURCL0VKVGI4dWYxeDhUY1IrM3ZwRHZzSklCNGxsT3I1THh0RzUwZXB1Q29m?=
 =?utf-8?B?VlRSN0dzaytLaEhWS1FYRlR3aTZrTVdsY1F6ZVRXSXpCcDRBNjdwaDhibHA5?=
 =?utf-8?B?OGJYT2xTY2Q1Rlpob0VmQUYybXJ3WE5lWFB6bjNVRlMveWw5R3ZHODNNaEhx?=
 =?utf-8?B?Yjg3cWE5cEZSQmhCbUR4NzdNQjYrZXVJQnhzdTRwN1RtSjFiZXJHQzdLVWxN?=
 =?utf-8?B?RCthRW9DVHdiM3hCVkl4UDlIdEwzQlFqN1NIYmxtUnpSU0w4S1FabWh6L1F4?=
 =?utf-8?B?SHkxYjZVdUNzUXRxTEoxS3l6Q1lPVzJZOWR6MVFyazJvMHpYR1IvUHRUOUl3?=
 =?utf-8?B?Ly94RzR0WUgxallJV2M3Wk02QU5zS1plKzhnSUxrcVVMbWVQKzB2b1RvbXJS?=
 =?utf-8?B?SUhJbzlnN2wxbXIzSG9DZ3ZEaFcvY2VjR3psVmd6YnROdFYvaSt2SEVRZk9n?=
 =?utf-8?B?VklNWXNvV1BNbDMrNmdDRCtac2dZYkc4dDVrRHFFRHdYYnoyUnRUQyt1OTJy?=
 =?utf-8?B?VnBnQmxSZ1hJVitGMmNKNFdLN1FpclFSVkE5NEtqcFNSZndTRHNCck1mMzFt?=
 =?utf-8?B?dmViZE5BSUlPbmd5cEd0MUF0R0lVSnVlbis5THhlVHJ6bk5VSEJTdmJaeFZS?=
 =?utf-8?B?aXdkS0dDMTM0WE5zUXgxQXhLaFNpUkJGYTE3SGNheWtJYTYyN1RMUTRiZW9E?=
 =?utf-8?B?Z2dsRlNIWHdpZlEyeTFyc1kxWWRPejV6bUlGRXRLeHFlbHpuU1NrTlMxZlI1?=
 =?utf-8?B?ZTJFMEQ5THczYmFqMjhKMXBIeUxNaGpZRlhucUZ5dXZ5QzJUaTZxZDdYZjVS?=
 =?utf-8?Q?NnmY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e918f0-328d-4479-746d-08de1f89dcd5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 12:16:51.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcUuDcy1uRDnVvNEde0xK/QIeoF8uqoNKV85DhR2gIVxgX3rK9rbWgbcHI1XMKXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

On 06/11/2025 3:13, Jakub Kicinski wrote:
> On Wed, 5 Nov 2025 21:40:10 +0200 Gal Pressman wrote:
>> Add all qstats counter attributes (HW-GRO, HW-GSO, checksum, drops,
>> etc.) to the qstats-get reply specification. The kernel already sends
>> these, but they were missing from the spec.
>>
>> Fixes: 92f8b1f5ca0f ("netdev: add queue stat for alloc failures")
>> Fixes: 0cfe71f45f42 ("netdev: add queue stats")
>> Fixes: 13c7c941e729 ("netdev: add qstat for csum complete")
>> Fixes: b56035101e1c ("netdev: Add queue stats for TX stop and wake")
>> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> Spooky how something is broken for over a year and then multiple people
> send a fix within 24h! Please TAL at:
> https://lore.kernel.org/all/20251104232348.1954349-2-kuba@kernel.org/

Sorry, didn't notice your submission, thanks for the link!

