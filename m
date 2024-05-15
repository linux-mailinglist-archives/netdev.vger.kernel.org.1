Return-Path: <netdev+bounces-96453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDF8C5F53
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06751F221BF
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FF37142;
	Wed, 15 May 2024 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iu31dhs2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BF381A4
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742643; cv=fail; b=dzr2Q9plHmy09hCS8AepqFDE0RZMf3L7tHfhW2bBXi16PzY3VLqYj3ZesWhRVLAOzEt13yVgYbglXNWKBGTkVrK+DpUTlNxnNudYV42mmCuOZPqXLvrc3r4X/7h0c75tqzDZTWLDHFWSN9oHwacyEQcYCtume6iXE/oxfz3MydU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742643; c=relaxed/simple;
	bh=fseAwI6V/sHXE0QKba45VIrFe1zkCyEvkizWYB9YyGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOet4L0NsSR6OqAFHdUpM0fcreqh7/ALxXV8qXTUhyvkjmTSgt7Xxlv/7/ENz95xVpZTOaB0Ahfx4T2nvuva7InH/sQg/dMYqcizD/i1+7l7k42vxn+fGBEDnp3pNDSzJV1za8b+j48rbmlcPwpjeQuuWAFwcro0BcAndnk/ZAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iu31dhs2; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwyJBtCzYK5lhJBAku6VPasLFAXgTYa7QtlIRfnGGnSDcCnPS5d9rpxrrbGLbK5w9aGUFZ9Dc8K0Kv6ir1yLnAdlPYyvRE8/jhV4h7lK922iMtJsvchBBBs7v/TEXuIwxYOarcKVtieNPYmAZpmGO4JJtVw+A6DLQvva86i73ylWvm2nAT1Beo4PF5MoyURr0VL1tncQRS7EGzeVkk4AQBs3qQkmhYATCGS8PZJjW87Mlx23DhzyvTpxoblV/AzFlCiAI6WIgYnhXnSLu39jfqxJUFOcBgeVDAwujevlbCArTgpltPFUWPtmJnKkrpc3N6hMWs6DtPvN+AoVCbeQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fseAwI6V/sHXE0QKba45VIrFe1zkCyEvkizWYB9YyGI=;
 b=cwOBLnU718pCR492Oo4b3l/LTlFPIweHr9zhd+gBNk1NeDgMpcCTGVIIf0zHvMPTdnFwBgR32mJhP0zIdBjFqpkOTpICSATMsc/Q1stwujvGnLvggBc4987BZiXyvWrhkAn6pKgdWs5ufei3JZd3V0NY5SaS5F6Y/2oxCMwtwHZs6RQ+wy1E1ySGhO7Zo0hp010m+o08o2wQ3Vao3ah4Oj0NJZ3OTEqCvpWQM+KD7GJhzsn+E4BL1uciEjenH+JIvzTZbvzuRBhb4ta1Qmgm8ShhzKL6cjFLuufe23uSazeHCv2DfX7cyZj1WwvVN45nM2T740QQ51o+Ug1HqZHE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fseAwI6V/sHXE0QKba45VIrFe1zkCyEvkizWYB9YyGI=;
 b=iu31dhs2Kht2C11a0zvVxCbONRzHxBpUoiYOr/vuDTp9b7rOS+tUExtqenIg74bcmjrWYUt1QObhYbp5C+8ESHbHARCiCTkDh7RoBpYICgmvc68tGuPg6gDphG8QtGLPfT6kNN6zVQUu/wG8HaWeK8lwHbeCFfjHHOWILlBfRzGeDcXpljXP5gek4MTommAKOidQgJOt+lXIzxfFxVDGZws4oPyWW3gXqXiOHVLtpXBdsuiak/FH+Ky8exEE2XTDvq4lwclAoBmu2JofRHKc8LUH+yzk5l5WSBFatO4ZKFZFBO5sLVVjtzsKXuEjiwV42xiR5vQC3fdCx+QWYu7Fng==
Received: from IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 03:10:38 +0000
Received: from IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4]) by IA1PR12MB6235.namprd12.prod.outlook.com
 ([fe80::da5c:5840:f24e:1cd4%6]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 03:10:38 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: "edumazet@google.com" <edumazet@google.com>
CC: Leon Romanovsky <leonro@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "fw@strlen.de" <fw@strlen.de>
Subject: Re: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Topic: [PATCH net] net: drop secpath extension before skb deferral free
Thread-Index: AQHapRztf+XVv59L3kGimcbRJBg/jrGU9qgAgAFhhICAABVtAIABMxeA
Date: Wed, 15 May 2024 03:10:38 +0000
Message-ID: <93610999a3541f41ea9b66dbc0d9dc7d2882dec7.camel@nvidia.com>
References: <20240513100246.85173-1-jianbol@nvidia.com>
	 <CANn89iLLk5PvbMa20C=eS0m=chAsgzY-fWnyEsp6L5QouDPcNg@mail.gmail.com>
	 <be732cc7427e09500467e30dd09dac621226568f.camel@nvidia.com>
	 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
In-Reply-To:
 <CANn89i+BGcnzJutnUFm_y-Xx66gBCh0yhgq_umk5YFMuFf6C4g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6235:EE_|LV8PR12MB9336:EE_
x-ms-office365-filtering-correlation-id: 2a482317-7700-402e-964f-08dc748c98ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXlKN2VUOVBIUlJuayt4UHVVUkluQzZudTRSRGhrcHpmbWVvSUk5MkNFZVJP?=
 =?utf-8?B?VmRmUFE5NmVHSnFkTTB5aTZvajNEak9rdnlCNkl1eFlkVWNOU1NBN2I5c3Fs?=
 =?utf-8?B?cFd5anlZNXNDbWNiRnB6MmxOUVRuTzhjOEhsWnJwRE1Tcmd5emJBN3FqcXph?=
 =?utf-8?B?OVlISU5KVGVRUEZQenpjcWRtL2ZQQkNpUno4OXlVVCtuazBNR2owNWZOSmJz?=
 =?utf-8?B?U0U4b2VEVUViZFRmbGl1Rm9CRWZCQ2Vid1J3d2l6emhVQmFhdCtFV2J6Sjgw?=
 =?utf-8?B?ZVptWnFWUFJlaXNqODd0bHhSZXNtM2ZTMFVRZy9QRkp0MWpURzR3KzJFKzZM?=
 =?utf-8?B?M09rZDlOWGFaM3VJR1JkaEpXQjhVa3BCVG9HSXVHU085SlRBVVg0cXdqTmRR?=
 =?utf-8?B?TWY5Wi93UUYrR0JvREdRL3pPRW9oT3dIU2FaQy93MG1COW56bUo0UTUzVHZN?=
 =?utf-8?B?SVFZVkVNNDF1dTNKdmhmMk1PclRPMWFrVUs1aGRsQmsyZ0hnMFBpMURnWGVP?=
 =?utf-8?B?b0Fsd1pUZnRla2FiWUVXSVJWZ01ic2lqbS9meHA0U1NDcGZhOVFua0J4MjZ6?=
 =?utf-8?B?OEsvbzFZWFdPaXlJSGlXeUdqMCtGN1FSNnMzd0o4ZEVSNCt5cHdOUUIzVUM0?=
 =?utf-8?B?ZHJCckdpTGc5Q3BML0ZqSUdnNFF1UmxXcXVLWlBlRUNuMlN1M0lVSUNMbm1x?=
 =?utf-8?B?MWpXdzFPTjNaa3pHWWcyaGVKVzhtQUkyTjJrclVjeElwVnVYc0dZRW1uTHlk?=
 =?utf-8?B?NjlLVFlINFJaVnZZOFFxbDJJUWZRbGxIRXZZRFk3aWhaUVVYZGJKRXc4dkwx?=
 =?utf-8?B?dHJ1eWNqcHM5NVlZZ1VvTnlZUnNqb2d1RDFDTTVKaVgybW1hanNOaW1sRDgx?=
 =?utf-8?B?ZmlFVjJValZMc3pTY0hpTTM1N0haY1M2ZUkzU3BGK1d1TlVJM3FsRXhMU1Vu?=
 =?utf-8?B?a2w1ZCs0NmlZVnhyTW1JZVJXdUJ2WXpucXRpSVN3RXNLQjBXUytGYjhkM1JO?=
 =?utf-8?B?N0d3YU13RS84dVhuNVBlN0gwSkltaGUwVHQwSnN3RGRMczNOR3hWUnVkZWZw?=
 =?utf-8?B?S0ZwSGc5Sm5rK3RMWVNPWVVHWm1nKzFBZXN2bSs4Mnl5Q0hXQWNCTnpUdGF6?=
 =?utf-8?B?YnBXcWRKNHp5c05Da21UeGZCaXVjZC9XZ0ZqTjNsVzVmUmlQYkRWM09XQTk0?=
 =?utf-8?B?QlN1S2wvMnN3dWtaQ2cyamljUFo2eWRBQmhsLytabmRaYUhVRzZ4UWt0aW5Y?=
 =?utf-8?B?ekd2YWFlZGM5VHlUMUUwWDFLb3hIdXU5QmhPZFJoWWJuc2tpWW44d2JNWndq?=
 =?utf-8?B?YTNXODRPRzFOWnEyWkNhUTRORnQvbEtITlV4bzY1dXNJWW51Yy9xaWdmZThu?=
 =?utf-8?B?a0JKL1p1QmFxWlI4d2kzK0NVTFFBUSsvRVowOEYrNFhTMnFCU1R2c1dOYmdD?=
 =?utf-8?B?OEJhRXVPWVpqQ0JiYXBDT05JWXRkTVozYzNIRUl4T0EvMm9iN1M5VjJhR1h4?=
 =?utf-8?B?OHQ5R2w4dlErbiswN3UyOGpIazVPb05GRDg1SFF4MGNYdHZFY2RTSnNNaXAv?=
 =?utf-8?B?MjlHU2tVbUNVTTdrTEZwNTJhTWZsQ0tZNUFmNUl3WU1CeThNMEZad25aKzd4?=
 =?utf-8?B?OUNWNTBISW9ZYm81YmNNbkh6ZlRzNk8vSkhnb1AzQytET2N6cmJ0bzlLUjhj?=
 =?utf-8?B?NlJjOCtsS0xJd0o1WFFUSEN1b3U0Q1ZPQmV3SlZwRVNEVTdBS2tXN3haWUh6?=
 =?utf-8?B?U1h5bXVMNkVrQjZjTVpXeXRaaWVNSlY0R2hQT0czNWRFTURjOEJJZ01LN1Ft?=
 =?utf-8?B?RklVVzdkWm92cGtQaDB1QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6235.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDZWd29GMVlGT3RLUllhOCs3RkoyNEtCQ0Rhdmp6RmNWdkMrV2NmUFNCZzhj?=
 =?utf-8?B?STFxL2pkaE1XcitNeWVLYU9XY1ptbGMrRmVRWTZSZ0FwU1VEL1gxTTVlRTZY?=
 =?utf-8?B?eXc1ME1LNXdzTU1tVkNrYjRGSC9veTcxK2pxRVFYRGtlUHRydnk3ZWp3SHdJ?=
 =?utf-8?B?WWR0OVpVRjhCMk5vZUphVm9BcnNub2V3Nm0xUWgxOVFiTjZ5elg3bEhxQUw3?=
 =?utf-8?B?SlpDNnpvYUl4YlZMKzVrSFd3UlRtd2lKL1hDREVzMlNoc0tDUlM0dkpPM0FF?=
 =?utf-8?B?YytEbWxwMlNFZlR0ZlVOcEg2NTBZcjVQVTVVejV3aWdaL2swaERJTVRKUmdT?=
 =?utf-8?B?ZHYrdXB2eit2ZWl6b2RDYk40KzNaTTBlazBmVndjRmROdzkrTWlvSndHeHlB?=
 =?utf-8?B?WnQxOUlhS2tMb052UTRORHZqQXFrL2g3WklvUjhwcWZMUXRwSW9aZ1VVVWVK?=
 =?utf-8?B?dnJSK2N4MUoxcjBxdlBYSzl0SGhYTHpSOE1pcXZualdtQ0RucHhSSkVsMWdj?=
 =?utf-8?B?ZlRyRjN5Vy85Tktzc0JmYk1FUmlIRVBKY3cyNG1pSzVUNXlGMXQrdWlQL3dI?=
 =?utf-8?B?dUx3V0dCa0Z0V0dLS1p5cFk5OU1QSEN2TFFYMVo1WEQ0RGFmV3cwdFRLS1pk?=
 =?utf-8?B?K1JVNXhkYVNTMFBzbVZlVnh2cmFtRWFjTkNmdzZkNW5GanBZa284ckwxMFp6?=
 =?utf-8?B?cnNyL2NScHVydi9DdnpwOFF3VjIzSEkrOTA3NkpQN3lWYXZkV1Z4ay9KZ3Ev?=
 =?utf-8?B?RGdaejZNSHFvV3BqVEhIeGNBdlFXUFl5SlBkQ1pnaTdQK3h5NlNQdlBjOWhL?=
 =?utf-8?B?aXBGbG1zUkFuRFFsMzc1NmVvcmxsMXlCMUwvL00rWi9pUm5SU0N5TnpsT1lW?=
 =?utf-8?B?dXVjcCtKVU5ubUI2YW5GZzc5NDl2SjlRYXl4MVpQbFUycmN5OHFsNDNaaE11?=
 =?utf-8?B?YkFkSmM3eC9JUUNLUThvVVdDQXlMbVFlRytEbEtTd0s4R05WbFBieXpjUEdO?=
 =?utf-8?B?b2kyMG5vVDZEU3NkUVY4aGlxWEZWOFNZcUFHN0xWbVpPSTFWOGFmTlc3Wkw3?=
 =?utf-8?B?RGxmOGpTRnQ3Y0NXM05vVUl5RWtVZDdRSkkrbk0yQzNiOXVRYUptaFFkSXRp?=
 =?utf-8?B?Y0U4NC9SaDdGVno5QTJ0OFpWajB2ZUNSWHhYR01XUWRqQ2FqSjFHM25KSEk5?=
 =?utf-8?B?TXNEN0E2VTRybXNFYTNiUWhHRVJCYW1ZTWJVZXRTUlh0dGliOUcyK3loaFJX?=
 =?utf-8?B?cVdFd1pwUTRvTGpyRmszVUYwSkFxc0FOYUYxNVdmMHpBdmxTQmpVWXcvK0lN?=
 =?utf-8?B?czJzb2ozRFdKZVpDdjFNRTc4dlhXcVF4UUNDRjI1eFBiS1hhd2FMemQrc0dz?=
 =?utf-8?B?dG1NMVY0R3NTWDdoZTkrNXpzLzY5UVdEVGNVQitUUlBjZi9RMEl1Rlc0SThu?=
 =?utf-8?B?RHFMZ3FtenZGS0VmeVFxV093dmZWNW5UUnB5d2dibHFRL0NGbDllbVFnNUVj?=
 =?utf-8?B?YTRDUkxNTElxdXRabFFvbERzU2pBZjhZejNPaFdNQ3ZOUlZVQWZKa3huTDFn?=
 =?utf-8?B?M1Y4d1dFaEVEVWQwemlhMEl3UUE1bGYyNHNjR3hKMjA3TEszMkl0UVpzbkxP?=
 =?utf-8?B?dXJKZENPRUx0a01kdy9qcmVDeDBCM2dCMTl6S2F5RHBRRWlnK2x6QXhFWmVn?=
 =?utf-8?B?WTc4RUtLT0VTVHNRRWRmK004L0wyd05qRFNaTlhrM0ZnWHdXS25ueHFqR0t5?=
 =?utf-8?B?UTBUN1RpT1YvMENLRUNuMGh6RkNGdktpSUZITk45azRHeEdvYjZ3YzRTei9E?=
 =?utf-8?B?SnRCUWZvdDNaWWc4WUJoUFlIczNxQkRtaW9Oa05OUmYrOUR4L3lwZ084OTVj?=
 =?utf-8?B?dVVLdUpFOS8yUit2WWhnUU9HWllQS0crVnd5YzBTR1pEYkprUi9SdzkwbXBk?=
 =?utf-8?B?Z1NjckRBS2d2QWozdHppcnFITlBHenV6SGtneDFyTzVlckRnRTFySytwd2lm?=
 =?utf-8?B?blhxejRhYzU1Y0ZFOXJWYUdvS1NBTlRjQTZZQTNkVXVvOGFaeXFWbTZ4MXBS?=
 =?utf-8?B?MFBnUjdwVFlPbk03MlJaZVhIUlFDU1FweEN4U1BvQlJ1dHF1blJ3bVI2anJL?=
 =?utf-8?Q?BwLGQ7NeEuYY0ndNsKlLQnkYh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE8F1FCC36B81749BAD1553D48ACD384@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a482317-7700-402e-964f-08dc748c98ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 03:10:38.5442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfJEzMP423qbuHtRjyXByFr8bxkb41o5hBHeFYLJO5Tz0evsNs0rkkotJmPY+7GBkptioPoRmHxvMGfczJtw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

T24gVHVlLCAyMDI0LTA1LTE0IGF0IDEwOjUxICswMjAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDE0LCAyMDI0IGF0IDk6MzfigK9BTSBKaWFuYm8gTGl1IDxqaWFuYm9sQG52
aWRpYS5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNC0wNS0xMyBhdCAxMjoy
OSArMDIwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0KPiA+ID4gT24gTW9uLCBNYXkgMTMsIDIwMjQg
YXQgMTI6MDTigK9QTSBKaWFuYm8gTGl1IDxqaWFuYm9sQG52aWRpYS5jb20+DQo+ID4gPiB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+IA0KLi4uDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhpcyBh
dHRyaWJ1dGlvbiBhbmQgcGF0Y2ggc2VlbSB3cm9uZy4gQWxzbyB5b3Ugc2hvdWxkIENDIFhGUk0N
Cj4gPiA+IG1haW50YWluZXJzLg0KPiA+ID4gDQo+ID4gPiBCZWZvcmUgYmVpbmcgZnJlZWQgZnJv
bSB0Y3BfcmVjdm1zZygpIHBhdGgsIHBhY2tldHMgY2FuIHNpdCBpbg0KPiA+ID4gVENQDQo+ID4g
PiByZWNlaXZlIHF1ZXVlcyBmb3IgYXJiaXRyYXJ5IGFtb3VudHMgb2YgdGltZS4NCj4gPiA+IA0K
PiA+ID4gc2VjcGF0aF9yZXNldCgpIHNob3VsZCBiZSBjYWxsZWQgbXVjaCBlYXJsaWVyIHRoYW4g
aW4gdGhlIGNvZGUNCj4gPiA+IHlvdQ0KPiA+ID4gdHJpZWQgdG8gY2hhbmdlLg0KPiA+IA0KPiA+
IFllcywgdGhpcyBhbHNvIGZpeGVkIHRoZSBpc3N1ZSBpZiBJIG1vdmVkIHNlY3BhdGNoX3Jlc2V0
KCkgYmVmb3JlDQo+ID4gdGNwX3Y0X2RvX3JjdigpLg0KPiA+IA0KPiA+IC0tLSBhL25ldC9pcHY0
L3RjcF9pcHY0LmMNCj4gPiArKysgYi9uZXQvaXB2NC90Y3BfaXB2NC5jDQo+ID4gQEAgLTIzMTQs
NiArMjMxNCw3IEBAIGludCB0Y3BfdjRfcmN2KHN0cnVjdCBza19idWZmICpza2IpDQo+ID4gwqDC
oMKgwqDCoMKgwqAgdGNwX3Y0X2ZpbGxfY2Ioc2tiLCBpcGgsIHRoKTsNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqDCoCBza2ItPmRldiA9IE5VTEw7DQo+ID4gK8KgwqDCoMKgwqDCoCBzZWNwYXRoX3Jl
c2V0KHNrYik7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHNrLT5za19zdGF0ZSA9PSBU
Q1BfTElTVEVOKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHRj
cF92NF9kb19yY3Yoc2ssIHNrYik7DQo+ID4gDQo+ID4gRG8geW91IHdhbnQgbWUgdG8gc2VuZCB2
Miwgb3IgcHVzaCBhIG5ldyBvbmUgaWYgeW91IGFncmVlIHdpdGggdGhpcw0KPiA+IGNoYW5nZT8N
Cj4gDQo+IFRoYXQgd291bGQgb25seSBjYXJlIGFib3V0IFRDUCBhbmQgSVB2NC4NCj4gDQo+IEkg
dGhpbmsgd2UgbmVlZCBhIGZ1bGwgZml4LCBub3QgYSBwYXJ0aWFsIHdvcmsgYXJvdW5kIHRvIGFu
IGltbWVkaWF0ZQ0KPiBwcm9ibGVtLg0KPiANCg0KRG8geW91IHdhbnQgdG8gZml4IHRoZSBpc3N1
ZSBpZiBza2Igd2l0aCBzZWNwYXRoIGV4dGVuc2lvbiBpcyBob2xkIGluDQpwcm90b2NvbCBxdWV1
ZXM/IEJ1dCwgaXMgdGhhdCBwb3NzaWJsZT8gDQoNCj4gQ2FuIHdlIGhhdmUgc29tZSBmZWVkYmFj
ayBmcm9tIFN0ZWZmZW4sIEnCoCB3b25kZXIgaWYgd2UgbWlzc2VkDQo+IHNvbWV0aGluZyByZWFs
bHkgb2J2aW91cy4NCj4gDQo+IEl0IGlzIGhhcmQgdG8gYmVsaWV2ZSB0aGlzIGhhcyBiZWVuIGJy
b2tlbiBmb3Igc3VjaMKgIGEgbG9uZyB0aW1lLg0KPiANCj4gSSB0aGluayB0aGUgaXNzdWUgY2Ft
ZSB3aXRoDQo+IA0KPiBjb21taXQgZDc3ZTM4ZTYxMmEwMTc0ODAxNTdmZTZkMmMxNDIyZjQyY2I1
YjdlMw0KPiBBdXRob3I6IFN0ZWZmZW4gS2xhc3NlcnQgPHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5l
dC5jb20+DQo+IERhdGU6wqDCoCBGcmkgQXByIDE0IDEwOjA2OjEwIDIwMTcgKzAyMDANCj4gDQo+
IMKgwqDCoCB4ZnJtOiBBZGQgYW4gSVBzZWMgaGFyZHdhcmUgb2ZmbG9hZGluZyBBUEkNCj4gDQo+
IMKgwqDCoCBUaGlzIHBhdGNoIGFkZHMgYWxsIHRoZSBiaXRzIHRoYXQgYXJlIG5lZWRlZCB0byBk
bw0KPiDCoMKgwqAgSVBzZWMgaGFyZHdhcmUgb2ZmbG9hZCBmb3IgSVBzZWMgc3RhdGVzIGFuZCBF
U1AgcGFja2V0cy4NCj4gwqDCoMKgIFdlIGFkZCB4ZnJtZGV2X29wcyB0byB0aGUgbmV0X2Rldmlj
ZS4geGZybWRldl9vcHMgaGFzDQo+IMKgwqDCoCBmdW5jdGlvbiBwb2ludGVycyB0aGF0IGFyZSBu
ZWVkZWQgdG8gbWFuYWdlIHRoZSB4ZnJtDQo+IMKgwqDCoCBzdGF0ZXMgaW4gdGhlIGhhcmR3YXJl
IGFuZCB0byBkbyBhIHBlciBwYWNrZXQNCj4gwqDCoMKgIG9mZmxvYWRpbmcgZGVjaXNpb24uDQo+
IA0KPiDCoMKgwqAgSm9pbnQgd29yayB3aXRoOg0KPiDCoMKgwqAgSWxhbiBUYXlhcmkgPGlsYW50
QG1lbGxhbm94LmNvbT4NCj4gwqDCoMKgIEd1eSBTaGFwaXJvIDxndXlzaEBtZWxsYW5veC5jb20+
DQo+IMKgwqDCoCBZb3NzaSBLdXBlcm1hbiA8eW9zc2lrdUBtZWxsYW5veC5jb20+DQo+IA0KPiDC
oMKgwqAgU2lnbmVkLW9mZi1ieTogR3V5IFNoYXBpcm8gPGd1eXNoQG1lbGxhbm94LmNvbT4NCj4g
wqDCoMKgIFNpZ25lZC1vZmYtYnk6IElsYW4gVGF5YXJpIDxpbGFudEBtZWxsYW5veC5jb20+DQo+
IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBZb3NzaSBLdXBlcm1hbiA8eW9zc2lrdUBtZWxsYW5veC5j
b20+DQo+IMKgwqDCoCBTaWduZWQtb2ZmLWJ5OiBTdGVmZmVuIEtsYXNzZXJ0IDxzdGVmZmVuLmts
YXNzZXJ0QHNlY3VuZXQuY29tPg0KPiANCj4gV2Ugc2hvdWxkIHByb2JhYmx5IGhhbmRsZSBORVRE
RVZfRE9XTi9ORVRERVZfVU5SRUdJU1RFUiBiZXR0ZXIsDQo+IA0KDQpBbmQgSSB0aGluayB3ZSBh
bHNvIG5lZWQgdG8gcmVwbGFjZSB4ZnJtX3N0YXRlX3B1dCgpIHdpdGgNCnhmcm1fc3RhdGVfcHV0
X3N5bmMoKSBpbiB4ZnJtX2Rldl9zdGF0ZV9mbHVzaCgpLg0KDQo+IGluc3RlYWQgb2YgYWRkaW5n
wqAgc2VjcGF0aF9yZXNldChza2IpIHRoZXJlIGFuZCB0aGVyZS4NCg0K

