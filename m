Return-Path: <netdev+bounces-103228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A3907330
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA7B215B7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5025B14374F;
	Thu, 13 Jun 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="za4Z41QY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058841E49B;
	Thu, 13 Jun 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284181; cv=fail; b=B2o8ukVdxLyrwzPnDJ0aCwF2WspdP0nTQbkSic47nhcPwQmYSoR0Awvjxc3Wy55CiFrHGFGA7vPZJugxS4DNBNSdGy8GeAqcB5GrQSOneweqapTfcFCjU6k/L+Fd1pYrPmG9ZSS49Hx1L8FMXr1shcpygey11ox7Ux9ZZHIO1jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284181; c=relaxed/simple;
	bh=u/UAIw66E22l9YRJyzmm2yZZyHB8m6MgIwyj/ykBywo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EnyY/tvjLzI2iMV2+rOonDg1VO2cZys5FsxffAOyXztbmzToLQAP0LH1M0DSw6Ug2F2MgBflBDed6UWamEcsMAKIjCYt90SFE4f0NsAwME0IdcptywXE2HR1uHFERIstiydTr8R+8Ir0Z3o+GPuhyLrrHVBi7Un7s/oQ3dt9zi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=za4Z41QY; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOJ2c2XqZaRKmsAGPu0kmwyLHgifRkgYPXibXc08i3IRj/HBLAZ/I4wMstR+bl1UeHr4L3D8edakTNPY3Eqy8pAR/VzTktxTQ9E0e+yry+CUGNWrALE1dR9DVbyipImLmxp7m8FzPyKoq7+QwXtRox6W2ZFg0oC7jt2q/mOH2rB74LPADOufLcXR18Grj9VAxaCadwbnd47pmbqeTurhYuFRo0k2d0lKEL8CEezn/VHzSP1SOM1J1RBQmZ9uf8p0rEEjHx8gDnITZXU3NTz5/2rx0MHoVwEYl+kyiHQZRvhEvB3OTIv46VRUSyMMJ7puHid/c8hOjRYDRFTuLYh/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/UAIw66E22l9YRJyzmm2yZZyHB8m6MgIwyj/ykBywo=;
 b=L6EDPnmTR6Ofce0PQfd0HL0aTFlKrOAUucJXMaAKMQiLS2syX8J8j/xCaJk03P8PHBtsaokFg6H/6zIhuolcJguvV3TrQXDj2A0EKd4j4EadXRWESooG9g/PxxvegUAIH7dRgpmRcz6XyfQgznmWHH1dfE3yLU9khhlPyXORft9VqBLzB1JnWVcId2TBg6WFClb3nHu9HILkzmFh3fdElgRsmKcQbD3UV8Oo5InRplLyRyCe1iemAUqRJrciCrmIHHAJ34xYaoE689RXyQKsjm1/v1utt2Xx1l6JaEpD9ltgNyUR+OO+WPJORo2GAZ/DEtX50FQ4z1ddjJ/vDk+3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/UAIw66E22l9YRJyzmm2yZZyHB8m6MgIwyj/ykBywo=;
 b=za4Z41QY5HHBxnUfoB2inVoFR2Gp+8SpU4XCp80XuURoBManoQkF/8l6wgj30KQ1wtpfBauAhIEO8ltbwfASOR+p7fGa8khOYQ6wYEIVDDeVwhs/t3n3bpZDeb9V2Dm4dxhQNUNJeOlboqQsi9ogHgStjglI5Yh58NiR0oQ3n0Uvo4DDQEnGj6L9Cnu2hSu32g+f61QF9OG5yZoUKnz4Jr+qR1m2fQ/v4YJUcPmwEdE8chdCu8VI4vhoJA7mNrwppQGmJ5R6cnXOKywRyNSeB6bSZCV2KlnB+yY+ZeTtBsC9hLwxaxX2iZQA+0Y1Oo7bBSEucrnnsbm+a0Q7WMhfxw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM0PR10MB3972.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Thu, 13 Jun
 2024 13:09:33 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 13:09:33 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "yuehaibing@huawei.com"
	<yuehaibing@huawei.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"p-varis@ti.com" <p-varis@ti.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "srk@ti.com" <srk@ti.com>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Thread-Topic: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Thread-Index:
 AQHavZEkKELFKPApXESUbFzBrG7o2rEdeQGAgAE1NoCAABVZAIAAHHWAgAA7PICAAUy6AIAAF4+AgAAEMACApScAAA==
Date: Thu, 13 Jun 2024 13:09:32 +0000
Message-ID: <9d61982695053e49996f0c9c9ba708b7cfc13edb.camel@siemens.com>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
	 <Zd3YHQRMnv-ZvSWs@nanopsycho> <7d1496da-100a-4336-b744-33e843eba930@ti.com>
	 <Zd7taFB2nEvtZh8E@nanopsycho> <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
	 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
	 <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
	 <0106ce78-c83f-4552-a234-1bf7a33f1ed1@kernel.org>
	 <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
In-Reply-To: <389aea37-ce0f-4b65-bf7c-d00c45b80e04@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM0PR10MB3972:EE_
x-ms-office365-filtering-correlation-id: 6cd21f57-7bc6-4af9-e997-08dc8baa1141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230035|1800799019|366011|7416009|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUM4V0JNd1JZRjNZNVJXMmVpMm1PMGtreGpjU2hkc2NBSnBHdGd5RnNnT2tS?=
 =?utf-8?B?cG5CQlhFSzdOZm0xaDVzeDMvQmJCMDdyOXJ0Mk9wcTZ5eDlXMEU3aWVoN0h5?=
 =?utf-8?B?cU44TktIaWVSbWpweEY5TUlTd3NxT1pCM2FmQXByV2RCR1JlWDVIcHJEUmlo?=
 =?utf-8?B?cy9CM0lSKzViVnpUTXdoaWc2b21kNGlaQThlbit6UXJYT0dmdS9LR2x6a09Q?=
 =?utf-8?B?clQ2Z0RqUkZlTDRpekpCaTIyaGNqbEhmOW5FRFZYakxlTnBzMjNvNjRpZTBv?=
 =?utf-8?B?RlFraGNmd1V4UVNFOVZhUWYvVUphYjE4NmU0MDVEVEprcnAvTjNoeEpJckxr?=
 =?utf-8?B?TncyOHplNEUxWHM1N0l0ZXlJcm1MWituSi9DUWxvdXZ3L3JnRCt2eDlNaWUw?=
 =?utf-8?B?Q3UwNUkyUkpndGVxZjYwdHB0UThJemVGWFl3UDVIcml2TVM1UWJRaHBjNy9Y?=
 =?utf-8?B?Zmdlc2Q0K1BMamhobXhjYVNtSzhucUVKaHlOOSt4dGxVYVp3Z1VpMEwrWU9J?=
 =?utf-8?B?SWJJZWdteE1YcWlETnYzYm1tcFRNZFRyMDU0T1hDaW05R1FzVEpLNlE3T2My?=
 =?utf-8?B?b1BwZ1NvZlA2Qjc1U0hKdlIwSEtFdEJlZDl0YmRGalMzR2Y4TDI5Mk1NOE9Z?=
 =?utf-8?B?RkFWL0R6UE1jWm9Xd1FIYWx0SkRzR2JkbHlaRnE0R0hRbEs3Ni8vRmxySnVY?=
 =?utf-8?B?TzlHMSs5VGc3TFRlazVEcWtGNXYvM1JmZGVmcGp1cHB4ck5sZWxjNE5iOHdI?=
 =?utf-8?B?bVNBYm91ZWFxc0hnd3FDYjRZbmtNMWZrWTJjblhHaUhyUy8xNVd6cURMaHNx?=
 =?utf-8?B?UWg5VFpuZ3dHNHVBdTNGS1VTaDdnKzUveXJiRDhMcUxIY3JhTXR3U2hIWDF6?=
 =?utf-8?B?d0hvVFdua3EyVWFqQ3plMWNZQzFPVi9wOU10T2hwL3Z4Rnd3YWZ6WU91R2pH?=
 =?utf-8?B?c3FHQmhIeGt0RkNTWkE4YkdTY0gxMjNYMUxtbkNtTU90cUxIN0kxRHkrM0Np?=
 =?utf-8?B?ZndrR29VZ24xb0ltRGYxeTVDQkJaYjNxK0JMeS9YN2lJa0pqZ0h4OGgyekZJ?=
 =?utf-8?B?ODNEMUZqZ3ROQjZOVzJ0blpwM1R6MlR5ODJJVTR6MVNuc0ZEQ3p5UHlUbXkx?=
 =?utf-8?B?TCtiM3JmdXZ0eWFHY2h5ZkMzdEJjSnlhOVY2VndIMXZVTEgvV3Brdm91LzRR?=
 =?utf-8?B?WCtZYnpzbjZGZGs4VVpFR0YwWnRUbUJNSUw0WmwvMkdvUUF3SWhySEhvSEVs?=
 =?utf-8?B?Z21OVnFLSDZlY1haRTRiNlQvR3N1a2xiT1BEZ1p6dTVzTU5pTU4yZUNnd1Qz?=
 =?utf-8?B?NytqYTRIZ3FoczhjdzhZRXI1RDNvbWRJTGJuK1pyTXdLejZjWDZ4Wk00ZXRj?=
 =?utf-8?B?WmRLWFMzamVuektnaXR3SGdaRjZkeVIvT3hyM2hoa1V1dFpOeTlObklPQ1dq?=
 =?utf-8?B?VnU5WXJCbysrazBmUmVVT0xjanpubUtLcnJvZy9rR0J1U3ZmalhSdjh2RlZ0?=
 =?utf-8?B?SHUyK25EazZvUVNKaU5mamlrZUJzVEFpWTk4UGpsWFM4aGgxQUdNVlZaaGJ1?=
 =?utf-8?B?S0hGVnp0ZnI1U0lzQm1XY3NJd244UTVtb0FxRHBqL0pRY3hyK29sbXROTGxL?=
 =?utf-8?B?RWxCY1hFMDRlUWtURythYmV1bGE2ZGZiY0o5V1dwUVBhTURUYSt4L2s2QlJJ?=
 =?utf-8?B?aktFSm05VmJSanZKMVZCT0M5WkFrbnFVb0xLdlQ3ZTNERXg5cHlWYWcxc3pS?=
 =?utf-8?Q?uk+wflD2zUeSATvzXZRrxwmzG1csMzPXdmKLU6w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXpFUlVKb2Nnd1dqVUpXeVFQQWdEQVNUYm5mUmhRTjBmVXhuTVdWUlJ3M241?=
 =?utf-8?B?MlNVQ1lpdzU1THZhS0dEYnllYmp6VnE3S3ZIdjBGSGR5cFFuTk9xVkwrUVd4?=
 =?utf-8?B?TGZGSmplWkhNNmhoVEZySHlQaE9rQlBXSDhNbXlmK2V2UEFTUnY1Rk9lMGpQ?=
 =?utf-8?B?Y0NuR29FNUNuaUdxYitYRXZZWkI3WWJrTEpOUFJOc1Z3R0JjK3kwSTZPTG1U?=
 =?utf-8?B?Q25FKzQvN2tIQy9vZEdUNGcwZ01aY0p6VEVoSUpBcSs1YkMxNmRGa21mTGVX?=
 =?utf-8?B?Q241UjdCbjBrZ3hwQ1h3SHZNYlFRbWdIVU1ORU5xbXk4bStURnQyN1h1aVFt?=
 =?utf-8?B?V0RiRkF6eVc1emxnaTBZN2NMTlF0dGRVVWtDd3AzTFVia1l4N2FCVTFvSlJj?=
 =?utf-8?B?TEdjelZkb2VTd0xlVjNuaWhFUmc3elVCZFplOGt1SDJPL3dDQWJMSzlWaXV3?=
 =?utf-8?B?QkxGRnhMdUpHZ1p3RjY2M1J0enM4MWtreFpwek83QnhmQ1ZsNnpNUXBTR2ZE?=
 =?utf-8?B?MkVNMFFKNTBWeG4wYmUxbG1PZ2JZdzhhd2VlQWhpYmNnMnJvMVB2bTdrdzJF?=
 =?utf-8?B?eXFSZ1pjNWs5VHJ1VzZ6VmhWREpDV2FpRGZaeEZFYkFLWUl3VEQ2RS9IM0FD?=
 =?utf-8?B?bW53V0VDdzNtNkxIVmNHTCtyQW1pVW90MGdMTDZqQXFuOW1NY1NLWnBMZkxG?=
 =?utf-8?B?aTd6QXhjZ3lWV2FqU2ZKT3pvK0pHNXVHMS9MaHM4Z1dkRmlldzR4ME1ZZ3dN?=
 =?utf-8?B?dGNoOGF1Z2FSLzByZnFZbHJzdzd4RGdqeDh6Y2NXM2N6YnVqWVVIZG9CclBF?=
 =?utf-8?B?aEY5Mk1ubHBYektIZStQYjBKdnl1YW5DTFBGcy94REFxWisyejdZb0hHWHd1?=
 =?utf-8?B?Vmc1UEpjd1NOdWZGZ0dLb1V2elRvUFpNY2tIUVBSV0VEbzdsV1BkREh0dUhP?=
 =?utf-8?B?eGNXckwrUHg0UTBwMDl2Vy9wRTIwYk10OE5kLzJHdHpldGl6M3JXL1FNUEYv?=
 =?utf-8?B?M21ob0dOMFZMTWhZREZKZmY1U0VpKzcxN0FhQi9neUtNUzB6US9KRnpoOURw?=
 =?utf-8?B?WnBkUmZRQkdKR1VUS0dDNVNjZ3pnYTllYzN2bGV6cTd5Skhmdnh4NVFjcjA0?=
 =?utf-8?B?dlp2OHlrSUwwdTV5ZytXUmg0Qmg0dTI0dmdqbUVFc1ljTkxpeldVbTQ2SUJX?=
 =?utf-8?B?TGdxNmVnb1VIK2lvSHB2NnFpNmhDMVJKSEZlYlJCcmMydVpkczlCWGVwMkw1?=
 =?utf-8?B?VlV4OTdaUlZuS2ZJcGNDNDZjMHNPSGZGaFpFVHNoMEh2eHpFRmtRUENreXRS?=
 =?utf-8?B?UGdkdzdodEJDWmhjbDRrbHNnM2NqZ0E2d200aGJCcjNIeVl3cmZGd2JRRU9P?=
 =?utf-8?B?V2UxUi96bHI1c1Qra3Q2RWoxbHEyNzVrUnJ2RnhlUllMeU50bXNIcUkrcENs?=
 =?utf-8?B?YmdLNldaWUM2enh2VVpGcHdjTG8xcGY0SHhvZ205NGorNW41cmc2MjBnZUkz?=
 =?utf-8?B?VHQvaXEvQmtWcmkrYjkxR1F5ZjVOdE9xQm44VnJpcThubzJpRGp4TUZ6OVFB?=
 =?utf-8?B?SDRxZjlGWWZVWWtPdmo1cndiUzZqV0IwVDdLVkR6dmZ0OVJIL09pdS9MdU1W?=
 =?utf-8?B?ZThYd3FQYTd6bVcrV2FOUlNUcm1Ocys1VHhsVnZuZFI2QmtyRzNFU041Si9L?=
 =?utf-8?B?VktnYU5vNWpYYWRxMllqSWRaRm9pVFp0eHZjb3ZEL1BaSzVtNmJvcWFzRysz?=
 =?utf-8?B?MkM2WnExbTQwRUpVSnAyeFV2aEMxY1hESkVGWUlucHR4ZC9ydE5ldmtZSGVC?=
 =?utf-8?B?SHF0QjlyRUFLZmtWbVlDMXo1WHUza2tvc1pBRWdpWkdWM0VNdWhJck00UElD?=
 =?utf-8?B?Um9jRUFQblFxV1RxYVRLdHRsTmdac3FZT1BPWVBubGxkenFYR2s4OWVyVDFS?=
 =?utf-8?B?cG5taUdyZ0QyalBYUk5kdEtNMzl6S3NqWVcvSWlXTk1zRUFFdnR4cU1RSTBs?=
 =?utf-8?B?Nmw0bmhYOTFCVUlHdDR1c01UcUNaa2p0U3JKaGdxdVVCNUM4Rnl2OFhub01l?=
 =?utf-8?B?cWliQ2poaS9nODNqZXBYNEpKYXlnUjc1VU8wVTdaWHo1SFNnR0t6YUZIVnla?=
 =?utf-8?B?bEdSTUlmZEtFVkpYaDlDeThSVzNYZlBpWFJuSGRFNy9MUDRyUjloaWFRREFG?=
 =?utf-8?Q?44Rs2XwItXbnIxVY0qnmHvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38717666AF9349479370FA3023CEB904@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd21f57-7bc6-4af9-e997-08dc8baa1141
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 13:09:32.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okVENsmnZMK4697NLnOe1hwwUjlqZtdgVg7fZhRop132AbRhyks9GKrM5fNJFGzQ08H2HtIa/ct4bGGo78tnOiUj21nOG+qj+Rn6NYaW7Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3972

SGVsbG8gU2lkZGhhcnRoLA0KDQpPbiBUaHUsIDIwMjQtMDItMjkgYXQgMTY6MzcgKzA1MzAsIFNp
ZGRoYXJ0aCBWYWRhcGFsbGkgd3JvdGU6DQo+ID4gQSBiaXQgbGF0ZXIgdGhlIGRyaXZlciBkb2Vz
IHRoaXMNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgIC8qIHN3aXRjaCB0byB2bGFuIHVuYXdh
cmUgbW9kZSAqLw0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgY3Bzd19hbGVfY29udHJvbF9zZXQoY29t
bW9uLT5hbGUsIEhPU1RfUE9SVF9OVU0sIEFMRV9WTEFOX0FXQVJFLCAxKTsNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgIGNwc3dfYWxlX2NvbnRyb2xfc2V0KGNvbW1vbi0+YWxlLCBIT1NUX1BPUlRfTlVN
LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQUxFX1BPUlRfU1RBVEUsIEFMRV9QT1JUX1NUQVRFX0ZPUldBUkQpOw0KPiA+IA0K
PiA+IFRoZSBjb21tZW50IHNheXMgdmxhbiB1bmF3YXJlIGJ1dCBjb2RlIGlzIHNldHRpbmcgQUxF
X1ZMQU5fQVdBUkUgdG8gMS4NCj4gPiBJcyB0aGUgY29tbWVudCB3cm9uZz8NCg0KSSB3YXMgYXNr
aW5nIG15c2VsZiB0aGUgc2FtZSBxdWVzdGlvbiBsb29raW5nIGludG8gdGhlIDMgZHJpdmVycy4N
Cg0KPiBBTEVfVkxBTl9BV0FSRSBiZWxvbmdzIHRvIHRoZSAiQ1BTV19BTEVfQ09OVFJPTCIgcmVn
aXN0ZXIgYW5kIGlzIGRlZmluZWQNCj4gYXM6DQo+IEFMRV9WTEFOX0FXQVJFIGRldGVybWluZXMg
aG93IHRyYWZmaWMgaXMgZm9yd2FyZGVkIHVzaW5nIFZMQU4gcnVsZXMuDQo+IDBoID0gU2ltcGxl
IHN3aXRjaCBydWxlcywgcGFja2V0cyBmb3J3YXJkZWQgdG8gYWxsIHBvcnRzIGZvciB1bmtub3du
DQo+IGRlc3RpbmF0aW9ucy4NCj4gMWggPSBWTEFOIEF3YXJlIHJ1bGVzLCBwYWNrZXRzIGZvcndh
cmRlZCBiYXNlZCBvbiBWTEFOIG1lbWJlcnMuDQoNClNvIGlzIG91ciB1bmRlcnN0YW5kaW5nIGNv
cnJlY3Q/IFNoYWxsIEkgc2VuZCBhIHBhdGNoIGludmVydGluZyB0aGUgY29tbWVudA0KaW4gcXVl
c3Rpb24/DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVu
cy5jb20NCg==

