Return-Path: <netdev+bounces-206164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD797B01C74
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5837A641094
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B412D23AD;
	Fri, 11 Jul 2025 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUZ1p3jo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD692C327C
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238649; cv=fail; b=j+optobv+6DEdBFeUqKGNg+WZw8tZBkxfko2PUGjItcLDg5ec3db2ecURyo1LXazS3G5CxRIHpsQnpwbZQbzJT2nkMT3GEFVyk6choUX9d598u8cXnNwhWB3grrP9m3mZJ7uPZINoUlpa/al7S/nXk7hkjmk0+Mh9WLuN9PDjVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238649; c=relaxed/simple;
	bh=AKoNvNkcICr0B0hT/itOVc7+9bx1WRbQqfZkqfEcqoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1UFrNgETHnFRvoak8aXbordGopvQaUUKXrO1JpbQmrt5YWe0bMfTvQBNQGf9k9Lf1qyvEOs4Ue9vylz1Br0YyggWg7uEF9NZMgS5X8y0zQ61d/eHdntsYpZOUEHc/P6EOagjciMpS5semq78w3DxBXQRef5FlOKcOvR04WMv7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUZ1p3jo; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPrMjWrtTGRbMGxAoKrtZGiUgSuRXfyg04lGhTOPxlr2h12IxoieSDqyDx39UfsS4EGcviDi87HGhhvF2uI2qVYIYYE44GY7+ugu8zU8kAG6XO0QkpAgPM7yex8WSX70OMWjYuhNwtpDLMUloLnQeZEqr0vtq4d9GjTYNvI2ghWOjU8IZxqewuNubRbdjBG+gVboTg0Ad3dEDBCM4CWJNjvC1Dsdd7E+nhILPaw34CxSkmTVX4iapynh0zftRUP2nlIcN3pgtUe6qsrbJMzLSCjkg65FJG20aryk587Af4bKgoCor5nY7kNAp4qvVRAV07tle4LMaVUjD+M9v7YmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKoNvNkcICr0B0hT/itOVc7+9bx1WRbQqfZkqfEcqoY=;
 b=mOkBM1UC+qmv31BLmf2XK5JO2FyFX3MqGuHR+aVfbaeGqcelt+//UntCYDbN2IurErh9/62EfmAVvPKHmb5LNBtUPXrUpsC5neHEyntjykXuj8EDdm8CUgEDNdEUjdnXQkPHuhBgKN/WIEimrAl57tSSlWnmW2yYERz/aCdUHAV8LpnUB7DzE9WZXCc3bF57WcKGk8WMmiHM5bnqFGKYuFvo5JKVZouyRDbI+idN8zJY6Aon+g4YC+Nw8kd4rjB3x/luuhkDattzkOKP+47mVCAzrur/umUcCKCjv/yvPLkE841YNH/gfykXSzduhy72iuezwW5WzkN5N6VOkseWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKoNvNkcICr0B0hT/itOVc7+9bx1WRbQqfZkqfEcqoY=;
 b=DUZ1p3jovETMTvqkP+9vqJqBgF6T99NkLC+oYaJERPTaWENdOv4PAGU5p7UWtbJyG+gLcp3mKmhlACm4avZiTuN6x86uKczgLsIUqMG4LgUquyU2xFi35BjyCnRikA1pb0+GqS8/gZ1bLLJ+uW1CIGG8kBOw0jajWs8sEaP81cgqkNevlFWF+hgTmytNPFTvduukag4+qd18A8PypM+pY6Idy/1h4FBCrU0sHjoGSwd1vkOFzuWG5x+szCzIIAxgsIuJQmtIfPi0+s3thKEncVgj1V0Pf1aBoRYkIelTpfxFvVZ5oHBPS4nhX6M+51vfttLDKjBNWRSokycLS5DUkQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SA1PR12MB7344.namprd12.prod.outlook.com
 (2603:10b6:806:2b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 12:57:24 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8835.025; Fri, 11 Jul 2025
 12:57:24 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>, "edumazet@google.com"
	<edumazet@google.com>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: Boris Pismenny <borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "leon@kernel.org" <leon@kernel.org>,
	"toke@redhat.com" <toke@redhat.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, "willemb@google.com" <willemb@google.com>, Raed
 Salem <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"ncardwell@google.com" <ncardwell@google.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 12/19] net/mlx5e: Implement PSP operations .assoc_add
 and .assoc_del
Thread-Topic: [PATCH v3 12/19] net/mlx5e: Implement PSP operations .assoc_add
 and .assoc_del
Thread-Index: AQHb63TiABAekxzx7Uic9iQg9YWwi7Qs78aA
Date: Fri, 11 Jul 2025 12:57:24 +0000
Message-ID: <c575ff8db3e5f4f53b67fe820d5e0af767a78af8.camel@nvidia.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
	 <20250702171326.3265825-13-daniel.zahka@gmail.com>
In-Reply-To: <20250702171326.3265825-13-daniel.zahka@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SA1PR12MB7344:EE_
x-ms-office365-filtering-correlation-id: ba0a2e7e-37a1-40c7-4b4a-08ddc07a7b44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFI4R2hnMmNYdE9YN28xOEoyeDlKa1RQNCtLWk1sdmdZdTRFbjdzQmtXUTVO?=
 =?utf-8?B?TWhVZm5oWGVMVVhXczNXVTA5Ly81MXIyczBSUTNwOHhjZWtRRC9La05aMUxN?=
 =?utf-8?B?dDl6SUZpWHhrSXNtelg1bExCZXQ2US9CQm5wSkhBU1NLV05raW14VVkwWWtK?=
 =?utf-8?B?c3YxT2RIQjRkSUgvVWUrU3BQSTl0aDZkMElVSFRjeExaM3FVclErb0FOazg4?=
 =?utf-8?B?TFNkY1JyYXZuRnZQN2NrU1RscVY3VnNaRnN6Nlg3THZxS3AzdnB6Zit4cktl?=
 =?utf-8?B?eWc4aWpkRFlLOVZ3SzM0c1RXT2N2cW5FZm05QldFVDNZczNSSTVYWCtjVVFt?=
 =?utf-8?B?d2pmQzBZNnVLa2FKUmpidngrVEh4dkdmOEltUGFVUUloWjEyZTRrZGtFRXFn?=
 =?utf-8?B?UXJMUDByTXpqblpaeHpZMVc1WUp4LytYbndVMzRGaTBPV1NuejM1aWExTzVk?=
 =?utf-8?B?RWVxMTZjSTByTHNlWnYyQzcyV2F6d0F3S2l5L1YwZFZ5eTQzblN6UUdCY3p6?=
 =?utf-8?B?eHQ5UWJiMkZFS2F5UXh0aURiREpWelNBUGFKdmMrNktQUGtRVStMOG9KNzRs?=
 =?utf-8?B?OVBBeFU4eXptQmhLUjJmYjZtaEdjZXFuRWpneVZpdEZzZlNVSUk2Z3B0QmZK?=
 =?utf-8?B?VG90cmgwclVWR1VZQzVQSVg4TFVMVmVmbm9nMVE4dk9RNEVDZmJ1U1F6eks3?=
 =?utf-8?B?c0Y2WlMwd3V2Vzc1N0ZHcWNpT3lDeStnQU1saUJ6RHkxQktmNkRkaUdYK1JY?=
 =?utf-8?B?cUVxRVJoT0FINjVZMXVLR2tPZmYvNWZiVUZneDUwS0tITzlDWVRhY1FWbEw5?=
 =?utf-8?B?WkRwbEFkcW9zaWovQUhnNTBZRG5DQWMvTG5GY29YRWlhVms2ZllqM2dmZThz?=
 =?utf-8?B?RDd5TEdleHhlZXVDaSt0cThpdzNTQ0ZiVXdOU3RXYTA4ZzNuYmRqT2tFeU1n?=
 =?utf-8?B?d2VxMzN5NnBxeWRxMjBqb2didGZ2YW5PS1phdmtCN3dwVDhYZ2lQRWhYTytt?=
 =?utf-8?B?dGo3emlCbW9vZXE2cXJrblBSa2trUkVSajJDQmNTd2ducFJ6Qm9BY1A4ZlFk?=
 =?utf-8?B?NmV0VkdleEx6cU9OTkRNMnlMdXNWdzErNHRzUGNrRFdkMFhRamUrTGlwZ0RL?=
 =?utf-8?B?dGpLYjNjYWxQcVNlRHRjRTUxZE5jZzNOUG9lRi8ybnM4blhFZTZiZkFrSGxU?=
 =?utf-8?B?alF2RHdQTXFuR0g2UnhDM20rUDMxcW42azZYbmNkWDZUbUxoeXJpQUcrbkNN?=
 =?utf-8?B?Y2E1L0pZY1hMcFRvdHFXUDJHNHpNdmpnaEtPUzluRnVDbStyYk1yZkQ1OGNE?=
 =?utf-8?B?SVl4dElmWFJINWxNdVovN1Y3TURjRG51ZStIbkZNWWFBT2ptVlFHRXFsMkNu?=
 =?utf-8?B?Wnc5dlRxeVF2ZWlKY0ZxUkQycUhKa0IrdzN1T0YrYU1FU0N0RVgyekVZYTRh?=
 =?utf-8?B?OGdOZGpyUEZSTGJYdnh1R1lXTXJ5WEVmb3NoRm1DVHgvZUlRZEtGYytaTG04?=
 =?utf-8?B?ZWVXYWZOYytua0dUL1Q2ejQyTnQwSGxJcy9LZGlUcVB4c2YwaDZKTmJRQVFM?=
 =?utf-8?B?OU9CY3FzQVoxMWVLWGdGN1l4WDVIQjdCcndrbzEzb1MxUzg2UGQzTVhWZlIy?=
 =?utf-8?B?U0xIUzZEZlVtUHlHejlheWpDWlBLcjRhekJUdUNyOTVQMkJEV0ZzVEg5TVRI?=
 =?utf-8?B?bE9nVytPUFc1WWYxZ0o1Q1FiOGsybDdyVlVoZFRTcThJTGpkVzVaaEFnRFdP?=
 =?utf-8?B?OHIxSmIybzJGWEpQbG1CSDdyNjRURC9DT0pJSjFVRmFWNG9OZlVGZ0ZDd2ZT?=
 =?utf-8?B?RWwrZW9hNjNtMTFEdis3VnVOQk1TbmpqbXRkTytadTJJSEFJamowSXVEb1g4?=
 =?utf-8?B?RG5qVHNXTmkrY1M5Mlc1NGl3WGYrSHpTSDlwaEFTbjVGMnhNSlJ1U1pEL1pY?=
 =?utf-8?B?Q3ZyM2ZHTFFMSWZZdVdFYk10RVVKN1BCbnIxQkM0MHJkSWpWUWFtK2ttRG92?=
 =?utf-8?Q?K1OMKt8YroNEwDZTxC7S9JJZM8szhU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXJrb1ZQbk9ZVUlndC9va3p3UzQyb2RteGVYTUd3MHJlR3pzRHRMbGpmcXhZ?=
 =?utf-8?B?SEY3OW5nNU5BNC9HYjQxdEpjZEJ5Ny9UQjBBMFNubFZiK1lvYko2eEJONXli?=
 =?utf-8?B?ZVJhYzRod0RySnZyUklDZ2F3MjlhVnhOa24wZXpvZnJ0MTFobDhKSUlVSkJy?=
 =?utf-8?B?Ym4vZ0RaVWpMS3dHQml5UE8yS0pNNEpUSFM0NzYzMHVZdWRiMVF5QmZsWmgv?=
 =?utf-8?B?QkZxUlBieUpHMmxhZFEvT0xoSlIrN1VHWjAxSFI3MzVYa0JkeXo5UkJ5bDVB?=
 =?utf-8?B?Ukx5NFFXZHgwWWJXY2dOQjFSM2crc2dsRmdQZnlYVjJNSys3YzBDZTdHUjM5?=
 =?utf-8?B?bTJJUzNxUXUvUHNWZU9JWGUrc1NWL254bW1UTDJiRnlrVlhweHE5OWUxSGZu?=
 =?utf-8?B?U1RSU0F5NFZRZDVFNVduZ3ZoSTc1OURGVFhzalozSzJXM0pPdDVXZkRyVXpN?=
 =?utf-8?B?UkpoeUQxVGpkQWlwVGRMbEMwSDFTUHBYUER5d1Z5eUErZUNwakFIWWdCaE1O?=
 =?utf-8?B?VE1GTXpmeVZkTDVBaitiQ0xuZ3ZMSkVuTldsdlNNcVBYR1JmMGhTdWl5OVZ3?=
 =?utf-8?B?OWN3VFBwYTY3RFVZdC91LzZFQzE4bkhIUDV6emNPck1HZjNMWDA0VTdudXFV?=
 =?utf-8?B?Yy9HQnBMVDU4T3lpOUc2Q0xBN0dsMnpzTVhoMUl5WGRiN3gzU2N5czE1NUJs?=
 =?utf-8?B?ZkRVaXBnM2VHMUlmaGtLd09VVEZVaTF1RXZyaUFoTVplNjZDY0NXb1RPZ0RQ?=
 =?utf-8?B?Qm1WSmNueGRUaFNyWGI1Q2RLcDFsa01ENlZkc1pKdDJMV0VoS242aTd2Q2dW?=
 =?utf-8?B?eXQxNFkyMXFJRGxQUVd4UDdKMlE2Q24xd0N6c2J4OFNMekFXQXpnQU1CbnJp?=
 =?utf-8?B?Z09oWnVJd0R0SHFBb3ZVclBYRFNMZllDNVl2WWk5VEczbk9ZNE9weFdnbCth?=
 =?utf-8?B?VDgwbEhSd2hxYW5ZL0JsYTlqS3hLQjZXR2xwajgxNUJZQ0IxK1ZTL1RVL2VU?=
 =?utf-8?B?dklFQVZnTkd3R21uVW83RmVZN3dRSGZHMExwSXBOcnQ4eEJHS1JPUjM4UWQv?=
 =?utf-8?B?Sk1yZVhNZHpsQzB4QlhQbGxZbTRQczkyT0tXTXZOdjZxM2t2eldWNWIrajRu?=
 =?utf-8?B?YkhjeXphajUxclA2dXM5Mmh3VGwxR1Bqdk9jU2tPbllCTzI5R0hVUjIwQ1Ex?=
 =?utf-8?B?aEVlY205YjNVNFNDdHIwTHd6bVFXRzIvU3VRc0h4UnIzbkFMeldLOTVUeEpV?=
 =?utf-8?B?dDBDeWdrSWYwaDFuZy82aGY3Sk96MVBaS0JVTW5PcERLcHNYOFBwalE2bVJY?=
 =?utf-8?B?T1BUK0VzcXltUzFrQUJjTkV6U2VJOEhXMHdvb083TlVPS2hmVzB6NTNTQVV0?=
 =?utf-8?B?Zm43TkRoWXlmN2d1OXRkaTJoeG5RSU1aQXdqcEg4VmNzVjRVaGJEdCs4MTNI?=
 =?utf-8?B?M04xVGlETUs5WWhvREpNTzhiUldPMGY1QmZIVGN3KzN4TnRNWTBDck1PVFFO?=
 =?utf-8?B?SHhYYkZoeU15VTRMZGVmK3czQk5hQ1ZqZUdZZVNncUEvaWIvRXJpbHRyQmYy?=
 =?utf-8?B?c3I5LzZqOXpkMmVtL216ZXFGK2ZQU0tPMXlNbkE1UFpjUzdkR2t5TDdLRi9V?=
 =?utf-8?B?eFF4L1UrUERoQzhvdlVaUXV4WnkvMVRLVjRaM3lWTldKcmdZN2ZUby8vTFA4?=
 =?utf-8?B?OTZ2YjU1ZnRUNW05WGZmbURHcUR2dmVKZzRkVWVTeWpRQ25mVk1yeGJzNGZH?=
 =?utf-8?B?cE9oR0xYWjROejVETE9hKzhkeGdzK0dxeTJpUlBOTXVHQWIzTE1CaEkyTDU2?=
 =?utf-8?B?c1dEdVFFWFM1MkNJNmlycWxrRnFrZmVDOXB6Zmw4S1V6NFBIUk9mbVJ3ZG1N?=
 =?utf-8?B?K0E4VEFuWFNTb3pGamFsSW5SdnliWFdKOC9yQTNpTVlVa3E0NzMvM211SzFI?=
 =?utf-8?B?RkFSM0ZnTDB3UDljSFB5Tkw1cGF2WC9VVm02Q1hqTmFNMFFaSVlIQmpuTnpK?=
 =?utf-8?B?Y28rclduOVpTUGNQUXZ1amYvSEhQb3lXeXVUeE04UWxOVU92bWRMU3lXOTV0?=
 =?utf-8?B?RWNIVFl4eG5TQ0ZhQXA3RjNaT0cwQ1BoOFAzcER5eXU5NGhXbkxjU3ZPMmxX?=
 =?utf-8?Q?RmIBUx8lHseTse8y1jcuM5N/u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51E38F02BE84A74D87009CE97F927DBF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a2e7e-37a1-40c7-4b4a-08ddc07a7b44
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 12:57:24.2953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EprNBvjYuxrHqBRTT3EMwqOXJH1OPUG+FCaxPnXurDnN4X8OQAQZtRgfoioq+Lj9rrALXcZKHByTt9Q6dX3tZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

T24gV2VkLCAyMDI1LTA3LTAyIGF0IDEwOjEzIC0wNzAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IEZyb206IFJhZWQgU2FsZW0gPHJhZWRzQG52aWRpYS5jb20+DQo+IA0KPiBJbXBsZW1lbnQgLmFz
c29jX2FkZCBhbmQgLmFzc29jX2RlbCBQU1Agb3BlcmF0aW9ucyB1c2VkIGluIHRoZSB0eA0KPiBj
b250cm9sDQo+IHBhdGguIEFsbG9jYXRlIHRoZSByZWxldmFudCBoYXJkd2FyZSByZXNvdXJjZXMg
d2hlbiBhIG5ldyBrZXkgaXMNCj4gcmVnaXN0ZXJlZA0KPiB1c2luZyAuYXNzb2NfYWRkLiBEZXN0
cm95IHRoZSBrZXkgd2hlbiAuYXNzb2NfZGVsIGlzIGNhbGxlZC4gVXNlIGENCj4gYXRvbWljDQo+
IGNvdW50ZXIgdG8ga2VlcCB0cmFjayBvZiB0aGUgY3VycmVudCBudW1iZXIgb2Yga2V5cyBiZWlu
ZyB1c2VkIGJ5IHRoZQ0KPiBkZXZpY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWVkIFNhbGVt
IDxyYWVkc0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSYWh1bCBSYW1lc2hiYWJ1IDxy
cmFtZXNoYmFidUBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgWmFoa2EgPGRh
bmllbC56YWhrYUBnbWFpbC5jb20+DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+IMKgwqDCoCB2MToN
Cj4gwqDCoMKgIC0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjQwNTEwMDMw
NDM1LjEyMDkzNS0xMS1rdWJhQGtlcm5lbC5vcmcvDQo+IA0KPiDCoC4uLi9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxlwqAgfMKgwqAgMiArLQ0KPiDCoC4uLi9tZWxsYW5v
eC9tbHg1L2NvcmUvZW5fYWNjZWwvZW5fYWNjZWwuaMKgwqDCoCB8wqDCoCA4ICsNCj4gwqAuLi4v
bWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcC5jwqDCoMKgwqDCoMKgwqDCoCB8wqAgNTUg
KysrKy0NCj4gwqAuLi4vbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcC5owqDCoMKgwqDC
oMKgwqDCoCB8wqDCoCAyICsNCj4gwqAuLi4vbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3Bz
cF9mcy5jwqDCoMKgwqDCoCB8IDIzMw0KPiArKysrKysrKysrKysrKysrKysNCj4gwqAuLi4vbWVs
bGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcF9mcy5owqDCoMKgwqDCoCB8wqAgMjMgKysNCj4g
wqAuLi4vbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9tYWluLmMgfMKgIDEwICst
DQo+IMKgLi4uL2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9saWIvY3J5cHRvLmjCoCB8wqDC
oCAxICsNCj4gwqA4IGZpbGVzIGNoYW5nZWQsIDMyNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwX2ZzLmMNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcF9m
cy5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4
NS9jb3JlL01ha2VmaWxlDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL01ha2VmaWxlDQo+IGluZGV4IGUyN2RlNzRlZjAyOC4uNWQyNzgzZjJlODJmIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvTWFrZWZpbGUN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL01ha2VmaWxl
DQo+IEBAIC0xMTAsNyArMTEwLDcgQEAgbWx4NV9jb3JlLSQoQ09ORklHX01MWDVfRU5fVExTKSAr
PQ0KPiBlbl9hY2NlbC9rdGxzX3N0YXRzLm8gXA0KPiDCoAkJCQnCoMKgIGVuX2FjY2VsL2ZzX3Rj
cC5vIGVuX2FjY2VsL2t0bHMubw0KPiBlbl9hY2NlbC9rdGxzX3R4cngubyBcDQo+IMKgCQkJCcKg
wqAgZW5fYWNjZWwva3Rsc190eC5vDQo+IGVuX2FjY2VsL2t0bHNfcngubw0KPiDCoA0KPiAtbWx4
NV9jb3JlLSQoQ09ORklHX01MWDVfRU5fUFNQKSArPSBlbl9hY2NlbC9wc3Aubw0KPiBlbl9hY2Nl
bC9wc3Bfb2ZmbG9hZC5vDQo+ICttbHg1X2NvcmUtJChDT05GSUdfTUxYNV9FTl9QU1ApICs9IGVu
X2FjY2VsL3BzcC5vDQo+IGVuX2FjY2VsL3BzcF9vZmZsb2FkLm8gZW5fYWNjZWwvcHNwX2ZzLm8N
Cj4gwqANCj4gwqAjDQo+IMKgIyBTVyBTdGVlcmluZw0KPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL2VuX2FjY2VsLmgNCj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvZW5fYWNj
ZWwuaA0KPiBpbmRleCAzM2UzMjU4NGIwN2YuLmJkOTkwZTdhNmE3OSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL2VuX2FjY2Vs
LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX2Fj
Y2VsL2VuX2FjY2VsLmgNCj4gQEAgLTQyLDYgKzQyLDcgQEANCj4gwqAjaW5jbHVkZSA8ZW5fYWNj
ZWwvbWFjc2VjLmg+DQo+IMKgI2luY2x1ZGUgImVuLmgiDQo+IMKgI2luY2x1ZGUgImVuL3R4cngu
aCINCj4gKyNpbmNsdWRlICJlbl9hY2NlbC9wc3BfZnMuaCINCj4gwqANCj4gwqAjaWYgSVNfRU5B
QkxFRChDT05GSUdfR0VORVZFKQ0KPiDCoCNpbmNsdWRlIDxuZXQvZ2VuZXZlLmg+DQo+IEBAIC0y
MTgsMTEgKzIxOSwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQNCj4gbWx4NWVfYWNjZWxfY2xlYW51
cF9yeChzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikNCj4gwqANCj4gwqBzdGF0aWMgaW5saW5lIGlu
dCBtbHg1ZV9hY2NlbF9pbml0X3R4KHN0cnVjdCBtbHg1ZV9wcml2ICpwcml2KQ0KPiDCoHsNCj4g
KwlpbnQgZXJyOw0KPiArDQo+ICsJZXJyID0gbWx4NV9hY2NlbF9wc3BfZnNfaW5pdF90eF90YWJs
ZXMocHJpdik7DQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiDCoAlyZXR1
cm4gbWx4NWVfa3Rsc19pbml0X3R4KHByaXYpOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgaW5s
aW5lIHZvaWQgbWx4NWVfYWNjZWxfY2xlYW51cF90eChzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikN
Cj4gwqB7DQo+IMKgCW1seDVlX2t0bHNfY2xlYW51cF90eChwcml2KTsNCj4gKwltbHg1X2FjY2Vs
X3BzcF9mc19jbGVhbnVwX3R4X3RhYmxlcyhwcml2KTsNCj4gwqB9DQo+IMKgI2VuZGlmIC8qIF9f
TUxYNUVfRU5fQUNDRUxfSF9fICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwLmMNCj4gaW5kZXggNDgyZTJjZGFi
ZGFlLi5mYjJiN2U0ZTJmMDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9lbl9hY2NlbC9wc3AuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwLmMNCj4gQEAgLTcsNiArNywxMiBA
QA0KPiDCoCNpbmNsdWRlICJwc3AuaCINCj4gwqAjaW5jbHVkZSAibGliL2NyeXB0by5oIg0KPiDC
oCNpbmNsdWRlICJlbl9hY2NlbC9wc3AuaCINCj4gKyNpbmNsdWRlICJlbl9hY2NlbC9wc3BfZnMu
aCINCj4gKw0KPiArc3RydWN0IG1seDVlX3BzcF9zYV9lbnRyeSB7DQo+ICsJc3RydWN0IG1seDVl
X2FjY2VsX3BzcF9ydWxlICpwc3BfcnVsZTsNCj4gKwl1MzIgZW5jX2tleV9pZDsNCj4gK307DQoN
ClRoaXMgaXMgdW51c2VkLCBwbGVhc2UgcmVtb3ZlLiBJdCdzIHByb2JhYmx5IGEgbGVmdG92ZXIg
ZnJvbSBwcmV2aW91cw0KdmVyc2lvbnMuDQoNCg==

