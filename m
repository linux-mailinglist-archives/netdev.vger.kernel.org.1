Return-Path: <netdev+bounces-208023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B024DB09675
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E7B7B33D6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269323373B;
	Thu, 17 Jul 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="n5kZ7qU0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2093.outbound.protection.outlook.com [40.107.94.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2EA224AEB;
	Thu, 17 Jul 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788600; cv=fail; b=kBNKBNGeyyjF6FcTZ54JF+bExCe4GoAJXrM1wudEKo/TwaqL3WHqOilKn56rlrvzTW9RlMUgkOd8yr8nYLf9tAkdRasq2i7j3i6OpsGYZvPmnCxPaa/1JP10TkGKL0Q+PuRhEdi3OTaJ88ePUA8uY/FFByI3mYY0VV+Q2YDfiDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788600; c=relaxed/simple;
	bh=iWrgV0UoP1l59m3ZgGgj5njkryPG+u4z/dKNpPZG2bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E3lFxh3GMK0jeqaXfDxxgbMGtAS6iU241vMrv/8+uTwi3oTlvpZvK76xoGa+iUVBAHC4dd1JWgRzE+b03tGKK/EwSWjukJ3EAF5Y2K2V85wURAR3uK60YkyiSHHS9Y9WYIV6C/y3/GeJAjgVsaJ9SZbojNxzMrgvS/myhPnPMgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=n5kZ7qU0 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8qnngKmdSvkW+Iq4DcLoxIZJZQ0B0P2M32Cn1Mt25JR/opCOKLiGERfPzZAFYEx/iHbC4RCCD1k+BGeOmrm0LrKTphrB/CMOeFWhHVi48fy8t6j27h7mtOQiBF8A02QlSxMsec8pqx3dwR/Gui+0AjTo3sBskHDb36wY8IQ0sxXJwqcFLo2OeT1RH2t3QXdx89aq8Skyc7ocKWHfqEEQltsFySv4lqPN1Oj5QZ89I0M6aBjesVWy2XQVoVPdXTXhZE9AuqBAaArArEjv8c0Wa4Y55ws2/JIyXkJhzxHZEkccIv3Jfmlg6FuwINlw43G4gCFf9GbpIDHPvl+7181dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb0PNyK8sh20Zy83gilANayF/puRhnZby9yFUBt3CIA=;
 b=P1aK4LLp71kC7z1xWha9dyAHBH67SOpCOVtO5TiXAa2/gFzzFQyjQGyYSgrTOnn0k4nS+ZEiDRM7E4eUaUJAGFMzSEdvcg9sCGwfgzEOMxqRudAtraKLMQ+NjGS+Et0LaJ4S1x56ipqsXvKKyh7yTyWeY0yfvofCItR7EBcdAR1wx/S2kUEUl+3j+mCXxKe6BCxGQa7ClQSCdfeqPwVs9xVWWMNvPrPdzorKytQinY5Zj3diyeGAMmmDE8NsnCKnMROzDdkb/wkRxHTsvTdURhmer4ZG0tatfbLpgKg44AFDqanExk+PWyo3HbudTcfR0s11SGh6eFPKFM6DnWTKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb0PNyK8sh20Zy83gilANayF/puRhnZby9yFUBt3CIA=;
 b=n5kZ7qU0u453+3bUZhDsWRhqvVoQnP8Y+3aP/SSB7Qce31kedjEN8ZI35LQUsukhad2+UgX/LKzWU/SsN1t6+or4YIY8LUIolj+zRFABbw8jHBfn2XzmWTrX1jWnYEYaKFFmOrIAoK1Mt/JJZoYW3ED2f1R4CAl7RVmHLQvWxvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA6PR01MB8781.prod.exchangelabs.com (2603:10b6:806:431::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 21:43:14 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 21:43:14 +0000
Message-ID: <e1314a38-5350-41cb-9ffa-82617eff67be@amperemail.onmicrosoft.com>
Date: Thu, 17 Jul 2025 17:43:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
To: YH Chung <yh_chung@aspeedtech.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,
 "matt@codeconstruct.com.au" <matt@codeconstruct.com.au>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 BMC-SW <BMC-SW@aspeedtech.com>
Cc: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
 <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <SEZPR06MB5763125EBCAAA4F0C14C939E9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA6PR01MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: e933a9bb-a9bb-4bad-00a9-08ddc57aeed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVp6SHhNTUJvSW80dmZwQndtbmd5bHF0OWJqc2lZUklyYXdEc2xpVFYwL0lZ?=
 =?utf-8?B?WW1pOEhpMXhtOFQ1NHJWZjNvTWhvMHVVQTNXSGlBcHovMTRVL0d4MU53MThW?=
 =?utf-8?B?VlREUzU3d2ZGNXprSDJTNEEvd29FRDJaTlN1UVRwTk1PNlhWSFBTc21ndngy?=
 =?utf-8?B?SzNaS01HMUs4NFl5dko1eFR6NjJ5RyszTVlub2paWFNlbnpjRXIvOUFabmI4?=
 =?utf-8?B?RnRuT0U3UWZ3SGpBZFcycU5UVFJBRVo2aUxGMzlvYUorWjFSODBYWWo3OGlQ?=
 =?utf-8?B?MUEzaVdiZ05PUmFNdDdPZVdWMUhRRHRYTzhjbzJ0VlY2L2NBN080NmV1VXVh?=
 =?utf-8?B?QXd4THVZdDNiMWl5d3Z1bHhhMzVNbU1pZ3FkUHgvNklrbGZUZXNCZUxJRFBu?=
 =?utf-8?B?aVZSeURnOEtQeGN1emt2MG1rYzFuY0wraVdXb1BGT0ZvenRBdzZZTWxzc3J3?=
 =?utf-8?B?angxNVNYN2pYLzhjcjZ5MzRnVkZZQWpFQTNqc0E0TjNuSnRBQVVKU0ZhQm81?=
 =?utf-8?B?Z0FJTGRTRE8wQzEzZXJ2cnZaMmNzWDlQcS9kek1nTVkwemJHaXNUV3krcHFv?=
 =?utf-8?B?dHU4WGFqbTRYV3ZpUHNVVVZHUXlpYTRuVGswNTFERTMyTUFyMzNJNk1iUjYr?=
 =?utf-8?B?SEdaendYNDNpTlkzVkxvU09Kd2IvRVJsTENSQUs5OU41bDhWQTN4ZXp3bnV6?=
 =?utf-8?B?OVhBd2ZKbGVSNW9LVWh5Q1AzaWhKY3cydjFzcWdEY0liQkFHYXZaSW9ZeTlt?=
 =?utf-8?B?S0xuVE5VYldwa3NZaTFhdWtoQWE0Um1RdTRkS0pqODZCNUFBbGthalRacnNs?=
 =?utf-8?B?TTlYOWZHNEtrV2tZOUdlOHhjQnd6eDJLbjdwMUZsU2pHMUNoQnV4WWE3Kzha?=
 =?utf-8?B?WGVjRmhzSE1EZ2hxbzNIUjl3aGxSRzIwZXFqeTBQMWV2ZlpjTmM0QzVVL3pi?=
 =?utf-8?B?a0h4NTgwRUtWQ0ZMOFlpaEZkMG0ySU1lRnZLbSttOExHeUJOS0xXL3FrRy95?=
 =?utf-8?B?SDB3aWZoOG5FYTQyTGRWUDJNSkxTY0dCd3hXSTJ6UEwrZm5tTkNMU3VmakhU?=
 =?utf-8?B?S2cwaHUyd3Z4d3FINmFFZHJGR3FYWUoxK1R6U1N1QmlrKy9mYnk5NXNwaFI1?=
 =?utf-8?B?cVM2VEFjeVZlcVdDcDdBWnI2Ky94WTNoQzdOdzg0elRwL0cyWTZlZUY2Uk9M?=
 =?utf-8?B?cm15RGJZTmVWZ1UwNG5IUTdIRnBycEpYbGtQT2tQQzMvYisvemNvcGd5REx1?=
 =?utf-8?B?eFVLSDRlUGlqZjBSZ1BZUHE3UG1vOHUyR00zZ292Q2JDWFBvYmQ0V3Z3Mnk2?=
 =?utf-8?B?ckxBMjV3eUpkaTN0UkhSQmR1TUNtREp3Z3U0U3hjZmoyUkE4bVNJNHNZdG1X?=
 =?utf-8?B?T0tLelprZlRTMnJIa1krc01udFpvVVh2bnoydWRDbmRQaTBldE1RK1VkenBj?=
 =?utf-8?B?RXZXS0xocUY5d0NzdlBTOFZFMFB2NDlESFVyQ21qTmVWSkp1SnZNY3JtZWFP?=
 =?utf-8?B?a29oaEFyUWEwRG5VQW1qVlAwQURqZUpQUWpLNjBVV1FwVi91dlQrNjRSdVB5?=
 =?utf-8?B?WkgweWxuVWlOV1V4QXdrSkF4MmdmT291QnhWalpFU3NnRXArZ2hVcEYwSTNK?=
 =?utf-8?B?V1VwZnVzRllqcmVBY0ZRc1dZWkY1UytQc2c5VXJDcFpQZXZ2eUFEdlhWeWR5?=
 =?utf-8?B?U1NjeWxHRGM5aEh0SXJQMEdFL21qa1h1NkwvbnJaUUhyUkQyQm5VcFZaT2ZK?=
 =?utf-8?B?UE12andsMDhub0dhaTUzQmFGU1lCN2prL01rbGFpdFhpYmw2UWFOY2p2NGNC?=
 =?utf-8?B?dmU5dmx5cE1XMWNaSThjelNnOGZYMEJaclhDSVVkY0pCYk9weFN3R1RuZThp?=
 =?utf-8?B?QjBPOE11d3BLS3Zydjl0WStGYjN4ZFpnYXdMdkVFbGp2RVVGS1ZRVUxlRUxP?=
 =?utf-8?B?QkRXTENPT3E5cmRpd2tmckxUdzYxSTdhb051bzdBVUlmS3VBQU5TOXdNV1kz?=
 =?utf-8?B?N0VkcU5ONG13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW1WcGhUbi9yczl2clNEWlFnaWdlVC9TQTYyMk9taUEyNDQ5WjVob2NxYVdx?=
 =?utf-8?B?TVlZZG90c0NXY2Rhc0hRVmNDdjNhdWVSTTh6aWhBUzA0V05PSzlkeWlpclNl?=
 =?utf-8?B?cEw0Y1pub1JOem9zMExKK1pHeWk5UHBTZHliRXB1a0djVUF4eWdrYTNnMEt6?=
 =?utf-8?B?M3ZQVktBVXNUbDJhZlVlTkRneS9VWW52U050a250cndyRzRuTENsOVVjcTdk?=
 =?utf-8?B?RmlXQnlCemh0SEZwRnFoZXhTVWRQYkFUTzNtY2VscHQ0d3R3TE9BbWF2bC9w?=
 =?utf-8?B?clFsVlkvVmEvRk1JWmtmNkJ3cFg2U2kxSlJhMXBHK2FLTHVrU1JJdU84c2pR?=
 =?utf-8?B?SjlwUm1EUkhjR0lRWS9JVm1xd1R3SVRqOWxBeU9XY1RSeW02cE1NTmtFYVV6?=
 =?utf-8?B?NnZnY2FEcFc1eWUxKy9mZ0p6NHl6cmlxaktMbWphanNkNEZ4U3AzZGp0Mmhp?=
 =?utf-8?B?NTBjTHN5d0p2Y1lSbHQxQjU4NFVFb1lQVHVwc21QU1VhSEpEaEx1ais2V01F?=
 =?utf-8?B?bjFaV01BVmkwamZjUWJpOVlSWnJvZVVMU2xEa1BPYTIzRHlpdTVFeE9jU1hP?=
 =?utf-8?B?VGUvOFZxeVhnREwrcnlTQ1UranFzSEE1UWpIcVNkMXdVd0JZZkhDM2JEUDdy?=
 =?utf-8?B?K0haNGM3NVREaFRxb1YwNm42allTeFBOMmQzcUZtMGx0OVUxUHpUM0x6R2Na?=
 =?utf-8?B?RVJyQnhNY0VHL0hRZStoMEowZXdCWTZiVXM2Z0tvbC9FMVc0L2FNUFFsSEk4?=
 =?utf-8?B?OTd6SFlRSjFFeGQ5QnlJUlV0anVENjROWFZpcEdVZzBYUnVhMjJJS2lQWUVC?=
 =?utf-8?B?NmQwMDA2U0Z4eDMvZHFMYWVKRTRodnF3dVZjcHRWUEoyY3BuQ3JRZ2JtblN1?=
 =?utf-8?B?MTlLTlV3MzE1OCtEQ2h2d2lkUGtVTTJvR0VjaUJReHVQcmRrUzA0Rkl0SnY2?=
 =?utf-8?B?cEEzNGpjdGU4ODl4TDk1dDN0NThPb3FyN0JxN28ybDBCNEZucTk4YVhJQVJk?=
 =?utf-8?B?WlBnRHRuelNPYWZrNHNyQ2pZbi9XUmVqRFNoTmhVMlI0eXlIMFJ4WWJwNmMw?=
 =?utf-8?B?WnlKd25LS3YyWGNiSUV5ZHB5THc4N2N6RmEwdkhrMEdxVGRwclcxVXBZZTZI?=
 =?utf-8?B?VHI3V1E2a0pYaGtsb09SVjMyS0xBbDNYSjVUUmNkSmg0U2UwUjIrUnA4ZFRY?=
 =?utf-8?B?SDdEZUtiOVU0cG5SaStDdkpZczNNcndxNXgxMlR5QVhRWEo1dVJiNSt4dXdm?=
 =?utf-8?B?T2E0d3U0YlppMGg0VGdPZENiNFNLR1JxU0pJZlozcUUvRGw5cVpmY2ZyeDNn?=
 =?utf-8?B?RlJ3NWtQbVBzeGNaVXZLa3BFNDlTTXpyUlhXdTJXNFVxUEdOcU0ybXBrdXdp?=
 =?utf-8?B?eGIzSWlLM1VXTXpHUzJka0dZTHBOcFFDOGh0ekYrRjV3SmZpMTd5M2Z1RlJE?=
 =?utf-8?B?OE05eVJ5Ny9tdkxHS0dSWDc3bkl4dnk3VVV5SWk3cEI4SVF0MkRLUHVmakhi?=
 =?utf-8?B?RW9XTzAxU2hqNEZ6OXhWdzJSL241VHMzb1dMSWFWQnpoT3Y3RWRreUhBZWpP?=
 =?utf-8?B?U3hKK3RlRTY4TWFJZk9jMXhpUXZPam9xVVAycTZpNkIwL0FqT1ZJYXg1MjQv?=
 =?utf-8?B?Vzl6VWtWa2RHVEFwM3pwdlAraktEQldJZkxlandQMmFYK3pZQ2FqME9UbHds?=
 =?utf-8?B?YUxtL2JFWUlWRGloNktVWmg1YUVOdnF5OE14Wko2RHJoL1M2VGRpdjlsQUoy?=
 =?utf-8?B?UWNoWjVjUno5L0Y5dmp2Nm5FMkszSytyL293UlAwWXAzVVY2Z2Y0V0FqNHRQ?=
 =?utf-8?B?MlpUczRGZy9iQTJBaTJGUEdyU2J2Q2o4V0FZd3RENFlsY3RwT3QyMDR6RTJo?=
 =?utf-8?B?czNRMzdDL0dwVFlNSklIdHdoNUNBN2Y2YmswT2xnU1ViK0VJZzQ2K2JoUU5v?=
 =?utf-8?B?b0tmTVM4dG9oSUE4akoyQTlLQ3dXb3lpd0s1a3JBUUxHNlphaFlYbTh2dEVZ?=
 =?utf-8?B?dGRRL0VUMUk2SEtDYnF1R2RhYjY4WnN0NjlVRm1xc01yTk43bU5tYWFvWFVQ?=
 =?utf-8?B?elAxMWJPSmVxZmhqYWVWYXRDNmJXcnp3Y0svRTlBbWRiblBLS0ZjT0Z6OHd6?=
 =?utf-8?B?Q3owSXZZYVRuaHhlSFlubVRwYWwzcm1uQTd3MFM5VVRGTzRKQ1c0WW9mUDdR?=
 =?utf-8?B?dXBDN3Erc2xCRlE4Z2JZQVZDZ3RPSzZGOWF6Z3VMRjBqUzdMQW9WWXhtVmMr?=
 =?utf-8?Q?xwaAi+/uI67S0InMImuE9yicdwZcTZogLPWw9Y48q0=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e933a9bb-a9bb-4bad-00a9-08ddc57aeed4
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 21:43:14.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4UeFiLLjijsiXvNig3cD/JNHUjsj1eqCzTFZAUW3maXivOGMX9REZQHjaKvd78lImi1MRkvlFpFFZUIGJuCju9NTOjYcS9Xw3rYhyEjTC35xz4+GS4v5KruBPX2JkMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8781


On 7/17/25 03:17, YH Chung wrote:
>  From my perspective, the other MCTP transport drivers do make use of abstraction layers that already exist in the kernel tree. For example, mctp-i3c uses i3c_device_do_priv_xfers(), which ultimately invokes operations registered by the underlying I3C driver. This is effectively an abstraction layer handling the hardware-specific details of TX packet transmission.
>
> In our case, there is no standard interface—like those for I2C/I3C—that serves PCIe VDM. So, the proposed driver tries to introduce a unified interface, defined in mctp-pcie-vdm.h, to provide a reusable interface that allows developers to focus on hardware-specific implementation without needing to duplicate or rework the transport binding logic each time.
>
> Could you kindly share your thoughts or guidance on how the abstraction model used in our PCIe VDM driver compares to the existing abstractions used in I2C/I3C transport implementations?


Would the mailbox abstraction work for this?  It is what I am using in 
the MCTP over PCC code.  Perhaps a PCIe VDM mailbox implementation will 
have a wider use  than just MCTP.


