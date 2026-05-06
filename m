Return-Path: <netdev+bounces-284756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFoFGLn8+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03884D7EA9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C421B303588F
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF23E3C4B;
	Wed,  6 May 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZWjW5XQ"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055C39448F;
	Wed,  6 May 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056270; cv=fail; b=t23LdDtRAJzYXf/jTUpQjHAHt/V++cmFOYKvf+rC8nQAC4RZQ7IiIpl0TMfsL2ZmbbohcdD2OofP0ktyYv6y/lAFbxdXVBkDmy7AT+gsiN5mNDYE2VFh5A6NgdoCG+OBwr/UIRrbkjMvo0O7yjKpwWsHuSf9eqrCq2moeaG5t1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056270; c=relaxed/simple;
	bh=/EXht80vQU9Bp9PUVjpoEFnBeQn/pZAu57zDEmGoxqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t78ifD7bSHZHgJCDbDuPUSK04AiNvsGWji+6dfRGVIGm0FxgDdf8TxEQVR/xNMgQu7QTh8gRiPl+o4O4rSdrVqTLfRprAPjgr/d5H/0Rg8E5+P7Hzj3Tn4rzIzHbekzEu1djcR3R43/okoV7LKpWl+OcXRisa0C862Bnh/ROPjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZWjW5XQ; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE2QsYA9bQETiKjunare81EabN6i1lzIVY39+eW9brJ9ovdaPLFjxZVOo0J7JRYl6glOV+k+nmYXva4Um1gGiq8bWNeMR39uo+cesckUqrLQ+KmCQvDHXQPx02oSSjGPendH9TgMpJ1pGT36YXLD088QhAY1V+roaSNPyOXJ/L+NogBXkIBpcV7ExH+9FYDyIFE/SaOJJkAkk+2sw+Nmjj/j0BZVRfcxddS1D1qAtwADsvWoHLWQmGmHpa5qM4820fiibbdaS0xnIpnkyPors7d/0FQVqs7E/4dCxAw8a62hlC6IrvA61P2IGPFmY7ECKeEirT2Z5uApse8OrHVwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EXht80vQU9Bp9PUVjpoEFnBeQn/pZAu57zDEmGoxqQ=;
 b=i+zWqdIog3kBR+mgsCk+3Y7wXIib8wMOv4wJqVIlZ81w6bVO/p4v7jWq3Iugw776/37dtsEmCcIZt1bC4qJY432xNPByiCIfejBnpvz3gxeC6WINBHYQLhwlJJw7ye3cToHlWrW4ne2f9+0ckc4Tfexiz/yL5x7imPAA7VHFhu3Ic7BkbC+jceOi3vBGish7GqnvYle0nOoQv3Khn3WdoHM9yFt0o+7yhztJnSt/wPtctYDBm/e2gBM4OrKR73wJnARQJDkUvkf9vNPSWEuCQy/sYmojwkQtP0MggLhYM33ArQudUQgSBOoQ0G+RSu4K22Cj++ZQsxB1NKHR6E0tVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EXht80vQU9Bp9PUVjpoEFnBeQn/pZAu57zDEmGoxqQ=;
 b=sZWjW5XQHdI9vcAE7M3PYmSkfzKhq3aYRttnmIX+AF5DS+2qT+x07IO0zTuEwQ00hXG6YETQ5iKStoavhJdlY+RB/KFaSuJsI8Mo2cr2oCsD4qz2DhmFddouZyr2DIQuui1GhgaJFSfxvAGTM8I2qiH3EqWbrTjFON75u3IG0qQwadayng5AVI2gj0/4F5SnyEJ1jK/oS/RVKbCjaTYYNnMoyHdCL9kf0cM/Csle4XjTpGNssrq+6sP5AuSKvC60yXLkJlcOJrhV0FjnxZUx/Na6+f6RNBSjx+rqepH3kl1PUWIAlX4OkQMUZJPjMl08hwnbj5qXoZL1VEaBNdjdZg==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:31:02 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::ca04:6eff:be7f:5699%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:31:01 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "razor@blackwall.org" <razor@blackwall.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "shuah@kernel.org"
	<shuah@kernel.org>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, Andy Roulin <aroulin@nvidia.com>,
	"fmaurer@redhat.com" <fmaurer@redhat.com>, "sdf.kernel@gmail.com"
	<sdf.kernel@gmail.com>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"kees@kernel.org" <kees@kernel.org>, "nickgarlis@gmail.com"
	<nickgarlis@gmail.com>, "amorenoz@redhat.com" <amorenoz@redhat.com>,
	"alasdair@mcwilliam.dev" <alasdair@mcwilliam.dev>,
	"johannes.wiesboeck@aisec.fraunhofer.de"
	<johannes.wiesboeck@aisec.fraunhofer.de>, Petr Machata <petrm@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat netlink
 attributes
Thread-Topic: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat
 netlink attributes
Thread-Index: AQHc2s+NexrgUKRuZEe54VQUMl+TibYAQqwAgABUnQCAAApTsA==
Date: Wed, 6 May 2026 08:31:01 +0000
Message-ID:
 <DM6PR12MB45167562767CFC70DA9AE8D0D83F2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-2-danieller@nvidia.com>
 <20260505190044.0608dfb1@kernel.org> <20260506070334.GA617302@shredder>
In-Reply-To: <20260506070334.GA617302@shredder>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|DS7PR12MB6359:EE_
x-ms-office365-filtering-correlation-id: 5a149cd7-759d-4b63-5892-08deab49ce40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 uN06RF1W9Ixt1GwWaqSXEEeb1H5Sp+Vwk5AMrqZ7VYYip9RrhZmPZTP0h/lpvrCuZG0F7weByzbOSPxt0a6ozFJNyDZpwnOSi4+TgUxZBv/e1Ha+HcSRSqR3thTzM+h9Yaris+c0vPt3VezzHh7DA31MncQMLTjSh3t7LyR+er3BU+qddNsoKM2aeupOpPRwcax5pndDkTkElu4wbGM9ULrRJgRZy3qvGQf6NzFM3eunJVTdTas6RlpTl4hVN7wu+ym1HsIHaAUJD+Gr37H0dlg7wOoep2Q2bmXH+0l4V0bs290BvTfPb78H0EhHUPIDY9wEBubxQZSTEbfuP1dEWgLUarrlh4z/g2A+YdI9IEF4z1hJV+EPM6CP56kCbYiKP55qafdTOH91fm9dgV0ZoQyY5i0kD2WCLomWUcb/O8LIrV/stvfQJREdSuVB7u0YuPxBTv4dTaWw9qFqUQxMLsii9Q9555EFdUGqQWM9DpGbEDVTm959Yg4y1RrepoH3asLZinGgatSoGx0063pWemYJWZaJpRDrNxSKCDSQtTDIMt7QRwmF5fsZCIEkID6yjs1SItPYRyDfjT9MboRCZYqnb2PCzwYWcw1mEpXD+rg8GANKNEUo/oDAaO09TIrQXOOmBrpaOUMuwEobL/4W/MJPwBPJe0jX/5AFSeoWtMtoIOZOghYo8ZDPebUzXqvEmigpInfvjagk7PcTD2O5UtUBYw5sugN7ka++198s0tQWs4NwVO9tMp5av5pLfO0o
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UktxYkEyU0JQSU42N0RVRmZUSlp6SWtFeXJJZ202cWZMSThGZzRnNTMxMEY5?=
 =?utf-8?B?TnY5WmMwckFNbWViTFZJdTN2UkhlUnVyOVFlN0h2M2pFZi9wdXN3Y0t0Vk83?=
 =?utf-8?B?V2xRaWg0VHBPNVNEbjhUR3NFN1VHWnh4YmxBYlNvdmZLUnZLeUY3WjNDa1RO?=
 =?utf-8?B?ei9STFFVTDNkTVFLK0t4Q1BRdXdJZUMrLzR3cXFNSzBRWEt4WEgzY1FMWkF1?=
 =?utf-8?B?dDMxc1EzTDFSRkxSYkFxc3h1RFhqTmVSMFQyWXpnOTkrUmNpOE5xMDBOMkor?=
 =?utf-8?B?T0RoYU1yc3JFc21oR0tyOVBVNXFRa2FFcDZINEx3bFQvUkxQMElzb1IrQUNR?=
 =?utf-8?B?Z2FFWVlYK3YxelZ4UzYvZlBMRTcyNm9CN01YQzJReFQ3U2k1OFpoRTgveXZm?=
 =?utf-8?B?cWJQTDFoc1NTWC9sTWVPenZrdW5DQVRINSt2MTgwcHVsRWRsZitjdXVodDdT?=
 =?utf-8?B?VzBEdC9KRVJwUWZyM3NTR054TE9SOTd2TGo2b3lBeXZ4ckVqbUZNaXM3c2Q4?=
 =?utf-8?B?Y0JSdDhSTEZqWGRVeUhTZTFhckpzbHFWMjVnak1WUkYzVlB2UEs2OVJtUGN1?=
 =?utf-8?B?L1l2QzZnbEtXYUhxOVdSL3NSaTd3Z1RmZzBGdlVTc3NtUjFkci94VFFPL05T?=
 =?utf-8?B?OURXNUVvMHZRdWl1d25kalAxUm1jYzEyOUgyZnRmcC9iOWFhRW1HZEViUGxV?=
 =?utf-8?B?SXBIL2pMOUZvWVhMQnVUQUs2NTFTUUZub0hYdHE2WkhoZDlQZEhnMDZaVlUy?=
 =?utf-8?B?YzdaZjI2S21SWHovcTA4eXFhdy92WjFCVkk3QUVraWNISUFFdHBpOC8yQ2Q5?=
 =?utf-8?B?ZE96WExuSHppUkhFOHJxREVHb1greFJraVhIZTlWQko4ZFBlN1Zia2lqaXZS?=
 =?utf-8?B?WWttNmt5Umt0SHF4emdVaFhZMURtSmdaV0ZVUUpNUDdsek4wd1o3bWN4RFZD?=
 =?utf-8?B?WHBycGkvRE5OYVJoQzFiRkNpY3doU0djeGNUMmhoT1lwckFxREpsdnNaV2NT?=
 =?utf-8?B?MjREQ2lCSnFXSUJuMERMNjNtb3RFNzBBZmloMVZ2LzMvYlFCU1IvUFF1elI0?=
 =?utf-8?B?RkZPcWdxd0IvZGxXbDBGK3ZUS0xyMmVrdXp1ZEJTL2pYRmtscUE1cjNLUTNk?=
 =?utf-8?B?RWJTMmZCdTBwY1pGc3FiZG0ybmN3ME5vdkYzU3FISUw4c3JYSHFQMVU5MHRD?=
 =?utf-8?B?TTlLYzc3NkppYzJyWHJ2aHBJL1MvU21KWUJRdmpsaktlc0EvWVdMbE1KK2Z6?=
 =?utf-8?B?NmNvR01maVBsWU9LTjVmM0ZxSzJ5SUJ6N2lEeHlJT0laZUMwVEV6R0Vhd0ZV?=
 =?utf-8?B?WVVLNGQvTzZBdzczZ2JKM2dCaUVucDllSXdKb1dYczc4SWJqbWFFRlc5SWFG?=
 =?utf-8?B?N1RyekZsbGI3THdLUGpoWVVHZDlUb01lcW9QY0poc0cvRDRhOGZnMHFqQWpZ?=
 =?utf-8?B?dUc1dXVpQkJkb0x5dmFlTTE2UFZPTUlIU3VtUEcxQlJMZlZib2hNdnp2bDZ5?=
 =?utf-8?B?UUoxMUt3QmlES0RCYkxSaU44YUx5V3RpekRaUTJTVVRhOSt1SHVrZ0lKRWtp?=
 =?utf-8?B?TzFKTC95d2VNYjJpNDFieEdzaW9rNmRCR1I4RExzcHRkZXBIZXBCdE5LZWNO?=
 =?utf-8?B?TUQvempxL3l2VHgvZk5iTTdQOWxFV0hPT2lkM3g5WHNaT2txMDdQWlBUQVlj?=
 =?utf-8?B?Q3RUV3p1OTJZZWtVc2tNeTc3ZzJCQkZtSEhCeW0zSkRCdEFhdHBlanZXb2tE?=
 =?utf-8?B?SHk5TGhWZFQvVTEzYUgxMWZNZElPSTVYZTJlbUl5YzZndEQ1UnV5QlBZY2h3?=
 =?utf-8?B?N01zb0sxMW1XK0MwRFN4cng5VStWNTFMMU9ZT0cxMklReU1aaW5pSjRKUEhE?=
 =?utf-8?B?dWtUb21KcnV4U25SM2s0NnhqNWphYXJnRzd2VUdUWU9GcjFCQk96bSs0NWJu?=
 =?utf-8?B?Q1pLKzVtUkhtNTVTTTU1SWRqZ3FHZVN5NEZqQS84RTJrS3dDcE1FcjNWcFFn?=
 =?utf-8?B?a0w5NFhpejVXV3VndU1VZk5wQWZRRFpkbi9EY0VjMllXUGVVVEpoakwzcmhL?=
 =?utf-8?B?WWV4R09RM1dmQlNnUFFhcER6TE82bkloUUhxT0M0L0cvVE1VeXFDMW1DSDc2?=
 =?utf-8?B?UE1TV2Jhb05OTDdqeU9PWXByYjJ3bG9iUlA3Sm9NK2d1bVBiVGp6RzBZaXhw?=
 =?utf-8?B?c2U5bGlLMFlpYzRjRDgwR3ZGL3NrcVZUQU9ScUxjb1NkVjdTRm9TNjR6aU9q?=
 =?utf-8?B?Zk9VL00xWmordG04dVM2T3kzemRWOUxIOTdFK2RTSW1YUHZQZkEraCtjQ3pw?=
 =?utf-8?Q?kS41qlizr/vMiSNUBU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a149cd7-759d-4b63-5892-08deab49ce40
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 08:31:01.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXOBpjbhqR4qUrRJMMR3j2bMtRtJ0PGFG9OgdgX+0E0f9C4PD1fI6y+4C03M6UGWwXbyXBu/IFoNTtcHsVLS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
X-Rspamd-Queue-Id: D03884D7EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284756-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,blackwall.org,lunn.ch,fiberby.net,iogearbox.net,nvidia.com,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZG8gU2NoaW1tZWwgPGlkb3Nj
aEBudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDYgTWF5IDIwMjYgMTA6MDQNCj4gVG86
IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBEYW5pZWxsZSBSYXRzb24g
PGRhbmllbGxlckBudmlkaWEuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gZG9uYWxk
Lmh1bnRlckBnbWFpbC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IHBhYmVuaUByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwub3JnOyByYXpvckBibGFja3dh
bGwub3JnOw0KPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IHNodWFoQGtlcm5lbC5vcmc7IGFzdEBm
aWJlcmJ5Lm5ldDsNCj4gbGl1aGFuZ2JpbkBnbWFpbC5jb207IGRhbmllbEBpb2dlYXJib3gubmV0
OyBBbmR5IFJvdWxpbg0KPiA8YXJvdWxpbkBudmlkaWEuY29tPjsgZm1hdXJlckByZWRoYXQuY29t
OyBzZGYua2VybmVsQGdtYWlsLmNvbTsNCj4gc2RAcXVlYXN5c25haWwubmV0OyBrZWVzQGtlcm5l
bC5vcmc7IG5pY2tnYXJsaXNAZ21haWwuY29tOw0KPiBhbW9yZW5vekByZWRoYXQuY29tOyBhbGFz
ZGFpckBtY3dpbGxpYW0uZGV2Ow0KPiBqb2hhbm5lcy53aWVzYm9lY2tAYWlzZWMuZnJhdW5ob2Zl
ci5kZTsgUGV0ciBNYWNoYXRhDQo+IDxwZXRybUBudmlkaWEuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgYnJpZGdlQGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgta3NlbGZ0ZXN0
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDEvNl0gYnJp
ZGdlOiB1YXBpOiBBZGQgbmVpZ2hfZm9yd2FyZF9ncmF0DQo+IG5ldGxpbmsgYXR0cmlidXRlcw0K
PiANCj4gT24gVHVlLCBNYXkgMDUsIDIwMjYgYXQgMDc6MDA6NDRQTSAtMDcwMCwgSmFrdWIgS2lj
aW5za2kgd3JvdGU6DQo+ID4gT24gU3VuLCAzIE1heSAyMDI2IDEwOjM1OjI3ICswMzAwIERhbmll
bGxlIFJhdHNvbiB3cm90ZToNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vbmV0bGluay9zcGVj
cy9ydC1saW5rLnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9y
dC1saW5rLnlhbWwNCj4gPiA+IEBAIC0xNzAwLDYgKzE3MDAsOSBAQCBhdHRyaWJ1dGUtc2V0czoN
Cj4gPiA+ICAgICAgICAtDQo+ID4gPiAgICAgICAgICBuYW1lOiBiYWNrdXAtbmhpZA0KPiA+ID4g
ICAgICAgICAgdHlwZTogdTMyDQo+ID4gPiArICAgICAgLQ0KPiA+ID4gKyAgICAgICAgbmFtZTog
bmVpZ2gtZm9yd2FyZC1ncmF0DQo+ID4gPiArICAgICAgICB0eXBlOiBmbGFnDQo+ID4NCj4gPiBJ
IHRoaW5rIHRoaXMgc2hvdWxkIGJlIHU4ID8gbmVpZ2gtdmxhbi1zdXBwcmVzcyBsb29rcyBidWdn
eSB0b28NCj4gDQo+IEkgcG9pbnRlZCB0aGlzIG91dCBkdXJpbmcgaW50ZXJuYWwgcmV2aWV3LCBi
dXQgYXNzdW1lZCBJIGFtIG1pc3Npbmcgc29tZXRoaW5nDQo+IHNpbmNlIGFsbW9zdCBhbGwgdGhl
IGF0dHJpYnV0ZXMgdXNlIGZsYWcgd2hlbiB0aGV5IGFyZSBpbiBmYWN0IHU4LiBXZSBjYW4gZml4
DQoNClRoaXMgaXMgaW4gZmFjdCB0aGUgcmVhc29uIHdoeSBJIGFsc28gY2hhbmdlZCBpdCBteXNl
bGYgdG8gdXNlIGZsYWcgYmVmb3JlIHNlbmRpbmcuDQoNCj4gbmVpZ2gtZm9yd2FyZC1ncmF0IHRv
IHVzZSB1OCBpbiB2MiBhbmQgY2hhbmdlIHRoZSByZXN0IGluIG5ldC4gVG8gYmUgY2xlYXIsIEkN
Cj4gYmVsaWV2ZSB0aGUgZm9sbG93aW5nIHNob3VsZCBiZSBjb252ZXJ0ZWQgZnJvbSBmbGFnIHRv
IHU4Og0KPiANCj4gbW9kZSwgZ3VhcmQsIHByb3RlY3QsIGZhc3QtbGVhdmUsIGxlYXJuaW5nLCB1
bmljYXN0LWZsb29kLCBwcm94eWFycCwgbGVhcm5pbmctDQo+IHN5bmMsIHByb3h5YXJwLXdpZmks
IG1jYXN0LWZsb29kLCBtY2FzdC10by11Y2FzdCwgdmxhbi10dW5uZWwsIGJjYXN0LWZsb29kLA0K
PiBuZWlnaC1zdXBwcmVzcywgaXNvbGF0ZWQsIG1ycC1yaW5nLW9wZW4sIG1ycC1pbi1vcGVuLCBs
b2NrZWQsIG1hYiwgbmVpZ2gtDQo+IHZsYW4tc3VwcHJlc3MNCj4gDQoNClNvIHNob3VsZCB3ZSBw
cm9jZWVkIGFzIElkbyBzdWdnZXN0ZWQ/DQoNCj4gPiBmbGFnIGlzIGEgdHlwZSB3aXRob3V0IGEg
cGF5bG9hZCwgdGhlIHByZXNlbmNlIG9mIHRoZSBhdHRyIGlzIHRoZQ0KPiA+IGVudGlyZSBpbmZv
cm1hdGlvbg0KPiA+DQo+ID4gTm9uZSBvZiB0aGUgQUlzIHNlZW0gdG8gY2F0Y2ggdGhpcywgSSB0
aGluayB5b3UgbWF5IGhhdmUgb3Zlci1zcGxpdA0KPiA+IHRoaXMgc3VibWlzc2lvbiBhIGxpdHRs
ZSBiaXQuIFRoaXMgcGF0Y2ggbWF5IGhhdmUgYmVlbiBiZXR0ZXIgb2ZmDQo+ID4gc3F1YXNoZWQg
aW50byBwYXRjaCA0ID8NCg0KSXQgc2VlbXMgbGlrZSB0aGUgcGF0Y2ggaGFzIGVub3VnaCBjb250
ZW50LCBidXQgSSBjYW4gc3F1YXNoLiBJIGd1ZXNzIGlsbCBzcGxpdCB0aGUgY29tbWl0IGJldHdl
ZW4gcGF0Y2hlcyA0IGFuZCA1IGFjY29yZGluZ2x5Lg0KDQo+IA0KPiBSZWxhdGVkOiBUaGUgQUkg
YWxzbyBkaWQgbm90IGNhdGNoIHRoYXQgdGhlIHNwZWMgd2FzIG1pc3NpbmcgKGVhc3kgdG8gZm9y
Z2V0IGZvcg0KPiBydG5ldGxpbmspLiBEbyB5b3UgdGhpbmsgaXQncyB3b3J0aCBhZGRpbmcgdG8g
cmV2aWV3LXByb21wdHM/DQo=

