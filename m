Return-Path: <netdev+bounces-124602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4296A233
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1317289264
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F57718BC1E;
	Tue,  3 Sep 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gBQ6LwoI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1418BBB4;
	Tue,  3 Sep 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376823; cv=fail; b=jJeBy19OVjadNAt2nEI1vAR7PKD3EoOqrqQOOt49svfRvLKbwbPTrpWyHbVM47/sRqAp9HXY7ALV+u8vcU5h3XFNxRHZBK/DiBVCO3SFWo2qupqDHHmWGwHpoBf3rLXv9T2FzeBSvE6Om09VEk0XsHCzQqoZyDjIhq1/UQhsk4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376823; c=relaxed/simple;
	bh=So/Fi3X05MjtD2ltL9RRp8Dt8pYu4cf4O5OXS/epMjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrCg5RjR+PWbMc781J+61xmvz4rPGazotfWX5H0jo+ku+MttM7hm62eD3Cn4EX2Y8MlPB/B6OXj4KllvvQmJS2ycHXmDaoT8QRHRA8wa5biFe7NgvlIrdHp+DSGiU49pqXxYJ/q8WiIvvd6USsxbSpHDOhfmEuUSx5fD/9jdoJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gBQ6LwoI; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBirkFM1tvfyy6Oqc48CNyh/L9W7arDKuEX4o+hBG/ybj3fNFPcRSqdxqcv4FZP63ML5YVhlpSDH4kT23oQTekYJb1UoMyhwwNYUmhCibpvDsj5Bw0He3njtiXjfIXmddj3/uw803dokll6KX23NKCRVI5ZkexKgUp4R1TG/gR7KUUDwl5jHcfDV9yB0hVDF5hSDINY7r/gznf1nCW9gI7Og9txcDYOqB7iXbpE5H2jmiNRTgDe2xHpOdNl7mRUTHC7d+rxCqXu5mLHirtEh3tnq7HPhHEBjOlDYaTj/LWD6Vm2rBUxzRMervVBjq9bxspxGYRx9BDnXh4TVhz8e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So/Fi3X05MjtD2ltL9RRp8Dt8pYu4cf4O5OXS/epMjY=;
 b=wv/WMNwWBnKaIpFyA77kLpMNYc5mg/kE1aJHtwVsk+V9r7YVjISTyjhZTHn198Cu4o3mIOrKi+D/NKJNbIzfdPXtzLx6Koik1o53l4/CP86acAHboSCtqfUHAYdGYtKpjgMnBs7EBpRy9p38EjNlqTTGt5Y/i058qirFp31Qjo4Nro4g1lJz6+/NRyn89fNEfTKqOrECP5ZbhxVJWK6RWxBDW4nm0GOpZISLniBxeAwv82cfv9iTDqMCSGP1x11VchhE5Lu+uLasI3frHxTiPbcUJCsYRYE/0ozMPKdE/Lf7NpCDyf/s0KRh0yxdoJWbtRoOJtCg9uFaplNkb01BiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So/Fi3X05MjtD2ltL9RRp8Dt8pYu4cf4O5OXS/epMjY=;
 b=gBQ6LwoIn3sZxhCiyC/Cm9bpGcLUvTTTrm2vWpjxcX7oHg4j3plZCGASjTNTegHgERV37WZ+MV22xGYkfRs5wPUnVs4n7bBjjXRgAmPrwdnOFEh1bPzp9oQiDdAifb/MHrjtQO9R4oGmv/465vlnRJei+9sLPmTrlb1ofmevfUcThBmeWyUHjfrs3G3Nq8q6t8T8mA/GPaKijBht+kUEU3iwHw94oGJKmeqBdFrHpoU3u/IVf3WVin9L5u0wQYZ9KdDj89uM/yz30hO4OtIZ9RQi+VEMSp4W4gVTPaFmPGRUaPoUbouZwe7fMQTmGMWSuq4H3CKRxzZVkJkCsm9WzA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 15:20:17 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:20:16 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<Tristram.Ha@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Topic: [PATCH net-next v3 3/3] net: dsa: microchip: replace unclear
 KSZ8830 strings
Thread-Index: AQHa/dMeBHUhq3NrfEmGYx13QL5aj7JGLpEA
Date: Tue, 3 Sep 2024 15:20:16 +0000
Message-ID: <03fa382f3469c0fa12d4051e23a7aebfa5c1d456.camel@microchip.com>
References: <20240903072946.344507-1-vtpieter@gmail.com>
	 <20240903072946.344507-4-vtpieter@gmail.com>
In-Reply-To: <20240903072946.344507-4-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|IA1PR11MB8246:EE_
x-ms-office365-filtering-correlation-id: f6c79e88-8902-41d2-afac-08dccc2bea02
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHBOcWpBcXpKcnd0Tnp1QjFNT0dvMkd4NlhmOEpvVzZVSUNZZXE3NHhZSW5M?=
 =?utf-8?B?ZlE4NTVYajJDZWVqck1NS24rV1M2NExyQytnUXBWU0txWkVKeUxUZjJSUjRJ?=
 =?utf-8?B?TWt6V0hMMUdzZFFBZW9zbTU1T0ZibW03MHZZb0JFZ1BnOVcvcFJsWnFQWWJi?=
 =?utf-8?B?UVc2OTRZTVBVQkpPNWoxcVVsQkNzNDEzR2dpNXl5UU5PNEI5N3prR1ZucCtl?=
 =?utf-8?B?cWhram5WTU1aMlhlQ2RaRG9vYXBOSVZOZ0I1ZVIxWHB0V3N0TzlMam5hRFIw?=
 =?utf-8?B?cHhaVGhHYk9BVEhuZFd2NFhWSlB3Q2lMSHpZOGNYeTliS01SV2lDT2tpd1Qz?=
 =?utf-8?B?aU5vbVo0NzF6ZVp6Vi9QZlRFWktHTHNPeklkekd0THpWYnpveW5mTmlPNFp6?=
 =?utf-8?B?dFR0ZDRkOVN0V0VtcWlsdnlSK0ZRUHdBZnVTTmxhV2x2QkxPU0xYTlY2Q2hM?=
 =?utf-8?B?NWhYSGtjQ1dveGoyMW1QbmZWVGdnK3UzOUpzQnBELzd5cHhQZ01EdGo1dW1j?=
 =?utf-8?B?NVZsYVV1amlsblMvRmxwZTl4elRjWjFVS2phWTh1TFJ4R3BYbGlVSVlTYnYr?=
 =?utf-8?B?Wk0xcWNxRDc2THVIMXhRQitvTVRoQ1RpU3owck9iVjFCdUtsZ2xIckhEcVRp?=
 =?utf-8?B?amI4SVZSUlQrNTZoQzUrZkFsaWs0aStocFZ3bm9DUnlqS3B2RFZPQnZXVndt?=
 =?utf-8?B?emxQdHJpL0NTNUxpQTVhMUhRODRsQTV1K2JZeHRLR1ZFSWpPTjhTTmdWSjcz?=
 =?utf-8?B?SXhGejUrcEliNWhtLzY2cnFSR0U4Zm4vbUZkdWEvTTRzS1hhTFpyUGJSdjNu?=
 =?utf-8?B?Q3AvSm5nSmxiNC9zdERrRWlueVExYURSeGRDNTJMNGNsaFlwZktxUzR0Z1Nq?=
 =?utf-8?B?bmZ1U1FLTG1xZGozRWtaY3dENDFjWjBHNTY4Q0IvU1hCcFFHdittRUp0a0Zq?=
 =?utf-8?B?THMxY3AxZEZ2bG5NSTdLUVpIc1pHR0N1bk11b2llT3pBZm9SWXg4Ui9NanNI?=
 =?utf-8?B?YUtybXJlRHQ2NnN5Wmd1ejR4RHZNTzJFV0ZDYzNWM2J2WVFudEJ1WVA5VkZY?=
 =?utf-8?B?a2NITmpKSFY4d1NldzE1R3dpTllvUWUzcDJ2RDc3a0lHTktXYkZyMEtxZzJ2?=
 =?utf-8?B?U3dSeGdvMEgyVVU2ZnRCajRtTFgrbW5IdGVkYzFUNE9GOXkwRzNvSmZIZHFI?=
 =?utf-8?B?ckM3RmpIUlQ3clhmVWR4UjlzazBUREw5UVpzb1FsZHBQdEpsR0liWFJpMFZG?=
 =?utf-8?B?YmtRT3ZyZDlycUVZRDl0ZUxMNTZnL05tMzdSY3p1NXQvQzh0cXFBeFhvOUFS?=
 =?utf-8?B?OEN6MVBCL004c09Cbll3K3A4T0JxZnF1YVlUNC9zNWNSZ2hlaVN3bUNZZ1du?=
 =?utf-8?B?TjljSWVxWmFaTGVkMXdqTnBMbHpDV2k5YlZCZkJwZTJMdzBUc1hOclo0dTdS?=
 =?utf-8?B?VmtjRGVodjMxRXlsNHBMT1I3WmJtektmT1BWZy9jRHk4Z2tQMFM0UDRDYkI3?=
 =?utf-8?B?NXhWRER4WElzYlAxVDM2bFhYek5HdmF6ZTRrSHA0SzZVRWcxdXo4WXk0OTJk?=
 =?utf-8?B?TW85cXgwWGNoVVAzV002Y2hMNkh6bERhMUgxOXlJamlzRlB5YlZDK0F3U0RL?=
 =?utf-8?B?bE9kVWg1MHFPelpsNk0wbklKMlBFS1NyUXpvTnMvMUlQNWZ3LzVEQXQ4T0Q4?=
 =?utf-8?B?bUJyS0s0RDJFcS9kTS9mNzcranRQSHdvbWhrOFdZMnNURFVnbkJXaUpJTTdw?=
 =?utf-8?B?amx3b1ZXOFJ1Y1FkMWpmdTZlT0dFaGhaSXI1cjNQMGRZa0NzdW96Q3ZtTHIw?=
 =?utf-8?B?Y3BCbkdCUTlzcWE2NGd6Z1RBUkZtbUMraDh4Qm9xR2lza2pHcHJjWDZUc0lW?=
 =?utf-8?B?U3owaENmcGJqUzE0bk5UZHhOc25rNExKZjVML2VxR1VaSktkcEdkdXZCZTBm?=
 =?utf-8?Q?UDd3+BZ+lqY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0xaWUpJTlJWN2s4ODBKM3lwSzFaNEFaeFVZR0xhbG5OcUdBcXlncTE4WlhQ?=
 =?utf-8?B?YktDdTZ5dmUzZXhFUmQraGRmMnlCNURMVkVXWm1ZQnRGTDRyM0hKZ1dmMU1B?=
 =?utf-8?B?ZXN1K1BHcmFNSVl1c24xd3EzRzlTOVhUVkdBMnFhODNJVDhPb1JNV3Zvakdx?=
 =?utf-8?B?VDdVOENoem81YWJtYStKSDdhTC9CcEVTcE9NcmFHTVNnZmhwK2s0ZEIwWVBK?=
 =?utf-8?B?b1VjT2l6amNGcldndE1vUkZWMXlrdmNtYVF6NTVVMXdhK2lCVFRyMDVNYUVO?=
 =?utf-8?B?anR1NEs4R0ZSUUIzQks4djl3SUtxUFA0Y2dLdXdQaHMvOG5pSlVocHRsaENk?=
 =?utf-8?B?UDREbjV5SjhHNWpJSXg2Q0tEWHhlWHhLK2pCMk5NckhUdzBWUExZQ0FlUDg1?=
 =?utf-8?B?U3JVSlpSYU5DSis4eXVFbHFkNFZtTGsyMkl3TEdNZnFWVGtEUzNyZkFoUUNL?=
 =?utf-8?B?bE4yTGYzS2ZKWGNEajZkSjdhRXNjK3krOVdIa0lHMTdaS1BKUjZaV0NUbVQw?=
 =?utf-8?B?T2sycHdWY2RzQjRyRitVa2Q3R2tlb0p3c0hKMTRwNFNsUjhQOUVacWVuUkd0?=
 =?utf-8?B?MG9MNHVISXcyemx0bTZJMmZRby85THpiT09iVjJTcEhSeTZNMStkM0dQUk1s?=
 =?utf-8?B?aTJQSDBXamtTN3lhNWJJY0F6MkZSZURDZitPQ2hRckM4NTJmYVdiYlcwNWds?=
 =?utf-8?B?dHBySExlTVVVMmoyb0pzblgvL0dKeGJxS0U1VlZwSm1kQ0FzdDJtL3g5VCt2?=
 =?utf-8?B?KzhFWUp1S1diSGs1N2Frd09maTRPNUZaVmVoZU9salE4UFp0OXFLUzdNc3hw?=
 =?utf-8?B?d3dXbTNIVnNldGdWOEJMZ1RiSnhjRDZlSHArb3Nkd3dBS3RibjJwMkhGNE9v?=
 =?utf-8?B?cUdlWmlib08rRG0ySmdxSFRtcGhaZWp4UCswR1BvdjBVQ3Q1R1hUUXhZN0k2?=
 =?utf-8?B?cXA2M1k1ZlRzWUxqS2Y4V0hwL0x5Z0gyWW1QZzJ2UjBFUGsrVVQzaXNoMmt3?=
 =?utf-8?B?ajJXT1kzYjVPQklxWG9mL2RsM3RLRDhhcEMzNXVmbVdzbjl3MERNSGE1dlo1?=
 =?utf-8?B?ejVpOU4wVXNJQnFZeWlmK3U3Z1kzNERmd3JYN3B1ckRXUWRKeksySUFxb01H?=
 =?utf-8?B?VktIRlVNYk5Ea2NITmlFTTdaYUQzeUl5KzNCaWtyV0Z4aWxWTGNpbFJxdWo2?=
 =?utf-8?B?ZXRXeVpSR2VEWHFvVnhpWXArdWhRWFlhRndTVGJuV0FaMGtKQ3ZnNkN0YllO?=
 =?utf-8?B?WFJvMFlaeUFFSmFiWFl1dTNQOW4vajBCai9McjRvSDVrdTc3N3ZFak9iZFVE?=
 =?utf-8?B?TkJZUE1uSmMvZis4ZlkvcFB3UWg4bHptWWprV09MTXE4ZitITk5yNzBzak8v?=
 =?utf-8?B?UEVoVVJXdjZjUmpRODd0RWhKZlg5UWpaQWZCcCtMSjE3bm9NTGxIQ09taWgy?=
 =?utf-8?B?cUlJZzg3cnMzREcyNllyOFRsbkN4YVdqRGFMV21kOGs1L2ZHT3JROFNUUWtH?=
 =?utf-8?B?S3J4RjNENGpqWmhNWHoySGhmNklNeHVKaG5INnRqbXlqUWJ2SThzaG14RFNG?=
 =?utf-8?B?bE1HNDk2ZFdCU1VlaVpzaEN6OXE1eXpia2lSam1yTmxJUmh2MUFtQU82RDYz?=
 =?utf-8?B?bHZLTEFWMmMyTXJpSEMxeTFadFRiZWlqSHdrY2RxS2xNQW95c2RMVm93QytI?=
 =?utf-8?B?QzZJMWZIa01oWHVaekhzL1liSEVvQ1dCYlBvTEpCYnhZNnk4czFuQ3BScWFZ?=
 =?utf-8?B?V3liT3pIdkJWNUZKU1RPSkczSmNEMFBNZ0ovS2dBQ1VuQngvL3JqS0VpUUNl?=
 =?utf-8?B?dU9CSG9sVXFKOGZ4a08yMngvQjBpS1NqQXVwcXZrWnA2ZE1ZMTVlZ2UzTm5x?=
 =?utf-8?B?MVM0Ym9oQlJKeGhNbmxCU0g4R2tzbE5KWXFKWUJDeVNRU01oRTErVnIxL25C?=
 =?utf-8?B?WkVIVFg5eHFtNGlZckpQVVJjT2svTWZkZjhPdXZsOXlmaFQzZytYeWlmS3Zm?=
 =?utf-8?B?NG5uMHVXSTJOeG5IYzAvSzhKRzA0SXZWY1cxMTBxSnhhaTRBRU5CaVFnOE5T?=
 =?utf-8?B?UStQQXF2Ym0vbnh3TEVzMlNHT2JEWk5mTkpvT2ZEQ3hBVjBodW5yZnpWMjNs?=
 =?utf-8?B?OHo0eWdkdTg2ZjdzbHFWV0txNm9IVnU1ZnBMMytsRDJCdFV0a28vQVNQazZx?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C358230DE3C92B40935A5F09028DDF82@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c79e88-8902-41d2-afac-08dccc2bea02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 15:20:16.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNqHdrqJH2Vvk03Tsf3mT4CGfMKJQtnSbcyuM9s7dHApTuz9a7oJtnYFLO6BlqcrI83l2Q2it5PjqpWba8zWHg6P95l3l9388A2mpjZjQmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246

T24gVHVlLCAyMDI0LTA5LTAzIGF0IDA5OjI5ICswMjAwLCB2dHBpZXRlckBnbWFpbC5jb20gd3Jv
dGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTog
UGlldGVyIFZhbiBUcmFwcGVuIDxwaWV0ZXIudmFuLnRyYXBwZW5AY2Vybi5jaD4NCj4gDQo+IFJl
cGxhY2Uga3N6ODgzMCB3aXRoIGtzejg4eDMgZm9yIENISVBfSUQgZGVmaW5pdGlvbiBhbmQgb3Ro
ZXINCj4gc3RyaW5ncy4gVGhpcyBkdWUgdG8gS1NaODgzMCBub3QgYmVpbmcgYW4gYWN0dWFsIHN3
aXRjaCBidXQgdGhlIENoaXANCj4gSUQgc2hhcmVkIGFtb25nIEtTWjg4NjMvODg3MyBzd2l0Y2hl
cywgaW1wb3NzaWJsZSB0byBkaWZmZXJlbnRpYXRlDQo+IGZyb20gdGhlaXIgQ2hpcCBJRCBvciBS
ZXZpc2lvbiBJRCByZWdpc3RlcnMuDQo+IA0KPiBOb3cgYWxsIEtTWipfQ0hJUF9JRCBtYWNyb3Mg
cmVmZXIgdG8gYWN0dWFsLCBleGlzdGluZyBzd2l0Y2hlcyB3aGljaA0KPiByZW1vdmVzIGNvbmZ1
c2lvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpZXRlciBWYW4gVHJhcHBlbiA8cGlldGVyLnZh
bi50cmFwcGVuQGNlcm4uY2g+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxhcnVuLnJhbWFk
b3NzQG1pY3JvY2hpcC5jb20+DQo=

