Return-Path: <netdev+bounces-141120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB39B9A20
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BB21F21AF9
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334521E47B6;
	Fri,  1 Nov 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="W/B1dgjj"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020087.outbound.protection.outlook.com [52.101.85.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E271E32CC;
	Fri,  1 Nov 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496009; cv=fail; b=N0yOuav2FdgLiyZKFlDNuk++dBKeNJ9JC8Sf9WwuV64im0XJ9BqLIQmChVMts2Cn3E0oD9u2OGja70/Rzf64urRtgvmj1jHV2Ojk+VdybdAOsAJ/LB/6438Nh/qWiaUk7JWfSSAoG7VKNFVJfOB2GKaYrE4mRrKZjHM2+/KBiYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496009; c=relaxed/simple;
	bh=ii+fZEH5nlh2FYfTsuoCA7WsMae0UU87Cogfm68Yo4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPOnknU4vIENJHkK4jMZ9/3EsY6r+yW4xlNqTBVERS8iwfY1/875j1O/MUEOIUAXkF9XTT5OZyup618X3FlzUVVw8laFxyslRWBa0O+Aj7IVSVmk8pHZxlfEnkzh4IaM/YCqTV2RSRGvCf8S3WIBi5B2Xf2/8dP71KhMHe0SN/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=W/B1dgjj reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.85.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkWL9IinMeNLDTCdiaPP1jykMqowSeh1NRSBW4jz0g2SJtyNyIWfBXn9wTaAVGkey0WnmAQmXIqHEhPJseVT9Biet1mR8iEwf8vVkoDmJuhAnQTvGXQAozixk39TkjIODJryhx4c1OGH8Ao1DtquFJ5dXo1DVnAcO2YVNHaf05Em5NQmr+SluXC6Tj9dIXP9imbwOX3P9bF5/IBKTOTzvL3dGIwwwifT1GCAOCY/O0xsPZ/h/mNQv9QNX0Y4QsYHbAEPauPHtnNpvlzmS/L767eg8FppLFHjJzB3fsMdRjLiq8/8XJpPNkaNRwX+NGGhVt2NbbsQledjh4zg2sLejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPAd84ZGpkYbbL5P//zr+06YfcV49QgIhc+M+w4/u/c=;
 b=yCX0PVNc3ltnKBZeAaQjQ1sJWW8mOCw6VA1IF3XZGzWECCJJzsF6b9VdgnihucsMQPcmY7jC3FVurpukJRw+rlszaJuh5zV92Y2a5rkIDlBfzbHwkFzy4j8yYRF0KoM8V5uWsL2T/L6NJAkPXQAZn8ZE+yEthVmRoyrANLHOA/wENKq0gWJ45W+ywIZqQZ8RIGh/Gwkn4yG3XClgZXCM/yY/7xmUQ10YHSVpwP/DI0QlQp7KOWhkp2kJY6eFR4DefTgY5+sm7uwn3WN5iyjWxcVyMB9DP3f+JmAP0NI14Nj+GqQEfwAxEZx7Gx8XVjaQ+MT86n9NEygWuq+SVTFj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPAd84ZGpkYbbL5P//zr+06YfcV49QgIhc+M+w4/u/c=;
 b=W/B1dgjjLNE1CKemv37ryii71W9LeJK2nbqq40LHWCEoCCxUR5JI5qvM/Dz+Nz3UUPaVGKl0Jxne9Nyv9XMz6SI9Q4pbjPSzFuObJ8Myr3CMsOmFakw7OxMxGE5LEOyFSrmRzPYz4Ebe5hGYJ1rJcwWByqgRbCV9O4tX5akrmHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 MW4PR01MB6257.prod.exchangelabs.com (2603:10b6:303:7f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.10; Fri, 1 Nov 2024 21:20:02 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 21:20:02 +0000
Message-ID: <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
Date: Fri, 1 Nov 2024 17:19:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::8) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|MW4PR01MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 531c93c6-fddb-41dd-aa02-08dcfabaf2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXZveWlvaGF2MlgxRUVGcXd6NDQ3NmU4STlSNW9DcTBzUE9XVmROcTJrdU50?=
 =?utf-8?B?WU1RUzNocGk5SEJUc1J3bXN0Y3JoTzFSSXJNV3lsNHdkcDYyTHJhNzBwVUZu?=
 =?utf-8?B?b2doWUFVVlhEamkwRERDZXpkMGVmZGJtS1k2amRVRHlURG9Zb1M2QXlCa3U1?=
 =?utf-8?B?MVBKL2hoTkt3NlVoR3hvU1krdnUxbENrTE5zblZDM1hocHp4VnlMNTRGS1FM?=
 =?utf-8?B?bzUxbVU0R3hWY1VZSy95VnhZZnUzOXZzcVV0SjBBMnNNUGJYM3hFR2oxVW5h?=
 =?utf-8?B?TlkxV3Y2cURwcEFCWStFK2k0Sm1zVENPNHNRdTNoSlRKY3JaMWczQ0JPUnF1?=
 =?utf-8?B?dVhXcU04dnJqM1F3UTVsVVJ2V3RxVHdtMXdsNFRsTnRod3A5cHd6c0F6NWxt?=
 =?utf-8?B?cVlCbzRFQTZnazlWa095aDIxVHlyWXZubENoZzVTT3VqK2xMY3ZWSkJaZjQz?=
 =?utf-8?B?Zk9qdmxCS3BUbFE5RFhERnFLM1BSWUVUTWV3QUkyMHQweXdoU1BqenUvdk5n?=
 =?utf-8?B?M0lSUy84ZU1ueFNGZ0xaMVN0UTV4S2tBZmhnNXlkZjVkTmdqWE1lSTBrWCtn?=
 =?utf-8?B?cVA0Y1NlblRvd2gvRVlZb1JYOWxDZjh0bHFnd1Rac3owYStpL2EzbkZreFR3?=
 =?utf-8?B?ZllyNTFmdnVVR25oREh3UUNwZkZadUtNcE9xYzRqUU1NaVpSMFFRbjB2OWt5?=
 =?utf-8?B?bnBzdUNsMjk2ZEdiTEVmeUd2MmZlWldvWVpYZzAvTlVSS0kzaXFPSGFDbzBJ?=
 =?utf-8?B?VUJ0bWZDYUwzSUtDNUYzY29kQjJqeEhBSXh1ckw5ZlZac2lITnpyUmhjVlFs?=
 =?utf-8?B?WWs3RVVrVDJpOXhnOFpUUlRkeEk5eE9TVHhOcTBjVWR5ODRrdDcxRVZzKzVP?=
 =?utf-8?B?WnY3VXdtQVRheUR5WWNqaEdFcGNHK1c4K0JmL0pJQkJMTWd5N0hhM2x3ZU1H?=
 =?utf-8?B?ZlJZd3VTay81aTA2NjZ4bTZIdFFiY1pFNTVUV3hZcm10SFRmdmNKdGZzVXhE?=
 =?utf-8?B?MlpqSWdBMUp2dmlvUVlGR1JkMjZET2ZML21JSWRMWlhCWTV6YmRvNDdlMUZi?=
 =?utf-8?B?YmJrVlBiWHNZZzZwM1llWGFHdHd6elJMb0oyTHRlZnA1OEhtbTluSk1PeVBD?=
 =?utf-8?B?SlpUTjNJQ2JNM2p0djBSVEs3Z2l5azJ1dnlJZ3h6RU5YZEFpM0N4ZzRDZGh2?=
 =?utf-8?B?NGFKNmJ1bUNpZENLYjlRR0pXYlhScUFrTWNaMmdmQmJ6dkNQWmZLaFpCdGhF?=
 =?utf-8?B?bUVUbWJuUk81WFc5cUZEVFhadWh0OHhETUpsamZaVWQ2UzVOT2pIcm9FbmJC?=
 =?utf-8?B?aGQxNTRQdG5CL2ZFSlpUeHlmVnNvOXdaUlVHTVNLa3lPbURBMzdwSEEwcUxq?=
 =?utf-8?B?akxkbFR4enZ2cDViVGNPajNnR0VoS3VybUt2QmhBZFhaVUtRQ1RVZ2ZNYWpP?=
 =?utf-8?B?Zmd4aUg1Q3lFN2duN1JaVzRmUUl2MlRwTDVqY1lqUkh3K3JYbkFVS3p2RFVD?=
 =?utf-8?B?WUNuK3phZE9qNEs3Q3hiMCtLM2tEa2Q2UnpiYk0wVWZvenNpa2hGanV4SVhB?=
 =?utf-8?B?d1lhbTNMbVhKUDdKZUFrQmlQM2lsTWpodXdHcnA1ZkhuVUgvOVdQajFYajRZ?=
 =?utf-8?B?TDJ3dWpUSDRMcUlxYlFSaDVvQ21QYlk0RUFBeXVMM1FwMTNaa09PS1g1Rnl6?=
 =?utf-8?Q?XP2opTK7tAm2Td+yEixW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdDdmozS2lPSGJicmUxSXlWMVZIN3R1QXZDaldIZEdVamtvSStqOHpJY283?=
 =?utf-8?B?MjcvWXY3WDl6NlVqaUxENTlJRWhTWXdJMEpTbElGMFN0eWtUaGRnY2wrdm92?=
 =?utf-8?B?ZzJSYjRTM1lackxlbkJxYm9EUEZNZzFvdzFFcVdVOHQyQVRka005aStkZWds?=
 =?utf-8?B?RUpVZUh2SlJPMmc1K2NQS0xKTDFOWUdsUk5nV29rVWd5cDlIWDQ5bzV3T3cv?=
 =?utf-8?B?RDFKTEtwZWEyaEYrSDRHbXB5K3lvK1NpYWREZ2RvVVltOFpqbzh1TVp5cVpI?=
 =?utf-8?B?M2ZDTEVIUXlHdUlwbUROTVlLazBXdDY3TzF2NGl0TU0rZ0pVOWJYakhQWVFS?=
 =?utf-8?B?eFh4VzZCVVFrNlRIRitQcnBjbHloKzhFK0dTZ1BUdzNrYkZvYjBnNWtjWXds?=
 =?utf-8?B?cU8zakZRY052cVlySk1uZWtkd2lnVVdLQlUxcXRmMEs1alNzcFRHQjRlaEgw?=
 =?utf-8?B?UURBV2dZM3dkRnQvcTA2MkF4UDUrNlc1eWo2YVRwS0JGbDFPMHFUVmN4QjZh?=
 =?utf-8?B?QkxIN2xlb3BFNEVBa1lSRS9vZ2pqS0NQak5sUjdua002TldhMGFEbEt3UGFE?=
 =?utf-8?B?STE5RVVSWmw4Q2ZiSHhJSGRtWXNTNHlWazE3cFJqdERwa3M2SUx5RVhaRXc5?=
 =?utf-8?B?NWxFSnhpcU9MWURkSHNMSk1zb1l4d0ppN1FOanBYd3RkYUhtaFY5TnlVQkRy?=
 =?utf-8?B?Y2d5MFpXRWRybnZuTHpUbjZYSUViNzFpbkJYQkJEM040bVY0aVkyQ0dOdm96?=
 =?utf-8?B?UDJqYlVaWFdUZm0ra3ROa0MrdWFma2tCSFRFdmdrQ2ozdnJ6SnBBc2NjQm8x?=
 =?utf-8?B?a0FqK21NbHI5anFDTHNGdHdNbzM3WTczcW1qQTZwM2RLeFpPaDdtd05yV251?=
 =?utf-8?B?bXZZL0tSY3h5bjg3R2x2clZYV3lXRnNrNmdyWmtPa0hlMnNOZW0zLzIvOS9y?=
 =?utf-8?B?UG5vVXk0MGFOTGhST01yU3JCWHVEKzkwNm1jUXlFTmJHS3hFelhFSWo0aXR0?=
 =?utf-8?B?bDNrRDE4NC9kem8yTUdqbmZ6aWlzUi8yV2lqcWxJR0ZrdVlZY0RPOWVwc0pw?=
 =?utf-8?B?ektoNnMvcHU5QWtDcC9FbTVBY0JnRHBjVzNEckJCQkdZalZPOVcrT3R0SVpm?=
 =?utf-8?B?aGIyZVg3eEU1czlueCtXd0VHUlZRYTZEYWVTRTZ1YzBXNkJ3bjltQTVUTUJG?=
 =?utf-8?B?Q1JveExVMnA4dS9hazI1NTg4bmRNVjdrWk52UlJWeTdiVGZsblNtYW1INU5t?=
 =?utf-8?B?SVQ4MHV5MDdGcFNIdEZXbndiQ0hpOTJzVkJETXBreExvbEtTRi83N2ZwU2Yv?=
 =?utf-8?B?TzFzWmo2OGR1WlBDR3dldEgybXJPTHdmeVZxRk9tcE5CVUprMGc1QjNNRmJ2?=
 =?utf-8?B?bkZGVGpuTldEcm9QcUxwZTJ2dmwyOFo5OExjamxOL3c3UnVYSTVkc25mWTBK?=
 =?utf-8?B?OXN4M1hyNTdWRVdpa2t6NXY1VHl6bEdUeVVNMWtnU1VEK3licFY0UzF0S21H?=
 =?utf-8?B?VWZzcTkra1AwTTZsZkhJTVAvYU9vYzFpbTBqbWIxMjJ3Y1dVNWs5dm1lUzRq?=
 =?utf-8?B?ckI2aXhHcFNFWWl1djY4QmlwZVkrMllEc01SL2cyUE9UMVA4TDNLM2NYa25V?=
 =?utf-8?B?cnN2YVMvc1dLOWFmZzQ5eUttYXVOVFJXMDh6VWczakY2ZnBGVTlrWlRpT3FM?=
 =?utf-8?B?SGoxY20yQ3c3RTY1d0dNckRHTlRuNWxya3Judm9uUnAvVmRaUWw4K29VdElD?=
 =?utf-8?B?bHppZ0hTNlVHZGVsYWtjMjhWTzkzcjdkRVhMQ3pzSVNrZEFkWnFFNnNVR3lO?=
 =?utf-8?B?Wm1LamcrV2RGVWNqcThndHJDUVF5VmREbWQwWVpnRVJRcHU1ZjZ6QzVSR0RW?=
 =?utf-8?B?bU0yc0d1WFF1RFR5V0FVdTJtY25SNUlxVy92SHBQaGIzQXUyNDY4YmRqU1dT?=
 =?utf-8?B?NDgyN29sOXBYK3FxVXRqNXJtVVl5VXVjL0pReUFidFpqQTVDcVdzYk1hS3U2?=
 =?utf-8?B?ajdBb3JzeFIrV1pOdWk0U2FhMFVWT1NpRDhvUURBaUR3MFdTL052Z3ZCWS91?=
 =?utf-8?B?V1lGWmFScFJEOXNXdUhZaUFqNXBkN2sxSDRiQUZSSElXSFd1Q2ovZ2pEL3FL?=
 =?utf-8?B?blhQeDdiUElGMitBSENHeER6K2l4RlBlWXYyOEMra3V2QURjTXFudVU0M1Ax?=
 =?utf-8?B?VU0xdWJIRzBka2xkbFRPdG84K3JDRnF6U2NnR1pZNFJyTGVha0o3dlRBZGJN?=
 =?utf-8?Q?ahXQlrO2EWZnbXC6VknCFLBHguAY9LbFjeRjYk9Mic=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531c93c6-fddb-41dd-aa02-08dcfabaf2a1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:20:02.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkAwgSUzJ5Yn6LlByTIig68+/pUU2o3QbwNsHshXVe9X/6r0cwSwv1U1RVaZsuBizp7tD1aH4SvWywgRhb0dXpyUej4u0DakIoI9Ny3EvNzDGdeHEekTr2vGXq5CU5xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6257


On 11/1/24 04:55, Jeremy Kerr wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
> Hi Adam,
>
> Thanks for the quick response. I think the dev lladdr is the main thing
> to work out here, and it's not something we can change that post-merge.
> I'm not yet  convinced on your current approach, but a few
> comments/queries that may help us get a consensus there, one way or the
> other:

Thanks so much for your review, and yes, this is one part of the code 
that commits us to a course of action, as it defines the userland  
interface.

>
>> We need a hardware address to create a socket without an EID in order
>> to know where we are sending the packets.
> Just to clarify that: for physical (ie, null-EID) addressing, you don't
> need the hardware address, you need:
>
>   1) the outgoing interface's ifindex; and
>   2) the hardware address of the *remote* endpoint, in whatever
>      format is appropriate for link type
>
> In cases where there is no hardware addressing in the tx packet (which
> looks to apply to PCC), (2) is empty.
>
> I understand that you're needing some mechanism for finding the correct
> ifindex, but I don't think using the device lladdr is the correct
> approach.
>
> We have this model already for mctp-over-serial, which is another
> point-to-point link type. MCTP-over-serial devices have no hardware
> address, as there is no hardware addressing in the packet format. In
> EID-less routing, it's up to the application to determine the ifindex,
> using whatever existing device-identification mechanism is suitable.

I'd like to avoid having a custom mechanism to find the right 
interface.  Agreed that this is really find 1) above: selecting the 
outgoing interface.  There is already an example of using the HW address 
in the interface:  the loopback has an address in it, for some reason.  
Probably because it is inherited from the Ethernet loopback.

>
>> The Hardware addressing is needed to be able to use the device in
>> point-to-point mode.  It is possible to have multiple devices at the
>> hardware level, and also to not use EID based routing.  Thus, the
>> kernel needs to expose which device is which.
> Yes, that's totally fine to expect find a specific device - but the
> device's hardware address is not the conventional place to do that.

True.  Typically, the hardware interface is linked to a physical device, 
and the operator know a-priori which network is plugged into that 
device.  Really, device selection is a collection of heuristics.

In our use case, we expect there to be two MCTP-PCC links available on a 
2 Socket System, one per socket.  The end user needs a way to know which 
device talks to which socket.  In the case of a single socket system, 
there should only be one.

However, there is no telling how this mechanism will be used in the 
future, and there may be MCTP-PCC enabled devices that are not bound to 
a CPU.

>
>> The Essential piece of information is the outbox, which identifies
>> which channel the message will be sent on.  The inbox is in the
>> hardware address as well as a confirmation of on which channel the
>> messages are expected to return.
> Those are the indices of the shared memory regions used for the
> transfer, right?

Correct.  And, strictly speaking, only the outbox index is in the 
message, but it is in there.

Technically we get the signature field in the first four bytes of the 
PCC Generic Comunications channel Shared memory region:

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#generic-communications-channel-shared-memory-region

"The PCC signature. The signature of a subspace is computed by a 
bitwise-or of the value 0x50434300 with the subspace ID. For example, 
subspace 3 has the signature 0x50434303."

So we could use that.  And it is sufficient to let the receiver know 
which channel sent the message, if there are  multiples:

>
>> In the future, it is possible to reuse channels and IRQs in
>> constrained situations, and the driver would then be able to deduce
>> from the packet which remote device sent it.
> The spec mentions:
>
>    A single PCC instance shall serve as a communication channel
>    between at most two MCTP capable entities
>
> so how is it ambiguous which remote device has sent a packet? Am I
> misinterpreting "channel" there?

Yes, the spec does  say that a single channel is only ever used for a 
single pair of communicators.  However, we have seen cases where 
interrupts  are used for more than just a single channel, and thus I 
don't want to assume that it will stay that way for ever:  pub-sub 
mechanisms are fairly common.  Thus, this address does not tell the 
receiver where it came from, and, more importantly where to send 
responses to.  Hence a push for a better addressing scheme.  There 
really is no reason a single channel cannot be used by multiple publishers.

> In which case, how does the driver RX path do that deduction? There is
> no hardware addressing information in the DSP0292 packet format.
>
>>   Instead, there is a portion of it on outgoing packets, and a
>> different portion on incoming packets.
>>
>> The hardware address format is in an upcoming version of the spec not
>> yet published.
> I can't really comment on non-published specs, but that looks more like
> identifiers for the tx/rx channel pair (ie., maps to a device
> identifier) rather than physical packet addressing data (ie., an
> interface lladdr). Happy to be corrected on that though!

In this case,  they really are the same thing:  the index of the channel 
is  used  to look up the rest of the information.  And the index of the 
outbox is  the address to send  the packet to, the index of the inbox is 
where the packet will be received.

One possibility is to do another revision that uses  the SIGNATURE as 
the HW address, with an understanding that if the signature changes, 
there will be a corresponding change in the HW address, and thus 
userland and kernel space will be kept in sync. This is an ugly format. 
The format suggested above is easier to parse and work with.


>
> Cheers,
>
>
> Jeremy

