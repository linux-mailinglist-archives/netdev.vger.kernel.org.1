Return-Path: <netdev+bounces-192555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB6AC0619
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C9D1BA2501
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02972242D80;
	Thu, 22 May 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b="DH57B7MR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2113.outbound.protection.outlook.com [40.107.101.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5C23F421
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900153; cv=fail; b=ZLzVVTxvE2+UH6z+t3/gvRFmfM8xOnpJpJo3xZGyGOlERApNaAMt2P0OnpherqptrBsNw3+KkLI1cSWvLP7StpM0WImbTYfa+gvYGe5IAm59K/K4dW0ARlv+lJoMW91Tfg2nGwyXJtydszM9ZQds8mZfhzaRSzl7jMOjmesZ5qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900153; c=relaxed/simple;
	bh=uBd8YAb4eA71vyj2Ro4ksccF57fs6gnL1uA1GQVHIHc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mo8hvPvuZgDXZT7FnedigxT1L0HNTKhqBTDEAFMxF3PTKnOWFr/gtmxybCYC4Lcn331tbHgpaHcKawHIWCnNGY5kQqgeOf0TK8B1ipClzI+KTZolzYTnkT5k4Tc548fdxYb/Sl4GKc7aZeNYozsE1jrLsTJC/IqQ27yeqqWTN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com; spf=pass smtp.mailfrom=zenlayer.com; dkim=pass (1024-bit key) header.d=zenlayer.onmicrosoft.com header.i=@zenlayer.onmicrosoft.com header.b=DH57B7MR; arc=fail smtp.client-ip=40.107.101.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenlayer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenlayer.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2yaKVmms3EuPhHnvf1ytfWk0T/GHtNGS6Jy/+GANFM6ArUJmFeMai8WD6qXXMGf6bIMH9UNB1r8BkxFXUSxsAs3uzR1EG0sGsNFmLOp9yxxXASViA0bajLOm3nrVP9S078oI3okAWqpqRbOI/Q5IkzWIx/gcpiU6zEiXESTDtXOman1kSCDf7WUmSm3W9BfcGi/N/GUwNGeXyQCYNhxsUZf2aFucsr4SEhAtQfK27m8hQzCGasOtbcQZuMPFFtla3Mo2Luvc4812uD7T8gOAaaC9BmxjeWLVvXzND2cJg2f7U5xkgxeCeuBD2Qb1B/CNSiMru2wIb+rfMtWnZWoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBd8YAb4eA71vyj2Ro4ksccF57fs6gnL1uA1GQVHIHc=;
 b=fknLbHKCJkPC88w1JyYjWz3mGEqDJStVc2hDlrBuRg3fSAg0k0EOTFQwIEs64957rNBjBFZBLAUUvYn24UwqLJFM3EAD01103KOJooM8O6L3mXHdMYsbz4hYRO9fRUahNMk5GnQBfmrjkDv/ixtovtBFYlPyWmG0OnHpWewKTU4UTBe8Bhi2AYHZVFwZp14xKU+ffLc0y+wThwI5PR8zKAFmBaUhvlAE5vVnhUwfeTveKhM9bdeUJF5DX+spfrSIOn5l3m40CyMVZxk3ooporfnqpIh9aeq6RDtOuTcjdTMVL+msH10uNxvWutlPga3+eHorENvjx95UyyuunrPB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenlayer.com; dmarc=pass action=none header.from=zenlayer.com;
 dkim=pass header.d=zenlayer.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zenlayer.onmicrosoft.com; s=selector2-zenlayer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBd8YAb4eA71vyj2Ro4ksccF57fs6gnL1uA1GQVHIHc=;
 b=DH57B7MR9SNag6UBAthhCgXIxPAX7Bl3+AU7RWvESWgM1YrnPDSciaRuDeMC9f7dcT81TqcPOcSdl+EyWjf0VhRBf0bs6MSO+7PPifwplbXf1/YSEo/3aZ6iSaTtIZmQalq3t3qQggfjATrb7l/8ZINlcX7o2aMbD7gjGzjKun0=
Received: from SJ0PR20MB6079.namprd20.prod.outlook.com (2603:10b6:a03:4d7::19)
 by MW4PR20MB5180.namprd20.prod.outlook.com (2603:10b6:303:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 07:49:09 +0000
Received: from SJ0PR20MB6079.namprd20.prod.outlook.com
 ([fe80::2c78:c02d:92:3811]) by SJ0PR20MB6079.namprd20.prod.outlook.com
 ([fe80::2c78:c02d:92:3811%4]) with mapi id 15.20.8699.019; Thu, 22 May 2025
 07:49:08 +0000
From: Faicker Mo <faicker.mo@zenlayer.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "dev@openvswitch.org" <dev@openvswitch.org>, "aconole@redhat.com"
	<aconole@redhat.com>, "echaudro@redhat.com" <echaudro@redhat.com>,
	"i.maximets@ovn.org" <i.maximets@ovn.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "martin.varghese@nokia.com"
	<martin.varghese@nokia.com>, "pshelar@ovn.org" <pshelar@ovn.org>
Subject: [PATCH net-next v3] net: openvswitch: Fix the dead loop of MPLS parse
Thread-Topic: [PATCH net-next v3] net: openvswitch: Fix the dead loop of MPLS
 parse
Thread-Index: AQHbyu3/VJZsMK3bUE+qTE9tcCwtgQ==
Date: Thu, 22 May 2025 07:49:08 +0000
Message-ID: <21855B7D-A3D5-4031-A618-CCA8FD75B6FD@zenlayer.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenlayer.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB6079:EE_|MW4PR20MB5180:EE_
x-ms-office365-filtering-correlation-id: 70138865-24c0-427c-b0af-08dd9905227c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjhLRUpQblpkVDFkU0xPOGhRM01TZExvTmFUQURCV1I2TVVSL2o4QThmaDBF?=
 =?utf-8?B?T1RKL2NIdjY2RzdwTUVtTkVvT2ZHak5pZ3FSNUlZbTFNSFZRanJpdllHbUkv?=
 =?utf-8?B?Q25idm5ZLzBXdTU0M29MSjJSMzUxMk1RZlh0RlVSbFpkbjArTEtLR3NQRnA0?=
 =?utf-8?B?aG5iZGJ6bUdnZUxJeFo0Y2l0NlU2UlNuUm5RVk95VTYxVzM1aE1BdGJMRVpV?=
 =?utf-8?B?SFFnVkFqaHdWdG1XTm4wUDZWY3ZWR081NnhTOEhCdVNmcENTZGpCNEo2VnZR?=
 =?utf-8?B?c2Z6czR6Q016K1JBeWhtY1o4YWk1R0J5aW1hSW5xUEN0V2xsaWlrK2d5U2NF?=
 =?utf-8?B?bU5YcHUrVTV4dTlHb2hGQm9nbC91ODh6TCtPaE5oRzZrS3d6bWxqbUFtQ0wz?=
 =?utf-8?B?RThFTml3aFA5QVRzaXBVQ25la1NXa3hxYml0THJVYkRJVGk1aWZXT2prZlUv?=
 =?utf-8?B?TUpsdWpsbWFYdE10dmI4MmMwK013amptQ250L1ZlRFJ6b3FtVHVMaDNHUTVa?=
 =?utf-8?B?RXZRMnZZbE1lRGpVQUo3aWQ0czQ5aEdnZ3dzUzNqUWgzWXU4L2VyNG5la3Bv?=
 =?utf-8?B?cDhHamdRTExvNnBQVmk4RkUvVWNXUjkwc3A1b1VaT1hxVEhlVk5BSmV3SDZx?=
 =?utf-8?B?dUd6R0Vnc04zNkJUQnJrWndLTy9xQXNTaUJmNlhIeVpCTDRRaWt1YWQxNGdP?=
 =?utf-8?B?elJaQWIxQlMyN1YrOEdtaFdUaXU4ekpXekh0WDVVQU9wdG1meG0xT0YzVmVt?=
 =?utf-8?B?WmVXaWh1dFVxRWIyRmlvakN5aXQ0dExmNmIrVlJXWGcwamtNT0VOeUNUL0dt?=
 =?utf-8?B?VmIyN3pyT1NlQW9vcVlNakFhR3RYZGl3alNaY1BoU29UVU9QK21iWGZDb05l?=
 =?utf-8?B?cEZtb1ZIMnV0YThpeCtGaDE1bGJsamtyVzJDWVZ5cStiUzQ4bHJ1RXZqdjA0?=
 =?utf-8?B?QVR6YWNUZzZWakQ3bjdudXNzYkliLzl5MTMvYjJDclZSZjBRSHlmSjRING9K?=
 =?utf-8?B?aEV0UHRoT3psTGhsUk9FRFdCR2pIckZzbm9wYWJXMWZ6RU4yTWhjc0xEdGtG?=
 =?utf-8?B?c2ttUmJ4aGJiZkg3OUp2aDIrdSsxYUYyREtGOEdyMFdxdWxFVXl2cWNBR0E0?=
 =?utf-8?B?U3F3NDRlVWNHSW5xaGdwL1dLNFVsWDEzdEwxZkRzcTNzWGJ0bGJUdnl1dWhz?=
 =?utf-8?B?ZFVYRGpYYjNJTkhQWnRwbHdOOTNIYVo0b0ljL3B2R1pOUnhObWFaTzZ0cFlq?=
 =?utf-8?B?NDgzamZCMDF0TDRFSFZDRlNKWmxvLzVVUmh4eDhvRmdkZ2U5QnVBb0JHLzE4?=
 =?utf-8?B?dG1YOWwvdnA1WjkxOEtNSUpidHpjbE52cTQvaGlneG83ZUZLcXFEQVdFOHl3?=
 =?utf-8?B?aW41OHp1RzZERDRQNEFEbW5aTjdELzZYRGhxRXVVYlBvYW14NTY5WFhnQkw0?=
 =?utf-8?B?cUdObE96bmo3dGthQ1ZrNGtQU1o0S2Q5Y1p2ZEsyT0hCQXBOK3RFVXlFMHhx?=
 =?utf-8?B?OFdNVnBjWU8vTTNkR2g0SzQvYmgyODFDZVYxQS9tOWp5Ty9wSHN2QkJrMXhL?=
 =?utf-8?B?ZmtkTHBrVXhXWm1RRVM4S1Y5TzMrZ29CZFpwUUpCTXlITUtQNjhkVStCY1pw?=
 =?utf-8?B?d1lhMEZja3pMSkVPSUpxdXJRNEpwNGUzV3dOM3hJQ01ReGVkYldSUXZ0bDVC?=
 =?utf-8?B?Nm1aaTc1S00wVkZUVzlRWEVoS1lrMFlQYmZBeVpkck9BbHNXOXcvaWFydjZP?=
 =?utf-8?B?alI5Z093ZCtBVTFrc1M0RWNnd2lTNWJIZTNvRTJwRzg1QkQvUVNiZjFlQ2R2?=
 =?utf-8?B?WldRQ0c1M1NaVXFYTEVyNkx1bmEzNjIzUHNZYUNmRG1iTkN2SldTeFlCMEtk?=
 =?utf-8?B?K3lIRklQOHp3RVBjOVhyMk1RR1FSTHVObUxPZEs5QXBtbGM5MzJuY29TbWRp?=
 =?utf-8?B?Mi9Jajl0b2tzeUdoaDNpSUpETkFEUlB1UkxvTzN4UE1uS0REZmEydzNYZWRE?=
 =?utf-8?B?R0dDVHlVblFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB6079.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkVVa1N5em9UNWNoM3RLRkN6bGlva2ZxZVNkMHBxUmJnV3ZwZ3pzVElOZzBu?=
 =?utf-8?B?ZG14N09NNVpUcTFUY3NKOHQzTHBJMGJhMExxejZZNEFPV0J3a0Y4KzNOZ3JX?=
 =?utf-8?B?V1FnWWxLdkw5TWt4aVcxMnZyYkpWc3NMV3lrVDJqa3gwY1pDWXlRNjEvbUNt?=
 =?utf-8?B?VjhsK0V4OVFhS09SMXBuaUdUTHZZUHg2MmlGSmNad1dESHE3Y3haS05LYVph?=
 =?utf-8?B?YnhDTkJOcEpvdjl5b2hjbGxwYlBrZGFQQXIxTnRSVEc1QWNRZmF3bkZoWUZK?=
 =?utf-8?B?aUdlQ2RvaVpBQ01MYndhNUszZHkwVnRDb1pRSHVuVDlCU2pGMW1TdTZwZ09L?=
 =?utf-8?B?WHU3aUJrTm90VHBOck1ubUlscHpJSXZodjNIdGRRVWticWJwbEZhcUI0TmpB?=
 =?utf-8?B?clRDelhuUU1QUTJ0YVptY0RVM0VERjJjM1VWbjJkemxGeUhTd2FWTzhILzA5?=
 =?utf-8?B?ZGExdzdMRzdCREhnQ2V1d0krVW1BaEFwQ2RhbGorWUUxY1pMYkZtTnpDdFB6?=
 =?utf-8?B?U2piRFB5ZDV5N2xWRXFiUVJEcGFnK0R3YVFzbG05ZGRDa1V0cHNYLzRJUDB5?=
 =?utf-8?B?c0lZblZJR3BkdWdnd05pMnFTY2UwTDdTeHZJZWsxampLVkorQkxxSHZnaXZU?=
 =?utf-8?B?U3hqL28yNGxubGp1SU1vUVQ3R29zVzVyUkhacTc2UGZlQk8xdTFOMDhpRktT?=
 =?utf-8?B?cElVMHB5Qi85QldPTnc5dU5oblJlSzhNT05MWHBUWDg3SGpVTmVxd1BpRkd3?=
 =?utf-8?B?ZU5OZ0Y5WjRIQmtSUnpYcmVyY1ZhbTZkeWVRYlQydURRaWh6UjdjM1dJd1My?=
 =?utf-8?B?dzVvTGRyQU1WMUIrN1RLWDJnZ0xUditjMUlYSHJHMTB3cmpSU0tNL2pRZjZs?=
 =?utf-8?B?UHI5aStKeHI2UkVSY3FoV1EwK1B5cnhtZGpNSXF2U3ZQKzA5bDBlS1BRSWhC?=
 =?utf-8?B?WnlaKzdER2lMZDlxdlpxZ05nMUR3cDRuR3BqVW4wVjVleU5nejRyZWttdWlv?=
 =?utf-8?B?d1g3cExNZXFackwzUDRPMk9TNVRhdURhLzR6TTZIT3FkanBycmVaQTRXdzFv?=
 =?utf-8?B?NGxJeWwrUFpvTDNjaGtjbkQ1dXRnaUMwNnR1ajJGNUpNVi9UU3FoOUs5MHdR?=
 =?utf-8?B?ZnhBbGlEOHMyMmFNZmpPM1A2TzV0NktoTTdGNmtoRGU4a0R4ZEl4dlhkcTFO?=
 =?utf-8?B?MW5Xa0RKMk5FSldEaC8rblFHWGVRb2ZyQmp5NmJHVTh1dzR2bWZRWE5RVTlB?=
 =?utf-8?B?NTZLNHRkeFVabmFCUjdmcittb0x6ci94cHhYb0RzVTd3QkFURGZMQXJIcnJB?=
 =?utf-8?B?V1ZlQVdhc2tUK2toY00zQkp6MENmSm1SeGZVMlAwYlVqS0NYL1dZUDB6WjFq?=
 =?utf-8?B?VFp1NktEaHVheXNaWkRXV3dGM2dNZGtUbmpiMVdVNWhzUnA3TER5YktzRkMv?=
 =?utf-8?B?aHJ2ZXJ4em5nd0U2em9KeTZ3VytTYzhWZGlhMjBxYUkvN0REb3ZDK1M4a1No?=
 =?utf-8?B?ZjFCVmE2dlZWeXB4TlNtckI1R3FVTVZBTlpGSER1M3FXWUtBT3lhVzYvaExK?=
 =?utf-8?B?MHMyMU1Oc1NYQUJjK1FiamhYRnNVVk9VTzZ1VnNYc1NBZWZ1SENITjltS2pM?=
 =?utf-8?B?TEJwRGUvcHpnZDltaEpSazJ2RCtxZHlqdjdoQXV3dWFaNCtyTldVaDJydDFB?=
 =?utf-8?B?TVFzckFabTg4QVlsMTNJbnkrdTdhc3d2UEdFNklvZi83L2tFT256c3RaU0xT?=
 =?utf-8?B?d2J5bmlhM3VVYmpodGNxZ1RubjVmWG15RGp6d2xSL2JBRWgvb2ZvWDZmSjNl?=
 =?utf-8?B?Rnp5a3F1SlRuOXlveUkxQkZEb3pmZjE5UG5ZQVh6bFovYnRBdGNVOXlIR0JL?=
 =?utf-8?B?QmM0NjF5Q0Y0emtXSUUvWCtTV1l5U0FBeVp5akZNVFVMK3J3QkxJb25BZE5J?=
 =?utf-8?B?amZkb2hDZEgwVFVFZXU0TksrVHNZazVKV2dEeE42b2ZMbDNpdUF6K3R6VFR1?=
 =?utf-8?B?UHZ0YzFMQ3d3SnMzRjB0eDFxeXFNQnBUeDNGcmJKdWxUdEgzRUVKNlVEckhm?=
 =?utf-8?B?QVBzemRxd3ZNZjVoRHdaTVhjdFBMTVhzWHYrNnQ2bTk2dUM3WUxuUDE5bFBy?=
 =?utf-8?B?WDNNRTJpb1B3V0JBWUErZnpUMFk3MzhxMWxPdGNnazYwdXh1QjNpV3AvVzBR?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <341EC15FB8D7F24691E998681F702740@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zenlayer.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB6079.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70138865-24c0-427c-b0af-08dd9905227c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 07:49:08.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d27725c-b11d-49f0-b479-a26ae758f26d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YorlNoNfa2FzWRzBFjfRI7A0lG2bd2opjhp4k20qjCjQMtjBWlRmJfhMpk4kvCPp2084PZoR5Bl1OsiQHpUQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5180

VGhlIHVuZXhwZWN0ZWQgTVBMUyBwYWNrZXQgbWF5IG5vdCBlbmQgd2l0aCB0aGUgYm90dG9tIGxh
YmVsIHN0YWNrLg0KV2hlbiB0aGVyZSBhcmUgbWFueSBzdGFja3MsIFRoZSBsYWJlbCBjb3VudCB2
YWx1ZSBoYXMgd3JhcHBlZCBhcm91bmQuDQpBIGRlYWQgbG9vcCBvY2N1cnMsIHNvZnQgbG9ja3Vw
L0NQVSBzdHVjayBmaW5hbGx5Lg0KDQpzdGFjayBiYWNrdHJhY2U6DQpVQlNBTjogYXJyYXktaW5k
ZXgtb3V0LW9mLWJvdW5kcyBpbiAvYnVpbGQvbGludXgtMFBhMHhLL2xpbnV4LTUuMTUuMC9uZXQv
b3BlbnZzd2l0Y2gvZmxvdy5jOjY2MjoyNg0KaW5kZXggLTEgaXMgb3V0IG9mIHJhbmdlIGZvciB0
eXBlICdfX2JlMzIgWzNdJw0KQ1BVOiAzNCBQSUQ6IDAgQ29tbTogc3dhcHBlci8zNCBLZHVtcDog
bG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgNS4xNS4wLTEyMS1nZW5lcmljICMxMzEt
VWJ1bnR1DQpIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIEM2NDIwLzBKUDlURiwg
QklPUyAyLjEyLjIgMDcvMTQvMjAyMQ0KQ2FsbCBUcmFjZToNCjxJUlE+DQpzaG93X3N0YWNrKzB4
NTIvMHg1Yw0KZHVtcF9zdGFja19sdmwrMHg0YS8weDYzDQpkdW1wX3N0YWNrKzB4MTAvMHgxNg0K
dWJzYW5fZXBpbG9ndWUrMHg5LzB4MzYNCl9fdWJzYW5faGFuZGxlX291dF9vZl9ib3VuZHMuY29s
ZCsweDQ0LzB4NDkNCmtleV9leHRyYWN0X2wzbDQrMHg4MmEvMHg4NDAgW29wZW52c3dpdGNoXQ0K
PyBrZnJlZV9za2JtZW0rMHg1Mi8weGEwDQprZXlfZXh0cmFjdCsweDljLzB4MmIwIFtvcGVudnN3
aXRjaF0NCm92c19mbG93X2tleV9leHRyYWN0KzB4MTI0LzB4MzUwIFtvcGVudnN3aXRjaF0NCm92
c192cG9ydF9yZWNlaXZlKzB4NjEvMHhkMCBbb3BlbnZzd2l0Y2hdDQo/IGtlcm5lbF9pbml0X2Zy
ZWVfcGFnZXMucGFydC4wKzB4NGEvMHg3MA0KPyBnZXRfcGFnZV9mcm9tX2ZyZWVsaXN0KzB4MzUz
LzB4NTQwDQpuZXRkZXZfcG9ydF9yZWNlaXZlKzB4YzQvMHgxODAgW29wZW52c3dpdGNoXQ0KPyBu
ZXRkZXZfcG9ydF9yZWNlaXZlKzB4MTgwLzB4MTgwIFtvcGVudnN3aXRjaF0NCm5ldGRldl9mcmFt
ZV9ob29rKzB4MWYvMHg0MCBbb3BlbnZzd2l0Y2hdDQpfX25ldGlmX3JlY2VpdmVfc2tiX2NvcmUu
Y29uc3Rwcm9wLjArMHgyM2EvMHhmMDANCl9fbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9jb3JlKzB4
ZmEvMHgyNDANCm5ldGlmX3JlY2VpdmVfc2tiX2xpc3RfaW50ZXJuYWwrMHgxOGUvMHgyYTANCm5h
cGlfY29tcGxldGVfZG9uZSsweDdhLzB4MWMwDQpibnh0X3BvbGwrMHgxNTUvMHgxYzAgW2JueHRf
ZW5dDQpfX25hcGlfcG9sbCsweDMwLzB4MTgwDQpuZXRfcnhfYWN0aW9uKzB4MTI2LzB4MjgwDQo/
IGJueHRfbXNpeCsweDY3LzB4ODAgW2JueHRfZW5dDQpoYW5kbGVfc29mdGlycXMrMHhkYS8weDJk
MA0KaXJxX2V4aXRfcmN1KzB4OTYvMHhjMA0KY29tbW9uX2ludGVycnVwdCsweDhlLzB4YTANCjwv
SVJRPg0KDQpGaXhlczogZmJkY2RkNzhkYTdjICgiQ2hhbmdlIGluIE9wZW52c3dpdGNoIHRvIHN1
cHBvcnQgTVBMUyBsYWJlbCBkZXB0aCBvZiAzIGluIGluZ3Jlc3MgZGlyZWN0aW9uIikNClNpZ25l
ZC1vZmYtYnk6IEZhaWNrZXIgTW8gPGZhaWNrZXIubW9AemVubGF5ZXIuY29tPg0KLS0tDQp2Mg0K
LSBDaGFuZ2VkIHJldHVybiB2YWx1ZSBiYXNlZCBvbiBFZWxjbydzIGZlZWRiYWNrLg0KLSBBZGRl
ZCBGaXhlcy4NCnYzDQotIFJldmVydCAiQ2hhbmdlZCByZXR1cm4gdmFsdWUgYmFzZWQgb24gRWVs
Y28ncyBmZWVkYmFjayIuDQotIENoYW5nZWQgdGhlIGxhYmVsX2NvdW50IHZhcmlhYmxlIHR5cGUg
YmFzZWQgb24gSWx5YSdzIGZlZWRiYWNrLg0KLS0tDQpuZXQvb3BlbnZzd2l0Y2gvZmxvdy5jIHwg
MiArLQ0KMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9uZXQvb3BlbnZzd2l0Y2gvZmxvdy5jIGIvbmV0L29wZW52c3dpdGNoL2Zsb3cu
Yw0KaW5kZXggOGE4NDhjZTcyZTI5Li5iODBiZDNhOTA3NzMgMTAwNjQ0DQotLS0gYS9uZXQvb3Bl
bnZzd2l0Y2gvZmxvdy5jDQorKysgYi9uZXQvb3BlbnZzd2l0Y2gvZmxvdy5jDQpAQCAtNzg4LDcg
Kzc4OCw3IEBAIHN0YXRpYyBpbnQga2V5X2V4dHJhY3RfbDNsNChzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdHJ1Y3Qgc3dfZmxvd19rZXkgKmtleSkNCgkJCW1lbXNldCgma2V5LT5pcHY0LCAwLCBzaXpl
b2Yoa2V5LT5pcHY0KSk7DQoJCX0NCgl9IGVsc2UgaWYgKGV0aF9wX21wbHMoa2V5LT5ldGgudHlw
ZSkpIHsNCi0JCXU4IGxhYmVsX2NvdW50ID0gMTsNCisJCXNpemVfdCBsYWJlbF9jb3VudCA9IDE7
DQoNCgkJbWVtc2V0KCZrZXktPm1wbHMsIDAsIHNpemVvZihrZXktPm1wbHMpKTsNCgkJc2tiX3Nl
dF9pbm5lcl9uZXR3b3JrX2hlYWRlcihza2IsIHNrYi0+bWFjX2xlbik7DQotLQ0KMi4zNC4xDQoN
Cg0K

