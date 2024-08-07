Return-Path: <netdev+bounces-116316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9B949EA4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B01C23BEF
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E318FC92;
	Wed,  7 Aug 2024 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="07tHDR/b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA41372;
	Wed,  7 Aug 2024 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002481; cv=fail; b=oZuUbWYiJw3j6wXbddSzSFQRBwQnsV5Zdh2G+2KR0C7qUYjGmOTlR1txuhNKgkc5Mcd14RefrpF7BRqo2gPNau1zQ62fY8ajdKdMXEyMHg6q8M+NnibMEBTOyp25wsB9ZITmfK4ktBQhGVwGM4/XUWPhlOVVjkq/hxSW0F6Y9gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002481; c=relaxed/simple;
	bh=+Z7kHqBquHP10sGy/Z/tavvMQ8/zrZpOMzoSkDmxVWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EpJv5Dd6cXBpOU6L/Ovq5jj6vq1XpuzDGSiaHj0lpZKOhY954fIiCESeyNvEFt8r2UPehO63lhMaE1TcutwZIzLNq7IMjlcyQamLHE94uY1bW51eFEUa3KglZLfZop8KzAOOUFQYLfwIPATrTVplhPZ27LjOLqOF/qOwWypz86I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=07tHDR/b; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC2Q0aXh/3YdqDNB5FE7m6sbO/lYTIgtC4B8RVzFxysmoCYJkFNytWawT+5ZzBoHIDZD5B5ACQ2T2jgxe9k/Sh6VrkXFYWvJ9UNxb1zn/G3Xzigl//5R7Bm+mkjqewwNb5Gfaf0W6uxwAkHELebVJA8klViU9bQ8H6fDdzhlHXgO1qCIC49iFauoOj/GV0NpzEEHzn0uRxNRBvIMJdcx4UQeO4dKedAqRwE97FglkHN9PIF70sqOI6NUnryMjgfvs9uWTKVyLiUIKwPRAsNaLgePiaKHLAfSzvKeGB/fwNqrUFWNDCTqHY8J97njO4NgyY5cRGFQurqH/LujdsJtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z7kHqBquHP10sGy/Z/tavvMQ8/zrZpOMzoSkDmxVWo=;
 b=sHirV/VjPL/Mt4j0kw9Xy9FlQGbKtlknQR/W+VVVr0utQUsBgFDWPMQkIuDqkl60sHqe4ZVsNV5cu7C2BVTSy0JC/cZxFCmPCq8+XqY9Qe0dy4T0L8nw8Aq/G2YJ7inKZmez0DyNI9eBXRO+oZh+W40l/MFEqj81jaa6KWjdq2fjku2/cSj/J0w+75pvylKipwvuGv+7YkNQyP5LLuY4WHU7LU98B8+8x0YT2hVLfqbpdrYKYoZpk4DeGcOi6H5UAs1s15AwC9mx8AS4orDRr4VjNrY9110hbZxJ4fFUZtU25THUu5pnyYGivOHX5EywfzZqWdu78vPo3Y8FbiKN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z7kHqBquHP10sGy/Z/tavvMQ8/zrZpOMzoSkDmxVWo=;
 b=07tHDR/bUXYGZWf23SOa0ll2Kp0xM1n6gOKID9znab4orEo2S5cBng+3JATF0wOD1G+qPzLuuVTbUMjmKQalBMX8ffh/SZT9/fwMee6OqAYgzpJbHtYDp2AYq2KTKOT2EWat66QCf/j0+MSrddrzCMQS3hZK076f8o/Vf4/s6lnZRej+EvNbkdLeYdrSl3kDpxrqrxzom3J319VUiPymTEKW10QU0SUMHuMAfyq9N0FYbxcA+/D+NGWKSD+fJSMTiqU8weONCPIzN7MK+dk19ieG4vhFwPAn2ts9galJGpLTVEgk3k87DDdAIx//fXmJ18iOEme8MjaC2QDWsfZTAQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 03:47:55 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 03:47:55 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/5] net: dsa: microchip: generalize KSZ9477
 WoL functions at ksz_common
Thread-Topic: [PATCH net-next v3 3/5] net: dsa: microchip: generalize KSZ9477
 WoL functions at ksz_common
Thread-Index: AQHa6ASX09NEasZeTU6Z/wZCsDZGmbIbKdQA
Date: Wed, 7 Aug 2024 03:47:55 +0000
Message-ID: <060e525817bcbbfd95f5f87204c19eb9c9955d1f.camel@microchip.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
	 <20240806132606.1438953-4-vtpieter@gmail.com>
In-Reply-To: <20240806132606.1438953-4-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH0PR11MB5048:EE_
x-ms-office365-filtering-correlation-id: e6483989-b187-4a43-f8a4-08dcb693b891
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2t2cmsxVGp1RXROYzZXS2YrZCsxM1ZYaW1kMENXcUpaRnNjK0VVZzF4Qjc2?=
 =?utf-8?B?VjZkMENvWUtPOUsrR3RWOVA1Y3JwTy9leU1aZWhCd3lPdHFJeGNIY2lhWER1?=
 =?utf-8?B?dUVzVW9ndnM1K0dPQjhyNVFzTGI4bTFHcHJQZFNuR08xYTdNWXFROHpiclNm?=
 =?utf-8?B?VDNTYTMxR3BaK2lBVEJjbVpoN2phcThFVklvdEJVdkhmYmxreVlDTVlnOXNz?=
 =?utf-8?B?czRLcCtKOWlacmtTUlBPUmEvZytOZVQ1SlFhaVhsMlRkMGJkVzVPaTlHUDhr?=
 =?utf-8?B?eTczT2NhWWJVeWNuYXVEUTZycW82OUJkU0JGQ0w2YmxvY3FiU0tWTEtFSzJJ?=
 =?utf-8?B?NjFLM2EzdkNhVjQvOGQranZYSlc0WThNeXFGenNLVE9SZHE2Wi85NzRUbTB2?=
 =?utf-8?B?VERySktlbksyTlZkT2R1L0dpVFJPdlR2c1VnS3VCVkp1VnpZSE84R2JXeUli?=
 =?utf-8?B?RUp1b0ZYOUpZOFl0T0FQQzlKM2h2Y1MrWXY5UFZMTDVCb1FpZk16TTdnd3Nr?=
 =?utf-8?B?dVorNWlsVjNvMnVhaWhyVUJDb1lJMVIwWENxSXduYUdobUgyS00zVFFTMUJx?=
 =?utf-8?B?ZE9IaTU2WnFLVlRSa0s2b3QyVjNLdzVEOE9oSFlHNC9sTWt2UzhPNmppV0RT?=
 =?utf-8?B?VHBmcGI1aGZ0YWNmNHl5UCtNcnQzMkdKTTdGaTBqWlY1ZzNodlpqSTVSejM5?=
 =?utf-8?B?UWpETHJhWUg2RHlmSjNxUnZRS1JhWEpNT3RmRVMyK3VZOUhsalJoZnR6VUlV?=
 =?utf-8?B?VVgyamNRMXdIdUcxZWxzSXdsNGdaYXlLd3JzdjVMbTdIVFMwcmtTRk1aSnJ3?=
 =?utf-8?B?THRYLzNsM1lBZHBPTmk5NFFUNng3NjBxTzcwZkVZbU9TTjBWOE9WOGRWVW0z?=
 =?utf-8?B?UFBnWVR6WndsUGxJQk4ySy85a0loNXQrRWxuYXBhYzJrMTJrbzcrdVJPM0dk?=
 =?utf-8?B?MWx0MUJNMGF5SDVlQm1UeDA2eTNoQmlJcjhsN0EvUnQyZEJyLy95eFlkcWVz?=
 =?utf-8?B?UHNpQldtejFLNUY5c1hCdW5oWk9tZ2s1WG1sSmdITUNFKzBpVUp3OVNWMlhl?=
 =?utf-8?B?K1d1VFRTbVQzdzZVbTBGbVVHNlBXY3l4MXpPWXRKZnNUckxab25GdGQwd0N5?=
 =?utf-8?B?djhMaG8zemc1U2MxdzhTM2ZkWWtCRlZjTTJaYi9RNEFvNVAxeUVnSk1takZz?=
 =?utf-8?B?S2pEUzR3U2Z5L0xrZVE0Nkx6ME4vQjNKSUxlN2JubWVoMXRrQURPb3JUU085?=
 =?utf-8?B?N1VKVlBuWDJNd0N1ekNySDkyZkZBTGN5aVNHejQvbGxJQXpMNkQweTdZOFNy?=
 =?utf-8?B?THZvNitvSjlpOGg3MWVoMXI0bDQ4bHBpNkFzVGxLRy9VTkt0RGhiS1Z0S2p5?=
 =?utf-8?B?NzhkRk4xTzN2c3FpbDdPNmNtTi9sOFFUN0l3YjVreXhwdCtXUDZYQUhNSVZD?=
 =?utf-8?B?aDZmL29HMjJRQmpnQWRsZ3FjU3UrcyszdEFBRnZhQUdEc3JDZXhDVEZhb2Ji?=
 =?utf-8?B?THlBdmgrTlhhQjhWRkN2cDRUTVQzM3dGdEIwNHEvOUNIbXVRVVFkeHBmUGtr?=
 =?utf-8?B?NTQ3RkZkNXRlbTdaOElnKzhScTB0ZkFVZkdmOWxPc1JpTGhoTXhXaFU0Qzhq?=
 =?utf-8?B?MEozZ0VGbzhrTlEyMzEvNUFiajAvSVJHdHRjbkk2Rnp1QWRIdUpQeDZJSTRB?=
 =?utf-8?B?Rkh3Z2hBbjVXazYySjdKaHNpWlcrUHFSRmlnRWpjK1pjUG9OanQzQU50UjJY?=
 =?utf-8?B?TkZaU3dpTWJvcEdqbHNScUtoeTkzTHppV0N4ay9oTUlFQlBscHNCdjhQbDZi?=
 =?utf-8?B?WGo0bGsrWGJmMVUyODBqMmIyL0hGYmY1QW0yTFJMRGVoRTNkelE5TldrQVQ1?=
 =?utf-8?B?L1B6RGxSVkJQaXJXVE5FN2kwV3poYWZsa0NRL2N2T3ZBL2Ztc1ptVGF4MGxo?=
 =?utf-8?Q?4Cw1ZS97Cq8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3Rsb3F5TW5yLzUwc1hZdmdRUVZxS05NbWNYeVVKelRIUlpmMmVFY0RHQUp1?=
 =?utf-8?B?TFRYVDVNNS9PaEhuUXRrTExQeFVuSzcxM3I1UDNiM0Izb0xaNlpCWkFyN2xL?=
 =?utf-8?B?SEdtcWVvc2RGWnR2em5DVm1BU3Ayc0xjY0RiMG0yWUZVRnZoWHh6dG00MmM5?=
 =?utf-8?B?Y25TNXljLzVnZy9qb0xHcFFNYWh1WGNmSnMvVzV4TDVwTC9tandycURCSFhW?=
 =?utf-8?B?ZFJaYzFTQWxWQTFMeW1WWDE2Qk83K0xJdVZRTE1LME95QWVaTjJCMDhYOC9m?=
 =?utf-8?B?TjBmaFFxUmRNWjZVd2lscG54bzRPUk1WaURrNFk3cTR4QzBKWkh3bm9DeTFy?=
 =?utf-8?B?cEFmNzA5U0grcFJKckpsb24rWUxtYTJnakpucUt4c1ZoTEQrU0dhSVRaRkRo?=
 =?utf-8?B?QlVyUkRlbUNvems0QU1Vb1pJb1JKaURrb3QrSmtwUmtCU2VucGZoYUppci9C?=
 =?utf-8?B?YVpjZXdNaVRsVjN5bDVXQ3lvdGsxZEo0SVBGK3dlNEZKZWpwWlVXM3JjVXNi?=
 =?utf-8?B?ZVBHazZSMDVvenFKWDQzWEdWWnhxUE1jNjZSVG5WRjBnY3REaEVEWjVkQUFN?=
 =?utf-8?B?TWU2TjJjTHBsNS93QTJXQy82c0gxQ0g1Y0FkWTd0NE9CMk16a0M0azA0bjYz?=
 =?utf-8?B?QjVhTlZUNWNxczRQUlF0VTVkV3FDbXNVeFNORTAzYmlZejNZMlZoSVFYQzF3?=
 =?utf-8?B?T2NMM2VtYVdJRmk0L0VCbVJMSGEzMkt4RXh5S20wOXlQZjNBd2M0VDVydGNE?=
 =?utf-8?B?Ym1qUXh3dkgvZjlTcFhJSkYvL3pWK0ZXSXQ5bGlCdmdzcUJEV3A4dkRBNWox?=
 =?utf-8?B?STAzVWpVMVd0a2FzM09LL1dFMmloUmZONlB6K0hSRExDSy9vNS9EdTZoQXc3?=
 =?utf-8?B?dFZqb2gyWlloSHdqNmIxd3Z6ZlhtMUxqbmxqOHNkNVd3MFZIVnRmZ2RmellV?=
 =?utf-8?B?MkN3Njd3R0R1d3hnWUM2N3o2VHczRVF1WlJ5aHJ2Z2NZQys5SlJsbzhNdnQr?=
 =?utf-8?B?czNiYXJ6d3NmRWp6aEczd1RRYm1QakZRV3B6NUcxcEFZODdhNXp2cTJGeWhY?=
 =?utf-8?B?ZytsZ1N2Z25MOEtoSGt3MGxoRkZ4ZWNOT05sSVMvU2VwczBPRTZxUFVHRmk1?=
 =?utf-8?B?Y3MyczRLb0NnaVhkVElGc20rMmZtMG1XT3VtdEZNRjlac3U0V2RPSUFLQUg5?=
 =?utf-8?B?clVkOEl1bnNxdzBDcGhhNGRQMVphMERTUkppWVpRRXJHc0IzL0tVbGt0TlhO?=
 =?utf-8?B?MTRjQzNTcm12QmRvTW4rYWYvVHgvQnBKSlppbTJIbFFlNGp6K2VqSVI1bGZv?=
 =?utf-8?B?a0daYUtINzFBajE0WlMvWnZrUExucG1OaExqMWJ5Vmx2Zjl0U2tuY240OUJJ?=
 =?utf-8?B?eVl6ZE81YkRSTTlDS0NuWnBkRWtyQ0FxVVliR3pPUWM2K2xRdCs0S1NGVldy?=
 =?utf-8?B?cXpyVmwvTkVYeEY2S1VRRjlONE1HZ0pvNHZYZjM5aFlnSWh5b2draFRuSVZx?=
 =?utf-8?B?UGhsamVtaEllYlVBWWhqeXY0RGl4MXBsVUVQL1hPNnYyWnZnVkxObTR2VmZt?=
 =?utf-8?B?Z1NMYmpUUWJpRTdPaWF3VzVsWG15SFFuMHNTTCtFWW5BR08za3M4TC8yZUp5?=
 =?utf-8?B?YlVoNWlsSTJTbmpsRXZMVEFVVlBFNWJlWDFkNk1iYmhsUWlmZzFqSWQzT1F1?=
 =?utf-8?B?a3d3c2pkc1htWEFMKzJPTXFmV2M0QzBlRHdTenJRMlJnME5ZVXVhNTlOOGdE?=
 =?utf-8?B?TVNBeFVZdVdoTUdKT0hIaFcxQ1BIbGkrNlRMYk1mTUxTckFMUXI5MVhjL2Ro?=
 =?utf-8?B?Mk5GcVd0TXZFaDEzVXNIZHZvbmFlQmUyQmJ3Q2JwTjFGTHNEb3VqQTRpbXNw?=
 =?utf-8?B?T2dOVzB5UnB2bGo5MTNKRUxGYnpydFE0Z2RNb1pmYWI4MExENDZidFpGdGFx?=
 =?utf-8?B?bmNpS1FWQzhncXdCL2h5czhuNWV6V0JWMkJOTlJtZ1paWU1DR0FlL1VmVDJL?=
 =?utf-8?B?ZW83LzUwRitCS0N4VWlIeTRPQUJMNTlIWWlKN3ZUdzFidmdFdmJlUkdPdWtX?=
 =?utf-8?B?NkR6VXZwUk9DOTg1WVp6MndqSURYMmpYZXVYRjl0bzRVMDhWenZ3ZklVRk5m?=
 =?utf-8?B?NDdodmpZeUZJbXFTeXZLZkRaZWlSMEViOURRczc3di9VOTVFN0F2amphWk9J?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66450907436AEF47A76E34F402CDADCC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6483989-b187-4a43-f8a4-08dcb693b891
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 03:47:55.2315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKhu+RSbGxXhkqUPFTz0lTG1j2MjLbn09nFiiVbSBXAXOk6Fz3aHQAAA+dNO7p3V0KwEbzqz5is16w73pv2coC8KcJORaN8t0EEJFYWNTQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048

SGkgUGlldGVyLCANCg0KT24gVHVlLCAyMDI0LTA4LTA2IGF0IDE1OjI1ICswMjAwLCB2dHBpZXRl
ckBnbWFpbC5jb20gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gRnJvbTogUGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vy
bi5jaD4NCj4gDQo+IEdlbmVyYWxpemUgS1NaOTQ3NyBXb0wgZnVuY3Rpb25zIGF0IGtzel9jb21t
b24uIE1vdmUgZGVkaWNhdGVkDQo+IHJlZ2lzdGVycw0KPiBhbmQgZ2VuZXJpYyBtYXNrcyB0byBl
eGlzdGluZyBzdHJ1Y3R1cmVzICYgZGVmaW5lcyBmb3IgdGhhdCBwdXJwb3NlLg0KPiANCj4gSW50
cm9kdWN0aW9uIG9mIFBNRSAocG9ydCkgcmVhZC93cml0ZSBoZWxwZXIgZnVuY3Rpb25zLCB3aGlj
aCBoYXBwZW4NCj4gdG8gYmUgdGhlIGdlbmVyaWMgcmVhZC93cml0ZSBmb3IgS1NaOTQ3NyBidXQg
bm90IGZvciB0aGUgaW5jb21pbmcNCj4gS1NaODd4eCBwYXRjaC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBpZXRlciBWYW4gVHJhcHBlbiA8cGlldGVyLnZhbi50cmFwcGVuQGNlcm4uY2g+DQoNCkFj
a2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQo=

