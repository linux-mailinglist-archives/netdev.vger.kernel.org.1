Return-Path: <netdev+bounces-128043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0959779A3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13623B254B9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9091BC08F;
	Fri, 13 Sep 2024 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HyPTfHjs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC353185934;
	Fri, 13 Sep 2024 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212578; cv=fail; b=TgTpMiDOEaLQGR82ytQn2LRN60JzHzxRXqBVkL4XzB1FB/f4Avm6sJ+WeOstjYvpi+XemhLUwF3et/udSopfWY7u+e2MwhA4a13k817EJGRWh9M/blIKRW5uGrGcqJX0rRdrCRIGq4YH+9/u87p5fcY9gIj4gWeZVy4jVuZB00A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212578; c=relaxed/simple;
	bh=vafHUjn6+ZwasWj6hkNnJYqfKu4LZpL0sjHyPN4ESl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDmhnKrasjOWeaa3XPiPoeAb8WNFzw6JW37wZnEvRVon6jGLoZQ/tSdeO0JqMsU9vpn2RSgm0Jrvom7iqg31g8sGVUpS50wGYASxRym4oU9xDXy0KvpVRk0D89PSlCqovcY6VxBGeCbnUKX/FmFoAeUzgN4sCEdA04y9O08b71c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HyPTfHjs; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdO497b7+OsecI1pDdufBgYuSuPFw3E5mN6CDX4m5XeyBdXeeh53NQd9WPZK8ReoqoBrykGnk5yXUv9OOuuYpkyElUkVrj68V+pr/NydbwYCt176vncOZ/BcVSY2R8nvYvS2fCTmjxzYwwoCveyDDJbIXtofCzudG5zqKRBQUIC8ShH0gjZ5AIL/nOUgB1abqUFXY9aXsqeKH7P+aACweeEmMIKcJhBlGq5WT65W4WWNTqNfjjyDa+NqV88642fbyKlm811yA4ArbeYKEXjHWk0RdWUNPd9w39ZTP7/TbPAkuChilGC+K3TtZvaLGFeKZ/2GcicrUpT45JvoHuUPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vafHUjn6+ZwasWj6hkNnJYqfKu4LZpL0sjHyPN4ESl8=;
 b=dPpy2OGiRKpH8KwKSkKyB0dWn2xAymlok0C0q1y9wu80gcVtvLtTReBlcebUnRpkcP43Nuz1DMXWGY2lMCIcPBhkbvg8OG98PnIEmK6Gt+Swmq6a2LyuKsMnZroRsN6aYLgwkE+fTzbDGlSAsw6OQKmAhbFu2axgggmBPO3RdCVgh92KTLMMydBTlq+Gn9mjAExNB+7lJX96Z+kGjsz5rOlWxTZSH9P+51tu7W+85KFrLLlT71pKjTWrotNFz2fEAGeupkYN4flGf6DV8o0sHSjM6tJuOdMVw4awefv2si/ljqksiseimrkaoqWHprdBVFiu3QspSk1b/kh97inofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vafHUjn6+ZwasWj6hkNnJYqfKu4LZpL0sjHyPN4ESl8=;
 b=HyPTfHjsWc7HrlWK79RdJ+Pc6DlbjXlaG2EKKoOpkW53dFu+i3nfdbvI6rVafgTOjwOoDNDm4oW5mdDFfHEnDqkI5zSWwYmZQQh3Y4AmI2MTlpBi86554lvVzJb15RckqPO7J8bfXv70EuhF4rzPnSBl3VNTlPR8ggRAGNQRChTlboYMpWsrUIz9lsj3QUxA6nAZh8cQaurIcI2Up/T3FgrJY3hFv0EKUJwMfkqwbNSoK5dtZNE/n3Cx3iNUbMkzw3Kta54CSY5TClv5qry3DGC6D+1yIBJk3JFCGYw7ZLesufEMXw13C4yCwKeosaL/FpwJGiddcFWlIhSy6jjsTg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29; Fri, 13 Sep
 2024 07:29:33 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 07:29:32 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Machata
	<petrm@nvidia.com>
Subject: RE: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Topic: [PATCH net-next v2 2/2] net: ethtool: Add support for writing
 firmware blocks using EPL payload
Thread-Index: AQHbA2A2/ifz6xdLskaRO4d4gN4jcbJSMsgAgABSFgCAACuisIAAK4YAgAJ6ESA=
Date: Fri, 13 Sep 2024 07:29:32 +0000
Message-ID:
 <DM6PR12MB4516B5AC9AF9F83B389573D4D8652@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240910090217.3044324-1-danieller@nvidia.com>
 <20240910090217.3044324-3-danieller@nvidia.com>
 <20240911073234.GJ572255@kernel.org>
 <cb9d0196-5b91-486b-932e-e73a391fa609@lunn.ch>
 <DM6PR12MB4516864A308D5BDFF0021129D89B2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <76d49fe4-e2b4-43c4-83f9-07796f47ae1d@lunn.ch>
In-Reply-To: <76d49fe4-e2b4-43c4-83f9-07796f47ae1d@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|SA0PR12MB7461:EE_
x-ms-office365-filtering-correlation-id: a8e04a8c-83b8-480f-1243-08dcd3c5cfb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0dXN3BNZmk4NThXVk1MeTdKdmc0Zlp1NStYcEVXOHlnTjN6NXlNNGRFZit2?=
 =?utf-8?B?R0s5Z0xwZnJDcURYeDhaWVNvdDh6MitoeHJYalpBSUlnYVhjVlhtZ3ovWm9x?=
 =?utf-8?B?RmFSdDhKaGl5UWtZQW0rMldCVi9qU3FpRElpK2pxNGZadml4K2Z1QUMyMyty?=
 =?utf-8?B?anVaemFUNVdoM0hVN3dYNHdiN0hxa3hkVXcwdmhmZkwzaE4yVUdDa3FBbUdQ?=
 =?utf-8?B?RHBoZHphVEtsL0RBNjhkeWdJZTlXUDNDcWtDSEUxeXlwbG5LZWhWOW5PdEZF?=
 =?utf-8?B?Tm5vTGdPWkpYZktWbzJON3pQTHRtNEkvR2QwMEU0UUloRlByb2hHRUN4eUN6?=
 =?utf-8?B?QjlPejl4ZTVMSlJoVGhsb3AxWlVsZXVsSG5BQkpTRGo0dUZZNnd3U0htYzVP?=
 =?utf-8?B?WWFpQ3pqVktVemgwZmIvWHI3eHdBekdEdFU5UVMydDZzK3NUL0tXV25YZmFn?=
 =?utf-8?B?U2t5eXpVTWZYem4yME00aFY4eGR6QXBTK2hNeG1TanB5WC9CWldCTUpBeFJZ?=
 =?utf-8?B?eEdHNm9EOG5iQ0xYUzFHUmVuOGdrSW5NNWdXVWd1MXVTSERtRHdQM044SUlx?=
 =?utf-8?B?aENiZGdOc2llNDk4V0xnRjV6K0N6NS9Ia0xnU2lUWWNXUVE3eUo0OS9aU3hV?=
 =?utf-8?B?QkFiWGRNVVo4RDRGQ0pHZzEyODQzV0l6ZTIxejRYV2c3N0tqK29oNzN2TzE3?=
 =?utf-8?B?ZWpyaDR4dENNZk9KQzlnQkFuMFo3SVF2L0x0Qk5abklGZkFTZ2d3YjVDVSs1?=
 =?utf-8?B?Q0lXa2xwZ29oYmVMUzFRdlh3elZBRGpWUWRSMXFZTnc2bmpOUkdmZlNqVEhw?=
 =?utf-8?B?eGV6emRmWGhZaUNyQzRUb29rU0pxVzFCUmhOTmVLb0pRSG9oSFp4Ulc2L1NU?=
 =?utf-8?B?WFdMTkpoRU90TS9IWFlqYTBaT1VqNXA1dExCSlo0cXBKbEVvMHVWYlVhNEph?=
 =?utf-8?B?Q1N3SStKT21QRE5JWnFpQlR3UXFQQUdLMVpHOHRidmg4OXUreHRRU3FwWWY3?=
 =?utf-8?B?aUNXNmM4WU95UURnNTlzR0Q4emxOOFJrK2xDUzJ2SGVYSFg5UXg5UW5qbEdw?=
 =?utf-8?B?TTBCbVBWZGRNOE45R2ZkaU9oci95ZVVVOU9Vc25ZNTM4b015bzI5SHFodVJo?=
 =?utf-8?B?OWJzSXFvbjBtYnJFQVhaUW91MHJRRERtaFp3aVFwVksySW1vVEpUK09HOHVy?=
 =?utf-8?B?ZXV6SlluUTFwbllIcE5SQVhXOXlvQ0tqZERwcjFQNjdBOHIyR2NJc0VoSS8w?=
 =?utf-8?B?WE1vZXBiZ3BsSHRYUjVnV2hxVWZKcWVGZnM5dHcvQUgyL1ZveFlOblRTa2JC?=
 =?utf-8?B?bThBcGJwRFdzSVRTdjJZWGtDZFcwczRiMjF0MmMyTDl5citqVnNmZjM0MUFV?=
 =?utf-8?B?dEVJc0l1Q1UxK3F4bk0wVFhNdkJxMzdYSEJNaFlaQnZobi9rWUJ6UEpDT0Jh?=
 =?utf-8?B?VXBtNG1Va3RLM0Y2emJqSWVycytnZWJQSFA3bVM5cEZGWnVYemxPbkFtb2Ft?=
 =?utf-8?B?S0lqcitBRDkvY1BnUVlocktiQXhlbDRSTlRkTndMSVhqMVB3QnRuSkg1QitC?=
 =?utf-8?B?SCtOMzI4Slk1K2FvK05iM1U0cHdQd2Fsc3FudkZGSWhieW1yTWx4RVFzR3hD?=
 =?utf-8?B?YmlIK3VyOXBGT1ovN0RRakRtMmVYcE05Y3c2b1JYNXhCeFZiNmNXS0Q3UVdn?=
 =?utf-8?B?ajl5SUdraDcrL3plQkxEejJoU0lWS243L0FsZkZuais2RXh1bEVwVFJRbzFB?=
 =?utf-8?B?cnM4RGF2cHBaTXhuRzJzVWRmZys4OWdQbFRGdTZkTmNCRmpIRE8xbkRtRDYv?=
 =?utf-8?B?UEt0bHhvTG5KcVlWOXZhanRSR1h1U21FOU92YU9UV29tV29WQ3lTUTFlSmFC?=
 =?utf-8?B?eTJGMjMrTkNjdk1sUnB6RG9BYUM2WmRVdHJtRVBlRVRheWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnJpNkFnN08vWCt2TkFMSUJZTHV0QWJ3a1VnbTNDdndua1hXS0d2TWxvTDFM?=
 =?utf-8?B?bVNjSlp3Y3M0MXZOVStJY1RjRW5mMXR0Q052cjBpY0FPVkM2KzNyMTV6ZEpU?=
 =?utf-8?B?TXl5cnVvdTRBWG15bXVhQTZ2ZERTQ0UvcTR2azZ4ZVFIS1pDU0sxMGdJai9O?=
 =?utf-8?B?S0NteDVQM0JiTi9sY1VKdVZGUlNVd2lEdElEMlpaeHovNTl1Q0NSajVZOE1Q?=
 =?utf-8?B?cDI5UVkrdkVCeG4xTkdTL0E2bzBXRTRERlEyOTlDNWc5V3BWNTVaY3V0QWtz?=
 =?utf-8?B?Wkc5ZlVSeTJnalJ2QllRSGRYajhIUUtJcmVldTRlbEFiS0dBQ2tTSlB0UHYv?=
 =?utf-8?B?ODhveGc2cmRET2tVdUhoZXJFNXVwc0RDQkxPR0pFUEFKRXBtcU5LSjFFQk1G?=
 =?utf-8?B?K1BVYlNGTGZqRlN6dE8xV2lJTG56anBtM3RIUUZFQkxubHZVejM1ckIzQzE5?=
 =?utf-8?B?Tld5TGdWV21JV1FhaFlkaUZJdjJhK2ZoUTRUUENOdnZyWXpyRFZqL3JJOE5y?=
 =?utf-8?B?RXYrdU0xaVRqcXlpTTBoZ3VXQXVodWs3dmZOSzBRSVRsMGNUdElOU2l3S0tk?=
 =?utf-8?B?Zzhzc0FYaGxzV1liVXZhNFhsdllQTG0vZHNoYWp5Q1pBdFJJb1FnWU1pTDh6?=
 =?utf-8?B?eGsyUWxmemZ6Q3dENVJXSFRtSFJGUno4dCt6VXQvT1JxSy8rQndpT1FqZnZR?=
 =?utf-8?B?bXZjVnNIOHRIY0hTczRvY291dEwwSmRQT1YydEVyQ0p3UlhBUy8rMmhrTXli?=
 =?utf-8?B?ZndWblFNVHpVaUE5VzNmY29nVHhiV0ljSGUzOUpEUmJsSnV4bVNKZ2xTRUJt?=
 =?utf-8?B?MXRucDhqY0tjUTVRenRhM1BOMDVDb1VLTVJHYlRUOTdQUWdKU1N5SGdpSVNC?=
 =?utf-8?B?SGtNYTJ0L2RmV1B6M2lhdlFuZ2hRZG1MWitYWlN2RlZTQmJ6clpXcnFNdDRn?=
 =?utf-8?B?elJQMGROaU1sQU9xUStycHVGTWpqUGZ4a1k3Q2pRS3NiaUpsME1kV2ZsVFdy?=
 =?utf-8?B?dWRKSnh1WEpKekp6bXVhVFMxaXNWcis1SC9EbThkV3dFVEo1eXplbnFydW11?=
 =?utf-8?B?Y1VLQVpBaXR4YVQ4blNSSjRJUnFoZUNnclJoN3I0VGFpU0M4REpmMXBHbTV5?=
 =?utf-8?B?dGRxOUp1d0dLODRwaFJGS0VpRVo1dHRGWW9YdTA0OFJ1bFdCMFBGa0RzQ0lK?=
 =?utf-8?B?S2g0aUd6YkZVMFFBcmdLM3o3bDJDVEVzY0o3dVcwNlpGNDUzbDBiZXhaem94?=
 =?utf-8?B?dmpWcHUyZWxiS3dPN200YnA1TEt2NUVvSDdUN3o4ZGZBSmVRVCtaN0NrRWlj?=
 =?utf-8?B?YTk2a094dXVRL0YwS09nakg5YWRaa1BRcmVoYUFXcU5pTVM5SlZZWTY4bWM2?=
 =?utf-8?B?Z1ZWWDFuTFVmaFRPTnI2V0ZmWXZrY045enFZaGM0emhma1dPUzlXcXRGY3dj?=
 =?utf-8?B?dDNEZ3VsaXIwOFdtampTaGtRemZuN0xvVlR1T2RrQTdJTThMNTVRaGdRdHhO?=
 =?utf-8?B?NWFBZmcvUjUreHM4WHJLc0pTT2tYbzJMMWlsaTdzSzd0M01SRktPTzQyQ1Nm?=
 =?utf-8?B?cWI1RHdMSjd4ZUQ0Q0VqanA4SDBsQlh3MnI4bTNZTXYvbnJudUlHVTFybDJs?=
 =?utf-8?B?enMrNWxvWVJIOGVlVzcvUVR0RzA2eFhsdzdJUXh1VWFNMGx1VTBWRlNMV3Ur?=
 =?utf-8?B?ZlBGdGpHRXVwTm1GSVFrSGlnOXp3cnRJdXViWThaa0d4WmlkejZ3N29PV29Z?=
 =?utf-8?B?c2FUUi9vTElvTnh5QlNqd0xGcFBzMHdqdW5OTFNONHZCMVk4dWlxSWF0cHVU?=
 =?utf-8?B?eW9tRjViQ0drM014NnNFSDJjVGRHOUJhUUd6VXVPV1RDNGtQclNCNzQrUXBG?=
 =?utf-8?B?NjZkbGFaUmRJQ1F2Z2tKaVhwQlFWREFzSERLdmhxOGxtUzE2WFAzWTljT0hv?=
 =?utf-8?B?Zkw0a29xQUEyK3Nwd3MzcjQ0RTBDZVpBU1JwVnBPelV0QUlrZldnREJvR1R2?=
 =?utf-8?B?R1BYMHpXSHpqL01kbi95NzhQU3c0MFFjMVRVTVV3UEphTDQrUkRwUWh3QzZS?=
 =?utf-8?B?OWllRnBMNHZMaDhFYURxa0tCMlhOTGR4Rlg3SFFzSGExYXB4U2Fvc1pRc1Bv?=
 =?utf-8?Q?cUnX3q6WhEqDJvX3LliuaMTwi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e04a8c-83b8-480f-1243-08dcd3c5cfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 07:29:32.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PphWj8u9WU8R9WxMzfOuP+99XHVu1sdNY+ValfI2imknXVwBdch41rJGTwuBBgSB5b4Rmq6sysOgmFMiXKJB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

PiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
MTEgU2VwdGVtYmVyIDIwMjQgMjA6MzgNCj4gVG86IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVy
QG52aWRpYS5jb20+DQo+IENjOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+OyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyB5dWVoYWliaW5n
QGh1YXdlaS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MiAy
LzJdIG5ldDogZXRodG9vbDogQWRkIHN1cHBvcnQgZm9yIHdyaXRpbmcNCj4gZmlybXdhcmUgYmxv
Y2tzIHVzaW5nIEVQTCBwYXlsb2FkDQo+IA0KPiA+IEhpIEFuZHJldywNCj4gPg0KPiA+IEluIGJv
dGggY2FzZXMgd2UgdHJhbnNmZXIgdGhlIHNhbWUgc2l6ZSBvZiBkYXRhLCB3aGljaCBjb3JyZXNw
b25kcyB0byB0aGUNCj4gc2l6ZSBvZiB0aGUgZmlybXdhcmUgaW1hZ2UsIHRvIHRoZSBtb2R1bGUu
DQo+ID4gTW9yZW92ZXIsIGluIGJvdGggY2FzZXMgdGhlIHNhbWUgc2l6ZSBvZiBkYXRhIGlzIHBh
c3Npbmcgb24gdGhlIHdpcmUsIHdoaWNoDQo+IGRlcGVuZHMgb24gdGhlIHdpcmUgb2JsaWdhdGlv
bnMuDQo+ID4NCj4gPiBCdXQsIGluc3RlYWQgb2YgcnVubmluZyAjbiAiMDEwM2g6IFdyaXRlIEZX
IEJsb2NrIExQTCIgY29tbWFuZHMgKHNlZQ0KPiBzZWN0aW9uIDkuNy40IGluIENNSVMgNS4yKSB3
aXRoIHVwIHRvIDEyOCBieXRlcywgd2UgYXJlIHJ1bm5pbmcgI24vMTYNCj4gIjAxMDRoOiBXcml0
ZSBGVyBCbG9jayBFUEwiIGNvbW1hbmRzIChzZWUgc2VjdGlvbiA5LjcuNSBpbiBDTUlTIDUuMikg
d2l0aA0KPiB1cCB0byAyMDQ4IGJ5dGVzLg0KPiA+IFRoYXQgbWVhbnMgdGhhdCBpbnN0ZWFkIG9m
IHByb2Nlc3NpbmcgI24gY29tbWFuZHMgYW5kIHNlbmRpbmcgYmFjayB0bw0KPiB0aGUgY29yZSB0
aGUgc3RhdHVzIGZvciBlYWNoIG9uZSwgd2UgZG8gaXQgZm9yIG9ubHkgI24vMTYuDQo+IA0KPiBP
LkssIHRoYW5rcy4NCj4gDQo+ID4gVGhlIHN0YW5kYXJkIGRvZXMgbm90IHNheSBhbnl0aGluZyBh
Ym91dCB0aGUgSTJDIGxheWVyLCBidXQgdGhlDQo+ID4gc3BlZWR1cCBkb2VzbuKAmXQgbGllIGlu
IHRoYXQuDQo+IA0KPiBXaGF0IGRvZXMgeW91ciBoYXJkd2FyZSBkbz8gQ2FuIGl0IGRvIDIwNDgg
Ynl0ZSBJMkMgYnVzIHRyYW5zZmVycz8gT3IgaXMgaXQNCj4gZ2V0dGluZyBjaG9wcGVkIHVwIGlu
dG8gc21hbGxlciBjaHVua3M/DQoNCk5vLCBpdCBjYW4gbm90IHRyYW5zZmVyIDIwNDggYnl0ZXMg
aW4gb25lIGNodW5rcywgaXQgaXMgZ2V0dGluZyBjaG9wcGVkIGluIHRoZSBkcml2ZXIuDQoNClRo
YW5rcywNCkRhbmllbGxlDQoNCj4gDQo+IFRoYW5rcw0KPiAJQW5kcmV3DQo=

