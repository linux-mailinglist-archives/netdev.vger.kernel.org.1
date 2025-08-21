Return-Path: <netdev+bounces-215761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F02B30259
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771D4AA5979
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9EC345732;
	Thu, 21 Aug 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z/1ug7o1"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731B343D9B;
	Thu, 21 Aug 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802410; cv=fail; b=PM/l1MAphgTsDUgd54iT3cyHDTgt7jiMGxEs6Nx4yqBtcO67BXBzNOKMEg95jgTeCaBLPX4AVH8axAOF1psemA3s/+mPJSEHsYAPrv7O2ByfKgSorU/xyU19UMyu06Xeq7GecGsOvKDmSCLds9JpQHL+H2H6S2Sha08oZCUq0C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802410; c=relaxed/simple;
	bh=zxSiDqmMTsH97VHslEIvSS0hKArFRts8VgguWzoB/O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kew8EsDLr0/x2jF5mRMOOi3KYjl0vChF+Rl68yCwHtFeHCfJm/fnlxrI8qppsQZmwd2ljLGCPYlBXt5eAVpdu//O0pTEpg0sgHrsCy29SNRnbcwyPiPhVsmN10ONhhjPlj5Y6fG4+cpunlWOWAkCQekn5QUSQfKV0zsVT6K6UE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z/1ug7o1; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzhwTpnzCXBsvKrMZVFfWFbNjxeQVTXitzTN/t6fTO1Oqck1iGmTXbXwttiXF52HNmwpsSdA5PqxwORdNJofLISbTqeJTwbOqg/sKA1kYboNXs56YeOfQ6TFSY95RmrlZlY1wsB+X88pZFfd8E0YrK9KBDpN5huaxY6vk+ajsa7zysxj/CgZVPjF7XOpeWaNtRQY+Q9HVhofddijv3VN08L8/gVUkQygSsnS2NnoUHkFsppOnPXKDZjKuJyIY2Tw8f1qirRRG8nNhOTLq0gmVuiDPsNpIBU0pCeBjABwqrkXb4n8hunWDfPbYLL8qOUtA7DtsZUsgGWfQWDCSiKTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxSiDqmMTsH97VHslEIvSS0hKArFRts8VgguWzoB/O0=;
 b=fX80ZukHG5DLo3b8OO5dBNiED7+O8zjmO6ZZqLOmQg/+ZbLlIXzcCDWoASkFB+0OStYW/gFV1pMv+F/rBJ/HHIDR4sILIstXjjsrhq//XMjjxPCeErZFsQ6Ahq7+FFMQ83DG3M+FLAlLuWCNuyNEzD9RbZVelY+Ctow4bqdfhWm09Kr7Cf/A3WvOlKzBbVXcBrhQGFI6zjUefoXsioFzH2LqyN2j1Vk3rocW5K39AZ9Elnvkc9akPmkzswBkWBGOBvSZbFXQdCujvTfPwPZwX8V8MQByKTJpb2xIXpg1mkkzTg3sLB4FOxgwp7WbEpb/Pmduw+4Yjse6a7eQujw8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxSiDqmMTsH97VHslEIvSS0hKArFRts8VgguWzoB/O0=;
 b=z/1ug7o1Scsgqc9OTRU5UvyhG+1bS8cwUOQj87PgA1+pSxS5cGLJiIu7D1hr+fMBVKQAFS3rtB3iGfIbRhbxAaXJdI2EM7a5OO5/7niuYXVfwnBFFY5PFv6XPkvLlgZ5/zj1HzvWux9iYlthCHLcF+PUCL8UIa7KzZCYRSpDKeYxlcu82AGoBu00N77JsdCOg4/iLFDo2r3kQkp+wX3Jr7gNaMZF1A4qyX+B1HJDp2dQFyEPR0s057VBvLjwpRPSAW0ZI4/ErtKaJ/2KoGbraIor28FII/GmgRY7WV+jGWEtB1KAxsL2UgjwCBsKwGEW0qj8sgnAS5rCl8inkz29XA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB5327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 18:53:22 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 18:53:22 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hauke@hauke-m.de" <hauke@hauke-m.de>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arkadis@mellanox.com"
	<arkadis@mellanox.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "john@phrozen.org" <john@phrozen.org>, "Stockmann, Lukas"
	<lukas.stockmann@siemens.com>, "yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>, "Christen, Peter"
	<peter.christen@siemens.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcDuf7846RS4sgEkqqTJthT32tBrRte+qA
Date: Thu, 21 Aug 2025 18:53:22 +0000
Message-ID: <59f32c924cd8ebd02483dfd19c2788cf09d9ab75.camel@siemens.com>
References: <aKDikYiU-88zC6RF@pidgin.makrotopia.org>
In-Reply-To: <aKDikYiU-88zC6RF@pidgin.makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB5327:EE_
x-ms-office365-filtering-correlation-id: d1d0f10c-adf3-4311-0d00-08dde0e400cd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wmt4Z2gzK0prREswem5LYXpLM1JaLzBvdDc5TCtiVk1xdDJ4Ri9oSFpjZFBR?=
 =?utf-8?B?WUNuZXZHa3FXOE5xOE9sN3VGUWMwVTJxU0hYVzNLZkNBU29KVGRNMEZ4SEl6?=
 =?utf-8?B?KzVHcHFmMk9mWE5ZT1NneTZMcWlORTJhR0xqbGtxeU13RnR3Z0ZMa3RaMEVJ?=
 =?utf-8?B?RzZKZkg1QUJweFl3UXdOeCtERC85eXpmSEliLzBJQWNZT1dnV2ZIalJUQjU3?=
 =?utf-8?B?VTBXMUl4RG9mMlZ0QVFrWE5wVU1saU5YSDhtUnUyLzV0cDA0cW94UC9uZ1l6?=
 =?utf-8?B?U1RSek8zRkhXYmUyZ0tMUkVZbzdsbkxOTEcxUUNTbHdKbldEbEhQYUZEa3F0?=
 =?utf-8?B?a0p5YXVjNGZkWlpZaDlZZnZDeGFYQWJoMHljNDNGQno2R3piZnRjMG5nZ2E1?=
 =?utf-8?B?UVlmOWZ0OHdBUktRL3k5WCtQWVpmNFd4WEkxRnJLTEMvVFlaeStTcGFIT1dE?=
 =?utf-8?B?WkVDRW9FYm1zMkFzcXhkU21uWFB6a0lVaTkreWt4Q0FvalNqcWFyZ2tpQlgv?=
 =?utf-8?B?NUFhT1h2YjFWaWZUbXpWdm9NNEFvdVNMUXdKVHVOZFBWaGIvbmxUa0hzRUFi?=
 =?utf-8?B?RXU2RmhwMURtTldiWFpJWDM3YldtM1RxdFI0UllyWXZrK0crWFBsSXJNYlVX?=
 =?utf-8?B?WjJOZ2F0OUdyMm1DZ3BRL3pBNTVNZ0d0ZkZ4bUdFenVtampQTjhkMC9OMjdK?=
 =?utf-8?B?TlMxUEhrblladExTNHJYdXVMcWpnM0cvRVBpTWNtWGttRWRWYUVFR0IzcHZ2?=
 =?utf-8?B?RjdiN1kyd0oxVEpKVXNwbkUvVE04eG1nTU1LL2F0b2ErU3V5MFdld0hTR2dE?=
 =?utf-8?B?cXNOaUJRUWRwTVkyblpLSTBmU1BpTWxmV0xBV2JQTVNoam9HckVlcmNxZHJ4?=
 =?utf-8?B?dWNSNVViYlBxL0k0c1o5MGF4WlVBbHJqM28zYUd5TkYzUnBSRldvR2pUaFFr?=
 =?utf-8?B?SEpFNHM2bzJ4dkFtc2dpZEMvd1RPYmxvSTNiZXBUdUp5cjloemVQSUVhbU81?=
 =?utf-8?B?YWhlMTdaTTRPSTR1QkREQzg0L1VCNkdFYVk5UTYrWUNHYVRCOUFiNE9uNEdl?=
 =?utf-8?B?U3MvMWxXdzRKWjNrUUVCSDJ6NG40Yis3K0N1a0t4aGtrbTFvTWh2ekpOQnAz?=
 =?utf-8?B?bzFLSXViejI4SzFzME9VYjNRbEE5eVd3YXhwZWxVQjdjbDlBWG1CczVuTkp1?=
 =?utf-8?B?aTJQR016ZUNzVy9EbjRybzRKMDdRc2Z5Nkhpd1VONWlJYXdJZEQxejZUZ2Vs?=
 =?utf-8?B?SVNPTVBPRzRpajEwMW9veUEyUkFUQU04YnZ4RlJ6a01RTDFLcUtMcjl6Wksx?=
 =?utf-8?B?WE5Lc1AzcE9zRzFCMkM2QXNHV1VBVmRKT0p6RzdzKzI5QzN4SHhRdVZ2d3I5?=
 =?utf-8?B?NnlZUm13Y1hGMU9vNnJvaE9saUZ0b3pDQVUyeDI4Q2pnaFpacHZoQ01XVjRG?=
 =?utf-8?B?T3pCSGtnVmptUGlpeTdWUHBWcEh6NlhlZFNpcWNQWTBsVGNwQlhTVitlWi9w?=
 =?utf-8?B?dzh6aGdZRnpPd0tZTzFlSStJODZoNTNnbEwrdzZOSGVYVVJDdzRDK3AyTkpP?=
 =?utf-8?B?eW56V3NZVzM1T1IzMEp0WXVrSG91eXB4Ni9Pbi82d0tkaWJtaEFQK0NJMEhi?=
 =?utf-8?B?S0J1Y01Sczh6Z20vcUtmSkNoK01GUU4xa0V0bWo4KzEvQU1jbjNqS3NYMU1o?=
 =?utf-8?B?dXl5WDhtM2owN3pHWXM1ZDllVVhXRTdxa1lSSUhhditNa2xPdi9qWmdCMlB4?=
 =?utf-8?B?U0dPakNwOFFFcytjN1l1MHByeWo1VE8vbDFFYnJoaEV4T2I1eEhFUGZHMkE3?=
 =?utf-8?B?MTEwTHFVek9MZUU4TStFcDRzVXFoVDBvWG1oNXlCQk02MTk0TDlJaWwyWTRQ?=
 =?utf-8?B?ZE1TRFVqZkVaLzBTNDBwL0RRQmhqNjVzWWlnZWZVaHgwbUlzd0hrMDZlMGFK?=
 =?utf-8?Q?01e1z4J8rJ7MkfwdiE8xbYqflOo/FTDz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXBDUmVzRWNhZTlaL3JoWWhuaW40L1VsQVVIaUVCQWQrVm9RRjg3SURheUNV?=
 =?utf-8?B?aXlaSTJvYkdxMm1KSXVRT0FsMXlGYzZ3WkwwOTVmYjJGNS9CU25JdGg0cWpL?=
 =?utf-8?B?aDc1N1hZdEdDclBNS055SWxFV2gzL0tYTFArMEZJSU9Vam1TckFaSk5KT2xv?=
 =?utf-8?B?Y01mdjM0WjR0TEVBVERZZVloUll4eHAvUmlMV00yQ1JIbmlQekFaM1ZYUy8z?=
 =?utf-8?B?M0JlZVBKUXQyZGQzampIK21VZHVCYWtLQ3dSY2UzY09YUDR0bHU2REJwZVlt?=
 =?utf-8?B?eno3d2hOUFZpK0tLSGFWYnR2c1ZDRUQ0eURKV1I5OXhRRUZTaWE0a1lJb0p5?=
 =?utf-8?B?U2R5enBOVUM2VUFYWkdqdjBuZFA3TXAyaTdoY2FsalpMT1J4bW1uUXVYcE02?=
 =?utf-8?B?TVV0Vzl2SENRYW0xWDJ2ZjJGclZxSjZtbnduSjVIN1ByLytZQklaRDY3T1ZU?=
 =?utf-8?B?UVo1V3pkMFNjS3JEUWJQSnBmRWc2cVUvTkhMN1BCbnJJaTBKMGduQXNBVTNR?=
 =?utf-8?B?b2NIanl2NWs5UkhrUk4rQ3FmZURFVWVxUTVobEZHMmJYRXVUMjJCVTl4dlJ5?=
 =?utf-8?B?elNjM0l5L1BYZC92RDlFN0N5TDFIajgzcmRpVmRHbU8rc2YvQzQzL2U0M1Zl?=
 =?utf-8?B?S2FYMUNzUXgrL3NtM3JCaHNxZjViZlU0QU4zdWcyRkE1MDM2eGhPUjg3Qlgw?=
 =?utf-8?B?c2g4Nkh0WEU3V2REaXdZTVU5b21XdVd1YWluSnpqQnpwUVBaWTl6ZnNSVXRv?=
 =?utf-8?B?WTFhU1M2dTRGYzg0NFpYbHdZRGlZQzlpOFhSbnQyS2VUYkwrVmhNV3B1Z3lD?=
 =?utf-8?B?Wjl6Z1FORVlMRktJQUhDK2NBTHFkSXZ0SUlZeTBYRStzUStvMzNPZVBMMkcw?=
 =?utf-8?B?ZmpLTG5VUkpoWFRkS09KZEtISm9OOVB6QzJ3VzdpV3JHRmIvdC93R1B3aXRH?=
 =?utf-8?B?aHNDWUttVFA3VUlOTTNibGJqM1N1M2Vrc3czaU5MSW1PK2lwZm1ONzYyL0ty?=
 =?utf-8?B?ODJFKzhMUDNZY0lidFhtVS9vSnlJK1FpemQxbFRkZTNrVUt5QUkxYy9UTSsz?=
 =?utf-8?B?dDYxbjRkRzdGSThwVk1Qelg4VHpDNm1hUHJsYzNla1BWRzlFOHliOU9FNnpi?=
 =?utf-8?B?eFhiMFhRdnBEWVZRakFKd2tDcDN0UmJDNEREZmZpUThVWDYzblBkQlkzMXg2?=
 =?utf-8?B?d2plampNOW95QXduS3BRcEdPOForU0U1Y01lVzZlRTVsQXpsTHMwcVc0OWhH?=
 =?utf-8?B?RWRCZ2dnaUlLeTRQVXRJdGdCK05lUWgrK3h1NmxvVEE5YWcvRm9ITlFIRUo5?=
 =?utf-8?B?SnB5dkI4TTdGWGRaaDVuR1BvMSs0YzU1Y1d5YkIrZU8xUm1pYlNqRkQyM2Yr?=
 =?utf-8?B?KzZramFjdDBLanpYaUlnNzZUQmZ3dTcwRzhpMWx0VW82bEJxc3NOVlpldG42?=
 =?utf-8?B?NE1WWkNMNVdzM0dtNGFnMnZha2ZnQnBQRHowZHJ0Lzk4c2ZNM01ZS3dac0Q5?=
 =?utf-8?B?SnY1R1hudEh2N3hTZ3dEQUl0T0R5ZkhLWDhZdVNYWWwvMXRSdW5uT0pxbWlF?=
 =?utf-8?B?c1dDczhjWHo5KzFIaEQ3ZjhHS2JMZ1pVcVp2WkJDaCszYzFMTUdCNkVIK09C?=
 =?utf-8?B?VTgwOVNqZlRNU1cxWTByZTVrOGt0TWlqK1JqSmpyVWVOVWl5T1hKMzF3dEpK?=
 =?utf-8?B?TWU4OU80MzFDQVhEc09CZnJTWi9XWEJscmsyaGg3cEFjY01xajhEdGxBWXJz?=
 =?utf-8?B?OUMwTkUvR3FUV0hrWUZhbnhqNG9YQ0FNMmd1b1RTNGJjYTVwZllBSFVGSTRk?=
 =?utf-8?B?MVBrTVdjdWpqM24yQVQwUjYwK1BZd0duU2l3aklROGtFeC9WbndncGxxa05C?=
 =?utf-8?B?cUpBOFpkanNvQjVyYkU0cVRQa2xodG4xZi91U1FtZjlaM3BuTnZUbWwySi84?=
 =?utf-8?B?M1BScmM0dFU5NDZtR1ZXZlZNMEJDMW8vODNxeWJ2M1k1V2hSSGd5TEl3aitw?=
 =?utf-8?B?Mm1kK2VvdlVxTHF6cVB4eGh5WkVpUW1iai9VRzUyc1ZmRzVDaG50ZFRwNHg4?=
 =?utf-8?B?SExSYjBybnQzdTdWdDJ5YzYxTmh4NmtvSTZCZ1ZWcUxRNCtTUU9UNktSSjhM?=
 =?utf-8?B?U25Qek5JdkNOamxBbU92SG1KMFEzVDczcDlaQVBIU1lZOXVMcm9Vby81dW9X?=
 =?utf-8?Q?pAVU9PL1Jsn8GXaAdlRo17Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C288CE0565990D4AB6AE4122255DE5CE@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d0f10c-adf3-4311-0d00-08dde0e400cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 18:53:22.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3Bsb2dx0EpBfFg9aTUW5YSTtJgZ/h3iG0ijY9EnWIio4oXzQc8TgDiuzh1qvkqBZ6VMVdw9gVxRUiPTSA8++1Wxs8IFWcre1+chW4sapRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5327

SGkgRGFuaWVsLA0KDQpPbiBTYXQsIDIwMjUtMDgtMTYgYXQgMjA6NTcgKzAxMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gQWRkIGRyaXZlciBmb3IgdGhlIE1heExpbmVhciBHU1cxeHggZmFtaWx5
IG9mIEV0aGVybmV0IHN3aXRjaCBJQ3Mgd2hpY2gNCj4gYXJlIGJhc2VkIG9uIHRoZSBzYW1lIElQ
IGFzIHRoZSBMYW50aXEvSW50ZWwgR1NXSVAgZm91bmQgaW4gdGhlIExhbnRpcSBWUjkNCj4gYW5k
IEludGVsIEdSWCBNSVBTIHJvdXRlciBTb0NzLiBUaGUgbWFpbiBkaWZmZXJlbmNlIGlzIHRoYXQg
aW5zdGVhZCBvZg0KPiB1c2luZyBtZW1vcnktbWFwcGVkIEkvTyB0byBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBob3N0IENQVSB0aGVzZSBJQ3MgYXJlDQo+IGNvbm5lY3RlZCB2aWEgTURJTyAob3IgU1BJ
LCB3aGljaCBpc24ndCBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIpLg0KPiBJbXBsZW1lbnQgdGhl
IHJlZ21hcCBBUEkgdG8gYWNjZXNzIHRoZSBzd2l0Y2ggcmVnaXN0ZXJzIG92ZXIgTURJTyB0byBh
bGxvdw0KPiByZXVzaW5nIGxhbnRpcV9nc3dpcF9jb21tb24gZm9yIGFsbCBjb3JlIGZ1bmN0aW9u
YWxpdHkuDQo+IA0KPiBUaGUgR1NXMXh4IGFsc28gY29tZXMgd2l0aCBhIFNlckRlcyBwb3J0IGNh
cGFibGUgb2YgMTAwMEJhc2UtWCwgU0dNSUkgYW5kDQo+IDI1MDBCYXNlLVgsIHdoaWNoIGNhbiBl
aXRoZXIgYmUgdXNlZCB0byBjb25uZWN0IGFuIGV4dGVybmFsIFBIWSBvciBTRlANCj4gY2FnZSwg
b3IgYXMgdGhlIENQVSBwb3J0LiBTdXBwb3J0IGZvciB0aGUgU2VyRGVzIGludGVyZmFjZSBpcyBp
bXBsZW1lbnRlZA0KPiBpbiB0aGlzIGRyaXZlciB1c2luZyB0aGUgcGh5bGlua19wY3MgaW50ZXJm
YWNlLg0KDQouLi4NCg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9t
eGwtZ3N3MXh4LmMNCg0KLi4uDQoNCj4gc3RhdGljIGludCBnc3cxeHhfc2dtaWlfcGNzX2NvbmZp
ZyhzdHJ1Y3QgcGh5bGlua19wY3MgKnBjcywNCj4gKwkJCQkgICB1bnNpZ25lZCBpbnQgbmVnX21v
ZGUsDQo+ICsJCQkJICAgcGh5X2ludGVyZmFjZV90IGludGVyZmFjZSwNCj4gKwkJCQkgICBjb25z
dCB1bnNpZ25lZCBsb25nICphZHZlcnRpc2luZywNCj4gKwkJCQkgICBib29sIHBlcm1pdF9wYXVz
ZV90b19tYWMpDQo+ICt7DQo+ICsJc3RydWN0IGdzdzF4eF9wcml2ICpwcml2ID0gc2dtaWlfcGNz
X3RvX2dzdzF4eChwY3MpOw0KPiArCWJvb2wgc2dtaWlfbWFjX21vZGUgPSBkc2FfaXNfdXNlcl9w
b3J0KHByaXYtPmdzd2lwLmRzLCBHU1cxWFhfU0dNSUlfUE9SVCk7DQo+ICsJdTE2IHR4YW5lZywg
YW5lZ2N0bCwgdmFsLCBuY29fY3RybDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJLyogQXNzZXJ0
IGFuZCBkZWFzc2VydCBTR01JSSBzaGVsbCByZXNldCAqLw0KPiArCXJldCA9IHJlZ21hcF9zZXRf
Yml0cyhwcml2LT5zaGVsbCwgR1NXMVhYX1NIRUxMX1JTVF9SRVEsDQo+ICsJCQkgICAgICBHU1cx
WFhfUlNUX1JFUV9TR01JSV9TSEVMTCk7DQoNCkNhbiB0aGlzIGJlIG1vdmVkIGludG8gZ3N3MXh4
X3Byb2JlKCkgbWF5YmU/DQoNClRoZSB0aGluZyBpcywgaWYgdGhlIHN3aXRjaCBpcyBib290c3Ry
YXBwZWQgaW4NCiJTZWxmLXN0YXJ0IE1vZGU6IE1hbmFnZWQgU3dpdGNoIFN1Yi1Nb2RlIiwgU0dN
SUkgd2lsbCBiZSBhbHJlYWR5DQpicm91Z2h0IG91dCBvZiByZXNldCAoYnkgYm9vdGxvYWRlcj8p
IChHU1dJUF9DRkcgcmVnaXN0ZXIpLCByZWZlcg0KdG8gIlRhYmxlIDEyIFJlZ2lzdGVycyBDb25m
aWd1cmF0aW9uIGZvciBTZWxmLXN0YXJ0IE1vZGU6IE1hbmFnZWQgU3dpdGNoIFN1Yi1Nb2RlIg0K
aW4gZGF0YXNoZWV0LiBBbmQgbm9ib2R5IHdvdWxkIGRpc2FibGUgU0dNSUkgaWYgaXQncyB1bnVz
ZWQgb3RoZXJ3aXNlLg0KDQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsN
Cj4gKwlyZXQgPSByZWdtYXBfY2xlYXJfYml0cyhwcml2LT5zaGVsbCwgR1NXMVhYX1NIRUxMX1JT
VF9SRVEsDQo+ICsJCQkJR1NXMVhYX1JTVF9SRVFfU0dNSUlfU0hFTEwpOw0KPiArCWlmIChyZXQg
PCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJLyogSGFyZHdhcmUgQnJpbmd1cCBGU00g
RW5hYmxlICAqLw0KPiArCXJldCA9IHJlZ21hcF93cml0ZShwcml2LT5zZ21paSwgR1NXMVhYX1NH
TUlJX1BIWV9IV0JVX0NUUkwsDQo+ICsJCQkgICBHU1cxWFhfU0dNSUlfUEhZX0hXQlVfQ1RSTF9F
Tl9IV0JVX0ZTTSB8DQo+ICsJCQkgICBHU1cxWFhfU0dNSUlfUEhZX0hXQlVfQ1RSTF9IV19GU01f
RU4pOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJLyogQ29u
ZmlndXJlIFNHTUlJIFBIWSBSZWNlaXZlciAqLw0KPiArCXZhbCA9IEZJRUxEX1BSRVAoR1NXMVhY
X1NHTUlJX1BIWV9SWDBfQ0ZHMl9FUSwNCj4gKwkJCSBHU1cxWFhfU0dNSUlfUEhZX1JYMF9DRkcy
X0VRX0RFRikgfA0KPiArCSAgICAgIEdTVzFYWF9TR01JSV9QSFlfUlgwX0NGRzJfTE9TX0VOIHwN
Cj4gKwkgICAgICBHU1cxWFhfU0dNSUlfUEhZX1JYMF9DRkcyX1RFUk1fRU4gfA0KPiArCSAgICAg
IEZJRUxEX1BSRVAoR1NXMVhYX1NHTUlJX1BIWV9SWDBfQ0ZHMl9GSUxUX0NOVCwNCj4gKwkJCSBH
U1cxWFhfU0dNSUlfUEhZX1JYMF9DRkcyX0ZJTFRfQ05UX0RFRik7DQo+ICsNCj4gKwkvLyBpZiAo
IXByaXYtPmR0cy5zZ21paV9yeF9pbnZlcnQpDQogICAgICAgIF5eDQpUaGVyZSBpcyBzdGlsbCBh
IHJvb20gZm9yIHNvbWUgY2xlYW51cCA7LSkNCg0KPiArCQl2YWwgfD0gR1NXMVhYX1NHTUlJX1BI
WV9SWDBfQ0ZHMl9JTlZFUlQ7DQo+ICsNCj4gKwlyZXQgPSByZWdtYXBfd3JpdGUocHJpdi0+c2dt
aWksIEdTVzFYWF9TR01JSV9QSFlfUlgwX0NGRzIsIHZhbCk7DQo+ICsJaWYgKHJldCA8IDApDQo+
ICsJCXJldHVybiByZXQ7DQo+ICsNCg0KLi4uDQoNCj4gK3N0YXRpYyBpbnQgZ3N3MXh4X3Byb2Jl
KHN0cnVjdCBtZGlvX2RldmljZSAqbWRpb2RldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmbWRpb2Rldi0+ZGV2Ow0KPiArCXN0cnVjdCBnc3cxeHhfcHJpdiAqcHJpdjsNCj4gKwlz
dHJ1Y3QgZHNhX3N3aXRjaCAqZHM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXByaXYgPSBkZXZt
X2t6YWxsb2MoZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXByaXYp
DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJcHJpdi0+bWRpb19kZXYgPSBtZGlvZGV2
Ow0KPiArCXByaXYtPnNtZGlvX2JhZHIgPSBHU1cxWFhfU01ESU9fQkFEUl9VTktOT1dOOw0KPiAr
DQo+ICsJcHJpdi0+Z3N3aXAuZGV2ID0gZGV2Ow0KPiArCXByaXYtPmdzd2lwLmh3X2luZm8gPSBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gKwlpZiAoIXByaXYtPmdzd2lwLmh3X2lu
Zm8pDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJbXV0ZXhfaW5pdCgmcHJpdi0+Z3N3
aXAucGNlX3RhYmxlX2xvY2spOw0KPiArDQo+ICsJcHJpdi0+Z3N3aXAuZ3N3aXAgPSBnc3cxeHhf
cmVnbWFwX2luaXQocHJpdiwgInN3aXRjaCIsDQo+ICsJCQkJCSAgICAgICBHU1cxWFhfU1dJVENI
X0JBU0UsIDB4ZmZmKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYtPmdzd2lwLmdzd2lwKSkNCj4gKwkJ
cmV0dXJuIFBUUl9FUlIocHJpdi0+Z3N3aXAuZ3N3aXApOw0KPiArDQo+ICsJcHJpdi0+Z3N3aXAu
bWRpbyA9IGdzdzF4eF9yZWdtYXBfaW5pdChwcml2LCAibWRpbyIsIEdTVzFYWF9NTURJT19CQVNF
LA0KPiArCQkJCQkgICAgICAweGZmKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYtPmdzd2lwLm1kaW8p
KQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwcml2LT5nc3dpcC5tZGlvKTsNCj4gKw0KPiArCXByaXYt
Pmdzd2lwLm1paSA9IGdzdzF4eF9yZWdtYXBfaW5pdChwcml2LCAibWlpIiwgR1NXMVhYX1JHTUlJ
X0JBU0UsDQo+ICsJCQkJCSAgICAgMHhmZik7DQo+ICsJaWYgKElTX0VSUihwcml2LT5nc3dpcC5t
aWkpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwcml2LT5nc3dpcC5taWkpOw0KPiArDQo+ICsJcHJp
di0+c2dtaWkgPSBnc3cxeHhfcmVnbWFwX2luaXQocHJpdiwgInNnbWlpIiwgR1NXMVhYX1NHTUlJ
X0JBU0UsDQo+ICsJCQkJCSAweGZmZik7DQo+ICsJaWYgKElTX0VSUihwcml2LT5zZ21paSkpDQo+
ICsJCXJldHVybiBQVFJfRVJSKHByaXYtPnNnbWlpKTsNCj4gKw0KPiArCXByaXYtPmdwaW8gPSBn
c3cxeHhfcmVnbWFwX2luaXQocHJpdiwgImdwaW8iLCBHU1cxWFhfR1BJT19CQVNFLA0KPiArCQkJ
CQkweGZmKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYtPmdwaW8pKQ0KPiArCQlyZXR1cm4gUFRSX0VS
Uihwcml2LT5ncGlvKTsNCj4gKw0KPiArCXByaXYtPmNsayA9IGdzdzF4eF9yZWdtYXBfaW5pdChw
cml2LCAiY2xrIiwgR1NXMVhYX0NMS19CQVNFLCAweGZmKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYt
PmNsaykpDQo+ICsJCXJldHVybiBQVFJfRVJSKHByaXYtPmNsayk7DQo+ICsNCj4gKwlwcml2LT5z
aGVsbCA9IGdzdzF4eF9yZWdtYXBfaW5pdChwcml2LCAic2hlbGwiLCBHU1cxWFhfU0hFTExfQkFT
RSwNCj4gKwkJCQkJIDB4ZmYpOw0KPiArCWlmIChJU19FUlIocHJpdi0+c2hlbGwpKQ0KPiArCQly
ZXR1cm4gUFRSX0VSUihwcml2LT5zaGVsbCk7DQo+ICsNCj4gKwlwcml2LT5zZ21paV9wY3Mub3Bz
ID0gJmdzdzF4eF9zZ21paV9wY3Nfb3BzOw0KPiArCXByaXYtPnNnbWlpX3Bjcy5wb2xsID0gMTsN
Cj4gKwlfX3NldF9iaXQoUEhZX0lOVEVSRkFDRV9NT0RFX1NHTUlJLA0KPiArCQkgIHByaXYtPnNn
bWlpX3Bjcy5zdXBwb3J0ZWRfaW50ZXJmYWNlcyk7DQo+ICsJX19zZXRfYml0KFBIWV9JTlRFUkZB
Q0VfTU9ERV8xMDAwQkFTRVgsDQo+ICsJCSAgcHJpdi0+c2dtaWlfcGNzLnN1cHBvcnRlZF9pbnRl
cmZhY2VzKTsNCj4gKwlpZiAocHJpdi0+Z3N3aXAuaHdfaW5mby0+c3VwcG9ydHNfMjUwMG0pDQo+
ICsJCV9fc2V0X2JpdChQSFlfSU5URVJGQUNFX01PREVfMjUwMEJBU0VYLA0KPiArCQkJICBwcml2
LT5zZ21paV9wY3Muc3VwcG9ydGVkX2ludGVyZmFjZXMpOw0KPiArDQo+ICsJcmV0ID0gcmVnbWFw
X3JlYWQocHJpdi0+Z3N3aXAuZ3N3aXAsIEdTV0lQX1ZFUlNJT04sICZwcml2LT5nc3dpcC52ZXJz
aW9uKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWRzID0g
ZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkcyksIEdGUF9LRVJORUwpOw0KPiArCWlmICghZHMp
DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJcHJpdi0+Z3N3aXAuZHMgPSBkczsNCj4g
Kw0KPiArCXJldCA9IGdzd2lwX2FsbG9jYXRlX3ZsYW5zKCZwcml2LT5nc3dpcCk7DQo+ICsJaWYg
KHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWRzLT5kZXYgPSBkZXY7DQo+ICsJZHMt
Pm51bV9wb3J0cyA9IEdTVzFYWF9QT1JUUzsNCj4gKwlkcy0+cHJpdiA9ICZwcml2LT5nc3dpcDsN
Cj4gKwlkcy0+b3BzID0gJmdzd2lwX3N3aXRjaF9vcHM7DQo+ICsJZHMtPnBoeWxpbmtfbWFjX29w
cyA9ICZnc3dpcF9waHlsaW5rX21hY19vcHM7DQo+ICsJZHMtPmZkYl9pc29sYXRpb24gPSB0cnVl
Ow0KPiArDQo+ICsJLyogY29uZmlndXJlIEdQSU8gcGluLW11eCBmb3IgTU1ESU8gaW4gY2FzZSBv
ZiBleHRlcm5hbCBQSFkgY29ubmVjdGVkIHRvDQo+ICsJICogU0dNSUkgb3IgUkdNSUkgYXMgc2xh
dmUgaW50ZXJmYWNlDQo+ICsJICovDQo+ICsJcmVnbWFwX3NldF9iaXRzKHByaXYtPmdwaW8sIEdQ
SU9fQUxUU0VMMCwgMyk7DQo+ICsJcmVnbWFwX3NldF9iaXRzKHByaXYtPmdwaW8sIEdQSU9fQUxU
U0VMMSwgMyk7DQo+ICsNCj4gKwlkZXZfc2V0X2RydmRhdGEoZGV2LCBkcyk7DQo+ICsNCj4gKwly
ZXQgPSBkc2FfcmVnaXN0ZXJfc3dpdGNoKGRzKTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWlmIChy
ZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCWRldl9lcnIoZGV2LCAiJXM6IEVycm9yICVkIHJl
Z2lzdGVyIERTQSBzd2l0Y2hcbiIsDQo+ICsJCQkJX19mdW5jX18sIHJldCk7DQo+ICsJCXJldHVy
biByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gZ3N3aXBfdmFsaWRhdGVfY3B1X3BvcnQoZHMp
Ow0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZGlzYWJsZV9zd2l0Y2g7DQo+ICsNCj4gKwlkZXZf
aW5mbyhkZXYsICJwcm9iZWQgR1NXSVAgdmVyc2lvbiAlbHggbW9kICVseFxuIiwNCj4gKwkJIChw
cml2LT5nc3dpcC52ZXJzaW9uICYgR1NXSVBfVkVSU0lPTl9SRVZfTUFTSykgPj4gR1NXSVBfVkVS
U0lPTl9SRVZfU0hJRlQsDQo+ICsJCSAocHJpdi0+Z3N3aXAudmVyc2lvbiAmIEdTV0lQX1ZFUlNJ
T05fTU9EX01BU0spID4+IEdTV0lQX1ZFUlNJT05fTU9EX1NISUZUKTsNCj4gKw0KPiArCXJldHVy
biAwOw0KPiArDQo+ICtkaXNhYmxlX3N3aXRjaDoNCj4gKwlnc3dpcF9kaXNhYmxlX3N3aXRjaCgm
cHJpdi0+Z3N3aXApOw0KPiArCWRzYV91bnJlZ2lzdGVyX3N3aXRjaChkcyk7DQo+ICsNCj4gKwly
ZXR1cm4gcmV0Ow0KPiArfQ0KDQouLi4NCg0KPiArc3RhdGljIHN0cnVjdCBtZGlvX2RyaXZlciBn
c3cxeHhfZHJpdmVyID0gew0KPiArCS5wcm9iZQkJPSBnc3cxeHhfcHJvYmUsDQo+ICsJLnJlbW92
ZQkJPSBnc3cxeHhfcmVtb3ZlLA0KPiArCS5zaHV0ZG93bgk9IGdzdzF4eF9zaHV0ZG93biwNCj4g
KwkubWRpb2Rydi5kcml2ZXIJPSB7DQo+ICsJCS5uYW1lID0gIm14bC1nc3cxeHgiLA0KPiArCQku
b2ZfbWF0Y2hfdGFibGUgPSBnc3cxeHhfb2ZfbWF0Y2gsDQo+ICsJfSwNCj4gK307DQoNCi0tIA0K
QWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

