Return-Path: <netdev+bounces-274576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFizJ2F7zmnBnwYAu9opvQ
	(envelope-from <netdev+bounces-274576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:21:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92B38A632
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F296A30976F0
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCD3DD510;
	Thu,  2 Apr 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2168xWz"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845F3DEFE5;
	Thu,  2 Apr 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139538; cv=fail; b=Ty6h2aZXBms4xvFfcaz5Tl/0v8cXd9c8qYHEQI7laa96lAeARVAff2qsQlrRmFgGAFq8P0gxaBelVrmaz6VmXMSCckMPkxIVNsk6RdgDFFr1NjyHz4DGW3ujNSmxnne9YtJYDmFWAAv7CraqvNgmJh0jcY6aWm0gv86SJHgFTIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139538; c=relaxed/simple;
	bh=UIwJFPSoAPhgJuf52IK7rSJdC90wXuHmKyPzl/VSK08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djtr3VIym2H5WDFAAQNW0U6R9K3d76JzzxLfgIzjdnj7gt60oJGRtxRKGASx+BhXi3Yn2Nmr3FxSdl4tlIaBwj3w/1VuptcAqLYHaX1tfuPGUpOqmfgZ+3pv9e5El12AipKQ6061Nc7RjJiZKgyWvg8ajJTQdfDAi6bJQdNbvLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2168xWz; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9QzvopsOML6TwxqyKOr5yKR8BGP6X7UkgKEtnr3Zq1hWDGBfrFmHsb8LpCrRtCm8UZmAYxuMvUIw3yIXhkjLzP6eNYS1kfC5KmbbowG+PJPiUahLQg44fe/fkALGES8c6LhX0wSXdBJeEKb+/OzRXWVnKYHzlcySDREdFqiytGA4GpJTlov90ZWMRsEdgNsXZZkxICADJYj6w4E80qL1G6PRzv4BbFCyBULWcJpLTyy9qnFlRguvv/uZeLmGAqLSCvNjrXarTq2yKt1/34L7uV6tLhP2CzL/oYwb8OXlKWy6zhwntRt0p7V/RI6W2P3luk/eIInUcwW581opBUl5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIwJFPSoAPhgJuf52IK7rSJdC90wXuHmKyPzl/VSK08=;
 b=EBg7Ilh+hB6Jgwd3RpmtzFg+/hoHpQ6/TY+v5hThmB5qhH24e4iJc0TwxlJrefuId6rasKtVkwbf3T/fzLqqlbjTNvhciuuzfCrie4T5iFeAKBRQAalxSDuYEeGM5rzKBCD12mng4ySOwQvYFRY1pL3s8UKXese43nJBIMwyikkg7xI26zwsGl8U3QAeuHs+Jrtx9pQJgp94M8jPMX6Pg1Fun+Qz6QxGCarp/LgnwexLIqlJrhByi4kmQVJi34UQkW5Ksd+QP13gDQsRnekNEKvDAYi+X3XnivqW7UvVn+z0FDUz3Fs6eYZZOfiCOWzEmPYyTvdWBl9tE3TvGQ+zpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIwJFPSoAPhgJuf52IK7rSJdC90wXuHmKyPzl/VSK08=;
 b=q2168xWzhEIj/dTeArq74tp0KpDA9dWLh7Xdr2q6YU1e0oSXXBNTQnfTLmFj+cpkaJVi37Z0uAZccogvaD5mZYgvVAPbMHGtR0lR/Vc9IHE9pcoP/CjHcQ8t8kFWnTnBi2FdHrNG39v0wC4SZU/o0rWbl+pwuSPwU9ZURsIMk5xZsHuHXFz96Gr4DBQSoLsMfLlWLgHNpaql0C7xzYFpZGj4qY6faqmewWPczUa5UAWfZ+44mhIYFN83tKJeMYWZcdTQr+hEmCQ+g3JJdcS5zRhqeqeswSDRf5rMbvqhtObhRNkvxLOBIaKs7H/0D0Pj1HJIgTln3H8yHL2m1tWHQw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB9341.namprd12.prod.outlook.com
 (2603:10b6:610:1cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 14:18:52 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Thu, 2 Apr 2026
 14:18:51 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 3/4] selftests: Add MACsec VLAN propagation traffic
 test
Thread-Topic: [PATCH net v6 3/4] selftests: Add MACsec VLAN propagation
 traffic test
Thread-Index: AQHcwEV43GYoW4ksD0aMd/2mKp3yYLXLqX4AgAAtKwA=
Date: Thu, 2 Apr 2026 14:18:51 +0000
Message-ID: <aa1af947f32305ef08aea7f9ebfb9ad5e8eb39dd.camel@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
	 <20260330130130.989236-4-cratiu@nvidia.com> <ac5U3LFm2pOV3vWM@krikkit>
In-Reply-To: <ac5U3LFm2pOV3vWM@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB9341:EE_
x-ms-office365-filtering-correlation-id: 5fff7aa7-3818-402f-1097-08de90c2c3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 lKFjmCkwtsb6T/MtlmxOr/TrABk6KB2vKHiC8U/MRHyTxzil6WHwl6vEy+S5b0L7/Z8l7md6u5WNWvBakC9ViXpVWod4G0E3OCAcxFCIgIkGGYZyrNU2PnaAZohV3uoM9yMcOzS7ygzUqx4elN2UlF7J4qh9Jh8BXIeuNxw//iSAVyuecjOkgSepulNvi0vl6z7OIayIX9S4R9yzNPO6Ta/tS3m9e2ZwdCk6Ntvy2ivCqMsaTxQzwasBOSp5jESP8W+ofmnOND8Ows8uFvIhqVTmumQR9hvRmHeWrHaYGKQowUbA1CR8+EKET+ioWs/vELRdpZJFdrtP8Jfsq9/e0RXBletQ3RrFyE/UonwobSDBB1i3yob4cx/jJyoCs4p83ztr9tUmFLsczkmve4ZDWoiFn7jO3OdNU0Y6bRD9bVH0wVIWHVYGZGrMyQngmVQm8noe271rauqCW+FY1CPLuhoZ0iCggDuW5vT0QW5mai0qavLFDMZexZNxIiizSVi+jfdpyGAdQQlnMxyCDU6r33U0QI+pqeydMi968bvzxkVKBfqh0aitr/rv2ByV/g89LuBJEj900O8nSBbY63UetGKOUdKf7OFLFmY+hYs8apGVnCuSRx4pxuRhvRcKLYxWN/UIhnH8ci/k3liYVHNJQHRr3xU6n53Prm86Y32f5ip92vXyQ8LIYP0RVgZ9HJ1oVoJ0YXF5jDYiqIG4kEDgvXbb+oDKXkhIq8Dep9VqIW2upl8RCyF2PDfY/1XgVWW2onSxQ+GnA0eJ+ibltXsLkgo6yw2WGskYXZ7NAsCWDaQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZseHJRLzgzVnBtdVJGVnFocXhnMlNyTEZhamwzRk9LaHRpYm5OZ21UOW9W?=
 =?utf-8?B?cGsyVHV0eTlWbW9wckdQVEExZWlRM0lHUm8rTmNlbEFRUzlmRXJUcGw3eGJZ?=
 =?utf-8?B?Tk52U255alJlZEZhWHI3K3g0QUJqVmZEYlVTb2s5VFFxVGNOclF4blVzVlkz?=
 =?utf-8?B?aDYzUEdWWDkyWEhhTUNXVGxCT3RNNTVoUXJCTUFTUWo0RDRTak8rQ1VKQ1Ri?=
 =?utf-8?B?TUFSQ3RLLy9XTFBIczIxUm9MUGxKYmJkZUxWODIzMWJSYVlKc1Y2Unl2dkY3?=
 =?utf-8?B?eWpkMlA0K0wyZHVZVm5MZVVvemxBK0tOYUtOM2xMTk9QamZGUFNhK3FMS2pq?=
 =?utf-8?B?azVpWmN1MThNRUZYR09ldU1IaGFOYk9UbXN6bTQzTDVHYTVicXkzdzYxWThL?=
 =?utf-8?B?ZE04UjlKUWtxZjFBQi9xOENVenJPMUxieDlUZ0pEWG1ySVF6bXYwMHdqNVBu?=
 =?utf-8?B?YkdvOFlITlZmbms0YjNOdFRhYXh5dU01SW1hcGgvWk5veVhtenRMK3RSSXBD?=
 =?utf-8?B?c3ZnMFcwKzMzNm1SQUJXQVkrYm1KczNaNHF3L2lQT3JYU2FrVDN1cVo4N1JZ?=
 =?utf-8?B?K2hHYUhGMUJOZmczdTgxaTAxMllQaDFOVUhMQUVkdW5YUmo5d29ZZmQvcDJE?=
 =?utf-8?B?WHdJQ0NUQlZuMnp6V2lqbDMxWXdjQlorbXc5aDFINVJjL2JjTDVkRHJzSkpW?=
 =?utf-8?B?L3J6SDhjZVV0eDZQN1d3SlYyYjQzTmNqMlk4U3pmQ2UvTnlkSHc3WlZTTmdI?=
 =?utf-8?B?bkIwNTdOYks0OVAvalIrKzNiRExBV3dPZitNUUlReEZrcUI1MXBRNmF0U2N4?=
 =?utf-8?B?N2RQbTRtbjNxTVp1VDJ5bnlldDVaaVBjbm1nWXkzTkZqbUFEOHlhNHp6aUJL?=
 =?utf-8?B?K2JYTUp0dUUydHFMS3g1dVZrRDIzOFlWcUZXdXI5dGFuS2hxMk9GaUNGVkNa?=
 =?utf-8?B?SVFIYzRzbFQ2VjYyNU4yVmlSWXNHS2RIY3VQUEZNQzdkeGI2b0ZTRWdKaisr?=
 =?utf-8?B?blZ6M3pIWXZnbEtDZWlrQkxRcWlyRDZrUjlmWElNMCtDcjdlZGszYTRHRUdi?=
 =?utf-8?B?VEJYV3plMmxtSWdBR3RWOVo1TGYvaHhNdU10OW5XL3lweE1IK243eFZTYkV5?=
 =?utf-8?B?RGlHa1ovMElIQk8xeld6SW41VFVhYzNkall6YTJIRTV0MU5jTmxkM2NYQ0hz?=
 =?utf-8?B?eXJqbndnZWlYU1dYeDdzTCtkU0NxWk55Yms5bUF4VzUxaG9xYkxwWjREQTU4?=
 =?utf-8?B?TFh1Zk1xSHlsNkx4RE9keXkyRG5PQ0JuUUF2cSs0SWl6TjVQcnBLMExYRE5j?=
 =?utf-8?B?OXh3UHphSjRHWWhlak9yM3JLbHVvaFQ2b0pFYzMzcDR3U0FCQjRoa0FMWUls?=
 =?utf-8?B?TXNrOU1iTC94dzB3QlV2cndNTHIwaDNSWlFsRzZqZzZPZzBJd3RteUVTem53?=
 =?utf-8?B?MnhOZ013YXF0VU50M2Q5N3Z6TWR4NmJxaHpOcWN1Qk1uZnZoNUVjTkx6Z3Fy?=
 =?utf-8?B?NG11dWtmVUxlNTN2RFFqTDgrT3VpS3lGK1E3ZndIVnhtdk96ZXBGY3B6aHlE?=
 =?utf-8?B?N2hpMnNGdytrVkVkNnVISklyc01VSzMzMzBrb0NFOVhnSUdoRDNia1VpUzVt?=
 =?utf-8?B?bmtFdWt2Ym5JRXRjeUczUHMvSHREMHlWZmNsR2w0MklXdkN5cEVpMS9lTjNM?=
 =?utf-8?B?ZVhjVWFVcWlPa1MrTWU1T252a2d0aWxlQUR6aGN0dFQzbm5FN2Z2Y0FacHpH?=
 =?utf-8?B?VUVmTlFHamxmbkNYRzVydmZmNWE4OU5xNGMwcy93SEl5Ykc5VFRoWlZZSTlJ?=
 =?utf-8?B?R2pVUlp5bmFGa1FjMVVZaFpsbG9JR2I4SXJnZXpZdXl1NUlPbTZRYkc1Z0Jy?=
 =?utf-8?B?K0JPNXNadXFqMm5JMWFkZzF4TURneFlyUnJJSUliTDRDTnBHZ1haeW43N1B4?=
 =?utf-8?B?TFlRSHpRc1FtdDZhUmRhWFdPN2pMaHZsNUNpRWVxZzFuRWtNWHptbVoraWdV?=
 =?utf-8?B?bGp1OENkZjNoVmI1SVRuU0xVU2xZMUJ6cXRpdTVUcjVSNytVWjUyK3pkdEJv?=
 =?utf-8?B?UG9YMVdUekdtWEwzeG1uVFlnZEQ0QXMxU3VJckQxaWdmdVlZQ2JwMXhzemlW?=
 =?utf-8?B?S0lXVXVEK0NGakdiYzVpM2FzYzRhaTh0MGJCeVFEamtRWXdLOWxMYUNRUU1O?=
 =?utf-8?B?cEZkNXUxQmtWNk1FN2t6Q0l5cWxmb0hZQ21vVENNMHUxbDJ0NnZxTG5QRkow?=
 =?utf-8?B?dEkrTmlIYklXZ0xISmg4MEllaHhHTUpiRVB5TDIvY3crSlUxeURzeUhSVHNH?=
 =?utf-8?B?bWJxTndaQk1hajhqWmhYanRrOEJXQS84WUJzdE1jTVNmcWprUnhPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDF7C1623351E7418F951F29A4E70C75@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fff7aa7-3818-402f-1097-08de90c2c3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 14:18:51.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: halpe8EfksmKfhdajQhNVxkrMuHEmFcTzYigwbqOEH0qOFqAt6LUVR2V0icdrl6yRzsRsDTsFlnxbMYtqp4Vug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 3B92B38A632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDEzOjM3ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDMtMzAsIDE2OjAxOjI5ICswMzAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
K2RlZiBfZ2V0X21hYyhpZm5hbWUsIGhvc3Q9Tm9uZSk6DQo+ID4gK8KgwqDCoCAiIiJHZXRzIE1B
QyBhZGRyZXNzIG9mIGFuIGludGVyZmFjZS4iIiINCj4gPiArwqDCoMKgIGRldiA9IGlwKGYiLWQg
bGluayBzaG93IGRldiB7aWZuYW1lfSIsIGpzb249VHJ1ZSwgaG9zdD1ob3N0KQ0KPiANCj4gbml0
OiBNQUMgYWRkcmVzcyBkb2Vzbid0IG5lZWQgJy1kJw0KDQpXaWxsIGRvLg0KDQo+IA0KPiBJIHdv
dWxkIGhhdmUgdXNlZCBmaXhlZCBTQ0kgb24gYm90aCBlbmRzIHRvIGF2b2lkIHRoaXMgbWVzcyB3
aXRoIHRoZQ0KPiBsb2NhbC9yZW1vdGUgTUFDIGFkZHJlc3MsIGJ1dCBpdCdzIG9rIGFzIHlvdSB3
cm90ZSBpdC4NCg0KSSBndWVzcyBpdCB3b3VsZCBtYWtlIHRoZSB0ZXN0IHNsaWdodGx5IHNpbXBs
ZXIgYnV0IGl0IHdvdWxkIG5vIGxvbmdlcg0KZXhlcmNpc2UgdGhlIG1hbnVhbCByeCBwb3J0IGFk
ZHJlc3MgY3JlYXRpb24uIEkgdGhpbmsgdGhlIE1BQyBzdHVmZiBpcw0KYSBzbWFsbCBjb3N0IHRv
IHBheSBmb3IgYSBsaXR0bGUgZXh0cmEgY292ZXJhZ2UuDQoNCg0KPiA+ICvCoMKgwqAgcmV0dXJu
IGRldlswXVsiYWRkcmVzcyJdDQo+IA0KPiBbLi4uXQ0KPiA+ICtkZWYgX2NoZWNrX25zaW1fdmlk
KGNmZywgdmlkLCBleHBlY3RlZCkgLT4gTm9uZToNCj4gPiArwqDCoMKgICIiIkNoZWNrcyBpZiBh
IFZMQU4gaXMgcHJlc2VudC4gT25seSB3b3JrcyBvbiBuZXRkZXZzaW0uIiIiDQo+ID4gKw0KPiA+
ICvCoMKgwqAgbnNpbSA9IGNmZy5nZXRfbG9jYWxfbnNpbV9kZXYoKQ0KPiA+ICvCoMKgwqAgaWYg
bm90IG5zaW06DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybg0KPiA+ICsNCj4gPiArwqDCoMKg
IHZsYW5fcGF0aCA9IG5zaW0ubnNpbXNbMF0uZGZzX2RpciArICJ2bGFuIg0KPiANCj4gbml0OiBv
cy5wYXRoLmpvaW4gZm9yIGNvbnNpc3RlbmN5IHdpdGggb3RoZXIgdXNlcnMNCg0KV2lsbCBkby4N
Cg0KQ29zbWluLg0K

