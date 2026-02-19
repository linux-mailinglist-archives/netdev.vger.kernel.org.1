Return-Path: <netdev+bounces-259433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIvDDaLqlmkzrAIAu9opvQ
	(envelope-from <netdev+bounces-259433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:49:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C915DF8B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EED4E3003738
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED812E3387;
	Thu, 19 Feb 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wzh0IaG/"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC526D4F9;
	Thu, 19 Feb 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498141; cv=fail; b=RsH6RBVy96mgo+6CAauKnGbVOLetGV+IIZdmXIjOJ2f3cLLEft9HtuZFNfBsU0Q2O/6byo3WpctgfBPG26vZSyOfrGt8rDSoxTkAeMp7E5grY9XhOnoAO29X3coKVWM1ISq+YrA07aFwuxCFsUHYkSpDkYZGKDSOylKVTyetxsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498141; c=relaxed/simple;
	bh=daAvgZJTdwp9SstO7NASmI7Ae/6fKfGZnZm1S4riiRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEcw+BIFk1TsHDGgB64nXoenUilQkZ/YhXGF0cQr7p2CgTVFGAbNtp6AVX5HA/Zc1p7bYiCRzpY3+Z6gZ/6HCz2ZmDoXC0SogIxMtpC6joxkkdr0YG23VRXioDZrv484iAProh/8t+w0R8WfPRpkOsT24PFyFZutZo6fhKBDIX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wzh0IaG/; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOaNE042wjjYQOLlTLPVkV2B8vFV8DyyYaRgt9FbI1YleiKU0alixP9Hg5vfYqXFGtoXPT0f6nmnZPAyTcJuj+b44crjwQAu/uBKRrHrwxKDx5MsxCwONG3jWEI5Jjkc4KGSIRkvTEhz0Y3XCOKLIm/JaKo5mPuRzt6/g/sXpGsR4xGF+bJRRyT8XUo9Op+ADCZeWocRYfXO+WUp9RYYE8plS7RBpVnZSlMe42zAaqUR1UBf/O7RXCiWFhDbb8mpeFsx/Zb5MyII5Gvg12M4cRTmUGofgbnVPipqQXEZgfqd/eHuvPlmAnqvAZFAJ3CsQHFk0Dzw7PcLu1PB7/TBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAktBIr5UYFfD9Wbmls2Rmmeqlrg0QEIUDR96AFhg+s=;
 b=a+Bl8XVGvdLdVEPokCcXe7/bNyOI4HCDqk4kO6xf0Ly4TuXWaqAYHqHqYxFGd+CuNtgHZYruntnDo5b9A0dLjCAqxuUTxIpMjio0ENGr8JKglB0dc/zEilPlYFZSnNiSc2vWKiJhNLCHXuUL1VKj5QE2BjxbMYQ1kNHJxFm12gT359XGuvy98XUMHpKj9qtUk7gulutTqJEiIVjnam1P5tfycEFPf3Hy5bO+cuebd7YwVsGATWXOe22978S3VSSdcFaXtKjMRpNjQdl2vFDWAbQgdzyfWROonCeJeisHr2HCCuJTfJWGfydtwghWme9Fb0U5+2MdsvMJAH0fGxFb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAktBIr5UYFfD9Wbmls2Rmmeqlrg0QEIUDR96AFhg+s=;
 b=wzh0IaG/aQj6cD98y+J5vQVt9r7O962cXoNZixzNJy4o2XiWazXHbVADcJ5QBhQDzB3fTghzdiS+A2J3EhB8/dMAC6kLRNcFEc1g3wmWOWTSIfJu024FmoEN2Grk0qeJtHLB0yUYQ7b+80m5psikoARcc+XT0mFhqUKXo6RSg50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 10:48:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:48:57 +0000
Message-ID: <f1725a2d-8b94-4149-a49f-7ea8b40a5d59@amd.com>
Date: Thu, 19 Feb 2026 10:48:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 19/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-20-alejandro.lucero-palau@amd.com>
 <c7024d3a-36e4-4e7e-934c-46c7c26b43ba@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c7024d3a-36e4-4e7e-934c-46c7c26b43ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: adb57469-50b7-434f-e18f-08de6fa47b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEF3cllVRE52QWViazlyWnhMUTJ2WDNLelF6TUZxeVlHUTcxQjdUdHpDWXJx?=
 =?utf-8?B?Qm9RUnFlSjVjNFB0UTJCVVpXdkN2Yk5GOWx0Q0U5V3dHdWdrU3JTNEFjYWxQ?=
 =?utf-8?B?R2YvdnZLRkZrUjRjTEpDdlJPdm43bnRVTXNrSjRuZ2lFVzc3US9RV3c4VTNR?=
 =?utf-8?B?bjUyRmtHR1EwbkR3MU5pQWliaCtFMEpwY0ZVVWs0eklKNnQxaHlVQlhtYlhJ?=
 =?utf-8?B?Rk1McXo4M3h4K2NleDk4UTN6THUwQlJYellVOVQ3V295YlZuNDkyTHdUZlVL?=
 =?utf-8?B?RHRMVGdaRENjQTlINXN0WTY5cDdtRWY5bldXNmFGNTY4a0laUFlVQkFYeUdS?=
 =?utf-8?B?R2tLVDNpYml6cTdnNVorN3VaNlJTSHZmaHhrU1A5azcyMTd2WTRnejVuTDBS?=
 =?utf-8?B?Qm9yVkVvYThrdHlDdGVpNmdNOC94QTZPbWMzbEdmNC9yVENxMkR1Z216anJO?=
 =?utf-8?B?eFh5dS83cElWOWZ5UDFubWZoYWhlcXRMNW80aTIrYXc1REZycVJwemNLWVVH?=
 =?utf-8?B?aFFVMFA3YmJXVWN5OE9ybDl2V1NRNDVrZjFDUWJIY0FGQ3NRaUF1eWF6UDFz?=
 =?utf-8?B?alFiWjUycWhPSC9ZME1jM2F0anp1WVdzZFhGbEZFblRWd28vcnFwNzlXMmJo?=
 =?utf-8?B?MW1xYVQvMW9Xa0x4VnVSN1RQQnVPVENtVWRKVTdkb0hnRCtCWkNXYTlHbDBO?=
 =?utf-8?B?OExJZ1dHck1sajBWaWdtK2tJTlhuR2xiUWdsOUVSQytRMVYwclVWRWt0bDFX?=
 =?utf-8?B?NmM1aSsvbGJxMEU1NVptREdZT1A0RXQ5VktkN1VlZVRoSmZsenlkckNheXVa?=
 =?utf-8?B?ZDFNYTI1RWVuSEZVb3dDcll0UU16MnNxa3pwVWlVNXpWUlY4eTFUaXdibjMz?=
 =?utf-8?B?Wjg3SUhjRis3bWJLcVk4UHNKT2EwWHA5SktWZ2ozZVNxM0ZyTURuSUVSblpY?=
 =?utf-8?B?TStxVlRtU1ptclppVnN0Wlc2U3ora1VNUjl1S1RRMFdqcjh2czZRSzBYSVcr?=
 =?utf-8?B?WDg4c0tSZTczY3czSWtPOFNDNFhUUXpVc1QrTW8xVDhaWnEvam1UY3JKejVu?=
 =?utf-8?B?UVBnSTdOWXRKT0RmVUhiS25qMFhpeTdSTUdCOWg4Q3hHeElSbnJIL254Vmpx?=
 =?utf-8?B?UTZGeGY4VE14eGFURHVqaG1ia2ZPVU45NnBxa1YvNUpaSzUvQk1FQXgvTGlX?=
 =?utf-8?B?SWZjNjFtMVpkQ0p1VXdmS2FZRXVhR00zempLR2lkUkwza3l3aTQybldpL0ZZ?=
 =?utf-8?B?cTZ0bElaYXorKzFMZ3c3UWdVUzl2QnRQVGQxeWJUb2hjOTZ2bVVCNlVLUnFo?=
 =?utf-8?B?aC8rOHRDeUlQUlBkMklPcnROMjRJbTllOU5BZUVkbTRhWHFyb05VeFFMbFFh?=
 =?utf-8?B?NTRua0lBOHZCUndlY2c3QnM2VGZaazA1aTBRRzJMNWd6akhQOHh6dVNpYzlN?=
 =?utf-8?B?TXYyTnNqREU3RW04WWNzNDJZRjE5QkcxNGkyYW5paWdwVWJvWmROVlJ3bVha?=
 =?utf-8?B?R2xNUjljUE44Qk94b3pRNndST1pZZnZybURYaW4vQ3ZVSzVPRUZsSis3MFlK?=
 =?utf-8?B?MHZVTHpqYTJ0TERuMS84eXFJL21SZVQ1UTR0SmZYYVVUZUx6SDZBSlBMQVZ6?=
 =?utf-8?B?cldJOGZNb3V4b09kYTRlSUFkdW0wRFVEQWk0UTR2cmFwZ3RoOHFqMXpoWE5S?=
 =?utf-8?B?R2pVTDExN01KSW5OdGlXdGxOZ00xRHdtTSthWSttcW1FMllVeUllQlQ0dkhr?=
 =?utf-8?B?QUlCT1YzNEI3blFBaHZBcVFpR0R2dGduTDVtMDBERyswbDVhTWYwWVVPbXpB?=
 =?utf-8?B?ZzQ2UUlSZ05KakptQ2ZzQWFKMDdjb1lxOGROMTV2Y2tPczRGUkdyZDJyQUZk?=
 =?utf-8?B?UFMrRk0rSi81ZGVtMlQyZUdQeXZoelZHZ3hNb0VyY3Rsa1RnRXZQUVVsZ2JI?=
 =?utf-8?B?eHp4ZHUwQU41WEdMMUVnckxVR1ZNSTY0bkZnY1I1WmJXOXpoVlh3L2dmRHpy?=
 =?utf-8?B?ckVrZGNIcUl3aUNEbXE2ZnpOSXNST0xzZ0dpSjhFT3FyTVBWZVJ2c1d4b2xh?=
 =?utf-8?B?dTBMSXAwS1o0LzJQZzZEd3RIeUkvbDlQRmVrUnZhUllYWlFsdnpqbjFCWDBv?=
 =?utf-8?Q?uuGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1BBUEh5OUFBSnRhcE8rTlJXMnlDTTdoenRkWDBVN25UaitJaWJaYVppR254?=
 =?utf-8?B?WkRhbERrN3VzajdpTmQraTIzdlRsNHpKS3lUdjByU2V2NTVEbldRSTlMamRB?=
 =?utf-8?B?NnFkWStQVGhFWjFYMCt4Q0xzM1Y0NHdxR3MyR1oxMGJoYUlvekwwUWJRQkhw?=
 =?utf-8?B?bDVWSjNQcTBlRW95bWYxYWlaV2g0NkpNSlFDbUNpZFZkOW9zSURZTFgzVFdL?=
 =?utf-8?B?YWdNMVhUbDdEeHdxU3N6ZnFHb0ZtTGVteDNwa05IMGU2M09OZlJERDlOemxq?=
 =?utf-8?B?SHF1SWJKbnJGKy9pQUcyeGRwTkZ3REwyUHdYbzBUdXNRNng4VnRLUXRoVW1k?=
 =?utf-8?B?d2pBVVlTNkhLYXlFZENWa09kN2c1OU5DdFNTcVBjSmpQODVTUm53bHJneVJO?=
 =?utf-8?B?eUF0WlVMa0EvZjRjeHFOa3JwZFJGTWo2Wk03SmhoNjhaQzF1UjdXQ0o5d3VW?=
 =?utf-8?B?R3pDbGtYU256dE8vTmhnc3lZLzM5U0FrR1ZTQmh4bk9zOWN5U1ZZVkJvNy9M?=
 =?utf-8?B?TEhQakFCNTh6QVp0bTNsakhPa010MEJRcDN3K3BwYkdrSm14MDMrUXAvbmUx?=
 =?utf-8?B?ZzlWOTl4cDZtZllqUkc0SEZSU3piaFdreXNMdVdRaThHbEE4NkJPTGlCbHR6?=
 =?utf-8?B?QmxKZXl1SzRobzdjMmx5MXoxN1JvbWR4MEIwdDZOMEJQNlhEUUxFSnpPV3Rm?=
 =?utf-8?B?Z3A0bjAvcDRaSzRiQXJOcDJOcGc1SW1Eb216QjNURFpMUlRpaGJFTlEvWDZT?=
 =?utf-8?B?VGt3R0tMaDFaN2dwWUs0a3pSQlk0NG5GN0ZtWFhuWThqSG9Dd1VTNUxmU2RW?=
 =?utf-8?B?YXFoOE4xek9pQjd2UjJVYWhheGgvOFZkN0lpTERwcHlTV0FxNU9XNG5xZUJ1?=
 =?utf-8?B?WkhjZENmL1N0UEtHZkJGR2ZzU1M4cWVpVEpkdExVUVBtc0V4b1VxVUFXQTlB?=
 =?utf-8?B?SHMvenBXcU1UWWFsTVJpRmVzRTJTVUlTVTdRNXBqWjJPWFFML01KNlV6bk51?=
 =?utf-8?B?S0UxM2ZRaTduTFllWVZhS0piYnFMY0E2ZWh5bnJIT3Y5bi9CZFprY1lUaXdt?=
 =?utf-8?B?NDlNRlpTU2RaVUhUbFo3aThPVktaUE1iR3NZckdaaURLbnpWeERsUkxKSTZy?=
 =?utf-8?B?U3lXa2JMQ2dmai82MnJ4dTkwbTcwT3BxOVhhN3dyZTBhR2ZTckVYaDdzWmF5?=
 =?utf-8?B?QUdDY2s4ZGg2eEljMktpK3BNWjlhQ0RuTlhBNXc1eHZGNE1OYTFXcTNJbHlO?=
 =?utf-8?B?b01rcTl5cU5vZTEzMjhjZUFTaXdNTzJVSEZBRTdBbVlXa0FzYm1CNFVnT1F4?=
 =?utf-8?B?TTVOVUN5a1JLTS9CMW42WG9sczlrVUxLd0lOTjZvaE1DN0xtdkYwUEVDRENB?=
 =?utf-8?B?MUVKZDQyNDFSVzlWbExPMG9EZkhXRXErQjBxWEVvcWgvbGhyRWFRR2RmT3J6?=
 =?utf-8?B?Qk5SOVpYd3ZVNEdpYmpPQXZxb0NCRkw2NHFuVmtPVHc5TXc3bGJYVkhxK05N?=
 =?utf-8?B?dmY2bjNPRzYvZVBzNFlIREwwQ08zeE1hWVdSWXZ2L3p0WVZXNnNZS2MxSXE4?=
 =?utf-8?B?WTZEdDZoVndVQzJBTkZwaXZLd2dsaWdRRm5mYWNaQzdRU0I0by9VMTd6bkZk?=
 =?utf-8?B?UDJpYkhyMzZ6U1R2ekF5NDc4ZEJid2VnYTM0SXlZTWxoV2tUaDRmS3B0a3dI?=
 =?utf-8?B?U0pDV0lMRmkzbnE0clZyVEt6QU5KdzltSmlKN1hHVGZ2UWhCajYvWUJFU09s?=
 =?utf-8?B?SVYySnJpdzJjZFhoWTZpRitUN3l3S1hxdjNxT0VaOXpHckpoVlhtMFVKbU1m?=
 =?utf-8?B?TWRJMm56dHBZdUozSXNWSGtVZGlUb3lYRzlQL3huUmUycVMyNWZKRS9OMm11?=
 =?utf-8?B?TEFuZGh0eVovUG11dWhyejhiMnZHRGJxZnRMVHAzajZkelZBcFhuRmRLVmd1?=
 =?utf-8?B?alpmdGZVRk10eTJVNWRZN2R3L1dMWE51MWpadFdrSzM4T0hveUZGaDhEVXY0?=
 =?utf-8?B?Y3l5N3dIT0ZuRWw4TStZcU9Vdi9iY3lBd3JVaVdjQUlnK2FSK3B4Q3NrNlM0?=
 =?utf-8?B?S2FDZnpOUDFXTXJ5eW5CVUNrYld5dmpQK0E5YmtFTWQ5Z0JYWjRvVGhsY0d2?=
 =?utf-8?B?N2lsek9NMlZleC8zODRhV1pGUXY2dytDOGlHbDhTTHR0Ky9uQ3BRTHhKdDhj?=
 =?utf-8?B?SytXbE1ud3lzQ09TUllhRVJBM2owRUk1cllYOWRCTTFIaStaM2lNVmM2aU1u?=
 =?utf-8?B?NlNyQmJvU3dHOEdZOW44WnVjRTZFa0RPWmloTU1LSjdoeGJJK0lJNGFZMnNv?=
 =?utf-8?B?RXZyczNnUFRSaWVoam5xSklvNm1yYWVJK1VZb0ZXc2F6ZkJzVGJYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb57469-50b7-434f-e18f-08de6fa47b3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:48:57.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUoJkZi18+G8apBb47acRu1p4tu6Q9/q3aSxq0H6CfL3ils2ZL85amWOxlxrnX+kEazX3bD82vRP/IGkfjCaeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F0C915DF8B
X-Rspamd-Action: no action


On 2/11/26 22:11, Cheatham, Benjamin wrote:
> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 131 ++++++++++++++++++++++++++++++++++++--
>>   include/cxl/cxl.h         |   3 +
>>   2 files changed, 127 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 63c2aeb2ee1f..293e63dfef22 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2944,6 +2944,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, __unregister_region, cxlr);
>> +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -4047,14 +4055,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>   	return 0;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	int rc, part = READ_ONCE(cxled->part);
>> +	int part = READ_ONCE(cxled->part);
>>   	struct cxl_region *cxlr;
>>   
>>   	do {
>> @@ -4063,13 +4069,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   				       cxled->cxld.target_type);
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>> -	if (IS_ERR(cxlr)) {
>> +	if (IS_ERR(cxlr))
>>   		dev_err(cxlmd->dev.parent,
>>   			"%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>> +
>> +	return cxlr;
>> +}
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>>   		return cxlr;
>> -	}
>>   
>>   	rc = __construct_region(cxlr, cxlrd, cxled);
>>   	if (rc) {
>> @@ -4080,6 +4099,104 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	return cxlr;
>>   }
>>   
>> +DEFINE_FREE(cxl_region_drop, struct cxl_region *, if (_T) drop_region(_T))
> This needs to be "if (!IS_ERR_OR_NULL(_T) drop_region(_T)". If construct_region_begin() returns an
> error pointer, drop_region() will be called with it as of now leading to a garbage pointer deref.


That's true. I will fix it.


Thank you!


>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	int rc, i;
>> +
>> +	struct cxl_region *cxlr __free(cxl_region_drop) =
>> +		construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	guard(rwsem_write)(&cxl_rwsem.region);
>> +
>> +	/*
>> +	 * Sanity check. This should not happen with an accel driver handling
>> +	 * the region creation.
>> +	 */
>> +	p = &cxlr->params;
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s  unexpected region state\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>> +			__func__);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			if (!cxled[i]->dpa_res)
>> +				return ERR_PTR(-EINVAL);
>> +			size += resource_size(cxled[i]->dpa_res);
>> +		}
>> +
>> +		rc = alloc_hpa(cxlr, size);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +
>> +		for (i = 0; i < ways; i++) {
>> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
> Position parameter is hardcoded to 0. It should be set to i, right? This kind of goes back to my
> issues in patch 12/22; the interleaving functionality is there but it looks unused.
>
>> +			if (rc)
>> +				return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return no_free_ptr(cxlr);
>> +}
>> +
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoders with reserved DPA capacity
>> + * @ways: interleave ways required
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways)
>> +{
>> +	struct cxl_region *cxlr;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
>> +	mutex_unlock(&cxlrd->range_lock);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	return cxlr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>> +
>>   static struct cxl_region *
>>   cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>>   {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 4802371db00e..50acbd13bcf8 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -281,4 +281,7 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     enum cxl_partition_mode mode,
>>   					     resource_size_t alloc);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways);
>>   #endif /* __CXL_CXL_H__ */

