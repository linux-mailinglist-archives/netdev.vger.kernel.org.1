Return-Path: <netdev+bounces-142033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC49BD216
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB3D1C20EC3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C280415EFB9;
	Tue,  5 Nov 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lPxY+NQn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81213E3EF
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823405; cv=fail; b=mj6E8nGXs/udVB2Cckg6cxTOcdk2g2UC2kX0n30VhEGMjiGw0bth3RKh3Vbu2SnrcsY3tHy5mei2c+vtpyNjjGTgAQ3YHx70la7rLPOSKR8FpUSM4qTOXQ19BNjMNZaII5gJO+4FUmb8OD9xVl3AiEc66oBRqP02rxVKo0xOpTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823405; c=relaxed/simple;
	bh=qBmW7xUDuJ42y03m3m3JI99JIGFTJ5PpXMhl6aHXCiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kf0yh4qZnEsdKYJ2sjZwpK13yFRQSj2SxGnGgm3L6EJFEAfzJTSCaKWqdvwuFkb/rB+hMeWM+nsqkDPLLNrPDzJGoiHilOmBv0Re4V3JQalNGMaMSHiKMLvEAD77y2iQ64ed7PFjWXQWWgueV6LvBupouxe0ZVJBCaSlC7mMhkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lPxY+NQn; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdDgCXWgxQzvbmhFkEMi+i+SjV3kAEE8Z13kclxpqr2IaEEBZqoS/fPkJUQ1wcWD2nXkH5QPjTIeX0rzqjZtPPSRCNnaoc7I8Ezi2XiwbhxgwNNkbLWRTfktaoqs7KWnVP6ePqST6Ds3Nqycnz2Xj6u56uRHtYj8JLPDYVpdp6d5Jv6eeKZY0BfHUxYb3DA0iHMVDzbMF2aCOJVSQaXlot1Ns/fpU1FTfwX1XtgryQh6N7ca1QDVNDDKxxOXHlSsy/uEnoyBrIkUSh+OFTXdXefjNEmEoEp0mzN15b9zztNxP0QlQSxexzr+g8dmo15LXnAgeObC9pEsWMuCJ065NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww7lrA9nQHZrug+GIpq8AoDNY6LtXq+1/7C3Hqz+yQ0=;
 b=UXfl0jXnR35ptroP74Vn0737j/AQGbsuEkc8aCkLoYtsYQzYNvKxpUu61oCfgmfNJB6aegb30ascc35fElvkyIRQowHETPN5q5K4zG5l1PnWwbyXxR990ojGyESPkqmmETe21xrw60VfzB1AE1K9FcR3+gpcrrH7bvyN0ZS119QwnoFwkx2m3YpMOmvNI5Gt59A231HQqyMhkW2mi6Yz7jHliinklEV1TceBLagsRtOO6eQyNymoUaDhfCEaR40hjaeWSWtIODM9QG3xsHf9DIRnlVgm1CIjOOK5tekkKHxYzBL7YnpM+6lZ2O23SWjJV8R3Q8Sx0JXLFGBS/JLEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ww7lrA9nQHZrug+GIpq8AoDNY6LtXq+1/7C3Hqz+yQ0=;
 b=lPxY+NQn+pnV915OpItyhCprvMdMJ44dQF7GHO9myLuRkteotYXgfPINwMcOh51I7n5kMTlZY7m6xu7izD61yBTQSx8/+TBq4lMztggH3xFnTZNff+DDnPPWpzTpfL+jsB6f9MuSudR2i3+f4aATRE6FdZIIN/I27HgUM6jmlVsNJLIyOX3tgYSJmC5THdYfh3CYyvPsS2vfCr3Vh4J3H4xz1OiwI6J03G611DyTgR2XHnr7a+piim1eUoNkkn4LT3NW7tzBvkQel+qIJ5f2n8tQT8Ks2U21WVk3l89gLGVhn1+3vVBcxmpxfK5dy0JHDd4LwL/u0gMJMr3Z5hfOzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 16:16:36 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 16:16:36 +0000
Message-ID: <91932534-7309-4650-b4c8-1bfe61579b50@nvidia.com>
Date: Tue, 5 Nov 2024 18:16:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
To: "Arinzon, David" <darinzon@amazon.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Machnikowski, Maciek" <maciek@machnikowski.net>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20241103113140.275-1-darinzon@amazon.com>
 <20241103113140.275-4-darinzon@amazon.com>
 <20241104181722.4ee86665@kernel.org>
 <4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df51e46-3d15-4559-ef48-08dcfdb5386b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3N2ck5rYTFOVGZRYytwMURSVnNQbngwOFJ1YUdHSkd5MEJxYzcxTk8xdVJZ?=
 =?utf-8?B?LzFoVnpPUkhjdFpQRERQaXdRNVFBcytLUzZ1ekdiQmhOV1NYTW5CTElNckRk?=
 =?utf-8?B?dE1RZmJTcGFPTVFydFlrQnV4N0xCbnpONW0vekZydEFjQUZ1U0VxSG1BRkVo?=
 =?utf-8?B?MFdMQVk1L1JZRGJUU1QrS3dlMWpMUGhERGhTZEZidGFuT21MTldCcHRaVHJ0?=
 =?utf-8?B?b3NPZERtNG1pS2xXSlBDWFJiUlJnM0szL3JiYjB4NVBZQVAyc01PVnFpbUV2?=
 =?utf-8?B?WFQ4M2MxTGxBL3gwVWFETEdmR2xLT3FIdStaV3RYaVA4YjZNMEF3SEpRa0dx?=
 =?utf-8?B?M0d0b3RlT0RnZkhmakE5aGd5VTdiOU5ibEtPZjhIaEp6YnRma0tIQkpDNWhy?=
 =?utf-8?B?VTdDZ1R0K2ZDVDloZGlmcmxnOHREMThoSHNiUzFLeFp5YmtteGZNbGtqT0tL?=
 =?utf-8?B?MFFDclZ2YUdxWG45am9yTDZlcnJCZ0ErckNBbW1ET3QzOHJQYkdyNUtsWndv?=
 =?utf-8?B?Mmt0WkpHcDFocWRGMjdQT3ZPUHBBcEd1bEliYXVHSFRtdGhXb2ZmeTVvNXYz?=
 =?utf-8?B?aFRCaXhnV1RYY0tpY29zT2Y5Z2JzYW9zRU5VK01HLzZQakM5RkxaSFZOMmp1?=
 =?utf-8?B?K1lucGhxSDU4b25PeDBhR01sMURYcFBTeFdFbDNLdUwrQU5ZanhkcDRFNDdx?=
 =?utf-8?B?MzhUZmUwUStjNDU0alMyOHM4azgwbHJNajdZamQ4RER3byt0NTZqcUJKdlJH?=
 =?utf-8?B?ODRBRmVEajNFR1JRRmdtZkRCZEoxaEkwQzNmYkRpRXFMbFZuaGJBQVJvV2Jt?=
 =?utf-8?B?ajBhMnRZUlQ2c1ZrQkR0c0FGSTlRQ09zOHNjS3ZET2ZEZk54ZDZGWFFwa2I0?=
 =?utf-8?B?cGo4V3prN0xvbGdXaGxRVlNJbXM2TnVuSy94VXkyd045TW5ocTJ3anMvY01j?=
 =?utf-8?B?UXNxNEgwbGJWWmdpY0N4Z3p3UTJ0ajQyaVI2TVdGOGNtVWdFeVZoOHVTRXZ6?=
 =?utf-8?B?YVRkcjNoVmhUYUphSzRNd1Y2L3FjWml2eEM5d0VzT1VDWEpRckRnRTllVXNv?=
 =?utf-8?B?ZGVqT3FkRUJGQXRvdHZiWHdvcXRRZFpiVG16eVRDY3Y4YlhUbFJqSXJlVzJz?=
 =?utf-8?B?SjRwT0psZUwyWklsRlBPT0xWcklySlVrQjZSNFlGenBCRnRlRWViNkVOYkpD?=
 =?utf-8?B?a2VGUEJhTTRoUjg1NVl4VEszcDF4R0tnTzJ2OWpmdmlyT3NQU2VpMGl4a200?=
 =?utf-8?B?Z1NKK1l5L3IwV3o0THNxVFIvYVFxUFFGN09UVGYzUWNheDNHb2oyVURXUFVF?=
 =?utf-8?B?MlhzUWRGcFp2dklIUmw0MUo0M2dhb2R4OXJ6MkZsMUh5aWhPMUhwbUF6NEpE?=
 =?utf-8?B?TGo5eGJzcDlwMkN0WklMM0ROUU13WkF3UG5xdjFBOXZjTFVRQkpXcmhqSjFj?=
 =?utf-8?B?cGpqTkc0Mm1hNGdCVDZUTUw5SXloYmpValpaTlRZY1ZDSzl4RGRjTzU0d2Mv?=
 =?utf-8?B?V21sZzlITlBQYzQ3c0cvR0FQUU9xQUhzZm85ZkRuUWZLS2ZtOUo3dFBMcTU5?=
 =?utf-8?B?SVAzY3M5VHc3Q2JPdlk5UzhaazFPRTRzcEVhemFnajdrY2hrTXJ4ZTYycGZi?=
 =?utf-8?B?ZnBVOTB2RnRleXc5RUp5Q3Y4RUVpdnNTVUtRbXV5WGRtUGl1dHkvMWhDcmk3?=
 =?utf-8?B?UFZWNTZqelhWQXVDZTVWQVUrMXF1cWtObEJrN2V6d2F0dzUzcUlMakk3Nk5i?=
 =?utf-8?Q?f5GYYv90fZFmWKaVpMEenaWMe2ECcf8D+7CbJRE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VBSTFCTmQxaktYb2RjR0lzbEtTWDZpL3hxUHU2bjN0TDhPWTcxd2dzQVph?=
 =?utf-8?B?TFA0NFhlT2FUQ1NXUngyU3FMVk44d3JtaDM4dEZJUnZyS3hFeVRmTkhMdjN6?=
 =?utf-8?B?Nk9sVnlnUW9idkFxUWk5OGRwcDNwaGo2VWM4d2xMRFpud2ZuRjYwTm1VWmRJ?=
 =?utf-8?B?c2toMjQ5WFZzR0d4TEJ4S2oyWk45bjFwa0t3WDVSSktxa1pETytnUUFoWDBt?=
 =?utf-8?B?MGpVSmxTVEppU2Z4c1puY3R1RDZSZUNreUxWeC9wV0VNZllvUXhiRzdxc1RO?=
 =?utf-8?B?TC9kUFpxZ3l5K2hkYXdQcEJqcWp4dXY1bGhmUjNxTm9weENKdGo4andEb2Zy?=
 =?utf-8?B?SEVnYTFxTGVhcDVDWS9USFhWVnR0Z2lMaWo3MHBFNVVEL2NqNjhNUUIzNGNp?=
 =?utf-8?B?TjFCcEhlM2w0MEtBNXFOT0J0S0lMY09VMFdlWVhaV2VHL01DYjkxZ215c29l?=
 =?utf-8?B?UXlmUzQzODM4Y2tFbWlmaHlnZ01GVEt1cFhLTmhWdTQ0b0tZRGNyY1lIZVM2?=
 =?utf-8?B?d3JLWlJkR1RPVVZzTXA0SWZjSEtRaUhTRlQxeUdNNWdzdm1WamYxbndyL1Qx?=
 =?utf-8?B?dUxjNkdLYjdtY1pDNFptR1NZNzVBa05zdWw1YVNpTVBmOW12U3poNlR4anlC?=
 =?utf-8?B?NnM1VHJUTmh6TlFuWE54ZWM1UnpRT2VTc0pDaElxRE11cVlkckZsd09zOFVC?=
 =?utf-8?B?WDRsMG8yS09qcnB5VXBIak5iOXJ5YlRySTNJQ3JjZ3ZuNmlRY21OSjZoSEtZ?=
 =?utf-8?B?cWlzNHYvQ05OaVpKcHFRSTRhVkdzc2ZXTlg5WmlJV3NYVjJBbllTR0ZMSElo?=
 =?utf-8?B?OGJkZmx3bEx4MHdRSG1sUHQ2MzQyMURsZFhJQVZ5NDlhd2pTaFlIdlJrdGdP?=
 =?utf-8?B?ek5aTFk3ZWYrUHF3aTZqSHBZZFBZWFlDT2hrUVFBeFY0cGZkZjZseHpna21i?=
 =?utf-8?B?c0d0TjlHaVQ5NE1CbTMydDB2UlZLb3JwZk1pQm14R3NVY25yWlBtSXgwMTcx?=
 =?utf-8?B?MVRyZlFKT1dpNEU3MnRKVWlkNjg2bFd6NWNQVUdaSUtwZFI4VFZPd3BXN0dH?=
 =?utf-8?B?YjJFYTdIVEhEL3FqemZPcVVLdkh4MTFFOVN0NytncWJuWU14NFdEZWN1eGh6?=
 =?utf-8?B?azNWUmtNY203OUJVTksxMmdCWVlwTHNhN0tUTGN1TFU4ZHJoaURjbXYxQ3o3?=
 =?utf-8?B?c1p2eVpxNHlQZFZ4ZGdIalc4VHl5WmpadCtBV3ljbGhFTHYySHlvYW1LZEln?=
 =?utf-8?B?Y3VYMGhHcS9xeFovaS9XeWpvV09oTm9kVXdsSUFGTmFGT1ZsdEZPUFFLcktY?=
 =?utf-8?B?UFptSVY1T01idzRCdGtFZjdhR2k5Ulg3MlN1eFlPQmFHbHFBQkcydmxBU1Jp?=
 =?utf-8?B?Tkp6ZWNCeW03ekd5Sng3OGxYUVZSQkRORE5ybWNlV1A4QXhJRDJyVlZhNGR6?=
 =?utf-8?B?djdXZ0ZKNFVFVENnaDZOUlZsMzBKMzZWV0FJSE5xQi9UMTJlVWhUUXdlV3kr?=
 =?utf-8?B?UENFcjFkTDJMa1pidzRORnlkczNmdzJ2bXFkUVk4aWpoTnRQclExYm5hNkQ3?=
 =?utf-8?B?czNVMms5ZDlycCt0dVBLUlZZK01uWC83ZG0wbjhPUVlkUldGblJiVnZ3Q041?=
 =?utf-8?B?VnY1K0dZRVd5TXB3dG1GMVhhaksrOHdOTThjREplZE5Sa0Y5S0d1MjAvT1NZ?=
 =?utf-8?B?V09IV0tPWjZoaWxCTnZkZGtSK1VhZEpVK21XV1g1dC9aYy96THFhbXFSOVBP?=
 =?utf-8?B?SmhzT0RlUHkzWFRtQ01JK0NjaVFXUEhVNDZZLzE4OGtCVEtvUHZjNy9uV1pa?=
 =?utf-8?B?dXEwUmFtUktGMVo4cGlSeVlJNGoxYjM5QTdWeWFWZjc0bHkzeDFBZXNITFFC?=
 =?utf-8?B?VDhySkxMa3lOUXZ4akxaUjluZExuajBlb0ZVL3hPYVRUY1B5K0lnZVY0Mzhh?=
 =?utf-8?B?bjhmNUgxTGtmWlZ5Zks0TStRZW9nMEFkaVVUa3JaODRNOHlHdk1tRmxJMnp1?=
 =?utf-8?B?bjB0UVZTajdscWZJWWdJWURnNkF4RjZhY0syWHlpUXFmdy84OWxkZEl4aDZn?=
 =?utf-8?B?QlVXSFZhZVFDTDVvaHF6VXFzSFU3MmtOaFBpTXZ5cnp3UGpkWWxzamJTcnRz?=
 =?utf-8?Q?1Vfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df51e46-3d15-4559-ef48-08dcfdb5386b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 16:16:36.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jys58t9xABUwpi0CLxKFCV/MqyZZ2vDzopmmnruEoTg+mz4yeGJSVE1V5FUiWf/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

On 05/11/2024 12:52, Arinzon, David wrote:
>>> +=================
>> ======================================================
>>> +**phc_cnt**         Number of successful retrieved timestamps (below
>> expire timeout).
>>> +**phc_exp**         Number of expired retrieved timestamps (above
>> expire timeout).
>>> +**phc_skp**         Number of skipped get time attempts (during block
>> period).
>>> +**phc_err**         Number of failed get time attempts (entering into block
>> state).
>>> +=================
>> ======================================================
>>
>> I seem to recall we had an unpleasant conversation about using standard
>> stats recently. Please tell me where you looked to check if Linux has standard
>> stats for packet timestamping. We need to add the right info there.
>> --
>> pw-bot: cr
> 
> Hi Jakub,
> 
> Just wanted to clarify that this feature and the associated documentation are specifically intended for reading a HW timestamp,
> not for TX/RX packet timestamping.
> We reviewed similar drivers that support HW timestamping via `gettime64` and `gettimex64` APIs,
> and we couldn't identify any that capture or report statistics related to reading a HW timestamp.
> Let us know if further details would be helpful.

David, did you consider Rahul's recent timestamping stats API?
0e9c127729be ("ethtool: add interface to read Tx hardware timestamping
statistics")

